-- Metric views for domain: inventory | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-22 18:44:46

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_availability_snapshot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Daily inventory availability KPIs by property and room type — core operational dashboard for revenue managers tracking sellable supply, overbooking exposure, and occupancy rate."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot`"
  dimensions:
    - name: "snapshot_date"
      expr: snapshot_date
      comment: "Business date of the availability snapshot — primary time dimension for trend analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier — enables property-level inventory performance comparison."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type identifier — allows drill-down into availability by room category."
    - name: "stop_sell_flag"
      expr: stop_sell_flag
      comment: "Indicates whether the room type is closed to new bookings — critical for channel management."
    - name: "closed_to_arrival_flag"
      expr: closed_to_arrival_flag
      comment: "Indicates CTA restriction is active — used to assess restriction impact on pickup."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of inventory reconciliation — flags discrepancies requiring resolution."
  measures:
    - name: "avg_occupancy_rate"
      expr: AVG(CAST(occ_rate AS DOUBLE))
      comment: "Average occupancy rate across snapshots — primary KPI for measuring how effectively available rooms are being sold. Drives pricing and channel strategy decisions."
    - name: "total_rooms_sold"
      expr: SUM(CAST(rooms_sold AS DOUBLE))
      comment: "Total room nights sold across the snapshot period — baseline volume metric for revenue and demand analysis. NOTE: rooms_sold is stored as STRING per schema; CAST applied for aggregation."
    - name: "total_rooms_out_of_order"
      expr: SUM(CAST(rooms_out_of_order AS DOUBLE))
      comment: "Total room nights removed from sellable inventory due to OOO status — directly impacts revenue capacity and maintenance cost tracking."
    - name: "total_rooms_overbooked"
      expr: SUM(CAST(rooms_overbooked AS DOUBLE))
      comment: "Total room nights in overbooking position — critical risk metric; high values signal walk exposure and guest satisfaction risk."
    - name: "total_net_available_rooms"
      expr: SUM(CAST(net_available_rooms AS DOUBLE))
      comment: "Total net sellable room nights after all blocks, OOO, and restrictions — the true sellable capacity figure used in revenue strategy."
    - name: "total_rooms_blocked_group"
      expr: SUM(CAST(rooms_blocked_group AS DOUBLE))
      comment: "Total room nights held under group blocks — measures group business absorption of inventory, informing transient vs. group mix strategy."
    - name: "total_rooms_blocked_allotment"
      expr: SUM(CAST(rooms_blocked_allotment AS DOUBLE))
      comment: "Total room nights held under allotment contracts — measures wholesale/channel partner inventory commitment."
    - name: "snapshot_count"
      expr: COUNT(1)
      comment: "Number of availability snapshots — baseline count for data completeness and coverage monitoring."
    - name: "stop_sell_days"
      expr: SUM(CASE WHEN stop_sell_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of snapshot days where stop-sell was active — measures restriction frequency; high counts indicate demand-driven closures or inventory management issues."
    - name: "cta_days"
      expr: SUM(CASE WHEN closed_to_arrival_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of snapshot days with closed-to-arrival restriction active — tracks restriction aggressiveness and potential revenue impact from blocked arrivals."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group room block performance metrics — tracks contracted vs. picked-up room nights, attrition risk, and block financial exposure for group sales and revenue management."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room_block`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier — enables property-level group block performance comparison."
    - name: "block_status"
      expr: block_status
      comment: "Current status of the room block (tentative, definite, cancelled, etc.) — primary filter for active vs. historical block analysis."
    - name: "block_type"
      expr: block_type
      comment: "Type of group block (corporate, leisure, tour, etc.) — enables segment-level group performance analysis."
    - name: "cutoff_date"
      expr: cutoff_date
      comment: "Block cutoff date — critical for identifying blocks approaching release deadlines."
    - name: "start_date"
      expr: start_date
      comment: "Block arrival date — time dimension for group business calendar analysis."
    - name: "booking_source"
      expr: booking_source
      comment: "Source of the group booking — enables channel attribution for group business."
    - name: "lra_flag"
      expr: lra_flag
      comment: "Last Room Available flag — indicates whether LRA rate applies to this block."
  measures:
    - name: "total_contracted_room_nights"
      expr: SUM(CAST(contracted_room_nights AS DOUBLE))
      comment: "Total room nights contracted across all group blocks — primary volume metric for group business pipeline and capacity planning."
    - name: "total_picked_up_room_nights"
      expr: SUM(CAST(picked_up_room_nights AS DOUBLE))
      comment: "Total room nights actually booked against group blocks — measures group block conversion and demand realization."
    - name: "total_available_room_nights"
      expr: SUM(CAST(available_room_nights AS DOUBLE))
      comment: "Total room nights remaining available within group blocks — indicates unreleased group inventory exposure."
    - name: "avg_pickup_percentage"
      expr: AVG(CAST(pickup_percentage AS DOUBLE))
      comment: "Average pickup rate across group blocks — key performance indicator for group block conversion; low values signal attrition risk."
    - name: "total_attrition_penalty_amount"
      expr: SUM(CAST(attrition_penalty_amount AS DOUBLE))
      comment: "Total attrition penalty charges across blocks — measures financial recovery from underperforming group blocks; directly impacts group revenue."
    - name: "avg_attrition_percentage"
      expr: AVG(CAST(attrition_percentage AS DOUBLE))
      comment: "Average attrition rate across group blocks — indicates how frequently groups underperform contracted commitments; drives contract negotiation strategy."
    - name: "total_negotiated_rate_amount"
      expr: SUM(CAST(negotiated_rate_amount AS DOUBLE))
      comment: "Total negotiated rate value across group blocks — measures group rate revenue potential and discount depth."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposits collected on group blocks — measures cash flow security from group business commitments."
    - name: "avg_commission_percentage"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission rate on group blocks — tracks distribution cost for group channel; informs net revenue calculations."
    - name: "active_block_count"
      expr: COUNT(CASE WHEN block_status NOT IN ('cancelled', 'released') THEN 1 END)
      comment: "Number of active (non-cancelled, non-released) group blocks — baseline count for group pipeline management."
    - name: "cancelled_block_count"
      expr: COUNT(CASE WHEN block_status = 'cancelled' THEN 1 END)
      comment: "Number of cancelled group blocks — tracks group cancellation frequency; high values indicate market softness or sales execution issues."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_block_pickup`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group block pickup pace and performance metrics — tracks daily pickup velocity, wash exposure, and displacement cost for revenue management and group sales decisions."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`block_pickup`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier — enables property-level pickup pace comparison."
    - name: "pickup_date"
      expr: pickup_date
      comment: "Date on which pickup was recorded — primary time dimension for pace analysis."
    - name: "stay_date"
      expr: stay_date
      comment: "Actual stay date of the group — enables forward-looking pickup pace by arrival date."
    - name: "block_status"
      expr: block_status
      comment: "Current status of the associated room block — filters active vs. historical pickup records."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment of the group block — enables segment-level pickup performance analysis."
    - name: "is_lra_eligible"
      expr: is_lra_eligible
      comment: "Whether the block qualifies for Last Room Available rate — affects rate strategy for pickup."
  measures:
    - name: "total_rooms_picked_up"
      expr: SUM(CAST(rooms_picked_up AS DOUBLE))
      comment: "Total room nights picked up across all group blocks — primary volume metric for group demand realization."
    - name: "total_contracted_rooms"
      expr: SUM(CAST(contracted_rooms AS DOUBLE))
      comment: "Total contracted room nights across blocks — denominator for pickup rate calculations and attrition exposure."
    - name: "total_released_rooms"
      expr: SUM(CAST(released_rooms AS DOUBLE))
      comment: "Total room nights released back to general inventory — measures inventory recovery from group blocks for transient resale."
    - name: "total_remaining_block_rooms"
      expr: SUM(CAST(remaining_block_rooms AS DOUBLE))
      comment: "Total room nights still held in group blocks — measures current group inventory exposure and release opportunity."
    - name: "avg_pickup_rate"
      expr: AVG(CAST(pickup_rate AS DOUBLE))
      comment: "Average daily pickup rate across blocks — tracks pickup velocity; declining rates signal need for proactive release or sales intervention."
    - name: "avg_pickup_percentage"
      expr: AVG(CAST(pickup_percentage AS DOUBLE))
      comment: "Average pickup percentage against contracted rooms — key group performance KPI used in group evaluation and future contracting decisions."
    - name: "total_pickup_revenue"
      expr: SUM(CAST(pickup_revenue AS DOUBLE))
      comment: "Total revenue generated from group block pickups — direct revenue contribution metric for group business segment."
    - name: "total_displacement_cost"
      expr: SUM(CAST(displacement_cost AS DOUBLE))
      comment: "Total estimated displacement cost from group blocks — measures opportunity cost of holding inventory for groups vs. transient; critical for group evaluation ROI."
    - name: "avg_wash_factor"
      expr: AVG(CAST(wash_factor AS DOUBLE))
      comment: "Average wash factor applied to group blocks — measures expected attrition rate used in forecasting; informs how aggressively to overbook or release."
    - name: "total_net_pickup"
      expr: SUM(CAST(net_pickup AS DOUBLE))
      comment: "Total net pickup (gross pickup minus cancellations/adjustments) — most accurate measure of realized group demand."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_allotment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel allotment performance metrics — tracks allocated vs. sold inventory, commission exposure, and allotment efficiency for wholesale and channel partner management."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`allotment`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier — enables property-level allotment performance comparison."
    - name: "channel_id"
      expr: channel_id
      comment: "Channel identifier — primary dimension for channel-level allotment performance analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type identifier — enables allotment analysis by room category."
    - name: "allotment_status"
      expr: allotment_status
      comment: "Current status of the allotment (active, suspended, expired) — filters operational vs. historical allotments."
    - name: "allotment_type"
      expr: allotment_type
      comment: "Type of allotment (freesale, fixed, etc.) — enables analysis by allotment structure."
    - name: "start_date"
      expr: start_date
      comment: "Allotment start date — time dimension for allotment period analysis."
    - name: "end_date"
      expr: end_date
      comment: "Allotment end date — used with start_date to assess allotment duration and coverage."
    - name: "freesale_enabled"
      expr: freesale_enabled
      comment: "Whether freesale is enabled for this allotment — distinguishes fixed vs. open allotment structures."
  measures:
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total room nights allocated to channel partners — measures total inventory commitment to wholesale/allotment channels."
    - name: "total_sold_quantity"
      expr: SUM(CAST(sold_quantity AS DOUBLE))
      comment: "Total room nights sold through allotments — primary revenue volume metric for allotment channel performance."
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total room nights remaining available in allotments — measures unrealized allotment inventory and release opportunity."
    - name: "avg_commission_rate_percent"
      expr: AVG(CAST(commission_rate_percent AS DOUBLE))
      comment: "Average commission rate across allotments — tracks distribution cost for allotment channel; informs net revenue and channel profitability analysis."
    - name: "avg_performance_threshold_percent"
      expr: AVG(CAST(performance_threshold_percent AS DOUBLE))
      comment: "Average performance threshold set for allotments — benchmarks expected pickup rate; comparison against actual sold quantity reveals underperforming allotments."
    - name: "active_allotment_count"
      expr: COUNT(CASE WHEN allotment_status = 'active' THEN 1 END)
      comment: "Number of currently active allotments — baseline count for channel inventory commitment monitoring."
    - name: "suspended_allotment_count"
      expr: COUNT(CASE WHEN allotment_status = 'suspended' THEN 1 END)
      comment: "Number of suspended allotments — tracks allotments paused due to performance issues or channel disputes."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_out_of_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Out-of-order room metrics — tracks revenue impact, cost, and duration of rooms removed from sellable inventory for maintenance or safety reasons."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`out_of_order`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier — enables property-level OOO impact comparison."
    - name: "ooo_status"
      expr: ooo_status
      comment: "Current status of the OOO record (open, closed, etc.) — filters active vs. resolved OOO incidents."
    - name: "ooo_reason"
      expr: ooo_reason
      comment: "Reason for OOO designation — enables root cause analysis of inventory loss."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the OOO resolution — used to assess urgency and resource allocation."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for resolving the OOO — enables departmental accountability tracking."
    - name: "start_date"
      expr: start_date
      comment: "Date the room was taken out of order — time dimension for OOO trend analysis."
    - name: "safety_concern_flag"
      expr: safety_concern_flag
      comment: "Indicates whether the OOO is safety-related — critical flag for compliance and risk reporting."
    - name: "ada_compliance_flag"
      expr: ada_compliance_flag
      comment: "Indicates ADA compliance relevance of the OOO — tracks accessibility-related inventory removals."
  measures:
    - name: "total_lost_revenue_estimate"
      expr: SUM(CAST(lost_revenue_estimate AS DOUBLE))
      comment: "Total estimated revenue lost due to OOO rooms — primary financial impact metric for maintenance and capital planning decisions."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred to resolve OOO incidents — measures maintenance and repair spend; informs CapEx vs. OpEx decisions."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost for OOO resolution — used for budget forecasting and variance analysis against actual cost."
    - name: "avg_impact_on_occ"
      expr: AVG(CAST(impact_on_occ AS DOUBLE))
      comment: "Average occupancy impact per OOO incident — measures how much each OOO event reduces sellable occupancy."
    - name: "avg_impact_on_revpar"
      expr: AVG(CAST(impact_on_revpar AS DOUBLE))
      comment: "Average RevPAR impact per OOO incident — directly links maintenance issues to revenue performance degradation."
    - name: "ooo_incident_count"
      expr: COUNT(1)
      comment: "Total number of OOO incidents — baseline count for maintenance frequency monitoring and trend analysis."
    - name: "open_ooo_count"
      expr: COUNT(CASE WHEN ooo_status = 'open' THEN 1 END)
      comment: "Number of currently open OOO incidents — operational metric for real-time inventory availability management."
    - name: "safety_related_ooo_count"
      expr: COUNT(CASE WHEN safety_concern_flag = TRUE THEN 1 END)
      comment: "Number of OOO incidents flagged as safety concerns — critical compliance and risk metric requiring immediate executive attention."
    - name: "cost_variance"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(estimated_cost AS DOUBLE))
      comment: "Total variance between actual and estimated OOO resolution costs — measures budget accuracy and cost control effectiveness for maintenance operations."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory control and restriction metrics — tracks sell limits, overbooking exposure, hurdle rates, and restriction activity for revenue management decision-making."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`control`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier — enables property-level control strategy comparison."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type identifier — enables control analysis by room category."
    - name: "stay_date"
      expr: stay_date
      comment: "Stay date the control applies to — primary time dimension for restriction calendar analysis."
    - name: "control_status"
      expr: control_status
      comment: "Current status of the inventory control record — filters active vs. expired controls."
    - name: "stop_sell_flag"
      expr: stop_sell_flag
      comment: "Indicates stop-sell is active — critical restriction flag for channel management."
    - name: "cta_flag"
      expr: cta_flag
      comment: "Closed-to-arrival flag — tracks arrival restriction activity by date."
    - name: "ctd_flag"
      expr: ctd_flag
      comment: "Closed-to-departure flag — tracks departure restriction activity by date."
    - name: "lra_flag"
      expr: lra_flag
      comment: "Last Room Available flag — indicates LRA rate obligation is active for this control."
    - name: "channel_id"
      expr: channel_id
      comment: "Channel identifier — enables channel-specific control analysis."
  measures:
    - name: "avg_hurdle_rate"
      expr: AVG(CAST(hurdle_rate AS DOUBLE))
      comment: "Average hurdle rate across inventory controls — measures the minimum acceptable rate threshold set by revenue management; tracks pricing floor strategy."
    - name: "avg_forecast_occ_pct"
      expr: AVG(CAST(forecast_occ_pct AS DOUBLE))
      comment: "Average forecasted occupancy percentage at time of control — measures demand forecast accuracy and informs restriction aggressiveness."
    - name: "avg_overbooking_limit_pct"
      expr: AVG(CAST(overbooking_limit_pct AS DOUBLE))
      comment: "Average overbooking limit percentage across controls — tracks overbooking strategy aggressiveness; high values indicate high walk risk tolerance."
    - name: "avg_channel_allocation_pct"
      expr: AVG(CAST(channel_allocation_pct AS DOUBLE))
      comment: "Average channel allocation percentage — measures how inventory is distributed across channels; informs channel mix optimization."
    - name: "avg_forecast_adr"
      expr: AVG(CAST(forecast_adr AS DOUBLE))
      comment: "Average forecasted ADR at time of control — tracks rate expectation vs. actual performance for forecast accuracy assessment."
    - name: "avg_competitive_set_adr"
      expr: AVG(CAST(competitive_set_adr AS DOUBLE))
      comment: "Average competitive set ADR at time of control — measures rate positioning relative to comp set; drives pricing strategy decisions."
    - name: "avg_rgi_target"
      expr: AVG(CAST(rgi_target AS DOUBLE))
      comment: "Average Revenue Generation Index target — measures competitive revenue performance goal; tracks whether property is targeting market share gain or maintenance."
    - name: "stop_sell_control_count"
      expr: COUNT(CASE WHEN stop_sell_flag = TRUE THEN 1 END)
      comment: "Number of controls with stop-sell active — measures restriction frequency; high counts indicate aggressive demand management or inventory scarcity."
    - name: "total_control_records"
      expr: COUNT(1)
      comment: "Total inventory control records — baseline count for control activity monitoring and audit completeness."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room type portfolio metrics — tracks physical inventory composition, accessibility compliance, and sellable capacity by room category for asset and revenue management."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room_type`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier — enables property-level room type portfolio comparison."
    - name: "room_class"
      expr: room_class
      comment: "Room class (standard, deluxe, suite, etc.) — primary dimension for tier-based inventory analysis."
    - name: "rate_category"
      expr: rate_category
      comment: "Rate category associated with the room type — links inventory to pricing strategy."
    - name: "active_status"
      expr: active_status
      comment: "Whether the room type is currently active — filters sellable vs. inactive room types."
    - name: "is_ada_compliant"
      expr: is_ada_compliant
      comment: "ADA compliance flag — tracks accessible inventory availability for compliance reporting."
    - name: "is_suite"
      expr: is_suite
      comment: "Suite designation — enables premium inventory analysis and upsell opportunity tracking."
    - name: "sellable_flag"
      expr: sellable_flag
      comment: "Whether the room type is currently sellable — distinguishes revenue-generating from non-revenue inventory."
    - name: "overbooking_allowed"
      expr: overbooking_allowed
      comment: "Whether overbooking is permitted for this room type — informs overbooking strategy by category."
  measures:
    - name: "total_room_types"
      expr: COUNT(1)
      comment: "Total number of room types in the portfolio — baseline inventory composition metric for property benchmarking."
    - name: "sellable_room_type_count"
      expr: COUNT(CASE WHEN sellable_flag = TRUE THEN 1 END)
      comment: "Number of currently sellable room types — measures active revenue-generating inventory categories."
    - name: "ada_compliant_room_type_count"
      expr: COUNT(CASE WHEN is_ada_compliant = TRUE THEN 1 END)
      comment: "Number of ADA-compliant room types — compliance metric; low values relative to total may indicate regulatory risk."
    - name: "avg_max_occupancy"
      expr: AVG(CAST(max_occupancy AS DOUBLE))
      comment: "Average maximum occupancy across room types — measures capacity density of the room portfolio; informs group and family segment targeting."
    - name: "avg_standard_occupancy"
      expr: AVG(CAST(standard_occupancy AS DOUBLE))
      comment: "Average standard occupancy across room types — baseline occupancy assumption used in revenue forecasting and rate setting."
    - name: "avg_square_footage"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average square footage across room types — measures physical asset quality; larger rooms typically command premium rates."
    - name: "suite_room_type_count"
      expr: COUNT(CASE WHEN is_suite = TRUE THEN 1 END)
      comment: "Number of suite room types — measures premium inventory depth; informs upsell program design and luxury segment strategy."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical room asset metrics — tracks room condition, accessibility, and operational status across the property portfolio for asset management and compliance reporting."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier — enables property-level room asset comparison."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type identifier — enables room-level analysis by category."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the room — primary filter for active vs. inactive room inventory."
    - name: "housekeeping_status"
      expr: housekeeping_status
      comment: "Current housekeeping status — operational dimension for front desk and housekeeping coordination."
    - name: "ada_accessible"
      expr: ada_accessible
      comment: "ADA accessibility flag — compliance dimension for accessible room inventory tracking."
    - name: "smoking_allowed"
      expr: smoking_allowed
      comment: "Smoking policy for the room — inventory segmentation dimension for guest preference matching."
    - name: "lra_eligible"
      expr: lra_eligible
      comment: "Last Room Available eligibility — indicates rooms subject to LRA rate obligations."
  measures:
    - name: "total_rooms"
      expr: COUNT(1)
      comment: "Total physical room count — fundamental inventory capacity metric for the property portfolio."
    - name: "operational_room_count"
      expr: COUNT(CASE WHEN operational_status = 'operational' THEN 1 END)
      comment: "Number of rooms in operational status — measures sellable physical capacity excluding OOO and OOS rooms."
    - name: "ada_accessible_room_count"
      expr: COUNT(CASE WHEN ada_accessible = TRUE THEN 1 END)
      comment: "Number of ADA-accessible rooms — compliance metric; ratio to total rooms indicates accessibility compliance posture."
    - name: "avg_ffe_condition_score"
      expr: AVG(CAST(ffe_condition_score AS DOUBLE))
      comment: "Average FF&E condition score across rooms — asset quality metric; declining scores signal need for renovation investment (PIP planning)."
    - name: "avg_max_occupancy"
      expr: AVG(CAST(max_occupancy AS DOUBLE))
      comment: "Average maximum occupancy per room — measures capacity density; informs group and family segment revenue potential."
    - name: "avg_square_footage"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average room square footage — physical asset quality metric; used in competitive benchmarking and rate justification."
    - name: "overbooking_eligible_room_count"
      expr: COUNT(CASE WHEN overbooking_eligible = TRUE THEN 1 END)
      comment: "Number of rooms eligible for overbooking — measures the inventory buffer available for overbooking strategy execution."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_overbooking_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Overbooking policy metrics — tracks overbooking limits, walk risk tolerance, and no-show/cancellation forecast rates to manage walk exposure and revenue optimization."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier — enables property-level overbooking policy comparison."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type identifier — enables overbooking policy analysis by room category."
    - name: "policy_status"
      expr: policy_status
      comment: "Current status of the overbooking policy — filters active vs. inactive policies."
    - name: "overbooking_limit_type"
      expr: overbooking_limit_type
      comment: "Type of overbooking limit (absolute rooms vs. percentage) — distinguishes policy structures."
    - name: "lra_enabled"
      expr: lra_enabled
      comment: "Whether LRA is enabled under this policy — indicates rate obligation constraints on overbooking."
    - name: "walk_risk_tolerance"
      expr: walk_risk_tolerance
      comment: "Walk risk tolerance level — primary dimension for risk-stratified overbooking analysis."
  measures:
    - name: "avg_overbooking_limit_value"
      expr: AVG(CAST(overbooking_limit_value AS DOUBLE))
      comment: "Average overbooking limit value across policies — measures how aggressively properties are overbooking; high values increase walk risk."
    - name: "avg_no_show_forecast_rate"
      expr: AVG(CAST(no_show_forecast_rate AS DOUBLE))
      comment: "Average no-show forecast rate — key input to overbooking model; accuracy directly impacts walk incidents and revenue optimization."
    - name: "avg_cancellation_forecast_rate"
      expr: AVG(CAST(cancellation_forecast_rate AS DOUBLE))
      comment: "Average cancellation forecast rate — combined with no-show rate determines safe overbooking level; critical for revenue management model calibration."
    - name: "avg_walk_cost_estimate"
      expr: AVG(CAST(walk_cost_estimate AS DOUBLE))
      comment: "Average estimated cost per walk incident — measures financial exposure from overbooking; informs acceptable overbooking limit setting."
    - name: "active_policy_count"
      expr: COUNT(CASE WHEN policy_status = 'active' THEN 1 END)
      comment: "Number of active overbooking policies — baseline count for policy coverage monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_block_wash_factor_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Block wash factor application metrics — tracks forecast accuracy of wash assumptions vs. actual attrition for group block revenue management and model calibration."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`block_wash_factor_application`"
  dimensions:
    - name: "room_block_id"
      expr: room_block_id
      comment: "Room block identifier — primary grouping dimension for wash factor analysis by block."
    - name: "application_status"
      expr: application_status
      comment: "Status of the wash factor application — filters applied vs. pending wash adjustments."
    - name: "application_reason"
      expr: application_reason
      comment: "Reason for wash factor application — enables root cause analysis of wash adjustments."
    - name: "effective_date"
      expr: effective_date
      comment: "Date the wash factor was applied — time dimension for wash application trend analysis."
    - name: "block_size_tier_match"
      expr: block_size_tier_match
      comment: "Block size tier matched for wash factor selection — enables analysis of wash accuracy by block size category."
    - name: "lead_time_bucket_match"
      expr: lead_time_bucket_match
      comment: "Lead time bucket matched for wash factor selection — enables analysis of wash accuracy by booking lead time."
  measures:
    - name: "avg_applied_wash_pct"
      expr: AVG(CAST(applied_wash_pct AS DOUBLE))
      comment: "Average wash percentage applied to group blocks — measures how aggressively inventory is being released from group blocks in forecasting."
    - name: "avg_actual_wash_pct"
      expr: AVG(CAST(actual_wash_pct AS DOUBLE))
      comment: "Average actual wash percentage realized — measures true attrition rate; comparison to applied wash reveals forecast accuracy."
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_pct AS DOUBLE))
      comment: "Average variance between applied and actual wash percentage — primary model accuracy KPI; persistent positive variance means over-releasing inventory, negative means under-releasing."
    - name: "avg_wash_factor_percentage"
      expr: AVG(CAST(wash_factor_percentage AS DOUBLE))
      comment: "Average wash factor percentage from the referenced wash factor rule — baseline for comparing applied vs. rule-defined wash rates."
    - name: "wash_application_count"
      expr: COUNT(1)
      comment: "Total number of wash factor applications — baseline count for wash model activity monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_los_restriction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Length-of-stay restriction metrics — tracks minimum and maximum LOS restriction activity, occupancy thresholds, and ADR/RevPAR triggers for revenue management strategy evaluation."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`los_restriction`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier — enables property-level LOS restriction strategy comparison."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type identifier — enables LOS restriction analysis by room category."
    - name: "stay_date"
      expr: stay_date
      comment: "Stay date the restriction applies to — primary time dimension for restriction calendar analysis."
    - name: "restriction_status"
      expr: restriction_status
      comment: "Current status of the LOS restriction — filters active vs. expired restrictions."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Type of LOS restriction (min stay, max stay, full pattern) — enables analysis by restriction structure."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment the restriction applies to — enables segment-specific restriction analysis."
    - name: "lra_flag"
      expr: lra_flag
      comment: "Last Room Available flag — indicates LRA rate obligation applies to this restriction."
  measures:
    - name: "avg_occ_threshold_percent"
      expr: AVG(CAST(occ_threshold_percent AS DOUBLE))
      comment: "Average occupancy threshold that triggers LOS restrictions — measures how aggressively restrictions are set relative to demand; informs restriction calibration."
    - name: "avg_adr_threshold_amount"
      expr: AVG(CAST(adr_threshold_amount AS DOUBLE))
      comment: "Average ADR threshold for LOS restriction activation — measures rate floor used to trigger length-of-stay controls."
    - name: "avg_revpar_threshold_amount"
      expr: AVG(CAST(revpar_threshold_amount AS DOUBLE))
      comment: "Average RevPAR threshold for LOS restriction activation — measures RevPAR floor used in restriction strategy; directly links restrictions to revenue performance targets."
    - name: "active_restriction_count"
      expr: COUNT(CASE WHEN restriction_status = 'active' THEN 1 END)
      comment: "Number of currently active LOS restrictions — operational metric for restriction calendar density monitoring."
    - name: "total_restriction_records"
      expr: COUNT(1)
      comment: "Total LOS restriction records — baseline count for restriction activity volume tracking."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room_amenity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room amenity portfolio metrics — tracks amenity condition, cost, compliance, and premium designation across the room inventory for asset management and guest experience investment decisions."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room_amenity`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier — enables property-level amenity portfolio comparison."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type identifier — enables amenity analysis by room category."
    - name: "amenity_category"
      expr: amenity_category
      comment: "Category of the amenity (technology, comfort, safety, etc.) — primary dimension for amenity investment analysis."
    - name: "condition_status"
      expr: condition_status
      comment: "Current condition of the amenity — operational dimension for maintenance prioritization."
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the amenity — filters functional vs. non-functional amenities."
    - name: "is_premium_amenity"
      expr: is_premium_amenity
      comment: "Premium amenity designation — enables analysis of premium vs. standard amenity investment."
    - name: "is_ada_compliant"
      expr: is_ada_compliant
      comment: "ADA compliance flag — tracks accessible amenity inventory for compliance reporting."
    - name: "is_eco_friendly"
      expr: is_eco_friendly
      comment: "Eco-friendly designation — tracks sustainability investment in room amenities."
  measures:
    - name: "total_amenity_unit_cost"
      expr: SUM(CAST(unit_cost AS DOUBLE))
      comment: "Total unit cost of all room amenities — measures total amenity asset investment value across the portfolio."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per amenity — benchmarks amenity investment level; used in renovation budgeting and brand standard compliance."
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total charge amount for paid amenities — measures revenue generated from amenity charges; informs ancillary revenue strategy."
    - name: "premium_amenity_count"
      expr: COUNT(CASE WHEN is_premium_amenity = TRUE THEN 1 END)
      comment: "Number of premium amenities — measures premium inventory depth; informs upsell and luxury positioning strategy."
    - name: "non_compliant_amenity_count"
      expr: COUNT(CASE WHEN is_ada_compliant = FALSE THEN 1 END)
      comment: "Number of non-ADA-compliant amenities — compliance risk metric; high counts indicate potential regulatory exposure."
    - name: "total_amenity_count"
      expr: COUNT(1)
      comment: "Total number of room amenity records — baseline count for amenity portfolio completeness monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room_type_competitive_benchmark`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room type competitive benchmarking metrics — tracks benchmark weights and competitive set coverage for rate shop and market positioning analysis."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room_type_competitive_benchmark`"
  dimensions:
    - name: "benchmark_room_type_category"
      expr: benchmark_room_type_category
      comment: "Category of the benchmark room type — enables like-for-like competitive comparison."
    - name: "room_type_competitive_benchmark_status"
      expr: room_type_competitive_benchmark_status
      comment: "Status of the benchmark record — filters active vs. expired competitive benchmarks."
    - name: "is_primary_comp_category"
      expr: is_primary_comp_category
      comment: "Whether this is the primary competitive category — distinguishes primary vs. secondary comp set benchmarks."
    - name: "effective_date"
      expr: effective_date
      comment: "Date the benchmark became effective — time dimension for competitive positioning trend analysis."
  measures:
    - name: "avg_benchmark_weight"
      expr: AVG(CAST(benchmark_weight AS DOUBLE))
      comment: "Average benchmark weight assigned to competitive room types — measures relative importance of each comp set member in rate positioning decisions."
    - name: "active_benchmark_count"
      expr: COUNT(CASE WHEN room_type_competitive_benchmark_status = 'active' THEN 1 END)
      comment: "Number of active competitive benchmarks — measures competitive intelligence coverage; low counts indicate gaps in rate shop monitoring."
    - name: "primary_comp_category_count"
      expr: COUNT(CASE WHEN is_primary_comp_category = TRUE THEN 1 END)
      comment: "Number of primary competitive category benchmarks — measures core comp set depth for rate positioning analysis."
    - name: "total_benchmark_records"
      expr: COUNT(1)
      comment: "Total competitive benchmark records — baseline count for competitive intelligence program coverage."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_change_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Change Audit business metrics"
  source: "`vibe_travel_hospitality_v1`.`inventory`.`change_audit`"
  dimensions:
    - name: "Approval Authority Level"
      expr: approval_authority_level
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Authorizing User Name"
      expr: authorizing_user_name
    - name: "Business Date"
      expr: business_date
    - name: "Change Impact Type"
      expr: change_impact_type
    - name: "Change Reason Code"
      expr: change_reason_code
    - name: "Change Reason Description"
      expr: change_reason_description
    - name: "Change Timestamp"
      expr: change_timestamp
    - name: "Changed Entity Reference"
      expr: changed_entity_reference
    - name: "Changed Entity Type"
      expr: changed_entity_type
    - name: "Channel Code"
      expr: channel_code
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Cta Ctd Change Flag"
      expr: cta_ctd_change_flag
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Change Audit"
      expr: COUNT(DISTINCT change_audit_id)
    - name: "Total New Value"
      expr: SUM(new_value)
    - name: "Average New Value"
      expr: AVG(new_value)
    - name: "Total Previous Value"
      expr: SUM(previous_value)
    - name: "Average Previous Value"
      expr: AVG(previous_value)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_channel_inventory_map`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel Inventory Map business metrics"
  source: "`vibe_travel_hospitality_v1`.`inventory`.`channel_inventory_map`"
  dimensions:
    - name: "Advance Booking Days Max"
      expr: advance_booking_days_max
    - name: "Advance Booking Days Min"
      expr: advance_booking_days_min
    - name: "Allocation Type"
      expr: allocation_type
    - name: "Booking Source Code"
      expr: booking_source_code
    - name: "Channel Code"
      expr: channel_code
    - name: "Channel Priority Rank"
      expr: channel_priority_rank
    - name: "Channel Sell Limit"
      expr: channel_sell_limit
    - name: "Channel Visibility Flag"
      expr: channel_visibility_flag
    - name: "Commission Eligible Flag"
      expr: commission_eligible_flag
    - name: "Connectivity Method"
      expr: connectivity_method
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Last Sync Timestamp"
      expr: last_sync_timestamp
    - name: "Lra Enabled Flag"
      expr: lra_enabled_flag
    - name: "Mapping Status"
      expr: mapping_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Channel Inventory Map"
      expr: COUNT(DISTINCT channel_inventory_map_id)
    - name: "Total Overbooking Limit Pct"
      expr: SUM(overbooking_limit_pct)
    - name: "Average Overbooking Limit Pct"
      expr: AVG(overbooking_limit_pct)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_inventory_overbooking_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory Overbooking Policy business metrics"
  source: "`vibe_travel_hospitality_v1`.`inventory`.`inventory_overbooking_policy`"
  dimensions:
    - name: "Approval Authority"
      expr: approval_authority
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Channel Applicability"
      expr: channel_applicability
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Los Restriction Max"
      expr: los_restriction_max
    - name: "Los Restriction Min"
      expr: los_restriction_min
    - name: "Lra Enabled"
      expr: lra_enabled
    - name: "Maximum Overbooking Rooms"
      expr: maximum_overbooking_rooms
    - name: "Notes"
      expr: notes
    - name: "Overbooking Limit Type"
      expr: overbooking_limit_type
    - name: "Physical Room Capacity"
      expr: physical_room_capacity
    - name: "Policy Code"
      expr: policy_code
    - name: "Policy Name"
      expr: policy_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Inventory Overbooking Policy"
      expr: COUNT(DISTINCT inventory_overbooking_policy_id)
    - name: "Total Cancellation Forecast Rate"
      expr: SUM(cancellation_forecast_rate)
    - name: "Average Cancellation Forecast Rate"
      expr: AVG(cancellation_forecast_rate)
    - name: "Total No Show Forecast Rate"
      expr: SUM(no_show_forecast_rate)
    - name: "Average No Show Forecast Rate"
      expr: AVG(no_show_forecast_rate)
    - name: "Total Overbooking Limit Value"
      expr: SUM(overbooking_limit_value)
    - name: "Average Overbooking Limit Value"
      expr: AVG(overbooking_limit_value)
    - name: "Total Walk Cost Estimate"
      expr: SUM(walk_cost_estimate)
    - name: "Average Walk Cost Estimate"
      expr: AVG(walk_cost_estimate)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_rate_plan_room_type_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate Plan Room Type Assignment business metrics"
  source: "`vibe_travel_hospitality_v1`.`inventory`.`rate_plan_room_type_assignment`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Max Los"
      expr: max_los
    - name: "Min Los"
      expr: min_los
    - name: "Modified By User"
      expr: modified_by_user
    - name: "Priority Rank"
      expr: priority_rank
    - name: "Restriction Status"
      expr: restriction_status
    - name: "Sell Limit"
      expr: sell_limit
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rate Plan Room Type Assignment"
      expr: COUNT(DISTINCT rate_plan_room_type_assignment_id)
    - name: "Total Rate Adjustment Value"
      expr: SUM(rate_adjustment_value)
    - name: "Average Rate Adjustment Value"
      expr: AVG(rate_adjustment_value)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room_material_installation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room Material Installation business metrics"
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room_material_installation`"
  dimensions:
    - name: "Condition Status"
      expr: condition_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Installation Date"
      expr: installation_date
    - name: "Installation Notes"
      expr: installation_notes
    - name: "Last Maintenance Date"
      expr: last_maintenance_date
    - name: "Last Replacement Date"
      expr: last_replacement_date
    - name: "Maintenance Frequency Days"
      expr: maintenance_frequency_days
    - name: "Next Scheduled Replacement Date"
      expr: next_scheduled_replacement_date
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Warranty Expiry Date"
      expr: warranty_expiry_date
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Installation Date Month"
      expr: DATE_TRUNC('MONTH', installation_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Room Material Installation"
      expr: COUNT(DISTINCT room_material_installation_id)
    - name: "Total Quantity Installed"
      expr: SUM(quantity_installed)
    - name: "Average Quantity Installed"
      expr: AVG(quantity_installed)
    - name: "Total Unit Cost At Installation"
      expr: SUM(unit_cost_at_installation)
    - name: "Average Unit Cost At Installation"
      expr: AVG(unit_cost_at_installation)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room_status`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room Status business metrics"
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room_status`"
  dimensions:
    - name: "Blocked Reason"
      expr: blocked_reason
    - name: "Cleaning Type"
      expr: cleaning_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Discrepancy Flag"
      expr: discrepancy_flag
    - name: "Discrepancy Notes"
      expr: discrepancy_notes
    - name: "Do Not Disturb Flag"
      expr: do_not_disturb_flag
    - name: "Expected Checkin Date"
      expr: expected_checkin_date
    - name: "Expected Checkout Date"
      expr: expected_checkout_date
    - name: "Front Desk Status"
      expr: front_desk_status
    - name: "Housekeeping Status"
      expr: housekeeping_status
    - name: "Is Blocked"
      expr: is_blocked
    - name: "Is Clean"
      expr: is_clean
    - name: "Is Inspected"
      expr: is_inspected
    - name: "Is Out Of Order"
      expr: is_out_of_order
    - name: "Last Cleaned Timestamp"
      expr: last_cleaned_timestamp
    - name: "Last Inspected Timestamp"
      expr: last_inspected_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Room Status"
      expr: COUNT(DISTINCT room_status_id)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room_type_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room Type Promotion business metrics"
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room_type_promotion`"
  dimensions:
    - name: "Active Status"
      expr: active_status
    - name: "Blackout Dates"
      expr: blackout_dates
    - name: "Booking Window End Date"
      expr: booking_window_end_date
    - name: "Booking Window Start Date"
      expr: booking_window_start_date
    - name: "Created Date"
      expr: created_date
    - name: "Inventory Allocation Cap"
      expr: inventory_allocation_cap
    - name: "Minimum Los Override"
      expr: minimum_los_override
    - name: "Rooms Booked Count"
      expr: rooms_booked_count
    - name: "Booking Window End Date Month"
      expr: DATE_TRUNC('MONTH', booking_window_end_date)
    - name: "Booking Window Start Date Month"
      expr: DATE_TRUNC('MONTH', booking_window_start_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Room Type Promotion"
      expr: COUNT(DISTINCT room_type_promotion_id)
    - name: "Total Bonus Points Multiplier"
      expr: SUM(bonus_points_multiplier)
    - name: "Average Bonus Points Multiplier"
      expr: AVG(bonus_points_multiplier)
    - name: "Total Promotional Rate Amount"
      expr: SUM(promotional_rate_amount)
    - name: "Average Promotional Rate Amount"
      expr: AVG(promotional_rate_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room_type_vendor_supply`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room Type Vendor Supply business metrics"
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room_type_vendor_supply`"
  dimensions:
    - name: "Active Status"
      expr: active_status
    - name: "Contract Effective Date"
      expr: contract_effective_date
    - name: "Contract Expiry Date"
      expr: contract_expiry_date
    - name: "Created Date"
      expr: created_date
    - name: "Last Order Date"
      expr: last_order_date
    - name: "Last Updated Date"
      expr: last_updated_date
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Minimum Order Quantity"
      expr: minimum_order_quantity
    - name: "Preferred Vendor Flag"
      expr: preferred_vendor_flag
    - name: "Supply Category"
      expr: supply_category
    - name: "Contract Effective Date Month"
      expr: DATE_TRUNC('MONTH', contract_effective_date)
    - name: "Contract Expiry Date Month"
      expr: DATE_TRUNC('MONTH', contract_expiry_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Room Type Vendor Supply"
      expr: COUNT(DISTINCT room_type_vendor_supply_id)
    - name: "Total Negotiated Discount Percent"
      expr: SUM(negotiated_discount_percent)
    - name: "Average Negotiated Discount Percent"
      expr: AVG(negotiated_discount_percent)
    - name: "Total Total Spend Amount"
      expr: SUM(total_spend_amount)
    - name: "Average Total Spend Amount"
      expr: AVG(total_spend_amount)
$$;