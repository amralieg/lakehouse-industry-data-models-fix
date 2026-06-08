-- Metric views for domain: development | Business: Real Estate | Version: 1 | Generated on: 2026-05-02 04:45:11

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`development_dev_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for real estate development projects — tracks budget performance, schedule adherence, cost efficiency, and pipeline health across the active project portfolio."
  source: "`real_estate_ecm`.`development`.`dev_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current lifecycle status of the development project (e.g., Active, Completed, On Hold) — primary filter for pipeline analysis."
    - name: "current_phase"
      expr: current_phase
      comment: "Current construction or development phase (e.g., Pre-Development, Construction, Closeout) — used to segment projects by stage."
    - name: "property_type_id"
      expr: property_type_id
      comment: "Foreign key to property type reference — enables segmentation by asset class (residential, commercial, mixed-use)."
    - name: "esg_flag"
      expr: esg_flag
      comment: "Boolean indicating whether the project carries ESG designation — supports sustainability portfolio reporting."
    - name: "fund_id"
      expr: fund_id
      comment: "Foreign key to the investment fund sponsoring the project — enables fund-level performance roll-up."
    - name: "legal_entity_id"
      expr: legal_entity_id
      comment: "Foreign key to the legal entity owning the project — supports entity-level financial reporting."
    - name: "estimated_completion_date"
      expr: DATE_TRUNC('month', estimated_completion_date)
      comment: "Estimated completion month — used to bucket project delivery timelines for pipeline forecasting."
    - name: "actual_completion_date"
      expr: DATE_TRUNC('month', actual_completion_date)
      comment: "Actual completion month — used to compare planned vs. actual delivery cadence."
    - name: "closeout_package_complete"
      expr: closeout_package_complete
      comment: "Boolean indicating whether the project closeout package has been submitted — tracks administrative completion."
    - name: "coo_issued_date"
      expr: DATE_TRUNC('month', coo_issued_date)
      comment: "Month the Certificate of Occupancy was issued — key milestone for revenue recognition and asset handover."
  measures:
    - name: "total_project_count"
      expr: COUNT(1)
      comment: "Total number of development projects — baseline portfolio size metric for pipeline and capacity planning."
    - name: "total_budget_usd"
      expr: SUM(CAST(total_budget_usd AS DOUBLE))
      comment: "Sum of total approved budgets across all projects — represents total capital deployed or committed in the development pipeline."
    - name: "total_actual_cost_to_date_usd"
      expr: SUM(CAST(actual_cost_to_date_usd AS DOUBLE))
      comment: "Sum of actual costs incurred to date across all projects — measures capital burn rate against budget."
    - name: "total_hard_cost_budget_usd"
      expr: SUM(CAST(hard_cost_budget_usd AS DOUBLE))
      comment: "Sum of hard cost budgets (construction costs) across all projects — key input for construction cost benchmarking."
    - name: "total_soft_cost_budget_usd"
      expr: SUM(CAST(soft_cost_budget_usd AS DOUBLE))
      comment: "Sum of soft cost budgets (design, legal, permitting) across all projects — tracks non-construction overhead."
    - name: "total_contingency_budget_usd"
      expr: SUM(CAST(contingency_budget_usd AS DOUBLE))
      comment: "Sum of contingency reserves across all projects — indicates risk buffer held in the portfolio."
    - name: "avg_budget_per_project_usd"
      expr: AVG(CAST(total_budget_usd AS DOUBLE))
      comment: "Average total budget per development project — used to benchmark project scale and capital intensity."
    - name: "avg_cost_to_date_per_project_usd"
      expr: AVG(CAST(actual_cost_to_date_usd AS DOUBLE))
      comment: "Average actual cost incurred per project — supports cross-project cost efficiency comparison."
    - name: "total_target_gla_sqft"
      expr: SUM(CAST(target_gla_sqft AS DOUBLE))
      comment: "Total target gross leasable area in square feet across all projects — measures development output and leasable inventory being created."
    - name: "avg_cost_per_sqft_usd"
      expr: SUM(CAST(actual_cost_to_date_usd AS DOUBLE)) / NULLIF(SUM(CAST(target_gla_sqft AS DOUBLE)), 0)
      comment: "Actual cost to date per square foot of target GLA — key construction efficiency and cost benchmarking KPI."
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_cost_to_date_usd AS DOUBLE)) / NULLIF(SUM(CAST(total_budget_usd AS DOUBLE)), 0), 2)
      comment: "Percentage of total budget consumed to date — critical indicator of project spend pace and budget health."
    - name: "contingency_as_pct_of_total_budget"
      expr: ROUND(100.0 * SUM(CAST(contingency_budget_usd AS DOUBLE)) / NULLIF(SUM(CAST(total_budget_usd AS DOUBLE)), 0), 2)
      comment: "Contingency budget as a percentage of total project budget — measures risk provisioning adequacy across the portfolio."
    - name: "hard_cost_as_pct_of_total_budget"
      expr: ROUND(100.0 * SUM(CAST(hard_cost_budget_usd AS DOUBLE)) / NULLIF(SUM(CAST(total_budget_usd AS DOUBLE)), 0), 2)
      comment: "Hard costs as a percentage of total budget — benchmarks construction cost structure across project types."
    - name: "projects_with_coo_issued_count"
      expr: COUNT(CASE WHEN coo_issued_date IS NOT NULL THEN 1 END)
      comment: "Number of projects where a Certificate of Occupancy has been issued — tracks regulatory completion and asset delivery readiness."
    - name: "esg_project_count"
      expr: COUNT(CASE WHEN esg_flag = TRUE THEN 1 END)
      comment: "Number of projects with ESG designation — supports sustainability reporting and ESG portfolio commitments."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`development_construction_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular construction budget performance metrics — tracks variance, forecast accuracy, contingency consumption, and cost category breakdowns at the budget line level."
  source: "`real_estate_ecm`.`development`.`construction_budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget record (e.g., Approved, Draft, Revised) — primary filter for active budget analysis."
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g., Original, Revised, Forecast) — enables tracking of budget evolution over time."
    - name: "cost_category"
      expr: cost_category
      comment: "High-level cost category (e.g., Hard Cost, Soft Cost, Financing) — supports cost structure analysis."
    - name: "cost_code"
      expr: cost_code
      comment: "Detailed cost code for the budget line — enables granular cost tracking and benchmarking."
    - name: "dev_project_id"
      expr: dev_project_id
      comment: "Foreign key to the development project — enables project-level budget roll-up."
    - name: "budget_version"
      expr: budget_version
      comment: "Version identifier for the budget — supports budget revision history and trend analysis."
    - name: "is_contingency_drawn"
      expr: is_contingency_drawn
      comment: "Boolean indicating whether contingency has been drawn on this budget line — flags risk events."
    - name: "reporting_period_date"
      expr: DATE_TRUNC('month', reporting_period_date)
      comment: "Reporting period month — enables period-over-period budget performance trending."
    - name: "approval_date"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month the budget was approved — used to track approval cycle times and budget vintage."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Foreign key to cost center — enables cost center-level budget accountability reporting."
  measures:
    - name: "total_original_budget_amount"
      expr: SUM(CAST(original_budget_amount AS DOUBLE))
      comment: "Sum of original approved budget amounts — baseline for measuring budget growth and change order impact."
    - name: "total_current_budget_amount"
      expr: SUM(CAST(current_budget_amount AS DOUBLE))
      comment: "Sum of current (revised) budget amounts including approved change orders — reflects latest authorized spend."
    - name: "total_actual_cost_to_date"
      expr: SUM(CAST(actual_cost_to_date AS DOUBLE))
      comment: "Sum of actual costs incurred to date — measures capital burn against budget."
    - name: "total_committed_cost_amount"
      expr: SUM(CAST(committed_cost_amount AS DOUBLE))
      comment: "Sum of committed costs (contracted but not yet invoiced) — critical for cash flow and exposure forecasting."
    - name: "total_forecast_at_completion"
      expr: SUM(CAST(forecast_at_completion AS DOUBLE))
      comment: "Sum of forecast-at-completion amounts — the most important forward-looking cost estimate for project financial control."
    - name: "total_cost_variance_amount"
      expr: SUM(CAST(cost_variance_amount AS DOUBLE))
      comment: "Sum of cost variances (budget vs. actual/forecast) — negative values signal budget overruns requiring executive attention."
    - name: "total_approved_change_order_amount"
      expr: SUM(CAST(approved_change_order_amount AS DOUBLE))
      comment: "Sum of approved change order amounts added to budget — measures scope growth and its financial impact."
    - name: "total_pending_change_order_amount"
      expr: SUM(CAST(pending_change_order_amount AS DOUBLE))
      comment: "Sum of pending (unapproved) change order amounts — represents contingent cost exposure not yet in the budget."
    - name: "total_contingency_budget"
      expr: SUM(CAST(contingency_budget AS DOUBLE))
      comment: "Sum of contingency budget allocated — measures total risk reserve provisioned."
    - name: "total_contingency_remaining"
      expr: SUM(CAST(contingency_remaining AS DOUBLE))
      comment: "Sum of remaining contingency — a declining balance signals increasing project risk and potential overrun."
    - name: "budget_variance_pct"
      expr: ROUND(100.0 * SUM(CAST(cost_variance_amount AS DOUBLE)) / NULLIF(SUM(CAST(current_budget_amount AS DOUBLE)), 0), 2)
      comment: "Cost variance as a percentage of current budget — key executive KPI for budget health; negative values indicate overrun."
    - name: "forecast_vs_budget_variance_pct"
      expr: ROUND(100.0 * (SUM(CAST(forecast_at_completion AS DOUBLE)) - SUM(CAST(current_budget_amount AS DOUBLE))) / NULLIF(SUM(CAST(current_budget_amount AS DOUBLE)), 0), 2)
      comment: "Forecast-at-completion vs. current budget as a percentage — forward-looking overrun indicator for project financial control."
    - name: "contingency_consumption_rate"
      expr: ROUND(100.0 * (SUM(CAST(contingency_budget AS DOUBLE)) - SUM(CAST(contingency_remaining AS DOUBLE))) / NULLIF(SUM(CAST(contingency_budget AS DOUBLE)), 0), 2)
      comment: "Percentage of contingency budget consumed — high rates signal elevated project risk and potential need for budget reauthorization."
    - name: "change_order_growth_pct"
      expr: ROUND(100.0 * SUM(CAST(approved_change_order_amount AS DOUBLE)) / NULLIF(SUM(CAST(original_budget_amount AS DOUBLE)), 0), 2)
      comment: "Approved change orders as a percentage of original budget — measures scope creep and contract management effectiveness."
    - name: "cost_commitment_ratio"
      expr: ROUND(100.0 * (SUM(CAST(actual_cost_to_date AS DOUBLE)) + SUM(CAST(committed_cost_amount AS DOUBLE))) / NULLIF(SUM(CAST(current_budget_amount AS DOUBLE)), 0), 2)
      comment: "Actual plus committed costs as a percentage of current budget — measures total financial exposure relative to authorized budget."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`development_change_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Change order management KPIs — tracks cost impact, approval velocity, dispute rates, and scope growth across construction contracts."
  source: "`real_estate_ecm`.`development`.`change_order`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the change order (e.g., Approved, Pending, Rejected) — primary filter for change order pipeline analysis."
    - name: "change_type"
      expr: change_type
      comment: "Type of change order (e.g., Scope Addition, Design Change, Unforeseen Condition) — enables root cause analysis of cost growth."
    - name: "capex_category"
      expr: capex_category
      comment: "Capital expenditure category for the change order — supports CAPEX classification and reporting."
    - name: "is_disputed"
      expr: is_disputed
      comment: "Boolean indicating whether the change order is under dispute — flags legal and financial risk items."
    - name: "is_time_and_material"
      expr: is_time_and_material
      comment: "Boolean indicating time-and-material billing vs. lump sum — affects cost predictability and risk profile."
    - name: "dev_project_id"
      expr: dev_project_id
      comment: "Foreign key to the development project — enables project-level change order roll-up."
    - name: "contractor_id"
      expr: contractor_id
      comment: "Foreign key to the contractor — enables contractor-level change order performance benchmarking."
    - name: "cost_code"
      expr: cost_code
      comment: "Cost code associated with the change order — enables trade-level cost impact analysis."
    - name: "approved_date"
      expr: DATE_TRUNC('month', approved_date)
      comment: "Month the change order was approved — used for approval velocity trending and cash flow timing."
    - name: "submitted_date"
      expr: DATE_TRUNC('month', submitted_date)
      comment: "Month the change order was submitted — used to measure approval cycle time."
  measures:
    - name: "total_change_order_count"
      expr: COUNT(1)
      comment: "Total number of change orders — baseline volume metric for change order management oversight."
    - name: "total_cost_impact_amount"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total cost impact of all change orders — measures aggregate financial exposure from scope changes."
    - name: "total_approved_cost_impact"
      expr: SUM(CASE WHEN approval_status = 'Approved' THEN CAST(cost_impact_amount AS DOUBLE) ELSE 0 END)
      comment: "Total cost impact of approved change orders only — represents confirmed budget additions from scope changes."
    - name: "total_pending_cost_impact"
      expr: SUM(CASE WHEN approval_status = 'Pending' THEN CAST(cost_impact_amount AS DOUBLE) ELSE 0 END)
      comment: "Total cost impact of pending change orders — represents contingent financial exposure awaiting approval decisions."
    - name: "total_lump_sum_amount"
      expr: SUM(CAST(lump_sum_amount AS DOUBLE))
      comment: "Total lump sum value of change orders — measures fixed-price change order volume."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on change orders — supports tax liability tracking and reporting."
    - name: "disputed_change_order_count"
      expr: COUNT(CASE WHEN is_disputed = TRUE THEN 1 END)
      comment: "Number of disputed change orders — high counts signal contractor relationship issues and legal risk."
    - name: "disputed_cost_impact_amount"
      expr: SUM(CASE WHEN is_disputed = TRUE THEN CAST(cost_impact_amount AS DOUBLE) ELSE 0 END)
      comment: "Total cost impact of disputed change orders — measures financial exposure under active dispute."
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_disputed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of change orders that are disputed — key contractor performance and contract management KPI."
    - name: "avg_cost_impact_per_change_order"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per change order — benchmarks change order magnitude and helps identify outliers."
    - name: "avg_markup_percentage"
      expr: AVG(CAST(markup_percentage AS DOUBLE))
      comment: "Average markup percentage applied to change orders — monitors contractor margin practices and contract compliance."
    - name: "time_and_material_count"
      expr: COUNT(CASE WHEN is_time_and_material = TRUE THEN 1 END)
      comment: "Number of time-and-material change orders — high counts indicate cost unpredictability and scope definition issues."
    - name: "time_and_material_cost_impact"
      expr: SUM(CASE WHEN is_time_and_material = TRUE THEN CAST(cost_impact_amount AS DOUBLE) ELSE 0 END)
      comment: "Total cost impact of time-and-material change orders — measures open-ended cost exposure from T&M billing."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`development_draw_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Construction loan draw request KPIs — tracks disbursement velocity, retainage management, lender approval rates, and payment completion across the draw cycle."
  source: "`real_estate_ecm`.`development`.`draw_request`"
  dimensions:
    - name: "draw_status"
      expr: draw_status
      comment: "Current status of the draw request (e.g., Submitted, Approved, Disbursed) — primary filter for draw pipeline management."
    - name: "lender_approval_status"
      expr: lender_approval_status
      comment: "Lender's approval decision on the draw request — tracks lender responsiveness and approval rates."
    - name: "owner_approval_status"
      expr: owner_approval_status
      comment: "Owner's approval decision on the draw request — tracks owner-side approval velocity."
    - name: "lien_waiver_status"
      expr: lien_waiver_status
      comment: "Status of lien waiver documentation — critical for title protection and draw disbursement eligibility."
    - name: "title_review_status"
      expr: title_review_status
      comment: "Status of title review for the draw — tracks title risk clearance in the draw process."
    - name: "dev_project_id"
      expr: dev_project_id
      comment: "Foreign key to the development project — enables project-level draw activity roll-up."
    - name: "contractor_id"
      expr: contractor_id
      comment: "Foreign key to the contractor — enables contractor-level payment tracking."
    - name: "is_notarized"
      expr: is_notarized
      comment: "Boolean indicating whether the draw package is notarized — compliance check for draw eligibility."
    - name: "billing_period_end"
      expr: DATE_TRUNC('month', billing_period_end)
      comment: "Billing period end month — enables period-over-period draw activity analysis."
    - name: "disbursement_date"
      expr: DATE_TRUNC('month', disbursement_date)
      comment: "Month funds were disbursed — used to track cash outflow timing and construction loan utilization."
  measures:
    - name: "total_draw_request_count"
      expr: COUNT(1)
      comment: "Total number of draw requests submitted — baseline volume metric for construction loan activity."
    - name: "total_disbursed_amount"
      expr: SUM(CAST(disbursed_amount AS DOUBLE))
      comment: "Total amount disbursed to contractors — measures actual capital deployed from the construction loan."
    - name: "total_net_payment_due"
      expr: SUM(CAST(net_payment_due AS DOUBLE))
      comment: "Total net payment due across all draw requests — represents outstanding payment obligations to contractors."
    - name: "total_work_completed_current"
      expr: SUM(CAST(work_completed_current AS DOUBLE))
      comment: "Total value of work completed in the current billing period — measures construction progress velocity."
    - name: "total_work_completed_to_date"
      expr: SUM(CAST(total_earned_to_date AS DOUBLE))
      comment: "Total earned value to date across all draw requests — measures cumulative construction progress."
    - name: "total_retainage_withheld"
      expr: SUM(CAST(total_retainage_withheld AS DOUBLE))
      comment: "Total retainage withheld from contractors — measures the retainage liability owed upon project completion."
    - name: "total_materials_stored"
      expr: SUM(CAST(materials_stored AS DOUBLE))
      comment: "Total value of materials stored on-site — tracks inventory risk and draw eligibility for stored materials."
    - name: "total_balance_to_finish"
      expr: SUM(CAST(balance_to_finish AS DOUBLE))
      comment: "Total remaining contract value to be earned — measures remaining construction loan exposure."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average construction completion percentage across draw requests — tracks overall portfolio construction progress."
    - name: "avg_retainage_rate"
      expr: AVG(CAST(retainage_rate AS DOUBLE))
      comment: "Average retainage rate applied across draw requests — monitors retainage policy consistency."
    - name: "disbursement_to_earned_ratio"
      expr: ROUND(100.0 * SUM(CAST(disbursed_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_earned_to_date AS DOUBLE)), 0), 2)
      comment: "Disbursed amount as a percentage of total earned value — measures payment efficiency and identifies underpayment or overpayment risk."
    - name: "retainage_as_pct_of_earned"
      expr: ROUND(100.0 * SUM(CAST(total_retainage_withheld AS DOUBLE)) / NULLIF(SUM(CAST(total_earned_to_date AS DOUBLE)), 0), 2)
      comment: "Total retainage withheld as a percentage of total earned value — monitors retainage accumulation and future liability."
    - name: "lender_approved_draw_count"
      expr: COUNT(CASE WHEN lender_approval_status = 'Approved' THEN 1 END)
      comment: "Number of draw requests approved by the lender — tracks lender approval throughput and construction loan utilization pace."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`development_construction_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Construction contract portfolio KPIs — tracks contract value, retainage exposure, insurance compliance, bonding coverage, and contractor diversity across the active contract base."
  source: "`real_estate_ecm`.`development`.`construction_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the construction contract (e.g., Executed, Active, Closed) — primary filter for active contract analysis."
    - name: "contract_category"
      expr: contract_category
      comment: "Category of the contract (e.g., General Contractor, Subcontractor, Design-Build) — enables contract type segmentation."
    - name: "trade_division"
      expr: trade_division
      comment: "Construction trade division (e.g., Electrical, Mechanical, Structural) — enables trade-level cost and performance analysis."
    - name: "dev_project_id"
      expr: dev_project_id
      comment: "Foreign key to the development project — enables project-level contract roll-up."
    - name: "contractor_id"
      expr: contractor_id
      comment: "Foreign key to the contractor — enables contractor-level contract portfolio analysis."
    - name: "bonding_required"
      expr: bonding_required
      comment: "Boolean indicating whether a performance/payment bond is required — tracks bonding compliance across the contract portfolio."
    - name: "prevailing_wage_required"
      expr: prevailing_wage_required
      comment: "Boolean indicating prevailing wage requirements — supports labor compliance monitoring."
    - name: "minority_business_required"
      expr: minority_business_required
      comment: "Boolean indicating minority business enterprise requirements — supports diversity and inclusion compliance tracking."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms specified in the contract — enables cash flow planning and payment cycle analysis."
    - name: "commencement_date"
      expr: DATE_TRUNC('month', commencement_date)
      comment: "Month the contract commenced — used to track contract start cadence and construction mobilization timing."
    - name: "substantial_completion_date"
      expr: DATE_TRUNC('month', substantial_completion_date)
      comment: "Planned substantial completion month — used for schedule adherence and milestone tracking."
  measures:
    - name: "total_contract_count"
      expr: COUNT(1)
      comment: "Total number of construction contracts — baseline portfolio size metric for contract management oversight."
    - name: "total_original_contract_value"
      expr: SUM(CAST(original_contract_value AS DOUBLE))
      comment: "Sum of original contract values — measures total contracted construction spend at award."
    - name: "total_revised_contract_value"
      expr: SUM(CAST(revised_contract_value AS DOUBLE))
      comment: "Sum of revised contract values including change orders — measures current total contracted exposure."
    - name: "total_change_order_allowance"
      expr: SUM(CAST(change_order_allowance AS DOUBLE))
      comment: "Sum of change order allowances built into contracts — measures pre-authorized contingency in the contract base."
    - name: "total_performance_bond_amount"
      expr: SUM(CAST(performance_bond_amount AS DOUBLE))
      comment: "Sum of performance bond amounts — measures total surety coverage protecting against contractor default."
    - name: "total_payment_bond_amount"
      expr: SUM(CAST(payment_bond_amount AS DOUBLE))
      comment: "Sum of payment bond amounts — measures total surety coverage protecting subcontractor and supplier payments."
    - name: "total_liquidated_damages_exposure"
      expr: SUM(CAST(liquidated_damages_per_day AS DOUBLE))
      comment: "Sum of daily liquidated damages rates across contracts — measures total daily financial exposure from schedule delays."
    - name: "avg_retainage_percentage"
      expr: AVG(CAST(retainage_percentage AS DOUBLE))
      comment: "Average retainage percentage across contracts — monitors retainage policy consistency and contractor cash flow impact."
    - name: "contract_value_growth_pct"
      expr: ROUND(100.0 * (SUM(CAST(revised_contract_value AS DOUBLE)) - SUM(CAST(original_contract_value AS DOUBLE))) / NULLIF(SUM(CAST(original_contract_value AS DOUBLE)), 0), 2)
      comment: "Percentage growth from original to revised contract value — measures aggregate scope creep and change order impact across the contract portfolio."
    - name: "bonded_contract_count"
      expr: COUNT(CASE WHEN bonding_required = TRUE THEN 1 END)
      comment: "Number of contracts requiring bonding — tracks surety coverage requirements across the portfolio."
    - name: "minority_business_contract_count"
      expr: COUNT(CASE WHEN minority_business_required = TRUE THEN 1 END)
      comment: "Number of contracts with minority business enterprise requirements — supports diversity compliance reporting."
    - name: "avg_original_contract_value"
      expr: AVG(CAST(original_contract_value AS DOUBLE))
      comment: "Average original contract value — benchmarks contract size and helps identify outlier contracts."
    - name: "schedule_overrun_contract_count"
      expr: COUNT(CASE WHEN actual_substantial_completion_date > substantial_completion_date AND actual_substantial_completion_date IS NOT NULL AND substantial_completion_date IS NOT NULL THEN 1 END)
      comment: "Number of contracts where actual substantial completion exceeded the planned date — measures schedule performance across the contractor base."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`development_inspection_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Construction inspection quality and compliance KPIs — tracks pass/fail rates, deficiency severity, reinspection rates, OSHA compliance, and corrective action velocity."
  source: "`real_estate_ecm`.`development`.`inspection_event`"
  dimensions:
    - name: "inspection_result"
      expr: inspection_result
      comment: "Outcome of the inspection (e.g., Pass, Fail, Conditional Pass) — primary dimension for quality performance analysis."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (e.g., Structural, MEP, Fire Safety, Final) — enables trade and phase-specific quality analysis."
    - name: "inspection_category"
      expr: inspection_category
      comment: "Category of inspection (e.g., Municipal, Lender, Owner) — distinguishes regulatory from contractual inspections."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection record (e.g., Scheduled, Completed, Pending Reinspection) — tracks inspection workflow."
    - name: "deficiency_severity"
      expr: deficiency_severity
      comment: "Severity level of identified deficiencies (e.g., Critical, Major, Minor) — enables risk-weighted quality reporting."
    - name: "dev_project_id"
      expr: dev_project_id
      comment: "Foreign key to the development project — enables project-level inspection quality roll-up."
    - name: "contractor_id"
      expr: contractor_id
      comment: "Foreign key to the contractor — enables contractor-level quality performance benchmarking."
    - name: "osha_compliance_flag"
      expr: osha_compliance_flag
      comment: "Boolean indicating OSHA compliance status at time of inspection — tracks safety regulatory compliance."
    - name: "coo_related"
      expr: coo_related
      comment: "Boolean indicating whether the inspection is related to Certificate of Occupancy — tracks COO milestone progress."
    - name: "inspection_date"
      expr: DATE_TRUNC('month', inspection_date)
      comment: "Month of the inspection — enables period-over-period quality trend analysis."
  measures:
    - name: "total_inspection_count"
      expr: COUNT(1)
      comment: "Total number of inspection events — baseline volume metric for construction quality oversight activity."
    - name: "passed_inspection_count"
      expr: COUNT(CASE WHEN inspection_result = 'Pass' THEN 1 END)
      comment: "Number of inspections that passed — measures quality throughput and first-pass success."
    - name: "failed_inspection_count"
      expr: COUNT(CASE WHEN inspection_result = 'Fail' THEN 1 END)
      comment: "Number of inspections that failed — high counts signal quality control issues requiring contractor intervention."
    - name: "first_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_result = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections passing on first attempt — key construction quality KPI; low rates indicate rework risk and schedule impact."
    - name: "reinspection_required_count"
      expr: COUNT(CASE WHEN reinspection_required = TRUE THEN 1 END)
      comment: "Number of inspections requiring reinspection — measures rework volume and its impact on schedule and cost."
    - name: "reinspection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reinspection_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring reinspection — elevated rates signal systemic quality issues with contractors or trades."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of inspections triggering corrective action — measures deficiency volume requiring remediation."
    - name: "osha_violation_count"
      expr: COUNT(CASE WHEN osha_violation_noted = TRUE THEN 1 END)
      comment: "Number of inspections where OSHA violations were noted — critical safety compliance KPI with direct regulatory and liability implications."
    - name: "osha_violation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN osha_violation_noted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections with OSHA violations — key safety performance indicator for contractor prequalification and risk management."
    - name: "coo_related_inspection_count"
      expr: COUNT(CASE WHEN coo_related = TRUE THEN 1 END)
      comment: "Number of COO-related inspections — tracks progress toward Certificate of Occupancy milestone."
    - name: "lender_draw_related_inspection_count"
      expr: COUNT(CASE WHEN lender_draw_related = TRUE THEN 1 END)
      comment: "Number of inspections tied to lender draw requests — tracks inspection activity supporting construction loan disbursements."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`development_project_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project schedule performance KPIs — tracks milestone adherence, schedule variance, SPI, critical path health, and completion forecasting across the development portfolio."
  source: "`real_estate_ecm`.`development`.`project_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the schedule record (e.g., Active, Baseline, Superseded) — primary filter for current schedule analysis."
    - name: "milestone_status"
      expr: milestone_status
      comment: "Status of the specific milestone (e.g., Complete, In Progress, At Risk, Delayed) — enables milestone-level performance tracking."
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (e.g., Design Complete, Permit Issued, Substantial Completion) — enables phase-specific schedule analysis."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of schedule (e.g., Master, Look-Ahead, Recovery) — distinguishes baseline from recovery schedules."
    - name: "dev_project_id"
      expr: dev_project_id
      comment: "Foreign key to the development project — enables project-level schedule performance roll-up."
    - name: "milestone_responsible_party"
      expr: milestone_responsible_party
      comment: "Party responsible for the milestone — enables accountability-based schedule performance reporting."
    - name: "data_date"
      expr: DATE_TRUNC('month', data_date)
      comment: "Month of the schedule data date — enables period-over-period schedule performance trending."
    - name: "baseline_finish_date"
      expr: DATE_TRUNC('month', baseline_finish_date)
      comment: "Baseline finish month — used to compare planned vs. current schedule finish dates."
    - name: "current_finish_date"
      expr: DATE_TRUNC('month', current_finish_date)
      comment: "Current forecast finish month — tracks schedule slippage over time."
  measures:
    - name: "total_schedule_record_count"
      expr: COUNT(1)
      comment: "Total number of schedule records — baseline count for schedule management activity."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average schedule percent complete across all active schedule records — measures overall portfolio construction progress."
    - name: "avg_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index (SPI) across projects — SPI < 1.0 indicates schedule slippage; key executive KPI for portfolio delivery health."
    - name: "min_spi"
      expr: MIN(CAST(spi AS DOUBLE))
      comment: "Minimum SPI across all schedule records — identifies the most severely delayed project in the portfolio for escalation."
    - name: "at_risk_milestone_count"
      expr: COUNT(CASE WHEN milestone_status = 'At Risk' THEN 1 END)
      comment: "Number of milestones flagged as at risk — early warning indicator for schedule interventions before delays materialize."
    - name: "delayed_milestone_count"
      expr: COUNT(CASE WHEN milestone_status = 'Delayed' THEN 1 END)
      comment: "Number of milestones confirmed as delayed — measures active schedule slippage requiring management action."
    - name: "on_schedule_milestone_count"
      expr: COUNT(CASE WHEN milestone_status = 'Complete' OR milestone_status = 'On Track' THEN 1 END)
      comment: "Number of milestones on schedule or completed — measures schedule adherence across the portfolio."
    - name: "milestone_on_time_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN milestone_actual_date <= milestone_planned_date AND milestone_actual_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN milestone_actual_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of completed milestones delivered on or before planned date — key schedule delivery performance KPI for executive reporting."
    - name: "avg_far_approved"
      expr: AVG(CAST(far_approved AS DOUBLE))
      comment: "Average approved Floor Area Ratio across schedule records — tracks entitlement utilization relative to schedule milestones."
    - name: "below_spi_threshold_count"
      expr: COUNT(CASE WHEN CAST(spi AS DOUBLE) < 0.9 THEN 1 END)
      comment: "Number of schedule records with SPI below 0.9 — identifies projects with significant schedule underperformance requiring executive intervention."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`development_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Entitlement pipeline KPIs — tracks approval rates, FAR utilization, environmental review status, and entitlement cycle times across the development land use approval process."
  source: "`real_estate_ecm`.`development`.`entitlement`"
  dimensions:
    - name: "entitlement_status"
      expr: entitlement_status
      comment: "Current status of the entitlement (e.g., Pending, Approved, Denied, Appealed) — primary filter for entitlement pipeline analysis."
    - name: "entitlement_type"
      expr: entitlement_type
      comment: "Type of entitlement (e.g., Rezoning, Variance, Conditional Use Permit) — enables entitlement category analysis."
    - name: "environmental_review_status"
      expr: environmental_review_status
      comment: "Status of environmental review (e.g., Complete, In Progress, Not Required) — tracks regulatory compliance in the entitlement process."
    - name: "environmental_review_type"
      expr: environmental_review_type
      comment: "Type of environmental review required (e.g., EIR, CEQA, NEPA) — enables regulatory complexity segmentation."
    - name: "far_compliance_status"
      expr: far_compliance_status
      comment: "FAR compliance status — tracks whether proposed development is within allowable density limits."
    - name: "appeal_filed"
      expr: appeal_filed
      comment: "Boolean indicating whether an appeal has been filed — flags entitlements with legal challenges affecting project timelines."
    - name: "dev_project_id"
      expr: dev_project_id
      comment: "Foreign key to the development project — enables project-level entitlement status roll-up."
    - name: "jurisdiction_id"
      expr: jurisdiction_id
      comment: "Foreign key to the jurisdiction — enables jurisdiction-level entitlement approval rate benchmarking."
    - name: "application_date"
      expr: DATE_TRUNC('month', application_date)
      comment: "Month the entitlement application was filed — used to track application volume and approval cycle time."
    - name: "approval_date"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month the entitlement was approved — used to measure approval velocity and pipeline conversion."
  measures:
    - name: "total_entitlement_count"
      expr: COUNT(1)
      comment: "Total number of entitlements in the pipeline — baseline metric for land use approval activity."
    - name: "approved_entitlement_count"
      expr: COUNT(CASE WHEN entitlement_status = 'Approved' THEN 1 END)
      comment: "Number of approved entitlements — measures successful land use approvals enabling development to proceed."
    - name: "denied_entitlement_count"
      expr: COUNT(CASE WHEN entitlement_status = 'Denied' THEN 1 END)
      comment: "Number of denied entitlements — measures regulatory rejection rate and associated stranded pre-development costs."
    - name: "entitlement_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN entitlement_status = 'Approved' THEN 1 END) / NULLIF(COUNT(CASE WHEN entitlement_status IN ('Approved', 'Denied') THEN 1 END), 0), 2)
      comment: "Percentage of decided entitlements that were approved — key pipeline conversion KPI for development strategy and jurisdiction selection."
    - name: "appealed_entitlement_count"
      expr: COUNT(CASE WHEN appeal_filed = TRUE THEN 1 END)
      comment: "Number of entitlements with appeals filed — measures legal challenge exposure and associated timeline risk."
    - name: "total_proposed_gross_floor_area_sqft"
      expr: SUM(CAST(proposed_gross_floor_area_sqf AS DOUBLE))
      comment: "Total proposed gross floor area across all entitlements — measures development density being pursued in the pipeline."
    - name: "total_site_area_sqft"
      expr: SUM(CAST(site_area_sqf AS DOUBLE))
      comment: "Total site area across all entitlements — measures land area under entitlement review."
    - name: "avg_proposed_far"
      expr: AVG(CAST(proposed_far AS DOUBLE))
      comment: "Average proposed Floor Area Ratio — benchmarks development density strategy across the entitlement portfolio."
    - name: "avg_total_allowable_far"
      expr: AVG(CAST(total_allowable_far AS DOUBLE))
      comment: "Average total allowable FAR — measures regulatory density capacity available across entitlement sites."
    - name: "far_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(proposed_far AS DOUBLE)) / NULLIF(SUM(CAST(total_allowable_far AS DOUBLE)), 0), 2)
      comment: "Proposed FAR as a percentage of total allowable FAR — measures how aggressively the development program utilizes available density entitlements."
    - name: "avg_max_building_height_ft"
      expr: AVG(CAST(max_building_height_ft AS DOUBLE))
      comment: "Average maximum allowable building height across entitlements — tracks height envelope available for development."
    - name: "environmental_review_pending_count"
      expr: COUNT(CASE WHEN environmental_review_status = 'In Progress' THEN 1 END)
      comment: "Number of entitlements with environmental review in progress — measures regulatory bottleneck in the entitlement pipeline."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`development_contractor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contractor prequalification and performance KPIs — tracks safety ratings, financial capacity, diversity certifications, insurance compliance, and vendor quality across the approved contractor base."
  source: "`real_estate_ecm`.`development`.`contractor`"
  dimensions:
    - name: "contractor_type"
      expr: contractor_type
      comment: "Type of contractor (e.g., General Contractor, Subcontractor, Specialty Trade) — primary segmentation for contractor portfolio analysis."
    - name: "prequalification_status"
      expr: prequalification_status
      comment: "Current prequalification status (e.g., Approved, Expired, Pending) — tracks contractor eligibility for project award."
    - name: "license_state"
      expr: license_state
      comment: "State of contractor licensure — enables geographic coverage and compliance analysis."
    - name: "license_type"
      expr: license_type
      comment: "Type of contractor license — supports trade-specific compliance tracking."
    - name: "preferred_vendor"
      expr: preferred_vendor
      comment: "Boolean indicating preferred vendor status — enables preferred vs. non-preferred contractor performance comparison."
    - name: "mbe_certified"
      expr: mbe_certified
      comment: "Boolean indicating Minority Business Enterprise certification — supports diversity spend tracking and compliance reporting."
    - name: "wbe_certified"
      expr: wbe_certified
      comment: "Boolean indicating Women Business Enterprise certification — supports diversity spend tracking and compliance reporting."
    - name: "dbe_certified"
      expr: dbe_certified
      comment: "Boolean indicating Disadvantaged Business Enterprise certification — supports federal and state diversity compliance reporting."
    - name: "leed_capable"
      expr: leed_capable
      comment: "Boolean indicating LEED-capable contractor — supports ESG and green building project contractor selection."
    - name: "bim_capable"
      expr: bim_capable
      comment: "Boolean indicating BIM capability — tracks digital construction readiness across the contractor base."
  measures:
    - name: "total_contractor_count"
      expr: COUNT(1)
      comment: "Total number of contractors in the approved vendor base — measures supply chain depth and competitive bidding capacity."
    - name: "avg_performance_rating"
      expr: AVG(CAST(performance_rating AS DOUBLE))
      comment: "Average contractor performance rating — key quality KPI for contractor selection, renewal, and prequalification decisions."
    - name: "avg_osha_recordable_rate"
      expr: AVG(CAST(osha_recordable_rate AS DOUBLE))
      comment: "Average OSHA recordable incident rate across contractors — critical safety KPI; high rates trigger contractor disqualification and liability exposure."
    - name: "avg_safety_emod_rate"
      expr: AVG(CAST(safety_emod_rate AS DOUBLE))
      comment: "Average Experience Modification Rate (EMod) across contractors — measures workers compensation risk; EMod > 1.0 indicates above-average safety risk."
    - name: "total_bonding_capacity"
      expr: SUM(CAST(bonding_capacity AS DOUBLE))
      comment: "Total bonding capacity across all contractors — measures aggregate surety capacity available for project award."
    - name: "avg_bonding_capacity"
      expr: AVG(CAST(bonding_capacity AS DOUBLE))
      comment: "Average bonding capacity per contractor — benchmarks financial capacity for project size eligibility."
    - name: "total_annual_revenue_usd"
      expr: SUM(CAST(annual_revenue_usd AS DOUBLE))
      comment: "Total annual revenue across all contractors — measures aggregate financial scale of the contractor base."
    - name: "diversity_certified_contractor_count"
      expr: COUNT(CASE WHEN mbe_certified = TRUE OR wbe_certified = TRUE OR dbe_certified = TRUE THEN 1 END)
      comment: "Number of contractors with at least one diversity certification (MBE, WBE, or DBE) — tracks diversity vendor base depth for compliance and ESG reporting."
    - name: "diversity_certification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mbe_certified = TRUE OR wbe_certified = TRUE OR dbe_certified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contractors with diversity certifications — measures diversity supply chain penetration for ESG and regulatory compliance."
    - name: "preferred_vendor_count"
      expr: COUNT(CASE WHEN preferred_vendor = TRUE THEN 1 END)
      comment: "Number of preferred vendors — measures the depth of the pre-vetted, high-performance contractor pool available for project award."
    - name: "leed_capable_contractor_count"
      expr: COUNT(CASE WHEN leed_capable = TRUE THEN 1 END)
      comment: "Number of LEED-capable contractors — measures green building execution capacity in the contractor base for ESG-designated projects."
    - name: "high_safety_risk_contractor_count"
      expr: COUNT(CASE WHEN CAST(safety_emod_rate AS DOUBLE) > 1.0 THEN 1 END)
      comment: "Number of contractors with EMod rate above 1.0 — identifies above-average safety risk contractors for prequalification review and risk mitigation."
$$;