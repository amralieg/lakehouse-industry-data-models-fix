-- Metric views for domain: franchise | Business: Restaurants | Version: 2 | Generated on: 2026-06-22 15:12:58

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_royalty_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks royalty revenue, gross sales, and royalty yield across franchisees and reporting periods — core financial KPI for franchise operations leadership."
  source: "`vibe_restaurants_v1`.`franchise`.`sales_report`"
  dimensions:
    - name: "reporting_period_type"
      expr: reporting_period_type
      comment: "Granularity of the sales report (weekly, monthly, quarterly) for trend analysis."
    - name: "reporting_period_start"
      expr: DATE_TRUNC('month', reporting_period_start)
      comment: "Month bucket of the reporting period start date for time-series trending."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which sales and royalties are denominated."
    - name: "validation_status"
      expr: validation_status
      comment: "Whether the sales report has been validated, enabling filtering to audited data only."
    - name: "submission_method"
      expr: submission_method
      comment: "How the report was submitted (portal, EDI, manual) for compliance tracking."
  measures:
    - name: "total_gross_sales"
      expr: SUM(CAST(gross_sales_amount AS DOUBLE))
      comment: "Total gross sales reported by franchisees — primary top-line revenue indicator for the franchise system."
    - name: "total_net_sales"
      expr: SUM(CAST(net_sales_amount AS DOUBLE))
      comment: "Total net sales after adjustments — used to compute royalty obligations and system-wide net revenue."
    - name: "total_royalty_revenue"
      expr: SUM(CAST(royalty_amount AS DOUBLE))
      comment: "Total royalty fees collected from franchisees — direct franchisor revenue stream and key P&L line."
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate AS DOUBLE))
      comment: "Average effective royalty rate across all sales reports — monitors rate consistency and contract compliance."
    - name: "royalty_yield_pct"
      expr: ROUND(100.0 * SUM(CAST(royalty_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_sales_amount AS DOUBLE)), 0), 2)
      comment: "Effective royalty yield as a percentage of gross sales — measures how much of system sales converts to franchisor royalty income."
    - name: "avg_check_value"
      expr: AVG(CAST(average_check_value AS DOUBLE))
      comment: "Average transaction check value across reporting units — proxy for guest spending and menu mix effectiveness."
    - name: "total_transaction_count"
      expr: SUM(CAST(transaction_count AS DOUBLE))
      comment: "Total guest transactions across all franchise units in the period — volume indicator for system traffic."
    - name: "variance_flag_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN variance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sales reports flagged with a variance — signals data quality or compliance issues requiring investigation."
    - name: "total_adjustments"
      expr: SUM(CAST(adjustments_amount AS DOUBLE))
      comment: "Total sales adjustments applied across reports — large values indicate systematic reporting corrections or disputes."
    - name: "report_count"
      expr: COUNT(1)
      comment: "Number of sales reports submitted — baseline volume metric for reporting compliance tracking."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_billing_health`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors franchise billing obligations, payment status, and fee collection efficiency — critical for franchisor cash flow and accounts receivable management."
  source: "`vibe_restaurants_v1`.`franchise`.`billing`"
  dimensions:
    - name: "billing_period_month"
      expr: DATE_TRUNC('month', billing_date)
      comment: "Month of billing date for trend analysis of fee collection cycles."
    - name: "billing_status"
      expr: billing_status
      comment: "Current status of the billing record (open, paid, overdue) for AR aging analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the billing record for multi-currency franchise systems."
    - name: "is_paid"
      expr: is_paid
      comment: "Boolean flag indicating whether the billing has been fully paid — primary collection status indicator."
    - name: "period"
      expr: period
      comment: "Billing period label (e.g., 2024-Q1) for period-over-period comparison."
  measures:
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total amount billed to franchisees — represents total fee obligations raised in the period."
    - name: "total_amount_collected"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total amount actually collected from franchisees — measures cash received against obligations."
    - name: "total_amount_outstanding"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Total outstanding balance due from franchisees — key AR metric for collections management."
    - name: "total_royalty_billed"
      expr: SUM(CAST(royalty_amount AS DOUBLE))
      comment: "Total royalty fees billed — primary franchisor revenue line item."
    - name: "total_marketing_fee_billed"
      expr: SUM(CAST(marketing_fee_amount AS DOUBLE))
      comment: "Total marketing fund contributions billed — funds the national/regional advertising programs."
    - name: "total_technology_fee_billed"
      expr: SUM(CAST(technology_fee_amount AS DOUBLE))
      comment: "Total technology fees billed — covers POS, loyalty, and digital platform costs."
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(amount_paid AS DOUBLE)) / NULLIF(SUM(CAST(billed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of billed amounts collected — measures billing efficiency and franchisee payment compliance."
    - name: "overdue_billing_count"
      expr: COUNT(CASE WHEN is_paid = FALSE AND due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of billing records past due and unpaid — triggers collections escalation and compliance review."
    - name: "avg_days_to_payment"
      expr: AVG(CAST(DATEDIFF(paid_date, billing_date) AS DOUBLE))
      comment: "Average number of days from billing date to payment — measures franchisee payment timeliness."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures franchise compliance audit scores, violation rates, and corrective action triggers — essential for brand protection and regulatory risk management."
  source: "`vibe_restaurants_v1`.`franchise`.`compliance_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of compliance audit (scheduled, surprise, follow-up) for audit program analysis."
    - name: "compliance_audit_status"
      expr: compliance_audit_status
      comment: "Current status of the audit (open, closed, pending review) for workflow tracking."
    - name: "audit_month"
      expr: DATE_TRUNC('month', CAST(audit_timestamp AS DATE))
      comment: "Month the audit was conducted for trend analysis of compliance performance over time."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether the audit triggered a corrective action — key risk flag for franchise compliance teams."
  measures:
    - name: "avg_overall_compliance_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall compliance score across all audits — primary KPI for franchise brand standards adherence."
    - name: "avg_food_safety_score"
      expr: AVG(CAST(food_safety_score AS DOUBLE))
      comment: "Average food safety score — critical health and liability metric monitored by operations and legal."
    - name: "avg_brand_standards_score"
      expr: AVG(CAST(brand_standards_score AS DOUBLE))
      comment: "Average brand standards score — measures consistency of guest experience across franchise locations."
    - name: "avg_cleanliness_score"
      expr: AVG(CAST(cleanliness_score AS DOUBLE))
      comment: "Average cleanliness score — directly impacts guest satisfaction and health inspection outcomes."
    - name: "avg_service_score"
      expr: AVG(CAST(service_score AS DOUBLE))
      comment: "Average service score — measures franchisee adherence to service standards and guest experience protocols."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring corrective action — high rates signal systemic compliance failures."
    - name: "audit_count"
      expr: COUNT(1)
      comment: "Total number of compliance audits conducted — measures audit program coverage and cadence."
    - name: "avg_equipment_score"
      expr: AVG(CAST(equipment_score AS DOUBLE))
      comment: "Average equipment compliance score — tracks maintenance and operational readiness of franchise units."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_agreement_portfolio`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides a portfolio view of franchise agreements — tracks financial terms, compliance status, and renewal pipeline for strategic franchise development decisions."
  source: "`vibe_restaurants_v1`.`franchise`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the franchise agreement (active, expired, terminated) for portfolio health assessment."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of franchise agreement (single-unit, multi-unit, area development) for portfolio segmentation."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance standing of the agreement — identifies at-risk agreements requiring intervention."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the agreement became effective — enables cohort analysis of agreement vintages."
    - name: "ftc_compliance_attestation_flag"
      expr: ftc_compliance_attestation_flag
      comment: "Whether FTC compliance has been attested — regulatory requirement tracking for franchise disclosure."
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total number of franchise agreements in the portfolio — baseline system size metric."
    - name: "avg_royalty_rate_pct"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate across all agreements — monitors rate consistency and revenue yield expectations."
    - name: "avg_marketing_fee_pct"
      expr: AVG(CAST(marketing_fee_percent AS DOUBLE))
      comment: "Average marketing fund contribution rate — ensures adequate funding for brand advertising programs."
    - name: "total_initial_fees"
      expr: SUM(CAST(initial_fee_amount AS DOUBLE))
      comment: "Total initial franchise fees collected — measures new unit development revenue for the franchisor."
    - name: "total_renewal_fees"
      expr: SUM(CAST(renewal_fee_amount AS DOUBLE))
      comment: "Total renewal fees collected — measures revenue from agreement renewals and system retention."
    - name: "avg_sales_target"
      expr: AVG(CAST(sales_target_amount AS DOUBLE))
      comment: "Average sales target per agreement — benchmarks expected unit performance against actual AUV."
    - name: "avg_average_unit_volume"
      expr: AVG(CAST(average_unit_volume AS DOUBLE))
      comment: "Average unit volume across agreements — key system health metric used in FDD disclosures and investor reporting."
    - name: "non_compliant_agreement_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status != 'compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of agreements in non-compliant status — risk indicator for legal and franchise development teams."
    - name: "agreements_expiring_within_90_days"
      expr: COUNT(CASE WHEN effective_end_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Number of agreements expiring within 90 days — drives renewal pipeline management and retention actions."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_performance_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregates franchisee performance scorecard KPIs — enables ranking, benchmarking, and identification of underperforming franchisees for targeted support."
  source: "`vibe_restaurants_v1`.`franchise`.`performance_scorecard`"
  dimensions:
    - name: "evaluation_period_start_month"
      expr: DATE_TRUNC('month', evaluation_period_start)
      comment: "Month of evaluation period start for time-series performance trending."
    - name: "evaluation_type"
      expr: evaluation_type
      comment: "Type of evaluation (annual, quarterly, ad-hoc) for filtering to comparable assessment periods."
    - name: "overall_performance_tier"
      expr: overall_performance_tier
      comment: "Performance tier classification (gold, silver, bronze, probation) for franchisee segmentation."
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Status of the scorecard evaluation (draft, finalized, disputed) for data quality filtering."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region for regional performance benchmarking and area representative accountability."
  measures:
    - name: "avg_customer_satisfaction_score"
      expr: AVG(CAST(customer_satisfaction_score AS DOUBLE))
      comment: "Average guest satisfaction score across franchisees — directly tied to brand equity and repeat visit rates."
    - name: "avg_net_promoter_score"
      expr: AVG(CAST(net_promoter_score AS DOUBLE))
      comment: "Average NPS across franchise units — leading indicator of guest loyalty and word-of-mouth growth."
    - name: "avg_food_safety_score"
      expr: AVG(CAST(food_safety_score AS DOUBLE))
      comment: "Average food safety score from scorecards — monitors health compliance risk across the franchise system."
    - name: "avg_compliance_audit_score"
      expr: AVG(CAST(compliance_audit_average_score AS DOUBLE))
      comment: "Average compliance audit score — measures brand standards adherence across the franchisee portfolio."
    - name: "avg_same_store_sales_growth_pct"
      expr: AVG(CAST(same_store_sales_growth_pct AS DOUBLE))
      comment: "Average same-store sales growth rate — primary organic growth metric for the franchise system."
    - name: "avg_royalty_payment_timeliness_pct"
      expr: AVG(CAST(royalty_payment_timeliness_pct AS DOUBLE))
      comment: "Average royalty payment timeliness rate — measures franchisee financial compliance and cash flow reliability."
    - name: "avg_training_completion_rate_pct"
      expr: AVG(CAST(training_completion_rate_pct AS DOUBLE))
      comment: "Average training completion rate — measures workforce readiness and franchisee investment in staff development."
    - name: "total_system_sales"
      expr: SUM(CAST(total_sales_amount AS DOUBLE))
      comment: "Total system-wide sales across all evaluated franchisees — top-line system revenue for investor and board reporting."
    - name: "total_royalty_collected"
      expr: SUM(CAST(total_royalty_amount AS DOUBLE))
      comment: "Total royalties collected across all franchisees in the evaluation period — franchisor P&L revenue line."
    - name: "avg_unit_volume"
      expr: AVG(CAST(average_unit_volume AS DOUBLE))
      comment: "Average unit volume (AUV) across franchisees — benchmark metric used in FDD, investor decks, and development decisions."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_fee_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Analyzes franchise fee structures across agreements and territories — supports fee benchmarking, rate consistency audits, and revenue modeling."
  source: "`vibe_restaurants_v1`.`franchise`.`fee_schedule`"
  dimensions:
    - name: "calculation_basis"
      expr: calculation_basis
      comment: "Basis for fee calculation (gross sales, net sales, flat) for fee structure segmentation."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate the fee (percentage, flat, tiered) for rate analysis."
    - name: "frequency"
      expr: frequency
      comment: "Billing frequency of the fee (weekly, monthly, annual) for cash flow planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the fee schedule for multi-currency franchise systems."
    - name: "is_active"
      expr: is_active
      comment: "Whether the fee schedule is currently active — filters to current vs. historical rate structures."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the fee schedule became effective — tracks rate change history over time."
  measures:
    - name: "avg_royalty_rate_pct"
      expr: AVG(CAST(royalty_rate_pct AS DOUBLE))
      comment: "Average royalty rate across active fee schedules — benchmarks rate consistency and identifies outliers."
    - name: "avg_marketing_fee_rate_pct"
      expr: AVG(CAST(marketing_fee_rate_pct AS DOUBLE))
      comment: "Average marketing fund contribution rate — ensures adequate and consistent brand fund contributions."
    - name: "avg_flat_fee_amount"
      expr: AVG(CAST(flat_fee_amount AS DOUBLE))
      comment: "Average flat fee amount across schedules — benchmarks fixed fee obligations for financial planning."
    - name: "total_flat_fee_obligations"
      expr: SUM(CAST(flat_fee_amount AS DOUBLE))
      comment: "Total flat fee obligations across all active schedules — measures fixed fee revenue base for the franchisor."
    - name: "fee_schedule_count"
      expr: COUNT(1)
      comment: "Total number of fee schedules — measures complexity of the fee structure portfolio."
    - name: "avg_fee_amount"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average fee amount across all schedule types — provides a blended fee benchmark for financial modeling."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_marketing_fund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks marketing fund contributions from franchisees — ensures adequate brand advertising funding and monitors collection compliance."
  source: "`vibe_restaurants_v1`.`franchise`.`marketing_fund_contribution`"
  dimensions:
    - name: "contribution_period_month"
      expr: DATE_TRUNC('month', contribution_date)
      comment: "Month of contribution for trend analysis of marketing fund inflows."
    - name: "marketing_fund_contribution_status"
      expr: marketing_fund_contribution_status
      comment: "Status of the contribution (pending, paid, overdue) for collection management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contribution for multi-currency franchise systems."
    - name: "calculation_basis"
      expr: calculation_basis
      comment: "Basis for contribution calculation (gross sales, net sales) for rate analysis."
    - name: "is_paid"
      expr: is_paid
      comment: "Whether the contribution has been paid — primary collection status flag."
  measures:
    - name: "total_contributions_collected"
      expr: SUM(CAST(contribution_amount AS DOUBLE))
      comment: "Total marketing fund contributions collected — measures total advertising budget available for brand programs."
    - name: "total_gross_sales_basis"
      expr: SUM(CAST(gross_sales_amount AS DOUBLE))
      comment: "Total gross sales used as the contribution basis — validates that contributions are correctly calculated."
    - name: "avg_contribution_rate_pct"
      expr: AVG(CAST(contribution_rate_percent AS DOUBLE))
      comment: "Average marketing fund contribution rate — monitors rate consistency across the franchise system."
    - name: "effective_contribution_yield_pct"
      expr: ROUND(100.0 * SUM(CAST(contribution_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_sales_amount AS DOUBLE)), 0), 2)
      comment: "Effective marketing fund yield as a percentage of gross sales — validates contribution rates are being applied correctly."
    - name: "total_fund_balance"
      expr: SUM(CAST(fund_balance_amount AS DOUBLE))
      comment: "Total marketing fund balance across all franchisees — measures available advertising spend capacity."
    - name: "unpaid_contribution_count"
      expr: COUNT(CASE WHEN is_paid = FALSE THEN 1 END)
      comment: "Number of unpaid marketing fund contributions — triggers collection follow-up and compliance review."
    - name: "contribution_record_count"
      expr: COUNT(1)
      comment: "Total number of contribution records — baseline volume metric for contribution program coverage."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_nro_pipeline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors new restaurant opening pipeline health — tracks development progress, capital investment, and opening timelines for franchise growth management."
  source: "`vibe_restaurants_v1`.`franchise`.`nro_pipeline`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the NRO project (site selection, construction, training, open) for pipeline stage analysis."
    - name: "stage"
      expr: stage
      comment: "Development stage of the NRO for granular pipeline tracking."
    - name: "development_type"
      expr: development_type
      comment: "Type of development (new build, conversion, relocation) for capital planning segmentation."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk classification of the NRO project — enables prioritization of at-risk openings for intervention."
    - name: "target_open_year"
      expr: YEAR(target_open_date)
      comment: "Target opening year for annual development pipeline planning."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the NRO project — tracks permit, health inspection, and regulatory readiness."
  measures:
    - name: "total_nro_projects"
      expr: COUNT(1)
      comment: "Total NRO projects in the pipeline — measures development activity and growth trajectory."
    - name: "total_budget_capex"
      expr: SUM(CAST(budget_capex AS DOUBLE))
      comment: "Total budgeted capital expenditure across all NRO projects — key input for capital allocation and financing decisions."
    - name: "total_actual_capex_spent"
      expr: SUM(CAST(actual_capex_spent AS DOUBLE))
      comment: "Total actual capital spent on NRO projects — measures capital deployment against budget."
    - name: "capex_budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_capex_spent AS DOUBLE)) / NULLIF(SUM(CAST(budget_capex AS DOUBLE)), 0), 2)
      comment: "Percentage of NRO capex budget consumed — identifies over/under-spend trends for capital management."
    - name: "avg_expected_roi"
      expr: AVG(CAST(expected_roi AS DOUBLE))
      comment: "Average expected ROI across NRO projects — primary investment quality metric for development approval decisions."
    - name: "avg_expected_acuv"
      expr: AVG(CAST(expected_acuv AS DOUBLE))
      comment: "Average expected annual customer unit volume for pipeline projects — validates development economics."
    - name: "permits_obtained_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN permits_obtained_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NRO projects with permits obtained — measures regulatory readiness and opening timeline risk."
    - name: "training_complete_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN training_complete_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NRO projects with training completed — measures operational readiness for opening."
    - name: "avg_capital_investment_estimate"
      expr: AVG(CAST(capital_investment_estimate AS DOUBLE))
      comment: "Average capital investment estimate per NRO — used in FDD disclosures and franchisee financial qualification."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_corrective_actions`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks franchise corrective action resolution rates, severity distribution, and closure timelines — measures compliance remediation effectiveness."
  source: "`vibe_restaurants_v1`.`franchise`.`franchise_corrective_action`"
  dimensions:
    - name: "franchise_corrective_action_status"
      expr: franchise_corrective_action_status
      comment: "Current status of the corrective action (open, in-progress, closed, verified) for workflow management."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the corrective action (critical, major, minor) for risk prioritization."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of the corrective action — tracks whether issues have been formally resolved."
    - name: "issue_date_month"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month the corrective action was issued for trend analysis of compliance issues over time."
    - name: "is_resolved"
      expr: is_resolved
      comment: "Boolean flag indicating resolution — primary filter for open vs. closed corrective action analysis."
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total corrective actions issued — measures compliance issue volume and audit program rigor."
    - name: "resolution_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_resolved = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions resolved — measures franchisee responsiveness to compliance issues."
    - name: "avg_days_to_resolution"
      expr: AVG(CAST(DATEDIFF(resolution_date, issue_date) AS DOUBLE))
      comment: "Average days from issue to resolution — measures speed of compliance remediation; slow resolution signals systemic problems."
    - name: "critical_action_count"
      expr: COUNT(CASE WHEN severity_level = 'critical' THEN 1 END)
      comment: "Number of critical severity corrective actions — high-priority risk indicator for franchise compliance leadership."
    - name: "overdue_action_count"
      expr: COUNT(CASE WHEN is_resolved = FALSE AND due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of corrective actions past their due date and unresolved — triggers escalation and potential agreement enforcement."
    - name: "avg_days_to_closure"
      expr: AVG(CAST(DATEDIFF(closed_date, issue_date) AS DOUBLE))
      comment: "Average days from issue date to formal closure — measures end-to-end corrective action cycle time."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_territory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Analyzes franchise territory portfolio — tracks assignment status, market potential, and financial performance by territory for development planning."
  source: "`vibe_restaurants_v1`.`franchise`.`territory`"
  dimensions:
    - name: "territory_status"
      expr: territory_status
      comment: "Current status of the territory (available, assigned, protected, expired) for development opportunity identification."
    - name: "territory_type"
      expr: territory_type
      comment: "Type of territory (exclusive, non-exclusive, area development) for portfolio segmentation."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Assignment status of the territory — identifies unassigned territories as development opportunities."
    - name: "region"
      expr: region
      comment: "Geographic region for regional development pipeline analysis."
    - name: "trade_area_classification"
      expr: trade_area_classification
      comment: "Trade area classification (urban, suburban, rural) for market segmentation and site selection strategy."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the territory — identifies territories with regulatory or contractual issues."
  measures:
    - name: "total_territories"
      expr: COUNT(1)
      comment: "Total number of territories in the franchise system — measures geographic footprint and development capacity."
    - name: "avg_territory_area_sq_miles"
      expr: AVG(CAST(area_sq_miles AS DOUBLE))
      comment: "Average territory size in square miles — informs territory sizing standards and market coverage analysis."
    - name: "avg_median_income"
      expr: AVG(CAST(median_income AS DOUBLE))
      comment: "Average median household income across territories — proxy for consumer spending potential and AUV expectations."
    - name: "avg_average_unit_volume"
      expr: AVG(CAST(average_unit_volume AS DOUBLE))
      comment: "Average unit volume by territory — benchmarks territory performance for development and renewal decisions."
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate AS DOUBLE))
      comment: "Average royalty rate across territories — monitors rate consistency and identifies negotiated outliers."
    - name: "assigned_territory_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN assignment_status = 'assigned' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of territories currently assigned — measures development penetration of the available territory portfolio."
    - name: "total_franchise_fees"
      expr: SUM(CAST(franchise_fee AS DOUBLE))
      comment: "Total franchise fees associated with territories — measures fee revenue from territory grants."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_support_visits`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures franchise support visit activity, compliance outcomes, and operational impact — tracks field support effectiveness and franchisee engagement."
  source: "`vibe_restaurants_v1`.`franchise`.`support_visit`"
  dimensions:
    - name: "visit_type"
      expr: visit_type
      comment: "Type of support visit (operational, training, compliance, marketing) for activity categorization."
    - name: "support_visit_status"
      expr: support_visit_status
      comment: "Status of the support visit (scheduled, completed, cancelled) for visit program management."
    - name: "visit_month"
      expr: DATE_TRUNC('month', CAST(visit_timestamp AS DATE))
      comment: "Month of the support visit for trend analysis of field support activity."
    - name: "is_training_visit"
      expr: is_training_visit
      comment: "Whether the visit was primarily a training visit — segments operational vs. training support activity."
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Whether a follow-up visit is required — identifies locations needing additional support."
    - name: "region"
      expr: region
      comment: "Geographic region of the support visit for regional field team performance analysis."
  measures:
    - name: "total_support_visits"
      expr: COUNT(1)
      comment: "Total support visits conducted — measures field support program coverage and consultant activity."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score observed during support visits — tracks operational standards adherence in the field."
    - name: "avg_visit_duration_minutes"
      expr: AVG(CAST(visit_duration_minutes AS DOUBLE))
      comment: "Average duration of support visits in minutes — measures depth of engagement and consultant time investment."
    - name: "avg_sales_impact_estimate"
      expr: AVG(CAST(sales_impact_estimate AS DOUBLE))
      comment: "Average estimated sales impact from support visits — measures ROI of field support program."
    - name: "total_visit_expense"
      expr: SUM(CAST(expense_amount AS DOUBLE))
      comment: "Total expense incurred for support visits — measures cost of field support operations for budget management."
    - name: "follow_up_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN follow_up_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of visits requiring follow-up — high rates indicate persistent operational issues in the franchise network."
    - name: "compliance_flag_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of support visits with compliance flags raised — measures compliance issue prevalence in field observations."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`franchise_development_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks franchisee development schedule commitments vs. progress — measures unit opening velocity and development agreement compliance."
  source: "`vibe_restaurants_v1`.`franchise`.`development_schedule`"
  dimensions:
    - name: "development_schedule_status"
      expr: development_schedule_status
      comment: "Current status of the development schedule (on-track, behind, completed, defaulted) for pipeline health assessment."
    - name: "development_phase"
      expr: development_phase
      comment: "Current development phase (planning, construction, pre-opening) for stage-gate analysis."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of development schedule (single-unit, multi-unit, area development) for portfolio segmentation."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the development schedule — identifies franchisees at risk of development default."
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the development schedule commenced for cohort analysis of development programs."
  measures:
    - name: "total_development_schedules"
      expr: COUNT(1)
      comment: "Total active development schedules — measures scale of committed franchise development pipeline."
    - name: "total_units_committed"
      expr: SUM(CAST(total_units_committed AS DOUBLE))
      comment: "Total units committed across all development schedules — measures contracted future system growth."
    - name: "avg_units_committed_per_schedule"
      expr: AVG(CAST(total_units_committed AS DOUBLE))
      comment: "Average units committed per development schedule — benchmarks development agreement size."
    - name: "non_compliant_schedule_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status != 'compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of development schedules in non-compliant status — identifies franchisees at risk of development default and potential agreement termination."
$$;