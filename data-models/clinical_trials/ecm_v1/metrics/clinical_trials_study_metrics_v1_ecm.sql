-- Metric views for domain: study | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-06 23:23:25

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core study-level metrics tracking enrollment performance, study lifecycle, and operational health across the clinical trial portfolio."
  source: "`clinical_trials_ecm`.`study`.`study_study`"
  dimensions:
    - name: "study_status"
      expr: study_status
      comment: "Current status of the study (e.g., Active, Completed, Terminated)"
    - name: "development_phase"
      expr: development_phase
      comment: "Clinical development phase (Phase I, II, III, IV)"
    - name: "study_type"
      expr: study_type
      comment: "Type of study (e.g., Interventional, Observational)"
    - name: "blinding_type"
      expr: blinding_type
      comment: "Blinding methodology (Open-label, Single-blind, Double-blind)"
    - name: "design_type"
      expr: design_type
      comment: "Study design type (e.g., Parallel, Crossover)"
    - name: "is_randomized"
      expr: CAST(is_randomized AS STRING)
      comment: "Whether the study uses randomization"
    - name: "primary_regulatory_region"
      expr: primary_regulatory_region
      comment: "Primary regulatory region for the study"
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year the study was planned to start"
    - name: "actual_start_year"
      expr: YEAR(actual_start_date)
      comment: "Year the study actually started"
  measures:
    - name: "total_studies"
      expr: COUNT(1)
      comment: "Total number of clinical studies in the portfolio"
    - name: "active_studies"
      expr: COUNT(CASE WHEN study_status = 'Active' THEN 1 END)
      comment: "Number of currently active studies"
    - name: "terminated_studies"
      expr: COUNT(CASE WHEN study_status = 'Terminated' THEN 1 END)
      comment: "Number of terminated studies — signals portfolio risk and resource waste"
    - name: "avg_planned_duration_days"
      expr: AVG(DATEDIFF(planned_end_date, planned_start_date))
      comment: "Average planned study duration in days across the portfolio"
    - name: "avg_startup_delay_days"
      expr: AVG(DATEDIFF(actual_start_date, planned_start_date))
      comment: "Average delay between planned and actual start dates — key operational efficiency indicator"
    - name: "studies_with_site_initiation"
      expr: COUNT(CASE WHEN first_site_initiation_date IS NOT NULL THEN 1 END)
      comment: "Number of studies that have initiated at least one site"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`study_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Milestone achievement and variance metrics tracking study execution against plan, critical for identifying delays and forecasting study completion."
  source: "`clinical_trials_ecm`.`study`.`study_milestone`"
  dimensions:
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone (e.g., Planned, Achieved, Missed)"
    - name: "milestone_category"
      expr: milestone_category
      comment: "Category of milestone (e.g., Regulatory, Enrollment, Data)"
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type classification of the milestone"
    - name: "is_critical_path"
      expr: CAST(is_critical_path AS STRING)
      comment: "Whether the milestone is on the critical path"
    - name: "is_regulatory_milestone"
      expr: CAST(is_regulatory_milestone AS STRING)
      comment: "Whether this is a regulatory milestone"
    - name: "is_contractual"
      expr: CAST(is_contractual AS STRING)
      comment: "Whether the milestone is tied to a contractual obligation"
    - name: "study_phase"
      expr: study_phase
      comment: "Study phase associated with this milestone"
    - name: "responsible_party"
      expr: responsible_party
      comment: "Party responsible for achieving the milestone"
    - name: "planned_date_year_month"
      expr: DATE_TRUNC('MONTH', planned_date)
      comment: "Month of the planned milestone date for trend analysis"
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total number of study milestones tracked"
    - name: "achieved_milestones"
      expr: COUNT(CASE WHEN milestone_status = 'Achieved' THEN 1 END)
      comment: "Number of milestones that have been achieved"
    - name: "missed_milestones"
      expr: COUNT(CASE WHEN milestone_status = 'Missed' THEN 1 END)
      comment: "Number of milestones that were missed — triggers investigation and corrective action"
    - name: "critical_path_milestones_missed"
      expr: COUNT(CASE WHEN is_critical_path = TRUE AND milestone_status = 'Missed' THEN 1 END)
      comment: "Critical path milestones missed — highest priority operational risk indicator"
    - name: "avg_milestone_variance_days"
      expr: AVG(DATEDIFF(actual_date, planned_date))
      comment: "Average variance in days between planned and actual milestone dates — positive means late"
    - name: "contractual_milestones_at_risk"
      expr: COUNT(CASE WHEN is_contractual = TRUE AND milestone_status NOT IN ('Achieved', 'Completed') AND planned_date < CURRENT_DATE() THEN 1 END)
      comment: "Contractual milestones past due — financial and relationship risk indicator"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`study_country_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Country-level enrollment and activation metrics tracking geographic performance of clinical trial execution."
  source: "`clinical_trials_ecm`.`study`.`country`"
  dimensions:
    - name: "country_name"
      expr: country_name
      comment: "Name of the country participating in the study"
    - name: "country_code"
      expr: country_code
      comment: "ISO country code"
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status for this country"
    - name: "activation_status"
      expr: activation_status
      comment: "Site activation status at country level"
    - name: "cta_approval_status"
      expr: cta_approval_status
      comment: "Clinical Trial Authorization approval status"
    - name: "regulatory_hold_flag"
      expr: CAST(regulatory_hold_flag AS STRING)
      comment: "Whether the country is under regulatory hold"
    - name: "data_privacy_framework"
      expr: data_privacy_framework
      comment: "Data privacy framework applicable in this country"
  measures:
    - name: "total_country_participations"
      expr: COUNT(1)
      comment: "Total number of country-study participations"
    - name: "countries_with_regulatory_hold"
      expr: COUNT(CASE WHEN regulatory_hold_flag = TRUE THEN 1 END)
      comment: "Number of country participations under regulatory hold — critical compliance risk"
    - name: "avg_feasibility_score"
      expr: AVG(CAST(feasibility_score AS DOUBLE))
      comment: "Average feasibility score across countries — informs site selection strategy"
    - name: "avg_dropout_rate_assumption"
      expr: AVG(CAST(dropout_rate_assumption AS DOUBLE))
      comment: "Average assumed dropout rate across countries — impacts sample size planning"
    - name: "avg_screen_failure_rate_assumption"
      expr: AVG(CAST(screen_failure_rate_assumption AS DOUBLE))
      comment: "Average assumed screen failure rate — impacts recruitment planning and cost"
    - name: "total_country_budget"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated across all country participations"
    - name: "avg_enrollment_rate_assumption"
      expr: AVG(CAST(enrollment_rate_assumption AS DOUBLE))
      comment: "Average enrollment rate assumption — key input for timeline forecasting"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`study_protocol_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Protocol amendment metrics tracking the frequency, type, and impact of protocol changes — a key indicator of study design quality and operational disruption."
  source: "`clinical_trials_ecm`.`study`.`study_protocol_amendment`"
  dimensions:
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current status of the amendment (e.g., Draft, Approved, Implemented)"
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (e.g., Substantial, Non-substantial)"
    - name: "change_category"
      expr: change_category
      comment: "Category of change driving the amendment"
    - name: "safety_driven_flag"
      expr: CAST(safety_driven_flag AS STRING)
      comment: "Whether the amendment was driven by safety concerns"
    - name: "subject_impact_flag"
      expr: CAST(subject_impact_flag AS STRING)
      comment: "Whether the amendment impacts enrolled subjects"
    - name: "reconsent_required_flag"
      expr: CAST(reconsent_required_flag AS STRING)
      comment: "Whether re-consent of subjects is required"
    - name: "irb_iec_status"
      expr: irb_iec_status
      comment: "IRB/IEC review status for the amendment"
    - name: "amendment_year"
      expr: YEAR(amendment_date)
      comment: "Year the amendment was issued"
  measures:
    - name: "total_amendments"
      expr: COUNT(1)
      comment: "Total number of protocol amendments — high counts indicate design instability"
    - name: "safety_driven_amendments"
      expr: COUNT(CASE WHEN safety_driven_flag = TRUE THEN 1 END)
      comment: "Number of amendments driven by safety signals — critical quality and risk indicator"
    - name: "amendments_requiring_reconsent"
      expr: COUNT(CASE WHEN reconsent_required_flag = TRUE THEN 1 END)
      comment: "Amendments requiring subject re-consent — significant operational burden and dropout risk"
    - name: "amendments_impacting_subjects"
      expr: COUNT(CASE WHEN subject_impact_flag = TRUE THEN 1 END)
      comment: "Amendments that impact enrolled subjects — measures protocol stability for participants"
    - name: "amendments_with_sap_impact"
      expr: COUNT(CASE WHEN sap_impact_flag = TRUE THEN 1 END)
      comment: "Amendments impacting the Statistical Analysis Plan — signals analytical complexity changes"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`study_arm`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Treatment arm metrics providing insight into study design complexity, randomization structure, and arm-level planning."
  source: "`clinical_trials_ecm`.`study`.`arm`"
  dimensions:
    - name: "arm_status"
      expr: arm_status
      comment: "Current status of the treatment arm"
    - name: "arm_type"
      expr: arm_type
      comment: "Type of arm (e.g., Experimental, Comparator, Placebo)"
    - name: "blinding_type"
      expr: blinding_type
      comment: "Blinding methodology for this arm"
    - name: "intervention_type"
      expr: intervention_type
      comment: "Type of intervention (Drug, Biologic, Device, etc.)"
    - name: "is_control_arm"
      expr: CAST(is_control_arm AS STRING)
      comment: "Whether this is a control arm"
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of administration for the intervention"
    - name: "adaptive_design_flag"
      expr: CAST(adaptive_design_flag AS STRING)
      comment: "Whether this arm is part of an adaptive design"
  measures:
    - name: "total_arms"
      expr: COUNT(1)
      comment: "Total number of treatment arms across studies"
    - name: "active_arms"
      expr: COUNT(CASE WHEN arm_status = 'Active' THEN 1 END)
      comment: "Number of currently active treatment arms"
    - name: "discontinued_arms"
      expr: COUNT(CASE WHEN arm_status = 'Discontinued' THEN 1 END)
      comment: "Number of discontinued arms — may indicate futility or safety issues"
    - name: "avg_randomization_ratio"
      expr: AVG(CAST(randomization_ratio_numeric AS DOUBLE))
      comment: "Average randomization ratio across arms — informs enrollment planning"
    - name: "adaptive_design_arms"
      expr: COUNT(CASE WHEN adaptive_design_flag = TRUE THEN 1 END)
      comment: "Number of arms using adaptive design — indicates study design sophistication"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`study_endpoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Endpoint metrics tracking the composition and complexity of study endpoints — critical for understanding statistical rigor and regulatory strategy."
  source: "`clinical_trials_ecm`.`study`.`endpoint`"
  dimensions:
    - name: "endpoint_type"
      expr: endpoint_type
      comment: "Classification of endpoint (Primary, Secondary, Exploratory)"
    - name: "endpoint_category"
      expr: endpoint_category
      comment: "Category of endpoint (Efficacy, Safety, PK, Biomarker)"
    - name: "endpoint_status"
      expr: endpoint_status
      comment: "Current status of the endpoint"
    - name: "analysis_population"
      expr: analysis_population
      comment: "Analysis population for this endpoint (ITT, PP, Safety)"
    - name: "directionality"
      expr: directionality
      comment: "Expected direction of treatment effect"
    - name: "multiplicity_adjustment_flag"
      expr: CAST(multiplicity_adjustment_flag AS STRING)
      comment: "Whether multiplicity adjustment is required"
    - name: "sdtm_domain"
      expr: sdtm_domain
      comment: "SDTM domain associated with this endpoint"
  measures:
    - name: "total_endpoints"
      expr: COUNT(1)
      comment: "Total number of study endpoints defined"
    - name: "primary_endpoints"
      expr: COUNT(CASE WHEN endpoint_type = 'Primary' THEN 1 END)
      comment: "Number of primary endpoints — drives sample size and regulatory strategy"
    - name: "endpoints_requiring_multiplicity_adjustment"
      expr: COUNT(CASE WHEN multiplicity_adjustment_flag = TRUE THEN 1 END)
      comment: "Endpoints requiring multiplicity adjustment — indicates statistical complexity"
    - name: "avg_alpha_level"
      expr: AVG(CAST(alpha_level AS DOUBLE))
      comment: "Average significance level across endpoints — reflects statistical rigor standards"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`study_investigational_product`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Investigational product portfolio metrics tracking the breadth and characteristics of products under development."
  source: "`clinical_trials_ecm`.`study`.`investigational_product`"
  dimensions:
    - name: "development_phase"
      expr: development_phase
      comment: "Current development phase of the product"
    - name: "product_type"
      expr: product_type
      comment: "Type of investigational product (Drug, Biologic, Device)"
    - name: "therapeutic_class"
      expr: therapeutic_class
      comment: "Therapeutic class of the product"
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of administration"
    - name: "dosage_form"
      expr: dosage_form
      comment: "Dosage form of the product"
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Current regulatory approval status"
    - name: "investigational_product_status"
      expr: investigational_product_status
      comment: "Overall status of the investigational product"
    - name: "is_comparator"
      expr: CAST(is_comparator AS STRING)
      comment: "Whether this is a comparator product"
    - name: "is_placebo"
      expr: CAST(is_placebo AS STRING)
      comment: "Whether this is a placebo"
  measures:
    - name: "total_products"
      expr: COUNT(1)
      comment: "Total number of investigational products in the portfolio"
    - name: "active_products"
      expr: COUNT(CASE WHEN investigational_product_status = 'Active' THEN 1 END)
      comment: "Number of actively developed investigational products"
    - name: "products_in_phase3"
      expr: COUNT(CASE WHEN development_phase = 'Phase III' THEN 1 END)
      comment: "Products in Phase III — closest to market and highest investment"
    - name: "comparator_products"
      expr: COUNT(CASE WHEN is_comparator = TRUE THEN 1 END)
      comment: "Number of comparator products — impacts supply chain and cost planning"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`study_amendment_site_implementation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Amendment site implementation metrics tracking how quickly and completely protocol amendments are rolled out to sites — critical for compliance and data integrity."
  source: "`clinical_trials_ecm`.`study`.`amendment_site_implementation`"
  dimensions:
    - name: "implementation_status"
      expr: implementation_status
      comment: "Current implementation status at the site"
    - name: "edc_configuration_updated_flag"
      expr: CAST(edc_configuration_updated_flag AS STRING)
      comment: "Whether EDC configuration has been updated for this amendment"
    - name: "reconsent_completed_flag"
      expr: CAST(reconsent_completed_flag AS STRING)
      comment: "Whether re-consent has been completed at this site"
    - name: "implementation_month"
      expr: DATE_TRUNC('MONTH', implementation_date)
      comment: "Month of implementation for trend analysis"
  measures:
    - name: "total_site_implementations"
      expr: COUNT(1)
      comment: "Total number of site-level amendment implementations tracked"
    - name: "completed_implementations"
      expr: COUNT(CASE WHEN implementation_status = 'Completed' THEN 1 END)
      comment: "Number of completed site implementations"
    - name: "overdue_implementations"
      expr: COUNT(CASE WHEN implementation_date IS NULL AND implementation_deadline < CURRENT_DATE() THEN 1 END)
      comment: "Site implementations past deadline — compliance risk requiring immediate action"
    - name: "pending_reconsent"
      expr: COUNT(CASE WHEN reconsent_completed_flag = FALSE THEN 1 END)
      comment: "Sites with pending re-consent — patient safety and regulatory compliance risk"
    - name: "avg_implementation_lead_time_days"
      expr: AVG(DATEDIFF(implementation_date, notification_date))
      comment: "Average days from notification to implementation — measures site responsiveness"
$$;