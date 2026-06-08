-- Metric views for domain: patient | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`patient_care_program_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic metrics for care program enrollment tracking - monitors population health program effectiveness, risk stratification, and patient engagement across value-based care initiatives."
  source: "`healthcare_ecm_v1`.`patient`.`care_program_enrollment`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current enrollment status (active, disenrolled, pending) for filtering program performance"
    - name: "program_type"
      expr: program_type
      comment: "Type of care program (chronic disease management, transitional care, etc.)"
    - name: "risk_tier"
      expr: risk_tier
      comment: "Patient risk stratification tier for population segmentation"
    - name: "enrollment_method"
      expr: enrollment_method
      comment: "How patient was enrolled (auto-attribution, referral, self-enrollment)"
    - name: "segment_type"
      expr: segment_type
      comment: "Population segment classification for cohort analysis"
    - name: "is_high_priority"
      expr: CAST(is_high_priority AS STRING)
      comment: "Whether enrollment is flagged as high priority for intervention"
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year of enrollment for trend analysis"
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment for seasonal pattern detection"
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total number of care program enrollments across all programs"
    - name: "active_enrollments"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active enrollments indicating program capacity utilization"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of enrolled patients - key indicator for resource allocation and intervention intensity"
    - name: "avg_program_outcome_score"
      expr: AVG(CAST(program_outcome_score AS DOUBLE))
      comment: "Average program outcome score measuring clinical effectiveness of care programs"
    - name: "high_priority_enrollment_count"
      expr: COUNT(CASE WHEN is_high_priority = TRUE THEN 1 END)
      comment: "Count of high-priority enrollments requiring immediate intervention resources"
    - name: "disenrolled_count"
      expr: COUNT(CASE WHEN disenrollment_date IS NOT NULL THEN 1 END)
      comment: "Count of disenrollments for attrition analysis and program retention improvement"
    - name: "distinct_patients_enrolled"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients enrolled across programs - measures population reach"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`patient_risk_stratification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Population health risk stratification metrics for resource allocation, care management targeting, and SDOH-driven intervention planning."
  source: "`healthcare_ecm_v1`.`patient`.`risk_stratification`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category classification (high, moderate, low) for population segmentation"
    - name: "risk_stratification_status"
      expr: risk_stratification_status
      comment: "Current status of the risk assessment"
    - name: "sdoh_domain"
      expr: sdoh_domain
      comment: "Social determinant domain (housing, food, transportation) driving risk"
    - name: "assessment_method"
      expr: assessment_method
      comment: "Method used for risk assessment (algorithmic, clinical, hybrid)"
    - name: "is_current"
      expr: CAST(is_current AS STRING)
      comment: "Whether this is the most current risk assessment for the patient"
    - name: "readmission_risk"
      expr: readmission_risk
      comment: "Readmission risk level for CMS penalty avoidance strategies"
    - name: "ed_utilization_risk"
      expr: ed_utilization_risk
      comment: "ED utilization risk for care management targeting"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of assessment for longitudinal trend analysis"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total risk stratification assessments performed"
    - name: "avg_composite_risk_score"
      expr: AVG(CAST(composite_risk_score AS DOUBLE))
      comment: "Average composite risk score across population - primary indicator for resource planning"
    - name: "avg_geographic_risk_index"
      expr: AVG(CAST(geographic_risk_index AS DOUBLE))
      comment: "Average geographic risk index indicating community-level health disparities"
    - name: "patients_with_care_gaps"
      expr: COUNT(CASE WHEN care_gap_identified = TRUE THEN 1 END)
      comment: "Count of patients with identified care gaps requiring quality measure intervention"
    - name: "food_insecurity_count"
      expr: COUNT(CASE WHEN food_insecurity_flag = TRUE THEN 1 END)
      comment: "Patients flagged for food insecurity - drives SDOH referral resource allocation"
    - name: "housing_instability_count"
      expr: COUNT(CASE WHEN housing_instability_flag = TRUE THEN 1 END)
      comment: "Patients flagged for housing instability - critical SDOH intervention trigger"
    - name: "transportation_barrier_count"
      expr: COUNT(CASE WHEN transportation_barrier_flag = TRUE THEN 1 END)
      comment: "Patients with transportation barriers affecting care access"
    - name: "distinct_patients_assessed"
      expr: COUNT(DISTINCT risk_mpi_record_id)
      comment: "Unique patients with risk assessments - measures screening coverage"
    - name: "avg_screening_completion_pct"
      expr: AVG(CAST(screening_completion_pct AS DOUBLE))
      comment: "Average screening completion percentage indicating assessment thoroughness"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`patient_sdoh_referral_management`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SDOH referral management metrics tracking closed-loop referral effectiveness, community resource utilization, and social needs resolution - critical for CMS VBC and Joint Commission compliance."
  source: "`healthcare_ecm_v1`.`patient`.`referral_management`"
  dimensions:
    - name: "referral_status"
      expr: referral_status
      comment: "Current referral status for pipeline tracking"
    - name: "referral_month"
      expr: DATE_TRUNC('MONTH', referral_date)
      comment: "Month of referral for volume trend analysis"
  measures:
    - name: "total_referrals"
      expr: COUNT(1)
      comment: "Total SDOH referrals initiated - measures screening-to-referral conversion"
    - name: "distinct_community_resources_used"
      expr: COUNT(DISTINCT community_resource_id)
      comment: "Number of distinct community resources engaged - measures network breadth"
    - name: "completed_referrals"
      expr: COUNT(CASE WHEN referral_status = 'completed' THEN 1 END)
      comment: "Count of completed referrals for resolution rate calculation"
    - name: "pending_referrals"
      expr: COUNT(CASE WHEN referral_status = 'pending' OR referral_status = 'in_progress' THEN 1 END)
      comment: "Open referrals requiring follow-up action"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`patient_need_closure_tracking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SDOH need closure tracking metrics measuring time-to-resolution, barrier identification, and intervention effectiveness for social determinant needs - required for Joint Commission accreditation and CMS quality programs."
  source: "`healthcare_ecm_v1`.`patient`.`need_closure_tracking`"
  dimensions:
    - name: "closure_status"
      expr: closure_status
      comment: "Current closure status of the identified need"
    - name: "need_category"
      expr: need_category
      comment: "Category of social need (food, housing, transportation, utilities)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for resource allocation and SLA tracking"
    - name: "risk_stratification_tier"
      expr: risk_stratification_tier
      comment: "Risk tier of the patient for intervention intensity planning"
    - name: "intervention_type"
      expr: intervention_type
      comment: "Type of intervention applied to address the need"
    - name: "patient_engagement_level"
      expr: patient_engagement_level
      comment: "Patient engagement level affecting intervention success probability"
    - name: "overdue_flag"
      expr: CAST(overdue_flag AS STRING)
      comment: "Whether the need closure is overdue per target date"
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month need was identified for volume trending"
  measures:
    - name: "total_needs_tracked"
      expr: COUNT(1)
      comment: "Total social needs being tracked across the patient population"
    - name: "closed_needs"
      expr: COUNT(CASE WHEN closure_status = 'closed' OR actual_closure_date IS NOT NULL THEN 1 END)
      comment: "Needs successfully closed - primary outcome metric for SDOH programs"
    - name: "overdue_needs"
      expr: COUNT(CASE WHEN overdue_flag = TRUE THEN 1 END)
      comment: "Overdue needs requiring escalation - operational efficiency indicator"
    - name: "escalated_needs"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Needs escalated due to barriers - indicates systemic resource gaps"
    - name: "avg_screening_score"
      expr: AVG(CAST(screening_score AS DOUBLE))
      comment: "Average screening score indicating severity of identified needs"
    - name: "distinct_patients_with_needs"
      expr: COUNT(DISTINCT need_mpi_record_id)
      comment: "Unique patients with tracked social needs - measures SDOH burden in population"
    - name: "quality_measure_flagged_count"
      expr: COUNT(CASE WHEN quality_measure_flag = TRUE THEN 1 END)
      comment: "Needs flagged for quality measure reporting - directly impacts VBC performance scores"
    - name: "recurrent_needs"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Recurring needs indicating inadequate initial resolution - drives program redesign"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`patient_chw_interventions`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Community Health Worker intervention metrics tracking outreach effectiveness, patient engagement, and SDOH intervention outcomes - critical for demonstrating CHW program ROI and CMS billing justification."
  source: "`healthcare_ecm_v1`.`patient`.`chw_interventions`"
  dimensions:
    - name: "intervention_type"
      expr: intervention_type
      comment: "Type of CHW intervention for effectiveness comparison"
    - name: "intervention_category"
      expr: intervention_category
      comment: "Category of intervention (navigation, education, resource connection)"
    - name: "sdoh_domain"
      expr: sdoh_domain
      comment: "SDOH domain addressed by the intervention"
    - name: "delivery_mode"
      expr: delivery_mode
      comment: "Mode of delivery (in-person, phone, telehealth) for cost-effectiveness analysis"
    - name: "outcome_status"
      expr: outcome_status
      comment: "Outcome status of the intervention for effectiveness measurement"
    - name: "chw_interventions_status"
      expr: chw_interventions_status
      comment: "Current status of the intervention record"
    - name: "priority"
      expr: priority
      comment: "Priority level of the intervention"
    - name: "intervention_month"
      expr: DATE_TRUNC('MONTH', intervention_date)
      comment: "Month of intervention for volume and seasonal analysis"
  measures:
    - name: "total_interventions"
      expr: COUNT(1)
      comment: "Total CHW interventions performed - measures program activity volume"
    - name: "billable_interventions"
      expr: COUNT(CASE WHEN billable_flag = TRUE THEN 1 END)
      comment: "Billable CHW interventions - directly measures revenue-generating program activity"
    - name: "avg_risk_stratification_score"
      expr: AVG(CAST(risk_stratification_score AS DOUBLE))
      comment: "Average risk score of patients receiving CHW interventions - validates targeting effectiveness"
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_required = TRUE THEN 1 END)
      comment: "Interventions requiring follow-up - indicates complexity and resource planning needs"
    - name: "no_show_count"
      expr: COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END)
      comment: "No-show interventions - measures patient engagement barriers and scheduling effectiveness"
    - name: "consent_obtained_count"
      expr: COUNT(CASE WHEN consent_obtained = TRUE THEN 1 END)
      comment: "Interventions with consent obtained - compliance tracking for data sharing"
    - name: "distinct_patients_served"
      expr: COUNT(DISTINCT chw_patient_mpi_record_id)
      comment: "Unique patients served by CHW program - measures population reach"
    - name: "quality_measure_interventions"
      expr: COUNT(CASE WHEN quality_measure_flag = TRUE THEN 1 END)
      comment: "Interventions linked to quality measures - demonstrates VBC program contribution"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`patient_referral_management`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient referral management metrics tracking referral pipeline, closed-loop completion rates, and time-to-resolution for care coordination effectiveness and network leakage prevention."
  source: "`healthcare_ecm_v1`.`patient`.`referral_management`"
  dimensions:
    - name: "referral_status"
      expr: referral_status
      comment: "Current referral status for pipeline management"
    - name: "referral_type"
      expr: referral_type
      comment: "Type of referral (specialist, SDOH, post-acute) for volume analysis"
    - name: "sdoh_domain"
      expr: sdoh_domain
      comment: "SDOH domain if referral is social-needs related"
    - name: "priority"
      expr: priority
      comment: "Referral priority for SLA tracking"
    - name: "risk_stratification_level"
      expr: risk_stratification_level
      comment: "Patient risk level driving referral urgency"
    - name: "need_closure_status"
      expr: need_closure_status
      comment: "Whether the underlying need has been resolved"
    - name: "is_closed_loop"
      expr: CAST(is_closed_loop AS STRING)
      comment: "Whether referral achieved closed-loop confirmation"
    - name: "referral_month"
      expr: DATE_TRUNC('MONTH', referral_date)
      comment: "Month of referral for trend analysis"
  measures:
    - name: "total_referrals"
      expr: COUNT(1)
      comment: "Total referrals managed - measures care coordination volume"
    - name: "closed_loop_referrals"
      expr: COUNT(CASE WHEN is_closed_loop = TRUE THEN 1 END)
      comment: "Referrals with confirmed closed-loop completion - gold standard for care coordination quality"
    - name: "distinct_patients_referred"
      expr: COUNT(DISTINCT referral_mpi_record_id)
      comment: "Unique patients with managed referrals"
    - name: "quality_measure_referrals"
      expr: COUNT(CASE WHEN quality_measure_flag = TRUE THEN 1 END)
      comment: "Referrals linked to quality measures - impacts VBC performance scores"
    - name: "consent_obtained_referrals"
      expr: COUNT(CASE WHEN consent_obtained = TRUE THEN 1 END)
      comment: "Referrals with proper consent documentation - compliance metric"
    - name: "transportation_barrier_referrals"
      expr: COUNT(CASE WHEN transportation_barrier = TRUE THEN 1 END)
      comment: "Referrals with transportation barriers - identifies access equity issues"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`patient_quality_measure_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient-level quality measure evaluation metrics for HEDIS, MIPS, and VBC program performance tracking - directly impacts reimbursement and star ratings."
  source: "`healthcare_ecm_v1`.`patient`.`quality_measure_evaluation`"
  dimensions:
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Current evaluation status of the quality measure"
    - name: "gap_status"
      expr: gap_status
      comment: "Care gap status (open, closed, excluded) for intervention targeting"
    - name: "gap_closure_status"
      expr: gap_closure_status
      comment: "Whether the care gap has been closed"
    - name: "population_category"
      expr: population_category
      comment: "Population category for measure stratification"
    - name: "denominator_status"
      expr: denominator_status
      comment: "Whether patient is in measure denominator"
    - name: "numerator_status"
      expr: numerator_status
      comment: "Whether patient meets numerator criteria"
    - name: "compliance_indicator"
      expr: compliance_indicator
      comment: "Compliance indicator for regulatory reporting"
    - name: "measurement_period_start"
      expr: DATE_TRUNC('QUARTER', measurement_period_start)
      comment: "Measurement period for performance trending"
  measures:
    - name: "total_evaluations"
      expr: COUNT(1)
      comment: "Total quality measure evaluations performed"
    - name: "open_care_gaps"
      expr: COUNT(CASE WHEN gap_status = 'open' THEN 1 END)
      comment: "Open care gaps requiring intervention - primary driver of quality improvement initiatives"
    - name: "closed_care_gaps"
      expr: COUNT(CASE WHEN gap_closure_status = 'closed' OR gap_status = 'closed' THEN 1 END)
      comment: "Closed care gaps - measures quality program effectiveness"
    - name: "exempt_patients"
      expr: COUNT(CASE WHEN is_exempt = TRUE THEN 1 END)
      comment: "Patients exempt from measures - monitors exclusion patterns for gaming detection"
    - name: "avg_score_value"
      expr: AVG(CAST(score_value AS DOUBLE))
      comment: "Average quality measure score - composite performance indicator"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of evaluated patients for acuity-adjusted performance analysis"
    - name: "distinct_patients_evaluated"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients with quality evaluations - measures attribution panel coverage"
    - name: "outreach_success_count"
      expr: COUNT(CASE WHEN outreach_success_flag = TRUE THEN 1 END)
      comment: "Successful outreach attempts for gap closure - measures engagement effectiveness"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`patient_sdoh_risk_stratification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SDOH-specific risk stratification metrics measuring social vulnerability, health equity indicators, and community-level risk factors for population health resource allocation."
  source: "`healthcare_ecm_v1`.`patient`.`risk_stratification`"
  dimensions:
    - name: "is_current"
      expr: CAST(is_current AS STRING)
      comment: "Whether this is the current risk assessment"
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Assessment month for trend analysis"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total SDOH risk stratification assessments performed"
    - name: "food_insecurity_flagged"
      expr: COUNT(CASE WHEN food_insecurity_flag = TRUE THEN 1 END)
      comment: "Patients flagged for food insecurity - drives community resource partnerships"
    - name: "housing_instability_flagged"
      expr: COUNT(CASE WHEN housing_instability_flag = TRUE THEN 1 END)
      comment: "Patients flagged for housing instability - critical for health equity initiatives"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`patient_communication_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient communication campaign effectiveness metrics for outreach ROI, engagement optimization, and population health messaging strategy."
  source: "`healthcare_ecm_v1`.`patient`.`communication_campaign`"
  dimensions:
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (preventive, recall, wellness, gap closure)"
    - name: "channel"
      expr: channel
      comment: "Communication channel (email, SMS, phone, portal) for channel effectiveness comparison"
    - name: "communication_campaign_status"
      expr: communication_campaign_status
      comment: "Current campaign status for pipeline management"
    - name: "target_audience"
      expr: target_audience
      comment: "Target audience segment for ROI analysis by cohort"
    - name: "language"
      expr: language
      comment: "Campaign language for health equity and access analysis"
    - name: "priority"
      expr: priority
      comment: "Campaign priority level"
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total communication campaigns - measures outreach program activity"
    - name: "total_messages_sent"
      expr: SUM(CAST(total_messages_sent AS DOUBLE))
      comment: "Total messages sent across campaigns - measures outreach volume"
    - name: "total_actual_reach"
      expr: SUM(CAST(actual_reach AS DOUBLE))
      comment: "Total patients actually reached - measures effective penetration"
    - name: "avg_click_through_rate"
      expr: AVG(CAST(click_through_rate AS DOUBLE))
      comment: "Average click-through rate - measures content engagement effectiveness"
    - name: "avg_response_rate"
      expr: AVG(CAST(response_rate AS DOUBLE))
      comment: "Average response rate - measures patient activation from outreach"
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average conversion rate - measures campaign goal achievement (appointment scheduled, gap closed)"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total campaign budget for ROI calculation"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`patient_mpi_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Master Patient Index integrity and coverage metrics for enterprise patient identity management, data quality governance, and duplicate detection effectiveness."
  source: "`healthcare_ecm_v1`.`patient`.`mpi_record`"
  dimensions:
    - name: "record_status"
      expr: record_status
      comment: "MPI record status (active, merged, inactive) for data quality monitoring"
    - name: "source_system"
      expr: source_system
      comment: "Source system of the patient record for integration coverage analysis"
    - name: "consent_status"
      expr: consent_status
      comment: "Patient consent status for data governance compliance"
    - name: "duplicate_flag"
      expr: CAST(duplicate_flag AS STRING)
      comment: "Whether record is flagged as potential duplicate"
    - name: "deceased_flag"
      expr: CAST(deceased_flag AS STRING)
      comment: "Deceased status for population denominator accuracy"
    - name: "gender"
      expr: gender
      comment: "Patient gender for demographic analysis and health equity reporting"
  measures:
    - name: "total_mpi_records"
      expr: COUNT(1)
      comment: "Total MPI records - measures enterprise patient registry size"
    - name: "active_records"
      expr: COUNT(CASE WHEN record_status = 'active' THEN 1 END)
      comment: "Active MPI records representing current patient population"
    - name: "duplicate_flagged_records"
      expr: COUNT(CASE WHEN duplicate_flag = TRUE THEN 1 END)
      comment: "Records flagged as potential duplicates - data quality indicator requiring resolution"
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average MPI match confidence score - measures identity resolution algorithm effectiveness"
    - name: "deceased_patients"
      expr: COUNT(CASE WHEN deceased_flag = TRUE THEN 1 END)
      comment: "Deceased patient count for accurate population denominator management"
    - name: "consented_patients"
      expr: COUNT(CASE WHEN consent_status = 'active' OR consent_status = 'granted' THEN 1 END)
      comment: "Patients with active consent - measures data sharing readiness for HIE and analytics"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`patient_pcp_attribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PCP attribution metrics for value-based care panel management, provider capacity planning, and attribution accuracy monitoring."
  source: "`healthcare_ecm_v1`.`patient`.`pcp_attribution`"
  dimensions:
    - name: "attribution_status"
      expr: attribution_status
      comment: "Current attribution status (active, expired, disputed)"
    - name: "attribution_method"
      expr: attribution_method
      comment: "Method used for attribution (claims-based, prospective, hybrid)"
    - name: "attribution_type"
      expr: attribution_type
      comment: "Type of attribution (primary, secondary)"
    - name: "plan_type"
      expr: plan_type
      comment: "Insurance plan type for payer-specific attribution analysis"
    - name: "attribution_source"
      expr: attribution_source
      comment: "Source of attribution data (payer file, internal algorithm)"
  measures:
    - name: "total_attributions"
      expr: COUNT(1)
      comment: "Total PCP attributions - measures panel assignment coverage"
    - name: "active_attributions"
      expr: COUNT(CASE WHEN attribution_status = 'active' THEN 1 END)
      comment: "Currently active attributions representing managed panel size"
    - name: "avg_attribution_confidence"
      expr: AVG(CAST(attribution_confidence_score AS DOUBLE))
      comment: "Average attribution confidence score - measures algorithm accuracy and dispute risk"
    - name: "distinct_patients_attributed"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients with PCP attribution - measures population coverage under VBC"
    - name: "distinct_panels"
      expr: COUNT(DISTINCT attribution_panel_id)
      comment: "Number of distinct attribution panels - measures provider network breadth"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`patient_financial_assistance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient financial assistance program metrics for charity care tracking, community benefit reporting, and financial counseling effectiveness."
  source: "`healthcare_ecm_v1`.`patient`.`financial_assistance`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Application status for pipeline management"
    - name: "program_type"
      expr: program_type
      comment: "Type of financial assistance program (charity care, sliding scale, Medicaid presumptive)"
    - name: "income_verification_method"
      expr: income_verification_method
      comment: "Method used to verify income for audit compliance"
    - name: "application_year"
      expr: YEAR(application_date)
      comment: "Year of application for trend analysis and IRS reporting"
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total financial assistance applications - measures community need volume"
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_assistance_amount AS DOUBLE))
      comment: "Total approved assistance amount - key metric for IRS Form 990 Schedule H community benefit reporting"
    - name: "total_requested_amount"
      expr: SUM(CAST(requested_assistance_amount AS DOUBLE))
      comment: "Total requested assistance amount - measures unmet financial need in community"
    - name: "avg_fpl_percentage"
      expr: AVG(CAST(federal_poverty_level_percentage AS DOUBLE))
      comment: "Average FPL percentage of applicants - indicates community economic vulnerability"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total billing adjustments from financial assistance - impacts net revenue"
    - name: "distinct_patients_assisted"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients receiving financial assistance - measures program reach"
$$;