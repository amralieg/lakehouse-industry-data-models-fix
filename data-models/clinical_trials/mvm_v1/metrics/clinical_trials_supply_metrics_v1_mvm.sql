-- Metric views for domain: supply | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-07 02:29:00

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`supply_dispensing_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for IMP dispensing activity across clinical trial sites. Tracks dispensing volume, dose compliance, protocol deviation rates, and cold-chain integrity to support supply accountability and patient safety oversight."
  source: "`clinical_trials_ecm`.`supply`.`dispensing_record`"
  dimensions:
    - name: "dispensing_date"
      expr: dispensing_date
      comment: "Date the IMP was dispensed to the subject, used for time-series trending of dispensing activity."
    - name: "dispensing_status"
      expr: dispensing_status
      comment: "Current status of the dispensing event (e.g., Completed, Pending, Cancelled) for operational filtering."
    - name: "dosage_form"
      expr: dosage_form
      comment: "Pharmaceutical form of the dispensed IMP (e.g., tablet, injection) for product-level analysis."
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route by which the IMP was administered (e.g., oral, IV) for clinical and supply segmentation."
    - name: "dispensing_method"
      expr: dispensing_method
      comment: "Method used for dispensing (e.g., direct, RTSM-guided) to evaluate process adherence."
    - name: "protocol_deviation_flag"
      expr: protocol_deviation_flag
      comment: "Indicates whether a protocol deviation was associated with this dispensing event."
    - name: "temperature_excursion_flag"
      expr: temperature_excursion_flag
      comment: "Flags dispensing events where a cold-chain temperature excursion was recorded."
    - name: "accountability_reconciled"
      expr: accountability_reconciled
      comment: "Indicates whether this dispensing record has been reconciled in the accountability process."
    - name: "is_unblinded"
      expr: is_unblinded
      comment: "Flags records where the blind was broken, critical for data integrity monitoring."
  measures:
    - name: "total_dispensing_events"
      expr: COUNT(1)
      comment: "Total number of IMP dispensing events. Baseline volume metric for supply consumption tracking and site performance benchmarking."
    - name: "total_quantity_dispensed"
      expr: SUM(CAST(quantity_dispensed AS DOUBLE))
      comment: "Total units of IMP dispensed across all events. Core supply consumption metric used to validate supply plan accuracy and trigger resupply."
    - name: "total_quantity_returned"
      expr: SUM(CAST(quantity_returned AS DOUBLE))
      comment: "Total units of IMP returned by subjects. Used to calculate net consumption and assess subject compliance."
    - name: "avg_dose_amount"
      expr: AVG(CAST(dose_amount AS DOUBLE))
      comment: "Average dose amount dispensed per event. Deviations from protocol-specified dose signal potential compliance or data quality issues."
    - name: "avg_subject_compliance_pct"
      expr: AVG(CAST(subject_compliance_pct AS DOUBLE))
      comment: "Average subject medication compliance percentage across dispensing events. A key efficacy and safety signal; low compliance triggers clinical intervention."
    - name: "protocol_deviation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN protocol_deviation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dispensing events associated with a protocol deviation. Elevated rates signal site training gaps or process failures requiring CAPA."
    - name: "temperature_excursion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN temperature_excursion_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dispensing events with a recorded temperature excursion. Directly impacts IMP integrity and patient safety; drives cold-chain corrective actions."
    - name: "unblinding_event_count"
      expr: SUM(CASE WHEN is_unblinded = TRUE THEN 1 ELSE 0 END)
      comment: "Count of dispensing events where unblinding occurred. Unblinding events are tightly controlled; unexpected counts trigger regulatory and safety review."
    - name: "accountability_reconciliation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN accountability_reconciled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dispensing records that have been reconciled. GCP requires full accountability; low rates indicate reconciliation backlogs and audit risk."
    - name: "distinct_subjects_dispensed"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Number of unique trial subjects who received IMP. Tracks active treatment population size and supports enrollment-to-dispensing conversion analysis."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`supply_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Logistics and cold-chain KPIs for IMP shipments between depots and clinical sites. Monitors delivery performance, temperature excursion rates, and customs clearance efficiency to ensure uninterrupted supply to sites."
  source: "`clinical_trials_ecm`.`supply`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (e.g., In Transit, Delivered, Quarantined) for pipeline visibility."
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of shipment (e.g., Initial Supply, Resupply, Return) for categorized logistics analysis."
    - name: "direction"
      expr: direction
      comment: "Direction of shipment flow (e.g., Outbound, Return) to distinguish supply vs. returns logistics."
    - name: "carrier_name"
      expr: carrier_name
      comment: "Name of the logistics carrier used, enabling carrier performance benchmarking."
    - name: "destination_node_type"
      expr: destination_node_type
      comment: "Type of destination node (e.g., Site, Depot) for network-level supply flow analysis."
    - name: "storage_condition"
      expr: storage_condition
      comment: "Required storage condition for the shipment (e.g., Refrigerated, Ambient) for cold-chain segmentation."
    - name: "temperature_excursion_flag"
      expr: temperature_excursion_flag
      comment: "Flags shipments where a temperature excursion was recorded during transit."
    - name: "customs_clearance_required"
      expr: customs_clearance_required
      comment: "Indicates whether customs clearance was required, used to segment international vs. domestic shipment performance."
    - name: "dispatch_date"
      expr: dispatch_date
      comment: "Date the shipment was dispatched, used for time-series logistics performance trending."
    - name: "actual_delivery_date"
      expr: actual_delivery_date
      comment: "Date the shipment was actually delivered, used to compute delivery lead times."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments. Baseline logistics volume metric for supply chain throughput monitoring."
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_delivery_date <= expected_delivery_date AND actual_delivery_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN actual_delivery_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of shipments delivered on or before the expected delivery date. A primary logistics KPI; low rates risk site stock-outs and trial delays."
    - name: "temperature_excursion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN temperature_excursion_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments with a recorded temperature excursion. Directly impacts IMP usability and patient safety; drives cold-chain vendor reviews."
    - name: "avg_max_recorded_temp_c"
      expr: AVG(CAST(max_recorded_temp_c AS DOUBLE))
      comment: "Average maximum temperature recorded across shipments. Monitors cold-chain upper-bound compliance; exceedances may render IMP unusable."
    - name: "avg_min_recorded_temp_c"
      expr: AVG(CAST(min_recorded_temp_c AS DOUBLE))
      comment: "Average minimum temperature recorded across shipments. Monitors cold-chain lower-bound compliance for freeze-sensitive products."
    - name: "quarantine_shipment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN quarantine_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments placed in quarantine. Quarantined shipments represent supply at risk; high rates signal quality or cold-chain systemic issues."
    - name: "avg_delivery_lead_time_days"
      expr: AVG(DATEDIFF(actual_delivery_date, dispatch_date))
      comment: "Average number of days from dispatch to actual delivery. Measures logistics efficiency; extended lead times risk site stock-outs."
    - name: "distinct_sites_supplied"
      expr: COUNT(DISTINCT study_site_id)
      comment: "Number of unique clinical sites that received shipments. Measures supply network reach and supports site-level supply equity analysis."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`supply_temperature_excursion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and risk KPIs for IMP temperature excursion events. Tracks excursion frequency, severity, disposition outcomes, and CAPA requirements to protect IMP integrity and ensure GCP compliance."
  source: "`clinical_trials_ecm`.`supply`.`temperature_excursion`"
  dimensions:
    - name: "excursion_type"
      expr: excursion_type
      comment: "Type of temperature excursion (e.g., High, Low, Freeze) for root-cause categorization."
    - name: "excursion_status"
      expr: excursion_status
      comment: "Current resolution status of the excursion (e.g., Open, Closed, Under Review)."
    - name: "location_type"
      expr: location_type
      comment: "Location where the excursion occurred (e.g., Depot, In Transit, Site) to identify systemic weak points."
    - name: "detection_source"
      expr: detection_source
      comment: "Source that detected the excursion (e.g., Data Logger, Manual Check) for monitoring system effectiveness analysis."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Categorized root cause of the excursion (e.g., Equipment Failure, Human Error) to drive systemic corrective actions."
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Final disposition of affected IMP (e.g., Released, Destroyed, Quarantined) to quantify supply impact."
    - name: "capa_required"
      expr: capa_required
      comment: "Indicates whether a CAPA was required for this excursion, flagging higher-severity events."
    - name: "impact_assessment_outcome"
      expr: impact_assessment_outcome
      comment: "Outcome of the stability/impact assessment (e.g., No Impact, Product Destroyed) for risk quantification."
    - name: "excursion_start_timestamp"
      expr: DATE_TRUNC('month', excursion_start_timestamp)
      comment: "Month of excursion start, used for time-series trending of excursion frequency."
  measures:
    - name: "total_excursion_events"
      expr: COUNT(1)
      comment: "Total number of temperature excursion events. Baseline quality metric; rising trends trigger cold-chain infrastructure reviews."
    - name: "capa_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN capa_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of excursion events requiring a CAPA. High rates indicate systemic cold-chain failures demanding executive intervention."
    - name: "avg_max_temp_recorded_c"
      expr: AVG(CAST(max_temp_recorded_c AS DOUBLE))
      comment: "Average maximum temperature recorded during excursion events. Quantifies thermal severity to prioritize impact assessments."
    - name: "avg_mean_kinetic_temp_c"
      expr: AVG(CAST(mean_kinetic_temp_c AS DOUBLE))
      comment: "Average mean kinetic temperature across excursion events. MKT is the regulatory-standard measure for cumulative thermal stress on IMP."
    - name: "open_excursion_count"
      expr: SUM(CASE WHEN excursion_status NOT IN ('Closed', 'Resolved') THEN 1 ELSE 0 END)
      comment: "Count of excursion events not yet resolved. Open excursions represent active supply risk and regulatory exposure."
    - name: "sponsor_notification_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sponsor_notification_required = TRUE AND sponsor_notification_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN sponsor_notification_required = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of excursions requiring sponsor notification where notification was completed. Regulatory compliance KPI; gaps create audit findings."
    - name: "stability_data_reviewed_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN stability_data_reviewed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of excursion events where stability data was reviewed. GCP requires stability review before disposition; low rates signal process gaps."
    - name: "distinct_studies_affected"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of unique studies affected by temperature excursions. Broad study impact signals cross-program cold-chain infrastructure risk."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`supply_accountability_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GCP accountability and reconciliation KPIs for IMP supply. Tracks reconciliation completion, discrepancy rates, signoff compliance, and protocol deviation flags to ensure regulatory-grade drug accountability across sites."
  source: "`clinical_trials_ecm`.`supply`.`accountability_reconciliation`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Current status of the reconciliation record (e.g., Complete, Pending, Discrepancy) for pipeline management."
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Type of reconciliation (e.g., Periodic, Final, Unscheduled) for process-level analysis."
    - name: "reconciliation_date"
      expr: reconciliation_date
      comment: "Date the reconciliation was performed, used for time-series compliance trending."
    - name: "discrepancy_resolution_status"
      expr: discrepancy_resolution_status
      comment: "Status of discrepancy resolution (e.g., Resolved, Pending Investigation) to track outstanding accountability gaps."
    - name: "gcp_compliance_flag"
      expr: gcp_compliance_flag
      comment: "Indicates whether the reconciliation record is GCP-compliant, the primary regulatory quality gate."
    - name: "protocol_deviation_flag"
      expr: protocol_deviation_flag
      comment: "Flags reconciliation records associated with a protocol deviation."
    - name: "cra_signoff_flag"
      expr: cra_signoff_flag
      comment: "Indicates whether the CRA has signed off on the reconciliation, a required GCP step."
    - name: "investigator_signoff_flag"
      expr: investigator_signoff_flag
      comment: "Indicates whether the Principal Investigator has signed off, a required GCP accountability step."
    - name: "temperature_excursion_flag"
      expr: temperature_excursion_flag
      comment: "Flags reconciliation records where a temperature excursion was noted, impacting IMP accountability."
    - name: "inspection_ready_flag"
      expr: inspection_ready_flag
      comment: "Indicates whether the reconciliation record is inspection-ready, a key regulatory preparedness indicator."
  measures:
    - name: "total_reconciliation_records"
      expr: COUNT(1)
      comment: "Total number of accountability reconciliation records. Baseline volume metric for GCP accountability process coverage."
    - name: "gcp_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gcp_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reconciliation records that are GCP-compliant. The primary regulatory KPI for drug accountability; non-compliance triggers regulatory action."
    - name: "discrepancy_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN discrepancy_resolution_status IS NOT NULL AND discrepancy_resolution_status != '' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reconciliation records with a recorded discrepancy. High rates indicate supply accountability failures requiring investigation."
    - name: "dual_signoff_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cra_signoff_flag = TRUE AND investigator_signoff_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of records with both CRA and Investigator signoff completed. GCP mandates dual signoff; gaps represent direct audit findings."
    - name: "inspection_readiness_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN inspection_ready_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reconciliation records flagged as inspection-ready. Regulatory agencies expect 100% readiness; gaps signal trial quality risk."
    - name: "protocol_deviation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN protocol_deviation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reconciliation records associated with a protocol deviation. Elevated rates signal systemic site compliance issues."
    - name: "overdue_reconciliation_count"
      expr: SUM(CASE WHEN next_reconciliation_due_date < CURRENT_DATE() AND reconciliation_status NOT IN ('Complete', 'Closed') THEN 1 ELSE 0 END)
      comment: "Count of reconciliation records past their due date and not yet completed. Overdue reconciliations are a direct GCP compliance risk and inspection finding."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`supply_depot_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Depot-level IMP inventory health KPIs. Monitors stock availability, quarantine rates, expiry risk, and cold-chain compliance to ensure depots maintain adequate, quality-assured supply for site distribution."
  source: "`clinical_trials_ecm`.`supply`.`depot_inventory`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of the inventory record (e.g., Available, Quarantined, Expired) for stock health segmentation."
    - name: "kit_type"
      expr: kit_type
      comment: "Type of kit in inventory (e.g., Active, Placebo, Comparator) for treatment-arm supply analysis."
    - name: "is_cold_chain"
      expr: is_cold_chain
      comment: "Indicates whether the inventory item requires cold-chain storage, for cold-chain capacity planning."
    - name: "is_controlled_substance"
      expr: is_controlled_substance
      comment: "Flags controlled substance inventory requiring enhanced security and regulatory oversight."
    - name: "qp_release_status"
      expr: qp_release_status
      comment: "Qualified Person release status (e.g., Released, Pending, Rejected) — only released stock can be dispensed."
    - name: "temperature_excursion_flag"
      expr: temperature_excursion_flag
      comment: "Flags inventory records with a recorded temperature excursion, indicating potential quality compromise."
    - name: "storage_condition_zone"
      expr: storage_condition_zone
      comment: "Storage zone assigned to the inventory (e.g., Refrigerated, Frozen, Ambient) for capacity utilization analysis."
    - name: "expiry_date"
      expr: expiry_date
      comment: "Expiry date of the inventory batch, used for near-expiry risk monitoring and waste prevention."
    - name: "accountability_reconciliation_status"
      expr: accountability_reconciliation_status
      comment: "Reconciliation status of the inventory record for GCP accountability tracking."
  measures:
    - name: "total_inventory_records"
      expr: COUNT(1)
      comment: "Total number of depot inventory records. Baseline metric for inventory portfolio size and data completeness."
    - name: "qp_released_inventory_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN qp_release_status = 'Released' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inventory records with QP release. Only QP-released stock is distributable; low rates signal supply availability risk."
    - name: "quarantine_inventory_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN inventory_status = 'Quarantined' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inventory records in quarantine status. High quarantine rates reduce usable supply and may delay site distribution."
    - name: "near_expiry_inventory_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inventory records expiring within 90 days. Near-expiry stock drives urgent redistribution or destruction decisions to minimize waste."
    - name: "temperature_excursion_affected_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN temperature_excursion_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inventory records with a temperature excursion flag. Excursion-affected stock requires quality review before use; high rates signal depot infrastructure issues."
    - name: "distinct_depots_with_inventory"
      expr: COUNT(DISTINCT depot_id)
      comment: "Number of unique depots holding active inventory. Measures supply network distribution breadth and depot utilization."
    - name: "distinct_batches_in_inventory"
      expr: COUNT(DISTINCT manufacture_batch_id)
      comment: "Number of unique manufacturing batches in depot inventory. Batch diversity supports supply continuity if a batch recall occurs."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`supply_resupply_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply chain responsiveness KPIs for IMP resupply orders. Tracks order fulfillment rates, emergency override frequency, lead time performance, and RTSM-triggered resupply efficiency to prevent site stock-outs."
  source: "`clinical_trials_ecm`.`supply`.`resupply_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the resupply order (e.g., Approved, Shipped, Delivered, Cancelled) for pipeline visibility."
    - name: "trigger_type"
      expr: trigger_type
      comment: "What triggered the resupply order (e.g., RTSM Automatic, Manual, Emergency) to evaluate supply planning effectiveness."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency classification of the order (e.g., Routine, Urgent, Emergency) for prioritization and escalation analysis."
    - name: "requesting_location_type"
      expr: requesting_location_type
      comment: "Type of location requesting resupply (e.g., Site, Depot) for network-level demand analysis."
    - name: "cold_chain_required"
      expr: cold_chain_required
      comment: "Indicates whether the resupply order requires cold-chain logistics, for cold-chain capacity planning."
    - name: "is_emergency_override"
      expr: is_emergency_override
      comment: "Flags orders placed as emergency overrides, indicating supply planning failures or unexpected demand spikes."
    - name: "blinding_level"
      expr: blinding_level
      comment: "Blinding level of the ordered supply (e.g., Double-Blind, Open-Label) for blinded supply chain integrity."
    - name: "order_date"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month the resupply order was placed, used for demand trending and supply planning cycle analysis."
  measures:
    - name: "total_resupply_orders"
      expr: COUNT(1)
      comment: "Total number of resupply orders placed. Baseline demand metric for supply chain throughput and planning cycle evaluation."
    - name: "on_time_fulfillment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_delivery_date <= expected_fulfillment_date AND actual_delivery_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN actual_delivery_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of resupply orders fulfilled by the expected date. The primary supply chain KPI; low rates directly risk site stock-outs and trial delays."
    - name: "emergency_override_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_emergency_override = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of resupply orders placed as emergency overrides. High rates indicate supply planning failures; each emergency order carries premium logistics cost and trial risk."
    - name: "cancellation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of resupply orders that were cancelled. Cancellations may indicate over-ordering, enrollment changes, or supply plan inaccuracies."
    - name: "avg_fulfillment_lead_time_days"
      expr: AVG(DATEDIFF(actual_delivery_date, CAST(order_date AS DATE)))
      comment: "Average days from order placement to actual delivery. Measures supply chain responsiveness; long lead times require larger buffer stocks."
    - name: "reconciliation_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN accountability_reconciled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of resupply orders that have been accountability-reconciled. GCP requires full reconciliation; low rates indicate accountability process gaps."
    - name: "distinct_sites_resupplied"
      expr: COUNT(DISTINCT study_site_id)
      comment: "Number of unique clinical sites that received resupply orders. Measures supply network coverage and identifies sites not receiving adequate resupply."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`supply_destruction_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IMP destruction accountability KPIs. Tracks destruction volumes, regulatory notification compliance, reconciliation status, and blinded destruction integrity to ensure GCP-compliant drug disposal and minimize regulatory risk."
  source: "`clinical_trials_ecm`.`supply`.`destruction_record`"
  dimensions:
    - name: "destruction_status"
      expr: destruction_status
      comment: "Current status of the destruction record (e.g., Completed, Pending, Authorized) for process pipeline management."
    - name: "destruction_method"
      expr: destruction_method
      comment: "Method used for IMP destruction (e.g., Incineration, Chemical) for regulatory and environmental compliance analysis."
    - name: "destruction_reason"
      expr: destruction_reason
      comment: "Reason for destruction (e.g., Expired, Temperature Excursion, Protocol Deviation) to quantify supply waste drivers."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the destruction record for GCP accountability completeness."
    - name: "is_blinded_destruction"
      expr: is_blinded_destruction
      comment: "Indicates whether the destruction was performed under blinded conditions, critical for trial integrity."
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Flags destruction events requiring regulatory notification, for compliance monitoring."
    - name: "temperature_excursion_noted"
      expr: temperature_excursion_noted
      comment: "Indicates whether a temperature excursion was noted as a contributing factor to destruction."
    - name: "destruction_date"
      expr: destruction_date
      comment: "Date of IMP destruction, used for time-series waste and disposal trending."
  measures:
    - name: "total_destruction_events"
      expr: COUNT(1)
      comment: "Total number of IMP destruction events. Baseline metric for supply waste volume and destruction process workload."
    - name: "total_weight_destroyed_kg"
      expr: SUM(CAST(weight_destroyed_kg AS DOUBLE))
      comment: "Total weight of IMP destroyed in kilograms. Quantifies supply waste magnitude; high values relative to dispensed supply signal planning or quality inefficiencies."
    - name: "regulatory_notification_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_notification_required = TRUE AND regulatory_notification_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN regulatory_notification_required = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of destruction events requiring regulatory notification where notification was completed. Non-compliance is a direct regulatory violation with potential trial suspension risk."
    - name: "reconciliation_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reconciliation_status = 'Complete' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of destruction records with completed reconciliation. GCP mandates full accountability for destroyed IMP; gaps create audit findings."
    - name: "temperature_excursion_destruction_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN temperature_excursion_noted = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of destruction events attributed to temperature excursions. Quantifies cold-chain failure cost in terms of destroyed supply."
    - name: "avg_weight_per_destruction_event_kg"
      expr: AVG(CAST(weight_destroyed_kg AS DOUBLE))
      comment: "Average weight of IMP destroyed per destruction event. Benchmarks destruction batch sizes; unusually large events may indicate batch recalls or systemic quality failures."
    - name: "distinct_studies_with_destructions"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of unique studies with destruction events. Broad study impact signals cross-program supply quality or planning issues."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`supply_import_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory import permit KPIs for cross-border IMP supply. Tracks permit utilization rates, expiry risk, approval lead times, and renewal compliance to prevent supply disruptions caused by regulatory import barriers."
  source: "`clinical_trials_ecm`.`supply`.`import_permit`"
  dimensions:
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of the import permit (e.g., Active, Expired, Revoked, Pending) for regulatory pipeline management."
    - name: "permit_type"
      expr: permit_type
      comment: "Type of import permit (e.g., Single Use, Multiple Use) for regulatory strategy analysis."
    - name: "import_country_code"
      expr: import_country_code
      comment: "Country into which the IMP is being imported, for country-level regulatory compliance analysis."
    - name: "issuing_authority_name"
      expr: issuing_authority_name
      comment: "Name of the regulatory authority that issued the permit, for authority-level performance benchmarking."
    - name: "requires_cold_chain"
      expr: requires_cold_chain
      comment: "Indicates whether the permitted shipment requires cold-chain logistics."
    - name: "renewal_required"
      expr: renewal_required
      comment: "Flags permits requiring renewal, for proactive regulatory timeline management."
    - name: "valid_from_date"
      expr: valid_from_date
      comment: "Start date of permit validity, used for permit lifecycle and coverage analysis."
    - name: "valid_to_date"
      expr: valid_to_date
      comment: "Expiry date of the permit, used for near-expiry risk monitoring."
  measures:
    - name: "total_import_permits"
      expr: COUNT(1)
      comment: "Total number of import permits. Baseline metric for regulatory import portfolio size across countries."
    - name: "permit_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(utilized_quantity AS DOUBLE)) / NULLIF(SUM(CAST(permitted_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of permitted import quantity that has been utilized. Low utilization may indicate over-permitting; high utilization signals risk of supply disruption if permits are not renewed."
    - name: "near_expiry_permit_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN valid_to_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 60) AND permit_status = 'Active' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN permit_status = 'Active' THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of active permits expiring within 60 days. Near-expiry permits without renewal risk halting cross-border IMP supply."
    - name: "avg_approval_lead_time_days"
      expr: AVG(DATEDIFF(approval_date, application_date))
      comment: "Average days from permit application to approval. Long lead times require earlier application submission to prevent supply gaps."
    - name: "total_permitted_quantity"
      expr: SUM(CAST(permitted_quantity AS DOUBLE))
      comment: "Total quantity of IMP permitted for import across all active permits. Measures regulatory import capacity available to the supply chain."
    - name: "total_utilized_quantity"
      expr: SUM(CAST(utilized_quantity AS DOUBLE))
      comment: "Total quantity of IMP actually imported under permits. Compared against permitted quantity to assess regulatory capacity consumption."
    - name: "active_permit_count"
      expr: SUM(CASE WHEN permit_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of currently active import permits. Ensures sufficient regulatory coverage for ongoing supply operations across all countries."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`supply_site_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site-level IMP inventory KPIs for clinical trial supply management. Monitors stock availability, resupply trigger rates, expiry risk, and storage compliance to ensure sites maintain adequate, quality-assured IMP for subject dosing."
  source: "`clinical_trials_ecm`.`supply`.`site_inventory`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of site inventory (e.g., Available, Quarantined, Expired) for stock health monitoring."
    - name: "location_type"
      expr: location_type
      comment: "Type of storage location at the site (e.g., Pharmacy, Investigator Site) for site-level supply segmentation."
    - name: "blinding_level"
      expr: blinding_level
      comment: "Blinding level of the inventory (e.g., Double-Blind, Open-Label) for blinded supply integrity monitoring."
    - name: "storage_condition"
      expr: storage_condition
      comment: "Required storage condition for the inventory (e.g., Refrigerated, Ambient) for compliance analysis."
    - name: "storage_condition_compliant"
      expr: storage_condition_compliant
      comment: "Indicates whether the inventory is stored under compliant conditions — a direct GCP quality gate."
    - name: "resupply_triggered"
      expr: resupply_triggered
      comment: "Flags inventory records where a resupply has been triggered, for supply chain responsiveness analysis."
    - name: "destruction_authorized"
      expr: destruction_authorized
      comment: "Indicates whether destruction of this inventory has been authorized."
    - name: "expiry_date"
      expr: expiry_date
      comment: "Expiry date of the site inventory batch, used for near-expiry risk monitoring."
    - name: "accountability_reconciled"
      expr: accountability_reconciled
      comment: "Indicates whether this site inventory record has been accountability-reconciled."
  measures:
    - name: "total_site_inventory_records"
      expr: COUNT(1)
      comment: "Total number of site inventory records. Baseline metric for site-level supply portfolio coverage."
    - name: "storage_condition_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN storage_condition_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of site inventory records stored under compliant conditions. Non-compliant storage compromises IMP integrity and is a direct GCP violation."
    - name: "near_expiry_site_inventory_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of site inventory expiring within 90 days. Near-expiry stock at sites requires urgent resupply or redistribution to prevent dosing gaps."
    - name: "resupply_trigger_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN resupply_triggered = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of site inventory records where a resupply was triggered. High rates may indicate under-stocking or aggressive resupply thresholds."
    - name: "accountability_reconciliation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN accountability_reconciled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of site inventory records that have been accountability-reconciled. GCP requires full reconciliation; low rates indicate compliance risk."
    - name: "distinct_sites_with_inventory"
      expr: COUNT(DISTINCT study_site_id)
      comment: "Number of unique clinical sites holding active inventory. Measures supply network site coverage and identifies sites without adequate stock."
    - name: "distinct_studies_with_site_inventory"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of unique studies with active site inventory records. Measures cross-study supply operations breadth."
$$;