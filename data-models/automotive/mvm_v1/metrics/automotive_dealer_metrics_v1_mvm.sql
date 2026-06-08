-- Metric views for domain: dealer | Business: Automotive | Version: 1 | Generated on: 2026-05-07 02:19:54

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`dealer_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Certification business metrics"
  source: "`automotive_ecm`.`dealer`.`certification`"
  dimensions:
    - name: "Allocation Eligibility Flag"
      expr: allocation_eligibility_flag
    - name: "Audit Outcome"
      expr: audit_outcome
    - name: "Audit Required Flag"
      expr: audit_required_flag
    - name: "Authorized Vehicle Lines"
      expr: authorized_vehicle_lines
    - name: "Certification Level"
      expr: certification_level
    - name: "Certification Name"
      expr: certification_name
    - name: "Certification Number"
      expr: certification_number
    - name: "Certification Status"
      expr: certification_status
    - name: "Certification Type"
      expr: certification_type
    - name: "Compliance Standard"
      expr: compliance_standard
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Equipment Requirements"
      expr: equipment_requirements
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Facility Requirements"
      expr: facility_requirements
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Certification"
      expr: COUNT(DISTINCT certification_id)
    - name: "Total Annual Maintenance Cost Amount"
      expr: SUM(annual_maintenance_cost_amount)
    - name: "Average Annual Maintenance Cost Amount"
      expr: AVG(annual_maintenance_cost_amount)
    - name: "Total Audit Score"
      expr: SUM(audit_score)
    - name: "Average Audit Score"
      expr: AVG(audit_score)
    - name: "Total Cost Amount"
      expr: SUM(cost_amount)
    - name: "Average Cost Amount"
      expr: AVG(cost_amount)
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`dealer_contact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contact business metrics"
  source: "`automotive_ecm`.`dealer`.`contact`"
  dimensions:
    - name: "Active Flag"
      expr: active_flag
    - name: "Certification Expiry Date"
      expr: certification_expiry_date
    - name: "Certification Status"
      expr: certification_status
    - name: "Communication Preference"
      expr: communication_preference
    - name: "Contact Role"
      expr: contact_role
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source System"
      expr: data_source_system
    - name: "Dealer Portal Access Flag"
      expr: dealer_portal_access_flag
    - name: "Department"
      expr: department
    - name: "Email Address"
      expr: email_address
    - name: "Emergency Contact Name"
      expr: emergency_contact_name
    - name: "Emergency Contact Phone"
      expr: emergency_contact_phone
    - name: "Fax Number"
      expr: fax_number
    - name: "First Name"
      expr: first_name
    - name: "Hire Date"
      expr: hire_date
    - name: "Job Title"
      expr: job_title
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Contact"
      expr: COUNT(DISTINCT contact_id)
    - name: "Total Tenure Years"
      expr: SUM(tenure_years)
    - name: "Average Tenure Years"
      expr: AVG(tenure_years)
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`dealer_dealer_incentive_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dealer Incentive Claim business metrics"
  source: "`automotive_ecm`.`dealer`.`dealer_incentive_claim`"
  dimensions:
    - name: "Accrual Posted"
      expr: accrual_posted
    - name: "Adjustment Reason"
      expr: adjustment_reason
    - name: "Approved Units"
      expr: approved_units
    - name: "Claim Number"
      expr: claim_number
    - name: "Claim Period End Date"
      expr: claim_period_end_date
    - name: "Claim Period Start Date"
      expr: claim_period_start_date
    - name: "Claim Status"
      expr: claim_status
    - name: "Claim Type"
      expr: claim_type
    - name: "Claimed Metric Unit"
      expr: claimed_metric_unit
    - name: "Claimed Units"
      expr: claimed_units
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dealer Contact Email"
      expr: dealer_contact_email
    - name: "Dealer Contact Name"
      expr: dealer_contact_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dealer Incentive Claim"
      expr: COUNT(DISTINCT dealer_incentive_claim_id)
    - name: "Total Adjustment Amount"
      expr: SUM(adjustment_amount)
    - name: "Average Adjustment Amount"
      expr: AVG(adjustment_amount)
    - name: "Total Approved Amount"
      expr: SUM(approved_amount)
    - name: "Average Approved Amount"
      expr: AVG(approved_amount)
    - name: "Total Claimed Amount"
      expr: SUM(claimed_amount)
    - name: "Average Claimed Amount"
      expr: AVG(claimed_amount)
    - name: "Total Claimed Metric Value"
      expr: SUM(claimed_metric_value)
    - name: "Average Claimed Metric Value"
      expr: AVG(claimed_metric_value)
    - name: "Total Paid Amount"
      expr: SUM(paid_amount)
    - name: "Average Paid Amount"
      expr: AVG(paid_amount)
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`dealer_dealer_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dealer Inventory business metrics"
  source: "`automotive_ecm`.`dealer`.`dealer_inventory`"
  dimensions:
    - name: "Body Style"
      expr: body_style
    - name: "Certified Pre Owned"
      expr: certified_pre_owned
    - name: "Days On Lot"
      expr: days_on_lot
    - name: "Dms Record Reference"
      expr: dms_record_reference
    - name: "Drivetrain"
      expr: drivetrain
    - name: "Engine Description"
      expr: engine_description
    - name: "Estimated Arrival Date"
      expr: estimated_arrival_date
    - name: "Exterior Color Code"
      expr: exterior_color_code
    - name: "Exterior Color Name"
      expr: exterior_color_name
    - name: "Floor Plan Date"
      expr: floor_plan_date
    - name: "Floor Plan Lender"
      expr: floor_plan_lender
    - name: "In Service Date"
      expr: in_service_date
    - name: "Interior Color Code"
      expr: interior_color_code
    - name: "Interior Color Name"
      expr: interior_color_name
    - name: "Inventory Status"
      expr: inventory_status
    - name: "Inventory Type"
      expr: inventory_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dealer Inventory"
      expr: COUNT(DISTINCT dealer_inventory_id)
    - name: "Total Acquisition Cost"
      expr: SUM(acquisition_cost)
    - name: "Average Acquisition Cost"
      expr: AVG(acquisition_cost)
    - name: "Total Asking Price"
      expr: SUM(asking_price)
    - name: "Average Asking Price"
      expr: AVG(asking_price)
    - name: "Total Fuel Economy City Mpg"
      expr: SUM(fuel_economy_city_mpg)
    - name: "Average Fuel Economy City Mpg"
      expr: AVG(fuel_economy_city_mpg)
    - name: "Total Fuel Economy Highway Mpg"
      expr: SUM(fuel_economy_highway_mpg)
    - name: "Average Fuel Economy Highway Mpg"
      expr: AVG(fuel_economy_highway_mpg)
    - name: "Total Invoice Price"
      expr: SUM(invoice_price)
    - name: "Average Invoice Price"
      expr: AVG(invoice_price)
    - name: "Total Msrp"
      expr: SUM(msrp)
    - name: "Average Msrp"
      expr: AVG(msrp)
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`dealer_dealer_repair_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dealer Repair Order business metrics"
  source: "`automotive_ecm`.`dealer`.`dealer_repair_order`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dealer Repair Order"
      expr: COUNT(DISTINCT dealer_repair_order_id)
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`dealer_dealer_service_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dealer Service Appointment business metrics"
  source: "`automotive_ecm`.`dealer`.`dealer_service_appointment`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dealer Service Appointment"
      expr: COUNT(DISTINCT dealer_service_appointment_id)
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`dealer_dealer_territory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dealer Territory business metrics"
  source: "`automotive_ecm`.`dealer`.`dealer_territory`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "City List"
      expr: city_list
    - name: "Competitive Intensity Rating"
      expr: competitive_intensity_rating
    - name: "Country Code"
      expr: country_code
    - name: "County Region"
      expr: county_region
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dms Integration Status"
      expr: dms_integration_status
    - name: "Dms Last Sync Timestamp"
      expr: dms_last_sync_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Geographic Boundary Description"
      expr: geographic_boundary_description
    - name: "Household Count Estimate"
      expr: household_count_estimate
    - name: "Incentive Program Eligibility Flag"
      expr: incentive_program_eligibility_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Review Date"
      expr: last_review_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dealer Territory"
      expr: COUNT(DISTINCT dealer_territory_id)
    - name: "Total Allocation Quota Percentage"
      expr: SUM(allocation_quota_percentage)
    - name: "Average Allocation Quota Percentage"
      expr: AVG(allocation_quota_percentage)
    - name: "Total Sales Potential Index"
      expr: SUM(sales_potential_index)
    - name: "Average Sales Potential Index"
      expr: AVG(sales_potential_index)
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`dealer_dealer_warranty_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dealer Warranty Claim business metrics"
  source: "`automotive_ecm`.`dealer`.`dealer_warranty_claim`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dealer Warranty Claim"
      expr: COUNT(DISTINCT dealer_warranty_claim_id)
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`dealer_dealership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dealership business metrics"
  source: "`automotive_ecm`.`dealer`.`dealership`"
  dimensions:
    - name: "Activation Date"
      expr: activation_date
    - name: "Adas Certified"
      expr: adas_certified
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Cdk Dealer Code"
      expr: cdk_dealer_code
    - name: "Channel Classification"
      expr: channel_classification
    - name: "City"
      expr: city
    - name: "Country Code"
      expr: country_code
    - name: "Deactivation Date"
      expr: deactivation_date
    - name: "Dealer Code"
      expr: dealer_code
    - name: "Dealer Status"
      expr: dealer_status
    - name: "Dealer Tier"
      expr: dealer_tier
    - name: "Dms Go Live Date"
      expr: dms_go_live_date
    - name: "Dms Integration Status"
      expr: dms_integration_status
    - name: "Ev Certified"
      expr: ev_certified
    - name: "Ev Charger Count"
      expr: ev_charger_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dealership"
      expr: COUNT(DISTINCT dealership_id)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Parts Warehouse Area Sqm"
      expr: SUM(parts_warehouse_area_sqm)
    - name: "Average Parts Warehouse Area Sqm"
      expr: AVG(parts_warehouse_area_sqm)
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`dealer_floor_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Floor Plan business metrics"
  source: "`automotive_ecm`.`dealer`.`floor_plan`"
  dimensions:
    - name: "Account Number"
      expr: account_number
    - name: "Aged Inventory Flag"
      expr: aged_inventory_flag
    - name: "Aging Threshold Days"
      expr: aging_threshold_days
    - name: "Audit Status"
      expr: audit_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Curtailment Due Date"
      expr: curtailment_due_date
    - name: "Curtailment Paid Flag"
      expr: curtailment_paid_flag
    - name: "Days In Inventory"
      expr: days_in_inventory
    - name: "Default Date"
      expr: default_date
    - name: "Default Flag"
      expr: default_flag
    - name: "Dms Floor Plan Reference"
      expr: dms_floor_plan_reference
    - name: "Financing End Date"
      expr: financing_end_date
    - name: "Financing Institution Code"
      expr: financing_institution_code
    - name: "Financing Institution Name"
      expr: financing_institution_name
    - name: "Financing Start Date"
      expr: financing_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Floor Plan"
      expr: COUNT(DISTINCT floor_plan_id)
    - name: "Total Credit Line Amount"
      expr: SUM(credit_line_amount)
    - name: "Average Credit Line Amount"
      expr: AVG(credit_line_amount)
    - name: "Total Curtailment Amount"
      expr: SUM(curtailment_amount)
    - name: "Average Curtailment Amount"
      expr: AVG(curtailment_amount)
    - name: "Total Daily Interest Amount"
      expr: SUM(daily_interest_amount)
    - name: "Average Daily Interest Amount"
      expr: AVG(daily_interest_amount)
    - name: "Total Dealer Invoice Amount"
      expr: SUM(dealer_invoice_amount)
    - name: "Average Dealer Invoice Amount"
      expr: AVG(dealer_invoice_amount)
    - name: "Total Interest Rate Pct"
      expr: SUM(interest_rate_pct)
    - name: "Average Interest Rate Pct"
      expr: AVG(interest_rate_pct)
    - name: "Total Msrp Amount"
      expr: SUM(msrp_amount)
    - name: "Average Msrp Amount"
      expr: AVG(msrp_amount)
    - name: "Total Oem Assistance Amount"
      expr: SUM(oem_assistance_amount)
    - name: "Average Oem Assistance Amount"
      expr: AVG(oem_assistance_amount)
    - name: "Total Outstanding Balance Amount"
      expr: SUM(outstanding_balance_amount)
    - name: "Average Outstanding Balance Amount"
      expr: AVG(outstanding_balance_amount)
    - name: "Total Payoff Amount"
      expr: SUM(payoff_amount)
    - name: "Average Payoff Amount"
      expr: AVG(payoff_amount)
    - name: "Total Per Unit Floor Plan Cost"
      expr: SUM(per_unit_floor_plan_cost)
    - name: "Average Per Unit Floor Plan Cost"
      expr: AVG(per_unit_floor_plan_cost)
    - name: "Total Total Interest Paid"
      expr: SUM(total_interest_paid)
    - name: "Average Total Interest Paid"
      expr: AVG(total_interest_paid)
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`dealer_franchise_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise Agreement business metrics"
  source: "`automotive_ecm`.`dealer`.`franchise_agreement`"
  dimensions:
    - name: "Agreement Currency Code"
      expr: agreement_currency_code
    - name: "Agreement Document Url"
      expr: agreement_document_url
    - name: "Agreement Name"
      expr: agreement_name
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Allocation Priority Tier"
      expr: allocation_priority_tier
    - name: "Authorized Nameplates"
      expr: authorized_nameplates
    - name: "Authorized Vehicle Lines"
      expr: authorized_vehicle_lines
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Certified Pre Owned Authorized Flag"
      expr: certified_pre_owned_authorized_flag
    - name: "Commercial Fleet Authorized Flag"
      expr: commercial_fleet_authorized_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dealer Signatory Name"
      expr: dealer_signatory_name
    - name: "Digital Retailing Required Flag"
      expr: digital_retailing_required_flag
    - name: "Dms Integration Required Flag"
      expr: dms_integration_required_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Franchise Agreement"
      expr: COUNT(DISTINCT franchise_agreement_id)
    - name: "Total Customer Satisfaction Target Score"
      expr: SUM(customer_satisfaction_target_score)
    - name: "Average Customer Satisfaction Target Score"
      expr: AVG(customer_satisfaction_target_score)
    - name: "Total Facility Investment Requirement Amount"
      expr: SUM(facility_investment_requirement_amount)
    - name: "Average Facility Investment Requirement Amount"
      expr: AVG(facility_investment_requirement_amount)
    - name: "Total Parts Inventory Requirement Amount"
      expr: SUM(parts_inventory_requirement_amount)
    - name: "Average Parts Inventory Requirement Amount"
      expr: AVG(parts_inventory_requirement_amount)
    - name: "Total Territory Radius Km"
      expr: SUM(territory_radius_km)
    - name: "Average Territory Radius Km"
      expr: AVG(territory_radius_km)
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`dealer_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order business metrics"
  source: "`automotive_ecm`.`dealer`.`order`"
  dimensions:
    - name: "Actual Delivery Date"
      expr: actual_delivery_date
    - name: "Actual Ship Date"
      expr: actual_ship_date
    - name: "Allocation Pool Code"
      expr: allocation_pool_code
    - name: "Cancellation Reason Code"
      expr: cancellation_reason_code
    - name: "Confirmed Delivery Date"
      expr: confirmed_delivery_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Days Late"
      expr: days_late
    - name: "Dms Order Number"
      expr: dms_order_number
    - name: "Estimated Ship Date"
      expr: estimated_ship_date
    - name: "Hold Reason Code"
      expr: hold_reason_code
    - name: "Market Code"
      expr: market_code
    - name: "Notes"
      expr: notes
    - name: "Order Date"
      expr: order_date
    - name: "Order Source"
      expr: order_source
    - name: "Order Status"
      expr: order_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Order"
      expr: COUNT(DISTINCT order_id)
    - name: "Total Dealer Invoice Amount"
      expr: SUM(dealer_invoice_amount)
    - name: "Average Dealer Invoice Amount"
      expr: AVG(dealer_invoice_amount)
    - name: "Total Incentive Amount"
      expr: SUM(incentive_amount)
    - name: "Average Incentive Amount"
      expr: AVG(incentive_amount)
    - name: "Total Msrp Amount"
      expr: SUM(msrp_amount)
    - name: "Average Msrp Amount"
      expr: AVG(msrp_amount)
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`dealer_parts_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Parts Inventory business metrics"
  source: "`automotive_ecm`.`dealer`.`parts_inventory`"
  dimensions:
    - name: "Bin Location"
      expr: bin_location
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Inventory Snapshot Date"
      expr: inventory_snapshot_date
    - name: "Inventory Status"
      expr: inventory_status
    - name: "Is Core Part"
      expr: is_core_part
    - name: "Is Hazardous Material"
      expr: is_hazardous_material
    - name: "Is Serialized"
      expr: is_serialized
    - name: "Last Count Date"
      expr: last_count_date
    - name: "Last Receipt Date"
      expr: last_receipt_date
    - name: "Last Sale Date"
      expr: last_sale_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Model Year Applicability"
      expr: model_year_applicability
    - name: "Parts Classification"
      expr: parts_classification
    - name: "Parts Group Code"
      expr: parts_group_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Parts Inventory"
      expr: COUNT(DISTINCT parts_inventory_id)
    - name: "Total Average Monthly Demand"
      expr: SUM(average_monthly_demand)
    - name: "Average Average Monthly Demand"
      expr: AVG(average_monthly_demand)
    - name: "Total Core Charge Amount"
      expr: SUM(core_charge_amount)
    - name: "Average Core Charge Amount"
      expr: AVG(core_charge_amount)
    - name: "Total Dealer Cost Price"
      expr: SUM(dealer_cost_price)
    - name: "Average Dealer Cost Price"
      expr: AVG(dealer_cost_price)
    - name: "Total List Price"
      expr: SUM(list_price)
    - name: "Average List Price"
      expr: AVG(list_price)
    - name: "Total Lost Sales Quantity"
      expr: SUM(lost_sales_quantity)
    - name: "Average Lost Sales Quantity"
      expr: AVG(lost_sales_quantity)
    - name: "Total Maximum Stock Level"
      expr: SUM(maximum_stock_level)
    - name: "Average Maximum Stock Level"
      expr: AVG(maximum_stock_level)
    - name: "Total Months Supply"
      expr: SUM(months_supply)
    - name: "Average Months Supply"
      expr: AVG(months_supply)
    - name: "Total Quantity Available"
      expr: SUM(quantity_available)
    - name: "Average Quantity Available"
      expr: AVG(quantity_available)
    - name: "Total Quantity On Hand"
      expr: SUM(quantity_on_hand)
    - name: "Average Quantity On Hand"
      expr: AVG(quantity_on_hand)
    - name: "Total Quantity On Order"
      expr: SUM(quantity_on_order)
    - name: "Average Quantity On Order"
      expr: AVG(quantity_on_order)
    - name: "Total Quantity Reserved"
      expr: SUM(quantity_reserved)
    - name: "Average Quantity Reserved"
      expr: AVG(quantity_reserved)
    - name: "Total Reorder Point"
      expr: SUM(reorder_point)
    - name: "Average Reorder Point"
      expr: AVG(reorder_point)
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`dealer_recall_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recall Completion business metrics"
  source: "`automotive_ecm`.`dealer`.`recall_completion`"
  dimensions:
    - name: "Completion Date"
      expr: completion_date
    - name: "Completion Number"
      expr: completion_number
    - name: "Completion Status"
      expr: completion_status
    - name: "Completion Timestamp"
      expr: completion_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Notification Date"
      expr: customer_notification_date
    - name: "Customer Notification Method"
      expr: customer_notification_method
    - name: "Dms Transaction Reference"
      expr: dms_transaction_reference
    - name: "Nhtsa Report Date"
      expr: nhtsa_report_date
    - name: "Nhtsa Report Flag"
      expr: nhtsa_report_flag
    - name: "Odometer Reading"
      expr: odometer_reading
    - name: "Odometer Unit"
      expr: odometer_unit
    - name: "Parts Quantity List"
      expr: parts_quantity_list
    - name: "Parts Used List"
      expr: parts_used_list
    - name: "Post Repair Inspection Notes"
      expr: post_repair_inspection_notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Recall Completion"
      expr: COUNT(DISTINCT recall_completion_id)
    - name: "Total Labor Amount"
      expr: SUM(labor_amount)
    - name: "Average Labor Amount"
      expr: AVG(labor_amount)
    - name: "Total Labor Hours"
      expr: SUM(labor_hours)
    - name: "Average Labor Hours"
      expr: AVG(labor_hours)
    - name: "Total Parts Amount"
      expr: SUM(parts_amount)
    - name: "Average Parts Amount"
      expr: AVG(parts_amount)
    - name: "Total Sublet Amount"
      expr: SUM(sublet_amount)
    - name: "Average Sublet Amount"
      expr: AVG(sublet_amount)
    - name: "Total Total Reimbursement Amount"
      expr: SUM(total_reimbursement_amount)
    - name: "Average Total Reimbursement Amount"
      expr: AVG(total_reimbursement_amount)
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`dealer_retail_sale`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retail Sale business metrics"
  source: "`automotive_ecm`.`dealer`.`retail_sale`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Deal Number"
      expr: deal_number
    - name: "Deal Status"
      expr: deal_status
    - name: "Delivery Date"
      expr: delivery_date
    - name: "Dms Deal Reference"
      expr: dms_deal_reference
    - name: "Financing Type"
      expr: financing_type
    - name: "Fleet Sale"
      expr: fleet_sale
    - name: "Lender Name"
      expr: lender_name
    - name: "Loan Term Months"
      expr: loan_term_months
    - name: "Model Year"
      expr: model_year
    - name: "Oem Program Code"
      expr: oem_program_code
    - name: "Pdi Completed"
      expr: pdi_completed
    - name: "Sale Date"
      expr: sale_date
    - name: "Stock Number"
      expr: stock_number
    - name: "Trade In Vin"
      expr: trade_in_vin
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Retail Sale"
      expr: COUNT(DISTINCT retail_sale_id)
    - name: "Total Apr"
      expr: SUM(apr)
    - name: "Average Apr"
      expr: AVG(apr)
    - name: "Total Back End Gross"
      expr: SUM(back_end_gross)
    - name: "Average Back End Gross"
      expr: AVG(back_end_gross)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Doc Fee"
      expr: SUM(doc_fee)
    - name: "Average Doc Fee"
      expr: AVG(doc_fee)
    - name: "Total Down Payment"
      expr: SUM(down_payment)
    - name: "Average Down Payment"
      expr: AVG(down_payment)
    - name: "Total Fi Product Revenue"
      expr: SUM(fi_product_revenue)
    - name: "Average Fi Product Revenue"
      expr: AVG(fi_product_revenue)
    - name: "Total Finance Amount"
      expr: SUM(finance_amount)
    - name: "Average Finance Amount"
      expr: AVG(finance_amount)
    - name: "Total Front End Gross"
      expr: SUM(front_end_gross)
    - name: "Average Front End Gross"
      expr: AVG(front_end_gross)
    - name: "Total Monthly Payment"
      expr: SUM(monthly_payment)
    - name: "Average Monthly Payment"
      expr: AVG(monthly_payment)
    - name: "Total Msrp Amount"
      expr: SUM(msrp_amount)
    - name: "Average Msrp Amount"
      expr: AVG(msrp_amount)
    - name: "Total Oem Incentive Amount"
      expr: SUM(oem_incentive_amount)
    - name: "Average Oem Incentive Amount"
      expr: AVG(oem_incentive_amount)
    - name: "Total Sale Price"
      expr: SUM(sale_price)
    - name: "Average Sale Price"
      expr: AVG(sale_price)
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`dealer_vehicle_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle Allocation business metrics"
  source: "`automotive_ecm`.`dealer`.`vehicle_allocation`"
  dimensions:
    - name: "Acceptance Deadline"
      expr: acceptance_deadline
    - name: "Acceptance Timestamp"
      expr: acceptance_timestamp
    - name: "Accepted Quantity"
      expr: accepted_quantity
    - name: "Actual Delivery Date"
      expr: actual_delivery_date
    - name: "Allocation Batch Number"
      expr: allocation_batch_number
    - name: "Allocation Date"
      expr: allocation_date
    - name: "Allocation Number"
      expr: allocation_number
    - name: "Allocation Rule Code"
      expr: allocation_rule_code
    - name: "Allocation Status"
      expr: allocation_status
    - name: "Allocation Type"
      expr: allocation_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dms Reference Number"
      expr: dms_reference_number
    - name: "Estimated Delivery Date"
      expr: estimated_delivery_date
    - name: "Hold Code"
      expr: hold_code
    - name: "Incentive Program Code"
      expr: incentive_program_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vehicle Allocation"
      expr: COUNT(DISTINCT vehicle_allocation_id)
    - name: "Total Dealer Invoice Price"
      expr: SUM(dealer_invoice_price)
    - name: "Average Dealer Invoice Price"
      expr: AVG(dealer_invoice_price)
    - name: "Total Incentive Amount"
      expr: SUM(incentive_amount)
    - name: "Average Incentive Amount"
      expr: AVG(incentive_amount)
    - name: "Total Msrp"
      expr: SUM(msrp)
    - name: "Average Msrp"
      expr: AVG(msrp)
$$;