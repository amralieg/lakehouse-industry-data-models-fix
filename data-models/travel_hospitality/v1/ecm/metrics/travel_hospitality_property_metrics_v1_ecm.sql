-- Metric views for domain: property | Business: Travel Hospitality | Version: 1 | Generated on: 2026-05-08 03:57:43

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Certification business metrics"
  source: "`travel_hospitality_ecm`.`property`.`certification`"
  dimensions:
    - name: "Accreditation Body"
      expr: accreditation_body
    - name: "Audit End Date"
      expr: audit_end_date
    - name: "Audit Section Scores"
      expr: audit_section_scores
    - name: "Audit Start Date"
      expr: audit_start_date
    - name: "Auditor Firm"
      expr: auditor_firm
    - name: "Auditor Name"
      expr: auditor_name
    - name: "Certificate Number"
      expr: certificate_number
    - name: "Certification Level"
      expr: certification_level
    - name: "Certification Name"
      expr: certification_name
    - name: "Certification Scope"
      expr: certification_scope
    - name: "Certification Status"
      expr: certification_status
    - name: "Certification Type"
      expr: certification_type
    - name: "Compliance Notes"
      expr: compliance_notes
    - name: "Corrective Action Plan Reference"
      expr: corrective_action_plan_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Critical Deficiency Count"
      expr: critical_deficiency_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Certification"
      expr: COUNT(DISTINCT certification_id)
    - name: "Total Compliance Score"
      expr: SUM(compliance_score)
    - name: "Average Compliance Score"
      expr: AVG(compliance_score)
    - name: "Total Permit Fee Amount"
      expr: SUM(permit_fee_amount)
    - name: "Average Permit Fee Amount"
      expr: AVG(permit_fee_amount)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_channel_connection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel Connection business metrics"
  source: "`travel_hospitality_ecm`.`property`.`channel_connection`"
  dimensions:
    - name: "Activation Date"
      expr: activation_date
    - name: "Connectivity Status"
      expr: connectivity_status
    - name: "Content Last Updated"
      expr: content_last_updated
    - name: "Contract Reference"
      expr: contract_reference
    - name: "Deactivation Date"
      expr: deactivation_date
    - name: "Inventory Allocation Method"
      expr: inventory_allocation_method
    - name: "Last Booking Received"
      expr: last_booking_received
    - name: "Rate Loading Protocol"
      expr: rate_loading_protocol
    - name: "Rate Parity Exception"
      expr: rate_parity_exception
    - name: "Activation Date Month"
      expr: DATE_TRUNC('MONTH', activation_date)
    - name: "Content Last Updated Month"
      expr: DATE_TRUNC('MONTH', content_last_updated)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Channel Connection"
      expr: COUNT(DISTINCT channel_connection_id)
    - name: "Total Commission Rate Override"
      expr: SUM(commission_rate_override)
    - name: "Average Commission Rate Override"
      expr: AVG(commission_rate_override)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_currency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Currency business metrics"
  source: "`travel_hospitality_ecm`.`property`.`currency`"
  dimensions:
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Currency Name"
      expr: currency_name
    - name: "Currency Status"
      expr: currency_status
    - name: "Decimal Places"
      expr: decimal_places
    - name: "Display Format"
      expr: display_format
    - name: "Effective Date"
      expr: effective_date
    - name: "Erp Currency Code"
      expr: erp_currency_code
    - name: "Exchange Rate Source"
      expr: exchange_rate_source
    - name: "Exchange Rate Update Frequency"
      expr: exchange_rate_update_frequency
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Is Active"
      expr: is_active
    - name: "Is Base Currency"
      expr: is_base_currency
    - name: "Is Crypto Currency"
      expr: is_crypto_currency
    - name: "Minor Unit"
      expr: minor_unit
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Currency"
      expr: COUNT(DISTINCT currency_id)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_franchise_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise Agreement business metrics"
  source: "`travel_hospitality_ecm`.`property`.`franchise_agreement`"
  dimensions:
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Brand Code"
      expr: brand_code
    - name: "Brand Segment"
      expr: brand_segment
    - name: "Brand Standard Version"
      expr: brand_standard_version
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crs Connectivity Required"
      expr: crs_connectivity_required
    - name: "Effective Date"
      expr: effective_date
    - name: "Exclusive Territory"
      expr: exclusive_territory
    - name: "Executed Date"
      expr: executed_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Fdd Registration Number"
      expr: fdd_registration_number
    - name: "Franchisee Entity Name"
      expr: franchisee_entity_name
    - name: "Governing Law Country"
      expr: governing_law_country
    - name: "Governing Law State"
      expr: governing_law_state
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Franchise Agreement"
      expr: COUNT(DISTINCT franchise_agreement_id)
    - name: "Total Ff And E Reserve Pct"
      expr: SUM(ff_and_e_reserve_pct)
    - name: "Average Ff And E Reserve Pct"
      expr: AVG(ff_and_e_reserve_pct)
    - name: "Total Liquidated Damages Amount"
      expr: SUM(liquidated_damages_amount)
    - name: "Average Liquidated Damages Amount"
      expr: AVG(liquidated_damages_amount)
    - name: "Total Loyalty Fee Pct"
      expr: SUM(loyalty_fee_pct)
    - name: "Average Loyalty Fee Pct"
      expr: AVG(loyalty_fee_pct)
    - name: "Total Management Fee Base Pct"
      expr: SUM(management_fee_base_pct)
    - name: "Average Management Fee Base Pct"
      expr: AVG(management_fee_base_pct)
    - name: "Total Management Fee Incentive Pct"
      expr: SUM(management_fee_incentive_pct)
    - name: "Average Management Fee Incentive Pct"
      expr: AVG(management_fee_incentive_pct)
    - name: "Total Marketing Fee Pct"
      expr: SUM(marketing_fee_pct)
    - name: "Average Marketing Fee Pct"
      expr: AVG(marketing_fee_pct)
    - name: "Total Pip Budget Amount"
      expr: SUM(pip_budget_amount)
    - name: "Average Pip Budget Amount"
      expr: AVG(pip_budget_amount)
    - name: "Total Quality Assurance Score Min"
      expr: SUM(quality_assurance_score_min)
    - name: "Average Quality Assurance Score Min"
      expr: AVG(quality_assurance_score_min)
    - name: "Total Reservation Fee Pct"
      expr: SUM(reservation_fee_pct)
    - name: "Average Reservation Fee Pct"
      expr: AVG(reservation_fee_pct)
    - name: "Total Royalty Fee Pct"
      expr: SUM(royalty_fee_pct)
    - name: "Average Royalty Fee Pct"
      expr: AVG(royalty_fee_pct)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_gds_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gds Profile business metrics"
  source: "`travel_hospitality_ecm`.`property`.`gds_profile`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Amadeus Property Code"
      expr: amadeus_property_code
    - name: "Brand Code"
      expr: brand_code
    - name: "Brand Name"
      expr: brand_name
    - name: "Chain Code"
      expr: chain_code
    - name: "Check In Time"
      expr: check_in_time
    - name: "Check Out Time"
      expr: check_out_time
    - name: "City Code"
      expr: city_code
    - name: "City Name"
      expr: city_name
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crs Property Code"
      expr: crs_property_code
    - name: "Display Name"
      expr: display_name
    - name: "Distribution Channel Type"
      expr: distribution_channel_type
    - name: "Fax Number"
      expr: fax_number
    - name: "Floor Count"
      expr: floor_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Gds Profile"
      expr: COUNT(DISTINCT gds_profile_id)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Star Rating"
      expr: SUM(star_rating)
    - name: "Average Star Rating"
      expr: AVG(star_rating)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_hierarchy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hierarchy business metrics"
  source: "`travel_hospitality_ecm`.`property`.`hierarchy`"
  dimensions:
    - name: "Brand Portfolio"
      expr: brand_portfolio
    - name: "Chain Scale"
      expr: chain_scale
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Fiscal Year Start Month"
      expr: fiscal_year_start_month
    - name: "Gds Chain Code"
      expr: gds_chain_code
    - name: "Geographic Region"
      expr: geographic_region
    - name: "Hierarchy Level"
      expr: hierarchy_level
    - name: "Is Reporting Node"
      expr: is_reporting_node
    - name: "Is Str Market Node"
      expr: is_str_market_node
    - name: "Kpi Rollup Method"
      expr: kpi_rollup_method
    - name: "Management Type"
      expr: management_type
    - name: "Node Code"
      expr: node_code
    - name: "Node Description"
      expr: node_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Hierarchy"
      expr: COUNT(DISTINCT hierarchy_id)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_legal_entity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Legal Entity business metrics"
  source: "`travel_hospitality_ecm`.`property`.`legal_entity`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dissolution Date"
      expr: dissolution_date
    - name: "Doing Business As Name"
      expr: doing_business_as_name
    - name: "Duns Number"
      expr: duns_number
    - name: "Entity Subtype"
      expr: entity_subtype
    - name: "Entity Type"
      expr: entity_type
    - name: "Fiscal Year End Day"
      expr: fiscal_year_end_day
    - name: "Fiscal Year End Month"
      expr: fiscal_year_end_month
    - name: "Franchisee Name"
      expr: franchisee_name
    - name: "Functional Currency Code"
      expr: functional_currency_code
    - name: "Incorporation Date"
      expr: incorporation_date
    - name: "Incorporation Jurisdiction"
      expr: incorporation_jurisdiction
    - name: "Is Franchise Entity"
      expr: is_franchise_entity
    - name: "Is Publicly Traded"
      expr: is_publicly_traded
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Legal Name"
      expr: legal_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Legal Entity"
      expr: COUNT(DISTINCT legal_entity_id)
    - name: "Total Ownership Percentage"
      expr: SUM(ownership_percentage)
    - name: "Average Ownership Percentage"
      expr: AVG(ownership_percentage)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_media`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Media business metrics"
  source: "`travel_hospitality_ecm`.`property`.`media`"
  dimensions:
    - name: "Alt Text"
      expr: alt_text
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Aspect Ratio"
      expr: aspect_ratio
    - name: "Asset Code"
      expr: asset_code
    - name: "Brand Website Approved"
      expr: brand_website_approved
    - name: "Caption"
      expr: caption
    - name: "Capture Date"
      expr: capture_date
    - name: "Cdn Path"
      expr: cdn_path
    - name: "Copyright Holder"
      expr: copyright_holder
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Display Order"
      expr: display_order
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "File Format"
      expr: file_format
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Media"
      expr: COUNT(DISTINCT media_id)
    - name: "Total File Size Kb"
      expr: SUM(file_size_kb)
    - name: "Average File Size Kb"
      expr: AVG(file_size_kb)
    - name: "Total View Count"
      expr: SUM(view_count)
    - name: "Average View Count"
      expr: AVG(view_count)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_meeting_space`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Meeting Space business metrics"
  source: "`travel_hospitality_ecm`.`property`.`meeting_space`"
  dimensions:
    - name: "Accessibility Compliant"
      expr: accessibility_compliant
    - name: "Adjacent Prefunction Space"
      expr: adjacent_prefunction_space
    - name: "Blackout Capability"
      expr: blackout_capability
    - name: "Builtin Av Equipment"
      expr: builtin_av_equipment
    - name: "Capacity Banquet"
      expr: capacity_banquet
    - name: "Capacity Classroom"
      expr: capacity_classroom
    - name: "Capacity Hollow Square"
      expr: capacity_hollow_square
    - name: "Capacity Reception"
      expr: capacity_reception
    - name: "Capacity Theater"
      expr: capacity_theater
    - name: "Capacity U Shape"
      expr: capacity_u_shape
    - name: "Catering Required"
      expr: catering_required
    - name: "Climate Control Type"
      expr: climate_control_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dedicated Wifi Bandwidth Mbps"
      expr: dedicated_wifi_bandwidth_mbps
    - name: "Divisible"
      expr: divisible
    - name: "Emergency Exit Count"
      expr: emergency_exit_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Meeting Space"
      expr: COUNT(DISTINCT meeting_space_id)
    - name: "Total Ceiling Height Feet"
      expr: SUM(ceiling_height_feet)
    - name: "Average Ceiling Height Feet"
      expr: AVG(ceiling_height_feet)
    - name: "Total Entrance Width Inches"
      expr: SUM(entrance_width_inches)
    - name: "Average Entrance Width Inches"
      expr: AVG(entrance_width_inches)
    - name: "Total Minimum Catering Spend"
      expr: SUM(minimum_catering_spend)
    - name: "Average Minimum Catering Spend"
      expr: AVG(minimum_catering_spend)
    - name: "Total Minimum Rental Hours"
      expr: SUM(minimum_rental_hours)
    - name: "Average Minimum Rental Hours"
      expr: AVG(minimum_rental_hours)
    - name: "Total Total Square Footage"
      expr: SUM(total_square_footage)
    - name: "Average Total Square Footage"
      expr: AVG(total_square_footage)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_ownership_entity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ownership Entity business metrics"
  source: "`travel_hospitality_ecm`.`property`.`ownership_entity`"
  dimensions:
    - name: "Acquisition Date"
      expr: acquisition_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Entity Type"
      expr: entity_type
    - name: "Investment Vehicle Name"
      expr: investment_vehicle_name
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Legal Entity Name"
      expr: legal_entity_name
    - name: "Management Company Affiliation"
      expr: management_company_affiliation
    - name: "Ownership Notes"
      expr: ownership_notes
    - name: "Ownership Status"
      expr: ownership_status
    - name: "Primary Contact Email"
      expr: primary_contact_email
    - name: "Primary Contact Name"
      expr: primary_contact_name
    - name: "Primary Contact Phone"
      expr: primary_contact_phone
    - name: "Registered Address Line1"
      expr: registered_address_line1
    - name: "Registered Address Line2"
      expr: registered_address_line2
    - name: "Registered City"
      expr: registered_city
    - name: "Registered Country Code"
      expr: registered_country_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ownership Entity"
      expr: COUNT(DISTINCT ownership_entity_id)
    - name: "Total Portfolio Acquisition Value Usd"
      expr: SUM(portfolio_acquisition_value_usd)
    - name: "Average Portfolio Acquisition Value Usd"
      expr: AVG(portfolio_acquisition_value_usd)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_party`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Party business metrics"
  source: "`travel_hospitality_ecm`.`property`.`party`"
  dimensions:
    - name: "Address Line 1"
      expr: address_line_1
    - name: "Address Line 2"
      expr: address_line_2
    - name: "City"
      expr: city
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Rating"
      expr: credit_rating
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Employee Count"
      expr: employee_count
    - name: "Fax Number"
      expr: fax_number
    - name: "Incorporation Country Code"
      expr: incorporation_country_code
    - name: "Incorporation Date"
      expr: incorporation_date
    - name: "Industry Classification Code"
      expr: industry_classification_code
    - name: "Is Publicly Traded"
      expr: is_publicly_traded
    - name: "Is Tax Exempt"
      expr: is_tax_exempt
    - name: "Legal Name"
      expr: legal_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Party"
      expr: COUNT(DISTINCT party_id)
    - name: "Total Annual Revenue Amount"
      expr: SUM(annual_revenue_amount)
    - name: "Average Annual Revenue Amount"
      expr: AVG(annual_revenue_amount)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_pip_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pip Item business metrics"
  source: "`travel_hospitality_ecm`.`property`.`pip_item`"
  dimensions:
    - name: "Actual Completion Date"
      expr: actual_completion_date
    - name: "Actual Start Date"
      expr: actual_start_date
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Date"
      expr: approved_date
    - name: "Asset Tag Number"
      expr: asset_tag_number
    - name: "Brand Requirement Flag"
      expr: brand_requirement_flag
    - name: "Capex Budget Code"
      expr: capex_budget_code
    - name: "Compliance Deadline"
      expr: compliance_deadline
    - name: "Contract Number"
      expr: contract_number
    - name: "Contractor Name"
      expr: contractor_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deferral Reason"
      expr: deferral_reason
    - name: "Deferred Completion Date"
      expr: deferred_completion_date
    - name: "Ffe Category"
      expr: ffe_category
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Inspection Date"
      expr: inspection_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pip Item"
      expr: COUNT(DISTINCT pip_item_id)
    - name: "Total Actual Cost"
      expr: SUM(actual_cost)
    - name: "Average Actual Cost"
      expr: AVG(actual_cost)
    - name: "Total Estimated Cost"
      expr: SUM(estimated_cost)
    - name: "Average Estimated Cost"
      expr: AVG(estimated_cost)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_pip_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pip Plan business metrics"
  source: "`travel_hospitality_ecm`.`property`.`pip_plan`"
  dimensions:
    - name: "Actual Completion Date"
      expr: actual_completion_date
    - name: "Ada Compliance Included"
      expr: ada_compliance_included
    - name: "Brand Compliance Status"
      expr: brand_compliance_status
    - name: "Brand Standard Compliance Deadline"
      expr: brand_standard_compliance_deadline
    - name: "Contractor License Number"
      expr: contractor_license_number
    - name: "Contractor Name"
      expr: contractor_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Fire Safety Upgrade Included"
      expr: fire_safety_upgrade_included
    - name: "Impacted Areas"
      expr: impacted_areas
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Payback Period Months"
      expr: payback_period_months
    - name: "Permit Expiration Date"
      expr: permit_expiration_date
    - name: "Permit Issue Date"
      expr: permit_issue_date
    - name: "Permit Number"
      expr: permit_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pip Plan"
      expr: COUNT(DISTINCT pip_plan_id)
    - name: "Total Actual Spend To Date"
      expr: SUM(actual_spend_to_date)
    - name: "Average Actual Spend To Date"
      expr: AVG(actual_spend_to_date)
    - name: "Total Approved Budget"
      expr: SUM(approved_budget)
    - name: "Average Approved Budget"
      expr: AVG(approved_budget)
    - name: "Total Completion Percentage"
      expr: SUM(completion_percentage)
    - name: "Average Completion Percentage"
      expr: AVG(completion_percentage)
    - name: "Total Expected Roi Percentage"
      expr: SUM(expected_roi_percentage)
    - name: "Average Expected Roi Percentage"
      expr: AVG(expected_roi_percentage)
    - name: "Total Ffe Actual Spend"
      expr: SUM(ffe_actual_spend)
    - name: "Average Ffe Actual Spend"
      expr: AVG(ffe_actual_spend)
    - name: "Total Ffe Budget"
      expr: SUM(ffe_budget)
    - name: "Average Ffe Budget"
      expr: AVG(ffe_budget)
    - name: "Total Opex Impact Estimate"
      expr: SUM(opex_impact_estimate)
    - name: "Average Opex Impact Estimate"
      expr: AVG(opex_impact_estimate)
    - name: "Total Revenue Displacement Estimate"
      expr: SUM(revenue_displacement_estimate)
    - name: "Average Revenue Displacement Estimate"
      expr: AVG(revenue_displacement_estimate)
    - name: "Total Total Estimated Capex"
      expr: SUM(total_estimated_capex)
    - name: "Average Total Estimated Capex"
      expr: AVG(total_estimated_capex)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_property`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property business metrics"
  source: "`travel_hospitality_ecm`.`property`.`property`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Brand Code"
      expr: brand_code
    - name: "Brand Name"
      expr: brand_name
    - name: "Brand Tier"
      expr: brand_tier
    - name: "City"
      expr: city
    - name: "Closure Date"
      expr: closure_date
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dos Email"
      expr: dos_email
    - name: "Dos Name"
      expr: dos_name
    - name: "Franchise Agreement Number"
      expr: franchise_agreement_number
    - name: "Gds Property Code"
      expr: gds_property_code
    - name: "Gm Email"
      expr: gm_email
    - name: "Gm Name"
      expr: gm_name
    - name: "Is Franchised"
      expr: is_franchised
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Property"
      expr: COUNT(DISTINCT property_id)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Star Rating"
      expr: SUM(star_rating)
    - name: "Average Star Rating"
      expr: AVG(star_rating)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_property_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property Facility business metrics"
  source: "`travel_hospitality_ecm`.`property`.`property_facility`"
  dimensions:
    - name: "Ada Features"
      expr: ada_features
    - name: "Age Restriction"
      expr: age_restriction
    - name: "Av Equipment Available"
      expr: av_equipment_available
    - name: "Building Wing"
      expr: building_wing
    - name: "Capacity"
      expr: capacity
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dress Code"
      expr: dress_code
    - name: "Facility Category"
      expr: facility_category
    - name: "Facility Code"
      expr: facility_code
    - name: "Facility Name"
      expr: facility_name
    - name: "Facility Type"
      expr: facility_type
    - name: "Floor Number"
      expr: floor_number
    - name: "Inspection Result"
      expr: inspection_result
    - name: "Is 24 Hour"
      expr: is_24_hour
    - name: "Is Ada Compliant"
      expr: is_ada_compliant
    - name: "Is Fee Based"
      expr: is_fee_based
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Property Facility"
      expr: COUNT(DISTINCT property_facility_id)
    - name: "Total Area Sqft"
      expr: SUM(area_sqft)
    - name: "Average Area Sqft"
      expr: AVG(area_sqft)
    - name: "Total Max Occupancy Pct"
      expr: SUM(max_occupancy_pct)
    - name: "Average Max Occupancy Pct"
      expr: AVG(max_occupancy_pct)
    - name: "Total Usage Fee Amount"
      expr: SUM(usage_fee_amount)
    - name: "Average Usage Fee Amount"
      expr: AVG(usage_fee_amount)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_property_outlet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property Outlet business metrics"
  source: "`travel_hospitality_ecm`.`property`.`property_outlet`"
  dimensions:
    - name: "Alcohol Service Flag"
      expr: alcohol_service_flag
    - name: "Closure Date"
      expr: closure_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cuisine Type"
      expr: cuisine_type
    - name: "Delivery Service Available Flag"
      expr: delivery_service_available_flag
    - name: "Dress Code"
      expr: dress_code
    - name: "Floor Number"
      expr: floor_number
    - name: "Gratuity Policy"
      expr: gratuity_policy
    - name: "Health Permit Number"
      expr: health_permit_number
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Renovation Date"
      expr: last_renovation_date
    - name: "Liquor License Number"
      expr: liquor_license_number
    - name: "Location Description"
      expr: location_description
    - name: "Loyalty Points Eligible Flag"
      expr: loyalty_points_eligible_flag
    - name: "Menu Url"
      expr: menu_url
    - name: "Mobile Ordering Enabled Flag"
      expr: mobile_ordering_enabled_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Property Outlet"
      expr: COUNT(DISTINCT property_outlet_id)
    - name: "Total Average Check Amount"
      expr: SUM(average_check_amount)
    - name: "Average Average Check Amount"
      expr: AVG(average_check_amount)
    - name: "Total Service Charge Percentage"
      expr: SUM(service_charge_percentage)
    - name: "Average Service Charge Percentage"
      expr: AVG(service_charge_percentage)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_property_space_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property Space Allocation business metrics"
  source: "`travel_hospitality_ecm`.`property`.`property_space_allocation`"
  dimensions:
    - name: "Allocation Created Timestamp"
      expr: allocation_created_timestamp
    - name: "Allocation Date"
      expr: allocation_date
    - name: "Allocation Modified Timestamp"
      expr: allocation_modified_timestamp
    - name: "Allocation Status"
      expr: allocation_status
    - name: "End Time"
      expr: end_time
    - name: "Guaranteed Attendance"
      expr: guaranteed_attendance
    - name: "Setup Style"
      expr: setup_style
    - name: "Special Requirements"
      expr: special_requirements
    - name: "Start Time"
      expr: start_time
    - name: "Allocation Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', allocation_created_timestamp)
    - name: "Allocation Date Month"
      expr: DATE_TRUNC('MONTH', allocation_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Property Space Allocation"
      expr: COUNT(DISTINCT property_space_allocation_id)
    - name: "Total Rental Charge"
      expr: SUM(rental_charge)
    - name: "Average Rental Charge"
      expr: AVG(rental_charge)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_seasonal_calendar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Seasonal Calendar business metrics"
  source: "`travel_hospitality_ecm`.`property`.`seasonal_calendar`"
  dimensions:
    - name: "Advance Booking Days"
      expr: advance_booking_days
    - name: "Blackout Reason"
      expr: blackout_reason
    - name: "Climate Description"
      expr: climate_description
    - name: "Competitive Set Position"
      expr: competitive_set_position
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Demand Classification"
      expr: demand_classification
    - name: "End Date"
      expr: end_date
    - name: "Facility Closures"
      expr: facility_closures
    - name: "Holiday Name"
      expr: holiday_name
    - name: "Is Blackout Date"
      expr: is_blackout_date
    - name: "Is Holiday Period"
      expr: is_holiday_period
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Market Segment Focus"
      expr: market_segment_focus
    - name: "Maximum Los Restriction"
      expr: maximum_los_restriction
    - name: "Minimum Los Restriction"
      expr: minimum_los_restriction
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Seasonal Calendar"
      expr: COUNT(DISTINCT seasonal_calendar_id)
    - name: "Total Cancellation Rate Pct"
      expr: SUM(cancellation_rate_pct)
    - name: "Average Cancellation Rate Pct"
      expr: AVG(cancellation_rate_pct)
    - name: "Total Estimated Adr"
      expr: SUM(estimated_adr)
    - name: "Average Estimated Adr"
      expr: AVG(estimated_adr)
    - name: "Total Estimated Occupancy Pct"
      expr: SUM(estimated_occupancy_pct)
    - name: "Average Estimated Occupancy Pct"
      expr: AVG(estimated_occupancy_pct)
    - name: "Total Estimated Revpar"
      expr: SUM(estimated_revpar)
    - name: "Average Estimated Revpar"
      expr: AVG(estimated_revpar)
    - name: "Total No Show Rate Pct"
      expr: SUM(no_show_rate_pct)
    - name: "Average No Show Rate Pct"
      expr: AVG(no_show_rate_pct)
    - name: "Total Rgi Target"
      expr: SUM(rgi_target)
    - name: "Average Rgi Target"
      expr: AVG(rgi_target)
    - name: "Total Yoy Demand Variance Pct"
      expr: SUM(yoy_demand_variance_pct)
    - name: "Average Yoy Demand Variance Pct"
      expr: AVG(yoy_demand_variance_pct)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_vendor_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor Agreement business metrics"
  source: "`travel_hospitality_ecm`.`property`.`vendor_agreement`"
  dimensions:
    - name: "Contract Reference Number"
      expr: contract_reference_number
    - name: "Created Date"
      expr: created_date
    - name: "Delivery Lead Time Days"
      expr: delivery_lead_time_days
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Date"
      expr: last_modified_date
    - name: "Last Performance Review Date"
      expr: last_performance_review_date
    - name: "Local Contact Email"
      expr: local_contact_email
    - name: "Local Contact Name"
      expr: local_contact_name
    - name: "Local Contact Phone"
      expr: local_contact_phone
    - name: "Payment Terms Override"
      expr: payment_terms_override
    - name: "Preferred Vendor Tier"
      expr: preferred_vendor_tier
    - name: "Relationship End Date"
      expr: relationship_end_date
    - name: "Relationship Start Date"
      expr: relationship_start_date
    - name: "Relationship Status"
      expr: relationship_status
    - name: "Created Date Month"
      expr: DATE_TRUNC('MONTH', created_date)
    - name: "Last Modified Date Month"
      expr: DATE_TRUNC('MONTH', last_modified_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vendor Agreement"
      expr: COUNT(DISTINCT vendor_agreement_id)
    - name: "Total Minimum Order Value"
      expr: SUM(minimum_order_value)
    - name: "Average Minimum Order Value"
      expr: AVG(minimum_order_value)
    - name: "Total Performance Rating"
      expr: SUM(performance_rating)
    - name: "Average Performance Rating"
      expr: AVG(performance_rating)
    - name: "Total Property Specific Discount Pct"
      expr: SUM(property_specific_discount_pct)
    - name: "Average Property Specific Discount Pct"
      expr: AVG(property_specific_discount_pct)
$$;