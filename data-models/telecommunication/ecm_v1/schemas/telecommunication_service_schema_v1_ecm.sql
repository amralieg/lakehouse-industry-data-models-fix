-- Schema for Domain: service | Business: Telecommunication | Version: v1_ecm
-- Generated on: 2026-05-08 05:07:50

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `telecommunication_ecm`.`service` COMMENT 'SSOT for the logical service layer instantiated on network resources — active service instances, provisioning, activation, service configurations, SLA parameters, QoS profiles, VoLTE/IMS service state, eSIM profiles, and CPE assignments. Bridges product catalog to physical network delivery via Oracle OSM and Netcracker OSS.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `telecommunication_ecm`.`service`.`svc_instance` (
    `svc_instance_id` BIGINT COMMENT 'Unique identifier for the service instance. Primary key for the service instance entity.',
    `catalog_item_id` BIGINT COMMENT 'FK to product.catalog_item.catalog_item_id — Service instances must reference the product catalog item they instantiate for product analytics, entitlement validation, and configuration management.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise service instances must track the corporate account for billing consolidation, SLA enforcement, contract compliance, and account-level reporting. Critical for B2B service delivery and revenu',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Service instances consume network resources (bandwidth, spectrum, infrastructure) that must be allocated to cost centers for internal cost accounting, technology-specific profitability analysis, and o',
    `cpni_authorization_id` BIGINT COMMENT 'Foreign key linking to compliance.cpni_authorization. Business justification: CPNI authorizations grant customer consent to access service-specific call detail records, usage data, and network information. CSRs must verify authorization before disclosing service details; link e',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account that owns this service instance. Links the service to the billing and customer relationship.',
    `e911_compliance_id` BIGINT COMMENT 'Foreign key linking to compliance.e911_compliance. Business justification: E911 compliance records track location accuracy, PSAP routing, and dispatchable location capability for specific VoLTE/VoWiFi service instances. Required for FCC compliance reporting, emergency servic',
    `enterprise_site_id` BIGINT COMMENT 'Foreign key linking to enterprise.site. Business justification: Enterprise services are delivered to specific customer sites. Required for installation coordination, SLA measurement by location, circuit provisioning, and site-level service inventory management in ',
    `lawful_intercept_order_id` BIGINT COMMENT 'Foreign key linking to compliance.lawful_intercept_order. Business justification: Law enforcement intercept orders target specific service instances (MSISDN/IMSI) for surveillance. Operations teams must link intercept orders to service instances to provision monitoring, deliver CDR',
    `mvno_profile_id` BIGINT COMMENT 'Foreign key linking to partner.mvno_profile. Business justification: MVNO wholesale model requires tracking which MVNO partner owns each service instance for revenue settlement, regulatory reporting, and provisioning orchestration. Core telecom business relationship fo',
    `network_qos_profile_id` BIGINT COMMENT 'Reference to the QoS profile defining traffic prioritization, bandwidth allocation, latency targets, and packet handling rules for this service instance.',
    `parent_service_instance_svc_instance_id` BIGINT COMMENT 'Reference to the parent service instance in hierarchical service scenarios (e.g., a mobile line under a family plan, or a managed service component under an enterprise contract).',
    `premise_id` BIGINT COMMENT 'Foreign key linking to location.premise. Business justification: Service instances are physically delivered to specific premises (residential/business locations). Essential for installation dispatch, field service routing, network planning, and serviceability valid',
    `offering_id` BIGINT COMMENT 'Reference to the product catalog offering that defines the commercial terms and features of this service instance.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Revenue-generating services must map to profit centers for P&L reporting, ARPU calculation by segment, EBITDA analysis, and business unit profitability—core requirement for telco financial consolidati',
    `segment_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.segment_definition. Business justification: Service instances are assigned to customer segments (consumer, enterprise, prepaid, postpaid) for analytics reporting, targeted marketing campaigns, and segment-based performance analysis. Essential f',
    `sla_profile_id` BIGINT COMMENT 'Reference to the SLA profile defining performance commitments, uptime guarantees, and remediation terms for this service instance.',
    `subscriber_id` BIGINT COMMENT 'Reference to the individual subscriber using this service instance. May differ from account holder in multi-user scenarios.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to interconnect.interconnect_carrier. Business justification: Roaming service instances must track the visited carrier for TAP file reconciliation, settlement invoice validation, and regulatory roaming reports. Essential for wholesale roaming revenue assurance.',
    `activation_timestamp` TIMESTAMP COMMENT 'Date and time when the service instance was successfully activated and became operational. Marks the start of service delivery and billing.',
    `apn` STRING COMMENT 'Access Point Name used by this mobile service instance to connect to external packet data networks. Determines routing and billing for data sessions.',
    `auto_renew` BOOLEAN COMMENT 'Indicates whether this service instance automatically renews at the end of its contract term. Controls subscription continuity and churn prevention.',
    `bandwidth_mbps` DECIMAL(18,2) COMMENT 'Provisioned bandwidth capacity for this service instance in megabits per second. Applies to broadband, FTTH, and enterprise connectivity services.',
    `billing_cycle_day` STRING COMMENT 'Day of the month on which billing is generated for this service instance. Aligns service billing with customer account billing schedule.',
    `cpe_serial_number` STRING COMMENT 'Serial number of the CPE device (router, modem, ONT, set-top box) assigned to this service instance. Used for inventory tracking and remote management.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this service instance record was first created in the system. Marks the beginning of the service lifecycle in the data platform.',
    `data_allowance_gb` DECIMAL(18,2) COMMENT 'Monthly or total data usage allowance for this service instance in gigabytes. Applies to mobile and IoT services with usage caps.',
    `deactivation_timestamp` TIMESTAMP COMMENT 'Date and time when the service instance was deactivated or terminated. Marks the end of service delivery and billing eligibility.',
    `esim_profile_id` STRING COMMENT 'Unique identifier of the eSIM profile provisioned for this mobile service instance. Used for remote SIM provisioning and management.',
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
    `provisioning_order_id` BIGINT COMMENT 'Reference to the order that initiated the provisioning of this service instance. Links service lifecycle to order management.',
    `provisioning_system` STRING COMMENT 'Name of the OSS (Operations Support System) or provisioning platform that manages this service instance (e.g., Oracle OSM, Netcracker OSS, Ericsson Network Manager).',
    `roaming_enabled` BOOLEAN COMMENT 'Indicates whether international or domestic roaming is enabled for this mobile service instance. Controls network access outside the home network.',
    `service_class` STRING COMMENT 'Business segment classification for the service instance. Drives SLA (Service Level Agreement) requirements, support tier, and billing rules.. Valid values are `consumer|enterprise|wholesale|iot|government`',
    `service_end_date` DATE COMMENT 'Contractual or scheduled end date for the service instance. Null for open-ended subscriptions.',
    `service_identifier` STRING COMMENT 'Externally visible business identifier for the service instance. May be displayed to customers on bills and portals (e.g., service number, circuit ID, subscription reference).',
    `service_start_date` DATE COMMENT 'Contractual start date for the service instance. May differ from activation timestamp for pre-scheduled or backdated services.',
    `service_type` STRING COMMENT 'Classification of the service instance by technology and delivery model. Determines provisioning workflows and network resource requirements. [ENUM-REF-CANDIDATE: mobile|broadband|ftth|voip|iptv|iot_m2m|managed_service|5g_network_slice|enterprise_connectivity|wholesale_mvno — 10 candidates stripped; promote to reference product]',
    `slice_id` BIGINT COMMENT 'Identifier of the 5G network slice allocated to this service instance. Defines the virtualized network resources and QoS characteristics for 5G services.',
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
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise provisioning orders require corporate account linkage for approval workflows, credit verification, contract validation, and billing. Essential for B2B order management and fulfillment proce',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Provisioning activities (technician dispatch, truck rolls, installations, network configuration) incur direct operational costs that must be allocated to cost centers for cost-per-activation KPIs, wor',
    `dealer_id` BIGINT COMMENT 'Foreign key linking to partner.dealer. Business justification: Dealer-initiated orders require tracking originating dealer for commission calculation, fraud pattern detection, channel performance analytics, and regulatory dealer-of-record requirements. Standard r',
    `employee_id` BIGINT COMMENT 'User identifier or system account that created this provisioning order record, used for audit and accountability purposes.',
    `enterprise_site_id` BIGINT COMMENT 'Foreign key linking to enterprise.site. Business justification: Enterprise provisioning orders target specific customer sites for technician dispatch, installation planning, and site access coordination. Critical for field service management and enterprise service',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the originating commercial order from the order domain that triggered this provisioning work order.',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: Provisioning orders track operational KPIs like order completion time, SLA compliance rate, fallout percentage, and time-to-activate. Required for operational performance dashboards, SLA reporting to ',
    `location_address_id` BIGINT COMMENT 'Foreign key linking to location.location_address. Business justification: Orders require installation addresses for technician dispatch, GPS routing, and customer communication. Distinct from premise (which is network planning entity) - address is operational dispatch targe',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to interconnect.interconnect_carrier. Business justification: International or MVNO provisioning orders require tracking the partner/wholesale carrier for IoT global SIM activation, roaming profile setup, and inter-carrier provisioning coordination workflows.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to location.premise. Business justification: Provisioning orders target specific premises for service installation. Critical for work order management, technician dispatch, serviceability pre-checks, construction requirement assessment, and prem',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Provisioning orders document deployment milestones (spectrum buildout, universal service coverage expansion) that serve as evidence for regulatory filings. Link needed for FCC Form 477 submissions, CA',
    `svc_instance_id` BIGINT COMMENT 'Reference to the logical service instance being provisioned, modified, or deprovisioned.',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber for whom this provisioning order is being executed.',
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
    `sla_tier` STRING COMMENT 'Service Level Agreement (SLA) tier or class of service associated with this provisioning order, determining priority, response time, and support level commitments.. Valid values are `bronze|silver|gold|platinum|enterprise`',
    `target_completion_timestamp` TIMESTAMP COMMENT 'Service Level Agreement (SLA) target timestamp by which provisioning must be completed to meet contractual commitments.',
    `test_result` STRING COMMENT 'Result of pre-activation service testing or qualification step, particularly for enterprise Fiber to the Home (FTTH) or Multiprotocol Label Switching (MPLS) delivery where service quality must be validated before customer handoff.. Valid values are `passed|failed|not_applicable|pending`',
    CONSTRAINT pk_provisioning_order PRIMARY KEY(`provisioning_order_id`)
) COMMENT 'Transactional record capturing each service provisioning or de-provisioning work order dispatched to OSS/BSS systems (Oracle OSM, Netcracker). Tracks order type (new activation, upgrade, downgrade, suspension, termination, MNP port-in/out, service test/qualification), orchestration state machine, step-level execution status including fallout management (failure step, error code, retry count, resolution action, resolution timestamp), completion timestamp, and originating commercial order reference. One provisioning order may span multiple activation tasks across network domains. Encompasses full fallout lifecycle for NOC operational quality tracking and systemic failure pattern identification. Supports pre-activation service testing and qualification as provisioning step types for enterprise FTTH/MPLS delivery. Does NOT own the commercial order (order domain) — owns only the technical provisioning execution, its outcomes, and failure resolution.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`service`.`activation_event` (
    `activation_event_id` BIGINT COMMENT 'Unique identifier for the service activation event record. Primary key for the activation event entity.',
    `technician_id` BIGINT COMMENT 'Reference to the field technician who performed the activation, if applicable. Null for automated or remote activations.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Each activation event generates measurable costs (labor, materials, system usage) that must be captured to cost centers for calculating cost-per-gross-add, analyzing activation efficiency by channel/t',
    `dealer_id` BIGINT COMMENT 'Foreign key linking to partner.dealer. Business justification: Activation events need dealer attribution for commission settlement timing, channel performance measurement, and regulatory compliance. Critical for dealer compensation and fraud detection in indirect',
    `enterprise_site_id` BIGINT COMMENT 'Foreign key linking to enterprise.site. Business justification: Enterprise service activations occur at specific customer sites. Required for SLA measurement by location, installation verification, and site-level activation reporting in B2B service delivery.',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: Activation audit trails must link to physical CPE inventory for regulatory compliance, warranty validation, and root cause analysis when activations fail. Tracks which specific asset was used in activ',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: Activation events measure KPIs like activation success rate, average time-to-activate, SLA compliance, and first-time-right percentage. Critical for network operations dashboards, regulatory reporting',
    `element_id` BIGINT COMMENT 'Identifier of the activating network element that performed the service activation. May reference Optical Line Terminal (OLT), Broadband Network Gateway (BNG), Home Subscriber Server (HSS), or other Operations Support Systems (OSS) components.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to location.premise. Business justification: Activation events occur at specific premises during service installation. Required for field technician dispatch, installation verification, premise-level service history tracking, and regulatory repo',
    `provisioning_order_id` BIGINT COMMENT 'Reference to the provisioning order that triggered this activation event. Links back to the order fulfillment workflow in Oracle Communications Order and Service Management (OSM).',
    `ran_cell_id` BIGINT COMMENT 'Foreign key linking to network.ran_cell. Business justification: Mobile service activations occur on specific RAN cells. Critical for coverage analysis, activation success rate reporting by cell, and troubleshooting first-call failures. Standard metric in mobile ne',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber for whom this service was activated. Links to the customer subscriber record.',
    `svc_instance_id` BIGINT COMMENT 'Reference to the service instance that was activated in this event. Links to the specific service configuration being brought online.',
    `svc_location_id` BIGINT COMMENT 'Reference to the physical service location or address where the service was activated. Links to the service delivery address.',
    `trouble_ticket_id` BIGINT COMMENT 'Foreign key linking to assurance.trouble_ticket. Business justification: Activation failures commonly generate trouble tickets for NOC investigation and resolution. Critical for tracking activation success rates and SLA compliance in service delivery operations.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to interconnect.interconnect_carrier. Business justification: Activation events on visited roaming networks must capture the carrier ID for regulatory reporting (NRTRDE), TAP file generation, and roaming settlement reconciliation processes.',
    `activation_channel` STRING COMMENT 'System or interface channel through which the activation was executed. May include Oracle OSM, Netcracker OSS, Element Management System (EMS), Network Management System (NMS), command-line interface (CLI), Application Programming Interface (API), or self-service portal. [ENUM-REF-CANDIDATE: OSM|Netcracker|EMS|NMS|CLI|API|portal — 7 candidates stripped; promote to reference product]',
    `activation_error_code` STRING COMMENT 'Error code returned by the network element or provisioning system if activation failed or encountered issues. Null for successful activations.',
    `activation_error_message` STRING COMMENT 'Detailed error message or description associated with the activation error code. Provides troubleshooting context for failed activations.',
    `activation_method` STRING COMMENT 'Method used to perform the service activation. Indicates whether activation was automatic via provisioning system, manual by operations staff, or performed by field technician.. Valid values are `automatic|manual|semi_automatic|remote|field_technician`',
    `activation_status` STRING COMMENT 'Final outcome status of the activation attempt. Indicates whether the service was successfully activated, failed, partially activated, or rolled back.. Valid values are `successful|failed|partial|pending_confirmation|rolled_back`',
    `activation_timestamp` TIMESTAMP COMMENT 'Precise moment when the service instance transitioned to active state on the network. Used for Service Level Agreement (SLA) compliance measurement and regulatory reporting of service activation timelines.',
    `bandwidth_allocated_mbps` DECIMAL(18,2) COMMENT 'Bandwidth allocated to the service at activation, measured in megabits per second (Mbps). Defines the service speed tier.',
    `created_by_user` STRING COMMENT 'User identifier or system account that created this activation event record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this activation event record was first created in the system. Used for audit trail and data lineage.',
    `esim_profile_download_status` STRING COMMENT 'Status of the embedded SIM (eSIM) profile download confirmation at activation. Indicates whether the eSIM profile was successfully provisioned to the device.. Valid values are `downloaded|download_failed|not_applicable|pending`',
    `esim_profile_iccid` STRING COMMENT 'Integrated Circuit Card Identifier (ICCID) of the eSIM profile that was activated. Uniquely identifies the eSIM profile downloaded to the device.',
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
    `device_model_id` BIGINT COMMENT 'Reference to the CPE device (router, modem, set-top box) provisioned for this service instance.',
    `dq_rule_id` BIGINT COMMENT 'Foreign key linking to analytics.dq_rule. Business justification: Service configurations are validated against data quality rules for QoS parameters, bandwidth profiles, valid APN/DNN names, and VLAN assignments. Required for configuration validation workflows, auto',
    `employee_id` BIGINT COMMENT 'Username or system identifier of the user or process that last modified this configuration record.',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Service configurations for managed enterprise services must link to the managed service contract for SLA compliance validation, configuration change management, and service delivery verification in B2',
    `element_id` BIGINT COMMENT 'Foreign key linking to network.element. Business justification: Service configurations must reference the serving network element (BNG, GGSN, PGW, UPF) for provisioning workflows, troubleshooting, and capacity planning. Essential for OSS/BSS integration and servic',
    `provisioning_order_id` BIGINT COMMENT 'External order or work order identifier that triggered this configuration change.',
    `rate_plan_id` BIGINT COMMENT 'Foreign key linking to billing.rate_plan. Business justification: Service configurations determine applicable rate plans for usage rating. Bandwidth profiles, QoS settings, and feature flags directly map to rating tiers. Required for real-time charging, bill shock p',
    `svc_instance_id` BIGINT COMMENT 'Reference to the parent service instance to which this configuration applies.',
    `trouble_ticket_id` BIGINT COMMENT 'Foreign key linking to assurance.trouble_ticket. Business justification: Configuration errors generate trouble tickets for remediation. Required for root cause analysis linking configuration changes to service degradation and customer-reported issues.',
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
    `esim_eid` STRING COMMENT '32-digit unique identifier of the embedded Universal Integrated Circuit Card (eUICC) hardware.. Valid values are `^[0-9]{32}$`',
    `esim_iccid` STRING COMMENT '19 or 20-digit identifier of the eSIM profile (virtual SIM card) provisioned on the eUICC.. Valid values are `^[0-9]{19,20}$`',
    `esim_profile_state` STRING COMMENT 'Current state of the eSIM profile on the device (not provisioned, downloaded, installed, enabled, disabled, deleted).. Valid values are `not_provisioned|downloaded|installed|enabled|disabled|deleted`',
    `esim_smdp_plus_address` STRING COMMENT 'Fully qualified domain name of the SM-DP+ server responsible for eSIM profile generation and download.',
    `expiry_timestamp` TIMESTAMP COMMENT 'Date and time when this configuration version is scheduled to expire or be superseded. Null for open-ended configurations.',
    `ftth_gem_port_number` STRING COMMENT 'GEM port identifier used for traffic segmentation and QoS mapping in GPON.',
    `ftth_olt_identifier` STRING COMMENT 'Identifier of the OLT device in the central office serving this FTTH service instance.',
    `ftth_ont_serial_number` STRING COMMENT 'Unique serial number of the ONT device installed at the customer premises for FTTH service delivery.',
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
    `sla_class` STRING COMMENT 'SLA tier assigned to this service instance defining performance guarantees and support priority.. Valid values are `gold|silver|bronze|standard|premium|enterprise`',
    `sla_target_latency_ms` STRING COMMENT 'Maximum acceptable round-trip latency in milliseconds as defined in the SLA.',
    `sla_target_uptime_percent` DECIMAL(18,2) COMMENT 'Contractual uptime percentage target for this service instance (e.g., 99.95%).',
    `volte_enabled_flag` BOOLEAN COMMENT 'Indicates whether VoLTE voice service is enabled for this service instance.',
    `vowifi_enabled_flag` BOOLEAN COMMENT 'Indicates whether VoWiFi (WiFi Calling) is enabled for this service instance.',
    CONSTRAINT pk_svc_configuration PRIMARY KEY(`svc_configuration_id`)
) COMMENT 'Master record storing the full technical configuration state applied to a service instance at any point in time — including bearer settings, APN bindings, QoS class identifiers, bandwidth profiles, VoLTE/IMS parameters (P-CSCF assignment, HD voice, VoWiFi), eSIM profile state (EID, ICCID, SM-DP+ reference), FTTH ONT bindings (OLT, PON port, T-CONT, GEM port, VLAN), MVNO overrides, roaming zone configuration, codec preferences, and CPE provisioning parameters. Technology-agnostic container supporting all service types through typed configuration attributes. Sourced from Netcracker OSS, Nokia NetAct, HLR/HSS, and OLT EMS.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`service`.`sla_profile` (
    `sla_profile_id` BIGINT COMMENT 'Unique identifier for the SLA profile. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: SLA governance requirement: SLA profiles defining service commitments must be approved by authorized employees before activation, critical for contract compliance and revenue assurance. Removes denorm',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: SLA profiles encode service commitments mandated by regulatory obligations (e.g., FCC broadband performance disclosure rules, wholesale interconnection SLAs, universal service quality standards). Link',
    `sla_template_id` BIGINT COMMENT 'Foreign key linking to product.sla_template. Business justification: Service SLA profiles instantiate product SLA templates with customer-specific parameters. Template defines baseline targets, penalties, and measurement methods used across all service instances refere',
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

CREATE OR REPLACE TABLE `telecommunication_ecm`.`service`.`service_qos_profile` (
    `service_qos_profile_id` BIGINT COMMENT 'Unique identifier for the QoS profile. Primary key.',
    `slice_id` BIGINT COMMENT 'Identifier of the 5G network slice (S-NSSAI) this QoS profile is associated with. Enables slice-specific QoS policies.',
    `aggregate_maximum_bit_rate_downlink_kbps` BIGINT COMMENT 'Aggregate maximum downlink bit rate in kbps across all non-GBR bearers for a subscriber.',
    `aggregate_maximum_bit_rate_uplink_kbps` BIGINT COMMENT 'Aggregate maximum uplink bit rate in kbps across all non-GBR bearers for a subscriber.',
    `application_category` STRING COMMENT 'Category of applications this QoS profile is optimized for (e.g., VoLTE, video streaming, gaming, IoT telemetry).',
    `arp_priority_level` STRING COMMENT 'ARP priority level (1-15, where 1 is highest). Controls resource allocation and bearer retention during congestion.',
    `charging_rule_name` STRING COMMENT 'Name of the charging rule associated with this QoS profile. Links QoS enforcement to billing/rating policies.',
    `congestion_handling_policy` STRING COMMENT 'Policy for handling traffic during network congestion: drop packets, throttle rate, queue, or prioritize.. Valid values are `drop|throttle|queue|prioritize`',
    `cos_marking` STRING COMMENT 'CoS value (0-7) applied to Ethernet frames for Layer 2 QoS prioritization.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this QoS profile record was first created in the system.',
    `dpi_policy_class` STRING COMMENT 'DPI policy class identifier applied to traffic matching this QoS profile. Used for traffic shaping and content filtering.',
    `dscp_marking` STRING COMMENT 'DSCP value (0-63) applied to IP packet headers for QoS marking in IP networks. Used for traffic prioritization.',
    `effective_end_date` DATE COMMENT 'Date when this QoS profile is retired or deprecated. Null for profiles with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this QoS profile becomes active and available for service provisioning.',
    `five_qi_value` STRING COMMENT '5QI value for 5G networks (1-9 standardized, 65-255 operator-specific). Defines packet forwarding treatment in 5G NR.',
    `guaranteed_bit_rate_downlink_kbps` BIGINT COMMENT 'Guaranteed downlink bit rate in kbps for GBR bearers. Null for non-GBR bearers.',
    `guaranteed_bit_rate_uplink_kbps` BIGINT COMMENT 'Guaranteed uplink bit rate in kbps for GBR bearers. Null for non-GBR bearers.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this QoS profile record was last updated.',
    `maximum_bit_rate_downlink_kbps` BIGINT COMMENT 'Maximum downlink bit rate in kbps. Enforced by BNG/BRAS or PCF/PCRF.',
    `maximum_bit_rate_uplink_kbps` BIGINT COMMENT 'Maximum uplink bit rate in kbps. Enforced by BNG/BRAS or PCF/PCRF.',
    `packet_delay_budget_ms` STRING COMMENT 'Maximum allowable one-way packet delay in milliseconds from UE to gateway. Critical for latency-sensitive services.',
    `packet_error_rate` DECIMAL(18,2) COMMENT 'Acceptable packet error rate (e.g., 0.000001 for 10^-6). Defines acceptable loss threshold for the QoS flow.',
    `pcf_policy_code` STRING COMMENT 'PCF policy identifier in 5G core network. References the policy rule enforced by the PCF.',
    `pcrf_policy_code` STRING COMMENT 'PCRF policy identifier in LTE/4G network. References the policy rule enforced by the PCRF.',
    `preemption_capability` STRING COMMENT 'Indicates whether this QoS profile can preempt resources from lower-priority bearers during congestion (enabled, disabled).. Valid values are `enabled|disabled`',
    `preemption_vulnerability` STRING COMMENT 'Indicates whether this QoS profile can be preempted by higher-priority bearers during congestion (enabled, disabled).. Valid values are `enabled|disabled`',
    `profile_code` STRING COMMENT 'Unique business identifier code for the QoS profile used across OSS/BSS systems.',
    `profile_name` STRING COMMENT 'Human-readable name of the QoS profile (e.g., Premium Voice, Enterprise Data, IoT Low Latency).',
    `profile_type` STRING COMMENT 'Classification of the QoS profile by service type (voice, data, video, IoT, converged, emergency).. Valid values are `voice|data|video|iot|converged|emergency`',
    `qci_value` STRING COMMENT 'QCI value for LTE/4G networks (1-9 standardized, 65-255 operator-specific). Defines packet forwarding treatment and scheduling priority.',
    `resource_type` STRING COMMENT 'Classification of resource allocation model: GBR (guaranteed bit rate), non-GBR (best effort), or delay-critical GBR.. Valid values are `gbr|non_gbr|delay_critical_gbr`',
    `service_qos_profile_description` STRING COMMENT 'Detailed description of the QoS profile purpose, use cases, and technical characteristics.',
    `service_qos_profile_status` STRING COMMENT 'Current lifecycle status of the QoS profile (active, inactive, deprecated, testing).. Valid values are `active|inactive|deprecated|testing`',
    `source_system` STRING COMMENT 'Name of the source system that defined this QoS profile (e.g., Netcracker OSS, Ericsson Network Manager).',
    `traffic_shaping_rule` STRING COMMENT 'Traffic shaping rule identifier or policy name applied to flows using this QoS profile (e.g., rate limiting, burst control).',
    CONSTRAINT pk_service_qos_profile PRIMARY KEY(`service_qos_profile_id`)
) COMMENT 'Reference master defining network-layer Quality of Service parameters applied to a service instance — QCI/5QI values, ARP priority, guaranteed bit rate (GBR), maximum bit rate (MBR), uplink/downlink throughput caps, DPI policy class, and traffic shaping rules. Linked to service instances and enforced by PCF/PCRF and BNG/BRAS nodes. Distinct from SLA profiles which represent commercial commitments. Sourced from Netcracker OSS and Ericsson Network Manager policy configurations.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`service`.`volte_ims_state` (
    `volte_ims_state_id` BIGINT COMMENT 'Unique identifier for the VoLTE IMS state record. Primary key for tracking individual service state instances across the IMS infrastructure.',
    `ims_node_id` BIGINT COMMENT 'Foreign key linking to network.ims_node. Business justification: VoLTE/IMS registrations are anchored to specific IMS nodes (P-CSCF/S-CSCF). Essential for voice service assurance, IMS node capacity management, and troubleshooting registration failures. Replaces den',
    `lawful_intercept_order_id` BIGINT COMMENT 'Foreign key linking to compliance.lawful_intercept_order. Business justification: VoLTE intercepts require IMS registration state (IMPI/IMPU, P-CSCF address, S-CSCF name) to provision call interception at the IMS layer. LEA orders targeting VoLTE services must reference IMS identit',
    `network_analytics_kpi_id` BIGINT COMMENT 'Foreign key linking to analytics.network_analytics_kpi. Business justification: VoLTE/IMS registration states feed network KPIs like IMS registration success rate, VoLTE capability penetration, HD voice adoption, and VoWiFi usage. Essential for network performance monitoring, tec',
    `network_qos_profile_id` BIGINT COMMENT 'Identifier of the Quality of Service profile applied to this VoLTE service instance, defining bandwidth, latency, and priority parameters.',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber whose VoLTE/IMS service state is being tracked. Links to the customer domain subscriber entity.',
    `svc_instance_id` BIGINT COMMENT 'Reference to the active service instance for which this VoLTE/IMS state applies. Links to the service instance entity in the service domain.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to interconnect.interconnect_carrier. Business justification: VoLTE roaming IMS registration state requires visited carrier tracking for inter-carrier IMS interworking, TAP CDR generation, and VoLTE roaming settlement. Critical for IR.92/IR.51 compliance.',
    `barring_status` STRING COMMENT 'Indicates any call barring restrictions applied to the VoLTE service, such as outgoing, incoming, or international call restrictions.. Valid values are `none|outgoing_barred|incoming_barred|all_barred|international_barred|roaming_barred`',
    `call_forwarding_status` STRING COMMENT 'Current call forwarding configuration for the VoLTE service. Indicates if and under what conditions calls are forwarded to another number.. Valid values are `disabled|unconditional|busy|no_answer|not_reachable`',
    `call_waiting_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether call waiting supplementary service is enabled, allowing the subscriber to receive a second call while on an active call.',
    `caller_id_presentation` STRING COMMENT 'Configuration for outgoing caller ID presentation. Determines whether the subscribers number is displayed to called parties.. Valid values are `allowed|restricted|not_available|network_default`',
    `charging_function_address` STRING COMMENT 'The address of the Online Charging System (OCS) or Offline Charging System (OFCS) handling billing events for this VoLTE service instance.',
    `codec_preference` STRING COMMENT 'The preferred voice codec configuration for this subscriber (e.g., EVS, AMR-WB, AMR-NB). Determines audio quality and bandwidth usage.',
    `deregistration_timestamp` TIMESTAMP COMMENT 'The date and time when the subscriber was last deregistered from the IMS network, either explicitly or due to timeout/failure.',
    `emergency_call_capability` BOOLEAN COMMENT 'Boolean flag indicating whether the subscriber can place emergency calls (E911/E112) over VoLTE. Critical for regulatory compliance with emergency services requirements.',
    `emergency_location_info` STRING COMMENT 'The most recent location information (cell ID, GPS coordinates, or civic address) available for emergency call routing. Critical for E911 compliance.',
    `esrvcc_capability` BOOLEAN COMMENT 'Indicates whether the subscriber and network support enhanced SRVCC for seamless handover of VoLTE calls to 3G/2G networks and emergency call continuity.',
    `hd_voice_enabled` BOOLEAN COMMENT 'Indicates whether High Definition voice codec (EVS or AMR-WB) is enabled for this subscriber, providing enhanced audio quality over VoLTE.',
    `hss_address` STRING COMMENT 'The address of the Home Subscriber Server storing the subscriber profile and authentication credentials for IMS services.',
    `impi` STRING COMMENT 'The private identity used for IMS authentication and authorization. Typically derived from IMSI and used in SIP registration.',
    `impu` STRING COMMENT 'The public identity (SIP URI or TEL URI) used for IMS service delivery. Visible to other users and used for call establishment.',
    `ims_registration_status` STRING COMMENT 'Current registration state of the subscriber in the IMS core network. Indicates whether the subscriber can initiate or receive VoLTE calls.. Valid values are `registered|unregistered|authentication_pending|registration_failed|deregistered|expired`',
    `imsi` STRING COMMENT 'The 15-digit International Mobile Subscriber Identity uniquely identifying the subscriber in the IMS/HSS system. Critical for IMS registration and authentication.. Valid values are `^[0-9]{15}$`',
    `last_call_timestamp` TIMESTAMP COMMENT 'The date and time of the most recent VoLTE call (incoming or outgoing) made by this subscriber. Used for activity monitoring and churn prediction.',
    `last_location_update` TIMESTAMP COMMENT 'The timestamp of the most recent location update received from the subscriber device. Used for emergency services location accuracy.',
    `last_sync_timestamp` TIMESTAMP COMMENT 'The timestamp when this VoLTE IMS state record was last synchronized from the source IMS HSS/UDM or network management system.',
    `msisdn` STRING COMMENT 'The telephone number associated with the subscriber for VoLTE service. Used for call routing and billing correlation.. Valid values are `^[0-9]{10,15}$`',
    `network_assigned_uri` STRING COMMENT 'The SIP URI assigned by the network for IMS service delivery. May differ from the public identity for routing purposes.',
    `provisioning_system` STRING COMMENT 'Identifier of the OSS/BSS system that provisioned this VoLTE service state record (e.g., Oracle OSM, Netcracker OSS, Ericsson Network Manager).',
    `rcs_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether Rich Communication Services (advanced messaging over IMS) is enabled for this subscriber.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this VoLTE IMS state record was first created in the data lakehouse. Used for data lineage and audit purposes.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this VoLTE IMS state record was last modified in the data lakehouse. Tracks data currency for analytics and reporting.',
    `registration_expiry_time` TIMESTAMP COMMENT 'The timestamp when the current IMS registration will expire if not refreshed. Determines when re-registration is required.',
    `registration_timestamp` TIMESTAMP COMMENT 'The date and time when the subscriber last successfully registered with the IMS network. Used for session management and troubleshooting.',
    `roaming_status` STRING COMMENT 'Current roaming state of the subscriber for VoLTE service. Affects routing, charging, and service availability.. Valid values are `home|domestic_roaming|international_roaming|not_roaming`',
    `service_activation_date` DATE COMMENT 'The date when VoLTE service was first activated for this subscriber. Used for service tenure analysis and billing cycle determination.',
    `service_status` STRING COMMENT 'Current lifecycle status of the VoLTE service instance. Determines whether the subscriber can use VoLTE features.. Valid values are `active|suspended|deactivated|provisioning|pending_activation|barred`',
    `sla_tier` STRING COMMENT 'The service level agreement tier assigned to this VoLTE service, determining priority, support level, and performance guarantees.. Valid values are `premium|standard|basic|enterprise|wholesale`',
    `ue_capability_version` STRING COMMENT 'The IMS capability version reported by the subscribers device. Indicates supported features and protocol versions.',
    `video_calling_enabled` BOOLEAN COMMENT 'Indicates whether video calling over IMS (ViLTE) is enabled for this subscriber. Requires additional QoS and device capability.',
    `visited_network_code` STRING COMMENT 'Identifier of the visited network when the subscriber is roaming. Null when in home network. Used for inter-operator billing and routing.',
    `volte_capability_flag` BOOLEAN COMMENT 'Boolean indicator of whether the subscriber device and subscription support VoLTE service. True indicates VoLTE is enabled and available.',
    `vowifi_status` STRING COMMENT 'Current status of Wi-Fi calling capability for the subscriber. Indicates whether the subscriber can make VoLTE calls over Wi-Fi networks.. Valid values are `enabled|disabled|not_provisioned|active|inactive`',
    CONSTRAINT pk_volte_ims_state PRIMARY KEY(`volte_ims_state_id`)
) COMMENT 'Master record tracking the real-time and historical VoLTE/IMS service state for a subscribers service instance — IMS registration status, P-CSCF/S-CSCF assignment, VoLTE capability flag, HD voice enablement, Wi-Fi calling (VoWiFi) status, emergency call (eSRVCC) capability, and last registration timestamp. Critical for voice service assurance and regulatory emergency services compliance. Sourced from IMS HSS/UDM and Ericsson Network Manager.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`service`.`esim_profile` (
    `esim_profile_id` BIGINT COMMENT 'Unique identifier for the eSIM profile record. Primary key for the service eSIM profile entity.',
    `device_model_id` BIGINT COMMENT 'Foreign key linking to product.device_model. Business justification: eSIM profile provisioning must validate device eSIM capability, firmware version, and LPA compatibility from device model master data. Critical for activation success and regulatory compliance reporti',
    `network_analytics_kpi_id` BIGINT COMMENT 'Foreign key linking to analytics.network_analytics_kpi. Business justification: eSIM profile states feed network KPIs like eSIM activation success rate, profile download completion rate, multi-profile adoption, and remote provisioning performance. Required for eSIM technology per',
    `network_qos_profile_id` BIGINT COMMENT 'Reference to the QoS profile that defines the service quality parameters for this eSIM profile. Includes bandwidth limits, latency targets, packet loss thresholds, and priority levels.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to interconnect.interconnect_carrier. Business justification: eSIM profiles for multi-IMSI or roaming scenarios track the partner carrier for profile provisioning, SM-DP+ coordination, and international eSIM roaming agreements (GSMA SGP.22).',
    `privacy_consent_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_consent. Business justification: eSIM profile provisioning processes subscriber identity data (IMSI, EID, ICCID) and enables remote SIM management. GDPR/privacy laws require explicit consent for profile downloads, remote enable/disab',
    `sim_stock_id` BIGINT COMMENT 'Foreign key linking to inventory.sim_stock. Business justification: eSIM profile lifecycle management requires linking to SIM inventory for activation code generation, SMDP+ provisioning, inventory depletion tracking, and regulatory compliance reporting. Tracks which ',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber who owns this eSIM profile. Links the eSIM profile to the customer subscriber record.',
    `svc_instance_id` BIGINT COMMENT 'Reference to the active service instance that this eSIM profile delivers. Links the eSIM profile to the logical service layer.',
    `activation_code` STRING COMMENT 'QR code or alphanumeric string provided to the subscriber for profile download and installation. Contains the SM-DP+ address, matching ID, and confirmation code. Typically delivered via email, SMS, or printed on packaging.',
    `confirmation_code` STRING COMMENT 'Security code used to authenticate the profile download request. Prevents unauthorized profile downloads. Part of the activation code and validated by the SM-DP+ during the download process.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this eSIM profile record was first created in the system. Used for audit trails, data lineage, and lifecycle tracking.',
    `deleted_timestamp` TIMESTAMP COMMENT 'Date and time when the eSIM profile was permanently deleted from the eUICC. The profile is removed from storage and cannot be recovered. The ICCID may be reused for a new profile.',
    `device_imei` STRING COMMENT 'Unique 15-digit identifier of the mobile device hardware where this eSIM profile is installed. Used for device tracking, theft prevention, and network access control.. Valid values are `^[0-9]{15}$`',
    `device_model` STRING COMMENT 'Make and model of the device where this eSIM profile is installed. Used for device compatibility tracking, troubleshooting, and targeted service offerings.',
    `disabled_timestamp` TIMESTAMP COMMENT 'Date and time when the eSIM profile was disabled and deactivated from network access. The profile remains on the eUICC but cannot connect to the mobile network until re-enabled.',
    `download_timestamp` TIMESTAMP COMMENT 'Date and time when the eSIM profile was successfully downloaded from the SM-DP+ server to the eUICC. Marks the beginning of the profile installation process.',
    `eid` STRING COMMENT 'Unique 32-digit identifier of the embedded Universal Integrated Circuit Card (eUICC) chip in the subscriber device. Globally unique hardware identifier assigned by the eUICC manufacturer per GSMA SGP.02 specification.. Valid values are `^[0-9]{32}$`',
    `enabled_timestamp` TIMESTAMP COMMENT 'Date and time when the eSIM profile was enabled and activated for network access. The profile is now the active profile on the eUICC and can connect to the mobile network.',
    `euicc_firmware_version` STRING COMMENT 'Version of the firmware running on the eUICC chip. Determines compatibility with different profile formats, security features, and RSP specification versions.',
    `expiry_date` DATE COMMENT 'Date when the eSIM profile expires and can no longer be used for network access. Used for temporary profiles, trial subscriptions, and prepaid services with fixed validity periods.',
    `imsi` STRING COMMENT 'Unique 14-15 digit identifier stored in the eSIM profile that identifies the subscriber on the mobile network. Used for authentication, authorization, and routing in the HLR/HSS. Format: MCC (3 digits) + MNC (2-3 digits) + MSIN (9-10 digits).. Valid values are `^[0-9]{14,15}$`',
    `installation_timestamp` TIMESTAMP COMMENT 'Date and time when the eSIM profile was successfully installed on the eUICC. The profile is now stored on the chip but not yet enabled for network access.',
    `is_mnp_eligible` BOOLEAN COMMENT 'Indicates whether this eSIM profile is eligible for Mobile Number Portability (MNP). True if the MSISDN can be ported to another operator, false if porting is restricted or not supported.',
    `is_multi_profile_enabled` BOOLEAN COMMENT 'Indicates whether this eSIM profile is part of a multi-profile eUICC configuration. True if the eUICC can store and switch between multiple profiles, false if it supports only a single profile.',
    `is_roaming_enabled` BOOLEAN COMMENT 'Indicates whether international and domestic roaming is enabled for this eSIM profile. True if the profile can connect to partner networks outside the home network, false if roaming is disabled.',
    `last_location_update_timestamp` TIMESTAMP COMMENT 'Date and time when the network last received a location update from this eSIM profile. Used for subscriber location tracking, emergency services, and roaming analytics.',
    `last_network_attach_timestamp` TIMESTAMP COMMENT 'Date and time when this eSIM profile last successfully attached to the mobile network. Used for activity monitoring, fraud detection, and service usage analytics.',
    `lpa_version` STRING COMMENT 'Version of the Local Profile Assistant (LPA) software on the device. The LPA manages profile download, installation, enabling, disabling, and deletion on the eUICC.',
    `matching_code` STRING COMMENT 'Unique identifier used by the SM-DP+ to match the eUICC with the correct profile during download. Part of the activation code and used in the secure profile download handshake.',
    `mcc` STRING COMMENT 'Three-digit code identifying the country of the mobile network operator. Part of the IMSI and used for international roaming and network selection.. Valid values are `^[0-9]{3}$`',
    `mnc` STRING COMMENT 'Two or three-digit code identifying the mobile network operator within a country. Part of the IMSI and used for network identification and roaming partner selection.. Valid values are `^[0-9]{2,3}$`',
    `msisdn` STRING COMMENT 'The telephone number associated with this eSIM profile. Used for voice calls, SMS, and subscriber identification. Format follows E.164 international numbering plan.. Valid values are `^+?[1-9][0-9]{7,14}$`',
    `operator_name` STRING COMMENT 'Name of the mobile network operator (MNO) that issued this eSIM profile. Displayed in device settings and used for subscriber identification.',
    `profile_class` STRING COMMENT 'Business classification of the eSIM profile. Consumer profiles for handsets and tablets, M2M (Machine-to-Machine) profiles for connected devices, IoT (Internet of Things) profiles for low-power sensors and embedded systems.. Valid values are `consumer|m2m|iot`',
    `profile_nickname` STRING COMMENT 'User-defined friendly name for the eSIM profile displayed in the device settings. Helps subscribers distinguish between multiple profiles on the same eUICC (e.g., Personal, Work, Travel).',
    `profile_size_kb` DECIMAL(18,2) COMMENT 'Size of the encrypted eSIM profile package in kilobytes. Used for eUICC storage capacity planning and download bandwidth estimation.',
    `profile_state` STRING COMMENT 'Current lifecycle state of the eSIM profile on the eUICC. Tracks the profile from creation through download, installation, activation, and deletion. Managed by the Local Profile Assistant (LPA) on the device. [ENUM-REF-CANDIDATE: available|downloading|downloaded|installing|installed|enabled|disabled|deleted — 8 candidates stripped; promote to reference product]',
    `profile_type` STRING COMMENT 'Classification of the eSIM profile purpose. Operational profiles are for live subscriber service, test profiles for QA and device testing, bootstrap profiles for initial device provisioning, and provisioning profiles for remote SIM provisioning workflows.. Valid values are `operational|test|bootstrap|provisioning`',
    `profile_version` STRING COMMENT 'Version number of the eSIM profile format and content. Indicates the profile generation and compatibility with different eUICC firmware versions and RSP specification releases.',
    `provisioned_timestamp` TIMESTAMP COMMENT 'Date and time when the eSIM profile was created and encrypted on the SM-DP+ server. Marks the beginning of the profile lifecycle before download.',
    `sla_tier` STRING COMMENT 'Service level tier assigned to this eSIM profile. Defines the guaranteed service quality, support response times, and compensation terms for service disruptions.. Valid values are `platinum|gold|silver|bronze|basic`',
    `smdp_address` STRING COMMENT 'Fully qualified domain name (FQDN) or IP address of the SM-DP+ server that hosts and delivers this eSIM profile. The SM-DP+ is responsible for profile encryption, secure delivery, and lifecycle management per GSMA RSP architecture.',
    `smds_address` STRING COMMENT 'Fully qualified domain name (FQDN) or IP address of the SM-DS server used for profile discovery. The SM-DS enables the eUICC to discover available profiles from multiple SM-DP+ servers in multi-operator scenarios.',
    `source_system` STRING COMMENT 'Name of the operational system that created or last updated this eSIM profile record. Typically the SM-DP+ platform, OSS/BSS suite, or service provisioning system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this eSIM profile record was last modified in the system. Used for change tracking, audit trails, and data synchronization.',
    CONSTRAINT pk_esim_profile PRIMARY KEY(`esim_profile_id`)
) COMMENT 'Master record for each eSIM (eUICC) profile provisioned to a subscriber device — EID, ICCID, profile state (downloaded, enabled, disabled, deleted), SM-DP+ server reference, profile type (operational/test/bootstrap), activation code, and download timestamp. Tracks the full eSIM lifecycle from SM-DP+ provisioning through device enablement. Supports MNP and multi-profile eSIM scenarios. Governed by GSMA SGP.22 RSP specification.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`service`.`svc_status_history` (
    `svc_status_history_id` BIGINT COMMENT 'Unique identifier for each service status transition event. Primary key for the service status history log.',
    `billing_account_id` BIGINT COMMENT 'Reference to the billing account responsible for charges related to this service instance. Links service lifecycle to billing and revenue management.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise service status transitions must track corporate account for SLA reporting, contract compliance audits, and account-level service health dashboards. Essential for B2B service management.',
    `customer_analytics_kpi_id` BIGINT COMMENT 'Foreign key linking to analytics.customer_analytics_kpi. Business justification: Service status transitions feed customer KPIs like service uptime percentage, suspension rate, churn indicators, and service stability metrics. Critical for customer experience measurement, churn pred',
    `employee_id` BIGINT COMMENT 'Identifier of the specific actor who or which initiated the status change. May be a customer ID, employee ID, system process name, or regulatory order reference depending on the actor type.',
    `provisioning_order_id` BIGINT COMMENT 'Reference to the order that triggered this status transition, if applicable. Links service lifecycle events to the order management domain for fulfillment tracking.',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber who owns or uses the service instance. Links service lifecycle events to the customer domain for churn and retention analysis.',
    `svc_instance_id` BIGINT COMMENT 'Reference to the service instance that underwent the status transition. Links to the service instance master record.',
    `trouble_ticket_id` BIGINT COMMENT 'Reference to the trouble ticket or incident that caused this status transition, if applicable. Links service disruptions to fault management processes.',
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
    `initiating_actor_name` STRING COMMENT 'Human-readable name or label of the actor who initiated the transition. Provides business context for audit trails and dispute resolution.',
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
    `esim_profile_id` BIGINT COMMENT 'The eSIM profile identifier associated with this number assignment. Applicable for eSIM-enabled service instances.',
    `lawful_intercept_order_id` BIGINT COMMENT 'Foreign key linking to compliance.lawful_intercept_order. Business justification: Intercept orders specify target MSISDNs; number assignments track which service instance currently owns each MSISDN. LEA fulfillment workflows require this link to identify the correct service instanc',
    `mnp_transaction_id` BIGINT COMMENT 'Foreign key linking to interconnect.mnp_transaction. Business justification: MSISDN assignments link to MNP transactions when number portability occurs. Essential for porting workflow tracking, regulatory compliance reporting, and HLR/NPAC routing updates.',
    `msisdn_range_id` BIGINT COMMENT 'Reference to the regulatory number range from which this number was allocated. Links to the inventory domain number range master.',
    `mvno_profile_id` BIGINT COMMENT 'Foreign key linking to partner.mvno_profile. Business justification: MSISDN assignments within MVNO number ranges must track MVNO owner for number inventory management, regulatory ownership reporting, porting coordination, and wholesale billing. Core MVNO operational r',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber who owns this number assignment. Enables customer-level number inventory reporting.',
    `svc_instance_id` BIGINT COMMENT 'Reference to the active service instance to which this number is assigned. Links the number to the provisioned service.',
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
    `billing_account_id` BIGINT COMMENT 'Reference to the billing account associated with the suspended service. Used for billing impact tracking in Amdocs Revenue Management.',
    `case_id` BIGINT COMMENT 'Reference to the customer service case in Salesforce CRM associated with this suspension. Used for tracking customer interactions, disputes, and resolution workflows. Null if no case was created.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise service suspensions must track corporate account for contract impact analysis, billing adjustments, account-level suspension policies, and escalation to account management teams in B2B scen',
    `dunning_event_id` BIGINT COMMENT 'Reference to the dunning event in Amdocs Revenue Management that triggered this suspension for non-payment scenarios. Links to the collections workflow. Null for non-payment-related suspensions.',
    `employee_id` BIGINT COMMENT 'User ID or system ID of the person or system that initiated the suspension. For agent-initiated suspensions, this is the Salesforce CRM user ID. For system-initiated, this is the system process identifier. Null for customer-initiated suspensions.',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the service order in Oracle OSM that executed the suspension or reinstatement. Links to the order management and fulfillment workflow. Null if no formal order was created.',
    `dealer_id` BIGINT COMMENT 'Foreign key linking to partner.dealer. Business justification: Suspensions of dealer-originated services require tracking originating dealer for fraud pattern analysis, commission clawback processing, and dealer compliance monitoring. Essential for indirect chann',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber whose service was suspended. Links to the customer subscriber record in Salesforce CRM.',
    `svc_instance_id` BIGINT COMMENT 'Reference to the service instance that was suspended. Links to the active service instance in the service inventory managed by Oracle OSM and Netcracker OSS.',
    `trouble_ticket_id` BIGINT COMMENT 'Foreign key linking to assurance.trouble_ticket. Business justification: Service suspensions may trigger customer disputes requiring trouble ticket investigation. Supports tracking wrongful suspension cases and regulatory compliance for service restoration timelines.',
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

