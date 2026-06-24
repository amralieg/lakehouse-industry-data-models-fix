-- Metric views for domain: finance | Business: Automotive | Version: 2 | Generated on: 2026-06-23 04:49:37

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_vehicle_profitability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle-level profitability metrics covering gross margin, net contribution, incentive impact, warranty reserve charges, and EBITDA contribution. Core strategic KPI view for product line and market profitability steering."
  source: "`vibe_automotive_v1`.`finance`.`vehicle_profitability`"
  dimensions:
    - name: "vehicle_line"
      expr: vehicle_line
      comment: "Vehicle line (e.g. SUV, Sedan, Truck) for product-line profitability segmentation."
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle for year-over-year profitability trend analysis."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel (e.g. dealer, fleet, direct) to compare channel profitability."
    - name: "market_region"
      expr: market_region
      comment: "Geographic market region for regional profitability benchmarking."
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type (ICE, BEV, PHEV, HEV) to track electrification profitability shift."
    - name: "vehicle_category"
      expr: vehicle_category
      comment: "Vehicle category (passenger, commercial, etc.) for segment-level analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual profitability reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly/quarterly profitability tracking."
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Transaction month for time-series profitability trend analysis."
    - name: "vehicle_profitability_status"
      expr: vehicle_profitability_status
      comment: "Status of the profitability record (e.g. final, provisional) for data quality filtering."
    - name: "is_eligible_for_subsidy"
      expr: is_eligible_for_subsidy
      comment: "Flag indicating subsidy eligibility, used to segment subsidized vs. non-subsidized vehicle economics."
    - name: "emission_rating"
      expr: emission_rating
      comment: "Emission rating class for ESG-linked profitability analysis."
  measures:
    - name: "total_gross_revenue_msrp"
      expr: SUM(CAST(gross_revenue_msrp AS DOUBLE))
      comment: "Total MSRP-based gross revenue across all vehicles. Baseline top-line revenue KPI for executive reporting."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue AS DOUBLE))
      comment: "Total net revenue after discounts and incentives. Primary revenue KPI used in P&L and board reporting."
    - name: "total_gross_margin"
      expr: SUM(CAST(gross_margin AS DOUBLE))
      comment: "Total gross margin (revenue minus direct manufacturing cost). Core profitability KPI for product line steering."
    - name: "total_net_contribution_margin"
      expr: SUM(CAST(net_contribution_margin AS DOUBLE))
      comment: "Total net contribution margin after all variable costs including incentives and warranty. Key metric for vehicle economics decisions."
    - name: "total_ebitda_contribution"
      expr: SUM(CAST(ebitda_contribution AS DOUBLE))
      comment: "Total EBITDA contribution from vehicle sales. Used in investor reporting and strategic investment decisions."
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive spend across vehicles. Tracks incentive cost burden and its impact on net revenue."
    - name: "total_warranty_reserve_charge"
      expr: SUM(CAST(warranty_reserve_charge AS DOUBLE))
      comment: "Total warranty reserve charges booked against vehicle sales. Monitors warranty cost accrual trends by model/region."
    - name: "total_actual_manufacturing_cost"
      expr: SUM(CAST(actual_manufacturing_cost AS DOUBLE))
      comment: "Total actual manufacturing cost. Used to compare against standard cost and identify cost overruns."
    - name: "total_standard_manufacturing_cost"
      expr: SUM(CAST(standard_manufacturing_cost AS DOUBLE))
      comment: "Total standard manufacturing cost. Baseline for variance analysis against actual manufacturing cost."
    - name: "total_fi_revenue"
      expr: SUM(CAST(fi_revenue_amount AS DOUBLE))
      comment: "Total Finance & Insurance (F&I) revenue contribution. Critical revenue stream for dealer and OEM profitability."
    - name: "total_subsidy_amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total government or program subsidies received. Important for EV/PHEV economics and regulatory incentive tracking."
    - name: "total_selling_distribution_cost"
      expr: SUM(CAST(selling_distribution_cost AS DOUBLE))
      comment: "Total selling and distribution cost. Used to assess go-to-market cost efficiency by channel and region."
    - name: "avg_gross_margin_per_vehicle"
      expr: AVG(CAST(gross_margin AS DOUBLE))
      comment: "Average gross margin per vehicle unit. Benchmark KPI for per-unit economics across model lines."
    - name: "avg_net_contribution_margin_per_vehicle"
      expr: AVG(CAST(net_contribution_margin AS DOUBLE))
      comment: "Average net contribution margin per vehicle. Used to compare profitability across vehicle lines and channels."
    - name: "vehicle_count"
      expr: COUNT(1)
      comment: "Count of vehicle profitability records. Used as denominator for per-unit KPI calculations and volume context."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_manufacturing_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing cost variance and standard vs. actual cost analysis by plant, vehicle line, and model year. Drives cost reduction decisions and production efficiency steering."
  source: "`vibe_automotive_v1`.`finance`.`manufacturing_cost`"
  dimensions:
    - name: "vehicle_line"
      expr: vehicle_line
      comment: "Vehicle line for cost analysis by product family."
    - name: "vehicle_model_year"
      expr: vehicle_model_year
      comment: "Model year for year-over-year manufacturing cost trend analysis."
    - name: "vehicle_model_code"
      expr: vehicle_model_code
      comment: "Specific model code for granular cost tracking."
    - name: "manufacturing_cost_status"
      expr: manufacturing_cost_status
      comment: "Status of the cost record (e.g. confirmed, provisional) for data quality filtering."
    - name: "costing_version"
      expr: costing_version
      comment: "Costing version (standard, revised) for scenario comparison."
    - name: "costing_month"
      expr: DATE_TRUNC('MONTH', costing_date)
      comment: "Costing month for monthly cost trend analysis."
    - name: "is_variance_exceed_threshold"
      expr: is_variance_exceed_threshold
      comment: "Flag for records where cost variance exceeds the defined threshold — used to filter exception reports."
  measures:
    - name: "total_actual_cost"
      expr: SUM(CAST(total_actual_cost AS DOUBLE))
      comment: "Total actual manufacturing cost. Primary cost KPI for plant and vehicle line cost management."
    - name: "total_standard_cost"
      expr: SUM(CAST(total_standard_cost AS DOUBLE))
      comment: "Total standard manufacturing cost. Baseline for variance analysis and cost target tracking."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance_amount AS DOUBLE))
      comment: "Total cost variance (actual minus standard). Key metric for identifying cost overruns requiring management action."
    - name: "total_actual_labor_cost"
      expr: SUM(CAST(actual_labor_cost AS DOUBLE))
      comment: "Total actual labor cost. Tracks labor cost trends and efficiency improvements."
    - name: "total_actual_material_cost"
      expr: SUM(CAST(actual_material_cost AS DOUBLE))
      comment: "Total actual material cost. Largest cost component; critical for BOM cost management."
    - name: "total_actual_energy_cost"
      expr: SUM(CAST(actual_energy_cost AS DOUBLE))
      comment: "Total actual energy cost. Supports ESG energy cost tracking and efficiency initiatives."
    - name: "total_actual_scrap_cost"
      expr: SUM(CAST(actual_scrap_cost AS DOUBLE))
      comment: "Total actual scrap cost. Tracks waste and quality-driven cost losses in manufacturing."
    - name: "total_actual_tooling_amortization_cost"
      expr: SUM(CAST(actual_tooling_amortization_cost AS DOUBLE))
      comment: "Total actual tooling amortization cost. Monitors capital tooling cost recovery per vehicle produced."
    - name: "total_actual_fixed_overhead_cost"
      expr: SUM(CAST(actual_fixed_overhead_cost AS DOUBLE))
      comment: "Total actual fixed overhead cost. Used in absorption costing and plant capacity utilization analysis."
    - name: "total_actual_variable_overhead_cost"
      expr: SUM(CAST(actual_variable_overhead_cost AS DOUBLE))
      comment: "Total actual variable overhead cost. Tracks variable cost efficiency as production volumes change."
    - name: "avg_cost_variance_percent"
      expr: AVG(CAST(cost_variance_percent AS DOUBLE))
      comment: "Average cost variance percentage. Normalized KPI for comparing cost performance across plants and models."
    - name: "production_order_count"
      expr: COUNT(1)
      comment: "Count of production order cost records. Used as volume context for per-unit cost calculations."
    - name: "variance_exception_count"
      expr: COUNT(CASE WHEN is_variance_exceed_threshold = TRUE THEN 1 END)
      comment: "Count of production orders where cost variance exceeded the threshold. Drives exception-based cost management actions."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_warranty_reserve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warranty reserve adequacy, claims activity, and actuarial metrics by vehicle line, model year, and market region. Critical for financial risk management and IFRS/SOX compliance."
  source: "`vibe_automotive_v1`.`finance`.`warranty_reserve`"
  dimensions:
    - name: "vehicle_line"
      expr: vehicle_line
      comment: "Vehicle line for warranty reserve analysis by product family."
    - name: "model_year"
      expr: model_year
      comment: "Model year for vintage-based warranty reserve adequacy analysis."
    - name: "market_region"
      expr: market_region
      comment: "Market region for geographic warranty cost distribution analysis."
    - name: "warranty_type"
      expr: warranty_type
      comment: "Warranty type (basic, powertrain, extended) for reserve segmentation."
    - name: "warranty_reserve_status"
      expr: warranty_reserve_status
      comment: "Status of the reserve record (active, closed, under review) for filtering."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual warranty reserve reporting."
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period for period-level reserve movement tracking."
    - name: "is_ifrs_compliant"
      expr: is_ifrs_compliant
      comment: "IFRS compliance flag for regulatory reporting segmentation."
    - name: "is_sox_controlled"
      expr: is_sox_controlled
      comment: "SOX control flag for internal audit and compliance reporting."
    - name: "reserve_source"
      expr: reserve_source
      comment: "Source of the reserve (actuarial, statistical, management estimate) for methodology transparency."
  measures:
    - name: "total_reserve_amount"
      expr: SUM(CAST(reserve_amount AS DOUBLE))
      comment: "Total warranty reserve amount booked. Primary balance sheet liability KPI for warranty risk management."
    - name: "total_reserve_balance"
      expr: SUM(CAST(reserve_balance AS DOUBLE))
      comment: "Total current warranty reserve balance. Tracks reserve adequacy against outstanding warranty obligations."
    - name: "total_warranty_claims_amount"
      expr: SUM(CAST(warranty_claims_amount AS DOUBLE))
      comment: "Total warranty claims paid or accrued. Measures actual warranty cost burden against reserve."
    - name: "total_claims_charged"
      expr: SUM(CAST(claims_charged AS DOUBLE))
      comment: "Total claims charged against the warranty reserve. Tracks reserve consumption rate."
    - name: "total_warranty_claims_count"
      expr: SUM(CAST(warranty_claims_count AS DOUBLE))
      comment: "Total number of warranty claims. Volume KPI for warranty frequency analysis."
    - name: "total_units_sold"
      expr: SUM(CAST(units_sold AS DOUBLE))
      comment: "Total units sold covered by warranty reserves. Used to calculate per-unit reserve adequacy."
    - name: "total_estimated_cost_per_unit"
      expr: SUM(CAST(estimated_cost_per_unit AS DOUBLE))
      comment: "Sum of estimated warranty cost per unit across all reserve records. Used for aggregate cost projection."
    - name: "avg_reserve_adequacy_ratio"
      expr: AVG(CAST(reserve_adequacy_ratio AS DOUBLE))
      comment: "Average reserve adequacy ratio (reserve balance / expected claims). Key actuarial KPI for reserve sufficiency assessment."
    - name: "avg_estimated_cost_per_unit"
      expr: AVG(CAST(estimated_cost_per_unit AS DOUBLE))
      comment: "Average estimated warranty cost per unit. Benchmark for warranty cost per vehicle across model lines."
    - name: "reserve_record_count"
      expr: COUNT(1)
      comment: "Count of warranty reserve records. Used for coverage and completeness monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_budget_vs_actual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget vs. actual spend analysis by cost center, GL account, fiscal year, and business unit. Core financial planning and control KPI view for CFO and finance leadership."
  source: "`vibe_automotive_v1`.`finance`.`budget_line`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual budget vs. actual comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly budget tracking and variance reporting."
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit for organizational budget accountability."
    - name: "product_line"
      expr: product_line
      comment: "Product line for budget allocation analysis by vehicle/product family."
    - name: "budget_line_status"
      expr: budget_line_status
      comment: "Budget line status (approved, draft, revised) for filtering active budget records."
    - name: "amount_type"
      expr: amount_type
      comment: "Amount type (OPEX, CAPEX, headcount) for budget category analysis."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Allocation method used for cost distribution analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency budget reporting."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code for plant-level budget accountability."
    - name: "is_manual"
      expr: is_manual
      comment: "Flag for manually entered budget lines vs. system-generated, for audit and control purposes."
  measures:
    - name: "total_planned_amount"
      expr: SUM(CAST(planned_amount AS DOUBLE))
      comment: "Total planned budget amount. Primary budget baseline for variance analysis."
    - name: "total_revised_amount"
      expr: SUM(CAST(revised_amount AS DOUBLE))
      comment: "Total revised budget amount after adjustments. Tracks budget reforecasting activity."
    - name: "budget_line_count"
      expr: COUNT(1)
      comment: "Count of budget lines. Used for budget completeness and coverage monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_capex_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure request pipeline metrics covering approval rates, budget utilization, NPV/IRR, and payback period analysis. Drives investment prioritization and capital allocation decisions."
  source: "`vibe_automotive_v1`.`finance`.`capex_request`"
  dimensions:
    - name: "investment_category"
      expr: investment_category
      comment: "Investment category (tooling, facility, IT, R&D) for capital allocation analysis."
    - name: "capex_request_status"
      expr: capex_request_status
      comment: "Request status (submitted, approved, rejected, in-progress) for pipeline tracking."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual CAPEX budget cycle management."
    - name: "priority"
      expr: priority
      comment: "Investment priority (critical, high, medium, low) for capital rationing decisions."
    - name: "funding_source"
      expr: funding_source
      comment: "Funding source (internal, external, government grant) for capital structure analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the CAPEX request for risk-adjusted investment portfolio management."
    - name: "is_capitalized"
      expr: is_capitalized
      comment: "Flag indicating whether the investment is capitalized vs. expensed, for balance sheet impact analysis."
    - name: "has_external_funding"
      expr: has_external_funding
      comment: "Flag for externally funded investments, relevant for subsidy and grant tracking."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement method (tender, direct award) for sourcing strategy analysis."
    - name: "project_start_month"
      expr: DATE_TRUNC('MONTH', project_start_date)
      comment: "Project start month for CAPEX pipeline timing analysis."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved CAPEX budget. Primary capital commitment KPI for investment governance."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual CAPEX spend. Tracks capital deployment against approved budgets."
    - name: "total_budget_requested"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total CAPEX budget requested (pre-approval). Used to assess capital demand vs. available budget."
    - name: "total_external_funding"
      expr: SUM(CAST(external_funding_amount AS DOUBLE))
      comment: "Total external funding secured for CAPEX projects. Tracks subsidy and grant contribution to capital plan."
    - name: "avg_npv"
      expr: AVG(CAST(npv AS DOUBLE))
      comment: "Average Net Present Value of CAPEX requests. Key financial return metric for investment prioritization."
    - name: "avg_irr"
      expr: AVG(CAST(irr AS DOUBLE))
      comment: "Average Internal Rate of Return. Used to rank and select investments against hurdle rate."
    - name: "avg_payback_period_years"
      expr: AVG(CAST(payback_period_years AS DOUBLE))
      comment: "Average payback period in years. Used to assess capital recovery speed for liquidity planning."
    - name: "capex_request_count"
      expr: COUNT(1)
      comment: "Total number of CAPEX requests. Used for pipeline volume and approval throughput analysis."
    - name: "approved_request_count"
      expr: COUNT(CASE WHEN capex_request_status = 'APPROVED' THEN 1 END)
      comment: "Count of approved CAPEX requests. Used to calculate approval rate and governance efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable invoice metrics covering outstanding balances, aging, collection performance, and revenue recognition. Critical for working capital management and cash flow forecasting."
  source: "`vibe_automotive_v1`.`finance`.`ar_invoice`"
  dimensions:
    - name: "ar_invoice_status"
      expr: ar_invoice_status
      comment: "Invoice status (open, paid, overdue, disputed) for AR aging and collection analysis."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket (current, 30-60, 60-90, 90+) for DSO and collection risk analysis."
    - name: "invoice_category"
      expr: invoice_category
      comment: "Invoice category (vehicle sale, parts, service) for revenue stream analysis."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Invoice type for transaction classification."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel for channel-level AR analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual AR reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly AR balance and collection tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency AR exposure analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status for cash application and collection monitoring."
    - name: "collection_status"
      expr: collection_status
      comment: "Collection status (in-collection, written-off, disputed) for credit risk management."
    - name: "intercompany_flag"
      expr: intercompany_flag
      comment: "Intercompany flag to separate third-party AR from intercompany balances."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Invoice month for revenue recognition and AR trend analysis."
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross AR invoice amount. Primary top-line revenue and receivables KPI."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net AR invoice amount after discounts. Net revenue KPI for P&L reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AR invoices. Used for tax liability reporting and compliance."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount granted. Tracks discount policy impact on net revenue."
    - name: "total_payment_received"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total payments received against AR invoices. Tracks cash collection performance."
    - name: "total_warranty_reserve_amount"
      expr: SUM(CAST(warranty_reserve_amount AS DOUBLE))
      comment: "Total warranty reserve amounts embedded in AR invoices. Tracks warranty accrual at point of sale."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AR invoices. Volume KPI for billing activity and workload analysis."
    - name: "overdue_invoice_count"
      expr: COUNT(CASE WHEN ar_invoice_status = 'OVERDUE' THEN 1 END)
      comment: "Count of overdue invoices. Key collection risk indicator for credit management."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice metrics covering payment performance, discount capture, three-way match compliance, and vendor payment terms adherence. Drives working capital and procurement finance decisions."
  source: "`vibe_automotive_v1`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "AP invoice status (open, paid, blocked, disputed) for payables pipeline management."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (ACH, wire, check) for payment channel analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms (Net30, Net60, 2/10 Net30) for working capital and DPO analysis."
    - name: "material_group"
      expr: material_group
      comment: "Material group for spend category analysis by commodity."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code for plant-level AP spend analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual AP reporting."
    - name: "three_way_match_flag"
      expr: three_way_match_flag
      comment: "Three-way match flag (PO/GR/Invoice) for procurement compliance monitoring."
    - name: "is_credit_memo"
      expr: is_credit_memo
      comment: "Credit memo flag to separate credit notes from standard invoices."
    - name: "payment_block_flag"
      expr: payment_block_flag
      comment: "Payment block flag for identifying invoices held from payment."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Invoice month for AP spend trend analysis."
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross AP invoice amount. Primary payables spend KPI."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net AP invoice amount after discounts. Net payables liability KPI."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total input tax on AP invoices. Used for VAT reclaim and tax compliance reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured. Tracks discount capture rate and working capital benefit."
    - name: "total_warranty_reserve_amount"
      expr: SUM(CAST(warranty_reserve_amount AS DOUBLE))
      comment: "Total warranty reserve amounts on AP invoices. Tracks supplier warranty cost pass-through."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total AP invoice count. Volume KPI for AP workload and automation rate analysis."
    - name: "three_way_match_count"
      expr: COUNT(CASE WHEN three_way_match_flag = TRUE THEN 1 END)
      comment: "Count of invoices with successful three-way match. Measures procurement compliance and fraud risk reduction."
    - name: "blocked_invoice_count"
      expr: COUNT(CASE WHEN payment_block_flag = TRUE THEN 1 END)
      comment: "Count of payment-blocked invoices. Tracks AP exceptions requiring resolution to avoid supplier relationship issues."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry volume, manual entry rate, and intercompany transaction metrics. Supports financial close quality, SOX compliance, and audit readiness monitoring."
  source: "`vibe_automotive_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "journal_entry_status"
      expr: journal_entry_status
      comment: "Journal entry status (posted, reversed, parked) for close process monitoring."
    - name: "document_type"
      expr: document_type
      comment: "Document type (SA, KR, DR, etc.) for transaction classification in the GL."
    - name: "posting_category"
      expr: posting_category
      comment: "Posting category for financial statement line classification."
    - name: "source_module"
      expr: source_module
      comment: "Source module (MM, SD, FI, CO) for sub-ledger reconciliation analysis."
    - name: "posting_period"
      expr: posting_period
      comment: "Posting period for period-close completeness monitoring."
    - name: "is_manual_entry"
      expr: is_manual_entry
      comment: "Manual entry flag for SOX control monitoring — high manual entry rates indicate control risk."
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Intercompany indicator for elimination and reconciliation analysis."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Reversal indicator for tracking correcting entries and error rates."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', document_date)
      comment: "Posting month for GL activity trend analysis."
  measures:
    - name: "total_journal_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total journal entry amount. Baseline GL activity volume KPI."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount posted via journal entries. Used for tax provision and compliance reporting."
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total journal entry count. Volume KPI for close process efficiency and automation benchmarking."
    - name: "manual_entry_count"
      expr: COUNT(CASE WHEN is_manual_entry = TRUE THEN 1 END)
      comment: "Count of manual journal entries. SOX control KPI — high manual entry rates trigger audit scrutiny."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Count of reversed journal entries. Tracks error correction volume as a financial close quality indicator."
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN intercompany_indicator = TRUE THEN 1 END)
      comment: "Count of intercompany journal entries. Used for intercompany elimination completeness monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_dealer_incentive`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dealer incentive program spend, payment performance, and budget utilization metrics. Drives sales incentive ROI analysis and dealer network investment decisions."
  source: "`vibe_automotive_v1`.`finance`.`dealer_incentive`"
  dimensions:
    - name: "program_type"
      expr: program_type
      comment: "Incentive program type (volume bonus, stair-step, floor plan) for program effectiveness analysis."
    - name: "incentive_category"
      expr: incentive_category
      comment: "Incentive category for spend classification and budget tracking."
    - name: "dealer_incentive_status"
      expr: dealer_incentive_status
      comment: "Incentive status (accrued, paid, pending) for payment pipeline monitoring."
    - name: "vehicle_line"
      expr: vehicle_line
      comment: "Vehicle line for incentive spend analysis by product family."
    - name: "model_year"
      expr: model_year
      comment: "Model year for incentive program vintage analysis."
    - name: "region_code"
      expr: region_code
      comment: "Region code for geographic incentive spend distribution analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for incentive disbursement analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status for cash flow and accrual reconciliation."
    - name: "is_taxable"
      expr: is_taxable
      comment: "Taxability flag for tax reporting on dealer incentive payments."
    - name: "program_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Program start month for incentive program lifecycle analysis."
  measures:
    - name: "total_actual_payment_amount"
      expr: SUM(CAST(actual_payment_amount AS DOUBLE))
      comment: "Total actual incentive payments made to dealers. Primary incentive spend KPI."
    - name: "total_budget"
      expr: SUM(CAST(total_budget AS DOUBLE))
      comment: "Total incentive program budget. Used for budget utilization and spend control analysis."
    - name: "total_incentive_amount_per_unit"
      expr: SUM(CAST(incentive_amount_per_unit AS DOUBLE))
      comment: "Sum of per-unit incentive amounts. Used to calculate average incentive cost per vehicle."
    - name: "avg_incentive_amount_per_unit"
      expr: AVG(CAST(incentive_amount_per_unit AS DOUBLE))
      comment: "Average incentive amount per vehicle unit. Key metric for per-unit economics and incentive efficiency."
    - name: "incentive_program_count"
      expr: COUNT(1)
      comment: "Count of dealer incentive programs. Used for program portfolio management."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset portfolio metrics covering net book value, accumulated depreciation, acquisition cost, and asset lifecycle status. Drives capital asset management and balance sheet reporting."
  source: "`vibe_automotive_v1`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class (machinery, vehicles, buildings, IT) for asset portfolio segmentation."
    - name: "asset_type"
      expr: asset_type
      comment: "Asset type for detailed asset classification."
    - name: "asset_status"
      expr: asset_status
      comment: "Asset status (active, retired, under maintenance) for lifecycle management."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method (straight-line, declining balance) for accounting policy analysis."
    - name: "location_code"
      expr: location_code
      comment: "Location code for plant/facility-level asset tracking."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Responsible department for asset accountability and cost center allocation."
    - name: "capitalized_flag"
      expr: capitalized_flag
      comment: "Capitalization flag to separate capitalized assets from expensed items."
    - name: "acquisition_year"
      expr: DATE_TRUNC('YEAR', acquisition_date)
      comment: "Acquisition year for asset vintage analysis and replacement planning."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of fixed assets. Gross asset base KPI for balance sheet reporting."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation. Tracks asset aging and replacement need across the portfolio."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of fixed assets. Primary balance sheet asset KPI."
    - name: "total_tax_depreciation_amount"
      expr: SUM(CAST(tax_depreciation_amount AS DOUBLE))
      comment: "Total tax depreciation amount. Used for deferred tax calculation and tax reporting."
    - name: "total_insurance_coverage_amount"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage value of fixed assets. Tracks insurance adequacy vs. asset replacement value."
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Total number of fixed assets. Portfolio size KPI for asset management."
    - name: "avg_net_book_value"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value per asset. Used to assess average asset age and replacement cycle planning."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_inventory_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory valuation metrics covering total inventory value, standard vs. actual cost variances, obsolescence provisions, and write-downs. Critical for balance sheet accuracy and working capital management."
  source: "`vibe_automotive_v1`.`finance`.`finance_inventory_valuation`"
  dimensions:
    - name: "material_type"
      expr: material_type
      comment: "Material type (raw material, WIP, finished goods) for inventory category analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code for plant-level inventory valuation analysis."
    - name: "storage_location_code"
      expr: storage_location_code
      comment: "Storage location for granular inventory positioning analysis."
    - name: "valuation_method"
      expr: valuation_method
      comment: "Valuation method (standard cost, moving average, FIFO) for accounting policy analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual inventory valuation reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly inventory balance tracking."
    - name: "is_consignment"
      expr: is_consignment
      comment: "Consignment flag to separate owned inventory from consignment stock."
    - name: "valuation_month"
      expr: DATE_TRUNC('MONTH', valuation_date)
      comment: "Valuation month for inventory value trend analysis."
  measures:
    - name: "total_valuation_amount"
      expr: SUM(CAST(total_valuation_amount AS DOUBLE))
      comment: "Total inventory valuation amount. Primary balance sheet inventory KPI."
    - name: "total_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total inventory value at current cost. Used for working capital analysis."
    - name: "total_obsolescence_provision"
      expr: SUM(CAST(obsolescence_provision_amount AS DOUBLE))
      comment: "Total obsolescence provision. Tracks slow-moving and obsolete inventory risk on the balance sheet."
    - name: "total_write_down_amount"
      expr: SUM(CAST(write_down_amount AS DOUBLE))
      comment: "Total inventory write-down amount. Measures realized inventory losses impacting P&L."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total standard vs. actual cost variance on inventory. Drives cost accounting accuracy investigations."
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity on hand across all inventory records. Volume KPI for inventory coverage analysis."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across inventory records. Used for cost trend and inflation impact analysis."
    - name: "avg_standard_unit_cost"
      expr: AVG(CAST(standard_unit_cost AS DOUBLE))
      comment: "Average standard unit cost. Benchmark for cost variance analysis."
    - name: "inventory_record_count"
      expr: COUNT(1)
      comment: "Count of inventory valuation records. Used for coverage completeness monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_intercompany_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany settlement metrics covering settlement volumes, netting efficiency, reconciliation status, and transfer pricing compliance. Critical for group consolidation and intercompany elimination."
  source: "`vibe_automotive_v1`.`finance`.`intercompany_settlement`"
  dimensions:
    - name: "settlement_type"
      expr: settlement_type
      comment: "Settlement type (goods, services, royalty, loan) for intercompany transaction classification."
    - name: "intercompany_settlement_status"
      expr: intercompany_settlement_status
      comment: "Settlement status (pending, cleared, disputed) for reconciliation monitoring."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status for intercompany elimination completeness tracking."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual intercompany reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for period-close intercompany reconciliation."
    - name: "sending_company_code"
      expr: sending_company_code
      comment: "Sending entity for intercompany flow analysis."
    - name: "receiving_company_code"
      expr: receiving_company_code
      comment: "Receiving entity for intercompany flow analysis."
    - name: "netting_indicator"
      expr: netting_indicator
      comment: "Netting indicator to identify settlements processed through netting vs. gross settlement."
    - name: "transfer_price_basis"
      expr: transfer_price_basis
      comment: "Transfer pricing basis (arm's length, cost-plus, resale price) for tax compliance analysis."
    - name: "settlement_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Settlement month for intercompany volume trend analysis."
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross intercompany settlement amount. Primary intercompany flow KPI for consolidation."
    - name: "total_net_amount"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net intercompany settlement amount after netting. Tracks netting efficiency."
    - name: "total_tax_amount"
      expr: SUM(CAST(amount_tax AS DOUBLE))
      comment: "Total tax on intercompany settlements. Used for transfer pricing tax compliance reporting."
    - name: "settlement_count"
      expr: COUNT(1)
      comment: "Total intercompany settlement count. Volume KPI for intercompany activity monitoring."
    - name: "approved_settlement_count"
      expr: COUNT(CASE WHEN is_approved = TRUE THEN 1 END)
      comment: "Count of approved settlements. Tracks approval completeness for period-close readiness."
    - name: "netting_settlement_count"
      expr: COUNT(CASE WHEN netting_indicator = TRUE THEN 1 END)
      comment: "Count of settlements processed via netting. Measures netting program utilization and cash efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_accruals`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accruals KPI view – tracks total and average accrual amounts and tax exposure across fiscal periods and cost centers."
  source: "`vibe_automotive_v1`.`finance`.`accrual`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the accrual"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the accrual"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Identifier of the cost center linked to the accrual"
    - name: "accrual_type"
      expr: accrual_type
      comment: "Type/category of the accrual"
    - name: "accrual_status"
      expr: accrual_status
      comment: "Current status of the accrual"
    - name: "accrual_month"
      expr: DATE_TRUNC('month', accrual_date)
      comment: "Accrual month for time‑based analysis"
  measures:
    - name: "accrual_count"
      expr: COUNT(1)
      comment: "Number of accrual records"
    - name: "total_accrual_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total accrual amount"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount for accruals"
    - name: "average_accrual_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average accrual amount per record"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_ap_invoices`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Payable invoice view – provides spend visibility, discounts and tax impact."
  source: "`vibe_automotive_v1`.`finance`.`ap_invoice`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor identifier"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice"
    - name: "due_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month of invoice due date"
  measures:
    - name: "ap_invoice_count"
      expr: COUNT(1)
      comment: "Number of AP invoices"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount of AP invoices"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount of AP invoices"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount granted on AP invoices"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AP invoices"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_ar_invoices`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Receivable invoice view – tracks revenue, tax and collection performance."
  source: "`vibe_automotive_v1`.`finance`.`ar_invoice`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice"
    - name: "profit_center_code"
      expr: profit_center_code
      comment: "Profit center linked to the invoice"
    - name: "invoice_status"
      expr: ar_invoice_status
      comment: "Current status of the AR invoice"
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month of invoice posting"
  measures:
    - name: "ar_invoice_count"
      expr: COUNT(1)
      comment: "Number of AR invoices"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount of AR invoices"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount of AR invoices"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AR invoices"
    - name: "avg_days_to_payment"
      expr: AVG(DATEDIFF(payment_received_date, due_date))
      comment: "Average days between due date and actual payment receipt"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_budget_lines`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget line view – compares planned vs revised amounts and tracks quantity metrics."
  source: "`vibe_automotive_v1`.`finance`.`budget_line`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget line"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center linked to the line"
    - name: "gl_account_id"
      expr: gl_account_id
      comment: "GL account for the line"
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center linked to the line"
    - name: "budget_line_status"
      expr: budget_line_status
      comment: "Current status of the budget line"
  measures:
    - name: "budget_line_count"
      expr: COUNT(1)
      comment: "Number of budget line items"
    - name: "total_planned_amount"
      expr: SUM(CAST(planned_amount AS DOUBLE))
      comment: "Total planned (budgeted) amount"
    - name: "total_revised_amount"
      expr: SUM(CAST(revised_amount AS DOUBLE))
      comment: "Total revised (actual) amount"
    - name: "total_line_quantity"
      expr: SUM(CAST(line_quantity AS DOUBLE))
      comment: "Sum of line quantities"
    - name: "avg_line_quantity"
      expr: AVG(CAST(line_quantity AS DOUBLE))
      comment: "Average line quantity"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`finance_capex_requests`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capex request view – monitors investment budgeting, spend and financial performance indicators."
  source: "`vibe_automotive_v1`.`finance`.`capex_request`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the capex request"
    - name: "capex_request_status"
      expr: capex_request_status
      comment: "Current approval/status of the request"
    - name: "priority"
      expr: priority
      comment: "Business priority assigned to the request"
    - name: "request_month"
      expr: DATE_TRUNC('month', request_date)
      comment: "Month when the request was submitted"
  measures:
    - name: "capex_request_count"
      expr: COUNT(1)
      comment: "Number of capital expenditure requests"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount for capex requests"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend recorded for approved capex"
    - name: "avg_irr"
      expr: AVG(CAST(irr AS DOUBLE))
      comment: "Average internal rate of return across requests"
    - name: "avg_payback_period_years"
      expr: AVG(CAST(payback_period_years AS DOUBLE))
      comment: "Average payback period in years"
$$;