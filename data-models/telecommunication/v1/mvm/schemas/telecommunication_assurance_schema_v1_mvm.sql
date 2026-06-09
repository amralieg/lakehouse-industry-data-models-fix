-- Schema for Domain: assurance | Business: Telecommunication | Version: v1_mvm
-- Generated on: 2026-05-08 08:31:42

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `telecommunication_ecm`.`assurance` COMMENT 'SSOT for network fault management, performance monitoring, revenue assurance, and service quality operations — alarm events, trouble tickets, SLA breach tracking, MTTR/MTBF KPIs, NOC/SOC incident records, fraud detection, leakage detection, and reconciliation. Integrates Nokia NetAct, Ericsson NM, and ServiceNow ITSM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `telecommunication_ecm`.`assurance`.`alarm_event` (
    `alarm_event_id` BIGINT COMMENT 'Unique identifier for the network alarm event record. Primary key for the alarm event entity.',
    `addon_id` BIGINT COMMENT 'Foreign key linking to product.addon. Business justification: Alarms are raised for specific add-on service failures (e.g., VoIP add-on connectivity alarm, roaming add-on activation failure alarm). Add-on-level alarm tracking enables targeted fault management an',
    `ip_address_pool_id` BIGINT COMMENT 'Foreign key linking to inventory.ip_address_pool. Business justification: IP pool exhaustion and CGNAT threshold breach alarms are raised in OSS/NMS systems. Linking alarm_event to ip_address_pool supports IP resource capacity management, automated pool expansion triggers, ',
    `svc_instance_id` BIGINT COMMENT 'Foreign key linking to service.svc_instance. Business justification: Network element alarms affect specific service instances. Required for proactive customer notification, service impact assessment, and correlating network events to customer experience degradation.',
    `kpi_threshold_id` BIGINT COMMENT 'Reference to the alarm suppression rule applied to this alarm event, if any. Used for managing alarm storms and maintenance windows.',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: When managed_object_class=CPE, correlates customer equipment alarms (offline, low signal, reboot loops) with specific device serial numbers for remote troubleshooting, warranty claims, and proactive',
    `network_equipment_id` BIGINT COMMENT 'Foreign key linking to inventory.network_equipment. Business justification: NOC alarm-to-asset correlation: alarms raised against physical network equipment (routers, BTS, switches) must link to the inventory record for maintenance scheduling, MTBF analysis, and vendor escala',
    `olt_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.olt_asset. Business justification: OLT alarms (PON port failures, optical power degradation) are critical in fiber networks. Linking alarm_event to the specific OLT asset supports fiber NOC operations, OLT maintenance scheduling, and m',
    `ont_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.ont_asset. Business justification: When managed_object_class=ONT, links fiber access alarms (LOS, dying gasp, high temperature) to specific ONT serial numbers for technician dispatch optimization and vendor quality analysis.',
    `element_id` BIGINT COMMENT 'Reference to the network element (RAN, transport, core, GPON, FTTH node) that raised this alarm.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: Alarms are raised for service-affecting events tied to specific offerings. Offering-level alarm aggregation drives product quality monitoring and SLA breach detection. alarm_event has catalog_item_id ',
    `poi_id` BIGINT COMMENT 'Foreign key linking to interconnect.poi. Business justification: Alarms are raised against POIs for circuit failures, capacity threshold breaches, and signalling errors. alarm_event has network_element_id but POI is a distinct interconnect entity; direct POI refere',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Alarm events on regulated network infrastructure (emergency services, licensed spectrum) trigger mandatory regulatory reporting obligations. Telecom NOC and compliance teams must trace which regulator',
    `site_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_site. Business justification: Enterprise site alarm correlation: alarms on CPE or network elements at enterprise sites must link to the site for managed service monitoring dashboards, enterprise customer portal visibility, and pro',
    `acknowledged_by_user` STRING COMMENT 'Username or identifier of the NOC or SOC operator who acknowledged this alarm event.',
    `actual_resolution_minutes` STRING COMMENT 'Actual time in minutes from alarm raised to alarm cleared. Used for MTTR KPI calculation and SLA compliance reporting.',
    `affected_service_type` STRING COMMENT 'Type of customer service potentially impacted by this alarm event (e.g., mobile_voice, mobile_data, broadband, iptv, enterprise_vpn).',
    `alarm_acknowledged_timestamp` TIMESTAMP COMMENT 'Timestamp when the alarm event was acknowledged by NOC or SOC personnel, indicating human review has occurred.',
    `alarm_cleared_timestamp` TIMESTAMP COMMENT 'Timestamp when the alarm event was cleared, indicating the fault condition has been resolved. Null if alarm is still active.',
    `alarm_identifier` STRING COMMENT 'Business identifier for the alarm event, typically assigned by the source OSS system (Nokia NetAct or Ericsson Network Manager).',
    `alarm_raised_timestamp` TIMESTAMP COMMENT 'Timestamp when the alarm event was first raised by the network element. Represents the real-world fault occurrence time.',
    `alarm_severity` STRING COMMENT 'Severity level of the alarm event indicating business impact. Critical indicates service-affecting; major indicates significant degradation; minor indicates non-service-affecting; warning indicates potential issue; indeterminate indicates unknown impact.. Valid values are `critical|major|minor|warning|indeterminate`',
    `alarm_state` STRING COMMENT 'Current lifecycle state of the alarm event. Raised indicates active fault; cleared indicates fault resolved; acknowledged indicates NOC has reviewed; suppressed indicates alarm is temporarily hidden from active view.. Valid values are `raised|cleared|acknowledged|suppressed`',
    `alarm_type` STRING COMMENT 'Classification of the alarm event by fault category. Communications indicates connectivity failure; quality_of_service indicates performance degradation; processing_error indicates software fault; equipment indicates hardware failure; environmental indicates physical conditions (temperature, power).. Valid values are `communications|quality_of_service|processing_error|equipment|environmental`',
    `cleared_by_system` STRING COMMENT 'System or process that cleared the alarm event (e.g., network element auto-recovery, manual intervention, OSS automation).',
    `correlation_identifier` STRING COMMENT 'Identifier used to correlate related alarm events across multiple network elements or systems. Enables root cause analysis and alarm storm management.',
    `customer_impact_count` STRING COMMENT 'Estimated number of customers or subscribers potentially affected by this alarm event. Used for prioritization and SLA breach assessment.',
    `first_occurrence_timestamp` TIMESTAMP COMMENT 'Timestamp of the very first occurrence of this alarm condition. Used for tracking recurring or flapping alarms.',
    `geographic_region` STRING COMMENT 'Geographic region or market where the affected network element is located. Used for regional NOC routing and reporting.',
    `ingestion_timestamp` TIMESTAMP COMMENT 'Timestamp when this alarm event record was ingested into the lakehouse silver layer from the source OSS system.',
    `last_occurrence_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent occurrence of this alarm condition. Updated when alarm repeats or flaps.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this alarm event record was last modified in the lakehouse, reflecting state changes or attribute updates.',
    `managed_object_class` STRING COMMENT 'Object-oriented class name of the network resource that raised the alarm (e.g., eNodeB, BNG, OLT, Router, Optical_Amplifier).',
    `managed_object_instance` STRING COMMENT 'Unique instance identifier of the managed object within the network element that raised the alarm. Typically a distinguished name or hierarchical path.',
    `mttr_target_minutes` STRING COMMENT 'Target resolution time in minutes for this alarm event based on severity and service impact, derived from SLA commitments.',
    `network_domain` STRING COMMENT 'High-level network domain classification of the affected network element. RAN indicates Radio Access Network; transport indicates backhaul/fronthaul; core indicates packet core; access indicates GPON/FTTH/DSLAM; edge indicates edge computing nodes.. Valid values are `ran|transport|core|access|edge`',
    `occurrence_count` STRING COMMENT 'Number of times this alarm condition has occurred since first detection. Used to identify flapping or intermittent faults.',
    `oss_source_system` STRING COMMENT 'Source OSS system that generated and published this alarm event (Nokia NetAct, Ericsson Network Manager, or other network management system).. Valid values are `nokia_netact|ericsson_network_manager|other`',
    `probable_cause` STRING COMMENT 'Standardized description of the likely root cause of the alarm event as determined by the network element or OSS system.',
    `proposed_repair_action` STRING COMMENT 'Recommended corrective action or troubleshooting steps for resolving the alarm condition, typically provided by the OSS system or knowledge base.',
    `service_affecting_flag` BOOLEAN COMMENT 'Boolean indicator whether this alarm event is currently affecting customer service delivery. True indicates active service impact; false indicates no customer impact.',
    `site_identifier` STRING COMMENT 'Physical site or facility identifier where the affected network element is deployed (e.g., cell site ID, central office code, data center ID).',
    `sla_breach_flag` BOOLEAN COMMENT 'Boolean indicator whether this alarm event has resulted in an SLA breach based on resolution time or service availability thresholds.',
    `specific_problem` STRING COMMENT 'Vendor-specific or system-specific problem code providing detailed fault identification beyond the standardized probable cause.',
    `technology_type` STRING COMMENT 'Specific technology or protocol of the affected network element (e.g., LTE, 5G NR, GPON, MPLS, IP, Optical).',
    CONSTRAINT pk_alarm_event PRIMARY KEY(`alarm_event_id`)
) COMMENT 'SSOT for network alarm events ingested from Nokia NetAct and Ericsson Network Manager. Captures real-time fault signals raised by network elements including RAN, transport, core, and GPON/FTTH nodes. Stores alarm severity, alarm type, affected network element, alarm state (raised/cleared/acknowledged), first occurrence timestamp, last occurrence timestamp, probable cause, specific problem code, managed object class, managed object instance, OSS source system, and correlation identifier. Feeds trouble ticket creation workflows in ServiceNow ITSM.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` (
    `trouble_ticket_id` BIGINT COMMENT 'Unique identifier for the trouble ticket record. Primary key.',
    `addon_id` BIGINT COMMENT 'Foreign key linking to product.addon. Business justification: Trouble tickets are frequently raised for specific add-on failures (e.g., roaming add-on not activating, VoIP add-on call quality issues). Add-on-level fault tracking and MTTR reporting require this l',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: Tracks which customer premise equipment (modem, router, STB) is subject of trouble ticket for warranty claim processing, replacement decisions, and device failure pattern analysis across manufacturers',
    `fiber_cable_id` BIGINT COMMENT 'Foreign key linking to inventory.fiber_cable. Business justification: Fiber cable cuts are a primary trouble ticket cause in fixed-line/fiber telecom. Field technicians must link the ticket to the specific cable segment for right-of-way coordination, splice repair dispa',
    `element_id` BIGINT COMMENT 'Reference to the specific network element (RAN node, router, switch, OLT, BNG) where the fault originated or was detected.',
    `network_equipment_id` BIGINT COMMENT 'Foreign key linking to inventory.network_equipment. Business justification: Trouble tickets for hardware faults (router failures, switch port issues, BTS equipment) must link to the specific network equipment inventory record for field dispatch, spare parts ordering, and warr',
    `olt_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.olt_asset. Business justification: OLT failures generate trouble tickets affecting entire PON trees (hundreds of customers). Linking trouble_ticket to olt_asset enables mass-impact ticket management, OLT maintenance history tracking, a',
    `ont_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.ont_asset. Business justification: Links fiber access trouble tickets to specific ONT assets for technician dispatch with correct replacement inventory, optical power troubleshooting, and ONT failure rate tracking by vendor/model.',
    `sim_stock_id` BIGINT COMMENT 'Foreign key linking to inventory.sim_stock. Business justification: SIM activation failures, defective SIM batches, and SIM swap issues generate trouble tickets. Linking to sim_stock enables batch defect tracking, quality control escalation to the SIM manufacturer, an',
    `team_id` BIGINT COMMENT 'Foreign key linking to workforce.team. Business justification: Trouble ticket team assignment: trouble tickets are assigned to workforce teams for resolution. trouble_ticket.assigned_group is a plain text field; a proper FK to workforce.team enables team SLA perf',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to product.bundle. Business justification: Trouble tickets are raised for bundle-level service failures (e.g., triple-play bundle where TV component is down). Bundle-level fault tracking drives product quality reporting and bundle-specific MTT',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Trouble tickets track service issues by product type; enables root cause analysis, warranty validation, product quality reporting, and defect trend analysis by catalog item. Essential for product life',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise fault management: trouble tickets for corporate customers must link to the corporate account for SLA escalation routing, account manager notification, and enterprise fault reporting. A tele',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account affected by the service fault. Nullable for network-level faults not tied to a specific customer.',
    `data_breach_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.data_breach_incident. Business justification: Tickets track breach remediation tasks: containment, system patching, customer notification, forensic analysis. Incident response teams manage breach response via ticketing systems. Critical for breac',
    `device_registration_id` BIGINT COMMENT 'Foreign key linking to customer.device_registration. Business justification: Device-specific faults generate trouble tickets. Links ticket to registered device for warranty claims, device quality analysis, and manufacturer defect tracking. Real business process: device fault m',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Trouble tickets for billing disputes or service issues reference specific invoices. Essential for customer care dispute resolution, linking service quality complaints to billing records for credit pro',
    `lawful_intercept_order_id` BIGINT COMMENT 'Foreign key linking to compliance.lawful_intercept_order. Business justification: Tickets created to provision/terminate lawful intercepts per court orders. NOC/provisioning teams track which tickets fulfill which intercept orders for legal compliance, chain of custody, and audit r',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Managed service fault tracking: trouble tickets raised against managed services must link to the managed service record for SLA breach calculation, vendor coordination, and managed service availabilit',
    `mnp_transaction_id` BIGINT COMMENT 'Foreign key linking to interconnect.mnp_transaction. Business justification: MNP porting failures, HLR update errors, and porting window breaches generate trouble tickets. Regulators mandate porting completion within defined windows; linking trouble_ticket to mnp_transaction e',
    `mvno_profile_id` BIGINT COMMENT 'Foreign key linking to partner.mvno_profile. Business justification: MVNO-specific trouble tickets (HLR provisioning failures, APN issues, IMSI range problems) require MVNO profile linkage for proper escalation, SLA breach attribution, and wholesale billing adjustments',
    `noc_incident_id` BIGINT COMMENT 'Foreign key linking to assurance.noc_incident. Business justification: Trouble tickets can be linked to NOC incidents when they are part of a larger operational incident. This is N:1 (many tickets can be associated with one NOC incident). The FK column does not currently',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: Trouble tickets are raised against specific service offerings (e.g., Fiber 500 offering down). Offering-level fault analysis, MTTR reporting, and product quality dashboards require this direct link.',
    `peering_arrangement_id` BIGINT COMMENT 'Foreign key linking to interconnect.peering_arrangement. Business justification: BGP peering failures, route flaps, and capacity issues generate trouble tickets. NOC engineers need to link a trouble ticket directly to the affected peering arrangement to coordinate with the peer ca',
    `poi_id` BIGINT COMMENT 'Foreign key linking to interconnect.poi. Business justification: Points of Interconnect are physical/logical interconnect nodes that generate trouble tickets when circuits fail or capacity is exceeded. Linking trouble_ticket to poi enables interconnect operations t',
    `problem_record_id` BIGINT COMMENT 'Foreign key linking to assurance.problem_record. Business justification: Trouble tickets can be linked to problem records for root cause investigation tracking. This is N:1 (many tickets can be associated with one problem record). The FK column does not currently exist and',
    `roaming_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.partner_roaming_agreement. Business justification: Roaming trouble tickets (TAP file discrepancies, fraud threshold breaches, steering policy violations) must reference the roaming agreement for dispute resolution, rate verification, and NRTRDE thresh',
    `site_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_site. Business justification: Site-level fault dispatch: enterprise customers have multiple sites; trouble tickets must link to the specific enterprise site to route field engineers, track site-level SLA performance, and generate ',
    `sla_profile_id` BIGINT COMMENT 'Foreign key linking to service.sla_profile. Business justification: Trouble tickets must reference applicable SLA commitments to determine response time targets, escalation procedures, and breach risk. Required for SLA compliance reporting and penalty avoidance.',
    `subscriber_id` BIGINT COMMENT 'Reference to the specific subscriber experiencing the service issue. Nullable for infrastructure faults.',
    `svc_instance_id` BIGINT COMMENT 'Reference to the service instance experiencing the fault or degradation.',
    `acknowledged_timestamp` TIMESTAMP COMMENT 'Date and time when the assigned team or engineer acknowledged receipt of the ticket and began investigation.',
    `affected_customer_count` STRING COMMENT 'Estimated or actual number of customer accounts impacted by the fault. Used for prioritization and impact assessment.',
    `affected_service_name` STRING COMMENT 'Human-readable name of the service affected by the fault (e.g., Broadband Internet, VoLTE, IPTV, Enterprise MPLS).',
    `affected_subscriber_count` STRING COMMENT 'Estimated or actual number of individual subscribers impacted by the fault. Used for SLA penalty calculation and customer communication.',
    `assignee_name` STRING COMMENT 'Full name of the engineer or technician assigned to the ticket.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the ticket was formally closed after verification and customer confirmation.',
    `correlated_alarm_ids` STRING COMMENT 'Comma-separated list of related alarm IDs that were correlated and consolidated into this single trouble ticket. Supports alarm correlation and root cause analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this trouble ticket record was first inserted into the data warehouse. Used for audit trail and data lineage.',
    `customer_reported_flag` BOOLEAN COMMENT 'Indicates whether the fault was first reported by a customer (reactive) or proactively detected by network monitoring systems.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the ticket was escalated to a higher support tier or management due to complexity, SLA risk, or customer impact.',
    `escalation_tier` STRING COMMENT 'The support tier or level to which the ticket was escalated (Tier 1 = frontline NOC, Tier 2 = specialist engineers, Tier 3 = vendor support, Management = executive escalation).. Valid values are `tier_1|tier_2|tier_3|management|vendor`',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when the ticket was escalated to a higher tier or management.',
    `impact_scope` STRING COMMENT 'Geographic or customer scope of the fault impact (single customer, multiple customers, entire site, regional, network-wide outage).. Valid values are `single_customer|multiple_customers|site|region|network_wide`',
    `mttr_minutes` DECIMAL(18,2) COMMENT 'Calculated duration in minutes from ticket opened to ticket resolved. Key performance indicator for fault management efficiency and SLA compliance.',
    `opened_timestamp` TIMESTAMP COMMENT 'Date and time when the trouble ticket was first created in the fault management system. Represents the start of the fault lifecycle.',
    `outage_duration_minutes` DECIMAL(18,2) COMMENT 'Total duration in minutes that the service was unavailable or degraded. Used for SLA credit calculation and availability reporting.',
    `priority` STRING COMMENT 'Business priority assigned to the ticket based on impact and urgency. Determines response and resolution time targets per SLA.. Valid values are `critical|high|medium|low`',
    `resolution_code` STRING COMMENT 'Standardized code representing the resolution action taken. Used for trend analysis and knowledge base categorization.',
    `resolution_description` STRING COMMENT 'Detailed description of the actions taken to resolve the fault (e.g., equipment replacement, configuration change, software patch, service restart).',
    `resolved_timestamp` TIMESTAMP COMMENT 'Date and time when the fault was resolved and service restored. Used to calculate MTTR.',
    `root_cause_category` STRING COMMENT 'High-level classification of the underlying cause of the fault identified during investigation.. Valid values are `hardware_failure|software_bug|configuration_error|capacity_overload|external_event|human_error`',
    `root_cause_description` STRING COMMENT 'Detailed narrative explanation of the root cause identified during fault analysis. Supports knowledge management and problem prevention.',
    `severity` STRING COMMENT 'Technical severity level indicating the scope and impact of the fault. Sev1 = service down, Sev2 = major degradation, Sev3 = minor impact, Sev4 = cosmetic/informational.. Valid values are `sev1|sev2|sev3|sev4`',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the ticket resolution exceeded the SLA target time for the assigned priority level. Critical for revenue assurance and customer satisfaction tracking.',
    `sla_target_minutes` STRING COMMENT 'The contractual or policy-defined target resolution time in minutes for this ticket priority level.',
    `source_system` STRING COMMENT 'Name of the operational system that originated this trouble ticket record (ServiceNow ITSM, Nokia NetAct, Ericsson Network Manager, Netcracker OSS, or Manual entry).. Valid values are `ServiceNow|Nokia_NetAct|Ericsson_NM|Netcracker_OSS|Manual`',
    `ticket_category` STRING COMMENT 'High-level classification of the trouble ticket indicating the domain of the fault (network infrastructure, service delivery, customer equipment, security incident, performance degradation).. Valid values are `network|service|customer|infrastructure|security|performance`',
    `ticket_number` STRING COMMENT 'Externally visible unique ticket number assigned by the fault management system. Used for customer and NOC communication.. Valid values are `^TT-[0-9]{8,12}$`',
    `ticket_type` STRING COMMENT 'Specific type of trouble ticket aligned with ITIL/ITSM classification: incident (unplanned interruption), problem (root cause investigation), change request, service request, or planned maintenance.. Valid values are `incident|problem|change_request|service_request|maintenance`',
    `trouble_ticket_status` STRING COMMENT 'Current lifecycle status of the trouble ticket in the fault management workflow. [ENUM-REF-CANDIDATE: new|open|assigned|in_progress|pending|resolved|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this trouble ticket record was last modified in the data warehouse. Used for change tracking and incremental processing.',
    `vendor_ticket_number` STRING COMMENT 'External ticket number assigned by equipment vendor or third-party support provider if the issue was escalated to vendor technical support.',
    CONSTRAINT pk_trouble_ticket PRIMARY KEY(`trouble_ticket_id`)
) COMMENT 'SSOT for fault management trouble tickets sourced from ServiceNow ITSM. Represents a formal record of a network or service fault requiring investigation and resolution. Captures ticket number, category (network/service/customer), priority, severity, affected service, affected network element, assigned NOC/SOC group, assignee, open timestamp, acknowledged timestamp, resolved timestamp, closed timestamp, root cause category, resolution description, MTTR (minutes), escalation flag, escalation tier, SLA breach flag, and source alarm correlation IDs. Aligns with eTOM process 1.1.1 Fault Management.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`assurance`.`noc_incident` (
    `noc_incident_id` BIGINT COMMENT 'Unique identifier for the NOC/SOC incident record. Primary key.',
    `fiber_cable_id` BIGINT COMMENT 'Foreign key linking to inventory.fiber_cable. Business justification: Fiber cable cuts are a leading cause of NOC incidents. Linking noc_incident to fiber_cable supports post-incident root cause analysis, right-of-way permit tracking for repairs, and regulatory outage r',
    `olt_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.olt_asset. Business justification: OLT failures are a top cause of mass-impact NOC incidents in fiber networks. Linking noc_incident to olt_asset supports post-incident review, OLT vendor escalation, and regulatory outage reporting tha',
    `alarm_event_id` BIGINT COMMENT 'Foreign key linking to assurance.alarm_event. Business justification: A NOC/SOC incident is typically declared in response to one or more network alarm events. Linking noc_incident to the primary triggering alarm_event provides the detection chain from alarm to declared',
    `team_id` BIGINT COMMENT 'Foreign key linking to workforce.team. Business justification: Incident team assignment: NOC incidents are formally assigned to workforce teams for resolution. noc_incident.assigned_team is currently a plain text field; a proper FK to workforce.team enforces refe',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to interconnect.carrier. Business justification: NOC incidents affecting interconnect (e.g., SS7 link failures, roaming hub outages, TAP file exchange disruptions) are associated with a specific carrier. Carrier-level incident tracking is required f',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise impact assessment: NOC incidents must identify affected corporate accounts to trigger account manager notifications, executive escalations, and enterprise SLA breach calculations. Critical ',
    `element_id` BIGINT COMMENT 'Foreign key linking to network.element. Business justification: Major incidents must identify the primary affected network element for vendor escalation, spare parts logistics, and post-incident review. Core NOC operational requirement for incident command and res',
    `network_equipment_id` BIGINT COMMENT 'Foreign key linking to inventory.network_equipment. Business justification: NOC incidents caused by specific physical equipment failures require linking to the inventory record for post-incident review, MTBF tracking, vendor SLA claims, and equipment replacement decisions — s',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: NOC incidents meeting severity or duration thresholds require formal regulatory filings with telecom authorities. noc_incident has regulatory_reporting_required_flag; linking to the resulting regulato',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Major outages trigger regulatory reporting obligations (FCC Part 4 outage reporting, EU NIS Directive incident notification). NOC teams must identify which incidents require regulatory filings and tra',
    `site_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_site. Business justification: Site-level incident impact: NOC incidents affecting specific enterprise sites require site linkage for field dispatch coordination, site-level customer notification, and post-incident review reporting',
    `sla_contract_id` BIGINT COMMENT 'Foreign key linking to assurance.sla_contract. Business justification: A NOC incident must be assessed against applicable SLA contracts to determine breach obligations and customer notification requirements. Linking noc_incident to sla_contract enables direct SLA complia',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the incident record was formally closed after verification, documentation, and post-incident review completion.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this incident record was first created in the system, used for audit trail and data lineage.',
    `customer_notification_sent_flag` BOOLEAN COMMENT 'Indicates whether proactive customer communication was sent regarding the incident and its impact on services.',
    `declared_timestamp` TIMESTAMP COMMENT 'Date and time when the incident was officially declared by NOC/SOC operations, marking the start of the incident lifecycle.',
    `detected_timestamp` TIMESTAMP COMMENT 'Date and time when the incident was first detected by monitoring systems or reported by field personnel, which may precede the declared timestamp.',
    `escalation_level` STRING COMMENT 'Current escalation tier of the incident within the support hierarchy (L1=frontline NOC, L2=engineering, L3=vendor/specialist, executive=C-level notification).. Valid values are `L1|L2|L3|executive`',
    `estimated_revenue_impact` DECIMAL(18,2) COMMENT 'Estimated financial impact of the incident in terms of lost revenue, service credits, or penalties, used for revenue assurance and executive reporting.',
    `impacted_customer_count` STRING COMMENT 'Estimated number of customers affected by the incident, used for impact assessment and prioritization.',
    `impacted_geography` STRING COMMENT 'Geographic region, market, or service area affected by the incident (e.g., Northeast Region, Metro Atlanta, California Central Coast).',
    `impacted_network_elements` STRING COMMENT 'List of network infrastructure components affected by the incident (e.g., RAN sites, core routers, OLT devices, BNG gateways).',
    `impacted_services_list` STRING COMMENT 'Comma-separated list of service types or service identifiers affected by the incident (e.g., LTE Data, VoLTE, IPTV, Broadband, 5G NR).',
    `incident_category` STRING COMMENT 'Operational categorization of the incident based on service impact pattern (complete outage, performance degradation, security compromise, capacity constraint, or maintenance-related event).. Valid values are `outage|degradation|security_breach|capacity_issue|maintenance_related`',
    `incident_number` STRING COMMENT 'Externally-known unique incident identifier used for tracking and communication across NOC/SOC teams and stakeholders.. Valid values are `^INC-[0-9]{8,12}$`',
    `incident_priority` STRING COMMENT 'Operational priority assigned to the incident based on severity and business impact, determining resource allocation and response time targets (P1=highest, P4=lowest).. Valid values are `P1|P2|P3|P4`',
    `incident_source` STRING COMMENT 'Origin or detection method through which the incident was first identified (automated monitoring, customer complaint, field observation, proactive analysis, or vendor alert).. Valid values are `monitoring_system|customer_report|field_technician|proactive_detection|vendor_notification`',
    `incident_status` STRING COMMENT 'Current lifecycle state of the incident within the NOC/SOC operational workflow.. Valid values are `declared|investigating|mitigating|resolved|closed`',
    `incident_type` STRING COMMENT 'Classification of the incident based on the nature of the operational event (e.g., network outage, DDoS attack, power failure, fiber cut, environmental hazard, hardware failure).. Valid values are `network|security|power|environmental|service|hardware`',
    `last_modified_by` STRING COMMENT 'User identifier or system name that last modified this incident record, used for audit and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this incident record was last updated, used for audit trail and change tracking.',
    `mttr_minutes` STRING COMMENT 'Calculated time in minutes from incident declaration to resolution, used as a key performance indicator for operational efficiency.',
    `noc_shift` STRING COMMENT 'NOC operational shift during which the incident was declared, used for staffing analysis and shift performance metrics.. Valid values are `day|evening|night|weekend`',
    `post_incident_review_flag` BOOLEAN COMMENT 'Indicates whether a formal post-incident review (PIR) is required or has been completed for this incident, typically mandated for high-severity or customer-impacting events.',
    `preventive_action_taken` STRING COMMENT 'Description of preventive measures or corrective actions implemented to prevent recurrence of similar incidents in the future.',
    `rca_document_reference` STRING COMMENT 'Reference identifier or URL to the formal RCA document or post-incident review report stored in the document management system.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether the incident meets thresholds requiring formal reporting to regulatory bodies such as FCC, BEREC, or national telecommunications authorities.',
    `resolved_timestamp` TIMESTAMP COMMENT 'Date and time when the incident was resolved and normal service operations were restored.',
    `root_cause_category` STRING COMMENT 'High-level classification of the underlying root cause identified during post-incident analysis.. Valid values are `hardware_failure|software_defect|configuration_error|capacity_overload|external_event|human_error`',
    `root_cause_description` STRING COMMENT 'Detailed narrative description of the root cause identified through Root Cause Analysis (RCA), including technical details and contributing factors.',
    `severity_level` STRING COMMENT 'Business impact severity of the incident, determining priority and escalation path. Critical incidents typically affect large customer populations or core network infrastructure.. Valid values are `critical|high|medium|low`',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the incident resulted in a breach of service level agreement commitments to customers or business units.',
    `vendor_involved` STRING COMMENT 'Name of the external vendor or equipment manufacturer involved in incident resolution (e.g., Nokia, Ericsson, Cisco, Juniper), if applicable.',
    `vendor_ticket_reference` STRING COMMENT 'External ticket or case number opened with the vendor for support or escalation related to this incident.',
    `war_room_bridge_number` STRING COMMENT 'Conference bridge phone number or virtual meeting link used for real-time incident coordination and communication among response teams.',
    `created_by` STRING COMMENT 'User identifier or system name that created this incident record, used for audit and accountability.',
    CONSTRAINT pk_noc_incident PRIMARY KEY(`noc_incident_id`)
) COMMENT 'NOC/SOC operational incident record representing a declared network or security incident managed by the Network Operations Center or Security Operations Center. Distinct from a trouble ticket in that it represents a broader operational event (e.g., major outage, DDoS attack, fiber cut) that may span multiple trouble tickets and alarms. Captures incident ID, incident type (network/security/power/environmental), severity level, declared timestamp, resolved timestamp, impacted geography, impacted customer count estimate, impacted services list, incident commander, war-room bridge details, post-incident review flag, and RCA document reference.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` (
    `performance_measurement_id` BIGINT COMMENT 'Unique identifier for the performance measurement record. Primary key.',
    `addon_id` BIGINT COMMENT 'Foreign key linking to product.addon. Business justification: Performance measurements validate add-on service delivery (e.g., measuring throughput for a speed boost add-on, latency for a VoIP add-on). Add-on-level performance reporting is a real telecom operati',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Network performance KPIs must be validated against product specifications (guaranteed bandwidth, latency SLAs); enables automated SLA compliance monitoring and product performance benchmarking against',
    `kpi_threshold_id` BIGINT COMMENT 'Foreign key linking to assurance.kpi_threshold. Business justification: A performance measurement is evaluated against a KPI threshold definition. The kpi_threshold table is the SSOT for all detection rules and threshold definitions. Adding kpi_threshold_id to performance',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: CPE performance monitoring (throughput, latency, signal quality per device) is standard in telecom. Linking performance_measurement to cpe_asset supports proactive CPE maintenance, SLA validation per ',
    `network_equipment_id` BIGINT COMMENT 'Foreign key linking to inventory.network_equipment. Business justification: When measurement_object_type=EQUIPMENT, links KPI data (port utilization, CPU, temperature) to specific routers/switches for capacity planning, fault correlation, and predictive maintenance in netwo',
    `olt_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.olt_asset. Business justification: When measurement_object_type=OLT, monitors PON port utilization, ONT count per port, and uplink bandwidth for fiber access network capacity management and OLT expansion planning.',
    `ont_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.ont_asset. Business justification: When measurement_object_type=ONT, tracks optical power levels, distance, and bandwidth utilization per ONT for GPON network quality assurance and proactive maintenance of fiber access infrastructure',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Performance measurements in telecom are collected to satisfy specific regulatory QoS reporting obligations. A regulatory compliance engineer must trace which obligation drives each measurement collect',
    `spectrum_license_id` BIGINT COMMENT 'Foreign key linking to compliance.spectrum_license. Business justification: Performance measurements validate spectrum license compliance: utilization thresholds (build-out requirements), interference limits, coverage obligations. Regulators audit spectrum usage; measurements',
    `aggregation_method` STRING COMMENT 'Statistical method used to aggregate raw samples into the measurement value (e.g., average, sum, min, max, percentile, count). Essential for correct interpretation.. Valid values are `average|sum|min|max|percentile|count`',
    `availability_percentage` DECIMAL(18,2) COMMENT 'Computed availability percentage for the measurement object during the measurement interval. Derived from uptime and downtime measurements. Used for SLA compliance reporting.',
    `baseline_value` DECIMAL(18,2) COMMENT 'Historical baseline or expected value for this KPI under normal operating conditions. Used for anomaly detection and deviation analysis.',
    `collection_timestamp` TIMESTAMP COMMENT 'Timestamp when the measurement record was collected and ingested into the data platform from the source OSS/EMS/NMS system.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Numeric quality score (0-100) representing the reliability and completeness of the measurement data. Used for filtering and weighting in analytics.',
    `deviation_percentage` DECIMAL(18,2) COMMENT 'Percentage deviation of the measurement value from the baseline value. Positive indicates above baseline; negative indicates below baseline. Used for trend analysis.',
    `geographic_region` STRING COMMENT 'Geographic region or market where the measured network element is deployed (e.g., North, South, East, West, or specific market names). Supports regional performance analysis.',
    `measurement_end_timestamp` TIMESTAMP COMMENT 'End timestamp of the measurement interval window. Defines the conclusion of the period over which the KPI was computed.',
    `measurement_interval_type` STRING COMMENT 'Time granularity at which the measurement was aggregated: 15-minute, 1-hour, 24-hour, or real-time. Aligns with standard OSS collection intervals.. Valid values are `15-minute|1-hour|24-hour|real-time`',
    `measurement_object_reference` STRING COMMENT 'Unique identifier of the network element being measured (cell, link, node, shelf, port, or other infrastructure component). Maps to the physical or logical resource in the network inventory.',
    `measurement_object_type` STRING COMMENT 'Type of network element being measured. Categorizes the infrastructure layer at which the KPI was collected.. Valid values are `cell|link|node|shelf|port|interface`',
    `measurement_reliability_flag` BOOLEAN COMMENT 'Boolean indicator of whether the measurement is considered reliable for reporting and analytics. False indicates the measurement should be excluded from SLA calculations.',
    `measurement_source_system` STRING COMMENT 'Name of the source system from which the measurement was collected (e.g., Nokia NetAct, Ericsson Network Manager, generic NMS/EMS/OSS).. Valid values are `Nokia NetAct|Ericsson Network Manager|NMS|EMS|OSS`',
    `measurement_source_system_code` STRING COMMENT 'Unique identifier or instance ID of the source system. Enables traceability back to the originating OSS/EMS/NMS instance.',
    `measurement_start_timestamp` TIMESTAMP COMMENT 'Start timestamp of the measurement interval window. Defines the beginning of the period over which the KPI was computed.',
    `measurement_status` STRING COMMENT 'Quality status of the measurement record. Indicates whether the data is valid, suspect (questionable quality), invalid (failed validation), or incomplete (missing samples).. Valid values are `valid|suspect|invalid|incomplete`',
    `measurement_unit` STRING COMMENT 'Unit of measure for the measurement value (e.g., dBm, Mbps, ms, percent, count, ratio). Essential for correct interpretation and threshold comparison.',
    `measurement_value` DECIMAL(18,2) COMMENT 'Raw numeric value of the performance measurement as collected from the network element. Unit of measure is specified in measurement_unit.',
    `network_domain` STRING COMMENT 'High-level network domain where the measurement was collected: RAN (Radio Access Network), transport, core, edge, or access network.. Valid values are `RAN|transport|core|edge|access`',
    `notes` STRING COMMENT 'Free-text notes or comments about the measurement record. May include context about anomalies, maintenance windows, or data quality issues.',
    `sample_count` BIGINT COMMENT 'Number of raw samples or data points aggregated to produce the measurement value. Indicates statistical confidence and granularity of the measurement.',
    `technology_type` STRING COMMENT 'Technology standard or protocol of the measured network element (e.g., 5G NR, LTE, FTTH, GPON, MPLS). [ENUM-REF-CANDIDATE: 5G NR|LTE|UMTS|GSM|FTTH|GPON|MPLS|Ethernet — 8 candidates stripped; promote to reference product]',
    `threshold_breach_flag` BOOLEAN COMMENT 'Boolean indicator of whether the measurement value breached the configured threshold. True indicates a breach; False indicates compliance. Used for SLA tracking and alarm correlation.',
    `threshold_breach_severity` STRING COMMENT 'Severity level of the threshold breach if threshold_breach_flag is True. Aligns with alarm severity classifications in fault management systems.. Valid values are `critical|major|minor|warning`',
    `threshold_value` DECIMAL(18,2) COMMENT 'Configured threshold value for this KPI. Used to determine whether the measurement breaches acceptable performance limits. Null if no threshold is defined.',
    `vendor_name` STRING COMMENT 'Name of the equipment vendor for the measured network element (e.g., Nokia, Ericsson, Huawei, Cisco). Used for vendor-specific performance analysis.',
    CONSTRAINT pk_performance_measurement PRIMARY KEY(`performance_measurement_id`)
) COMMENT 'SSOT for time-series performance measurement records collected at the network-element layer from Nokia NetAct and Ericsson Network Manager across RAN, transport, and core domains. Captures infrastructure-level KPIs: RSRP, SINR, cell throughput, packet loss, latency, link utilization, node availability, and capacity metrics. Each record captures measurement object (cell/link/node/shelf/port), KPI name, measurement interval (15-min/1-hour/24-hour), raw value, threshold value, threshold breach flag, measurement source (OSS/EMS/NMS), collection timestamp, and source system. Serves as the unified network-element measurement store for availability computation, capacity planning, and threshold breach detection. Service-layer and bearer-level QoS measurements are owned by qos_measurement. Aligns with eTOM process 1.1.2 Performance Management.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`assurance`.`sla_contract` (
    `sla_contract_id` BIGINT COMMENT 'Unique identifier for the SLA contract record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.partner_agreement. Business justification: SLA contracts are defined within partner agreements and must reference the governing agreement for compliance verification, penalty cap enforcement, and dispute resolution per contract terms.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to interconnect.carrier. Business justification: SLA contracts govern interconnect performance obligations with specific carriers. sla_contract has partner_id but not carrier_id; for interconnect-specific SLAs (TAP delivery, NRTRDE latency, settleme',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: SLA contracts are defined per product offering; this is the master relationship between service level commitments and product catalog, enabling contract template management and product-specific SLA de',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: SLA contracts in telecom are negotiated against specific product offerings (e.g., Business Fiber 500 with 99.9% uptime SLA). Offering-level SLA management drives contract structuring, breach penalty c',
    `parent_sla_contract_id` BIGINT COMMENT 'Reference to a parent or master SLA contract when this SLA is a specialized or subsidiary agreement (e.g., service-specific SLA under an enterprise master agreement). Nullable for top-level SLAs.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: SLA contracts for MVNOs, roaming partners, and wholesale customers require partner attribution for SLA monitoring, breach tracking, and penalty calculation in partner settlement processes.',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: SLA contracts in telecom are tied to specific price plans that define QoS tiers and uptime commitments (price_plan has qos_tier, sla_uptime_percentage). Enterprise price plans carry dedicated SLA cont',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Telecom SLA contracts are frequently mandated by or must comply with specific regulatory obligations (universal service, QoS mandates). A regulatory affairs manager expects SLA contracts to reference ',
    `approval_authority` STRING COMMENT 'The role or individual who has authority to approve, modify, or terminate this SLA contract (e.g., VP Network Operations, Chief Technology Officer, Regulatory Affairs Director).',
    `availability_target_percent` DECIMAL(18,2) COMMENT 'The committed service availability target expressed as a percentage (e.g., 99.95% uptime). Used for SLA breach detection and penalty calculation.',
    `breach_notification_required` BOOLEAN COMMENT 'Indicates whether automatic notification to customers or stakeholders is required when an SLA breach occurs (True) or not (False).',
    `breach_threshold_count` STRING COMMENT 'The number of allowable SLA breaches within the measurement window before penalties are triggered or escalation occurs. Provides tolerance for minor incidents.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the SLA contract: draft (being defined), active (in force), suspended (temporarily inactive), expired (past expiry date), terminated (cancelled before expiry), or under review (being renegotiated).. Valid values are `draft|active|suspended|expired|terminated|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this SLA contract record was first created in the system. Audit trail field.',
    `customer_segment` STRING COMMENT 'The target customer segment for this SLA (e.g., Consumer, Small Business, Enterprise, Government, Wholesale Carrier). Used for segmented SLA reporting and analytics.',
    `effective_date` DATE COMMENT 'The date on which this SLA contract becomes active and enforceable. SLA breach tracking begins from this date.',
    `escalation_procedure` STRING COMMENT 'Description of the escalation process and contact hierarchy when SLA targets are breached or at risk. May reference external documentation or runbooks.',
    `exclusion_criteria` STRING COMMENT 'Conditions or events that are excluded from SLA calculations (e.g., Planned maintenance windows, Force majeure events, Customer-caused outages, Third-party network failures).',
    `expiry_date` DATE COMMENT 'The date on which this SLA contract expires or terminates. Nullable for evergreen or indefinite agreements.',
    `geographic_scope` STRING COMMENT 'The geographic region or coverage area to which this SLA applies (e.g., National, Regional, Metro Area, International). Critical for multi-region operators.',
    `jitter_target_ms` DECIMAL(18,2) COMMENT 'The maximum allowable jitter (variation in packet delay) in milliseconds. Essential for voice and video quality assurance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this SLA contract record was last updated. Audit trail field for change tracking.',
    `latency_target_ms` DECIMAL(18,2) COMMENT 'The maximum allowable network latency (round-trip time) in milliseconds. Applicable to real-time services such as VoLTE, VoIP, and gaming.',
    `measurement_source_system` STRING COMMENT 'The operational system or platform that provides the performance data for SLA measurement (e.g., Nokia NetAct, Ericsson Network Manager, ServiceNow ITSM, Custom NMS).',
    `measurement_window` STRING COMMENT 'The time period over which SLA performance is measured and evaluated (e.g., monthly, quarterly, annual, rolling 30-day window).. Valid values are `monthly|quarterly|annual|rolling_30_day|rolling_90_day`',
    `mttr_target_hours` DECIMAL(18,2) COMMENT 'The maximum allowable mean time to repair (MTTR) for service faults, measured in hours. Critical for NOC/SOC incident management and penalty assessment.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or operational notes related to this SLA contract. Used for non-structured information that does not fit other fields.',
    `owner_department` STRING COMMENT 'The internal business unit or department responsible for managing and enforcing this SLA (e.g., Network Operations Center, Customer Care, Enterprise Services, Wholesale Operations).',
    `packet_loss_target_percent` DECIMAL(18,2) COMMENT 'The maximum allowable packet loss rate expressed as a percentage. Critical for QoS monitoring in IP-based services.',
    `penalty_calculation_method` STRING COMMENT 'The method used to calculate financial penalties or service credits when SLA targets are breached: fixed amount per incident, percentage of monthly recurring revenue (MRR), tiered based on severity, prorated by downtime duration, or service credit.. Valid values are `fixed_amount|percentage_of_mrr|tiered|prorated|credit`',
    `penalty_cap_amount` DECIMAL(18,2) COMMENT 'The maximum total penalty or credit amount that can be assessed within a single measurement window. Protects both provider and customer from unlimited liability.',
    `penalty_clause_flag` BOOLEAN COMMENT 'Indicates whether this SLA contract includes financial penalty clauses for breach events (True) or is informational only (False).',
    `reporting_frequency` STRING COMMENT 'The frequency at which SLA performance reports are generated and delivered to stakeholders (e.g., real-time dashboards, daily summaries, monthly compliance reports).. Valid values are `real_time|daily|weekly|monthly|quarterly|on_demand`',
    `service_class` STRING COMMENT 'The product or service category to which this SLA applies (e.g., Fiber Broadband, 5G Mobile, IPTV, Enterprise MPLS, VoLTE).',
    `sla_code` STRING COMMENT 'Externally-known unique business identifier or code for the SLA contract used in operational systems and customer communications.',
    `sla_name` STRING COMMENT 'Human-readable name or title of the SLA contract (e.g., Gold Business SLA, Enterprise Uptime Guarantee).',
    `sla_type` STRING COMMENT 'Classification of the SLA contract by its application scope: customer-facing (B2C/B2B service commitments), internal (inter-department operational agreements), wholesale (MVNO/carrier interconnect), partner (third-party service provider), or regulatory (mandated QoS compliance).. Valid values are `customer_facing|internal|wholesale|partner|regulatory`',
    `throughput_target_mbps` DECIMAL(18,2) COMMENT 'The minimum guaranteed throughput or bandwidth in megabits per second (Mbps). Applicable to broadband, fiber, and enterprise connectivity services.',
    `version_number` STRING COMMENT 'The version identifier for this SLA contract definition. Incremented when terms are renegotiated or updated. Supports audit trail and change management.',
    CONSTRAINT pk_sla_contract PRIMARY KEY(`sla_contract_id`)
) COMMENT 'Master record defining SLA (Service Level Agreement) contracts applicable to customer services or internal network operations. Captures SLA ID, SLA name, SLA type (customer-facing/internal/wholesale), associated product or service class, availability target (%), MTTR target (hours), latency target (ms), packet loss target (%), jitter target (ms), measurement window, penalty clause flag, penalty calculation method, effective date, expiry date, and governing regulatory body reference. Owned by the assurance domain as the authoritative SLA definition used for breach tracking, penalty calculation, and regulatory QoS compliance reporting. Aligns with eTOM process 1.1.3 SLA Management.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` (
    `sla_breach_event_id` BIGINT COMMENT 'Unique identifier for each SLA breach event instance. Primary key for the SLA breach event record.',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: When breach is customer-specific (MTTR, availability), identifies which CPE asset contributed to SLA violation for proactive replacement, device upgrade programs, and vendor performance penalty calcul',
    `element_id` BIGINT COMMENT 'Identifier of the specific network element (RAN, BNG, OLT, router, etc.) that experienced the fault leading to the SLA breach.',
    `network_equipment_id` BIGINT COMMENT 'Foreign key linking to inventory.network_equipment. Business justification: Network equipment failures causing SLA breaches must be linked to the specific asset for vendor SLA penalty claims, equipment replacement justification, and regulatory SLA compliance reporting — a sta',
    `olt_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.olt_asset. Business justification: OLT failures causing mass SLA breaches for fiber customers require linking to the specific OLT asset for vendor maintenance SLA claims, penalty calculation, and regulatory reporting of infrastructure-',
    `ont_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.ont_asset. Business justification: ONT failures directly cause SLA breaches for individual fiber customers. Linking sla_breach_event to ont_asset supports customer SLA penalty credit calculation, ONT replacement tracking, and fiber ser',
    `alarm_event_id` BIGINT COMMENT 'Foreign key linking to assurance.alarm_event. Business justification: An SLA breach event is often triggered by or correlated with a specific network alarm event. Linking sla_breach_event to the triggering alarm_event provides end-to-end traceability from network fault ',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to product.bundle. Business justification: SLA breach events occur at the bundle level when a bundled service fails its combined SLA (e.g., triple-play bundle availability breach). Bundle-level breach tracking is required for penalty calculati',
    `carrier_agreement_id` BIGINT COMMENT 'Foreign key linking to interconnect.carrier_agreement. Business justification: SLA breaches against carrier agreements (TAP delivery latency, NRTRDE transmission windows, settlement timeliness) must be tracked at the carrier_agreement level for penalty calculation and contract r',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: SLA breaches must be tracked per product offering for contract compliance validation, penalty calculation, and product-specific performance reporting. Critical for regulatory reporting and customer co',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise SLA breach reporting: SLA breach events must be traceable to the corporate account for executive reporting dashboards, credit note generation, and contract renewal risk assessment by enterp',
    `kpi_threshold_id` BIGINT COMMENT 'Foreign key linking to assurance.kpi_threshold. Business justification: An SLA breach event is triggered when a KPI threshold is violated. The kpi_threshold table is the SSOT for all detection rules including SLA-related thresholds. Linking sla_breach_event to kpi_thresho',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Managed service SLA penalty calculation: SLA breach events on managed services must link to the managed service record to calculate penalties, issue service credits, and feed enterprise SLA compliance',
    `noc_incident_id` BIGINT COMMENT 'Foreign key linking to assurance.noc_incident. Business justification: An SLA breach event can be associated with a declared NOC/SOC incident. Linking sla_breach_event to noc_incident enables NOC operations teams to track which incidents resulted in SLA breaches, support',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: SLA breach events must be attributed to the specific offering whose SLA was violated to calculate penalties, generate offering-level breach reports, and drive product quality improvement. sla_breach_e',
    `performance_measurement_id` BIGINT COMMENT 'Foreign key linking to assurance.performance_measurement. Business justification: An SLA breach is detected from a specific performance measurement that crossed the contracted threshold. Linking sla_breach_event to the triggering performance_measurement record provides the evidenti',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: When an SLA breach meets regulatory reportable thresholds, a formal regulatory filing is submitted. sla_breach_event has regulatory_report_submitted_flag and regulatory_report_submission_timestamp, ma',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: SLA breach events in telecom are subject to regulatory QoS reporting obligations. sla_breach_event already has regulatory_reportable_flag; linking to the governing regulatory_obligation enables compli',
    `settlement_invoice_id` BIGINT COMMENT 'Foreign key linking to interconnect.settlement_invoice. Business justification: SLA breaches in interconnect agreements result in financial penalties captured in settlement invoices. Linking sla_breach_event to the settlement_invoice that records the penalty supports penalty reco',
    `sla_contract_id` BIGINT COMMENT 'Reference to the SLA contract that defines the service level commitments and thresholds that were breached.',
    `sla_definition_id` BIGINT COMMENT 'Foreign key linking to partner.sla_definition. Business justification: SLA breach events must reference the specific SLA definition violated for accurate penalty calculation using the defined penalty formula, credit calculation, and compliance reporting per partner agree',
    `sla_profile_id` BIGINT COMMENT 'Foreign key linking to service.sla_profile. Business justification: Breach events must link to contracted SLA terms for penalty calculation, customer credit eligibility, and regulatory reporting. Essential for financial impact assessment and dispute resolution.',
    `svc_instance_id` BIGINT COMMENT 'Reference to the specific service instance that experienced the SLA breach. Links to the service provisioned to the customer.',
    `actual_measured_value` DECIMAL(18,2) COMMENT 'The actual performance metric value measured during the breach period. Used to calculate the severity of the breach deviation.',
    `affected_customer_count` STRING COMMENT 'Number of customers impacted by the SLA breach event. Used for impact assessment and regulatory reporting thresholds.',
    `affected_service_type` STRING COMMENT 'Type of telecommunications service that experienced the SLA breach. Used for service-specific breach analysis and reporting. [ENUM-REF-CANDIDATE: broadband|mobile|voice|iptv|enterprise_wan|cloud_service|iot — 7 candidates stripped; promote to reference product]',
    `breach_deviation_percentage` DECIMAL(18,2) COMMENT 'Percentage deviation of the actual measured value from the contracted threshold. Quantifies the magnitude of the SLA violation.',
    `breach_duration_minutes` DECIMAL(18,2) COMMENT 'Total duration of the SLA breach measured in minutes. Calculated from breach start to breach end timestamp. Used for penalty calculation.',
    `breach_end_timestamp` TIMESTAMP COMMENT 'Precise date and time when the service metric returned to acceptable levels, marking the end of the breach period. Null if breach is ongoing.',
    `breach_event_number` STRING COMMENT 'Human-readable business identifier for the SLA breach event. Used for external communication and reporting.. Valid values are `^SLA-BRH-[0-9]{10}$`',
    `breach_severity` STRING COMMENT 'Severity classification of the SLA breach based on impact to service quality and business operations. Determines escalation and penalty tier.. Valid values are `critical|major|minor|warning`',
    `breach_start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the service metric first fell below the SLA threshold, marking the beginning of the breach period.',
    `breach_status` STRING COMMENT 'Current lifecycle status of the SLA breach event. Tracks the breach from detection through resolution and penalty application.. Valid values are `open|acknowledged|under_review|resolved|closed|disputed`',
    `breach_type` STRING COMMENT 'Category of SLA metric that was breached. Defines which Key Performance Indicator (KPI) failed to meet the contracted threshold.. Valid values are `availability|mttr|latency|packet_loss|throughput|jitter`',
    `contracted_threshold_value` DECIMAL(18,2) COMMENT 'The SLA threshold value defined in the contract that was breached. Represents the minimum acceptable performance level agreed upon.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this SLA breach event record was first created in the system. Audit trail for data lineage and compliance.',
    `customer_impact_level` STRING COMMENT 'Assessment of the business impact on the customer due to the SLA breach. Considers service criticality and customer segment.. Valid values are `no_impact|low|medium|high|critical`',
    `customer_notification_channel` STRING COMMENT 'Communication channel used to notify the customer about the SLA breach. Tracks notification method for audit and compliance purposes.. Valid values are `email|sms|portal|phone|automated_ivr`',
    `customer_notification_sent_flag` BOOLEAN COMMENT 'Indicates whether the customer has been notified about the SLA breach event. Tracks compliance with contractual notification obligations.',
    `customer_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the customer notification was sent regarding the SLA breach. Used to verify compliance with notification SLAs.',
    `detection_delay_minutes` DECIMAL(18,2) COMMENT 'Time difference between breach start and detection timestamps. Measures monitoring system responsiveness and Mean Time to Detect (MTTD).',
    `detection_method` STRING COMMENT 'Method by which the SLA breach was detected. Used to evaluate monitoring effectiveness and improve detection capabilities.. Valid values are `automated_monitoring|customer_complaint|proactive_testing|scheduled_audit|third_party_report`',
    `detection_timestamp` TIMESTAMP COMMENT 'Date and time when the SLA breach was first detected by monitoring systems or reported. May differ from breach start timestamp.',
    `dispute_raised_flag` BOOLEAN COMMENT 'Indicates whether the customer or internal team has disputed the SLA breach determination or penalty calculation. Triggers dispute resolution workflow.',
    `dispute_resolution_status` STRING COMMENT 'Current status of the dispute resolution process for the SLA breach. Tracks dispute lifecycle from initiation to final decision.. Valid values are `not_disputed|under_review|accepted|rejected|partially_accepted`',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicates whether the breach requires escalation to senior management or specialized teams based on severity and duration thresholds.',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when the breach was escalated to higher management or specialized resolution teams. Tracks escalation timeliness.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this SLA breach event record was most recently modified. Tracks data currency and change history.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Calculated financial penalty or service credit amount owed to the customer due to the SLA breach. Used for revenue assurance and billing adjustments.',
    `penalty_applicable_flag` BOOLEAN COMMENT 'Indicates whether a financial penalty or service credit is applicable for this breach according to the SLA contract terms.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount. Ensures accurate financial processing across multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `preventive_action_recommended` STRING COMMENT 'Recommended preventive measures to avoid similar SLA breaches in the future. Used for continuous improvement and network optimization.',
    `regulatory_report_submission_timestamp` TIMESTAMP COMMENT 'Date and time when the regulatory report was submitted to the governing authority. Used for compliance audit trail.',
    `regulatory_report_submitted_flag` BOOLEAN COMMENT 'Indicates whether the required regulatory report has been submitted for this breach event. Tracks compliance with regulatory obligations.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this SLA breach must be reported to regulatory authorities (FCC, Ofcom, etc.) based on severity and impact thresholds.',
    `resolution_action_taken` STRING COMMENT 'Description of the corrective actions taken to resolve the SLA breach and restore service to acceptable levels. Documents remediation steps.',
    `root_cause_category` STRING COMMENT 'High-level classification of the underlying cause of the SLA breach. Used for trend analysis and preventive action planning. [ENUM-REF-CANDIDATE: network_outage|equipment_failure|capacity_overload|configuration_error|external_factor|planned_maintenance|unknown — 7 candidates stripped; promote to reference product]',
    `root_cause_description` STRING COMMENT 'Detailed narrative explanation of the root cause analysis findings for the SLA breach. Documents technical and operational factors.',
    `source_system` STRING COMMENT 'Operational system that originated or recorded the SLA breach event. Identifies the system of record for data lineage and reconciliation.. Valid values are `nokia_netact|ericsson_nm|servicenow_itsm|custom_assurance_platform`',
    `threshold_unit` STRING COMMENT 'Unit of measurement for both the contracted threshold and actual measured values. Ensures consistent interpretation of performance metrics. [ENUM-REF-CANDIDATE: percent|milliseconds|seconds|minutes|mbps|gbps|packets_per_second — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_sla_breach_event PRIMARY KEY(`sla_breach_event_id`)
) COMMENT 'Transactional record capturing each instance where a service or network KPI breaches a defined SLA threshold. Captures breach event ID, referenced SLA contract, affected service instance, affected customer account, breach type (availability/MTTR/latency/packet-loss), breach start timestamp, breach end timestamp, breach duration (minutes), contracted threshold, actual measured value, breach severity, penalty applicable flag, penalty amount, notification sent flag, and notification timestamp. Critical for revenue assurance penalty calculations and regulatory reporting.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`assurance`.`fraud_case` (
    `fraud_case_id` BIGINT COMMENT 'Unique identifier for the fraud case record. Primary key for the fraud case entity.',
    `addon_id` BIGINT COMMENT 'Foreign key linking to product.addon. Business justification: Fraud cases frequently involve specific add-ons (e.g., international roaming add-on fraud, premium SMS add-on abuse, SIM-based VoIP add-on misuse). Add-on-level fraud analysis drives targeted fraud pr',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: When fraud_type=DEVICE_CLONING or MAC_SPOOFING, links fraudulent activity to specific CPE MAC addresses for device blacklisting, subscriber notification, and device security vulnerability analysis',
    `msisdn_range_id` BIGINT COMMENT 'Foreign key linking to inventory.msisdn_range. Business justification: MSISDN range fraud (number spoofing, range hijacking, CLI fraud) requires linking fraud cases to the specific number range for regulatory reporting to numbering authorities, range quarantine decisions',
    `ont_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.ont_asset. Business justification: ONT cloning and unauthorized ONT connections are known fiber fraud vectors. Linking fraud_case to ont_asset enables investigation of specific hardware involved, supports law enforcement evidence colle',
    `sim_stock_id` BIGINT COMMENT 'Foreign key linking to inventory.sim_stock. Business justification: Tracks which SIM cards are involved in SIM swap fraud, cloning, or IRSF attacks for inventory quarantine, EIR blacklisting, and fraud pattern analysis by SIM batch/manufacturer.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the subscriber account impacted by the fraud incident.',
    `team_id` BIGINT COMMENT 'Foreign key linking to workforce.team. Business justification: Fraud investigation team assignment: fraud cases are assigned to specialized workforce teams (fraud investigation units). fraud_case.assigned_team is a plain text field; a proper FK enables fraud team',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Fraud cases (subscription fraud, account takeover, payment fraud) require billing account context for investigation, recovery, and pattern detection. Core fraud management workflow linking security ev',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to interconnect.carrier. Business justification: Interconnect fraud cases (IRSF, SIM box bypass, CLI spoofing) are directly associated with a specific carrier. Fraud investigation and recovery processes require identifying the originating/terminatin',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Fraud patterns are product-specific (international roaming fraud, premium content fraud, device subsidy fraud); linking enables product-specific fraud rule tuning, risk scoring, and targeted preventio',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise fraud investigation: fraud cases affecting corporate accounts (toll fraud on enterprise voice, SIM cloning on IoT) must link to the corporate account for account security management, law en',
    `data_breach_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.data_breach_incident. Business justification: Fraud investigations (account takeover, SIM swap, subscription fraud) often uncover data breaches or are caused by breaches. Links fraud case to breach record for root cause analysis, regulatory repor',
    `dealer_id` BIGINT COMMENT 'Foreign key linking to partner.dealer. Business justification: Dealer fraud cases (activation fraud, identity theft, SIM swap fraud) require dealer attribution for investigation, compliance enforcement, dealer termination decisions, and fraud loss recovery from d',
    `device_registration_id` BIGINT COMMENT 'Foreign key linking to customer.device_registration. Business justification: Device-based fraud (IMEI cloning, stolen devices) requires linking fraud cases to registered devices for investigation, CEIR blocking, and device blacklisting. Real business process: device fraud inve',
    `fraud_pattern_id` BIGINT COMMENT 'Reference to a known fraud pattern or signature that matches the characteristics of this case for trend analysis.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Fraud cases are often initiated from disputed invoices containing fraudulent charges (e.g., unauthorized roaming, SIM cloning charges). Telco fraud investigators need to reference the specific invoice',
    `iot_deployment_id` BIGINT COMMENT 'Foreign key linking to enterprise.iot_deployment. Business justification: IoT fraud containment: fraud cases involving SIM cloning or unauthorized data usage on IoT deployments must link to the specific IoT deployment for immediate containment actions, insurance claims, and',
    `lawful_intercept_order_id` BIGINT COMMENT 'Foreign key linking to compliance.lawful_intercept_order. Business justification: Fraud cases may trigger law enforcement requests for lawful intercepts to investigate criminal activity (fraud rings, identity theft). Links fraud investigation to intercept order for legal compliance',
    `mnp_compliance_id` BIGINT COMMENT 'Foreign key linking to compliance.mnp_compliance. Business justification: Fraudulent MNP porting (unauthorized number transfers) is a major telecom fraud vector. When MNP fraud is detected, a fraud_case is opened referencing the specific mnp_compliance record. Fraud investi',
    `mnp_transaction_id` BIGINT COMMENT 'Foreign key linking to interconnect.mnp_transaction. Business justification: Unauthorized number porting (MNP fraud) is a regulated fraud type requiring investigation. Fraud cases involving SIM swap or unauthorized port must reference the mnp_transaction to support law enforce',
    `element_id` BIGINT COMMENT 'Identifier of the network element or node involved in or affected by the fraud incident.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: Fraud cases in telecom are associated with specific offerings (e.g., SIM swap fraud on prepaid offering, subscription fraud on unlimited data offering). Offering-level fraud analysis drives product ri',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: Fraud cases are linked to price plans to identify which plans are most susceptible to fraud (e.g., unlimited data plans targeted for SIM box fraud, free trial plans for subscription fraud). Price plan',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Fraud cases meeting regulatory thresholds require formal filings with telecom authorities or financial regulators. Linking fraud_case to the resulting regulatory_filing enables end-to-end compliance t',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Telecom fraud cases (SIM swap, subscription fraud, bypass fraud) are subject to specific regulatory reporting obligations to national telecom authorities. Compliance teams must trace which regulatory ',
    `roaming_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.partner_roaming_agreement. Business justification: Roaming fraud cases (IRSF, SIM box fraud, bypass fraud) require roaming agreement linkage for liability determination, fraud threshold enforcement, settlement disputes, and potential agreement termina',
    `svc_instance_id` BIGINT COMMENT 'Unique identifier of the telecommunications service instance impacted by the fraud activity.',
    `tap_file_id` BIGINT COMMENT 'Foreign key linking to interconnect.tap_file. Business justification: TAP files are the primary evidence source for roaming fraud investigations. Fraud cases arising from TAP file anomaly analysis (e.g., inflated CDR counts, abnormal charges) must reference the source T',
    `affected_msisdn` STRING COMMENT 'Phone number of the affected subscriber involved in the fraud incident.. Valid values are `^[0-9]{10,15}$`',
    `alert_severity` STRING COMMENT 'Severity classification of the initial fraud alert indicating the urgency and potential impact of the detected anomaly.. Valid values are `critical|major|minor|warning|informational`',
    `alert_timestamp` TIMESTAMP COMMENT 'Date and time when the fraud detection system generated the initial alert that led to case creation.',
    `case_closed_timestamp` TIMESTAMP COMMENT 'Date and time when the fraud case was formally closed after investigation completion and resolution.',
    `case_number` STRING COMMENT 'Business-facing unique case number assigned to the fraud investigation for external reference and tracking.. Valid values are `^FRD-[0-9]{8,12}$`',
    `case_opened_timestamp` TIMESTAMP COMMENT 'Date and time when the fraud case was formally opened and assigned for investigation.',
    `case_priority` STRING COMMENT 'Business priority assigned to the fraud case based on severity, financial impact, and urgency for investigation and resolution.. Valid values are `critical|high|medium|low`',
    `case_status` STRING COMMENT 'Current lifecycle status of the fraud case indicating investigation progress and resolution state.. Valid values are `open|under-investigation|suspended|closed-confirmed|closed-false-positive|escalated`',
    `confirmed_fraud_loss_amount` DECIMAL(18,2) COMMENT 'Verified and confirmed financial loss amount after investigation completion and validation of fraudulent activity.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the fraud activity originated or was detected.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this fraud case record was first created in the fraud management system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all monetary amounts in this fraud case record.. Valid values are `^[A-Z]{3}$`',
    `detection_rule_reference` STRING COMMENT 'Reference identifier for the specific fraud detection rule, algorithm, or model that triggered the alert.',
    `detection_source` STRING COMMENT 'Origin system or channel that initially detected and raised the fraud alert triggering case creation.. Valid values are `automated-rule|ml-model|customer-report|partner-notification|manual-review|revenue-assurance`',
    `estimated_fraud_loss_amount` DECIMAL(18,2) COMMENT 'Initial estimated financial loss amount attributed to the fraud incident at the time of detection, before investigation confirmation.',
    `evidence_references` STRING COMMENT 'References to supporting evidence documents, call detail records (CDR), logs, screenshots, or other artifacts collected during investigation.',
    `false_positive_flag` BOOLEAN COMMENT 'Indicates whether the fraud case was determined to be a false positive after investigation, with no actual fraudulent activity confirmed.',
    `fraud_confidence_score` DECIMAL(18,2) COMMENT 'Numerical confidence score (0-100) indicating the likelihood that the detected activity is genuine fraud based on detection algorithms and investigation findings.',
    `fraud_subtype` STRING COMMENT 'Detailed subclassification within the primary fraud type for granular categorization and pattern analysis.',
    `fraud_type` STRING COMMENT 'Classification of the fraud incident type. [ENUM-REF-CANDIDATE: sim-swap|subscription-fraud|bypass-fraud|roaming-fraud|pbx-hacking|wangiri|irsf|dealer-fraud|identity-theft|device-fraud|refund-fraud|premium-rate-fraud — promote to reference product]. Valid values are `sim-swap|subscription-fraud|bypass-fraud|roaming-fraud|pbx-hacking|wangiri`',
    `geographic_region` STRING COMMENT 'Geographic region or market where the fraud incident occurred or was detected.',
    `investigation_notes` STRING COMMENT 'Detailed narrative notes documenting investigation activities, findings, interviews, and analysis performed during the fraud case lifecycle.',
    `last_modified_by` STRING COMMENT 'User identifier or system account that last modified this fraud case record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this fraud case record was last updated or modified.',
    `law_enforcement_agency` STRING COMMENT 'Name of the law enforcement agency or department to which the fraud case was referred.',
    `law_enforcement_case_number` STRING COMMENT 'External case or incident number assigned by the law enforcement agency for tracking the criminal investigation.',
    `law_enforcement_referral_flag` BOOLEAN COMMENT 'Indicates whether the fraud case has been referred to law enforcement authorities for criminal investigation and prosecution.',
    `law_enforcement_referral_timestamp` TIMESTAMP COMMENT 'Date and time when the fraud case was formally referred to law enforcement agencies.',
    `preventive_action_taken` STRING COMMENT 'Description of preventive measures or controls implemented as a result of this fraud case to prevent future similar incidents.',
    `recovery_amount` DECIMAL(18,2) COMMENT 'Total amount successfully recovered from the fraudster or through insurance claims and chargebacks.',
    `recovery_method` STRING COMMENT 'Method or mechanism used to recover financial losses from the fraud incident.. Valid values are `chargeback|insurance-claim|legal-recovery|write-off|partial-recovery|none`',
    `resolution_notes` STRING COMMENT 'Summary notes documenting the final resolution, outcome, and closure rationale for the fraud case.',
    `root_cause_category` STRING COMMENT 'High-level categorization of the root cause that enabled the fraud incident (process gap, system vulnerability, insider threat, etc.).',
    `root_cause_description` STRING COMMENT 'Detailed narrative description of the identified root cause and contributing factors that allowed the fraud to occur.',
    `trigger_type` STRING COMMENT 'Type of detection mechanism or condition that triggered the fraud alert (velocity check, threshold breach, pattern match, etc.).. Valid values are `velocity|threshold|pattern|blacklist|ml-signal|anomaly`',
    `created_by` STRING COMMENT 'User identifier or system account that created this fraud case record.',
    CONSTRAINT pk_fraud_case PRIMARY KEY(`fraud_case_id`)
) COMMENT 'Operational record covering the full fraud management lifecycle from initial detection alert through formal investigation, law enforcement referral, and resolution. Captures fraud case ID, fraud type (SIM-swap/subscription-fraud/bypass-fraud/roaming-fraud/PBX-hacking/wangiri/IRSF/dealer-fraud), detection source, detection rule reference, alert severity, trigger type (velocity/threshold/pattern/blacklist/ML-signal), alert timestamp, affected subscriber, affected service, estimated fraud loss amount, confirmed fraud loss amount, case status (open/under-investigation/suspended/closed-confirmed/closed-false-positive), assigned fraud analyst, investigation notes, evidence references, law enforcement referral flag, referral timestamp, recovery amount, recovery method, and case closure timestamp. Consolidates the detection-to-resolution workflow in a single entity with lifecycle stage tracking. Aligns with eTOM process 1.1.4 Fraud Management.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` (
    `fraud_alert_id` BIGINT COMMENT 'Unique identifier for the fraud alert record. Primary key.',
    `addon_id` BIGINT COMMENT 'Foreign key linking to product.addon. Business justification: Fraud alerts are triggered by anomalous usage of specific add-ons (e.g., excessive international calls on a roaming add-on, abnormal data usage on a speed boost add-on). Add-on-level fraud alert track',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: CPE-based fraud (MAC spoofing, unauthorized device, modem cloning) generates fraud alerts. Linking fraud_alert to cpe_asset enables device-level fraud investigation, CPE blacklisting, and correlation ',
    `msisdn_range_id` BIGINT COMMENT 'Foreign key linking to inventory.msisdn_range. Business justification: Fraud alerts involving MSISDN ranges (CLI spoofing, Wangiri fraud, range-level abuse) require linking to the number range for range-level fraud monitoring, regulatory reporting to numbering authoritie',
    `sim_stock_id` BIGINT COMMENT 'Foreign key linking to inventory.sim_stock. Business justification: SIM swap and SIM cloning fraud alerts must link to the specific SIM stock record for investigation, SIM deactivation, and batch fraud analysis. Telecom fraud teams routinely trace alerts to physical S',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Real-time fraud alerts trigger on account-level anomalies (unusual spend spikes, payment method changes, velocity attacks). Operational fraud prevention requires immediate account context for blocking',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to interconnect.carrier. Business justification: Real-time fraud alerts for roaming/interconnect fraud (IRSF, bypass) must reference the carrier involved to enable immediate blocking or rate limiting. Carrier-level fraud alert routing is a core inte',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Real-time fraud detection rules vary by product type; linking enables context-aware alerting, product-specific threshold configuration, and false positive reduction through product behavior profiling.',
    `device_registration_id` BIGINT COMMENT 'Foreign key linking to customer.device_registration. Business justification: Fraud alerts triggered by device-level anomalies (IMEI cloning, unauthorized SIM swap on a specific device) must reference the device registration record. fraud_alert.affected_imei is a denormalized d',
    `fraud_case_id` BIGINT COMMENT 'Foreign key to the formal fraud investigation case if this alert was escalated. Null if alert was closed without escalation or is still under initial review.',
    `fraud_pattern_id` BIGINT COMMENT 'Foreign key linking to assurance.fraud_pattern. Business justification: A fraud alert is triggered by a specific fraud pattern rule. The fraud_pattern table is the master reference for fraud detection patterns. Linking fraud_alert to fraud_pattern identifies which pattern',
    `kpi_threshold_id` BIGINT COMMENT 'Unique identifier of the fraud detection rule in the fraud management system that generated this alert.',
    `element_id` BIGINT COMMENT 'Identifier of the network element (cell tower, base station, gateway, switch) where the suspicious activity originated or was detected.',
    `nrtrde_record_id` BIGINT COMMENT 'Foreign key linking to interconnect.nrtrde_record. Business justification: NRTRDE exists specifically for near-real-time roaming fraud detection. Fraud alerts generated from NRTRDE analysis must reference the source record — this is the primary operational purpose of NRTRDE ',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: Fraud alerts are triggered by anomalous usage patterns on specific offerings. Offering-level fraud alert aggregation is used in product risk management and fraud prevention reporting. fraud_alert has ',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: Fraud alerts are triggered by usage anomalies relative to price plan allowances (e.g., data usage 10x the plan allowance). Linking alert to price plan enables plan-level fraud risk scoring and thresho',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the subscriber account associated with the suspected fraudulent activity.',
    `tap_record_id` BIGINT COMMENT 'Foreign key linking to interconnect.tap_record. Business justification: Individual TAP records trigger fraud alerts when charges exceed IOT rates or usage patterns indicate IRSF. Linking fraud_alert to the specific tap_record enables investigators to drill into the exact ',
    `acknowledged_timestamp` TIMESTAMP COMMENT 'Timestamp when a fraud analyst acknowledged the alert and began review. Null if alert has not been acknowledged.',
    `action_taken` STRING COMMENT 'Description of the immediate remediation action taken in response to the alert, such as service suspension, account barring, SIM deactivation, transaction reversal, or customer notification.',
    `actual_value` DECIMAL(18,2) COMMENT 'The actual observed value that triggered the alert, such as the number of calls made, total charge amount, or data volume consumed during the detection window.',
    `affected_imsi` STRING COMMENT 'The IMSI associated with the subscriber at the time of the alert, used to uniquely identify the subscriber on the network. Personally identifiable information.',
    `affected_msisdn` STRING COMMENT 'The mobile phone number (MSISDN) on which the suspicious activity was detected. Personally identifiable information.',
    `alert_generated_timestamp` TIMESTAMP COMMENT 'Timestamp when the alert record was created in the fraud management system, may differ slightly from detection_timestamp due to processing latency.',
    `alert_number` STRING COMMENT 'Human-readable business identifier for the fraud alert, typically formatted as FA- followed by a 10-digit sequence number.. Valid values are `^FA-[0-9]{10}$`',
    `alert_priority` STRING COMMENT 'Business priority assigned to the alert for queue management and resource allocation, distinct from severity which reflects technical risk.. Valid values are `urgent|high|normal|low`',
    `alert_severity` STRING COMMENT 'Severity classification of the fraud alert indicating the urgency and potential impact: critical (immediate action required), high (escalate quickly), medium (investigate within SLA), low (monitor).. Valid values are `critical|high|medium|low`',
    `alert_status` STRING COMMENT 'Current lifecycle status of the fraud alert: new (unreviewed), acknowledged (assigned to analyst), investigating (under review), escalated (promoted to fraud case), closed (resolved), false-positive (dismissed as non-fraud).. Valid values are `new|acknowledged|investigating|escalated|closed|false-positive`',
    `alert_trigger_type` STRING COMMENT 'Category of fraud detection trigger that generated the alert: velocity (rapid usage), threshold (limit breach), pattern (behavioral anomaly), blacklist (known fraud entity), anomaly (statistical outlier), or geo-location (impossible travel).. Valid values are `velocity|threshold|pattern|blacklist|anomaly|geo-location`',
    `analyst_notes` STRING COMMENT 'Free-text notes entered by the fraud analyst during alert review, documenting findings, rationale for decisions, and any additional context.',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the alert was closed, either by resolution, escalation to case, or dismissal as false positive. Null if still open.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Machine learning or rule-based confidence score (0-100) indicating the likelihood that the alert represents genuine fraud. Higher scores indicate higher confidence.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the suspicious activity was detected, such as USA, GBR, DEU.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fraud alert record was first created in the lakehouse silver layer. Audit trail field.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated revenue impact amount, such as USD, EUR, GBP.. Valid values are `^[A-Z]{3}$`',
    `detection_timestamp` TIMESTAMP COMMENT 'Timestamp when the fraud detection system identified the suspicious activity and generated the alert. Represents the real-world event time.',
    `detection_window_end` TIMESTAMP COMMENT 'End timestamp of the time window during which the fraud detection rule evaluated activity. Used for velocity and pattern-based rules.',
    `detection_window_start` TIMESTAMP COMMENT 'Start timestamp of the time window during which the fraud detection rule evaluated activity. Used for velocity and pattern-based rules.',
    `escalated_timestamp` TIMESTAMP COMMENT 'Timestamp when the alert was escalated to a formal fraud case for investigation. Null if not escalated.',
    `estimated_revenue_impact` DECIMAL(18,2) COMMENT 'Estimated financial impact of the suspected fraud in the billing currency, representing potential revenue loss or fraudulent charges. Business-sensitive financial data.',
    `false_positive_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the alert was determined to be a false positive after analyst review. True if false positive, False if genuine fraud or still under investigation.',
    `fraud_category` STRING COMMENT 'High-level category grouping fraud types for reporting and analytics: revenue-assurance (billing/charging fraud), network-abuse (traffic pumping, toll fraud), identity-fraud (account takeover, SIM swap), device-fraud (cloning, IMEI manipulation), roaming-fraud, content-fraud (premium SMS, OTT abuse).. Valid values are `revenue-assurance|network-abuse|identity-fraud|device-fraud|roaming-fraud|content-fraud`',
    `fraud_type` STRING COMMENT 'Classification of the suspected fraud type, such as subscription fraud, identity theft, SIM swap fraud, international revenue share fraud (IRSF), wangiri fraud, PBX hacking, roaming fraud, or revenue leakage. [ENUM-REF-CANDIDATE: subscription-fraud|identity-theft|sim-swap|irsf|wangiri|pbx-hacking|roaming-fraud|revenue-leakage|account-takeover|device-cloning|premium-rate-abuse — promote to reference product]',
    `geographic_region` STRING COMMENT 'Geographic region where the suspicious activity originated, such as North America, EMEA, APAC, LATAM. Used for regional fraud pattern analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fraud alert record was last updated in the lakehouse silver layer. Audit trail field.',
    `network_element_type` STRING COMMENT 'Type of network element involved in the alert, such as RAN (Radio Access Network), Core, BNG (Broadband Network Gateway), OLT (Optical Line Terminal), or CPE (Customer Premises Equipment).',
    `notification_sent_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a fraud alert notification was sent to the affected subscriber. True if notification sent, False otherwise.',
    `notification_timestamp` TIMESTAMP COMMENT 'Timestamp when the fraud alert notification was sent to the subscriber via SMS, email, or mobile app push notification. Null if no notification sent.',
    `risk_score` DECIMAL(18,2) COMMENT 'Composite risk score (0-100) combining fraud likelihood, potential financial impact, and subscriber risk profile. Used for prioritization.',
    `source_system` STRING COMMENT 'Name of the fraud detection or revenue assurance system that generated the alert, such as Subex ROC, FICO Falcon Fraud Manager, WeDo RAID, or internal fraud engine.',
    `source_system_alert_reference` STRING COMMENT 'Native alert identifier from the originating fraud detection system, used for traceability and cross-system reconciliation.',
    `threshold_unit` STRING COMMENT 'Unit of measure for the threshold and actual values, such as calls, SMS, currency (USD, EUR), megabytes (MB), minutes, or transactions.',
    `threshold_value` DECIMAL(18,2) COMMENT 'The threshold limit configured in the fraud rule that was breached, triggering the alert. For example, maximum call count, maximum charge amount, or maximum data volume.',
    CONSTRAINT pk_fraud_alert PRIMARY KEY(`fraud_alert_id`)
) COMMENT 'Real-time or near-real-time alert generated by fraud detection rules or threshold triggers indicating suspicious activity on a subscriber account or network element. Captures alert ID, alert rule name, alert trigger type (velocity/threshold/pattern/blacklist), alert severity, affected subscriber or network element, alert timestamp, alert status (new/acknowledged/escalated/closed/false-positive), linked fraud case ID (if escalated), and analyst notes. Distinct from fraud_case — an alert is the initial signal; a case is the formal investigation record.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`assurance`.`problem_record` (
    `problem_record_id` BIGINT COMMENT 'Unique identifier for the problem record in ServiceNow ITSM Problem Management. Primary key for the problem_record product.',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: Recurring CPE failures for specific units or models are tracked in problem management for proactive replacement campaigns. Linking problem_record to cpe_asset supports CPE model defect analysis, bulk ',
    `fiber_cable_id` BIGINT COMMENT 'Foreign key linking to inventory.fiber_cable. Business justification: Recurring fiber cable issues (degraded cable segment causing repeated outages) are classic problem management scenarios. Linking problem_record to fiber_cable supports cable replacement prioritization',
    `network_equipment_id` BIGINT COMMENT 'Foreign key linking to inventory.network_equipment. Business justification: ITIL problem management requires linking recurring problems to specific physical assets for root cause analysis, vendor escalation, and permanent fix tracking. Telecom problem managers expect this lin',
    `olt_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.olt_asset. Business justification: Recurring OLT failures (systematic PON port degradation, firmware bugs) are tracked in problem management. Linking problem_record to olt_asset supports OLT vendor escalation, firmware remediation trac',
    `ont_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.ont_asset. Business justification: Recurring ONT failures (systematic optical degradation, firmware issues) are tracked in problem management. Linking problem_record to ont_asset supports ONT model defect analysis, proactive replacemen',
    `team_id` BIGINT COMMENT 'Foreign key linking to workforce.team. Business justification: Problem management team assignment: problem records are assigned to specialist workforce teams for root cause investigation and permanent fix. problem_record.assigned_team is a plain text field; a pro',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Problem records (ITIL known errors) are associated with specific catalog items to track recurring product defects and known error database (KEDB) entries per product. Product-level problem trending is',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise problem management: problem records (root cause investigations) affecting corporate accounts must link to the corporate account for proactive communication, service improvement reporting, a',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: Problem records (ITIL) are associated with specific offerings to track recurring product defects and drive root cause analysis at the product level. Offering-level problem trending informs product imp',
    `element_id` BIGINT COMMENT 'Foreign key linking to network.element. Business justification: Problem management tracks recurring issues to specific network elements for trend analysis, preventive maintenance planning, and vendor quality feedback. ITIL-standard process requires linking known e',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Post-incident problem records in telecom often result in mandatory regulatory filings (formal post-incident reports to regulators). problem_record has rca_document_reference indicating formal reportin',
    `acknowledged_timestamp` TIMESTAMP COMMENT 'Date and time when the problem was acknowledged by the assigned problem manager or team. Indicates investigation has commenced.',
    `affected_customer_count` STRING COMMENT 'Estimated number of customers impacted by incidents related to this problem. Quantifies business impact and supports prioritization.',
    `affected_network_domain` STRING COMMENT 'Network domain or technology layer impacted by the problem (e.g., RAN, Core, Transport, BSS, OSS). Enables domain-specific problem analysis and MTBF tracking.',
    `affected_service_type` STRING COMMENT 'Type of customer-facing service impacted by the problem (e.g., voice, data, IPTV, broadband). Links problem to service quality and SLA metrics.',
    `affected_technology_type` STRING COMMENT 'Specific technology or platform affected by the problem (e.g., 5G NR, LTE, FTTH, GPON, IMS, VoLTE). Supports technology-specific root cause analysis.',
    `assigned_problem_manager` STRING COMMENT 'Name or identifier of the problem manager responsible for investigating and resolving this problem. Establishes accountability for problem resolution.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the problem record was formally closed after verification and documentation. Marks the end of the problem lifecycle.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this problem record was first created in the data platform. Used for data lineage and audit trail.',
    `estimated_revenue_impact` DECIMAL(18,2) COMMENT 'Estimated financial impact in currency units due to service disruption caused by this problem. Supports revenue assurance and business case for problem resolution.',
    `geographic_region` STRING COMMENT 'Geographic region or market where the problem was observed (e.g., Northeast, Southwest, EMEA, APAC). Supports regional problem trend analysis.',
    `identified_timestamp` TIMESTAMP COMMENT 'Date and time when the problem was first identified and the problem record was created. Marks the start of the problem investigation lifecycle.',
    `impact` STRING COMMENT 'Assessment of the business impact scope of the problem. Measures the extent of service degradation or customer affect.. Valid values are `widespread|significant|moderate|minor`',
    `investigation_duration_hours` DECIMAL(18,2) COMMENT 'Total time in hours spent investigating the problem from identification to root cause determination. Used for problem management efficiency KPIs.',
    `kedb_article_reference` STRING COMMENT 'Reference identifier or URL to the KEDB article documenting this known error. Provides link to detailed knowledge base entry.',
    `known_error_flag` BOOLEAN COMMENT 'Indicates whether this problem has been documented in the Known Error Database. True when root cause is identified and workaround is available.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this problem record was last updated. Tracks data currency and supports change data capture processes.',
    `notes` STRING COMMENT 'Additional notes, comments, or observations related to the problem investigation. Captures supplementary information not covered by structured fields.',
    `permanent_fix_description` STRING COMMENT 'Description of the permanent solution implemented to eliminate the root cause. Documents the change or remediation that resolves the problem.',
    `post_incident_review_flag` BOOLEAN COMMENT 'Indicates whether a formal post-incident review was conducted for this problem. True when major incidents triggered formal review process.',
    `preventive_action_taken` STRING COMMENT 'Description of proactive measures implemented to prevent recurrence of similar problems. Documents continuous improvement actions.',
    `priority` STRING COMMENT 'Business priority level assigned to the problem based on impact and urgency. Determines resource allocation and investigation timeline.. Valid values are `critical|high|medium|low`',
    `problem_category` STRING COMMENT 'High-level categorization of the problem type. Used for classification and routing to appropriate problem management teams.. Valid values are `hardware|software|network|application|database|security`',
    `problem_description` STRING COMMENT 'Detailed description of the problem, including symptoms, impact, and context. Provides comprehensive understanding of the issue under investigation.',
    `problem_number` STRING COMMENT 'Human-readable business identifier for the problem record, typically following ServiceNow PRB format (e.g., PRB0001234). Used for external communication and tracking.. Valid values are `^PRB[0-9]{7}$`',
    `problem_status` STRING COMMENT 'Current lifecycle state of the problem record. Tracks progression from identification through resolution and closure. [ENUM-REF-CANDIDATE: new|open|in_progress|known_error|resolved|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `problem_subcategory` STRING COMMENT 'Detailed subcategory providing granular classification within the problem category. Enables precise problem taxonomy and trend analysis.',
    `problem_title` STRING COMMENT 'Short descriptive title summarizing the problem being investigated. Provides quick identification of the problem nature.',
    `rca_document_reference` STRING COMMENT 'Reference identifier or URL to the formal RCA document. Links to detailed analysis report with investigation findings and recommendations.',
    `resolution_duration_hours` DECIMAL(18,2) COMMENT 'Total time in hours from problem identification to permanent fix implementation. Measures end-to-end problem resolution efficiency.',
    `resolved_timestamp` TIMESTAMP COMMENT 'Date and time when the permanent fix was implemented and the problem was resolved. Indicates the problem no longer causes incidents.',
    `root_cause_category` STRING COMMENT 'High-level classification of the identified root cause (e.g., configuration error, hardware failure, software defect, capacity issue, human error). Enables root cause trend analysis.',
    `root_cause_description` STRING COMMENT 'Detailed explanation of the underlying root cause identified through problem investigation. Documents the fundamental reason for recurring incidents.',
    `root_cause_identified_timestamp` TIMESTAMP COMMENT 'Date and time when the root cause was successfully identified. Marks transition to known error status and enables MTTR calculation.',
    `site_ids` STRING COMMENT 'Comma-separated list of network site IDs affected by this problem. Links problem to specific physical infrastructure locations.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether incidents related to this problem resulted in SLA breaches. True when customer SLA commitments were violated.',
    `source_system` STRING COMMENT 'Name of the system that originated the problem record (e.g., ServiceNow ITSM, Nokia NetAct, Ericsson Network Manager). Tracks data lineage.',
    `urgency` STRING COMMENT 'Time sensitivity of the problem resolution. Indicates how quickly the problem must be addressed to prevent further incidents.. Valid values are `critical|high|medium|low`',
    `vendor_involved` STRING COMMENT 'Name of external vendor or supplier involved in problem investigation or resolution (e.g., Nokia, Ericsson, Cisco). Tracks third-party engagement.',
    `vendor_ticket_reference` STRING COMMENT 'External ticket or case number from vendor support system. Enables tracking of vendor escalations and support interactions.',
    `workaround_description` STRING COMMENT 'Temporary solution or procedure to mitigate the problem impact while permanent fix is being developed. Enables incident teams to reduce service disruption.',
    CONSTRAINT pk_problem_record PRIMARY KEY(`problem_record_id`)
) COMMENT 'ServiceNow ITSM Problem Management record representing the root cause investigation of one or more recurring trouble tickets or incidents. Captures problem ID, problem title, problem category, linked incident/ticket IDs, affected network domain, root cause description, workaround description, permanent fix description, problem status (open/known-error/resolved/closed), priority, assigned problem manager, identified timestamp, resolved timestamp, and known error database (KEDB) flag. Enables proactive fault management and MTBF improvement tracking.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`assurance`.`outage_record` (
    `outage_record_id` BIGINT COMMENT 'Unique identifier for the outage record. Primary key for the outage event lifecycle tracking from detection through restoration and regulatory notification.',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Outages affect specific geographic areas. Linking to address enables customer impact identification by location, proactive notification to affected addresses, and service restoration prioritization. R',
    `fiber_cable_id` BIGINT COMMENT 'Foreign key linking to inventory.fiber_cable. Business justification: Fiber cable cuts are a top cause of network outages. Linking outage_record to fiber_cable supports regulatory outage reporting requiring physical infrastructure identification, right-of-way repair coo',
    `element_id` BIGINT COMMENT 'Identifier of the primary network element or infrastructure component that failed or was taken offline.',
    `network_equipment_id` BIGINT COMMENT 'Foreign key linking to inventory.network_equipment. Business justification: Outage post-mortems require linking to specific physical equipment for vendor SLA penalty claims, equipment replacement justification, and regulatory outage reporting that mandates identification of t',
    `olt_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.olt_asset. Business justification: OLT failures cause mass fiber outages. Linking outage_record to olt_asset supports regulatory outage reporting (which requires specific equipment identification), OLT vendor SLA claims, and post-outag',
    `alarm_event_id` BIGINT COMMENT 'Foreign key linking to assurance.alarm_event. Business justification: A network outage is typically detected and triggered by one or more alarm events. Linking outage_record to the primary triggering alarm_event provides the detection chain from alarm to confirmed outag',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to product.bundle. Business justification: Outage records track service unavailability events that affect specific bundles (e.g., a triple-play bundle outage). Bundle-level availability reporting and SLA breach calculation for bundle contracts',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Outage records must be attributed to specific catalog items for product-level availability reporting and regulatory submissions. Consistent with alarm_event, trouble_ticket, performance_measurement, s',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise outage notification and SLA breach triggering: outage records affecting enterprise customers must link to the corporate account for executive notification, SLA penalty calculation, and regu',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Managed service outage SLA tracking: outages affecting managed services must link to the managed service record for SLA breach calculation, credit issuance, and managed service availability reporting ',
    `mvno_profile_id` BIGINT COMMENT 'Foreign key linking to partner.mvno_profile. Business justification: Network outages affecting MVNO subscribers require MVNO profile linkage for regulatory reporting obligations, SLA breach calculation, and subscriber impact assessment per MVNO capacity and subscriber ',
    `noc_incident_id` BIGINT COMMENT 'Foreign key reference to the NOC incident record that captured the operational response and war-room coordination for this outage event.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: Outage records must be attributed to specific offerings for offering-level availability reporting, regulatory submissions on service availability, and SLA breach calculation. Telecom regulators requir',
    `peering_arrangement_id` BIGINT COMMENT 'Foreign key linking to interconnect.peering_arrangement. Business justification: Outages affecting IP peering arrangements (BGP session drops, IXP failures) must be recorded for SLA penalty calculation and regulatory reporting. Linking outage_record to peering_arrangement enables ',
    `poi_id` BIGINT COMMENT 'Foreign key linking to interconnect.poi. Business justification: Outages affecting Points of Interconnect must be recorded for regulatory reporting and carrier SLA penalty calculation. Linking outage_record to poi enables interconnect outage impact analysis and sup',
    `problem_record_id` BIGINT COMMENT 'Foreign key linking to assurance.problem_record. Business justification: Outage records can be linked to problem records for root cause analysis. This is N:1 (many outages can be associated with one underlying problem). The FK column does not currently exist and will be cr',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Outages meeting regulatory thresholds (duration, customer impact) must be reported via formal filings to FCC, OFCOM, EU regulators. Links outage data to submitted filing for audit trail and compliance',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Outages trigger specific compliance obligations: notification timelines, root cause analysis requirements, customer communication mandates. Operations teams need to identify which obligations apply to',
    `site_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_site. Business justification: Site-level outage restoration: outages at enterprise sites must link to the site record for field restoration dispatch, site-specific customer notification, and post-outage review. Regulatory reportin',
    `sla_contract_id` BIGINT COMMENT 'Foreign key linking to assurance.sla_contract. Business justification: An outage record must be assessed against the applicable SLA contract to determine breach status and penalty obligations. Linking outage_record to sla_contract enables direct SLA compliance assessment',
    `trouble_ticket_id` BIGINT COMMENT 'Foreign key linking to assurance.trouble_ticket. Business justification: A confirmed network outage generates a trouble ticket for fault management and resolution tracking. Linking outage_record to trouble_ticket provides direct traceability between the outage lifecycle re',
    `affected_cell_site_ids` STRING COMMENT 'Comma-separated list of cell site identifiers impacted by the outage for RAN-related events.',
    `affected_geography` STRING COMMENT 'Geographic scope of the outage impact: region, city, cell site, exchange, or specific service area identifier.',
    `affected_region` STRING COMMENT 'Regional classification of the outage footprint for operational and regulatory segmentation.',
    `affected_service_type` STRING COMMENT 'Type of service impacted by the outage: mobile voice, mobile data, broadband, IPTV, VoIP, enterprise connectivity, etc. Pipe-separated list for multiple services.',
    `compliance_officer_sign_off_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance officer approved and signed off on the regulatory notification submission.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the outage record was first created in the system.',
    `customer_notification_sent_flag` BOOLEAN COMMENT 'Indicates whether proactive customer notifications were sent regarding the outage event via SMS, email, or other channels.',
    `customer_notification_timestamp` TIMESTAMP COMMENT 'Timestamp when the first customer notification was sent regarding the outage event.',
    `detection_method` STRING COMMENT 'Method by which the outage was first detected: network alarm, performance monitoring system, customer trouble report, or proactive health check.. Valid values are `alarm|monitoring|customer-report|proactive`',
    `estimated_revenue_impact` DECIMAL(18,2) COMMENT 'Estimated financial impact of the outage in terms of lost revenue, service credits, and potential penalties.',
    `impacted_business_customer_count` BIGINT COMMENT 'Number of business or enterprise customers affected by the outage, tracked separately for priority restoration and regulatory reporting.',
    `impacted_subscriber_count` BIGINT COMMENT 'Total number of unique subscribers affected by the outage event. Key metric for regulatory threshold determination.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the outage record was last updated or modified.',
    `mttr_target_minutes` DECIMAL(18,2) COMMENT 'Target mean time to repair in minutes as defined by SLA or operational policy for this outage severity level.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, escalation details, or special circumstances related to the outage event.',
    `notification_due_timestamp` TIMESTAMP COMMENT 'Regulatory deadline timestamp by which the outage notification must be submitted to avoid compliance penalties.',
    `notification_submission_timestamp` TIMESTAMP COMMENT 'Timestamp when the regulatory notification was officially submitted to the governing body.',
    `outage_cause_category` STRING COMMENT 'Root cause classification for the outage event: hardware failure, software defect, power loss, fiber cut, weather event, or human error.. Valid values are `hardware|software|power|fiber-cut|weather|human-error`',
    `outage_cause_description` STRING COMMENT 'Detailed narrative description of the root cause and contributing factors for the outage event.',
    `outage_duration_minutes` DECIMAL(18,2) COMMENT 'Total duration of the outage event in minutes, calculated from start to end timestamp. Critical for SLA compliance and regulatory reporting.',
    `outage_end_timestamp` TIMESTAMP COMMENT 'Timestamp when service was fully restored and the outage event was closed.',
    `outage_number` STRING COMMENT 'Business-facing unique identifier for the outage event, used for external communication and regulatory reporting.. Valid values are `^OUT-[0-9]{8,12}$`',
    `outage_severity` STRING COMMENT 'Severity classification of the outage event based on service impact, subscriber count, and business criticality.. Valid values are `critical|major|minor`',
    `outage_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the outage event was first detected or when service disruption began.',
    `outage_status` STRING COMMENT 'Current lifecycle status of the outage record: detected, under investigation, restoration in progress, service restored, or record closed.. Valid values are `detected|investigating|restoring|restored|closed`',
    `outage_type` STRING COMMENT 'Classification of the outage as planned maintenance or unplanned service disruption.. Valid values are `planned|unplanned`',
    `post_outage_review_completed_flag` BOOLEAN COMMENT 'Indicates whether the post-outage review and root cause analysis have been completed and documented.',
    `post_outage_review_reference` STRING COMMENT 'Reference identifier or document link to the post-outage review report, root cause analysis, and preventive action plan.',
    `regulatory_body` STRING COMMENT 'Governing regulatory body to which the outage must be reported: FCC (USA), Ofcom (UK), BEREC (EU), NTIA (USA), CRTC (Canada), ACMA (Australia).. Valid values are `FCC|Ofcom|BEREC|NTIA|CRTC|ACMA`',
    `regulatory_notification_status` STRING COMMENT 'Current status of the regulatory notification workflow: not required, draft in preparation, submitted to regulator, acknowledged by regulator, or closed.. Valid values are `not-required|draft|submitted|acknowledged|closed`',
    `regulatory_reference_number` STRING COMMENT 'Reference number or case identifier assigned by the regulatory body upon submission of the outage notification.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether the outage event meets regulatory reporting thresholds and must be reported to governing bodies.',
    `reportable_threshold_met` STRING COMMENT 'Description of which regulatory threshold criteria were met: subscriber count threshold, duration threshold, service type threshold, or geographic scope threshold.',
    `restoration_method` STRING COMMENT 'Method used to restore service: automatic recovery, manual intervention, network failover, traffic bypass, equipment replacement, or on-site repair.. Valid values are `automatic|manual|failover|bypass|replacement|repair`',
    `restoration_priority` STRING COMMENT 'Priority level assigned to the restoration effort based on service impact, customer segment, and regulatory obligations.. Valid values are `critical|high|medium|low`',
    `restoration_team` STRING COMMENT 'Name or identifier of the NOC team, field operations team, or vendor team responsible for service restoration.',
    `sla_breach_count` STRING COMMENT 'Number of distinct SLA contracts breached as a result of this outage event.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the outage event resulted in a breach of contractual SLA commitments for availability, MTTR, or service quality.',
    `vendor_involved_flag` BOOLEAN COMMENT 'Indicates whether a third-party vendor or equipment manufacturer was involved in the outage cause or restoration effort.',
    `vendor_name` STRING COMMENT 'Name of the vendor or equipment manufacturer involved in the outage event or restoration.',
    `vendor_ticket_reference` STRING COMMENT 'Vendor-assigned ticket or case number for tracking the outage issue with the equipment manufacturer or service provider.',
    CONSTRAINT pk_outage_record PRIMARY KEY(`outage_record_id`)
) COMMENT 'Master record of a confirmed network or service outage event with full lifecycle tracking from detection to restoration and regulatory notification. Distinct from noc_incident (which captures the operational response and war-room coordination) — outage_record owns the infrastructure event facts: what failed, when, where, how long, and how many subscribers were impacted. Captures outage ID, outage type (planned/unplanned), outage cause category (hardware/software/power/fiber-cut/weather/human-error/cyber), affected network element or service, affected geography (region/cell/exchange), outage start timestamp, outage end timestamp, outage duration (minutes), impacted subscriber count, impacted service types, restoration method, restoration team, regulatory reportable flag, regulatory body (FCC/Ofcom/BEREC/NTIA), reportable threshold met (subscriber count/duration/service type), regulatory notification status (not-required/draft/submitted/acknowledged/closed), regulatory reference number, notification submission timestamp, compliance officer sign-off, and post-outage review reference.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` (
    `kpi_threshold_id` BIGINT COMMENT 'Unique identifier for the KPI threshold, alarm correlation rule, fraud detection rule, or suppression rule configuration record.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: KPI thresholds in telecom are defined per offering to enforce offering-specific SLA parameters (e.g., premium offering has stricter latency thresholds than basic offering). Offering-level threshold co',
    `parent_rule_kpi_threshold_id` BIGINT COMMENT 'Identifier of the parent rule if this rule is a derived or specialized version of another rule configuration. Null if this is a top-level rule.',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: KPI thresholds are calibrated to price plan QoS tiers — higher-tier price plans trigger stricter monitoring thresholds. This drives automated SLA compliance monitoring per price plan tier. kpi_thresho',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: KPI thresholds in telecom are frequently set to satisfy regulatory QoS obligations (e.g., minimum availability, latency mandates from national regulators). A regulatory compliance engineer expects KPI',
    `applicable_service_type` STRING COMMENT 'Service type or product category to which this rule applies, such as prepaid mobile, postpaid mobile, broadband, IPTV, VoIP, or enterprise services.',
    `auto_ticket_creation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether breaches or detections triggered by this rule automatically create a trouble ticket in the incident management system.',
    `correlated_alarm_types` STRING COMMENT 'Comma-separated list of alarm types or event codes that are correlated with the trigger alarm. Used by alarm correlation rules to identify related or cascading alarms.',
    `correlation_window_minutes` STRING COMMENT 'Time window in minutes within which correlated alarms must occur to be grouped together by this correlation rule.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rule configuration record was first created in the system.',
    `detection_logic_description` STRING COMMENT 'Detailed textual description of the detection logic, correlation algorithm, threshold condition, or fraud pattern that this rule implements.',
    `detection_method` STRING COMMENT 'Method or technique used for fraud or anomaly detection: velocity check, threshold breach, pattern matching, blacklist lookup, whitelist validation, machine learning signal, or rule-based logic. [ENUM-REF-CANDIDATE: velocity|threshold|pattern|blacklist|whitelist|ml_signal|rule_based — 7 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'Date from which this rule or threshold configuration becomes active and is applied by assurance monitoring systems.',
    `expiry_date` DATE COMMENT 'Date on which this rule or threshold configuration expires and is no longer applied. Null if the rule has no expiration.',
    `false_positive_rate_percent` DECIMAL(18,2) COMMENT 'Estimated or measured false positive rate for this detection rule, expressed as a percentage. Used to track and tune rule accuracy.',
    `fraud_type` STRING COMMENT 'Type of fraud or revenue leakage that this detection rule targets, such as subscription fraud, identity theft, SIM box fraud, international revenue share fraud, or usage anomaly. Applicable when rule_category is fraud_detection or revenue_leakage.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user or system that last modified this rule configuration record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this rule configuration record was last modified or updated.',
    `last_tuned_timestamp` TIMESTAMP COMMENT 'Timestamp when this rule or threshold was last tuned, adjusted, or recalibrated based on performance analysis or operational feedback.',
    `measurement_window_minutes` STRING COMMENT 'Time window in minutes over which the KPI measurement or event count is evaluated before comparing to the threshold. Used for sliding window and aggregation-based detection.',
    `network_domain` STRING COMMENT 'Network domain or technology layer to which this rule applies: Radio Access Network (RAN), transport, core network, Fiber to the Home (FTTH), Gigabit Passive Optical Network (GPON), IP Multimedia Subsystem (IMS), or all domains. [ENUM-REF-CANDIDATE: RAN|transport|core|FTTH|GPON|IMS|all — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text notes, comments, or additional context about this rule configuration, including tuning history, known issues, or special handling instructions.',
    `notification_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether breaches or detections triggered by this rule require immediate notification to operations teams or management.',
    `owning_team` STRING COMMENT 'Name of the team, department, or organizational unit responsible for maintaining and tuning this rule, such as Network Operations Center (NOC), Security Operations Center (SOC), or Revenue Assurance.',
    `priority_level` STRING COMMENT 'Numeric priority level assigned to this rule for processing order or escalation routing. Lower numbers typically indicate higher priority.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether breaches or detections triggered by this rule require reporting to regulatory authorities such as Federal Communications Commission (FCC) or International Telecommunication Union (ITU).',
    `root_cause_determination_logic` STRING COMMENT 'Description of the logic or algorithm used to determine the root cause alarm from a set of correlated alarms. Applicable for alarm correlation rules.',
    `rule_category` STRING COMMENT 'Classification of the rule type: KPI threshold breach detection, alarm correlation logic, alarm suppression rule, fraud detection rule, deduplication rule, or revenue leakage detection.. Valid values are `kpi_threshold|alarm_correlation|alarm_suppression|fraud_detection|deduplication|revenue_leakage`',
    `rule_identifier` STRING COMMENT 'Externally-known unique code or identifier for this threshold or rule configuration, used for reference across assurance systems.. Valid values are `^[A-Z0-9_-]{6,50}$`',
    `rule_name` STRING COMMENT 'Human-readable name of the threshold or rule configuration, describing its purpose and detection target.',
    `rule_status` STRING COMMENT 'Current operational status of the rule: active (in production use), inactive (disabled), testing (under evaluation), or deprecated (retired).. Valid values are `active|inactive|testing|deprecated`',
    `severity_level` STRING COMMENT 'Severity classification assigned to breaches or alarms triggered by this rule: critical, major, minor, warning, or informational.. Valid values are `critical|major|minor|warning|info`',
    `sla_impact_flag` BOOLEAN COMMENT 'Boolean flag indicating whether breaches detected by this rule have potential impact on customer Service Level Agreement (SLA) commitments.',
    `source_system` STRING COMMENT 'Name of the source system or platform from which this rule configuration originates, such as Nokia NetAct, Ericsson Network Manager, ServiceNow ITSM, or custom fraud detection platform.',
    `suppression_duration_minutes` STRING COMMENT 'Duration in minutes for which subsequent alarms of the same type are suppressed after the initial alarm is raised. Applicable for alarm suppression rules.',
    `technology_type` STRING COMMENT 'Specific technology or protocol to which this rule applies, such as 5G NR, LTE, VoLTE, MPLS, SD-WAN, or broadband access technology.',
    `threshold_direction` STRING COMMENT 'Direction of threshold breach that triggers an alert: above (greater than), below (less than), equal, or not equal to the threshold value.. Valid values are `above|below|equal|not_equal`',
    `threshold_unit` STRING COMMENT 'Unit of measure for the threshold value, such as percent, milliseconds, Mbps, count, transactions per minute, or currency.',
    `threshold_value` DECIMAL(18,2) COMMENT 'Numeric threshold value that triggers a breach or alert when crossed. Used for KPI threshold rules and fraud detection velocity/threshold rules.',
    `trigger_alarm_type` STRING COMMENT 'Primary alarm type or event code that triggers this correlation or suppression rule. Applicable when rule_category is alarm_correlation or alarm_suppression.',
    `version_number` STRING COMMENT 'Version number of this rule configuration, following semantic versioning format (major.minor.patch). Used to track rule evolution and changes over time.. Valid values are `^[0-9]+.[0-9]+.[0-9]+$`',
    `created_by` STRING COMMENT 'Username or identifier of the user or system that created this rule configuration record.',
    CONSTRAINT pk_kpi_threshold PRIMARY KEY(`kpi_threshold_id`)
) COMMENT 'Unified reference master and single source of truth for ALL detection rules, correlation logic, suppression rules, and threshold configurations used across the assurance domain. Encompasses: (1) KPI breach thresholds for performance monitoring (threshold value, direction, measurement window, severity); (2) Alarm correlation and suppression rules from Nokia NetAct/Ericsson NM (trigger alarm type, correlated alarm types, correlation window, root cause determination logic, suppression duration); (3) Fraud detection rules (fraud type targeted, detection method — velocity/threshold/pattern/blacklist/ML-signal, trigger threshold, applicable service type, false positive rate). Captures rule/threshold ID, rule name, rule category (KPI-threshold/alarm-correlation/alarm-suppression/fraud-detection/deduplication), detection logic description, network domain applicability (RAN/transport/core/FTTH), severity classification, rule status (active/inactive/testing), effective date, expiry date, last tuned timestamp, and owning team. Provides the authoritative rules and threshold registry consumed by all assurance monitoring and detection systems.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`assurance`.`fraud_pattern` (
    `fraud_pattern_id` BIGINT COMMENT 'Primary key for fraud_pattern',
    `evolved_from_fraud_pattern_id` BIGINT COMMENT 'Self-referencing FK on fraud_pattern (evolved_from_fraud_pattern_id)',
    `iot_tariff_id` BIGINT COMMENT 'Foreign key linking to interconnect.iot_tariff. Business justification: Fraud patterns for IRSF and interconnect bypass are calibrated against IOT tariff rates — charges significantly exceeding IOT rates signal fraud. Linking fraud_pattern to iot_tariff enables dynamic th',
    `kpi_threshold_id` BIGINT COMMENT 'Foreign key linking to assurance.kpi_threshold. Business justification: The kpi_threshold table is the SSOT for ALL detection rules, correlation logic, and suppression rules — explicitly including fraud detection thresholds. A fraud_pattern should reference its governing ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Fraud detection patterns in telecom are often defined or mandated by regulatory obligations (GSMA fraud reporting standards, national telecom authority requirements). fraud_pattern already has regulat',
    `alert_threshold` DECIMAL(18,2) COMMENT 'Threshold for escalating a detection to a high‑priority alert.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the fraud pattern record was first created in the system.',
    `detection_method` STRING COMMENT 'Technique used to detect the pattern, such as rule‑based logic or machine‑learning model.',
    `detection_threshold` DECIMAL(18,2) COMMENT 'Numeric threshold that triggers the pattern (e.g., number of suspicious events within a time window).',
    `effective_from` DATE COMMENT 'Date from which the fraud pattern becomes applicable for detection.',
    `effective_until` DATE COMMENT 'Date after which the fraud pattern is no longer applied (null for indefinite).',
    `fraud_type` STRING COMMENT 'Specific type of fraud addressed by the pattern.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the pattern is currently enabled for detection.',
    `last_review_date` DATE COMMENT 'Date when the pattern was last reviewed for relevance and accuracy.',
    `mitigation_action` STRING COMMENT 'Recommended operational response when the pattern is triggered (e.g., block account, flag for review).',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information about the pattern.',
    `pattern_category` STRING COMMENT 'High‑level classification of the fraud pattern (e.g., billing fraud, authentication fraud).',
    `pattern_description` STRING COMMENT 'Detailed textual description of the fraud scenario, including typical indicators and attack vectors.',
    `pattern_name` STRING COMMENT 'Human‑readable name of the fraud pattern used by detection engines.',
    `pattern_status` STRING COMMENT 'Lifecycle status of the pattern within the fraud management catalog.',
    `pattern_tags` STRING COMMENT 'Comma‑separated list of keywords for search and grouping (e.g., SIM swap,high value).',
    `pattern_version` STRING COMMENT 'Version identifier for the pattern definition, supporting change management.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'True if the pattern is required for compliance with telecom fraud regulations.',
    `reviewed_by` STRING COMMENT 'Identifier of the analyst or team that performed the last review.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk score (0‑100) representing likelihood and impact of the pattern.',
    `severity_level` STRING COMMENT 'Business impact rating of the fraud pattern if triggered.',
    `source_system` STRING COMMENT 'Name of the upstream system that supplied the fraud pattern definition (e.g., NetAct, ServiceNow).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the fraud pattern record.',
    CONSTRAINT pk_fraud_pattern PRIMARY KEY(`fraud_pattern_id`)
) COMMENT 'Master reference table for fraud_pattern. Referenced by fraud_pattern_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ADD CONSTRAINT `fk_assurance_alarm_event_kpi_threshold_id` FOREIGN KEY (`kpi_threshold_id`) REFERENCES `telecommunication_ecm`.`assurance`.`kpi_threshold`(`kpi_threshold_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_noc_incident_id` FOREIGN KEY (`noc_incident_id`) REFERENCES `telecommunication_ecm`.`assurance`.`noc_incident`(`noc_incident_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ADD CONSTRAINT `fk_assurance_trouble_ticket_problem_record_id` FOREIGN KEY (`problem_record_id`) REFERENCES `telecommunication_ecm`.`assurance`.`problem_record`(`problem_record_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ADD CONSTRAINT `fk_assurance_noc_incident_alarm_event_id` FOREIGN KEY (`alarm_event_id`) REFERENCES `telecommunication_ecm`.`assurance`.`alarm_event`(`alarm_event_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ADD CONSTRAINT `fk_assurance_noc_incident_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ADD CONSTRAINT `fk_assurance_performance_measurement_kpi_threshold_id` FOREIGN KEY (`kpi_threshold_id`) REFERENCES `telecommunication_ecm`.`assurance`.`kpi_threshold`(`kpi_threshold_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ADD CONSTRAINT `fk_assurance_sla_contract_parent_sla_contract_id` FOREIGN KEY (`parent_sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_alarm_event_id` FOREIGN KEY (`alarm_event_id`) REFERENCES `telecommunication_ecm`.`assurance`.`alarm_event`(`alarm_event_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_kpi_threshold_id` FOREIGN KEY (`kpi_threshold_id`) REFERENCES `telecommunication_ecm`.`assurance`.`kpi_threshold`(`kpi_threshold_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_noc_incident_id` FOREIGN KEY (`noc_incident_id`) REFERENCES `telecommunication_ecm`.`assurance`.`noc_incident`(`noc_incident_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_performance_measurement_id` FOREIGN KEY (`performance_measurement_id`) REFERENCES `telecommunication_ecm`.`assurance`.`performance_measurement`(`performance_measurement_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ADD CONSTRAINT `fk_assurance_sla_breach_event_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ADD CONSTRAINT `fk_assurance_fraud_case_fraud_pattern_id` FOREIGN KEY (`fraud_pattern_id`) REFERENCES `telecommunication_ecm`.`assurance`.`fraud_pattern`(`fraud_pattern_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ADD CONSTRAINT `fk_assurance_fraud_alert_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `telecommunication_ecm`.`assurance`.`fraud_case`(`fraud_case_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ADD CONSTRAINT `fk_assurance_fraud_alert_fraud_pattern_id` FOREIGN KEY (`fraud_pattern_id`) REFERENCES `telecommunication_ecm`.`assurance`.`fraud_pattern`(`fraud_pattern_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ADD CONSTRAINT `fk_assurance_fraud_alert_kpi_threshold_id` FOREIGN KEY (`kpi_threshold_id`) REFERENCES `telecommunication_ecm`.`assurance`.`kpi_threshold`(`kpi_threshold_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_alarm_event_id` FOREIGN KEY (`alarm_event_id`) REFERENCES `telecommunication_ecm`.`assurance`.`alarm_event`(`alarm_event_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_noc_incident_id` FOREIGN KEY (`noc_incident_id`) REFERENCES `telecommunication_ecm`.`assurance`.`noc_incident`(`noc_incident_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_problem_record_id` FOREIGN KEY (`problem_record_id`) REFERENCES `telecommunication_ecm`.`assurance`.`problem_record`(`problem_record_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_sla_contract_id` FOREIGN KEY (`sla_contract_id`) REFERENCES `telecommunication_ecm`.`assurance`.`sla_contract`(`sla_contract_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ADD CONSTRAINT `fk_assurance_outage_record_trouble_ticket_id` FOREIGN KEY (`trouble_ticket_id`) REFERENCES `telecommunication_ecm`.`assurance`.`trouble_ticket`(`trouble_ticket_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ADD CONSTRAINT `fk_assurance_kpi_threshold_parent_rule_kpi_threshold_id` FOREIGN KEY (`parent_rule_kpi_threshold_id`) REFERENCES `telecommunication_ecm`.`assurance`.`kpi_threshold`(`kpi_threshold_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_pattern` ADD CONSTRAINT `fk_assurance_fraud_pattern_evolved_from_fraud_pattern_id` FOREIGN KEY (`evolved_from_fraud_pattern_id`) REFERENCES `telecommunication_ecm`.`assurance`.`fraud_pattern`(`fraud_pattern_id`);
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_pattern` ADD CONSTRAINT `fk_assurance_fraud_pattern_kpi_threshold_id` FOREIGN KEY (`kpi_threshold_id`) REFERENCES `telecommunication_ecm`.`assurance`.`kpi_threshold`(`kpi_threshold_id`);

-- ========= TAGS =========
ALTER SCHEMA `telecommunication_ecm`.`assurance` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `telecommunication_ecm`.`assurance` SET TAGS ('dbx_domain' = 'assurance');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` SET TAGS ('dbx_subdomain' = 'fault_management');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `alarm_event_id` SET TAGS ('dbx_business_glossary_term' = 'Alarm Event Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `addon_id` SET TAGS ('dbx_business_glossary_term' = 'Addon Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Ip Address Pool Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Svc Instance Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `kpi_threshold_id` SET TAGS ('dbx_business_glossary_term' = 'Alarm Suppression Rule Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Object Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Object Network Equipment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `olt_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Object Olt Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `ont_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Object Ont Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Network Element Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `poi_id` SET TAGS ('dbx_business_glossary_term' = 'Poi Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `acknowledged_by_user` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged By User');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `actual_resolution_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Minutes');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `affected_service_type` SET TAGS ('dbx_business_glossary_term' = 'Affected Service Type');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `alarm_acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alarm Acknowledged Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `alarm_cleared_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alarm Cleared Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `alarm_identifier` SET TAGS ('dbx_business_glossary_term' = 'Alarm Identifier');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `alarm_raised_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alarm Raised Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `alarm_severity` SET TAGS ('dbx_business_glossary_term' = 'Alarm Severity');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `alarm_severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor|warning|indeterminate');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `alarm_state` SET TAGS ('dbx_business_glossary_term' = 'Alarm State');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `alarm_state` SET TAGS ('dbx_value_regex' = 'raised|cleared|acknowledged|suppressed');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `alarm_type` SET TAGS ('dbx_business_glossary_term' = 'Alarm Type');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `alarm_type` SET TAGS ('dbx_value_regex' = 'communications|quality_of_service|processing_error|equipment|environmental');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `cleared_by_system` SET TAGS ('dbx_business_glossary_term' = 'Cleared By System');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `correlation_identifier` SET TAGS ('dbx_business_glossary_term' = 'Correlation Identifier');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `customer_impact_count` SET TAGS ('dbx_business_glossary_term' = 'Customer Impact Count');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `first_occurrence_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Occurrence Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `ingestion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingestion Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `last_occurrence_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Occurrence Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `managed_object_class` SET TAGS ('dbx_business_glossary_term' = 'Managed Object Class (MOC)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `managed_object_instance` SET TAGS ('dbx_business_glossary_term' = 'Managed Object Instance (MOI)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `mttr_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Mean Time to Repair (MTTR) Target Minutes');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `network_domain` SET TAGS ('dbx_business_glossary_term' = 'Network Domain');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `network_domain` SET TAGS ('dbx_value_regex' = 'ran|transport|core|access|edge');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `occurrence_count` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Count');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `oss_source_system` SET TAGS ('dbx_business_glossary_term' = 'Operations Support System (OSS) Source System');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `oss_source_system` SET TAGS ('dbx_value_regex' = 'nokia_netact|ericsson_network_manager|other');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `probable_cause` SET TAGS ('dbx_business_glossary_term' = 'Probable Cause');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `proposed_repair_action` SET TAGS ('dbx_business_glossary_term' = 'Proposed Repair Action');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `service_affecting_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Affecting Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `site_identifier` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `specific_problem` SET TAGS ('dbx_business_glossary_term' = 'Specific Problem Code');
ALTER TABLE `telecommunication_ecm`.`assurance`.`alarm_event` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Technology Type');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` SET TAGS ('dbx_subdomain' = 'fault_management');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `trouble_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Trouble Ticket Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `addon_id` SET TAGS ('dbx_business_glossary_term' = 'Addon Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `fiber_cable_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Fiber Cable Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Network Element Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Network Equipment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `olt_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Olt Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `ont_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Ont Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `sim_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Sim Stock Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Team Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `data_breach_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Data Breach Incident Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `device_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registration Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `lawful_intercept_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lawful Intercept Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `mnp_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Mnp Transaction Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `mvno_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Mvno Profile Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `noc_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Noc Incident Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `peering_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Peering Arrangement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `poi_id` SET TAGS ('dbx_business_glossary_term' = 'Poi Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `problem_record_id` SET TAGS ('dbx_business_glossary_term' = 'Problem Record Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `roaming_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Roaming Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `sla_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Profile Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Service Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ticket Acknowledged Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `affected_customer_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Customer Count');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `affected_service_name` SET TAGS ('dbx_business_glossary_term' = 'Affected Service Name');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `affected_subscriber_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Subscriber Count');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `assignee_name` SET TAGS ('dbx_business_glossary_term' = 'Assignee Name');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ticket Closed Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `correlated_alarm_ids` SET TAGS ('dbx_business_glossary_term' = 'Correlated Alarm Identifiers (IDs)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `customer_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Reported Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `escalation_tier` SET TAGS ('dbx_business_glossary_term' = 'Escalation Tier');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `escalation_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|management|vendor');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `impact_scope` SET TAGS ('dbx_business_glossary_term' = 'Impact Scope');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `impact_scope` SET TAGS ('dbx_value_regex' = 'single_customer|multiple_customers|site|region|network_wide');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `mttr_minutes` SET TAGS ('dbx_business_glossary_term' = 'Mean Time to Repair (MTTR) in Minutes');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `opened_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ticket Opened Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `outage_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Outage Duration in Minutes');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Ticket Priority');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `resolution_code` SET TAGS ('dbx_business_glossary_term' = 'Resolution Code');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `resolved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ticket Resolved Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'hardware_failure|software_bug|configuration_error|capacity_overload|external_event|human_error');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Ticket Severity');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'sev1|sev2|sev3|sev4');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `sla_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target in Minutes');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'ServiceNow|Nokia_NetAct|Ericsson_NM|Netcracker_OSS|Manual');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `ticket_category` SET TAGS ('dbx_business_glossary_term' = 'Ticket Category');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `ticket_category` SET TAGS ('dbx_value_regex' = 'network|service|customer|infrastructure|security|performance');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Ticket Number');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `ticket_number` SET TAGS ('dbx_value_regex' = '^TT-[0-9]{8,12}$');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `ticket_type` SET TAGS ('dbx_business_glossary_term' = 'Ticket Type');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `ticket_type` SET TAGS ('dbx_value_regex' = 'incident|problem|change_request|service_request|maintenance');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `trouble_ticket_status` SET TAGS ('dbx_business_glossary_term' = 'Ticket Status');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`trouble_ticket` ALTER COLUMN `vendor_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Ticket Number');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` SET TAGS ('dbx_subdomain' = 'fault_management');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `noc_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Network Operations Center (NOC) Incident ID');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `fiber_cable_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Fiber Cable Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `olt_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Olt Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `alarm_event_id` SET TAGS ('dbx_business_glossary_term' = 'Alarm Event Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Team Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Network Element Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Network Equipment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `sla_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Closed Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `customer_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `declared_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Declared Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `detected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Detected Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'L1|L2|L3|executive');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `estimated_revenue_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue Impact');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `estimated_revenue_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `impacted_customer_count` SET TAGS ('dbx_business_glossary_term' = 'Impacted Customer Count');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `impacted_geography` SET TAGS ('dbx_business_glossary_term' = 'Impacted Geography');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `impacted_network_elements` SET TAGS ('dbx_business_glossary_term' = 'Impacted Network Elements');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `impacted_services_list` SET TAGS ('dbx_business_glossary_term' = 'Impacted Services List');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `incident_category` SET TAGS ('dbx_business_glossary_term' = 'Incident Category');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `incident_category` SET TAGS ('dbx_value_regex' = 'outage|degradation|security_breach|capacity_issue|maintenance_related');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_value_regex' = '^INC-[0-9]{8,12}$');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `incident_priority` SET TAGS ('dbx_business_glossary_term' = 'Incident Priority');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `incident_priority` SET TAGS ('dbx_value_regex' = 'P1|P2|P3|P4');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `incident_source` SET TAGS ('dbx_business_glossary_term' = 'Incident Source');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `incident_source` SET TAGS ('dbx_value_regex' = 'monitoring_system|customer_report|field_technician|proactive_detection|vendor_notification');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'declared|investigating|mitigating|resolved|closed');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'network|security|power|environmental|service|hardware');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `mttr_minutes` SET TAGS ('dbx_business_glossary_term' = 'Mean Time to Repair (MTTR) in Minutes');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `noc_shift` SET TAGS ('dbx_business_glossary_term' = 'Network Operations Center (NOC) Shift');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `noc_shift` SET TAGS ('dbx_value_regex' = 'day|evening|night|weekend');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `post_incident_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Post-Incident Review Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `preventive_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Taken');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `rca_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Document Reference');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `resolved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Resolved Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'hardware_failure|software_defect|configuration_error|capacity_overload|external_event|human_error');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `vendor_involved` SET TAGS ('dbx_business_glossary_term' = 'Vendor Involved');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `vendor_ticket_reference` SET TAGS ('dbx_business_glossary_term' = 'Vendor Ticket Reference');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `war_room_bridge_number` SET TAGS ('dbx_business_glossary_term' = 'War Room Bridge Number');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `war_room_bridge_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`noc_incident` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `performance_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Measurement ID');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `addon_id` SET TAGS ('dbx_business_glossary_term' = 'Addon Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `kpi_threshold_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Threshold Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Object Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Object Network Equipment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `olt_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Object Olt Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `ont_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Object Ont Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `spectrum_license_id` SET TAGS ('dbx_business_glossary_term' = 'Spectrum License Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `aggregation_method` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Method');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `aggregation_method` SET TAGS ('dbx_value_regex' = 'average|sum|min|max|percentile|count');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `availability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Availability Percentage');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Collection Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `deviation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Deviation Percentage');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `measurement_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement End Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `measurement_interval_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Interval Type');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `measurement_interval_type` SET TAGS ('dbx_value_regex' = '15-minute|1-hour|24-hour|real-time');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `measurement_object_reference` SET TAGS ('dbx_business_glossary_term' = 'Measurement Object Identifier');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `measurement_object_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Object Type');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `measurement_object_type` SET TAGS ('dbx_value_regex' = 'cell|link|node|shelf|port|interface');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `measurement_reliability_flag` SET TAGS ('dbx_business_glossary_term' = 'Measurement Reliability Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `measurement_source_system` SET TAGS ('dbx_business_glossary_term' = 'Measurement Source System');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `measurement_source_system` SET TAGS ('dbx_value_regex' = 'Nokia NetAct|Ericsson Network Manager|NMS|EMS|OSS');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `measurement_source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Measurement Source System Identifier');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `measurement_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Status');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_value_regex' = 'valid|suspect|invalid|incomplete');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit of Measure');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `measurement_value` SET TAGS ('dbx_business_glossary_term' = 'Measurement Value');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `network_domain` SET TAGS ('dbx_business_glossary_term' = 'Network Domain');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `network_domain` SET TAGS ('dbx_value_regex' = 'RAN|transport|core|edge|access');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Measurement Notes');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `sample_count` SET TAGS ('dbx_business_glossary_term' = 'Sample Count');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Technology Type');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `threshold_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Threshold Breach Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `threshold_breach_severity` SET TAGS ('dbx_business_glossary_term' = 'Threshold Breach Severity');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `threshold_breach_severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor|warning');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `telecommunication_ecm`.`assurance`.`performance_measurement` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `sla_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Contract Identifier');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `parent_sla_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Service Level Agreement (SLA) Contract Identifier');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `availability_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Availability Target Percentage');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `breach_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Breach Notification Required');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `breach_threshold_count` SET TAGS ('dbx_business_glossary_term' = 'Breach Threshold Count');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated|under_review');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `escalation_procedure` SET TAGS ('dbx_business_glossary_term' = 'Escalation Procedure');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `exclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Criteria');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `jitter_target_ms` SET TAGS ('dbx_business_glossary_term' = 'Jitter Target Milliseconds');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `latency_target_ms` SET TAGS ('dbx_business_glossary_term' = 'Latency Target Milliseconds');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `measurement_source_system` SET TAGS ('dbx_business_glossary_term' = 'Measurement Source System');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `measurement_window` SET TAGS ('dbx_business_glossary_term' = 'Measurement Window');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `measurement_window` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|rolling_30_day|rolling_90_day');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `mttr_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time to Repair (MTTR) Target Hours');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `packet_loss_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Packet Loss Target Percentage');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `penalty_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Penalty Calculation Method');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `penalty_calculation_method` SET TAGS ('dbx_value_regex' = 'fixed_amount|percentage_of_mrr|tiered|prorated|credit');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `penalty_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Cap Amount');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `penalty_cap_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `penalty_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'real_time|daily|weekly|monthly|quarterly|on_demand');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `service_class` SET TAGS ('dbx_business_glossary_term' = 'Service Class');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `sla_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Code');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `sla_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Name');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `sla_type` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Type');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `sla_type` SET TAGS ('dbx_value_regex' = 'customer_facing|internal|wholesale|partner|regulatory');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `throughput_target_mbps` SET TAGS ('dbx_business_glossary_term' = 'Throughput Target Megabits per Second (Mbps)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_contract` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `sla_breach_event_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Event ID');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Network Element ID');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Network Equipment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `olt_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Olt Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `ont_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Ont Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `alarm_event_id` SET TAGS ('dbx_business_glossary_term' = 'Alarm Event Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `kpi_threshold_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Threshold Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `noc_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Noc Incident Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `performance_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Measurement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `settlement_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Invoice Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `sla_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Contract ID');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `sla_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Profile Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance ID');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `actual_measured_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Measured Value');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `affected_customer_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Customer Count');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `affected_service_type` SET TAGS ('dbx_business_glossary_term' = 'Affected Service Type');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `breach_deviation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Breach Deviation Percentage');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `breach_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Breach Duration (Minutes)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `breach_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Breach End Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `breach_event_number` SET TAGS ('dbx_business_glossary_term' = 'Breach Event Number');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `breach_event_number` SET TAGS ('dbx_value_regex' = '^SLA-BRH-[0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `breach_severity` SET TAGS ('dbx_business_glossary_term' = 'Breach Severity');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `breach_severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor|warning');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `breach_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Breach Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `breach_status` SET TAGS ('dbx_business_glossary_term' = 'Breach Status');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `breach_status` SET TAGS ('dbx_value_regex' = 'open|acknowledged|under_review|resolved|closed|disputed');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `breach_type` SET TAGS ('dbx_business_glossary_term' = 'Breach Type');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `breach_type` SET TAGS ('dbx_value_regex' = 'availability|mttr|latency|packet_loss|throughput|jitter');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `contracted_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Contracted Threshold Value');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `customer_impact_level` SET TAGS ('dbx_business_glossary_term' = 'Customer Impact Level');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `customer_impact_level` SET TAGS ('dbx_value_regex' = 'no_impact|low|medium|high|critical');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `customer_notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Channel');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `customer_notification_channel` SET TAGS ('dbx_value_regex' = 'email|sms|portal|phone|automated_ivr');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `customer_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `customer_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `detection_delay_minutes` SET TAGS ('dbx_business_glossary_term' = 'Detection Delay (Minutes)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'automated_monitoring|customer_complaint|proactive_testing|scheduled_audit|third_party_report');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `dispute_raised_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Raised Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `dispute_resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Status');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `dispute_resolution_status` SET TAGS ('dbx_value_regex' = 'not_disputed|under_review|accepted|rejected|partially_accepted');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `penalty_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Applicable Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `preventive_action_recommended` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Recommended');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `regulatory_report_submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Submission Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `regulatory_report_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Submitted Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `resolution_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action Taken');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'nokia_netact|ericsson_nm|servicenow_itsm|custom_assurance_platform');
ALTER TABLE `telecommunication_ecm`.`assurance`.`sla_breach_event` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit of Measure');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` SET TAGS ('dbx_subdomain' = 'fraud_detection');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `addon_id` SET TAGS ('dbx_business_glossary_term' = 'Addon Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Msisdn Range Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `ont_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Ont Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `sim_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Sim Stock Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Subscriber Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Team Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `data_breach_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Data Breach Incident Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `dealer_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `device_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registration Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `fraud_pattern_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Pattern Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `iot_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Iot Deployment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `lawful_intercept_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lawful Intercept Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `mnp_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Mnp Compliance Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `mnp_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Mnp Transaction Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Network Element Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `roaming_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Roaming Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Service Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `tap_file_id` SET TAGS ('dbx_business_glossary_term' = 'Tap File Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `affected_msisdn` SET TAGS ('dbx_business_glossary_term' = 'Affected Mobile Station International Subscriber Directory Number (MSISDN)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `affected_msisdn` SET TAGS ('dbx_value_regex' = '^[0-9]{10,15}$');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `affected_msisdn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `affected_msisdn` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `alert_severity` SET TAGS ('dbx_business_glossary_term' = 'Alert Severity Level');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `alert_severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor|warning|informational');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `alert_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `case_closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Closed Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Number');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^FRD-[0-9]{8,12}$');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `case_opened_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Opened Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `case_priority` SET TAGS ('dbx_business_glossary_term' = 'Case Priority Level');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `case_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Status');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|under-investigation|suspended|closed-confirmed|closed-false-positive|escalated');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `confirmed_fraud_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Fraud Loss Amount');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `confirmed_fraud_loss_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `confirmed_fraud_loss_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `detection_rule_reference` SET TAGS ('dbx_business_glossary_term' = 'Detection Rule Reference Code');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `detection_source` SET TAGS ('dbx_business_glossary_term' = 'Fraud Detection Source');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `detection_source` SET TAGS ('dbx_value_regex' = 'automated-rule|ml-model|customer-report|partner-notification|manual-review|revenue-assurance');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `estimated_fraud_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Fraud Loss Amount');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `estimated_fraud_loss_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `estimated_fraud_loss_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `evidence_references` SET TAGS ('dbx_business_glossary_term' = 'Evidence References');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `evidence_references` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `false_positive_flag` SET TAGS ('dbx_business_glossary_term' = 'False Positive Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `fraud_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Confidence Score');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `fraud_subtype` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subtype');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `fraud_type` SET TAGS ('dbx_business_glossary_term' = 'Fraud Type Classification');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `fraud_type` SET TAGS ('dbx_value_regex' = 'sim-swap|subscription-fraud|bypass-fraud|roaming-fraud|pbx-hacking|wangiri');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `law_enforcement_agency` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Agency Name');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `law_enforcement_case_number` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Case Number');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `law_enforcement_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Referral Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `law_enforcement_referral_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Referral Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `preventive_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Taken');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Fraud Recovery Amount');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `recovery_method` SET TAGS ('dbx_business_glossary_term' = 'Recovery Method');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `recovery_method` SET TAGS ('dbx_value_regex' = 'chargeback|insurance-claim|legal-recovery|write-off|partial-recovery|none');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Case Resolution Notes');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `trigger_type` SET TAGS ('dbx_business_glossary_term' = 'Fraud Trigger Type');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `trigger_type` SET TAGS ('dbx_value_regex' = 'velocity|threshold|pattern|blacklist|ml-signal|anomaly');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_case` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` SET TAGS ('dbx_subdomain' = 'fraud_detection');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `fraud_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `addon_id` SET TAGS ('dbx_business_glossary_term' = 'Addon Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Msisdn Range Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `sim_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Sim Stock Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `device_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registration Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `fraud_pattern_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Pattern Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `kpi_threshold_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Detection Rule Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Network Element Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `nrtrde_record_id` SET TAGS ('dbx_business_glossary_term' = 'Nrtrde Record Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `tap_record_id` SET TAGS ('dbx_business_glossary_term' = 'Tap Record Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alert Acknowledgment Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `action_taken` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Taken');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Observed Value');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `affected_imsi` SET TAGS ('dbx_business_glossary_term' = 'International Mobile Subscriber Identity (IMSI)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `affected_imsi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `affected_imsi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `affected_msisdn` SET TAGS ('dbx_business_glossary_term' = 'Mobile Station International Subscriber Directory Number (MSISDN)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `affected_msisdn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `affected_msisdn` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `alert_generated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alert Generation Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `alert_number` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Number');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `alert_number` SET TAGS ('dbx_value_regex' = '^FA-[0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `alert_priority` SET TAGS ('dbx_business_glossary_term' = 'Alert Priority');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `alert_priority` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `alert_severity` SET TAGS ('dbx_business_glossary_term' = 'Alert Severity Level');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `alert_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `alert_status` SET TAGS ('dbx_business_glossary_term' = 'Alert Status');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `alert_status` SET TAGS ('dbx_value_regex' = 'new|acknowledged|investigating|escalated|closed|false-positive');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `alert_trigger_type` SET TAGS ('dbx_business_glossary_term' = 'Alert Trigger Type');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `alert_trigger_type` SET TAGS ('dbx_value_regex' = 'velocity|threshold|pattern|blacklist|anomaly|geo-location');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `analyst_notes` SET TAGS ('dbx_business_glossary_term' = 'Fraud Analyst Notes');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alert Closure Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Confidence Score');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alert Detection Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `detection_window_end` SET TAGS ('dbx_business_glossary_term' = 'Detection Window End Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `detection_window_start` SET TAGS ('dbx_business_glossary_term' = 'Detection Window Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `escalated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alert Escalation Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `estimated_revenue_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue Impact Amount');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `estimated_revenue_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `false_positive_flag` SET TAGS ('dbx_business_glossary_term' = 'False Positive Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `fraud_category` SET TAGS ('dbx_business_glossary_term' = 'Fraud Category');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `fraud_category` SET TAGS ('dbx_value_regex' = 'revenue-assurance|network-abuse|identity-fraud|device-fraud|roaming-fraud|content-fraud');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `fraud_type` SET TAGS ('dbx_business_glossary_term' = 'Fraud Type Classification');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `network_element_type` SET TAGS ('dbx_business_glossary_term' = 'Network Element Type');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `source_system_alert_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Alert Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit of Measure');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_alert` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` SET TAGS ('dbx_subdomain' = 'fault_management');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `problem_record_id` SET TAGS ('dbx_business_glossary_term' = 'Problem Record Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `fiber_cable_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Fiber Cable Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Network Equipment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `olt_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Olt Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `ont_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Ont Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Team Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Network Element Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Problem Acknowledged Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `affected_customer_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Customer Count');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `affected_network_domain` SET TAGS ('dbx_business_glossary_term' = 'Affected Network Domain');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `affected_service_type` SET TAGS ('dbx_business_glossary_term' = 'Affected Service Type');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `affected_technology_type` SET TAGS ('dbx_business_glossary_term' = 'Affected Technology Type');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `assigned_problem_manager` SET TAGS ('dbx_business_glossary_term' = 'Assigned Problem Manager');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Problem Closed Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `estimated_revenue_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue Impact');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `estimated_revenue_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `identified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Problem Identified Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `impact` SET TAGS ('dbx_business_glossary_term' = 'Problem Impact');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `impact` SET TAGS ('dbx_value_regex' = 'widespread|significant|moderate|minor');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `investigation_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Investigation Duration Hours');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `kedb_article_reference` SET TAGS ('dbx_business_glossary_term' = 'Known Error Database (KEDB) Article Reference');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `known_error_flag` SET TAGS ('dbx_business_glossary_term' = 'Known Error Database (KEDB) Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Problem Notes');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `permanent_fix_description` SET TAGS ('dbx_business_glossary_term' = 'Permanent Fix Description');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `post_incident_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Post Incident Review (PIR) Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `preventive_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Taken');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Problem Priority');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `problem_category` SET TAGS ('dbx_business_glossary_term' = 'Problem Category');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `problem_category` SET TAGS ('dbx_value_regex' = 'hardware|software|network|application|database|security');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `problem_description` SET TAGS ('dbx_business_glossary_term' = 'Problem Description');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `problem_number` SET TAGS ('dbx_business_glossary_term' = 'Problem Number');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `problem_number` SET TAGS ('dbx_value_regex' = '^PRB[0-9]{7}$');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `problem_status` SET TAGS ('dbx_business_glossary_term' = 'Problem Status');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `problem_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Problem Subcategory');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `problem_title` SET TAGS ('dbx_business_glossary_term' = 'Problem Title');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `rca_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Document Reference');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `resolution_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Resolution Duration Hours');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `resolved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Problem Resolved Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `root_cause_identified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Identified Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `site_ids` SET TAGS ('dbx_business_glossary_term' = 'Site Identifiers (IDs)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `urgency` SET TAGS ('dbx_business_glossary_term' = 'Problem Urgency');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `urgency` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `vendor_involved` SET TAGS ('dbx_business_glossary_term' = 'Vendor Involved');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `vendor_ticket_reference` SET TAGS ('dbx_business_glossary_term' = 'Vendor Ticket Reference');
ALTER TABLE `telecommunication_ecm`.`assurance`.`problem_record` ALTER COLUMN `workaround_description` SET TAGS ('dbx_business_glossary_term' = 'Workaround Description');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` SET TAGS ('dbx_subdomain' = 'fault_management');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `outage_record_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Record Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Address Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `fiber_cable_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Fiber Cable Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Network Element Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Network Equipment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `olt_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Olt Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `alarm_event_id` SET TAGS ('dbx_business_glossary_term' = 'Alarm Event Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `mvno_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Mvno Profile Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `noc_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Related Network Operations Center (NOC) Incident Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `peering_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Peering Arrangement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `poi_id` SET TAGS ('dbx_business_glossary_term' = 'Poi Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `problem_record_id` SET TAGS ('dbx_business_glossary_term' = 'Problem Record Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `sla_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `trouble_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Trouble Ticket Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `affected_cell_site_ids` SET TAGS ('dbx_business_glossary_term' = 'Affected Cell Site Identifiers (IDs)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `affected_geography` SET TAGS ('dbx_business_glossary_term' = 'Affected Geography');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `affected_region` SET TAGS ('dbx_business_glossary_term' = 'Affected Region');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `affected_service_type` SET TAGS ('dbx_business_glossary_term' = 'Affected Service Type');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `compliance_officer_sign_off_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Sign-Off Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `customer_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `customer_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'alarm|monitoring|customer-report|proactive');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `estimated_revenue_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue Impact');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `estimated_revenue_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `impacted_business_customer_count` SET TAGS ('dbx_business_glossary_term' = 'Impacted Business Customer Count');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `impacted_subscriber_count` SET TAGS ('dbx_business_glossary_term' = 'Impacted Subscriber Count');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `mttr_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Mean Time to Repair (MTTR) Target (Minutes)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Outage Notes');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `notification_due_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Due Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `notification_submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Submission Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `outage_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Outage Cause Category');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `outage_cause_category` SET TAGS ('dbx_value_regex' = 'hardware|software|power|fiber-cut|weather|human-error');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `outage_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Outage Cause Description');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `outage_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Outage Duration (Minutes)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `outage_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Outage End Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `outage_number` SET TAGS ('dbx_business_glossary_term' = 'Outage Number');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `outage_number` SET TAGS ('dbx_value_regex' = '^OUT-[0-9]{8,12}$');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `outage_severity` SET TAGS ('dbx_business_glossary_term' = 'Outage Severity');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `outage_severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `outage_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Outage Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `outage_status` SET TAGS ('dbx_business_glossary_term' = 'Outage Status');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `outage_status` SET TAGS ('dbx_value_regex' = 'detected|investigating|restoring|restored|closed');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `outage_type` SET TAGS ('dbx_business_glossary_term' = 'Outage Type');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `outage_type` SET TAGS ('dbx_value_regex' = 'planned|unplanned');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `post_outage_review_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Post-Outage Review Completed Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `post_outage_review_reference` SET TAGS ('dbx_business_glossary_term' = 'Post-Outage Review Reference');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'FCC|Ofcom|BEREC|NTIA|CRTC|ACMA');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `regulatory_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Status');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `regulatory_notification_status` SET TAGS ('dbx_value_regex' = 'not-required|draft|submitted|acknowledged|closed');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `reportable_threshold_met` SET TAGS ('dbx_business_glossary_term' = 'Reportable Threshold Met');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `restoration_method` SET TAGS ('dbx_business_glossary_term' = 'Restoration Method');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `restoration_method` SET TAGS ('dbx_value_regex' = 'automatic|manual|failover|bypass|replacement|repair');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `restoration_priority` SET TAGS ('dbx_business_glossary_term' = 'Restoration Priority');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `restoration_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `restoration_team` SET TAGS ('dbx_business_glossary_term' = 'Restoration Team');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `sla_breach_count` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Count');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `vendor_involved_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Involved Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `telecommunication_ecm`.`assurance`.`outage_record` ALTER COLUMN `vendor_ticket_reference` SET TAGS ('dbx_business_glossary_term' = 'Vendor Ticket Reference');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `kpi_threshold_id` SET TAGS ('dbx_business_glossary_term' = 'Assurance Key Performance Indicator (KPI) Threshold Identifier');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `parent_rule_kpi_threshold_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Rule Identifier');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `applicable_service_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Service Type');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `auto_ticket_creation_flag` SET TAGS ('dbx_business_glossary_term' = 'Automatic Ticket Creation Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `correlated_alarm_types` SET TAGS ('dbx_business_glossary_term' = 'Correlated Alarm Types List');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `correlation_window_minutes` SET TAGS ('dbx_business_glossary_term' = 'Correlation Window Duration in Minutes');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `detection_logic_description` SET TAGS ('dbx_business_glossary_term' = 'Detection Logic Description');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `false_positive_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'False Positive Rate Percentage');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `fraud_type` SET TAGS ('dbx_business_glossary_term' = 'Fraud Type Targeted');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `last_tuned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Tuned Timestamp');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `measurement_window_minutes` SET TAGS ('dbx_business_glossary_term' = 'Measurement Window Duration in Minutes');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `network_domain` SET TAGS ('dbx_business_glossary_term' = 'Network Domain');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Required Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Team');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `root_cause_determination_logic` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Determination Logic');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `rule_category` SET TAGS ('dbx_business_glossary_term' = 'Rule Category');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `rule_category` SET TAGS ('dbx_value_regex' = 'kpi_threshold|alarm_correlation|alarm_suppression|fraud_detection|deduplication|revenue_leakage');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `rule_identifier` SET TAGS ('dbx_business_glossary_term' = 'Rule Identifier Code');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `rule_identifier` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{6,50}$');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Name');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `rule_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Status');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|testing|deprecated');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|major|minor|warning|info');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `sla_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Impact Flag');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `suppression_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Suppression Duration in Minutes');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Technology Type');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `threshold_direction` SET TAGS ('dbx_business_glossary_term' = 'Threshold Direction');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `threshold_direction` SET TAGS ('dbx_value_regex' = 'above|below|equal|not_equal');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit of Measure');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `trigger_alarm_type` SET TAGS ('dbx_business_glossary_term' = 'Trigger Alarm Type');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+$');
ALTER TABLE `telecommunication_ecm`.`assurance`.`kpi_threshold` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_pattern` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_pattern` SET TAGS ('dbx_subdomain' = 'fraud_detection');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_pattern` ALTER COLUMN `fraud_pattern_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Pattern Identifier');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_pattern` ALTER COLUMN `evolved_from_fraud_pattern_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_pattern` ALTER COLUMN `iot_tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Iot Tariff Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_pattern` ALTER COLUMN `kpi_threshold_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Threshold Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`assurance`.`fraud_pattern` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
