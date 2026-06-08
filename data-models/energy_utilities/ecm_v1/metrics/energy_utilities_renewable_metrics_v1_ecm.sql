-- Metric views for domain: renewable | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-04 21:07:37

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`renewable_battery_storage_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance and cost metrics for battery storage assets"
  source: "`energy_utilities_ecm`.`renewable`.`battery_storage_asset`"
  dimensions:
    - name: "asset_name"
      expr: asset_name
      comment: "Human‑readable name of the battery asset"
    - name: "storage_technology_type"
      expr: storage_technology_type
      comment: "Technology type (e.g., Li‑ion, flow) used in the battery"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the asset"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership model (e.g., owned, leased)"
    - name: "site_state"
      expr: site_state
      comment: "State where the asset is located"
    - name: "site_city"
      expr: site_city
      comment: "City where the asset is located"
    - name: "commissioning_date"
      expr: commissioning_date
      comment: "Date the asset was commissioned"
  measures:
    - name: "total_capital_cost_usd"
      expr: SUM(CAST(capital_cost_usd AS DOUBLE))
      comment: "Total capital cost of all battery storage assets in USD"
    - name: "average_round_trip_efficiency_percent"
      expr: AVG(CAST(round_trip_efficiency_percent AS DOUBLE))
      comment: "Average round‑trip efficiency across assets"
    - name: "total_annual_om_cost_usd"
      expr: SUM(CAST(annual_om_cost_usd AS DOUBLE))
      comment: "Sum of annual operation & maintenance cost for all assets"
    - name: "average_current_soc_percent"
      expr: AVG(CAST(current_soc_percent AS DOUBLE))
      comment: "Average state‑of‑charge across assets at snapshot time"
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Number of battery storage assets"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`renewable_der_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic capacity and export limits for DER registry"
  source: "`energy_utilities_ecm`.`renewable`.`der_registry`"
  dimensions:
    - name: "der_name"
      expr: der_name
      comment: "Name of the DER"
    - name: "der_type"
      expr: der_type
      comment: "Classification of DER (e.g., solar, wind, storage)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status"
    - name: "ownership_structure"
      expr: ownership_structure
      comment: "Legal ownership structure"
    - name: "registration_date"
      expr: registration_date
      comment: "Date the DER was registered"
  measures:
    - name: "total_storage_capacity_kwh"
      expr: SUM(CAST(storage_capacity_kwh AS DOUBLE))
      comment: "Aggregate storage capacity of all DERs in kWh"
    - name: "average_nameplate_capacity_kw"
      expr: AVG(CAST(nameplate_capacity_kw AS DOUBLE))
      comment: "Average nameplate capacity of DERs in kW"
    - name: "total_export_limit_kw"
      expr: SUM(CAST(export_limit_kw AS DOUBLE))
      comment: "Combined export limit across DERs"
    - name: "der_count"
      expr: COUNT(1)
      comment: "Number of Distributed Energy Resources"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`renewable_curtailment_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and operational impact of curtailment events"
  source: "`energy_utilities_ecm`.`renewable`.`curtailment_event`"
  dimensions:
    - name: "curtailment_type"
      expr: curtailment_type
      comment: "Type of curtailment (e.g., market, reliability)"
    - name: "curtailment_reason_description"
      expr: curtailment_reason_description
      comment: "Narrative reason for curtailment"
    - name: "curtailment_status"
      expr: curtailment_status
      comment: "Current status of the curtailment event"
    - name: "iso_rto_code"
      expr: iso_rto_code
      comment: "ISO/RTO jurisdiction code"
    - name: "control_area_id"
      expr: control_area_id
      comment: "Control area identifier"
  measures:
    - name: "total_curtailed_capacity_mw"
      expr: SUM(CAST(curtailed_capacity_mw AS DOUBLE))
      comment: "Total capacity curtailed across events (MW)"
    - name: "total_curtailed_energy_mwh"
      expr: SUM(CAST(curtailed_energy_mwh AS DOUBLE))
      comment: "Total energy curtailed across events (MWh)"
    - name: "total_market_price_loss_usd"
      expr: SUM(curtailed_energy_mwh * market_price_per_mwh)
      comment: "Estimated revenue loss due to curtailment (USD)"
    - name: "curtailment_event_count"
      expr: COUNT(1)
      comment: "Number of curtailment events recorded"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`renewable_generation_meter_read`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Generation performance and curtailment captured by meter reads"
  source: "`energy_utilities_ecm`.`renewable`.`generation_meter_read`"
  dimensions:
    - name: "power_plant_id"
      expr: power_plant_id
      comment: "Identifier of the power plant"
    - name: "der_registry_id"
      expr: der_registry_id
      comment: "DER registry linked to the read"
    - name: "interval_duration_minutes"
      expr: interval_duration_minutes
      comment: "Length of the measurement interval"
    - name: "read_timestamp"
      expr: read_timestamp
      comment: "Timestamp of the meter read"
  measures:
    - name: "total_gross_generation_kwh"
      expr: SUM(CAST(gross_generation_kwh AS DOUBLE))
      comment: "Total gross generation recorded (kWh)"
    - name: "total_net_generation_kwh"
      expr: SUM(CAST(net_generation_kwh AS DOUBLE))
      comment: "Total net generation after losses (kWh)"
    - name: "average_capacity_factor_percent"
      expr: AVG(CAST(capacity_factor_percent AS DOUBLE))
      comment: "Average capacity factor across reads"
    - name: "total_curtailed_energy_kwh"
      expr: SUM(CAST(curtailed_energy_kwh AS DOUBLE))
      comment: "Total curtailed energy captured in meter reads (kWh)"
    - name: "read_count"
      expr: COUNT(1)
      comment: "Number of generation meter reads"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`renewable_ppa_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial terms of power purchase agreements"
  source: "`energy_utilities_ecm`.`renewable`.`ppa_contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Legal type of the contract"
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract"
    - name: "generation_source"
      expr: generation_source
      comment: "Source of generation covered by the PPA"
  measures:
    - name: "total_contracted_capacity_mw"
      expr: SUM(CAST(contracted_capacity_mw AS DOUBLE))
      comment: "Aggregate contracted capacity across all PPAs (MW)"
    - name: "average_base_price_per_mwh"
      expr: AVG(CAST(base_price_per_mwh AS DOUBLE))
      comment: "Average base price per MWh in contracts"
    - name: "total_annual_energy_volume_mwh"
      expr: SUM(CAST(contracted_energy_volume_mwh_annual AS DOUBLE))
      comment: "Total annual energy volume committed (MWh)"
    - name: "ppa_contract_count"
      expr: COUNT(1)
      comment: "Number of active PPA contracts"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`renewable_rec_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and generation attributes of renewable REC certificates"
  source: "`energy_utilities_ecm`.`renewable`.`renewable_rec_certificate`"
  dimensions:
    - name: "certificate_status"
      expr: certificate_status
      comment: "Current status of the certificate"
    - name: "technology_type"
      expr: technology_type
      comment: "Technology class of the underlying asset"
    - name: "vintage_year"
      expr: vintage_year
      comment: "Vintage year of the REC"
    - name: "issuance_date"
      expr: issuance_date
      comment: "Date the certificate was issued"
  measures:
    - name: "total_market_value_usd"
      expr: SUM(CAST(market_value_usd AS DOUBLE))
      comment: "Aggregate market value of all RECs"
    - name: "total_generation_mwh"
      expr: SUM(CAST(generation_mwh AS DOUBLE))
      comment: "Total generation represented by RECs (MWh)"
    - name: "average_nameplate_capacity_mw"
      expr: AVG(CAST(nameplate_capacity_mw AS DOUBLE))
      comment: "Average nameplate capacity of REC‑linked assets"
    - name: "rec_certificate_count"
      expr: COUNT(1)
      comment: "Number of renewable REC certificates"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`renewable_vpp_configuration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity and performance metrics for virtual power plant configurations"
  source: "`energy_utilities_ecm`.`renewable`.`vpp_configuration`"
  dimensions:
    - name: "aggregation_type"
      expr: aggregation_type
      comment: "Method of aggregating DERs (e.g., geographic, technology)"
    - name: "vpp_status"
      expr: vpp_status
      comment: "Operational status of the VPP"
    - name: "control_area_id"
      expr: control_area_id
      comment: "Control area linked to the VPP"
  measures:
    - name: "total_aggregated_capacity_mw"
      expr: SUM(CAST(total_aggregated_capacity_mw AS DOUBLE))
      comment: "Combined capacity of all DERs in the VPP configuration (MW)"
    - name: "average_performance_score"
      expr: AVG(CAST(average_performance_score AS DOUBLE))
      comment: "Average performance score across VPP configurations"
    - name: "total_capacity_payment_rate_per_mw_month"
      expr: SUM(CAST(capacity_payment_rate_per_mw_month AS DOUBLE))
      comment: "Total capacity payment rate across configurations"
    - name: "vpp_configuration_count"
      expr: COUNT(1)
      comment: "Number of VPP configurations"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`renewable_incentive_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and enrollment metrics for renewable incentive programs"
  source: "`energy_utilities_ecm`.`renewable`.`incentive_program`"
  dimensions:
    - name: "program_type"
      expr: program_type
      comment: "Type of incentive program (e.g., tax credit, rebate)"
    - name: "program_status"
      expr: program_status
      comment: "Current status of the program"
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Regulatory jurisdiction for the program"
  measures:
    - name: "total_enrolled_capacity_mw"
      expr: SUM(CAST(enrolled_capacity_mw AS DOUBLE))
      comment: "Total capacity enrolled in incentive programs (MW)"
    - name: "average_incentive_rate_value"
      expr: AVG(CAST(incentive_rate_value AS DOUBLE))
      comment: "Average monetary incentive rate"
    - name: "total_program_budget_amount"
      expr: SUM(CAST(program_budget_amount AS DOUBLE))
      comment: "Total budget allocated to incentive programs"
    - name: "incentive_program_count"
      expr: COUNT(1)
      comment: "Number of incentive programs"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`renewable_green_tariff_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue and participation metrics for green tariff subscriptions"
  source: "`energy_utilities_ecm`.`renewable`.`green_tariff_subscription`"
  dimensions:
    - name: "program_name"
      expr: program_name
      comment: "Name of the green tariff program"
    - name: "program_type"
      expr: program_type
      comment: "Program classification (e.g., residential, commercial)"
    - name: "subscription_status"
      expr: subscription_status
      comment: "Current status of the subscription"
    - name: "enrollment_date"
      expr: enrollment_date
      comment: "Date the subscription was enrolled"
  measures:
    - name: "total_monthly_premium_amount"
      expr: SUM(CAST(monthly_premium_amount AS DOUBLE))
      comment: "Aggregate monthly premium paid by subscribers"
    - name: "average_subscription_percentage"
      expr: AVG(CAST(subscription_percentage AS DOUBLE))
      comment: "Average share of capacity subscribed"
    - name: "total_kwh_allocated_lifetime"
      expr: SUM(CAST(total_kwh_allocated_lifetime AS DOUBLE))
      comment: "Cumulative kWh allocated over subscription lifetimes"
    - name: "green_tariff_subscription_count"
      expr: COUNT(1)
      comment: "Number of active green tariff subscriptions"
$$;