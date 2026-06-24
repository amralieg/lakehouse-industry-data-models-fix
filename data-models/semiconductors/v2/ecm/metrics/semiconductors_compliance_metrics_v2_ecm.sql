-- Metric views for domain: compliance | Business: Semiconductors | Version: 2 | Generated on: 2026-06-23 23:34:49

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_export_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for export license portfolio management — tracks license coverage, value exposure, and renewal risk across the semiconductor export control program."
  source: "`vibe_semiconductors_v1`.`compliance`.`export_license`"
  dimensions:
    - name: "license_type"
      expr: license_type
      comment: "Type of export license (e.g., individual, global, deemed export) for portfolio segmentation."
    - name: "export_license_status"
      expr: export_license_status
      comment: "Current lifecycle status of the license (active, expired, pending) for pipeline health monitoring."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Government body that issued the license (e.g., BIS, DDTC) for regulatory jurisdiction analysis."
    - name: "registration_category"
      expr: registration_category
      comment: "Export control registration category (EAR, ITAR) for compliance framework segmentation."
    - name: "effective_from_year"
      expr: YEAR(effective_from)
      comment: "Year the license became effective for trend analysis."
    - name: "renewal_required"
      expr: renewal_required
      comment: "Flag indicating whether the license requires renewal, used to prioritize renewal pipeline."
  measures:
    - name: "total_active_licenses"
      expr: COUNT(CASE WHEN export_license_status = 'active' THEN export_license_id END)
      comment: "Count of currently active export licenses. Executives use this to gauge export authorization coverage and identify gaps."
    - name: "total_value_ceiling_usd"
      expr: SUM(CAST(value_ceiling AS DOUBLE))
      comment: "Total authorized export value ceiling in USD across all licenses. Directly measures the monetary scope of export authorization — a key risk and revenue enabler metric."
    - name: "avg_value_ceiling_usd"
      expr: AVG(CAST(value_ceiling AS DOUBLE))
      comment: "Average authorized value ceiling per export license. Helps benchmark license sizing and identify under- or over-authorized licenses."
    - name: "licenses_expiring_within_90_days"
      expr: COUNT(CASE WHEN effective_until <= DATE_ADD(CURRENT_DATE(), 90) AND export_license_status = 'active' THEN export_license_id END)
      comment: "Number of active licenses expiring within 90 days. A critical operational risk metric — if this spikes, shipments may be blocked."
    - name: "renewal_required_count"
      expr: COUNT(CASE WHEN renewal_required = TRUE THEN export_license_id END)
      comment: "Count of licenses flagged for renewal. Drives the compliance team's renewal workload planning."
    - name: "total_licenses"
      expr: COUNT(1)
      comment: "Total export licenses in the portfolio. Baseline denominator for coverage and renewal rate calculations."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_export_license_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for export license consumption — tracks utilization rates, declared values, and shipment volumes to prevent over-use and identify compliance risk."
  source: "`vibe_semiconductors_v1`.`compliance`.`export_license_usage`"
  dimensions:
    - name: "export_license_type"
      expr: export_license_type
      comment: "Type of export license being consumed for segmentation by authorization category."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country of the export shipment — critical for geographic risk analysis and restricted-country monitoring."
    - name: "export_control_regulation"
      expr: export_control_regulation
      comment: "Governing regulation (EAR, ITAR) under which the usage is recorded."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the usage record — used to filter and escalate non-compliant transactions."
    - name: "export_license_usage_status"
      expr: export_license_usage_status
      comment: "Lifecycle status of the usage record (pending, approved, rejected)."
    - name: "export_year"
      expr: YEAR(export_date)
      comment: "Year of export for trend and annual reporting."
    - name: "is_sensitive"
      expr: is_sensitive
      comment: "Flag indicating whether the export involves sensitive technology — used to prioritize compliance review."
  measures:
    - name: "total_declared_value_usd"
      expr: SUM(CAST(declared_value AS DOUBLE))
      comment: "Total declared export value in USD. Directly measures the monetary volume of exports against license ceilings — a primary compliance risk indicator."
    - name: "avg_license_utilization_pct"
      expr: AVG(CAST(cumulative_license_utilization_percent AS DOUBLE))
      comment: "Average cumulative license utilization percentage across usage records. Executives use this to identify licenses approaching exhaustion before shipments are blocked."
    - name: "total_quantity_exported"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of units exported under license. Tracks physical volume against authorized quantities."
    - name: "total_license_balance_remaining_usd"
      expr: SUM(CAST(license_balance_remaining AS DOUBLE))
      comment: "Total remaining license balance in USD across all usage records. A forward-looking capacity metric — low balance signals need for new license applications."
    - name: "high_utilization_usage_count"
      expr: COUNT(CASE WHEN cumulative_license_utilization_percent >= 80 THEN export_license_usage_id END)
      comment: "Count of usage records where license utilization exceeds 80%. Flags licenses at risk of exhaustion requiring immediate renewal action."
    - name: "sensitive_export_count"
      expr: COUNT(CASE WHEN is_sensitive = TRUE THEN export_license_usage_id END)
      comment: "Count of exports flagged as sensitive. Drives enhanced compliance review prioritization and audit focus."
    - name: "total_usage_transactions"
      expr: COUNT(1)
      comment: "Total export license usage transactions. Baseline volume metric for throughput and compliance workload analysis."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_restricted_party_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk and compliance KPIs for restricted party screening — measures screening hit rates, risk scores, and escalation rates to protect the company from prohibited transaction exposure."
  source: "`vibe_semiconductors_v1`.`compliance`.`restricted_party_screening`"
  dimensions:
    - name: "screened_entity_type"
      expr: screened_entity_type
      comment: "Type of entity screened (customer, partner, individual) for risk segmentation."
    - name: "match_result"
      expr: match_result
      comment: "Outcome of the screening match (no match, potential match, confirmed match) — primary decision driver."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category assigned to the screened entity for portfolio risk stratification."
    - name: "compliance_regulation"
      expr: compliance_regulation
      comment: "Regulatory framework under which screening was performed (OFAC, BIS, EU)."
    - name: "restricted_party_screening_status"
      expr: restricted_party_screening_status
      comment: "Current status of the screening record (pending, cleared, escalated, blocked)."
    - name: "screening_year"
      expr: YEAR(screening_date)
      comment: "Year of screening for trend analysis and annual compliance reporting."
    - name: "escalation_required"
      expr: escalation_required
      comment: "Flag indicating whether the screening result required escalation to compliance leadership."
    - name: "is_manual"
      expr: is_manual
      comment: "Flag indicating manual vs. automated screening — used to assess automation coverage and manual review burden."
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total restricted party screenings performed. Baseline volume metric for compliance program throughput."
    - name: "match_hit_count"
      expr: COUNT(CASE WHEN match_result IN ('potential_match', 'confirmed_match') THEN restricted_party_screening_id END)
      comment: "Count of screenings with a potential or confirmed match. A critical risk metric — rising hits signal increased exposure to prohibited transactions."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_required = TRUE THEN restricted_party_screening_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings requiring escalation. Measures compliance program stress — high escalation rates indicate systemic risk or process gaps."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across all screened entities. Tracks portfolio-level risk exposure over time — a leading indicator for compliance investment decisions."
    - name: "avg_match_score"
      expr: AVG(CAST(match_score AS DOUBLE))
      comment: "Average match confidence score. Used to calibrate screening algorithm thresholds and reduce false positives."
    - name: "manual_screening_count"
      expr: COUNT(CASE WHEN is_manual = TRUE THEN restricted_party_screening_id END)
      comment: "Count of manually performed screenings. Drives automation investment decisions — high manual counts indicate automation gaps."
    - name: "distinct_entities_screened"
      expr: COUNT(DISTINCT screened_entity_reference)
      comment: "Count of distinct entities screened. Measures breadth of compliance coverage across the business partner ecosystem."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_trade_compliance_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for trade compliance holds — measures hold volume, financial exposure, and resolution efficiency to minimize revenue impact from compliance blocks."
  source: "`vibe_semiconductors_v1`.`compliance`.`trade_compliance_hold`"
  dimensions:
    - name: "hold_type"
      expr: hold_type
      comment: "Type of trade compliance hold (export control, restricted party, ECCN) for root-cause segmentation."
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the hold (active, released, escalated) for pipeline management."
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Coded reason for the hold — used to identify systemic compliance issues requiring process improvement."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country of the held transaction — identifies geographic risk concentrations."
    - name: "export_control_regulation"
      expr: export_control_regulation
      comment: "Governing regulation triggering the hold (EAR, ITAR, OFAC) for regulatory risk analysis."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the hold is currently active — used to filter live operational holds."
    - name: "hold_year"
      expr: YEAR(hold_date)
      comment: "Year the hold was placed for trend and annual compliance reporting."
  measures:
    - name: "total_active_holds"
      expr: COUNT(CASE WHEN is_active = TRUE THEN trade_compliance_hold_id END)
      comment: "Count of currently active trade compliance holds. A primary operational risk metric — active holds directly block revenue."
    - name: "total_estimated_value_at_risk_usd"
      expr: SUM(CASE WHEN is_active = TRUE THEN estimated_value_usd ELSE 0 END)
      comment: "Total estimated USD value of transactions currently on active compliance hold. Quantifies revenue at risk from compliance blocks — a critical executive metric."
    - name: "total_gross_amount_held_usd"
      expr: SUM(CAST(gross_amount_usd AS DOUBLE))
      comment: "Total gross transaction value placed on compliance hold. Measures cumulative financial exposure from trade compliance actions."
    - name: "avg_estimated_value_per_hold_usd"
      expr: AVG(CAST(estimated_value_usd AS DOUBLE))
      comment: "Average estimated value per compliance hold. Benchmarks hold severity and helps prioritize resolution effort by financial impact."
    - name: "total_holds"
      expr: COUNT(1)
      comment: "Total trade compliance holds recorded. Baseline volume metric for compliance program load and trend analysis."
    - name: "sensitive_hold_count"
      expr: COUNT(CASE WHEN is_sensitive = TRUE THEN trade_compliance_hold_id END)
      comment: "Count of holds flagged as sensitive. Sensitive holds require expedited executive review and carry higher regulatory risk."
    - name: "total_adjustment_amount_usd"
      expr: SUM(CAST(adjustment_amount_usd AS DOUBLE))
      comment: "Total adjustment amounts applied to held transactions. Measures the financial remediation cost of compliance holds."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_audit_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance audit program KPIs — tracks audit outcomes, finding rates, and closure performance to assess the health of the enterprise compliance audit program."
  source: "`vibe_semiconductors_v1`.`compliance`.`audit_event`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (internal, external, regulatory, supplier) for program segmentation."
    - name: "audit_outcome"
      expr: audit_outcome
      comment: "Overall outcome of the audit (pass, fail, conditional pass) — primary quality indicator."
    - name: "audit_standard"
      expr: audit_standard
      comment: "Standard against which the audit was conducted (ISO 9001, IATF, SOX) for framework analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the audit (high, medium, low) for prioritization."
    - name: "closure_status"
      expr: closure_status
      comment: "Closure status of the audit (open, closed, in-progress) for pipeline management."
    - name: "audit_category"
      expr: audit_category
      comment: "Category of audit (quality, environmental, export control) for domain-level compliance tracking."
    - name: "audit_year"
      expr: YEAR(audit_date)
      comment: "Year the audit was conducted for trend analysis."
    - name: "auditing_body"
      expr: auditing_body
      comment: "Organization conducting the audit — used to track third-party vs. internal audit performance."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total audit events conducted. Baseline metric for audit program coverage and activity level."
    - name: "audit_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN audit_outcome = 'pass' THEN audit_event_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits with a passing outcome. A primary compliance program health metric — declining pass rates signal systemic compliance deterioration."
    - name: "open_audit_count"
      expr: COUNT(CASE WHEN closure_status != 'closed' THEN audit_event_id END)
      comment: "Count of audits not yet closed. Measures compliance program backlog and resolution velocity."
    - name: "high_risk_audit_count"
      expr: COUNT(CASE WHEN risk_level = 'high' THEN audit_event_id END)
      comment: "Count of high-risk audits. Executives use this to prioritize resource allocation and escalation decisions."
    - name: "distinct_sites_audited"
      expr: COUNT(DISTINCT audit_site_id)
      comment: "Count of distinct sites that have been audited. Measures geographic and operational coverage of the audit program."
    - name: "corrective_action_overdue_count"
      expr: COUNT(CASE WHEN corrective_action_due_date < CURRENT_DATE() AND closure_status != 'closed' THEN audit_event_id END)
      comment: "Count of audits with overdue corrective actions. A critical compliance risk metric — overdue CAPAs expose the company to regulatory penalties."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit finding resolution KPIs — tracks finding severity distribution, closure rates, and corrective action effectiveness to drive continuous compliance improvement."
  source: "`vibe_semiconductors_v1`.`compliance`.`compliance_audit_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Type of audit finding (major non-conformance, minor, observation) for severity-based prioritization."
    - name: "severity"
      expr: severity
      comment: "Severity level of the finding — drives escalation and resource allocation decisions."
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the finding (open, in-progress, closed, verified) for pipeline management."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the finding for portfolio risk analysis."
    - name: "compliance_audit_finding_status"
      expr: compliance_audit_finding_status
      comment: "Lifecycle status of the compliance audit finding record."
    - name: "root_cause_method"
      expr: root_cause_method
      comment: "Root cause analysis method used (5-Why, Fishbone, FMEA) — used to assess RCA rigor."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total compliance audit findings recorded. Baseline metric for compliance program finding load."
    - name: "open_findings_count"
      expr: COUNT(CASE WHEN finding_status = 'open' THEN compliance_audit_finding_id END)
      comment: "Count of open (unresolved) audit findings. A primary compliance risk metric — high open counts signal unresolved compliance gaps."
    - name: "finding_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN finding_status = 'closed' THEN compliance_audit_finding_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that have been closed. Measures compliance program resolution effectiveness — a key audit readiness indicator."
    - name: "overdue_findings_count"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE() AND finding_status != 'closed' THEN compliance_audit_finding_id END)
      comment: "Count of findings past their due date without closure. Overdue findings directly increase regulatory exposure and audit failure risk."
    - name: "distinct_audits_with_findings"
      expr: COUNT(DISTINCT audit_event_id)
      comment: "Count of distinct audit events that generated findings. Measures the breadth of compliance issues across the audit program."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_obligation_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory obligation management KPIs — tracks compliance status, overdue obligations, and remediation progress across the enterprise obligation portfolio."
  source: "`vibe_semiconductors_v1`.`compliance`.`obligation_register`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of regulatory obligation (reporting, operational, financial) for portfolio segmentation."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the obligation (compliant, non-compliant, at-risk) — primary risk indicator."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction governing the obligation (US, EU, China) for geographic risk analysis."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body enforcing the obligation (SEC, BIS, EPA) for agency-level compliance tracking."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Category of compliance obligation (export control, environmental, labor) for domain analysis."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the obligation is currently active — used to filter live obligations."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the obligation (high, medium, low) for prioritization."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the obligation record for pipeline management."
  measures:
    - name: "total_active_obligations"
      expr: COUNT(CASE WHEN is_active = TRUE THEN obligation_register_id END)
      comment: "Total active regulatory obligations in the register. Baseline metric for compliance program scope and resource planning."
    - name: "non_compliant_obligation_count"
      expr: COUNT(CASE WHEN compliance_status = 'non_compliant' THEN obligation_register_id END)
      comment: "Count of obligations currently in non-compliant status. A critical risk metric — non-compliant obligations expose the company to regulatory penalties and sanctions."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'compliant' THEN obligation_register_id END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN obligation_register_id END), 0), 2)
      comment: "Percentage of active obligations in compliant status. The primary enterprise compliance health KPI — reported at board and executive level."
    - name: "overdue_obligation_count"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE() AND compliance_status != 'compliant' THEN obligation_register_id END)
      comment: "Count of obligations past their due date without achieving compliance. Directly measures regulatory deadline risk."
    - name: "high_risk_obligation_count"
      expr: COUNT(CASE WHEN risk_rating = 'high' THEN obligation_register_id END)
      comment: "Count of high-risk obligations. Executives use this to prioritize compliance investment and escalation decisions."
    - name: "distinct_jurisdictions_covered"
      expr: COUNT(DISTINCT jurisdiction)
      comment: "Count of distinct jurisdictions with active obligations. Measures the geographic complexity of the compliance program."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_chips_act_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CHIPS Act compliance KPIs — tracks funding utilization, obligation fulfillment rates, and target achievement to ensure compliance with US CHIPS Act grant conditions."
  source: "`vibe_semiconductors_v1`.`compliance`.`chips_act_obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of CHIPS Act obligation (domestic production, workforce training, childcare) for program segmentation."
    - name: "chips_act_obligation_status"
      expr: chips_act_obligation_status
      comment: "Current status of the CHIPS Act obligation (on-track, at-risk, breached) — primary compliance indicator."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the obligation for executive reporting."
    - name: "measurement_frequency"
      expr: measurement_frequency
      comment: "Frequency at which the obligation is measured (quarterly, annual) for reporting cadence alignment."
    - name: "is_met"
      expr: is_met
      comment: "Flag indicating whether the obligation target has been met — primary binary compliance indicator."
    - name: "domestic_production_commitment"
      expr: domestic_production_commitment
      comment: "Flag indicating whether the obligation includes a domestic production commitment — a key CHIPS Act guardrail."
    - name: "guardrail_restriction"
      expr: guardrail_restriction
      comment: "Flag indicating whether a guardrail restriction applies — violations can trigger clawback of federal funding."
  measures:
    - name: "total_funding_amount_usd"
      expr: SUM(CAST(funding_amount AS DOUBLE))
      comment: "Total CHIPS Act funding amount in USD across all obligations. Measures the total federal investment at stake — a primary executive and board metric."
    - name: "avg_compliance_actual"
      expr: AVG(CAST(compliance_actual AS DOUBLE))
      comment: "Average actual compliance value achieved across obligations. Tracks overall program performance against CHIPS Act commitments."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across CHIPS Act obligations. Used as denominator context for compliance achievement rate calculations."
    - name: "obligations_met_count"
      expr: COUNT(CASE WHEN is_met = TRUE THEN chips_act_obligation_id END)
      comment: "Count of CHIPS Act obligations that have been met. Measures program fulfillment — unmet obligations risk clawback of federal funding."
    - name: "obligation_fulfillment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_met = TRUE THEN chips_act_obligation_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CHIPS Act obligations fulfilled. The primary CHIPS Act compliance KPI — reported to federal agencies and the board."
    - name: "clawback_risk_count"
      expr: COUNT(CASE WHEN clawback_condition = TRUE AND is_met = FALSE THEN chips_act_obligation_id END)
      comment: "Count of obligations with clawback conditions that have not been met. Directly quantifies federal funding at risk of clawback — a critical financial and reputational risk metric."
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total CHIPS Act obligations tracked. Baseline metric for program scope and compliance workload."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Certification portfolio KPIs — tracks certification coverage, expiry risk, and audit compliance to ensure continuous regulatory and customer certification status."
  source: "`vibe_semiconductors_v1`.`compliance`.`certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (ISO 9001, IATF 16949, ISO 14001) for portfolio segmentation."
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (active, expired, suspended) — primary coverage indicator."
    - name: "certifying_body"
      expr: certifying_body
      comment: "Organization that issued the certification for third-party credibility analysis."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category of the certification (quality, environmental, export) for domain analysis."
    - name: "compliance_risk_level"
      expr: compliance_risk_level
      comment: "Risk level associated with the certification for prioritization."
    - name: "recertification_required"
      expr: recertification_required
      comment: "Flag indicating whether recertification is required — drives renewal planning."
    - name: "internal_audit_required"
      expr: internal_audit_required
      comment: "Flag indicating whether an internal audit is required to maintain the certification."
  measures:
    - name: "total_active_certifications"
      expr: COUNT(CASE WHEN certification_status = 'active' THEN certification_id END)
      comment: "Count of currently active certifications. Measures compliance coverage — lost certifications can block customer shipments and revenue."
    - name: "certifications_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND certification_status = 'active' THEN certification_id END)
      comment: "Count of active certifications expiring within 90 days. A critical operational risk metric — expired certifications can halt production and shipments."
    - name: "certification_expiry_risk_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND certification_status = 'active' THEN certification_id END) / NULLIF(COUNT(CASE WHEN certification_status = 'active' THEN certification_id END), 0), 2)
      comment: "Percentage of active certifications at near-term expiry risk. Drives renewal prioritization and resource allocation."
    - name: "recertification_required_count"
      expr: COUNT(CASE WHEN recertification_required = TRUE THEN certification_id END)
      comment: "Count of certifications requiring recertification. Measures the compliance renewal workload pipeline."
    - name: "distinct_sites_certified"
      expr: COUNT(DISTINCT certification_site_id)
      comment: "Count of distinct sites holding certifications. Measures geographic coverage of the certification program."
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total certifications in the portfolio. Baseline metric for program scope."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_substance_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chemical substance compliance KPIs — tracks restricted substance inventory, regulatory risk exposure, and compliance status to meet REACH, RoHS, TSCA, and ITAR requirements."
  source: "`vibe_semiconductors_v1`.`compliance`.`substance_inventory`"
  dimensions:
    - name: "substance_type"
      expr: substance_type
      comment: "Type of substance (chemical, gas, solvent) for inventory segmentation."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the substance (compliant, restricted, prohibited) — primary regulatory risk indicator."
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "Hazard classification of the substance (carcinogen, flammable, toxic) for safety and regulatory analysis."
    - name: "controlled_substance_category"
      expr: controlled_substance_category
      comment: "Category of controlled substance for regulatory framework alignment."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the substance record (active, phased-out, under-review)."
    - name: "is_reach_svhc"
      expr: is_reach_svhc
      comment: "Flag indicating REACH SVHC (Substance of Very High Concern) status — triggers mandatory declaration obligations."
    - name: "is_rohs_restricted"
      expr: is_rohs_restricted
      comment: "Flag indicating RoHS restriction — affects product market access in EU."
    - name: "is_itar_controlled"
      expr: is_itar_controlled
      comment: "Flag indicating ITAR control status — affects export authorization requirements."
    - name: "is_pfas"
      expr: is_pfas
      comment: "Flag indicating PFAS (per- and polyfluoroalkyl substances) classification — subject to emerging global restrictions."
  measures:
    - name: "total_annual_usage_volume_kg"
      expr: SUM(CAST(annual_usage_volume_kg AS DOUBLE))
      comment: "Total annual usage volume in kilograms across all substances. Measures the scale of chemical consumption — a key input for regulatory threshold calculations."
    - name: "restricted_substance_count"
      expr: COUNT(CASE WHEN is_restricted = TRUE THEN substance_inventory_id END)
      comment: "Count of restricted substances in inventory. Measures regulatory exposure — high counts signal product redesign or substitution needs."
    - name: "reach_svhc_substance_count"
      expr: COUNT(CASE WHEN is_reach_svhc = TRUE THEN substance_inventory_id END)
      comment: "Count of REACH SVHC substances in inventory. Directly drives EU declaration obligations and customer notification requirements."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across all substances in inventory. Tracks portfolio-level chemical risk — a leading indicator for compliance investment and substitution programs."
    - name: "avg_concentration_ppm"
      expr: AVG(CAST(concentration_ppm AS DOUBLE))
      comment: "Average substance concentration in parts per million. Used to monitor threshold compliance across the substance portfolio."
    - name: "itar_controlled_substance_count"
      expr: COUNT(CASE WHEN is_itar_controlled = TRUE THEN substance_inventory_id END)
      comment: "Count of ITAR-controlled substances. Drives export license requirements and technology control plan coverage."
    - name: "pfas_substance_count"
      expr: COUNT(CASE WHEN is_pfas = TRUE THEN substance_inventory_id END)
      comment: "Count of PFAS substances in inventory. Measures exposure to emerging PFAS regulations — a growing compliance risk requiring proactive substitution planning."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_conflict_minerals_declaration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Conflict minerals compliance KPIs — tracks declaration status, conflict-free rates, and supply chain risk to meet SEC Rule 13p-1 and OECD due diligence requirements."
  source: "`vibe_semiconductors_v1`.`compliance`.`conflict_minerals_declaration`"
  dimensions:
    - name: "declaration_type"
      expr: declaration_type
      comment: "Type of conflict minerals declaration (CMRT, custom) for framework segmentation."
    - name: "declaration_status"
      expr: declaration_status
      comment: "Current status of the declaration (submitted, pending, rejected) — primary compliance indicator."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin of the conflict minerals — used to identify DRC and adjoining country sourcing risk."
    - name: "drc_conflict_free_status"
      expr: drc_conflict_free_status
      comment: "DRC conflict-free status of the declaration — the primary regulatory compliance indicator for SEC filing."
    - name: "is_conflict_free"
      expr: is_conflict_free
      comment: "Flag indicating whether the declaration is conflict-free — drives SEC filing classification."
    - name: "third_party_verification"
      expr: third_party_verification
      comment: "Flag indicating whether third-party verification was obtained — strengthens declaration credibility."
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year of the declaration for annual compliance trend analysis."
  measures:
    - name: "total_declarations"
      expr: COUNT(1)
      comment: "Total conflict minerals declarations in the program. Baseline metric for supply chain coverage."
    - name: "conflict_free_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_conflict_free = TRUE THEN conflict_minerals_declaration_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of declarations classified as conflict-free. The primary SEC compliance KPI — reported annually in the conflict minerals report."
    - name: "avg_compliance_risk_score"
      expr: AVG(CAST(compliance_risk_score AS DOUBLE))
      comment: "Average compliance risk score across all declarations. Tracks supply chain risk portfolio — a leading indicator for supplier engagement and audit prioritization."
    - name: "avg_conflict_minerals_percentage"
      expr: AVG(CAST(conflict_minerals_percentage AS DOUBLE))
      comment: "Average conflict minerals percentage across declarations. Measures the concentration of conflict minerals in the supply chain."
    - name: "total_material_weight_kg"
      expr: SUM(CAST(total_material_weight_kg AS DOUBLE))
      comment: "Total material weight in kilograms covered by conflict minerals declarations. Measures the physical scope of the compliance program."
    - name: "third_party_verified_count"
      expr: COUNT(CASE WHEN third_party_verification = TRUE THEN conflict_minerals_declaration_id END)
      comment: "Count of declarations with third-party verification. Measures the rigor of the conflict minerals program — higher verification rates reduce SEC filing risk."
    - name: "distinct_suppliers_covered"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Count of distinct suppliers covered by conflict minerals declarations. Measures supply chain due diligence breadth."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_eccn_classification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Export control classification KPIs — tracks ECCN classification coverage, license requirement rates, and deemed export exposure across the semiconductor product portfolio."
  source: "`vibe_semiconductors_v1`.`compliance`.`eccn_classification`"
  dimensions:
    - name: "eccn_code"
      expr: eccn_code
      comment: "ECCN code assigned to the product or technology — the primary export control classification identifier."
    - name: "technology_type"
      expr: technology_type
      comment: "Type of technology being classified (semiconductor, EDA tool, IP core) for portfolio segmentation."
    - name: "product_category"
      expr: product_category
      comment: "Product category for classification portfolio analysis."
    - name: "eccn_classification_status"
      expr: eccn_classification_status
      comment: "Current status of the ECCN classification (active, under-review, expired) for portfolio management."
    - name: "export_license_required"
      expr: export_license_required
      comment: "Flag indicating whether an export license is required — directly drives license application workload."
    - name: "is_deemed_export"
      expr: is_deemed_export
      comment: "Flag indicating deemed export status — affects foreign national access controls and HR compliance."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the classification (EAR, ITAR) for jurisdiction analysis."
  measures:
    - name: "total_classifications"
      expr: COUNT(1)
      comment: "Total ECCN classifications in the portfolio. Baseline metric for export control program coverage."
    - name: "license_required_count"
      expr: COUNT(CASE WHEN export_license_required = TRUE THEN eccn_classification_id END)
      comment: "Count of classifications requiring an export license. Directly measures the export license application workload and revenue gating risk."
    - name: "license_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN export_license_required = TRUE THEN eccn_classification_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of classified products requiring an export license. A strategic metric — high rates indicate significant export control burden on revenue."
    - name: "deemed_export_count"
      expr: COUNT(CASE WHEN is_deemed_export = TRUE THEN eccn_classification_id END)
      comment: "Count of classifications with deemed export status. Drives HR and facility access control requirements — a key workforce compliance metric."
    - name: "avg_deminimis_value_usd"
      expr: AVG(CAST(deminimis_value_usd AS DOUBLE))
      comment: "Average de minimis value threshold in USD across classifications. Used to assess re-export control exposure in foreign-made products."
    - name: "avg_process_node_nm"
      expr: AVG(CAST(process_node_nm AS DOUBLE))
      comment: "Average process node size in nanometers across classified products. Tracks the technology sensitivity of the export portfolio — smaller nodes face stricter controls."
    - name: "classifications_due_for_review"
      expr: COUNT(CASE WHEN next_review_date <= DATE_ADD(CURRENT_DATE(), 90) AND eccn_classification_status = 'active' THEN eccn_classification_id END)
      comment: "Count of active classifications due for review within 90 days. Drives compliance team workload planning and prevents stale classifications."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_technology_control_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technology control plan KPIs — tracks plan coverage, expiry risk, and deemed export controls to protect controlled technology from unauthorized access and export."
  source: "`vibe_semiconductors_v1`.`compliance`.`technology_control_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of technology control plan (facility, program, product) for coverage segmentation."
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the plan (active, expired, under-review) for portfolio management."
    - name: "technology_control_plan_status"
      expr: technology_control_plan_status
      comment: "Lifecycle status of the technology control plan record."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the plan (EAR, ITAR) for jurisdiction analysis."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the plan is currently active — used to filter live controls."
    - name: "is_deemed_export"
      expr: is_deemed_export
      comment: "Flag indicating deemed export applicability — drives foreign national access restrictions."
    - name: "export_license_required"
      expr: export_license_required
      comment: "Flag indicating whether an export license is required under this plan."
    - name: "training_required"
      expr: training_required
      comment: "Flag indicating whether training is required for personnel with access to controlled technology."
  measures:
    - name: "total_active_plans"
      expr: COUNT(CASE WHEN is_active = TRUE THEN technology_control_plan_id END)
      comment: "Count of currently active technology control plans. Measures the scope of controlled technology protection — gaps in coverage create export violation risk."
    - name: "plans_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiration_date <= DATE_ADD(CURRENT_DATE(), 90) AND is_active = TRUE THEN technology_control_plan_id END)
      comment: "Count of active plans expiring within 90 days. A critical compliance risk metric — expired TCPs leave controlled technology unprotected."
    - name: "deemed_export_plan_count"
      expr: COUNT(CASE WHEN is_deemed_export = TRUE AND is_active = TRUE THEN technology_control_plan_id END)
      comment: "Count of active plans covering deemed export scenarios. Drives HR access control and foreign national management requirements."
    - name: "avg_deminimis_value_usd"
      expr: AVG(CAST(deminimis_value_usd AS DOUBLE))
      comment: "Average de minimis value threshold across technology control plans. Used to assess re-export exposure in foreign-manufactured products."
    - name: "training_required_plan_count"
      expr: COUNT(CASE WHEN training_required = TRUE AND is_active = TRUE THEN technology_control_plan_id END)
      comment: "Count of active plans requiring personnel training. Drives compliance training program scope and workforce compliance investment."
    - name: "total_plans"
      expr: COUNT(1)
      comment: "Total technology control plans in the portfolio. Baseline metric for program scope."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory filing KPIs — tracks filing status, deadline adherence, and impact severity to ensure timely and complete regulatory submissions across all jurisdictions."
  source: "`vibe_semiconductors_v1`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "filing_type"
      expr: filing_type
      comment: "Type of regulatory filing (annual report, change notification, incident report) for program segmentation."
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the filing (submitted, pending, overdue, accepted) — primary compliance indicator."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body receiving the filing (SEC, BIS, EPA) for agency-level compliance tracking."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction of the filing for geographic compliance analysis."
    - name: "impact_severity"
      expr: impact_severity
      comment: "Severity of the regulatory change or filing impact (critical, major, minor) for prioritization."
    - name: "regulatory_filing_status"
      expr: regulatory_filing_status
      comment: "Lifecycle status of the regulatory filing record."
    - name: "filing_year"
      expr: YEAR(filing_date)
      comment: "Year of the filing for trend and annual compliance reporting."
    - name: "is_confidential"
      expr: is_confidential
      comment: "Flag indicating whether the filing is confidential — affects disclosure and access controls."
  measures:
    - name: "total_filings"
      expr: COUNT(1)
      comment: "Total regulatory filings in the portfolio. Baseline metric for compliance program filing volume."
    - name: "on_time_filing_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN filing_date <= submission_date AND filing_status = 'submitted' THEN regulatory_filing_id END) / NULLIF(COUNT(CASE WHEN filing_status = 'submitted' THEN regulatory_filing_id END), 0), 2)
      comment: "Percentage of submitted filings completed on or before the submission deadline. Measures regulatory deadline adherence — late filings risk penalties and sanctions."
    - name: "overdue_filing_count"
      expr: COUNT(CASE WHEN action_deadline < CURRENT_DATE() AND filing_status NOT IN ('submitted', 'accepted') THEN regulatory_filing_id END)
      comment: "Count of filings past their action deadline without submission. Directly measures regulatory non-compliance risk."
    - name: "critical_impact_filing_count"
      expr: COUNT(CASE WHEN impact_severity = 'critical' THEN regulatory_filing_id END)
      comment: "Count of filings with critical impact severity. Executives use this to prioritize compliance resources and escalation decisions."
    - name: "distinct_jurisdictions_filed"
      expr: COUNT(DISTINCT jurisdiction)
      comment: "Count of distinct jurisdictions with active regulatory filings. Measures the geographic complexity of the regulatory compliance program."
    - name: "pending_action_count"
      expr: COUNT(CASE WHEN action_status NOT IN ('completed', 'closed') AND action_deadline IS NOT NULL THEN regulatory_filing_id END)
      comment: "Count of filings with pending required actions. Measures the compliance team's open action backlog."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`compliance_declaration_substance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "REACH SVHC substance declaration KPIs — tracks threshold exceedances, concentration levels, and exemption coverage to ensure product-level chemical compliance."
  source: "`vibe_semiconductors_v1`.`compliance`.`declaration_substance`"
  dimensions:
    - name: "substance_name"
      expr: substance_name
      comment: "Name of the declared substance for substance-level compliance analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the substance declaration (compliant, non-compliant, exempt) — primary regulatory indicator."
    - name: "declaration_status"
      expr: declaration_status
      comment: "Status of the declaration record (submitted, pending, rejected) for pipeline management."
    - name: "material_category"
      expr: material_category
      comment: "Material category of the substance (metal, polymer, chemical) for portfolio segmentation."
    - name: "exceeds_threshold"
      expr: exceeds_threshold
      comment: "Flag indicating whether the substance concentration exceeds the regulatory threshold — primary compliance trigger."
    - name: "exemption_applicable_flag"
      expr: exemption_applicable_flag
      comment: "Flag indicating whether an exemption applies — reduces mandatory declaration obligations."
    - name: "reporting_status"
      expr: reporting_status
      comment: "Reporting status of the declaration for regulatory submission tracking."
  measures:
    - name: "total_declarations"
      expr: COUNT(1)
      comment: "Total substance declarations recorded. Baseline metric for REACH compliance program coverage."
    - name: "threshold_exceedance_count"
      expr: COUNT(CASE WHEN exceeds_threshold = TRUE THEN declaration_substance_id END)
      comment: "Count of substance declarations exceeding the regulatory threshold. Directly measures REACH non-compliance exposure — each exceedance requires customer notification and potential product redesign."
    - name: "threshold_exceedance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exceeds_threshold = TRUE THEN declaration_substance_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of substance declarations exceeding the regulatory threshold. The primary REACH compliance KPI — high rates signal systemic product compliance issues."
    - name: "avg_measured_concentration_ppm"
      expr: AVG(CAST(measured_concentration AS DOUBLE))
      comment: "Average measured substance concentration in PPM. Tracks portfolio-level concentration trends — rising averages signal increasing compliance risk."
    - name: "avg_threshold_ppm"
      expr: AVG(CAST(threshold_ppm AS DOUBLE))
      comment: "Average regulatory threshold in PPM across declarations. Used as context for concentration compliance analysis."
    - name: "exemption_covered_count"
      expr: COUNT(CASE WHEN exemption_applicable_flag = TRUE THEN declaration_substance_id END)
      comment: "Count of declarations covered by regulatory exemptions. Measures the scope of exemption utilization — a key cost avoidance metric for compliance programs."
    - name: "distinct_substances_declared"
      expr: COUNT(DISTINCT substance_name)
      comment: "Count of distinct substances declared. Measures the breadth of the REACH compliance program."
$$;