-- Metric views for domain: quality | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 14:47:42

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_measure_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality measure performance results across programs (MIPS, VBP, HEDIS) — the core KPI layer for tracking performance rate vs. target, benchmark comparison, and gap-to-target. Steers value-based care contract performance."
  source: "`vibe_healthcare_v1`.`quality`.`measure_result`"
  dimensions:
    - name: "performance_year"
      expr: performance_year
      comment: "Performance/measurement year for trending quality results over time."
    - name: "reporting_program"
      expr: reporting_program
      comment: "Reporting program (MIPS, HEDIS, VBP, etc.) for program-level performance steering."
    - name: "measure_domain"
      expr: measure_domain
      comment: "Clinical/quality domain of the measure for portfolio segmentation."
    - name: "vbp_domain"
      expr: vbp_domain
      comment: "Value-based purchasing domain for CMS VBP scoring analysis."
    - name: "reporting_quarter"
      expr: reporting_quarter
      comment: "Reporting quarter for intra-year cadence analysis."
  measures:
    - name: "Result Count"
      expr: COUNT(1)
      comment: "Number of measure result records — denominator base for coverage tracking."
    - name: "Avg Performance Rate"
      expr: AVG(CAST(performance_rate AS DOUBLE))
      comment: "Average measure performance rate — the headline KPI for quality program steering."
    - name: "Avg Gap To Target Rate"
      expr: AVG(CAST(gap_to_target_rate AS DOUBLE))
      comment: "Average gap to target — directly drives intervention prioritization to close performance shortfalls."
    - name: "Avg Target Rate"
      expr: AVG(CAST(target_rate AS DOUBLE))
      comment: "Average target rate used as benchmark for goal-setting."
    - name: "Avg National Benchmark Rate"
      expr: AVG(CAST(national_benchmark_rate AS DOUBLE))
      comment: "Average national benchmark for competitive positioning analysis."
    - name: "Avg Percentile Rank"
      expr: AVG(CAST(percentile_rank AS DOUBLE))
      comment: "Average percentile rank vs. peers — informs reimbursement/incentive standing."
    - name: "Avg MIPS Points Earned"
      expr: AVG(CAST(mips_points_earned AS DOUBLE))
      comment: "Average MIPS points earned — ties directly to Medicare payment adjustment."
    - name: "Avg VBP Achievement Score"
      expr: AVG(CAST(vbp_achievement_score AS DOUBLE))
      comment: "Average VBP achievement score — drives value-based payment outcomes."
    - name: "Avg Data Completeness Rate"
      expr: AVG(CAST(data_completeness_rate AS DOUBLE))
      comment: "Average data completeness — quality of submitted measure data."
    - name: "Publicly Reported Result Count"
      expr: COUNT(CASE WHEN is_publicly_reported = true THEN 1 END)
      comment: "Count of publicly reported results — reputational risk exposure."
    - name: "Meets Threshold Count"
      expr: COUNT(CASE WHEN meets_reporting_threshold = true THEN 1 END)
      comment: "Count of results meeting reporting threshold — submission readiness."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_care_gap_closure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care gap identification and closure tracking — central to population health and value-based contract gap closure performance. Drives outreach prioritization and risk-adjusted gap management."
  source: "`vibe_healthcare_v1`.`quality`.`care_gap_closure`"
  dimensions:
    - name: "closure_status"
      expr: closure_status
      comment: "Gap closure status (open/closed/excluded) for closure-rate funnel analysis."
    - name: "gap_type"
      expr: gap_type
      comment: "Type of care gap for portfolio segmentation."
    - name: "clinical_condition"
      expr: clinical_condition
      comment: "Clinical condition associated with the gap for condition-level steering."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority of the gap for outreach resource allocation."
    - name: "measure_year"
      expr: measure_year
      comment: "Measurement year for trending gap closure performance."
    - name: "outreach_channel"
      expr: outreach_channel
      comment: "Outreach channel used for closure-channel effectiveness analysis."
    - name: "closure_method"
      expr: closure_method
      comment: "Method by which the gap was closed for workflow effectiveness."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of closure evidence for data integrity."
  measures:
    - name: "Care Gap Count"
      expr: COUNT(1)
      comment: "Total care gaps — denominator for closure-rate KPIs."
    - name: "Closed Gap Count"
      expr: COUNT(CASE WHEN closure_status = 'Closed' THEN 1 END)
      comment: "Count of closed gaps — numerator for closure rate, a core population health KPI."
    - name: "Compliant Gap Count"
      expr: COUNT(CASE WHEN compliance_flag = true THEN 1 END)
      comment: "Count of compliant gaps — measure-level compliance for VBP contracts."
    - name: "Excluded Gap Count"
      expr: COUNT(CASE WHEN exclusion_reason IS NOT NULL THEN 1 END)
      comment: "Count of excluded gaps — adjusts the eligible denominator."
    - name: "Avg Risk Score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average member risk score — prioritizes high-risk gap closure."
    - name: "Avg Outreach Attempts"
      expr: AVG(CAST(outreach_attempt_count AS DOUBLE))
      comment: "Average outreach attempts per gap — outreach efficiency indicator."
    - name: "Supplemental Data Gap Count"
      expr: COUNT(CASE WHEN supplemental_data_flag = true THEN 1 END)
      comment: "Gaps closed via supplemental data — informs data-strategy ROI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_patient_safety_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient safety event reporting — the harm/sentinel-event surveillance layer for the Chief Quality and Patient Safety Officer. Drives RCA prioritization and regulatory reporting compliance."
  source: "`vibe_healthcare_v1`.`quality`.`patient_safety_event`"
  dimensions:
    - name: "event_category"
      expr: event_category
      comment: "Event category for harm-class segmentation."
    - name: "harm_level"
      expr: harm_level_description
      comment: "Harm level for severity-weighted safety steering."
    - name: "action_plan_status"
      expr: action_plan_status
      comment: "Corrective action plan status for closure tracking."
    - name: "hai_event_type"
      expr: hai_event_type
      comment: "Healthcare-associated infection type for HAI surveillance."
    - name: "patient_outcome"
      expr: patient_outcome
      comment: "Patient outcome for outcome-based safety analysis."
  measures:
    - name: "Safety Event Count"
      expr: COUNT(1)
      comment: "Total reported safety events — the baseline safety surveillance volume."
    - name: "Sentinel Event Count"
      expr: COUNT(CASE WHEN is_sentinel_event = true THEN 1 END)
      comment: "Count of sentinel events — highest-severity events requiring board-level attention."
    - name: "CMS Reportable Event Count"
      expr: COUNT(CASE WHEN is_cms_reportable = true THEN 1 END)
      comment: "CMS-reportable events — regulatory reporting compliance exposure."
    - name: "State Reportable Event Count"
      expr: COUNT(CASE WHEN is_state_reportable = true THEN 1 END)
      comment: "State-reportable events — state regulatory compliance exposure."
    - name: "Effectiveness Verified Count"
      expr: COUNT(CASE WHEN effectiveness_verified = true THEN 1 END)
      comment: "Events with verified corrective-action effectiveness — closure-quality KPI."
    - name: "Distinct Patients With Events"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients experiencing a safety event — patient-level harm exposure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_cahps_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HCAHPS/CAHPS patient experience survey scores — drives patient experience strategy and VBP patient-experience domain reimbursement. Executive-level patient satisfaction steering."
  source: "`vibe_healthcare_v1`.`quality`.`cahps_survey`"
  dimensions:
    - name: "star_rating"
      expr: star_rating
      comment: "Overall star rating for public-reporting reputation tracking."
    - name: "cms_submission_status"
      expr: cms_submission_status
      comment: "CMS submission status for reporting compliance."
    - name: "publicly_reported"
      expr: publicly_reported
      comment: "Whether the survey result is publicly reported."
  measures:
    - name: "Survey Count"
      expr: COUNT(1)
      comment: "Number of survey records — fielding volume base."
    - name: "Avg HCAHPS Linear Mean Score"
      expr: AVG(CAST(hcahps_linear_mean_score AS DOUBLE))
      comment: "Average HCAHPS linear mean — headline patient experience KPI."
    - name: "Avg VBP Patient Experience Score"
      expr: AVG(CAST(vbp_patient_experience_score AS DOUBLE))
      comment: "Average VBP patient-experience score — ties directly to value-based payment."
    - name: "Avg Nurse Communication Score"
      expr: AVG(CAST(score_communication_nurses AS DOUBLE))
      comment: "Average nurse communication score — key actionable experience driver."
    - name: "Avg Doctor Communication Score"
      expr: AVG(CAST(score_communication_doctors AS DOUBLE))
      comment: "Average doctor communication score — key actionable experience driver."
    - name: "Avg Responsiveness Score"
      expr: AVG(CAST(score_responsiveness_staff AS DOUBLE))
      comment: "Average staff responsiveness score — operational experience lever."
    - name: "Avg Discharge Information Score"
      expr: AVG(CAST(score_discharge_information AS DOUBLE))
      comment: "Average discharge information score — care transition experience."
    - name: "Response Received Count"
      expr: COUNT(CASE WHEN response_received = true THEN 1 END)
      comment: "Surveys with a response — informs response-rate calculation."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_hedis_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HEDIS measure results by health plan and product line — drives NCQA accreditation and Star ratings strategy. Executive layer for managed-care quality performance."
  source: "`vibe_healthcare_v1`.`quality`.`hedis_result`"
  dimensions:
    - name: "measurement_year"
      expr: measurement_year
      comment: "HEDIS measurement year for trending."
    - name: "product_line"
      expr: product_line
      comment: "Product line (Commercial/Medicare/Medicaid) for line-of-business analysis."
    - name: "submission_status"
      expr: submission_status
      comment: "Submission status for NCQA reporting compliance."
    - name: "methodology_type"
      expr: methodology_type
      comment: "Calculation methodology (admin/hybrid) for data-strategy analysis."
    - name: "stratification_category"
      expr: stratification_category
      comment: "Stratification category for health-equity reporting."
  measures:
    - name: "HEDIS Result Count"
      expr: COUNT(1)
      comment: "Number of HEDIS result records — coverage base."
    - name: "Avg Performance Rate"
      expr: AVG(CAST(performance_rate AS DOUBLE))
      comment: "Average HEDIS performance rate — headline managed-care quality KPI."
    - name: "Avg Prior Year Performance Rate"
      expr: AVG(CAST(prior_year_performance_rate AS DOUBLE))
      comment: "Average prior-year rate for year-over-year trend baseline."
    - name: "Avg Rate Change From Prior Year"
      expr: AVG(CAST(rate_change_from_prior_year AS DOUBLE))
      comment: "Average rate change vs. prior year — improvement trajectory."
    - name: "Avg NCQA 90th Percentile"
      expr: AVG(CAST(ncqa_benchmark_percentile_90 AS DOUBLE))
      comment: "Average NCQA 90th-percentile benchmark for competitive target-setting."
    - name: "Avg Star Rating Weight"
      expr: AVG(CAST(star_rating_weight AS DOUBLE))
      comment: "Average Star rating weight — informs weighted Star strategy."
    - name: "Starred Measure Count"
      expr: COUNT(CASE WHEN is_starred_measure = true THEN 1 END)
      comment: "Count of Star-rated measures — Star program focus."
    - name: "Reportable Result Count"
      expr: COUNT(CASE WHEN is_reportable = true THEN 1 END)
      comment: "Count of reportable results — submission readiness."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_mortality_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mortality case review — preventable-mortality surveillance and CMS mortality-measure tracking for the quality committee. Drives RCA and preventability intervention."
  source: "`vibe_healthcare_v1`.`quality`.`mortality_review`"
  dimensions:
    - name: "death_classification"
      expr: death_classification
      comment: "Classification of death for mortality taxonomy."
    - name: "preventability_determination"
      expr: preventability_determination
      comment: "Preventability determination — the key quality finding driving improvement."
    - name: "review_trigger_type"
      expr: review_trigger_type
      comment: "Trigger for the mortality review for case-selection analysis."
    - name: "care_quality_rating"
      expr: care_quality_rating
      comment: "Care quality rating assigned during review."
  measures:
    - name: "Mortality Review Count"
      expr: COUNT(1)
      comment: "Number of mortality reviews — review program volume."
    - name: "Sentinel Event Mortality Count"
      expr: COUNT(CASE WHEN sentinel_event_flag = true THEN 1 END)
      comment: "Mortalities flagged as sentinel events — highest-severity escalation."
    - name: "CMS Mortality Measure Count"
      expr: COUNT(CASE WHEN cms_mortality_measure_flag = true THEN 1 END)
      comment: "Cases tied to CMS mortality measures — public-reporting exposure."
    - name: "RCA Required Count"
      expr: COUNT(CASE WHEN root_cause_analysis_required_flag = true THEN 1 END)
      comment: "Cases requiring RCA — quality investigation workload."
    - name: "HAI Related Mortality Count"
      expr: COUNT(CASE WHEN hai_related_flag = true THEN 1 END)
      comment: "HAI-related mortalities — infection-prevention focus."
    - name: "Avg Days Admission To Death"
      expr: AVG(CAST(days_from_admission_to_death AS DOUBLE))
      comment: "Average days from admission to death — acuity/length pattern insight."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action tracking across surveys, safety events and findings — drives accountability for closure timeliness and effectiveness verification. Operational quality steering layer."
  source: "`vibe_healthcare_v1`.`quality`.`corrective_action`"
  dimensions:
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for resource allocation."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for systemic-issue trending."
    - name: "service_line"
      expr: service_line
      comment: "Service line for departmental accountability."
    - name: "regulatory_program"
      expr: regulatory_program
      comment: "Associated regulatory program for compliance segmentation."
  measures:
    - name: "Corrective Action Count"
      expr: COUNT(1)
      comment: "Total corrective actions — workload base."
    - name: "Overdue Action Count"
      expr: COUNT(CASE WHEN is_overdue = true THEN 1 END)
      comment: "Overdue corrective actions — accountability and risk KPI."
    - name: "Effectiveness Verified Count"
      expr: COUNT(CASE WHEN effectiveness_verified = true THEN 1 END)
      comment: "Actions with verified effectiveness — closure-quality KPI."
    - name: "CMS Reportable Count"
      expr: COUNT(CASE WHEN is_cms_reportable = true THEN 1 END)
      comment: "CMS-reportable actions — regulatory exposure."
    - name: "Avg Days To Complete"
      expr: AVG(CAST(days_to_complete AS DOUBLE))
      comment: "Average days to complete — closure timeliness KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_standard_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accreditation/regulatory survey findings (TJC, CMS CoP) — drives survey readiness and deficiency remediation. Compliance-risk steering for accreditation maintenance."
  source: "`vibe_healthcare_v1`.`quality`.`standard_finding`"
  dimensions:
    - name: "finding_status"
      expr: finding_status
      comment: "Finding status for remediation tracking."
    - name: "severity_code"
      expr: severity_code
      comment: "Severity code for risk-weighted finding analysis."
    - name: "standard_chapter"
      expr: standard_chapter
      comment: "Standard chapter for accreditation-domain analysis."
    - name: "surveying_body"
      expr: surveying_body
      comment: "Surveying body (TJC/CMS/state) for body-level analysis."
    - name: "affected_department"
      expr: affected_department
      comment: "Affected department for departmental accountability."
  measures:
    - name: "Finding Count"
      expr: COUNT(1)
      comment: "Total survey findings — deficiency volume base."
    - name: "Immediate Jeopardy Count"
      expr: COUNT(CASE WHEN immediate_jeopardy = true THEN 1 END)
      comment: "Immediate-jeopardy findings — highest-severity regulatory risk."
    - name: "Repeat Finding Count"
      expr: COUNT(CASE WHEN repeat_finding = true THEN 1 END)
      comment: "Repeat findings — systemic-failure indicator."
    - name: "Revisit Required Count"
      expr: COUNT(CASE WHEN revisit_required = true THEN 1 END)
      comment: "Findings requiring revisit — follow-up survey exposure."
    - name: "Effectiveness Verified Count"
      expr: COUNT(CASE WHEN effectiveness_verified = true THEN 1 END)
      comment: "Findings with verified remediation effectiveness — closure quality."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_raf_score`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk Adjustment Factor (RAF) scoring — drives Medicare Advantage/ACO risk-adjustment revenue and coding-gap closure. CFO/population-health revenue steering layer."
  source: "`vibe_healthcare_v1`.`quality`.`raf_score`"
  dimensions:
    - name: "payment_year"
      expr: payment_year
      comment: "Payment year for RAF revenue trending."
    - name: "program_type"
      expr: program_type
      comment: "Program type (MA/ACO/Commercial) for line-of-business RAF analysis."
    - name: "score_type"
      expr: score_type
      comment: "Score type for prospective vs. retrospective analysis."
    - name: "model_version"
      expr: model_version
      comment: "CMS-HCC model version for model-impact analysis."
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Member enrollment status for eligible-population segmentation."
  measures:
    - name: "RAF Record Count"
      expr: COUNT(1)
      comment: "Number of RAF score records — population base."
    - name: "Avg RAF Value"
      expr: AVG(CAST(raf_value AS DOUBLE))
      comment: "Average RAF value — drives risk-adjusted reimbursement, a core revenue KPI."
    - name: "Avg RAF Gap Value"
      expr: AVG(CAST(raf_gap_value AS DOUBLE))
      comment: "Average RAF gap — unrealized risk-adjustment revenue opportunity."
    - name: "Avg Suspected RAF Value"
      expr: AVG(CAST(suspected_raf_value AS DOUBLE))
      comment: "Average suspected RAF — prospective coding-gap opportunity."
    - name: "Avg Normalized RAF Value"
      expr: AVG(CAST(normalized_raf_value AS DOUBLE))
      comment: "Average normalized RAF — payment-comparable RAF metric."
    - name: "Distinct Members Scored"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct members with a RAF score — population coverage."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_improvement_initiative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality improvement initiatives (PDSA/Lean/Six Sigma) — drives portfolio prioritization and tracks baseline-to-goal performance. Steering layer for QI program ROI."
  source: "`vibe_healthcare_v1`.`quality`.`improvement_initiative`"
  dimensions:
    - name: "initiative_status"
      expr: initiative_status
      comment: "Initiative lifecycle status for portfolio progress tracking."
    - name: "initiative_type"
      expr: initiative_type
      comment: "Type of initiative for portfolio segmentation."
    - name: "improvement_methodology"
      expr: improvement_methodology
      comment: "QI methodology for method-effectiveness analysis."
    - name: "current_phase"
      expr: current_phase
      comment: "Current phase for pipeline-stage analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority for resource allocation."
    - name: "service_line"
      expr: service_line
      comment: "Service line for departmental QI accountability."
  measures:
    - name: "Initiative Count"
      expr: COUNT(1)
      comment: "Number of improvement initiatives — QI portfolio size."
    - name: "Avg Baseline Value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average baseline value — starting point for improvement measurement."
    - name: "Avg Current Performance Value"
      expr: AVG(CAST(current_performance_value AS DOUBLE))
      comment: "Average current performance — progress against baseline."
    - name: "Avg Goal Value"
      expr: AVG(CAST(goal_value AS DOUBLE))
      comment: "Average goal value — target the portfolio is steering toward."
    - name: "Sentinel Related Initiative Count"
      expr: COUNT(CASE WHEN is_sentinel_event_related = true THEN 1 END)
      comment: "Sentinel-event-driven initiatives — highest-priority QI work."
    - name: "Avg PDSA Cycle Count"
      expr: AVG(CAST(pdsa_cycle_count AS DOUBLE))
      comment: "Average PDSA cycles — improvement iteration intensity."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_sdoh_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Social Determinants of Health screening — drives health-equity strategy, positive-screen follow-through, and referral closure. Population-health and equity steering layer."
  source: "`vibe_healthcare_v1`.`quality`.`sdoh_screening`"
  dimensions:
    - name: "sdoh_domain"
      expr: sdoh_domain
      comment: "SDOH domain (housing/food/transport) for domain-level need analysis."
    - name: "screening_status"
      expr: screening_status
      comment: "Screening status for completion tracking."
    - name: "screening_setting"
      expr: screening_setting
      comment: "Setting where screening occurred for workflow analysis."
    - name: "health_equity_stratifier"
      expr: health_equity_stratifier
      comment: "Health-equity stratifier for disparity analysis."
    - name: "program_year"
      expr: program_year
      comment: "Program year for trending."
    - name: "referral_type"
      expr: referral_type
      comment: "Type of referral generated for referral-mix analysis."
  measures:
    - name: "Screening Count"
      expr: COUNT(1)
      comment: "Total SDOH screenings — denominator for positive-screen and referral rates."
    - name: "Positive Screen Count"
      expr: COUNT(CASE WHEN is_positive_screen = true THEN 1 END)
      comment: "Positive screens — identifies unmet social need volume."
    - name: "Referral Generated Count"
      expr: COUNT(CASE WHEN is_referral_generated = true THEN 1 END)
      comment: "Screenings generating a referral — closed-loop follow-through KPI."
    - name: "Need Resolved Count"
      expr: COUNT(CASE WHEN need_resolved = true THEN 1 END)
      comment: "Resolved needs — ultimate equity-outcome KPI."
    - name: "Resource Connected Count"
      expr: COUNT(CASE WHEN community_resource_connected = true THEN 1 END)
      comment: "Screenings connected to a community resource — closed-loop success."
    - name: "Numerator Compliant Count"
      expr: COUNT(CASE WHEN is_numerator_compliant = true THEN 1 END)
      comment: "Numerator-compliant screenings — SDOH measure performance."
    - name: "Distinct Patients Screened"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients screened — screening reach."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_population_health_gap`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Population health care gaps across payers and measures — drives panel-level gap closure and value-based contract performance. Population-health management steering layer."
  source: "`vibe_healthcare_v1`.`quality`.`population_health_gap`"
  dimensions:
    - name: "gap_status"
      expr: gap_status
      comment: "Gap status for closure-funnel analysis."
    - name: "gap_type"
      expr: gap_type
      comment: "Type of gap for portfolio segmentation."
    - name: "gap_category"
      expr: gap_category
      comment: "Gap category for grouping clinical gap families."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority of the gap for outreach allocation."
    - name: "reporting_program"
      expr: reporting_program
      comment: "Reporting program for contract-level gap analysis."
    - name: "measurement_year"
      expr: measurement_year
      comment: "Measurement year for trending."
  measures:
    - name: "Population Gap Count"
      expr: COUNT(1)
      comment: "Total population health gaps — denominator base for closure rates."
    - name: "Numerator Compliant Count"
      expr: COUNT(CASE WHEN is_numerator_compliant = true THEN 1 END)
      comment: "Numerator-compliant gaps — measure performance numerator."
    - name: "Denominator Eligible Count"
      expr: COUNT(CASE WHEN is_denominator_eligible = true THEN 1 END)
      comment: "Denominator-eligible members — eligible measure population."
    - name: "Avg Risk Score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score — prioritizes high-risk gap closure."
    - name: "Avg Outreach Attempts"
      expr: AVG(CAST(outreach_attempt_count AS DOUBLE))
      comment: "Average outreach attempts — outreach efficiency."
    - name: "Distinct Members With Gaps"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct members with open gaps — panel-level exposure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_cdi_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical Documentation Integrity reviews — drives DRG/CMI capture and query effectiveness. CDI program steering for documentation-driven revenue and severity capture."
  source: "`vibe_healthcare_v1`.`quality`.`cdi_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Review status for CDI workflow tracking."
    - name: "review_type"
      expr: review_type
      comment: "Type of CDI review for review-mix analysis."
    - name: "query_outcome"
      expr: query_outcome
      comment: "Outcome of a CDI query for query-effectiveness analysis."
    - name: "cc_mcc_status"
      expr: cc_mcc_status
      comment: "CC/MCC status for severity-capture analysis."
    - name: "reviewer_role"
      expr: reviewer_role
      comment: "Reviewer role for staffing-mix analysis."
  measures:
    - name: "CDI Review Count"
      expr: COUNT(1)
      comment: "Total CDI reviews — program workload base."
    - name: "Query Initiated Count"
      expr: COUNT(CASE WHEN query_initiated_flag = true THEN 1 END)
      comment: "Reviews initiating a query — CDI query rate driver."
    - name: "DRG Change Count"
      expr: COUNT(CASE WHEN drg_change_flag = true THEN 1 END)
      comment: "Reviews resulting in a DRG change — documentation revenue impact."
    - name: "CC MCC Opportunity Count"
      expr: COUNT(CASE WHEN cc_mcc_opportunity_flag = true THEN 1 END)
      comment: "Reviews with CC/MCC opportunity — severity-capture opportunity."
    - name: "Avg CMI Impact"
      expr: AVG(CAST(cmi_impact AS DOUBLE))
      comment: "Average case-mix-index impact — documentation revenue lever."
    - name: "Avg Review Lag Days"
      expr: AVG(CAST(review_lag_days AS DOUBLE))
      comment: "Average review lag — CDI timeliness KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_contract_initiative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payer-contract-linked quality initiatives — tracks incentive earnings vs. penalties against performance targets. CFO/managed-care steering for value-based contract economics."
  source: "`vibe_healthcare_v1`.`quality`.`contract_initiative`"
  dimensions:
    - name: "contract_initiative_status"
      expr: contract_initiative_status
      comment: "Status of the contract initiative for portfolio tracking."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Reporting frequency for cadence management."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the measure is contractually mandatory."
    - name: "contract_measure_code"
      expr: contract_measure_code
      comment: "Contract measure code for measure-level economics."
  measures:
    - name: "Contract Initiative Count"
      expr: COUNT(1)
      comment: "Number of contract-linked initiatives — VBC portfolio size."
    - name: "Total Incentive Earned"
      expr: SUM(CAST(incentive_earned_to_date AS DOUBLE))
      comment: "Total incentive earned to date — realized value-based revenue."
    - name: "Total Penalty Incurred"
      expr: SUM(CAST(penalty_incurred_to_date AS DOUBLE))
      comment: "Total penalties incurred — at-risk revenue downside."
    - name: "Total Incentive Amount At Stake"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive amount at stake — maximum upside."
    - name: "Avg Performance Target"
      expr: AVG(CAST(performance_target AS DOUBLE))
      comment: "Average performance target — contractual goal benchmark."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_accreditation_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accreditation surveys (TJC/CMS) — drives survey readiness scoring and deficiency exposure. Executive accreditation-risk steering layer."
  source: "`vibe_healthcare_v1`.`quality`.`accreditation_survey`"
  dimensions:
    - name: "survey_status"
      expr: survey_status
      comment: "Survey status for survey lifecycle tracking."
    - name: "survey_type"
      expr: survey_type
      comment: "Type of survey for survey-mix analysis."
    - name: "accrediting_body"
      expr: accrediting_body
      comment: "Accrediting body for body-level analysis."
    - name: "accreditation_decision"
      expr: accreditation_decision
      comment: "Accreditation decision — the outcome KPI driver."
    - name: "corrective_action_plan_status"
      expr: corrective_action_plan_status
      comment: "CAP status for remediation tracking."
  measures:
    - name: "Survey Count"
      expr: COUNT(1)
      comment: "Number of accreditation surveys — survey volume base."
    - name: "Avg Overall Readiness Score"
      expr: AVG(CAST(overall_readiness_score AS DOUBLE))
      comment: "Average readiness score — survey-preparedness KPI."
    - name: "Condition Level Deficiency Count"
      expr: COUNT(CASE WHEN condition_level_deficiency = true THEN 1 END)
      comment: "Surveys with condition-level deficiencies — highest accreditation risk."
    - name: "Follow Up Required Count"
      expr: COUNT(CASE WHEN follow_up_survey_required = true THEN 1 END)
      comment: "Surveys requiring follow-up — remediation exposure."
    - name: "Avg Survey Duration Days"
      expr: AVG(CAST(survey_duration_days AS DOUBLE))
      comment: "Average survey duration — survey-intensity indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_accreditation_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accreditation program performance metrics"
  source: "`vibe_healthcare_v1`.`quality`.`accreditation_program`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Identifier of the care site"
    - name: "program_name"
      expr: program_name
      comment: "Name of the accreditation program"
    - name: "program_type"
      expr: program_type
      comment: "Type of accreditation program"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the accreditation program became effective"
  measures:
    - name: "total_accreditations"
      expr: COUNT(1)
      comment: "Total number of accreditation program records"
    - name: "active_accreditations"
      expr: SUM(CASE WHEN expiration_date >= CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of currently active accreditations (expiration date in the future)"
    - name: "avg_readiness_score"
      expr: AVG(CAST(readiness_score AS DOUBLE))
      comment: "Average readiness score across accreditation programs"
    - name: "deemed_accreditations"
      expr: SUM(CASE WHEN deemed_status THEN 1 ELSE 0 END)
      comment: "Count of accreditations where deemed_status is true"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`quality_hedis_measure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HEDIS measure performance metrics"
  source: "`vibe_healthcare_v1`.`quality`.`hedis_measure`"
  dimensions:
    - name: "measure_year"
      expr: measurement_year
      comment: "Year of the measurement period"
    - name: "clinical_area"
      expr: clinical_area
      comment: "Clinical area of the measure"
    - name: "measure_type"
      expr: measure_type
      comment: "Type/category of the measure"
  measures:
    - name: "total_measures"
      expr: COUNT(1)
      comment: "Total number of HEDIS measures defined"
    - name: "avg_target_performance_rate"
      expr: AVG(CAST(target_performance_rate AS DOUBLE))
      comment: "Average target performance rate across measures"
    - name: "avg_national_average_rate"
      expr: AVG(CAST(national_average_rate AS DOUBLE))
      comment: "Average national benchmark rate"
    - name: "avg_minimum_performance_threshold"
      expr: AVG(CAST(minimum_performance_threshold AS DOUBLE))
      comment: "Average minimum performance threshold"
$$;