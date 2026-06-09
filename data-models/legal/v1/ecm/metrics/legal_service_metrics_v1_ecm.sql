-- Metric views for domain: service | Business: Legal | Version: 1 | Generated on: 2026-05-07 11:54:14

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`service_legal_service`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core legal service performance metrics tracking service utilization, billability, and pricing effectiveness across practice areas and jurisdictions"
  source: "`legal_ecm`.`service`.`legal_service`"
  dimensions:
    - name: "service_name"
      expr: service_name
      comment: "Name of the legal service offering"
    - name: "service_code"
      expr: service_code
      comment: "Unique code identifying the legal service"
    - name: "service_type"
      expr: service_type
      comment: "Type classification of the legal service"
    - name: "service_category"
      expr: service_category
      comment: "Category grouping for the legal service"
    - name: "service_status"
      expr: service_status
      comment: "Current operational status of the service"
    - name: "practice_area"
      expr: practice_area
      comment: "Practice area to which the service belongs"
    - name: "jurisdiction_coverage"
      expr: jurisdiction_coverage
      comment: "Geographic jurisdictions covered by this service"
    - name: "is_billable"
      expr: is_billable
      comment: "Whether the service is billable to clients"
    - name: "allows_afa"
      expr: allows_afa
      comment: "Whether alternative fee arrangements are permitted"
    - name: "approval_required"
      expr: approval_required
      comment: "Whether service engagement requires approval"
    - name: "requires_conflict_check"
      expr: requires_conflict_check
      comment: "Whether conflict check is mandatory for this service"
    - name: "requires_kyc"
      expr: requires_kyc
      comment: "Whether KYC verification is required"
    - name: "insurance_coverage_required"
      expr: insurance_coverage_required
      comment: "Whether insurance coverage is required for service delivery"
    - name: "eligible_client_segments"
      expr: eligible_client_segments
      comment: "Client segments eligible for this service"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the service"
    - name: "required_expertise_level"
      expr: required_expertise_level
      comment: "Minimum expertise level required to deliver the service"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for service pricing"
  measures:
    - name: "total_active_services"
      expr: COUNT(CASE WHEN service_status = 'Active' THEN 1 END)
      comment: "Count of active legal services available for engagement"
    - name: "total_billable_services"
      expr: COUNT(CASE WHEN is_billable = TRUE THEN 1 END)
      comment: "Count of services that generate billable revenue"
    - name: "afa_enabled_services"
      expr: COUNT(CASE WHEN allows_afa = TRUE THEN 1 END)
      comment: "Count of services supporting alternative fee arrangements"
    - name: "total_standard_rate_value"
      expr: SUM(CAST(standard_rate AS DOUBLE))
      comment: "Sum of standard rates across all services"
    - name: "avg_standard_rate"
      expr: AVG(CAST(standard_rate AS DOUBLE))
      comment: "Average standard rate per service"
    - name: "total_estimated_duration_hours"
      expr: SUM(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Total estimated hours across all services"
    - name: "avg_estimated_duration_hours"
      expr: AVG(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Average estimated duration per service engagement"
    - name: "conflict_check_required_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN requires_conflict_check = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of services requiring conflict checks"
    - name: "kyc_required_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN requires_kyc = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of services requiring KYC verification"
    - name: "insurance_required_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN insurance_coverage_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of services requiring insurance coverage"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`service_matter_service_mapping`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Matter-level service engagement metrics tracking budget utilization, service scope, and engagement effectiveness"
  source: "`legal_ecm`.`service`.`matter_service_mapping`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the matter-service mapping"
    - name: "is_primary_service"
      expr: is_primary_service
      comment: "Whether this is the primary service for the matter"
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model applied to this matter-service engagement"
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Frequency of billing for this service"
    - name: "budget_currency_code"
      expr: budget_currency_code
      comment: "Currency for budget amounts"
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier assigned to this engagement"
    - name: "utbms_activity_code"
      expr: utbms_activity_code
      comment: "UTBMS activity code for standardized billing"
    - name: "utbms_task_code"
      expr: utbms_task_code
      comment: "UTBMS task code for standardized billing"
  measures:
    - name: "total_matter_service_engagements"
      expr: COUNT(1)
      comment: "Total count of matter-service mappings"
    - name: "approved_engagements"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Count of approved matter-service engagements"
    - name: "primary_service_engagements"
      expr: COUNT(CASE WHEN is_primary_service = TRUE THEN 1 END)
      comment: "Count of primary service assignments to matters"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount across all matter-service engagements"
    - name: "avg_budget_per_engagement"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per matter-service engagement"
    - name: "total_estimated_hours"
      expr: SUM(CAST(estimated_hours AS DOUBLE))
      comment: "Total estimated hours across all engagements"
    - name: "avg_estimated_hours"
      expr: AVG(CAST(estimated_hours AS DOUBLE))
      comment: "Average estimated hours per engagement"
    - name: "budget_per_hour"
      expr: ROUND(SUM(CAST(budget_amount AS DOUBLE)) / NULLIF(SUM(CAST(estimated_hours AS DOUBLE)), 0), 2)
      comment: "Average budgeted rate per hour across engagements"
    - name: "distinct_matters_served"
      expr: COUNT(DISTINCT matter_id)
      comment: "Count of unique matters with service mappings"
    - name: "distinct_services_engaged"
      expr: COUNT(DISTINCT legal_service_id)
      comment: "Count of unique legal services engaged across matters"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`service_pricing_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing model effectiveness metrics tracking rate structures, AFA adoption, and pricing strategy performance"
  source: "`legal_ecm`.`service`.`pricing_model`"
  dimensions:
    - name: "model_name"
      expr: model_name
      comment: "Name of the pricing model"
    - name: "model_code"
      expr: model_code
      comment: "Unique code for the pricing model"
    - name: "model_type"
      expr: model_type
      comment: "Type of pricing model (hourly, fixed, contingency, etc.)"
    - name: "pricing_model_status"
      expr: pricing_model_status
      comment: "Current status of the pricing model"
    - name: "afa_indicator"
      expr: afa_indicator
      comment: "Whether this is an alternative fee arrangement"
    - name: "approval_required"
      expr: approval_required
      comment: "Whether approval is required to use this pricing model"
    - name: "calculation_basis"
      expr: calculation_basis
      comment: "Basis for pricing calculation"
    - name: "rate_currency_code"
      expr: rate_currency_code
      comment: "Currency for rate amounts"
    - name: "applicable_practice_areas"
      expr: applicable_practice_areas
      comment: "Practice areas where this pricing model applies"
    - name: "applicable_jurisdictions"
      expr: applicable_jurisdictions
      comment: "Jurisdictions where this pricing model is applicable"
    - name: "advance_payment_required"
      expr: advance_payment_required
      comment: "Whether advance payment is required"
  measures:
    - name: "total_pricing_models"
      expr: COUNT(1)
      comment: "Total count of pricing models"
    - name: "active_pricing_models"
      expr: COUNT(CASE WHEN pricing_model_status = 'Active' THEN 1 END)
      comment: "Count of active pricing models available for use"
    - name: "afa_models"
      expr: COUNT(CASE WHEN afa_indicator = TRUE THEN 1 END)
      comment: "Count of alternative fee arrangement models"
    - name: "afa_adoption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN afa_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pricing models that are AFAs"
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate_amount AS DOUBLE))
      comment: "Average base rate across pricing models"
    - name: "avg_blended_rate"
      expr: AVG(CAST(blended_rate_amount AS DOUBLE))
      comment: "Average blended rate across pricing models"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage offered"
    - name: "avg_contingency_percentage"
      expr: AVG(CAST(contingency_percentage AS DOUBLE))
      comment: "Average contingency fee percentage"
    - name: "total_retainer_value"
      expr: SUM(CAST(retainer_amount AS DOUBLE))
      comment: "Total retainer amounts across all pricing models"
    - name: "avg_retainer_amount"
      expr: AVG(CAST(retainer_amount AS DOUBLE))
      comment: "Average retainer amount per pricing model"
    - name: "avg_minimum_fee"
      expr: AVG(CAST(minimum_fee_amount AS DOUBLE))
      comment: "Average minimum fee across pricing models"
    - name: "avg_maximum_fee"
      expr: AVG(CAST(maximum_fee_amount AS DOUBLE))
      comment: "Average maximum fee cap across pricing models"
    - name: "models_with_advance_payment"
      expr: COUNT(CASE WHEN advance_payment_required = TRUE THEN 1 END)
      comment: "Count of pricing models requiring advance payment"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`service_practice_area`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Practice area performance metrics tracking matter economics, specialization requirements, and regulatory alignment"
  source: "`legal_ecm`.`service`.`practice_area`"
  dimensions:
    - name: "practice_area_name"
      expr: practice_area_name
      comment: "Name of the practice area"
    - name: "practice_area_code"
      expr: practice_area_code
      comment: "Unique code for the practice area"
    - name: "practice_area_status"
      expr: practice_area_status
      comment: "Current operational status of the practice area"
    - name: "practice_group"
      expr: practice_group
      comment: "Practice group to which this area belongs"
    - name: "primary_service_line"
      expr: primary_service_line
      comment: "Primary service line for this practice area"
    - name: "classification_type"
      expr: classification_type
      comment: "Classification type of the practice area"
    - name: "jurisdiction_scope"
      expr: jurisdiction_scope
      comment: "Geographic jurisdiction scope"
    - name: "billable_flag"
      expr: billable_flag
      comment: "Whether work in this practice area is billable"
    - name: "pro_bono_eligible"
      expr: pro_bono_eligible
      comment: "Whether practice area is eligible for pro bono work"
    - name: "requires_specialization"
      expr: requires_specialization
      comment: "Whether specialized expertise is required"
    - name: "requires_security_clearance"
      expr: requires_security_clearance
      comment: "Whether security clearance is required"
    - name: "default_billing_arrangement"
      expr: default_billing_arrangement
      comment: "Default billing arrangement for this practice area"
    - name: "regulatory_body_alignment"
      expr: regulatory_body_alignment
      comment: "Regulatory body governing this practice area"
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in the practice area hierarchy"
  measures:
    - name: "total_practice_areas"
      expr: COUNT(1)
      comment: "Total count of practice areas"
    - name: "active_practice_areas"
      expr: COUNT(CASE WHEN practice_area_status = 'Active' THEN 1 END)
      comment: "Count of active practice areas"
    - name: "billable_practice_areas"
      expr: COUNT(CASE WHEN billable_flag = TRUE THEN 1 END)
      comment: "Count of billable practice areas"
    - name: "pro_bono_eligible_areas"
      expr: COUNT(CASE WHEN pro_bono_eligible = TRUE THEN 1 END)
      comment: "Count of practice areas eligible for pro bono work"
    - name: "specialized_practice_areas"
      expr: COUNT(CASE WHEN requires_specialization = TRUE THEN 1 END)
      comment: "Count of practice areas requiring specialized expertise"
    - name: "avg_matter_value"
      expr: AVG(CAST(average_matter_value AS DOUBLE))
      comment: "Average matter value across practice areas"
    - name: "total_matter_value"
      expr: SUM(CAST(average_matter_value AS DOUBLE))
      comment: "Total average matter value across all practice areas"
    - name: "avg_cpd_requirement_hours"
      expr: AVG(CAST(cpd_requirement_hours AS DOUBLE))
      comment: "Average continuing professional development hours required"
    - name: "total_cpd_requirement_hours"
      expr: SUM(CAST(cpd_requirement_hours AS DOUBLE))
      comment: "Total CPD hours required across all practice areas"
    - name: "security_clearance_required_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN requires_security_clearance = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of practice areas requiring security clearance"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`service_rate_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate card effectiveness metrics tracking pricing compliance, rate variance, and discount management"
  source: "`legal_ecm`.`service`.`rate_card`"
  dimensions:
    - name: "rate_card_name"
      expr: rate_card_name
      comment: "Name of the rate card"
    - name: "rate_type"
      expr: rate_type
      comment: "Type of rate (standard, discounted, premium, etc.)"
    - name: "rate_source"
      expr: rate_source
      comment: "Source of the rate card"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the rate card"
    - name: "is_active"
      expr: is_active
      comment: "Whether the rate card is currently active"
    - name: "is_default_rate"
      expr: is_default_rate
      comment: "Whether this is the default rate card"
    - name: "billing_guideline_compliant"
      expr: billing_guideline_compliant
      comment: "Whether the rate card complies with billing guidelines"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for rate amounts"
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction to which the rate card applies"
    - name: "office_location_code"
      expr: office_location_code
      comment: "Office location for the rate card"
    - name: "seniority_level"
      expr: seniority_level
      comment: "Seniority level for the rate card"
    - name: "client_segment"
      expr: client_segment
      comment: "Client segment to which the rate card applies"
    - name: "utbms_activity_code"
      expr: utbms_activity_code
      comment: "UTBMS activity code for the rate card"
    - name: "utbms_task_code"
      expr: utbms_task_code
      comment: "UTBMS task code for the rate card"
  measures:
    - name: "total_rate_cards"
      expr: COUNT(1)
      comment: "Total count of rate cards"
    - name: "active_rate_cards"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of active rate cards"
    - name: "approved_rate_cards"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Count of approved rate cards"
    - name: "guideline_compliant_rate_cards"
      expr: COUNT(CASE WHEN billing_guideline_compliant = TRUE THEN 1 END)
      comment: "Count of rate cards compliant with billing guidelines"
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate across all rate cards"
    - name: "total_hourly_rate_value"
      expr: SUM(CAST(hourly_rate AS DOUBLE))
      comment: "Sum of hourly rates across all rate cards"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied"
    - name: "avg_rate_cap"
      expr: AVG(CAST(rate_cap_amount AS DOUBLE))
      comment: "Average rate cap amount"
    - name: "avg_rate_floor"
      expr: AVG(CAST(rate_floor_amount AS DOUBLE))
      comment: "Average rate floor amount"
    - name: "rate_variance"
      expr: ROUND(AVG(CAST(rate_cap_amount AS DOUBLE)) - AVG(CAST(rate_floor_amount AS DOUBLE)), 2)
      comment: "Average variance between rate cap and floor"
    - name: "compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN billing_guideline_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rate cards compliant with billing guidelines"
    - name: "distinct_jurisdictions"
      expr: COUNT(DISTINCT jurisdiction_code)
      comment: "Count of unique jurisdictions covered by rate cards"
    - name: "distinct_client_segments"
      expr: COUNT(DISTINCT client_segment)
      comment: "Count of unique client segments with rate cards"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`service_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service line performance metrics tracking revenue targets, realization rates, and strategic positioning"
  source: "`legal_ecm`.`service`.`line`"
  dimensions:
    - name: "line_name"
      expr: line_name
      comment: "Name of the service line"
    - name: "line_code"
      expr: line_code
      comment: "Unique code for the service line"
    - name: "line_status"
      expr: line_status
      comment: "Current operational status of the service line"
    - name: "client_facing_flag"
      expr: client_facing_flag
      comment: "Whether the service line is client-facing"
    - name: "billing_model_default"
      expr: billing_model_default
      comment: "Default billing model for the service line"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the service line"
    - name: "strategic_priority_level"
      expr: strategic_priority_level
      comment: "Strategic priority level assigned to the service line"
    - name: "market_positioning"
      expr: market_positioning
      comment: "Market positioning strategy for the service line"
    - name: "conflict_sensitivity_level"
      expr: conflict_sensitivity_level
      comment: "Conflict sensitivity level for the service line"
    - name: "insurance_coverage_required_flag"
      expr: insurance_coverage_required_flag
      comment: "Whether insurance coverage is required"
    - name: "regulatory_oversight_body"
      expr: regulatory_oversight_body
      comment: "Regulatory body overseeing the service line"
    - name: "technology_platform_primary"
      expr: technology_platform_primary
      comment: "Primary technology platform used"
  measures:
    - name: "total_service_lines"
      expr: COUNT(1)
      comment: "Total count of service lines"
    - name: "active_service_lines"
      expr: COUNT(CASE WHEN line_status = 'Active' THEN 1 END)
      comment: "Count of active service lines"
    - name: "client_facing_lines"
      expr: COUNT(CASE WHEN client_facing_flag = TRUE THEN 1 END)
      comment: "Count of client-facing service lines"
    - name: "total_revenue_target"
      expr: SUM(CAST(revenue_target_annual AS DOUBLE))
      comment: "Total annual revenue target across all service lines"
    - name: "avg_revenue_target"
      expr: AVG(CAST(revenue_target_annual AS DOUBLE))
      comment: "Average annual revenue target per service line"
    - name: "avg_realization_rate_target"
      expr: AVG(CAST(realization_rate_target AS DOUBLE))
      comment: "Average realization rate target across service lines"
    - name: "avg_matter_value"
      expr: AVG(CAST(average_matter_value AS DOUBLE))
      comment: "Average matter value across service lines"
    - name: "total_fte_count"
      expr: SUM(CAST(fte_count_current AS DOUBLE))
      comment: "Total current FTE count across all service lines"
    - name: "avg_fte_per_line"
      expr: AVG(CAST(fte_count_current AS DOUBLE))
      comment: "Average FTE count per service line"
    - name: "avg_pro_bono_allocation"
      expr: AVG(CAST(pro_bono_allocation_percentage AS DOUBLE))
      comment: "Average pro bono allocation percentage"
    - name: "avg_diversity_target"
      expr: AVG(CAST(diversity_target_percentage AS DOUBLE))
      comment: "Average diversity target percentage"
    - name: "avg_cross_selling_affinity"
      expr: AVG(CAST(cross_selling_affinity_score AS DOUBLE))
      comment: "Average cross-selling affinity score"
    - name: "revenue_per_fte"
      expr: ROUND(SUM(CAST(revenue_target_annual AS DOUBLE)) / NULLIF(SUM(CAST(fte_count_current AS DOUBLE)), 0), 2)
      comment: "Average revenue target per FTE across service lines"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`service_delivery_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service delivery model performance metrics tracking capacity utilization, scalability, and operational efficiency"
  source: "`legal_ecm`.`service`.`delivery_model`"
  dimensions:
    - name: "model_name"
      expr: model_name
      comment: "Name of the delivery model"
    - name: "model_code"
      expr: model_code
      comment: "Unique code for the delivery model"
    - name: "model_type"
      expr: model_type
      comment: "Type of delivery model"
    - name: "delivery_model_status"
      expr: delivery_model_status
      comment: "Current operational status of the delivery model"
    - name: "staffing_model"
      expr: staffing_model
      comment: "Staffing model used for service delivery"
    - name: "client_interaction_model"
      expr: client_interaction_model
      comment: "Model for client interaction"
    - name: "primary_delivery_geography"
      expr: primary_delivery_geography
      comment: "Primary geographic location for delivery"
    - name: "secondary_delivery_geography"
      expr: secondary_delivery_geography
      comment: "Secondary geographic location for delivery"
    - name: "cost_structure_basis"
      expr: cost_structure_basis
      comment: "Basis for cost structure"
    - name: "scalability_rating"
      expr: scalability_rating
      comment: "Scalability rating of the delivery model"
    - name: "innovation_maturity"
      expr: innovation_maturity
      comment: "Innovation maturity level"
    - name: "quality_assurance_approach"
      expr: quality_assurance_approach
      comment: "Quality assurance approach used"
    - name: "technology_enablement"
      expr: technology_enablement
      comment: "Technology enablement level"
    - name: "data_security_tier"
      expr: data_security_tier
      comment: "Data security tier classification"
    - name: "conflict_check_required"
      expr: conflict_check_required
      comment: "Whether conflict check is required"
    - name: "ethical_wall_support"
      expr: ethical_wall_support
      comment: "Whether ethical wall support is available"
  measures:
    - name: "total_delivery_models"
      expr: COUNT(1)
      comment: "Total count of delivery models"
    - name: "active_delivery_models"
      expr: COUNT(CASE WHEN delivery_model_status = 'Active' THEN 1 END)
      comment: "Count of active delivery models"
    - name: "avg_capacity_utilization_target"
      expr: AVG(CAST(capacity_utilization_target_pct AS DOUBLE))
      comment: "Average capacity utilization target percentage"
    - name: "avg_fte_requirement_min"
      expr: AVG(CAST(fte_requirement_min AS DOUBLE))
      comment: "Average minimum FTE requirement"
    - name: "avg_fte_requirement_max"
      expr: AVG(CAST(fte_requirement_max AS DOUBLE))
      comment: "Average maximum FTE requirement"
    - name: "total_fte_capacity_min"
      expr: SUM(CAST(fte_requirement_min AS DOUBLE))
      comment: "Total minimum FTE capacity across all delivery models"
    - name: "total_fte_capacity_max"
      expr: SUM(CAST(fte_requirement_max AS DOUBLE))
      comment: "Total maximum FTE capacity across all delivery models"
    - name: "fte_flexibility_range"
      expr: ROUND(AVG(CAST(fte_requirement_max AS DOUBLE)) - AVG(CAST(fte_requirement_min AS DOUBLE)), 2)
      comment: "Average FTE flexibility range per delivery model"
    - name: "conflict_check_required_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN conflict_check_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delivery models requiring conflict checks"
    - name: "ethical_wall_support_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ethical_wall_support = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delivery models with ethical wall support"
    - name: "distinct_primary_geographies"
      expr: COUNT(DISTINCT primary_delivery_geography)
      comment: "Count of unique primary delivery geographies"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`service_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service package performance metrics tracking engagement value, cross-sell effectiveness, and package utilization"
  source: "`legal_ecm`.`service`.`package`"
  dimensions:
    - name: "package_name"
      expr: package_name
      comment: "Name of the service package"
    - name: "package_code"
      expr: package_code
      comment: "Unique code for the service package"
    - name: "package_type"
      expr: package_type
      comment: "Type of service package"
    - name: "active_flag"
      expr: active_flag
      comment: "Whether the package is currently active"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the package"
    - name: "practice_area"
      expr: practice_area
      comment: "Practice area for the package"
    - name: "pricing_basis"
      expr: pricing_basis
      comment: "Basis for package pricing"
    - name: "target_client_segment"
      expr: target_client_segment
      comment: "Target client segment for the package"
    - name: "jurisdiction_coverage"
      expr: jurisdiction_coverage
      comment: "Jurisdictions covered by the package"
    - name: "cross_sell_eligible_flag"
      expr: cross_sell_eligible_flag
      comment: "Whether the package is eligible for cross-selling"
    - name: "requires_conflict_check_flag"
      expr: requires_conflict_check_flag
      comment: "Whether conflict check is required"
    - name: "requires_kyc_flag"
      expr: requires_kyc_flag
      comment: "Whether KYC is required"
    - name: "includes_ediscovery_flag"
      expr: includes_ediscovery_flag
      comment: "Whether package includes eDiscovery services"
    - name: "includes_legal_research_flag"
      expr: includes_legal_research_flag
      comment: "Whether package includes legal research services"
    - name: "document_management_required_flag"
      expr: document_management_required_flag
      comment: "Whether document management is required"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for package pricing"
  measures:
    - name: "total_packages"
      expr: COUNT(1)
      comment: "Total count of service packages"
    - name: "active_packages"
      expr: COUNT(CASE WHEN active_flag = TRUE THEN 1 END)
      comment: "Count of active service packages"
    - name: "approved_packages"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Count of approved packages"
    - name: "cross_sell_eligible_packages"
      expr: COUNT(CASE WHEN cross_sell_eligible_flag = TRUE THEN 1 END)
      comment: "Count of packages eligible for cross-selling"
    - name: "avg_base_price"
      expr: AVG(CAST(base_price_amount AS DOUBLE))
      comment: "Average base price per package"
    - name: "total_base_price_value"
      expr: SUM(CAST(base_price_amount AS DOUBLE))
      comment: "Total base price value across all packages"
    - name: "avg_engagement_value"
      expr: AVG(CAST(average_engagement_value AS DOUBLE))
      comment: "Average engagement value per package"
    - name: "total_engagement_value"
      expr: SUM(CAST(average_engagement_value AS DOUBLE))
      comment: "Total average engagement value across all packages"
    - name: "avg_estimated_hours"
      expr: AVG(CAST(estimated_hours AS DOUBLE))
      comment: "Average estimated hours per package"
    - name: "total_estimated_hours"
      expr: SUM(CAST(estimated_hours AS DOUBLE))
      comment: "Total estimated hours across all packages"
    - name: "value_per_hour"
      expr: ROUND(SUM(CAST(average_engagement_value AS DOUBLE)) / NULLIF(SUM(CAST(estimated_hours AS DOUBLE)), 0), 2)
      comment: "Average engagement value per estimated hour"
    - name: "cross_sell_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cross_sell_eligible_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of packages eligible for cross-selling"
    - name: "ediscovery_inclusion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN includes_ediscovery_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of packages including eDiscovery services"
    - name: "distinct_target_segments"
      expr: COUNT(DISTINCT target_client_segment)
      comment: "Count of unique target client segments"
$$;