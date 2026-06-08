-- Schema for Domain: service | Business: Telecommunication | Version: v1_mvm
-- Generated on: 2026-05-08 08:31:46

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `telecommunication_ecm`.`service` COMMENT 'SSOT for the logical service layer instantiated on network resources — active service instances, provisioning, activation, service configurations, SLA parameters, QoS profiles, VoLTE/IMS service state, eSIM profiles, and CPE assignments. Bridges product catalog to physical network delivery via Oracle OSM and Netcracker OSS.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `telecommunication_ecm`.`service`.`svc_instance` (
    `svc_instance_id` BIGINT COMMENT 'Unique identifier for the service instance. Primary key for the service instance entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: MVNO/wholesale service instances are governed by a specific partner agreement defining commercial terms, authorized services, and SLA obligations. Telecom operators require this link for wholesale bil',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Every service instance must be directly associated with a billing account for charge aggregation, invoice generation, dunning, and spend-limit enforcement. billing_cycle_day on svc_instance is a denor',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to product.bundle. Business justification: Bundle management, churn analysis, and billing require knowing which product bundle a service instance belongs to. Telecom operators track bundle membership to apply bundle discounts, manage component',
    `carrier_agreement_id` BIGINT COMMENT 'Foreign key linking to interconnect.carrier_agreement. Business justification: Roaming service instances are governed by a specific carrier agreement defining commercial terms, TAP/NRTRDE obligations, and settlement rates. Billing dispute resolution and roaming SLA enforcement r',
    `catalog_item_id` BIGINT COMMENT 'FK to product.catalog_item.catalog_item_id — Service instances must reference the product catalog item they instantiate for product analytics, entitlement validation, and configuration management.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to sales.channel. Business justification: The sales channel through which a service was acquired drives commission calculation, channel performance KPIs, and regulatory attribution reporting. Telecom operators track originating channel on eve',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise service instances must track the corporate account for billing consolidation, SLA enforcement, contract compliance, and account-level reporting. Critical for B2B service delivery and revenu',
    `enterprise_contract_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_contract. Business justification: Enterprise contract lifecycle management requires knowing which service instances are covered by a given contract for renewal, SLA compliance, and billing reconciliation. Telecom contract managers exp',
    `iot_deployment_id` BIGINT COMMENT 'Foreign key linking to enterprise.iot_deployment. Business justification: IoT fleet management requires tracing each IoT SIM service instance to its deployment for usage aggregation, billing, and fleet health reporting. Telecom IoT operations teams expect each service insta',
    `ip_address_pool_id` BIGINT COMMENT 'Foreign key linking to inventory.ip_address_pool. Business justification: Each service instance draws its assigned IP address from a specific IP address pool. Telecom IPAM operations require this link for pool utilization reporting, CGNAT policy enforcement, lawful intercep',
    `mvno_profile_id` BIGINT COMMENT 'Foreign key linking to partner.mvno_profile. Business justification: MVNO wholesale model requires tracking which MVNO partner owns each service instance for revenue settlement, regulatory reporting, and provisioning orchestration. Core telecom business relationship fo',
    `ont_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.ont_asset. Business justification: A fiber/FTTH service instance is delivered through a specific ONT asset installed at the customer premises. Telecom operations require this link for ONT-to-service mapping, mass outage impact assessme',
    `parent_service_instance_svc_instance_id` BIGINT COMMENT 'Reference to the parent service instance in hierarchical service scenarios (e.g., a mobile line under a family plan, or a managed service component under an enterprise contract).',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: The product price plan governs data allowances, voice minutes, overage rates, and contract terms applied to a service instance. Telecom billing and customer management systems must link service instan',
    `privacy_consent_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_consent. Business justification: GDPR, CCPA, and CPNI regulations require verified privacy consent before activating data, location, or marketing services. Linking svc_instance to privacy_consent enables compliance verification that ',
    `offering_id` BIGINT COMMENT 'Reference to the product catalog offering that defines the commercial terms and features of this service instance.',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to product.promo_offer. Business justification: Promotional offer attribution at activation is a core telecom marketing analytics and revenue assurance requirement. Linking service instances to the promo offer applied at activation enables promo re',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to sales.promotion. Business justification: A service instance may be activated under a promotional offer (e.g., 6-month discount, free device). Linking enables promotion redemption tracking, billing reconciliation of discounted rates, and mark',
    `qos_profile_id` BIGINT COMMENT 'Reference to the QoS profile defining traffic prioritization, bandwidth allocation, latency targets, and packet handling rules for this service instance.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Individual service instances may be subject to specific regulatory obligations (universal service, accessibility mandates, roaming regulations). The indirect path via sla_profile is insufficient for s',
    `sdwan_topology_id` BIGINT COMMENT 'Foreign key linking to enterprise.sdwan_topology. Business justification: SD-WAN operations require knowing which service instances (broadband, MPLS underlay links) are assigned to a topology for fault management and capacity planning. Network engineers expect direct tracea',
    `site_id` BIGINT COMMENT 'Foreign key linking to enterprise.site. Business justification: Enterprise services are delivered to specific customer sites. Required for installation coordination, SLA measurement by location, circuit provisioning, and site-level service inventory management in ',
    `sla_contract_id` BIGINT COMMENT 'Foreign key linking to assurance.sla_contract. Business justification: Each active service instance is governed by a specific SLA contract. SLA breach monitoring, penalty calculation, and customer SLA reporting all require knowing which contractual SLA commitment applies',
    `sla_profile_id` BIGINT COMMENT 'Reference to the SLA profile defining performance commitments, uptime guarantees, and remediation terms for this service instance.',
    `slice_id` BIGINT COMMENT 'Identifier of the 5G network slice allocated to this service instance. Defines the virtualized network resources and QoS characteristics for 5G services.',
    `spectrum_license_id` BIGINT COMMENT 'Foreign key linking to compliance.spectrum_license. Business justification: Wireless service instances operate on licensed spectrum. Regulators require operators to demonstrate services are delivered within licensed frequency bands and geographic areas. Linking svc_instance t',
    `subscriber_id` BIGINT COMMENT 'Reference to the individual subscriber using this service instance. May differ from account holder in multi-user scenarios.',
    `svc_location_id` BIGINT COMMENT 'Foreign key linking to service.svc_location. Business justification: For fixed-line, broadband, and fiber service instances, the service is physically delivered to a specific location. svc_location is the SSOT for service delivery addresses, infrastructure availability',
    `transmission_link_id` BIGINT COMMENT 'Foreign key linking to network.transmission_link. Business justification: Fixed-line and broadband service instances are delivered over a specific transmission link. Outage impact analysis, SLA breach detection, and capacity planning require knowing which transmission link ',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to interconnect.interconnect_carrier. Business justification: Roaming service instances must track the visited carrier for TAP file reconciliation, settlement invoice validation, and regulatory roaming reports. Essential for wholesale roaming revenue assurance.',
    `activation_timestamp` TIMESTAMP COMMENT 'Date and time when the service instance was successfully activated and became operational. Marks the start of service delivery and billing.',
    `apn` STRING COMMENT 'Access Point Name used by this mobile service instance to connect to external packet data networks. Determines routing and billing for data sessions.',
    `auto_renew` BOOLEAN COMMENT 'Indicates whether this service instance automatically renews at the end of its contract term. Controls subscription continuity and churn prevention.',
    `bandwidth_mbps` DECIMAL(18,2) COMMENT 'Provisioned bandwidth capacity for this service instance in megabits per second. Applies to broadband, FTTH, and enterprise connectivity services.',
    `cpe_serial_number` STRING COMMENT 'Serial number of the CPE device (router, modem, ONT, set-top box) assigned to this service instance. Used for inventory tracking and remote management.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this service instance record was first created in the system. Marks the beginning of the service lifecycle in the data platform.',
    `data_allowance_gb` DECIMAL(18,2) COMMENT 'Monthly or total data usage allowance for this service instance in gigabytes. Applies to mobile and IoT services with usage caps.',
    `deactivation_timestamp` TIMESTAMP COMMENT 'Date and time when the service instance was deactivated or terminated. Marks the end of service delivery and billing eligibility.',
    `external_service_code` STRING COMMENT 'Service instance identifier in the upstream provisioning or network management system. Used for cross-system reconciliation and troubleshooting.',
    `iccid` STRING COMMENT 'Unique serial number of the physical or eSIM card associated with this mobile service instance. Used for SIM lifecycle management and fraud prevention.',
    `ims_registered` BOOLEAN COMMENT 'Indicates whether this service instance is currently registered with the IMS core for VoLTE, VoIP, or RCS services.',
    `imsi` STRING COMMENT 'Unique identifier stored on the SIM card that identifies the subscriber in the mobile network core (HLR/HSS/UDM). Used for authentication and roaming.',
    `ip_address` STRING COMMENT 'Static or dynamic IP address assigned to this service instance for broadband, IoT, or enterprise connectivity services. May be IPv4 or IPv6.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this service instance record was last updated. Used for change tracking and audit trails.',
    `lifecycle_status` STRING COMMENT 'Current state of the service instance in its operational lifecycle. Controls service availability and billing eligibility.. Valid values are `pending|active|suspended|terminated|provisioning_failed|deactivated`',
    `mac_address` STRING COMMENT 'Hardware address of the Customer Premises Equipment (CPE) or device associated with this service instance. Used for network access control and device tracking.',
    `msisdn` STRING COMMENT 'The telephone number assigned to this mobile service instance. Uniquely identifies the subscriber in the mobile network for voice and SMS routing.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special instructions, or customer-specific service configurations. Used by provisioning and support teams.',
    `provisioning_system` STRING COMMENT 'Name of the OSS (Operations Support System) or provisioning platform that manages this service instance (e.g., Oracle OSM, Netcracker OSS, Ericsson Network Manager).',
    `roaming_enabled` BOOLEAN COMMENT 'Indicates whether international or domestic roaming is enabled for this mobile service instance. Controls network access outside the home network.',
    `service_class` STRING COMMENT 'Business segment classification for the service instance. Drives SLA (Service Level Agreement) requirements, support tier, and billing rules.. Valid values are `consumer|enterprise|wholesale|iot|government`',
    `service_end_date` DATE COMMENT 'Contractual or scheduled end date for the service instance. Null for open-ended subscriptions.',
    `service_identifier` STRING COMMENT 'Externally visible business identifier for the service instance. May be displayed to customers on bills and portals (e.g., service number, circuit ID, subscription reference).',
    `service_start_date` DATE COMMENT 'Contractual start date for the service instance. May differ from activation timestamp for pre-scheduled or backdated services.',
    `service_type` STRING COMMENT 'Classification of the service instance by technology and delivery model. Determines provisioning workflows and network resource requirements. [ENUM-REF-CANDIDATE: mobile|broadband|ftth|voip|iptv|iot_m2m|managed_service|5g_network_slice|enterprise_connectivity|wholesale_mvno — 10 candidates stripped; promote to reference product]',
    `sms_allowance` STRING COMMENT 'Monthly SMS message allowance for this mobile service instance. Used for prepaid and postpaid plan enforcement.',
    `suspension_reason` STRING COMMENT 'Reason code for service suspension when lifecycle status is suspended. Used for operational reporting and customer communication.. Valid values are `non_payment|fraud|customer_request|regulatory|technical_issue|temporary_disconnect`',
    `technology_type` STRING COMMENT 'Underlying network technology used to deliver the service instance. Determines provisioning system integration and network resource allocation. [ENUM-REF-CANDIDATE: lte|5g_nr|volte|gpon|ftth|dsl|cable|sd_wan|mpls|ims|esim — 11 candidates stripped; promote to reference product]',
    `termination_reason` STRING COMMENT 'Reason code for service termination when lifecycle status is terminated. Critical for churn analysis and retention strategy. [ENUM-REF-CANDIDATE: customer_request|non_payment|fraud|migration|end_of_contract|regulatory|deceased — 7 candidates stripped; promote to reference product]',
    `voice_minutes_allowance` STRING COMMENT 'Monthly voice call allowance for this mobile service instance in minutes. Used for prepaid and postpaid plan enforcement.',
    `volte_enabled` BOOLEAN COMMENT 'Indicates whether VoLTE service is provisioned and active for this mobile service instance. Enables high-definition voice calls over LTE.',
    CONSTRAINT pk_svc_instance PRIMARY KEY(`svc_instance_id`)
) COMMENT 'Core master record for every active or historical logical service instance provisioned for a subscriber — mobile, broadband, FTTH, VoIP, IPTV, IoT/M2M, managed service, or 5G network slice service. SSOT for the instantiated service binding a customer account to a product catalog offering and underlying network resources. Tracks lifecycle state (pending, active, suspended, terminated), activation/deactivation timestamps, service start/end dates, assigned SLA profile, QoS profile reference, technology type, and service class (consumer, enterprise, wholesale/MVNO, IoT). Supports massive-scale IoT/M2M scenarios through bulk instance management patterns. Central entity from which all service-domain transactions and configurations radiate. Does NOT own the customer account (customer domain), the product catalog offering (product domain), or the physical network resources (network/inventory domains) — owns only the logical service instantiation and its lifecycle.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`service`.`provisioning_order` (
    `provisioning_order_id` BIGINT COMMENT 'Unique identifier for the provisioning order. Primary key for this entity.',
    `technician_id` BIGINT COMMENT 'Reference to the workforce technician or engineer assigned to resolve fallout or perform manual provisioning steps, particularly for Fiber to the Home (FTTH) or Customer Premises Equipment (CPE) installations.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Provisioning orders trigger billing account setup and activation charges. Telecom operations require billing account assignment at order creation for credit checks, deposit collection, and first-bill ',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to product.bundle. Business justification: Bundle provisioning is a named telecom business process requiring orchestration of multiple component services. Provisioning orders for triple-play or converged bundles must reference the bundle to co',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Provisioning order management requires knowing which catalog item is being activated to apply correct technology-specific provisioning steps, SLA targets, and regulatory compliance rules. Telecom OSS ',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise provisioning orders require corporate account linkage for approval workflows, credit verification, contract validation, and billing. Essential for B2B order management and fulfillment proce',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: CPE dispatch and assignment is a core step in broadband provisioning orders. The provisioning order determines which CPE asset is allocated and dispatched to the customer. Telecom field operations req',
    `enterprise_contract_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_contract. Business justification: Enterprise provisioning orders are executed under a specific contract governing pricing, SLA, and terms. Contract compliance reporting and order-to-contract traceability are standard telecom enterpris',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the originating commercial order from the order domain that triggered this provisioning work order.',
    `iot_deployment_id` BIGINT COMMENT 'Foreign key linking to enterprise.iot_deployment. Business justification: Provisioning orders are raised to activate IoT devices as part of an IoT deployment. IoT fleet activation workflows require linking provisioning orders to the deployment for batch activation tracking,',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Provisioning orders are raised to activate or modify managed services. Managed service change management and audit trails require linking provisioning orders to the managed service they fulfill. Telec',
    `mnp_compliance_id` BIGINT COMMENT 'Foreign key linking to compliance.mnp_compliance. Business justification: Provisioning orders for number porting (provisioning_order has mnp_port_type, donor_carrier_code, recipient_carrier_code, porting_timestamp) execute the MNP transaction. Direct FK to mnp_compliance en',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: Order fulfillment and revenue assurance reporting require linking provisioning orders to the specific product offering being activated. Telecom order management systems track which offering triggered ',
    `ont_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.ont_asset. Business justification: FTTH provisioning orders require assignment of a specific ONT asset to the customer premises. Telecom fiber operations track which ONT is allocated per provisioning order for installation scheduling, ',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to interconnect.interconnect_carrier. Business justification: International or MVNO provisioning orders require tracking the partner/wholesale carrier for IoT global SIM activation, roaming profile setup, and inter-carrier provisioning coordination workflows.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Provisioning orders are subject to regulatory SLA obligations (e.g., number portability completion timelines mandated by regulators, activation deadlines). provisioning_order has sla_compliance_flag. ',
    `site_id` BIGINT COMMENT 'Foreign key linking to enterprise.site. Business justification: Enterprise provisioning orders target specific customer sites for technician dispatch, installation planning, and site access coordination. Critical for field service management and enterprise service',
    `sla_contract_id` BIGINT COMMENT 'Foreign key linking to assurance.sla_contract. Business justification: Provisioning orders must reference the SLA contract being fulfilled to configure correct QoS parameters and track SLA compliance from activation. Provisioning teams use this to ensure the service is a',
    `sla_profile_id` BIGINT COMMENT 'Foreign key linking to service.sla_profile. Business justification: provisioning_order carries an inline sla_tier string that classifies the SLA commitment for the work order. sla_profile is the master reference for SLA tiers, response times, MTTR targets, and escalat',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber for whom this provisioning order is being executed.',
    `svc_instance_id` BIGINT COMMENT 'Reference to the logical service instance being provisioned, modified, or deprovisioned.',
    `activation_task_count` STRING COMMENT 'Total number of individual activation tasks or steps that comprise this provisioning order, as one order may span multiple network domains and systems.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual timestamp when provisioning execution began in the Operations Support Systems (OSS).',
    `completed_task_count` STRING COMMENT 'Number of activation tasks that have been successfully completed, used to calculate provisioning progress percentage.',
    `completion_timestamp` TIMESTAMP COMMENT 'Timestamp when the provisioning order reached a terminal state (completed, failed, or cancelled).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this provisioning order record was first created in the system, marking the beginning of the order lifecycle.',
    `donor_carrier_code` STRING COMMENT 'Carrier code of the donor network for Mobile Number Portability (MNP) port-in scenarios, used for inter-carrier coordination and porting validation.',
    `error_code` STRING COMMENT 'System-generated error code returned by the Operations Support Systems (OSS) or Business Support Systems (BSS) component that failed during provisioning execution.',
    `error_message` STRING COMMENT 'Detailed error message or description returned by the failing system component, providing context for troubleshooting and resolution.',
    `failure_step` STRING COMMENT 'Specific orchestration step or task name where the provisioning order failed, used for root cause analysis and Network Operations Center (NOC) troubleshooting.',
    `fallout_flag` BOOLEAN COMMENT 'Indicates whether this provisioning order has entered fallout state due to execution failure requiring manual intervention or retry.',
    `last_modified_by_user` STRING COMMENT 'User identifier or system account that last modified this provisioning order record, used for audit and accountability purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this provisioning order record was last updated, used for audit trail and change tracking in the lakehouse silver layer.',
    `max_retry_count` STRING COMMENT 'Maximum number of automatic retry attempts configured for this provisioning order type before escalation to manual fallout resolution.',
    `mnp_port_type` STRING COMMENT 'Indicates whether this provisioning order involves Mobile Number Portability (MNP) porting in from another carrier or porting out to another carrier.. Valid values are `port_in|port_out|not_applicable`',
    `network_domain` STRING COMMENT 'Primary network domain or layer where provisioning activities are executed. Includes Radio Access Network (RAN), core network, transport, access, IP Multimedia Subsystem (IMS), Customer Premises Equipment (CPE), Optical Line Terminal (OLT), and Optical Network Terminal (ONT). [ENUM-REF-CANDIDATE: ran|core|transport|access|ims|cpe|olt|ont — 8 candidates stripped; promote to reference product]',
    `orchestration_state` STRING COMMENT 'Current state within the Oracle Order and Service Management (OSM) or Netcracker orchestration workflow state machine. Captures granular step-level execution state.',
    `order_number` STRING COMMENT 'Externally-visible business identifier for the provisioning order, used for tracking and reference in Operations Support Systems (OSS) and Business Support Systems (BSS).. Valid values are `^PO-[0-9]{10}$`',
    `order_status` STRING COMMENT 'Current lifecycle state of the provisioning order in the orchestration state machine. Tracks progression from pending through execution to completion or failure. [ENUM-REF-CANDIDATE: pending|in_progress|completed|failed|cancelled|suspended|fallout|awaiting_retry — 8 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the provisioning action being performed. Includes new activation, upgrade, downgrade, suspension, termination, Mobile Number Portability (MNP) port-in/out, service test, service qualification, modification, and reactivation. [ENUM-REF-CANDIDATE: new_activation|upgrade|downgrade|suspension|termination|mnp_port_in|mnp_port_out|service_test|service_qualification|modification|reactivation — 11 candidates stripped; promote to reference product]',
    `oss_order_reference` STRING COMMENT 'Native order identifier or reference number in the source Operations Support Systems (OSS) platform, used for cross-system reconciliation and troubleshooting.',
    `oss_system` STRING COMMENT 'Primary Operations Support Systems (OSS) or Business Support Systems (BSS) platform executing this provisioning order. Includes Oracle Order and Service Management (OSM), Netcracker, Nokia NetAct, Ericsson Network Manager, Amdocs, and other systems.. Valid values are `oracle_osm|netcracker|nokia_netact|ericsson_nm|amdocs|other`',
    `porting_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the Mobile Number Portability (MNP) porting cutover was executed and the subscriber number was transferred between carriers.',
    `priority` STRING COMMENT 'Business priority level assigned to the provisioning order, determining queue position and resource allocation in Network Operations Center (NOC) systems.. Valid values are `low|normal|high|urgent|critical`',
    `provisioning_notes` STRING COMMENT 'Free-text notes capturing special instructions, customer requirements, or operational observations relevant to provisioning execution and fallout resolution.',
    `qos_profile_code` STRING COMMENT 'Code identifying the Quality of Service (QoS) profile applied to the provisioned service, defining bandwidth, latency, jitter, and packet loss parameters.',
    `qualification_status` STRING COMMENT 'Status of service qualification process determining whether the requested service can be delivered at the target location with required Quality of Service (QoS) parameters.. Valid values are `qualified|not_qualified|pending|not_required`',
    `recipient_carrier_code` STRING COMMENT 'Carrier code of the recipient network for Mobile Number Portability (MNP) port-out scenarios, used for inter-carrier coordination and porting validation.',
    `requested_activation_date` DATE COMMENT 'Customer-requested or business-scheduled date for service activation or provisioning completion.',
    `resolution_action` STRING COMMENT 'Description of the corrective action taken to resolve a fallout condition, captured for operational quality tracking and knowledge management.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Timestamp when the fallout condition was resolved and the provisioning order was returned to normal execution flow or manually completed.',
    `retry_count` STRING COMMENT 'Number of automatic retry attempts executed by the orchestration system after initial failure, used for fallout pattern analysis.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned timestamp when provisioning execution is scheduled to begin in the orchestration system.',
    `service_type` STRING COMMENT 'Type of telecommunications service being provisioned. Includes mobile, broadband, Fiber to the Home (FTTH), Internet Protocol Television (IPTV), Voice over Internet Protocol (VoIP), Voice over Long-Term Evolution (VoLTE), Multiprotocol Label Switching (MPLS), Software-Defined Wide Area Network (SD-WAN), and Internet of Things (IoT). [ENUM-REF-CANDIDATE: mobile|broadband|ftth|iptv|voip|volte|mpls|sdwan|iot — 9 candidates stripped; promote to reference product]',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicates whether the provisioning order was completed within the Service Level Agreement (SLA) target timeframe, used for operational quality metrics and customer satisfaction tracking.',
    `target_completion_timestamp` TIMESTAMP COMMENT 'Service Level Agreement (SLA) target timestamp by which provisioning must be completed to meet contractual commitments.',
    `test_result` STRING COMMENT 'Result of pre-activation service testing or qualification step, particularly for enterprise Fiber to the Home (FTTH) or Multiprotocol Label Switching (MPLS) delivery where service quality must be validated before customer handoff.. Valid values are `passed|failed|not_applicable|pending`',
    CONSTRAINT pk_provisioning_order PRIMARY KEY(`provisioning_order_id`)
) COMMENT 'Transactional record capturing each service provisioning or de-provisioning work order dispatched to OSS/BSS systems (Oracle OSM, Netcracker). Tracks order type (new activation, upgrade, downgrade, suspension, termination, MNP port-in/out, service test/qualification), orchestration state machine, step-level execution status including fallout management (failure step, error code, retry count, resolution action, resolution timestamp), completion timestamp, and originating commercial order reference. One provisioning order may span multiple activation tasks across network domains. Encompasses full fallout lifecycle for NOC operational quality tracking and systemic failure pattern identification. Supports pre-activation service testing and qualification as provisioning step types for enterprise FTTH/MPLS delivery. Does NOT own the commercial order (order domain) — owns only the technical provisioning execution, its outcomes, and failure resolution.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`service`.`activation_event` (
    `activation_event_id` BIGINT COMMENT 'Unique identifier for the service activation event record. Primary key for the activation event entity.',
    `technician_id` BIGINT COMMENT 'Reference to the field technician who performed the activation, if applicable. Null for automated or remote activations.',
    `addon_id` BIGINT COMMENT 'Foreign key linking to product.addon. Business justification: Addon activation events (roaming pack, data boost, VoLTE enablement) must reference the specific addon product for revenue recognition, entitlement provisioning, and regulatory reporting. Telecom BSS ',
    `appointment_id` BIGINT COMMENT 'Foreign key linking to order.appointment. Business justification: Field technician appointments (FTTH installation, CPE swap) directly trigger activation events. Linking activation_event to the appointment that drove the field visit is essential for field operations',
    `carrier_agreement_id` BIGINT COMMENT 'Foreign key linking to interconnect.carrier_agreement. Business justification: Roaming activation events must record the governing carrier agreement for billing reconciliation, TAP file audit, and regulatory compliance. Already has visited_carrier_id but not the specific agreeme',
    `channel_id` BIGINT COMMENT 'Foreign key linking to sales.channel. Business justification: Activation events must be attributed to the originating sales channel for dealer commission processing and channel performance KPI reporting. activation_channel on activation_event is a denormalized s',
    `dealer_id` BIGINT COMMENT 'Foreign key linking to partner.dealer. Business justification: Activation events need dealer attribution for commission settlement timing, channel performance measurement, and regulatory compliance. Critical for dealer compensation and fraud detection in indirect',
    `device_registration_id` BIGINT COMMENT 'Foreign key linking to customer.device_registration. Business justification: Device activation traceability: every service activation event is tied to a specific registered device (IMEI/SIM). Direct link enables device activation audit trails, eSIM profile download reconciliat',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: Activation audit trails must link to physical CPE inventory for regulatory compliance, warranty validation, and root cause analysis when activations fail. Tracks which specific asset was used in activ',
    `iot_deployment_id` BIGINT COMMENT 'Foreign key linking to enterprise.iot_deployment. Business justification: IoT SIM activation events are part of an IoT deployment activation workflow. Deployment progress tracking, fleet activation dashboards, and IoT SLA compliance reporting require linking activation even',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Managed service activation events trigger NOC onboarding, SLA clock start, and service assurance workflows. Managed service activation tracking requires linking activation events directly to the manag',
    `mnp_compliance_id` BIGINT COMMENT 'Foreign key linking to compliance.mnp_compliance. Business justification: When a ported number is activated, the activation event completes the MNP transaction. Regulators require proof that activation occurred within mandated porting timelines. Direct FK from activation_ev',
    `mnp_transaction_id` BIGINT COMMENT 'Foreign key linking to interconnect.mnp_transaction. Business justification: MNP port completion triggers a service activation event. Regulatory MNP SLA reporting requires tracing from port request through to the activation event timestamp; this direct FK enables end-to-end po',
    `element_id` BIGINT COMMENT 'Identifier of the activating network element that performed the service activation. May reference Optical Line Terminal (OLT), Broadband Network Gateway (BNG), Home Subscriber Server (HSS), or other Operations Support Systems (OSS) components.',
    `ont_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.ont_asset. Business justification: FTTH activation events involve activating a specific ONT asset at the customer premises. Telecom fiber operations require this link for ONT activation audit trails, optical power level recording at ac',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to product.promo_offer. Business justification: Promotional offer attribution at the activation event level is required for marketing ROI reporting and promo budget tracking. Telecom marketing operations need to know which promo drove each activati',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to sales.promotion. Business justification: An activation event may be associated with a promotional offer (e.g., promotional device bundle, free activation). Linking enables promotion redemption count tracking, marketing ROI measurement, and b',
    `provisioning_order_id` BIGINT COMMENT 'Reference to the provisioning order that triggered this activation event. Links back to the order fulfillment workflow in Oracle Communications Order and Service Management (OSM).',
    `ran_cell_id` BIGINT COMMENT 'Foreign key linking to network.ran_cell. Business justification: Mobile service activations occur on specific RAN cells. Critical for coverage analysis, activation success rate reporting by cell, and troubleshooting first-call failures. Standard metric in mobile ne',
    `roaming_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.roaming_agreement. Business justification: Roaming activation events must be traceable to the specific roaming agreement governing the visited network for TAP/NRTRDE settlement, fraud monitoring threshold enforcement, and regulatory roaming re',
    `sim_stock_id` BIGINT COMMENT 'Foreign key linking to inventory.sim_stock. Business justification: Mobile activation events record which SIM card was activated. esim_profile_iccid is a denormalized SIM identifier on activation_event. A proper FK to sim_stock enables SIM activation audit trails, eSI',
    `site_id` BIGINT COMMENT 'Foreign key linking to enterprise.site. Business justification: Enterprise service activations occur at specific customer sites. Required for SLA measurement by location, installation verification, and site-level activation reporting in B2B service delivery.',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber for whom this service was activated. Links to the customer subscriber record.',
    `svc_configuration_id` BIGINT COMMENT 'Foreign key linking to service.svc_configuration. Business justification: An activation event applies a specific technical configuration to a service instance. svc_configuration is the master record of the full technical configuration state (APN, QoS, eSIM profile, VoLTE fl',
    `svc_instance_id` BIGINT COMMENT 'Reference to the service instance that was activated in this event. Links to the specific service configuration being brought online.',
    `svc_location_id` BIGINT COMMENT 'Reference to the physical service location or address where the service was activated. Links to the service delivery address.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to interconnect.interconnect_carrier. Business justification: Activation events on visited roaming networks must capture the carrier ID for regulatory reporting (NRTRDE), TAP file generation, and roaming settlement reconciliation processes.',
    `activation_error_code` STRING COMMENT 'Error code returned by the network element or provisioning system if activation failed or encountered issues. Null for successful activations.',
    `activation_error_message` STRING COMMENT 'Detailed error message or description associated with the activation error code. Provides troubleshooting context for failed activations.',
    `activation_method` STRING COMMENT 'Method used to perform the service activation. Indicates whether activation was automatic via provisioning system, manual by operations staff, or performed by field technician.. Valid values are `automatic|manual|semi_automatic|remote|field_technician`',
    `activation_status` STRING COMMENT 'Final outcome status of the activation attempt. Indicates whether the service was successfully activated, failed, partially activated, or rolled back.. Valid values are `successful|failed|partial|pending_confirmation|rolled_back`',
    `activation_timestamp` TIMESTAMP COMMENT 'Precise moment when the service instance transitioned to active state on the network. Used for Service Level Agreement (SLA) compliance measurement and regulatory reporting of service activation timelines.',
    `bandwidth_allocated_mbps` DECIMAL(18,2) COMMENT 'Bandwidth allocated to the service at activation, measured in megabits per second (Mbps). Defines the service speed tier.',
    `created_by_user` STRING COMMENT 'User identifier or system account that created this activation event record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this activation event record was first created in the system. Used for audit trail and data lineage.',
    `esim_profile_download_status` STRING COMMENT 'Status of the embedded SIM (eSIM) profile download confirmation at activation. Indicates whether the eSIM profile was successfully provisioned to the device.. Valid values are `downloaded|download_failed|not_applicable|pending`',
    `fallback_activation_flag` BOOLEAN COMMENT 'Boolean indicator of whether a fallback or alternate activation procedure was used. True if primary activation method failed and fallback was invoked.',
    `fallback_reason` STRING COMMENT 'Reason or error code that triggered the fallback activation procedure. Null if no fallback was required.',
    `ims_registration_timestamp` TIMESTAMP COMMENT 'Timestamp when the service successfully registered with the IP Multimedia Subsystem (IMS) core network. Null if IMS registration is not applicable or failed.',
    `imsi` STRING COMMENT 'International Mobile Subscriber Identity (IMSI) provisioned and activated for the subscriber. Uniquely identifies the subscriber in the mobile network.',
    `ip_address_assigned` STRING COMMENT 'Internet Protocol (IP) address assigned to the service or Customer Premises Equipment (CPE) at activation. May be IPv4 or IPv6 format.',
    `msisdn` STRING COMMENT 'Mobile Station International Subscriber Directory Number (MSISDN) or phone number activated for the service. Primary identifier for mobile voice and data services.',
    `network_element_type` STRING COMMENT 'Type classification of the network element that performed the activation. Includes Optical Line Terminal (OLT), Optical Network Terminal (ONT), Broadband Network Gateway (BNG), Broadband Remote Access Server (BRAS), Home Subscriber Server (HSS), Home Location Register (HLR), IP Multimedia Subsystem (IMS), Radio Access Network (RAN), Customer Premises Equipment (CPE). [ENUM-REF-CANDIDATE: OLT|ONT|BNG|BRAS|HSS|HLR|IMS|RAN|CPE|other — 10 candidates stripped; promote to reference product]',
    `network_technology` STRING COMMENT 'Underlying network technology used for service delivery. Includes 5G New Radio (5G NR), Long-Term Evolution (LTE), Voice over LTE (VoLTE), Gigabit Passive Optical Network (GPON), Fiber to the Home (FTTH), Data Over Cable Service Interface Specification (DOCSIS), Digital Subscriber Line (DSL), Multiprotocol Label Switching (MPLS), Software-Defined Wide Area Network (SD-WAN). [ENUM-REF-CANDIDATE: 5G_NR|LTE|VoLTE|GPON|FTTH|DOCSIS|DSL|MPLS|SD_WAN — 9 candidates stripped; promote to reference product]',
    `provisioning_system_reference` STRING COMMENT 'Confirmation reference or transaction identifier from the provisioning system that executed the activation. Used for audit trail and troubleshooting in Oracle OSM or Netcracker OSS.',
    `qos_profile_applied` STRING COMMENT 'Quality of Service (QoS) profile identifier or name applied to the service at activation. Defines bandwidth, latency, jitter, and packet loss parameters.',
    `regulatory_jurisdiction` STRING COMMENT 'Regulatory jurisdiction or country code where this activation occurred and is subject to reporting requirements. Uses ISO 3166-1 alpha-3 country codes. [ENUM-REF-CANDIDATE: USA|GBR|DEU|FRA|IND|BRA|AUS|CAN|other — 9 candidates stripped; promote to reference product]',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Boolean indicator of whether this activation event must be included in regulatory reporting to Federal Communications Commission (FCC), Office of Communications (Ofcom), or other governing bodies. True if regulatory reporting is required.',
    `retry_attempt_count` STRING COMMENT 'Number of retry attempts made before successful activation or final failure. Zero indicates success on first attempt.',
    `service_category` STRING COMMENT 'Business category of the service activated. Distinguishes consumer, business, enterprise, wholesale, or Mobile Virtual Network Operator (MVNO) services.. Valid values are `consumer|business|enterprise|wholesale|MVNO`',
    `service_type` STRING COMMENT 'Type classification of the service being activated. Includes mobile voice, mobile data, fixed broadband, Fiber to the Home (FTTH), Internet Protocol Television (IPTV), Voice over Internet Protocol (VoIP), enterprise data, Internet of Things (IoT), 5G New Radio (5G NR), Long-Term Evolution (LTE). [ENUM-REF-CANDIDATE: mobile_voice|mobile_data|fixed_broadband|FTTH|IPTV|VoIP|enterprise_data|IoT|5G_NR|LTE — 10 candidates stripped; promote to reference product]',
    `sla_actual_activation_time` STRING COMMENT 'Actual activation time in minutes from order submission to service active state. Used to calculate SLA compliance and identify breaches.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether the activation met the Service Level Agreement (SLA) target time. True if compliant, False if SLA was breached.',
    `sla_target_activation_time` STRING COMMENT 'Target activation time in minutes as defined in the Service Level Agreement (SLA). Used to measure compliance with contractual activation commitments.',
    `source_system` STRING COMMENT 'Source system that generated or recorded this activation event. Identifies the originating Operations Support System (OSS) or Business Support System (BSS).. Valid values are `Oracle_OSM|Netcracker_OSS|Nokia_NetAct|Ericsson_NM|other`',
    `vlan_number` STRING COMMENT 'Virtual Local Area Network (VLAN) identifier assigned to the service for network segmentation and Quality of Service (QoS) enforcement.',
    `volte_registration_status` STRING COMMENT 'Voice over LTE (VoLTE) or IP Multimedia Subsystem (IMS) registration status at the moment of activation. Indicates whether the service successfully registered with the IMS core for voice services.. Valid values are `registered|not_registered|registration_failed|not_applicable`',
    CONSTRAINT pk_activation_event PRIMARY KEY(`activation_event_id`)
) COMMENT 'Immutable event record capturing the precise moment a service instance transitions to active state on the network. Records activation timestamp, activating network element, provisioning system confirmation reference, VoLTE/IMS registration status at activation, eSIM profile download confirmation, and any fallback or retry attempts. Used for SLA compliance measurement and regulatory reporting of service activation timelines.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`service`.`svc_configuration` (
    `svc_configuration_id` BIGINT COMMENT 'Unique identifier for the service configuration record. Primary key.',
    `addon_id` BIGINT COMMENT 'Foreign key linking to product.addon. Business justification: Service configuration applies addon-specific technical parameters (roaming zone codes, VoLTE profiles, data boost quotas). Telecom configuration management and entitlement systems must reference the a',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: Field configuration audit trail: technicians apply CPE/network configurations during site visits. Tracking which technician applied a configuration is required for quality assurance, fault attribution',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: Service configuration is applied to a specific CPE device — APN, QoS, VoIP codec settings are pushed to the physical CPE asset. Telecom OSS/BSS systems require this link for remote CPE configuration m',
    `device_model_id` BIGINT COMMENT 'Reference to the CPE device (router, modem, set-top box) provisioned for this service instance.',
    `iot_deployment_id` BIGINT COMMENT 'Foreign key linking to enterprise.iot_deployment. Business justification: IoT device configurations (APN, QoS, roaming profiles) are provisioned as part of an IoT deployment. IoT deployment configuration management requires linking configurations to the deployment for bulk ',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Service configurations for managed enterprise services must link to the managed service contract for SLA compliance validation, configuration change management, and service delivery verification in B2',
    `mvno_profile_id` BIGINT COMMENT 'Foreign key linking to partner.mvno_profile. Business justification: MVNO service configurations apply MVNO-specific overrides for APN, QoS, VoLTE, roaming, and codec settings defined in the MVNO profile. The mvno_override_flag on svc_configuration signals MVNO context',
    `element_id` BIGINT COMMENT 'Foreign key linking to network.element. Business justification: Service configurations must reference the serving network element (BNG, GGSN, PGW, UPF) for provisioning workflows, troubleshooting, and capacity planning. Essential for OSS/BSS integration and servic',
    `ont_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.ont_asset. Business justification: FTTH service configuration (GEM port, TCONT, VLAN, PON port) is applied to a specific ONT asset. ftth_ont_serial_number is a denormalized ONT identifier. A proper FK enables ONT configuration manageme',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: Service configuration implements the technical parameters defined by a product price plan (QoS class, bandwidth profile, APN settings). Telecom provisioning systems reference the price plan to configu',
    `provisioning_order_id` BIGINT COMMENT 'External order or work order identifier that triggered this configuration change.',
    `rate_plan_id` BIGINT COMMENT 'Foreign key linking to billing.rate_plan. Business justification: Service configurations determine applicable rate plans for usage rating. Bandwidth profiles, QoS settings, and feature flags directly map to rating tiers. Required for real-time charging, bill shock p',
    `sales_contract_id` BIGINT COMMENT 'Foreign key linking to sales.sales_contract. Business justification: Service configuration parameters (bandwidth profile, QoS class, VoLTE enablement) are contractually mandated in enterprise and managed service contracts. Linking svc_configuration to the governing sal',
    `sdwan_topology_id` BIGINT COMMENT 'Foreign key linking to enterprise.sdwan_topology. Business justification: SD-WAN CPE and underlay service configurations are directly associated with an SD-WAN topology. Network engineers require this link for topology-aware configuration change management and troubleshooti',
    `sim_stock_id` BIGINT COMMENT 'Foreign key linking to inventory.sim_stock. Business justification: Service configuration for mobile/eSIM services directly references the SIM asset being configured. esim_iccid and esim_eid are denormalized SIM identifiers. A proper FK to sim_stock enables eSIM profi',
    `sla_profile_id` BIGINT COMMENT 'Foreign key linking to service.sla_profile. Business justification: svc_configuration stores inline SLA parameters (sla_class, sla_target_latency_ms, sla_target_uptime_percent) that are authoritatively defined in sla_profile (service_class, latency_threshold_ms, uptim',
    `spec_id` BIGINT COMMENT 'Foreign key linking to product.spec. Business justification: Product specs define the technical characteristics (bandwidth, latency, codec list, QoS class) that service configurations must implement. Telecom configuration management maps each configuration to i',
    `svc_instance_id` BIGINT COMMENT 'Reference to the parent service instance to which this configuration applies.',
    `uc_subscription_id` BIGINT COMMENT 'Foreign key linking to enterprise.uc_subscription. Business justification: UC service configurations (codec, SIP trunk, IMS parameters) are provisioned as part of a UC subscription. UC platform operations require linking configurations to subscriptions for feature pack enfor',
    `activation_timestamp` TIMESTAMP COMMENT 'Actual date and time when this configuration was successfully activated on the network elements.',
    `apn_name` STRING COMMENT 'Access Point Name identifying the external packet data network gateway for data sessions (LTE/3G).',
    `bandwidth_profile_downstream_mbps` DECIMAL(18,2) COMMENT 'Maximum downstream (download) bandwidth in megabits per second allocated to this service instance.',
    `bandwidth_profile_upstream_mbps` DECIMAL(18,2) COMMENT 'Maximum upstream (upload) bandwidth in megabits per second allocated to this service instance.',
    `configuration_payload_json` STRING COMMENT 'Full JSON payload containing all technology-specific configuration parameters not captured in structured columns. Supports extensibility for diverse service types.',
    `configuration_status` STRING COMMENT 'Current lifecycle state of this configuration version (draft, pending activation, active, suspended, deactivated, failed, rollback). [ENUM-REF-CANDIDATE: draft|pending|active|suspended|deactivated|failed|rollback — 7 candidates stripped; promote to reference product]',
    `configuration_type` STRING COMMENT 'Category of configuration parameters contained in this record (e.g., bearer settings, QoS profile, VoLTE/IMS, eSIM, FTTH ONT binding). [ENUM-REF-CANDIDATE: bearer|qos|apn|volte|ims|esim|ftth|ont|mvno|roaming|cpe|codec|bandwidth — 13 candidates stripped; promote to reference product]',
    `configuration_version` STRING COMMENT 'Sequential version number tracking configuration changes over time for the same service instance.',
    `cpe_wan_ip_address` STRING COMMENT 'Public or carrier-grade NAT IP address assigned to the WAN interface of the CPE device.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this configuration record was first created in the system.',
    `deactivation_timestamp` TIMESTAMP COMMENT 'Date and time when this configuration was deactivated or superseded by a newer version.',
    `dnn_name` STRING COMMENT 'Data Network Name identifying the external data network for 5G standalone (5G SA) PDU sessions. Replaces APN in 5G core.',
    `effective_timestamp` TIMESTAMP COMMENT 'Date and time when this configuration version became or will become active on the network.',
    `esim_profile_state` STRING COMMENT 'Current state of the eSIM profile on the device (not provisioned, downloaded, installed, enabled, disabled, deleted).. Valid values are `not_provisioned|downloaded|installed|enabled|disabled|deleted`',
    `esim_smdp_plus_address` STRING COMMENT 'Fully qualified domain name of the SM-DP+ server responsible for eSIM profile generation and download.',
    `expiry_timestamp` TIMESTAMP COMMENT 'Date and time when this configuration version is scheduled to expire or be superseded. Null for open-ended configurations.',
    `ftth_gem_port_number` STRING COMMENT 'GEM port identifier used for traffic segmentation and QoS mapping in GPON.',
    `ftth_olt_identifier` STRING COMMENT 'Identifier of the OLT device in the central office serving this FTTH service instance.',
    `ftth_pon_port` STRING COMMENT 'PON port identifier on the OLT to which the ONT is connected.',
    `ftth_tcont_number` STRING COMMENT 'T-CONT identifier used for upstream bandwidth allocation in GPON architecture.',
    `ftth_vlan_number` STRING COMMENT 'VLAN identifier assigned for service traffic segregation on the FTTH access network.',
    `hd_voice_enabled_flag` BOOLEAN COMMENT 'Indicates whether HD Voice (wideband audio codec) is enabled for voice calls.',
    `ims_pcscf_address` STRING COMMENT 'IP address or FQDN of the P-CSCF node assigned for IMS session control (VoLTE/VoWiFi signaling).',
    `ims_private_user_identity` STRING COMMENT 'Private user identity used for IMS authentication and registration. Typically derived from IMSI.',
    `ims_public_user_identity` STRING COMMENT 'Public user identity (SIP URI or Tel URI) used for IMS service delivery and routing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this configuration record was last updated.',
    `mvno_override_flag` BOOLEAN COMMENT 'Indicates whether this service instance has MVNO-specific configuration overrides applied.',
    `preferred_codec_list` STRING COMMENT 'Comma-separated ordered list of preferred voice codecs (e.g., AMR-WB, EVS, AMR-NB) for voice call negotiation.',
    `provisioning_system_source` STRING COMMENT 'Name of the source system that provisioned this configuration (e.g., Netcracker OSS, Nokia NetAct, HLR/HSS, OLT EMS).',
    `qos_class_identifier` STRING COMMENT 'QCI (LTE) or 5QI (5G NR) value defining the bearer quality of service class for packet scheduling, priority, and delay tolerance.. Valid values are `^QCI[1-9]$|^5QI[0-9]{1,3}$`',
    `roaming_enabled_flag` BOOLEAN COMMENT 'Indicates whether international roaming is enabled for this service instance.',
    `roaming_zone_code` STRING COMMENT 'Code identifying the roaming zone configuration for international roaming tariff and access control.',
    `volte_enabled_flag` BOOLEAN COMMENT 'Indicates whether VoLTE voice service is enabled for this service instance.',
    `vowifi_enabled_flag` BOOLEAN COMMENT 'Indicates whether VoWiFi (WiFi Calling) is enabled for this service instance.',
    CONSTRAINT pk_svc_configuration PRIMARY KEY(`svc_configuration_id`)
) COMMENT 'Master record storing the full technical configuration state applied to a service instance at any point in time — including bearer settings, APN bindings, QoS class identifiers, bandwidth profiles, VoLTE/IMS parameters (P-CSCF assignment, HD voice, VoWiFi), eSIM profile state (EID, ICCID, SM-DP+ reference), FTTH ONT bindings (OLT, PON port, T-CONT, GEM port, VLAN), MVNO overrides, roaming zone configuration, codec preferences, and CPE provisioning parameters. Technology-agnostic container supporting all service types through typed configuration attributes. Sourced from Netcracker OSS, Nokia NetAct, HLR/HSS, and OLT EMS.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`service`.`sla_profile` (
    `sla_profile_id` BIGINT COMMENT 'Unique identifier for the SLA profile. Primary key.',
    `enterprise_contract_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_contract. Business justification: Bespoke SLA profiles are contractually mandated by specific enterprise contracts. Contract management and SLA breach credit processing require linking the SLA profile to the governing contract for cre',
    `segment_id` BIGINT COMMENT 'Foreign key linking to enterprise.segment. Business justification: SLA profiles are designed and offered based on enterprise segment tiers (SMB, mid-market, large enterprise). Segment-based SLA governance and product catalog management require knowing which segment a',
    `sla_contract_id` BIGINT COMMENT 'Foreign key linking to assurance.sla_contract. Business justification: An sla_profile is the technical implementation of a customer-facing sla_contract. Linking them enables SLA governance reporting, contract-to-profile mapping for compliance audits, and ensures that int',
    `sla_definition_id` BIGINT COMMENT 'Foreign key linking to partner.sla_definition. Business justification: Internal service SLA profiles for wholesale/MVNO services must map to the contractual partner SLA definition to ensure internal commitments align with partner agreement obligations. Required for SLA b',
    `applicable_service_types` STRING COMMENT 'Comma-separated list of service types this SLA profile applies to (e.g., FTTH, LTE, 5G NR, MPLS, SD-WAN, VoLTE, IPTV).',
    `approval_status` STRING COMMENT 'Approval workflow status for this SLA profile before it can be activated in the product catalog.. Valid values are `approved|pending|rejected|under_review`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this SLA profile was formally approved for use in service provisioning.',
    `bandwidth_guarantee_mbps` STRING COMMENT 'Minimum guaranteed bandwidth in Mbps committed under this SLA. Applies to dedicated circuits, MPLS, and SD-WAN services.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this SLA profile record was first created in the system.',
    `credit_eligible` BOOLEAN COMMENT 'Indicates whether SLA breaches under this profile are eligible for service credits or financial compensation.',
    `dedicated_support_team` BOOLEAN COMMENT 'Indicates whether a dedicated technical account manager or support team is assigned under this SLA profile.',
    `effective_end_date` DATE COMMENT 'Date when this SLA profile is retired or no longer available for new service assignments. Null for open-ended profiles.',
    `effective_start_date` DATE COMMENT 'Date when this SLA profile becomes active and available for assignment to service instances.',
    `escalation_tier_1_minutes` STRING COMMENT 'Time threshold in minutes before an unresolved incident is escalated to Tier 1 support or management.',
    `escalation_tier_2_minutes` STRING COMMENT 'Time threshold in minutes before an unresolved incident is escalated to Tier 2 engineering or senior management.',
    `escalation_tier_3_minutes` STRING COMMENT 'Time threshold in minutes before an unresolved incident is escalated to executive management or vendor escalation.',
    `exclusion_window_description` STRING COMMENT 'Description of planned maintenance windows or other exclusions that do not count against SLA uptime commitments.',
    `external_reference_code` STRING COMMENT 'Identifier used in external systems or partner interfaces to reference this SLA profile.',
    `geographic_scope` STRING COMMENT 'Geographic coverage area where this SLA profile is applicable (e.g., global, national, regional, site-specific).. Valid values are `global|regional|national|local|site_specific`',
    `jitter_threshold_ms` STRING COMMENT 'Maximum acceptable variation in packet delay (jitter) in milliseconds. Essential for voice and video quality in VoLTE and IMS services.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this SLA profile record was last updated or modified.',
    `latency_threshold_ms` STRING COMMENT 'Maximum acceptable round-trip latency in milliseconds for network traffic under this SLA. Used for real-time services like VoLTE and video conferencing.',
    `managed_in_system` STRING COMMENT 'Source system where this SLA profile is maintained (e.g., Netcracker OSS/BSS Product Catalog, Oracle OSM).',
    `measurement_window_hours` STRING COMMENT 'Time window in hours over which SLA metrics are measured and averaged (e.g., 24 hours, 720 hours for monthly).',
    `modified_by` STRING COMMENT 'Identifier of the user or system that last modified this SLA profile record.',
    `mttr_target_minutes` STRING COMMENT 'Maximum committed time in minutes to restore service after a fault or outage. Critical SLA parameter for fault management and NOC operations.',
    `network_technology` STRING COMMENT 'Specific network technologies covered by this SLA profile (e.g., 5G NR, LTE, GPON, MPLS, SD-WAN).',
    `packet_loss_limit_percentage` DECIMAL(18,2) COMMENT 'Maximum acceptable packet loss percentage for data transmission under this SLA. Critical for QoS enforcement and network performance monitoring.',
    `priority_level` STRING COMMENT 'Default priority level assigned to incidents and service requests under this SLA profile, determining queue position and resource allocation.. Valid values are `critical|high|medium|low`',
    `proactive_monitoring_enabled` BOOLEAN COMMENT 'Indicates whether proactive network monitoring and alerting is included in this SLA profile.',
    `profile_code` STRING COMMENT 'Externally-known unique business identifier for the SLA profile used in product catalogs and service provisioning systems.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `profile_description` STRING COMMENT 'Detailed description of the SLA profile including scope, coverage, and key commitments.',
    `profile_name` STRING COMMENT 'Human-readable name of the SLA profile (e.g., Gold Enterprise SLA, Standard Business SLA, Premium Residential SLA).',
    `profile_tier` STRING COMMENT 'Hierarchical tier level of the SLA profile indicating the quality and priority of service commitments.. Valid values are `platinum|gold|silver|bronze|standard|basic`',
    `regulatory_compliance_notes` STRING COMMENT 'Notes on regulatory requirements or compliance obligations associated with this SLA profile (e.g., FCC service quality standards, Ofcom requirements).',
    `reporting_frequency` STRING COMMENT 'Frequency at which SLA performance reports are provided to the customer (e.g., monthly performance dashboards, quarterly business reviews).. Valid values are `real_time|daily|weekly|monthly|quarterly|on_demand`',
    `response_time_target_minutes` STRING COMMENT 'Maximum time in minutes for initial response to a service incident or trouble ticket after customer notification.',
    `service_class` STRING COMMENT 'Classification of the service tier this SLA profile applies to, determining the customer segment and service expectations.. Valid values are `enterprise|business|residential|wholesale|government|carrier`',
    `sla_profile_status` STRING COMMENT 'Current lifecycle status of the SLA profile in the product catalog.. Valid values are `active|inactive|draft|deprecated|retired|pending_approval`',
    `support_hours` STRING COMMENT 'Availability window for technical support and NOC assistance under this SLA (e.g., 24x7, business hours 8am-6pm, extended hours).. Valid values are `24x7|business_hours|extended_hours|custom`',
    `uptime_percentage_target` DECIMAL(18,2) COMMENT 'Guaranteed service availability percentage (e.g., 99.999% for five-nines, 99.95% for standard enterprise). Represents the commercial commitment for network uptime.',
    `version_number` STRING COMMENT 'Version identifier for this SLA profile definition, following semantic versioning (e.g., 1.0, 2.1).. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_sla_profile PRIMARY KEY(`sla_profile_id`)
) COMMENT 'Reference master defining the SLA parameters associated with a class of service — guaranteed uptime percentage, MTTR targets, latency thresholds, packet loss limits, jitter bounds, and escalation tiers. Distinct from QoS profiles (which are network-layer enforcement parameters). SLA profiles represent the commercial commitment made to the customer. Does NOT own SLA breach detection or credit calculation (assurance and billing domains respectively) — owns only the contractual parameter definition. Managed in Netcracker OSS/BSS product catalog.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`service`.`svc_status_history` (
    `svc_status_history_id` BIGINT COMMENT 'Unique identifier for each service status transition event. Primary key for the service status history log.',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to order.amendment. Business justification: Customer-initiated amendments (plan change, suspension lift) trigger service status transitions recorded in svc_status_history. Linking to the amendment enables billing adjustment reconciliation, cust',
    `billing_account_id` BIGINT COMMENT 'Reference to the billing account responsible for charges related to this service instance. Links service lifecycle to billing and revenue management.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise service status transitions must track corporate account for SLA reporting, contract compliance audits, and account-level service health dashboards. Essential for B2B service management.',
    `enterprise_contract_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_contract. Business justification: Service status transitions (suspension, termination) trigger contractual obligations such as early termination fees and notice periods. Contract compliance and dispute resolution processes require lin',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: Field-initiated status transitions: technicians manually trigger service status changes (reactivation after repair, suspension enforcement). The existing initiating_actor_name is a denormalized techni',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Status transitions on service instances that are components of managed services must be tracked against the managed service for NOC incident correlation, SLA measurement, and managed service health da',
    `provisioning_order_id` BIGINT COMMENT 'Reference to the order that triggered this status transition, if applicable. Links service lifecycle events to the order management domain for fulfillment tracking.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Service lifecycle transitions (suspension, termination, reinstatement) are governed by specific regulatory obligations (mandatory notice periods, consumer protection rules). svc_status_history has reg',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber who owns or uses the service instance. Links service lifecycle events to the customer domain for churn and retention analysis.',
    `svc_instance_id` BIGINT COMMENT 'Reference to the service instance that underwent the status transition. Links to the service instance master record.',
    `svc_suspension_id` BIGINT COMMENT 'Foreign key linking to service.svc_suspension. Business justification: svc_status_history is an append-only audit log of every lifecycle state transition for a service instance. When a suspension event triggers a status change (e.g., ACTIVE → SUSPENDED or SUSPENDED → ACT',
    `trouble_ticket_id` BIGINT COMMENT 'Reference to the trouble ticket or incident that caused this status transition, if applicable. Links service disruptions to fault management processes.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to workforce.work_order. Business justification: Work order completion triggers service status transitions: when a technician completes a repair or installation work order, the service status changes (e.g., SUSPENDED→ACTIVE). Linking svc_status_hist',
    `actual_duration_minutes` STRING COMMENT 'The actual elapsed time for this status transition to complete, measured in minutes. Compared against SLA targets to determine compliance.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicator of whether this status transition required managerial or system approval before execution. True for high-risk transitions such as bulk disconnections or regulatory-mandated changes.',
    `approval_status` STRING COMMENT 'The approval workflow state for this status transition. Captures whether the transition was approved, rejected, is pending approval, or did not require approval.. Valid values are `pending|approved|rejected|not_required`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the status transition was approved. Used to measure approval cycle time and ensure timely execution of approved changes.',
    `approved_by` STRING COMMENT 'Identifier or name of the person or system that approved this status transition. Used for accountability and audit trail purposes.',
    `churn_category` STRING COMMENT 'Classification of the churn event by root cause. Distinguishes between voluntary customer-initiated churn, involuntary disconnection for non-payment, competitive loss to another provider, customer relocation, financial hardship, or service quality issues.. Valid values are `voluntary|involuntary|competitive|relocation|financial|quality`',
    `churn_indicator_flag` BOOLEAN COMMENT 'Indicator of whether this status transition represents a customer churn event. True when the transition to terminated status is customer-initiated and represents loss of revenue.',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or context related to this status transition. Captures information not structured elsewhere for future reference and dispute resolution.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this status history record was first created in the data platform. Immutable audit timestamp for data lineage and compliance.',
    `dispute_eligible_flag` BOOLEAN COMMENT 'Indicator of whether this status transition is eligible for customer dispute. True for transitions that can be contested through formal dispute resolution processes.',
    `effective_date` DATE COMMENT 'The calendar date on which the new status became effective for billing and service delivery purposes. May differ from transition timestamp for scheduled changes.',
    `initiating_actor_type` STRING COMMENT 'Classification of the entity that triggered the status transition. Distinguishes between customer self-service actions, customer service representative interventions, automated system processes, network-driven events, billing system actions, or regulatory mandates.. Valid values are `customer|csr|system|network|billing|regulatory`',
    `new_status` STRING COMMENT 'The lifecycle state of the service instance after this transition. Captures the to-state in the state machine. This becomes the current status of the service instance.. Valid values are `pending|active|suspended|terminated|provisioning|deprovisioning`',
    `notification_channel` STRING COMMENT 'The communication channel used to notify the customer of this status transition. Captures how the customer was informed of the service state change.. Valid values are `email|sms|push|ivr|portal|none`',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicator of whether a customer notification was sent regarding this status transition. True if notification was dispatched via email, SMS, or other channel.',
    `notification_timestamp` TIMESTAMP COMMENT 'The date and time when the customer notification was sent. Used to verify compliance with notification timing requirements and customer communication SLAs.',
    `previous_status` STRING COMMENT 'The lifecycle state of the service instance immediately before this transition occurred. Captures the from-state in the state machine.. Valid values are `pending|active|suspended|terminated|provisioning|deprovisioning`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicator of whether this status transition was subject to regulatory compliance requirements such as disconnection notice periods mandated by FCC or state public utility commissions.',
    `regulatory_notice_period_days` STRING COMMENT 'The minimum number of days advance notice required by regulation before this type of status transition can occur. Applicable to disconnections and suspensions.',
    `rollback_flag` BOOLEAN COMMENT 'Indicator of whether this status transition represents a rollback or reversal of a previous transition. True when a failed provisioning or erroneous suspension is reversed.',
    `rollback_reference_code` BIGINT COMMENT 'Reference to the original status history record that this transition is rolling back. Links forward and reverse transitions for audit trail completeness.',
    `scheduled_flag` BOOLEAN COMMENT 'Indicator of whether this status transition was scheduled in advance or occurred immediately. True for pre-planned transitions such as scheduled maintenance or future-dated disconnections.',
    `service_technology` STRING COMMENT 'The underlying network technology delivering the service. Examples include LTE, 5G NR, GPON, FTTH, DSL, cable, or satellite. Used for technology-specific lifecycle analysis.',
    `service_type` STRING COMMENT 'Classification of the service instance that underwent this status transition. Examples include mobile voice, mobile data, broadband internet, IPTV, VoIP, FTTH, or enterprise connectivity services.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicator of whether this status transition violated contractual SLA commitments. True if the transition timing or duration exceeded agreed service level targets.',
    `sla_target_duration_minutes` STRING COMMENT 'The contractual maximum time allowed for this type of status transition to complete, measured in minutes. Used to calculate SLA compliance.',
    `source_system` STRING COMMENT 'Name of the operational system that recorded and published the status transition event. Examples include Oracle OSM, Netcracker OSS, Salesforce CRM, or Amdocs billing system.',
    `source_system_event_code` STRING COMMENT 'Unique identifier of the status change event in the originating operational system. Enables traceability back to the source system for detailed investigation and reconciliation.',
    `transition_reason_code` STRING COMMENT 'Standardized code indicating the business reason for the status change. Examples include customer request, non-payment, network fault, service upgrade, regulatory order, or system-initiated action.',
    `transition_reason_description` STRING COMMENT 'Free-text explanation providing additional context for the status transition. Captures details not conveyed by the reason code alone, such as specific customer requests or technical fault descriptions.',
    `transition_timestamp` TIMESTAMP COMMENT 'The exact date and time when the service status transition occurred. This is the business event timestamp used for SLA measurement, compliance reporting, and churn analysis.',
    `win_back_eligible_flag` BOOLEAN COMMENT 'Indicator of whether the customer associated with this terminated service is eligible for win-back marketing campaigns. Used to trigger retention and reacquisition workflows.',
    `created_by` STRING COMMENT 'Identifier of the system process or user that created this status history record. Used for data lineage and troubleshooting data quality issues.',
    CONSTRAINT pk_svc_status_history PRIMARY KEY(`svc_status_history_id`)
) COMMENT 'Append-only audit log of every lifecycle state transition for a service instance — from pending through active, suspended, and terminated states. Captures previous state, new state, transition timestamp, reason code, initiating actor (customer, CSR, automated system), and source system event reference. Immutable record essential for SLA measurement, regulatory compliance (disconnection timelines), churn analysis, and dispute resolution.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`service`.`number_assignment` (
    `number_assignment_id` BIGINT COMMENT 'Unique identifier for the number assignment record. Primary key.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: MSISDN assignments drive billing account setup for number portability, vanity number fees, and regulatory compliance. Telecom billing requires account linkage for porting charges, number reservation f',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise DID number block assignments must link to corporate account for inventory management, billing, and number resource allocation tracking in B2B voice services and UC deployments.',
    `enterprise_contract_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_contract. Business justification: Number blocks (DIDs, toll-free) assigned to enterprise customers are governed by enterprise contracts specifying number portability rights and regulatory obligations. Number management, porting operat',
    `fraud_case_id` BIGINT COMMENT 'Foreign key linking to assurance.fraud_case. Business justification: MSISDN/number assignments are primary targets of telecom fraud (SIM swap, number hijacking, CLI spoofing). When fraud is detected on a specific number, the fraud_case must be linked to the number_assi',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to order.fulfillment_order. Business justification: MSISDN assignment and MNP porting are initiated by a fulfillment order. Linking number_assignment to fulfillment_order enables number portability regulatory audit trails, per-order number allocation r',
    `lawful_intercept_order_id` BIGINT COMMENT 'Foreign key linking to compliance.lawful_intercept_order. Business justification: Intercept orders specify target MSISDNs; number assignments track which service instance currently owns each MSISDN. LEA fulfillment workflows require this link to identify the correct service instanc',
    `mnp_compliance_id` BIGINT COMMENT 'Foreign key linking to compliance.mnp_compliance. Business justification: Number portability is a core telecom regulatory process. number_assignment tracks porting_status, porting_direction, donor_carrier_code, recipient_carrier_code — all MNP attributes. Direct FK to mnp_c',
    `mnp_transaction_id` BIGINT COMMENT 'Foreign key linking to interconnect.mnp_transaction. Business justification: MSISDN assignments link to MNP transactions when number portability occurs. Essential for porting workflow tracking, regulatory compliance reporting, and HLR/NPAC routing updates.',
    `msisdn_range_id` BIGINT COMMENT 'Reference to the regulatory number range from which this number was allocated. Links to the inventory domain number range master.',
    `mvno_profile_id` BIGINT COMMENT 'Foreign key linking to partner.mvno_profile. Business justification: MSISDN assignments within MVNO number ranges must track MVNO owner for number inventory management, regulatory ownership reporting, porting coordination, and wholesale billing. Core MVNO operational r',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Number assignments are governed by regulatory obligations (national numbering plan rules, NANP regulations, emergency services requirements). number_assignment has regulatory_ownership and regulatory_',
    `sim_stock_id` BIGINT COMMENT 'Foreign key linking to inventory.sim_stock. Business justification: A phone number (MSISDN) assignment is bound to a specific SIM card — the SIM physically carries the IMSI/MSISDN. Telecom number management requires this link for SIM swap workflows, number portability',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber who owns this number assignment. Enables customer-level number inventory reporting.',
    `svc_instance_id` BIGINT COMMENT 'Reference to the active service instance to which this number is assigned. Links the number to the provisioned service.',
    `uc_subscription_id` BIGINT COMMENT 'Foreign key linking to enterprise.uc_subscription. Business justification: DID numbers assigned to enterprise customers map directly to UC subscriptions for seat-to-DID assignment. UC provisioning, billing reconciliation, and E911 registration processes require knowing which',
    `activation_timestamp` TIMESTAMP COMMENT 'The precise date and time when the number was activated for service use. Distinct from assignment date; activation may occur after assignment.',
    `area_code` STRING COMMENT 'The geographic area code or national destination code portion of the number. Applicable to geographic numbers.. Valid values are `^[0-9]{1,5}$`',
    `assignment_date` DATE COMMENT 'The date when the number was assigned to the service instance. Marks the start of the assignment lifecycle.',
    `assignment_reason` STRING COMMENT 'The business reason for this number assignment. Distinguishes between new activations, replacements, and porting scenarios.. Valid values are `new_activation|replacement|port_in|upgrade|migration`',
    `assignment_status` STRING COMMENT 'Current lifecycle state of the number assignment. Active indicates the number is in service; reserved indicates temporary hold; quarantined indicates cooling-off period post-release; ported_out indicates number transferred to another carrier.. Valid values are `active|reserved|suspended|quarantined|released|ported_out`',
    `cnam_display_name` STRING COMMENT 'The caller ID display name associated with this number. Used for outbound call identification.',
    `country_code` STRING COMMENT 'Three-letter ISO country code indicating the geographic jurisdiction of the number. Critical for regulatory reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this number assignment record was first created in the system. Audit trail field.',
    `do_not_call_registry_flag` BOOLEAN COMMENT 'Indicates whether the subscriber has registered this number on the national Do Not Call registry. Restricts telemarketing calls.',
    `donor_carrier_code` STRING COMMENT 'The carrier code of the previous service provider from which the number was ported in. Nullable if the number was not ported.. Valid values are `^[A-Z0-9]{3,10}$`',
    `emergency_services_enabled` BOOLEAN COMMENT 'Indicates whether the number is enabled for emergency services (E911, E112). Critical for regulatory compliance and public safety.',
    `external_reference_code` STRING COMMENT 'The unique identifier for this number assignment in the source system. Enables cross-system reconciliation.',
    `hlr_location` STRING COMMENT 'The HLR or HSS node where the subscriber profile for this number is stored. Critical for routing and service provisioning.',
    `imsi` STRING COMMENT 'The IMSI associated with the service instance to which this number is assigned. Links the number to the subscriber identity in the HLR/HSS.. Valid values are `^[0-9]{14,15}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this number assignment record was last updated. Audit trail field.',
    `lidb_listing_flag` BOOLEAN COMMENT 'Indicates whether the number is listed in the LIDB for billing and validation purposes. Applicable primarily to North American carriers.',
    `managed_in_system` STRING COMMENT 'The source system of record where this number assignment is managed. Typically Oracle OSM or Netcracker OSS.',
    `modified_by` STRING COMMENT 'The user or system process that last modified this number assignment record. Audit trail field.',
    `msisdn` STRING COMMENT 'The assigned telephone number in E.164 international format. This is the primary business identifier for mobile number assignments.. Valid values are `^+?[1-9]d{1,14}$`',
    `notes` STRING COMMENT 'Free-text notes capturing additional context about the number assignment, such as special handling instructions or customer requests.',
    `number_category` STRING COMMENT 'Service category for which the number is assigned. Distinguishes between human-facing and machine-to-machine usage.. Valid values are `mobile|fixed_line|voip|machine_to_machine|iot`',
    `number_type` STRING COMMENT 'Classification of the assigned number based on regulatory and technical categorization. Determines routing, billing, and regulatory treatment.. Valid values are `geographic|non_geographic|toll_free|premium_rate|short_code|voip_did`',
    `number_usage_type` STRING COMMENT 'Indicates the primary service type for which the number is used. Some numbers may be voice-only, SMS-only, or support all services.. Valid values are `voice|sms|data|fax|all_services`',
    `port_completion_date` DATE COMMENT 'The date when the MNP port transaction was completed and the number was successfully transferred.',
    `port_request_date` DATE COMMENT 'The date when the MNP port request was initiated. Applicable to both port-in and port-out scenarios.',
    `porting_direction` STRING COMMENT 'Indicates whether this carrier is the donor (port_out) or recipient (port_in) in an MNP transaction. None indicates the number originated with this carrier.. Valid values are `none|port_in|port_out`',
    `porting_status` STRING COMMENT 'Current state of the number in the MNP porting workflow. Tracks whether the number was ported in from another carrier or is being ported out.. Valid values are `not_ported|port_in_pending|port_in_complete|port_out_pending|port_out_complete`',
    `previous_msisdn` STRING COMMENT 'The previous number assigned to this service instance, if this is a replacement assignment. Supports number change history tracking.. Valid values are `^+?[1-9]d{1,14}$`',
    `quarantine_end_date` DATE COMMENT 'The date when the number exits the regulatory quarantine period and becomes available for reassignment. Applicable after release to prevent customer confusion.',
    `recipient_carrier_code` STRING COMMENT 'The carrier code of the new service provider to which the number is being ported out. Nullable if the number is not being ported out.. Valid values are `^[A-Z0-9]{3,10}$`',
    `regulatory_ownership` STRING COMMENT 'Indicates whether the carrier owns the number range outright, leases it from the regulator, or sub-allocates it from another carrier.. Valid values are `owned|leased|sub_allocated`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this number assignment must be included in regulatory number inventory reports to FCC, Ofcom, or BEREC.',
    `release_date` DATE COMMENT 'The date when the number was released from the service instance and returned to inventory. Nullable for active assignments.',
    `reservation_expiry_date` DATE COMMENT 'The date when a reserved number assignment expires if not activated. Applicable only to reserved status assignments.',
    `routing_number` STRING COMMENT 'The network routing number used for call and SMS routing. May differ from the MSISDN in ported number scenarios.. Valid values are `^[0-9]{6,15}$`',
    `vanity_number_flag` BOOLEAN COMMENT 'Indicates whether the number is a vanity or premium number with special alphanumeric patterns or easy-to-remember sequences. May carry premium pricing.',
    CONSTRAINT pk_number_assignment PRIMARY KEY(`number_assignment_id`)
) COMMENT 'Master record managing the assignment of MSISDN (mobile numbers), DID numbers, and VoIP DIDs to active service instances. Tracks number type (geographic, non-geographic, toll-free, short code), assignment date, porting status (MNP donor/recipient), number reservation state, and regulatory number range ownership. Supports MNP port-in and port-out workflows. Critical for regulatory number inventory reporting to FCC/Ofcom/BEREC. Does NOT own the number pool inventory (inventory domain) — owns only the active assignment binding between a number and a service instance.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`service`.`svc_suspension` (
    `svc_suspension_id` BIGINT COMMENT 'Unique identifier for the service suspension event. Primary key.',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: Field enforcement of suspension orders: when a service suspension requires physical CPE disconnection at premises, a technician is dispatched. Telecom ops tracks which technician executed the physical',
    `billing_account_id` BIGINT COMMENT 'Reference to the billing account associated with the suspended service. Used for billing impact tracking in Amdocs Revenue Management.',
    `case_id` BIGINT COMMENT 'Reference to the customer service case in Salesforce CRM associated with this suspension. Used for tracking customer interactions, disputes, and resolution workflows. Null if no case was created.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise service suspensions must track corporate account for contract impact analysis, billing adjustments, account-level suspension policies, and escalation to account management teams in B2B scen',
    `enterprise_contract_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_contract. Business justification: Enterprise service suspensions must be evaluated against contractual terms including minimum notice periods and regulatory compliance clauses. Contract management and legal teams require this link for',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the service order in Oracle OSM that executed the suspension or reinstatement. Links to the order management and fulfillment workflow. Null if no formal order was created.',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Managed service suspensions must reference the managed service to trigger NOC alerts, SLA exclusion windows, and customer notifications. Managed service operations and SLA breach exclusion processing ',
    `dealer_id` BIGINT COMMENT 'Foreign key linking to partner.dealer. Business justification: Suspensions of dealer-originated services require tracking originating dealer for fraud pattern analysis, commission clawback processing, and dealer compliance monitoring. Essential for indirect chann',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Telecom regulators mandate specific suspension procedures: notice periods, emergency services preservation, reinstatement timelines. svc_suspension has regulatory_compliance_flag and notice_period_day',
    `retention_offer_id` BIGINT COMMENT 'Foreign key linking to sales.retention_offer. Business justification: During a suspension event, a retention offer is frequently presented to prevent churn before disconnection. Linking svc_suspension to the retention_offer applied enables retention effectiveness measur',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber whose service was suspended. Links to the customer subscriber record in Salesforce CRM.',
    `svc_instance_id` BIGINT COMMENT 'Reference to the service instance that was suspended. Links to the active service instance in the service inventory managed by Oracle OSM and Netcracker OSS.',
    `actual_reinstatement_date` DATE COMMENT 'The actual date when the service was reinstated and became active again. Null if the service has not yet been reinstated. Format: yyyy-MM-dd.',
    `actual_reinstatement_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the service was reinstated in the network. Captured from Oracle OSM service fulfillment system. Null if not yet reinstated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `auto_reinstatement_enabled` BOOLEAN COMMENT 'Indicates whether the service will be automatically reinstated when conditions are met. True: automatic reinstatement configured (e.g., upon payment receipt). False: manual reinstatement required. Common for payment-related suspensions integrated with Amdocs Revenue Management.',
    `billing_adjustment_applied` BOOLEAN COMMENT 'Indicates whether a billing adjustment or credit was applied to the account due to the suspension. True if adjustments were made, False otherwise. Used for revenue assurance and customer account reconciliation.',
    `billing_impact_flag` BOOLEAN COMMENT 'Indicates whether recurring charges continue during the suspension period. True: charges continue (customer still billed). False: charges are suspended (no billing during suspension). Critical for Amdocs Revenue Management billing cycle processing and customer billing inquiries.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the suspension record was first created in the system. Represents when the suspension request was initiated, not when it became effective. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `customer_acknowledgement_received` BOOLEAN COMMENT 'Indicates whether the customer acknowledged receipt of the suspension notice. True: customer confirmed receipt. False: no acknowledgement received. Used for dispute resolution and regulatory compliance.',
    `emergency_services_allowed` BOOLEAN COMMENT 'Indicates whether emergency services (e.g., 911, E911) remain accessible during the suspension. True: emergency calls are allowed. False: all services including emergency are blocked. Regulatory compliance requirement per FCC and E911 regulations.',
    `expected_reinstatement_date` DATE COMMENT 'The planned or expected date when the service will be reinstated. For voluntary suspensions, this is the customer-requested end date. For involuntary suspensions, this may be calculated based on payment terms or regulatory requirements. Nullable for indefinite suspensions. Format: yyyy-MM-dd.',
    `initiated_by` STRING COMMENT 'Indicates who or what initiated the suspension. Customer: customer-requested. System: automated system action (e.g., dunning workflow). Agent: customer service representative. Regulatory: regulatory authority order. Fraud_detection: automated fraud detection system.. Valid values are `customer|system|agent|regulatory|fraud_detection`',
    `initiated_channel` STRING COMMENT 'The channel through which the suspension was initiated. Web: online self-service portal. Mobile_app: mobile application. Call_center: customer service call. Retail_store: in-store request. Automated_system: system-generated. Partner_portal: partner or MVNO portal.. Valid values are `web|mobile_app|call_center|retail_store|automated_system|partner_portal`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the suspension record was last updated. Tracks changes to status, dates, or other attributes throughout the suspension lifecycle. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified the suspension record. Used for audit trail and change tracking. Links to Salesforce CRM user records or system process identifiers.',
    `network_suspension_applied` BOOLEAN COMMENT 'Indicates whether the suspension was successfully applied at the network level. True: service is blocked in the network (RAN, Core, IMS). False: suspension is pending network execution or failed. Critical for operational validation.',
    `network_suspension_timestamp` TIMESTAMP COMMENT 'Timestamp when the suspension was successfully applied in the network infrastructure (HSS, HLR, UDM, PCF). Captured from Ericsson Network Manager or Nokia NetAct. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notes` STRING COMMENT 'Free-text notes and comments about the suspension event. Used by customer service representatives to document special circumstances, customer requests, or operational issues. Captured in Salesforce CRM case notes.',
    `notice_method` STRING COMMENT 'Method used to notify the customer of the pending suspension. Multiple: more than one method was used. Required for regulatory compliance documentation.. Valid values are `email|sms|postal_mail|phone_call|in_app|multiple`',
    `notice_period_days` STRING COMMENT 'Number of days of advance notice provided to the customer before involuntary suspension. Required by regulatory authorities (typically 15-30 days). Null for voluntary or immediate suspensions.',
    `notice_sent_date` DATE COMMENT 'Date when the suspension notice was sent to the customer. Required for involuntary suspensions to demonstrate regulatory compliance. Null for voluntary suspensions. Format: yyyy-MM-dd.',
    `prorated_charge_amount` DECIMAL(18,2) COMMENT 'The prorated charge amount applied for partial billing periods affected by the suspension. Calculated by Amdocs Revenue Management based on suspension dates and rate plan. Null if no proration applies.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the suspension complies with regulatory requirements for involuntary disconnection. True: all regulatory notice periods and procedures were followed. False: suspension may be non-compliant. Critical for FCC, state PUC, and international regulatory audits.',
    `reinstatement_condition` STRING COMMENT 'Description of the conditions that must be met for service reinstatement. Examples: payment of outstanding balance, resolution of fraud investigation, completion of regulatory hold period, customer request. Used by collections and customer service teams.',
    `reinstatement_condition_met` BOOLEAN COMMENT 'Indicates whether the reinstatement conditions have been satisfied. True: conditions met, service can be reinstated. False: conditions not yet met. Null if not applicable or not yet evaluated.',
    `reinstatement_fee_amount` DECIMAL(18,2) COMMENT 'One-time fee charged to the customer for reinstating the suspended service. Common for involuntary suspensions due to non-payment. Null if no fee is charged. Amount in the billing account currency.',
    `service_barring_profile` STRING COMMENT 'The network barring profile applied during suspension. Defines which services are blocked (e.g., outgoing calls only, all services, data only). Managed in Netcracker OSS service catalog and applied via IMS/PCF policy control.',
    `suspension_duration_days` STRING COMMENT 'Calculated number of days the service was or is expected to be suspended. For active suspensions, this is calculated from start date to current date. For completed suspensions, this is the actual duration from start to reinstatement.',
    `suspension_fee_amount` DECIMAL(18,2) COMMENT 'One-time fee charged to the customer for processing the suspension request. Typically applies to voluntary suspensions. Null if no fee is charged. Amount in the billing account currency.',
    `suspension_reason_code` STRING COMMENT 'Standardized code indicating the specific reason for suspension. Examples: NONPAY (non-payment), FRAUD (fraud detection), TRAVEL (customer travel hold), DISPUTE (billing dispute), REGULATORY (regulatory order), TECHNICAL (network issue). Aligns with Amdocs Revenue Management dunning codes and ServiceNow incident categories.. Valid values are `^[A-Z0-9]{3,10}$`',
    `suspension_reason_description` STRING COMMENT 'Detailed human-readable explanation of why the service was suspended. Provides context beyond the reason code for customer service representatives and audit purposes.',
    `suspension_reference_number` STRING COMMENT 'Externally visible unique reference number for the suspension event. Format: SUS-XXXXXXXXXX. Used for customer communication and case tracking.. Valid values are `^SUS-[0-9]{10}$`',
    `suspension_start_date` DATE COMMENT 'The date when the service suspension became effective. This is the actual date the service was suspended, not the request date. Format: yyyy-MM-dd.',
    `suspension_start_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the service suspension was activated in the network. Captured from Oracle OSM service fulfillment system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `suspension_status` STRING COMMENT 'Current lifecycle status of the suspension event. Pending: suspension scheduled but not yet active. Active: service currently suspended. Reinstated: service has been restored. Expired: suspension period ended without reinstatement. Cancelled: suspension request was cancelled before activation.. Valid values are `pending|active|reinstated|expired|cancelled`',
    `suspension_type` STRING COMMENT 'Classification of the suspension event. Voluntary: customer-initiated (e.g., travel hold, seasonal suspension). Involuntary: provider-initiated due to non-payment, policy violation, or fraud. Administrative: internal operational suspension. Regulatory: mandated by regulatory authority. Technical: network or service quality issue. Fraud: suspected fraudulent activity.. Valid values are `voluntary|involuntary|administrative|regulatory|technical|fraud`',
    CONSTRAINT pk_svc_suspension PRIMARY KEY(`svc_suspension_id`)
) COMMENT 'Transactional record for each service suspension event — voluntary (customer-initiated travel hold) or involuntary (non-payment, fraud, regulatory). Captures suspension type, initiating reason code, suspension start date, expected reinstatement date, actual reinstatement date, and the billing impact flag (whether charges continue during suspension). Supports collections workflow integration with Amdocs Revenue Management and regulatory compliance for involuntary disconnection rules.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`service`.`svc_location` (
    `svc_location_id` BIGINT COMMENT 'Unique identifier for the service delivery location. Primary key for the service location entity.',
    `fiber_cable_id` BIGINT COMMENT 'Foreign key linking to inventory.fiber_cable. Business justification: A service location is physically connected via a specific fiber cable segment. Telecom network operations require this link for fiber cut impact analysis (identifying all affected service locations), ',
    `olt_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.olt_asset. Business justification: A service location is served by a specific OLT asset in the fiber access network. Telecom NOC operations require this link for OLT capacity planning, mass outage customer impact assessment, and FTTH s',
    `depot_id` BIGINT COMMENT 'Foreign key linking to workforce.depot. Business justification: Depot-to-location service zone assignment: each service location is served by a responsible depot whose technicians are dispatched there. Telecom field ops uses this for dispatch optimization, SLA rep',
    `element_id` BIGINT COMMENT 'Foreign key linking to network.element. Business justification: A service location (premises) is served by a specific network element (OLT, DSLAM, cabinet switch). Fault impact analysis, serviceability checks, and capacity planning require this link. Role prefix ',
    `ran_cell_id` BIGINT COMMENT 'Foreign key linking to network.ran_cell. Business justification: For Fixed Wireless Access (FWA) and 5G home broadband, a service location is assigned a primary serving RAN cell. Coverage outage analysis and capacity planning depend on this link. Role prefix servi',
    `site_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_site. Business justification: A service location (network delivery point) corresponds to an enterprise site (business entity). Network planning, service delivery, and field operations require mapping service locations to enterpris',
    `spectrum_license_id` BIGINT COMMENT 'Foreign key linking to compliance.spectrum_license. Business justification: Wireless service locations must be within the geographic coverage area of a spectrum license. Regulators require operators to demonstrate spectrum is used within licensed territories. Linking svc_loca',
    `access_restrictions` STRING COMMENT 'Notes on any physical access restrictions or special requirements for field technicians (e.g., gated community, security clearance required).',
    `access_technology` STRING COMMENT 'Primary network access technology available at this service location. FTTH = Fiber to the Home, FTTC = Fiber to the Curb, DSL = Digital Subscriber Line.. Valid values are `ftth|fttc|dsl|cable|fixed_wireless|satellite`',
    `active_service_count` STRING COMMENT 'Number of active service instances currently provisioned at this location.',
    `address_line_1` STRING COMMENT 'Primary street address line for the service delivery location (street number and name).',
    `address_line_2` STRING COMMENT 'Secondary address line for the service delivery location (unit, suite, apartment number).',
    `building_type` STRING COMMENT 'Classification of the building structure at the service location. [ENUM-REF-CANDIDATE: single_family|multi_family|office|retail|warehouse|mixed_use|other — 7 candidates stripped; promote to reference product]',
    `cabinet_identifier` STRING COMMENT 'Identifier for the street cabinet or distribution point serving this location for FTTC deployments.',
    `central_office_code` STRING COMMENT 'Identifier for the central office or exchange facility serving this location.. Valid values are `^[A-Z0-9]{4,12}$`',
    `city` STRING COMMENT 'City or municipality name for the service delivery location.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the service delivery location.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service location record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this service location was decommissioned or became unavailable for service provisioning.',
    `effective_start_date` DATE COMMENT 'Date when this service location became active and available for service provisioning.',
    `external_location_code` STRING COMMENT 'Identifier for this location in external systems such as Oracle OSM, Netcracker OSS, or third-party GIS platforms.',
    `fiber_availability` BOOLEAN COMMENT 'Indicates whether fiber optic infrastructure is available at this location.',
    `five_g_coverage` BOOLEAN COMMENT 'Indicates whether 5G New Radio (NR) mobile network coverage is available at this location.',
    `geocode_accuracy` STRING COMMENT 'Precision level of the latitude/longitude coordinates for the service location.. Valid values are `rooftop|parcel|street|postal_code|city|unknown`',
    `installation_complexity` STRING COMMENT 'Assessment of the complexity level for service installation at this location, used for workforce planning and scheduling.. Valid values are `standard|moderate|complex|very_complex`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service location record was last updated.',
    `last_survey_date` DATE COMMENT 'Date when the location was last surveyed for serviceability or network infrastructure assessment.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the service delivery location in decimal degrees.',
    `location_code` STRING COMMENT 'Business-assigned unique code for the service location, used for operational reference and field dispatch.. Valid values are `^[A-Z0-9]{6,20}$`',
    `location_name` STRING COMMENT 'Descriptive name or label for the service location (e.g., building name, site name).',
    `location_notes` STRING COMMENT 'Free-text notes or special instructions related to this service location for operational reference.',
    `location_status` STRING COMMENT 'Current operational status of the service location record.. Valid values are `active|inactive|pending|decommissioned`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the service delivery location in decimal degrees.',
    `managed_in_system` STRING COMMENT 'Name of the source system that manages this service location record (e.g., Oracle OSM, Netcracker OSS, Salesforce CRM).',
    `maximum_bandwidth_mbps` STRING COMMENT 'Maximum bandwidth capacity available at this location in megabits per second, based on access technology and network infrastructure.',
    `modified_by` STRING COMMENT 'User or system identifier that last modified this service location record.',
    `network_serving_area_code` STRING COMMENT 'Code identifying the network serving area or exchange that serves this location. Used for network planning and capacity management.. Valid values are `^[A-Z0-9]{4,12}$`',
    `olt_identifier` STRING COMMENT 'Identifier for the OLT equipment serving this location for FTTH/GPON deployments.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the service delivery location.',
    `premises_type` STRING COMMENT 'Classification of the premises where service is delivered. MDU = Multi-Dwelling Unit.. Valid values are `residential|commercial|mdu|industrial|government|educational`',
    `regulatory_zone` STRING COMMENT 'Regulatory or franchise zone identifier for this location, used for compliance reporting and service obligation tracking.',
    `serviceability_status` STRING COMMENT 'Indicates whether the location can currently be served with telecommunications services.. Valid values are `serviceable|non_serviceable|planned|under_construction|pending_survey`',
    `state_province` STRING COMMENT 'State, province, or region for the service delivery location.',
    `surveyed_by` STRING COMMENT 'Name or identifier of the technician or team who conducted the last survey.',
    `unit_count` STRING COMMENT 'Number of individual units or dwellings at this location (relevant for MDU premises).',
    `universal_service_eligible` BOOLEAN COMMENT 'Indicates whether this location is eligible for universal service funding or subsidies.',
    CONSTRAINT pk_svc_location PRIMARY KEY(`svc_location_id`)
) COMMENT 'Master record for the service delivery location associated with a fixed-line or broadband service instance — civic address, geographic coordinates, premises type (residential/commercial/MDU), access technology at that location (FTTH/FTTC/DSL/cable), serviceability status, and the network serving area (NSA) or exchange reference. Distinct from customer billing address — this is the physical location where the service is delivered. Critical for field dispatch, network planning, and regulatory coverage reporting.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`service`.`dependency` (
    `dependency_id` BIGINT COMMENT 'Unique identifier for the service dependency relationship record. Primary key for the service dependency entity.',
    `addon_id` BIGINT COMMENT 'Foreign key linking to product.addon. Business justification: Service dependencies may require a specific addon to be active (e.g., VoLTE requires IMS addon, international roaming requires roaming addon). Telecom provisioning orchestration and eligibility valida',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to product.bundle. Business justification: Service dependencies defined at the bundle level (e.g., bundle requires broadband + voice components) must reference the product bundle. Telecom provisioning orchestration uses bundle-level dependency',
    `svc_instance_id` BIGINT COMMENT 'Reference to the child or dependent service instance in the dependency relationship. For bundle compositions, this is a component service (e.g., broadband, VoIP, or IPTV within triple-play). For technology dependencies, this is the dependent service (e.g., VoLTE service depending on data bearer). For 5G network slices, this is the underlying connectivity service. For wholesale/MVNO scenarios, this is the virtual service layer.',
    `dependency_svc_instance_id` BIGINT COMMENT 'Reference to the parent service instance in the dependency relationship. For bundle compositions, this is the container service (e.g., triple-play bundle). For technology dependencies, this is the prerequisite service (e.g., data bearer for VoLTE). For 5G network slices, this is the slice instance. For wholesale/MVNO scenarios, this is the host carrier service.',
    `mvno_profile_id` BIGINT COMMENT 'Foreign key linking to partner.mvno_profile. Business justification: Service dependencies in MVNO wholesale bundles (signaled by mvno_wholesale_flag) must reference the MVNO profile to enforce MVNO-specific dependency rules, bundle composition constraints, and QoS/SLA ',
    `parent_dependency_id` BIGINT COMMENT 'Self-referencing FK on dependency (parent_dependency_id)',
    `offering_id` BIGINT COMMENT 'Reference to the commercial product offering that defines this dependency relationship. Links the runtime dependency instance back to the catalog definition. Used to trace dependencies to their product catalog source and understand which commercial bundles drive which service dependencies.',
    `provisioning_order_id` BIGINT COMMENT 'Reference to the provisioning order that established this service dependency. Used for traceability and audit purposes. Enables linking dependency creation back to the originating order for troubleshooting and compliance reporting.',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber who owns or is associated with the service dependency relationship. Denormalized for reporting and analytics. Enables quick identification of all service dependencies for a given subscriber without complex joins.',
    `activation_sequence_order` STRING COMMENT 'Numeric order indicating the sequence in which dependent services must be activated. Lower numbers activate first. Used by orchestration systems to ensure correct provisioning sequencing. For example, in a triple-play bundle, broadband (order 1) must activate before VoIP (order 2) and IPTV (order 3).',
    `billing_impact_type` STRING COMMENT 'Indicates how the dependency relationship affects billing. Bundle_discount means the dependency enables bundle pricing or discounts. Separate_billing means each service is billed independently despite the dependency. Consolidated_billing means services are billed together as a single line item. No_impact means the dependency has no billing implications.. Valid values are `bundle_discount|separate_billing|consolidated_billing|no_impact`',
    `bundle_composition_flag` BOOLEAN COMMENT 'Indicates whether this dependency represents a commercial bundle composition (e.g., triple-play, quad-play, family plan). True means this is a bundle relationship where parent is the bundle container and children are component services. False means this is a technical or operational dependency.',
    `child_service_type` STRING COMMENT 'Denormalized service type of the child service instance for faster querying and reporting without joining to service instance table. Examples: voip, iptv, data_bearer, volte, connectivity_service.',
    `created_by_system` STRING COMMENT 'Name of the source system or orchestration engine that created this dependency record. Examples: Oracle OSM, Netcracker OSS, manual entry via CRM. Used for data lineage and troubleshooting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this service dependency record was first created in the system. Used for audit trails and data lineage tracking.',
    `deactivation_sequence_order` STRING COMMENT 'Numeric order indicating the sequence in which dependent services must be deactivated or suspended. Typically reverse of activation order. Used to ensure graceful shutdown without breaking dependencies. For example, IPTV (order 1) deactivates before VoIP (order 2) and broadband (order 3).',
    `dependency_category` STRING COMMENT 'High-level categorization of the dependency purpose. Commercial indicates bundle or pricing-driven relationships. Technical indicates technology stack or protocol dependencies. Regulatory indicates compliance-mandated relationships. Operational indicates process or workflow dependencies.. Valid values are `commercial|technical|regulatory|operational`',
    `dependency_status` STRING COMMENT 'Current lifecycle status of the dependency relationship. Active indicates the dependency is currently in effect. Inactive indicates the dependency exists but is not currently enforced. Suspended indicates temporary hold. Pending indicates the dependency is being established. Terminated indicates the dependency has been permanently removed.. Valid values are `active|inactive|suspended|pending|terminated`',
    `dependency_type` STRING COMMENT 'Classification of the dependency relationship between service instances. Composition indicates bundle/package relationships where parent contains children. Prerequisite indicates one service must exist before another can be activated. Peer indicates services that work together at the same level. Slice_component indicates 5G network slice composition. Wholesale_virtual indicates MVNO host-to-virtual service mapping. Technology_stack indicates layered technology dependencies.. Valid values are `composition|prerequisite|peer|slice_component|wholesale_virtual|technology_stack`',
    `direction` STRING COMMENT 'Indicates the directionality of the dependency relationship. Parent_to_child means parent controls or contains child. Child_to_parent means child requires parent to function. Bidirectional means mutual dependency where both services depend on each other.. Valid values are `parent_to_child|child_to_parent|bidirectional`',
    `effective_end_timestamp` TIMESTAMP COMMENT 'Date and time when the service dependency relationship ended or was terminated. Null indicates the dependency is currently active. Used for historical analysis and audit trails of service relationship changes.',
    `effective_start_timestamp` TIMESTAMP COMMENT 'Date and time when the service dependency relationship became active and enforceable. Used for temporal tracking of dependency lifecycle and historical analysis of service compositions.',
    `external_dependency_code` STRING COMMENT 'External system identifier for this dependency relationship in the source OSS/BSS system. Used for reconciliation and integration with upstream systems. Enables bidirectional traceability between lakehouse and operational systems.',
    `failure_handling_policy` STRING COMMENT 'Defines how provisioning or lifecycle failures should be handled when they occur in the dependency chain. Rollback_all means any failure triggers rollback of all related services. Continue_partial means successful services remain active. Manual_intervention means failures require human review. Retry_automatic means system automatically retries failed operations.. Valid values are `rollback_all|continue_partial|manual_intervention|retry_automatic`',
    `impact_propagation_rule` STRING COMMENT 'Defines how lifecycle changes to the parent service propagate to child services. Cascade_suspend means if parent suspends, children auto-suspend. Cascade_terminate means if parent terminates, children auto-terminate. Notify_only means changes generate alerts but do not auto-propagate. Block_parent_change means parent cannot change state if children are active. Isolate means no propagation occurs.. Valid values are `cascade_suspend|cascade_terminate|notify_only|block_parent_change|isolate`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this service dependency record was last updated. Used for change tracking and audit purposes. Updated whenever any attribute of the dependency relationship changes.',
    `mandatory_dependency_flag` BOOLEAN COMMENT 'Indicates whether the dependency is mandatory for service operation. True means the child service cannot function without the parent, or the parent cannot exist without the child. False means the dependency is optional or advisory. Used by provisioning systems to enforce hard constraints.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user or system process that last modified this dependency record. Used for audit trails and accountability. May be a human user ID or a system service account name.',
    `mvno_wholesale_flag` BOOLEAN COMMENT 'Indicates whether this dependency represents a wholesale or MVNO virtual service layer relationship. True means the parent is a host carrier service and the child is a virtual service provided by an MVNO or wholesale partner. False means this is not a wholesale/MVNO relationship.',
    `network_slice_dependency_flag` BOOLEAN COMMENT 'Indicates whether this dependency represents a 5G network slice composition. True means the parent is a network slice instance and the child is an underlying connectivity or transport service. False means this is not a slice-related dependency. Essential for 5G slice orchestration and lifecycle management.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to this service dependency. Used by operations teams to document exceptions, workarounds, or special handling requirements.',
    `orchestration_constraint` STRING COMMENT 'Free-text description of any special orchestration constraints or rules that apply to this dependency. For example, Parent must be fully activated before child provisioning begins or Child suspension requires 24-hour notice to parent subscriber. Used by OSS orchestration engines.',
    `parent_service_type` STRING COMMENT 'Denormalized service type of the parent service instance for faster querying and reporting without joining to service instance table. Examples: broadband, mobile, bundle, network_slice, wholesale_service.',
    `qos_inheritance_flag` BOOLEAN COMMENT 'Indicates whether the child service inherits QoS profile settings from the parent service. True means child uses parent QoS parameters. False means child has independent QoS configuration. Important for network slice scenarios where slice QoS applies to all component services.',
    `sla_inheritance_flag` BOOLEAN COMMENT 'Indicates whether the child service inherits SLA parameters from the parent service. True means child adopts parent SLA targets and commitments. False means child has independent SLA. Relevant for bundle compositions where all components share a single SLA tier.',
    `strength` STRING COMMENT 'Indicates the strength or enforcement level of the dependency. Hard means the dependency is strictly enforced by provisioning systems and cannot be violated. Soft means the dependency is recommended but can be overridden with approval. Advisory means the dependency is informational only and not enforced.. Valid values are `hard|soft|advisory`',
    CONSTRAINT pk_dependency PRIMARY KEY(`dependency_id`)
) COMMENT 'Master record defining parent-child and peer relationships between service instances — modeling bundle compositions (triple-play: broadband + VoIP + IPTV), technology dependencies (VoLTE depends on data bearer), 5G network slice compositions (slice instance depends on underlying connectivity service), wholesale/MVNO virtual service layers (host service → virtual service mapping), and service groupings (multi-SIM family plans). Captures dependency type (composition, prerequisite, peer, slice-component, wholesale-virtual), parent service instance, child service instance, dependency direction, activation sequencing constraint, and impact propagation rule (e.g., if parent suspends, children auto-suspend). Essential for bundle lifecycle management, 5G slice orchestration, MVNO service modeling, impact analysis during service modifications, and correct provisioning sequencing. Does NOT own the commercial bundle definition (product domain) or the network slice template (network domain) — owns only the instantiated runtime dependency graph.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_parent_service_instance_svc_instance_id` FOREIGN KEY (`parent_service_instance_svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `telecommunication_ecm`.`service`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_svc_location_id` FOREIGN KEY (`svc_location_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_location`(`svc_location_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `telecommunication_ecm`.`service`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_provisioning_order_id` FOREIGN KEY (`provisioning_order_id`) REFERENCES `telecommunication_ecm`.`service`.`provisioning_order`(`provisioning_order_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_svc_configuration_id` FOREIGN KEY (`svc_configuration_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_configuration`(`svc_configuration_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_svc_location_id` FOREIGN KEY (`svc_location_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_location`(`svc_location_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ADD CONSTRAINT `fk_service_svc_configuration_provisioning_order_id` FOREIGN KEY (`provisioning_order_id`) REFERENCES `telecommunication_ecm`.`service`.`provisioning_order`(`provisioning_order_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ADD CONSTRAINT `fk_service_svc_configuration_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `telecommunication_ecm`.`service`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ADD CONSTRAINT `fk_service_svc_configuration_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ADD CONSTRAINT `fk_service_svc_status_history_provisioning_order_id` FOREIGN KEY (`provisioning_order_id`) REFERENCES `telecommunication_ecm`.`service`.`provisioning_order`(`provisioning_order_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ADD CONSTRAINT `fk_service_svc_status_history_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ADD CONSTRAINT `fk_service_svc_status_history_svc_suspension_id` FOREIGN KEY (`svc_suspension_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_suspension`(`svc_suspension_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ADD CONSTRAINT `fk_service_number_assignment_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ADD CONSTRAINT `fk_service_svc_suspension_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ADD CONSTRAINT `fk_service_dependency_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ADD CONSTRAINT `fk_service_dependency_dependency_svc_instance_id` FOREIGN KEY (`dependency_svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ADD CONSTRAINT `fk_service_dependency_parent_dependency_id` FOREIGN KEY (`parent_dependency_id`) REFERENCES `telecommunication_ecm`.`service`.`dependency`(`dependency_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ADD CONSTRAINT `fk_service_dependency_provisioning_order_id` FOREIGN KEY (`provisioning_order_id`) REFERENCES `telecommunication_ecm`.`service`.`provisioning_order`(`provisioning_order_id`);

-- ========= TAGS =========
ALTER SCHEMA `telecommunication_ecm`.`service` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `telecommunication_ecm`.`service` SET TAGS ('dbx_domain' = 'service');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` SET TAGS ('dbx_subdomain' = 'instance_management');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `enterprise_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `iot_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Iot Deployment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Address Pool Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `mvno_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Mvno Profile Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `ont_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ont Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `parent_service_instance_svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Service Instance Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `privacy_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Product Offering Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `qos_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Profile Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `sdwan_topology_id` SET TAGS ('dbx_business_glossary_term' = 'Sdwan Topology Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `sla_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `sla_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Profile Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `slice_id` SET TAGS ('dbx_business_glossary_term' = '5G Network Slice Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `spectrum_license_id` SET TAGS ('dbx_business_glossary_term' = 'Spectrum License Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `svc_location_id` SET TAGS ('dbx_business_glossary_term' = 'Svc Location Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `transmission_link_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Link Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Visited Carrier Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Activation Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `apn` SET TAGS ('dbx_business_glossary_term' = 'Access Point Name (APN)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `auto_renew` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `bandwidth_mbps` SET TAGS ('dbx_business_glossary_term' = 'Bandwidth Megabits Per Second (Mbps)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `cpe_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Premises Equipment (CPE) Serial Number');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `cpe_serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `cpe_serial_number` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `data_allowance_gb` SET TAGS ('dbx_business_glossary_term' = 'Data Allowance Gigabytes (GB)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `deactivation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Deactivation Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `external_service_code` SET TAGS ('dbx_business_glossary_term' = 'External System Service Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `iccid` SET TAGS ('dbx_business_glossary_term' = 'Integrated Circuit Card Identifier (ICCID)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `iccid` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `iccid` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `ims_registered` SET TAGS ('dbx_business_glossary_term' = 'IP Multimedia Subsystem (IMS) Registered Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `imsi` SET TAGS ('dbx_business_glossary_term' = 'International Mobile Subscriber Identity (IMSI)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `imsi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `imsi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Service Lifecycle Status');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'pending|active|suspended|terminated|provisioning_failed|deactivated');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `mac_address` SET TAGS ('dbx_business_glossary_term' = 'Media Access Control (MAC) Address');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `mac_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `mac_address` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `msisdn` SET TAGS ('dbx_business_glossary_term' = 'Mobile Station International Subscriber Directory Number (MSISDN)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `msisdn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `msisdn` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Service Instance Notes');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `provisioning_system` SET TAGS ('dbx_business_glossary_term' = 'Provisioning System Source');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `roaming_enabled` SET TAGS ('dbx_business_glossary_term' = 'Roaming Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `service_class` SET TAGS ('dbx_business_glossary_term' = 'Service Class Segment');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `service_class` SET TAGS ('dbx_value_regex' = 'consumer|enterprise|wholesale|iot|government');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `service_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `service_identifier` SET TAGS ('dbx_business_glossary_term' = 'Service Business Identifier');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type Classification');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `sms_allowance` SET TAGS ('dbx_business_glossary_term' = 'Short Message Service (SMS) Allowance');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Service Suspension Reason');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_value_regex' = 'non_payment|fraud|customer_request|regulatory|technical_issue|temporary_disconnect');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Service Technology Type');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Service Termination Reason');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `voice_minutes_allowance` SET TAGS ('dbx_business_glossary_term' = 'Voice Minutes Allowance');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `volte_enabled` SET TAGS ('dbx_business_glossary_term' = 'Voice over Long-Term Evolution (VoLTE) Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` SET TAGS ('dbx_subdomain' = 'provisioning_operations');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `provisioning_order_id` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Order Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Technician Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `enterprise_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial Order Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `iot_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Iot Deployment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `mnp_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Mnp Compliance Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `ont_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ont Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Carrier Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `sla_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `sla_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Profile Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `activation_task_count` SET TAGS ('dbx_business_glossary_term' = 'Activation Task Count');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `completed_task_count` SET TAGS ('dbx_business_glossary_term' = 'Completed Task Count');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `donor_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Donor Carrier Code');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `failure_step` SET TAGS ('dbx_business_glossary_term' = 'Failure Step');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `fallout_flag` SET TAGS ('dbx_business_glossary_term' = 'Fallout Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `max_retry_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Retry Count');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `mnp_port_type` SET TAGS ('dbx_business_glossary_term' = 'Mobile Number Portability (MNP) Port Type');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `mnp_port_type` SET TAGS ('dbx_value_regex' = 'port_in|port_out|not_applicable');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `network_domain` SET TAGS ('dbx_business_glossary_term' = 'Network Domain');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `orchestration_state` SET TAGS ('dbx_business_glossary_term' = 'Orchestration State');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Order Number');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^PO-[0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Order Status');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Order Type');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `oss_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Operations Support Systems (OSS) Order Reference');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `oss_system` SET TAGS ('dbx_business_glossary_term' = 'Operations Support Systems (OSS) System');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `oss_system` SET TAGS ('dbx_value_regex' = 'oracle_osm|netcracker|nokia_netact|ericsson_nm|amdocs|other');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `porting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Mobile Number Portability (MNP) Porting Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Order Priority');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|critical');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `provisioning_notes` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Notes');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `qos_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Profile Code');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Service Qualification Status');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|not_qualified|pending|not_required');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `recipient_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Recipient Carrier Code');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `requested_activation_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Activation Date');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `target_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Service Test Result');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'passed|failed|not_applicable|pending');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` SET TAGS ('dbx_subdomain' = 'provisioning_operations');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `activation_event_id` SET TAGS ('dbx_business_glossary_term' = 'Activation Event Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Activation Technician Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `addon_id` SET TAGS ('dbx_business_glossary_term' = 'Addon Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `dealer_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `device_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registration Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Cpe Asset Serial Number (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `iot_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Iot Deployment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `mnp_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Mnp Compliance Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `mnp_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Mnp Transaction Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Network Element Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `ont_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ont Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `provisioning_order_id` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Order Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `ran_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Ran Cell Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `roaming_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Roaming Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `sim_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Sim Stock Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `svc_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Svc Configuration Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `svc_location_id` SET TAGS ('dbx_business_glossary_term' = 'Service Location Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Visited Carrier Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `activation_error_code` SET TAGS ('dbx_business_glossary_term' = 'Activation Error Code');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `activation_error_message` SET TAGS ('dbx_business_glossary_term' = 'Activation Error Message');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `activation_method` SET TAGS ('dbx_business_glossary_term' = 'Activation Method');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `activation_method` SET TAGS ('dbx_value_regex' = 'automatic|manual|semi_automatic|remote|field_technician');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `activation_status` SET TAGS ('dbx_business_glossary_term' = 'Activation Status');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `activation_status` SET TAGS ('dbx_value_regex' = 'successful|failed|partial|pending_confirmation|rolled_back');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activation Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `bandwidth_allocated_mbps` SET TAGS ('dbx_business_glossary_term' = 'Bandwidth Allocated (Megabits per Second)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `esim_profile_download_status` SET TAGS ('dbx_business_glossary_term' = 'Embedded Subscriber Identity Module (eSIM) Profile Download Status');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `esim_profile_download_status` SET TAGS ('dbx_value_regex' = 'downloaded|download_failed|not_applicable|pending');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `fallback_activation_flag` SET TAGS ('dbx_business_glossary_term' = 'Fallback Activation Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `fallback_reason` SET TAGS ('dbx_business_glossary_term' = 'Fallback Reason');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `ims_registration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'IP Multimedia Subsystem (IMS) Registration Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `imsi` SET TAGS ('dbx_business_glossary_term' = 'International Mobile Subscriber Identity (IMSI)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `imsi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `imsi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `ip_address_assigned` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address Assigned');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `ip_address_assigned` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `ip_address_assigned` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `msisdn` SET TAGS ('dbx_business_glossary_term' = 'Mobile Station International Subscriber Directory Number (MSISDN)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `msisdn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `msisdn` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `network_element_type` SET TAGS ('dbx_business_glossary_term' = 'Network Element Type');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `network_technology` SET TAGS ('dbx_business_glossary_term' = 'Network Technology');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `provisioning_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Provisioning System Confirmation Reference');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `qos_profile_applied` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Profile Applied');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `retry_attempt_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Attempt Count');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `service_category` SET TAGS ('dbx_value_regex' = 'consumer|business|enterprise|wholesale|MVNO');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `sla_actual_activation_time` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Actual Activation Time');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `sla_target_activation_time` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Activation Time');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Oracle_OSM|Netcracker_OSS|Nokia_NetAct|Ericsson_NM|other');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `vlan_number` SET TAGS ('dbx_business_glossary_term' = 'Virtual Local Area Network (VLAN) Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `volte_registration_status` SET TAGS ('dbx_business_glossary_term' = 'Voice over Long-Term Evolution (VoLTE) Registration Status');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `volte_registration_status` SET TAGS ('dbx_value_regex' = 'registered|not_registered|registration_failed|not_applicable');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` SET TAGS ('dbx_subdomain' = 'instance_management');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `svc_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Service Configuration ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `addon_id` SET TAGS ('dbx_business_glossary_term' = 'Addon Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Configuring Technician Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `device_model_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Premises Equipment (CPE) Device ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `iot_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Iot Deployment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `mvno_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Mvno Profile Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Network Element Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `ont_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ont Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `provisioning_order_id` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Order ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `sdwan_topology_id` SET TAGS ('dbx_business_glossary_term' = 'Sdwan Topology Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `sim_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Sim Stock Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `sla_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Profile Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `spec_id` SET TAGS ('dbx_business_glossary_term' = 'Spec Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `uc_subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Uc Subscription Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Configuration Activation Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `apn_name` SET TAGS ('dbx_business_glossary_term' = 'Access Point Name (APN)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `bandwidth_profile_downstream_mbps` SET TAGS ('dbx_business_glossary_term' = 'Bandwidth Profile Downstream (Mbps)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `bandwidth_profile_upstream_mbps` SET TAGS ('dbx_business_glossary_term' = 'Bandwidth Profile Upstream (Mbps)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `configuration_payload_json` SET TAGS ('dbx_business_glossary_term' = 'Configuration Payload (JSON)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `configuration_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `configuration_type` SET TAGS ('dbx_business_glossary_term' = 'Configuration Type');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `configuration_version` SET TAGS ('dbx_business_glossary_term' = 'Configuration Version Number');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `cpe_wan_ip_address` SET TAGS ('dbx_business_glossary_term' = 'CPE Wide Area Network (WAN) IP Address');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `cpe_wan_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `deactivation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Configuration Deactivation Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `dnn_name` SET TAGS ('dbx_business_glossary_term' = 'Data Network Name (DNN)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Configuration Effective Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `esim_profile_state` SET TAGS ('dbx_business_glossary_term' = 'Embedded SIM (eSIM) Profile State');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `esim_profile_state` SET TAGS ('dbx_value_regex' = 'not_provisioned|downloaded|installed|enabled|disabled|deleted');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `esim_smdp_plus_address` SET TAGS ('dbx_business_glossary_term' = 'eSIM Subscription Manager Data Preparation Plus (SM-DP+) Address');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `esim_smdp_plus_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `esim_smdp_plus_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Configuration Expiry Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `ftth_gem_port_number` SET TAGS ('dbx_business_glossary_term' = 'FTTH GPON Encapsulation Method (GEM) Port ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `ftth_olt_identifier` SET TAGS ('dbx_business_glossary_term' = 'FTTH Optical Line Terminal (OLT) Identifier');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `ftth_pon_port` SET TAGS ('dbx_business_glossary_term' = 'FTTH Passive Optical Network (PON) Port');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `ftth_tcont_number` SET TAGS ('dbx_business_glossary_term' = 'FTTH Transmission Container (T-CONT) ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `ftth_vlan_number` SET TAGS ('dbx_business_glossary_term' = 'FTTH Virtual Local Area Network (VLAN) ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `hd_voice_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'High Definition (HD) Voice Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `ims_pcscf_address` SET TAGS ('dbx_business_glossary_term' = 'IP Multimedia Subsystem (IMS) Proxy Call Session Control Function (P-CSCF) Address');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `ims_pcscf_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `ims_pcscf_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `ims_private_user_identity` SET TAGS ('dbx_business_glossary_term' = 'IMS Private User Identity (IMPI)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `ims_private_user_identity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `ims_private_user_identity` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `ims_public_user_identity` SET TAGS ('dbx_business_glossary_term' = 'IMS Public User Identity (IMPU)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `ims_public_user_identity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `ims_public_user_identity` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `mvno_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Mobile Virtual Network Operator (MVNO) Override Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `preferred_codec_list` SET TAGS ('dbx_business_glossary_term' = 'Preferred Codec List');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `provisioning_system_source` SET TAGS ('dbx_business_glossary_term' = 'Provisioning System Source');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `qos_class_identifier` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Class Identifier');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `qos_class_identifier` SET TAGS ('dbx_value_regex' = '^QCI[1-9]$|^5QI[0-9]{1,3}$');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `roaming_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Roaming Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `roaming_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Roaming Zone Code');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `volte_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Voice over LTE (VoLTE) Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `vowifi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Voice over WiFi (VoWiFi) Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` SET TAGS ('dbx_subdomain' = 'provisioning_operations');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `sla_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Profile Identifier');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `enterprise_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Segment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `sla_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `applicable_service_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Service Types');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|under_review');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `bandwidth_guarantee_mbps` SET TAGS ('dbx_business_glossary_term' = 'Bandwidth Guarantee in Megabits per Second (Mbps)');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `credit_eligible` SET TAGS ('dbx_business_glossary_term' = 'Credit Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `dedicated_support_team` SET TAGS ('dbx_business_glossary_term' = 'Dedicated Support Team Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `escalation_tier_1_minutes` SET TAGS ('dbx_business_glossary_term' = 'Escalation Tier 1 Time in Minutes');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `escalation_tier_2_minutes` SET TAGS ('dbx_business_glossary_term' = 'Escalation Tier 2 Time in Minutes');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `escalation_tier_3_minutes` SET TAGS ('dbx_business_glossary_term' = 'Escalation Tier 3 Time in Minutes');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `exclusion_window_description` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Window Description');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'global|regional|national|local|site_specific');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `jitter_threshold_ms` SET TAGS ('dbx_business_glossary_term' = 'Jitter Threshold in Milliseconds');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `latency_threshold_ms` SET TAGS ('dbx_business_glossary_term' = 'Latency Threshold in Milliseconds');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `managed_in_system` SET TAGS ('dbx_business_glossary_term' = 'Managed in System');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `measurement_window_hours` SET TAGS ('dbx_business_glossary_term' = 'Measurement Window in Hours');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `mttr_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Mean Time to Repair (MTTR) Target in Minutes');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `network_technology` SET TAGS ('dbx_business_glossary_term' = 'Network Technology');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `packet_loss_limit_percentage` SET TAGS ('dbx_business_glossary_term' = 'Packet Loss Limit Percentage');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `proactive_monitoring_enabled` SET TAGS ('dbx_business_glossary_term' = 'Proactive Monitoring Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_business_glossary_term' = 'SLA Profile Code');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `profile_description` SET TAGS ('dbx_business_glossary_term' = 'SLA Profile Description');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_business_glossary_term' = 'SLA Profile Name');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `profile_tier` SET TAGS ('dbx_business_glossary_term' = 'SLA Profile Tier');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `profile_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard|basic');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `regulatory_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Notes');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'real_time|daily|weekly|monthly|quarterly|on_demand');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `response_time_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Response Time Target in Minutes');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `service_class` SET TAGS ('dbx_business_glossary_term' = 'Service Class');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `service_class` SET TAGS ('dbx_value_regex' = 'enterprise|business|residential|wholesale|government|carrier');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `sla_profile_status` SET TAGS ('dbx_business_glossary_term' = 'SLA Profile Status');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `sla_profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|deprecated|retired|pending_approval');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `support_hours` SET TAGS ('dbx_business_glossary_term' = 'Support Hours');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `support_hours` SET TAGS ('dbx_value_regex' = '24x7|business_hours|extended_hours|custom');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `uptime_percentage_target` SET TAGS ('dbx_business_glossary_term' = 'Uptime Percentage Target');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` SET TAGS ('dbx_subdomain' = 'instance_management');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `svc_status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Service Status History ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `enterprise_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Initiating Technician Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `provisioning_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `svc_suspension_id` SET TAGS ('dbx_business_glossary_term' = 'Svc Suspension Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `trouble_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Trouble Ticket ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `actual_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Transition Duration Minutes');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `churn_category` SET TAGS ('dbx_business_glossary_term' = 'Churn Category');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `churn_category` SET TAGS ('dbx_value_regex' = 'voluntary|involuntary|competitive|relocation|financial|quality');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `churn_indicator_flag` SET TAGS ('dbx_business_glossary_term' = 'Churn Indicator Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Transition Comments');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `dispute_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Status Effective Date');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `initiating_actor_type` SET TAGS ('dbx_business_glossary_term' = 'Initiating Actor Type');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `initiating_actor_type` SET TAGS ('dbx_value_regex' = 'customer|csr|system|network|billing|regulatory');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Service Status');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `new_status` SET TAGS ('dbx_value_regex' = 'pending|active|suspended|terminated|provisioning|deprovisioning');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `notification_channel` SET TAGS ('dbx_value_regex' = 'email|sms|push|ivr|portal|none');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Service Status');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `previous_status` SET TAGS ('dbx_value_regex' = 'pending|active|suspended|terminated|provisioning|deprovisioning');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `regulatory_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notice Period Days');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `rollback_flag` SET TAGS ('dbx_business_glossary_term' = 'Rollback Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `rollback_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Rollback Reference ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `scheduled_flag` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Transition Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `service_technology` SET TAGS ('dbx_business_glossary_term' = 'Service Technology');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `sla_target_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Duration Minutes');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `source_system_event_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Event ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `transition_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Reason Code');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `transition_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Reason Description');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `transition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `win_back_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Win-Back Campaign Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` SET TAGS ('dbx_subdomain' = 'provisioning_operations');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `number_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Number Assignment Identifier');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `enterprise_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `lawful_intercept_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lawful Intercept Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `mnp_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Mnp Compliance Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `mnp_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Mnp Transaction Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_business_glossary_term' = 'Number Range Identifier');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `mvno_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Mvno Profile Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `sim_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Sim Stock Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance Identifier');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `uc_subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Uc Subscription Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activation Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `area_code` SET TAGS ('dbx_business_glossary_term' = 'Area Code');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `area_code` SET TAGS ('dbx_value_regex' = '^[0-9]{1,5}$');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_value_regex' = 'new_activation|replacement|port_in|upgrade|migration');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|reserved|suspended|quarantined|released|ported_out');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `cnam_display_name` SET TAGS ('dbx_business_glossary_term' = 'Calling Name (CNAM) Display Name');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `do_not_call_registry_flag` SET TAGS ('dbx_business_glossary_term' = 'Do Not Call Registry Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `donor_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Donor Carrier Code');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `donor_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `emergency_services_enabled` SET TAGS ('dbx_business_glossary_term' = 'Emergency Services Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `hlr_location` SET TAGS ('dbx_business_glossary_term' = 'Home Location Register (HLR) Location');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `imsi` SET TAGS ('dbx_business_glossary_term' = 'International Mobile Subscriber Identity (IMSI)');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `imsi` SET TAGS ('dbx_value_regex' = '^[0-9]{14,15}$');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `imsi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `imsi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `lidb_listing_flag` SET TAGS ('dbx_business_glossary_term' = 'Line Information Database (LIDB) Listing Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `managed_in_system` SET TAGS ('dbx_business_glossary_term' = 'Managed In System');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `msisdn` SET TAGS ('dbx_business_glossary_term' = 'Mobile Station International Subscriber Directory Number (MSISDN)');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `msisdn` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `msisdn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `msisdn` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `number_category` SET TAGS ('dbx_business_glossary_term' = 'Number Category');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `number_category` SET TAGS ('dbx_value_regex' = 'mobile|fixed_line|voip|machine_to_machine|iot');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `number_type` SET TAGS ('dbx_business_glossary_term' = 'Number Type Classification');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `number_type` SET TAGS ('dbx_value_regex' = 'geographic|non_geographic|toll_free|premium_rate|short_code|voip_did');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `number_usage_type` SET TAGS ('dbx_business_glossary_term' = 'Number Usage Type');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `number_usage_type` SET TAGS ('dbx_value_regex' = 'voice|sms|data|fax|all_services');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `port_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Port Completion Date');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `port_request_date` SET TAGS ('dbx_business_glossary_term' = 'Port Request Date');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `porting_direction` SET TAGS ('dbx_business_glossary_term' = 'Porting Direction');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `porting_direction` SET TAGS ('dbx_value_regex' = 'none|port_in|port_out');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `porting_status` SET TAGS ('dbx_business_glossary_term' = 'Mobile Number Portability (MNP) Porting Status');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `porting_status` SET TAGS ('dbx_value_regex' = 'not_ported|port_in_pending|port_in_complete|port_out_pending|port_out_complete');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `previous_msisdn` SET TAGS ('dbx_business_glossary_term' = 'Previous Mobile Station International Subscriber Directory Number (MSISDN)');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `previous_msisdn` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `previous_msisdn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `previous_msisdn` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `quarantine_end_date` SET TAGS ('dbx_business_glossary_term' = 'Quarantine End Date');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `recipient_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Recipient Carrier Code');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `recipient_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `regulatory_ownership` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Ownership Status');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `regulatory_ownership` SET TAGS ('dbx_value_regex' = 'owned|leased|sub_allocated');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `reservation_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Reservation Expiry Date');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Routing Number');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{6,15}$');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `vanity_number_flag` SET TAGS ('dbx_business_glossary_term' = 'Vanity Number Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` SET TAGS ('dbx_subdomain' = 'provisioning_operations');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `svc_suspension_id` SET TAGS ('dbx_business_glossary_term' = 'Service Suspension ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Technician Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `enterprise_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `dealer_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Dealer Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `retention_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Offer Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `actual_reinstatement_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Reinstatement Date');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `actual_reinstatement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Reinstatement Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `auto_reinstatement_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto Reinstatement Enabled');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `billing_adjustment_applied` SET TAGS ('dbx_business_glossary_term' = 'Billing Adjustment Applied');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `billing_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Impact Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `customer_acknowledgement_received` SET TAGS ('dbx_business_glossary_term' = 'Customer Acknowledgement Received');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `emergency_services_allowed` SET TAGS ('dbx_business_glossary_term' = 'Emergency Services Allowed');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `expected_reinstatement_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Reinstatement Date');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Initiated By');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `initiated_by` SET TAGS ('dbx_value_regex' = 'customer|system|agent|regulatory|fraud_detection');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `initiated_channel` SET TAGS ('dbx_business_glossary_term' = 'Initiated Channel');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `initiated_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|call_center|retail_store|automated_system|partner_portal');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `network_suspension_applied` SET TAGS ('dbx_business_glossary_term' = 'Network Suspension Applied');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `network_suspension_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Network Suspension Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Suspension Notes');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `notice_method` SET TAGS ('dbx_business_glossary_term' = 'Notice Method');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `notice_method` SET TAGS ('dbx_value_regex' = 'email|sms|postal_mail|phone_call|in_app|multiple');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `notice_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notice Sent Date');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `prorated_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Prorated Charge Amount');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `reinstatement_condition` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Condition');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `reinstatement_condition_met` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Condition Met');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `reinstatement_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Fee Amount');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `service_barring_profile` SET TAGS ('dbx_business_glossary_term' = 'Service Barring Profile');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `suspension_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Suspension Duration Days');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `suspension_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Suspension Fee Amount');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `suspension_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason Code');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `suspension_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `suspension_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason Description');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `suspension_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reference Number');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `suspension_reference_number` SET TAGS ('dbx_value_regex' = '^SUS-[0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Start Date');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `suspension_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Suspension Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `suspension_status` SET TAGS ('dbx_business_glossary_term' = 'Suspension Status');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `suspension_status` SET TAGS ('dbx_value_regex' = 'pending|active|reinstated|expired|cancelled');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `suspension_type` SET TAGS ('dbx_business_glossary_term' = 'Suspension Type');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `suspension_type` SET TAGS ('dbx_value_regex' = 'voluntary|involuntary|administrative|regulatory|technical|fraud');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` SET TAGS ('dbx_subdomain' = 'instance_management');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `svc_location_id` SET TAGS ('dbx_business_glossary_term' = 'Service Location Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `fiber_cable_id` SET TAGS ('dbx_business_glossary_term' = 'Fiber Cable Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `olt_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Olt Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Serving Depot Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Serving Network Element Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `ran_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Serving Ran Cell Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `spectrum_license_id` SET TAGS ('dbx_business_glossary_term' = 'Spectrum License Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `access_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Access Restrictions');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `access_technology` SET TAGS ('dbx_business_glossary_term' = 'Access Technology');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `access_technology` SET TAGS ('dbx_value_regex' = 'ftth|fttc|dsl|cable|fixed_wireless|satellite');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `active_service_count` SET TAGS ('dbx_business_glossary_term' = 'Active Service Count');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `building_type` SET TAGS ('dbx_business_glossary_term' = 'Building Type');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `cabinet_identifier` SET TAGS ('dbx_business_glossary_term' = 'Street Cabinet Identifier');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `central_office_code` SET TAGS ('dbx_business_glossary_term' = 'Central Office (CO) Code');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `central_office_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `external_location_code` SET TAGS ('dbx_business_glossary_term' = 'External Location Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `fiber_availability` SET TAGS ('dbx_business_glossary_term' = 'Fiber Availability Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `five_g_coverage` SET TAGS ('dbx_business_glossary_term' = '5G Coverage Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `geocode_accuracy` SET TAGS ('dbx_business_glossary_term' = 'Geocode Accuracy');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `geocode_accuracy` SET TAGS ('dbx_value_regex' = 'rooftop|parcel|street|postal_code|city|unknown');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `installation_complexity` SET TAGS ('dbx_business_glossary_term' = 'Installation Complexity');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `installation_complexity` SET TAGS ('dbx_value_regex' = 'standard|moderate|complex|very_complex');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `last_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Last Survey Date');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `latitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `location_notes` SET TAGS ('dbx_business_glossary_term' = 'Location Notes');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `location_status` SET TAGS ('dbx_business_glossary_term' = 'Location Status');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|decommissioned');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `longitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `managed_in_system` SET TAGS ('dbx_business_glossary_term' = 'Managed In System');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `maximum_bandwidth_mbps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Bandwidth (Mbps)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `network_serving_area_code` SET TAGS ('dbx_business_glossary_term' = 'Network Serving Area (NSA) Code');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `network_serving_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `olt_identifier` SET TAGS ('dbx_business_glossary_term' = 'Optical Line Terminal (OLT) Identifier');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `premises_type` SET TAGS ('dbx_business_glossary_term' = 'Premises Type');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `premises_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|mdu|industrial|government|educational');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `regulatory_zone` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Zone');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `serviceability_status` SET TAGS ('dbx_business_glossary_term' = 'Serviceability Status');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `serviceability_status` SET TAGS ('dbx_value_regex' = 'serviceable|non_serviceable|planned|under_construction|pending_survey');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `surveyed_by` SET TAGS ('dbx_business_glossary_term' = 'Surveyed By');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `unit_count` SET TAGS ('dbx_business_glossary_term' = 'Unit Count');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `universal_service_eligible` SET TAGS ('dbx_business_glossary_term' = 'Universal Service Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` SET TAGS ('dbx_subdomain' = 'instance_management');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `dependency_id` SET TAGS ('dbx_business_glossary_term' = 'Service Dependency Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `addon_id` SET TAGS ('dbx_business_glossary_term' = 'Addon Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Child Service Instance Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `dependency_svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Service Instance Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `mvno_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Mvno Profile Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `parent_dependency_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Product Offering Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `provisioning_order_id` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Order Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `activation_sequence_order` SET TAGS ('dbx_business_glossary_term' = 'Activation Sequence Order');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `billing_impact_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Impact Type');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `billing_impact_type` SET TAGS ('dbx_value_regex' = 'bundle_discount|separate_billing|consolidated_billing|no_impact');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `bundle_composition_flag` SET TAGS ('dbx_business_glossary_term' = 'Bundle Composition Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `child_service_type` SET TAGS ('dbx_business_glossary_term' = 'Child Service Type');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `created_by_system` SET TAGS ('dbx_business_glossary_term' = 'Created By System');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `deactivation_sequence_order` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Sequence Order');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `dependency_category` SET TAGS ('dbx_business_glossary_term' = 'Dependency Category');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `dependency_category` SET TAGS ('dbx_value_regex' = 'commercial|technical|regulatory|operational');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `dependency_status` SET TAGS ('dbx_business_glossary_term' = 'Dependency Status');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `dependency_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `dependency_type` SET TAGS ('dbx_business_glossary_term' = 'Dependency Type');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `dependency_type` SET TAGS ('dbx_value_regex' = 'composition|prerequisite|peer|slice_component|wholesale_virtual|technology_stack');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Dependency Direction');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'parent_to_child|child_to_parent|bidirectional');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `effective_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective End Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `effective_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `external_dependency_code` SET TAGS ('dbx_business_glossary_term' = 'External Dependency Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `failure_handling_policy` SET TAGS ('dbx_business_glossary_term' = 'Failure Handling Policy');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `failure_handling_policy` SET TAGS ('dbx_value_regex' = 'rollback_all|continue_partial|manual_intervention|retry_automatic');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `impact_propagation_rule` SET TAGS ('dbx_business_glossary_term' = 'Impact Propagation Rule');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `impact_propagation_rule` SET TAGS ('dbx_value_regex' = 'cascade_suspend|cascade_terminate|notify_only|block_parent_change|isolate');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `mandatory_dependency_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Dependency Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `mvno_wholesale_flag` SET TAGS ('dbx_business_glossary_term' = 'Mobile Virtual Network Operator (MVNO) Wholesale Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `network_slice_dependency_flag` SET TAGS ('dbx_business_glossary_term' = 'Network Slice Dependency Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Dependency Notes');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `orchestration_constraint` SET TAGS ('dbx_business_glossary_term' = 'Orchestration Constraint');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `parent_service_type` SET TAGS ('dbx_business_glossary_term' = 'Parent Service Type');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `qos_inheritance_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Inheritance Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `sla_inheritance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Inheritance Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `strength` SET TAGS ('dbx_business_glossary_term' = 'Dependency Strength');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `strength` SET TAGS ('dbx_value_regex' = 'hard|soft|advisory');
