-- Metric views for domain: compliance | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 06:46:03

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Governance and audit performance metrics covering audit outcomes, findings severity, corrective action follow-through, detention rates, and cost of compliance audits. Used by Port Compliance Officers and C-suite to steer audit programme effectiveness and regulatory risk posture."
  source: "`shipping_ports_ecm`.`compliance`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Classification of the audit (e.g. PSC Inspection, Internal, Flag State, ISM) enabling performance comparison across audit programmes."
    - name: "audit_status"
      expr: audit_status
      comment: "Current lifecycle status of the audit (e.g. Open, Closed, In Progress) for pipeline and backlog analysis."
    - name: "overall_audit_outcome"
      expr: overall_audit_outcome
      comment: "Final outcome of the audit (e.g. Pass, Fail, Conditional Pass) used to track compliance health trends."
    - name: "auditing_body_type"
      expr: auditing_body_type
      comment: "Type of auditing body (e.g. Flag State Authority, Classification Society, Internal) for benchmarking across oversight bodies."
    - name: "audit_scope"
      expr: audit_scope
      comment: "Scope of the audit (e.g. Safety Management, Environmental, Security) to identify which compliance domains drive the most findings."
    - name: "psc_inspection_flag"
      expr: psc_inspection_flag
      comment: "Indicates whether the audit was a Port State Control inspection, enabling PSC-specific performance tracking."
    - name: "detention_issued_flag"
      expr: detention_issued_flag
      comment: "Indicates whether a vessel detention was issued as a result of the audit — a critical regulatory risk signal."
    - name: "follow_up_audit_required_flag"
      expr: follow_up_audit_required_flag
      comment: "Flags audits requiring follow-up, used to track unresolved compliance gaps."
    - name: "audit_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the audit commenced, enabling trend analysis of audit volumes and outcomes over time."
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency of the audit cost, required for multi-currency cost aggregation context."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audits conducted. Baseline volume metric for audit programme throughput and workload planning."
    - name: "detention_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN detention_issued_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits resulting in vessel detention. A critical PSC KPI — high detention rates signal systemic compliance failures and damage port reputation with flag states."
    - name: "follow_up_audit_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN follow_up_audit_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring a follow-up audit. Measures the rate of unresolved compliance deficiencies — a leading indicator of systemic non-compliance risk."
    - name: "psc_inspection_count"
      expr: SUM(CASE WHEN psc_inspection_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of Port State Control inspections. PSC inspections are the most consequential external audits; tracking volume informs regulatory engagement strategy."
    - name: "total_audit_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total monetary cost of all audits. Directly informs compliance budget allocation and cost-of-quality analysis."
    - name: "avg_audit_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per audit. Benchmarks audit efficiency and identifies outlier audit types driving disproportionate spend."
    - name: "avg_audit_duration_days"
      expr: AVG(CAST(duration_days AS DOUBLE))
      comment: "Average duration of audits in days. Longer audits may indicate complex findings or resource constraints — used to optimise audit scheduling."
    - name: "management_response_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN management_response_received_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits for which management has submitted a formal response. Low rates indicate governance gaps in corrective action accountability."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`compliance_customs_declaration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customs clearance performance and trade compliance metrics covering declaration throughput, duty and tax revenue, clearance cycle times, and sanctions screening outcomes. Used by Customs Compliance Managers and Port Directors to monitor trade facilitation efficiency and regulatory adherence."
  source: "`shipping_ports_ecm`.`compliance`.`customs_declaration`"
  dimensions:
    - name: "declaration_type"
      expr: declaration_type
      comment: "Type of customs declaration (e.g. Import, Export, Transit) for trade flow analysis."
    - name: "declaration_status"
      expr: declaration_status
      comment: "Current status of the declaration (e.g. Submitted, Cleared, Rejected, Under Review) for pipeline monitoring."
    - name: "customs_regime"
      expr: customs_regime
      comment: "Customs procedure regime (e.g. Home Use, Warehousing, Temporary Admission) for regime-level compliance analysis."
    - name: "sanctions_screening_status"
      expr: sanctions_screening_status
      comment: "Outcome of sanctions screening on the declaration (e.g. Clear, Flagged, Pending) — critical for trade compliance risk management."
    - name: "country_of_destination"
      expr: country_of_destination
      comment: "Destination country of the shipment, enabling trade lane and sanctions risk analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "International commercial terms governing the shipment, used for trade finance and liability analysis."
    - name: "fal_form_3_compliant"
      expr: fal_form_3_compliant
      comment: "Indicates FAL Form 3 (Cargo Declaration) compliance — an IMO FAL Convention requirement for port clearance."
    - name: "psc_inspection_required"
      expr: psc_inspection_required
      comment: "Flags declarations requiring PSC inspection, used to forecast inspection workload."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of declaration submission for trend analysis of trade volumes and clearance performance."
    - name: "declared_value_currency"
      expr: declared_value_currency
      comment: "Currency of the declared cargo value, required for multi-currency trade value aggregation context."
  measures:
    - name: "total_declarations"
      expr: COUNT(1)
      comment: "Total number of customs declarations submitted. Core throughput metric for trade facilitation capacity planning."
    - name: "total_declared_value"
      expr: SUM(CAST(declared_value_amount AS DOUBLE))
      comment: "Total declared cargo value across all declarations. Represents the economic throughput of the port and is a key indicator for trade volume and duty revenue potential."
    - name: "total_duty_collected"
      expr: SUM(CAST(duty_amount AS DOUBLE))
      comment: "Total customs duty assessed across all declarations. Directly measures fiscal compliance revenue and informs duty recovery performance."
    - name: "total_vat_collected"
      expr: SUM(CAST(vat_amount AS DOUBLE))
      comment: "Total VAT assessed on declarations. Key fiscal metric for customs authority reporting and port revenue contribution."
    - name: "total_charges"
      expr: SUM(CAST(total_charges_amount AS DOUBLE))
      comment: "Total customs-related charges across all declarations. Used for cost-of-trade analysis and fee revenue tracking."
    - name: "avg_declared_value_per_declaration"
      expr: AVG(CAST(declared_value_amount AS DOUBLE))
      comment: "Average declared cargo value per declaration. Benchmarks cargo value density and identifies shifts in trade mix (high-value vs. bulk)."
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN declaration_status = 'Rejected' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of declarations rejected by customs. High rejection rates signal documentation quality issues or broker non-compliance, directly impacting cargo dwell time and port efficiency."
    - name: "sanctions_flagged_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sanctions_screening_status = 'Flagged' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of declarations flagged during sanctions screening. A critical trade compliance risk KPI — elevated rates trigger regulatory escalation and reputational risk."
    - name: "avg_gross_weight_kg"
      expr: AVG(CAST(gross_weight_kg AS DOUBLE))
      comment: "Average gross cargo weight per declaration in kilograms. Used for capacity planning and cross-checking declared vs. physical weights."
    - name: "fal_non_compliance_count"
      expr: SUM(CASE WHEN fal_form_3_compliant = FALSE THEN 1 ELSE 0 END)
      comment: "Count of declarations not compliant with FAL Form 3 requirements. Non-compliance with IMO FAL Convention obligations can result in port state sanctions."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`compliance_customs_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customs hold management metrics tracking hold volumes, delay durations, demurrage exposure, seizure rates, and release performance. Used by Port Operations and Compliance Directors to minimise cargo dwell time, reduce demurrage liability, and manage regulatory hold risk."
  source: "`shipping_ports_ecm`.`compliance`.`customs_hold`"
  dimensions:
    - name: "hold_type"
      expr: hold_type
      comment: "Type of customs hold (e.g. Documentary, Physical Examination, Sanctions, Prohibited Goods) for root-cause analysis."
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the hold (e.g. Active, Released, Escalated) for real-time hold pipeline management."
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Standardised reason code for the hold placement, enabling Pareto analysis of hold causes."
    - name: "placed_by_authority"
      expr: placed_by_authority
      comment: "Authority that placed the hold (e.g. Customs, Port Health, ISPS Security) for inter-agency workload analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the hold for resolution, used to assess whether high-priority holds are resolved faster."
    - name: "demurrage_applicable_flag"
      expr: demurrage_applicable_flag
      comment: "Indicates whether demurrage charges apply to the held cargo — directly links hold duration to financial liability."
    - name: "detention_applicable_flag"
      expr: detention_applicable_flag
      comment: "Indicates whether container detention charges apply, adding to the financial cost of the hold."
    - name: "seizure_flag"
      expr: seizure_flag
      comment: "Indicates whether the cargo was seized, representing the most severe hold outcome."
    - name: "psc_inspection_flag"
      expr: psc_inspection_flag
      comment: "Indicates whether the hold is associated with a PSC inspection, linking hold activity to port state control performance."
    - name: "hold_placement_month"
      expr: DATE_TRUNC('MONTH', hold_placement_timestamp)
      comment: "Month the hold was placed, enabling trend analysis of hold volumes and seasonal patterns."
  measures:
    - name: "total_holds"
      expr: COUNT(1)
      comment: "Total number of customs holds placed. Core volume metric for hold management workload and regulatory activity intensity."
    - name: "active_holds"
      expr: SUM(CASE WHEN hold_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of currently active holds. Real-time operational metric for hold resolution backlog management."
    - name: "seizure_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN seizure_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds resulting in cargo seizure. Seizures represent the most severe compliance outcome — high rates signal systemic contraband or sanctions violations."
    - name: "demurrage_exposure_hold_count"
      expr: SUM(CASE WHEN demurrage_applicable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of holds with demurrage charges applicable. Directly quantifies the financial liability exposure from customs holds to cargo owners and the port."
    - name: "avg_actual_delay_hours"
      expr: AVG(CAST(actual_delay_duration_hours AS DOUBLE))
      comment: "Average actual delay in hours caused by customs holds. A key port efficiency KPI — excessive hold delays degrade port throughput and customer satisfaction."
    - name: "total_actual_delay_hours"
      expr: SUM(CAST(actual_delay_duration_hours AS DOUBLE))
      comment: "Total hours of delay caused by all customs holds. Aggregates the full operational impact of holds on port throughput."
    - name: "delay_overrun_hours"
      expr: SUM(CAST(actual_delay_duration_hours AS DOUBLE) - CAST(estimated_delay_duration_hours AS DOUBLE))
      comment: "Total hours by which actual hold delays exceeded estimates. Positive overrun indicates systematic underestimation of hold complexity, impacting berth scheduling and demurrage forecasting."
    - name: "avg_estimated_delay_hours"
      expr: AVG(CAST(estimated_delay_duration_hours AS DOUBLE))
      comment: "Average estimated delay duration for holds. Used to benchmark estimation accuracy against actual delay outcomes."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`compliance_violation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory violation tracking metrics covering violation volumes, severity distribution, penalty revenue, corrective action compliance, and recurrence rates. Used by Port Compliance Directors and Regulatory Affairs teams to manage enforcement risk, penalty exposure, and systemic non-compliance patterns."
  source: "`shipping_ports_ecm`.`compliance`.`violation`"
  dimensions:
    - name: "violation_type"
      expr: violation_type
      comment: "Category of regulatory violation (e.g. MARPOL, ISPS, Customs, SOLAS) for domain-specific compliance risk analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the violation (e.g. Critical, Major, Minor) for risk-weighted prioritisation."
    - name: "case_status"
      expr: case_status
      comment: "Current status of the violation case (e.g. Open, Closed, Under Investigation) for enforcement pipeline management."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework under which the violation was raised (e.g. IMO, MARPOL, WCO) for framework-level compliance benchmarking."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of the corrective action plan (e.g. Pending, In Progress, Completed) for remediation tracking."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Level to which the violation has been escalated (e.g. Internal, Port Authority, Flag State) indicating regulatory severity."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Indicates whether the violation is a repeat occurrence — recurrent violations signal systemic non-compliance and attract heightened regulatory scrutiny."
    - name: "penalty_payment_status"
      expr: penalty_payment_status
      comment: "Status of penalty payment (e.g. Paid, Outstanding, Disputed) for financial recovery tracking."
    - name: "detection_method"
      expr: detection_method
      comment: "Method by which the violation was detected (e.g. Inspection, System Alert, Whistleblower) for detection effectiveness analysis."
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detection_timestamp)
      comment: "Month the violation was detected, enabling trend analysis of violation rates and seasonal compliance patterns."
  measures:
    - name: "total_violations"
      expr: COUNT(1)
      comment: "Total number of regulatory violations recorded. Core compliance health metric — rising violation counts trigger regulatory intervention and reputational risk."
    - name: "critical_violation_count"
      expr: SUM(CASE WHEN severity_level = 'Critical' THEN 1 ELSE 0 END)
      comment: "Count of critical severity violations. Critical violations carry the highest penalty and detention risk — a key executive risk indicator."
    - name: "recurrence_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN recurrence_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of violations that are repeat occurrences. High recurrence rates indicate that corrective actions are ineffective — a leading indicator of systemic compliance failure."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total monetary penalties assessed across all violations. Directly measures the financial cost of non-compliance and informs risk-based compliance investment decisions."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty per violation. Benchmarks penalty severity and identifies violation types with disproportionate financial impact."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across violations. Composite risk metric used to prioritise enforcement resources and corrective action investment."
    - name: "corrective_action_overdue_count"
      expr: SUM(CASE WHEN corrective_action_status != 'Completed' AND corrective_action_deadline < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of violations where corrective action is overdue. Overdue corrective actions escalate regulatory risk and can trigger additional penalties or detention."
    - name: "open_case_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN case_status = 'Open' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of violation cases still open. High open rates indicate enforcement backlog and unresolved compliance risk exposure."
    - name: "penalty_outstanding_amount"
      expr: SUM(CASE WHEN penalty_payment_status = 'Outstanding' THEN CAST(penalty_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of unpaid penalties. Represents outstanding financial liability from non-compliance — a key accounts receivable and regulatory risk metric."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`compliance_marpol_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental compliance metrics under MARPOL convention covering emissions volumes, waste disposal operations, ballast water management, and compliance status. Used by Environmental Compliance Officers and Port Directors to manage IMO environmental obligations, CII ratings, and port environmental performance."
  source: "`shipping_ports_ecm`.`compliance`.`marpol_record`"
  dimensions:
    - name: "marpol_annex"
      expr: marpol_annex
      comment: "MARPOL Annex under which the record falls (e.g. Annex I Oil, Annex IV Sewage, Annex VI Air Pollution) for annex-level compliance tracking."
    - name: "operation_type"
      expr: operation_type
      comment: "Type of MARPOL-regulated operation (e.g. Waste Discharge, Ballast Water Exchange, Bunker Operation) for operational compliance analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the MARPOL record (e.g. Compliant, Non-Compliant, Under Review) — the primary environmental compliance health indicator."
    - name: "waste_type"
      expr: waste_type
      comment: "Type of waste managed (e.g. Oily Water, Garbage, Sewage) for waste stream analysis and reception facility planning."
    - name: "cii_rating"
      expr: cii_rating
      comment: "IMO Carbon Intensity Indicator rating (A-E) of the vessel at time of operation — a mandatory IMO 2023 decarbonisation metric."
    - name: "port_authority_endorsement_flag"
      expr: port_authority_endorsement_flag
      comment: "Indicates whether the port authority has endorsed the MARPOL record — required for regulatory filing completeness."
    - name: "ballast_water_management_method"
      expr: ballast_water_management_method
      comment: "Method used for ballast water management (e.g. Exchange, Treatment System) for BWM Convention compliance analysis."
    - name: "operation_month"
      expr: DATE_TRUNC('MONTH', operation_timestamp)
      comment: "Month of the MARPOL-regulated operation for trend analysis of environmental compliance and emissions over time."
  measures:
    - name: "total_marpol_records"
      expr: COUNT(1)
      comment: "Total number of MARPOL records. Baseline metric for environmental compliance activity volume and record-keeping completeness."
    - name: "non_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of MARPOL records with non-compliant status. A critical environmental KPI — non-compliance with MARPOL exposes the port and vessels to PSC detention and flag state sanctions."
    - name: "total_nox_emissions_mt"
      expr: SUM(CAST(nox_emissions_mt AS DOUBLE))
      comment: "Total NOx emissions in metric tonnes across all MARPOL records. Mandatory MARPOL Annex VI reporting metric for air quality compliance and IMO decarbonisation targets."
    - name: "total_sox_emissions_mt"
      expr: SUM(CAST(sox_emissions_mt AS DOUBLE))
      comment: "Total SOx emissions in metric tonnes. MARPOL Annex VI SOx cap compliance metric — critical for Emission Control Area (ECA) adherence."
    - name: "total_particulate_matter_emissions_mt"
      expr: SUM(CAST(particulate_matter_emissions_mt AS DOUBLE))
      comment: "Total particulate matter emissions in metric tonnes. Environmental health metric for port community air quality management and regulatory reporting."
    - name: "avg_eedi_value"
      expr: AVG(CAST(eedi_value AS DOUBLE))
      comment: "Average Energy Efficiency Design Index value across records. IMO-mandated vessel efficiency metric — lower values indicate more energy-efficient vessels calling at the port."
    - name: "avg_eexi_value"
      expr: AVG(CAST(eexi_value AS DOUBLE))
      comment: "Average Energy Efficiency Existing Ship Index value. IMO 2023 mandatory metric for existing vessel efficiency compliance — used to assess fleet decarbonisation progress."
    - name: "total_waste_quantity_mt"
      expr: SUM(CAST(quantity_mass_mt AS DOUBLE))
      comment: "Total mass of waste managed under MARPOL in metric tonnes. Measures the port's waste reception capacity utilisation and environmental service throughput."
    - name: "port_endorsement_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN port_authority_endorsement_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of MARPOL records endorsed by the port authority. Low endorsement rates indicate record-keeping gaps that create regulatory filing risk."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`compliance_sanctions_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sanctions and trade compliance screening metrics covering screening volumes, match rates, risk levels, escalation rates, and resolution performance. Used by Trade Compliance Officers and Risk Committees to manage sanctions exposure, regulatory obligations, and AML/CFT risk."
  source: "`shipping_ports_ecm`.`compliance`.`sanctions_screening`"
  dimensions:
    - name: "screening_status"
      expr: screening_status
      comment: "Current status of the screening (e.g. Pending, Completed, Escalated) for screening pipeline management."
    - name: "match_status"
      expr: match_status
      comment: "Outcome of the sanctions list match (e.g. No Match, Potential Match, Confirmed Match) — the primary sanctions risk signal."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the screened entity (e.g. Low, Medium, High, Critical) for risk-tiered compliance management."
    - name: "screened_entity_type"
      expr: screened_entity_type
      comment: "Type of entity screened (e.g. Vessel, Shipping Line, Individual, Company) for entity-level sanctions risk analysis."
    - name: "analyst_review_status"
      expr: analyst_review_status
      comment: "Status of analyst review of screening results (e.g. Pending Review, Cleared, Escalated) for compliance team workload management."
    - name: "is_high_risk_cargo"
      expr: is_high_risk_cargo
      comment: "Indicates whether the screened cargo is classified as high-risk, requiring enhanced due diligence."
    - name: "screening_trigger_event"
      expr: screening_trigger_event
      comment: "Event that triggered the screening (e.g. Vessel Arrival, Cargo Declaration, Permit Application) for process-level compliance analysis."
    - name: "screening_month"
      expr: DATE_TRUNC('MONTH', screening_timestamp)
      comment: "Month the screening was performed, enabling trend analysis of sanctions screening volumes and match rates."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin of the screened cargo or entity, enabling geographic sanctions risk analysis."
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total number of sanctions screenings performed. Baseline metric for compliance programme throughput and regulatory obligation fulfilment."
    - name: "confirmed_match_count"
      expr: SUM(CASE WHEN match_status = 'Confirmed Match' THEN 1 ELSE 0 END)
      comment: "Count of screenings resulting in a confirmed sanctions list match. Each confirmed match represents a potential regulatory violation requiring immediate action — a critical risk metric."
    - name: "match_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN match_status IN ('Potential Match', 'Confirmed Match') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings generating a match (potential or confirmed). Elevated match rates signal increased sanctions exposure and may indicate changes in trade partner risk profiles."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN escalated_to_authority IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings escalated to a regulatory authority. Escalation rate is a key indicator of serious sanctions risk materialisation requiring executive attention."
    - name: "high_risk_screening_count"
      expr: SUM(CASE WHEN risk_level = 'High' OR risk_level = 'Critical' THEN 1 ELSE 0 END)
      comment: "Count of screenings classified as high or critical risk. Concentrates executive attention on the most consequential sanctions exposures."
    - name: "avg_match_score"
      expr: AVG(CAST(match_score AS DOUBLE))
      comment: "Average sanctions list match score across all screenings. Higher average scores indicate stronger potential matches requiring more analyst review resources."
    - name: "pending_review_count"
      expr: SUM(CASE WHEN analyst_review_status = 'Pending Review' THEN 1 ELSE 0 END)
      comment: "Count of screenings awaiting analyst review. Backlog metric — large pending queues increase the risk of delayed sanctions holds and regulatory non-compliance."
    - name: "high_risk_cargo_screening_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_high_risk_cargo = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings involving high-risk cargo. Used to assess the proportion of trade activity requiring enhanced due diligence and to calibrate screening resource allocation."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`compliance_isps_facility_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ISPS Code facility security compliance metrics covering security levels, PSC inspection outcomes, Declaration of Security (DoS) status, and facility security plan currency. Used by Port Facility Security Officers (PFSOs) and Port Directors to manage ISPS compliance obligations and maritime security posture."
  source: "`shipping_ports_ecm`.`compliance`.`isps_facility_record`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall ISPS compliance status of the facility (e.g. Compliant, Non-Compliant, Under Review) — the primary ISPS health indicator."
    - name: "current_security_level"
      expr: current_security_level
      comment: "Current ISPS security level of the facility (1, 2, or 3). Security level 3 indicates an imminent threat — a critical operational and regulatory signal."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of port facility (e.g. Container Terminal, Bulk Terminal, Passenger Terminal) for facility-type compliance benchmarking."
    - name: "last_psc_inspection_result"
      expr: last_psc_inspection_result
      comment: "Result of the most recent PSC inspection (e.g. Pass, Fail, Deficiency Noted) for PSC performance tracking."
    - name: "alert_severity"
      expr: alert_severity
      comment: "Severity of the most recent security alert (e.g. Low, Medium, High, Critical) for security incident risk analysis."
    - name: "alert_type"
      expr: alert_type
      comment: "Type of security alert raised (e.g. Unauthorised Access, Suspicious Activity, Cyber Threat) for threat pattern analysis."
    - name: "dos_type"
      expr: dos_type
      comment: "Type of Declaration of Security (e.g. Ship-to-Port, Ship-to-Ship) for DoS compliance monitoring."
    - name: "record_created_month"
      expr: DATE_TRUNC('MONTH', record_created_timestamp)
      comment: "Month the ISPS facility record was created, enabling trend analysis of security compliance activity."
  measures:
    - name: "total_facility_records"
      expr: COUNT(1)
      comment: "Total number of ISPS facility records. Baseline metric for ISPS compliance programme coverage across port facilities."
    - name: "non_compliant_facility_count"
      expr: SUM(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 ELSE 0 END)
      comment: "Count of facilities with non-compliant ISPS status. Non-compliant facilities are at risk of PSC detention and port closure — a critical security governance metric."
    - name: "elevated_security_level_count"
      expr: SUM(CASE WHEN current_security_level IN ('2', '3') THEN 1 ELSE 0 END)
      comment: "Count of facilities operating at ISPS security level 2 or 3. Elevated security levels indicate active threats and trigger mandatory enhanced security measures and cost escalation."
    - name: "pfsp_expiry_within_90_days_count"
      expr: SUM(CASE WHEN pfsp_expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 ELSE 0 END)
      comment: "Count of facilities whose Port Facility Security Plan (PFSP) expires within 90 days. Expired PFSPs result in immediate ISPS non-compliance — a leading indicator for proactive renewal management."
    - name: "pfso_cert_expiry_within_90_days_count"
      expr: SUM(CASE WHEN pfso_certification_expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 ELSE 0 END)
      comment: "Count of facilities where the PFSO certification expires within 90 days. Lapsed PFSO certifications create ISPS compliance gaps and regulatory liability."
    - name: "psc_deficiency_total"
      expr: SUM(CAST(psc_deficiency_count AS BIGINT))
      comment: "Total PSC deficiencies recorded across all ISPS facility records. Aggregate deficiency count is a key port reputation and regulatory risk metric used in PSC targeting risk models."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ISPS facility records with compliant status. The headline ISPS compliance KPI for executive and regulatory reporting."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`compliance_trade_restriction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade restriction and embargo management metrics covering active restriction volumes, enforcement levels, expiry risk, and screening obligation coverage. Used by Trade Compliance and Legal teams to manage regulatory trade controls, embargo obligations, and licence requirement exposure."
  source: "`shipping_ports_ecm`.`compliance`.`trade_restriction`"
  dimensions:
    - name: "restriction_type"
      expr: restriction_type
      comment: "Type of trade restriction (e.g. Embargo, Sanction, Export Control, Import Ban) for restriction category analysis."
    - name: "restriction_status"
      expr: restriction_status
      comment: "Current status of the restriction (e.g. Active, Expired, Suspended) for active restriction portfolio management."
    - name: "enforcement_level"
      expr: enforcement_level
      comment: "Level of enforcement applied to the restriction (e.g. Mandatory, Advisory, Voluntary) for risk-weighted compliance prioritisation."
    - name: "restriction_scope"
      expr: restriction_scope
      comment: "Scope of the restriction (e.g. Country-Wide, Commodity-Specific, Entity-Specific) for impact assessment."
    - name: "issuing_authority_country_code"
      expr: issuing_authority_country_code
      comment: "Country code of the authority issuing the restriction (e.g. US, EU, UN) for jurisdictional compliance analysis."
    - name: "declaration_required_flag"
      expr: declaration_required_flag
      comment: "Indicates whether a customs declaration is required under the restriction — drives declaration workload forecasting."
    - name: "screening_required_flag"
      expr: screening_required_flag
      comment: "Indicates whether sanctions screening is mandated by the restriction — drives screening programme scope."
    - name: "derogation_available_flag"
      expr: derogation_available_flag
      comment: "Indicates whether a derogation (exemption) is available for the restriction — relevant for trade facilitation and licence management."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the restriction became effective, enabling trend analysis of new restriction introductions."
  measures:
    - name: "total_restrictions"
      expr: COUNT(1)
      comment: "Total number of trade restrictions in the register. Baseline metric for the breadth of the trade compliance obligation landscape."
    - name: "active_restriction_count"
      expr: SUM(CASE WHEN restriction_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of currently active trade restrictions. Active restrictions directly constrain trade operations — a key metric for compliance programme scope and resource planning."
    - name: "mandatory_enforcement_count"
      expr: SUM(CASE WHEN enforcement_level = 'Mandatory' THEN 1 ELSE 0 END)
      comment: "Count of restrictions with mandatory enforcement level. Mandatory restrictions carry the highest penalty risk for non-compliance — used to prioritise compliance controls."
    - name: "expiring_within_90_days_count"
      expr: SUM(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 ELSE 0 END)
      comment: "Count of restrictions expiring within 90 days. Proactive expiry management prevents inadvertent continuation of expired controls or gaps in coverage."
    - name: "screening_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN screening_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of restrictions requiring sanctions screening. Drives the scope and volume of the sanctions screening programme — a key compliance resource planning metric."
    - name: "overdue_review_count"
      expr: SUM(CASE WHEN next_review_date < CURRENT_DATE() AND restriction_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of active restrictions whose scheduled review date has passed. Overdue reviews create regulatory risk from outdated controls — a governance quality metric."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`compliance_import_export_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Import and export permit lifecycle metrics covering permit volumes, approval rates, inspection outcomes, value authorisation, and expiry risk. Used by Trade Compliance Officers and Port Directors to manage controlled goods licensing obligations and permit programme performance."
  source: "`shipping_ports_ecm`.`compliance`.`import_export_permit`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Type of permit (e.g. Import Licence, Export Licence, CITES Permit, Dual-Use Export Authorisation) for permit category analysis."
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of the permit (e.g. Active, Expired, Revoked, Pending) for permit portfolio management."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the permit (e.g. Ministry of Trade, Customs Authority) for issuing body performance analysis."
    - name: "issuing_country_code"
      expr: issuing_country_code
      comment: "Country that issued the permit, enabling jurisdictional compliance analysis."
    - name: "controlled_goods_flag"
      expr: controlled_goods_flag
      comment: "Indicates whether the permit covers controlled goods (e.g. dual-use, strategic, CITES-listed) requiring enhanced oversight."
    - name: "inspection_required_flag"
      expr: inspection_required_flag
      comment: "Indicates whether a physical inspection is required as a permit condition — drives inspection workload planning."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for the permitted goods, enabling trade lane and sanctions risk analysis."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the permit was issued, enabling trend analysis of permit volumes and approval cycle times."
  measures:
    - name: "total_permits"
      expr: COUNT(1)
      comment: "Total number of import/export permits. Baseline metric for controlled goods trade volume and licensing programme throughput."
    - name: "active_permit_count"
      expr: SUM(CASE WHEN permit_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of currently active permits. Active permit portfolio size determines the scope of ongoing compliance monitoring obligations."
    - name: "revocation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN permit_status = 'Revoked' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of permits that have been revoked. High revocation rates signal compliance failures by permit holders and may indicate systemic issues with permit holder vetting."
    - name: "total_value_authorized"
      expr: SUM(CAST(value_authorized AS DOUBLE))
      comment: "Total value of goods authorised under all permits. Measures the economic scale of controlled goods trade and informs risk-based compliance resource allocation."
    - name: "total_quantity_authorized"
      expr: SUM(CAST(quantity_authorized AS DOUBLE))
      comment: "Total quantity of goods authorised under all permits. Used to monitor controlled goods volume against quota and restriction thresholds."
    - name: "inspection_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN inspection_required_flag = TRUE AND inspection_completion_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN inspection_required_flag = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of permits requiring inspection where the inspection has been completed. Low completion rates indicate inspection backlogs that create permit validity risk."
    - name: "expiring_within_30_days_count"
      expr: SUM(CASE WHEN validity_end_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 30) AND permit_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of active permits expiring within 30 days. Proactive expiry management prevents inadvertent trading under expired permits — a direct regulatory violation risk."
    - name: "controlled_goods_permit_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN controlled_goods_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of permits covering controlled goods. Higher rates indicate greater regulatory complexity and enhanced due diligence obligations for the compliance programme."
$$;