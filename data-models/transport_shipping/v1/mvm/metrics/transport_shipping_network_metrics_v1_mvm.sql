-- Metric views for domain: network | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 22:34:38

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`network_agent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Agent business metrics"
  source: "`transport_shipping_ecm`.`network`.`agent`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Aeo Certified"
      expr: aeo_certified
    - name: "Agent Status"
      expr: agent_status
    - name: "Agent Type"
      expr: agent_type
    - name: "Bond Currency Code"
      expr: bond_currency_code
    - name: "Bonding Status"
      expr: bonding_status
    - name: "Business Registration Number"
      expr: business_registration_number
    - name: "City"
      expr: city
    - name: "Commission Structure Type"
      expr: commission_structure_type
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Ctpat Certified"
      expr: ctpat_certified
    - name: "Dangerous Goods Certified"
      expr: dangerous_goods_certified
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Agent"
      expr: COUNT(DISTINCT agent_id)
    - name: "Total Bond Amount"
      expr: SUM(bond_amount)
    - name: "Average Bond Amount"
      expr: AVG(bond_amount)
    - name: "Total Insurance Coverage Amount"
      expr: SUM(insurance_coverage_amount)
    - name: "Average Insurance Coverage Amount"
      expr: AVG(insurance_coverage_amount)
    - name: "Total Standard Commission Rate"
      expr: SUM(standard_commission_rate)
    - name: "Average Standard Commission Rate"
      expr: AVG(standard_commission_rate)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`network_agent_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Agent Appointment business metrics"
  source: "`transport_shipping_ecm`.`network`.`agent_appointment`"
  dimensions:
    - name: "Aeo Certification Flag"
      expr: aeo_certification_flag
    - name: "Appointment Effective Date"
      expr: appointment_effective_date
    - name: "Appointment Expiry Date"
      expr: appointment_expiry_date
    - name: "Appointment Reference Number"
      expr: appointment_reference_number
    - name: "Appointment Status"
      expr: appointment_status
    - name: "Appointment Term Months"
      expr: appointment_term_months
    - name: "Appointment Type"
      expr: appointment_type
    - name: "Approval Date"
      expr: approval_date
    - name: "Authorized Service Lines"
      expr: authorized_service_lines
    - name: "Authorized Transport Modes"
      expr: authorized_transport_modes
    - name: "Commission Basis"
      expr: commission_basis
    - name: "Commission Currency Code"
      expr: commission_currency_code
    - name: "Contract Document Reference"
      expr: contract_document_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Ctpat Certification Flag"
      expr: ctpat_certification_flag
    - name: "Customs Broker License Flag"
      expr: customs_broker_license_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Agent Appointment"
      expr: COUNT(DISTINCT agent_appointment_id)
    - name: "Total Commission Rate Percent"
      expr: SUM(commission_rate_percent)
    - name: "Average Commission Rate Percent"
      expr: AVG(commission_rate_percent)
    - name: "Total Insurance Coverage Amount"
      expr: SUM(insurance_coverage_amount)
    - name: "Average Insurance Coverage Amount"
      expr: AVG(insurance_coverage_amount)
    - name: "Total Minimum Revenue Commitment"
      expr: SUM(minimum_revenue_commitment)
    - name: "Average Minimum Revenue Commitment"
      expr: AVG(minimum_revenue_commitment)
    - name: "Total Performance Bond Amount"
      expr: SUM(performance_bond_amount)
    - name: "Average Performance Bond Amount"
      expr: AVG(performance_bond_amount)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`network_blocked_space_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Blocked Space Agreement business metrics"
  source: "`transport_shipping_ecm`.`network`.`blocked_space_agreement`"
  dimensions:
    - name: "Agreement Reference Number"
      expr: agreement_reference_number
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Allocation Frequency"
      expr: allocation_frequency
    - name: "Blocked Space Agreement Status"
      expr: blocked_space_agreement_status
    - name: "Capacity Unit Of Measure"
      expr: capacity_unit_of_measure
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Destination Region"
      expr: destination_region
    - name: "Dispute Resolution Mechanism"
      expr: dispute_resolution_mechanism
    - name: "Effective Date"
      expr: effective_date
    - name: "Exclusivity Flag"
      expr: exclusivity_flag
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Force Majeure Clause"
      expr: force_majeure_clause
    - name: "Governing Law"
      expr: governing_law
    - name: "Last Modified By User"
      expr: last_modified_by_user
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Blocked Space Agreement"
      expr: COUNT(DISTINCT blocked_space_agreement_id)
    - name: "Total Base Rate Per Unit"
      expr: SUM(base_rate_per_unit)
    - name: "Average Base Rate Per Unit"
      expr: AVG(base_rate_per_unit)
    - name: "Total Guaranteed Capacity Cbm"
      expr: SUM(guaranteed_capacity_cbm)
    - name: "Average Guaranteed Capacity Cbm"
      expr: AVG(guaranteed_capacity_cbm)
    - name: "Total Guaranteed Capacity Kg"
      expr: SUM(guaranteed_capacity_kg)
    - name: "Average Guaranteed Capacity Kg"
      expr: AVG(guaranteed_capacity_kg)
    - name: "Total Guaranteed Capacity Teu"
      expr: SUM(guaranteed_capacity_teu)
    - name: "Average Guaranteed Capacity Teu"
      expr: AVG(guaranteed_capacity_teu)
    - name: "Total Minimum Utilization Commitment Absolute"
      expr: SUM(minimum_utilization_commitment_absolute)
    - name: "Average Minimum Utilization Commitment Absolute"
      expr: AVG(minimum_utilization_commitment_absolute)
    - name: "Total Minimum Utilization Commitment Percent"
      expr: SUM(minimum_utilization_commitment_percent)
    - name: "Average Minimum Utilization Commitment Percent"
      expr: AVG(minimum_utilization_commitment_percent)
    - name: "Total Penalty Amount"
      expr: SUM(penalty_amount)
    - name: "Average Penalty Amount"
      expr: AVG(penalty_amount)
    - name: "Total Rollover Limit Percent"
      expr: SUM(rollover_limit_percent)
    - name: "Average Rollover Limit Percent"
      expr: AVG(rollover_limit_percent)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`network_capacity_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity Allocation business metrics"
  source: "`transport_shipping_ecm`.`network`.`capacity_allocation`"
  dimensions:
    - name: "Allocated Capacity Pallet Positions"
      expr: allocated_capacity_pallet_positions
    - name: "Allocation Currency Code"
      expr: allocation_currency_code
    - name: "Allocation End Date"
      expr: allocation_end_date
    - name: "Allocation Notes"
      expr: allocation_notes
    - name: "Allocation Period Type"
      expr: allocation_period_type
    - name: "Allocation Reference Number"
      expr: allocation_reference_number
    - name: "Allocation Start Date"
      expr: allocation_start_date
    - name: "Allocation Status"
      expr: allocation_status
    - name: "Booking Cutoff Hours"
      expr: booking_cutoff_hours
    - name: "Capacity Source Type"
      expr: capacity_source_type
    - name: "Commodity Restriction"
      expr: commodity_restriction
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Destination Location Code"
      expr: destination_location_code
    - name: "Equipment Type"
      expr: equipment_type
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Origin Location Code"
      expr: origin_location_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Capacity Allocation"
      expr: COUNT(DISTINCT capacity_allocation_id)
    - name: "Total Allocated Capacity Teu"
      expr: SUM(allocated_capacity_teu)
    - name: "Average Allocated Capacity Teu"
      expr: AVG(allocated_capacity_teu)
    - name: "Total Allocated Capacity Volume Cbm"
      expr: SUM(allocated_capacity_volume_cbm)
    - name: "Average Allocated Capacity Volume Cbm"
      expr: AVG(allocated_capacity_volume_cbm)
    - name: "Total Allocated Capacity Weight Kg"
      expr: SUM(allocated_capacity_weight_kg)
    - name: "Average Allocated Capacity Weight Kg"
      expr: AVG(allocated_capacity_weight_kg)
    - name: "Total Capacity Fill Rate Percent"
      expr: SUM(capacity_fill_rate_percent)
    - name: "Average Capacity Fill Rate Percent"
      expr: AVG(capacity_fill_rate_percent)
    - name: "Total Minimum Commitment Amount"
      expr: SUM(minimum_commitment_amount)
    - name: "Average Minimum Commitment Amount"
      expr: AVG(minimum_commitment_amount)
    - name: "Total Overage Rate Per Unit"
      expr: SUM(overage_rate_per_unit)
    - name: "Average Overage Rate Per Unit"
      expr: AVG(overage_rate_per_unit)
    - name: "Total Utilized Capacity Teu"
      expr: SUM(utilized_capacity_teu)
    - name: "Average Utilized Capacity Teu"
      expr: AVG(utilized_capacity_teu)
    - name: "Total Utilized Capacity Volume Cbm"
      expr: SUM(utilized_capacity_volume_cbm)
    - name: "Average Utilized Capacity Volume Cbm"
      expr: AVG(utilized_capacity_volume_cbm)
    - name: "Total Utilized Capacity Weight Kg"
      expr: SUM(utilized_capacity_weight_kg)
    - name: "Average Utilized Capacity Weight Kg"
      expr: AVG(utilized_capacity_weight_kg)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`network_carrier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier business metrics"
  source: "`transport_shipping_ecm`.`network`.`carrier`"
  dimensions:
    - name: "Aeo Certified"
      expr: aeo_certified
    - name: "Api Integration Enabled"
      expr: api_integration_enabled
    - name: "Carrier Type"
      expr: carrier_type
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Country Of Registration"
      expr: country_of_registration
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Rating"
      expr: credit_rating
    - name: "Ctpat Certified"
      expr: ctpat_certified
    - name: "Customs Brokerage Service"
      expr: customs_brokerage_service
    - name: "Dangerous Goods Certified"
      expr: dangerous_goods_certified
    - name: "Edi Enabled"
      expr: edi_enabled
    - name: "Fiata Certified"
      expr: fiata_certified
    - name: "Financial Standing"
      expr: financial_standing
    - name: "Headquarters Address"
      expr: headquarters_address
    - name: "Headquarters Country"
      expr: headquarters_country
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Carrier"
      expr: COUNT(DISTINCT carrier_id)
    - name: "Total Insurance Coverage Amount"
      expr: SUM(insurance_coverage_amount)
    - name: "Average Insurance Coverage Amount"
      expr: AVG(insurance_coverage_amount)
    - name: "Total Otd Percentage"
      expr: SUM(otd_percentage)
    - name: "Average Otd Percentage"
      expr: AVG(otd_percentage)
    - name: "Total Performance Rating"
      expr: SUM(performance_rating)
    - name: "Average Performance Rating"
      expr: AVG(performance_rating)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`network_carrier_contact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier Contact business metrics"
  source: "`transport_shipping_ecm`.`network`.`carrier_contact`"
  dimensions:
    - name: "Active Status"
      expr: active_status
    - name: "Contact First Name"
      expr: contact_first_name
    - name: "Contact Full Name"
      expr: contact_full_name
    - name: "Contact Last Name"
      expr: contact_last_name
    - name: "Contact Type"
      expr: contact_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crm Account Code"
      expr: crm_account_code
    - name: "Department"
      expr: department
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Email Address"
      expr: email_address
    - name: "Emergency Contact Flag"
      expr: emergency_contact_flag
    - name: "Escalation Level"
      expr: escalation_level
    - name: "Fax Number"
      expr: fax_number
    - name: "Job Title"
      expr: job_title
    - name: "Language Preference"
      expr: language_preference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Carrier Contact"
      expr: COUNT(DISTINCT carrier_contact_id)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`network_carrier_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier Profile business metrics"
  source: "`transport_shipping_ecm`.`network`.`carrier_profile`"
  dimensions:
    - name: "Api Integration Available"
      expr: api_integration_available
    - name: "Api Protocol"
      expr: api_protocol
    - name: "Carbon Reporting Available"
      expr: carbon_reporting_available
    - name: "Countries Served"
      expr: countries_served
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cross Border Capable"
      expr: cross_border_capable
    - name: "Customs Brokerage Included"
      expr: customs_brokerage_included
    - name: "Dangerous Goods Certified"
      expr: dangerous_goods_certified
    - name: "Dg Classes Handled"
      expr: dg_classes_handled
    - name: "Edi Capable"
      expr: edi_capable
    - name: "Effective Date"
      expr: effective_date
    - name: "Equipment Types"
      expr: equipment_types
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Geographic Coverage Scope"
      expr: geographic_coverage_scope
    - name: "Insurance Coverage Available"
      expr: insurance_coverage_available
    - name: "Last Mile Capable"
      expr: last_mile_capable
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Carrier Profile"
      expr: COUNT(DISTINCT carrier_profile_id)
    - name: "Total Average Transit Time Days"
      expr: SUM(average_transit_time_days)
    - name: "Average Average Transit Time Days"
      expr: AVG(average_transit_time_days)
    - name: "Total Claims Ratio Percentage"
      expr: SUM(claims_ratio_percentage)
    - name: "Average Claims Ratio Percentage"
      expr: AVG(claims_ratio_percentage)
    - name: "Total Max Insurance Value Usd"
      expr: SUM(max_insurance_value_usd)
    - name: "Average Max Insurance Value Usd"
      expr: AVG(max_insurance_value_usd)
    - name: "Total Max Volume Capacity Cbm"
      expr: SUM(max_volume_capacity_cbm)
    - name: "Average Max Volume Capacity Cbm"
      expr: AVG(max_volume_capacity_cbm)
    - name: "Total Max Weight Capacity Kg"
      expr: SUM(max_weight_capacity_kg)
    - name: "Average Max Weight Capacity Kg"
      expr: AVG(max_weight_capacity_kg)
    - name: "Total Otd Percentage"
      expr: SUM(otd_percentage)
    - name: "Average Otd Percentage"
      expr: AVG(otd_percentage)
    - name: "Total Temperature Range Max Celsius"
      expr: SUM(temperature_range_max_celsius)
    - name: "Average Temperature Range Max Celsius"
      expr: AVG(temperature_range_max_celsius)
    - name: "Total Temperature Range Min Celsius"
      expr: SUM(temperature_range_min_celsius)
    - name: "Average Temperature Range Min Celsius"
      expr: AVG(temperature_range_min_celsius)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`network_carrier_service`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier Service business metrics"
  source: "`transport_shipping_ecm`.`network`.`carrier_service`"
  dimensions:
    - name: "Carbon Neutral Certified"
      expr: carbon_neutral_certified
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customs Clearance Included"
      expr: customs_clearance_included
    - name: "Cutoff Day Offset"
      expr: cutoff_day_offset
    - name: "Cutoff Time Local"
      expr: cutoff_time_local
    - name: "Dangerous Goods Capable"
      expr: dangerous_goods_capable
    - name: "Destination Location Code"
      expr: destination_location_code
    - name: "Destination Region"
      expr: destination_region
    - name: "Dg Classes Supported"
      expr: dg_classes_supported
    - name: "Documentation Cutoff Time"
      expr: documentation_cutoff_time
    - name: "Door To Door Available"
      expr: door_to_door_available
    - name: "Effective Date"
      expr: effective_date
    - name: "Equipment Types Supported"
      expr: equipment_types_supported
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Flight Service Identifier"
      expr: flight_service_identifier
    - name: "Frequency"
      expr: frequency
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Carrier Service"
      expr: COUNT(DISTINCT carrier_service_id)
    - name: "Total Max Volume Capacity Cbm"
      expr: SUM(max_volume_capacity_cbm)
    - name: "Average Max Volume Capacity Cbm"
      expr: AVG(max_volume_capacity_cbm)
    - name: "Total Max Weight Capacity Kg"
      expr: SUM(max_weight_capacity_kg)
    - name: "Average Max Weight Capacity Kg"
      expr: AVG(max_weight_capacity_kg)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`network_edi_connection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Edi Connection business metrics"
  source: "`transport_shipping_ecm`.`network`.`edi_connection`"
  dimensions:
    - name: "Acknowledgment Required"
      expr: acknowledgment_required
    - name: "Authentication Method"
      expr: authentication_method
    - name: "Average Daily Message Volume"
      expr: average_daily_message_volume
    - name: "Compression Enabled"
      expr: compression_enabled
    - name: "Connection Health Status"
      expr: connection_health_status
    - name: "Connection Name"
      expr: connection_name
    - name: "Connection Reference Number"
      expr: connection_reference_number
    - name: "Connection Status"
      expr: connection_status
    - name: "Connection Type"
      expr: connection_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Encryption Enabled"
      expr: encryption_enabled
    - name: "Encryption Protocol"
      expr: encryption_protocol
    - name: "Endpoint Host"
      expr: endpoint_host
    - name: "Endpoint Port"
      expr: endpoint_port
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Edi Connection"
      expr: COUNT(DISTINCT edi_connection_id)
    - name: "Total Sla Uptime Percentage"
      expr: SUM(sla_uptime_percentage)
    - name: "Average Sla Uptime Percentage"
      expr: AVG(sla_uptime_percentage)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`network_interline_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interline Agreement business metrics"
  source: "`transport_shipping_ecm`.`network`.`interline_agreement`"
  dimensions:
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Awb Prefix Allocation"
      expr: awb_prefix_allocation
    - name: "Billing Currency Code"
      expr: billing_currency_code
    - name: "Commitment Period"
      expr: commitment_period
    - name: "Confidentiality Clause Flag"
      expr: confidentiality_clause_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Destination Region"
      expr: destination_region
    - name: "Dispute Resolution Method"
      expr: dispute_resolution_method
    - name: "Effective Date"
      expr: effective_date
    - name: "Exclusivity Flag"
      expr: exclusivity_flag
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Governing Law Jurisdiction"
      expr: governing_law_jurisdiction
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Interline Agreement"
      expr: COUNT(DISTINCT interline_agreement_id)
    - name: "Total Liability Limit Amount"
      expr: SUM(liability_limit_amount)
    - name: "Average Liability Limit Amount"
      expr: AVG(liability_limit_amount)
    - name: "Total Minimum Volume Commitment"
      expr: SUM(minimum_volume_commitment)
    - name: "Average Minimum Volume Commitment"
      expr: AVG(minimum_volume_commitment)
    - name: "Total Revenue Split Percentage"
      expr: SUM(revenue_split_percentage)
    - name: "Average Revenue Split Percentage"
      expr: AVG(revenue_split_percentage)
    - name: "Total Sla On Time Delivery Target Pct"
      expr: SUM(sla_on_time_delivery_target_pct)
    - name: "Average Sla On Time Delivery Target Pct"
      expr: AVG(sla_on_time_delivery_target_pct)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`network_network_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network Event business metrics"
  source: "`transport_shipping_ecm`.`network`.`network_event`"
  dimensions:
    - name: "Affected Airports"
      expr: affected_airports
    - name: "Affected Countries"
      expr: affected_countries
    - name: "Affected Ports"
      expr: affected_ports
    - name: "Affected Regions"
      expr: affected_regions
    - name: "Affected Trade Lanes"
      expr: affected_trade_lanes
    - name: "Affected Transport Modes"
      expr: affected_transport_modes
    - name: "Alternative Carrier Engaged"
      expr: alternative_carrier_engaged
    - name: "Alternative Routing Available"
      expr: alternative_routing_available
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Notification Datetime"
      expr: customer_notification_datetime
    - name: "Customer Notification Sent"
      expr: customer_notification_sent
    - name: "End Datetime"
      expr: end_datetime
    - name: "Escalation Datetime"
      expr: escalation_datetime
    - name: "Escalation Required"
      expr: escalation_required
    - name: "Estimated Shipments Affected"
      expr: estimated_shipments_affected
    - name: "Event Code"
      expr: event_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Network Event"
      expr: COUNT(DISTINCT network_event_id)
    - name: "Total Estimated Capacity Loss Teu"
      expr: SUM(estimated_capacity_loss_teu)
    - name: "Average Estimated Capacity Loss Teu"
      expr: AVG(estimated_capacity_loss_teu)
    - name: "Total Estimated Delay Hours"
      expr: SUM(estimated_delay_hours)
    - name: "Average Estimated Delay Hours"
      expr: AVG(estimated_delay_hours)
    - name: "Total Financial Impact Estimated Usd"
      expr: SUM(financial_impact_estimated_usd)
    - name: "Average Financial Impact Estimated Usd"
      expr: AVG(financial_impact_estimated_usd)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`network_partner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner business metrics"
  source: "`transport_shipping_ecm`.`network`.`partner`"
  dimensions:
    - name: "Address Line 1"
      expr: address_line_1
    - name: "Address Line 2"
      expr: address_line_2
    - name: "Aeo Certification"
      expr: aeo_certification
    - name: "Audit Status"
      expr: audit_status
    - name: "Bonded Warehouse License"
      expr: bonded_warehouse_license
    - name: "City"
      expr: city
    - name: "Contract Expiry Date"
      expr: contract_expiry_date
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Rating"
      expr: credit_rating
    - name: "Ctpat Certification"
      expr: ctpat_certification
    - name: "Currency Code"
      expr: currency_code
    - name: "Customs Broker License"
      expr: customs_broker_license
    - name: "Facility Type"
      expr: facility_type
    - name: "Handling Capacity"
      expr: handling_capacity
    - name: "Iata Code"
      expr: iata_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partner"
      expr: COUNT(DISTINCT partner_id)
    - name: "Total Insurance Coverage Amount"
      expr: SUM(insurance_coverage_amount)
    - name: "Average Insurance Coverage Amount"
      expr: AVG(insurance_coverage_amount)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`network_partner_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner Certification business metrics"
  source: "`transport_shipping_ecm`.`network`.`partner_certification`"
  dimensions:
    - name: "Accreditation Body"
      expr: accreditation_body
    - name: "Active Flag"
      expr: active_flag
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Certification Document Url"
      expr: certification_document_url
    - name: "Certification Number"
      expr: certification_number
    - name: "Certification Status"
      expr: certification_status
    - name: "Certification Type"
      expr: certification_type
    - name: "Compliance Level"
      expr: compliance_level
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Issue Date"
      expr: issue_date
    - name: "Issuing Authority"
      expr: issuing_authority
    - name: "Issuing Country Code"
      expr: issuing_country_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partner Certification"
      expr: COUNT(DISTINCT partner_certification_id)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`network_partner_onboarding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner Onboarding business metrics"
  source: "`transport_shipping_ecm`.`network`.`partner_onboarding`"
  dimensions:
    - name: "Actual Activation Date"
      expr: actual_activation_date
    - name: "Api Integration Status"
      expr: api_integration_status
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Certification Verification Status"
      expr: certification_verification_status
    - name: "Certification Verified Date"
      expr: certification_verified_date
    - name: "Contract Execution Date"
      expr: contract_execution_date
    - name: "Contract Reference Number"
      expr: contract_reference_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Due Diligence Completed Date"
      expr: due_diligence_completed_date
    - name: "Edi Integration Status"
      expr: edi_integration_status
    - name: "Financial Assessment Date"
      expr: financial_assessment_date
    - name: "Financial Assessment Status"
      expr: financial_assessment_status
    - name: "Geographic Scope Authorized"
      expr: geographic_scope_authorized
    - name: "Go Live Date"
      expr: go_live_date
    - name: "Initiated Date"
      expr: initiated_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partner Onboarding"
      expr: COUNT(DISTINCT partner_onboarding_id)
    - name: "Total Operational Readiness Score"
      expr: SUM(operational_readiness_score)
    - name: "Average Operational Readiness Score"
      expr: AVG(operational_readiness_score)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`network_partner_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner Performance business metrics"
  source: "`transport_shipping_ecm`.`network`.`partner_performance`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Corrective Action Due Date"
      expr: corrective_action_due_date
    - name: "Corrective Action Required Flag"
      expr: corrective_action_required_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Evaluation Completed Date"
      expr: evaluation_completed_date
    - name: "Evaluation Frequency"
      expr: evaluation_frequency
    - name: "Evaluation Period End Date"
      expr: evaluation_period_end_date
    - name: "Evaluation Period Start Date"
      expr: evaluation_period_start_date
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Review Notes"
      expr: review_notes
    - name: "Review Outcome"
      expr: review_outcome
    - name: "Service Mode"
      expr: service_mode
    - name: "Trend Direction"
      expr: trend_direction
    - name: "Approved Timestamp Month"
      expr: DATE_TRUNC('MONTH', approved_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partner Performance"
      expr: COUNT(DISTINCT partner_performance_id)
    - name: "Total Capacity Fulfillment Actual Pct"
      expr: SUM(capacity_fulfillment_actual_pct)
    - name: "Average Capacity Fulfillment Actual Pct"
      expr: AVG(capacity_fulfillment_actual_pct)
    - name: "Total Capacity Fulfillment Target Pct"
      expr: SUM(capacity_fulfillment_target_pct)
    - name: "Average Capacity Fulfillment Target Pct"
      expr: AVG(capacity_fulfillment_target_pct)
    - name: "Total Claims Rate Actual Pct"
      expr: SUM(claims_rate_actual_pct)
    - name: "Average Claims Rate Actual Pct"
      expr: AVG(claims_rate_actual_pct)
    - name: "Total Claims Rate Target Pct"
      expr: SUM(claims_rate_target_pct)
    - name: "Average Claims Rate Target Pct"
      expr: AVG(claims_rate_target_pct)
    - name: "Total Composite Score"
      expr: SUM(composite_score)
    - name: "Average Composite Score"
      expr: AVG(composite_score)
    - name: "Total Damage Rate Actual Pct"
      expr: SUM(damage_rate_actual_pct)
    - name: "Average Damage Rate Actual Pct"
      expr: AVG(damage_rate_actual_pct)
    - name: "Total Damage Rate Target Pct"
      expr: SUM(damage_rate_target_pct)
    - name: "Average Damage Rate Target Pct"
      expr: AVG(damage_rate_target_pct)
    - name: "Total Documentation Accuracy Actual Pct"
      expr: SUM(documentation_accuracy_actual_pct)
    - name: "Average Documentation Accuracy Actual Pct"
      expr: AVG(documentation_accuracy_actual_pct)
    - name: "Total Documentation Accuracy Target Pct"
      expr: SUM(documentation_accuracy_target_pct)
    - name: "Average Documentation Accuracy Target Pct"
      expr: AVG(documentation_accuracy_target_pct)
    - name: "Total Otd Rate Actual Pct"
      expr: SUM(otd_rate_actual_pct)
    - name: "Average Otd Rate Actual Pct"
      expr: AVG(otd_rate_actual_pct)
    - name: "Total Otd Rate Target Pct"
      expr: SUM(otd_rate_target_pct)
    - name: "Average Otd Rate Target Pct"
      expr: AVG(otd_rate_target_pct)
    - name: "Total Total Shipments Evaluated"
      expr: SUM(total_shipments_evaluated)
    - name: "Average Total Shipments Evaluated"
      expr: AVG(total_shipments_evaluated)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`network_partner_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner Settlement business metrics"
  source: "`transport_shipping_ecm`.`network`.`partner_settlement`"
  dimensions:
    - name: "Actual Payment Date"
      expr: actual_payment_date
    - name: "Approval Date"
      expr: approval_date
    - name: "Awb Count"
      expr: awb_count
    - name: "Bank Account Number"
      expr: bank_account_number
    - name: "Bank Name"
      expr: bank_name
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dispute Flag"
      expr: dispute_flag
    - name: "Dispute Raised Date"
      expr: dispute_raised_date
    - name: "Dispute Reason"
      expr: dispute_reason
    - name: "Dispute Resolution Date"
      expr: dispute_resolution_date
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Original Currency Code"
      expr: original_currency_code
    - name: "Payment Reference Number"
      expr: payment_reference_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partner Settlement"
      expr: COUNT(DISTINCT partner_settlement_id)
    - name: "Total Deduction Amount"
      expr: SUM(deduction_amount)
    - name: "Average Deduction Amount"
      expr: AVG(deduction_amount)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Gross Settlement Amount"
      expr: SUM(gross_settlement_amount)
    - name: "Average Gross Settlement Amount"
      expr: AVG(gross_settlement_amount)
    - name: "Total Net Settlement Amount"
      expr: SUM(net_settlement_amount)
    - name: "Average Net Settlement Amount"
      expr: AVG(net_settlement_amount)
    - name: "Total Tax Withholding Amount"
      expr: SUM(tax_withholding_amount)
    - name: "Average Tax Withholding Amount"
      expr: AVG(tax_withholding_amount)
    - name: "Total Total Volume Cbm"
      expr: SUM(total_volume_cbm)
    - name: "Average Total Volume Cbm"
      expr: AVG(total_volume_cbm)
    - name: "Total Total Weight Kg"
      expr: SUM(total_weight_kg)
    - name: "Average Total Weight Kg"
      expr: AVG(total_weight_kg)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`network_partner_sla`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner Sla business metrics"
  source: "`transport_shipping_ecm`.`network`.`partner_sla`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Contract Reference"
      expr: contract_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Destination Region"
      expr: destination_region
    - name: "Effective Date"
      expr: effective_date
    - name: "Escalation Procedure"
      expr: escalation_procedure
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Incentive Clause Reference"
      expr: incentive_clause_reference
    - name: "Incentive Currency Code"
      expr: incentive_currency_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Measurement Frequency"
      expr: measurement_frequency
    - name: "Measurement Period Days"
      expr: measurement_period_days
    - name: "Measurement Unit"
      expr: measurement_unit
    - name: "Next Review Date"
      expr: next_review_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partner Sla"
      expr: COUNT(DISTINCT partner_sla_id)
    - name: "Total Breach Threshold"
      expr: SUM(breach_threshold)
    - name: "Average Breach Threshold"
      expr: AVG(breach_threshold)
    - name: "Total Incentive Amount"
      expr: SUM(incentive_amount)
    - name: "Average Incentive Amount"
      expr: AVG(incentive_amount)
    - name: "Total Penalty Amount"
      expr: SUM(penalty_amount)
    - name: "Average Penalty Amount"
      expr: AVG(penalty_amount)
    - name: "Total Target Value"
      expr: SUM(target_value)
    - name: "Average Target Value"
      expr: AVG(target_value)
    - name: "Total Warning Threshold"
      expr: SUM(warning_threshold)
    - name: "Average Warning Threshold"
      expr: AVG(warning_threshold)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`network_tpl_provider`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tpl Provider business metrics"
  source: "`transport_shipping_ecm`.`network`.`tpl_provider`"
  dimensions:
    - name: "Aeo Certified"
      expr: aeo_certified
    - name: "Api Integration Available"
      expr: api_integration_available
    - name: "Cold Chain Capability"
      expr: cold_chain_capability
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Ctpat Certified"
      expr: ctpat_certified
    - name: "Customs Brokerage Capability"
      expr: customs_brokerage_capability
    - name: "Distribution Capability"
      expr: distribution_capability
    - name: "Duns Number"
      expr: duns_number
    - name: "Edi Capability"
      expr: edi_capability
    - name: "Financial Rating"
      expr: financial_rating
    - name: "Gdp Certified"
      expr: gdp_certified
    - name: "Geographic Coverage"
      expr: geographic_coverage
    - name: "Haccp Certified"
      expr: haccp_certified
    - name: "Headquarters Address Line1"
      expr: headquarters_address_line1
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tpl Provider"
      expr: COUNT(DISTINCT tpl_provider_id)
    - name: "Total Insurance Coverage Amount"
      expr: SUM(insurance_coverage_amount)
    - name: "Average Insurance Coverage Amount"
      expr: AVG(insurance_coverage_amount)
    - name: "Total Performance Score"
      expr: SUM(performance_score)
    - name: "Average Performance Score"
      expr: AVG(performance_score)
    - name: "Total Total Warehouse Sqft"
      expr: SUM(total_warehouse_sqft)
    - name: "Average Total Warehouse Sqft"
      expr: AVG(total_warehouse_sqft)
$$;