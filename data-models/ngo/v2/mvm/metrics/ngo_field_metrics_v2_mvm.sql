-- Metric views for domain: field | Business: Ngo | Version: 2 | Generated on: 2026-06-23 02:03:19

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for field assessments — quality, coverage, and beneficiary satisfaction metrics used by program directors and M&E leads to evaluate assessment effectiveness and data integrity."
  source: "`vibe_ngo_v1`.`field`.`assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of assessment conducted (e.g., rapid, baseline, endline) — used to segment quality and satisfaction metrics by methodology."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (e.g., planned, in-progress, completed) — enables pipeline and completion tracking."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic coverage of the assessment — used to analyze reach and identify under-assessed areas."
    - name: "methodology"
      expr: methodology
      comment: "Data collection methodology applied — enables comparison of quality scores across methodological approaches."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of assessment date — supports trend analysis of assessment volume and quality over time."
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of assessment — supports annual reporting and year-over-year comparisons."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Whether the assessment is visible to donors — used to track donor-reportable assessment coverage."
    - name: "mel_indicator_linked"
      expr: mel_indicator_linked
      comment: "Whether the assessment is linked to a MEL indicator — measures alignment of field assessments with the M&E framework."
    - name: "protection_concerns_noted"
      expr: protection_concerns_noted
      comment: "Whether protection concerns were identified — used to flag assessments requiring follow-up action."
    - name: "cluster_coordination_body"
      expr: cluster_coordination_body
      comment: "Humanitarian cluster coordinating the assessment — enables cluster-level performance analysis."
  measures:
    - name: "total_assessments_completed"
      expr: COUNT(CASE WHEN assessment_status = 'completed' THEN assessment_id END)
      comment: "Total number of completed assessments — baseline KPI for program coverage and operational throughput."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across assessments — critical indicator of evidence reliability for program decisions and donor reporting."
    - name: "avg_beneficiary_satisfaction_score"
      expr: AVG(CAST(beneficiary_satisfaction_score AS DOUBLE))
      comment: "Average beneficiary satisfaction score — key accountability metric reflecting whether programs meet beneficiary needs."
    - name: "avg_adequacy_score"
      expr: AVG(CAST(adequacy_score AS DOUBLE))
      comment: "Average adequacy score across assessments — measures whether humanitarian response meets minimum standards."
    - name: "avg_utilization_rate_percent"
      expr: AVG(CAST(utilization_rate_percent AS DOUBLE))
      comment: "Average utilization rate of assessed services or resources — indicates operational efficiency and uptake of humanitarian assistance."
    - name: "total_assessments_with_protection_concerns"
      expr: COUNT(CASE WHEN protection_concerns_noted = TRUE THEN assessment_id END)
      comment: "Number of assessments where protection concerns were identified — drives protection mainstreaming and referral decisions."
    - name: "mel_linked_assessment_count"
      expr: COUNT(CASE WHEN mel_indicator_linked = TRUE THEN assessment_id END)
      comment: "Number of assessments linked to MEL indicators — measures alignment of field evidence with the monitoring and evaluation framework."
    - name: "donor_visible_assessment_count"
      expr: COUNT(CASE WHEN donor_visibility_flag = TRUE THEN assessment_id END)
      comment: "Number of assessments flagged for donor visibility — supports donor reporting compliance and accountability."
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of assessment records — denominator for completion rate and quality ratio calculations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_assessment_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household-level field response KPIs capturing vulnerability profiles, food security, protection risks, and referral needs — used by program managers and protection officers to target assistance and measure population vulnerability."
  source: "`vibe_ngo_v1`.`field`.`assessment_response`"
  dimensions:
    - name: "response_status"
      expr: response_status
      comment: "Status of the assessment response record — used to filter for validated/complete responses in analysis."
    - name: "displacement_status"
      expr: displacement_status
      comment: "Displacement status of the household — key segmentation variable for targeting and vulnerability analysis."
    - name: "primary_need_category"
      expr: primary_need_category
      comment: "Primary humanitarian need category reported — drives sector-level resource allocation decisions."
    - name: "shelter_type"
      expr: shelter_type
      comment: "Type of shelter the household occupies — used to assess shelter vulnerability and prioritize NFI distributions."
    - name: "shelter_condition"
      expr: shelter_condition
      comment: "Condition of the household shelter — supports shelter sector targeting and quality-of-life assessments."
    - name: "livelihood_status"
      expr: livelihood_status
      comment: "Livelihood status of the household — used to segment economic vulnerability and target livelihoods programming."
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Method used to collect the response data — enables quality comparison across collection modalities."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of response submission — supports trend analysis of vulnerability indicators over time."
    - name: "protection_concern_type"
      expr: protection_concern_type
      comment: "Type of protection concern identified — used to categorize and prioritize protection responses."
    - name: "interview_language"
      expr: interview_language
      comment: "Language used during the interview — used to assess language access and inclusion in data collection."
  measures:
    - name: "avg_food_security_score"
      expr: AVG(CAST(food_security_score AS DOUBLE))
      comment: "Average food security score across surveyed households — primary indicator for food assistance targeting and severity classification."
    - name: "avg_monthly_income_usd"
      expr: AVG(CAST(monthly_income_usd AS DOUBLE))
      comment: "Average monthly household income in USD — key economic vulnerability indicator for livelihoods and cash programming decisions."
    - name: "total_households_with_protection_concerns"
      expr: COUNT(CASE WHEN protection_concern_flag = TRUE THEN assessment_response_id END)
      comment: "Number of households with identified protection concerns — drives protection referral and case management resource allocation."
    - name: "total_households_requiring_referral"
      expr: COUNT(CASE WHEN referral_required_flag = TRUE THEN assessment_response_id END)
      comment: "Number of households flagged for referral to specialized services — measures referral pipeline volume for case management planning."
    - name: "total_households_with_disability"
      expr: COUNT(CASE WHEN disability_present_flag = TRUE THEN assessment_response_id END)
      comment: "Number of households with at least one member with a disability — supports inclusive programming and accessibility planning."
    - name: "total_households_with_chronic_illness"
      expr: COUNT(CASE WHEN chronic_illness_flag = TRUE THEN assessment_response_id END)
      comment: "Number of households with chronic illness — informs health sector targeting and medical supply planning."
    - name: "total_responses_with_data_sharing_consent"
      expr: COUNT(CASE WHEN consent_data_sharing = TRUE THEN assessment_response_id END)
      comment: "Number of responses where data sharing consent was obtained — critical for data protection compliance and inter-agency data sharing."
    - name: "avg_gps_accuracy_meters"
      expr: AVG(CAST(gps_accuracy_meters AS DOUBLE))
      comment: "Average GPS accuracy of response submissions in meters — data quality indicator for geographic targeting and mapping reliability."
    - name: "total_responses"
      expr: COUNT(1)
      comment: "Total number of assessment responses — baseline denominator for vulnerability rate and consent rate calculations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_distribution_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for humanitarian distribution events — used by logistics managers, program directors, and donors to track delivery performance, budget utilization, and beneficiary reach."
  source: "`vibe_ngo_v1`.`field`.`distribution_event`"
  dimensions:
    - name: "distribution_status"
      expr: distribution_status
      comment: "Current status of the distribution event — used to track pipeline, in-progress, and completed distributions."
    - name: "distribution_type"
      expr: distribution_type
      comment: "Type of distribution (e.g., food, NFI, cash) — enables sector-level performance and reach analysis."
    - name: "distribution_modality"
      expr: distribution_modality
      comment: "Modality of distribution (e.g., in-kind, cash, voucher) — used to compare efficiency and reach across modalities."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Category of commodity distributed — supports supply chain and sector-level reporting."
    - name: "cva_transfer_modality"
      expr: cva_transfer_modality
      comment: "Cash and voucher assistance transfer modality — used to analyze CVA program performance and financial inclusion."
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "First administrative level of distribution location — enables geographic disaggregation of reach and expenditure."
    - name: "admin_level_2"
      expr: admin_level_2
      comment: "Second administrative level of distribution location — supports sub-national targeting and gap analysis."
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month the distribution was scheduled — supports pipeline planning and on-time delivery trend analysis."
    - name: "incident_reported_flag"
      expr: incident_reported_flag
      comment: "Whether an incident was reported during the distribution — used to track operational safety and accountability."
    - name: "pdm_scheduled_flag"
      expr: pdm_scheduled_flag
      comment: "Whether a post-distribution monitoring exercise is scheduled — measures accountability and feedback loop coverage."
  measures:
    - name: "total_actual_expenditure_usd"
      expr: SUM(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Total actual expenditure across distribution events in USD — primary financial KPI for budget burn and donor reporting."
    - name: "total_budget_allocated_usd"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated to distribution events in USD — denominator for budget utilization rate calculations."
    - name: "avg_budget_utilization_rate"
      expr: AVG(CAST(actual_expenditure_amount AS DOUBLE) / NULLIF(CAST(budget_allocated_amount AS DOUBLE), 0))
      comment: "Average budget utilization rate per distribution event — measures financial efficiency and identifies under/over-spending patterns."
    - name: "total_distribution_events_completed"
      expr: COUNT(CASE WHEN distribution_status = 'completed' THEN distribution_event_id END)
      comment: "Total number of completed distribution events — operational throughput KPI for program delivery tracking."
    - name: "total_incidents_reported"
      expr: COUNT(CASE WHEN incident_reported_flag = TRUE THEN distribution_event_id END)
      comment: "Total number of distribution events with reported incidents — safety and accountability KPI for operational risk management."
    - name: "total_pdm_scheduled"
      expr: COUNT(CASE WHEN pdm_scheduled_flag = TRUE THEN distribution_event_id END)
      comment: "Number of distribution events with post-distribution monitoring scheduled — accountability coverage metric for program quality assurance."
    - name: "total_distribution_events"
      expr: COUNT(1)
      comment: "Total number of distribution event records — baseline denominator for completion rate and incident rate calculations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_distribution_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commodity-level distribution KPIs tracking quantities delivered, financial value, and variance — used by supply chain managers and program officers to monitor delivery accuracy, pipeline performance, and donor earmark compliance."
  source: "`vibe_ngo_v1`.`field`.`distribution_line`"
  dimensions:
    - name: "distribution_status"
      expr: distribution_status
      comment: "Status of the distribution line item — used to filter completed vs. pending deliveries."
    - name: "item_category"
      expr: item_category
      comment: "Category of item distributed — enables sector and commodity-level performance analysis."
    - name: "cluster_sector"
      expr: cluster_sector
      comment: "Humanitarian cluster or sector the distribution line belongs to — supports cluster-level reporting and coordination."
    - name: "distribution_method"
      expr: distribution_method
      comment: "Method of distribution for the line item — used to compare efficiency across delivery approaches."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the distributed commodity — required for accurate quantity aggregation and comparison."
    - name: "donor_earmark"
      expr: donor_earmark
      comment: "Donor earmark designation for the distribution line — used to track compliance with donor-restricted funding."
    - name: "quality_check_status"
      expr: quality_check_status
      comment: "Quality check status of the distributed items — used to flag and track quality assurance compliance."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the distribution line — supports strategic reporting on sustainable development goal contributions."
    - name: "iati_transaction_type"
      expr: iati_transaction_type
      comment: "IATI transaction type classification — required for international aid transparency reporting compliance."
    - name: "pipeline_source"
      expr: pipeline_source
      comment: "Source pipeline for the commodity — used to track supply chain origin and pipeline reliability."
  measures:
    - name: "total_actual_quantity_distributed"
      expr: SUM(CAST(actual_quantity_distributed AS DOUBLE))
      comment: "Total actual quantity of commodities distributed — primary delivery volume KPI for supply chain and program reporting."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity for distribution — denominator for delivery fulfillment rate calculations."
    - name: "total_distribution_value_usd"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total monetary value of distributions in USD — financial KPI for donor reporting and budget accountability."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total variance between planned and actual quantities distributed — operational accuracy KPI identifying supply chain gaps or over-delivery."
    - name: "avg_unit_value_usd"
      expr: AVG(CAST(unit_value AS DOUBLE))
      comment: "Average unit value of distributed items in USD — cost efficiency indicator used to benchmark commodity pricing across distributions."
    - name: "total_distribution_lines"
      expr: COUNT(1)
      comment: "Total number of distribution line items — baseline denominator for quality check compliance rate and variance rate calculations."
    - name: "lines_with_quality_issues"
      expr: COUNT(CASE WHEN quality_check_status NOT IN ('passed', 'approved') AND quality_check_status IS NOT NULL THEN distribution_line_id END)
      comment: "Number of distribution lines with quality check issues — supply chain quality KPI driving corrective action and supplier accountability."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_emergency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic emergency response KPIs tracking funding gaps, population impact, and response activation — used by country directors, emergency coordinators, and donors to prioritize resources and monitor humanitarian response adequacy."
  source: "`vibe_ngo_v1`.`field`.`emergency`"
  dimensions:
    - name: "emergency_type"
      expr: emergency_type
      comment: "Type of emergency (e.g., flood, conflict, drought) — used to segment funding, population impact, and response metrics by crisis type."
    - name: "emergency_status"
      expr: emergency_status
      comment: "Current status of the emergency (e.g., active, closed) — used to filter active vs. historical emergency analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the emergency — key dimension for prioritizing resource allocation and escalation decisions."
    - name: "disaster_category"
      expr: disaster_category
      comment: "Disaster category classification — supports cross-emergency benchmarking and preparedness planning."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the emergency — used to assess coverage and identify geographic response gaps."
    - name: "response_modality"
      expr: response_modality
      comment: "Primary response modality deployed — used to compare effectiveness and cost across response approaches."
    - name: "declaration_year"
      expr: YEAR(declaration_date)
      comment: "Year the emergency was declared — supports annual trend analysis of emergency frequency and scale."
    - name: "flash_appeal_issued"
      expr: flash_appeal_issued
      comment: "Whether a flash appeal was issued — indicates scale and international recognition of the emergency."
    - name: "hrp_issued"
      expr: hrp_issued
      comment: "Whether a Humanitarian Response Plan was issued — measures strategic planning coverage for active emergencies."
    - name: "is_active"
      expr: is_active
      comment: "Whether the emergency is currently active — primary filter for operational vs. historical emergency dashboards."
  measures:
    - name: "total_funding_received_usd"
      expr: SUM(CAST(funding_received_usd AS DOUBLE))
      comment: "Total funding received across emergencies in USD — primary financial KPI for resource mobilization tracking and donor reporting."
    - name: "total_funding_requirement_usd"
      expr: SUM(CAST(funding_requirement_usd AS DOUBLE))
      comment: "Total funding requirement across emergencies in USD — denominator for funding coverage rate and gap analysis."
    - name: "avg_funding_coverage_rate"
      expr: AVG(CAST(funding_received_usd AS DOUBLE) / NULLIF(CAST(funding_requirement_usd AS DOUBLE), 0))
      comment: "Average funding coverage rate per emergency (received / required) — strategic KPI measuring resource mobilization effectiveness and funding gap severity."
    - name: "total_affected_population"
      expr: SUM(CAST(affected_population_count AS DOUBLE))
      comment: "Total affected population across emergencies — scale indicator used to prioritize response and allocate resources proportionally."
    - name: "total_displaced_population"
      expr: SUM(CAST(displaced_population_count AS DOUBLE))
      comment: "Total displaced population across emergencies — critical protection and shelter planning KPI."
    - name: "total_targeted_beneficiaries"
      expr: SUM(CAST(targeted_beneficiaries_count AS DOUBLE))
      comment: "Total targeted beneficiaries across emergencies — program reach planning KPI used to assess response ambition vs. affected population."
    - name: "active_emergency_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN emergency_id END)
      comment: "Number of currently active emergencies — operational load indicator for emergency coordination and resource planning."
    - name: "rapid_assessment_completion_rate"
      expr: AVG(CASE WHEN rapid_assessment_completed = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of emergencies where a rapid assessment was completed — measures evidence-based response activation and preparedness quality."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_team`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field team operational KPIs tracking budget utilization, deployment coverage, and performance — used by operations managers and country directors to optimize team deployment, monitor costs, and ensure accountability."
  source: "`vibe_ngo_v1`.`field`.`field_team`"
  dimensions:
    - name: "team_type"
      expr: team_type
      comment: "Type of field team (e.g., assessment, distribution, protection) — used to segment performance and budget metrics by team function."
    - name: "cluster_affiliation"
      expr: cluster_affiliation
      comment: "Humanitarian cluster the team is affiliated with — enables cluster-level operational performance analysis."
    - name: "performance_rating"
      expr: performance_rating
      comment: "Performance rating of the field team — used to identify high and low performers for capacity building decisions."
    - name: "safety_clearance_level"
      expr: safety_clearance_level
      comment: "Safety clearance level of the team — used to assess deployment risk and match teams to appropriate operational contexts."
    - name: "mobile_data_collection_platform"
      expr: mobile_data_collection_platform
      comment: "Mobile data collection platform used by the team — supports digital transformation and platform standardization analysis."
    - name: "deployment_start_month"
      expr: DATE_TRUNC('MONTH', deployment_start_date)
      comment: "Month of team deployment start — supports trend analysis of deployment patterns and surge capacity planning."
    - name: "gps_tracking_enabled"
      expr: gps_tracking_enabled
      comment: "Whether GPS tracking is enabled for the team — measures accountability and real-time monitoring coverage."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language of the field team — used to assess language access and community engagement capacity."
  measures:
    - name: "total_monthly_operational_budget_usd"
      expr: SUM(CAST(monthly_operational_budget AS DOUBLE))
      comment: "Total monthly operational budget across field teams in USD — primary cost KPI for field operations financial planning and donor reporting."
    - name: "avg_monthly_operational_budget_usd"
      expr: AVG(CAST(monthly_operational_budget AS DOUBLE))
      comment: "Average monthly operational budget per field team in USD — benchmarking KPI for cost efficiency and budget allocation equity."
    - name: "total_active_field_teams"
      expr: COUNT(CASE WHEN operational_status > 0 THEN field_team_id END)
      comment: "Number of operationally active field teams — capacity indicator used to assess surge readiness and deployment coverage."
    - name: "gps_tracked_team_count"
      expr: COUNT(CASE WHEN gps_tracking_enabled = TRUE THEN field_team_id END)
      comment: "Number of field teams with GPS tracking enabled — accountability and real-time monitoring coverage KPI."
    - name: "total_field_teams"
      expr: COUNT(1)
      comment: "Total number of field team records — baseline denominator for GPS tracking rate and performance distribution calculations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_project_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project site infrastructure and operational KPIs — used by program managers and country directors to assess site coverage, infrastructure quality, and operational readiness across the field network."
  source: "`vibe_ngo_v1`.`field`.`project_site`"
  dimensions:
    - name: "site_type"
      expr: site_type
      comment: "Type of project site (e.g., health post, distribution point, office) — used to segment infrastructure and operational metrics by site function."
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "First administrative level of the project site — enables geographic disaggregation of site coverage and infrastructure quality."
    - name: "admin_level_2"
      expr: admin_level_2
      comment: "Second administrative level — supports sub-national site coverage gap analysis."
    - name: "security_level"
      expr: security_level
      comment: "Security level classification of the site — used to assess operational risk and access constraints."
    - name: "accessibility_rating"
      expr: accessibility_rating
      comment: "Accessibility rating of the site — used to prioritize logistics planning and identify hard-to-reach locations."
    - name: "cluster_affiliation"
      expr: cluster_affiliation
      comment: "Humanitarian cluster the site is affiliated with — supports cluster-level site coverage reporting."
    - name: "electricity_available"
      expr: electricity_available
      comment: "Whether electricity is available at the site — infrastructure readiness indicator for cold chain and digital operations."
    - name: "water_source_available"
      expr: water_source_available
      comment: "Whether a water source is available at the site — WASH infrastructure indicator for site suitability assessment."
    - name: "kobo_collection_enabled"
      expr: kobo_collection_enabled
      comment: "Whether KoBoToolbox data collection is enabled at the site — digital data collection readiness indicator."
    - name: "establishment_year"
      expr: YEAR(establishment_date)
      comment: "Year the project site was established — used for cohort analysis of site maturity and performance."
  measures:
    - name: "total_active_project_sites"
      expr: COUNT(CASE WHEN operational_status > 0 THEN project_site_id END)
      comment: "Number of operationally active project sites — primary coverage KPI for field network reach and program delivery capacity."
    - name: "total_site_area_sqm"
      expr: SUM(CAST(site_area_sqm AS DOUBLE))
      comment: "Total physical area of project sites in square meters — infrastructure capacity indicator for planning and asset management."
    - name: "avg_site_area_sqm"
      expr: AVG(CAST(site_area_sqm AS DOUBLE))
      comment: "Average site area in square meters — used to benchmark site capacity and identify undersized facilities."
    - name: "sites_with_electricity"
      expr: COUNT(CASE WHEN electricity_available = TRUE THEN project_site_id END)
      comment: "Number of project sites with electricity — infrastructure readiness KPI for cold chain, digital operations, and service quality."
    - name: "sites_with_water_source"
      expr: COUNT(CASE WHEN water_source_available = TRUE THEN project_site_id END)
      comment: "Number of project sites with available water source — WASH infrastructure coverage KPI for site suitability and beneficiary safety."
    - name: "kobo_enabled_site_count"
      expr: COUNT(CASE WHEN kobo_collection_enabled = TRUE THEN project_site_id END)
      comment: "Number of sites with KoBoToolbox data collection enabled — digital transformation and data quality coverage KPI."
    - name: "total_project_sites"
      expr: COUNT(1)
      comment: "Total number of project site records — baseline denominator for infrastructure coverage rate calculations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_sitrep`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Situation report KPIs tracking humanitarian response progress, funding gaps, and reporting compliance — used by country directors, donors, and cluster coordinators to monitor response effectiveness and accountability."
  source: "`vibe_ngo_v1`.`field`.`sitrep`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Status of the situation report (e.g., draft, submitted, published) — used to track reporting pipeline and compliance."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of situation reporting (e.g., weekly, monthly) — used to assess reporting cadence compliance."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope covered by the sitrep — used to assess reporting coverage across operational areas."
    - name: "admin_level_1_name"
      expr: admin_level_1_name
      comment: "First administrative level name covered in the sitrep — enables geographic disaggregation of response progress metrics."
    - name: "reporting_period_month"
      expr: DATE_TRUNC('MONTH', reporting_period_start_date)
      comment: "Month of the reporting period — supports trend analysis of response progress and funding gaps over time."
    - name: "donor_submission_required"
      expr: donor_submission_required
      comment: "Whether donor submission is required for this sitrep — used to track donor reporting compliance obligations."
    - name: "ocha_submission_required"
      expr: ocha_submission_required
      comment: "Whether OCHA submission is required — measures compliance with inter-agency coordination reporting requirements."
    - name: "cluster_lead_agency"
      expr: cluster_lead_agency
      comment: "Lead agency for the cluster covered in the sitrep — enables cluster-level response progress analysis."
  measures:
    - name: "total_funding_gap_usd"
      expr: SUM(CAST(funding_gap_usd AS DOUBLE))
      comment: "Total funding gap reported across situation reports in USD — critical resource mobilization KPI for donor engagement and emergency appeals."
    - name: "avg_hrp_progress_percentage"
      expr: AVG(CAST(hrp_progress_percentage AS DOUBLE))
      comment: "Average Humanitarian Response Plan progress percentage — strategic KPI measuring overall response delivery against planned targets."
    - name: "total_sitreps_submitted"
      expr: COUNT(CASE WHEN report_status = 'submitted' THEN sitrep_id END)
      comment: "Total number of submitted situation reports — reporting compliance KPI for donor and OCHA accountability."
    - name: "donor_required_sitrep_count"
      expr: COUNT(CASE WHEN donor_submission_required = TRUE THEN sitrep_id END)
      comment: "Number of sitreps with donor submission requirements — compliance tracking KPI for donor relationship management."
    - name: "ocha_required_sitrep_count"
      expr: COUNT(CASE WHEN ocha_submission_required = TRUE THEN sitrep_id END)
      comment: "Number of sitreps with OCHA submission requirements — inter-agency coordination compliance KPI."
    - name: "avg_funding_gap_usd"
      expr: AVG(CAST(funding_gap_usd AS DOUBLE))
      comment: "Average funding gap per situation report in USD — used to benchmark funding shortfalls across emergencies and reporting periods."
    - name: "total_sitreps"
      expr: COUNT(1)
      comment: "Total number of situation report records — baseline denominator for submission rate and compliance rate calculations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_country`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Country-level strategic KPIs for humanitarian context and operational presence — used by regional directors and strategic planners to assess country portfolio risk, operational footprint, and humanitarian need."
  source: "`vibe_ngo_v1`.`field`.`country`"
  dimensions:
    - name: "humanitarian_status"
      expr: humanitarian_status
      comment: "Humanitarian status classification of the country — primary dimension for prioritizing resource allocation and response planning."
    - name: "fragility_status"
      expr: fragility_status
      comment: "Fragility status of the country — used to assess operational risk and contextualize program design."
    - name: "security_risk_level"
      expr: security_risk_level
      comment: "Security risk level of the country — critical dimension for staff safety planning and operational access analysis."
    - name: "income_classification"
      expr: income_classification
      comment: "World Bank income classification of the country — used to contextualize humanitarian need and donor targeting."
    - name: "region"
      expr: region
      comment: "Geographic region of the country — enables regional portfolio analysis and resource allocation."
    - name: "sub_region"
      expr: sub_region
      comment: "Sub-regional classification — supports more granular geographic portfolio analysis."
    - name: "humanitarian_response_plan_active"
      expr: humanitarian_response_plan_active
      comment: "Whether an active Humanitarian Response Plan exists — indicates formal humanitarian response activation."
    - name: "least_developed_country"
      expr: least_developed_country
      comment: "Whether the country is classified as a Least Developed Country — used for donor targeting and concessional funding eligibility."
    - name: "is_active"
      expr: is_active
      comment: "Whether the country has active operations — used to filter operational vs. historical country portfolio."
  measures:
    - name: "total_population"
      expr: SUM(CAST(population AS DOUBLE))
      comment: "Total population across countries in portfolio — scale indicator for humanitarian need assessment and program sizing."
    - name: "avg_population"
      expr: AVG(CAST(population AS DOUBLE))
      comment: "Average population per country — used to benchmark country scale and contextualize per-capita program reach."
    - name: "total_land_area_sq_km"
      expr: SUM(CAST(land_area_sq_km AS DOUBLE))
      comment: "Total land area across countries in portfolio in square kilometers — geographic scale indicator for logistics and access planning."
    - name: "active_hrp_country_count"
      expr: COUNT(CASE WHEN humanitarian_response_plan_active = TRUE THEN country_id END)
      comment: "Number of countries with an active Humanitarian Response Plan — strategic KPI measuring formal humanitarian response activation across the portfolio."
    - name: "countries_with_mou"
      expr: COUNT(CASE WHEN memorandum_of_understanding_signed = TRUE THEN country_id END)
      comment: "Number of countries with a signed MOU — legal and operational presence KPI for government partnership tracking."
    - name: "active_country_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN country_id END)
      comment: "Number of countries with active operations — portfolio footprint KPI for strategic planning and resource allocation."
    - name: "total_countries"
      expr: COUNT(1)
      comment: "Total number of country records — baseline denominator for MOU coverage rate and HRP activation rate calculations."
$$;