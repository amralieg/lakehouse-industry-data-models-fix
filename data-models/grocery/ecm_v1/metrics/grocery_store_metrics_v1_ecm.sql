-- Metric views for domain: store | Business: Grocery | Version: 1 | Generated on: 2026-05-04 18:32:13

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`store_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core store footprint and count metrics for strategic real‑estate and capacity planning"
  source: "`grocery_ecm`.`store`.`store_location`"
  dimensions:
    - name: "region_id"
      expr: region_id
      comment: "Region identifier for geographic aggregation"
    - name: "banner_id"
      expr: banner_id
      comment: "Banner identifier linking stores to corporate banner"
    - name: "format_id"
      expr: format_id
      comment: "Store format identifier (e.g., supercenter, market)"
  measures:
    - name: "store_count"
      expr: COUNT(1)
      comment: "Total number of store locations"
    - name: "total_gross_square_footage"
      expr: SUM(CAST(gross_square_footage AS DOUBLE))
      comment: "Sum of gross square footage across stores"
    - name: "average_gross_square_footage"
      expr: AVG(CAST(gross_square_footage AS DOUBLE))
      comment: "Average gross square footage per store"
    - name: "total_backroom_square_footage"
      expr: SUM(CAST(backroom_square_footage AS DOUBLE))
      comment: "Total backroom square footage across stores"
    - name: "average_backroom_square_footage"
      expr: AVG(CAST(backroom_square_footage AS DOUBLE))
      comment: "Average backroom square footage per store"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`store_energy_management`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Energy usage, cost, and carbon metrics to drive sustainability and cost‑efficiency initiatives"
  source: "`grocery_ecm`.`store`.`energy_management`"
  dimensions:
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location associated with the energy record"
    - name: "energy_source"
      expr: energy_source
      comment: "Source of energy (e.g., electricity, gas)"
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to measure consumption"
    - name: "reporting_period"
      expr: reporting_period
      comment: "Reporting period identifier"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of energy management records"
    - name: "total_consumption_amount"
      expr: SUM(CAST(consumption_amount AS DOUBLE))
      comment: "Total energy consumption amount (kWh or other unit) for the period"
    - name: "average_consumption_amount"
      expr: AVG(CAST(consumption_amount AS DOUBLE))
      comment: "Average consumption amount per record"
    - name: "total_carbon_emission_kg"
      expr: SUM(CAST(carbon_emission_kg AS DOUBLE))
      comment: "Total carbon emissions in kilograms"
    - name: "average_cost_per_unit_usd"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per unit of energy in USD"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`store_health_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Health inspection performance metrics to monitor food safety and regulatory compliance"
  source: "`grocery_ecm`.`store`.`health_inspection`"
  dimensions:
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location inspected"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of health inspection"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection"
    - name: "letter_grade"
      expr: letter_grade
      comment: "Letter grade assigned by the inspecting agency"
  measures:
    - name: "inspection_record_count"
      expr: COUNT(1)
      comment: "Total number of health inspection records"
    - name: "average_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall inspection score"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`store_lease`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lease financial metrics to support real‑estate cost management and budgeting"
  source: "`grocery_ecm`.`store`.`lease`"
  dimensions:
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location associated with the lease"
    - name: "lease_status"
      expr: lease_status
      comment: "Current status of the lease (e.g., active, terminated)"
    - name: "lease_type"
      expr: lease_type
      comment: "Type of lease agreement"
  measures:
    - name: "lease_record_count"
      expr: COUNT(1)
      comment: "Number of lease records"
    - name: "total_base_rent_usd"
      expr: SUM(CAST(base_rent_amount_usd AS DOUBLE))
      comment: "Total base rent amount in USD across leases"
    - name: "average_base_rent_usd"
      expr: AVG(CAST(base_rent_amount_usd AS DOUBLE))
      comment: "Average base rent per lease in USD"
    - name: "total_leased_square_footage"
      expr: SUM(CAST(leased_square_footage AS DOUBLE))
      comment: "Total leased square footage across all leases"
    - name: "average_leased_square_footage"
      expr: AVG(CAST(leased_square_footage AS DOUBLE))
      comment: "Average leased square footage per lease"
    - name: "total_insurance_amount_usd"
      expr: SUM(CAST(insurance_amount_usd AS DOUBLE))
      comment: "Total insurance amount covered by leases in USD"
$$;