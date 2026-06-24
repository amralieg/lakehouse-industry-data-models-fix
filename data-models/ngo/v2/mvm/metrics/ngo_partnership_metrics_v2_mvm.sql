-- Metric views for domain: partnership | Business: Ngo | Version: 2 | Generated on: 2026-06-23 02:03:19

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for partnership agreements — tracks portfolio size, financial exposure, funding ceilings, indirect cost rates, and agreement lifecycle attributes to support partnership governance and resource allocation decisions."
  source: "`vibe_ngo_v1`.`partnership`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current lifecycle status of the agreement (e.g. Active, Expired, Terminated) — primary filter for portfolio health analysis."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Classification of the agreement type (e.g. MOU, Grant, Sub-award) — used to segment portfolio by instrument type."
    - name: "is_consortium_agreement"
      expr: is_consortium_agreement
      comment: "Flags whether the agreement is part of a consortium arrangement — enables consortium vs bilateral portfolio split."
    - name: "is_sub_award"
      expr: is_sub_award
      comment: "Flags whether the agreement is a sub-award — supports pass-through funding analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic coverage of the agreement — enables regional portfolio segmentation."
    - name: "program_sector"
      expr: program_sector
      comment: "Sector alignment of the agreement (e.g. Health, Education, WASH) — supports thematic portfolio analysis."
    - name: "hact_transfer_modality"
      expr: hact_transfer_modality
      comment: "HACT-defined transfer modality — critical for UN/NGO compliance and risk-based oversight segmentation."
    - name: "due_diligence_risk_rating"
      expr: due_diligence_risk_rating
      comment: "Risk rating assigned during due diligence — enables risk-tiered portfolio monitoring."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of required partner reporting — used to assess reporting burden and compliance risk."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the agreement became effective — supports cohort and trend analysis of agreement portfolio."
    - name: "effective_end_year"
      expr: YEAR(effective_end_date)
      comment: "Year the agreement is set to expire — supports pipeline and renewal planning."
    - name: "capacity_assessment_status"
      expr: capacity_assessment_status
      comment: "Status of the capacity assessment linked to this agreement — used to track due diligence completeness."
  measures:
    - name: "total_active_agreements"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN agreement_id END)
      comment: "Count of currently active agreements — baseline KPI for partnership portfolio size and operational reach."
    - name: "total_funding_ceiling_usd"
      expr: SUM(CAST(funding_ceiling_amount AS DOUBLE))
      comment: "Total funding ceiling across all agreements in USD — measures total financial exposure and partnership investment scale."
    - name: "avg_funding_ceiling_usd"
      expr: AVG(CAST(funding_ceiling_amount AS DOUBLE))
      comment: "Average funding ceiling per agreement — benchmarks typical agreement size and informs resource allocation norms."
    - name: "total_indirect_cost_usd"
      expr: SUM(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Sum of indirect cost rates across agreements — proxy for total overhead burden on the partnership portfolio."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate across agreements — benchmarks overhead efficiency and informs negotiation strategy."
    - name: "consortium_agreement_count"
      expr: COUNT(CASE WHEN is_consortium_agreement = TRUE THEN agreement_id END)
      comment: "Number of consortium agreements — tracks localization and multi-partner collaboration trends."
    - name: "sub_award_count"
      expr: COUNT(CASE WHEN is_sub_award = TRUE THEN agreement_id END)
      comment: "Number of sub-award agreements — measures pass-through funding volume and downstream partner engagement."
    - name: "agreements_with_renewal_option"
      expr: COUNT(CASE WHEN renewal_option = TRUE THEN agreement_id END)
      comment: "Count of agreements with a renewal option — supports pipeline forecasting and partner retention planning."
    - name: "distinct_partner_orgs"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of unique partner organizations with agreements — measures breadth of the partnership network."
    - name: "distinct_interventions_covered"
      expr: COUNT(DISTINCT intervention_id)
      comment: "Number of distinct program interventions covered by agreements — measures programmatic reach of the partnership portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_capacity_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for partner capacity assessments — tracks assessment coverage, risk ratings, functional area scores, and capacity building triggers to inform risk-based partnership management and localization strategy."
  source: "`vibe_ngo_v1`.`partnership`.`capacity_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the capacity assessment (e.g. Completed, In Progress, Pending) — primary filter for assessment pipeline monitoring."
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of capacity assessment conducted (e.g. HACT Micro, Full, Desk Review) — enables comparison across assessment methodologies."
    - name: "overall_risk_rating"
      expr: overall_risk_rating
      comment: "Overall risk rating assigned to the partner (e.g. Low, Medium, High, Significant) — primary risk segmentation dimension."
    - name: "financial_risk_rating"
      expr: financial_risk_rating
      comment: "Financial management risk rating — supports targeted financial oversight and capacity building prioritization."
    - name: "ip_transfer_modality"
      expr: ip_transfer_modality
      comment: "Recommended implementing partner transfer modality based on assessment — drives financial control decisions."
    - name: "capacity_building_plan_required"
      expr: capacity_building_plan_required
      comment: "Flags whether a capacity building plan is required — used to track follow-up obligations post-assessment."
    - name: "enhanced_monitoring_required"
      expr: enhanced_monitoring_required
      comment: "Flags whether enhanced monitoring is required — identifies high-risk partners needing intensified oversight."
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year the assessment was conducted — supports trend analysis of partner risk profiles over time."
    - name: "assessment_methodology"
      expr: assessment_methodology
      comment: "Methodology used for the assessment — enables quality and comparability analysis across assessment approaches."
  measures:
    - name: "total_assessments_completed"
      expr: COUNT(CASE WHEN assessment_status = 'Completed' THEN capacity_assessment_id END)
      comment: "Number of completed capacity assessments — baseline KPI for due diligence coverage and compliance."
    - name: "avg_overall_capacity_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall capacity score across assessed partners — headline indicator of partner ecosystem capability."
    - name: "avg_financial_mgmt_score"
      expr: AVG(CAST(financial_mgmt_score AS DOUBLE))
      comment: "Average financial management score — key risk indicator for fiduciary oversight and fund transfer decisions."
    - name: "avg_governance_score"
      expr: AVG(CAST(governance_score AS DOUBLE))
      comment: "Average governance score across partners — measures organizational accountability and leadership quality."
    - name: "avg_program_mgmt_score"
      expr: AVG(CAST(program_mgmt_score AS DOUBLE))
      comment: "Average program management score — indicates partner delivery capability and programmatic quality."
    - name: "avg_mel_score"
      expr: AVG(CAST(mel_score AS DOUBLE))
      comment: "Average monitoring, evaluation and learning score — measures partner data quality and accountability capacity."
    - name: "high_risk_partner_count"
      expr: COUNT(CASE WHEN overall_risk_rating IN ('High', 'Significant') THEN capacity_assessment_id END)
      comment: "Number of partners rated High or Significant risk — drives enhanced monitoring and capacity building prioritization."
    - name: "capacity_building_plan_required_count"
      expr: COUNT(CASE WHEN capacity_building_plan_required = TRUE THEN capacity_assessment_id END)
      comment: "Number of assessments triggering a mandatory capacity building plan — measures scale of capacity development obligations."
    - name: "enhanced_monitoring_required_count"
      expr: COUNT(CASE WHEN enhanced_monitoring_required = TRUE THEN capacity_assessment_id END)
      comment: "Number of partners requiring enhanced monitoring — quantifies intensified oversight workload."
    - name: "distinct_partners_assessed"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of unique partner organizations assessed — measures due diligence coverage breadth."
    - name: "avg_partner_self_assessment_score"
      expr: AVG(CAST(partner_self_assessment_score AS DOUBLE))
      comment: "Average partner self-assessment score — enables gap analysis between self-reported and independently assessed capacity."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_capacity_building_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for partner capacity building plans — tracks investment, progress, budget utilization, and strategic alignment to measure effectiveness of localization and partner development efforts."
  source: "`vibe_ngo_v1`.`partnership`.`capacity_building_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the capacity building plan (e.g. Active, Completed, On Hold) — primary filter for plan portfolio monitoring."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of capacity building plan — enables segmentation by intervention approach."
    - name: "overall_progress_status"
      expr: overall_progress_status
      comment: "Overall progress status of the plan — used to identify at-risk or delayed capacity building efforts."
    - name: "localization_strategy_aligned"
      expr: localization_strategy_aligned
      comment: "Flags whether the plan is aligned to the localization strategy — tracks Grand Bargain and localization commitments."
    - name: "safeguarding_component_included"
      expr: safeguarding_component_included
      comment: "Flags whether safeguarding is included in the plan — measures compliance with safeguarding standards."
    - name: "gender_mainstreaming_included"
      expr: gender_mainstreaming_included
      comment: "Flags whether gender mainstreaming is included — tracks gender-responsive capacity development."
    - name: "chs_standard_aligned"
      expr: chs_standard_aligned
      comment: "Flags alignment with Core Humanitarian Standard — measures quality and accountability compliance."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of plan progress reporting — used to assess oversight intensity."
    - name: "plan_start_year"
      expr: YEAR(start_date)
      comment: "Year the capacity building plan started — supports cohort and trend analysis."
  measures:
    - name: "total_budget_usd"
      expr: SUM(CAST(total_budget_usd AS DOUBLE))
      comment: "Total budget allocated to capacity building plans in USD — measures total investment in partner development."
    - name: "total_expenditure_to_date_usd"
      expr: SUM(CAST(expenditure_to_date_usd AS DOUBLE))
      comment: "Total expenditure to date across capacity building plans — tracks actual spend against investment commitments."
    - name: "avg_budget_per_plan_usd"
      expr: AVG(CAST(total_budget_usd AS DOUBLE))
      comment: "Average budget per capacity building plan — benchmarks investment intensity per partner engagement."
    - name: "avg_baseline_capacity_score"
      expr: AVG(CAST(baseline_capacity_score AS DOUBLE))
      comment: "Average baseline capacity score at plan inception — establishes starting point for measuring capacity gains."
    - name: "avg_current_capacity_score"
      expr: AVG(CAST(current_capacity_score AS DOUBLE))
      comment: "Average current capacity score — measures real-time partner capability level across the portfolio."
    - name: "avg_target_capacity_score"
      expr: AVG(CAST(target_capacity_score AS DOUBLE))
      comment: "Average target capacity score — benchmarks ambition level of capacity building investments."
    - name: "localization_aligned_plan_count"
      expr: COUNT(CASE WHEN localization_strategy_aligned = TRUE THEN capacity_building_plan_id END)
      comment: "Number of plans aligned to localization strategy — tracks progress on Grand Bargain localization commitments."
    - name: "safeguarding_included_plan_count"
      expr: COUNT(CASE WHEN safeguarding_component_included = TRUE THEN capacity_building_plan_id END)
      comment: "Number of plans with a safeguarding component — measures compliance with safeguarding capacity requirements."
    - name: "distinct_partners_with_plans"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of unique partner organizations with active capacity building plans — measures breadth of development investment."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_due_diligence_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for partner due diligence — tracks compliance verification coverage, risk levels, certification statuses, and screening outcomes to support risk-based partnership governance and regulatory compliance."
  source: "`vibe_ngo_v1`.`partnership`.`due_diligence_record`"
  dimensions:
    - name: "diligence_status"
      expr: diligence_status
      comment: "Current status of the due diligence process (e.g. Completed, Pending, In Review) — primary filter for compliance pipeline."
    - name: "diligence_type"
      expr: diligence_type
      comment: "Type of due diligence conducted (e.g. Full, Simplified, Desk Review) — enables segmentation by rigor level."
    - name: "risk_level"
      expr: risk_level
      comment: "Overall risk level assigned to the partner (e.g. Low, Medium, High) — primary risk segmentation for oversight decisions."
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Final outcome of the due diligence process (e.g. Approved, Conditional, Rejected) — drives partnership eligibility decisions."
    - name: "chs_certification_status"
      expr: chs_certification_status
      comment: "Core Humanitarian Standard certification status — measures quality and accountability compliance."
    - name: "debarment_check_status"
      expr: debarment_check_status
      comment: "Status of debarment screening — critical compliance check for donor and regulatory requirements."
    - name: "aml_cft_check_status"
      expr: aml_cft_check_status
      comment: "Anti-money laundering and counter-terrorism financing check status — regulatory compliance dimension."
    - name: "financial_audit_opinion"
      expr: financial_audit_opinion
      comment: "External audit opinion on partner financials — key fiduciary risk indicator."
    - name: "initiation_year"
      expr: YEAR(initiation_date)
      comment: "Year due diligence was initiated — supports trend analysis of compliance workload."
  measures:
    - name: "total_due_diligence_records"
      expr: COUNT(due_diligence_record_id)
      comment: "Total number of due diligence records — baseline measure of compliance screening volume."
    - name: "completed_due_diligence_count"
      expr: COUNT(CASE WHEN diligence_status = 'Completed' THEN due_diligence_record_id END)
      comment: "Number of completed due diligence processes — measures compliance coverage and throughput."
    - name: "high_risk_partner_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN due_diligence_record_id END)
      comment: "Number of partners assessed as high risk — drives enhanced monitoring and conditional approval decisions."
    - name: "legal_registration_verified_count"
      expr: COUNT(CASE WHEN legal_registration_verified = TRUE THEN due_diligence_record_id END)
      comment: "Number of partners with verified legal registration — measures foundational compliance coverage."
    - name: "safeguarding_policy_verified_count"
      expr: COUNT(CASE WHEN safeguarding_policy_verified = TRUE THEN due_diligence_record_id END)
      comment: "Number of partners with verified safeguarding policies — tracks compliance with safeguarding standards."
    - name: "anti_terrorism_certified_count"
      expr: COUNT(CASE WHEN anti_terrorism_certification = TRUE THEN due_diligence_record_id END)
      comment: "Number of partners with valid anti-terrorism certification — measures regulatory compliance for donor requirements."
    - name: "financial_audit_reviewed_count"
      expr: COUNT(CASE WHEN financial_audit_reviewed = TRUE THEN due_diligence_record_id END)
      comment: "Number of partners with reviewed financial audits — measures fiduciary due diligence coverage."
    - name: "distinct_partners_screened"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of unique partner organizations that have undergone due diligence — measures compliance coverage breadth."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_partner_org`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the partner organization registry — tracks portfolio composition, financial scale, capacity scores, due diligence status, and sanctions screening to support partner selection and governance decisions."
  source: "`vibe_ngo_v1`.`partnership`.`partner_org`"
  dimensions:
    - name: "org_type"
      expr: org_type
      comment: "Type of partner organization (e.g. NNGO, INGO, CBO, UN Agency) — primary segmentation for localization and portfolio analysis."
    - name: "partnership_status"
      expr: partnership_status
      comment: "Current partnership status (e.g. Active, Inactive, Suspended) — primary filter for active partner portfolio."
    - name: "due_diligence_status"
      expr: due_diligence_status
      comment: "Current due diligence status of the partner — drives eligibility for new agreements."
    - name: "hq_country"
      expr: hq_country
      comment: "Country where the partner organization is headquartered — enables geographic portfolio analysis."
    - name: "chs_certified"
      expr: chs_certified
      comment: "Flags whether the partner holds CHS certification — measures quality and accountability standard adoption."
    - name: "sanctions_screened"
      expr: sanctions_screened
      comment: "Flags whether the partner has been sanctions screened — critical compliance indicator."
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Accreditation status of the partner organization — used to segment by formal recognition level."
  measures:
    - name: "total_active_partners"
      expr: COUNT(CASE WHEN partnership_status = 'Active' THEN partner_org_id END)
      comment: "Number of currently active partner organizations — headline KPI for partnership network size."
    - name: "total_annual_budget_usd"
      expr: SUM(CAST(annual_budget_usd AS DOUBLE))
      comment: "Total annual budget across all partner organizations in USD — measures aggregate financial scale of the partner ecosystem."
    - name: "avg_annual_budget_usd"
      expr: AVG(CAST(annual_budget_usd AS DOUBLE))
      comment: "Average annual budget per partner organization — benchmarks typical partner financial capacity."
    - name: "avg_capacity_assessment_score"
      expr: AVG(CAST(capacity_assessment_score AS DOUBLE))
      comment: "Average capacity assessment score across partner organizations — headline indicator of partner ecosystem capability."
    - name: "chs_certified_partner_count"
      expr: COUNT(CASE WHEN chs_certified = TRUE THEN partner_org_id END)
      comment: "Number of CHS-certified partners — measures quality standard adoption across the partnership portfolio."
    - name: "sanctions_screened_partner_count"
      expr: COUNT(CASE WHEN sanctions_screened = TRUE THEN partner_org_id END)
      comment: "Number of partners that have been sanctions screened — measures regulatory compliance coverage."
    - name: "due_diligence_expired_count"
      expr: COUNT(CASE WHEN due_diligence_expiry_date < CURRENT_DATE() THEN partner_org_id END)
      comment: "Number of partners with expired due diligence — identifies compliance gaps requiring immediate renewal action."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_partner_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for partner performance reviews — tracks delivery quality, financial accountability, reporting compliance, milestone achievement, and corrective action rates to steer partnership management and renewal decisions."
  source: "`vibe_ngo_v1`.`partnership`.`partner_performance_review`"
  dimensions:
    - name: "overall_performance_rating"
      expr: overall_performance_rating
      comment: "Overall performance rating assigned to the partner (e.g. Excellent, Satisfactory, Unsatisfactory) — primary KPI for partner quality segmentation."
    - name: "review_type"
      expr: review_type
      comment: "Type of performance review conducted (e.g. Mid-term, Final, Annual) — enables comparison across review cycles."
    - name: "review_status"
      expr: review_status
      comment: "Current status of the review process — used to track review pipeline completion."
    - name: "financial_accountability_rating"
      expr: financial_accountability_rating
      comment: "Rating for financial accountability — key fiduciary performance dimension."
    - name: "programmatic_quality_rating"
      expr: programmatic_quality_rating
      comment: "Rating for programmatic quality — measures delivery effectiveness."
    - name: "reporting_compliance_rating"
      expr: reporting_compliance_rating
      comment: "Rating for reporting compliance — measures partner accountability on reporting obligations."
    - name: "safeguarding_compliance_rating"
      expr: safeguarding_compliance_rating
      comment: "Rating for safeguarding compliance — critical risk and accountability dimension."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flags whether a corrective action plan is required — identifies underperforming partners needing intervention."
    - name: "partnership_renewal_recommendation"
      expr: partnership_renewal_recommendation
      comment: "Recommendation on whether to renew the partnership — directly informs strategic partnership continuation decisions."
    - name: "review_year"
      expr: YEAR(review_date)
      comment: "Year the performance review was conducted — supports trend analysis of partner performance over time."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned during the performance review — enables risk-tiered portfolio monitoring."
  measures:
    - name: "avg_overall_performance_score"
      expr: AVG(CAST(overall_performance_score AS DOUBLE))
      comment: "Average overall performance score across reviewed partners — headline KPI for partner delivery quality."
    - name: "avg_budget_utilisation_rate"
      expr: AVG(CAST(budget_utilisation_rate AS DOUBLE))
      comment: "Average budget utilisation rate across partners — measures financial absorption capacity and delivery pace."
    - name: "avg_milestone_achievement_rate"
      expr: AVG(CAST(milestone_achievement_rate AS DOUBLE))
      comment: "Average milestone achievement rate — measures programmatic delivery effectiveness against planned targets."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN partner_performance_review_id END)
      comment: "Number of reviews triggering a corrective action plan — quantifies underperformance requiring management intervention."
    - name: "field_visit_conducted_count"
      expr: COUNT(CASE WHEN field_visit_conducted = TRUE THEN partner_performance_review_id END)
      comment: "Number of reviews with a field visit conducted — measures quality of oversight and verification rigor."
    - name: "beneficiary_feedback_incorporated_count"
      expr: COUNT(CASE WHEN beneficiary_feedback_incorporated = TRUE THEN partner_performance_review_id END)
      comment: "Number of reviews incorporating beneficiary feedback — measures accountability to affected populations."
    - name: "distinct_partners_reviewed"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of unique partner organizations reviewed — measures performance monitoring coverage."
    - name: "total_reviews_completed"
      expr: COUNT(CASE WHEN review_status = 'Completed' THEN partner_performance_review_id END)
      comment: "Total number of completed performance reviews — baseline measure of oversight throughput."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_partner_report_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for partner report submissions — tracks reporting compliance, timeliness, quality scores, financial accountability, and expenditure reporting to support donor compliance and partner accountability management."
  source: "`vibe_ngo_v1`.`partnership`.`partner_report_submission`"
  dimensions:
    - name: "report_type"
      expr: report_type
      comment: "Type of report submitted (e.g. Narrative, Financial, Combined) — primary segmentation for reporting compliance analysis."
    - name: "review_status"
      expr: review_status
      comment: "Current review status of the submitted report — tracks review pipeline and acceptance rates."
    - name: "is_late_submission"
      expr: is_late_submission
      comment: "Flags whether the report was submitted late — primary indicator of reporting compliance."
    - name: "report_period_frequency"
      expr: report_period_frequency
      comment: "Frequency of the reporting period (e.g. Monthly, Quarterly, Annual) — enables compliance analysis by reporting cycle."
    - name: "donor_reporting_obligation"
      expr: donor_reporting_obligation
      comment: "Flags whether the report fulfills a donor reporting obligation — prioritizes compliance monitoring for donor-facing reports."
    - name: "mel_indicators_reported"
      expr: mel_indicators_reported
      comment: "Flags whether MEL indicators were reported — measures data quality and programmatic accountability."
    - name: "financial_documentation_attached"
      expr: financial_documentation_attached
      comment: "Flags whether financial documentation was attached — measures financial accountability compliance."
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year of report submission — supports trend analysis of reporting compliance over time."
    - name: "cluster_sector"
      expr: cluster_sector
      comment: "Cluster or sector the report relates to — enables sector-level reporting compliance analysis."
  measures:
    - name: "total_reports_submitted"
      expr: COUNT(partner_report_submission_id)
      comment: "Total number of partner reports submitted — baseline measure of reporting volume and partner engagement."
    - name: "late_submission_count"
      expr: COUNT(CASE WHEN is_late_submission = TRUE THEN partner_report_submission_id END)
      comment: "Number of late report submissions — key compliance KPI for partner accountability management."
    - name: "total_expenditure_reported_usd"
      expr: SUM(CAST(total_expenditure_reported AS DOUBLE))
      comment: "Total expenditure reported across all partner submissions in USD — measures financial accountability and burn rate."
    - name: "avg_expenditure_reported_usd"
      expr: AVG(CAST(total_expenditure_reported AS DOUBLE))
      comment: "Average expenditure reported per submission — benchmarks typical financial reporting volume per partner."
    - name: "total_approved_budget_usd"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved budget amount across submissions — measures total financial authorization under active reporting."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average report quality score — measures overall quality of partner reporting and informs capacity building needs."
    - name: "mel_indicators_reported_count"
      expr: COUNT(CASE WHEN mel_indicators_reported = TRUE THEN partner_report_submission_id END)
      comment: "Number of reports with MEL indicators reported — measures programmatic data quality and accountability."
    - name: "financial_documentation_attached_count"
      expr: COUNT(CASE WHEN financial_documentation_attached = TRUE THEN partner_report_submission_id END)
      comment: "Number of reports with financial documentation attached — measures financial accountability compliance rate."
    - name: "distinct_partners_reporting"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of unique partner organizations that have submitted reports — measures active reporting coverage."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_consortium`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for consortium arrangements — tracks funding scale, localization percentages, member counts, and operational status to support multi-partner coordination and Grand Bargain localization commitments."
  source: "`vibe_ngo_v1`.`partnership`.`consortium`"
  dimensions:
    - name: "consortium_type"
      expr: consortium_type
      comment: "Type of consortium arrangement — enables segmentation by collaboration model."
    - name: "chs_compliance_status"
      expr: chs_compliance_status
      comment: "Core Humanitarian Standard compliance status of the consortium — measures quality and accountability standard adoption."
    - name: "grand_bargain_localization"
      expr: grand_bargain_localization
      comment: "Flags whether the consortium is aligned to Grand Bargain localization commitments — tracks localization progress."
    - name: "ngo_role"
      expr: ngo_role
      comment: "Role of the NGO within the consortium (e.g. Lead, Member) — enables analysis by organizational positioning."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the consortium — supports regional portfolio analysis."
    - name: "thematic_focus"
      expr: thematic_focus
      comment: "Thematic focus area of the consortium — enables sector-level portfolio analysis."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Reporting frequency for the consortium — used to assess oversight intensity."
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the consortium was established — supports cohort and trend analysis."
  measures:
    - name: "total_consortium_funding_usd"
      expr: SUM(CAST(total_funding_amount AS DOUBLE))
      comment: "Total funding amount across all consortia in USD — measures aggregate financial scale of multi-partner arrangements."
    - name: "avg_consortium_funding_usd"
      expr: AVG(CAST(total_funding_amount AS DOUBLE))
      comment: "Average funding amount per consortium — benchmarks typical consortium investment size."
    - name: "avg_localization_percentage"
      expr: AVG(CAST(localization_percentage AS DOUBLE))
      comment: "Average localization percentage across consortia — headline KPI for Grand Bargain localization progress."
    - name: "avg_ngo_funding_share"
      expr: AVG(CAST(ngo_funding_share AS DOUBLE))
      comment: "Average NGO funding share within consortia — measures financial empowerment of local and national NGOs."
    - name: "grand_bargain_aligned_count"
      expr: COUNT(CASE WHEN grand_bargain_localization = TRUE THEN consortium_id END)
      comment: "Number of consortia aligned to Grand Bargain localization commitments — tracks progress on localization agenda."
    - name: "distinct_lead_partners"
      expr: COUNT(DISTINCT lead_partner_org_id)
      comment: "Number of unique organizations serving as consortium lead — measures diversity of consortium leadership."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`partnership_consortium_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for consortium membership — tracks funding allocations, cost-sharing, indirect cost rates, and member performance to support equitable resource distribution and consortium governance decisions."
  source: "`vibe_ngo_v1`.`partnership`.`consortium_member`"
  dimensions:
    - name: "member_role"
      expr: member_role
      comment: "Role of the member within the consortium (e.g. Lead, Co-implementer, Technical Partner) — primary segmentation for role-based analysis."
    - name: "membership_status"
      expr: membership_status
      comment: "Current membership status (e.g. Active, Withdrawn, Suspended) — primary filter for active consortium membership."
    - name: "performance_rating"
      expr: performance_rating
      comment: "Performance rating of the consortium member — enables quality-based segmentation of member contributions."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the consortium member — supports risk-tiered oversight within the consortium."
    - name: "cost_share_required"
      expr: cost_share_required
      comment: "Flags whether cost-sharing is required from this member — used to track co-financing obligations."
    - name: "voting_rights"
      expr: voting_rights
      comment: "Flags whether the member has voting rights in consortium governance — measures governance inclusivity."
    - name: "contribution_type"
      expr: contribution_type
      comment: "Type of contribution made by the member (e.g. Financial, In-kind, Technical) — enables analysis by contribution modality."
    - name: "membership_start_year"
      expr: YEAR(membership_start_date)
      comment: "Year membership commenced — supports cohort analysis of consortium composition."
  measures:
    - name: "total_funding_allocation_usd"
      expr: SUM(CAST(funding_allocation_amount AS DOUBLE))
      comment: "Total funding allocated to consortium members in USD — measures aggregate financial distribution across the consortium."
    - name: "avg_funding_allocation_usd"
      expr: AVG(CAST(funding_allocation_amount AS DOUBLE))
      comment: "Average funding allocation per consortium member — benchmarks equitable resource distribution."
    - name: "avg_funding_allocation_percentage"
      expr: AVG(CAST(funding_allocation_percentage AS DOUBLE))
      comment: "Average funding allocation percentage per member — measures proportional resource distribution within consortia."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate across consortium members — benchmarks overhead efficiency across the consortium."
    - name: "avg_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average cost-share percentage across members — measures co-financing contribution levels."
    - name: "distinct_partner_orgs_in_consortia"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of unique partner organizations participating in consortia — measures breadth of multi-partner engagement."
    - name: "active_member_count"
      expr: COUNT(CASE WHEN membership_status = 'Active' THEN consortium_member_id END)
      comment: "Number of currently active consortium members — baseline KPI for consortium operational scale."
$$;