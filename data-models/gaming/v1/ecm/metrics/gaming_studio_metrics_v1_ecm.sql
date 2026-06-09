-- Metric views for domain: studio | Business: Gaming | Version: 1 | Generated on: 2026-05-08 07:57:15

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

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`studio_certification_test_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Certification Test Run business metrics"
  source: "`gaming_ecm`.`studio`.`certification_test_run`"
  dimensions:
    - name: "Advisory Failure Count"
      expr: advisory_failure_count
    - name: "Certification Outcome"
      expr: certification_outcome
    - name: "Certification Status"
      expr: certification_status
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Failure Count"
      expr: failure_count
    - name: "Mandatory Pass Count"
      expr: mandatory_pass_count
    - name: "Notes"
      expr: notes
    - name: "Platform Submission Reference"
      expr: platform_submission_reference
    - name: "Resubmission Number"
      expr: resubmission_number
    - name: "Test Completed Timestamp"
      expr: test_completed_timestamp
    - name: "Test Execution Date"
      expr: test_execution_date
    - name: "Test Started Timestamp"
      expr: test_started_timestamp
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Waiver Count"
      expr: waiver_count
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Certification Test Run"
      expr: COUNT(DISTINCT certification_test_run_id)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`studio_changelist`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Changelist business metrics"
  source: "`gaming_ecm`.`studio`.`changelist`"
  dimensions:
    - name: "Bug Severity"
      expr: bug_severity
    - name: "Build Number"
      expr: build_number
    - name: "Change Category"
      expr: change_category
    - name: "Change Status"
      expr: change_status
    - name: "Change Type"
      expr: change_type
    - name: "Cicd Pipeline Status"
      expr: cicd_pipeline_status
    - name: "Cl Description"
      expr: cl_description
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Engine Version"
      expr: engine_version
    - name: "File Count"
      expr: file_count
    - name: "Game Area"
      expr: game_area
    - name: "Integration Type"
      expr: integration_type
    - name: "Is Gaas Live Op"
      expr: is_gaas_live_op
    - name: "Is Hotfix"
      expr: is_hotfix
    - name: "Jira Issue Type"
      expr: jira_issue_type
    - name: "Lines Added"
      expr: lines_added
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Changelist"
      expr: COUNT(DISTINCT changelist_id)
    - name: "Total Cl Number"
      expr: SUM(cl_number)
    - name: "Average Cl Number"
      expr: AVG(cl_number)
    - name: "Total Reverts Cl Number"
      expr: SUM(reverts_cl_number)
    - name: "Average Reverts Cl Number"
      expr: AVG(reverts_cl_number)
    - name: "Total Total File Size Bytes"
      expr: SUM(total_file_size_bytes)
    - name: "Average Total File Size Bytes"
      expr: AVG(total_file_size_bytes)
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

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`studio_engine_config`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engine Config business metrics"
  source: "`gaming_ecm`.`studio`.`engine_config`"
  dimensions:
    - name: "Animation System"
      expr: animation_system
    - name: "Api Backend"
      expr: api_backend
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Audio Middleware"
      expr: audio_middleware
    - name: "Build Configuration"
      expr: build_configuration
    - name: "Change Notes"
      expr: change_notes
    - name: "Cicd Pipeline Url"
      expr: cicd_pipeline_url
    - name: "Compression Method"
      expr: compression_method
    - name: "Config Code"
      expr: config_code
    - name: "Config Description"
      expr: config_description
    - name: "Config Name"
      expr: config_name
    - name: "Config Status"
      expr: config_status
    - name: "Config Version"
      expr: config_version
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deprecated Timestamp"
      expr: deprecated_timestamp
    - name: "Draw Call Budget"
      expr: draw_call_budget
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Engine Config"
      expr: COUNT(DISTINCT engine_config_id)
    - name: "Total Perforce Changelist"
      expr: SUM(perforce_changelist)
    - name: "Average Perforce Changelist"
      expr: AVG(perforce_changelist)
    - name: "Total Template Source Reference"
      expr: SUM(template_source_reference)
    - name: "Average Template Source Reference"
      expr: AVG(template_source_reference)
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
    - name: "Cert Approval Date"
      expr: cert_approval_date
    - name: "Cert Submission Date"
      expr: cert_submission_date
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

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`studio_partnership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partnership business metrics"
  source: "`gaming_ecm`.`studio`.`partnership`"
  dimensions:
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Contract Document Url"
      expr: contract_document_url
    - name: "Contract Reference Number"
      expr: contract_reference_number
    - name: "Coppa Applicable"
      expr: coppa_applicable
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Resolution Mechanism"
      expr: dispute_resolution_mechanism
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Esrb Compliance Required"
      expr: esrb_compliance_required
    - name: "Exclusivity Type"
      expr: exclusivity_type
    - name: "Gaas Support Flag"
      expr: gaas_support_flag
    - name: "Gdpr Data Processing Agreement"
      expr: gdpr_data_processing_agreement
    - name: "Governing Law Country"
      expr: governing_law_country
    - name: "Ip Ownership Arrangement"
      expr: ip_ownership_arrangement
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partnership"
      expr: COUNT(DISTINCT partnership_id)
    - name: "Total Advance Recoupable Usd"
      expr: SUM(advance_recoupable_usd)
    - name: "Average Advance Recoupable Usd"
      expr: AVG(advance_recoupable_usd)
    - name: "Total Gaming Revenue Share Pct"
      expr: SUM(gaming_revenue_share_pct)
    - name: "Average Gaming Revenue Share Pct"
      expr: AVG(gaming_revenue_share_pct)
    - name: "Total Partner Revenue Share Pct"
      expr: SUM(partner_revenue_share_pct)
    - name: "Average Partner Revenue Share Pct"
      expr: AVG(partner_revenue_share_pct)
    - name: "Total Total Contract Value Usd"
      expr: SUM(total_contract_value_usd)
    - name: "Average Total Contract Value Usd"
      expr: AVG(total_contract_value_usd)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`studio_project_budget_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project Budget Allocation business metrics"
  source: "`gaming_ecm`.`studio`.`project_budget_allocation`"
  dimensions:
    - name: "Allocation Reference Code"
      expr: allocation_reference_code
    - name: "Allocation Type"
      expr: allocation_type
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Budget Category"
      expr: budget_category
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective Until Date"
      expr: effective_until_date
    - name: "Finance Sign Off Date"
      expr: finance_sign_off_date
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Headcount Funded"
      expr: headcount_funded
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Project Budget Allocation"
      expr: COUNT(DISTINCT project_budget_allocation_id)
    - name: "Total Actual Amount Spent"
      expr: SUM(actual_amount_spent)
    - name: "Average Actual Amount Spent"
      expr: AVG(actual_amount_spent)
    - name: "Total Allocated Amount"
      expr: SUM(allocated_amount)
    - name: "Average Allocated Amount"
      expr: AVG(allocated_amount)
    - name: "Total Budget Consumed Usd"
      expr: SUM(budget_consumed_usd)
    - name: "Average Budget Consumed Usd"
      expr: AVG(budget_consumed_usd)
    - name: "Total Committed Amount"
      expr: SUM(committed_amount)
    - name: "Average Committed Amount"
      expr: AVG(committed_amount)
    - name: "Total Remaining Amount"
      expr: SUM(remaining_amount)
    - name: "Average Remaining Amount"
      expr: AVG(remaining_amount)
    - name: "Total Total Budget Usd"
      expr: SUM(total_budget_usd)
    - name: "Average Total Budget Usd"
      expr: AVG(total_budget_usd)
    - name: "Total Variance Pct"
      expr: SUM(variance_pct)
    - name: "Average Variance Pct"
      expr: AVG(variance_pct)
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

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`studio_resource_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Resource Allocation business metrics"
  source: "`gaming_ecm`.`studio`.`resource_allocation`"
  dimensions:
    - name: "Allocated Role"
      expr: allocated_role
    - name: "Allocation Code"
      expr: allocation_code
    - name: "Allocation Source"
      expr: allocation_source
    - name: "Allocation Status"
      expr: allocation_status
    - name: "Approval Date"
      expr: approval_date
    - name: "Cicd Pipeline Access"
      expr: cicd_pipeline_access
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "End Date"
      expr: end_date
    - name: "Gaas Live Ops Flag"
      expr: gaas_live_ops_flag
    - name: "Is Billable"
      expr: is_billable
    - name: "Is Contractor"
      expr: is_contractor
    - name: "Is Remote"
      expr: is_remote
    - name: "Jira Epic Key"
      expr: jira_epic_key
    - name: "Notes"
      expr: notes
    - name: "Overtime Approved"
      expr: overtime_approved
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Resource Allocation"
      expr: COUNT(DISTINCT resource_allocation_id)
    - name: "Total Allocation Pct"
      expr: SUM(allocation_pct)
    - name: "Average Allocation Pct"
      expr: AVG(allocation_pct)
    - name: "Total Daily Rate Usd"
      expr: SUM(daily_rate_usd)
    - name: "Average Daily Rate Usd"
      expr: AVG(daily_rate_usd)
    - name: "Total Fte Hours Per Day"
      expr: SUM(fte_hours_per_day)
    - name: "Average Fte Hours Per Day"
      expr: AVG(fte_hours_per_day)
    - name: "Total Total Allocated Days"
      expr: SUM(total_allocated_days)
    - name: "Average Total Allocated Days"
      expr: AVG(total_allocated_days)
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

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`studio_vendor_work_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor Work Package business metrics"
  source: "`gaming_ecm`.`studio`.`vendor_work_package`"
  dimensions:
    - name: "Acceptance Criteria"
      expr: acceptance_criteria
    - name: "Actual Delivery Date"
      expr: actual_delivery_date
    - name: "Asset Count"
      expr: asset_count
    - name: "Cost Allocation Reference"
      expr: cost_allocation_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Deliverable Type"
      expr: deliverable_type
    - name: "Delivery Milestone Date"
      expr: delivery_milestone_date
    - name: "Gaas Live Ops Flag"
      expr: gaas_live_ops_flag
    - name: "Game Engine"
      expr: game_engine
    - name: "Ip Ownership Terms"
      expr: ip_ownership_terms
    - name: "Jira Epic Key"
      expr: jira_epic_key
    - name: "Nda Executed"
      expr: nda_executed
    - name: "Notes"
      expr: notes
    - name: "Package Code"
      expr: package_code
    - name: "Package Name"
      expr: package_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vendor Work Package"
      expr: COUNT(DISTINCT vendor_work_package_id)
    - name: "Total Contracted Amount"
      expr: SUM(contracted_amount)
    - name: "Average Contracted Amount"
      expr: AVG(contracted_amount)
$$;