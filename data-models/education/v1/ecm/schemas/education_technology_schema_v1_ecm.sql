-- Schema for Domain: technology | Business: Education | Version: v1_ecm
-- Generated on: 2026-05-06 12:28:03

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `education_ecm`.`technology` COMMENT 'Manages institutional IT infrastructure, identity and access management, enterprise application portfolio, network services, cybersecurity incidents, service desk operations, and technology asset lifecycle.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `education_ecm`.`technology`.`it_asset` (
    `it_asset_id` BIGINT COMMENT 'Unique identifier for the IT asset record. Primary key for the IT asset master data.',
    `configuration_item_id` BIGINT COMMENT 'Foreign key linking to technology.configuration_item. Business justification: IT assets (hardware, servers, workstations) are configuration items in ITIL frameworks. The it_asset table tracks every technology asset owned or leased by the institution while configuration_item t',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Capitalized IT equipment exists in both financial fixed asset register and IT inventory. Real business process: monthly reconciliation between systems, depreciation alignment, disposal coordination, a',
    `it_contract_id` BIGINT COMMENT 'Foreign key linking to technology.it_contract. Business justification: IT assets are covered by support, warranty, and maintenance contracts. The support_contract_number STRING should normalize to it_contract_id FK. This links asset management to contract management and ',
    `employee_id` BIGINT COMMENT 'Unique identifier of the faculty, staff, or student to whom the asset is currently assigned for individual use, linking to the institutional identity management system.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to finance.purchase_order. Business justification: IT hardware/software acquisitions flow through procurement system. Real business process: asset acquisition tracking, capital vs expense classification, warranty terms tied to PO, receiving/invoice ma',
    `replaced_it_asset_id` BIGINT COMMENT 'Self-referencing FK on it_asset (replaced_it_asset_id)',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Total cost paid to acquire the asset including purchase price, taxes, shipping, installation, and initial configuration costs. Recorded in USD.',
    `acquisition_date` DATE COMMENT 'Date on which the institution acquired ownership or lease rights to the asset through purchase, donation, or lease agreement.',
    `asset_category` STRING COMMENT 'High-level classification of the asset type distinguishing between hardware, software licenses, network equipment, mobile devices, peripherals, and infrastructure components.. Valid values are `hardware|software|network_equipment|mobile_device|peripheral|infrastructure`',
    `asset_description` STRING COMMENT 'Detailed textual description of the asset including key specifications, configuration details, and distinguishing characteristics.',
    `asset_tag` STRING COMMENT 'Externally visible barcode or RFID tag identifier affixed to the physical asset for inventory tracking and auditing purposes.. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `asset_type` STRING COMMENT 'Detailed classification of the asset within its category (e.g., server, workstation, laptop, tablet, router, switch, printer, software license, SaaS subscription).',
    `assigned_department_code` STRING COMMENT 'Code identifying the academic or administrative department to which the asset is currently assigned for operational use and budgetary responsibility.',
    `building_code` STRING COMMENT 'Code identifying the campus building where the asset is physically located, linking to the institutional facilities management system.',
    `compliance_status` STRING COMMENT 'Current compliance status of the asset with institutional IT security policies, software licensing requirements, and regulatory standards (e.g., FERPA, HIPAA for health center devices).. Valid values are `compliant|non_compliant|pending_review|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset record was first created in the IT asset management system.',
    `current_book_value` DECIMAL(18,2) COMMENT 'Current accounting value of the asset after applying depreciation or amortization, representing the net carrying value on the institutional balance sheet. Recorded in USD.',
    `data_sanitization_method` STRING COMMENT 'Method used to securely erase data from the asset prior to disposal or reassignment (e.g., DoD 5220.22-M wipe, physical destruction, degaussing) to ensure compliance with data privacy regulations.',
    `depreciation_method` STRING COMMENT 'Accounting method used to calculate the periodic depreciation expense for the asset over its useful life (straight-line, declining balance, units of production, or not applicable for non-depreciable assets).. Valid values are `straight_line|declining_balance|units_of_production|not_applicable`',
    `disposal_date` DATE COMMENT 'Date on which the asset was formally disposed of, retired from service, or removed from the institutional inventory.',
    `disposal_method` STRING COMMENT 'Method by which the asset was disposed of at end of life, including recycling, donation to another entity, sale, secure destruction, or return to vendor.. Valid values are `recycled|donated|sold|destroyed|returned_to_vendor`',
    `hostname` STRING COMMENT 'Human-readable network name assigned to the device for DNS resolution and network identification purposes.',
    `insurance_policy_number` STRING COMMENT 'Reference number for the institutional property insurance policy covering the asset against loss, theft, or damage.',
    `ip_address` STRING COMMENT 'IPv4 or IPv6 network address assigned to the asset for network connectivity and device identification on the institutional network.. Valid values are `^(?:[0-9]{1,3}.){3}[0-9]{1,3}$`',
    `last_audit_date` DATE COMMENT 'Date of the most recent physical inventory audit or compliance verification performed on the asset.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset record was most recently updated, reflecting changes to assignment, location, status, or other attributes.',
    `lifecycle_status` STRING COMMENT 'Current state of the asset in its operational lifecycle from acquisition through disposal, indicating whether it is actively deployed, in storage, retired from service, disposed, or reported lost or stolen. [ENUM-REF-CANDIDATE: active|in_storage|deployed|retired|disposed|lost|stolen — 7 candidates stripped; promote to reference product]',
    `mac_address` STRING COMMENT 'Unique hardware identifier assigned to the network interface controller for network communication and device authentication.. Valid values are `^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$`',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured the hardware device or developed the software product.',
    `model_name` STRING COMMENT 'Human-readable marketing or product name for the asset model (e.g., Dell Latitude 7420, Cisco Catalyst 9300, Microsoft Office 365 E3).',
    `model_number` STRING COMMENT 'Manufacturer-assigned model or part number identifying the specific product configuration and specifications.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, special handling instructions, configuration notes, or incident history related to the asset.',
    `operating_system` STRING COMMENT 'Name and version of the operating system software installed on the device (e.g., Windows 11 Enterprise, macOS Ventura 13.2, Ubuntu 22.04 LTS).',
    `ownership_type` STRING COMMENT 'Legal ownership status indicating whether the asset is owned outright by the institution, leased from a vendor, donated by a benefactor, or on loan from another entity.. Valid values are `owned|leased|donated|loaned`',
    `room_number` STRING COMMENT 'Specific room or office number within the building where the asset is physically located for inventory and maintenance purposes.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to identify the specific hardware unit or software license instance.',
    `support_expiration_date` DATE COMMENT 'Date on which the current support or maintenance contract expires, requiring renewal for continued vendor support services.',
    `useful_life_years` STRING COMMENT 'Expected operational lifespan of the asset in years as defined by institutional capital asset policies and used for depreciation calculations.',
    `vendor_name` STRING COMMENT 'Name of the vendor or supplier from whom the asset was purchased or leased.',
    `warranty_expiration_date` DATE COMMENT 'Date on which the manufacturers warranty coverage for the asset expires, after which repairs and support may incur additional costs.',
    CONSTRAINT pk_it_asset PRIMARY KEY(`it_asset_id`)
) COMMENT 'Master record for every technology asset owned or leased by the institution, including hardware (servers, workstations, laptops, mobile devices, networking equipment, printers) and software licenses. Captures asset tag, serial number, model, manufacturer, asset category, acquisition date, acquisition cost, current book value, depreciation method, assigned department, assigned user, physical location (building/room), warranty expiration, support contract reference, lifecycle status (active, retired, disposed, lost/stolen), and disposal method. Serves as the authoritative SSOT for the institutional technology asset inventory and feeds IT asset lifecycle management, capital planning, and insurance reporting.';

