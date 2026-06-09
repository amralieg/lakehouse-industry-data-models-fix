-- Metric views for domain: realestate | Business: Restaurants | Version: 1 | Generated on: 2026-05-06 03:57:03

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`realestate_rent_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks rent payment performance, occupancy cost composition, and payment compliance across all leased locations. Enables treasury, real-estate finance, and operations teams to monitor cash outflows, late-payment risk, and variance against scheduled obligations."
  source: "`restaurants_ecm`.`realestate`.`rent_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the rent payment (e.g., Paid, Pending, Late, Disputed) — primary filter for compliance analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used to remit payment (e.g., ACH, Wire, Check) — used to assess payment channel efficiency."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period label associated with the payment — enables period-over-period trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code of the payment — required for multi-currency portfolio analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation state of the payment (e.g., Reconciled, Unreconciled) — flags outstanding items for accounting close."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Boolean indicating whether the payment is under dispute — isolates contested payments for legal/finance review."
    - name: "late_fee_applied_flag"
      expr: late_fee_applied_flag
      comment: "Boolean indicating whether a late fee was assessed — used to track penalty exposure."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Calendar month of payment date — supports monthly cash-flow trending."
    - name: "payment_due_month"
      expr: DATE_TRUNC('MONTH', payment_due_date)
      comment: "Calendar month the payment was due — used to align actuals against scheduled obligations."
  measures:
    - name: "total_rent_paid"
      expr: SUM(CAST(total_payment_amount AS DOUBLE))
      comment: "Total cash outflow for all rent payments in the period — primary occupancy cost KPI for real-estate finance."
    - name: "total_base_rent_paid"
      expr: SUM(CAST(base_rent_amount AS DOUBLE))
      comment: "Sum of base rent components across all payments — isolates fixed rent obligation from variable charges."
    - name: "total_cam_paid"
      expr: SUM(CAST(cam_amount AS DOUBLE))
      comment: "Total common-area maintenance charges paid — tracks variable occupancy cost exposure."
    - name: "total_property_tax_paid"
      expr: SUM(CAST(property_tax_amount AS DOUBLE))
      comment: "Total property tax pass-through paid to landlords — informs tax cost allocation and budgeting."
    - name: "total_late_fees_incurred"
      expr: SUM(CAST(late_fee_amount AS DOUBLE))
      comment: "Total late fees assessed across all payments — a direct measure of payment-process inefficiency and penalty exposure."
    - name: "total_payment_variance"
      expr: SUM(CAST(payment_variance_amount AS DOUBLE))
      comment: "Aggregate variance between scheduled and actual payment amounts — highlights systematic over- or under-payment patterns."
    - name: "total_scheduled_payment"
      expr: SUM(CAST(scheduled_payment_amount AS DOUBLE))
      comment: "Sum of all scheduled payment obligations — baseline denominator for variance and compliance rate calculations."
    - name: "disputed_payment_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN rent_payment_id END)
      comment: "Number of payments currently under dispute — a risk indicator for landlord relationship health and cash-flow certainty."
    - name: "late_payment_count"
      expr: COUNT(CASE WHEN late_fee_applied_flag = TRUE THEN rent_payment_id END)
      comment: "Number of payments on which a late fee was applied — measures payment-process compliance and operational discipline."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of rent payment records — baseline volume metric for rate and ratio calculations."
    - name: "avg_payment_variance"
      expr: AVG(CAST(payment_variance_amount AS DOUBLE))
      comment: "Average variance per payment between scheduled and actual amounts — identifies systemic billing discrepancies."
    - name: "total_insurance_paid"
      expr: SUM(CAST(insurance_amount AS DOUBLE))
      comment: "Total insurance pass-through charges paid — contributes to full occupancy cost picture."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`realestate_lease`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides a portfolio-level view of lease obligations, financial exposure, and lease structure across all locations. Supports real-estate strategy, IFRS 16 / ASC 842 compliance reporting, and lease renewal planning."
  source: "`restaurants_ecm`.`realestate`.`lease`"
  dimensions:
    - name: "lease_status"
      expr: lease_status
      comment: "Current lifecycle status of the lease (e.g., Active, Expired, Terminated) — primary filter for portfolio health analysis."
    - name: "lease_type"
      expr: lease_type
      comment: "Classification of the lease structure (e.g., Ground Lease, Building Lease, NNN) — drives financial modeling assumptions."
    - name: "accounting_classification"
      expr: accounting_classification
      comment: "IFRS 16 / ASC 842 accounting classification (Finance vs. Operating) — critical for balance-sheet and P&L reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code of the lease — required for multi-currency portfolio consolidation."
    - name: "rent_escalation_type"
      expr: rent_escalation_type
      comment: "Type of rent escalation clause (e.g., Fixed, CPI, Percentage) — informs future rent obligation forecasting."
    - name: "co_tenancy_clause_flag"
      expr: co_tenancy_clause_flag
      comment: "Boolean indicating presence of a co-tenancy clause — flags leases with potential rent-reduction triggers."
    - name: "termination_clause_flag"
      expr: termination_clause_flag
      comment: "Boolean indicating whether the lease contains a termination option — used in portfolio flexibility analysis."
    - name: "commencement_year"
      expr: YEAR(commencement_date)
      comment: "Year the lease commenced — supports vintage cohort analysis of the portfolio."
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the lease expires — critical for renewal pipeline planning and maturity wall analysis."
  measures:
    - name: "total_lease_liability"
      expr: SUM(CAST(liability_value AS DOUBLE))
      comment: "Total present-value lease liability across the portfolio — a primary balance-sheet metric under IFRS 16 / ASC 842."
    - name: "total_rou_asset_value"
      expr: SUM(CAST(rou_asset_value AS DOUBLE))
      comment: "Total right-of-use asset value on the balance sheet — paired with lease liability for net lease position reporting."
    - name: "total_annual_base_rent"
      expr: SUM(CAST(base_rent_amount AS DOUBLE))
      comment: "Aggregate annualized base rent obligation across all active leases — core occupancy cost commitment metric."
    - name: "total_annual_cam_charges"
      expr: SUM(CAST(cam_charges_annual AS DOUBLE))
      comment: "Total annual CAM charges across the portfolio — variable occupancy cost exposure beyond base rent."
    - name: "total_annual_property_tax"
      expr: SUM(CAST(property_tax_annual AS DOUBLE))
      comment: "Total annual property tax obligations passed through to the company — informs total occupancy cost and tax planning."
    - name: "total_annual_insurance"
      expr: SUM(CAST(insurance_annual AS DOUBLE))
      comment: "Total annual insurance charges across all leases — component of full occupancy cost stack."
    - name: "total_security_deposit"
      expr: SUM(CAST(security_deposit_amount AS DOUBLE))
      comment: "Total security deposits held by landlords — represents locked capital that could be redeployed."
    - name: "total_termination_penalty_exposure"
      expr: SUM(CAST(termination_penalty_amount AS DOUBLE))
      comment: "Total financial exposure from early termination penalties across the portfolio — critical for portfolio restructuring decisions."
    - name: "avg_rent_escalation_rate"
      expr: AVG(CAST(rent_escalation_rate AS DOUBLE))
      comment: "Average rent escalation rate across leases — informs future rent cost trajectory and budget forecasting."
    - name: "avg_base_rent"
      expr: AVG(CAST(base_rent_amount AS DOUBLE))
      comment: "Average base rent per lease — benchmarking metric for portfolio rent level analysis."
    - name: "lease_count"
      expr: COUNT(1)
      comment: "Total number of lease records — baseline portfolio size metric."
    - name: "leases_with_termination_clause"
      expr: COUNT(CASE WHEN termination_clause_flag = TRUE THEN lease_id END)
      comment: "Number of leases containing a termination option — measures portfolio flexibility and exit optionality."
    - name: "leases_with_co_tenancy_clause"
      expr: COUNT(CASE WHEN co_tenancy_clause_flag = TRUE THEN lease_id END)
      comment: "Number of leases with co-tenancy clauses — quantifies rent-reduction risk exposure from anchor tenant departures."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`realestate_rent_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Models the scheduled rent obligation stream including occupancy cost percentages, percentage rent thresholds, and IFRS 16 amortization components. Supports lease accounting, cash-flow forecasting, and occupancy cost ratio analysis."
  source: "`restaurants_ecm`.`realestate`.`rent_schedule`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the scheduled payment (e.g., Scheduled, Paid, Overdue) — used to identify outstanding obligations."
    - name: "lease_accounting_classification"
      expr: lease_accounting_classification
      comment: "IFRS 16 / ASC 842 classification for the schedule line — drives P&L vs. balance-sheet treatment."
    - name: "escalation_type"
      expr: escalation_type
      comment: "Type of escalation applied to this schedule period (e.g., Fixed, CPI) — informs rent growth modeling."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the scheduled amounts — required for multi-currency consolidation."
    - name: "cam_reconciliation_flag"
      expr: cam_reconciliation_flag
      comment: "Boolean indicating whether CAM reconciliation is required for this period — flags periods needing landlord true-up."
    - name: "sales_reporting_required_flag"
      expr: sales_reporting_required_flag
      comment: "Boolean indicating whether sales must be reported to the landlord — identifies percentage-rent exposure periods."
    - name: "billing_period_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Month of the billing period start — enables monthly scheduled obligation trending."
    - name: "payment_due_month"
      expr: DATE_TRUNC('MONTH', payment_due_date)
      comment: "Month the scheduled payment is due — used for cash-flow forecasting by due date."
  measures:
    - name: "total_scheduled_occupancy_cost"
      expr: SUM(CAST(total_occupancy_cost AS DOUBLE))
      comment: "Total scheduled occupancy cost across all rent schedule lines — the most comprehensive occupancy cost commitment metric."
    - name: "total_scheduled_base_rent"
      expr: SUM(CAST(base_rent_amount AS DOUBLE))
      comment: "Total scheduled base rent obligations — fixed component of occupancy cost commitment."
    - name: "total_scheduled_cam"
      expr: SUM(CAST(cam_amount AS DOUBLE))
      comment: "Total scheduled CAM charges — variable occupancy cost component for budget planning."
    - name: "total_percentage_rent_scheduled"
      expr: SUM(CAST(percentage_rent_amount AS DOUBLE))
      comment: "Total percentage rent scheduled based on reported sales — measures variable rent exposure tied to revenue performance."
    - name: "total_rou_asset_depreciation"
      expr: SUM(CAST(right_of_use_asset_depreciation AS DOUBLE))
      comment: "Total ROU asset depreciation across schedule lines — key IFRS 16 P&L charge for finance leases."
    - name: "total_interest_expense"
      expr: SUM(CAST(interest_expense AS DOUBLE))
      comment: "Total interest expense on lease liabilities — IFRS 16 finance cost component affecting EBIT vs. EBITDA."
    - name: "total_lease_liability_reduction"
      expr: SUM(CAST(lease_liability_reduction AS DOUBLE))
      comment: "Total principal reduction of lease liabilities across schedule periods — tracks balance-sheet deleveraging from lease payments."
    - name: "avg_occupancy_cost_percentage"
      expr: AVG(CAST(occupancy_cost_percentage AS DOUBLE))
      comment: "Average occupancy cost as a percentage of reported sales — a critical restaurant-industry benchmark (target typically <10%)."
    - name: "avg_rent_per_square_foot"
      expr: AVG(CAST(rent_per_square_foot AS DOUBLE))
      comment: "Average rent per square foot across scheduled periods — standard real-estate efficiency benchmark."
    - name: "total_reported_sales"
      expr: SUM(CAST(reported_sales_amount AS DOUBLE))
      comment: "Total sales reported to landlords for percentage-rent calculation — links real-estate cost to revenue performance."
    - name: "schedule_line_count"
      expr: COUNT(1)
      comment: "Total number of rent schedule lines — baseline volume for average and rate calculations."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`realestate_nro_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks new restaurant opening (NRO) project performance including capital spend, schedule adherence, and pipeline health. Enables development leadership to manage capex efficiency, opening velocity, and project risk."
  source: "`restaurants_ecm`.`realestate`.`nro_project`"
  dimensions:
    - name: "nro_project_status"
      expr: nro_project_status
      comment: "Current status of the NRO project (e.g., In Progress, Completed, On Hold, Cancelled) — primary filter for pipeline health."
    - name: "project_type"
      expr: project_type
      comment: "Type of development project (e.g., New Build, Relocation, Conversion) — segments the pipeline by development strategy."
    - name: "project_phase"
      expr: project_phase
      comment: "Current phase of the project (e.g., Site Selection, Permitting, Construction, Pre-Opening) — enables phase-gate analysis."
    - name: "lease_type"
      expr: lease_type
      comment: "Lease structure for the new location (e.g., Ground Lease, Building Lease) — informs long-term occupancy cost modeling."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory and brand compliance status of the project — flags projects at risk of opening delays."
    - name: "permitting_status"
      expr: permitting_status
      comment: "Current permitting status — a leading indicator of construction start and opening date risk."
    - name: "risk_level"
      expr: risk_level
      comment: "Assessed risk level of the project (e.g., Low, Medium, High) — used to prioritize executive attention and mitigation."
    - name: "target_opening_year"
      expr: YEAR(target_opening_date)
      comment: "Year the restaurant is targeted to open — used for annual opening pipeline planning."
    - name: "actual_opening_year"
      expr: YEAR(actual_opening_date)
      comment: "Year the restaurant actually opened — used to measure opening velocity vs. plan."
    - name: "ifr16_lease_asset_flag"
      expr: ifr16_lease_asset_flag
      comment: "Boolean indicating whether the project carries an IFRS 16 lease asset — segments projects by accounting treatment."
  measures:
    - name: "total_capex_budget"
      expr: SUM(CAST(capex_budget_amount AS DOUBLE))
      comment: "Total approved capex budget across all NRO projects — primary capital commitment metric for development planning."
    - name: "total_capex_actual"
      expr: SUM(CAST(capex_actual_amount AS DOUBLE))
      comment: "Total actual capex spent across all NRO projects — measures capital deployment against budget."
    - name: "total_capex_committed"
      expr: SUM(CAST(capex_committed_amount AS DOUBLE))
      comment: "Total committed (contracted but not yet spent) capex — forward-looking capital obligation metric."
    - name: "avg_capex_budget_per_project"
      expr: AVG(CAST(capex_budget_amount AS DOUBLE))
      comment: "Average capex budget per NRO project — benchmarks investment per new unit for portfolio planning."
    - name: "avg_capex_actual_per_project"
      expr: AVG(CAST(capex_actual_amount AS DOUBLE))
      comment: "Average actual capex per NRO project — used to track unit economics of new restaurant development."
    - name: "project_count"
      expr: COUNT(1)
      comment: "Total number of NRO projects — measures development pipeline size and opening velocity."
    - name: "projects_at_high_risk"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN nro_project_id END)
      comment: "Number of projects assessed at high risk — executive escalation metric for development pipeline health."
    - name: "projects_with_permitting_issues"
      expr: COUNT(CASE WHEN permitting_status NOT IN ('Approved', 'Complete') THEN nro_project_id END)
      comment: "Number of projects where permitting is not yet approved — leading indicator of construction and opening delays."
    - name: "completed_projects_count"
      expr: COUNT(CASE WHEN nro_project_status = 'Completed' THEN nro_project_id END)
      comment: "Number of NRO projects successfully completed — measures actual new unit delivery against pipeline."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`realestate_capex_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Governs capital expenditure budgets for real-estate projects including new builds, remodels, and site improvements. Enables finance and development teams to track budget allocation, revision history, and cost-category composition."
  source: "`restaurants_ecm`.`realestate`.`capex_budget`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Classification of the capex budget (e.g., New Build, Remodel, Maintenance Capex) — segments capital allocation by strategic purpose."
    - name: "budget_phase"
      expr: budget_phase
      comment: "Phase of the budget lifecycle (e.g., Initial, Revised, Final) — tracks budget maturity and amendment history."
    - name: "capex_budget_status"
      expr: capex_budget_status
      comment: "Approval and execution status of the budget (e.g., Approved, Pending, Closed) — primary filter for active capital commitments."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of capital funding (e.g., Corporate, Franchisee, JV) — critical for capital allocation and return attribution."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code of the budget — required for multi-currency capital reporting."
    - name: "budget_revision_year"
      expr: YEAR(budget_revision_date)
      comment: "Year of the most recent budget revision — used to track amendment frequency and budget stability."
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the budget was approved — enables vintage analysis of capital commitments."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total approved capex budget across all real-estate projects — primary capital commitment metric for CFO reporting."
    - name: "total_budget_revision_amount"
      expr: SUM(CAST(budget_revision_amount AS DOUBLE))
      comment: "Total net revision to budgets — measures budget discipline and scope-change exposure across the portfolio."
    - name: "total_land_cost"
      expr: SUM(CAST(land_cost AS DOUBLE))
      comment: "Total budgeted land acquisition cost — key component of site investment for owned-location strategy."
    - name: "total_building_shell_cost"
      expr: SUM(CAST(building_shell_cost AS DOUBLE))
      comment: "Total budgeted building shell construction cost — largest single capex category for new builds."
    - name: "total_ffe_cost"
      expr: SUM(CAST(ffe_cost AS DOUBLE))
      comment: "Total budgeted furniture, fixtures, and equipment cost — tracks equipment investment per project cohort."
    - name: "total_leasehold_improvements_cost"
      expr: SUM(CAST(leasehold_improvements_cost AS DOUBLE))
      comment: "Total budgeted leasehold improvement cost — key metric for leased-location capital investment analysis."
    - name: "total_technology_cost"
      expr: SUM(CAST(technology_cost AS DOUBLE))
      comment: "Total budgeted technology investment across projects — tracks digital infrastructure spend in new and remodeled units."
    - name: "total_signage_cost"
      expr: SUM(CAST(signage_cost AS DOUBLE))
      comment: "Total budgeted signage cost — brand visibility investment component of the capex stack."
    - name: "total_soft_costs"
      expr: SUM(CAST(soft_costs AS DOUBLE))
      comment: "Total budgeted soft costs (architecture, legal, permitting fees) — often underestimated; tracked separately for benchmarking."
    - name: "avg_total_budget_per_project"
      expr: AVG(CAST(total_budget_amount AS DOUBLE))
      comment: "Average total capex budget per project — unit-economics benchmark for new restaurant investment."
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Total number of capex budget records — baseline count for portfolio-level capital planning."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`realestate_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides a physical asset health and compliance view across all restaurant facilities. Enables facilities management, operations, and risk teams to monitor condition scores, compliance status, maintenance readiness, and capital spend."
  source: "`restaurants_ecm`.`realestate`.`facility`"
  dimensions:
    - name: "facility_status"
      expr: facility_status
      comment: "Operational status of the facility (e.g., Active, Closed, Under Renovation) — primary filter for active asset analysis."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (e.g., Freestanding, In-Line, Drive-Thru Only) — segments the portfolio by format."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership model (e.g., Company-Owned, Franchisee, Ground Lease) — critical for capital responsibility attribution."
    - name: "construction_status"
      expr: construction_status
      comment: "Current construction or renovation status — identifies facilities in transition."
    - name: "ada_compliance_status"
      expr: ada_compliance_status
      comment: "ADA compliance status — regulatory risk indicator; non-compliant facilities represent legal and reputational exposure."
    - name: "fire_safety_compliance_status"
      expr: fire_safety_compliance_status
      comment: "Fire safety compliance status — life-safety regulatory metric requiring executive visibility."
    - name: "r_and_m_status"
      expr: r_and_m_status
      comment: "Repair and maintenance status of the facility — operational readiness indicator."
    - name: "energy_rating"
      expr: energy_rating
      comment: "Energy efficiency rating of the facility — sustainability KPI and proxy for utility cost efficiency."
    - name: "remodel_type"
      expr: remodel_type
      comment: "Type of most recent remodel (e.g., Full, Partial, Image Update) — used to track brand standard compliance investment."
    - name: "zoning_type"
      expr: zoning_type
      comment: "Zoning classification of the facility — informs permissible use and expansion optionality."
    - name: "last_inspection_year"
      expr: YEAR(last_inspection_date)
      comment: "Year of the last health/safety inspection — used to identify facilities overdue for inspection."
  measures:
    - name: "avg_condition_score"
      expr: AVG(CAST(condition_score AS DOUBLE))
      comment: "Average physical condition score across facilities — primary asset health KPI; low scores trigger capital reinvestment decisions."
    - name: "avg_health_inspection_score"
      expr: AVG(CAST(health_inspection_score AS DOUBLE))
      comment: "Average health inspection score — regulatory compliance and brand quality metric with direct customer safety implications."
    - name: "total_capex_spent"
      expr: SUM(CAST(capex_spent AS DOUBLE))
      comment: "Total capital expenditure spent on facilities — measures actual investment in the physical asset base."
    - name: "total_cam_charges"
      expr: SUM(CAST(cam_charges AS DOUBLE))
      comment: "Total CAM charges across all facilities — variable occupancy cost component for portfolio cost management."
    - name: "total_tax_assessment_value"
      expr: SUM(CAST(tax_assessment_value AS DOUBLE))
      comment: "Total assessed property tax value across the facility portfolio — informs property tax liability and appeal strategy."
    - name: "avg_property_tax_rate"
      expr: AVG(CAST(property_tax_rate AS DOUBLE))
      comment: "Average property tax rate across facilities — benchmarks tax burden by market and informs site selection decisions."
    - name: "total_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Total square footage across all facilities — portfolio scale metric used to normalize per-sqft cost benchmarks."
    - name: "avg_square_footage"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average facility size in square feet — format benchmark used in occupancy cost per sqft analysis."
    - name: "facility_count"
      expr: COUNT(1)
      comment: "Total number of facility records — baseline portfolio size metric."
    - name: "non_ada_compliant_count"
      expr: COUNT(CASE WHEN ada_compliance_status != 'Compliant' THEN facility_id END)
      comment: "Number of facilities not meeting ADA compliance standards — regulatory risk metric requiring remediation tracking."
    - name: "avg_waste_percentage"
      expr: AVG(CAST(waste_percentage AS DOUBLE))
      comment: "Average waste percentage across facilities — operational efficiency and sustainability metric."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across facilities — measures productive utilization of the physical asset."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`realestate_maintenance_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks maintenance work order volume, cost, and resolution performance across all facilities. Enables facilities management to monitor repair spend, labor efficiency, warranty utilization, and issue category trends."
  source: "`restaurants_ecm`.`realestate`.`maintenance_work_order`"
  dimensions:
    - name: "maintenance_work_order_status"
      expr: maintenance_work_order_status
      comment: "Current status of the work order (e.g., Open, In Progress, Completed, Cancelled) — primary filter for backlog analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the work order (e.g., Emergency, High, Medium, Low) — used to assess response-time compliance."
    - name: "issue_category"
      expr: issue_category
      comment: "Category of the maintenance issue (e.g., HVAC, Plumbing, Electrical, Equipment) — identifies recurring failure patterns."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for work order costs — required for multi-currency cost consolidation."
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Boolean indicating whether the work order is covered under warranty — measures warranty recovery rate."
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month the work order was scheduled — enables monthly maintenance activity trending."
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_timestamp)
      comment: "Month the work order was completed — used to measure resolution velocity over time."
  measures:
    - name: "total_maintenance_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total maintenance spend across all work orders — primary R&M cost metric for facilities budget management."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost component of maintenance work orders — used to benchmark labor efficiency and contractor rates."
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Total parts and materials cost across work orders — tracks supply chain spend for maintenance operations."
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labor hours expended on maintenance — workforce productivity metric for facilities operations."
    - name: "avg_cost_per_work_order"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average total cost per work order — benchmarks maintenance efficiency and identifies cost outliers."
    - name: "avg_labor_hours_per_work_order"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labor hours per work order — measures technician productivity and job complexity trends."
    - name: "work_order_count"
      expr: COUNT(1)
      comment: "Total number of maintenance work orders — baseline volume metric for maintenance activity analysis."
    - name: "emergency_work_order_count"
      expr: COUNT(CASE WHEN priority_level = 'Emergency' THEN maintenance_work_order_id END)
      comment: "Number of emergency-priority work orders — measures reactive maintenance burden and facility condition risk."
    - name: "warranty_claim_count"
      expr: COUNT(CASE WHEN warranty_claim_flag = TRUE THEN maintenance_work_order_id END)
      comment: "Number of work orders submitted as warranty claims — measures warranty recovery and vendor accountability."
    - name: "open_work_order_count"
      expr: COUNT(CASE WHEN maintenance_work_order_status = 'Open' THEN maintenance_work_order_id END)
      comment: "Number of currently open work orders — real-time backlog metric for facilities operations management."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`realestate_maintenance_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manages the portfolio of maintenance service contracts covering facilities and equipment. Enables procurement and facilities teams to track contract value, coverage, renewal risk, and vendor compliance."
  source: "`restaurants_ecm`.`realestate`.`maintenance_contract`"
  dimensions:
    - name: "maintenance_contract_status"
      expr: maintenance_contract_status
      comment: "Current status of the maintenance contract (e.g., Active, Expired, Pending Renewal) — primary filter for active coverage analysis."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of maintenance contract (e.g., Full Service, Preventive, On-Call) — segments coverage model and cost structure."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of contract payments (e.g., Monthly, Quarterly, Annual) — informs cash-flow planning for maintenance spend."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code of the contract — required for multi-currency vendor spend consolidation."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Boolean indicating whether the contract auto-renews — flags contracts requiring proactive renewal management."
    - name: "warranty_coverage_flag"
      expr: warranty_coverage_flag
      comment: "Boolean indicating whether the contract includes warranty coverage — used to assess warranty recovery potential."
    - name: "service_frequency"
      expr: service_frequency
      comment: "Frequency of scheduled service visits — used to assess preventive maintenance coverage intensity."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the contract became effective — used for contract vintage and renewal cycle analysis."
    - name: "effective_end_year"
      expr: YEAR(effective_end_date)
      comment: "Year the contract expires — critical for renewal pipeline planning and coverage gap identification."
  measures:
    - name: "total_annual_contract_value"
      expr: SUM(CAST(annual_contract_value AS DOUBLE))
      comment: "Total annual value of all maintenance contracts — primary vendor spend metric for procurement and budget management."
    - name: "avg_annual_contract_value"
      expr: AVG(CAST(annual_contract_value AS DOUBLE))
      comment: "Average annual contract value — benchmarks vendor pricing and identifies outlier contracts for renegotiation."
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total number of maintenance contracts — measures vendor portfolio breadth and coverage complexity."
    - name: "auto_renewal_contract_count"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN maintenance_contract_id END)
      comment: "Number of contracts set to auto-renew — identifies contracts requiring proactive review before automatic commitment."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN maintenance_contract_status = 'Active' THEN maintenance_contract_id END)
      comment: "Number of currently active maintenance contracts — measures live coverage across the facility portfolio."
    - name: "contracts_expiring_soon_count"
      expr: COUNT(CASE WHEN effective_end_date <= DATE_ADD(CURRENT_DATE(), 90) AND effective_end_date >= CURRENT_DATE() THEN maintenance_contract_id END)
      comment: "Number of contracts expiring within 90 days — proactive renewal risk metric to prevent coverage gaps."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`realestate_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides a strategic portfolio view of all restaurant sites including location economics, site characteristics, and lifecycle stage. Supports site selection, portfolio optimization, and real-estate strategy decisions."
  source: "`restaurants_ecm`.`realestate`.`site`"
  dimensions:
    - name: "site_type"
      expr: site_type
      comment: "Type of site (e.g., Freestanding, End-Cap, In-Line, Drive-Thru) — primary format segmentation for portfolio analysis."
    - name: "ownership_status"
      expr: ownership_status
      comment: "Ownership model of the site (e.g., Owned, Leased, Ground Lease) — drives capital structure and balance-sheet treatment."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Current lifecycle stage of the site (e.g., Active, Pipeline, Closed) — used for portfolio health and growth planning."
    - name: "market_classification"
      expr: market_classification
      comment: "Market tier classification (e.g., Urban, Suburban, Rural) — enables market-level performance benchmarking."
    - name: "country_code"
      expr: country_code
      comment: "ISO country code of the site — required for international portfolio segmentation."
    - name: "state_province"
      expr: state_province
      comment: "State or province of the site — enables regional portfolio analysis and regulatory compliance tracking."
    - name: "city"
      expr: city
      comment: "City of the site — granular geographic dimension for local market analysis."
    - name: "zoning_classification"
      expr: zoning_classification
      comment: "Zoning classification of the site — informs permissible use, expansion potential, and regulatory risk."
    - name: "drive_thru_capable"
      expr: drive_thru_capable
      comment: "Boolean indicating drive-thru capability — key format attribute correlated with AUV and throughput performance."
    - name: "opening_year"
      expr: YEAR(opening_date)
      comment: "Year the site opened — used for vintage cohort analysis of site economics."
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year the site was acquired — tracks capital deployment timing for owned-location portfolio."
  measures:
    - name: "total_capex_investment"
      expr: SUM(CAST(total_capex_investment AS DOUBLE))
      comment: "Total capital invested across all sites — primary portfolio investment metric for real-estate strategy."
    - name: "avg_capex_investment_per_site"
      expr: AVG(CAST(total_capex_investment AS DOUBLE))
      comment: "Average capex investment per site — unit-economics benchmark for new site development and remodel decisions."
    - name: "total_monthly_base_rent"
      expr: SUM(CAST(monthly_base_rent AS DOUBLE))
      comment: "Total monthly base rent obligation across all leased sites — primary recurring occupancy cost metric."
    - name: "total_monthly_cam_charges"
      expr: SUM(CAST(monthly_cam_charges AS DOUBLE))
      comment: "Total monthly CAM charges across all sites — variable occupancy cost component for cash-flow planning."
    - name: "avg_projected_auv"
      expr: AVG(CAST(projected_auv AS DOUBLE))
      comment: "Average projected annual unit volume (AUV) across sites — key site selection and portfolio quality metric."
    - name: "total_projected_auv"
      expr: SUM(CAST(projected_auv AS DOUBLE))
      comment: "Total projected AUV across the site portfolio — aggregate revenue potential metric for portfolio planning."
    - name: "avg_accessibility_score"
      expr: AVG(CAST(accessibility_score AS DOUBLE))
      comment: "Average site accessibility score — location quality metric correlated with customer traffic and AUV."
    - name: "avg_visibility_score"
      expr: AVG(CAST(visibility_score AS DOUBLE))
      comment: "Average site visibility score — location quality metric used in site selection and portfolio grading."
    - name: "site_count"
      expr: COUNT(1)
      comment: "Total number of sites in the portfolio — baseline portfolio size metric."
    - name: "drive_thru_site_count"
      expr: COUNT(CASE WHEN drive_thru_capable = TRUE THEN site_id END)
      comment: "Number of sites with drive-thru capability — measures format mix and throughput capacity of the portfolio."
    - name: "avg_percentage_rent_rate"
      expr: AVG(CAST(percentage_rent_rate AS DOUBLE))
      comment: "Average percentage rent rate across sites — measures variable rent exposure tied to sales performance."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`realestate_landlord`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides a relationship health and portfolio concentration view of the landlord base. Enables real-estate and legal teams to manage landlord relationships, track compliance obligations, and assess counterparty risk."
  source: "`restaurants_ecm`.`realestate`.`landlord`"
  dimensions:
    - name: "landlord_status"
      expr: landlord_status
      comment: "Current status of the landlord relationship (e.g., Active, Inactive, Terminated) — primary filter for active counterparty analysis."
    - name: "entity_type"
      expr: entity_type
      comment: "Legal entity type of the landlord (e.g., REIT, Private Individual, Institutional) — segments counterparty risk profile."
    - name: "relationship_tier"
      expr: relationship_tier
      comment: "Strategic tier of the landlord relationship (e.g., Strategic, Standard, Transactional) — drives engagement and negotiation strategy."
    - name: "negotiation_posture"
      expr: negotiation_posture
      comment: "Landlord's typical negotiation posture (e.g., Flexible, Firm, Aggressive) — informs lease renewal and amendment strategy."
    - name: "cam_billing_method"
      expr: cam_billing_method
      comment: "Method used by landlord to bill CAM charges (e.g., Estimated, Actual, Capped) — affects occupancy cost predictability."
    - name: "insurance_certificate_required_flag"
      expr: insurance_certificate_required_flag
      comment: "Boolean indicating whether the landlord requires insurance certificates — compliance obligation tracking."
    - name: "w9_on_file_flag"
      expr: w9_on_file_flag
      comment: "Boolean indicating whether a W-9 is on file for the landlord — tax compliance requirement for payment processing."
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Country of the landlord's billing address — geographic segmentation for international portfolio management."
  measures:
    - name: "avg_relationship_health_score"
      expr: AVG(CAST(relationship_health_score AS DOUBLE))
      comment: "Average landlord relationship health score — strategic KPI for real-estate team; low scores trigger proactive engagement."
    - name: "landlord_count"
      expr: COUNT(1)
      comment: "Total number of landlords in the portfolio — measures counterparty concentration and diversification."
    - name: "landlords_missing_w9"
      expr: COUNT(CASE WHEN w9_on_file_flag = FALSE THEN landlord_id END)
      comment: "Number of landlords without a W-9 on file — tax compliance risk metric; unresolved cases block payment processing."
    - name: "landlords_requiring_insurance_cert"
      expr: COUNT(CASE WHEN insurance_certificate_required_flag = TRUE THEN landlord_id END)
      comment: "Number of landlords requiring insurance certificates — compliance obligation volume metric for risk management."
    - name: "strategic_landlord_count"
      expr: COUNT(CASE WHEN relationship_tier = 'Strategic' THEN landlord_id END)
      comment: "Number of landlords classified as strategic tier — measures concentration of portfolio in high-priority relationships."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`realestate_lease_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks lease amendment activity including financial impact, space changes, and legal review status. Enables real-estate and finance teams to monitor portfolio restructuring activity, TI allowance recovery, and IFRS 16 remeasurement triggers."
  source: "`restaurants_ecm`.`realestate`.`lease_amendment`"
  dimensions:
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of lease amendment (e.g., Rent Reduction, Extension, Expansion, Termination) — classifies restructuring activity."
    - name: "lease_amendment_status"
      expr: lease_amendment_status
      comment: "Current status of the amendment (e.g., Executed, Pending, Rejected) — primary filter for active amendment pipeline."
    - name: "legal_review_status"
      expr: legal_review_status
      comment: "Legal review status of the amendment — tracks amendments awaiting legal clearance before execution."
    - name: "amendment_reason"
      expr: amendment_reason
      comment: "Business reason for the amendment — used to categorize portfolio restructuring drivers."
    - name: "ifrs16_impact_flag"
      expr: ifrs16_impact_flag
      comment: "Boolean indicating whether the amendment triggers an IFRS 16 lease remeasurement — critical for accounting close planning."
    - name: "permitted_use_change_flag"
      expr: permitted_use_change_flag
      comment: "Boolean indicating whether the amendment changes permitted use — flags amendments with operational implications."
    - name: "co_tenancy_waiver_flag"
      expr: co_tenancy_waiver_flag
      comment: "Boolean indicating whether a co-tenancy clause was waived — tracks landlord concessions in the amendment."
    - name: "space_change_type"
      expr: space_change_type
      comment: "Type of space change in the amendment (e.g., Expansion, Reduction, No Change) — tracks portfolio footprint evolution."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the amendment becomes effective — used for annual amendment activity trending."
  measures:
    - name: "total_net_impact_amount"
      expr: SUM(CAST(net_impact_amount AS DOUBLE))
      comment: "Total net financial impact of all lease amendments — measures aggregate P&L and balance-sheet effect of portfolio restructuring."
    - name: "total_rent_change_amount"
      expr: SUM(CAST(rent_change_amount AS DOUBLE))
      comment: "Total rent change amount across all amendments — measures net rent savings or increases from renegotiation activity."
    - name: "total_ti_allowance_secured"
      expr: SUM(CAST(ti_allowance_amount AS DOUBLE))
      comment: "Total tenant improvement allowance secured through amendments — measures landlord capital contribution recovery."
    - name: "total_space_change_sqft"
      expr: SUM(CAST(space_change_sqft AS DOUBLE))
      comment: "Net square footage change across all amendments — tracks portfolio footprint expansion or contraction."
    - name: "amendment_count"
      expr: COUNT(1)
      comment: "Total number of lease amendments — measures portfolio restructuring activity volume."
    - name: "ifrs16_remeasurement_count"
      expr: COUNT(CASE WHEN ifrs16_impact_flag = TRUE THEN lease_amendment_id END)
      comment: "Number of amendments triggering IFRS 16 remeasurement — accounting close workload metric for the finance team."
    - name: "avg_rent_change_per_amendment"
      expr: AVG(CAST(rent_change_amount AS DOUBLE))
      comment: "Average rent change per amendment — benchmarks negotiation effectiveness across the real-estate team."
$$;