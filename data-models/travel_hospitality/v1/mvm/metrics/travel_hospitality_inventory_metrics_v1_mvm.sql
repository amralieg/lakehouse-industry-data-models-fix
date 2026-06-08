-- Metric views for domain: inventory | Business: Travel Hospitality | Version: 1 | Generated on: 2026-05-08 05:56:59

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`inventory_availability_snapshot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Daily room availability health metrics derived from availability snapshots. Tracks occupancy rates, overbooking exposure, and room blockage patterns to support revenue management and capacity planning decisions."
  source: "`travel_hospitality_ecm`.`inventory`.`availability_snapshot`"
  dimensions:
    - name: "snapshot_date"
      expr: snapshot_date
      comment: "The calendar date of the availability snapshot, used for daily trending and period-over-period analysis."
    - name: "property_id"
      expr: property_id
      comment: "Foreign key to the property dimension, enabling property-level availability analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Foreign key to the room type dimension, enabling room-type-level availability segmentation."
    - name: "stop_sell_flag"
      expr: stop_sell_flag
      comment: "Indicates whether the stop-sell restriction is active on this snapshot date, used to identify constrained inventory."
    - name: "closed_to_arrival_flag"
      expr: closed_to_arrival_flag
      comment: "Indicates whether arrivals are restricted on this date, a key revenue management control dimension."
    - name: "closed_to_departure_flag"
      expr: closed_to_departure_flag
      comment: "Indicates whether departures are restricted on this date, relevant for minimum-stay enforcement analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of the inventory reconciliation process for this snapshot, used to filter or segment data quality."
    - name: "source_system"
      expr: source_system
      comment: "The originating system that produced the snapshot, enabling source-level data quality monitoring."
    - name: "lra_flag"
      expr: lra_flag
      comment: "Last Room Available flag indicating whether LRA rate plans are active, a key distribution control indicator."
  measures:
    - name: "avg_occupancy_rate"
      expr: AVG(CAST(occ_rate AS DOUBLE))
      comment: "Average occupancy rate across snapshots in the selected period. Core KPI for revenue management — directly drives pricing strategy and capacity decisions."
    - name: "total_snapshot_records"
      expr: COUNT(1)
      comment: "Total number of availability snapshot records. Used as a baseline denominator for rate calculations and data completeness checks."
    - name: "stop_sell_days"
      expr: COUNT(CASE WHEN stop_sell_flag = TRUE THEN 1 END)
      comment: "Number of snapshot records where stop-sell is active. High values indicate constrained inventory periods requiring revenue management review."
    - name: "closed_to_arrival_days"
      expr: COUNT(CASE WHEN closed_to_arrival_flag = TRUE THEN 1 END)
      comment: "Number of snapshot records with closed-to-arrival restrictions. Tracks how aggressively minimum-stay controls are applied."
    - name: "lra_active_days"
      expr: COUNT(CASE WHEN lra_flag = TRUE THEN 1 END)
      comment: "Number of snapshot records where Last Room Available is active. Indicates premium rate plan exposure and distribution strategy aggressiveness."
    - name: "max_occupancy_rate"
      expr: MAX(occ_rate)
      comment: "Peak occupancy rate observed within the selected period. Used to identify demand peaks for pricing and staffing decisions."
    - name: "min_occupancy_rate"
      expr: MIN(occ_rate)
      comment: "Lowest occupancy rate observed within the selected period. Used to identify demand troughs and evaluate promotional opportunity windows."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`inventory_allotment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Allotment performance and utilization metrics tracking contracted room blocks against sold and available quantities. Supports channel management, contract performance evaluation, and commission cost analysis."
  source: "`travel_hospitality_ecm`.`inventory`.`allotment`"
  dimensions:
    - name: "allotment_status"
      expr: allotment_status
      comment: "Current lifecycle status of the allotment (e.g., active, expired, suspended), used to segment performance by contract state."
    - name: "allotment_type"
      expr: allotment_type
      comment: "Classification of the allotment (e.g., wholesale, corporate, tour operator), enabling segment-level performance comparison."
    - name: "start_date"
      expr: start_date
      comment: "Allotment validity start date, used for period-based performance trending."
    - name: "end_date"
      expr: end_date
      comment: "Allotment validity end date, used to identify expiring contracts requiring renegotiation."
    - name: "property_id"
      expr: property_id
      comment: "Foreign key to the property dimension, enabling property-level allotment analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Foreign key to the room type dimension, enabling room-type-level allotment utilization analysis."
    - name: "channel_id"
      expr: channel_id
      comment: "Foreign key to the channel dimension, enabling channel-level allotment performance comparison."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Foreign key to the market segment dimension, enabling segment-level allotment analysis."
    - name: "freesale_enabled"
      expr: freesale_enabled
      comment: "Indicates whether freesale is enabled for this allotment, a key distribution flexibility indicator."
    - name: "auto_release_enabled"
      expr: auto_release_enabled
      comment: "Indicates whether automatic release of unsold rooms is enabled, relevant for inventory recovery analysis."
    - name: "lra_enabled"
      expr: lra_enabled
      comment: "Indicates whether Last Room Available is enabled for this allotment, a premium distribution control flag."
  measures:
    - name: "total_allotments"
      expr: COUNT(1)
      comment: "Total number of allotment contracts in the selected period. Baseline measure for allotment portfolio size."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_percent AS DOUBLE))
      comment: "Average commission rate across allotment contracts. Directly impacts distribution cost and net revenue — a key contract negotiation KPI."
    - name: "max_commission_rate_pct"
      expr: MAX(commission_rate_percent)
      comment: "Highest commission rate in the allotment portfolio. Flags outlier contracts with excessive distribution cost exposure."
    - name: "avg_performance_threshold_pct"
      expr: AVG(CAST(performance_threshold_percent AS DOUBLE))
      comment: "Average contracted performance threshold percentage. Indicates the minimum pickup commitment level across allotment contracts."
    - name: "total_commission_cost"
      expr: SUM(CAST(commission_rate_percent AS DOUBLE))
      comment: "Sum of commission rate percentages across allotments. Used as a relative proxy for total commission cost exposure in the portfolio."
    - name: "freesale_allotment_count"
      expr: COUNT(CASE WHEN freesale_enabled = TRUE THEN 1 END)
      comment: "Number of allotments with freesale enabled. High freesale exposure increases overbooking risk and requires close monitoring."
    - name: "active_allotment_count"
      expr: COUNT(CASE WHEN allotment_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active allotment contracts. Core portfolio health metric for channel management teams."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`inventory_block_pickup`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group block pickup performance metrics tracking contracted versus picked-up room nights, pace variance, and displacement cost. Critical for group sales evaluation, revenue management, and attrition risk monitoring."
  source: "`travel_hospitality_ecm`.`inventory`.`block_pickup`"
  dimensions:
    - name: "pickup_date"
      expr: pickup_date
      comment: "Date on which pickup activity was recorded, used for pace trending and pickup velocity analysis."
    - name: "stay_date"
      expr: stay_date
      comment: "The actual stay date for the group block, used for demand calendar analysis."
    - name: "cutoff_date"
      expr: cutoff_date
      comment: "Block cutoff date after which unreleased rooms return to general inventory, a critical group management milestone."
    - name: "block_status"
      expr: block_status
      comment: "Current status of the group block (e.g., tentative, definite, cancelled), used to segment pickup performance by contract stage."
    - name: "property_id"
      expr: property_id
      comment: "Foreign key to the property dimension, enabling property-level group block analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Foreign key to the room type dimension, enabling room-type-level pickup analysis."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Foreign key to the market segment dimension, enabling segment-level group performance comparison."
    - name: "group_code"
      expr: group_code
      comment: "Unique group identifier code, enabling group-level pickup tracking and performance attribution."
    - name: "is_lra_eligible"
      expr: is_lra_eligible
      comment: "Indicates whether the block is eligible for Last Room Available rate plans, a distribution strategy dimension."
  measures:
    - name: "total_pickup_revenue"
      expr: SUM(CAST(pickup_revenue AS DOUBLE))
      comment: "Total revenue generated from group block pickups. Primary financial KPI for group sales performance evaluation."
    - name: "avg_pickup_rate"
      expr: AVG(CAST(pickup_rate AS DOUBLE))
      comment: "Average pickup rate per block record. Measures the velocity of room night absorption relative to contracted block size."
    - name: "avg_pickup_percentage"
      expr: AVG(CAST(pickup_percentage AS DOUBLE))
      comment: "Average percentage of contracted rooms picked up. Core group performance KPI — low values signal attrition risk and potential penalty exposure."
    - name: "total_displacement_cost"
      expr: SUM(CAST(displacement_cost AS DOUBLE))
      comment: "Total displacement cost incurred by holding group blocks. Measures the opportunity cost of group business versus transient demand — critical for group evaluation decisions."
    - name: "avg_displacement_cost"
      expr: AVG(CAST(displacement_cost AS DOUBLE))
      comment: "Average displacement cost per block pickup record. Used to benchmark group profitability against transient alternatives."
    - name: "avg_wash_factor"
      expr: AVG(CAST(wash_factor AS DOUBLE))
      comment: "Average wash factor applied to group blocks. Indicates the expected attrition rate used in revenue forecasting — high wash factors signal unreliable group demand."
    - name: "total_block_pickup_records"
      expr: COUNT(1)
      comment: "Total number of block pickup records. Baseline measure for group activity volume."
    - name: "max_pickup_revenue"
      expr: MAX(pickup_revenue)
      comment: "Highest single pickup revenue value. Identifies top-performing group blocks for best-practice benchmarking."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`inventory_out_of_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Out-of-order room metrics tracking financial impact, duration, and operational cost of rooms removed from sellable inventory. Supports asset management, maintenance prioritization, and lost revenue quantification."
  source: "`travel_hospitality_ecm`.`inventory`.`out_of_order`"
  dimensions:
    - name: "start_date"
      expr: start_date
      comment: "Date the room was taken out of order, used for trending OOO incidents over time."
    - name: "expected_return_date"
      expr: expected_return_date
      comment: "Expected date the room returns to sellable inventory, used for forward-looking capacity planning."
    - name: "actual_return_date"
      expr: actual_return_date
      comment: "Actual date the room returned to sellable inventory, used to measure maintenance execution accuracy."
    - name: "property_id"
      expr: property_id
      comment: "Foreign key to the property dimension, enabling property-level OOO impact analysis."
    - name: "ooo_status"
      expr: ooo_status
      comment: "Current status of the out-of-order record (e.g., open, closed, in-progress), used to segment active versus resolved incidents."
    - name: "ooo_reason"
      expr: ooo_reason
      comment: "Reason for the out-of-order designation, enabling root-cause analysis and maintenance category trending."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the OOO incident, used to evaluate maintenance resource allocation effectiveness."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for resolving the OOO incident, enabling departmental accountability tracking."
    - name: "guest_impacted_flag"
      expr: guest_impacted_flag
      comment: "Indicates whether a guest was impacted by the OOO incident, a key guest satisfaction risk indicator."
    - name: "safety_concern_flag"
      expr: safety_concern_flag
      comment: "Indicates whether the OOO incident involves a safety concern, used for compliance and risk management reporting."
    - name: "ada_compliance_flag"
      expr: ada_compliance_flag
      comment: "Indicates whether the OOO room is ADA-accessible, relevant for compliance risk assessment."
  measures:
    - name: "total_lost_revenue_estimate"
      expr: SUM(CAST(lost_revenue_estimate AS DOUBLE))
      comment: "Total estimated revenue lost due to rooms being out of order. Primary financial impact KPI for asset management and maintenance investment decisions."
    - name: "avg_lost_revenue_per_incident"
      expr: AVG(CAST(lost_revenue_estimate AS DOUBLE))
      comment: "Average estimated revenue loss per OOO incident. Used to prioritize high-impact maintenance cases and justify capital expenditure."
    - name: "total_actual_maintenance_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred for out-of-order room repairs. Core maintenance budget KPI for property operations and asset management."
    - name: "avg_actual_maintenance_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual maintenance cost per OOO incident. Benchmarks repair cost efficiency across properties and incident types."
    - name: "total_estimated_maintenance_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated maintenance cost across OOO incidents. Used for budget forecasting and maintenance planning."
    - name: "avg_occ_impact"
      expr: AVG(CAST(impact_on_occ AS DOUBLE))
      comment: "Average occupancy impact per OOO incident. Quantifies how maintenance issues translate to occupancy rate degradation."
    - name: "avg_revpar_impact"
      expr: AVG(CAST(impact_on_revpar AS DOUBLE))
      comment: "Average RevPAR impact per OOO incident. Directly links asset condition to the most critical hotel revenue KPI."
    - name: "total_ooo_incidents"
      expr: COUNT(1)
      comment: "Total number of out-of-order incidents. Baseline volume metric for maintenance workload and asset reliability benchmarking."
    - name: "guest_impacted_incidents"
      expr: COUNT(CASE WHEN guest_impacted_flag = TRUE THEN 1 END)
      comment: "Number of OOO incidents that directly impacted guests. High values signal guest satisfaction risk and potential compensation liability."
    - name: "safety_concern_incidents"
      expr: COUNT(CASE WHEN safety_concern_flag = TRUE THEN 1 END)
      comment: "Number of OOO incidents flagged as safety concerns. Critical compliance and liability KPI requiring immediate executive visibility."
    - name: "cost_variance"
      expr: SUM(actual_cost - estimated_cost)
      comment: "Total variance between actual and estimated maintenance costs. Measures maintenance cost estimation accuracy and budget discipline."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`inventory_room_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group room block financial and operational metrics tracking contracted room nights, pickup performance, attrition exposure, and deposit management. Supports group sales strategy, revenue forecasting, and contract risk management."
  source: "`travel_hospitality_ecm`.`inventory`.`room_block`"
  dimensions:
    - name: "start_date"
      expr: start_date
      comment: "Group block arrival start date, used for demand calendar and group pace analysis."
    - name: "end_date"
      expr: end_date
      comment: "Group block departure end date, used for length-of-stay and group duration analysis."
    - name: "cutoff_date"
      expr: cutoff_date
      comment: "Cutoff date for the room block, after which unreleased rooms return to general inventory."
    - name: "block_status"
      expr: block_status
      comment: "Current lifecycle status of the room block (e.g., tentative, definite, cancelled), used to segment financial exposure by contract stage."
    - name: "block_type"
      expr: block_type
      comment: "Classification of the room block (e.g., group, tour, corporate), enabling segment-level performance comparison."
    - name: "property_id"
      expr: property_id
      comment: "Foreign key to the property dimension, enabling property-level group block analysis."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Foreign key to the market segment dimension, enabling segment-level group revenue analysis."
    - name: "lra_flag"
      expr: lra_flag
      comment: "Last Room Available flag for the block, indicating premium rate plan eligibility."
    - name: "deposit_required_flag"
      expr: deposit_required_flag
      comment: "Indicates whether a deposit is required for this block, used to assess financial commitment and cancellation risk."
    - name: "overbooking_allowed_flag"
      expr: overbooking_allowed_flag
      comment: "Indicates whether overbooking is permitted for this block, a key inventory risk management dimension."
  measures:
    - name: "total_attrition_penalty_amount"
      expr: SUM(CAST(attrition_penalty_amount AS DOUBLE))
      comment: "Total attrition penalty amounts across room blocks. Measures financial recovery from underperforming group contracts — a key group revenue protection KPI."
    - name: "avg_attrition_percentage"
      expr: AVG(CAST(attrition_percentage AS DOUBLE))
      comment: "Average attrition percentage across room blocks. Indicates the typical shortfall between contracted and picked-up room nights — drives group pricing and contract terms strategy."
    - name: "avg_pickup_percentage"
      expr: AVG(CAST(pickup_percentage AS DOUBLE))
      comment: "Average pickup percentage across room blocks. Core group performance KPI measuring how effectively contracted rooms are absorbed."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts collected across room blocks. Measures financial commitment secured from group clients and cash flow from group business."
    - name: "avg_commission_percentage"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission percentage across room blocks. Tracks distribution cost for group business — directly impacts group net revenue."
    - name: "total_room_blocks"
      expr: COUNT(1)
      comment: "Total number of room block records. Baseline measure for group business volume and portfolio size."
    - name: "definite_block_count"
      expr: COUNT(CASE WHEN block_status = 'DEFINITE' THEN 1 END)
      comment: "Number of definite (confirmed) room blocks. Measures committed group demand for revenue forecasting and staffing planning."
    - name: "cancelled_block_count"
      expr: COUNT(CASE WHEN block_status = 'CANCELLED' THEN 1 END)
      comment: "Number of cancelled room blocks. Tracks group cancellation volume — high values signal market softness or contract terms issues."
    - name: "max_attrition_penalty_amount"
      expr: MAX(attrition_penalty_amount)
      comment: "Highest single attrition penalty amount. Identifies the most financially significant underperforming group contracts."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`inventory_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory control restriction and yield management metrics tracking hurdle rates, overbooking limits, channel allocations, and sell restrictions. Supports revenue management strategy evaluation and rate optimization decisions."
  source: "`travel_hospitality_ecm`.`inventory`.`control`"
  dimensions:
    - name: "stay_date"
      expr: stay_date
      comment: "The stay date to which the inventory control applies, used for demand calendar and restriction trending."
    - name: "property_id"
      expr: property_id
      comment: "Foreign key to the property dimension, enabling property-level control analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Foreign key to the room type dimension, enabling room-type-level restriction analysis."
    - name: "channel_id"
      expr: channel_id
      comment: "Foreign key to the channel dimension, enabling channel-level allocation and restriction analysis."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Foreign key to the market segment dimension, enabling segment-level control strategy analysis."
    - name: "control_status"
      expr: control_status
      comment: "Current status of the inventory control record (e.g., active, expired, overridden), used to filter active restrictions."
    - name: "control_source"
      expr: control_source
      comment: "Source of the control record (e.g., automated RMS, manual override), used to evaluate automation versus manual intervention rates."
    - name: "stop_sell_flag"
      expr: stop_sell_flag
      comment: "Indicates whether stop-sell is active for this control record, a critical revenue management restriction indicator."
    - name: "cta_flag"
      expr: cta_flag
      comment: "Closed-to-arrival flag, indicating arrival restrictions are in effect for this stay date."
    - name: "ctd_flag"
      expr: ctd_flag
      comment: "Closed-to-departure flag, indicating departure restrictions are in effect for this stay date."
    - name: "lra_flag"
      expr: lra_flag
      comment: "Last Room Available flag, indicating premium rate plan availability for this control record."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which hurdle rates and competitive ADR values are denominated."
  measures:
    - name: "avg_hurdle_rate"
      expr: AVG(CAST(hurdle_rate AS DOUBLE))
      comment: "Average hurdle rate across inventory control records. The hurdle rate is the minimum acceptable rate for accepting a booking — a core revenue management yield optimization KPI."
    - name: "max_hurdle_rate"
      expr: MAX(hurdle_rate)
      comment: "Maximum hurdle rate applied. Identifies peak demand periods where the most aggressive yield management is in effect."
    - name: "avg_overbooking_limit_pct"
      expr: AVG(CAST(overbooking_limit_pct AS DOUBLE))
      comment: "Average overbooking limit percentage across control records. Measures the aggressiveness of overbooking strategy — directly impacts walk risk and guest satisfaction."
    - name: "avg_channel_allocation_pct"
      expr: AVG(CAST(channel_allocation_pct AS DOUBLE))
      comment: "Average channel allocation percentage across control records. Tracks how inventory is distributed across channels — key for channel mix optimization."
    - name: "avg_competitive_set_adr"
      expr: AVG(CAST(competitive_set_adr AS DOUBLE))
      comment: "Average competitive set ADR used in inventory control decisions. Benchmarks pricing strategy against the competitive set — a critical revenue management input."
    - name: "avg_rgi_target"
      expr: AVG(CAST(rgi_target AS DOUBLE))
      comment: "Average Revenue Generation Index target set in inventory controls. Measures the ambition level of revenue management strategy relative to the competitive set."
    - name: "stop_sell_control_count"
      expr: COUNT(CASE WHEN stop_sell_flag = TRUE THEN 1 END)
      comment: "Number of control records with stop-sell active. Quantifies how frequently inventory is fully closed — high values may indicate missed revenue opportunities."
    - name: "cta_control_count"
      expr: COUNT(CASE WHEN cta_flag = TRUE THEN 1 END)
      comment: "Number of control records with closed-to-arrival active. Tracks minimum-stay enforcement frequency across the demand calendar."
    - name: "total_control_records"
      expr: COUNT(1)
      comment: "Total number of inventory control records. Baseline measure for control activity volume and RMS automation coverage."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`inventory_room_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room type portfolio metrics tracking inventory composition, ADA compliance, suite mix, and sellable room type distribution. Supports product strategy, accessibility compliance, and inventory mix optimization decisions."
  source: "`travel_hospitality_ecm`.`inventory`.`room_type`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Foreign key to the property dimension, enabling property-level room type portfolio analysis."
    - name: "room_class"
      expr: room_class
      comment: "Classification of the room (e.g., standard, deluxe, suite), used for product tier analysis and revenue mix evaluation."
    - name: "rate_category"
      expr: rate_category
      comment: "Rate category associated with the room type, used for pricing tier and yield analysis."
    - name: "bed_type"
      expr: bed_type
      comment: "Bed configuration of the room type (e.g., king, double), used for demand pattern and product mix analysis."
    - name: "view_category"
      expr: view_category
      comment: "View category of the room type (e.g., ocean view, city view), used for premium product mix and upsell analysis."
    - name: "active_status"
      expr: active_status
      comment: "Current active status of the room type, used to filter sellable inventory."
    - name: "is_suite"
      expr: is_suite
      comment: "Indicates whether the room type is a suite, enabling suite mix and premium inventory analysis."
    - name: "is_ada_compliant"
      expr: is_ada_compliant
      comment: "Indicates ADA compliance of the room type, critical for accessibility compliance reporting and risk management."
    - name: "sellable_flag"
      expr: sellable_flag
      comment: "Indicates whether the room type is currently sellable, used to measure active inventory portfolio size."
    - name: "lra_eligible"
      expr: lra_eligible
      comment: "Indicates whether the room type is eligible for Last Room Available rate plans, a distribution strategy dimension."
    - name: "overbooking_allowed"
      expr: overbooking_allowed
      comment: "Indicates whether overbooking is permitted for this room type, a key inventory risk management dimension."
    - name: "smoking_policy"
      expr: smoking_policy
      comment: "Smoking policy for the room type, used for product compliance and guest preference analysis."
  measures:
    - name: "total_room_types"
      expr: COUNT(1)
      comment: "Total number of room type records in the portfolio. Baseline measure for inventory product breadth."
    - name: "sellable_room_types"
      expr: COUNT(CASE WHEN sellable_flag = TRUE THEN 1 END)
      comment: "Number of currently sellable room types. Measures active inventory product availability — a key capacity and revenue potential indicator."
    - name: "suite_room_types"
      expr: COUNT(CASE WHEN is_suite = TRUE THEN 1 END)
      comment: "Number of suite room types in the portfolio. Tracks premium inventory mix — suites drive disproportionate ADR and revenue contribution."
    - name: "ada_compliant_room_types"
      expr: COUNT(CASE WHEN is_ada_compliant = TRUE THEN 1 END)
      comment: "Number of ADA-compliant room types. Measures accessibility compliance coverage — regulatory and reputational risk KPI."
    - name: "avg_square_footage"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average square footage across room types. Measures product quality and space standard — directly correlates with rate potential and guest satisfaction."
    - name: "max_square_footage"
      expr: MAX(square_footage)
      comment: "Maximum square footage in the room type portfolio. Identifies the premium product ceiling for upsell and luxury positioning strategy."
    - name: "lra_eligible_room_types"
      expr: COUNT(CASE WHEN lra_eligible = TRUE THEN 1 END)
      comment: "Number of room types eligible for Last Room Available rate plans. Measures premium distribution exposure and rate plan strategy breadth."
$$;