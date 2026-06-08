-- Metric views for domain: research | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`research_subject_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core research enrollment metrics tracking subject accrual, consent rates, withdrawal patterns, and enrollment pipeline health for clinical trial management."
  source: "`healthcare_ecm_v1`.`research`.`subject_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (screening, enrolled, active, completed, withdrawn) for pipeline analysis"
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment (randomized, open-label, compassionate use) for study design analysis"
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Eligibility determination status for screening funnel analysis"
    - name: "randomization_arm"
      expr: randomization_arm
      comment: "Treatment arm assignment for balanced enrollment monitoring"
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year of enrollment for temporal accrual tracking"
    - name: "enrollment_month"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month of enrollment for accrual rate trending"
    - name: "consent_given_flag"
      expr: CASE WHEN consent_given = true THEN 'Consented' ELSE 'Not Consented' END
      comment: "Whether informed consent was obtained"
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total number of subject enrollment records for accrual tracking"
    - name: "active_enrollments"
      expr: SUM(CASE WHEN enrollment_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of currently active enrolled subjects"
    - name: "withdrawn_subjects"
      expr: SUM(CASE WHEN enrollment_status = 'withdrawn' THEN 1 ELSE 0 END)
      comment: "Count of subjects who withdrew from study - key retention metric"
    - name: "screen_failure_count"
      expr: SUM(CASE WHEN eligibility_status = 'ineligible' OR eligibility_status = 'screen_failure' THEN 1 ELSE 0 END)
      comment: "Count of screen failures indicating eligibility criteria stringency"
    - name: "consent_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_given = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of subjects who provided informed consent out of all enrollment attempts"
    - name: "withdrawal_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN enrollment_status = 'withdrawn' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Subject withdrawal rate - critical for study viability and FDA reporting"
    - name: "distinct_studies_enrolling"
      expr: COUNT(DISTINCT subject_research_study_id)
      comment: "Number of distinct studies with enrollment activity"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`research_adverse_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research adverse event metrics for safety monitoring, regulatory reporting, and DSMB oversight. Critical for FDA compliance and study continuation decisions."
  source: "`healthcare_ecm_v1`.`research`.`adverse_event`"
  dimensions:
    - name: "adverse_event_status"
      expr: adverse_event_status
      comment: "Current status of the adverse event (reported, under investigation, resolved, closed)"
    - name: "severity_grade"
      expr: severity_grade
      comment: "CTCAE severity grade (1-5) for safety signal detection"
    - name: "event_type"
      expr: event_type
      comment: "Classification of adverse event type for pattern analysis"
    - name: "causality_assessment"
      expr: causality_assessment
      comment: "Investigator causality determination (related, possibly related, unrelated)"
    - name: "seriousness_criteria"
      expr: seriousness_criteria
      comment: "SAE seriousness criteria (death, life-threatening, hospitalization, disability)"
    - name: "irb_reportable_flag"
      expr: CASE WHEN irb_reportable = true THEN 'IRB Reportable' ELSE 'Not IRB Reportable' END
      comment: "Whether event requires IRB notification"
    - name: "expedited_report_flag"
      expr: CASE WHEN expedited_report_flag = true THEN 'Expedited' ELSE 'Standard' END
      comment: "Whether event requires expedited FDA/sponsor reporting (15-day or 7-day)"
    - name: "onset_month"
      expr: DATE_TRUNC('month', onset_date)
      comment: "Month of adverse event onset for temporal safety signal analysis"
    - name: "deviation_category"
      expr: deviation_category
      comment: "Category of protocol deviation associated with the adverse event"
  measures:
    - name: "total_adverse_events"
      expr: COUNT(1)
      comment: "Total adverse event count for safety monitoring dashboards"
    - name: "serious_adverse_events"
      expr: SUM(CASE WHEN seriousness_criteria IS NOT NULL AND seriousness_criteria != '' THEN 1 ELSE 0 END)
      comment: "Count of Serious Adverse Events (SAEs) requiring expedited regulatory reporting"
    - name: "expedited_reports"
      expr: SUM(CASE WHEN expedited_report_flag = true THEN 1 ELSE 0 END)
      comment: "Count of events requiring expedited reporting to FDA/sponsor within 7-15 days"
    - name: "irb_reportable_events"
      expr: SUM(CASE WHEN irb_reportable = true THEN 1 ELSE 0 END)
      comment: "Count of events requiring IRB notification for continuing review"
    - name: "unresolved_events"
      expr: SUM(CASE WHEN outcome IS NULL OR outcome = 'ongoing' THEN 1 ELSE 0 END)
      comment: "Count of adverse events without resolution - indicates open safety concerns"
    - name: "sae_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN seriousness_criteria IS NOT NULL AND seriousness_criteria != '' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "SAE rate as percentage of all AEs - key DSMB decision metric for study continuation"
    - name: "distinct_affected_subjects"
      expr: COUNT(DISTINCT subject_enrollment_id)
      comment: "Number of distinct subjects experiencing adverse events"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`research_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research study portfolio metrics for institutional research leadership, tracking study pipeline health, phase distribution, and operational status."
  source: "`healthcare_ecm_v1`.`research`.`research_study`"
  dimensions:
    - name: "research_study_status"
      expr: research_study_status
      comment: "Current study status (planning, active, enrolling, closed, terminated) for portfolio management"
    - name: "study_type"
      expr: study_type
      comment: "Type of research study (interventional, observational, registry) for portfolio mix analysis"
    - name: "phase"
      expr: phase
      comment: "Clinical trial phase (I, II, III, IV) for pipeline maturity assessment"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area for strategic research investment alignment"
    - name: "funding_source"
      expr: funding_source
      comment: "Funding source (NIH, industry, foundation, internal) for revenue diversification"
    - name: "is_multi_site"
      expr: CASE WHEN is_multi_site = true THEN 'Multi-Site' ELSE 'Single-Site' END
      comment: "Whether study is multi-site for complexity and coordination assessment"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Study start year for cohort analysis"
  measures:
    - name: "total_studies"
      expr: COUNT(1)
      comment: "Total number of research studies in portfolio"
    - name: "active_studies"
      expr: SUM(CASE WHEN research_study_status = 'active' OR research_study_status = 'enrolling' THEN 1 ELSE 0 END)
      comment: "Count of currently active or enrolling studies - institutional research capacity indicator"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget across all studies for research revenue tracking"
    - name: "avg_budget_per_study"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per study for resource planning and benchmarking"
    - name: "multi_site_study_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_multi_site = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of multi-site studies indicating institutional leadership in collaborative research"
    - name: "fda_compliant_studies"
      expr: SUM(CASE WHEN fda_21cfr11_compliant = true THEN 1 ELSE 0 END)
      comment: "Count of FDA 21 CFR Part 11 compliant studies for regulatory readiness"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`research_grant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research grant financial metrics for tracking funding portfolio health, award amounts, indirect cost recovery, and grant lifecycle management."
  source: "`healthcare_ecm_v1`.`research`.`research_grant`"
  dimensions:
    - name: "research_grant_status"
      expr: research_grant_status
      comment: "Grant lifecycle status (submitted, awarded, active, closeout) for pipeline management"
    - name: "grant_type"
      expr: grant_type
      comment: "Type of grant (R01, R21, U01, industry, foundation) for portfolio diversification analysis"
    - name: "funding_agency_name"
      expr: funding_agency_name
      comment: "Funding agency (NIH, NSF, DOD, industry) for sponsor relationship management"
    - name: "funding_mechanism"
      expr: funding_mechanism
      comment: "Funding mechanism for strategic alignment with agency priorities"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area for research investment alignment"
    - name: "research_category"
      expr: research_category
      comment: "Research category (basic, translational, clinical) for portfolio balance"
    - name: "award_year"
      expr: YEAR(award_date)
      comment: "Year of award for temporal funding trend analysis"
  measures:
    - name: "total_grants"
      expr: COUNT(1)
      comment: "Total number of research grants in portfolio"
    - name: "total_award_amount"
      expr: SUM(CAST(award_amount AS DOUBLE))
      comment: "Total award amount across all grants - primary research revenue metric"
    - name: "total_direct_costs"
      expr: SUM(CAST(direct_cost_amount AS DOUBLE))
      comment: "Total direct costs for research expenditure planning"
    - name: "total_indirect_costs"
      expr: SUM(CAST(indirect_cost_amount AS DOUBLE))
      comment: "Total indirect cost recovery - critical institutional revenue stream"
    - name: "avg_award_amount"
      expr: AVG(CAST(award_amount AS DOUBLE))
      comment: "Average grant award amount for benchmarking and forecasting"
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average negotiated indirect cost rate for financial planning"
    - name: "current_year_total_budget"
      expr: SUM(CAST(current_year_budget AS DOUBLE))
      comment: "Total current year budget across active grants for cash flow management"
    - name: "cost_sharing_total"
      expr: SUM(CAST(cost_sharing_amount AS DOUBLE))
      comment: "Total institutional cost sharing commitment - unfunded obligation tracking"
    - name: "human_subjects_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN involves_human_subjects = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of grants involving human subjects for IRB workload planning"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`research_grant_expenditure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grant expenditure metrics for financial compliance monitoring, burn rate analysis, and sponsor reporting. Critical for avoiding grant disallowances and audit findings."
  source: "`healthcare_ecm_v1`.`research`.`grant_expenditure`"
  dimensions:
    - name: "expense_category"
      expr: expense_category
      comment: "Expense category (personnel, supplies, equipment, travel, other) for budget variance analysis"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment processing status for cash flow management"
    - name: "budget_period"
      expr: budget_period
      comment: "Budget period for period-over-period spending analysis"
    - name: "is_indirect_cost"
      expr: CASE WHEN is_indirect_cost = true THEN 'Indirect' ELSE 'Direct' END
      comment: "Direct vs indirect cost classification for F&A rate compliance"
    - name: "expense_month"
      expr: DATE_TRUNC('month', expense_date)
      comment: "Month of expense for burn rate trending"
    - name: "sponsor_cost_classification"
      expr: sponsor_cost_classification
      comment: "Sponsor-specific cost classification for allowability determination"
  measures:
    - name: "total_expense_amount"
      expr: SUM(CAST(expense_amount AS DOUBLE))
      comment: "Total grant expenditures for budget utilization tracking"
    - name: "total_amount_with_indirect"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total amount including indirect costs for comprehensive spend tracking"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts on grant expenditures"
    - name: "avg_expense_amount"
      expr: AVG(CAST(expense_amount AS DOUBLE))
      comment: "Average expense transaction amount for anomaly detection"
    - name: "indirect_cost_total"
      expr: SUM(CASE WHEN is_indirect_cost = true THEN CAST(expense_amount AS DOUBLE) ELSE 0 END)
      comment: "Total indirect costs charged for F&A rate compliance monitoring"
    - name: "direct_cost_total"
      expr: SUM(CASE WHEN is_indirect_cost = false THEN CAST(expense_amount AS DOUBLE) ELSE 0 END)
      comment: "Total direct costs for budget category tracking"
    - name: "distinct_grants_with_spend"
      expr: COUNT(DISTINCT research_grant_id)
      comment: "Number of distinct grants with expenditure activity"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`research_protocol_deviation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Protocol deviation metrics for GCP compliance monitoring, site performance evaluation, and regulatory inspection readiness. High deviation rates trigger FDA scrutiny."
  source: "`healthcare_ecm_v1`.`research`.`protocol_deviation`"
  dimensions:
    - name: "protocol_deviation_status"
      expr: protocol_deviation_status
      comment: "Deviation status (identified, under review, resolved, closed) for compliance workflow tracking"
    - name: "deviation_category"
      expr: deviation_category
      comment: "Category of deviation (eligibility, consent, procedure, visit window, safety reporting) for root cause analysis"
    - name: "severity"
      expr: severity
      comment: "Deviation severity (minor, moderate, major, critical) for risk-based monitoring"
    - name: "irb_reportable"
      expr: irb_reportable
      comment: "Whether deviation requires IRB reporting for regulatory compliance"
    - name: "sponsor_reportable"
      expr: sponsor_reportable
      comment: "Whether deviation requires sponsor notification"
    - name: "discovery_month"
      expr: DATE_TRUNC('month', discovery_timestamp)
      comment: "Month of deviation discovery for trend analysis"
  measures:
    - name: "total_deviations"
      expr: COUNT(1)
      comment: "Total protocol deviations - primary GCP compliance indicator"
    - name: "major_critical_deviations"
      expr: SUM(CASE WHEN severity IN ('major', 'critical') THEN 1 ELSE 0 END)
      comment: "Count of major/critical deviations requiring immediate corrective action"
    - name: "irb_reportable_deviations"
      expr: SUM(CASE WHEN irb_reportable = 'true' OR irb_reportable = 'yes' THEN 1 ELSE 0 END)
      comment: "Count of IRB-reportable deviations for regulatory notification tracking"
    - name: "capa_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN capa_completed = 'true' OR capa_completed = 'yes' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "CAPA completion rate - measures effectiveness of corrective action program"
    - name: "distinct_affected_subjects"
      expr: COUNT(DISTINCT subject_enrollment_id)
      comment: "Number of distinct subjects affected by protocol deviations"
    - name: "distinct_affected_sites"
      expr: COUNT(DISTINCT study_site_id)
      comment: "Number of distinct sites with deviations for risk-based monitoring prioritization"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`research_study_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Study site performance metrics for multi-site trial management, enrollment capacity utilization, and risk-based monitoring decisions."
  source: "`healthcare_ecm_v1`.`research`.`study_site`"
  dimensions:
    - name: "site_status"
      expr: site_status
      comment: "Site operational status (selected, activated, enrolling, closed) for pipeline management"
    - name: "site_type"
      expr: site_type
      comment: "Type of research site (academic, community, VA, international) for performance benchmarking"
    - name: "site_region"
      expr: site_region
      comment: "Geographic region for diversity and access analysis"
    - name: "country_code"
      expr: country_code
      comment: "Country for international trial geographic distribution"
    - name: "corrective_action_required"
      expr: CASE WHEN corrective_action_required = true THEN 'CAPA Required' ELSE 'No CAPA' END
      comment: "Whether site has outstanding corrective actions"
    - name: "protocol_deviation_flag"
      expr: CASE WHEN protocol_deviation_flag = true THEN 'Has Deviations' ELSE 'No Deviations' END
      comment: "Whether site has protocol deviations flagged"
  measures:
    - name: "total_sites"
      expr: COUNT(1)
      comment: "Total number of study sites across all trials"
    - name: "active_sites"
      expr: SUM(CASE WHEN site_status = 'active' OR site_status = 'enrolling' THEN 1 ELSE 0 END)
      comment: "Count of currently active/enrolling sites"
    - name: "avg_site_performance_score"
      expr: AVG(CAST(site_performance_score AS DOUBLE))
      comment: "Average site performance score for benchmarking and risk-based monitoring"
    - name: "sites_with_corrective_action"
      expr: SUM(CASE WHEN corrective_action_required = true THEN 1 ELSE 0 END)
      comment: "Count of sites requiring corrective action - risk indicator for study integrity"
    - name: "sites_with_deviations"
      expr: SUM(CASE WHEN protocol_deviation_flag = true THEN 1 ELSE 0 END)
      comment: "Count of sites with protocol deviations for monitoring prioritization"
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sites requiring corrective action - institutional quality indicator"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`research_irb_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IRB submission metrics for research compliance oversight, review cycle time analysis, and regulatory readiness. Critical for maintaining research program velocity."
  source: "`healthcare_ecm_v1`.`research`.`irb_submission`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of IRB review (full board, expedited, exempt) for workload planning"
    - name: "submission_type"
      expr: submission_type
      comment: "Submission type (initial, amendment, continuing review, reportable event) for workflow analysis"
    - name: "review_status"
      expr: review_status
      comment: "Current review status for pipeline tracking"
    - name: "outcome"
      expr: outcome
      comment: "Review outcome (approved, approved with conditions, deferred, disapproved) for approval rate analysis"
    - name: "risk_level"
      expr: risk_level
      comment: "Study risk level determination for resource allocation"
    - name: "study_phase"
      expr: study_phase
      comment: "Clinical trial phase for complexity-based analysis"
    - name: "submission_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month of submission for volume trending"
    - name: "is_amendment"
      expr: CASE WHEN is_amendment = true THEN 'Amendment' ELSE 'Original' END
      comment: "Whether submission is an amendment vs original for workload characterization"
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total IRB submissions for research compliance workload tracking"
    - name: "approved_submissions"
      expr: SUM(CASE WHEN outcome = 'approved' OR outcome = 'approved_with_conditions' THEN 1 ELSE 0 END)
      comment: "Count of approved submissions for throughput measurement"
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN outcome = 'approved' OR outcome = 'approved_with_conditions' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "IRB approval rate - institutional research quality indicator"
    - name: "total_funding_requested"
      expr: SUM(CAST(total_funding_amount AS DOUBLE))
      comment: "Total funding amount across submitted studies for research revenue pipeline"
    - name: "vulnerable_population_studies"
      expr: SUM(CASE WHEN has_vulnerable_population = true THEN 1 ELSE 0 END)
      comment: "Count of studies involving vulnerable populations requiring additional protections"
    - name: "multi_site_submissions"
      expr: SUM(CASE WHEN is_multi_site = true THEN 1 ELSE 0 END)
      comment: "Count of multi-site submissions for single-IRB coordination workload"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`research_trial_matching`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical trial matching metrics for patient-trial eligibility assessment, enrollment optimization, and precision medicine trial access. Directly supports AMC trial matching programs."
  source: "`healthcare_ecm_v1`.`research`.`trial_matching`"
  dimensions:
    - name: "matching_status"
      expr: matching_status
      comment: "Current matching status (eligible, ineligible, pending review, enrolled) for funnel analysis"
    - name: "matching_type"
      expr: matching_type
      comment: "Type of matching (automated, manual, hybrid) for AI effectiveness assessment"
    - name: "consent_status"
      expr: consent_status
      comment: "Patient consent status for trial participation"
    - name: "patient_response"
      expr: patient_response
      comment: "Patient response to trial offer (interested, declined, no response) for engagement analysis"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area for disease-specific matching effectiveness"
    - name: "trial_phase"
      expr: trial_phase
      comment: "Trial phase for matching complexity analysis"
    - name: "evaluation_month"
      expr: DATE_TRUNC('month', evaluation_date)
      comment: "Month of eligibility evaluation for volume trending"
  measures:
    - name: "total_matches_evaluated"
      expr: COUNT(1)
      comment: "Total patient-trial matching evaluations performed"
    - name: "eligible_matches"
      expr: SUM(CASE WHEN matching_status = 'eligible' THEN 1 ELSE 0 END)
      comment: "Count of patients found eligible for trial enrollment"
    - name: "eligibility_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN matching_status = 'eligible' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Patient eligibility rate - measures criteria specificity and matching algorithm effectiveness"
    - name: "avg_eligibility_score"
      expr: AVG(CAST(eligibility_score AS DOUBLE))
      comment: "Average eligibility score across all evaluations for algorithm calibration"
    - name: "avg_confidence_level"
      expr: AVG(CAST(confidence_level AS DOUBLE))
      comment: "Average matching confidence level for algorithm quality assessment"
    - name: "enrolled_from_match_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN matching_status = 'enrolled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Conversion rate from match to enrollment - end-to-end trial matching effectiveness"
    - name: "distinct_patients_evaluated"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients evaluated for trial matching - reach metric"
    - name: "distinct_trials_matched"
      expr: COUNT(DISTINCT research_study_id)
      comment: "Distinct trials with matching activity for portfolio coverage"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`research_biospecimen`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Biospecimen management metrics for biobank operations, specimen quality, and research resource utilization. Critical for AMCs with active biobanking programs."
  source: "`healthcare_ecm_v1`.`research`.`biospecimen`"
  dimensions:
    - name: "specimen_type"
      expr: specimen_type
      comment: "Type of biospecimen (blood, tissue, urine, CSF) for inventory management"
    - name: "biospecimen_status"
      expr: biospecimen_status
      comment: "Current specimen status (collected, processed, stored, distributed, disposed) for lifecycle tracking"
    - name: "storage_status"
      expr: storage_status
      comment: "Storage status for inventory availability assessment"
    - name: "collection_method"
      expr: collection_method
      comment: "Collection method for quality and protocol compliance analysis"
    - name: "qc_passed_flag"
      expr: CASE WHEN qc_passed_flag = true THEN 'QC Passed' ELSE 'QC Failed' END
      comment: "Quality control pass/fail for specimen usability assessment"
    - name: "deidentification_status"
      expr: deidentification_status
      comment: "De-identification status for research readiness and compliance"
  measures:
    - name: "total_specimens"
      expr: COUNT(1)
      comment: "Total biospecimen inventory count for biobank capacity planning"
    - name: "qc_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN qc_passed_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "QC pass rate - specimen quality indicator for research usability"
    - name: "total_volume"
      expr: SUM(CAST(volume AS DOUBLE))
      comment: "Total specimen volume in inventory for capacity planning"
    - name: "total_aliquot_volume"
      expr: SUM(CAST(aliquot_volume AS DOUBLE))
      comment: "Total aliquot volume available for distribution"
    - name: "avg_storage_temperature"
      expr: AVG(CAST(storage_temperature AS DOUBLE))
      comment: "Average storage temperature for cold chain compliance monitoring"
    - name: "distinct_subjects_with_specimens"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with biospecimens for cohort availability assessment"
    - name: "distinct_studies_with_specimens"
      expr: COUNT(DISTINCT research_study_id)
      comment: "Distinct studies with biospecimen collections for resource allocation"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`research_monitoring_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical research monitoring visit metrics for sponsor oversight, site compliance assessment, and risk-based monitoring program effectiveness."
  source: "`healthcare_ecm_v1`.`research`.`monitoring_visit`"
  dimensions:
    - name: "visit_type"
      expr: visit_type
      comment: "Type of monitoring visit (routine, for-cause, close-out, pre-study) for resource planning"
    - name: "visit_status"
      expr: visit_status
      comment: "Visit completion status for monitoring schedule adherence"
    - name: "corrective_action_required_flag"
      expr: CASE WHEN corrective_action_required_flag = true THEN 'CAPA Required' ELSE 'No CAPA' END
      comment: "Whether visit resulted in corrective action requirement"
    - name: "protocol_deviation_flag"
      expr: CASE WHEN protocol_deviation_flag = true THEN 'Deviation Found' ELSE 'No Deviation' END
      comment: "Whether protocol deviations were identified during visit"
    - name: "visit_month"
      expr: DATE_TRUNC('month', visit_timestamp)
      comment: "Month of monitoring visit for schedule adherence trending"
  measures:
    - name: "total_monitoring_visits"
      expr: COUNT(1)
      comment: "Total monitoring visits conducted for oversight compliance"
    - name: "visits_with_findings"
      expr: SUM(CASE WHEN corrective_action_required_flag = true OR protocol_deviation_flag = true THEN 1 ELSE 0 END)
      comment: "Visits resulting in findings - site quality indicator"
    - name: "finding_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required_flag = true OR protocol_deviation_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of visits with findings - risk-based monitoring effectiveness metric"
    - name: "capa_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of visits requiring corrective action - GCP compliance indicator"
    - name: "distinct_sites_monitored"
      expr: COUNT(DISTINCT study_site_id)
      comment: "Distinct sites monitored for coverage assessment"
    - name: "distinct_studies_monitored"
      expr: COUNT(DISTINCT research_study_id)
      comment: "Distinct studies with monitoring activity for portfolio oversight"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`research_billing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research billing event metrics for clinical trial financial management, coverage analysis compliance, and sponsor invoicing. Critical for research revenue cycle."
  source: "`healthcare_ecm_v1`.`research`.`billing_event`"
  dimensions:
    - name: "billing_category"
      expr: billing_category
      comment: "Billing category (routine care, research-only, device) for coverage determination"
    - name: "billing_event_status"
      expr: billing_event_status
      comment: "Billing event processing status for revenue cycle tracking"
    - name: "coverage_determination"
      expr: coverage_determination
      comment: "Coverage determination (sponsor, payer, patient, shared) for financial routing"
    - name: "charge_type"
      expr: charge_type
      comment: "Type of charge for financial classification"
    - name: "approval_status"
      expr: approval_status
      comment: "Billing approval status for revenue recognition"
    - name: "payer"
      expr: payer
      comment: "Responsible payer for the research service"
    - name: "service_month"
      expr: DATE_TRUNC('month', service_date)
      comment: "Month of service for revenue trending"
  measures:
    - name: "total_billing_events"
      expr: COUNT(1)
      comment: "Total research billing events for volume tracking"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross charges for research services"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net revenue from research billing after adjustments"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total billing adjustments for write-off and variance analysis"
    - name: "avg_charge_per_event"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average charge per billing event for rate benchmarking"
    - name: "sponsor_covered_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN coverage_determination = 'sponsor' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of charges covered by sponsor for coverage analysis compliance"
    - name: "eligible_event_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_eligible = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of billing events deemed eligible for coverage - compliance metric"
$$;