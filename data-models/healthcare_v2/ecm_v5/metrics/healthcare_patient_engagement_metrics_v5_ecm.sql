-- Metric views for domain: patient_engagement | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`patient_engagement_rpm_device_readings`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metric view for Remote Patient Monitoring (RPM) device readings - tracks device utilization, program engagement, and cross-domain linkage for chronic disease management and behavioral health integration."
  source: "`healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_rpm_device_readings`"
  dimensions:
    - name: "behavioral_health_mat_treatment_id"
      expr: behavioral_health_mat_treatment_id
      comment: "Links RPM readings to Medication-Assisted Treatment episodes for integrated behavioral health monitoring"
    - name: "post_acute_episode_id"
      expr: post_acute_episode_id
      comment: "Links RPM readings to post-acute care episodes for transitional care monitoring"
    - name: "has_mat_treatment_link"
      expr: CASE WHEN behavioral_health_mat_treatment_id IS NOT NULL THEN 'Yes' ELSE 'No' END
      comment: "Indicates whether the RPM reading is associated with a MAT treatment program"
    - name: "has_post_acute_link"
      expr: CASE WHEN post_acute_episode_id IS NOT NULL THEN 'Yes' ELSE 'No' END
      comment: "Indicates whether the RPM reading is associated with a post-acute care episode"
  measures:
    - name: "total_rpm_readings"
      expr: COUNT(1)
      comment: "Total number of RPM device readings captured - baseline volume metric for remote monitoring program scale"
    - name: "mat_linked_readings_count"
      expr: COUNT(CASE WHEN behavioral_health_mat_treatment_id IS NOT NULL THEN 1 END)
      comment: "Count of RPM readings linked to MAT treatment - measures integration of remote monitoring with substance use disorder treatment programs"
    - name: "post_acute_linked_readings_count"
      expr: COUNT(CASE WHEN post_acute_episode_id IS NOT NULL THEN 1 END)
      comment: "Count of RPM readings linked to post-acute episodes - measures transitional care monitoring engagement"
    - name: "distinct_mat_treatments_monitored"
      expr: COUNT(DISTINCT behavioral_health_mat_treatment_id)
      comment: "Number of distinct MAT treatment episodes with active RPM monitoring - measures breadth of behavioral health remote monitoring coverage"
    - name: "distinct_post_acute_episodes_monitored"
      expr: COUNT(DISTINCT post_acute_episode_id)
      comment: "Number of distinct post-acute episodes with active RPM monitoring - measures transitional care program reach"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`patient_engagement_prom_responses`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metric view for Patient-Reported Outcome Measure (PROM) responses - tracks patient engagement with standardized outcome questionnaires across behavioral health, post-acute care, and quality programs."
  source: "`healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_prom_responses`"
  dimensions:
    - name: "behavioral_health_psychiatric_assessment_id"
      expr: behavioral_health_psychiatric_assessment_id
      comment: "Links PROM response to psychiatric assessment (PHQ-9, GAD-7, etc.) for behavioral health outcome tracking"
    - name: "behavioral_health_sud_episode_id"
      expr: behavioral_health_sud_episode_id
      comment: "Links PROM response to substance use disorder treatment episode for recovery outcome measurement"
    - name: "clinical_ai_care_gap_id"
      expr: clinical_ai_care_gap_id
      comment: "Links PROM response to an identified care gap for quality measure closure tracking"
    - name: "post_acute_episode_id"
      expr: post_acute_episode_id
      comment: "Links PROM response to post-acute care episode for functional recovery tracking"
    - name: "therapy_session_id"
      expr: therapy_session_id
      comment: "Links PROM response to a specific therapy session for session-level outcome measurement"
    - name: "has_behavioral_health_context"
      expr: CASE WHEN behavioral_health_psychiatric_assessment_id IS NOT NULL OR behavioral_health_sud_episode_id IS NOT NULL OR therapy_session_id IS NOT NULL THEN 'Yes' ELSE 'No' END
      comment: "Indicates whether the PROM response is associated with any behavioral health program"
    - name: "has_care_gap_link"
      expr: CASE WHEN clinical_ai_care_gap_id IS NOT NULL THEN 'Yes' ELSE 'No' END
      comment: "Indicates whether the PROM response addresses an identified AI-detected care gap"
  measures:
    - name: "total_prom_responses"
      expr: COUNT(1)
      comment: "Total PROM responses collected - measures overall patient engagement with outcome reporting"
    - name: "behavioral_health_prom_count"
      expr: COUNT(CASE WHEN behavioral_health_psychiatric_assessment_id IS NOT NULL OR behavioral_health_sud_episode_id IS NOT NULL OR therapy_session_id IS NOT NULL THEN 1 END)
      comment: "PROM responses linked to behavioral health programs - measures patient engagement in mental health and SUD outcome reporting"
    - name: "care_gap_closure_prom_count"
      expr: COUNT(CASE WHEN clinical_ai_care_gap_id IS NOT NULL THEN 1 END)
      comment: "PROM responses that address identified care gaps - measures effectiveness of patient engagement in quality measure closure"
    - name: "distinct_psychiatric_assessments_with_proms"
      expr: COUNT(DISTINCT behavioral_health_psychiatric_assessment_id)
      comment: "Number of distinct psychiatric assessments with patient-reported outcomes - measures depth of behavioral health outcome data collection"
    - name: "distinct_therapy_sessions_with_proms"
      expr: COUNT(DISTINCT therapy_session_id)
      comment: "Number of distinct therapy sessions with PROM data - measures therapy outcome measurement coverage"
    - name: "distinct_care_gaps_addressed"
      expr: COUNT(DISTINCT clinical_ai_care_gap_id)
      comment: "Number of distinct care gaps addressed by PROM responses - measures patient engagement contribution to quality improvement"
    - name: "post_acute_prom_count"
      expr: COUNT(CASE WHEN post_acute_episode_id IS NOT NULL THEN 1 END)
      comment: "PROM responses linked to post-acute care episodes - measures functional recovery outcome reporting engagement"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`patient_engagement_portal_engagement_events`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metric view for patient portal engagement events - tracks digital health engagement, consent-linked interactions, and care gap awareness through portal activity."
  source: "`healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_portal_engagement_events`"
  dimensions:
    - name: "behavioral_health_cfr42_consent_id"
      expr: behavioral_health_cfr42_consent_id
      comment: "Links portal event to 42 CFR Part 2 consent workflow - tracks patient engagement with behavioral health consent management"
    - name: "clinical_ai_care_gap_id"
      expr: clinical_ai_care_gap_id
      comment: "Links portal event to AI-identified care gap - tracks patient awareness and action on quality measure gaps"
    - name: "has_cfr42_consent_context"
      expr: CASE WHEN behavioral_health_cfr42_consent_id IS NOT NULL THEN 'Yes' ELSE 'No' END
      comment: "Indicates whether the portal event involves 42 CFR Part 2 consent management"
    - name: "has_care_gap_context"
      expr: CASE WHEN clinical_ai_care_gap_id IS NOT NULL THEN 'Yes' ELSE 'No' END
      comment: "Indicates whether the portal event is related to a care gap notification or action"
  measures:
    - name: "total_portal_events"
      expr: COUNT(1)
      comment: "Total portal engagement events - baseline measure of digital health platform utilization"
    - name: "cfr42_consent_events_count"
      expr: COUNT(CASE WHEN behavioral_health_cfr42_consent_id IS NOT NULL THEN 1 END)
      comment: "Portal events involving 42 CFR Part 2 consent management - measures patient self-service engagement with behavioral health privacy controls"
    - name: "care_gap_engagement_events_count"
      expr: COUNT(CASE WHEN clinical_ai_care_gap_id IS NOT NULL THEN 1 END)
      comment: "Portal events linked to care gap notifications - measures patient engagement with quality improvement outreach"
    - name: "distinct_care_gaps_engaged"
      expr: COUNT(DISTINCT clinical_ai_care_gap_id)
      comment: "Number of distinct care gaps patients engaged with through the portal - measures breadth of quality gap awareness"
    - name: "distinct_cfr42_consents_managed"
      expr: COUNT(DISTINCT behavioral_health_cfr42_consent_id)
      comment: "Number of distinct 42 CFR Part 2 consents managed through portal - measures patient autonomy in behavioral health data sharing decisions"
$$;