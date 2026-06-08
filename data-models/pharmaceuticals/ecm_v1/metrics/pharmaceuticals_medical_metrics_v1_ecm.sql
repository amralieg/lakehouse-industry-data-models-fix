-- Metric views for domain: medical | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 17:46:18

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`medical_affairs_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic medical affairs planning metrics tracking budget allocation, evidence generation, and KOL engagement across therapeutic areas and development phases"
  source: "`pharmaceuticals_ecm`.`medical`.`affairs_plan`"
  dimensions:
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area focus of the medical affairs plan"
    - name: "development_phase"
      expr: development_phase
      comment: "Development phase of the compound or product"
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the medical affairs plan"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the plan"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the medical affairs plan"
    - name: "indication"
      expr: indication
      comment: "Disease indication targeted by the plan"
    - name: "evidence_generation_priority"
      expr: evidence_generation_priority
      comment: "Priority level for evidence generation activities"
    - name: "heor_priority_flag"
      expr: heor_priority_flag
      comment: "Flag indicating if HEOR is a priority for this plan"
    - name: "launch_readiness_flag"
      expr: launch_readiness_flag
      comment: "Flag indicating if plan is focused on launch readiness"
  measures:
    - name: "total_medical_affairs_budget_usd"
      expr: SUM(CAST(total_budget_usd AS DOUBLE))
      comment: "Total medical affairs budget allocated across all plans in USD"
    - name: "total_evidence_generation_budget_usd"
      expr: SUM(CAST(evidence_generation_budget_usd AS DOUBLE))
      comment: "Total budget allocated for evidence generation activities in USD"
    - name: "total_kol_engagement_budget_usd"
      expr: SUM(CAST(kol_engagement_budget_usd AS DOUBLE))
      comment: "Total budget allocated for KOL engagement activities in USD"
    - name: "total_publication_budget_usd"
      expr: SUM(CAST(publication_budget_usd AS DOUBLE))
      comment: "Total budget allocated for publication planning and execution in USD"
    - name: "avg_evidence_generation_budget_usd"
      expr: AVG(CAST(evidence_generation_budget_usd AS DOUBLE))
      comment: "Average evidence generation budget per plan in USD"
    - name: "evidence_generation_budget_pct"
      expr: ROUND(100.0 * SUM(CAST(evidence_generation_budget_usd AS DOUBLE)) / NULLIF(SUM(CAST(total_budget_usd AS DOUBLE)), 0), 2)
      comment: "Evidence generation budget as percentage of total medical affairs budget"
    - name: "kol_engagement_budget_pct"
      expr: ROUND(100.0 * SUM(CAST(kol_engagement_budget_usd AS DOUBLE)) / NULLIF(SUM(CAST(total_budget_usd AS DOUBLE)), 0), 2)
      comment: "KOL engagement budget as percentage of total medical affairs budget"
    - name: "publication_budget_pct"
      expr: ROUND(100.0 * SUM(CAST(publication_budget_usd AS DOUBLE)) / NULLIF(SUM(CAST(total_budget_usd AS DOUBLE)), 0), 2)
      comment: "Publication budget as percentage of total medical affairs budget"
    - name: "plan_count"
      expr: COUNT(DISTINCT affairs_plan_id)
      comment: "Number of distinct medical affairs plans"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`medical_congress_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Congress event participation and ROI metrics tracking spend efficiency, KOL engagement, and scientific output at medical congresses"
  source: "`pharmaceuticals_ecm`.`medical`.`congress_event`"
  dimensions:
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area focus of the congress event"
    - name: "congress_type"
      expr: congress_type
      comment: "Type of congress event"
    - name: "congress_status"
      expr: congress_status
      comment: "Current status of the congress event"
    - name: "strategic_importance_tier"
      expr: strategic_importance_tier
      comment: "Strategic importance tier of the congress"
    - name: "company_participation_type"
      expr: company_participation_type
      comment: "Type of company participation at the congress"
    - name: "has_booth_presence"
      expr: has_booth_presence
      comment: "Flag indicating if company has booth presence"
    - name: "has_satellite_symposium"
      expr: has_satellite_symposium
      comment: "Flag indicating if company has satellite symposium"
    - name: "congress_format"
      expr: congress_format
      comment: "Format of the congress (virtual, in-person, hybrid)"
    - name: "event_year"
      expr: YEAR(start_date)
      comment: "Year of the congress event"
  measures:
    - name: "total_planned_budget_usd"
      expr: SUM(CAST(planned_budget_usd AS DOUBLE))
      comment: "Total planned budget for congress events in USD"
    - name: "total_actual_spend_usd"
      expr: SUM(CAST(actual_spend_usd AS DOUBLE))
      comment: "Total actual spend on congress events in USD"
    - name: "total_hcp_transfer_of_value_usd"
      expr: SUM(CAST(hcp_transfer_of_value_usd AS DOUBLE))
      comment: "Total transfer of value to HCPs at congress events in USD"
    - name: "avg_actual_spend_per_event_usd"
      expr: AVG(CAST(actual_spend_usd AS DOUBLE))
      comment: "Average actual spend per congress event in USD"
    - name: "budget_variance_usd"
      expr: SUM((CAST(actual_spend_usd AS DOUBLE)) - (CAST(planned_budget_usd AS DOUBLE)))
      comment: "Total budget variance (actual minus planned) across congress events in USD"
    - name: "budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_usd AS DOUBLE)) / NULLIF(SUM(CAST(planned_budget_usd AS DOUBLE)), 0), 2)
      comment: "Budget utilization rate as percentage of planned budget"
    - name: "total_kol_engagement_count"
      expr: SUM(CAST(kol_engagement_count AS DOUBLE))
      comment: "Total number of KOL engagements across congress events"
    - name: "total_oral_presentation_count"
      expr: SUM(CAST(oral_presentation_count AS DOUBLE))
      comment: "Total number of oral presentations delivered at congress events"
    - name: "total_poster_presentation_count"
      expr: SUM(CAST(poster_presentation_count AS DOUBLE))
      comment: "Total number of poster presentations at congress events"
    - name: "avg_kol_engagement_per_event"
      expr: AVG(CAST(kol_engagement_count AS DOUBLE))
      comment: "Average number of KOL engagements per congress event"
    - name: "congress_event_count"
      expr: COUNT(DISTINCT congress_event_id)
      comment: "Number of distinct congress events"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`medical_iit_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Investigator-initiated trial submission metrics tracking approval rates, funding efficiency, and study execution performance"
  source: "`pharmaceuticals_ecm`.`medical`.`iit_submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the IIT submission"
    - name: "review_decision"
      expr: review_decision
      comment: "Review decision outcome for the IIT submission"
    - name: "study_phase"
      expr: study_phase
      comment: "Clinical study phase of the IIT"
    - name: "study_type"
      expr: study_type
      comment: "Type of study design for the IIT"
    - name: "indication"
      expr: indication
      comment: "Disease indication being studied"
    - name: "irb_approval_status"
      expr: irb_approval_status
      comment: "IRB approval status for the IIT"
    - name: "compound_supply_requested"
      expr: compound_supply_requested
      comment: "Flag indicating if compound supply was requested"
    - name: "publication_rights_agreed"
      expr: publication_rights_agreed
      comment: "Flag indicating if publication rights were agreed"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year of IIT submission"
  measures:
    - name: "total_grant_amount_usd"
      expr: SUM(CAST(grant_amount AS DOUBLE))
      comment: "Total grant amount awarded for IIT submissions in USD"
    - name: "total_disbursed_amount_usd"
      expr: SUM(CAST(disbursed_amount AS DOUBLE))
      comment: "Total amount disbursed to IIT investigators in USD"
    - name: "avg_grant_amount_usd"
      expr: AVG(CAST(grant_amount AS DOUBLE))
      comment: "Average grant amount per IIT submission in USD"
    - name: "disbursement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(disbursed_amount AS DOUBLE)) / NULLIF(SUM(CAST(grant_amount AS DOUBLE)), 0), 2)
      comment: "Disbursement rate as percentage of total grant amount"
    - name: "total_compound_supply_quantity"
      expr: SUM(CAST(compound_supply_quantity AS DOUBLE))
      comment: "Total quantity of compound supplied to IIT studies"
    - name: "iit_submission_count"
      expr: COUNT(DISTINCT iit_submission_id)
      comment: "Number of distinct IIT submissions"
    - name: "approved_iit_count"
      expr: COUNT(DISTINCT CASE WHEN review_decision = 'Approved' THEN iit_submission_id END)
      comment: "Number of approved IIT submissions"
    - name: "iit_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN review_decision = 'Approved' THEN iit_submission_id END) / NULLIF(COUNT(DISTINCT iit_submission_id), 0), 2)
      comment: "IIT approval rate as percentage of total submissions"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`medical_publication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medical publication performance metrics tracking publication output, impact, and strategic alignment across therapeutic areas"
  source: "`pharmaceuticals_ecm`.`medical`.`medical_publication`"
  dimensions:
    - name: "publication_status"
      expr: publication_status
      comment: "Current status of the medical publication"
    - name: "publication_type"
      expr: publication_type
      comment: "Type of medical publication"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the publication"
    - name: "company_sponsored_flag"
      expr: company_sponsored_flag
      comment: "Flag indicating if publication is company-sponsored"
    - name: "heor_rwe_flag"
      expr: heor_rwe_flag
      comment: "Flag indicating if publication contains HEOR or RWE content"
    - name: "iit_iss_flag"
      expr: iit_iss_flag
      comment: "Flag indicating if publication is related to IIT or ISS"
    - name: "peer_reviewed_flag"
      expr: peer_reviewed_flag
      comment: "Flag indicating if publication is peer-reviewed"
    - name: "open_access_flag"
      expr: open_access_flag
      comment: "Flag indicating if publication is open access"
    - name: "publication_year"
      expr: YEAR(publication_date)
      comment: "Year of publication"
  measures:
    - name: "publication_count"
      expr: COUNT(DISTINCT medical_publication_id)
      comment: "Number of distinct medical publications"
    - name: "total_citation_count"
      expr: SUM(CAST(citation_count AS DOUBLE))
      comment: "Total number of citations across all publications"
    - name: "avg_citation_count"
      expr: AVG(CAST(citation_count AS DOUBLE))
      comment: "Average number of citations per publication"
    - name: "avg_impact_factor"
      expr: AVG(CAST(impact_factor AS DOUBLE))
      comment: "Average journal impact factor across publications"
    - name: "peer_reviewed_publication_count"
      expr: COUNT(DISTINCT CASE WHEN peer_reviewed_flag = TRUE THEN medical_publication_id END)
      comment: "Number of peer-reviewed publications"
    - name: "peer_reviewed_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN peer_reviewed_flag = TRUE THEN medical_publication_id END) / NULLIF(COUNT(DISTINCT medical_publication_id), 0), 2)
      comment: "Peer-reviewed publication rate as percentage of total publications"
    - name: "open_access_publication_count"
      expr: COUNT(DISTINCT CASE WHEN open_access_flag = TRUE THEN medical_publication_id END)
      comment: "Number of open access publications"
    - name: "open_access_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN open_access_flag = TRUE THEN medical_publication_id END) / NULLIF(COUNT(DISTINCT medical_publication_id), 0), 2)
      comment: "Open access publication rate as percentage of total publications"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`medical_msl_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medical Science Liaison engagement metrics tracking HCP interaction quality, compliance, and scientific exchange effectiveness"
  source: "`pharmaceuticals_ecm`.`medical`.`msl_engagement`"
  dimensions:
    - name: "engagement_status"
      expr: engagement_status
      comment: "Current status of the MSL engagement"
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of MSL interaction with HCP"
    - name: "channel"
      expr: channel
      comment: "Channel through which engagement occurred"
    - name: "kol_tier"
      expr: kol_tier
      comment: "KOL tier of the engaged HCP"
    - name: "hcp_role"
      expr: hcp_role
      comment: "Role of the engaged healthcare professional"
    - name: "scientific_topic"
      expr: scientific_topic
      comment: "Scientific topic discussed during engagement"
    - name: "heor_topic_discussed"
      expr: heor_topic_discussed
      comment: "Flag indicating if HEOR topics were discussed"
    - name: "iit_iss_discussed"
      expr: iit_iss_discussed
      comment: "Flag indicating if IIT or ISS topics were discussed"
    - name: "adverse_event_reported"
      expr: adverse_event_reported
      comment: "Flag indicating if adverse event was reported during engagement"
    - name: "medical_inquiry_received"
      expr: medical_inquiry_received
      comment: "Flag indicating if medical inquiry was received"
    - name: "compliance_attestation"
      expr: compliance_attestation
      comment: "Flag indicating if compliance attestation was completed"
    - name: "engagement_year"
      expr: YEAR(engagement_date)
      comment: "Year of MSL engagement"
  measures:
    - name: "msl_engagement_count"
      expr: COUNT(DISTINCT msl_engagement_id)
      comment: "Number of distinct MSL engagements"
    - name: "total_transfer_of_value_usd"
      expr: SUM(CAST(transfer_of_value_amount AS DOUBLE))
      comment: "Total transfer of value to HCPs from MSL engagements in USD"
    - name: "avg_transfer_of_value_usd"
      expr: AVG(CAST(transfer_of_value_amount AS DOUBLE))
      comment: "Average transfer of value per MSL engagement in USD"
    - name: "total_engagement_duration_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total duration of MSL engagements in minutes"
    - name: "avg_engagement_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration per MSL engagement in minutes"
    - name: "adverse_event_engagement_count"
      expr: COUNT(DISTINCT CASE WHEN adverse_event_reported = TRUE THEN msl_engagement_id END)
      comment: "Number of MSL engagements where adverse events were reported"
    - name: "adverse_event_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN adverse_event_reported = TRUE THEN msl_engagement_id END) / NULLIF(COUNT(DISTINCT msl_engagement_id), 0), 2)
      comment: "Adverse event reporting rate as percentage of total MSL engagements"
    - name: "medical_inquiry_engagement_count"
      expr: COUNT(DISTINCT CASE WHEN medical_inquiry_received = TRUE THEN msl_engagement_id END)
      comment: "Number of MSL engagements where medical inquiries were received"
    - name: "medical_inquiry_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN medical_inquiry_received = TRUE THEN msl_engagement_id END) / NULLIF(COUNT(DISTINCT msl_engagement_id), 0), 2)
      comment: "Medical inquiry rate as percentage of total MSL engagements"
    - name: "compliance_attestation_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN compliance_attestation = TRUE THEN msl_engagement_id END) / NULLIF(COUNT(DISTINCT msl_engagement_id), 0), 2)
      comment: "Compliance attestation rate as percentage of total MSL engagements"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`medical_heor_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Health Economics and Outcomes Research study metrics tracking study execution, budget efficiency, and real-world evidence generation"
  source: "`pharmaceuticals_ecm`.`medical`.`medical_heor_study`"
  dimensions:
    - name: "study_status"
      expr: study_status
      comment: "Current status of the HEOR study"
    - name: "study_type"
      expr: study_type
      comment: "Type of HEOR study"
    - name: "study_design"
      expr: study_design
      comment: "Study design methodology"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the HEOR study"
    - name: "indication"
      expr: indication
      comment: "Disease indication being studied"
    - name: "heor_model_type"
      expr: heor_model_type
      comment: "Type of HEOR model used"
    - name: "data_source_type"
      expr: data_source_type
      comment: "Type of data source for the study"
    - name: "rwe_study_flag"
      expr: rwe_study_flag
      comment: "Flag indicating if study is real-world evidence focused"
    - name: "publication_status"
      expr: publication_status
      comment: "Publication status of the study results"
    - name: "irb_approval_status"
      expr: irb_approval_status
      comment: "IRB approval status for the study"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the HEOR study"
  measures:
    - name: "heor_study_count"
      expr: COUNT(DISTINCT medical_heor_study_id)
      comment: "Number of distinct HEOR studies"
    - name: "total_heor_budget_usd"
      expr: SUM(CAST(total_budget_usd AS DOUBLE))
      comment: "Total budget for HEOR studies in USD"
    - name: "total_heor_actual_spend_usd"
      expr: SUM(CAST(actual_spend_usd AS DOUBLE))
      comment: "Total actual spend on HEOR studies in USD"
    - name: "avg_heor_budget_usd"
      expr: AVG(CAST(total_budget_usd AS DOUBLE))
      comment: "Average budget per HEOR study in USD"
    - name: "heor_budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_usd AS DOUBLE)) / NULLIF(SUM(CAST(total_budget_usd AS DOUBLE)), 0), 2)
      comment: "HEOR budget utilization rate as percentage of total budget"
    - name: "total_planned_sample_size"
      expr: SUM(CAST(planned_sample_size AS DOUBLE))
      comment: "Total planned sample size across HEOR studies"
    - name: "total_actual_sample_size"
      expr: SUM(CAST(actual_sample_size AS DOUBLE))
      comment: "Total actual sample size achieved across HEOR studies"
    - name: "avg_planned_sample_size"
      expr: AVG(CAST(planned_sample_size AS DOUBLE))
      comment: "Average planned sample size per HEOR study"
    - name: "rwe_study_count"
      expr: COUNT(DISTINCT CASE WHEN rwe_study_flag = TRUE THEN medical_heor_study_id END)
      comment: "Number of real-world evidence focused HEOR studies"
    - name: "rwe_study_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN rwe_study_flag = TRUE THEN medical_heor_study_id END) / NULLIF(COUNT(DISTINCT medical_heor_study_id), 0), 2)
      comment: "Real-world evidence study rate as percentage of total HEOR studies"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`medical_kol_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key Opinion Leader profile metrics tracking engagement depth, influence, compliance, and transfer of value across therapeutic areas"
  source: "`pharmaceuticals_ecm`.`medical`.`medical_kol_profile`"
  dimensions:
    - name: "kol_type"
      expr: kol_type
      comment: "Type of Key Opinion Leader"
    - name: "influence_tier"
      expr: influence_tier
      comment: "Influence tier classification of the KOL"
    - name: "fmv_tier"
      expr: fmv_tier
      comment: "Fair market value tier for KOL compensation"
    - name: "engagement_status"
      expr: engagement_status
      comment: "Current engagement status with the KOL"
    - name: "primary_therapeutic_area"
      expr: primary_therapeutic_area
      comment: "Primary therapeutic area of expertise"
    - name: "secondary_therapeutic_area"
      expr: secondary_therapeutic_area
      comment: "Secondary therapeutic area of expertise"
    - name: "advisory_board_member"
      expr: advisory_board_member
      comment: "Flag indicating if KOL is an advisory board member"
    - name: "clinical_trial_investigator"
      expr: clinical_trial_investigator
      comment: "Flag indicating if KOL is a clinical trial investigator"
    - name: "heor_expert"
      expr: heor_expert
      comment: "Flag indicating if KOL is a HEOR expert"
    - name: "iit_sponsor"
      expr: iit_sponsor
      comment: "Flag indicating if KOL sponsors investigator-initiated trials"
    - name: "rwe_collaborator"
      expr: rwe_collaborator
      comment: "Flag indicating if KOL collaborates on real-world evidence studies"
    - name: "coi_disclosure_status"
      expr: coi_disclosure_status
      comment: "Conflict of interest disclosure status"
  measures:
    - name: "kol_profile_count"
      expr: COUNT(DISTINCT medical_kol_profile_id)
      comment: "Number of distinct KOL profiles"
    - name: "total_sunshine_act_ytd_amount"
      expr: SUM(CAST(sunshine_act_ytd_amount AS DOUBLE))
      comment: "Total Sunshine Act reportable transfer of value year-to-date in USD"
    - name: "total_efpia_ytd_amount"
      expr: SUM(CAST(efpia_ytd_amount AS DOUBLE))
      comment: "Total EFPIA reportable transfer of value year-to-date in USD"
    - name: "avg_sunshine_act_ytd_amount"
      expr: AVG(CAST(sunshine_act_ytd_amount AS DOUBLE))
      comment: "Average Sunshine Act transfer of value per KOL year-to-date in USD"
    - name: "avg_efpia_ytd_amount"
      expr: AVG(CAST(efpia_ytd_amount AS DOUBLE))
      comment: "Average EFPIA transfer of value per KOL year-to-date in USD"
    - name: "avg_relationship_depth_score"
      expr: AVG(CAST(relationship_depth_score AS DOUBLE))
      comment: "Average relationship depth score across KOL profiles"
    - name: "avg_digital_influence_score"
      expr: AVG(CAST(digital_influence_score AS DOUBLE))
      comment: "Average digital influence score across KOL profiles"
    - name: "total_publications"
      expr: SUM(CAST(total_publications AS DOUBLE))
      comment: "Total number of publications across all KOLs"
    - name: "total_citations"
      expr: SUM(CAST(total_citations AS DOUBLE))
      comment: "Total number of citations across all KOL publications"
    - name: "avg_h_index"
      expr: AVG(CAST(h_index AS DOUBLE))
      comment: "Average h-index across KOL profiles"
    - name: "advisory_board_member_count"
      expr: COUNT(DISTINCT CASE WHEN advisory_board_member = TRUE THEN medical_kol_profile_id END)
      comment: "Number of KOLs serving on advisory boards"
    - name: "clinical_trial_investigator_count"
      expr: COUNT(DISTINCT CASE WHEN clinical_trial_investigator = TRUE THEN medical_kol_profile_id END)
      comment: "Number of KOLs serving as clinical trial investigators"
    - name: "heor_expert_count"
      expr: COUNT(DISTINCT CASE WHEN heor_expert = TRUE THEN medical_kol_profile_id END)
      comment: "Number of KOLs with HEOR expertise"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`medical_grant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medical grant funding metrics tracking grant allocation, disbursement efficiency, compliance, and transparency reporting"
  source: "`pharmaceuticals_ecm`.`medical`.`grant`"
  dimensions:
    - name: "grant_status"
      expr: grant_status
      comment: "Current status of the medical grant"
    - name: "grant_type"
      expr: grant_type
      comment: "Type of medical grant"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area focus of the grant"
    - name: "recipient_org_type"
      expr: recipient_org_type
      comment: "Type of recipient organization"
    - name: "compliance_review_status"
      expr: compliance_review_status
      comment: "Compliance review status of the grant"
    - name: "efpia_disclosure_required"
      expr: efpia_disclosure_required
      comment: "Flag indicating if EFPIA disclosure is required"
    - name: "sunshine_act_category"
      expr: sunshine_act_category
      comment: "Sunshine Act reporting category for the grant"
    - name: "fmv_assessed"
      expr: fmv_assessed
      comment: "Flag indicating if fair market value was assessed"
    - name: "final_report_received"
      expr: final_report_received
      comment: "Flag indicating if final report was received"
    - name: "budget_year"
      expr: budget_year
      comment: "Budget year of the grant"
  measures:
    - name: "grant_count"
      expr: COUNT(DISTINCT grant_id)
      comment: "Number of distinct medical grants"
    - name: "total_requested_amount"
      expr: SUM(CAST(requested_amount AS DOUBLE))
      comment: "Total amount requested across all grants in USD"
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total amount approved across all grants in USD"
    - name: "total_disbursed_amount"
      expr: SUM(CAST(disbursed_amount AS DOUBLE))
      comment: "Total amount disbursed across all grants in USD"
    - name: "avg_approved_amount"
      expr: AVG(CAST(approved_amount AS DOUBLE))
      comment: "Average approved amount per grant in USD"
    - name: "grant_approval_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(approved_amount AS DOUBLE)) / NULLIF(SUM(CAST(requested_amount AS DOUBLE)), 0), 2)
      comment: "Grant approval rate as percentage of requested amount"
    - name: "grant_disbursement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(disbursed_amount AS DOUBLE)) / NULLIF(SUM(CAST(approved_amount AS DOUBLE)), 0), 2)
      comment: "Grant disbursement rate as percentage of approved amount"
    - name: "total_fmv_assessment_amount"
      expr: SUM(CAST(fmv_assessment_amount AS DOUBLE))
      comment: "Total fair market value assessment amount across grants in USD"
    - name: "final_report_received_count"
      expr: COUNT(DISTINCT CASE WHEN final_report_received = TRUE THEN grant_id END)
      comment: "Number of grants with final reports received"
    - name: "final_report_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN final_report_received = TRUE THEN grant_id END) / NULLIF(COUNT(DISTINCT grant_id), 0), 2)
      comment: "Final report completion rate as percentage of total grants"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`medical_inquiry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medical inquiry response metrics tracking inquiry volume, response time, compliance, and safety signal detection"
  source: "`pharmaceuticals_ecm`.`medical`.`inquiry`"
  dimensions:
    - name: "inquiry_status"
      expr: inquiry_status
      comment: "Current status of the medical inquiry"
    - name: "inquiry_category"
      expr: inquiry_category
      comment: "Category of the medical inquiry"
    - name: "subcategory"
      expr: subcategory
      comment: "Subcategory of the medical inquiry"
    - name: "requester_type"
      expr: requester_type
      comment: "Type of requester submitting the inquiry"
    - name: "channel"
      expr: channel
      comment: "Channel through which inquiry was received"
    - name: "response_channel"
      expr: response_channel
      comment: "Channel through which response was provided"
    - name: "response_type"
      expr: response_type
      comment: "Type of response provided"
    - name: "priority"
      expr: priority
      comment: "Priority level of the inquiry"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the inquiry"
    - name: "indication"
      expr: indication
      comment: "Disease indication related to the inquiry"
    - name: "is_adverse_event_related"
      expr: is_adverse_event_related
      comment: "Flag indicating if inquiry is related to adverse event"
    - name: "is_off_label"
      expr: is_off_label
      comment: "Flag indicating if inquiry is about off-label use"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flag indicating if inquiry has regulatory compliance implications"
  measures:
    - name: "inquiry_count"
      expr: COUNT(DISTINCT inquiry_id)
      comment: "Number of distinct medical inquiries"
    - name: "adverse_event_inquiry_count"
      expr: COUNT(DISTINCT CASE WHEN is_adverse_event_related = TRUE THEN inquiry_id END)
      comment: "Number of inquiries related to adverse events"
    - name: "adverse_event_inquiry_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_adverse_event_related = TRUE THEN inquiry_id END) / NULLIF(COUNT(DISTINCT inquiry_id), 0), 2)
      comment: "Adverse event inquiry rate as percentage of total inquiries"
    - name: "off_label_inquiry_count"
      expr: COUNT(DISTINCT CASE WHEN is_off_label = TRUE THEN inquiry_id END)
      comment: "Number of inquiries about off-label use"
    - name: "off_label_inquiry_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_off_label = TRUE THEN inquiry_id END) / NULLIF(COUNT(DISTINCT inquiry_id), 0), 2)
      comment: "Off-label inquiry rate as percentage of total inquiries"
    - name: "regulatory_compliance_inquiry_count"
      expr: COUNT(DISTINCT CASE WHEN regulatory_compliance_flag = TRUE THEN inquiry_id END)
      comment: "Number of inquiries with regulatory compliance implications"
    - name: "regulatory_compliance_inquiry_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN regulatory_compliance_flag = TRUE THEN inquiry_id END) / NULLIF(COUNT(DISTINCT inquiry_id), 0), 2)
      comment: "Regulatory compliance inquiry rate as percentage of total inquiries"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`medical_evidence_gap`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Evidence gap identification and resolution metrics tracking gap prioritization, resolution efficiency, and strategic impact"
  source: "`pharmaceuticals_ecm`.`medical`.`evidence_gap`"
  dimensions:
    - name: "gap_status"
      expr: gap_status
      comment: "Current status of the evidence gap"
    - name: "gap_type"
      expr: gap_type
      comment: "Type of evidence gap identified"
    - name: "priority_tier"
      expr: priority_tier
      comment: "Priority tier for addressing the evidence gap"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the evidence gap"
    - name: "indication"
      expr: indication
      comment: "Disease indication related to the evidence gap"
    - name: "gap_source"
      expr: gap_source
      comment: "Source of the evidence gap identification"
    - name: "data_source_type"
      expr: data_source_type
      comment: "Type of data source needed to address the gap"
    - name: "proposed_study_type"
      expr: proposed_study_type
      comment: "Proposed study type to address the evidence gap"
    - name: "payer_relevance_flag"
      expr: payer_relevance_flag
      comment: "Flag indicating if gap is relevant to payers"
    - name: "regulatory_commitment_flag"
      expr: regulatory_commitment_flag
      comment: "Flag indicating if gap is a regulatory commitment"
    - name: "kol_identified_flag"
      expr: kol_identified_flag
      comment: "Flag indicating if KOL has been identified to address gap"
  measures:
    - name: "evidence_gap_count"
      expr: COUNT(DISTINCT evidence_gap_id)
      comment: "Number of distinct evidence gaps identified"
    - name: "total_estimated_budget_usd"
      expr: SUM(CAST(estimated_budget_usd AS DOUBLE))
      comment: "Total estimated budget to address evidence gaps in USD"
    - name: "avg_estimated_budget_usd"
      expr: AVG(CAST(estimated_budget_usd AS DOUBLE))
      comment: "Average estimated budget per evidence gap in USD"
    - name: "payer_relevant_gap_count"
      expr: COUNT(DISTINCT CASE WHEN payer_relevance_flag = TRUE THEN evidence_gap_id END)
      comment: "Number of evidence gaps relevant to payers"
    - name: "payer_relevant_gap_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN payer_relevance_flag = TRUE THEN evidence_gap_id END) / NULLIF(COUNT(DISTINCT evidence_gap_id), 0), 2)
      comment: "Payer-relevant evidence gap rate as percentage of total gaps"
    - name: "regulatory_commitment_gap_count"
      expr: COUNT(DISTINCT CASE WHEN regulatory_commitment_flag = TRUE THEN evidence_gap_id END)
      comment: "Number of evidence gaps that are regulatory commitments"
    - name: "regulatory_commitment_gap_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN regulatory_commitment_flag = TRUE THEN evidence_gap_id END) / NULLIF(COUNT(DISTINCT evidence_gap_id), 0), 2)
      comment: "Regulatory commitment gap rate as percentage of total gaps"
    - name: "kol_identified_gap_count"
      expr: COUNT(DISTINCT CASE WHEN kol_identified_flag = TRUE THEN evidence_gap_id END)
      comment: "Number of evidence gaps with identified KOL to address"
    - name: "kol_identified_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN kol_identified_flag = TRUE THEN evidence_gap_id END) / NULLIF(COUNT(DISTINCT evidence_gap_id), 0), 2)
      comment: "KOL identification rate as percentage of total evidence gaps"
$$;