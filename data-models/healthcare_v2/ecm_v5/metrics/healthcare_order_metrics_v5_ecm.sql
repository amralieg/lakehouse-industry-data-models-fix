-- Metric views for domain: order | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`order_clinical_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core clinical order metrics tracking order volume, completion rates, CPOE compliance, and turnaround efficiency across the order management lifecycle."
  source: "`healthcare_ecm_v1`.`order`.`clinical_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of clinical order (medication, laboratory, radiology, referral, procedure) for volume analysis by category"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order (active, completed, cancelled, discontinued) for pipeline tracking"
    - name: "order_priority"
      expr: order_priority
      comment: "Priority level (stat, routine, urgent) for workload and response time analysis"
    - name: "order_class"
      expr: order_class
      comment: "Order class (inpatient, outpatient, emergency) for setting-based analysis"
    - name: "is_cpoe_entered"
      expr: CAST(is_cpoe_entered AS STRING)
      comment: "Whether order was entered via CPOE system - critical for CMS Meaningful Use compliance reporting"
    - name: "is_verbal_order"
      expr: CAST(is_verbal_order AS STRING)
      comment: "Whether order originated as verbal order - tracked for Joint Commission compliance"
    - name: "is_recurring"
      expr: CAST(is_recurring AS STRING)
      comment: "Whether order is recurring - relevant for chronic disease management workflows"
    - name: "source_system"
      expr: source_system
      comment: "Originating EHR or clinical system for multi-system integration analysis"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_datetime)
      comment: "Month of order placement for trend analysis"
    - name: "order_mode"
      expr: order_mode
      comment: "Mode of order entry (electronic, written, telephone) for workflow optimization"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of clinical orders placed - baseline volume metric for capacity planning"
    - name: "cpoe_order_count"
      expr: COUNT(CASE WHEN is_cpoe_entered = TRUE THEN 1 END)
      comment: "Count of orders entered via CPOE - numerator for CMS CPOE compliance rate"
    - name: "verbal_order_count"
      expr: COUNT(CASE WHEN is_verbal_order = TRUE THEN 1 END)
      comment: "Count of verbal orders - monitored for Joint Commission compliance (should be minimized)"
    - name: "cancelled_order_count"
      expr: COUNT(CASE WHEN order_status = 'cancelled' THEN 1 END)
      comment: "Count of cancelled orders - indicator of order appropriateness and clinical decision support effectiveness"
    - name: "completed_order_count"
      expr: COUNT(CASE WHEN order_status = 'completed' THEN 1 END)
      comment: "Count of completed orders - throughput metric for operational efficiency"
    - name: "avg_quantity_ordered"
      expr: AVG(CAST(quantity_ordered AS DOUBLE))
      comment: "Average quantity per order - useful for pharmacy and supply chain demand forecasting"
    - name: "stat_order_count"
      expr: COUNT(CASE WHEN order_priority = 'stat' THEN 1 END)
      comment: "Count of stat/urgent orders - indicator of acuity and emergency workload"
    - name: "distinct_ordering_providers"
      expr: COUNT(DISTINCT ordering_provider_npi)
      comment: "Distinct ordering providers - workforce utilization and order distribution analysis"
    - name: "order_set_member_count"
      expr: COUNT(CASE WHEN is_order_set_member = TRUE THEN 1 END)
      comment: "Orders placed as part of order sets - measures standardized care pathway adoption"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`order_cpoe_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical decision support alert metrics measuring alert fatigue, override rates, and CDS effectiveness - critical for patient safety and Meaningful Use compliance."
  source: "`healthcare_ecm_v1`.`order`.`cpoe_alert`"
  dimensions:
    - name: "alert_type"
      expr: alert_type
      comment: "Type of CDS alert (drug-drug interaction, allergy, dose range, duplicate order) for effectiveness analysis"
    - name: "alert_severity"
      expr: alert_severity
      comment: "Severity classification of the alert for risk stratification of overrides"
    - name: "provider_response"
      expr: provider_response
      comment: "How the clinician responded (accepted, overridden, cancelled order) - key for alert fatigue analysis"
    - name: "alert_priority"
      expr: alert_priority
      comment: "Display priority of the alert for UI optimization studies"
    - name: "formulary_status"
      expr: formulary_status
      comment: "Formulary status triggering the alert - relevant for pharmacy cost management"
    - name: "alert_suppressed_flag"
      expr: CAST(alert_suppressed_flag AS STRING)
      comment: "Whether alert was suppressed before display - measures suppression rule effectiveness"
    - name: "alert_source_system"
      expr: alert_source_system
      comment: "Source CDS system generating the alert for vendor performance comparison"
    - name: "alert_fire_month"
      expr: DATE_TRUNC('MONTH', alert_fire_timestamp)
      comment: "Month alert fired for trend analysis of alert volumes"
  measures:
    - name: "total_alerts_fired"
      expr: COUNT(1)
      comment: "Total CDS alerts fired - baseline for alert burden and fatigue analysis"
    - name: "overridden_alert_count"
      expr: COUNT(CASE WHEN provider_response = 'overridden' THEN 1 END)
      comment: "Alerts overridden by clinicians - high override rates indicate alert fatigue risk"
    - name: "accepted_alert_count"
      expr: COUNT(CASE WHEN provider_response = 'accepted' THEN 1 END)
      comment: "Alerts accepted (order modified/cancelled) - measures CDS clinical impact"
    - name: "suppressed_alert_count"
      expr: COUNT(CASE WHEN alert_suppressed_flag = TRUE THEN 1 END)
      comment: "Alerts suppressed before display - measures pre-filtering effectiveness"
    - name: "high_severity_alert_count"
      expr: COUNT(CASE WHEN alert_severity = 'high' THEN 1 END)
      comment: "High-severity alerts - these should have lowest override rates for patient safety"
    - name: "avg_ordered_dose"
      expr: AVG(CAST(ordered_dose AS DOUBLE))
      comment: "Average ordered dose triggering alerts - useful for dose range alert calibration"
    - name: "distinct_patients_alerted"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients generating alerts - identifies high-risk patient populations"
    - name: "distinct_clinicians_alerted"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Distinct clinicians receiving alerts - identifies providers with highest alert burden"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`order_fulfillment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order fulfillment metrics tracking completion rates, turnaround times, charge capture, and partial fulfillment patterns for revenue cycle and operational efficiency."
  source: "`healthcare_ecm_v1`.`order`.`fulfillment`"
  dimensions:
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Current fulfillment status for pipeline and bottleneck analysis"
    - name: "order_type"
      expr: order_type
      comment: "Type of order being fulfilled for category-level performance comparison"
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Method of fulfillment (in-house, send-out, mobile) for operational routing optimization"
    - name: "charge_capture_flag"
      expr: CAST(charge_capture_flag AS STRING)
      comment: "Whether charge was captured - critical for revenue leakage detection"
    - name: "partial_fulfillment_flag"
      expr: CAST(partial_fulfillment_flag AS STRING)
      comment: "Whether fulfillment was partial - indicates supply or capacity constraints"
    - name: "priority_code"
      expr: priority_code
      comment: "Priority of the fulfillment for SLA compliance tracking"
    - name: "performing_department_code"
      expr: performing_department_code
      comment: "Department performing the fulfillment for departmental productivity analysis"
    - name: "fulfillment_month"
      expr: DATE_TRUNC('MONTH', datetime)
      comment: "Month of fulfillment for trend and seasonality analysis"
  measures:
    - name: "total_fulfillments"
      expr: COUNT(1)
      comment: "Total fulfillment events - operational throughput baseline"
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total charges generated from fulfillments - revenue impact of order completion"
    - name: "avg_charge_amount"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge per fulfillment - monitors charge integrity and pricing consistency"
    - name: "total_fulfilled_quantity"
      expr: SUM(CAST(fulfilled_quantity AS DOUBLE))
      comment: "Total quantity fulfilled across all orders - supply consumption metric"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity originally ordered - denominator for fill rate calculation"
    - name: "charge_captured_count"
      expr: COUNT(CASE WHEN charge_capture_flag = TRUE THEN 1 END)
      comment: "Fulfillments with charge captured - numerator for charge capture rate (revenue integrity)"
    - name: "partial_fulfillment_count"
      expr: COUNT(CASE WHEN partial_fulfillment_flag = TRUE THEN 1 END)
      comment: "Partial fulfillments - indicator of supply chain or capacity issues"
    - name: "distinct_patients_served"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct patients receiving fulfilled orders - patient reach metric"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`order_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization metrics tracking approval rates, turnaround times, denial patterns, and appeal outcomes - critical for revenue cycle and patient access."
  source: "`healthcare_ecm_v1`.`order`.`order_authorization`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Current authorization status (approved, denied, pending, appealed) for pipeline management"
    - name: "authorization_type"
      expr: authorization_type
      comment: "Type of authorization (prior auth, concurrent review, retrospective) for workflow analysis"
    - name: "priority"
      expr: priority
      comment: "Priority level of the authorization request for SLA tracking"
    - name: "submission_method"
      expr: submission_method
      comment: "How authorization was submitted (electronic, fax, phone, portal) for automation opportunity analysis"
    - name: "facility_service_category"
      expr: facility_service_category
      comment: "Service category (inpatient, outpatient surgery, imaging, DME) for denial pattern analysis"
    - name: "claim_appeal_status"
      expr: claim_appeal_status
      comment: "Appeal status for denied authorizations - tracks appeal success rates"
    - name: "peer_to_peer_conducted"
      expr: CAST(peer_to_peer_conducted AS STRING)
      comment: "Whether peer-to-peer review was conducted - often reverses denials"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_datetime)
      comment: "Month of authorization request for volume trending"
  measures:
    - name: "total_authorization_requests"
      expr: COUNT(1)
      comment: "Total prior authorization requests - administrative burden metric"
    - name: "approved_count"
      expr: COUNT(CASE WHEN authorization_status = 'approved' THEN 1 END)
      comment: "Approved authorizations - numerator for approval rate"
    - name: "denied_count"
      expr: COUNT(CASE WHEN authorization_status = 'denied' THEN 1 END)
      comment: "Denied authorizations - triggers root cause analysis and appeal workflows"
    - name: "avg_turnaround_hours"
      expr: AVG(CAST(turnaround_time_hours AS DOUBLE))
      comment: "Average turnaround time in hours - SLA compliance and patient access impact metric"
    - name: "total_approved_quantity"
      expr: SUM(CAST(approved_quantity AS DOUBLE))
      comment: "Total approved service quantity - measures authorization generosity/restrictiveness"
    - name: "total_requested_quantity"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total requested service quantity - denominator for quantity approval rate"
    - name: "peer_to_peer_count"
      expr: COUNT(CASE WHEN peer_to_peer_conducted = TRUE THEN 1 END)
      comment: "Peer-to-peer reviews conducted - resource-intensive process tracked for efficiency"
    - name: "distinct_payers"
      expr: COUNT(DISTINCT payer_id)
      comment: "Distinct payers involved - identifies payers with highest denial/delay patterns"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`order_referral_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Referral management metrics tracking referral loop closure, leakage, scheduling timeliness, and network retention - critical for value-based care and patient retention."
  source: "`healthcare_ecm_v1`.`order`.`referral_order`"
  dimensions:
    - name: "referral_type"
      expr: referral_type
      comment: "Type of referral (specialist, facility, ancillary) for volume distribution analysis"
    - name: "order_status"
      expr: order_status
      comment: "Current referral status for pipeline and bottleneck identification"
    - name: "referral_disposition"
      expr: referral_disposition
      comment: "Final disposition of the referral for outcome tracking"
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency of the referral for access timeliness analysis"
    - name: "referral_loop_closed"
      expr: CAST(referral_loop_closed AS STRING)
      comment: "Whether referral loop was closed (report received back) - key quality and care coordination metric"
    - name: "authorization_required"
      expr: CAST(authorization_required AS STRING)
      comment: "Whether prior auth was needed - identifies administrative burden by referral type"
    - name: "referral_source"
      expr: referral_source
      comment: "Source of the referral for network analysis"
    - name: "order_placed_month"
      expr: DATE_TRUNC('MONTH', order_placed_timestamp)
      comment: "Month referral was placed for trend analysis"
  measures:
    - name: "total_referrals"
      expr: COUNT(1)
      comment: "Total referral orders placed - volume metric for care coordination workload"
    - name: "loop_closed_count"
      expr: COUNT(CASE WHEN referral_loop_closed = TRUE THEN 1 END)
      comment: "Referrals with closed loop - numerator for loop closure rate (quality metric)"
    - name: "cancelled_referral_count"
      expr: COUNT(CASE WHEN order_status = 'cancelled' THEN 1 END)
      comment: "Cancelled referrals - may indicate access barriers or patient no-shows"
    - name: "stat_referral_count"
      expr: COUNT(CASE WHEN is_stat_order = TRUE THEN 1 END)
      comment: "Stat/urgent referrals - acuity indicator for specialist access"
    - name: "auth_required_count"
      expr: COUNT(CASE WHEN authorization_required = TRUE THEN 1 END)
      comment: "Referrals requiring prior authorization - administrative burden metric"
    - name: "distinct_receiving_providers"
      expr: COUNT(DISTINCT receiving_provider_npi)
      comment: "Distinct receiving providers - network breadth and referral concentration analysis"
    - name: "distinct_referring_providers"
      expr: COUNT(DISTINCT referring_provider_npi)
      comment: "Distinct referring providers - identifies high-volume referrers for relationship management"
    - name: "distinct_specialties"
      expr: COUNT(DISTINCT specialty_id)
      comment: "Distinct specialties referred to - demand signal for specialist capacity planning"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`order_verbal_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Verbal order compliance metrics tracking authentication timeliness, read-back confirmation, and overdue rates - critical for Joint Commission and CMS regulatory compliance."
  source: "`healthcare_ecm_v1`.`order`.`verbal_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current verbal order status for compliance pipeline tracking"
    - name: "order_type"
      expr: order_type
      comment: "Type of verbal order for risk stratification"
    - name: "verbal_order_type"
      expr: verbal_order_type
      comment: "Specific verbal order classification (telephone, in-person verbal) for workflow analysis"
    - name: "controlled_substance_flag"
      expr: CAST(controlled_substance_flag AS STRING)
      comment: "Whether order involves controlled substance - highest compliance risk category"
    - name: "read_back_confirmed_flag"
      expr: CAST(read_back_confirmed_flag AS STRING)
      comment: "Whether read-back was confirmed - Joint Commission NPSG requirement"
    - name: "overdue_flag"
      expr: CAST(overdue_flag AS STRING)
      comment: "Whether authentication is overdue - compliance risk indicator"
    - name: "priority"
      expr: priority
      comment: "Order priority for context on verbal order necessity"
    - name: "order_received_month"
      expr: DATE_TRUNC('MONTH', order_received_datetime)
      comment: "Month verbal order was received for compliance trending"
  measures:
    - name: "total_verbal_orders"
      expr: COUNT(1)
      comment: "Total verbal orders - should be minimized per best practice; high volumes indicate workflow issues"
    - name: "overdue_authentication_count"
      expr: COUNT(CASE WHEN overdue_flag = TRUE THEN 1 END)
      comment: "Verbal orders with overdue authentication - direct regulatory compliance risk"
    - name: "read_back_confirmed_count"
      expr: COUNT(CASE WHEN read_back_confirmed_flag = TRUE THEN 1 END)
      comment: "Orders with confirmed read-back - numerator for Joint Commission NPSG compliance rate"
    - name: "controlled_substance_count"
      expr: COUNT(CASE WHEN controlled_substance_flag = TRUE THEN 1 END)
      comment: "Controlled substance verbal orders - highest risk category requiring DEA compliance"
    - name: "authenticated_count"
      expr: COUNT(CASE WHEN authentication_datetime IS NOT NULL THEN 1 END)
      comment: "Orders that have been authenticated - numerator for authentication completion rate"
    - name: "waiver_count"
      expr: COUNT(CASE WHEN waiver_flag = TRUE THEN 1 END)
      comment: "Orders with authentication waivers - monitors exception usage for compliance audits"
    - name: "distinct_ordering_providers"
      expr: COUNT(DISTINCT ordering_provider_npi)
      comment: "Distinct providers issuing verbal orders - identifies providers needing CPOE training"
    - name: "distinct_receiving_clinicians"
      expr: COUNT(DISTINCT receiving_clinician_id)
      comment: "Distinct clinicians receiving verbal orders - workload distribution for nursing staff"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`order_routing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order routing efficiency metrics tracking SLA compliance, turnaround times, rerouting patterns, and queue management for operational throughput optimization."
  source: "`healthcare_ecm_v1`.`order`.`order_routing`"
  dimensions:
    - name: "order_routing_status"
      expr: order_routing_status
      comment: "Current routing status for pipeline visibility"
    - name: "order_routing_method"
      expr: order_routing_method
      comment: "Routing method (electronic, manual, auto-routed) for automation analysis"
    - name: "priority"
      expr: priority
      comment: "Routing priority for SLA tier analysis"
    - name: "sla_compliance_flag"
      expr: CAST(sla_compliance_flag AS STRING)
      comment: "Whether routing met SLA target - key operational performance indicator"
    - name: "auto_route_eligible_flag"
      expr: CAST(auto_route_eligible_flag AS STRING)
      comment: "Whether order was eligible for auto-routing - automation opportunity metric"
    - name: "queue_name"
      expr: queue_name
      comment: "Destination queue for workload distribution analysis"
    - name: "routing_month"
      expr: DATE_TRUNC('MONTH', datetime)
      comment: "Month of routing event for trend analysis"
  measures:
    - name: "total_routings"
      expr: COUNT(1)
      comment: "Total order routing events - operational volume baseline"
    - name: "sla_compliant_count"
      expr: COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END)
      comment: "Routings meeting SLA targets - numerator for SLA compliance rate"
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_compliance_flag = FALSE THEN 1 END)
      comment: "Routings breaching SLA - triggers operational intervention"
    - name: "auto_route_eligible_count"
      expr: COUNT(CASE WHEN auto_route_eligible_flag = TRUE THEN 1 END)
      comment: "Orders eligible for auto-routing - measures automation opportunity"
    - name: "priority_override_count"
      expr: COUNT(CASE WHEN priority_override_flag = TRUE THEN 1 END)
      comment: "Priority overrides - monitors exception handling patterns"
    - name: "avg_workload_score"
      expr: AVG(CAST(workload_score AS DOUBLE))
      comment: "Average workload score at routing time - capacity utilization indicator"
    - name: "rerouted_count"
      expr: COUNT(CASE WHEN reroute_reason IS NOT NULL THEN 1 END)
      comment: "Orders that were rerouted - indicates initial routing rule inefficiency"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`order_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medication reconciliation metrics tracking completion rates, discrepancy identification, and compliance with CMS and Joint Commission requirements at transitions of care."
  source: "`healthcare_ecm_v1`.`order`.`reconciliation`"
  dimensions:
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Type of reconciliation (admission, discharge, transfer) for transition-specific analysis"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Current status of reconciliation for completion tracking"
    - name: "transition_event"
      expr: transition_event
      comment: "Care transition triggering reconciliation for workflow optimization"
    - name: "reconciliation_method"
      expr: reconciliation_method
      comment: "Method used (electronic, manual, hybrid) for automation analysis"
    - name: "discrepancy_identified_indicator"
      expr: CAST(discrepancy_identified_indicator AS STRING)
      comment: "Whether discrepancies were found - patient safety signal"
    - name: "compliance_indicator"
      expr: CAST(compliance_indicator AS STRING)
      comment: "Whether reconciliation met compliance requirements"
    - name: "discrepancy_severity"
      expr: discrepancy_severity
      comment: "Severity of identified discrepancies for risk prioritization"
    - name: "reconciliation_month"
      expr: DATE_TRUNC('MONTH', datetime)
      comment: "Month of reconciliation for compliance trending"
  measures:
    - name: "total_reconciliations"
      expr: COUNT(1)
      comment: "Total medication reconciliation events - compliance volume baseline"
    - name: "completed_count"
      expr: COUNT(CASE WHEN completion_indicator = TRUE THEN 1 END)
      comment: "Completed reconciliations - numerator for completion rate (CMS quality measure)"
    - name: "discrepancy_found_count"
      expr: COUNT(CASE WHEN discrepancy_identified_indicator = TRUE THEN 1 END)
      comment: "Reconciliations with discrepancies - patient safety intervention opportunities"
    - name: "compliant_count"
      expr: COUNT(CASE WHEN compliance_indicator = TRUE THEN 1 END)
      comment: "Reconciliations meeting compliance standards - regulatory reporting metric"
    - name: "non_compliant_count"
      expr: COUNT(CASE WHEN compliance_indicator = FALSE THEN 1 END)
      comment: "Non-compliant reconciliations - triggers corrective action"
    - name: "drug_interaction_checked_count"
      expr: COUNT(CASE WHEN drug_interaction_check_indicator = TRUE THEN 1 END)
      comment: "Reconciliations with drug interaction check performed - safety process adherence"
    - name: "distinct_patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with reconciliation events - population coverage metric"
    - name: "distinct_providers"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Distinct providers performing reconciliations - workload distribution"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`order_alert_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CDS alert rule governance metrics tracking rule effectiveness, override rates, and maintenance compliance for clinical decision support optimization."
  source: "`healthcare_ecm_v1`.`order`.`alert_rule`"
  dimensions:
    - name: "rule_category"
      expr: rule_category
      comment: "Category of alert rule (drug interaction, allergy, dose check, duplicate) for portfolio analysis"
    - name: "rule_status"
      expr: rule_status
      comment: "Current rule status (active, retired, under review) for governance tracking"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the rule for risk-based prioritization"
    - name: "hard_stop_flag"
      expr: CAST(hard_stop_flag AS STRING)
      comment: "Whether rule is a hard stop (cannot be overridden) vs soft alert"
    - name: "evidence_strength_level"
      expr: evidence_strength_level
      comment: "Evidence strength supporting the rule for clinical validity assessment"
    - name: "override_allowed_flag"
      expr: CAST(override_allowed_flag AS STRING)
      comment: "Whether override is permitted - governance control indicator"
    - name: "regulatory_requirement_flag"
      expr: CAST(regulatory_requirement_flag AS STRING)
      comment: "Whether rule is regulatory-mandated vs best practice"
  measures:
    - name: "total_active_rules"
      expr: COUNT(1)
      comment: "Total alert rules in the system - CDS portfolio size metric"
    - name: "total_fire_count"
      expr: SUM(CAST(fire_count_total AS DOUBLE))
      comment: "Total times all rules have fired - aggregate alert burden on clinicians"
    - name: "total_override_count"
      expr: SUM(CAST(override_count_total AS DOUBLE))
      comment: "Total overrides across all rules - aggregate alert fatigue indicator"
    - name: "avg_override_rate"
      expr: AVG(CAST(override_rate_percent AS DOUBLE))
      comment: "Average override rate across rules - rules above 90% override rate should be retired or modified"
    - name: "avg_fatigue_risk_score"
      expr: AVG(CAST(alert_fatigue_risk_score AS DOUBLE))
      comment: "Average alert fatigue risk score - composite indicator for CDS committee review"
    - name: "hard_stop_rule_count"
      expr: COUNT(CASE WHEN hard_stop_flag = TRUE THEN 1 END)
      comment: "Number of hard-stop rules - these have highest patient safety impact"
    - name: "regulatory_rule_count"
      expr: COUNT(CASE WHEN regulatory_requirement_flag = TRUE THEN 1 END)
      comment: "Regulatory-mandated rules - cannot be retired without compliance review"
$$;