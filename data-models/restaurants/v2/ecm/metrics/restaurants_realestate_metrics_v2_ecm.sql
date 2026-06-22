-- Metric views for domain: realestate | Business: Restaurants | Version: 2 | Generated on: 2026-06-22 15:12:58

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Portfolio-level site metrics tracking investment, rent economics, and site pipeline health across the real estate portfolio."
  source: "`vibe_restaurants_v1`.`realestate`.`site`"
  dimensions:
    - name: "site_type"
      expr: site_type
      comment: "Classification of site (end-cap, inline, freestanding, drive-thru, etc.) for portfolio segmentation."
    - name: "ownership_status"
      expr: ownership_status
      comment: "Whether the site is owned, leased, or ground-leased — drives capital vs. operating cost analysis."
    - name: "market_classification"
      expr: market_classification
      comment: "Market tier (urban, suburban, rural) for geographic performance benchmarking."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Stage of site lifecycle (prospecting, under construction, open, closed) for pipeline tracking."
    - name: "state_province"
      expr: state_province
      comment: "State or province for regional real estate portfolio analysis."
    - name: "drive_thru_capable"
      expr: drive_thru_capable
      comment: "Whether the site has drive-thru capability — key differentiator for AUV and format strategy."
    - name: "zoning_classification"
      expr: zoning_classification
      comment: "Zoning type for regulatory and development planning."
    - name: "opening_year"
      expr: YEAR(opening_date)
      comment: "Year the site opened, used for cohort analysis of portfolio vintage."
  measures:
    - name: "total_sites"
      expr: COUNT(1)
      comment: "Total number of sites in the portfolio — baseline portfolio size KPI."
    - name: "total_capex_investment"
      expr: SUM(CAST(total_capex_investment AS DOUBLE))
      comment: "Total capital invested across all sites — critical for ROI and capital allocation decisions."
    - name: "avg_capex_per_site"
      expr: AVG(CAST(total_capex_investment AS DOUBLE))
      comment: "Average capital investment per site — benchmarks new development cost efficiency."
    - name: "total_projected_auv"
      expr: SUM(CAST(projected_auv AS DOUBLE))
      comment: "Sum of projected annual unit volumes across portfolio — forward-looking revenue pipeline."
    - name: "avg_projected_auv"
      expr: AVG(CAST(projected_auv AS DOUBLE))
      comment: "Average projected AUV per site — used to evaluate site quality and investment return potential."
    - name: "total_monthly_base_rent"
      expr: SUM(CAST(monthly_base_rent AS DOUBLE))
      comment: "Total monthly base rent obligation across all leased sites — key occupancy cost driver."
    - name: "avg_monthly_base_rent"
      expr: AVG(CAST(monthly_base_rent AS DOUBLE))
      comment: "Average monthly base rent per site — benchmarks lease negotiation outcomes."
    - name: "total_monthly_cam_charges"
      expr: SUM(CAST(monthly_cam_charges AS DOUBLE))
      comment: "Total monthly CAM charges across portfolio — tracks operating cost exposure beyond base rent."
    - name: "avg_accessibility_score"
      expr: AVG(CAST(accessibility_score AS DOUBLE))
      comment: "Average site accessibility score — proxy for customer convenience and traffic capture potential."
    - name: "avg_visibility_score"
      expr: AVG(CAST(visibility_score AS DOUBLE))
      comment: "Average site visibility score — correlates with brand awareness and walk-in traffic."
    - name: "drive_thru_site_count"
      expr: COUNT(CASE WHEN drive_thru_capable = TRUE THEN 1 END)
      comment: "Number of drive-thru capable sites — strategic format mix metric for operations and marketing."
    - name: "drive_thru_penetration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN drive_thru_capable = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of portfolio with drive-thru capability — informs format strategy and capital planning."
    - name: "avg_percentage_rent_rate"
      expr: AVG(CAST(percentage_rent_rate AS DOUBLE))
      comment: "Average percentage rent rate across leases — tracks variable rent exposure tied to sales performance."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_lease`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lease portfolio metrics covering rent obligations, lease economics, liability exposure, and renewal risk management."
  source: "`vibe_restaurants_v1`.`realestate`.`lease`"
  dimensions:
    - name: "lease_type"
      expr: lease_type
      comment: "Type of lease (NNN, gross, modified gross) — determines total occupancy cost structure."
    - name: "lease_status"
      expr: lease_status
      comment: "Current status of the lease (active, expired, terminated, in-negotiation) for portfolio health monitoring."
    - name: "accounting_classification"
      expr: accounting_classification
      comment: "IFRS 16 / ASC 842 classification (finance lease vs. operating lease) — drives balance sheet treatment."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the lease for multi-currency portfolio analysis."
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the lease expires — critical for renewal pipeline and risk management."
    - name: "commencement_year"
      expr: YEAR(commencement_date)
      comment: "Year the lease commenced — used for vintage cohort analysis of lease terms."
  measures:
    - name: "total_active_leases"
      expr: COUNT(1)
      comment: "Total number of leases in the portfolio — baseline lease portfolio size."
    - name: "total_annual_base_rent"
      expr: SUM(CAST(base_rent_amount AS DOUBLE))
      comment: "Total annual base rent obligation across all leases — primary occupancy cost KPI."
    - name: "avg_base_rent_per_lease"
      expr: AVG(CAST(base_rent_amount AS DOUBLE))
      comment: "Average base rent per lease — benchmarks negotiation outcomes and market rates."
    - name: "total_rou_asset_value"
      expr: SUM(CAST(rou_asset_value AS DOUBLE))
      comment: "Total right-of-use asset value across all leases — key balance sheet metric under IFRS 16 / ASC 842."
    - name: "total_lease_liability"
      expr: SUM(CAST(liability_value AS DOUBLE))
      comment: "Total lease liability on balance sheet — critical for debt covenant compliance and financial reporting."
    - name: "avg_lease_liability"
      expr: AVG(CAST(liability_value AS DOUBLE))
      comment: "Average lease liability per lease — used to assess per-unit financial obligation."
    - name: "total_annual_cam_charges"
      expr: SUM(CAST(cam_charges_annual AS DOUBLE))
      comment: "Total annual CAM charges across portfolio — tracks operating cost exposure beyond base rent."
    - name: "total_annual_property_tax"
      expr: SUM(CAST(property_tax_annual AS DOUBLE))
      comment: "Total annual property tax obligation — significant occupancy cost component for owned/NNN leases."
    - name: "total_security_deposit"
      expr: SUM(CAST(security_deposit_amount AS DOUBLE))
      comment: "Total security deposits held — represents capital tied up in lease obligations."
    - name: "avg_rent_escalation_rate"
      expr: AVG(CAST(rent_escalation_rate AS DOUBLE))
      comment: "Average rent escalation rate across leases — forecasts future rent cost growth."
    - name: "total_termination_penalty_exposure"
      expr: SUM(CAST(termination_penalty_amount AS DOUBLE))
      comment: "Total potential termination penalty exposure — quantifies exit cost risk across the portfolio."
    - name: "leases_with_termination_clause"
      expr: COUNT(CASE WHEN termination_clause_flag = TRUE THEN 1 END)
      comment: "Number of leases with termination clauses — measures portfolio flexibility for strategic exits."
    - name: "termination_clause_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN termination_clause_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of leases with termination clauses — strategic flexibility indicator for portfolio management."
    - name: "avg_percentage_rent_rate"
      expr: AVG(CAST(percentage_rent_rate AS DOUBLE))
      comment: "Average percentage rent rate — tracks variable rent exposure tied to sales performance."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_rent_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rent payment execution metrics tracking payment performance, late fees, disputes, and total occupancy cost cash outflows."
  source: "`vibe_restaurants_v1`.`realestate`.`rent_payment`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of payment reconciliation — identifies unreconciled payments requiring follow-up."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the payment is under dispute — flags payments requiring landlord negotiation."
    - name: "late_fee_applied_flag"
      expr: late_fee_applied_flag
      comment: "Whether a late fee was applied — tracks payment discipline and cash management performance."
    - name: "currency_code"
      expr: currency_code
      comment: "Payment currency for multi-currency portfolio analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the payment for period-over-period trend analysis."
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year of payment for annual occupancy cost trend analysis."
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of payment for monthly cash flow monitoring."
  measures:
    - name: "total_payments"
      expr: COUNT(1)
      comment: "Total number of rent payments processed — baseline payment volume KPI."
    - name: "total_rent_paid"
      expr: SUM(CAST(total_payment_amount AS DOUBLE))
      comment: "Total rent cash outflow — primary occupancy cost cash flow KPI for treasury and finance."
    - name: "total_base_rent_paid"
      expr: SUM(CAST(base_rent_amount AS DOUBLE))
      comment: "Total base rent component paid — isolates fixed rent obligation from variable charges."
    - name: "total_cam_paid"
      expr: SUM(CAST(cam_amount AS DOUBLE))
      comment: "Total CAM charges paid — tracks operating cost recovery payments to landlords."
    - name: "total_property_tax_paid"
      expr: SUM(CAST(property_tax_amount AS DOUBLE))
      comment: "Total property tax payments — tracks tax obligation cash outflows."
    - name: "total_late_fees_paid"
      expr: SUM(CAST(late_fee_amount AS DOUBLE))
      comment: "Total late fees incurred — measures cost of payment timing failures; should trend toward zero."
    - name: "total_payment_variance"
      expr: SUM(CAST(payment_variance_amount AS DOUBLE))
      comment: "Total variance between scheduled and actual payments — identifies systematic over/underpayment patterns."
    - name: "avg_payment_variance"
      expr: AVG(CAST(payment_variance_amount AS DOUBLE))
      comment: "Average payment variance per transaction — benchmarks payment accuracy."
    - name: "disputed_payment_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of disputed payments — tracks landlord relationship friction and billing accuracy issues."
    - name: "disputed_payment_amount"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN total_payment_amount ELSE 0 END)
      comment: "Total amount under dispute — quantifies financial exposure from payment disputes."
    - name: "late_payment_count"
      expr: COUNT(CASE WHEN late_fee_applied_flag = TRUE THEN 1 END)
      comment: "Number of late payments — measures treasury and AP process discipline."
    - name: "late_payment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN late_fee_applied_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments made late — key AP performance and landlord relationship health metric."
    - name: "total_scheduled_payment_amount"
      expr: SUM(CAST(scheduled_payment_amount AS DOUBLE))
      comment: "Total scheduled rent obligations — used to compare against actual payments for variance analysis."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_rent_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rent schedule metrics for forecasting occupancy costs, tracking lease accounting components, and monitoring escalation impacts."
  source: "`vibe_restaurants_v1`.`realestate`.`rent_schedule`"
  dimensions:
    - name: "lease_accounting_classification"
      expr: lease_accounting_classification
      comment: "IFRS 16 / ASC 842 lease classification — determines P&L vs. balance sheet treatment of rent."
    - name: "escalation_type"
      expr: escalation_type
      comment: "Type of rent escalation (fixed, CPI, percentage) — drives rent cost forecasting methodology."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rent schedule for multi-currency portfolio analysis."
    - name: "cam_reconciliation_flag"
      expr: cam_reconciliation_flag
      comment: "Whether CAM reconciliation is required for this period — identifies periods requiring landlord settlement."
    - name: "sales_reporting_required_flag"
      expr: sales_reporting_required_flag
      comment: "Whether sales reporting is required for percentage rent calculation."
    - name: "billing_period_month"
      expr: DATE_TRUNC('month', billing_period_start_date)
      comment: "Billing period month for monthly occupancy cost trend analysis."
    - name: "billing_period_year"
      expr: YEAR(billing_period_start_date)
      comment: "Billing period year for annual occupancy cost planning."
  measures:
    - name: "total_scheduled_base_rent"
      expr: SUM(CAST(base_rent_amount AS DOUBLE))
      comment: "Total scheduled base rent across all periods — primary forward-looking occupancy cost obligation."
    - name: "total_scheduled_cam"
      expr: SUM(CAST(cam_amount AS DOUBLE))
      comment: "Total scheduled CAM charges — tracks operating cost recovery obligations."
    - name: "total_total_occupancy_cost"
      expr: SUM(CAST(total_occupancy_cost AS DOUBLE))
      comment: "Total all-in occupancy cost (rent + CAM + tax + insurance) — comprehensive real estate cost KPI."
    - name: "avg_occupancy_cost_percentage"
      expr: AVG(CAST(occupancy_cost_percentage AS DOUBLE))
      comment: "Average occupancy cost as a percentage of sales — critical profitability metric for restaurant real estate."
    - name: "total_percentage_rent"
      expr: SUM(CAST(percentage_rent_amount AS DOUBLE))
      comment: "Total percentage rent paid — tracks variable rent exposure tied to sales performance."
    - name: "total_rou_asset_depreciation"
      expr: SUM(CAST(right_of_use_asset_depreciation AS DOUBLE))
      comment: "Total ROU asset depreciation — key IFRS 16 / ASC 842 P&L impact metric."
    - name: "total_lease_liability_reduction"
      expr: SUM(CAST(lease_liability_reduction AS DOUBLE))
      comment: "Total lease liability principal reduction — tracks balance sheet deleveraging from lease payments."
    - name: "total_interest_expense"
      expr: SUM(CAST(interest_expense AS DOUBLE))
      comment: "Total interest expense on lease liabilities — IFRS 16 finance cost component for P&L reporting."
    - name: "avg_rent_per_square_foot"
      expr: AVG(CAST(rent_per_square_foot AS DOUBLE))
      comment: "Average rent per square foot — standard real estate benchmarking metric for market comparison."
    - name: "total_reported_sales"
      expr: SUM(CAST(reported_sales_amount AS DOUBLE))
      comment: "Total reported sales used for percentage rent calculation — validates sales reporting compliance."
    - name: "avg_escalation_rate"
      expr: AVG(CAST(escalation_rate AS DOUBLE))
      comment: "Average rent escalation rate — forecasts future rent cost growth trajectory."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_cam_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CAM reconciliation metrics tracking billing accuracy, dispute rates, over/underpayment exposure, and landlord settlement outcomes."
  source: "`vibe_restaurants_v1`.`realestate`.`cam_reconciliation`"
  dimensions:
    - name: "cam_reconciliation_status"
      expr: cam_reconciliation_status
      comment: "Status of the CAM reconciliation (pending, completed, disputed) — tracks settlement pipeline."
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Type of reconciliation (annual, interim, final) — categorizes reconciliation activity."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the reconciliation is under dispute — flags landlord billing accuracy issues."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of any dispute — tracks resolution progress."
    - name: "cam_itemization_flag"
      expr: cam_itemization_flag
      comment: "Whether itemized CAM breakdown was provided — measures landlord transparency compliance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the reconciliation for multi-currency portfolio analysis."
    - name: "reconciliation_year"
      expr: YEAR(period_start_date)
      comment: "Year of the reconciliation period for annual CAM cost trend analysis."
  measures:
    - name: "total_reconciliations"
      expr: COUNT(1)
      comment: "Total number of CAM reconciliations processed — baseline activity volume."
    - name: "total_cam_billed"
      expr: SUM(CAST(cam_billed_amount AS DOUBLE))
      comment: "Total CAM charges billed by landlords — tracks gross CAM cost exposure."
    - name: "total_cam_estimated"
      expr: SUM(CAST(cam_estimated_amount AS DOUBLE))
      comment: "Total CAM charges estimated — used to compare against actual billings for variance analysis."
    - name: "total_cam_final"
      expr: SUM(CAST(cam_final_amount AS DOUBLE))
      comment: "Total final settled CAM amounts — represents actual CAM cost after reconciliation."
    - name: "total_cam_adjustments"
      expr: SUM(CAST(cam_adjustments_amount AS DOUBLE))
      comment: "Total CAM adjustments negotiated — measures value recovered through audit and negotiation."
    - name: "total_cam_exclusions"
      expr: SUM(CAST(cam_exclusions_amount AS DOUBLE))
      comment: "Total CAM exclusions applied — tracks lease-protected cost exclusions enforced."
    - name: "total_overpayment_credits"
      expr: SUM(CAST(overpayment_credit_amount AS DOUBLE))
      comment: "Total overpayment credits recovered — measures CAM audit recovery value."
    - name: "total_underpayment_due"
      expr: SUM(CAST(underpayment_due_amount AS DOUBLE))
      comment: "Total underpayment amounts owed to landlords — tracks additional cash obligations from reconciliation."
    - name: "disputed_reconciliation_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of disputed CAM reconciliations — measures landlord billing dispute frequency."
    - name: "dispute_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CAM reconciliations under dispute — key landlord relationship and billing accuracy KPI."
    - name: "avg_cam_variance"
      expr: AVG(CAST(cam_adjustments_amount AS DOUBLE))
      comment: "Average CAM adjustment per reconciliation — benchmarks audit effectiveness and landlord billing accuracy."
    - name: "total_cam_cap_amount"
      expr: SUM(CAST(cam_cap_amount AS DOUBLE))
      comment: "Total CAM cap amounts — tracks contractual protection against CAM cost escalation."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility condition and cost metrics tracking maintenance spend, compliance status, and asset health across the restaurant portfolio."
  source: "`vibe_restaurants_v1`.`realestate`.`facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (restaurant, drive-thru, kiosk) for format-level analysis."
    - name: "facility_status"
      expr: facility_status
      comment: "Current operational status of the facility — tracks active vs. inactive asset base."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership structure (owned, leased, ground-leased) — drives capital vs. operating cost classification."
    - name: "construction_status"
      expr: construction_status
      comment: "Construction or renovation status — tracks facilities under development or remodel."
    - name: "ada_compliance_status"
      expr: ada_compliance_status
      comment: "ADA compliance status — critical regulatory compliance dimension for risk management."
    - name: "fire_safety_compliance_status"
      expr: fire_safety_compliance_status
      comment: "Fire safety compliance status — tracks life-safety regulatory compliance."
    - name: "energy_rating"
      expr: energy_rating
      comment: "Energy efficiency rating — supports sustainability reporting and utility cost benchmarking."
    - name: "zoning_type"
      expr: zoning_type
      comment: "Zoning classification of the facility — relevant for expansion and use-change planning."
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total number of facilities in the portfolio — baseline asset count KPI."
    - name: "total_capex_spent"
      expr: SUM(CAST(capex_spent AS DOUBLE))
      comment: "Total capital expenditure spent on facilities — tracks capital deployment against budget."
    - name: "total_cam_charges"
      expr: SUM(CAST(cam_charges AS DOUBLE))
      comment: "Total CAM charges across facilities — tracks operating cost exposure."
    - name: "avg_condition_score"
      expr: AVG(CAST(condition_score AS DOUBLE))
      comment: "Average facility condition score — key asset health KPI driving maintenance prioritization."
    - name: "avg_health_inspection_score"
      expr: AVG(CAST(health_inspection_score AS DOUBLE))
      comment: "Average health inspection score — critical food safety and regulatory compliance KPI."
    - name: "total_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Total square footage across portfolio — used for rent-per-sqft and space utilization benchmarking."
    - name: "avg_square_footage"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average facility size in square feet — benchmarks format standards and space efficiency."
    - name: "total_property_tax_rate_exposure"
      expr: SUM(CAST(property_tax_rate AS DOUBLE))
      comment: "Sum of property tax rates — aggregate tax burden indicator across the portfolio."
    - name: "avg_property_tax_rate"
      expr: AVG(CAST(property_tax_rate AS DOUBLE))
      comment: "Average property tax rate — benchmarks tax burden across markets."
    - name: "total_tax_assessment_value"
      expr: SUM(CAST(tax_assessment_value AS DOUBLE))
      comment: "Total assessed value of facilities — tracks portfolio asset value for tax and insurance purposes."
    - name: "avg_lease_rate"
      expr: AVG(CAST(lease_rate AS DOUBLE))
      comment: "Average lease rate per facility — benchmarks occupancy cost efficiency."
    - name: "facilities_due_for_maintenance"
      expr: COUNT(CASE WHEN maintenance_next_due <= CURRENT_DATE() THEN 1 END)
      comment: "Number of facilities with overdue maintenance — operational risk KPI requiring immediate action."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_maintenance_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance work order metrics tracking repair costs, labor efficiency, warranty utilization, and maintenance backlog across the portfolio."
  source: "`vibe_restaurants_v1`.`realestate`.`maintenance_work_order`"
  dimensions:
    - name: "maintenance_work_order_status"
      expr: maintenance_work_order_status
      comment: "Current status of the work order (open, in-progress, completed, cancelled) — tracks maintenance backlog."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the work order (critical, high, medium, low) — drives maintenance resource allocation."
    - name: "issue_category"
      expr: issue_category
      comment: "Category of maintenance issue (HVAC, plumbing, electrical, equipment) — identifies systemic failure patterns."
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Whether the work order is a warranty claim — tracks warranty recovery value."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the work order costs for multi-currency portfolio analysis."
    - name: "scheduled_month"
      expr: DATE_TRUNC('month', scheduled_date)
      comment: "Month the work was scheduled — used for maintenance spend trend analysis."
    - name: "completion_year"
      expr: YEAR(completion_timestamp)
      comment: "Year of work order completion for annual maintenance cost reporting."
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of maintenance work orders — baseline maintenance activity volume."
    - name: "total_maintenance_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total maintenance spend across all work orders — primary facility operating cost KPI."
    - name: "avg_maintenance_cost_per_order"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average cost per work order — benchmarks maintenance efficiency and contractor pricing."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost for maintenance — tracks workforce cost component of facility maintenance."
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Total parts and materials cost — tracks supply chain cost component of maintenance."
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labor hours expended on maintenance — measures maintenance workforce utilization."
    - name: "avg_labor_hours_per_order"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labor hours per work order — benchmarks maintenance task complexity and efficiency."
    - name: "warranty_claim_count"
      expr: COUNT(CASE WHEN warranty_claim_flag = TRUE THEN 1 END)
      comment: "Number of warranty claims filed — tracks warranty recovery and equipment quality issues."
    - name: "warranty_claim_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN warranty_claim_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of work orders covered by warranty — measures warranty utilization effectiveness."
    - name: "warranty_cost_recovery"
      expr: SUM(CASE WHEN warranty_claim_flag = TRUE THEN total_cost ELSE 0 END)
      comment: "Total cost of warranty-covered work orders — quantifies warranty recovery value."
    - name: "labor_cost_ratio"
      expr: ROUND(100.0 * SUM(CAST(labor_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_cost AS DOUBLE)), 0), 2)
      comment: "Labor cost as a percentage of total maintenance cost — benchmarks labor intensity of maintenance operations."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_nro_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "New restaurant opening project metrics tracking development pipeline, capex performance, permitting status, and opening timeline adherence."
  source: "`vibe_restaurants_v1`.`realestate`.`nro_project`"
  dimensions:
    - name: "nro_project_status"
      expr: nro_project_status
      comment: "Current status of the NRO project (planning, permitting, construction, open) — tracks development pipeline stage."
    - name: "project_type"
      expr: project_type
      comment: "Type of project (new build, conversion, relocation) — categorizes development activity."
    - name: "project_phase"
      expr: project_phase
      comment: "Current phase of the project — granular pipeline stage tracking."
    - name: "permitting_status"
      expr: permitting_status
      comment: "Status of permitting approvals — critical path item for opening timeline management."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the project — tracks risk exposure."
    - name: "risk_level"
      expr: risk_level
      comment: "Project risk level (low, medium, high) — drives executive escalation and resource allocation."
    - name: "lease_type"
      expr: lease_type
      comment: "Type of lease for the new location — informs balance sheet treatment under IFRS 16."
    - name: "target_opening_year"
      expr: YEAR(target_opening_date)
      comment: "Target opening year for pipeline planning and development schedule tracking."
  measures:
    - name: "total_nro_projects"
      expr: COUNT(1)
      comment: "Total number of NRO projects in the pipeline — baseline development activity KPI."
    - name: "total_capex_budget"
      expr: SUM(CAST(capex_budget_amount AS DOUBLE))
      comment: "Total budgeted capital for NRO projects — tracks capital commitment in the development pipeline."
    - name: "total_capex_actual"
      expr: SUM(CAST(capex_actual_amount AS DOUBLE))
      comment: "Total actual capital spent on NRO projects — tracks capital deployment against budget."
    - name: "total_capex_committed"
      expr: SUM(CAST(capex_committed_amount AS DOUBLE))
      comment: "Total committed (contracted but not yet spent) capital — tracks capital obligation pipeline."
    - name: "avg_capex_per_project"
      expr: AVG(CAST(capex_budget_amount AS DOUBLE))
      comment: "Average budgeted capex per NRO project — benchmarks development cost standards."
    - name: "capex_variance"
      expr: SUM((CAST(capex_actual_amount AS DOUBLE)) - (CAST(capex_budget_amount AS DOUBLE)))
      comment: "Total capex variance (actual minus budget) — measures development cost discipline; negative is favorable."
    - name: "avg_capex_variance_per_project"
      expr: AVG(CAST(capex_actual_amount AS DOUBLE) - CAST(capex_budget_amount AS DOUBLE))
      comment: "Average capex variance per project — benchmarks project management cost control effectiveness."
    - name: "projects_at_high_risk"
      expr: COUNT(CASE WHEN risk_level = 'high' THEN 1 END)
      comment: "Number of NRO projects at high risk — executive escalation KPI for development pipeline health."
    - name: "high_risk_project_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_level = 'high' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NRO projects at high risk — portfolio-level development risk indicator."
    - name: "projects_with_ifrs16_lease"
      expr: COUNT(CASE WHEN ifr16_lease_asset_flag = TRUE THEN 1 END)
      comment: "Number of NRO projects with IFRS 16 lease assets — tracks balance sheet impact of new openings."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_remodel_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Remodel project metrics tracking renovation cost performance, schedule adherence, and project completion rates across the restaurant portfolio."
  source: "`vibe_restaurants_v1`.`realestate`.`realestate_remodel_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the remodel project (planning, in-progress, completed, on-hold) — tracks renovation pipeline."
    - name: "remodel_type"
      expr: remodel_type
      comment: "Type of remodel (full reimage, refresh, equipment upgrade) — categorizes investment level and scope."
    - name: "realestate_remodel_project_status"
      expr: realestate_remodel_project_status
      comment: "Detailed project status for granular pipeline tracking."
    - name: "closure_required_flag"
      expr: closure_required_flag
      comment: "Whether the remodel requires restaurant closure — tracks revenue impact risk during renovation."
    - name: "is_complete"
      expr: is_complete
      comment: "Whether the project is fully complete — used to filter active vs. completed project pipeline."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of project costs for multi-currency portfolio analysis."
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year the remodel was planned to start — used for vintage cohort analysis of remodel program."
  measures:
    - name: "total_remodel_projects"
      expr: COUNT(1)
      comment: "Total number of remodel projects — baseline renovation program activity KPI."
    - name: "total_budgeted_cost"
      expr: SUM(CAST(budgeted_cost AS DOUBLE))
      comment: "Total budgeted remodel cost — tracks capital commitment in the renovation program."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual remodel cost incurred — tracks capital deployment against renovation budget."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated remodel cost — forward-looking capital requirement for pipeline projects."
    - name: "avg_actual_cost_per_project"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per remodel project — benchmarks renovation cost efficiency."
    - name: "total_cost_variance"
      expr: SUM((CAST(actual_cost AS DOUBLE)) - (CAST(budgeted_cost AS DOUBLE)))
      comment: "Total cost variance (actual minus budget) across remodel projects — measures capital discipline."
    - name: "avg_cost_variance_per_project"
      expr: AVG(CAST(actual_cost AS DOUBLE) - CAST(budgeted_cost AS DOUBLE))
      comment: "Average cost variance per project — benchmarks project management cost control."
    - name: "completed_project_count"
      expr: COUNT(CASE WHEN is_complete = TRUE THEN 1 END)
      comment: "Number of completed remodel projects — tracks renovation program execution velocity."
    - name: "completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_complete = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of remodel projects completed — measures renovation program execution effectiveness."
    - name: "closure_required_project_count"
      expr: COUNT(CASE WHEN closure_required_flag = TRUE THEN 1 END)
      comment: "Number of remodels requiring restaurant closure — quantifies revenue disruption risk in renovation pipeline."
    - name: "closure_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN closure_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of remodels requiring closure — tracks operational disruption risk from renovation program."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_site_selection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site selection pipeline metrics tracking evaluation scores, financial projections, and approval rates for new restaurant development decisions."
  source: "`vibe_restaurants_v1`.`realestate`.`site_selection`"
  dimensions:
    - name: "site_selection_status"
      expr: site_selection_status
      comment: "Current status of the site evaluation (prospecting, under review, approved, rejected) — tracks pipeline stage."
    - name: "evaluation_stage"
      expr: evaluation_stage
      comment: "Detailed evaluation stage for granular pipeline tracking."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the site (low, medium, high) — drives approval authority and investment committee review."
    - name: "lease_type"
      expr: lease_type
      comment: "Anticipated lease type for the site — informs balance sheet treatment and occupancy cost structure."
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Reason code for site rejection — identifies systemic barriers in the development pipeline."
    - name: "decision_year"
      expr: YEAR(decision_date)
      comment: "Year of site decision for pipeline velocity trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of financial projections for multi-currency portfolio analysis."
  measures:
    - name: "total_site_evaluations"
      expr: COUNT(1)
      comment: "Total number of site evaluations in the pipeline — baseline development activity KPI."
    - name: "avg_overall_site_score"
      expr: AVG(CAST(overall_site_score AS DOUBLE))
      comment: "Average overall site score — measures quality of sites entering the development pipeline."
    - name: "avg_projected_annual_sales"
      expr: AVG(CAST(projected_annual_sales AS DOUBLE))
      comment: "Average projected annual sales for evaluated sites — benchmarks revenue potential of development pipeline."
    - name: "total_projected_annual_sales"
      expr: SUM(CAST(projected_annual_sales AS DOUBLE))
      comment: "Total projected annual sales across pipeline sites — forward-looking revenue potential of development program."
    - name: "avg_projected_capex"
      expr: AVG(CAST(projected_capex_amount AS DOUBLE))
      comment: "Average projected capex per site — benchmarks development cost standards for new openings."
    - name: "total_projected_capex"
      expr: SUM(CAST(projected_capex_amount AS DOUBLE))
      comment: "Total projected capex across pipeline sites — tracks capital requirement of development program."
    - name: "avg_projected_roi"
      expr: AVG(CAST(projected_roi_percent AS DOUBLE))
      comment: "Average projected ROI across evaluated sites — key investment quality metric for capital allocation decisions."
    - name: "avg_payback_period_months"
      expr: AVG(CAST(payback_period_months AS DOUBLE))
      comment: "Average payback period in months — measures investment recovery speed for new restaurant development."
    - name: "avg_traffic_score"
      expr: AVG(CAST(traffic_score AS DOUBLE))
      comment: "Average traffic score of evaluated sites — proxy for customer accessibility and revenue potential."
    - name: "avg_demographic_score"
      expr: AVG(CAST(demographic_score AS DOUBLE))
      comment: "Average demographic score — measures alignment of site population with target customer profile."
    - name: "avg_competition_score"
      expr: AVG(CAST(competition_score AS DOUBLE))
      comment: "Average competition score — measures competitive intensity at evaluated sites."
    - name: "avg_cannibalization_risk_score"
      expr: AVG(CAST(cannibalization_risk_score AS DOUBLE))
      comment: "Average cannibalization risk score — tracks risk of new sites cannibalizing existing unit sales."
    - name: "avg_market_share_estimate"
      expr: AVG(CAST(market_share_estimate_percent AS DOUBLE))
      comment: "Average estimated market share for pipeline sites — measures competitive positioning of development targets."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_property_acquisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property acquisition metrics tracking investment costs, financing structures, and acquisition pipeline performance for owned real estate."
  source: "`vibe_restaurants_v1`.`realestate`.`property_acquisition`"
  dimensions:
    - name: "property_acquisition_status"
      expr: property_acquisition_status
      comment: "Current status of the acquisition (prospecting, due diligence, closed, cancelled) — tracks acquisition pipeline."
    - name: "property_type"
      expr: property_type
      comment: "Type of property being acquired (land, building, ground lease) — categorizes investment type."
    - name: "financing_structure"
      expr: financing_structure
      comment: "Financing structure (cash, mortgage, sale-leaseback) — tracks capital structure of acquisitions."
    - name: "environmental_assessment_status"
      expr: environmental_assessment_status
      comment: "Environmental assessment status — tracks regulatory risk in acquisition due diligence."
    - name: "lease_obligation_flag"
      expr: lease_obligation_flag
      comment: "Whether the acquisition carries a lease obligation — identifies IFRS 16 balance sheet impact."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of acquisition costs for multi-currency portfolio analysis."
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year of acquisition for vintage cohort analysis of owned property portfolio."
  measures:
    - name: "total_acquisitions"
      expr: COUNT(1)
      comment: "Total number of property acquisitions — baseline acquisition activity KPI."
    - name: "total_acquisition_price"
      expr: SUM(CAST(acquisition_price AS DOUBLE))
      comment: "Total acquisition price paid — primary capital deployment KPI for owned real estate strategy."
    - name: "total_closing_costs"
      expr: SUM(CAST(closing_costs AS DOUBLE))
      comment: "Total closing costs incurred — tracks transaction cost efficiency of acquisition program."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(total_acquisition_cost AS DOUBLE))
      comment: "Total all-in acquisition cost (price plus closing costs) — comprehensive capital investment KPI."
    - name: "avg_acquisition_price"
      expr: AVG(CAST(acquisition_price AS DOUBLE))
      comment: "Average acquisition price per property — benchmarks market pricing and negotiation outcomes."
    - name: "avg_capitalization_rate"
      expr: AVG(CAST(capitalization_rate AS DOUBLE))
      comment: "Average capitalization rate on acquisitions — key investment return metric for real estate capital allocation."
    - name: "total_loan_amount"
      expr: SUM(CAST(loan_amount AS DOUBLE))
      comment: "Total debt financing used for acquisitions — tracks leverage in the owned real estate portfolio."
    - name: "avg_loan_to_cost_ratio"
      expr: ROUND(100.0 * SUM(CAST(loan_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Average loan-to-cost ratio across acquisitions — measures leverage and financial risk in acquisition program."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_trade_area`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade area demographic and competitive metrics supporting site selection, market planning, and portfolio geographic analysis."
  source: "`vibe_restaurants_v1`.`realestate`.`trade_area`"
  dimensions:
    - name: "trade_area_type"
      expr: trade_area_type
      comment: "Type of trade area (primary, secondary, tertiary) — defines competitive catchment zone."
    - name: "trade_area_status"
      expr: trade_area_status
      comment: "Current status of the trade area analysis — tracks data currency and validity."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the trade area — enables regional market analysis."
    - name: "state"
      expr: state
      comment: "State of the trade area for state-level market analysis."
    - name: "methodology"
      expr: methodology
      comment: "Methodology used to define the trade area (drive-time, radius, custom) — ensures analytical consistency."
    - name: "data_vintage_year"
      expr: YEAR(data_vintage_date)
      comment: "Year of demographic data vintage — tracks data currency for site selection decisions."
  measures:
    - name: "total_trade_areas"
      expr: COUNT(1)
      comment: "Total number of trade areas analyzed — baseline market coverage KPI."
    - name: "avg_median_household_income"
      expr: AVG(CAST(median_household_income AS DOUBLE))
      comment: "Average median household income across trade areas — key demographic quality indicator for site selection."
    - name: "avg_population_density"
      expr: AVG(CAST(population_density_per_sq_mile AS DOUBLE))
      comment: "Average population density across trade areas — measures customer base concentration."
    - name: "avg_projected_auv"
      expr: AVG(CAST(projected_auv AS DOUBLE))
      comment: "Average projected AUV across trade areas — forward-looking revenue potential of market coverage."
    - name: "total_projected_auv"
      expr: SUM(CAST(projected_auv AS DOUBLE))
      comment: "Total projected AUV across all trade areas — aggregate revenue potential of market portfolio."
    - name: "avg_market_share_score"
      expr: AVG(CAST(market_share_score AS DOUBLE))
      comment: "Average market share score — measures competitive positioning across trade areas."
    - name: "avg_cannibalization_risk_score"
      expr: AVG(CAST(cannibalization_risk_score AS DOUBLE))
      comment: "Average cannibalization risk score — tracks inter-unit competition risk across the portfolio."
    - name: "avg_employment_rate"
      expr: AVG(CAST(employment_rate_percent AS DOUBLE))
      comment: "Average employment rate across trade areas — proxy for consumer spending power and restaurant demand."
    - name: "avg_primary_drive_time"
      expr: AVG(CAST(primary_boundary_drive_time_minutes AS DOUBLE))
      comment: "Average primary trade area drive time — measures customer convenience and accessibility of portfolio locations."
    - name: "avg_area_sq_miles"
      expr: AVG(CAST(area_sq_miles AS DOUBLE))
      comment: "Average trade area size in square miles — benchmarks market coverage per location."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`realestate_capex_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure budget metrics tracking investment allocation, budget utilization, and cost category breakdown for real estate projects."
  source: "`vibe_restaurants_v1`.`realestate`.`capex_budget`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the capex budget for multi-currency portfolio analysis."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of capital funding (corporate, franchisee, debt) — tracks capital structure of real estate investment."
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year of budget approval for annual capital planning analysis."
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the capex project starts for capital deployment timeline analysis."
  measures:
    - name: "total_capex_budgets"
      expr: COUNT(1)
      comment: "Total number of capex budgets — baseline capital program activity KPI."
    - name: "total_budget_amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total approved capex budget — primary capital allocation KPI for real estate investment program."
    - name: "total_building_shell_cost"
      expr: SUM(CAST(building_shell_cost AS DOUBLE))
      comment: "Total budgeted building shell cost — tracks structural construction investment."
    - name: "total_leasehold_improvements"
      expr: SUM(CAST(leasehold_improvements_cost AS DOUBLE))
      comment: "Total budgeted leasehold improvement cost — tracks tenant improvement investment."
    - name: "total_ffe_cost"
      expr: SUM(CAST(ffe_cost AS DOUBLE))
      comment: "Total budgeted furniture, fixtures, and equipment cost — tracks FF&E investment component."
    - name: "total_technology_cost"
      expr: SUM(CAST(technology_cost AS DOUBLE))
      comment: "Total budgeted technology cost — tracks digital and POS infrastructure investment."
    - name: "total_signage_cost"
      expr: SUM(CAST(signage_cost AS DOUBLE))
      comment: "Total budgeted signage cost — tracks brand identity investment in new locations."
    - name: "total_soft_costs"
      expr: SUM(CAST(soft_costs AS DOUBLE))
      comment: "Total budgeted soft costs (architecture, permits, legal) — tracks non-construction investment overhead."
    - name: "total_land_cost"
      expr: SUM(CAST(land_cost AS DOUBLE))
      comment: "Total budgeted land cost — tracks land acquisition investment in owned-site strategy."
    - name: "total_budget_revision_amount"
      expr: SUM(CAST(budget_revision_amount AS DOUBLE))
      comment: "Total budget revision amounts — measures scope change and cost escalation in capital program."
    - name: "avg_budget_per_project"
      expr: AVG(CAST(total_budget_amount AS DOUBLE))
      comment: "Average capex budget per project — benchmarks investment standards for new development and remodels."
$$;