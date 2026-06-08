-- Metric views for domain: supply | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-06 23:23:25

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`supply_dispensing_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical trial drug dispensing metrics tracking subject compliance, dispensing volumes, and return rates to monitor IMP accountability and patient adherence."
  source: "`clinical_trials_ecm`.`supply`.`dispensing_record`"
  dimensions:
    - name: "dispensing_status"
      expr: dispensing_status
      comment: "Current status of the dispensing event (e.g., dispensed, returned, reconciled)"
    - name: "dispensing_method"
      expr: dispensing_method
      comment: "Method used for dispensing (e.g., RTSM, manual)"
    - name: "dosage_form"
      expr: dosage_form
      comment: "Physical form of the dispensed medication (tablet, injection, etc.)"
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route by which the IMP is administered to the subject"
    - name: "visit_name"
      expr: visit_name
      comment: "Protocol visit at which dispensing occurred"
    - name: "protocol_deviation_flag"
      expr: protocol_deviation_flag
      comment: "Whether a protocol deviation was associated with this dispensing event"
    - name: "temperature_excursion_flag"
      expr: temperature_excursion_flag
      comment: "Whether a temperature excursion was noted for the dispensed kit"
    - name: "dispensing_month"
      expr: DATE_TRUNC('month', dispensing_date)
      comment: "Month in which dispensing occurred for trend analysis"
    - name: "imp_name"
      expr: imp_name
      comment: "Name of the investigational medicinal product dispensed"
  measures:
    - name: "total_dispensing_events"
      expr: COUNT(1)
      comment: "Total number of dispensing events recorded across all sites and subjects"
    - name: "total_quantity_dispensed"
      expr: SUM(CAST(quantity_dispensed AS DOUBLE))
      comment: "Total quantity of IMP units dispensed to subjects"
    - name: "total_quantity_returned"
      expr: SUM(CAST(quantity_returned AS DOUBLE))
      comment: "Total quantity of IMP units returned by subjects"
    - name: "avg_subject_compliance_pct"
      expr: AVG(CAST(subject_compliance_pct AS DOUBLE))
      comment: "Average subject compliance percentage based on pill counts or returned units"
    - name: "avg_dose_amount"
      expr: AVG(CAST(dose_amount AS DOUBLE))
      comment: "Average dose amount per dispensing event"
    - name: "dispensing_with_deviation_count"
      expr: COUNT(CASE WHEN protocol_deviation_flag = TRUE THEN 1 END)
      comment: "Number of dispensing events associated with a protocol deviation"
    - name: "dispensing_with_temp_excursion_count"
      expr: COUNT(CASE WHEN temperature_excursion_flag = TRUE THEN 1 END)
      comment: "Number of dispensing events where temperature excursion was flagged"
    - name: "unblinded_dispensing_count"
      expr: COUNT(CASE WHEN is_unblinded = TRUE THEN 1 END)
      comment: "Number of dispensing events where unblinding occurred — critical for trial integrity monitoring"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`supply_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IMP shipment performance metrics tracking delivery timeliness, cold chain compliance, and customs clearance efficiency for clinical supply chain management."
  source: "`clinical_trials_ecm`.`supply`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (e.g., in-transit, delivered, quarantined)"
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of shipment (e.g., initial, resupply, return)"
    - name: "direction"
      expr: direction
      comment: "Direction of shipment flow (outbound to site, inbound return, inter-depot)"
    - name: "storage_condition"
      expr: storage_condition
      comment: "Required storage condition during transit (ambient, refrigerated, frozen)"
    - name: "carrier_name"
      expr: carrier_name
      comment: "Logistics carrier responsible for the shipment"
    - name: "destination_node_type"
      expr: destination_node_type
      comment: "Type of destination (depot, site, destruction facility)"
    - name: "origin_node_type"
      expr: origin_node_type
      comment: "Type of origin node for the shipment"
    - name: "temperature_excursion_flag"
      expr: temperature_excursion_flag
      comment: "Whether a temperature excursion was detected during transit"
    - name: "customs_clearance_required"
      expr: customs_clearance_required
      comment: "Whether customs clearance was required for this shipment"
    - name: "dispatch_month"
      expr: DATE_TRUNC('month', dispatch_date)
      comment: "Month of shipment dispatch for trend analysis"
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments processed"
    - name: "shipments_with_temp_excursion"
      expr: COUNT(CASE WHEN temperature_excursion_flag = TRUE THEN 1 END)
      comment: "Number of shipments with temperature excursions — key quality risk indicator"
    - name: "shipments_quarantined"
      expr: COUNT(CASE WHEN quarantine_flag = TRUE THEN 1 END)
      comment: "Number of shipments placed in quarantine upon receipt"
    - name: "shipments_delivered"
      expr: COUNT(CASE WHEN shipment_status = 'Delivered' THEN 1 END)
      comment: "Number of shipments successfully delivered"
    - name: "max_recorded_temperature"
      expr: MAX(max_recorded_temp_c)
      comment: "Highest temperature recorded across shipments — monitors cold chain breach severity"
    - name: "min_recorded_temperature"
      expr: MIN(min_recorded_temp_c)
      comment: "Lowest temperature recorded across shipments — monitors freezing risk"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`supply_shipment_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment line-level metrics tracking quantity accuracy, receipt confirmation rates, and discrepancies for IMP supply chain accountability."
  source: "`clinical_trials_ecm`.`supply`.`shipment_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the shipment line (shipped, received, discrepant)"
    - name: "kit_type"
      expr: kit_type
      comment: "Type of kit shipped on this line"
    - name: "dosage_form"
      expr: dosage_form
      comment: "Dosage form of the IMP on this shipment line"
    - name: "storage_condition_code"
      expr: storage_condition_code
      comment: "Storage condition code for the shipped product"
    - name: "quarantine_status"
      expr: quarantine_status
      comment: "Quarantine status upon receipt"
    - name: "temperature_excursion_flag"
      expr: temperature_excursion_flag
      comment: "Whether temperature excursion was detected for this line item"
    - name: "receipt_month"
      expr: DATE_TRUNC('month', receipt_date)
      comment: "Month of receipt for trend analysis"
  measures:
    - name: "total_shipment_lines"
      expr: COUNT(1)
      comment: "Total number of shipment line items processed"
    - name: "total_quantity_shipped"
      expr: SUM(CAST(quantity_shipped AS DOUBLE))
      comment: "Total quantity of units shipped across all lines"
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity of units confirmed received"
    - name: "total_quantity_discrepancy"
      expr: SUM(CAST(quantity_discrepancy AS DOUBLE))
      comment: "Total quantity discrepancy between shipped and received — measures supply chain accuracy"
    - name: "lines_with_temp_excursion"
      expr: COUNT(CASE WHEN temperature_excursion_flag = TRUE THEN 1 END)
      comment: "Number of shipment lines affected by temperature excursions"
    - name: "lines_receipt_confirmed"
      expr: COUNT(CASE WHEN receipt_confirmed = TRUE THEN 1 END)
      comment: "Number of shipment lines with confirmed receipt — tracks accountability compliance"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`supply_kit_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Kit-level inventory metrics tracking stock status, dispensing activity, expiry risk, and cold chain compliance across depots and sites."
  source: "`clinical_trials_ecm`.`supply`.`kit_inventory`"
  dimensions:
    - name: "kit_status"
      expr: kit_status
      comment: "Current lifecycle status of the kit (available, dispensed, expired, destroyed)"
    - name: "current_location_type"
      expr: current_location_type
      comment: "Where the kit currently resides (depot, site, in-transit)"
    - name: "blinding_status"
      expr: blinding_status
      comment: "Blinding integrity status of the kit"
    - name: "storage_condition"
      expr: storage_condition
      comment: "Required storage condition for the kit"
    - name: "treatment_arm"
      expr: treatment_arm
      comment: "Treatment arm assignment for the kit"
    - name: "country_code"
      expr: country_code
      comment: "Country where the kit is located"
    - name: "temperature_excursion_flag"
      expr: temperature_excursion_flag
      comment: "Whether a temperature excursion has been recorded for this kit"
    - name: "cold_chain_required"
      expr: cold_chain_required
      comment: "Whether the kit requires cold chain storage"
  measures:
    - name: "total_kits"
      expr: COUNT(1)
      comment: "Total number of kits in inventory across all statuses"
    - name: "kits_available"
      expr: COUNT(CASE WHEN kit_status = 'Available' THEN 1 END)
      comment: "Number of kits currently available for dispensing"
    - name: "kits_dispensed"
      expr: COUNT(CASE WHEN kit_status = 'Dispensed' THEN 1 END)
      comment: "Number of kits that have been dispensed to subjects"
    - name: "kits_expired"
      expr: COUNT(CASE WHEN kit_status = 'Expired' THEN 1 END)
      comment: "Number of kits that have expired — measures wastage and expiry management effectiveness"
    - name: "kits_with_temp_excursion"
      expr: COUNT(CASE WHEN temperature_excursion_flag = TRUE THEN 1 END)
      comment: "Number of kits affected by temperature excursions — critical quality metric"
    - name: "kits_accountability_reconciled"
      expr: COUNT(CASE WHEN accountability_reconciled = TRUE THEN 1 END)
      comment: "Number of kits with completed accountability reconciliation"
    - name: "distinct_sites_with_inventory"
      expr: COUNT(DISTINCT study_site_id)
      comment: "Number of distinct study sites holding kit inventory"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`supply_depot_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Depot-level inventory metrics for monitoring stock levels, QP release status, quarantine volumes, and expiry risk across the clinical supply network."
  source: "`clinical_trials_ecm`.`supply`.`depot_inventory`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of inventory record (available, quarantined, expired, destroyed)"
    - name: "qp_release_status"
      expr: qp_release_status
      comment: "Qualified Person release status — determines if product is cleared for distribution"
    - name: "kit_type"
      expr: kit_type
      comment: "Type of kit held in depot inventory"
    - name: "storage_condition_zone"
      expr: storage_condition_zone
      comment: "Storage zone within the depot (ambient, refrigerated, frozen)"
    - name: "is_cold_chain"
      expr: is_cold_chain
      comment: "Whether the inventory item requires cold chain management"
    - name: "is_controlled_substance"
      expr: is_controlled_substance
      comment: "Whether the item is a controlled substance requiring additional oversight"
    - name: "temperature_excursion_flag"
      expr: temperature_excursion_flag
      comment: "Whether a temperature excursion has been recorded for this inventory"
  measures:
    - name: "total_inventory_records"
      expr: COUNT(1)
      comment: "Total number of depot inventory records"
    - name: "records_quarantined"
      expr: COUNT(CASE WHEN inventory_status = 'Quarantined' THEN 1 END)
      comment: "Number of inventory records in quarantine — indicates quality holds"
    - name: "records_with_temp_excursion"
      expr: COUNT(CASE WHEN temperature_excursion_flag = TRUE THEN 1 END)
      comment: "Number of inventory records affected by temperature excursions"
    - name: "records_pending_qp_release"
      expr: COUNT(CASE WHEN qp_release_status = 'Pending' THEN 1 END)
      comment: "Number of inventory items awaiting QP release — bottleneck indicator"
    - name: "distinct_depots_with_stock"
      expr: COUNT(DISTINCT depot_id)
      comment: "Number of depots holding inventory — network coverage metric"
    - name: "distinct_batches_in_stock"
      expr: COUNT(DISTINCT batch_number)
      comment: "Number of distinct batches in depot inventory — complexity indicator"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`supply_temperature_excursion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Temperature excursion event metrics tracking frequency, severity, disposition outcomes, and root causes to drive cold chain quality improvement."
  source: "`clinical_trials_ecm`.`supply`.`temperature_excursion`"
  dimensions:
    - name: "excursion_status"
      expr: excursion_status
      comment: "Current status of the excursion investigation (open, under review, closed)"
    - name: "excursion_type"
      expr: excursion_type
      comment: "Type of excursion (high temperature, low temperature, freeze)"
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Final disposition decision for affected product (use, quarantine, destroy)"
    - name: "location_type"
      expr: location_type
      comment: "Where the excursion occurred (depot, site, in-transit)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Categorized root cause of the excursion for trend analysis"
    - name: "detection_source"
      expr: detection_source
      comment: "How the excursion was detected (data logger, manual check, alarm)"
    - name: "impact_assessment_outcome"
      expr: impact_assessment_outcome
      comment: "Outcome of the impact assessment on product quality"
    - name: "capa_required"
      expr: capa_required
      comment: "Whether a CAPA (Corrective and Preventive Action) is required"
    - name: "sponsor_notification_required"
      expr: sponsor_notification_required
      comment: "Whether sponsor notification was required for this excursion"
    - name: "excursion_month"
      expr: DATE_TRUNC('month', disposition_date)
      comment: "Month of disposition for trend analysis"
  measures:
    - name: "total_excursion_events"
      expr: COUNT(1)
      comment: "Total number of temperature excursion events recorded"
    - name: "excursions_requiring_capa"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN 1 END)
      comment: "Number of excursions requiring CAPA — indicates systemic quality issues"
    - name: "excursions_product_destroyed"
      expr: COUNT(CASE WHEN disposition_decision = 'Destroy' THEN 1 END)
      comment: "Number of excursions resulting in product destruction — direct financial and supply impact"
    - name: "excursions_requiring_replacement"
      expr: COUNT(CASE WHEN replacement_kits_required = TRUE THEN 1 END)
      comment: "Number of excursions requiring kit replacement — measures supply disruption"
    - name: "max_temperature_breach"
      expr: MAX(max_temp_recorded_c)
      comment: "Highest temperature recorded across all excursion events — severity indicator"
    - name: "avg_upper_threshold"
      expr: AVG(CAST(upper_threshold_c AS DOUBLE))
      comment: "Average upper temperature threshold across excursion events"
    - name: "avg_lower_threshold"
      expr: AVG(CAST(lower_threshold_c AS DOUBLE))
      comment: "Average lower temperature threshold across excursion events"
    - name: "avg_mean_kinetic_temp"
      expr: AVG(CAST(mean_kinetic_temp_c AS DOUBLE))
      comment: "Average mean kinetic temperature across excursions — key stability indicator"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`supply_return_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IMP return and reconciliation metrics tracking return volumes, condition assessment, and accountability closure rates for regulatory compliance."
  source: "`clinical_trials_ecm`.`supply`.`return_record`"
  dimensions:
    - name: "return_status"
      expr: return_status
      comment: "Current status of the return (received, reconciled, destroyed)"
    - name: "return_type"
      expr: return_type
      comment: "Type of return (subject return, site return, depot return)"
    - name: "return_reason"
      expr: return_reason
      comment: "Reason for the return (completion, withdrawal, expiry, excursion)"
    - name: "return_condition"
      expr: return_condition
      comment: "Physical condition of returned product (intact, damaged, opened)"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of accountability reconciliation for the return"
    - name: "destruction_method"
      expr: destruction_method
      comment: "Method used for destruction of returned product"
    - name: "blinding_intact"
      expr: blinding_intact
      comment: "Whether blinding was maintained on the returned kit"
    - name: "temperature_excursion_flag"
      expr: temperature_excursion_flag
      comment: "Whether a temperature excursion was noted during return transit"
    - name: "return_month"
      expr: DATE_TRUNC('month', return_date)
      comment: "Month of return for trend analysis"
  measures:
    - name: "total_returns"
      expr: COUNT(1)
      comment: "Total number of IMP return records"
    - name: "returns_reconciled"
      expr: COUNT(CASE WHEN reconciliation_status = 'Reconciled' THEN 1 END)
      comment: "Number of returns fully reconciled — measures accountability closure rate"
    - name: "returns_with_discrepancy"
      expr: COUNT(CASE WHEN discrepancy_quantity IS NOT NULL AND discrepancy_quantity != '0' THEN 1 END)
      comment: "Number of returns with quantity discrepancies — flags accountability issues"
    - name: "returns_blinding_compromised"
      expr: COUNT(CASE WHEN blinding_intact = FALSE THEN 1 END)
      comment: "Number of returns where blinding was compromised — trial integrity risk"
    - name: "returns_with_temp_excursion"
      expr: COUNT(CASE WHEN temperature_excursion_flag = TRUE THEN 1 END)
      comment: "Number of returns with temperature excursions during transit"
    - name: "distinct_sites_returning"
      expr: COUNT(DISTINCT study_site_id)
      comment: "Number of distinct sites submitting returns — operational breadth indicator"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`supply_destruction_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IMP destruction metrics tracking volumes, compliance status, and regulatory notification requirements for end-of-lifecycle accountability."
  source: "`clinical_trials_ecm`.`supply`.`destruction_record`"
  dimensions:
    - name: "destruction_status"
      expr: destruction_status
      comment: "Current status of the destruction process (pending, completed, certified)"
    - name: "destruction_method"
      expr: destruction_method
      comment: "Method of destruction used (incineration, chemical, etc.)"
    - name: "destruction_reason"
      expr: destruction_reason
      comment: "Reason for destruction (expiry, excursion, study closure, recall)"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the destruction record"
    - name: "is_blinded_destruction"
      expr: is_blinded_destruction
      comment: "Whether destruction was performed under blinded conditions"
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Whether regulatory authority notification was required"
    - name: "facility_country_code"
      expr: facility_country_code
      comment: "Country where destruction was performed"
    - name: "tmf_filing_status"
      expr: tmf_filing_status
      comment: "Status of TMF filing for the destruction certificate"
    - name: "destruction_month"
      expr: DATE_TRUNC('month', destruction_date)
      comment: "Month of destruction for trend analysis"
  measures:
    - name: "total_destruction_records"
      expr: COUNT(1)
      comment: "Total number of destruction records"
    - name: "total_weight_destroyed_kg"
      expr: SUM(CAST(weight_destroyed_kg AS DOUBLE))
      comment: "Total weight of IMP destroyed in kilograms"
    - name: "destructions_pending_reconciliation"
      expr: COUNT(CASE WHEN reconciliation_status != 'Reconciled' THEN 1 END)
      comment: "Number of destructions not yet reconciled — compliance risk indicator"
    - name: "destructions_requiring_regulatory_notification"
      expr: COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END)
      comment: "Number of destructions requiring regulatory notification — regulatory burden metric"
    - name: "destructions_with_temp_excursion"
      expr: COUNT(CASE WHEN temperature_excursion_noted = TRUE THEN 1 END)
      comment: "Number of destructions triggered by temperature excursions"
    - name: "distinct_studies_with_destructions"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of distinct studies with destruction activity"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`supply_resupply_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Resupply order metrics tracking demand patterns, fulfillment performance, emergency overrides, and supply continuity risk for clinical sites."
  source: "`clinical_trials_ecm`.`supply`.`resupply_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the resupply order (pending, approved, shipped, delivered, cancelled)"
    - name: "trigger_type"
      expr: trigger_type
      comment: "What triggered the resupply (RTSM automatic, manual, emergency)"
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency classification of the resupply order"
    - name: "blinding_level"
      expr: blinding_level
      comment: "Blinding level of the ordered supply"
    - name: "storage_condition"
      expr: storage_condition
      comment: "Required storage condition for the ordered supply"
    - name: "cold_chain_required"
      expr: cold_chain_required
      comment: "Whether cold chain logistics are required"
    - name: "is_emergency_override"
      expr: is_emergency_override
      comment: "Whether this is an emergency override order bypassing normal thresholds"
    - name: "requesting_location_type"
      expr: requesting_location_type
      comment: "Type of location requesting resupply (site, depot)"
    - name: "order_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month of order placement for demand trend analysis"
  measures:
    - name: "total_resupply_orders"
      expr: COUNT(1)
      comment: "Total number of resupply orders placed"
    - name: "emergency_override_orders"
      expr: COUNT(CASE WHEN is_emergency_override = TRUE THEN 1 END)
      comment: "Number of emergency override orders — indicates supply planning gaps"
    - name: "cancelled_orders"
      expr: COUNT(CASE WHEN order_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled resupply orders — measures demand forecasting accuracy"
    - name: "orders_delivered"
      expr: COUNT(CASE WHEN order_status = 'Delivered' THEN 1 END)
      comment: "Number of resupply orders successfully delivered"
    - name: "distinct_sites_ordering"
      expr: COUNT(DISTINCT study_site_id)
      comment: "Number of distinct sites placing resupply orders — demand breadth indicator"
    - name: "distinct_studies_with_orders"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of distinct studies with active resupply demand"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`supply_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply planning metrics tracking plan status, buffer stock adequacy, overage assumptions, and forecasting parameters for strategic supply chain governance."
  source: "`clinical_trials_ecm`.`supply`.`supply_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the supply plan (draft, approved, active, closed)"
    - name: "blinding_type"
      expr: blinding_type
      comment: "Blinding type for the planned supply (open-label, single-blind, double-blind)"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the supply plan (global, regional, country-specific)"
    - name: "planning_cycle"
      expr: planning_cycle
      comment: "Planning cycle frequency (monthly, quarterly, ad-hoc)"
    - name: "cold_chain_required"
      expr: cold_chain_required
      comment: "Whether the plan involves cold chain products"
    - name: "expiry_management_strategy"
      expr: expiry_management_strategy
      comment: "Strategy for managing product expiry (FEFO, rotation, etc.)"
    - name: "randomization_method"
      expr: randomization_method
      comment: "Randomization method impacting supply allocation"
    - name: "plan_month"
      expr: DATE_TRUNC('month', plan_date)
      comment: "Month of plan creation for planning activity trends"
  measures:
    - name: "total_supply_plans"
      expr: COUNT(1)
      comment: "Total number of supply plans created"
    - name: "avg_buffer_stock_weeks"
      expr: AVG(CAST(buffer_stock_weeks AS DOUBLE))
      comment: "Average buffer stock in weeks across plans — measures supply risk tolerance"
    - name: "avg_overage_pct"
      expr: AVG(CAST(overage_pct AS DOUBLE))
      comment: "Average overage percentage planned — measures manufacturing efficiency assumptions"
    - name: "avg_dropout_rate_pct"
      expr: AVG(CAST(dropout_rate_pct AS DOUBLE))
      comment: "Average dropout rate assumption — key demand forecasting parameter"
    - name: "plans_with_cold_chain"
      expr: COUNT(CASE WHEN cold_chain_required = TRUE THEN 1 END)
      comment: "Number of plans requiring cold chain — complexity and cost driver"
    - name: "plans_with_destruction_included"
      expr: COUNT(CASE WHEN destruction_plan_included = TRUE THEN 1 END)
      comment: "Number of plans including destruction planning — end-of-lifecycle readiness"
    - name: "distinct_studies_planned"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of distinct studies with active supply plans"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`supply_manufacture_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing batch metrics tracking release status, recall risk, batch complexity, and production quality for IMP supply assurance."
  source: "`clinical_trials_ecm`.`supply`.`manufacture_batch`"
  dimensions:
    - name: "release_status"
      expr: release_status
      comment: "QP release status of the batch (released, pending, rejected, recalled)"
    - name: "batch_type"
      expr: batch_type
      comment: "Type of manufacturing batch (clinical, commercial, stability)"
    - name: "dosage_form"
      expr: dosage_form
      comment: "Dosage form of the manufactured product"
    - name: "storage_condition"
      expr: storage_condition
      comment: "Required storage condition for the batch"
    - name: "blinding_type"
      expr: blinding_type
      comment: "Blinding type applied to the batch"
    - name: "is_comparator"
      expr: is_comparator
      comment: "Whether this is a comparator product batch"
    - name: "is_placebo"
      expr: is_placebo
      comment: "Whether this is a placebo batch"
    - name: "recall_flag"
      expr: recall_flag
      comment: "Whether the batch has been recalled"
    - name: "manufacturing_site_country"
      expr: manufacturing_site_country
      comment: "Country of the manufacturing site"
    - name: "manufacture_month"
      expr: DATE_TRUNC('month', manufacture_date)
      comment: "Month of manufacture for production trend analysis"
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Total number of manufacturing batches"
    - name: "batches_released"
      expr: COUNT(CASE WHEN release_status = 'Released' THEN 1 END)
      comment: "Number of batches with QP release — measures manufacturing throughput"
    - name: "batches_recalled"
      expr: COUNT(CASE WHEN recall_flag = TRUE THEN 1 END)
      comment: "Number of batches recalled — critical quality and patient safety metric"
    - name: "batches_pending_release"
      expr: COUNT(CASE WHEN release_status = 'Pending' THEN 1 END)
      comment: "Number of batches awaiting QP release — supply pipeline bottleneck indicator"
    - name: "distinct_manufacturing_sites"
      expr: COUNT(DISTINCT manufacturing_site_name)
      comment: "Number of distinct manufacturing sites — supply network diversity"
    - name: "avg_max_storage_temp"
      expr: AVG(CAST(storage_temp_max_c AS DOUBLE))
      comment: "Average maximum storage temperature across batches"
    - name: "avg_min_storage_temp"
      expr: AVG(CAST(storage_temp_min_c AS DOUBLE))
      comment: "Average minimum storage temperature across batches"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`supply_import_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Import permit metrics tracking regulatory approval timelines, utilization rates, and permit status for cross-border IMP supply chain compliance."
  source: "`clinical_trials_ecm`.`supply`.`import_permit`"
  dimensions:
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of the import permit (pending, approved, expired, revoked)"
    - name: "permit_type"
      expr: permit_type
      comment: "Type of import permit"
    - name: "import_country_code"
      expr: import_country_code
      comment: "Country into which the IMP is being imported"
    - name: "export_country_code"
      expr: export_country_code
      comment: "Country from which the IMP is being exported"
    - name: "storage_condition"
      expr: storage_condition
      comment: "Required storage condition for the permitted product"
    - name: "renewal_required"
      expr: renewal_required
      comment: "Whether the permit requires renewal"
    - name: "requires_cold_chain"
      expr: requires_cold_chain
      comment: "Whether the permitted product requires cold chain"
    - name: "approval_month"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month of permit approval for regulatory timeline analysis"
  measures:
    - name: "total_import_permits"
      expr: COUNT(1)
      comment: "Total number of import permits managed"
    - name: "permits_approved"
      expr: COUNT(CASE WHEN permit_status = 'Approved' THEN 1 END)
      comment: "Number of permits currently approved and valid"
    - name: "permits_pending"
      expr: COUNT(CASE WHEN permit_status = 'Pending' THEN 1 END)
      comment: "Number of permits pending approval — supply chain risk indicator"
    - name: "total_permitted_quantity"
      expr: SUM(CAST(permitted_quantity AS DOUBLE))
      comment: "Total quantity permitted for import across all permits"
    - name: "total_utilized_quantity"
      expr: SUM(CAST(utilized_quantity AS DOUBLE))
      comment: "Total quantity actually utilized against permits — measures permit efficiency"
    - name: "distinct_import_countries"
      expr: COUNT(DISTINCT import_country_code)
      comment: "Number of distinct countries with active import permits — regulatory complexity indicator"
$$;