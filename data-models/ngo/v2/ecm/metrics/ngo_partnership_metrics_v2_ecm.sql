-- Metric views for domain: partnership | Business: Ngo | Version: 2 | Generated on: 2026-06-23 01:23:48

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_partner_org`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the partner organisation master registry. Tracks portfolio health, due-diligence coverage, CHS certification rates, and financial scale of the implementing-partner base. Relevant to Partnership Directors, Grants teams, and Compliance officers. Aligns with HACT assurance frameworks used by UN agencies (UNICEF, UNDP, WFP) and large INGOs managing sub-award portfolios via eTools or SAP."
  source: "`vibe_ngo_v1`.`partnership`.`partner_org`"
  dimensions:
    - name: "org_type"
      expr: org_type
      comment: "Type of partner organisation (INGO, LNGO, CBO, UN agency, government, etc.) — primary segmentation for portfolio analysis."
    - name: "partnership_status"
      expr: partnership_status
      comment: "Current partnership lifecycle status (active, suspended, closed, prospective) — used to filter active vs. historical portfolio."
    - name: "due_diligence_status"
      expr: due_diligence_status
      comment: "Overall due-diligence outcome for the partner — drives assurance-level decisions and sub-award eligibility."
    - name: "hq_country"
      expr: hq_country
      comment: "Country of headquarters — enables geographic portfolio segmentation and localisation-ratio analysis."
    - name: "chs_certified"
      expr: chs_certified
      comment: "Whether the partner holds a valid Core Humanitarian Standard certification — key quality gate for humanitarian partnerships."
    - name: "sanctions_screened"
      expr: sanctions_screened
      comment: "Whether the partner has been screened against sanctions lists — mandatory compliance dimension."
  measures:
    - name: "total_partners"
      expr: COUNT(1)
      comment: "Total number of partner organisations in the registry. Baseline portfolio-size KPI used in board reporting and localisation dashboards."
    - name: "active_partners"
      expr: COUNT(CASE WHEN partnership_status = 'active' THEN 1 END)
      comment: "Count of partners with active partnership status. Tracks the live implementing-partner base available for programme delivery."
    - name: "chs_certified_partners"
      expr: COUNT(CASE WHEN chs_certified = TRUE THEN 1 END)
      comment: "Number of partners holding CHS certification. Informs quality-assurance coverage and donor reporting on partner standards compliance."
    - name: "sanctions_screened_partners"
      expr: COUNT(CASE WHEN sanctions_screened = TRUE THEN 1 END)
      comment: "Number of partners that have been screened against sanctions lists. Compliance KPI — any gap triggers immediate risk escalation."
    - name: "avg_capacity_assessment_score"
      expr: AVG(CAST(capacity_assessment_score AS DOUBLE))
      comment: "Average capacity assessment score across all partners. Tracks overall portfolio capability level; declining trend signals need for capacity-building investment."
    - name: "total_annual_budget_usd"
      expr: SUM(CAST(annual_budget_usd AS DOUBLE))
      comment: "Sum of reported annual budgets across all partner organisations (USD). Proxy for total financial scale of the implementing-partner ecosystem."
    - name: "avg_annual_budget_usd"
      expr: AVG(CAST(annual_budget_usd AS DOUBLE))
      comment: "Average annual budget per partner organisation (USD). Helps segment large vs. small partners for differentiated oversight strategies."
    - name: "due_diligence_expired_partners"
      expr: COUNT(CASE WHEN due_diligence_expiry_date < CURRENT_DATE() THEN 1 END)
      comment: "Partners whose due-diligence validity has lapsed. Critical compliance KPI — expired DD blocks new sub-award disbursements under most donor rules."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Portfolio-level KPIs for partnership agreements (sub-awards, MOUs, LOAs). Tracks agreement lifecycle, funding ceilings, indirect-cost rates, and compliance posture. Used by Grants Management, Finance, and Partnership teams. Aligns with HACT transfer-modality tracking required by UN agencies and IATI publication obligations."
  source: "`vibe_ngo_v1`.`partnership`.`partnership_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of partnership agreement (sub-award, MOU, LOA, consortium agreement) — primary classification for portfolio segmentation."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Lifecycle status of the agreement (draft, active, expired, terminated, suspended) — drives operational and compliance filtering."
    - name: "ip_transfer_modality"
      expr: ip_transfer_modality
      comment: "Implementing-partner transfer modality (direct cash transfer, reimbursement, direct payment, direct implementation) — HACT-required dimension for UN agency reporting."
    - name: "hact_transfer_modality"
      expr: hact_transfer_modality
      comment: "HACT-specific transfer modality classification — used for UNICEF/UNDP HACT assurance planning and audit-threshold calculations."
    - name: "is_sub_award"
      expr: is_sub_award
      comment: "Flags agreements that are sub-awards (vs. prime agreements) — required for FFATA/2 CFR 200 sub-award reporting."
    - name: "is_consortium_agreement"
      expr: is_consortium_agreement
      comment: "Flags consortium-level agreements — used to segment multi-partner arrangements for governance reporting."
    - name: "program_sector"
      expr: program_sector
      comment: "Humanitarian or development sector covered by the agreement (health, WASH, protection, food security, etc.) — enables sector-level portfolio analysis."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Required reporting cadence (monthly, quarterly, semi-annual, annual) — used to plan partner reporting workload and compliance monitoring."
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total number of partnership agreements. Baseline portfolio-size KPI for partnership management dashboards."
    - name: "active_agreements"
      expr: COUNT(CASE WHEN agreement_status = 'active' THEN 1 END)
      comment: "Count of currently active partnership agreements. Tracks live operational commitments requiring monitoring and reporting."
    - name: "total_funding_ceiling_usd"
      expr: SUM(CAST(funding_ceiling_amount AS DOUBLE))
      comment: "Total funding ceiling across all partnership agreements (USD). Represents the maximum financial exposure of the sub-award portfolio — key for budget oversight."
    - name: "avg_funding_ceiling_usd"
      expr: AVG(CAST(funding_ceiling_amount AS DOUBLE))
      comment: "Average funding ceiling per partnership agreement (USD). Benchmarks typical agreement size; outliers signal concentration risk."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate (ICR/NICRA) across agreements. Tracks overhead burden on the sub-award portfolio; high rates reduce programmatic spend."
    - name: "agreements_expiring_within_90_days"
      expr: COUNT(CASE WHEN effective_end_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Agreements expiring within the next 90 days. Operational urgency KPI — drives renewal, extension, or closeout planning."
    - name: "terminated_agreements"
      expr: COUNT(CASE WHEN agreement_status = 'terminated' THEN 1 END)
      comment: "Count of terminated agreements. Elevated termination rates signal partner performance or compliance issues requiring investigation."
    - name: "sub_award_agreements"
      expr: COUNT(CASE WHEN is_sub_award = TRUE THEN 1 END)
      comment: "Number of agreements classified as sub-awards. Required for FFATA sub-award disclosure reporting and 2 CFR 200 pass-through entity obligations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_capacity_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for partner capacity assessments — the primary tool for determining sub-award eligibility, transfer modality, and capacity-building needs. Used by Partnership, Grants, and Compliance teams. Aligns with HACT micro-assessment methodology (UNICEF/UNDP) and USAID OCA/NUPAS frameworks. Kobo Toolbox is a common data-collection platform for these assessments."
  source: "`vibe_ngo_v1`.`partnership`.`capacity_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of capacity assessment (HACT micro-assessment, OCA, NUPAS, organisational capacity assessment) — determines methodology and scoring framework."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Lifecycle status of the assessment (planned, in-progress, completed, validated) — used to track assessment pipeline."
    - name: "overall_risk_rating"
      expr: overall_risk_rating
      comment: "Composite risk rating (low, medium, high, significant) — primary output driving transfer modality and assurance-level decisions."
    - name: "financial_risk_rating"
      expr: financial_risk_rating
      comment: "Financial management risk rating — key input for determining audit requirements and payment modality."
    - name: "assessment_location_country"
      expr: assessment_location_country
      comment: "Country where the assessment was conducted — enables geographic risk-profile analysis."
    - name: "ip_transfer_modality"
      expr: ip_transfer_modality
      comment: "Recommended transfer modality based on assessment outcome — directly informs sub-award structuring."
    - name: "capacity_building_plan_required"
      expr: capacity_building_plan_required
      comment: "Whether a capacity-building plan is required as a result of the assessment — triggers follow-on investment planning."
    - name: "enhanced_monitoring_required"
      expr: enhanced_monitoring_required
      comment: "Whether enhanced monitoring is required — flags partners needing intensified oversight, impacting field monitoring workload."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of capacity assessments conducted. Baseline KPI for assurance-coverage tracking."
    - name: "completed_assessments"
      expr: COUNT(CASE WHEN assessment_status = 'completed' THEN 1 END)
      comment: "Number of completed assessments. Tracks assurance pipeline throughput — low completion rates delay sub-award approvals."
    - name: "high_risk_assessments"
      expr: COUNT(CASE WHEN overall_risk_rating IN ('high', 'significant') THEN 1 END)
      comment: "Assessments resulting in high or significant risk ratings. Elevated count signals portfolio-wide capacity concerns requiring escalation."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall capacity score across all assessments. Tracks portfolio-level capacity trend; declining average triggers investment review."
    - name: "avg_financial_mgmt_score"
      expr: AVG(CAST(financial_mgmt_score AS DOUBLE))
      comment: "Average financial management score. Financial management is the highest-risk dimension for sub-award fiduciary accountability."
    - name: "avg_governance_score"
      expr: AVG(CAST(governance_score AS DOUBLE))
      comment: "Average governance score across assessments. Governance weakness is a leading indicator of compliance and safeguarding risk."
    - name: "avg_mel_score"
      expr: AVG(CAST(mel_score AS DOUBLE))
      comment: "Average MEL (monitoring, evaluation, learning) score. Tracks partner data-quality capability — low scores undermine programme reporting."
    - name: "capacity_building_plans_required"
      expr: COUNT(CASE WHEN capacity_building_plan_required = TRUE THEN 1 END)
      comment: "Number of assessments requiring a capacity-building plan. Drives capacity-building investment pipeline and budget planning."
    - name: "enhanced_monitoring_required_count"
      expr: COUNT(CASE WHEN enhanced_monitoring_required = TRUE THEN 1 END)
      comment: "Number of partners requiring enhanced monitoring. Directly impacts field monitoring resource allocation and cost."
    - name: "avg_procurement_score"
      expr: AVG(CAST(procurement_score AS DOUBLE))
      comment: "Average procurement score. Procurement weakness is a key fiduciary risk dimension for donors funding commodity-intensive programmes."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_capacity_building_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for partner capacity-building plans — tracks investment, progress, and outcomes of structured capacity-development programmes. Used by Partnership and Programme teams to demonstrate localisation commitments and Grand Bargain compliance. Relevant to donors requiring evidence of partner strengthening (USAID, ECHO, FCDO)."
  source: "`vibe_ngo_v1`.`partnership`.`capacity_building_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Lifecycle status of the capacity-building plan (draft, approved, in-progress, completed, cancelled)."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of capacity-building plan (organisational, technical, financial, safeguarding, MEL) — enables thematic investment analysis."
    - name: "overall_progress_status"
      expr: overall_progress_status
      comment: "Current implementation progress status — used for portfolio-level progress monitoring."
    - name: "chs_standard_aligned"
      expr: chs_standard_aligned
      comment: "Whether the plan is aligned to CHS standards — required for CHS-certified partner reporting."
    - name: "localization_strategy_aligned"
      expr: localization_strategy_aligned
      comment: "Whether the plan supports the organisation's localisation strategy — tracks Grand Bargain commitment delivery."
    - name: "donor_reporting_required"
      expr: donor_reporting_required
      comment: "Whether donor reporting on this plan is required — flags plans with external accountability obligations."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of progress reporting on the plan — used to plan review workload."
  measures:
    - name: "total_plans"
      expr: COUNT(1)
      comment: "Total number of capacity-building plans. Baseline investment-pipeline KPI."
    - name: "active_plans"
      expr: COUNT(CASE WHEN plan_status = 'in-progress' THEN 1 END)
      comment: "Number of capacity-building plans currently in implementation. Tracks active investment workload."
    - name: "total_budget_usd"
      expr: SUM(CAST(total_budget_usd AS DOUBLE))
      comment: "Total budgeted investment in partner capacity building (USD). Key financial KPI for localisation and partner-strengthening programme reporting."
    - name: "total_expenditure_to_date_usd"
      expr: SUM(CAST(expenditure_to_date_usd AS DOUBLE))
      comment: "Total expenditure to date across all capacity-building plans (USD). Tracks actual investment delivery against budget."
    - name: "avg_budget_utilisation_rate"
      expr: AVG(CAST(expenditure_to_date_usd AS DOUBLE) / NULLIF(CAST(total_budget_usd AS DOUBLE), 0))
      comment: "Average budget utilisation rate (expenditure / budget) across plans. Low utilisation signals implementation delays; high utilisation near period-end signals burn risk."
    - name: "avg_baseline_capacity_score"
      expr: AVG(CAST(baseline_capacity_score AS DOUBLE))
      comment: "Average baseline capacity score at plan inception. Establishes the starting point for measuring capacity-building impact."
    - name: "avg_current_capacity_score"
      expr: AVG(CAST(current_capacity_score AS DOUBLE))
      comment: "Average current capacity score across active plans. Tracks real-time capacity improvement trajectory."
    - name: "avg_target_capacity_score"
      expr: AVG(CAST(target_capacity_score AS DOUBLE))
      comment: "Average target capacity score set in plans. Benchmarks ambition level of the capacity-building portfolio."
    - name: "plans_with_safeguarding_component"
      expr: COUNT(CASE WHEN safeguarding_component_included = TRUE THEN 1 END)
      comment: "Number of plans that include a safeguarding component. Tracks safeguarding mainstreaming in partner capacity development — donor-required metric."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_capacity_building_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for individual capacity-building activities (trainings, workshops, coaching sessions, technical assistance). Tracks delivery efficiency, cost, participant reach, and learning outcomes. Used by Partnership and Programme teams. Aligns with Grand Bargain localisation reporting and FCDO/USAID partner-strengthening indicators."
  source: "`vibe_ngo_v1`.`partnership`.`capacity_building_activity`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of capacity-building activity (training, workshop, coaching, technical assistance, peer learning) — primary classification for portfolio analysis."
    - name: "activity_status"
      expr: activity_status
      comment: "Delivery status of the activity (planned, in-progress, completed, cancelled) — used to track pipeline vs. delivered activities."
    - name: "delivery_mode"
      expr: delivery_mode
      comment: "Delivery modality (in-person, virtual, blended) — relevant for cost analysis and accessibility planning."
    - name: "capacity_domain"
      expr: capacity_domain
      comment: "Functional domain targeted (financial management, governance, MEL, procurement, safeguarding, HR) — enables thematic investment analysis."
    - name: "thematic_area"
      expr: thematic_area
      comment: "Thematic area of the activity — used for sector-level capacity investment reporting."
    - name: "is_certified"
      expr: is_certified
      comment: "Whether the activity leads to a formal certification — tracks quality-credentialed training delivery."
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Whether follow-up action is required after the activity — flags activities with outstanding accountability obligations."
  measures:
    - name: "total_activities"
      expr: COUNT(1)
      comment: "Total number of capacity-building activities. Baseline delivery-volume KPI."
    - name: "completed_activities"
      expr: COUNT(CASE WHEN activity_status = 'completed' THEN 1 END)
      comment: "Number of completed activities. Tracks delivery throughput against planned pipeline."
    - name: "total_activity_cost_usd"
      expr: SUM(CAST(activity_cost_usd AS DOUBLE))
      comment: "Total cost of capacity-building activities (USD). Tracks financial investment in partner strengthening — key for localisation budget reporting."
    - name: "avg_activity_cost_usd"
      expr: AVG(CAST(activity_cost_usd AS DOUBLE))
      comment: "Average cost per capacity-building activity (USD). Benchmarks cost efficiency; high averages may indicate over-reliance on expensive external facilitators."
    - name: "total_duration_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total hours of capacity-building delivered. Volume metric for learning investment reporting."
    - name: "avg_completion_rate_pct"
      expr: AVG(CAST(completion_rate_pct AS DOUBLE))
      comment: "Average participant completion rate across activities. Low completion rates signal engagement or relevance issues requiring curriculum review."
    - name: "avg_participant_satisfaction_score"
      expr: AVG(CAST(participant_satisfaction_score AS DOUBLE))
      comment: "Average participant satisfaction score. Quality KPI for training effectiveness — low scores trigger facilitator or content review."
    - name: "avg_pre_assessment_score"
      expr: AVG(CAST(pre_assessment_score AS DOUBLE))
      comment: "Average pre-activity knowledge assessment score. Establishes baseline for measuring learning gain."
    - name: "avg_post_assessment_score"
      expr: AVG(CAST(post_assessment_score AS DOUBLE))
      comment: "Average post-activity knowledge assessment score. Tracks learning outcomes — the gap vs. pre-assessment score measures knowledge transfer effectiveness."
    - name: "activities_with_follow_up_required"
      expr: COUNT(CASE WHEN follow_up_required = TRUE THEN 1 END)
      comment: "Number of activities with outstanding follow-up requirements. Tracks accountability obligations from training delivery."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_due_diligence_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for partner due-diligence records — the primary compliance gate for sub-award eligibility. Tracks screening coverage, risk distribution, and verification status. Used by Compliance, Grants, and Partnership teams. Aligns with USAID ADS 303, ECHO partner registration, and UN agency HACT assurance frameworks. Sanctions screening aligns with OFAC, EU, and UN consolidated lists."
  source: "`vibe_ngo_v1`.`partnership`.`due_diligence_record`"
  dimensions:
    - name: "diligence_type"
      expr: diligence_type
      comment: "Type of due-diligence process (pre-award, periodic, enhanced, event-triggered) — determines scope and depth of review."
    - name: "diligence_status"
      expr: diligence_status
      comment: "Current status of the due-diligence process (initiated, in-progress, completed, expired) — tracks pipeline and coverage gaps."
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Final due-diligence outcome (approved, approved-with-conditions, rejected, deferred) — primary decision output."
    - name: "risk_level"
      expr: risk_level
      comment: "Assessed risk level (low, medium, high, critical) — drives monitoring intensity and transfer-modality decisions."
    - name: "debarment_check_status"
      expr: debarment_check_status
      comment: "Status of debarment/exclusion list check — mandatory compliance dimension; any positive match blocks sub-award."
    - name: "aml_cft_check_status"
      expr: aml_cft_check_status
      comment: "Anti-money-laundering and counter-financing-of-terrorism check status — required by most institutional donors."
    - name: "chs_certification_status"
      expr: chs_certification_status
      comment: "CHS certification status of the partner at time of due diligence — quality assurance dimension."
  measures:
    - name: "total_due_diligence_records"
      expr: COUNT(1)
      comment: "Total number of due-diligence records. Baseline coverage KPI."
    - name: "completed_due_diligence"
      expr: COUNT(CASE WHEN diligence_status = 'completed' THEN 1 END)
      comment: "Number of completed due-diligence reviews. Tracks assurance pipeline throughput."
    - name: "high_risk_partners"
      expr: COUNT(CASE WHEN risk_level IN ('high', 'critical') THEN 1 END)
      comment: "Partners assessed as high or critical risk. Elevated count signals portfolio-wide fiduciary exposure requiring escalation."
    - name: "approved_partners"
      expr: COUNT(CASE WHEN overall_outcome = 'approved' THEN 1 END)
      comment: "Partners approved through due diligence. Tracks eligible sub-award pipeline."
    - name: "rejected_partners"
      expr: COUNT(CASE WHEN overall_outcome = 'rejected' THEN 1 END)
      comment: "Partners rejected through due diligence. Tracks disqualification rate — high rates may indicate poor pre-screening or partner quality issues."
    - name: "safeguarding_policy_verified_count"
      expr: COUNT(CASE WHEN safeguarding_policy_verified = TRUE THEN 1 END)
      comment: "Partners with verified safeguarding policies. Tracks safeguarding compliance coverage — mandatory for most institutional donors post-2018."
    - name: "legal_registration_verified_count"
      expr: COUNT(CASE WHEN legal_registration_verified = TRUE THEN 1 END)
      comment: "Partners with verified legal registration. Baseline legal compliance KPI — unverified registration blocks sub-award execution."
    - name: "financial_audit_reviewed_count"
      expr: COUNT(CASE WHEN financial_audit_reviewed = TRUE THEN 1 END)
      comment: "Partners whose financial audit has been reviewed. Tracks financial accountability verification coverage."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_field_monitoring_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for field monitoring visits to partner implementation sites. Tracks visit coverage, compliance findings, corrective action status, and safeguarding observations. Used by Partnership, Grants, and Compliance teams. Aligns with HACT programme monitoring requirements and donor field-verification obligations (USAID, ECHO, FCDO). eTools is the primary platform for UN agency field monitoring."
  source: "`vibe_ngo_v1`.`partnership`.`field_monitoring_visit`"
  dimensions:
    - name: "visit_type"
      expr: visit_type
      comment: "Type of monitoring visit (programmatic, financial, safeguarding, combined, follow-up) — determines scope and reporting requirements."
    - name: "visit_status"
      expr: visit_status
      comment: "Status of the visit (planned, completed, cancelled, report-pending) — tracks monitoring pipeline."
    - name: "overall_compliance_rating"
      expr: overall_compliance_rating
      comment: "Overall compliance rating from the visit (satisfactory, partially-satisfactory, unsatisfactory) — primary quality output."
    - name: "visit_purpose"
      expr: visit_purpose
      comment: "Purpose of the visit (routine monitoring, spot-check, investigation, capacity support) — enables purpose-based analysis."
    - name: "corrective_action_plan_required"
      expr: corrective_action_plan_required
      comment: "Whether a corrective action plan was required — flags visits with compliance deficiencies."
    - name: "corrective_action_plan_status"
      expr: corrective_action_plan_status
      comment: "Status of the corrective action plan (not-required, pending, in-progress, completed) — tracks remediation follow-through."
    - name: "program_sector"
      expr: program_sector
      comment: "Programme sector covered by the visit — enables sector-level compliance analysis."
    - name: "donor_notification_required"
      expr: donor_notification_required
      comment: "Whether the donor must be notified of findings — flags visits with external reporting obligations."
  measures:
    - name: "total_visits"
      expr: COUNT(1)
      comment: "Total number of field monitoring visits. Baseline coverage KPI for assurance planning."
    - name: "completed_visits"
      expr: COUNT(CASE WHEN visit_status = 'completed' THEN 1 END)
      comment: "Number of completed monitoring visits. Tracks actual monitoring coverage delivered."
    - name: "visits_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_plan_required = TRUE THEN 1 END)
      comment: "Visits that identified issues requiring a corrective action plan. Elevated rate signals systemic partner compliance problems."
    - name: "unsatisfactory_compliance_visits"
      expr: COUNT(CASE WHEN overall_compliance_rating = 'unsatisfactory' THEN 1 END)
      comment: "Visits rated unsatisfactory. Critical KPI — high count triggers enhanced monitoring, potential sub-award suspension."
    - name: "visits_with_donor_notification"
      expr: COUNT(CASE WHEN donor_notification_required = TRUE THEN 1 END)
      comment: "Visits requiring donor notification of findings. Tracks external reporting obligations arising from monitoring."
    - name: "avg_site_latitude"
      expr: AVG(CAST(site_latitude AS DOUBLE))
      comment: "Average latitude of monitored sites. Used for geographic coverage analysis and access-constraint mapping."
    - name: "visits_with_assets_verified"
      expr: COUNT(CASE WHEN assets_verified = TRUE THEN 1 END)
      comment: "Visits where physical assets were verified. Tracks asset-accountability coverage — required for donor asset-management compliance."
    - name: "visits_with_safeguarding_findings"
      expr: COUNT(CASE WHEN safeguarding_findings_summary IS NOT NULL AND safeguarding_findings_summary != '' THEN 1 END)
      comment: "Visits that recorded safeguarding findings. Any positive count triggers mandatory escalation to safeguarding focal points."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_partner_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for partner performance reviews — the primary mechanism for evaluating sub-award delivery quality, financial accountability, and reporting compliance. Used by Partnership Directors and Grants teams for renewal decisions and risk escalation. Aligns with USAID AOR/COR review requirements and UN agency HACT performance assessment frameworks."
  source: "`vibe_ngo_v1`.`partnership`.`partner_performance_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of performance review (mid-term, annual, final, ad-hoc) — determines scope and decision implications."
    - name: "review_status"
      expr: review_status
      comment: "Status of the review (planned, in-progress, completed, approved) — tracks review pipeline."
    - name: "overall_performance_rating"
      expr: overall_performance_rating
      comment: "Overall performance rating (excellent, satisfactory, partially-satisfactory, unsatisfactory) — primary output driving renewal and risk decisions."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned at review (low, medium, high) — informs monitoring intensity for the next period."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required — flags partners with performance deficiencies."
    - name: "capacity_building_recommended"
      expr: capacity_building_recommended
      comment: "Whether capacity building is recommended — triggers investment planning for underperforming partners."
    - name: "partnership_renewal_recommendation"
      expr: partnership_renewal_recommendation
      comment: "Renewal recommendation (renew, renew-with-conditions, do-not-renew) — primary strategic output of the review."
    - name: "review_method"
      expr: review_method
      comment: "Method used for the review (desk review, field visit, joint review, remote) — affects review quality and depth."
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of partner performance reviews. Baseline coverage KPI."
    - name: "completed_reviews"
      expr: COUNT(CASE WHEN review_status = 'completed' THEN 1 END)
      comment: "Number of completed performance reviews. Tracks review pipeline throughput."
    - name: "unsatisfactory_performance_reviews"
      expr: COUNT(CASE WHEN overall_performance_rating = 'unsatisfactory' THEN 1 END)
      comment: "Reviews with unsatisfactory overall rating. Critical KPI — triggers enhanced monitoring, corrective action, or partnership termination."
    - name: "avg_overall_performance_score"
      expr: AVG(CAST(overall_performance_score AS DOUBLE))
      comment: "Average overall performance score across reviews. Portfolio-level quality trend — declining average signals systemic partner performance deterioration."
    - name: "avg_budget_utilisation_rate"
      expr: AVG(CAST(budget_utilisation_rate AS DOUBLE))
      comment: "Average budget utilisation rate across reviewed partners. Low utilisation signals implementation delays; very high rates near period-end signal burn risk."
    - name: "avg_milestone_achievement_rate"
      expr: AVG(CAST(milestone_achievement_rate AS DOUBLE))
      comment: "Average milestone achievement rate across reviews. Tracks programmatic delivery effectiveness — low rates signal implementation bottlenecks."
    - name: "reviews_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Reviews that identified issues requiring corrective action. Elevated count signals portfolio-wide performance concerns."
    - name: "do_not_renew_recommendations"
      expr: COUNT(CASE WHEN partnership_renewal_recommendation = 'do-not-renew' THEN 1 END)
      comment: "Reviews recommending non-renewal of the partnership. Tracks partner attrition risk and pipeline implications for programme delivery."
    - name: "field_visit_conducted_count"
      expr: COUNT(CASE WHEN field_visit_conducted = TRUE THEN 1 END)
      comment: "Reviews where a field visit was conducted. Tracks in-person verification coverage — field visits provide higher-quality evidence than desk reviews."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_partner_report_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for partner report submissions — tracks reporting compliance, timeliness, quality, and financial accountability. Used by Grants, Compliance, and Partnership teams. Aligns with donor reporting obligations (USAID, ECHO, FCDO, UN agencies) and IATI publication requirements. Late or low-quality submissions trigger donor relationship risks."
  source: "`vibe_ngo_v1`.`partnership`.`partner_report_submission`"
  dimensions:
    - name: "report_type"
      expr: report_type
      comment: "Type of report (narrative, financial, combined, MEL, final) — determines review process and donor obligations."
    - name: "review_status"
      expr: review_status
      comment: "Review status of the submission (pending, under-review, accepted, revision-required, rejected) — tracks review pipeline."
    - name: "is_late_submission"
      expr: is_late_submission
      comment: "Whether the report was submitted after the due date — primary timeliness compliance dimension."
    - name: "report_period_frequency"
      expr: report_period_frequency
      comment: "Reporting frequency (monthly, quarterly, semi-annual, annual) — used to segment compliance analysis by reporting cadence."
    - name: "donor_reporting_obligation"
      expr: donor_reporting_obligation
      comment: "Whether this submission fulfils a donor reporting obligation — flags reports with external accountability requirements."
    - name: "financial_documentation_attached"
      expr: financial_documentation_attached
      comment: "Whether financial documentation was attached — incomplete submissions without financial docs are typically rejected."
    - name: "mel_indicators_reported"
      expr: mel_indicators_reported
      comment: "Whether MEL indicators were reported — tracks data-quality completeness of submissions."
    - name: "submission_method"
      expr: submission_method
      comment: "Method of submission (portal, email, in-person, system) — used for process efficiency analysis."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of partner report submissions. Baseline reporting-volume KPI."
    - name: "accepted_submissions"
      expr: COUNT(CASE WHEN review_status = 'accepted' THEN 1 END)
      comment: "Number of accepted report submissions. Tracks successful reporting compliance."
    - name: "late_submissions"
      expr: COUNT(CASE WHEN is_late_submission = TRUE THEN 1 END)
      comment: "Number of late report submissions. Elevated count signals partner reporting capacity issues or workload problems — triggers compliance follow-up."
    - name: "on_time_submission_rate"
      expr: COUNT(CASE WHEN is_late_submission = FALSE THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Proportion of reports submitted on time. Key compliance KPI — low rates risk donor relationship damage and future funding."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score of report submissions. Tracks reporting quality trend — low scores indicate partner capacity gaps in reporting."
    - name: "total_expenditure_reported_usd"
      expr: SUM(CAST(total_expenditure_reported AS DOUBLE))
      comment: "Total expenditure reported across all partner submissions (USD). Tracks financial accountability volume — reconciled against award disbursements."
    - name: "avg_expenditure_reported_usd"
      expr: AVG(CAST(total_expenditure_reported AS DOUBLE))
      comment: "Average expenditure reported per submission (USD). Benchmarks typical financial reporting volume per partner."
    - name: "submissions_missing_financial_docs"
      expr: COUNT(CASE WHEN financial_documentation_attached = FALSE THEN 1 END)
      comment: "Submissions without financial documentation attached. Incomplete submissions block financial reconciliation and donor reporting."
    - name: "submissions_with_mel_indicators"
      expr: COUNT(CASE WHEN mel_indicators_reported = TRUE THEN 1 END)
      comment: "Submissions that include MEL indicator data. Tracks data-quality completeness — missing indicators undermine programme performance reporting."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_partner_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for the partner risk register — tracks fiduciary, safeguarding, and operational risks across the implementing-partner portfolio. Used by Risk, Compliance, and Partnership teams for portfolio-level risk management. Aligns with USAID risk management requirements, ECHO partner risk frameworks, and UN agency HACT risk-based assurance planning."
  source: "`vibe_ngo_v1`.`partnership`.`partner_risk_register`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Category of risk (fiduciary, safeguarding, operational, reputational, compliance, security) — primary risk taxonomy dimension."
    - name: "risk_level"
      expr: risk_level
      comment: "Overall risk level (low, medium, high, critical) — primary severity dimension for risk prioritisation."
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk (open, mitigated, closed, escalated, materialised) — tracks risk lifecycle."
    - name: "likelihood_rating"
      expr: likelihood_rating
      comment: "Likelihood rating of the risk materialising — used in risk matrix analysis."
    - name: "impact_rating"
      expr: impact_rating
      comment: "Impact rating if the risk materialises — used in risk matrix analysis."
    - name: "fiduciary_risk_flag"
      expr: fiduciary_risk_flag
      comment: "Whether the risk has a fiduciary dimension — flags financial accountability risks requiring enhanced oversight."
    - name: "safeguarding_risk_flag"
      expr: safeguarding_risk_flag
      comment: "Whether the risk has a safeguarding dimension — any safeguarding risk triggers mandatory escalation protocols."
    - name: "escalation_required"
      expr: escalation_required
      comment: "Whether the risk requires escalation — tracks unresolved high-priority risks."
    - name: "donor_notification_required"
      expr: donor_notification_required
      comment: "Whether the donor must be notified of this risk — flags risks with external reporting obligations."
  measures:
    - name: "total_risks"
      expr: COUNT(1)
      comment: "Total number of risks in the partner risk register. Baseline portfolio-risk-volume KPI."
    - name: "open_risks"
      expr: COUNT(CASE WHEN risk_status = 'open' THEN 1 END)
      comment: "Number of currently open risks. Tracks unresolved risk exposure across the partner portfolio."
    - name: "high_critical_risks"
      expr: COUNT(CASE WHEN risk_level IN ('high', 'critical') THEN 1 END)
      comment: "Risks rated high or critical. Elevated count signals portfolio-level risk concentration requiring immediate management attention."
    - name: "materialised_risks"
      expr: COUNT(CASE WHEN risk_materialised = TRUE THEN 1 END)
      comment: "Risks that have materialised. Tracks actual risk events — high materialisation rate signals inadequate risk mitigation."
    - name: "total_financial_exposure_usd"
      expr: SUM(CAST(financial_exposure_usd AS DOUBLE))
      comment: "Total financial exposure from partner risks (USD). Quantifies the financial value at risk across the partner portfolio — key for board risk reporting."
    - name: "avg_financial_exposure_usd"
      expr: AVG(CAST(financial_exposure_usd AS DOUBLE))
      comment: "Average financial exposure per risk entry (USD). Benchmarks typical risk magnitude for portfolio comparison."
    - name: "fiduciary_risks"
      expr: COUNT(CASE WHEN fiduciary_risk_flag = TRUE THEN 1 END)
      comment: "Number of risks with a fiduciary dimension. Tracks financial accountability risk concentration — high count triggers enhanced financial monitoring."
    - name: "safeguarding_risks"
      expr: COUNT(CASE WHEN safeguarding_risk_flag = TRUE THEN 1 END)
      comment: "Number of risks with a safeguarding dimension. Any safeguarding risk requires mandatory escalation — zero tolerance threshold."
    - name: "risks_requiring_donor_notification"
      expr: COUNT(CASE WHEN donor_notification_required = TRUE THEN 1 END)
      comment: "Risks requiring donor notification. Tracks external reporting obligations arising from risk events."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_consortium`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for consortium arrangements — multi-partner delivery structures common in large humanitarian responses and development programmes. Tracks funding scale, localisation ratios, membership, and governance. Used by Partnership Directors and Senior Management. Aligns with Grand Bargain localisation commitments and OCHA cluster coordination reporting."
  source: "`vibe_ngo_v1`.`partnership`.`consortium`"
  dimensions:
    - name: "consortium_type"
      expr: consortium_type
      comment: "Type of consortium (humanitarian response, development programme, advocacy, research) — primary classification."
    - name: "ngo_role"
      expr: ngo_role
      comment: "The NGO's role in the consortium (lead, member, technical advisor, fiscal agent) — determines governance and accountability responsibilities."
    - name: "chs_compliance_status"
      expr: chs_compliance_status
      comment: "CHS compliance status of the consortium — tracks quality-standard adherence across the multi-partner arrangement."
    - name: "grand_bargain_localization"
      expr: grand_bargain_localization
      comment: "Whether the consortium is aligned to Grand Bargain localisation commitments — tracks localisation agenda delivery."
    - name: "ocha_cluster_alignment"
      expr: ocha_cluster_alignment
      comment: "OCHA cluster alignment of the consortium — used for humanitarian coordination reporting."
    - name: "thematic_focus"
      expr: thematic_focus
      comment: "Thematic focus area of the consortium (health, WASH, protection, food security, education) — enables sector-level portfolio analysis."
  measures:
    - name: "total_consortia"
      expr: COUNT(1)
      comment: "Total number of consortium arrangements. Baseline portfolio-size KPI."
    - name: "active_consortia"
      expr: COUNT(CASE WHEN operational_status = 1 THEN 1 END)
      comment: "Number of operationally active consortia. Tracks live multi-partner delivery arrangements."
    - name: "total_funding_amount_usd"
      expr: SUM(CAST(total_funding_amount AS DOUBLE))
      comment: "Total funding mobilised across all consortium arrangements (USD). Tracks the financial scale of multi-partner delivery — key for resource mobilisation reporting."
    - name: "avg_funding_amount_usd"
      expr: AVG(CAST(total_funding_amount AS DOUBLE))
      comment: "Average funding per consortium (USD). Benchmarks typical consortium scale."
    - name: "avg_localization_percentage"
      expr: AVG(CAST(localization_percentage AS DOUBLE))
      comment: "Average localisation percentage across consortia. Tracks Grand Bargain localisation commitment delivery — target typically 25%+ for humanitarian consortia."
    - name: "total_ngo_funding_share_usd"
      expr: SUM(CAST(ngo_funding_share AS DOUBLE))
      comment: "Total NGO funding share across all consortia (USD). Tracks the organisation's direct financial contribution to consortium arrangements."
    - name: "grand_bargain_aligned_consortia"
      expr: COUNT(CASE WHEN grand_bargain_localization = TRUE THEN 1 END)
      comment: "Number of consortia aligned to Grand Bargain localisation commitments. Tracks delivery against the organisation's localisation pledge."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_consortium_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for consortium membership — tracks funding allocation, cost-sharing, and performance across individual consortium members. Used by Partnership and Finance teams for consortium governance and financial management. Enables analysis of funding distribution, localisation ratios, and member performance."
  source: "`vibe_ngo_v1`.`partnership`.`consortium_member`"
  dimensions:
    - name: "member_role"
      expr: member_role
      comment: "Role of the member within the consortium (lead, implementing, technical, advisory) — determines responsibilities and accountability."
    - name: "membership_status"
      expr: membership_status
      comment: "Current membership status (active, suspended, withdrawn, completed) — tracks active vs. historical membership."
    - name: "contribution_type"
      expr: contribution_type
      comment: "Type of contribution (financial, in-kind, technical, combined) — enables analysis of non-financial partnership value."
    - name: "due_diligence_status"
      expr: due_diligence_status
      comment: "Due-diligence status of the member — compliance gate for funding allocation."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the consortium member — drives monitoring intensity and payment modality decisions."
    - name: "performance_rating"
      expr: performance_rating
      comment: "Performance rating of the member — used for renewal and future consortium participation decisions."
    - name: "voting_rights"
      expr: voting_rights
      comment: "Whether the member has voting rights in consortium governance — tracks governance structure and decision-making power distribution."
  measures:
    - name: "total_members"
      expr: COUNT(1)
      comment: "Total number of consortium member records. Baseline membership-volume KPI."
    - name: "active_members"
      expr: COUNT(CASE WHEN membership_status = 'active' THEN 1 END)
      comment: "Number of currently active consortium members. Tracks live membership for governance and workload planning."
    - name: "total_funding_allocation_usd"
      expr: SUM(CAST(funding_allocation_amount AS DOUBLE))
      comment: "Total funding allocated across all consortium members (USD). Tracks financial distribution across the consortium — reconciled against total consortium budget."
    - name: "avg_funding_allocation_usd"
      expr: AVG(CAST(funding_allocation_amount AS DOUBLE))
      comment: "Average funding allocation per consortium member (USD). Benchmarks typical member funding scale."
    - name: "avg_funding_allocation_percentage"
      expr: AVG(CAST(funding_allocation_percentage AS DOUBLE))
      comment: "Average funding allocation percentage per member. Tracks funding concentration — high concentration in few members signals dependency risk."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate across consortium members. Tracks overhead burden on consortium funding — high rates reduce programmatic spend."
    - name: "avg_capacity_assessment_score"
      expr: AVG(CAST(capacity_assessment_score AS DOUBLE))
      comment: "Average capacity assessment score across consortium members. Tracks collective capability level of the consortium."
    - name: "cost_share_required_members"
      expr: COUNT(CASE WHEN cost_share_required = TRUE THEN 1 END)
      comment: "Number of members with cost-share requirements. Tracks co-financing obligations within the consortium."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_mou_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for MOU obligations — tracks delivery of commitments made in partnership agreements and MOUs. Monitors overdue obligations, financial values, and escalation status. Used by Partnership and Programme teams for accountability management. Critical for donor reporting on partnership deliverables and IATI activity reporting."
  source: "`vibe_ngo_v1`.`partnership`.`mou_obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of obligation (programmatic, financial, reporting, safeguarding, compliance) — primary classification for obligation management."
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current status of the obligation (pending, in-progress, completed, overdue, waived) — primary tracking dimension."
    - name: "escalation_status"
      expr: escalation_status
      comment: "Escalation status for overdue obligations — tracks unresolved accountability issues."
    - name: "is_critical_obligation"
      expr: is_critical_obligation
      comment: "Whether the obligation is classified as critical — critical obligations trigger immediate escalation if overdue."
    - name: "is_donor_reportable"
      expr: is_donor_reportable
      comment: "Whether the obligation must be reported to the donor — flags obligations with external accountability requirements."
    - name: "program_sector"
      expr: program_sector
      comment: "Programme sector of the obligation — enables sector-level accountability analysis."
    - name: "capacity_building_component"
      expr: capacity_building_component
      comment: "Whether the obligation includes a capacity-building component — tracks localisation-related commitments."
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of MOU obligations. Baseline accountability-volume KPI."
    - name: "overdue_obligations"
      expr: COUNT(CASE WHEN obligation_status = 'overdue' THEN 1 END)
      comment: "Number of overdue obligations. Critical KPI — elevated count signals partnership delivery failures requiring escalation."
    - name: "completed_obligations"
      expr: COUNT(CASE WHEN obligation_status = 'completed' THEN 1 END)
      comment: "Number of completed obligations. Tracks delivery achievement against partnership commitments."
    - name: "critical_overdue_obligations"
      expr: COUNT(CASE WHEN is_critical_obligation = TRUE AND obligation_status = 'overdue' THEN 1 END)
      comment: "Critical obligations that are overdue. Highest-priority KPI — any critical overdue obligation triggers immediate senior management escalation."
    - name: "total_financial_value_usd"
      expr: SUM(CAST(financial_value_amount AS DOUBLE))
      comment: "Total financial value of MOU obligations (USD). Tracks the monetary scale of partnership commitments."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across obligations. Benchmarks typical obligation scale for portfolio comparison."
    - name: "avg_achieved_value"
      expr: AVG(CAST(achieved_value AS DOUBLE))
      comment: "Average achieved value across obligations. Tracks delivery performance against targets."
    - name: "obligation_achievement_rate"
      expr: AVG(CAST(achieved_value AS DOUBLE) / NULLIF(CAST(target_value AS DOUBLE), 0))
      comment: "Average achievement rate (achieved / target) across obligations. Portfolio-level delivery effectiveness KPI — below 80% triggers programme review."
    - name: "donor_reportable_obligations"
      expr: COUNT(CASE WHEN is_donor_reportable = TRUE THEN 1 END)
      comment: "Number of obligations requiring donor reporting. Tracks external accountability volume."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_campaign_participation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for partner participation in advocacy campaigns — tracks partner engagement, financial contributions, reach, and reporting compliance. Used by Communications, Advocacy, and Partnership teams. Measures the collective impact of multi-partner advocacy efforts and partner contribution to campaign outcomes. Aligns with VREQ-031 requirement to expand this previously thin product."
  source: "`vibe_ngo_v1`.`partnership`.`campaign_participation`"
  dimensions:
    - name: "participation_status"
      expr: participation_status
      comment: "Current status of the partner's campaign participation (active, completed, withdrawn, pending) — primary lifecycle dimension."
    - name: "partner_role"
      expr: partner_role
      comment: "Role of the partner in the campaign (lead, co-implementer, amplifier, funder, technical advisor) — determines contribution type and accountability."
    - name: "engagement_level"
      expr: engagement_level
      comment: "Level of partner engagement (high, medium, low) — used to segment active vs. passive campaign participants."
    - name: "contribution_type"
      expr: contribution_type
      comment: "Type of contribution (financial, in-kind, technical, communications, combined) — enables analysis of non-financial partnership value."
    - name: "is_lead_partner"
      expr: is_lead_partner
      comment: "Whether the partner is the lead for this campaign — identifies primary accountability holder."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the participation arrangement — tracks governance compliance."
    - name: "report_submitted_flag"
      expr: report_submitted_flag
      comment: "Whether the partner has submitted their campaign participation report — tracks reporting compliance."
    - name: "visibility_level"
      expr: visibility_level
      comment: "Visibility level of the partner's participation (public, restricted, confidential) — used for communications planning."
  measures:
    - name: "total_participations"
      expr: COUNT(1)
      comment: "Total number of partner campaign participation records. Baseline engagement-volume KPI."
    - name: "active_participations"
      expr: COUNT(CASE WHEN participation_status = 'active' THEN 1 END)
      comment: "Number of currently active campaign participations. Tracks live partner engagement in advocacy efforts."
    - name: "total_financial_contribution_usd"
      expr: SUM(CAST(contribution_amount AS DOUBLE))
      comment: "Total financial contributions from partners to campaigns (USD). Tracks co-financing mobilised through partnership advocacy arrangements."
    - name: "avg_financial_contribution_usd"
      expr: AVG(CAST(contribution_amount AS DOUBLE))
      comment: "Average financial contribution per partner participation (USD). Benchmarks typical partner financial commitment to campaigns."
    - name: "total_in_kind_contribution_value_usd"
      expr: SUM(CAST(in_kind_contribution_value AS DOUBLE))
      comment: "Total in-kind contribution value from partners (USD). Tracks non-financial partnership value — important for full-cost campaign reporting."
    - name: "total_social_media_impressions"
      expr: SUM(CAST(social_media_impressions_count AS DOUBLE))
      comment: "Total social media impressions generated across all partner participations. Tracks collective digital reach of the campaign partnership network."
    - name: "avg_satisfaction_score"
      expr: AVG(CAST(satisfaction_score AS DOUBLE))
      comment: "Average partner satisfaction score with campaign participation. Tracks partnership quality — low scores signal coordination or communication issues."
    - name: "reports_submitted_count"
      expr: COUNT(CASE WHEN report_submitted_flag = TRUE THEN 1 END)
      comment: "Number of partners that have submitted campaign participation reports. Tracks reporting compliance across the campaign partnership network."
    - name: "reporting_compliance_rate"
      expr: COUNT(CASE WHEN report_submitted_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Proportion of partners that have submitted required campaign reports. Reporting compliance rate — below 80% signals accountability gaps in the campaign network."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_agreement_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for partnership agreement amendments — tracks the frequency, financial impact, and nature of changes to sub-award agreements. High amendment rates signal poor initial planning or volatile operating environments. Used by Grants and Partnership teams. Aligns with donor prior-approval requirements (USAID, ECHO) and IATI activity update obligations."
  source: "`vibe_ngo_v1`.`partnership`.`agreement_amendment`"
  dimensions:
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (no-cost extension, budget revision, scope change, geographic change, combined) — primary classification for amendment analysis."
    - name: "amendment_status"
      expr: amendment_status
      comment: "Lifecycle status of the amendment (draft, submitted, approved, rejected, executed) — tracks amendment pipeline."
    - name: "is_no_cost_extension"
      expr: is_no_cost_extension
      comment: "Whether the amendment is a no-cost extension — NCEs are the most common amendment type and signal implementation delays."
    - name: "donor_prior_approval_required"
      expr: donor_prior_approval_required
      comment: "Whether donor prior approval is required — flags amendments with external approval dependencies that affect timeline."
    - name: "budget_change_flag"
      expr: CASE WHEN budget_change_amount != 0 THEN TRUE ELSE FALSE END
      comment: "Whether the amendment involves a budget change — derived flag for financial impact analysis."
    - name: "geographic_scope_change"
      expr: geographic_scope_change
      comment: "Whether the amendment changes the geographic scope — geographic changes often require additional donor approvals."
    - name: "beneficiary_target_change"
      expr: beneficiary_target_change
      comment: "Whether the amendment changes beneficiary targets — target reductions signal programme delivery challenges."
  measures:
    - name: "total_amendments"
      expr: COUNT(1)
      comment: "Total number of agreement amendments. Baseline amendment-volume KPI — high volume signals planning quality issues."
    - name: "approved_amendments"
      expr: COUNT(CASE WHEN amendment_status = 'approved' THEN 1 END)
      comment: "Number of approved amendments. Tracks amendment pipeline throughput."
    - name: "no_cost_extensions"
      expr: COUNT(CASE WHEN is_no_cost_extension = TRUE THEN 1 END)
      comment: "Number of no-cost extension amendments. High NCE rate signals systemic implementation delays across the portfolio."
    - name: "total_budget_change_amount_usd"
      expr: SUM(CAST(budget_change_amount AS DOUBLE))
      comment: "Total net budget change across all amendments (USD). Tracks financial scope changes — large positive values indicate scope expansion; negative values indicate reductions."
    - name: "avg_budget_change_amount_usd"
      expr: AVG(CAST(budget_change_amount AS DOUBLE))
      comment: "Average budget change per amendment (USD). Benchmarks typical financial scope of amendments."
    - name: "amendments_requiring_donor_approval"
      expr: COUNT(CASE WHEN donor_prior_approval_required = TRUE THEN 1 END)
      comment: "Amendments requiring donor prior approval. Tracks external approval dependencies — high count creates pipeline bottlenecks."
    - name: "budget_revision_amendments"
      expr: COUNT(CASE WHEN budget_change_amount != 0 THEN 1 END)
      comment: "Number of amendments involving a budget change. Tracks financial scope volatility across the sub-award portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_partner_accreditation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for partner accreditations — tracks certification coverage, expiry risk, and quality-standard compliance across the partner portfolio. Used by Compliance and Partnership teams. Covers CHS, ISO, Sphere, and other humanitarian quality standards. Accreditation gaps block sub-award eligibility for quality-gated donors."
  source: "`vibe_ngo_v1`.`partnership`.`partner_accreditation`"
  dimensions:
    - name: "accreditation_type"
      expr: accreditation_type
      comment: "Type of accreditation (CHS, ISO 9001, Sphere, HAP, PSEA, sector-specific) — primary classification."
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Current accreditation status (active, expired, suspended, pending-renewal) — primary compliance dimension."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the accreditation (verified, pending, unverified) — tracks due-diligence completeness."
    - name: "donor_required"
      expr: donor_required
      comment: "Whether the accreditation is required by a donor — flags mandatory certifications whose lapse blocks funding."
    - name: "is_mandatory_for_partnership"
      expr: is_mandatory_for_partnership
      comment: "Whether the accreditation is mandatory for partnership eligibility — critical compliance gate."
    - name: "chs_commitment_level"
      expr: chs_commitment_level
      comment: "CHS commitment level (verified, committed, signatory) — tracks depth of CHS engagement across the partner portfolio."
  measures:
    - name: "total_accreditations"
      expr: COUNT(1)
      comment: "Total number of partner accreditation records. Baseline coverage KPI."
    - name: "active_accreditations"
      expr: COUNT(CASE WHEN accreditation_status = 'active' THEN 1 END)
      comment: "Number of currently active accreditations. Tracks valid certification coverage across the partner portfolio."
    - name: "expired_accreditations"
      expr: COUNT(CASE WHEN accreditation_status = 'expired' THEN 1 END)
      comment: "Number of expired accreditations. Expired mandatory accreditations block sub-award eligibility — requires immediate remediation."
    - name: "accreditations_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Accreditations expiring within 90 days. Proactive renewal KPI — prevents eligibility gaps from lapsing certifications."
    - name: "avg_accreditation_score"
      expr: AVG(CAST(accreditation_score AS DOUBLE))
      comment: "Average accreditation score across all records. Tracks portfolio-level quality-standard achievement."
    - name: "donor_required_accreditations"
      expr: COUNT(CASE WHEN donor_required = TRUE THEN 1 END)
      comment: "Number of donor-required accreditations. Tracks mandatory certification obligations — any lapse risks funding suspension."
    - name: "verified_accreditations"
      expr: COUNT(CASE WHEN verification_status = 'verified' THEN 1 END)
      comment: "Number of accreditations with verified status. Tracks due-diligence completeness for certification claims."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_consortium_communication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consortium Communication business metrics"
  source: "`vibe_ngo_v1`.`partnership`.`consortium_communication`"
  dimensions:
    - name: "Approval Authority"
      expr: approval_authority
    - name: "Assigned Date"
      expr: assigned_date
    - name: "Branding Guidelines"
      expr: branding_guidelines
    - name: "Consortium Role"
      expr: consortium_role
    - name: "Review Completed Date"
      expr: review_completed_date
    - name: "Review Deadline"
      expr: review_deadline
    - name: "Review Notes"
      expr: review_notes
    - name: "Review Status"
      expr: review_status
    - name: "Visibility Requirements"
      expr: visibility_requirements
    - name: "Assigned Date Month"
      expr: DATE_TRUNC('MONTH', assigned_date)
    - name: "Review Completed Date Month"
      expr: DATE_TRUNC('MONTH', review_completed_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Consortium Communication"
      expr: COUNT(DISTINCT consortium_communication_id)
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_coordination_meeting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coordination Meeting business metrics"
  source: "`vibe_ngo_v1`.`partnership`.`coordination_meeting`"
  dimensions:
    - name: "Action Items Summary"
      expr: action_items_summary
    - name: "Agenda Document Url"
      expr: agenda_document_url
    - name: "Agenda Summary"
      expr: agenda_summary
    - name: "Associated Response Plan"
      expr: associated_response_plan
    - name: "City"
      expr: city
    - name: "Cluster Sector"
      expr: cluster_sector
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Duration Minutes"
      expr: duration_minutes
    - name: "End Time"
      expr: end_time
    - name: "Follow Up Status"
      expr: follow_up_status
    - name: "Hosting Organization"
      expr: hosting_organization
    - name: "Humanitarian Context"
      expr: humanitarian_context
    - name: "Is Recurring"
      expr: is_recurring
    - name: "Key Decisions"
      expr: key_decisions
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Coordination Meeting"
      expr: COUNT(DISTINCT coordination_meeting_id)
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_partner_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner Compliance business metrics"
  source: "`vibe_ngo_v1`.`partnership`.`partner_compliance`"
  dimensions:
    - name: "Assigned Date"
      expr: assigned_date
    - name: "Completion Date"
      expr: completion_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Due Date"
      expr: due_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Notes"
      expr: notes
    - name: "Partner Compliance Status"
      expr: partner_compliance_status
    - name: "Responsible Focal Point"
      expr: responsible_focal_point
    - name: "Waiver Status"
      expr: waiver_status
    - name: "Assigned Date Month"
      expr: DATE_TRUNC('MONTH', assigned_date)
    - name: "Completion Date Month"
      expr: DATE_TRUNC('MONTH', completion_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partner Compliance"
      expr: COUNT(DISTINCT partner_compliance_id)
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_partner_contact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner Contact business metrics"
  source: "`vibe_ngo_v1`.`partnership`.`partner_contact`"
  dimensions:
    - name: "Cluster Membership"
      expr: cluster_membership
    - name: "Consent Date"
      expr: consent_date
    - name: "Contact Status"
      expr: contact_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Sharing Consent"
      expr: data_sharing_consent
    - name: "Department"
      expr: department
    - name: "Do Not Contact"
      expr: do_not_contact
    - name: "Duty Station"
      expr: duty_station
    - name: "End Date"
      expr: end_date
    - name: "First Name"
      expr: first_name
    - name: "Gender"
      expr: gender
    - name: "Is Authorized Signatory"
      expr: is_authorized_signatory
    - name: "Is Financial Authorized"
      expr: is_financial_authorized
    - name: "Is Primary Contact"
      expr: is_primary_contact
    - name: "Job Title"
      expr: job_title
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partner Contact"
      expr: COUNT(DISTINCT partner_contact_id)
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_partnership_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partnership Agreement business metrics"
  source: "`vibe_ngo_v1`.`partnership`.`partnership_agreement`"
  dimensions:
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Amendment Date"
      expr: amendment_date
    - name: "Amendment Description"
      expr: amendment_description
    - name: "Amendment Number"
      expr: amendment_number
    - name: "Capacity Assessment Date"
      expr: capacity_assessment_date
    - name: "Capacity Assessment Status"
      expr: capacity_assessment_status
    - name: "Cluster Lead Agency"
      expr: cluster_lead_agency
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dispute Resolution Mechanism"
      expr: dispute_resolution_mechanism
    - name: "Due Diligence Risk Rating"
      expr: due_diligence_risk_rating
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Execution Date"
      expr: execution_date
    - name: "Geographic Scope"
      expr: geographic_scope
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partnership Agreement"
      expr: COUNT(DISTINCT partnership_agreement_id)
    - name: "Total Funding Ceiling Amount"
      expr: SUM(funding_ceiling_amount)
    - name: "Average Funding Ceiling Amount"
      expr: AVG(funding_ceiling_amount)
    - name: "Total Indirect Cost Rate"
      expr: SUM(indirect_cost_rate)
    - name: "Average Indirect Cost Rate"
      expr: AVG(indirect_cost_rate)
$$;