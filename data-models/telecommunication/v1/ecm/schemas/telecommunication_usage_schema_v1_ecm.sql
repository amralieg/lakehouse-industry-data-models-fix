-- Schema for Domain: usage | Business: Telecommunication | Version: v1_ecm
-- Generated on: 2026-05-08 05:07:51

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `telecommunication_ecm`.`usage` COMMENT 'SSOT for raw and processed usage event data — CDRs (voice, SMS, data), IPDR streams, DPI session records, roaming TAP/NRTRDE records, and content consumption events. Manages usage collection, mediation, aggregation, and feeds to real-time rating engines and revenue assurance analytics.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `telecommunication_ecm`.`usage`.`cdr` (
    `cdr_id` BIGINT COMMENT 'Unique identifier for the call detail record. Primary key for the CDR product.',
    `carrier_id` BIGINT COMMENT 'Reference to the interconnect partner involved in call termination or origination.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: CDRs must be attributed to operating company for revenue recognition, interconnect settlement accounting, and regulatory reporting in multi-entity telecommunications groups. Critical for financial aud',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise voice CDRs must link to corporate accounts for B2B billing, cost allocation by department/site, invoice generation, and regulatory compliance reporting. Standard telecom B2B operations.',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: Call detail records must track originating CPE (router, STB, mobile hotspot) for device-specific troubleshooting, warranty claims, firmware correlation with call quality issues, and capacity planning ',
    `enterprise_site_id` BIGINT COMMENT 'Foreign key linking to enterprise.site. Business justification: Enterprise CDRs need site-level attribution for cost center allocation, site-specific billing, location-based usage analytics, and chargeback reporting in multi-site corporate telecommunications opera',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to order.fulfillment_order. Business justification: Links CDR to originating provisioning order. Enables order-to-revenue reconciliation, service activation validation (first call proves service works), and dispute resolution when customers claim servi',
    `iot_deployment_id` BIGINT COMMENT 'Foreign key linking to enterprise.iot_deployment. Business justification: IoT CDRs (M2M voice alerts, diagnostic calls) must link to IoT deployments for fleet-level usage tracking, billing aggregation, and device connectivity monitoring in enterprise IoT operations.',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Enterprise CDRs for managed voice services must link to specific managed service instances for SLA monitoring, service-level billing, and contract compliance tracking in B2B telecommunications.',
    `network_operator_carrier_id` BIGINT COMMENT 'Identifier of the network operator that handled the call (home or visited network).',
    `original_cdr_id` BIGINT COMMENT 'Reference to the original CDR identifier if this record is a correction or reprocessed version.',
    `pipeline_run_id` BIGINT COMMENT 'Foreign key linking to analytics.pipeline_run. Business justification: CDR mediation and rating processes execute via ETL pipelines. Operational troubleshooting of rating errors, reprocessing workflows, and data lineage tracking require linking each CDR to the pipeline r',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: CDR rating engines require the active price plan at call time to calculate charges. Every rated CDR must reference the price plan used for billing reconciliation and revenue assurance audits.',
    `ran_cell_id` BIGINT COMMENT 'Identifier of the cell tower or base station that served the call.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: CDRs are source data for regulatory traffic reports, interconnect reports, and revenue reports submitted to telecom authorities. Regulators require detailed call records for market oversight, dispute ',
    `roaming_file_id` BIGINT COMMENT 'Foreign key linking to usage.roaming_file. Business justification: CDR records generated in roaming scenarios are transmitted via TAP (Transferred Account Procedure) files. The cdr table has tap_file_sequence_number (STRING) which is a denormalized reference to the f',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber who originated or received the call.',
    `svc_instance_id` BIGINT COMMENT 'Foreign key linking to service.svc_instance. Business justification: CDRs must link to service instances for billing reconciliation, service quality analysis, dispute resolution, and regulatory reporting. Core telecom operation linking usage events to provisioned servi',
    `bearer_service_code` STRING COMMENT 'Code identifying the bearer service type used for the call.',
    `call_category` STRING COMMENT 'Geographic classification of the call: local, national, international, or roaming.. Valid values are `local|national|international|roaming`',
    `call_direction` STRING COMMENT 'Direction of the call: mobile originated (MO), mobile terminated (MT), or forwarded.. Valid values are `mobile_originated|mobile_terminated|forwarded`',
    `call_duration_seconds` STRING COMMENT 'Total duration of the call in seconds, calculated from start to end timestamp.',
    `call_end_timestamp` TIMESTAMP COMMENT 'The exact date and time when the call was terminated or disconnected.',
    `call_start_timestamp` TIMESTAMP COMMENT 'The exact date and time when the call was initiated or connected.',
    `call_type` STRING COMMENT 'Type of communication event captured in this CDR (voice, SMS, MMS, data session, video call).. Valid values are `voice|sms|mms|data|video`',
    `charging_indicator` STRING COMMENT 'Indicates whether the call is chargeable, non-chargeable, free, or promotional.. Valid values are `chargeable|non_chargeable|free|promotional`',
    `collection_timestamp` TIMESTAMP COMMENT 'Timestamp when the CDR was collected from the network element.',
    `correction_indicator` BOOLEAN COMMENT 'Flag indicating whether this CDR is a correction or adjustment of a previously processed record.',
    `data_volume_downlink_bytes` BIGINT COMMENT 'Total data volume downloaded during the session, measured in bytes.',
    `data_volume_uplink_bytes` BIGINT COMMENT 'Total data volume uploaded during the session, measured in bytes.',
    `fraud_indicator` BOOLEAN COMMENT 'Flag indicating whether this CDR has been flagged for potential fraudulent activity.',
    `imei` STRING COMMENT 'Unique identifier for the mobile device hardware used during the call.. Valid values are `^[0-9]{15}$`',
    `imsi` STRING COMMENT 'Unique identifier for the subscribers SIM card, used to identify the user in the mobile network.. Valid values are `^[0-9]{14,15}$`',
    `ingestion_timestamp` TIMESTAMP COMMENT 'Timestamp when the CDR was ingested into the lakehouse silver layer.',
    `location_area_code` STRING COMMENT 'Location area code identifying the geographic region where the call originated.',
    `mediation_status` STRING COMMENT 'Current processing status of the CDR in the mediation layer.. Valid values are `raw|mediated|validated|rejected|error`',
    `mediation_timestamp` TIMESTAMP COMMENT 'Timestamp when the CDR was processed through the mediation layer.',
    `msisdn` STRING COMMENT 'The telephone number associated with the subscribers mobile device.. Valid values are `^[0-9]{10,15}$`',
    `nrtrde_batch_reference` STRING COMMENT 'Batch identifier for near real-time roaming data exchange records.',
    `originating_number` STRING COMMENT 'The telephone number that initiated the call (A-party number).. Valid values are `^[0-9+]{10,15}$`',
    `qos_class` STRING COMMENT 'Quality of Service class assigned to the call or data session.',
    `rating_status` STRING COMMENT 'Status of the rating process for this CDR in the billing system.. Valid values are `pending|rated|failed|reprocessed`',
    `record_sequence_number` BIGINT COMMENT 'Sequential number assigned to the CDR within the source system or collection batch.',
    `record_version` STRING COMMENT 'Version number of the CDR record, incremented when corrections or updates are applied.',
    `revenue_assurance_status` STRING COMMENT 'Status of revenue assurance validation for this CDR.. Valid values are `passed|flagged|under_review|cleared`',
    `roaming_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the roaming call occurred.. Valid values are `^[A-Z]{3}$`',
    `roaming_indicator` BOOLEAN COMMENT 'Flag indicating whether the call occurred while the subscriber was roaming on another network.',
    `roaming_network_code` STRING COMMENT 'Mobile Country Code (MCC) and Mobile Network Code (MNC) of the visited roaming network.. Valid values are `^[0-9]{5,6}$`',
    `service_type` STRING COMMENT 'Technology platform used for the call: VoLTE, IMS-based, circuit-switched, or packet-switched.. Valid values are `volte|ims|circuit_switched|packet_switched`',
    `serving_msc` STRING COMMENT 'Identifier of the Mobile Switching Center that handled the call.',
    `source_system` STRING COMMENT 'Identifier of the source system that generated the CDR (MSC, SSF, IMS-AS, mediation platform).',
    `supplementary_service_codes` STRING COMMENT 'Comma-separated list of supplementary service codes active during the call (call forwarding, call waiting, etc.).',
    `terminating_number` STRING COMMENT 'The telephone number that received the call (B-party number).. Valid values are `^[0-9+]{10,15}$`',
    `termination_cause_code` STRING COMMENT 'Code indicating the reason for call termination (normal, busy, no answer, network failure, etc.).',
    `termination_cause_description` STRING COMMENT 'Human-readable description of the call termination reason.',
    `trunk_group_code` STRING COMMENT 'Identifier of the trunk group used for call routing and interconnection.',
    CONSTRAINT pk_cdr PRIMARY KEY(`cdr_id`)
) COMMENT 'Call Detail Record — the authoritative raw usage event record for voice calls (MO/MT, VoLTE, IMS-based), capturing originating/terminating numbers, call start/end timestamps, duration, call type (local, national, international, roaming), network node identifiers, IMSI, IMEI, cell ID, trunk group, termination cause, and mediation processing status. Sourced from MSC/SSF/IMS-AS and processed through the mediation layer. SSOT for voice CDR data in the Silver layer.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`usage`.`sms_record` (
    `sms_record_id` BIGINT COMMENT 'Unique identifier for the SMS usage event record. Primary key for the SMS record entity.',
    `billing_account_id` BIGINT COMMENT 'Foreign key reference to the billing account that will be charged for this SMS event. May differ from subscriber_id in corporate or family plan scenarios.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to interconnect.interconnect_carrier. Business justification: Roaming SMS records require interconnect carrier identification for TAP file generation and settlement invoice reconciliation. Visited network code is denormalized carrier reference replaced by proper',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise SMS usage (M2M alerts, IoT messaging, corporate bulk SMS) requires corporate account linkage for billing, usage reporting, and cost center allocation in B2B telecommunications.',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to order.fulfillment_order. Business justification: Links SMS usage to provisioning order. Enables activation verification, MNP port success validation (first SMS after port proves successful migration), and dispute resolution for service-never-worked ',
    `iot_deployment_id` BIGINT COMMENT 'Foreign key linking to enterprise.iot_deployment. Business justification: IoT SMS records (device alerts, M2M messaging, sensor notifications) must link to deployments for usage tracking, billing, and fleet-level messaging analytics in enterprise IoT telecommunications.',
    `element_id` BIGINT COMMENT 'Identifier of the network element (SMSC, MSC, or gateway) that generated this CDR. Used for network operations, fault correlation, and capacity planning.',
    `pipeline_run_id` BIGINT COMMENT 'Foreign key linking to analytics.pipeline_run. Business justification: SMS mediation follows same pattern as CDR - records processed in batches by pipelines. Troubleshooting SMS rating issues and reprocessing failed batches requires pipeline run context for operational l',
    `ran_cell_id` BIGINT COMMENT 'Identifier of the radio cell or base station where the originating subscriber was located when the SMS was sent. Used for network analytics and location-based services.',
    `rate_plan_id` BIGINT COMMENT 'Foreign key reference to the rate plan or tariff that was applied to rate this SMS event. Used for billing reconciliation and revenue assurance.',
    `roaming_file_id` BIGINT COMMENT 'Foreign key linking to usage.roaming_file. Business justification: SMS records in roaming scenarios are transmitted via TAP files alongside voice CDRs. The sms_record table has tap_file_sequence (STRING) which is a denormalized reference. Adding tap_file_id FK to roa',
    `subscriber_id` BIGINT COMMENT 'Foreign key reference to the subscriber master record. Links this SMS usage event to the customer account for billing and analytics.',
    `svc_instance_id` BIGINT COMMENT 'Foreign key linking to service.svc_instance. Business justification: SMS records require service instance context for accurate rating, billing, service-level troubleshooting, and validating service entitlements. Standard practice in telecom mediation and billing system',
    `cdr_sequence_number` STRING COMMENT 'Unique sequence number assigned by the mediation system to this SMS CDR for traceability and reconciliation across billing and revenue assurance systems.. Valid values are `^[A-Z0-9]{10,30}$`',
    `charging_indicator` STRING COMMENT 'Indicates whether this SMS event is chargeable to the subscriber: chargeable (standard billing applies), non_chargeable (free service message), promotional (marketing campaign, no charge), zero_rated (included in bundle or plan).. Valid values are `chargeable|non_chargeable|promotional|zero_rated`',
    `content_class` STRING COMMENT 'Classification of the message content for regulatory reporting and rating: standard (regular P2P), premium (premium-rate services), promotional (marketing A2P), transactional (account notifications), otp (one-time password), alert (emergency or service alerts).. Valid values are `standard|premium|promotional|transactional|otp|alert`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the rated amount (e.g., USD, EUR, GBP). Null if non-chargeable.. Valid values are `^[A-Z]{3}$`',
    `data_coding_scheme` STRING COMMENT 'Code indicating the character encoding and message class of the SMS (e.g., 7-bit GSM, 8-bit data, UCS-2 Unicode). Used for message rendering and international character support.. Valid values are `^[0-9]{1,3}$`',
    `delivery_status` STRING COMMENT 'Final delivery outcome of the SMS message: delivered (successfully received by destination), failed (permanent delivery failure), pending (awaiting retry), expired (exceeded retry window), rejected (blocked by spam filter or policy), unknown (status not available).. Valid values are `delivered|failed|pending|expired|rejected|unknown`',
    `delivery_timestamp` TIMESTAMP COMMENT 'The date and time when the SMS message was successfully delivered to the terminating device, or when final delivery failure was confirmed. Null if delivery is still pending.',
    `fraud_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this SMS event was flagged by fraud detection systems as potentially fraudulent (e.g., SMS spam, A2P abuse, SIM box fraud). True if flagged, false otherwise.',
    `home_network_code` STRING COMMENT 'The MCC-MNC code of the subscribers home network. Used to identify the operator responsible for billing and to distinguish home vs. roaming traffic.. Valid values are `^[0-9]{5,6}$`',
    `imei` STRING COMMENT 'The unique identifier of the mobile device used to send or receive this SMS. Used for device tracking, fraud detection, and stolen device blocking. Personally identifiable information subject to privacy regulations.. Valid values are `^[0-9]{14,16}$`',
    `imsi` STRING COMMENT 'The unique identifier of the SIM card used for this SMS event. Personally identifiable information used for subscriber authentication and roaming. Subject to privacy regulations.. Valid values are `^[0-9]{14,15}$`',
    `mediation_status` STRING COMMENT 'Processing status of the SMS CDR within the mediation and usage collection pipeline: raw (newly collected), mediated (normalized and enriched), validated (passed quality checks), rejected (failed validation), duplicate (identified as duplicate record).. Valid values are `raw|mediated|validated|rejected|duplicate`',
    `mediation_timestamp` TIMESTAMP COMMENT 'The date and time when this SMS CDR was processed by the mediation system and loaded into the usage data repository.',
    `message_reference` STRING COMMENT 'Unique reference identifier assigned by the originating application or SMSC for message tracking and delivery receipt correlation. Used for A2P campaign tracking and delivery confirmation.. Valid values are `^[A-Z0-9]{10,40}$`',
    `message_segment_count` STRING COMMENT 'Number of SMS segments required to transmit the message. Standard SMS is 160 characters (1 segment); longer messages are split into multiple concatenated segments, each rated separately.',
    `message_size_bytes` STRING COMMENT 'Total size of the SMS or MMS message payload in bytes. Used for rating, especially for MMS and concatenated SMS messages that span multiple segments.',
    `message_timestamp` TIMESTAMP COMMENT 'The exact date and time when the SMS message was originated or received by the network, captured in UTC. This is the principal business event timestamp for rating and billing purposes.',
    `message_type` STRING COMMENT 'Classification of the SMS message: MT (Mobile Terminated - incoming to subscriber), MO (Mobile Originated - outgoing from subscriber), P2P (Person-to-Person), A2P (Application-to-Person for commercial messaging), P2A (Person-to-Application), MMS (Multimedia Messaging Service).. Valid values are `MT|MO|P2P|A2P|P2A|MMS`',
    `originating_msisdn` STRING COMMENT 'The phone number of the subscriber or application that originated the SMS message. Personally identifiable information subject to CPNI and privacy regulations.. Valid values are `^[0-9]{10,15}$`',
    `partition_date` DATE COMMENT 'The date used for physical partitioning of this SMS record in the lakehouse storage layer, typically derived from message_timestamp. Used for query optimization and data lifecycle management.',
    `priority_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this SMS was marked as high-priority for expedited delivery (e.g., emergency alerts, OTP messages). True if high-priority, false otherwise.',
    `protocol_identifier` STRING COMMENT 'SMS protocol identifier code indicating the type of message protocol used (e.g., standard SMS, SIM data download, email gateway). Used for technical troubleshooting and protocol-specific routing.. Valid values are `^[0-9]{1,3}$`',
    `rated_amount` DECIMAL(18,2) COMMENT 'The monetary amount charged for this SMS event after rating engine processing, in the billing currency. Null if non-chargeable or not yet rated.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this SMS record was first created in the usage data repository. Used for data lineage and audit trail purposes.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this SMS record was last modified in the usage data repository. Used for change tracking and audit trail purposes.',
    `reply_path_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a reply path was requested for this SMS, allowing the recipient to reply via the same SMSC route. True if reply path enabled, false otherwise.',
    `roaming_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the originating or terminating subscriber was roaming on a visited network at the time of the SMS event. True if roaming, false if on home network.',
    `service_code` STRING COMMENT 'Internal service code or product identifier used by the rating engine to determine the applicable tariff and billing treatment for this SMS event.. Valid values are `^[A-Z0-9]{2,10}$`',
    `smsc_address` STRING COMMENT 'Network address of the SMSC node that processed and routed this SMS message. Used for network troubleshooting and capacity planning.. Valid values are `^[A-Z0-9.]{5,50}$`',
    `source_system` STRING COMMENT 'Identifier of the upstream system or mediation platform that provided this SMS CDR (e.g., SMSC vendor name, mediation system instance). Used for data lineage and troubleshooting.. Valid values are `^[A-Z0-9_]{3,30}$`',
    `spam_score` DECIMAL(18,2) COMMENT 'Numeric score (0.00 to 100.00) assigned by spam detection algorithms indicating the likelihood that this SMS is unsolicited commercial messaging or spam. Higher scores indicate higher spam probability.',
    `terminating_msisdn` STRING COMMENT 'The phone number of the subscriber or application that received the SMS message. Personally identifiable information subject to CPNI and privacy regulations.. Valid values are `^[0-9]{10,15}$`',
    `validity_period_minutes` STRING COMMENT 'The time period (in minutes) during which the SMSC will attempt to deliver the message before expiring it. Null if default validity period applies.',
    CONSTRAINT pk_sms_record PRIMARY KEY(`sms_record_id`)
) COMMENT 'Short Message Service usage event record capturing SMS/MMS origination and termination details — MSISDN, SMSC address, message type (MT/MO/P2P/A2P), delivery status, content class, message size, timestamp, network node, roaming indicator, and mediation status. Distinct from voice CDRs due to different rating logic, regulatory reporting (A2P filtering), and spam/fraud patterns.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`usage`.`data_session` (
    `data_session_id` BIGINT COMMENT 'Unique identifier for the packet data session record. Primary key.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Data sessions must tie to billing account for charging, invoicing, and revenue recognition. Every data session is a billable event requiring account-level aggregation for postpaid billing cycles.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to interconnect.interconnect_carrier. Business justification: Roaming data sessions must link to interconnect carrier for NRTRDE near-real-time transmission, TAP file generation, and IoT tariff application. PLMN ID is denormalized carrier identifier.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise data sessions (mobile workforce, IoT devices, corporate APNs) must link to corporate accounts for usage-based billing, bandwidth reporting, and cost allocation across business units.',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: Data sessions require CPE device linkage for bandwidth throttling decisions, device-specific QoS policies, firmware performance analytics, and customer support escalations where device model/condition',
    `dq_execution_result_id` BIGINT COMMENT 'Foreign key linking to analytics.dq_execution_result. Business justification: Data sessions validated by DQ rules (volume thresholds, duration checks, APN validation). Linking enables remediation workflows, troubleshooting data billing discrepancies, and quality monitoring.',
    `enterprise_site_id` BIGINT COMMENT 'Foreign key linking to enterprise.site. Business justification: Enterprise data sessions must link to sites for location-based usage tracking, bandwidth management per site, site-level performance reporting, and cost allocation in multi-location B2B operations.',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to order.fulfillment_order. Business justification: Links data session to provisioning order. Enables first-use validation (did broadband/mobile data activate as promised?), quality assurance (actual throughput vs. ordered speed), and regulatory compli',
    `iot_deployment_id` BIGINT COMMENT 'Foreign key linking to enterprise.iot_deployment. Business justification: IoT data sessions are the primary usage type for IoT deployments, requiring linkage for billing, device monitoring, data plan enforcement, and fleet-level connectivity analytics in enterprise IoT.',
    `ip_address_pool_id` BIGINT COMMENT 'Foreign key linking to inventory.ip_address_pool. Business justification: Sessions must reference the IP pool that allocated ue_ip_address for CGNAT port allocation tracking, IP address reclamation workflows, lawful intercept correlation, pool utilization analytics, and reg',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Data sessions for managed connectivity services must link to managed service instances for bandwidth monitoring, SLA compliance measurement, and service-level usage reporting in enterprise telecommuni',
    `network_qos_profile_id` BIGINT COMMENT 'Foreign key linking to network.qos_profile. Business justification: Data sessions inherit QoS profiles mapping QCI/5QI values to bearer characteristics (GBR, MBR, packet delay budget). Direct link enables session-level QoS analysis, SLA breach investigation, and corre',
    `ont_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.ont_asset. Business justification: FTTH data sessions require ONT device reference for optical power diagnostics, distance-based QoS adjustments, ONT firmware correlation with session quality, PON capacity planning, and field technicia',
    `pipeline_run_id` BIGINT COMMENT 'Foreign key linking to analytics.pipeline_run. Business justification: Data session mediation and aggregation executed via pipelines. Operational lineage tracking, troubleshooting data volume discrepancies, and reprocessing workflows require linking sessions to the pipel',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: Data session rating requires the active price plan to apply tiered pricing, overage rates, and zero-rating policies. Essential for real-time charging and billing cycle aggregation in mobile data netwo',
    `qos_measurement_id` BIGINT COMMENT 'Foreign key linking to assurance.qos_measurement. Business justification: Real-time QoS measurements (throughput, latency, jitter, MOS) are captured during active data sessions to validate service delivery against SLA commitments. Session diagnostics and customer experience',
    `ran_cell_id` BIGINT COMMENT 'Identifier of the radio cell where the session was initiated or primarily served. Used for geographic analysis and network optimization.',
    `rate_plan_id` BIGINT COMMENT 'Foreign key linking to billing.rate_plan. Business justification: Data sessions are rated against subscribers rate plan for charging (tiered data, fair use policy, overage). Rate plan determines pricing, throttling thresholds, and zero-rating eligibility.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Data session aggregates feed regulatory reports on broadband performance metrics, network utilization, spectrum efficiency, and quality of service. Authorities require this for license compliance, con',
    `sdwan_topology_id` BIGINT COMMENT 'Foreign key linking to enterprise.sdwan_topology. Business justification: Data sessions over SD-WAN must link to topology for underlay performance monitoring, traffic engineering analytics, and SLA measurement in enterprise SD-WAN managed connectivity services.',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber who initiated this data session.',
    `svc_instance_id` BIGINT COMMENT 'Foreign key linking to service.svc_instance. Business justification: Data sessions must tie to service instances for quota management, QoS policy enforcement, billing, and service-level performance analysis. Fundamental for mobile data operations and policy control.',
    `apn` STRING COMMENT 'The Access Point Name that defines the packet data network and services the subscriber is accessing (e.g., internet, MMS, IMS).',
    `charging_characteristics` STRING COMMENT 'Hexadecimal string defining the charging behavior for this session (e.g., online/offline charging, prepaid/postpaid). Used by charging systems to determine rating rules.',
    `charging_reference` STRING COMMENT 'Unique identifier assigned by the charging system to correlate this session with billing and rating records. Links usage to revenue assurance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this data session record was first created in the lakehouse. Used for data lineage and audit trail purposes.',
    `downlink_bytes` BIGINT COMMENT 'Total number of bytes transmitted from the network to the subscriber device during this session. Used for usage-based billing and fair-use policy enforcement.',
    `five_qi` STRING COMMENT '5G QoS Identifier for 5G NR sessions, defining the packet forwarding treatment and service characteristics. Replaces QCI in 5G networks.',
    `home_plmn_code` STRING COMMENT 'Mobile Country Code (MCC) and Mobile Network Code (MNC) of the subscriber home network. Used for subscriber identification and roaming validation.. Valid values are `^[0-9]{5,6}$`',
    `imei` STRING COMMENT 'Unique identifier for the mobile device hardware used during this data session. Used for device tracking and fraud prevention.. Valid values are `^[0-9]{15}$`',
    `imsi` STRING COMMENT 'Unique identifier stored on the SIM card that identifies the subscriber on the network. Used for authentication and session tracking.. Valid values are `^[0-9]{14,15}$`',
    `location_area_code` STRING COMMENT 'Location Area Code identifying the geographic area where the session occurred. Used for location-based services and network planning.',
    `mediation_timestamp` TIMESTAMP COMMENT 'Timestamp when this raw CDR was processed and validated by the mediation system. Used for data lineage and processing audit trails.',
    `msisdn` STRING COMMENT 'The phone number of the subscriber associated with this data session. Unique mobile subscriber identifier used for routing and billing.. Valid values are `^[0-9]{10,15}$`',
    `pdn_type` STRING COMMENT 'The IP address type assigned to the subscriber for this session (IPv4, IPv6, or dual-stack IPv4v6). Critical for IP address management and network planning.. Valid values are `IPv4|IPv6|IPv4v6`',
    `peak_downlink_throughput_kbps` DECIMAL(18,2) COMMENT 'Maximum downlink data transfer rate achieved during the session, measured in kilobits per second. Used for Quality of Service (QoS) analysis and network performance monitoring.',
    `peak_uplink_throughput_kbps` DECIMAL(18,2) COMMENT 'Maximum uplink data transfer rate achieved during the session, measured in kilobits per second. Used for Quality of Service (QoS) analysis and network performance monitoring.',
    `pgw_address` STRING COMMENT 'IP address of the PGW node that served this session in LTE networks. Gateway between the mobile network and external packet data networks.',
    `qci` STRING COMMENT 'QoS Class Identifier for LTE sessions, defining the packet forwarding treatment (e.g., priority, packet delay budget, packet error loss rate). Values range from 1 to 9 for standardized bearers.',
    `rat_type` STRING COMMENT 'The radio access technology used during the data session (e.g., 2G, 3G, HSPA, LTE, 5G NR). Critical for network performance analysis and technology migration tracking.. Valid values are `2G|3G|HSPA|HSPA_PLUS|LTE|5G_NR`',
    `rating_group` STRING COMMENT 'Identifier for the rating group applied to this session, determining the pricing rules and tariff plan. Used by real-time charging systems.',
    `record_closing_time` TIMESTAMP COMMENT 'Timestamp when this charging data record was closed and finalized by the network element. Marks the record as complete for billing processing.',
    `record_opening_time` TIMESTAMP COMMENT 'Timestamp when this charging data record was opened by the network element. Used for CDR lifecycle tracking and mediation processing.',
    `record_sequence_number` BIGINT COMMENT 'Sequential number assigned to this CDR by the generating network element. Used for duplicate detection and record ordering in mediation systems.',
    `record_type` STRING COMMENT 'Type classification of this CDR based on the generating network element and session characteristics (e.g., S-CDR for SGSN, PGW-CDR for LTE gateway). Used for CDR routing and processing rules.. Valid values are `S-CDR|M-CDR|S-SMO-CDR|PGW-CDR|SGW-CDR`',
    `roaming_indicator` BOOLEAN COMMENT 'Flag indicating whether this session occurred while the subscriber was roaming on a partner network. Critical for roaming billing and Transferred Account Procedure (TAP) processing.',
    `service_identifier` STRING COMMENT 'Unique identifier for the service type consumed during this session (e.g., internet browsing, video streaming, VoIP). Used for service-based rating and analytics.',
    `serving_node_type` STRING COMMENT 'Type of core network node that served this session (SGSN for 2G/3G, PGW/SGW for LTE, UPF for 5G). Used for network architecture analysis.. Valid values are `SGSN|PGW|SGW|UPF`',
    `session_duration_seconds` BIGINT COMMENT 'Total duration of the data session in seconds, calculated from start to end timestamp. Used for time-based rating and analytics.',
    `session_end_timestamp` TIMESTAMP COMMENT 'The date and time when the packet data session was terminated. Used to calculate session duration and billing periods.',
    `session_start_timestamp` TIMESTAMP COMMENT 'The date and time when the packet data session was initiated by the subscriber. Primary business event timestamp for session lifecycle.',
    `session_termination_cause` STRING COMMENT 'The reason code or description for why the data session was terminated (e.g., normal release, user disconnect, network failure, timeout). Used for troubleshooting and quality analysis.',
    `sgsn_address` STRING COMMENT 'IP address of the SGSN node that served this session in 2G/3G networks. Used for network element tracking and troubleshooting.',
    `sgw_address` STRING COMMENT 'IP address of the SGW node that served this session in LTE networks. Routes and forwards user data packets between the RAN and PGW.',
    `source_system` STRING COMMENT 'Identifier of the network element or system that generated this CDR (e.g., PGW node name, UPF instance). Used for data provenance and troubleshooting.',
    `total_bytes` BIGINT COMMENT 'Combined total of uplink and downlink bytes transferred during the session. Primary metric for data usage rating and quota management.',
    `tracking_area_code` STRING COMMENT 'Tracking Area Code for LTE/5G networks, identifying the registration area. Used for mobility management and location tracking.',
    `ue_ip_address` STRING COMMENT 'The IP address assigned to the subscriber device during this data session. Used for session correlation and security analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this data session record was last modified in the lakehouse. Used for change tracking and data quality monitoring.',
    `upf_address` STRING COMMENT 'IP address of the UPF node that served this session in 5G networks. Handles user plane traffic routing and forwarding in 5G core.',
    `uplink_bytes` BIGINT COMMENT 'Total number of bytes transmitted from the subscriber device to the network during this session. Used for usage-based billing and fair-use policy enforcement.',
    CONSTRAINT pk_data_session PRIMARY KEY(`data_session_id`)
) COMMENT 'Packet data session record (PGW/SGW/UPF-generated) capturing subscriber MSISDN/IMSI, APN, session start/end timestamps, uplink/downlink bytes transferred, peak throughput, RAT type (LTE/5G NR/HSPA), QoS class identifier (QCI/5QI), charging characteristics, SGSN/PGW/UPF node IDs, PDN type (IPv4/IPv6), and session termination cause. Primary source for data usage rating and fair-use policy enforcement.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`usage`.`ipdr_record` (
    `ipdr_record_id` BIGINT COMMENT 'Unique identifier for the IPDR record. Primary key for the consolidated IP flow-level and application-layer traffic data record.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: IPDR records drive policy enforcement (zero-rating, throttling) and charging decisions that require billing account context for credit limits, spend caps, and plan-specific policies.',
    `carrier_id` BIGINT COMMENT 'Identifier of the roaming partner network where this traffic occurred. Null if roaming_flag is False. Used for roaming settlement and revenue assurance.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise IPDR flows (fixed broadband, managed internet services) require corporate account linkage for traffic analysis, policy enforcement reporting, and usage-based billing in B2B operations.',
    `data_session_id` BIGINT COMMENT 'Unique session identifier assigned by the BNG/BRAS or DPI probe for this IP flow. Used to correlate multiple flows within a single subscriber session.',
    `dq_execution_result_id` BIGINT COMMENT 'Foreign key linking to analytics.dq_execution_result. Business justification: IPDR records subject to DQ validation (application detection accuracy, zero-rating eligibility). Linking enables investigation of DPI data quality issues, content billing validation, and policy enforc',
    `enterprise_site_id` BIGINT COMMENT 'Foreign key linking to enterprise.site. Business justification: IPDR records for enterprise fixed services must link to sites for circuit-level usage tracking, site performance monitoring, and location-specific traffic analysis in managed connectivity services.',
    `fraud_alert_id` BIGINT COMMENT 'Foreign key linking to assurance.fraud_alert. Business justification: Fraud detection systems analyze IPDR traffic patterns (destination IPs, application categories, volume anomalies) and generate alerts. Fraud investigation workflows require tracing alerts back to the ',
    `iot_deployment_id` BIGINT COMMENT 'Foreign key linking to enterprise.iot_deployment. Business justification: IoT IPDR records must link to deployments for application-level traffic analysis, policy enforcement, zero-rating program tracking, and fleet-level usage analytics in enterprise IoT operations.',
    `lawful_intercept_order_id` BIGINT COMMENT 'Identifier of the lawful intercept order under which this traffic was monitored. Null if lawful_intercept_flag is False. Links to the lawful intercept order master record. Highly restricted access.',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: IPDR flows for managed services must link to service instances for traffic analysis, policy enforcement monitoring, SLA measurement, and service-level performance reporting in B2B operations.',
    `partner_id` BIGINT COMMENT 'Identifier of the content provider or Over-The-Top (OTT) service associated with this traffic flow. Used for content billing, partnership settlement, and traffic analytics. Null if not applicable.',
    `pipeline_run_id` BIGINT COMMENT 'Foreign key linking to analytics.pipeline_run. Business justification: IPDR records processed by DPI/mediation pipelines. Linking to pipeline_run enables data quality investigation, troubleshooting application detection errors, and reprocessing workflows for content bill',
    `element_id` BIGINT COMMENT 'Identifier of the DPI probe or inline inspection node that captured and analyzed this traffic flow. Used for network topology analysis and probe performance monitoring.',
    `ran_cell_id` BIGINT COMMENT 'Identifier of the radio cell or base station serving the subscriber during this traffic flow. Null for fixed broadband access. Used for geographic analytics and network optimization.',
    `rate_plan_id` BIGINT COMMENT 'Foreign key linking to billing.rate_plan. Business justification: IPDR flows are rated per rate plan for policy enforcement (zero-rating specific apps, throttling after quota) and charging. Rate plan defines application-level pricing and policy rules.',
    `sdwan_policy_id` BIGINT COMMENT 'Foreign key linking to network.sdwan_policy. Business justification: DPI/IPDR systems enforce SD-WAN policies for application-aware routing, QoS marking, and path selection. Policy ID enables policy effectiveness analysis, troubleshooting application steering issues, a',
    `sdwan_topology_id` BIGINT COMMENT 'Foreign key linking to enterprise.sdwan_topology. Business justification: IPDR flows over SD-WAN must link to topology for application-aware routing analytics, policy enforcement monitoring, and traffic steering performance analysis in enterprise SD-WAN operations.',
    `slice_id` BIGINT COMMENT 'Identifier of the 5G network slice used for this traffic flow. Used for network slicing analytics and service assurance in 5G deployments. Null for non-5G traffic.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the subscriber who generated this IP traffic. Links to the subscriber master record.',
    `svc_instance_id` BIGINT COMMENT 'Foreign key linking to service.svc_instance. Business justification: IPDR records require service instance linkage for policy enforcement, zero-rating program validation, lawful intercept compliance, and service-specific traffic analysis. Critical for policy control an',
    `zero_rating_program_id` BIGINT COMMENT 'Identifier of the zero-rating program applied to this traffic flow. Null if zero_rating_eligible_flag is False. Used for zero-rating validation and revenue assurance.',
    `access_technology` STRING COMMENT 'The radio access technology or fixed access technology used by the subscriber for this traffic flow. Examples: 5G_NR, LTE, WIFI, FTTH, CABLE, DSL. Used for technology-specific analytics and network planning. [ENUM-REF-CANDIDATE: 5G_NR|LTE|3G|2G|WIFI|FIXED_BROADBAND|FTTH|CABLE|DSL|OTHER — 10 candidates stripped; promote to reference product]',
    `application_category` STRING COMMENT 'The high-level category of the detected application. Used for traffic analytics, policy enforcement, and zero-rating classification. Examples: VIDEO_STREAMING, SOCIAL_MEDIA, MESSAGING, GAMING. [ENUM-REF-CANDIDATE: VIDEO_STREAMING|SOCIAL_MEDIA|MESSAGING|GAMING|BROWSING|FILE_SHARING|VOIP|EMAIL|OTHER|UNKNOWN — 10 candidates stripped; promote to reference product]',
    `bytes_downlink` BIGINT COMMENT 'Total number of bytes transmitted from the network to the subscriber during this flow. Used for usage-based billing and fair-use policy enforcement.',
    `bytes_uplink` BIGINT COMMENT 'Total number of bytes transmitted from the subscriber to the network during this flow. Used for usage-based billing and fair-use policy enforcement.',
    `charging_rule_code` STRING COMMENT 'Identifier of the charging rule applied to this traffic flow for real-time rating. Links to the rating engine rule set. Used for billing validation and revenue assurance.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the rated_amount. Examples: USD, EUR, GBP. Null if rated_amount is null.. Valid values are `^[A-Z]{3}$`',
    `destination_domain` STRING COMMENT 'The fully qualified domain name (FQDN) of the destination server, resolved from DNS queries or extracted by DPI. Examples: www.netflix.com, api.whatsapp.net.',
    `destination_ip_address` STRING COMMENT 'The destination IP address of the traffic flow. Represents the remote server or service the subscriber is accessing.',
    `detected_application` STRING COMMENT 'The application or service detected by DPI analysis. Examples: Netflix, YouTube, WhatsApp, Facebook, Spotify, Zoom. Null if application could not be identified.',
    `dscp_marking` STRING COMMENT 'The DSCP value applied to packets in this flow for Quality of Service (QoS) prioritization. Used to enforce traffic class policies and SLA commitments.',
    `flow_duration_seconds` BIGINT COMMENT 'The total duration of the IP flow in seconds, calculated as the difference between flow_end_timestamp and flow_start_timestamp. Used for session analytics and quality of experience analysis.',
    `flow_end_timestamp` TIMESTAMP COMMENT 'The timestamp when this IP flow was terminated or closed. Represents the real-world event time of the last packet in the flow. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `flow_start_timestamp` TIMESTAMP COMMENT 'The timestamp when this IP flow was initiated. Represents the real-world event time of the first packet in the flow. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `lawful_intercept_flag` BOOLEAN COMMENT 'Indicates whether this traffic flow was subject to lawful intercept monitoring. True if the subscriber is under active lawful intercept order, False otherwise. Highly restricted access.',
    `location_area_code` STRING COMMENT 'The location area code where the subscriber was located during this traffic flow. Null for fixed broadband access. Used for geographic analytics and regulatory compliance.',
    `mediation_timestamp` TIMESTAMP COMMENT 'The timestamp when this IPDR record was processed and mediated by the usage mediation system. Used for data lineage tracking and processing audit. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `packets_downlink` BIGINT COMMENT 'Total number of packets transmitted from the network to the subscriber during this flow. Used for network performance analysis and anomaly detection.',
    `packets_uplink` BIGINT COMMENT 'Total number of packets transmitted from the subscriber to the network during this flow. Used for network performance analysis and anomaly detection.',
    `policy_enforcement_action` STRING COMMENT 'The policy enforcement action taken by the Policy Control Function (PCF) or policy engine for this flow. Examples: ALLOW, BLOCK, REDIRECT, RATE_LIMIT, LOG_ONLY. Used for policy compliance auditing.. Valid values are `ALLOW|BLOCK|REDIRECT|RATE_LIMIT|LOG_ONLY`',
    `policy_rule_code` STRING COMMENT 'Identifier of the specific policy rule that triggered the policy_enforcement_action. Used for policy effectiveness analysis and troubleshooting.',
    `protocol` STRING COMMENT 'The network or transport layer protocol used for this traffic flow. Examples: TCP, UDP, ICMP, HTTP, HTTPS, QUIC. [ENUM-REF-CANDIDATE: TCP|UDP|ICMP|HTTP|HTTPS|QUIC|FTP|SMTP|DNS|OTHER — 10 candidates stripped; promote to reference product]',
    `qos_policy_applied` STRING COMMENT 'The name or identifier of the QoS policy that was applied to this traffic flow. Examples: PREMIUM_VIDEO, STANDARD_BROWSING, BEST_EFFORT. Used for policy enforcement validation and network planning.',
    `rated_amount` DECIMAL(18,2) COMMENT 'The monetary amount charged for this traffic flow after applying the charging rule. Null if the flow is zero-rated or not subject to usage-based charging. Used for revenue assurance and billing reconciliation.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this IPDR record was first created in the lakehouse. Used for audit trail and data retention management. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `record_source_system` STRING COMMENT 'Identifier of the source system that generated this IPDR record. Examples: DPI_PROBE_VENDOR_A, BNG_SYSTEM_B, IPDR_COLLECTOR_C. Used for data lineage and source system reconciliation.',
    `roaming_flag` BOOLEAN COMMENT 'Indicates whether this traffic flow occurred while the subscriber was roaming on a partner network. True if roaming, False if on home network.',
    `subscriber_identifier` STRING COMMENT 'Alternative subscriber identifier captured from the session (e.g., MSISDN, IMSI, username, MAC address). Used when IP address alone is insufficient for subscriber correlation.',
    `subscriber_ip_address` STRING COMMENT 'The IP address assigned to the subscriber device at the time of this traffic flow. May be IPv4 or IPv6 format.',
    `throttle_action_applied` STRING COMMENT 'The throttling or traffic shaping action applied to this flow. NONE: no action, THROTTLED: bandwidth reduced, BLOCKED: traffic blocked, SHAPED: traffic shaped per policy. Used for fair-use policy enforcement evidence.. Valid values are `NONE|THROTTLED|BLOCKED|SHAPED`',
    `throttle_reason` STRING COMMENT 'The business or technical reason for applying a throttle action. Examples: FAIR_USE_EXCEEDED, CONGESTION_MANAGEMENT, POLICY_VIOLATION. Null if throttle_action_applied is NONE.',
    `traffic_direction` STRING COMMENT 'The direction of the traffic flow relative to the subscriber. UPLINK: subscriber to network, DOWNLINK: network to subscriber, BIDIRECTIONAL: both directions aggregated.. Valid values are `UPLINK|DOWNLINK|BIDIRECTIONAL`',
    `zero_rating_eligible_flag` BOOLEAN COMMENT 'Indicates whether this traffic flow is eligible for zero-rating (excluded from data allowance charges). True if the application or destination is part of a zero-rating program, False otherwise.',
    CONSTRAINT pk_ipdr_record PRIMARY KEY(`ipdr_record_id`)
) COMMENT 'IP Detail Record and Deep Packet Inspection consolidated usage record — the single authoritative source for all IP flow-level and application-layer traffic data from DPI probes, BNG/BRAS systems, and inline inspection nodes. Captures subscriber IP/identifier, destination IP/domain, DPI probe node, protocol, detected application (Netflix, YouTube, WhatsApp, etc.), application category, traffic direction, bytes in/out, flow start/end, DSCP marking, QoS policy applied, zero-rating eligibility flag, throttle action, and policy enforcement action. Serves as the unified record for traffic analytics, content billing, zero-rating validation, application-aware policy enforcement, fair-use throttling evidence, lawful intercept feeds, and network planning. Replaces legacy separate IPDR and DPI session stores with a single SSOT.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`usage`.`content_consumption` (
    `content_consumption_id` BIGINT COMMENT 'Unique identifier for the content consumption event record. Primary key.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Content consumption (IPTV, VOD, streaming) is a billable service requiring billing account linkage for charging, bundling with telecom services, and consolidated invoicing.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise content services (corporate training videos, business streaming, digital signage) need corporate account linkage for billing, usage reporting, and license compliance tracking in B2B telecom',
    `device_registration_id` BIGINT COMMENT 'Unique identifier of the device used for consumption (IMEI, MAC address, device serial number). Trackable to subscriber.',
    `entitlement_id` BIGINT COMMENT 'Reference to the DRM entitlement or license that authorized this content consumption. Used for rights validation and audit.',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to order.fulfillment_order. Business justification: Links content/IPTV consumption to provisioning order. Validates successful activation of digital entertainment services ordered (first stream = service works), enables quality validation (buffering vs',
    `license_id` BIGINT COMMENT 'Identifier of the content license agreement under which this consumption occurred. Used for licensing cost allocation and royalty calculation.',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to content.ott_platform. Business justification: Required for partner revenue share calculations, platform-specific QoS reporting, and OTT partnership performance tracking. Telcos must reconcile consumption events to platform agreements for billing ',
    `partner_id` BIGINT COMMENT 'Identifier of the content provider or OTT partner who owns the content asset. Used for revenue sharing and licensing cost allocation.',
    `pipeline_run_id` BIGINT COMMENT 'Foreign key linking to analytics.pipeline_run. Business justification: Content usage events mediated via pipelines. Operational troubleshooting of content billing discrepancies, zero-rating validation, and CDN performance analysis require pipeline run context for data li',
    `rate_plan_id` BIGINT COMMENT 'Foreign key linking to billing.rate_plan. Business justification: Content consumption is rated per rate plan (bundled content, zero-rated streaming, premium tiers). Rate plan determines whether content is included, charged separately, or zero-rated.',
    `roaming_partner_id` BIGINT COMMENT 'Identifier of the roaming partner network if the subscriber was roaming. Null for non-roaming sessions.',
    `data_session_id` BIGINT COMMENT 'Unique identifier for the streaming or viewing session. Used to correlate multiple events within a single consumption session.',
    `slice_id` BIGINT COMMENT 'Foreign key linking to network.network_slice. Business justification: 5G content streaming (video, gaming) uses dedicated network slices with guaranteed SLAs (latency, throughput). Slice ID enables slice performance analysis, tenant-specific SLA validation, usage-based ',
    `subscriber_id` BIGINT COMMENT 'Identifier of the subscriber who consumed the content. Links to the subscriber master record.',
    `package_id` BIGINT COMMENT 'Identifier of the subscription package or content entitlement that authorized this consumption. Null for pay-per-view or rental.',
    `svc_instance_id` BIGINT COMMENT 'Foreign key linking to service.svc_instance. Business justification: Content consumption events need service instance context for entitlement validation, billing, service analytics, and zero-rating eligibility determination. Essential for digital entertainment service ',
    `vod_asset_id` BIGINT COMMENT 'Unique identifier of the digital content asset consumed (VOD title, live channel, music track, podcast episode).',
    `bitrate_kbps` STRING COMMENT 'Average bitrate of the streamed content in kilobits per second. Indicates stream quality and bandwidth consumption rate.',
    `buffering_events_count` STRING COMMENT 'Number of buffering or rebuffering events during the session. Key QoS indicator for subscriber experience.',
    `bytes_consumed` BIGINT COMMENT 'Total number of bytes transferred during the content consumption session. Used for data usage tracking and zero-rating validation.',
    `cdn_node_code` STRING COMMENT 'Identifier of the CDN edge node that served the content. Used for CDN performance analysis and cost allocation.',
    `charging_reference` STRING COMMENT 'Unique identifier linking this consumption event to the real-time rating and charging system. Used for revenue assurance reconciliation.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of content consumed relative to total content duration (0.00 to 100.00). Indicates viewer engagement and content quality.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this content consumption record was first created in the lakehouse. Used for audit and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the rated amount. Null if no charge applied.. Valid values are `^[A-Z]{3}$`',
    `device_type` STRING COMMENT 'Type of device used for content consumption (e.g., Smart TV, Smartphone, Tablet, STB, Desktop). Used for device-specific QoS analysis.',
    `error_code` STRING COMMENT 'Error code if the session encountered a failure or abnormal termination. Null for successful sessions.',
    `error_description` STRING COMMENT 'Human-readable description of the error encountered during the session. Null for successful sessions.',
    `event_status` STRING COMMENT 'Current status of the content consumption event in the usage processing lifecycle.. Valid values are `Completed|In Progress|Failed|Abandoned`',
    `geographic_location` STRING COMMENT 'Geographic location (country, region, or city) from which the content was consumed. Used for geo-restriction compliance and regional analytics.',
    `ip_address` STRING COMMENT 'IP address of the device or session from which content was consumed. May be considered PII in some jurisdictions.',
    `mediation_timestamp` TIMESTAMP COMMENT 'Timestamp when this usage event was processed by the mediation system. Used for data lineage and reconciliation.',
    `network_type` STRING COMMENT 'Type of network access technology used during content consumption. Critical for QoS analysis and network capacity planning.. Valid values are `5G|LTE|3G|WiFi|Fixed Broadband|FTTH`',
    `parental_control_rating` STRING COMMENT 'Age or content rating of the consumed content (e.g., G, PG, PG-13, R, TV-MA). Used for parental control compliance and content filtering.',
    `rated_amount` DECIMAL(18,2) COMMENT 'Monetary amount charged for this content consumption event after rating. Null if zero-rated or included in subscription.',
    `roaming_flag` BOOLEAN COMMENT 'Indicates whether the subscriber was roaming during content consumption. Impacts rating and interconnect settlement.',
    `session_duration_seconds` BIGINT COMMENT 'Total duration of the content consumption session in seconds. Calculated from start to end timestamp or last heartbeat.',
    `session_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the content consumption session ended. Null if session is still active or was abnormally terminated.',
    `session_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the content consumption session began. Represents the actual business event time when the subscriber initiated playback.',
    `source_system` STRING COMMENT 'Name or identifier of the source system that generated this usage event (IPTV platform, OTT app, DPI system).',
    `stream_quality` STRING COMMENT 'Video or audio quality level of the streamed content. Impacts bandwidth consumption and QoS metrics.. Valid values are `SD|HD|Full HD|4K|8K|Auto`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this content consumption record was last updated. Used for audit and change tracking.',
    `zero_rated_flag` BOOLEAN COMMENT 'Indicates whether this content consumption was zero-rated (data usage not charged to subscriber). Used for zero-rating policy validation and revenue assurance.',
    CONSTRAINT pk_content_consumption PRIMARY KEY(`content_consumption_id`)
) COMMENT 'Digital content and OTT/IPTV consumption event record capturing subscriber content viewing/streaming sessions — content asset ID, content type (VOD, live TV, podcast, music), platform (IPTV, OTT app, web), stream quality (SD/HD/4K), bytes consumed, session duration, device type, DRM entitlement reference, and completion percentage. Feeds content licensing cost allocation and zero-rating policy validation.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`usage`.`mediation_event` (
    `mediation_event_id` BIGINT COMMENT 'Unique identifier for the mediation event record. Primary key for tracking each raw usage event through the mediation lifecycle from collection to delivery.',
    `carrier_id` BIGINT COMMENT 'Identifier of the visited network operator where roaming usage occurred. Used for inter-operator settlement and TAP file reconciliation.',
    `dq_execution_result_id` BIGINT COMMENT 'Foreign key linking to analytics.dq_execution_result. Business justification: Mediation events are primary target of DQ validation (normalization checks, enrichment validation). Linking to execution results enables rejection analysis, troubleshooting mediation failures, and qua',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Mediation platforms track which telecom engineer manually intervened on failed/rejected CDRs for revenue assurance, dispute resolution, and audit compliance. Standard operational workflow in telco med',
    `element_id` BIGINT COMMENT 'Identifier of the source network element that generated the raw usage record (e.g., MSC, SGSN, GGSN, P-GW, OLT, BNG). Critical for tracing usage back to originating infrastructure.',
    `pipeline_run_id` BIGINT COMMENT 'Foreign key linking to analytics.pipeline_run. Business justification: Mediation events are generated BY pipeline runs - this is core operational lineage. Troubleshooting mediation failures, rejection analysis, and reprocessing workflows require linking each mediation ev',
    `ran_cell_id` BIGINT COMMENT 'Identifier of the cell tower or base station serving the usage event. Used for location-based rating, network performance analysis, and regulatory compliance.',
    `cdr_id` BIGINT COMMENT 'Reference to the original raw usage event record (CDR, IPDR, TAP, or DPI session) collected from the network element before mediation processing.',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber who generated this usage event. Links mediation event to customer account for rating and billing.',
    `trouble_ticket_id` BIGINT COMMENT 'Foreign key linking to assurance.trouble_ticket. Business justification: Mediation failures (rejected CDRs, validation errors, rating exceptions) trigger trouble tickets for revenue assurance teams to investigate and resolve. Operational process requires linking mediation ',
    `vod_asset_id` BIGINT COMMENT 'Identifier of the content asset consumed during the usage event (VOD title, IPTV channel, OTT stream). Applicable to content consumption events.',
    `acknowledgement_timestamp` TIMESTAMP COMMENT 'Timestamp when the downstream system acknowledged receipt of the mediated event. Used for end-to-end SLA monitoring and gap detection.',
    `apn` STRING COMMENT 'Access Point Name identifying the data network gateway used for the data session. Determines service type, QoS policy, and rating rules.',
    `called_party` STRING COMMENT 'Phone number or identifier of the party receiving the usage event (B-party). Applicable to voice, SMS, and MMS events.',
    `calling_party` STRING COMMENT 'Phone number or identifier of the party initiating the usage event (A-party). Applicable to voice, SMS, and MMS events.',
    `collection_timestamp` TIMESTAMP COMMENT 'Timestamp when the raw usage record was collected from the network element by the mediation system. Represents the start of the mediation lifecycle.',
    `data_volume_bytes` BIGINT COMMENT 'Total data volume transferred during the usage event in bytes (upload + download). Applicable to data sessions, IPDR, and DPI records.',
    `delivery_acknowledgement_flag` BOOLEAN COMMENT 'Flag indicating whether the downstream system acknowledged successful receipt and processing of the mediated event. Critical for end-to-end usage processing completeness.',
    `delivery_timestamp` TIMESTAMP COMMENT 'Timestamp when the rated usage event was successfully delivered to downstream billing, revenue assurance, or analytics systems.',
    `download_bytes` BIGINT COMMENT 'Data volume downloaded by the subscriber during the usage event in bytes. Used for asymmetric rating and QoS analysis.',
    `downstream_system_code` STRING COMMENT 'Identifier of the downstream system (rating engine, billing system, revenue assurance platform) to which the mediated event was delivered.',
    `duration_seconds` STRING COMMENT 'Duration of the usage event in seconds. Applicable to voice calls, data sessions, and streaming content consumption.',
    `enrichment_timestamp` TIMESTAMP COMMENT 'Timestamp when the normalized record was enriched with subscriber, product, and network reference data. Tracks mediation processing latency.',
    `event_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the usage event occurred in the network (call start, data session start, SMS sent). Distinct from collection timestamp.',
    `imei` STRING COMMENT 'International Mobile Equipment Identity uniquely identifying the device hardware. Used for device-based rating, fraud detection, and CPE validation.. Valid values are `^[0-9]{15}$`',
    `imsi` STRING COMMENT 'International Mobile Subscriber Identity uniquely identifying the subscribers SIM card. Used for subscriber lookup and roaming validation during mediation.. Valid values are `^[0-9]{15}$`',
    `location_area_code` STRING COMMENT 'Location Area Code identifying the geographic region where the usage event occurred. Used for zone-based rating and regulatory reporting.',
    `manual_review_queue` STRING COMMENT 'Identifier of the manual review queue to which this rejected event was assigned for human investigation and resolution.',
    `mediation_node_code` STRING COMMENT 'Identifier of the mediation platform node that processed this event. Used for load balancing analysis and troubleshooting mediation bottlenecks.',
    `msisdn` STRING COMMENT 'Mobile phone number of the subscriber in E.164 format. Primary customer-facing identifier for usage attribution and billing.. Valid values are `^[0-9]{10,15}$`',
    `network_element_type` STRING COMMENT 'Type of network element that generated the usage event. Determines mediation processing rules and validation logic. [ENUM-REF-CANDIDATE: MSC|SGSN|GGSN|P-GW|S-GW|OLT|BNG|BRAS|IMS|PCRF|DPI|TAP — 12 candidates stripped; promote to reference product]',
    `normalization_timestamp` TIMESTAMP COMMENT 'Timestamp when the raw usage record was normalized into standard mediation format. Tracks mediation processing latency.',
    `processing_status` STRING COMMENT 'Current status of the mediation event in the processing lifecycle. Tracks progression from collection through normalization, enrichment, validation, rating, and delivery to downstream systems. [ENUM-REF-CANDIDATE: collected|normalized|enriched|validated|rated|rejected|reprocessed|delivered — 8 candidates stripped; promote to reference product]',
    `qos_class` STRING COMMENT 'Quality of Service class assigned to the usage event (e.g., QCI 1-9 for LTE). Affects rating, prioritization, and SLA compliance tracking.',
    `rating_timestamp` TIMESTAMP COMMENT 'Timestamp when the validated usage event was rated and priced by the rating engine. Marks completion of mediation processing before delivery.',
    `rejection_category` STRING COMMENT 'High-level category of rejection reason for reporting and root cause analysis. Groups detailed rejection codes into actionable categories. [ENUM-REF-CANDIDATE: duplicate|missing_mandatory_field|format_error|out_of_sequence|future_dated|unknown_subscriber|invalid_imsi|invalid_network_element|business_rule_violation — 9 candidates stripped; promote to reference product]',
    `rejection_description` STRING COMMENT 'Detailed human-readable description of why the mediation event was rejected. Provides context for manual review and resolution.',
    `rejection_flag` BOOLEAN COMMENT 'Flag indicating whether the mediation event was rejected during processing due to validation failures, missing data, or business rule violations.',
    `rejection_reason_code` STRING COMMENT 'Standardized code identifying the specific reason for mediation rejection (e.g., DUP-001 for duplicate, MAN-002 for missing mandatory field, FMT-003 for format error).',
    `reprocessing_history` STRING COMMENT 'Audit trail of all reprocessing attempts including timestamps, actions taken, and outcomes. Critical for regulatory audit trails and revenue assurance investigations.',
    `resolution_outcome` STRING COMMENT 'Final outcome of the rejection resolution process. Indicates whether the event was corrected and reprocessed, permanently rejected, or written off as unrecoverable.. Valid values are `auto_corrected|manually_resolved|permanently_rejected|written_off|pending_review`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Timestamp when the rejected event was resolved (either successfully reprocessed or permanently rejected). Used for SLA tracking and revenue leakage analysis.',
    `retry_count` STRING COMMENT 'Number of times the mediation system attempted to reprocess this event after initial rejection. Used for retry policy enforcement and escalation.',
    `retry_eligible_flag` BOOLEAN COMMENT 'Flag indicating whether the rejected event is eligible for automatic retry or requires manual intervention. Based on rejection category and business rules.',
    `roaming_indicator` BOOLEAN COMMENT 'Flag indicating whether the usage event occurred while the subscriber was roaming on a partner network. Triggers roaming-specific rating and TAP/NRTRDE processing.',
    `service_type` STRING COMMENT 'Specific service classification for the usage event (e.g., LTE data, VoLTE, international roaming, premium SMS). More granular than usage_type for rating precision.',
    `upload_bytes` BIGINT COMMENT 'Data volume uploaded by the subscriber during the usage event in bytes. Used for asymmetric rating and QoS analysis.',
    `usage_type` STRING COMMENT 'Category of usage event being mediated (voice call, SMS, data session, MMS, roaming, content consumption, IPTV, VOD). Determines rating rules and revenue allocation. [ENUM-REF-CANDIDATE: voice|sms|data|mms|roaming|content|iptv|vod — 8 candidates stripped; promote to reference product]',
    `validation_timestamp` TIMESTAMP COMMENT 'Timestamp when the enriched record passed business rule validation (mandatory field checks, format validation, duplicate detection). Tracks mediation processing latency.',
    `visited_network_code` STRING COMMENT 'Public Land Mobile Network (PLMN) code of the visited network during roaming. Combination of MCC (Mobile Country Code) and MNC (Mobile Network Code).. Valid values are `^[0-9]{5,6}$`',
    CONSTRAINT pk_mediation_event PRIMARY KEY(`mediation_event_id`)
) COMMENT 'Mediation layer processing lifecycle record tracking each raw usage event from network collection through normalization, enrichment, duplicate detection, validation, rejection handling, and delivery to downstream rating engines. Captures source network element, collection timestamp, raw record reference, mediation node ID, processing status (collected, normalized, enriched, validated, rated, rejected, reprocessed), rejection reason code and category (duplicate, missing mandatory field, format error, out-of-sequence, future-dated, unknown subscriber, invalid IMSI), retry count, retry eligibility flag, manual review queue assignment, resolution outcome (auto-corrected, manually resolved, permanently rejected, written off), reprocessing history, and downstream system delivery confirmation with acknowledgement timestamp. This is the single authoritative record for ALL mediation outcomes including rejections — no separate rejection entity exists. Critical for revenue assurance gap detection, mediation SLA monitoring, and regulatory audit trails demonstrating usage processing completeness.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`usage`.`balance` (
    `balance_id` BIGINT COMMENT 'Unique identifier for the usage balance record. Primary key for the usage balance entity.',
    `analytics_segment_membership_id` BIGINT COMMENT 'Foreign key linking to analytics.segment_membership. Business justification: Real-time balance monitoring and threshold alerts are segmented by customer segment. Linking balance records to segment membership enables segment-specific balance analytics, targeted top-up campaigns',
    `billing_account_id` BIGINT COMMENT 'Reference to the billing account associated with this usage balance. Links to the billing account master record.',
    `bundle_subscription_id` BIGINT COMMENT 'Reference to the specific bundle instance this balance tracks. Links to the bundle or rate plan instance.',
    `rated_event_id` BIGINT COMMENT 'Identifier of the most recent consumption event. Links to the detailed usage event record for audit purposes.',
    `prepaid_balance_id` BIGINT COMMENT 'Foreign key linking to billing.prepaid_balance. Business justification: Hybrid prepaid-postpaid scenarios require usage_balance (postpaid bundles) to reference prepaid_balance for unified balance management, cross-bucket consumption, and account migration.',
    `rate_plan_id` BIGINT COMMENT 'Foreign key linking to billing.rate_plan. Business justification: Usage balances (voice/SMS/data buckets) are defined by rate plan. Rate plan specifies initial balance, rollover rules, expiry, and top-up eligibility for postpaid bundles.',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber who owns this usage balance. Links to the subscriber master record.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this balance automatically renews at the end of the period. Defines renewal policy.',
    `balance_status` STRING COMMENT 'Current lifecycle status of the usage balance. Indicates whether the balance is available for consumption.. Valid values are `active|suspended|expired|depleted|throttled|terminated`',
    `balance_type` STRING COMMENT 'Type of usage balance being tracked. Categorizes the balance by service type.. Valid values are `voice|sms|data|content|monetary`',
    `bundle_name` STRING COMMENT 'Human-readable name of the bundle or allowance package this balance represents.',
    `charging_system_source` STRING COMMENT 'Source system that generated or updated this balance record. Identifies the authoritative charging platform.. Valid values are `ocs|prepaid_platform|rating_engine|mediation_system`',
    `consumed_quantity` DECIMAL(18,2) COMMENT 'Total quantity consumed from the balance during the current period. Aggregated from all consumption events.',
    `consumption_percentage` DECIMAL(18,2) COMMENT 'Percentage of the initial balance that has been consumed. Calculated as (consumed / initial) * 100.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this usage balance record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for monetary balances. Only applicable when balance_type is monetary.. Valid values are `^[A-Z]{3}$`',
    `fair_usage_policy_flag` BOOLEAN COMMENT 'Indicates whether this balance is subject to fair usage policy restrictions that may limit consumption.',
    `fair_usage_threshold` DECIMAL(18,2) COMMENT 'Consumption threshold defined by fair usage policy. Beyond this limit, restrictions or throttling may apply.',
    `group_code` STRING COMMENT 'Identifier for the group of subscribers sharing this balance. Only populated when shared_balance_flag is true.',
    `initial_balance_quantity` DECIMAL(18,2) COMMENT 'The starting quantity of the balance at the beginning of the period. Represents the total allowance granted.',
    `last_consumption_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent consumption event that affected this balance. Used for real-time balance queries.',
    `last_top_up_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent top-up or recharge event that added to this balance.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this usage balance record was last modified. Tracks the most recent balance update.',
    `network_type` STRING COMMENT 'Type of network technology this balance applies to. Distinguishes between mobile generations and fixed services.. Valid values are `2g|3g|4g_lte|5g_nr|wifi|fixed_line`',
    `notification_threshold_1` DECIMAL(18,2) COMMENT 'First consumption percentage threshold that triggers a balance notification to the subscriber.',
    `notification_threshold_2` DECIMAL(18,2) COMMENT 'Second consumption percentage threshold that triggers a balance notification to the subscriber.',
    `overage_flag` BOOLEAN COMMENT 'Indicates whether the subscriber has exceeded the allocated balance and is incurring overage charges.',
    `overage_quantity` DECIMAL(18,2) COMMENT 'Quantity consumed beyond the allocated balance. Only populated when overage_flag is true.',
    `period_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the current balance period ends or expires. After this time, unused balance may be forfeited.',
    `period_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the current balance period began. Marks the start of the billing or bundle cycle.',
    `priority_level` STRING COMMENT 'Priority order for balance consumption when multiple balances are available. Lower numbers indicate higher priority.',
    `remaining_quantity` DECIMAL(18,2) COMMENT 'Current remaining quantity available in the balance. Calculated as initial minus consumed.',
    `roaming_flag` BOOLEAN COMMENT 'Indicates whether this balance applies to roaming usage. Distinguishes between national and roaming allowances.',
    `rollover_flag` BOOLEAN COMMENT 'Indicates whether unused balance can roll over to the next period. Defines balance carryover policy.',
    `rollover_quantity` DECIMAL(18,2) COMMENT 'Quantity of balance rolled over from the previous period. Only populated when rollover_flag is true.',
    `service_type` STRING COMMENT 'Specific service category this balance applies to. May include subcategories like national data, international voice, premium SMS.',
    `shared_balance_flag` BOOLEAN COMMENT 'Indicates whether this balance is shared across multiple subscribers or devices in a family or corporate plan.',
    `snapshot_timestamp` TIMESTAMP COMMENT 'Timestamp when this balance snapshot was captured. Represents the point-in-time state of the balance.',
    `throttle_action` STRING COMMENT 'Description of the throttling action applied when threshold is reached. May include speed reduction details or service restrictions.',
    `throttle_status` STRING COMMENT 'Current throttling state of the balance. Indicates whether service speed or quality has been reduced due to consumption.. Valid values are `not_throttled|throttled|pending_throttle`',
    `throttle_threshold_quantity` DECIMAL(18,2) COMMENT 'The consumption level at which throttling or speed reduction is triggered. Typically a percentage of initial balance.',
    `top_up_count` STRING COMMENT 'Number of top-up or recharge events that have added to this balance during the current period.',
    `unit_of_measure` STRING COMMENT 'Unit in which the balance quantity is measured. Defines how to interpret the quantity values. [ENUM-REF-CANDIDATE: minutes|seconds|sms_units|bytes|megabytes|gigabytes|credits|currency_units — 8 candidates stripped; promote to reference product]',
    `zero_rated_flag` BOOLEAN COMMENT 'Indicates whether this balance tracks zero-rated usage that does not count against subscriber allowances.',
    CONSTRAINT pk_balance PRIMARY KEY(`balance_id`)
) COMMENT 'Real-time subscriber usage balance and bundle consumption tracking record — the single authoritative source for current-state balance snapshots AND event-level consumption/deduction history across all bundle types. Tracks voice minutes, SMS units, data bytes (national/roaming/zero-rated), content credits, and add-on bundle balances. Captures balance at period start, consumed units per bundle instance, remaining units, overage flag/units, throttle threshold and status, bundle instance reference, bundle expiry date, last consumption event timestamp, per-event deduction history with full granularity, throttle trigger actions, and bundle lifecycle state. Sourced from real-time charging systems (OCS/Comverse ONE) and batch rating engines. Serves as the authoritative record for real-time balance queries, bundle consumption audit, prepaid top-up reconciliation, historical consumption analysis, and per-bundle allowance tracking. Consolidates both snapshot and transactional consumption views — no separate bundle consumption entity exists.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` (
    `aggregated_usage_id` BIGINT COMMENT 'Unique identifier for the aggregated usage record. Primary key for this operational summary entity.',
    `analytics_segment_membership_id` BIGINT COMMENT 'Foreign key linking to analytics.segment_membership. Business justification: Aggregated usage is primary input to segment assignment models. Linking enables segment performance analysis, model validation, and segment-specific usage pattern analysis for marketing and network pl',
    `billing_account_id` BIGINT COMMENT 'Reference to the billing account under which this usage will be charged. Links to billing account master.',
    `billing_cycle_id` BIGINT COMMENT 'The billing cycle identifier (e.g., 2024-01, cycle 202401) to which this aggregated usage belongs. Used for invoice generation alignment.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Aggregated usage must be attributed to legal entities for financial consolidation, regulatory reporting, and multi-entity telco group revenue recognition. Essential for IFRS 15 compliance and inter-co',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise aggregated usage summaries must link to corporate accounts for monthly billing cycles, invoice line item generation, and executive-level usage dashboards in B2B telecommunications operation',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to order.fulfillment_order. Business justification: Links aggregated usage to provisioning order. Enables lifecycle revenue attribution (revenue generated from this order), service quality validation against order commitments (usage patterns vs. ordere',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Aggregated usage summaries directly support invoice generation for billing cycles. Link required for invoice drill-down, usage detail reports, and billing dispute resolution.',
    `iot_deployment_id` BIGINT COMMENT 'Foreign key linking to enterprise.iot_deployment. Business justification: Aggregated IoT usage must link to deployments for monthly billing, fleet-level analytics, data plan compliance monitoring, and executive reporting in enterprise IoT telecommunications operations.',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Aggregated usage must link to managed service instances for service-level billing, performance reporting, and SLA compliance tracking in enterprise managed connectivity and voice services.',
    `pipeline_run_id` BIGINT COMMENT 'Foreign key linking to analytics.pipeline_run. Business justification: Aggregated usage is OUTPUT of aggregation pipelines. Linking to the pipeline run that created each aggregation record is fundamental operational lineage for troubleshooting billing discrepancies and r',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: Aggregated usage summaries must reference the price plan to correctly apply billing cycle allowances, overage thresholds, and proration rules. Required for invoice generation and customer bill present',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Aggregated usage statistics are the primary data source for regulatory reports on network performance, service quality, market share, and consumer usage patterns. Regulators require periodic submissio',
    `retention_model_output_id` BIGINT COMMENT 'Foreign key linking to analytics.retention_model_output. Business justification: Aggregated usage is primary feature input to churn models. Linking enables model explainability (which usage patterns drove churn score), feature validation, and model performance monitoring for reten',
    `sla_breach_event_id` BIGINT COMMENT 'Foreign key linking to assurance.sla_breach_event. Business justification: SLA breaches for contracted data/voice thresholds are detected by comparing aggregated usage against service level commitments. Breach events must reference the usage aggregation period that triggered',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber for whom usage is aggregated. Links to the subscriber master entity.',
    `svc_instance_id` BIGINT COMMENT 'Reference to the specific service instance (mobile line, broadband connection, IPTV subscription) for which usage is aggregated.',
    `aggregation_end_timestamp` TIMESTAMP COMMENT 'The end date and time of the aggregation period. Defines the close of the usage window being summarized.',
    `aggregation_period_type` STRING COMMENT 'The time granularity at which usage is aggregated: daily summary, weekly rollup, monthly billing cycle, or custom period.. Valid values are `daily|weekly|monthly|billing_cycle|real_time|custom`',
    `aggregation_start_timestamp` TIMESTAMP COMMENT 'The start date and time of the aggregation period. Defines the beginning of the usage window being summarized.',
    `aggregation_status` STRING COMMENT 'Current processing status of this aggregated usage record: pending initial aggregation, completed and ready for billing, failed validation, or reprocessing.. Valid values are `pending|completed|failed|reprocessing`',
    `content_streaming_hours` DECIMAL(18,2) COMMENT 'Total hours of video/audio streaming content consumed (IPTV, OTT, VoD) during the aggregation period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this aggregated usage record was first created in the system.',
    `data_volume_mb_2g` DECIMAL(18,2) COMMENT 'Total data consumed in megabytes over 2G Radio Access Network (RAN) during the aggregation period.',
    `data_volume_mb_3g` DECIMAL(18,2) COMMENT 'Total data consumed in megabytes over 3G Radio Access Network (RAN) during the aggregation period.',
    `data_volume_mb_4g_lte` DECIMAL(18,2) COMMENT 'Total data consumed in megabytes over 4G LTE Radio Access Network (RAN) during the aggregation period.',
    `data_volume_mb_5g` DECIMAL(18,2) COMMENT 'Total data consumed in megabytes over 5G NR Radio Access Network (RAN) during the aggregation period.',
    `data_volume_mb_roaming` DECIMAL(18,2) COMMENT 'Total data consumed in megabytes while roaming on partner networks during the aggregation period.',
    `data_volume_mb_wifi_offload` DECIMAL(18,2) COMMENT 'Total data consumed in megabytes via Wi-Fi offload (carrier-managed hotspots) during the aggregation period.',
    `dpi_category_gaming_mb` DECIMAL(18,2) COMMENT 'Data volume attributed to gaming applications via DPI classification during the aggregation period.',
    `dpi_category_other_mb` DECIMAL(18,2) COMMENT 'Data volume attributed to other/unclassified applications via DPI classification during the aggregation period.',
    `dpi_category_social_media_mb` DECIMAL(18,2) COMMENT 'Data volume attributed to social media applications via DPI classification during the aggregation period.',
    `dpi_category_video_streaming_mb` DECIMAL(18,2) COMMENT 'Data volume attributed to video streaming applications via DPI classification during the aggregation period.',
    `fair_use_policy_threshold_exceeded` BOOLEAN COMMENT 'Boolean flag indicating whether the subscriber exceeded the fair use policy threshold during this aggregation period.',
    `iptv_viewing_hours` DECIMAL(18,2) COMMENT 'Total hours of IPTV live and time-shifted television viewing during the aggregation period.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this aggregated usage record was last modified or reprocessed.',
    `mediation_source_system` STRING COMMENT 'Identifier of the mediation system or collection platform that sourced the raw CDR/IPDR records for this aggregation.',
    `offpeak_usage_mb` DECIMAL(18,2) COMMENT 'Data volume consumed during off-peak hours (nights, weekends) in megabytes.',
    `overage_data_mb` DECIMAL(18,2) COMMENT 'Data volume consumed beyond the subscribers plan allowance (overage) in megabytes during the aggregation period.',
    `overage_sms_count` BIGINT COMMENT 'SMS messages sent beyond the subscribers plan allowance (overage) during the aggregation period.',
    `overage_voice_minutes` DECIMAL(18,2) COMMENT 'Voice minutes consumed beyond the subscribers plan allowance (overage) during the aggregation period.',
    `peak_usage_mb` DECIMAL(18,2) COMMENT 'Data volume consumed during peak hours (as defined by network policy, typically business hours) in megabytes.',
    `revenue_assurance_flag` STRING COMMENT 'Revenue assurance status flag indicating whether this aggregated usage record passed validation checks or has anomalies requiring investigation.. Valid values are `clean|anomaly_detected|under_review|reconciled`',
    `roaming_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the primary roaming destination during the aggregation period (if applicable).. Valid values are `^[A-Z]{3}$`',
    `roaming_partner_network_code` STRING COMMENT 'Identifier of the roaming partner network (PLMN ID or partner code) where the majority of roaming usage occurred.',
    `sms_count_international` BIGINT COMMENT 'Total number of SMS messages sent to international destinations during the aggregation period.',
    `sms_count_offnet` BIGINT COMMENT 'Total number of SMS messages sent to off-net destinations during the aggregation period.',
    `sms_count_onnet` BIGINT COMMENT 'Total number of SMS messages sent to on-net destinations during the aggregation period.',
    `sms_count_roaming` BIGINT COMMENT 'Total number of SMS messages sent while roaming during the aggregation period.',
    `throttling_applied` BOOLEAN COMMENT 'Boolean flag indicating whether data throttling (speed reduction) was applied to the subscriber during this period due to policy enforcement.',
    `total_session_count` BIGINT COMMENT 'Total number of data sessions (PDP contexts, PDN connections) initiated during the aggregation period.',
    `unique_cell_tower_count` STRING COMMENT 'Number of unique cell towers (eNodeB, gNodeB) the subscriber connected to during the aggregation period. Indicator of mobility.',
    `vod_rental_count` BIGINT COMMENT 'Total number of VoD rentals (pay-per-view events) during the aggregation period.',
    `voice_minutes_international` DECIMAL(18,2) COMMENT 'Total voice call minutes to international destinations during the aggregation period.',
    `voice_minutes_offnet` DECIMAL(18,2) COMMENT 'Total voice call minutes to destinations outside the network (off-net, other carriers) during the aggregation period.',
    `voice_minutes_onnet` DECIMAL(18,2) COMMENT 'Total voice call minutes to destinations within the same network (on-net) during the aggregation period.',
    `voice_minutes_roaming` DECIMAL(18,2) COMMENT 'Total voice call minutes made while roaming on partner networks during the aggregation period.',
    CONSTRAINT pk_aggregated_usage PRIMARY KEY(`aggregated_usage_id`)
) COMMENT 'Pre-aggregated periodic usage summary at the subscriber-service-period grain (daily, weekly, monthly billing cycle) — total voice minutes, SMS count, data MB consumed (split by RAT type), roaming usage by service, content hours, overage amounts, and peak/off-peak breakdowns. This is the Silver-layer operational aggregation used as direct input to invoice line generation, ARPU/AMPU calculation feeds, fair-use policy threshold evaluation, and regulatory usage reporting. NOT a BI/analytics cube — it is the authoritative operational summary feeding billing and policy systems.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`usage`.`anomaly` (
    `anomaly_id` BIGINT COMMENT 'Unique identifier for the usage anomaly record. Primary key.',
    `adjustment_id` BIGINT COMMENT 'Foreign key linking to billing.adjustment. Business justification: Usage anomalies often result in billing adjustments (credits for overcharges, corrections). Direct link required for resolution tracking, audit trail, and revenue assurance reporting.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Usage anomalies trigger compliance audit findings in revenue assurance audits, fraud control audits, and billing accuracy reviews. Auditors trace findings back to specific anomaly records for root cau',
    `billing_dispute_id` BIGINT COMMENT 'Foreign key linking to billing.dispute. Business justification: Usage anomalies (unexpected charges, fraud, rating errors) frequently trigger billing disputes. Direct link required for dispute investigation, evidence gathering, and resolution tracking.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to interconnect.interconnect_carrier. Business justification: Revenue assurance and fraud detection on roaming traffic require carrier identification for dispute escalation, pattern analysis across carriers, and regulatory reporting. Network codes are denormaliz',
    `cdr_id` BIGINT COMMENT 'Reference to the source CDR, IPDR, or usage event record that triggered this anomaly detection.',
    `detection_rule_id` BIGINT COMMENT 'Identifier of the revenue assurance or mediation rule that triggered the anomaly detection.',
    `dq_issue_id` BIGINT COMMENT 'Foreign key linking to analytics.dq_issue. Business justification: Usage anomalies detected by revenue assurance often trigger formal DQ issues for investigation. This link enables closed-loop anomaly management, tracking remediation actions, and preventing revenue l',
    `employee_id` BIGINT COMMENT 'User ID or team identifier of the revenue assurance analyst or fraud investigator assigned to this anomaly.',
    `rated_event_id` BIGINT COMMENT 'Foreign key linking to billing.rated_event. Business justification: Usage anomalies (revenue leakage, fraud, rating errors) are often detected on rated events. Direct link required for investigation, re-rating, and revenue assurance workflows.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Significant usage anomalies (fraud patterns, revenue leakage, billing errors) must be disclosed in regulatory filings for consumer protection, financial reporting, and fraud prevention oversight. Regu',
    `retention_model_output_id` BIGINT COMMENT 'Foreign key linking to analytics.retention_model_output. Business justification: Usage anomalies (sudden drop in usage) are strong churn signals. Linking anomalies to retention model output enables model validation, early warning system integration, and proactive retention interve',
    `revenue_leakage_case_id` BIGINT COMMENT 'Foreign key linking to assurance.revenue_leakage_case. Business justification: Usage anomalies (unexpected traffic patterns, rating discrepancies, threshold deviations) are primary detection method for revenue leakage. Revenue assurance case investigation requires referencing th',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber associated with the anomalous usage event.',
    `actual_value` DECIMAL(18,2) COMMENT 'Actual observed value that deviated from the expected value and triggered the anomaly detection.',
    `affected_record_reference` STRING COMMENT 'External reference or identifier of the specific usage record that exhibited the anomaly (CDR sequence number, IPDR session ID, TAP file record number).',
    `anomaly_type` STRING COMMENT 'Classification of the detected anomaly: duplicate CDR (same record ingested multiple times), missing sequence (gap in CDR sequence numbers), volume spike (abnormal usage volume), zero duration call (call with zero or null duration), grey route indicator (suspected unauthorized routing), negative duration (invalid negative time value), invalid destination (malformed or non-existent destination number), roaming mismatch (roaming partner data inconsistency). [ENUM-REF-CANDIDATE: duplicate_cdr|missing_sequence|volume_spike|zero_duration_call|grey_route_indicator|negative_duration|invalid_destination|roaming_mismatch — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the usage anomaly record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the revenue impact amount.. Valid values are `^[A-Z]{3}$`',
    `detection_source_system` STRING COMMENT 'Name or identifier of the system that detected the anomaly (mediation platform, revenue assurance engine, fraud management system).',
    `detection_timestamp` TIMESTAMP COMMENT 'Timestamp when the anomaly was detected by the mediation or revenue assurance system.',
    `deviation_percentage` DECIMAL(18,2) COMMENT 'Percentage deviation between expected and actual values, used to quantify the magnitude of the anomaly.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the anomaly has been escalated to senior management or specialized fraud investigation teams (true) or handled at operational level (false).',
    `escalation_timestamp` TIMESTAMP COMMENT 'Timestamp when the anomaly was escalated to higher-level investigation or management.',
    `event_timestamp` TIMESTAMP COMMENT 'Original timestamp of the usage event that exhibited the anomaly (call start time, data session start, SMS timestamp).',
    `expected_value` DECIMAL(18,2) COMMENT 'Expected or baseline value for the attribute that triggered the anomaly (e.g., expected sequence number, typical volume range, standard duration threshold).',
    `investigation_status` STRING COMMENT 'Current workflow status of the anomaly investigation: new (detected, not yet assigned), assigned (assigned to analyst), in progress (under active investigation), resolved (root cause identified and corrected), closed (investigation complete), false positive (determined not to be a genuine anomaly).. Valid values are `new|assigned|in_progress|resolved|closed|false_positive`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the usage anomaly record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text notes and comments added by revenue assurance analysts during the investigation and resolution process.',
    `recurrence_flag` BOOLEAN COMMENT 'Indicates whether this anomaly is a recurring issue (true) or a one-time occurrence (false), used to prioritize systemic problems.',
    `reference_number` STRING COMMENT 'Business-facing unique reference number for the anomaly, used in revenue assurance and fraud investigation workflows.. Valid values are `^ANO-[0-9]{10}$`',
    `related_anomaly_count` STRING COMMENT 'Number of related or similar anomalies detected in the same time window or for the same subscriber, indicating potential systemic or fraud patterns.',
    `resolution_action` STRING COMMENT 'Description of the corrective action taken to resolve the anomaly (e.g., CDR reprocessed, duplicate removed, billing adjustment issued, partner notified, system configuration corrected).',
    `resolution_timestamp` TIMESTAMP COMMENT 'Timestamp when the anomaly investigation was resolved and corrective action completed.',
    `revenue_impact_amount` DECIMAL(18,2) COMMENT 'Estimated revenue impact (leakage or overcharge) resulting from the anomaly, in the billing currency.',
    `roaming_partner_code` STRING COMMENT 'Code identifying the roaming partner network involved in the usage event, applicable for roaming anomalies.',
    `root_cause_category` STRING COMMENT 'High-level category of the identified root cause: system error (software or hardware malfunction), data quality (incomplete or malformed data), partner issue (roaming or interconnect partner data problem), configuration error (incorrect system setup), fraud (suspected fraudulent activity), network issue (network element failure or misconfiguration).. Valid values are `system_error|data_quality|partner_issue|configuration_error|fraud|network_issue`',
    `root_cause_description` STRING COMMENT 'Detailed description of the identified root cause of the anomaly, documented during investigation.',
    `severity_level` STRING COMMENT 'Business impact severity of the anomaly: critical (immediate revenue or fraud risk), high (significant revenue leakage potential), medium (moderate impact requiring investigation), low (minor discrepancy with minimal impact).. Valid values are `critical|high|medium|low`',
    `usage_type` STRING COMMENT 'Type of usage event associated with the anomaly: voice (voice call), sms (short message service), data (mobile data session), mms (multimedia messaging), roaming (roaming usage event), content (IPTV or OTT content consumption).. Valid values are `voice|sms|data|mms|roaming|content`',
    CONSTRAINT pk_anomaly PRIMARY KEY(`anomaly_id`)
) COMMENT 'Operational record of detected usage anomalies flagged during mediation or revenue assurance processing — anomaly type (duplicate CDR, missing sequence, volume spike, zero-duration call, grey route indicator), detection timestamp, affected record reference, severity level, assigned investigation status, and resolution action. Feeds revenue assurance and fraud operations workflows without being an analytics construct.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`usage`.`roaming_file` (
    `roaming_file_id` BIGINT COMMENT 'Primary key for roaming_file',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Roaming file discrepancies are common audit findings in revenue assurance and interconnect settlement audits. Auditors trace validation errors, pricing discrepancies, and settlement disputes back to s',
    `carrier_agreement_id` BIGINT COMMENT 'Reference to the bilateral roaming agreement governing the commercial terms for this TAP file exchange.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: TAP/RAP files represent inter-carrier settlements that must be attributed to legal entity for accounts payable/receivable processing, financial reporting, and multi-entity consolidation in telecommuni',
    `mvno_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.mvno_agreement. Business justification: Roaming TAP files are processed under specific MVNO/wholesale agreements that define rates, SLAs, and settlement terms. Real business process: roaming settlement reconciliation matches TAP files to go',
    `pipeline_run_id` BIGINT COMMENT 'Foreign key linking to analytics.pipeline_run. Business justification: TAP/RAP file processing executed via pipelines. Linking files to their processing pipeline run enables operational monitoring, troubleshooting validation errors, and reprocessing failed roaming file b',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: TAP/RAP file processing in wholesale roaming requires operator assignment for validation, dispute handling, settlement reconciliation, and audit trails. Critical for inter-carrier billing accountabili',
    `rap_file_id` BIGINT COMMENT 'Reference to the associated RAP file record if a return file was generated for this TAP file.',
    `reconciliation_run_id` BIGINT COMMENT 'Foreign key linking to assurance.reconciliation_run. Business justification: TAP/RAP file reconciliation is core revenue assurance process validating roaming file completeness, accuracy, and settlement amounts against partner agreements. Reconciliation runs must reference the ',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: TAP files are exchanged with specific roaming partners for usage reconciliation and settlement. Critical for identifying which partner sent/received the file, dispute resolution, and revenue assurance',
    `acknowledgement_timestamp` TIMESTAMP COMMENT 'Date and time when the recipient operator sent formal acknowledgement (ACK) of successful file receipt and validation.',
    `call_event_count` BIGINT COMMENT 'Number of voice call events (Mobile Originated Calls and Mobile Terminated Calls) in the TAP file.',
    `clearing_house_name` STRING COMMENT 'Name of the roaming clearing house or data exchange platform used for file transmission (e.g., Syniverse, MACH, GRX) or Direct for bilateral exchange.. Valid values are `Syniverse|MACH|GRX|Direct`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this TAP file control record was first created in the usage data management system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in the TAP file (e.g., USD, EUR, GBP). Defined in the bilateral roaming agreement.. Valid values are `^[A-Z]{3}$`',
    `data_event_count` BIGINT COMMENT 'Number of mobile data session events (GPRS/LTE/5G data usage) in the TAP file.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the TAP file or any of its records are under dispute between the sending and receiving operators.',
    `dispute_reason_code` STRING COMMENT 'Standardized code indicating the reason for dispute if dispute_flag is true. Used for inter-operator dispute resolution.. Valid values are `rate_mismatch|duplicate_records|invalid_destination|missing_records|technical_error|other`',
    `file_available_timestamp` TIMESTAMP COMMENT 'Date and time when the TAP file was made available for retrieval by the recipient operator or clearing house.',
    `file_checksum` STRING COMMENT 'MD5 or SHA-256 hash of the TAP file used for integrity verification during transmission and receipt.. Valid values are `^[a-fA-F0-9]{32,64}$`',
    `file_compression_type` STRING COMMENT 'Compression algorithm applied to the TAP file for transmission efficiency (typically gzip per GSMA standard).. Valid values are `none|gzip|zip`',
    `file_generation_timestamp` TIMESTAMP COMMENT 'Date and time when the TAP file was generated by the sending operators mediation system.',
    `file_sequence_number` BIGINT COMMENT 'Sequential number assigned to the TAP file for ordering and tracking purposes within the bilateral exchange relationship.',
    `file_size_bytes` BIGINT COMMENT 'Size of the TAP file in bytes (compressed size if compression is applied).',
    `file_status` STRING COMMENT 'Current processing status of the TAP file in the roaming settlement workflow. Tracks file lifecycle from generation through final settlement. [ENUM-REF-CANDIDATE: generated|transmitted|received|validated|rejected|accepted|settled — 7 candidates stripped; promote to reference product]',
    `file_type_code` STRING COMMENT 'Type of roaming data exchange file. TAP3 = Transferred Account Procedure version 3 (standard roaming CDRs), RAP = Returned Account Procedure (rejections/returns), NRTRDE = Near Real-Time Roaming Data Exchange.. Valid values are `TAP3|RAP|NRTRDE`',
    `iot_tariff_applied` STRING COMMENT 'Identifier of the inter-operator tariff agreement applied to rate the usage events in this TAP file.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this TAP file control record was last updated, reflecting status changes or corrections.',
    `processing_notes` STRING COMMENT 'Free-text field for operational notes, special handling instructions, or comments related to TAP file processing and settlement.',
    `rap_file_generated_flag` BOOLEAN COMMENT 'Indicates whether a RAP file (rejection/return file) was generated in response to this TAP file due to validation failures or disputes.',
    `receipt_timestamp` TIMESTAMP COMMENT 'Date and time when the TAP file was received and acknowledged by the recipient operator or clearing house.',
    `recipient_tadig_code` STRING COMMENT 'Five-character TADIG code identifying the receiving mobile network operator. Format: 3-letter country code + 2-digit operator code.. Valid values are `^[A-Z]{3}[0-9]{2}$`',
    `sender_tadig_code` STRING COMMENT 'Five-character TADIG code identifying the sending mobile network operator. Format: 3-letter country code + 2-digit operator code.. Valid values are `^[A-Z]{3}[0-9]{2}$`',
    `settlement_date` DATE COMMENT 'Date when the financial settlement for this TAP file was completed and payment was processed.',
    `settlement_period_end_date` DATE COMMENT 'End date of the billing/settlement period covered by the usage events in this TAP file.',
    `settlement_period_start_date` DATE COMMENT 'Start date of the billing/settlement period covered by the usage events in this TAP file.',
    `settlement_status` STRING COMMENT 'Current status of the financial settlement process for this TAP file between the operators.. Valid values are `pending|in_progress|completed|disputed|cancelled`',
    `sms_event_count` BIGINT COMMENT 'Number of SMS message events (Mobile Originated SMS and Mobile Terminated SMS) in the TAP file.',
    `tap_file_name` STRING COMMENT 'Standardized TAP file name following GSMA naming convention: sender TADIG code (5 chars), recipient TADIG code (5 chars), file type (3 chars), sequence number (5 digits).. Valid values are `^[A-Z0-9]{5}[A-Z0-9]{5}[A-Z]{3}[0-9]{5}$`',
    `tap_version` STRING COMMENT 'Version number of the TAP specification used for this file (e.g., 3.11, 3.12). Determines the ASN.1 schema and field availability.. Valid values are `^3.[0-9]{1,2}$`',
    `total_charge_amount` DECIMAL(18,2) COMMENT 'Sum of all charged amounts for all usage events in the TAP file, expressed in the file currency. Represents the total inter-operator settlement amount before discounts.',
    `total_discount_amount` DECIMAL(18,2) COMMENT 'Sum of all discount amounts applied to the usage events in the TAP file per bilateral roaming agreement terms.',
    `total_record_count` BIGINT COMMENT 'Total number of individual roaming usage records (CDRs) contained within this TAP file.',
    `total_tax_amount` DECIMAL(18,2) COMMENT 'Sum of all tax amounts applied to the usage events in the TAP file, if applicable per bilateral agreement.',
    `transmission_timestamp` TIMESTAMP COMMENT 'Date and time when the TAP file was transmitted to the clearing house or recipient operator.',
    `validation_error_count` STRING COMMENT 'Number of fatal validation errors detected in the TAP file that prevent processing.',
    `validation_status` STRING COMMENT 'Result of TAP file validation checks (syntax, structure, business rules). Failed validation triggers RAP file generation.. Valid values are `pending|passed|failed|warning`',
    `validation_warning_count` STRING COMMENT 'Number of non-fatal validation warnings detected in the TAP file that allow processing but require review.',
    CONSTRAINT pk_roaming_file PRIMARY KEY(`roaming_file_id`)
) COMMENT 'TAP (Transferred Account Procedure) file-level control record tracking the exchange of roaming usage files between operators via clearing houses (GSMA/Syniverse) — TAP file name, sequence number, sender/recipient TADIG codes, file type (TAP3/RAP), record count, total charged amount, currency, file generation date, transmission status, acknowledgement timestamp, and dispute flag. Parent record for individual roaming_tap_records.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`usage`.`volte_session` (
    `volte_session_id` BIGINT COMMENT 'Unique identifier for the VoLTE/VoNR IMS session record. Primary key.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: VoLTE calls are billable voice events requiring billing account linkage for charging, invoicing, and account-level usage aggregation in converged billing systems.',
    `carrier_agreement_id` BIGINT COMMENT 'Foreign key linking to interconnect.carrier_agreement. Business justification: VoLTE roaming sessions require direct agreement reference for correct IoT tariff application, settlement rate determination, and SLA compliance tracking. Critical for voice-over-LTE roaming billing ac',
    `carrier_id` BIGINT COMMENT 'Mobile Country Code (MCC) and Mobile Network Code (MNC) of the visited network if subscriber was roaming. Null for home network sessions.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise VoLTE calls (mobile workforce, corporate mobile plans) require corporate account linkage for unified communications billing, usage reporting, and cost allocation in B2B telecommunications.',
    `enterprise_site_id` BIGINT COMMENT 'Foreign key linking to enterprise.site. Business justification: Enterprise VoLTE sessions need site linkage for location-based call quality analytics, site-level UC performance monitoring, and cost allocation in multi-site unified communications deployments.',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to order.fulfillment_order. Business justification: Links VoLTE voice session to provisioning order. Critical for validating voice service activation quality (MOS score vs. order commitment), MNP port success (first call after port), and SLA compliance',
    `ims_node_id` BIGINT COMMENT 'Foreign key linking to network.ims_node. Business justification: VoLTE sessions traverse IMS nodes (P-CSCF for registration, S-CSCF for routing). Linking session to serving IMS node enables call quality analysis by node, capacity planning based on session load, fau',
    `pipeline_run_id` BIGINT COMMENT 'Foreign key linking to analytics.pipeline_run. Business justification: VoLTE session records processed via IMS mediation pipelines. Troubleshooting voice quality issues, MOS score validation, and VoLTE billing require pipeline run context for operational lineage and repr',
    `qos_measurement_id` BIGINT COMMENT 'Foreign key linking to assurance.qos_measurement. Business justification: VoLTE quality metrics (MOS score, jitter, packet loss, round-trip delay) are measured per session for service assurance and customer experience management. QoS measurements must reference the specific',
    `ran_cell_id` BIGINT COMMENT 'Identifier of the LTE or 5G NR cell (eNodeB/gNodeB + Cell ID) serving the subscriber at session start. Used for geographic and network performance analysis.',
    `rate_plan_id` BIGINT COMMENT 'Foreign key linking to billing.rate_plan. Business justification: VoLTE calls are rated per rate plan (included minutes, overage rates, international calling). Rate plan determines voice pricing, bundling, and roaming charges.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the subscriber who initiated or received the VoLTE session. Links to the subscriber master record.',
    `svc_instance_id` BIGINT COMMENT 'Foreign key linking to service.svc_instance. Business justification: VoLTE sessions must link to service instances for IMS troubleshooting, voice quality monitoring, billing reconciliation, and validating VoLTE service activation status. Core for IMS operations.',
    `uc_subscription_id` BIGINT COMMENT 'Foreign key linking to enterprise.uc_subscription. Business justification: VoLTE sessions for enterprise UC users must link to UC subscriptions for seat-level usage tracking, billing, call quality monitoring, and unified communications analytics in B2B operations.',
    `call_direction` STRING COMMENT 'Direction of the call: mobile_originated (MO - outgoing from subscriber) or mobile_terminated (MT - incoming to subscriber).. Valid values are `mobile_originated|mobile_terminated`',
    `call_setup_time_ms` STRING COMMENT 'Time in milliseconds from SIP INVITE to SIP 200 OK (answer). Key metric for Call Setup Success Rate (CSSR) KPI.',
    `call_type` STRING COMMENT 'Type of VoLTE call session: voice (audio-only), video (audio+video), or emergency (E911/E112).. Valid values are `voice|video|emergency`',
    `called_party_number` STRING COMMENT 'Telephone number of the party receiving the call (B-party). May be MSISDN or other E.164 number.',
    `calling_party_number` STRING COMMENT 'Telephone number of the party initiating the call (A-party). May be MSISDN or other E.164 number.',
    `charged_amount` DECIMAL(18,2) COMMENT 'Monetary amount charged for this VoLTE session in the subscribers billing currency. Calculated by rating engine based on duration and rate plan.',
    `charging_type` STRING COMMENT 'Charging model applied to this session: postpaid (offline charging) or prepaid (online charging with real-time balance deduction).. Valid values are `postpaid|prepaid`',
    `codec_negotiated` STRING COMMENT 'Audio codec negotiated for the VoLTE session via SDP (Session Description Protocol). AMR-WB and EVS provide HD voice quality.. Valid values are `AMR-NB|AMR-WB|EVS|G.711`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the charged amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `emergency_call_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this was an emergency call (E911 in North America, E112 in Europe). Emergency calls have special routing and regulatory requirements.',
    `handover_count` STRING COMMENT 'Number of handover events (cell changes) that occurred during the VoLTE session. Includes intra-RAT and inter-RAT handovers.',
    `imei` STRING COMMENT 'International Mobile Equipment Identity uniquely identifying the mobile device hardware used during the VoLTE session.. Valid values are `^[0-9]{15}$`',
    `ims_charging_reference` STRING COMMENT 'IMS charging correlation identifier used to correlate this session record with charging events in the online/offline charging systems.',
    `imsi` STRING COMMENT 'International Mobile Subscriber Identity uniquely identifying the subscriber on the network. 15-digit numeric identifier stored in the SIM/eSIM.. Valid values are `^[0-9]{15}$`',
    `jitter_ms` DECIMAL(18,2) COMMENT 'Average jitter (variation in packet arrival time) in milliseconds during the VoLTE session. High jitter degrades voice quality.',
    `location_accuracy_meters` STRING COMMENT 'Estimated accuracy radius of the location coordinates in meters. Critical for E911 compliance (FCC requires <50m for 80% of calls).',
    `location_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the subscriber at session start. Captured for emergency call location and network analytics.',
    `location_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the subscriber at session start. Captured for emergency call location and network analytics.',
    `mediation_batch_reference` STRING COMMENT 'Identifier of the mediation batch that processed and transformed this raw IMS session record. Used for reconciliation and reprocessing.',
    `mos_score` DECIMAL(18,2) COMMENT 'Mean Opinion Score representing perceived voice quality on a scale of 1.0 (poor) to 5.0 (excellent). Calculated from jitter, packet loss, and delay metrics.',
    `msisdn` STRING COMMENT 'Mobile Station International Subscriber Directory Number - the telephone number associated with the subscribers SIM card.. Valid values are `^[0-9]{10,15}$`',
    `p_cscf_address` STRING COMMENT 'IP address of the Proxy Call Session Control Function node that served as the first point of contact in the IMS network for this session.',
    `packet_loss_percent` DECIMAL(18,2) COMMENT 'Percentage of RTP (Real-time Transport Protocol) packets lost during the session. Packet loss above 1-2% impacts voice quality.',
    `qci` STRING COMMENT 'QoS Class Identifier assigned to the VoLTE bearer. Typically QCI=1 for conversational voice (guaranteed bit rate, low latency).',
    `rat_type` STRING COMMENT 'Radio Access Technology type used during the session: LTE (4G VoLTE) or 5G_NR (5G VoNR).. Valid values are `LTE|5G_NR`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this VoLTE session record was created in the usage mediation system. Audit trail for data lineage.',
    `record_source_system` STRING COMMENT 'Name or identifier of the source system that generated this VoLTE session record (e.g., IMS network element, mediation platform).',
    `roaming_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the subscriber was roaming (outside home network) during the VoLTE session.',
    `round_trip_delay_ms` STRING COMMENT 'Average round-trip delay (latency) in milliseconds for RTP packets during the session. ITU-T recommends <150ms for acceptable voice quality.',
    `s_cscf_address` STRING COMMENT 'IP address of the Serving Call Session Control Function node that performed session control and routing for this VoLTE session.',
    `session_answer_timestamp` TIMESTAMP COMMENT 'Timestamp when the called party answered the call (SIP 200 OK received). Null if call was not answered.',
    `session_duration_seconds` STRING COMMENT 'Total duration of the VoLTE session in seconds, measured from session answer to session end. Zero if call was not answered.',
    `session_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the VoLTE IMS session was terminated (SIP BYE or session timeout).',
    `session_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the VoLTE IMS session was initiated (SIP INVITE sent). Represents the business event time of call setup.',
    `sip_session_reference` STRING COMMENT 'Session Initiation Protocol session identifier (Call-ID header) uniquely identifying the IMS call session at the SIP layer.',
    `sip_termination_code` STRING COMMENT 'SIP response code at session termination (e.g., 200 for normal, 486 for busy, 503 for unavailable). Numeric code per IETF RFC 3261.',
    `srvcc_event_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a Single Radio Voice Call Continuity handover occurred (LTE VoLTE to 3G/2G circuit-switched fallback).',
    `srvcc_target_rat` STRING COMMENT 'Target Radio Access Technology for SRVCC handover: UMTS (3G) or GSM (2G). Null if no SRVCC event occurred.. Valid values are `UMTS|GSM`',
    `termination_cause` STRING COMMENT 'Reason for session termination. Maps to SIP response codes and IMS release causes. Critical for call drop analysis. [ENUM-REF-CANDIDATE: normal_clearing|user_busy|no_answer|network_congestion|call_rejected|service_unavailable|radio_link_failure|handover_failure|other — 9 candidates stripped; promote to reference product]',
    CONSTRAINT pk_volte_session PRIMARY KEY(`volte_session_id`)
) COMMENT 'VoLTE (Voice over LTE) and VoNR (Voice over NR/5G) IMS session record capturing IMS-layer call detail — P-CSCF/S-CSCF node, SIP session ID, codec negotiated (AMR-WB/EVS), call setup time (CSSR), call drop cause, MOS score, jitter, packet loss, handover events (LTE-to-3G SRVCC), and IMS charging correlation ID. Distinct from standard CDR: VoLTE sessions carry QoS/MOS metrics critical for VoLTE service quality management.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`usage`.`correction` (
    `correction_id` BIGINT COMMENT 'Unique identifier for the usage correction record. Primary key for the usage correction entity.',
    `adjustment_id` BIGINT COMMENT 'Foreign key linking to billing.adjustment. Business justification: Usage corrections often result in billing adjustments (credits, re-rating). Direct link required for reconciliation, audit trail, and regulatory compliance reporting.',
    `employee_id` BIGINT COMMENT 'User ID of the manager or supervisor who approved the correction. Null if correction does not require approval or is still pending.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Usage corrections are remediation actions for audit findings related to billing accuracy, revenue assurance, and consumer protection. Auditors verify that findings are addressed through documented cor',
    `billing_account_id` BIGINT COMMENT 'Reference to the billing account impacted by the usage correction. Required for financial reconciliation and invoice adjustment processing.',
    `billing_charge_id` BIGINT COMMENT 'Foreign key linking to billing.charge. Business justification: Usage corrections may adjust specific charges (re-rating, subscriber reassignment). Direct link required for audit trail, charge reversal, and financial reconciliation.',
    `billing_dispute_id` BIGINT COMMENT 'Reference to the billing dispute case that triggered this correction. Links to customer service dispute management system. Null if correction was not dispute-driven.',
    `carrier_agreement_id` BIGINT COMMENT 'Foreign key linking to interconnect.carrier_agreement. Business justification: Usage corrections affecting roaming charges must reference the governing agreement to generate accurate RAP files and settlement adjustments. TADIG code is denormalized agreement/carrier reference.',
    `cdr_id` BIGINT COMMENT 'Reference to the original usage event (CDR, IPDR, or other usage record) that was corrected. Links to the source usage record in the CDR or data session tables.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Usage corrections impact revenue and must be tracked by legal entity for financial audit compliance, revenue assurance reporting, and regulatory filings. Essential for SOX compliance and financial sta',
    `subscriber_id` BIGINT COMMENT 'Subscriber ID to which the usage was reassigned after correction. Used for subscriber reassignment corrections.',
    `correction_employee_id` BIGINT COMMENT 'User ID or system identifier of the person or process that initiated the correction. Used for audit trail and accountability tracking.',
    `correction_original_subscriber_id` BIGINT COMMENT 'Subscriber ID to which the usage was originally attributed before correction. Used for subscriber reassignment corrections.',
    `correction_subscriber_id` BIGINT COMMENT 'Reference to the subscriber account associated with the corrected usage event. Used for billing dispute resolution and subscriber-specific corrections.',
    `credit_note_id` BIGINT COMMENT 'Reference to the credit note issued for this correction. Null if no credit note was generated or correction resulted in additional charges.',
    `dq_issue_id` BIGINT COMMENT 'Foreign key linking to analytics.dq_issue. Business justification: Usage corrections often initiated from DQ issues identified in analytics. Linking corrections back to originating DQ issue enables root cause tracking, prevents recurrence, and supports regulatory aud',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice that included the original (incorrect) usage charge. Used to determine if credit note or invoice adjustment is required.',
    `invoice_line_id` BIGINT COMMENT 'Foreign key linking to billing.invoice_line. Business justification: Usage corrections may adjust specific invoice lines (re-rating, subscriber reassignment). Direct link required for invoice correction, audit trail, and customer dispute resolution.',
    `rap_file_id` BIGINT COMMENT 'Reference to the RAP file that contains this correction record. Used to track inter-operator dispute communications. Null if no RAP file was generated.',
    `rated_event_id` BIGINT COMMENT 'Foreign key linking to billing.rated_event. Business justification: Usage corrections often adjust specific rated events (re-rating, subscriber reassignment). Direct link required for audit trail, revenue assurance, and regulatory compliance reporting.',
    `regulatory_penalty_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_penalty. Business justification: Usage corrections may be required as remediation for regulatory penalties related to billing accuracy violations, consumer protection breaches, or tariff compliance failures. Penalties often mandate s',
    `reversed_correction_id` BIGINT COMMENT 'Reference to the original correction record that is being reversed by this correction. Null if this is not a reversal correction.',
    `svc_instance_id` BIGINT COMMENT 'Foreign key linking to service.svc_instance. Business justification: Usage corrections require service instance context to validate correction scope, verify service configuration at event time, and apply billing adjustments accurately. Essential for revenue assurance o',
    `trouble_ticket_id` BIGINT COMMENT 'Reference to the trouble ticket or incident record associated with this correction. Used when correction is part of a broader service issue resolution. Null if not ticket-driven.',
    `reversal_correction_id` BIGINT COMMENT 'Self-referencing FK on correction (reversal_correction_id)',
    `application_timestamp` TIMESTAMP COMMENT 'Date and time when the correction was applied to the billing system and financial impact was realized. Null if correction has not yet been applied. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether the correction requires management approval before application. True for high-value corrections or regulatory-sensitive adjustments.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the correction was approved. Null if correction is pending or does not require approval. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `corrected_call_duration_seconds` STRING COMMENT 'Corrected call or session duration in seconds after adjustment. Null if correction does not involve duration adjustment.',
    `corrected_data_volume_bytes` BIGINT COMMENT 'Corrected data volume in bytes after adjustment. Null if correction does not involve volume adjustment.',
    `corrected_rated_amount` DECIMAL(18,2) COMMENT 'Corrected monetary amount charged for the usage event after adjustment. Used to calculate financial impact of the correction.',
    `correction_status` STRING COMMENT 'Current workflow status of the correction record. Tracks approval and application lifecycle. Values: pending (awaiting approval), approved (authorized for application), rejected (correction denied), applied (correction successfully applied to billing), reversed (correction rolled back).. Valid values are `pending|approved|rejected|applied|reversed`',
    `correction_timestamp` TIMESTAMP COMMENT 'Date and time when the correction was created in the system. Represents the business event time of the correction initiation. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `correction_type` STRING COMMENT 'Category of correction applied to the usage event. Determines the nature of the adjustment and the fields modified. Values: duplicate_removal (duplicate CDR detected), duration_adjustment (call/session duration corrected), volume_correction (data volume adjusted), misrouted_cdr (CDR routed to wrong account), subscriber_reassignment (usage reassigned to correct subscriber), test_call_removal (test/maintenance traffic removed).. Valid values are `duplicate_removal|duration_adjustment|volume_correction|misrouted_cdr|subscriber_reassignment|test_call_removal`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this correction record was first created in the system. Audit trail timestamp for record creation. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `credit_note_generated_flag` BOOLEAN COMMENT 'Indicates whether a credit note was issued to the customer as a result of this correction. True if credit note was generated, false otherwise.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this correction record. Ensures consistent financial reporting across multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Net financial impact of the correction (corrected amount minus original amount). Positive values indicate additional charges (debit), negative values indicate credits to the customer.',
    `initiator_type` STRING COMMENT 'Source or party that triggered the correction. Values: subscriber_dispute (customer-initiated billing dispute), revenue_assurance (internal RA team detection), regulatory_audit (compliance audit finding), operator_error (manual correction by operations), system_mediation (automated mediation system correction), roaming_partner (correction from roaming partner via RAP file).. Valid values are `subscriber_dispute|revenue_assurance|regulatory_audit|operator_error|system_mediation|roaming_partner`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this correction record was last updated. Audit trail timestamp for tracking changes to correction status, approval, or application. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notes` STRING COMMENT 'Free-text field for additional comments, context, or instructions related to the correction. Used by customer service, revenue assurance, and audit teams for detailed documentation.',
    `original_call_duration_seconds` STRING COMMENT 'Original call or session duration in seconds before correction was applied. Null if correction does not involve duration adjustment.',
    `original_data_volume_bytes` BIGINT COMMENT 'Original data volume in bytes before correction was applied. Null if correction does not involve volume adjustment.',
    `original_rated_amount` DECIMAL(18,2) COMMENT 'Original monetary amount charged for the usage event before correction. Used to calculate financial impact of the correction.',
    `rap_file_generated_flag` BOOLEAN COMMENT 'Indicates whether a RAP file was generated to communicate this correction to the roaming partner. True if RAP file was created, false otherwise. Required for GSMA roaming dispute resolution.',
    `reason_code` STRING COMMENT 'Standardized code indicating the business reason for the correction. Used for root cause analysis and trend reporting. Format: AAA999 (three-letter category + three-digit sub-reason).. Valid values are `^[A-Z]{3}[0-9]{3}$`',
    `reason_description` STRING COMMENT 'Detailed free-text explanation of why the correction was necessary. Provides context for auditors, customer service, and revenue assurance teams.',
    `reference_number` STRING COMMENT 'Externally visible unique reference number for the correction record. Used in customer communications, dispute resolution, and regulatory audit trails. Format: COR-XXXXXXXXXX.. Valid values are `^COR-[0-9]{10}$`',
    `regulatory_audit_reference` STRING COMMENT 'Reference number or identifier for the regulatory audit or compliance review that identified the need for this correction. Required for FCC, Ofcom, and other regulatory audit trails.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this correction record represents a reversal of a previously applied correction. True for reversal corrections, false for original corrections.',
    `roaming_indicator` BOOLEAN COMMENT 'Indicates whether the corrected usage event was a roaming event. True for roaming usage, false for home network usage. Critical for GSMA TAP/RAP dispute resolution.',
    `source_system` STRING COMMENT 'Name or identifier of the system that generated or recorded this correction. Examples: Revenue Assurance Platform, Mediation System, Customer Care System, Roaming Clearing House.',
    `tap_file_sequence_number` STRING COMMENT 'Sequence number of the TAP file containing the original roaming usage record. Used to trace corrections back to source roaming data exchange files.',
    CONSTRAINT pk_correction PRIMARY KEY(`correction_id`)
) COMMENT 'Usage correction and dispute adjustment record capturing post-mediation modifications to rated usage events — correction type (duplicate removal, duration adjustment, volume correction, misrouted CDR, subscriber reassignment, test call removal), original usage event reference, corrected field values, correction reason code, initiator (subscriber dispute, revenue assurance, regulatory audit, operator error), approval workflow status, correction timestamp, financial impact (credit/debit amount), and regulatory audit trail reference. Required for GSMA TAP dispute resolution (RAP files), subscriber billing disputes, and regulatory audit compliance (Ofcom/FCC usage accuracy mandates).';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`usage`.`detection_rule` (
    `detection_rule_id` BIGINT COMMENT 'Primary key for detection_rule',
    `derived_from_detection_rule_id` BIGINT COMMENT 'Self-referencing FK on detection_rule (derived_from_detection_rule_id)',
    `alert_channel` STRING COMMENT 'Channel used to deliver alerts when the rule fires.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rule record was first created in the system.',
    `detection_rule_description` STRING COMMENT 'Detailed free‑text description of the rule logic and intent.',
    `effective_from` DATE COMMENT 'Date from which the rule becomes active.',
    `effective_until` DATE COMMENT 'Date after which the rule is no longer applicable; null if open‑ended.',
    `escalation_policy` STRING COMMENT 'Identifier of the escalation policy applied to rule alerts.',
    `is_threshold_based` BOOLEAN COMMENT 'Indicates whether the rule uses a numeric threshold for triggering.',
    `last_executed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent rule execution attempt.',
    `last_successful_run_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful rule execution.',
    `detection_rule_name` STRING COMMENT 'Human‑readable name of the detection rule.',
    `owner_team` STRING COMMENT 'Name of the internal team responsible for the rule.',
    `parameters_json` STRING COMMENT 'JSON‑encoded parameters that configure the rule logic.',
    `rule_code` STRING COMMENT 'Business identifier code used to reference the rule in external systems.',
    `rule_owner` STRING COMMENT 'Identifier of the person or role that owns the rule.',
    `rule_priority` STRING COMMENT 'Numeric priority used to order rule evaluation; lower numbers indicate higher priority.',
    `rule_source_system` STRING COMMENT 'Name of the upstream system that originated the rule.',
    `rule_tags` STRING COMMENT 'Comma‑separated list of free‑form tags for categorization and search.',
    `rule_type` STRING COMMENT 'Category of the rule indicating its purpose, such as fraud detection or usage anomaly.',
    `rule_version` STRING COMMENT 'Version string of the rule definition.',
    `severity_score` STRING COMMENT 'Numeric severity rating of the rule, higher values indicate greater impact.',
    `detection_rule_status` STRING COMMENT 'Current lifecycle status of the rule.',
    `threshold_unit` STRING COMMENT 'Unit of measure for the threshold value.',
    `threshold_value` DECIMAL(18,2) COMMENT 'Numeric threshold value used when is_threshold_based is true.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rule record.',
    CONSTRAINT pk_detection_rule PRIMARY KEY(`detection_rule_id`)
) COMMENT 'Master reference table for detection_rule. Referenced by detection_rule_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_original_cdr_id` FOREIGN KEY (`original_cdr_id`) REFERENCES `telecommunication_ecm`.`usage`.`cdr`(`cdr_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_roaming_file_id` FOREIGN KEY (`roaming_file_id`) REFERENCES `telecommunication_ecm`.`usage`.`roaming_file`(`roaming_file_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_roaming_file_id` FOREIGN KEY (`roaming_file_id`) REFERENCES `telecommunication_ecm`.`usage`.`roaming_file`(`roaming_file_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ADD CONSTRAINT `fk_usage_ipdr_record_data_session_id` FOREIGN KEY (`data_session_id`) REFERENCES `telecommunication_ecm`.`usage`.`data_session`(`data_session_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ADD CONSTRAINT `fk_usage_content_consumption_data_session_id` FOREIGN KEY (`data_session_id`) REFERENCES `telecommunication_ecm`.`usage`.`data_session`(`data_session_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ADD CONSTRAINT `fk_usage_mediation_event_cdr_id` FOREIGN KEY (`cdr_id`) REFERENCES `telecommunication_ecm`.`usage`.`cdr`(`cdr_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_cdr_id` FOREIGN KEY (`cdr_id`) REFERENCES `telecommunication_ecm`.`usage`.`cdr`(`cdr_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_detection_rule_id` FOREIGN KEY (`detection_rule_id`) REFERENCES `telecommunication_ecm`.`usage`.`detection_rule`(`detection_rule_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ADD CONSTRAINT `fk_usage_correction_cdr_id` FOREIGN KEY (`cdr_id`) REFERENCES `telecommunication_ecm`.`usage`.`cdr`(`cdr_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ADD CONSTRAINT `fk_usage_correction_reversed_correction_id` FOREIGN KEY (`reversed_correction_id`) REFERENCES `telecommunication_ecm`.`usage`.`correction`(`correction_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ADD CONSTRAINT `fk_usage_correction_reversal_correction_id` FOREIGN KEY (`reversal_correction_id`) REFERENCES `telecommunication_ecm`.`usage`.`correction`(`correction_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`detection_rule` ADD CONSTRAINT `fk_usage_detection_rule_derived_from_detection_rule_id` FOREIGN KEY (`derived_from_detection_rule_id`) REFERENCES `telecommunication_ecm`.`usage`.`detection_rule`(`detection_rule_id`);

