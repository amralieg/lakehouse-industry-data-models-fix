-- Metric views for domain: quality | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`quality_measure_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core quality measure performance metrics tracking organizational performance rates, gap-to-target analysis, and benchmark comparisons across quality programs and reporting periods."
  source: "`healthcare_ecm_v1`.`quality`.`measure_result`"
  dimensions:
    - name: "measure_category"
      expr: measure_category
      comment: "Category of quality measure (process, outcome, structure, patient experience)"
    - name: "quality_domain"
      expr: quality_domain
      comment: "Clinical quality domain (safety, effectiveness, timeliness, efficiency, equity, patient-centeredness)"
    - name: "reporting_year"
      expr: reporting_year
      comment: "Calendar year of measure reporting for annual trending"
    - name: "reporting_quarter"
      expr: reporting_quarter
      comment: "Quarter within reporting year for seasonal analysis"
    - name: "entity_type"
      expr: entity_type
      comment: "Type of measured entity (clinician, facility, health plan, ACO)"
    - name: "submission_status"
      expr: submission_status
      comment: "Status of measure submission to regulatory body"
    - name: "reporting_method"
      expr: reporting_method
      comment: "Method used for reporting (EHR, registry, claims, QCDR)"
    - name: "risk_adjusted_flag"
      expr: CAST(risk_adjusted_flag AS STRING)
      comment: "Whether the result has been risk-adjusted for patient acuity"
    - name: "measure_result_status"
      expr: measure_result_status
      comment: "Current status of the measure result record"
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality indicator for the measure result"
  measures:
    - name: "avg_performance_rate"
      expr: AVG(CAST(performance_rate AS DOUBLE))
      comment: "Average performance rate across all measured entities - primary indicator of organizational quality performance"
    - name: "avg_gap_to_target"
      expr: AVG(CAST(gap_to_target AS DOUBLE))
      comment: "Average gap between actual performance and target rate - indicates how far organization is from quality goals"
    - name: "total_numerator"
      expr: SUM(CAST(numerator AS DOUBLE))
      comment: "Total numerator count across all measure results for aggregate compliance calculation"
    - name: "total_denominator"
      expr: SUM(CAST(denominator AS DOUBLE))
      comment: "Total denominator count across all measure results for aggregate rate calculation"
    - name: "total_exclusion_count"
      expr: SUM(CAST(exclusion_count AS DOUBLE))
      comment: "Total exclusions applied - monitors potential over-exclusion that could mask poor performance"
    - name: "avg_risk_adjusted_rate"
      expr: AVG(CAST(risk_adjusted_rate AS DOUBLE))
      comment: "Average risk-adjusted performance rate accounting for patient complexity"
    - name: "avg_benchmark_rate"
      expr: AVG(CAST(benchmark_rate AS DOUBLE))
      comment: "Average benchmark rate for comparison against national or peer performance"
    - name: "measure_result_count"
      expr: COUNT(1)
      comment: "Total number of measure results reported - baseline volume metric for completeness assessment"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`quality_mips_clinician_measure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MIPS clinician-level quality measure performance tracking for CMS Merit-based Incentive Payment System reporting, payment adjustment forecasting, and individual provider quality accountability."
  source: "`healthcare_ecm_v1`.`quality`.`measure`"
  dimensions:
    - name: "measure_category"
      expr: measure_category
      comment: "Clinical category of the quality measure"
  measures:
    - name: "clinician_measure_count"
      expr: COUNT(1)
      comment: "Total clinician-measure reporting combinations submitted"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`quality_mips_reporting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Organization-level MIPS reporting metrics for tracking aggregate CMS quality program performance, payment adjustment exposure, and exceptional performance bonus eligibility."
  source: "`healthcare_ecm_v1`.`quality`.`mips_reporting`"
  dimensions:
    - name: "performance_year"
      expr: performance_year
      comment: "MIPS performance year for CMS reporting"
    - name: "category_code"
      expr: category_code
      comment: "MIPS reporting category (quality, PI, IA, cost)"
    - name: "submission_method_code"
      expr: submission_method_code
      comment: "Method of data submission to CMS"
    - name: "status_code"
      expr: status_code
      comment: "Current status of the MIPS reporting record"
    - name: "exceptional_performance_flag"
      expr: CAST(exceptional_performance_flag AS STRING)
      comment: "Whether clinician qualifies for exceptional performance bonus"
  measures:
    - name: "avg_final_score"
      expr: AVG(CAST(final_score AS DOUBLE))
      comment: "Average MIPS final composite score across reporting entities"
    - name: "total_points_earned"
      expr: SUM(CAST(points_earned AS DOUBLE))
      comment: "Total MIPS points earned across all measures and clinicians"
    - name: "total_points_available"
      expr: SUM(CAST(points_available AS DOUBLE))
      comment: "Total MIPS points available - denominator for point utilization rate"
    - name: "avg_payment_adjustment_pct"
      expr: AVG(CAST(payment_adjustment_pct AS DOUBLE))
      comment: "Average payment adjustment percentage - forecasts Medicare revenue impact"
    - name: "avg_performance_rate"
      expr: AVG(CAST(performance_rate AS DOUBLE))
      comment: "Average performance rate across all reported measures"
    - name: "distinct_clinicians_reported"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Number of unique clinicians with MIPS reporting - completeness indicator"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`quality_care_gap_closure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care gap identification and closure tracking metrics for value-based care programs, measuring outreach effectiveness, closure rates, and patient engagement in quality improvement."
  source: "`healthcare_ecm_v1`.`quality`.`care_gap_closure`"
  dimensions:
    - name: "closure_status"
      expr: closure_status
      comment: "Current status of the care gap (open, closed, excluded, patient declined)"
    - name: "closure_method"
      expr: closure_method
      comment: "Method by which the gap was closed (visit, telehealth, supplemental data, outreach)"
    - name: "measurement_year"
      expr: measurement_year
      comment: "Quality measurement year for the care gap"
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year for value-based contract alignment"
    - name: "evidence_type"
      expr: evidence_type
      comment: "Type of evidence used to close the gap (claim, EHR, supplemental)"
    - name: "patient_declined_flag"
      expr: CAST(patient_declined_flag AS STRING)
      comment: "Whether patient declined recommended care - important for exclusion tracking"
    - name: "barrier_reason"
      expr: barrier_reason_cd
      comment: "Coded reason for barrier to gap closure (transportation, cost, language, etc.)"
  measures:
    - name: "total_care_gaps"
      expr: COUNT(1)
      comment: "Total number of care gaps identified across all patients and measures"
    - name: "distinct_patients_with_gaps"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients with open or closed care gaps"
    - name: "avg_outreach_attempts"
      expr: AVG(CAST(outreach_attempt_count AS DOUBLE))
      comment: "Average number of outreach attempts per care gap - measures engagement effort intensity"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`quality_patient_safety_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient safety event tracking and severity analysis for risk management, regulatory reporting, and organizational safety culture improvement."
  source: "`healthcare_ecm_v1`.`quality`.`patient_safety_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of safety event (fall, medication error, surgical, infection, etc.)"
    - name: "harm_level"
      expr: harm_level
      comment: "Level of patient harm (near miss, no harm, temporary harm, permanent harm, death)"
    - name: "patient_safety_event_category"
      expr: patient_safety_event_category
      comment: "Broad category of the safety event for trending"
    - name: "patient_safety_event_status"
      expr: patient_safety_event_status
      comment: "Current investigation/resolution status of the event"
    - name: "is_sentinel"
      expr: CAST(is_sentinel AS STRING)
      comment: "Whether event qualifies as a sentinel event requiring Joint Commission reporting"
    - name: "is_reportable"
      expr: CAST(is_reportable AS STRING)
      comment: "Whether event must be reported to external regulatory agency"
    - name: "disclosure_status"
      expr: disclosure_status
      comment: "Status of patient/family disclosure of the safety event"
    - name: "location"
      expr: location
      comment: "Physical location where the safety event occurred"
  measures:
    - name: "total_safety_events"
      expr: COUNT(1)
      comment: "Total patient safety events reported - primary safety culture indicator"
    - name: "distinct_patients_affected"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients affected by safety events"
    - name: "sentinel_event_count"
      expr: SUM(CASE WHEN is_sentinel = TRUE THEN 1 ELSE 0 END)
      comment: "Count of sentinel events requiring immediate root cause analysis and Joint Commission reporting"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`quality_hedis_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HEDIS measure performance results for health plan quality reporting, NCQA accreditation, and Star Ratings performance tracking."
  source: "`healthcare_ecm_v1`.`quality`.`hedis_result`"
  dimensions:
    - name: "measure_category"
      expr: measure_category
      comment: "HEDIS measure domain (effectiveness of care, access, utilization, etc.)"
    - name: "measure_type"
      expr: measure_type
      comment: "Type of HEDIS measure (process, outcome, structural)"
    - name: "hedis_result_status"
      expr: hedis_result_status
      comment: "Status of the HEDIS result (preliminary, final, audited)"
    - name: "submission_status"
      expr: submission_status
      comment: "NCQA submission status for the measure result"
    - name: "data_source"
      expr: data_source
      comment: "Source of data for HEDIS calculation (administrative, hybrid, ECDS)"
    - name: "risk_adjusted_flag"
      expr: CAST(risk_adjusted_flag AS STRING)
      comment: "Whether result is risk-adjusted for population acuity"
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality indicator for audit readiness"
  measures:
    - name: "avg_hedis_rate"
      expr: AVG(CAST(rate AS DOUBLE))
      comment: "Average HEDIS performance rate - primary health plan quality indicator for Star Ratings"
    - name: "avg_risk_adjusted_rate"
      expr: AVG(CAST(risk_adjusted_rate AS DOUBLE))
      comment: "Average risk-adjusted HEDIS rate accounting for population health complexity"
    - name: "avg_benchmark_rate"
      expr: AVG(CAST(benchmark_rate AS DOUBLE))
      comment: "Average NCQA benchmark rate for peer comparison and percentile ranking"
    - name: "total_hedis_results"
      expr: COUNT(1)
      comment: "Total HEDIS measure results reported across all measures and populations"
    - name: "distinct_measures_reported"
      expr: COUNT(DISTINCT hedis_measure_id)
      comment: "Number of unique HEDIS measures with results - completeness indicator for NCQA submission"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`quality_vbp_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Value-Based Purchasing program performance metrics tracking total performance scores, domain weights, payment adjustments, and program financial impact."
  source: "`healthcare_ecm_v1`.`quality`.`vbp_program`"
  dimensions:
    - name: "program_type"
      expr: program_type
      comment: "Type of VBP program (HVBP, HRRP, HAC, SNF-VBP, HH-VBP)"
    - name: "program_year"
      expr: program_year
      comment: "Program performance year for annual comparison"
    - name: "vbp_program_status"
      expr: vbp_program_status
      comment: "Current status of VBP program participation"
    - name: "is_apm_enrolled"
      expr: CAST(is_apm_enrolled AS STRING)
      comment: "Whether facility is enrolled in Alternative Payment Model"
    - name: "is_mips_eligible"
      expr: CAST(is_mips_eligible AS STRING)
      comment: "Whether facility is MIPS-eligible under the VBP program"
  measures:
    - name: "avg_total_performance_score"
      expr: AVG(CAST(total_performance_score AS DOUBLE))
      comment: "Average Total Performance Score (TPS) - determines VBP payment adjustment magnitude"
    - name: "avg_payment_adjustment_factor"
      expr: AVG(CAST(payment_adjustment_factor AS DOUBLE))
      comment: "Average payment adjustment factor applied to DRG payments - direct revenue impact"
    - name: "avg_clinical_outcome_weight"
      expr: AVG(CAST(clinical_outcome_weight AS DOUBLE))
      comment: "Average weight assigned to clinical outcomes domain in TPS calculation"
    - name: "avg_safety_weight"
      expr: AVG(CAST(safety_weight AS DOUBLE))
      comment: "Average weight assigned to safety domain - reflects CMS emphasis on harm reduction"
    - name: "avg_performance_score"
      expr: AVG(CAST(performance_score AS DOUBLE))
      comment: "Average raw performance score before payment adjustment conversion"
    - name: "avg_baseline_score"
      expr: AVG(CAST(baseline_score AS DOUBLE))
      comment: "Average baseline period score for improvement calculation"
    - name: "program_count"
      expr: COUNT(1)
      comment: "Number of VBP programs tracked"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`quality_apm_program_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Alternative Payment Model program enrollment and performance metrics for tracking ACO participation, shared savings/loss exposure, and qualifying participant status."
  source: "`healthcare_ecm_v1`.`quality`.`apm_program_enrollment`"
  dimensions:
    - name: "apm_program_code"
      expr: apm_program_code
      comment: "CMS APM program identifier (MSSP, BPCI-A, CJR, PCF, ACO REACH)"
    - name: "participation_type"
      expr: participation_type
      comment: "Type of APM participation (one-sided risk, two-sided risk, capitated)"
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status in the APM program"
    - name: "performance_year"
      expr: performance_year
      comment: "APM performance year for annual evaluation"
    - name: "entity_type_code"
      expr: entity_type_code
      comment: "Type of participating entity (individual, group, ACO, hospital)"
    - name: "qualifying_participant_flag"
      expr: CAST(qualifying_participant_flag AS STRING)
      comment: "Whether entity meets QP threshold for MIPS exemption"
    - name: "risk_level"
      expr: risk_level_cd
      comment: "Risk level of APM participation track"
  measures:
    - name: "total_payment_incentive"
      expr: SUM(CAST(payment_incentive_amount AS DOUBLE))
      comment: "Total payment incentives earned across APM enrollments - shared savings revenue"
    - name: "avg_quality_threshold_score"
      expr: AVG(CAST(quality_threshold_score AS DOUBLE))
      comment: "Average quality threshold score determining shared savings eligibility"
    - name: "avg_shared_savings_rate"
      expr: AVG(CAST(shared_savings_rate_pct AS DOUBLE))
      comment: "Average shared savings rate percentage across APM participants"
    - name: "avg_shared_loss_rate"
      expr: AVG(CAST(shared_loss_rate_pct AS DOUBLE))
      comment: "Average shared loss rate percentage - downside risk exposure indicator"
    - name: "avg_threshold_score"
      expr: AVG(CAST(threshold_score AS DOUBLE))
      comment: "Average performance threshold score for APM success determination"
    - name: "distinct_clinicians_enrolled"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Number of unique clinicians enrolled in APM programs"
    - name: "enrollment_count"
      expr: COUNT(1)
      comment: "Total APM program enrollments across all entities and programs"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`quality_cahps_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CAHPS patient experience survey response metrics for Hospital Star Ratings, VBP person and community engagement domain scoring, and patient satisfaction trending."
  source: "`healthcare_ecm_v1`.`quality`.`cahps_response`"
  dimensions:
    - name: "survey_name"
      expr: survey_name
      comment: "Name of CAHPS survey instrument (HCAHPS, CG-CAHPS, OAS-CAHPS)"
    - name: "overall_score_category"
      expr: overall_score_category
      comment: "Categorical rating of overall hospital experience (top-box, middle-box, bottom-box)"
    - name: "administration_mode"
      expr: administration_mode
      comment: "Survey administration method (mail, phone, mixed-mode, web)"
    - name: "respondent_type"
      expr: respondent_type
      comment: "Type of survey respondent (patient, proxy)"
    - name: "response_status"
      expr: response_status
      comment: "Status of the survey response (complete, partial, non-response)"
    - name: "reporting_period"
      expr: reporting_period
      comment: "Reporting period for the CAHPS survey cycle"
    - name: "admission_type"
      expr: admission_type
      comment: "Type of admission for the surveyed encounter"
  measures:
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall hospital rating - primary HCAHPS composite for Star Ratings"
    - name: "avg_communication_doctor_score"
      expr: AVG(CAST(communication_doctor_score AS DOUBLE))
      comment: "Average doctor communication composite score - key driver of patient experience"
    - name: "avg_responsiveness_staff_score"
      expr: AVG(CAST(responsiveness_staff_score AS DOUBLE))
      comment: "Average staff responsiveness score - operational efficiency indicator"
    - name: "avg_pain_management_score"
      expr: AVG(CAST(pain_management_score AS DOUBLE))
      comment: "Average pain management communication score"
    - name: "avg_discharge_information_score"
      expr: AVG(CAST(discharge_information_score AS DOUBLE))
      comment: "Average discharge information score - impacts readmission rates"
    - name: "avg_communication_medicine_score"
      expr: AVG(CAST(communication_medicine_score AS DOUBLE))
      comment: "Average communication about medicines score - medication safety indicator"
    - name: "total_responses"
      expr: COUNT(1)
      comment: "Total survey responses received - response rate denominator component"
    - name: "distinct_patients_surveyed"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients who completed CAHPS surveys"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`quality_improvement_initiative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality improvement initiative performance tracking for PDSA cycles, Lean/Six Sigma projects, and organizational quality strategy execution monitoring."
  source: "`healthcare_ecm_v1`.`quality`.`improvement_initiative`"
  dimensions:
    - name: "improvement_initiative_status"
      expr: improvement_initiative_status
      comment: "Current status of the improvement initiative (planning, active, completed, suspended)"
    - name: "current_phase"
      expr: current_phase
      comment: "Current PDSA or project phase (Plan, Do, Study, Act, Define, Measure, Analyze, Improve, Control)"
    - name: "methodology"
      expr: methodology
      comment: "Improvement methodology used (PDSA, Lean, Six Sigma, IHI Model for Improvement)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the initiative (critical, high, medium, low)"
    - name: "related_clinical_area"
      expr: related_clinical_area
      comment: "Clinical area targeted by the improvement initiative"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the initiative"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the initiative"
  measures:
    - name: "avg_baseline_performance"
      expr: AVG(CAST(baseline_performance AS DOUBLE))
      comment: "Average baseline performance before intervention - establishes improvement starting point"
    - name: "avg_goal_performance"
      expr: AVG(CAST(goal_performance AS DOUBLE))
      comment: "Average target goal performance for initiatives - defines success criteria"
    - name: "avg_measure_actual"
      expr: AVG(CAST(measure_actual AS DOUBLE))
      comment: "Average actual measured performance - compared against baseline and goal for improvement assessment"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated to quality improvement initiatives"
    - name: "total_estimated_savings"
      expr: SUM(CAST(estimated_savings AS DOUBLE))
      comment: "Total estimated financial savings from improvement initiatives - ROI indicator"
    - name: "initiative_count"
      expr: COUNT(1)
      comment: "Total number of quality improvement initiatives in portfolio"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`quality_accreditation_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accreditation survey readiness and compliance metrics for Joint Commission, DNV, HFAP, and CMS survey performance tracking."
  source: "`healthcare_ecm_v1`.`quality`.`accreditation_survey`"
  dimensions:
    - name: "survey_type"
      expr: survey_type
      comment: "Type of accreditation survey (triennial, unannounced, focused, validation)"
    - name: "accrediting_body"
      expr: accrediting_body
      comment: "Accrediting organization (TJC, DNV, HFAP, CMS, state)"
    - name: "accreditation_decision"
      expr: accreditation_decision
      comment: "Survey decision outcome (accredited, conditional, preliminary denial, denial)"
    - name: "survey_status"
      expr: survey_status
      comment: "Current status of the survey process"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned based on survey findings"
    - name: "corrective_action_plan_required"
      expr: CAST(corrective_action_plan_required AS STRING)
      comment: "Whether a corrective action plan was required post-survey"
    - name: "survey_scope"
      expr: survey_scope
      comment: "Scope of the survey (full, focused, for-cause)"
  measures:
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across surveys - primary accreditation readiness indicator"
    - name: "avg_overall_readiness_score"
      expr: AVG(CAST(overall_readiness_score AS DOUBLE))
      comment: "Average organizational readiness score for upcoming surveys"
    - name: "avg_documentation_completeness_score"
      expr: AVG(CAST(documentation_completeness_score AS DOUBLE))
      comment: "Average documentation completeness score - common deficiency area"
    - name: "survey_count"
      expr: COUNT(1)
      comment: "Total number of accreditation surveys conducted"
    - name: "distinct_facilities_surveyed"
      expr: COUNT(DISTINCT care_site_id)
      comment: "Number of unique facilities that underwent accreditation surveys"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`quality_population_health_gap`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Population health gap identification and management metrics for proactive care management, risk stratification, and value-based care program performance."
  source: "`healthcare_ecm_v1`.`quality`.`population_health_gap`"
  dimensions:
    - name: "gap_type"
      expr: gap_type
      comment: "Type of population health gap (preventive, chronic disease, behavioral, SDOH)"
    - name: "gap_status"
      expr: gap_status
      comment: "Current status of the health gap (open, closed, excluded, in-progress)"
    - name: "gap_category"
      expr: gap_category
      comment: "Category of the gap for population health stratification"
    - name: "priority"
      expr: priority
      comment: "Priority level for gap closure outreach"
    - name: "closure_method"
      expr: closure_method
      comment: "Method used to close the gap (office visit, telehealth, outreach, supplemental data)"
    - name: "is_excluded"
      expr: CAST(is_excluded AS STRING)
      comment: "Whether the gap has been excluded from measurement"
  measures:
    - name: "total_population_gaps"
      expr: COUNT(1)
      comment: "Total population health gaps identified - workload and opportunity indicator"
    - name: "distinct_patients_with_gaps"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients with identified health gaps"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of patients with gaps - prioritization indicator for care management resources"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`quality_cdi_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical Documentation Improvement review metrics tracking query rates, physician response, DRG impact, and CMI optimization for revenue integrity and quality reporting accuracy."
  source: "`healthcare_ecm_v1`.`quality`.`cdi_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of CDI review (concurrent, retrospective, pre-bill)"
    - name: "query_type"
      expr: query_type
      comment: "Type of physician query issued (clarification, specificity, present on admission)"
    - name: "query_outcome"
      expr: query_outcome
      comment: "Outcome of the physician query (agreed, disagreed, no response)"
    - name: "cdi_review_status"
      expr: cdi_review_status
      comment: "Current status of the CDI review"
    - name: "physician_response"
      expr: physician_response
      comment: "Physician response to CDI query"
    - name: "documentation_impact"
      expr: documentation_impact
      comment: "Impact level of documentation improvement on coding"
    - name: "query_present"
      expr: CAST(query_present AS STRING)
      comment: "Whether a query was generated during the review"
    - name: "cc_mcc_captured"
      expr: CAST(cc_mcc_captured AS STRING)
      comment: "Whether CC/MCC was captured through CDI intervention"
  measures:
    - name: "avg_cmi_impact"
      expr: AVG(CAST(cmi_impact AS DOUBLE))
      comment: "Average Case Mix Index impact from CDI interventions - direct revenue and severity indicator"
    - name: "avg_cmi_final"
      expr: AVG(CAST(cmi_final AS DOUBLE))
      comment: "Average final CMI after CDI review - organizational acuity benchmark"
    - name: "avg_quality_metric_score"
      expr: AVG(CAST(quality_metric_score AS DOUBLE))
      comment: "Average quality metric score improvement from documentation accuracy"
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total CDI reviews performed - productivity and coverage metric"
    - name: "distinct_patients_reviewed"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients with CDI reviews - penetration rate denominator"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`quality_sdoh_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Social Determinants of Health screening metrics for CMS and Joint Commission compliance, community health needs assessment, and health equity program effectiveness."
  source: "`healthcare_ecm_v1`.`quality`.`sdoh_screening`"
  dimensions:
    - name: "screening_domain"
      expr: screening_domain
      comment: "SDOH domain screened (food insecurity, housing, transportation, interpersonal safety, utilities)"
    - name: "screening_tool"
      expr: screening_tool
      comment: "Standardized screening instrument used (AHC-HRSN, PRAPARE, Protocol for Responding to Patients Assets Risks and Experiences)"
    - name: "screening_status"
      expr: screening_status
      comment: "Status of the screening (completed, refused, incomplete)"
    - name: "screening_result"
      expr: screening_result
      comment: "Result of the screening (positive, negative, inconclusive)"
    - name: "positive_screen_flag"
      expr: CAST(positive_screen_flag AS STRING)
      comment: "Whether screening identified an unmet social need"
    - name: "referral_generated"
      expr: CAST(referral_generated AS STRING)
      comment: "Whether a community resource referral was generated from positive screen"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned based on screening results"
    - name: "follow_up_completed"
      expr: CAST(follow_up_completed AS STRING)
      comment: "Whether follow-up on identified need was completed"
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total SDOH screenings performed - CMS compliance volume indicator"
    - name: "distinct_patients_screened"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients screened for SDOH - population coverage metric"
    - name: "positive_screen_count"
      expr: SUM(CASE WHEN positive_screen_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of positive SDOH screens identifying unmet social needs - community health burden indicator"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`quality_contract_initiative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payer contract quality initiative performance metrics tracking incentive/penalty exposure, target achievement, and value-based contract financial outcomes."
  source: "`healthcare_ecm_v1`.`quality`.`contract_initiative`"
  dimensions:
    - name: "contract_initiative_status"
      expr: contract_initiative_status
      comment: "Current status of the contract quality initiative"
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "How often performance is reported to payer (monthly, quarterly, annually)"
    - name: "performance_metric_code"
      expr: performance_metric_code
      comment: "Code identifying the specific performance metric in the contract"
    - name: "compliance_flag"
      expr: CAST(compliance_flag AS STRING)
      comment: "Whether the initiative is currently in compliance with contract terms"
  measures:
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total financial incentives available across contract quality initiatives"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalty exposure across contract quality initiatives"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average performance target value across contract initiatives"
    - name: "initiative_count"
      expr: COUNT(1)
      comment: "Total number of active contract quality initiatives being tracked"
$$;