CREATE OR REPLACE TABLE `education_ecm`.`technology`.`software_license` (
    `software_license_id` BIGINT COMMENT 'Unique identifier for the software license record. Primary key for the software license entity.',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to technology.enterprise_application. Business justification: Each software license record is for a specific enterprise application. The product_name STRING should normalize to enterprise_application_id FK. This links license management to the application portfo',
    `it_contract_id` BIGINT COMMENT 'Foreign key linking to technology.it_contract. Business justification: Software licenses are governed by vendor contracts (license agreements, enterprise agreements). The contract_number STRING should normalize to it_contract_id FK. This links license management to contr',
    `upgraded_from_software_license_id` BIGINT COMMENT 'Self-referencing FK on software_license (upgraded_from_software_license_id)',
    `annual_cost` DECIMAL(18,2) COMMENT 'The annualized cost of the license in USD, including subscription fees, maintenance, or amortized perpetual license cost. Used for budgeting and cost allocation.',
    `assigned_seat_count` STRING COMMENT 'The number of seats currently assigned or allocated to specific users, departments, or devices.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the license is configured for automatic renewal (true) or requires manual renewal action (false).',
    `available_seat_count` STRING COMMENT 'The number of unassigned seats available for allocation. Calculated as total_seat_count minus assigned_seat_count.',
    `compliance_status` STRING COMMENT 'Assessment of whether current usage aligns with license entitlements: compliant (usage within limits), over_deployed (usage exceeds entitlement), under_utilized (significant unused capacity), audit_required (compliance verification needed), or unknown (status not yet assessed).. Valid values are `compliant|over_deployed|under_utilized|audit_required|unknown`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this license record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deployment_method` STRING COMMENT 'The technical deployment model for the software: cloud SaaS (vendor-hosted), on-premise (institution-hosted), hybrid (combination), virtual desktop infrastructure, or mobile application.. Valid values are `cloud_saas|on_premise|hybrid|virtual_desktop|mobile_app`',
    `is_open_source` BOOLEAN COMMENT 'Boolean flag indicating whether this is an open-source software license (true) or commercial proprietary software (false).',
    `last_compliance_audit_date` DATE COMMENT 'The date of the most recent internal or vendor-initiated license compliance audit or review.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this license record was most recently updated or modified.',
    `last_usage_report_date` DATE COMMENT 'The date of the most recent usage report or metrics collection for this license.',
    `license_expiration_date` DATE COMMENT 'The date when the license expires and usage rights terminate. Null for perpetual licenses without maintenance expiration.',
    `license_key` STRING COMMENT 'The unique license key, activation code, or entitlement identifier provided by the vendor. This is the externally-known unique identifier for this license grant.',
    `license_scope` STRING COMMENT 'The organizational scope or intended user population for the license: institution-wide (all users), department-specific, college-specific, research group, administrative staff only, student-only, or faculty-only. [ENUM-REF-CANDIDATE: institution_wide|department|college|research_group|administrative|student|faculty — 7 candidates stripped; promote to reference product]',
    `license_start_date` DATE COMMENT 'The date when the license becomes effective and usage rights begin.',
    `license_status` STRING COMMENT 'Current lifecycle state of the license: active (in use and compliant), expired (past end date), suspended (temporarily disabled), pending_renewal (approaching expiration), cancelled (terminated early), or non_compliant (usage exceeds entitlement).. Valid values are `active|expired|suspended|pending_renewal|cancelled|non_compliant`',
    `license_type` STRING COMMENT 'The licensing model governing usage rights: perpetual (one-time purchase with indefinite use), subscription (recurring payment for time-bound access), concurrent (floating licenses with simultaneous user limit), named-user (assigned to specific individuals), site license (unlimited use within a location), or enterprise agreement (institution-wide volume licensing).. Valid values are `perpetual|subscription|concurrent|named_user|site_license|enterprise_agreement`',
    `maintenance_expiration_date` DATE COMMENT 'The date when vendor support, updates, and maintenance services expire. Relevant for perpetual licenses with separate maintenance agreements.',
    `modified_by` STRING COMMENT 'The username or identifier of the individual who last modified this license record.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special terms, restrictions, or institutional context related to this license.',
    `open_source_license_type` STRING COMMENT 'For open-source software, the specific license type (e.g., MIT, Apache 2.0, GPL v3, BSD). Null for commercial software.',
    `procurement_reference` STRING COMMENT 'The purchase order number, contract identifier, or procurement system reference associated with the acquisition of this license.',
    `renewal_notice_days` STRING COMMENT 'The number of days before expiration that renewal notification or action is required per contract terms.',
    `renewal_owner` STRING COMMENT 'The name or identifier of the individual or department responsible for managing license renewal and vendor negotiations.',
    `software_category` STRING COMMENT 'The functional classification of the software (e.g., ERP (Enterprise Resource Planning), LMS (Learning Management System), productivity suite, research tools, security software, database management, collaboration platform).',
    `total_contract_value` DECIMAL(18,2) COMMENT 'The total monetary value of the license agreement over its full term, including all payments and fees.',
    `total_seat_count` STRING COMMENT 'The total number of licensed seats, users, or installations permitted under this license agreement. Null for unlimited site licenses.',
    `usage_tracking_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether automated usage tracking and metering is enabled for this license (true) or not (false).',
    `vendor_contact_email` STRING COMMENT 'The primary email address for the vendor account manager or licensing contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `vendor_name` STRING COMMENT 'The name of the software vendor or publisher providing the license (e.g., Microsoft, Oracle, Ellucian, Instructure).',
    `vendor_support_url` STRING COMMENT 'The web URL for vendor technical support, documentation, or customer portal access.',
    `version_number` STRING COMMENT 'The specific version or release number of the licensed software covered by this license.',
    CONSTRAINT pk_software_license PRIMARY KEY(`software_license_id`)
) COMMENT 'Master record for each software license or license pool held by the institution, covering commercial, open-source, and cloud-subscription software. Captures product name, vendor, license type (perpetual, subscription, concurrent, named-user, site license), license key or entitlement ID, total seat count, assigned seat count, available seats, license start and expiration dates, annual cost, renewal owner, compliance status, and associated procurement reference. Enables software asset management (SAM), license compliance audits, and renewal planning. Distinct from it_asset in that it tracks entitlements rather than physical hardware.';

CREATE OR REPLACE TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` (
    `it_asset_lifecycle_event_id` BIGINT COMMENT 'Unique identifier for the IT asset lifecycle event record. Primary key for the immutable event log.',
    `building_id` BIGINT COMMENT 'Reference to the physical location where the asset was situated at the time of this event. Supports chain-of-custody and space management.',
    `change_request_id` BIGINT COMMENT 'Foreign key linking to technology.change_request. Business justification: Major asset lifecycle events (deployments, upgrades, disposals) may require formal change requests. The change_request_number STRING should normalize to change_request_id FK. This links asset manageme',
    `finance_vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier involved in this lifecycle event, such as the procurement source, repair service provider, or disposal contractor.',
    `it_asset_id` BIGINT COMMENT 'Reference to the technology asset that experienced this lifecycle event. Links to the master IT asset record.',
    `org_unit_id` BIGINT COMMENT 'Reference to the department or organizational unit to which the asset was assigned during this event.',
    `employee_id` BIGINT COMMENT 'Reference to the IT staff member who verified that data sanitization was completed successfully. Supports FERPA compliance and audit requirements.',
    `prior_location_building_id` BIGINT COMMENT 'Reference to the physical location where the asset was situated before this event, if the event involved a transfer or reassignment.',
    `quaternary_it_custody_transfer_acknowledged_by_employee_id` BIGINT COMMENT 'Reference to the employee who acknowledged receipt or transfer of custody during this event. Supports dual-signature chain-of-custody requirements.',
    `quinary_it_approved_by_employee_id` BIGINT COMMENT 'Reference to the manager or approver who authorized this lifecycle event, if approval was required. Supports audit trail and accountability.',
    `service_request_id` BIGINT COMMENT 'Foreign key linking to technology.service_request. Business justification: Asset lifecycle events (provisioning, moves, repairs) are often initiated via service desk requests. This FK links asset management to service desk operations, enabling tracking of asset-related servi',
    `tertiary_it_assigned_to_employee_id` BIGINT COMMENT 'Reference to the employee to whom the asset was assigned during this event, if the event type is deployment, assignment, or reassignment.',
    `corrected_it_asset_lifecycle_event_id` BIGINT COMMENT 'Self-referencing FK on it_asset_lifecycle_event (corrected_it_asset_lifecycle_event_id)',
    `approval_status` STRING COMMENT 'The approval status of this lifecycle event, if institutional policy requires managerial or financial approval for the action. Supports governance and control requirements.. Valid values are `approved|pending|rejected|not_required`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this lifecycle event was approved, if approval was required. Supports audit trail and compliance reporting.',
    `building_code` STRING COMMENT 'The code or identifier of the building where the asset was located during this event. Supports facilities management integration.',
    `chain_of_custody_signature` STRING COMMENT 'Digital or physical signature identifier confirming the transfer of custody during this event. Supports property control and accountability requirements.',
    `compliance_certification_number` STRING COMMENT 'The certification or compliance document number associated with this event, if applicable. Supports regulatory and institutional property control requirements.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the event cost amount. Supports multi-currency environments.. Valid values are `USD|CAD|GBP|EUR|AUD`',
    `data_sanitization_certificate_number` STRING COMMENT 'The certificate or report number documenting successful data sanitization. Provides audit trail for data security compliance.',
    `data_sanitization_method` STRING COMMENT 'The method used to sanitize or destroy data on the asset before disposal or reassignment. Supports FERPA and institutional data security policies.. Valid values are `dod_5220_22_m|nist_800_88|physical_destruction|degaussing|secure_erase|not_applicable`',
    `depreciation_impact_flag` BOOLEAN COMMENT 'Indicates whether this lifecycle event triggers a change in the depreciation schedule of the asset. True if the event affects capitalized value or useful life.',
    `disposal_method` STRING COMMENT 'The method used to dispose of the asset, if the event type is disposal. Supports environmental compliance and institutional surplus property policies.. Valid values are `recycled|donated|sold|destroyed|returned_to_vendor`',
    `event_cost_amount` DECIMAL(18,2) COMMENT 'The monetary cost associated with this lifecycle event, such as purchase price, repair cost, or disposal fee. Expressed in the institutional base currency.',
    `event_notes` STRING COMMENT 'Free-text notes or comments recorded by the technician or system administrator about this lifecycle event. Captures contextual details, issues encountered, or special handling instructions.',
    `event_timestamp` TIMESTAMP COMMENT 'The date and time when the lifecycle event occurred in the real world. Represents the business event time, not the system recording time.',
    `event_type` STRING COMMENT 'The type of lifecycle event applied to the asset. Categorizes the nature of the state transition or action performed. [ENUM-REF-CANDIDATE: procurement|receipt|deployment|assignment|reassignment|transfer|upgrade|repair|maintenance|retirement|disposal|lost|stolen — 13 candidates stripped; promote to reference product]',
    `incident_ticket_number` STRING COMMENT 'The incident or service desk ticket number associated with this lifecycle event, if the event was triggered by a reported issue or service request.',
    `invoice_number` STRING COMMENT 'The invoice number associated with this event, if applicable. Supports financial reconciliation and audit trail.',
    `new_status` STRING COMMENT 'The status of the asset after this lifecycle event was applied. Captures the to state in the transition. [ENUM-REF-CANDIDATE: ordered|in_transit|received|available|deployed|in_use|in_repair|in_storage|retired|disposed|lost|stolen — 12 candidates stripped; promote to reference product]',
    `prior_status` STRING COMMENT 'The status of the asset immediately before this lifecycle event was applied. Captures the from state in the transition. [ENUM-REF-CANDIDATE: ordered|in_transit|received|available|deployed|in_use|in_repair|in_storage|retired|disposed|lost|stolen — 12 candidates stripped; promote to reference product]',
    `purchase_order_number` STRING COMMENT 'The purchase order number associated with this event, if the event type is procurement or receipt. Links to financial procurement records.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this event record was first created in the data platform. Represents the system recording time, distinct from the business event time.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this event record was last updated in the data platform. Supports audit trail and data quality monitoring.',
    `repair_description` STRING COMMENT 'Description of the repair performed on the asset, if the event type is repair. Captures details such as parts replaced, issues resolved, or service actions taken.',
    `room_number` STRING COMMENT 'The room number or space identifier where the asset was located during this event. Provides granular location tracking.',
    `source_system` STRING COMMENT 'The name or identifier of the operational system that recorded this lifecycle event. Supports data lineage and integration traceability.',
    `source_system_event_reference` STRING COMMENT 'The unique identifier of this event in the source operational system. Supports reconciliation and cross-system traceability.',
    `upgrade_description` STRING COMMENT 'Description of the upgrade performed on the asset, if the event type is upgrade. Captures details such as hardware component additions, software version updates, or capacity enhancements.',
    `warranty_impact_flag` BOOLEAN COMMENT 'Indicates whether this lifecycle event affects the warranty status of the asset. True if the event voids, extends, or otherwise modifies warranty coverage.',
    `work_order_number` STRING COMMENT 'The work order or service ticket number associated with this lifecycle event, if applicable. Links the event to a formal work request or maintenance activity.',
    CONSTRAINT pk_it_asset_lifecycle_event PRIMARY KEY(`it_asset_lifecycle_event_id`)
) COMMENT 'Immutable transactional record of every lifecycle event applied to a technology asset, including procurement receipt, deployment, reassignment, repair, upgrade, retirement, and disposal. Captures event type, event date, prior status, new status, performed-by technician, associated work order reference, notes, and chain-of-custody details. Provides a complete audit trail for asset history, supports depreciation schedules, and satisfies institutional property control requirements.';

CREATE OR REPLACE TABLE `education_ecm`.`technology`.`network_device` (
    `network_device_id` BIGINT COMMENT 'Unique identifier for the network device. Primary key for this entity.',
    `athletic_facility_id` BIGINT COMMENT 'Foreign key linking to athletics.athletic_facility. Business justification: Network infrastructure (switches, access points, video boards) deployed in athletic facilities for game operations, broadcasting, fan WiFi, and facility management. IT operations track device location',
    `configuration_item_id` BIGINT COMMENT 'Foreign key linking to technology.configuration_item. Business justification: Network devices are configuration items tracked in the institutional CMDB. The configuration_item table is described as tracking every configuration item (CI) tracked in the institutional Configurati',
    `it_contract_id` BIGINT COMMENT 'Foreign key linking to technology.it_contract. Business justification: Network devices are covered by support and maintenance contracts. The support_contract_number STRING should normalize to it_contract_id FK. This links network infrastructure management to contract man',
    `upstream_network_device_id` BIGINT COMMENT 'Self-referencing FK on network_device (upstream_network_device_id)',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original purchase price of the device in US dollars. Used for asset valuation and depreciation calculations.',
    `assigned_to_department` STRING COMMENT 'Academic or administrative department responsible for the network segment served by this device.',
    `building_code` STRING COMMENT 'Code or identifier of the campus building where the device is physically installed.',
    `compliance_status` STRING COMMENT 'Current compliance status against institutional security policies, firmware patch requirements, and configuration standards.. Valid values are `compliant|non_compliant|pending_review|exempt`',
    `configuration_backup_location` STRING COMMENT 'File path or repository location where the devices running configuration is backed up for disaster recovery.',
    `cooling_requirement_btu` DECIMAL(18,2) COMMENT 'Heat dissipation in British Thermal Units per hour. Critical for data center cooling capacity planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this network device record was first created in the IT asset management system.',
    `device_type` STRING COMMENT 'Classification of the network device by its primary function in the campus network infrastructure.. Valid values are `router|switch|wireless_access_point|firewall|load_balancer|vpn_concentrator`',
    `end_of_life_date` DATE COMMENT 'Manufacturer-announced date when the device model will no longer receive software updates, security patches, or technical support.',
    `end_of_support_date` DATE COMMENT 'Date when vendor technical support and hardware replacement services are no longer available for this device model.',
    `firmware_version` STRING COMMENT 'Current version of the operating system or firmware running on the device. Critical for security patch management and compatibility.',
    `floor_number` STRING COMMENT 'Floor level within the building where the device is located (e.g., 1, 2, B1 for basement).',
    `hostname` STRING COMMENT 'Fully qualified domain name or hostname assigned to the network device for identification and DNS resolution within the campus network.',
    `installation_date` DATE COMMENT 'Date when the device was physically installed and commissioned into the production network.',
    `ip_address` STRING COMMENT 'Primary IPv4 or IPv6 address assigned to the device for network communication and management access.',
    `last_configuration_backup_timestamp` TIMESTAMP COMMENT 'Date and time when the devices configuration was last successfully backed up.',
    `last_firmware_update_timestamp` TIMESTAMP COMMENT 'Date and time when the device firmware or operating system was last updated or patched.',
    `last_health_check_timestamp` TIMESTAMP COMMENT 'Date and time when the device last responded successfully to automated health monitoring or ping checks.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this network device record was most recently updated in the IT asset management system.',
    `mac_address` STRING COMMENT 'Hardware address uniquely identifying the network interface at the data link layer. Used for device tracking and network access control.',
    `management_ip_address` STRING COMMENT 'Dedicated IP address used for administrative access and network management protocols (SNMP, SSH, HTTPS).',
    `management_vlan_number` STRING COMMENT 'VLAN identifier used for out-of-band management and administrative access to the device.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured the network device (e.g., Cisco, Juniper, Aruba, Palo Alto Networks).',
    `model_number` STRING COMMENT 'Manufacturer-assigned model number or SKU identifying the specific hardware configuration and capabilities of the device.',
    `network_role` STRING COMMENT 'Functional role of the device within the campus network architecture (core, distribution, access layers per hierarchical design).. Valid values are `core|distribution|access|edge|dmz`',
    `notes` STRING COMMENT 'Free-text field for operational notes, special configurations, known issues, or maintenance history relevant to this device.',
    `operational_status` STRING COMMENT 'Current operational state of the device in the network infrastructure lifecycle.. Valid values are `active|inactive|maintenance|decommissioned|failed|standby`',
    `port_count` STRING COMMENT 'Total number of physical network ports available on the device for connectivity.',
    `power_consumption_watts` DECIMAL(18,2) COMMENT 'Maximum power consumption of the device in watts. Used for capacity planning and energy cost allocation.',
    `power_supply_type` STRING COMMENT 'Type of power supply configuration (AC, DC, Power over Ethernet, redundant) supporting the device.. Valid values are `ac|dc|poe|redundant`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary technical contact for escalations and maintenance coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the IT staff member or network engineer responsible for managing and maintaining this device.',
    `purchase_order_number` STRING COMMENT 'Institutional purchase order number used to procure the device. Links to financial and procurement systems.',
    `rack_location` STRING COMMENT 'Rack identifier and unit position (e.g., Rack-A-U12) for devices mounted in equipment racks.',
    `room_number` STRING COMMENT 'Specific room, telecommunications closet, or data center location identifier where the device is installed.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer for warranty tracking, support contracts, and asset inventory.',
    `snmp_community_string` STRING COMMENT 'Authentication string for SNMP-based monitoring and management. Highly sensitive credential requiring encryption at rest.',
    `support_tier` STRING COMMENT 'Level of vendor support coverage (e.g., 8x5, 24x7, next-business-day replacement) associated with the support contract.. Valid values are `basic|standard|premium|enterprise`',
    `uplink_port` STRING COMMENT 'Physical port identifier used for upstream connectivity to core network or aggregation layer (e.g., GigabitEthernet0/1).',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer warranty coverage expires. Critical for budgeting replacement or extended support contracts.',
    CONSTRAINT pk_network_device PRIMARY KEY(`network_device_id`)
) COMMENT 'Master record for every managed network infrastructure device on campus, including routers, switches, wireless access points, firewalls, load balancers, and VPN concentrators. Captures device hostname, IP address, MAC address, device type, manufacturer, model, firmware version, physical location (building, floor, closet), management VLAN, uplink port, installation date, end-of-life date, support contract, and operational status. Distinct from it_asset in that it carries network-specific attributes (IP, VLAN, topology role) and is managed through network operations tooling (e.g., Cisco DNA Center, SolarWinds).';

CREATE OR REPLACE TABLE `education_ecm`.`technology`.`identity_account` (
    `identity_account_id` BIGINT COMMENT 'Unique identifier for the institutional digital identity account record. Primary key for the identity_account product.',
    `employee_id` BIGINT COMMENT 'The institutional employee identifier for faculty and staff accounts. Sourced from Workday HCM or legacy HR systems. Null for student-only and alumni accounts. Used for payroll integration, benefits administration, and HR reporting.',
    `profile_id` BIGINT COMMENT 'The institutional student identifier for enrolled or former student accounts. Sourced from Ellucian Banner Student Information System (SIS). Null for non-student accounts. Used for academic records, financial aid, and student services integration.',
    `linked_identity_account_id` BIGINT COMMENT 'Self-referencing FK on identity_account (linked_identity_account_id)',
    `access_level` STRING COMMENT 'The overall access privilege tier assigned to this account, determining the scope of systems and data the account holder can access. Basic for limited guest access; standard for typical student/staff access; elevated for accounts requiring access to sensitive data; privileged for IT staff with system administration rights; administrative for accounts with full institutional access.. Valid values are `basic|standard|elevated|privileged|administrative`',
    `account_creation_date` DATE COMMENT 'The date on which this identity account was originally provisioned in the institutional identity management system. This is the official start date of the accounts lifecycle and is used for audit and compliance reporting.',
    `account_deactivation_date` DATE COMMENT 'The date on which this identity account was permanently deactivated or disabled. Null for active accounts. Once deactivated, accounts typically enter a grace period before data is archived or purged according to retention policies.',
    `account_expiration_date` DATE COMMENT 'The date on which this identity account is scheduled to expire and be automatically disabled. Nullable for accounts with indefinite validity (e.g., permanent staff). For students and sponsored accounts, this is typically tied to graduation date or sponsorship end date.',
    `account_locked` BOOLEAN COMMENT 'Indicates whether the account is currently locked due to excessive failed login attempts, security policy violation, or administrative action. True if locked and authentication is blocked; false if unlocked and authentication is permitted. Locked accounts require administrator intervention or automatic unlock after a timeout period.',
    `account_notes` STRING COMMENT 'Free-text field for administrative notes, special instructions, or context about this identity account. May include information about access exceptions, security incidents, or account history. Used by IT support staff and identity administrators.',
    `account_status` STRING COMMENT 'The current lifecycle state of the identity account. Active accounts have full access; suspended accounts are temporarily blocked pending investigation or compliance action; disabled accounts are permanently deactivated; expired accounts have passed their validity period; pending accounts are awaiting provisioning or approval.. Valid values are `active|suspended|disabled|expired|pending`',
    `account_type` STRING COMMENT 'The primary classification of the identity account based on the holders relationship to the institution. Determines access privileges, resource entitlements, and lifecycle policies. Student accounts are for enrolled learners; faculty for instructional staff; staff for administrative and support personnel; alumni for graduates; sponsored for external collaborators; affiliate for contractors and temporary workers.. Valid values are `student|faculty|staff|alumni|sponsored|affiliate`',
    `alternate_email` STRING COMMENT 'A secondary or personal email address provided by the account holder for account recovery, notifications when the primary institutional email is unavailable, or alumni forwarding. Nullable if not provided.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `alumni_status` STRING COMMENT 'The alumni relationship status for accounts associated with graduates. Not_alumni for current students and non-graduates; active_alumni for engaged graduates with current contact information; lapsed_alumni for graduates with outdated contact information or no recent engagement; deceased for graduates who have passed away. Used for alumni services and advancement operations.. Valid values are `not_alumni|active_alumni|lapsed_alumni|deceased`',
    `compliance_training_completed` BOOLEAN COMMENT 'Indicates whether the account holder has completed required institutional compliance training (e.g., FERPA, cybersecurity awareness, Title IX, research ethics). True if all required training is current; false if training is incomplete or expired. May be used to gate access to certain systems or data.',
    `compliance_training_date` DATE COMMENT 'The date on which the account holder most recently completed required institutional compliance training. Null if training has never been completed. Used to track training currency and trigger renewal notifications.',
    `deactivation_reason` STRING COMMENT 'The primary reason why this identity account was deactivated. Graduation for students who completed their program; employment_termination for faculty/staff who left the institution; withdrawal for students who left before completing; expiration for accounts that reached their validity period; security_violation for accounts disabled due to policy breach; request for voluntary account closure.. Valid values are `graduation|employment_termination|withdrawal|expiration|security_violation|request`',
    `department_code` STRING COMMENT 'The organizational department or academic unit to which this account holder is primarily affiliated. For students, this is typically their major department; for faculty and staff, this is their employing department. Used for access control, resource allocation, and organizational reporting.',
    `directory_visible` BOOLEAN COMMENT 'Indicates whether this account and its associated contact information are visible in the institutional directory (LDAP, web directory, email address book). True if the account holder has opted in to directory listing; false if they have opted out for privacy reasons. FERPA-protected students may default to false.',
    `display_name` STRING COMMENT 'The full human-readable name of the account holder as it appears in institutional directories, email clients, and user interfaces. Typically formatted as FirstName LastName or LastName, FirstName.',
    `failed_login_attempts` STRING COMMENT 'The cumulative count of consecutive failed authentication attempts since the last successful login. Reset to zero upon successful authentication. Used to trigger account lockout when the threshold is exceeded and to detect potential brute-force attacks.',
    `ferpa_protected` BOOLEAN COMMENT 'Indicates whether this account is subject to enhanced privacy protections under FERPA. True for student accounts where the student has requested directory information suppression; false otherwise. FERPA-protected accounts have restricted visibility in directories and reports.',
    `graduation_year` STRING COMMENT 'The year in which the account holder graduated or is expected to graduate from the institution. Null for non-student accounts or students who have not yet declared an expected graduation date. Used for alumni segmentation, reunion planning, and lifecycle transitions.',
    `last_login_timestamp` TIMESTAMP COMMENT 'The most recent date and time the account holder successfully authenticated to any institutional system via single sign-on (SSO). Used for dormant account detection, security monitoring, and user engagement analytics. Null if the account has never been used.',
    `last_modified_by` STRING COMMENT 'The NetID or system identifier of the user or automated process that last modified this identity account record. Used for audit trails and accountability in identity lifecycle management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when any attribute of this identity account record was last updated. Used for change tracking, audit trails, and synchronization with downstream systems.',
    `last_password_change_date` DATE COMMENT 'The date on which the account password was most recently changed by the user or reset by an administrator. Used to enforce password rotation policies and identify accounts with stale credentials.',
    `legal_name` STRING COMMENT 'The full legal name of the account holder as it appears on official government-issued identification documents. May differ from display_name if the account holder uses a preferred name. Used for official records, financial aid, payroll, and compliance reporting.',
    `lockout_timestamp` TIMESTAMP COMMENT 'The date and time when the account was most recently locked. Null if the account has never been locked or if the most recent lock has been cleared. Used for security incident investigation and automatic unlock scheduling.',
    `mfa_enrolled` BOOLEAN COMMENT 'Indicates whether the account holder has enrolled in multi-factor authentication (MFA). True if at least one MFA method (authenticator app, SMS, hardware token) is registered; false otherwise. MFA enrollment may be required for certain account types or access levels.',
    `mfa_method` STRING COMMENT 'The primary multi-factor authentication method registered for this account. Authenticator app includes TOTP-based apps like Google Authenticator or Duo; SMS sends one-time codes via text message; hardware token includes YubiKey or RSA SecurID; biometric includes fingerprint or facial recognition; backup codes are single-use recovery codes.. Valid values are `none|authenticator_app|sms|hardware_token|biometric|backup_codes`',
    `netid` STRING COMMENT 'The unique institutional username or network identifier assigned to the user. This is the primary login credential used across all institutional systems and serves as the canonical identifier for single sign-on (SSO) and directory services.. Valid values are `^[a-z][a-z0-9]{2,15}$`',
    `password_policy_group` STRING COMMENT 'The password complexity and rotation policy tier assigned to this account. Standard applies to most users; elevated for accounts with access to sensitive data; administrative for IT staff and system administrators; service for application service accounts with extended validity periods.. Valid values are `standard|elevated|administrative|service`',
    `password_reset_required` BOOLEAN COMMENT 'Indicates whether the account holder must reset their password at next login. True when an administrator forces a password reset due to security incident, policy violation, or initial provisioning; false for normal operation.',
    `phone_number` STRING COMMENT 'The primary contact phone number for the account holder. Used for SMS-based multi-factor authentication, account recovery, and emergency notifications. Should be in E.164 international format when possible.. Valid values are `^+?[1-9]d{1,14}$`',
    `preferred_name` STRING COMMENT 'The name the account holder prefers to be called in non-official contexts, such as class rosters, email signatures, and informal communications. Nullable if the account holder has not specified a preferred name different from their legal name. Supports inclusive practices for transgender and non-binary individuals.',
    `primary_email` STRING COMMENT 'The primary institutional email address associated with this identity account. This is the official communication channel for institutional correspondence and serves as the primary contact method for password resets and account notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `pronouns` STRING COMMENT 'The personal pronouns the account holder uses (e.g., she/her, he/him, they/them, ze/zir). Nullable if not provided. Used to support inclusive communication and respect for gender identity. May be displayed in directory listings and email signatures.',
    `source_system` STRING COMMENT 'The authoritative system of record from which this identity account was originally provisioned or synchronized. Banner for student accounts sourced from the Student Information System (SIS); Workday for employee accounts from Human Capital Management (HCM); manual for accounts created directly in the identity management system; LDAP for legacy directory imports; SAML federation for federated external identities.. Valid values are `banner|workday|manual|ldap|saml_federation`',
    `source_system_code` STRING COMMENT 'The unique identifier for this person in the source system of record. For Banner-sourced accounts, this is the Banner PIDM or student ID; for Workday-sourced accounts, this is the Workday Employee ID. Used for reconciliation and synchronization between the identity system and upstream systems.',
    `sponsor_netid` STRING COMMENT 'For sponsored guest accounts, the NetID of the institutional faculty or staff member who is responsible for this account and has authorized its creation. Null for non-sponsored accounts. The sponsor is accountable for the guests access and must renew or terminate the sponsorship.. Valid values are `^[a-z][a-z0-9]{2,15}$`',
    `sponsorship_end_date` DATE COMMENT 'For sponsored guest accounts, the date on which the sponsorship expires and the account should be deactivated. Null for non-sponsored accounts. Sponsored accounts are typically created for external collaborators, visiting researchers, or contractors and require a faculty or staff sponsor.',
    `sso_enabled` BOOLEAN COMMENT 'Indicates whether this account is enabled for single sign-on (SSO) across institutional applications. True if the account can authenticate via the central identity provider (Shibboleth, SAML, CAS); false if SSO is disabled and direct authentication is required.',
    CONSTRAINT pk_identity_account PRIMARY KEY(`identity_account_id`)
) COMMENT 'Master record for every institutional digital identity and associated system account provisioned for students, faculty, staff, alumni, and sponsored guests. Captures NetID/username, display name, primary email address, account type (student, faculty, staff, sponsored), account status (active, suspended, disabled, expired), password policy group, multi-factor authentication (MFA) enrollment status, account creation date, last login timestamp, account expiration date, and source identity system (Banner, Workday, manual). Serves as the SSOT for identity and access management (IAM) and feeds single sign-on (SSO), directory services (Active Directory/LDAP), and provisioning workflows.';

CREATE OR REPLACE TABLE `education_ecm`.`technology`.`access_entitlement` (
    `access_entitlement_id` BIGINT COMMENT 'Unique identifier for the access entitlement record. Primary key for the access entitlement entity.',
    `approval_workflow_id` BIGINT COMMENT 'Foreign key reference to the approval workflow process that must be completed before this entitlement can be granted. Null if no approval is required.',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key reference to the application or system record in the enterprise application portfolio that this entitlement controls access to.',
    `org_unit_id` BIGINT COMMENT 'Foreign key reference to the organizational unit or department that owns this entitlement and is accountable for access reviews and certification.',
    `parent_access_entitlement_id` BIGINT COMMENT 'Self-referencing FK on access_entitlement (parent_access_entitlement_id)',
    `access_entitlement_description` STRING COMMENT 'Detailed description of what access rights, capabilities, and responsibilities this entitlement grants. Used to help requesters and approvers understand the scope and purpose of the entitlement.',
    `access_entitlement_status` STRING COMMENT 'Current lifecycle status of the entitlement. Active entitlements can be granted; Inactive entitlements are disabled but retained for historical reference; Deprecated entitlements are being phased out; Pending Review entitlements await certification; Suspended entitlements are temporarily disabled due to security concerns.. Valid values are `active|inactive|deprecated|pending_review|suspended`',
    `access_level` STRING COMMENT 'The level or scope of access granted by this entitlement. Read allows viewing data; Write allows creating and updating; Admin allows configuration and user management; Execute allows running processes; Full Control allows all operations including deletion and permission changes. [ENUM-REF-CANDIDATE: read|write|admin|execute|full_control|modify|contribute|view_only — 8 candidates stripped; promote to reference product]',
    `active_assignment_count` STRING COMMENT 'Current number of identities that have been granted this entitlement and have active assignments. Used for license management and access analytics.',
    `allows_bulk_operations` BOOLEAN COMMENT 'Indicates whether this entitlement permits bulk data operations such as mass updates, batch exports, or bulk deletions. Bulk operation capabilities increase risk and require additional oversight.',
    `allows_data_export` BOOLEAN COMMENT 'Indicates whether this entitlement permits exporting or downloading data from the target system. Export capabilities require data loss prevention monitoring.',
    `auto_revoke_on_expiry` BOOLEAN COMMENT 'Indicates whether the entitlement should be automatically revoked when the grant duration expires (True) or requires manual review (False).',
    `business_justification` STRING COMMENT 'Business rationale for why this entitlement exists and what job functions or roles require it. Used during access reviews to validate continued need.',
    `business_owner_email` STRING COMMENT 'Email address of the business owner for this entitlement, used for access request notifications and certification campaigns.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `business_owner_name` STRING COMMENT 'Full name of the individual who serves as the business owner for this entitlement, responsible for approving access requests and conducting periodic access reviews.',
    `certification_frequency_days` STRING COMMENT 'Number of days between required access certification reviews for this entitlement. Common values are 90, 180, or 365 days. Used to schedule periodic access reviews and attestation campaigns.',
    `compliance_framework` STRING COMMENT 'Regulatory or compliance framework that governs this entitlement. Examples include FERPA (Family Educational Rights and Privacy Act), HIPAA (for university health centers), PCI-DSS (for payment systems), FISMA (for federally funded research), GLBA (for financial aid), SOX (for financial systems).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this entitlement record was first created in the identity and access management system.',
    `data_classification_level` STRING COMMENT 'Highest level of data classification that this entitlement grants access to. Restricted includes FERPA-protected student records, PHI, PCI data; Confidential includes internal business data; Internal includes operational data; Public includes publicly available information.. Valid values are `public|internal|confidential|restricted`',
    `effective_end_date` DATE COMMENT 'Date when this entitlement definition will be or was retired and no longer available for new assignments. Null indicates no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this entitlement definition became active and available for assignment to identities.',
    `entitlement_category` STRING COMMENT 'High-level classification of the type of resource or capability this entitlement controls. Application Access covers enterprise applications; Network Access covers VPN and network segments; Data Access covers databases and file systems; Physical Access covers building and room entry; Privileged Access covers administrative and elevated rights; Shared Resource covers collaborative spaces and drives.. Valid values are `application_access|network_access|data_access|physical_access|privileged_access|shared_resource`',
    `entitlement_code` STRING COMMENT 'Business identifier code for the entitlement, used for external reference and integration with identity management systems. Typically follows organizational naming conventions for role and permission identifiers.. Valid values are `^[A-Z0-9_-]{3,50}$`',
    `entitlement_name` STRING COMMENT 'Human-readable name of the access entitlement, describing the role, permission set, or access right being granted. Examples include Faculty Portal Admin, Student Records Read-Only, Financial Aid Counselor, Research Grant Manager.',
    `entitlement_type` STRING COMMENT 'Classification of the entitlement mechanism. Role represents a collection of permissions assigned as a unit; Group represents membership-based access; Permission represents a specific action right; Privilege represents elevated access; Profile represents a configuration template.. Valid values are `role|group|permission|privilege|profile`',
    `ferpa_protected` BOOLEAN COMMENT 'Indicates whether this entitlement grants access to FERPA-protected student education records. True requires additional compliance controls and audit logging per federal regulations.',
    `is_privileged` BOOLEAN COMMENT 'Indicates whether this entitlement grants privileged or administrative access that allows modification of system configurations, security settings, or access to sensitive data. Privileged entitlements require enhanced monitoring and stricter controls.',
    `is_sod_restricted` BOOLEAN COMMENT 'Indicates whether this entitlement is subject to segregation of duties controls and cannot be granted in combination with certain other entitlements to prevent fraud or conflicts of interest.',
    `last_certification_date` DATE COMMENT 'Date when this entitlement was last reviewed and certified by the business owner as still required and appropriately scoped.',
    `maximum_grant_duration_days` STRING COMMENT 'Maximum number of days this entitlement can be granted to an identity before it must be reviewed or renewed. Null indicates no time limit. Used to enforce time-bound access for temporary roles, contractors, and high-risk entitlements.',
    `mfa_required` BOOLEAN COMMENT 'Indicates whether multi-factor authentication is required to exercise this entitlement. True for high-risk and privileged entitlements per institutional security policy.',
    `modified_by` STRING COMMENT 'Username or identifier of the administrator who last modified this entitlement definition.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this entitlement record was last modified or updated.',
    `network_zone` STRING COMMENT 'Network access zone from which this entitlement can be exercised. Campus restricts to on-campus network; VPN requires VPN connection; Remote allows any authenticated connection; Partner allows access from partner institutions; Public allows internet access.. Valid values are `campus|vpn|remote|partner|public`',
    `next_certification_date` DATE COMMENT 'Scheduled date for the next access certification review of this entitlement. Calculated based on last certification date plus certification frequency.',
    `owner_department` STRING COMMENT 'Name of the academic or administrative department that owns and is responsible for this entitlement. Examples include Information Technology Services, Office of the Registrar, Financial Aid Office, Human Resources, Research Administration.',
    `requires_approval` BOOLEAN COMMENT 'Indicates whether granting this entitlement to an identity requires formal approval workflow. True for sensitive or privileged entitlements; False for standard self-service entitlements.',
    `risk_level` STRING COMMENT 'Risk classification of the entitlement based on the sensitivity of data and operations it grants access to. Critical entitlements require highest scrutiny and approval; High entitlements access sensitive data (FERPA, financial); Medium entitlements access internal operational data; Low entitlements access public or non-sensitive resources.. Valid values are `low|medium|high|critical`',
    `sod_conflict_group` STRING COMMENT 'Identifier for the SOD conflict group this entitlement belongs to. Entitlements in the same conflict group cannot be granted to the same identity simultaneously. Examples include FINANCE_APPROVE_PAY, STUDENT_RECORDS_MODIFY_GRADE.',
    `target_system` STRING COMMENT 'Name or identifier of the application, system, or platform to which this entitlement grants access. Examples include Banner SIS, Canvas LMS, Workday HCM, Active Directory, Oracle Financials, Slate CRM, VPN Gateway, Shared Drive Infrastructure.',
    `technical_owner_name` STRING COMMENT 'Full name of the IT staff member or system administrator who serves as the technical owner for this entitlement, responsible for provisioning and de-provisioning access.',
    `usage_guidelines` STRING COMMENT 'Instructions and guidelines for appropriate use of this entitlement, including acceptable use policies, restrictions, and responsibilities of users who are granted this access.',
    `created_by` STRING COMMENT 'Username or identifier of the administrator who created this entitlement definition.',
    CONSTRAINT pk_access_entitlement PRIMARY KEY(`access_entitlement_id`)
) COMMENT 'Master record defining a specific access right, role, or permission set that can be granted to an identity account, covering application roles, network access groups, shared drive permissions, VPN profiles, and privileged access levels. Captures entitlement name, entitlement type (role, group, permission), target system or application, access level (read, write, admin), approval workflow required flag, maximum grant duration, and owner department. Enables role-based access control (RBAC) governance, access certification campaigns, and least-privilege enforcement.';

CREATE OR REPLACE TABLE `education_ecm`.`technology`.`access_provisioning_event` (
    `access_provisioning_event_id` BIGINT COMMENT 'Unique identifier for the access provisioning event. Primary key for this transactional record of access grant, modification, or revocation.',
    `access_certification_id` BIGINT COMMENT 'Reference to the access certification campaign that resulted in this provisioning event (for revocations or modifications identified during periodic access reviews).',
    `access_entitlement_id` BIGINT COMMENT 'Reference to the specific entitlement (role, permission, group membership, or access right) being granted, modified, or revoked in this event.',
    `enterprise_application_id` BIGINT COMMENT 'Reference to the enterprise application or system where the access was provisioned (e.g., Banner, Workday, Canvas, Active Directory).',
    `employee_id` BIGINT COMMENT 'Reference to the identity (person or system) who requested this access provisioning. Null for automated system-initiated events.',
    `identity_account_id` BIGINT COMMENT 'Reference to the identity account (user, service account, or system account) that is the target of this provisioning action.',
    `service_request_id` BIGINT COMMENT 'Reference to the originating access request that triggered this provisioning event. Null for automated joiner-mover-leaver events.',
    `quaternary_access_sod_exception_approved_by_employee_id` BIGINT COMMENT 'Reference to the senior manager or compliance officer who approved the segregation of duties exception. Required when sod_conflict_detected is true.',
    `target_system_account_identity_account_id` BIGINT COMMENT 'The native account identifier in the target system where the entitlement was provisioned (e.g., Active Directory SamAccountName, Banner PIDM, Workday User ID).',
    `tertiary_access_executed_by_employee_id` BIGINT COMMENT 'Reference to the identity (IAM administrator or automated service account) that executed the provisioning action in the target system.',
    `reversal_access_provisioning_event_id` BIGINT COMMENT 'Self-referencing FK on access_provisioning_event (reversal_access_provisioning_event_id)',
    `action_type` STRING COMMENT 'Type of provisioning action performed: grant (new access), modify (change existing access), revoke (remove access), suspend (temporary disable), restore (re-enable), or extend (renew expiration).. Valid values are `grant|modify|revoke|suspend|restore|extend`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the provisioning request was approved by the authorizing party. Required for manual requests; null for automated events.',
    `audit_log_reference` STRING COMMENT 'Reference to the detailed audit log entry in the target system for this provisioning event. Enables cross-system audit trail correlation.',
    `business_justification` STRING COMMENT 'Free-text explanation of the business need for this access grant or modification. Required for manual requests and high-risk entitlements per SOX and institutional security policy.',
    `compliance_framework` STRING COMMENT 'Primary regulatory or policy framework governing this access provisioning event (FERPA for student data, SOX for financial systems, HIPAA for health records, institutional policy for general access). [ENUM-REF-CANDIDATE: ferpa|sox|hipaa|pci_dss|fisma|gdpr|ccpa|institutional_policy — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this provisioning event record was first created in the IAM system. Used for audit trail and data lineage.',
    `effective_date` DATE COMMENT 'Date when the granted or modified access becomes active and usable by the identity. May be future-dated for scheduled access grants.',
    `emergency_access_flag` BOOLEAN COMMENT 'Indicates whether this was an emergency access grant bypassing normal approval workflows. Requires post-facto review and justification per institutional security policy.',
    `emergency_justification` STRING COMMENT 'Detailed explanation for emergency access grant, including incident reference and business impact. Required when emergency_access_flag is true.',
    `error_code` STRING COMMENT 'System error code returned by the target system if provisioning failed. Used for troubleshooting and root cause analysis.',
    `error_message` STRING COMMENT 'Detailed error message returned by the target system if provisioning failed. Used for troubleshooting and root cause analysis.',
    `event_number` STRING COMMENT 'Human-readable business identifier for this provisioning event, used in audit logs and compliance reports.. Valid values are `^APE-[0-9]{10}$`',
    `execution_timestamp` TIMESTAMP COMMENT 'Date and time when the provisioning action was executed in the target system. This is the principal business event timestamp for this transaction.',
    `expiration_date` DATE COMMENT 'Date when the granted access automatically expires and is revoked. Null for permanent access grants. Required for temporary access and guest accounts per FERPA and institutional policy.',
    `ip_address` STRING COMMENT 'IP address from which the provisioning request originated. Used for security monitoring and forensic analysis.. Valid values are `^(?:[0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$`',
    `new_entitlement_value` DECIMAL(18,2) COMMENT 'For grant and modify actions, captures the new state of the entitlement after the change. Enables audit trail of access changes.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about this provisioning event, entered by administrators or approvers.',
    `previous_entitlement_value` DECIMAL(18,2) COMMENT 'For modify actions, captures the previous state of the entitlement before the change. Enables audit trail of access changes.',
    `provisioning_duration_seconds` STRING COMMENT 'Time elapsed in seconds between provisioning initiation and completion. Used for SLA monitoring and performance analysis of IAM automation.',
    `provisioning_method` STRING COMMENT 'Method by which this provisioning event was triggered: automated joiner-mover-leaver workflow, manual access request, periodic access review, emergency grant, or bulk import. [ENUM-REF-CANDIDATE: automated_joiner|automated_mover|automated_leaver|manual_request|access_review|emergency_grant|bulk_import — 7 candidates stripped; promote to reference product]',
    `provisioning_status` STRING COMMENT 'Current status of the provisioning workflow: pending (awaiting execution), in_progress (being applied), completed (successfully applied), failed (error occurred), or rolled_back (reverted due to failure).. Valid values are `pending|in_progress|completed|failed|rolled_back`',
    `request_timestamp` TIMESTAMP COMMENT 'Date and time when the access provisioning was requested. Null for automated system-initiated events.',
    `retry_count` STRING COMMENT 'Number of times the provisioning action was retried after initial failure. Used for reliability monitoring of IAM automation.',
    `revocation_reason` STRING COMMENT 'Reason for access revocation: employee/student termination, role change, access review finding, security incident response, policy violation, no longer needed, or system decommission. [ENUM-REF-CANDIDATE: termination|role_change|access_review|security_incident|policy_violation|no_longer_needed|system_decommission — 7 candidates stripped; promote to reference product]',
    `risk_level` STRING COMMENT 'Risk classification of the entitlement being provisioned, based on data sensitivity and privilege level. High and critical access requires additional approval workflows.. Valid values are `low|medium|high|critical`',
    `segregation_of_duties_check` BOOLEAN COMMENT 'Indicates whether a segregation of duties conflict check was performed before granting this access. Required for financial system access per SOX.',
    `session_reference` STRING COMMENT 'Unique session identifier for the provisioning request. Enables correlation of multiple provisioning events within a single user session.',
    `sod_conflict_detected` BOOLEAN COMMENT 'Indicates whether a segregation of duties conflict was detected during the provisioning workflow. True requires exception approval from senior management.',
    `trigger_source` STRING COMMENT 'Source event or system that triggered this provisioning action: HR event (hire, termination, transfer), student enrollment, manual request, access certification review, role change, policy update, or security incident response. [ENUM-REF-CANDIDATE: hr_event|student_enrollment|manual_request|access_certification|role_change|policy_update|security_incident — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this provisioning event record was last modified in the IAM system. Used for audit trail and data lineage.',
    `user_agent` STRING COMMENT 'Browser or client application user agent string for the provisioning request. Used for security monitoring and user experience analysis.',
    CONSTRAINT pk_access_provisioning_event PRIMARY KEY(`access_provisioning_event_id`)
) COMMENT 'Transactional record of every access grant, modification, or revocation applied to an identity account for a specific entitlement. Captures provisioning action type (grant, modify, revoke), target identity account, entitlement granted or revoked, requesting party, approving party, approval timestamp, effective date, expiration date, provisioning method (automated joiner-mover-leaver, manual request, access review), and source trigger (HR event, student enrollment, manual request). Provides the authoritative audit trail for access provisioning required by SOX, FERPA, and institutional security policy.';

CREATE OR REPLACE TABLE `education_ecm`.`technology`.`service_request` (
    `service_request_id` BIGINT COMMENT 'Unique identifier for the IT service desk request. Primary key for the service request entity.',
    `incident_id` BIGINT COMMENT 'Identifier of a related incident ticket if this service request is linked to a broader system outage or known issue. Enables correlation analysis and root cause investigation.',
    `it_asset_id` BIGINT COMMENT 'Identifier of the IT asset (hardware device, software license, network equipment) associated with the service request. Links to the institutional Configuration Management Database (CMDB).',
    `it_service_id` BIGINT COMMENT 'Foreign key linking to technology.it_service. Business justification: Service requests are submitted for specific IT catalog services. This FK links service desk operations to the service catalog, enabling request volume analysis per service and service portfolio manage',
    `knowledge_article_id` BIGINT COMMENT 'Identifier of the knowledge base article used to resolve the service request or created as a result of this request. Supports knowledge management and self-service capabilities.',
    `employee_id` BIGINT COMMENT 'Identifier of the person who submitted the service request. May be a student, faculty member, or staff member. Links to the institutional identity management system.',
    `tertiary_service_assigned_technician_employee_id` BIGINT COMMENT 'Identifier of the IT support technician currently assigned to resolve the service request. Links to the HR or staff directory system.',
    `parent_service_request_id` BIGINT COMMENT 'Self-referencing FK on service_request (parent_service_request_id)',
    `acknowledged_timestamp` TIMESTAMP COMMENT 'Date and time when the service request was first acknowledged by a technician or automatically by the system. Used to measure initial response time against SLA targets.',
    `actual_effort_hours` DECIMAL(18,2) COMMENT 'Actual number of labor hours spent resolving the service request, as logged by the assigned technician. Used for performance analysis, cost tracking, and process improvement.',
    `assigned_team` STRING COMMENT 'Name of the IT support team or functional group responsible for resolving the request (e.g., Desktop Support, Network Operations, Application Support, Identity Management, Classroom Technology Services).',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the service request was formally closed after requester confirmation or auto-closure. Marks the end of the request lifecycle.',
    `cost_center` STRING COMMENT 'Financial cost center to which any service charges or labor costs should be allocated. Used for chargeback models and budget tracking.',
    `customer_feedback` STRING COMMENT 'Free-text comments provided by the requester in the post-resolution satisfaction survey. Captures qualitative feedback on service quality, technician performance, or process improvements.',
    `customer_satisfaction_score` STRING COMMENT 'Numerical rating provided by the requester indicating satisfaction with the service received, typically on a scale of 1-5 or 1-10. Collected via post-resolution survey.',
    `department_code` STRING COMMENT 'Code identifying the academic or administrative department of the requester or affected user. Used for cost allocation, reporting, and service usage analysis.',
    `escalated_flag` BOOLEAN COMMENT 'Indicates whether the service request has been escalated beyond the initial assigned team or technician due to complexity, SLA breach risk, or requester dissatisfaction.',
    `escalation_level` STRING COMMENT 'Number of times the service request has been escalated to higher support tiers or management. Zero indicates no escalation; higher numbers indicate increased severity or complexity.',
    `estimated_effort_hours` DECIMAL(18,2) COMMENT 'Estimated number of labor hours required to resolve the service request, as assessed by the assigned technician or team lead. Used for resource planning and capacity management.',
    `first_response_timestamp` TIMESTAMP COMMENT 'Date and time when the first substantive communication was sent to the requester by the assigned technician. Key metric for measuring service desk responsiveness.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the service request record, including status changes, reassignments, or note additions.',
    `location_code` STRING COMMENT 'Code identifying the physical location where the service is needed or where the affected asset is located (building code, room number, campus identifier). Used for on-site support dispatch.',
    `opened_timestamp` TIMESTAMP COMMENT 'Date and time when the service request was first submitted and entered into the ITSM system. Serves as the start point for SLA calculations.',
    `priority_level` STRING COMMENT 'Business priority assigned to the service request based on impact and urgency. Critical: system-wide outage affecting instruction or operations; High: significant impact on multiple users; Medium: moderate impact or single user; Low: minor issue or enhancement request.. Valid values are `critical|high|medium|low`',
    `reopened_count` STRING COMMENT 'Number of times the service request has been reopened after initial resolution due to incomplete resolution or recurring issues. Indicates quality of resolution and potential systemic problems.',
    `request_category` STRING COMMENT 'High-level classification of the service request type: hardware (device issues, repairs), software (application support, licensing), access (permissions, provisioning), network (connectivity, Wi-Fi), account (password reset, account creation), classroom technology (AV equipment, projectors, lecture capture), or security (phishing, malware, data breach). [ENUM-REF-CANDIDATE: hardware|software|access|network|account|classroom_tech|security — 7 candidates stripped; promote to reference product]',
    `request_subcategory` STRING COMMENT 'Detailed classification within the request category (e.g., laptop repair, password reset, VPN access, printer issue, Canvas LMS support, Banner access request). Enables granular reporting and routing.',
    `requester_email` STRING COMMENT 'Primary email address of the person who submitted the service request. Used for status updates and resolution notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `requester_phone` STRING COMMENT 'Contact phone number of the requester for follow-up communication or clarification.',
    `requester_type` STRING COMMENT 'Classification of the requesters affiliation with the institution: student, faculty, staff, contractor, or guest. Determines service level agreements and support entitlements.. Valid values are `student|faculty|staff|contractor|guest`',
    `resolution_code` STRING COMMENT 'Standardized code categorizing how the request was resolved (e.g., password_reset, hardware_replaced, access_granted, configuration_changed, user_error, duplicate_request). Enables trend analysis and knowledge management.',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the actions taken to resolve the service request, including troubleshooting steps, configuration changes, or solutions provided. Used for knowledge base and future reference.',
    `resolved_timestamp` TIMESTAMP COMMENT 'Date and time when the service request was marked as resolved by the assigned technician. Represents when the solution was provided to the requester.',
    `service_request_description` STRING COMMENT 'Detailed description of the issue, need, or request provided by the requester. May include error messages, steps to reproduce, or specific requirements.',
    `service_request_status` STRING COMMENT 'Current lifecycle status of the service request. Open: newly submitted; In Progress: actively being worked; Pending: awaiting information or external dependency; Resolved: solution provided, awaiting confirmation; Closed: confirmed resolved and archived; Cancelled: request withdrawn or invalid.. Valid values are `open|in_progress|pending|resolved|closed|cancelled`',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the service request resolution exceeded the committed SLA response or resolution time. Used for performance reporting and process improvement.',
    `sla_due_timestamp` TIMESTAMP COMMENT 'Target date and time by which the service request must be resolved according to the applicable SLA tier and priority level. Used for escalation and performance reporting.',
    `sla_tier` STRING COMMENT 'Service level agreement tier determining response and resolution time commitments. Tier 1: standard support; Tier 2: priority support for critical systems; Tier 3: extended support for non-urgent requests; VIP: executive or high-priority user support.. Valid values are `tier_1|tier_2|tier_3|vip`',
    `source_system` STRING COMMENT 'Name of the ITSM platform or system from which this service request record originated (e.g., ServiceNow, Cherwell, Jira Service Management, BMC Remedy). Used for data lineage and integration tracking.',
    `subject` STRING COMMENT 'Brief summary or title of the service request provided by the requester or auto-generated from the request type. Displayed in ticket lists and notifications.',
    `submission_channel` STRING COMMENT 'Method by which the service request was submitted: self-service portal, email, phone call to service desk, walk-in to IT help desk, or live chat.. Valid values are `portal|email|phone|walk_in|chat`',
    `ticket_number` STRING COMMENT 'Externally-visible unique ticket identifier assigned by the ITSM platform (e.g., ServiceNow, Cherwell, Jira Service Management). Used for customer communication and tracking.. Valid values are `^(INC|REQ|SR|TKT)[0-9]{7,10}$`',
    CONSTRAINT pk_service_request PRIMARY KEY(`service_request_id`)
) COMMENT 'Core transactional record for every IT service desk request submitted by students, faculty, or staff through the institutional ITSM platform (e.g., ServiceNow, Cherwell, Jira Service Management). Captures ticket number, request category (hardware, software, access, network, account, AV/classroom tech), request subcategory, requester identity, affected user, priority level, service level agreement (SLA) tier, submission channel (portal, email, phone, walk-in), assigned technician, assigned team, current status (open, in-progress, pending, resolved, closed), open timestamp, SLA due timestamp, resolution timestamp, resolution notes, and customer satisfaction score. Serves as the SSOT for IT service delivery operations.';

CREATE OR REPLACE TABLE `education_ecm`.`technology`.`incident` (
    `incident_id` BIGINT COMMENT 'Unique identifier for the IT incident record. Primary key for the incident entity.',
    `configuration_item_id` BIGINT COMMENT 'Foreign key linking to technology.configuration_item. Business justification: Incidents are tracked against specific configuration items in the CMDB. The affected_ci STRING field should be normalized to configuration_item_id FK for proper referential integrity and to enable inc',
    `identity_account_id` BIGINT COMMENT 'Identifier of the user who initially reported the incident to the service desk.',
    `employee_id` BIGINT COMMENT 'Identifier of the senior IT leader coordinating response for major incidents (P1/P2). Null for lower-severity incidents.',
    `incident_employee_id` BIGINT COMMENT 'Identifier of the individual IT staff member currently assigned to resolve the incident.',
    `it_service_id` BIGINT COMMENT 'Foreign key linking to technology.it_service. Business justification: Incidents are tracked against specific IT services for SLA management and service availability reporting. The affected_service STRING should normalize to it_service_id FK. This is a core ITSM relation',
    `change_request_id` BIGINT COMMENT 'Identifier of the change request if this incident was caused by or resolved through a change to the IT infrastructure.',
    `problem_id` BIGINT COMMENT 'Identifier of the problem record if this incident is linked to a known underlying problem requiring permanent resolution.',
    `parent_incident_id` BIGINT COMMENT 'Self-referencing FK on incident (parent_incident_id)',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'Date and time when the incident was acknowledged by the IT support team. Used to measure initial response time.',
    `affected_system` STRING COMMENT 'Technical system or application component impacted by the incident (e.g., Banner PROD DB, Workday HCM API, Firewall Cluster 2).',
    `affected_user_population_size` STRING COMMENT 'Estimated number of users impacted by the incident. Used to assess business impact and prioritize resolution efforts.',
    `assigned_resolver_group` STRING COMMENT 'IT support team or functional group responsible for resolving the incident (e.g., Network Operations, Database Administration, Security Operations Center, Application Support).',
    `assignment_timestamp` TIMESTAMP COMMENT 'Date and time when the incident was assigned to a resolver or resolver group.',
    `business_impact_description` STRING COMMENT 'Narrative description of the business impact caused by the incident (e.g., Students unable to register for spring courses, Payroll processing delayed, Research data inaccessible).',
    `closure_timestamp` TIMESTAMP COMMENT 'Date and time when the incident was formally closed after user confirmation or automatic closure period elapsed.',
    `communication_channel` STRING COMMENT 'Channel(s) used to communicate incident status to affected users (e.g., Email, SMS, Status Page, Campus Alert System). Pipe-separated if multiple channels used.',
    `communication_sent_flag` BOOLEAN COMMENT 'Indicates whether a mass communication was sent to affected users about the incident. True if communication sent, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the incident record was first created in the ITSM system. Audit trail for record creation.',
    `detection_method` STRING COMMENT 'How the incident was initially discovered: monitoring alert (system-generated), user report (service desk ticket), automated scan (security/compliance tool), routine check (manual inspection), or third-party notification (vendor alert).. Valid values are `monitoring_alert|user_report|automated_scan|routine_check|third_party_notification`',
    `detection_timestamp` TIMESTAMP COMMENT 'Date and time when the incident was first detected or reported. Represents the real-world event time of incident occurrence.',
    `escalation_level` STRING COMMENT 'Current escalation tier of the incident (0 = no escalation, 1 = first-level escalation, 2 = second-level escalation, 3 = executive escalation). Increments as incident severity or duration increases.',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when the incident was most recently escalated to a higher support tier or management level.',
    `estimated_financial_impact` DECIMAL(18,2) COMMENT 'Estimated financial cost of the incident in USD, including lost productivity, revenue impact, and recovery costs. Used for major incident reporting.',
    `incident_category` STRING COMMENT 'High-level classification of the incident type: network outage, system down, security breach, application error, data loss, or hardware failure.. Valid values are `network_outage|system_down|security_breach|application_error|data_loss|hardware_failure`',
    `incident_number` STRING COMMENT 'Externally-visible unique incident ticket number assigned by the ITSM platform (e.g., INC0001234). Used for user communication and tracking.. Valid values are `^INC[0-9]{7,10}$`',
    `incident_status` STRING COMMENT 'Current lifecycle state of the incident: new (just reported), acknowledged (team notified), assigned (resolver assigned), in_progress (actively working), pending (awaiting external input), resolved (fix applied), closed (user confirmed), cancelled (duplicate or invalid). [ENUM-REF-CANDIDATE: new|acknowledged|assigned|in_progress|pending|resolved|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the incident record was most recently updated. Audit trail for record changes.',
    `pir_reference` STRING COMMENT 'Reference identifier or document link to the post-incident review conducted for major incidents. Used to capture lessons learned and improvement actions.',
    `reported_by_contact_method` STRING COMMENT 'Channel through which the user reported the incident: phone, email, web portal, chat, or walk-in to service desk.. Valid values are `phone|email|web_portal|chat|walk_in`',
    `reported_by_user_name` STRING COMMENT 'Full name of the user who reported the incident.',
    `resolution_description` STRING COMMENT 'Detailed description of the actions taken to resolve the incident and restore service. Used for knowledge base articles and future reference.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the incident was resolved (fix applied and service restored). Used to calculate resolution time and SLA compliance.',
    `root_cause_category` STRING COMMENT 'High-level classification of the underlying cause of the incident (e.g., Configuration Error, Hardware Failure, Software Bug, Capacity Exceeded, Human Error, External Dependency). Populated after investigation.',
    `root_cause_description` STRING COMMENT 'Detailed narrative explanation of the root cause identified during incident investigation. Supports knowledge management and problem prevention.',
    `severity_level` STRING COMMENT 'Priority classification indicating business impact and urgency: P1 (critical - major service outage), P2 (high - significant degradation), P3 (medium - minor impact), P4 (low - minimal impact).. Valid values are `P1|P2|P3|P4`',
    `sla_actual_resolution_minutes` STRING COMMENT 'Actual time in minutes from detection to resolution. Calculated as difference between resolution_timestamp and detection_timestamp.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the incident resolution exceeded the SLA target time. True if SLA was breached, False if met.',
    `sla_target_resolution_minutes` STRING COMMENT 'Target resolution time in minutes as defined by the SLA for this incident severity level. Used to measure SLA compliance.',
    `subcategory` STRING COMMENT 'Detailed subcategory providing granular classification within the incident category (e.g., DNS failure under network_outage, SQL injection attempt under security_breach).',
    `user_satisfaction_rating` STRING COMMENT 'Post-resolution satisfaction rating provided by the affected user on a scale of 1-5 (1=very dissatisfied, 5=very satisfied). Used for service quality metrics.',
    `workaround_applied` BOOLEAN COMMENT 'Indicates whether a temporary workaround was applied to restore service while the underlying problem remains unresolved. True if workaround used, False if permanent fix applied.',
    `workaround_description` STRING COMMENT 'Description of the temporary workaround applied to restore service. Null if no workaround was used.',
    CONSTRAINT pk_incident PRIMARY KEY(`incident_id`)
) COMMENT 'Core transactional record for every IT incident — an unplanned interruption or degradation of an IT service — managed through the institutional ITSM platform. Captures incident number, incident category (network outage, system down, security breach, application error, data loss), severity level (P1-P4), affected service or system, affected user population size, detection method (monitoring alert, user report, automated), assigned resolver group, incident commander (for major incidents), current status, detection timestamp, acknowledgment timestamp, resolution timestamp, root cause category, and post-incident review (PIR) reference. Distinct from service_request in that incidents represent unplanned failures requiring restoration, not fulfillment of a user request.';

CREATE OR REPLACE TABLE `education_ecm`.`technology`.`change_request` (
    `change_request_id` BIGINT COMMENT 'Unique identifier for the IT change request record. Primary key for the change_request product.',
    `configuration_item_id` BIGINT COMMENT 'Foreign key linking to technology.configuration_item. Business justification: Change requests target specific configuration items. The affected_ci STRING field should be normalized to configuration_item_id FK. This enables change impact analysis and links change management to t',
    `it_project_id` BIGINT COMMENT 'Foreign key linking to technology.it_project. Business justification: Change requests can be project-driven or operational. Adding optional it_project_id FK allows tracking which changes are part of formal IT projects vs. operational changes. This enables project change',
    `employee_id` BIGINT COMMENT 'Unique identifier of the person who submitted the change request.',
    `rollback_change_request_id` BIGINT COMMENT 'Self-referencing FK on change_request (rollback_change_request_id)',
    `actual_downtime_minutes` STRING COMMENT 'Actual duration of service downtime in minutes that occurred during implementation.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when change implementation was completed.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when change implementation began.',
    `affected_services` STRING COMMENT 'Comma-separated list of IT services that may experience disruption or modification during change implementation.',
    `affected_user_count` STRING COMMENT 'Estimated number of end users who will be impacted by this change.',
    `assigned_to_name` STRING COMMENT 'Full name of the IT staff member or team responsible for implementing the change.',
    `business_justification` STRING COMMENT 'Explanation of the business need, benefit, or requirement driving this change request.',
    `cab_approval_notes` STRING COMMENT 'Comments, conditions, or recommendations provided by the CAB during the approval process.',
    `cab_approval_status` STRING COMMENT 'Decision status from the Change Advisory Board review process.. Valid values are `pending|approved|rejected|conditional|not_required`',
    `cab_review_date` DATE COMMENT 'Date when the change request was reviewed by the CAB.',
    `change_category` STRING COMMENT 'Functional area or domain affected by the change request, used for routing and impact analysis.. Valid values are `infrastructure|application|configuration|security|network|database`',
    `change_freeze_exception` BOOLEAN COMMENT 'Indicates whether this change was granted an exception to proceed during an institutional change freeze period aligned to academic term boundaries.',
    `change_number` STRING COMMENT 'Externally-visible unique change request identifier assigned by the ITSM system, typically following format CHG followed by 7 digits.. Valid values are `^CHG[0-9]{7}$`',
    `change_status` STRING COMMENT 'Current lifecycle state of the change request in the CAB approval and implementation workflow. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|scheduled|in_progress|implemented|successful|failed|rolled_back|closed|cancelled — 13 candidates stripped; promote to reference product]',
    `change_type` STRING COMMENT 'Classification of the change request based on risk and approval requirements. Standard changes are pre-approved low-risk changes; normal changes require CAB review; emergency changes are implemented immediately to restore service; expedited changes are fast-tracked normal changes.. Valid values are `standard|normal|emergency|expedited`',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the change request was formally closed after successful implementation and post-implementation review.',
    `closure_notes` STRING COMMENT 'Final comments and summary provided when closing the change request.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the change request record was first created in the system.',
    `detailed_description` STRING COMMENT 'Comprehensive description of the change including technical details, scope, and implementation steps.',
    `downtime_required` BOOLEAN COMMENT 'Indicates whether the change implementation requires service downtime or outage.',
    `estimated_downtime_minutes` STRING COMMENT 'Estimated duration of service downtime in minutes if downtime is required.',
    `impact_assessment` STRING COMMENT 'Detailed analysis of the potential impact on services, users, systems, and business operations.',
    `implementation_notes` STRING COMMENT 'Detailed notes captured during the implementation process including issues encountered, deviations from plan, and resolution steps.',
    `implementation_outcome` STRING COMMENT 'Final result of the change implementation indicating whether the change was successfully applied, failed, or required rollback.. Valid values are `successful|failed|partially_successful|rolled_back`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the change request record was last updated.',
    `post_implementation_review_date` DATE COMMENT 'Date when the post-implementation review was conducted.',
    `post_implementation_review_notes` STRING COMMENT 'Findings and lessons learned from the post-implementation review, including validation of success criteria and identification of improvement opportunities.',
    `priority` STRING COMMENT 'Business priority level for the change request based on urgency and impact.. Valid values are `low|medium|high|critical`',
    `related_incident_number` STRING COMMENT 'Reference to an incident ticket that triggered or is related to this change request.',
    `related_problem_number` STRING COMMENT 'Reference to a problem ticket that this change is intended to resolve.',
    `requester_department` STRING COMMENT 'Academic or administrative department of the change requester.',
    `requester_name` STRING COMMENT 'Full name of the person who submitted the change request.',
    `risk_level` STRING COMMENT 'Assessment of the potential risk and impact to services if the change fails or causes unintended consequences.. Valid values are `low|medium|high|critical`',
    `rollback_plan` STRING COMMENT 'Documented procedure for reverting the change and restoring the previous configuration if implementation fails.',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'Planned date and time when change implementation is expected to be completed.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned date and time when change implementation is scheduled to begin, aligned with institutional change freeze calendars and academic term boundaries.',
    `short_description` STRING COMMENT 'Brief summary of the change request, typically displayed in lists and dashboards.',
    `test_plan` STRING COMMENT 'Description of testing procedures and validation steps to be performed before and after implementation.',
    CONSTRAINT pk_change_request PRIMARY KEY(`change_request_id`)
) COMMENT 'Transactional record for every formal IT change request submitted through the Change Advisory Board (CAB) process, covering infrastructure changes, application deployments, configuration modifications, and emergency changes. Captures change number, change type (standard, normal, emergency), change category, affected CI (configuration item), change description, business justification, risk level, impact assessment, rollback plan, CAB approval status, scheduled implementation window, actual implementation date, implementation outcome (successful, failed, rolled back), and post-implementation review notes. Supports ITIL change management and institutional change freeze calendars aligned to academic term boundaries.';

CREATE OR REPLACE TABLE `education_ecm`.`technology`.`configuration_item` (
    `configuration_item_id` BIGINT COMMENT 'Unique identifier for the configuration item in the institutional Configuration Management Database (CMDB). Primary key for the configuration_item product.',
    `it_contract_id` BIGINT COMMENT 'Foreign key linking to technology.it_contract. Business justification: Configuration items in the CMDB are covered by support contracts. The support_contract_number STRING should normalize to it_contract_id FK. This links CMDB to contract management and enables CI suppor',
    `parent_configuration_item_id` BIGINT COMMENT 'Self-referencing FK on configuration_item (parent_configuration_item_id)',
    `backup_frequency` STRING COMMENT 'Frequency at which backups are performed for this configuration item. Determined by recovery point objective (RPO) requirements and data criticality. More frequent backups for mission-critical systems.. Valid values are `real_time|hourly|daily|weekly|monthly|on_demand`',
    `backup_required` BOOLEAN COMMENT 'Indicates whether this configuration item requires regular backup as part of institutional data protection and disaster recovery procedures. True for systems containing critical or regulated data.',
    `business_service_name` STRING COMMENT 'Name of the business service or institutional capability that this configuration item supports. Examples include Student Registration, Financial Aid Processing, Research Grant Management, or Learning Management. Links technical components to business outcomes.',
    `ci_class` STRING COMMENT 'High-level classification of the configuration item type. Defines the broad category of IT component being tracked in the CMDB for service topology and impact analysis. [ENUM-REF-CANDIDATE: server|application|database|network_device|service|middleware|storage|endpoint|cloud_resource|virtual_machine — 10 candidates stripped; promote to reference product]',
    `ci_identifier` STRING COMMENT 'Externally-known unique identifier or code for the configuration item, such as a service catalog code, application ID, or network device name. Used for cross-system reference and integration.',
    `ci_name` STRING COMMENT 'Human-readable name or label for the configuration item. Used for identification and display purposes in service management tools and dashboards.',
    `ci_subtype` STRING COMMENT 'Further refinement of CI type for specialized categorization. Examples include Apache web server, Oracle database, Cisco router model, or specific middleware platform version.',
    `ci_type` STRING COMMENT 'Detailed sub-classification within the CI class. Examples include web server, database server, SaaS application, router, switch, firewall, or business service. Provides granular categorization for reporting and analysis.',
    `compliance_scope` STRING COMMENT 'Regulatory or compliance frameworks that apply to this configuration item. Examples include FERPA (student data), HIPAA (health center systems), PCI-DSS (payment processing), FISMA (federal research systems). Used for audit scoping and control validation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this configuration item record was first created in the CMDB. Used for audit trails, data lineage tracking, and CMDB data quality reporting.',
    `criticality` STRING COMMENT 'Business criticality rating of the configuration item based on its impact to institutional operations. Critical items require immediate response for incidents and have strict change control procedures. Used for SLA prioritization and resource allocation.. Valid values are `critical|high|medium|low`',
    `data_classification` STRING COMMENT 'Highest level of data classification that this configuration item processes or stores. Determines security controls, access restrictions, and compliance requirements under FERPA, HIPAA, and institutional data governance policies.. Valid values are `restricted|confidential|internal|public`',
    `discovery_source` STRING COMMENT 'Method by which this configuration item was identified and added to the CMDB. Automated scans provide continuous discovery, manual entries capture items not discoverable by tools. Important for CMDB data quality and completeness assessment.. Valid values are `automated_scan|manual_entry|import|api_integration|service_desk`',
    `discovery_tool` STRING COMMENT 'Name of the automated discovery tool or system that identified this configuration item. Examples include ServiceNow Discovery, Microsoft SCCM, or network scanning tools. Used for reconciliation and data quality auditing.',
    `dr_tier` STRING COMMENT 'Disaster recovery tier classification indicating recovery priority and time objectives. Tier 0 requires immediate failover, Tier 1 within hours, lower tiers have longer recovery windows. Based on business impact analysis.. Valid values are `tier_0|tier_1|tier_2|tier_3|tier_4`',
    `environment` STRING COMMENT 'The operational environment in which the configuration item is deployed. Critical for change management, incident prioritization, and impact analysis. Production environments receive highest priority for incident response. [ENUM-REF-CANDIDATE: production|staging|development|test|qa|dr|sandbox — 7 candidates stripped; promote to reference product]',
    `go_live_date` DATE COMMENT 'Date when this configuration item was placed into production service and made available to end users. May differ from installation date due to testing and staging periods. Critical for SLA calculations and service availability reporting.',
    `hostname` STRING COMMENT 'Fully qualified domain name (FQDN) or network hostname for this configuration item. Used for DNS resolution, remote access, and system identification in distributed environments.',
    `installation_date` DATE COMMENT 'Date when this configuration item was initially installed or deployed into the institutional IT environment. Used for lifecycle tracking, depreciation calculations, and upgrade planning.',
    `ip_address` STRING COMMENT 'Primary IP address assigned to this configuration item on the institutional network. Used for network management, security monitoring, and incident troubleshooting. May be IPv4 or IPv6 format.',
    `last_discovered_timestamp` TIMESTAMP COMMENT 'Date and time when this configuration item was most recently detected by automated discovery processes. Used to identify stale or potentially decommissioned items that have not been seen in recent scans.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this configuration item record was most recently updated. Tracks changes to CI attributes and supports change management audit requirements. Updated automatically on any field modification.',
    `last_verified_date` DATE COMMENT 'Date when the configuration item record was last manually verified or audited for accuracy. CMDB verification ensures data quality and compliance with institutional IT governance policies. Typically performed quarterly or annually.',
    `license_count` STRING COMMENT 'Number of licenses allocated or available for this configuration item. Used for license compliance monitoring and capacity planning. Null for unlimited or site licenses.',
    `license_expiration_date` DATE COMMENT 'Date when the software license or subscription for this configuration item expires. Critical for renewal planning and avoiding service disruptions. Particularly important for SaaS applications and annual subscriptions common in higher education.',
    `license_type` STRING COMMENT 'Type of software licensing model for this configuration item. Critical for compliance audits, budget planning, and software asset management in higher education institutions. [ENUM-REF-CANDIDATE: perpetual|subscription|concurrent|named_user|site|open_source|freeware — 7 candidates stripped; promote to reference product]',
    `lifecycle_stage` STRING COMMENT 'Current stage in the configuration item lifecycle from initial planning through disposal. Tracks the CI journey through institutional IT asset and service management processes.. Valid values are `planning|development|testing|production|retirement|disposed`',
    `location_building_code` STRING COMMENT 'Code identifying the campus building where this configuration item is physically located. Used for facilities management integration, physical security, and disaster recovery planning.',
    `location_room_number` STRING COMMENT 'Room or space identifier where this configuration item is physically located. Important for physical access control, environmental monitoring, and asset audits.',
    `mac_address` STRING COMMENT 'Hardware MAC address for network-connected configuration items. Used for network access control (NAC), device tracking, and security incident investigation. Classified as device identifier PII.',
    `notes` STRING COMMENT 'Free-form text field for additional information, special configurations, known issues, or operational notes about this configuration item. Used by support teams for knowledge sharing and troubleshooting context.',
    `operating_system` STRING COMMENT 'Operating system platform and version running on this configuration item. Examples include Windows Server 2019, Red Hat Enterprise Linux 8, macOS Monterey. Critical for patch management, security compliance, and compatibility assessment.',
    `operational_status` STRING COMMENT 'Current operational state of the configuration item in its lifecycle. Indicates whether the CI is actively in service, undergoing maintenance, or has been decommissioned. Used for availability reporting and service impact analysis.. Valid values are `operational|non_operational|under_repair|retired|planned|ordered`',
    `owning_department_code` STRING COMMENT 'Code identifying the academic or administrative department that owns or is responsible for this configuration item. Used for cost allocation, access control, and accountability in decentralized IT environments common in higher education.',
    `owning_department_name` STRING COMMENT 'Full name of the department that owns this configuration item. Examples include College of Engineering, Office of the Registrar, or University Libraries.',
    `product_name` STRING COMMENT 'Commercial product name or brand of the configuration item. Examples include Oracle Database, Cisco Catalyst, VMware vSphere, or Ellucian Banner. Used for license management and vendor support.',
    `retirement_date` DATE COMMENT 'Planned or actual date when this configuration item will be or was decommissioned and removed from service. Used for lifecycle planning, data migration scheduling, and compliance with data retention policies.',
    `support_expiration_date` DATE COMMENT 'Date when vendor support or maintenance coverage expires for this configuration item. Critical for planning renewals and identifying unsupported systems that pose security and operational risks.',
    `support_team` STRING COMMENT 'Name of the IT support team or group responsible for maintaining and supporting this configuration item. Used for incident assignment, change approval routing, and escalation procedures.',
    `support_tier` STRING COMMENT 'Level of technical support responsible for this configuration item. Tier 1 handles basic issues, Tier 2 handles complex troubleshooting, Tier 3 handles architecture and design, vendor support involves external providers.. Valid values are `tier_1|tier_2|tier_3|vendor|specialized`',
    `vendor_name` STRING COMMENT 'Name of the vendor or manufacturer that provides this configuration item. Used for support contract management, license compliance, and vendor relationship tracking.',
    `verified_by` STRING COMMENT 'Name or identifier of the person who last verified the accuracy of this configuration item record. Used for accountability in CMDB data quality management.',
    `version` STRING COMMENT 'Version number or release identifier for the configuration item. Critical for software applications, databases, and middleware to track compatibility, security patches, and upgrade planning.',
    CONSTRAINT pk_configuration_item PRIMARY KEY(`configuration_item_id`)
) COMMENT 'Master record for every configuration item (CI) tracked in the institutional Configuration Management Database (CMDB), representing the logical or physical components that make up IT services. Captures CI name, CI class (server, application, database, network device, service, middleware), CI type, environment (production, staging, development, DR), operational status, owning department, support team, related business service, discovery source (automated scan, manual entry), last verified date, and CI relationships (parent/child, depends-on, hosted-on). Serves as the CMDB backbone enabling impact analysis for incidents and changes. Complements it_asset (financial/physical tracking) with service-topology context.';

CREATE OR REPLACE TABLE `education_ecm`.`technology`.`cybersecurity_incident` (
    `cybersecurity_incident_id` BIGINT COMMENT 'Unique identifier for the cybersecurity incident record. Primary key for the cybersecurity incident entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the information security staff member or incident response team member assigned as the primary investigator for this incident. Links to employee or user identity record.',
    `identity_account_id` BIGINT COMMENT 'Identifier of the user (student, faculty, staff) who initially reported the incident, if applicable. Links to user or employee identity record. Null if incident was detected by automated systems.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to technology.incident. Business justification: Cybersecurity incidents often generate corresponding ITSM incident tickets for operational tracking and resolution. The related_itsm_incident_number STRING should normalize to incident_id FK. This lin',
    `related_cybersecurity_incident_id` BIGINT COMMENT 'Self-referencing FK on cybersecurity_incident (related_cybersecurity_incident_id)',
    `affected_data_types` STRING COMMENT 'Description of the categories of data potentially exposed, accessed, or compromised during the incident. Examples include student academic records, financial aid data, employee payroll information, research data, or health records.',
    `affected_systems` STRING COMMENT 'Comma-separated list or narrative description of institutional IT systems, applications, servers, or network segments impacted by the cybersecurity incident. May include Student Information System (SIS), Learning Management System (LMS), email servers, file shares, or research computing infrastructure.',
    `assigned_investigator_name` STRING COMMENT 'Full name of the primary incident investigator for display and reporting purposes. Denormalized for operational convenience.',
    `attack_vector` STRING COMMENT 'Description of the method or pathway used by the attacker to compromise systems or data. Examples include phishing email, unpatched vulnerability, stolen credentials, malicious attachment, drive-by download, or SQL injection.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the incident was formally closed after all response activities, notifications, and documentation were completed. Marks the end of the incident lifecycle.',
    `closure_notes` STRING COMMENT 'Final summary notes documenting the resolution of the incident, including confirmation of eradication, validation of recovery, completion of notifications, and any outstanding follow-up actions or monitoring requirements.',
    `containment_actions` STRING COMMENT 'Narrative summary of immediate containment steps taken to limit the scope and impact of the incident. Actions may include isolating affected systems, disabling compromised accounts, blocking malicious IP addresses, or shutting down network segments.',
    `containment_timestamp` TIMESTAMP COMMENT 'Date and time when the incident was successfully contained, preventing further unauthorized access or data exfiltration. Marks the transition from active threat to controlled investigation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this cybersecurity incident record was first created in the information security incident management system. Used for audit trail and record lifecycle tracking.',
    `data_sensitivity_level` STRING COMMENT 'Highest classification level of data involved in the incident, determining regulatory notification and breach response obligations. Categories include FERPA-protected education records, HIPAA Protected Health Information (PHI), Payment Card Industry Data Security Standard (PCI DSS) cardholder data, controlled research data, or public information.. Valid values are `ferpa_protected|hipaa_phi|pci_dss|research_controlled|public`',
    `detection_source` STRING COMMENT 'The channel or mechanism through which the incident was initially detected. Sources include Security Information and Event Management (SIEM) alerts, user reports, threat intelligence feeds, vulnerability scans, audit log reviews, or external notifications from partners or law enforcement.. Valid values are `siem_alert|user_report|threat_intel_feed|vulnerability_scan|audit_log_review|external_notification`',
    `detection_timestamp` TIMESTAMP COMMENT 'Date and time when the cybersecurity incident was first detected or reported, representing the initial awareness event. This is the principal business event timestamp for the incident lifecycle.',
    `eradication_actions` STRING COMMENT 'Narrative summary of eradication steps taken to remove the threat from the environment. Actions may include malware removal, patching vulnerabilities, deleting unauthorized accounts, or rebuilding compromised systems.',
    `eradication_timestamp` TIMESTAMP COMMENT 'Date and time when the threat was fully eradicated from institutional systems and the root cause was addressed. Marks completion of threat removal activities.',
    `estimated_financial_impact` DECIMAL(18,2) COMMENT 'Estimated total financial cost of the incident in U.S. dollars, including investigation costs, remediation expenses, notification costs, legal fees, regulatory fines, and business disruption losses. Used for risk quantification and insurance claims.',
    `estimated_record_count` STRING COMMENT 'Estimated number of individual records (student records, employee records, patient records, etc.) potentially affected by the incident. Used for breach notification threshold determination and regulatory reporting.',
    `forensic_evidence_collected_flag` BOOLEAN COMMENT 'Boolean indicator of whether digital forensic evidence was collected and preserved during the incident investigation. True indicates evidence was collected for potential legal proceedings or detailed analysis; false indicates no forensic collection.',
    `forensic_evidence_location` STRING COMMENT 'Secure storage location or reference identifier for collected forensic evidence, including disk images, memory dumps, log files, or network packet captures. Maintained for chain of custody and potential legal proceedings.',
    `incident_classification` STRING COMMENT 'Primary classification of the cybersecurity incident type per institutional taxonomy aligned with NIST Cybersecurity Framework (CSF). Categories include phishing attacks, malware infections, unauthorized access attempts, data breaches, ransomware events, and insider threats.. Valid values are `phishing|malware|unauthorized_access|data_breach|ransomware|insider_threat`',
    `incident_description` STRING COMMENT 'Detailed narrative description of the cybersecurity incident, including initial symptoms, observed behavior, affected users or systems, and preliminary assessment. Provides context for investigation and response activities.',
    `incident_status` STRING COMMENT 'Current lifecycle status of the cybersecurity incident investigation and response workflow. Tracks progression from initial detection through containment, eradication, recovery, and closure.. Valid values are `new|investigating|contained|eradicated|recovered|closed`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this cybersecurity incident record was most recently updated. Used for audit trail and change tracking throughout the incident lifecycle.',
    `law_enforcement_case_number` STRING COMMENT 'Case or reference number assigned by law enforcement agency if the incident was reported for criminal investigation. Used for coordination with law enforcement and tracking legal proceedings.',
    `law_enforcement_notified_flag` BOOLEAN COMMENT 'Boolean indicator of whether law enforcement agencies (FBI, Secret Service, state/local police) were notified of the incident. True indicates law enforcement involvement; false indicates no law enforcement notification.',
    `lessons_learned_summary` STRING COMMENT 'Summary of key lessons learned from the incident response process, including what worked well, what could be improved, and recommendations for policy, process, or technology enhancements to prevent recurrence.',
    `mitre_attack_techniques` STRING COMMENT 'Comma-separated list of MITRE ATT&CK technique identifiers (e.g., T1566.001 for Spearphishing Attachment) observed during the incident. Used for threat intelligence sharing and defensive control mapping.',
    `notification_completed_date` DATE COMMENT 'Date when all required breach notifications were completed and documented. Used to demonstrate compliance with notification deadlines and regulatory requirements.',
    `notification_deadline_date` DATE COMMENT 'Regulatory or legal deadline by which affected parties and agencies must be notified of the breach. Calculated based on applicable law (e.g., HIPAA requires notification within 60 days of discovery; state laws vary from immediate to 90 days).',
    `notification_obligations` STRING COMMENT 'Description of specific notification requirements triggered by the incident, including affected parties (students, employees, patients), regulatory agencies (U.S. Department of Education, state attorneys general), and notification timelines. May reference FERPA breach notification, HIPAA breach notification, or state-specific breach laws.',
    `notification_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether the incident triggers regulatory or legal notification obligations under FERPA breach notification requirements, state breach notification laws, or contractual obligations. True indicates notification is required; false indicates no notification obligation.',
    `recovery_actions` STRING COMMENT 'Narrative summary of recovery steps taken to restore affected systems and services to normal operation. Actions may include restoring from backups, reconfiguring systems, validating data integrity, or re-enabling user access.',
    `recovery_timestamp` TIMESTAMP COMMENT 'Date and time when affected systems and services were fully restored to normal operation and validated for safe use. Marks the return to business-as-usual state.',
    `reported_by_user_name` STRING COMMENT 'Full name of the user who reported the incident, if applicable. Denormalized for operational convenience and recognition purposes.',
    `root_cause_analysis` STRING COMMENT 'Detailed narrative of the root cause investigation findings, identifying the underlying vulnerability, misconfiguration, or human error that enabled the incident. Used for lessons learned and preventive control implementation.',
    `severity_level` STRING COMMENT 'Assessed severity of the cybersecurity incident based on impact to confidentiality, integrity, and availability of institutional systems and data. Critical incidents involve significant data breaches or system compromise; low incidents involve minor policy violations with no data exposure.. Valid values are `critical|high|medium|low`',
    `threat_actor_type` STRING COMMENT 'Classification of the suspected threat actor behind the incident based on tactics, techniques, and procedures (TTPs). Categories include nation-state actors, organized cybercrime groups, hacktivists, malicious insiders, opportunistic attackers, or unknown.. Valid values are `nation_state|organized_crime|hacktivist|insider|opportunistic|unknown`',
    CONSTRAINT pk_cybersecurity_incident PRIMARY KEY(`cybersecurity_incident_id`)
) COMMENT 'Master record for every cybersecurity incident investigated by the institutions information security office, including phishing attacks, malware infections, unauthorized access, data breaches, ransomware events, and insider threats. Captures incident identifier, incident classification (per NIST CSF or institutional taxonomy), detection source (SIEM alert, user report, threat intel feed), affected systems and data types, data sensitivity level (FERPA, HIPAA, PCI, research data), containment actions taken, eradication steps, recovery actions, notification obligations triggered (FERPA breach, state breach notification law), regulatory reporting deadlines, incident severity, and lessons-learned summary. Distinct from the ITSM incident in that cybersecurity incidents involve security investigation workflows, legal/compliance notification, and forensic evidence handling.';

CREATE OR REPLACE TABLE `education_ecm`.`technology`.`vulnerability` (
    `vulnerability_id` BIGINT COMMENT 'Unique identifier for the security vulnerability record in the institutions vulnerability management program.',
    `configuration_item_id` BIGINT COMMENT 'Foreign key linking to technology.configuration_item. Business justification: Vulnerabilities are discovered on specific configuration items (servers, network devices, applications). The affected_asset_identifier STRING should normalize to configuration_item_id FK. This links v',
    `related_vulnerability_id` BIGINT COMMENT 'Self-referencing FK on vulnerability (related_vulnerability_id)',
    `affected_software_name` STRING COMMENT 'Name of the software product, operating system, or application component that contains the vulnerability.',
    `affected_software_vendor` STRING COMMENT 'Name of the software vendor or publisher that produces the affected software product.',
    `affected_software_version` STRING COMMENT 'Version number or build identifier of the affected software product in which the vulnerability exists.',
    `affected_system_count` STRING COMMENT 'Total number of institutional systems, devices, or application instances affected by this vulnerability, used to assess institutional exposure and prioritize remediation efforts.',
    `business_criticality` STRING COMMENT 'Business criticality rating of the affected system or application (mission-critical, high, medium, low), used to prioritize remediation based on operational impact.. Valid values are `mission-critical|high|medium|low`',
    `compliance_framework_impact` STRING COMMENT 'Identification of regulatory or compliance frameworks (FERPA, HIPAA, PCI-DSS, FISMA, state data breach laws) that may be impacted by this vulnerability if exploited, used to prioritize remediation for compliance-critical systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vulnerability record was first created in the vulnerability management system.',
    `cve_identifier` STRING COMMENT 'Standardized CVE identifier assigned by MITRE for publicly disclosed vulnerabilities, enabling cross-reference with national vulnerability databases and vendor advisories.. Valid values are `^CVE-d{4}-d{4,}$`',
    `cvss_base_score` DECIMAL(18,2) COMMENT 'Numeric severity score (0.0 to 10.0) calculated using the CVSS framework, representing the intrinsic characteristics of the vulnerability independent of temporal or environmental factors.',
    `cvss_vector_string` STRING COMMENT 'Compressed textual representation of the CVSS metric values (e.g., CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H) used to derive the base score.',
    `data_classification_exposure` STRING COMMENT 'Highest data classification level of information that could be exposed if this vulnerability is exploited, used to assess business impact and prioritize remediation.. Valid values are `restricted|confidential|internal|public`',
    `discovery_date` DATE COMMENT 'Date on which the vulnerability was first identified within the institutions environment through automated scanning, penetration testing, or vendor advisory.',
    `discovery_source` STRING COMMENT 'Method or channel through which the vulnerability was discovered (automated scan from Tenable/Qualys/Rapid7, penetration testing engagement, vendor security advisory, security research, incident response, manual audit).. Valid values are `automated-scan|penetration-test|vendor-advisory|security-research|incident-response|manual-audit`',
    `exploitability_assessment` STRING COMMENT 'Assessment of the likelihood and ease of exploiting this vulnerability in the wild: active-exploit (known active exploitation), proof-of-concept (exploit code publicly available), theoretical (exploit possible but not demonstrated), unlikely (difficult to exploit).. Valid values are `active-exploit|proof-of-concept|theoretical|unlikely`',
    `false_positive_justification` STRING COMMENT 'Technical explanation for why the reported vulnerability is determined to be a false positive, including evidence and validation method. Required when remediation_status is false-positive.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this vulnerability record, capturing status changes, remediation progress, or data corrections.',
    `network_exposure` STRING COMMENT 'Network exposure classification of the affected asset: internet-facing (publicly accessible), internal (campus network only), isolated (air-gapped or restricted network), DMZ (demilitarized zone).. Valid values are `internet-facing|internal|isolated|dmz`',
    `notes` STRING COMMENT 'Free-text field for additional context, coordination notes, escalation history, or special handling instructions related to this vulnerability.',
    `patch_identifier` STRING COMMENT 'Vendor-assigned identifier for the security patch or update that remediates this vulnerability (e.g., Microsoft KB number, Red Hat advisory ID).',
    `remediation_action_taken` STRING COMMENT 'Description of the specific remediation action performed to address the vulnerability, such as patch applied, configuration changed, software upgraded, system decommissioned, or compensating control implemented.',
    `remediation_completed_date` DATE COMMENT 'Actual date on which the vulnerability was successfully remediated through patching, configuration change, or other corrective action.',
    `remediation_due_date` DATE COMMENT 'Target date by which the vulnerability must be remediated, calculated based on institutional severity-based SLA policies (e.g., critical within 7 days, high within 30 days).',
    `remediation_owner_department` STRING COMMENT 'Organizational department or unit responsible for remediation, such as IT Infrastructure, Application Development, or Network Services.',
    `remediation_owner_name` STRING COMMENT 'Name of the individual or team responsible for remediating this vulnerability, typically the system owner, application owner, or infrastructure team lead.',
    `remediation_status` STRING COMMENT 'Current lifecycle status of the vulnerability remediation effort: open (newly discovered), in-remediation (work in progress), remediated (patched or fixed), accepted-risk (formally accepted by risk owner), false-positive (determined not to be a valid vulnerability), mitigated (compensating controls applied).. Valid values are `open|in-remediation|remediated|accepted-risk|false-positive|mitigated`',
    `risk_acceptance_approval_date` DATE COMMENT 'Date on which the risk acceptance decision was formally approved by the authorized risk owner.',
    `risk_acceptance_approver_name` STRING COMMENT 'Name of the authorized individual (typically CISO, CIO, or senior IT leader) who formally approved the risk acceptance decision.',
    `risk_acceptance_expiration_date` DATE COMMENT 'Date on which the risk acceptance expires and must be re-evaluated or remediated, ensuring periodic review of accepted risks.',
    `risk_acceptance_justification` STRING COMMENT 'Business and technical rationale for accepting the vulnerability risk without remediation, including compensating controls, business impact of remediation, and risk owner approval. Required when remediation_status is accepted-risk.',
    `scan_identifier` STRING COMMENT 'Unique identifier of the vulnerability scan or assessment run that detected this vulnerability, enabling traceability to the source scan report.',
    `scanning_tool_name` STRING COMMENT 'Name of the automated vulnerability scanning tool that detected this vulnerability (e.g., Tenable Nessus, Qualys VMDR, Rapid7 InsightVM).',
    `severity_level` STRING COMMENT 'Categorical severity classification (critical, high, medium, low, informational) derived from CVSS base score and used to determine remediation SLA and prioritization.. Valid values are `critical|high|medium|low|informational`',
    `threat_intelligence_indicator` STRING COMMENT 'Reference to external threat intelligence sources or indicators of compromise (IOCs) associated with active exploitation of this vulnerability, used to elevate priority.',
    `title` STRING COMMENT 'Concise descriptive title of the security vulnerability as reported by the scanning tool or security advisory.',
    `verification_scan_date` DATE COMMENT 'Date of the follow-up vulnerability scan performed to verify that the remediation action successfully eliminated the vulnerability.',
    `verification_status` STRING COMMENT 'Status of remediation verification: verified (confirmed resolved by rescan), pending-verification (awaiting rescan), failed-verification (still present after remediation attempt), not-applicable (verification not required for this remediation type).. Valid values are `verified|pending-verification|failed-verification|not-applicable`',
    `vulnerability_description` STRING COMMENT 'Detailed technical description of the vulnerability, including the nature of the security weakness, potential exploit vectors, and impact to confidentiality, integrity, or availability.',
    CONSTRAINT pk_vulnerability PRIMARY KEY(`vulnerability_id`)
) COMMENT 'Master record for every identified security vulnerability tracked by the institutions vulnerability management program, sourced from automated scanning tools (Tenable, Qualys, Rapid7), penetration testing engagements, and vendor security advisories (CVEs). Captures CVE identifier, CVSS base score, vulnerability title, affected asset or software, affected system count, discovery date, discovery source, remediation owner, remediation due date (based on severity SLA), remediation status (open, in-remediation, remediated, accepted-risk, false-positive), remediation action taken, and risk acceptance justification when applicable. Enables institutional vulnerability SLA compliance tracking and feeds cybersecurity risk reporting.';

CREATE OR REPLACE TABLE `education_ecm`.`technology`.`enterprise_application` (
    `enterprise_application_id` BIGINT COMMENT 'Unique identifier for the enterprise application in the institutional application portfolio registry. Primary key for the enterprise application master record.',
    `configuration_item_id` BIGINT COMMENT 'Foreign key linking to technology.configuration_item. Business justification: Enterprise applications are configuration items in ITIL/CMDB frameworks. The configuration_item tables ci_class field would include application as a CI type. This FK enables tracking applications a',
    `parent_enterprise_application_id` BIGINT COMMENT 'Self-referencing FK on enterprise_application (parent_enterprise_application_id)',
    `accessibility_compliance_level` STRING COMMENT 'Level of web accessibility standards compliance for the application, ensuring usability for individuals with disabilities (WCAG for Web Content Accessibility Guidelines, Section 508 for US federal accessibility requirements).. Valid values are `WCAG 2.0 AA|WCAG 2.1 AA|WCAG 2.2 AA|Section 508|Not Compliant|Unknown`',
    `api_availability` STRING COMMENT 'Type of programmatic API (Application Programming Interface) provided by the application for integration and data exchange with other systems.. Valid values are `REST API|SOAP API|GraphQL|Proprietary|None`',
    `application_category` STRING COMMENT 'High-level functional category classifying the application by its primary business domain (e.g., ERP for Enterprise Resource Planning, SIS for Student Information System, LMS for Learning Management System). [ENUM-REF-CANDIDATE: ERP|SIS|LMS|CRM|HCM|Financial|Research Administration|Advancement|Library|Facilities|Analytics|Infrastructure|Security|Collaboration — 14 candidates stripped; promote to reference product]',
    `application_code` STRING COMMENT 'Short alphanumeric code or abbreviation used to uniquely identify the application in IT systems and documentation (e.g., BANNER, CANVAS, SLATE, WDAY).. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `application_name` STRING COMMENT 'Full business name of the enterprise application as known to users and stakeholders (e.g., Ellucian Banner Student Information System, Canvas Learning Management System).',
    `authentication_method` STRING COMMENT 'Primary user authentication mechanism used by the application (SSO for Single Sign-On, SAML for Security Assertion Markup Language federation, LDAP for directory services, local credentials, OAuth, or multi-factor authentication).. Valid values are `SSO|SAML|LDAP|Local|OAuth|Multi-Factor`',
    `backup_frequency` STRING COMMENT 'Frequency at which application data is backed up to support disaster recovery and data protection requirements.. Valid values are `Real-Time|Hourly|Daily|Weekly|Monthly|None`',
    `business_application_owner` STRING COMMENT 'Name or identifier of the business stakeholder or functional leader responsible for application strategy, requirements, and business outcomes.',
    `compliance_frameworks` STRING COMMENT 'Comma-separated list of regulatory and compliance frameworks applicable to this application (e.g., FERPA, HIPAA, PCI-DSS, FISMA, GDPR, SOC 2) based on the data it processes and institutional requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this application record was first created in the enterprise application portfolio registry.',
    `criticality_rating` STRING COMMENT 'Business impact classification indicating the importance of the application to institutional operations (mission critical for essential services, high for important functions, medium for supporting services, low for convenience applications).. Valid values are `Mission Critical|High|Medium|Low`',
    `data_classification_level` STRING COMMENT 'Highest sensitivity level of data processed or stored by the application, determining security and access control requirements (restricted for FERPA/HIPAA data, confidential for business-sensitive, internal for operational, public for non-sensitive).. Valid values are `restricted|confidential|internal|public`',
    `data_residency_location` STRING COMMENT 'Geographic location or jurisdiction where application data is physically stored, relevant for compliance with data sovereignty and privacy regulations.',
    `deployment_model` STRING COMMENT 'Technical deployment architecture indicating where and how the application is hosted (on-premise data center, cloud Software-as-a-Service, hybrid model, or third-party hosted).. Valid values are `On-Premise|Cloud SaaS|Hybrid|Hosted|IaaS|PaaS`',
    `disaster_recovery_tier` STRING COMMENT 'Business continuity tier classification indicating recovery priority and RTO (Recovery Time Objective) requirements (Tier 1 for mission-critical with immediate recovery, Tier 2 for high priority, Tier 3 for moderate priority, Tier 4 for low priority).. Valid values are `Tier 1|Tier 2|Tier 3|Tier 4`',
    `documentation_url` STRING COMMENT 'Web URL or repository location where application documentation, user guides, and technical specifications are maintained.',
    `go_live_date` DATE COMMENT 'Date when the application was first deployed to production and made available to end users in the institutional environment.',
    `hosting_environment` STRING COMMENT 'Specific hosting platform or infrastructure environment where the application runs (e.g., AWS, Azure, Google Cloud, on-campus data center, vendor cloud).',
    `integration_dependencies` STRING COMMENT 'Comma-separated list or description of other enterprise applications or systems that this application integrates with via API (Application Programming Interface), ETL (Extract Transform Load), or other data exchange mechanisms.',
    `is_mobile_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether the application provides native mobile apps or mobile-responsive web interfaces for smartphone and tablet access.',
    `is_sso_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether the application is integrated with the institutional Single Sign-On (SSO) identity management system for seamless authentication.',
    `it_application_owner` STRING COMMENT 'Name or identifier of the IT staff member responsible for technical administration, maintenance, and support of the application.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this application record was most recently updated in the enterprise application portfolio registry.',
    `last_security_assessment_date` DATE COMMENT 'Date of the most recent security assessment, vulnerability scan, or penetration test conducted on the application.',
    `lifecycle_status` STRING COMMENT 'Current stage in the application lifecycle indicating operational status (active for production use, sunset planned for scheduled retirement, decommissioned for retired, under evaluation for assessment phase, implementation for deployment in progress, pilot for limited trial).. Valid values are `Active|Sunset Planned|Decommissioned|Under Evaluation|Implementation|Pilot`',
    `modified_by` STRING COMMENT 'Username or identifier of the person who last modified this application record, supporting audit trail and data stewardship accountability.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special considerations, migration plans, known issues, or other contextual information about the application.',
    `owning_department_code` STRING COMMENT 'Code identifying the institutional department or division that has primary business ownership and budgetary responsibility for the application.',
    `primary_business_function` STRING COMMENT 'Core business process or functional area that this application primarily supports (e.g., Student Registration, Financial Aid Administration, Course Content Delivery, Donor Management).',
    `product_version` STRING COMMENT 'Current version number or release identifier of the application software as deployed in the institutional environment.',
    `replacement_application_code` STRING COMMENT 'Application code of the successor system that will replace this application if sunset is planned. Null if no replacement is identified.',
    `sunset_date` DATE COMMENT 'Planned date for application retirement or decommissioning when lifecycle status is sunset planned. Null if no sunset is scheduled.',
    `support_tier` STRING COMMENT 'Level of IT support coverage provided for the application (24x7 for round-the-clock support, business hours for standard coverage, best effort for limited support, vendor only for vendor-managed support).. Valid values are `24x7|Business Hours|Best Effort|Vendor Only`',
    `total_user_count` STRING COMMENT 'Total number of active user accounts or licenses provisioned for the application across all user populations (students, faculty, staff, external).',
    `user_satisfaction_score` DECIMAL(18,2) COMMENT 'Average user satisfaction rating from surveys or feedback mechanisms, typically on a scale of 1.00 to 5.00, measuring end-user experience and application effectiveness.',
    `vendor_name` STRING COMMENT 'Name of the software vendor or provider that develops and supports the application (e.g., Ellucian, Instructure, Workday, Oracle, Salesforce).',
    `vendor_support_contact` STRING COMMENT 'Primary contact information (email or phone) for vendor technical support and escalation.',
    CONSTRAINT pk_enterprise_application PRIMARY KEY(`enterprise_application_id`)
) COMMENT 'Master record for every enterprise application in the institutional application portfolio, including ERP modules (Banner, Workday, PeopleSoft), SIS, LMS (Canvas), CRM, research administration systems, and departmental applications. Captures application name, application code, vendor, version, deployment model (on-premise, cloud SaaS, hybrid), hosting environment, primary business function, owning department, IT application owner, business application owner, data classification level (restricted, confidential, internal, public), integration dependencies, go-live date, contract expiration date, and lifecycle status (active, sunset-planned, decommissioned). Serves as the authoritative application portfolio registry for IT governance and enterprise architecture.';

CREATE OR REPLACE TABLE `education_ecm`.`technology`.`application_integration` (
    `application_integration_id` BIGINT COMMENT 'Unique identifier for the application integration record. Primary key.',
    `enterprise_application_id` BIGINT COMMENT 'Technical identifier or instance name of the source application system.',
    `target_application_enterprise_application_id` BIGINT COMMENT 'Technical identifier or instance name of the target application system.',
    `superseded_application_integration_id` BIGINT COMMENT 'Self-referencing FK on application_integration (superseded_application_integration_id)',
    `activation_date` DATE COMMENT 'Date when the integration was first activated and moved to production.',
    `authentication_method` STRING COMMENT 'Authentication mechanism used to secure the integration connection (OAuth 2.0, SAML for federated identity, API Key, Basic Auth, Certificate-based, SSO for Single Sign-On, Kerberos for enterprise authentication).. Valid values are `OAuth 2.0|SAML|API Key|Basic Auth|Certificate|SSO|Kerberos`',
    `average_record_volume` STRING COMMENT 'Average number of records or transactions processed per integration execution, used for capacity planning and performance monitoring.',
    `business_criticality` STRING COMMENT 'Business impact classification of the integration (Critical for mission-critical processes with immediate business impact, High for important but not mission-critical, Medium for standard operational processes, Low for non-essential or convenience integrations).. Valid values are `Critical|High|Medium|Low`',
    `compliance_requirements` STRING COMMENT 'Comma-separated list of regulatory or compliance frameworks applicable to this integration (e.g., FERPA, HIPAA, PCI-DSS, GDPR, SOX, institutional data governance policies).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this integration record was first created in the system.',
    `data_objects_exchanged` STRING COMMENT 'Comma-separated list or description of the primary data entities or objects transferred (e.g., Student Records, Course Enrollments, Financial Transactions, Faculty Assignments).',
    `data_sensitivity_classification` STRING COMMENT 'Highest data classification level of the data exchanged in this integration, per institutional data governance policy (Restricted for FERPA-protected student records or PII, Confidential for business-sensitive data, Internal for operational data, Public for non-sensitive data).. Valid values are `Restricted|Confidential|Internal|Public`',
    `data_transformation_required` BOOLEAN COMMENT 'Indicates whether data transformation or mapping is required between source and target schemas (True if transformation logic is applied, False for direct pass-through).',
    `deactivation_date` DATE COMMENT 'Date when the integration was deactivated or retired from production. Null if currently active.',
    `dependency_notes` STRING COMMENT 'Free-text notes describing upstream or downstream dependencies, prerequisite integrations, or impact considerations for change management.',
    `documentation_url` STRING COMMENT 'URL or file path to the technical documentation, runbook, or knowledge base article for this integration.',
    `encryption_enabled` BOOLEAN COMMENT 'Indicates whether data in transit is encrypted using TLS/SSL or other encryption protocols (True if encryption is enabled, False otherwise).',
    `error_handling_approach` STRING COMMENT 'Strategy used to handle integration errors (Retry for automatic retry logic, Alert and Stop for immediate halt with notification, Log and Continue for non-blocking errors, Dead Letter Queue for message quarantine, Manual Intervention for human review required).. Valid values are `Retry|Alert and Stop|Log and Continue|Dead Letter Queue|Manual Intervention`',
    `integration_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the integration in technical documentation and monitoring systems.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `integration_description` STRING COMMENT 'Detailed description of the integration purpose, business process supported, and data flow summary.',
    `integration_frequency` STRING COMMENT 'Frequency at which the integration executes (Real-Time for immediate sync, Near Real-Time for sub-minute latency, Hourly/Daily/Weekly/Monthly for scheduled batch, On-Demand for manual trigger, Event-Triggered for event-based execution). [ENUM-REF-CANDIDATE: Real-Time|Near Real-Time|Hourly|Daily|Weekly|Monthly|On-Demand|Event-Triggered — 8 candidates stripped; promote to reference product]',
    `integration_name` STRING COMMENT 'Business-friendly name of the integration (e.g., Banner-to-Canvas Grade Sync, Slate-to-Banner Admissions Feed).',
    `integration_owner` STRING COMMENT 'Name or identifier of the business or technical owner responsible for the integration (typically a department, team, or individual).',
    `integration_owner_email` STRING COMMENT 'Email address of the integration owner for operational notifications and escalations.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `integration_pattern` STRING COMMENT 'Technical integration pattern used (API for real-time web services, ETL Batch for scheduled bulk loads, Event-Driven for publish-subscribe, File Transfer for SFTP/FTP, Database Replication for direct DB sync, Messaging Queue for asynchronous messaging).. Valid values are `API|ETL Batch|Event-Driven|File Transfer|Database Replication|Messaging Queue`',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance or security audit performed on this integration.',
    `last_failed_run_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent failed execution of the integration. Null if no failures have occurred since last successful run.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this integration record was last updated.',
    `last_successful_run_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful execution of the integration, used for monitoring and operational health checks.',
    `middleware_platform` STRING COMMENT 'Middleware or integration platform used to orchestrate the integration (e.g., MuleSoft, Dell Boomi, Informatica, Apache Kafka, custom script, native API).',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified this integration record.',
    `monitoring_dashboard_url` STRING COMMENT 'URL to the operational monitoring dashboard or observability tool tracking this integrations health and performance metrics.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review or recertification of the integration, per governance policy.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or operational observations about the integration.',
    `operational_status` STRING COMMENT 'Current operational state of the integration (Active for production use, Inactive for disabled, Suspended for temporarily paused, Deprecated for planned retirement, In Development for under construction, Testing for pre-production validation).. Valid values are `Active|Inactive|Suspended|Deprecated|In Development|Testing`',
    `peak_record_volume` STRING COMMENT 'Maximum number of records or transactions processed in a single integration execution, representing peak load.',
    `retry_count` STRING COMMENT 'Number of automatic retry attempts configured for failed integration executions before escalation or manual intervention.',
    `sla_target_latency_minutes` STRING COMMENT 'Target maximum latency in minutes for data to be delivered from source to target, as defined in the integration SLA.',
    `technical_contact` STRING COMMENT 'Name or identifier of the technical contact responsible for integration maintenance and troubleshooting.',
    `technical_contact_email` STRING COMMENT 'Email address of the technical contact for integration support and incident response.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `transformation_logic_description` STRING COMMENT 'Description of the data transformation, mapping, or business rules applied during the integration process.',
    CONSTRAINT pk_application_integration PRIMARY KEY(`application_integration_id`)
) COMMENT 'Master record for every point-to-point or middleware-based integration between enterprise applications in the institutional integration landscape. Captures integration name, source application, target application, integration pattern (API, ETL batch, event-driven, file transfer), middleware platform (MuleSoft, Dell Boomi, Informatica, custom), data objects exchanged, integration frequency, data sensitivity classification, integration owner, operational status, last successful run timestamp, and error handling approach. Enables integration dependency mapping, impact analysis for application changes, and middleware governance.';

CREATE OR REPLACE TABLE `education_ecm`.`technology`.`it_project` (
    `it_project_id` BIGINT COMMENT 'Unique identifier for the IT project record. Primary key.',
    `grant_account_id` BIGINT COMMENT 'Foreign key linking to finance.grant_account. Business justification: IT projects often support grant-funded research (lab systems, data infrastructure, specialized software). Real business process: project cost tracking against grant budgets, effort reporting, delivera',
    `it_contract_id` BIGINT COMMENT 'Foreign key linking to technology.it_contract. Business justification: IT projects may be funded or governed by vendor contracts (implementation contracts, consulting agreements). The contract_number STRING should normalize to it_contract_id FK. This links project manage',
    `employee_id` BIGINT COMMENT 'Unique identifier of the senior business leader serving as executive sponsor and primary decision authority for the project.',
    `org_unit_id` BIGINT COMMENT 'FK to hr.org_unit',
    `sport_id` BIGINT COMMENT 'Foreign key linking to athletics.sport. Business justification: Sport-specific system implementation projects: football recruiting CRM deployment, basketball video analysis platform upgrade, baseball statistics tracking system. Project management and resource allo',
    `tertiary_it_business_sponsor_employee_id` BIGINT COMMENT 'FK to hr.employee',
    `parent_it_project_id` BIGINT COMMENT 'Self-referencing FK on it_project (parent_it_project_id)',
    `accessibility_review_completed` BOOLEAN COMMENT 'Indicates whether the project deliverables have been reviewed for compliance with Section 508 and WCAG 2.1 accessibility standards.',
    `actual_end_date` DATE COMMENT 'Actual date when project was completed and formally closed. Null if project is still in progress.',
    `actual_start_date` DATE COMMENT 'Actual date when project work commenced. Null if project has not yet started.',
    `budget_committed` DECIMAL(18,2) COMMENT 'Amount of budget obligated through purchase orders, contracts, or other commitments but not yet expended. Expressed in institutional base currency (USD).',
    `budget_spent_to_date` DECIMAL(18,2) COMMENT 'Cumulative actual expenditures incurred on the project from inception through the current reporting period. Expressed in institutional base currency (USD).',
    `business_justification` STRING COMMENT 'Executive summary of the business case, including problem statement, expected benefits, return on investment, and strategic alignment rationale.',
    `change_management_required` BOOLEAN COMMENT 'Indicates whether formal organizational change management activities (training, communication, stakeholder engagement) are required for successful adoption.',
    `complexity_score` STRING COMMENT 'Quantitative complexity rating (1-10 scale) based on technical difficulty, number of integrations, organizational units impacted, and change management requirements. Higher scores indicate greater complexity.',
    `compliance_impact_flag` BOOLEAN COMMENT 'Indicates whether the project has implications for regulatory compliance (FERPA, HIPAA, PCI-DSS, accessibility, data privacy, financial reporting).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this IT project record was first created in the project portfolio management system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all budget and cost amounts. Typically USD for U.S. higher education institutions.. Valid values are `^[A-Z]{3}$`',
    `forecast_completion_date` DATE COMMENT 'Current projected completion date based on progress to date and remaining work estimates. Updated regularly during project execution.',
    `funding_source` STRING COMMENT 'Primary source of financial resources for the project: institutional operating budget, capital budget allocation, external grant, auxiliary enterprise funds, restricted endowment or gift funds, or bond proceeds.. Valid values are `operating_budget|capital_budget|grant|auxiliary|restricted_fund|bond_proceeds`',
    `governance_approval_date` DATE COMMENT 'Date when the IT governance committee or steering committee formally approved the project charter and authorized project initiation.',
    `governance_review_frequency` STRING COMMENT 'Cadence at which the project status is formally reviewed by governance committee or steering committee.. Valid values are `weekly|biweekly|monthly|quarterly|milestone_based`',
    `impacted_system_count` STRING COMMENT 'Number of enterprise applications or IT systems that will be modified, integrated, or replaced as part of this project.',
    `impacted_user_count` STRING COMMENT 'Estimated number of faculty, staff, students, or external users who will be directly affected by the project deliverables.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the person who last updated this project record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this IT project record was most recently updated.',
    `lessons_learned` STRING COMMENT 'Post-project retrospective summary capturing what went well, what could be improved, and recommendations for future projects. Populated upon project closeout.',
    `planned_end_date` DATE COMMENT 'Originally approved date when project was scheduled to complete and close, as documented in the project charter.',
    `planned_start_date` DATE COMMENT 'Originally approved date when project work was scheduled to begin, as documented in the project charter.',
    `priority_level` STRING COMMENT 'Institutional priority ranking assigned by IT governance committee based on strategic value, risk mitigation, and resource constraints.. Valid values are `critical|high|medium|low`',
    `project_category` STRING COMMENT 'Functional area or system domain that the project primarily impacts: Enterprise Resource Planning (ERP), Student Information System (SIS), Human Capital Management (HCM), financial systems, research administration, Learning Management System (LMS), Customer Relationship Management (CRM), IT infrastructure, cybersecurity, business intelligence and analytics, or regulatory compliance. [ENUM-REF-CANDIDATE: erp|student_systems|hr_systems|financial_systems|research_systems|lms|crm|infrastructure|security|analytics|compliance — 11 candidates stripped; promote to reference product]',
    `project_code` STRING COMMENT 'Business-assigned unique alphanumeric code for the IT project, used for tracking and reporting across institutional systems.. Valid values are `^[A-Z]{2,4}-[0-9]{4,6}$`',
    `project_description` STRING COMMENT 'Detailed narrative description of the project scope, objectives, deliverables, and expected business outcomes.',
    `project_name` STRING COMMENT 'Full descriptive name of the IT project as approved by governance committee.',
    `project_phase` STRING COMMENT 'Current lifecycle phase of the IT project following PMI methodology: initiation (charter and stakeholder identification), planning (scope, schedule, budget definition), execution (deliverable production), monitoring (performance tracking and control), or closeout (final acceptance and lessons learned).. Valid values are `initiation|planning|execution|monitoring|closeout`',
    `project_status` STRING COMMENT 'Current health and progress status of the IT project: on-track (meeting milestones and budget), at-risk (potential issues identified), delayed (behind schedule), on-hold (temporarily paused), completed (successfully closed), or cancelled (terminated before completion).. Valid values are `on_track|at_risk|delayed|on_hold|completed|cancelled`',
    `project_type` STRING COMMENT 'Classification of the IT project by its primary objective: system implementation, upgrade, infrastructure enhancement, cybersecurity initiative, process improvement, system integration, data migration, or system decommission. [ENUM-REF-CANDIDATE: implementation|upgrade|infrastructure|security|process_improvement|integration|migration|decommission — 8 candidates stripped; promote to reference product]',
    `risk_rating` STRING COMMENT 'Overall project risk assessment considering technical complexity, organizational change impact, resource availability, and external dependencies.. Valid values are `low|medium|high|critical`',
    `security_review_completed` BOOLEAN COMMENT 'Indicates whether the institutional information security office has completed a security risk assessment and approved the project design.',
    `strategic_alignment_category` STRING COMMENT 'Primary institutional strategic goal that this IT project supports: student success and retention, operational excellence and efficiency, research advancement and innovation, financial sustainability, regulatory compliance and risk mitigation, or digital transformation and modernization.. Valid values are `student_success|operational_excellence|research_advancement|financial_sustainability|regulatory_compliance|digital_transformation`',
    `total_approved_budget` DECIMAL(18,2) COMMENT 'Total project budget approved by governance committee, including all phases, labor, software, hardware, consulting, and contingency costs. Expressed in institutional base currency (USD).',
    `vendor_name` STRING COMMENT 'Name of primary external vendor, consultant, or implementation partner supporting the project. Null for internally-resourced projects.',
    CONSTRAINT pk_it_project PRIMARY KEY(`it_project_id`)
) COMMENT 'Master record for every formally approved IT project in the institutional technology project portfolio, including system implementations, infrastructure upgrades, cybersecurity initiatives, and digital transformation programs. Captures project name, project code, project type (implementation, upgrade, infrastructure, security, process improvement), sponsoring department, IT project manager, business project sponsor, project phase (initiation, planning, execution, closeout), planned start date, planned end date, actual start date, actual end date, total approved budget, budget spent to date, project status (on-track, at-risk, delayed, on-hold, completed, cancelled), and strategic alignment category. Supports IT governance, portfolio prioritization, and capital budget reporting.';

CREATE OR REPLACE TABLE `education_ecm`.`technology`.`it_service` (
    `it_service_id` BIGINT COMMENT 'Unique identifier for the IT service record. Primary key.',
    `it_contract_id` BIGINT COMMENT 'Foreign key linking to technology.it_contract. Business justification: IT services may be delivered by external vendors under service contracts (managed services, SaaS subscriptions, outsourcing agreements). The vendor_contract_number STRING should normalize to it_contra',
    `employee_id` BIGINT COMMENT 'Employee identifier of the IT staff member who owns accountability for service delivery, performance, and continuous improvement.',
    `primary_it_modified_by_employee_id` BIGINT COMMENT 'Employee identifier of the IT staff member who last modified this service catalog record.',
    `parent_it_service_id` BIGINT COMMENT 'Self-referencing FK on it_service (parent_it_service_id)',
    `annual_operating_cost` DECIMAL(18,2) COMMENT 'Total annual cost to operate and maintain this IT service, including licensing, infrastructure, and support labor.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether manager or departmental approval is required before users can access or provision this IT service.',
    `authentication_method` STRING COMMENT 'Primary authentication mechanism used to control access to this IT service (SSO = Single Sign-On, SAML = Security Assertion Markup Language, MFA = Multi-Factor Authentication). [ENUM-REF-CANDIDATE: sso|ldap|saml|oauth|local|mfa|federated — 7 candidates stripped; promote to reference product]',
    `availability_target_percent` DECIMAL(18,2) COMMENT 'Target uptime percentage for this service as defined in the SLA (e.g., 99.9% for mission-critical services).',
    `backup_frequency` STRING COMMENT 'Frequency at which data associated with this IT service is backed up for disaster recovery and business continuity purposes.. Valid values are `real_time|hourly|daily|weekly|monthly|none`',
    `contract_expiration_date` DATE COMMENT 'Date when the current vendor contract or licensing agreement expires, requiring renewal or replacement decision.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `cost_recovery_model` STRING COMMENT 'Financial model used to fund and recover costs for this IT service (centrally funded = no user charges, chargeback = departmental billing, grant-funded = research grant support).. Valid values are `centrally_funded|chargeback|grant_funded|hybrid|cost_share`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this IT service record was first created in the service catalog system.',
    `data_classification_level` STRING COMMENT 'Highest level of data sensitivity that this IT service is authorized to process or store, per institutional data governance policy.. Valid values are `public|internal|confidential|restricted`',
    `disaster_recovery_tier` STRING COMMENT 'Business continuity tier indicating recovery time objective (RTO) and recovery point objective (RPO) for this service (tier 0 = mission-critical, immediate recovery; tier 4 = non-critical, extended recovery acceptable).. Valid values are `tier_0|tier_1|tier_2|tier_3|tier_4`',
    `documentation_url` STRING COMMENT 'URL to the knowledge base, user guide, or documentation portal for this IT service.',
    `ferpa_applicable_flag` BOOLEAN COMMENT 'Indicates whether this IT service processes or stores student education records subject to FERPA privacy protections.',
    `hipaa_applicable_flag` BOOLEAN COMMENT 'Indicates whether this IT service processes or stores protected health information (PHI) subject to HIPAA regulations (applicable to university health centers and medical schools).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this IT service record was most recently updated or modified.',
    `last_review_date` DATE COMMENT 'Date of the most recent service review or assessment conducted by IT governance or service management team.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next service review or assessment to evaluate performance, costs, and alignment with institutional needs.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or special instructions related to this IT service for internal IT staff reference.',
    `pci_dss_applicable_flag` BOOLEAN COMMENT 'Indicates whether this IT service processes, stores, or transmits payment card data subject to PCI DSS compliance requirements.',
    `planned_maintenance_window` STRING COMMENT 'Scheduled time window for routine maintenance activities (e.g., Sunday 2:00 AM - 6:00 AM EST, First Saturday of each month).',
    `primary_user_population` STRING COMMENT 'Primary institutional community segment that this IT service is designed to serve. [ENUM-REF-CANDIDATE: all_users|students|faculty|staff|researchers|administrators|alumni|guests — 8 candidates stripped; promote to reference product]',
    `self_service_enabled_flag` BOOLEAN COMMENT 'Indicates whether users can request, provision, or configure this IT service through self-service portal without IT staff intervention.',
    `service_catalog_visibility` STRING COMMENT 'Visibility level of this service in the institutional IT service catalog (public = visible to all users, restricted = visible to specific populations, hidden = not displayed but available).. Valid values are `public|restricted|internal|hidden`',
    `service_category` STRING COMMENT 'High-level classification of the IT service type for catalog organization and reporting. [ENUM-REF-CANDIDATE: infrastructure|application|platform|security|support|communication|collaboration|research_computing|classroom_technology|identity_access — 10 candidates stripped; promote to reference product]',
    `service_code` STRING COMMENT 'Unique business identifier code for the IT service used in service catalog and billing systems (e.g., EMAIL-001, LMS-CANVAS, VPN-STD).. Valid values are `^[A-Z0-9]{4,12}$`',
    `service_delivery_model` STRING COMMENT 'Technical delivery model for the IT service (on-premise = institutional data center, cloud SaaS = vendor-hosted application, hybrid = mixed environment).. Valid values are `on_premise|cloud_saas|cloud_iaas|cloud_paas|hybrid|managed_service`',
    `service_description` STRING COMMENT 'Detailed business description of the IT service, including capabilities, features, and intended use cases for the institutional community.',
    `service_launch_date` DATE COMMENT 'Date when this IT service was first made available to the institutional community.',
    `service_name` STRING COMMENT 'Official name of the IT service as presented in the institutional service catalog (e.g., Email and Collaboration, Canvas Learning Management System, Campus Wi-Fi).',
    `service_retirement_date` DATE COMMENT 'Planned or actual date when this IT service was or will be decommissioned and removed from the service catalog.',
    `service_status` STRING COMMENT 'Current operational status of the IT service indicating availability and health state.. Valid values are `active|limited|degraded|maintenance|retired|planned`',
    `service_url` STRING COMMENT 'Primary web URL where users access this IT service (e.g., https://canvas.university.edu, https://email.university.edu).',
    `sla_tier` STRING COMMENT 'Service level tier indicating the priority and response time commitments for this service (gold = mission-critical, silver = business-critical, bronze = standard).. Valid values are `gold|silver|bronze|standard|basic`',
    `support_email` STRING COMMENT 'Primary email address for users to request support or report issues with this IT service.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `support_phone` STRING COMMENT 'Primary phone number for users to contact the service desk for assistance with this IT service.',
    `support_team_name` STRING COMMENT 'Name of the IT support team or department responsible for incident resolution and service requests related to this service.',
    `vendor_name` STRING COMMENT 'Name of the primary vendor or software provider for this IT service (null if internally developed or open-source).',
    CONSTRAINT pk_it_service PRIMARY KEY(`it_service_id`)
) COMMENT 'Master catalog record for every IT service formally offered to the institutional community through the IT service catalog, including email and collaboration, network connectivity, identity and access, learning management, research computing, classroom technology, printing, and cloud storage. Captures service name, service category, service description, service owner, support team, SLA tier (gold, silver, bronze), standard availability target (e.g., 99.9%), planned maintenance window, service status (active, limited, degraded, retired), cost recovery model (centrally funded, chargeback, grant-funded), and primary user population. Serves as the SSOT for the IT service catalog and underpins SLA reporting and service costing.';

CREATE OR REPLACE TABLE `education_ecm`.`technology`.`it_service_outage` (
    `it_service_outage_id` BIGINT COMMENT 'Unique identifier for the IT service outage event record.',
    `athletic_facility_id` BIGINT COMMENT 'Foreign key linking to athletics.athletic_facility. Business justification: Facility-specific IT service outages: video board failures during games, ticketing kiosk outages, WiFi outages in stadiums, scoreboard system failures. Operations and incident management require facil',
    `change_request_id` BIGINT COMMENT 'Foreign key linking to technology.change_request. Business justification: Service outages may be caused by changes (planned maintenance or failed changes). The change_request_number STRING should normalize to change_request_id FK. This links service availability to change m',
    `incident_id` BIGINT COMMENT 'Foreign key linking to technology.incident. Business justification: Service outages generate incident tickets for tracking and resolution. The incident_ticket_number STRING should normalize to incident_id FK. This links service availability management to incident mana',
    `it_service_id` BIGINT COMMENT 'Reference to the IT service that experienced the outage (e.g., Student Information System (SIS), Learning Management System (LMS), email, network, authentication service).',
    `employee_id` BIGINT COMMENT 'Reference to the primary IT technician or engineer assigned to lead the outage resolution effort.',
    `related_it_service_outage_id` BIGINT COMMENT 'Self-referencing FK on it_service_outage (related_it_service_outage_id)',
    `affected_campus_locations` STRING COMMENT 'Comma-separated list of campus locations or buildings impacted by the outage. Null if the outage affected all locations or was service-wide.',
    `affected_user_count_estimate` STRING COMMENT 'Estimated number of users (students, faculty, staff) impacted by the outage, used for prioritization and communication planning.',
    `assigned_support_team` STRING COMMENT 'Name of the IT support team or group responsible for resolving the outage (e.g., Network Operations, Database Administration, Application Support).',
    `business_impact_description` STRING COMMENT 'Narrative description of the operational and academic impact of the outage on institutional functions such as course registration, grade submission, research activities, or administrative operations.',
    `communication_channel` STRING COMMENT 'Comma-separated list of channels used to notify users about the outage (e.g., email, SMS, status page, social media, emergency notification system).',
    `communication_sent_flag` BOOLEAN COMMENT 'Indicates whether proactive communication was sent to the affected user community about the outage through institutional channels (email, status page, alerts).',
    `communication_timestamp` TIMESTAMP COMMENT 'Date and time when the first outage notification was sent to users, used to measure communication timeliness.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this outage record was first created in the IT Service Management (ITSM) system.',
    `detected_by_source` STRING COMMENT 'Method or channel through which the outage was first identified, used to evaluate monitoring effectiveness.. Valid values are `monitoring_system|user_report|service_desk|automated_alert|vendor_notification`',
    `detected_timestamp` TIMESTAMP COMMENT 'Date and time when the outage was first detected by IT staff or monitoring systems. May differ from start_timestamp if there was a detection delay.',
    `duration_minutes` DECIMAL(18,2) COMMENT 'Total elapsed time of the outage in minutes, calculated from start to end timestamp. Used for Service Level Agreement (SLA) availability calculations and trend analysis.',
    `end_timestamp` TIMESTAMP COMMENT 'Date and time when the service was fully restored to normal operation. Null if the outage is still active.',
    `estimated_financial_impact` DECIMAL(18,2) COMMENT 'Estimated financial cost of the outage including lost productivity, refunds, penalties, or revenue impact, expressed in the institutional base currency.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this outage record was most recently updated, used for audit trail and data quality monitoring.',
    `outage_number` STRING COMMENT 'Human-readable business identifier for the outage event, typically auto-generated by the IT Service Management (ITSM) system for tracking and communication purposes.',
    `outage_status` STRING COMMENT 'Current lifecycle state of the outage event in the incident management workflow.. Valid values are `active|resolved|monitoring|closed`',
    `outage_type` STRING COMMENT 'Classification of the outage event indicating whether it was scheduled maintenance, an unexpected failure, or a performance degradation.. Valid values are `planned_maintenance|unplanned_outage|partial_degradation|emergency_maintenance`',
    `post_outage_review_completed_flag` BOOLEAN COMMENT 'Indicates whether a formal post-incident review or post-mortem analysis was conducted to identify lessons learned and preventive actions.',
    `post_outage_review_date` DATE COMMENT 'Date when the post-incident review meeting was held to analyze the outage and document improvement opportunities.',
    `preventive_action_description` STRING COMMENT 'Detailed description of the recommended preventive measures, configuration changes, or infrastructure upgrades identified to prevent similar outages.',
    `preventive_action_required_flag` BOOLEAN COMMENT 'Indicates whether the post-outage review identified specific preventive actions or infrastructure improvements needed to avoid recurrence.',
    `problem_ticket_number` STRING COMMENT 'Reference number of the linked problem record created to investigate recurring or chronic outage patterns for this service.',
    `resolution_notes` STRING COMMENT 'Detailed technical notes documenting the steps taken to resolve the outage, including troubleshooting actions, configuration changes, and restoration procedures.',
    `response_timestamp` TIMESTAMP COMMENT 'Date and time when IT staff began actively working on the outage resolution, used to calculate response time metrics.',
    `root_cause_category` STRING COMMENT 'High-level classification of the underlying cause of the outage, determined through post-incident analysis.. Valid values are `hardware_failure|software_bug|network_issue|configuration_error|capacity_overload|security_incident`',
    `root_cause_description` STRING COMMENT 'Detailed narrative explanation of the technical root cause identified during post-outage investigation, including contributing factors and failure points.',
    `severity_level` STRING COMMENT 'Business impact classification of the outage based on the scope of affected users and criticality of the service to institutional operations.. Valid values are `critical|high|medium|low`',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the outage duration or response time exceeded the committed Service Level Agreement (SLA) targets for this service.',
    `sla_target_availability_percent` DECIMAL(18,2) COMMENT 'The committed uptime percentage target for this service as defined in the Service Level Agreement (SLA), typically expressed as a value like 99.9 percent.',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the service outage or degradation began, representing the actual business event time when users first experienced service unavailability.',
    `vendor_involved_flag` BOOLEAN COMMENT 'Indicates whether a third-party vendor or cloud service provider was involved in the outage cause or resolution.',
    `vendor_name` STRING COMMENT 'Name of the external vendor or service provider whose infrastructure or service contributed to the outage.',
    `vendor_ticket_number` STRING COMMENT 'Reference number of the support ticket opened with the external vendor for escalation and resolution assistance.',
    `workaround_available_flag` BOOLEAN COMMENT 'Indicates whether a temporary workaround or alternative access method was provided to users during the outage.',
    `workaround_description` STRING COMMENT 'Detailed explanation of the temporary workaround or alternative procedure provided to users to minimize business impact during the outage.',
    CONSTRAINT pk_it_service_outage PRIMARY KEY(`it_service_outage_id`)
) COMMENT 'Transactional record of every planned or unplanned IT service outage or degradation event, capturing the affected IT service, outage type (planned maintenance, unplanned outage, partial degradation), start timestamp, end timestamp, total duration in minutes, affected user population estimate, root cause category, linked incident or change request reference, communication sent flag, and post-outage review completion flag. Enables service availability calculation against SLA targets, trend analysis for chronic outage patterns, and institutional communication planning during major outages.';

CREATE OR REPLACE TABLE `education_ecm`.`technology`.`it_contract` (
    `it_contract_id` BIGINT COMMENT 'Unique identifier for the IT contract record. Primary key for the IT contract entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Contracts are charged to specific departments for budget accountability. Real business process: departmental budget tracking, decentralized IT procurement, contract cost allocation to academic/adminis',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Contracts must be funded from appropriate fund sources with proper restrictions. Real business process: ensuring contract payments comply with fund purpose restrictions, auxiliary enterprise accountin',
    `finance_vendor_id` BIGINT COMMENT 'Foreign key reference to the vendor master record in the finance or procurement domain, linking this IT contract to the institutional vendor registry.',
    `identity_account_id` BIGINT COMMENT 'The user identifier of the person who created this contract record in the system. Used for audit trail purposes.',
    `last_modified_by_user_identity_account_id` BIGINT COMMENT 'The user identifier of the person who most recently modified this contract record. Used for audit trail purposes.',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: IT contracts generate recurring expenses posted to specific GL accounts. Real business process: monthly contract expense accrual, budget vs actual variance analysis, financial statement preparation, n',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the employee who is the designated business owner of this contract. This individual is responsible for contract performance monitoring, vendor relationship management, and renewal decisions.',
    `primary_it_relationship_manager_employee_id` BIGINT COMMENT 'Foreign key reference to the IT staff member who serves as the primary relationship manager for this vendor contract. This individual coordinates technical requirements, service delivery, and escalations.',
    `renewed_it_contract_id` BIGINT COMMENT 'Self-referencing FK on it_contract (renewed_it_contract_id)',
    `annual_cost` DECIMAL(18,2) COMMENT 'The annualized cost of the contract, representing the average yearly expenditure. For multi-year contracts, this is typically the total contract value divided by the number of years. For contracts with variable pricing, this represents the estimated or budgeted annual spend.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews for an additional term unless explicitly terminated or non-renewed by either party. True if auto-renewal clause is present, false otherwise.',
    `business_associate_agreement_flag` BOOLEAN COMMENT 'Indicates whether a HIPAA Business Associate Agreement is in place for this contract. Required when the vendor will have access to protected health information (PHI) from university health centers or medical schools. True if BAA is executed, false otherwise.',
    `contract_description` STRING COMMENT 'Detailed narrative description of the scope, deliverables, and purpose of the IT contract. Includes information about the systems, services, or infrastructure covered by the agreement.',
    `contract_document_url` STRING COMMENT 'The URL or file path to the executed contract document stored in the institutional document management system or contract repository.',
    `contract_end_date` DATE COMMENT 'The date on which the contract term expires. May be null for open-ended agreements or contracts with indefinite terms subject to termination clauses.',
    `contract_number` STRING COMMENT 'The externally-known business identifier for the contract, typically assigned by procurement or vendor management systems. Used for reference in communications, invoices, and audit trails.',
    `contract_start_date` DATE COMMENT 'The date on which the contract becomes effective and the vendor begins providing services or the institution begins incurring obligations under the agreement.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the IT contract. Indicates whether the contract is currently in force (active), awaiting renewal decision (pending_renewal), past its end date (expired), ended early (terminated), not yet executed (draft), or temporarily paused (suspended).. Valid values are `active|pending_renewal|expired|terminated|draft|suspended`',
    `contract_type` STRING COMMENT 'Classification of the IT contract by service or product category. Distinguishes between hardware maintenance agreements, software subscriptions, professional services engagements, managed service agreements, and cloud service models (Infrastructure as a Service, Platform as a Service, Software as a Service). [ENUM-REF-CANDIDATE: hardware_maintenance|software_subscription|professional_services|managed_service|cloud_iaas|cloud_paas|cloud_saas — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this contract record was first created in the IT contract management system. Used for audit trail and data lineage purposes.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which contract amounts are denominated (e.g., USD, EUR, GBP, CAD).. Valid values are `^[A-Z]{3}$`',
    `data_privacy_compliance_flag` BOOLEAN COMMENT 'Indicates whether the contract includes data privacy and security provisions compliant with FERPA, HIPAA (if applicable), and other relevant data protection regulations. True if compliant provisions are present, false otherwise.',
    `department_code` STRING COMMENT 'The organizational department code to which this contract is assigned for budgeting and cost allocation purposes. Typically represents the IT division or a specific IT functional area.',
    `insurance_requirement_met_flag` BOOLEAN COMMENT 'Indicates whether the vendor has provided proof of required insurance coverage (general liability, professional liability, cyber liability, etc.) as specified in the contract terms. True if requirements are met and current, false otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this contract record was most recently updated. Used for audit trail and change tracking purposes.',
    `last_renewal_date` DATE COMMENT 'The date on which the contract was most recently renewed or extended. Null for contracts that have never been renewed.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next formal review of contract performance, pricing, and renewal decision. Typically set based on the renewal notice period to ensure timely action.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special considerations related to the contract. May include information about unique terms, historical context, or operational considerations.',
    `payment_frequency` STRING COMMENT 'The billing and payment cycle for the contract. Indicates how often the institution is invoiced and makes payments to the vendor.. Valid values are `monthly|quarterly|annually|one_time|usage_based`',
    `purchase_order_number` STRING COMMENT 'The purchase order number issued by the procurement office to authorize expenditures under this contract. Links the IT contract to the institutional procurement and accounts payable systems.',
    `renewal_notice_period_days` STRING COMMENT 'The number of days prior to contract expiration by which the institution must provide written notice if it intends to terminate or non-renew the contract. Critical for avoiding unintended auto-renewals.',
    `service_level_agreement_flag` BOOLEAN COMMENT 'Indicates whether the contract includes formal service level agreements with defined performance metrics, uptime guarantees, and remediation terms. True if SLA is present, false otherwise.',
    `termination_for_convenience_flag` BOOLEAN COMMENT 'Indicates whether the contract includes a termination for convenience clause allowing the institution to end the agreement without cause, subject to notice requirements. True if such clause exists, false otherwise.',
    `total_contract_value` DECIMAL(18,2) COMMENT 'The total financial value of the contract over its entire term, including all base fees, recurring charges, and committed expenditures. Excludes variable usage charges unless a minimum commitment is specified.',
    `vendor_contact_email` STRING COMMENT 'The email address of the primary vendor contact for this contract. Used for operational communications and support requests.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `vendor_contact_name` STRING COMMENT 'The name of the primary vendor representative or account manager for this contract. Used for operational communications and issue escalation.',
    `vendor_contact_phone` STRING COMMENT 'The phone number of the primary vendor contact for this contract. Used for urgent communications and escalations.',
    CONSTRAINT pk_it_contract PRIMARY KEY(`it_contract_id`)
) COMMENT 'Master record for every technology vendor contract, maintenance agreement, cloud subscription, and managed service agreement held by the institutions IT division. Captures contract number, vendor name, contract type (hardware maintenance, software subscription, professional services, managed service, cloud IaaS/PaaS/SaaS), contract description, contract start date, contract end date, auto-renewal flag, renewal notice period in days, total contract value, annual cost, payment frequency, contract owner, IT relationship manager, and contract status (active, pending renewal, expired, terminated). Distinct from finance.vendor and finance.purchase_order in that it tracks the ongoing contractual relationship and renewal lifecycle specific to IT agreements.';

CREATE OR REPLACE TABLE `education_ecm`.`technology`.`it_risk` (
    `it_risk_id` BIGINT COMMENT 'Unique identifier for the IT risk record in the institutional risk register.',
    `configuration_item_id` BIGINT COMMENT 'Foreign key linking to technology.configuration_item. Business justification: IT risks should be linkable to the specific configuration items they threaten. The it_risk table currently has an affected_systems string field, which is a denormalized list. Normalizing this to a F',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to technology.enterprise_application. Business justification: IT risks should be linkable to the applications they affect. Application-specific risks (e.g., risk of ERP system data breach, risk of LMS vendor discontinuation) are common in enterprise IT risk ',
    `it_service_id` BIGINT COMMENT 'Foreign key linking to technology.it_service. Business justification: IT risks should be linkable to the services they threaten. Risk management in higher education IT focuses on service continuity (e.g., risk of email service disruption, risk of student portal unava',
    `audit_finding_id` BIGINT COMMENT 'Identifier of a related internal or external audit finding that identified or contributed to this risk, supporting compliance and governance reporting.',
    `incident_id` BIGINT COMMENT 'Identifier of a related cybersecurity incident, service disruption, or operational event that triggered or is associated with this risk, enabling traceability between risk management and incident response.',
    `employee_id` BIGINT COMMENT 'FK to hr.employee',
    `primary_it_employee_id` BIGINT COMMENT 'Identifier of the individual (typically a senior IT leader, department head, or business unit owner) who is accountable for managing, monitoring, and mitigating this risk.',
    `parent_it_risk_id` BIGINT COMMENT 'Self-referencing FK on it_risk (parent_it_risk_id)',
    `actual_remediation_date` DATE COMMENT 'Actual date on which the risk mitigation activities were completed and verified, used for tracking remediation performance and compliance.',
    `business_continuity_impact_flag` BOOLEAN COMMENT 'Indicator of whether the risk, if realized, would disrupt critical institutional operations or services, affecting teaching, research, student services, or administrative functions.',
    `compliance_framework` STRING COMMENT 'Regulatory, legal, or industry framework(s) to which this risk is relevant, such as FERPA (Family Educational Rights and Privacy Act), HIPAA (Health Insurance Portability and Accountability Act), NIST Cybersecurity Framework (CSF), ISO 27001, PCI DSS (Payment Card Industry Data Security Standard), or GLBA (Gramm-Leach-Bliley Act).',
    `control_description` STRING COMMENT 'Detailed description of existing or planned controls, safeguards, countermeasures, or mitigation strategies implemented to reduce the likelihood or impact of the risk (e.g., multi-factor authentication (MFA), encryption, access controls, monitoring, training).',
    `control_effectiveness` STRING COMMENT 'Assessment of how well the implemented controls are functioning to mitigate the risk: effective (controls are working as intended), partially effective (controls provide some mitigation but gaps remain), ineffective (controls are not reducing risk), or not implemented (controls are planned but not yet in place).. Valid values are `effective|partially_effective|ineffective|not_implemented`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk record was first created in the IT risk register system, supporting audit trail and data lineage requirements.',
    `data_breach_risk_flag` BOOLEAN COMMENT 'Indicator of whether the risk involves potential unauthorized access, disclosure, or loss of sensitive institutional data, including student records (FERPA), health information (HIPAA), payment card data (PCI DSS), or research data.',
    `escalation_level` STRING COMMENT 'Level of organizational escalation required for this risk based on its severity and impact: operational (managed by IT operations), tactical (requires IT leadership attention), strategic (requires senior leadership or CIO attention), or executive (requires board or president attention).. Valid values are `operational|tactical|strategic|executive`',
    `financial_impact_estimate` DECIMAL(18,2) COMMENT 'Estimated financial cost or loss to the institution if the risk materializes, including direct costs (remediation, fines, legal fees) and indirect costs (reputational damage, lost revenue, operational disruption), expressed in US dollars (USD).',
    `impact_rating` STRING COMMENT 'Assessment of the potential adverse effect on institutional operations, assets, or individuals if the risk materializes, rated on a scale of 1 (negligible) to 5 (catastrophic), considering financial, reputational, operational, and compliance dimensions.',
    `inherent_risk_score` STRING COMMENT 'Calculated risk score before any controls or mitigations are applied, typically computed as likelihood_rating multiplied by impact_rating, representing the raw exposure level.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update or modification to this risk record, supporting change tracking and audit trail requirements.',
    `last_review_date` DATE COMMENT 'Date of the most recent review or reassessment of the risk, including updates to likelihood, impact, controls, and status.',
    `likelihood_rating` STRING COMMENT 'Qualitative or quantitative assessment of the probability that the risk event will occur, rated on a scale of 1 (very unlikely) to 5 (very likely), based on threat intelligence, historical data, and environmental factors.',
    `mitigation_plan` STRING COMMENT 'Detailed action plan outlining specific steps, resources, timelines, and responsibilities for implementing risk mitigation controls or remediation activities.',
    `modified_by` STRING COMMENT 'Username or identifier of the individual who last modified this risk record, supporting accountability and audit trail requirements.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review or reassessment of the risk, ensuring ongoing risk management and compliance with institutional policies.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or context related to the risk, including historical information, stakeholder feedback, or special considerations for risk management.',
    `reputational_impact_flag` BOOLEAN COMMENT 'Indicator of whether the risk, if realized, would have significant reputational impact on the institution, affecting student enrollment, donor confidence, faculty recruitment, or public perception.',
    `residual_risk_score` STRING COMMENT 'Calculated risk score after controls and mitigations have been applied, representing the remaining exposure level that the institution must accept or further mitigate.',
    `risk_appetite_alignment` STRING COMMENT 'Assessment of whether the residual risk level aligns with the institutions defined risk appetite or tolerance: within appetite (acceptable level), exceeds appetite (requires additional mitigation or executive acceptance), or requires review (needs further analysis).. Valid values are `within_appetite|exceeds_appetite|requires_review`',
    `risk_category` STRING COMMENT 'Primary classification of the risk type: cybersecurity risks (threats to confidentiality, integrity, availability), operational risks (service disruptions, process failures), vendor risks (third-party dependencies), compliance risks (regulatory violations), disaster recovery risks (business continuity threats), or data privacy risks (FERPA, HIPAA violations).. Valid values are `cybersecurity|operational|vendor|compliance|disaster_recovery|data_privacy`',
    `risk_description` STRING COMMENT 'Comprehensive narrative description of the risk, including the threat source, vulnerability exploited, potential impact on institutional operations, and context for stakeholders.',
    `risk_identification_date` DATE COMMENT 'Date on which the risk was first identified and documented in the institutional IT risk register.',
    `risk_number` STRING COMMENT 'Business-facing unique identifier or reference number for the risk, used in risk register reports and communications with stakeholders.',
    `risk_owner_department` STRING COMMENT 'Department or organizational unit to which the risk owner belongs, providing context for risk ownership and accountability.',
    `risk_source` STRING COMMENT 'Origin or source of the risk identification, such as internal audit, vulnerability scan, penetration test, incident report, compliance assessment, vendor assessment, or strategic planning.',
    `risk_status` STRING COMMENT 'Current lifecycle status of the risk: open (newly identified, awaiting action), mitigating (remediation activities in progress), accepted (risk acknowledged and accepted by leadership), closed (risk fully remediated or no longer applicable), or monitoring (risk under continuous observation).. Valid values are `open|mitigating|accepted|closed|monitoring`',
    `risk_subcategory` STRING COMMENT 'Detailed subcategory or specific classification within the primary risk category, providing granular context for risk analysis and reporting.',
    `risk_title` STRING COMMENT 'Concise title or name of the identified risk, summarizing the threat or vulnerability in business terms.',
    `risk_treatment_strategy` STRING COMMENT 'Strategic approach selected for managing the risk: accept (acknowledge and monitor without further action), mitigate (implement controls to reduce likelihood or impact), transfer (shift risk to third party via insurance or contract), or avoid (eliminate the risk by discontinuing the activity or system).. Valid values are `accept|mitigate|transfer|avoid`',
    `target_remediation_date` DATE COMMENT 'Planned or target date by which the risk mitigation activities are expected to be completed and the residual risk reduced to an acceptable level.',
    `third_party_vendor_name` STRING COMMENT 'Name of the third-party vendor, service provider, or partner associated with this risk, applicable for vendor risks, supply chain risks, or outsourced service risks.',
    CONSTRAINT pk_it_risk PRIMARY KEY(`it_risk_id`)
) COMMENT 'Master record for every identified technology risk in the institutional IT risk register, covering cybersecurity risks, operational risks, vendor risks, compliance risks, and disaster recovery risks. Captures risk identifier, risk title, risk category, risk description, affected systems or services, likelihood rating (1-5), impact rating (1-5), inherent risk score, control description, residual risk score, risk owner, risk treatment strategy (accept, mitigate, transfer, avoid), mitigation plan, target remediation date, and current risk status (open, mitigating, accepted, closed). Feeds institutional enterprise risk management (ERM) reporting and cybersecurity framework assessments (NIST CSF, ISO 27001).';

CREATE OR REPLACE TABLE `education_ecm`.`technology`.`it_sla_record` (
    `it_sla_record_id` BIGINT COMMENT 'Unique identifier for the IT SLA performance record. Primary key for the IT SLA record entity.',
    `it_service_id` BIGINT COMMENT 'Reference to the IT service for which SLA performance is being measured. Links to the IT service catalog entry.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who is the designated service owner responsible for the overall performance and governance of this IT service.',
    `prior_it_sla_record_id` BIGINT COMMENT 'Self-referencing FK on it_sla_record (prior_it_sla_record_id)',
    `actual_availability_percentage` DECIMAL(18,2) COMMENT 'The measured availability of the IT service during the reporting period, expressed as a percentage. Calculated as (total time - downtime) / total time * 100.',
    `actual_first_contact_resolution_percentage` DECIMAL(18,2) COMMENT 'The actual measured percentage of incidents or service requests resolved on first contact during the reporting period.',
    `actual_mttr_hours` DECIMAL(18,2) COMMENT 'The actual measured mean time to resolve incidents for this IT service during the reporting period, measured in hours. Calculated as total resolution time divided by number of incidents.',
    `actual_response_time_seconds` STRING COMMENT 'The actual measured average response time for the IT service during the reporting period, measured in seconds.',
    `availability_target_percentage` DECIMAL(18,2) COMMENT 'The contractual or committed availability target for the IT service during the reporting period, expressed as a percentage (e.g., 99.95 for 99.95% uptime).',
    `change_success_rate_percentage` DECIMAL(18,2) COMMENT 'The percentage of changes to this IT service that were successfully implemented without causing incidents during the reporting period. Calculated as successful changes divided by total changes.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this SLA performance record was first created in the system. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `customer_satisfaction_score` DECIMAL(18,2) COMMENT 'The average customer satisfaction score for this IT service during the reporting period, typically measured on a scale of 1.00 to 5.00 based on user surveys.',
    `first_contact_resolution_target_percentage` DECIMAL(18,2) COMMENT 'The target percentage of incidents or service requests resolved on first contact during the reporting period, without escalation or follow-up.',
    `governance_review_date` DATE COMMENT 'The date this SLA performance record was reviewed by institutional IT governance bodies or leadership.',
    `improvement_action_description` STRING COMMENT 'Detailed description of the improvement actions or investments planned or required to address SLA performance gaps for this IT service.',
    `improvement_action_required_flag` BOOLEAN COMMENT 'Indicates whether this IT service requires improvement investment or corrective action based on SLA performance. True if performance is below acceptable thresholds.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this SLA performance record was most recently updated or modified. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `major_incidents_count` STRING COMMENT 'The number of major incidents (high-impact, high-urgency incidents affecting multiple users or critical services) that occurred for this IT service during the reporting period.',
    `mttr_target_hours` DECIMAL(18,2) COMMENT 'The target mean time to resolve incidents for this IT service during the reporting period, measured in hours. Represents the committed average resolution time.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding this SLA performance record, including explanations for breaches or exceptional circumstances.',
    `planned_downtime_minutes` STRING COMMENT 'The number of minutes of planned or scheduled downtime for maintenance during the reporting period. Typically excluded from SLA availability calculations.',
    `reporting_period_end_date` DATE COMMENT 'The last day of the reporting period for which SLA performance is measured (typically the last day of a month or quarter).',
    `reporting_period_start_date` DATE COMMENT 'The first day of the reporting period for which SLA performance is measured (typically the first day of a month or quarter).',
    `reporting_period_type` STRING COMMENT 'The granularity of the reporting period for SLA measurement (monthly, quarterly, annual, or weekly).. Valid values are `monthly|quarterly|annual|weekly`',
    `reporting_status` STRING COMMENT 'The current status of this SLA performance record in the reporting workflow (draft, submitted for review, approved by governance, or published to stakeholders).. Valid values are `draft|submitted|approved|published`',
    `response_time_target_seconds` STRING COMMENT 'The target average response time for the IT service during the reporting period, measured in seconds. Represents the committed time for the service to respond to user requests.',
    `sla_breach_count` STRING COMMENT 'The total number of SLA breaches or violations that occurred for this IT service during the reporting period. Each breach represents a failure to meet a specific SLA target.',
    `sla_met_flag` BOOLEAN COMMENT 'Indicates whether the IT service met all SLA targets for the reporting period. True if all targets were met, False if any target was breached.',
    `sla_record_number` STRING COMMENT 'Business-facing unique identifier for this SLA performance record, used in reporting and governance communications.',
    `sla_tier` STRING COMMENT 'The service tier or level of service commitment for this IT service (e.g., platinum for mission-critical services, bronze for best-effort services).. Valid values are `platinum|gold|silver|bronze|standard|basic`',
    `total_downtime_minutes` STRING COMMENT 'The total number of minutes the IT service was unavailable or down during the reporting period. Used to calculate actual availability percentage.',
    `total_incidents_count` STRING COMMENT 'The total number of incidents logged against this IT service during the reporting period.',
    `total_service_requests_count` STRING COMMENT 'The total number of service requests fulfilled for this IT service during the reporting period.',
    `unplanned_downtime_minutes` STRING COMMENT 'The number of minutes of unplanned or unscheduled downtime due to incidents or failures during the reporting period. Counted against SLA availability targets.',
    CONSTRAINT pk_it_sla_record PRIMARY KEY(`it_sla_record_id`)
) COMMENT 'Transactional record capturing the measured SLA performance for each IT service against its defined targets for a given reporting period. Captures IT service reference, reporting period (month/quarter), SLA tier, availability target percentage, actual availability percentage, SLA met flag, mean time to resolve (MTTR) target in hours, actual MTTR in hours, total incidents in period, total service requests in period, customer satisfaction score average, and SLA breach count. Enables IT leadership to report service performance to institutional governance bodies and identify services requiring improvement investment.';

CREATE OR REPLACE TABLE `education_ecm`.`technology`.`it_chargeback` (
    `it_chargeback_id` BIGINT COMMENT 'Unique identifier for the IT chargeback transaction record.',
    `employee_id` BIGINT COMMENT 'The unique identifier of the IT financial manager or department head who approved this chargeback transaction for posting.',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: IT cost recovery must align with fund accounting restrictions (general, auxiliary, restricted). Real business process: ensuring charges comply with fund purpose, auxiliary enterprise accounting, restr',
    `grant_account_id` BIGINT COMMENT 'Foreign key linking to finance.grant_account. Business justification: Sponsored research projects are charged for specialized IT services (HPC, secure storage, cloud). Real business process: grant expenditure tracking, F&A allocation, sponsor billing for direct IT costs',
    `it_service_id` BIGINT COMMENT 'Foreign key linking to technology.it_service. Business justification: IT chargebacks are issued for consumption of specific IT services. The it_service_code and it_service_name STRING fields should normalize to it_service_id FK. This links financial management to the se',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: IT chargeback journal entries post to specific GL accounts for expense classification. Real business process: monthly IT cost allocation postings, financial statement preparation, natural account repo',
    `principal_investigator_id` BIGINT COMMENT 'The unique identifier of the Principal Investigator responsible for the research project being charged. Applicable only when charges are allocated to sponsored research projects.',
    `team_id` BIGINT COMMENT 'Foreign key linking to athletics.team. Business justification: Team-specific IT cost allocation for cloud storage (game film, recruiting video), video analysis software licenses, recruiting platform subscriptions, and support services. Financial reporting require',
    `reversal_it_chargeback_id` BIGINT COMMENT 'Self-referencing FK on it_chargeback (reversal_it_chargeback_id)',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Any post-calculation adjustment to the chargeback amount due to billing corrections, dispute resolutions, or retroactive rate changes. May be positive or negative.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of total IT service cost allocated to this department or project when using allocation formula chargeback method. Null for actual consumption or flat rate methods.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the chargeback transaction was approved for posting to departmental or project budgets.',
    `billing_period_end_date` DATE COMMENT 'The last date of the billing period for which IT service consumption is being charged back.',
    `billing_period_start_date` DATE COMMENT 'The first date of the billing period for which IT service consumption is being charged back.',
    `chargeback_method` STRING COMMENT 'The methodology used to calculate and allocate IT costs to departments or projects. Actual consumption charges based on metered usage; allocation formula distributes shared costs using predefined ratios; flat rate applies fixed periodic charges; tiered rate varies by consumption volume; subscription charges fixed fee for defined service level.. Valid values are `Actual Consumption|Allocation Formula|Flat Rate|Tiered Rate|Subscription`',
    `chargeback_number` STRING COMMENT 'Human-readable business identifier for the chargeback transaction, typically formatted as CHG-YYYYMMDD or similar sequential numbering scheme.. Valid values are `^CHG-[0-9]{8}$`',
    `charged_department_code` STRING COMMENT 'The organizational department code or cost center identifier to which the IT service charges are allocated. May represent academic departments, administrative units, or research projects.. Valid values are `^[A-Z0-9]{4,10}$`',
    `charged_department_name` STRING COMMENT 'The full name of the department, administrative unit, or research project being charged for IT service consumption.',
    `consumption_quantity` DECIMAL(18,2) COMMENT 'The measured quantity of IT service consumed during the billing period. Interpretation depends on the unit of measure (e.g., 500 GB, 100 user seats, 1000 compute hours).',
    `cost_center_code` STRING COMMENT 'The financial cost center code used for budget tracking and financial reporting in the institutional Enterprise Resource Planning (ERP) system.. Valid values are `^[0-9]{6,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this chargeback transaction record was first created in the IT financial system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the charge amount. Typically USD for U.S. higher education institutions.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any discount applied to the chargeback amount, such as volume discounts, promotional credits, or special program subsidies. Reduces the net amount charged.',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator of whether the charged department or project has disputed this chargeback transaction. True indicates an active or resolved dispute exists.',
    `dispute_reason` STRING COMMENT 'The reason provided by the charged department for disputing the chargeback, such as incorrect usage measurement, wrong rate applied, or service not received. Null if no dispute exists.',
    `dispute_resolution_date` DATE COMMENT 'The date when a disputed chargeback was resolved through investigation, adjustment, or mutual agreement. Null if no dispute or dispute is still open.',
    `fiscal_period` STRING COMMENT 'The fiscal period or accounting month within the fiscal year (typically 01-12) to which this chargeback is posted.. Valid values are `^[0-9]{2}$`',
    `fiscal_year` STRING COMMENT 'The institutional fiscal year to which this chargeback transaction is attributed for budget and financial reporting purposes.',
    `invoice_date` DATE COMMENT 'The date the invoice was generated and issued to the charged department or project.',
    `invoice_number` STRING COMMENT 'The invoice reference number generated by the IT financial system or institutional billing system for this chargeback transaction.. Valid values are `^INV-[0-9]{8,10}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this chargeback transaction record was most recently updated or modified.',
    `net_charge_amount` DECIMAL(18,2) COMMENT 'The final net amount charged after applying discounts and adjustments. This is the amount posted to the departmental or project budget.',
    `notes` STRING COMMENT 'Free-text notes providing additional context about the chargeback transaction, such as special circumstances, manual adjustments, or communication with the charged department.',
    `payment_date` DATE COMMENT 'The date when payment or budget transfer was completed for this chargeback transaction. Null if payment is still pending.',
    `payment_due_date` DATE COMMENT 'The date by which payment or budget transfer is expected to be completed for this chargeback transaction.',
    `payment_reference_number` STRING COMMENT 'The reference number or transaction identifier from the financial system confirming the budget transfer or payment for this chargeback.',
    `payment_status` STRING COMMENT 'The current payment status of the chargeback transaction, tracking whether the charged department or project has completed the budget transfer or payment.. Valid values are `Pending|Paid|Partially Paid|Overdue|Disputed|Waived`',
    `project_code` STRING COMMENT 'The research project or grant identifier when IT services are charged to sponsored research activities. Null for non-research departmental charges.',
    `service_category` STRING COMMENT 'The high-level category of IT service being charged, used for cost analysis and budget planning across service portfolios. [ENUM-REF-CANDIDATE: Infrastructure|Application|Security|Support|Communication|Storage|Compute|Network — 8 candidates stripped; promote to reference product]',
    `total_charge_amount` DECIMAL(18,2) COMMENT 'The total dollar amount charged to the department or project for IT service consumption during the billing period. Typically calculated as consumption quantity multiplied by unit rate, with possible adjustments.',
    `transaction_date` DATE COMMENT 'The date when the chargeback transaction was recorded and posted to the departmental or project account.',
    `unit_of_measure` STRING COMMENT 'The unit in which IT service consumption is measured and billed, such as gigabytes for storage, user seats for software licenses, compute hours for virtual machines, or pages for printing services. [ENUM-REF-CANDIDATE: GB|TB|User Seat|Compute Hour|CPU Hour|Transaction|Page|Device|License|Connection — 10 candidates stripped; promote to reference product]',
    `unit_rate` DECIMAL(18,2) COMMENT 'The cost per unit of measure for the IT service during the billing period. Used to calculate total charge amount by multiplying unit rate by consumption quantity.',
    CONSTRAINT pk_it_chargeback PRIMARY KEY(`it_chargeback_id`)
) COMMENT 'Transactional record of IT cost chargeback or cost allocation transactions issued to academic departments, administrative units, and research projects for consumption of centrally provided IT services. Captures billing period, charged department or cost center, IT service consumed, consumption quantity and unit of measure (GB storage, user seats, compute hours, print pages), unit rate, total charge amount, chargeback method (actual consumption, allocation formula, flat rate), invoice reference, and payment status. Supports IT financial transparency, departmental budget planning, and cost recovery for shared IT infrastructure.';

CREATE OR REPLACE TABLE `education_ecm`.`technology`.`it_policy` (
    `it_policy_id` BIGINT COMMENT 'Unique identifier for the IT policy record. Primary key.',
    `identity_account_id` BIGINT COMMENT 'Identifier of the user or system account that last modified this policy record.',
    `employee_id` BIGINT COMMENT 'FK to hr.employee',
    `owner_employee_id` BIGINT COMMENT 'FK to hr.employee',
    `primary_it_employee_id` BIGINT COMMENT 'Identifier of the IT division staff member or executive responsible for maintaining and enforcing this policy.',
    `superseded_policy_it_policy_id` BIGINT COMMENT 'Identifier of the previous policy version that this policy replaces, if applicable. Null if this is the first version.',
    `superseded_it_policy_id` BIGINT COMMENT 'Self-referencing FK on it_policy (superseded_it_policy_id)',
    `acknowledgment_count` STRING COMMENT 'Number of users who have formally acknowledged this policy, used to track compliance with acknowledgment requirements.',
    `acknowledgment_required_flag` BOOLEAN COMMENT 'Indicates whether users in the applicable audience must formally acknowledge that they have read and understood this policy (True) or not (False).',
    `applicable_audience` STRING COMMENT 'Population to whom this policy applies, expressed as a comma-separated list (e.g., all users, faculty, staff, students, IT staff, contractors, vendors). [ENUM-REF-CANDIDATE: all-users|faculty|staff|students|it-staff|contractors|vendors|administrators|researchers — promote to reference product]',
    `approval_authority` STRING COMMENT 'Title or role of the individual or committee that formally approved this policy (e.g., Chief Information Officer, IT Governance Committee, Vice President for Technology).',
    `approval_date` DATE COMMENT 'Date on which the policy was formally approved by the designated authority.',
    `communication_date` DATE COMMENT 'Date on which the policy was communicated to the applicable audience via email, portal announcement, or other channel.',
    `communication_sent_flag` BOOLEAN COMMENT 'Indicates whether notification of this policy has been sent to the applicable audience (True) or not (False).',
    `compliance_framework` STRING COMMENT 'Industry or institutional framework to which this policy aligns (e.g., NIST Cybersecurity Framework, ISO 27001, CIS Controls, EDUCAUSE Top 10 IT Issues).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this policy record was first created in the system.',
    `document_repository_path` STRING COMMENT 'File path or location identifier within the institutional document management system where the authoritative policy document is stored.',
    `document_url` STRING COMMENT 'Web address or document management system link where the full policy document can be accessed by authorized users.',
    `effective_date` DATE COMMENT 'Date on which the policy becomes binding and enforceable across the institution.',
    `enforcement_mechanism` STRING COMMENT 'Primary method by which compliance with this policy is enforced: technical control (automated system enforcement), administrative review (manual oversight), user acknowledgment (signed attestation), audit (periodic compliance check), or none (guideline only).. Valid values are `technical-control|administrative-review|user-acknowledgment|audit|none`',
    `exception_process_description` STRING COMMENT 'Narrative description of the process by which users may request an exception or waiver from this policy, including approval authority and documentation requirements.',
    `expiration_date` DATE COMMENT 'Date on which the policy is scheduled to expire or be retired, if applicable. Null for policies with indefinite duration.',
    `keywords` STRING COMMENT 'Comma-separated list of search keywords or tags to facilitate discovery of this policy in the institutional policy repository (e.g., password, encryption, mobile device, cloud, data classification).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this policy record was most recently updated in the system.',
    `last_review_date` DATE COMMENT 'Date on which the policy was most recently reviewed, regardless of whether changes were made.',
    `next_review_due_date` DATE COMMENT 'Scheduled date by which the policy must undergo its next formal review to ensure continued relevance and compliance.',
    `notes` STRING COMMENT 'Free-text field for additional context, implementation guidance, or administrative notes related to this policy.',
    `policy_category` STRING COMMENT 'Functional area of IT operations that the policy governs: security, access control, data governance, network, acceptable use, bring-your-own-device (BYOD), or remote access. [ENUM-REF-CANDIDATE: security|access-control|data-governance|network|acceptable-use|byod|remote-access — 7 candidates stripped; promote to reference product]',
    `policy_name` STRING COMMENT 'The official title of the IT policy, standard, or procedure (e.g., Acceptable Use Policy, Information Security Policy, Password Standard).',
    `policy_number` STRING COMMENT 'Externally-known unique identifier for the policy, formatted as IT-POL-#### for easy reference in communications and documentation.. Valid values are `^IT-POL-[0-9]{4}$`',
    `policy_status` STRING COMMENT 'Current lifecycle state of the policy: draft (being developed), active (in force), under-review (being revised), retired (no longer applicable), or superseded (replaced by newer version).. Valid values are `draft|active|under-review|retired|superseded`',
    `policy_type` STRING COMMENT 'Classification of the governance document: policy (high-level directive), standard (mandatory specification), procedure (step-by-step instruction), or guideline (recommended practice).. Valid values are `policy|standard|procedure|guideline`',
    `publication_date` DATE COMMENT 'Date on which the policy was officially published and made available to the applicable audience.',
    `regulatory_driver` STRING COMMENT 'External regulation, law, or compliance framework that mandates or influences this policy (e.g., FERPA, HIPAA, PCI-DSS, GLBA, state data breach notification law). Multiple drivers may be listed as comma-separated values.',
    `related_policy_ids` STRING COMMENT 'Comma-separated list of it_policy_id values for policies that are related, complementary, or cross-referenced by this policy.',
    `review_cycle_months` STRING COMMENT 'Frequency in months at which the policy must be reviewed and reaffirmed or revised (e.g., 12 for annual review, 24 for biennial review).',
    `scope_description` STRING COMMENT 'Narrative description of the systems, services, data, or activities covered by this policy (e.g., all university-owned devices, institutional data classified as confidential or restricted, remote access to administrative systems).',
    `version_number` STRING COMMENT 'Semantic version identifier for the policy document (e.g., 1.0, 2.1) to track revisions and updates over time.. Valid values are `^[0-9]+.[0-9]+$`',
    `violation_consequence` STRING COMMENT 'Summary of disciplinary or corrective actions that may result from policy violations (e.g., account suspension, referral to Human Resources, termination of access, legal action).',
    CONSTRAINT pk_it_policy PRIMARY KEY(`it_policy_id`)
) COMMENT 'Master record for every formally adopted IT policy, standard, and procedure governing the institutions technology environment, including acceptable use policy, information security policy, data governance policy, password standard, remote access standard, and bring-your-own-device (BYOD) policy. Captures policy name, policy type (policy, standard, procedure, guideline), policy owner, applicable audience (all users, faculty, staff, students, IT staff), effective date, review cycle in months, next review due date, version number, approval authority, policy status (draft, active, under-review, retired), and regulatory drivers. Distinct from compliance.policy in that it is owned and managed by the IT division and governs technology-specific behaviors.';

CREATE OR REPLACE TABLE `education_ecm`.`technology`.`application_contract_coverage` (
    `application_contract_coverage_id` BIGINT COMMENT 'Unique identifier for this application-contract coverage relationship',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to the enterprise application covered by this contract',
    `it_contract_id` BIGINT COMMENT 'Foreign key linking to the IT contract providing coverage',
    `allocated_annual_cost` DECIMAL(18,2) COMMENT 'The portion of the contracts annual cost allocated to this specific application, used for IT cost allocation and chargeback to owning departments',
    `annual_license_cost` DECIMAL(18,2) COMMENT 'Total annual cost in US dollars for software licenses, subscriptions, and maintenance fees for the application. [Moved from enterprise_application: This attribute in enterprise_application likely represents the cost allocated from a specific contract, which is relationship-specific data that belongs in the association as allocated_annual_cost. An application covered by multiple contracts would have different cost allocations for each.]',
    `contract_application_role` STRING COMMENT 'The type of coverage or service this contract provides for this application (e.g., primary license, maintenance support, cloud subscription, professional services, managed service, infrastructure hosting)',
    `contract_line_item_number` STRING COMMENT 'The specific line item or schedule reference within the contract that covers this application, used for detailed contract administration and invoice reconciliation',
    `coverage_end_date` DATE COMMENT 'The date when this contract stops covering this application, which may differ from the overall contract end date if applications are removed or migrated',
    `coverage_start_date` DATE COMMENT 'The date when this contract began covering this application, which may differ from the overall contract start date if applications are added mid-term',
    `coverage_status` STRING COMMENT 'Current status of this coverage relationship indicating whether the application is actively covered under this contract',
    `license_quantity_allocated` STRING COMMENT 'The number of licenses or seats from this contract allocated to this application, relevant for subscription-based and per-user licensing models',
    `notes` STRING COMMENT 'Free-text notes about special terms, conditions, or considerations for this specific application-contract coverage',
    CONSTRAINT pk_application_contract_coverage PRIMARY KEY(`application_contract_coverage_id`)
) COMMENT 'This association product represents the contractual coverage relationship between enterprise applications and IT vendor contracts. It captures which applications are covered under which contracts for cost allocation, license tracking, and renewal planning. Each record links one enterprise application to one IT contract with attributes that exist only in the context of this coverage relationship, including allocated costs, license quantities, coverage periods, and the role the contract plays for that specific application.. Existence Justification: In higher education IT portfolio management, enterprise applications are frequently covered by multiple vendor contracts simultaneously - for example, an ERP system may have separate contracts for the base software license, maintenance support, cloud hosting infrastructure, and professional services. Conversely, enterprise license agreements and cloud subscription contracts routinely cover multiple applications from the same vendor or technology stack. The business actively manages these coverage relationships for cost allocation, renewal planning, license compliance tracking, and vendor relationship management.';

CREATE OR REPLACE TABLE `education_ecm`.`technology`.`asset_software_installation` (
    `asset_software_installation_id` BIGINT COMMENT 'Unique identifier for this software installation record. Primary key.',
    `it_asset_id` BIGINT COMMENT 'Foreign key linking to the IT asset on which the software is installed',
    `software_license_id` BIGINT COMMENT 'Foreign key linking to the software license under which this installation is authorized',
    `compliance_status` STRING COMMENT 'Assessment of whether this installation is properly licensed and compliant with vendor terms. Explicitly identified in detection reasoning as relationship data. Values: compliant (properly licensed), non_compliant (license violation detected), under_review (compliance audit in progress), exempt (open-source or institutional agreement).',
    `discovery_method` STRING COMMENT 'The method by which this installation was discovered and recorded. Values: automated_scan (SAM tool discovery), manual_entry (IT staff recorded), import (bulk import from external system), self_reported (user-submitted).',
    `installation_date` DATE COMMENT 'The date when the software was installed on the asset. Explicitly identified in detection reasoning as relationship data.',
    `installation_path` STRING COMMENT 'The file system path where the software is installed on the asset. Used for automated discovery validation and troubleshooting.',
    `installation_status` STRING COMMENT 'Current lifecycle status of this software installation. Explicitly identified in detection reasoning as relationship data. Values: active (installed and operational), inactive (installed but not in use), pending_removal (scheduled for uninstallation), uninstalled (removed), failed (installation attempt failed).',
    `installed_by` STRING COMMENT 'The user account or automated system that performed the installation. Used for audit trail and change management tracking.',
    `installed_version` STRING COMMENT 'The specific version number of the software installed on this asset. May differ from the licensed version in software_license if assets are at different patch levels. Critical for security patch management and version compliance.',
    `last_usage_date` DATE COMMENT 'The most recent date when this software was actively used on the asset, if usage tracking is enabled. Used for identifying unused licenses that can be reclaimed.',
    `last_verified_date` DATE COMMENT 'The date when this installation was last verified through automated discovery scan or manual audit. Explicitly identified in detection reasoning as relationship data. Used for compliance reporting and stale installation detection.',
    `license_key_assigned` STRING COMMENT 'The specific license key or activation code assigned to this installation. Explicitly identified in detection reasoning as relationship data. May differ from the master license key in cases of volume licensing.',
    `uninstall_date` DATE COMMENT 'The date when the software was uninstalled or removed from the asset. Explicitly identified in detection reasoning as relationship data. Null for active installations. Enables historical tracking of software deployment lifecycle.',
    CONSTRAINT pk_asset_software_installation PRIMARY KEY(`asset_software_installation_id`)
) COMMENT 'This association product represents the installation relationship between IT assets and software licenses. It captures the operational reality that a single IT asset can have multiple software packages installed (operating system, productivity suite, specialized applications), and a single software license (especially site licenses, concurrent licenses, or multi-seat licenses) can be deployed across multiple physical or virtual assets. Each record represents one software installation on one asset, tracking installation lifecycle, compliance status, and verification history.. Existence Justification: In higher education IT operations, a single IT asset (workstation, server, laptop) routinely has multiple software packages installed simultaneously—operating system, productivity suite, specialized academic applications, security tools. Conversely, a single software license (particularly site licenses, concurrent licenses, or multi-seat volume licenses) is deployed across multiple physical and virtual assets throughout the institution. Software asset management (SAM) systems actively track each installation as a distinct operational record with installation dates, compliance status, version tracking, and verification history.';

CREATE OR REPLACE TABLE `education_ecm`.`technology`.`approval_workflow` (
    `approval_workflow_id` BIGINT COMMENT 'Primary key for approval_workflow',
    `identity_account_id` BIGINT COMMENT 'Identifier of the individual user responsible for maintaining and updating this workflow configuration.',
    `last_modified_by_user_identity_account_id` BIGINT COMMENT 'Identifier of the user who most recently modified this workflow configuration.',
    `notification_template_id` BIGINT COMMENT 'Reference to the communication template used for workflow notifications (e.g., email template ID, message format identifier).',
    `org_unit_id` BIGINT COMMENT 'Identifier of the academic or administrative department that owns and maintains this approval workflow.',
    `previous_version_id` BIGINT COMMENT 'Reference to the prior version of this workflow, enabling version history tracking and rollback capability.',
    `parent_approval_workflow_id` BIGINT COMMENT 'Self-referencing FK on approval_workflow (parent_approval_workflow_id)',
    `allows_parallel_approval` BOOLEAN COMMENT 'Indicates whether multiple approval stages can be processed simultaneously (true) or must be sequential (false).',
    `approval_authority_matrix` STRING COMMENT 'Structured definition of approval authority levels, thresholds, and role-based permissions that govern who can approve at each stage (stored as JSON or structured text).',
    `approval_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of requests submitted through this workflow that result in final approval (vs. rejection or cancellation), used for workflow effectiveness analysis.',
    `approval_stage_count` STRING COMMENT 'Total number of sequential approval stages defined in this workflow (e.g., 1 for single-stage, 3 for three-tier approval).',
    `audit_trail_required` BOOLEAN COMMENT 'Indicates whether this workflow requires comprehensive audit logging of all actions, decisions, and state changes for compliance or governance purposes.',
    `auto_approval_criteria` STRING COMMENT 'Business rules and conditions that trigger automatic approval without human intervention (e.g., Amount < $500 AND Requester in Pre-Approved List).',
    `auto_approval_enabled` BOOLEAN COMMENT 'Indicates whether this workflow supports automatic approval based on predefined business rules (e.g., amounts below threshold, pre-authorized requesters).',
    `average_completion_hours` DECIMAL(18,2) COMMENT 'Mean number of hours taken to complete approval requests in this workflow, calculated from historical data for performance monitoring.',
    `comments_required` BOOLEAN COMMENT 'Indicates whether approvers must provide comments or justification when approving or rejecting requests in this workflow.',
    `compliance_framework` STRING COMMENT 'Regulatory or institutional policy framework that this workflow is designed to enforce (e.g., FERPA, Title IX, Institutional Procurement Policy, HIPAA for Research).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this approval workflow record was first created in the system.',
    `delegation_allowed` BOOLEAN COMMENT 'Indicates whether approvers can delegate their approval authority to another user within this workflow.',
    `approval_workflow_description` STRING COMMENT 'Detailed business description of the approval workflow purpose, scope, and when it should be used.',
    `effective_end_date` DATE COMMENT 'Date when this approval workflow is retired or replaced. Null indicates the workflow is currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this approval workflow becomes active and available for use in the institution.',
    `escalation_enabled` BOOLEAN COMMENT 'Indicates whether this workflow includes automatic escalation to higher authority if approvals are not completed within the defined timeframe.',
    `escalation_threshold_hours` STRING COMMENT 'Number of hours after which an approval request is automatically escalated to the next level of authority if not acted upon.',
    `integration_system_code` STRING COMMENT 'Code identifying the source or integrated enterprise system that triggers or consumes this workflow (e.g., ERP-FIN, HCM, SIS, ITSM).',
    `is_template` BOOLEAN COMMENT 'Indicates whether this workflow serves as a reusable template that can be cloned to create new workflow instances with similar structure.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this approval workflow record was most recently updated or modified.',
    `notes` STRING COMMENT 'Additional free-text notes, special instructions, or contextual information about this workflow for administrators and users.',
    `notification_enabled` BOOLEAN COMMENT 'Indicates whether email or system notifications are sent to stakeholders at key workflow milestones (submission, approval, rejection, completion).',
    `priority_level` STRING COMMENT 'Default priority level assigned to requests processed through this workflow, influencing processing order and escalation urgency.',
    `rejection_returns_to_originator` BOOLEAN COMMENT 'Indicates whether a rejection at any stage returns the request to the original requester (true) or terminates the workflow immediately (false).',
    `requires_unanimous_approval` BOOLEAN COMMENT 'Indicates whether all approvers at each stage must approve (true) or if a single approval is sufficient (false).',
    `retention_period_years` STRING COMMENT 'Number of years that completed workflow instances and their associated records must be retained for regulatory or institutional policy compliance.',
    `service_level_agreement_hours` STRING COMMENT 'Target number of hours within which requests in this workflow should be completed from submission to final decision, as defined by institutional service standards.',
    `usage_count` STRING COMMENT 'Total number of approval requests that have been processed through this workflow since its creation, used for workflow performance analysis.',
    `version_number` STRING COMMENT 'Version identifier for this workflow configuration, following semantic versioning (e.g., 1.0, 2.1.3) to track changes and updates over time.',
    `workflow_code` STRING COMMENT 'Unique business identifier code for the workflow, used for system integration and reference (e.g., FAC-HIRE-01, BUDG-REQ-STD).',
    `workflow_name` STRING COMMENT 'Human-readable name of the approval workflow (e.g., Faculty Hiring Approval, Budget Request Approval, Course Proposal Review).',
    `workflow_status` STRING COMMENT 'Current lifecycle status of the approval workflow indicating whether it is in use, being designed, temporarily disabled, or retired.',
    `workflow_type` STRING COMMENT 'Category of approval workflow based on the business domain it serves (financial approvals, HR processes, academic reviews, procurement, IT service requests, access management).',
    CONSTRAINT pk_approval_workflow PRIMARY KEY(`approval_workflow_id`)
) COMMENT 'Master reference table for approval_workflow. Referenced by approval_workflow_id.';

CREATE OR REPLACE TABLE `education_ecm`.`technology`.`access_certification` (
    `access_certification_id` BIGINT COMMENT 'Primary key for access_certification',
    `approver_employee_id` BIGINT COMMENT 'Reference to the senior authority who provides final sign-off on the completed certification campaign results.',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to technology.enterprise_application. Business justification: Access certifications are scoped to specific enterprise applications. The access_certification table has an application_id field (BIGINT) that should be a FK to enterprise_application. Access certif',
    `employee_id` BIGINT COMMENT 'Reference to the primary individual or role responsible for conducting and approving this access certification campaign.',
    `org_unit_id` BIGINT COMMENT 'Reference to the academic or administrative department whose access is being certified in this campaign.',
    `prior_access_certification_id` BIGINT COMMENT 'Self-referencing FK on access_certification (prior_access_certification_id)',
    `approved_items_count` STRING COMMENT 'Number of access items that were certified as appropriate and approved for continued access.',
    `audit_trail_reference` STRING COMMENT 'External reference identifier linking this certification campaign to detailed audit logs and evidence repositories for compliance verification.',
    `automated_flag` BOOLEAN COMMENT 'Indicates whether this certification campaign leverages automated review workflows and decision support tools versus manual review processes.',
    `certification_number` STRING COMMENT 'Business identifier for the access certification campaign, formatted as CERT-YYYYMMDD pattern for external reference and audit tracking.',
    `certification_scope` STRING COMMENT 'Organizational or functional boundary of the certification campaign, defining whether it covers the entire institution, specific departments, applications, roles, or individuals.',
    `certification_status` STRING COMMENT 'Current lifecycle state of the access certification campaign, tracking progression from initiation through completion or cancellation.',
    `certification_type` STRING COMMENT 'Category of access being certified, distinguishing between user-level, role-based, privileged, application-specific, data-level, or network access reviews.',
    `comments` STRING COMMENT 'Free-text field for reviewers and approvers to document rationale, exceptions, or special circumstances related to this certification campaign.',
    `completed_date` DATE COMMENT 'Actual date when the certification campaign was finalized and all reviews were processed. Null if still in progress.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Calculated percentage of access items reviewed out of total items, expressed as a decimal value between 0.00 and 100.00.',
    `compliance_framework` STRING COMMENT 'Primary regulatory or compliance framework driving this certification requirement, such as SOX, FERPA, HIPAA, or institutional policy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this access certification record was first created in the system.',
    `due_date` DATE COMMENT 'Target completion date by which all access reviews must be submitted and approved to maintain compliance.',
    `escalation_date` DATE COMMENT 'Date when unresolved certification items were escalated to higher authority for decision. Null if no escalation occurred.',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicates whether unresolved or high-risk access items require escalation to senior management or security governance committees.',
    `frequency` STRING COMMENT 'Scheduled recurrence pattern for this type of access certification, aligned with institutional policy and regulatory requirements.',
    `initiated_date` DATE COMMENT 'Date when the access certification campaign was formally launched and notifications sent to reviewers.',
    `last_reminder_date` DATE COMMENT 'Date of the most recent reminder notification sent to incomplete reviewers. Null if no reminders have been sent.',
    `modified_by` STRING COMMENT 'Username or identifier of the individual who last updated this access certification record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this access certification record, tracking any changes to status, counts, or metadata.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether initial certification campaign notifications have been successfully delivered to all assigned reviewers.',
    `reminder_count` STRING COMMENT 'Number of follow-up reminder notifications sent to reviewers who have not completed their certification tasks.',
    `review_period_end` DATE COMMENT 'Ending date of the access period being reviewed in this certification campaign.',
    `review_period_start` DATE COMMENT 'Beginning date of the access period being reviewed in this certification campaign.',
    `reviewed_items_count` STRING COMMENT 'Number of access items that have been reviewed and decided upon by certifiers as of the current state.',
    `revoked_items_count` STRING COMMENT 'Number of access items that were identified as inappropriate and marked for revocation or removal.',
    `risk_level` STRING COMMENT 'Overall risk classification assigned to this certification campaign based on the sensitivity of systems and data covered.',
    `total_items_count` STRING COMMENT 'Total number of access items (user accounts, roles, permissions) included in this certification campaign for review.',
    `created_by` STRING COMMENT 'Username or identifier of the individual who initiated this access certification campaign.',
    CONSTRAINT pk_access_certification PRIMARY KEY(`access_certification_id`)
) COMMENT 'Master reference table for access_certification. Referenced by access_certification_id.';

CREATE OR REPLACE TABLE `education_ecm`.`technology`.`problem` (
    `problem_id` BIGINT COMMENT 'Primary key for problem',
    `configuration_item_id` BIGINT COMMENT 'Foreign key linking to technology.configuration_item. Business justification: Problems (in ITIL) are root causes affecting configuration items. The problem table currently has affected_configuration_item as a string field, which should be normalized to a FK. Problems represen',
    `it_service_id` BIGINT COMMENT 'Foreign key linking to technology.it_service. Business justification: Problems affect IT services and should be linked to them. The problem table currently has affected_service as a string field, which should be normalized to a FK. Problems represent root causes of se',
    `parent_problem_id` BIGINT COMMENT 'Self-referencing FK on problem (parent_problem_id)',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual cost incurred to resolve the problem after completion.',
    `assigned_group` STRING COMMENT 'Support group or team responsible for managing the problem resolution.',
    `assigned_to` STRING COMMENT 'Name or identifier of the individual or team currently assigned to investigate and resolve the problem.',
    `business_justification` STRING COMMENT 'Business rationale and justification for prioritizing and resolving this problem.',
    `change_request_number` STRING COMMENT 'Reference number of the change request created to implement the permanent solution for this problem.',
    `closed_date` DATE COMMENT 'Date when the problem record was formally closed after verification and documentation.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated cost to resolve the problem including labor, materials, and downtime impact.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the problem record was first created in the system.',
    `problem_description` STRING COMMENT 'Detailed description of the problem including symptoms, scope, and business impact.',
    `detected_date` DATE COMMENT 'Date when the underlying issue was first detected in the environment, which may precede the reported date.',
    `impact` STRING COMMENT 'Scope of business impact indicating how many users or services are affected.',
    `incident_count` STRING COMMENT 'Number of incidents that have been linked to or caused by this problem.',
    `investigation_start_date` DATE COMMENT 'Date when formal investigation of the problem began.',
    `known_error_flag` BOOLEAN COMMENT 'Indicates whether this problem has been classified as a known error with documented root cause and workaround.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the problem record was last updated or modified.',
    `permanent_solution` STRING COMMENT 'Documented permanent fix or solution that addresses the root cause of the problem.',
    `priority` STRING COMMENT 'Business priority level assigned based on impact and urgency of the problem.',
    `problem_category` STRING COMMENT 'High-level categorization of the problem domain.',
    `problem_number` STRING COMMENT 'Human-readable unique problem ticket number assigned by the service management system.',
    `problem_subcategory` STRING COMMENT 'Detailed subcategory providing granular classification within the problem category.',
    `problem_type` STRING COMMENT 'Classification indicating whether the problem was identified reactively (after incidents) or proactively (before incidents occur).',
    `reported_by` STRING COMMENT 'Name or identifier of the person who initially reported or identified the problem.',
    `reported_date` DATE COMMENT 'Date when the problem was first reported or identified.',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the resolution process, actions taken, and lessons learned.',
    `resolved_date` DATE COMMENT 'Date when the problem was resolved with a permanent solution implemented.',
    `root_cause` STRING COMMENT 'Documented root cause of the problem identified through investigation and analysis.',
    `root_cause_identified_date` DATE COMMENT 'Date when the root cause of the problem was successfully identified.',
    `severity` STRING COMMENT 'Technical severity level indicating the extent of service degradation or disruption.',
    `problem_status` STRING COMMENT 'Current lifecycle state of the problem record.',
    `target_resolution_date` DATE COMMENT 'Target or committed date by which the problem should be resolved based on priority and service level agreements.',
    `title` STRING COMMENT 'Brief descriptive title summarizing the problem.',
    `urgency` STRING COMMENT 'Time sensitivity indicating how quickly the problem must be resolved.',
    `vendor_reference` STRING COMMENT 'Reference number or case identifier from an external vendor if the problem involves third-party products or services.',
    `workaround` STRING COMMENT 'Temporary solution or workaround to reduce or eliminate the impact of the problem before permanent resolution.',
    CONSTRAINT pk_problem PRIMARY KEY(`problem_id`)
) COMMENT 'Master reference table for problem. Referenced by related_problem_id.';

CREATE OR REPLACE TABLE `education_ecm`.`technology`.`knowledge_article` (
    `knowledge_article_id` BIGINT COMMENT 'Primary key for knowledge_article',
    `knowledge_category_id` BIGINT COMMENT 'Reference to the primary category or topic area this article belongs to within the knowledge base taxonomy.',
    `employee_id` BIGINT COMMENT 'Reference to the staff member or system user who originally created the article.',
    `org_unit_id` BIGINT COMMENT 'Reference to the academic or administrative department that owns or is primarily served by this article.',
    `owner_employee_id` BIGINT COMMENT 'Reference to the staff member or team responsible for maintaining and updating the article.',
    `reviewer_employee_id` BIGINT COMMENT 'Reference to the staff member who performed the most recent quality review or approval of the article.',
    `knowledge_subcategory_id` BIGINT COMMENT 'Reference to the secondary classification level for more granular organization of the article.',
    `superseded_knowledge_article_id` BIGINT COMMENT 'Self-referencing FK on knowledge_article (superseded_knowledge_article_id)',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the article was formally approved for publication by a reviewer.',
    `archived_date` DATE COMMENT 'Date when the article was moved to archived status and removed from active knowledge base.',
    `article_number` STRING COMMENT 'Human-readable unique identifier for the knowledge article, typically displayed to end users and support staff.',
    `article_type` STRING COMMENT 'Classification of the knowledge article by its purpose and structure.',
    `attachment_count` STRING COMMENT 'Number of files, documents, or media attachments associated with this article.',
    `audience` STRING COMMENT 'Primary intended audience or user group for this knowledge article.',
    `average_rating` DECIMAL(18,2) COMMENT 'Mean rating score provided by users, typically on a scale of 1 to 5.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether this article contains information relevant to regulatory compliance or institutional policy.',
    `content` STRING COMMENT 'The full body text of the knowledge article containing detailed information, instructions, or guidance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this knowledge article record was first created in the system.',
    `expiration_date` DATE COMMENT 'Date on which this article is scheduled to expire or be automatically archived if not reviewed.',
    `external_url` STRING COMMENT 'Optional hyperlink to an external resource or reference related to this article.',
    `helpful_count` BIGINT COMMENT 'Number of users who marked this article as helpful or useful.',
    `is_featured` BOOLEAN COMMENT 'Indicates whether this article is promoted or highlighted in the knowledge base interface.',
    `is_searchable` BOOLEAN COMMENT 'Indicates whether this article is included in knowledge base search indexes.',
    `keywords` STRING COMMENT 'Comma-separated list of keywords and tags to improve article discoverability in search.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the language in which the article is written.',
    `last_reviewed_date` DATE COMMENT 'Date when the article content was last reviewed for accuracy and relevance.',
    `lifecycle_status` STRING COMMENT 'Current state of the knowledge article in its publication lifecycle.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this knowledge article record was last updated or modified.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of article content and accuracy.',
    `not_helpful_count` BIGINT COMMENT 'Number of users who marked this article as not helpful or inadequate.',
    `notes` STRING COMMENT 'Free-form internal notes or comments for knowledge base administrators, not visible to end users.',
    `published_date` DATE COMMENT 'Date when the article was first made available to its intended audience.',
    `related_incident_count` STRING COMMENT 'Number of service desk incidents that have been linked to or resolved using this article.',
    `requires_authentication` BOOLEAN COMMENT 'Indicates whether users must be authenticated to access this article.',
    `resolution_time_minutes` STRING COMMENT 'Average time in minutes that incidents are resolved when this article is applied.',
    `retired_date` DATE COMMENT 'Date when the article was permanently retired and marked as obsolete.',
    `summary` STRING COMMENT 'Brief abstract or executive summary of the article content, typically displayed in search results.',
    `title` STRING COMMENT 'The primary title or headline of the knowledge article that summarizes its content.',
    `version_number` STRING COMMENT 'Semantic version identifier tracking major and minor revisions of the article content.',
    `view_count` BIGINT COMMENT 'Total number of times this article has been accessed or viewed by users.',
    `visibility` STRING COMMENT 'Access control level determining who can view this article in the knowledge base.',
    CONSTRAINT pk_knowledge_article PRIMARY KEY(`knowledge_article_id`)
) COMMENT 'Master reference table for knowledge_article. Referenced by knowledge_article_id.';

CREATE OR REPLACE TABLE `education_ecm`.`technology`.`notification_template` (
    `notification_template_id` BIGINT COMMENT 'Primary key for notification_template',
    `parent_notification_template_id` BIGINT COMMENT 'Self-referencing FK on notification_template (parent_notification_template_id)',
    `approval_required` BOOLEAN COMMENT 'Indicates whether notifications generated from this template require managerial or administrative approval before sending.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this template for production use.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this notification template was approved for production use.',
    `attachment_allowed` BOOLEAN COMMENT 'Indicates whether file attachments can be included with notifications generated from this template.',
    `audience_type` STRING COMMENT 'The primary recipient audience segment for which this notification template is designed.',
    `body_content` STRING COMMENT 'The main message body content of the notification template. May contain HTML markup and merge field placeholders for dynamic content substitution.',
    `compliance_category` STRING COMMENT 'The primary regulatory compliance framework applicable to notifications generated from this template.',
    `content_format` STRING COMMENT 'The markup or formatting standard used in the body content of the notification template.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this notification template record was first created in the system.',
    `delivery_schedule` STRING COMMENT 'The timing pattern for notification delivery: immediate upon trigger, scheduled for specific time, batched with others, or recurring on a schedule.',
    `notification_template_description` STRING COMMENT 'Detailed description of the purpose, use case, and intended audience for this notification template.',
    `effective_end_date` DATE COMMENT 'The date after which this notification template is no longer active and should not be used for new notifications. Null indicates no planned end date.',
    `effective_start_date` DATE COMMENT 'The date from which this notification template becomes active and available for use.',
    `encryption_required` BOOLEAN COMMENT 'Indicates whether notifications generated from this template must be encrypted during transmission and storage.',
    `language_code` STRING COMMENT 'ISO 639-1 language code (with optional ISO 3166-1 country code) indicating the language of the template content.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Date and time when this template was most recently used to generate a notification.',
    `max_attachment_size_mb` DECIMAL(18,2) COMMENT 'Maximum total file size in megabytes allowed for attachments on notifications using this template.',
    `merge_fields` STRING COMMENT 'Comma-separated list or JSON array of dynamic merge field placeholders available in this template for personalization (e.g., student_name, course_code, due_date).',
    `modified_by` STRING COMMENT 'Name or identifier of the user who most recently modified this notification template record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this notification template record was most recently updated.',
    `notification_type` STRING COMMENT 'The delivery channel or medium through which the notification will be sent to recipients.',
    `owner_department_id` BIGINT COMMENT 'Reference to the institutional department or unit responsible for maintaining and approving this notification template.',
    `priority_level` STRING COMMENT 'The urgency or importance level assigned to notifications generated from this template, affecting delivery timing and routing.',
    `reply_to_email` STRING COMMENT 'The email address to which recipient replies should be directed, if different from the sender email.',
    `requires_acknowledgment` BOOLEAN COMMENT 'Indicates whether recipients must acknowledge receipt or reading of notifications generated from this template.',
    `retention_days` STRING COMMENT 'Number of days that notifications generated from this template should be retained in the system before archival or deletion.',
    `sender_email` STRING COMMENT 'The email address that will appear as the sender for email notifications generated from this template.',
    `sender_name` STRING COMMENT 'The display name that will appear as the sender of the notification.',
    `subject_line` STRING COMMENT 'The subject line or title text for the notification, applicable to email and portal notifications. May contain merge field placeholders.',
    `template_category` STRING COMMENT 'Categorical classification of the notification template based on functional area within the institution.',
    `template_code` STRING COMMENT 'Unique business identifier code for the notification template, used for programmatic reference and integration.',
    `template_name` STRING COMMENT 'Human-readable name of the notification template for identification and selection purposes.',
    `template_status` STRING COMMENT 'Current lifecycle status of the notification template indicating its availability for use.',
    `test_mode_enabled` BOOLEAN COMMENT 'Indicates whether this template is currently in test mode, preventing actual delivery to recipients.',
    `trigger_event` STRING COMMENT 'The business event or condition that initiates the sending of notifications using this template (e.g., enrollment_confirmation, payment_due, grade_posted).',
    `usage_count` BIGINT COMMENT 'Total number of notifications that have been generated and sent using this template since activation.',
    `version_number` STRING COMMENT 'Semantic version number of the template, incremented when content or configuration changes are made.',
    `created_by` STRING COMMENT 'Name or identifier of the user who originally created this notification template record.',
    CONSTRAINT pk_notification_template PRIMARY KEY(`notification_template_id`)
) COMMENT 'Master reference table for notification_template. Referenced by notification_template_id.';

CREATE OR REPLACE TABLE `education_ecm`.`technology`.`knowledge_category` (
    `knowledge_category_id` BIGINT COMMENT 'Primary key for knowledge_category',
    `parent_knowledge_category_id` BIGINT COMMENT 'Self-referencing FK on knowledge_category (parent_knowledge_category_id)',
    `access_level` STRING COMMENT 'Security classification determining who can view and access knowledge articles within this category. Aligns with institutional data classification policies.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether knowledge articles in this category require formal approval before publication. True for categories containing sensitive or policy-related content.',
    `article_count` STRING COMMENT 'Current count of active knowledge articles associated with this category. Updated periodically for reporting and analytics purposes.',
    `audience_type` STRING COMMENT 'Primary audience or user group for whom knowledge articles in this category are intended. Determines access controls and content complexity.',
    `category_code` STRING COMMENT 'Short alphanumeric code used as a business identifier for the knowledge category. Used for external references and integrations.',
    `category_name` STRING COMMENT 'Human-readable name of the knowledge category. Primary display label used across IT service management systems and knowledge bases.',
    `category_type` STRING COMMENT 'Classification of the knowledge category based on the nature of content it organizes. Determines how knowledge articles are structured and accessed.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this knowledge category record was first created in the system.',
    `knowledge_category_description` STRING COMMENT 'Detailed description of the knowledge category purpose, scope, and the types of knowledge articles it contains. Provides guidance for content creators and users.',
    `display_order` STRING COMMENT 'Numeric sequence used to control the display order of categories within the same hierarchy level. Lower numbers appear first.',
    `effective_end_date` DATE COMMENT 'Date when this knowledge category was or will be retired from active use. Null for currently active categories.',
    `effective_start_date` DATE COMMENT 'Date when this knowledge category became active and available for use in knowledge management systems.',
    `external_reference_url` STRING COMMENT 'Optional URL linking to external documentation, vendor resources, or industry standards related to this knowledge category.',
    `hierarchy_level` STRING COMMENT 'Numeric level in the category hierarchy tree. Level 1 represents top-level categories, with increasing numbers for deeper nesting.',
    `icon_url` STRING COMMENT 'URL path to the visual icon or image representing this knowledge category in user interfaces. Enhances user experience and navigation.',
    `is_featured` BOOLEAN COMMENT 'Indicates whether this category should be prominently displayed on knowledge portal home pages or featured sections.',
    `is_searchable` BOOLEAN COMMENT 'Indicates whether articles in this category are included in knowledge base search results. False for internal or draft categories.',
    `last_reviewed_date` DATE COMMENT 'Date when the knowledge category definition and associated articles were last reviewed for accuracy and relevance.',
    `modified_by` STRING COMMENT 'Username or identifier of the person who last modified this knowledge category record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this knowledge category record was last modified.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this knowledge category and its content. Calculated based on review frequency.',
    `notes` STRING COMMENT 'Free-form text field for administrative notes, special instructions, or additional context about this knowledge category. For internal use only.',
    `notification_enabled` BOOLEAN COMMENT 'Indicates whether subscribers should receive notifications when new articles are published or updated in this category.',
    `owner_contact_email` STRING COMMENT 'Primary email address for the category owner or responsible team. Used for content governance and escalation purposes.',
    `owner_department` STRING COMMENT 'Name of the IT department or organizational unit responsible for maintaining and curating knowledge content in this category.',
    `parent_category_id` BIGINT COMMENT 'Reference to the parent knowledge category for hierarchical organization. Enables multi-level taxonomy structures. Null for top-level categories.',
    `retention_period_days` STRING COMMENT 'Number of days that knowledge articles in this category should be retained before archival or deletion. Supports compliance with records retention policies.',
    `review_frequency_days` STRING COMMENT 'Recommended number of days between periodic reviews of knowledge articles in this category to ensure content accuracy and relevance.',
    `search_keywords` STRING COMMENT 'Comma-separated list of keywords and synonyms to improve search discoverability of this category and its articles. Supports natural language search optimization.',
    `service_area` STRING COMMENT 'Primary IT service area or domain that this knowledge category supports. Aligns with institutional IT service portfolio structure.',
    `knowledge_category_status` STRING COMMENT 'Current lifecycle status of the knowledge category. Controls visibility and usability in knowledge management systems.',
    `version_number` STRING COMMENT 'Version number of this knowledge category record. Incremented with each modification to support change tracking and audit history.',
    `view_count` BIGINT COMMENT 'Cumulative number of times knowledge articles in this category have been viewed. Used for usage analytics and content optimization.',
    `created_by` STRING COMMENT 'Username or identifier of the person who created this knowledge category record.',
    CONSTRAINT pk_knowledge_category PRIMARY KEY(`knowledge_category_id`)
) COMMENT 'Master reference table for knowledge_category. Referenced by category_id.';

CREATE OR REPLACE TABLE `education_ecm`.`technology`.`knowledge_subcategory` (
    `knowledge_subcategory_id` BIGINT COMMENT 'Primary key for knowledge_subcategory',
    `parent_knowledge_subcategory_id` BIGINT COMMENT 'Self-referencing FK on knowledge_subcategory (parent_knowledge_subcategory_id)',
    `article_count` STRING COMMENT 'Current number of published knowledge articles assigned to this subcategory, used for content inventory and gap analysis.',
    `audience_type` STRING COMMENT 'Primary target audience for knowledge articles within this subcategory, supporting role-based content filtering and personalization.',
    `average_article_rating` DECIMAL(18,2) COMMENT 'Mean user satisfaction rating for all articles within this subcategory, calculated on a scale of 1.00 to 5.00.',
    `created_by_user_id` BIGINT COMMENT 'Reference to the user who created this knowledge subcategory record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this knowledge subcategory record was first created in the system.',
    `deleted_by_user_id` BIGINT COMMENT 'Reference to the user who soft deleted this knowledge subcategory record.',
    `deleted_timestamp` TIMESTAMP COMMENT 'Date and time when this knowledge subcategory was soft deleted, if applicable.',
    `display_order` STRING COMMENT 'Numeric sequence value controlling the presentation order of subcategories within their parent category in user interfaces and reports.',
    `effective_end_date` DATE COMMENT 'Date on which this knowledge subcategory was or will be retired, after which no new articles should be assigned to it.',
    `effective_start_date` DATE COMMENT 'Date from which this knowledge subcategory became active and available for article classification and user access.',
    `icon_name` STRING COMMENT 'Name or identifier of the visual icon used to represent this subcategory in user interfaces and knowledge portals.',
    `is_deleted` BOOLEAN COMMENT 'Soft delete indicator showing whether this knowledge subcategory has been logically deleted but retained for audit purposes.',
    `is_visible_to_end_users` BOOLEAN COMMENT 'Indicates whether this knowledge subcategory is visible to end users in self-service portals or restricted to internal IT staff only.',
    `knowledge_category_id` BIGINT COMMENT 'Reference to the parent knowledge category under which this subcategory is organized.',
    `last_article_published_date` DATE COMMENT 'Date when the most recent knowledge article was published within this subcategory, indicating content freshness.',
    `modified_by_user_id` BIGINT COMMENT 'Reference to the user who last modified this knowledge subcategory record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this knowledge subcategory record was last updated.',
    `owner_department_id` BIGINT COMMENT 'Reference to the IT department or organizational unit responsible for maintaining knowledge content within this subcategory.',
    `requires_approval` BOOLEAN COMMENT 'Indicates whether knowledge articles assigned to this subcategory require formal approval before publication.',
    `retention_period_days` STRING COMMENT 'Number of days that archived or deprecated articles within this subcategory must be retained before permanent deletion, per records management policy.',
    `search_keywords` STRING COMMENT 'Comma-separated list of keywords and synonyms associated with this subcategory to enhance search discoverability and content retrieval.',
    `service_area` STRING COMMENT 'Broad IT service domain to which this knowledge subcategory primarily relates, enabling cross-functional knowledge organization.',
    `knowledge_subcategory_status` STRING COMMENT 'Current lifecycle status of the knowledge subcategory indicating whether it is actively used for article classification.',
    `subcategory_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the knowledge subcategory for external reference and integration purposes.',
    `subcategory_description` STRING COMMENT 'Detailed explanation of the knowledge subcategory scope, purpose, and the types of knowledge articles or documentation it encompasses.',
    `subcategory_name` STRING COMMENT 'Full descriptive name of the knowledge subcategory used for display and reporting purposes.',
    `subcategory_type` STRING COMMENT 'Classification of the knowledge subcategory by content type, indicating the nature of knowledge articles contained within.',
    CONSTRAINT pk_knowledge_subcategory PRIMARY KEY(`knowledge_subcategory_id`)
) COMMENT 'Master reference table for knowledge_subcategory. Referenced by subcategory_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `education_ecm`.`technology`.`it_asset` ADD CONSTRAINT `fk_technology_it_asset_configuration_item_id` FOREIGN KEY (`configuration_item_id`) REFERENCES `education_ecm`.`technology`.`configuration_item`(`configuration_item_id`);
ALTER TABLE `education_ecm`.`technology`.`it_asset` ADD CONSTRAINT `fk_technology_it_asset_it_contract_id` FOREIGN KEY (`it_contract_id`) REFERENCES `education_ecm`.`technology`.`it_contract`(`it_contract_id`);
ALTER TABLE `education_ecm`.`technology`.`it_asset` ADD CONSTRAINT `fk_technology_it_asset_replaced_it_asset_id` FOREIGN KEY (`replaced_it_asset_id`) REFERENCES `education_ecm`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `education_ecm`.`technology`.`software_license` ADD CONSTRAINT `fk_technology_software_license_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`technology`.`software_license` ADD CONSTRAINT `fk_technology_software_license_it_contract_id` FOREIGN KEY (`it_contract_id`) REFERENCES `education_ecm`.`technology`.`it_contract`(`it_contract_id`);
ALTER TABLE `education_ecm`.`technology`.`software_license` ADD CONSTRAINT `fk_technology_software_license_upgraded_from_software_license_id` FOREIGN KEY (`upgraded_from_software_license_id`) REFERENCES `education_ecm`.`technology`.`software_license`(`software_license_id`);
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ADD CONSTRAINT `fk_technology_it_asset_lifecycle_event_change_request_id` FOREIGN KEY (`change_request_id`) REFERENCES `education_ecm`.`technology`.`change_request`(`change_request_id`);
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ADD CONSTRAINT `fk_technology_it_asset_lifecycle_event_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `education_ecm`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ADD CONSTRAINT `fk_technology_it_asset_lifecycle_event_service_request_id` FOREIGN KEY (`service_request_id`) REFERENCES `education_ecm`.`technology`.`service_request`(`service_request_id`);
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ADD CONSTRAINT `fk_technology_it_asset_lifecycle_event_corrected_it_asset_lifecycle_event_id` FOREIGN KEY (`corrected_it_asset_lifecycle_event_id`) REFERENCES `education_ecm`.`technology`.`it_asset_lifecycle_event`(`it_asset_lifecycle_event_id`);
ALTER TABLE `education_ecm`.`technology`.`network_device` ADD CONSTRAINT `fk_technology_network_device_configuration_item_id` FOREIGN KEY (`configuration_item_id`) REFERENCES `education_ecm`.`technology`.`configuration_item`(`configuration_item_id`);
ALTER TABLE `education_ecm`.`technology`.`network_device` ADD CONSTRAINT `fk_technology_network_device_it_contract_id` FOREIGN KEY (`it_contract_id`) REFERENCES `education_ecm`.`technology`.`it_contract`(`it_contract_id`);
ALTER TABLE `education_ecm`.`technology`.`network_device` ADD CONSTRAINT `fk_technology_network_device_upstream_network_device_id` FOREIGN KEY (`upstream_network_device_id`) REFERENCES `education_ecm`.`technology`.`network_device`(`network_device_id`);
ALTER TABLE `education_ecm`.`technology`.`identity_account` ADD CONSTRAINT `fk_technology_identity_account_linked_identity_account_id` FOREIGN KEY (`linked_identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ADD CONSTRAINT `fk_technology_access_entitlement_approval_workflow_id` FOREIGN KEY (`approval_workflow_id`) REFERENCES `education_ecm`.`technology`.`approval_workflow`(`approval_workflow_id`);
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ADD CONSTRAINT `fk_technology_access_entitlement_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ADD CONSTRAINT `fk_technology_access_entitlement_parent_access_entitlement_id` FOREIGN KEY (`parent_access_entitlement_id`) REFERENCES `education_ecm`.`technology`.`access_entitlement`(`access_entitlement_id`);
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ADD CONSTRAINT `fk_technology_access_provisioning_event_access_certification_id` FOREIGN KEY (`access_certification_id`) REFERENCES `education_ecm`.`technology`.`access_certification`(`access_certification_id`);
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ADD CONSTRAINT `fk_technology_access_provisioning_event_access_entitlement_id` FOREIGN KEY (`access_entitlement_id`) REFERENCES `education_ecm`.`technology`.`access_entitlement`(`access_entitlement_id`);
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ADD CONSTRAINT `fk_technology_access_provisioning_event_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ADD CONSTRAINT `fk_technology_access_provisioning_event_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ADD CONSTRAINT `fk_technology_access_provisioning_event_service_request_id` FOREIGN KEY (`service_request_id`) REFERENCES `education_ecm`.`technology`.`service_request`(`service_request_id`);
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ADD CONSTRAINT `fk_technology_access_provisioning_event_target_system_account_identity_account_id` FOREIGN KEY (`target_system_account_identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ADD CONSTRAINT `fk_technology_access_provisioning_event_reversal_access_provisioning_event_id` FOREIGN KEY (`reversal_access_provisioning_event_id`) REFERENCES `education_ecm`.`technology`.`access_provisioning_event`(`access_provisioning_event_id`);
ALTER TABLE `education_ecm`.`technology`.`service_request` ADD CONSTRAINT `fk_technology_service_request_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `education_ecm`.`technology`.`incident`(`incident_id`);
ALTER TABLE `education_ecm`.`technology`.`service_request` ADD CONSTRAINT `fk_technology_service_request_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `education_ecm`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `education_ecm`.`technology`.`service_request` ADD CONSTRAINT `fk_technology_service_request_it_service_id` FOREIGN KEY (`it_service_id`) REFERENCES `education_ecm`.`technology`.`it_service`(`it_service_id`);
ALTER TABLE `education_ecm`.`technology`.`service_request` ADD CONSTRAINT `fk_technology_service_request_knowledge_article_id` FOREIGN KEY (`knowledge_article_id`) REFERENCES `education_ecm`.`technology`.`knowledge_article`(`knowledge_article_id`);
ALTER TABLE `education_ecm`.`technology`.`service_request` ADD CONSTRAINT `fk_technology_service_request_parent_service_request_id` FOREIGN KEY (`parent_service_request_id`) REFERENCES `education_ecm`.`technology`.`service_request`(`service_request_id`);
ALTER TABLE `education_ecm`.`technology`.`incident` ADD CONSTRAINT `fk_technology_incident_configuration_item_id` FOREIGN KEY (`configuration_item_id`) REFERENCES `education_ecm`.`technology`.`configuration_item`(`configuration_item_id`);
ALTER TABLE `education_ecm`.`technology`.`incident` ADD CONSTRAINT `fk_technology_incident_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`technology`.`incident` ADD CONSTRAINT `fk_technology_incident_it_service_id` FOREIGN KEY (`it_service_id`) REFERENCES `education_ecm`.`technology`.`it_service`(`it_service_id`);
ALTER TABLE `education_ecm`.`technology`.`incident` ADD CONSTRAINT `fk_technology_incident_change_request_id` FOREIGN KEY (`change_request_id`) REFERENCES `education_ecm`.`technology`.`change_request`(`change_request_id`);
ALTER TABLE `education_ecm`.`technology`.`incident` ADD CONSTRAINT `fk_technology_incident_problem_id` FOREIGN KEY (`problem_id`) REFERENCES `education_ecm`.`technology`.`problem`(`problem_id`);
ALTER TABLE `education_ecm`.`technology`.`incident` ADD CONSTRAINT `fk_technology_incident_parent_incident_id` FOREIGN KEY (`parent_incident_id`) REFERENCES `education_ecm`.`technology`.`incident`(`incident_id`);
ALTER TABLE `education_ecm`.`technology`.`change_request` ADD CONSTRAINT `fk_technology_change_request_configuration_item_id` FOREIGN KEY (`configuration_item_id`) REFERENCES `education_ecm`.`technology`.`configuration_item`(`configuration_item_id`);
ALTER TABLE `education_ecm`.`technology`.`change_request` ADD CONSTRAINT `fk_technology_change_request_it_project_id` FOREIGN KEY (`it_project_id`) REFERENCES `education_ecm`.`technology`.`it_project`(`it_project_id`);
ALTER TABLE `education_ecm`.`technology`.`change_request` ADD CONSTRAINT `fk_technology_change_request_rollback_change_request_id` FOREIGN KEY (`rollback_change_request_id`) REFERENCES `education_ecm`.`technology`.`change_request`(`change_request_id`);
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ADD CONSTRAINT `fk_technology_configuration_item_it_contract_id` FOREIGN KEY (`it_contract_id`) REFERENCES `education_ecm`.`technology`.`it_contract`(`it_contract_id`);
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ADD CONSTRAINT `fk_technology_configuration_item_parent_configuration_item_id` FOREIGN KEY (`parent_configuration_item_id`) REFERENCES `education_ecm`.`technology`.`configuration_item`(`configuration_item_id`);
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ADD CONSTRAINT `fk_technology_cybersecurity_incident_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ADD CONSTRAINT `fk_technology_cybersecurity_incident_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `education_ecm`.`technology`.`incident`(`incident_id`);
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ADD CONSTRAINT `fk_technology_cybersecurity_incident_related_cybersecurity_incident_id` FOREIGN KEY (`related_cybersecurity_incident_id`) REFERENCES `education_ecm`.`technology`.`cybersecurity_incident`(`cybersecurity_incident_id`);
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ADD CONSTRAINT `fk_technology_vulnerability_configuration_item_id` FOREIGN KEY (`configuration_item_id`) REFERENCES `education_ecm`.`technology`.`configuration_item`(`configuration_item_id`);
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ADD CONSTRAINT `fk_technology_vulnerability_related_vulnerability_id` FOREIGN KEY (`related_vulnerability_id`) REFERENCES `education_ecm`.`technology`.`vulnerability`(`vulnerability_id`);
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ADD CONSTRAINT `fk_technology_enterprise_application_configuration_item_id` FOREIGN KEY (`configuration_item_id`) REFERENCES `education_ecm`.`technology`.`configuration_item`(`configuration_item_id`);
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ADD CONSTRAINT `fk_technology_enterprise_application_parent_enterprise_application_id` FOREIGN KEY (`parent_enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`technology`.`application_integration` ADD CONSTRAINT `fk_technology_application_integration_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`technology`.`application_integration` ADD CONSTRAINT `fk_technology_application_integration_target_application_enterprise_application_id` FOREIGN KEY (`target_application_enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`technology`.`application_integration` ADD CONSTRAINT `fk_technology_application_integration_superseded_application_integration_id` FOREIGN KEY (`superseded_application_integration_id`) REFERENCES `education_ecm`.`technology`.`application_integration`(`application_integration_id`);
ALTER TABLE `education_ecm`.`technology`.`it_project` ADD CONSTRAINT `fk_technology_it_project_it_contract_id` FOREIGN KEY (`it_contract_id`) REFERENCES `education_ecm`.`technology`.`it_contract`(`it_contract_id`);
ALTER TABLE `education_ecm`.`technology`.`it_project` ADD CONSTRAINT `fk_technology_it_project_parent_it_project_id` FOREIGN KEY (`parent_it_project_id`) REFERENCES `education_ecm`.`technology`.`it_project`(`it_project_id`);
ALTER TABLE `education_ecm`.`technology`.`it_service` ADD CONSTRAINT `fk_technology_it_service_it_contract_id` FOREIGN KEY (`it_contract_id`) REFERENCES `education_ecm`.`technology`.`it_contract`(`it_contract_id`);
ALTER TABLE `education_ecm`.`technology`.`it_service` ADD CONSTRAINT `fk_technology_it_service_parent_it_service_id` FOREIGN KEY (`parent_it_service_id`) REFERENCES `education_ecm`.`technology`.`it_service`(`it_service_id`);
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ADD CONSTRAINT `fk_technology_it_service_outage_change_request_id` FOREIGN KEY (`change_request_id`) REFERENCES `education_ecm`.`technology`.`change_request`(`change_request_id`);
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ADD CONSTRAINT `fk_technology_it_service_outage_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `education_ecm`.`technology`.`incident`(`incident_id`);
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ADD CONSTRAINT `fk_technology_it_service_outage_it_service_id` FOREIGN KEY (`it_service_id`) REFERENCES `education_ecm`.`technology`.`it_service`(`it_service_id`);
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ADD CONSTRAINT `fk_technology_it_service_outage_related_it_service_outage_id` FOREIGN KEY (`related_it_service_outage_id`) REFERENCES `education_ecm`.`technology`.`it_service_outage`(`it_service_outage_id`);
ALTER TABLE `education_ecm`.`technology`.`it_contract` ADD CONSTRAINT `fk_technology_it_contract_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`technology`.`it_contract` ADD CONSTRAINT `fk_technology_it_contract_last_modified_by_user_identity_account_id` FOREIGN KEY (`last_modified_by_user_identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`technology`.`it_contract` ADD CONSTRAINT `fk_technology_it_contract_renewed_it_contract_id` FOREIGN KEY (`renewed_it_contract_id`) REFERENCES `education_ecm`.`technology`.`it_contract`(`it_contract_id`);
ALTER TABLE `education_ecm`.`technology`.`it_risk` ADD CONSTRAINT `fk_technology_it_risk_configuration_item_id` FOREIGN KEY (`configuration_item_id`) REFERENCES `education_ecm`.`technology`.`configuration_item`(`configuration_item_id`);
ALTER TABLE `education_ecm`.`technology`.`it_risk` ADD CONSTRAINT `fk_technology_it_risk_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`technology`.`it_risk` ADD CONSTRAINT `fk_technology_it_risk_it_service_id` FOREIGN KEY (`it_service_id`) REFERENCES `education_ecm`.`technology`.`it_service`(`it_service_id`);
ALTER TABLE `education_ecm`.`technology`.`it_risk` ADD CONSTRAINT `fk_technology_it_risk_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `education_ecm`.`technology`.`incident`(`incident_id`);
ALTER TABLE `education_ecm`.`technology`.`it_risk` ADD CONSTRAINT `fk_technology_it_risk_parent_it_risk_id` FOREIGN KEY (`parent_it_risk_id`) REFERENCES `education_ecm`.`technology`.`it_risk`(`it_risk_id`);
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ADD CONSTRAINT `fk_technology_it_sla_record_it_service_id` FOREIGN KEY (`it_service_id`) REFERENCES `education_ecm`.`technology`.`it_service`(`it_service_id`);
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ADD CONSTRAINT `fk_technology_it_sla_record_prior_it_sla_record_id` FOREIGN KEY (`prior_it_sla_record_id`) REFERENCES `education_ecm`.`technology`.`it_sla_record`(`it_sla_record_id`);
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ADD CONSTRAINT `fk_technology_it_chargeback_it_service_id` FOREIGN KEY (`it_service_id`) REFERENCES `education_ecm`.`technology`.`it_service`(`it_service_id`);
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ADD CONSTRAINT `fk_technology_it_chargeback_reversal_it_chargeback_id` FOREIGN KEY (`reversal_it_chargeback_id`) REFERENCES `education_ecm`.`technology`.`it_chargeback`(`it_chargeback_id`);
ALTER TABLE `education_ecm`.`technology`.`it_policy` ADD CONSTRAINT `fk_technology_it_policy_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`technology`.`it_policy` ADD CONSTRAINT `fk_technology_it_policy_superseded_policy_it_policy_id` FOREIGN KEY (`superseded_policy_it_policy_id`) REFERENCES `education_ecm`.`technology`.`it_policy`(`it_policy_id`);
ALTER TABLE `education_ecm`.`technology`.`it_policy` ADD CONSTRAINT `fk_technology_it_policy_superseded_it_policy_id` FOREIGN KEY (`superseded_it_policy_id`) REFERENCES `education_ecm`.`technology`.`it_policy`(`it_policy_id`);
ALTER TABLE `education_ecm`.`technology`.`application_contract_coverage` ADD CONSTRAINT `fk_technology_application_contract_coverage_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`technology`.`application_contract_coverage` ADD CONSTRAINT `fk_technology_application_contract_coverage_it_contract_id` FOREIGN KEY (`it_contract_id`) REFERENCES `education_ecm`.`technology`.`it_contract`(`it_contract_id`);
ALTER TABLE `education_ecm`.`technology`.`asset_software_installation` ADD CONSTRAINT `fk_technology_asset_software_installation_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `education_ecm`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `education_ecm`.`technology`.`asset_software_installation` ADD CONSTRAINT `fk_technology_asset_software_installation_software_license_id` FOREIGN KEY (`software_license_id`) REFERENCES `education_ecm`.`technology`.`software_license`(`software_license_id`);
ALTER TABLE `education_ecm`.`technology`.`approval_workflow` ADD CONSTRAINT `fk_technology_approval_workflow_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`technology`.`approval_workflow` ADD CONSTRAINT `fk_technology_approval_workflow_last_modified_by_user_identity_account_id` FOREIGN KEY (`last_modified_by_user_identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`technology`.`approval_workflow` ADD CONSTRAINT `fk_technology_approval_workflow_notification_template_id` FOREIGN KEY (`notification_template_id`) REFERENCES `education_ecm`.`technology`.`notification_template`(`notification_template_id`);
ALTER TABLE `education_ecm`.`technology`.`approval_workflow` ADD CONSTRAINT `fk_technology_approval_workflow_previous_version_id` FOREIGN KEY (`previous_version_id`) REFERENCES `education_ecm`.`technology`.`approval_workflow`(`approval_workflow_id`);
ALTER TABLE `education_ecm`.`technology`.`approval_workflow` ADD CONSTRAINT `fk_technology_approval_workflow_parent_approval_workflow_id` FOREIGN KEY (`parent_approval_workflow_id`) REFERENCES `education_ecm`.`technology`.`approval_workflow`(`approval_workflow_id`);
ALTER TABLE `education_ecm`.`technology`.`access_certification` ADD CONSTRAINT `fk_technology_access_certification_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`technology`.`access_certification` ADD CONSTRAINT `fk_technology_access_certification_prior_access_certification_id` FOREIGN KEY (`prior_access_certification_id`) REFERENCES `education_ecm`.`technology`.`access_certification`(`access_certification_id`);
ALTER TABLE `education_ecm`.`technology`.`problem` ADD CONSTRAINT `fk_technology_problem_configuration_item_id` FOREIGN KEY (`configuration_item_id`) REFERENCES `education_ecm`.`technology`.`configuration_item`(`configuration_item_id`);
ALTER TABLE `education_ecm`.`technology`.`problem` ADD CONSTRAINT `fk_technology_problem_it_service_id` FOREIGN KEY (`it_service_id`) REFERENCES `education_ecm`.`technology`.`it_service`(`it_service_id`);
ALTER TABLE `education_ecm`.`technology`.`problem` ADD CONSTRAINT `fk_technology_problem_parent_problem_id` FOREIGN KEY (`parent_problem_id`) REFERENCES `education_ecm`.`technology`.`problem`(`problem_id`);
ALTER TABLE `education_ecm`.`technology`.`knowledge_article` ADD CONSTRAINT `fk_technology_knowledge_article_knowledge_category_id` FOREIGN KEY (`knowledge_category_id`) REFERENCES `education_ecm`.`technology`.`knowledge_category`(`knowledge_category_id`);
ALTER TABLE `education_ecm`.`technology`.`knowledge_article` ADD CONSTRAINT `fk_technology_knowledge_article_knowledge_subcategory_id` FOREIGN KEY (`knowledge_subcategory_id`) REFERENCES `education_ecm`.`technology`.`knowledge_subcategory`(`knowledge_subcategory_id`);
ALTER TABLE `education_ecm`.`technology`.`knowledge_article` ADD CONSTRAINT `fk_technology_knowledge_article_superseded_knowledge_article_id` FOREIGN KEY (`superseded_knowledge_article_id`) REFERENCES `education_ecm`.`technology`.`knowledge_article`(`knowledge_article_id`);
ALTER TABLE `education_ecm`.`technology`.`notification_template` ADD CONSTRAINT `fk_technology_notification_template_parent_notification_template_id` FOREIGN KEY (`parent_notification_template_id`) REFERENCES `education_ecm`.`technology`.`notification_template`(`notification_template_id`);
ALTER TABLE `education_ecm`.`technology`.`knowledge_category` ADD CONSTRAINT `fk_technology_knowledge_category_parent_knowledge_category_id` FOREIGN KEY (`parent_knowledge_category_id`) REFERENCES `education_ecm`.`technology`.`knowledge_category`(`knowledge_category_id`);
ALTER TABLE `education_ecm`.`technology`.`knowledge_subcategory` ADD CONSTRAINT `fk_technology_knowledge_subcategory_parent_knowledge_subcategory_id` FOREIGN KEY (`parent_knowledge_subcategory_id`) REFERENCES `education_ecm`.`technology`.`knowledge_subcategory`(`knowledge_subcategory_id`);

-- ========= TAGS =========
ALTER SCHEMA `education_ecm`.`technology` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `education_ecm`.`technology` SET TAGS ('dbx_domain' = 'technology');
ALTER TABLE `education_ecm`.`technology`.`it_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`technology`.`it_asset` SET TAGS ('dbx_subdomain' = 'asset_operations');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Information Technology (IT) Asset ID');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `configuration_item_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Item Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `it_contract_id` SET TAGS ('dbx_business_glossary_term' = 'It Contract Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned User ID');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `replaced_it_asset_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `asset_category` SET TAGS ('dbx_value_regex' = 'hardware|software|network_equipment|mobile_device|peripheral|infrastructure');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `asset_tag` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `assigned_department_code` SET TAGS ('dbx_business_glossary_term' = 'Assigned Department Code');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `building_code` SET TAGS ('dbx_business_glossary_term' = 'Building Code');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|exempt');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `current_book_value` SET TAGS ('dbx_business_glossary_term' = 'Current Book Value');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `data_sanitization_method` SET TAGS ('dbx_business_glossary_term' = 'Data Sanitization Method');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|not_applicable');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'recycled|donated|sold|destroyed|returned_to_vendor');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `hostname` SET TAGS ('dbx_business_glossary_term' = 'Network Hostname');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^(?:[0-9]{1,3}.){3}[0-9]{1,3}$');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `mac_address` SET TAGS ('dbx_business_glossary_term' = 'Media Access Control (MAC) Address');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `mac_address` SET TAGS ('dbx_value_regex' = '^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `mac_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `mac_address` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Model Name');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Asset Notes');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|donated|loaned');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `room_number` SET TAGS ('dbx_business_glossary_term' = 'Room Number');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Serial Number');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `support_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Support Contract Expiration Date');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life in Years');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `education_ecm`.`technology`.`it_asset` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `education_ecm`.`technology`.`software_license` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`technology`.`software_license` SET TAGS ('dbx_subdomain' = 'asset_operations');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `software_license_id` SET TAGS ('dbx_business_glossary_term' = 'Software License ID');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `it_contract_id` SET TAGS ('dbx_business_glossary_term' = 'It Contract Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `upgraded_from_software_license_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `annual_cost` SET TAGS ('dbx_business_glossary_term' = 'Annual License Cost');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `annual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `assigned_seat_count` SET TAGS ('dbx_business_glossary_term' = 'Assigned Seat Count');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `available_seat_count` SET TAGS ('dbx_business_glossary_term' = 'Available Seat Count');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|over_deployed|under_utilized|audit_required|unknown');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `deployment_method` SET TAGS ('dbx_business_glossary_term' = 'Deployment Method');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `deployment_method` SET TAGS ('dbx_value_regex' = 'cloud_saas|on_premise|hybrid|virtual_desktop|mobile_app');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `is_open_source` SET TAGS ('dbx_business_glossary_term' = 'Is Open Source Software');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `last_compliance_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Audit Date');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `last_usage_report_date` SET TAGS ('dbx_business_glossary_term' = 'Last Usage Report Date');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `license_key` SET TAGS ('dbx_business_glossary_term' = 'License Key or Entitlement ID');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `license_key` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `license_scope` SET TAGS ('dbx_business_glossary_term' = 'License Scope');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `license_start_date` SET TAGS ('dbx_business_glossary_term' = 'License Start Date');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `license_status` SET TAGS ('dbx_business_glossary_term' = 'License Status');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `license_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|pending_renewal|cancelled|non_compliant');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'perpetual|subscription|concurrent|named_user|site_license|enterprise_agreement');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `maintenance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Expiration Date');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'License Notes');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `open_source_license_type` SET TAGS ('dbx_business_glossary_term' = 'Open Source License Type');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `procurement_reference` SET TAGS ('dbx_business_glossary_term' = 'Procurement Reference Number');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `renewal_owner` SET TAGS ('dbx_business_glossary_term' = 'Renewal Owner');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `software_category` SET TAGS ('dbx_business_glossary_term' = 'Software Category');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `total_seat_count` SET TAGS ('dbx_business_glossary_term' = 'Total Seat Count');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `usage_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Usage Tracking Enabled');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Email');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `vendor_support_url` SET TAGS ('dbx_business_glossary_term' = 'Vendor Support URL');
ALTER TABLE `education_ecm`.`technology`.`software_license` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Software Version Number');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` SET TAGS ('dbx_subdomain' = 'asset_operations');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `it_asset_lifecycle_event_id` SET TAGS ('dbx_business_glossary_term' = 'Information Technology (IT) Asset Lifecycle Event ID');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Change Request Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `finance_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Information Technology (IT) Asset ID');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Department ID');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Data Sanitization Verified By ID');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `prior_location_building_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Location ID');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `quaternary_it_custody_transfer_acknowledged_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Custody Transfer Acknowledged By ID');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `quaternary_it_custody_transfer_acknowledged_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `quaternary_it_custody_transfer_acknowledged_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `quinary_it_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `quinary_it_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `quinary_it_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `tertiary_it_assigned_to_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Employee ID');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `tertiary_it_assigned_to_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `tertiary_it_assigned_to_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `corrected_it_asset_lifecycle_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|not_required');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `building_code` SET TAGS ('dbx_business_glossary_term' = 'Building Code');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `chain_of_custody_signature` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Signature');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `compliance_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Number');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|GBP|EUR|AUD');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `data_sanitization_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Data Sanitization Certificate Number');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `data_sanitization_method` SET TAGS ('dbx_business_glossary_term' = 'Data Sanitization Method');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `data_sanitization_method` SET TAGS ('dbx_value_regex' = 'dod_5220_22_m|nist_800_88|physical_destruction|degaussing|secure_erase|not_applicable');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `depreciation_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Impact Flag');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'recycled|donated|sold|destroyed|returned_to_vendor');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `event_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Event Cost Amount');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `event_notes` SET TAGS ('dbx_business_glossary_term' = 'Event Notes');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Event Type');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `incident_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Ticket Number');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Asset Status');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `prior_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Asset Status');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `repair_description` SET TAGS ('dbx_business_glossary_term' = 'Repair Description');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `room_number` SET TAGS ('dbx_business_glossary_term' = 'Room Number');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `source_system_event_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Event ID');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `upgrade_description` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Description');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `warranty_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Impact Flag');
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `education_ecm`.`technology`.`network_device` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`technology`.`network_device` SET TAGS ('dbx_subdomain' = 'asset_operations');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `network_device_id` SET TAGS ('dbx_business_glossary_term' = 'Network Device ID');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `network_device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `network_device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `athletic_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Athletic Facility Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `configuration_item_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Item Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `it_contract_id` SET TAGS ('dbx_business_glossary_term' = 'It Contract Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `upstream_network_device_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `assigned_to_department` SET TAGS ('dbx_business_glossary_term' = 'Assigned Department');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `building_code` SET TAGS ('dbx_business_glossary_term' = 'Building Code');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Security Compliance Status');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|exempt');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `configuration_backup_location` SET TAGS ('dbx_business_glossary_term' = 'Configuration Backup Location');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `cooling_requirement_btu` SET TAGS ('dbx_business_glossary_term' = 'Cooling Requirement (BTU per Hour)');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Network Device Type');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'router|switch|wireless_access_point|firewall|load_balancer|vpn_concentrator');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `end_of_life_date` SET TAGS ('dbx_business_glossary_term' = 'End of Life (EOL) Date');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `end_of_support_date` SET TAGS ('dbx_business_glossary_term' = 'End of Support (EOS) Date');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `hostname` SET TAGS ('dbx_business_glossary_term' = 'Device Hostname');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `last_configuration_backup_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Configuration Backup Timestamp');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `last_firmware_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Firmware Update Timestamp');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Health Check Timestamp');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `mac_address` SET TAGS ('dbx_business_glossary_term' = 'Media Access Control (MAC) Address');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `mac_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `mac_address` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `management_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Management IP Address');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `management_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `management_vlan_number` SET TAGS ('dbx_business_glossary_term' = 'Management Virtual Local Area Network (VLAN) ID');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Device Manufacturer');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Device Model Number');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `network_role` SET TAGS ('dbx_business_glossary_term' = 'Network Topology Role');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `network_role` SET TAGS ('dbx_value_regex' = 'core|distribution|access|edge|dmz');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Device Notes');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|decommissioned|failed|standby');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `port_count` SET TAGS ('dbx_business_glossary_term' = 'Total Port Count');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `power_consumption_watts` SET TAGS ('dbx_business_glossary_term' = 'Power Consumption (Watts)');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `power_supply_type` SET TAGS ('dbx_business_glossary_term' = 'Power Supply Type');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `power_supply_type` SET TAGS ('dbx_value_regex' = 'ac|dc|poe|redundant');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `rack_location` SET TAGS ('dbx_business_glossary_term' = 'Rack Location');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `room_number` SET TAGS ('dbx_business_glossary_term' = 'Room or Closet Number');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Device Serial Number');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `serial_number` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `snmp_community_string` SET TAGS ('dbx_business_glossary_term' = 'Simple Network Management Protocol (SNMP) Community String');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `snmp_community_string` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `support_tier` SET TAGS ('dbx_business_glossary_term' = 'Support Service Tier');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `support_tier` SET TAGS ('dbx_value_regex' = 'basic|standard|premium|enterprise');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `uplink_port` SET TAGS ('dbx_business_glossary_term' = 'Uplink Port Identifier');
ALTER TABLE `education_ecm`.`technology`.`network_device` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `education_ecm`.`technology`.`identity_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`technology`.`identity_account` SET TAGS ('dbx_subdomain' = 'security_governance');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Identity Account ID');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `linked_identity_account_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `access_level` SET TAGS ('dbx_value_regex' = 'basic|standard|elevated|privileged|administrative');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `account_creation_date` SET TAGS ('dbx_business_glossary_term' = 'Account Creation Date');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `account_deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Account Deactivation Date');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `account_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Account Expiration Date');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `account_locked` SET TAGS ('dbx_business_glossary_term' = 'Account Locked');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `account_notes` SET TAGS ('dbx_business_glossary_term' = 'Account Notes');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|suspended|disabled|expired|pending');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'student|faculty|staff|alumni|sponsored|affiliate');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `alternate_email` SET TAGS ('dbx_business_glossary_term' = 'Alternate Email Address');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `alternate_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `alternate_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `alternate_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `alumni_status` SET TAGS ('dbx_business_glossary_term' = 'Alumni Status');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `alumni_status` SET TAGS ('dbx_value_regex' = 'not_alumni|active_alumni|lapsed_alumni|deceased');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `compliance_training_completed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Completed');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `compliance_training_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Date');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `deactivation_reason` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Reason');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `deactivation_reason` SET TAGS ('dbx_value_regex' = 'graduation|employment_termination|withdrawal|expiration|security_violation|request');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `directory_visible` SET TAGS ('dbx_business_glossary_term' = 'Directory Visible');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `display_name` SET TAGS ('dbx_business_glossary_term' = 'Display Name');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `display_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `display_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `failed_login_attempts` SET TAGS ('dbx_business_glossary_term' = 'Failed Login Attempts');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `ferpa_protected` SET TAGS ('dbx_business_glossary_term' = 'FERPA (Family Educational Rights and Privacy Act) Protected');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `graduation_year` SET TAGS ('dbx_business_glossary_term' = 'Graduation Year');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `last_login_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Login Timestamp');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `last_password_change_date` SET TAGS ('dbx_business_glossary_term' = 'Last Password Change Date');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Name');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `lockout_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Lockout Timestamp');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `mfa_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Multi-Factor Authentication (MFA) Enrolled');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `mfa_method` SET TAGS ('dbx_business_glossary_term' = 'Multi-Factor Authentication (MFA) Method');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `mfa_method` SET TAGS ('dbx_value_regex' = 'none|authenticator_app|sms|hardware_token|biometric|backup_codes');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `netid` SET TAGS ('dbx_business_glossary_term' = 'Network ID (NetID)');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `netid` SET TAGS ('dbx_value_regex' = '^[a-z][a-z0-9]{2,15}$');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `netid` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `netid` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `password_policy_group` SET TAGS ('dbx_business_glossary_term' = 'Password Policy Group');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `password_policy_group` SET TAGS ('dbx_value_regex' = 'standard|elevated|administrative|service');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `password_reset_required` SET TAGS ('dbx_business_glossary_term' = 'Password Reset Required');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `primary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `pronouns` SET TAGS ('dbx_business_glossary_term' = 'Pronouns');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'banner|workday|manual|ldap|saml_federation');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `source_system_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `source_system_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `sponsor_netid` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Network ID (NetID)');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `sponsor_netid` SET TAGS ('dbx_value_regex' = '^[a-z][a-z0-9]{2,15}$');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `sponsorship_end_date` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship End Date');
ALTER TABLE `education_ecm`.`technology`.`identity_account` ALTER COLUMN `sso_enabled` SET TAGS ('dbx_business_glossary_term' = 'Single Sign-On (SSO) Enabled');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` SET TAGS ('dbx_subdomain' = 'security_governance');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `access_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Access Entitlement Identifier (ID)');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `approval_workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Identifier (ID)');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Target Application Identifier (ID)');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Department Identifier (ID)');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `parent_access_entitlement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `access_entitlement_description` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Description');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `access_entitlement_status` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Status');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `access_entitlement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending_review|suspended');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `active_assignment_count` SET TAGS ('dbx_business_glossary_term' = 'Active Assignment Count');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `allows_bulk_operations` SET TAGS ('dbx_business_glossary_term' = 'Allows Bulk Operations Flag');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `allows_data_export` SET TAGS ('dbx_business_glossary_term' = 'Allows Data Export Flag');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `auto_revoke_on_expiry` SET TAGS ('dbx_business_glossary_term' = 'Auto-Revoke on Expiry Flag');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `business_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Business Owner Email Address');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `business_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `business_owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `business_owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `business_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Business Owner Name');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `certification_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Certification Frequency in Days');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `entitlement_category` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Category');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `entitlement_category` SET TAGS ('dbx_value_regex' = 'application_access|network_access|data_access|physical_access|privileged_access|shared_resource');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `entitlement_code` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Code');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `entitlement_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,50}$');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `entitlement_name` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Name');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `entitlement_type` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Type');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `entitlement_type` SET TAGS ('dbx_value_regex' = 'role|group|permission|privilege|profile');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `ferpa_protected` SET TAGS ('dbx_business_glossary_term' = 'Family Educational Rights and Privacy Act (FERPA) Protected Flag');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `is_privileged` SET TAGS ('dbx_business_glossary_term' = 'Is Privileged Access Flag');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `is_sod_restricted` SET TAGS ('dbx_business_glossary_term' = 'Is Segregation of Duties (SOD) Restricted Flag');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `last_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Certification Date');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `maximum_grant_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Grant Duration in Days');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `mfa_required` SET TAGS ('dbx_business_glossary_term' = 'Multi-Factor Authentication (MFA) Required Flag');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `network_zone` SET TAGS ('dbx_business_glossary_term' = 'Network Zone');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `network_zone` SET TAGS ('dbx_value_regex' = 'campus|vpn|remote|partner|public');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `next_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Next Certification Date');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `requires_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Approval Flag');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `sod_conflict_group` SET TAGS ('dbx_business_glossary_term' = 'Segregation of Duties (SOD) Conflict Group');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `target_system` SET TAGS ('dbx_business_glossary_term' = 'Target System');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `technical_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Technical Owner Name');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `usage_guidelines` SET TAGS ('dbx_business_glossary_term' = 'Usage Guidelines');
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` SET TAGS ('dbx_subdomain' = 'security_governance');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `access_provisioning_event_id` SET TAGS ('dbx_business_glossary_term' = 'Access Provisioning Event ID');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `access_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Access Certification ID');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `access_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Entitlement ID');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Target System ID');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By Identity ID');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Identity Account ID');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Request ID');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `quaternary_access_sod_exception_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'SOD Exception Approved By Identity ID');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `quaternary_access_sod_exception_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `quaternary_access_sod_exception_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `target_system_account_identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Target System Account ID');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `tertiary_access_executed_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Executed By Identity ID');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `tertiary_access_executed_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `tertiary_access_executed_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `reversal_access_provisioning_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Action Type');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'grant|modify|revoke|suspend|restore|extend');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `audit_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Log Reference');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Access Effective Date');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `emergency_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Access Flag');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `emergency_justification` SET TAGS ('dbx_business_glossary_term' = 'Emergency Access Justification');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Error Code');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Error Message');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Access Provisioning Event Number');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `event_number` SET TAGS ('dbx_value_regex' = '^APE-[0-9]{10}$');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Timestamp');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Access Expiration Date');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Source IP Address');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^(?:[0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `new_entitlement_value` SET TAGS ('dbx_business_glossary_term' = 'New Entitlement Value');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Notes');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `previous_entitlement_value` SET TAGS ('dbx_business_glossary_term' = 'Previous Entitlement Value');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `provisioning_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Duration in Seconds');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `provisioning_method` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Method');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `provisioning_status` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Status');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `provisioning_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed|rolled_back');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Retry Count');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Access Revocation Reason');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Access Risk Level');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `segregation_of_duties_check` SET TAGS ('dbx_business_glossary_term' = 'Segregation of Duties (SOD) Check Performed');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `session_reference` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `sod_conflict_detected` SET TAGS ('dbx_business_glossary_term' = 'SOD Conflict Detected');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `trigger_source` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Trigger Source');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`technology`.`service_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`technology`.`service_request` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request ID');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Related Incident ID');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `it_service_id` SET TAGS ('dbx_business_glossary_term' = 'It Service Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `knowledge_article_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Article ID');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester ID');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `tertiary_service_assigned_technician_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Technician ID');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `tertiary_service_assigned_technician_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `tertiary_service_assigned_technician_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `parent_service_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged Timestamp');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `actual_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Effort Hours');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `assigned_team` SET TAGS ('dbx_business_glossary_term' = 'Assigned Team');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `customer_feedback` SET TAGS ('dbx_business_glossary_term' = 'Customer Feedback');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `customer_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Score');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `escalated_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalated Flag');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `estimated_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Effort Hours');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `first_response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Response Timestamp');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `opened_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Opened Timestamp');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `reopened_count` SET TAGS ('dbx_business_glossary_term' = 'Reopened Count');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `request_category` SET TAGS ('dbx_business_glossary_term' = 'Request Category');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `request_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Request Subcategory');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `requester_email` SET TAGS ('dbx_business_glossary_term' = 'Requester Email Address');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `requester_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `requester_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `requester_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `requester_phone` SET TAGS ('dbx_business_glossary_term' = 'Requester Phone Number');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `requester_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `requester_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `requester_type` SET TAGS ('dbx_business_glossary_term' = 'Requester Type');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `requester_type` SET TAGS ('dbx_value_regex' = 'student|faculty|staff|contractor|guest');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `resolution_code` SET TAGS ('dbx_business_glossary_term' = 'Resolution Code');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `resolved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolved Timestamp');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `service_request_description` SET TAGS ('dbx_business_glossary_term' = 'Request Description');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `service_request_status` SET TAGS ('dbx_business_glossary_term' = 'Service Request Status');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `service_request_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending|resolved|closed|cancelled');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `sla_due_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Due Timestamp');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|vip');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Request Subject');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `submission_channel` SET TAGS ('dbx_business_glossary_term' = 'Submission Channel');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `submission_channel` SET TAGS ('dbx_value_regex' = 'portal|email|phone|walk_in|chat');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Ticket Number');
ALTER TABLE `education_ecm`.`technology`.`service_request` ALTER COLUMN `ticket_number` SET TAGS ('dbx_value_regex' = '^(INC|REQ|SR|TKT)[0-9]{7,10}$');
ALTER TABLE `education_ecm`.`technology`.`incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`technology`.`incident` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident ID');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `configuration_item_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Item Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By User ID');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Commander ID');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `incident_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Resolver ID');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `incident_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `incident_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `it_service_id` SET TAGS ('dbx_business_glossary_term' = 'It Service Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Related Change ID');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `problem_id` SET TAGS ('dbx_business_glossary_term' = 'Related Problem ID');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `parent_incident_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Timestamp');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `affected_system` SET TAGS ('dbx_business_glossary_term' = 'Affected System');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `affected_user_population_size` SET TAGS ('dbx_business_glossary_term' = 'Affected User Population Size');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `assigned_resolver_group` SET TAGS ('dbx_business_glossary_term' = 'Assigned Resolver Group');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `business_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Business Impact Description');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `closure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closure Timestamp');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `communication_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Communication Sent Flag');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'monitoring_alert|user_report|automated_scan|routine_check|third_party_notification');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Financial Impact');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `incident_category` SET TAGS ('dbx_business_glossary_term' = 'Incident Category');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `incident_category` SET TAGS ('dbx_value_regex' = 'network_outage|system_down|security_breach|application_error|data_loss|hardware_failure');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_value_regex' = '^INC[0-9]{7,10}$');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `pir_reference` SET TAGS ('dbx_business_glossary_term' = 'Post-Incident Review (PIR) Reference');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `reported_by_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Reported By Contact Method');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `reported_by_contact_method` SET TAGS ('dbx_value_regex' = 'phone|email|web_portal|chat|walk_in');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `reported_by_user_name` SET TAGS ('dbx_business_glossary_term' = 'Reported By User Name');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `reported_by_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `reported_by_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'P1|P2|P3|P4');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `sla_actual_resolution_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Actual Resolution Minutes');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `sla_target_resolution_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Resolution Minutes');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Incident Subcategory');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `user_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'User Satisfaction Rating');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `workaround_applied` SET TAGS ('dbx_business_glossary_term' = 'Workaround Applied');
ALTER TABLE `education_ecm`.`technology`.`incident` ALTER COLUMN `workaround_description` SET TAGS ('dbx_business_glossary_term' = 'Workaround Description');
ALTER TABLE `education_ecm`.`technology`.`change_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`technology`.`change_request` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Change Request ID');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `configuration_item_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Item Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `it_project_id` SET TAGS ('dbx_business_glossary_term' = 'It Project Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester ID');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `rollback_change_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `actual_downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Downtime Minutes');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `affected_services` SET TAGS ('dbx_business_glossary_term' = 'Affected Services');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `affected_user_count` SET TAGS ('dbx_business_glossary_term' = 'Affected User Count');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `assigned_to_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Name');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `cab_approval_notes` SET TAGS ('dbx_business_glossary_term' = 'Change Advisory Board (CAB) Approval Notes');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `cab_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Change Advisory Board (CAB) Approval Status');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `cab_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional|not_required');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `cab_review_date` SET TAGS ('dbx_business_glossary_term' = 'Change Advisory Board (CAB) Review Date');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `change_category` SET TAGS ('dbx_business_glossary_term' = 'Change Category');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `change_category` SET TAGS ('dbx_value_regex' = 'infrastructure|application|configuration|security|network|database');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `change_freeze_exception` SET TAGS ('dbx_business_glossary_term' = 'Change Freeze Exception');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `change_number` SET TAGS ('dbx_business_glossary_term' = 'Change Number');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `change_number` SET TAGS ('dbx_value_regex' = '^CHG[0-9]{7}$');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `change_status` SET TAGS ('dbx_business_glossary_term' = 'Change Status');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'standard|normal|emergency|expedited');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `closure_notes` SET TAGS ('dbx_business_glossary_term' = 'Closure Notes');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `detailed_description` SET TAGS ('dbx_business_glossary_term' = 'Change Detailed Description');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `downtime_required` SET TAGS ('dbx_business_glossary_term' = 'Downtime Required');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `estimated_downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Downtime Minutes');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `implementation_notes` SET TAGS ('dbx_business_glossary_term' = 'Implementation Notes');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `implementation_outcome` SET TAGS ('dbx_business_glossary_term' = 'Implementation Outcome');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `implementation_outcome` SET TAGS ('dbx_value_regex' = 'successful|failed|partially_successful|rolled_back');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `post_implementation_review_date` SET TAGS ('dbx_business_glossary_term' = 'Post-Implementation Review Date');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `post_implementation_review_notes` SET TAGS ('dbx_business_glossary_term' = 'Post-Implementation Review Notes');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `related_incident_number` SET TAGS ('dbx_business_glossary_term' = 'Related Incident Number');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `related_problem_number` SET TAGS ('dbx_business_glossary_term' = 'Related Problem Number');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `requester_department` SET TAGS ('dbx_business_glossary_term' = 'Requester Department');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `requester_name` SET TAGS ('dbx_business_glossary_term' = 'Requester Name');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `rollback_plan` SET TAGS ('dbx_business_glossary_term' = 'Rollback Plan');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `scheduled_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Timestamp');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Change Short Description');
ALTER TABLE `education_ecm`.`technology`.`change_request` ALTER COLUMN `test_plan` SET TAGS ('dbx_business_glossary_term' = 'Test Plan');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` SET TAGS ('dbx_subdomain' = 'asset_operations');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `configuration_item_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Item (CI) Identifier');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `it_contract_id` SET TAGS ('dbx_business_glossary_term' = 'It Contract Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `parent_configuration_item_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `backup_frequency` SET TAGS ('dbx_business_glossary_term' = 'Backup Frequency');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `backup_frequency` SET TAGS ('dbx_value_regex' = 'real_time|hourly|daily|weekly|monthly|on_demand');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `backup_required` SET TAGS ('dbx_business_glossary_term' = 'Backup Required');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `business_service_name` SET TAGS ('dbx_business_glossary_term' = 'Business Service Name');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `ci_class` SET TAGS ('dbx_business_glossary_term' = 'Configuration Item (CI) Class');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `ci_identifier` SET TAGS ('dbx_business_glossary_term' = 'Configuration Item (CI) Business Identifier');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `ci_name` SET TAGS ('dbx_business_glossary_term' = 'Configuration Item (CI) Name');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `ci_subtype` SET TAGS ('dbx_business_glossary_term' = 'Configuration Item (CI) Subtype');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `ci_type` SET TAGS ('dbx_business_glossary_term' = 'Configuration Item (CI) Type');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `compliance_scope` SET TAGS ('dbx_business_glossary_term' = 'Compliance Scope');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `criticality` SET TAGS ('dbx_business_glossary_term' = 'Criticality');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `criticality` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `discovery_source` SET TAGS ('dbx_business_glossary_term' = 'Discovery Source');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `discovery_source` SET TAGS ('dbx_value_regex' = 'automated_scan|manual_entry|import|api_integration|service_desk');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `discovery_tool` SET TAGS ('dbx_business_glossary_term' = 'Discovery Tool');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `dr_tier` SET TAGS ('dbx_business_glossary_term' = 'Disaster Recovery (DR) Tier');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `dr_tier` SET TAGS ('dbx_value_regex' = 'tier_0|tier_1|tier_2|tier_3|tier_4');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `environment` SET TAGS ('dbx_business_glossary_term' = 'Environment');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Go-Live Date');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `hostname` SET TAGS ('dbx_business_glossary_term' = 'Hostname');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `last_discovered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Discovered Timestamp');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `license_count` SET TAGS ('dbx_business_glossary_term' = 'License Count');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_value_regex' = 'planning|development|testing|production|retirement|disposed');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `location_building_code` SET TAGS ('dbx_business_glossary_term' = 'Location Building Code');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `location_room_number` SET TAGS ('dbx_business_glossary_term' = 'Location Room Number');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `mac_address` SET TAGS ('dbx_business_glossary_term' = 'Media Access Control (MAC) Address');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `mac_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `mac_address` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System (OS)');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'operational|non_operational|under_repair|retired|planned|ordered');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `owning_department_code` SET TAGS ('dbx_business_glossary_term' = 'Owning Department Code');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `owning_department_name` SET TAGS ('dbx_business_glossary_term' = 'Owning Department Name');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `support_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Support Expiration Date');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `support_team` SET TAGS ('dbx_business_glossary_term' = 'Support Team');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `support_tier` SET TAGS ('dbx_business_glossary_term' = 'Support Tier');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `support_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|vendor|specialized');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `education_ecm`.`technology`.`configuration_item` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` SET TAGS ('dbx_subdomain' = 'security_governance');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `cybersecurity_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Cybersecurity Incident Identifier (ID)');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Investigator Identifier (ID)');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By User Identifier (ID)');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `related_cybersecurity_incident_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `affected_data_types` SET TAGS ('dbx_business_glossary_term' = 'Affected Data Types');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `affected_systems` SET TAGS ('dbx_business_glossary_term' = 'Affected Systems');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `assigned_investigator_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned Investigator Name');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `attack_vector` SET TAGS ('dbx_business_glossary_term' = 'Attack Vector');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `closure_notes` SET TAGS ('dbx_business_glossary_term' = 'Closure Notes');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `containment_actions` SET TAGS ('dbx_business_glossary_term' = 'Containment Actions');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `containment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Containment Timestamp');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `data_sensitivity_level` SET TAGS ('dbx_business_glossary_term' = 'Data Sensitivity Level');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `data_sensitivity_level` SET TAGS ('dbx_value_regex' = 'ferpa_protected|hipaa_phi|pci_dss|research_controlled|public');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `detection_source` SET TAGS ('dbx_business_glossary_term' = 'Detection Source');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `detection_source` SET TAGS ('dbx_value_regex' = 'siem_alert|user_report|threat_intel_feed|vulnerability_scan|audit_log_review|external_notification');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `eradication_actions` SET TAGS ('dbx_business_glossary_term' = 'Eradication Actions');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `eradication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Eradication Timestamp');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Financial Impact');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `estimated_record_count` SET TAGS ('dbx_business_glossary_term' = 'Estimated Record Count');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `forensic_evidence_collected_flag` SET TAGS ('dbx_business_glossary_term' = 'Forensic Evidence Collected Flag');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `forensic_evidence_location` SET TAGS ('dbx_business_glossary_term' = 'Forensic Evidence Location');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `forensic_evidence_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `incident_classification` SET TAGS ('dbx_business_glossary_term' = 'Incident Classification');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `incident_classification` SET TAGS ('dbx_value_regex' = 'phishing|malware|unauthorized_access|data_breach|ransomware|insider_threat');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'new|investigating|contained|eradicated|recovered|closed');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `law_enforcement_case_number` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Case Number');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `law_enforcement_case_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `law_enforcement_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Notified Flag');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `lessons_learned_summary` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned Summary');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `mitre_attack_techniques` SET TAGS ('dbx_business_glossary_term' = 'MITRE ATT&CK Techniques');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `notification_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Completed Date');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `notification_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Deadline Date');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `notification_obligations` SET TAGS ('dbx_business_glossary_term' = 'Notification Obligations');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Required Flag');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `recovery_actions` SET TAGS ('dbx_business_glossary_term' = 'Recovery Actions');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `recovery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recovery Timestamp');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `reported_by_user_name` SET TAGS ('dbx_business_glossary_term' = 'Reported By User Name');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `reported_by_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `reported_by_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `threat_actor_type` SET TAGS ('dbx_business_glossary_term' = 'Threat Actor Type');
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ALTER COLUMN `threat_actor_type` SET TAGS ('dbx_value_regex' = 'nation_state|organized_crime|hacktivist|insider|opportunistic|unknown');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` SET TAGS ('dbx_subdomain' = 'security_governance');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `vulnerability_id` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Identifier (ID)');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `configuration_item_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Item Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `related_vulnerability_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `affected_software_name` SET TAGS ('dbx_business_glossary_term' = 'Affected Software Name');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `affected_software_vendor` SET TAGS ('dbx_business_glossary_term' = 'Affected Software Vendor');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `affected_software_version` SET TAGS ('dbx_business_glossary_term' = 'Affected Software Version');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `affected_system_count` SET TAGS ('dbx_business_glossary_term' = 'Affected System Count');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `business_criticality` SET TAGS ('dbx_business_glossary_term' = 'Affected System Business Criticality');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `business_criticality` SET TAGS ('dbx_value_regex' = 'mission-critical|high|medium|low');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `compliance_framework_impact` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework Impact');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `cve_identifier` SET TAGS ('dbx_business_glossary_term' = 'Common Vulnerabilities and Exposures (CVE) Identifier');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `cve_identifier` SET TAGS ('dbx_value_regex' = '^CVE-d{4}-d{4,}$');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `cvss_base_score` SET TAGS ('dbx_business_glossary_term' = 'Common Vulnerability Scoring System (CVSS) Base Score');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `cvss_vector_string` SET TAGS ('dbx_business_glossary_term' = 'Common Vulnerability Scoring System (CVSS) Vector String');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `data_classification_exposure` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Exposure Level');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `data_classification_exposure` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Discovery Date');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `discovery_source` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Discovery Source');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `discovery_source` SET TAGS ('dbx_value_regex' = 'automated-scan|penetration-test|vendor-advisory|security-research|incident-response|manual-audit');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `exploitability_assessment` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Exploitability Assessment');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `exploitability_assessment` SET TAGS ('dbx_value_regex' = 'active-exploit|proof-of-concept|theoretical|unlikely');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `false_positive_justification` SET TAGS ('dbx_business_glossary_term' = 'False Positive Justification');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `network_exposure` SET TAGS ('dbx_business_glossary_term' = 'Network Exposure Classification');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `network_exposure` SET TAGS ('dbx_value_regex' = 'internet-facing|internal|isolated|dmz');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Management Notes');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `patch_identifier` SET TAGS ('dbx_business_glossary_term' = 'Security Patch Identifier (ID)');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `remediation_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Remediation Action Taken');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `remediation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Remediation Completed Date');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Remediation Due Date');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `remediation_owner_department` SET TAGS ('dbx_business_glossary_term' = 'Remediation Owner Department');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `remediation_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Remediation Owner Name');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Remediation Status');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'open|in-remediation|remediated|accepted-risk|false-positive|mitigated');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `risk_acceptance_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Acceptance Approval Date');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `risk_acceptance_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Risk Acceptance Approver Name');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `risk_acceptance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Acceptance Expiration Date');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `risk_acceptance_justification` SET TAGS ('dbx_business_glossary_term' = 'Risk Acceptance Justification');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `scan_identifier` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Scan Identifier (ID)');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `scanning_tool_name` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Scanning Tool Name');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Severity Level');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `threat_intelligence_indicator` SET TAGS ('dbx_business_glossary_term' = 'Threat Intelligence Indicator');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Title');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `verification_scan_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Verification Scan Date');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Verification Status');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending-verification|failed-verification|not-applicable');
ALTER TABLE `education_ecm`.`technology`.`vulnerability` ALTER COLUMN `vulnerability_description` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Description');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Application ID');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `configuration_item_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Item Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `parent_enterprise_application_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `accessibility_compliance_level` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Compliance Level');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `accessibility_compliance_level` SET TAGS ('dbx_value_regex' = 'WCAG 2.0 AA|WCAG 2.1 AA|WCAG 2.2 AA|Section 508|Not Compliant|Unknown');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `api_availability` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Availability');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `api_availability` SET TAGS ('dbx_value_regex' = 'REST API|SOAP API|GraphQL|Proprietary|None');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `application_category` SET TAGS ('dbx_business_glossary_term' = 'Application Category');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `application_code` SET TAGS ('dbx_business_glossary_term' = 'Application Code');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `application_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `application_name` SET TAGS ('dbx_business_glossary_term' = 'Application Name');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'SSO|SAML|LDAP|Local|OAuth|Multi-Factor');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `backup_frequency` SET TAGS ('dbx_business_glossary_term' = 'Backup Frequency');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `backup_frequency` SET TAGS ('dbx_value_regex' = 'Real-Time|Hourly|Daily|Weekly|Monthly|None');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `business_application_owner` SET TAGS ('dbx_business_glossary_term' = 'Business Application Owner');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `compliance_frameworks` SET TAGS ('dbx_business_glossary_term' = 'Compliance Frameworks');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_value_regex' = 'Mission Critical|High|Medium|Low');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `data_residency_location` SET TAGS ('dbx_business_glossary_term' = 'Data Residency Location');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `deployment_model` SET TAGS ('dbx_business_glossary_term' = 'Deployment Model');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `deployment_model` SET TAGS ('dbx_value_regex' = 'On-Premise|Cloud SaaS|Hybrid|Hosted|IaaS|PaaS');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `disaster_recovery_tier` SET TAGS ('dbx_business_glossary_term' = 'Disaster Recovery (DR) Tier');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `disaster_recovery_tier` SET TAGS ('dbx_value_regex' = 'Tier 1|Tier 2|Tier 3|Tier 4');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Go-Live Date');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `hosting_environment` SET TAGS ('dbx_business_glossary_term' = 'Hosting Environment');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `integration_dependencies` SET TAGS ('dbx_business_glossary_term' = 'Integration Dependencies');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `is_mobile_enabled` SET TAGS ('dbx_business_glossary_term' = 'Is Mobile Enabled');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `is_mobile_enabled` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `is_mobile_enabled` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `is_sso_enabled` SET TAGS ('dbx_business_glossary_term' = 'Is Single Sign-On (SSO) Enabled');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `it_application_owner` SET TAGS ('dbx_business_glossary_term' = 'Information Technology (IT) Application Owner');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `last_security_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Security Assessment Date');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'Active|Sunset Planned|Decommissioned|Under Evaluation|Implementation|Pilot');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `owning_department_code` SET TAGS ('dbx_business_glossary_term' = 'Owning Department Code');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `primary_business_function` SET TAGS ('dbx_business_glossary_term' = 'Primary Business Function');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `product_version` SET TAGS ('dbx_business_glossary_term' = 'Product Version');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `replacement_application_code` SET TAGS ('dbx_business_glossary_term' = 'Replacement Application Code');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `sunset_date` SET TAGS ('dbx_business_glossary_term' = 'Sunset Date');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `support_tier` SET TAGS ('dbx_business_glossary_term' = 'Support Tier');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `support_tier` SET TAGS ('dbx_value_regex' = '24x7|Business Hours|Best Effort|Vendor Only');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `total_user_count` SET TAGS ('dbx_business_glossary_term' = 'Total User Count');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `user_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'User Satisfaction Score');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `education_ecm`.`technology`.`enterprise_application` ALTER COLUMN `vendor_support_contact` SET TAGS ('dbx_business_glossary_term' = 'Vendor Support Contact');
ALTER TABLE `education_ecm`.`technology`.`application_integration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`technology`.`application_integration` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `application_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Application Integration Identifier (ID)');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Source Application Identifier (ID)');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `target_application_enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Target Application Identifier (ID)');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `superseded_application_integration_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'OAuth 2.0|SAML|API Key|Basic Auth|Certificate|SSO|Kerberos');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `average_record_volume` SET TAGS ('dbx_business_glossary_term' = 'Average Record Volume');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `business_criticality` SET TAGS ('dbx_business_glossary_term' = 'Business Criticality');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `business_criticality` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `data_objects_exchanged` SET TAGS ('dbx_business_glossary_term' = 'Data Objects Exchanged');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `data_sensitivity_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Sensitivity Classification');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `data_sensitivity_classification` SET TAGS ('dbx_value_regex' = 'Restricted|Confidential|Internal|Public');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `data_transformation_required` SET TAGS ('dbx_business_glossary_term' = 'Data Transformation Required Flag');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `dependency_notes` SET TAGS ('dbx_business_glossary_term' = 'Dependency Notes');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `encryption_enabled` SET TAGS ('dbx_business_glossary_term' = 'Encryption Enabled Flag');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `error_handling_approach` SET TAGS ('dbx_business_glossary_term' = 'Error Handling Approach');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `error_handling_approach` SET TAGS ('dbx_value_regex' = 'Retry|Alert and Stop|Log and Continue|Dead Letter Queue|Manual Intervention');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `integration_code` SET TAGS ('dbx_business_glossary_term' = 'Integration Code');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `integration_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `integration_description` SET TAGS ('dbx_business_glossary_term' = 'Integration Description');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `integration_frequency` SET TAGS ('dbx_business_glossary_term' = 'Integration Frequency');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `integration_name` SET TAGS ('dbx_business_glossary_term' = 'Integration Name');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `integration_owner` SET TAGS ('dbx_business_glossary_term' = 'Integration Owner');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `integration_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Integration Owner Email Address');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `integration_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `integration_owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `integration_pattern` SET TAGS ('dbx_business_glossary_term' = 'Integration Pattern');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `integration_pattern` SET TAGS ('dbx_value_regex' = 'API|ETL Batch|Event-Driven|File Transfer|Database Replication|Messaging Queue');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `last_failed_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Failed Run Timestamp');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `last_successful_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Successful Run Timestamp');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `middleware_platform` SET TAGS ('dbx_business_glossary_term' = 'Middleware Platform');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `monitoring_dashboard_url` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Dashboard Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Suspended|Deprecated|In Development|Testing');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `peak_record_volume` SET TAGS ('dbx_business_glossary_term' = 'Peak Record Volume');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `sla_target_latency_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Latency Minutes');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `technical_contact` SET TAGS ('dbx_business_glossary_term' = 'Technical Contact');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Technical Contact Email Address');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`application_integration` ALTER COLUMN `transformation_logic_description` SET TAGS ('dbx_business_glossary_term' = 'Transformation Logic Description');
ALTER TABLE `education_ecm`.`technology`.`it_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`technology`.`it_project` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `it_project_id` SET TAGS ('dbx_business_glossary_term' = 'Information Technology (IT) Project ID');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `grant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `it_contract_id` SET TAGS ('dbx_business_glossary_term' = 'It Contract Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Business Sponsor ID');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `sport_id` SET TAGS ('dbx_business_glossary_term' = 'Sport Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `tertiary_it_business_sponsor_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `parent_it_project_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `accessibility_review_completed` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Review Completed');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `budget_committed` SET TAGS ('dbx_business_glossary_term' = 'Budget Committed');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `budget_spent_to_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Spent to Date');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `change_management_required` SET TAGS ('dbx_business_glossary_term' = 'Change Management Required');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `complexity_score` SET TAGS ('dbx_business_glossary_term' = 'Complexity Score');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `compliance_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Impact Flag');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `forecast_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Completion Date');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'operating_budget|capital_budget|grant|auxiliary|restricted_fund|bond_proceeds');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `governance_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Governance Approval Date');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `governance_review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Governance Review Frequency');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `governance_review_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|quarterly|milestone_based');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `impacted_system_count` SET TAGS ('dbx_business_glossary_term' = 'Impacted System Count');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `impacted_user_count` SET TAGS ('dbx_business_glossary_term' = 'Impacted User Count');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `project_category` SET TAGS ('dbx_business_glossary_term' = 'Project Category');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `project_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4,6}$');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Description');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `project_phase` SET TAGS ('dbx_business_glossary_term' = 'Project Phase');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `project_phase` SET TAGS ('dbx_value_regex' = 'initiation|planning|execution|monitoring|closeout');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `project_status` SET TAGS ('dbx_value_regex' = 'on_track|at_risk|delayed|on_hold|completed|cancelled');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `security_review_completed` SET TAGS ('dbx_business_glossary_term' = 'Security Review Completed');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `strategic_alignment_category` SET TAGS ('dbx_business_glossary_term' = 'Strategic Alignment Category');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `strategic_alignment_category` SET TAGS ('dbx_value_regex' = 'student_success|operational_excellence|research_advancement|financial_sustainability|regulatory_compliance|digital_transformation');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `total_approved_budget` SET TAGS ('dbx_business_glossary_term' = 'Total Approved Budget');
ALTER TABLE `education_ecm`.`technology`.`it_project` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `education_ecm`.`technology`.`it_service` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`technology`.`it_service` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `it_service_id` SET TAGS ('dbx_business_glossary_term' = 'Information Technology (IT) Service Identifier');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `it_contract_id` SET TAGS ('dbx_business_glossary_term' = 'It Contract Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Service Owner Employee Identifier');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `primary_it_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By Employee Identifier');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `primary_it_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `primary_it_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `parent_it_service_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `annual_operating_cost` SET TAGS ('dbx_business_glossary_term' = 'Annual Operating Cost');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `annual_operating_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `availability_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Availability Target Percentage');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `backup_frequency` SET TAGS ('dbx_business_glossary_term' = 'Backup Frequency');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `backup_frequency` SET TAGS ('dbx_value_regex' = 'real_time|hourly|daily|weekly|monthly|none');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `contract_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiration Date');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `cost_recovery_model` SET TAGS ('dbx_business_glossary_term' = 'Cost Recovery Model');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `cost_recovery_model` SET TAGS ('dbx_value_regex' = 'centrally_funded|chargeback|grant_funded|hybrid|cost_share');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `disaster_recovery_tier` SET TAGS ('dbx_business_glossary_term' = 'Disaster Recovery Tier');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `disaster_recovery_tier` SET TAGS ('dbx_value_regex' = 'tier_0|tier_1|tier_2|tier_3|tier_4');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `ferpa_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Family Educational Rights and Privacy Act (FERPA) Applicable Flag');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `hipaa_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Applicable Flag');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Service Notes');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `pci_dss_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Card Industry Data Security Standard (PCI DSS) Applicable Flag');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `planned_maintenance_window` SET TAGS ('dbx_business_glossary_term' = 'Planned Maintenance Window');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `primary_user_population` SET TAGS ('dbx_business_glossary_term' = 'Primary User Population');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `self_service_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Self-Service Enabled Flag');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `service_catalog_visibility` SET TAGS ('dbx_business_glossary_term' = 'Service Catalog Visibility');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `service_catalog_visibility` SET TAGS ('dbx_value_regex' = 'public|restricted|internal|hidden');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `service_code` SET TAGS ('dbx_business_glossary_term' = 'Service Code');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `service_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `service_delivery_model` SET TAGS ('dbx_business_glossary_term' = 'Service Delivery Model');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `service_delivery_model` SET TAGS ('dbx_value_regex' = 'on_premise|cloud_saas|cloud_iaas|cloud_paas|hybrid|managed_service');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `service_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Service Launch Date');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `service_name` SET TAGS ('dbx_business_glossary_term' = 'Service Name');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `service_retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Service Retirement Date');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'Service Status');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `service_status` SET TAGS ('dbx_value_regex' = 'active|limited|degraded|maintenance|retired|planned');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `service_url` SET TAGS ('dbx_business_glossary_term' = 'Service Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'gold|silver|bronze|standard|basic');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `support_email` SET TAGS ('dbx_business_glossary_term' = 'Support Email Address');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `support_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `support_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `support_phone` SET TAGS ('dbx_business_glossary_term' = 'Support Phone Number');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `support_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `support_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `support_team_name` SET TAGS ('dbx_business_glossary_term' = 'Support Team Name');
ALTER TABLE `education_ecm`.`technology`.`it_service` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `it_service_outage_id` SET TAGS ('dbx_business_glossary_term' = 'Information Technology (IT) Service Outage ID');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `athletic_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Athletic Facility Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Change Request Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `it_service_id` SET TAGS ('dbx_business_glossary_term' = 'Information Technology (IT) Service ID');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Technician ID');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `related_it_service_outage_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `affected_campus_locations` SET TAGS ('dbx_business_glossary_term' = 'Affected Campus Locations');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `affected_user_count_estimate` SET TAGS ('dbx_business_glossary_term' = 'Affected User Population Estimate');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `assigned_support_team` SET TAGS ('dbx_business_glossary_term' = 'Assigned Support Team');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `business_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Business Impact Description');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `communication_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Communication Sent Flag');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `communication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Communication Timestamp');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `detected_by_source` SET TAGS ('dbx_business_glossary_term' = 'Detection Source');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `detected_by_source` SET TAGS ('dbx_value_regex' = 'monitoring_system|user_report|service_desk|automated_alert|vendor_notification');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `detected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Outage Duration in Minutes');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Outage End Timestamp');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Financial Impact');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `outage_number` SET TAGS ('dbx_business_glossary_term' = 'Outage Reference Number');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `outage_status` SET TAGS ('dbx_business_glossary_term' = 'Outage Status');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `outage_status` SET TAGS ('dbx_value_regex' = 'active|resolved|monitoring|closed');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `outage_type` SET TAGS ('dbx_business_glossary_term' = 'Outage Type');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `outage_type` SET TAGS ('dbx_value_regex' = 'planned_maintenance|unplanned_outage|partial_degradation|emergency_maintenance');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `post_outage_review_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Post-Outage Review Completed Flag');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `post_outage_review_date` SET TAGS ('dbx_business_glossary_term' = 'Post-Outage Review Date');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `preventive_action_description` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Description');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `preventive_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Required Flag');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `problem_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Problem Ticket Number');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'hardware_failure|software_bug|network_issue|configuration_error|capacity_overload|security_incident');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `sla_target_availability_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Availability Percentage');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Outage Start Timestamp');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `vendor_involved_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Involved Flag');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `vendor_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Ticket Number');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `workaround_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Workaround Available Flag');
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ALTER COLUMN `workaround_description` SET TAGS ('dbx_business_glossary_term' = 'Workaround Description');
ALTER TABLE `education_ecm`.`technology`.`it_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`technology`.`it_contract` SET TAGS ('dbx_subdomain' = 'asset_operations');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `it_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Information Technology (IT) Contract Identifier');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `finance_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User Identifier');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `last_modified_by_user_identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User Identifier');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `last_modified_by_user_identity_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `last_modified_by_user_identity_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Employee Identifier');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `primary_it_relationship_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Information Technology (IT) Relationship Manager Employee Identifier');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `primary_it_relationship_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `primary_it_relationship_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `renewed_it_contract_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `annual_cost` SET TAGS ('dbx_business_glossary_term' = 'Annual Cost');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `business_associate_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Business Associate Agreement (BAA) Flag');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `contract_description` SET TAGS ('dbx_business_glossary_term' = 'Contract Description');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'active|pending_renewal|expired|terminated|draft|suspended');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `data_privacy_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Compliance Flag');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `insurance_requirement_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirement Met Flag');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `last_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renewal Date');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|one_time|usage_based');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period in Days');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `service_level_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Flag');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `termination_for_convenience_flag` SET TAGS ('dbx_business_glossary_term' = 'Termination for Convenience Flag');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Email Address');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Name');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Phone Number');
ALTER TABLE `education_ecm`.`technology`.`it_contract` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_risk` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`technology`.`it_risk` SET TAGS ('dbx_subdomain' = 'security_governance');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `it_risk_id` SET TAGS ('dbx_business_glossary_term' = 'Information Technology (IT) Risk Identifier');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `configuration_item_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Configuration Item Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Enterprise Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `it_service_id` SET TAGS ('dbx_business_glossary_term' = 'Affected It Service Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Related Audit Finding Identifier');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Related Incident Identifier');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `primary_it_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Owner Identifier');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `primary_it_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `primary_it_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `parent_it_risk_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `actual_remediation_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Remediation Date');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `business_continuity_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Business Continuity Impact Flag');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `control_description` SET TAGS ('dbx_business_glossary_term' = 'Control Description');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `control_effectiveness` SET TAGS ('dbx_business_glossary_term' = 'Control Effectiveness');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `control_effectiveness` SET TAGS ('dbx_value_regex' = 'effective|partially_effective|ineffective|not_implemented');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `data_breach_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Breach Risk Flag');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'operational|tactical|strategic|executive');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `financial_impact_estimate` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Estimate');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `impact_rating` SET TAGS ('dbx_business_glossary_term' = 'Impact Rating');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `inherent_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Score');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `likelihood_rating` SET TAGS ('dbx_business_glossary_term' = 'Likelihood Rating');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Risk Notes');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `reputational_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Reputational Impact Flag');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `residual_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Score');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `risk_appetite_alignment` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Alignment');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `risk_appetite_alignment` SET TAGS ('dbx_value_regex' = 'within_appetite|exceeds_appetite|requires_review');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'cybersecurity|operational|vendor|compliance|disaster_recovery|data_privacy');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `risk_identification_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Identification Date');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `risk_number` SET TAGS ('dbx_business_glossary_term' = 'Risk Number');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `risk_owner_department` SET TAGS ('dbx_business_glossary_term' = 'Risk Owner Department');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `risk_source` SET TAGS ('dbx_business_glossary_term' = 'Risk Source');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `risk_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Status');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `risk_status` SET TAGS ('dbx_value_regex' = 'open|mitigating|accepted|closed|monitoring');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `risk_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Risk Subcategory');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `risk_title` SET TAGS ('dbx_business_glossary_term' = 'Risk Title');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `risk_treatment_strategy` SET TAGS ('dbx_business_glossary_term' = 'Risk Treatment Strategy');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `risk_treatment_strategy` SET TAGS ('dbx_value_regex' = 'accept|mitigate|transfer|avoid');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `risk_treatment_strategy` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `risk_treatment_strategy` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `target_remediation_date` SET TAGS ('dbx_business_glossary_term' = 'Target Remediation Date');
ALTER TABLE `education_ecm`.`technology`.`it_risk` ALTER COLUMN `third_party_vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Vendor Name');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `it_sla_record_id` SET TAGS ('dbx_business_glossary_term' = 'Information Technology (IT) Service Level Agreement (SLA) Record Identifier (ID)');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `it_service_id` SET TAGS ('dbx_business_glossary_term' = 'Information Technology (IT) Service Identifier (ID)');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Service Owner Identifier (ID)');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `prior_it_sla_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `actual_availability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Actual Availability Percentage');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `actual_first_contact_resolution_percentage` SET TAGS ('dbx_business_glossary_term' = 'Actual First Contact Resolution (FCR) Percentage');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `actual_mttr_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Mean Time to Resolve (MTTR) Hours');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `actual_response_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Actual Response Time Seconds');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `availability_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Availability Target Percentage');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `change_success_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Change Success Rate Percentage');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `customer_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Score');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `first_contact_resolution_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'First Contact Resolution (FCR) Target Percentage');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `governance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Governance Review Date');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `improvement_action_description` SET TAGS ('dbx_business_glossary_term' = 'Improvement Action Description');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `improvement_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Improvement Action Required Flag');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `major_incidents_count` SET TAGS ('dbx_business_glossary_term' = 'Major Incidents Count');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `mttr_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time to Resolve (MTTR) Target Hours');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `planned_downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Planned Downtime Minutes');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `reporting_period_type` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Type');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `reporting_period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|weekly');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `reporting_status` SET TAGS ('dbx_business_glossary_term' = 'Reporting Status');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `reporting_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|published');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `response_time_target_seconds` SET TAGS ('dbx_business_glossary_term' = 'Response Time Target Seconds');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `sla_breach_count` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Count');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Met Flag');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `sla_record_number` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Record Number');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard|basic');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `total_downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Downtime Minutes');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `total_incidents_count` SET TAGS ('dbx_business_glossary_term' = 'Total Incidents Count');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `total_service_requests_count` SET TAGS ('dbx_business_glossary_term' = 'Total Service Requests Count');
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ALTER COLUMN `unplanned_downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Unplanned Downtime Minutes');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `it_chargeback_id` SET TAGS ('dbx_business_glossary_term' = 'Information Technology (IT) Chargeback ID');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Approver ID');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `grant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `it_service_id` SET TAGS ('dbx_business_glossary_term' = 'It Service Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) ID');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `reversal_it_chargeback_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `chargeback_method` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Method');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `chargeback_method` SET TAGS ('dbx_value_regex' = 'Actual Consumption|Allocation Formula|Flat Rate|Tiered Rate|Subscription');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `chargeback_number` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Transaction Number');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `chargeback_number` SET TAGS ('dbx_value_regex' = '^CHG-[0-9]{8}$');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `charged_department_code` SET TAGS ('dbx_business_glossary_term' = 'Charged Department Code');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `charged_department_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `charged_department_name` SET TAGS ('dbx_business_glossary_term' = 'Charged Department Name');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `consumption_quantity` SET TAGS ('dbx_business_glossary_term' = 'Service Consumption Quantity');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^INV-[0-9]{8,10}$');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `net_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Charge Amount');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Notes');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'Pending|Paid|Partially Paid|Overdue|Disputed|Waived');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Research Project Code');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'IT Service Category');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `total_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Charge Amount');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Transaction Date');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate');
ALTER TABLE `education_ecm`.`technology`.`it_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`technology`.`it_policy` SET TAGS ('dbx_subdomain' = 'security_governance');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `it_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Information Technology (IT) Policy Identifier');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By Identifier');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `primary_it_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner Identifier');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `primary_it_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `primary_it_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `superseded_policy_it_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Policy Identifier');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `superseded_it_policy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `acknowledgment_count` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Count');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `acknowledgment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Required Flag');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `applicable_audience` SET TAGS ('dbx_business_glossary_term' = 'Applicable Audience');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `communication_date` SET TAGS ('dbx_business_glossary_term' = 'Communication Date');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `communication_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Communication Sent Flag');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `document_repository_path` SET TAGS ('dbx_business_glossary_term' = 'Document Repository Path');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `enforcement_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Mechanism');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `enforcement_mechanism` SET TAGS ('dbx_value_regex' = 'technical-control|administrative-review|user-acknowledgment|audit|none');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `exception_process_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Process Description');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `policy_category` SET TAGS ('dbx_business_glossary_term' = 'Policy Category');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Policy Name');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_value_regex' = '^IT-POL-[0-9]{4}$');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'draft|active|under-review|retired|superseded');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Policy Type');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'policy|standard|procedure|guideline');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `regulatory_driver` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Driver');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `related_policy_ids` SET TAGS ('dbx_business_glossary_term' = 'Related Policy Identifiers');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle in Months');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `education_ecm`.`technology`.`it_policy` ALTER COLUMN `violation_consequence` SET TAGS ('dbx_business_glossary_term' = 'Violation Consequence');
ALTER TABLE `education_ecm`.`technology`.`application_contract_coverage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`technology`.`application_contract_coverage` SET TAGS ('dbx_subdomain' = 'asset_operations');
ALTER TABLE `education_ecm`.`technology`.`application_contract_coverage` SET TAGS ('dbx_association_edges' = 'technology.enterprise_application,technology.it_contract');
ALTER TABLE `education_ecm`.`technology`.`application_contract_coverage` ALTER COLUMN `application_contract_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Application Contract Coverage ID');
ALTER TABLE `education_ecm`.`technology`.`application_contract_coverage` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Contract Coverage - Enterprise Application Id');
ALTER TABLE `education_ecm`.`technology`.`application_contract_coverage` ALTER COLUMN `it_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Application Contract Coverage - It Contract Id');
ALTER TABLE `education_ecm`.`technology`.`application_contract_coverage` ALTER COLUMN `allocated_annual_cost` SET TAGS ('dbx_business_glossary_term' = 'Allocated Annual Cost');
ALTER TABLE `education_ecm`.`technology`.`application_contract_coverage` ALTER COLUMN `annual_license_cost` SET TAGS ('dbx_business_glossary_term' = 'Annual License Cost');
ALTER TABLE `education_ecm`.`technology`.`application_contract_coverage` ALTER COLUMN `annual_license_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`application_contract_coverage` ALTER COLUMN `contract_application_role` SET TAGS ('dbx_business_glossary_term' = 'Contract Application Role');
ALTER TABLE `education_ecm`.`technology`.`application_contract_coverage` ALTER COLUMN `contract_line_item_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Item Number');
ALTER TABLE `education_ecm`.`technology`.`application_contract_coverage` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `education_ecm`.`technology`.`application_contract_coverage` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `education_ecm`.`technology`.`application_contract_coverage` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status');
ALTER TABLE `education_ecm`.`technology`.`application_contract_coverage` ALTER COLUMN `license_quantity_allocated` SET TAGS ('dbx_business_glossary_term' = 'License Quantity Allocated');
ALTER TABLE `education_ecm`.`technology`.`application_contract_coverage` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Coverage Notes');
ALTER TABLE `education_ecm`.`technology`.`asset_software_installation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`technology`.`asset_software_installation` SET TAGS ('dbx_subdomain' = 'asset_operations');
ALTER TABLE `education_ecm`.`technology`.`asset_software_installation` SET TAGS ('dbx_association_edges' = 'technology.it_asset,technology.software_license');
ALTER TABLE `education_ecm`.`technology`.`asset_software_installation` ALTER COLUMN `asset_software_installation_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Software Installation ID');
ALTER TABLE `education_ecm`.`technology`.`asset_software_installation` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Software Installation - It Asset Id');
ALTER TABLE `education_ecm`.`technology`.`asset_software_installation` ALTER COLUMN `software_license_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Software Installation - Software License Id');
ALTER TABLE `education_ecm`.`technology`.`asset_software_installation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `education_ecm`.`technology`.`asset_software_installation` ALTER COLUMN `discovery_method` SET TAGS ('dbx_business_glossary_term' = 'Discovery Method');
ALTER TABLE `education_ecm`.`technology`.`asset_software_installation` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `education_ecm`.`technology`.`asset_software_installation` ALTER COLUMN `installation_path` SET TAGS ('dbx_business_glossary_term' = 'Installation Path');
ALTER TABLE `education_ecm`.`technology`.`asset_software_installation` ALTER COLUMN `installation_status` SET TAGS ('dbx_business_glossary_term' = 'Installation Status');
ALTER TABLE `education_ecm`.`technology`.`asset_software_installation` ALTER COLUMN `installed_by` SET TAGS ('dbx_business_glossary_term' = 'Installed By');
ALTER TABLE `education_ecm`.`technology`.`asset_software_installation` ALTER COLUMN `installed_version` SET TAGS ('dbx_business_glossary_term' = 'Installed Version');
ALTER TABLE `education_ecm`.`technology`.`asset_software_installation` ALTER COLUMN `last_usage_date` SET TAGS ('dbx_business_glossary_term' = 'Last Usage Date');
ALTER TABLE `education_ecm`.`technology`.`asset_software_installation` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `education_ecm`.`technology`.`asset_software_installation` ALTER COLUMN `license_key_assigned` SET TAGS ('dbx_business_glossary_term' = 'License Key Assigned');
ALTER TABLE `education_ecm`.`technology`.`asset_software_installation` ALTER COLUMN `license_key_assigned` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`technology`.`asset_software_installation` ALTER COLUMN `uninstall_date` SET TAGS ('dbx_business_glossary_term' = 'Uninstall Date');
ALTER TABLE `education_ecm`.`technology`.`approval_workflow` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`technology`.`approval_workflow` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `education_ecm`.`technology`.`approval_workflow` ALTER COLUMN `approval_workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Identifier');
ALTER TABLE `education_ecm`.`technology`.`approval_workflow` ALTER COLUMN `parent_approval_workflow_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`technology`.`access_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`technology`.`access_certification` SET TAGS ('dbx_subdomain' = 'security_governance');
ALTER TABLE `education_ecm`.`technology`.`access_certification` ALTER COLUMN `access_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Access Certification Identifier');
ALTER TABLE `education_ecm`.`technology`.`access_certification` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Certified Enterprise Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`access_certification` ALTER COLUMN `prior_access_certification_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`technology`.`problem` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`technology`.`problem` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `education_ecm`.`technology`.`problem` ALTER COLUMN `problem_id` SET TAGS ('dbx_business_glossary_term' = 'Problem Identifier');
ALTER TABLE `education_ecm`.`technology`.`problem` ALTER COLUMN `configuration_item_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Configuration Item Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`problem` ALTER COLUMN `it_service_id` SET TAGS ('dbx_business_glossary_term' = 'Affected It Service Id (Foreign Key)');
ALTER TABLE `education_ecm`.`technology`.`problem` ALTER COLUMN `parent_problem_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`technology`.`knowledge_article` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`technology`.`knowledge_article` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `education_ecm`.`technology`.`knowledge_article` ALTER COLUMN `knowledge_article_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Article Identifier');
ALTER TABLE `education_ecm`.`technology`.`knowledge_article` ALTER COLUMN `superseded_knowledge_article_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`technology`.`notification_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`technology`.`notification_template` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `education_ecm`.`technology`.`notification_template` ALTER COLUMN `notification_template_id` SET TAGS ('dbx_business_glossary_term' = 'Notification Template Identifier');
ALTER TABLE `education_ecm`.`technology`.`notification_template` ALTER COLUMN `parent_notification_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`technology`.`notification_template` ALTER COLUMN `reply_to_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`notification_template` ALTER COLUMN `sender_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`knowledge_category` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`technology`.`knowledge_category` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `education_ecm`.`technology`.`knowledge_category` ALTER COLUMN `knowledge_category_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Category Identifier');
ALTER TABLE `education_ecm`.`technology`.`knowledge_category` ALTER COLUMN `parent_knowledge_category_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`technology`.`knowledge_category` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`technology`.`knowledge_subcategory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`technology`.`knowledge_subcategory` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `education_ecm`.`technology`.`knowledge_subcategory` ALTER COLUMN `knowledge_subcategory_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Subcategory Identifier');
ALTER TABLE `education_ecm`.`technology`.`knowledge_subcategory` ALTER COLUMN `parent_knowledge_subcategory_id` SET TAGS ('dbx_self_ref_fk' = 'true');
