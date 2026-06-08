-- Metric views for domain: contract | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 22:31:03

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`contract_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core contract agreement performance metrics tracking credit exposure, volume commitments, and SLA targets across carrier agreements"
  source: "`transport_shipping_ecm`.`contract`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the agreement (active, expired, terminated, etc.)"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of agreement (master, spot, framework, etc.)"
    - name: "contract_tier"
      expr: contract_tier
      comment: "Tier classification of the contract (platinum, gold, silver, bronze)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the agreement is denominated"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the agreement automatically renews upon expiration"
    - name: "insurance_required_flag"
      expr: insurance_required_flag
      comment: "Whether insurance coverage is required under this agreement"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the agreement became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the agreement became effective"
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the agreement expires"
    - name: "governing_jurisdiction"
      expr: governing_jurisdiction
      comment: "Legal jurisdiction governing the agreement"
  measures:
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit exposure across all agreements"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per agreement"
    - name: "total_volume_commitment_teu"
      expr: SUM(CAST(volume_commitment_teu AS DOUBLE))
      comment: "Total committed volume in TEU (twenty-foot equivalent units) across agreements"
    - name: "total_volume_commitment_weight_kg"
      expr: SUM(CAST(volume_commitment_weight_kg AS DOUBLE))
      comment: "Total committed volume in kilograms across agreements"
    - name: "avg_sla_otd_target"
      expr: AVG(CAST(sla_otd_target_percent AS DOUBLE))
      comment: "Average on-time delivery SLA target percentage across agreements"
    - name: "avg_sla_otif_target"
      expr: AVG(CAST(sla_otif_target_percent AS DOUBLE))
      comment: "Average on-time in-full SLA target percentage across agreements"
    - name: "agreement_count"
      expr: COUNT(1)
      comment: "Total number of agreements"
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN 1 END)
      comment: "Number of active agreements"
    - name: "auto_renewal_agreement_count"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END)
      comment: "Number of agreements with auto-renewal enabled"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`contract_carrier_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier-specific contract performance metrics tracking capacity commitments, liability limits, and service level targets"
  source: "`transport_shipping_ecm`.`contract`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the carrier agreement"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for the carrier agreement"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the carrier agreement auto-renews"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the carrier agreement became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the carrier agreement became effective"
  measures:
    - name: "avg_sla_otd_target"
      expr: AVG(CAST(sla_otd_target_percent AS DOUBLE))
      comment: "Average on-time delivery SLA target for carrier agreements"
    - name: "avg_sla_otif_target"
      expr: AVG(CAST(sla_otif_target_percent AS DOUBLE))
      comment: "Average on-time in-full SLA target for carrier agreements"
    - name: "carrier_agreement_count"
      expr: COUNT(1)
      comment: "Total number of carrier agreements"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`contract_sla_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service level agreement performance tracking and compliance metrics measuring actual vs target performance with breach detection"
  source: "`transport_shipping_ecm`.`contract`.`sla_performance`"
  dimensions:
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the SLA measurement (final, draft, disputed, etc.)"
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of SLA measurement (on-time delivery, in-full, damage rate, etc.)"
    - name: "measurement_category"
      expr: measurement_category
      comment: "Category of the SLA measurement"
    - name: "breach_flag"
      expr: breach_flag
      comment: "Whether the SLA was breached in this measurement period"
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity level of the SLA breach (critical, major, minor)"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the SLA measurement is under dispute"
    - name: "incentive_applicable_flag"
      expr: incentive_applicable_flag
      comment: "Whether incentive payments are applicable for this performance"
    - name: "penalty_applicable_flag"
      expr: penalty_applicable_flag
      comment: "Whether penalty charges are applicable for this performance"
    - name: "service_type"
      expr: service_type
      comment: "Type of service measured (express, standard, economy, etc.)"
    - name: "measurement_period_month"
      expr: DATE_TRUNC('MONTH', measurement_period_start_date)
      comment: "Month of the SLA measurement period start"
    - name: "measurement_period_year"
      expr: YEAR(measurement_period_start_date)
      comment: "Year of the SLA measurement period start"
  measures:
    - name: "avg_attainment_percentage"
      expr: AVG(CAST(attainment_percentage AS DOUBLE))
      comment: "Average SLA attainment percentage across all measurements"
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual performance value across measurements"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target performance value across measurements"
    - name: "avg_variance"
      expr: AVG(CAST(variance AS DOUBLE))
      comment: "Average variance between actual and target performance"
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive amounts earned for exceeding SLA targets"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amounts incurred for SLA breaches"
    - name: "net_sla_financial_impact"
      expr: SUM((CAST(incentive_amount AS DOUBLE)) - (CAST(penalty_amount AS DOUBLE)))
      comment: "Net financial impact of SLA performance (incentives minus penalties)"
    - name: "sla_measurement_count"
      expr: COUNT(1)
      comment: "Total number of SLA performance measurements"
    - name: "breach_count"
      expr: COUNT(CASE WHEN breach_flag = TRUE THEN 1 END)
      comment: "Number of SLA breaches recorded"
    - name: "breach_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SLA measurements that resulted in breaches"
    - name: "dispute_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of disputed SLA measurements"
    - name: "compliant_shipment_total"
      expr: SUM(CAST(compliant_shipment_count AS BIGINT))
      comment: "Total number of compliant shipments across all measurements"
    - name: "non_compliant_shipment_total"
      expr: SUM(CAST(non_compliant_shipment_count AS BIGINT))
      comment: "Total number of non-compliant shipments across all measurements"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`contract_volume_actuals`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volume commitment performance tracking comparing actual shipped volumes against contractual commitments with variance analysis"
  source: "`transport_shipping_ecm`.`contract`.`volume_actuals`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of volume commitment (compliant, shortfall, surplus)"
    - name: "record_status"
      expr: record_status
      comment: "Status of the volume actuals record (final, draft, adjusted)"
    - name: "period_type"
      expr: period_type
      comment: "Type of measurement period (monthly, quarterly, annual)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (ocean, air, road, rail, multimodal)"
    - name: "service_level"
      expr: service_level
      comment: "Service level tier (express, standard, economy)"
    - name: "trade_lane"
      expr: trade_lane
      comment: "Trade lane or route corridor"
    - name: "origin_region"
      expr: origin_region
      comment: "Origin region for the volume commitment"
    - name: "destination_region"
      expr: destination_region
      comment: "Destination region for the volume commitment"
    - name: "shortfall_flag"
      expr: shortfall_flag
      comment: "Whether actual volume fell short of commitment"
    - name: "surplus_flag"
      expr: surplus_flag
      comment: "Whether actual volume exceeded commitment"
    - name: "incentive_triggered_flag"
      expr: incentive_triggered_flag
      comment: "Whether volume performance triggered incentive payments"
    - name: "penalty_triggered_flag"
      expr: penalty_triggered_flag
      comment: "Whether volume performance triggered penalty charges"
    - name: "measurement_period_month"
      expr: DATE_TRUNC('MONTH', measurement_period_start_date)
      comment: "Month of the volume measurement period"
    - name: "measurement_period_year"
      expr: YEAR(measurement_period_start_date)
      comment: "Year of the volume measurement period"
  measures:
    - name: "total_actual_volume"
      expr: SUM(CAST(actual_volume_shipped AS DOUBLE))
      comment: "Total actual volume shipped across all commitments"
    - name: "total_committed_volume"
      expr: SUM(CAST(committed_volume AS DOUBLE))
      comment: "Total committed volume across all agreements"
    - name: "total_volume_variance"
      expr: SUM(CAST(volume_variance AS DOUBLE))
      comment: "Total variance between actual and committed volume"
    - name: "avg_attainment_percentage"
      expr: AVG(CAST(attainment_percentage AS DOUBLE))
      comment: "Average volume commitment attainment percentage"
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive amounts earned for exceeding volume commitments"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amounts incurred for volume shortfalls"
    - name: "net_volume_financial_impact"
      expr: SUM((CAST(incentive_amount AS DOUBLE)) - (CAST(penalty_amount AS DOUBLE)))
      comment: "Net financial impact of volume performance (incentives minus penalties)"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amounts applied to volume actuals"
    - name: "volume_actuals_count"
      expr: COUNT(1)
      comment: "Total number of volume actuals records"
    - name: "shortfall_count"
      expr: COUNT(CASE WHEN shortfall_flag = TRUE THEN 1 END)
      comment: "Number of periods with volume shortfalls"
    - name: "surplus_count"
      expr: COUNT(CASE WHEN surplus_flag = TRUE THEN 1 END)
      comment: "Number of periods with volume surplus"
    - name: "total_shipment_count"
      expr: SUM(CAST(shipment_count AS BIGINT))
      comment: "Total number of shipments across all volume actuals"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`contract_penalty_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Penalty event tracking and financial impact analysis for contract breaches and SLA violations"
  source: "`transport_shipping_ecm`.`contract`.`penalty_event`"
  dimensions:
    - name: "penalty_event_status"
      expr: penalty_event_status
      comment: "Status of the penalty event (pending, approved, disputed, waived, paid)"
    - name: "event_type"
      expr: event_type
      comment: "Type of penalty event (SLA breach, volume shortfall, damage, delay, etc.)"
    - name: "trigger_category"
      expr: trigger_category
      comment: "Category of the penalty trigger"
    - name: "party_type"
      expr: party_type
      comment: "Type of party responsible for the penalty (carrier, customer, supplier)"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the penalty event is under dispute"
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Whether approval is required for this penalty event"
    - name: "notification_sent_flag"
      expr: notification_sent_flag
      comment: "Whether notification has been sent for this penalty event"
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate the penalty amount"
    - name: "sla_metric_code"
      expr: sla_metric_code
      comment: "SLA metric code that triggered the penalty"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month when the penalty event occurred"
    - name: "event_year"
      expr: YEAR(event_date)
      comment: "Year when the penalty event occurred"
  measures:
    - name: "total_base_amount"
      expr: SUM(CAST(base_amount AS DOUBLE))
      comment: "Total base penalty amounts before adjustments"
    - name: "total_calculated_amount"
      expr: SUM(CAST(calculated_amount AS DOUBLE))
      comment: "Total calculated penalty amounts"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amounts applied to penalties"
    - name: "total_final_amount"
      expr: SUM(CAST(final_amount AS DOUBLE))
      comment: "Total final penalty amounts after all adjustments"
    - name: "avg_penalty_rate"
      expr: AVG(CAST(penalty_rate AS DOUBLE))
      comment: "Average penalty rate applied across events"
    - name: "penalty_event_count"
      expr: COUNT(1)
      comment: "Total number of penalty events"
    - name: "disputed_event_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of disputed penalty events"
    - name: "waived_event_count"
      expr: COUNT(CASE WHEN waiver_date IS NOT NULL THEN 1 END)
      comment: "Number of penalty events that were waived"
    - name: "approved_event_count"
      expr: COUNT(CASE WHEN approval_date IS NOT NULL THEN 1 END)
      comment: "Number of penalty events that have been approved"
    - name: "dispute_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of penalty events that are disputed"
    - name: "waiver_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN waiver_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of penalty events that were waived"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`contract_lane_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lane-specific capacity commitment and pricing performance tracking for contracted trade routes"
  source: "`transport_shipping_ecm`.`contract`.`lane_commitment`"
  dimensions:
    - name: "commitment_status"
      expr: commitment_status
      comment: "Status of the lane commitment (active, expired, suspended)"
    - name: "commitment_period"
      expr: commitment_period
      comment: "Period type for the commitment (monthly, quarterly, annual)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for the lane (ocean, air, road, rail)"
    - name: "service_type"
      expr: service_type
      comment: "Type of service (express, standard, economy)"
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment used (container type, vehicle type)"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the lane commitment"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the lane commitment"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the lane commitment auto-renews"
    - name: "rollover_allowed_flag"
      expr: rollover_allowed_flag
      comment: "Whether unused capacity can be rolled over"
    - name: "incentive_clause_flag"
      expr: incentive_clause_flag
      comment: "Whether incentive clauses apply to this lane"
    - name: "penalty_clause_flag"
      expr: penalty_clause_flag
      comment: "Whether penalty clauses apply to this lane"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_from_date)
      comment: "Month when the lane commitment became effective"
  measures:
    - name: "total_capacity_commitment"
      expr: SUM(CAST(capacity_commitment_quantity AS DOUBLE))
      comment: "Total committed capacity across all lanes"
    - name: "total_minimum_booking"
      expr: SUM(CAST(minimum_booking_quantity AS DOUBLE))
      comment: "Total minimum booking quantities across lanes"
    - name: "total_maximum_booking"
      expr: SUM(CAST(maximum_booking_quantity AS DOUBLE))
      comment: "Total maximum booking quantities across lanes"
    - name: "total_incentive_threshold"
      expr: SUM(CAST(incentive_threshold_quantity AS DOUBLE))
      comment: "Total incentive threshold quantities across lanes"
    - name: "total_rollover_limit"
      expr: SUM(CAST(rollover_limit_quantity AS DOUBLE))
      comment: "Total rollover limit quantities across lanes"
    - name: "avg_rate_per_unit"
      expr: AVG(CAST(rate_per_unit AS DOUBLE))
      comment: "Average contracted rate per unit across lanes"
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive amounts for lane commitments"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amounts for lane commitments"
    - name: "lane_commitment_count"
      expr: COUNT(1)
      comment: "Total number of lane commitments"
    - name: "active_lane_count"
      expr: COUNT(CASE WHEN commitment_status = 'Active' THEN 1 END)
      comment: "Number of active lane commitments"
    - name: "incentive_lane_count"
      expr: COUNT(CASE WHEN incentive_clause_flag = TRUE THEN 1 END)
      comment: "Number of lanes with incentive clauses"
    - name: "penalty_lane_count"
      expr: COUNT(CASE WHEN penalty_clause_flag = TRUE THEN 1 END)
      comment: "Number of lanes with penalty clauses"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`contract_rate_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate schedule and pricing structure metrics tracking base rates, surcharges, and volume/weight breaks across contracted lanes"
  source: "`transport_shipping_ecm`.`contract`.`rate_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Status of the rate schedule (active, expired, pending)"
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of rate schedule (standard, promotional, spot)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the rate schedule"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for the rate schedule"
    - name: "service_type"
      expr: service_type
      comment: "Type of service covered by the rate schedule"
    - name: "rate_basis"
      expr: rate_basis
      comment: "Basis for rate calculation (per kg, per TEU, per shipment)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which rates are denominated"
    - name: "fuel_surcharge_applicable"
      expr: fuel_surcharge_applicable
      comment: "Whether fuel surcharge applies to this rate schedule"
    - name: "peak_season_surcharge_applicable"
      expr: peak_season_surcharge_applicable
      comment: "Whether peak season surcharge applies"
    - name: "security_surcharge_applicable"
      expr: security_surcharge_applicable
      comment: "Whether security surcharge applies"
    - name: "origin_zone"
      expr: origin_zone
      comment: "Origin zone for the rate schedule"
    - name: "destination_zone"
      expr: destination_zone
      comment: "Destination zone for the rate schedule"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month when the rate schedule became effective"
  measures:
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate AS DOUBLE))
      comment: "Average base rate across all rate schedules"
    - name: "avg_minimum_charge"
      expr: AVG(CAST(minimum_charge AS DOUBLE))
      comment: "Average minimum charge across rate schedules"
    - name: "avg_maximum_charge"
      expr: AVG(CAST(maximum_charge AS DOUBLE))
      comment: "Average maximum charge across rate schedules"
    - name: "avg_fuel_surcharge_rate"
      expr: AVG(CAST(fuel_surcharge_rate AS DOUBLE))
      comment: "Average fuel surcharge rate where applicable"
    - name: "avg_peak_season_surcharge_rate"
      expr: AVG(CAST(peak_season_surcharge_rate AS DOUBLE))
      comment: "Average peak season surcharge rate where applicable"
    - name: "avg_security_surcharge_rate"
      expr: AVG(CAST(security_surcharge_rate AS DOUBLE))
      comment: "Average security surcharge rate where applicable"
    - name: "rate_schedule_count"
      expr: COUNT(1)
      comment: "Total number of rate schedules"
    - name: "active_rate_schedule_count"
      expr: COUNT(CASE WHEN schedule_status = 'Active' THEN 1 END)
      comment: "Number of active rate schedules"
    - name: "fuel_surcharge_schedule_count"
      expr: COUNT(CASE WHEN fuel_surcharge_applicable = TRUE THEN 1 END)
      comment: "Number of rate schedules with fuel surcharge"
    - name: "peak_season_schedule_count"
      expr: COUNT(CASE WHEN peak_season_surcharge_applicable = TRUE THEN 1 END)
      comment: "Number of rate schedules with peak season surcharge"
$$;