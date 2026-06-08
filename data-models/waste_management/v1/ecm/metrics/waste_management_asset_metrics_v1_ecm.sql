-- Metric views for domain: asset | Business: Waste Management | Version: 1 | Generated on: 2026-05-07 19:57:14

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`asset_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core fixed asset financial and operational KPIs including book value, depreciation, and asset condition metrics"
  source: "`waste_management_ecm`.`asset`.`fixed_asset`"
  dimensions:
    - name: "asset_number"
      expr: asset_number
      comment: "Unique identifier for the fixed asset"
    - name: "asset_description"
      expr: asset_description
      comment: "Description of the fixed asset"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership classification (owned, leased, etc.)"
    - name: "condition_rating"
      expr: condition_rating
      comment: "Current condition assessment of the asset"
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Method used for depreciation calculation"
    - name: "cost_center"
      expr: cost_center
      comment: "Cost center responsible for the asset"
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year the asset was acquired"
    - name: "acquisition_month"
      expr: DATE_TRUNC('MONTH', acquisition_date)
      comment: "Month the asset was acquired"
    - name: "capitalization_year"
      expr: YEAR(capitalization_date)
      comment: "Year the asset was capitalized"
    - name: "environmental_compliance_flag"
      expr: environmental_compliance_flag
      comment: "Whether asset meets environmental compliance requirements"
  measures:
    - name: "total_asset_count"
      expr: COUNT(1)
      comment: "Total number of fixed assets"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of all fixed assets"
    - name: "total_current_book_value"
      expr: SUM(CAST(current_book_value AS DOUBLE))
      comment: "Total current book value across all fixed assets"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across all fixed assets"
    - name: "avg_current_book_value"
      expr: AVG(CAST(current_book_value AS DOUBLE))
      comment: "Average current book value per fixed asset"
    - name: "depreciation_rate"
      expr: ROUND(100.0 * SUM(CAST(accumulated_depreciation AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Overall depreciation rate as percentage of acquisition cost"
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total estimated salvage value of all fixed assets"
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from disposed assets"
    - name: "avg_asset_age_years"
      expr: AVG(DATEDIFF(CURRENT_DATE(), acquisition_date) / 365.25)
      comment: "Average age of fixed assets in years"
    - name: "total_capacity_value"
      expr: SUM(CAST(capacity_value AS DOUBLE))
      comment: "Total capacity value across all assets"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`asset_capital_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital project financial performance and execution KPIs including budget variance, schedule performance, and project ROI"
  source: "`waste_management_ecm`.`asset`.`capital_project`"
  dimensions:
    - name: "project_number"
      expr: project_number
      comment: "Unique identifier for the capital project"
    - name: "project_name"
      expr: project_name
      comment: "Name of the capital project"
    - name: "project_status"
      expr: project_status
      comment: "Current status of the project"
    - name: "project_type"
      expr: project_type
      comment: "Type or category of capital project"
    - name: "project_priority"
      expr: project_priority
      comment: "Priority level of the project"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk assessment level for the project"
    - name: "funding_source"
      expr: funding_source
      comment: "Source of funding for the project"
    - name: "approval_authority"
      expr: approval_authority
      comment: "Authority that approved the project"
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year the project is planned to start"
    - name: "planned_completion_year"
      expr: YEAR(planned_completion_date)
      comment: "Year the project is planned to complete"
    - name: "environmental_permit_required"
      expr: environmental_permit_required
      comment: "Whether environmental permit is required"
  measures:
    - name: "total_project_count"
      expr: COUNT(1)
      comment: "Total number of capital projects"
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved budget across all capital projects"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend across all capital projects"
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed amount across all capital projects"
    - name: "total_budget_variance"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (actual vs approved) across all projects"
    - name: "avg_budget_variance_pct"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage across projects"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(approved_budget_amount AS DOUBLE)), 0), 2)
      comment: "Overall budget utilization rate as percentage of approved budget"
    - name: "avg_schedule_variance_days"
      expr: AVG(CAST(schedule_variance_days AS DOUBLE))
      comment: "Average schedule variance in days across projects"
    - name: "commitment_rate"
      expr: ROUND(100.0 * SUM(CAST(committed_amount AS DOUBLE)) / NULLIF(SUM(CAST(approved_budget_amount AS DOUBLE)), 0), 2)
      comment: "Commitment rate as percentage of approved budget"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`asset_depreciation_posting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Depreciation expense and asset value KPIs for financial reporting and asset lifecycle management"
  source: "`waste_management_ecm`.`asset`.`depreciation_posting`"
  dimensions:
    - name: "asset_number"
      expr: asset_number
      comment: "Asset number for the depreciation posting"
    - name: "company_code"
      expr: company_code
      comment: "Company code for the posting"
    - name: "cost_center"
      expr: cost_center
      comment: "Cost center charged with depreciation"
    - name: "depreciation_area"
      expr: depreciation_area
      comment: "Depreciation area (book, tax, etc.)"
    - name: "depreciation_key"
      expr: depreciation_key
      comment: "Depreciation calculation method key"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the posting"
    - name: "posting_period"
      expr: posting_period
      comment: "Posting period within fiscal year"
    - name: "posting_status"
      expr: posting_status
      comment: "Status of the depreciation posting"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of depreciation transaction"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of the depreciation posting"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Whether this is a reversal posting"
  measures:
    - name: "total_posting_count"
      expr: COUNT(1)
      comment: "Total number of depreciation postings"
    - name: "total_posted_depreciation"
      expr: SUM(CAST(posted_depreciation_amount AS DOUBLE))
      comment: "Total posted depreciation expense"
    - name: "total_planned_depreciation"
      expr: SUM(CAST(planned_depreciation_amount AS DOUBLE))
      comment: "Total planned depreciation expense"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across all postings"
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value across all assets in postings"
    - name: "total_acquisition_value"
      expr: SUM(CAST(acquisition_value AS DOUBLE))
      comment: "Total acquisition value of assets in postings"
    - name: "avg_posted_depreciation"
      expr: AVG(CAST(posted_depreciation_amount AS DOUBLE))
      comment: "Average posted depreciation amount per posting"
    - name: "depreciation_variance"
      expr: SUM((CAST(posted_depreciation_amount AS DOUBLE)) - (CAST(planned_depreciation_amount AS DOUBLE)))
      comment: "Total variance between posted and planned depreciation"
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life in years across depreciation postings"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`asset_container`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Container asset utilization and deployment KPIs for waste collection operations"
  source: "`waste_management_ecm`.`asset`.`asset_container`"
  dimensions:
    - name: "cid"
      expr: cid
      comment: "Container ID"
    - name: "container_type"
      expr: container_type
      comment: "Type of waste container"
    - name: "waste_stream_type"
      expr: waste_stream_type
      comment: "Type of waste stream handled"
    - name: "ownership_status"
      expr: ownership_status
      comment: "Ownership status of the container"
    - name: "condition_grade"
      expr: condition_grade
      comment: "Current condition grade of the container"
    - name: "service_frequency"
      expr: service_frequency
      comment: "Frequency of service for the container"
    - name: "manufacturer"
      expr: manufacturer
      comment: "Manufacturer of the container"
    - name: "material"
      expr: material
      comment: "Material the container is made from"
    - name: "is_gps_enabled"
      expr: is_gps_enabled
      comment: "Whether container has GPS tracking enabled"
    - name: "is_rfid_enabled"
      expr: is_rfid_enabled
      comment: "Whether container has RFID tracking enabled"
    - name: "deployment_year"
      expr: YEAR(deployment_date)
      comment: "Year the container was deployed"
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year the container was acquired"
  measures:
    - name: "total_container_count"
      expr: COUNT(1)
      comment: "Total number of asset containers"
    - name: "total_capacity_cubic_yards"
      expr: SUM(CAST(capacity_cubic_yards AS DOUBLE))
      comment: "Total capacity in cubic yards across all containers"
    - name: "avg_capacity_cubic_yards"
      expr: AVG(CAST(capacity_cubic_yards AS DOUBLE))
      comment: "Average capacity per container in cubic yards"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of all containers"
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of all containers"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation on containers"
    - name: "avg_tare_weight_lbs"
      expr: AVG(CAST(tare_weight_lbs AS DOUBLE))
      comment: "Average tare weight per container in pounds"
    - name: "avg_compaction_ratio"
      expr: AVG(CAST(compaction_ratio AS DOUBLE))
      comment: "Average compaction ratio across containers"
    - name: "gps_enabled_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_gps_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of containers with GPS tracking enabled"
    - name: "rfid_enabled_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_rfid_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of containers with RFID tracking enabled"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`asset_utilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset utilization and efficiency KPIs for operational performance management"
  source: "`waste_management_ecm`.`asset`.`utilization`"
  dimensions:
    - name: "asset_type"
      expr: asset_type
      comment: "Type of asset being measured"
    - name: "utilization_status"
      expr: utilization_status
      comment: "Current utilization status"
    - name: "cost_center"
      expr: cost_center
      comment: "Cost center responsible for the asset"
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to measure utilization"
    - name: "data_source"
      expr: data_source
      comment: "Source system for utilization data"
    - name: "measurement_period_start"
      expr: measurement_period_start_date
      comment: "Start date of measurement period"
    - name: "measurement_period_end"
      expr: measurement_period_end_date
      comment: "End date of measurement period"
    - name: "measurement_year"
      expr: YEAR(measurement_period_start_date)
      comment: "Year of the measurement period"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_period_start_date)
      comment: "Month of the measurement period"
    - name: "redeployment_candidate_flag"
      expr: redeployment_candidate_flag
      comment: "Whether asset is a candidate for redeployment"
  measures:
    - name: "total_utilization_records"
      expr: COUNT(1)
      comment: "Total number of utilization measurement records"
    - name: "avg_utilization_rate"
      expr: AVG(CAST(rate_percent AS DOUBLE))
      comment: "Average utilization rate percentage across all assets"
    - name: "total_operating_hours"
      expr: SUM(CAST(operating_hours AS DOUBLE))
      comment: "Total operating hours across all assets"
    - name: "total_idle_hours"
      expr: SUM(CAST(idle_hours AS DOUBLE))
      comment: "Total idle hours across all assets"
    - name: "avg_fill_level_pct"
      expr: AVG(CAST(average_fill_level_percent AS DOUBLE))
      comment: "Average fill level percentage across containers"
    - name: "avg_peak_fill_level_pct"
      expr: AVG(CAST(peak_fill_level_percent AS DOUBLE))
      comment: "Average peak fill level percentage"
    - name: "total_throughput_value"
      expr: SUM(CAST(actual_throughput_value AS DOUBLE))
      comment: "Total actual throughput value across all assets"
    - name: "total_rated_capacity"
      expr: SUM(CAST(rated_capacity_value AS DOUBLE))
      comment: "Total rated capacity across all assets"
    - name: "capacity_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_throughput_value AS DOUBLE)) / NULLIF(SUM(CAST(rated_capacity_value AS DOUBLE)), 0), 2)
      comment: "Overall capacity utilization rate as percentage of rated capacity"
    - name: "total_weight_processed_tons"
      expr: SUM(CAST(total_weight_processed_tons AS DOUBLE))
      comment: "Total weight processed in tons"
    - name: "avg_measurement_quality_score"
      expr: AVG(CAST(measurement_quality_score AS DOUBLE))
      comment: "Average quality score of utilization measurements"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`asset_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility operational capacity and compliance KPIs for site management"
  source: "`waste_management_ecm`.`asset`.`facility`"
  dimensions:
    - name: "facility_code"
      expr: facility_code
      comment: "Unique code for the facility"
    - name: "facility_name"
      expr: facility_name
      comment: "Name of the facility"
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (landfill, transfer station, etc.)"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type of the facility"
    - name: "state_province"
      expr: state_province
      comment: "State or province where facility is located"
    - name: "country_code"
      expr: country_code
      comment: "Country code for facility location"
    - name: "hazmat_facility_flag"
      expr: hazmat_facility_flag
      comment: "Whether facility handles hazardous materials"
    - name: "iso_14001_certified"
      expr: iso_14001_certified
      comment: "Whether facility is ISO 14001 certified"
    - name: "iso_45001_certified"
      expr: iso_45001_certified
      comment: "Whether facility is ISO 45001 certified"
    - name: "commissioning_year"
      expr: YEAR(commissioning_date)
      comment: "Year the facility was commissioned"
  measures:
    - name: "total_facility_count"
      expr: COUNT(1)
      comment: "Total number of facilities"
    - name: "total_permitted_capacity_tpd"
      expr: SUM(CAST(permitted_capacity_tpd AS DOUBLE))
      comment: "Total permitted capacity in tons per day across all facilities"
    - name: "avg_permitted_capacity_tpd"
      expr: AVG(CAST(permitted_capacity_tpd AS DOUBLE))
      comment: "Average permitted capacity per facility in tons per day"
    - name: "total_site_area_acres"
      expr: SUM(CAST(site_area_acres AS DOUBLE))
      comment: "Total site area in acres across all facilities"
    - name: "total_landfill_remaining_capacity_tons"
      expr: SUM(CAST(landfill_remaining_capacity_tons AS DOUBLE))
      comment: "Total remaining landfill capacity in tons"
    - name: "avg_landfill_remaining_capacity_tons"
      expr: AVG(CAST(landfill_remaining_capacity_tons AS DOUBLE))
      comment: "Average remaining landfill capacity per facility in tons"
    - name: "iso_14001_certification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN iso_14001_certified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities with ISO 14001 certification"
    - name: "iso_45001_certification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN iso_45001_certified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities with ISO 45001 certification"
    - name: "hazmat_facility_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN hazmat_facility_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities handling hazardous materials"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`asset_impairment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset impairment and valuation loss KPIs for financial risk management"
  source: "`waste_management_ecm`.`asset`.`impairment`"
  dimensions:
    - name: "impairment_number"
      expr: impairment_number
      comment: "Unique identifier for the impairment"
    - name: "impairment_type"
      expr: impairment_type
      comment: "Type of impairment"
    - name: "impairment_status"
      expr: impairment_status
      comment: "Status of the impairment"
    - name: "triggering_event"
      expr: triggering_event
      comment: "Event that triggered the impairment"
    - name: "company_code"
      expr: company_code
      comment: "Company code for the impairment"
    - name: "cost_center"
      expr: cost_center
      comment: "Cost center affected by impairment"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the impairment"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the impairment"
    - name: "valuation_method"
      expr: valuation_method
      comment: "Method used for valuation"
    - name: "environmental_incident_flag"
      expr: environmental_incident_flag
      comment: "Whether impairment was due to environmental incident"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Whether this is a reversal of prior impairment"
    - name: "sox_material_flag"
      expr: sox_material_flag
      comment: "Whether impairment is SOX material"
  measures:
    - name: "total_impairment_count"
      expr: COUNT(1)
      comment: "Total number of impairment events"
    - name: "total_impairment_loss"
      expr: SUM(CAST(loss_amount AS DOUBLE))
      comment: "Total impairment loss amount"
    - name: "avg_impairment_loss"
      expr: AVG(CAST(loss_amount AS DOUBLE))
      comment: "Average impairment loss per event"
    - name: "total_carrying_amount"
      expr: SUM(CAST(carrying_amount AS DOUBLE))
      comment: "Total carrying amount of impaired assets"
    - name: "total_recoverable_amount"
      expr: SUM(CAST(recoverable_amount AS DOUBLE))
      comment: "Total recoverable amount of impaired assets"
    - name: "total_fair_value_less_costs"
      expr: SUM(CAST(fair_value_less_costs_to_sell AS DOUBLE))
      comment: "Total fair value less costs to sell"
    - name: "total_value_in_use"
      expr: SUM(CAST(value_in_use AS DOUBLE))
      comment: "Total value in use of impaired assets"
    - name: "total_reversal_amount"
      expr: SUM(CAST(reversal_amount AS DOUBLE))
      comment: "Total amount of impairment reversals"
    - name: "avg_discount_rate_pct"
      expr: AVG(CAST(discount_rate_percent AS DOUBLE))
      comment: "Average discount rate used in impairment calculations"
    - name: "impairment_rate"
      expr: ROUND(100.0 * SUM(CAST(loss_amount AS DOUBLE)) / NULLIF(SUM(CAST(carrying_amount AS DOUBLE)), 0), 2)
      comment: "Impairment rate as percentage of carrying amount"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`asset_lease`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lease liability and right-of-use asset KPIs for lease accounting and financial reporting"
  source: "`waste_management_ecm`.`asset`.`lease`"
  dimensions:
    - name: "contract_number"
      expr: contract_number
      comment: "Lease contract number"
    - name: "lease_type"
      expr: lease_type
      comment: "Type of lease (operating, finance, etc.)"
    - name: "lease_status"
      expr: lease_status
      comment: "Current status of the lease"
    - name: "company_code"
      expr: company_code
      comment: "Company code for the lease"
    - name: "cost_center"
      expr: cost_center
      comment: "Cost center charged with lease payments"
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of lease payments"
    - name: "purchase_option_flag"
      expr: purchase_option_flag
      comment: "Whether lease includes purchase option"
    - name: "renewal_option_flag"
      expr: renewal_option_flag
      comment: "Whether lease includes renewal option"
    - name: "termination_option_flag"
      expr: termination_option_flag
      comment: "Whether lease includes termination option"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the lease started"
    - name: "end_year"
      expr: YEAR(end_date)
      comment: "Year the lease ends"
  measures:
    - name: "total_lease_count"
      expr: COUNT(1)
      comment: "Total number of leases"
    - name: "total_rou_asset_value"
      expr: SUM(CAST(rou_asset_value AS DOUBLE))
      comment: "Total right-of-use asset value across all leases"
    - name: "total_liability_balance"
      expr: SUM(CAST(liability_balance AS DOUBLE))
      comment: "Total lease liability balance"
    - name: "total_monthly_lease_payment"
      expr: SUM(CAST(monthly_lease_payment AS DOUBLE))
      comment: "Total monthly lease payments across all leases"
    - name: "avg_monthly_lease_payment"
      expr: AVG(CAST(monthly_lease_payment AS DOUBLE))
      comment: "Average monthly lease payment per lease"
    - name: "avg_implicit_interest_rate"
      expr: AVG(CAST(implicit_interest_rate AS DOUBLE))
      comment: "Average implicit interest rate across leases"
    - name: "avg_incremental_borrowing_rate"
      expr: AVG(CAST(incremental_borrowing_rate AS DOUBLE))
      comment: "Average incremental borrowing rate across leases"
    - name: "total_purchase_option_price"
      expr: SUM(CAST(purchase_option_price AS DOUBLE))
      comment: "Total purchase option price for leases with purchase options"
    - name: "total_termination_penalty"
      expr: SUM(CAST(termination_penalty_amount AS DOUBLE))
      comment: "Total termination penalty amount across leases"
$$;