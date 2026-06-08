-- Metric views for domain: compliance | Business: Real Estate | Version: 1 | Generated on: 2026-05-02 04:45:11

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`compliance_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance assessment KPIs tracking risk exposure, remediation cost, ESG scoring, and finding severity across properties and jurisdictions. Enables leadership to monitor portfolio-wide compliance health and prioritize remediation investment."
  source: "`real_estate_ecm`.`compliance`.`assessment`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the assessment (e.g., Compliant, Non-Compliant, In Remediation) — primary filter for risk triage."
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of compliance assessment performed (e.g., Environmental, Fire Safety, ADA) — used to segment risk by category."
    - name: "overall_risk_rating"
      expr: overall_risk_rating
      comment: "Aggregated risk rating assigned to the assessment (e.g., High, Medium, Low) — key dimension for executive risk dashboards."
    - name: "remediation_status"
      expr: remediation_status
      comment: "Current status of remediation activities (e.g., Pending, In Progress, Completed) — tracks remediation pipeline health."
    - name: "assessor_type"
      expr: assessor_type
      comment: "Classification of the assessor (e.g., Internal, Third-Party) — used to evaluate assessment independence and quality."
    - name: "audit_opinion"
      expr: audit_opinion
      comment: "Formal audit opinion issued (e.g., Unqualified, Qualified, Adverse) — critical for regulatory and investor reporting."
    - name: "period_end_year"
      expr: YEAR(period_end_date)
      comment: "Year of the assessment period end date — enables year-over-year compliance trend analysis."
    - name: "period_end_month"
      expr: DATE_TRUNC('MONTH', period_end_date)
      comment: "Month of the assessment period end date — supports monthly compliance cadence reporting."
    - name: "material_weakness_identified"
      expr: material_weakness_identified
      comment: "Boolean flag indicating whether a material weakness was identified — critical for SOX and regulatory escalation tracking."
    - name: "environmental_condition_identified"
      expr: environmental_condition_identified
      comment: "Boolean flag indicating whether an environmental condition was identified — drives ESG and environmental liability reporting."
    - name: "follow_up_assessment_required"
      expr: follow_up_assessment_required
      comment: "Boolean flag indicating whether a follow-up assessment is required — used to manage open compliance obligations."
    - name: "subtype"
      expr: subtype
      comment: "Sub-classification of the assessment type — enables granular segmentation within assessment categories."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of compliance assessments conducted — baseline volume metric for compliance program activity."
    - name: "non_compliant_assessments"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Count of assessments with a Non-Compliant status — directly measures the scale of active compliance failures across the portfolio."
    - name: "material_weakness_count"
      expr: COUNT(CASE WHEN material_weakness_identified = TRUE THEN 1 END)
      comment: "Number of assessments where a material weakness was identified — a critical risk indicator for regulatory and investor reporting."
    - name: "environmental_condition_count"
      expr: COUNT(CASE WHEN environmental_condition_identified = TRUE THEN 1 END)
      comment: "Number of assessments identifying an environmental condition — drives environmental liability and ESG risk quantification."
    - name: "remediation_required_count"
      expr: COUNT(CASE WHEN remediation_required = TRUE THEN 1 END)
      comment: "Number of assessments requiring remediation — measures the size of the active remediation backlog."
    - name: "total_estimated_remediation_cost"
      expr: SUM(CAST(estimated_remediation_cost AS DOUBLE))
      comment: "Total estimated cost of remediation across all assessments — key capital planning metric for compliance budget allocation."
    - name: "avg_estimated_remediation_cost"
      expr: AVG(CAST(estimated_remediation_cost AS DOUBLE))
      comment: "Average estimated remediation cost per assessment — benchmarks remediation cost intensity across property types and jurisdictions."
    - name: "avg_esg_score"
      expr: AVG(CAST(esg_score AS DOUBLE))
      comment: "Average ESG score across assessments — tracks portfolio-level ESG performance for investor and regulatory reporting."
    - name: "high_risk_assessment_count"
      expr: COUNT(CASE WHEN overall_risk_rating = 'High' THEN 1 END)
      comment: "Number of assessments rated High risk — used by leadership to prioritize compliance intervention and resource allocation."
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_assessment_required = TRUE THEN 1 END)
      comment: "Number of assessments requiring a follow-up — measures open compliance obligations and future assessment pipeline."
    - name: "assessments_with_overdue_remediation"
      expr: COUNT(CASE WHEN remediation_due_date < CURRENT_DATE() AND remediation_status != 'Completed' THEN 1 END)
      comment: "Number of assessments where remediation is past due and not yet completed — a leading indicator of regulatory penalty exposure."
    - name: "assessments_past_filing_deadline"
      expr: COUNT(CASE WHEN regulatory_filing_deadline < CURRENT_DATE() THEN 1 END)
      comment: "Number of assessments where the regulatory filing deadline has passed — measures regulatory filing delinquency risk."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`compliance_violation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Violation KPIs tracking penalty exposure, resolution rates, repeat violations, and severity distribution across the portfolio. Enables risk and legal teams to quantify regulatory liability and monitor enforcement trends."
  source: "`real_estate_ecm`.`compliance`.`violation`"
  dimensions:
    - name: "violation_type"
      expr: violation_type
      comment: "Category of the violation (e.g., Zoning, Environmental, Safety) — primary dimension for regulatory risk segmentation."
    - name: "violation_status"
      expr: violation_status
      comment: "Current status of the violation (e.g., Open, Resolved, Contested) — tracks the lifecycle of compliance enforcement actions."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the violation (e.g., Critical, High, Medium, Low) — drives prioritization of enforcement response."
    - name: "esg_category"
      expr: esg_category
      comment: "ESG pillar associated with the violation (e.g., Environmental, Social, Governance) — links violations to ESG reporting frameworks."
    - name: "is_repeat_violation"
      expr: is_repeat_violation
      comment: "Boolean flag indicating whether this is a repeat violation — repeat violations signal systemic compliance failures."
    - name: "is_contested"
      expr: is_contested
      comment: "Boolean flag indicating whether the violation is being contested — tracks legal dispute volume and associated cost exposure."
    - name: "osha_recordable"
      expr: osha_recordable
      comment: "Boolean flag indicating whether the violation is OSHA recordable — required for OSHA 300 log and regulatory reporting."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the violation — enables systemic analysis to drive preventive compliance programs."
    - name: "violation_year"
      expr: YEAR(violation_date)
      comment: "Year the violation occurred — supports year-over-year trend analysis of compliance enforcement activity."
    - name: "violation_month"
      expr: DATE_TRUNC('MONTH', violation_date)
      comment: "Month the violation occurred — enables monthly violation trend monitoring."
    - name: "governing_body"
      expr: governing_body
      comment: "Regulatory body that issued the violation — identifies which regulators are most active against the portfolio."
    - name: "subtype"
      expr: subtype
      comment: "Sub-classification of the violation type — enables granular regulatory risk segmentation."
  measures:
    - name: "total_violations"
      expr: COUNT(1)
      comment: "Total number of violations recorded — baseline measure of regulatory enforcement activity across the portfolio."
    - name: "open_violations"
      expr: COUNT(CASE WHEN violation_status = 'Open' THEN 1 END)
      comment: "Number of currently open violations — measures the active regulatory liability backlog requiring management attention."
    - name: "repeat_violations"
      expr: COUNT(CASE WHEN is_repeat_violation = TRUE THEN 1 END)
      comment: "Number of repeat violations — a critical indicator of systemic compliance failures and elevated regulatory scrutiny risk."
    - name: "total_penalty_assessed"
      expr: SUM(CAST(penalty_amount_assessed AS DOUBLE))
      comment: "Total penalty amount assessed across all violations — quantifies gross regulatory financial exposure for the portfolio."
    - name: "total_penalty_settled"
      expr: SUM(CAST(penalty_amount_settled AS DOUBLE))
      comment: "Total penalty amount actually settled — measures realized regulatory cost and compares against assessed exposure."
    - name: "avg_penalty_assessed"
      expr: AVG(CAST(penalty_amount_assessed AS DOUBLE))
      comment: "Average penalty amount per violation — benchmarks penalty severity and informs risk-based compliance investment decisions."
    - name: "contested_violations"
      expr: COUNT(CASE WHEN is_contested = TRUE THEN 1 END)
      comment: "Number of violations being legally contested — tracks legal dispute volume and associated litigation cost exposure."
    - name: "critical_violations"
      expr: COUNT(CASE WHEN severity_level = 'Critical' THEN 1 END)
      comment: "Number of critical severity violations — the highest-priority risk metric for executive and board-level compliance reporting."
    - name: "osha_recordable_violations"
      expr: COUNT(CASE WHEN osha_recordable = TRUE THEN 1 END)
      comment: "Number of OSHA recordable violations — required for regulatory reporting and tracks workplace safety compliance performance."
    - name: "violations_with_mandatory_report"
      expr: COUNT(CASE WHEN is_mandatory_report = TRUE THEN 1 END)
      comment: "Number of violations requiring mandatory regulatory reporting — measures the volume of high-stakes disclosure obligations."
    - name: "penalty_settlement_rate"
      expr: ROUND(100.0 * SUM(CAST(penalty_amount_settled AS DOUBLE)) / NULLIF(SUM(CAST(penalty_amount_assessed AS DOUBLE)), 0), 2)
      comment: "Percentage of assessed penalties that have been settled — measures legal resolution efficiency and remaining financial exposure."
    - name: "distinct_assets_with_violations"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of distinct assets with at least one violation — measures the breadth of compliance risk across the property portfolio."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`compliance_remediation_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Remediation action KPIs tracking cost, completion rates, escalation frequency, and overdue actions. Enables operations and compliance teams to manage remediation backlogs, control costs, and reduce regulatory penalty exposure."
  source: "`real_estate_ecm`.`compliance`.`remediation_action`"
  dimensions:
    - name: "action_status"
      expr: action_status
      comment: "Current status of the remediation action (e.g., Open, In Progress, Completed, Overdue) — primary lifecycle tracking dimension."
    - name: "action_type"
      expr: action_type
      comment: "Type of remediation action (e.g., Structural Repair, Environmental Cleanup, Policy Update) — segments remediation by nature of work."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the remediation action (e.g., Critical, High, Medium, Low) — drives resource allocation decisions."
    - name: "esg_category"
      expr: esg_category
      comment: "ESG pillar associated with the remediation action — links remediation spend to ESG performance improvement."
    - name: "cost_classification"
      expr: cost_classification
      comment: "Classification of the remediation cost (e.g., Capital, Operating) — supports financial planning and budget categorization."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category driving the remediation — enables systemic analysis to prevent recurrence."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Boolean flag indicating whether the action has been escalated — tracks management escalation volume and urgency."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Boolean flag indicating whether this is a recurring remediation issue — identifies chronic compliance problems."
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the compliance finding that triggered the remediation — links remediation to specific assessment findings."
    - name: "target_completion_year"
      expr: YEAR(target_completion_date)
      comment: "Year the remediation action is targeted for completion — supports annual remediation planning and budget forecasting."
    - name: "target_completion_month"
      expr: DATE_TRUNC('MONTH', target_completion_date)
      comment: "Month the remediation action is targeted for completion — enables monthly remediation pipeline management."
  measures:
    - name: "total_remediation_actions"
      expr: COUNT(1)
      comment: "Total number of remediation actions — baseline measure of remediation program activity and backlog size."
    - name: "open_remediation_actions"
      expr: COUNT(CASE WHEN action_status != 'Completed' THEN 1 END)
      comment: "Number of remediation actions not yet completed — measures the active remediation backlog requiring resource allocation."
    - name: "overdue_remediation_actions"
      expr: COUNT(CASE WHEN target_completion_date < CURRENT_DATE() AND action_status != 'Completed' THEN 1 END)
      comment: "Number of remediation actions past their target completion date — a leading indicator of regulatory penalty exposure and enforcement risk."
    - name: "escalated_actions"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of remediation actions that have been escalated — measures management escalation volume and urgency of compliance issues."
    - name: "recurring_actions"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Number of recurring remediation actions — identifies chronic compliance failures requiring systemic intervention."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all remediation actions — key input for compliance capital planning and budget forecasting."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred for completed remediation actions — measures realized compliance remediation spend."
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per remediation action — benchmarks remediation cost efficiency across action types and properties."
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_exposure_amount AS DOUBLE))
      comment: "Total regulatory penalty exposure associated with open remediation actions — quantifies the financial risk of non-completion."
    - name: "cost_overrun_actions"
      expr: COUNT(CASE WHEN actual_cost > estimated_cost AND actual_cost > 0 THEN 1 END)
      comment: "Number of remediation actions where actual cost exceeded the estimate — measures cost estimation accuracy and budget risk."
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN action_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of remediation actions that have been completed — measures overall remediation program execution effectiveness."
    - name: "distinct_assets_in_remediation"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of distinct assets with active remediation actions — measures the breadth of remediation activity across the portfolio."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory filing KPIs tracking filing timeliness, penalty exposure, amendment rates, and filing status distribution. Enables compliance and legal teams to manage regulatory submission obligations and minimize late-filing penalties."
  source: "`real_estate_ecm`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the regulatory filing (e.g., Submitted, Accepted, Rejected, Pending) — primary lifecycle tracking dimension."
    - name: "filing_type"
      expr: filing_type
      comment: "Type of regulatory filing (e.g., Annual Report, ESG Disclosure, SEC Form) — segments filing obligations by regulatory category."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category of the filing (e.g., Environmental, Financial, Fair Housing) — enables cross-domain compliance reporting."
    - name: "esg_category"
      expr: esg_category
      comment: "ESG pillar associated with the filing — links regulatory filings to ESG performance and disclosure frameworks."
    - name: "is_amendment"
      expr: is_amendment
      comment: "Boolean flag indicating whether the filing is an amendment — tracks restatement frequency as a data quality and governance indicator."
    - name: "is_material"
      expr: is_material
      comment: "Boolean flag indicating whether the filing is material — prioritizes high-stakes filings for executive oversight."
    - name: "governing_body"
      expr: governing_body
      comment: "Regulatory body to which the filing is submitted — identifies which regulators drive the highest filing volume and risk."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the regulatory filing — enables year-over-year filing compliance trend analysis."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the regulatory filing — supports quarterly compliance cadence and deadline management."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the filing (e.g., Online Portal, Mail, Electronic) — tracks submission channel adoption and efficiency."
    - name: "due_year"
      expr: YEAR(due_date)
      comment: "Year the filing is due — supports annual filing calendar planning and deadline management."
  measures:
    - name: "total_filings"
      expr: COUNT(1)
      comment: "Total number of regulatory filings — baseline measure of regulatory submission volume and compliance program activity."
    - name: "on_time_filings"
      expr: COUNT(CASE WHEN filing_date <= due_date AND filing_date IS NOT NULL THEN 1 END)
      comment: "Number of filings submitted on or before the due date — measures regulatory filing timeliness compliance."
    - name: "late_filings"
      expr: COUNT(CASE WHEN filing_date > due_date THEN 1 END)
      comment: "Number of filings submitted after the due date — directly measures regulatory non-compliance and penalty exposure risk."
    - name: "rejected_filings"
      expr: COUNT(CASE WHEN filing_status = 'Rejected' THEN 1 END)
      comment: "Number of filings rejected by the regulatory body — measures filing quality and rework burden."
    - name: "amendment_filings"
      expr: COUNT(CASE WHEN is_amendment = TRUE THEN 1 END)
      comment: "Number of amendment filings — tracks restatement frequency as an indicator of data quality and governance maturity."
    - name: "material_filings"
      expr: COUNT(CASE WHEN is_material = TRUE THEN 1 END)
      comment: "Number of material regulatory filings — identifies the highest-stakes submissions requiring executive oversight."
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_exposure_amount AS DOUBLE))
      comment: "Total regulatory penalty exposure across all filings — quantifies the financial risk of non-compliant or late submissions."
    - name: "avg_penalty_exposure"
      expr: AVG(CAST(penalty_exposure_amount AS DOUBLE))
      comment: "Average penalty exposure per filing — benchmarks risk intensity across filing types and regulatory bodies."
    - name: "on_time_filing_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN filing_date <= due_date AND filing_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN filing_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of submitted filings that were on time — the primary KPI for regulatory filing compliance performance."
    - name: "pending_filings"
      expr: COUNT(CASE WHEN filing_status = 'Pending' THEN 1 END)
      comment: "Number of filings currently in pending status — measures the volume of outstanding regulatory submissions requiring action."
    - name: "distinct_jurisdictions_filed"
      expr: COUNT(DISTINCT jurisdiction_id)
      comment: "Number of distinct jurisdictions with regulatory filings — measures the geographic breadth of regulatory compliance obligations."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`compliance_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Permit KPIs tracking permit status, expiry risk, fee spend, inspection outcomes, and renewal compliance. Enables property and compliance teams to manage permit portfolios and avoid operational disruptions from expired or lapsed permits."
  source: "`real_estate_ecm`.`compliance`.`permit`"
  dimensions:
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of the permit (e.g., Active, Expired, Pending, Revoked) — primary dimension for permit portfolio health monitoring."
    - name: "permit_type"
      expr: permit_type
      comment: "Type of permit (e.g., Building, Environmental, Occupancy, Fire Safety) — segments permit obligations by regulatory category."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the permit — identifies which regulatory bodies govern the most critical permits."
    - name: "inspection_required"
      expr: inspection_required
      comment: "Boolean flag indicating whether an inspection is required for the permit — tracks inspection obligation volume."
    - name: "renewal_required"
      expr: renewal_required
      comment: "Boolean flag indicating whether the permit requires renewal — identifies permits with ongoing compliance obligations."
    - name: "esg_relevant"
      expr: esg_relevant
      comment: "Boolean flag indicating whether the permit is ESG-relevant — links permit compliance to ESG reporting and green building programs."
    - name: "last_inspection_result"
      expr: last_inspection_result
      comment: "Result of the most recent inspection (e.g., Pass, Fail, Conditional) — tracks inspection compliance outcomes."
    - name: "leed_certification_level"
      expr: leed_certification_level
      comment: "LEED certification level associated with the permit — links permits to green building certification programs."
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the permit was issued — supports permit vintage analysis and renewal cycle planning."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the permit expires — enables proactive permit renewal planning and expiry risk management."
  measures:
    - name: "total_permits"
      expr: COUNT(1)
      comment: "Total number of permits in the portfolio — baseline measure of permit management scope."
    - name: "active_permits"
      expr: COUNT(CASE WHEN permit_status = 'Active' THEN 1 END)
      comment: "Number of currently active permits — measures the size of the compliant, operational permit portfolio."
    - name: "expired_permits"
      expr: COUNT(CASE WHEN permit_status = 'Expired' OR expiry_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of expired permits — directly measures operational compliance risk from lapsed permit coverage."
    - name: "permits_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) AND permit_status = 'Active' THEN 1 END)
      comment: "Number of active permits expiring within the next 90 days — a leading indicator for proactive renewal management."
    - name: "revoked_permits"
      expr: COUNT(CASE WHEN permit_status = 'Revoked' THEN 1 END)
      comment: "Number of revoked permits — measures the most severe permit compliance failures with direct operational impact."
    - name: "failed_inspections"
      expr: COUNT(CASE WHEN last_inspection_result = 'Fail' THEN 1 END)
      comment: "Number of permits with a failed last inspection — identifies properties with active inspection compliance deficiencies."
    - name: "total_permit_fees"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total permit fees paid across the portfolio — measures the direct cost of permit compliance for budget management."
    - name: "avg_permit_fee"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average permit fee — benchmarks permit cost intensity across property types and jurisdictions."
    - name: "total_floor_area_permitted"
      expr: SUM(CAST(floor_area_sqft AS DOUBLE))
      comment: "Total floor area covered by permits — measures the physical scope of permitted space across the portfolio."
    - name: "total_valuation_amount"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total valuation amount associated with permits — measures the asset value covered by active permit compliance."
    - name: "renewal_required_count"
      expr: COUNT(CASE WHEN renewal_required = TRUE THEN 1 END)
      comment: "Number of permits requiring renewal — measures the ongoing renewal obligation workload for the compliance team."
    - name: "distinct_assets_with_permits"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of distinct assets with at least one permit — measures the breadth of permit compliance obligations across the portfolio."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`compliance_green_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Green certification KPIs tracking certification coverage, scoring performance, renewal risk, and ESG reportability. Enables sustainability and asset management teams to monitor green building program performance and support ESG investor reporting."
  source: "`real_estate_ecm`.`compliance`.`green_certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the green certification (e.g., Active, Expired, In Progress) — primary dimension for certification portfolio health."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of green certification (e.g., LEED, BREEAM, ENERGY STAR) — segments the portfolio by green building standard."
    - name: "certification_level"
      expr: certification_level
      comment: "Level of certification achieved (e.g., Platinum, Gold, Silver, Certified) — measures the quality tier of green building performance."
    - name: "certifying_body"
      expr: certifying_body
      comment: "Organization that issued the certification — identifies which standards bodies govern the portfolio's green certifications."
    - name: "esg_reportable"
      expr: esg_reportable
      comment: "Boolean flag indicating whether the certification is reportable in ESG disclosures — links certifications to investor reporting obligations."
    - name: "incentive_eligible"
      expr: incentive_eligible
      comment: "Boolean flag indicating whether the certification qualifies for financial incentives — tracks potential cost recovery opportunities."
    - name: "green_lease_linked"
      expr: green_lease_linked
      comment: "Boolean flag indicating whether the certification is linked to a green lease — measures green lease program adoption."
    - name: "renewal_in_progress"
      expr: renewal_in_progress
      comment: "Boolean flag indicating whether a certification renewal is in progress — tracks active renewal pipeline."
    - name: "certification_year"
      expr: YEAR(certification_date)
      comment: "Year the certification was awarded — supports vintage analysis and certification program growth tracking."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the certification expires — enables proactive renewal planning and expiry risk management."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of green certifications in the portfolio — baseline measure of green building program coverage."
    - name: "active_certifications"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN 1 END)
      comment: "Number of currently active green certifications — measures the live green building footprint for ESG reporting."
    - name: "expired_certifications"
      expr: COUNT(CASE WHEN certification_status = 'Expired' OR expiry_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of expired certifications — measures the loss of green building status and associated ESG reporting gaps."
    - name: "certifications_expiring_within_180_days"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 180) AND certification_status = 'Active' THEN 1 END)
      comment: "Number of active certifications expiring within 180 days — a leading indicator for proactive renewal management."
    - name: "esg_reportable_certifications"
      expr: COUNT(CASE WHEN esg_reportable = TRUE THEN 1 END)
      comment: "Number of certifications flagged as ESG reportable — measures the scope of green building data available for investor ESG disclosures."
    - name: "incentive_eligible_certifications"
      expr: COUNT(CASE WHEN incentive_eligible = TRUE THEN 1 END)
      comment: "Number of certifications eligible for financial incentives — quantifies potential cost recovery from green building programs."
    - name: "total_certified_area_sqft"
      expr: SUM(CAST(certified_area_sqft AS DOUBLE))
      comment: "Total floor area covered by green certifications — measures the physical scale of the certified green building portfolio."
    - name: "avg_score_percentage"
      expr: AVG(CAST(score_percentage AS DOUBLE))
      comment: "Average certification score percentage — benchmarks the quality of green building performance across the portfolio."
    - name: "avg_points_scored"
      expr: AVG(CAST(points_scored AS DOUBLE))
      comment: "Average points scored in certification assessments — tracks green building performance against certification benchmarks."
    - name: "total_points_scored"
      expr: SUM(CAST(points_scored AS DOUBLE))
      comment: "Total points scored across all certifications — aggregate measure of green building program achievement."
    - name: "certification_score_achievement_rate"
      expr: ROUND(100.0 * SUM(CAST(points_scored AS DOUBLE)) / NULLIF(SUM(CAST(points_available AS DOUBLE)), 0), 2)
      comment: "Percentage of available certification points achieved across the portfolio — measures overall green building program effectiveness."
    - name: "distinct_assets_certified"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of distinct assets with at least one green certification — measures the breadth of green building coverage across the portfolio."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`compliance_esg_metric`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ESG metric KPIs tracking environmental performance, social indicators, governance scores, and target achievement rates. Enables sustainability and investor relations teams to monitor ESG program performance against targets and reporting frameworks."
  source: "`real_estate_ecm`.`compliance`.`esg_metric`"
  dimensions:
    - name: "esg_pillar"
      expr: esg_pillar
      comment: "ESG pillar of the metric (Environmental, Social, Governance) — primary dimension for ESG performance segmentation."
    - name: "metric_category"
      expr: metric_category
      comment: "Category of the ESG metric (e.g., Energy, Water, GHG, Diversity) — enables granular ESG performance analysis."
    - name: "metric_status"
      expr: metric_status
      comment: "Current status of the ESG metric (e.g., Active, Archived, Under Review) — tracks the lifecycle of ESG data points."
    - name: "reporting_framework"
      expr: reporting_framework
      comment: "ESG reporting framework the metric aligns to (e.g., GRI, SASB, TCFD, GRESB) — links metrics to investor disclosure standards."
    - name: "verification_status"
      expr: verification_status
      comment: "Third-party verification status of the ESG metric (e.g., Verified, Unverified, In Progress) — measures data assurance quality."
    - name: "ghg_scope"
      expr: ghg_scope
      comment: "GHG emissions scope (Scope 1, 2, 3) — required dimension for carbon footprint and climate risk reporting."
    - name: "is_landlord_controlled"
      expr: is_landlord_controlled
      comment: "Boolean flag indicating whether the metric is under landlord operational control — distinguishes landlord vs. tenant ESG responsibility."
    - name: "is_like_for_like"
      expr: is_like_for_like
      comment: "Boolean flag indicating whether the metric is on a like-for-like basis — required for GRESB and comparable ESG performance reporting."
    - name: "reporting_period_year"
      expr: YEAR(reporting_period_end)
      comment: "Year of the ESG reporting period — enables year-over-year ESG performance trend analysis."
    - name: "data_source"
      expr: data_source
      comment: "Source of the ESG data (e.g., Smart Meter, Manual Entry, Utility Bill) — tracks data quality and collection method."
  measures:
    - name: "total_esg_metrics"
      expr: COUNT(1)
      comment: "Total number of ESG metric records — baseline measure of ESG data collection coverage."
    - name: "verified_metrics"
      expr: COUNT(CASE WHEN verification_status = 'Verified' THEN 1 END)
      comment: "Number of ESG metrics with third-party verification — measures the assurance quality of ESG disclosures."
    - name: "avg_metric_value"
      expr: AVG(CAST(metric_value AS DOUBLE))
      comment: "Average ESG metric value across records — provides a normalized view of ESG performance for cross-portfolio benchmarking."
    - name: "total_metric_value"
      expr: SUM(CAST(metric_value AS DOUBLE))
      comment: "Total ESG metric value — used for additive ESG indicators such as total energy consumption or total GHG emissions."
    - name: "avg_target_achievement_rate"
      expr: ROUND(100.0 * AVG(CAST(metric_value AS DOUBLE)) / NULLIF(AVG(CAST(target_value AS DOUBLE)), 0), 2)
      comment: "Average ratio of actual metric value to target value — measures ESG target achievement rate across the portfolio."
    - name: "avg_renewable_energy_pct"
      expr: AVG(CAST(renewable_energy_pct AS DOUBLE))
      comment: "Average renewable energy percentage across ESG metrics — tracks progress toward renewable energy targets for climate reporting."
    - name: "avg_waste_diversion_rate"
      expr: AVG(CAST(waste_diversion_rate AS DOUBLE))
      comment: "Average waste diversion rate — measures portfolio-level waste management performance for ESG and sustainability reporting."
    - name: "avg_coverage_pct"
      expr: AVG(CAST(coverage_pct AS DOUBLE))
      comment: "Average data coverage percentage — measures the completeness of ESG data collection across the portfolio."
    - name: "total_community_investment"
      expr: SUM(CAST(community_investment_usd AS DOUBLE))
      comment: "Total community investment in USD — measures the social impact investment component of the ESG program."
    - name: "avg_tenant_satisfaction_score"
      expr: AVG(CAST(tenant_satisfaction_score AS DOUBLE))
      comment: "Average tenant satisfaction score — a key social ESG indicator linking occupant experience to portfolio performance."
    - name: "avg_board_diversity_pct"
      expr: AVG(CAST(board_diversity_pct AS DOUBLE))
      comment: "Average board diversity percentage — measures governance ESG performance for investor and regulatory disclosure."
    - name: "like_for_like_metrics"
      expr: COUNT(CASE WHEN is_like_for_like = TRUE THEN 1 END)
      comment: "Number of like-for-like ESG metrics — measures the volume of comparable data available for GRESB and peer benchmarking."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`compliance_fair_housing_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fair housing KPIs tracking complaint volumes, resolution rates, settlement costs, and accommodation outcomes. Enables legal and compliance teams to monitor fair housing risk exposure and demonstrate regulatory compliance to HUD and other bodies."
  source: "`real_estate_ecm`.`compliance`.`fair_housing_record`"
  dimensions:
    - name: "record_type"
      expr: record_type
      comment: "Type of fair housing record (e.g., Complaint, Accommodation Request, Audit) — primary classification for fair housing case management."
    - name: "complaint_type"
      expr: complaint_type
      comment: "Type of fair housing complaint (e.g., Discrimination, Harassment, Retaliation) — segments complaints by nature of allegation."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the fair housing record (e.g., Open, Resolved, Pending Investigation) — tracks case lifecycle."
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Outcome of the resolved case (e.g., Dismissed, Settled, Conciliated) — measures the nature of fair housing case resolutions."
    - name: "protected_class_categories"
      expr: protected_class_categories
      comment: "Protected class categories involved in the complaint (e.g., Race, Disability, Familial Status) — required for fair housing risk analysis."
    - name: "accommodation_type"
      expr: accommodation_type
      comment: "Type of reasonable accommodation requested — tracks accommodation request patterns for ADA and fair housing compliance."
    - name: "accommodation_approved"
      expr: accommodation_approved
      comment: "Boolean flag indicating whether the accommodation was approved — measures accommodation approval rates for compliance monitoring."
    - name: "ada_applicable"
      expr: ada_applicable
      comment: "Boolean flag indicating whether ADA requirements apply to the record — segments cases by ADA compliance obligations."
    - name: "legal_counsel_assigned"
      expr: legal_counsel_assigned
      comment: "Boolean flag indicating whether legal counsel has been assigned — tracks legal escalation volume and associated cost exposure."
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year the fair housing incident occurred — enables year-over-year fair housing complaint trend analysis."
  measures:
    - name: "total_fair_housing_records"
      expr: COUNT(1)
      comment: "Total number of fair housing records — baseline measure of fair housing compliance activity and risk exposure."
    - name: "open_cases"
      expr: COUNT(CASE WHEN resolution_status = 'Open' THEN 1 END)
      comment: "Number of currently open fair housing cases — measures the active legal and regulatory risk backlog."
    - name: "hud_filed_cases"
      expr: COUNT(CASE WHEN hud_case_number IS NOT NULL THEN 1 END)
      comment: "Number of cases filed with HUD — measures the volume of formal federal fair housing complaints requiring regulatory response."
    - name: "cases_with_legal_counsel"
      expr: COUNT(CASE WHEN legal_counsel_assigned = TRUE THEN 1 END)
      comment: "Number of cases with legal counsel assigned — measures the volume of legally escalated fair housing matters."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement amount paid across all fair housing cases — quantifies the realized financial cost of fair housing non-compliance."
    - name: "avg_settlement_amount"
      expr: AVG(CAST(settlement_amount AS DOUBLE))
      comment: "Average settlement amount per resolved case — benchmarks fair housing settlement cost intensity for risk provisioning."
    - name: "accommodation_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN accommodation_approved = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN accommodation_type IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of accommodation requests that were approved — measures ADA and fair housing accommodation compliance rate."
    - name: "overdue_hud_responses"
      expr: COUNT(CASE WHEN hud_response_due_date < CURRENT_DATE() AND hud_response_submitted_date IS NULL THEN 1 END)
      comment: "Number of HUD responses that are past due and not yet submitted — measures regulatory response delinquency risk."
    - name: "resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN resolution_status = 'Resolved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of fair housing records that have been resolved — measures case management effectiveness and backlog clearance rate."
    - name: "distinct_assets_with_complaints"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of distinct assets with fair housing complaints — measures the breadth of fair housing risk across the property portfolio."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`compliance_regulatory_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory obligation KPIs tracking obligation inventory, mandatory vs. recurring obligations, penalty exposure, and renewal risk. Enables compliance program managers to maintain a governed inventory of regulatory requirements and prioritize high-risk obligations."
  source: "`real_estate_ecm`.`compliance`.`regulatory_obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of regulatory obligation (e.g., Permit, Filing, Disclosure, Inspection) — primary classification for obligation management."
    - name: "obligation_category"
      expr: obligation_category
      comment: "Category of the obligation (e.g., Environmental, Financial, Safety) — segments obligations by compliance domain."
    - name: "regulatory_obligation_status"
      expr: regulatory_obligation_status
      comment: "Current status of the obligation (e.g., Active, Expired, Superseded) — tracks the lifecycle of regulatory requirements."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the obligation (e.g., High, Medium, Low) — drives prioritization of compliance resources."
    - name: "esg_category"
      expr: esg_category
      comment: "ESG pillar associated with the obligation — links regulatory requirements to ESG reporting frameworks."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Boolean flag indicating whether the obligation is mandatory — distinguishes legally required from voluntary compliance activities."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Boolean flag indicating whether the obligation recurs periodically — identifies ongoing compliance workload."
    - name: "requires_third_party_audit"
      expr: requires_third_party_audit
      comment: "Boolean flag indicating whether a third-party audit is required — tracks external audit obligations and associated costs."
    - name: "governing_body"
      expr: governing_body
      comment: "Regulatory body governing the obligation — identifies which regulators impose the most significant compliance burdens."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for fulfilling the obligation — enables workload distribution analysis across compliance teams."
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of regulatory obligations in the inventory — baseline measure of the compliance program scope."
    - name: "active_obligations"
      expr: COUNT(CASE WHEN regulatory_obligation_status = 'Active' THEN 1 END)
      comment: "Number of currently active regulatory obligations — measures the live compliance workload across the organization."
    - name: "mandatory_obligations"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN 1 END)
      comment: "Number of mandatory regulatory obligations — quantifies the non-discretionary compliance burden."
    - name: "recurring_obligations"
      expr: COUNT(CASE WHEN is_recurring = TRUE THEN 1 END)
      comment: "Number of recurring obligations — measures the ongoing periodic compliance workload for resource planning."
    - name: "third_party_audit_required_count"
      expr: COUNT(CASE WHEN requires_third_party_audit = TRUE THEN 1 END)
      comment: "Number of obligations requiring third-party audits — quantifies external audit obligations and associated budget requirements."
    - name: "high_risk_obligations"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Number of high-risk regulatory obligations — the primary prioritization metric for compliance resource allocation."
    - name: "total_max_penalty_exposure"
      expr: SUM(CAST(max_penalty_amount AS DOUBLE))
      comment: "Total maximum penalty exposure across all obligations — quantifies the gross regulatory financial risk of the obligation portfolio."
    - name: "avg_max_penalty_amount"
      expr: AVG(CAST(max_penalty_amount AS DOUBLE))
      comment: "Average maximum penalty per obligation — benchmarks penalty severity across obligation types and regulatory bodies."
    - name: "obligations_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) AND regulatory_obligation_status = 'Active' THEN 1 END)
      comment: "Number of active obligations expiring within 90 days — a leading indicator for proactive renewal and re-registration management."
    - name: "distinct_jurisdictions_covered"
      expr: COUNT(DISTINCT jurisdiction_id)
      comment: "Number of distinct jurisdictions with active regulatory obligations — measures the geographic breadth of the compliance program."
$$;