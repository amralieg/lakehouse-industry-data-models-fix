-- Schema for Domain: network | Business: Telecommunication | Version: v1_mvm
-- Generated on: 2026-05-08 08:31:44

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `telecommunication_ecm`.`network` COMMENT 'SSOT for all physical and logical network infrastructure including RAN, transport, core network elements, GPON/FTTH, MPLS, SD-WAN, NFV/SDN nodes, OLT/ONT, DSLAM, BNG, BRAS, POP sites, and spectrum allocation. Governs network topology, capacity, configuration, and element lifecycle managed via Nokia NetAct, Ericsson Network Manager, and NMS/EMS platforms.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`element` (
    `element_id` BIGINT COMMENT 'Primary key for element',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Network elements (base stations, routers) are directly assessed in compliance audits (equipment type approval, security hardening, EMF certification audits). Telecom operators track which audit last a',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Asset lifecycle management and procurement processes require knowing which catalog item (hardware product) a physical network element represents. Telecom operations teams use this link for EOL trackin',
    `network_equipment_id` BIGINT COMMENT 'Foreign key linking to inventory.network_equipment. Business justification: Network inventory reconciliation and asset lifecycle management require mapping logical network elements to their physical hardware. Telecom NOC teams routinely join element records to physical equipm',
    `spectrum_license_id` BIGINT COMMENT 'Foreign key linking to compliance.spectrum_license. Business justification: Network elements (base stations, radios, antennas) operate under spectrum licenses. Telecommunications operators must track which equipment uses which spectrum authorization for regulatory audits, lic',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: Vendor support/maintenance agreement tracking: each network element is covered by a vendor support agreement governing MTTR commitments, spare parts, and on-site response. Linking element to the agree',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Vendor/supplier management: telecom operators track which partner supplied or maintains each network element for procurement, warranty claims, and vendor SLA enforcement. Domain experts universally ex',
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
    `slot_position` STRING COMMENT 'Specific slot or bay position within the rack or chassis where the network element card or module is installed.',
    `subtype` STRING COMMENT 'Detailed classification of the network element specifying the exact node type (e.g., eNodeB, gNodeB, MME, AMF, SMF, UPF, P-CSCF, S-CSCF, I-CSCF, HSS, MPLS router, OTN switch, DSLAM, BNG, BRAS, OLT, ONT, ONU, vMME, vSGW, vPGW, vBNG, vFirewall).',
    `support_contact` STRING COMMENT 'Primary technical support contact information (email or phone) for vendor support escalation related to this network element.',
    `temperature_rating_celsius` DECIMAL(18,2) COMMENT 'Maximum operating temperature rating in degrees Celsius for the network element hardware.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this network element record was last modified in the system.',
    `vcpu_count` STRING COMMENT 'Number of virtual CPU cores allocated to the virtualized network function. Applicable only when NFV indicator is true.',
    `vnfd_identifier` STRING COMMENT 'Unique identifier for the VNF Descriptor that defines the deployment and operational behavior of the virtualized network function. Applicable only when NFV indicator is true.',
    `vram_gb` DECIMAL(18,2) COMMENT 'Amount of virtual memory in gigabytes allocated to the virtualized network function. Applicable only when NFV indicator is true.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer or vendor warranty coverage for the network element expires.',
    CONSTRAINT pk_element PRIMARY KEY(`element_id`)
) COMMENT 'Unified master record for every physical and logical network element in the operators infrastructure — the Single Source of Truth for all managed network nodes. Covers RAN base stations (eNodeB, gNodeB), core network nodes (MME, AMF, SMF, UPF, IMS P-CSCF/S-CSCF/I-CSCF/HSS), transport nodes (MPLS routers, OTN switches), access nodes (DSLAM, BNG, BRAS, OLT), CPE-side ONT/ONU devices, and virtualized network functions (VNFs: vMME, vSGW, vPGW, vBNG, vFirewall). Tracks element type, subtype, vendor, model, hardware/software version, operational state, administrative state, lifecycle state, geographic location, POP site assignment, rack/slot position, management IP, and NFV-specific attributes (vCPU, vRAM, VNFD, MANO orchestrator) where applicable. Sourced from Nokia NetAct, Ericsson Network Manager, and MANO platforms. This is the foundational master entity — all other network products reference elements via FK.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`topology` (
    `topology_id` BIGINT COMMENT 'Primary key for topology',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Dedicated customer circuit ownership: MPLS VPN, SD-WAN, and private circuit topologies are provisioned for specific enterprise customer accounts. Telecom operators require this link for customer-facin',
    `element_id` BIGINT COMMENT 'Reference to the terminating network element (node) of this topology link. Represents the Z-end of the connection.',
    `fiber_cable_id` BIGINT COMMENT 'Foreign key linking to inventory.fiber_cable. Business justification: Network topology links (optical layer) map to physical fiber cables. Essential for path computation engines, restoration planning, ROADM configuration, and physical-to-logical network reconciliation i',
    `qos_profile_id` BIGINT COMMENT 'Foreign key linking to network.qos_profile. Business justification: Network topology links have QoS classifications that determine traffic prioritization and resource allocation. Currently qos_class is stored as STRING. Normalizing to qos_profile enables consistent Qo',
    `sla_contract_id` BIGINT COMMENT 'Foreign key linking to assurance.sla_contract. Business justification: Network topology paths (MPLS circuits, enterprise leased-line paths) are governed by SLA contracts. SLA breach detection and penalty calculation require knowing which contract governs a given topology',
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
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: RAN cells are dimensioned and deployed to deliver specific service products. Network planning maps cells to catalog items for coverage/capacity planning and technology roadmap decisions (5G premium vs',
    `element_id` BIGINT COMMENT 'Reference to the parent base station (eNodeB, gNodeB, NodeB, BTS) that hosts this cell. Links cell to physical network infrastructure.',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: RAN cells dedicated to enterprise private wireless (private LTE/5G campus networks) are provisioned as managed services. Linking ran_cell to managed_service enables service-level performance monitorin',
    `network_equipment_id` BIGINT COMMENT 'Foreign key linking to inventory.network_equipment. Business justification: RAN cells are hosted on physical base station equipment (RRU, BBU, RAN server). Hardware lifecycle tracking, power consumption monitoring, site surveys, and equipment-to-cell mapping for maintenance r',
    `qos_profile_id` BIGINT COMMENT 'Foreign key linking to network.qos_profile. Business justification: RAN cells have QoS configurations that determine radio resource scheduling and bearer treatment. Currently quality_of_service_class is stored as STRING. Normalizing to qos_profile enables consistent Q',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: RAN cells are subject to regulatory obligations beyond spectrum licensing — EMF exposure limits, coverage rollout mandates, technology deployment requirements. Telecom regulators impose per-cell compl',
    `site_id` BIGINT COMMENT 'Foreign key linking to enterprise.site. Business justification: RAN cells provide dedicated coverage for enterprise campus/facility sites in private LTE/5G deployments. Real business process: enterprise wireless solution design and coverage planning for corporate ',
    `sla_contract_id` BIGINT COMMENT 'Foreign key linking to assurance.sla_contract. Business justification: RAN cells provisioned for enterprise/MVNO customers are governed by SLA contracts specifying availability and coverage targets. NOC teams assess SLA breach risk during cell degradation events by refer',
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
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Transmission links (leased lines, fiber circuits, Ethernet private lines) are provisioned as catalog products. Service provisioning, product lifecycle management, and circuit inventory reporting requi',
    `site_id` BIGINT COMMENT 'Foreign key linking to enterprise.site. Business justification: Transmission links terminate at enterprise customer sites for dedicated WAN/MPLS connectivity. Core business process: enterprise circuit provisioning and inventory management for point-to-point and MP',
    `fiber_cable_id` BIGINT COMMENT 'Foreign key linking to inventory.fiber_cable. Business justification: Transmission links run over physical fiber infrastructure. Fault correlation, route diversity planning, physical path validation, maintenance scheduling, and logical-to-physical reconciliation require',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: Leased transmission link contract management: the existing FK identifies the lease provider partner, but the specific governing agreement (terms, SLA, penalties) must also be linked for billing reconc',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Transmission links are frequently leased from infrastructure partners (fiber providers, dark fiber lessors). Settlement reconciliation, invoice validation, SLA tracking, and dispute resolution require',
    `network_equipment_id` BIGINT COMMENT 'Identifier of the network element or equipment at the A-end of the transmission link (e.g., OLT, DSLAM, BNG, router).',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Transmission links (especially cross-border or right-of-way routes) are governed by specific regulatory obligations (data localization, cross-border data transfer rules, right-of-way permits). Telecom',
    `sla_contract_id` BIGINT COMMENT 'Foreign key linking to assurance.sla_contract. Business justification: Leased transmission links have specific SLA contracts with carriers for availability, latency, MTTR. Essential for breach detection, penalty calculation, and vendor performance management. Standard fo',
    `spectrum_license_id` BIGINT COMMENT 'Foreign key linking to compliance.spectrum_license. Business justification: Microwave and licensed wireless backhaul transmission links must operate under a valid spectrum license. Regulators require each licensed link to reference its authorizing spectrum license for complia',
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

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`capacity` (
    `capacity_id` BIGINT COMMENT 'Primary key for capacity',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Capacity reservations and guaranteed bandwidth allocations for enterprise customers must be tracked against their billing accounts. Essential for enterprise capacity-based billing, reservation trackin',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Capacity planning and SLA assurance for enterprise managed services requires linking capacity records to the consuming managed service. Capacity managers run at-risk managed services reports to proa',
    `element_id` BIGINT COMMENT 'Reference to the specific network element (RAN cell, OLT, BNG, MPLS node, etc.) for which capacity is being tracked.',
    `ran_cell_id` BIGINT COMMENT 'Foreign key linking to network.ran_cell. Business justification: Capacity must track RAN cell-level metrics (user capacity, spectral efficiency, load). The existing network_element_id → element covers the base station element, but ran_cell is the granular unit for ',
    `slice_id` BIGINT COMMENT 'Foreign key linking to network.slice. Business justification: 5G network slices have dedicated capacity allocations (guaranteed bit rates, max UE counts). Tracking capacity per slice is essential for slice SLA management and resource admission control. Adding sl',
    `topology_id` BIGINT COMMENT 'Foreign key linking to network.topology. Business justification: Capacity can track logical topology link capacity (MPLS paths, virtual circuits, SD-WAN overlays). topology already has link_capacity_mbps and utilization_percentage inline, but the dedicated capacity',
    `transmission_link_id` BIGINT COMMENT 'Foreign key linking to network.transmission_link. Business justification: Capacity tracks utilization and thresholds for network elements AND transmission links. The capacity table has resource_identifier and resource_type STRING fields that currently identify the resource ',
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
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: Telecom regulatory compliance and change governance require auditable records of who approved each configuration baseline. The plain-text approved_by column on element_config is a denormalized techn',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Configuration records are directly reviewed and validated during compliance audits (CIS benchmarks, NIST, regulatory equipment audits). Telecom compliance teams link each configuration snapshot to the',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Vendor configuration audit trail: element configs track vendor-supplied or vendor-applied configurations. Linking to the partner record enables vendor performance audits, compliance reviews, and accou',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Configuration changes tracked per managed service instance for change control and audit. Business process: managed service configuration management, service-specific change tracking, and compliance va',
    `element_id` BIGINT COMMENT 'Reference to the physical or logical network element (RAN node, OLT, BNG, BRAS, router, switch) that this configuration applies to. Links to the network element inventory.',
    `planned_outage_id` BIGINT COMMENT 'Reference to the scheduled maintenance window during which this configuration change was executed. Ensures changes occur during approved low-impact periods and supports SLA (Service Level Agreement) compliance tracking.',
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
    CONSTRAINT pk_element_config PRIMARY KEY(`element_config_id`)
) COMMENT 'Configuration management record for network elements — stores both the active configuration baseline AND the transactional history of all configuration changes. Baseline section: configuration version, type (running/startup/candidate), structured parameters (neighbor lists, handover thresholds, QoS policies, routing tables), compliance status. Change history section: change request reference, change type (planned/emergency/automated), parameters modified (before/after values), execution timestamp, operator/automation ID, outcome (success/partial/failed/rolled-back), rollback reference. Aligned with Nokia NetAct Configuration Management and Ericsson Network Manager. Supports configuration audit, drift detection, rollback, change management compliance, and root cause analysis.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`config_change` (
    `config_change_id` BIGINT COMMENT 'Unique identifier for the configuration change record. Primary key for the configuration change transaction.',
    `element_config_id` BIGINT COMMENT 'Foreign key linking to network.element_config. Business justification: Configuration changes are applied against a baseline configuration. This FK links each config_change transaction to the element_config baseline it modifies, enabling change impact analysis, rollback p',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: Configuration changes executed by technicians (field or NOC) require audit trail linking change to executor. Regulatory compliance (SOX, telecom audits) and change management processes mandate trackin',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Config changes impact specific managed services for incident correlation. Business process: managed service change tracking, service impact assessment, and root cause analysis linking changes to servi',
    `element_id` BIGINT COMMENT 'Identifier of the network element (RAN, core, transport, GPON, MPLS node, etc.) on which the configuration change was applied.',
    `planned_outage_id` BIGINT COMMENT 'Identifier of the scheduled maintenance window during which this configuration change was executed. Null if executed outside a maintenance window.',
    `provisioning_order_id` BIGINT COMMENT 'Foreign key linking to service.provisioning_order. Business justification: Network element config changes are triggered by service provisioning orders (activation, modification, deactivation). OSS change management and audit trails require tracing which provisioning order dr',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Telecom config changes must be validated against specific regulatory obligations (CALEA, spectrum conditions, security mandates). The existing `compliance_validated` flag on config_change requires a r',
    `trouble_ticket_id` BIGINT COMMENT 'Foreign key linking to assurance.trouble_ticket. Business justification: Config changes causing service degradation generate trouble tickets. Change management process requires linking config_change to resulting trouble_ticket for impact assessment, rollback decisions, and',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Vendor change management accountability: config changes executed by vendor engineers must link to the partner record for change advisory board (CAB) audit trails, vendor SLA accountability, and post-i',
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
    CONSTRAINT pk_config_change PRIMARY KEY(`config_change_id`)
) COMMENT 'Transactional record of every configuration change applied to a network element — the configuration change history log aligned with Nokia NetAct and Ericsson Network Manager change management. Captures change request reference, change type (planned/emergency/automated), change description, parameters modified (before/after values), execution timestamp, executed by (operator ID/automation system), change outcome (success/partial/failed/rolled-back), and rollback reference. Supports change management, compliance auditing, and root cause analysis for network incidents.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`performance_counter` (
    `performance_counter_id` BIGINT COMMENT 'Primary key for performance_counter',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Performance metrics for dedicated enterprise circuits, wholesale services require customer attribution. Real process: enterprise SLA reporting, per-customer capacity planning, wholesale billing verifi',
    `kpi_threshold_id` BIGINT COMMENT 'Foreign key linking to assurance.kpi_threshold. Business justification: Performance counters are evaluated against KPI thresholds to determine breach conditions. This is the core measurement-to-threshold relationship in telecom NOC operations — every counter value is asse',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Performance metrics collected per managed service for SLA validation and reporting. Business process: enterprise SLA measurement, service-level performance monitoring, and monthly SLA compliance repor',
    `element_id` BIGINT COMMENT 'Reference to the network element (RAN node, OLT, BNG, BRAS, core network function, transport node) that generated this performance measurement.',
    `noc_incident_id` BIGINT COMMENT 'Foreign key linking to assurance.noc_incident. Business justification: Performance counter threshold breaches (high BER, cell congestion, link saturation) trigger NOC incidents. Direct FK enables NOC incident management to identify the specific KPI measurement that trigg',
    `sla_definition_id` BIGINT COMMENT 'Foreign key linking to partner.sla_definition. Business justification: Partner SLA breach detection: performance counters measuring KPIs for MVNO, roaming, and wholesale partners must reference the governing partner SLA definition to automate threshold breach detection a',
    `ran_cell_id` BIGINT COMMENT 'Foreign key linking to network.ran_cell. Business justification: RAN performance counters (RSRP, SINR, throughput, handover success rate) are collected at the cell level, not just the element level. The existing network_element_id → element covers the base station,',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Performance metrics (E911 call completion rates, location accuracy, service availability) are measured against regulatory obligations. Telecommunications operators report compliance KPIs to regulatory',
    `sla_breach_event_id` BIGINT COMMENT 'Foreign key linking to assurance.sla_breach_event. Business justification: Performance counters are the direct measurement source triggering SLA breach events. Linking performance_counter to sla_breach_event enables direct traceability from KPI measurement to breach record, ',
    `sla_contract_id` BIGINT COMMENT 'Reference to the specific SLA contract or policy that governs the performance thresholds and reporting requirements for this measurement.',
    `slice_id` BIGINT COMMENT 'Foreign key linking to network.slice. Business justification: 5G network slice performance monitoring is a core operational requirement — slice-level KPIs (throughput, latency, availability) must be tracked against slice SLAs. Adding slice_id to performance_coun',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to customer.subscriber. Business justification: Per-subscriber QoE monitoring: performance counters measured at subscriber granularity (per-MSISDN throughput, latency, packet loss) are used for subscriber-level SLA reporting, churn prediction model',
    `svc_instance_id` BIGINT COMMENT 'Foreign key linking to service.svc_instance. Business justification: Per-service KPI monitoring and SLA performance reporting require performance counters to be associated with specific service instances. This enables automated SLA breach detection at the service level',
    `topology_id` BIGINT COMMENT 'Foreign key linking to network.topology. Business justification: Logical topology segments (MPLS LSPs, SD-WAN tunnels, virtual circuits) generate PM counters for latency, packet loss, and jitter. Adding topology_id to performance_counter enables topology-level perf',
    `transmission_link_id` BIGINT COMMENT 'Foreign key linking to network.transmission_link. Business justification: Transmission link performance counters (BER, attenuation, latency, utilization) are collected from transport network elements. Adding transmission_link_id to performance_counter enables direct link-le',
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
    `site_id` BIGINT COMMENT 'Foreign key linking to enterprise.site. Business justification: Alarms affecting enterprise sites drive customer impact assessment and notification. Business process: enterprise customer notification, site-level fault correlation, and proactive outage communicatio',
    `element_id` BIGINT COMMENT 'Foreign key reference to the network element (RAN node, OLT, BNG, BRAS, router, switch, etc.) that raised the alarm or is affected by the fault condition.',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to customer.subscriber. Business justification: NOC subscriber impact analysis: when a VoLTE drop, data session failure, or RAN alarm fires, operators must identify the specific affected subscriber for proactive notification, SLA breach tracking, a',
    `team_id` BIGINT COMMENT 'Foreign key linking to workforce.team. Business justification: Major network alarms in telecom are assigned to field teams for crew dispatch, not only individual technicians. Team-level alarm assignment supports NOC workload dashboards, escalation routing, and SL',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: Network alarms require technician assignment for investigation and resolution in NOC/field operations. Critical for alarm lifecycle management, SLA tracking, and workforce utilization reporting in tel',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: CPE faults (router failures, ONT signal loss, modem offline) generate alarms in the NMS. Telecom NOC teams need direct alarm-to-CPE linkage for customer fault management, field dispatch, and SLA breac',
    `lawful_intercept_order_id` BIGINT COMMENT 'Foreign key linking to compliance.lawful_intercept_order. Business justification: Alarms on network elements provisioned for lawful intercept must be tracked for chain-of-custody and audit requirements. Law enforcement agencies require notification of service disruptions affecting ',
    `planned_outage_id` BIGINT COMMENT 'Foreign key linking to network.planned_outage. Business justification: Alarms raised during a planned maintenance window must be correlated with the outage to suppress false escalations and correctly classify alarm severity. Adding planned_outage_id to alarm enables main',
    `poi_id` BIGINT COMMENT 'Foreign key linking to interconnect.poi. Business justification: Alarms on interconnect Points of Interconnect require immediate carrier notification and are tracked separately in NOC workflows. Direct alarm→poi FK enables interconnect-specific alarm dashboards, ca',
    `problem_record_id` BIGINT COMMENT 'Foreign key linking to assurance.problem_record. Business justification: Recurring alarms on the same element are escalated to problem records for root cause analysis under ITIL problem management. Direct FK enables NOC teams to identify chronic alarm patterns and link the',
    `slice_id` BIGINT COMMENT 'Foreign key linking to network.slice. Business justification: Network alarms can be raised at the 5G slice level (slice degradation, SLA breach, resource exhaustion). Adding slice_id to alarm enables slice-aware fault management, supporting tenant notification w',
    `svc_instance_id` BIGINT COMMENT 'Foreign key reference to the service instance impacted by this alarm. Used to correlate network faults with customer-facing service degradation and SLA breach detection.',
    `config_change_id` BIGINT COMMENT 'Foreign key linking to network.config_change. Business justification: Configuration changes frequently trigger network alarms (service disruption, interface flap, routing instability). The config_change table has incident_reference as a STRING field, but a proper FK fro',
    `acknowledged_by` STRING COMMENT 'The username or identifier of the NOC operator or engineer who acknowledged the alarm. Used for accountability and audit trail.',
    `acknowledged_timestamp` TIMESTAMP COMMENT 'The date and time when the alarm was acknowledged by NOC staff. Used to measure response time from alarm raise to acknowledgement.',
    `acknowledgement_status` STRING COMMENT 'Indicates whether the alarm has been acknowledged by NOC operations staff. Acknowledged alarms are under active investigation or remediation.. Valid values are `acknowledged|unacknowledged`',
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
    `site_id` BIGINT COMMENT 'Foreign key linking to enterprise.site. Business justification: Planned outages affecting enterprise sites require customer notification per contract. Business process: enterprise maintenance notification, site-level outage scheduling, and SLA exclusion window coo',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to interconnect.carrier. Business justification: Planned outages affecting interconnect circuits require mandatory carrier notification per carrier agreements and regulatory obligations. Operations teams must identify which interconnect carrier to n',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to workforce.work_order. Business justification: Telecom change management (ITIL) requires a work order to execute every planned maintenance outage. Linking planned_outage to its execution work_order enables outage-to-field-activity traceability, po',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: Planned outages require lead technician assignment for execution oversight beyond general employee_id. Field operations need to identify skilled technician responsible for outage execution, rollback d',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Planned outages must be linked to affected managed services for contractual customer notification, SLA exclusion clause application, and change advisory board approvals. The existing enterprise_site F',
    `element_id` BIGINT COMMENT 'Foreign key linking to network.element. Business justification: A planned outage is scheduled for a specific network element (router, switch, OLT, BTS). The planned_outage table currently has affected_service_ids as a STRING field but no direct FK to the element b',
    `network_equipment_id` BIGINT COMMENT 'Foreign key linking to inventory.network_equipment. Business justification: Planned maintenance outages target specific physical equipment for hardware upgrades, firmware updates, and replacements. Maintenance scheduling systems require direct linkage to physical asset record',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: Contractual maintenance window compliance: planned outages on leased or vendor-managed infrastructure must reference the governing partner agreement to validate that the outage falls within contracted',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Vendor-executed maintenance accountability: planned outages performed by vendor engineers must link to the partner record for SLA exclusion processing, vendor performance tracking, and post-outage aud',
    `poi_id` BIGINT COMMENT 'Foreign key linking to interconnect.poi. Business justification: Planned outages on Points of Interconnect are a distinct operational category requiring specific carrier coordination and regulatory filing. Linking planned_outage directly to poi enables POI-level ou',
    `ran_cell_id` BIGINT COMMENT 'Foreign key linking to network.ran_cell. Business justification: RAN cell maintenance (antenna work, software upgrades, sector reconfigurations) requires planned outages at the cell level. Adding ran_cell_id to planned_outage enables cell-specific maintenance sched',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Planned outages are often executed to fulfill regulatory obligations (mandatory security patching, equipment recertification, spectrum refarming mandates). Linking the outage directly to the driving r',
    `team_id` BIGINT COMMENT 'Foreign key linking to workforce.team. Business justification: Planned outages in telecom are executed by field teams, not just a lead technician. Team-level outage assignment drives workload planning, SLA accountability reports, and crew scheduling. The existing',
    `sla_contract_id` BIGINT COMMENT 'Foreign key linking to assurance.sla_contract. Business justification: Planned outages must be evaluated against SLA contracts to determine if they fall within maintenance exclusion windows. The sla_exclusion_flag on planned_outage requires knowing which SLA contract app',
    `transmission_link_id` BIGINT COMMENT 'Foreign key linking to network.transmission_link. Business justification: Planned outages frequently cover transmission link maintenance (fiber splicing, microwave realignment, wavelength regrooming). Adding transmission_link_id to planned_outage directly links maintenance ',
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
    `risk_assessment_level` STRING COMMENT 'Pre-outage risk assessment classification based on complexity, customer impact, and technical risk: low (routine), medium (moderate risk), high (significant risk), critical (high-risk requiring executive approval).. Valid values are `low|medium|high|critical`',
    `rollback_executed_flag` BOOLEAN COMMENT 'Boolean indicator whether the rollback plan was executed during this planned outage (True = rollback performed, False = no rollback needed).',
    `rollback_plan_reference` STRING COMMENT 'Reference identifier or document location for the rollback procedure to be executed if the planned outage encounters critical issues requiring service restoration to previous state.',
    `sla_exclusion_flag` BOOLEAN COMMENT 'Boolean indicator whether this planned outage window is excluded from SLA availability calculations (True = excluded from SLA, False = counted against SLA).',
    `sla_notification_lead_time_hours` STRING COMMENT 'Number of hours advance notice provided to customers before the planned outage, used to verify compliance with SLA notification requirements.',
    `vendor_engineer_name` STRING COMMENT 'Name of the vendor engineer or technician supporting the planned outage execution, if vendor support is required.',
    CONSTRAINT pk_planned_outage PRIMARY KEY(`planned_outage_id`)
) COMMENT 'Transactional record of planned maintenance windows and scheduled outages — the maintenance scheduling record for NOC coordination. Captures outage reference, type (maintenance/upgrade/decommission/migration/testing), affected elements and services, planned and actual start/end datetimes, outage reason, responsible team, customer notification status, SLA exclusion flag, rollback plan reference, and outcome. Supports NOC scheduling, SLA exclusion window management, change advisory board (CAB) approvals, and customer impact communication.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`qos_profile` (
    `qos_profile_id` BIGINT COMMENT 'Unique identifier for the QoS profile. Primary key for the QoS profile master reference.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: QoS profiles implement product-specific SLA commitments. Different catalog items (premium vs basic broadband, voice vs video) map to distinct QoS profiles for bandwidth guarantees, latency budgets, an',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: QoS profiles are mandated by regulatory obligations (net neutrality rules, emergency services QoS requirements, wholesale access QoS mandates). Telecom operators must demonstrate each QoS profile meet',
    `sla_contract_id` BIGINT COMMENT 'Foreign key linking to assurance.sla_contract. Business justification: QoS profiles define the technical parameters implementing SLA commitments (guaranteed bit rates, latency, packet loss). Linking network_qos_profile to sla_contract enables service design validation — ',
    `spec_id` BIGINT COMMENT 'Foreign key linking to product.spec. Business justification: QoS profiles implement the technical parameters defined in product specs (latency, bandwidth, qos_class). Product management and network engineering use this mapping to ensure product specs are correc',
    `applicable_network_domain` STRING COMMENT 'Network domain where this QoS profile is enforced. RAN for radio access network, Core for packet core (EPC/5GC), Transport for IP/MPLS backhaul, All for end-to-end enforcement.. Valid values are `ran|core|transport|all`',
    `applicable_technology` STRING COMMENT 'Network technology or service platform where this QoS profile is applicable. Supports LTE, 5G NR, VoLTE, IMS, MPLS, SD-WAN and other technology-specific QoS implementations.. Valid values are `lte|5g_nr|volte|ims|mpls|sd_wan`',
    `arp_priority_level` STRING COMMENT 'Allocation and Retention Priority level (1-15) used for admission control decisions. Lower values indicate higher priority for resource allocation and retention.',
    `averaging_window_ms` STRING COMMENT 'Time window in milliseconds over which bit rate guarantees and measurements are averaged for GBR bearers. Used for traffic policing and shaping calculations.',
    `burst_size_bytes` BIGINT COMMENT 'Maximum burst size in bytes allowed for traffic shaping token bucket algorithm. Defines how much traffic can exceed the sustained rate in short bursts.',
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
    CONSTRAINT pk_qos_profile PRIMARY KEY(`qos_profile_id`)
) COMMENT 'Reference master for Quality of Service (QoS) profiles and traffic class definitions applied across the network — DSCP markings, traffic shaping parameters, priority queuing configurations, and bearer QoS class identifiers (QCI/5QI for LTE/5G). Captures profile name, QoS class (voice/video/data/best-effort), DSCP value, 5QI/QCI value, guaranteed bit rate (GBR), maximum bit rate (MBR), priority level, packet delay budget, packet error rate, and applicable network domain. Used by RAN, core, and transport layers for consistent end-to-end QoS enforcement.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`slice` (
    `slice_id` BIGINT COMMENT 'Unique identifier for the 5G network slice instance. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: Network slice provisioning contract: slices provisioned for partner tenants are governed by specific agreements defining capacity, SLA, and pricing. The existing FK identifies the tenant partner; the ',
    `carrier_agreement_id` BIGINT COMMENT 'Foreign key linking to interconnect.carrier_agreement. Business justification: 5G network slices provisioned for roaming or wholesale partners are governed by carrier agreements defining SLA, QoS, and commercial terms. Linking slice to carrier_agreement enables slice-level billi',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Network slicing instantiates specific catalog items (IoT service, enterprise VPN, AR/VR). Slice orchestration systems reference catalog_item_id to apply correct SLA parameters, QoS profiles, and resou',
    `ip_address_pool_id` BIGINT COMMENT 'Foreign key linking to inventory.ip_address_pool. Business justification: 5G network slices require dedicated IP address pools for tenant traffic isolation and billing. Operators assign specific CIDR blocks to slices (e.g., enterprise slice gets a private pool). Slice IP po',
    `network_equipment_id` BIGINT COMMENT 'Foreign key linking to inventory.network_equipment. Business justification: 5G network slices are instantiated on physical network equipment (UPF, SMF, gNB). Slice-to-hardware mapping is essential for capacity planning, fault isolation, and SLA assurance. When a slice degrade',
    `parent_slice_id` BIGINT COMMENT 'Self-referencing FK on slice (parent_slice_id)',
    `qos_profile_id` BIGINT COMMENT 'Reference to the QoS profile defining 5QI, GFBR, MFBR, packet delay budget, and packet error rate parameters for this slice.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Network slices for regulated verticals (public safety, healthcare, government) are subject to distinct regulatory obligations (data sovereignty, ETSI NFV compliance, national security requirements). O',
    `sla_profile_id` BIGINT COMMENT 'Foreign key linking to service.sla_profile. Business justification: A network slice is governed by an SLA profile defining performance guarantees (latency, throughput, availability). Slice SLA enforcement, breach detection, and customer reporting all require this link',
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

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`ran_slice_assignment` (
    `ran_slice_assignment_id` BIGINT COMMENT 'Primary key for the ran_slice_assignment association',
    `ran_cell_id` BIGINT COMMENT 'Foreign key linking to the RAN cell master record to which this network slice is being assigned.',
    `slice_id` BIGINT COMMENT 'Foreign key linking to the 5G network slice master record that is being assigned to this RAN cell.',
    `activation_timestamp` TIMESTAMP COMMENT 'Date and time when this specific slice-cell binding was activated and the slice began serving traffic on this RAN cell. Distinct from the slice-level activation_timestamp which records when the slice became globally active.',
    `admission_control_policy` STRING COMMENT 'The admission control policy applied to this slice on this specific RAN cell, governing how new UE connection requests are accepted or rejected when the cell approaches capacity. Policy may differ per cell based on SLA tier and local congestion thresholds.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this RAN slice assignment record was first created in the network management system. Used for audit and lifecycle tracking.',
    `deactivation_timestamp` TIMESTAMP COMMENT 'Date and time when this slice-cell binding was deactivated. Null for currently active bindings. Used for lifecycle tracking and SLA compliance reporting of slice coverage per cell.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to this slice-cell binding record, such as a configuration update or status change.',
    `max_ue_count_for_slice_on_cell` STRING COMMENT 'Maximum number of concurrent User Equipment (devices) admitted to this slice on this specific RAN cell. This value varies per cell based on local radio conditions and resource partitioning agreements, and cannot reside on the slice master (which holds the global max_ue_count across all cells).',
    `operational_status` STRING COMMENT 'Current operational state of this specific slice-cell binding. A slice may be globally active but degraded or inactive on a specific cell due to cell outage, resource exhaustion, or maintenance. Distinct from the slice-level operational_status.',
    `slice_config_for_cell` STRING COMMENT 'JSON or XML configuration parameters defining how this network slice is configured specifically on this RAN cell — including RAN-level resource partitioning, PRB allocation, and scheduling weights. Distinct from the global core_slice_config on the slice master record.',
    CONSTRAINT pk_ran_slice_assignment PRIMARY KEY(`ran_slice_assignment_id`)
) COMMENT 'This association product represents the operational binding (Role) between a 5G network slice and a RAN cell. It captures the per-cell slice configuration, admission control policy, UE capacity allocation, and lifecycle state of each slice-cell binding as managed by the NSSF and RAN slice management systems per 3GPP TS 28.541. Each record links one network slice to one RAN cell and carries attributes that exist only in the context of this specific binding — they cannot reside on either the slice master or the ran_cell master.. Existence Justification: In 5G network operations, a single network slice (e.g., a URLLC slice for an enterprise customer) is deployed across MULTIPLE RAN cells to provide geographic coverage, and a single RAN cell simultaneously serves MULTIPLE active slices (eMBB, URLLC, mMTC) through RAN slicing. This is a first-class operational concept managed by the NSSF and RAN slice management systems, explicitly defined in 3GPP TS 28.541 as RAN Slice Subnet management. Telecom operators actively create, modify, and deactivate these slice-cell bindings in their NMS/EMS platforms as part of slice lifecycle management.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`network`.`slice_element_assignment` (
    `slice_element_assignment_id` BIGINT COMMENT 'Primary key for the slice_element_assignment association',
    `element_id` BIGINT COMMENT 'Foreign key linking to the physical or virtual network element assigned to this slice.',
    `slice_id` BIGINT COMMENT 'Foreign key linking to the 5G network slice that this element is assigned to.',
    `activation_timestamp` TIMESTAMP COMMENT 'Date and time when this network element was activated and bound to this slice by the MANO orchestrator. Distinct from the slices own activation_timestamp and the elements activation_date — this records when the specific binding became operational.',
    `element_role_in_slice` STRING COMMENT 'The functional role this network element plays within the slice (e.g., AMF, SMF, UPF, RAN_NODE, TRANSPORT). A single element may serve different roles in different slices. Sourced from MANO orchestrator assignment records.',
    `operational_status` STRING COMMENT 'Current operational health of this element within the context of this specific slice. An element may be ACTIVE in one slice and DEGRADED in another if partial resource contention exists. Belongs to the binding, not to either entity alone.',
    `resource_allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of this network elements total capacity allocated to this specific slice. Used for resource isolation enforcement and SLA compliance reporting. Belongs to the binding, not to either entity alone.',
    `slice_specific_config` STRING COMMENT 'JSON or XML configuration parameters applied to this network element specifically for this slice binding (e.g., per-slice QoS policies, NSSAI routing rules, slice-aware scheduling weights). Distinct from the elements global configuration and the slices core_slice_config.',
    CONSTRAINT pk_slice_element_assignment PRIMARY KEY(`slice_element_assignment_id`)
) COMMENT 'This association product represents the operational binding (Role/Assignment) between a 5G network slice and a physical or virtual network element. It captures the MANO-managed assignment of network functions and infrastructure elements to specific slices, per 3GPP TS 28.530 Network Slice Subnet Instance to Network Function mapping. Each record links one slice to one element and carries attributes that exist only in the context of this specific binding: the elements functional role within the slice, its allocated resource share, its per-slice operational status, and its slice-specific configuration. Network engineers actively create, modify, and decommission these records during slice lifecycle operations.. Existence Justification: In 5G SA (Standalone) networks, a single network slice (identified by S-NSSAI) is composed of multiple physical and virtual network elements (gNodeBs, AMF, SMF, UPF, transport nodes, etc.), and a single network element can participate in multiple slices simultaneously — this is the foundational principle of network slicing per 3GPP TS 28.530. Operators actively manage these slice-to-element bindings in MANO orchestrators (Nokia CloudBand, Ericsson Cloud Manager) as explicit operational records with role, resource allocation percentage, and per-element slice configuration. The business concept Slice Element Assignment or Network Function Slice Binding is a recognized operational entity that network engineers create, modify, and decommission as part of slice lifecycle management.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ADD CONSTRAINT `fk_network_topology_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ADD CONSTRAINT `fk_network_topology_qos_profile_id` FOREIGN KEY (`qos_profile_id`) REFERENCES `telecommunication_ecm`.`network`.`qos_profile`(`qos_profile_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ADD CONSTRAINT `fk_network_topology_source_network_element_id` FOREIGN KEY (`source_network_element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ADD CONSTRAINT `fk_network_ran_cell_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ADD CONSTRAINT `fk_network_ran_cell_qos_profile_id` FOREIGN KEY (`qos_profile_id`) REFERENCES `telecommunication_ecm`.`network`.`qos_profile`(`qos_profile_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ADD CONSTRAINT `fk_network_capacity_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ADD CONSTRAINT `fk_network_capacity_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ADD CONSTRAINT `fk_network_capacity_slice_id` FOREIGN KEY (`slice_id`) REFERENCES `telecommunication_ecm`.`network`.`slice`(`slice_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ADD CONSTRAINT `fk_network_capacity_topology_id` FOREIGN KEY (`topology_id`) REFERENCES `telecommunication_ecm`.`network`.`topology`(`topology_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ADD CONSTRAINT `fk_network_capacity_transmission_link_id` FOREIGN KEY (`transmission_link_id`) REFERENCES `telecommunication_ecm`.`network`.`transmission_link`(`transmission_link_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ADD CONSTRAINT `fk_network_element_config_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ADD CONSTRAINT `fk_network_element_config_planned_outage_id` FOREIGN KEY (`planned_outage_id`) REFERENCES `telecommunication_ecm`.`network`.`planned_outage`(`planned_outage_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ADD CONSTRAINT `fk_network_element_config_rollback_reference_element_config_id` FOREIGN KEY (`rollback_reference_element_config_id`) REFERENCES `telecommunication_ecm`.`network`.`element_config`(`element_config_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ADD CONSTRAINT `fk_network_config_change_element_config_id` FOREIGN KEY (`element_config_id`) REFERENCES `telecommunication_ecm`.`network`.`element_config`(`element_config_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ADD CONSTRAINT `fk_network_config_change_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ADD CONSTRAINT `fk_network_config_change_planned_outage_id` FOREIGN KEY (`planned_outage_id`) REFERENCES `telecommunication_ecm`.`network`.`planned_outage`(`planned_outage_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ADD CONSTRAINT `fk_network_performance_counter_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ADD CONSTRAINT `fk_network_performance_counter_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ADD CONSTRAINT `fk_network_performance_counter_slice_id` FOREIGN KEY (`slice_id`) REFERENCES `telecommunication_ecm`.`network`.`slice`(`slice_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ADD CONSTRAINT `fk_network_performance_counter_topology_id` FOREIGN KEY (`topology_id`) REFERENCES `telecommunication_ecm`.`network`.`topology`(`topology_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ADD CONSTRAINT `fk_network_performance_counter_transmission_link_id` FOREIGN KEY (`transmission_link_id`) REFERENCES `telecommunication_ecm`.`network`.`transmission_link`(`transmission_link_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ADD CONSTRAINT `fk_network_alarm_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ADD CONSTRAINT `fk_network_alarm_planned_outage_id` FOREIGN KEY (`planned_outage_id`) REFERENCES `telecommunication_ecm`.`network`.`planned_outage`(`planned_outage_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ADD CONSTRAINT `fk_network_alarm_slice_id` FOREIGN KEY (`slice_id`) REFERENCES `telecommunication_ecm`.`network`.`slice`(`slice_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ADD CONSTRAINT `fk_network_alarm_config_change_id` FOREIGN KEY (`config_change_id`) REFERENCES `telecommunication_ecm`.`network`.`config_change`(`config_change_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ADD CONSTRAINT `fk_network_planned_outage_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ADD CONSTRAINT `fk_network_planned_outage_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ADD CONSTRAINT `fk_network_planned_outage_transmission_link_id` FOREIGN KEY (`transmission_link_id`) REFERENCES `telecommunication_ecm`.`network`.`transmission_link`(`transmission_link_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ADD CONSTRAINT `fk_network_slice_parent_slice_id` FOREIGN KEY (`parent_slice_id`) REFERENCES `telecommunication_ecm`.`network`.`slice`(`slice_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ADD CONSTRAINT `fk_network_slice_qos_profile_id` FOREIGN KEY (`qos_profile_id`) REFERENCES `telecommunication_ecm`.`network`.`qos_profile`(`qos_profile_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`ran_slice_assignment` ADD CONSTRAINT `fk_network_ran_slice_assignment_ran_cell_id` FOREIGN KEY (`ran_cell_id`) REFERENCES `telecommunication_ecm`.`network`.`ran_cell`(`ran_cell_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`ran_slice_assignment` ADD CONSTRAINT `fk_network_ran_slice_assignment_slice_id` FOREIGN KEY (`slice_id`) REFERENCES `telecommunication_ecm`.`network`.`slice`(`slice_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`slice_element_assignment` ADD CONSTRAINT `fk_network_slice_element_assignment_element_id` FOREIGN KEY (`element_id`) REFERENCES `telecommunication_ecm`.`network`.`element`(`element_id`);
ALTER TABLE `telecommunication_ecm`.`network`.`slice_element_assignment` ADD CONSTRAINT `fk_network_slice_element_assignment_slice_id` FOREIGN KEY (`slice_id`) REFERENCES `telecommunication_ecm`.`network`.`slice`(`slice_id`);

-- ========= TAGS =========
ALTER SCHEMA `telecommunication_ecm`.`network` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `telecommunication_ecm`.`network` SET TAGS ('dbx_domain' = 'network');
ALTER TABLE `telecommunication_ecm`.`network`.`element` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`network`.`element` SET TAGS ('dbx_subdomain' = 'infrastructure_assets');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Element Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Network Equipment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `spectrum_license_id` SET TAGS ('dbx_business_glossary_term' = 'Spectrum License Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Support Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Partner Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `slot_position` SET TAGS ('dbx_business_glossary_term' = 'Slot Position');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'Network Element Subtype');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `support_contact` SET TAGS ('dbx_business_glossary_term' = 'Technical Support Contact');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `support_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `support_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `temperature_rating_celsius` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature Rating Celsius');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `vcpu_count` SET TAGS ('dbx_business_glossary_term' = 'Virtual Central Processing Unit (vCPU) Count');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `vnfd_identifier` SET TAGS ('dbx_business_glossary_term' = 'Virtual Network Function Descriptor (VNFD) Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `vram_gb` SET TAGS ('dbx_business_glossary_term' = 'Virtual Random Access Memory (vRAM) Gigabytes (GB)');
ALTER TABLE `telecommunication_ecm`.`network`.`element` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` SET TAGS ('dbx_subdomain' = 'infrastructure_assets');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `topology_id` SET TAGS ('dbx_business_glossary_term' = 'Topology Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Network Element Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `fiber_cable_id` SET TAGS ('dbx_business_glossary_term' = 'Fiber Cable Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `qos_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Qos Profile Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`topology` ALTER COLUMN `sla_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Contract Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` SET TAGS ('dbx_subdomain' = 'infrastructure_assets');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `ran_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Radio Access Network (RAN) Cell Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Base Station Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Network Equipment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `qos_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Qos Profile Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_cell` ALTER COLUMN `sla_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Contract Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` SET TAGS ('dbx_subdomain' = 'infrastructure_assets');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `transmission_link_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Link Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `fiber_cable_id` SET TAGS ('dbx_business_glossary_term' = 'Fiber Cable Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Provider Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'A-End Equipment Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `sla_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`transmission_link` ALTER COLUMN `spectrum_license_id` SET TAGS ('dbx_business_glossary_term' = 'Spectrum License Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` SET TAGS ('dbx_subdomain' = 'infrastructure_assets');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `capacity_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Network Element ID');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `ran_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Ran Cell Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `slice_id` SET TAGS ('dbx_business_glossary_term' = 'Slice Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `topology_id` SET TAGS ('dbx_business_glossary_term' = 'Topology Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`capacity` ALTER COLUMN `transmission_link_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Link Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` SET TAGS ('dbx_subdomain' = 'configuration_management');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `element_config_id` SET TAGS ('dbx_business_glossary_term' = 'Element Configuration ID');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Technician Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Config Vendor Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Network Element ID');
ALTER TABLE `telecommunication_ecm`.`network`.`element_config` ALTER COLUMN `planned_outage_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window ID');
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
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` SET TAGS ('dbx_subdomain' = 'configuration_management');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `config_change_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Change ID');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `element_config_id` SET TAGS ('dbx_business_glossary_term' = 'Baseline Element Config Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Executed By Technician Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Network Element ID');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `planned_outage_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window ID');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `provisioning_order_id` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `trouble_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Trouble Ticket Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`config_change` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Partner Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` SET TAGS ('dbx_subdomain' = 'operational_monitoring');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `performance_counter_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Counter Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `kpi_threshold_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Threshold Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Network Element ID');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `noc_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Noc Incident Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Sla Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `ran_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Ran Cell Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `sla_breach_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Breach Event Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `sla_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) ID');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `slice_id` SET TAGS ('dbx_business_glossary_term' = 'Slice Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Svc Instance Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `topology_id` SET TAGS ('dbx_business_glossary_term' = 'Topology Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`performance_counter` ALTER COLUMN `transmission_link_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Link Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` SET TAGS ('dbx_subdomain' = 'operational_monitoring');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `alarm_id` SET TAGS ('dbx_business_glossary_term' = 'Alarm Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Network Element Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Subscriber Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Team Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Technician Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `lawful_intercept_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lawful Intercept Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `planned_outage_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Outage Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `poi_id` SET TAGS ('dbx_business_glossary_term' = 'Poi Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `problem_record_id` SET TAGS ('dbx_business_glossary_term' = 'Problem Record Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `slice_id` SET TAGS ('dbx_business_glossary_term' = 'Slice Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Service Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `config_change_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Config Change Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `acknowledged_by` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged By User');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `acknowledgement_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Status');
ALTER TABLE `telecommunication_ecm`.`network`.`alarm` ALTER COLUMN `acknowledgement_status` SET TAGS ('dbx_value_regex' = 'acknowledged|unacknowledged');
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
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` SET TAGS ('dbx_subdomain' = 'operational_monitoring');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `planned_outage_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Outage ID');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Work Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Technician Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Network Element Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Network Equipment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Vendor Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `poi_id` SET TAGS ('dbx_business_glossary_term' = 'Poi Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `ran_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Ran Cell Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Team Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `sla_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `transmission_link_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Link Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `risk_assessment_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Level');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `risk_assessment_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `rollback_executed_flag` SET TAGS ('dbx_business_glossary_term' = 'Rollback Executed Flag');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `rollback_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Rollback Plan Reference');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `sla_exclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Exclusion Flag');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `sla_notification_lead_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Notification Lead Time Hours');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `vendor_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Engineer Name');
ALTER TABLE `telecommunication_ecm`.`network`.`planned_outage` ALTER COLUMN `vendor_engineer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` SET TAGS ('dbx_subdomain' = 'infrastructure_assets');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `qos_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Profile Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `sla_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `spec_id` SET TAGS ('dbx_business_glossary_term' = 'Spec Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `applicable_network_domain` SET TAGS ('dbx_business_glossary_term' = 'Applicable Network Domain');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `applicable_network_domain` SET TAGS ('dbx_value_regex' = 'ran|core|transport|all');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `applicable_technology` SET TAGS ('dbx_business_glossary_term' = 'Applicable Network Technology');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `applicable_technology` SET TAGS ('dbx_value_regex' = 'lte|5g_nr|volte|ims|mpls|sd_wan');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `arp_priority_level` SET TAGS ('dbx_business_glossary_term' = 'Allocation and Retention Priority (ARP) Priority Level');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `averaging_window_ms` SET TAGS ('dbx_business_glossary_term' = 'Averaging Window in Milliseconds (ms)');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `burst_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Maximum Burst Size in Bytes');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `configuration_template` SET TAGS ('dbx_business_glossary_term' = 'Network Configuration Template Reference');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `congestion_notification_enabled` SET TAGS ('dbx_business_glossary_term' = 'Explicit Congestion Notification (ECN) Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `dscp_value` SET TAGS ('dbx_business_glossary_term' = 'Differentiated Services Code Point (DSCP) Value');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `five_qi_value` SET TAGS ('dbx_business_glossary_term' = '5G Quality of Service (QoS) Identifier (5QI) Value');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `guaranteed_bit_rate_downlink_kbps` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Bit Rate (GBR) Downlink in Kilobits per Second (kbps)');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `guaranteed_bit_rate_uplink_kbps` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Bit Rate (GBR) Uplink in Kilobits per Second (kbps)');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `maximum_bit_rate_downlink_kbps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Bit Rate (MBR) Downlink in Kilobits per Second (kbps)');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `maximum_bit_rate_uplink_kbps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Bit Rate (MBR) Uplink in Kilobits per Second (kbps)');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `network_qos_profile_description` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Profile Description');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `packet_delay_budget_ms` SET TAGS ('dbx_business_glossary_term' = 'Packet Delay Budget in Milliseconds (ms)');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `packet_error_rate` SET TAGS ('dbx_business_glossary_term' = 'Packet Error Rate (PER)');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `preemption_capability` SET TAGS ('dbx_business_glossary_term' = 'Allocation and Retention Priority (ARP) Preemption Capability');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `preemption_capability` SET TAGS ('dbx_value_regex' = 'may_preempt|shall_not_preempt');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `preemption_vulnerability` SET TAGS ('dbx_business_glossary_term' = 'Allocation and Retention Priority (ARP) Preemption Vulnerability');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `preemption_vulnerability` SET TAGS ('dbx_value_regex' = 'preemptable|not_preemptable');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Priority Level');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Profile Code');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Profile Name');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Profile Status');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|testing');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `qci_value` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Class Identifier (QCI) Value');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `qos_class` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Traffic Class');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `qos_class` SET TAGS ('dbx_value_regex' = 'voice|video|data|best_effort|mission_critical|streaming');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `resource_type` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Resource Type');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `resource_type` SET TAGS ('dbx_value_regex' = 'gbr|non_gbr|delay_critical_gbr');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|best_effort');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `traffic_shaping_enabled` SET TAGS ('dbx_business_glossary_term' = 'Traffic Shaping Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`network`.`qos_profile` ALTER COLUMN `vendor_specific_parameters` SET TAGS ('dbx_business_glossary_term' = 'Vendor-Specific Quality of Service (QoS) Parameters');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` SET TAGS ('dbx_subdomain' = 'infrastructure_assets');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `slice_id` SET TAGS ('dbx_business_glossary_term' = 'Network Slice Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Slice Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Address Pool Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Network Equipment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `parent_slice_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `qos_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Profile Identifier');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`network`.`slice` ALTER COLUMN `sla_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Profile Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`network`.`ran_slice_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_slice_assignment` SET TAGS ('dbx_subdomain' = 'configuration_management');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_slice_assignment` SET TAGS ('dbx_association_edges' = 'network.slice,network.ran_cell');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_slice_assignment` ALTER COLUMN `ran_slice_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Ran Slice Assignment - Ran Slice Assignment Id');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_slice_assignment` ALTER COLUMN `ran_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Ran Slice Assignment - Ran Cell Id');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_slice_assignment` ALTER COLUMN `slice_id` SET TAGS ('dbx_business_glossary_term' = 'Ran Slice Assignment - Slice Id');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_slice_assignment` ALTER COLUMN `activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cell Slice Activation Time');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_slice_assignment` ALTER COLUMN `admission_control_policy` SET TAGS ('dbx_business_glossary_term' = 'Cell Slice Admission Control Policy');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_slice_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Record Creation Time');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_slice_assignment` ALTER COLUMN `deactivation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cell Slice Deactivation Time');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_slice_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Last Modified Time');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_slice_assignment` ALTER COLUMN `max_ue_count_for_slice_on_cell` SET TAGS ('dbx_business_glossary_term' = 'Per-Cell Slice UE Admission Cap');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_slice_assignment` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Cell Slice Binding Operational Status');
ALTER TABLE `telecommunication_ecm`.`network`.`ran_slice_assignment` ALTER COLUMN `slice_config_for_cell` SET TAGS ('dbx_business_glossary_term' = 'Per-Cell Slice Configuration');
ALTER TABLE `telecommunication_ecm`.`network`.`slice_element_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`network`.`slice_element_assignment` SET TAGS ('dbx_subdomain' = 'configuration_management');
ALTER TABLE `telecommunication_ecm`.`network`.`slice_element_assignment` SET TAGS ('dbx_association_edges' = 'network.slice,network.element');
ALTER TABLE `telecommunication_ecm`.`network`.`slice_element_assignment` ALTER COLUMN `slice_element_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Slice Element Assignment - Slice Element Assignment Id');
ALTER TABLE `telecommunication_ecm`.`network`.`slice_element_assignment` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Slice Element Assignment - Element Id');
ALTER TABLE `telecommunication_ecm`.`network`.`slice_element_assignment` ALTER COLUMN `slice_id` SET TAGS ('dbx_business_glossary_term' = 'Slice Element Assignment - Slice Id');
ALTER TABLE `telecommunication_ecm`.`network`.`slice_element_assignment` ALTER COLUMN `activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Activation Timestamp');
ALTER TABLE `telecommunication_ecm`.`network`.`slice_element_assignment` ALTER COLUMN `element_role_in_slice` SET TAGS ('dbx_business_glossary_term' = 'Element Role in Slice');
ALTER TABLE `telecommunication_ecm`.`network`.`slice_element_assignment` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Operational Status');
ALTER TABLE `telecommunication_ecm`.`network`.`slice_element_assignment` ALTER COLUMN `resource_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Resource Allocation Percentage');
ALTER TABLE `telecommunication_ecm`.`network`.`slice_element_assignment` ALTER COLUMN `slice_specific_config` SET TAGS ('dbx_business_glossary_term' = 'Slice-Specific Element Configuration');
