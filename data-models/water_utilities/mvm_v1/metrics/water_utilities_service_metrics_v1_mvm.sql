-- Metric views for domain: service | Business: Water Utilities | Version: 1 | Generated on: 2026-05-06 01:55:38

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`service_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for service agreements — tracks active portfolio value, deposit exposure, SLA commitments, and customer program adoption to steer revenue assurance and contract management decisions."
  source: "`water_utilities_ecm`.`service`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Lifecycle status of the agreement (e.g., Active, Terminated, Pending) — primary segmentation for portfolio health analysis."
    - name: "billing_cycle_code"
      expr: billing_cycle_code
      comment: "Billing cycle assigned to the agreement (e.g., Monthly, Quarterly) — used to align revenue forecasting and cash-flow analysis."
    - name: "termination_reason_code"
      expr: termination_reason_code
      comment: "Reason code for agreement termination — enables churn root-cause analysis and retention strategy decisions."
    - name: "deposit_status"
      expr: deposit_status
      comment: "Current status of the security deposit (e.g., Held, Refunded, Applied) — supports credit-risk and cash-management reporting."
    - name: "auto_pay_enabled"
      expr: auto_pay_enabled
      comment: "Indicates whether auto-pay is active on the agreement — used to segment payment-risk and collections efficiency."
    - name: "low_income_assistance_eligible"
      expr: low_income_assistance_eligible
      comment: "Flag indicating eligibility for low-income assistance programs — supports affordability program targeting and regulatory reporting."
    - name: "irrigation_service_flag"
      expr: irrigation_service_flag
      comment: "Indicates whether the agreement includes irrigation service — used for seasonal demand and conservation program analysis."
    - name: "fire_protection_service_flag"
      expr: fire_protection_service_flag
      comment: "Indicates whether fire protection service is included — critical for infrastructure planning and regulatory compliance tracking."
    - name: "start_date"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the agreement became effective — enables cohort and vintage analysis of the agreement portfolio."
    - name: "end_date"
      expr: DATE_TRUNC('month', end_date)
      comment: "Month the agreement is scheduled to end — supports contract renewal pipeline and revenue-at-risk forecasting."
  measures:
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN agreement_id END)
      comment: "Number of currently active service agreements — primary portfolio-size KPI used in capacity planning and revenue forecasting."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total security deposit value held across all agreements — measures credit-risk exposure and cash held in trust for regulatory reporting."
    - name: "avg_deposit_amount"
      expr: AVG(CAST(deposit_amount AS DOUBLE))
      comment: "Average security deposit per agreement — benchmarks deposit policy adequacy and identifies outlier risk segments."
    - name: "total_minimum_usage_commitment_gallons"
      expr: SUM(CAST(minimum_usage_commitment_gallons AS DOUBLE))
      comment: "Total contracted minimum usage volume in gallons across active agreements — underpins minimum revenue guarantee calculations."
    - name: "avg_minimum_usage_commitment_gallons"
      expr: AVG(CAST(minimum_usage_commitment_gallons AS DOUBLE))
      comment: "Average minimum usage commitment per agreement — used to assess whether contracted volumes align with infrastructure capacity."
    - name: "auto_pay_adoption_count"
      expr: COUNT(CASE WHEN auto_pay_enabled = TRUE THEN agreement_id END)
      comment: "Number of agreements with auto-pay enabled — tracks digital payment adoption, which reduces collections cost and late-payment risk."
    - name: "low_income_eligible_count"
      expr: COUNT(CASE WHEN low_income_assistance_eligible = TRUE THEN agreement_id END)
      comment: "Number of agreements eligible for low-income assistance — supports affordability program sizing and regulatory compliance reporting."
    - name: "terminated_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'Terminated' THEN agreement_id END)
      comment: "Number of terminated agreements — key churn indicator used to evaluate retention programs and service reliability."
    - name: "sla_met_agreement_count"
      expr: COUNT(CASE WHEN sla_response_time_hours IS NOT NULL THEN agreement_id END)
      comment: "Number of agreements with an SLA response-time commitment defined — measures SLA coverage across the portfolio for compliance tracking."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`service_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and SLA performance KPIs for service orders — tracks order throughput, SLA compliance, service fee revenue, and scheduling efficiency to drive field operations and customer satisfaction decisions."
  source: "`water_utilities_ecm`.`service`.`order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of service order (e.g., Connect, Disconnect, Repair, Meter Read) — primary segmentation for workload and resource planning."
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order (e.g., Open, Completed, Cancelled) — used to monitor backlog and completion rates."
    - name: "priority"
      expr: priority
      comment: "Order priority level (e.g., Emergency, High, Normal) — drives SLA tier analysis and resource dispatch decisions."
    - name: "outcome_code"
      expr: outcome_code
      comment: "Outcome of the completed order (e.g., Resolved, Rescheduled, No-Access) — used to measure first-visit resolution rates."
    - name: "billable_flag"
      expr: billable_flag
      comment: "Indicates whether the order generates a billable charge — separates revenue-generating work from non-billable operational activity."
    - name: "sla_met_flag"
      expr: sla_met_flag
      comment: "Indicates whether the order was completed within the SLA target — primary SLA compliance dimension for regulatory and operational reporting."
    - name: "requested_date"
      expr: DATE_TRUNC('month', requested_date)
      comment: "Month the order was requested — enables trend analysis of service demand over time."
    - name: "completion_date"
      expr: DATE_TRUNC('month', completion_date)
      comment: "Month the order was completed — used to measure throughput and backlog clearance rates."
    - name: "scheduled_date"
      expr: DATE_TRUNC('week', scheduled_date)
      comment: "Week the order was scheduled — supports field crew capacity planning and scheduling efficiency analysis."
  measures:
    - name: "total_order_count"
      expr: COUNT(1)
      comment: "Total number of service orders — baseline throughput KPI for field operations capacity and demand planning."
    - name: "completed_order_count"
      expr: COUNT(CASE WHEN order_status = 'Completed' THEN order_id END)
      comment: "Number of completed service orders — measures operational throughput and field crew productivity."
    - name: "sla_met_count"
      expr: COUNT(CASE WHEN sla_met_flag = TRUE THEN order_id END)
      comment: "Number of orders completed within SLA — numerator for SLA compliance rate; directly tied to regulatory penalties and customer satisfaction."
    - name: "sla_eligible_count"
      expr: COUNT(CASE WHEN sla_met_flag IS NOT NULL THEN order_id END)
      comment: "Number of orders with a measurable SLA outcome — denominator for SLA compliance rate calculation."
    - name: "total_service_fee_amount"
      expr: SUM(CAST(service_fee_amount AS DOUBLE))
      comment: "Total service fee revenue generated by billable orders — key revenue KPI for field service operations and cost recovery analysis."
    - name: "avg_service_fee_amount"
      expr: AVG(CAST(service_fee_amount AS DOUBLE))
      comment: "Average service fee per order — benchmarks pricing adequacy and identifies under-priced service categories."
    - name: "total_sla_actual_hours"
      expr: SUM(CAST(sla_actual_hours AS DOUBLE))
      comment: "Total actual hours consumed across all orders — measures aggregate field labor demand for workforce planning."
    - name: "avg_sla_actual_hours"
      expr: AVG(CAST(sla_actual_hours AS DOUBLE))
      comment: "Average actual resolution time in hours per order — key efficiency KPI; rising averages signal resource constraints or complexity increases."
    - name: "emergency_order_count"
      expr: COUNT(CASE WHEN priority = 'Emergency' THEN order_id END)
      comment: "Number of emergency-priority orders — tracks unplanned demand spikes that drive overtime costs and SLA risk."
    - name: "cancelled_order_count"
      expr: COUNT(CASE WHEN order_status = 'Cancelled' THEN order_id END)
      comment: "Number of cancelled orders — measures scheduling inefficiency and customer-initiated cancellations that waste field capacity."
    - name: "billable_order_count"
      expr: COUNT(CASE WHEN billable_flag = TRUE THEN order_id END)
      comment: "Number of billable service orders — used to calculate cost-recovery ratio and identify non-revenue-generating workload."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`service_connection_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Growth and revenue KPIs for new service connection applications — tracks application pipeline, fee revenue, approval rates, and infrastructure upgrade demand to inform capacity investment and growth planning."
  source: "`water_utilities_ecm`.`service`.`connection_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the connection application (e.g., Pending, Approved, Rejected) — primary pipeline health dimension."
    - name: "application_type"
      expr: application_type
      comment: "Type of connection being applied for (e.g., New Service, Upgrade, Temporary) — segments growth demand by service category."
    - name: "property_type"
      expr: property_type
      comment: "Type of property requesting connection (e.g., Residential, Commercial, Industrial) — drives capacity planning and rate classification."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of application fees — used to track fee collection efficiency and identify revenue leakage."
    - name: "infrastructure_upgrade_required"
      expr: infrastructure_upgrade_required
      comment: "Flag indicating whether the connection requires infrastructure upgrades — critical input for CIP project prioritization and capital budgeting."
    - name: "capacity_available"
      expr: capacity_available
      comment: "Flag indicating whether system capacity is available to serve the application — used to identify constrained zones requiring investment."
    - name: "application_date"
      expr: DATE_TRUNC('month', application_date)
      comment: "Month the application was submitted — enables trend analysis of new connection demand and growth forecasting."
    - name: "approval_date"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month the application was approved — measures processing cycle time and approval pipeline throughput."
    - name: "service_state"
      expr: service_state
      comment: "State where the service connection is requested — geographic segmentation for growth and regulatory reporting."
  measures:
    - name: "total_application_count"
      expr: COUNT(1)
      comment: "Total number of connection applications submitted — primary growth demand indicator used in capacity and revenue planning."
    - name: "approved_application_count"
      expr: COUNT(CASE WHEN application_status = 'Approved' THEN connection_application_id END)
      comment: "Number of approved connection applications — measures conversion of demand into new service connections and revenue."
    - name: "rejected_application_count"
      expr: COUNT(CASE WHEN application_status = 'Rejected' THEN connection_application_id END)
      comment: "Number of rejected applications — identifies capacity constraints, compliance barriers, or process inefficiencies limiting growth."
    - name: "total_connection_fee_revenue"
      expr: SUM(CAST(connection_fee_amount AS DOUBLE))
      comment: "Total connection fee revenue collected — direct revenue KPI for new service growth; funds infrastructure expansion."
    - name: "total_application_fee_revenue"
      expr: SUM(CAST(application_fee_amount AS DOUBLE))
      comment: "Total application fee revenue — measures administrative cost recovery from the connection application process."
    - name: "total_capacity_charge_revenue"
      expr: SUM(CAST(capacity_charge_amount AS DOUBLE))
      comment: "Total capacity charge revenue — funds system capacity expansion; key metric for infrastructure investment cost recovery."
    - name: "total_fees_assessed"
      expr: SUM(CAST(total_fees_assessed AS DOUBLE))
      comment: "Total fees assessed across all connection applications — aggregate revenue potential from the new connection pipeline."
    - name: "avg_connection_fee_amount"
      expr: AVG(CAST(connection_fee_amount AS DOUBLE))
      comment: "Average connection fee per application — benchmarks fee adequacy against infrastructure cost recovery targets."
    - name: "infrastructure_upgrade_required_count"
      expr: COUNT(CASE WHEN infrastructure_upgrade_required = TRUE THEN connection_application_id END)
      comment: "Number of applications requiring infrastructure upgrades — directly drives CIP project scope and capital budget requirements."
    - name: "avg_estimated_flow_demand_gpm"
      expr: AVG(CAST(estimated_flow_demand_gpm AS DOUBLE))
      comment: "Average estimated flow demand in gallons per minute across applications — used to assess aggregate system capacity impact of pending connections."
    - name: "total_estimated_flow_demand_gpm"
      expr: SUM(CAST(estimated_flow_demand_gpm AS DOUBLE))
      comment: "Total estimated flow demand from all pending/approved applications — critical input for hydraulic capacity planning and treatment plant load forecasting."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`service_conservation_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Effectiveness and financial KPIs for water conservation programs — tracks water savings performance, incentive spend efficiency, and budget utilization to steer conservation investment and regulatory compliance."
  source: "`water_utilities_ecm`.`service`.`conservation_program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current status of the conservation program (e.g., Active, Completed, Suspended) — primary filter for portfolio health analysis."
    - name: "program_type"
      expr: program_type
      comment: "Type of conservation program (e.g., Rebate, Audit, Education) — segments effectiveness analysis by intervention strategy."
    - name: "program_category"
      expr: program_category
      comment: "Category of the conservation program (e.g., Residential, Commercial, Industrial) — enables customer-segment-level conservation performance analysis."
    - name: "incentive_type"
      expr: incentive_type
      comment: "Type of incentive offered (e.g., Rebate, Bill Credit, Equipment) — used to compare cost-effectiveness of different incentive mechanisms."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of program funding (e.g., Rate Revenue, Grant, State Fund) — supports fund accountability and grant compliance reporting."
    - name: "regulatory_mandate_flag"
      expr: regulatory_mandate_flag
      comment: "Indicates whether the program is mandated by a regulatory requirement — separates compliance-driven spend from discretionary conservation investment."
    - name: "program_start_date"
      expr: DATE_TRUNC('year', program_start_date)
      comment: "Year the program started — enables vintage analysis of conservation program portfolio and long-term savings trend tracking."
    - name: "customer_class_applicability"
      expr: customer_class_applicability
      comment: "Customer class the program applies to — used to assess conservation equity and target under-served segments."
  measures:
    - name: "total_actual_water_savings_gallons"
      expr: SUM(CAST(actual_water_savings_gallons AS DOUBLE))
      comment: "Total actual water savings achieved across all programs in gallons — primary conservation outcome KPI used in regulatory reporting and drought management."
    - name: "total_target_water_savings_gallons"
      expr: SUM(CAST(target_water_savings_gallons AS DOUBLE))
      comment: "Total targeted water savings across all programs — denominator for savings attainment rate; measures ambition vs. achievement."
    - name: "total_program_budget"
      expr: SUM(CAST(total_program_budget AS DOUBLE))
      comment: "Total budgeted spend across all conservation programs — used in cost-per-gallon-saved efficiency analysis and budget planning."
    - name: "total_budget_expended"
      expr: SUM(CAST(budget_expended_to_date AS DOUBLE))
      comment: "Total budget expended to date across all programs — measures financial execution rate and identifies under-spending that risks program goals."
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive value offered per program unit — aggregate incentive liability across the conservation portfolio."
    - name: "avg_incentive_amount"
      expr: AVG(CAST(incentive_amount AS DOUBLE))
      comment: "Average incentive amount per program — benchmarks incentive generosity and informs program design for cost-effectiveness."
    - name: "total_maximum_incentive_per_customer"
      expr: SUM(CAST(maximum_incentive_per_customer AS DOUBLE))
      comment: "Total maximum incentive exposure per customer across all programs — measures maximum financial liability for incentive payouts."
    - name: "active_program_count"
      expr: COUNT(CASE WHEN program_status = 'Active' THEN conservation_program_id END)
      comment: "Number of currently active conservation programs — measures breadth of conservation portfolio available to customers."
    - name: "regulatory_mandated_program_count"
      expr: COUNT(CASE WHEN regulatory_mandate_flag = TRUE THEN conservation_program_id END)
      comment: "Number of programs driven by regulatory mandate — tracks compliance program coverage for regulatory reporting and audit readiness."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`service_affordability_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equity and regulatory KPIs for customer affordability plans — tracks plan portfolio, discount exposure, benefit capacity, and regulatory compliance to steer low-income assistance program management."
  source: "`water_utilities_ecm`.`service`.`affordability_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the affordability plan (e.g., Active, Expired, Pending) — primary filter for active program portfolio analysis."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of affordability plan (e.g., LIRA, PIPP, Senior Discount) — segments benefit analysis by program design."
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount offered (e.g., Fixed Amount, Percentage, Tiered) — used to compare cost and equity impact of different discount structures."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of funding for the affordability plan — supports fund accountability and grant compliance reporting."
    - name: "regulatory_mandate_flag"
      expr: regulatory_mandate_flag
      comment: "Indicates whether the plan is required by regulation — separates compliance-driven programs from discretionary utility initiatives."
    - name: "auto_enrollment_flag"
      expr: auto_enrollment_flag
      comment: "Indicates whether customers are automatically enrolled — measures reach efficiency; auto-enrollment plans typically achieve higher participation."
    - name: "recertification_required_flag"
      expr: recertification_required_flag
      comment: "Indicates whether periodic recertification is required — impacts administrative burden and enrollment retention rates."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year the affordability plan became effective — enables vintage analysis of the plan portfolio and regulatory approval timelines."
    - name: "eligibility_income_threshold_basis"
      expr: eligibility_income_threshold_basis
      comment: "Basis for income eligibility threshold (e.g., Federal Poverty Level, Area Median Income) — used to assess equity and coverage breadth of affordability programs."
  measures:
    - name: "active_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'Active' THEN affordability_plan_id END)
      comment: "Number of currently active affordability plans — measures breadth of low-income assistance portfolio available to eligible customers."
    - name: "total_maximum_benefit_amount"
      expr: SUM(CAST(maximum_benefit_amount AS DOUBLE))
      comment: "Total maximum benefit value across all affordability plans — measures aggregate financial assistance capacity and maximum program liability."
    - name: "avg_maximum_benefit_amount"
      expr: AVG(CAST(maximum_benefit_amount AS DOUBLE))
      comment: "Average maximum benefit per plan — benchmarks benefit adequacy against affordability targets and peer utility programs."
    - name: "total_discount_fixed_amount"
      expr: SUM(CAST(discount_fixed_amount AS DOUBLE))
      comment: "Total fixed discount value across all plans — measures aggregate rate relief provided to low-income customers."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across plans — benchmarks rate relief generosity and informs rate design equity analysis."
    - name: "avg_eligibility_income_threshold_percent"
      expr: AVG(CAST(eligibility_income_threshold_percent AS DOUBLE))
      comment: "Average income threshold percentage (e.g., % of Federal Poverty Level) across plans — measures how broadly or narrowly eligibility is defined across the portfolio."
    - name: "regulatory_mandated_plan_count"
      expr: COUNT(CASE WHEN regulatory_mandate_flag = TRUE THEN affordability_plan_id END)
      comment: "Number of affordability plans required by regulation — tracks compliance program coverage for regulatory audit and reporting."
    - name: "auto_enrollment_plan_count"
      expr: COUNT(CASE WHEN auto_enrollment_flag = TRUE THEN affordability_plan_id END)
      comment: "Number of plans with automatic enrollment — measures program reach efficiency; higher auto-enrollment reduces participation barriers for vulnerable customers."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`service_point`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Infrastructure and demand KPIs for service points — tracks active connection inventory, AMI adoption, demand profile, and backflow compliance to support asset management and capacity planning decisions."
  source: "`water_utilities_ecm`.`service`.`point`"
  dimensions:
    - name: "service_point_status"
      expr: service_point_status
      comment: "Current status of the service point (e.g., Active, Inactive, Disconnected) — primary filter for active infrastructure inventory analysis."
    - name: "service_type"
      expr: service_type
      comment: "Type of service delivered at the point (e.g., Potable, Recycled, Fire) — segments demand and infrastructure analysis by service category."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership classification of the service point (e.g., Utility, Customer, Shared) — used in asset responsibility and maintenance cost allocation."
    - name: "ami_enabled"
      expr: ami_enabled
      comment: "Indicates whether the service point has AMI (Advanced Metering Infrastructure) — tracks smart meter deployment progress and data quality coverage."
    - name: "backflow_prevention_required"
      expr: backflow_prevention_required
      comment: "Indicates whether backflow prevention is required at this point — used to track compliance with cross-connection control regulations."
    - name: "fire_service_indicator"
      expr: fire_service_indicator
      comment: "Indicates whether the point serves fire protection — critical for fire flow compliance and infrastructure reliability planning."
    - name: "service_state"
      expr: service_state
      comment: "State where the service point is located — geographic segmentation for infrastructure inventory and regulatory reporting."
    - name: "activation_date"
      expr: DATE_TRUNC('year', activation_date)
      comment: "Year the service point was activated — enables vintage analysis of infrastructure age and replacement planning."
    - name: "service_city"
      expr: service_city
      comment: "City where the service point is located — geographic segmentation for local demand and infrastructure planning."
  measures:
    - name: "active_service_point_count"
      expr: COUNT(CASE WHEN service_point_status = 'Active' THEN point_id END)
      comment: "Number of active service points — primary infrastructure inventory KPI used in capacity planning and revenue base analysis."
    - name: "ami_enabled_count"
      expr: COUNT(CASE WHEN ami_enabled = TRUE THEN point_id END)
      comment: "Number of service points with AMI enabled — tracks smart meter deployment progress; AMI coverage drives billing accuracy and leak detection capability."
    - name: "total_estimated_daily_demand_gallons"
      expr: SUM(CAST(estimated_daily_demand_gallons AS DOUBLE))
      comment: "Total estimated daily water demand across all active service points in gallons — primary system load KPI for treatment plant and distribution capacity planning."
    - name: "avg_estimated_daily_demand_gallons"
      expr: AVG(CAST(estimated_daily_demand_gallons AS DOUBLE))
      comment: "Average estimated daily demand per service point — benchmarks per-connection consumption for rate design and conservation program targeting."
    - name: "total_peak_demand_gpm"
      expr: SUM(CAST(peak_demand_gpm AS DOUBLE))
      comment: "Total peak demand in gallons per minute across all service points — critical input for hydraulic model calibration and fire flow adequacy assessment."
    - name: "avg_connection_size_inches"
      expr: AVG(CAST(connection_size_inches AS DOUBLE))
      comment: "Average connection size in inches across service points — used to assess infrastructure capacity profile and identify undersized connections."
    - name: "backflow_prevention_required_count"
      expr: COUNT(CASE WHEN backflow_prevention_required = TRUE THEN point_id END)
      comment: "Number of service points requiring backflow prevention — measures cross-connection control compliance scope and inspection workload."
    - name: "fire_service_point_count"
      expr: COUNT(CASE WHEN fire_service_indicator = TRUE THEN point_id END)
      comment: "Number of service points designated for fire protection — used in fire flow compliance reporting and infrastructure reliability planning."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`service_tariff`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate governance and revenue requirement KPIs for tariffs — tracks rate base, revenue requirements, return on investment, and tariff lifecycle to support rate case management and regulatory compliance decisions."
  source: "`water_utilities_ecm`.`service`.`tariff`"
  dimensions:
    - name: "tariff_status"
      expr: tariff_status
      comment: "Current status of the tariff (e.g., Active, Superseded, Pending) — primary filter for current rate schedule analysis."
    - name: "tariff_type"
      expr: tariff_type
      comment: "Type of tariff (e.g., Residential, Commercial, Industrial, Wholesale) — segments rate analysis by customer class."
    - name: "rate_structure_type"
      expr: rate_structure_type
      comment: "Rate structure design (e.g., Flat, Tiered, Inclining Block) — used to evaluate rate design equity and conservation incentive effectiveness."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory body that approved the tariff — used for multi-jurisdiction rate governance and compliance tracking."
    - name: "conservation_rate_flag"
      expr: conservation_rate_flag
      comment: "Indicates whether the tariff includes conservation rate design — tracks adoption of conservation-oriented pricing structures."
    - name: "low_income_assistance_flag"
      expr: low_income_assistance_flag
      comment: "Indicates whether the tariff includes low-income assistance provisions — used in affordability and equity analysis."
    - name: "effective_date"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the tariff became effective — enables rate history and rate case cycle analysis."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Frequency of billing under this tariff (e.g., Monthly, Bi-Monthly) — used in revenue timing and cash-flow analysis."
  measures:
    - name: "active_tariff_count"
      expr: COUNT(CASE WHEN tariff_status = 'Active' THEN tariff_id END)
      comment: "Number of currently active tariffs — measures rate schedule complexity and governance scope across the utility."
    - name: "total_revenue_requirement_amount"
      expr: SUM(CAST(revenue_requirement_amount AS DOUBLE))
      comment: "Total revenue requirement across all active tariffs — the authorized revenue the utility must collect; primary financial planning KPI for rate case management."
    - name: "avg_revenue_requirement_amount"
      expr: AVG(CAST(revenue_requirement_amount AS DOUBLE))
      comment: "Average revenue requirement per tariff — benchmarks rate case size and identifies tariffs with disproportionate revenue concentration."
    - name: "total_rate_base_amount"
      expr: SUM(CAST(rate_base_amount AS DOUBLE))
      comment: "Total rate base across all tariffs — the invested capital on which the utility earns its authorized return; core regulatory finance KPI."
    - name: "avg_rate_of_return_percent"
      expr: AVG(CAST(rate_of_return_percent AS DOUBLE))
      comment: "Average authorized rate of return across tariffs — measures regulatory-approved profitability; deviations from authorized return trigger rate case filings."
    - name: "total_base_rate_amount"
      expr: SUM(CAST(base_rate_amount AS DOUBLE))
      comment: "Total base rate revenue across all tariffs — measures fixed revenue component independent of consumption; used in revenue stability analysis."
    - name: "avg_minimum_charge_amount"
      expr: AVG(CAST(minimum_charge_amount AS DOUBLE))
      comment: "Average minimum monthly charge across tariffs — benchmarks fixed cost recovery adequacy and low-usage customer revenue floor."
    - name: "conservation_rate_tariff_count"
      expr: COUNT(CASE WHEN conservation_rate_flag = TRUE THEN tariff_id END)
      comment: "Number of tariffs with conservation rate design — tracks adoption of tiered/inclining block pricing that incentivizes water conservation."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`service_program_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Conservation program participation and incentive KPIs — tracks enrollment pipeline, active participation, incentive deployment, and program retention to steer conservation program effectiveness and customer engagement."
  source: "`water_utilities_ecm`.`service`.`program_enrollment`"
  dimensions:
    - name: "program_enrollment_status"
      expr: program_enrollment_status
      comment: "Current status of the enrollment (e.g., Active, Expired, Withdrawn) — primary filter for active participation analysis."
    - name: "enrollment_date"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month of enrollment — enables cohort analysis of program participation trends and seasonal enrollment patterns."
    - name: "expiration_date"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month of enrollment expiration — used to forecast renewal pipeline and identify at-risk enrollments requiring recertification outreach."
    - name: "certification_date"
      expr: DATE_TRUNC('month', certification_date)
      comment: "Month of enrollment certification — tracks certification processing throughput and identifies administrative bottlenecks."
  measures:
    - name: "total_enrollment_count"
      expr: COUNT(1)
      comment: "Total number of program enrollments — baseline participation KPI for conservation program reach and customer engagement."
    - name: "active_enrollment_count"
      expr: COUNT(CASE WHEN program_enrollment_status = 'Active' THEN program_enrollment_id END)
      comment: "Number of currently active program enrollments — measures live conservation program participation driving actual water savings."
    - name: "total_incentive_amount_applied"
      expr: SUM(CAST(incentive_amount_applied AS DOUBLE))
      comment: "Total incentive value applied to enrolled customers — measures actual financial benefit delivered; key metric for program cost-effectiveness analysis."
    - name: "avg_incentive_amount_applied"
      expr: AVG(CAST(incentive_amount_applied AS DOUBLE))
      comment: "Average incentive amount applied per enrollment — benchmarks per-customer benefit delivery and identifies programs with low incentive utilization."
    - name: "distinct_program_count"
      expr: COUNT(DISTINCT conservation_program_id)
      comment: "Number of distinct conservation programs with at least one enrollment — measures active program portfolio breadth and customer choice availability."
    - name: "distinct_agreement_count"
      expr: COUNT(DISTINCT agreement_id)
      comment: "Number of distinct service agreements enrolled in conservation programs — measures customer penetration of conservation programs across the customer base."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`service_sla_definition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA governance and performance standard KPIs — tracks SLA target values, compliance thresholds, penalty exposure, and regulatory coverage to support service quality management and regulatory compliance decisions."
  source: "`water_utilities_ecm`.`service`.`sla_definition`"
  dimensions:
    - name: "sla_type"
      expr: sla_type
      comment: "Type of SLA (e.g., Response Time, Restoration Time, Water Quality) — primary segmentation for service quality standard analysis."
    - name: "sla_definition_status"
      expr: sla_definition_status
      comment: "Current status of the SLA definition (e.g., Active, Superseded, Draft) — filters to current governing service standards."
    - name: "penalty_type"
      expr: penalty_type
      comment: "Type of penalty for SLA breach (e.g., Financial, Regulatory, Service Credit) — used to assess financial risk exposure from non-compliance."
    - name: "measurement_frequency"
      expr: measurement_frequency
      comment: "Frequency at which SLA compliance is measured (e.g., Daily, Monthly, Quarterly) — used to align reporting cadence with regulatory requirements."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the SLA (e.g., System-Wide, Zone, Territory) — enables spatial analysis of service quality commitments."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year the SLA definition became effective — enables tracking of service standard evolution over time."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the SLA metric (e.g., Hours, PSI, NTU) — provides context for interpreting target and compliance values."
  measures:
    - name: "active_sla_count"
      expr: COUNT(CASE WHEN sla_definition_status = 'Active' THEN sla_definition_id END)
      comment: "Number of currently active SLA definitions — measures the scope of service quality commitments the utility is contractually and regulatorily bound to."
    - name: "avg_compliance_percentage"
      expr: AVG(CAST(compliance_percentage AS DOUBLE))
      comment: "Average compliance percentage across all SLA definitions — headline service quality KPI; below-target values trigger regulatory scrutiny and penalty risk."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average SLA target value across definitions — used to benchmark service standard stringency against industry norms and regulatory requirements."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount defined across all SLA definitions — measures maximum financial exposure from SLA non-compliance; critical for risk management reporting."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per SLA definition — benchmarks penalty severity and prioritizes which SLAs carry the highest compliance risk."
    - name: "sla_with_penalty_count"
      expr: COUNT(CASE WHEN penalty_amount > 0 THEN sla_definition_id END)
      comment: "Number of SLA definitions with a financial penalty — measures the proportion of service commitments carrying direct financial consequences for non-compliance."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`service_territory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Geographic service territory KPIs — tracks service area coverage, demand profile, customer density, and franchise status to support territorial expansion, regulatory reporting, and capacity planning decisions."
  source: "`water_utilities_ecm`.`service`.`territory`"
  dimensions:
    - name: "territory_status"
      expr: territory_status
      comment: "Current status of the territory (e.g., Active, Inactive, Pending) — primary filter for active service area analysis."
    - name: "territory_type"
      expr: territory_type
      comment: "Type of territory (e.g., Municipal, Unincorporated, Industrial Park) — segments service area analysis by governance and customer profile."
    - name: "service_classification"
      expr: service_classification
      comment: "Service classification of the territory (e.g., Urban, Suburban, Rural) — used in infrastructure investment prioritization and rate equity analysis."
    - name: "state_code"
      expr: state_code
      comment: "State code of the territory — geographic segmentation for multi-state utility regulatory and operational reporting."
    - name: "potable_water_service_flag"
      expr: potable_water_service_flag
      comment: "Indicates whether potable water service is provided in the territory — used to define service scope for regulatory reporting."
    - name: "recycled_water_service_flag"
      expr: recycled_water_service_flag
      comment: "Indicates whether recycled water service is provided — tracks water reuse program geographic coverage."
    - name: "wastewater_service_flag"
      expr: wastewater_service_flag
      comment: "Indicates whether wastewater service is provided — used to identify integrated water/wastewater service territories for bundled rate analysis."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year the territory became effective — enables analysis of territorial expansion history and franchise acquisition timeline."
  measures:
    - name: "active_territory_count"
      expr: COUNT(CASE WHEN territory_status = 'Active' THEN territory_id END)
      comment: "Number of active service territories — measures geographic service footprint; used in regulatory reporting and franchise management."
    - name: "total_area_square_miles"
      expr: SUM(CAST(area_square_miles AS DOUBLE))
      comment: "Total service area in square miles across all territories — measures geographic coverage scope for infrastructure density and expansion planning."
    - name: "total_average_daily_demand_mgd"
      expr: SUM(CAST(average_daily_demand_mgd AS DOUBLE))
      comment: "Total average daily water demand in million gallons per day across all territories — primary system load KPI for treatment and distribution capacity planning."
    - name: "total_peak_daily_demand_mgd"
      expr: SUM(CAST(peak_daily_demand_mgd AS DOUBLE))
      comment: "Total peak daily demand in million gallons per day — critical for infrastructure sizing, emergency response planning, and drought contingency analysis."
    - name: "avg_average_daily_demand_mgd"
      expr: AVG(CAST(average_daily_demand_mgd AS DOUBLE))
      comment: "Average daily demand per territory in MGD — benchmarks territory-level demand intensity for equitable infrastructure investment allocation."
    - name: "recycled_water_territory_count"
      expr: COUNT(CASE WHEN recycled_water_service_flag = TRUE THEN territory_id END)
      comment: "Number of territories with recycled water service — tracks water reuse program geographic penetration; key sustainability and regulatory reporting metric."
    - name: "integrated_service_territory_count"
      expr: COUNT(CASE WHEN potable_water_service_flag = TRUE AND wastewater_service_flag = TRUE THEN territory_id END)
      comment: "Number of territories with both potable water and wastewater service — measures integrated utility service scope for bundled rate and regulatory reporting."
$$;