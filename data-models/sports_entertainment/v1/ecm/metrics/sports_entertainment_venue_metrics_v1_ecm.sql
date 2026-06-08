-- Metric views for domain: venue | Business: Sports Entertainment | Version: 1 | Generated on: 2026-05-09 01:35:39

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`venue_concession_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Concession revenue, transaction volume, and operational performance metrics for food & beverage operations across venues"
  source: "`sports_entertainment_ecm`.`venue`.`concession_transaction`"
  dimensions:
    - name: "transaction_date"
      expr: DATE(transaction_timestamp)
      comment: "Date of the concession transaction"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month of the concession transaction for monthly trend analysis"
    - name: "item_category"
      expr: item_category
      comment: "Product category (food, beverage, merchandise, etc.)"
    - name: "stand_type"
      expr: stand_type
      comment: "Type of concession stand (portable, fixed, premium, etc.)"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (credit, debit, mobile, cash, etc.)"
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which payment was processed (POS, mobile app, kiosk, etc.)"
    - name: "event_period"
      expr: event_period
      comment: "Period during event when transaction occurred (pre-game, halftime, post-game, etc.)"
    - name: "alcohol_sale_flag"
      expr: alcohol_sale_flag
      comment: "Whether the transaction included alcohol sales"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the transaction (completed, refunded, voided, etc.)"
  measures:
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross revenue from concession sales before discounts and taxes"
    - name: "total_net_revenue"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net revenue from concession sales after discounts and taxes"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to concession transactions"
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected on concession sales"
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of concession transactions"
    - name: "unique_loyalty_members"
      expr: COUNT(DISTINCT loyalty_enrollment_id)
      comment: "Number of unique loyalty members who made concession purchases"
    - name: "avg_transaction_value"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net transaction value per concession purchase"
    - name: "total_units_sold"
      expr: SUM(CAST(quantity_sold AS BIGINT))
      comment: "Total quantity of items sold across all concession transactions"
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_amount AS DOUBLE) / NULLIF(CAST(gross_amount AS DOUBLE), 0))
      comment: "Average discount rate as percentage of gross amount"
    - name: "refund_count"
      expr: SUM(CASE WHEN is_refund = TRUE THEN 1 ELSE 0 END)
      comment: "Number of refunded transactions"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`venue_rental`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Venue rental revenue, utilization, and contract performance metrics for non-event space usage"
  source: "`sports_entertainment_ecm`.`venue`.`rental`"
  dimensions:
    - name: "event_date"
      expr: event_date
      comment: "Date of the rental event"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month of the rental event for monthly trend analysis"
    - name: "event_type"
      expr: event_type
      comment: "Type of event (corporate, wedding, concert, conference, etc.)"
    - name: "renter_type"
      expr: renter_type
      comment: "Type of renter (corporate, individual, non-profit, etc.)"
    - name: "rental_status"
      expr: rental_status
      comment: "Status of the rental (confirmed, pending, cancelled, completed, etc.)"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the rental (paid, pending, overdue, etc.)"
    - name: "space_configuration"
      expr: space_configuration
      comment: "Configuration of the rented space (theater, banquet, classroom, etc.)"
    - name: "contract_signed_month"
      expr: DATE_TRUNC('MONTH', contract_signed_date)
      comment: "Month when rental contract was signed for pipeline analysis"
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total contracted revenue from venue rentals"
    - name: "total_base_rental_fee"
      expr: SUM(CAST(base_rental_fee AS DOUBLE))
      comment: "Total base rental fees excluding ancillary services"
    - name: "total_ancillary_revenue"
      expr: SUM(CAST(av_service_fee AS DOUBLE) + CAST(catering_service_fee AS DOUBLE) + CAST(cleaning_service_fee AS DOUBLE) + CAST(security_service_fee AS DOUBLE) + CAST(other_ancillary_fees AS DOUBLE))
      comment: "Total revenue from ancillary services (AV, catering, cleaning, security, other)"
    - name: "total_deposit_collected"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts collected from renters"
    - name: "rental_count"
      expr: COUNT(1)
      comment: "Total number of venue rental bookings"
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value per rental booking"
    - name: "avg_expected_attendance"
      expr: AVG(CAST(expected_attendance AS BIGINT))
      comment: "Average expected attendance across rental events"
    - name: "cancellation_count"
      expr: SUM(CASE WHEN cancellation_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of cancelled rental bookings"
    - name: "ancillary_revenue_rate"
      expr: AVG((CAST(av_service_fee AS DOUBLE) + CAST(catering_service_fee AS DOUBLE) + CAST(cleaning_service_fee AS DOUBLE) + CAST(security_service_fee AS DOUBLE) + CAST(other_ancillary_fees AS DOUBLE)) / NULLIF(CAST(total_contract_value AS DOUBLE), 0))
      comment: "Average ancillary revenue as percentage of total contract value"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`venue_suite_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium suite licensing revenue, retention, and contract performance metrics for high-value hospitality assets"
  source: "`sports_entertainment_ecm`.`venue`.`suite_license`"
  dimensions:
    - name: "license_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when suite license started for cohort analysis"
    - name: "license_term_type"
      expr: license_term_type
      comment: "Type of license term (annual, multi-year, seasonal, etc.)"
    - name: "licensee_type"
      expr: licensee_type
      comment: "Type of licensee (corporate, individual, partnership, etc.)"
    - name: "contract_status"
      expr: contract_status
      comment: "Status of the suite license contract (active, expired, pending, cancelled, etc.)"
    - name: "food_beverage_package_type"
      expr: food_beverage_package_type
      comment: "Type of food and beverage package included in license"
    - name: "payment_schedule_type"
      expr: payment_schedule_type
      comment: "Payment schedule for the license (monthly, quarterly, annual, etc.)"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the license has auto-renewal enabled"
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason for license termination if applicable"
  measures:
    - name: "total_license_revenue"
      expr: SUM(CAST(total_license_fee AS DOUBLE))
      comment: "Total revenue from suite license fees"
    - name: "total_annual_license_revenue"
      expr: SUM(CAST(annual_license_fee AS DOUBLE))
      comment: "Total annualized license fee revenue"
    - name: "total_catering_credit"
      expr: SUM(CAST(catering_credit_amount AS DOUBLE))
      comment: "Total catering credit amounts included in suite licenses"
    - name: "total_deposit_collected"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts collected from suite licensees"
    - name: "license_count"
      expr: COUNT(1)
      comment: "Total number of suite licenses"
    - name: "avg_license_value"
      expr: AVG(CAST(total_license_fee AS DOUBLE))
      comment: "Average total license fee per suite"
    - name: "avg_price_escalation_rate"
      expr: AVG(CAST(price_escalation_rate AS DOUBLE))
      comment: "Average annual price escalation rate across suite licenses"
    - name: "terminated_license_count"
      expr: SUM(CASE WHEN termination_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of terminated suite licenses"
    - name: "catering_credit_rate"
      expr: AVG(CAST(catering_credit_amount AS DOUBLE) / NULLIF(CAST(total_license_fee AS DOUBLE), 0))
      comment: "Average catering credit as percentage of total license fee"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`venue_maintenance_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance cost, efficiency, and asset reliability metrics for venue operations and facility management"
  source: "`sports_entertainment_ecm`.`venue`.`maintenance_work_order`"
  dimensions:
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_date)
      comment: "Month when maintenance work was scheduled to start"
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of maintenance work order (preventive, corrective, emergency, etc.)"
    - name: "work_order_status"
      expr: work_order_status
      comment: "Status of the work order (open, in-progress, completed, cancelled, etc.)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the work order (critical, high, medium, low, etc.)"
    - name: "asset_system_category"
      expr: asset_system_category
      comment: "Category of asset or system being maintained (HVAC, electrical, plumbing, etc.)"
    - name: "activity_type_code"
      expr: activity_type_code
      comment: "Code representing the type of maintenance activity performed"
    - name: "is_safety_critical"
      expr: is_safety_critical
      comment: "Whether the work order is related to safety-critical systems"
    - name: "requires_shutdown"
      expr: requires_shutdown
      comment: "Whether the maintenance requires facility or system shutdown"
  measures:
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of completed maintenance work orders"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of maintenance work orders"
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Total cost of parts used in maintenance work orders"
    - name: "total_external_service_cost"
      expr: SUM(CAST(external_service_cost AS DOUBLE))
      comment: "Total cost of external vendor services for maintenance"
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours spent on maintenance work orders"
    - name: "total_estimated_labor_hours"
      expr: SUM(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Total estimated labor hours for maintenance work orders"
    - name: "work_order_count"
      expr: COUNT(1)
      comment: "Total number of maintenance work orders"
    - name: "avg_cost_per_work_order"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per maintenance work order"
    - name: "cost_variance_rate"
      expr: AVG((CAST(actual_cost AS DOUBLE) - CAST(estimated_cost AS DOUBLE)) / NULLIF(CAST(estimated_cost AS DOUBLE), 0))
      comment: "Average cost variance as percentage of estimated cost (positive = over budget)"
    - name: "labor_variance_rate"
      expr: AVG((CAST(actual_labor_hours AS DOUBLE) - CAST(estimated_labor_hours AS DOUBLE)) / NULLIF(CAST(estimated_labor_hours AS DOUBLE), 0))
      comment: "Average labor hour variance as percentage of estimated hours"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`venue_event_day_ops`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event day operational performance, readiness, and incident metrics for live event execution"
  source: "`sports_entertainment_ecm`.`venue`.`event_day_ops`"
  dimensions:
    - name: "event_date"
      expr: event_date
      comment: "Date of the event"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month of the event for monthly trend analysis"
    - name: "ops_status"
      expr: ops_status
      comment: "Operational status of the event day (ready, in-progress, completed, incident, etc.)"
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions during the event"
    - name: "emergency_system_verified"
      expr: emergency_system_verified
      comment: "Whether emergency systems were verified before event"
    - name: "security_sweep_completed"
      expr: security_sweep_completed
      comment: "Whether security sweep was completed before event"
    - name: "damage_assessment_required"
      expr: damage_assessment_required
      comment: "Whether damage assessment was required post-event"
  measures:
    - name: "total_actual_attendance"
      expr: SUM(CAST(actual_attendance AS BIGINT))
      comment: "Total actual attendance across all events"
    - name: "event_count"
      expr: COUNT(1)
      comment: "Total number of event days"
    - name: "avg_actual_attendance"
      expr: AVG(CAST(actual_attendance AS BIGINT))
      comment: "Average actual attendance per event"
    - name: "avg_checklist_completion_rate"
      expr: AVG(CAST(checklist_completion_pct AS DOUBLE))
      comment: "Average checklist completion percentage across events"
    - name: "total_incident_count"
      expr: SUM(CAST(incident_count AS BIGINT))
      comment: "Total number of incidents reported across all events"
    - name: "total_critical_failures"
      expr: SUM(CAST(critical_item_failure_count AS BIGINT))
      comment: "Total number of critical item failures across all events"
    - name: "avg_active_concession_stands"
      expr: AVG(CAST(active_concession_stand_count AS BIGINT))
      comment: "Average number of active concession stands per event"
    - name: "avg_security_staff"
      expr: AVG(CAST(security_staff_count AS BIGINT))
      comment: "Average number of security staff deployed per event"
    - name: "avg_medical_staff"
      expr: AVG(CAST(medical_staff_count AS BIGINT))
      comment: "Average number of medical staff deployed per event"
    - name: "avg_peak_concourse_occupancy"
      expr: AVG(CAST(peak_concourse_occupancy AS BIGINT))
      comment: "Average peak concourse occupancy across events"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`venue_safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety incident frequency, severity, and liability metrics for risk management and regulatory compliance"
  source: "`sports_entertainment_ecm`.`venue`.`safety_incident`"
  dimensions:
    - name: "incident_date"
      expr: DATE(incident_datetime)
      comment: "Date when the safety incident occurred"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_datetime)
      comment: "Month when the safety incident occurred for trend analysis"
    - name: "incident_type"
      expr: incident_type
      comment: "Type of safety incident (slip/fall, equipment failure, crowd-related, etc.)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the incident (minor, moderate, major, critical, etc.)"
    - name: "incident_status"
      expr: incident_status
      comment: "Status of the incident investigation (open, under investigation, closed, etc.)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Category of root cause (human error, equipment failure, environmental, etc.)"
    - name: "is_osha_recordable"
      expr: is_osha_recordable
      comment: "Whether the incident is OSHA recordable"
    - name: "is_hospitalization_required"
      expr: is_hospitalization_required
      comment: "Whether the incident required hospitalization"
    - name: "is_fatality"
      expr: is_fatality
      comment: "Whether the incident resulted in a fatality"
    - name: "affected_party_type"
      expr: affected_party_type
      comment: "Type of affected party (fan, employee, contractor, vendor, etc.)"
  measures:
    - name: "incident_count"
      expr: COUNT(1)
      comment: "Total number of safety incidents"
    - name: "total_estimated_liability"
      expr: SUM(CAST(estimated_liability_usd AS DOUBLE))
      comment: "Total estimated liability in USD from safety incidents"
    - name: "avg_estimated_liability"
      expr: AVG(CAST(estimated_liability_usd AS DOUBLE))
      comment: "Average estimated liability per safety incident"
    - name: "total_persons_affected"
      expr: SUM(CAST(persons_affected_count AS BIGINT))
      comment: "Total number of persons affected by safety incidents"
    - name: "total_days_away_from_work"
      expr: SUM(CAST(days_away_from_work AS BIGINT))
      comment: "Total days away from work due to safety incidents"
    - name: "total_days_restricted_work"
      expr: SUM(CAST(days_restricted_work AS BIGINT))
      comment: "Total days of restricted work due to safety incidents"
    - name: "osha_recordable_count"
      expr: SUM(CASE WHEN is_osha_recordable = TRUE THEN 1 ELSE 0 END)
      comment: "Number of OSHA recordable incidents"
    - name: "hospitalization_count"
      expr: SUM(CASE WHEN is_hospitalization_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of incidents requiring hospitalization"
    - name: "fatality_count"
      expr: SUM(CASE WHEN is_fatality = TRUE THEN 1 ELSE 0 END)
      comment: "Number of fatal incidents"
    - name: "avg_witness_count"
      expr: AVG(CAST(witness_count AS BIGINT))
      comment: "Average number of witnesses per safety incident"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`venue_parking_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Parking capacity, utilization, and revenue metrics for venue access and fan experience"
  source: "`sports_entertainment_ecm`.`venue`.`parking_lot`"
  dimensions:
    - name: "lot_type"
      expr: lot_type
      comment: "Type of parking lot (surface, garage, valet, etc.)"
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the parking lot (active, closed, under construction, etc.)"
    - name: "pricing_tier"
      expr: pricing_tier
      comment: "Pricing tier of the parking lot (premium, standard, economy, etc.)"
    - name: "surface_type"
      expr: surface_type
      comment: "Surface type of the parking lot (paved, gravel, grass, etc.)"
    - name: "covered"
      expr: covered
      comment: "Whether the parking lot is covered"
    - name: "ada_compliant"
      expr: ada_compliant
      comment: "Whether the parking lot is ADA compliant"
    - name: "shuttle_served"
      expr: shuttle_served
      comment: "Whether the parking lot is served by shuttle service"
    - name: "pre_sale_available"
      expr: pre_sale_available
      comment: "Whether pre-sale parking is available for this lot"
  measures:
    - name: "total_parking_capacity"
      expr: SUM(CAST(total_spaces AS BIGINT))
      comment: "Total parking capacity across all lots"
    - name: "total_accessible_spaces"
      expr: SUM(CAST(accessible_spaces AS BIGINT))
      comment: "Total ADA accessible parking spaces"
    - name: "total_ev_charging_spaces"
      expr: SUM(CAST(ev_charging_spaces AS BIGINT))
      comment: "Total electric vehicle charging spaces"
    - name: "total_reserved_spaces"
      expr: SUM(CAST(reserved_spaces AS BIGINT))
      comment: "Total reserved parking spaces"
    - name: "parking_lot_count"
      expr: COUNT(1)
      comment: "Total number of parking lots"
    - name: "avg_base_event_rate"
      expr: AVG(CAST(base_event_rate AS DOUBLE))
      comment: "Average base event parking rate across lots"
    - name: "avg_distance_from_entrance"
      expr: AVG(CAST(distance_from_entrance_m AS BIGINT))
      comment: "Average distance from venue entrance in meters"
    - name: "accessible_space_rate"
      expr: AVG(CAST(accessible_spaces AS BIGINT) / NULLIF(CAST(total_spaces AS BIGINT), 0))
      comment: "Average accessible spaces as percentage of total capacity"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`venue_staff_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event staffing cost, fulfillment, and labor efficiency metrics for workforce planning and budget management"
  source: "`sports_entertainment_ecm`.`venue`.`staff_plan`"
  dimensions:
    - name: "shift_date"
      expr: DATE(shift_start_timestamp)
      comment: "Date of the staffing shift"
    - name: "shift_month"
      expr: DATE_TRUNC('MONTH', shift_start_timestamp)
      comment: "Month of the staffing shift for monthly trend analysis"
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the staffing plan (draft, approved, active, completed, cancelled, etc.)"
    - name: "role_category"
      expr: role_category
      comment: "Category of staffing role (security, concessions, ushers, medical, etc.)"
    - name: "employment_type"
      expr: employment_type
      comment: "Type of employment (full-time, part-time, seasonal, contractor, etc.)"
    - name: "fulfillment_source"
      expr: fulfillment_source
      comment: "Source of staff fulfillment (internal, agency, volunteer, etc.)"
    - name: "event_type_category"
      expr: event_type_category
      comment: "Category of event type for the staffing plan"
    - name: "is_osha_safety_critical"
      expr: is_osha_safety_critical
      comment: "Whether the role is OSHA safety-critical"
  measures:
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Total estimated staffing cost in USD"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE))
      comment: "Total actual staffing cost in USD"
    - name: "total_required_headcount"
      expr: SUM(CAST(required_headcount AS BIGINT))
      comment: "Total required headcount across all staffing plans"
    - name: "total_confirmed_headcount"
      expr: SUM(CAST(confirmed_headcount AS BIGINT))
      comment: "Total confirmed headcount across all staffing plans"
    - name: "total_actual_headcount"
      expr: SUM(CAST(actual_headcount AS BIGINT))
      comment: "Total actual headcount deployed"
    - name: "staff_plan_count"
      expr: COUNT(1)
      comment: "Total number of staffing plans"
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate_usd AS DOUBLE))
      comment: "Average pay rate per hour in USD"
    - name: "avg_shift_duration"
      expr: AVG(CAST(shift_duration_hours AS DOUBLE))
      comment: "Average shift duration in hours"
    - name: "fulfillment_rate"
      expr: AVG(CAST(confirmed_headcount AS BIGINT) / NULLIF(CAST(required_headcount AS BIGINT), 0))
      comment: "Average fulfillment rate as percentage of required headcount"
    - name: "cost_variance_rate"
      expr: AVG((CAST(actual_cost_usd AS DOUBLE) - CAST(estimated_cost_usd AS DOUBLE)) / NULLIF(CAST(estimated_cost_usd AS DOUBLE), 0))
      comment: "Average cost variance as percentage of estimated cost"
$$;