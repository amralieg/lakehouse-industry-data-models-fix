-- Metric views for domain: workforce | Business: Manufacturing | Version: 1 | Generated on: 2026-05-06 08:25:38

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`workforce_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruiting and staffing KPIs"
  source: "`manufacturing_ecm`.`workforce`.`requisition`"
  dimensions:
    - name: "org_unit_id"
      expr: org_unit_id
      comment: "Organizational unit requesting the hire"
    - name: "job_profile_id"
      expr: job_profile_id
      comment: "Job profile associated with the requisition"
    - name: "location_id"
      expr: location_id
      comment: "Location of the position"
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of the requisition"
    - name: "priority_level"
      expr: priority_level
      comment: "Business priority of the requisition"
    - name: "opened_date"
      expr: opened_date
      comment: "Date the requisition was opened"
  measures:
    - name: "total_requisitions"
      expr: COUNT(1)
      comment: "Total number of requisitions created"
    - name: "active_requisition_count"
      expr: SUM(CASE WHEN is_active THEN 1 ELSE 0 END)
      comment: "Count of currently active requisitions"
    - name: "average_salary_range_max"
      expr: AVG(CAST(salary_range_max AS DOUBLE))
      comment: "Average maximum salary range offered"
    - name: "average_salary_range_min"
      expr: AVG(CAST(salary_range_min AS DOUBLE))
      comment: "Average minimum salary range offered"
    - name: "filled_requisition_count"
      expr: SUM(CASE WHEN positions_filled IS NOT NULL AND positions_filled != '' THEN 1 ELSE 0 END)
      comment: "Count of requisitions with at least one filled position"
$$;