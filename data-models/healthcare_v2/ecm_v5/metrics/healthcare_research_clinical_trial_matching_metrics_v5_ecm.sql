-- Metric views for domain: research_clinical_trial_matching | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`research_clinical_trial_matching_eligibility_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core metric view for clinical trial eligibility evaluations - tracks patient-to-trial matching volume, diversity of data sources used in matching, and operational throughput of the trial matching engine."
  source: "`healthcare_ecm_v1`.`research_clinical_trial_matching`.`research_clinical_trial_matching_eligibility_evaluation`"
  dimensions:
    - name: "eligibility_criteria_id"
      expr: research_clinical_trial_matching_eligibility_criteria_id
      comment: "The eligibility criteria set against which the patient was evaluated, enabling analysis of match rates per trial criteria"
    - name: "patient_mpi_record_id"
      expr: mpi_record_id
      comment: "Patient identifier for analyzing per-patient trial matching coverage and multi-trial eligibility patterns"
    - name: "has_genomic_data"
      expr: CASE WHEN genomic_test_result_id IS NOT NULL THEN 'Yes' ELSE 'No' END
      comment: "Whether genomic data was available for this evaluation, indicating precision medicine trial matching capability"
    - name: "has_risk_score"
      expr: CASE WHEN clinical_ai_patient_risk_score_id IS NOT NULL THEN 'Yes' ELSE 'No' END
      comment: "Whether AI risk scoring was incorporated into the eligibility evaluation"
    - name: "has_post_acute_episode"
      expr: CASE WHEN post_acute_episode_id IS NOT NULL THEN 'Yes' ELSE 'No' END
      comment: "Whether post-acute care episode data was used in eligibility determination"
  measures:
    - name: "total_eligibility_evaluations"
      expr: COUNT(1)
      comment: "Total number of patient-to-trial eligibility evaluations performed - primary throughput metric for the clinical trial matching engine"
    - name: "distinct_patients_evaluated"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients who have undergone trial eligibility evaluation - measures patient reach of the matching program"
    - name: "distinct_criteria_sets_evaluated"
      expr: COUNT(DISTINCT research_clinical_trial_matching_eligibility_criteria_id)
      comment: "Number of distinct trial eligibility criteria sets actively being matched against - indicates breadth of active trial portfolio"
    - name: "genomic_enriched_evaluations"
      expr: SUM(CASE WHEN genomic_test_result_id IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of evaluations that incorporated genomic test results - measures precision medicine integration in trial matching"
    - name: "ai_risk_enriched_evaluations"
      expr: SUM(CASE WHEN clinical_ai_patient_risk_score_id IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of evaluations that incorporated AI-generated patient risk scores - measures AI/ML integration maturity"
    - name: "multi_source_enriched_evaluations"
      expr: SUM(CASE WHEN genomic_test_result_id IS NOT NULL AND clinical_ai_patient_risk_score_id IS NOT NULL AND post_acute_episode_id IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of evaluations leveraging all three enrichment sources (genomic, AI risk, post-acute) - indicates comprehensive data-driven matching"
    - name: "evaluations_per_patient"
      expr: CAST(COUNT(1) AS DOUBLE) / NULLIF(COUNT(DISTINCT mpi_record_id), 0)
      comment: "Average number of trial eligibility evaluations per patient - higher values indicate broader trial matching coverage per patient"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`research_clinical_trial_matching_eligibility_criteria`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metric view for trial eligibility criteria definitions - tracks the volume and diversity of structured eligibility criteria linked to research studies, indicating trial matching program maturity."
  source: "`healthcare_ecm_v1`.`research_clinical_trial_matching`.`research_clinical_trial_matching_eligibility_criteria`"
  dimensions:
    - name: "research_study_id"
      expr: research_study_id
      comment: "The research study to which eligibility criteria belong, enabling per-study criteria complexity analysis"
  measures:
    - name: "total_eligibility_criteria"
      expr: COUNT(1)
      comment: "Total number of structured eligibility criteria definitions - measures the breadth of trial matching rule coverage"
    - name: "distinct_studies_with_criteria"
      expr: COUNT(DISTINCT research_study_id)
      comment: "Number of distinct research studies that have structured eligibility criteria defined - indicates trial matching program coverage across the study portfolio"
    - name: "avg_criteria_per_study"
      expr: CAST(COUNT(1) AS DOUBLE) / NULLIF(COUNT(DISTINCT research_study_id), 0)
      comment: "Average number of eligibility criteria per study - higher values indicate more granular and precise matching rules"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`research_clinical_trial_matching_trial_eligibility_criteria`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metric view for trial-level eligibility criteria - tracks the structured criteria definitions at the trial level for operational reporting on trial matching readiness."
  source: "`healthcare_ecm_v1`.`research_clinical_trial_matching`.`research_clinical_trial_matching_trial_eligibility_criteria`"
  dimensions:
    - name: "research_study_id"
      expr: research_study_id
      comment: "The research study associated with trial eligibility criteria, enabling per-study readiness analysis"
  measures:
    - name: "total_trial_criteria_definitions"
      expr: COUNT(1)
      comment: "Total number of trial-level eligibility criteria definitions - measures operational readiness of the trial matching system"
    - name: "distinct_studies_with_trial_criteria"
      expr: COUNT(DISTINCT research_study_id)
      comment: "Number of distinct studies with trial eligibility criteria configured - indicates how many trials are actively matchable in the system"
$$;