CREATE OR REPLACE TABLE `telecommunication_ecm`.`service`.`service_mnp_request` (
    `service_mnp_request_id` BIGINT COMMENT 'Unique identifier for the mobile number portability request transaction. Primary key for the service MNP request entity.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: MNP requests require billing account validation for outstanding balance checks, early termination fee calculation, and final bill generation. Regulatory requirement for port-out authorization and fina',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise MNP requests for bulk number porting must link to corporate account for contract validation, approval workflows, and coordinated porting schedules. Essential for enterprise customer migrati',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: MNP requests require linking donor operator to partner entity for interconnect settlement, dispute resolution with donor, and regulatory clearinghouse reporting. Replaces denormalized donor_operator_n',
    `mnp_transaction_id` BIGINT COMMENT 'Foreign key linking to interconnect.mnp_transaction. Business justification: Service-side MNP request directly maps to interconnect-side transaction for bilateral porting coordination between donor and recipient carriers. Critical for inter-carrier porting workflow and clearin',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system that submitted the MNP request (customer service representative, online portal, API).',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber who initiated or is subject to the mobile number portability request.',
    `svc_instance_id` BIGINT COMMENT 'Reference to the service instance being ported (the mobile service associated with the MSISDN).',
    `account_number` STRING COMMENT 'The subscriber account number with the donor operator, used for validation and authorization of the port request.',
    `actual_port_completion_datetime` TIMESTAMP COMMENT 'The actual date and time when the mobile number portability was successfully completed and the number became active on the recipient network.',
    `actual_processing_hours` DECIMAL(18,2) COMMENT 'The actual elapsed time in hours from request submission to completion, used for SLA compliance measurement.',
    `authorization_code` STRING COMMENT 'Security code or PIN provided by the subscriber to authorize the porting request and prevent unauthorized number transfers.. Valid values are `^[A-Z0-9]{6,12}$`',
    `balance_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the outstanding balance amount.. Valid values are `^[A-Z]{3}$`',
    `cancellation_reason` STRING COMMENT 'Explanation of why the MNP request was cancelled, including whether it was subscriber-initiated or operator-initiated cancellation.',
    `clearinghouse_transaction_code` STRING COMMENT 'Transaction identifier assigned by the national MNP clearinghouse system for inter-operator coordination and reconciliation.',
    `contract_end_date` DATE COMMENT 'The date on which the subscriber contract with the donor operator is scheduled to end, relevant for early termination fees.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this MNP request record was first created in the system.',
    `donor_operator_code` STRING COMMENT 'Unique code identifying the telecommunications operator from which the mobile number is being ported (the losing operator).. Valid values are `^[A-Z0-9]{3,10}$`',
    `donor_response_code` STRING COMMENT 'Standardized response code provided by the donor operator in response to the port request.. Valid values are `^[A-Z0-9]{2,10}$`',
    `early_termination_fee_amount` DECIMAL(18,2) COMMENT 'The monetary amount of the early termination fee charged by the donor operator, if applicable.',
    `early_termination_fee_applicable` BOOLEAN COMMENT 'Indicates whether an early termination fee applies to this porting request due to contract obligations with the donor operator.',
    `iccid` STRING COMMENT 'Unique identifier of the SIM card associated with the mobile number being ported.. Valid values are `^[0-9]{19,20}$`',
    `imsi` STRING COMMENT 'Unique international identifier for the mobile subscriber, stored on the SIM card and used for network authentication.. Valid values are `^[0-9]{14,15}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this MNP request record was last updated or modified.',
    `mnp_request_number` STRING COMMENT 'Externally visible unique business identifier for the MNP request, used for tracking and reference with national MNP clearinghouse and operators.. Valid values are `^MNP[0-9]{10,15}$`',
    `msisdn` STRING COMMENT 'The mobile phone number being ported. This is the primary identifier for the mobile subscriber in the public switched telephone network.. Valid values are `^[0-9]{10,15}$`',
    `network_technology` STRING COMMENT 'The mobile network technology generation associated with the service being ported.. Valid values are `2G|3G|4G|5G|LTE|VoLTE`',
    `outstanding_balance_amount` DECIMAL(18,2) COMMENT 'Any outstanding financial balance on the subscriber account with the donor operator at the time of the port request.',
    `porting_direction` STRING COMMENT 'Indicates whether this is a port-in request (number coming into this operator) or port-out request (number leaving this operator).. Valid values are `port_in|port_out`',
    `porting_status` STRING COMMENT 'Current lifecycle status of the mobile number portability request in the porting workflow. [ENUM-REF-CANDIDATE: submitted|validated|in_progress|completed|rejected|cancelled|failed — 7 candidates stripped; promote to reference product]',
    `processing_priority` STRING COMMENT 'Priority level assigned to the MNP request for processing queue management and SLA adherence.. Valid values are `low|normal|high|urgent`',
    `recipient_acknowledgement_timestamp` TIMESTAMP COMMENT 'Date and time when the recipient operator acknowledged receipt and acceptance of the port request.',
    `recipient_operator_code` STRING COMMENT 'Unique code identifying the telecommunications operator to which the mobile number is being ported (the gaining operator).. Valid values are `^[A-Z0-9]{3,10}$`',
    `recipient_operator_name` STRING COMMENT 'Full business name of the recipient telecommunications operator.',
    `regulatory_reference_number` STRING COMMENT 'Unique reference number assigned by the national MNP clearinghouse or regulatory authority for tracking and compliance purposes.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating the reason for rejection of the MNP request, if applicable. Null if request was not rejected.. Valid values are `^[A-Z0-9]{2,10}$`',
    `rejection_reason_description` STRING COMMENT 'Detailed human-readable explanation of why the MNP request was rejected, providing context beyond the rejection code.',
    `request_type` STRING COMMENT 'Classification of the MNP request based on processing priority and timeline requirements.. Valid values are `standard|expedited|emergency`',
    `requested_port_date` DATE COMMENT 'The date on which the subscriber has requested the mobile number portability to be completed.',
    `scheduled_port_datetime` TIMESTAMP COMMENT 'The precise date and time scheduled for the porting cutover event, coordinated between donor and recipient operators.',
    `service_type` STRING COMMENT 'Classification of the mobile service being ported based on billing model (prepaid, postpaid, or hybrid).. Valid values are `prepaid|postpaid|hybrid`',
    `sim_type` STRING COMMENT 'Indicates whether the service uses a physical SIM card or an embedded SIM (eSIM) profile.. Valid values are `physical_sim|esim`',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the MNP request processing exceeded the SLA target completion time.',
    `sla_target_completion_hours` STRING COMMENT 'The number of hours within which the MNP request must be completed according to regulatory or contractual SLA requirements.',
    `submission_channel` STRING COMMENT 'The channel or interface through which the MNP request was submitted by the subscriber or on their behalf.. Valid values are `web_portal|mobile_app|call_center|retail_store|api|partner_portal`',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the MNP request was initially submitted to the system or clearinghouse.',
    `subscriber_address` STRING COMMENT 'Registered address of the subscriber with the donor operator, used for validation purposes during the porting process.',
    `validation_status` STRING COMMENT 'Status of the validation checks performed on the MNP request data against donor operator records.. Valid values are `pending|passed|failed`',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when the MNP request validation was completed by the donor operator or clearinghouse.',
    CONSTRAINT pk_service_mnp_request PRIMARY KEY(`service_mnp_request_id`)
) COMMENT 'Transactional record managing Mobile Number Portability (MNP) port-in and port-out requests. Captures porting direction (in/out), donor/recipient operator, MSISDN being ported, requested port date, actual completion date, porting status (submitted, validated, completed, rejected, cancelled), rejection reason code, and regulatory reference number. Interfaces with national MNP clearinghouse. Governed by FCC/Ofcom MNP regulations.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` (
    `ftth_ont_config_id` BIGINT COMMENT 'Unique identifier for the FTTH ONT configuration record. Primary key for this master resource entity representing the logical-to-physical binding between FTTH service instance and passive optical network infrastructure.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: FTTH installations trigger billing account setup for installation charges, CPE rental fees, and bandwidth tier billing. Required for fiber service activation billing, technician dispatch charges, and ',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to finance.capital_project. Business justification: FTTH ONT installations are part of fiber network build-out capex projects; linking enables project cost tracking, milestone-based budget consumption analysis, homes-passed ROI calculation, and regulat',
    `enterprise_site_id` BIGINT COMMENT 'Foreign key linking to enterprise.site. Business justification: FTTH ONT installations at enterprise customer sites must link to site for asset tracking, service delivery verification, and site-level fiber infrastructure management in B2B fiber deployments.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: ONT devices are capitalized customer premises equipment tracked in fixed asset register for depreciation calculation, asset lifecycle management, insurance valuation, and regulatory asset base reporti',
    `technician_id` BIGINT COMMENT 'Identifier of the field technician who performed the ONT installation. Used for quality tracking and accountability.',
    `network_qos_profile_id` BIGINT COMMENT 'Reference to the QoS profile defining traffic prioritization, latency targets, and packet handling rules for this ONT configuration.',
    `olt_asset_id` BIGINT COMMENT 'Identifier of the OLT node in the central office or remote cabinet that serves this ONT. Represents the aggregation point in the GPON architecture.',
    `element_id` BIGINT COMMENT 'Foreign key linking to network.element. Business justification: FTTH ONT configurations must reference the OLT network element for fiber service provisioning, PON port management, and fault isolation. Critical for fiber network operations, capacity planning, and s',
    `ont_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.ont_asset. Business justification: FTTH service provisioning requires linking logical ONT configuration to physical ONT inventory asset for optical power monitoring, firmware management, warranty tracking, and field replacement workflo',
    `device_model_id` BIGINT COMMENT 'Foreign key linking to product.device_model. Business justification: FTTH provisioning requires ONT device model specifications (firmware, PON technology, port count) for OLT configuration. Removes denormalized ont_model and ont_vendor attributes, enforcing 3NF.',
    `ont_ont_asset_id` BIGINT COMMENT 'Logical identifier assigned to the ONT within the PON port context (0-127 for GPON). Used in PLOAM messages and bandwidth allocation.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to location.premise. Business justification: ONT devices are physically installed at specific premises in FTTH deployments. Required for premise-level network inventory, fiber drop management, ONT replacement workflows, and premise serviceabilit',
    `provisioning_order_id` BIGINT COMMENT 'Reference to the service order that triggered this ONT configuration. Links provisioning activity to customer order fulfillment workflow.',
    `sla_profile_id` BIGINT COMMENT 'Reference to the SLA profile defining uptime commitments, MTTR targets, and support tier for this FTTH service configuration.',
    `svc_instance_id` BIGINT COMMENT 'Reference to the parent FTTH service instance that this ONT configuration supports. Links the physical ONT device to the logical service layer.',
    `trouble_ticket_id` BIGINT COMMENT 'Foreign key linking to assurance.trouble_ticket. Business justification: ONT equipment failures are primary driver of fiber service trouble tickets. Essential for tracking CPE reliability, vendor performance, and field technician dispatch efficiency.',
    `activation_timestamp` TIMESTAMP COMMENT 'Date and time when the ONT was successfully activated and began passing customer traffic. Key milestone for service delivery SLA measurement.',
    `auto_discovery_enabled` BOOLEAN COMMENT 'Indicates whether the ONT is configured for automatic discovery and provisioning when connected to the PON. Simplifies zero-touch deployment.',
    `configuration_notes` STRING COMMENT 'Free-text field for operational notes, special configuration requirements, or troubleshooting history related to this ONT.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this ONT configuration record was first created in the system. Audit trail for data lineage.',
    `cvlan_number` STRING COMMENT 'Customer VLAN (inner VLAN tag) used in QinQ double-tagging for end-customer service identification within carrier network.',
    `deactivation_timestamp` TIMESTAMP COMMENT 'Date and time when the ONT was deactivated or disconnected from service. Used for churn analysis and resource reclamation.',
    `downstream_bandwidth_mbps` DECIMAL(18,2) COMMENT 'Configured downstream bandwidth limit in megabits per second. Represents the maximum download speed available to the customer.',
    `downstream_bandwidth_profile` STRING COMMENT 'Name or identifier of the bandwidth profile governing downstream traffic from OLT to ONT. Defines service tier bandwidth limits.',
    `encryption_enabled` BOOLEAN COMMENT 'Indicates whether AES encryption is enabled for downstream traffic to this ONT. Security feature mandated for sensitive services.',
    `external_reference_code` STRING COMMENT 'Identifier used in the source OSS/EMS system (Netcracker, OLT EMS) for this ONT configuration. Enables cross-system reconciliation and troubleshooting.',
    `fiber_distance_meters` STRING COMMENT 'Physical distance in meters from OLT to ONT along the fiber path. Used for optical budget calculations and troubleshooting.',
    `gem_port_number` STRING COMMENT 'GEM port identifier for traffic segmentation and QoS mapping. Multiple GEM ports can be assigned to a single ONT for service differentiation.',
    `installation_date` DATE COMMENT 'Date when the ONT was physically installed at the customer premises by field technician. Used for warranty tracking and asset lifecycle management.',
    `ipv6_enabled` BOOLEAN COMMENT 'Indicates whether IPv6 protocol support is enabled on this ONT configuration. Required for dual-stack or IPv6-only service delivery.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this ONT configuration record was last updated. Tracks configuration change history for compliance and troubleshooting.',
    `last_online_timestamp` TIMESTAMP COMMENT 'Most recent date and time when the ONT was detected online by the OLT. Used for availability monitoring and fault detection.',
    `managed_in_system` STRING COMMENT 'Source system responsible for managing this ONT configuration. Identifies the authoritative OSS/EMS platform for configuration changes.. Valid values are `Netcracker OSS|Ericsson Network Manager|Nokia NetAct|Manual`',
    `modified_by` STRING COMMENT 'User ID or system identifier that last modified this ONT configuration record. Accountability for configuration changes.',
    `multicast_enabled` BOOLEAN COMMENT 'Indicates whether IGMP multicast is enabled for IPTV service delivery to this ONT. Required for live TV channel distribution.',
    `olt_chassis_slot` STRING COMMENT 'Physical slot number in the OLT chassis where the line card serving this ONT is installed. Used for capacity planning and fault isolation.',
    `olt_pon_port` STRING COMMENT 'PON port number on the OLT line card to which this ONT is connected. Each PON port supports up to 128 ONTs in GPON architecture.',
    `ont_firmware_version` STRING COMMENT 'Current firmware version running on the ONT device. Tracked for security patching, feature enablement, and troubleshooting.. Valid values are `^[0-9]+.[0-9]+.[0-9]+(.[0-9]+)?$`',
    `ont_location_description` STRING COMMENT 'Textual description of the ONT physical installation location at customer premises (e.g., basement, garage, utility closet). Aids field technicians during service calls.',
    `optical_power_rx_dbm` DECIMAL(18,2) COMMENT 'Received optical power level at the ONT in dBm. Critical performance indicator for signal quality and fiber health monitoring.',
    `optical_power_tx_dbm` DECIMAL(18,2) COMMENT 'Transmitted optical power level from the ONT in dBm. Monitored to ensure compliance with GPON specifications and prevent OLT receiver saturation.',
    `provisioning_status` STRING COMMENT 'Current state of the ONT provisioning workflow. Tracks progression from initial configuration through activation to service delivery. [ENUM-REF-CANDIDATE: pending|in_progress|provisioned|active|suspended|deprovisioned|failed — 7 candidates stripped; promote to reference product]',
    `svlan_number` STRING COMMENT 'Service VLAN (outer VLAN tag) used in QinQ double-tagging for carrier-grade service delivery and wholesale scenarios.',
    `tcont_number` STRING COMMENT 'T-CONT identifier for upstream bandwidth allocation in GPON. Each T-CONT represents a traffic container with specific QoS characteristics.',
    `upstream_bandwidth_mbps` DECIMAL(18,2) COMMENT 'Configured upstream bandwidth limit in megabits per second. Represents the maximum upload speed available to the customer.',
    `upstream_bandwidth_profile` STRING COMMENT 'Name or identifier of the bandwidth profile governing upstream traffic from ONT to OLT. Defines assured, maximum, and fixed bandwidth allocations.',
    `vlan_number` STRING COMMENT 'VLAN identifier assigned to this ONT for traffic segregation and service isolation. Used for multi-service delivery over single fiber.',
    CONSTRAINT pk_ftth_ont_config PRIMARY KEY(`ftth_ont_config_id`)
) COMMENT 'Master record for FTTH/GPON Optical Network Terminal (ONT) configuration assigned to a fiber service instance. Stores OLT node reference, PON port, ONT serial number, GPON T-CONT and GEM port assignments, upstream/downstream bandwidth profiles, VLAN configuration, ONT firmware version, and provisioning state. Represents the logical-to-physical binding between the FTTH service instance and the passive optical network infrastructure. Sourced from Netcracker OSS and OLT EMS.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` (
    `provisioning_fallout_id` BIGINT COMMENT 'Unique identifier for the provisioning fallout record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Provisioning fallout resolution requires employee assignment tracking for workforce accountability, SLA compliance reporting, and performance management. Telecommunications operations mandate clear ow',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise provisioning failures must link to corporate account for SLA breach tracking, escalation to account teams, and contract penalty assessment. Critical for B2B service assurance.',
    `dq_issue_id` BIGINT COMMENT 'Foreign key linking to analytics.dq_issue. Business justification: Provisioning fallouts often stem from data quality issues like invalid configurations, missing reference data, or inconsistent network element information. Required for root cause analysis linking ope',
    `element_id` BIGINT COMMENT 'Identifier of the specific network element (RAN node, OLT, BNG, etc.) involved in the provisioning failure, if applicable.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to location.premise. Business justification: Provisioning failures often have location-specific causes (access restrictions, construction required, premise not passed). Essential for fallout root cause analysis, construction planning, and premis',
    `provisioning_order_id` BIGINT COMMENT 'Reference to the originating provisioning order that encountered the fallout condition. Links to the order orchestration system.',
    `noc_incident_id` BIGINT COMMENT 'Reference to any related incident ticket in ServiceNow ITSM or other incident management system that was opened for this fallout.',
    `problem_record_id` BIGINT COMMENT 'Reference to any problem record created to address systemic issues identified through this fallout event.',
    `svc_instance_id` BIGINT COMMENT 'Reference to the service instance that was being provisioned or modified when the fallout occurred.',
    `assigned_to_team` STRING COMMENT 'Name of the NOC, OSS operations, or engineering team currently responsible for resolving the fallout.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this fallout record was first created in the data platform.',
    `customer_impact` STRING COMMENT 'Assessment of the impact on customer service availability or quality resulting from the provisioning failure.. Valid values are `service_down|service_degraded|activation_delayed|no_customer_impact`',
    `customer_notified_timestamp` TIMESTAMP COMMENT 'Date and time when the customer was notified about the provisioning delay or issue, if applicable.',
    `error_category` STRING COMMENT 'High-level classification of the error type for reporting and trend analysis purposes. [ENUM-REF-CANDIDATE: configuration|connectivity|authentication|resource_unavailable|timeout|data_validation|system_error — 7 candidates stripped; promote to reference product]',
    `error_code` STRING COMMENT 'System-generated error code returned by the failing component, used for diagnostic and pattern analysis.',
    `error_description` STRING COMMENT 'Detailed human-readable description of the error condition, including technical details and context from the source system.',
    `escalation_level` STRING COMMENT 'Current escalation tier of the fallout (0=not escalated, 1=tier 1, 2=tier 2, 3=tier 3), indicating management visibility and urgency.',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when the fallout was escalated to a higher support tier or management level.',
    `external_vendor_involved` BOOLEAN COMMENT 'Indicates whether resolution required involvement of an external vendor or partner (equipment manufacturer, MVNO partner, interconnect carrier).',
    `failed_system_name` STRING COMMENT 'Name of the specific system or network element that generated the failure, such as Oracle OSM, Netcracker OSS, or a specific RAN node identifier.',
    `failure_layer` STRING COMMENT 'The architectural layer where the provisioning failure originated: network element, OSS system, BSS system, integration middleware, or external vendor system.. Valid values are `network_element|oss_system|bss_system|integration_layer|external_vendor`',
    `failure_step` STRING COMMENT 'The specific provisioning workflow step or task where the failure occurred, such as network element configuration, inventory update, or service activation.',
    `fallout_number` STRING COMMENT 'Human-readable business identifier for the fallout event, typically generated by the OSS fallout management module.',
    `fallout_status` STRING COMMENT 'Current lifecycle status of the fallout record in the resolution workflow.. Valid values are `open|in_progress|pending_vendor|resolved|closed|cancelled`',
    `fallout_timestamp` TIMESTAMP COMMENT 'Date and time when the provisioning fallout event was first detected and recorded by the OSS system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this fallout record was last updated, tracking the most recent status or resolution change.',
    `max_retry_reached` BOOLEAN COMMENT 'Indicates whether the fallout occurred because the maximum configured retry threshold was exceeded.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, troubleshooting details, or context that does not fit structured fields.',
    `notification_sent` BOOLEAN COMMENT 'Indicates whether automated notification was sent to relevant stakeholders (customer, operations team, management) about the provisioning delay.',
    `order_type` STRING COMMENT 'The type of provisioning order that encountered the fallout: new service activation, service modification, suspension, termination, or technology migration.. Valid values are `new_activation|modification|suspension|termination|migration`',
    `preventive_action` STRING COMMENT 'Description of any preventive measures or process improvements implemented to avoid recurrence of similar fallout patterns.',
    `resolution_action` STRING COMMENT 'Detailed description of the corrective action taken to resolve the provisioning fallout, including manual interventions, configuration changes, or system fixes.',
    `resolution_category` STRING COMMENT 'Classification of the resolution approach used to clear the fallout condition.. Valid values are `manual_intervention|system_restart|configuration_fix|data_correction|vendor_escalation|cancelled`',
    `resolution_duration_minutes` STRING COMMENT 'Total elapsed time in minutes from fallout detection to resolution, used for MTTR analysis and operational KPIs.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the fallout was successfully resolved and the provisioning order was able to proceed or complete.',
    `retry_count` STRING COMMENT 'Number of automatic retry attempts made by the provisioning system before escalating to fallout status.',
    `root_cause_code` STRING COMMENT 'Standardized code identifying the underlying root cause of the provisioning failure, used for trend analysis and systemic issue identification.',
    `root_cause_description` STRING COMMENT 'Detailed explanation of the root cause analysis findings, documenting why the provisioning failure occurred.',
    `service_type` STRING COMMENT 'Type of service being provisioned when the fallout occurred, such as mobile broadband, voice, IPTV, or enterprise connectivity.',
    `severity_level` STRING COMMENT 'Business impact severity of the provisioning fallout, determining prioritization for NOC and operations teams.. Valid values are `critical|high|medium|low`',
    `sla_breach_risk` BOOLEAN COMMENT 'Indicates whether the provisioning delay poses a risk of breaching committed service activation SLA targets.',
    `technology_type` STRING COMMENT 'The network technology domain where the provisioning failure occurred, such as 5G NR, LTE, FTTH, GPON, IMS, or VoLTE.',
    `vendor_ticket_number` STRING COMMENT 'External ticket or case number opened with a vendor or partner for resolution of the provisioning issue.',
    CONSTRAINT pk_provisioning_fallout PRIMARY KEY(`provisioning_fallout_id`)
) COMMENT 'Transactional record capturing failed or stalled provisioning events during service activation or modification workflows. Records the originating provisioning order, failure step (network element, OSS system, or BSS system), error code, error description, retry count, fallout timestamp, resolution action taken, and resolution timestamp. Used by NOC and OSS operations teams to manage provisioning quality and identify systemic failure patterns. Sourced from Oracle OSM fallout management module.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`service`.`svc_location` (
    `svc_location_id` BIGINT COMMENT 'Unique identifier for the service delivery location. Primary key for the service location entity.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to finance.capital_project. Business justification: Serviceable locations are outcomes of network expansion capex projects (fiber builds, cell site deployments, cabinet installations); linking enables homes-passed tracking, cost-per-location analysis, ',
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
    `svc_instance_id` BIGINT COMMENT 'Reference to the child or dependent service instance in the dependency relationship. For bundle compositions, this is a component service (e.g., broadband, VoIP, or IPTV within triple-play). For technology dependencies, this is the dependent service (e.g., VoLTE service depending on data bearer). For 5G network slices, this is the underlying connectivity service. For wholesale/MVNO scenarios, this is the virtual service layer.',
    `dependency_svc_instance_id` BIGINT COMMENT 'Reference to the parent service instance in the dependency relationship. For bundle compositions, this is the container service (e.g., triple-play bundle). For technology dependencies, this is the prerequisite service (e.g., data bearer for VoLTE). For 5G network slices, this is the slice instance. For wholesale/MVNO scenarios, this is the host carrier service.',
    `offering_id` BIGINT COMMENT 'Reference to the commercial product offering that defines this dependency relationship. Links the runtime dependency instance back to the catalog definition. Used to trace dependencies to their product catalog source and understand which commercial bundles drive which service dependencies.',
    `provisioning_order_id` BIGINT COMMENT 'Reference to the provisioning order that established this service dependency. Used for traceability and audit purposes. Enables linking dependency creation back to the originating order for troubleshooting and compliance reporting.',
    `revenue_recognition_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_recognition. Business justification: Bundled service dependencies (e.g., mobile+broadband, voice+data) require proper revenue allocation across performance obligations per ASC 606/IFRS 15; linking enables standalone selling price allocat',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber who owns or is associated with the service dependency relationship. Denormalized for reporting and analytics. Enables quick identification of all service dependencies for a given subscriber without complex joins.',
    `parent_dependency_id` BIGINT COMMENT 'Self-referencing FK on dependency (parent_dependency_id)',
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

CREATE OR REPLACE TABLE `telecommunication_ecm`.`service`.`service_roaming_session` (
    `service_roaming_session_id` BIGINT COMMENT 'Primary key for service_roaming_session',
    `roaming_agreement_id` BIGINT COMMENT 'Foreign key linking to the roaming agreement under which this session was conducted',
    `customer_roaming_session_id` BIGINT COMMENT 'Unique identifier for this roaming session record. Primary key.',
    `svc_instance_id` BIGINT COMMENT 'Foreign key linking to the service instance that roamed onto the partner network',
    `data_volume_mb` DECIMAL(18,2) COMMENT 'Total data usage in megabytes during this roaming session. Used for wholesale settlement calculation based on agreement data_mb_rate.',
    `fraud_alert_triggered` BOOLEAN COMMENT 'Indicates whether this roaming session triggered fraud detection thresholds defined in the roaming agreement or NRTRDE monitoring.',
    `roaming_country_code` STRING COMMENT 'ISO 3166-1 alpha-2 country code where the roaming session occurred. Used for geographic analysis and regulatory reporting.',
    `session_end_timestamp` TIMESTAMP COMMENT 'Date and time when the service instance detached from the visited partner network and ended the roaming session. Null for active sessions.',
    `session_start_timestamp` TIMESTAMP COMMENT 'Date and time when the service instance attached to the visited partner network and began the roaming session. Used for session duration calculation and TAP file generation.',
    `session_status` STRING COMMENT 'Current lifecycle status of the roaming session: active (ongoing), completed (ended, awaiting settlement), disputed (settlement dispute raised), settled (invoiced and paid).',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Calculated wholesale charge for this roaming session in the agreement currency, based on usage volumes and agreement rates. Used for inter-operator invoicing.',
    `sms_count` STRING COMMENT 'Total number of SMS messages sent during this roaming session. Used for wholesale settlement calculation based on agreement sms_rate.',
    `tap_record_reference` STRING COMMENT 'Reference identifier to the TAP (Transferred Account Procedure) file record generated for this roaming session for inter-operator settlement.',
    `visited_network_code` STRING COMMENT 'Mobile Country Code (MCC) and Mobile Network Code (MNC) of the specific visited network where roaming occurred. May differ from partner_id if partner operates multiple networks.',
    `voice_minutes` DECIMAL(18,2) COMMENT 'Total voice call minutes during this roaming session. Used for wholesale settlement calculation based on agreement voice_mou_rate.',
    CONSTRAINT pk_service_roaming_session PRIMARY KEY(`service_roaming_session_id`)
) COMMENT 'This association product represents the operational roaming event between a service instance and a partner roaming agreement. It captures each discrete roaming session when a subscribers service instance connects to a visited partner network under the terms of a specific roaming agreement. Each record links one service instance to one partner roaming agreement with session-level attributes including data volume, voice minutes, SMS count, session timestamps, visited network details, and TAP record references required for inter-operator settlement and fraud detection.. Existence Justification: In telecommunications operations, a mobile service instance roams across multiple partner networks throughout its lifetime as subscribers travel internationally or domestically. Each roaming agreement covers potentially millions of service instances that may roam onto that partners network. The business actively manages each roaming session as a discrete operational event with session-level usage data (data volume, voice minutes, SMS count), timestamps, visited network identification, and TAP record references required for wholesale inter-operator settlement, fraud detection, and regulatory compliance.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`service`.`ont_service_binding` (
    `ont_service_binding_id` BIGINT COMMENT 'Unique identifier for this ONT-to-service binding record. Primary key.',
    `ont_asset_id` BIGINT COMMENT 'Foreign key linking to the ONT hardware asset providing physical connectivity for this service',
    `service_qos_profile_id` BIGINT COMMENT 'Reference to the QoS profile applied to this specific service-ONT binding. Defines traffic prioritization and bandwidth allocation for this service on this ONT.',
    `svc_instance_id` BIGINT COMMENT 'Foreign key linking to the service instance being delivered through this ONT binding',
    `activation_timestamp` TIMESTAMP COMMENT 'Date and time when this specific service-to-ONT binding was activated in the provisioning system. Tracks when the service was bound to this particular ONT device.',
    `bandwidth_downstream_mbps` DECIMAL(18,2) COMMENT 'Provisioned downstream bandwidth in megabits per second allocated to this service on this ONT. Configured at binding activation time.',
    `bandwidth_upstream_mbps` DECIMAL(18,2) COMMENT 'Provisioned upstream bandwidth in megabits per second allocated to this service on this ONT. Configured at binding activation time.',
    `deactivation_timestamp` TIMESTAMP COMMENT 'Date and time when this service-to-ONT binding was deactivated. Null if binding is currently active. Populated during service migration or ONT replacement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this binding record. Tracks configuration changes, status updates, or parameter adjustments.',
    `ont_port_assignment` STRING COMMENT 'Specific Ethernet port on the ONT device assigned to this service instance. Relevant for multi-service scenarios where different services use different physical ports.',
    `optical_power_rx_dbm` DECIMAL(18,2) COMMENT 'Received optical power level in dBm measured at the time of service-ONT binding activation. Baseline measurement for service assurance and troubleshooting.',
    `optical_power_tx_dbm` DECIMAL(18,2) COMMENT 'Transmitted optical power level in dBm measured at the time of service-ONT binding activation. Baseline measurement for service assurance and troubleshooting.',
    `provisioning_status` STRING COMMENT 'Current provisioning state of this service-ONT binding. Tracks lifecycle: pending (awaiting activation), active (service live), suspended (temporarily disabled), failed (provisioning error), decommissioned (binding terminated).',
    `provisioning_system` STRING COMMENT 'Name of the OSS/provisioning platform that created and manages this binding (Oracle OSM, Netcracker). Tracks system of record for this binding.',
    `vlan_number` STRING COMMENT 'VLAN identifier assigned to this service-ONT binding for traffic segregation and QoS enforcement in the GPON network.',
    `created_by` STRING COMMENT 'User or system identifier that created this service-ONT binding record. Audit trail for provisioning actions.',
    CONSTRAINT pk_ont_service_binding PRIMARY KEY(`ont_service_binding_id`)
) COMMENT 'This association product represents the operational binding between a service instance and an ONT asset in FTTH/GPON networks. It captures the physical-to-logical service mapping including activation timestamps, QoS profiles, bandwidth allocations, and optical power measurements. Each record links one service instance to one ONT asset with attributes that exist only in the context of this provisioning relationship. Supports service migration scenarios (ONT replacement, upgrade) and multi-service scenarios (MDU, business multi-service on single ONT).. Existence Justification: In FTTH operations, service instances can migrate between ONT assets during device replacement, upgrade, or troubleshooting scenarios - one service can be bound to multiple ONTs over its lifetime. Simultaneously, a single ONT asset can host multiple service instances in multi-dwelling unit (MDU) deployments or business scenarios where multiple services (broadband, VoIP, IPTV) are delivered through one ONT. The detection phase identified an existing association table (ftth_ont_config) with rich relationship attributes including activation timestamps, QoS profiles, bandwidth allocations, and optical power measurements, confirming this is an actively managed operational relationship.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`service`.`visit` (
    `visit_id` BIGINT COMMENT 'Unique identifier for this service visit record. Primary key.',
    `svc_instance_id` BIGINT COMMENT 'Foreign key linking to the service instance that was serviced during this visit',
    `technician_id` BIGINT COMMENT 'Foreign key linking to the technician who performed this service visit',
    `work_order_id` BIGINT COMMENT 'Reference to the work order that authorized this service visit. Links to workforce management system dispatch records.',
    `actual_arrival_time` TIMESTAMP COMMENT 'Actual time technician arrived on site. Used to calculate SLA adherence and response time metrics.',
    `actual_completion_time` TIMESTAMP COMMENT 'Actual time technician completed work and departed. Used to calculate mean time to repair (MTTR).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service visit record was created in the system.',
    `customer_present_flag` BOOLEAN COMMENT 'Indicates whether customer or authorized representative was present during the visit. Required for certain work types.',
    `customer_satisfaction_rating` DECIMAL(18,2) COMMENT 'Post-visit customer satisfaction score (0-100 scale) collected via SMS survey or app feedback. Feeds into technician performance evaluation and service quality metrics. Identified in detection phase.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether additional visits are needed to complete the work. Drives dispatch scheduling.',
    `labor_hours` DECIMAL(18,2) COMMENT 'Total labor hours spent by the technician on this service visit. Used for workforce productivity analysis and cost allocation. Identified in detection phase.',
    `notes` STRING COMMENT 'Additional technician notes, observations, or recommendations captured during the visit.',
    `outcome` STRING COMMENT 'Result status of the service visit: completed (work finished successfully), partial (work incomplete, follow-up needed), escalated (requires specialist), cancelled (customer unavailable), or rescheduled. Drives first-time fix rate KPI. Identified in detection phase.',
    `parts_used_flag` BOOLEAN COMMENT 'Indicates whether inventory parts were consumed during this visit. Triggers inventory replenishment workflows.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Scheduled appointment start time communicated to customer. Used for SLA compliance tracking.',
    `sla_met_flag` BOOLEAN COMMENT 'Indicates whether this visit met the committed SLA timeframe. Feeds into technician and service performance dashboards.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this service visit record was last updated.',
    `visit_date` DATE COMMENT 'Date when the service visit occurred. Corresponds to service_visit_date from detection phase.',
    `visit_type` STRING COMMENT 'Classification of the service visit purpose: installation (new service activation), maintenance (preventive), repair (reactive fault resolution), upgrade (service enhancement), troubleshooting (diagnostic), or decommission (service termination). Identified in detection phase.',
    `work_performed_description` STRING COMMENT 'Free-text description of the work performed during this visit. Captured by technician in field service app. Identified in detection phase.',
    CONSTRAINT pk_visit PRIMARY KEY(`visit_id`)
) COMMENT 'This association product represents the field service event between a service instance and a technician. It captures every installation, maintenance, repair, upgrade, or troubleshooting visit performed by workforce personnel on a customer service instance. Each record links one service instance to one technician for a specific visit, tracking labor hours, work performed, visit outcome, and customer feedback. Central to workforce management, service assurance, and operational analytics.. Existence Justification: In telecommunications operations, service instances require multiple technician visits throughout their lifecycle (installation at activation, maintenance visits, repair visits for faults, upgrade visits for service enhancements, and decommissioning). Each technician performs work on many different service instances across their service territory. The business actively manages these service visits as operational events with specific data: visit date, visit type, labor hours, work performed, outcome status, and customer satisfaction ratings.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`service`.`contract_service_line` (
    `contract_service_line_id` BIGINT COMMENT 'Unique identifier for this contract service line record. Primary key.',
    `amendment_id` BIGINT COMMENT 'Reference to the contract amendment that created or modified this service line. Null for original contract lines. Links to amendment tracking in sales_contract or separate amendment table. Enables amendment impact analysis.',
    `sales_contract_id` BIGINT COMMENT 'Foreign key linking to the sales contract that governs this service instance',
    `svc_instance_id` BIGINT COMMENT 'Foreign key linking to the service instance covered by this contract line',
    `billing_end_date` DATE COMMENT 'Date when billing ended or is scheduled to end for this service under this contract. Null for active ongoing services. Populated when service is terminated, migrated to another contract, or contract expires.',
    `billing_start_date` DATE COMMENT 'Date when billing commenced for this service under this contract. May differ from service_activation_date due to promotional periods, billing alignment, or contract-specific terms. Used by billing systems to determine charge periods.',
    `contract_line_number` STRING COMMENT 'Business identifier for this line item within the contract. Used in contract documents and invoices to reference specific services. Format typically CONTRACT_NUMBER-LINE_SEQ (e.g., CNT-2024-12345-001).',
    `contract_term_months` STRING COMMENT 'Contract commitment term in months for this specific service instance. May differ from the master contract term if services were added mid-term or have different commitment periods. Used for ETF calculations and renewal scheduling.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this contract service line record was created. Used for audit trail and data lineage.',
    `effective_end_date` DATE COMMENT 'Date when this contract line expires or was terminated. Null for active lines. Used for contract term tracking and renewal forecasting.',
    `effective_start_date` DATE COMMENT 'Date when this contract line became effective. For original contract lines, matches contract effective_start_date. For services added via amendment, reflects the amendment effective date. Supports temporal contract queries.',
    `line_status` STRING COMMENT 'Administrative status of this contract line item. Tracks the commercial/contractual state: active (line in force), suspended (temporarily paused), cancelled (terminated before term end), completed (term ended normally), amended (superseded by amendment). Used for contract compliance and reporting.',
    `mrr_amount` DECIMAL(18,2) COMMENT 'Monthly Recurring Revenue allocated to this specific service instance under this contract. Enables MRR rollup to contract level and revenue allocation for multi-service contracts. Critical for revenue recognition and sales compensation.',
    `service_activation_date` DATE COMMENT 'Date when this service instance was activated under this specific contract. May differ from the service instances original activation_timestamp if the service was migrated from another contract or reactivated. Used for contract term calculations and billing start date determination.',
    `service_status` STRING COMMENT 'Status of this service instance within the context of this contract. Tracks contract-specific lifecycle: active (service operational under contract), suspended (service paused but contract binding remains), pending_activation (contract signed but service not yet provisioned), terminated (service ended under this contract), migrated (service moved to different contract). Distinct from the service instances technical lifecycle_status.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this contract service line record was last modified. Used for change tracking and data synchronization.',
    CONSTRAINT pk_contract_service_line PRIMARY KEY(`contract_service_line_id`)
) COMMENT 'This association product represents the commercial contract coverage for individual service instances. It captures which sales contract governs each service instance, the contract-specific terms (MRR allocation, activation date, term), and the lifecycle of service-contract binding. Each record links one service instance to one sales contract, enabling enterprise scenarios where multiple services are bundled under one contract, and service lifecycle scenarios where a service migrates across contracts (initial sale, renewal, amendment, migration). This is the operational record used for contract compliance, revenue allocation, and service entitlement verification.. Existence Justification: In telecommunications, enterprise sales contracts typically bundle multiple service instances (multiple lines, devices, locations) under a single commercial agreement, and service instances can migrate across contracts during their lifetime (initial contract, renewals, amendments, plan changes, account migrations). The relationship between service instances and sales contracts is operationally managed as contract service lines, with each line tracking contract-specific terms (MRR allocation, activation date, term, billing dates) that exist only in the context of that specific service-contract binding.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_parent_service_instance_svc_instance_id` FOREIGN KEY (`parent_service_instance_svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ADD CONSTRAINT `fk_service_svc_instance_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `telecommunication_ecm`.`service`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ADD CONSTRAINT `fk_service_provisioning_order_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_provisioning_order_id` FOREIGN KEY (`provisioning_order_id`) REFERENCES `telecommunication_ecm`.`service`.`provisioning_order`(`provisioning_order_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ADD CONSTRAINT `fk_service_activation_event_svc_location_id` FOREIGN KEY (`svc_location_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_location`(`svc_location_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ADD CONSTRAINT `fk_service_svc_configuration_provisioning_order_id` FOREIGN KEY (`provisioning_order_id`) REFERENCES `telecommunication_ecm`.`service`.`provisioning_order`(`provisioning_order_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ADD CONSTRAINT `fk_service_svc_configuration_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ADD CONSTRAINT `fk_service_volte_ims_state_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ADD CONSTRAINT `fk_service_esim_profile_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ADD CONSTRAINT `fk_service_svc_status_history_provisioning_order_id` FOREIGN KEY (`provisioning_order_id`) REFERENCES `telecommunication_ecm`.`service`.`provisioning_order`(`provisioning_order_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ADD CONSTRAINT `fk_service_svc_status_history_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ADD CONSTRAINT `fk_service_number_assignment_esim_profile_id` FOREIGN KEY (`esim_profile_id`) REFERENCES `telecommunication_ecm`.`service`.`esim_profile`(`esim_profile_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ADD CONSTRAINT `fk_service_number_assignment_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ADD CONSTRAINT `fk_service_svc_suspension_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ADD CONSTRAINT `fk_service_service_mnp_request_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ADD CONSTRAINT `fk_service_ftth_ont_config_provisioning_order_id` FOREIGN KEY (`provisioning_order_id`) REFERENCES `telecommunication_ecm`.`service`.`provisioning_order`(`provisioning_order_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ADD CONSTRAINT `fk_service_ftth_ont_config_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `telecommunication_ecm`.`service`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ADD CONSTRAINT `fk_service_ftth_ont_config_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ADD CONSTRAINT `fk_service_provisioning_fallout_provisioning_order_id` FOREIGN KEY (`provisioning_order_id`) REFERENCES `telecommunication_ecm`.`service`.`provisioning_order`(`provisioning_order_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ADD CONSTRAINT `fk_service_provisioning_fallout_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ADD CONSTRAINT `fk_service_dependency_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ADD CONSTRAINT `fk_service_dependency_dependency_svc_instance_id` FOREIGN KEY (`dependency_svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ADD CONSTRAINT `fk_service_dependency_provisioning_order_id` FOREIGN KEY (`provisioning_order_id`) REFERENCES `telecommunication_ecm`.`service`.`provisioning_order`(`provisioning_order_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ADD CONSTRAINT `fk_service_dependency_parent_dependency_id` FOREIGN KEY (`parent_dependency_id`) REFERENCES `telecommunication_ecm`.`service`.`dependency`(`dependency_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`service_roaming_session` ADD CONSTRAINT `fk_service_service_roaming_session_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`ont_service_binding` ADD CONSTRAINT `fk_service_ont_service_binding_service_qos_profile_id` FOREIGN KEY (`service_qos_profile_id`) REFERENCES `telecommunication_ecm`.`service`.`service_qos_profile`(`service_qos_profile_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`ont_service_binding` ADD CONSTRAINT `fk_service_ont_service_binding_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`visit` ADD CONSTRAINT `fk_service_visit_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);
ALTER TABLE `telecommunication_ecm`.`service`.`contract_service_line` ADD CONSTRAINT `fk_service_contract_service_line_svc_instance_id` FOREIGN KEY (`svc_instance_id`) REFERENCES `telecommunication_ecm`.`service`.`svc_instance`(`svc_instance_id`);

-- ========= TAGS =========
ALTER SCHEMA `telecommunication_ecm`.`service` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `telecommunication_ecm`.`service` SET TAGS ('dbx_domain' = 'service');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` SET TAGS ('dbx_subdomain' = 'service_management');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `cpni_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Cpni Authorization Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `e911_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'E911 Compliance Record Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `enterprise_site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `lawful_intercept_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lawful Intercept Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `mvno_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Mvno Profile Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `network_qos_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Profile Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `parent_service_instance_svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Service Instance Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Product Offering Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `segment_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `sla_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Profile Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Visited Carrier Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Activation Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `apn` SET TAGS ('dbx_business_glossary_term' = 'Access Point Name (APN)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `auto_renew` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `bandwidth_mbps` SET TAGS ('dbx_business_glossary_term' = 'Bandwidth Megabits Per Second (Mbps)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `billing_cycle_day` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Day of Month');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `cpe_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Premises Equipment (CPE) Serial Number');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `cpe_serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `cpe_serial_number` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `data_allowance_gb` SET TAGS ('dbx_business_glossary_term' = 'Data Allowance Gigabytes (GB)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `deactivation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Deactivation Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `esim_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Embedded SIM (eSIM) Profile Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `esim_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `esim_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
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
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `provisioning_order_id` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Order Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `provisioning_system` SET TAGS ('dbx_business_glossary_term' = 'Provisioning System Source');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `roaming_enabled` SET TAGS ('dbx_business_glossary_term' = 'Roaming Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `service_class` SET TAGS ('dbx_business_glossary_term' = 'Service Class Segment');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `service_class` SET TAGS ('dbx_value_regex' = 'consumer|enterprise|wholesale|iot|government');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `service_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `service_identifier` SET TAGS ('dbx_business_glossary_term' = 'Service Business Identifier');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type Classification');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_instance` ALTER COLUMN `slice_id` SET TAGS ('dbx_business_glossary_term' = '5G Network Slice Identifier (ID)');
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
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `dealer_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `enterprise_site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial Order Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `location_address_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Address Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `location_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `location_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Carrier Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
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
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum|enterprise');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `target_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Service Test Result');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_order` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'passed|failed|not_applicable|pending');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` SET TAGS ('dbx_subdomain' = 'provisioning_operations');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `activation_event_id` SET TAGS ('dbx_business_glossary_term' = 'Activation Event Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Activation Technician Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `dealer_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `enterprise_site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Cpe Asset Serial Number (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Network Element Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `provisioning_order_id` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Order Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `ran_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Ran Cell Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `svc_location_id` SET TAGS ('dbx_business_glossary_term' = 'Service Location Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `trouble_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Trouble Ticket Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Visited Carrier Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `activation_channel` SET TAGS ('dbx_business_glossary_term' = 'Activation Channel');
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
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `esim_profile_iccid` SET TAGS ('dbx_business_glossary_term' = 'Embedded Subscriber Identity Module (eSIM) Profile Integrated Circuit Card Identifier (ICCID)');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `esim_profile_iccid` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`activation_event` ALTER COLUMN `esim_profile_iccid` SET TAGS ('dbx_pii_identifier' = 'true');
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
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `svc_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Service Configuration ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `device_model_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Premises Equipment (CPE) Device ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `dq_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Dq Rule Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Network Element Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `provisioning_order_id` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Order ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `trouble_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Trouble Ticket Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `esim_eid` SET TAGS ('dbx_business_glossary_term' = 'eSIM Identifier (EID)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `esim_eid` SET TAGS ('dbx_value_regex' = '^[0-9]{32}$');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `esim_eid` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `esim_eid` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `esim_iccid` SET TAGS ('dbx_business_glossary_term' = 'eSIM Integrated Circuit Card Identifier (ICCID)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `esim_iccid` SET TAGS ('dbx_value_regex' = '^[0-9]{19,20}$');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `esim_iccid` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `esim_iccid` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `esim_profile_state` SET TAGS ('dbx_business_glossary_term' = 'Embedded SIM (eSIM) Profile State');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `esim_profile_state` SET TAGS ('dbx_value_regex' = 'not_provisioned|downloaded|installed|enabled|disabled|deleted');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `esim_smdp_plus_address` SET TAGS ('dbx_business_glossary_term' = 'eSIM Subscription Manager Data Preparation Plus (SM-DP+) Address');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `esim_smdp_plus_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `esim_smdp_plus_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Configuration Expiry Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `ftth_gem_port_number` SET TAGS ('dbx_business_glossary_term' = 'FTTH GPON Encapsulation Method (GEM) Port ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `ftth_olt_identifier` SET TAGS ('dbx_business_glossary_term' = 'FTTH Optical Line Terminal (OLT) Identifier');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `ftth_ont_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Fiber to the Home (FTTH) Optical Network Terminal (ONT) Serial Number');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `ftth_ont_serial_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `ftth_ont_serial_number` SET TAGS ('dbx_pii_device' = 'true');
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
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `sla_class` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Class');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `sla_class` SET TAGS ('dbx_value_regex' = 'gold|silver|bronze|standard|premium|enterprise');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `sla_target_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Latency (Milliseconds)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `sla_target_uptime_percent` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Uptime Percentage');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `volte_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Voice over LTE (VoLTE) Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_configuration` ALTER COLUMN `vowifi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Voice over WiFi (VoWiFi) Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `sla_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Profile Identifier');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`sla_profile` ALTER COLUMN `sla_template_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Template Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `service_qos_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Service Quality of Service (QoS) Profile Identifier');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `slice_id` SET TAGS ('dbx_business_glossary_term' = 'Network Slice Identifier');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `aggregate_maximum_bit_rate_downlink_kbps` SET TAGS ('dbx_business_glossary_term' = 'Aggregate Maximum Bit Rate (AMBR) Downlink in Kilobits per Second');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `aggregate_maximum_bit_rate_uplink_kbps` SET TAGS ('dbx_business_glossary_term' = 'Aggregate Maximum Bit Rate (AMBR) Uplink in Kilobits per Second');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `application_category` SET TAGS ('dbx_business_glossary_term' = 'Application Category');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `arp_priority_level` SET TAGS ('dbx_business_glossary_term' = 'Allocation and Retention Priority (ARP) Level');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `charging_rule_name` SET TAGS ('dbx_business_glossary_term' = 'Charging Rule Name');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `congestion_handling_policy` SET TAGS ('dbx_business_glossary_term' = 'Congestion Handling Policy');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `congestion_handling_policy` SET TAGS ('dbx_value_regex' = 'drop|throttle|queue|prioritize');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `cos_marking` SET TAGS ('dbx_business_glossary_term' = 'Class of Service (CoS) Marking');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `dpi_policy_class` SET TAGS ('dbx_business_glossary_term' = 'Deep Packet Inspection (DPI) Policy Class');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `dscp_marking` SET TAGS ('dbx_business_glossary_term' = 'Differentiated Services Code Point (DSCP) Marking');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `five_qi_value` SET TAGS ('dbx_business_glossary_term' = '5G QoS Identifier (5QI) Value');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `guaranteed_bit_rate_downlink_kbps` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Bit Rate (GBR) Downlink in Kilobits per Second');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `guaranteed_bit_rate_uplink_kbps` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Bit Rate (GBR) Uplink in Kilobits per Second');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `maximum_bit_rate_downlink_kbps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Bit Rate (MBR) Downlink in Kilobits per Second');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `maximum_bit_rate_uplink_kbps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Bit Rate (MBR) Uplink in Kilobits per Second');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `packet_delay_budget_ms` SET TAGS ('dbx_business_glossary_term' = 'Packet Delay Budget in Milliseconds');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `packet_error_rate` SET TAGS ('dbx_business_glossary_term' = 'Packet Error Rate');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `pcf_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Policy Control Function (PCF) Policy Identifier');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `pcrf_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Policy and Charging Rules Function (PCRF) Policy Identifier');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `preemption_capability` SET TAGS ('dbx_business_glossary_term' = 'Preemption Capability');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `preemption_capability` SET TAGS ('dbx_value_regex' = 'enabled|disabled');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `preemption_vulnerability` SET TAGS ('dbx_business_glossary_term' = 'Preemption Vulnerability');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `preemption_vulnerability` SET TAGS ('dbx_value_regex' = 'enabled|disabled');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_business_glossary_term' = 'QoS Profile Code');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_business_glossary_term' = 'QoS Profile Name');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `profile_type` SET TAGS ('dbx_business_glossary_term' = 'QoS Profile Type');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `profile_type` SET TAGS ('dbx_value_regex' = 'voice|data|video|iot|converged|emergency');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `qci_value` SET TAGS ('dbx_business_glossary_term' = 'QoS Class Identifier (QCI) Value');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `resource_type` SET TAGS ('dbx_business_glossary_term' = 'Resource Type');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `resource_type` SET TAGS ('dbx_value_regex' = 'gbr|non_gbr|delay_critical_gbr');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `service_qos_profile_description` SET TAGS ('dbx_business_glossary_term' = 'QoS Profile Description');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `service_qos_profile_status` SET TAGS ('dbx_business_glossary_term' = 'QoS Profile Status');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `service_qos_profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|testing');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`service`.`service_qos_profile` ALTER COLUMN `traffic_shaping_rule` SET TAGS ('dbx_business_glossary_term' = 'Traffic Shaping Rule');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `volte_ims_state_id` SET TAGS ('dbx_business_glossary_term' = 'VoLTE (Voice over Long-Term Evolution) IMS (IP Multimedia Subsystem) State ID');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `ims_node_id` SET TAGS ('dbx_business_glossary_term' = 'Ims Node Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `lawful_intercept_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lawful Intercept Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `network_analytics_kpi_id` SET TAGS ('dbx_business_glossary_term' = 'Network Analytics Kpi Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `network_qos_profile_id` SET TAGS ('dbx_business_glossary_term' = 'QoS (Quality of Service) Profile ID');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance ID');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Visited Carrier Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `barring_status` SET TAGS ('dbx_business_glossary_term' = 'Call Barring Status');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `barring_status` SET TAGS ('dbx_value_regex' = 'none|outgoing_barred|incoming_barred|all_barred|international_barred|roaming_barred');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `call_forwarding_status` SET TAGS ('dbx_business_glossary_term' = 'Call Forwarding Status');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `call_forwarding_status` SET TAGS ('dbx_value_regex' = 'disabled|unconditional|busy|no_answer|not_reachable');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `call_waiting_enabled` SET TAGS ('dbx_business_glossary_term' = 'Call Waiting Enabled');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `caller_id_presentation` SET TAGS ('dbx_business_glossary_term' = 'Caller ID Presentation');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `caller_id_presentation` SET TAGS ('dbx_value_regex' = 'allowed|restricted|not_available|network_default');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `charging_function_address` SET TAGS ('dbx_business_glossary_term' = 'Charging Function Address');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `charging_function_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `charging_function_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `codec_preference` SET TAGS ('dbx_business_glossary_term' = 'Voice Codec Preference');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `deregistration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'IMS Deregistration Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `emergency_call_capability` SET TAGS ('dbx_business_glossary_term' = 'Emergency Call Capability');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `emergency_location_info` SET TAGS ('dbx_business_glossary_term' = 'Emergency Location Information');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `emergency_location_info` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `esrvcc_capability` SET TAGS ('dbx_business_glossary_term' = 'eSRVCC (Enhanced Single Radio Voice Call Continuity) Capability');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `hd_voice_enabled` SET TAGS ('dbx_business_glossary_term' = 'HD (High Definition) Voice Enabled');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `hss_address` SET TAGS ('dbx_business_glossary_term' = 'HSS (Home Subscriber Server) Address');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `hss_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `hss_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `impi` SET TAGS ('dbx_business_glossary_term' = 'IMPI (IP Multimedia Private Identity)');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `impi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `impi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `impu` SET TAGS ('dbx_business_glossary_term' = 'IMPU (IP Multimedia Public Identity)');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `impu` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `impu` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `ims_registration_status` SET TAGS ('dbx_business_glossary_term' = 'IMS (IP Multimedia Subsystem) Registration Status');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `ims_registration_status` SET TAGS ('dbx_value_regex' = 'registered|unregistered|authentication_pending|registration_failed|deregistered|expired');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `imsi` SET TAGS ('dbx_business_glossary_term' = 'IMSI (International Mobile Subscriber Identity)');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `imsi` SET TAGS ('dbx_value_regex' = '^[0-9]{15}$');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `imsi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `imsi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `last_call_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last VoLTE Call Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `last_location_update` SET TAGS ('dbx_business_glossary_term' = 'Last Location Update Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `last_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Synchronization Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `msisdn` SET TAGS ('dbx_business_glossary_term' = 'MSISDN (Mobile Station International Subscriber Directory Number)');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `msisdn` SET TAGS ('dbx_value_regex' = '^[0-9]{10,15}$');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `msisdn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `msisdn` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `network_assigned_uri` SET TAGS ('dbx_business_glossary_term' = 'Network Assigned URI (Uniform Resource Identifier)');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `provisioning_system` SET TAGS ('dbx_business_glossary_term' = 'Provisioning System Source');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `rcs_enabled` SET TAGS ('dbx_business_glossary_term' = 'RCS (Rich Communication Services) Enabled');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `registration_expiry_time` SET TAGS ('dbx_business_glossary_term' = 'Registration Expiry Time');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `registration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'IMS Registration Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `roaming_status` SET TAGS ('dbx_business_glossary_term' = 'Roaming Status');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `roaming_status` SET TAGS ('dbx_value_regex' = 'home|domestic_roaming|international_roaming|not_roaming');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `service_activation_date` SET TAGS ('dbx_business_glossary_term' = 'VoLTE Service Activation Date');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'VoLTE Service Status');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `service_status` SET TAGS ('dbx_value_regex' = 'active|suspended|deactivated|provisioning|pending_activation|barred');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Tier');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|basic|enterprise|wholesale');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `ue_capability_version` SET TAGS ('dbx_business_glossary_term' = 'UE (User Equipment) Capability Version');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `video_calling_enabled` SET TAGS ('dbx_business_glossary_term' = 'Video Calling Enabled');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `visited_network_code` SET TAGS ('dbx_business_glossary_term' = 'Visited Network ID');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `volte_capability_flag` SET TAGS ('dbx_business_glossary_term' = 'VoLTE (Voice over Long-Term Evolution) Capability Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `vowifi_status` SET TAGS ('dbx_business_glossary_term' = 'VoWiFi (Voice over Wi-Fi) Status');
ALTER TABLE `telecommunication_ecm`.`service`.`volte_ims_state` ALTER COLUMN `vowifi_status` SET TAGS ('dbx_value_regex' = 'enabled|disabled|not_provisioned|active|inactive');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `esim_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Service eSIM (Embedded Subscriber Identity Module) Profile ID');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `device_model_id` SET TAGS ('dbx_business_glossary_term' = 'Device Model Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `network_analytics_kpi_id` SET TAGS ('dbx_business_glossary_term' = 'Network Analytics Kpi Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `network_qos_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Profile ID');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Carrier Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `privacy_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `sim_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Sim Stock Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance ID');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `activation_code` SET TAGS ('dbx_business_glossary_term' = 'eSIM Profile Activation Code');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `activation_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `confirmation_code` SET TAGS ('dbx_business_glossary_term' = 'eSIM Profile Confirmation Code');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `confirmation_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `deleted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'eSIM Profile Deleted Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `device_imei` SET TAGS ('dbx_business_glossary_term' = 'International Mobile Equipment Identity (IMEI)');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `device_imei` SET TAGS ('dbx_value_regex' = '^[0-9]{15}$');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `device_imei` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `device_imei` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `device_model` SET TAGS ('dbx_business_glossary_term' = 'Device Model');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `disabled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'eSIM Profile Disabled Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `download_timestamp` SET TAGS ('dbx_business_glossary_term' = 'eSIM Profile Download Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `eid` SET TAGS ('dbx_business_glossary_term' = 'eUICC (Embedded Universal Integrated Circuit Card) Identifier (EID)');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `eid` SET TAGS ('dbx_value_regex' = '^[0-9]{32}$');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `eid` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `eid` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `enabled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'eSIM Profile Enabled Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `euicc_firmware_version` SET TAGS ('dbx_business_glossary_term' = 'eUICC (Embedded Universal Integrated Circuit Card) Firmware Version');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'eSIM Profile Expiry Date');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `imsi` SET TAGS ('dbx_business_glossary_term' = 'International Mobile Subscriber Identity (IMSI)');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `imsi` SET TAGS ('dbx_value_regex' = '^[0-9]{14,15}$');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `imsi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `imsi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `installation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'eSIM Profile Installation Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `is_mnp_eligible` SET TAGS ('dbx_business_glossary_term' = 'Mobile Number Portability (MNP) Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `is_multi_profile_enabled` SET TAGS ('dbx_business_glossary_term' = 'Multi-Profile Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `is_roaming_enabled` SET TAGS ('dbx_business_glossary_term' = 'Roaming Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `last_location_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Location Update Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `last_network_attach_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Network Attach Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `lpa_version` SET TAGS ('dbx_business_glossary_term' = 'Local Profile Assistant (LPA) Version');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `matching_code` SET TAGS ('dbx_business_glossary_term' = 'eSIM Profile Matching ID');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `matching_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `mcc` SET TAGS ('dbx_business_glossary_term' = 'Mobile Country Code (MCC)');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `mcc` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `mnc` SET TAGS ('dbx_business_glossary_term' = 'Mobile Network Code (MNC)');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `mnc` SET TAGS ('dbx_value_regex' = '^[0-9]{2,3}$');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `msisdn` SET TAGS ('dbx_business_glossary_term' = 'Mobile Station International Subscriber Directory Number (MSISDN)');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `msisdn` SET TAGS ('dbx_value_regex' = '^+?[1-9][0-9]{7,14}$');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `msisdn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `msisdn` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `operator_name` SET TAGS ('dbx_business_glossary_term' = 'Mobile Network Operator Name');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `profile_class` SET TAGS ('dbx_business_glossary_term' = 'eSIM Profile Class');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `profile_class` SET TAGS ('dbx_value_regex' = 'consumer|m2m|iot');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `profile_nickname` SET TAGS ('dbx_business_glossary_term' = 'eSIM Profile Nickname');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `profile_size_kb` SET TAGS ('dbx_business_glossary_term' = 'eSIM Profile Size in Kilobytes (KB)');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `profile_state` SET TAGS ('dbx_business_glossary_term' = 'eSIM Profile State');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `profile_type` SET TAGS ('dbx_business_glossary_term' = 'eSIM Profile Type');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `profile_type` SET TAGS ('dbx_value_regex' = 'operational|test|bootstrap|provisioning');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `profile_version` SET TAGS ('dbx_business_glossary_term' = 'eSIM Profile Version');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `provisioned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'eSIM Profile Provisioned Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|basic');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `smdp_address` SET TAGS ('dbx_business_glossary_term' = 'SM-DP+ (Subscription Manager Data Preparation Plus) Server Address');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `smdp_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `smdp_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `smds_address` SET TAGS ('dbx_business_glossary_term' = 'SM-DS (Subscription Manager Discovery Service) Server Address');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `smds_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `smds_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`service`.`esim_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` SET TAGS ('dbx_subdomain' = 'service_management');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `svc_status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Service Status History ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `customer_analytics_kpi_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Analytics Kpi Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiating Actor ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `provisioning_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `trouble_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Trouble Ticket ID');
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
ALTER TABLE `telecommunication_ecm`.`service`.`svc_status_history` ALTER COLUMN `initiating_actor_name` SET TAGS ('dbx_business_glossary_term' = 'Initiating Actor Name');
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
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` SET TAGS ('dbx_subdomain' = 'service_management');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `number_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Number Assignment Identifier');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `esim_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Embedded SIM (eSIM) Profile Identifier');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `lawful_intercept_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lawful Intercept Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `mnp_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Mnp Transaction Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_business_glossary_term' = 'Number Range Identifier');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `mvno_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Mvno Profile Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier');
ALTER TABLE `telecommunication_ecm`.`service`.`number_assignment` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance Identifier');
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
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` SET TAGS ('dbx_subdomain' = 'service_management');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `svc_suspension_id` SET TAGS ('dbx_business_glossary_term' = 'Service Suspension ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `dunning_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dunning Event ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiated By User ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `dealer_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Dealer Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance ID');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_suspension` ALTER COLUMN `trouble_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Trouble Ticket Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` SET TAGS ('dbx_subdomain' = 'service_management');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `service_mnp_request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Mobile Number Portability (MNP) Request ID');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `mnp_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnect Mnp Transaction Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By User ID');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance ID');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `actual_port_completion_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Port Completion Date and Time');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `actual_processing_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Processing Hours');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `authorization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `authorization_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `balance_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Balance Currency Code');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `balance_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `clearinghouse_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Clearinghouse Transaction ID');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `donor_operator_code` SET TAGS ('dbx_business_glossary_term' = 'Donor Operator Code');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `donor_operator_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `donor_response_code` SET TAGS ('dbx_business_glossary_term' = 'Donor Response Code');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `donor_response_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `early_termination_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Fee Amount');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `early_termination_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `early_termination_fee_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `early_termination_fee_applicable` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Fee Applicable');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `iccid` SET TAGS ('dbx_business_glossary_term' = 'Integrated Circuit Card Identifier (ICCID)');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `iccid` SET TAGS ('dbx_value_regex' = '^[0-9]{19,20}$');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `iccid` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `iccid` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `imsi` SET TAGS ('dbx_business_glossary_term' = 'International Mobile Subscriber Identity (IMSI)');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `imsi` SET TAGS ('dbx_value_regex' = '^[0-9]{14,15}$');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `imsi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `imsi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `mnp_request_number` SET TAGS ('dbx_business_glossary_term' = 'Mobile Number Portability (MNP) Request Number');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `mnp_request_number` SET TAGS ('dbx_value_regex' = '^MNP[0-9]{10,15}$');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `msisdn` SET TAGS ('dbx_business_glossary_term' = 'Mobile Station International Subscriber Directory Number (MSISDN)');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `msisdn` SET TAGS ('dbx_value_regex' = '^[0-9]{10,15}$');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `msisdn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `msisdn` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `network_technology` SET TAGS ('dbx_business_glossary_term' = 'Network Technology');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `network_technology` SET TAGS ('dbx_value_regex' = '2G|3G|4G|5G|LTE|VoLTE');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `outstanding_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance Amount');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `outstanding_balance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `outstanding_balance_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `porting_direction` SET TAGS ('dbx_business_glossary_term' = 'Porting Direction');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `porting_direction` SET TAGS ('dbx_value_regex' = 'port_in|port_out');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `porting_status` SET TAGS ('dbx_business_glossary_term' = 'Porting Status');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `processing_priority` SET TAGS ('dbx_business_glossary_term' = 'Processing Priority');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `processing_priority` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `recipient_acknowledgement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recipient Acknowledgement Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `recipient_operator_code` SET TAGS ('dbx_business_glossary_term' = 'Recipient Operator Code');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `recipient_operator_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `recipient_operator_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Operator Name');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `recipient_operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `recipient_operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `rejection_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Request Type');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'standard|expedited|emergency');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `requested_port_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Port Date');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `scheduled_port_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Port Date and Time');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'prepaid|postpaid|hybrid');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `sim_type` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identity Module (SIM) Type');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `sim_type` SET TAGS ('dbx_value_regex' = 'physical_sim|esim');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `sla_target_completion_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Completion Hours');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `submission_channel` SET TAGS ('dbx_business_glossary_term' = 'Submission Channel');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `submission_channel` SET TAGS ('dbx_value_regex' = 'web_portal|mobile_app|call_center|retail_store|api|partner_portal');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `subscriber_address` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Address');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `subscriber_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `subscriber_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed');
ALTER TABLE `telecommunication_ecm`.`service`.`service_mnp_request` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` SET TAGS ('dbx_subdomain' = 'provisioning_operations');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `ftth_ont_config_id` SET TAGS ('dbx_business_glossary_term' = 'Fiber to the Home (FTTH) Optical Network Terminal (ONT) Configuration ID');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `enterprise_site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Installed By Technician ID');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `network_qos_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Profile ID');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `olt_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Optical Line Terminal (OLT) Node ID');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Olt Network Element Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `ont_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ont Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `device_model_id` SET TAGS ('dbx_business_glossary_term' = 'Ont Device Model Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `ont_ont_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Optical Network Terminal (ONT) ID');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `provisioning_order_id` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Order ID');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `sla_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Profile ID');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance ID');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `trouble_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Trouble Ticket Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activation Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `auto_discovery_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto Discovery Enabled');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `configuration_notes` SET TAGS ('dbx_business_glossary_term' = 'Configuration Notes');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `cvlan_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Virtual Local Area Network (C-VLAN) ID');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `deactivation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `downstream_bandwidth_mbps` SET TAGS ('dbx_business_glossary_term' = 'Downstream Bandwidth Megabits per Second (Mbps)');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `downstream_bandwidth_profile` SET TAGS ('dbx_business_glossary_term' = 'Downstream Bandwidth Profile');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `encryption_enabled` SET TAGS ('dbx_business_glossary_term' = 'Encryption Enabled');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `fiber_distance_meters` SET TAGS ('dbx_business_glossary_term' = 'Fiber Distance Meters');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `gem_port_number` SET TAGS ('dbx_business_glossary_term' = 'GPON Encapsulation Method (GEM) Port ID');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `ipv6_enabled` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol Version 6 (IPv6) Enabled');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `last_online_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Online Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `managed_in_system` SET TAGS ('dbx_business_glossary_term' = 'Managed In System');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `managed_in_system` SET TAGS ('dbx_value_regex' = 'Netcracker OSS|Ericsson Network Manager|Nokia NetAct|Manual');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `multicast_enabled` SET TAGS ('dbx_business_glossary_term' = 'Multicast Enabled');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `olt_chassis_slot` SET TAGS ('dbx_business_glossary_term' = 'Optical Line Terminal (OLT) Chassis Slot');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `olt_pon_port` SET TAGS ('dbx_business_glossary_term' = 'Optical Line Terminal (OLT) Passive Optical Network (PON) Port');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `ont_firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Optical Network Terminal (ONT) Firmware Version');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `ont_firmware_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `ont_location_description` SET TAGS ('dbx_business_glossary_term' = 'Optical Network Terminal (ONT) Location Description');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `optical_power_rx_dbm` SET TAGS ('dbx_business_glossary_term' = 'Optical Power Receive Decibels Milliwatt (dBm)');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `optical_power_tx_dbm` SET TAGS ('dbx_business_glossary_term' = 'Optical Power Transmit Decibels Milliwatt (dBm)');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `provisioning_status` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Status');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `svlan_number` SET TAGS ('dbx_business_glossary_term' = 'Service Virtual Local Area Network (S-VLAN) ID');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `tcont_number` SET TAGS ('dbx_business_glossary_term' = 'Transmission Container (T-CONT) ID');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `upstream_bandwidth_mbps` SET TAGS ('dbx_business_glossary_term' = 'Upstream Bandwidth Megabits per Second (Mbps)');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `upstream_bandwidth_profile` SET TAGS ('dbx_business_glossary_term' = 'Upstream Bandwidth Profile');
ALTER TABLE `telecommunication_ecm`.`service`.`ftth_ont_config` ALTER COLUMN `vlan_number` SET TAGS ('dbx_business_glossary_term' = 'Virtual Local Area Network (VLAN) ID');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` SET TAGS ('dbx_subdomain' = 'provisioning_operations');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `provisioning_fallout_id` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Fallout ID');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To User Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `dq_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Dq Issue Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Network Element ID');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `provisioning_order_id` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Order ID');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `noc_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Related Incident ID');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `problem_record_id` SET TAGS ('dbx_business_glossary_term' = 'Related Problem ID');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance ID');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `assigned_to_team` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Team');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `customer_impact` SET TAGS ('dbx_business_glossary_term' = 'Customer Impact');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `customer_impact` SET TAGS ('dbx_value_regex' = 'service_down|service_degraded|activation_delayed|no_customer_impact');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `customer_notified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notified Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `error_category` SET TAGS ('dbx_business_glossary_term' = 'Error Category');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `error_description` SET TAGS ('dbx_business_glossary_term' = 'Error Description');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `external_vendor_involved` SET TAGS ('dbx_business_glossary_term' = 'External Vendor Involved Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `failed_system_name` SET TAGS ('dbx_business_glossary_term' = 'Failed System Name');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `failure_layer` SET TAGS ('dbx_business_glossary_term' = 'Failure Layer');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `failure_layer` SET TAGS ('dbx_value_regex' = 'network_element|oss_system|bss_system|integration_layer|external_vendor');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `failure_step` SET TAGS ('dbx_business_glossary_term' = 'Failure Step');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `fallout_number` SET TAGS ('dbx_business_glossary_term' = 'Fallout Number');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `fallout_status` SET TAGS ('dbx_business_glossary_term' = 'Fallout Status');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `fallout_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_vendor|resolved|closed|cancelled');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `fallout_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fallout Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `max_retry_reached` SET TAGS ('dbx_business_glossary_term' = 'Maximum Retry Reached Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'new_activation|modification|suspension|termination|migration');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `preventive_action` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `resolution_category` SET TAGS ('dbx_business_glossary_term' = 'Resolution Category');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `resolution_category` SET TAGS ('dbx_value_regex' = 'manual_intervention|system_restart|configuration_fix|data_correction|vendor_escalation|cancelled');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `resolution_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Duration Minutes');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Code');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `sla_breach_risk` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Risk Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Technology Type');
ALTER TABLE `telecommunication_ecm`.`service`.`provisioning_fallout` ALTER COLUMN `vendor_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Ticket Number');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `svc_location_id` SET TAGS ('dbx_business_glossary_term' = 'Service Location Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`svc_location` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` SET TAGS ('dbx_subdomain' = 'service_management');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `dependency_id` SET TAGS ('dbx_business_glossary_term' = 'Service Dependency Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Child Service Instance Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `dependency_svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Service Instance Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Product Offering Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `provisioning_order_id` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Order Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `revenue_recognition_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`service`.`dependency` ALTER COLUMN `parent_dependency_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `telecommunication_ecm`.`service`.`service_roaming_session` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`service`.`service_roaming_session` SET TAGS ('dbx_subdomain' = 'service_management');
ALTER TABLE `telecommunication_ecm`.`service`.`service_roaming_session` SET TAGS ('dbx_association_edges' = 'service.svc_instance,partner.partner_roaming_agreement');
ALTER TABLE `telecommunication_ecm`.`service`.`service_roaming_session` ALTER COLUMN `service_roaming_session_id` SET TAGS ('dbx_business_glossary_term' = 'service_roaming_session Identifier');
ALTER TABLE `telecommunication_ecm`.`service`.`service_roaming_session` ALTER COLUMN `roaming_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Roaming Session - Partner Roaming Agreement Id');
ALTER TABLE `telecommunication_ecm`.`service`.`service_roaming_session` ALTER COLUMN `customer_roaming_session_id` SET TAGS ('dbx_business_glossary_term' = 'Roaming Session Identifier');
ALTER TABLE `telecommunication_ecm`.`service`.`service_roaming_session` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Roaming Session - Svc Instance Id');
ALTER TABLE `telecommunication_ecm`.`service`.`service_roaming_session` ALTER COLUMN `data_volume_mb` SET TAGS ('dbx_business_glossary_term' = 'Data Volume Megabytes');
ALTER TABLE `telecommunication_ecm`.`service`.`service_roaming_session` ALTER COLUMN `fraud_alert_triggered` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Triggered');
ALTER TABLE `telecommunication_ecm`.`service`.`service_roaming_session` ALTER COLUMN `roaming_country_code` SET TAGS ('dbx_business_glossary_term' = 'Roaming Country Code');
ALTER TABLE `telecommunication_ecm`.`service`.`service_roaming_session` ALTER COLUMN `session_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Roaming Session End Time');
ALTER TABLE `telecommunication_ecm`.`service`.`service_roaming_session` ALTER COLUMN `session_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Roaming Session Start Time');
ALTER TABLE `telecommunication_ecm`.`service`.`service_roaming_session` ALTER COLUMN `session_status` SET TAGS ('dbx_business_glossary_term' = 'Session Status');
ALTER TABLE `telecommunication_ecm`.`service`.`service_roaming_session` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `telecommunication_ecm`.`service`.`service_roaming_session` ALTER COLUMN `sms_count` SET TAGS ('dbx_business_glossary_term' = 'SMS Count');
ALTER TABLE `telecommunication_ecm`.`service`.`service_roaming_session` ALTER COLUMN `tap_record_reference` SET TAGS ('dbx_business_glossary_term' = 'TAP Record Reference');
ALTER TABLE `telecommunication_ecm`.`service`.`service_roaming_session` ALTER COLUMN `visited_network_code` SET TAGS ('dbx_business_glossary_term' = 'Visited Network Identifier');
ALTER TABLE `telecommunication_ecm`.`service`.`service_roaming_session` ALTER COLUMN `voice_minutes` SET TAGS ('dbx_business_glossary_term' = 'Voice Minutes');
ALTER TABLE `telecommunication_ecm`.`service`.`ont_service_binding` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`service`.`ont_service_binding` SET TAGS ('dbx_subdomain' = 'provisioning_operations');
ALTER TABLE `telecommunication_ecm`.`service`.`ont_service_binding` SET TAGS ('dbx_association_edges' = 'service.svc_instance,inventory.ont_asset');
ALTER TABLE `telecommunication_ecm`.`service`.`ont_service_binding` ALTER COLUMN `ont_service_binding_id` SET TAGS ('dbx_business_glossary_term' = 'ONT Service Binding Identifier');
ALTER TABLE `telecommunication_ecm`.`service`.`ont_service_binding` ALTER COLUMN `ont_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ont Service Binding - Ont Asset Id');
ALTER TABLE `telecommunication_ecm`.`service`.`ont_service_binding` ALTER COLUMN `service_qos_profile_id` SET TAGS ('dbx_business_glossary_term' = 'QoS Profile Identifier');
ALTER TABLE `telecommunication_ecm`.`service`.`ont_service_binding` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Ont Service Binding - Svc Instance Id');
ALTER TABLE `telecommunication_ecm`.`service`.`ont_service_binding` ALTER COLUMN `activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Binding Activation Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`ont_service_binding` ALTER COLUMN `bandwidth_downstream_mbps` SET TAGS ('dbx_business_glossary_term' = 'Downstream Bandwidth Allocation');
ALTER TABLE `telecommunication_ecm`.`service`.`ont_service_binding` ALTER COLUMN `bandwidth_upstream_mbps` SET TAGS ('dbx_business_glossary_term' = 'Upstream Bandwidth Allocation');
ALTER TABLE `telecommunication_ecm`.`service`.`ont_service_binding` ALTER COLUMN `deactivation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Binding Deactivation Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`ont_service_binding` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`ont_service_binding` ALTER COLUMN `ont_port_assignment` SET TAGS ('dbx_business_glossary_term' = 'ONT Port Assignment');
ALTER TABLE `telecommunication_ecm`.`service`.`ont_service_binding` ALTER COLUMN `optical_power_rx_dbm` SET TAGS ('dbx_business_glossary_term' = 'Received Optical Power at Binding');
ALTER TABLE `telecommunication_ecm`.`service`.`ont_service_binding` ALTER COLUMN `optical_power_tx_dbm` SET TAGS ('dbx_business_glossary_term' = 'Transmitted Optical Power at Binding');
ALTER TABLE `telecommunication_ecm`.`service`.`ont_service_binding` ALTER COLUMN `provisioning_status` SET TAGS ('dbx_business_glossary_term' = 'Binding Provisioning Status');
ALTER TABLE `telecommunication_ecm`.`service`.`ont_service_binding` ALTER COLUMN `provisioning_system` SET TAGS ('dbx_business_glossary_term' = 'Provisioning System');
ALTER TABLE `telecommunication_ecm`.`service`.`ont_service_binding` ALTER COLUMN `vlan_number` SET TAGS ('dbx_business_glossary_term' = 'VLAN Identifier');
ALTER TABLE `telecommunication_ecm`.`service`.`ont_service_binding` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `telecommunication_ecm`.`service`.`visit` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`service`.`visit` SET TAGS ('dbx_subdomain' = 'provisioning_operations');
ALTER TABLE `telecommunication_ecm`.`service`.`visit` SET TAGS ('dbx_association_edges' = 'service.svc_instance,workforce.technician');
ALTER TABLE `telecommunication_ecm`.`service`.`visit` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Service Visit Identifier');
ALTER TABLE `telecommunication_ecm`.`service`.`visit` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Visit - Svc Instance Id');
ALTER TABLE `telecommunication_ecm`.`service`.`visit` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Service Visit - Technician Id');
ALTER TABLE `telecommunication_ecm`.`service`.`visit` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier');
ALTER TABLE `telecommunication_ecm`.`service`.`visit` ALTER COLUMN `actual_arrival_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Time');
ALTER TABLE `telecommunication_ecm`.`service`.`visit` ALTER COLUMN `actual_completion_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Time');
ALTER TABLE `telecommunication_ecm`.`service`.`visit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`visit` ALTER COLUMN `customer_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Present Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`visit` ALTER COLUMN `customer_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Rating');
ALTER TABLE `telecommunication_ecm`.`service`.`visit` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-up Required Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`visit` ALTER COLUMN `labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Labor Hours');
ALTER TABLE `telecommunication_ecm`.`service`.`visit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Visit Notes');
ALTER TABLE `telecommunication_ecm`.`service`.`visit` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Visit Outcome');
ALTER TABLE `telecommunication_ecm`.`service`.`visit` ALTER COLUMN `parts_used_flag` SET TAGS ('dbx_business_glossary_term' = 'Parts Used Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`visit` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `telecommunication_ecm`.`service`.`visit` ALTER COLUMN `sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA Met Flag');
ALTER TABLE `telecommunication_ecm`.`service`.`visit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`visit` ALTER COLUMN `visit_date` SET TAGS ('dbx_business_glossary_term' = 'Visit Date');
ALTER TABLE `telecommunication_ecm`.`service`.`visit` ALTER COLUMN `visit_type` SET TAGS ('dbx_business_glossary_term' = 'Visit Type');
ALTER TABLE `telecommunication_ecm`.`service`.`visit` ALTER COLUMN `work_performed_description` SET TAGS ('dbx_business_glossary_term' = 'Work Performed Description');
ALTER TABLE `telecommunication_ecm`.`service`.`contract_service_line` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`service`.`contract_service_line` SET TAGS ('dbx_subdomain' = 'provisioning_operations');
ALTER TABLE `telecommunication_ecm`.`service`.`contract_service_line` SET TAGS ('dbx_association_edges' = 'service.svc_instance,sales.sales_contract');
ALTER TABLE `telecommunication_ecm`.`service`.`contract_service_line` ALTER COLUMN `contract_service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Service Line ID');
ALTER TABLE `telecommunication_ecm`.`service`.`contract_service_line` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Amendment Reference');
ALTER TABLE `telecommunication_ecm`.`service`.`contract_service_line` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Service Line - Sales Contract Id');
ALTER TABLE `telecommunication_ecm`.`service`.`contract_service_line` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Service Line - Svc Instance Id');
ALTER TABLE `telecommunication_ecm`.`service`.`contract_service_line` ALTER COLUMN `billing_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service Billing End Date');
ALTER TABLE `telecommunication_ecm`.`service`.`contract_service_line` ALTER COLUMN `billing_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Billing Start Date');
ALTER TABLE `telecommunication_ecm`.`service`.`contract_service_line` ALTER COLUMN `contract_line_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Number');
ALTER TABLE `telecommunication_ecm`.`service`.`contract_service_line` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Term');
ALTER TABLE `telecommunication_ecm`.`service`.`contract_service_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `telecommunication_ecm`.`service`.`contract_service_line` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Line Effective End Date');
ALTER TABLE `telecommunication_ecm`.`service`.`contract_service_line` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Line Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`service`.`contract_service_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Status');
ALTER TABLE `telecommunication_ecm`.`service`.`contract_service_line` ALTER COLUMN `mrr_amount` SET TAGS ('dbx_business_glossary_term' = 'Service Line MRR');
ALTER TABLE `telecommunication_ecm`.`service`.`contract_service_line` ALTER COLUMN `service_activation_date` SET TAGS ('dbx_business_glossary_term' = 'Service Activation Date Under Contract');
ALTER TABLE `telecommunication_ecm`.`service`.`contract_service_line` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Service Status');
ALTER TABLE `telecommunication_ecm`.`service`.`contract_service_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
