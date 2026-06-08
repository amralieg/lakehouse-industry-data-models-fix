-- Schema for Domain: usage | Business: Telecommunication | Version: v1_mvm
-- Generated on: 2026-05-08 08:31:46

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `telecommunication_ecm`.`usage` COMMENT 'SSOT for raw and processed usage event data — CDRs (voice, SMS, data), IPDR streams, DPI session records, roaming TAP/NRTRDE records, and content consumption events. Manages usage collection, mediation, aggregation, and feeds to real-time rating engines and revenue assurance analytics.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `telecommunication_ecm`.`usage`.`cdr` (
    `cdr_id` BIGINT COMMENT 'Unique identifier for the call detail record. Primary key for the CDR product.',
    `addon_id` BIGINT COMMENT 'Foreign key linking to product.addon. Business justification: CDRs generated for addon-specific services (international calling packs, roaming addons) must reference the addon product for correct rating, quota deduction, and revenue attribution. Telecom rating e',
    `carrier_id` BIGINT COMMENT 'Reference to the interconnect partner involved in call termination or origination.',
    `cdr_network_operator_carrier_id` BIGINT COMMENT 'Identifier of the network operator that handled the call (home or visited network).',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise voice CDRs must link to corporate accounts for B2B billing, cost allocation by department/site, invoice generation, and regulatory compliance reporting. Standard telecom B2B operations.',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: Call detail records must track originating CPE (router, STB, mobile hotspot) for device-specific troubleshooting, warranty claims, firmware correlation with call quality issues, and capacity planning ',
    `enterprise_contract_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_contract. Business justification: Voice CDRs must be attributed to the governing enterprise contract for minimum commitment tracking, volume discount tier validation, and contract compliance reporting. Telecom billing systems directly',
    `lawful_intercept_order_id` BIGINT COMMENT 'Foreign key linking to compliance.lawful_intercept_order. Business justification: CALEA/ETSI LI mandates that CDRs captured under a lawful intercept order be traceable to the authorizing order. Law enforcement delivery and chain-of-custody reporting require this link. Every telecom',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Enterprise CDRs for managed voice services must link to specific managed service instances for SLA monitoring, service-level billing, and contract compliance tracking in B2B telecommunications.',
    `mvno_profile_id` BIGINT COMMENT 'Foreign key linking to partner.mvno_profile. Business justification: CDRs from MVNO subscribers on the host network must be attributed to the MVNO profile for wholesale CDR delivery, MVNO billing, and IMSI range validation. Host operators deliver CDR feeds per MVNO pro',
    `nrtrde_record_id` BIGINT COMMENT 'Foreign key linking to interconnect.nrtrde_record. Business justification: NRTRDE (Near Real Time Roaming Data Exchange) records are derived from CDRs for roaming fraud detection per GSMA IR.21. Linking CDR to its NRTRDE record supports fraud investigation traceability and N',
    `original_cdr_id` BIGINT COMMENT 'Reference to the original CDR identifier if this record is a correction or reprocessed version.',
    `poi_id` BIGINT COMMENT 'Foreign key linking to interconnect.poi. Business justification: Interconnect CDR routing identifies the Point of Interconnect (POI) where traffic was handed off between carriers. cdr.trunk_group_code is a denormalized reference to poi.trunk_group_code; a proper FK',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: CDR rating engines require the active price plan at call time to calculate charges. Every rated CDR must reference the price plan used for billing reconciliation and revenue assurance audits.',
    `ran_cell_id` BIGINT COMMENT 'Identifier of the cell tower or base station that served the call.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to interconnect.rate. Business justification: Interconnect CDR rating applies wholesale interconnect rates to terminating/originating traffic. Revenue assurance and settlement dispute resolution require knowing which interconnect rate was applied',
    `rate_plan_id` BIGINT COMMENT 'Foreign key linking to billing.rate_plan. Business justification: CDRs are rated against a specific rate plan. The rating engine requires this link to apply correct tariffs, calculate charges, and support re-rating scenarios. A telecom billing expert would expect ev',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: CDRs are source data for regulatory traffic reports, interconnect reports, and revenue reports submitted to telecom authorities. Regulators require detailed call records for market oversight, dispute ',
    `roaming_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.roaming_agreement. Business justification: Each roaming CDR must reference the roaming agreement governing the call for TAP/RAP file generation, GSMA-compliant inter-operator settlement, and NRTRDE fraud threshold monitoring. Telecom interconn',
    `roaming_file_id` BIGINT COMMENT 'Foreign key linking to usage.roaming_file. Business justification: CDR records generated in roaming scenarios are transmitted via TAP (Transferred Account Procedure) files. The cdr table has tap_file_sequence_number (STRING) which is a denormalized reference to the f',
    `element_id` BIGINT COMMENT 'Foreign key linking to network.element. Business justification: CDRs are generated by network elements (MSC, SGSN, PGW). The serving_msc field is a denormalized string. Fault correlation between CDR generation failures and NE outages is a core NOC/revenue assuranc',
    `network_equipment_id` BIGINT COMMENT 'Foreign key linking to inventory.network_equipment. Business justification: MSC-level traffic analysis, equipment capacity planning, and fault-to-billing correlation require linking CDRs to the physical MSC asset. The cdr.serving_msc plain attribute is a denormalized equipmen',
    `slice_id` BIGINT COMMENT 'Foreign key linking to network.slice. Business justification: 5G CDRs must reference the network slice for slice-based charging and regulatory reporting. 3GPP standards require slice attribution (S-NSSAI) in charging records. Revenue assurance and slice tenant b',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber who originated or received the call.',
    `svc_instance_id` BIGINT COMMENT 'Foreign key linking to service.svc_instance. Business justification: CDRs must link to service instances for billing reconciliation, service quality analysis, dispute resolution, and regulatory reporting. Core telecom operation linking usage events to provisioned servi',
    `tap_file_id` BIGINT COMMENT 'Foreign key linking to interconnect.tap_file. Business justification: GSMA TAP3 compliance requires tracing which TAP file each roaming CDR was packaged into. TAP file reconciliation and resubmission workflows depend on knowing the CDR-to-TAP-file mapping for settlement',
    `tap_record_id` BIGINT COMMENT 'Foreign key linking to interconnect.tap_record. Business justification: Revenue assurance reconciliation requires tracing home-network CDRs to their corresponding TAP records submitted to visited networks. GSMA TAP3 reconciliation process depends on this link to detect di',
    `uc_subscription_id` BIGINT COMMENT 'Foreign key linking to enterprise.uc_subscription. Business justification: Voice CDRs generated by UC platform subscribers must be linked to the UC subscription for per-seat usage reporting, DID number utilization tracking, and UC contract compliance. Enterprise UC billing r',
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
    `source_system` STRING COMMENT 'Identifier of the source system that generated the CDR (MSC, SSF, IMS-AS, mediation platform).',
    `supplementary_service_codes` STRING COMMENT 'Comma-separated list of supplementary service codes active during the call (call forwarding, call waiting, etc.).',
    `terminating_number` STRING COMMENT 'The telephone number that received the call (B-party number).. Valid values are `^[0-9+]{10,15}$`',
    `termination_cause_code` STRING COMMENT 'Code indicating the reason for call termination (normal, busy, no answer, network failure, etc.).',
    `termination_cause_description` STRING COMMENT 'Human-readable description of the call termination reason.',
    CONSTRAINT pk_cdr PRIMARY KEY(`cdr_id`)
) COMMENT 'Call Detail Record — the authoritative raw usage event record for voice calls (MO/MT, VoLTE, IMS-based), capturing originating/terminating numbers, call start/end timestamps, duration, call type (local, national, international, roaming), network node identifiers, IMSI, IMEI, cell ID, trunk group, termination cause, and mediation processing status. Sourced from MSC/SSF/IMS-AS and processed through the mediation layer. SSOT for voice CDR data in the Silver layer.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`usage`.`sms_record` (
    `sms_record_id` BIGINT COMMENT 'Unique identifier for the SMS usage event record. Primary key for the SMS record entity.',
    `addon_id` BIGINT COMMENT 'Foreign key linking to product.addon. Business justification: SMS records generated under SMS addon packs (international SMS bundles, bulk SMS addons) must reference the addon product for correct quota deduction and addon revenue attribution. Telecom billing sys',
    `billing_account_id` BIGINT COMMENT 'Foreign key reference to the billing account that will be charged for this SMS event. May differ from subscriber_id in corporate or family plan scenarios.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to interconnect.interconnect_carrier. Business justification: Roaming SMS records require interconnect carrier identification for TAP file generation and settlement invoice reconciliation. Visited network code is denormalized carrier reference replaced by proper',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise SMS usage (M2M alerts, IoT messaging, corporate bulk SMS) requires corporate account linkage for billing, usage reporting, and cost center allocation in B2B telecommunications.',
    `cycle_id` BIGINT COMMENT 'Foreign key linking to billing.billing_cycle. Business justification: SMS records are aggregated per billing cycle to calculate included bundle consumption and overage charges. Telecom billing systems require this link to determine which billing period an SMS event belo',
    `fraud_alert_id` BIGINT COMMENT 'Foreign key linking to assurance.fraud_alert. Business justification: SMS fraud alerting: SMS pumping and spam campaign detection systems generate fraud alerts from individual SMS records. Direct link enables alert-to-evidence traceability required for fraud analyst wor',
    `fraud_case_id` BIGINT COMMENT 'Foreign key linking to assurance.fraud_case. Business justification: SMS fraud investigation: SMS records are key evidence in SMS pumping (IRSF), grey-route bypass, and smishing fraud cases. Fraud teams reference specific SMS records to calculate confirmed fraud loss a',
    `iot_deployment_id` BIGINT COMMENT 'Foreign key linking to enterprise.iot_deployment. Business justification: IoT SMS records (device alerts, M2M messaging, sensor notifications) must link to deployments for usage tracking, billing, and fleet-level messaging analytics in enterprise IoT telecommunications.',
    `lawful_intercept_order_id` BIGINT COMMENT 'Foreign key linking to compliance.lawful_intercept_order. Business justification: CALEA/ETSI LI intercept orders explicitly cover SMS metadata and content. Telecom operators must link intercepted SMS records to the authorizing court order for LEA delivery, chain-of-custody complian',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.line. Business justification: SMS records are generated for a specific ordered service line. Linking sms_record to order.line enables per-line SMS usage reporting, bundle consumption tracking, and billing reconciliation — standard',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: SMS services bundled within managed service packages (managed UC, IoT messaging) require SMS records linked to the managed service for usage reporting, SLA compliance monitoring, and managed service i',
    `element_id` BIGINT COMMENT 'Identifier of the network element (SMSC, MSC, or gateway) that generated this CDR. Used for network operations, fault correlation, and capacity planning.',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: SMS records must reference the product price plan for rating and allowance deduction, identical to how CDR and data_session link to price_plan. sms_record has rate_plan_id (billing domain) but lacks t',
    `ran_cell_id` BIGINT COMMENT 'Identifier of the radio cell or base station where the originating subscriber was located when the SMS was sent. Used for network analytics and location-based services.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to interconnect.rate. Business justification: SMS interconnect termination rates govern wholesale SMS billing between carriers. Revenue assurance teams verify correct interconnect rate application per SMS record; sms_record has rate_plan_id (reta',
    `rate_plan_id` BIGINT COMMENT 'Foreign key reference to the rate plan or tariff that was applied to rate this SMS event. Used for billing reconciliation and revenue assurance.',
    `roaming_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.roaming_agreement. Business justification: Roaming SMS records must reference the roaming agreement specifying sms_rate for GSMA TAP/RAP inter-operator settlement. sms_record has roaming_indicator confirming roaming SMS events occur; agreement',
    `roaming_file_id` BIGINT COMMENT 'Foreign key linking to usage.roaming_file. Business justification: SMS records in roaming scenarios are transmitted via TAP files alongside voice CDRs. The sms_record table has tap_file_sequence (STRING) which is a denormalized reference. Adding tap_file_id FK to roa',
    `sim_stock_id` BIGINT COMMENT 'Foreign key linking to inventory.sim_stock. Business justification: SMS fraud detection (spam scoring, SIM cloning) and lawful intercept compliance require linking each SMS record to the physical SIM. Operators correlate sms_record.spam_score with SIM batch quality an',
    `site_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_site. Business justification: Enterprise site-level SMS usage reporting is a standard corporate account management requirement. Multi-site enterprises need SMS consumption attributed per branch/campus for cost allocation, site-lev',
    `subscriber_id` BIGINT COMMENT 'Foreign key reference to the subscriber master record. Links this SMS usage event to the customer account for billing and analytics.',
    `svc_instance_id` BIGINT COMMENT 'Foreign key linking to service.svc_instance. Business justification: SMS records require service instance context for accurate rating, billing, service-level troubleshooting, and validating service entitlements. Standard practice in telecom mediation and billing system',
    `tap_record_id` BIGINT COMMENT 'Foreign key linking to interconnect.tap_record. Business justification: Roaming SMS records are packaged as TAP records for settlement with visited networks. SMS-specific TAP reconciliation and settlement dispute resolution require direct traceability from sms_record to t',
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
    `addon_id` BIGINT COMMENT 'Foreign key linking to product.addon. Business justification: Data sessions consumed under data addons (top-up packs, roaming data addons, speed boost addons) must reference the specific addon for quota deduction, expiry enforcement, and addon revenue reporting.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Data sessions must tie to billing account for charging, invoicing, and revenue recognition. Every data session is a billable event requiring account-level aggregation for postpaid billing cycles.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to interconnect.interconnect_carrier. Business justification: Roaming data sessions must link to interconnect carrier for NRTRDE near-real-time transmission, TAP file generation, and IoT tariff application. PLMN ID is denormalized carrier identifier.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise data sessions (mobile workforce, IoT devices, corporate APNs) must link to corporate accounts for usage-based billing, bandwidth reporting, and cost allocation across business units.',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: Data sessions require CPE device linkage for bandwidth throttling decisions, device-specific QoS policies, firmware performance analytics, and customer support escalations where device model/condition',
    `cycle_id` BIGINT COMMENT 'Foreign key linking to billing.billing_cycle. Business justification: Data sessions are aggregated per billing cycle to calculate allowance consumption, overage charges, and fair-use policy enforcement. The billing cycle governs data allowance reset periods — a fundamen',
    `enterprise_contract_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_contract. Business justification: Data sessions for enterprise customers must be attributed to the governing enterprise contract for minimum commitment tracking, wholesale agreement compliance, and contract-level data consumption repo',
    `fraud_alert_id` BIGINT COMMENT 'Foreign key linking to assurance.fraud_alert. Business justification: Data anomaly fraud detection: Unusual data consumption patterns (volume spikes, abnormal APN usage) trigger fraud alerts from individual data sessions. Direct link supports real-time fraud detection w',
    `fraud_case_id` BIGINT COMMENT 'Foreign key linking to assurance.fraud_case. Business justification: Data fraud investigation: Data sessions are evidence in SIM box fraud, unauthorized data reselling, and data exfiltration cases. Fraud investigators reference specific data sessions to establish fraud',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to order.fulfillment_order. Business justification: Links data session to provisioning order. Enables first-use validation (did broadband/mobile data activate as promised?), quality assurance (actual throughput vs. ordered speed), and regulatory compli',
    `iot_deployment_id` BIGINT COMMENT 'Foreign key linking to enterprise.iot_deployment. Business justification: IoT data sessions are the primary usage type for IoT deployments, requiring linkage for billing, device monitoring, data plan enforcement, and fleet-level connectivity analytics in enterprise IoT.',
    `ip_address_pool_id` BIGINT COMMENT 'Foreign key linking to inventory.ip_address_pool. Business justification: Sessions must reference the IP pool that allocated ue_ip_address for CGNAT port allocation tracking, IP address reclamation workflows, lawful intercept correlation, pool utilization analytics, and reg',
    `lawful_intercept_order_id` BIGINT COMMENT 'Foreign key linking to compliance.lawful_intercept_order. Business justification: Lawful intercept orders covering broadband/data services require data sessions to be linked to the authorizing order. CALEA and ETSI LI standards mandate that intercepted data session records referenc',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Data sessions for managed connectivity services must link to managed service instances for bandwidth monitoring, SLA compliance measurement, and service-level usage reporting in enterprise telecommuni',
    `mvno_profile_id` BIGINT COMMENT 'Foreign key linking to partner.mvno_profile. Business justification: Data sessions from MVNO subscribers must reference the MVNO profile for wholesale data billing, APN configuration validation, and QoS profile enforcement. data_session has apn as a plain attribute; MV',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: Data session rating requires the active price plan to apply tiered pricing, overage rates, and zero-rating policies. Essential for real-time charging and billing cycle aggregation in mobile data netwo',
    `qos_profile_id` BIGINT COMMENT 'Foreign key linking to network.qos_profile. Business justification: Data sessions inherit QoS profiles mapping QCI/5QI values to bearer characteristics (GBR, MBR, packet delay budget). Direct link enables session-level QoS analysis, SLA breach investigation, and corre',
    `ran_cell_id` BIGINT COMMENT 'Identifier of the radio cell where the session was initiated or primarily served. Used for geographic analysis and network optimization.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to interconnect.rate. Business justification: Roaming data sessions are rated using GSMA IOT (Inter-Operator Tariff) rates. Revenue assurance verification of correct IOT rate application per data session is a standard roaming settlement audit req',
    `rate_plan_id` BIGINT COMMENT 'Foreign key linking to billing.rate_plan. Business justification: Data sessions are rated against subscribers rate plan for charging (tiered data, fair use policy, overage). Rate plan determines pricing, throttling thresholds, and zero-rating eligibility.',
    `roaming_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.roaming_agreement. Business justification: Roaming data sessions must be linked to the roaming agreement specifying data_mb_rate and TAP/RAP processing rules for inter-operator settlement. Data roaming settlement requires session-to-agreement ',
    `roaming_file_id` BIGINT COMMENT 'Foreign key linking to usage.roaming_file. Business justification: Roaming data sessions originate from TAP/NRTRDE files received from visited network operators. The cdr and sms_record products already have roaming_file_id FKs to roaming_file, establishing a consiste',
    `topology_id` BIGINT COMMENT 'Foreign key linking to network.topology. Business justification: Fixed/broadband data sessions traverse specific network topologies (MPLS circuits, virtual circuits). Session-path correlation and fault impact analysis — when a topology link fails, operators must id',
    `transmission_link_id` BIGINT COMMENT 'Foreign key linking to network.transmission_link. Business justification: Fixed broadband and backhaul data sessions are delivered over specific transmission links. Fault correlation process: when a transmission link degrades, NOC must identify impacted active sessions for ',
    `sim_stock_id` BIGINT COMMENT 'Foreign key linking to inventory.sim_stock. Business justification: Data session APN policy enforcement and roaming profile validation require linking sessions to the physical SIMs profile_type and roaming_enabled flag. SIM-level data usage tracking supports eSIM pro',
    `site_id` BIGINT COMMENT 'Foreign key linking to enterprise.site. Business justification: Enterprise data sessions must link to sites for location-based usage tracking, bandwidth management per site, site-level performance reporting, and cost allocation in multi-location B2B operations.',
    `slice_id` BIGINT COMMENT 'Foreign key linking to network.slice. Business justification: 5G data sessions are instantiated within a specific network slice. Slice utilization reporting, per-slice SLA enforcement, and slice-based charging all require this link. Any 5G network architect expe',
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

