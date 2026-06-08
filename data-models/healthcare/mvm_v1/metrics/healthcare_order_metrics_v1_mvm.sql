-- Metric views for domain: order | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 18:58:55

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`order_clinical_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over clinical orders. Tracks order volume, CPOE adoption, verbal order risk, recurring order patterns, and quantity throughput to support clinical operations, patient safety, and provider performance steering."
  source: "`healthcare_ecm`.`order`.`clinical_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Clinical order type (e.g., Lab, Medication, Radiology, Referral) — primary axis for order mix analysis."
    - name: "order_class"
      expr: order_class
      comment: "Order class (e.g., Normal, Stat, Standing) — used to segment urgency and workflow routing."
    - name: "order_priority"
      expr: order_priority
      comment: "Priority assigned to the order (e.g., Routine, Urgent, STAT) — key dimension for throughput and SLA analysis."
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the order (e.g., Active, Completed, Cancelled) — used to filter and segment order pipeline."
    - name: "order_mode"
      expr: order_mode
      comment: "Mode through which the order was placed (e.g., Inpatient, Outpatient, Telehealth) — supports care-setting analysis."
    - name: "is_cpoe_entered"
      expr: is_cpoe_entered
      comment: "Indicates whether the order was entered via Computerized Physician Order Entry — key patient safety and compliance dimension."
    - name: "is_verbal_order"
      expr: is_verbal_order
      comment: "Flags orders placed verbally — used to monitor verbal order rates for regulatory and safety compliance."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Indicates whether the order is a recurring/standing order — used to distinguish episodic from chronic care ordering patterns."
    - name: "is_order_set_member"
      expr: is_order_set_member
      comment: "Flags orders that originated from a standardized order set — used to measure order set adoption and protocol adherence."
    - name: "order_date_month"
      expr: DATE_TRUNC('MONTH', order_datetime)
      comment: "Month of order placement — primary time grain for trend analysis of order volumes and patterns."
    - name: "order_date_day"
      expr: CAST(order_datetime AS DATE)
      comment: "Calendar date of order placement — used for daily operational monitoring."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason provided when an order was cancelled — used to identify systemic ordering errors or workflow gaps."
    - name: "frequency_code"
      expr: frequency_code
      comment: "Dosing or service frequency code (e.g., QD, BID, PRN) — used to analyze ordering patterns for medications and recurring services."
    - name: "source_system"
      expr: source_system
      comment: "Source EHR or operational system that generated the order — used for data lineage and system-level performance comparison."
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of clinical orders placed. Baseline volume KPI used to track ordering throughput and capacity demand."
    - name: "distinct_patients_ordered"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Count of unique patients with at least one clinical order. Measures breadth of care delivery and patient reach."
    - name: "distinct_ordering_providers"
      expr: COUNT(DISTINCT ordering_provider_npi_registry_id)
      comment: "Count of unique ordering providers. Used to assess provider ordering activity and workload distribution."
    - name: "cpoe_order_count"
      expr: COUNT(CASE WHEN is_cpoe_entered = TRUE THEN 1 END)
      comment: "Number of orders entered via CPOE. Numerator for CPOE adoption rate — a core patient safety and regulatory KPI."
    - name: "verbal_order_count"
      expr: COUNT(CASE WHEN is_verbal_order = TRUE THEN 1 END)
      comment: "Number of verbal orders placed. High verbal order rates signal patient safety risk and compliance exposure."
    - name: "cancelled_order_count"
      expr: COUNT(CASE WHEN order_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled orders. Used to compute cancellation rate and identify workflow inefficiencies or ordering errors."
    - name: "order_set_member_count"
      expr: COUNT(CASE WHEN is_order_set_member = TRUE THEN 1 END)
      comment: "Number of orders that originated from a standardized order set. Numerator for order set adoption rate — a clinical standardization KPI."
    - name: "recurring_order_count"
      expr: COUNT(CASE WHEN is_recurring = TRUE THEN 1 END)
      comment: "Number of recurring/standing orders. Used to assess chronic care management volume and protocol-driven ordering."
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity of items/services ordered across all clinical orders. Drives supply chain demand forecasting and resource planning."
    - name: "avg_quantity_per_order"
      expr: AVG(CAST(quantity_ordered AS DOUBLE))
      comment: "Average quantity ordered per clinical order. Identifies outlier ordering behavior and supports dosing/supply normalization."
    - name: "stat_order_count"
      expr: COUNT(CASE WHEN order_priority = 'STAT' THEN 1 END)
      comment: "Number of STAT-priority orders. High STAT volumes indicate acute care demand spikes and may signal capacity or triage issues."
    - name: "cosign_pending_order_count"
      expr: COUNT(CASE WHEN cosign_due_datetime IS NOT NULL AND cosign_completed_datetime IS NULL THEN 1 END)
      comment: "Number of orders awaiting co-signature. Unresolved co-sign obligations represent compliance and patient safety risk."
    - name: "distinct_visits_with_orders"
      expr: COUNT(DISTINCT visit_id)
      comment: "Number of distinct patient visits that generated at least one clinical order. Measures ordering intensity across the care episode."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`order_fulfillment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over order fulfillments. Tracks charge capture, fulfillment quality, partial fulfillment rates, quantity throughput, and exception patterns to support revenue integrity, operational efficiency, and care delivery quality."
  source: "`healthcare_ecm`.`order`.`fulfillment`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of order being fulfilled (e.g., Lab, Medication, Radiology) — primary axis for fulfillment mix analysis."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Current status of the fulfillment event (e.g., Completed, Pending, Failed) — used to monitor fulfillment pipeline health."
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Method used to fulfill the order (e.g., In-house, External, Telehealth) — used to analyze delivery channel efficiency."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority assigned to the fulfillment (e.g., Routine, STAT) — used to segment SLA compliance and throughput by urgency."
    - name: "partial_fulfillment_flag"
      expr: partial_fulfillment_flag
      comment: "Indicates whether the fulfillment was only partially completed — key dimension for supply and capacity gap analysis."
    - name: "charge_capture_flag"
      expr: charge_capture_flag
      comment: "Indicates whether a charge was captured for this fulfillment — critical for revenue integrity monitoring."
    - name: "quality_flag"
      expr: quality_flag
      comment: "Flags fulfillments that triggered a quality review — used to track quality exception rates."
    - name: "exception_reason_code"
      expr: exception_reason_code
      comment: "Coded reason for a fulfillment exception — used to categorize and trend operational failure modes."
    - name: "revenue_code"
      expr: revenue_code
      comment: "Revenue code associated with the fulfillment — used for billing and revenue cycle analysis."
    - name: "fulfillment_date_month"
      expr: DATE_TRUNC('MONTH', datetime)
      comment: "Month of fulfillment event — primary time grain for trend analysis of fulfillment volumes and revenue."
    - name: "fulfillment_date_day"
      expr: CAST(datetime AS DATE)
      comment: "Calendar date of fulfillment — used for daily operational monitoring and SLA tracking."
    - name: "result_availability_month"
      expr: DATE_TRUNC('MONTH', result_availability_datetime)
      comment: "Month when results became available — used to trend result turnaround performance over time."
  measures:
    - name: "total_fulfillments"
      expr: COUNT(1)
      comment: "Total number of fulfillment events. Baseline throughput KPI for operational capacity and demand planning."
    - name: "distinct_orders_fulfilled"
      expr: COUNT(DISTINCT clinical_order_id)
      comment: "Number of distinct clinical orders that received at least one fulfillment event. Measures order completion breadth."
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total charges generated from fulfillment events. Primary revenue integrity KPI — tracks gross charge capture across all order types."
    - name: "avg_charge_per_fulfillment"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge amount per fulfillment event. Used to benchmark pricing consistency and identify outlier charge patterns."
    - name: "total_fulfilled_quantity"
      expr: SUM(CAST(fulfilled_quantity AS DOUBLE))
      comment: "Total quantity of items/services actually fulfilled. Compared against ordered quantity to measure fulfillment completeness."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity of items/services that were ordered. Denominator for fulfillment rate calculations and supply demand analysis."
    - name: "avg_fulfilled_quantity"
      expr: AVG(CAST(fulfilled_quantity AS DOUBLE))
      comment: "Average quantity fulfilled per fulfillment event. Used to detect systematic under-fulfillment patterns."
    - name: "partial_fulfillment_count"
      expr: COUNT(CASE WHEN partial_fulfillment_flag = TRUE THEN 1 END)
      comment: "Number of fulfillments that were only partially completed. High partial rates indicate supply shortages or workflow breakdowns."
    - name: "charge_captured_count"
      expr: COUNT(CASE WHEN charge_capture_flag = TRUE THEN 1 END)
      comment: "Number of fulfillments where a charge was successfully captured. Numerator for charge capture rate — a core revenue integrity KPI."
    - name: "quality_exception_count"
      expr: COUNT(CASE WHEN quality_flag = TRUE THEN 1 END)
      comment: "Number of fulfillments flagged for quality review. Elevated quality exception rates signal care delivery or process quality issues."
    - name: "exception_fulfillment_count"
      expr: COUNT(CASE WHEN exception_reason_code IS NOT NULL THEN 1 END)
      comment: "Number of fulfillments with a recorded exception reason. Used to quantify operational failure volume and drive root-cause analysis."
    - name: "distinct_patients_fulfilled"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Number of distinct patients who received a fulfillment. Measures patient reach and care delivery breadth."
    - name: "distinct_visits_with_fulfillments"
      expr: COUNT(DISTINCT visit_id)
      comment: "Number of distinct patient visits with at least one fulfillment. Used to assess fulfillment density per care episode."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`order_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over order status change events. Tracks order lifecycle transitions, verbal order authentication compliance, controlled substance ordering patterns, CDS alert override rates, and co-signature compliance — all critical for patient safety, regulatory compliance, and audit readiness."
  source: "`healthcare_ecm`.`order`.`order_status_history`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of order associated with the status event — used to segment compliance and safety metrics by order category."
    - name: "event_type"
      expr: event_type
      comment: "Type of status change event (e.g., Created, Modified, Cancelled, Completed) — primary axis for lifecycle transition analysis."
    - name: "new_status"
      expr: new_status
      comment: "The order status after the change event — used to track status distribution and pipeline health."
    - name: "previous_status"
      expr: previous_status
      comment: "The order status before the change event — used to analyze transition patterns and identify problematic status flows."
    - name: "order_priority"
      expr: order_priority
      comment: "Priority of the order at the time of the status event — used to segment compliance metrics by urgency level."
    - name: "is_controlled_substance"
      expr: is_controlled_substance
      comment: "Flags status events for controlled substance orders — critical dimension for DEA compliance and diversion monitoring."
    - name: "is_verbal_order"
      expr: is_verbal_order
      comment: "Flags status events for verbal orders — used to monitor verbal order authentication compliance."
    - name: "cds_alert_overridden"
      expr: cds_alert_overridden
      comment: "Indicates whether a Clinical Decision Support alert was overridden at this event — key patient safety monitoring dimension."
    - name: "cosignature_required"
      expr: cosignature_required
      comment: "Flags events where co-signature was required — used to track co-signature compliance rates."
    - name: "is_amendment"
      expr: is_amendment
      comment: "Indicates whether the status event represents an amendment to a prior order — used for audit trail completeness analysis."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA schedule classification for controlled substance orders — used to segment controlled substance compliance by risk tier."
    - name: "modifying_user_role"
      expr: modifying_user_role
      comment: "Role of the user who made the status change — used to analyze ordering authority patterns and unauthorized modification risk."
    - name: "hipaa_audit_category"
      expr: hipaa_audit_category
      comment: "HIPAA audit category associated with the event — used for regulatory audit reporting and compliance monitoring."
    - name: "discontinuation_type"
      expr: discontinuation_type
      comment: "Type of order discontinuation (e.g., Completed, Cancelled, Superseded) — used to analyze order lifecycle termination patterns."
    - name: "event_date_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of the status change event — primary time grain for compliance trend analysis."
    - name: "transmission_status"
      expr: transmission_status
      comment: "Status of order transmission to downstream systems (e.g., Sent, Failed, Pending) — used to monitor order routing reliability."
  measures:
    - name: "total_status_events"
      expr: COUNT(1)
      comment: "Total number of order status change events. Baseline volume KPI for order lifecycle activity and audit trail completeness."
    - name: "distinct_orders_with_changes"
      expr: COUNT(DISTINCT clinical_order_id)
      comment: "Number of distinct orders that experienced at least one status change. Measures order lifecycle activity breadth."
    - name: "cds_alert_override_count"
      expr: COUNT(CASE WHEN cds_alert_overridden = TRUE THEN 1 END)
      comment: "Number of events where a CDS alert was overridden. High override rates are a leading indicator of patient safety risk and require clinical governance review."
    - name: "verbal_order_event_count"
      expr: COUNT(CASE WHEN is_verbal_order = TRUE THEN 1 END)
      comment: "Number of status events associated with verbal orders. Used to monitor verbal order volume for regulatory compliance."
    - name: "verbal_order_authenticated_count"
      expr: COUNT(CASE WHEN is_verbal_order = TRUE AND verbal_order_authentication_datetime IS NOT NULL THEN 1 END)
      comment: "Number of verbal order events that were subsequently authenticated. Numerator for verbal order authentication compliance rate — a Joint Commission requirement."
    - name: "controlled_substance_event_count"
      expr: COUNT(CASE WHEN is_controlled_substance = TRUE THEN 1 END)
      comment: "Number of status events for controlled substance orders. Used for DEA compliance monitoring and diversion risk assessment."
    - name: "cosignature_required_count"
      expr: COUNT(CASE WHEN cosignature_required = TRUE THEN 1 END)
      comment: "Number of events requiring co-signature. Denominator for co-signature compliance rate — a patient safety and regulatory KPI."
    - name: "cosignature_completed_count"
      expr: COUNT(CASE WHEN cosignature_required = TRUE AND cosignature_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of events where required co-signature was completed. Numerator for co-signature compliance rate."
    - name: "amendment_event_count"
      expr: COUNT(CASE WHEN is_amendment = TRUE THEN 1 END)
      comment: "Number of order amendment events. High amendment rates may indicate documentation quality issues or workflow inefficiencies."
    - name: "transmission_failure_count"
      expr: COUNT(CASE WHEN transmission_status = 'Failed' THEN 1 END)
      comment: "Number of order transmission failures. Transmission failures represent care continuity risk and revenue cycle disruption."
    - name: "distinct_modifying_providers"
      expr: COUNT(DISTINCT modifying_provider_npi_registry_id)
      comment: "Number of distinct providers who modified orders. Used to assess modification authority distribution and identify unauthorized change patterns."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`order_referral_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over referral orders. Tracks referral volume, loop closure rates, authorization compliance, urgency distribution, and referral disposition outcomes — critical for care coordination quality, network management, and value-based care performance."
  source: "`healthcare_ecm`.`order`.`referral_order`"
  dimensions:
    - name: "referral_type"
      expr: referral_type
      comment: "Type of referral (e.g., Specialist, Primary Care, Behavioral Health) — primary axis for referral mix and network analysis."
    - name: "order_status"
      expr: order_status
      comment: "Current status of the referral order (e.g., Pending, Completed, Cancelled) — used to monitor referral pipeline health."
    - name: "referral_disposition"
      expr: referral_disposition
      comment: "Outcome disposition of the referral (e.g., Accepted, Declined, Redirected) — key dimension for network adequacy and care coordination analysis."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency classification of the referral (e.g., Routine, Urgent, STAT) — used to segment SLA compliance and access-to-care metrics."
    - name: "referral_source"
      expr: referral_source
      comment: "Source of the referral (e.g., PCP, ED, Specialist) — used to analyze referral origination patterns and care pathway efficiency."
    - name: "authorization_required"
      expr: authorization_required
      comment: "Indicates whether prior authorization was required for the referral — used to monitor authorization compliance and denial risk."
    - name: "referral_loop_closed"
      expr: referral_loop_closed
      comment: "Indicates whether the referral loop was closed (i.e., results returned to referring provider) — core care coordination quality KPI dimension."
    - name: "is_stat_order"
      expr: is_stat_order
      comment: "Flags STAT referral orders — used to monitor urgent referral volumes and response time compliance."
    - name: "plan_type"
      expr: plan_type
      comment: "Insurance plan type associated with the referral — used to analyze referral patterns and authorization rates by payer."
    - name: "order_placed_month"
      expr: DATE_TRUNC('MONTH', order_placed_timestamp)
      comment: "Month the referral order was placed — primary time grain for referral volume and loop closure trend analysis."
    - name: "disposition_month"
      expr: DATE_TRUNC('MONTH', CAST(disposition_date AS TIMESTAMP))
      comment: "Month of referral disposition — used to trend referral resolution timelines and network performance."
    - name: "referral_reason_description"
      expr: referral_reason_description
      comment: "Clinical reason for the referral — used to analyze referral demand by clinical indication and support population health management."
  measures:
    - name: "total_referrals"
      expr: COUNT(1)
      comment: "Total number of referral orders placed. Baseline volume KPI for care coordination demand and network utilization."
    - name: "distinct_patients_referred"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of distinct patients with at least one referral order. Measures breadth of care coordination activity across the patient population."
    - name: "referral_loop_closed_count"
      expr: COUNT(CASE WHEN referral_loop_closed = TRUE THEN 1 END)
      comment: "Number of referrals where the care loop was closed. Numerator for referral loop closure rate — a core care coordination and value-based care KPI."
    - name: "authorization_required_count"
      expr: COUNT(CASE WHEN authorization_required = TRUE THEN 1 END)
      comment: "Number of referrals requiring prior authorization. Used to quantify authorization burden and denial risk exposure."
    - name: "stat_referral_count"
      expr: COUNT(CASE WHEN is_stat_order = TRUE THEN 1 END)
      comment: "Number of STAT referral orders. High STAT referral volumes indicate acute care demand and may signal access-to-care gaps."
    - name: "cancelled_referral_count"
      expr: COUNT(CASE WHEN order_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled referral orders. Used to compute cancellation rate and identify care coordination breakdowns."
    - name: "scheduled_referral_count"
      expr: COUNT(CASE WHEN scheduled_appointment_date IS NOT NULL THEN 1 END)
      comment: "Number of referrals that resulted in a scheduled appointment. Measures referral-to-appointment conversion — a key access-to-care metric."
    - name: "distinct_receiving_providers"
      expr: COUNT(DISTINCT receiving_provider_clinician_id)
      comment: "Number of distinct receiving providers across all referrals. Used to assess referral network breadth and concentration risk."
    - name: "distinct_referring_providers"
      expr: COUNT(DISTINCT referring_provider_npi_registry_id)
      comment: "Number of distinct referring providers. Used to analyze referral origination distribution and identify high-volume referrers."
    - name: "distinct_visits_with_referrals"
      expr: COUNT(DISTINCT visit_id)
      comment: "Number of distinct patient visits that generated a referral. Used to measure referral intensity per care episode."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`order_routing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over order routing events. Tracks routing throughput, SLA compliance, reroute rates, priority override patterns, and workload distribution — critical for operational efficiency, order fulfillment speed, and care delivery reliability."
  source: "`healthcare_ecm`.`order`.`routing`"
  dimensions:
    - name: "routing_status"
      expr: routing_status
      comment: "Current status of the routing event (e.g., Pending, Acknowledged, Completed, Failed) — primary axis for routing pipeline health monitoring."
    - name: "routing_method"
      expr: routing_method
      comment: "Method used to route the order (e.g., Auto, Manual, Override) — used to analyze automation adoption and manual intervention rates."
    - name: "priority"
      expr: priority
      comment: "Priority assigned to the routing event — used to segment SLA compliance and throughput by urgency tier."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Indicates whether the routing event met its SLA target — primary dimension for service level performance analysis."
    - name: "auto_route_eligible_flag"
      expr: auto_route_eligible_flag
      comment: "Flags orders eligible for automated routing — used to measure automation opportunity and adoption gaps."
    - name: "priority_override_flag"
      expr: priority_override_flag
      comment: "Indicates whether the routing priority was manually overridden — used to monitor override rates and workflow discipline."
    - name: "transport_required_flag"
      expr: transport_required_flag
      comment: "Flags routing events requiring physical transport — used to analyze transport demand and logistics capacity."
    - name: "specimen_collection_required_flag"
      expr: specimen_collection_required_flag
      comment: "Flags routing events requiring specimen collection — used to coordinate pre-analytical workflow and lab capacity."
    - name: "queue_name"
      expr: queue_name
      comment: "Name of the work queue to which the order was routed — used to analyze queue-level workload distribution and bottlenecks."
    - name: "routing_date_month"
      expr: DATE_TRUNC('MONTH', datetime)
      comment: "Month of the routing event — primary time grain for routing volume and SLA compliance trend analysis."
    - name: "routing_date_day"
      expr: CAST(datetime AS DATE)
      comment: "Calendar date of the routing event — used for daily operational monitoring of routing throughput."
    - name: "system_source"
      expr: system_source
      comment: "Source system that generated the routing event — used for system-level performance comparison and data lineage."
  measures:
    - name: "total_routing_events"
      expr: COUNT(1)
      comment: "Total number of order routing events. Baseline throughput KPI for operational routing capacity and demand."
    - name: "distinct_orders_routed"
      expr: COUNT(DISTINCT clinical_order_id)
      comment: "Number of distinct clinical orders that were routed. Measures routing coverage across the order pipeline."
    - name: "sla_compliant_count"
      expr: COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END)
      comment: "Number of routing events that met their SLA target. Numerator for SLA compliance rate — a core operational performance KPI."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_compliance_flag = FALSE THEN 1 END)
      comment: "Number of routing events that breached their SLA target. Elevated breach counts signal capacity constraints or workflow failures requiring intervention."
    - name: "priority_override_count"
      expr: COUNT(CASE WHEN priority_override_flag = TRUE THEN 1 END)
      comment: "Number of routing events where priority was manually overridden. High override rates indicate workflow discipline issues or systemic priority misconfiguration."
    - name: "auto_route_eligible_count"
      expr: COUNT(CASE WHEN auto_route_eligible_flag = TRUE THEN 1 END)
      comment: "Number of routing events eligible for automated routing. Denominator for automation adoption rate — used to identify automation opportunity gaps."
    - name: "transport_required_count"
      expr: COUNT(CASE WHEN transport_required_flag = TRUE THEN 1 END)
      comment: "Number of routing events requiring physical transport. Used to forecast transport demand and optimize logistics staffing."
    - name: "total_workload_score"
      expr: SUM(CAST(workload_score AS DOUBLE))
      comment: "Total workload score across all routing events. Used to measure aggregate operational burden and support staffing and capacity planning decisions."
    - name: "avg_workload_score"
      expr: AVG(CAST(workload_score AS DOUBLE))
      comment: "Average workload score per routing event. Used to benchmark routing complexity and identify queues or periods with disproportionate workload."
    - name: "completed_routing_count"
      expr: COUNT(CASE WHEN completion_datetime IS NOT NULL THEN 1 END)
      comment: "Number of routing events that reached completion. Used to compute routing completion rate and identify stuck or abandoned routing events."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`order_set`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over clinical order sets. Tracks order set adoption, compliance rates, evidence-based guideline coverage, CMS core measure alignment, and governance health — critical for clinical standardization, quality improvement, and regulatory compliance."
  source: "`healthcare_ecm`.`order`.`set`"
  dimensions:
    - name: "order_set_type"
      expr: order_set_type
      comment: "Type of order set (e.g., Admission, Procedure, Disease-Specific) — primary axis for order set portfolio analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Governance approval status of the order set (e.g., Approved, Pending, Retired) — used to monitor order set governance health."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the order set is currently active — used to filter active vs. retired order sets in compliance analysis."
    - name: "is_cms_core_measure"
      expr: is_cms_core_measure
      comment: "Flags order sets aligned to CMS core quality measures — critical dimension for regulatory compliance and value-based care reporting."
    - name: "evidence_level"
      expr: evidence_level
      comment: "Evidence level of the clinical guideline underlying the order set (e.g., Level A, B, C) — used to assess clinical rigor of the order set portfolio."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting for which the order set is designed (e.g., Inpatient, Outpatient, ED) — used to segment order set coverage by care environment."
    - name: "governance_level"
      expr: governance_level
      comment: "Governance tier of the order set (e.g., Enterprise, Department, Unit) — used to analyze standardization depth across the organization."
    - name: "population_age_group"
      expr: population_age_group
      comment: "Target patient age group for the order set — used to assess order set coverage across pediatric, adult, and geriatric populations."
    - name: "includes_pharmacy_orders"
      expr: includes_pharmacy_orders
      comment: "Flags order sets that include pharmacy orders — used to analyze medication management standardization."
    - name: "includes_lab_orders"
      expr: includes_lab_orders
      comment: "Flags order sets that include lab orders — used to analyze diagnostic standardization."
    - name: "includes_radiology_orders"
      expr: includes_radiology_orders
      comment: "Flags order sets that include radiology orders — used to analyze imaging utilization standardization."
    - name: "renal_adjustment_required"
      expr: renal_adjustment_required
      comment: "Flags order sets requiring renal dose adjustment — used to monitor medication safety protocol coverage for renal-impaired populations."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', CAST(effective_date AS TIMESTAMP))
      comment: "Month the order set became effective — used to trend order set portfolio growth and refresh cadence."
    - name: "owning_department"
      expr: owning_department
      comment: "Department responsible for the order set — used to analyze order set ownership distribution and governance accountability."
  measures:
    - name: "total_order_sets"
      expr: COUNT(1)
      comment: "Total number of order sets in the catalog. Baseline KPI for order set portfolio size and clinical standardization coverage."
    - name: "active_order_set_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active order sets. Used to assess the size of the live clinical standardization portfolio."
    - name: "cms_core_measure_set_count"
      expr: COUNT(CASE WHEN is_cms_core_measure = TRUE THEN 1 END)
      comment: "Number of order sets aligned to CMS core quality measures. Directly tied to regulatory compliance and value-based reimbursement performance."
    - name: "approved_order_set_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of order sets with formal governance approval. Used to monitor governance compliance and identify unapproved order sets in use."
    - name: "total_compliance_rate_pct"
      expr: SUM(CAST(compliance_rate_pct AS DOUBLE))
      comment: "Sum of compliance rate percentages across all order sets. Used with count to derive average compliance rate — measures how consistently clinicians follow order set protocols."
    - name: "avg_compliance_rate_pct"
      expr: AVG(CAST(compliance_rate_pct AS DOUBLE))
      comment: "Average order set compliance rate across the portfolio. A core clinical quality KPI — low compliance rates indicate protocol adherence gaps requiring intervention."
    - name: "order_sets_due_for_review"
      expr: COUNT(CASE WHEN next_review_date <= CURRENT_DATE() AND is_active = TRUE THEN 1 END)
      comment: "Number of active order sets past their scheduled review date. Overdue reviews represent clinical governance risk and potential patient safety exposure."
    - name: "order_sets_with_pharmacy"
      expr: COUNT(CASE WHEN includes_pharmacy_orders = TRUE THEN 1 END)
      comment: "Number of order sets that include pharmacy orders. Used to measure medication management standardization coverage."
    - name: "order_sets_with_lab"
      expr: COUNT(CASE WHEN includes_lab_orders = TRUE THEN 1 END)
      comment: "Number of order sets that include lab orders. Used to measure diagnostic standardization coverage."
    - name: "order_sets_requiring_renal_adjustment"
      expr: COUNT(CASE WHEN renal_adjustment_required = TRUE THEN 1 END)
      comment: "Number of order sets requiring renal dose adjustment. Used to assess medication safety protocol coverage for high-risk patient populations."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`order_standing_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over standing orders (protocol-driven, pre-authorized orders). Tracks standing order portfolio health, renewal compliance, notification requirements, evidence-based guideline alignment, and regulatory compliance — critical for protocol governance, patient safety, and operational efficiency."
  source: "`healthcare_ecm`.`order`.`standing_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of standing order (e.g., Medication, Lab, Nursing) — primary axis for standing order portfolio analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Governance approval status of the standing order (e.g., Approved, Pending, Expired) — used to monitor protocol governance health."
    - name: "authorized_role"
      expr: authorized_role
      comment: "Clinical role authorized to execute the standing order (e.g., RN, PA, MD) — used to analyze scope-of-practice compliance."
    - name: "priority"
      expr: priority
      comment: "Priority level of the standing order — used to segment protocol urgency and workflow routing."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Indicates whether the standing order requires periodic renewal — used to monitor renewal compliance and protocol currency."
    - name: "notification_required_flag"
      expr: notification_required_flag
      comment: "Flags standing orders requiring provider notification upon execution — used to monitor notification compliance."
    - name: "care_setting"
      expr: activation_condition
      comment: "Condition or clinical trigger that activates the standing order — used to analyze protocol activation patterns and appropriateness."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', CAST(effective_start_date AS TIMESTAMP))
      comment: "Month the standing order became effective — used to trend protocol portfolio growth and refresh cadence."
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', CAST(effective_end_date AS TIMESTAMP))
      comment: "Month the standing order expires — used to proactively identify protocols approaching expiration."
  measures:
    - name: "total_standing_orders"
      expr: COUNT(1)
      comment: "Total number of standing orders in the protocol library. Baseline KPI for protocol portfolio size and clinical standardization coverage."
    - name: "approved_standing_order_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of standing orders with formal governance approval. Used to monitor protocol governance compliance and identify unapproved protocols in use."
    - name: "renewal_required_count"
      expr: COUNT(CASE WHEN renewal_required_flag = TRUE THEN 1 END)
      comment: "Number of standing orders requiring periodic renewal. Used to quantify renewal management burden and compliance risk."
    - name: "notification_required_count"
      expr: COUNT(CASE WHEN notification_required_flag = TRUE THEN 1 END)
      comment: "Number of standing orders requiring provider notification. Used to assess notification workflow volume and compliance obligations."
    - name: "standing_orders_expiring_soon"
      expr: COUNT(CASE WHEN effective_end_date <= DATE_ADD(CURRENT_DATE(), 90) AND effective_end_date >= CURRENT_DATE() THEN 1 END)
      comment: "Number of standing orders expiring within the next 90 days. Proactive governance KPI — expiring protocols without renewal create patient safety and compliance gaps."
    - name: "expired_standing_order_count"
      expr: COUNT(CASE WHEN effective_end_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of standing orders past their effective end date. Expired protocols still in use represent a direct patient safety and regulatory compliance risk."
    - name: "distinct_specialties_covered"
      expr: COUNT(DISTINCT specialty_id)
      comment: "Number of distinct clinical specialties with standing orders. Measures breadth of protocol standardization across the clinical enterprise."
    - name: "distinct_care_sites_covered"
      expr: COUNT(DISTINCT care_site_id)
      comment: "Number of distinct care sites with standing orders. Used to assess geographic and facility-level protocol standardization coverage."
$$;