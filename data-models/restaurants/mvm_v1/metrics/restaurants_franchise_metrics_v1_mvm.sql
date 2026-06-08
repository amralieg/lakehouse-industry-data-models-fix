-- Metric views for domain: franchise | Business: Restaurants | Version: 1 | Generated on: 2026-05-06 03:57:03

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`franchise_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over franchise agreements — royalty economics, fee structures, compliance posture, and portfolio health for executive oversight of the franchise contract lifecycle."
  source: "`restaurants_ecm`.`franchise`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current lifecycle status of the franchise agreement (e.g., Active, Expired, Terminated) — primary filter for portfolio health analysis."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Classification of the agreement (e.g., Single-Unit, Multi-Unit, Area Development) — drives royalty and fee tier analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory and brand-standard compliance standing of the agreement — used to identify at-risk franchisees."
    - name: "brand_id"
      expr: brand_id
      comment: "Foreign key to the brand — enables brand-level segmentation of agreement economics."
    - name: "territory_id"
      expr: territory_id
      comment: "Foreign key to the territory — supports geographic analysis of agreement distribution and performance."
    - name: "franchisee_id"
      expr: franchisee_id
      comment: "Foreign key to the franchisee — enables franchisee-level portfolio and economics analysis."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the agreement became effective — used for cohort and vintage analysis of franchise agreements."
    - name: "effective_end_year"
      expr: YEAR(effective_end_date)
      comment: "Year the agreement is scheduled to expire — used for renewal pipeline forecasting."
    - name: "ftc_compliance_attestation_flag"
      expr: ftc_compliance_attestation_flag
      comment: "Indicates whether the FTC disclosure compliance attestation has been completed — critical for regulatory risk monitoring."
    - name: "transfer_rights_flag"
      expr: transfer_rights_flag
      comment: "Indicates whether the agreement grants transfer rights to the franchisee — affects M&A and succession planning."
  measures:
    - name: "total_active_agreements"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN agreement_id END)
      comment: "Count of currently active franchise agreements — baseline measure of the active franchise portfolio size."
    - name: "avg_royalty_rate_pct"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate percentage across agreements — key lever for franchise revenue yield management."
    - name: "avg_marketing_fee_pct"
      expr: AVG(CAST(marketing_fee_percent AS DOUBLE))
      comment: "Average marketing fee percentage across agreements — informs brand fund contribution analysis."
    - name: "total_initial_fee_revenue"
      expr: SUM(CAST(initial_fee_amount AS DOUBLE))
      comment: "Total initial franchise fees across all agreements — measures new franchise revenue from agreement signings."
    - name: "total_renewal_fee_revenue"
      expr: SUM(CAST(renewal_fee_amount AS DOUBLE))
      comment: "Total renewal fees across all agreements — measures revenue from franchise agreement renewals."
    - name: "avg_average_unit_volume"
      expr: AVG(CAST(average_unit_volume AS DOUBLE))
      comment: "Average unit volume (AUV) across agreements — a primary indicator of franchisee economic health and brand performance."
    - name: "total_sales_target_amount"
      expr: SUM(CAST(sales_target_amount AS DOUBLE))
      comment: "Sum of contractual sales targets across all agreements — used to measure portfolio-level sales commitment vs. actuals."
    - name: "agreements_expiring_within_1_year"
      expr: COUNT(CASE WHEN effective_end_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 365) THEN agreement_id END)
      comment: "Number of agreements expiring within the next 12 months — critical for renewal pipeline management and revenue risk assessment."
    - name: "non_compliant_agreement_count"
      expr: COUNT(CASE WHEN compliance_status != 'Compliant' THEN agreement_id END)
      comment: "Count of agreements not in compliant status — drives compliance intervention prioritization and legal risk management."
    - name: "ftc_attestation_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ftc_compliance_attestation_flag = TRUE THEN agreement_id END) / NULLIF(COUNT(agreement_id), 0), 2)
      comment: "Percentage of agreements with completed FTC compliance attestation — regulatory risk KPI; low rates signal legal exposure."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`franchise_franchisee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchisee portfolio health and economic KPIs — tracks franchisee financial standing, compliance, unit economics, and portfolio composition for strategic franchise development decisions."
  source: "`restaurants_ecm`.`franchise`.`franchisee`"
  dimensions:
    - name: "franchisee_status"
      expr: franchisee_status
      comment: "Current operational status of the franchisee (e.g., Active, Probation, Terminated) — primary dimension for portfolio health segmentation."
    - name: "franchisee_type"
      expr: franchisee_type
      comment: "Classification of the franchisee (e.g., Single-Unit, Multi-Unit, Area Developer) — drives differentiated management strategies."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance standing of the franchisee — used to identify at-risk operators requiring intervention."
    - name: "industry_segment"
      expr: industry_segment
      comment: "Industry segment the franchisee operates in — supports segment-level performance benchmarking."
    - name: "country_code"
      expr: country_code
      comment: "Country of franchisee operations — enables geographic portfolio analysis."
    - name: "state_province"
      expr: state_province
      comment: "State or province of franchisee operations — supports regional performance analysis."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating of the franchisee — key financial health indicator for risk management and financing decisions."
    - name: "food_safety_certified"
      expr: food_safety_certified
      comment: "Indicates whether the franchisee holds current food safety certification — regulatory compliance dimension."
    - name: "fdd_disclosure_status"
      expr: fdd_disclosure_status
      comment: "Status of the Franchise Disclosure Document (FDD) disclosure — legal compliance dimension."
    - name: "ifa_membership_status"
      expr: ifa_membership_status
      comment: "International Franchise Association membership status — industry engagement and governance dimension."
    - name: "established_year"
      expr: YEAR(established_date)
      comment: "Year the franchisee was established — used for franchisee tenure and cohort analysis."
  measures:
    - name: "total_active_franchisees"
      expr: COUNT(CASE WHEN franchisee_status = 'Active' THEN franchisee_id END)
      comment: "Count of active franchisees — baseline measure of the active franchise network size."
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue AS DOUBLE))
      comment: "Total annual revenue across all franchisees — measures the aggregate economic scale of the franchise network."
    - name: "avg_annual_revenue_per_franchisee"
      expr: AVG(CAST(annual_revenue AS DOUBLE))
      comment: "Average annual revenue per franchisee — benchmarks franchisee economic productivity."
    - name: "avg_average_unit_volume"
      expr: AVG(CAST(average_unit_volume AS DOUBLE))
      comment: "Average unit volume (AUV) across franchisees — primary indicator of unit-level sales performance."
    - name: "total_franchise_fee_revenue"
      expr: SUM(CAST(franchise_fee_amount AS DOUBLE))
      comment: "Total franchise fees collected across all franchisees — measures franchise fee revenue stream."
    - name: "total_royalty_fee_revenue"
      expr: SUM(CAST(royalty_fee_amount AS DOUBLE))
      comment: "Total royalty fees collected across all franchisees — the primary recurring revenue stream from the franchise network."
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate AS DOUBLE))
      comment: "Average royalty rate across franchisees — used to benchmark and optimize royalty yield across the portfolio."
    - name: "non_compliant_franchisee_count"
      expr: COUNT(CASE WHEN compliance_status != 'Compliant' THEN franchisee_id END)
      comment: "Count of franchisees not in compliant status — drives compliance intervention and risk management."
    - name: "food_safety_certified_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN food_safety_certified = TRUE THEN franchisee_id END) / NULLIF(COUNT(franchisee_id), 0), 2)
      comment: "Percentage of franchisees with current food safety certification — regulatory compliance KPI; low rates signal operational and legal risk."
    - name: "insurance_expiry_within_90_days"
      expr: COUNT(CASE WHEN insurance_expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN franchisee_id END)
      comment: "Count of franchisees with insurance expiring within 90 days — operational risk KPI requiring proactive renewal management."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`franchise_sales_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise sales performance KPIs — tracks gross and net sales, royalty yield, same-store sales trends, and transaction economics to steer revenue management and franchisee accountability."
  source: "`restaurants_ecm`.`franchise`.`sales_report`"
  dimensions:
    - name: "franchisee_id"
      expr: franchisee_id
      comment: "Foreign key to the franchisee — enables franchisee-level sales performance analysis."
    - name: "agreement_id"
      expr: agreement_id
      comment: "Foreign key to the franchise agreement — links sales performance to contractual obligations."
    - name: "sales_report_status"
      expr: sales_report_status
      comment: "Current status of the sales report (e.g., Submitted, Validated, Rejected) — used to filter for reliable, validated data."
    - name: "reporting_period_type"
      expr: reporting_period_type
      comment: "Type of reporting period (e.g., Weekly, Monthly, Quarterly) — enables period-appropriate aggregation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the reported sales — required for multi-currency portfolio analysis."
    - name: "validation_status"
      expr: validation_status
      comment: "Data validation status of the sales report — used to exclude unvalidated or disputed reports from KPI calculations."
    - name: "variance_flag"
      expr: variance_flag
      comment: "Indicates whether a material variance was detected in the sales report — flags reports requiring audit or investigation."
    - name: "reporting_period_start_month"
      expr: DATE_TRUNC('MONTH', reporting_period_start)
      comment: "Month bucket of the reporting period start — enables monthly trend analysis of franchise sales."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the sales report (e.g., Portal, EDI, Manual) — used to monitor reporting compliance and automation adoption."
  measures:
    - name: "total_gross_sales"
      expr: SUM(CAST(gross_sales_amount AS DOUBLE))
      comment: "Total gross sales across all franchise sales reports — top-line revenue measure for the franchise network."
    - name: "total_net_sales"
      expr: SUM(CAST(net_sales_amount AS DOUBLE))
      comment: "Total net sales after adjustments — the primary revenue base for royalty and fee calculations."
    - name: "total_royalty_collected"
      expr: SUM(CAST(royalty_amount AS DOUBLE))
      comment: "Total royalty fees collected across all sales reports — primary recurring revenue stream from the franchise network."
    - name: "total_franchise_fee_collected"
      expr: SUM(CAST(franchise_fee AS DOUBLE))
      comment: "Total franchise fees collected across all sales reports — measures fee revenue alongside royalties."
    - name: "avg_check_value"
      expr: AVG(CAST(average_check_value AS DOUBLE))
      comment: "Average transaction check value across all reports — key unit economics indicator for pricing and upsell strategy."
    - name: "total_transaction_count"
      expr: SUM(CAST(transaction_count AS BIGINT))
      comment: "Total customer transactions across all franchise sales reports — measures traffic volume and operational throughput."
    - name: "total_same_store_sales"
      expr: SUM(CAST(same_store_sales AS DOUBLE))
      comment: "Total same-store sales across comparable reporting units — the gold-standard organic growth metric for franchise networks."
    - name: "total_sales_variance"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between reported and expected sales — measures reporting accuracy and potential revenue leakage."
    - name: "royalty_yield_rate"
      expr: ROUND(100.0 * SUM(CAST(royalty_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_sales_amount AS DOUBLE)), 0), 4)
      comment: "Effective royalty rate as a percentage of net sales — measures actual royalty yield vs. contracted rates; deviations signal under-reporting or fee disputes."
    - name: "variance_flagged_report_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN variance_flag = TRUE THEN sales_report_id END) / NULLIF(COUNT(sales_report_id), 0), 2)
      comment: "Percentage of sales reports flagged for variance — measures reporting quality and potential revenue leakage risk across the franchise network."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`franchise_compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise compliance and brand standards audit KPIs — tracks audit scores, violation rates, and corrective action requirements to manage brand quality, food safety, and regulatory risk."
  source: "`restaurants_ecm`.`franchise`.`compliance_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of compliance audit conducted (e.g., Brand Standards, Food Safety, Operations) — enables audit-type-specific performance analysis."
    - name: "audit_disposition"
      expr: audit_disposition
      comment: "Outcome disposition of the audit (e.g., Pass, Fail, Conditional Pass) — primary dimension for compliance performance segmentation."
    - name: "compliance_audit_status"
      expr: compliance_audit_status
      comment: "Current status of the audit record (e.g., Open, Closed, In Review) — used to filter for completed audits in KPI calculations."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Indicates whether a corrective action plan was required — key risk flag for brand standards enforcement."
    - name: "unit_id"
      expr: unit_id
      comment: "Foreign key to the restaurant unit — enables unit-level compliance performance analysis."
    - name: "agreement_id"
      expr: agreement_id
      comment: "Foreign key to the franchise agreement — links audit results to contractual compliance obligations."
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', CAST(audit_timestamp AS DATE))
      comment: "Month of the audit — enables trend analysis of compliance performance over time."
    - name: "audit_source_system"
      expr: audit_source_system
      comment: "Source system that generated the audit record — used for data lineage and audit program tracking."
  measures:
    - name: "avg_overall_audit_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall compliance audit score — primary KPI for brand standards and operational quality across the franchise network."
    - name: "avg_food_safety_score"
      expr: AVG(CAST(food_safety_score AS DOUBLE))
      comment: "Average food safety audit score — critical public health and regulatory compliance KPI."
    - name: "avg_brand_standards_score"
      expr: AVG(CAST(brand_standards_score AS DOUBLE))
      comment: "Average brand standards audit score — measures franchisee adherence to brand identity and operational standards."
    - name: "avg_cleanliness_score"
      expr: AVG(CAST(cleanliness_score AS DOUBLE))
      comment: "Average cleanliness audit score — directly linked to customer experience and health inspection outcomes."
    - name: "avg_service_score"
      expr: AVG(CAST(service_score AS DOUBLE))
      comment: "Average service quality audit score — measures franchisee delivery of brand service standards."
    - name: "avg_equipment_score"
      expr: AVG(CAST(equipment_score AS DOUBLE))
      comment: "Average equipment condition audit score — informs capital reinvestment and maintenance compliance decisions."
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN compliance_audit_id END) / NULLIF(COUNT(compliance_audit_id), 0), 2)
      comment: "Percentage of audits requiring corrective action — measures the prevalence of non-compliance; high rates signal systemic brand standards failures."
    - name: "total_audits_conducted"
      expr: COUNT(compliance_audit_id)
      comment: "Total number of compliance audits conducted — measures audit program coverage and activity."
    - name: "units_with_corrective_action"
      expr: COUNT(DISTINCT CASE WHEN corrective_action_required = TRUE THEN unit_id END)
      comment: "Count of distinct restaurant units with at least one corrective action required — identifies the breadth of non-compliance across the network."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`franchise_performance_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchisee performance scorecard KPIs — aggregates multi-dimensional performance metrics including sales growth, royalty timeliness, customer satisfaction, and training compliance for executive franchise portfolio reviews."
  source: "`restaurants_ecm`.`franchise`.`performance_scorecard`"
  dimensions:
    - name: "franchisee_id"
      expr: franchisee_id
      comment: "Foreign key to the franchisee — primary dimension for franchisee-level performance benchmarking."
    - name: "brand_id"
      expr: brand_id
      comment: "Foreign key to the brand — enables brand-level performance comparison across the franchise portfolio."
    - name: "overall_performance_tier"
      expr: overall_performance_tier
      comment: "Performance tier classification of the franchisee (e.g., Platinum, Gold, Silver, Probation) — primary executive segmentation for franchise management."
    - name: "evaluation_type"
      expr: evaluation_type
      comment: "Type of performance evaluation (e.g., Annual, Semi-Annual, Quarterly) — used to filter for comparable evaluation periods."
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Status of the evaluation record (e.g., Final, Draft, In Review) — used to filter for finalized scorecards."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region code — enables regional performance benchmarking and resource allocation decisions."
    - name: "evaluation_year"
      expr: evaluation_year
      comment: "Year of the performance evaluation — used for year-over-year performance trend analysis."
    - name: "evaluation_period_start_month"
      expr: DATE_TRUNC('MONTH', evaluation_period_start)
      comment: "Month bucket of the evaluation period start — enables period-level performance trend analysis."
  measures:
    - name: "avg_same_store_sales_growth_pct"
      expr: AVG(CAST(same_store_sales_growth_pct AS DOUBLE))
      comment: "Average same-store sales growth percentage across franchisees — the primary organic growth KPI for the franchise network."
    - name: "avg_royalty_payment_timeliness_pct"
      expr: AVG(CAST(royalty_payment_timeliness_pct AS DOUBLE))
      comment: "Average royalty payment timeliness percentage — measures franchisee financial discipline; low rates signal cash flow issues or disputes."
    - name: "avg_customer_satisfaction_score"
      expr: AVG(CAST(customer_satisfaction_score AS DOUBLE))
      comment: "Average customer satisfaction score across franchisees — directly linked to brand equity and repeat visit rates."
    - name: "avg_food_safety_score"
      expr: AVG(CAST(food_safety_score AS DOUBLE))
      comment: "Average food safety score from performance scorecards — regulatory and brand risk KPI."
    - name: "avg_compliance_audit_score"
      expr: AVG(CAST(compliance_audit_average_score AS DOUBLE))
      comment: "Average compliance audit score from performance scorecards — measures brand standards adherence across the franchise portfolio."
    - name: "avg_training_completion_rate_pct"
      expr: AVG(CAST(training_completion_rate_pct AS DOUBLE))
      comment: "Average training completion rate percentage — measures workforce readiness and franchisee investment in operational excellence."
    - name: "total_royalty_revenue"
      expr: SUM(CAST(total_royalty_amount AS DOUBLE))
      comment: "Total royalty revenue across all performance scorecard records — measures the aggregate royalty yield from the franchise network."
    - name: "total_network_sales"
      expr: SUM(CAST(total_sales_amount AS DOUBLE))
      comment: "Total system-wide sales across all franchisees in the scorecard — measures the aggregate economic scale of the franchise network."
    - name: "avg_average_unit_volume"
      expr: AVG(CAST(average_unit_volume AS DOUBLE))
      comment: "Average unit volume (AUV) from performance scorecards — benchmarks unit-level sales productivity across the franchise portfolio."
    - name: "probation_franchisee_count"
      expr: COUNT(DISTINCT CASE WHEN overall_performance_tier = 'Probation' THEN franchisee_id END)
      comment: "Count of distinct franchisees in the Probation performance tier — measures the scale of underperformance requiring executive intervention."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`franchise_nro_pipeline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "New Restaurant Opening (NRO) pipeline KPIs — tracks development progress, capital investment, budget adherence, and opening velocity to steer franchise growth strategy and capital allocation."
  source: "`restaurants_ecm`.`franchise`.`nro_pipeline`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the NRO project (e.g., In Development, Under Construction, Opened, Cancelled) — primary dimension for pipeline stage analysis."
    - name: "stage"
      expr: stage
      comment: "Current development stage of the NRO project — enables stage-gate pipeline analysis and bottleneck identification."
    - name: "development_type"
      expr: development_type
      comment: "Type of development (e.g., New Build, Conversion, Relocation) — drives capital investment benchmarking."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk classification of the NRO project — used to prioritize executive attention and mitigation resources."
    - name: "brand"
      expr: brand
      comment: "Brand associated with the NRO project — enables brand-level pipeline and investment analysis."
    - name: "franchisee_id"
      expr: franchisee_id
      comment: "Foreign key to the franchisee — enables franchisee-level development pipeline analysis."
    - name: "territory_id"
      expr: territory_id
      comment: "Foreign key to the territory — supports geographic analysis of new restaurant development activity."
    - name: "construction_complete_flag"
      expr: construction_complete_flag
      comment: "Indicates whether construction has been completed — milestone flag for pipeline progression tracking."
    - name: "permits_obtained_flag"
      expr: permits_obtained_flag
      comment: "Indicates whether all required permits have been obtained — critical milestone for construction readiness."
    - name: "training_complete_flag"
      expr: training_complete_flag
      comment: "Indicates whether pre-opening training has been completed — operational readiness milestone."
    - name: "target_open_year"
      expr: YEAR(target_open_date)
      comment: "Year of the targeted opening date — used for annual opening velocity forecasting."
  measures:
    - name: "total_projects_in_pipeline"
      expr: COUNT(nro_pipeline_id)
      comment: "Total number of NRO projects in the pipeline — measures the scale of the franchise development program."
    - name: "total_budget_capex"
      expr: SUM(CAST(budget_capex AS DOUBLE))
      comment: "Total budgeted capital expenditure across all NRO projects — measures the total capital commitment of the development pipeline."
    - name: "total_actual_capex_spent"
      expr: SUM(CAST(actual_capex_spent AS DOUBLE))
      comment: "Total actual capital expenditure spent across all NRO projects — measures capital deployment against budget."
    - name: "total_capex_variance"
      expr: SUM(CAST(actual_capex_spent AS DOUBLE) - CAST(budget_capex AS DOUBLE))
      comment: "Total capital expenditure variance (actual minus budget) across all NRO projects — measures budget adherence; positive values indicate cost overruns."
    - name: "avg_expected_roi"
      expr: AVG(CAST(expected_roi AS DOUBLE))
      comment: "Average expected return on investment across NRO projects — primary capital allocation KPI for franchise development decisions."
    - name: "avg_capital_investment_estimate"
      expr: AVG(CAST(capital_investment_estimate AS DOUBLE))
      comment: "Average capital investment estimate per NRO project — benchmarks investment requirements for new restaurant development."
    - name: "avg_expected_acuv"
      expr: AVG(CAST(expected_acuv AS DOUBLE))
      comment: "Average expected annualized unit volume (ACUV) for NRO projects — measures projected sales productivity of new openings."
    - name: "projects_opened_count"
      expr: COUNT(CASE WHEN actual_open_date IS NOT NULL THEN nro_pipeline_id END)
      comment: "Count of NRO projects that have successfully opened — measures actual opening velocity against development targets."
    - name: "high_risk_project_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN nro_pipeline_id END)
      comment: "Count of NRO projects classified as high risk — measures the risk concentration in the development pipeline requiring executive attention."
    - name: "capex_budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_capex_spent AS DOUBLE)) / NULLIF(SUM(CAST(budget_capex AS DOUBLE)), 0), 2)
      comment: "Percentage of budgeted capital expenditure actually spent — measures capital deployment efficiency; significant deviations signal project delays or cost overruns."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`franchise_training_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise training program KPIs — tracks enrollment completion rates, training hours, pass/fail outcomes, and compliance to ensure franchisee workforce readiness and regulatory certification adherence."
  source: "`restaurants_ecm`.`franchise`.`training_enrollment`"
  dimensions:
    - name: "training_type"
      expr: training_type
      comment: "Type of training program (e.g., Initial, Refresher, Food Safety, Operations) — enables training-type-specific completion and quality analysis."
    - name: "training_enrollment_status"
      expr: training_enrollment_status
      comment: "Current status of the training enrollment (e.g., Enrolled, In Progress, Completed, Withdrawn) — primary dimension for completion pipeline analysis."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass or fail outcome of the training enrollment — measures training effectiveness and franchisee workforce quality."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether the enrollment satisfies a compliance requirement — used to track regulatory and contractual training obligations."
    - name: "franchisee_id"
      expr: franchisee_id
      comment: "Foreign key to the franchisee — enables franchisee-level training completion analysis."
    - name: "unit_id"
      expr: unit_id
      comment: "Foreign key to the restaurant unit — enables unit-level training readiness analysis."
    - name: "enrollment_year"
      expr: YEAR(CAST(enrollment_date AS DATE))
      comment: "Year of training enrollment — used for annual training program volume and trend analysis."
    - name: "scheduled_completion_month"
      expr: DATE_TRUNC('MONTH', scheduled_completion_date)
      comment: "Month of scheduled training completion — used for training pipeline and capacity planning."
  measures:
    - name: "training_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN training_enrollment_status = 'Completed' THEN training_enrollment_id END) / NULLIF(COUNT(training_enrollment_id), 0), 2)
      comment: "Percentage of training enrollments that have been completed — primary KPI for franchise workforce readiness and training program effectiveness."
    - name: "training_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_status = 'Pass' THEN training_enrollment_id END) / NULLIF(COUNT(CASE WHEN pass_fail_status IN ('Pass', 'Fail') THEN training_enrollment_id END), 0), 2)
      comment: "Percentage of assessed training enrollments that resulted in a pass — measures training quality and franchisee workforce competency."
    - name: "avg_training_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average training assessment score across all enrollments — measures the quality of franchisee training outcomes."
    - name: "total_hours_completed"
      expr: SUM(CAST(hours_completed AS DOUBLE))
      comment: "Total training hours completed across all enrollments — measures the aggregate investment in franchisee workforce development."
    - name: "total_hours_required"
      expr: SUM(CAST(hours_required AS DOUBLE))
      comment: "Total training hours required across all enrollments — measures the total training obligation of the franchise network."
    - name: "training_hours_completion_rate"
      expr: ROUND(100.0 * SUM(CAST(hours_completed AS DOUBLE)) / NULLIF(SUM(CAST(hours_required AS DOUBLE)), 0), 2)
      comment: "Percentage of required training hours that have been completed — measures training program progress against mandatory hour requirements."
    - name: "compliance_training_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE AND training_enrollment_status = 'Completed' THEN training_enrollment_id END) / NULLIF(COUNT(CASE WHEN compliance_flag = TRUE THEN training_enrollment_id END), 0), 2)
      comment: "Percentage of compliance-required training enrollments that have been completed — regulatory risk KPI; low rates signal contractual and legal exposure."
    - name: "overdue_training_count"
      expr: COUNT(CASE WHEN scheduled_completion_date < CURRENT_DATE AND training_enrollment_status != 'Completed' THEN training_enrollment_id END)
      comment: "Count of training enrollments past their scheduled completion date and not yet completed — operational risk KPI for training compliance management."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`franchise_territory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise territory portfolio KPIs — tracks territory assignment, market penetration, unit economics, and geographic coverage to inform territory development and franchise expansion strategy."
  source: "`restaurants_ecm`.`franchise`.`territory`"
  dimensions:
    - name: "territory_status"
      expr: territory_status
      comment: "Current status of the territory (e.g., Active, Available, Reserved, Expired) — primary dimension for territory portfolio management."
    - name: "territory_type"
      expr: territory_type
      comment: "Classification of the territory (e.g., Exclusive, Protected, Open) — drives franchise development and rights management strategy."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Assignment status of the territory (e.g., Assigned, Unassigned, Pending) — used to identify available territories for franchise development."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance standing of the territory — used to identify territories with regulatory or brand standards issues."
    - name: "trade_area_classification"
      expr: trade_area_classification
      comment: "Trade area classification (e.g., Urban, Suburban, Rural) — enables market-type performance benchmarking."
    - name: "region"
      expr: region
      comment: "Geographic region of the territory — enables regional portfolio analysis and resource allocation."
    - name: "country_code"
      expr: country_code
      comment: "Country code of the territory — enables international portfolio analysis."
    - name: "brand_id"
      expr: brand_id
      comment: "Foreign key to the brand — enables brand-level territory portfolio analysis."
    - name: "dma"
      expr: dma
      comment: "Designated Market Area (DMA) of the territory — used for media market and competitive density analysis."
  measures:
    - name: "total_active_territories"
      expr: COUNT(CASE WHEN territory_status = 'Active' THEN territory_id END)
      comment: "Count of active franchise territories — measures the geographic footprint of the franchise network."
    - name: "unassigned_territory_count"
      expr: COUNT(CASE WHEN assignment_status = 'Unassigned' THEN territory_id END)
      comment: "Count of unassigned territories — measures the available franchise development opportunity pipeline."
    - name: "avg_territory_average_unit_volume"
      expr: AVG(CAST(average_unit_volume AS DOUBLE))
      comment: "Average unit volume (AUV) across territories — benchmarks territory-level sales productivity for development prioritization."
    - name: "avg_median_income"
      expr: AVG(CAST(median_income AS DOUBLE))
      comment: "Average median household income across territories — measures the demographic quality of the franchise territory portfolio."
    - name: "total_territory_area_sq_miles"
      expr: SUM(CAST(area_sq_miles AS DOUBLE))
      comment: "Total geographic area covered by franchise territories in square miles — measures the physical scale of the franchise network's market coverage."
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate AS DOUBLE))
      comment: "Average royalty rate across territories — used to benchmark territory-level royalty economics and identify rate optimization opportunities."
    - name: "total_franchise_fee_revenue"
      expr: SUM(CAST(franchise_fee AS DOUBLE))
      comment: "Total franchise fees associated with territories — measures territory-level fee revenue contribution."
    - name: "non_compliant_territory_count"
      expr: COUNT(CASE WHEN compliance_status != 'Compliant' THEN territory_id END)
      comment: "Count of territories not in compliant status — identifies geographic areas with brand standards or regulatory issues requiring intervention."
$$;