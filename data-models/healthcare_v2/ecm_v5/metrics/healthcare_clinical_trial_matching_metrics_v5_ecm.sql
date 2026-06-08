-- Metric views for domain: clinical_trial_matching | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`clinical_trial_matching_trial_match`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core clinical trial matching metrics tracking patient-to-trial match effectiveness, conversion rates, and operational throughput for clinical research programs."
  source: "`healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match`"
  dimensions:
    - name: "match_status"
      expr: match_status
      comment: "Current status of the trial match (e.g., identified, screened, enrolled, declined)"
    - name: "match_type"
      expr: match_type
      comment: "Type of match algorithm or pathway used (e.g., automated, manual, hybrid)"
    - name: "confidence_level"
      expr: confidence_level
      comment: "Confidence tier of the match (high, medium, low)"
    - name: "match_month"
      expr: DATE_TRUNC('MONTH', match_date)
      comment: "Month when the match was identified for trend analysis"
    - name: "match_quarter"
      expr: DATE_TRUNC('QUARTER', match_date)
      comment: "Quarter when the match was identified for executive reporting"
    - name: "is_active"
      expr: CAST(is_active AS STRING)
      comment: "Whether the match is currently active"
    - name: "is_inclusion_criteria_met"
      expr: CAST(is_inclusion_criteria_met AS STRING)
      comment: "Whether all inclusion criteria were satisfied"
    - name: "has_exclusion_criteria_triggered"
      expr: CAST(has_exclusion_criteria_triggered AS STRING)
      comment: "Whether any exclusion criteria were triggered"
    - name: "outreach_status"
      expr: outreach_status
      comment: "Patient outreach status for the match"
    - name: "match_algorithm_version"
      expr: match_algorithm_version
      comment: "Version of the matching algorithm used"
  measures:
    - name: "total_matches"
      expr: COUNT(1)
      comment: "Total number of patient-trial matches generated"
    - name: "avg_match_score"
      expr: AVG(CAST(match_score AS DOUBLE))
      comment: "Average match confidence score across all matches - indicates algorithm quality"
    - name: "distinct_patients_matched"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients matched to at least one trial - measures program reach"
    - name: "distinct_trials_with_matches"
      expr: COUNT(DISTINCT clinical_trial_id)
      comment: "Unique trials that have at least one patient match - measures trial coverage"
    - name: "avg_data_completeness_pct"
      expr: AVG(CAST(data_completeness_pct AS DOUBLE))
      comment: "Average data completeness percentage across matches - indicates data quality for matching"
    - name: "matches_with_exclusion_triggered"
      expr: SUM(CASE WHEN has_exclusion_criteria_triggered = TRUE THEN 1 ELSE 0 END)
      comment: "Count of matches where exclusion criteria were triggered - helps identify common barriers"
    - name: "matches_inclusion_met"
      expr: SUM(CASE WHEN is_inclusion_criteria_met = TRUE THEN 1 ELSE 0 END)
      comment: "Count of matches where all inclusion criteria were met - measures screening effectiveness"
    - name: "enrolled_matches"
      expr: SUM(CASE WHEN match_status = 'enrolled' THEN 1 ELSE 0 END)
      comment: "Count of matches that resulted in enrollment - key conversion metric"
    - name: "declined_matches"
      expr: SUM(CASE WHEN match_status = 'declined' THEN 1 ELSE 0 END)
      comment: "Count of matches where patient declined - informs outreach strategy"
    - name: "rescreening_required_count"
      expr: SUM(CASE WHEN is_re_screening_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of matches requiring rescreening - indicates protocol complexity or data staleness"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`clinical_trial_matching_match_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Match result analytics tracking eligibility determinations, enrollment outcomes, and operational efficiency of the clinical trial matching pipeline."
  source: "`healthcare_ecm_v1`.`clinical_trial_matching`.`match_result`"
  dimensions:
    - name: "match_status"
      expr: match_status
      comment: "Current status of the match result"
    - name: "match_type"
      expr: match_type
      comment: "Type of matching approach used"
    - name: "eligibility_determination"
      expr: eligibility_determination
      comment: "Final eligibility determination (eligible, ineligible, indeterminate)"
    - name: "enrollment_outcome"
      expr: enrollment_outcome
      comment: "Final enrollment outcome for the match"
    - name: "referral_status"
      expr: referral_status
      comment: "Status of the referral to the trial site"
    - name: "patient_notification_status"
      expr: patient_notification_status
      comment: "Whether patient has been notified of the match"
    - name: "is_urgent"
      expr: CAST(is_urgent AS STRING)
      comment: "Whether the match is flagged as urgent"
    - name: "is_rescreen"
      expr: CAST(is_rescreen AS STRING)
      comment: "Whether this is a rescreening attempt"
    - name: "evaluation_month"
      expr: DATE_TRUNC('MONTH', evaluation_timestamp)
      comment: "Month of evaluation for trend analysis"
    - name: "matching_algorithm_version"
      expr: matching_algorithm_version
      comment: "Algorithm version used for this match result"
  measures:
    - name: "total_match_results"
      expr: COUNT(1)
      comment: "Total match results processed"
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall eligibility score - key quality indicator for matching algorithm"
    - name: "avg_confidence_level"
      expr: AVG(CAST(confidence_level AS DOUBLE))
      comment: "Average confidence level of match determinations"
    - name: "avg_data_completeness"
      expr: AVG(CAST(data_completeness_percent AS DOUBLE))
      comment: "Average data completeness across results - identifies data gaps impacting matching"
    - name: "avg_distance_to_site_km"
      expr: AVG(CAST(distance_to_site_km AS DOUBLE))
      comment: "Average distance patients must travel to trial site - accessibility metric"
    - name: "eligible_count"
      expr: SUM(CASE WHEN eligibility_determination = 'eligible' THEN 1 ELSE 0 END)
      comment: "Count of patients determined eligible"
    - name: "ineligible_count"
      expr: SUM(CASE WHEN eligibility_determination = 'ineligible' THEN 1 ELSE 0 END)
      comment: "Count of patients determined ineligible"
    - name: "consent_obtained_count"
      expr: SUM(CASE WHEN patient_consent_obtained = TRUE THEN 1 ELSE 0 END)
      comment: "Count of matches where patient consent was obtained - consent conversion metric"
    - name: "distinct_patients_evaluated"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients evaluated for trial eligibility"
    - name: "distinct_trials_evaluated"
      expr: COUNT(DISTINCT clinical_trial_id)
      comment: "Unique trials with evaluation activity"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`clinical_trial_matching_eligibility_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Eligibility evaluation metrics tracking screening throughput, evaluation outcomes, and protocol compliance for clinical trial enrollment workflows."
  source: "`healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation`"
  dimensions:
    - name: "eligibility_evaluation_status"
      expr: eligibility_evaluation_status
      comment: "Current status of the eligibility evaluation"
    - name: "overall_result"
      expr: overall_result
      comment: "Overall eligibility result (pass, fail, indeterminate)"
    - name: "evaluation_type"
      expr: evaluation_type
      comment: "Type of evaluation (initial, re-evaluation, override)"
    - name: "evaluation_method"
      expr: evaluation_method
      comment: "Method used for evaluation (automated, manual, hybrid)"
    - name: "confidence_level"
      expr: confidence_level
      comment: "Confidence level of the evaluation determination"
    - name: "irb_approval_status"
      expr: irb_approval_status
      comment: "IRB approval status at time of evaluation"
    - name: "informed_consent_status"
      expr: informed_consent_status
      comment: "Informed consent status of the patient"
    - name: "override_indicator"
      expr: CAST(override_indicator AS STRING)
      comment: "Whether the evaluation was overridden by a provider"
    - name: "evaluation_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month of evaluation for trend analysis"
    - name: "re_evaluation_indicator"
      expr: CAST(re_evaluation_indicator AS STRING)
      comment: "Whether this is a re-evaluation"
  measures:
    - name: "total_evaluations"
      expr: COUNT(1)
      comment: "Total eligibility evaluations performed"
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall eligibility score across evaluations"
    - name: "avg_data_completeness"
      expr: AVG(CAST(data_completeness_pct AS DOUBLE))
      comment: "Average data completeness percentage - identifies data quality barriers to enrollment"
    - name: "override_count"
      expr: SUM(CASE WHEN override_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of evaluations overridden by providers - monitors protocol deviation patterns"
    - name: "randomization_eligible_count"
      expr: SUM(CASE WHEN randomization_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of patients eligible for randomization - measures pipeline yield"
    - name: "washout_period_met_count"
      expr: SUM(CASE WHEN washout_period_met = TRUE THEN 1 ELSE 0 END)
      comment: "Count of patients meeting washout period requirements"
    - name: "distinct_patients_evaluated"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients who underwent eligibility evaluation"
    - name: "distinct_trials_evaluated"
      expr: COUNT(DISTINCT clinical_trial_id)
      comment: "Unique trials with active evaluations"
    - name: "re_evaluations_count"
      expr: SUM(CASE WHEN re_evaluation_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of re-evaluations performed - indicates protocol complexity or patient status changes"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`clinical_trial_matching_trial`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical trial portfolio metrics tracking trial availability, matching readiness, and enrollment capacity across the health system's research program."
  source: "`healthcare_ecm_v1`.`clinical_trial_matching`.`trial`"
  dimensions:
    - name: "trial_status"
      expr: trial_status
      comment: "Current status of the trial (recruiting, active, completed, suspended)"
    - name: "phase"
      expr: phase
      comment: "Trial phase (Phase I, II, III, IV)"
    - name: "study_type"
      expr: study_type
      comment: "Type of study (interventional, observational, expanded access)"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the trial (oncology, cardiology, neurology, etc.)"
    - name: "intervention_type"
      expr: intervention_type
      comment: "Type of intervention (drug, device, biological, procedure)"
    - name: "sponsor_type"
      expr: sponsor_type
      comment: "Type of sponsor (industry, NIH, academic, other)"
    - name: "primary_purpose"
      expr: primary_purpose
      comment: "Primary purpose of the trial (treatment, prevention, diagnostic, etc.)"
    - name: "is_actively_matching"
      expr: CAST(is_actively_matching AS STRING)
      comment: "Whether the trial is actively matching patients"
    - name: "is_multi_center"
      expr: CAST(is_multi_center AS STRING)
      comment: "Whether the trial is multi-center"
    - name: "fda_regulated_drug"
      expr: CAST(fda_regulated_drug AS STRING)
      comment: "Whether the trial involves an FDA-regulated drug"
  measures:
    - name: "total_trials"
      expr: COUNT(1)
      comment: "Total number of clinical trials in the portfolio"
    - name: "actively_matching_trials"
      expr: SUM(CASE WHEN is_actively_matching = TRUE THEN 1 ELSE 0 END)
      comment: "Trials currently matching patients - measures active research capacity"
    - name: "avg_matching_priority_score"
      expr: AVG(CAST(matching_priority_score AS DOUBLE))
      comment: "Average matching priority score across trials - indicates portfolio strategic alignment"
    - name: "multi_center_trials"
      expr: SUM(CASE WHEN is_multi_center = TRUE THEN 1 ELSE 0 END)
      comment: "Count of multi-center trials - indicates collaborative research engagement"
    - name: "fda_regulated_trials"
      expr: SUM(CASE WHEN fda_regulated_drug = TRUE OR fda_regulated_device = TRUE THEN 1 ELSE 0 END)
      comment: "Count of FDA-regulated trials - indicates regulatory complexity of portfolio"
    - name: "trials_accepting_volunteers"
      expr: SUM(CASE WHEN accepts_healthy_volunteers = TRUE THEN 1 ELSE 0 END)
      comment: "Trials accepting healthy volunteers - broadens matching pool"
    - name: "distinct_therapeutic_areas"
      expr: COUNT(DISTINCT therapeutic_area)
      comment: "Number of distinct therapeutic areas covered - measures research program breadth"
    - name: "distinct_care_sites"
      expr: COUNT(DISTINCT care_site_id)
      comment: "Number of distinct care sites hosting trials - measures geographic reach"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`clinical_trial_matching_patient_trial_match`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient-level trial matching metrics tracking enrollment funnel conversion, screen failure rates, and diversity in clinical trial participation."
  source: "`healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match`"
  dimensions:
    - name: "match_status"
      expr: match_status
      comment: "Current match status in the enrollment funnel"
    - name: "match_type"
      expr: match_type
      comment: "Type of match (algorithm-driven, physician-referred, self-identified)"
  measures:
    - name: "total_patient_trial_matches"
      expr: COUNT(1)
      comment: "Total patient-trial match records"
    - name: "enrolled_count"
      expr: SUM(CASE WHEN match_status = 'enrolled' THEN 1 ELSE 0 END)
      comment: "Count of patients enrolled from matches - ultimate conversion metric"
    - name: "distinct_patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients in the matching pipeline"
    - name: "distinct_trials_matched"
      expr: COUNT(DISTINCT clinical_trial_id)
      comment: "Unique trials with patient matches"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`clinical_trial_matching_trial_eligibility_status`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trial eligibility status metrics tracking multi-criteria eligibility assessment outcomes, screening windows, and waiver patterns for protocol optimization."
  source: "`healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility_status`"
  dimensions:
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Overall eligibility status determination"
    - name: "enrollment_decision"
      expr: enrollment_decision
      comment: "Final enrollment decision made"
    - name: "evaluation_method"
      expr: evaluation_method
      comment: "Method used for eligibility evaluation"
    - name: "source_system"
      expr: source_system
      comment: "Source system providing eligibility data"
    - name: "is_current_record"
      expr: CAST(is_current_record AS STRING)
      comment: "Whether this is the current/latest eligibility record"
    - name: "rescreening_flag"
      expr: CAST(rescreening_flag AS STRING)
      comment: "Whether this is a rescreening attempt"
    - name: "evaluation_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month of eligibility evaluation"
    - name: "confidence_level"
      expr: confidence_level
      comment: "Confidence level of the eligibility determination"
  measures:
    - name: "total_eligibility_records"
      expr: COUNT(1)
      comment: "Total eligibility status records"
    - name: "avg_match_score"
      expr: AVG(CAST(overall_match_score AS DOUBLE))
      comment: "Average overall match score - algorithm performance indicator"
    - name: "avg_data_completeness"
      expr: AVG(CAST(data_completeness_percent AS DOUBLE))
      comment: "Average data completeness for eligibility assessments"
    - name: "waiver_requested_count"
      expr: SUM(CASE WHEN waiver_requested_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of waiver requests - indicates protocol stringency issues"
    - name: "waiver_approved_count"
      expr: SUM(CASE WHEN waiver_approved_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of approved waivers - measures protocol flexibility utilization"
    - name: "age_eligible_count"
      expr: SUM(CASE WHEN age_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count meeting age criteria - demographic eligibility indicator"
    - name: "diagnosis_eligible_count"
      expr: SUM(CASE WHEN diagnosis_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count meeting diagnosis criteria - clinical eligibility indicator"
    - name: "lab_eligible_count"
      expr: SUM(CASE WHEN lab_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count meeting lab criteria - identifies lab-related screening barriers"
    - name: "medication_eligible_count"
      expr: SUM(CASE WHEN medication_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count meeting medication criteria - identifies medication washout barriers"
    - name: "distinct_patients_assessed"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients with eligibility assessments"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`clinical_trial_matching_trial_eligibility_criteria`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Eligibility criteria complexity and automation metrics tracking protocol design patterns, automation readiness, and criteria management for trial operations."
  source: "`healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_criteria`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "total_criteria"
      expr: COUNT(1)
      comment: "Total eligibility criteria defined across all trials"
$$;