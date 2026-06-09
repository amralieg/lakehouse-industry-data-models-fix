-- Metric views for domain: studio | Business: Gaming | Version: 1 | Generated on: 2026-05-08 09:44:17

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`studio_backlog_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Backlog Item business metrics"
  source: "`gaming_ecm`.`studio`.`backlog_item`"
  dimensions:
    - name: "Acceptance Criteria"
      expr: acceptance_criteria
    - name: "Affected Version"
      expr: affected_version
    - name: "Backlog Item Description"
      expr: backlog_item_description
    - name: "Blocker Reason"
      expr: blocker_reason
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Component"
      expr: component
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Due Date"
      expr: due_date
    - name: "Environment"
      expr: environment
    - name: "Fix Version"
      expr: fix_version
    - name: "Gaas Live Ops Flag"
      expr: gaas_live_ops_flag
    - name: "Is Blocked"
      expr: is_blocked
    - name: "Is Regression"
      expr: is_regression
    - name: "Issue Key"
      expr: issue_key
    - name: "Issue Type"
      expr: issue_type
    - name: "Jira Issue Key"
      expr: jira_issue_key
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Backlog Item"
      expr: COUNT(DISTINCT backlog_item_id)
    - name: "Total Epic Key"
      expr: SUM(epic_key)
    - name: "Average Epic Key"
      expr: AVG(epic_key)
    - name: "Total Original Estimate Hours"
      expr: SUM(original_estimate_hours)
    - name: "Average Original Estimate Hours"
      expr: AVG(original_estimate_hours)
    - name: "Total Time Spent Hours"
      expr: SUM(time_spent_hours)
    - name: "Average Time Spent Hours"
      expr: AVG(time_spent_hours)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`studio_build`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Build business metrics"
  source: "`gaming_ecm`.`studio`.`build`"
  dimensions:
    - name: "Agent"
      expr: agent
    - name: "Artifact Storage Path"
      expr: artifact_storage_path
    - name: "Branch Name"
      expr: branch_name
    - name: "Build Status"
      expr: build_status
    - name: "Build Type"
      expr: build_type
    - name: "Completed Timestamp"
      expr: completed_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dlc Identifier"
      expr: dlc_identifier
    - name: "Duration Seconds"
      expr: duration_seconds
    - name: "Engine Type"
      expr: engine_type
    - name: "Engine Version"
      expr: engine_version
    - name: "Error Count"
      expr: error_count
    - name: "Failure Message"
      expr: failure_message
    - name: "Failure Stage"
      expr: failure_stage
    - name: "Gaas Live Update"
      expr: gaas_live_update
    - name: "Is Automated Trigger"
      expr: is_automated_trigger
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Build"
      expr: COUNT(DISTINCT build_id)
    - name: "Total Artifact Size Mb"
      expr: SUM(artifact_size_mb)
    - name: "Average Artifact Size Mb"
      expr: AVG(artifact_size_mb)
    - name: "Total Build Number"
      expr: SUM(build_number)
    - name: "Average Build Number"
      expr: AVG(build_number)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`studio_dev_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dev Project business metrics"
  source: "`gaming_ecm`.`studio`.`dev_project`"
  dimensions:
    - name: "Actual Ship Date"
      expr: actual_ship_date
    - name: "Cert Approval Date"
      expr: cert_approval_date
    - name: "Cert Submission Date"
      expr: cert_submission_date
    - name: "Cicd Pipeline Url"
      expr: cicd_pipeline_url
    - name: "Coppa Applicable"
      expr: coppa_applicable
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Critical Bug Count"
      expr: critical_bug_count
    - name: "Current Sprint Number"
      expr: current_sprint_number
    - name: "Development Methodology"
      expr: development_methodology
    - name: "Engine Version"
      expr: engine_version
    - name: "Game Engine"
      expr: game_engine
    - name: "Gold Master Date"
      expr: gold_master_date
    - name: "Has Mtx"
      expr: has_mtx
    - name: "Has Ugc"
      expr: has_ugc
    - name: "Headcount Allocated"
      expr: headcount_allocated
    - name: "Is First Party"
      expr: is_first_party
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dev Project"
      expr: COUNT(DISTINCT dev_project_id)
    - name: "Total Milestone Completion Pct"
      expr: SUM(milestone_completion_pct)
    - name: "Average Milestone Completion Pct"
      expr: AVG(milestone_completion_pct)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`studio_game_studio`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Game Studio business metrics"
  source: "`gaming_ecm`.`studio`.`game_studio`"
  dimensions:
    - name: "Acquisition Date"
      expr: acquisition_date
    - name: "Active Project Count"
      expr: active_project_count
    - name: "Cicd Pipeline Enabled"
      expr: cicd_pipeline_enabled
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Contract Tier"
      expr: contract_tier
    - name: "Coppa Compliant"
      expr: coppa_compliant
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crm Account Reference"
      expr: crm_account_reference
    - name: "Data Processing Agreement"
      expr: data_processing_agreement
    - name: "Dissolution Date"
      expr: dissolution_date
    - name: "Engine Primary"
      expr: engine_primary
    - name: "Erp Vendor Reference"
      expr: erp_vendor_reference
    - name: "Esrb Registered"
      expr: esrb_registered
    - name: "Founding Date"
      expr: founding_date
    - name: "Gaas Capable"
      expr: gaas_capable
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Game Studio"
      expr: COUNT(DISTINCT game_studio_id)
    - name: "Total Revenue Share Pct"
      expr: SUM(revenue_share_pct)
    - name: "Average Revenue Share Pct"
      expr: AVG(revenue_share_pct)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`studio_live_ops_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Live Ops Cycle business metrics"
  source: "`gaming_ecm`.`studio`.`live_ops_cycle`"
  dimensions:
    - name: "Actual Dev Hours"
      expr: actual_dev_hours
    - name: "Actual Release Date"
      expr: actual_release_date
    - name: "Cicd Pipeline Run Reference"
      expr: cicd_pipeline_run_reference
    - name: "Content Scope Summary"
      expr: content_scope_summary
    - name: "Coppa Applicable"
      expr: coppa_applicable
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Critical Bug Count At Release"
      expr: critical_bug_count_at_release
    - name: "Cycle Code"
      expr: cycle_code
    - name: "Cycle End Date"
      expr: cycle_end_date
    - name: "Cycle Name"
      expr: cycle_name
    - name: "Cycle Start Date"
      expr: cycle_start_date
    - name: "Cycle Status"
      expr: cycle_status
    - name: "Cycle Type"
      expr: cycle_type
    - name: "Deployment Region"
      expr: deployment_region
    - name: "Esrb Content Descriptor"
      expr: esrb_content_descriptor
    - name: "Estimated Dev Hours"
      expr: estimated_dev_hours
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Live Ops Cycle"
      expr: COUNT(DISTINCT live_ops_cycle_id)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`studio_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Milestone business metrics"
  source: "`gaming_ecm`.`studio`.`milestone`"
  dimensions:
    - name: "Actual Date"
      expr: actual_date
    - name: "Blocker Count"
      expr: blocker_count
    - name: "Build Version"
      expr: build_version
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Critical Bug Count"
      expr: critical_bug_count
    - name: "Deliverables Checklist Url"
      expr: deliverables_checklist_url
    - name: "Deliverables Completed"
      expr: deliverables_completed
    - name: "Deliverables Total"
      expr: deliverables_total
    - name: "Epic Key"
      expr: epic_key
    - name: "Is Greenlight Gate"
      expr: is_greenlight_gate
    - name: "Is Publisher Facing"
      expr: is_publisher_facing
    - name: "Is Signed Off"
      expr: is_signed_off
    - name: "Jira Release Key"
      expr: jira_release_key
    - name: "Milestone Description"
      expr: milestone_description
    - name: "Milestone Name"
      expr: milestone_name
    - name: "Milestone Status"
      expr: milestone_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Milestone"
      expr: COUNT(DISTINCT milestone_id)
    - name: "Total Payment Amount"
      expr: SUM(payment_amount)
    - name: "Average Payment Amount"
      expr: AVG(payment_amount)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`studio_repo`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Repo business metrics"
  source: "`gaming_ecm`.`studio`.`repo`"
  dimensions:
    - name: "Access Control Tier"
      expr: access_control_tier
    - name: "Active Workspace Count"
      expr: active_workspace_count
    - name: "Archived Date"
      expr: archived_date
    - name: "Backup Policy"
      expr: backup_policy
    - name: "Branch Count"
      expr: branch_count
    - name: "Build System"
      expr: build_system
    - name: "Ci Cd Pipeline Enabled"
      expr: ci_cd_pipeline_enabled
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Depot Description"
      expr: depot_description
    - name: "Depot Name"
      expr: depot_name
    - name: "Depot Type"
      expr: depot_type
    - name: "Exclusive Checkout Enabled"
      expr: exclusive_checkout_enabled
    - name: "Gaas Live Ops Enabled"
      expr: gaas_live_ops_enabled
    - name: "Game Engine"
      expr: game_engine
    - name: "Gdpr Applicable"
      expr: gdpr_applicable
    - name: "Gold Master Branch"
      expr: gold_master_branch
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Repo"
      expr: COUNT(DISTINCT repo_id)
    - name: "Total Changelist Count"
      expr: SUM(changelist_count)
    - name: "Average Changelist Count"
      expr: AVG(changelist_count)
    - name: "Total File Count"
      expr: SUM(file_count)
    - name: "Average File Count"
      expr: AVG(file_count)
    - name: "Total Revision Count"
      expr: SUM(revision_count)
    - name: "Average Revision Count"
      expr: AVG(revision_count)
    - name: "Total Storage Quota Gb"
      expr: SUM(storage_quota_gb)
    - name: "Average Storage Quota Gb"
      expr: AVG(storage_quota_gb)
    - name: "Total Storage Used Gb"
      expr: SUM(storage_used_gb)
    - name: "Average Storage Used Gb"
      expr: AVG(storage_used_gb)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`studio_sprint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sprint business metrics"
  source: "`gaming_ecm`.`studio`.`sprint`"
  dimensions:
    - name: "Added Story Points"
      expr: added_story_points
    - name: "Blockers Count"
      expr: blockers_count
    - name: "Bug Issues"
      expr: bug_issues
    - name: "Build Number"
      expr: build_number
    - name: "Committed Story Points"
      expr: committed_story_points
    - name: "Completed Date"
      expr: completed_date
    - name: "Completed Issues"
      expr: completed_issues
    - name: "Completed Story Points"
      expr: completed_story_points
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Duration Days"
      expr: duration_days
    - name: "End Date"
      expr: end_date
    - name: "Goal"
      expr: goal
    - name: "Health"
      expr: health
    - name: "Incomplete Issues"
      expr: incomplete_issues
    - name: "Is Gaas Sprint"
      expr: is_gaas_sprint
    - name: "Perforce Changelist"
      expr: perforce_changelist
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sprint"
      expr: COUNT(DISTINCT sprint_id)
    - name: "Total Board Reference"
      expr: SUM(board_reference)
    - name: "Average Board Reference"
      expr: AVG(board_reference)
    - name: "Total Epic Key"
      expr: SUM(epic_key)
    - name: "Average Epic Key"
      expr: AVG(epic_key)
    - name: "Total Jira Sprint Key"
      expr: SUM(jira_sprint_key)
    - name: "Average Jira Sprint Key"
      expr: AVG(jira_sprint_key)
$$;