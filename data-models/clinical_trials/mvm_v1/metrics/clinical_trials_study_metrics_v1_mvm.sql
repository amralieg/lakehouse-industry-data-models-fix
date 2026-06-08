-- Metric views for domain: study | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-07 02:29:00

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Executive-level KPIs for clinical study portfolio management — tracks study lifecycle status, enrollment performance, and timeline adherence across the active study portfolio."
  source: "`clinical_trials_ecm`.`study`.`study`"
  dimensions:
    - name: "study_status"
      expr: study_status
      comment: "Current operational status of the study (e.g., Active, Completed, Terminated) — primary filter for portfolio health dashboards."
    - name: "development_phase"
      expr: development_phase
      comment: "Clinical development phase (Phase I, II, III, IV) — used to segment portfolio by pipeline maturity and investment tier."
    - name: "study_type"
      expr: study_type
      comment: "Type of study (Interventional, Observational) — drives regulatory pathway and resource allocation decisions."
    - name: "blinding_type"
      expr: blinding_type
      comment: "Blinding methodology (Open-Label, Single-Blind, Double-Blind) — relevant for data integrity risk assessment."
    - name: "primary_regulatory_region"
      expr: primary_regulatory_region
      comment: "Primary regulatory jurisdiction (e.g., US, EU, APAC) — used to segment portfolio by regulatory complexity and market priority."
    - name: "design_type"
      expr: design_type
      comment: "Study design classification (e.g., Parallel, Crossover, Factorial) — informs protocol complexity and operational risk."
    - name: "is_randomized"
      expr: is_randomized
      comment: "Indicates whether the study uses randomization — distinguishes randomized controlled trials from non-randomized designs."
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year the study was planned to start — enables cohort analysis of study initiation trends over time."
    - name: "actual_start_year"
      expr: YEAR(actual_start_date)
      comment: "Year the study actually started — used to measure startup delay trends across the portfolio."
  measures:
    - name: "total_studies"
      expr: COUNT(1)
      comment: "Total number of studies in the portfolio — baseline KPI for portfolio size and capacity planning."
    - name: "active_studies"
      expr: COUNT(CASE WHEN study_status = 'Active' THEN 1 END)
      comment: "Number of currently active studies — key indicator of operational workload and resource demand."
    - name: "terminated_studies"
      expr: COUNT(CASE WHEN study_status = 'Terminated' THEN 1 END)
      comment: "Number of terminated studies — critical risk metric; high termination rates signal pipeline attrition and sunk cost exposure."
    - name: "study_termination_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN study_status = 'Terminated' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of studies that were terminated — executive KPI for pipeline attrition risk; benchmarked against industry norms (~30% Phase II termination rate)."
    - name: "studies_with_startup_delay"
      expr: COUNT(CASE WHEN actual_start_date > planned_start_date THEN 1 END)
      comment: "Number of studies where actual start date exceeded planned start date — measures startup execution risk across the portfolio."
    - name: "startup_delay_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_start_date > planned_start_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_start_date IS NOT NULL AND planned_start_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of studies that started later than planned — a leading indicator of CRO/sponsor execution quality and timeline risk."
    - name: "studies_past_planned_end"
      expr: COUNT(CASE WHEN actual_end_date IS NULL AND planned_end_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of studies that have passed their planned end date without completing — flags overrunning studies requiring executive intervention."
    - name: "completed_studies"
      expr: COUNT(CASE WHEN study_status = 'Completed' THEN 1 END)
      comment: "Number of successfully completed studies — measures pipeline throughput and delivery performance."
    - name: "randomized_study_count"
      expr: COUNT(CASE WHEN is_randomized = TRUE THEN 1 END)
      comment: "Number of randomized controlled trials in the portfolio — RCTs carry higher regulatory weight and resource intensity."
    - name: "studies_with_dbl_completed"
      expr: COUNT(CASE WHEN dbl_date IS NOT NULL THEN 1 END)
      comment: "Number of studies that have reached Database Lock — a critical milestone indicating readiness for statistical analysis and regulatory submission."
    - name: "studies_with_csr_submitted"
      expr: COUNT(CASE WHEN csr_submission_date IS NOT NULL THEN 1 END)
      comment: "Number of studies with a Clinical Study Report submitted — measures regulatory deliverable throughput and submission pipeline health."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`study_country`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Country-level enrollment, regulatory, and feasibility KPIs — enables geographic portfolio management, CTA tracking, and enrollment performance benchmarking across study countries."
  source: "`clinical_trials_ecm`.`study`.`country`"
  dimensions:
    - name: "country_name"
      expr: country_name
      comment: "Name of the country — primary geographic dimension for enrollment and regulatory performance analysis."
    - name: "country_code"
      expr: country_code
      comment: "ISO country code — standardized geographic identifier for cross-study country comparisons."
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status for the country (e.g., Enrolling, Closed, On Hold) — operational filter for active enrollment management."
    - name: "cta_approval_status"
      expr: cta_approval_status
      comment: "Status of the Clinical Trial Authorization in this country — tracks regulatory approval progress by geography."
    - name: "regulatory_hold_flag"
      expr: regulatory_hold_flag
      comment: "Indicates whether a regulatory hold is active in this country — critical risk flag for enrollment and site operations."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for country-level budget — enables financial analysis by currency zone."
    - name: "data_privacy_framework"
      expr: data_privacy_framework
      comment: "Applicable data privacy regulation (e.g., GDPR, HIPAA) — relevant for data transfer risk and compliance overhead assessment."
    - name: "cta_approval_year"
      expr: YEAR(cta_approval_date)
      comment: "Year CTA was approved — enables trend analysis of regulatory approval timelines by country and year."
  measures:
    - name: "total_country_activations"
      expr: COUNT(1)
      comment: "Total number of country-study activations — measures geographic footprint of the clinical trial portfolio."
    - name: "countries_on_regulatory_hold"
      expr: COUNT(CASE WHEN regulatory_hold_flag = TRUE THEN 1 END)
      comment: "Number of country-study combinations currently under regulatory hold — a critical risk metric that directly impacts enrollment capacity."
    - name: "regulatory_hold_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_hold_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of country activations currently under regulatory hold — executive risk indicator for geographic regulatory exposure."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted spend across all country activations — primary financial KPI for country-level cost management and budget vs. actuals tracking."
    - name: "avg_budget_per_country"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per country activation — benchmarking metric for country cost efficiency and budget allocation decisions."
    - name: "avg_feasibility_score"
      expr: AVG(CAST(feasibility_score AS DOUBLE))
      comment: "Average feasibility score across countries — used in site selection decisions; low scores predict enrollment underperformance."
    - name: "avg_enrollment_rate_assumption"
      expr: AVG(CAST(enrollment_rate_assumption AS DOUBLE))
      comment: "Average assumed enrollment rate per country — baseline for enrollment forecasting and country performance benchmarking."
    - name: "avg_screen_failure_rate_assumption"
      expr: AVG(CAST(screen_failure_rate_assumption AS DOUBLE))
      comment: "Average assumed screen failure rate — high screen failure rates inflate recruitment costs and extend timelines."
    - name: "avg_dropout_rate_assumption"
      expr: AVG(CAST(dropout_rate_assumption AS DOUBLE))
      comment: "Average assumed dropout rate per country — informs sample size adjustments and risk-based monitoring intensity."
    - name: "cta_approval_cycle_time_days"
      expr: AVG(DATEDIFF(cta_approval_date, cta_submission_date))
      comment: "Average days from CTA submission to approval — measures regulatory efficiency by country; drives country prioritization in future studies."
    - name: "countries_with_cta_approved"
      expr: COUNT(CASE WHEN cta_approval_status = 'Approved' THEN 1 END)
      comment: "Number of countries with approved CTA — measures regulatory readiness for enrollment launch."
    - name: "first_site_activation_to_first_enrollment_days"
      expr: AVG(DATEDIFF(first_subject_enrolled_date, first_site_activation_date))
      comment: "Average days from first site activation to first subject enrolled per country — measures country startup efficiency and site readiness."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`study_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Study milestone execution KPIs — tracks planned vs. actual milestone achievement, critical path adherence, and timeline variance to support study delivery governance."
  source: "`clinical_trials_ecm`.`study`.`study_milestone`"
  dimensions:
    - name: "milestone_category"
      expr: milestone_category
      comment: "High-level category of the milestone (e.g., Enrollment, Regulatory, Data Management) — enables category-level timeline performance analysis."
    - name: "milestone_type"
      expr: milestone_type
      comment: "Specific type of milestone — used to drill into performance by milestone type across studies."
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone (e.g., Achieved, Overdue, Forecasted) — primary operational filter for milestone tracking dashboards."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Indicates whether the milestone is on the critical path — critical path milestones have direct impact on study completion date."
    - name: "is_regulatory_milestone"
      expr: is_regulatory_milestone
      comment: "Indicates whether the milestone is a regulatory commitment — regulatory milestones carry compliance and contractual obligations."
    - name: "is_contractual"
      expr: is_contractual
      comment: "Indicates whether the milestone is contractually obligated — contractual milestones trigger financial penalties if missed."
    - name: "study_phase"
      expr: study_phase
      comment: "Clinical phase associated with the milestone — enables phase-level timeline benchmarking."
    - name: "responsible_party"
      expr: responsible_party
      comment: "Party responsible for milestone delivery (e.g., Sponsor, CRO, Site) — accountability dimension for milestone performance reviews."
    - name: "planned_year"
      expr: YEAR(planned_date)
      comment: "Year the milestone was planned — enables annual portfolio timeline planning and capacity analysis."
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total number of milestones tracked — baseline for milestone portfolio size and governance coverage."
    - name: "achieved_milestones"
      expr: COUNT(CASE WHEN milestone_status = 'Achieved' THEN 1 END)
      comment: "Number of milestones successfully achieved — measures delivery execution performance."
    - name: "overdue_milestones"
      expr: COUNT(CASE WHEN actual_date IS NULL AND planned_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of milestones past their planned date without achievement — critical operational KPI for escalation and intervention."
    - name: "milestone_on_time_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_date <= planned_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of achieved milestones completed on or before planned date — primary delivery performance KPI for study execution governance."
    - name: "critical_path_overdue_milestones"
      expr: COUNT(CASE WHEN is_critical_path = TRUE AND actual_date IS NULL AND planned_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of overdue milestones on the critical path — highest-priority risk metric; each overdue critical path milestone directly delays study completion."
    - name: "contractual_milestone_on_time_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_contractual = TRUE AND actual_date <= planned_date THEN 1 END) / NULLIF(COUNT(CASE WHEN is_contractual = TRUE AND actual_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "On-time rate for contractually obligated milestones — directly tied to financial penalty exposure and sponsor relationship health."
    - name: "regulatory_milestone_on_time_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_regulatory_milestone = TRUE AND actual_date <= planned_date THEN 1 END) / NULLIF(COUNT(CASE WHEN is_regulatory_milestone = TRUE AND actual_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "On-time rate for regulatory milestones — compliance KPI; missed regulatory milestones can trigger agency action or study suspension."
    - name: "milestones_with_waiver"
      expr: COUNT(CASE WHEN waiver_approved_by IS NOT NULL THEN 1 END)
      comment: "Number of milestones where a waiver was granted — elevated waiver counts signal systemic execution issues requiring process improvement."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`study_protocol_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Protocol amendment KPIs — tracks amendment frequency, regulatory submission performance, and subject/safety impact to support protocol quality governance and regulatory strategy."
  source: "`clinical_trials_ecm`.`study`.`study_protocol_amendment`"
  dimensions:
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of protocol amendment (e.g., Substantial, Non-Substantial, Administrative) — drives regulatory submission requirements and operational impact."
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current status of the amendment (e.g., Draft, Submitted, Approved) — operational filter for amendment pipeline management."
    - name: "change_category"
      expr: change_category
      comment: "Category of change driving the amendment (e.g., Eligibility, Dosing, Endpoint) — identifies most common protocol instability drivers."
    - name: "safety_driven_flag"
      expr: safety_driven_flag
      comment: "Indicates whether the amendment was driven by a safety finding — safety-driven amendments are highest priority and require expedited regulatory review."
    - name: "subject_impact_flag"
      expr: subject_impact_flag
      comment: "Indicates whether the amendment impacts enrolled subjects — subject-impacting amendments require re-consent and IRB/IEC re-approval."
    - name: "reconsent_required_flag"
      expr: reconsent_required_flag
      comment: "Indicates whether subject re-consent is required — re-consent drives site workload and enrollment disruption risk."
    - name: "irb_iec_status"
      expr: irb_iec_status
      comment: "IRB/IEC review status for the amendment — tracks ethics committee approval progress critical for implementation."
    - name: "fda_submission_status"
      expr: fda_submission_status
      comment: "FDA submission status for the amendment — tracks US regulatory submission pipeline."
    - name: "ema_submission_status"
      expr: ema_submission_status
      comment: "EMA submission status for the amendment — tracks EU regulatory submission pipeline."
    - name: "amendment_year"
      expr: YEAR(amendment_date)
      comment: "Year the amendment was issued — enables trend analysis of protocol amendment frequency over time."
  measures:
    - name: "total_amendments"
      expr: COUNT(1)
      comment: "Total number of protocol amendments — baseline KPI for protocol stability; high amendment counts signal design quality issues."
    - name: "safety_driven_amendments"
      expr: COUNT(CASE WHEN safety_driven_flag = TRUE THEN 1 END)
      comment: "Number of amendments driven by safety findings — critical patient safety KPI; elevated counts trigger regulatory scrutiny and sponsor review."
    - name: "safety_driven_amendment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN safety_driven_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of amendments that are safety-driven — executive risk metric; benchmarked against sponsor and industry safety thresholds."
    - name: "subject_impacting_amendments"
      expr: COUNT(CASE WHEN subject_impact_flag = TRUE THEN 1 END)
      comment: "Number of amendments that impact enrolled subjects — drives re-consent workload and enrollment disruption risk quantification."
    - name: "reconsent_required_amendments"
      expr: COUNT(CASE WHEN reconsent_required_flag = TRUE THEN 1 END)
      comment: "Number of amendments requiring subject re-consent — operational KPI for site workload planning and enrollment continuity risk."
    - name: "fda_submission_cycle_time_days"
      expr: AVG(DATEDIFF(fda_submission_date, effective_date))
      comment: "Average days from amendment effective date to FDA submission — measures regulatory submission responsiveness for US-regulated studies."
    - name: "irb_iec_approval_cycle_time_days"
      expr: AVG(DATEDIFF(irb_iec_approval_date, irb_iec_notification_date))
      comment: "Average days from IRB/IEC notification to approval — measures ethics committee review efficiency; delays block amendment implementation."
    - name: "amendments_with_sap_impact"
      expr: COUNT(CASE WHEN sap_impact_flag = TRUE THEN 1 END)
      comment: "Number of amendments that impact the Statistical Analysis Plan — SAP-impacting amendments require biostatistics rework and potential regulatory re-filing."
    - name: "amendments_with_edc_update"
      expr: COUNT(CASE WHEN edc_configuration_updated_flag = TRUE THEN 1 END)
      comment: "Number of amendments requiring EDC system reconfiguration — measures data management operational burden from protocol instability."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`study_arm`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Study arm design and configuration KPIs — supports protocol design quality assessment, blinding compliance, and arm-level enrollment planning across the study portfolio."
  source: "`clinical_trials_ecm`.`study`.`arm`"
  dimensions:
    - name: "arm_type"
      expr: arm_type
      comment: "Type of study arm (e.g., Experimental, Active Comparator, Placebo) — fundamental design dimension for efficacy and safety analysis."
    - name: "arm_status"
      expr: arm_status
      comment: "Current operational status of the arm (e.g., Active, Closed, Suspended) — used to filter active arms for enrollment monitoring."
    - name: "blinding_type"
      expr: blinding_type
      comment: "Blinding methodology applied to the arm — data integrity dimension for regulatory submission quality assessment."
    - name: "intervention_type"
      expr: intervention_type
      comment: "Type of intervention administered in the arm (e.g., Drug, Device, Behavioral) — used to segment arms by therapeutic modality."
    - name: "is_control_arm"
      expr: is_control_arm
      comment: "Indicates whether the arm is a control arm — distinguishes experimental from control arms for comparative efficacy analysis."
    - name: "is_blinded"
      expr: is_blinded
      comment: "Indicates whether the arm is blinded — blinding compliance is a critical GCP requirement and data integrity safeguard."
    - name: "adaptive_design_flag"
      expr: adaptive_design_flag
      comment: "Indicates whether the arm is part of an adaptive design — adaptive arms require additional statistical oversight and regulatory pre-specification."
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of administration for the investigational product — relevant for patient compliance and site procedure planning."
    - name: "dosing_frequency"
      expr: dosing_frequency
      comment: "Frequency of dosing in the arm — impacts patient burden, compliance rates, and site visit scheduling."
  measures:
    - name: "total_arms"
      expr: COUNT(1)
      comment: "Total number of study arms — baseline for study design complexity assessment."
    - name: "active_arms"
      expr: COUNT(CASE WHEN arm_status = 'Active' THEN 1 END)
      comment: "Number of currently active arms — measures operational enrollment capacity across the portfolio."
    - name: "blinded_arm_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_blinded = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of arms that are blinded — GCP compliance indicator; low blinding rates in interventional studies signal protocol design risk."
    - name: "adaptive_design_arm_count"
      expr: COUNT(CASE WHEN adaptive_design_flag = TRUE THEN 1 END)
      comment: "Number of arms using adaptive design — adaptive designs require specialized statistical oversight and regulatory pre-approval of adaptation rules."
    - name: "control_arm_count"
      expr: COUNT(CASE WHEN is_control_arm = TRUE THEN 1 END)
      comment: "Number of control arms across the portfolio — used to verify study design integrity (each study should have at least one control arm in confirmatory trials)."
    - name: "avg_randomization_ratio"
      expr: AVG(CAST(randomization_ratio_numeric AS DOUBLE))
      comment: "Average randomization ratio across arms — used to assess allocation efficiency and statistical power implications of arm design."
    - name: "itt_population_arms"
      expr: COUNT(CASE WHEN itt_population_flag = TRUE THEN 1 END)
      comment: "Number of arms included in the Intent-to-Treat population — ITT population coverage is a primary regulatory requirement for confirmatory trials."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`study_eligibility_criterion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Eligibility criterion design KPIs — tracks criterion complexity, amendment-driven changes, and critical criterion coverage to support protocol quality and patient recruitment feasibility."
  source: "`clinical_trials_ecm`.`study`.`eligibility_criterion`"
  dimensions:
    - name: "criterion_type"
      expr: criterion_type
      comment: "Type of criterion (Inclusion or Exclusion) — fundamental dimension for eligibility design analysis and screen failure root cause investigation."
    - name: "criterion_category"
      expr: criterion_category
      comment: "Category of the criterion (e.g., Lab Value, Medical History, Demographic) — identifies which criterion categories drive the most screen failures."
    - name: "criterion_status"
      expr: criterion_status
      comment: "Current status of the criterion (e.g., Active, Retired, Superseded) — used to filter to currently applicable criteria."
    - name: "is_critical_criterion"
      expr: is_critical_criterion
      comment: "Indicates whether the criterion is designated as critical — critical criteria require mandatory source document verification."
    - name: "is_amendment_driven"
      expr: is_amendment_driven
      comment: "Indicates whether the criterion was introduced or modified by a protocol amendment — amendment-driven criteria signal protocol instability."
    - name: "waiver_allowed"
      expr: waiver_allowed
      comment: "Indicates whether a waiver is permitted for this criterion — waiver-eligible criteria introduce eligibility flexibility but require governance oversight."
    - name: "irb_iec_approval_required"
      expr: irb_iec_approval_required
      comment: "Indicates whether IRB/IEC approval is required for this criterion — drives ethics committee workload estimation."
    - name: "applicable_population"
      expr: applicable_population
      comment: "Population to which the criterion applies (e.g., All Subjects, Pediatric Subset) — used to assess criterion scope and recruitment complexity."
  measures:
    - name: "total_criteria"
      expr: COUNT(1)
      comment: "Total number of eligibility criteria — baseline for protocol complexity; studies with >30 criteria have significantly higher screen failure rates."
    - name: "inclusion_criteria_count"
      expr: COUNT(CASE WHEN criterion_type = 'Inclusion' THEN 1 END)
      comment: "Number of inclusion criteria — directly impacts patient recruitment feasibility; more inclusion criteria narrow the eligible population."
    - name: "exclusion_criteria_count"
      expr: COUNT(CASE WHEN criterion_type = 'Exclusion' THEN 1 END)
      comment: "Number of exclusion criteria — high exclusion criterion counts are the primary driver of screen failure rates and recruitment delays."
    - name: "critical_criterion_count"
      expr: COUNT(CASE WHEN is_critical_criterion = TRUE THEN 1 END)
      comment: "Number of critical eligibility criteria — critical criteria require mandatory SDV and drive monitoring visit frequency and cost."
    - name: "critical_criterion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_critical_criterion = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of criteria designated as critical — high rates increase monitoring burden and site compliance risk."
    - name: "amendment_driven_criteria_count"
      expr: COUNT(CASE WHEN is_amendment_driven = TRUE THEN 1 END)
      comment: "Number of criteria introduced or changed by protocol amendments — measures protocol instability impact on eligibility design."
    - name: "amendment_driven_criteria_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_amendment_driven = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of criteria that are amendment-driven — high rates indicate poor initial protocol design quality and increase re-screening costs."
    - name: "avg_numeric_threshold_value"
      expr: AVG(CAST(numeric_threshold_value AS DOUBLE))
      comment: "Average numeric threshold value across quantitative criteria — used to benchmark eligibility stringency for lab-based and vital sign criteria."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`study_endpoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Study endpoint design and statistical KPIs — tracks endpoint portfolio composition, multiplicity management, and estimand strategy to support regulatory submission quality and statistical rigor governance."
  source: "`clinical_trials_ecm`.`study`.`endpoint`"
  dimensions:
    - name: "endpoint_type"
      expr: endpoint_type
      comment: "Type of endpoint (Primary, Secondary, Exploratory) — fundamental hierarchy for regulatory submission and statistical analysis planning."
    - name: "endpoint_category"
      expr: endpoint_category
      comment: "Clinical category of the endpoint (e.g., Efficacy, Safety, PK, PRO) — used to assess endpoint portfolio balance and regulatory alignment."
    - name: "endpoint_status"
      expr: endpoint_status
      comment: "Current status of the endpoint (e.g., Active, Retired, Superseded) — filters to currently applicable endpoints."
    - name: "analysis_population"
      expr: analysis_population
      comment: "Statistical analysis population for the endpoint (e.g., ITT, PP, Safety) — regulatory requirement for confirmatory endpoint specification."
    - name: "multiplicity_adjustment_flag"
      expr: multiplicity_adjustment_flag
      comment: "Indicates whether multiplicity adjustment is applied — required for confirmatory trials with multiple primary endpoints to control Type I error."
    - name: "directionality"
      expr: directionality
      comment: "Direction of the hypothesis test (e.g., Superiority, Non-Inferiority, Equivalence) — drives statistical methodology and regulatory acceptance criteria."
    - name: "missing_data_strategy"
      expr: missing_data_strategy
      comment: "Strategy for handling missing data (e.g., MMRM, MI, LOCF) — ICH E9(R1) compliance dimension; regulators scrutinize missing data handling."
    - name: "sdtm_domain"
      expr: sdtm_domain
      comment: "CDISC SDTM domain associated with the endpoint — measures CDISC compliance coverage for regulatory submission readiness."
  measures:
    - name: "total_endpoints"
      expr: COUNT(1)
      comment: "Total number of endpoints across the portfolio — baseline for endpoint complexity; studies with many endpoints face multiplicity and regulatory scrutiny."
    - name: "primary_endpoints"
      expr: COUNT(CASE WHEN endpoint_type = 'Primary' THEN 1 END)
      comment: "Number of primary endpoints — regulatory agencies scrutinize studies with multiple primary endpoints; this KPI flags multiplicity risk."
    - name: "secondary_endpoints"
      expr: COUNT(CASE WHEN endpoint_type = 'Secondary' THEN 1 END)
      comment: "Number of secondary endpoints — large secondary endpoint sets increase statistical analysis complexity and SAP scope."
    - name: "endpoints_with_multiplicity_adjustment"
      expr: COUNT(CASE WHEN multiplicity_adjustment_flag = TRUE THEN 1 END)
      comment: "Number of endpoints with multiplicity adjustment applied — measures statistical rigor compliance for confirmatory trials."
    - name: "multiplicity_adjustment_coverage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN multiplicity_adjustment_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN endpoint_type = 'Primary' THEN 1 END), 0), 2)
      comment: "Percentage of primary endpoints with multiplicity adjustment — regulatory compliance KPI; confirmatory trials require multiplicity control for all primary endpoints."
    - name: "avg_alpha_level"
      expr: AVG(CAST(alpha_level AS DOUBLE))
      comment: "Average alpha level (significance threshold) across endpoints — monitors statistical rigor; deviations from 0.05 convention require regulatory justification."
    - name: "avg_non_inferiority_margin"
      expr: AVG(CAST(non_inferiority_margin AS DOUBLE))
      comment: "Average non-inferiority margin across NI endpoints — NI margin selection is a critical regulatory decision point; this KPI supports margin benchmarking."
    - name: "endpoints_with_estimand_defined"
      expr: COUNT(CASE WHEN estimand_variable IS NOT NULL THEN 1 END)
      comment: "Number of endpoints with a fully defined estimand — ICH E9(R1) compliance KPI; regulators now require estimand framework for all confirmatory endpoints."
    - name: "estimand_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN estimand_variable IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of endpoints with estimand defined — ICH E9(R1) compliance rate; a key regulatory submission readiness metric."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`study_dosing_regimen`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dosing regimen design KPIs — tracks dose escalation coverage, regimen complexity, and PK/PD assessment requirements to support clinical pharmacology governance and safety monitoring."
  source: "`clinical_trials_ecm`.`study`.`dosing_regimen`"
  dimensions:
    - name: "regimen_status"
      expr: regimen_status
      comment: "Current status of the dosing regimen (e.g., Active, Superseded, Discontinued) — filters to currently applicable regimens."
    - name: "dosing_route"
      expr: dosing_route
      comment: "Route of administration for the regimen — impacts patient compliance, site procedure requirements, and safety monitoring intensity."
    - name: "dosing_frequency"
      expr: dosing_frequency
      comment: "Frequency of dosing (e.g., QD, BID, Weekly) — patient burden dimension affecting compliance and dropout rates."
    - name: "is_dose_escalation"
      expr: is_dose_escalation
      comment: "Indicates whether the regimen is part of a dose escalation scheme — dose escalation regimens require DSMB oversight and safety stopping rules."
    - name: "is_mtd"
      expr: is_mtd
      comment: "Indicates whether this regimen represents the Maximum Tolerated Dose — MTD determination is a primary Phase I objective."
    - name: "pk_sampling_required"
      expr: pk_sampling_required
      comment: "Indicates whether PK sampling is required for this regimen — PK-intensive regimens drive sample collection burden and central lab costs."
    - name: "pd_assessment_required"
      expr: pd_assessment_required
      comment: "Indicates whether pharmacodynamic assessment is required — PD assessments add procedural complexity and biomarker analysis costs."
    - name: "blinding_type"
      expr: blinding_type
      comment: "Blinding type applied to the regimen — data integrity dimension for regulatory submission quality."
    - name: "dose_form"
      expr: dose_form
      comment: "Pharmaceutical dose form (e.g., Tablet, Injection, Infusion) — impacts supply chain complexity and site administration requirements."
  measures:
    - name: "total_regimens"
      expr: COUNT(1)
      comment: "Total number of dosing regimens — baseline for dosing complexity; high regimen counts indicate complex dose-finding or combination studies."
    - name: "dose_escalation_regimens"
      expr: COUNT(CASE WHEN is_dose_escalation = TRUE THEN 1 END)
      comment: "Number of dose escalation regimens — escalation regimens require DSMB review and safety stopping rules; this KPI measures Phase I safety oversight scope."
    - name: "mtd_regimens"
      expr: COUNT(CASE WHEN is_mtd = TRUE THEN 1 END)
      comment: "Number of regimens designated as MTD — MTD determination is a primary Phase I deliverable; this KPI tracks MTD identification progress."
    - name: "pk_intensive_regimens"
      expr: COUNT(CASE WHEN pk_sampling_required = TRUE THEN 1 END)
      comment: "Number of regimens requiring PK sampling — PK-intensive regimens drive central lab costs and subject burden; used for resource planning."
    - name: "avg_dose_level"
      expr: AVG(CAST(dose_level AS DOUBLE))
      comment: "Average dose level across active regimens — clinical pharmacology KPI for dose range characterization and exposure-response analysis."
    - name: "avg_dosing_interval_days"
      expr: AVG(CAST(dosing_interval_days AS DOUBLE))
      comment: "Average dosing interval in days — patient convenience metric; longer intervals generally improve compliance and reduce site visit burden."
    - name: "avg_infusion_duration_minutes"
      expr: AVG(CAST(infusion_duration_minutes AS DOUBLE))
      comment: "Average infusion duration in minutes for IV regimens — drives site chair time requirements and infusion suite capacity planning."
    - name: "avg_loading_dose_level"
      expr: AVG(CAST(loading_dose_level AS DOUBLE))
      comment: "Average loading dose level — loading doses are used to rapidly achieve therapeutic concentrations; this KPI supports PK/PD modeling and safety review."
    - name: "avg_maximum_dose_level"
      expr: AVG(CAST(maximum_dose_level AS DOUBLE))
      comment: "Average maximum dose level across escalation regimens — used to benchmark dose range breadth and safety margin assessment."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`study_investigational_product`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Investigational product portfolio KPIs — tracks IMP regulatory status, storage requirements, and development phase distribution to support supply chain governance and regulatory compliance."
  source: "`clinical_trials_ecm`.`study`.`investigational_product`"
  dimensions:
    - name: "development_phase"
      expr: development_phase
      comment: "Clinical development phase of the investigational product — primary pipeline segmentation dimension for portfolio investment decisions."
    - name: "investigational_product_status"
      expr: investigational_product_status
      comment: "Current regulatory/operational status of the IMP — used to filter active IMPs for supply chain and regulatory monitoring."
    - name: "product_type"
      expr: product_type
      comment: "Type of investigational product (e.g., Small Molecule, Biologic, Gene Therapy) — drives regulatory pathway, manufacturing complexity, and storage requirements."
    - name: "therapeutic_class"
      expr: therapeutic_class
      comment: "Therapeutic class of the IMP — enables portfolio analysis by therapeutic area for investment and partnership decisions."
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status of the IMP — tracks progression from IND to NDA/BLA approval."
    - name: "is_blinded"
      expr: is_blinded
      comment: "Indicates whether the IMP is blinded — blinded IMPs require specialized packaging and distribution controls."
    - name: "is_comparator"
      expr: is_comparator
      comment: "Indicates whether the product is a comparator — comparator sourcing and supply chain management is a distinct operational challenge."
    - name: "is_placebo"
      expr: is_placebo
      comment: "Indicates whether the product is a placebo — placebo manufacturing and matching requirements impact supply chain complexity."
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of administration — impacts site administration requirements, patient compliance, and cold chain logistics."
  measures:
    - name: "total_investigational_products"
      expr: COUNT(1)
      comment: "Total number of investigational products in the portfolio — baseline for IMP supply chain scope and regulatory submission workload."
    - name: "active_imps"
      expr: COUNT(CASE WHEN investigational_product_status = 'Active' THEN 1 END)
      comment: "Number of currently active investigational products — measures active supply chain and regulatory monitoring obligations."
    - name: "blinded_imp_count"
      expr: COUNT(CASE WHEN is_blinded = TRUE THEN 1 END)
      comment: "Number of blinded IMPs — blinded products require specialized packaging, labeling, and distribution controls increasing supply chain cost."
    - name: "comparator_product_count"
      expr: COUNT(CASE WHEN is_comparator = TRUE THEN 1 END)
      comment: "Number of comparator products — comparator sourcing is a frequent supply chain bottleneck; this KPI supports procurement planning."
    - name: "avg_storage_temperature_max_c"
      expr: AVG(CAST(storage_temperature_max_c AS DOUBLE))
      comment: "Average maximum storage temperature across IMPs — cold chain logistics planning KPI; products requiring low temperatures drive higher distribution costs."
    - name: "avg_storage_temperature_min_c"
      expr: AVG(CAST(storage_temperature_min_c AS DOUBLE))
      comment: "Average minimum storage temperature across IMPs — used alongside max temperature to characterize cold chain requirements across the IMP portfolio."
    - name: "imps_with_ind_submitted"
      expr: COUNT(CASE WHEN ind_submission_date IS NOT NULL THEN 1 END)
      comment: "Number of IMPs with an IND submission on record — measures US regulatory filing coverage for the investigational product portfolio."
    - name: "imps_first_in_human"
      expr: COUNT(CASE WHEN first_in_human_date IS NOT NULL THEN 1 END)
      comment: "Number of IMPs that have reached First-in-Human dosing — FIH milestone is a critical pipeline progression indicator and regulatory milestone."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`study_epoch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Study epoch design KPIs — tracks epoch structure, treatment coverage, and endpoint alignment to support protocol design quality and CDISC SDTM compliance governance."
  source: "`clinical_trials_ecm`.`study`.`epoch`"
  dimensions:
    - name: "epoch_type"
      expr: epoch_type
      comment: "Type of epoch (e.g., Screening, Treatment, Follow-Up, Washout) — fundamental protocol structure dimension for timeline and procedure planning."
    - name: "epoch_status"
      expr: epoch_status
      comment: "Current status of the epoch (e.g., Active, Completed, Planned) — operational filter for active epoch monitoring."
    - name: "blinding_type"
      expr: blinding_type
      comment: "Blinding type applied during the epoch — data integrity dimension; blinding must be maintained consistently across treatment epochs."
    - name: "ip_administered"
      expr: ip_administered
      comment: "Indicates whether investigational product is administered during this epoch — distinguishes treatment from non-treatment epochs for safety monitoring scope."
    - name: "primary_endpoint_epoch"
      expr: primary_endpoint_epoch
      comment: "Indicates whether the primary endpoint is assessed during this epoch — primary endpoint epochs are highest priority for data quality and monitoring."
    - name: "ae_reporting_applicable"
      expr: ae_reporting_applicable
      comment: "Indicates whether adverse event reporting applies during this epoch — AE reporting epochs drive pharmacovigilance workload."
    - name: "randomization_applicable"
      expr: randomization_applicable
      comment: "Indicates whether randomization occurs during this epoch — randomization epochs require IWRS integration and unblinding procedures."
    - name: "washout_epoch"
      expr: washout_epoch
      comment: "Indicates whether this is a washout epoch — washout epochs are critical for crossover designs to prevent carryover effects."
  measures:
    - name: "total_epochs"
      expr: COUNT(1)
      comment: "Total number of epochs across the portfolio — baseline for protocol structural complexity."
    - name: "treatment_epochs"
      expr: COUNT(CASE WHEN ip_administered = TRUE THEN 1 END)
      comment: "Number of epochs where investigational product is administered — measures treatment exposure scope and pharmacovigilance monitoring obligations."
    - name: "primary_endpoint_epochs"
      expr: COUNT(CASE WHEN primary_endpoint_epoch = TRUE THEN 1 END)
      comment: "Number of epochs designated as primary endpoint assessment epochs — these epochs require highest data quality standards and monitoring intensity."
    - name: "ae_reporting_epochs"
      expr: COUNT(CASE WHEN ae_reporting_applicable = TRUE THEN 1 END)
      comment: "Number of epochs with active AE reporting — measures pharmacovigilance scope; more AE reporting epochs increase safety data management workload."
    - name: "washout_epoch_count"
      expr: COUNT(CASE WHEN washout_epoch = TRUE THEN 1 END)
      comment: "Number of washout epochs — washout epochs in crossover designs are critical for carryover effect prevention; their presence indicates crossover design complexity."
    - name: "sdtm_mapped_epochs"
      expr: COUNT(CASE WHEN sdtm_epoch_code IS NOT NULL THEN 1 END)
      comment: "Number of epochs with SDTM epoch code mapped — CDISC SDTM compliance KPI; unmapped epochs block regulatory submission data package completion."
    - name: "sdtm_mapping_coverage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sdtm_epoch_code IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of epochs with SDTM mapping complete — regulatory submission readiness KPI; 100% coverage required for FDA/EMA electronic submission."
$$;