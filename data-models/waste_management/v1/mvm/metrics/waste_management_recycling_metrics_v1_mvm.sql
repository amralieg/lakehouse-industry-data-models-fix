-- Metric views for domain: recycling | Business: Waste Management | Version: 1 | Generated on: 2026-05-07 22:39:52

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_inbound_load`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for inbound material loads received at MRF facilities. Tracks tonnage throughput, contamination rates, tipping fee revenue, and load quality to support facility planning and program performance management."
  source: "`waste_management_ecm`.`recycling`.`inbound_load`"
  dimensions:
    - name: "mrf_facility_id"
      expr: mrf_facility_id
      comment: "MRF facility that received the inbound load — primary grouping for facility-level performance analysis."
    - name: "load_source_type"
      expr: load_source_type
      comment: "Origin type of the load (e.g., residential curbside, commercial, drop-off) — used to segment tonnage by program type."
    - name: "load_status"
      expr: load_status
      comment: "Current processing status of the load (e.g., received, processed, rejected) — used to monitor operational pipeline."
    - name: "processing_shift"
      expr: processing_shift
      comment: "Shift during which the load was processed — enables shift-level throughput and quality analysis."
    - name: "contamination_flag"
      expr: contamination_flag
      comment: "Boolean indicator that the load was flagged for contamination — used to filter and segment contaminated vs. clean loads."
    - name: "vehicle_type"
      expr: vehicle_type
      comment: "Type of collection vehicle delivering the load — supports fleet and route performance correlation."
    - name: "received_date"
      expr: DATE_TRUNC('day', received_timestamp)
      comment: "Date the load was received at the facility — used for daily and trend-based throughput reporting."
    - name: "received_month"
      expr: DATE_TRUNC('month', received_timestamp)
      comment: "Month the load was received — used for monthly tonnage and contamination trend analysis."
  measures:
    - name: "total_inbound_gross_tons"
      expr: SUM(CAST(gross_weight_tons AS DOUBLE))
      comment: "Total gross tonnage of all inbound loads received. Core throughput KPI used to measure facility intake volume and program performance against tonnage commitments."
    - name: "total_inbound_net_tons"
      expr: SUM(CAST(net_weight_tons AS DOUBLE))
      comment: "Total net tonnage (after tare deduction) of inbound loads. Represents actual material volume available for processing and is the basis for diversion and recovery calculations."
    - name: "total_estimated_diversion_tons"
      expr: SUM(CAST(estimated_diversion_tons AS DOUBLE))
      comment: "Total estimated tons diverted from landfill across all inbound loads. Key environmental performance KPI tied to diversion rate targets and regulatory reporting."
    - name: "total_tipping_fee_revenue"
      expr: SUM(CAST(tipping_fee_amount AS DOUBLE))
      comment: "Total tipping fee revenue collected from inbound loads. Direct revenue KPI used to assess facility gate revenue and program financial performance."
    - name: "total_contamination_surcharge_revenue"
      expr: SUM(CAST(contamination_surcharge AS DOUBLE))
      comment: "Total contamination surcharge revenue collected. Tracks financial recovery from contaminated loads and incentivizes source separation compliance."
    - name: "avg_contamination_pct"
      expr: AVG(CAST(contamination_pct AS DOUBLE))
      comment: "Average contamination percentage across all inbound loads. Critical quality KPI — elevated contamination reduces commodity value, increases processing costs, and risks contract penalties."
    - name: "contaminated_load_count"
      expr: COUNT(CASE WHEN contamination_flag = TRUE THEN inbound_load_id END)
      comment: "Number of loads flagged for contamination. Used to track contamination incident frequency and evaluate source community education program effectiveness."
    - name: "total_load_count"
      expr: COUNT(1)
      comment: "Total number of inbound loads received. Baseline volume metric used to normalize contamination rates and compute per-load averages."
    - name: "avg_net_tons_per_load"
      expr: AVG(CAST(net_weight_tons AS DOUBLE))
      comment: "Average net tonnage per inbound load. Operational efficiency metric used to assess load density, vehicle utilization, and route optimization opportunities."
    - name: "rejected_load_count"
      expr: COUNT(CASE WHEN load_status = 'rejected' THEN inbound_load_id END)
      comment: "Number of loads rejected at intake. Tracks material acceptance quality and compliance with facility permit conditions — high rejection rates signal upstream collection or customer issues."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_sort_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MRF sort line operational performance KPIs covering throughput, recovery rates, contamination, residue generation, and downtime. Drives facility efficiency management and equipment investment decisions."
  source: "`waste_management_ecm`.`recycling`.`sort_session`"
  dimensions:
    - name: "mrf_facility_id"
      expr: mrf_facility_id
      comment: "MRF facility where the sort session occurred — primary grouping for facility-level operational benchmarking."
    - name: "sort_line_id"
      expr: sort_line_id
      comment: "Sort line on which the session ran — enables line-level performance comparison and capacity planning."
    - name: "session_date"
      expr: session_date
      comment: "Date of the sort session — used for daily operational trend analysis."
    - name: "session_month"
      expr: DATE_TRUNC('month', start_timestamp)
      comment: "Month of the sort session — used for monthly throughput and recovery trend reporting."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type (e.g., day, night, weekend) — used to compare performance across shifts and identify shift-specific inefficiencies."
    - name: "session_type"
      expr: session_type
      comment: "Type of sort session (e.g., standard, special sort, QC run) — used to segment operational vs. quality-control sessions."
    - name: "session_status"
      expr: session_status
      comment: "Completion status of the session (e.g., completed, aborted, partial) — used to filter valid sessions for performance calculations."
    - name: "quality_grade"
      expr: quality_grade
      comment: "Quality grade assigned to the sort session output — used to track output quality trends and grade distribution over time."
    - name: "equipment_fault_flag"
      expr: equipment_fault_flag
      comment: "Boolean flag indicating an equipment fault occurred during the session — used to correlate equipment failures with throughput and recovery losses."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Boolean flag indicating a safety incident occurred during the session — used for EHS performance tracking and regulatory reporting."
  measures:
    - name: "total_input_tonnage"
      expr: SUM(CAST(input_tonnage AS DOUBLE))
      comment: "Total tonnage fed into sort lines across all sessions. Primary throughput KPI used to measure MRF processing volume against design capacity."
    - name: "total_recovered_tonnage"
      expr: SUM(CAST(recovered_tonnage AS DOUBLE))
      comment: "Total tonnage of recyclable material recovered from sort sessions. Core environmental and revenue KPI — recovered material is sold as commodity and diverted from landfill."
    - name: "total_residue_tonnage"
      expr: SUM(CAST(residue_tonnage AS DOUBLE))
      comment: "Total residue tonnage generated from sort sessions. Residue is landfilled at cost — minimizing residue is a key operational and environmental objective."
    - name: "avg_diversion_rate_pct"
      expr: AVG(CAST(diversion_rate_pct AS DOUBLE))
      comment: "Average diversion rate percentage across sort sessions. Strategic KPI measuring the share of input material successfully diverted from landfill — benchmarked against facility and regulatory targets."
    - name: "avg_contamination_rate_pct"
      expr: AVG(CAST(contamination_rate_pct AS DOUBLE))
      comment: "Average contamination rate percentage across sort sessions. Elevated contamination reduces commodity grade and sale price — tracked against contract thresholds and facility permit limits."
    - name: "avg_throughput_rate_tph"
      expr: AVG(CAST(throughput_rate_tph AS DOUBLE))
      comment: "Average sort line throughput in tons per hour. Operational efficiency KPI used to assess line performance against design capacity and identify bottlenecks."
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Total number of sort sessions completed. Baseline volume metric used to normalize per-session KPIs and assess operational cadence."
    - name: "sessions_with_equipment_fault"
      expr: COUNT(CASE WHEN equipment_fault_flag = TRUE THEN sort_session_id END)
      comment: "Number of sort sessions impacted by equipment faults. Tracks equipment reliability and its operational impact — high fault frequency triggers maintenance investment decisions."
    - name: "sessions_with_safety_incident"
      expr: COUNT(CASE WHEN safety_incident_flag = TRUE THEN sort_session_id END)
      comment: "Number of sort sessions with a recorded safety incident. EHS performance KPI used for regulatory reporting and safety program evaluation."
    - name: "avg_contamination_input_pct"
      expr: AVG(CAST(contamination_input_pct AS DOUBLE))
      comment: "Average contamination percentage in the input material stream. Measures upstream source separation quality — high input contamination drives processing cost and residue generation."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_bale`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commodity bale production, quality, and value KPIs. Tracks bale output, weight, estimated market value, contamination, and moisture to support commodity sales, quality management, and inventory decisions."
  source: "`waste_management_ecm`.`recycling`.`bale`"
  dimensions:
    - name: "mrf_facility_id"
      expr: mrf_facility_id
      comment: "MRF facility that produced the bale — primary grouping for facility-level bale production analysis."
    - name: "commodity_id"
      expr: commodity_id
      comment: "Commodity type of the bale (e.g., OCC, HDPE, aluminum) — used to analyze production volume and value by material type."
    - name: "commodity_grade_id"
      expr: commodity_grade_id
      comment: "Quality grade of the bale — used to track grade distribution and assess quality management effectiveness."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the bale (e.g., in storage, allocated, shipped, rejected) — used to manage inventory pipeline and identify bottlenecks."
    - name: "production_shift"
      expr: production_shift
      comment: "Production shift during which the bale was produced — used for shift-level quality and output analysis."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Result of the bale quality inspection (e.g., pass, fail, conditional) — used to track quality pass rates and rejection trends."
    - name: "reinspection_required"
      expr: reinspection_required
      comment: "Boolean flag indicating the bale requires reinspection — used to track quality exception volume and inspection workload."
    - name: "production_month"
      expr: DATE_TRUNC('month', production_timestamp)
      comment: "Month of bale production — used for monthly production volume and value trend analysis."
  measures:
    - name: "total_bale_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of all bales produced in kilograms. Primary production volume KPI used to measure commodity output and compare against processing throughput targets."
    - name: "total_estimated_value_usd"
      expr: SUM(CAST(estimated_value_usd AS DOUBLE))
      comment: "Total estimated market value of bales produced. Revenue pipeline KPI used to forecast commodity sale revenue and assess inventory value at risk."
    - name: "avg_bale_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average bale weight in kilograms. Quality and operational KPI — bales outside spec weight range may be rejected by buyers or incur contract penalties."
    - name: "avg_contamination_pct"
      expr: AVG(CAST(contamination_pct AS DOUBLE))
      comment: "Average contamination percentage across all bales. Critical quality KPI — contamination above contract thresholds triggers price deductions or buyer rejection."
    - name: "avg_moisture_pct"
      expr: AVG(CAST(moisture_pct AS DOUBLE))
      comment: "Average moisture percentage across all bales. Moisture above spec reduces commodity value and can trigger buyer rejection — tracked against grade specifications."
    - name: "avg_market_price_per_ton"
      expr: AVG(CAST(market_price_per_ton AS DOUBLE))
      comment: "Average market price per ton across bales. Tracks commodity price realization and is used to assess pricing strategy and buyer contract performance."
    - name: "total_bale_count"
      expr: COUNT(1)
      comment: "Total number of bales produced. Baseline production volume metric used to normalize per-bale KPIs and assess baling line productivity."
    - name: "rejected_bale_count"
      expr: COUNT(CASE WHEN inspection_result = 'fail' THEN bale_id END)
      comment: "Number of bales that failed quality inspection. Tracks quality rejection rate — high rejection rates signal processing or contamination issues that reduce saleable output."
    - name: "avg_density_kg_per_m3"
      expr: AVG(CAST(density_kg_per_m3 AS DOUBLE))
      comment: "Average bale density in kg per cubic meter. Operational quality KPI — bale density affects transport efficiency and buyer acceptance; deviations from spec indicate baler performance issues."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_commodity_sale`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commodity sales revenue, pricing, and volume KPIs. Tracks net sale revenue, freight costs, contamination deductions, and sale volume to support commodity trading performance and buyer relationship management."
  source: "`waste_management_ecm`.`recycling`.`commodity_sale`"
  dimensions:
    - name: "mrf_facility_id"
      expr: mrf_facility_id
      comment: "MRF facility originating the commodity sale — used for facility-level revenue attribution and performance benchmarking."
    - name: "commodity_id"
      expr: commodity_id
      comment: "Commodity type sold (e.g., OCC, HDPE, aluminum) — primary dimension for commodity-level revenue and volume analysis."
    - name: "commodity_buyer_id"
      expr: commodity_buyer_id
      comment: "Buyer receiving the commodity — used to analyze revenue concentration, buyer performance, and contract compliance."
    - name: "sale_status"
      expr: sale_status
      comment: "Status of the sale transaction (e.g., invoiced, paid, disputed) — used to track revenue realization and outstanding receivables."
    - name: "pricing_basis"
      expr: pricing_basis
      comment: "Basis on which the commodity was priced (e.g., spot, contract, index) — used to analyze pricing strategy mix and market exposure."
    - name: "is_export_sale"
      expr: is_export_sale
      comment: "Boolean flag indicating whether the sale was an export transaction — used to segment domestic vs. export revenue and assess trade policy exposure."
    - name: "shipment_method"
      expr: shipment_method
      comment: "Method of shipment (e.g., truck, rail, container) — used to analyze freight cost drivers and logistics efficiency."
    - name: "sale_month"
      expr: DATE_TRUNC('month', sale_date)
      comment: "Month of the commodity sale — used for monthly revenue trend analysis and period-over-period comparisons."
  measures:
    - name: "total_net_sale_amount_usd"
      expr: SUM(CAST(net_sale_amount_usd AS DOUBLE))
      comment: "Total net sale revenue from commodity sales after adjustments. Primary revenue KPI for the recycling business — directly tied to commodity market performance and operational quality."
    - name: "total_gross_sale_amount_usd"
      expr: SUM(CAST(total_sale_amount_usd AS DOUBLE))
      comment: "Total gross sale amount before adjustments. Used alongside net sale amount to quantify the impact of price adjustments, contamination deductions, and freight charges."
    - name: "total_freight_charges_usd"
      expr: SUM(CAST(freight_charge_usd AS DOUBLE))
      comment: "Total freight charges incurred on commodity sales. Logistics cost KPI — freight is a significant margin driver in commodity trading and is tracked against transport responsibility terms."
    - name: "total_adjustment_amount_usd"
      expr: SUM(CAST(adjustment_amount_usd AS DOUBLE))
      comment: "Total price adjustments applied to commodity sales (e.g., contamination deductions, quality penalties). Tracks the financial impact of quality issues on realized revenue."
    - name: "total_net_weight_tons_sold"
      expr: SUM(CAST(total_net_weight_tons AS DOUBLE))
      comment: "Total net weight of commodities sold in tons. Volume KPI used to track sales throughput, assess market demand, and compare against production output."
    - name: "total_gross_weight_tons_sold"
      expr: SUM(CAST(total_gross_weight_tons AS DOUBLE))
      comment: "Total gross weight of commodities sold in tons. Used with net weight to calculate tare and assess weighing accuracy across shipments."
    - name: "avg_contamination_rate_pct"
      expr: AVG(CAST(contamination_rate_percent AS DOUBLE))
      comment: "Average contamination rate on sold commodities. Quality KPI at point of sale — contamination above contract thresholds triggers buyer deductions and relationship risk."
    - name: "total_sale_transactions"
      expr: COUNT(1)
      comment: "Total number of commodity sale transactions. Baseline volume metric used to normalize per-transaction revenue and assess sales activity levels."
    - name: "distinct_buyers"
      expr: COUNT(DISTINCT commodity_buyer_id)
      comment: "Number of distinct commodity buyers transacted with. Buyer diversification KPI — concentration risk is high when few buyers account for most revenue."
    - name: "export_sale_count"
      expr: COUNT(CASE WHEN is_export_sale = TRUE THEN commodity_sale_id END)
      comment: "Number of export commodity sale transactions. Tracks export market activity and exposure to international trade regulations and currency risk."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_contamination_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contamination event tracking KPIs covering financial impact, material diversion loss, and event frequency. Supports quality management, regulatory compliance, and customer education program decisions."
  source: "`waste_management_ecm`.`recycling`.`contamination_event`"
  dimensions:
    - name: "mrf_facility_id"
      expr: mrf_facility_id
      comment: "MRF facility where the contamination event was detected — used for facility-level contamination performance benchmarking."
    - name: "contamination_type"
      expr: contamination_type
      comment: "Type of contaminant detected (e.g., food waste, hazardous material, non-recyclable plastic) — used to identify dominant contamination sources and target education programs."
    - name: "contamination_level"
      expr: contamination_level
      comment: "Severity level of the contamination event (e.g., low, medium, high, critical) — used to prioritize response actions and assess operational impact."
    - name: "detection_method"
      expr: detection_method
      comment: "Method used to detect the contamination (e.g., visual inspection, lab analysis, optical sorter) — used to evaluate detection system effectiveness."
    - name: "disposition_action"
      expr: disposition_action
      comment: "Action taken to dispose of or remediate the contaminated material — used to track remediation costs and process compliance."
    - name: "epa_reportable"
      expr: epa_reportable
      comment: "Boolean flag indicating the event meets EPA reportable threshold — used to track regulatory reporting obligations and compliance exposure."
    - name: "customer_notification_sent"
      expr: customer_notification_sent
      comment: "Boolean flag indicating whether the customer was notified of the contamination event — used to track customer communication compliance."
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of the contamination event — used for monthly trend analysis and seasonal contamination pattern identification."
  measures:
    - name: "total_commodity_value_loss_usd"
      expr: SUM(CAST(commodity_value_loss_usd AS DOUBLE))
      comment: "Total commodity value lost due to contamination events. Direct financial impact KPI — quantifies the revenue cost of contamination and justifies investment in source separation programs."
    - name: "total_processing_cost_impact_usd"
      expr: SUM(CAST(processing_cost_impact_usd AS DOUBLE))
      comment: "Total additional processing cost incurred due to contamination events. Operational cost KPI — contamination increases sorting labor, equipment wear, and residue disposal costs."
    - name: "total_diversion_impact_tons"
      expr: SUM(CAST(diversion_impact_tons AS DOUBLE))
      comment: "Total tonnage of recyclable material lost to landfill due to contamination events. Environmental performance KPI — directly reduces diversion rate and may trigger regulatory non-compliance."
    - name: "avg_contaminants_percentage"
      expr: AVG(CAST(contaminants_percentage AS DOUBLE))
      comment: "Average contamination percentage across all contamination events. Quality baseline metric used to track contamination severity trends and assess program intervention effectiveness."
    - name: "total_contamination_events"
      expr: COUNT(1)
      comment: "Total number of contamination events recorded. Frequency KPI used to track contamination incident rates and evaluate the effectiveness of source separation education programs."
    - name: "epa_reportable_event_count"
      expr: COUNT(CASE WHEN epa_reportable = TRUE THEN contamination_event_id END)
      comment: "Number of contamination events meeting EPA reportable thresholds. Regulatory compliance KPI — unreported events create significant legal and financial liability."
    - name: "avg_sample_weight_lbs"
      expr: AVG(CAST(sample_weight_lbs AS DOUBLE))
      comment: "Average sample weight used in contamination analysis. Quality assurance metric — ensures sampling methodology is consistent and statistically valid across events."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_commodity_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commodity inventory position, valuation, and storage utilization KPIs. Supports inventory management, working capital optimization, and commodity sales planning decisions."
  source: "`waste_management_ecm`.`recycling`.`commodity_inventory`"
  dimensions:
    - name: "mrf_facility_id"
      expr: mrf_facility_id
      comment: "MRF facility holding the inventory — used for facility-level inventory position and capacity utilization analysis."
    - name: "commodity_id"
      expr: commodity_id
      comment: "Commodity type in inventory (e.g., OCC, HDPE, aluminum) — primary dimension for commodity-level inventory analysis."
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of the inventory record (e.g., available, allocated, on hold) — used to distinguish sellable from committed or restricted inventory."
    - name: "commodity_grade"
      expr: commodity_grade
      comment: "Quality grade of the inventory — used to analyze grade mix in storage and assess marketability of on-hand inventory."
    - name: "quality_certification_status"
      expr: quality_certification_status
      comment: "Certification status of the inventory (e.g., certified, pending, expired) — used to track inventory eligible for premium-grade buyer contracts."
    - name: "snapshot_date"
      expr: snapshot_date
      comment: "Date of the inventory snapshot — used for point-in-time inventory position analysis and trend tracking."
    - name: "snapshot_month"
      expr: DATE_TRUNC('month', snapshot_timestamp)
      comment: "Month of the inventory snapshot — used for monthly inventory level and valuation trend analysis."
  measures:
    - name: "total_inventory_weight_tons"
      expr: SUM(CAST(total_weight_tons AS DOUBLE))
      comment: "Total weight of commodity inventory on hand in tons. Primary inventory position KPI used to assess storage utilization and available supply for commodity sales."
    - name: "total_available_weight_tons"
      expr: SUM(CAST(available_weight_tons AS DOUBLE))
      comment: "Total weight of inventory available for sale (not yet allocated). Sellable inventory KPI used to assess near-term commodity sales capacity and revenue pipeline."
    - name: "total_allocated_weight_tons"
      expr: SUM(CAST(allocated_weight_tons AS DOUBLE))
      comment: "Total weight of inventory already allocated to buyers or contracts. Tracks committed inventory volume and helps prevent over-selling or under-delivery against contracts."
    - name: "total_inventory_valuation_usd"
      expr: SUM(CAST(inventory_valuation_amount AS DOUBLE))
      comment: "Total market valuation of commodity inventory on hand. Working capital KPI — inventory value fluctuates with commodity markets and directly impacts balance sheet and cash flow planning."
    - name: "avg_storage_capacity_utilization_pct"
      expr: AVG(CAST(storage_capacity_utilization_percent AS DOUBLE))
      comment: "Average storage capacity utilization percentage across inventory records. Facility capacity KPI — high utilization constrains intake and may require expedited sales or additional storage."
    - name: "avg_contamination_rate_pct"
      expr: AVG(CAST(contamination_rate_percent AS DOUBLE))
      comment: "Average contamination rate of inventory on hand. Quality KPI — contaminated inventory may be unsaleable or subject to price deductions, impacting realized revenue."
    - name: "avg_market_price_per_ton"
      expr: AVG(CAST(market_price_per_ton AS DOUBLE))
      comment: "Average market price per ton across inventory records. Pricing intelligence KPI used to assess current commodity market conditions and inform sales timing decisions."
    - name: "total_maximum_capacity_tons"
      expr: SUM(CAST(maximum_capacity_tons AS DOUBLE))
      comment: "Total maximum storage capacity in tons across all inventory records. Denominator for capacity utilization analysis and facility expansion planning."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_residue_disposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MRF residue disposal cost, volume, and compliance KPIs. Tracks residue tonnage sent to landfill, disposal costs, and regulatory compliance to support cost reduction and diversion improvement initiatives."
  source: "`waste_management_ecm`.`recycling`.`residue_disposal`"
  dimensions:
    - name: "mrf_facility_id"
      expr: mrf_facility_id
      comment: "MRF facility generating the residue — primary grouping for facility-level residue cost and volume benchmarking."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method used to dispose of the residue (e.g., landfill, incineration, waste-to-energy) — used to analyze disposal method mix and associated cost and environmental impact."
    - name: "disposal_destination_type"
      expr: disposal_destination_type
      comment: "Type of disposal destination (e.g., municipal landfill, TSDF, transfer station) — used to track regulatory compliance and disposal cost drivers."
    - name: "disposal_status"
      expr: disposal_status
      comment: "Current status of the disposal transaction (e.g., pending, completed, rejected) — used to monitor disposal pipeline and identify bottlenecks."
    - name: "contamination_level"
      expr: contamination_level
      comment: "Contamination level of the residue being disposed — used to correlate contamination severity with disposal cost and method."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the disposal invoice (e.g., paid, outstanding, disputed) — used to manage disposal accounts payable."
    - name: "disposal_month"
      expr: DATE_TRUNC('month', disposal_timestamp)
      comment: "Month of the disposal event — used for monthly residue cost and volume trend analysis."
  measures:
    - name: "total_residue_weight_tons"
      expr: SUM(CAST(residue_weight_tons AS DOUBLE))
      comment: "Total residue tonnage disposed. Core environmental and cost KPI — residue represents material that failed to be recycled and incurs landfill disposal costs. Minimizing residue is a primary MRF performance objective."
    - name: "total_disposal_cost_usd"
      expr: SUM(CAST(total_disposal_cost AS DOUBLE))
      comment: "Total cost of residue disposal including tipping fees, hauling, and surcharges. Direct operational cost KPI — disposal costs reduce recycling program margins and are tracked against budget."
    - name: "total_hauling_cost_usd"
      expr: SUM(CAST(hauling_cost AS DOUBLE))
      comment: "Total hauling cost for residue transport to disposal sites. Logistics cost component used to identify opportunities for route optimization and hauling contract renegotiation."
    - name: "total_environmental_surcharge_usd"
      expr: SUM(CAST(environmental_surcharge AS DOUBLE))
      comment: "Total environmental surcharges paid on residue disposal. Regulatory cost KPI — surcharges increase with hazardous or special waste content and signal compliance risk."
    - name: "avg_tipping_fee_per_ton"
      expr: AVG(CAST(tipping_fee_per_ton AS DOUBLE))
      comment: "Average tipping fee per ton of residue disposed. Unit cost KPI used to benchmark disposal costs across facilities and disposal sites, and to evaluate disposal agreement pricing."
    - name: "total_disposal_events"
      expr: COUNT(1)
      comment: "Total number of residue disposal events. Baseline frequency metric used to normalize per-event costs and assess disposal logistics cadence."
    - name: "avg_gross_weight_tons_per_disposal"
      expr: AVG(CAST(gross_weight_tons AS DOUBLE))
      comment: "Average gross weight per disposal event. Operational efficiency metric — larger loads reduce per-ton hauling costs and improve disposal logistics efficiency."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_outbound_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbound commodity shipment logistics KPIs covering shipment volume, weight, freight costs, and delivery performance. Supports supply chain management, buyer fulfillment, and logistics cost optimization."
  source: "`waste_management_ecm`.`recycling`.`outbound_shipment`"
  dimensions:
    - name: "mrf_facility_id"
      expr: mrf_facility_id
      comment: "MRF facility originating the shipment — used for facility-level outbound logistics performance analysis."
    - name: "commodity_id"
      expr: commodity_id
      comment: "Commodity type being shipped — used to analyze shipment volume and freight cost by material type."
    - name: "commodity_buyer_id"
      expr: commodity_buyer_id
      comment: "Buyer receiving the shipment — used to analyze fulfillment performance and freight cost by buyer."
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (e.g., in transit, delivered, delayed) — used to monitor fulfillment pipeline and identify delivery issues."
    - name: "destination_state"
      expr: destination_state
      comment: "Destination state of the shipment — used for geographic analysis of commodity flows and freight cost drivers."
    - name: "destination_country"
      expr: destination_country
      comment: "Destination country of the shipment — used to segment domestic vs. export shipments and assess international trade exposure."
    - name: "hazmat_indicator"
      expr: hazmat_indicator
      comment: "Boolean flag indicating the shipment contains hazardous materials — used to track hazmat shipment compliance and associated regulatory requirements."
    - name: "shipment_month"
      expr: DATE_TRUNC('month', shipment_date)
      comment: "Month of the shipment — used for monthly outbound volume and freight cost trend analysis."
  measures:
    - name: "total_net_weight_tons_shipped"
      expr: SUM(CAST(net_weight_tons AS DOUBLE))
      comment: "Total net weight of commodities shipped in tons. Primary outbound volume KPI used to track commodity sales fulfillment and compare against inbound processing throughput."
    - name: "total_gross_weight_tons_shipped"
      expr: SUM(CAST(gross_weight_tons AS DOUBLE))
      comment: "Total gross weight of outbound shipments. Used with net weight to assess tare weight consistency and shipment accuracy."
    - name: "total_freight_charges_usd"
      expr: SUM(CAST(freight_charges_usd AS DOUBLE))
      comment: "Total freight charges incurred on outbound commodity shipments. Logistics cost KPI — freight is a major margin driver in commodity trading and is tracked against transport responsibility contract terms."
    - name: "total_insurance_value_usd"
      expr: SUM(CAST(insurance_value_usd AS DOUBLE))
      comment: "Total insured value of outbound shipments. Risk management KPI used to ensure adequate coverage for commodity in transit and assess exposure to cargo loss."
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of outbound shipments. Baseline logistics volume metric used to normalize per-shipment costs and assess fulfillment activity levels."
    - name: "hazmat_shipment_count"
      expr: COUNT(CASE WHEN hazmat_indicator = TRUE THEN outbound_shipment_id END)
      comment: "Number of outbound shipments classified as hazardous materials. Regulatory compliance KPI — hazmat shipments require special permits, manifests, and transporter certifications."
    - name: "avg_net_weight_tons_per_shipment"
      expr: AVG(CAST(net_weight_tons AS DOUBLE))
      comment: "Average net weight per outbound shipment. Logistics efficiency KPI — larger average shipment weights reduce per-ton freight costs and improve transport utilization."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_buyer_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commodity buyer contract portfolio KPIs covering committed volumes, pricing terms, contamination thresholds, and contract status. Supports contract management, revenue planning, and buyer relationship decisions."
  source: "`waste_management_ecm`.`recycling`.`buyer_contract`"
  dimensions:
    - name: "mrf_facility_id"
      expr: mrf_facility_id
      comment: "MRF facility covered by the buyer contract — used for facility-level contract portfolio analysis."
    - name: "commodity_id"
      expr: commodity_id
      comment: "Commodity type covered by the contract — used to analyze contract terms and committed volumes by material type."
    - name: "commodity_buyer_id"
      expr: commodity_buyer_id
      comment: "Buyer party to the contract — used to analyze contract portfolio by buyer and assess buyer concentration risk."
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the buyer contract (e.g., active, expired, terminated, pending) — used to track active contract coverage and renewal pipeline."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of buyer contract (e.g., spot, long-term, index-linked) — used to analyze contract mix and market price exposure."
    - name: "price_mechanism"
      expr: price_mechanism
      comment: "Pricing mechanism used in the contract (e.g., fixed, index, negotiated) — used to assess revenue predictability and market risk exposure."
    - name: "auto_renewal"
      expr: auto_renewal
      comment: "Boolean flag indicating the contract auto-renews — used to identify contracts requiring proactive renewal management."
    - name: "contract_start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the contract became effective — used for contract vintage analysis and renewal cycle planning."
  measures:
    - name: "total_committed_volume_tons_monthly"
      expr: SUM(CAST(committed_volume_tons_monthly AS DOUBLE))
      comment: "Total monthly committed volume in tons across all active buyer contracts. Revenue planning KPI — committed volumes represent guaranteed offtake and are compared against production capacity to identify gaps."
    - name: "avg_base_price_per_ton"
      expr: AVG(CAST(base_price_per_ton AS DOUBLE))
      comment: "Average base price per ton across buyer contracts. Pricing benchmark KPI used to assess contract pricing competitiveness against spot market rates."
    - name: "avg_floor_price_per_ton"
      expr: AVG(CAST(floor_price_per_ton AS DOUBLE))
      comment: "Average floor price per ton across contracts. Revenue protection KPI — floor prices guarantee minimum revenue per ton regardless of market conditions."
    - name: "avg_ceiling_price_per_ton"
      expr: AVG(CAST(ceiling_price_per_ton AS DOUBLE))
      comment: "Average ceiling price per ton across contracts. Revenue upside KPI — ceiling prices cap maximum revenue and are evaluated against market price trends."
    - name: "avg_max_contamination_pct"
      expr: AVG(CAST(max_contamination_pct AS DOUBLE))
      comment: "Average maximum contamination percentage allowed under buyer contracts. Quality threshold KPI — exceeding contract contamination limits triggers penalties or rejection, directly impacting revenue."
    - name: "avg_contamination_penalty_rate"
      expr: AVG(CAST(contamination_penalty_rate AS DOUBLE))
      comment: "Average contamination penalty rate across contracts. Financial risk KPI — higher penalty rates amplify the revenue impact of contamination events and drive quality management investment."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'active' THEN buyer_contract_id END)
      comment: "Number of currently active buyer contracts. Contract portfolio KPI used to assess market coverage and buyer diversification."
    - name: "total_contract_count"
      expr: COUNT(1)
      comment: "Total number of buyer contracts in the portfolio. Baseline metric used to assess contract portfolio size and normalize per-contract KPIs."
    - name: "avg_volume_tolerance_pct"
      expr: AVG(CAST(volume_tolerance_pct AS DOUBLE))
      comment: "Average volume tolerance percentage across contracts. Operational flexibility KPI — higher tolerance allows more variance in delivery volumes without triggering contract penalties."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_market_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commodity market price intelligence KPIs tracking price levels, price changes, and market conditions by commodity and region. Supports commodity trading decisions, contract pricing strategy, and revenue forecasting."
  source: "`waste_management_ecm`.`recycling`.`market_price`"
  dimensions:
    - name: "commodity_id"
      expr: commodity_id
      comment: "Commodity type for which the price is recorded — primary dimension for commodity-level price analysis."
    - name: "commodity_grade_id"
      expr: commodity_grade_id
      comment: "Commodity grade for which the price applies — used to analyze price differentials across quality grades."
    - name: "mrf_facility_id"
      expr: mrf_facility_id
      comment: "MRF facility associated with the price record — used for facility-level price realization analysis."
    - name: "price_region"
      expr: price_region
      comment: "Geographic region for which the price applies — used to analyze regional price variations and identify arbitrage opportunities."
    - name: "price_type"
      expr: price_type
      comment: "Type of price record (e.g., spot, contract, index) — used to segment market price intelligence by pricing mechanism."
    - name: "price_status"
      expr: price_status
      comment: "Status of the price record (e.g., active, expired, superseded) — used to filter current vs. historical price data."
    - name: "market_condition"
      expr: market_condition
      comment: "Prevailing market condition at time of price record (e.g., oversupply, tight, balanced) — used to contextualize price movements and forecast future pricing."
    - name: "price_effective_month"
      expr: DATE_TRUNC('month', price_effective_date)
      comment: "Month the price became effective — used for monthly commodity price trend analysis."
  measures:
    - name: "avg_price_per_ton_usd"
      expr: AVG(CAST(price_per_ton_usd AS DOUBLE))
      comment: "Average commodity market price per ton in USD. Primary pricing intelligence KPI used to benchmark contract prices, forecast revenue, and time commodity sales decisions."
    - name: "avg_price_floor_per_ton_usd"
      expr: AVG(CAST(price_floor_per_ton_usd AS DOUBLE))
      comment: "Average price floor per ton across market price records. Downside risk KPI — tracks the minimum price level the market is expected to support, informing contract floor price negotiations."
    - name: "avg_price_ceiling_per_ton_usd"
      expr: AVG(CAST(price_ceiling_per_ton_usd AS DOUBLE))
      comment: "Average price ceiling per ton across market price records. Upside potential KPI — tracks the maximum price level expected, informing contract ceiling price negotiations."
    - name: "avg_price_change_percentage"
      expr: AVG(CAST(price_change_percentage AS DOUBLE))
      comment: "Average price change percentage across market price records. Market volatility KPI — large price swings increase revenue uncertainty and may trigger contract renegotiation or hedging decisions."
    - name: "avg_contamination_adjustment_factor"
      expr: AVG(CAST(contamination_adjustment_factor AS DOUBLE))
      comment: "Average contamination adjustment factor applied to market prices. Quality discount KPI — quantifies the average price reduction applied for contamination, informing quality investment decisions."
    - name: "total_price_records"
      expr: COUNT(1)
      comment: "Total number of market price records. Baseline metric used to assess price data coverage and freshness across commodities and regions."
    - name: "distinct_commodities_priced"
      expr: COUNT(DISTINCT commodity_id)
      comment: "Number of distinct commodities with active market price records. Coverage KPI — ensures pricing intelligence is available for all commodities in the recycling portfolio."
$$;