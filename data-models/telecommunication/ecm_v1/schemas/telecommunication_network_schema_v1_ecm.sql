-- Schema for Domain: network | Business: Telecommunication | Version: v1_ecm
-- Generated on: 2026-05-08 05:07:48

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `telecommunication_ecm`.`network` COMMENT 'SSOT for all physical and logical network infrastructure including RAN, transport, core network elements, GPON/FTTH, MPLS, SD-WAN, NFV/SDN nodes, OLT/ONT, DSLAM, BNG, BRAS, POP sites, and spectrum allocation. Governs network topology, capacity, configuration, and element lifecycle managed via Nokia NetAct, Ericsson Network Manager, and NMS/EMS platforms.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`element` (
    `element_id` BIGINT COMMENT 'Primary key for element',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Network elements incur operational expenses (power, maintenance, site lease) allocated to cost centers for budget tracking and variance analysis. Required for OpEx allocation, cost center reporting, a',
    `location_site_id` BIGINT COMMENT 'Foreign key linking to location.location_site. Business justification: Network elements are physically installed at specific sites. Critical for field maintenance dispatch, asset tracking, physical security, power/cooling management, and site access coordination. Fundame',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to people.org_unit. Business justification: Network elements are owned and managed by specific organizational units (regional NOCs, core network operations, etc.). Business process: budget allocation, headcount planning, operational responsibil',
    `pop_facility_id` BIGINT COMMENT 'Foreign key linking to inventory.pop_facility. Business justification: Network elements are physically housed in PoP facilities. Critical for site planning, maintenance dispatch, power/cooling capacity management, physical asset audits, and facility-level operational rep',
    `site_id` BIGINT COMMENT 'FK to location.site.site_id — Network elements must be locatable for outage triage, capacity planning, and field dispatch. Without this FK, NOC cannot determine physical location of faulting equipment.',
    `spectrum_license_id` BIGINT COMMENT 'Foreign key linking to compliance.spectrum_license. Business justification: Network elements (base stations, radios, antennas) operate under spectrum licenses. Telecommunications operators must track which equipment uses which spectrum authorization for regulatory audits, lic',
    `activation_date` DATE COMMENT 'Date when the network element was activated and placed into operational service.',
    `administrative_state` STRING COMMENT 'Administrative control state of the network element indicating whether it is locked (prevented from use), unlocked (available for use), or in the process of shutting down.. Valid values are `locked|unlocked|shutting_down`',
    `asset_tag` STRING COMMENT 'Internal asset tracking identifier assigned by the telecommunications operator for inventory and asset management purposes.',
    `capacity_unit` STRING COMMENT 'Unit of measure for the capacity value (e.g., Gbps for bandwidth, TPS for transactions per second, Erlang for traffic intensity, subscribers for user capacity).. Valid values are `gbps|mbps|tps|erlang|subscribers`',
    `capacity_value` DECIMAL(18,2) COMMENT 'Numeric capacity rating of the network element representing its maximum throughput, bandwidth, or processing capability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this network element record was first created in the system.',
    `decommission_date` DATE COMMENT 'Date when the network element was decommissioned and removed from active service.',
    `element_name` STRING COMMENT 'Human-readable name or label assigned to the network element for identification and operational reference.',
    `element_type` STRING COMMENT 'High-level classification of the network element indicating its functional category within the telecommunications infrastructure.. Valid values are `ran|core|transport|access|cpe|vnf`',
    `ems_system` STRING COMMENT 'Name of the Element Management System platform responsible for element-level configuration and fault management.',
    `hardware_version` STRING COMMENT 'Version identifier for the physical hardware components of the network element.',
    `identifier` STRING COMMENT 'Externally-known unique identifier or code for the network element, used across operational systems and documentation.',
    `installation_date` DATE COMMENT 'Date when the network element was physically installed at its site location.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent scheduled maintenance activity performed on the network element.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the network element physical location in decimal degrees.',
    `lifecycle_state` STRING COMMENT 'Current lifecycle stage of the network element from initial planning through active operation to eventual retirement.. Valid values are `planned|installed|active|maintenance|decommissioned|retired`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the network element physical location in decimal degrees.',
    `management_ip_address` STRING COMMENT 'IP address used for network management access to the element via Network Management System (NMS) or Element Management System (EMS) platforms.',
    `mano_orchestrator` STRING COMMENT 'Name or identifier of the NFV MANO platform responsible for orchestrating the lifecycle of this virtualized network function. Applicable only when NFV indicator is true.',
    `model_number` STRING COMMENT 'Vendor-specific model number or designation for the network element hardware or software platform.',
    `mtbf_hours` DECIMAL(18,2) COMMENT 'Average time in hours between failures for this network element type, used for reliability planning and maintenance scheduling.',
    `mttr_hours` DECIMAL(18,2) COMMENT 'Average time in hours required to repair or restore this network element type to operational state after a failure.',
    `next_maintenance_date` DATE COMMENT 'Date when the next scheduled maintenance activity is planned for the network element.',
    `nfv_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this network element is a virtualized network function (VNF) running on NFV infrastructure rather than dedicated physical hardware.',
    `nms_system` STRING COMMENT 'Name of the Network Management System platform responsible for managing this network element (e.g., Nokia NetAct, Ericsson Network Manager).',
    `notes` STRING COMMENT 'Free-text field for operational notes, special configurations, known issues, or other relevant information about the network element.',
    `operational_state` STRING COMMENT 'Current operational state of the network element indicating whether it is actively processing traffic, disabled, or in testing mode.. Valid values are `enabled|disabled|testing`',
    `power_consumption_watts` DECIMAL(18,2) COMMENT 'Typical power consumption of the network element in watts, used for energy management and operational expenditure (OPEX) planning.',
    `rack_position` STRING COMMENT 'Physical rack identifier and position within the data center or network facility where the element is mounted.',
    `redundancy_mode` STRING COMMENT 'Redundancy configuration mode for the network element indicating how failover and high availability are implemented.. Valid values are `none|active_standby|active_active|n_plus_1`',
    `serial_number` STRING COMMENT 'Manufacturer-assigned unique serial number for the physical network element hardware unit.',
    `slot_position` STRING COMMENT 'Specific slot or bay position within the rack or chassis where the network element card or module is installed.',
    `software_version` STRING COMMENT 'Version identifier for the software or firmware running on the network element.',
    `subtype` STRING COMMENT 'Detailed classification of the network element specifying the exact node type (e.g., eNodeB, gNodeB, MME, AMF, SMF, UPF, P-CSCF, S-CSCF, I-CSCF, HSS, MPLS router, OTN switch, DSLAM, BNG, BRAS, OLT, ONT, ONU, vMME, vSGW, vPGW, vBNG, vFirewall).',
    `support_contact` STRING COMMENT 'Primary technical support contact information (email or phone) for vendor support escalation related to this network element.',
    `temperature_rating_celsius` DECIMAL(18,2) COMMENT 'Maximum operating temperature rating in degrees Celsius for the network element hardware.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this network element record was last modified in the system.',
    `vcpu_count` STRING COMMENT 'Number of virtual CPU cores allocated to the virtualized network function. Applicable only when NFV indicator is true.',
    `vendor_name` STRING COMMENT 'Name of the manufacturer or vendor that produced the network element hardware or software.',
    `vnfd_identifier` STRING COMMENT 'Unique identifier for the VNF Descriptor that defines the deployment and operational behavior of the virtualized network function. Applicable only when NFV indicator is true.',
    `vram_gb` DECIMAL(18,2) COMMENT 'Amount of virtual memory in gigabytes allocated to the virtualized network function. Applicable only when NFV indicator is true.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer or vendor warranty coverage for the network element expires.',
    CONSTRAINT pk_element PRIMARY KEY(`element_id`)
) COMMENT 'Unified master record for every physical and logical network element in the operators infrastructure — the Single Source of Truth for all managed network nodes. Covers RAN base stations (eNodeB, gNodeB), core network nodes (MME, AMF, SMF, UPF, IMS P-CSCF/S-CSCF/I-CSCF/HSS), transport nodes (MPLS routers, OTN switches), access nodes (DSLAM, BNG, BRAS, OLT), CPE-side ONT/ONU devices, and virtualized network functions (VNFs: vMME, vSGW, vPGW, vBNG, vFirewall). Tracks element type, subtype, vendor, model, hardware/software version, operational state, administrative state, lifecycle state, geographic location, POP site assignment, rack/slot position, management IP, and NFV-specific attributes (vCPU, vRAM, VNFD, MANO orchestrator) where applicable. Sourced from Nokia NetAct, Ericsson Network Manager, and MANO platforms. This is the foundational master entity — all other network products reference elements via FK.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`topology` (
    `topology_id` BIGINT COMMENT 'Primary key for topology',
    `transmission_link_id` BIGINT COMMENT 'Reference to the backup or protection link used for failover when this primary link fails. Part of the protection scheme topology.',
    `element_id` BIGINT COMMENT 'Reference to the terminating network element (node) of this topology link. Represents the Z-end of the connection.',
    `fiber_cable_id` BIGINT COMMENT 'Foreign key linking to inventory.fiber_cable. Business justification: Network topology links (optical layer) map to physical fiber cables. Essential for path computation engines, restoration planning, ROADM configuration, and physical-to-logical network reconciliation i',
    `network_qos_profile_id` BIGINT COMMENT 'Foreign key linking to network.qos_profile. Business justification: Network topology links have QoS classifications that determine traffic prioritization and resource allocation. Currently qos_class is stored as STRING. Normalizing to qos_profile enables consistent Qo',
    `source_network_element_id` BIGINT COMMENT 'Reference to the originating network element (node) of this topology link. Represents the A-end of the connection.',
    `actual_availability_percentage` DECIMAL(18,2) COMMENT 'Measured availability of the link over a reporting period, expressed as a percentage. Compared against Service Level Agreement (SLA) targets for compliance reporting.',
    `administrative_state` STRING COMMENT 'Administratively configured state of the link, independent of operational status. Controlled by network engineers through Nokia NetAct or Ericsson Network Manager.. Valid values are `unlocked|locked|shutting_down`',
    `circuit_reference` STRING COMMENT 'External circuit identifier assigned by the service provider or carrier for leased or wholesale links. Used for interconnect billing and settlement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this topology link record was first created in the system. Used for data lineage and audit trail purposes.',
    `decommission_date` DATE COMMENT 'Date when the link was or is planned to be decommissioned and removed from service. Used for network evolution planning and asset retirement.',
    `destination_interface_name` STRING COMMENT 'Name or identifier of the physical or logical interface on the destination network element where the link terminates. Used for detailed topology mapping and troubleshooting.',
    `installation_date` DATE COMMENT 'Date when the network link was physically installed and commissioned. Used for asset lifecycle management and Capital Expenditure (CAPEX) tracking.',
    `is_bidirectional` BOOLEAN COMMENT 'Indicates whether the link supports bidirectional traffic flow or is unidirectional. Affects path computation and traffic engineering algorithms.',
    `is_protected` BOOLEAN COMMENT 'Indicates whether the link has an active protection scheme configured for redundancy and failover. Critical for Service Level Agreement (SLA) compliance.',
    `is_virtual` BOOLEAN COMMENT 'Indicates whether the link is a virtual or logical connection (e.g., Software-Defined Networking (SDN) or Network Functions Virtualization (NFV) overlay) rather than a physical connection.',
    `last_failure_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent link failure event. Used for fault management, root cause analysis, and Mean Time Between Failures (MTBF) calculations.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent maintenance activity performed on the link. Used for preventive maintenance scheduling and Mean Time Between Failures (MTBF) analysis.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this topology link record was most recently modified. Used for change tracking and data synchronization with Nokia NetAct and Ericsson Network Manager.',
    `link_capacity_mbps` DECIMAL(18,2) COMMENT 'Maximum bandwidth capacity of the link measured in megabits per second. Critical for capacity planning, traffic engineering, and Quality of Service (QoS) management.',
    `link_cost` STRING COMMENT 'Routing protocol cost or metric assigned to the link for path computation algorithms. Used in Open Shortest Path First (OSPF), Intermediate System to Intermediate System (IS-IS), and other routing protocols.',
    `link_distance_km` DECIMAL(18,2) COMMENT 'Physical or logical distance of the link in kilometers. Used for latency calculations, signal degradation analysis, and network planning.',
    `link_identifier` STRING COMMENT 'Externally-known unique identifier for the network link, used in network management systems and topology diagrams. Typically follows naming conventions from Nokia NetAct or Ericsson Network Manager.',
    `link_latency_ms` DECIMAL(18,2) COMMENT 'Measured or calculated propagation delay across the link in milliseconds. Critical for Service Level Agreement (SLA) compliance and Quality of Service (QoS) assurance.',
    `link_name` STRING COMMENT 'Human-readable name or label for the network link, used for identification in network operations and documentation.',
    `link_type` STRING COMMENT 'Classification of the physical or logical medium used for the network link. Determines transmission characteristics and capacity planning parameters.. Valid values are `fiber|microwave|copper|ethernet|mpls_lsp|ip`',
    `mpls_label` STRING COMMENT 'MPLS label assigned to the Label Switched Path (LSP) for this link. Used for traffic engineering and Quality of Service (QoS) in MPLS networks.',
    `mtbf_hours` DECIMAL(18,2) COMMENT 'Average time between consecutive failures of the link, measured in hours. Used for reliability analysis and preventive maintenance planning.',
    `mttr_hours` DECIMAL(18,2) COMMENT 'Average time required to restore the link to operational state after a failure, measured in hours. Key Performance Indicator (KPI) for fault management and Network Operations Center (NOC) efficiency.',
    `network_layer` STRING COMMENT 'The hierarchical layer of the telecommunications network where this link operates. Used for layer-specific topology analysis and capacity planning.. Valid values are `ran|transport|core|access|aggregation|backbone`',
    `next_maintenance_date` DATE COMMENT 'Scheduled date for the next planned maintenance activity on the link. Used by Workforce Management (WFM) systems for field dispatch and scheduling.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, configuration details, or special handling instructions for the network link.',
    `operational_state` STRING COMMENT 'Current operational status of the network link. Reflects real-time state from Network Management System (NMS) and Element Management System (EMS) platforms. Used by Network Operations Center (NOC) for fault management.. Valid values are `in_service|out_of_service|maintenance|testing|degraded|failed`',
    `protection_scheme` STRING COMMENT 'Redundancy and failover mechanism configured for the link. Defines how the network recovers from link failures to maintain service continuity and meet Service Level Agreement (SLA) requirements.. Valid values are `none|1+1|1:1|1:n|ring|mesh`',
    `sla_target_availability_percentage` DECIMAL(18,2) COMMENT 'Contractual availability target for the link expressed as a percentage. Used for Service Level Agreement (SLA) compliance monitoring and reporting.',
    `source_interface_name` STRING COMMENT 'Name or identifier of the physical or logical interface on the source network element where the link originates. Used for detailed topology mapping and troubleshooting.',
    `technology_standard` STRING COMMENT 'Industry standard or protocol specification governing the link technology. Examples include IEEE 802.3 for Ethernet, ITU-T G.652 for fiber, or 3GPP specifications for Radio Access Network (RAN) links.',
    `utilization_percentage` DECIMAL(18,2) COMMENT 'Current bandwidth utilization of the link expressed as a percentage of total capacity. Key Performance Indicator (KPI) for capacity planning and congestion management.',
    `vendor_name` STRING COMMENT 'Name of the equipment vendor providing the network elements connected by this link. Used for vendor-specific management and support processes.',
    `vlan_number` STRING COMMENT 'VLAN identifier for Ethernet-based links, used for logical network segmentation and traffic isolation. Applicable to Ethernet and Software-Defined Wide Area Network (SD-WAN) links.',
    CONSTRAINT pk_topology PRIMARY KEY(`topology_id`)
) COMMENT 'Represents the logical and physical connectivity graph between network elements — links, segments, and paths that form the network topology. Captures link type (fiber, microwave, copper, Ethernet, MPLS LSP), link capacity (bandwidth in Mbps/Gbps), link distance, latency, protection scheme (1+1, ring, mesh), operational state, and the two endpoint network elements. Supports topology visualization, path computation, and capacity planning for RAN, transport, and core network layers.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`ran_cell` (
    `ran_cell_id` BIGINT COMMENT 'Unique identifier for the RAN cell record. Primary key for the ran_cell product.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Private network deployments (enterprise 5G, campus networks, industrial IoT) dedicate RAN cells to specific corporate billing accounts. Essential for private network billing, capacity reservation trac',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: RAN cells are dimensioned and deployed to deliver specific service products. Network planning maps cells to catalog items for coverage/capacity planning and technology roadmap decisions (5G premium vs',
    `e911_compliance_id` BIGINT COMMENT 'Foreign key linking to compliance.e911_compliance. Business justification: RAN cells must meet E911 location accuracy requirements (horizontal/vertical accuracy, dispatchable location). Compliance is tracked and tested per cell. Essential for E911 compliance testing, certifi',
    `element_id` BIGINT COMMENT 'Reference to the parent base station (eNodeB, gNodeB, NodeB, BTS) that hosts this cell. Links cell to physical network infrastructure.',
    `enterprise_site_id` BIGINT COMMENT 'Foreign key linking to enterprise.site. Business justification: RAN cells provide dedicated coverage for enterprise campus/facility sites in private LTE/5G deployments. Real business process: enterprise wireless solution design and coverage planning for corporate ',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: RAN cells (base stations, antennas, radio equipment) are capital assets requiring depreciation tracking, asset tagging, and lifecycle management. Critical for infrastructure asset accounting and finan',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to workforce.work_order. Business justification: RAN cell installation and commissioning generates work orders for tower climbers and RF technicians. Critical for tracking cell deployment lifecycle, installation costs, and time-to-market for network',
    `spectrum_allocation_id` BIGINT COMMENT 'Foreign key linking to inventory.spectrum_allocation. Business justification: RAN cells operate on licensed spectrum bands. Regulatory compliance reporting, interference coordination, coverage obligation tracking, and spectrum efficiency analysis require linking cells to their ',
    `location_site_id` BIGINT COMMENT 'Reference to the physical network site or tower location where the cell equipment is installed. Links cell to infrastructure asset records.',
    `network_equipment_id` BIGINT COMMENT 'Foreign key linking to inventory.network_equipment. Business justification: RAN cells are hosted on physical base station equipment (RRU, BBU, RAN server). Hardware lifecycle tracking, power consumption monitoring, site surveys, and equipment-to-cell mapping for maintenance r',
    `network_qos_profile_id` BIGINT COMMENT 'Foreign key linking to network.qos_profile. Business justification: RAN cells have QoS configurations that determine radio resource scheduling and bearer treatment. Currently quality_of_service_class is stored as STRING. Normalizing to qos_profile enables consistent Q',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: RAN cells require assigned RF engineers for optimization, troubleshooting, and performance management. Business process: cell performance degradation triggers work assignment to responsible engineer f',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to customer.subscriber. Business justification: RAN cells track currently-served or last-served subscriber for handover decisions, radio resource management, coverage analysis. Core mobile network operation: cell-to-subscriber association drives re',
    `spectrum_license_id` BIGINT COMMENT 'Reference to the regulatory spectrum license authorizing operation on this frequency. Links cell to spectrum asset and compliance records.',
    `administrative_state` STRING COMMENT 'Administrative control state of the cell. Unlocked allows normal operation, locked prevents service, shutting_down indicates graceful shutdown in progress.. Valid values are `unlocked|locked|shutting_down`',
    `antenna_height_meters` DECIMAL(18,2) COMMENT 'Height of the antenna above ground level in meters. Affects coverage radius and signal propagation characteristics.',
    `azimuth_degrees` DECIMAL(18,2) COMMENT 'Horizontal direction of the antennas main beam in degrees from true north (0-360). Critical for coverage planning and interference management.',
    `bandwidth_mhz` DECIMAL(18,2) COMMENT 'The bandwidth of the radio channel in megahertz. Common values include 5, 10, 15, 20 MHz for LTE; up to 100 MHz for 5G NR.',
    `beamforming_enabled` BOOLEAN COMMENT 'Indicates whether advanced beamforming techniques are enabled. Beamforming directs radio signals toward specific users, improving signal quality and capacity.',
    `carrier_aggregation_enabled` BOOLEAN COMMENT 'Indicates whether carrier aggregation is enabled for this cell. CA combines multiple frequency bands to increase throughput in LTE and 5G networks.',
    `carrier_frequency_mhz` DECIMAL(18,2) COMMENT 'Center frequency of the carrier in megahertz. The primary operating frequency for the cells radio transmission.',
    `cell_activation_date` DATE COMMENT 'Date when the cell was first activated and began serving traffic. Used for lifecycle tracking and network evolution analysis.',
    `cell_capacity_users` STRING COMMENT 'Maximum number of concurrent users the cell is designed to support. Based on spectrum allocation, technology, and configuration.',
    `cell_deactivation_date` DATE COMMENT 'Date when the cell was deactivated or decommissioned. Null for active cells. Used for historical analysis and asset lifecycle management.',
    `cell_global_identity` STRING COMMENT 'Globally unique cell identifier combining MCC, MNC, LAC/TAC, and Cell ID. Format varies by technology: CGI for 2G/3G, ECGI for LTE, NCI for 5G NR. Used for cell identification in handovers and network operations.',
    `cell_name` STRING COMMENT 'Human-readable name assigned to the cell for operational identification and network management purposes. Typically includes site identifier and sector information.',
    `cell_operational_state` STRING COMMENT 'Current operational status of the cell. Indicates whether the cell is serving traffic, under maintenance, or planned for deployment.. Valid values are `active|inactive|blocked|maintenance|testing|planned`',
    `channel_number` STRING COMMENT 'Channel number identifying the specific radio frequency channel. Format varies by technology: ARFCN for GSM/UMTS, EARFCN for LTE, NR-ARFCN for 5G NR.',
    `coverage_type` STRING COMMENT 'Classification of the cells primary coverage area: outdoor macro coverage, indoor small cell, or mixed deployment.. Valid values are `outdoor|indoor|mixed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cell record was first created in the network management system. Used for audit trail and data lineage.',
    `deployment_scenario` STRING COMMENT 'The deployment environment scenario for the cell. Influences planning parameters, capacity expectations, and performance benchmarks.. Valid values are `urban|suburban|rural|highway|indoor|enterprise`',
    `electrical_tilt_degrees` DECIMAL(18,2) COMMENT 'Electronic beam steering tilt angle in degrees, adjustable via Remote Electrical Tilt (RET) systems. Enables dynamic coverage optimization.',
    `energy_saving_mode` STRING COMMENT 'Energy saving configuration for the cell. Adaptive mode dynamically adjusts power based on traffic load to reduce operational expenditure.. Valid values are `disabled|enabled|adaptive`',
    `equipment_model` STRING COMMENT 'Specific model designation of the base station equipment serving this cell. Used for inventory management and maintenance planning.',
    `frequency_band` STRING COMMENT 'The frequency band designation used by the cell (e.g., Band 1, Band 3, Band 7, n78, n260). Identifies the spectrum allocation for the cell.',
    `handover_hysteresis_db` DECIMAL(18,2) COMMENT 'Hysteresis value in decibels to prevent ping-pong handovers between cells. Stabilizes mobility decisions in border areas.',
    `handover_margin_db` DECIMAL(18,2) COMMENT 'Signal strength margin in decibels required to trigger handover to neighboring cells. Critical parameter for mobility management and call continuity.',
    `last_configuration_change_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent configuration change applied to the cell. Critical for change management and troubleshooting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this cell record was last updated. Supports change tracking and data quality monitoring.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the cell antenna location in decimal degrees. Used for coverage mapping and network planning.',
    `load_balancing_enabled` BOOLEAN COMMENT 'Indicates whether automatic load balancing is enabled to distribute traffic across neighboring cells during congestion.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the cell antenna location in decimal degrees. Used for coverage mapping and network planning.',
    `maximum_cell_range_meters` STRING COMMENT 'Maximum designed coverage radius of the cell in meters. Used for network planning and capacity dimensioning.',
    `mechanical_tilt_degrees` DECIMAL(18,2) COMMENT 'Physical downward tilt angle of the antenna in degrees. Used to control vertical coverage and reduce interference.',
    `mimo_configuration` STRING COMMENT 'MIMO antenna configuration indicating the number of transmit and receive antenna paths. Higher configurations enable greater spectral efficiency and throughput.. Valid values are `1x1|2x2|4x4|8x8|massive_mimo`',
    `physical_cell_identifier` STRING COMMENT 'Physical layer cell identity used for cell identification during initial access and handover. Range 0-503 for LTE, 0-1007 for 5G NR.',
    `radio_access_technology` STRING COMMENT 'Specific radio access technology standard implemented by the cell. More granular than technology generation, specifying the exact air interface protocol.. Valid values are `GSM|UMTS|LTE|NR|CDMA|HSPA`',
    `sector_number` STRING COMMENT 'Identifier for the sector within the base station site. Typically indicates the directional coverage area (e.g., Alpha, Beta, Gamma or 1, 2, 3).',
    `software_version` STRING COMMENT 'Version of the base station software running on the equipment. Critical for feature availability, performance, and security patching.',
    `technology_generation` STRING COMMENT 'The mobile network technology generation of the cell: 2G (GSM/GPRS/EDGE), 3G (UMTS/HSPA), 4G (LTE/LTE-Advanced), or 5G (5G NR).. Valid values are `2G|3G|4G|5G`',
    `time_to_trigger_ms` STRING COMMENT 'Duration in milliseconds that handover conditions must be met before triggering handover. Prevents unnecessary handovers due to temporary signal fluctuations.',
    `tracking_area_code` STRING COMMENT 'Tracking Area Code for LTE/5G or Location Area Code for 2G/3G. Groups cells for mobility management and paging optimization.',
    `transmit_power_dbm` DECIMAL(18,2) COMMENT 'Maximum transmit power of the cell in decibels relative to one milliwatt (dBm). Determines signal strength and coverage area.',
    `vendor_name` STRING COMMENT 'Name of the equipment vendor providing the RAN hardware and software for this cell (e.g., Ericsson, Nokia, Huawei, Samsung).',
    CONSTRAINT pk_ran_cell PRIMARY KEY(`ran_cell_id`)
) COMMENT 'Master record for every Radio Access Network (RAN) cell — individual radio cells served by base stations across 2G, 3G, 4G LTE, and 5G NR technologies. Captures cell ID (CGI/NCI), cell name, technology generation (GSM/UMTS/LTE/NR), frequency band, channel number (ARFCN/EARFCN/NR-ARFCN), bandwidth, azimuth, tilt (mechanical and electrical), antenna height, transmit power, cell range, handover parameters, and operational state. Critical for RAN planning, optimization, and coverage management.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`transmission_link` (
    `transmission_link_id` BIGINT COMMENT 'Unique identifier for the physical transmission link in the transport network. Primary key.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Leased transmission links, dedicated circuits, and dark fiber are billed to specific enterprise or wholesale billing accounts. Critical for wholesale circuit billing, enterprise dedicated connectivity',
    `circuit_id` BIGINT COMMENT 'Foreign key linking to network.circuit. Business justification: A transmission link belongs to a circuit; linking transmission_link.circuit_id to circuit.circuit_id enables circuit-level reporting and eliminates the circuit silo.',
    `enterprise_site_id` BIGINT COMMENT 'Foreign key linking to enterprise.site. Business justification: Transmission links terminate at enterprise customer sites for dedicated WAN/MPLS connectivity. Core business process: enterprise circuit provisioning and inventory management for point-to-point and MP',
    `fiber_cable_id` BIGINT COMMENT 'Foreign key linking to inventory.fiber_cable. Business justification: Transmission links run over physical fiber infrastructure. Fault correlation, route diversity planning, physical path validation, maintenance scheduling, and logical-to-physical reconciliation require',
    `fiber_lease_id` BIGINT COMMENT 'Circuit identifier provided by the leasing carrier for leased line links. Null for owned infrastructure.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Owned transmission links (fiber, microwave) are capital infrastructure requiring asset tracking and depreciation. Essential for infrastructure asset management, capitalization decisions, and financial',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Transmission links are frequently leased from infrastructure partners (fiber providers, dark fiber lessors). Settlement reconciliation, invoice validation, SLA tracking, and dispute resolution require',
    `location_site_id` BIGINT COMMENT 'Identifier of the network site or Point of Presence (POP) at the A-end (originating end) of the transmission link.',
    `network_equipment_id` BIGINT COMMENT 'Identifier of the network element or equipment at the A-end of the transmission link (e.g., OLT, DSLAM, BNG, router).',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Transmission links require assigned engineers for maintenance, fault resolution, and capacity planning. Business process: link alarms and maintenance windows route to responsible engineer for executio',
    `sla_contract_id` BIGINT COMMENT 'Foreign key linking to assurance.sla_contract. Business justification: Leased transmission links have specific SLA contracts with carriers for availability, latency, MTTR. Essential for breach detection, penalty calculation, and vendor performance management. Standard fo',
    `a_end_port` STRING COMMENT 'Port or interface designation on the A-end equipment where the transmission link terminates.',
    `alarm_severity_threshold` STRING COMMENT 'Minimum alarm severity level configured for fault management notifications for this transmission link.. Valid values are `critical|major|minor|warning|informational`',
    `attenuation_db` DECIMAL(18,2) COMMENT 'Signal attenuation or loss measured in decibels for the transmission link, applicable to fiber and microwave links.',
    `capacity_unit` STRING COMMENT 'Unit of measure for the link capacity, supporting SDH/SONET (STM-N), OTN (OTU-k), or Ethernet rate standards. [ENUM-REF-CANDIDATE: mbps|gbps|tbps|stm_1|stm_4|stm_16|stm_64|otu_1|otu_2|otu_3|otu_4 — 11 candidates stripped; promote to reference product]',
    `capacity_value` DECIMAL(18,2) COMMENT 'Numeric value representing the transmission capacity of the link.',
    `commissioning_date` DATE COMMENT 'Date when the transmission link was commissioned and put into operational service.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this transmission link record was first created in the system.',
    `decommissioning_date` DATE COMMENT 'Date when the transmission link was decommissioned and removed from operational service. Null if still in service.',
    `fiber_pair_count` STRING COMMENT 'Number of fiber pairs (transmit/receive pairs) available in the fiber cable for this link. Null for non-fiber links.',
    `fiber_type` STRING COMMENT 'Type of optical fiber used for fiber-based transmission links. Single-Mode Fiber (SMF) for long-distance, Multi-Mode Fiber (MMF) for short-distance. Not applicable for non-fiber links.. Valid values are `smf|mmf|not_applicable`',
    `geographic_route_description` STRING COMMENT 'Textual description of the geographic route or path taken by the transmission link, including key waypoints or conduit paths.',
    `last_maintenance_date` DATE COMMENT 'Date when the last scheduled or corrective maintenance was performed on the transmission link.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this transmission link record was last modified or updated.',
    `latency_ms` DECIMAL(18,2) COMMENT 'Measured or calculated one-way latency of the transmission link in milliseconds, critical for Quality of Service (QoS) requirements.',
    `lease_contract_end_date` DATE COMMENT 'End date of the lease contract for leased line circuits. Null for owned infrastructure.',
    `lease_monthly_cost` DECIMAL(18,2) COMMENT 'Monthly recurring cost for leased transmission links. Null for owned infrastructure. Business-confidential financial data.',
    `link_identifier` STRING COMMENT 'Externally-known unique identifier or code for the transmission link used in network management systems and operational documentation.',
    `link_name` STRING COMMENT 'Human-readable name or designation for the transmission link, typically reflecting geographic endpoints or circuit designation.',
    `link_status` STRING COMMENT 'Current operational state of the transmission link in its lifecycle.. Valid values are `in_service|out_of_service|under_maintenance|planned|decommissioned|reserved`',
    `link_type` STRING COMMENT 'Classification of the physical transmission medium used for the link.. Valid values are `fiber|microwave|copper|leased_line|satellite|hybrid`',
    `maintenance_window` STRING COMMENT 'Scheduled maintenance window for the transmission link, typically expressed as day-of-week and time range (e.g., Sunday 02:00-06:00 UTC).',
    `next_maintenance_date` DATE COMMENT 'Date when the next scheduled maintenance is planned for the transmission link.',
    `nms_object_reference` STRING COMMENT 'Unique object identifier or managed object instance ID for this transmission link in the Network Management System (NMS).',
    `nms_system` STRING COMMENT 'Name of the Network Management System (NMS) or Element Management System (EMS) platform managing this transmission link (e.g., Nokia NetAct, Ericsson Network Manager).',
    `notes` STRING COMMENT 'Free-text field for operational notes, special instructions, or additional context about the transmission link.',
    `owner_organization` STRING COMMENT 'Internal business unit, division, or organizational entity that owns and manages this transmission link asset.',
    `protection_type` STRING COMMENT 'Type of redundancy or protection mechanism configured for the transmission link to ensure service continuity.. Valid values are `unprotected|one_plus_one|one_colon_one|one_colon_n|ring|mesh`',
    `redundancy_group_code` BIGINT COMMENT 'Identifier of the redundancy or protection group to which this transmission link belongs, used for coordinated protection switching.',
    `right_of_way_type` STRING COMMENT 'Type of right-of-way or access rights for the physical transmission path (owned land, leased access, easement, public utility corridor). Applicable primarily to fiber and copper links.. Valid values are `owned|leased|easement|public_utility|not_applicable`',
    `route_distance_km` DECIMAL(18,2) COMMENT 'Physical distance of the transmission link route measured in kilometers.',
    `utilization_percent` DECIMAL(18,2) COMMENT 'Current utilization percentage of the transmission link capacity, calculated from performance monitoring data.',
    `vendor` STRING COMMENT 'Manufacturer or vendor of the transmission equipment and infrastructure for this link.',
    `wavelength_count` STRING COMMENT 'Number of optical wavelengths (lambdas) supported on the fiber link for Dense Wavelength Division Multiplexing (DWDM) systems. Null for non-DWDM links.',
    `z_end_port` STRING COMMENT 'Port or interface designation on the Z-end equipment where the transmission link terminates.',
    CONSTRAINT pk_transmission_link PRIMARY KEY(`transmission_link_id`)
) COMMENT 'Master record for physical transmission links in the transport network — fiber spans, microwave hops, and leased line circuits connecting network elements. Captures link identifier, link type (fiber/microwave/copper/leased), vendor, capacity (STM-N, OTU-k, Ethernet rate), route distance, fiber type (SMF/MMF), number of fiber pairs, protection type, commissioning date, and operational state. Distinct from logical topology — this represents the physical medium layer (Layer 0/1) managed via NMS/EMS.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` (
    `mpls_tunnel_id` BIGINT COMMENT 'Unique identifier for the MPLS tunnel. Primary key for the MPLS tunnel master record.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: MPLS tunnels are provisioned per enterprise account for Layer 3 VPN services. Business process: enterprise VPN service delivery, traffic engineering, and account-level capacity management for MPLS net',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: MPLS transport infrastructure operational costs (bandwidth, maintenance) allocated to cost centers. Required for transport network cost allocation and operational expense tracking by technology domain',
    `fiber_cable_id` BIGINT COMMENT 'Foreign key linking to inventory.fiber_cable. Business justification: MPLS tunnels traverse physical fiber paths. Route diversity validation (SRLG analysis), latency correlation with physical distance, and restoration planning require mapping tunnels to underlying fiber',
    `network_qos_profile_id` BIGINT COMMENT 'Foreign key linking to network.qos_profile. Business justification: MPLS tunnels use QoS profiles to define traffic engineering behavior and service class treatment. Currently qos_class is stored as STRING. Normalizing to qos_profile ensures consistent QoS treatment a',
    `element_id` BIGINT COMMENT 'Identifier of the network element serving as the Label Edge Router (LER) where traffic enters the MPLS tunnel.',
    `sla_contract_id` BIGINT COMMENT 'Foreign key linking to assurance.sla_contract. Business justification: MPLS tunnels for enterprise/wholesale customers have contracted SLA commitments for bandwidth, latency, packet loss, availability. Business-critical for service delivery assurance, breach detection, a',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: MPLS tunnels require network engineers for configuration, path optimization, and troubleshooting. Business process: tunnel performance issues and reoptimization tasks escalate to assigned administrato',
    `administrative_status` STRING COMMENT 'Administrative state of the tunnel indicating whether it is configured to be active by network operations.. Valid values are `enabled|disabled|locked`',
    `affinity_bits` STRING COMMENT 'Administrative group or color constraints (32-bit mask) used to include or exclude specific links during path computation for traffic engineering.',
    `auto_bandwidth_enabled` BOOLEAN COMMENT 'Indicates whether automatic bandwidth adjustment is enabled, allowing the tunnel to dynamically resize based on traffic patterns.',
    `auto_bandwidth_max_mbps` DECIMAL(18,2) COMMENT 'Maximum bandwidth limit in megabits per second that auto-bandwidth can adjust to, preventing over-allocation.',
    `auto_bandwidth_min_mbps` DECIMAL(18,2) COMMENT 'Minimum bandwidth limit in megabits per second that auto-bandwidth can adjust to, ensuring baseline capacity.',
    `bandwidth_reserved_mbps` DECIMAL(18,2) COMMENT 'Amount of bandwidth reserved for this tunnel in megabits per second, used for traffic engineering and capacity planning.',
    `bandwidth_utilized_mbps` DECIMAL(18,2) COMMENT 'Current bandwidth utilization of the tunnel in megabits per second, measured from traffic statistics.',
    `bytes_received` BIGINT COMMENT 'Total number of bytes received through the tunnel since establishment.',
    `bytes_transmitted` BIGINT COMMENT 'Total number of bytes transmitted through the tunnel since establishment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the MPLS tunnel record was first created in the network management system.',
    `dscp_marking` STRING COMMENT 'Differentiated Services Code Point value used for packet marking and QoS treatment within the tunnel.',
    `explicit_route_path` STRING COMMENT 'Ordered list of network nodes or links defining the explicit route object (ERO) that the LSP must traverse, used for traffic engineering.',
    `failover_count` STRING COMMENT 'Number of times the tunnel has failed over to a protection path since establishment.',
    `holding_priority` STRING COMMENT 'Priority level (0-7, where 0 is highest) used to determine whether an established LSP can be preempted by a new LSP with higher setup priority.',
    `jitter_ms` DECIMAL(18,2) COMMENT 'Current packet delay variation (jitter) measurement in milliseconds, indicating consistency of latency.',
    `last_failover_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent failover event to a protection path.',
    `last_modified_by` STRING COMMENT 'User or system identifier that last modified the MPLS tunnel configuration.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the MPLS tunnel record was last updated or modified.',
    `last_reoptimization_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent path reoptimization event for this tunnel.',
    `latency_ms` DECIMAL(18,2) COMMENT 'Current end-to-end latency measurement in milliseconds for traffic traversing the tunnel.',
    `lsp_identifier` STRING COMMENT 'Numeric identifier for the specific Label Switched Path instance within the tunnel, used for multi-path or protection scenarios.',
    `metric_type` STRING COMMENT 'Type of metric used for path computation. IGP = Interior Gateway Protocol metric, TE = Traffic Engineering metric, delay = latency-based, hop-count = number of hops.. Valid values are `IGP|TE|delay|hop-count`',
    `metric_value` STRING COMMENT 'Numeric metric value associated with the tunnel path, used for routing decisions and path selection.',
    `operational_status` STRING COMMENT 'Current operational state of the MPLS tunnel indicating whether it is actively forwarding traffic.. Valid values are `up|down|degraded|testing|maintenance`',
    `packet_loss_count` BIGINT COMMENT 'Total number of packets lost in transit through the tunnel, indicating quality degradation.',
    `packets_received` BIGINT COMMENT 'Total number of packets received through the tunnel since establishment.',
    `packets_transmitted` BIGINT COMMENT 'Total number of packets transmitted through the tunnel since establishment.',
    `path_computation_method` STRING COMMENT 'Method used to compute the tunnel path. CSPF = Constrained Shortest Path First (local computation), PCE = Path Computation Element (centralized), manual = operator-defined.. Valid values are `CSPF|PCE|manual`',
    `pce_address` STRING COMMENT 'IP address of the Path Computation Element server used for centralized path computation when PCE method is enabled.',
    `protection_path` STRING COMMENT 'Ordered list of network nodes or links defining the backup or protection LSP route used when the primary path fails.',
    `protection_type` STRING COMMENT 'Type of protection mechanism configured for the tunnel to ensure resilience. Facility-backup protects multiple LSPs, one-to-one provides dedicated backup, fast-reroute enables sub-50ms recovery.. Valid values are `none|facility-backup|one-to-one|fast-reroute`',
    `reoptimization_enabled` BOOLEAN COMMENT 'Indicates whether periodic path reoptimization is enabled to find more optimal routes as network conditions change.',
    `reoptimization_interval_seconds` STRING COMMENT 'Time interval in seconds between automatic path reoptimization attempts.',
    `setup_priority` STRING COMMENT 'Priority level (0-7, where 0 is highest) used during LSP setup to determine which tunnels can preempt others when resources are constrained.',
    `signaling_protocol` STRING COMMENT 'Protocol used to signal and establish the MPLS tunnel. RSVP-TE = Resource Reservation Protocol Traffic Engineering, LDP = Label Distribution Protocol, BGP = Border Gateway Protocol, SR = Segment Routing.. Valid values are `RSVP-TE|LDP|BGP|Static|SR`',
    `tunnel_id_number` STRING COMMENT 'Numeric tunnel identifier used in RSVP-TE signaling to uniquely identify the tunnel on the ingress node.',
    `tunnel_name` STRING COMMENT 'Human-readable name or label assigned to the MPLS tunnel for identification and operational reference.',
    `tunnel_type` STRING COMMENT 'The signaling protocol or method used to establish the Label Switched Path (LSP). LDP = Label Distribution Protocol, RSVP-TE = Resource Reservation Protocol - Traffic Engineering, SR-MPLS = Segment Routing MPLS, MPLS-TP = MPLS Transport Profile, BGP-LU = BGP Labeled Unicast, Static = manually configured.. Valid values are `LDP|RSVP-TE|SR-MPLS|MPLS-TP|BGP-LU|Static`',
    `uptime_seconds` BIGINT COMMENT 'Total time in seconds that the tunnel has been in operational up state since last establishment.',
    `created_by` STRING COMMENT 'User or system identifier that created the MPLS tunnel configuration.',
    CONSTRAINT pk_mpls_tunnel PRIMARY KEY(`mpls_tunnel_id`)
) COMMENT 'Master record for MPLS Label Switched Paths (LSPs) and traffic engineering tunnels in the IP/MPLS transport network. Captures tunnel name, tunnel type (LDP/RSVP-TE/SR-MPLS), ingress node, egress node, explicit route, bandwidth reservation, QoS class, protection path, signaling protocol, operational state, and traffic statistics thresholds. Supports MPLS network capacity management, traffic engineering, and SD-WAN overlay planning.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`nfv_vnf` (
    `nfv_vnf_id` BIGINT COMMENT 'Unique identifier for the Virtual Network Function instance deployed on the NFV Infrastructure.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Virtual network functions consume cloud resources (compute, storage, network) with costs allocated to cost centers. Required for NFV infrastructure cost allocation, chargeback/showback, and cloud OpEx',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to workforce.work_order. Business justification: VNF deployment and troubleshooting generates work orders for NOC/datacenter technicians. Tracks labor for NFV lifecycle management, enables cost allocation for virtualized network functions, and suppo',
    `element_id` BIGINT COMMENT 'Foreign key linking to network.element. Business justification: NFV VNFs are deployed on network infrastructure (NFVI hosts) which should be tracked as network elements. The nfvi_host_id STRING field is an identifier, not a proper FK. Adding network_element_id est',
    `network_equipment_id` BIGINT COMMENT 'Foreign key linking to inventory.network_equipment. Business justification: VNFs instantiate on NFVI compute nodes (physical servers). Resource allocation tracking, performance troubleshooting, capacity planning, and virtual-to-physical mapping for NFV orchestration require t',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Virtual network functions require assigned engineers for lifecycle management, scaling operations, and troubleshooting. Business process: VNF instantiation, scaling, and termination require engineer a',
    `administrative_state` STRING COMMENT 'Administrative control state indicating whether the VNF is locked for administrative actions, unlocked for normal operations, or in the process of shutting down.. Valid values are `LOCKED|UNLOCKED|SHUTTING_DOWN`',
    `affinity_rule` STRING COMMENT 'Placement rule indicating whether this VNF instance should be co-located (affinity) or separated (anti-affinity) from other VNF instances for performance or resilience.. Valid values are `AFFINITY|ANTI_AFFINITY|NONE`',
    `auto_healing_enabled` BOOLEAN COMMENT 'Indicates whether automatic fault detection and recovery (auto-healing) is enabled for this VNF instance.',
    `configuration_status` STRING COMMENT 'Status of the VNF instance configuration, indicating whether initial configuration has been successfully applied or if configuration errors exist.. Valid values are `CONFIGURED|UNCONFIGURED|CONFIGURATION_ERROR|PENDING_CONFIGURATION`',
    `current_scale_level` STRING COMMENT 'Current number of active VNF instances deployed for this VNF type, reflecting the current scaling state.',
    `data_plane_ip_address` STRING COMMENT 'IP address assigned to the data plane interface of this VNF instance for processing user traffic and signaling.',
    `deployment_flavor` STRING COMMENT 'Deployment flavor identifier specifying the resource profile (CPU, memory, storage) and configuration variant for this VNF instance.',
    `fault_status` STRING COMMENT 'Current fault severity level for this VNF instance based on active alarms and fault management system inputs.. Valid values are `NO_FAULT|MINOR_FAULT|MAJOR_FAULT|CRITICAL_FAULT`',
    `high_availability_mode` STRING COMMENT 'High availability configuration mode for this VNF instance, indicating whether it operates in active-active, active-standby, or no redundancy mode.. Valid values are `ACTIVE_ACTIVE|ACTIVE_STANDBY|NONE`',
    `instantiation_level` STRING COMMENT 'Instantiation level identifier indicating the scale and capacity configuration at which this VNF instance was deployed.',
    `instantiation_state` STRING COMMENT 'Current lifecycle state of the VNF instance indicating whether it is instantiated and operational, failed, or in a transitional state.. Valid values are `NOT_INSTANTIATED|INSTANTIATED|FAILED|TERMINATING|TERMINATED`',
    `instantiation_timestamp` TIMESTAMP COMMENT 'Date and time when this VNF instance was successfully instantiated and became operational.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this VNF instance record was last updated, reflecting configuration changes, scaling events, or state transitions.',
    `license_expiry_date` DATE COMMENT 'Date on which the software license for this VNF instance expires, requiring renewal or decommissioning.',
    `license_key` STRING COMMENT 'Software license key or token required to activate and operate this VNF instance.',
    `license_type` STRING COMMENT 'Type of software licensing model applied to this VNF instance, affecting cost and usage rights.. Valid values are `PERPETUAL|SUBSCRIPTION|CAPACITY_BASED|USAGE_BASED|TRIAL`',
    `management_ip_address` STRING COMMENT 'IP address assigned to the management interface of this VNF instance for configuration, monitoring, and lifecycle management operations.',
    `max_scale_level` STRING COMMENT 'Maximum number of VNF instances that can be deployed for this VNF type based on capacity planning and resource constraints.',
    `min_scale_level` STRING COMMENT 'Minimum number of VNF instances that must be maintained for this VNF type to meet service availability and performance requirements.',
    `monitoring_enabled` BOOLEAN COMMENT 'Indicates whether performance monitoring and fault management are enabled for this VNF instance.',
    `network_service_reference` STRING COMMENT 'Identifier of the parent network service that this VNF instance is part of, enabling end-to-end service tracking and orchestration.',
    `nfvi_host_reference` STRING COMMENT 'Identifier of the physical or virtual host within the NFV Infrastructure where this VNF instance is deployed and running.',
    `nfvo_reference` STRING COMMENT 'Identifier of the NFV Orchestrator responsible for network service orchestration and resource orchestration across the NFV Infrastructure.',
    `notes` STRING COMMENT 'Free-text field for operational notes, troubleshooting history, or special instructions related to this VNF instance.',
    `operational_state` STRING COMMENT 'Indicates whether the VNF instance is currently enabled and processing traffic or disabled for maintenance or troubleshooting.. Valid values are `ENABLED|DISABLED`',
    `performance_tier` STRING COMMENT 'Performance tier classification for this VNF instance indicating the level of service quality, throughput capacity, and resource allocation.. Valid values are `BASIC|STANDARD|PREMIUM|ULTRA`',
    `redundancy_model` STRING COMMENT 'Redundancy architecture model applied to this VNF instance for fault tolerance and service continuity.. Valid values are `1_PLUS_1|N_PLUS_M|LOAD_BALANCED|NONE`',
    `scaling_policy` STRING COMMENT 'Defines the scaling behavior for this VNF instance, indicating whether scaling is manual, automatic (scale-out, scale-in, or both), or not applicable.. Valid values are `MANUAL|AUTO_SCALE_OUT|AUTO_SCALE_IN|AUTO_SCALE_BOTH|NONE`',
    `sla_profile` STRING COMMENT 'Identifier of the SLA profile defining the performance, availability, and quality of service commitments for this VNF instance.',
    `termination_timestamp` TIMESTAMP COMMENT 'Date and time when this VNF instance was terminated and resources were released, applicable only to terminated instances.',
    `usage_state` STRING COMMENT 'Current usage state of the VNF instance indicating whether it is idle, actively processing traffic, or operating at capacity.. Valid values are `IDLE|ACTIVE|BUSY`',
    `vcpu_allocation` STRING COMMENT 'Number of virtual CPU cores allocated to this VNF instance for compute processing.',
    `vendor_name` STRING COMMENT 'Name of the vendor or manufacturer that developed and supplies this VNF software package.',
    `vim_reference` STRING COMMENT 'Identifier of the VIM (e.g., OpenStack, VMware vCenter) managing the compute, storage, and network resources for this VNF instance.',
    `vnf_instance_name` STRING COMMENT 'Human-readable name assigned to this VNF instance for operational identification and management purposes.',
    `vnf_software_version` STRING COMMENT 'Version identifier of the VNF software package currently deployed, used for lifecycle management, patching, and upgrade planning.',
    `vnf_type` STRING COMMENT 'Classification of the virtualized network function indicating its role in the network architecture (e.g., virtual Evolved Packet Core components, IP Multimedia Subsystem elements, virtual Broadband Network Gateway, virtual Customer Premises Equipment). [ENUM-REF-CANDIDATE: vEPC|vMME|vSGW|vPGW|vIMS|vP-CSCF|vS-CSCF|vI-CSCF|vBNG|vFirewall|vRouter|vCPE|vSD-WAN|vDPI|vPCRF|vHSS|vUDM|vPCF|vSMF|vUPF|vAMF — 21 candidates stripped; promote to reference product]',
    `vnfd_reference` STRING COMMENT 'Reference to the VNF Descriptor that defines the deployment template, configuration parameters, and lifecycle management operations for this VNF type.',
    `vnfm_reference` STRING COMMENT 'Identifier of the VNF Manager component within the MANO (Management and Orchestration) framework responsible for lifecycle management of this VNF instance.',
    `vram_allocation_gb` DECIMAL(18,2) COMMENT 'Amount of virtual memory in gigabytes allocated to this VNF instance for runtime operations.',
    `vstorage_allocation_gb` DECIMAL(18,2) COMMENT 'Amount of virtual disk storage in gigabytes allocated to this VNF instance for persistent data and configuration storage.',
    CONSTRAINT pk_nfv_vnf PRIMARY KEY(`nfv_vnf_id`)
) COMMENT 'Master record for Virtual Network Functions (VNFs) deployed on the NFV Infrastructure (NFVI) — virtualized instances of network functions such as virtual EPC (vMME, vSGW, vPGW), IMS components (P-CSCF, S-CSCF, I-CSCF), virtual BNG, virtual firewall, and SD-WAN vCPE. Captures VNF name, VNF type, vendor, version, NFVI host, vCPU allocation, vRAM allocation, vStorage allocation, instantiation state, scaling policy, and associated VNFD (VNF Descriptor). Managed via MANO (NFV Management and Orchestration).';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`ip_address_plan` (
    `ip_address_plan_id` BIGINT COMMENT 'Unique identifier for the IP address plan record. Primary key for IP address space management (IPAM) entries.',
    `element_id` BIGINT COMMENT 'Reference to the network element (RAN, core, transport node, OLT, ONT, DSLAM, BNG, BRAS) to which this IP address block is assigned.',
    `network_qos_profile_id` BIGINT COMMENT 'Foreign key linking to network.qos_profile. Business justification: IP address blocks can have QoS classifications that determine default traffic treatment for addresses in that block. Currently quality_of_service_class is stored as STRING. Normalizing to qos_profile ',
    `pop_facility_id` BIGINT COMMENT 'Reference to the POP site or network location where this IP address block is deployed.',
    `address_space_type` STRING COMMENT 'Classification of the IP address space: public (globally routable), private (RFC 1918 for IPv4 or ULA for IPv6), reserved (special-use addresses), or carrier_grade_nat (CGN/LSN address pool per RFC 6598).. Valid values are `public|private|reserved|carrier_grade_nat`',
    `allocation_date` DATE COMMENT 'Date when this IP address block was initially allocated or assigned to the network element or service.',
    `allocation_purpose` STRING COMMENT 'Business purpose for which this IP address block is allocated: management (network device management), subscriber (customer-facing services), loopback (routing protocol loopbacks), transit (inter-AS routing), peering (interconnect with other carriers), or infrastructure (internal network services).. Valid values are `management|subscriber|loopback|transit|peering|infrastructure`',
    `allocation_status` STRING COMMENT 'Current lifecycle status of the IP address block: free (available for assignment), reserved (held for future use), allocated (actively assigned), quarantined (temporarily blocked due to security or abuse), or deprecated (scheduled for decommissioning).. Valid values are `free|reserved|allocated|quarantined|deprecated`',
    `assigned_addresses_count` STRING COMMENT 'Number of IP addresses from this block that are currently assigned to devices or services.',
    `autonomous_system_number` STRING COMMENT 'Autonomous System Number (ASN) associated with this IP address block for BGP routing. Identifies the carrier or network operator.',
    `available_addresses_count` STRING COMMENT 'Number of IP addresses in this block that remain available for assignment.',
    `block_size` BIGINT COMMENT 'Total number of IP addresses available in this block (e.g., /24 = 256 addresses, /30 = 4 addresses).',
    `broadcast_address` STRING COMMENT 'Broadcast address for this IPv4 subnet, typically the last address in the block. Not applicable for IPv6.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this IP address plan record was first created in the system.',
    `dhcp_pool_flag` BOOLEAN COMMENT 'Indicates whether this IP address block is configured as a DHCP pool for dynamic address assignment (True) or used for static assignment (False).',
    `dns_zone` STRING COMMENT 'DNS zone or domain name associated with this IP address block for reverse DNS lookups (e.g., in-addr.arpa for IPv4, ip6.arpa for IPv6).',
    `expiration_date` DATE COMMENT 'Date when this IP address block allocation expires or is scheduled for review. Null for permanent allocations.',
    `gateway_address` STRING COMMENT 'Default gateway IP address for this subnet, typically the first usable address in the block.',
    `ip_prefix` STRING COMMENT 'IP address block in CIDR notation (e.g., 10.0.0.0/24 for IPv4 or 2001:db8::/32 for IPv6). Represents the network prefix and subnet mask.. Valid values are `^([0-9]{1,3}.){3}[0-9]{1,3}/[0-9]{1,2}$|^([0-9a-fA-F]{0,4}:){2,7}[0-9a-fA-F]{0,4}/[0-9]{1,3}$`',
    `ip_version` STRING COMMENT 'Version of the IP protocol for this address block: IPv4 or IPv6.. Valid values are `IPv4|IPv6`',
    `ipam_source_system` STRING COMMENT 'Name of the IPAM or Network Management System (NMS/EMS) that is the authoritative source for this IP address plan record (e.g., Nokia NetAct, Ericsson Network Manager, Infoblox).',
    `last_audit_date` DATE COMMENT 'Date of the most recent IPAM audit or utilization review for this IP address block.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this IP address plan record was last updated or modified.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user or system process that last modified this IP address plan record.',
    `network_function_type` STRING COMMENT 'Type of network function or service supported by this IP address block (e.g., RAN, Core, IMS, NFV, SDN, GPON, MPLS, SD-WAN).',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this IP address block allocation, including special configurations, exceptions, or operational instructions.',
    `parent_prefix` STRING COMMENT 'Parent or supernet IP prefix from which this block was subdivided. Supports hierarchical IP address planning and aggregation.',
    `region_code` STRING COMMENT 'Geographic region or market code where this IP address block is deployed (e.g., NAM, EMEA, APAC, or country-specific codes).',
    `responsible_team` STRING COMMENT 'Name of the Network Operations Center (NOC) team or organizational unit responsible for managing this IP address block.',
    `routing_domain` STRING COMMENT 'Routing domain or autonomous system (AS) to which this IP address block belongs (e.g., internal, external, MPLS VPN instance name).',
    `security_zone` STRING COMMENT 'Security zone classification for this IP address block (e.g., DMZ, trusted, untrusted, management, customer-facing) used for firewall policy and access control.',
    `subnet_mask` STRING COMMENT 'Subnet mask in dotted-decimal notation (e.g., 255.255.255.0) for IPv4 address blocks. Defines the network and host portions of the address.. Valid values are `^([0-9]{1,3}.){3}[0-9]{1,3}$`',
    `utilization_percentage` DECIMAL(18,2) COMMENT 'Percentage of IP addresses in this block that are currently assigned or in use (0.00 to 100.00).',
    `vlan_number` STRING COMMENT 'VLAN tag associated with this IP address block for Layer 2 network segmentation (range 1-4094).',
    CONSTRAINT pk_ip_address_plan PRIMARY KEY(`ip_address_plan_id`)
) COMMENT 'Master record for IP address space management (IPAM) — IPv4 and IPv6 address blocks, subnets, and pools allocated across network infrastructure. Captures IP prefix (CIDR notation), IP version, block size, allocation purpose (management/subscriber/loopback/transit/peering), assigned element or POP site, VLAN association, utilization percentage, allocation status (free/reserved/allocated/quarantined), and responsible team. Supports IP address lifecycle management, subnet planning, and audit compliance for network operations.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`capacity` (
    `capacity_id` BIGINT COMMENT 'Primary key for capacity',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Capacity reservations and guaranteed bandwidth allocations for enterprise customers must be tracked against their billing accounts. Essential for enterprise capacity-based billing, reservation trackin',
    `capital_project_id` BIGINT COMMENT 'Reference identifier for the associated capacity expansion or upgrade project. Links capacity records to capital expenditure tracking.',
    `element_id` BIGINT COMMENT 'Reference to the specific network element (RAN cell, OLT, BNG, MPLS node, etc.) for which capacity is being tracked.',
    `pop_facility_id` BIGINT COMMENT 'Foreign key linking to inventory.pop_facility. Business justification: Capacity measurements (space, power, cooling, rack units) are facility-specific. PoP-level capacity reporting drives expansion projects, site selection, and infrastructure investment planning in telec',
    `available_capacity` DECIMAL(18,2) COMMENT 'Remaining capacity available for new service provisioning. Calculated as total capacity minus committed capacity and any reserved buffers.',
    `average_utilization_percentage` DECIMAL(18,2) COMMENT 'Mean utilization percentage across the measurement period. Used for trend analysis and capacity planning forecasting.',
    `busy_hour_indicator` BOOLEAN COMMENT 'Flag indicating whether this measurement represents the busy hour period. Busy hour metrics are critical for capacity dimensioning and network planning.',
    `capacity_status` STRING COMMENT 'Current operational status of the resource capacity relative to defined thresholds. Drives capacity augmentation and network planning decisions.. Valid values are `under_utilized|normal|near_threshold|congested|critical|planned_upgrade`',
    `collection_method` STRING COMMENT 'Method by which capacity data was collected or derived. Indicates data quality and reliability characteristics.. Valid values are `automated_polling|snmp|netconf|manual_entry|calculated|aggregated`',
    `committed_capacity` DECIMAL(18,2) COMMENT 'Capacity already allocated or reserved for active services and customer commitments. Represents the portion of total capacity currently in use or reserved.',
    `congestion_threshold_percentage` DECIMAL(18,2) COMMENT 'Utilization percentage threshold at which the resource is considered congested and requires capacity augmentation. Typically set based on QoS requirements and SLA commitments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this capacity record was first created in the system. Audit trail for data lineage and record lifecycle tracking.',
    `critical_threshold_percentage` DECIMAL(18,2) COMMENT 'Utilization percentage threshold indicating critical capacity exhaustion requiring immediate intervention. Triggers urgent capacity expansion or traffic engineering actions.',
    `data_source` STRING COMMENT 'Source system or tool from which capacity measurements were collected. Identifies the authoritative system of record for this capacity data. [ENUM-REF-CANDIDATE: netact|ericsson_nm|nms|ems|oss|manual_survey|capacity_tool — 7 candidates stripped; promote to reference product]',
    `equipment_model` STRING COMMENT 'Specific equipment model or platform type. Enables model-specific capacity profiling and upgrade path planning.',
    `forecast_date` DATE COMMENT 'Projected date when capacity will reach congestion threshold based on current growth trends. Drives capital planning and network expansion timelines.',
    `geographic_region` STRING COMMENT 'Geographic region or market area where the network resource is deployed. Used for regional capacity planning and investment prioritization.',
    `growth_rate_percentage` DECIMAL(18,2) COMMENT 'Observed or projected capacity growth rate percentage per period. Used for trend-based capacity forecasting and investment planning.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this capacity record. Tracks data freshness and change history for capacity management.',
    `measurement_end_timestamp` TIMESTAMP COMMENT 'Ending timestamp of the capacity measurement period. Used with start timestamp to define the observation window for capacity metrics.',
    `measurement_interval_minutes` STRING COMMENT 'Duration of the measurement period in minutes. Common intervals include 15, 30, 60 minutes for operational monitoring and daily/weekly for planning.',
    `measurement_start_timestamp` TIMESTAMP COMMENT 'Beginning timestamp of the capacity measurement period. Defines the temporal window for utilization calculations.',
    `network_layer` STRING COMMENT 'Hierarchical network layer classification of the resource. Aligns with network architecture topology and capacity planning domains.. Valid values are `access|aggregation|core|transport|edge|backhaul`',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, anomalies, planned maintenance, or special conditions affecting capacity measurements.',
    `peak_utilization_percentage` DECIMAL(18,2) COMMENT 'Maximum utilization percentage observed during the measurement period. Critical metric for identifying capacity bottlenecks and congestion events.',
    `planned_upgrade_date` DATE COMMENT 'Scheduled date for capacity augmentation or upgrade activity. Links capacity monitoring to capital project execution.',
    `qos_class` STRING COMMENT 'QoS classification of traffic carried by this resource. Different QoS classes may have different capacity thresholds and planning criteria.. Valid values are `premium|standard|best_effort|guaranteed|mission_critical`',
    `redundancy_configuration` STRING COMMENT 'Redundancy architecture of the resource. Impacts effective capacity calculations and failure scenario planning.. Valid values are `none|active_standby|active_active|n_plus_one|geographic_redundant`',
    `reservation_percentage` DECIMAL(18,2) COMMENT 'Percentage of total capacity reserved for network resilience, traffic bursts, and emergency services. Not available for normal service provisioning.',
    `resource_identifier` STRING COMMENT 'Business identifier or name of the specific resource (cell ID, link name, tunnel ID, port designation). Human-readable reference used in network operations.',
    `resource_type` STRING COMMENT 'Classification of the network resource being measured for capacity. Identifies the infrastructure layer and technology domain. [ENUM-REF-CANDIDATE: ran_cell|transmission_link|mpls_tunnel|bng_port|olt_port|bras_port|core_router|dslam_port|fiber_segment|spectrum_block — 10 candidates stripped; promote to reference product]',
    `sla_target_availability_percentage` DECIMAL(18,2) COMMENT 'Target availability percentage defined in SLA commitments. Capacity planning must ensure sufficient redundancy to meet availability targets.',
    `software_version` STRING COMMENT 'Software or firmware version running on the network element. Capacity characteristics may vary by software release.',
    `technology_domain` STRING COMMENT 'Technology domain classification of the network resource. Groups capacity records by major technology areas for domain-specific planning. [ENUM-REF-CANDIDATE: ran|transport|core|fixed_access|mobile_core|ip_backbone|optical — 7 candidates stripped; promote to reference product]',
    `total_capacity` DECIMAL(18,2) COMMENT 'Maximum theoretical capacity of the resource. Represents the absolute upper limit for bandwidth, channels, ports, or connections depending on resource type.',
    `unit` STRING COMMENT 'Unit of measurement for capacity values. Varies by resource type (bandwidth for links, Erlangs for voice, channels for radio, ports for switches). [ENUM-REF-CANDIDATE: mbps|gbps|erlangs|channels|ports|connections|mhz|subscribers — 8 candidates stripped; promote to reference product]',
    `vendor_name` STRING COMMENT 'Equipment vendor or manufacturer of the network element. Used for vendor-specific capacity analysis and multi-vendor network planning.',
    CONSTRAINT pk_capacity PRIMARY KEY(`capacity_id`)
) COMMENT 'Tracks capacity metrics and utilization thresholds for network elements, links, and cells — the operational capacity management record. Captures resource type (RAN cell, transmission link, MPLS tunnel, BNG port), total capacity (bandwidth/channels/ports), committed capacity, peak utilization percentage, average utilization percentage, congestion threshold, measurement period, and capacity status (under-utilized/normal/congested/critical). Feeds network planning and capacity augmentation decisions. Distinct from performance KPIs — this is the capacity planning master record.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`element_config` (
    `element_config_id` BIGINT COMMENT 'Unique identifier for the network element configuration record. Primary key for configuration management tracking across Nokia NetAct and Ericsson Network Manager platforms.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager, engineer, or CAB (Change Advisory Board) member who approved this configuration change. Required for audit trail and accountability in regulated environments.',
    `change_record_id` BIGINT COMMENT 'Reference to the change management ticket or request that authorized this configuration change. Links to ServiceNow ITSM change management system for audit trail and compliance tracking.',
    `config_template_id` BIGINT COMMENT 'Reference to the standardized configuration template or golden config that this configuration is based on. Enables consistency across similar network elements and simplifies mass configuration deployment.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Configuration management activities (automation, compliance validation, backup) incur operational costs allocated to network operations cost centers. Required for NOC cost tracking and operational exp',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Configuration changes tracked per managed service instance for change control and audit. Business process: managed service configuration management, service-specific change tracking, and compliance va',
    `element_id` BIGINT COMMENT 'Reference to the physical or logical network element (RAN node, OLT, BNG, BRAS, router, switch) that this configuration applies to. Links to the network element inventory.',
    `planned_outage_id` BIGINT COMMENT 'Reference to the scheduled maintenance window during which this configuration change was executed. Ensures changes occur during approved low-impact periods and supports SLA (Service Level Agreement) compliance tracking.',
    `primary_element_employee_id` BIGINT COMMENT 'Identifier of the network operations engineer or administrator who initiated or approved this configuration change. Used for accountability, audit trail, and access control compliance. May be human operator or automation system identifier.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Configuration changes must comply with regulatory requirements (E911 capabilities, lawful intercept readiness, accessibility features). Change management processes validate configurations against appl',
    `rollback_reference_element_config_id` BIGINT COMMENT 'Reference to the previous configuration version that was restored during a rollback operation. Enables tracking of configuration reversion history and supports automated rollback procedures.',
    `affected_subscribers_count` STRING COMMENT 'Estimated or actual number of subscribers impacted by this configuration change. Used for impact assessment, prioritization, and customer communication during planned maintenance or incident response.',
    `approval_status` STRING COMMENT 'Approval state of the configuration change request. Approved indicates change authorized by Change Advisory Board (CAB). Emergency_override indicates expedited approval for critical fixes. Used for governance and audit compliance.. Valid values are `approved|pending|rejected|emergency_override`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the configuration change was formally approved. Used to track approval-to-execution time and ensure changes are executed within approved maintenance windows.',
    `archived_timestamp` TIMESTAMP COMMENT 'Date and time when this configuration was moved to archived status. Used for retention policy enforcement and historical analysis. Null for active or staged configurations.',
    `automation_system` STRING COMMENT 'Name of the automation platform or orchestration system that executed this configuration change (e.g., Nokia NetAct, Ericsson Network Manager, Ansible, Terraform, NSO). Null if manually executed by operator.',
    `backup_location` STRING COMMENT 'Storage path or URI where the full configuration backup file is stored. Supports disaster recovery, audit compliance, and rapid restoration. May reference network file system, object storage, or configuration management database.',
    `change_type` STRING COMMENT 'Classification of the configuration change: planned (scheduled maintenance window), emergency (urgent fix outside normal window), automated (system-initiated optimization), rollback (reversion to previous config).. Valid values are `planned|emergency|automated|rollback`',
    `checksum` STRING COMMENT 'Cryptographic hash (MD5, SHA-256) of the configuration file to ensure integrity and detect unauthorized modifications. Used for security audit and tamper detection in compliance with security frameworks.',
    `compliance_policy_version` STRING COMMENT 'Version of the compliance policy framework used to validate this configuration. Ensures audit trail of which standards were applied at the time of configuration deployment.',
    `compliance_status` STRING COMMENT 'Indicates whether this configuration meets organizational policy standards, security baselines, and regulatory requirements. Non-compliant configurations trigger alerts for remediation. Used for configuration drift detection.. Valid values are `compliant|non_compliant|pending_review|exempted`',
    `config_description` STRING COMMENT 'Human-readable description of the configuration change purpose, scope, and expected outcome. Includes business justification such as capacity expansion, performance optimization, security hardening, or bug fix.',
    `config_notes` STRING COMMENT 'Additional operational notes, lessons learned, or special considerations related to this configuration. Used for knowledge management and to inform future similar changes.',
    `config_parameters` STRING COMMENT 'Structured representation of configuration parameters including neighbor cell lists, handover thresholds, QoS (Quality of Service) policies, routing tables, VLAN assignments, MPLS labels, BGP peers, OSPF areas, and vendor-specific settings. Stored as JSON or XML for structured querying.',
    `config_source_system` STRING COMMENT 'Name of the source system or NMS (Network Management System) / EMS (Element Management System) that generated or captured this configuration record (e.g., Nokia NetAct, Ericsson Network Manager, Netcracker OSS).',
    `config_status` STRING COMMENT 'Current lifecycle status of this configuration record. Active indicates currently deployed; staged indicates pending activation; archived indicates historical record; superseded indicates replaced by newer version; failed indicates deployment failure.. Valid values are `active|staged|archived|superseded|failed`',
    `config_type` STRING COMMENT 'Type of configuration record: running (active operational config), startup (boot config), candidate (staged for activation), baseline (approved reference), golden (vendor-certified template).. Valid values are `running|startup|candidate|baseline|golden`',
    `config_version` STRING COMMENT 'Version identifier for this configuration snapshot. Follows semantic versioning or vendor-specific versioning scheme (e.g., 2.4.1, R15B). Used for configuration baseline tracking and rollback operations.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this configuration record was first created in the configuration management system. Distinct from execution_timestamp which indicates when config was deployed to network element.',
    `drift_details` STRING COMMENT 'Detailed description of configuration drift including specific parameters that differ from baseline, magnitude of deviation, and potential impact on network performance or security. Used for root cause analysis.',
    `drift_detected_flag` BOOLEAN COMMENT 'Boolean indicator that the running configuration has diverged from the approved baseline configuration. Triggers automated alerts for investigation and remediation to maintain network stability and security posture.',
    `execution_outcome` STRING COMMENT 'Result of the configuration deployment attempt: success (fully applied), partial (some parameters applied), failed (deployment unsuccessful), rolled_back (reverted to previous config due to validation failure or service impact).. Valid values are `success|partial|failed|rolled_back`',
    `execution_timestamp` TIMESTAMP COMMENT 'Precise date and time when this configuration was deployed to the network element. Critical for correlating configuration changes with network performance events, outages, or KPI (Key Performance Indicator) degradation.',
    `failure_reason` STRING COMMENT 'Detailed explanation of why a configuration deployment failed or was rolled back. Includes error codes, validation failures, resource conflicts, or service impact triggers. Used for troubleshooting and process improvement.',
    `geographic_region` STRING COMMENT 'Geographic region or market where the network element is deployed (e.g., Northeast, Southwest, EMEA, APAC). Used for regional configuration standards, compliance requirements, and performance analysis.',
    `impact_assessment` STRING COMMENT 'Pre-change analysis of potential impact on network services, customer experience, and KPIs. Includes affected services, subscriber count, geographic scope, and risk level. Used for change approval and rollback planning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this configuration record was last updated in the configuration management database. Used for audit trail and to track configuration lifecycle changes.',
    `network_layer` STRING COMMENT 'OSI or telecom-specific network layer this configuration applies to (e.g., Layer 2, Layer 3, application layer, control plane, user plane). Used for troubleshooting and impact analysis.',
    `noc_site_code` STRING COMMENT 'Code identifying the NOC (Network Operations Center) or regional operations center responsible for managing this network element configuration. Used for operational accountability and escalation routing.',
    `parameters_modified` STRING COMMENT 'List of specific configuration parameters that were changed in this version, with before and after values. Enables precise change tracking and impact analysis for troubleshooting and audit purposes.',
    `retention_period_days` STRING COMMENT 'Number of days this configuration record must be retained for compliance, audit, or operational purposes. Based on regulatory requirements (FCC, GDPR) and internal data governance policies.',
    `service_impact_flag` BOOLEAN COMMENT 'Boolean indicator that this configuration change caused or is expected to cause service disruption, degradation, or customer impact. Used for SLA tracking, root cause analysis, and change management process improvement.',
    `software_version` STRING COMMENT 'Software or firmware version running on the network element at the time of this configuration. Critical for ensuring configuration compatibility and troubleshooting version-specific issues.',
    `technology_domain` STRING COMMENT 'High-level technology domain classification: RAN (Radio Access Network), transport (MPLS/SD-WAN), core (EPC/5GC), access (GPON/FTTH/DSLAM), edge (MEC), IMS (IP Multimedia Subsystem). Used for domain-specific configuration policies.. Valid values are `ran|transport|core|access|edge|ims`',
    `validation_errors` STRING COMMENT 'List of validation errors or warnings identified during configuration validation. Includes syntax errors, policy violations, resource conflicts, or dependency issues. Used to prevent service-impacting misconfigurations.',
    `validation_status` STRING COMMENT 'Result of pre-deployment or post-deployment validation checks. Validated indicates configuration passed all syntax, semantic, and policy checks. Validation_failed indicates issues detected. Used to prevent deployment of invalid configurations.. Valid values are `validated|validation_failed|pending_validation|skipped`',
    `vendor_name` STRING COMMENT 'Name of the network equipment vendor (e.g., Nokia, Ericsson, Cisco, Huawei, Juniper). Used to apply vendor-specific configuration templates, validation rules, and management protocols.',
    CONSTRAINT pk_element_config PRIMARY KEY(`element_config_id`)
) COMMENT 'Configuration management record for network elements — stores both the active configuration baseline AND the transactional history of all configuration changes. Baseline section: configuration version, type (running/startup/candidate), structured parameters (neighbor lists, handover thresholds, QoS policies, routing tables), compliance status. Change history section: change request reference, change type (planned/emergency/automated), parameters modified (before/after values), execution timestamp, operator/automation ID, outcome (success/partial/failed/rolled-back), rollback reference. Aligned with Nokia NetAct Configuration Management and Ericsson Network Manager. Supports configuration audit, drift detection, rollback, change management compliance, and root cause analysis.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`config_change` (
    `config_change_id` BIGINT COMMENT 'Unique identifier for the configuration change record. Primary key for the configuration change transaction.',
    `element_config_id` BIGINT COMMENT 'Foreign key linking to network.element_config. Business justification: Configuration changes are applied against a baseline configuration. This FK links each config_change transaction to the element_config baseline it modifies, enabling change impact analysis, rollback p',
    `change_record_id` BIGINT COMMENT 'Foreign key linking to assurance.change_record. Business justification: Network configuration changes must reference formal change management records for CAB approval tracking, compliance auditing, and rollback coordination. Standard ITIL change management process require',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Configuration changes may incur vendor professional services or internal labor costs allocated to cost centers. Enables tracking of change management costs and operational expense allocation.',
    `employee_id` BIGINT COMMENT 'Identifier of the human operator or technician who executed the configuration change. May be a user ID from Nokia NetAct, Ericsson Network Manager, or ServiceNow ITSM.',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: Configuration changes executed by technicians (field or NOC) require audit trail linking change to executor. Regulatory compliance (SOX, telecom audits) and change management processes mandate trackin',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Config changes impact specific managed services for incident correlation. Business process: managed service change tracking, service impact assessment, and root cause analysis linking changes to servi',
    `element_id` BIGINT COMMENT 'Identifier of the network element (RAN, core, transport, GPON, MPLS node, etc.) on which the configuration change was applied.',
    `planned_outage_id` BIGINT COMMENT 'Identifier of the scheduled maintenance window during which this configuration change was executed. Null if executed outside a maintenance window.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the configuration change execution completed or failed.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the configuration change execution began. This is the principal business event timestamp for the transaction.',
    `affected_customers_count` STRING COMMENT 'Estimated or actual number of customers whose services were impacted by this configuration change.',
    `affected_services` STRING COMMENT 'Comma-separated list of service identifiers or service names that were potentially impacted by this configuration change (e.g., VoLTE, IPTV, Broadband).',
    `after_value` DECIMAL(18,2) COMMENT 'Configuration parameter value(s) after the change was applied. Supports verification and compliance validation.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the configuration change was approved for execution.',
    `approved_by` STRING COMMENT 'Identifier or name of the approver (CAB member, manager, or automated approval system) who authorized the configuration change.',
    `backup_created` BOOLEAN COMMENT 'Indicates whether a configuration backup was created before applying this change to enable rollback (True/False).',
    `backup_reference` STRING COMMENT 'Identifier or file path of the configuration backup created before this change. Null if no backup was created.',
    `before_value` DECIMAL(18,2) COMMENT 'Configuration parameter value(s) before the change was applied. Supports audit trail and rollback scenarios.',
    `change_description` STRING COMMENT 'Detailed textual description of the configuration change, including business justification, technical scope, and expected impact.',
    `change_notes` STRING COMMENT 'Additional free-text notes, observations, or comments recorded by the operator or system during or after the configuration change execution.',
    `change_priority` STRING COMMENT 'Business priority level assigned to the configuration change: low, normal, high, urgent, or critical.. Valid values are `low|normal|high|urgent|critical`',
    `compliance_validated` BOOLEAN COMMENT 'Indicates whether the configuration change has been validated against compliance policies and regulatory requirements (True/False).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this configuration change record was first created in the system.',
    `downtime_duration_minutes` STRING COMMENT 'Total duration in minutes of service downtime caused by this configuration change. Zero if no downtime occurred.',
    `executed_by_system` STRING COMMENT 'Name or identifier of the automation system or orchestration platform that executed the change (e.g., Nokia NetAct, Ericsson Network Manager, Ansible Tower, NSO).',
    `failure_reason` STRING COMMENT 'Detailed explanation of why the configuration change failed or was rolled back. Null if change was successful.',
    `impact_assessment` STRING COMMENT 'Assessed business and technical impact level of the configuration change on network services and customers: low, medium, high, or critical.. Valid values are `low|medium|high|critical`',
    `incident_reference` STRING COMMENT 'Reference to the incident ticket (from ServiceNow ITSM or fault management system) that triggered this emergency configuration change. Null for planned changes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this configuration change record was last updated or modified.',
    `noc_notification_sent` BOOLEAN COMMENT 'Indicates whether the Network Operations Center was notified about this configuration change (True/False).',
    `parameters_modified` STRING COMMENT 'Comma-separated or structured list of configuration parameters that were modified during this change (e.g., txPower, antennaAzimuth, vlanId).',
    `risk_level` STRING COMMENT 'Risk classification of the configuration change based on probability and impact of failure: low, medium, high, or critical.. Valid values are `low|medium|high|critical`',
    `rollback_reference` STRING COMMENT 'Reference identifier to the rollback change request or transaction that reverted this configuration change. Null if no rollback occurred.',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'Planned date and time when the configuration change was scheduled to complete.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned date and time when the configuration change was scheduled to begin execution.',
    `software_version_after` STRING COMMENT 'Software or firmware version of the network element after the configuration change. Relevant for software upgrade changes.',
    `software_version_before` STRING COMMENT 'Software or firmware version of the network element before the configuration change. Relevant for software upgrade changes.',
    `validation_result` STRING COMMENT 'Result of post-change validation tests: passed (all tests successful), failed (validation detected issues), partial (some tests passed), or not_performed.. Valid values are `passed|failed|partial|not_performed`',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when post-change validation and verification tests were completed.',
    `vendor_name` STRING COMMENT 'Name of the network equipment vendor whose element was modified (e.g., Nokia, Ericsson, Huawei, Cisco).',
    CONSTRAINT pk_config_change PRIMARY KEY(`config_change_id`)
) COMMENT 'Transactional record of every configuration change applied to a network element — the configuration change history log aligned with Nokia NetAct and Ericsson Network Manager change management. Captures change request reference, change type (planned/emergency/automated), change description, parameters modified (before/after values), execution timestamp, executed by (operator ID/automation system), change outcome (success/partial/failed/rolled-back), and rollback reference. Supports change management, compliance auditing, and root cause analysis for network incidents.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`performance_counter` (
    `performance_counter_id` BIGINT COMMENT 'Primary key for performance_counter',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Performance metrics for dedicated enterprise circuits, wholesale services require customer attribution. Real process: enterprise SLA reporting, per-customer capacity planning, wholesale billing verifi',
    `location_site_id` BIGINT COMMENT 'Reference to the physical network site (cell tower, POP, central office, data center) where the measured network element is located.',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Performance metrics collected per managed service for SLA validation and reporting. Business process: enterprise SLA measurement, service-level performance monitoring, and monthly SLA compliance repor',
    `element_id` BIGINT COMMENT 'Reference to the network element (RAN node, OLT, BNG, BRAS, core network function, transport node) that generated this performance measurement.',
    `pop_facility_id` BIGINT COMMENT 'Foreign key linking to inventory.pop_facility. Business justification: Performance KPIs aggregated by facility for site-level SLA reporting, regional performance dashboards, facility ranking, and site optimization initiatives. Reuses existing pop_facility_id(FK→inventory',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Performance metrics (E911 call completion rates, location accuracy, service availability) are measured against regulatory obligations. Telecommunications operators report compliance KPIs to regulatory',
    `sla_contract_id` BIGINT COMMENT 'Reference to the specific SLA contract or policy that governs the performance thresholds and reporting requirements for this measurement.',
    `aggregation_method` STRING COMMENT 'The statistical method used to aggregate multiple raw measurements into the reported counter value. Examples: Sum (total), Average (mean), Minimum, Maximum, Percentile (95th, 99th), Count.. Valid values are `Sum|Average|Minimum|Maximum|Percentile|Count`',
    `breach_severity` STRING COMMENT 'The severity classification of the threshold breach if one occurred. Aligns with ITU-T X.733 alarm severity levels: Critical (service-affecting), Major (significant degradation), Minor (potential issue), Warning (approaching threshold).. Valid values are `Critical|Major|Minor|Warning`',
    `collection_status` STRING COMMENT 'The operational status of the performance data collection process for this record. Complete (full interval data), Partial (some samples missing), Failed (collection error), Suspect (data integrity concerns).. Valid values are `Complete|Partial|Failed|Suspect`',
    `collection_timestamp` TIMESTAMP COMMENT 'The date and time when this performance record was retrieved from the network element and ingested into the performance management system (Nokia NetAct or Ericsson Network Manager).',
    `correlation_key` STRING COMMENT 'A unique identifier used to correlate this performance measurement with related network events, alarms, or configuration changes occurring during the same time window. Enables cross-domain root cause analysis.',
    `counter_name` STRING COMMENT 'The raw performance counter identifier as defined by the network element vendor (Nokia, Ericsson, Huawei). This is the native counter name from the NMS/EMS system before KPI derivation.',
    `counter_value` DECIMAL(18,2) COMMENT 'The raw numeric value of the performance counter as collected from the network element. This is the unprocessed measurement before any KPI calculation or normalization.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this performance counter record was first inserted into the lakehouse silver layer. Used for data lineage, audit trail, and incremental processing.',
    `customer_impact_flag` BOOLEAN COMMENT 'Indicates whether the measured performance level (especially if threshold-breaching) has direct impact on customer-facing service quality. Used to prioritize network optimization and remediation efforts.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'A percentage score (0-100) indicating the completeness and reliability of this performance measurement. Accounts for missing samples, collection errors, or element unavailability during the measurement interval.',
    `geographic_region_code` STRING COMMENT 'The geographic region or market identifier where the measured network element is deployed. Used for regional performance analysis and capacity planning.',
    `kpi_category` STRING COMMENT 'High-level classification of the performance measurement domain: RAN (Radio Access Network), Transport (MPLS/SD-WAN), Core (IMS/EPC/5GC), Access (GPON/FTTH/DSLAM), Backhaul, or Aggregation.. Valid values are `RAN|Transport|Core|Access|Backhaul|Aggregation`',
    `kpi_name` STRING COMMENT 'Specific name of the performance metric being measured. Examples: RSRP (Reference Signal Received Power), SINR (Signal-to-Interference-plus-Noise Ratio), throughput_mbps, handover_success_rate, packet_loss_rate, session_establishment_rate, call_drop_rate, latency_ms, jitter_ms.',
    `kpi_value` DECIMAL(18,2) COMMENT 'The derived KPI value calculated from one or more raw performance counters. This is the business-meaningful metric used for network performance analysis and SLA monitoring.',
    `measurement_interval_minutes` STRING COMMENT 'Duration of the measurement period in minutes. Standard intervals are 15 minutes (granular), 60 minutes (hourly), or 1440 minutes (daily) as defined by 3GPP performance management standards.',
    `measurement_timestamp` TIMESTAMP COMMENT 'The exact date and time when this performance measurement was collected from the network element. Represents the end of the measurement interval.',
    `network_layer` STRING COMMENT 'The OSI model layer at which this performance measurement was captured. Helps categorize performance data by protocol stack level for root cause analysis.. Valid values are `Physical|Data Link|Network|Transport|Application`',
    `network_technology` STRING COMMENT 'The telecommunications technology domain of the network element generating this performance data. Examples: 5G NR (5G New Radio), LTE (Long-Term Evolution), GPON (Gigabit Passive Optical Network), MPLS (Multiprotocol Label Switching), IMS (IP Multimedia Subsystem). [ENUM-REF-CANDIDATE: 5G NR|LTE|UMTS|GSM|GPON|FTTH|MPLS|SD-WAN|IMS|EPC — 10 candidates stripped; promote to reference product]',
    `nms_system_name` STRING COMMENT 'The name of the Network Management System or Element Management System that collected and reported this performance measurement. Source system for data lineage and reconciliation.. Valid values are `Nokia NetAct|Ericsson Network Manager|Huawei U2000|Other`',
    `notes` STRING COMMENT 'Free-text field for operational notes, annotations, or context about this performance measurement. May include information about planned maintenance, known issues, or data quality caveats.',
    `sample_count` BIGINT COMMENT 'The number of individual measurements or observations aggregated into this performance counter record during the measurement interval. Indicates statistical confidence of the reported value.',
    `service_type` STRING COMMENT 'The type of telecommunications service being measured by this performance counter. Used to correlate network performance with customer-facing service quality.. Valid values are `Voice|Data|Video|IoT|Enterprise|Residential`',
    `sla_applicable_flag` BOOLEAN COMMENT 'Indicates whether this performance measurement is subject to a customer-facing or internal SLA commitment. True means the KPI is contractually committed and impacts SLA compliance reporting.',
    `threshold_breach_flag` BOOLEAN COMMENT 'Indicates whether the measured KPI value breached the defined threshold limits (upper or lower) during this measurement interval. True indicates a threshold violation requiring attention.',
    `threshold_lower_limit` DECIMAL(18,2) COMMENT 'The minimum acceptable value for this KPI as defined in the network performance SLA or operational policy. Values below this threshold trigger performance degradation alerts.',
    `threshold_upper_limit` DECIMAL(18,2) COMMENT 'The maximum acceptable value for this KPI (applicable to metrics where higher values indicate problems, such as packet loss or latency). Values above this threshold trigger performance degradation alerts.',
    `traffic_direction` STRING COMMENT 'The direction of network traffic for this performance measurement. Uplink (user to network), Downlink (network to user), or Bidirectional (combined).. Valid values are `Uplink|Downlink|Bidirectional`',
    `unit_of_measure` STRING COMMENT 'The unit in which the KPI value is expressed. Examples: dBm (for RSRP), dB (for SINR), Mbps (for throughput), percent (for success rates), ms (for latency/jitter), count (for session attempts).',
    `vendor_name` STRING COMMENT 'The manufacturer of the network element that generated this performance measurement. Critical for vendor-specific performance analysis and multi-vendor network optimization.. Valid values are `Nokia|Ericsson|Huawei|Cisco|Juniper|Other`',
    CONSTRAINT pk_performance_counter PRIMARY KEY(`performance_counter_id`)
) COMMENT 'Stores periodic network performance measurement records (PM counters) collected from network elements via Nokia NetAct Performance Management and Ericsson Network Manager — the operational performance data record. Captures measurement interval (15-min/1-hour/24-hour), KPI category (RAN: RSRP, SINR, throughput, handover success rate; Transport: packet loss, latency, jitter; Core: session establishment rate, drop rate), raw counter values, derived KPI values, threshold breach flags, and collection timestamp. Distinct from alarm/fault events — this is periodic measurement data.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`alarm` (
    `alarm_id` BIGINT COMMENT 'Primary key for alarm',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Network alarms affecting specific enterprise customer accounts drive proactive notifications, SLA credit calculations, escalation workflows. Real process: customer-impacting incident management for de',
    `enterprise_site_id` BIGINT COMMENT 'Foreign key linking to enterprise.site. Business justification: Alarms affecting enterprise sites drive customer impact assessment and notification. Business process: enterprise customer notification, site-level fault correlation, and proactive outage communicatio',
    `element_id` BIGINT COMMENT 'Foreign key reference to the network element (RAN node, OLT, BNG, BRAS, router, switch, etc.) that raised the alarm or is affected by the fault condition.',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: Network alarms require technician assignment for investigation and resolution in NOC/field operations. Critical for alarm lifecycle management, SLA tracking, and workforce utilization reporting in tel',
    `lawful_intercept_order_id` BIGINT COMMENT 'Foreign key linking to compliance.lawful_intercept_order. Business justification: Alarms on network elements provisioned for lawful intercept must be tracked for chain-of-custody and audit requirements. Law enforcement agencies require notification of service disruptions affecting ',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Alarms correlated to managed service instances for SLA breach detection. Business process: managed service fault management, SLA impact assessment, and automated ticket creation for enterprise service',
    `pop_facility_id` BIGINT COMMENT 'Foreign key linking to inventory.pop_facility. Business justification: Alarms require facility context for dispatch routing, environmental correlation (power/HVAC failures), multi-vendor incident management, and site-level alarm storm detection in NOC operations.',
    `svc_instance_id` BIGINT COMMENT 'Foreign key reference to the service instance impacted by this alarm. Used to correlate network faults with customer-facing service degradation and SLA breach detection.',
    `trouble_ticket_id` BIGINT COMMENT 'Foreign key reference to the trouble ticket or incident record created in the fault management or ITSM system (e.g., ServiceNow) to track the investigation and resolution of this alarm.',
    `acknowledged_by` STRING COMMENT 'The username or identifier of the NOC operator or engineer who acknowledged the alarm. Used for accountability and audit trail.',
    `acknowledged_timestamp` TIMESTAMP COMMENT 'The date and time when the alarm was acknowledged by NOC staff. Used to measure response time from alarm raise to acknowledgement.',
    `acknowledgement_status` STRING COMMENT 'Indicates whether the alarm has been acknowledged by NOC operations staff. Acknowledged alarms are under active investigation or remediation.. Valid values are `acknowledged|unacknowledged`',
    `additional_text` STRING COMMENT 'Free-form additional information or context provided by the network element or management system. May include diagnostic data, threshold values, or operational notes.',
    `affected_network_element_type` STRING COMMENT 'Type or category of the affected network element (e.g., eNodeB, OLT, BNG, MPLS router, optical switch, DSLAM). Used for alarm categorization and routing to specialized support teams.',
    `alarm_count` STRING COMMENT 'The number of times this specific alarm condition has been raised (for recurring alarms). A count greater than 1 indicates a flapping or intermittent fault condition.',
    `alarm_description` STRING COMMENT 'Detailed textual description of the alarm condition, including context, affected components, and potential impact. Sourced from the network element or enriched by the NMS.',
    `alarm_status` STRING COMMENT 'Current lifecycle status of the alarm indicating whether it is active, has been acknowledged by NOC staff, cleared by the network element, or administratively closed.. Valid values are `active|acknowledged|cleared|closed`',
    `alarm_type` STRING COMMENT 'Classification of the alarm indicating the nature of the fault or condition that triggered the alarm.. Valid values are `equipment_fault|link_down|threshold_exceeded|software_fault|configuration_error|environmental`',
    `clear_timestamp` TIMESTAMP COMMENT 'The date and time when the alarm condition was resolved and the alarm was cleared by the network element or management system. Null if the alarm is still active.',
    `correlation_key` STRING COMMENT 'Identifier used to group related alarms that stem from the same root cause. Alarm correlation reduces alarm noise and helps NOC staff focus on the primary fault.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this alarm record was first created in the lakehouse. Used for data lineage and audit trail.',
    `customer_impact_count` STRING COMMENT 'The estimated or actual number of customer subscribers or accounts impacted by this alarm. Used for prioritization and customer communication.',
    `duration_minutes` DECIMAL(18,2) COMMENT 'The total duration in minutes from alarm raise to alarm clear. Used for MTTR (Mean Time to Repair) and SLA breach analysis. Null if the alarm is still active.',
    `escalation_level` STRING COMMENT 'The current escalation level of the alarm within the NOC support hierarchy. Indicates whether the alarm has been escalated to higher-tier support or vendor technical assistance.. Valid values are `level_1|level_2|level_3|vendor_escalation`',
    `event_type` STRING COMMENT 'High-level categorization of the alarm event type as defined by ITU-T X.733 standards. Used for alarm classification and reporting.. Valid values are `communications_alarm|quality_of_service_alarm|processing_error_alarm|equipment_alarm|environmental_alarm`',
    `geographic_location` STRING COMMENT 'The geographic location or site identifier of the affected network element. Used for dispatch routing and regional impact analysis.',
    `identifier` STRING COMMENT 'Business identifier for the alarm as generated by the source network management system or network element. May be used for correlation and external reference.',
    `last_occurrence_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent occurrence of this alarm condition. Used for tracking recurring or flapping alarms.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this alarm record was last modified in the lakehouse. Used for change tracking and audit trail.',
    `managed_object_class` STRING COMMENT 'The class or type of the managed object (network element, interface, card, port) that raised the alarm. Used for alarm filtering and routing.',
    `managed_object_instance` STRING COMMENT 'The specific instance identifier of the managed object that raised the alarm. Typically a distinguished name (DN) or object identifier (OID) from the network management system.',
    `network_domain` STRING COMMENT 'The high-level network domain or layer where the alarm originated (e.g., RAN, transport, core, access, edge, backhaul). Used for alarm routing to specialized NOC teams.. Valid values are `ran|transport|core|access|edge|backhaul`',
    `notification_identifier` STRING COMMENT 'Unique identifier for the alarm notification message as assigned by the originating system. Used for message tracking and deduplication.',
    `probable_cause` STRING COMMENT 'The probable cause of the alarm as reported by the network element or inferred by the management system. Examples include hardware failure, link failure, threshold breach, configuration error.',
    `raise_timestamp` TIMESTAMP COMMENT 'The date and time when the alarm condition was first detected and raised by the network element or management system. Used as the start point for alarm duration and MTTR calculations.',
    `resolution_code` STRING COMMENT 'The code or category describing how the alarm was resolved (e.g., auto-cleared, manual intervention, equipment replacement, configuration change). Populated when the alarm is cleared or closed.',
    `resolution_notes` STRING COMMENT 'Free-form notes entered by NOC staff or engineers describing the actions taken to resolve the alarm and any lessons learned. Used for knowledge management and future troubleshooting.',
    `root_cause_alarm_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this alarm has been identified as the root cause alarm in a correlated alarm set. True if this is the root cause; false if it is a secondary or consequential alarm.',
    `service_impact_level` STRING COMMENT 'Assessment of the impact this alarm has on customer-facing services. Service down indicates complete outage; service degraded indicates reduced quality or capacity; no service impact indicates infrastructure redundancy absorbed the fault.. Valid values are `service_down|service_degraded|no_service_impact|potential_impact`',
    `severity` STRING COMMENT 'Severity level of the alarm indicating the urgency and impact of the fault. Critical and major alarms typically require immediate attention and may trigger SLA breach monitoring.. Valid values are `critical|major|minor|warning|indeterminate|cleared`',
    `sla_breach_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this alarm has caused or contributed to a breach of service level agreement commitments. True if SLA breach detected; false otherwise.',
    `sla_breach_type` STRING COMMENT 'The type of SLA breach associated with this alarm (e.g., availability breach, MTTR breach, performance degradation). Null if no SLA breach occurred.',
    `source_interface` STRING COMMENT 'The specific interface, protocol, or API through which the alarm was received (e.g., SNMP v2c, SNMP v3, Netconf, REST API, proprietary northbound interface).',
    `source_system` STRING COMMENT 'The network management system, element management system, or monitoring platform that originated or forwarded this alarm (e.g., Nokia NetAct, Ericsson Network Manager, SNMP trap receiver). [ENUM-REF-CANDIDATE: nokia_netact|ericsson_network_manager|nms|ems|snmp_trap|syslog|proprietary_agent — 7 candidates stripped; promote to reference product]',
    `specific_problem` STRING COMMENT 'Additional detail or vendor-specific code describing the specific problem or fault condition. Used for detailed diagnostics and vendor escalation.',
    `vendor_name` STRING COMMENT 'The name of the equipment vendor or manufacturer of the affected network element (e.g., Nokia, Ericsson, Huawei, Cisco). Used for vendor-specific escalation and support.',
    CONSTRAINT pk_alarm PRIMARY KEY(`alarm_id`)
) COMMENT 'Transactional record of network alarms raised by network elements — the fault management alarm record sourced from Nokia NetAct Fault Management and Ericsson Network Manager. Captures alarm ID, alarm type (equipment fault, link down, threshold exceeded, software fault), severity (critical/major/minor/warning), affected network element, affected service impact, alarm source (NMS/EMS/SNMP trap), raise timestamp, clear timestamp, alarm duration, acknowledgement status, and correlation to trouble ticket. Feeds NOC operations and SLA breach detection.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`planned_outage` (
    `planned_outage_id` BIGINT COMMENT 'Unique identifier for the planned maintenance outage record. Primary key for the planned outage entity.',
    `enterprise_site_id` BIGINT COMMENT 'Foreign key linking to enterprise.site. Business justification: Planned outages affecting enterprise sites require customer notification per contract. Business process: enterprise maintenance notification, site-level outage scheduling, and SLA exclusion window coo',
    `change_record_id` BIGINT COMMENT 'Reference to the associated change request or change ticket in the ITSM system (e.g., ServiceNow) that authorized this planned outage.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Planned maintenance activities incur labor and vendor costs allocated to responsible cost centers. Required for maintenance cost tracking, budget variance analysis, and operational expense management.',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: Planned outages require lead technician assignment for execution oversight beyond general employee_id. Field operations need to identify skilled technician responsible for outage execution, rollback d',
    `maintenance_window_id` BIGINT COMMENT 'Foreign key linking to network.maintenance_window. Business justification: A planned outage is scheduled within a maintenance window; adding planned_outage.maintenance_window_id links the two and removes the maintenance_window silo.',
    `pop_facility_id` BIGINT COMMENT 'Foreign key linking to inventory.pop_facility. Business justification: Planned maintenance is facility-scoped. Logistics coordination, access control, multi-system outage windows, and facility-level change calendars require linking outages to physical sites.',
    `employee_id` BIGINT COMMENT 'Identifier of the lead engineer or technician accountable for the planned outage execution and outcome.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Planned outages affecting critical services (E911, emergency communications, public safety networks) require regulatory notification and filing with authorities. Telecommunications operators must docu',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Planned outages must be tracked by service territory for customer notification campaigns, regulatory reporting by jurisdiction, SLA exclusion management, and territory-based impact assessment. Core to',
    `tertiary_planned_last_updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or system account that last modified the planned outage record, used for audit trail and change tracking.',
    `actual_duration_minutes` STRING COMMENT 'Actual duration of the planned outage in minutes, calculated from actual start to actual end, used for performance analysis.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the planned outage work was completed and services restored, used for variance analysis and SLA tracking.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the planned outage work commenced, used for variance analysis and SLA tracking.',
    `affected_customer_count` STRING COMMENT 'Estimated number of customers who will experience service impact during the planned outage, used for impact assessment and communication planning.',
    `affected_service_ids` STRING COMMENT 'Comma-separated list of service identifiers that will experience degradation or interruption during the planned outage window.',
    `backup_verification_status` STRING COMMENT 'Status of pre-outage configuration and data backup verification: verified (backups confirmed), not_verified (pending), not_required (no backup needed), failed (backup verification unsuccessful).. Valid values are `verified|not_verified|not_required|failed`',
    `cab_approval_status` STRING COMMENT 'Status of Change Advisory Board review and approval for the planned outage: pending (awaiting review), approved (authorized to proceed), rejected (denied), not_required (low-risk standard change).. Valid values are `pending|approved|rejected|not_required`',
    `cab_approval_timestamp` TIMESTAMP COMMENT 'Date and time when the Change Advisory Board approved the planned outage, establishing authorization to proceed.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the planned outage record was first created in the system, in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `customer_notification_status` STRING COMMENT 'Status of customer communication regarding the planned outage: not_sent (pending), scheduled (queued for delivery), sent (delivered), acknowledged (customer confirmed receipt), not_required (no customer impact).. Valid values are `not_sent|scheduled|sent|acknowledged|not_required`',
    `customer_notification_timestamp` TIMESTAMP COMMENT 'Date and time when customer notification about the planned outage was sent, used for compliance with SLA notification requirements.',
    `impact_severity` STRING COMMENT 'Business impact classification of the planned outage based on customer count, service criticality, and revenue exposure: critical (major service disruption), high (significant impact), medium (moderate impact), low (minor impact), minimal (negligible impact).. Valid values are `critical|high|medium|low|minimal`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the planned outage record was most recently modified, in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `maintenance_window_type` STRING COMMENT 'Classification of the maintenance window: standard (regular scheduled window), emergency (urgent unplanned but scheduled), extended (longer than standard duration), recurring (repeating pattern).. Valid values are `standard|emergency|extended|recurring`',
    `nms_system_name` STRING COMMENT 'Name of the Network Management System (Nokia NetAct, Ericsson Network Manager, or other NMS/EMS platform) used to coordinate and monitor the planned outage.',
    `notification_channel` STRING COMMENT 'Communication channel used to notify customers about the planned outage: email, SMS, customer portal, IVR (interactive voice response), push notification, or none if no notification required.. Valid values are `email|sms|portal|ivr|push_notification|none`',
    `outage_name` STRING COMMENT 'Descriptive name or title of the planned outage for identification and reporting purposes.',
    `outage_outcome` STRING COMMENT 'Final result of the planned outage execution: successful (all objectives met), partially_successful (some objectives met), failed (objectives not achieved), rolled_back (changes reverted), cancelled (aborted before execution).. Valid values are `successful|partially_successful|failed|rolled_back|cancelled`',
    `outage_outcome_notes` STRING COMMENT 'Detailed notes documenting the planned outage execution results, issues encountered, lessons learned, and post-implementation observations.',
    `outage_reason` STRING COMMENT 'Detailed business justification and technical rationale for the planned outage, including objectives and expected outcomes.',
    `outage_reference_number` STRING COMMENT 'Business-facing unique reference number for the planned outage, used for NOC coordination and customer communication.. Valid values are `^PO-[0-9]{8}$`',
    `outage_status` STRING COMMENT 'Current lifecycle state of the planned outage: draft (initial planning), scheduled (time allocated), approved (CAB approved), in_progress (work underway), completed (successfully finished), cancelled (aborted before start), rolled_back (reverted due to issues). [ENUM-REF-CANDIDATE: draft|scheduled|approved|in_progress|completed|cancelled|rolled_back — 7 candidates stripped; promote to reference product]',
    `outage_type` STRING COMMENT 'Classification of the planned outage activity: maintenance (routine upkeep), upgrade (software/hardware enhancement), decommission (element retirement), migration (platform/technology transition), testing (validation/acceptance), or emergency_planned (urgent but scheduled intervention).. Valid values are `maintenance|upgrade|decommission|migration|testing|emergency_planned`',
    `planned_duration_minutes` STRING COMMENT 'Expected duration of the planned outage maintenance window in minutes, calculated from planned start to planned end.',
    `planned_end_timestamp` TIMESTAMP COMMENT 'Scheduled date and time when the planned outage maintenance window is expected to conclude, in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `planned_start_timestamp` TIMESTAMP COMMENT 'Scheduled date and time when the planned outage maintenance window is expected to begin, in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `post_outage_validation_status` STRING COMMENT 'Status of post-outage testing and validation to confirm services are restored and functioning correctly: passed (validation successful), failed (issues detected), in_progress (testing underway), not_started (pending).. Valid values are `passed|failed|in_progress|not_started`',
    `recurrence_pattern` STRING COMMENT 'Description of the recurrence schedule for recurring planned outages (e.g., weekly, monthly, quarterly), null for one-time outages.',
    `responsible_team` STRING COMMENT 'Name of the NOC, engineering, or operations team responsible for executing the planned outage maintenance work.',
    `risk_assessment_level` STRING COMMENT 'Pre-outage risk assessment classification based on complexity, customer impact, and technical risk: low (routine), medium (moderate risk), high (significant risk), critical (high-risk requiring executive approval).. Valid values are `low|medium|high|critical`',
    `rollback_executed_flag` BOOLEAN COMMENT 'Boolean indicator whether the rollback plan was executed during this planned outage (True = rollback performed, False = no rollback needed).',
    `rollback_plan_reference` STRING COMMENT 'Reference identifier or document location for the rollback procedure to be executed if the planned outage encounters critical issues requiring service restoration to previous state.',
    `sla_exclusion_flag` BOOLEAN COMMENT 'Boolean indicator whether this planned outage window is excluded from SLA availability calculations (True = excluded from SLA, False = counted against SLA).',
    `sla_notification_lead_time_hours` STRING COMMENT 'Number of hours advance notice provided to customers before the planned outage, used to verify compliance with SLA notification requirements.',
    `vendor_engineer_name` STRING COMMENT 'Name of the vendor engineer or technician supporting the planned outage execution, if vendor support is required.',
    `vendor_name` STRING COMMENT 'Name of the equipment or software vendor whose products are being maintained, upgraded, or modified during the planned outage.',
    CONSTRAINT pk_planned_outage PRIMARY KEY(`planned_outage_id`)
) COMMENT 'Transactional record of planned maintenance windows and scheduled outages — the maintenance scheduling record for NOC coordination. Captures outage reference, type (maintenance/upgrade/decommission/migration/testing), affected elements and services, planned and actual start/end datetimes, outage reason, responsible team, customer notification status, SLA exclusion flag, rollback plan reference, and outcome. Supports NOC scheduling, SLA exclusion window management, change advisory board (CAB) approvals, and customer impact communication.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` (
    `network_capacity_plan_id` BIGINT COMMENT 'Unique identifier for the network capacity plan record. Primary key.',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to finance.budget_plan. Business justification: Capacity plans drive annual budget planning for network expansion and upgrades. Links technical capacity forecasts to financial budget allocation, enabling budget-to-actual variance analysis and capit',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to finance.capital_project. Business justification: Capacity plans translate into capital projects for network build-out. Links capacity forecasting to project initiation, enabling tracking from capacity gap identification through project execution and',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Capacity planning forecasts demand by catalog item to size network resources. Product launch plans, subscriber growth projections, and technology migrations (4G to 5G) require capacity plans linked to',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Capacity planning driven by specific enterprise account growth forecasts and contracted commitments. Business process: strategic network planning, account-driven capacity expansion, and capex justific',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Capacity plans require assigned network planners for demand analysis, forecasting, and recommendation development. Business process: capacity planning workload distribution and accountability tracking',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Capacity planning is fundamentally geography-driven, targeting specific territories for network expansion. Critical for capex budget allocation, rollout prioritization, franchise obligation compliance',
    `spectrum_license_id` BIGINT COMMENT 'Foreign key linking to compliance.spectrum_license. Business justification: Capacity expansion plans must account for spectrum license constraints, coverage obligations, and utilization requirements. Telecommunications operators plan network growth within licensed spectrum bo',
    `workforce_capacity_plan_id` BIGINT COMMENT 'Foreign key linking to workforce.workforce_capacity_plan. Business justification: Network capacity expansion plans drive workforce capacity planning for installation, commissioning, and maintenance. Strategic planning process requires linking network buildout plans to hiring/traini',
    `action_description` STRING COMMENT 'Detailed narrative description of the recommended capacity augmentation action, including technical approach, scope, and expected outcomes.',
    `actual_completion_date` DATE COMMENT 'Actual date on which the capacity plan implementation was completed and capacity was brought into service, in yyyy-MM-dd format. Null if not yet completed.',
    `actual_start_date` DATE COMMENT 'Actual date on which implementation activities commenced, in yyyy-MM-dd format. Null if not yet started.',
    `approval_date` DATE COMMENT 'Date on which the capacity plan was formally approved for implementation, in yyyy-MM-dd format.',
    `approval_status` STRING COMMENT 'Current approval workflow status of the capacity plan: draft (in preparation), submitted (awaiting review), under_review (being evaluated), approved (authorized for implementation), rejected (not approved), on_hold (paused), cancelled (withdrawn). [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|on_hold|cancelled — 7 candidates stripped; promote to reference product]',
    `approved_by` STRING COMMENT 'Name or identifier of the executive or authority who approved the capacity plan (e.g., VP Network Engineering, CFO, Capacity Planning Board).',
    `business_justification` STRING COMMENT 'Business case and strategic rationale for the capacity plan, including expected benefits such as revenue growth, churn reduction, QoS improvement, or competitive positioning.',
    `capacity_gap` DECIMAL(18,2) COMMENT 'Calculated or assessed capacity shortfall (projected_demand minus current_capacity_baseline), indicating the magnitude of capacity augmentation required.',
    `capacity_unit` STRING COMMENT 'Unit of measure for capacity metrics (e.g., Gbps, Mbps, Erlang, subscribers, sites, ports, wavelengths, MHz spectrum, cells). [ENUM-REF-CANDIDATE: gbps|mbps|erlang|subscribers|sites|ports|wavelengths|mhz|cells — 9 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the capacity plan record was first created in the system, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this plan (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `current_capacity_baseline` DECIMAL(18,2) COMMENT 'Current capacity baseline measurement for the target network domain, expressed in the unit specified by capacity_unit (e.g., Gbps, Erlang, number of subscribers, number of sites).',
    `estimated_capex` DECIMAL(18,2) COMMENT 'Estimated capital expenditure required to implement the capacity plan, in the currency specified by currency_code.',
    `estimated_opex_annual` DECIMAL(18,2) COMMENT 'Estimated incremental annual operational expenditure resulting from the capacity augmentation (e.g., maintenance, power, lease costs).',
    `fiber_route_km` DECIMAL(18,2) COMMENT 'Total length of new fiber route to be deployed (in kilometers) as part of the capacity plan. Applicable for FTTH, transport, and backhaul expansion plans.',
    `geographic_scope` STRING COMMENT 'Geographic area or region covered by the capacity plan (e.g., Northeast Region, Metro Area 5, National Backbone, specific market or cluster identifier).',
    `implementation_status` STRING COMMENT 'Current implementation status of the capacity plan: not_started (approved but not begun), in_progress (actively being implemented), completed (fully deployed), delayed (behind schedule), cancelled (implementation halted).. Valid values are `not_started|in_progress|completed|delayed|cancelled`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the capacity plan record was last modified, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `network_technology` STRING COMMENT 'Specific network technology or infrastructure type addressed by the plan (e.g., 5G NR, LTE, FTTH, GPON, MPLS, SD-WAN, DSLAM, BNG, BRAS, OLT, ONT). [ENUM-REF-CANDIDATE: 2g|3g|4g_lte|5g_nr|ftth|gpon|dslam|mpls|sd_wan|bng|bras|olt|ont — 13 candidates stripped; promote to reference product]',
    `nms_system` STRING COMMENT 'Network Management System or Element Management System used to monitor and manage the capacity being planned (e.g., Nokia NetAct, Ericsson Network Manager, Netcracker NMS).',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or observations related to the capacity plan.',
    `number_of_sites` STRING COMMENT 'Number of new cell sites, POPs, or network nodes to be deployed as part of the capacity plan. Applicable for site expansion plans.',
    `percent_complete` DECIMAL(18,2) COMMENT 'Percentage completion of the capacity plan implementation, ranging from 0.00 to 100.00.',
    `plan_code` STRING COMMENT 'Unique business identifier or reference code for the capacity plan, used for tracking and reporting (e.g., CAP-2024-RAN-037).',
    `plan_name` STRING COMMENT 'Business-friendly name or title of the capacity planning initiative (e.g., Q3 2024 RAN Expansion - Metro Region, 5G Core Capacity Augmentation Phase 2).',
    `planned_completion_date` DATE COMMENT 'Target completion date for the capacity plan implementation, in yyyy-MM-dd format.',
    `planned_start_date` DATE COMMENT 'Planned or scheduled start date for implementation of the capacity augmentation activities, in yyyy-MM-dd format.',
    `planning_horizon` STRING COMMENT 'Time horizon for the capacity planning activity: short_term (0-12 months), medium_term (1-3 years), long_term (3+ years).. Valid values are `short_term|medium_term|long_term`',
    `priority` STRING COMMENT 'Business priority level assigned to the capacity plan: critical (immediate action required), high (near-term priority), medium (planned), low (deferred or optional).. Valid values are `critical|high|medium|low`',
    `projected_demand` DECIMAL(18,2) COMMENT 'Forecasted demand or capacity requirement at the end of the planning horizon, expressed in the same unit as current_capacity_baseline.',
    `recommended_action` STRING COMMENT 'Primary recommended action to address the capacity gap: new_site (build new cell site or POP), spectrum_addition (acquire or refarm spectrum), equipment_upgrade (add cards/modules), fiber_deployment (extend FTTH/transport), capacity_swap (technology migration), decommission (retire legacy), optimization (software/configuration tuning). [ENUM-REF-CANDIDATE: new_site|spectrum_addition|equipment_upgrade|fiber_deployment|capacity_swap|decommission|optimization — 7 candidates stripped; promote to reference product]',
    `risk_description` STRING COMMENT 'Description of key risks, dependencies, or constraints associated with the capacity plan (e.g., site acquisition delays, vendor supply chain issues, regulatory approval dependencies).',
    `risk_level` STRING COMMENT 'Assessed risk level associated with the capacity plan execution: low (minimal risk), medium (manageable risk), high (significant risk requiring mitigation), critical (major risk to delivery).. Valid values are `low|medium|high|critical`',
    `roi_months` STRING COMMENT 'Expected return on investment period in months, representing the time to recover the CAPEX investment through incremental revenue or cost savings.',
    `sla_target_availability_percent` DECIMAL(18,2) COMMENT 'Target network availability percentage (e.g., 99.95%) that the augmented capacity is designed to support, per SLA commitments.',
    `spectrum_band` STRING COMMENT 'Spectrum frequency band targeted for capacity augmentation or refarming (e.g., 700 MHz, 2.6 GHz, 3.5 GHz C-Band, mmWave 28 GHz). Applicable for RAN capacity plans.',
    `spectrum_bandwidth_mhz` DECIMAL(18,2) COMMENT 'Amount of spectrum bandwidth (in MHz) to be added or refarmed as part of the capacity plan. Applicable for RAN capacity plans.',
    `target_network_domain` STRING COMMENT 'The network domain or layer targeted by this capacity plan: RAN (Radio Access Network), transport (MPLS/SD-WAN), core (EPC/5GC), access (FTTH/GPON/DSLAM), edge (MEC), backhaul.. Valid values are `ran|transport|core|access|edge|backhaul`',
    `target_subscriber_capacity` BIGINT COMMENT 'Target number of subscribers or connections that the augmented capacity will support. Applicable for access and core network capacity plans.',
    `updated_by` STRING COMMENT 'Identifier of the user or system that last updated the capacity plan record.',
    `vendor_name` STRING COMMENT 'Primary vendor or equipment manufacturer involved in the capacity augmentation (e.g., Nokia, Ericsson, Huawei, Cisco, Ciena).',
    CONSTRAINT pk_network_capacity_plan PRIMARY KEY(`network_capacity_plan_id`)
) COMMENT 'Transactional record of network capacity planning activities — formal capacity augmentation plans, upgrade projects, and spectrum refarming initiatives. Captures plan name, planning horizon (short/medium/long term), target network domain (RAN/transport/core/access), current capacity baseline, projected demand, capacity gap, recommended action (new site/spectrum addition/equipment upgrade/fiber deployment), estimated CAPEX, priority, approval status, and planned implementation date. Supports CAPEX planning and network investment decisions.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`sdwan_policy` (
    `sdwan_policy_id` BIGINT COMMENT 'Unique identifier for the SD-WAN policy configuration record. Primary key for the SD-WAN policy entity.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: SD-WAN policies enforce product-specific QoS and routing rules. Enterprise product catalog items (managed WAN, cloud connect) define SLA requirements that drive policy configuration. Policy templates ',
    `corporate_account_id` BIGINT COMMENT 'Reference to the enterprise customer account that owns this SD-WAN policy configuration, enabling customer-specific policy management and billing.',
    `enterprise_site_id` BIGINT COMMENT 'Foreign key linking to enterprise.site. Business justification: SD-WAN policies apply at site-level granularity for traffic steering and path selection. Business process: per-site SD-WAN configuration management, application routing, and site-specific policy enfor',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: SD-WAN policies map to specific managed service instances for configuration control. Business process: managed SD-WAN service provisioning, policy lifecycle management, and service-specific traffic en',
    `network_qos_profile_id` BIGINT COMMENT 'Foreign key linking to network.qos_profile. Business justification: SD-WAN policies reference QoS profiles to define traffic treatment. Currently qos_class is stored as STRING, creating redundancy and inconsistency risk. Normalizing to qos_profile enables centralized ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: SD-WAN policies require network engineers for creation, modification, and troubleshooting. Business process: policy changes require engineer approval, implementation tracking, and issue resolution ass',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to customer.subscriber. Business justification: SD-WAN policies applied per subscriber for enterprise mobility, IoT devices. Real process: per-subscriber traffic steering, application-aware QoS, mobile workforce connectivity. Already has corporate_',
    `svc_instance_id` BIGINT COMMENT 'Reference to the SD-WAN managed service instance to which this policy is applied, linking policy configuration to service delivery.',
    `activated_timestamp` TIMESTAMP COMMENT 'Timestamp when this SD-WAN policy was activated and deployed to production network elements, marking the transition from draft to operational state.',
    `application_classification_rules` STRING COMMENT 'Encoded rules defining how network traffic is classified by application type, protocol, port, or Deep Packet Inspection (DPI) signatures to enable application-aware routing decisions.',
    `bandwidth_allocation_mbps` STRING COMMENT 'Dedicated or guaranteed bandwidth allocation in megabits per second reserved for traffic matching this policy to ensure consistent performance.',
    `compliance_framework` STRING COMMENT 'Regulatory or industry compliance framework that this policy supports or enforces, such as PCI-DSS for payment data, HIPAA for healthcare, or GDPR for data privacy.',
    `created_by_user` STRING COMMENT 'Identifier of the network administrator or system user who created this SD-WAN policy configuration, supporting accountability and audit requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SD-WAN policy record was first created in the network management system.',
    `customer_vpn_reference` BIGINT COMMENT 'Reference to the enterprise customer VPN overlay to which this SD-WAN policy is associated, enabling multi-tenant policy isolation.',
    `deactivated_timestamp` TIMESTAMP COMMENT 'Timestamp when this SD-WAN policy was deactivated or removed from production, supporting lifecycle management and compliance audit trails.',
    `destination_network_segment` STRING COMMENT 'Destination network segment, subnet, or VLAN identifier to which this policy applies, enabling granular traffic control based on target.',
    `dscp_marking` STRING COMMENT 'DSCP value applied to packet headers for QoS enforcement across the network, enabling routers and switches to prioritize traffic according to policy requirements.',
    `effective_end_date` DATE COMMENT 'Date when this SD-WAN policy expires or is scheduled for deactivation. Null indicates an open-ended policy with no planned expiration.',
    `effective_start_date` DATE COMMENT 'Date when this SD-WAN policy becomes active and begins governing traffic routing decisions.',
    `encryption_algorithm` STRING COMMENT 'Encryption algorithm applied to traffic matching this policy when encryption is required: AES-256, AES-128, IPsec, TLS 1.3, or none.. Valid values are `aes_256|aes_128|ipsec|tls_1_3|none`',
    `encryption_required` BOOLEAN COMMENT 'Indicates whether traffic matching this policy must be encrypted, enforcing security requirements for sensitive data transmission over SD-WAN overlays.',
    `failover_revert_delay_seconds` STRING COMMENT 'Time delay in seconds before reverting traffic back to the primary path after the primary path recovers from a failure, preventing flapping during intermittent issues.',
    `failover_trigger_condition` STRING COMMENT 'Conditions that automatically trigger failover to backup path, such as link down, SLA threshold breach, or manual override. May include complex boolean logic combining multiple metrics.',
    `firewall_policy_reference` BIGINT COMMENT 'Reference to the associated firewall policy applied in conjunction with this SD-WAN policy for integrated security enforcement.',
    `geo_location_filter` STRING COMMENT 'Geographic location or region filter defining where this policy applies, enabling location-aware routing for distributed enterprise networks.',
    `last_modified_by_user` STRING COMMENT 'Identifier of the network administrator or system user who last modified this SD-WAN policy configuration, supporting change management and audit trails.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this SD-WAN policy configuration, supporting change tracking and audit requirements.',
    `load_balancing_algorithm` STRING COMMENT 'Algorithm used for distributing traffic across multiple paths when load balancing is enabled: round-robin, weighted distribution, least latency, least packet loss, or session-based persistence.. Valid values are `round_robin|weighted|least_latency|least_packet_loss|session_based`',
    `nms_object_reference` STRING COMMENT 'Unique object identifier or reference key for this policy in the source Network Management System, enabling bidirectional synchronization and reconciliation.',
    `nms_system_source` STRING COMMENT 'Name or identifier of the Network Management System (NMS) or Element Management System (EMS) that is the authoritative source for this policy configuration, such as Nokia NetAct or Ericsson Network Manager.',
    `notes` STRING COMMENT 'Additional free-form notes, comments, or operational guidance related to this SD-WAN policy for use by network operations teams.',
    `path_preference` STRING COMMENT 'Preferred transport path selection strategy for traffic routing: MPLS primary (prioritize MPLS links), broadband primary (prioritize internet broadband), LTE primary (prioritize cellular), load balanced (distribute across paths), or dynamic (real-time selection based on conditions).. Valid values are `mpls_primary|broadband_primary|lte_primary|load_balanced|dynamic`',
    `policy_description` STRING COMMENT 'Detailed textual description of the SD-WAN policy purpose, business rationale, and configuration intent for documentation and knowledge management.',
    `policy_identifier` STRING COMMENT 'Externally-known unique code or reference number for the SD-WAN policy used in network management systems and customer communications.',
    `policy_name` STRING COMMENT 'Human-readable name assigned to the SD-WAN policy for identification and management purposes.',
    `policy_priority` STRING COMMENT 'Numeric priority ranking for policy evaluation order when multiple policies apply to the same traffic. Lower numbers indicate higher priority.',
    `policy_status` STRING COMMENT 'Current operational state of the SD-WAN policy in its lifecycle: active (in production use), inactive (configured but not applied), draft (under development), suspended (temporarily disabled), or deprecated (scheduled for removal).. Valid values are `active|inactive|draft|suspended|deprecated`',
    `policy_type` STRING COMMENT 'Classification of the SD-WAN policy based on its primary function: traffic steering for path selection, QoS for quality of service enforcement, security for threat protection, failover for redundancy management, hybrid for combined functions, or application-aware for intelligent routing.. Valid values are `traffic_steering|qos|security|failover|hybrid|application_aware`',
    `policy_version` STRING COMMENT 'Version number of this policy configuration, incremented with each modification to support version control and rollback capabilities.',
    `port_range_filter` STRING COMMENT 'TCP/UDP port or port range filter specification defining which application ports are subject to this policy, enabling port-based traffic classification.',
    `protocol_filter` STRING COMMENT 'Network protocol filter specification (TCP, UDP, ICMP, etc.) defining which protocols are subject to this policy, enabling protocol-specific routing decisions.',
    `sla_bandwidth_threshold_mbps` STRING COMMENT 'Minimum guaranteed bandwidth in megabits per second defined in the SLA for this policy to ensure adequate capacity for business-critical applications.',
    `sla_jitter_threshold_ms` STRING COMMENT 'Maximum acceptable network jitter (latency variation) in milliseconds defined in the SLA for this policy. Critical for real-time applications like VoIP and video conferencing.',
    `sla_latency_threshold_ms` STRING COMMENT 'Maximum acceptable network latency in milliseconds defined in the SLA for this policy. Exceeding this threshold may trigger failover or path re-selection.',
    `sla_packet_loss_threshold_percent` DECIMAL(18,2) COMMENT 'Maximum acceptable packet loss percentage defined in the SLA for this policy. Exceeding this threshold indicates degraded network quality requiring remediation.',
    `source_network_segment` STRING COMMENT 'Source network segment, subnet, or VLAN identifier to which this policy applies, enabling granular traffic control based on origin.',
    `time_based_activation` STRING COMMENT 'Time-based schedule defining when this policy is active, supporting business-hours routing, maintenance windows, or time-of-day traffic optimization.',
    `traffic_shaping_enabled` BOOLEAN COMMENT 'Indicates whether traffic shaping is enabled for this policy to smooth traffic bursts and enforce rate limits, preventing network congestion.',
    CONSTRAINT pk_sdwan_policy PRIMARY KEY(`sdwan_policy_id`)
) COMMENT 'Master record for SD-WAN traffic steering and policy configurations applied to enterprise customer SD-WAN overlays. Captures policy name, policy type (traffic steering/QoS/security/failover), application classification rules, path preference (MPLS/broadband/LTE), SLA thresholds (latency/jitter/packet loss), failover triggers, policy priority, associated customer VPN, and policy activation status. Supports enterprise SD-WAN managed service delivery and policy lifecycle management.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`network_qos_profile` (
    `network_qos_profile_id` BIGINT COMMENT 'Unique identifier for the QoS profile. Primary key for the QoS profile master reference.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: QoS profiles implement product-specific SLA commitments. Different catalog items (premium vs basic broadband, voice vs video) map to distinct QoS profiles for bandwidth guarantees, latency budgets, an',
    `applicable_network_domain` STRING COMMENT 'Network domain where this QoS profile is enforced. RAN for radio access network, Core for packet core (EPC/5GC), Transport for IP/MPLS backhaul, All for end-to-end enforcement.. Valid values are `ran|core|transport|all`',
    `applicable_technology` STRING COMMENT 'Network technology or service platform where this QoS profile is applicable. Supports LTE, 5G NR, VoLTE, IMS, MPLS, SD-WAN and other technology-specific QoS implementations.. Valid values are `lte|5g_nr|volte|ims|mpls|sd_wan`',
    `arp_priority_level` STRING COMMENT 'Allocation and Retention Priority level (1-15) used for admission control decisions. Lower values indicate higher priority for resource allocation and retention.',
    `averaging_window_ms` STRING COMMENT 'Time window in milliseconds over which bit rate guarantees and measurements are averaged for GBR bearers. Used for traffic policing and shaping calculations.',
    `burst_size_bytes` BIGINT COMMENT 'Maximum burst size in bytes allowed for traffic shaping token bucket algorithm. Defines how much traffic can exceed the sustained rate in short bursts.',
    `charging_impact` STRING COMMENT 'Indicates how this QoS profile impacts subscriber charging. Premium for higher-tier billing, Standard for normal rates, Zero-rated for excluded from data caps, Sponsored for third-party paid.. Valid values are `premium|standard|zero_rated|sponsored`',
    `configuration_template` STRING COMMENT 'Reference to the network configuration template or policy map used to implement this QoS profile across network elements (NMS/EMS template identifier).',
    `congestion_notification_enabled` BOOLEAN COMMENT 'Indicates whether Explicit Congestion Notification is enabled for this QoS profile to signal network congestion without dropping packets.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this QoS profile record was first created in the system.',
    `dscp_value` STRING COMMENT '6-bit DSCP marking value (0-63) used in IP packet headers for traffic classification and priority treatment in IP transport and MPLS networks.',
    `effective_end_date` DATE COMMENT 'Date when this QoS profile is no longer effective and should not be used for new service provisioning. Null for profiles with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this QoS profile becomes effective and available for use in network provisioning and service activation.',
    `five_qi_value` STRING COMMENT '5G QoS Identifier scalar value (1-85 standardized, 128-254 operator-specific) that defines QoS characteristics for 5G NR bearers including resource type, priority level, packet delay budget, and packet error rate.',
    `guaranteed_bit_rate_downlink_kbps` DECIMAL(18,2) COMMENT 'Minimum downlink bit rate in kbps that the network guarantees to provide for GBR bearers. Null for non-GBR profiles.',
    `guaranteed_bit_rate_uplink_kbps` DECIMAL(18,2) COMMENT 'Minimum uplink bit rate in kbps that the network guarantees to provide for GBR bearers. Null for non-GBR profiles.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this QoS profile record was last modified or updated.',
    `maximum_bit_rate_downlink_kbps` DECIMAL(18,2) COMMENT 'Maximum downlink bit rate in kbps that the bearer is allowed to utilize. Used for traffic shaping and policing to prevent bandwidth oversubscription.',
    `maximum_bit_rate_uplink_kbps` DECIMAL(18,2) COMMENT 'Maximum uplink bit rate in kbps that the bearer is allowed to utilize. Used for traffic shaping and policing to prevent bandwidth oversubscription.',
    `modified_by_user` STRING COMMENT 'User identifier or system account that last modified this QoS profile record for audit trail purposes.',
    `network_qos_profile_description` STRING COMMENT 'Detailed description of the QoS profile including its intended use cases, traffic characteristics, and configuration rationale.',
    `packet_delay_budget_ms` STRING COMMENT 'Maximum allowable one-way packet delay in milliseconds from UE to gateway for this QoS profile. Critical for real-time services like VoLTE and video conferencing.',
    `packet_error_rate` DECIMAL(18,2) COMMENT 'Maximum acceptable packet error rate expressed as a decimal fraction (e.g., 0.000001 for 10^-6). Defines the upper bound for packet loss tolerance for this QoS class.',
    `preemption_capability` STRING COMMENT 'Indicates whether this QoS profile can trigger preemption of lower-priority bearers during resource congestion to establish or maintain its own bearer.. Valid values are `may_preempt|shall_not_preempt`',
    `preemption_vulnerability` STRING COMMENT 'Indicates whether bearers using this QoS profile can be preempted by higher-priority bearers during resource congestion.. Valid values are `preemptable|not_preemptable`',
    `priority_level` STRING COMMENT 'Relative priority level for resource allocation and scheduling, with lower numeric values indicating higher priority. Range typically 1-15 where 1 is highest priority.',
    `profile_code` STRING COMMENT 'Unique business code or identifier for the QoS profile used in network configuration and provisioning systems.',
    `profile_name` STRING COMMENT 'Human-readable name of the QoS profile used for identification and configuration purposes across network management systems.',
    `profile_status` STRING COMMENT 'Current lifecycle status of the QoS profile. Active profiles are in production use, Inactive are disabled, Deprecated are scheduled for removal, Testing are under validation.. Valid values are `active|inactive|deprecated|testing`',
    `qci_value` STRING COMMENT 'QoS Class Identifier for LTE networks, a scalar value (1-9 standardized, 128-254 operator-specific) that defines bearer-level QoS characteristics including priority, packet delay budget, and packet error loss rate.',
    `qos_class` STRING COMMENT 'High-level traffic classification category that determines the service treatment and priority handling for the traffic type.. Valid values are `voice|video|data|best_effort|mission_critical|streaming`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this QoS profile is configured to meet specific regulatory requirements such as emergency services priority (E911, E112) or lawful intercept QoS preservation.',
    `resource_type` STRING COMMENT 'Indicates whether the QoS profile guarantees a specific bit rate. GBR (Guaranteed Bit Rate) for real-time services, Non-GBR for elastic traffic, Delay-Critical GBR for ultra-low latency services.. Valid values are `gbr|non_gbr|delay_critical_gbr`',
    `service_type` STRING COMMENT 'Type of service or application this QoS profile is designed to support (e.g., VoLTE, Video Streaming, IoT, Enterprise VPN, Gaming, Web Browsing).',
    `sla_tier` STRING COMMENT 'SLA tier associated with this QoS profile defining the service quality commitment level for enterprise and wholesale customers.. Valid values are `platinum|gold|silver|bronze|best_effort`',
    `traffic_shaping_enabled` BOOLEAN COMMENT 'Indicates whether traffic shaping is enabled for this QoS profile to smooth traffic bursts and enforce maximum bit rate limits.',
    `vendor_specific_parameters` STRING COMMENT 'JSON or key-value string containing vendor-specific QoS parameters for Nokia, Ericsson, or other equipment vendors that extend standard 3GPP QoS attributes.',
    CONSTRAINT pk_network_qos_profile PRIMARY KEY(`network_qos_profile_id`)
) COMMENT 'Reference master for Quality of Service (QoS) profiles and traffic class definitions applied across the network — DSCP markings, traffic shaping parameters, priority queuing configurations, and bearer QoS class identifiers (QCI/5QI for LTE/5G). Captures profile name, QoS class (voice/video/data/best-effort), DSCP value, 5QI/QCI value, guaranteed bit rate (GBR), maximum bit rate (MBR), priority level, packet delay budget, packet error rate, and applicable network domain. Used by RAN, core, and transport layers for consistent end-to-end QoS enforcement.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`peering_agreement` (
    `peering_agreement_id` BIGINT COMMENT 'Unique identifier for the network peering or transit agreement record. Primary key for the peering agreement entity.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Peering partners with paid peering arrangements or transit agreements have associated billing accounts for interconnect settlement, transit charges, and capacity-based peering fees. Essential for inte',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Large enterprise accounts (hyperscalers, content providers) may have dedicated peering arrangements. Business process: wholesale/hyperscale customer peering management, custom interconnection agreemen',
    `fiber_cable_id` BIGINT COMMENT 'Foreign key linking to inventory.fiber_cable. Business justification: Peering circuits run over specific fiber infrastructure. Cost allocation (owned vs leased fiber), route diversity analysis, physical path validation, and peering port provisioning require fiber cable ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Peering agreements require assigned engineers for technical negotiation, BGP session management, and ongoing coordination. Business process: peering session failures and traffic ratio violations escal',
    `partner_id` BIGINT COMMENT 'Reference to the partner or carrier entity in the partner domain representing the peering counterparty.',
    `pop_facility_id` BIGINT COMMENT 'Reference to the network site or POP facility where the peering connection is physically terminated.',
    `agreed_bandwidth_mbps` DECIMAL(18,2) COMMENT 'The committed or agreed bandwidth capacity for the peering interconnection, measured in megabits per second.',
    `agreement_end_date` DATE COMMENT 'The expiration or termination date of the peering agreement. Null for open-ended agreements.',
    `agreement_number` STRING COMMENT 'Business identifier or contract number for the peering agreement, used for external reference and tracking.',
    `agreement_start_date` DATE COMMENT 'The effective start date when the peering agreement becomes active and traffic exchange begins.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the peering agreement: draft (under negotiation), active (in force), suspended (temporarily inactive), expired (past end date), terminated (cancelled), or pending renewal.. Valid values are `draft|active|suspended|expired|terminated|pending_renewal`',
    `bgp_asn_local` BIGINT COMMENT 'The local Autonomous System Number used in the BGP peering session for this agreement.',
    `bgp_asn_remote` BIGINT COMMENT 'The remote peering partners Autonomous System Number used in the BGP peering session.',
    `bgp_session_state` STRING COMMENT 'Current operational state of the BGP peering session: idle, connect, active, opensent, openconfirm, or established (per BGP finite state machine).. Valid values are `idle|connect|active|opensent|openconfirm|established`',
    `commercial_terms_reference` STRING COMMENT 'Reference to the commercial contract document or terms governing pricing, service levels, and obligations for the peering arrangement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this peering agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for financial terms (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `ixp_name` STRING COMMENT 'Name of the Internet Exchange Point where public peering is established, if applicable. Null for private peering or transit arrangements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this peering agreement record was last updated or modified.',
    `last_session_down_timestamp` TIMESTAMP COMMENT 'Timestamp when the BGP peering session last transitioned out of the established state (went down).',
    `last_session_up_timestamp` TIMESTAMP COMMENT 'Timestamp when the BGP peering session last transitioned to the established state.',
    `max_prefix_limit_ipv4` STRING COMMENT 'Maximum number of IPv4 prefixes that can be advertised or accepted over the BGP peering session before the session is torn down.',
    `max_prefix_limit_ipv6` STRING COMMENT 'Maximum number of IPv6 prefixes that can be advertised or accepted over the BGP peering session before the session is torn down.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this peering agreement record.',
    `monthly_recurring_charge` DECIMAL(18,2) COMMENT 'Monthly recurring cost for paid peering or transit services, if applicable. Null for settlement-free peering.',
    `noc_contact_email` STRING COMMENT 'Email address of the peering partners NOC contact for operational communication and incident management.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `noc_contact_name` STRING COMMENT 'Name of the primary technical contact at the peering partners Network Operations Center for operational coordination and incident escalation.',
    `noc_contact_phone` STRING COMMENT 'Phone number of the peering partners NOC contact for urgent operational escalations and incident response.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special conditions, or operational remarks related to the peering agreement.',
    `peering_ipv4_address_local` STRING COMMENT 'The local IPv4 address assigned to the peering interface on the local side of the BGP session.',
    `peering_ipv4_address_remote` STRING COMMENT 'The remote IPv4 address assigned to the peering partners interface on the remote side of the BGP session.',
    `peering_ipv6_address_local` STRING COMMENT 'The local IPv6 address assigned to the peering interface on the local side of the BGP session, if IPv6 peering is enabled.',
    `peering_ipv6_address_remote` STRING COMMENT 'The remote IPv6 address assigned to the peering partners interface on the remote side of the BGP session, if IPv6 peering is enabled.',
    `peering_location` STRING COMMENT 'Physical location or Point of Presence (POP) site where the peering interconnection is established, including city and facility name.',
    `peering_type` STRING COMMENT 'Classification of the peering arrangement: public peering (via IXP), private peering (direct interconnect), transit (paid upstream), settlement-free, or paid peering.. Valid values are `public|private|transit|settlement_free|paid`',
    `route_filter_policy` STRING COMMENT 'Description of BGP route filtering policies applied to the peering session, including prefix limits and route acceptance criteria.',
    `session_uptime_hours` DECIMAL(18,2) COMMENT 'Total uptime of the current BGP session since the last establishment, measured in hours.',
    `sla_availability_percent` DECIMAL(18,2) COMMENT 'Contractual uptime availability target for the peering interconnection, expressed as a percentage (e.g., 99.95%).',
    `sla_latency_ms` DECIMAL(18,2) COMMENT 'Maximum acceptable round-trip latency for the peering connection, measured in milliseconds, as specified in the SLA.',
    `sla_packet_loss_percent` DECIMAL(18,2) COMMENT 'Maximum acceptable packet loss rate for the peering connection, expressed as a percentage, as specified in the SLA.',
    `traffic_exchange_policy` STRING COMMENT 'Commercial policy governing traffic exchange: settlement-free (no charges), paid transit (upstream provider), paid peering (per-Mbps charges), balanced (equal traffic), or unbalanced (asymmetric traffic).. Valid values are `settlement_free|paid_transit|paid_peering|balanced|unbalanced`',
    `traffic_ratio_policy` STRING COMMENT 'Policy governing acceptable inbound-to-outbound traffic ratios, if specified in the agreement (e.g., 2:1, balanced).',
    CONSTRAINT pk_peering_agreement PRIMARY KEY(`peering_agreement_id`)
) COMMENT 'Master record for network peering and transit agreements with other operators and internet exchange points (IXPs) — the network interconnection agreement record. Captures peering partner name, peering type (public/private/transit), IXP name, peering location (POP site), BGP AS number, agreed bandwidth, traffic exchange policy (settlement-free/paid), peering IP addresses, BGP session state, agreement start date, agreement expiry date, and commercial terms reference. Distinct from interconnect domain commercial settlement — this is the network-layer peering configuration and agreement record.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`ims_node` (
    `ims_node_id` BIGINT COMMENT 'Unique identifier for the IMS core network node. Primary key.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: IMS nodes (CSCF, HSS, application servers) are capital assets requiring depreciation and asset lifecycle tracking. Essential for core network asset accounting and financial reporting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: IMS nodes require assigned engineers for configuration, capacity management, and service troubleshooting. Business process: IMS registration failures and session capacity issues route to responsible a',
    `element_id` BIGINT COMMENT 'Reference to the parent network element record in the broader network inventory, linking this IMS node to the overall network topology.',
    `network_equipment_id` BIGINT COMMENT 'Foreign key linking to inventory.network_equipment. Business justification: IMS nodes (CSCF, HSS, BGCF) run on physical servers/appliances. Hardware lifecycle management, capacity planning, fault isolation, and asset tracking require linking logical IMS function to physical e',
    `pop_facility_id` BIGINT COMMENT 'Reference to the POP site or data center facility where this IMS node is physically hosted.',
    `redundancy_pair_node_id` BIGINT COMMENT 'Reference to the paired IMS node that provides redundancy or failover capability for this node.',
    `uc_subscription_id` BIGINT COMMENT 'Foreign key linking to enterprise.uc_subscription. Business justification: IMS nodes serve enterprise UC subscriptions for SIP trunking and hosted VoIP. Business process: UC service delivery, SIP trunk provisioning, call routing, and IMS capacity allocation per subscription.',
    `actual_availability_percentage` DECIMAL(18,2) COMMENT 'Measured actual availability percentage of the IMS node over a defined reporting period, used for SLA compliance tracking.',
    `administrative_status` STRING COMMENT 'Administrative state indicating whether the node is enabled or disabled for service by network operations.. Valid values are `enabled|disabled|locked|unlocked`',
    `commissioning_date` DATE COMMENT 'Date when the IMS node was commissioned and placed into active service in the production network.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this IMS node record was first created in the system of record.',
    `current_registration_count` STRING COMMENT 'Current number of active subscriber registrations maintained by the node at the time of measurement.',
    `current_session_count` STRING COMMENT 'Current number of active IMS sessions being processed by the node at the time of measurement.',
    `decommissioning_date` DATE COMMENT 'Date when the IMS node was or is planned to be decommissioned and removed from active service.',
    `equipment_model` STRING COMMENT 'Specific model or product line designation of the IMS node hardware platform.',
    `geographic_location` STRING COMMENT 'Physical geographic location or data center site where the IMS node is deployed (city, region, or site identifier).',
    `ims_domain_name` STRING COMMENT 'Fully qualified domain name (FQDN) of the IMS domain that this node serves, used for SIP routing and service identification.',
    `ip_address` STRING COMMENT 'Primary IP address assigned to the IMS node for network communication and signaling.',
    `last_failure_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent failure or outage event experienced by the IMS node.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent scheduled maintenance activity performed on the IMS node.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this IMS node record was most recently modified or updated.',
    `maintenance_window` STRING COMMENT 'Scheduled time window during which maintenance activities can be performed on the IMS node with minimal service impact (e.g., Sunday 02:00-06:00 UTC).',
    `mtbf_hours` DECIMAL(18,2) COMMENT 'Average time in hours between consecutive failures of the IMS node, indicating equipment reliability and stability.',
    `mttr_hours` DECIMAL(18,2) COMMENT 'Average time in hours required to restore the IMS node to operational status following a failure, a key reliability metric.',
    `next_maintenance_date` DATE COMMENT 'Scheduled date for the next planned maintenance activity on the IMS node.',
    `nms_object_reference` STRING COMMENT 'Unique object identifier assigned to this IMS node within the network management system for tracking and correlation.',
    `nms_system` STRING COMMENT 'Name of the network management system (e.g., Nokia NetAct, Ericsson Network Manager) responsible for monitoring and managing this IMS node.',
    `node_identifier` STRING COMMENT 'Externally-known unique identifier or name for the IMS node, used in network management systems and operational documentation.',
    `node_name` STRING COMMENT 'Human-readable name assigned to the IMS node for identification in network operations and management interfaces.',
    `node_type` STRING COMMENT 'Classification of the IMS node function: P-CSCF (Proxy Call Session Control Function), S-CSCF (Serving CSCF), I-CSCF (Interrogating CSCF), PCRF (Policy and Charging Rules Function), HSS (Home Subscriber Server), AS (Application Server), BGCF (Breakout Gateway Control Function), MGCF (Media Gateway Control Function). [ENUM-REF-CANDIDATE: P-CSCF|S-CSCF|I-CSCF|PCRF|HSS|AS|BGCF|MGCF — 8 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-form text field for additional operational notes, configuration details, or special instructions related to the IMS node.',
    `operational_status` STRING COMMENT 'Current operational state of the IMS node in the network lifecycle.. Valid values are `in_service|out_of_service|maintenance|testing|standby|decommissioned`',
    `owner_organization` STRING COMMENT 'Business unit, department, or organizational entity responsible for the ownership and operational management of this IMS node.',
    `port_number` STRING COMMENT 'Primary TCP/UDP port number used by the IMS node for SIP signaling or other protocol communication.',
    `redundancy_configuration` STRING COMMENT 'Type of redundancy and high-availability configuration implemented for this IMS node to ensure service continuity.. Valid values are `active_active|active_standby|n_plus_1|geographic_redundant|none`',
    `registration_capacity` STRING COMMENT 'Maximum number of concurrent subscriber registrations that the node can maintain, applicable primarily to S-CSCF and HSS nodes.',
    `secondary_ip_address` STRING COMMENT 'Secondary or backup IP address for redundancy and failover scenarios.',
    `security_zone` STRING COMMENT 'Network security zone or segment in which the IMS node is deployed, defining firewall rules and access control policies.',
    `session_capacity` STRING COMMENT 'Maximum number of concurrent IMS sessions (calls, video sessions, messaging sessions) that the node can handle simultaneously.',
    `sla_target_availability_percentage` DECIMAL(18,2) COMMENT 'Target availability percentage defined in the SLA for this IMS node, typically 99.99% or higher for critical core network elements.',
    `software_version` STRING COMMENT 'Current software release or firmware version running on the IMS node, critical for compatibility and feature support.',
    `supported_codecs` STRING COMMENT 'Comma-separated list of voice and video codecs supported by this IMS node (e.g., AMR-NB, AMR-WB, EVS, H.264, H.265) for multimedia session negotiation.',
    `supported_services` STRING COMMENT 'Comma-separated list of IMS-based services enabled on this node (e.g., VoLTE, VoNR, RCS, video calling, SMS over IP, emergency calling).',
    `utilization_percentage` DECIMAL(18,2) COMMENT 'Current resource utilization of the IMS node expressed as a percentage of total capacity, used for capacity planning and performance monitoring.',
    `vendor_name` STRING COMMENT 'Name of the equipment vendor or manufacturer that supplied the IMS node hardware and software platform.',
    CONSTRAINT pk_ims_node PRIMARY KEY(`ims_node_id`)
) COMMENT 'Master record for IP Multimedia Subsystem (IMS) core network nodes enabling VoLTE, VoNR, and multimedia services — P-CSCF, S-CSCF, I-CSCF, PCRF, HSS, and AS (Application Server) nodes. Captures node type, vendor, software release, IMS domain name, supported codecs (AMR-NB, AMR-WB, EVS), supported services (VoLTE/VoNR/RCS/video calling), session capacity, registration capacity, geographic redundancy configuration, and operational state. Supports VoLTE/5G voice service delivery and IMS core network management.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`slice` (
    `slice_id` BIGINT COMMENT 'Unique identifier for the 5G network slice instance. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: 5G network slices require assigned engineers for orchestration, SLA monitoring, and lifecycle management. Business process: slice instantiation, modification, and SLA breach resolution require enginee',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Network slicing instantiates specific catalog items (IoT service, enterprise VPN, AR/VR). Slice orchestration systems reference catalog_item_id to apply correct SLA parameters, QoS profiles, and resou',
    `rate_plan_id` BIGINT COMMENT 'Reference to the rate plan defining pricing rules, tariffs, and charging parameters for usage of this network slice.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: 5G network slices incur operational costs (compute, transport, orchestration) allocated to cost centers or profit centers. Required for slice-based cost allocation, tenant chargeback, and 5G economics',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Network slices allocated to enterprise customers for 5G private networks, dedicated service tiers. Real process: 5G enterprise service delivery, slice-as-a-service, per-customer SLA enforcement. Alrea',
    `network_qos_profile_id` BIGINT COMMENT 'Reference to the QoS profile defining 5QI, GFBR, MFBR, packet delay budget, and packet error rate parameters for this slice.',
    `sla_contract_id` BIGINT COMMENT 'Foreign key linking to assurance.sla_contract. Business justification: 5G network slices are sold with specific SLA guarantees per tenant/use-case (e.g., URLLC, eMBB). Fundamental to slice monetization, performance assurance, and multi-tenant service differentiation. Cor',
    `svc_instance_id` BIGINT COMMENT 'Reference to the commercial service offering that this network slice supports. Links slice infrastructure to customer-facing service catalog.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: 5G network slices provide tenant-isolated connectivity per enterprise account. Business process: enterprise 5G service delivery, slice lifecycle management, and account-level SLA enforcement for dedic',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: 5G network slicing commonly serves enterprise partners or MVNOs as tenants with dedicated slice instances. Slice billing, SLA enforcement, resource allocation, and usage settlement require linking the',
    `parent_slice_id` BIGINT COMMENT 'Self-referencing FK on slice (parent_slice_id)',
    `activation_timestamp` TIMESTAMP COMMENT 'Date and time when the network slice transitioned to active operational state and began serving traffic.',
    `charging_model` STRING COMMENT 'The billing and charging model applied to this slice: prepaid (pay-before-use), postpaid (bill-after-use), hybrid (combination), or sponsored (third-party pays).. Valid values are `prepaid|postpaid|hybrid|sponsored`',
    `core_slice_config` STRING COMMENT 'JSON or XML configuration parameters defining 5G core network slice behavior including network function selection, policy rules, and charging parameters.',
    `coverage_area_tac_list` STRING COMMENT 'Comma-separated list of Tracking Area Codes where this slice is available. Defines the geographic scope of slice coverage.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this slice record was first created in the system. Used for audit trail and data lineage tracking.',
    `current_ue_count` STRING COMMENT 'Current number of active User Equipment (devices) connected to this network slice. Used for real-time capacity monitoring and utilization tracking.',
    `decommission_timestamp` TIMESTAMP COMMENT 'Date and time when the network slice was decommissioned and resources were released. Marks the end of the slice lifecycle.',
    `deployment_model` STRING COMMENT 'Resource allocation model: dedicated (isolated resources per slice), shared (resources shared across slices), or hybrid (mix of dedicated and shared components).. Valid values are `dedicated|shared|hybrid`',
    `identifier` STRING COMMENT 'The globally unique S-NSSAI identifier combining Slice/Service Type (SST) and Slice Differentiator (SD) in format S-NSSAI:SST:SD. Used for slice selection in 5G SA core network.. Valid values are `^S-NSSAI:[0-9A-F]{2}:[0-9A-F]{6}$`',
    `instantiation_timestamp` TIMESTAMP COMMENT 'Date and time when the network slice was instantiated and provisioned by the orchestrator. Marks the beginning of the slice lifecycle.',
    `isolation_level` STRING COMMENT 'Degree of resource isolation between this slice and others: physical (dedicated hardware), logical (virtualized separation), or none (best-effort shared resources).. Valid values are `physical|logical|none`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the slice configuration or attributes. Used for change tracking and audit purposes.',
    `lifecycle_state` STRING COMMENT 'The current stage in the network slice lifecycle from initial design through decommissioning. Governs operational workflows and change management processes.. Valid values are `design|test|commissioning|active|suspended|decommissioned`',
    `max_ue_count` STRING COMMENT 'Maximum number of concurrent User Equipment (devices) that can be served by this network slice. Critical capacity planning parameter for mMTC slices.',
    `modified_by_user` STRING COMMENT 'User ID or system account that performed the most recent modification to this slice record. Used for accountability and audit compliance.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special instructions, or additional context about the network slice configuration and usage.',
    `nsi_identifier` STRING COMMENT 'The globally unique Network Slice Instance identifier assigned by the MANO orchestrator. Used for lifecycle management and cross-domain coordination.',
    `nssf_instance_reference` STRING COMMENT 'The NSSF network function instance identifier responsible for slice selection for this slice. NSSF selects the appropriate network slice instance for UE registration.',
    `nst_identifier` STRING COMMENT 'Reference to the Network Slice Template used to instantiate this slice. Templates define reusable slice blueprints with predefined configurations.',
    `operational_status` STRING COMMENT 'Current operational state of the network slice reflecting real-time service availability and health status.. Valid values are `active|inactive|degraded|maintenance|failed`',
    `orchestrator_system` STRING COMMENT 'Name of the NFV MANO or SDN orchestrator system responsible for lifecycle management of this slice (e.g., ONAP, OSM, vendor-specific NFVO).',
    `plmn_id_list` STRING COMMENT 'Comma-separated list of PLMN IDs (MCC-MNC combinations) where this slice is deployed. Supports multi-operator and roaming scenarios.',
    `priority_level` STRING COMMENT 'Relative priority of this slice for resource allocation and preemption decisions. Lower numeric values indicate higher priority. Range typically 1-15.',
    `ran_slice_config` STRING COMMENT 'JSON or XML configuration parameters defining RAN-level slice behavior including radio resource allocation, scheduling policies, and QoS parameters.',
    `sd_value` DECIMAL(18,2) COMMENT 'The 24-bit Slice Differentiator component of S-NSSAI, used to differentiate multiple slices of the same SST. Hexadecimal format. Optional field per 3GPP specification.',
    `security_policy_reference` STRING COMMENT 'Reference to the security policy governing authentication, encryption, firewall rules, and access control for this slice.',
    `slice_name` STRING COMMENT 'Human-readable business name assigned to the network slice for operational identification and reporting purposes.',
    `slice_type` STRING COMMENT 'The service category this slice is optimized for: eMBB (enhanced Mobile Broadband), URLLC (Ultra-Reliable Low-Latency Communications), mMTC (massive Machine-Type Communications), V2X (Vehicle-to-Everything), or custom for enterprise-specific configurations.. Valid values are `eMBB|URLLC|mMTC|V2X|custom`',
    `sst_value` STRING COMMENT 'The 8-bit Slice/Service Type component of S-NSSAI. Standardized values: 1=eMBB, 2=URLLC, 3=mMTC, 4=V2X. Range 128-255 reserved for operator-specific slice types.',
    `tenant_code` BIGINT COMMENT 'Identifier of the enterprise customer or business unit that owns or leases this network slice. Used for multi-tenancy and slice-as-a-service offerings.',
    `transport_slice_config` STRING COMMENT 'JSON or XML configuration parameters defining transport network slice behavior including MPLS tunnels, SD-WAN policies, and QoS class mappings.',
    CONSTRAINT pk_slice PRIMARY KEY(`slice_id`)
) COMMENT 'Master record for 5G network slices — logical end-to-end network partitions configured to meet specific service requirements (eMBB, URLLC, mMTC). Captures slice identifier (S-NSSAI: SST + SD), slice name, slice type (eMBB/URLLC/mMTC/custom), SLA parameters (latency, throughput, reliability), constituent network functions (AMF, SMF, UPF instances), RAN slice configuration, transport slice configuration, lifecycle state (design/test/active/decommissioned), tenant assignment, and resource isolation level. Critical for 5G SA network operations, enterprise slice-as-a-service offerings, and regulatory reporting on network resource allocation.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`element_outage_impact` (
    `element_outage_impact_id` BIGINT COMMENT 'Unique identifier for this element-outage impact record. Primary key for the association.',
    `element_id` BIGINT COMMENT 'Foreign key linking to the network element affected by this planned outage',
    `planned_outage_id` BIGINT COMMENT 'Foreign key linking to the planned maintenance outage event',
    `affected_network_element_ids` STRING COMMENT 'Comma-separated list of network element identifiers (RAN, core, transport, GPON, MPLS, SD-WAN, NFV/SDN nodes, OLT, ONT, DSLAM, BNG, BRAS, POP sites) impacted by this planned outage. [Moved from planned_outage: This comma-separated STRING field is a poor implementation of the M:N relationship. It should be replaced by proper foreign key relationships in the element_outage_impact association table, enabling relational queries, referential integrity, and granular element-level tracking.]',
    `element_actual_downtime_minutes` STRING COMMENT 'Calculated duration in minutes that this specific network element was out of service, derived from element_downtime_start and element_downtime_end. Used for per-element SLA impact calculation and network availability reporting.',
    `element_downtime_end` TIMESTAMP COMMENT 'Actual timestamp when this specific network element was restored to service during the planned outage. May differ from the overall outage end time as elements are restored sequentially or may require additional validation time.',
    `element_downtime_start` TIMESTAMP COMMENT 'Actual timestamp when this specific network element was taken out of service during the planned outage. May differ from the overall outage start time as elements are often taken down sequentially.',
    `element_specific_impact_severity` STRING COMMENT 'Impact severity classification specific to this network element within the broader planned outage. While the outage may have an overall severity, individual elements may experience different impact levels based on redundancy, traffic load, and criticality.',
    `element_validation_status` STRING COMMENT 'Post-maintenance validation status for this specific network element indicating whether the element passed operational validation tests after the outage work was completed. Critical for ensuring element health before returning to full service.',
    `element_validation_timestamp` TIMESTAMP COMMENT 'Timestamp when validation testing was completed for this network element post-outage.',
    `element_work_notes` STRING COMMENT 'Detailed notes documenting element-specific work performed, issues encountered, or observations made during the planned outage for this particular network element.',
    `rollback_executed_for_element` BOOLEAN COMMENT 'Boolean indicator whether the rollback procedure was executed specifically for this network element. In complex outages, some elements may require rollback while others complete successfully.',
    CONSTRAINT pk_element_outage_impact PRIMARY KEY(`element_outage_impact_id`)
) COMMENT 'This association product represents the impact relationship between network elements and planned maintenance outages. It captures element-specific outage details including downtime windows, impact severity, rollback status, and validation outcomes. Each record links one network element to one planned outage with attributes that exist only in the context of this specific element-outage relationship. This enables granular element-level outage tracking, per-element downtime measurement, SLA impact analysis, and element-specific rollback/validation status tracking for NOC operations and network reliability reporting.. Existence Justification: In telecommunications network operations, planned maintenance outages routinely affect multiple network elements (RAN nodes, core network functions, transport equipment), and each network element participates in multiple planned outages over its lifecycle. The NOC actively manages element-specific outage impacts including per-element downtime windows, validation status, and rollback decisions. This is a core operational relationship that network engineers query and manage daily.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`slice_vnf_assignment` (
    `slice_vnf_assignment_id` BIGINT COMMENT 'Unique identifier for this VNF-to-slice assignment record. Primary key.',
    `nfv_vnf_id` BIGINT COMMENT 'Foreign key linking to the Virtual Network Function instance assigned to this slice',
    `sla_profile_id` BIGINT COMMENT 'Reference to the SLA profile governing this VNFs performance requirements within this slice. Different slices may impose different SLA requirements on the same VNF.',
    `slice_id` BIGINT COMMENT 'Foreign key linking to the 5G network slice that this VNF serves',
    `amf_instance_ids` STRING COMMENT 'Comma-separated list of AMF network function instance identifiers assigned to serve this slice. AMF handles registration, connection, and mobility management. [Moved from network_slice: This comma-separated list attribute is a poor implementation of the M:N relationship between network slices and VNF instances. The specific AMF instances assigned to a slice should be tracked in the slice_vnf_assignment association with proper role, resource allocation, and configuration attributes.]',
    `assignment_timestamp` TIMESTAMP COMMENT 'Timestamp when this VNF was assigned to serve this network slice. Critical for slice lifecycle tracking and audit trails.',
    `decommission_timestamp` TIMESTAMP COMMENT 'Timestamp when this VNF assignment to the slice was terminated or decommissioned. NULL indicates the assignment is currently active. Enables historical analysis of slice composition changes.',
    `operational_status` STRING COMMENT 'Current operational status of this VNF assignment within the slice context. A VNF may be active in one slice while in standby for another.',
    `priority_level` STRING COMMENT 'Priority level for this VNF assignment within the slice context (1=highest, 10=lowest). Used for resource contention resolution and failover decisions when a VNF serves multiple slices.',
    `resource_allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the VNFs total compute/network resources allocated to serving this specific slice. Enables resource sharing and isolation tracking across slices.',
    `slice_specific_config_parameters` STRING COMMENT 'JSON or XML configuration parameters specific to this VNFs operation within this slice. Includes slice-specific QoS policies, routing rules, security policies, and performance thresholds that differ from the VNFs base configuration.',
    `smf_instance_ids` STRING COMMENT 'Comma-separated list of SMF network function instance identifiers assigned to serve this slice. SMF manages PDU sessions and UPF selection. [Moved from network_slice: This comma-separated list attribute is a poor implementation of the M:N relationship between network slices and VNF instances. The specific SMF instances assigned to a slice should be tracked in the slice_vnf_assignment association with proper role, resource allocation, and configuration attributes.]',
    `upf_instance_ids` STRING COMMENT 'Comma-separated list of UPF network function instance identifiers assigned to serve this slice. UPF handles packet routing, forwarding, and QoS enforcement. [Moved from network_slice: This comma-separated list attribute is a poor implementation of the M:N relationship between network slices and VNF instances. The specific UPF instances assigned to a slice should be tracked in the slice_vnf_assignment association with proper role, resource allocation, and configuration attributes.]',
    `vnf_role_in_slice` STRING COMMENT 'The specific network function role this VNF performs within the slice context (e.g., AMF, SMF, UPF). A single VNF instance may serve different roles or priorities across multiple slices.',
    CONSTRAINT pk_slice_vnf_assignment PRIMARY KEY(`slice_vnf_assignment_id`)
) COMMENT 'This association product represents the assignment of Virtual Network Functions (VNFs) to 5G network slices. It captures the operational relationship between NFV virtualized network functions and the logical network slices they serve. Each record links one VNF instance to one network slice with slice-specific configuration, resource allocation, and role information that exists only in the context of this assignment. Critical for 5G slice orchestration, resource management, and performance assurance.. Existence Justification: In 5G network operations, a single VNF instance (e.g., a virtualized UPF or AMF) can simultaneously serve multiple network slices with different resource allocations and configurations, and each network slice requires multiple VNF instances (AMF, SMF, UPF, etc.) to provide end-to-end service. The business actively manages these assignments through MANO orchestration systems, tracking slice-specific VNF configurations, resource allocation percentages, and performance SLAs. This is a core operational relationship in 5G slice orchestration.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`cell_slice_assignment` (
    `cell_slice_assignment_id` BIGINT COMMENT 'Unique identifier for this cell-slice assignment record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the network engineer or orchestration system that configured this slice assignment on this cell. Used for audit and troubleshooting.',
    `ran_cell_id` BIGINT COMMENT 'Foreign key linking to the RAN cell that is configured to support this network slice.',
    `slice_id` BIGINT COMMENT 'Foreign key linking to the 5G network slice being deployed on this RAN cell.',
    `activation_timestamp` TIMESTAMP COMMENT 'Date and time when this network slice was activated on this RAN cell. Records when the slice became operational on this cell.',
    `admission_control_threshold` STRING COMMENT 'Maximum number of User Equipment (UE) connections allowed for this slice on this specific cell. Used for admission control to prevent slice oversubscription at the cell level.',
    `allocated_prb_percentage` DECIMAL(18,2) COMMENT 'Percentage of the cells Physical Resource Blocks (PRBs) allocated to this network slice. Defines the radio resource share for this slice on this cell. Range: 0.00-100.00.',
    `cell_slice_activation_status` STRING COMMENT 'Current operational status of this slice on this specific cell. Indicates whether the cell is actively serving traffic for this slice. Values: active, inactive, suspended, testing, decommissioned.',
    `deactivation_timestamp` TIMESTAMP COMMENT 'Date and time when this network slice was deactivated on this RAN cell. Null if the slice is currently active on this cell.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this cell-slice assignment configuration was last modified. Tracks configuration change history.',
    `sla_compliance_status` STRING COMMENT 'Current SLA compliance status for this slice on this cell. Indicates whether the cell is meeting the slice SLA requirements (latency, throughput, reliability). Values: compliant, degraded, violated, not_measured.',
    `slice_priority_level` STRING COMMENT 'Priority level for this slice on this cell, used for resource arbitration and preemption decisions when multiple slices compete for resources. Lower values indicate higher priority.',
    CONSTRAINT pk_cell_slice_assignment PRIMARY KEY(`cell_slice_assignment_id`)
) COMMENT 'This association product represents the operational assignment of 5G network slices to individual RAN cells. It captures the many-to-many relationship where a single cell can simultaneously support multiple network slices (eMBB, URLLC, mMTC) with different resource allocations, and a network slice spans across multiple cells to provide end-to-end service coverage. Each record defines the slice activation status, resource block allocation, priority levels, and admission control thresholds that govern how the cell serves traffic for that specific slice.. Existence Justification: In 5G networks, RAN cells and network slices have a true many-to-many operational relationship as defined by 3GPP standards. A single physical RAN cell simultaneously supports multiple network slices (e.g., eMBB for consumer broadband, URLLC for industrial IoT, mMTC for massive sensor networks) with independent resource allocations and SLA parameters. Conversely, a network slice spans across multiple RAN cells to provide end-to-end service coverage across geographic areas. Network operations teams actively manage these assignments, configuring per-cell resource allocations, priority levels, and admission control thresholds for each slice.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`circuit` (
    `circuit_id` BIGINT COMMENT 'Primary key for circuit',
    `carrier_id` BIGINT COMMENT 'Identifier of the external service provider that supplies the circuit.',
    `enterprise_contract_id` BIGINT COMMENT 'Identifier of the contract governing the circuit.',
    `location_site_id` BIGINT COMMENT 'Identifier of the site or POP where the circuit is terminated.',
    `vendor_id` BIGINT COMMENT 'Identifier of the equipment vendor associated with the circuit.',
    `protected_by_circuit_id` BIGINT COMMENT 'Self-referencing FK on circuit (protected_by_circuit_id)',
    `activation_date` DATE COMMENT 'Date the circuit became operational and available for traffic.',
    `billing_cycle` STRING COMMENT 'Billing frequency for the circuit service.',
    `capacity_mbps` DECIMAL(18,2) COMMENT 'Maximum data throughput capacity of the circuit in megabits per second.',
    `circuit_code` STRING COMMENT 'External business code or identifier assigned to the circuit by the carrier.',
    `city` STRING COMMENT 'City where the circuit terminates.',
    `cost` DECIMAL(18,2) COMMENT 'Recurring cost of the circuit per billing cycle.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the circuit record was first created in the system.',
    `currency` STRING COMMENT 'ISO 4217 currency code for the cost (e.g., USD, EUR).',
    `deactivation_date` DATE COMMENT 'Date the circuit was taken out of service (nullable if still active).',
    `circuit_description` STRING COMMENT 'Free‑form description of the circuit purpose or notes.',
    `installation_date` DATE COMMENT 'Date the circuit was physically installed.',
    `ip_address` STRING COMMENT 'IP address assigned to the circuit endpoint.',
    `is_primary` BOOLEAN COMMENT 'Flag indicating if this circuit is the primary path for a service.',
    `is_shared` BOOLEAN COMMENT 'Indicates whether the circuit is shared among multiple services.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent maintenance activity.',
    `location` STRING COMMENT 'Descriptive location of the circuit (e.g., data center, street address).',
    `maintenance_window` STRING COMMENT 'Scheduled maintenance window (e.g., "02:00-04:00").',
    `mtu` STRING COMMENT 'Maximum Transmission Unit size in bytes for the circuit.',
    `circuit_name` STRING COMMENT 'Human‑readable name of the circuit used in reports and dashboards.',
    `network_zone` STRING COMMENT 'Logical network zone classification (e.g., core, edge, access).',
    `next_maintenance_date` DATE COMMENT 'Planned date for the next maintenance activity.',
    `notes` STRING COMMENT 'Additional operational notes or remarks.',
    `port_a` STRING COMMENT 'Identifier of the A‑side port on the equipment.',
    `port_z` STRING COMMENT 'Identifier of the Z‑side port on the equipment.',
    `qos_class` STRING COMMENT 'Quality‑of‑Service class assigned to the circuit.',
    `redundancy_level` STRING COMMENT 'Level of redundancy configured for the circuit.',
    `region` STRING COMMENT 'Broad geographic region (e.g., North America, EMEA).',
    `service_level` STRING COMMENT 'Service level agreement tier for the circuit.',
    `sla_actual_ms` STRING COMMENT 'Measured latency in milliseconds observed on the circuit.',
    `sla_target_ms` STRING COMMENT 'Target latency in milliseconds defined in the SLA.',
    `circuit_status` STRING COMMENT 'Current lifecycle status of the circuit.',
    `subnet` STRING COMMENT 'Subnet mask or CIDR notation for the circuit IP range.',
    `technology` STRING COMMENT 'Specific technology details (e.g., 10GBASE‑SR, OTN, DWDM).',
    `termination_date` DATE COMMENT 'Contractual termination date of the circuit.',
    `circuit_type` STRING COMMENT 'Technology type of the circuit (e.g., Ethernet, MPLS, SDH, PTP, VPN).',
    `updated_by` STRING COMMENT 'User or system that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the circuit record.',
    `vlan_tag` STRING COMMENT 'VLAN ID associated with the circuit, if applicable.',
    `created_by` STRING COMMENT 'User or system that created the circuit record.',
    CONSTRAINT pk_circuit PRIMARY KEY(`circuit_id`)
) COMMENT 'Master reference table for circuit. Referenced by circuit_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`maintenance_window` (
    `maintenance_window_id` BIGINT COMMENT 'Primary key for maintenance_window',
    `recurring_from_maintenance_window_id` BIGINT COMMENT 'Self-referencing FK on maintenance_window (recurring_from_maintenance_window_id)',
    `actual_end` TIMESTAMP COMMENT 'Real end date and time when maintenance completed.',
    `actual_start` TIMESTAMP COMMENT 'Real start date and time when maintenance began.',
    `affected_elements` STRING COMMENT 'Comma‑separated list of network elements (e.g., nodes, circuits) impacted.',
    `affected_sites_count` STRING COMMENT 'Number of network sites impacted by the maintenance.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the maintenance window was approved.',
    `approved_by` STRING COMMENT 'Name of the person or role that approved the maintenance window.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the maintenance window record was created in the system.',
    `maintenance_window_description` STRING COMMENT 'Detailed free‑text description of the maintenance activities.',
    `expected_downtime_minutes` STRING COMMENT 'Estimated total downtime in minutes expected for the maintenance window.',
    `external_ticket_reference` STRING COMMENT 'Identifier of the related ticket in external ticketing system.',
    `impact_level` STRING COMMENT 'Severity of service impact expected from the maintenance.',
    `maintenance_category` STRING COMMENT 'Broad classification of the maintenance work.',
    `network_team` STRING COMMENT 'Team responsible for executing the maintenance.',
    `notification_sent` BOOLEAN COMMENT 'Indicates whether customers and internal stakeholders were notified.',
    `post_maintenance_review_completed` BOOLEAN COMMENT 'Indicates if the post‑maintenance review has been performed.',
    `priority` STRING COMMENT 'Business priority assigned to the maintenance window.',
    `review_timestamp` TIMESTAMP COMMENT 'Date and time when the post‑maintenance review was completed.',
    `risk_assessment` STRING COMMENT 'Risk rating assigned to the maintenance activity.',
    `rollback_plan_available` BOOLEAN COMMENT 'Flag indicating whether a rollback plan exists for the maintenance.',
    `scheduled_end` TIMESTAMP COMMENT 'Planned end date and time of the maintenance window.',
    `scheduled_start` TIMESTAMP COMMENT 'Planned start date and time of the maintenance window.',
    `source_system` STRING COMMENT 'Name of the source system that originated the maintenance window record.',
    `maintenance_window_status` STRING COMMENT 'Current lifecycle status of the maintenance window.',
    `status_reason` STRING COMMENT 'Free‑text explanation for the current status of the maintenance window.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the maintenance window record.',
    `window_code` STRING COMMENT 'Human‑readable code used to reference the maintenance window in operational systems.',
    `window_name` STRING COMMENT 'Descriptive name of the maintenance window.',
    `window_type` STRING COMMENT 'Category of maintenance indicating planning level and urgency.',
    CONSTRAINT pk_maintenance_window PRIMARY KEY(`maintenance_window_id`)
) COMMENT 'Master reference table for maintenance_window. Referenced by maintenance_window_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`config_template` (
    `config_template_id` BIGINT COMMENT 'Primary key for config_template',
    `base_config_template_id` BIGINT COMMENT 'Self-referencing FK on config_template (base_config_template_id)',
    `author` STRING COMMENT 'Name or identifier of the person or system that authored the template.',
    `change_log` STRING COMMENT 'Free‑text log of changes made to the template across versions.',
    `config_template_code` STRING COMMENT 'Business identifier or code used to reference the template in operational processes.',
    `compliance_flag` STRING COMMENT 'Indicates whether the template complies with internal or regulatory standards.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the template record was first created in the system.',
    `config_template_description` STRING COMMENT 'Detailed free‑text description of the templates purpose and scope.',
    `effective_from` DATE COMMENT 'Date when the template becomes valid for deployment.',
    `effective_until` DATE COMMENT 'Date when the template is no longer valid (null for open‑ended).',
    `config_template_name` STRING COMMENT 'Human‑readable name of the configuration template.',
    `network_element_type` STRING COMMENT 'Type of network element(s) the template can be applied to.',
    `owner` STRING COMMENT 'Business unit or team responsible for the lifecycle of the template.',
    `software_version` STRING COMMENT 'Software or firmware version of the target element for which the template is designed.',
    `config_template_status` STRING COMMENT 'Current lifecycle state of the template.',
    `template_size_bytes` BIGINT COMMENT 'Size of the template file or payload in bytes.',
    `template_type` STRING COMMENT 'Category of the template indicating its primary purpose within the network.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the template record.',
    `vendor` STRING COMMENT 'Equipment vendor or software provider associated with the template.',
    `version` STRING COMMENT 'Version identifier of the template, following the internal versioning scheme.',
    CONSTRAINT pk_config_template PRIMARY KEY(`config_template_id`)
) COMMENT 'Master reference table for config_template. Referenced by config_template_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ADD CONSTRAINT `fk_network_topology_transmission_link_id` FOREIGN KEY (`transmission_link_id`) REFERENCES `telecommunication_ecm`.`network`.`transmission_link`(`transmission_link_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ADD CONSTRAINT `fk_network_topology_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ADD CONSTRAINT `fk_network_topology_network_qos_profile_id` FOREIGN KEY (`network_qos_profile_id`) REFERENCES `telecommunication_ecm`.`network`.`network_qos_profile`(`network_qos_profile_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ADD CONSTRAINT `fk_network_topology_source_network_element_id` FOREIGN KEY (`source_network_element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ADD CONSTRAINT `fk_network_ran_cell_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ADD CONSTRAINT `fk_network_ran_cell_network_qos_profile_id` FOREIGN KEY (`network_qos_profile_id`) REFERENCES `telecommunication_ecm`.`network`.`network_qos_profile`(`network_qos_profile_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ADD CONSTRAINT `fk_network_transmission_link_circuit_id` FOREIGN KEY (`circuit_id`) REFERENCES `telecommunication_ecm`.`network`.`circuit`(`circuit_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ADD CONSTRAINT `fk_network_mpls_tunnel_network_qos_profile_id` FOREIGN KEY (`network_qos_profile_id`) REFERENCES `telecommunication_ecm`.`network`.`network_qos_profile`(`network_qos_profile_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ADD CONSTRAINT `fk_network_mpls_tunnel_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ADD CONSTRAINT `fk_network_nfv_vnf_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ADD CONSTRAINT `fk_network_ip_address_plan_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ADD CONSTRAINT `fk_network_ip_address_plan_network_qos_profile_id` FOREIGN KEY (`network_qos_profile_id`) REFERENCES `telecommunication_ecm`.`network`.`network_qos_profile`(`network_qos_profile_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ADD CONSTRAINT `fk_network_capacity_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ADD CONSTRAINT `fk_network_element_config_config_template_id` FOREIGN KEY (`config_template_id`) REFERENCES `telecommunication_ecm`.`network`.`config_template`(`config_template_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ADD CONSTRAINT `fk_network_element_config_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ADD CONSTRAINT `fk_network_element_config_planned_outage_id` FOREIGN KEY (`planned_outage_id`) REFERENCES `telecommunication_ecm`.`network`.`planned_outage`(`planned_outage_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ADD CONSTRAINT `fk_network_element_config_rollback_reference_element_config_id` FOREIGN KEY (`rollback_reference_element_config_id`) REFERENCES `telecommunication_ecm`.`network`.`element_config`(`element_config_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ADD CONSTRAINT `fk_network_config_change_element_config_id` FOREIGN KEY (`element_config_id`) REFERENCES `telecommunication_ecm`.`network`.`element_config`(`element_config_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ADD CONSTRAINT `fk_network_config_change_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ADD CONSTRAINT `fk_network_config_change_planned_outage_id` FOREIGN KEY (`planned_outage_id`) REFERENCES `telecommunication_ecm`.`network`.`planned_outage`(`planned_outage_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ADD CONSTRAINT `fk_network_performance_counter_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ADD CONSTRAINT `fk_network_alarm_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ADD CONSTRAINT `fk_network_planned_outage_maintenance_window_id` FOREIGN KEY (`maintenance_window_id`) REFERENCES `telecommunication_ecm`.`network`.`maintenance_window`(`maintenance_window_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ADD CONSTRAINT `fk_network_sdwan_policy_network_qos_profile_id` FOREIGN KEY (`network_qos_profile_id`) REFERENCES `telecommunication_ecm`.`network`.`network_qos_profile`(`network_qos_profile_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ADD CONSTRAINT `fk_network_ims_node_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ADD CONSTRAINT `fk_network_ims_node_redundancy_pair_node_id` FOREIGN KEY (`redundancy_pair_node_id`) REFERENCES `telecommunication_ecm`.`network`.`ims_node`(`ims_node_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ADD CONSTRAINT `fk_network_slice_network_qos_profile_id` FOREIGN KEY (`network_qos_profile_id`) REFERENCES `telecommunication_ecm`.`network`.`network_qos_profile`(`network_qos_profile_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ADD CONSTRAINT `fk_network_slice_parent_slice_id` FOREIGN KEY (`parent_slice_id`) REFERENCES `telecommunication_ecm`.`network`.`slice`(`slice_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`element_outage_impact` ADD CONSTRAINT `fk_network_element_outage_impact_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`element_outage_impact` ADD CONSTRAINT `fk_network_element_outage_impact_planned_outage_id` FOREIGN KEY (`planned_outage_id`) REFERENCES `telecommunication_ecm`.`network`.`planned_outage`(`planned_outage_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`slice_vnf_assignment` ADD CONSTRAINT `fk_network_slice_vnf_assignment_nfv_vnf_id` FOREIGN KEY (`nfv_vnf_id`) REFERENCES `telecommunication_ecm`.`network`.`nfv_vnf`(`nfv_vnf_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`slice_vnf_assignment` ADD CONSTRAINT `fk_network_slice_vnf_assignment_slice_id` FOREIGN KEY (`slice_id`) REFERENCES `telecommunication_ecm`.`network`.`slice`(`slice_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`cell_slice_assignment` ADD CONSTRAINT `fk_network_cell_slice_assignment_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`cell_slice_assignment` ADD CONSTRAINT `fk_network_cell_slice_assignment_slice_id` FOREIGN KEY (`slice_id`) REFERENCES `telecommunication_ecm`.`network`.`slice`(`slice_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`circuit` ADD CONSTRAINT `fk_network_circuit_protected_by_circuit_id` FOREIGN KEY (`protected_by_circuit_id`) REFERENCES `telecommunication_ecm`.`network`.`circuit`(`circuit_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`maintenance_window` ADD CONSTRAINT `fk_network_maintenance_window_recurring_from_maintenance_window_id` FOREIGN KEY (`recurring_from_maintenance_window_id`) REFERENCES `telecommunication_ecm`.`network`.`maintenance_window`(`maintenance_window_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`config_template` ADD CONSTRAINT `fk_network_config_template_base_config_template_id` FOREIGN KEY (`base_config_template_id`) REFERENCES `telecommunication_ecm`.`network`.`config_template`(`config_template_id`);

