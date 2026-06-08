-- Metric views for domain: partnership | Business: Ngo | Version: 1 | Generated on: 2026-05-07 03:19:07

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`partnership_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over partnership agreements — tracks portfolio composition, financial exposure, risk profile, and lifecycle health across all active and historical partner agreements."
  source: "`ngo_ecm`.`partnership`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current lifecycle status of the agreement (e.g. Active, Expired, Terminated) — primary filter for portfolio health analysis."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Classification of the agreement (e.g. Sub-Award, MOU, Grant Agreement) — used to segment portfolio by instrument type."
    - name: "is_sub_award"
      expr: is_sub_award
      comment: "Indicates whether the agreement is a sub-award — enables prime vs. sub-award portfolio split."
    - name: "is_consortium_agreement"
      expr: is_consortium_agreement
      comment: "Flags consortium agreements — used to track multi-partner arrangements separately."
    - name: "program_sector"
      expr: program_sector
      comment: "Humanitarian or development sector (e.g. Health, WASH, Education) — enables sector-level portfolio analysis."
    - name: "operational_country_code"
      expr: operational_country_code
      comment: "ISO country code where the agreement is operationally active — supports geographic portfolio breakdown."
    - name: "due_diligence_risk_rating"
      expr: due_diligence_risk_rating
      comment: "Risk rating assigned during due diligence (e.g. Low, Medium, High) — critical for risk-tiered portfolio management."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency at which the partner must report (e.g. Monthly, Quarterly) — used to assess reporting burden and compliance risk."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the agreement funding ceiling — supports multi-currency portfolio analysis."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the agreement became effective — enables cohort and trend analysis of agreement starts."
    - name: "effective_end_year"
      expr: YEAR(effective_end_date)
      comment: "Year the agreement is scheduled to end — used to forecast portfolio expiry and renewal pipeline."
    - name: "capacity_assessment_status"
      expr: capacity_assessment_status
      comment: "Status of the partner capacity assessment linked to this agreement — used to flag agreements with unresolved capacity gaps."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope descriptor of the agreement — supports regional portfolio segmentation."
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total number of agreements in the portfolio — baseline measure for portfolio size tracking."
    - name: "total_funding_ceiling_amount"
      expr: SUM(CAST(funding_ceiling_amount AS DOUBLE))
      comment: "Sum of all agreement funding ceilings — represents total financial exposure and commitment across the partnership portfolio."
    - name: "avg_funding_ceiling_amount"
      expr: AVG(CAST(funding_ceiling_amount AS DOUBLE))
      comment: "Average funding ceiling per agreement — benchmarks typical agreement size and informs resource allocation decisions."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate across agreements — monitors overhead burden and donor compliance with indirect cost caps."
    - name: "total_indirect_cost_amount"
      expr: SUM(CAST(funding_ceiling_amount AS DOUBLE) * CAST(indirect_cost_rate AS DOUBLE) / 100.0)
      comment: "Estimated total indirect cost across all agreements (funding ceiling × indirect cost rate) — quantifies overhead exposure for financial planning."
    - name: "high_risk_agreement_count"
      expr: COUNT(CASE WHEN due_diligence_risk_rating IN ('High', 'Critical') THEN 1 END)
      comment: "Number of agreements with high or critical due diligence risk ratings — key risk management KPI for leadership escalation."
    - name: "sub_award_count"
      expr: COUNT(CASE WHEN is_sub_award = TRUE THEN 1 END)
      comment: "Number of sub-award agreements — tracks downstream partner engagement and sub-award compliance obligations."
    - name: "consortium_agreement_count"
      expr: COUNT(CASE WHEN is_consortium_agreement = TRUE THEN 1 END)
      comment: "Number of consortium agreements — measures multi-partner collaboration depth in the portfolio."
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN 1 END)
      comment: "Number of currently active agreements — primary operational portfolio health indicator."
    - name: "terminated_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'Terminated' THEN 1 END)
      comment: "Number of terminated agreements — tracks early termination rate as a partnership quality signal."
    - name: "distinct_partner_orgs"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of distinct partner organizations with agreements — measures breadth of the partnership network."
    - name: "renewal_option_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN renewal_option = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of agreements that include a renewal option — indicates partnership continuity planning and long-term relationship investment."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`partnership_partner_org`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the partner organization master registry — tracks partner portfolio composition, risk profile, capacity, and due diligence health across all registered partner organizations."
  source: "`ngo_ecm`.`partnership`.`partner_org`"
  dimensions:
    - name: "org_type"
      expr: org_type
      comment: "Type of partner organization (e.g. INGO, Local NGO, Government, UN Agency) — primary segmentation dimension for partner portfolio analysis."
    - name: "partnership_status"
      expr: partnership_status
      comment: "Current status of the partnership relationship (e.g. Active, Inactive, Suspended) — used to filter operational vs. dormant partners."
    - name: "due_diligence_status"
      expr: due_diligence_status
      comment: "Current due diligence status of the partner (e.g. Approved, Pending, Expired) — critical compliance and risk management dimension."
    - name: "hq_country"
      expr: hq_country
      comment: "Country where the partner organization is headquartered — supports geographic partner portfolio analysis."
    - name: "chs_certified"
      expr: chs_certified
      comment: "Whether the partner holds Core Humanitarian Standard certification — quality and accountability indicator."
    - name: "sanctions_screened"
      expr: sanctions_screened
      comment: "Whether the partner has been screened against sanctions lists — compliance gate indicator."
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Accreditation status of the partner organization — used to tier partners by qualification level."
  measures:
    - name: "total_partner_orgs"
      expr: COUNT(1)
      comment: "Total number of registered partner organizations — baseline measure for partnership network size."
    - name: "active_partner_count"
      expr: COUNT(CASE WHEN partnership_status = 'Active' THEN 1 END)
      comment: "Number of currently active partner organizations — measures the live operational partnership network."
    - name: "due_diligence_approved_count"
      expr: COUNT(CASE WHEN due_diligence_status = 'Approved' THEN 1 END)
      comment: "Number of partners with approved due diligence — tracks compliance readiness of the partner portfolio."
    - name: "due_diligence_expired_count"
      expr: COUNT(CASE WHEN due_diligence_status = 'Expired' THEN 1 END)
      comment: "Number of partners with expired due diligence — flags compliance risk requiring immediate remediation."
    - name: "chs_certified_count"
      expr: COUNT(CASE WHEN chs_certified = TRUE THEN 1 END)
      comment: "Number of CHS-certified partner organizations — measures quality and accountability standard adoption across the partner network."
    - name: "chs_certification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN chs_certified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partner organizations holding CHS certification — strategic KPI for localization and partner quality benchmarking."
    - name: "sanctions_screened_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sanctions_screened = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners that have been sanctions-screened — compliance coverage rate; any gap triggers immediate regulatory risk."
    - name: "avg_capacity_assessment_score"
      expr: AVG(CAST(capacity_assessment_score AS DOUBLE))
      comment: "Average capacity assessment score across all partner organizations — portfolio-level indicator of partner organizational strength."
    - name: "avg_annual_budget_usd"
      expr: AVG(CAST(annual_budget_usd AS DOUBLE))
      comment: "Average annual budget (USD) of partner organizations — benchmarks partner financial scale and informs sub-award sizing decisions."
    - name: "total_annual_budget_usd"
      expr: SUM(CAST(annual_budget_usd AS DOUBLE))
      comment: "Total combined annual budget (USD) across all partner organizations — measures aggregate financial capacity of the partnership network."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`partnership_capacity_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over partner capacity assessments — tracks assessment coverage, scoring trends, risk distribution, and capacity building triggers across the partner portfolio."
  source: "`ngo_ecm`.`partnership`.`capacity_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of capacity assessment conducted (e.g. Pre-Award, Annual, Triggered) — used to segment assessments by purpose."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (e.g. Completed, In Progress, Overdue) — operational pipeline tracking dimension."
    - name: "overall_risk_rating"
      expr: overall_risk_rating
      comment: "Overall risk rating assigned by the assessment (e.g. Low, Medium, High, Critical) — primary risk segmentation dimension."
    - name: "financial_risk_rating"
      expr: financial_risk_rating
      comment: "Financial management risk rating from the assessment — used to flag partners requiring enhanced financial oversight."
    - name: "assessment_location_country"
      expr: assessment_location_country
      comment: "Country where the assessment was conducted — supports geographic risk analysis."
    - name: "assessment_methodology"
      expr: assessment_methodology
      comment: "Methodology used for the assessment (e.g. OCAT, NUPAS, Internal Tool) — enables methodology consistency analysis."
    - name: "capacity_building_plan_required"
      expr: capacity_building_plan_required
      comment: "Whether a capacity building plan was triggered by this assessment — used to track remediation pipeline."
    - name: "enhanced_monitoring_required"
      expr: enhanced_monitoring_required
      comment: "Whether enhanced monitoring was required as an outcome — flags high-risk partners needing intensified oversight."
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year the assessment was conducted — enables year-over-year trend analysis of partner risk profiles."
    - name: "payment_modality_recommendation"
      expr: payment_modality_recommendation
      comment: "Recommended payment modality based on assessment outcome (e.g. Advance, Reimbursement) — informs financial risk controls."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of capacity assessments conducted — baseline measure for assessment program coverage."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall capacity score across all assessments — portfolio-level indicator of partner organizational health."
    - name: "avg_financial_mgmt_score"
      expr: AVG(CAST(financial_mgmt_score AS DOUBLE))
      comment: "Average financial management score — tracks financial accountability capacity across the partner portfolio."
    - name: "avg_governance_score"
      expr: AVG(CAST(governance_score AS DOUBLE))
      comment: "Average governance score — measures organizational governance quality across assessed partners."
    - name: "avg_program_mgmt_score"
      expr: AVG(CAST(program_mgmt_score AS DOUBLE))
      comment: "Average program management score — tracks programmatic delivery capacity across the partner portfolio."
    - name: "avg_mel_score"
      expr: AVG(CAST(mel_score AS DOUBLE))
      comment: "Average Monitoring, Evaluation and Learning (MEL) score — measures partner data and accountability capacity."
    - name: "high_risk_assessment_count"
      expr: COUNT(CASE WHEN overall_risk_rating IN ('High', 'Critical') THEN 1 END)
      comment: "Number of assessments resulting in a High or Critical risk rating — key risk management KPI for leadership escalation and resource prioritization."
    - name: "capacity_building_plan_triggered_count"
      expr: COUNT(CASE WHEN capacity_building_plan_required = TRUE THEN 1 END)
      comment: "Number of assessments that triggered a capacity building plan requirement — measures remediation pipeline volume."
    - name: "enhanced_monitoring_triggered_count"
      expr: COUNT(CASE WHEN enhanced_monitoring_required = TRUE THEN 1 END)
      comment: "Number of assessments requiring enhanced monitoring — quantifies the high-risk partner oversight burden."
    - name: "high_risk_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_risk_rating IN ('High', 'Critical') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments resulting in High or Critical risk — strategic risk concentration indicator for the partnership portfolio."
    - name: "avg_partner_self_assessment_score"
      expr: AVG(CAST(partner_self_assessment_score AS DOUBLE))
      comment: "Average partner self-assessment score — compared against assessor scores to identify perception gaps and transparency issues."
    - name: "distinct_partners_assessed"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of distinct partner organizations assessed — measures assessment program coverage breadth."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`partnership_partner_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over partner performance reviews — tracks programmatic quality, financial accountability, reporting compliance, and corrective action rates across the partner portfolio."
  source: "`ngo_ecm`.`partnership`.`partner_performance_review`"
  dimensions:
    - name: "overall_performance_rating"
      expr: overall_performance_rating
      comment: "Overall performance rating assigned in the review (e.g. Satisfactory, Unsatisfactory, Excellent) — primary partner quality segmentation dimension."
    - name: "review_type"
      expr: review_type
      comment: "Type of performance review (e.g. Mid-Term, Final, Ad-Hoc) — used to segment reviews by purpose and timing."
    - name: "review_status"
      expr: review_status
      comment: "Current status of the review process (e.g. Completed, Draft, Pending Approval) — operational pipeline tracking."
    - name: "financial_accountability_rating"
      expr: financial_accountability_rating
      comment: "Rating for financial accountability (e.g. Strong, Adequate, Weak) — used to flag partners with financial management concerns."
    - name: "programmatic_quality_rating"
      expr: programmatic_quality_rating
      comment: "Rating for programmatic delivery quality — measures partner effectiveness in achieving program outcomes."
    - name: "reporting_compliance_rating"
      expr: reporting_compliance_rating
      comment: "Rating for reporting compliance — tracks partner adherence to reporting obligations."
    - name: "safeguarding_compliance_rating"
      expr: safeguarding_compliance_rating
      comment: "Rating for safeguarding compliance — critical accountability dimension for donor and regulatory requirements."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether a corrective action was required as a review outcome — flags underperforming partners."
    - name: "partnership_renewal_recommendation"
      expr: partnership_renewal_recommendation
      comment: "Recommendation on whether to renew the partnership — strategic decision-support dimension."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned during the performance review — used for risk-tiered partner management."
    - name: "review_year"
      expr: YEAR(review_date)
      comment: "Year the performance review was conducted — enables year-over-year partner performance trend analysis."
    - name: "capacity_building_recommended"
      expr: capacity_building_recommended
      comment: "Whether capacity building was recommended as a review outcome — tracks remediation pipeline."
  measures:
    - name: "total_performance_reviews"
      expr: COUNT(1)
      comment: "Total number of partner performance reviews conducted — baseline measure for review program coverage."
    - name: "avg_overall_performance_score"
      expr: AVG(CAST(overall_performance_score AS DOUBLE))
      comment: "Average overall performance score across all reviews — portfolio-level indicator of partner delivery quality."
    - name: "avg_budget_utilisation_rate"
      expr: AVG(CAST(budget_utilisation_rate AS DOUBLE))
      comment: "Average budget utilisation rate across partner reviews — measures financial absorption capacity and spending efficiency."
    - name: "avg_milestone_achievement_rate"
      expr: AVG(CAST(milestone_achievement_rate AS DOUBLE))
      comment: "Average milestone achievement rate across reviews — measures programmatic delivery effectiveness against planned targets."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of reviews that triggered a corrective action requirement — measures underperformance incidence across the partner portfolio."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews resulting in a corrective action — strategic quality KPI; high rates signal systemic partner performance issues."
    - name: "field_visit_conducted_count"
      expr: COUNT(CASE WHEN field_visit_conducted = TRUE THEN 1 END)
      comment: "Number of reviews that included a field visit — measures quality of oversight and direct verification coverage."
    - name: "field_visit_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN field_visit_conducted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews that included a field visit — tracks oversight intensity and accountability verification coverage."
    - name: "beneficiary_feedback_incorporated_count"
      expr: COUNT(CASE WHEN beneficiary_feedback_incorporated = TRUE THEN 1 END)
      comment: "Number of reviews that incorporated beneficiary feedback — measures accountability to affected populations (AAP) compliance."
    - name: "distinct_partners_reviewed"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of distinct partner organizations reviewed — measures performance review program coverage breadth."
    - name: "capacity_building_recommended_count"
      expr: COUNT(CASE WHEN capacity_building_recommended = TRUE THEN 1 END)
      comment: "Number of reviews recommending capacity building — quantifies the remediation and strengthening pipeline."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`partnership_partner_report_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over partner report submissions — tracks reporting compliance, timeliness, quality, and financial accountability across all partner reporting obligations."
  source: "`ngo_ecm`.`partnership`.`partner_report_submission`"
  dimensions:
    - name: "report_type"
      expr: report_type
      comment: "Type of report submitted (e.g. Narrative, Financial, MEL) — used to segment reporting compliance by report category."
    - name: "review_status"
      expr: review_status
      comment: "Current review status of the submitted report (e.g. Accepted, Under Review, Rejected) — tracks report processing pipeline."
    - name: "is_late_submission"
      expr: is_late_submission
      comment: "Whether the report was submitted after the due date — primary timeliness compliance indicator."
    - name: "country_code"
      expr: country_code
      comment: "Country associated with the report submission — supports geographic reporting compliance analysis."
    - name: "report_period_frequency"
      expr: report_period_frequency
      comment: "Frequency of the reporting period (e.g. Monthly, Quarterly, Annual) — used to segment compliance by reporting cycle."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the report (e.g. Email, Portal, Physical) — tracks digital adoption and process efficiency."
    - name: "donor_reporting_obligation"
      expr: donor_reporting_obligation
      comment: "Whether the report fulfills a donor reporting obligation — used to prioritize compliance monitoring for donor-facing reports."
    - name: "mel_indicators_reported"
      expr: mel_indicators_reported
      comment: "Whether MEL indicators were included in the report — tracks data quality and results reporting completeness."
    - name: "financial_documentation_attached"
      expr: financial_documentation_attached
      comment: "Whether financial documentation was attached to the report — measures financial accountability compliance."
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the report was submitted — enables year-over-year reporting compliance trend analysis."
    - name: "cluster_sector"
      expr: cluster_sector
      comment: "Humanitarian cluster or sector associated with the report — supports sector-level reporting compliance analysis."
  measures:
    - name: "total_report_submissions"
      expr: COUNT(1)
      comment: "Total number of partner report submissions — baseline measure for reporting volume and program coverage."
    - name: "late_submission_count"
      expr: COUNT(CASE WHEN is_late_submission = TRUE THEN 1 END)
      comment: "Number of reports submitted after the due date — key compliance KPI; high counts signal partner reporting capacity issues."
    - name: "late_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_late_submission = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports submitted late — strategic reporting compliance KPI used in partner performance assessments and donor reporting."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score of submitted reports — measures report quality and partner accountability standards across the portfolio."
    - name: "total_expenditure_reported_usd"
      expr: SUM(CAST(total_expenditure_reported AS DOUBLE))
      comment: "Total expenditure reported across all partner report submissions — measures financial accountability coverage and reported burn rate."
    - name: "avg_expenditure_reported_usd"
      expr: AVG(CAST(total_expenditure_reported AS DOUBLE))
      comment: "Average expenditure reported per submission — benchmarks typical financial reporting volume per partner report."
    - name: "donor_obligation_report_count"
      expr: COUNT(CASE WHEN donor_reporting_obligation = TRUE THEN 1 END)
      comment: "Number of reports fulfilling donor reporting obligations — tracks compliance with donor contractual requirements."
    - name: "mel_indicators_reported_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mel_indicators_reported = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports that included MEL indicators — measures results data completeness and partner accountability to outcomes."
    - name: "financial_documentation_attached_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN financial_documentation_attached = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports with financial documentation attached — tracks financial accountability compliance rate across the partner portfolio."
    - name: "distinct_partners_reporting"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of distinct partner organizations that have submitted reports — measures reporting program coverage breadth."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`partnership_due_diligence_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over partner due diligence records — tracks compliance coverage, risk levels, verification status, and certification health across all partner due diligence processes."
  source: "`ngo_ecm`.`partnership`.`due_diligence_record`"
  dimensions:
    - name: "diligence_status"
      expr: diligence_status
      comment: "Current status of the due diligence process (e.g. Approved, Pending, Rejected) — primary compliance pipeline dimension."
    - name: "diligence_type"
      expr: diligence_type
      comment: "Type of due diligence conducted (e.g. Pre-Award, Annual, Enhanced) — used to segment compliance by process type."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned as a due diligence outcome (e.g. Low, Medium, High) — primary risk segmentation dimension."
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Overall outcome of the due diligence process (e.g. Approved, Conditional, Rejected) — strategic partner eligibility indicator."
    - name: "aml_cft_check_status"
      expr: aml_cft_check_status
      comment: "Status of the Anti-Money Laundering / Counter-Financing of Terrorism check — critical regulatory compliance dimension."
    - name: "debarment_check_status"
      expr: debarment_check_status
      comment: "Status of the debarment check — flags partners excluded from donor-funded activities."
    - name: "chs_certification_status"
      expr: chs_certification_status
      comment: "CHS certification status verified during due diligence — quality and accountability compliance dimension."
    - name: "ngo_registration_country"
      expr: ngo_registration_country
      comment: "Country of NGO legal registration — supports geographic compliance analysis."
    - name: "financial_audit_opinion"
      expr: financial_audit_opinion
      comment: "External audit opinion on partner financials (e.g. Unqualified, Qualified, Adverse) — financial accountability risk indicator."
    - name: "safeguarding_policy_verified"
      expr: safeguarding_policy_verified
      comment: "Whether the partner safeguarding policy was verified — critical accountability and donor compliance dimension."
  measures:
    - name: "total_due_diligence_records"
      expr: COUNT(1)
      comment: "Total number of due diligence records — baseline measure for compliance program coverage."
    - name: "approved_due_diligence_count"
      expr: COUNT(CASE WHEN diligence_status = 'Approved' THEN 1 END)
      comment: "Number of due diligence records with approved status — measures compliant partner count ready for engagement."
    - name: "high_risk_due_diligence_count"
      expr: COUNT(CASE WHEN risk_level IN ('High', 'Critical') THEN 1 END)
      comment: "Number of due diligence records with high or critical risk levels — key risk management KPI for leadership oversight."
    - name: "high_risk_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_level IN ('High', 'Critical') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of due diligence records with high or critical risk — strategic risk concentration indicator for the partner portfolio."
    - name: "safeguarding_verified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN safeguarding_policy_verified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners with verified safeguarding policies — critical accountability compliance KPI for donor and regulatory requirements."
    - name: "legal_registration_verified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN legal_registration_verified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners with verified legal registration — measures foundational compliance coverage across the partner portfolio."
    - name: "financial_audit_reviewed_count"
      expr: COUNT(CASE WHEN financial_audit_reviewed = TRUE THEN 1 END)
      comment: "Number of due diligence records where financial audit was reviewed — tracks financial accountability verification coverage."
    - name: "anti_terrorism_certified_count"
      expr: COUNT(CASE WHEN anti_terrorism_certification = TRUE THEN 1 END)
      comment: "Number of partners with anti-terrorism certification — measures compliance with donor counter-terrorism requirements."
    - name: "distinct_partners_screened"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of distinct partner organizations with due diligence records — measures compliance program coverage breadth."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`partnership_agreement_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over agreement amendments — tracks amendment volume, budget change magnitude, no-cost extensions, and scope change patterns to monitor agreement stability and change management effectiveness."
  source: "`ngo_ecm`.`partnership`.`agreement_amendment`"
  dimensions:
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (e.g. Budget Revision, Extension, Scope Change) — used to segment amendments by change category."
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current status of the amendment (e.g. Approved, Pending, Rejected) — tracks amendment pipeline health."
    - name: "is_no_cost_extension"
      expr: is_no_cost_extension
      comment: "Whether the amendment is a no-cost extension — tracks timeline slippage without additional funding."
    - name: "donor_prior_approval_required"
      expr: donor_prior_approval_required
      comment: "Whether donor prior approval was required for the amendment — measures compliance burden and donor oversight intensity."
    - name: "geographic_scope_change"
      expr: geographic_scope_change
      comment: "Whether the amendment changed the geographic scope — tracks operational footprint changes."
    - name: "beneficiary_target_change"
      expr: beneficiary_target_change
      comment: "Whether the amendment changed beneficiary targets — tracks programmatic scope adjustments."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the amendment budget figures — supports multi-currency amendment analysis."
    - name: "amendment_year"
      expr: YEAR(effective_date)
      comment: "Year the amendment became effective — enables trend analysis of amendment frequency over time."
  measures:
    - name: "total_amendments"
      expr: COUNT(1)
      comment: "Total number of agreement amendments — baseline measure for amendment volume and agreement change management activity."
    - name: "no_cost_extension_count"
      expr: COUNT(CASE WHEN is_no_cost_extension = TRUE THEN 1 END)
      comment: "Number of no-cost extensions — measures timeline slippage frequency; high counts signal implementation delays."
    - name: "no_cost_extension_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_no_cost_extension = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of amendments that are no-cost extensions — strategic implementation efficiency KPI; high rates indicate systemic delivery delays."
    - name: "total_budget_change_amount"
      expr: SUM(CAST(budget_change_amount AS DOUBLE))
      comment: "Total net budget change across all amendments — measures aggregate financial revision magnitude in the agreement portfolio."
    - name: "avg_budget_change_amount"
      expr: AVG(CAST(budget_change_amount AS DOUBLE))
      comment: "Average budget change per amendment — benchmarks typical financial revision size and informs budget management practices."
    - name: "total_revised_budget_amount"
      expr: SUM(CAST(revised_budget_amount AS DOUBLE))
      comment: "Total revised budget amount across all amendments — measures the post-amendment financial commitment portfolio."
    - name: "donor_prior_approval_required_count"
      expr: COUNT(CASE WHEN donor_prior_approval_required = TRUE THEN 1 END)
      comment: "Number of amendments requiring donor prior approval — measures compliance burden and donor relationship management workload."
    - name: "scope_change_amendment_count"
      expr: COUNT(CASE WHEN geographic_scope_change = TRUE OR beneficiary_target_change = TRUE THEN 1 END)
      comment: "Number of amendments involving geographic or beneficiary scope changes — tracks programmatic flexibility and adaptation frequency."
    - name: "distinct_agreements_amended"
      expr: COUNT(DISTINCT agreement_id)
      comment: "Number of distinct agreements that have been amended — measures amendment prevalence across the agreement portfolio."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`partnership_capacity_building_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over partner capacity building plans — tracks investment levels, progress, score improvements, and plan completion rates to measure the effectiveness of partner strengthening programs."
  source: "`ngo_ecm`.`partnership`.`capacity_building_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the capacity building plan (e.g. Active, Completed, On Hold) — primary pipeline tracking dimension."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of capacity building plan (e.g. Organizational, Technical, Financial) — used to segment investment by strengthening category."
    - name: "overall_progress_status"
      expr: overall_progress_status
      comment: "Overall progress status of the plan (e.g. On Track, Delayed, Completed) — operational health indicator."
    - name: "country_code"
      expr: country_code
      comment: "Country where the capacity building plan is being implemented — supports geographic investment analysis."
    - name: "localization_strategy_aligned"
      expr: localization_strategy_aligned
      comment: "Whether the plan is aligned to the localization strategy — measures contribution to Grand Bargain localization commitments."
    - name: "safeguarding_component_included"
      expr: safeguarding_component_included
      comment: "Whether the plan includes a safeguarding component — tracks accountability and protection mainstreaming."
    - name: "gender_mainstreaming_included"
      expr: gender_mainstreaming_included
      comment: "Whether gender mainstreaming is included in the plan — measures gender equality integration in capacity building."
    - name: "plan_start_year"
      expr: YEAR(start_date)
      comment: "Year the capacity building plan started — enables cohort analysis of plan investments over time."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of progress reporting for the plan — used to assess oversight intensity."
  measures:
    - name: "total_capacity_building_plans"
      expr: COUNT(1)
      comment: "Total number of capacity building plans — baseline measure for partner strengthening program scale."
    - name: "total_budget_usd"
      expr: SUM(CAST(total_budget_usd AS DOUBLE))
      comment: "Total investment in capacity building plans (USD) — measures financial commitment to partner strengthening across the portfolio."
    - name: "avg_budget_usd"
      expr: AVG(CAST(total_budget_usd AS DOUBLE))
      comment: "Average budget per capacity building plan (USD) — benchmarks typical investment per partner strengthening engagement."
    - name: "total_expenditure_to_date_usd"
      expr: SUM(CAST(expenditure_to_date_usd AS DOUBLE))
      comment: "Total expenditure to date across all capacity building plans (USD) — measures actual investment deployed in partner strengthening."
    - name: "avg_budget_utilisation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(expenditure_to_date_usd AS DOUBLE)) / NULLIF(SUM(CAST(total_budget_usd AS DOUBLE)), 0), 2)
      comment: "Average budget utilisation rate across capacity building plans — measures financial absorption and implementation pace."
    - name: "avg_capacity_score_improvement"
      expr: AVG(CAST(current_capacity_score AS DOUBLE) - CAST(baseline_capacity_score AS DOUBLE))
      comment: "Average improvement in capacity score from baseline to current — measures the effectiveness of capacity building investments."
    - name: "avg_target_capacity_score"
      expr: AVG(CAST(target_capacity_score AS DOUBLE))
      comment: "Average target capacity score across plans — benchmarks ambition level of capacity building programs."
    - name: "localization_aligned_plan_count"
      expr: COUNT(CASE WHEN localization_strategy_aligned = TRUE THEN 1 END)
      comment: "Number of capacity building plans aligned to the localization strategy — measures contribution to Grand Bargain localization commitments."
    - name: "distinct_partners_with_plans"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of distinct partner organizations with active capacity building plans — measures partner strengthening program coverage."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`partnership_consortium`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over humanitarian and development consortia — tracks funding scale, localization progress, member composition, and operational status across all consortium arrangements."
  source: "`ngo_ecm`.`partnership`.`consortium`"
  dimensions:
    - name: "consortium_type"
      expr: consortium_type
      comment: "Type of consortium (e.g. Humanitarian Response, Development, Research) — primary segmentation dimension."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the consortium (e.g. Active, Closed, Forming) — used to filter live vs. historical consortia."
    - name: "country_code"
      expr: country_code
      comment: "Country where the consortium operates — supports geographic portfolio analysis."
    - name: "ngo_role"
      expr: ngo_role
      comment: "Role of the NGO within the consortium (e.g. Lead, Member, Technical Advisor) — used to analyze leadership vs. participation patterns."
    - name: "grand_bargain_localization"
      expr: grand_bargain_localization
      comment: "Whether the consortium is aligned to Grand Bargain localization commitments — strategic localization tracking dimension."
    - name: "chs_compliance_status"
      expr: chs_compliance_status
      comment: "CHS compliance status of the consortium — accountability and quality standard indicator."
    - name: "thematic_focus"
      expr: thematic_focus
      comment: "Thematic focus area of the consortium (e.g. Health, WASH, Food Security) — sector-level portfolio analysis."
    - name: "consortium_start_year"
      expr: YEAR(start_date)
      comment: "Year the consortium was established — enables cohort and trend analysis."
  measures:
    - name: "total_consortia"
      expr: COUNT(1)
      comment: "Total number of consortia — baseline measure for multi-partner collaboration portfolio size."
    - name: "active_consortium_count"
      expr: COUNT(CASE WHEN operational_status = 'Active' THEN 1 END)
      comment: "Number of currently active consortia — measures live multi-partner collaboration portfolio."
    - name: "total_funding_amount"
      expr: SUM(CAST(total_funding_amount AS DOUBLE))
      comment: "Total funding mobilized across all consortia — measures aggregate financial scale of consortium-based programming."
    - name: "avg_funding_amount"
      expr: AVG(CAST(total_funding_amount AS DOUBLE))
      comment: "Average funding amount per consortium — benchmarks typical consortium financial scale."
    - name: "total_ngo_funding_share"
      expr: SUM(CAST(ngo_funding_share AS DOUBLE))
      comment: "Total NGO funding share across all consortia — measures the organization's financial stake in consortium programming."
    - name: "avg_localization_percentage"
      expr: AVG(CAST(localization_percentage AS DOUBLE))
      comment: "Average localization percentage across consortia — strategic KPI for Grand Bargain localization commitment tracking."
    - name: "grand_bargain_aligned_count"
      expr: COUNT(CASE WHEN grand_bargain_localization = TRUE THEN 1 END)
      comment: "Number of consortia aligned to Grand Bargain localization commitments — measures localization strategy implementation."
    - name: "grand_bargain_alignment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN grand_bargain_localization = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consortia aligned to Grand Bargain localization — strategic accountability KPI for donor and sector reporting."
$$;