-- Metric views for domain: order | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 14:47:42

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_clinical_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core CPOE order operations KPIs: volume, CPOE adoption, verbal-order reliance, cosign compliance, and cancellation rates that steer ordering quality and provider workflow."
  source: "`vibe_healthcare_v1`.`order`.`clinical_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Lifecycle status of the order (active, completed, cancelled) for monitoring throughput and backlog."
    - name: "order_type"
      expr: order_type
      comment: "Type of clinical order (lab, imaging, medication, etc.) for service-line analysis."
    - name: "order_priority"
      expr: order_priority
      comment: "Clinical urgency (routine, stat, urgent) used to monitor stat-order responsiveness."
    - name: "order_class"
      expr: order_class
      comment: "Order class grouping for operational segmentation."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_datetime)
      comment: "Order month for time-series trending of ordering volume."
  measures:
    - name: "Total Orders"
      expr: COUNT(1)
      comment: "Total clinical orders placed — baseline throughput KPI for ordering operations and capacity planning."
    - name: "CPOE Entered Orders"
      expr: SUM(CASE WHEN is_cpoe_entered = TRUE THEN 1 ELSE 0 END)
      comment: "Count of orders entered via CPOE — numerator for the electronic-ordering adoption rate executives track for safety and meaningful use."
    - name: "CPOE Adoption Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_cpoe_entered = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of orders entered electronically — key patient-safety and regulatory adoption KPI driving CPOE rollout decisions."
    - name: "Verbal Order Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_verbal_order = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of orders placed verbally — high verbal reliance signals safety risk and triggers workflow intervention."
    - name: "Cancelled Order Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN order_status = 'cancelled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of orders cancelled — elevated cancellations flag ordering errors or care-plan churn requiring review."
    - name: "Stat Order Share Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN order_priority = 'stat' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of orders flagged stat — informs staffing and turnaround SLA planning for urgent workloads."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_cpoe_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical decision support alert effectiveness KPIs: alert burden, override rates, and acknowledgement — central to combating alert fatigue and tuning safety alerts."
  source: "`vibe_healthcare_v1`.`order`.`cpoe_alert`"
  dimensions:
    - name: "alert_type"
      expr: alert_type
      comment: "Type of CDS alert (drug-drug, allergy, dose, duplicate) for category-level fatigue analysis."
    - name: "alert_severity"
      expr: alert_severity
      comment: "Clinical severity of the alert used to prioritize alert-tuning efforts."
    - name: "alert_status"
      expr: alert_status
      comment: "Disposition of the alert (fired, overridden, accepted) for response monitoring."
    - name: "alert_source_system"
      expr: alert_source_system
      comment: "Originating CDS system for vendor and integration performance comparison."
    - name: "alert_month"
      expr: DATE_TRUNC('MONTH', alert_fire_timestamp)
      comment: "Month the alert fired for trending alert burden over time."
  measures:
    - name: "Total Alerts Fired"
      expr: COUNT(1)
      comment: "Total CDS alerts fired — measures provider interruptive burden and is the denominator for fatigue analysis."
    - name: "Override Count"
      expr: SUM(CASE WHEN alert_status = 'overridden' THEN 1 ELSE 0 END)
      comment: "Count of alerts overridden by clinicians — high overrides indicate low-value alerts to retire."
    - name: "Override Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN alert_status = 'overridden' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of alerts overridden — primary alert-fatigue KPI guiding which alerts to tune or suppress."
    - name: "Acknowledged Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN alert_acknowledged_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of alerts acknowledged — measures whether providers engage with safety alerts."
    - name: "Suppressed Alert Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN alert_suppressed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of alerts suppressed — tracks systematic alert filtering that may hide important warnings."
    - name: "Distinct Patients Alerted"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients triggering CDS alerts — supports population-level safety risk profiling."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_fulfillment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order fulfillment operations and charge-capture KPIs: turnaround, partial fulfillment, exception rates, and charge capture compliance driving revenue integrity."
  source: "`vibe_healthcare_v1`.`order`.`fulfillment`"
  dimensions:
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Status of the fulfillment (pending, completed, exception) for backlog and completion monitoring."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Type of fulfillment activity for service-line operational analysis."
    - name: "order_type"
      expr: order_type
      comment: "Underlying order type being fulfilled for departmental comparison."
    - name: "performing_department_code"
      expr: performing_department_code
      comment: "Department performing the fulfillment for workload and TAT comparison."
    - name: "fulfillment_month"
      expr: DATE_TRUNC('MONTH', fulfillment_timestamp)
      comment: "Month of fulfillment for throughput trending."
  measures:
    - name: "Total Fulfillments"
      expr: COUNT(1)
      comment: "Total order fulfillment events — baseline operational throughput KPI for departments."
    - name: "Total Charge Amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total charges captured at fulfillment — links order operations to revenue and is monitored for charge-capture leakage."
    - name: "Charge Capture Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN charge_capture_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of fulfillments with charges captured — revenue-integrity KPI; gaps mean lost reimbursement."
    - name: "Partial Fulfillment Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN partial_fulfillment_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of fulfillments completed only partially — signals supply or operational constraints needing intervention."
    - name: "Quality Flag Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN quality_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of fulfillments flagged for quality issues — drives quality-improvement focus."
    - name: "Avg Fulfilled Quantity"
      expr: AVG(CAST(fulfilled_quantity AS DOUBLE))
      comment: "Average quantity fulfilled per event — informs capacity and resource planning."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_referral_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Referral management KPIs: referral volume, loop-closure rates, stat referrals, and authorization burden — critical for care coordination and network leakage control."
  source: "`vibe_healthcare_v1`.`order`.`referral_order`"
  dimensions:
    - name: "referral_status"
      expr: referral_status
      comment: "Status of the referral (pending, scheduled, completed) for pipeline monitoring."
    - name: "referral_type"
      expr: referral_type
      comment: "Type of referral for specialty-mix and routing analysis."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency of the referral used to prioritize time-sensitive access."
    - name: "referral_disposition"
      expr: referral_disposition
      comment: "Outcome disposition of the referral for closure analysis."
    - name: "referral_month"
      expr: DATE_TRUNC('MONTH', referral_date)
      comment: "Month of referral for volume trending and access analysis."
  measures:
    - name: "Total Referrals"
      expr: COUNT(1)
      comment: "Total referral orders placed — baseline KPI for care-coordination volume and network steering."
    - name: "Loop Closure Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN referral_loop_closed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of referrals with closed loops — top care-coordination quality KPI; open loops are patient-safety and continuity risks."
    - name: "Authorization Required Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN authorization_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of referrals requiring prior authorization — quantifies administrative burden and delay risk."
    - name: "Stat Referral Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_stat_order = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of stat referrals — informs urgent-access staffing and turnaround commitments."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_verbal_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Verbal/telephone order compliance KPIs: read-back confirmation, cosignature timeliness, and controlled-substance exposure — core Joint Commission safety compliance metrics."
  source: "`vibe_healthcare_v1`.`order`.`verbal_order`"
  dimensions:
    - name: "verbal_order_type"
      expr: verbal_order_type
      comment: "Type of verbal order for compliance segmentation."
    - name: "order_status"
      expr: order_status
      comment: "Status of the verbal order for authentication backlog monitoring."
    - name: "co_signer_role"
      expr: co_signer_role
      comment: "Role of the cosigner for accountability analysis."
    - name: "verbal_order_month"
      expr: DATE_TRUNC('MONTH', order_received_datetime)
      comment: "Month the verbal order was received for compliance trending."
  measures:
    - name: "Total Verbal Orders"
      expr: COUNT(1)
      comment: "Total verbal orders received — baseline for monitoring verbal-order reliance, a safety-flagged practice."
    - name: "Read Back Confirmed Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN read_back_confirmed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of verbal orders with read-back confirmation — mandated patient-safety KPI tracked for Joint Commission compliance."
    - name: "Overdue Cosign Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN overdue_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of verbal orders overdue for authentication — compliance-risk KPI driving cosign follow-up workflows."
    - name: "Controlled Substance Verbal Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN controlled_substance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of verbal orders for controlled substances — elevated regulatory and diversion risk requiring oversight."
    - name: "Waiver Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN waiver_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of verbal orders with cosign waivers — tracks exception usage that may indicate compliance gaps."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medication/order reconciliation KPIs at care transitions: completion, discrepancy detection, and compliance — directly tied to readmission prevention and patient safety."
  source: "`vibe_healthcare_v1`.`order`.`reconciliation`"
  dimensions:
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Type of reconciliation (admission, transfer, discharge) for transition-point analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Completion status of the reconciliation for compliance tracking."
    - name: "transition_event"
      expr: transition_event
      comment: "Care transition event prompting reconciliation for workflow analysis."
    - name: "discrepancy_severity"
      expr: discrepancy_severity
      comment: "Severity of identified discrepancies for risk prioritization."
    - name: "reconciliation_month"
      expr: DATE_TRUNC('MONTH', reconciliation_date)
      comment: "Month of reconciliation for compliance trending."
  measures:
    - name: "Total Reconciliations"
      expr: COUNT(1)
      comment: "Total reconciliation events — baseline volume KPI for transition-of-care safety processes."
    - name: "Completion Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN completion_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of reconciliations completed — core medication-reconciliation quality measure tied to readmission and safety outcomes."
    - name: "Discrepancy Identified Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN discrepancy_identified_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of reconciliations finding discrepancies — measures process value in catching medication errors."
    - name: "Compliance Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of compliant reconciliations — regulatory-compliance KPI for accreditation reporting."
    - name: "Distinct Patients Reconciled"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients receiving reconciliation — supports coverage analysis across the population."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_alert_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CDS alert-rule governance KPIs: active rule inventory, override rates, fatigue scoring, and review currency — used to govern and optimize the alert library."
  source: "`vibe_healthcare_v1`.`order`.`alert_rule`"
  dimensions:
    - name: "rule_category"
      expr: rule_category
      comment: "Category of the alert rule for library segmentation."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the rule for prioritization."
    - name: "rule_status"
      expr: rule_status
      comment: "Lifecycle status of the rule for governance tracking."
    - name: "evidence_strength_level"
      expr: evidence_strength_level
      comment: "Evidence strength backing the rule for clinical-validity assessment."
  measures:
    - name: "Total Alert Rules"
      expr: COUNT(1)
      comment: "Total alert rules in the CDS library — baseline inventory KPI for governance scope."
    - name: "Active Rule Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of rules currently active — governs the live alert burden affecting providers."
    - name: "Hard Stop Rule Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN hard_stop_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of rules that hard-stop the workflow — measures interruptive intensity of the alert library."
    - name: "Avg Override Rate Across Rules"
      expr: AVG(CAST(override_rate_percent AS DOUBLE))
      comment: "Average per-rule override rate — identifies low-value rules dragging clinician trust and driving fatigue."
    - name: "Avg Fatigue Risk Score"
      expr: AVG(CAST(alert_fatigue_risk_score AS DOUBLE))
      comment: "Average alert-fatigue risk score across rules — strategic KPI prioritizing alert-rationalization investment."
    - name: "Total Fire Count"
      expr: SUM(CAST(fire_count_total AS DOUBLE))
      comment: "Total times rules have fired — quantifies cumulative interruptive burden across the system."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_routing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order routing operations KPIs: SLA compliance, rerouting, and delay — measures the efficiency of the order-routing pipeline across departments."
  source: "`vibe_healthcare_v1`.`order`.`routing`"
  dimensions:
    - name: "routing_status"
      expr: routing_status
      comment: "Status of the routing event for pipeline monitoring."
    - name: "routing_type"
      expr: routing_type
      comment: "Type of routing for departmental segmentation."
    - name: "destination"
      expr: destination
      comment: "Routing destination for workload-distribution analysis."
    - name: "priority"
      expr: priority
      comment: "Priority of the routed order for SLA prioritization."
    - name: "routing_month"
      expr: DATE_TRUNC('MONTH', routed_timestamp)
      comment: "Month of routing for throughput trending."
  measures:
    - name: "Total Routing Events"
      expr: COUNT(1)
      comment: "Total order routing events — baseline volume KPI for the routing pipeline."
    - name: "SLA Compliance Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of routings meeting SLA targets — operational efficiency KPI for order-flow management."
    - name: "Auto Route Eligible Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN auto_route_eligible_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of routings eligible for automation — quantifies automation opportunity to reduce manual effort."
    - name: "Priority Override Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN priority_override_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of routings with manual priority overrides — signals routing-rule gaps requiring tuning."
    - name: "Avg Workload Score"
      expr: AVG(CAST(workload_score AS DOUBLE))
      comment: "Average routing workload score — informs capacity balancing across destinations."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Authorization throughput and approval rates"
  source: "`vibe_healthcare_v1`.`order`.`order_authorization`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Current status of the authorization request"
  measures:
    - name: "total_authorizations"
      expr: COUNT(1)
      comment: "Total number of order authorizations submitted"
    - name: "approved_authorizations"
      expr: SUM(CASE WHEN authorization_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Count of authorizations that were approved"
$$;