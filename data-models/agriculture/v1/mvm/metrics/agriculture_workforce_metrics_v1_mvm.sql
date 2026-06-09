-- Metric views for domain: workforce | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 18:41:06

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`workforce_payroll`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic payroll KPIs covering labor cost composition, wage compliance, overtime burden, and piece-rate economics. Enables CFO and HR leadership to monitor total labor spend, AEWR compliance posture, and pay-type mix across farm operations and cost centers."
  source: "`agriculture_ecm`.`workforce`.`payroll`"
  dimensions:
    - name: "pay_period_start_date"
      expr: pay_period_start_date
      comment: "Start date of the pay period; used to trend payroll costs over time."
    - name: "pay_period_end_date"
      expr: pay_period_end_date
      comment: "End date of the pay period; used to bound payroll reporting windows."
    - name: "employment_type"
      expr: employment_type
      comment: "Classification of worker engagement (e.g., H-2A, domestic seasonal, full-time); drives labor cost segmentation."
    - name: "pay_type"
      expr: pay_type
      comment: "Pay basis for the record (hourly, piece-rate, salary); critical for wage compliance analysis."
    - name: "job_classification_code"
      expr: job_classification_code
      comment: "DOL/SOC job classification code; used for AEWR rate benchmarking and regulatory reporting."
    - name: "farm_operation_code"
      expr: farm_operation_code
      comment: "Farm operation identifier on the payroll record; enables cost attribution by operation."
    - name: "work_state_code"
      expr: work_state_code
      comment: "State where work was performed; drives state tax and AEWR jurisdiction analysis."
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Frequency of pay runs (weekly, bi-weekly); used to normalize annualized labor cost projections."
    - name: "payroll_status"
      expr: payroll_status
      comment: "Processing status of the payroll record (e.g., processed, pending, voided); filters for finalized payroll."
    - name: "aewr_compliant"
      expr: aewr_compliant
      comment: "Boolean flag indicating whether the payroll record meets Adverse Effect Wage Rate requirements; key compliance dimension."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payroll transaction; supports multi-currency labor cost reporting."
  measures:
    - name: "total_gross_wages"
      expr: SUM(CAST(gross_wages AS DOUBLE))
      comment: "Total gross wages paid across all payroll records. Primary labor cost KPI for budget vs. actuals tracking and executive P&L review."
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay AS DOUBLE))
      comment: "Total net pay disbursed after all deductions. Measures actual cash outflow to workers; used in cash flow planning."
    - name: "total_overtime_earnings"
      expr: SUM(CAST(overtime_earnings AS DOUBLE))
      comment: "Total overtime premium paid. Elevated overtime signals understaffing or scheduling inefficiency and drives crew-size decisions."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours_worked AS DOUBLE))
      comment: "Total overtime hours worked. Used alongside overtime earnings to compute effective overtime premium rate."
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours_worked AS DOUBLE))
      comment: "Total regular (straight-time) hours worked. Baseline labor volume metric for productivity and capacity planning."
    - name: "total_piece_rate_earnings"
      expr: SUM(CAST(piece_rate_earnings AS DOUBLE))
      comment: "Total earnings from piece-rate pay. Tracks incentive-pay exposure and informs harvest labor cost modeling."
    - name: "total_piece_rate_units"
      expr: SUM(CAST(piece_rate_units AS DOUBLE))
      comment: "Total units harvested or processed under piece-rate arrangements. Drives yield-per-worker productivity analysis."
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly wage rate across payroll records. Benchmarked against AEWR and minimum wage floors to assess compliance risk."
    - name: "overtime_hours_pct_of_total"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours_worked AS DOUBLE)) / NULLIF(SUM(CAST(regular_hours_worked AS DOUBLE)) + SUM(CAST(overtime_hours_worked AS DOUBLE)), 0), 2)
      comment: "Overtime hours as a percentage of total hours worked. A rising ratio signals scheduling pressure and potential labor cost overrun."
    - name: "total_housing_deductions"
      expr: SUM(CAST(housing_deduction AS DOUBLE))
      comment: "Total housing deductions withheld from worker pay. Monitored for DOL/H-2A compliance to ensure deductions do not reduce net pay below AEWR."
    - name: "total_transportation_deductions"
      expr: SUM(CAST(transportation_deduction AS DOUBLE))
      comment: "Total transportation deductions withheld. Tracked alongside housing deductions for H-2A three-fourths guarantee compliance."
    - name: "three_fourths_guarantee_hours_total"
      expr: SUM(CAST(three_fourths_guarantee_hours AS DOUBLE))
      comment: "Total three-fourths guarantee hours owed under H-2A contracts. Compared against actual hours to identify guarantee shortfall liability."
    - name: "aewr_non_compliant_records"
      expr: SUM(CASE WHEN aewr_compliant = FALSE THEN 1 ELSE 0 END)
      comment: "Count of payroll records failing AEWR compliance. Any non-zero value represents regulatory exposure requiring immediate remediation."
    - name: "three_fourths_guarantee_not_met_records"
      expr: SUM(CASE WHEN three_fourths_guarantee_met = FALSE THEN 1 ELSE 0 END)
      comment: "Count of payroll records where the H-2A three-fourths guarantee was not met. Triggers back-pay liability and DOL audit risk."
    - name: "total_payroll_records"
      expr: COUNT(1)
      comment: "Total number of payroll records processed. Used as denominator for per-record averages and compliance rate calculations."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce composition and compliance KPIs covering headcount, visa status, employment type mix, and credential expiry risk. Enables HR leadership and compliance officers to manage workforce demographics, H-2A visa pipeline, and I-9 verification posture."
  source: "`agriculture_ecm`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (active, terminated, on-leave); primary filter for active headcount reporting."
    - name: "employment_type"
      expr: employment_type
      comment: "Worker classification (H-2A, domestic seasonal, full-time, part-time); drives labor program cost and compliance segmentation."
    - name: "department"
      expr: department
      comment: "Organizational department of the employee; enables headcount and turnover analysis by business unit."
    - name: "job_title"
      expr: job_title
      comment: "Employee job title; used for role-level workforce planning and compensation benchmarking."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin of the worker; critical for H-2A program reporting and workforce diversity tracking."
    - name: "work_authorization_type"
      expr: work_authorization_type
      comment: "Type of work authorization (e.g., H-2A visa, US citizen, green card); drives I-9 and visa compliance segmentation."
    - name: "i9_verification_status"
      expr: i9_verification_status
      comment: "I-9 verification status (verified, pending, expired); key compliance dimension for employment eligibility."
    - name: "pay_type"
      expr: pay_type
      comment: "Pay basis (hourly, salary, piece-rate); used to segment workforce by compensation structure."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language of the employee; informs training delivery language requirements and safety communication planning."
    - name: "gender"
      expr: gender
      comment: "Gender of the employee; used for EEO workforce composition reporting."
    - name: "work_location_code"
      expr: work_location_code
      comment: "Code of the work location assigned to the employee; enables headcount analysis by farm site or facility."
    - name: "hire_date"
      expr: hire_date
      comment: "Date the employee was hired; used for tenure cohort analysis and seasonal rehire tracking."
    - name: "termination_date"
      expr: termination_date
      comment: "Date of employment termination; used to compute turnover rates and seasonal workforce cycle analysis."
  measures:
    - name: "total_active_employees"
      expr: COUNT(CASE WHEN employment_status = 'Active' THEN employee_id END)
      comment: "Total count of currently active employees. Primary headcount KPI for workforce capacity planning and budget tracking."
    - name: "total_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Total distinct employee count including all statuses. Used as denominator for workforce composition ratios."
    - name: "h2a_visa_employee_count"
      expr: COUNT(CASE WHEN employment_type = 'H-2A' THEN employee_id END)
      comment: "Count of employees on H-2A agricultural guest worker visas. Tracks H-2A program scale and drives DOL compliance obligations."
    - name: "seasonal_rehire_eligible_count"
      expr: SUM(CASE WHEN is_seasonal_rehire_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of employees eligible for seasonal rehire. Informs pre-season recruitment planning and reduces H-2A petition lead times."
    - name: "i9_pending_or_non_compliant_count"
      expr: COUNT(CASE WHEN i9_verification_status != 'Verified' THEN employee_id END)
      comment: "Count of employees with non-verified I-9 status. Any non-zero value represents employment eligibility compliance risk requiring immediate action."
    - name: "pesticide_license_expiring_within_90_days"
      expr: COUNT(CASE WHEN pesticide_license_expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN employee_id END)
      comment: "Count of employees whose pesticide applicator license expires within 90 days. Proactive renewal tracking to prevent work stoppages and EPA violations."
    - name: "h2a_visa_expiring_within_60_days"
      expr: COUNT(CASE WHEN h2a_visa_expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 60) THEN employee_id END)
      comment: "Count of H-2A employees whose visa expires within 60 days. Critical for timely extension petitions to avoid illegal employment exposure."
    - name: "voluntary_termination_count"
      expr: COUNT(CASE WHEN termination_reason = 'Voluntary' THEN employee_id END)
      comment: "Count of voluntary terminations. Elevated voluntary turnover signals compensation or working condition issues requiring HR intervention."
    - name: "termination_count"
      expr: COUNT(CASE WHEN termination_date IS NOT NULL THEN employee_id END)
      comment: "Total count of terminated employees in the period. Used as numerator for turnover rate calculations."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`workforce_labor_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "H-2A and agricultural labor compliance KPIs covering AEWR wage adherence, housing standards, three-fourths guarantee fulfillment, and DOL audit exposure. Enables compliance officers and legal teams to monitor regulatory risk across the H-2A workforce program."
  source: "`agriculture_ecm`.`workforce`.`labor_compliance`"
  dimensions:
    - name: "program_type"
      expr: program_type
      comment: "Labor program type (e.g., H-2A, MSPA, domestic); primary segmentation for compliance reporting."
    - name: "aewr_compliance_status"
      expr: aewr_compliance_status
      comment: "AEWR compliance status for the record; used to filter and count non-compliant wage records."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin of the worker; required for H-2A program demographic and DOL reporting."
    - name: "housing_type"
      expr: housing_type
      comment: "Type of employer-provided housing (e.g., dormitory, mobile home); used for EPA and OSHA housing compliance segmentation."
    - name: "visa_petition_status"
      expr: visa_petition_status
      comment: "Status of the H-2A visa petition (approved, pending, denied); tracks pipeline of authorized workers."
    - name: "dol_job_order_number"
      expr: dol_job_order_number
      comment: "DOL job order number associated with the H-2A contract; links compliance records to specific labor certifications."
    - name: "contract_start_date"
      expr: contract_start_date
      comment: "Start date of the H-2A or MSPA labor contract; used to bound compliance reporting to active contract periods."
    - name: "contract_end_date"
      expr: contract_end_date
      comment: "End date of the labor contract; used to identify contracts nearing expiration and trigger renewal workflows."
    - name: "arrival_date"
      expr: arrival_date
      comment: "Date workers arrived at the worksite; used to verify timely housing and orientation compliance."
    - name: "dol_audit_flag"
      expr: dol_audit_flag
      comment: "Boolean flag indicating the record is under DOL audit scrutiny; critical filter for compliance risk dashboards."
    - name: "epa_housing_compliant"
      expr: epa_housing_compliant
      comment: "Boolean indicating EPA housing compliance; used to segment compliant vs. non-compliant housing records."
    - name: "osha_housing_compliant"
      expr: osha_housing_compliant
      comment: "Boolean indicating OSHA housing compliance; paired with EPA flag for comprehensive housing audit readiness."
    - name: "workers_comp_coverage"
      expr: workers_comp_coverage
      comment: "Boolean indicating workers compensation coverage; identifies uninsured worker exposure."
  measures:
    - name: "total_compliance_records"
      expr: COUNT(1)
      comment: "Total labor compliance records. Baseline volume metric for compliance program scale and audit scope."
    - name: "aewr_non_compliant_count"
      expr: COUNT(CASE WHEN aewr_compliance_status != 'Compliant' THEN labor_compliance_id END)
      comment: "Count of records with AEWR wage violations. Any non-zero value represents DOL back-pay liability and potential debarment risk."
    - name: "avg_actual_hourly_wage"
      expr: AVG(CAST(actual_hourly_wage AS DOUBLE))
      comment: "Average actual hourly wage paid. Benchmarked against AEWR rate to assess systemic wage compliance posture."
    - name: "avg_aewr_hourly_rate"
      expr: AVG(CAST(aewr_hourly_rate AS DOUBLE))
      comment: "Average Adverse Effect Wage Rate applicable to the workforce. Used as the regulatory wage floor benchmark."
    - name: "wage_vs_aewr_gap"
      expr: AVG(CAST(actual_hourly_wage AS DOUBLE) - CAST(aewr_hourly_rate AS DOUBLE))
      comment: "Average difference between actual wage paid and AEWR floor. Negative values indicate systemic underpayment requiring immediate remediation."
    - name: "total_actual_hours_offered"
      expr: SUM(CAST(actual_hours_offered AS DOUBLE))
      comment: "Total hours offered to H-2A workers. Compared against three-fourths guarantee hours to assess guarantee fulfillment liability."
    - name: "total_three_fourths_guarantee_hours"
      expr: SUM(CAST(three_fourths_guarantee_hours AS DOUBLE))
      comment: "Total three-fourths guarantee hours contractually owed. Shortfall versus actual hours offered creates back-pay liability."
    - name: "total_inbound_transport_cost"
      expr: SUM(CAST(inbound_transport_cost AS DOUBLE))
      comment: "Total inbound transportation costs incurred for H-2A workers. Monitored to ensure reimbursement obligations are met under DOL regulations."
    - name: "total_outbound_transport_cost"
      expr: SUM(CAST(outbound_transport_cost AS DOUBLE))
      comment: "Total outbound transportation costs. Tracked for H-2A contract compliance and total program cost accounting."
    - name: "total_rent_deductions"
      expr: SUM(CAST(rent_deduction_amount AS DOUBLE))
      comment: "Total rent deducted from worker wages. Monitored to ensure deductions comply with DOL-approved housing cost limits."
    - name: "housing_non_compliant_count"
      expr: SUM(CASE WHEN epa_housing_compliant = FALSE OR osha_housing_compliant = FALSE THEN 1 ELSE 0 END)
      comment: "Count of records with EPA or OSHA housing violations. Non-compliant housing triggers stop-work orders and civil penalties."
    - name: "dol_audit_flagged_count"
      expr: SUM(CASE WHEN dol_audit_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of records flagged for DOL audit. Tracks active regulatory scrutiny volume and prioritizes compliance remediation effort."
    - name: "workers_comp_uncovered_count"
      expr: SUM(CASE WHEN workers_comp_coverage = FALSE THEN 1 ELSE 0 END)
      comment: "Count of workers without workers compensation coverage. Uninsured workers represent significant legal and financial liability."
    - name: "mspa_disclosure_non_compliant_count"
      expr: SUM(CASE WHEN mspa_disclosure_provided = FALSE THEN 1 ELSE 0 END)
      comment: "Count of records where MSPA disclosure was not provided. MSPA disclosure failures are a primary trigger for DOL enforcement actions."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`workforce_safety_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce safety KPIs covering incident frequency, severity, OSHA recordability, workers compensation claims, and pesticide exposure events. Enables EHS leadership and operations management to drive injury reduction, manage insurance costs, and maintain OSHA 300 log compliance."
  source: "`agriculture_ecm`.`workforce`.`safety_event`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of safety incident (e.g., injury, illness, near-miss, property damage); primary classification for safety trend analysis."
    - name: "severity_classification"
      expr: severity_classification
      comment: "Severity level of the incident (e.g., first-aid, recordable, lost-time, fatality); drives OSHA reporting and insurance triage."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the incident; used to identify systemic safety failures and prioritize corrective actions."
    - name: "location_type"
      expr: location_type
      comment: "Type of location where the incident occurred (field, packing house, equipment yard); enables site-level safety benchmarking."
    - name: "task_being_performed"
      expr: task_being_performed
      comment: "Agricultural task being performed at time of incident; identifies high-risk activities for targeted safety interventions."
    - name: "body_part_affected"
      expr: body_part_affected
      comment: "Body part affected by the injury; used for ergonomic and PPE program effectiveness analysis."
    - name: "medical_treatment_type"
      expr: medical_treatment_type
      comment: "Type of medical treatment required (first-aid, emergency room, hospitalization); correlates with claim cost and severity."
    - name: "osha_recordable"
      expr: osha_recordable
      comment: "Boolean indicating OSHA 300 log recordability; primary filter for regulatory incident rate calculations."
    - name: "pesticide_involved"
      expr: pesticide_involved
      comment: "Boolean indicating pesticide exposure involvement; triggers EPA WPS reporting and medical surveillance requirements."
    - name: "ppe_in_use"
      expr: ppe_in_use
      comment: "Boolean indicating whether PPE was in use at time of incident; measures PPE program effectiveness."
    - name: "claim_status"
      expr: claim_status
      comment: "Status of the workers compensation claim (open, closed, denied); used for insurance reserve and litigation management."
    - name: "incident_status"
      expr: incident_status
      comment: "Investigation and resolution status of the incident; tracks open investigations requiring management attention."
    - name: "workers_comp_claim_filed"
      expr: workers_comp_claim_filed
      comment: "Boolean indicating whether a workers comp claim was filed; used to compute claim filing rate and insurance cost drivers."
  measures:
    - name: "total_safety_incidents"
      expr: COUNT(1)
      comment: "Total safety incidents recorded. Primary volume metric for incident rate calculations and year-over-year safety trend analysis."
    - name: "osha_recordable_incident_count"
      expr: SUM(CASE WHEN osha_recordable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of OSHA 300 log recordable incidents. Directly feeds OSHA Total Recordable Incident Rate (TRIR) calculation and regulatory reporting."
    - name: "lost_time_incident_count"
      expr: COUNT(CASE WHEN severity_classification = 'Lost-Time' THEN safety_event_id END)
      comment: "Count of incidents resulting in days away from work. Drives Lost Time Incident Rate (LTIR) and workers comp reserve estimates."
    - name: "pesticide_exposure_incident_count"
      expr: SUM(CASE WHEN pesticide_involved = TRUE THEN 1 ELSE 0 END)
      comment: "Count of incidents involving pesticide exposure. Triggers EPA WPS compliance review and medical surveillance obligations."
    - name: "workers_comp_claims_filed_count"
      expr: SUM(CASE WHEN workers_comp_claim_filed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of incidents resulting in workers compensation claims. Primary driver of insurance premium and experience modification rate."
    - name: "total_claim_amount"
      expr: SUM(CAST(claim_amount AS DOUBLE))
      comment: "Total workers compensation claim amount. Measures direct financial impact of workplace injuries on insurance and self-insured retention."
    - name: "avg_claim_amount"
      expr: AVG(CAST(claim_amount AS DOUBLE))
      comment: "Average workers compensation claim amount per incident. Benchmarks claim severity and informs insurance reserve adequacy."
    - name: "incidents_without_ppe_count"
      expr: SUM(CASE WHEN ppe_in_use = FALSE THEN 1 ELSE 0 END)
      comment: "Count of incidents where PPE was not in use. Measures PPE compliance gap and informs targeted safety training interventions."
    - name: "osha_recordable_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN osha_recordable = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of all incidents that are OSHA recordable. Tracks severity profile of the incident portfolio and regulatory exposure concentration."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`workforce_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor time and productivity KPIs covering hours worked, overtime utilization, piece-rate output, and pay accuracy. Enables operations managers and payroll teams to monitor labor deployment efficiency, H-2A guarantee fulfillment, and time-entry data quality."
  source: "`agriculture_ecm`.`workforce`.`time_entry`"
  dimensions:
    - name: "work_date"
      expr: work_date
      comment: "Date of work performed; primary time dimension for daily and weekly labor utilization trending."
    - name: "pay_type"
      expr: pay_type
      comment: "Pay basis for the time entry (hourly, piece-rate); used to segment labor hours by compensation structure."
    - name: "task_type"
      expr: task_type
      comment: "Type of agricultural task performed (e.g., harvest, irrigation, pruning); enables task-level labor cost and productivity analysis."
    - name: "entry_status"
      expr: entry_status
      comment: "Processing status of the time entry (approved, pending, rejected); filters for finalized hours in payroll calculations."
    - name: "is_overtime"
      expr: is_overtime
      comment: "Boolean flag indicating overtime hours; used to segment and monitor overtime labor cost."
    - name: "is_amended"
      expr: is_amended
      comment: "Boolean flag indicating the entry was amended after initial submission; high amendment rates signal timekeeping process issues."
    - name: "visa_type"
      expr: visa_type
      comment: "Visa type of the worker (H-2A, other); enables H-2A-specific guarantee hour tracking."
    - name: "piece_rate_unit_type"
      expr: piece_rate_unit_type
      comment: "Unit of measure for piece-rate work (e.g., bins, flats, pounds); contextualizes piece-rate productivity metrics."
    - name: "payroll_period"
      expr: payroll_period
      comment: "Payroll period identifier; groups time entries for payroll reconciliation and period-over-period comparison."
    - name: "source_system"
      expr: source_system
      comment: "Source system that generated the time entry (e.g., mobile app, biometric clock); used for data quality and system adoption analysis."
  measures:
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular (straight-time) hours worked. Primary labor volume metric for capacity utilization and scheduling efficiency."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked. Elevated overtime signals crew understaffing or harvest peak demand requiring operational response."
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross pay amount from time entries. Cross-referenced against payroll records for pay accuracy and reconciliation."
    - name: "total_piece_rate_units"
      expr: SUM(CAST(piece_rate_units AS DOUBLE))
      comment: "Total units produced under piece-rate arrangements. Primary harvest productivity metric for yield-per-worker analysis."
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate across time entries. Benchmarked against AEWR and minimum wage to identify compliance risk."
    - name: "total_h2a_guarantee_hours"
      expr: SUM(CAST(h2a_guarantee_hours AS DOUBLE))
      comment: "Total H-2A three-fourths guarantee hours from time entries. Compared against actual hours to quantify guarantee shortfall and back-pay liability."
    - name: "amended_entry_count"
      expr: SUM(CASE WHEN is_amended = TRUE THEN 1 ELSE 0 END)
      comment: "Count of amended time entries. High amendment volume indicates timekeeping system issues or supervisory override patterns requiring audit."
    - name: "overtime_hours_pct"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(regular_hours AS DOUBLE)) + SUM(CAST(overtime_hours AS DOUBLE)), 0), 2)
      comment: "Overtime hours as a percentage of total hours. A rising ratio signals labor scheduling inefficiency and cost overrun risk."
    - name: "avg_piece_rate_per_unit"
      expr: AVG(CAST(piece_rate_per_unit AS DOUBLE))
      comment: "Average piece-rate pay per unit. Tracks incentive pay rate trends and informs harvest labor cost modeling."
    - name: "total_time_entries"
      expr: COUNT(1)
      comment: "Total time entries submitted. Baseline volume metric for timekeeping system utilization and payroll processing scale."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`workforce_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce credential and certification KPIs covering pesticide license coverage, OSHA certification status, CDL compliance, and certification expiry risk. Enables HR and EHS leadership to ensure regulatory credential coverage, prevent work stoppages, and manage renewal pipelines."
  source: "`agriculture_ecm`.`workforce`.`workforce_certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g., pesticide applicator, OSHA 10, CDL, HACCP); primary classification for credential portfolio analysis."
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (active, expired, suspended, pending); primary filter for compliance coverage reporting."
    - name: "certification_name"
      expr: certification_name
      comment: "Name of the specific certification; enables granular credential tracking and renewal management."
    - name: "pesticide_applicator_category"
      expr: pesticide_applicator_category
      comment: "EPA pesticide applicator category; used to ensure correct license coverage for restricted-use pesticide applications."
    - name: "pesticide_applicator_class"
      expr: pesticide_applicator_class
      comment: "Pesticide applicator license class (private, commercial); drives regulatory reporting and application authorization."
    - name: "osha_card_type"
      expr: osha_card_type
      comment: "OSHA card type (10-hour, 30-hour); used to verify safety training coverage meets job requirement thresholds."
    - name: "cdl_class"
      expr: cdl_class
      comment: "Commercial Driver License class (A, B, C); ensures equipment operators hold appropriate driving credentials."
    - name: "is_verified"
      expr: is_verified
      comment: "Boolean indicating the certification has been independently verified; unverified credentials represent compliance risk."
    - name: "is_renewal_required"
      expr: is_renewal_required
      comment: "Boolean indicating renewal is required; used to proactively identify and manage upcoming renewal obligations."
    - name: "is_restricted_use_pesticide_authorized"
      expr: is_restricted_use_pesticide_authorized
      comment: "Boolean indicating authorization for restricted-use pesticide application; critical for EPA compliance and application scheduling."
    - name: "job_role_code"
      expr: job_role_code
      comment: "Job role associated with the certification requirement; links credential coverage to position-level compliance obligations."
    - name: "training_provider"
      expr: training_provider
      comment: "Organization that delivered the training; used to evaluate training vendor quality and accreditation."
    - name: "expiration_date"
      expr: expiration_date
      comment: "Certification expiration date; primary time dimension for expiry risk monitoring and renewal pipeline management."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total certification records. Baseline metric for credential portfolio size and coverage analysis."
    - name: "active_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN workforce_certification_id END)
      comment: "Count of currently active certifications. Primary coverage metric ensuring workforce holds required credentials for current operations."
    - name: "expired_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Expired' THEN workforce_certification_id END)
      comment: "Count of expired certifications. Expired credentials represent immediate regulatory non-compliance and work authorization risk."
    - name: "certifications_expiring_within_30_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 30) THEN workforce_certification_id END)
      comment: "Count of certifications expiring within 30 days. Drives urgent renewal prioritization to prevent operational disruptions."
    - name: "certifications_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN workforce_certification_id END)
      comment: "Count of certifications expiring within 90 days. Enables proactive renewal pipeline management and training scheduling."
    - name: "unverified_certification_count"
      expr: SUM(CASE WHEN is_verified = FALSE THEN 1 ELSE 0 END)
      comment: "Count of certifications not yet independently verified. Unverified credentials cannot be relied upon for regulatory compliance purposes."
    - name: "restricted_use_pesticide_authorized_count"
      expr: SUM(CASE WHEN is_restricted_use_pesticide_authorized = TRUE THEN 1 ELSE 0 END)
      comment: "Count of workers authorized for restricted-use pesticide application. Ensures sufficient licensed applicator coverage for spray program execution."
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of workforce certifications. Tracks training and credentialing investment for budget management and ROI analysis."
    - name: "avg_exam_score"
      expr: AVG(CAST(exam_score AS DOUBLE))
      comment: "Average certification exam score. Measures training program effectiveness and identifies knowledge gaps requiring curriculum improvement."
    - name: "total_ceu_hours_completed"
      expr: SUM(CAST(ceu_hours_completed AS DOUBLE))
      comment: "Total continuing education units completed. Tracks workforce professional development investment and regulatory CEU compliance."
    - name: "ceu_hours_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(ceu_hours_completed AS DOUBLE)) / NULLIF(SUM(CAST(ceu_hours_required AS DOUBLE)), 0), 2)
      comment: "CEU hours completed as a percentage of required hours. Measures workforce compliance with continuing education obligations."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`workforce_training_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce training completion and compliance KPIs covering GAP, HACCP, and OSHA certification rates, assessment performance, and CEU credit accumulation. Enables HR and food safety leadership to ensure regulatory training coverage and measure training program effectiveness."
  source: "`agriculture_ecm`.`workforce`.`training_enrollment`"
  dimensions:
    - name: "completion_status"
      expr: completion_status
      comment: "Training completion status (completed, in-progress, failed, withdrawn); primary filter for training compliance reporting."
    - name: "enrollment_date"
      expr: enrollment_date
      comment: "Date of training enrollment; used to track training pipeline and time-to-completion analysis."
    - name: "completion_date"
      expr: completion_date
      comment: "Date training was completed; used for compliance deadline tracking and certificate issuance timing."
    - name: "certificate_issued"
      expr: certificate_issued
      comment: "Boolean indicating whether a certificate was issued upon completion; verifies training resulted in a credentialing outcome."
    - name: "gap_training_completed"
      expr: gap_training_completed
      comment: "Boolean indicating GAP (Good Agricultural Practices) training completion; required for food safety audit compliance."
    - name: "haccp_training_completed"
      expr: haccp_training_completed
      comment: "Boolean indicating HACCP training completion; required for food safety plan implementation and FSMA compliance."
    - name: "osha_safety_certified"
      expr: osha_safety_certified
      comment: "Boolean indicating OSHA safety certification achieved; required for certain equipment operation and supervisory roles."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total training enrollments. Baseline metric for training program scale and workforce development investment."
    - name: "completed_enrollments"
      expr: COUNT(CASE WHEN completion_status = 'Completed' THEN training_enrollment_id END)
      comment: "Count of successfully completed training enrollments. Primary training throughput KPI for compliance coverage tracking."
    - name: "training_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN completion_status = 'Completed' THEN training_enrollment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments resulting in completion. Low completion rates signal scheduling, language, or curriculum barriers requiring intervention."
    - name: "gap_training_completion_count"
      expr: SUM(CASE WHEN gap_training_completed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of employees who completed GAP training. Tracks food safety audit readiness and FSMA compliance coverage."
    - name: "haccp_training_completion_count"
      expr: SUM(CASE WHEN haccp_training_completed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of employees who completed HACCP training. Ensures sufficient trained personnel for food safety plan execution."
    - name: "osha_certified_count"
      expr: SUM(CASE WHEN osha_safety_certified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of employees achieving OSHA safety certification. Measures safety training program reach and regulatory credential coverage."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average training assessment score. Measures knowledge retention and training program effectiveness; low scores trigger curriculum review."
    - name: "total_ceu_credits_earned"
      expr: SUM(CAST(ceu_credits AS DOUBLE))
      comment: "Total continuing education credits earned across all enrollments. Tracks workforce professional development investment and CEU compliance."
    - name: "certificates_issued_count"
      expr: SUM(CASE WHEN certificate_issued = TRUE THEN 1 ELSE 0 END)
      comment: "Count of training certificates issued. Measures credentialing output of the training program and supports compliance documentation."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`workforce_work_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor deployment and assignment KPIs covering scheduled hours, pay rate analysis, REI compliance, and assignment status distribution. Enables operations managers to optimize crew deployment, monitor restricted entry interval compliance, and track labor scheduling efficiency."
  source: "`agriculture_ecm`.`workforce`.`work_assignment`"
  dimensions:
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of work assignment (e.g., harvest, irrigation, pest management); primary classification for labor deployment analysis."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the assignment (active, completed, cancelled); used to filter for active labor deployment."
    - name: "labor_type"
      expr: labor_type
      comment: "Labor category (e.g., H-2A, domestic, contract); drives program-level cost and compliance segmentation."
    - name: "pay_rate_unit"
      expr: pay_rate_unit
      comment: "Unit basis for pay rate (hourly, piece-rate, daily); used to segment assignments by compensation structure."
    - name: "start_date"
      expr: start_date
      comment: "Assignment start date; used to trend labor deployment volume and seasonal workforce planning."
    - name: "end_date"
      expr: end_date
      comment: "Assignment end date; used to identify active assignments and compute assignment duration."
    - name: "seasonal_flag"
      expr: seasonal_flag
      comment: "Boolean indicating a seasonal assignment; used to segment permanent vs. seasonal labor deployment."
    - name: "rei_restricted"
      expr: rei_restricted
      comment: "Boolean indicating the assignment is under a Restricted Entry Interval; critical for pesticide safety compliance."
    - name: "gap_training_required"
      expr: gap_training_required
      comment: "Boolean indicating GAP training is required for this assignment; used to verify training compliance before deployment."
    - name: "haccp_training_required"
      expr: haccp_training_required
      comment: "Boolean indicating HACCP training is required; ensures food safety-trained workers are assigned to critical control point tasks."
    - name: "osha_safety_cert_required"
      expr: osha_safety_cert_required
      comment: "Boolean indicating OSHA certification is required for the assignment; verifies safety credential coverage before deployment."
    - name: "pesticide_applicator_required"
      expr: pesticide_applicator_required
      comment: "Boolean indicating a licensed pesticide applicator is required; ensures regulatory compliance for chemical application tasks."
    - name: "priority"
      expr: priority
      comment: "Assignment priority level; used to triage labor allocation during peak demand periods."
    - name: "shift_pattern"
      expr: shift_pattern
      comment: "Shift pattern for the assignment (e.g., day, night, split); used for scheduling optimization and fatigue risk management."
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total work assignments created. Baseline metric for labor deployment volume and scheduling system utilization."
    - name: "total_scheduled_hours"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total scheduled labor hours across all assignments. Primary capacity planning metric for harvest and operational labor demand."
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average pay rate across work assignments. Benchmarked against AEWR and minimum wage floors to assess wage compliance risk."
    - name: "rei_restricted_assignment_count"
      expr: SUM(CASE WHEN rei_restricted = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assignments under active Restricted Entry Interval. Monitors pesticide safety compliance and worker re-entry authorization."
    - name: "assignments_requiring_gap_training"
      expr: SUM(CASE WHEN gap_training_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assignments requiring GAP training. Used to verify training compliance coverage before worker deployment to food safety-sensitive tasks."
    - name: "assignments_requiring_pesticide_license"
      expr: SUM(CASE WHEN pesticide_applicator_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assignments requiring a licensed pesticide applicator. Ensures sufficient licensed personnel are available for chemical application scheduling."
    - name: "active_assignment_count"
      expr: COUNT(CASE WHEN assignment_status = 'Active' THEN work_assignment_id END)
      comment: "Count of currently active work assignments. Real-time labor deployment metric for operations management and crew utilization tracking."
    - name: "seasonal_assignment_count"
      expr: SUM(CASE WHEN seasonal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of seasonal work assignments. Tracks seasonal labor program scale and informs H-2A petition sizing for future seasons."
$$;