-- Metric views for domain: realestate | Business: Restaurants | Version: 1 | Generated on: 2026-05-06 02:26:41

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`realestate_lease`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial and term metrics for leases"
  source: "`restaurants_ecm`.`realestate`.`lease`"
  dimensions:
    - name: "lease_status"
      expr: lease_status
      comment: "Current status of the lease"
    - name: "lease_type"
      expr: lease_type
      comment: "Classification of lease (e.g., gross, net)"
    - name: "landlord_id"
      expr: landlord_id
      comment: "Identifier of the landlord"
    - name: "site_id"
      expr: site_id
      comment: "Site where the lease is located"
  measures:
    - name: "total_base_rent_amount"
      expr: SUM(CAST(base_rent_amount AS DOUBLE))
      comment: "Total annual base rent across all leases"
    - name: "average_base_rent_amount"
      expr: AVG(CAST(base_rent_amount AS DOUBLE))
      comment: "Average base rent per lease"
    - name: "total_cam_charges_annual"
      expr: SUM(CAST(cam_charges_annual AS DOUBLE))
      comment: "Total annual CAM charges across leases"
    - name: "average_cam_charges_annual"
      expr: AVG(CAST(cam_charges_annual AS DOUBLE))
      comment: "Average annual CAM charge per lease"
    - name: "average_rent_escalation_rate"
      expr: AVG(CAST(rent_escalation_rate AS DOUBLE))
      comment: "Average rent escalation rate applied to leases"
    - name: "lease_count"
      expr: COUNT(1)
      comment: "Number of lease records"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`realestate_rent_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial performance of rent payments"
  source: "`restaurants_ecm`.`realestate`.`rent_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment"
    - name: "payment_year"
      expr: DATE_TRUNC('year', payment_date)
      comment: "Year of payment"
    - name: "landlord_id"
      expr: landlord_id
      comment: "Landlord associated with payment"
    - name: "lease_id"
      expr: lease_id
      comment: "Lease linked to payment"
    - name: "restaurant_unit_id"
      expr: restaurant_unit_id
      comment: "Restaurant unit receiving payment"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(total_payment_amount AS DOUBLE))
      comment: "Total amount paid across all rent payments"
    - name: "total_late_fee_amount"
      expr: SUM(CAST(late_fee_amount AS DOUBLE))
      comment: "Total late fees incurred"
    - name: "total_property_tax_amount"
      expr: SUM(CAST(property_tax_amount AS DOUBLE))
      comment: "Total property tax paid"
    - name: "total_insurance_amount"
      expr: SUM(CAST(insurance_amount AS DOUBLE))
      comment: "Total insurance charges"
    - name: "total_cam_amount"
      expr: SUM(CAST(cam_amount AS DOUBLE))
      comment: "Total CAM amount paid"
    - name: "average_payment_variance_amount"
      expr: AVG(CAST(payment_variance_amount AS DOUBLE))
      comment: "Average variance between scheduled and actual payment"
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Number of rent payment records"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`realestate_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial overview of facilities"
  source: "`restaurants_ecm`.`realestate`.`facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (e.g., restaurant, office)"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership classification"
    - name: "year_built"
      expr: year_built
      comment: "Year the facility was built"
    - name: "site_id"
      expr: site_id
      comment: "Site identifier for the facility"
    - name: "facility_status"
      expr: facility_status
      comment: "Current operational status"
  measures:
    - name: "total_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Aggregate square footage of facilities"
    - name: "average_condition_score"
      expr: AVG(CAST(condition_score AS DOUBLE))
      comment: "Average condition score across facilities"
    - name: "average_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage"
    - name: "total_cam_charges"
      expr: SUM(CAST(cam_charges AS DOUBLE))
      comment: "Total CAM charges incurred by facilities"
    - name: "total_capex_spent"
      expr: SUM(CAST(capex_spent AS DOUBLE))
      comment: "Total capital expenditures spent on facilities"
    - name: "facility_count"
      expr: COUNT(1)
      comment: "Number of facility records"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`realestate_cam_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key CAM reconciliation financial metrics"
  source: "`restaurants_ecm`.`realestate`.`cam_reconciliation`"
  dimensions:
    - name: "cam_reconciliation_status"
      expr: cam_reconciliation_status
      comment: "Status of the CAM reconciliation"
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current dispute status"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used in reconciliation"
    - name: "period_year"
      expr: DATE_TRUNC('year', period_start_date)
      comment: "Fiscal year of the reconciliation period"
    - name: "landlord_id"
      expr: landlord_id
      comment: "Landlord involved"
    - name: "tenant_id"
      expr: tenant_id
      comment: "Tenant involved"
  measures:
    - name: "total_cam_final_amount"
      expr: SUM(CAST(cam_final_amount AS DOUBLE))
      comment: "Total final CAM amount after reconciliation"
    - name: "total_cam_billed_amount"
      expr: SUM(CAST(cam_billed_amount AS DOUBLE))
      comment: "Total CAM amount billed"
    - name: "total_overpayment_credit_amount"
      expr: SUM(CAST(overpayment_credit_amount AS DOUBLE))
      comment: "Total overpayment credits identified"
    - name: "total_underpayment_due_amount"
      expr: SUM(CAST(underpayment_due_amount AS DOUBLE))
      comment: "Total underpayment amounts due"
    - name: "reconciliation_count"
      expr: COUNT(1)
      comment: "Number of CAM reconciliation records"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`realestate_capex_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial overview of capital expenditure budgets"
  source: "`restaurants_ecm`.`realestate`.`capex_budget`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Classification of budget (e.g., operational, expansion)"
    - name: "capex_budget_status"
      expr: capex_budget_status
      comment: "Current status of the budget"
    - name: "legal_entity_id"
      expr: legal_entity_id
      comment: "Legal entity responsible for the budget"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget amounts"
    - name: "budget_start_year"
      expr: DATE_TRUNC('year', start_date)
      comment: "Fiscal year when budget starts"
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total approved budget amount"
    - name: "total_building_shell_cost"
      expr: SUM(CAST(building_shell_cost AS DOUBLE))
      comment: "Aggregate building shell cost"
    - name: "total_ffe_cost"
      expr: SUM(CAST(ffe_cost AS DOUBLE))
      comment: "Aggregate furniture, fixtures, and equipment cost"
    - name: "total_technology_cost"
      expr: SUM(CAST(technology_cost AS DOUBLE))
      comment: "Aggregate technology investment cost"
    - name: "average_budget_revision_amount"
      expr: AVG(CAST(budget_revision_amount AS DOUBLE))
      comment: "Average amount of budget revisions"
    - name: "capex_budget_count"
      expr: COUNT(1)
      comment: "Number of capex budget records"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`realestate_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core financial and performance indicators for real estate sites"
  source: "`restaurants_ecm`.`realestate`.`site`"
  dimensions:
    - name: "site_type"
      expr: site_type
      comment: "Classification of site (e.g., restaurant, drive-thru)"
    - name: "ownership_status"
      expr: ownership_status
      comment: "Ownership arrangement of the site"
    - name: "city"
      expr: city
      comment: "City where the site is located"
    - name: "state_province"
      expr: state_province
      comment: "State or province of the site"
    - name: "country_code"
      expr: country_code
      comment: "Country code of the site"
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Current lifecycle stage (e.g., development, operational)"
    - name: "site_open_year"
      expr: DATE_TRUNC('year', opening_date)
      comment: "Year the site opened"
  measures:
    - name: "total_monthly_base_rent"
      expr: SUM(CAST(monthly_base_rent AS DOUBLE))
      comment: "Aggregate monthly base rent across sites"
    - name: "total_monthly_cam_charges"
      expr: SUM(CAST(monthly_cam_charges AS DOUBLE))
      comment: "Aggregate monthly CAM charges"
    - name: "total_projected_auv"
      expr: SUM(CAST(projected_auv AS DOUBLE))
      comment: "Total projected average unit volume"
    - name: "total_total_capex_investment"
      expr: SUM(CAST(total_capex_investment AS DOUBLE))
      comment: "Total capital investment across sites"
    - name: "average_visibility_score"
      expr: AVG(CAST(visibility_score AS DOUBLE))
      comment: "Average visibility score of sites"
    - name: "site_count"
      expr: COUNT(1)
      comment: "Number of site records"
$$;