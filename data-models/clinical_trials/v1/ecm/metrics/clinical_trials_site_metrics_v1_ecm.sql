-- Metric views for domain: site | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-06 23:23:25

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`site_activation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks site activation lifecycle performance including time-to-activate, activation status distribution, and milestone completion rates critical for study startup timelines."
  source: "`clinical_trials_ecm`.`site`.`activation`"
  dimensions:
    - name: "activation_status"
      expr: activation_status
      comment: "Current status of the site activation process (e.g., In Progress, Completed, On Hold)"
    - name: "activation_type"
      expr: activation_type
      comment: "Type of activation (e.g., Full, Conditional)"
    - name: "country_code"
      expr: country_code
      comment: "Country where the site is being activated, for geographic analysis"
    - name: "siv_status"
      expr: siv_status
      comment: "Site Initiation Visit status indicating readiness progression"
    - name: "irb_iec_status"
      expr: irb_iec_status
      comment: "IRB/IEC approval status at the site level"
    - name: "activation_year"
      expr: YEAR(actual_activation_date)
      comment: "Year of actual activation for trend analysis"
    - name: "activation_month"
      expr: DATE_TRUNC('month', actual_activation_date)
      comment: "Month of actual activation for trend analysis"
  measures:
    - name: "total_activations"
      expr: COUNT(1)
      comment: "Total number of site activation records for baseline volumetrics"
    - name: "essential_docs_verified_count"
      expr: COUNT(CASE WHEN essential_docs_verified = TRUE THEN 1 END)
      comment: "Number of activations with all essential documents verified - key regulatory readiness indicator"
    - name: "financial_agreement_executed_count"
      expr: COUNT(CASE WHEN financial_agreement_executed = TRUE THEN 1 END)
      comment: "Number of activations with financial agreements executed - prerequisite for enrollment"
    - name: "gcp_training_completed_count"
      expr: COUNT(CASE WHEN gcp_training_completed = TRUE THEN 1 END)
      comment: "Number of activations with GCP training completed - compliance requirement"
    - name: "avg_days_cda_to_activation"
      expr: AVG(DATEDIFF(actual_activation_date, cda_execution_date))
      comment: "Average days from CDA execution to actual activation - key startup efficiency metric"
    - name: "avg_days_regulatory_to_activation"
      expr: AVG(DATEDIFF(actual_activation_date, regulatory_pkg_approval_date))
      comment: "Average days from regulatory package approval to activation - measures regulatory-to-operational handoff speed"
    - name: "on_time_activation_count"
      expr: COUNT(CASE WHEN actual_activation_date <= target_activation_date THEN 1 END)
      comment: "Number of sites activated on or before target date - critical for study timeline adherence"
    - name: "delayed_activation_count"
      expr: COUNT(CASE WHEN actual_activation_date > target_activation_date THEN 1 END)
      comment: "Number of sites activated after target date - identifies bottlenecks in startup process"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`site_enrollment_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core enrollment KPIs measuring site-level recruitment effectiveness, screen failure rates, dropout rates, and target achievement - the primary operational dashboard for clinical operations leadership."
  source: "`clinical_trials_ecm`.`site`.`enrollment_performance`"
  dimensions:
    - name: "performance_status"
      expr: performance_status
      comment: "Overall performance classification of the site (e.g., On Track, At Risk, Behind)"
    - name: "gcp_compliance_status"
      expr: gcp_compliance_status
      comment: "GCP compliance status affecting site operational standing"
    - name: "irb_iec_approval_status"
      expr: irb_iec_approval_status
      comment: "Current IRB/IEC approval status impacting enrollment authorization"
    - name: "reporting_period_type"
      expr: reporting_period_type
      comment: "Reporting cadence (monthly, quarterly) for period-over-period analysis"
    - name: "data_source"
      expr: data_source
      comment: "Source system providing enrollment data for data lineage tracking"
    - name: "site_number"
      expr: site_number
      comment: "Site identifier for site-level drill-down"
    - name: "reporting_period_start"
      expr: DATE_TRUNC('month', reporting_period_start_date)
      comment: "Start of reporting period for time-series analysis"
  measures:
    - name: "total_performance_records"
      expr: COUNT(1)
      comment: "Total enrollment performance reporting records"
    - name: "avg_enrollment_rate_per_month"
      expr: AVG(CAST(enrollment_rate_per_month AS DOUBLE))
      comment: "Average monthly enrollment rate across sites - primary recruitment velocity metric"
    - name: "avg_screen_failure_rate"
      expr: AVG(CAST(screen_failure_rate AS DOUBLE))
      comment: "Average screen failure rate - indicates protocol complexity and patient population fit"
    - name: "avg_dropout_rate"
      expr: AVG(CAST(dropout_rate AS DOUBLE))
      comment: "Average dropout/discontinuation rate - key data integrity and retention metric"
    - name: "avg_enrollment_target_achievement_pct"
      expr: AVG(CAST(enrollment_target_achievement_pct AS DOUBLE))
      comment: "Average percentage of enrollment target achieved - primary site performance KPI"
    - name: "sites_meeting_target"
      expr: COUNT(CASE WHEN enrollment_target_achievement_pct >= 100.0 THEN 1 END)
      comment: "Number of sites meeting or exceeding enrollment targets"
    - name: "sites_at_risk"
      expr: COUNT(CASE WHEN enrollment_target_achievement_pct < 50.0 THEN 1 END)
      comment: "Number of sites significantly behind target requiring intervention"
    - name: "total_randomized"
      expr: SUM(CAST(randomized_count AS BIGINT))
      comment: "Total randomized subjects - the gold-standard enrollment metric for study completion forecasting"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`site_feasibility_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site feasibility scoring and selection pipeline metrics measuring assessment throughput, score distributions, and selection conversion rates for site identification strategy."
  source: "`clinical_trials_ecm`.`site`.`feasibility_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the feasibility assessment (e.g., Pending, Completed, Cancelled)"
    - name: "selection_decision"
      expr: selection_decision
      comment: "Final selection decision outcome (Selected, Rejected, Backup)"
    - name: "feasibility_score_tier"
      expr: feasibility_score_tier
      comment: "Tiered classification of feasibility score for portfolio analysis"
    - name: "site_country_code"
      expr: site_country_code
      comment: "Country of assessed site for geographic strategy"
    - name: "site_region"
      expr: site_region
      comment: "Region of assessed site for regional portfolio balance"
    - name: "phase"
      expr: phase
      comment: "Clinical trial phase for phase-specific feasibility benchmarking"
    - name: "irb_iec_status"
      expr: irb_iec_status
      comment: "IRB/IEC readiness status at time of assessment"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of assessment for trend analysis"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total feasibility assessments conducted - pipeline volume indicator"
    - name: "avg_feasibility_score"
      expr: AVG(CAST(feasibility_score AS DOUBLE))
      comment: "Average feasibility score across assessed sites - portfolio quality indicator"
    - name: "avg_enrollment_experience_score"
      expr: AVG(CAST(enrollment_experience_score AS DOUBLE))
      comment: "Average enrollment experience score - predictor of future recruitment success"
    - name: "avg_regulatory_compliance_score"
      expr: AVG(CAST(regulatory_compliance_score AS DOUBLE))
      comment: "Average regulatory compliance score - risk indicator for activation delays"
    - name: "avg_site_infrastructure_score"
      expr: AVG(CAST(site_infrastructure_score AS DOUBLE))
      comment: "Average site infrastructure score - operational readiness predictor"
    - name: "avg_estimated_screen_failure_rate"
      expr: AVG(CAST(estimated_screen_failure_rate AS DOUBLE))
      comment: "Average estimated screen failure rate from feasibility - used for enrollment planning"
    - name: "selected_site_count"
      expr: COUNT(CASE WHEN selection_decision = 'Selected' THEN 1 END)
      comment: "Number of sites selected from feasibility pipeline - conversion metric"
    - name: "avg_dedicated_research_staff"
      expr: AVG(CAST(dedicated_research_staff_count AS BIGINT))
      comment: "Average dedicated research staff count at assessed sites - capacity indicator"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`site_capacity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site operational capacity and resource utilization metrics for workforce planning, site load balancing, and enrollment forecasting."
  source: "`clinical_trials_ecm`.`site`.`capacity`"
  dimensions:
    - name: "capacity_status"
      expr: capacity_status
      comment: "Current capacity assessment status (Active, Under Review, Expired)"
    - name: "capacity_type"
      expr: capacity_type
      comment: "Type of capacity assessment for categorization"
    - name: "gcp_compliance_status"
      expr: gcp_compliance_status
      comment: "GCP compliance status affecting operational eligibility"
  measures:
    - name: "total_capacity_assessments"
      expr: COUNT(1)
      comment: "Total capacity assessment records"
    - name: "avg_utilization_pct"
      expr: AVG(CAST(utilization_pct AS DOUBLE))
      comment: "Average site utilization percentage - key load balancing metric for operations"
    - name: "avg_recruitment_rate_per_month"
      expr: AVG(CAST(recruitment_rate_per_month AS DOUBLE))
      comment: "Average monthly recruitment rate capacity - enrollment forecasting input"
    - name: "avg_screen_failure_rate_pct"
      expr: AVG(CAST(screen_failure_rate_pct AS DOUBLE))
      comment: "Average screen failure rate from capacity assessments - planning adjustment factor"
    - name: "avg_dropout_rate_pct"
      expr: AVG(CAST(dropout_rate_pct AS DOUBLE))
      comment: "Average dropout rate from capacity data - retention risk indicator"
    - name: "avg_site_selection_score"
      expr: AVG(CAST(site_selection_score AS DOUBLE))
      comment: "Average site selection score - quality benchmark for site network"
    - name: "avg_dedicated_research_fte"
      expr: AVG(CAST(dedicated_research_fte AS DOUBLE))
      comment: "Average dedicated research FTEs - workforce capacity indicator"
    - name: "avg_pi_fte_allocation"
      expr: AVG(CAST(pi_fte_allocation AS DOUBLE))
      comment: "Average PI FTE allocation - investigator bandwidth metric"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`site_closeout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site closeout process metrics tracking completion timelines, payment reconciliation, and regulatory compliance at study end - critical for TMF completeness and financial close."
  source: "`clinical_trials_ecm`.`site`.`closeout`"
  dimensions:
    - name: "closeout_status"
      expr: closeout_status
      comment: "Current closeout status (Initiated, In Progress, Completed)"
    - name: "closeout_type"
      expr: closeout_type
      comment: "Type of closeout (Planned, Early Termination)"
    - name: "drug_accountability_status"
      expr: drug_accountability_status
      comment: "Status of drug accountability reconciliation"
    - name: "final_payment_status"
      expr: final_payment_status
      comment: "Status of final site payment processing"
    - name: "essential_doc_archival_status"
      expr: essential_doc_archival_status
      comment: "Status of essential document archival for TMF completeness"
    - name: "gcp_compliance_status"
      expr: gcp_compliance_status
      comment: "GCP compliance status at closeout"
    - name: "closeout_year"
      expr: YEAR(completed_date)
      comment: "Year of closeout completion for trend analysis"
  measures:
    - name: "total_closeouts"
      expr: COUNT(1)
      comment: "Total site closeout records"
    - name: "total_final_payment_amount"
      expr: SUM(CAST(final_payment_amount AS DOUBLE))
      comment: "Total final payment amounts across closeouts - financial exposure metric"
    - name: "avg_final_payment_amount"
      expr: AVG(CAST(final_payment_amount AS DOUBLE))
      comment: "Average final payment per site closeout - budget benchmarking"
    - name: "avg_sdv_completion_pct"
      expr: AVG(CAST(sdv_completion_percentage AS DOUBLE))
      comment: "Average SDV completion percentage at closeout - data quality indicator"
    - name: "capa_required_count"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN 1 END)
      comment: "Number of closeouts requiring CAPA - quality signal for site network"
    - name: "pi_acknowledgement_received_count"
      expr: COUNT(CASE WHEN pi_acknowledgement_received = TRUE THEN 1 END)
      comment: "Number of closeouts with PI acknowledgement received - regulatory compliance metric"
    - name: "avg_days_initiated_to_completed"
      expr: AVG(DATEDIFF(completed_date, initiated_date))
      comment: "Average days from closeout initiation to completion - process efficiency metric"
    - name: "early_termination_count"
      expr: COUNT(CASE WHEN early_termination_reason IS NOT NULL THEN 1 END)
      comment: "Number of sites with early termination - risk and portfolio health indicator"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`site_study_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Study-site level operational metrics providing the primary view of site portfolio health, enrollment progress, risk tiering, and monitoring activity across the clinical program."
  source: "`clinical_trials_ecm`.`site`.`study_site`"
  dimensions:
    - name: "site_status"
      expr: site_status
      comment: "Current operational status of the study site (Active, Closed, Suspended)"
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk classification tier for risk-based monitoring strategy"
    - name: "gcp_compliance_status"
      expr: gcp_compliance_status
      comment: "GCP compliance status for regulatory oversight"
    - name: "site_number"
      expr: site_number
      comment: "Unique site number within the study for identification"
    - name: "protocol_number"
      expr: protocol_number
      comment: "Protocol number for study-level aggregation"
    - name: "enrollment_open_month"
      expr: DATE_TRUNC('month', enrollment_open_date)
      comment: "Month enrollment opened for cohort analysis"
  measures:
    - name: "total_study_sites"
      expr: COUNT(1)
      comment: "Total study-site relationships - portfolio size metric"
    - name: "total_budget_agreed"
      expr: SUM(CAST(budget_agreed_amount AS DOUBLE))
      comment: "Total agreed budget across study sites - financial commitment metric"
    - name: "avg_budget_per_site"
      expr: AVG(CAST(budget_agreed_amount AS DOUBLE))
      comment: "Average agreed budget per study site - cost benchmarking"
    - name: "distinct_active_sites"
      expr: COUNT(CASE WHEN site_status = 'Active' THEN 1 END)
      comment: "Number of currently active study sites - operational footprint"
    - name: "high_risk_site_count"
      expr: COUNT(CASE WHEN risk_tier = 'High' THEN 1 END)
      comment: "Number of high-risk sites requiring intensive monitoring"
    - name: "avg_days_selection_to_siv"
      expr: AVG(DATEDIFF(siv_date, selection_date))
      comment: "Average days from site selection to SIV - startup velocity metric"
    - name: "avg_days_siv_to_fpfv"
      expr: AVG(DATEDIFF(fpfv_date, siv_date))
      comment: "Average days from SIV to first patient first visit - enrollment readiness speed"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`site_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site agreement financial and negotiation metrics tracking contract values, negotiation timelines, and budget allocation across the site network for financial governance."
  source: "`clinical_trials_ecm`.`site`.`site_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current agreement status (Draft, Under Negotiation, Executed, Terminated)"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of agreement (CTA, Budget, Amendment)"
    - name: "payment_schedule_type"
      expr: payment_schedule_type
      comment: "Payment schedule structure (Per-Patient, Milestone, Hybrid)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the agreement for multi-currency reporting"
    - name: "governing_law_country"
      expr: governing_law_country
      comment: "Governing law jurisdiction for legal risk analysis"
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total site agreements in portfolio"
    - name: "total_budget_amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total contracted budget across all site agreements - financial commitment"
    - name: "avg_per_patient_fee"
      expr: AVG(CAST(per_patient_fee AS DOUBLE))
      comment: "Average per-patient fee across agreements - cost efficiency benchmark"
    - name: "avg_startup_fee"
      expr: AVG(CAST(startup_fee AS DOUBLE))
      comment: "Average startup fee - fixed cost component of site economics"
    - name: "avg_overhead_rate_pct"
      expr: AVG(CAST(overhead_rate_pct AS DOUBLE))
      comment: "Average overhead rate percentage - indirect cost indicator"
    - name: "avg_negotiation_days"
      expr: AVG(DATEDIFF(execution_date, negotiation_start_date))
      comment: "Average days from negotiation start to execution - contracting efficiency metric"
    - name: "total_closeout_fees"
      expr: SUM(CAST(closeout_fee AS DOUBLE))
      comment: "Total closeout fees across agreements - end-of-study financial liability"
    - name: "legal_review_completed_count"
      expr: COUNT(CASE WHEN legal_review_completed = TRUE THEN 1 END)
      comment: "Number of agreements with completed legal review - compliance readiness"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`site_selection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site selection pipeline metrics measuring conversion rates, selection timelines, and geographic distribution for strategic site network planning."
  source: "`clinical_trials_ecm`.`site`.`selection`"
  dimensions:
    - name: "selection_status"
      expr: selection_status
      comment: "Current selection status (Proposed, Selected, Rejected, Backup)"
    - name: "selection_type"
      expr: selection_type
      comment: "Type of selection process (Standard, Expedited, Replacement)"
    - name: "country_code"
      expr: country_code
      comment: "Country for geographic distribution analysis"
    - name: "region"
      expr: region
      comment: "Geographic region for regional portfolio balance"
    - name: "irb_iec_status"
      expr: irb_iec_status
      comment: "IRB/IEC status at time of selection decision"
    - name: "selection_year"
      expr: YEAR(selection_date)
      comment: "Year of selection for trend analysis"
  measures:
    - name: "total_selections"
      expr: COUNT(1)
      comment: "Total site selection decisions - pipeline volume"
    - name: "avg_feasibility_score"
      expr: AVG(CAST(feasibility_score AS DOUBLE))
      comment: "Average feasibility score of selected sites - quality of pipeline"
    - name: "avg_enrollment_rate_per_month"
      expr: AVG(CAST(enrollment_rate_per_month AS DOUBLE))
      comment: "Average projected enrollment rate - capacity planning input"
    - name: "selected_count"
      expr: COUNT(CASE WHEN selection_status = 'Selected' THEN 1 END)
      comment: "Number of sites selected - conversion from pipeline"
    - name: "rejected_count"
      expr: COUNT(CASE WHEN selection_status = 'Rejected' THEN 1 END)
      comment: "Number of sites rejected - attrition indicator"
    - name: "gcp_confirmed_count"
      expr: COUNT(CASE WHEN gcp_compliance_confirmed = TRUE THEN 1 END)
      comment: "Number of selections with GCP compliance confirmed - regulatory readiness"
    - name: "avg_days_selection_to_activation_target"
      expr: AVG(DATEDIFF(activation_target_date, selection_date))
      comment: "Average planned days from selection to activation target - startup planning metric"
    - name: "prior_audit_finding_count"
      expr: COUNT(CASE WHEN prior_audit_finding = TRUE THEN 1 END)
      comment: "Number of selected sites with prior audit findings - risk acceptance indicator"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`site_cra_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CRA (Clinical Research Associate) assignment and workload metrics for monitoring resource optimization, coverage analysis, and field force management."
  source: "`clinical_trials_ecm`.`site`.`site_cra_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current assignment status (Active, Completed, Transferred)"
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of CRA assignment (Primary, Backup, Interim)"
    - name: "monitoring_approach"
      expr: monitoring_approach
      comment: "Monitoring approach (On-site, Remote, Hybrid) for resource planning"
    - name: "risk_tier"
      expr: risk_tier
      comment: "Site risk tier driving monitoring intensity"
    - name: "geographic_territory"
      expr: geographic_territory
      comment: "Geographic territory for field force distribution analysis"
    - name: "territory_country_code"
      expr: territory_country_code
      comment: "Country code for territory-level reporting"
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total CRA-site assignments - monitoring coverage metric"
    - name: "avg_workload_allocation_pct"
      expr: AVG(CAST(workload_allocation_pct AS DOUBLE))
      comment: "Average workload allocation percentage - CRA capacity utilization"
    - name: "avg_sdv_rate_pct"
      expr: AVG(CAST(sdv_rate_pct AS DOUBLE))
      comment: "Average SDV rate percentage - source data verification intensity"
    - name: "avg_estimated_travel_days"
      expr: AVG(CAST(estimated_travel_days_per_visit AS DOUBLE))
      comment: "Average estimated travel days per visit - cost and efficiency factor"
    - name: "gcp_training_current_count"
      expr: COUNT(CASE WHEN gcp_training_current = TRUE THEN 1 END)
      comment: "Number of assignments with current GCP training - compliance metric"
    - name: "protocol_training_completed_count"
      expr: COUNT(CASE WHEN protocol_training_completed = TRUE THEN 1 END)
      comment: "Number of assignments with protocol training completed - readiness metric"
    - name: "handover_completed_count"
      expr: COUNT(CASE WHEN handover_visit_completed = TRUE THEN 1 END)
      comment: "Number of completed handovers - transition management metric"
$$;