-- ========= TAGS =========
ALTER SCHEMA `telecommunication_ecm`.`network` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `telecommunication_ecm`.`network` SET TAGS ('dbx_domain' = 'network');
ALTER TABLE `telecommunication_ecm`.`network`.`element` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`network`.`element` SET TAGS ('dbx_subdomain' = 'network_inventory');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Element Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Location Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Owning Org Unit Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `pop_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Pop Facility Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `spectrum_license_id` SET TAGS ('dbx_business_glossary_term' = 'Spectrum License Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `administrative_state` SET TAGS ('dbx_business_glossary_term' = 'Administrative State');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `administrative_state` SET TAGS ('dbx_value_regex' = 'locked|unlocked|shutting_down');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_value_regex' = 'gbps|mbps|tps|erlang|subscribers');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `capacity_value` SET TAGS ('dbx_business_glossary_term' = 'Capacity Value');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `element_name` SET TAGS ('dbx_business_glossary_term' = 'Network Element Name');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `element_type` SET TAGS ('dbx_business_glossary_term' = 'Network Element Type');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `element_type` SET TAGS ('dbx_value_regex' = 'ran|core|transport|access|cpe|vnf');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `ems_system` SET TAGS ('dbx_business_glossary_term' = 'Element Management System (EMS)');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `hardware_version` SET TAGS ('dbx_business_glossary_term' = 'Hardware Version');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `identifier` SET TAGS ('dbx_business_glossary_term' = 'Network Element Business Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Latitude');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `lifecycle_state` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle State');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `lifecycle_state` SET TAGS ('dbx_value_regex' = 'planned|installed|active|maintenance|decommissioned|retired');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Longitude');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `management_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Management Internet Protocol (IP) Address');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `management_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `mano_orchestrator` SET TAGS ('dbx_business_glossary_term' = 'Management and Orchestration (MANO) Orchestrator');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `mtbf_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (MTBF) Hours');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `mttr_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair (MTTR) Hours');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `nfv_indicator` SET TAGS ('dbx_business_glossary_term' = 'Network Functions Virtualization (NFV) Indicator');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `nms_system` SET TAGS ('dbx_business_glossary_term' = 'Network Management System (NMS)');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operational Notes');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `operational_state` SET TAGS ('dbx_business_glossary_term' = 'Operational State');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `operational_state` SET TAGS ('dbx_value_regex' = 'enabled|disabled|testing');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `power_consumption_watts` SET TAGS ('dbx_business_glossary_term' = 'Power Consumption Watts');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `rack_position` SET TAGS ('dbx_business_glossary_term' = 'Rack Position');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `redundancy_mode` SET TAGS ('dbx_business_glossary_term' = 'Redundancy Mode');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `redundancy_mode` SET TAGS ('dbx_value_regex' = 'none|active_standby|active_active|n_plus_1');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `slot_position` SET TAGS ('dbx_business_glossary_term' = 'Slot Position');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'Network Element Subtype');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `support_contact` SET TAGS ('dbx_business_glossary_term' = 'Technical Support Contact');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `support_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `support_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `temperature_rating_celsius` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature Rating Celsius');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `vcpu_count` SET TAGS ('dbx_business_glossary_term' = 'Virtual Central Processing Unit (vCPU) Count');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `vnfd_identifier` SET TAGS ('dbx_business_glossary_term' = 'Virtual Network Function Descriptor (VNFD) Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `vram_gb` SET TAGS ('dbx_business_glossary_term' = 'Virtual Random Access Memory (vRAM) Gigabytes (GB)');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` SET TAGS ('dbx_subdomain' = 'network_inventory');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `topology_id` SET TAGS ('dbx_business_glossary_term' = 'Topology Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `transmission_link_id` SET TAGS ('dbx_business_glossary_term' = 'Backup Link Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Network Element Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `fiber_cable_id` SET TAGS ('dbx_business_glossary_term' = 'Fiber Cable Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `network_qos_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Qos Profile Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `source_network_element_id` SET TAGS ('dbx_business_glossary_term' = 'Source Network Element Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `actual_availability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Actual Availability Percentage');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `administrative_state` SET TAGS ('dbx_business_glossary_term' = 'Administrative State');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `administrative_state` SET TAGS ('dbx_value_regex' = 'unlocked|locked|shutting_down');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `circuit_reference` SET TAGS ('dbx_business_glossary_term' = 'Circuit Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `destination_interface_name` SET TAGS ('dbx_business_glossary_term' = 'Destination Interface Name');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `is_bidirectional` SET TAGS ('dbx_business_glossary_term' = 'Is Bidirectional Link');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `is_protected` SET TAGS ('dbx_business_glossary_term' = 'Is Protected Link');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `is_virtual` SET TAGS ('dbx_business_glossary_term' = 'Is Virtual Link');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `last_failure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Failure Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `link_capacity_mbps` SET TAGS ('dbx_business_glossary_term' = 'Link Capacity in Megabits per Second (Mbps)');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `link_cost` SET TAGS ('dbx_business_glossary_term' = 'Link Cost Metric');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `link_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Link Distance in Kilometers (km)');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `link_identifier` SET TAGS ('dbx_business_glossary_term' = 'Link Business Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `link_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Link Latency in Milliseconds (ms)');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `link_name` SET TAGS ('dbx_business_glossary_term' = 'Link Name');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `link_type` SET TAGS ('dbx_business_glossary_term' = 'Link Type');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `link_type` SET TAGS ('dbx_value_regex' = 'fiber|microwave|copper|ethernet|mpls_lsp|ip');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `mpls_label` SET TAGS ('dbx_business_glossary_term' = 'Multiprotocol Label Switching (MPLS) Label');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `mtbf_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (MTBF) in Hours');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `mttr_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time to Repair (MTTR) in Hours');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `network_layer` SET TAGS ('dbx_business_glossary_term' = 'Network Layer');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `network_layer` SET TAGS ('dbx_value_regex' = 'ran|transport|core|access|aggregation|backbone');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Link Notes');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `operational_state` SET TAGS ('dbx_business_glossary_term' = 'Operational State');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `operational_state` SET TAGS ('dbx_value_regex' = 'in_service|out_of_service|maintenance|testing|degraded|failed');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `protection_scheme` SET TAGS ('dbx_business_glossary_term' = 'Protection Scheme');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `protection_scheme` SET TAGS ('dbx_value_regex' = 'none|1+1|1:1|1:n|ring|mesh');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `sla_target_availability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Availability Percentage');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `source_interface_name` SET TAGS ('dbx_business_glossary_term' = 'Source Interface Name');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `technology_standard` SET TAGS ('dbx_business_glossary_term' = 'Technology Standard');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Link Utilization Percentage');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `vlan_number` SET TAGS ('dbx_business_glossary_term' = 'Virtual Local Area Network (VLAN) Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` SET TAGS ('dbx_subdomain' = 'network_inventory');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `ran_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Radio Access Network (RAN) Cell Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `e911_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'E911 Compliance Record Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Base Station Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `enterprise_site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Work Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `spectrum_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Spectrum Allocation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Network Site Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Network Equipment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `network_qos_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Qos Profile Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Rf Engineer Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Serving Subscriber Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `spectrum_license_id` SET TAGS ('dbx_business_glossary_term' = 'Spectrum License Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `administrative_state` SET TAGS ('dbx_business_glossary_term' = 'Administrative State');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `administrative_state` SET TAGS ('dbx_value_regex' = 'unlocked|locked|shutting_down');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `antenna_height_meters` SET TAGS ('dbx_business_glossary_term' = 'Antenna Height Above Ground Level (Meters)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `azimuth_degrees` SET TAGS ('dbx_business_glossary_term' = 'Antenna Azimuth (Degrees)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `bandwidth_mhz` SET TAGS ('dbx_business_glossary_term' = 'Channel Bandwidth (MHz)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `beamforming_enabled` SET TAGS ('dbx_business_glossary_term' = 'Beamforming Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `carrier_aggregation_enabled` SET TAGS ('dbx_business_glossary_term' = 'Carrier Aggregation (CA) Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `carrier_frequency_mhz` SET TAGS ('dbx_business_glossary_term' = 'Carrier Frequency (MHz)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `cell_activation_date` SET TAGS ('dbx_business_glossary_term' = 'Cell Activation Date');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `cell_capacity_users` SET TAGS ('dbx_business_glossary_term' = 'Cell Capacity (Maximum Concurrent Users)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `cell_deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Cell Deactivation Date');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `cell_global_identity` SET TAGS ('dbx_business_glossary_term' = 'Cell Global Identity (CGI) / New Radio Cell Identity (NCI)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `cell_name` SET TAGS ('dbx_business_glossary_term' = 'RAN Cell Name');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `cell_operational_state` SET TAGS ('dbx_business_glossary_term' = 'Cell Operational State');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `cell_operational_state` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|maintenance|testing|planned');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `channel_number` SET TAGS ('dbx_business_glossary_term' = 'Absolute Radio Frequency Channel Number (ARFCN/EARFCN/NR-ARFCN)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type Classification');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'outdoor|indoor|mixed');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `deployment_scenario` SET TAGS ('dbx_business_glossary_term' = 'Deployment Scenario');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `deployment_scenario` SET TAGS ('dbx_value_regex' = 'urban|suburban|rural|highway|indoor|enterprise');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `electrical_tilt_degrees` SET TAGS ('dbx_business_glossary_term' = 'Electrical Tilt (Degrees)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `energy_saving_mode` SET TAGS ('dbx_business_glossary_term' = 'Energy Saving Mode');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `energy_saving_mode` SET TAGS ('dbx_value_regex' = 'disabled|enabled|adaptive');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `equipment_model` SET TAGS ('dbx_business_glossary_term' = 'Equipment Model Designation');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `frequency_band` SET TAGS ('dbx_business_glossary_term' = 'Frequency Band Designation');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `handover_hysteresis_db` SET TAGS ('dbx_business_glossary_term' = 'Handover Hysteresis (dB)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `handover_margin_db` SET TAGS ('dbx_business_glossary_term' = 'Handover Margin (dB)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `last_configuration_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Configuration Change Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Latitude');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `load_balancing_enabled` SET TAGS ('dbx_business_glossary_term' = 'Load Balancing Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Longitude');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `maximum_cell_range_meters` SET TAGS ('dbx_business_glossary_term' = 'Maximum Cell Range (Meters)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `mechanical_tilt_degrees` SET TAGS ('dbx_business_glossary_term' = 'Mechanical Tilt (Degrees)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `mimo_configuration` SET TAGS ('dbx_business_glossary_term' = 'Multiple Input Multiple Output (MIMO) Configuration');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `mimo_configuration` SET TAGS ('dbx_value_regex' = '1x1|2x2|4x4|8x8|massive_mimo');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `physical_cell_identifier` SET TAGS ('dbx_business_glossary_term' = 'Physical Cell Identifier (PCI)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `radio_access_technology` SET TAGS ('dbx_business_glossary_term' = 'Radio Access Technology (RAT)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `radio_access_technology` SET TAGS ('dbx_value_regex' = 'GSM|UMTS|LTE|NR|CDMA|HSPA');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `sector_number` SET TAGS ('dbx_business_glossary_term' = 'Sector Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `technology_generation` SET TAGS ('dbx_business_glossary_term' = 'Radio Technology Generation');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `technology_generation` SET TAGS ('dbx_value_regex' = '2G|3G|4G|5G');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `time_to_trigger_ms` SET TAGS ('dbx_business_glossary_term' = 'Time to Trigger (Milliseconds)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `tracking_area_code` SET TAGS ('dbx_business_glossary_term' = 'Tracking Area Code (TAC) / Location Area Code (LAC)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `transmit_power_dbm` SET TAGS ('dbx_business_glossary_term' = 'Transmit Power (dBm)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Equipment Vendor Name');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` SET TAGS ('dbx_subdomain' = 'network_inventory');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `transmission_link_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Link Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `circuit_id` SET TAGS ('dbx_business_glossary_term' = 'Circuit Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `enterprise_site_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `fiber_cable_id` SET TAGS ('dbx_business_glossary_term' = 'Fiber Cable Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `fiber_lease_id` SET TAGS ('dbx_business_glossary_term' = 'Leased Circuit Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Provider Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'A-End Site Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'A-End Equipment Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `sla_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `a_end_port` SET TAGS ('dbx_business_glossary_term' = 'A-End Port Designation');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `alarm_severity_threshold` SET TAGS ('dbx_business_glossary_term' = 'Alarm Severity Threshold');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `alarm_severity_threshold` SET TAGS ('dbx_value_regex' = 'critical|major|minor|warning|informational');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `attenuation_db` SET TAGS ('dbx_business_glossary_term' = 'Link Attenuation in Decibels (dB)');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `capacity_value` SET TAGS ('dbx_business_glossary_term' = 'Link Capacity Value');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Link Commissioning Date');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `decommissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Link Decommissioning Date');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `fiber_pair_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Fiber Pairs');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `fiber_type` SET TAGS ('dbx_business_glossary_term' = 'Fiber Type - Single-Mode (SMF) or Multi-Mode (MMF)');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `fiber_type` SET TAGS ('dbx_value_regex' = 'smf|mmf|not_applicable');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `geographic_route_description` SET TAGS ('dbx_business_glossary_term' = 'Geographic Route Description');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Link Latency in Milliseconds (ms)');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `lease_contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract End Date');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `lease_monthly_cost` SET TAGS ('dbx_business_glossary_term' = 'Monthly Lease Cost');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `lease_monthly_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `link_identifier` SET TAGS ('dbx_business_glossary_term' = 'Link Business Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `link_name` SET TAGS ('dbx_business_glossary_term' = 'Transmission Link Name');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `link_status` SET TAGS ('dbx_business_glossary_term' = 'Link Operational Status');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `link_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_service|under_maintenance|planned|decommissioned|reserved');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `link_type` SET TAGS ('dbx_business_glossary_term' = 'Link Type');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `link_type` SET TAGS ('dbx_value_regex' = 'fiber|microwave|copper|leased_line|satellite|hybrid');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `maintenance_window` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window Schedule');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `nms_object_reference` SET TAGS ('dbx_business_glossary_term' = 'Network Management System (NMS) Object Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `nms_system` SET TAGS ('dbx_business_glossary_term' = 'Network Management System (NMS)');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operational Notes');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Owner Organization');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `protection_type` SET TAGS ('dbx_business_glossary_term' = 'Link Protection Type');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `protection_type` SET TAGS ('dbx_value_regex' = 'unprotected|one_plus_one|one_colon_one|one_colon_n|ring|mesh');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `redundancy_group_code` SET TAGS ('dbx_business_glossary_term' = 'Redundancy Group Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `right_of_way_type` SET TAGS ('dbx_business_glossary_term' = 'Right-of-Way Type');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `right_of_way_type` SET TAGS ('dbx_value_regex' = 'owned|leased|easement|public_utility|not_applicable');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `route_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Route Distance in Kilometers (km)');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `utilization_percent` SET TAGS ('dbx_business_glossary_term' = 'Link Utilization Percentage');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `vendor` SET TAGS ('dbx_business_glossary_term' = 'Equipment Vendor');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `wavelength_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Wavelengths');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `z_end_port` SET TAGS ('dbx_business_glossary_term' = 'Z-End Port Designation');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` SET TAGS ('dbx_subdomain' = 'network_inventory');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `mpls_tunnel_id` SET TAGS ('dbx_business_glossary_term' = 'MPLS (Multiprotocol Label Switching) Tunnel ID');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `fiber_cable_id` SET TAGS ('dbx_business_glossary_term' = 'Fiber Cable Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `network_qos_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Qos Profile Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Ingress Node ID');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `sla_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Tunnel Administrator Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `administrative_status` SET TAGS ('dbx_business_glossary_term' = 'Administrative Status');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `administrative_status` SET TAGS ('dbx_value_regex' = 'enabled|disabled|locked');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `affinity_bits` SET TAGS ('dbx_business_glossary_term' = 'Affinity Bits');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `auto_bandwidth_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto-Bandwidth Enabled');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `auto_bandwidth_max_mbps` SET TAGS ('dbx_business_glossary_term' = 'Auto-Bandwidth Maximum (Mbps)');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `auto_bandwidth_min_mbps` SET TAGS ('dbx_business_glossary_term' = 'Auto-Bandwidth Minimum (Mbps)');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `bandwidth_reserved_mbps` SET TAGS ('dbx_business_glossary_term' = 'Bandwidth Reserved (Mbps)');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `bandwidth_utilized_mbps` SET TAGS ('dbx_business_glossary_term' = 'Bandwidth Utilized (Mbps)');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `bytes_received` SET TAGS ('dbx_business_glossary_term' = 'Bytes Received');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `bytes_transmitted` SET TAGS ('dbx_business_glossary_term' = 'Bytes Transmitted');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `dscp_marking` SET TAGS ('dbx_business_glossary_term' = 'DSCP (Differentiated Services Code Point) Marking');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `explicit_route_path` SET TAGS ('dbx_business_glossary_term' = 'Explicit Route Path');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `failover_count` SET TAGS ('dbx_business_glossary_term' = 'Failover Count');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `holding_priority` SET TAGS ('dbx_business_glossary_term' = 'Holding Priority');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `jitter_ms` SET TAGS ('dbx_business_glossary_term' = 'Jitter (Milliseconds)');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `last_failover_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Failover Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `last_reoptimization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reoptimization Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Latency (Milliseconds)');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `lsp_identifier` SET TAGS ('dbx_business_glossary_term' = 'LSP (Label Switched Path) ID');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `metric_type` SET TAGS ('dbx_business_glossary_term' = 'Metric Type');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `metric_type` SET TAGS ('dbx_value_regex' = 'IGP|TE|delay|hop-count');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `metric_value` SET TAGS ('dbx_business_glossary_term' = 'Metric Value');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'up|down|degraded|testing|maintenance');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `packet_loss_count` SET TAGS ('dbx_business_glossary_term' = 'Packet Loss Count');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `packets_received` SET TAGS ('dbx_business_glossary_term' = 'Packets Received');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `packets_transmitted` SET TAGS ('dbx_business_glossary_term' = 'Packets Transmitted');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `path_computation_method` SET TAGS ('dbx_business_glossary_term' = 'Path Computation Method');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `path_computation_method` SET TAGS ('dbx_value_regex' = 'CSPF|PCE|manual');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `pce_address` SET TAGS ('dbx_business_glossary_term' = 'PCE (Path Computation Element) Address');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `pce_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `pce_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `protection_path` SET TAGS ('dbx_business_glossary_term' = 'Protection Path');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `protection_type` SET TAGS ('dbx_business_glossary_term' = 'Protection Type');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `protection_type` SET TAGS ('dbx_value_regex' = 'none|facility-backup|one-to-one|fast-reroute');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `reoptimization_enabled` SET TAGS ('dbx_business_glossary_term' = 'Reoptimization Enabled');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `reoptimization_interval_seconds` SET TAGS ('dbx_business_glossary_term' = 'Reoptimization Interval (Seconds)');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `setup_priority` SET TAGS ('dbx_business_glossary_term' = 'Setup Priority');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `signaling_protocol` SET TAGS ('dbx_business_glossary_term' = 'Signaling Protocol');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `signaling_protocol` SET TAGS ('dbx_value_regex' = 'RSVP-TE|LDP|BGP|Static|SR');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `tunnel_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tunnel ID Number');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `tunnel_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `tunnel_id_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `tunnel_name` SET TAGS ('dbx_business_glossary_term' = 'MPLS Tunnel Name');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `tunnel_type` SET TAGS ('dbx_business_glossary_term' = 'MPLS Tunnel Type');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `tunnel_type` SET TAGS ('dbx_value_regex' = 'LDP|RSVP-TE|SR-MPLS|MPLS-TP|BGP-LU|Static');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `uptime_seconds` SET TAGS ('dbx_business_glossary_term' = 'Uptime (Seconds)');
ALTER TABLE `telecommunication_ecm`.`network`.`mpls_tunnel` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` SET TAGS ('dbx_subdomain' = 'network_inventory');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `nfv_vnf_id` SET TAGS ('dbx_business_glossary_term' = 'Network Functions Virtualization (NFV) Virtual Network Function (VNF) Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Deployment Work Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Network Element Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Network Equipment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Vnf Administrator Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `administrative_state` SET TAGS ('dbx_business_glossary_term' = 'VNF (Virtual Network Function) Administrative State');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `administrative_state` SET TAGS ('dbx_value_regex' = 'LOCKED|UNLOCKED|SHUTTING_DOWN');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `affinity_rule` SET TAGS ('dbx_business_glossary_term' = 'VNF (Virtual Network Function) Affinity Rule');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `affinity_rule` SET TAGS ('dbx_value_regex' = 'AFFINITY|ANTI_AFFINITY|NONE');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `auto_healing_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto-Healing Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `configuration_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `configuration_status` SET TAGS ('dbx_value_regex' = 'CONFIGURED|UNCONFIGURED|CONFIGURATION_ERROR|PENDING_CONFIGURATION');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `current_scale_level` SET TAGS ('dbx_business_glossary_term' = 'Current Scale Level');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `data_plane_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Data Plane IP (Internet Protocol) Address');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `data_plane_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `deployment_flavor` SET TAGS ('dbx_business_glossary_term' = 'VNF (Virtual Network Function) Deployment Flavor');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `fault_status` SET TAGS ('dbx_business_glossary_term' = 'Fault Status');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `fault_status` SET TAGS ('dbx_value_regex' = 'NO_FAULT|MINOR_FAULT|MAJOR_FAULT|CRITICAL_FAULT');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `high_availability_mode` SET TAGS ('dbx_business_glossary_term' = 'High Availability (HA) Mode');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `high_availability_mode` SET TAGS ('dbx_value_regex' = 'ACTIVE_ACTIVE|ACTIVE_STANDBY|NONE');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `instantiation_level` SET TAGS ('dbx_business_glossary_term' = 'VNF (Virtual Network Function) Instantiation Level');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `instantiation_state` SET TAGS ('dbx_business_glossary_term' = 'VNF (Virtual Network Function) Instantiation State');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `instantiation_state` SET TAGS ('dbx_value_regex' = 'NOT_INSTANTIATED|INSTANTIATED|FAILED|TERMINATING|TERMINATED');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `instantiation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'VNF (Virtual Network Function) Instantiation Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `license_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiry Date');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `license_key` SET TAGS ('dbx_business_glossary_term' = 'VNF (Virtual Network Function) License Key');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `license_key` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'VNF (Virtual Network Function) License Type');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'PERPETUAL|SUBSCRIPTION|CAPACITY_BASED|USAGE_BASED|TRIAL');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `management_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Management IP (Internet Protocol) Address');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `management_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `max_scale_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Scale Level');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `min_scale_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Scale Level');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `monitoring_enabled` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `network_service_reference` SET TAGS ('dbx_business_glossary_term' = 'Network Service Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `nfvi_host_reference` SET TAGS ('dbx_business_glossary_term' = 'NFV Infrastructure (NFVI) Host Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `nfvo_reference` SET TAGS ('dbx_business_glossary_term' = 'NFV Orchestrator (NFVO) Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'VNF (Virtual Network Function) Notes');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `operational_state` SET TAGS ('dbx_business_glossary_term' = 'VNF (Virtual Network Function) Operational State');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `operational_state` SET TAGS ('dbx_value_regex' = 'ENABLED|DISABLED');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Performance Tier');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `performance_tier` SET TAGS ('dbx_value_regex' = 'BASIC|STANDARD|PREMIUM|ULTRA');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `redundancy_model` SET TAGS ('dbx_business_glossary_term' = 'Redundancy Model');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `redundancy_model` SET TAGS ('dbx_value_regex' = '1_PLUS_1|N_PLUS_M|LOAD_BALANCED|NONE');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `scaling_policy` SET TAGS ('dbx_business_glossary_term' = 'VNF (Virtual Network Function) Scaling Policy');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `scaling_policy` SET TAGS ('dbx_value_regex' = 'MANUAL|AUTO_SCALE_OUT|AUTO_SCALE_IN|AUTO_SCALE_BOTH|NONE');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `sla_profile` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Profile');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `termination_timestamp` SET TAGS ('dbx_business_glossary_term' = 'VNF (Virtual Network Function) Termination Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `usage_state` SET TAGS ('dbx_business_glossary_term' = 'VNF (Virtual Network Function) Usage State');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `usage_state` SET TAGS ('dbx_value_regex' = 'IDLE|ACTIVE|BUSY');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `vcpu_allocation` SET TAGS ('dbx_business_glossary_term' = 'Virtual Central Processing Unit (vCPU) Allocation');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'VNF (Virtual Network Function) Vendor Name');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `vim_reference` SET TAGS ('dbx_business_glossary_term' = 'Virtualized Infrastructure Manager (VIM) Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `vnf_instance_name` SET TAGS ('dbx_business_glossary_term' = 'VNF (Virtual Network Function) Instance Name');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `vnf_software_version` SET TAGS ('dbx_business_glossary_term' = 'VNF (Virtual Network Function) Software Version');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `vnf_type` SET TAGS ('dbx_business_glossary_term' = 'VNF (Virtual Network Function) Type');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `vnfd_reference` SET TAGS ('dbx_business_glossary_term' = 'VNF Descriptor (VNFD) Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `vnfm_reference` SET TAGS ('dbx_business_glossary_term' = 'VNF Manager (VNFM) Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `vram_allocation_gb` SET TAGS ('dbx_business_glossary_term' = 'Virtual Random Access Memory (vRAM) Allocation in Gigabytes (GB)');
ALTER TABLE `telecommunication_ecm`.`network`.`nfv_vnf` ALTER COLUMN `vstorage_allocation_gb` SET TAGS ('dbx_business_glossary_term' = 'Virtual Storage Allocation in Gigabytes (GB)');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` SET TAGS ('dbx_subdomain' = 'network_inventory');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `ip_address_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address Plan Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `ip_address_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `ip_address_plan_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Network Element Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `network_qos_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Qos Profile Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `pop_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Presence (POP) Site Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `address_space_type` SET TAGS ('dbx_business_glossary_term' = 'IP Address Space Type');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `address_space_type` SET TAGS ('dbx_value_regex' = 'public|private|reserved|carrier_grade_nat');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `address_space_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `address_space_type` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'IP Address Block Allocation Date');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `allocation_purpose` SET TAGS ('dbx_business_glossary_term' = 'IP Address Allocation Purpose');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `allocation_purpose` SET TAGS ('dbx_value_regex' = 'management|subscriber|loopback|transit|peering|infrastructure');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'IP Address Allocation Status');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'free|reserved|allocated|quarantined|deprecated');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `assigned_addresses_count` SET TAGS ('dbx_business_glossary_term' = 'Assigned IP Addresses Count');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `autonomous_system_number` SET TAGS ('dbx_business_glossary_term' = 'Autonomous System Number (ASN)');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `available_addresses_count` SET TAGS ('dbx_business_glossary_term' = 'Available IP Addresses Count');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `block_size` SET TAGS ('dbx_business_glossary_term' = 'IP Address Block Size');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `broadcast_address` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Internet Protocol (IP) Address');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `broadcast_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `broadcast_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `dhcp_pool_flag` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Host Configuration Protocol (DHCP) Pool Flag');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `dns_zone` SET TAGS ('dbx_business_glossary_term' = 'Domain Name System (DNS) Zone');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'IP Address Block Expiration Date');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `gateway_address` SET TAGS ('dbx_business_glossary_term' = 'Default Gateway Internet Protocol (IP) Address');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `gateway_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `gateway_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `ip_prefix` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Prefix in Classless Inter-Domain Routing (CIDR) Notation');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `ip_prefix` SET TAGS ('dbx_value_regex' = '^([0-9]{1,3}.){3}[0-9]{1,3}/[0-9]{1,2}$|^([0-9a-fA-F]{0,4}:){2,7}[0-9a-fA-F]{0,4}/[0-9]{1,3}$');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `ip_version` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Version');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `ip_version` SET TAGS ('dbx_value_regex' = 'IPv4|IPv6');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `ipam_source_system` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol Address Management (IPAM) Source System');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last IP Address Management (IPAM) Audit Date');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `network_function_type` SET TAGS ('dbx_business_glossary_term' = 'Network Function Type');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'IP Address Plan Notes');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `parent_prefix` SET TAGS ('dbx_business_glossary_term' = 'Parent IP Prefix in Classless Inter-Domain Routing (CIDR) Notation');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `responsible_team` SET TAGS ('dbx_business_glossary_term' = 'Responsible Network Operations Team');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `routing_domain` SET TAGS ('dbx_business_glossary_term' = 'Routing Domain');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `security_zone` SET TAGS ('dbx_business_glossary_term' = 'Network Security Zone');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `subnet_mask` SET TAGS ('dbx_business_glossary_term' = 'Subnet Mask');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `subnet_mask` SET TAGS ('dbx_value_regex' = '^([0-9]{1,3}.){3}[0-9]{1,3}$');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'IP Address Block Utilization Percentage');
ALTER TABLE `telecommunication_ecm`.`network`.`ip_address_plan` ALTER COLUMN `vlan_number` SET TAGS ('dbx_business_glossary_term' = 'Virtual Local Area Network (VLAN) Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` SET TAGS ('dbx_subdomain' = 'capacity_management');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `capacity_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Project ID');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Network Element ID');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `pop_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Pop Facility Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `available_capacity` SET TAGS ('dbx_business_glossary_term' = 'Available Capacity');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `average_utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Average Utilization Percentage');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `busy_hour_indicator` SET TAGS ('dbx_business_glossary_term' = 'Busy Hour Indicator');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `capacity_status` SET TAGS ('dbx_business_glossary_term' = 'Capacity Status');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `capacity_status` SET TAGS ('dbx_value_regex' = 'under_utilized|normal|near_threshold|congested|critical|planned_upgrade');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `collection_method` SET TAGS ('dbx_value_regex' = 'automated_polling|snmp|netconf|manual_entry|calculated|aggregated');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `committed_capacity` SET TAGS ('dbx_business_glossary_term' = 'Committed Capacity');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `congestion_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Congestion Threshold Percentage');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `critical_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Critical Threshold Percentage');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `equipment_model` SET TAGS ('dbx_business_glossary_term' = 'Equipment Model');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `forecast_date` SET TAGS ('dbx_business_glossary_term' = 'Capacity Forecast Date');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `growth_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Growth Rate Percentage');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `measurement_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement End Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `measurement_interval_minutes` SET TAGS ('dbx_business_glossary_term' = 'Measurement Interval Minutes');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `measurement_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `network_layer` SET TAGS ('dbx_business_glossary_term' = 'Network Layer');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `network_layer` SET TAGS ('dbx_value_regex' = 'access|aggregation|core|transport|edge|backhaul');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Capacity Notes');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `peak_utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Peak Utilization Percentage');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `planned_upgrade_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Upgrade Date');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `qos_class` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Class');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `qos_class` SET TAGS ('dbx_value_regex' = 'premium|standard|best_effort|guaranteed|mission_critical');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `redundancy_configuration` SET TAGS ('dbx_business_glossary_term' = 'Redundancy Configuration');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `redundancy_configuration` SET TAGS ('dbx_value_regex' = 'none|active_standby|active_active|n_plus_one|geographic_redundant');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `reservation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Capacity Reservation Percentage');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `resource_identifier` SET TAGS ('dbx_business_glossary_term' = 'Resource Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `resource_type` SET TAGS ('dbx_business_glossary_term' = 'Resource Type');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `sla_target_availability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Availability Percentage');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `technology_domain` SET TAGS ('dbx_business_glossary_term' = 'Technology Domain');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `total_capacity` SET TAGS ('dbx_business_glossary_term' = 'Total Capacity');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `unit` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `element_config_id` SET TAGS ('dbx_business_glossary_term' = 'Element Configuration ID');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Change Approver ID');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `change_record_id` SET TAGS ('dbx_business_glossary_term' = 'Change Request ID');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `config_template_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Template ID');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Network Element ID');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `planned_outage_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window ID');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `primary_element_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `primary_element_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `rollback_reference_element_config_id` SET TAGS ('dbx_business_glossary_term' = 'Rollback Reference Configuration ID');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `affected_subscribers_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Subscribers Count');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Change Approval Status');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|emergency_override');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Configuration Change Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Configuration Archived Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `automation_system` SET TAGS ('dbx_business_glossary_term' = 'Automation System');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `backup_location` SET TAGS ('dbx_business_glossary_term' = 'Configuration Backup Location');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'planned|emergency|automated|rollback');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `checksum` SET TAGS ('dbx_business_glossary_term' = 'Configuration Checksum');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `compliance_policy_version` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Version');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|exempted');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `config_description` SET TAGS ('dbx_business_glossary_term' = 'Configuration Change Description');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `config_notes` SET TAGS ('dbx_business_glossary_term' = 'Configuration Notes');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `config_parameters` SET TAGS ('dbx_business_glossary_term' = 'Configuration Parameters');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `config_source_system` SET TAGS ('dbx_business_glossary_term' = 'Configuration Source System');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `config_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `config_status` SET TAGS ('dbx_value_regex' = 'active|staged|archived|superseded|failed');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `config_type` SET TAGS ('dbx_business_glossary_term' = 'Configuration Type');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `config_type` SET TAGS ('dbx_value_regex' = 'running|startup|candidate|baseline|golden');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `config_version` SET TAGS ('dbx_business_glossary_term' = 'Configuration Version');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Configuration Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `drift_details` SET TAGS ('dbx_business_glossary_term' = 'Configuration Drift Details');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `drift_detected_flag` SET TAGS ('dbx_business_glossary_term' = 'Configuration Drift Detected Flag');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `execution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Configuration Execution Outcome');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `execution_outcome` SET TAGS ('dbx_value_regex' = 'success|partial|failed|rolled_back');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Configuration Execution Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Configuration Failure Reason');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Configuration Change Impact Assessment');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Configuration Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `network_layer` SET TAGS ('dbx_business_glossary_term' = 'Network Layer');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `noc_site_code` SET TAGS ('dbx_business_glossary_term' = 'Network Operations Center (NOC) Site Code');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `parameters_modified` SET TAGS ('dbx_business_glossary_term' = 'Parameters Modified');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Configuration Retention Period Days');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `service_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Impact Flag');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Network Element Software Version');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `technology_domain` SET TAGS ('dbx_business_glossary_term' = 'Technology Domain');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `technology_domain` SET TAGS ('dbx_value_regex' = 'ran|transport|core|access|edge|ims');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `validation_errors` SET TAGS ('dbx_business_glossary_term' = 'Configuration Validation Errors');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Validation Status');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|validation_failed|pending_validation|skipped');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `config_change_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Change ID');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `element_config_id` SET TAGS ('dbx_business_glossary_term' = 'Baseline Element Config Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `change_record_id` SET TAGS ('dbx_business_glossary_term' = 'Change Record Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Executed By Operator ID');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Executed By Technician Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Network Element ID');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `planned_outage_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window ID');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `affected_customers_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Customers Count');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `affected_services` SET TAGS ('dbx_business_glossary_term' = 'Affected Services');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `after_value` SET TAGS ('dbx_business_glossary_term' = 'After Value');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `backup_created` SET TAGS ('dbx_business_glossary_term' = 'Backup Created');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `backup_reference` SET TAGS ('dbx_business_glossary_term' = 'Backup Reference');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `before_value` SET TAGS ('dbx_business_glossary_term' = 'Before Value');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `change_notes` SET TAGS ('dbx_business_glossary_term' = 'Change Notes');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `change_priority` SET TAGS ('dbx_business_glossary_term' = 'Change Priority');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `change_priority` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|critical');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `compliance_validated` SET TAGS ('dbx_business_glossary_term' = 'Compliance Validated');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `downtime_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime Duration Minutes');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `executed_by_system` SET TAGS ('dbx_business_glossary_term' = 'Executed By System');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `incident_reference` SET TAGS ('dbx_business_glossary_term' = 'Incident Reference');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `noc_notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Network Operations Center (NOC) Notification Sent');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `parameters_modified` SET TAGS ('dbx_business_glossary_term' = 'Parameters Modified');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `rollback_reference` SET TAGS ('dbx_business_glossary_term' = 'Rollback Reference');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `scheduled_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `software_version_after` SET TAGS ('dbx_business_glossary_term' = 'Software Version After');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `software_version_before` SET TAGS ('dbx_business_glossary_term' = 'Software Version Before');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `validation_result` SET TAGS ('dbx_business_glossary_term' = 'Validation Result');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `validation_result` SET TAGS ('dbx_value_regex' = 'passed|failed|partial|not_performed');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `performance_counter_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Counter Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Network Site ID');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Network Element ID');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `pop_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Pop Facility Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `sla_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) ID');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `aggregation_method` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Method');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `aggregation_method` SET TAGS ('dbx_value_regex' = 'Sum|Average|Minimum|Maximum|Percentile|Count');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `breach_severity` SET TAGS ('dbx_business_glossary_term' = 'Breach Severity Level');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `breach_severity` SET TAGS ('dbx_value_regex' = 'Critical|Major|Minor|Warning');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'Complete|Partial|Failed|Suspect');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Collection Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `correlation_key` SET TAGS ('dbx_business_glossary_term' = 'Correlation ID');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `counter_name` SET TAGS ('dbx_business_glossary_term' = 'Performance Counter Name');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `counter_value` SET TAGS ('dbx_business_glossary_term' = 'Performance Counter Value');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `customer_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Impact Flag');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score (Percent)');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `geographic_region_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `kpi_category` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Category');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `kpi_category` SET TAGS ('dbx_value_regex' = 'RAN|Transport|Core|Access|Backhaul|Aggregation');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `kpi_name` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Name');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `kpi_value` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Value');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `measurement_interval_minutes` SET TAGS ('dbx_business_glossary_term' = 'Measurement Interval (Minutes)');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `network_layer` SET TAGS ('dbx_business_glossary_term' = 'Network Layer (OSI Model)');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `network_layer` SET TAGS ('dbx_value_regex' = 'Physical|Data Link|Network|Transport|Application');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `network_technology` SET TAGS ('dbx_business_glossary_term' = 'Network Technology Type');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `nms_system_name` SET TAGS ('dbx_business_glossary_term' = 'Network Management System (NMS) Name');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `nms_system_name` SET TAGS ('dbx_value_regex' = 'Nokia NetAct|Ericsson Network Manager|Huawei U2000|Other');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Performance Measurement Notes');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `sample_count` SET TAGS ('dbx_business_glossary_term' = 'Sample Count');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type Classification');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'Voice|Data|Video|IoT|Enterprise|Residential');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `sla_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Applicable Flag');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `threshold_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Threshold Breach Flag');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `threshold_lower_limit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Lower Limit');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `threshold_upper_limit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Upper Limit');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `traffic_direction` SET TAGS ('dbx_business_glossary_term' = 'Traffic Direction');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `traffic_direction` SET TAGS ('dbx_value_regex' = 'Uplink|Downlink|Bidirectional');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Network Equipment Vendor Name');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `vendor_name` SET TAGS ('dbx_value_regex' = 'Nokia|Ericsson|Huawei|Cisco|Juniper|Other');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `alarm_id` SET TAGS ('dbx_business_glossary_term' = 'Alarm Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Customer Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `enterprise_site_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Network Element Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Technician Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `lawful_intercept_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lawful Intercept Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `pop_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Pop Facility Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Service Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `trouble_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Trouble Ticket Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `acknowledged_by` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged By User');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `acknowledgement_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Status');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `acknowledgement_status` SET TAGS ('dbx_value_regex' = 'acknowledged|unacknowledged');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `additional_text` SET TAGS ('dbx_business_glossary_term' = 'Additional Text');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `affected_network_element_type` SET TAGS ('dbx_business_glossary_term' = 'Affected Network Element Type');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `alarm_count` SET TAGS ('dbx_business_glossary_term' = 'Alarm Count');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `alarm_description` SET TAGS ('dbx_business_glossary_term' = 'Alarm Description');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `alarm_status` SET TAGS ('dbx_business_glossary_term' = 'Alarm Status');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `alarm_status` SET TAGS ('dbx_value_regex' = 'active|acknowledged|cleared|closed');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `alarm_type` SET TAGS ('dbx_business_glossary_term' = 'Alarm Type');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `alarm_type` SET TAGS ('dbx_value_regex' = 'equipment_fault|link_down|threshold_exceeded|software_fault|configuration_error|environmental');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `clear_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alarm Clear Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `correlation_key` SET TAGS ('dbx_business_glossary_term' = 'Alarm Correlation Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `customer_impact_count` SET TAGS ('dbx_business_glossary_term' = 'Customer Impact Count');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Alarm Duration (Minutes)');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3|vendor_escalation');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'communications_alarm|quality_of_service_alarm|processing_error_alarm|equipment_alarm|environmental_alarm');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `geographic_location` SET TAGS ('dbx_business_glossary_term' = 'Geographic Location');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `identifier` SET TAGS ('dbx_business_glossary_term' = 'Alarm Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `last_occurrence_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Occurrence Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `managed_object_class` SET TAGS ('dbx_business_glossary_term' = 'Managed Object Class');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `managed_object_instance` SET TAGS ('dbx_business_glossary_term' = 'Managed Object Instance');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `network_domain` SET TAGS ('dbx_business_glossary_term' = 'Network Domain');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `network_domain` SET TAGS ('dbx_value_regex' = 'ran|transport|core|access|edge|backhaul');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `notification_identifier` SET TAGS ('dbx_business_glossary_term' = 'Notification Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `probable_cause` SET TAGS ('dbx_business_glossary_term' = 'Probable Cause');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `raise_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alarm Raise Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `resolution_code` SET TAGS ('dbx_business_glossary_term' = 'Resolution Code');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `root_cause_alarm_flag` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Alarm Flag');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `service_impact_level` SET TAGS ('dbx_business_glossary_term' = 'Service Impact Level');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `service_impact_level` SET TAGS ('dbx_value_regex' = 'service_down|service_degraded|no_service_impact|potential_impact');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Alarm Severity');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor|warning|indeterminate|cleared');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `sla_breach_type` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Type');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `source_interface` SET TAGS ('dbx_business_glossary_term' = 'Alarm Source Interface');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Alarm Source System');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `specific_problem` SET TAGS ('dbx_business_glossary_term' = 'Specific Problem');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `planned_outage_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Outage ID');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `enterprise_site_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `change_record_id` SET TAGS ('dbx_business_glossary_term' = 'Change Request ID');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Technician Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `maintenance_window_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `pop_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Pop Facility Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer ID');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `tertiary_planned_last_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By User ID');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `tertiary_planned_last_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `tertiary_planned_last_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `actual_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration Minutes');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `affected_customer_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Customer Count');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `affected_service_ids` SET TAGS ('dbx_business_glossary_term' = 'Affected Service IDs');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `backup_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Backup Verification Status');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `backup_verification_status` SET TAGS ('dbx_value_regex' = 'verified|not_verified|not_required|failed');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `cab_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Change Advisory Board (CAB) Approval Status');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `cab_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `cab_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Change Advisory Board (CAB) Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `customer_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Status');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `customer_notification_status` SET TAGS ('dbx_value_regex' = 'not_sent|scheduled|sent|acknowledged|not_required');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `customer_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `impact_severity` SET TAGS ('dbx_business_glossary_term' = 'Impact Severity');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `impact_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|minimal');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `maintenance_window_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window Type');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `maintenance_window_type` SET TAGS ('dbx_value_regex' = 'standard|emergency|extended|recurring');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `nms_system_name` SET TAGS ('dbx_business_glossary_term' = 'Network Management System (NMS) Name');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `notification_channel` SET TAGS ('dbx_value_regex' = 'email|sms|portal|ivr|push_notification|none');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `outage_name` SET TAGS ('dbx_business_glossary_term' = 'Outage Name');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `outage_outcome` SET TAGS ('dbx_business_glossary_term' = 'Outage Outcome');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `outage_outcome` SET TAGS ('dbx_value_regex' = 'successful|partially_successful|failed|rolled_back|cancelled');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `outage_outcome_notes` SET TAGS ('dbx_business_glossary_term' = 'Outage Outcome Notes');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `outage_reason` SET TAGS ('dbx_business_glossary_term' = 'Outage Reason');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `outage_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Outage Reference Number');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `outage_reference_number` SET TAGS ('dbx_value_regex' = '^PO-[0-9]{8}$');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `outage_status` SET TAGS ('dbx_business_glossary_term' = 'Outage Status');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `outage_type` SET TAGS ('dbx_business_glossary_term' = 'Outage Type');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `outage_type` SET TAGS ('dbx_value_regex' = 'maintenance|upgrade|decommission|migration|testing|emergency_planned');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `planned_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Planned Duration Minutes');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `planned_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned End Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `planned_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `post_outage_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Post-Outage Validation Status');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `post_outage_validation_status` SET TAGS ('dbx_value_regex' = 'passed|failed|in_progress|not_started');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `responsible_team` SET TAGS ('dbx_business_glossary_term' = 'Responsible Team');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `risk_assessment_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Level');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `risk_assessment_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `rollback_executed_flag` SET TAGS ('dbx_business_glossary_term' = 'Rollback Executed Flag');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `rollback_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Rollback Plan Reference');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `sla_exclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Exclusion Flag');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `sla_notification_lead_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Notification Lead Time Hours');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `vendor_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Engineer Name');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `vendor_engineer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` SET TAGS ('dbx_subdomain' = 'capacity_management');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `network_capacity_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Planner Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `spectrum_license_id` SET TAGS ('dbx_business_glossary_term' = 'Spectrum License Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `workforce_capacity_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Workforce Capacity Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `action_description` SET TAGS ('dbx_business_glossary_term' = 'Action Description');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `capacity_gap` SET TAGS ('dbx_business_glossary_term' = 'Capacity Gap');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `current_capacity_baseline` SET TAGS ('dbx_business_glossary_term' = 'Current Capacity Baseline');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `estimated_capex` SET TAGS ('dbx_business_glossary_term' = 'Estimated Capital Expenditure (CAPEX)');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `estimated_capex` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `estimated_opex_annual` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Operational Expenditure (OPEX)');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `estimated_opex_annual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `fiber_route_km` SET TAGS ('dbx_business_glossary_term' = 'Fiber Route Distance in Kilometers (km)');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Implementation Status');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `implementation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|delayed|cancelled');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `network_technology` SET TAGS ('dbx_business_glossary_term' = 'Network Technology');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `nms_system` SET TAGS ('dbx_business_glossary_term' = 'Network Management System (NMS)');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `number_of_sites` SET TAGS ('dbx_business_glossary_term' = 'Number of Sites');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Code');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Name');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `planning_horizon` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `planning_horizon` SET TAGS ('dbx_value_regex' = 'short_term|medium_term|long_term');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Plan Priority');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `projected_demand` SET TAGS ('dbx_business_glossary_term' = 'Projected Demand');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `roi_months` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Period in Months');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `sla_target_availability_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Availability Percentage');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `spectrum_band` SET TAGS ('dbx_business_glossary_term' = 'Spectrum Band');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `spectrum_bandwidth_mhz` SET TAGS ('dbx_business_glossary_term' = 'Spectrum Bandwidth in Megahertz (MHz)');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `target_network_domain` SET TAGS ('dbx_business_glossary_term' = 'Target Network Domain');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `target_network_domain` SET TAGS ('dbx_value_regex' = 'ran|transport|core|access|edge|backhaul');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `target_subscriber_capacity` SET TAGS ('dbx_business_glossary_term' = 'Target Subscriber Capacity');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `telecommunication_ecm`.`network`.`network_capacity_plan` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `sdwan_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Software-Defined Wide Area Network (SD-WAN) Policy Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Customer Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `enterprise_site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `network_qos_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Qos Profile Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Administrator Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Policy Activation Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `application_classification_rules` SET TAGS ('dbx_business_glossary_term' = 'Application Classification Rules');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `bandwidth_allocation_mbps` SET TAGS ('dbx_business_glossary_term' = 'Bandwidth Allocation Megabits Per Second (Mbps)');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Policy Creation Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `customer_vpn_reference` SET TAGS ('dbx_business_glossary_term' = 'Customer Virtual Private Network (VPN) Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `deactivated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Policy Deactivation Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `destination_network_segment` SET TAGS ('dbx_business_glossary_term' = 'Destination Network Segment');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `dscp_marking` SET TAGS ('dbx_business_glossary_term' = 'Differentiated Services Code Point (DSCP) Marking');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `encryption_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Encryption Algorithm');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `encryption_algorithm` SET TAGS ('dbx_value_regex' = 'aes_256|aes_128|ipsec|tls_1_3|none');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `encryption_required` SET TAGS ('dbx_business_glossary_term' = 'Encryption Required Flag');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `failover_revert_delay_seconds` SET TAGS ('dbx_business_glossary_term' = 'Failover Revert Delay Seconds');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `failover_trigger_condition` SET TAGS ('dbx_business_glossary_term' = 'Failover Trigger Condition');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `firewall_policy_reference` SET TAGS ('dbx_business_glossary_term' = 'Firewall Policy Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `geo_location_filter` SET TAGS ('dbx_business_glossary_term' = 'Geographic Location Filter');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `load_balancing_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Load Balancing Algorithm');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `load_balancing_algorithm` SET TAGS ('dbx_value_regex' = 'round_robin|weighted|least_latency|least_packet_loss|session_based');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `nms_object_reference` SET TAGS ('dbx_business_glossary_term' = 'Network Management System (NMS) Object Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `nms_system_source` SET TAGS ('dbx_business_glossary_term' = 'Network Management System (NMS) Source');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Policy Notes');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `path_preference` SET TAGS ('dbx_business_glossary_term' = 'Path Preference Strategy');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `path_preference` SET TAGS ('dbx_value_regex' = 'mpls_primary|broadband_primary|lte_primary|load_balanced|dynamic');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `policy_description` SET TAGS ('dbx_business_glossary_term' = 'Policy Description');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `policy_identifier` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier Code');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Policy Name');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `policy_priority` SET TAGS ('dbx_business_glossary_term' = 'Policy Priority Ranking');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Lifecycle Status');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|suspended|deprecated');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Policy Type Classification');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'traffic_steering|qos|security|failover|hybrid|application_aware');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `policy_version` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Number');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `port_range_filter` SET TAGS ('dbx_business_glossary_term' = 'Port Range Filter');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `protocol_filter` SET TAGS ('dbx_business_glossary_term' = 'Protocol Filter');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `sla_bandwidth_threshold_mbps` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Bandwidth Threshold Megabits Per Second (Mbps)');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `sla_jitter_threshold_ms` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Jitter Threshold Milliseconds');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `sla_latency_threshold_ms` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Latency Threshold Milliseconds');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `sla_packet_loss_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Packet Loss Threshold Percentage');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `source_network_segment` SET TAGS ('dbx_business_glossary_term' = 'Source Network Segment');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `time_based_activation` SET TAGS ('dbx_business_glossary_term' = 'Time-Based Activation Schedule');
ALTER TABLE `telecommunication_ecm`.`network`.`sdwan_policy` ALTER COLUMN `traffic_shaping_enabled` SET TAGS ('dbx_business_glossary_term' = 'Traffic Shaping Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `network_qos_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Profile Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `applicable_network_domain` SET TAGS ('dbx_business_glossary_term' = 'Applicable Network Domain');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `applicable_network_domain` SET TAGS ('dbx_value_regex' = 'ran|core|transport|all');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `applicable_technology` SET TAGS ('dbx_business_glossary_term' = 'Applicable Network Technology');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `applicable_technology` SET TAGS ('dbx_value_regex' = 'lte|5g_nr|volte|ims|mpls|sd_wan');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `arp_priority_level` SET TAGS ('dbx_business_glossary_term' = 'Allocation and Retention Priority (ARP) Priority Level');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `averaging_window_ms` SET TAGS ('dbx_business_glossary_term' = 'Averaging Window in Milliseconds (ms)');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `burst_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Maximum Burst Size in Bytes');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `charging_impact` SET TAGS ('dbx_business_glossary_term' = 'Charging Impact Classification');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `charging_impact` SET TAGS ('dbx_value_regex' = 'premium|standard|zero_rated|sponsored');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `configuration_template` SET TAGS ('dbx_business_glossary_term' = 'Network Configuration Template Reference');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `congestion_notification_enabled` SET TAGS ('dbx_business_glossary_term' = 'Explicit Congestion Notification (ECN) Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `dscp_value` SET TAGS ('dbx_business_glossary_term' = 'Differentiated Services Code Point (DSCP) Value');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `five_qi_value` SET TAGS ('dbx_business_glossary_term' = '5G Quality of Service (QoS) Identifier (5QI) Value');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `guaranteed_bit_rate_downlink_kbps` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Bit Rate (GBR) Downlink in Kilobits per Second (kbps)');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `guaranteed_bit_rate_uplink_kbps` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Bit Rate (GBR) Uplink in Kilobits per Second (kbps)');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `maximum_bit_rate_downlink_kbps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Bit Rate (MBR) Downlink in Kilobits per Second (kbps)');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `maximum_bit_rate_uplink_kbps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Bit Rate (MBR) Uplink in Kilobits per Second (kbps)');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `network_qos_profile_description` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Profile Description');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `packet_delay_budget_ms` SET TAGS ('dbx_business_glossary_term' = 'Packet Delay Budget in Milliseconds (ms)');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `packet_error_rate` SET TAGS ('dbx_business_glossary_term' = 'Packet Error Rate (PER)');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `preemption_capability` SET TAGS ('dbx_business_glossary_term' = 'Allocation and Retention Priority (ARP) Preemption Capability');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `preemption_capability` SET TAGS ('dbx_value_regex' = 'may_preempt|shall_not_preempt');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `preemption_vulnerability` SET TAGS ('dbx_business_glossary_term' = 'Allocation and Retention Priority (ARP) Preemption Vulnerability');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `preemption_vulnerability` SET TAGS ('dbx_value_regex' = 'preemptable|not_preemptable');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Priority Level');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Profile Code');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Profile Name');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Profile Status');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|testing');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `qci_value` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Class Identifier (QCI) Value');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `qos_class` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Traffic Class');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `qos_class` SET TAGS ('dbx_value_regex' = 'voice|video|data|best_effort|mission_critical|streaming');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `resource_type` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Resource Type');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `resource_type` SET TAGS ('dbx_value_regex' = 'gbr|non_gbr|delay_critical_gbr');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|best_effort');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `traffic_shaping_enabled` SET TAGS ('dbx_business_glossary_term' = 'Traffic Shaping Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`network`.`network_qos_profile` ALTER COLUMN `vendor_specific_parameters` SET TAGS ('dbx_business_glossary_term' = 'Vendor-Specific Quality of Service (QoS) Parameters');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` SET TAGS ('dbx_subdomain' = 'network_inventory');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `peering_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Peering Agreement Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `fiber_cable_id` SET TAGS ('dbx_business_glossary_term' = 'Fiber Cable Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Peering Coordinator Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Peering Partner Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `pop_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Presence (POP) Site Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `agreed_bandwidth_mbps` SET TAGS ('dbx_business_glossary_term' = 'Agreed Bandwidth in Megabits per Second (Mbps)');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `agreement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Peering Agreement End Date');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Peering Agreement Number');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `agreement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Peering Agreement Start Date');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Peering Agreement Status');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated|pending_renewal');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `bgp_asn_local` SET TAGS ('dbx_business_glossary_term' = 'Border Gateway Protocol (BGP) Autonomous System Number (ASN) - Local');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `bgp_asn_remote` SET TAGS ('dbx_business_glossary_term' = 'Border Gateway Protocol (BGP) Autonomous System Number (ASN) - Remote');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `bgp_session_state` SET TAGS ('dbx_business_glossary_term' = 'Border Gateway Protocol (BGP) Session State');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `bgp_session_state` SET TAGS ('dbx_value_regex' = 'idle|connect|active|opensent|openconfirm|established');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `commercial_terms_reference` SET TAGS ('dbx_business_glossary_term' = 'Commercial Terms Reference');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `commercial_terms_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `ixp_name` SET TAGS ('dbx_business_glossary_term' = 'Internet Exchange Point (IXP) Name');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `last_session_down_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last BGP Session Down Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `last_session_up_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last BGP Session Up Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `max_prefix_limit_ipv4` SET TAGS ('dbx_business_glossary_term' = 'Maximum Prefix Limit - IPv4');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `max_prefix_limit_ipv6` SET TAGS ('dbx_business_glossary_term' = 'Maximum Prefix Limit - IPv6');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `monthly_recurring_charge` SET TAGS ('dbx_business_glossary_term' = 'Monthly Recurring Charge (MRC)');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `monthly_recurring_charge` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `noc_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Network Operations Center (NOC) Contact Email');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `noc_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `noc_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `noc_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `noc_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Network Operations Center (NOC) Contact Name');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `noc_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `noc_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `noc_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Network Operations Center (NOC) Contact Phone');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `noc_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `noc_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Peering Agreement Notes');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `peering_ipv4_address_local` SET TAGS ('dbx_business_glossary_term' = 'Peering IPv4 Address - Local');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `peering_ipv4_address_local` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `peering_ipv4_address_local` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `peering_ipv4_address_remote` SET TAGS ('dbx_business_glossary_term' = 'Peering IPv4 Address - Remote');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `peering_ipv4_address_remote` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `peering_ipv4_address_remote` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `peering_ipv6_address_local` SET TAGS ('dbx_business_glossary_term' = 'Peering IPv6 Address - Local');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `peering_ipv6_address_local` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `peering_ipv6_address_local` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `peering_ipv6_address_remote` SET TAGS ('dbx_business_glossary_term' = 'Peering IPv6 Address - Remote');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `peering_ipv6_address_remote` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `peering_ipv6_address_remote` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `peering_location` SET TAGS ('dbx_business_glossary_term' = 'Peering Location');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `peering_type` SET TAGS ('dbx_business_glossary_term' = 'Peering Type');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `peering_type` SET TAGS ('dbx_value_regex' = 'public|private|transit|settlement_free|paid');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `route_filter_policy` SET TAGS ('dbx_business_glossary_term' = 'Route Filter Policy');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `session_uptime_hours` SET TAGS ('dbx_business_glossary_term' = 'BGP Session Uptime in Hours');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `sla_availability_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Availability Percentage');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `sla_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Latency in Milliseconds (ms)');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `sla_packet_loss_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Packet Loss Percentage');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `traffic_exchange_policy` SET TAGS ('dbx_business_glossary_term' = 'Traffic Exchange Policy');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `traffic_exchange_policy` SET TAGS ('dbx_value_regex' = 'settlement_free|paid_transit|paid_peering|balanced|unbalanced');
ALTER TABLE `telecommunication_ecm`.`network`.`peering_agreement` ALTER COLUMN `traffic_ratio_policy` SET TAGS ('dbx_business_glossary_term' = 'Traffic Ratio Policy');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` SET TAGS ('dbx_subdomain' = 'network_inventory');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `ims_node_id` SET TAGS ('dbx_business_glossary_term' = 'IP Multimedia Subsystem (IMS) Node Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Ims Administrator Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Network Element Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Network Equipment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `pop_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Presence (POP) Site Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `redundancy_pair_node_id` SET TAGS ('dbx_business_glossary_term' = 'Redundancy Pair Node Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `uc_subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Uc Subscription Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `actual_availability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Actual Availability Percentage');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `administrative_status` SET TAGS ('dbx_business_glossary_term' = 'Administrative Status');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `administrative_status` SET TAGS ('dbx_value_regex' = 'enabled|disabled|locked|unlocked');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `current_registration_count` SET TAGS ('dbx_business_glossary_term' = 'Current Registration Count');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `current_session_count` SET TAGS ('dbx_business_glossary_term' = 'Current Session Count');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `decommissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Decommissioning Date');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `equipment_model` SET TAGS ('dbx_business_glossary_term' = 'Equipment Model');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `geographic_location` SET TAGS ('dbx_business_glossary_term' = 'Geographic Location');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `ims_domain_name` SET TAGS ('dbx_business_glossary_term' = 'IMS Domain Name');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `last_failure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Failure Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `maintenance_window` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `mtbf_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (MTBF) Hours');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `mttr_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time to Repair (MTTR) Hours');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Date');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `nms_object_reference` SET TAGS ('dbx_business_glossary_term' = 'Network Management System (NMS) Object Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `nms_system` SET TAGS ('dbx_business_glossary_term' = 'Network Management System (NMS) Name');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `node_identifier` SET TAGS ('dbx_business_glossary_term' = 'Node Business Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'IMS Node Name');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `node_type` SET TAGS ('dbx_business_glossary_term' = 'IMS Node Type');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_service|maintenance|testing|standby|decommissioned');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Owner Organization');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `port_number` SET TAGS ('dbx_business_glossary_term' = 'Port Number');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `redundancy_configuration` SET TAGS ('dbx_business_glossary_term' = 'Redundancy Configuration');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `redundancy_configuration` SET TAGS ('dbx_value_regex' = 'active_active|active_standby|n_plus_1|geographic_redundant|none');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `registration_capacity` SET TAGS ('dbx_business_glossary_term' = 'Registration Capacity');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `secondary_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Secondary IP Address');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `secondary_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `security_zone` SET TAGS ('dbx_business_glossary_term' = 'Security Zone');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `session_capacity` SET TAGS ('dbx_business_glossary_term' = 'Session Capacity');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `sla_target_availability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Availability Percentage');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `supported_codecs` SET TAGS ('dbx_business_glossary_term' = 'Supported Codecs');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `supported_services` SET TAGS ('dbx_business_glossary_term' = 'Supported Services');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Utilization Percentage');
ALTER TABLE `telecommunication_ecm`.`network`.`ims_node` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` SET TAGS ('dbx_subdomain' = 'capacity_management');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `slice_id` SET TAGS ('dbx_business_glossary_term' = 'Network Slice Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Slice Administrator Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Charging Rate Plan Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `network_qos_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Profile Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `sla_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Tenant Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `parent_slice_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Slice Activation Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `charging_model` SET TAGS ('dbx_business_glossary_term' = 'Charging Model');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `charging_model` SET TAGS ('dbx_value_regex' = 'prepaid|postpaid|hybrid|sponsored');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `core_slice_config` SET TAGS ('dbx_business_glossary_term' = 'Core Network Slice Configuration');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `coverage_area_tac_list` SET TAGS ('dbx_business_glossary_term' = 'Coverage Area Tracking Area Code (TAC) List');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `current_ue_count` SET TAGS ('dbx_business_glossary_term' = 'Current User Equipment (UE) Count');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `decommission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Slice Decommission Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `deployment_model` SET TAGS ('dbx_business_glossary_term' = 'Deployment Model');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `deployment_model` SET TAGS ('dbx_value_regex' = 'dedicated|shared|hybrid');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `identifier` SET TAGS ('dbx_business_glossary_term' = 'Single Network Slice Selection Assistance Information (S-NSSAI) Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `identifier` SET TAGS ('dbx_value_regex' = '^S-NSSAI:[0-9A-F]{2}:[0-9A-F]{6}$');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `instantiation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Slice Instantiation Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `isolation_level` SET TAGS ('dbx_business_glossary_term' = 'Resource Isolation Level');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `isolation_level` SET TAGS ('dbx_value_regex' = 'physical|logical|none');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `lifecycle_state` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle State');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `lifecycle_state` SET TAGS ('dbx_value_regex' = 'design|test|commissioning|active|suspended|decommissioned');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `max_ue_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum User Equipment (UE) Count');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operational Notes');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `nsi_identifier` SET TAGS ('dbx_business_glossary_term' = 'Network Slice Instance (NSI) Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `nssf_instance_reference` SET TAGS ('dbx_business_glossary_term' = 'Network Slice Selection Function (NSSF) Instance Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `nst_identifier` SET TAGS ('dbx_business_glossary_term' = 'Network Slice Template (NST) Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|degraded|maintenance|failed');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `orchestrator_system` SET TAGS ('dbx_business_glossary_term' = 'Management and Orchestration (MANO) Orchestrator System');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `plmn_id_list` SET TAGS ('dbx_business_glossary_term' = 'Public Land Mobile Network (PLMN) Identifier List');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Slice Priority Level');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `ran_slice_config` SET TAGS ('dbx_business_glossary_term' = 'Radio Access Network (RAN) Slice Configuration');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `sd_value` SET TAGS ('dbx_business_glossary_term' = 'Slice Differentiator (SD) Value');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `security_policy_reference` SET TAGS ('dbx_business_glossary_term' = 'Security Policy Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `slice_name` SET TAGS ('dbx_business_glossary_term' = 'Network Slice Name');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `slice_type` SET TAGS ('dbx_business_glossary_term' = 'Network Slice Type');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `slice_type` SET TAGS ('dbx_value_regex' = 'eMBB|URLLC|mMTC|V2X|custom');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `sst_value` SET TAGS ('dbx_business_glossary_term' = 'Slice/Service Type (SST) Value');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `tenant_code` SET TAGS ('dbx_business_glossary_term' = 'Tenant Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `transport_slice_config` SET TAGS ('dbx_business_glossary_term' = 'Transport Network Slice Configuration');
ALTER TABLE `telecommunication_ecm`.`network`.`element_outage_impact` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`network`.`element_outage_impact` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `telecommunication_ecm`.`network`.`element_outage_impact` SET TAGS ('dbx_association_edges' = 'network.element,network.planned_outage');
ALTER TABLE `telecommunication_ecm`.`network`.`element_outage_impact` ALTER COLUMN `element_outage_impact_id` SET TAGS ('dbx_business_glossary_term' = 'Element Outage Impact Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`element_outage_impact` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Element Outage Impact - Network Element Id');
ALTER TABLE `telecommunication_ecm`.`network`.`element_outage_impact` ALTER COLUMN `planned_outage_id` SET TAGS ('dbx_business_glossary_term' = 'Element Outage Impact - Planned Outage Id');
ALTER TABLE `telecommunication_ecm`.`network`.`element_outage_impact` ALTER COLUMN `affected_network_element_ids` SET TAGS ('dbx_business_glossary_term' = 'Affected Network Element IDs');
ALTER TABLE `telecommunication_ecm`.`network`.`element_outage_impact` ALTER COLUMN `element_actual_downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Element Actual Downtime Duration');
ALTER TABLE `telecommunication_ecm`.`network`.`element_outage_impact` ALTER COLUMN `element_downtime_end` SET TAGS ('dbx_business_glossary_term' = 'Element Downtime End Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`element_outage_impact` ALTER COLUMN `element_downtime_start` SET TAGS ('dbx_business_glossary_term' = 'Element Downtime Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`element_outage_impact` ALTER COLUMN `element_specific_impact_severity` SET TAGS ('dbx_business_glossary_term' = 'Element-Specific Impact Severity');
ALTER TABLE `telecommunication_ecm`.`network`.`element_outage_impact` ALTER COLUMN `element_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Element Validation Status');
ALTER TABLE `telecommunication_ecm`.`network`.`element_outage_impact` ALTER COLUMN `element_validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Element Validation Completion Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`element_outage_impact` ALTER COLUMN `element_work_notes` SET TAGS ('dbx_business_glossary_term' = 'Element-Specific Work Notes');
ALTER TABLE `telecommunication_ecm`.`network`.`element_outage_impact` ALTER COLUMN `rollback_executed_for_element` SET TAGS ('dbx_business_glossary_term' = 'Element Rollback Executed Flag');
ALTER TABLE `telecommunication_ecm`.`network`.`slice_vnf_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`network`.`slice_vnf_assignment` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `telecommunication_ecm`.`network`.`slice_vnf_assignment` SET TAGS ('dbx_association_edges' = 'network.nfv_vnf,network.network_slice');
ALTER TABLE `telecommunication_ecm`.`network`.`slice_vnf_assignment` ALTER COLUMN `slice_vnf_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Slice VNF Assignment Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`slice_vnf_assignment` ALTER COLUMN `nfv_vnf_id` SET TAGS ('dbx_business_glossary_term' = 'Slice Vnf Assignment - Nfv Vnf Id');
ALTER TABLE `telecommunication_ecm`.`network`.`slice_vnf_assignment` ALTER COLUMN `sla_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Performance SLA Profile Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`slice_vnf_assignment` ALTER COLUMN `slice_id` SET TAGS ('dbx_business_glossary_term' = 'Slice Vnf Assignment - Network Slice Id');
ALTER TABLE `telecommunication_ecm`.`network`.`slice_vnf_assignment` ALTER COLUMN `amf_instance_ids` SET TAGS ('dbx_business_glossary_term' = 'Access and Mobility Management Function (AMF) Instance Identifiers');
ALTER TABLE `telecommunication_ecm`.`network`.`slice_vnf_assignment` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`slice_vnf_assignment` ALTER COLUMN `decommission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decommission Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`slice_vnf_assignment` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Operational Status');
ALTER TABLE `telecommunication_ecm`.`network`.`slice_vnf_assignment` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority Level');
ALTER TABLE `telecommunication_ecm`.`network`.`slice_vnf_assignment` ALTER COLUMN `resource_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Resource Allocation Percentage');
ALTER TABLE `telecommunication_ecm`.`network`.`slice_vnf_assignment` ALTER COLUMN `slice_specific_config_parameters` SET TAGS ('dbx_business_glossary_term' = 'Slice-Specific Configuration Parameters');
ALTER TABLE `telecommunication_ecm`.`network`.`slice_vnf_assignment` ALTER COLUMN `smf_instance_ids` SET TAGS ('dbx_business_glossary_term' = 'Session Management Function (SMF) Instance Identifiers');
ALTER TABLE `telecommunication_ecm`.`network`.`slice_vnf_assignment` ALTER COLUMN `upf_instance_ids` SET TAGS ('dbx_business_glossary_term' = 'User Plane Function (UPF) Instance Identifiers');
ALTER TABLE `telecommunication_ecm`.`network`.`slice_vnf_assignment` ALTER COLUMN `vnf_role_in_slice` SET TAGS ('dbx_business_glossary_term' = 'VNF Role in Slice');
ALTER TABLE `telecommunication_ecm`.`network`.`cell_slice_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`network`.`cell_slice_assignment` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `telecommunication_ecm`.`network`.`cell_slice_assignment` SET TAGS ('dbx_association_edges' = 'network.ran_cell,network.network_slice');
ALTER TABLE `telecommunication_ecm`.`network`.`cell_slice_assignment` ALTER COLUMN `cell_slice_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Cell Slice Assignment Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`cell_slice_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration User Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`cell_slice_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`cell_slice_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`cell_slice_assignment` ALTER COLUMN `ran_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Cell Slice Assignment - Ran Cell Id');
ALTER TABLE `telecommunication_ecm`.`network`.`cell_slice_assignment` ALTER COLUMN `slice_id` SET TAGS ('dbx_business_glossary_term' = 'Cell Slice Assignment - Network Slice Id');
ALTER TABLE `telecommunication_ecm`.`network`.`cell_slice_assignment` ALTER COLUMN `activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Slice Activation Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`cell_slice_assignment` ALTER COLUMN `admission_control_threshold` SET TAGS ('dbx_business_glossary_term' = 'Admission Control Threshold');
ALTER TABLE `telecommunication_ecm`.`network`.`cell_slice_assignment` ALTER COLUMN `allocated_prb_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocated Physical Resource Block Percentage');
ALTER TABLE `telecommunication_ecm`.`network`.`cell_slice_assignment` ALTER COLUMN `cell_slice_activation_status` SET TAGS ('dbx_business_glossary_term' = 'Cell Slice Activation Status');
ALTER TABLE `telecommunication_ecm`.`network`.`cell_slice_assignment` ALTER COLUMN `deactivation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Slice Deactivation Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`cell_slice_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`cell_slice_assignment` ALTER COLUMN `sla_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'SLA Compliance Status');
ALTER TABLE `telecommunication_ecm`.`network`.`cell_slice_assignment` ALTER COLUMN `slice_priority_level` SET TAGS ('dbx_business_glossary_term' = 'Slice Priority Level');
ALTER TABLE `telecommunication_ecm`.`network`.`circuit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`network`.`circuit` SET TAGS ('dbx_subdomain' = 'network_inventory');
ALTER TABLE `telecommunication_ecm`.`network`.`circuit` ALTER COLUMN `circuit_id` SET TAGS ('dbx_business_glossary_term' = 'Circuit Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`circuit` ALTER COLUMN `protected_by_circuit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`circuit` ALTER COLUMN `cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`circuit` ALTER COLUMN `cost` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`circuit` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`circuit` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`maintenance_window` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`network`.`maintenance_window` SET TAGS ('dbx_subdomain' = 'network_inventory');
ALTER TABLE `telecommunication_ecm`.`network`.`maintenance_window` ALTER COLUMN `maintenance_window_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`maintenance_window` ALTER COLUMN `recurring_from_maintenance_window_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`config_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`network`.`config_template` SET TAGS ('dbx_subdomain' = 'network_inventory');
ALTER TABLE `telecommunication_ecm`.`network`.`config_template` ALTER COLUMN `config_template_id` SET TAGS ('dbx_business_glossary_term' = 'Config Template Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`config_template` ALTER COLUMN `base_config_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
