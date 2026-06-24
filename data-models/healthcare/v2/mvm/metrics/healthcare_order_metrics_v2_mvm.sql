-- Metric views for domain: order | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 16:05:56

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_clinical_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for clinical order volume, CPOE adoption, verbal order risk, order priority distribution, and recurring order patterns. Supports CMO, CNO, and operational leadership in monitoring order quality, clinician behavior, and care delivery efficiency."
  source: "`vibe_healthcare_v1`.`order`.`clinical_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of clinical order (e.g., medication, lab, imaging, procedure) — primary grouping for order volume analysis."
    - name: "order_class"
      expr: order_class
      comment: "Classification of the order (e.g., inpatient, outpatient, recurring) — used to segment order patterns by care setting."
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the order (e.g., active, completed, cancelled) — critical for operational monitoring."
    - name: "order_priority"
      expr: order_priority
      comment: "Clinical urgency priority assigned to the order (e.g., STAT, routine, urgent) — used to track high-acuity order volumes."
    - name: "order_mode"
      expr: order_mode
      comment: "Mode through which the order was entered (e.g., electronic, verbal, telephone) — key for safety and compliance analysis."
    - name: "order_date_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month bucket of the order date — enables trend analysis of order volumes over time."
    - name: "is_cpoe_entered"
      expr: is_cpoe_entered
      comment: "Indicates whether the order was entered via Computerized Physician Order Entry — key CPOE adoption dimension."
    - name: "is_verbal_order"
      expr: is_verbal_order
      comment: "Indicates whether the order was placed verbally — used to monitor verbal order risk and compliance."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Indicates whether the order is a recurring order — used to analyze standing/recurring order patterns."
    - name: "is_order_set_member"
      expr: is_order_set_member
      comment: "Indicates whether the order was placed as part of an order set — used to measure order set adoption rates."
    - name: "frequency_code"
      expr: frequency_code
      comment: "Frequency code for the order (e.g., daily, BID, PRN) — used to analyze dosing and scheduling patterns."
  measures:
    - name: "total_clinical_orders"
      expr: COUNT(1)
      comment: "Total number of clinical orders placed. Baseline volume KPI used by CMO and operations to track order throughput and workload."
    - name: "cpoe_order_count"
      expr: COUNT(CASE WHEN is_cpoe_entered = TRUE THEN 1 END)
      comment: "Count of orders entered via CPOE. Numerator for CPOE adoption rate — a key patient safety and regulatory compliance metric."
    - name: "verbal_order_count"
      expr: COUNT(CASE WHEN is_verbal_order = TRUE THEN 1 END)
      comment: "Count of verbal orders placed. High verbal order rates indicate patient safety risk and are monitored by compliance and nursing leadership."
    - name: "cancelled_order_count"
      expr: COUNT(CASE WHEN order_status = 'Cancelled' THEN 1 END)
      comment: "Count of cancelled clinical orders. Elevated cancellation rates signal workflow inefficiencies, duplicate ordering, or care coordination gaps."
    - name: "stat_order_count"
      expr: COUNT(CASE WHEN order_priority = 'STAT' THEN 1 END)
      comment: "Count of STAT (urgent) orders. Tracks high-acuity order burden on clinical staff and downstream fulfillment teams."
    - name: "order_set_member_count"
      expr: COUNT(CASE WHEN is_order_set_member = TRUE THEN 1 END)
      comment: "Count of orders placed as part of an order set. Measures order set adoption, which is linked to evidence-based care compliance and reduced variation."
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered across all clinical orders. Used to monitor supply demand, medication dispensing volumes, and resource planning."
    - name: "avg_quantity_ordered"
      expr: AVG(CAST(quantity_ordered AS DOUBLE))
      comment: "Average quantity per clinical order. Deviations from expected averages may indicate over-ordering, dosing errors, or protocol drift."
    - name: "distinct_patients_with_orders"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Count of distinct patients who have at least one clinical order. Measures breadth of clinical order activity across the patient population."
    - name: "distinct_ordering_providers"
      expr: COUNT(DISTINCT primary_clinical_ordering_clinician_id)
      comment: "Count of distinct clinicians who placed orders. Used to assess ordering provider workload distribution and identify outlier ordering behavior."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_fulfillment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for order fulfillment — covering charge capture, fulfillment throughput, partial fulfillment rates, quality flags, and turnaround efficiency. Supports CFO, COO, and department heads in monitoring revenue integrity and service delivery performance."
  source: "`vibe_healthcare_v1`.`order`.`fulfillment`"
  dimensions:
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Type of fulfillment (e.g., lab, imaging, pharmacy, procedure) — primary grouping for fulfillment volume and revenue analysis."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Current status of the fulfillment record (e.g., completed, pending, failed) — used to monitor fulfillment pipeline health."
    - name: "order_type"
      expr: order_type
      comment: "Type of the originating order — enables cross-analysis of fulfillment performance by order category."
    - name: "performing_department_code"
      expr: performing_department_code
      comment: "Department that performed the fulfillment — used to attribute volume, revenue, and quality metrics to specific departments."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority assigned to the fulfillment (e.g., STAT, routine) — used to analyze turnaround time compliance by urgency tier."
    - name: "method"
      expr: method
      comment: "Method used to fulfill the order (e.g., in-person, telehealth, mail) — used to analyze fulfillment channel mix."
    - name: "partial_fulfillment_flag"
      expr: partial_fulfillment_flag
      comment: "Indicates whether the fulfillment was only partially completed — key for identifying supply chain or capacity gaps."
    - name: "charge_capture_flag"
      expr: charge_capture_flag
      comment: "Indicates whether a charge was captured for this fulfillment — critical for revenue integrity monitoring."
    - name: "quality_flag"
      expr: quality_flag
      comment: "Indicates whether the fulfillment was flagged for a quality issue — used by quality management teams."
    - name: "fulfillment_month"
      expr: DATE_TRUNC('MONTH', fulfillment_timestamp)
      comment: "Month bucket of the fulfillment timestamp — enables trend analysis of fulfillment volumes and revenue over time."
  measures:
    - name: "total_fulfillments"
      expr: COUNT(1)
      comment: "Total number of fulfillment records. Baseline throughput KPI for operational capacity planning and department performance benchmarking."
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total charges generated from fulfillments. Primary revenue integrity KPI — directly tied to billing and financial performance."
    - name: "avg_charge_amount"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge amount per fulfillment. Used to detect pricing anomalies, benchmark against fee schedules, and monitor revenue per service."
    - name: "charge_captured_count"
      expr: COUNT(CASE WHEN charge_capture_flag = TRUE THEN 1 END)
      comment: "Count of fulfillments where a charge was successfully captured. Numerator for charge capture rate — a critical revenue cycle KPI."
    - name: "partial_fulfillment_count"
      expr: COUNT(CASE WHEN partial_fulfillment_flag = TRUE THEN 1 END)
      comment: "Count of partially fulfilled orders. Elevated partial fulfillment rates indicate supply, staffing, or scheduling constraints requiring intervention."
    - name: "quality_flagged_count"
      expr: COUNT(CASE WHEN quality_flag = TRUE THEN 1 END)
      comment: "Count of fulfillments flagged for quality issues. Directly informs quality improvement programs and accreditation readiness."
    - name: "total_fulfilled_quantity"
      expr: SUM(CAST(fulfilled_quantity AS DOUBLE))
      comment: "Total quantity fulfilled across all fulfillment records. Used to measure service delivery volume and compare against ordered quantities."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered as recorded on fulfillment records. Used as denominator for fulfillment rate calculations."
    - name: "distinct_patients_fulfilled"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Count of distinct patients who received a fulfillment. Measures breadth of service delivery across the patient population."
    - name: "distinct_performing_providers"
      expr: COUNT(DISTINCT primary_fulfillment_clinician_id)
      comment: "Count of distinct clinicians who performed fulfillments. Used to assess provider workload distribution and productivity."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient safety and compliance KPIs for medication reconciliation — covering discrepancy rates, compliance indicators, drug interaction checks, and reconciliation completeness. Supports CNO, pharmacy leadership, and patient safety officers in monitoring reconciliation quality at care transitions."
  source: "`vibe_healthcare_v1`.`order`.`reconciliation`"
  dimensions:
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Type of reconciliation performed (e.g., admission, discharge, transfer) — primary grouping for reconciliation safety analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Current status of the reconciliation record (e.g., complete, pending, in-progress) — used to monitor reconciliation pipeline."
    - name: "transition_event"
      expr: transition_event
      comment: "Care transition event that triggered the reconciliation (e.g., admission, discharge, transfer) — key for patient safety analysis."
    - name: "discrepancy_severity"
      expr: discrepancy_severity
      comment: "Severity level of identified discrepancies (e.g., minor, major, critical) — used to prioritize patient safety interventions."
    - name: "method"
      expr: method
      comment: "Method used to perform the reconciliation (e.g., pharmacist review, clinician review) — used to analyze reconciliation process variation."
    - name: "reconciliation_date_month"
      expr: DATE_TRUNC('MONTH', reconciliation_date)
      comment: "Month bucket of the reconciliation date — enables trend analysis of reconciliation volumes and quality over time."
    - name: "discrepancy_flag"
      expr: discrepancy_flag
      comment: "Indicates whether a discrepancy was identified during reconciliation — primary safety flag dimension."
    - name: "compliance_indicator"
      expr: compliance_indicator
      comment: "Indicates whether the reconciliation met compliance requirements — used for regulatory reporting and accreditation."
    - name: "completion_indicator"
      expr: completion_indicator
      comment: "Indicates whether the reconciliation was fully completed — used to track reconciliation completion rates."
  measures:
    - name: "total_reconciliations"
      expr: COUNT(1)
      comment: "Total number of medication reconciliations performed. Baseline volume KPI for patient safety program monitoring and staffing adequacy."
    - name: "reconciliations_with_discrepancy"
      expr: COUNT(CASE WHEN discrepancy_flag = TRUE THEN 1 END)
      comment: "Count of reconciliations where a medication discrepancy was identified. High discrepancy counts signal patient safety risk and care coordination failures."
    - name: "completed_reconciliations"
      expr: COUNT(CASE WHEN completion_indicator = TRUE THEN 1 END)
      comment: "Count of fully completed reconciliations. Numerator for reconciliation completion rate — a key Joint Commission and CMS compliance metric."
    - name: "compliant_reconciliations"
      expr: COUNT(CASE WHEN compliance_indicator = TRUE THEN 1 END)
      comment: "Count of reconciliations meeting compliance standards. Directly tied to regulatory reporting requirements and accreditation readiness."
    - name: "drug_interaction_checks_performed"
      expr: COUNT(CASE WHEN drug_interaction_check_indicator = TRUE THEN 1 END)
      comment: "Count of reconciliations where a drug interaction check was performed. Measures adherence to pharmacy safety protocols."
    - name: "allergy_reviews_performed"
      expr: COUNT(CASE WHEN allergy_review_indicator = TRUE THEN 1 END)
      comment: "Count of reconciliations where an allergy review was completed. Tracks adherence to allergy safety protocols during care transitions."
    - name: "home_medication_lists_reviewed"
      expr: COUNT(CASE WHEN home_medication_list_reviewed_indicator = TRUE THEN 1 END)
      comment: "Count of reconciliations where the home medication list was reviewed. Critical for preventing medication errors at admission and discharge."
    - name: "distinct_patients_reconciled"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Count of distinct patients who underwent medication reconciliation. Measures breadth of reconciliation program coverage across the patient population."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_referral_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for referral management — covering referral volume, loop closure rates, authorization requirements, urgency distribution, and referral disposition outcomes. Supports CMO, care coordination leadership, and network management in monitoring referral efficiency and network leakage."
  source: "`vibe_healthcare_v1`.`order`.`referral_order`"
  dimensions:
    - name: "referral_type"
      expr: referral_type
      comment: "Type of referral (e.g., specialist, primary care, behavioral health) — primary grouping for referral volume and outcome analysis."
    - name: "referral_status"
      expr: referral_status
      comment: "Current status of the referral (e.g., pending, scheduled, completed, cancelled) — used to monitor referral pipeline health."
    - name: "referral_disposition"
      expr: referral_disposition
      comment: "Outcome disposition of the referral (e.g., accepted, declined, redirected) — used to analyze referral acceptance rates by receiving provider."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency level assigned to the referral (e.g., routine, urgent, emergent) — used to monitor high-acuity referral volumes and response times."
    - name: "referral_source"
      expr: referral_source
      comment: "Source of the referral (e.g., PCP, specialist, ED) — used to analyze referral origin patterns and network utilization."
    - name: "plan_type"
      expr: plan_type
      comment: "Health plan type associated with the referral — used to analyze referral patterns by payer and plan type."
    - name: "authorization_required"
      expr: authorization_required
      comment: "Indicates whether prior authorization is required for the referral — used to monitor authorization burden and potential care delays."
    - name: "referral_loop_closed"
      expr: referral_loop_closed
      comment: "Indicates whether the referral loop was closed (i.e., results received back to referring provider) — key care coordination quality dimension."
    - name: "is_stat_order"
      expr: is_stat_order
      comment: "Indicates whether the referral was placed as a STAT (urgent) order — used to track urgent referral volumes."
    - name: "referral_date_month"
      expr: DATE_TRUNC('MONTH', referral_date)
      comment: "Month bucket of the referral date — enables trend analysis of referral volumes and outcomes over time."
  measures:
    - name: "total_referrals"
      expr: COUNT(1)
      comment: "Total number of referral orders placed. Baseline volume KPI for care coordination capacity planning and network utilization monitoring."
    - name: "referral_loop_closed_count"
      expr: COUNT(CASE WHEN referral_loop_closed = TRUE THEN 1 END)
      comment: "Count of referrals where the loop was closed. Numerator for referral loop closure rate — a key care coordination quality and patient safety metric."
    - name: "authorization_required_count"
      expr: COUNT(CASE WHEN authorization_required = TRUE THEN 1 END)
      comment: "Count of referrals requiring prior authorization. High authorization burden indicates administrative friction that may delay patient care."
    - name: "stat_referral_count"
      expr: COUNT(CASE WHEN is_stat_order = TRUE THEN 1 END)
      comment: "Count of STAT (urgent) referrals. Tracks high-acuity referral volume and is used to ensure urgent referrals are processed within SLA."
    - name: "distinct_patients_referred"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Count of distinct patients with at least one referral order. Measures breadth of referral activity across the patient population."
    - name: "distinct_receiving_providers"
      expr: COUNT(DISTINCT receiving_provider_clinician_id)
      comment: "Count of distinct receiving providers for referrals. Used to analyze referral network breadth and identify concentration risk in specialist utilization."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_routing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for order routing efficiency — covering SLA compliance, reroute rates, priority overrides, workload distribution, and transport/specimen requirements. Supports operations leadership and department managers in monitoring order routing performance and queue management."
  source: "`vibe_healthcare_v1`.`order`.`routing`"
  dimensions:
    - name: "routing_type"
      expr: routing_type
      comment: "Type of routing applied to the order (e.g., auto-route, manual, escalated) — primary grouping for routing efficiency analysis."
    - name: "routing_status"
      expr: routing_status
      comment: "Current status of the routing record (e.g., pending, acknowledged, completed) — used to monitor routing pipeline health."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the routing (e.g., STAT, routine, urgent) — used to analyze routing throughput by urgency tier."
    - name: "queue_name"
      expr: queue_name
      comment: "Name of the work queue the order was routed to — used to analyze queue-level workload and SLA compliance."
    - name: "method"
      expr: method
      comment: "Method used for routing (e.g., electronic, manual, fax) — used to analyze routing channel efficiency."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Indicates whether the routing met its SLA target — primary dimension for SLA compliance analysis."
    - name: "auto_route_eligible_flag"
      expr: auto_route_eligible_flag
      comment: "Indicates whether the order was eligible for auto-routing — used to measure automation opportunity and adoption."
    - name: "priority_override_flag"
      expr: priority_override_flag
      comment: "Indicates whether the routing priority was manually overridden — used to monitor override rates and potential workflow abuse."
    - name: "transport_required_flag"
      expr: transport_required_flag
      comment: "Indicates whether patient transport was required for this routing — used to analyze transport demand and logistics planning."
    - name: "routing_month"
      expr: DATE_TRUNC('MONTH', routed_timestamp)
      comment: "Month bucket of the routed timestamp — enables trend analysis of routing volumes and SLA compliance over time."
  measures:
    - name: "total_routings"
      expr: COUNT(1)
      comment: "Total number of order routing records. Baseline throughput KPI for operational capacity planning and queue management."
    - name: "sla_compliant_routing_count"
      expr: COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END)
      comment: "Count of routings that met their SLA target. Numerator for SLA compliance rate — a key operational performance metric for department managers and COO."
    - name: "priority_override_count"
      expr: COUNT(CASE WHEN priority_override_flag = TRUE THEN 1 END)
      comment: "Count of routings where priority was manually overridden. High override rates may indicate workflow gaming, escalation issues, or inadequate auto-routing logic."
    - name: "auto_route_eligible_count"
      expr: COUNT(CASE WHEN auto_route_eligible_flag = TRUE THEN 1 END)
      comment: "Count of routings eligible for auto-routing. Used to measure automation opportunity and benchmark against actual auto-routed volumes."
    - name: "transport_required_count"
      expr: COUNT(CASE WHEN transport_required_flag = TRUE THEN 1 END)
      comment: "Count of routings requiring patient transport. Used for logistics planning and transport resource allocation."
    - name: "specimen_collection_required_count"
      expr: COUNT(CASE WHEN specimen_collection_required_flag = TRUE THEN 1 END)
      comment: "Count of routings requiring specimen collection. Used to plan phlebotomy and specimen logistics staffing."
    - name: "total_workload_score"
      expr: SUM(CAST(workload_score AS DOUBLE))
      comment: "Total workload score across all routing records. Used to measure aggregate clinical workload burden and support staffing decisions."
    - name: "avg_workload_score"
      expr: AVG(CAST(workload_score AS DOUBLE))
      comment: "Average workload score per routing record. Used to benchmark workload intensity across queues, departments, and time periods."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_set`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Governance and adoption KPIs for clinical order sets — covering evidence-based set prevalence, approval status distribution, cosignature requirements, and set lifecycle management. Supports CMO, clinical informatics, and quality leadership in governing evidence-based order set adoption."
  source: "`vibe_healthcare_v1`.`order`.`set`"
  dimensions:
    - name: "order_set_type"
      expr: order_set_type
      comment: "Type of order set (e.g., admission, procedure, disease-specific) — primary grouping for order set governance analysis."
    - name: "order_set_status"
      expr: order_set_status
      comment: "Current lifecycle status of the order set (e.g., active, retired, draft) — used to monitor order set currency and governance."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the order set (e.g., approved, pending, rejected) — used to track governance compliance."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting for which the order set is designed (e.g., inpatient, outpatient, ED) — used to analyze order set coverage by care setting."
    - name: "clinical_domain"
      expr: clinical_domain
      comment: "Clinical domain of the order set (e.g., cardiology, oncology, surgery) — used to analyze order set coverage by specialty."
    - name: "is_evidence_based"
      expr: is_evidence_based
      comment: "Indicates whether the order set is grounded in evidence-based guidelines — key dimension for clinical quality governance."
    - name: "requires_cosignature"
      expr: requires_cosignature
      comment: "Indicates whether the order set requires a cosignature — used to monitor oversight and compliance requirements."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month bucket of the order set effective date — used to track order set rollout and retirement timelines."
  measures:
    - name: "total_order_sets"
      expr: COUNT(1)
      comment: "Total number of order sets in the catalog. Baseline KPI for order set library size and governance scope."
    - name: "active_order_sets"
      expr: COUNT(CASE WHEN order_set_status = 'Active' THEN 1 END)
      comment: "Count of currently active order sets. Used by clinical informatics to monitor the active order set library size and identify stale or retired sets."
    - name: "evidence_based_order_sets"
      expr: COUNT(CASE WHEN is_evidence_based = TRUE THEN 1 END)
      comment: "Count of order sets grounded in evidence-based guidelines. Numerator for evidence-based order set adoption rate — a key clinical quality metric."
    - name: "approved_order_sets"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Count of order sets with approved governance status. Used to monitor governance compliance and identify sets pending approval."
    - name: "cosignature_required_sets"
      expr: COUNT(CASE WHEN requires_cosignature = TRUE THEN 1 END)
      comment: "Count of order sets requiring cosignature. Used to assess oversight burden and ensure appropriate supervision requirements are in place."
    - name: "order_sets_past_review_date"
      expr: COUNT(CASE WHEN next_review_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of order sets past their scheduled review date. Directly informs clinical governance — overdue reviews indicate risk of outdated clinical guidance being used."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_standing_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Governance and compliance KPIs for standing orders — covering renewal requirements, notification obligations, approval status, and protocol coverage. Supports CNO, pharmacy leadership, and compliance officers in monitoring standing order governance and patient safety."
  source: "`vibe_healthcare_v1`.`order`.`standing_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of standing order (e.g., medication, lab, nursing) — primary grouping for standing order governance analysis."
    - name: "standing_order_status"
      expr: standing_order_status
      comment: "Current lifecycle status of the standing order (e.g., active, expired, suspended) — used to monitor standing order currency."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the standing order — used to track governance compliance and identify unapproved standing orders."
    - name: "authorized_role"
      expr: authorized_role
      comment: "Clinical role authorized to execute the standing order (e.g., RN, PA, NP) — used to analyze scope of practice compliance."
    - name: "priority"
      expr: priority
      comment: "Priority level of the standing order — used to analyze urgency distribution across standing order types."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Indicates whether the standing order requires periodic renewal — used to monitor renewal compliance and expiration risk."
    - name: "notification_required_flag"
      expr: notification_required_flag
      comment: "Indicates whether notification is required when the standing order is executed — used to monitor communication compliance."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month bucket of the standing order effective start date — used to track standing order activation trends over time."
  measures:
    - name: "total_standing_orders"
      expr: COUNT(1)
      comment: "Total number of standing orders in the system. Baseline KPI for standing order library scope and governance oversight."
    - name: "active_standing_orders"
      expr: COUNT(CASE WHEN standing_order_status = 'Active' THEN 1 END)
      comment: "Count of currently active standing orders. Used by CNO and pharmacy to monitor the active standing order inventory and identify expired or suspended orders."
    - name: "renewal_required_count"
      expr: COUNT(CASE WHEN renewal_required_flag = TRUE THEN 1 END)
      comment: "Count of standing orders requiring periodic renewal. Used to plan renewal workflows and ensure standing orders do not lapse, which could disrupt patient care."
    - name: "notification_required_count"
      expr: COUNT(CASE WHEN notification_required_flag = TRUE THEN 1 END)
      comment: "Count of standing orders requiring notification upon execution. Used to ensure communication workflows are in place for high-oversight standing orders."
    - name: "approved_standing_orders"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Count of standing orders with approved governance status. Used to monitor governance compliance and identify standing orders pending or lacking approval."
    - name: "distinct_patients_with_standing_orders"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Count of distinct patients with at least one standing order. Measures breadth of standing order utilization across the patient population."
$$;