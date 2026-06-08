-- Metric views for domain: talent | Business: Media Broadcasting | Version: 1 | Generated on: 2026-05-08 17:09:06

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`talent_appearance_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key operational KPIs for talent appearance scheduling: volume, time commitment, and exclusivity conflicts"
  source: "`media_broadcasting_ecm`.`talent`.`appearance_schedule`"
  dimensions:
    - name: "appearance_type"
      expr: appearance_type
      comment: "Category of appearance (e.g., interview, performance, cameo)"
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the scheduled appearance (e.g., prime, daytime, late night)"
    - name: "call_date_month"
      expr: DATE_TRUNC('month', call_date)
      comment: "Month of the call date for time‑based trend analysis"
  measures:
    - name: "total_estimated_hours"
      expr: SUM(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Sum of all estimated duration hours for scheduled talent appearances"
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_duration_hours AS DOUBLE))
      comment: "Sum of all actual duration hours recorded for talent appearances"
    - name: "appearance_count"
      expr: COUNT(1)
      comment: "Number of appearance schedule records (i.e., total scheduled appearances)"
    - name: "exclusivity_conflict_appearances"
      expr: SUM(CASE WHEN exclusivity_conflict_flag THEN 1 ELSE 0 END)
      comment: "Count of appearances that triggered an exclusivity conflict"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`talent_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic financial view of talent contracts: spend, duration, and active count"
  source: "`media_broadcasting_ecm`.`talent`.`contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract (e.g., Active, Expired, Terminated)"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g., Fixed‑Fee, Revenue Share)"
  measures:
    - name: "total_base_compensation"
      expr: SUM(CAST(base_compensation_amount AS DOUBLE))
      comment: "Total base compensation amount across contracts"
    - name: "average_contract_duration_days"
      expr: AVG(DATEDIFF(effective_end_date, effective_start_date))
      comment: "Average contract length in days"
    - name: "active_contracts"
      expr: SUM(CASE WHEN contract_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of contracts currently active"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`talent_role`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance and cost view of talent roles and credits"
  source: "`media_broadcasting_ecm`.`talent`.`role`"
  dimensions:
    - name: "role_name"
      expr: role_name
      comment: "Descriptive name of the role (e.g., Lead Actor, Supporting)"
    - name: "credit_type"
      expr: credit_type
      comment: "Type of credit (e.g., On‑Screen, End‑Credit)"
  measures:
    - name: "total_role_compensation"
      expr: SUM(CAST(compensation_amount AS DOUBLE))
      comment: "Total compensation paid for talent roles/credits"
    - name: "total_screen_time_minutes"
      expr: SUM(CAST(screen_time_minutes AS DOUBLE))
      comment: "Aggregate screen time across all role records"
    - name: "average_compensation_per_role"
      expr: AVG(CAST(compensation_amount AS DOUBLE))
      comment: "Average compensation per role instance"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`talent_residual_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial KPI for residual payments, tracking gross and net payouts"
  source: "`media_broadcasting_ecm`.`talent`.`residual_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., Paid, Pending, Failed)"
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of the payment for trend analysis"
  measures:
    - name: "total_gross_residual"
      expr: SUM(CAST(gross_residual_amount AS DOUBLE))
      comment: "Total gross residual amounts paid to talent"
    - name: "total_net_payment"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment after deductions"
    - name: "average_gross_residual"
      expr: AVG(CAST(gross_residual_amount AS DOUBLE))
      comment: "Average gross residual per payment record"
$$;