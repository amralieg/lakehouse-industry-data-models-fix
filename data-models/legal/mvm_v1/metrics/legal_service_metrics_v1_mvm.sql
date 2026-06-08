-- Metric views for domain: service | Business: Legal | Version: 1 | Generated on: 2026-05-07 14:29:57

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`service_legal_service`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core KPI layer over the legal service catalogue. Tracks service portfolio composition, standard rate economics, estimated delivery effort, and AFA/billability flags to support pricing strategy, portfolio governance, and service line investment decisions."
  source: "`legal_ecm`.`service`.`legal_service`"
  filter: service_status = 'Active'
  dimensions:
    - name: "service_type"
      expr: service_type
      comment: "Classifies the legal service by type (e.g. Advisory, Litigation, Transactional) for portfolio segmentation."
    - name: "service_category"
      expr: service_category
      comment: "Broad category grouping for the service, enabling roll-up analysis across the service catalogue."
    - name: "practice_area"
      expr: practice_area
      comment: "Practice area associated with the legal service, used to slice KPIs by legal discipline."
    - name: "required_expertise_level"
      expr: required_expertise_level
      comment: "Seniority or expertise level required to deliver the service, informing staffing and rate benchmarking."
    - name: "allows_afa"
      expr: allows_afa
      comment: "Indicates whether the service supports Alternative Fee Arrangements, a key pricing strategy dimension."
    - name: "is_billable"
      expr: is_billable
      comment: "Flags whether the service generates billable revenue, separating revenue-generating from non-billable work."
    - name: "requires_conflict_check"
      expr: requires_conflict_check
      comment: "Indicates whether a conflict-of-interest check is mandatory before engagement, relevant to risk and intake governance."
    - name: "requires_kyc"
      expr: requires_kyc
      comment: "Flags services requiring Know-Your-Client compliance, supporting regulatory risk segmentation."
    - name: "service_status"
      expr: service_status
      comment: "Lifecycle status of the service (Active, Deprecated, Draft), used to filter active portfolio views."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the service standard rate is denominated, enabling multi-currency portfolio analysis."
    - name: "effective_date"
      expr: effective_date
      comment: "Date from which the service became effective, used for cohort and vintage analysis of the service catalogue."
  measures:
    - name: "total_active_services"
      expr: COUNT(1)
      comment: "Total number of active legal services in the catalogue. Baseline portfolio size KPI used in capacity planning and service rationalisation reviews."
    - name: "total_standard_rate"
      expr: SUM(CAST(standard_rate AS DOUBLE))
      comment: "Sum of standard rates across all services. Used as a proxy for total listed rate exposure and pricing portfolio value."
    - name: "avg_standard_rate"
      expr: AVG(CAST(standard_rate AS DOUBLE))
      comment: "Average standard rate across active services. Tracks pricing level trends and benchmarks rate competitiveness across practice areas."
    - name: "avg_estimated_duration_hours"
      expr: AVG(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Average estimated delivery effort in hours per service. Informs capacity planning, staffing models, and profitability analysis."
    - name: "total_estimated_duration_hours"
      expr: SUM(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Total estimated delivery hours across all active services. Supports aggregate capacity demand forecasting."
    - name: "afa_eligible_service_count"
      expr: COUNT(CASE WHEN allows_afa = TRUE THEN 1 END)
      comment: "Number of services that support Alternative Fee Arrangements. Tracks AFA adoption breadth across the service portfolio, a key client-value and pricing strategy metric."
    - name: "afa_eligibility_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN allows_afa = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of active services that allow AFA. Measures the firm's flexibility in pricing models — a strategic indicator for client retention and competitive positioning."
    - name: "kyc_required_service_count"
      expr: COUNT(CASE WHEN requires_kyc = TRUE THEN 1 END)
      comment: "Number of services requiring KYC compliance. Quantifies the regulatory compliance burden across the service portfolio."
    - name: "conflict_check_required_service_count"
      expr: COUNT(CASE WHEN requires_conflict_check = TRUE THEN 1 END)
      comment: "Number of services mandating a conflict-of-interest check. Supports risk governance and intake process planning."
    - name: "billable_service_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_billable = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of active services that are billable. A portfolio health indicator — low billable rates signal revenue leakage or excessive non-billable service proliferation."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`service_pricing_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over pricing model configurations. Tracks rate economics, fee structure diversity, AFA adoption, discount levels, and retainer commitments to support pricing governance, profitability management, and client negotiation strategy."
  source: "`legal_ecm`.`service`.`pricing_model`"
  filter: pricing_model_status = 'Active'
  dimensions:
    - name: "model_type"
      expr: model_type
      comment: "Type of pricing model (e.g. Hourly, Fixed Fee, Contingency, Retainer) — primary dimension for pricing strategy analysis."
    - name: "model_name"
      expr: model_name
      comment: "Descriptive name of the pricing model for business-readable reporting."
    - name: "calculation_basis"
      expr: calculation_basis
      comment: "Basis on which fees are calculated (e.g. time-and-materials, milestone, outcome), informing pricing structure governance."
    - name: "afa_indicator"
      expr: afa_indicator
      comment: "Flags whether the pricing model is an Alternative Fee Arrangement, enabling AFA portfolio tracking."
    - name: "advance_payment_required"
      expr: advance_payment_required
      comment: "Indicates whether advance payment is required, relevant to cash flow and client credit risk management."
    - name: "approval_required"
      expr: approval_required
      comment: "Flags whether partner or management approval is required before applying this pricing model."
    - name: "rate_currency_code"
      expr: rate_currency_code
      comment: "Currency of the pricing model rates, enabling multi-currency pricing analysis."
    - name: "pricing_model_status"
      expr: pricing_model_status
      comment: "Lifecycle status of the pricing model (Active, Archived, Draft)."
    - name: "retainer_frequency"
      expr: retainer_frequency
      comment: "Frequency of retainer billing (Monthly, Quarterly, Annual), used to analyse recurring revenue structures."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Date from which the pricing model became effective, used for vintage and trend analysis."
  measures:
    - name: "total_pricing_models"
      expr: COUNT(1)
      comment: "Total number of active pricing models. Baseline measure for pricing model portfolio breadth and governance reviews."
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate_amount AS DOUBLE))
      comment: "Average base rate amount across active pricing models. Tracks rate level trends and supports competitive benchmarking."
    - name: "avg_blended_rate"
      expr: AVG(CAST(blended_rate_amount AS DOUBLE))
      comment: "Average blended rate across pricing models. A key profitability indicator reflecting the effective rate after staffing mix adjustments."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied across pricing models. Tracks pricing concession levels — rising averages signal margin pressure or aggressive client negotiations."
    - name: "avg_contingency_percentage"
      expr: AVG(CAST(contingency_percentage AS DOUBLE))
      comment: "Average contingency fee percentage across applicable models. Measures risk-sharing exposure in outcome-based fee arrangements."
    - name: "total_retainer_amount"
      expr: SUM(CAST(retainer_amount AS DOUBLE))
      comment: "Total retainer amounts committed across active pricing models. Represents the recurring revenue base secured through retainer arrangements."
    - name: "avg_retainer_amount"
      expr: AVG(CAST(retainer_amount AS DOUBLE))
      comment: "Average retainer amount per pricing model. Benchmarks retainer deal size and informs retainer pricing strategy."
    - name: "avg_minimum_fee"
      expr: AVG(CAST(minimum_fee_amount AS DOUBLE))
      comment: "Average minimum fee floor across pricing models. Ensures the firm maintains minimum revenue thresholds per engagement."
    - name: "avg_maximum_fee"
      expr: AVG(CAST(maximum_fee_amount AS DOUBLE))
      comment: "Average maximum fee cap across pricing models. Tracks fee ceiling exposure relevant to fixed-fee and capped-fee risk management."
    - name: "afa_model_count"
      expr: COUNT(CASE WHEN afa_indicator = TRUE THEN 1 END)
      comment: "Number of active AFA pricing models. Tracks the breadth of alternative fee adoption — a strategic indicator of client-centric pricing maturity."
    - name: "afa_model_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN afa_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of active pricing models that are AFA. Measures AFA penetration in the pricing portfolio — a key strategic and competitive positioning metric."
    - name: "avg_expense_markup_percentage"
      expr: AVG(CAST(expense_markup_percentage AS DOUBLE))
      comment: "Average expense markup percentage across pricing models. Tracks cost recovery rates on disbursements and expenses, directly impacting matter profitability."
    - name: "avg_success_fee_amount"
      expr: AVG(CAST(success_fee_amount AS DOUBLE))
      comment: "Average success fee amount across applicable pricing models. Quantifies outcome-based upside exposure in contingency and hybrid fee structures."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`service_rate_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over rate card configurations. Tracks hourly rate levels, discount structures, rate caps and floors, and billing guideline compliance to support rate governance, client negotiation, and profitability management."
  source: "`legal_ecm`.`service`.`rate_card`"
  filter: is_active = TRUE
  dimensions:
    - name: "rate_type"
      expr: rate_type
      comment: "Type of rate (e.g. Standard, Negotiated, Blended, Pro Bono) — primary dimension for rate structure analysis."
    - name: "seniority_level"
      expr: seniority_level
      comment: "Seniority level of the timekeeper (e.g. Partner, Associate, Paralegal) — critical for rate benchmarking and staffing economics."
    - name: "client_segment"
      expr: client_segment
      comment: "Client segment to which the rate card applies, enabling rate differentiation analysis by client tier."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction for which the rate card is applicable, supporting geographic rate governance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rate card, enabling multi-currency rate analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the rate card (Approved, Pending, Rejected), used to filter governance-ready rates."
    - name: "billing_guideline_compliant"
      expr: billing_guideline_compliant
      comment: "Indicates whether the rate card complies with client billing guidelines — a key risk and compliance dimension."
    - name: "is_default_rate"
      expr: is_default_rate
      comment: "Flags whether this is the default rate card for the associated service/tier combination."
    - name: "office_location_code"
      expr: office_location_code
      comment: "Office location associated with the rate card, enabling geographic rate benchmarking."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Effective start date of the rate card, used for rate vintage and trend analysis."
  measures:
    - name: "total_active_rate_cards"
      expr: COUNT(1)
      comment: "Total number of active rate cards. Baseline measure for rate card portfolio breadth and governance coverage."
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate across active rate cards. The primary rate benchmarking KPI — tracks rate level trends by seniority, jurisdiction, and client segment."
    - name: "max_hourly_rate"
      expr: MAX(CAST(hourly_rate AS DOUBLE))
      comment: "Maximum hourly rate in the active rate card portfolio. Identifies rate ceiling exposure and premium rate positioning."
    - name: "min_hourly_rate"
      expr: MIN(CAST(hourly_rate AS DOUBLE))
      comment: "Minimum hourly rate in the active rate card portfolio. Identifies rate floor and potential below-cost pricing risks."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied across active rate cards. Tracks pricing concession levels — a direct margin management KPI."
    - name: "avg_rate_cap_amount"
      expr: AVG(CAST(rate_cap_amount AS DOUBLE))
      comment: "Average rate cap across active rate cards. Measures the average ceiling imposed by client billing guidelines, informing rate negotiation strategy."
    - name: "avg_rate_floor_amount"
      expr: AVG(CAST(rate_floor_amount AS DOUBLE))
      comment: "Average rate floor across active rate cards. Ensures minimum rate thresholds are maintained across the portfolio."
    - name: "billing_guideline_compliant_count"
      expr: COUNT(CASE WHEN billing_guideline_compliant = TRUE THEN 1 END)
      comment: "Number of rate cards compliant with client billing guidelines. Tracks compliance coverage — non-compliant rate cards create invoice rejection and collection risk."
    - name: "billing_guideline_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN billing_guideline_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of active rate cards compliant with billing guidelines. A critical risk KPI — low compliance rates lead to write-downs, invoice disputes, and client relationship damage."
    - name: "rate_headroom_avg"
      expr: AVG(CAST(rate_cap_amount AS DOUBLE) - CAST(hourly_rate AS DOUBLE))
      comment: "Average difference between rate cap and actual hourly rate. Measures pricing headroom available before hitting client-imposed caps — informs rate increase strategy."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`service_practice_area`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over practice area master data. Tracks practice area portfolio composition, average matter economics, CPD requirements, and billability to support strategic investment decisions, resource allocation, and practice group governance."
  source: "`legal_ecm`.`service`.`practice_area`"
  filter: practice_area_status = 'Active'
  dimensions:
    - name: "practice_group"
      expr: practice_group
      comment: "High-level practice group (e.g. Corporate, Litigation, IP) for roll-up analysis of practice area KPIs."
    - name: "classification_type"
      expr: classification_type
      comment: "Classification of the practice area (e.g. Core, Emerging, Niche) — informs strategic investment prioritisation."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in the practice area hierarchy, enabling drill-down from practice group to sub-specialisation."
    - name: "default_billing_arrangement"
      expr: default_billing_arrangement
      comment: "Default billing arrangement for the practice area (Hourly, Fixed, Contingency), used for pricing strategy analysis."
    - name: "billable_flag"
      expr: billable_flag
      comment: "Indicates whether the practice area generates billable revenue."
    - name: "pro_bono_eligible"
      expr: pro_bono_eligible
      comment: "Flags practice areas eligible for pro bono work, supporting CSR and bar compliance reporting."
    - name: "requires_specialization"
      expr: requires_specialization
      comment: "Indicates whether the practice area requires specialist accreditation, informing talent acquisition and development strategy."
    - name: "requires_security_clearance"
      expr: requires_security_clearance
      comment: "Flags practice areas requiring security clearance, relevant to government and defence sector service delivery."
    - name: "jurisdiction_scope"
      expr: jurisdiction_scope
      comment: "Geographic scope of the practice area, enabling jurisdictional coverage analysis."
    - name: "practice_area_status"
      expr: practice_area_status
      comment: "Lifecycle status of the practice area (Active, Inactive, Emerging)."
  measures:
    - name: "total_practice_areas"
      expr: COUNT(1)
      comment: "Total number of active practice areas. Baseline measure for practice portfolio breadth and strategic coverage assessment."
    - name: "avg_matter_value"
      expr: AVG(CAST(average_matter_value AS DOUBLE))
      comment: "Average matter value across practice areas. A key revenue economics KPI — tracks which practice areas command higher matter values, informing investment and growth strategy."
    - name: "total_avg_matter_value_portfolio"
      expr: SUM(CAST(average_matter_value AS DOUBLE))
      comment: "Sum of average matter values across all active practice areas. Represents the aggregate revenue potential of the practice portfolio."
    - name: "avg_cpd_requirement_hours"
      expr: AVG(CAST(cpd_requirement_hours AS DOUBLE))
      comment: "Average Continuing Professional Development hours required across practice areas. Tracks training investment obligations and compliance burden per practice group."
    - name: "total_cpd_requirement_hours"
      expr: SUM(CAST(cpd_requirement_hours AS DOUBLE))
      comment: "Total CPD hours required across all active practice areas. Quantifies the aggregate professional development investment required to maintain practice area accreditations."
    - name: "specialization_required_count"
      expr: COUNT(CASE WHEN requires_specialization = TRUE THEN 1 END)
      comment: "Number of practice areas requiring specialist accreditation. Informs talent strategy — high counts signal significant specialist hiring or development investment needs."
    - name: "specialization_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN requires_specialization = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of active practice areas requiring specialisation. Tracks the complexity and talent intensity of the practice portfolio."
    - name: "pro_bono_eligible_count"
      expr: COUNT(CASE WHEN pro_bono_eligible = TRUE THEN 1 END)
      comment: "Number of practice areas eligible for pro bono work. Supports CSR reporting and bar association compliance tracking."
    - name: "billable_practice_area_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN billable_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of active practice areas that are billable. A portfolio health indicator — non-billable practice areas represent cost centres requiring strategic justification."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`service_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over service line master data. Tracks revenue targets, realization rates, FTE capacity, cross-selling affinity, pro bono allocation, and diversity targets to support service line P&L governance, strategic planning, and resource allocation decisions."
  source: "`legal_ecm`.`service`.`line`"
  filter: line_status = 'Active'
  dimensions:
    - name: "line_name"
      expr: line_name
      comment: "Name of the service line for business-readable reporting and drill-down analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the service line (e.g. National, Regional, Global), enabling geographic performance analysis."
    - name: "billing_model_default"
      expr: billing_model_default
      comment: "Default billing model for the service line (Hourly, Fixed, Contingency), used for pricing strategy segmentation."
    - name: "strategic_priority_level"
      expr: strategic_priority_level
      comment: "Strategic priority classification of the service line (e.g. Core, Growth, Maintain), directly informing investment allocation decisions."
    - name: "market_positioning"
      expr: market_positioning
      comment: "Market positioning descriptor for the service line, used in competitive strategy and business development analysis."
    - name: "client_facing_flag"
      expr: client_facing_flag
      comment: "Indicates whether the service line is directly client-facing, separating revenue-generating from support lines."
    - name: "conflict_sensitivity_level"
      expr: conflict_sensitivity_level
      comment: "Level of conflict-of-interest sensitivity for the service line, informing risk governance and intake controls."
    - name: "line_status"
      expr: line_status
      comment: "Lifecycle status of the service line (Active, Inactive, Sunset)."
    - name: "effective_date"
      expr: effective_date
      comment: "Date from which the service line became effective, used for vintage and trend analysis."
  measures:
    - name: "total_service_lines"
      expr: COUNT(1)
      comment: "Total number of active service lines. Baseline measure for service line portfolio breadth."
    - name: "total_revenue_target_annual"
      expr: SUM(CAST(revenue_target_annual AS DOUBLE))
      comment: "Total annual revenue target across all active service lines. The primary top-line planning KPI — tracks aggregate revenue ambition and informs budget allocation."
    - name: "avg_revenue_target_annual"
      expr: AVG(CAST(revenue_target_annual AS DOUBLE))
      comment: "Average annual revenue target per service line. Benchmarks service line revenue ambition and identifies under-targeted lines."
    - name: "avg_realization_rate_target"
      expr: AVG(CAST(realization_rate_target AS DOUBLE))
      comment: "Average realization rate target across service lines. Tracks the expected ratio of billed to worked fees — a core profitability management KPI."
    - name: "total_fte_count_current"
      expr: SUM(CAST(fte_count_current AS DOUBLE))
      comment: "Total current FTE headcount across active service lines. Measures aggregate capacity deployed and informs workforce planning."
    - name: "avg_fte_count_current"
      expr: AVG(CAST(fte_count_current AS DOUBLE))
      comment: "Average FTE count per service line. Benchmarks staffing levels and identifies over- or under-resourced lines."
    - name: "avg_cross_selling_affinity_score"
      expr: AVG(CAST(cross_selling_affinity_score AS DOUBLE))
      comment: "Average cross-selling affinity score across service lines. Identifies service lines with the highest cross-sell potential — a key business development and revenue growth KPI."
    - name: "avg_pro_bono_allocation_pct"
      expr: AVG(CAST(pro_bono_allocation_percentage AS DOUBLE))
      comment: "Average pro bono allocation percentage across service lines. Tracks the firm's pro bono commitment level for CSR reporting and bar association compliance."
    - name: "total_pro_bono_allocation_pct"
      expr: SUM(CAST(pro_bono_allocation_percentage AS DOUBLE))
      comment: "Sum of pro bono allocation percentages across service lines. Provides an aggregate view of pro bono commitment across the portfolio."
    - name: "avg_diversity_target_pct"
      expr: AVG(CAST(diversity_target_percentage AS DOUBLE))
      comment: "Average diversity target percentage across service lines. Tracks DEI commitments at the service line level — a governance and ESG reporting KPI."
    - name: "avg_matter_value"
      expr: AVG(CAST(average_matter_value AS DOUBLE))
      comment: "Average matter value across service lines. Tracks revenue per matter economics and informs pricing and matter scoping strategy."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`service_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over service package configurations. Tracks package pricing economics, engagement value, cross-sell eligibility, and compliance requirements to support package portfolio governance, pricing strategy, and client segment targeting decisions."
  source: "`legal_ecm`.`service`.`package`"
  filter: active_flag = TRUE
  dimensions:
    - name: "package_type"
      expr: package_type
      comment: "Type of service package (e.g. Fixed-Scope, Retainer, Bundled) — primary dimension for package portfolio analysis."
    - name: "practice_area"
      expr: practice_area
      comment: "Practice area associated with the package, enabling practice-level package portfolio analysis."
    - name: "pricing_basis"
      expr: pricing_basis
      comment: "Basis on which the package is priced (e.g. Fixed, Time-and-Materials, Outcome-based), informing pricing strategy governance."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the package (Approved, Pending, Rejected), used to filter governance-ready packages."
    - name: "cross_sell_eligible_flag"
      expr: cross_sell_eligible_flag
      comment: "Indicates whether the package is eligible for cross-selling, a key business development dimension."
    - name: "requires_conflict_check_flag"
      expr: requires_conflict_check_flag
      comment: "Flags packages requiring conflict-of-interest checks, relevant to risk and intake governance."
    - name: "requires_kyc_flag"
      expr: requires_kyc_flag
      comment: "Flags packages requiring KYC compliance, supporting regulatory risk segmentation."
    - name: "includes_ediscovery_flag"
      expr: includes_ediscovery_flag
      comment: "Indicates whether the package includes e-discovery services, relevant to litigation package analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the package is priced, enabling multi-currency portfolio analysis."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Date from which the package became effective, used for vintage and trend analysis."
  measures:
    - name: "total_active_packages"
      expr: COUNT(1)
      comment: "Total number of active service packages. Baseline measure for package portfolio breadth and governance coverage."
    - name: "avg_base_price"
      expr: AVG(CAST(base_price_amount AS DOUBLE))
      comment: "Average base price across active packages. Tracks package pricing levels and benchmarks value proposition across package types."
    - name: "total_base_price_portfolio"
      expr: SUM(CAST(base_price_amount AS DOUBLE))
      comment: "Total listed base price across all active packages. Represents the aggregate listed value of the package portfolio."
    - name: "avg_engagement_value"
      expr: AVG(CAST(average_engagement_value AS DOUBLE))
      comment: "Average engagement value per package. Tracks realised deal size versus listed price — a key revenue economics and pricing effectiveness KPI."
    - name: "total_engagement_value_portfolio"
      expr: SUM(CAST(average_engagement_value AS DOUBLE))
      comment: "Total average engagement value across all active packages. Represents the aggregate revenue potential of the package portfolio."
    - name: "avg_estimated_hours"
      expr: AVG(CAST(estimated_hours AS DOUBLE))
      comment: "Average estimated delivery hours per package. Informs capacity planning and effective hourly rate calculations for package pricing."
    - name: "implied_effective_hourly_rate"
      expr: ROUND(AVG(CAST(base_price_amount AS DOUBLE)) / NULLIF(AVG(CAST(estimated_hours AS DOUBLE)), 0), 2)
      comment: "Implied effective hourly rate derived from average base price divided by average estimated hours. A critical pricing efficiency KPI — compares package rates against standard hourly rates to assess pricing adequacy."
    - name: "cross_sell_eligible_count"
      expr: COUNT(CASE WHEN cross_sell_eligible_flag = TRUE THEN 1 END)
      comment: "Number of packages eligible for cross-selling. Quantifies the cross-sell opportunity in the package portfolio — a business development KPI."
    - name: "cross_sell_eligibility_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cross_sell_eligible_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of active packages eligible for cross-selling. Measures the breadth of cross-sell opportunity in the package portfolio."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`service_sla_template`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over SLA template configurations. Tracks SLA breach thresholds, fee adjustment exposure, regulatory compliance coverage, and template usage to support service quality governance, client commitment management, and risk mitigation decisions."
  source: "`legal_ecm`.`service`.`sla_template`"
  filter: approval_status = 'Approved'
  dimensions:
    - name: "sla_type"
      expr: sla_type
      comment: "Type of SLA (e.g. Response Time, Turnaround, Availability) — primary dimension for SLA portfolio analysis."
    - name: "matter_complexity"
      expr: matter_complexity
      comment: "Matter complexity level the SLA applies to (Simple, Standard, Complex), enabling complexity-adjusted SLA analysis."
    - name: "practice_area"
      expr: practice_area
      comment: "Practice area associated with the SLA template, enabling practice-level service quality governance."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction for which the SLA template applies, supporting geographic service quality analysis."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates whether the SLA template includes regulatory compliance commitments — a key risk governance dimension."
    - name: "quality_standard"
      expr: quality_standard
      comment: "Quality standard framework referenced by the SLA (e.g. ISO, internal standard), informing quality governance."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of SLA performance reporting to clients (Monthly, Quarterly), relevant to client relationship management."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the SLA template (Approved, Pending, Rejected)."
    - name: "effective_date"
      expr: effective_date
      comment: "Date from which the SLA template became effective, used for vintage and trend analysis."
  measures:
    - name: "total_approved_sla_templates"
      expr: COUNT(1)
      comment: "Total number of approved SLA templates. Baseline measure for SLA governance coverage across the service portfolio."
    - name: "avg_breach_threshold_pct"
      expr: AVG(CAST(breach_threshold_percentage AS DOUBLE))
      comment: "Average SLA breach threshold percentage across templates. Tracks the tolerance level built into SLA commitments — lower thresholds indicate tighter client commitments and higher breach risk."
    - name: "avg_fee_adjustment_pct"
      expr: AVG(CAST(fee_adjustment_percentage AS DOUBLE))
      comment: "Average fee adjustment percentage triggered on SLA breach. Quantifies the financial exposure from SLA failures — a direct revenue risk KPI for service quality management."
    - name: "max_fee_adjustment_pct"
      expr: MAX(CAST(fee_adjustment_percentage AS DOUBLE))
      comment: "Maximum fee adjustment percentage across SLA templates. Identifies the worst-case financial exposure from a single SLA breach event."
    - name: "regulatory_compliant_sla_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Number of SLA templates with regulatory compliance commitments. Tracks the regulatory obligation footprint embedded in service delivery commitments."
    - name: "regulatory_compliant_sla_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of approved SLA templates that include regulatory compliance commitments. A governance KPI — high rates indicate significant regulatory delivery obligations requiring active monitoring."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`service_delivery_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over delivery model configurations. Tracks capacity utilisation targets, FTE requirements, scalability, and ethical wall support to support operational planning, resource allocation, and service delivery governance decisions."
  source: "`legal_ecm`.`service`.`delivery_model`"
  filter: delivery_model_status = 'Active'
  dimensions:
    - name: "model_type"
      expr: model_type
      comment: "Type of delivery model (e.g. On-site, Remote, Hybrid, Managed Service) — primary dimension for delivery model analysis."
    - name: "model_name"
      expr: model_name
      comment: "Name of the delivery model for business-readable reporting."
    - name: "staffing_model"
      expr: staffing_model
      comment: "Staffing approach for the delivery model (e.g. Dedicated, Shared, Flex), informing resource planning."
    - name: "scalability_rating"
      expr: scalability_rating
      comment: "Scalability rating of the delivery model (e.g. High, Medium, Low), used to assess capacity expansion potential."
    - name: "innovation_maturity"
      expr: innovation_maturity
      comment: "Innovation maturity level of the delivery model, informing technology investment and modernisation strategy."
    - name: "technology_enablement"
      expr: technology_enablement
      comment: "Technology enablement level of the delivery model, used to track digital transformation progress."
    - name: "ethical_wall_support"
      expr: ethical_wall_support
      comment: "Indicates whether the delivery model supports ethical walls (information barriers), critical for conflict management in multi-client environments."
    - name: "conflict_check_required"
      expr: conflict_check_required
      comment: "Flags whether conflict checks are required under this delivery model, relevant to risk governance."
    - name: "preferred_matter_size"
      expr: preferred_matter_size
      comment: "Preferred matter size for the delivery model (Small, Mid-market, Large), enabling matter-size segmentation of delivery capacity."
    - name: "delivery_model_status"
      expr: delivery_model_status
      comment: "Lifecycle status of the delivery model (Active, Deprecated, Draft)."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Date from which the delivery model became effective, used for vintage and trend analysis."
  measures:
    - name: "total_active_delivery_models"
      expr: COUNT(1)
      comment: "Total number of active delivery models. Baseline measure for delivery model portfolio breadth and operational coverage."
    - name: "avg_capacity_utilization_target_pct"
      expr: AVG(CAST(capacity_utilization_target_pct AS DOUBLE))
      comment: "Average capacity utilisation target across active delivery models. A core operational efficiency KPI — tracks the planned utilisation level and informs staffing and capacity planning."
    - name: "avg_fte_requirement_min"
      expr: AVG(CAST(fte_requirement_min AS DOUBLE))
      comment: "Average minimum FTE requirement across delivery models. Establishes the baseline staffing floor needed to operate the delivery model portfolio."
    - name: "avg_fte_requirement_max"
      expr: AVG(CAST(fte_requirement_max AS DOUBLE))
      comment: "Average maximum FTE requirement across delivery models. Establishes the peak staffing ceiling for capacity planning and hiring strategy."
    - name: "total_fte_requirement_min"
      expr: SUM(CAST(fte_requirement_min AS DOUBLE))
      comment: "Total minimum FTE requirement across all active delivery models. Quantifies the aggregate minimum staffing demand across the delivery portfolio."
    - name: "total_fte_requirement_max"
      expr: SUM(CAST(fte_requirement_max AS DOUBLE))
      comment: "Total maximum FTE requirement across all active delivery models. Quantifies the aggregate peak staffing demand, informing workforce planning and hiring budgets."
    - name: "fte_requirement_range_avg"
      expr: AVG(CAST(fte_requirement_max AS DOUBLE) - CAST(fte_requirement_min AS DOUBLE))
      comment: "Average FTE requirement range (max minus min) per delivery model. Measures staffing flexibility — wide ranges indicate elastic delivery models that can scale with demand."
    - name: "ethical_wall_support_count"
      expr: COUNT(CASE WHEN ethical_wall_support = TRUE THEN 1 END)
      comment: "Number of delivery models supporting ethical walls. Tracks the firm's capacity to manage information barriers — critical for conflict management in complex multi-client mandates."
    - name: "ethical_wall_support_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ethical_wall_support = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of active delivery models that support ethical walls. A risk governance KPI — low rates indicate limited capacity to handle conflicted matters simultaneously."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`service_tier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over service tier configurations. Tracks base hourly rates, engagement value ranges, response time commitments, and AFA eligibility across tiers to support client segmentation strategy, pricing governance, and service level investment decisions."
  source: "`legal_ecm`.`service`.`tier`"
  filter: tier_status = 'Active'
  dimensions:
    - name: "tier_level"
      expr: tier_level
      comment: "Tier level classification (e.g. Platinum, Gold, Silver, Standard) — primary dimension for client tier analysis."
    - name: "tier_name"
      expr: tier_name
      comment: "Descriptive name of the service tier for business-readable reporting."
    - name: "practice_area"
      expr: practice_area
      comment: "Practice area associated with the tier, enabling practice-level tier economics analysis."
    - name: "afa_eligible_flag"
      expr: afa_eligible_flag
      comment: "Indicates whether the tier supports Alternative Fee Arrangements — a key pricing strategy dimension."
    - name: "kyc_aml_level"
      expr: kyc_aml_level
      comment: "KYC/AML compliance level required for the tier, informing regulatory risk segmentation."
    - name: "data_protection_classification"
      expr: data_protection_classification
      comment: "Data protection classification for the tier, relevant to information security governance."
    - name: "partner_approval_required_flag"
      expr: partner_approval_required_flag
      comment: "Flags whether partner approval is required for engagements under this tier, informing governance and deal approval workflows."
    - name: "insurance_coverage_required_flag"
      expr: insurance_coverage_required_flag
      comment: "Indicates whether insurance coverage is required for the tier, relevant to risk management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which tier rates and engagement values are denominated."
    - name: "tier_status"
      expr: tier_status
      comment: "Lifecycle status of the tier (Active, Inactive, Deprecated)."
  measures:
    - name: "total_active_tiers"
      expr: COUNT(1)
      comment: "Total number of active service tiers. Baseline measure for tier portfolio breadth and client segmentation coverage."
    - name: "avg_base_hourly_rate"
      expr: AVG(CAST(base_hourly_rate AS DOUBLE))
      comment: "Average base hourly rate across active tiers. Tracks rate level by tier — a core pricing governance KPI for ensuring appropriate rate differentiation across client segments."
    - name: "avg_minimum_engagement_value"
      expr: AVG(CAST(minimum_engagement_value AS DOUBLE))
      comment: "Average minimum engagement value threshold across tiers. Tracks the minimum deal size required per tier — informs client qualification and business development targeting."
    - name: "avg_maximum_engagement_value"
      expr: AVG(CAST(maximum_engagement_value AS DOUBLE))
      comment: "Average maximum engagement value ceiling across tiers. Tracks the upper deal size boundary per tier — informs capacity planning and risk exposure management."
    - name: "avg_response_time_commitment_hours"
      expr: AVG(CAST(response_time_commitment_hours AS DOUBLE))
      comment: "Average response time commitment in hours across active tiers. A service quality KPI — tracks the average responsiveness commitment made to clients by tier, informing SLA governance."
    - name: "engagement_value_range_avg"
      expr: AVG(CAST(maximum_engagement_value AS DOUBLE) - CAST(minimum_engagement_value AS DOUBLE))
      comment: "Average engagement value range (max minus min) per tier. Measures the breadth of deal sizes each tier is designed to serve — wide ranges indicate flexible tier structures."
    - name: "afa_eligible_tier_count"
      expr: COUNT(CASE WHEN afa_eligible_flag = TRUE THEN 1 END)
      comment: "Number of active tiers eligible for AFA. Tracks AFA availability across the client tier structure — a strategic pricing flexibility KPI."
    - name: "afa_eligible_tier_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN afa_eligible_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of active tiers that support AFA. Measures the breadth of AFA availability across the client segmentation structure."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`service_eligibility_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over service eligibility rules. Tracks rule portfolio composition, matter value thresholds, enforcement levels, and approval requirements to support intake governance, risk management, and service access control decisions."
  source: "`legal_ecm`.`service`.`eligibility_rule`"
  filter: rule_status = 'Active'
  dimensions:
    - name: "rule_type"
      expr: rule_type
      comment: "Type of eligibility rule (e.g. Client Type, Jurisdiction, Matter Value) — primary dimension for rule portfolio analysis."
    - name: "enforcement_level"
      expr: enforcement_level
      comment: "Enforcement level of the rule (Hard Block, Soft Warning, Advisory) — critical for risk governance and intake control analysis."
    - name: "rule_priority"
      expr: rule_priority
      comment: "Priority level of the rule, used to understand rule precedence in conflict resolution scenarios."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Indicates whether an approval is required when this rule is triggered, informing governance workflow design."
    - name: "rule_status"
      expr: rule_status
      comment: "Lifecycle status of the eligibility rule (Active, Inactive, Draft)."
    - name: "jurisdiction_filter"
      expr: jurisdiction_filter
      comment: "Jurisdiction to which the rule applies, enabling geographic eligibility governance analysis."
    - name: "client_type_filter"
      expr: client_type_filter
      comment: "Client type to which the rule applies (e.g. Corporate, Individual, Government), enabling client-segment eligibility analysis."
    - name: "threshold_currency_code"
      expr: threshold_currency_code
      comment: "Currency of the matter value threshold, enabling multi-currency eligibility rule analysis."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Date from which the eligibility rule became effective, used for rule vintage and governance trend analysis."
  measures:
    - name: "total_active_eligibility_rules"
      expr: COUNT(1)
      comment: "Total number of active eligibility rules. Baseline measure for intake governance coverage — high counts indicate complex eligibility frameworks requiring active management."
    - name: "avg_matter_value_threshold"
      expr: AVG(CAST(matter_value_threshold AS DOUBLE))
      comment: "Average matter value threshold across active eligibility rules. Tracks the average deal size trigger for eligibility controls — informs risk appetite calibration."
    - name: "max_matter_value_threshold"
      expr: MAX(CAST(matter_value_threshold AS DOUBLE))
      comment: "Maximum matter value threshold across eligibility rules. Identifies the highest-value trigger point in the eligibility framework — relevant to large matter risk governance."
    - name: "approval_required_rule_count"
      expr: COUNT(CASE WHEN approval_required_flag = TRUE THEN 1 END)
      comment: "Number of active eligibility rules requiring approval when triggered. Quantifies the approval workflow burden in the intake process."
    - name: "approval_required_rule_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of active eligibility rules that require approval. A governance efficiency KPI — high rates indicate a high-friction intake process that may slow client onboarding."
    - name: "distinct_jurisdiction_coverage_count"
      expr: COUNT(DISTINCT jurisdiction_filter)
      comment: "Number of distinct jurisdictions covered by active eligibility rules. Measures the geographic breadth of the eligibility governance framework."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`service_lpm_template`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over Legal Project Management (LPM) templates. Tracks budget estimates, FTE requirements, template complexity, and usage patterns to support matter planning efficiency, resource forecasting, and LPM programme governance decisions."
  source: "`legal_ecm`.`service`.`lpm_template`"
  filter: template_status = 'Active'
  dimensions:
    - name: "service_type"
      expr: service_type
      comment: "Service type associated with the LPM template, enabling service-level LPM analysis."
    - name: "complexity_level"
      expr: complexity_level
      comment: "Complexity level of the LPM template (Simple, Standard, Complex) — primary dimension for effort and budget benchmarking."
    - name: "practice_area"
      expr: practice_area
      comment: "Practice area associated with the LPM template, enabling practice-level project management analysis."
    - name: "jurisdiction_scope"
      expr: jurisdiction_scope
      comment: "Jurisdictional scope of the LPM template, informing geographic delivery planning."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Indicates whether approval is required before using the template, relevant to governance workflow design."
    - name: "client_reporting_frequency"
      expr: client_reporting_frequency
      comment: "Frequency of client reporting defined in the template (Weekly, Monthly, Milestone-based), informing client communication planning."
    - name: "budget_currency_code"
      expr: budget_currency_code
      comment: "Currency of the template budget estimate, enabling multi-currency LPM analysis."
    - name: "template_status"
      expr: template_status
      comment: "Lifecycle status of the LPM template (Active, Archived, Draft)."
    - name: "effective_from_date"
      expr: effective_from_date
      comment: "Date from which the LPM template became effective, used for template vintage analysis."
  measures:
    - name: "total_active_lpm_templates"
      expr: COUNT(1)
      comment: "Total number of active LPM templates. Baseline measure for LPM programme coverage across the service portfolio."
    - name: "avg_estimated_budget"
      expr: AVG(CAST(estimated_budget_amount AS DOUBLE))
      comment: "Average estimated budget per LPM template. Tracks matter budget benchmarks by complexity and practice area — a core matter economics and profitability planning KPI."
    - name: "total_estimated_budget"
      expr: SUM(CAST(estimated_budget_amount AS DOUBLE))
      comment: "Total estimated budget across all active LPM templates. Represents the aggregate planned matter investment across the LPM programme."
    - name: "avg_fte_requirement"
      expr: AVG(CAST(fte_requirement AS DOUBLE))
      comment: "Average FTE requirement per LPM template. Benchmarks staffing needs by matter type and complexity — informs resource planning and capacity allocation."
    - name: "total_fte_requirement"
      expr: SUM(CAST(fte_requirement AS DOUBLE))
      comment: "Total FTE requirement across all active LPM templates. Quantifies aggregate staffing demand from the LPM programme."
    - name: "implied_budget_per_fte"
      expr: ROUND(SUM(CAST(estimated_budget_amount AS DOUBLE)) / NULLIF(SUM(CAST(fte_requirement AS DOUBLE)), 0), 2)
      comment: "Implied budget per FTE across LPM templates. A productivity and pricing efficiency KPI — tracks the revenue generated per unit of staffing resource in planned matters."
$$;