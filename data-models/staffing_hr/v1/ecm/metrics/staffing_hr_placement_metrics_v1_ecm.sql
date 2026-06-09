-- Metric views for domain: placement | Business: Staffing Hr | Version: 1 | Generated on: 2026-05-02 15:43:14

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`placement_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core assignment metrics tracking contractor placements, rates, margins, and lifecycle events"
  source: "`staffing_hr_ecm`.`placement`.`assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the assignment (active, completed, cancelled, etc.)"
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of assignment (contract, contract-to-hire, temp-to-perm, etc.)"
    - name: "worker_classification"
      expr: worker_classification
      comment: "Worker classification (W2, 1099, etc.)"
    - name: "flsa_classification"
      expr: flsa_classification
      comment: "FLSA classification (exempt, non-exempt)"
    - name: "job_title"
      expr: job_title
      comment: "Job title for the assignment"
    - name: "department"
      expr: department
      comment: "Client department where worker is placed"
    - name: "is_remote"
      expr: is_remote
      comment: "Whether the assignment is remote"
    - name: "is_backfill"
      expr: is_backfill
      comment: "Whether this assignment is a backfill for another worker"
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current onboarding status of the worker"
    - name: "bgc_status"
      expr: bgc_status
      comment: "Background check status"
    - name: "drug_screen_status"
      expr: drug_screen_status
      comment: "Drug screening status"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the assignment started"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the assignment started"
    - name: "scheduled_end_year"
      expr: YEAR(scheduled_end_date)
      comment: "Year the assignment is scheduled to end"
    - name: "scheduled_end_month"
      expr: DATE_TRUNC('MONTH', scheduled_end_date)
      comment: "Month the assignment is scheduled to end"
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total number of assignments"
    - name: "total_bill_rate_revenue"
      expr: SUM(CAST(bill_rate AS DOUBLE))
      comment: "Sum of all bill rates across assignments"
    - name: "total_pay_rate_cost"
      expr: SUM(CAST(pay_rate AS DOUBLE))
      comment: "Sum of all pay rates across assignments"
    - name: "total_spread"
      expr: SUM(CAST(spread AS DOUBLE))
      comment: "Sum of spread (bill rate minus pay rate) across assignments"
    - name: "avg_bill_rate"
      expr: AVG(CAST(bill_rate AS DOUBLE))
      comment: "Average bill rate per assignment"
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average pay rate per assignment"
    - name: "avg_spread"
      expr: AVG(CAST(spread AS DOUBLE))
      comment: "Average spread per assignment"
    - name: "avg_markup_percentage"
      expr: AVG(CAST(markup_percentage AS DOUBLE))
      comment: "Average markup percentage across assignments"
    - name: "avg_scheduled_hours_per_week"
      expr: AVG(CAST(scheduled_hours_per_week AS DOUBLE))
      comment: "Average scheduled hours per week across assignments"
    - name: "total_conversion_fees"
      expr: SUM(CAST(conversion_fee AS DOUBLE))
      comment: "Total conversion fees collected from assignments converting to permanent"
    - name: "unique_clients"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of unique client accounts with assignments"
    - name: "unique_workers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique workers placed"
    - name: "unique_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers providing workers"
    - name: "backfill_assignments"
      expr: SUM(CASE WHEN is_backfill = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assignments that are backfills"
    - name: "remote_assignments"
      expr: SUM(CASE WHEN is_remote = TRUE THEN 1 ELSE 0 END)
      comment: "Count of remote assignments"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`placement_conversion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Conversion metrics tracking temp-to-perm conversions, fees, and conversion performance"
  source: "`staffing_hr_ecm`.`placement`.`conversion`"
  dimensions:
    - name: "conversion_status"
      expr: conversion_status
      comment: "Status of the conversion (pending, completed, cancelled, etc.)"
    - name: "conversion_type"
      expr: conversion_type
      comment: "Type of conversion (temp-to-perm, contract-to-hire, etc.)"
    - name: "fee_basis_type"
      expr: fee_basis_type
      comment: "Basis for fee calculation (percentage, flat fee, hours-based, etc.)"
    - name: "fee_waiver_flag"
      expr: fee_waiver_flag
      comment: "Whether the conversion fee was waived"
    - name: "job_title"
      expr: job_title
      comment: "Job title of the converted worker"
    - name: "conversion_year"
      expr: YEAR(conversion_date)
      comment: "Year the conversion occurred"
    - name: "conversion_month"
      expr: DATE_TRUNC('MONTH', conversion_date)
      comment: "Month the conversion occurred"
    - name: "notice_year"
      expr: YEAR(notice_date)
      comment: "Year conversion notice was received"
    - name: "notice_month"
      expr: DATE_TRUNC('MONTH', notice_date)
      comment: "Month conversion notice was received"
  measures:
    - name: "total_conversions"
      expr: COUNT(1)
      comment: "Total number of conversions"
    - name: "total_conversion_fee_revenue"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total conversion fee revenue collected"
    - name: "avg_conversion_fee"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average conversion fee per conversion"
    - name: "avg_fee_percentage"
      expr: AVG(CAST(fee_percentage AS DOUBLE))
      comment: "Average fee percentage for percentage-based conversions"
    - name: "avg_converted_salary"
      expr: AVG(CAST(converted_worker_annual_salary AS DOUBLE))
      comment: "Average annual salary of converted workers"
    - name: "total_converted_salary_value"
      expr: SUM(CAST(converted_worker_annual_salary AS DOUBLE))
      comment: "Total annual salary value of all converted workers"
    - name: "avg_hours_worked_before_conversion"
      expr: AVG(CAST(actual_hours_worked AS DOUBLE))
      comment: "Average hours worked before conversion"
    - name: "fee_waived_conversions"
      expr: SUM(CASE WHEN fee_waiver_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of conversions where fee was waived"
    - name: "unique_converted_clients"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of unique clients with conversions"
    - name: "unique_converted_workers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique workers converted to permanent"
    - name: "fall_off_conversions"
      expr: SUM(CASE WHEN fall_off_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of conversions that subsequently fell off"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`placement_direct_hire`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Direct hire placement metrics tracking permanent placements, fees, and placement performance"
  source: "`staffing_hr_ecm`.`placement`.`direct_hire`"
  dimensions:
    - name: "placement_status"
      expr: placement_status
      comment: "Status of the direct hire placement"
    - name: "placement_type"
      expr: placement_type
      comment: "Type of direct hire placement"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type (full-time, part-time, etc.)"
    - name: "exempt_status"
      expr: exempt_status
      comment: "FLSA exempt status"
    - name: "work_arrangement"
      expr: work_arrangement
      comment: "Work arrangement (remote, hybrid, on-site)"
    - name: "job_title"
      expr: job_title
      comment: "Job title of the placement"
    - name: "department"
      expr: department
      comment: "Department where worker is placed"
    - name: "sourcing_channel"
      expr: sourcing_channel
      comment: "Channel through which candidate was sourced"
    - name: "bgc_status"
      expr: bgc_status
      comment: "Background check status"
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Onboarding status of the placement"
    - name: "replacement_obligation"
      expr: replacement_obligation
      comment: "Whether there is a replacement obligation if placement fails"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the placement started"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the placement started"
    - name: "offer_year"
      expr: YEAR(offer_date)
      comment: "Year the offer was made"
    - name: "offer_month"
      expr: DATE_TRUNC('MONTH', offer_date)
      comment: "Month the offer was made"
  measures:
    - name: "total_direct_hires"
      expr: COUNT(1)
      comment: "Total number of direct hire placements"
    - name: "total_placement_fee_revenue"
      expr: SUM(CAST(base_salary AS DOUBLE) * CAST(fee_percentage AS DOUBLE) / 100.0)
      comment: "Total placement fee revenue based on salary and fee percentage"
    - name: "avg_base_salary"
      expr: AVG(CAST(base_salary AS DOUBLE))
      comment: "Average base salary of direct hire placements"
    - name: "total_base_salary_value"
      expr: SUM(CAST(base_salary AS DOUBLE))
      comment: "Total base salary value of all direct hire placements"
    - name: "avg_fee_percentage"
      expr: AVG(CAST(fee_percentage AS DOUBLE))
      comment: "Average fee percentage for direct hire placements"
    - name: "total_conversion_fees"
      expr: SUM(CAST(conversion_fee_amount AS DOUBLE))
      comment: "Total conversion fees for placements that converted from temp"
    - name: "unique_clients"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of unique clients with direct hire placements"
    - name: "unique_workers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique workers placed via direct hire"
    - name: "unique_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers providing direct hire candidates"
    - name: "fall_off_placements"
      expr: SUM(CASE WHEN fall_off_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of direct hire placements that fell off"
    - name: "fee_collected_placements"
      expr: SUM(CASE WHEN fee_collected = TRUE THEN 1 ELSE 0 END)
      comment: "Count of placements where fee has been collected"
    - name: "fee_invoiced_placements"
      expr: SUM(CASE WHEN fee_invoiced = TRUE THEN 1 ELSE 0 END)
      comment: "Count of placements where fee has been invoiced"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`placement_fall_off`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fall-off metrics tracking placement failures, reasons, and financial impact"
  source: "`staffing_hr_ecm`.`placement`.`fall_off`"
  dimensions:
    - name: "fall_off_status"
      expr: fall_off_status
      comment: "Status of the fall-off event"
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for the fall-off"
    - name: "reason_detail"
      expr: reason_detail
      comment: "Detailed reason for the fall-off"
    - name: "placement_type"
      expr: placement_type
      comment: "Type of placement that fell off"
    - name: "replacement_obligation"
      expr: replacement_obligation
      comment: "Whether there is an obligation to replace the worker"
    - name: "replacement_status"
      expr: replacement_status
      comment: "Status of replacement fulfillment"
    - name: "within_guarantee_period"
      expr: within_guarantee_period
      comment: "Whether fall-off occurred within guarantee period"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the fall-off was escalated"
    - name: "msp_program_flag"
      expr: msp_program_flag
      comment: "Whether this was part of an MSP program"
    - name: "fall_off_year"
      expr: YEAR(fall_off_date)
      comment: "Year the fall-off occurred"
    - name: "fall_off_month"
      expr: DATE_TRUNC('MONTH', fall_off_date)
      comment: "Month the fall-off occurred"
  measures:
    - name: "total_fall_offs"
      expr: COUNT(1)
      comment: "Total number of fall-off events"
    - name: "total_revenue_impact"
      expr: SUM(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Total revenue impact from all fall-offs"
    - name: "avg_revenue_impact"
      expr: AVG(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Average revenue impact per fall-off"
    - name: "total_fee_credits"
      expr: SUM(CAST(fee_credit_amount AS DOUBLE))
      comment: "Total fee credits issued due to fall-offs"
    - name: "avg_fee_credit"
      expr: AVG(CAST(fee_credit_amount AS DOUBLE))
      comment: "Average fee credit per fall-off"
    - name: "total_placement_fees_at_risk"
      expr: SUM(CAST(placement_fee_amount AS DOUBLE))
      comment: "Total placement fees at risk from fall-offs"
    - name: "avg_days_to_fall_off"
      expr: AVG(CAST(days_to_fall_off AS DOUBLE))
      comment: "Average days from placement start to fall-off"
    - name: "avg_bill_rate"
      expr: AVG(CAST(bill_rate AS DOUBLE))
      comment: "Average bill rate of placements that fell off"
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average pay rate of placements that fell off"
    - name: "unique_clients_with_fall_offs"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of unique clients experiencing fall-offs"
    - name: "unique_workers_falling_off"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique workers who fell off"
    - name: "fall_offs_within_guarantee"
      expr: SUM(CASE WHEN within_guarantee_period = TRUE THEN 1 ELSE 0 END)
      comment: "Count of fall-offs within guarantee period"
    - name: "fall_offs_with_replacement_obligation"
      expr: SUM(CASE WHEN replacement_obligation = TRUE THEN 1 ELSE 0 END)
      comment: "Count of fall-offs with replacement obligation"
    - name: "escalated_fall_offs"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of fall-offs that were escalated"
    - name: "replacements_fulfilled"
      expr: SUM(CASE WHEN replacement_fulfilled_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of fall-offs where replacement was fulfilled"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`placement_backfill`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Backfill metrics tracking replacement requests, time-to-fill, and backfill performance"
  source: "`staffing_hr_ecm`.`placement`.`backfill`"
  dimensions:
    - name: "backfill_status"
      expr: backfill_status
      comment: "Status of the backfill request"
    - name: "trigger_reason"
      expr: trigger_reason
      comment: "Reason that triggered the backfill need"
    - name: "fall_off_reason_category"
      expr: fall_off_reason_category
      comment: "Category of fall-off reason if applicable"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the backfill request"
    - name: "placement_type"
      expr: placement_type
      comment: "Type of placement being backfilled"
    - name: "job_title"
      expr: job_title
      comment: "Job title for the backfill position"
    - name: "department"
      expr: department
      comment: "Department requiring backfill"
    - name: "is_fall_off"
      expr: is_fall_off
      comment: "Whether backfill is due to a fall-off"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the backfill was escalated"
    - name: "sla_met"
      expr: sla_met
      comment: "Whether SLA for backfill was met"
    - name: "request_year"
      expr: YEAR(request_date)
      comment: "Year the backfill was requested"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month the backfill was requested"
  measures:
    - name: "total_backfill_requests"
      expr: COUNT(1)
      comment: "Total number of backfill requests"
    - name: "avg_days_to_backfill"
      expr: AVG(CAST(days_to_backfill AS DOUBLE))
      comment: "Average days to fill a backfill request"
    - name: "avg_bill_rate"
      expr: AVG(CAST(bill_rate AS DOUBLE))
      comment: "Average bill rate for backfill positions"
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average pay rate for backfill positions"
    - name: "unique_clients_with_backfills"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of unique clients with backfill requests"
    - name: "unique_suppliers_providing_backfills"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers providing backfill workers"
    - name: "backfills_due_to_fall_off"
      expr: SUM(CASE WHEN is_fall_off = TRUE THEN 1 ELSE 0 END)
      comment: "Count of backfills triggered by fall-offs"
    - name: "escalated_backfills"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of backfills that were escalated"
    - name: "backfills_meeting_sla"
      expr: SUM(CASE WHEN sla_met = TRUE THEN 1 ELSE 0 END)
      comment: "Count of backfills that met SLA"
    - name: "filled_backfills"
      expr: SUM(CASE WHEN filled_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of backfills that were successfully filled"
    - name: "cancelled_backfills"
      expr: SUM(CASE WHEN cancelled_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of backfills that were cancelled"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`placement_bench_roster`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bench roster metrics tracking available workers, redeployment readiness, and bench costs"
  source: "`staffing_hr_ecm`.`placement`.`bench_roster`"
  dimensions:
    - name: "bench_status"
      expr: bench_status
      comment: "Current status of worker on bench"
    - name: "redeployment_readiness"
      expr: redeployment_readiness
      comment: "Readiness level for redeployment"
    - name: "primary_skill"
      expr: primary_skill
      comment: "Primary skill of the benched worker"
    - name: "skill_category"
      expr: skill_category
      comment: "Category of worker skills"
    - name: "worker_classification"
      expr: worker_classification
      comment: "Classification of the worker"
    - name: "ending_job_title"
      expr: ending_job_title
      comment: "Job title from last assignment"
    - name: "preferred_work_type"
      expr: preferred_work_type
      comment: "Worker's preferred work type"
    - name: "preferred_location"
      expr: preferred_location
      comment: "Worker's preferred work location"
    - name: "remote_eligible"
      expr: remote_eligible
      comment: "Whether worker is eligible for remote work"
    - name: "willing_to_relocate"
      expr: willing_to_relocate
      comment: "Whether worker is willing to relocate"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the worker"
    - name: "bgc_status"
      expr: bgc_status
      comment: "Background check status"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for redeployment"
    - name: "bench_cost_risk"
      expr: bench_cost_risk
      comment: "Cost risk level of keeping worker on bench"
    - name: "bench_entry_year"
      expr: YEAR(bench_entry_date)
      comment: "Year worker entered bench"
    - name: "bench_entry_month"
      expr: DATE_TRUNC('MONTH', bench_entry_date)
      comment: "Month worker entered bench"
  measures:
    - name: "total_bench_workers"
      expr: COUNT(1)
      comment: "Total number of workers on bench"
    - name: "avg_days_on_bench"
      expr: AVG(CAST(days_on_bench AS DOUBLE))
      comment: "Average days workers have been on bench"
    - name: "avg_last_bill_rate"
      expr: AVG(CAST(last_bill_rate AS DOUBLE))
      comment: "Average last bill rate of benched workers"
    - name: "avg_last_pay_rate"
      expr: AVG(CAST(last_pay_rate AS DOUBLE))
      comment: "Average last pay rate of benched workers"
    - name: "avg_minimum_pay_rate"
      expr: AVG(CAST(minimum_pay_rate AS DOUBLE))
      comment: "Average minimum acceptable pay rate for benched workers"
    - name: "total_submittals"
      expr: SUM(CAST(submittals_count AS DOUBLE))
      comment: "Total submittals for benched workers"
    - name: "total_interviews"
      expr: SUM(CAST(interviews_count AS DOUBLE))
      comment: "Total interviews for benched workers"
    - name: "avg_outreach_attempts"
      expr: AVG(CAST(outreach_attempts AS DOUBLE))
      comment: "Average outreach attempts per benched worker"
    - name: "unique_clients"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of unique clients with workers on bench"
    - name: "remote_eligible_workers"
      expr: SUM(CASE WHEN remote_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of workers eligible for remote work"
    - name: "willing_to_relocate_workers"
      expr: SUM(CASE WHEN willing_to_relocate = TRUE THEN 1 ELSE 0 END)
      comment: "Count of workers willing to relocate"
    - name: "i9_verified_workers"
      expr: SUM(CASE WHEN i9_verified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of workers with verified I-9"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`placement_redeployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Redeployment metrics tracking worker redeployment efforts, outcomes, and time-to-redeploy"
  source: "`staffing_hr_ecm`.`placement`.`redeployment`"
  dimensions:
    - name: "redeployment_status"
      expr: redeployment_status
      comment: "Status of the redeployment effort"
    - name: "redeployment_type"
      expr: redeployment_type
      comment: "Type of redeployment"
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the redeployment effort"
    - name: "redeployment_source"
      expr: redeployment_source
      comment: "Source of the redeployment opportunity"
    - name: "primary_skill"
      expr: primary_skill
      comment: "Primary skill of the worker being redeployed"
    - name: "skill_category"
      expr: skill_category
      comment: "Skill category of the worker"
    - name: "worker_classification"
      expr: worker_classification
      comment: "Classification of the worker"
    - name: "preferred_work_type"
      expr: preferred_work_type
      comment: "Worker's preferred work type"
    - name: "preferred_location"
      expr: preferred_location
      comment: "Worker's preferred location"
    - name: "remote_eligible"
      expr: remote_eligible
      comment: "Whether worker is eligible for remote work"
    - name: "willing_to_relocate"
      expr: willing_to_relocate
      comment: "Whether worker is willing to relocate"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the redeployment"
    - name: "is_backfill"
      expr: is_backfill
      comment: "Whether redeployment is for a backfill position"
    - name: "separation_reason"
      expr: separation_reason
      comment: "Reason for separation from previous assignment"
  measures:
    - name: "total_redeployment_efforts"
      expr: COUNT(1)
      comment: "Total number of redeployment efforts"
    - name: "total_submittals"
      expr: SUM(CAST(submittals_count AS DOUBLE))
      comment: "Total submittals for redeployment"
    - name: "total_interviews"
      expr: SUM(CAST(interviews_count AS DOUBLE))
      comment: "Total interviews for redeployment"
    - name: "avg_outreach_attempts"
      expr: AVG(CAST(outreach_attempts AS DOUBLE))
      comment: "Average outreach attempts per redeployment"
    - name: "avg_minimum_pay_rate"
      expr: AVG(CAST(pay_rate_min AS DOUBLE))
      comment: "Average minimum pay rate for redeployment"
    - name: "total_bench_cost_risk"
      expr: SUM(CAST(bench_cost_risk AS DOUBLE))
      comment: "Total bench cost risk for workers being redeployed"
    - name: "avg_bench_cost_risk"
      expr: AVG(CAST(bench_cost_risk AS DOUBLE))
      comment: "Average bench cost risk per redeployment"
    - name: "total_conversion_fees"
      expr: SUM(CAST(conversion_fee AS DOUBLE))
      comment: "Total conversion fees from redeployments"
    - name: "unique_workers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique workers in redeployment"
    - name: "unique_target_clients"
      expr: COUNT(DISTINCT target_client_client_account_id)
      comment: "Number of unique target clients for redeployment"
    - name: "unique_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers involved in redeployment"
    - name: "successful_redeployments"
      expr: SUM(CASE WHEN actual_redeploy_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of successful redeployments"
    - name: "backfill_redeployments"
      expr: SUM(CASE WHEN is_backfill = TRUE THEN 1 ELSE 0 END)
      comment: "Count of redeployments for backfill positions"
    - name: "remote_eligible_workers"
      expr: SUM(CASE WHEN remote_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of remote-eligible workers in redeployment"
    - name: "willing_to_relocate_workers"
      expr: SUM(CASE WHEN willing_to_relocate = TRUE THEN 1 ELSE 0 END)
      comment: "Count of workers willing to relocate"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`placement_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Offer metrics tracking offer acceptance, decline rates, time-to-acceptance, and offer competitiveness"
  source: "`staffing_hr_ecm`.`placement`.`offer`"
  dimensions:
    - name: "offer_status"
      expr: offer_status
      comment: "Status of the offer (pending, accepted, declined, rescinded)"
    - name: "offer_type"
      expr: offer_type
      comment: "Type of offer (direct hire, contract, contract-to-hire, etc.)"
    - name: "placement_type"
      expr: placement_type
      comment: "Type of placement being offered"
    - name: "worker_classification"
      expr: worker_classification
      comment: "Worker classification for the offer"
    - name: "exempt_status"
      expr: exempt_status
      comment: "FLSA exempt status"
    - name: "work_arrangement"
      expr: work_arrangement
      comment: "Work arrangement (remote, hybrid, on-site)"
    - name: "job_title"
      expr: job_title
      comment: "Job title for the offer"
    - name: "department"
      expr: department
      comment: "Department for the position"
    - name: "sourcing_channel"
      expr: sourcing_channel
      comment: "Channel through which candidate was sourced"
    - name: "decline_reason_code"
      expr: decline_reason_code
      comment: "Coded reason for offer decline"
    - name: "rescind_reason_code"
      expr: rescind_reason_code
      comment: "Coded reason for offer rescission"
    - name: "bgc_required"
      expr: bgc_required
      comment: "Whether background check is required"
    - name: "drug_screen_required"
      expr: drug_screen_required
      comment: "Whether drug screen is required"
    - name: "offer_year"
      expr: YEAR(offer_date)
      comment: "Year the offer was made"
    - name: "offer_month"
      expr: DATE_TRUNC('MONTH', offer_date)
      comment: "Month the offer was made"
  measures:
    - name: "total_offers"
      expr: COUNT(1)
      comment: "Total number of offers made"
    - name: "avg_annual_salary"
      expr: AVG(CAST(annual_salary AS DOUBLE))
      comment: "Average annual salary offered"
    - name: "avg_bill_rate"
      expr: AVG(CAST(bill_rate AS DOUBLE))
      comment: "Average bill rate offered"
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average pay rate offered"
    - name: "avg_markup_percentage"
      expr: AVG(CAST(markup_percentage AS DOUBLE))
      comment: "Average markup percentage on offers"
    - name: "total_sign_on_bonuses"
      expr: SUM(CAST(sign_on_bonus AS DOUBLE))
      comment: "Total sign-on bonuses offered"
    - name: "avg_sign_on_bonus"
      expr: AVG(CAST(sign_on_bonus AS DOUBLE))
      comment: "Average sign-on bonus per offer"
    - name: "avg_counter_offer_amount"
      expr: AVG(CAST(counter_offer_amount AS DOUBLE))
      comment: "Average counter-offer amount"
    - name: "avg_days_to_acceptance"
      expr: AVG(CAST(to_acceptance_days AS DOUBLE))
      comment: "Average days from offer to acceptance"
    - name: "avg_negotiation_rounds"
      expr: AVG(CAST(negotiation_round_count AS DOUBLE))
      comment: "Average number of negotiation rounds per offer"
    - name: "unique_clients"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of unique clients with offers"
    - name: "unique_candidates"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique candidates receiving offers"
    - name: "unique_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers with offers"
    - name: "accepted_offers"
      expr: SUM(CASE WHEN accepted_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of accepted offers"
    - name: "declined_offers"
      expr: SUM(CASE WHEN declined_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of declined offers"
    - name: "rescinded_offers"
      expr: SUM(CASE WHEN rescinded_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of rescinded offers"
    - name: "offers_with_sign_on_bonus"
      expr: SUM(CASE WHEN sign_on_bonus > 0 THEN 1 ELSE 0 END)
      comment: "Count of offers including sign-on bonus"
    - name: "offers_with_counter"
      expr: SUM(CASE WHEN counter_offer_amount IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of offers with counter-offer"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`placement_assignment_extension`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assignment extension metrics tracking extension requests, approvals, rate changes, and extension performance"
  source: "`staffing_hr_ecm`.`placement`.`assignment_extension`"
  dimensions:
    - name: "extension_status"
      expr: extension_status
      comment: "Status of the extension request"
    - name: "extension_reason_code"
      expr: extension_reason_code
      comment: "Coded reason for the extension"
    - name: "worker_classification"
      expr: worker_classification
      comment: "Worker classification"
    - name: "work_location_type"
      expr: work_location_type
      comment: "Type of work location"
    - name: "rate_change_flag"
      expr: rate_change_flag
      comment: "Whether rates changed with the extension"
    - name: "conversion_eligible_flag"
      expr: conversion_eligible_flag
      comment: "Whether worker is eligible for conversion"
    - name: "fall_off_risk_flag"
      expr: fall_off_risk_flag
      comment: "Whether there is fall-off risk"
    - name: "redeployment_candidate_flag"
      expr: redeployment_candidate_flag
      comment: "Whether worker is a redeployment candidate"
    - name: "msp_program_flag"
      expr: msp_program_flag
      comment: "Whether this is part of an MSP program"
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason for extension rejection if applicable"
    - name: "request_year"
      expr: YEAR(request_date)
      comment: "Year the extension was requested"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month the extension was requested"
  measures:
    - name: "total_extension_requests"
      expr: COUNT(1)
      comment: "Total number of extension requests"
    - name: "avg_extension_duration_days"
      expr: AVG(CAST(extension_duration_days AS DOUBLE))
      comment: "Average extension duration in days"
    - name: "avg_prior_bill_rate"
      expr: AVG(CAST(prior_bill_rate AS DOUBLE))
      comment: "Average bill rate before extension"
    - name: "avg_revised_bill_rate"
      expr: AVG(CAST(revised_bill_rate AS DOUBLE))
      comment: "Average bill rate after extension"
    - name: "avg_prior_pay_rate"
      expr: AVG(CAST(prior_pay_rate AS DOUBLE))
      comment: "Average pay rate before extension"
    - name: "avg_revised_pay_rate"
      expr: AVG(CAST(revised_pay_rate AS DOUBLE))
      comment: "Average pay rate after extension"
    - name: "avg_prior_spread"
      expr: AVG(CAST(spread_prior AS DOUBLE))
      comment: "Average spread before extension"
    - name: "avg_revised_spread"
      expr: AVG(CAST(spread_revised AS DOUBLE))
      comment: "Average spread after extension"
    - name: "unique_clients"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of unique clients with extension requests"
    - name: "unique_workers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique workers with extension requests"
    - name: "unique_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers with extension requests"
    - name: "approved_extensions"
      expr: SUM(CASE WHEN approval_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of approved extensions"
    - name: "executed_extensions"
      expr: SUM(CASE WHEN executed_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of executed extensions"
    - name: "extensions_with_rate_change"
      expr: SUM(CASE WHEN rate_change_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of extensions with rate changes"
    - name: "conversion_eligible_extensions"
      expr: SUM(CASE WHEN conversion_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of extensions where worker is conversion-eligible"
    - name: "fall_off_risk_extensions"
      expr: SUM(CASE WHEN fall_off_risk_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of extensions with fall-off risk"
$$;