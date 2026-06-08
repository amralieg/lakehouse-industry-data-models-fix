-- Metric views for domain: compliance | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 03:36:32

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance audit performance and outcome metrics tracking audit efficiency, findings severity, and corrective action management across port facilities and vessels"
  source: "`shipping_ports_ecm`.`compliance`.`compliance_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of compliance audit conducted (ISPS, MARPOL, customs, safety, etc.)"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (scheduled, in-progress, completed, closed)"
    - name: "audit_scope"
      expr: audit_scope
      comment: "Scope of the audit engagement"
    - name: "auditing_body_type"
      expr: auditing_body_type
      comment: "Type of auditing organization (internal, external, regulatory, classification society)"
    - name: "overall_audit_outcome"
      expr: overall_audit_outcome
      comment: "Final outcome classification of the audit (pass, pass with observations, fail, conditional)"
    - name: "audit_year"
      expr: YEAR(start_date)
      comment: "Year the audit was initiated"
    - name: "audit_quarter"
      expr: CONCAT('Q', QUARTER(start_date))
      comment: "Quarter the audit was initiated"
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the audit was initiated"
    - name: "detention_issued"
      expr: detention_issued_flag
      comment: "Whether a detention was issued as a result of the audit"
    - name: "psc_inspection"
      expr: psc_inspection_flag
      comment: "Whether this was a Port State Control inspection"
    - name: "follow_up_required"
      expr: follow_up_audit_required_flag
      comment: "Whether a follow-up audit is required"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of compliance audits conducted"
    - name: "total_audit_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of compliance audits in local currency"
    - name: "avg_audit_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per compliance audit"
    - name: "total_audit_duration_days"
      expr: SUM(CAST(duration_days AS DOUBLE))
      comment: "Total duration of all audits in days"
    - name: "avg_audit_duration_days"
      expr: AVG(CAST(duration_days AS DOUBLE))
      comment: "Average duration per audit in days"
    - name: "total_major_findings"
      expr: COUNT(CASE WHEN major_findings_count IS NOT NULL AND major_findings_count != '0' THEN 1 END)
      comment: "Count of audits with major findings reported"
    - name: "total_psc_deficiencies"
      expr: COUNT(CASE WHEN psc_deficiency_count IS NOT NULL AND psc_deficiency_count != '0' THEN 1 END)
      comment: "Count of audits with PSC deficiencies identified"
    - name: "detention_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN detention_issued_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits resulting in detention orders"
    - name: "follow_up_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_audit_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring follow-up action"
    - name: "psc_inspection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN psc_inspection_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits that were PSC inspections"
    - name: "unique_audited_vessels"
      expr: COUNT(DISTINCT vessel_master_id)
      comment: "Number of unique vessels audited"
    - name: "unique_audited_locations"
      expr: COUNT(DISTINCT port_location_id)
      comment: "Number of unique port locations audited"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`compliance_customs_declaration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customs declaration processing efficiency and value metrics tracking clearance performance, duty collection, and declaration outcomes"
  source: "`shipping_ports_ecm`.`compliance`.`customs_declaration`"
  dimensions:
    - name: "declaration_type"
      expr: declaration_type
      comment: "Type of customs declaration (import, export, transit, re-export)"
    - name: "declaration_status"
      expr: declaration_status
      comment: "Current processing status of the declaration"
    - name: "customs_regime"
      expr: customs_regime
      comment: "Customs regime applied to the declaration"
    - name: "country_of_destination"
      expr: country_of_destination
      comment: "Destination country for the goods"
    - name: "sanctions_screening_status"
      expr: sanctions_screening_status
      comment: "Result of sanctions screening for the declaration"
    - name: "submission_year"
      expr: YEAR(submission_timestamp)
      comment: "Year the declaration was submitted"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month the declaration was submitted"
    - name: "clearance_year"
      expr: YEAR(clearance_timestamp)
      comment: "Year the declaration was cleared"
    - name: "clearance_month"
      expr: DATE_TRUNC('MONTH', clearance_timestamp)
      comment: "Month the declaration was cleared"
    - name: "psc_inspection_required"
      expr: psc_inspection_required
      comment: "Whether PSC inspection was required for this declaration"
    - name: "fal_form_3_compliant"
      expr: fal_form_3_compliant
      comment: "Whether declaration is compliant with FAL Form 3 standards"
  measures:
    - name: "total_declarations"
      expr: COUNT(1)
      comment: "Total number of customs declarations processed"
    - name: "total_declared_value"
      expr: SUM(CAST(declared_value_amount AS DOUBLE))
      comment: "Total declared value of goods across all declarations"
    - name: "avg_declared_value"
      expr: AVG(CAST(declared_value_amount AS DOUBLE))
      comment: "Average declared value per declaration"
    - name: "total_duty_collected"
      expr: SUM(CAST(duty_amount AS DOUBLE))
      comment: "Total customs duty collected across all declarations"
    - name: "avg_duty_per_declaration"
      expr: AVG(CAST(duty_amount AS DOUBLE))
      comment: "Average duty amount per declaration"
    - name: "total_vat_collected"
      expr: SUM(CAST(vat_amount AS DOUBLE))
      comment: "Total VAT collected on customs declarations"
    - name: "total_other_charges"
      expr: SUM(CAST(other_charges_amount AS DOUBLE))
      comment: "Total other charges collected (handling, processing, etc.)"
    - name: "total_charges_collected"
      expr: SUM(CAST(total_charges_amount AS DOUBLE))
      comment: "Total of all charges collected (duty + VAT + other)"
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight of declared goods in kilograms"
    - name: "total_net_weight_kg"
      expr: SUM(CAST(net_weight_kg AS DOUBLE))
      comment: "Total net weight of declared goods in kilograms"
    - name: "avg_gross_weight_kg"
      expr: AVG(CAST(gross_weight_kg AS DOUBLE))
      comment: "Average gross weight per declaration in kilograms"
    - name: "effective_duty_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(duty_amount AS DOUBLE)) / NULLIF(SUM(CAST(declared_value_amount AS DOUBLE)), 0), 2)
      comment: "Effective duty rate as percentage of declared value"
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rejection_reason IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of declarations rejected"
    - name: "unique_customs_brokers"
      expr: COUNT(DISTINCT customs_broker_id)
      comment: "Number of unique customs brokers filing declarations"
    - name: "unique_vessels"
      expr: COUNT(DISTINCT vessel_master_id)
      comment: "Number of unique vessels associated with declarations"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`compliance_customs_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customs hold and detention metrics tracking cargo delays, inspection efficiency, and release performance impacting port throughput and customer service"
  source: "`shipping_ports_ecm`.`compliance`.`customs_hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the customs hold (active, released, escalated, seized)"
    - name: "hold_type"
      expr: hold_type
      comment: "Type of customs hold applied"
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Standardized code for the reason the hold was placed"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the hold resolution"
    - name: "placed_by_authority"
      expr: placed_by_authority
      comment: "Authority that placed the customs hold"
    - name: "hold_placement_year"
      expr: YEAR(hold_placement_timestamp)
      comment: "Year the hold was placed"
    - name: "hold_placement_month"
      expr: DATE_TRUNC('MONTH', hold_placement_timestamp)
      comment: "Month the hold was placed"
    - name: "demurrage_applicable"
      expr: demurrage_applicable_flag
      comment: "Whether demurrage charges apply to this hold"
    - name: "detention_applicable"
      expr: detention_applicable_flag
      comment: "Whether detention charges apply to this hold"
    - name: "psc_inspection"
      expr: psc_inspection_flag
      comment: "Whether this hold involves PSC inspection"
    - name: "seizure_occurred"
      expr: seizure_flag
      comment: "Whether the cargo was seized"
    - name: "sanctions_screening_result"
      expr: sanctions_screening_result
      comment: "Result of sanctions screening that may have triggered the hold"
  measures:
    - name: "total_holds"
      expr: COUNT(1)
      comment: "Total number of customs holds placed"
    - name: "total_actual_delay_hours"
      expr: SUM(CAST(actual_delay_duration_hours AS DOUBLE))
      comment: "Total actual delay time caused by customs holds in hours"
    - name: "avg_actual_delay_hours"
      expr: AVG(CAST(actual_delay_duration_hours AS DOUBLE))
      comment: "Average actual delay duration per hold in hours"
    - name: "total_estimated_delay_hours"
      expr: SUM(CAST(estimated_delay_duration_hours AS DOUBLE))
      comment: "Total estimated delay time for customs holds in hours"
    - name: "avg_estimated_delay_hours"
      expr: AVG(CAST(estimated_delay_duration_hours AS DOUBLE))
      comment: "Average estimated delay duration per hold in hours"
    - name: "hold_release_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hold_release_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds that have been released"
    - name: "seizure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN seizure_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds resulting in cargo seizure"
    - name: "demurrage_applicable_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN demurrage_applicable_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds where demurrage charges apply"
    - name: "detention_applicable_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN detention_applicable_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds where detention charges apply"
    - name: "inspection_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_completed_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds where inspection has been completed"
    - name: "notification_sent_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN notification_sent_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds where notification was sent to stakeholders"
    - name: "unique_customs_declarations"
      expr: COUNT(DISTINCT customs_declaration_id)
      comment: "Number of unique customs declarations subject to holds"
    - name: "unique_port_locations"
      expr: COUNT(DISTINCT port_location_id)
      comment: "Number of unique port locations where holds were placed"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`compliance_sanctions_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sanctions screening effectiveness and risk detection metrics tracking screening outcomes, match rates, and resolution efficiency for trade compliance"
  source: "`shipping_ports_ecm`.`compliance`.`sanctions_screening`"
  dimensions:
    - name: "screening_status"
      expr: screening_status
      comment: "Current status of the sanctions screening process"
    - name: "match_status"
      expr: match_status
      comment: "Whether a match was found against sanctions lists (match, no-match, potential-match)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned based on screening results (high, medium, low)"
    - name: "screened_entity_type"
      expr: screened_entity_type
      comment: "Type of entity screened (vessel, company, individual, cargo)"
    - name: "screening_trigger_event"
      expr: screening_trigger_event
      comment: "Event that triggered the sanctions screening"
    - name: "analyst_review_status"
      expr: analyst_review_status
      comment: "Status of analyst review for potential matches"
    - name: "resolution_action"
      expr: resolution_action
      comment: "Action taken to resolve the screening (cleared, escalated, blocked)"
    - name: "screening_year"
      expr: YEAR(screening_timestamp)
      comment: "Year the screening was performed"
    - name: "screening_month"
      expr: DATE_TRUNC('MONTH', screening_timestamp)
      comment: "Month the screening was performed"
    - name: "is_high_risk_cargo"
      expr: is_high_risk_cargo
      comment: "Whether the cargo was flagged as high-risk"
    - name: "vessel_flag_state"
      expr: vessel_flag_state
      comment: "Flag state of the vessel being screened"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the goods or entity"
    - name: "country_of_destination"
      expr: country_of_destination
      comment: "Country of destination for the goods"
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total number of sanctions screenings performed"
    - name: "total_matches"
      expr: COUNT(CASE WHEN match_status = 'match' THEN 1 END)
      comment: "Total number of screenings resulting in a positive match"
    - name: "match_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN match_status = 'match' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings resulting in a sanctions list match"
    - name: "high_risk_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_level = 'high' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings classified as high risk"
    - name: "high_risk_cargo_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_high_risk_cargo = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings involving high-risk cargo"
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalated_to_authority IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings escalated to authorities"
    - name: "resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN resolution_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings that have been resolved"
    - name: "avg_match_score"
      expr: AVG(CAST(match_score AS DOUBLE))
      comment: "Average match score across all screenings (confidence level)"
    - name: "unique_screened_vessels"
      expr: COUNT(DISTINCT vessel_master_id)
      comment: "Number of unique vessels screened"
    - name: "unique_screened_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors screened"
    - name: "unique_screened_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of unique employees screened"
    - name: "unique_vessel_calls"
      expr: COUNT(DISTINCT vessel_call_id)
      comment: "Number of unique vessel calls screened"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`compliance_violation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance violation tracking and penalty metrics measuring regulatory breach frequency, severity, financial impact, and corrective action effectiveness"
  source: "`shipping_ports_ecm`.`compliance`.`violation`"
  dimensions:
    - name: "violation_type"
      expr: violation_type
      comment: "Type of compliance violation (safety, environmental, customs, security, operational)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the violation (critical, major, minor)"
    - name: "case_status"
      expr: case_status
      comment: "Current status of the violation case (open, under investigation, closed, appealed)"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework under which the violation occurred (ISPS, MARPOL, customs, OSHA)"
    - name: "detection_method"
      expr: detection_method
      comment: "Method by which the violation was detected (inspection, audit, self-report, monitoring)"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action implementation"
    - name: "penalty_payment_status"
      expr: penalty_payment_status
      comment: "Payment status of assessed penalties"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Level to which the violation has been escalated"
    - name: "detection_year"
      expr: YEAR(detection_timestamp)
      comment: "Year the violation was detected"
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detection_timestamp)
      comment: "Month the violation was detected"
    - name: "recurrence"
      expr: recurrence_flag
      comment: "Whether this is a recurring violation"
    - name: "associated_entity_type"
      expr: associated_entity_type
      comment: "Type of entity associated with the violation (vessel, facility, employee, vendor)"
  measures:
    - name: "total_violations"
      expr: COUNT(1)
      comment: "Total number of compliance violations recorded"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalties assessed for violations"
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per violation"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across all violations"
    - name: "critical_violations"
      expr: COUNT(CASE WHEN severity_level = 'critical' THEN 1 END)
      comment: "Number of critical severity violations"
    - name: "critical_violation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN severity_level = 'critical' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of violations classified as critical"
    - name: "recurrence_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of violations that are recurring"
    - name: "corrective_action_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_completion_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of violations with completed corrective actions"
    - name: "case_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN case_closure_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of violation cases that have been closed"
    - name: "penalty_payment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN penalty_payment_status = 'paid' THEN 1 END) / NULLIF(COUNT(CASE WHEN penalty_amount IS NOT NULL AND penalty_amount > 0 THEN 1 END), 0), 2)
      comment: "Percentage of assessed penalties that have been paid"
    - name: "unique_violating_vessels"
      expr: COUNT(DISTINCT vessel_master_id)
      comment: "Number of unique vessels with recorded violations"
    - name: "unique_violating_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors with recorded violations"
    - name: "unique_port_locations"
      expr: COUNT(DISTINCT port_location_id)
      comment: "Number of unique port locations where violations occurred"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`compliance_marpol_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MARPOL environmental compliance metrics tracking waste disposal, emissions, ballast water management, and environmental regulatory adherence for vessels and port facilities"
  source: "`shipping_ports_ecm`.`compliance`.`marpol_record`"
  dimensions:
    - name: "marpol_annex"
      expr: marpol_annex
      comment: "MARPOL annex under which the operation is recorded (I-VI covering oil, noxious substances, sewage, garbage, air pollution, ballast water)"
    - name: "operation_type"
      expr: operation_type
      comment: "Type of MARPOL operation (discharge, reception, transfer, treatment)"
    - name: "waste_type"
      expr: waste_type
      comment: "Type of waste handled (oily waste, sewage, garbage, noxious liquid, etc.)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the operation (compliant, non-compliant, under review)"
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method used for waste disposal or treatment"
    - name: "ballast_water_management_method"
      expr: ballast_water_management_method
      comment: "Method used for ballast water management (exchange, treatment, none)"
    - name: "cii_rating"
      expr: cii_rating
      comment: "Carbon Intensity Indicator rating (A, B, C, D, E)"
    - name: "operation_year"
      expr: YEAR(operation_timestamp)
      comment: "Year the MARPOL operation occurred"
    - name: "operation_month"
      expr: DATE_TRUNC('MONTH', operation_timestamp)
      comment: "Month the MARPOL operation occurred"
    - name: "port_authority_endorsed"
      expr: port_authority_endorsement_flag
      comment: "Whether the operation was endorsed by port authority"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required for non-compliance"
  measures:
    - name: "total_operations"
      expr: COUNT(1)
      comment: "Total number of MARPOL operations recorded"
    - name: "total_waste_mass_mt"
      expr: SUM(CAST(quantity_mass_mt AS DOUBLE))
      comment: "Total mass of waste handled in metric tons"
    - name: "avg_waste_mass_mt"
      expr: AVG(CAST(quantity_mass_mt AS DOUBLE))
      comment: "Average mass of waste per operation in metric tons"
    - name: "total_waste_volume_m3"
      expr: SUM(CAST(quantity_volume_m3 AS DOUBLE))
      comment: "Total volume of waste handled in cubic meters"
    - name: "avg_waste_volume_m3"
      expr: AVG(CAST(quantity_volume_m3 AS DOUBLE))
      comment: "Average volume of waste per operation in cubic meters"
    - name: "total_nox_emissions_mt"
      expr: SUM(CAST(nox_emissions_mt AS DOUBLE))
      comment: "Total nitrogen oxide emissions in metric tons"
    - name: "total_sox_emissions_mt"
      expr: SUM(CAST(sox_emissions_mt AS DOUBLE))
      comment: "Total sulfur oxide emissions in metric tons"
    - name: "total_particulate_emissions_mt"
      expr: SUM(CAST(particulate_matter_emissions_mt AS DOUBLE))
      comment: "Total particulate matter emissions in metric tons"
    - name: "avg_eedi_value"
      expr: AVG(CAST(eedi_value AS DOUBLE))
      comment: "Average Energy Efficiency Design Index value"
    - name: "avg_eexi_value"
      expr: AVG(CAST(eexi_value AS DOUBLE))
      comment: "Average Energy Efficiency Existing Ship Index value"
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of MARPOL operations in compliance"
    - name: "non_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'non-compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of MARPOL operations with non-compliance"
    - name: "port_authority_endorsement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN port_authority_endorsement_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of operations endorsed by port authority"
    - name: "corrective_action_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_completion_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN corrective_action_required IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of required corrective actions that have been completed"
    - name: "unique_vessels"
      expr: COUNT(DISTINCT vessel_master_id)
      comment: "Number of unique vessels with MARPOL operations recorded"
    - name: "unique_port_locations"
      expr: COUNT(DISTINCT port_location_id)
      comment: "Number of unique port locations where MARPOL operations occurred"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`compliance_isps_facility_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ISPS facility security compliance metrics tracking security levels, alerts, PSC inspection outcomes, and Declaration of Security management for port facilities"
  source: "`shipping_ports_ecm`.`compliance`.`isps_facility_record`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of port facility (container terminal, bulk terminal, passenger terminal, etc.)"
    - name: "current_security_level"
      expr: current_security_level
      comment: "Current ISPS security level (1, 2, or 3)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "ISPS compliance status of the facility"
    - name: "alert_type"
      expr: alert_type
      comment: "Type of security alert if applicable"
    - name: "alert_severity"
      expr: alert_severity
      comment: "Severity level of security alert"
    - name: "dos_type"
      expr: dos_type
      comment: "Type of Declaration of Security (ship-to-port, ship-to-ship)"
    - name: "last_psc_inspection_result"
      expr: last_psc_inspection_result
      comment: "Result of the most recent PSC inspection"
    - name: "security_level_effective_year"
      expr: YEAR(security_level_effective_date)
      comment: "Year the current security level became effective"
    - name: "security_level_effective_month"
      expr: DATE_TRUNC('MONTH', security_level_effective_date)
      comment: "Month the current security level became effective"
    - name: "alert_issued_year"
      expr: YEAR(alert_issued_timestamp)
      comment: "Year the security alert was issued"
    - name: "alert_issued_month"
      expr: DATE_TRUNC('MONTH', alert_issued_timestamp)
      comment: "Month the security alert was issued"
  measures:
    - name: "total_facility_records"
      expr: COUNT(1)
      comment: "Total number of ISPS facility records"
    - name: "total_security_alerts"
      expr: COUNT(CASE WHEN alert_type IS NOT NULL THEN 1 END)
      comment: "Total number of security alerts issued"
    - name: "alert_resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN alert_resolution_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN alert_issued_timestamp IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of security alerts that have been resolved"
    - name: "high_severity_alert_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN alert_severity = 'high' THEN 1 END) / NULLIF(COUNT(CASE WHEN alert_severity IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of alerts classified as high severity"
    - name: "security_level_3_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN current_security_level = '3' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities at security level 3 (highest)"
    - name: "psc_deficiency_rate"
      expr: AVG(CAST(psc_deficiency_count AS DOUBLE))
      comment: "Average number of PSC deficiencies per facility"
    - name: "audit_overdue_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN next_audit_due_date < CURRENT_DATE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities with overdue security audits"
    - name: "unique_port_locations"
      expr: COUNT(DISTINCT port_location_id)
      comment: "Number of unique port locations with ISPS facility records"
    - name: "unique_terminal_zones"
      expr: COUNT(DISTINCT terminal_zone_id)
      comment: "Number of unique terminal zones covered by ISPS records"
    - name: "unique_pfso_employees"
      expr: COUNT(DISTINCT pfso_employee_id)
      comment: "Number of unique Port Facility Security Officers"
$$;