CREATE OR REPLACE TABLE `telecommunication_ecm`.`usage`.`mediation_event` (
    `mediation_event_id` BIGINT COMMENT 'Unique identifier for the mediation event record. Primary key for tracking each raw usage event through the mediation lifecycle from collection to delivery.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Mediation events must be associated with a billing account for revenue assurance monitoring and mediation failure investigation. Telecom operations teams track unrated or rejected mediation events per',
    `carrier_id` BIGINT COMMENT 'Identifier of the visited network operator where roaming usage occurred. Used for inter-operator settlement and TAP file reconciliation.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Mediation events for enterprise traffic require corporate account attribution for enterprise-level mediation reporting, dispute resolution, and revenue assurance. Enterprise customers may dispute medi',
    `fraud_alert_id` BIGINT COMMENT 'Foreign key linking to assurance.fraud_alert. Business justification: Mediation fraud alerting: Anomalous patterns detected during CDR mediation (e.g., impossible roaming velocity, duplicate records) trigger fraud alerts. Direct link from mediation_event to fraud_alert ',
    `fraud_case_id` BIGINT COMMENT 'Foreign key linking to assurance.fraud_case. Business justification: Mediation-to-fraud pipeline: Mediation events flagged with rejection_flag or fraud-related rejection_reason_codes are escalated to fraud cases. The mediation layer is a primary fraud detection point; ',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.line. Business justification: Mediation events process raw usage for a specific service line. Linking mediation_event to order.line enables provisioning validation (confirming service is active and generating usage post-activation',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Mediation events for managed service traffic require managed service attribution for SLA monitoring, usage validation, and managed service billing reconciliation. Mediation processing for enterprise m',
    `element_id` BIGINT COMMENT 'Identifier of the source network element that generated the raw usage record (e.g., MSC, SGSN, GGSN, P-GW, OLT, BNG). Critical for tracing usage back to originating infrastructure.',
    `nrtrde_record_id` BIGINT COMMENT 'Foreign key linking to interconnect.nrtrde_record. Business justification: NRTRDE near-real-time fraud alerts trigger mediation events for immediate action. Linking mediation_event to nrtrde_record supports the GSMA NRTRDE fraud detection workflow where mediation systems act',
    `ran_cell_id` BIGINT COMMENT 'Identifier of the cell tower or base station serving the usage event. Used for location-based rating, network performance analysis, and regulatory compliance.',
    `cdr_id` BIGINT COMMENT 'Reference to the original raw usage event record (CDR, IPDR, TAP, or DPI session) collected from the network element before mediation processing.',
    `data_session_id` BIGINT COMMENT 'Foreign key linking to usage.data_session. Business justification: Mediation layer processes PGW/SGW/UPF-generated data session records (IPDRs, DPI streams) in addition to voice CDRs. The existing raw_cdr_id FK only covers voice events. Adding raw_data_session_id pro',
    `sms_record_id` BIGINT COMMENT 'Foreign key linking to usage.sms_record. Business justification: Mediation layer processes all raw usage event types including SMS/MMS. The existing raw_cdr_id FK covers voice CDRs, but there is no corresponding FK for SMS records processed through mediation. Addin',
    `roaming_file_id` BIGINT COMMENT 'Foreign key linking to usage.roaming_file. Business justification: Roaming usage events (TAP/NRTRDE records) arrive via roaming_file batches and are processed through the mediation layer. Linking mediation_event to the source roaming_file enables end-to-end traceabil',
    `sim_stock_id` BIGINT COMMENT 'Foreign key linking to inventory.sim_stock. Business justification: Mediation pipeline validates IMSI against active SIM inventory to categorize rejections (e.g., unknown IMSI, deactivated SIM). Linking mediation_event to sim_stock enables automated reprocessing decis',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber who generated this usage event. Links mediation event to customer account for rating and billing.',
    `svc_instance_id` BIGINT COMMENT 'Foreign key linking to service.svc_instance. Business justification: Mediation pipelines must resolve which service instance a raw network event belongs to for correct rating, routing, and enrichment. OSS mediation systems (e.g., Comptel, Ericsson BSCS) persist this re',
    `tap_file_id` BIGINT COMMENT 'Foreign key linking to interconnect.tap_file. Business justification: Mediation pipeline processes TAP files received from roaming partners. Linking mediation_event to tap_file identifies which TAP file processing triggered a mediation error or rejection event, critical',
    `tap_record_id` BIGINT COMMENT 'Foreign key linking to interconnect.tap_record. Business justification: Mediation systems process inbound TAP records from roaming partners. Linking mediation_event to tap_record enables TAP record processing audit trails, reprocessing workflows, and root cause analysis f',
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
    `addon_id` BIGINT COMMENT 'Foreign key linking to product.addon. Business justification: Balance buckets are frequently created by addon purchases (data packs, voice minute bundles, roaming addons). The balance must reference the governing addon for correct expiry management, consumption ',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to order.amendment. Business justification: A plan amendment (upgrade, downgrade, add-on change) directly triggers balance reallocation or reset mid-cycle. Linking balance to order.amendment enables tracking which amendment caused a balance cha',
    `billing_account_id` BIGINT COMMENT 'Reference to the billing account associated with this usage balance. Links to the billing account master record.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise shared data pool and group balance management requires balance records linked to the corporate account. Shared balance pools across enterprise subscribers are managed at the corporate accou',
    `cycle_id` BIGINT COMMENT 'Foreign key linking to billing.billing_cycle. Business justification: Balance buckets (voice, data, SMS) are period-bound and reset per billing cycle. The billing cycle governs balance expiry and renewal — essential for postpaid bundle management, rollover calculations,',
    `iot_deployment_id` BIGINT COMMENT 'Foreign key linking to enterprise.iot_deployment. Business justification: IoT deployment monthly data allowance tracking requires balance records linked to the IoT deployment. Each IoT deployment has a configured data allowance; balance records track consumption against tha',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.line. Business justification: A balance bucket (voice/data/SMS allowance) is provisioned per ordered service line. Linking balance to order.line enables allowance tracking per line, overage detection, and customer self-service rep',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Managed service data allowances and usage entitlements are tracked via balance records. Enterprise managed services include bundled data/voice allowances requiring balance attribution to the managed s',
    `prepaid_balance_id` BIGINT COMMENT 'Foreign key linking to billing.prepaid_balance. Business justification: Hybrid prepaid-postpaid scenarios require usage_balance (postpaid bundles) to reference prepaid_balance for unified balance management, cross-bucket consumption, and account migration.',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: Balance buckets are defined and governed by product price plans — the price plan determines initial balance quantities, rollover rules, and throttle thresholds. Balance management systems require this',
    `rate_plan_id` BIGINT COMMENT 'Foreign key linking to billing.rate_plan. Business justification: Usage balances (voice/SMS/data buckets) are defined by rate plan. Rate plan specifies initial balance, rollover rules, expiry, and top-up eligibility for postpaid bundles.',
    `slice_id` BIGINT COMMENT 'Foreign key linking to network.slice. Business justification: In 5G network slicing, quota/balance management is slice-specific — enterprise slice tenants have dedicated data allowances per slice. Slice-aware quota enforcement and throttling are real 5G charging',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber who owns this usage balance. Links to the subscriber master record.',
    `svc_instance_id` BIGINT COMMENT 'Foreign key linking to service.svc_instance. Business justification: Telecom charging systems (e.g., Ericsson IN, Huawei SCP) associate balance buckets with specific service instances for multi-SIM subscribers. Allowance enforcement, throttling decisions, and balance d',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this balance automatically renews at the end of the period. Defines renewal policy.',
    `balance_status` STRING COMMENT 'Current lifecycle status of the usage balance. Indicates whether the balance is available for consumption.. Valid values are `active|suspended|expired|depleted|throttled|terminated`',
    `balance_type` STRING COMMENT 'Type of usage balance being tracked. Categorizes the balance by service type.. Valid values are `voice|sms|data|content|monetary`',
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
    `addon_id` BIGINT COMMENT 'Foreign key linking to product.addon. Business justification: Aggregated usage must track addon-specific consumption (roaming addon data, international SMS pack usage) for product performance analytics, addon revenue reporting, and fair-use policy enforcement. T',
    `billing_account_id` BIGINT COMMENT 'Reference to the billing account under which this usage will be charged. Links to billing account master.',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to product.bundle. Business justification: Aggregated usage must be reportable at bundle level for shared data pool management, bundle performance analytics, and bundle revenue reporting. Telecom product and finance teams require bundle-level ',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: Usage-based customer segmentation (heavy data users, low-usage subscribers, roaming-heavy accounts) is a standard telecom campaign targeting method. Linking aggregated_usage to campaign enables campai',
    `carrier_agreement_id` BIGINT COMMENT 'Foreign key linking to interconnect.carrier_agreement. Business justification: Roaming minimum volume commitment monitoring and roaming revenue reporting require aggregating usage by carrier agreement. Carrier agreement terms (min_volume_commitment_units) are validated against a',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise aggregated usage summaries must link to corporate accounts for monthly billing cycles, invoice line item generation, and executive-level usage dashboards in B2B telecommunications operation',
    `cycle_id` BIGINT COMMENT 'The billing cycle identifier (e.g., 2024-01, cycle 202401) to which this aggregated usage belongs. Used for invoice generation alignment.',
    `discount_scheme_id` BIGINT COMMENT 'Foreign key linking to enterprise.discount_scheme. Business justification: Aggregated usage drives volume discount tier calculations — the discount scheme applied to a billing period is determined by aggregated consumption thresholds. Direct link enables automated discount s',
    `enterprise_contract_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_contract. Business justification: Aggregated usage is the primary input for enterprise contract minimum commitment tracking, volume discount tier calculation, and contract compliance reporting. Telecom billing systems require direct c',
    `iot_deployment_id` BIGINT COMMENT 'Foreign key linking to enterprise.iot_deployment. Business justification: Aggregated IoT usage must link to deployments for monthly billing, fleet-level analytics, data plan compliance monitoring, and executive reporting in enterprise IoT telecommunications operations.',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Aggregated usage must link to managed service instances for service-level billing, performance reporting, and SLA compliance tracking in enterprise managed connectivity and voice services.',
    `mvno_profile_id` BIGINT COMMENT 'Foreign key linking to partner.mvno_profile. Business justification: MVNO wholesale billing requires aggregated usage attributed per MVNO profile. Host operators aggregate subscriber usage by MVNO for wholesale invoicing and capacity reporting. A telecom MVNO operation',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Enterprise and consumer accounts consistently hitting data caps, high international roaming, or multi-line usage patterns trigger upsell/cross-sell opportunities. Telecom sales teams use aggregated us',
    `outage_record_id` BIGINT COMMENT 'Foreign key linking to assurance.outage_record. Business justification: Outage impact quantification: Aggregated usage drops during network outages are used to calculate impacted subscriber counts and revenue loss for outage records. Regulatory outage reporting requires u',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: Aggregated usage summaries must reference the price plan to correctly apply billing cycle allowances, overage thresholds, and proration rules. Required for invoice generation and customer bill present',
    `ran_cell_id` BIGINT COMMENT 'Foreign key linking to network.ran_cell. Business justification: Cell-level aggregated usage reports are a core radio network capacity planning and optimization input. The unique_cell_tower_count field signals denormalized cell data. RAN engineers aggregate usage p',
    `rate_plan_id` BIGINT COMMENT 'Foreign key linking to billing.rate_plan. Business justification: Aggregated usage summaries are segmented by rate plan to calculate overage charges, bundle exhaustion, and revenue analytics per plan tier. Billing operations require this link to generate accurate ov',
    `roaming_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.roaming_agreement. Business justification: Roaming usage aggregation (data_volume_mb_roaming, voice_minutes_roaming, sms_count_roaming) must reference the roaming agreement for inter-operator settlement calculation and TAP/RAP reconciliation. ',
    `sdwan_topology_id` BIGINT COMMENT 'Foreign key linking to enterprise.sdwan_topology. Business justification: SD-WAN topology-level aggregated usage reporting is required for SD-WAN managed service SLA compliance, capacity planning, and monthly managed service invoicing. Enterprise customers receive per-topol',
    `settlement_run_id` BIGINT COMMENT 'Foreign key linking to partner.settlement_run. Business justification: Settlement runs consume aggregated usage as primary input for inter-partner charge calculation. Linking aggregated_usage to settlement_run enables full traceability from settlement amounts back to usa',
    `site_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_site. Business justification: Site-level aggregated usage reporting is a standard enterprise service requirement — multi-site corporate customers receive per-site bandwidth and data consumption summaries for cost allocation, capac',
    `sla_profile_id` BIGINT COMMENT 'Foreign key linking to service.sla_profile. Business justification: SLA compliance reporting joins aggregated usage totals against SLA profile thresholds (uptime, data caps, MTTR). Telecom operations teams require this link to generate SLA breach reports and customer ',
    `slice_id` BIGINT COMMENT 'Foreign key linking to network.slice. Business justification: 5G slice-level usage aggregation is required for slice SLA reporting and enterprise/MVNO tenant billing. Operators must aggregate total data consumed per slice per billing period. Slice tenant invoici',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber for whom usage is aggregated. Links to the subscriber master entity.',
    `svc_instance_id` BIGINT COMMENT 'Reference to the specific service instance (mobile line, broadband connection, IPTV subscription) for which usage is aggregated.',
    `uc_subscription_id` BIGINT COMMENT 'Foreign key linking to enterprise.uc_subscription. Business justification: UC subscription seat utilization, call minute consumption, and DID usage aggregation are core enterprise UC billing and SLA reporting requirements. Aggregated usage must be linked to UC subscriptions ',
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
    `alarm_event_id` BIGINT COMMENT 'Foreign key linking to assurance.alarm_event. Business justification: Usage-network alarm correlation: Revenue assurance teams correlate usage anomalies with network alarm events to distinguish network-caused anomalies from fraud or billing errors. This cross-domain cor',
    `billing_charge_id` BIGINT COMMENT 'Foreign key linking to billing.billing_charge. Business justification: Usage anomalies (unexpected spikes, zero-rated fraud, duplicate charges) are investigated against specific billing charges for revenue assurance and dispute resolution. Telecom revenue assurance teams',
    `billing_dispute_id` BIGINT COMMENT 'Foreign key linking to billing.dispute. Business justification: Usage anomalies (unexpected charges, fraud, rating errors) frequently trigger billing disputes. Direct link required for dispute investigation, evidence gathering, and resolution tracking.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to interconnect.interconnect_carrier. Business justification: Revenue assurance and fraud detection on roaming traffic require carrier identification for dispute escalation, pattern analysis across carriers, and regulatory reporting. Network codes are denormaliz',
    `cdr_id` BIGINT COMMENT 'Reference to the source CDR, IPDR, or usage event record that triggered this anomaly detection.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise-level revenue assurance and fraud management requires anomalies attributed to the corporate account for account-level fraud scoring, enterprise customer dispute resolution, and regulatory r',
    `data_breach_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.data_breach_incident. Business justification: Usage anomalies (mass data exfiltration patterns, abnormal CDR volumes) are primary evidence in data breach investigations. Compliance teams investigating a breach under GDPR/breach notification oblig',
    `fraud_alert_id` BIGINT COMMENT 'Foreign key linking to assurance.fraud_alert. Business justification: Anomaly-to-alert traceability: Usage anomalies trigger fraud alerts in the assurance domain. Revenue assurance analysts need direct linkage from the detected anomaly to the generated fraud alert to tr',
    `fraud_case_id` BIGINT COMMENT 'Foreign key linking to assurance.fraud_case. Business justification: Revenue assurance to fraud escalation: Usage anomalies (anomaly product) that exceed fraud thresholds are escalated to fraud cases. This is a core revenue assurance workflow — anomaly detection feeds ',
    `iot_deployment_id` BIGINT COMMENT 'Foreign key linking to enterprise.iot_deployment. Business justification: Usage anomalies in IoT deployments (unexpected data consumption by IoT devices, SIM cloning, unauthorized roaming) are a critical fraud and revenue assurance use case. Direct link to iot_deployment en',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Anomalies in managed service usage (unexpected traffic spikes on managed WAN circuits, SLA-impacting events) must be linked to the managed service for SLA breach assessment, NOC incident correlation, ',
    `element_id` BIGINT COMMENT 'Foreign key linking to network.element. Business justification: Usage anomalies (fraud, revenue leakage, duplicate CDRs) are correlated to specific network elements for root cause analysis. Revenue assurance teams identify whether anomalous patterns originate from',
    `network_equipment_id` BIGINT COMMENT 'Foreign key linking to inventory.network_equipment. Business justification: Equipment-level billing anomalies (e.g., MSC generating duplicate CDRs, faulty mediation node causing rating errors) require direct anomaly-to-network_equipment linkage for root cause analysis, mainte',
    `ran_cell_id` BIGINT COMMENT 'Foreign key linking to network.ran_cell. Business justification: Usage anomalies such as abnormal data volumes or call patterns from a specific cell are correlated to RAN cells for fraud detection and network abuse investigation. Fraud management systems flag cell-',
    `rate_id` BIGINT COMMENT 'Foreign key linking to interconnect.rate. Business justification: Rate anomaly detection — identifying CDRs/sessions rated at incorrect interconnect rates — is a core revenue assurance use case. Linking anomaly to the offending interconnect rate supports root cause ',
    `rated_event_id` BIGINT COMMENT 'Foreign key linking to billing.rated_event. Business justification: Usage anomalies (revenue leakage, fraud, rating errors) are often detected on rated events. Direct link required for investigation, re-rating, and revenue assurance workflows.',
    `roaming_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.roaming_agreement. Business justification: Revenue assurance and fraud anomalies on roaming traffic must reference the roaming agreement for NRTRDE threshold breach reporting, partner dispute initiation, and fraud_monitoring_enabled validation',
    `roaming_file_id` BIGINT COMMENT 'Foreign key linking to usage.roaming_file. Business justification: Roaming file-level anomalies are a distinct category in telecom revenue assurance — TAP file checksum failures, settlement amount discrepancies, TADIG code mismatches, and RAP (Returned Account Proced',
    `settlement_dispute_id` BIGINT COMMENT 'Foreign key linking to interconnect.settlement_dispute. Business justification: Revenue assurance anomalies on roaming usage directly trigger interconnect settlement disputes. The anomaly-to-dispute escalation workflow requires linking the detected anomaly to the resulting settle',
    `settlement_run_id` BIGINT COMMENT 'Foreign key linking to partner.settlement_run. Business justification: Anomalies detected during settlement reconciliation must be linked to the settlement run for variance investigation and adjustment processing. Settlement operations teams investigate reconciliation_va',
    `sim_stock_id` BIGINT COMMENT 'Foreign key linking to inventory.sim_stock. Business justification: SIM cloning and IMSI fraud investigations require direct anomaly-to-SIM linkage to trigger SIM suspension workflows independent of which usage record detected the anomaly. Fraud operations teams need ',
    `site_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_site. Business justification: Usage anomalies detected at specific enterprise sites (unusual data consumption at a branch, fraud at a campus) are a core revenue assurance and fraud management use case. Site-level anomaly attributi',
    `sla_breach_event_id` BIGINT COMMENT 'Foreign key linking to assurance.sla_breach_event. Business justification: SLA breach correlation: Usage anomalies (e.g., anomalous data session quality, CDR volume drops) are correlated with SLA breach events for root cause analysis and penalty calculation. Revenue assuranc',
    `sms_record_id` BIGINT COMMENT 'Foreign key linking to usage.sms_record. Business justification: Revenue assurance anomalies are detected across all usage event types. The existing anomaly.cdr_id covers voice CDR anomalies, but there is no FK for SMS-related anomalies (e.g., SMS fraud, abnormal m',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber associated with the anomalous usage event.',
    `svc_instance_id` BIGINT COMMENT 'Foreign key linking to service.svc_instance. Business justification: Fraud management and revenue assurance workflows require linking usage anomalies directly to the service instance under investigation. Anomaly-triggered suspension, SIM swap fraud detection, and reven',
    `tap_record_id` BIGINT COMMENT 'Foreign key linking to interconnect.tap_record. Business justification: Revenue assurance anomalies detected on roaming TAP records (e.g., overcharging by visited network) require direct reference to the offending tap_record for settlement dispute filing and evidence subm',
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
    `resolution_action` STRING COMMENT 'Description of the corrective action taken to resolve the anomaly (e.g., CDR reprocessed, duplicate removed, billing adjustment issued, partner notified, system configuration corrected).',
    `resolution_timestamp` TIMESTAMP COMMENT 'Timestamp when the anomaly investigation was resolved and corrective action completed.',
    `revenue_impact_amount` DECIMAL(18,2) COMMENT 'Estimated revenue impact (leakage or overcharge) resulting from the anomaly, in the billing currency.',
    `root_cause_category` STRING COMMENT 'High-level category of the identified root cause: system error (software or hardware malfunction), data quality (incomplete or malformed data), partner issue (roaming or interconnect partner data problem), configuration error (incorrect system setup), fraud (suspected fraudulent activity), network issue (network element failure or misconfiguration).. Valid values are `system_error|data_quality|partner_issue|configuration_error|fraud|network_issue`',
    `root_cause_description` STRING COMMENT 'Detailed description of the identified root cause of the anomaly, documented during investigation.',
    `severity_level` STRING COMMENT 'Business impact severity of the anomaly: critical (immediate revenue or fraud risk), high (significant revenue leakage potential), medium (moderate impact requiring investigation), low (minor discrepancy with minimal impact).. Valid values are `critical|high|medium|low`',
    `usage_type` STRING COMMENT 'Type of usage event associated with the anomaly: voice (voice call), sms (short message service), data (mobile data session), mms (multimedia messaging), roaming (roaming usage event), content (IPTV or OTT content consumption).. Valid values are `voice|sms|data|mms|roaming|content`',
    CONSTRAINT pk_anomaly PRIMARY KEY(`anomaly_id`)
) COMMENT 'Operational record of detected usage anomalies flagged during mediation or revenue assurance processing — anomaly type (duplicate CDR, missing sequence, volume spike, zero-duration call, grey route indicator), detection timestamp, affected record reference, severity level, assigned investigation status, and resolution action. Feeds revenue assurance and fraud operations workflows without being an analytics construct.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`usage`.`roaming_file` (
    `roaming_file_id` BIGINT COMMENT 'Primary key for roaming_file',
    `carrier_agreement_id` BIGINT COMMENT 'Reference to the bilateral roaming agreement governing the commercial terms for this TAP file exchange.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to interconnect.carrier. Business justification: Roaming files are exchanged with specific carriers identified by TADIG codes. roaming_file has sender_tadig_code and recipient_tadig_code as denormalized plain attributes; replacing with a proper FK t',
    `cycle_id` BIGINT COMMENT 'Foreign key linking to billing.billing_cycle. Business justification: Roaming settlement files cover periods that must align with billing cycles for inter-operator charge reconciliation. Telecom finance teams require this link to match roaming file settlement periods to',
    `fraud_case_id` BIGINT COMMENT 'Foreign key linking to assurance.fraud_case. Business justification: Roaming fraud investigation: TAP/RAP roaming files are primary evidence in IRSF, SIM cloning in roaming, and bypass fraud cases. Fraud teams reference specific roaming files to calculate confirmed roa',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Roaming TAP/RAP files drive inter-operator settlement charges that are billed via invoices. Linking roaming_file to invoice enables reconciliation of roaming settlement amounts against billed amounts ',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Roaming TAP/RAP settlement files must be included in regulatory filings to national telecom authorities (BEREC roaming reports, national regulator submissions on roaming volumes and charges). Linking ',
    `roaming_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.roaming_agreement. Business justification: Each TAP/RAP roaming file is processed under a specific roaming agreement governing tap_version, rap_version, settlement_period_days, and fraud_threshold_amount. roaming_file already has carrier_agree',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: TAP files are exchanged with specific roaming partners for usage reconciliation and settlement. Critical for identifying which partner sent/received the file, dispute resolution, and revenue assurance',
    `tap_file_id` BIGINT COMMENT 'Foreign key linking to interconnect.tap_file. Business justification: GSMA TAP3 reconciliation requires matching home-network roaming files against TAP files exchanged with visited networks. Direct roaming_file to tap_file link enables settlement reconciliation, identif',
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
    `settlement_date` DATE COMMENT 'Date when the financial settlement for this TAP file was completed and payment was processed.',
    `settlement_period_end_date` DATE COMMENT 'End date of the billing/settlement period covered by the usage events in this TAP file.',
    `settlement_period_start_date` DATE COMMENT 'Start date of the billing/settlement period covered by the usage events in this TAP file.',
    `settlement_status` STRING COMMENT 'Current status of the financial settlement process for this TAP file between the operators.. Valid values are `pending|in_progress|completed|disputed|cancelled`',
    `sms_event_count` BIGINT COMMENT 'Number of SMS message events (Mobile Originated SMS and Mobile Terminated SMS) in the TAP file.',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_original_cdr_id` FOREIGN KEY (`original_cdr_id`) REFERENCES `telecommunication_ecm`.`usage`.`cdr`(`cdr_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ADD CONSTRAINT `fk_usage_cdr_roaming_file_id` FOREIGN KEY (`roaming_file_id`) REFERENCES `telecommunication_ecm`.`usage`.`roaming_file`(`roaming_file_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ADD CONSTRAINT `fk_usage_sms_record_roaming_file_id` FOREIGN KEY (`roaming_file_id`) REFERENCES `telecommunication_ecm`.`usage`.`roaming_file`(`roaming_file_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ADD CONSTRAINT `fk_usage_data_session_roaming_file_id` FOREIGN KEY (`roaming_file_id`) REFERENCES `telecommunication_ecm`.`usage`.`roaming_file`(`roaming_file_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ADD CONSTRAINT `fk_usage_mediation_event_cdr_id` FOREIGN KEY (`cdr_id`) REFERENCES `telecommunication_ecm`.`usage`.`cdr`(`cdr_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ADD CONSTRAINT `fk_usage_mediation_event_data_session_id` FOREIGN KEY (`data_session_id`) REFERENCES `telecommunication_ecm`.`usage`.`data_session`(`data_session_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ADD CONSTRAINT `fk_usage_mediation_event_sms_record_id` FOREIGN KEY (`sms_record_id`) REFERENCES `telecommunication_ecm`.`usage`.`sms_record`(`sms_record_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ADD CONSTRAINT `fk_usage_mediation_event_roaming_file_id` FOREIGN KEY (`roaming_file_id`) REFERENCES `telecommunication_ecm`.`usage`.`roaming_file`(`roaming_file_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_cdr_id` FOREIGN KEY (`cdr_id`) REFERENCES `telecommunication_ecm`.`usage`.`cdr`(`cdr_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_roaming_file_id` FOREIGN KEY (`roaming_file_id`) REFERENCES `telecommunication_ecm`.`usage`.`roaming_file`(`roaming_file_id`);
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ADD CONSTRAINT `fk_usage_anomaly_sms_record_id` FOREIGN KEY (`sms_record_id`) REFERENCES `telecommunication_ecm`.`usage`.`sms_record`(`sms_record_id`);

-- ========= TAGS =========
ALTER SCHEMA `telecommunication_ecm`.`usage` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `telecommunication_ecm`.`usage` SET TAGS ('dbx_domain' = 'usage');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` SET TAGS ('dbx_subdomain' = 'event_capture');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `cdr_id` SET TAGS ('dbx_business_glossary_term' = 'Call Detail Record (CDR) Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `addon_id` SET TAGS ('dbx_business_glossary_term' = 'Addon Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnect Partner Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `cdr_network_operator_carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Network Operator Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `enterprise_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `lawful_intercept_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lawful Intercept Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `mvno_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Mvno Profile Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `nrtrde_record_id` SET TAGS ('dbx_business_glossary_term' = 'Nrtrde Record Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `original_cdr_id` SET TAGS ('dbx_business_glossary_term' = 'Original Call Detail Record (CDR) Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `poi_id` SET TAGS ('dbx_business_glossary_term' = 'Poi Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `ran_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Cell Identifier (Cell ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `roaming_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Roaming Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `roaming_file_id` SET TAGS ('dbx_business_glossary_term' = 'Tap File Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Serving Element Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Serving Msc Network Equipment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `slice_id` SET TAGS ('dbx_business_glossary_term' = 'Slice Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `tap_file_id` SET TAGS ('dbx_business_glossary_term' = 'Tap File Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `tap_record_id` SET TAGS ('dbx_business_glossary_term' = 'Tap Record Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `uc_subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Uc Subscription Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `supplementary_service_codes` SET TAGS ('dbx_business_glossary_term' = 'Supplementary Service Codes');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `terminating_number` SET TAGS ('dbx_business_glossary_term' = 'Terminating Number');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `terminating_number` SET TAGS ('dbx_value_regex' = '^[0-9+]{10,15}$');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `terminating_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `terminating_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `termination_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Cause Code');
ALTER TABLE `telecommunication_ecm`.`usage`.`cdr` ALTER COLUMN `termination_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Termination Cause Description');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` SET TAGS ('dbx_subdomain' = 'event_capture');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `sms_record_id` SET TAGS ('dbx_business_glossary_term' = 'Short Message Service (SMS) Record Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `addon_id` SET TAGS ('dbx_business_glossary_term' = 'Addon Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnect Carrier Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `fraud_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `iot_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Iot Deployment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `lawful_intercept_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lawful Intercept Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Network Element Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `ran_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Cell Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `roaming_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Roaming Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `roaming_file_id` SET TAGS ('dbx_business_glossary_term' = 'Tap File Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `sim_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Sim Stock Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`sms_record` ALTER COLUMN `tap_record_id` SET TAGS ('dbx_business_glossary_term' = 'Tap Record Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `addon_id` SET TAGS ('dbx_business_glossary_term' = 'Addon Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnect Carrier Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `enterprise_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `fraud_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `iot_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Iot Deployment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Address Pool Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `lawful_intercept_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lawful Intercept Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `mvno_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Mvno Profile Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `qos_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Qos Profile Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `ran_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Cell Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `roaming_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Roaming Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `roaming_file_id` SET TAGS ('dbx_business_glossary_term' = 'Roaming File Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `topology_id` SET TAGS ('dbx_business_glossary_term' = 'Serving Topology Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `transmission_link_id` SET TAGS ('dbx_business_glossary_term' = 'Serving Transmission Link Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `sim_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Sim Stock Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`data_session` ALTER COLUMN `slice_id` SET TAGS ('dbx_business_glossary_term' = 'Slice Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` SET TAGS ('dbx_subdomain' = 'processing_control');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `mediation_event_id` SET TAGS ('dbx_business_glossary_term' = 'Mediation Event Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Roaming Partner Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `fraud_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Network Element Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `nrtrde_record_id` SET TAGS ('dbx_business_glossary_term' = 'Nrtrde Record Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `ran_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Cell Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `cdr_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Call Detail Record (CDR) Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `data_session_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Data Session Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `sms_record_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Sms Record Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `roaming_file_id` SET TAGS ('dbx_business_glossary_term' = 'Roaming File Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `sim_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Sim Stock Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Svc Instance Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `tap_file_id` SET TAGS ('dbx_business_glossary_term' = 'Tap File Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`mediation_event` ALTER COLUMN `tap_record_id` SET TAGS ('dbx_business_glossary_term' = 'Tap Record Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` SET TAGS ('dbx_subdomain' = 'subscriber_consumption');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `balance_id` SET TAGS ('dbx_business_glossary_term' = 'Usage Balance Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `addon_id` SET TAGS ('dbx_business_glossary_term' = 'Addon Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `iot_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Iot Deployment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `prepaid_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Prepaid Balance Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `slice_id` SET TAGS ('dbx_business_glossary_term' = 'Slice Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Svc Instance Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `balance_status` SET TAGS ('dbx_business_glossary_term' = 'Balance Status');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `balance_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|depleted|throttled|terminated');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `balance_type` SET TAGS ('dbx_business_glossary_term' = 'Balance Type');
ALTER TABLE `telecommunication_ecm`.`usage`.`balance` ALTER COLUMN `balance_type` SET TAGS ('dbx_value_regex' = 'voice|sms|data|content|monetary');
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
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` SET TAGS ('dbx_subdomain' = 'subscriber_consumption');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `aggregated_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Aggregated Usage Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `addon_id` SET TAGS ('dbx_business_glossary_term' = 'Addon Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `discount_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Discount Scheme Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `enterprise_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `iot_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Iot Deployment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `mvno_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Mvno Profile Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `outage_record_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Record Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `ran_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Ran Cell Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `roaming_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Roaming Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `sdwan_topology_id` SET TAGS ('dbx_business_glossary_term' = 'Sdwan Topology Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `settlement_run_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Run Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `sla_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Profile Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `slice_id` SET TAGS ('dbx_business_glossary_term' = 'Slice Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`aggregated_usage` ALTER COLUMN `uc_subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Uc Subscription Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` SET TAGS ('dbx_subdomain' = 'processing_control');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `anomaly_id` SET TAGS ('dbx_business_glossary_term' = 'Usage Anomaly Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `alarm_event_id` SET TAGS ('dbx_business_glossary_term' = 'Alarm Event Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `billing_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Charge Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `billing_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnect Carrier Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `cdr_id` SET TAGS ('dbx_business_glossary_term' = 'Call Detail Record (CDR) Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `data_breach_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Data Breach Incident Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `fraud_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `iot_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Iot Deployment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Network Element Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Network Equipment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `ran_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Ran Cell Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `rated_event_id` SET TAGS ('dbx_business_glossary_term' = 'Rated Event Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `roaming_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Roaming Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `roaming_file_id` SET TAGS ('dbx_business_glossary_term' = 'Roaming File Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `settlement_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Dispute Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `settlement_run_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Run Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `sim_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Sim Stock Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `sla_breach_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Breach Event Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `sms_record_id` SET TAGS ('dbx_business_glossary_term' = 'Sms Record Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Svc Instance Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `tap_record_id` SET TAGS ('dbx_business_glossary_term' = 'Tap Record Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `revenue_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Impact Amount');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `revenue_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'system_error|data_quality|partner_issue|configuration_error|fraud|network_issue');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `usage_type` SET TAGS ('dbx_business_glossary_term' = 'Usage Type');
ALTER TABLE `telecommunication_ecm`.`usage`.`anomaly` ALTER COLUMN `usage_type` SET TAGS ('dbx_value_regex' = 'voice|sms|data|mms|roaming|content');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` SET TAGS ('dbx_subdomain' = 'event_capture');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `roaming_file_id` SET TAGS ('dbx_business_glossary_term' = 'Roaming File Identifier');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Roaming Agreement ID');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Carrier Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `roaming_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Roaming Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Roaming Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `tap_file_id` SET TAGS ('dbx_business_glossary_term' = 'Tap File Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `settlement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period End Date');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `settlement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period Start Date');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|disputed|cancelled');
ALTER TABLE `telecommunication_ecm`.`usage`.`roaming_file` ALTER COLUMN `sms_event_count` SET TAGS ('dbx_business_glossary_term' = 'SMS (Short Message Service) Event Count');
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