-- ========= TAGS =========
ALTER SCHEMA `telecommunication_ecm`.`usage` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `telecommunication_ecm`.`usage` SET TAGS ('dbx_domain' = 'usage');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` SET TAGS ('dbx_subdomain' = 'event_capture');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `cdr_id` SET TAGS ('dbx_business_glossary_term' = 'Call Detail Record (CDR) Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnect Partner Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `enterprise_site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `iot_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Iot Deployment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `network_operator_carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Network Operator Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `original_cdr_id` SET TAGS ('dbx_business_glossary_term' = 'Original Call Detail Record (CDR) Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Run Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `ran_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Cell Identifier (Cell ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `roaming_file_id` SET TAGS ('dbx_business_glossary_term' = 'Tap File Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `bearer_service_code` SET TAGS ('dbx_business_glossary_term' = 'Bearer Service Code');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `call_category` SET TAGS ('dbx_business_glossary_term' = 'Call Category');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `call_category` SET TAGS ('dbx_value_regex' = 'local|national|international|roaming');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `call_direction` SET TAGS ('dbx_business_glossary_term' = 'Call Direction');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `call_direction` SET TAGS ('dbx_value_regex' = 'mobile_originated|mobile_terminated|forwarded');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `call_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Call Duration in Seconds');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `call_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Call End Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `call_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Call Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `call_type` SET TAGS ('dbx_business_glossary_term' = 'Call Type');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `call_type` SET TAGS ('dbx_value_regex' = 'voice|sms|mms|data|video');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `charging_indicator` SET TAGS ('dbx_business_glossary_term' = 'Charging Indicator');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `charging_indicator` SET TAGS ('dbx_value_regex' = 'chargeable|non_chargeable|free|promotional');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Collection Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `correction_indicator` SET TAGS ('dbx_business_glossary_term' = 'Correction Indicator');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `data_volume_downlink_bytes` SET TAGS ('dbx_business_glossary_term' = 'Data Volume Downlink in Bytes');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `data_volume_uplink_bytes` SET TAGS ('dbx_business_glossary_term' = 'Data Volume Uplink in Bytes');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `fraud_indicator` SET TAGS ('dbx_business_glossary_term' = 'Fraud Indicator');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `imei` SET TAGS ('dbx_business_glossary_term' = 'International Mobile Equipment Identity (IMEI)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `imei` SET TAGS ('dbx_value_regex' = '^[0-9]{15}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `imei` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `imei` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `imsi` SET TAGS ('dbx_business_glossary_term' = 'International Mobile Subscriber Identity (IMSI)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `imsi` SET TAGS ('dbx_value_regex' = '^[0-9]{14,15}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `imsi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `imsi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `ingestion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingestion Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `location_area_code` SET TAGS ('dbx_business_glossary_term' = 'Location Area Code (LAC)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `mediation_status` SET TAGS ('dbx_business_glossary_term' = 'Mediation Processing Status');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `mediation_status` SET TAGS ('dbx_value_regex' = 'raw|mediated|validated|rejected|error');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `mediation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Mediation Processing Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `msisdn` SET TAGS ('dbx_business_glossary_term' = 'Mobile Station International Subscriber Directory Number (MSISDN)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `msisdn` SET TAGS ('dbx_value_regex' = '^[0-9]{10,15}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `msisdn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `msisdn` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `nrtrde_batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Near Real-Time Roaming Data Exchange (NRTRDE) Batch Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `originating_number` SET TAGS ('dbx_business_glossary_term' = 'Originating Number');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `originating_number` SET TAGS ('dbx_value_regex' = '^[0-9+]{10,15}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `originating_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `originating_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `qos_class` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Class');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `rating_status` SET TAGS ('dbx_business_glossary_term' = 'Rating Status');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `rating_status` SET TAGS ('dbx_value_regex' = 'pending|rated|failed|reprocessed');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `record_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Record Sequence Number');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `revenue_assurance_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Assurance Status');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `revenue_assurance_status` SET TAGS ('dbx_value_regex' = 'passed|flagged|under_review|cleared');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `roaming_country_code` SET TAGS ('dbx_business_glossary_term' = 'Roaming Country Code');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `roaming_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `roaming_indicator` SET TAGS ('dbx_business_glossary_term' = 'Roaming Indicator');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `roaming_network_code` SET TAGS ('dbx_business_glossary_term' = 'Roaming Network Code');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `roaming_network_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5,6}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'volte|ims|circuit_switched|packet_switched');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `serving_msc` SET TAGS ('dbx_business_glossary_term' = 'Serving Mobile Switching Center (MSC)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `supplementary_service_codes` SET TAGS ('dbx_business_glossary_term' = 'Supplementary Service Codes');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `terminating_number` SET TAGS ('dbx_business_glossary_term' = 'Terminating Number');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `terminating_number` SET TAGS ('dbx_value_regex' = '^[0-9+]{10,15}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `terminating_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `terminating_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `termination_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Cause Code');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `termination_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Termination Cause Description');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `trunk_group_code` SET TAGS ('dbx_business_glossary_term' = 'Trunk Group Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` SET TAGS ('dbx_subdomain' = 'event_capture');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `sms_record_id` SET TAGS ('dbx_business_glossary_term' = 'Short Message Service (SMS) Record Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnect Carrier Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `iot_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Iot Deployment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Network Element Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Run Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `ran_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Cell Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `roaming_file_id` SET TAGS ('dbx_business_glossary_term' = 'Tap File Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `cdr_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Call Detail Record (CDR) Sequence Number');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `cdr_sequence_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,30}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `charging_indicator` SET TAGS ('dbx_business_glossary_term' = 'Charging Indicator');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `charging_indicator` SET TAGS ('dbx_value_regex' = 'chargeable|non_chargeable|promotional|zero_rated');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `content_class` SET TAGS ('dbx_business_glossary_term' = 'Content Class');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `content_class` SET TAGS ('dbx_value_regex' = 'standard|premium|promotional|transactional|otp|alert');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `data_coding_scheme` SET TAGS ('dbx_business_glossary_term' = 'Data Coding Scheme');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `data_coding_scheme` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'delivered|failed|pending|expired|rejected|unknown');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `home_network_code` SET TAGS ('dbx_business_glossary_term' = 'Home Network Mobile Country Code and Mobile Network Code (MCC-MNC)');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `home_network_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5,6}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `imei` SET TAGS ('dbx_business_glossary_term' = 'International Mobile Equipment Identity (IMEI)');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `imei` SET TAGS ('dbx_value_regex' = '^[0-9]{14,16}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `imei` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `imei` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `imsi` SET TAGS ('dbx_business_glossary_term' = 'International Mobile Subscriber Identity (IMSI)');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `imsi` SET TAGS ('dbx_value_regex' = '^[0-9]{14,15}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `imsi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `imsi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `mediation_status` SET TAGS ('dbx_business_glossary_term' = 'Mediation Status');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `mediation_status` SET TAGS ('dbx_value_regex' = 'raw|mediated|validated|rejected|duplicate');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `mediation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Mediation Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `message_reference` SET TAGS ('dbx_business_glossary_term' = 'Message Reference Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `message_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,40}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `message_segment_count` SET TAGS ('dbx_business_glossary_term' = 'Message Segment Count');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `message_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Message Size in Bytes');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `message_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Message Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `message_type` SET TAGS ('dbx_business_glossary_term' = 'Message Type');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `message_type` SET TAGS ('dbx_value_regex' = 'MT|MO|P2P|A2P|P2A|MMS');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `originating_msisdn` SET TAGS ('dbx_business_glossary_term' = 'Originating Mobile Station International Subscriber Directory Number (MSISDN)');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `originating_msisdn` SET TAGS ('dbx_value_regex' = '^[0-9]{10,15}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `originating_msisdn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `originating_msisdn` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `partition_date` SET TAGS ('dbx_business_glossary_term' = 'Partition Date');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `priority_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `protocol_identifier` SET TAGS ('dbx_business_glossary_term' = 'Protocol Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `protocol_identifier` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `rated_amount` SET TAGS ('dbx_business_glossary_term' = 'Rated Amount');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `reply_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Reply Path Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `roaming_indicator` SET TAGS ('dbx_business_glossary_term' = 'Roaming Indicator');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `service_code` SET TAGS ('dbx_business_glossary_term' = 'Service Code');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `service_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `smsc_address` SET TAGS ('dbx_business_glossary_term' = 'Short Message Service Center (SMSC) Address');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `smsc_address` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.]{5,50}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `smsc_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `smsc_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,30}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `spam_score` SET TAGS ('dbx_business_glossary_term' = 'Spam Score');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `terminating_msisdn` SET TAGS ('dbx_business_glossary_term' = 'Terminating Mobile Station International Subscriber Directory Number (MSISDN)');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `terminating_msisdn` SET TAGS ('dbx_value_regex' = '^[0-9]{10,15}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `terminating_msisdn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `terminating_msisdn` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `validity_period_minutes` SET TAGS ('dbx_business_glossary_term' = 'Validity Period in Minutes');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` SET TAGS ('dbx_subdomain' = 'event_capture');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `data_session_id` SET TAGS ('dbx_business_glossary_term' = 'Data Session Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnect Carrier Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `dq_execution_result_id` SET TAGS ('dbx_business_glossary_term' = 'Dq Execution Result Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `enterprise_site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `iot_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Iot Deployment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Address Pool Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `network_qos_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Qos Profile Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `ont_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ont Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Run Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `qos_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Qos Measurement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `ran_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Cell Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `sdwan_topology_id` SET TAGS ('dbx_business_glossary_term' = 'Sdwan Topology Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `apn` SET TAGS ('dbx_business_glossary_term' = 'Access Point Name (APN)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `charging_characteristics` SET TAGS ('dbx_business_glossary_term' = 'Charging Characteristics');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `charging_reference` SET TAGS ('dbx_business_glossary_term' = 'Charging Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `downlink_bytes` SET TAGS ('dbx_business_glossary_term' = 'Downlink Data Volume in Bytes');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `five_qi` SET TAGS ('dbx_business_glossary_term' = '5G QoS Identifier (5QI)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `home_plmn_code` SET TAGS ('dbx_business_glossary_term' = 'Home Public Land Mobile Network (PLMN) Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `home_plmn_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5,6}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `imei` SET TAGS ('dbx_business_glossary_term' = 'International Mobile Equipment Identity (IMEI)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `imei` SET TAGS ('dbx_value_regex' = '^[0-9]{15}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `imei` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `imei` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `imsi` SET TAGS ('dbx_business_glossary_term' = 'International Mobile Subscriber Identity (IMSI)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `imsi` SET TAGS ('dbx_value_regex' = '^[0-9]{14,15}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `imsi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `imsi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `location_area_code` SET TAGS ('dbx_business_glossary_term' = 'Location Area Code (LAC)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `mediation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Mediation Processing Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `msisdn` SET TAGS ('dbx_business_glossary_term' = 'Mobile Station International Subscriber Directory Number (MSISDN)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `msisdn` SET TAGS ('dbx_value_regex' = '^[0-9]{10,15}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `msisdn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `msisdn` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `pdn_type` SET TAGS ('dbx_business_glossary_term' = 'Packet Data Network (PDN) Type');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `pdn_type` SET TAGS ('dbx_value_regex' = 'IPv4|IPv6|IPv4v6');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `peak_downlink_throughput_kbps` SET TAGS ('dbx_business_glossary_term' = 'Peak Downlink Throughput in Kilobits per Second (Kbps)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `peak_uplink_throughput_kbps` SET TAGS ('dbx_business_glossary_term' = 'Peak Uplink Throughput in Kilobits per Second (Kbps)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `pgw_address` SET TAGS ('dbx_business_glossary_term' = 'Packet Data Network (PDN) Gateway (PGW) Address');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `pgw_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `pgw_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `qci` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Class Identifier (QCI)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `rat_type` SET TAGS ('dbx_business_glossary_term' = 'Radio Access Technology (RAT) Type');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `rat_type` SET TAGS ('dbx_value_regex' = '2G|3G|HSPA|HSPA_PLUS|LTE|5G_NR');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `rating_group` SET TAGS ('dbx_business_glossary_term' = 'Rating Group');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `record_closing_time` SET TAGS ('dbx_business_glossary_term' = 'Charging Data Record (CDR) Closing Time');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `record_opening_time` SET TAGS ('dbx_business_glossary_term' = 'Charging Data Record (CDR) Opening Time');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `record_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Record Sequence Number');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `record_type` SET TAGS ('dbx_business_glossary_term' = 'Charging Data Record (CDR) Type');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `record_type` SET TAGS ('dbx_value_regex' = 'S-CDR|M-CDR|S-SMO-CDR|PGW-CDR|SGW-CDR');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `roaming_indicator` SET TAGS ('dbx_business_glossary_term' = 'Roaming Indicator');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `service_identifier` SET TAGS ('dbx_business_glossary_term' = 'Service Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `serving_node_type` SET TAGS ('dbx_business_glossary_term' = 'Serving Node Type');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `serving_node_type` SET TAGS ('dbx_value_regex' = 'SGSN|PGW|SGW|UPF');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `session_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Session Duration in Seconds');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `session_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session End Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `session_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `session_termination_cause` SET TAGS ('dbx_business_glossary_term' = 'Session Termination Cause');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `sgsn_address` SET TAGS ('dbx_business_glossary_term' = 'Serving General Packet Radio Service (GPRS) Support Node (SGSN) Address');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `sgsn_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `sgsn_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `sgw_address` SET TAGS ('dbx_business_glossary_term' = 'Serving Gateway (SGW) Address');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `sgw_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `sgw_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `total_bytes` SET TAGS ('dbx_business_glossary_term' = 'Total Data Volume in Bytes');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `tracking_area_code` SET TAGS ('dbx_business_glossary_term' = 'Tracking Area Code (TAC)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `ue_ip_address` SET TAGS ('dbx_business_glossary_term' = 'User Equipment (UE) Internet Protocol (IP) Address');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `ue_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `ue_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `upf_address` SET TAGS ('dbx_business_glossary_term' = 'User Plane Function (UPF) Address');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `upf_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `upf_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `uplink_bytes` SET TAGS ('dbx_business_glossary_term' = 'Uplink Data Volume in Bytes');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` SET TAGS ('dbx_subdomain' = 'event_capture');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `ipdr_record_id` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol Detail Record (IPDR) Record ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Roaming Partner ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `data_session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `dq_execution_result_id` SET TAGS ('dbx_business_glossary_term' = 'Dq Execution Result Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `enterprise_site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `fraud_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `iot_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Iot Deployment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `lawful_intercept_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lawful Intercept Order ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `lawful_intercept_order_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Content Provider ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Run Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Deep Packet Inspection (DPI) Probe Node ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `ran_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Cell ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `sdwan_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Sdwan Policy Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `sdwan_topology_id` SET TAGS ('dbx_business_glossary_term' = 'Sdwan Topology Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `slice_id` SET TAGS ('dbx_business_glossary_term' = 'Network Slice ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `zero_rating_program_id` SET TAGS ('dbx_business_glossary_term' = 'Zero-Rating Program ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `access_technology` SET TAGS ('dbx_business_glossary_term' = 'Access Technology');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `application_category` SET TAGS ('dbx_business_glossary_term' = 'Application Category');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `bytes_downlink` SET TAGS ('dbx_business_glossary_term' = 'Bytes Downlink');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `bytes_uplink` SET TAGS ('dbx_business_glossary_term' = 'Bytes Uplink');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `charging_rule_code` SET TAGS ('dbx_business_glossary_term' = 'Charging Rule ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `destination_domain` SET TAGS ('dbx_business_glossary_term' = 'Destination Domain Name');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `destination_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Destination Internet Protocol (IP) Address');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `destination_ip_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `destination_ip_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `detected_application` SET TAGS ('dbx_business_glossary_term' = 'Detected Application Name');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `dscp_marking` SET TAGS ('dbx_business_glossary_term' = 'Differentiated Services Code Point (DSCP) Marking');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `flow_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Flow Duration in Seconds');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `flow_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Flow End Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `flow_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Flow Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `lawful_intercept_flag` SET TAGS ('dbx_business_glossary_term' = 'Lawful Intercept Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `lawful_intercept_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `location_area_code` SET TAGS ('dbx_business_glossary_term' = 'Location Area Code (LAC)');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `mediation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Mediation Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `packets_downlink` SET TAGS ('dbx_business_glossary_term' = 'Packets Downlink');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `packets_uplink` SET TAGS ('dbx_business_glossary_term' = 'Packets Uplink');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `policy_enforcement_action` SET TAGS ('dbx_business_glossary_term' = 'Policy Enforcement Action');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `policy_enforcement_action` SET TAGS ('dbx_value_regex' = 'ALLOW|BLOCK|REDIRECT|RATE_LIMIT|LOG_ONLY');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `policy_rule_code` SET TAGS ('dbx_business_glossary_term' = 'Policy Rule ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `protocol` SET TAGS ('dbx_business_glossary_term' = 'Network Protocol');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `qos_policy_applied` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Policy Applied');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `rated_amount` SET TAGS ('dbx_business_glossary_term' = 'Rated Amount');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `roaming_flag` SET TAGS ('dbx_business_glossary_term' = 'Roaming Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `subscriber_identifier` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `subscriber_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `subscriber_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `subscriber_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Internet Protocol (IP) Address');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `subscriber_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `subscriber_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `throttle_action_applied` SET TAGS ('dbx_business_glossary_term' = 'Throttle Action Applied');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `throttle_action_applied` SET TAGS ('dbx_value_regex' = 'NONE|THROTTLED|BLOCKED|SHAPED');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `throttle_reason` SET TAGS ('dbx_business_glossary_term' = 'Throttle Reason');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `traffic_direction` SET TAGS ('dbx_business_glossary_term' = 'Traffic Direction');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `traffic_direction` SET TAGS ('dbx_value_regex' = 'UPLINK|DOWNLINK|BIDIRECTIONAL');
ALTER TABLE `telecommunication_ecm`.`usage`.`ipdr_record` ALTER COLUMN `zero_rating_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Zero-Rating Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` SET TAGS ('dbx_subdomain' = 'event_capture');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `content_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Content Consumption ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `device_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `device_registration_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `device_registration_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Entitlement ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'Content License ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Content Provider ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Run Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `roaming_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Roaming Partner ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `data_session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `slice_id` SET TAGS ('dbx_business_glossary_term' = 'Network Slice Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Package ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `vod_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Bitrate (Kilobits per Second)');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `buffering_events_count` SET TAGS ('dbx_business_glossary_term' = 'Buffering Events Count');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `bytes_consumed` SET TAGS ('dbx_business_glossary_term' = 'Bytes Consumed');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `cdn_node_code` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Node ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `charging_reference` SET TAGS ('dbx_business_glossary_term' = 'Charging ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `error_description` SET TAGS ('dbx_business_glossary_term' = 'Error Description');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'Completed|In Progress|Failed|Abandoned');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `geographic_location` SET TAGS ('dbx_business_glossary_term' = 'Geographic Location');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `mediation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Mediation Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `network_type` SET TAGS ('dbx_business_glossary_term' = 'Network Type');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `network_type` SET TAGS ('dbx_value_regex' = '5G|LTE|3G|WiFi|Fixed Broadband|FTTH');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `parental_control_rating` SET TAGS ('dbx_business_glossary_term' = 'Parental Control Rating');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `rated_amount` SET TAGS ('dbx_business_glossary_term' = 'Rated Amount');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `roaming_flag` SET TAGS ('dbx_business_glossary_term' = 'Roaming Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `session_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Session Duration (Seconds)');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `session_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session End Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `session_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `stream_quality` SET TAGS ('dbx_business_glossary_term' = 'Stream Quality');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `stream_quality` SET TAGS ('dbx_value_regex' = 'SD|HD|Full HD|4K|8K|Auto');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`content_consumption` ALTER COLUMN `zero_rated_flag` SET TAGS ('dbx_business_glossary_term' = 'Zero-Rated Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` SET TAGS ('dbx_subdomain' = 'data_processing');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `mediation_event_id` SET TAGS ('dbx_business_glossary_term' = 'Mediation Event Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Roaming Partner Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `dq_execution_result_id` SET TAGS ('dbx_business_glossary_term' = 'Dq Execution Result Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Network Element Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Run Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `ran_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Cell Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `cdr_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Call Detail Record (CDR) Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `trouble_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Trouble Ticket Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `vod_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `acknowledgement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `apn` SET TAGS ('dbx_business_glossary_term' = 'Access Point Name (APN)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `called_party` SET TAGS ('dbx_business_glossary_term' = 'Called Party Number');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `called_party` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `called_party` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `calling_party` SET TAGS ('dbx_business_glossary_term' = 'Calling Party Number');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `calling_party` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `calling_party` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Collection Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `data_volume_bytes` SET TAGS ('dbx_business_glossary_term' = 'Data Volume in Bytes');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `delivery_acknowledgement_flag` SET TAGS ('dbx_business_glossary_term' = 'Delivery Acknowledgement Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `download_bytes` SET TAGS ('dbx_business_glossary_term' = 'Download Volume in Bytes');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `downstream_system_code` SET TAGS ('dbx_business_glossary_term' = 'Downstream System Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration in Seconds');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `enrichment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrichment Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `imei` SET TAGS ('dbx_business_glossary_term' = 'International Mobile Equipment Identity (IMEI)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `imei` SET TAGS ('dbx_value_regex' = '^[0-9]{15}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `imei` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `imei` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `imsi` SET TAGS ('dbx_business_glossary_term' = 'International Mobile Subscriber Identity (IMSI)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `imsi` SET TAGS ('dbx_value_regex' = '^[0-9]{15}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `imsi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `imsi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `location_area_code` SET TAGS ('dbx_business_glossary_term' = 'Location Area Code (LAC)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `manual_review_queue` SET TAGS ('dbx_business_glossary_term' = 'Manual Review Queue');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `mediation_node_code` SET TAGS ('dbx_business_glossary_term' = 'Mediation Node Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `msisdn` SET TAGS ('dbx_business_glossary_term' = 'Mobile Station International Subscriber Directory Number (MSISDN)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `msisdn` SET TAGS ('dbx_value_regex' = '^[0-9]{10,15}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `msisdn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `msisdn` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `network_element_type` SET TAGS ('dbx_business_glossary_term' = 'Network Element Type');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `normalization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Normalization Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `processing_status` SET TAGS ('dbx_business_glossary_term' = 'Processing Status');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `qos_class` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Class');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `rating_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rating Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `rejection_category` SET TAGS ('dbx_business_glossary_term' = 'Rejection Category');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `rejection_description` SET TAGS ('dbx_business_glossary_term' = 'Rejection Description');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `rejection_flag` SET TAGS ('dbx_business_glossary_term' = 'Rejection Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `reprocessing_history` SET TAGS ('dbx_business_glossary_term' = 'Reprocessing History');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'auto_corrected|manually_resolved|permanently_rejected|written_off|pending_review');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `retry_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Retry Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `roaming_indicator` SET TAGS ('dbx_business_glossary_term' = 'Roaming Indicator');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `upload_bytes` SET TAGS ('dbx_business_glossary_term' = 'Upload Volume in Bytes');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `usage_type` SET TAGS ('dbx_business_glossary_term' = 'Usage Type');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `visited_network_code` SET TAGS ('dbx_business_glossary_term' = 'Visited Network Code (PLMN)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `visited_network_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5,6}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` SET TAGS ('dbx_subdomain' = 'balance_oversight');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `balance_id` SET TAGS ('dbx_business_glossary_term' = 'Usage Balance Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `analytics_segment_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `bundle_subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Instance Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `rated_event_id` SET TAGS ('dbx_business_glossary_term' = 'Last Consumption Event Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `prepaid_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Prepaid Balance Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `balance_status` SET TAGS ('dbx_business_glossary_term' = 'Balance Status');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `balance_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|depleted|throttled|terminated');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `balance_type` SET TAGS ('dbx_business_glossary_term' = 'Balance Type');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `balance_type` SET TAGS ('dbx_value_regex' = 'voice|sms|data|content|monetary');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `bundle_name` SET TAGS ('dbx_business_glossary_term' = 'Bundle Name');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `charging_system_source` SET TAGS ('dbx_business_glossary_term' = 'Charging System Source');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `charging_system_source` SET TAGS ('dbx_value_regex' = 'ocs|prepaid_platform|rating_engine|mediation_system');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `consumed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Consumed Quantity');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `consumption_percentage` SET TAGS ('dbx_business_glossary_term' = 'Consumption Percentage');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `fair_usage_policy_flag` SET TAGS ('dbx_business_glossary_term' = 'Fair Usage Policy (FUP) Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `fair_usage_threshold` SET TAGS ('dbx_business_glossary_term' = 'Fair Usage Threshold');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `group_code` SET TAGS ('dbx_business_glossary_term' = 'Balance Group Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `initial_balance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Initial Balance Quantity');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `last_consumption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Consumption Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `last_top_up_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Top-Up Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `network_type` SET TAGS ('dbx_business_glossary_term' = 'Network Type');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `network_type` SET TAGS ('dbx_value_regex' = '2g|3g|4g_lte|5g_nr|wifi|fixed_line');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `notification_threshold_1` SET TAGS ('dbx_business_glossary_term' = 'Notification Threshold 1');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `notification_threshold_2` SET TAGS ('dbx_business_glossary_term' = 'Notification Threshold 2');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `overage_flag` SET TAGS ('dbx_business_glossary_term' = 'Overage Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `overage_quantity` SET TAGS ('dbx_business_glossary_term' = 'Overage Quantity');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `period_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Period End Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `period_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Period Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `remaining_quantity` SET TAGS ('dbx_business_glossary_term' = 'Remaining Quantity');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `roaming_flag` SET TAGS ('dbx_business_glossary_term' = 'Roaming Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `rollover_flag` SET TAGS ('dbx_business_glossary_term' = 'Rollover Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `rollover_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rollover Quantity');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `shared_balance_flag` SET TAGS ('dbx_business_glossary_term' = 'Shared Balance Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Balance Snapshot Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `throttle_action` SET TAGS ('dbx_business_glossary_term' = 'Throttle Action');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `throttle_status` SET TAGS ('dbx_business_glossary_term' = 'Throttle Status');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `throttle_status` SET TAGS ('dbx_value_regex' = 'not_throttled|throttled|pending_throttle');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `throttle_threshold_quantity` SET TAGS ('dbx_business_glossary_term' = 'Throttle Threshold Quantity');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `top_up_count` SET TAGS ('dbx_business_glossary_term' = 'Top-Up Count');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `zero_rated_flag` SET TAGS ('dbx_business_glossary_term' = 'Zero-Rated Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` SET TAGS ('dbx_subdomain' = 'data_processing');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `aggregated_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Aggregated Usage Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `analytics_segment_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `billing_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `iot_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Iot Deployment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Run Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `retention_model_output_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Model Output Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `sla_breach_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Breach Event Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `aggregation_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Period End Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `aggregation_period_type` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Period Type');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `aggregation_period_type` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|billing_cycle|real_time|custom');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `aggregation_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Period Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `aggregation_status` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Status');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `aggregation_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed|reprocessing');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `content_streaming_hours` SET TAGS ('dbx_business_glossary_term' = 'Content Streaming Hours');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `data_volume_mb_2g` SET TAGS ('dbx_business_glossary_term' = 'Data Volume Megabytes (MB) 2G');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `data_volume_mb_3g` SET TAGS ('dbx_business_glossary_term' = 'Data Volume Megabytes (MB) 3G');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `data_volume_mb_4g_lte` SET TAGS ('dbx_business_glossary_term' = 'Data Volume Megabytes (MB) 4G Long-Term Evolution (LTE)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `data_volume_mb_5g` SET TAGS ('dbx_business_glossary_term' = 'Data Volume Megabytes (MB) 5G New Radio (NR)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `data_volume_mb_roaming` SET TAGS ('dbx_business_glossary_term' = 'Data Volume Megabytes (MB) Roaming');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `data_volume_mb_wifi_offload` SET TAGS ('dbx_business_glossary_term' = 'Data Volume Megabytes (MB) Wi-Fi Offload');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `dpi_category_gaming_mb` SET TAGS ('dbx_business_glossary_term' = 'Deep Packet Inspection (DPI) Category Gaming Megabytes (MB)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `dpi_category_other_mb` SET TAGS ('dbx_business_glossary_term' = 'Deep Packet Inspection (DPI) Category Other Megabytes (MB)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `dpi_category_social_media_mb` SET TAGS ('dbx_business_glossary_term' = 'Deep Packet Inspection (DPI) Category Social Media Megabytes (MB)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `dpi_category_video_streaming_mb` SET TAGS ('dbx_business_glossary_term' = 'Deep Packet Inspection (DPI) Category Video Streaming Megabytes (MB)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `fair_use_policy_threshold_exceeded` SET TAGS ('dbx_business_glossary_term' = 'Fair Use Policy Threshold Exceeded Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `iptv_viewing_hours` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol Television (IPTV) Viewing Hours');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `mediation_source_system` SET TAGS ('dbx_business_glossary_term' = 'Mediation Source System');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `offpeak_usage_mb` SET TAGS ('dbx_business_glossary_term' = 'Off-Peak Usage Megabytes (MB)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `overage_data_mb` SET TAGS ('dbx_business_glossary_term' = 'Overage Data Megabytes (MB)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `overage_sms_count` SET TAGS ('dbx_business_glossary_term' = 'Overage Short Message Service (SMS) Count');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `overage_voice_minutes` SET TAGS ('dbx_business_glossary_term' = 'Overage Voice Minutes');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `peak_usage_mb` SET TAGS ('dbx_business_glossary_term' = 'Peak Usage Megabytes (MB)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `revenue_assurance_flag` SET TAGS ('dbx_business_glossary_term' = 'Revenue Assurance Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `revenue_assurance_flag` SET TAGS ('dbx_value_regex' = 'clean|anomaly_detected|under_review|reconciled');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `roaming_country_code` SET TAGS ('dbx_business_glossary_term' = 'Roaming Country Code');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `roaming_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `roaming_partner_network_code` SET TAGS ('dbx_business_glossary_term' = 'Roaming Partner Network Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `sms_count_international` SET TAGS ('dbx_business_glossary_term' = 'Short Message Service (SMS) Count International');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `sms_count_offnet` SET TAGS ('dbx_business_glossary_term' = 'Short Message Service (SMS) Count Off-Network');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `sms_count_onnet` SET TAGS ('dbx_business_glossary_term' = 'Short Message Service (SMS) Count On-Network');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `sms_count_roaming` SET TAGS ('dbx_business_glossary_term' = 'Short Message Service (SMS) Count Roaming');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `throttling_applied` SET TAGS ('dbx_business_glossary_term' = 'Throttling Applied Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `total_session_count` SET TAGS ('dbx_business_glossary_term' = 'Total Session Count');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `unique_cell_tower_count` SET TAGS ('dbx_business_glossary_term' = 'Unique Cell Tower Count');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `vod_rental_count` SET TAGS ('dbx_business_glossary_term' = 'Video on Demand (VoD) Rental Count');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `voice_minutes_international` SET TAGS ('dbx_business_glossary_term' = 'Voice Minutes International');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `voice_minutes_offnet` SET TAGS ('dbx_business_glossary_term' = 'Voice Minutes Off-Network');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `voice_minutes_onnet` SET TAGS ('dbx_business_glossary_term' = 'Voice Minutes On-Network');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `voice_minutes_roaming` SET TAGS ('dbx_business_glossary_term' = 'Voice Minutes Roaming');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` SET TAGS ('dbx_subdomain' = 'balance_oversight');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `anomaly_id` SET TAGS ('dbx_business_glossary_term' = 'Usage Anomaly Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `billing_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnect Carrier Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `cdr_id` SET TAGS ('dbx_business_glossary_term' = 'Call Detail Record (CDR) Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `detection_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Detection Rule Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `dq_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Dq Issue Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `rated_event_id` SET TAGS ('dbx_business_glossary_term' = 'Rated Event Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `retention_model_output_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Model Output Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `revenue_leakage_case_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Leakage Case Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Value');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `affected_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Affected Record Reference');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `anomaly_type` SET TAGS ('dbx_business_glossary_term' = 'Anomaly Type');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `detection_source_system` SET TAGS ('dbx_business_glossary_term' = 'Detection Source System');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `deviation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Deviation Percentage');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `expected_value` SET TAGS ('dbx_business_glossary_term' = 'Expected Value');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'new|assigned|in_progress|resolved|closed|false_positive');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Anomaly Reference Number');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^ANO-[0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `related_anomaly_count` SET TAGS ('dbx_business_glossary_term' = 'Related Anomaly Count');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `revenue_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Impact Amount');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `revenue_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `roaming_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Roaming Partner Code');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'system_error|data_quality|partner_issue|configuration_error|fraud|network_issue');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `usage_type` SET TAGS ('dbx_business_glossary_term' = 'Usage Type');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `usage_type` SET TAGS ('dbx_value_regex' = 'voice|sms|data|mms|roaming|content');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` SET TAGS ('dbx_subdomain' = 'balance_oversight');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `roaming_file_id` SET TAGS ('dbx_business_glossary_term' = 'Roaming File Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Roaming Agreement ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `mvno_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Mvno Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Run Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Processor Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `rap_file_id` SET TAGS ('dbx_business_glossary_term' = 'RAP (Returned Account Procedure) File ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `reconciliation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Run Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Roaming Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `acknowledgement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `call_event_count` SET TAGS ('dbx_business_glossary_term' = 'Call Event Count');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `clearing_house_name` SET TAGS ('dbx_business_glossary_term' = 'Clearing House Name');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `clearing_house_name` SET TAGS ('dbx_value_regex' = 'Syniverse|MACH|GRX|Direct');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `data_event_count` SET TAGS ('dbx_business_glossary_term' = 'Data Event Count');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `dispute_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Code');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `dispute_reason_code` SET TAGS ('dbx_value_regex' = 'rate_mismatch|duplicate_records|invalid_destination|missing_records|technical_error|other');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `file_available_timestamp` SET TAGS ('dbx_business_glossary_term' = 'File Available Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `file_checksum` SET TAGS ('dbx_business_glossary_term' = 'File Checksum');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `file_checksum` SET TAGS ('dbx_value_regex' = '^[a-fA-F0-9]{32,64}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `file_compression_type` SET TAGS ('dbx_business_glossary_term' = 'File Compression Type');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `file_compression_type` SET TAGS ('dbx_value_regex' = 'none|gzip|zip');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `file_generation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'File Generation Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `file_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'File Sequence Number');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size Bytes');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `file_status` SET TAGS ('dbx_business_glossary_term' = 'File Status');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `file_type_code` SET TAGS ('dbx_business_glossary_term' = 'File Type Code');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `file_type_code` SET TAGS ('dbx_value_regex' = 'TAP3|RAP|NRTRDE');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `iot_tariff_applied` SET TAGS ('dbx_business_glossary_term' = 'IOT (Inter-Operator Tariff) Applied');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `processing_notes` SET TAGS ('dbx_business_glossary_term' = 'Processing Notes');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `rap_file_generated_flag` SET TAGS ('dbx_business_glossary_term' = 'RAP (Returned Account Procedure) File Generated Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `recipient_tadig_code` SET TAGS ('dbx_business_glossary_term' = 'Recipient TADIG (Transferred Account Data Interchange Group) Code');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `recipient_tadig_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{2}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `sender_tadig_code` SET TAGS ('dbx_business_glossary_term' = 'Sender TADIG (Transferred Account Data Interchange Group) Code');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `sender_tadig_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{2}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `settlement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period End Date');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `settlement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period Start Date');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|disputed|cancelled');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `sms_event_count` SET TAGS ('dbx_business_glossary_term' = 'SMS (Short Message Service) Event Count');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `tap_file_name` SET TAGS ('dbx_business_glossary_term' = 'TAP (Transferred Account Procedure) File Name');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `tap_file_name` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{5}[A-Z0-9]{5}[A-Z]{3}[0-9]{5}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `tap_version` SET TAGS ('dbx_business_glossary_term' = 'TAP (Transferred Account Procedure) Version');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `tap_version` SET TAGS ('dbx_value_regex' = '^3.[0-9]{1,2}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `total_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Charge Amount');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `total_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Discount Amount');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `total_record_count` SET TAGS ('dbx_business_glossary_term' = 'Total Record Count');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `total_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `transmission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transmission Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `validation_error_count` SET TAGS ('dbx_business_glossary_term' = 'Validation Error Count');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|warning');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `validation_warning_count` SET TAGS ('dbx_business_glossary_term' = 'Validation Warning Count');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` SET TAGS ('dbx_subdomain' = 'event_capture');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `volte_session_id` SET TAGS ('dbx_business_glossary_term' = 'VoLTE (Voice over LTE) Session ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Roaming Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Visited Network ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `enterprise_site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `ims_node_id` SET TAGS ('dbx_business_glossary_term' = 'Ims Node Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Run Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `qos_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Qos Measurement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `ran_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Serving Cell ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `uc_subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Uc Subscription Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `call_direction` SET TAGS ('dbx_business_glossary_term' = 'Call Direction');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `call_direction` SET TAGS ('dbx_value_regex' = 'mobile_originated|mobile_terminated');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `call_setup_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Call Setup Time (Milliseconds)');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `call_type` SET TAGS ('dbx_business_glossary_term' = 'Call Type');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `call_type` SET TAGS ('dbx_value_regex' = 'voice|video|emergency');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `called_party_number` SET TAGS ('dbx_business_glossary_term' = 'Called Party Number');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `called_party_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `called_party_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `calling_party_number` SET TAGS ('dbx_business_glossary_term' = 'Calling Party Number');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `calling_party_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `calling_party_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `charged_amount` SET TAGS ('dbx_business_glossary_term' = 'Charged Amount');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `charged_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `charged_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `charging_type` SET TAGS ('dbx_business_glossary_term' = 'Charging Type');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `charging_type` SET TAGS ('dbx_value_regex' = 'postpaid|prepaid');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `codec_negotiated` SET TAGS ('dbx_business_glossary_term' = 'Codec Negotiated');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `codec_negotiated` SET TAGS ('dbx_value_regex' = 'AMR-NB|AMR-WB|EVS|G.711');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `emergency_call_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Call Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `handover_count` SET TAGS ('dbx_business_glossary_term' = 'Handover Count');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `imei` SET TAGS ('dbx_business_glossary_term' = 'IMEI (International Mobile Equipment Identity)');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `imei` SET TAGS ('dbx_value_regex' = '^[0-9]{15}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `imei` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `imei` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `ims_charging_reference` SET TAGS ('dbx_business_glossary_term' = 'IMS (IP Multimedia Subsystem) Charging Correlation ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `imsi` SET TAGS ('dbx_business_glossary_term' = 'IMSI (International Mobile Subscriber Identity)');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `imsi` SET TAGS ('dbx_value_regex' = '^[0-9]{15}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `imsi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `imsi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `jitter_ms` SET TAGS ('dbx_business_glossary_term' = 'Jitter (Milliseconds)');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `location_accuracy_meters` SET TAGS ('dbx_business_glossary_term' = 'Location Accuracy (Meters)');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Location Latitude');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Location Longitude');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `mediation_batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Mediation Batch ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `mos_score` SET TAGS ('dbx_business_glossary_term' = 'MOS (Mean Opinion Score)');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `msisdn` SET TAGS ('dbx_business_glossary_term' = 'MSISDN (Mobile Station International Subscriber Directory Number)');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `msisdn` SET TAGS ('dbx_value_regex' = '^[0-9]{10,15}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `msisdn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `msisdn` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `p_cscf_address` SET TAGS ('dbx_business_glossary_term' = 'P-CSCF (Proxy Call Session Control Function) Address');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `p_cscf_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `p_cscf_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `packet_loss_percent` SET TAGS ('dbx_business_glossary_term' = 'Packet Loss Percentage');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `qci` SET TAGS ('dbx_business_glossary_term' = 'QCI (QoS Class Identifier)');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `rat_type` SET TAGS ('dbx_business_glossary_term' = 'RAT (Radio Access Technology) Type');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `rat_type` SET TAGS ('dbx_value_regex' = 'LTE|5G_NR');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `roaming_flag` SET TAGS ('dbx_business_glossary_term' = 'Roaming Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `round_trip_delay_ms` SET TAGS ('dbx_business_glossary_term' = 'Round Trip Delay (Milliseconds)');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `s_cscf_address` SET TAGS ('dbx_business_glossary_term' = 'S-CSCF (Serving Call Session Control Function) Address');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `s_cscf_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `s_cscf_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `session_answer_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session Answer Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `session_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Session Duration (Seconds)');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `session_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session End Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `session_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `sip_session_reference` SET TAGS ('dbx_business_glossary_term' = 'SIP (Session Initiation Protocol) Session ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `sip_termination_code` SET TAGS ('dbx_business_glossary_term' = 'SIP (Session Initiation Protocol) Termination Code');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `srvcc_event_flag` SET TAGS ('dbx_business_glossary_term' = 'SRVCC (Single Radio Voice Call Continuity) Event Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `srvcc_target_rat` SET TAGS ('dbx_business_glossary_term' = 'SRVCC (Single Radio Voice Call Continuity) Target RAT (Radio Access Technology)');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `srvcc_target_rat` SET TAGS ('dbx_value_regex' = 'UMTS|GSM');
ALTER TABLE `telecommunication_ecm`.`usage`.`volte_session` ALTER COLUMN `termination_cause` SET TAGS ('dbx_business_glossary_term' = 'Termination Cause');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` SET TAGS ('dbx_subdomain' = 'data_processing');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `correction_id` SET TAGS ('dbx_business_glossary_term' = 'Usage Correction Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `billing_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Charge Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `billing_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Case Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Roaming Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `cdr_id` SET TAGS ('dbx_business_glossary_term' = 'Call Detail Record (CDR) Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Corrected Subscriber Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `correction_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiator User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `correction_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `correction_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `correction_original_subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Original Subscriber Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `correction_subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `credit_note_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `dq_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Dq Issue Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `rap_file_id` SET TAGS ('dbx_business_glossary_term' = 'Returned Account Procedure (RAP) File Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `rated_event_id` SET TAGS ('dbx_business_glossary_term' = 'Rated Event Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `regulatory_penalty_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Penalty Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `reversed_correction_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Correction Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `trouble_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Trouble Ticket Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `reversal_correction_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `application_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Application Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `corrected_call_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Corrected Call Duration (Seconds)');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `corrected_data_volume_bytes` SET TAGS ('dbx_business_glossary_term' = 'Corrected Data Volume (Bytes)');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `corrected_rated_amount` SET TAGS ('dbx_business_glossary_term' = 'Corrected Rated Amount');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `correction_status` SET TAGS ('dbx_business_glossary_term' = 'Correction Status');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `correction_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|applied|reversed');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `correction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Correction Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `correction_type` SET TAGS ('dbx_business_glossary_term' = 'Correction Type');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `correction_type` SET TAGS ('dbx_value_regex' = 'duplicate_removal|duration_adjustment|volume_correction|misrouted_cdr|subscriber_reassignment|test_call_removal');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `credit_note_generated_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Generated Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `initiator_type` SET TAGS ('dbx_business_glossary_term' = 'Initiator Type');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `initiator_type` SET TAGS ('dbx_value_regex' = 'subscriber_dispute|revenue_assurance|regulatory_audit|operator_error|system_mediation|roaming_partner');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `original_call_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Original Call Duration (Seconds)');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `original_data_volume_bytes` SET TAGS ('dbx_business_glossary_term' = 'Original Data Volume (Bytes)');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `original_rated_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Rated Amount');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `rap_file_generated_flag` SET TAGS ('dbx_business_glossary_term' = 'Returned Account Procedure (RAP) File Generated Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Correction Reason Code');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{3}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Correction Reason Description');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Correction Reference Number');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^COR-[0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `regulatory_audit_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Audit Reference');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `roaming_indicator` SET TAGS ('dbx_business_glossary_term' = 'Roaming Indicator');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`usage`.`correction` ALTER COLUMN `tap_file_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Transferred Account Procedure (TAP) File Sequence Number');
ALTER TABLE `telecommunication_ecm`.`usage`.`detection_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`usage`.`detection_rule` SET TAGS ('dbx_subdomain' = 'data_processing');
ALTER TABLE `telecommunication_ecm`.`usage`.`detection_rule` ALTER COLUMN `detection_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Detection Rule Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`detection_rule` ALTER COLUMN `derived_from_detection_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
