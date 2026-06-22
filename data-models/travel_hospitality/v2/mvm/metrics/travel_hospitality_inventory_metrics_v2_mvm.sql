-- Metric views for domain: inventory | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-22 19:35:58

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_availability_snapshot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Daily inventory availability KPIs tracking occupancy rates, overbooking exposure, and stop-sell activity across properties and room types. Core operational dashboard for revenue management and front-office leadership."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`availability_snapshot`"
  dimensions:
    - name: "snapshot_date"
      expr: snapshot_date
      comment: "Calendar date of the inventory snapshot, used for daily trend analysis and date-range filtering."
    - name: "property_id"
      expr: property_id
      comment: "Identifier of the property; used to segment availability metrics by hotel or resort."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Identifier of the room type; enables drill-down into availability by room category."
    - name: "stop_sell_flag"
      expr: stop_sell_flag
      comment: "Indicates whether the room type was closed to new sales on the snapshot date; critical for channel yield analysis."
    - name: "closed_to_arrival_flag"
      expr: closed_to_arrival_flag
      comment: "Indicates whether arrivals were blocked on this date; used to assess restriction impact on occupancy."
    - name: "closed_to_departure_flag"
      expr: closed_to_departure_flag
      comment: "Indicates whether departures were blocked on this date; used alongside CTA to evaluate LOS restriction patterns."
    - name: "lra_flag"
      expr: lra_flag
      comment: "Last Room Available flag; signals whether the property is obligated to sell the last available room under contract."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of the inventory reconciliation process for this snapshot; used to filter out unreconciled records in reporting."
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_date)
      comment: "Month-level bucket of the snapshot date for monthly trend and period-over-period analysis."
  measures:
    - name: "avg_occupancy_rate"
      expr: AVG(CAST(occ_rate AS DOUBLE))
      comment: "Average occupancy rate across all snapshots in the selected period and grouping. Core KPI for revenue management and capacity planning decisions."
    - name: "max_occupancy_rate"
      expr: MAX(CAST(occ_rate AS DOUBLE))
      comment: "Peak occupancy rate observed within the selected period; identifies demand spikes requiring yield intervention."
    - name: "min_occupancy_rate"
      expr: MIN(CAST(occ_rate AS DOUBLE))
      comment: "Lowest occupancy rate observed within the selected period; highlights demand troughs for promotional targeting."
    - name: "stop_sell_days"
      expr: COUNT(CASE WHEN stop_sell_flag = TRUE THEN 1 END)
      comment: "Number of snapshot days where stop-sell was active. High counts indicate aggressive yield management or capacity constraints."
    - name: "closed_to_arrival_days"
      expr: COUNT(CASE WHEN closed_to_arrival_flag = TRUE THEN 1 END)
      comment: "Number of snapshot days with closed-to-arrival restrictions active. Informs leadership on restriction frequency and potential revenue impact."
    - name: "lra_active_days"
      expr: COUNT(CASE WHEN lra_flag = TRUE THEN 1 END)
      comment: "Number of days where Last Room Available obligation was active. Tracks contractual exposure and its effect on sellable inventory."
    - name: "total_snapshots"
      expr: COUNT(1)
      comment: "Total number of availability snapshot records; baseline volume metric for data completeness and coverage monitoring."
    - name: "distinct_properties_tracked"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties represented in the snapshot dataset; confirms inventory monitoring coverage breadth."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue management control KPIs covering channel allocation, overbooking limits, hurdle rates, and competitive positioning. Designed for revenue strategy and distribution leadership to evaluate yield control effectiveness."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`control`"
  dimensions:
    - name: "stay_date"
      expr: stay_date
      comment: "The stay date to which the inventory control record applies; primary time dimension for demand-period analysis."
    - name: "stay_month"
      expr: DATE_TRUNC('MONTH', stay_date)
      comment: "Month-level bucket of the stay date for monthly yield strategy review."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier; enables property-level comparison of control parameters and yield strategies."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type identifier; allows drill-down into control settings by room category."
    - name: "channel_id"
      expr: channel_id
      comment: "Distribution channel identifier; critical for evaluating channel-specific allocation and yield control effectiveness."
    - name: "control_status"
      expr: control_status
      comment: "Current status of the inventory control record (e.g., active, expired, overridden); used to filter analysis to active controls."
    - name: "stop_sell_flag"
      expr: stop_sell_flag
      comment: "Indicates whether a stop-sell restriction is active under this control record."
    - name: "cta_flag"
      expr: cta_flag
      comment: "Closed-to-arrival flag on the control record; used to assess restriction breadth across channels."
    - name: "ctd_flag"
      expr: ctd_flag
      comment: "Closed-to-departure flag on the control record; paired with CTA for LOS restriction analysis."
    - name: "lra_flag"
      expr: lra_flag
      comment: "Last Room Available flag on the control record; indicates contractual obligation to sell last room."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which rate and financial control values are denominated."
    - name: "source"
      expr: source
      comment: "Source system or user that created the control record; useful for auditing automated vs. manual yield interventions."
  measures:
    - name: "avg_hurdle_rate"
      expr: AVG(CAST(hurdle_rate AS DOUBLE))
      comment: "Average hurdle rate across control records. The hurdle rate is the minimum acceptable ADR for accepting a booking; a key lever in revenue optimization strategy."
    - name: "avg_channel_allocation_pct"
      expr: AVG(CAST(channel_allocation_pct AS DOUBLE))
      comment: "Average percentage of inventory allocated to each channel. Informs distribution mix decisions and channel partnership negotiations."
    - name: "avg_overbooking_limit_pct"
      expr: AVG(CAST(overbooking_limit_pct AS DOUBLE))
      comment: "Average overbooking limit percentage across control records. Tracks risk tolerance in overbooking strategy; directly tied to walk risk and guest satisfaction."
    - name: "avg_competitive_set_adr"
      expr: AVG(CAST(competitive_set_adr AS DOUBLE))
      comment: "Average ADR of the competitive set as captured in control records. Benchmarks the property's pricing position relative to the market."
    - name: "avg_rgi_target"
      expr: AVG(CAST(rgi_target AS DOUBLE))
      comment: "Average Revenue Generation Index target set in control records. RGI measures revenue performance relative to the competitive set; a strategic KPI for ownership and asset management."
    - name: "stop_sell_control_count"
      expr: COUNT(CASE WHEN stop_sell_flag = TRUE THEN 1 END)
      comment: "Number of active control records with stop-sell enabled. High counts signal aggressive yield management or capacity constraints requiring leadership review."
    - name: "lra_control_count"
      expr: COUNT(CASE WHEN lra_flag = TRUE THEN 1 END)
      comment: "Number of control records with Last Room Available obligation active. Tracks contractual exposure that limits yield management flexibility."
    - name: "total_control_records"
      expr: COUNT(1)
      comment: "Total number of inventory control records; baseline for assessing yield management activity volume and system utilization."
    - name: "distinct_channels_controlled"
      expr: COUNT(DISTINCT channel_id)
      comment: "Number of distinct distribution channels with active control records; measures breadth of channel yield management coverage."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_los_restriction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Length-of-stay restriction KPIs tracking ADR thresholds, occupancy triggers, and restriction coverage across stay dates. Enables revenue management leadership to evaluate LOS strategy effectiveness and restriction intensity."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`los_restriction`"
  dimensions:
    - name: "stay_date"
      expr: stay_date
      comment: "The stay date to which the LOS restriction applies; primary time dimension for restriction calendar analysis."
    - name: "stay_month"
      expr: DATE_TRUNC('MONTH', stay_date)
      comment: "Month-level bucket of the stay date for monthly restriction strategy review."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier; enables property-level comparison of LOS restriction strategies."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type identifier; allows drill-down into LOS restrictions by room category."
    - name: "channel_id"
      expr: channel_id
      comment: "Channel identifier; used to assess channel-specific LOS restriction application."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Type of LOS restriction (e.g., min stay, max stay, full pattern); categorizes restriction strategy."
    - name: "restriction_status"
      expr: restriction_status
      comment: "Current status of the restriction record (e.g., active, expired); used to filter to actionable restrictions."
    - name: "lra_flag"
      expr: lra_flag
      comment: "Last Room Available flag; indicates whether LRA obligation applies to this restriction record."
    - name: "group_block_exempt_flag"
      expr: group_block_exempt_flag
      comment: "Indicates whether group blocks are exempt from this LOS restriction; important for group sales strategy."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment to which the restriction applies; enables segment-level LOS strategy analysis."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Start date of the restriction's effective period; used for restriction lifecycle and coverage analysis."
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "End date of the restriction's effective period; paired with start date to measure restriction duration."
  measures:
    - name: "avg_adr_threshold"
      expr: AVG(CAST(adr_threshold_amount AS DOUBLE))
      comment: "Average ADR threshold set on LOS restrictions. Reflects the minimum rate required to bypass or trigger a restriction; a key lever in revenue optimization."
    - name: "avg_occ_threshold_pct"
      expr: AVG(CAST(occ_threshold_percent AS DOUBLE))
      comment: "Average occupancy threshold percentage that triggers LOS restrictions. Indicates how aggressively restrictions are tied to demand levels."
    - name: "avg_revpar_threshold"
      expr: AVG(CAST(revpar_threshold_amount AS DOUBLE))
      comment: "Average RevPAR threshold set on LOS restrictions. RevPAR-linked restrictions represent sophisticated yield management; tracks strategy maturity."
    - name: "avg_override_authority_level"
      expr: AVG(CAST(override_authority_level AS DOUBLE))
      comment: "Average authority level required to override LOS restrictions. Higher values indicate tighter governance; informs delegation and approval workflow design."
    - name: "lra_exempt_restriction_count"
      expr: COUNT(CASE WHEN lra_flag = TRUE THEN 1 END)
      comment: "Number of LOS restrictions where LRA obligation is active. Tracks contractual constraints that limit restriction enforcement flexibility."
    - name: "group_exempt_restriction_count"
      expr: COUNT(CASE WHEN group_block_exempt_flag = TRUE THEN 1 END)
      comment: "Number of LOS restrictions that exempt group blocks. Measures how often group business is shielded from LOS controls; informs group vs. transient yield trade-off decisions."
    - name: "total_restrictions"
      expr: COUNT(1)
      comment: "Total number of LOS restriction records; baseline for measuring restriction activity volume and yield management intensity."
    - name: "distinct_properties_with_restrictions"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with LOS restrictions in place; measures breadth of LOS strategy deployment across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_out_of_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Out-of-order room KPIs tracking lost revenue, cost exposure, occupancy impact, and operational efficiency of room maintenance events. Critical for asset management, operations leadership, and revenue recovery planning."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`out_of_order`"
  dimensions:
    - name: "start_date"
      expr: start_date
      comment: "Date the room was taken out of order; primary time dimension for OOO event trend analysis."
    - name: "ooo_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month-level bucket of the OOO start date for monthly operational impact reporting."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier; enables property-level comparison of OOO frequency and financial impact."
    - name: "ooo_reason"
      expr: ooo_reason
      comment: "Reason the room was taken out of order; used to categorize maintenance events and identify systemic issues."
    - name: "ooo_status"
      expr: ooo_status
      comment: "Current status of the OOO record (e.g., open, closed, pending); used to filter active vs. resolved events."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for the OOO event; enables accountability tracking and departmental performance benchmarking."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the OOO event; used to assess urgency distribution and resource allocation effectiveness."
    - name: "safety_concern_flag"
      expr: safety_concern_flag
      comment: "Indicates whether the OOO event involves a safety concern; critical for risk management and compliance reporting."
    - name: "guest_impacted_flag"
      expr: guest_impacted_flag
      comment: "Indicates whether guests were impacted by the OOO event; directly tied to guest satisfaction and relocation cost exposure."
    - name: "ada_compliance_flag"
      expr: ada_compliance_flag
      comment: "Indicates whether the OOO event involves an ADA compliance issue; tracks regulatory exposure."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which cost and revenue estimates are denominated."
  measures:
    - name: "total_lost_revenue_estimate"
      expr: SUM(CAST(lost_revenue_estimate AS DOUBLE))
      comment: "Total estimated revenue lost due to out-of-order rooms. The single most important financial KPI for OOO management; directly informs maintenance prioritization and capital investment decisions."
    - name: "avg_lost_revenue_per_event"
      expr: AVG(CAST(lost_revenue_estimate AS DOUBLE))
      comment: "Average estimated revenue lost per OOO event. Benchmarks the financial severity of individual events; used to prioritize high-impact maintenance interventions."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred for out-of-order room repairs. Tracks maintenance spend and informs capital expenditure planning and budget variance analysis."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost for OOO repairs at time of event creation. Paired with actual cost to measure estimation accuracy and budget adherence."
    - name: "avg_impact_on_occ"
      expr: AVG(CAST(impact_on_occ AS DOUBLE))
      comment: "Average occupancy impact per OOO event. Quantifies how OOO rooms reduce sellable inventory and depress occupancy rates; a key input to revenue forecasting."
    - name: "avg_impact_on_revpar"
      expr: AVG(CAST(impact_on_revpar AS DOUBLE))
      comment: "Average RevPAR impact per OOO event. RevPAR is the primary hotel performance metric; this measure directly links maintenance events to top-line performance degradation."
    - name: "safety_concern_event_count"
      expr: COUNT(CASE WHEN safety_concern_flag = TRUE THEN 1 END)
      comment: "Number of OOO events flagged as safety concerns. Tracks regulatory and liability exposure; a non-negotiable KPI for risk management and compliance leadership."
    - name: "guest_impacted_event_count"
      expr: COUNT(CASE WHEN guest_impacted_flag = TRUE THEN 1 END)
      comment: "Number of OOO events that impacted guests. Directly tied to guest satisfaction scores, relocation costs, and brand reputation risk."
    - name: "total_ooo_events"
      expr: COUNT(1)
      comment: "Total number of out-of-order events; baseline volume metric for operational health monitoring and trend analysis."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical room inventory KPIs covering capacity, condition, accessibility, and operational status across the property portfolio. Supports asset management, capital planning, and operational readiness decisions."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier; primary grouping dimension for portfolio-level room inventory analysis."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type identifier; enables drill-down into inventory composition by room category."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the room (e.g., active, OOO, OOS); used to segment sellable vs. non-sellable inventory."
    - name: "housekeeping_status"
      expr: housekeeping_status
      comment: "Current housekeeping status of the room; used for operational readiness and turn-time analysis."
    - name: "front_office_status"
      expr: front_office_status
      comment: "Current front office status of the room; used to reconcile front-office and housekeeping discrepancies."
    - name: "bed_type"
      expr: bed_type
      comment: "Bed configuration of the room; used to analyze inventory mix and match supply to guest demand patterns."
    - name: "view_type"
      expr: view_type
      comment: "View category of the room (e.g., ocean, garden, city); used to assess premium inventory distribution."
    - name: "ada_accessible"
      expr: ada_accessible
      comment: "Indicates whether the room is ADA accessible; tracks compliance inventory levels and accessibility demand fulfillment."
    - name: "smoking_allowed"
      expr: smoking_allowed
      comment: "Indicates whether smoking is permitted in the room; used to manage inventory segmentation by guest preference."
    - name: "overbooking_eligible"
      expr: overbooking_eligible
      comment: "Indicates whether the room is eligible for overbooking; used in yield management and walk-risk analysis."
    - name: "lra_eligible"
      expr: lra_eligible
      comment: "Indicates whether the room is eligible for Last Room Available contracts; tracks contractual inventory exposure."
    - name: "last_renovation_date"
      expr: last_renovation_date
      comment: "Date of the room's last renovation; used for asset lifecycle management and capital expenditure planning."
  measures:
    - name: "total_rooms"
      expr: COUNT(1)
      comment: "Total number of physical rooms in the inventory. Foundational capacity metric for all occupancy, RevPAR, and yield calculations."
    - name: "ada_accessible_rooms"
      expr: COUNT(CASE WHEN ada_accessible = TRUE THEN 1 END)
      comment: "Number of ADA-accessible rooms. Tracks compliance with accessibility regulations and ability to fulfill accessibility demand."
    - name: "overbooking_eligible_rooms"
      expr: COUNT(CASE WHEN overbooking_eligible = TRUE THEN 1 END)
      comment: "Number of rooms eligible for overbooking. Defines the maximum overbooking capacity; critical input to walk-risk management."
    - name: "avg_square_footage"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average room square footage across the inventory. Informs product positioning, rate strategy, and renovation prioritization."
    - name: "avg_max_occupancy"
      expr: AVG(CAST(max_occupancy AS DOUBLE))
      comment: "Average maximum occupancy per room. Used in capacity planning and to assess revenue potential per room unit."
    - name: "avg_ffe_condition_score"
      expr: AVG(CAST(ffe_condition_score AS DOUBLE))
      comment: "Average FF&E (Furniture, Fixtures & Equipment) condition score across rooms. A leading indicator of renovation need and guest satisfaction risk; directly informs capital expenditure planning."
    - name: "lra_eligible_rooms"
      expr: COUNT(CASE WHEN lra_eligible = TRUE THEN 1 END)
      comment: "Number of rooms eligible for Last Room Available contracts. Quantifies contractual inventory exposure and its impact on yield management flexibility."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group and allotment room block KPIs tracking pickup performance, attrition risk, commission exposure, and block financial value. Essential for group sales, revenue management, and contract compliance leadership."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room_block`"
  dimensions:
    - name: "start_date"
      expr: start_date
      comment: "Start date of the room block; primary time dimension for group business calendar analysis."
    - name: "block_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month-level bucket of the block start date for monthly group business pipeline review."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier; enables property-level group business performance comparison."
    - name: "room_type_id"
      expr: room_type_id
      comment: "Room type identifier; allows analysis of group block composition by room category."
    - name: "block_type"
      expr: block_type
      comment: "Type of room block (e.g., group, allotment, wholesale); used to segment group business by contract type."
    - name: "block_status"
      expr: block_status
      comment: "Current status of the room block (e.g., tentative, definite, cancelled); used to filter pipeline by commitment stage."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which block financial values are denominated."
    - name: "lra_flag"
      expr: lra_flag
      comment: "Last Room Available flag on the block; indicates contractual obligation affecting yield management."
    - name: "overbooking_allowed_flag"
      expr: overbooking_allowed_flag
      comment: "Indicates whether overbooking is permitted within this block; used in walk-risk and yield analysis."
    - name: "deposit_required_flag"
      expr: deposit_required_flag
      comment: "Indicates whether a deposit is required for this block; used to track financial commitment and attrition risk."
    - name: "cutoff_date"
      expr: cutoff_date
      comment: "Date by which unconfirmed block rooms are released back to general inventory; critical for inventory release management."
  measures:
    - name: "avg_pickup_percentage"
      expr: AVG(CAST(pickup_percentage AS DOUBLE))
      comment: "Average room block pickup percentage (rooms picked up vs. contracted). The primary KPI for group business performance; low pickup triggers attrition penalties and revenue shortfalls."
    - name: "total_attrition_penalty_amount"
      expr: SUM(CAST(attrition_penalty_amount AS DOUBLE))
      comment: "Total attrition penalty amounts across room blocks. Tracks financial exposure from underperforming group contracts; a direct revenue risk metric for group sales leadership."
    - name: "avg_attrition_percentage"
      expr: AVG(CAST(attrition_percentage AS DOUBLE))
      comment: "Average attrition percentage across room blocks. Measures how far blocks fall short of contracted commitments; informs group contract negotiation strategy."
    - name: "total_negotiated_rate"
      expr: SUM(CAST(negotiated_rate_amount AS DOUBLE))
      comment: "Total negotiated rate value across all room blocks. Represents the contracted revenue potential of the group pipeline; a key input to revenue forecasting."
    - name: "avg_negotiated_rate"
      expr: AVG(CAST(negotiated_rate_amount AS DOUBLE))
      comment: "Average negotiated rate per room block. Benchmarks group pricing against transient rates and competitive set; informs group pricing strategy."
    - name: "avg_commission_percentage"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission percentage across room blocks. Tracks distribution cost for group business; informs channel profitability and net revenue analysis."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts collected or due across room blocks. Tracks cash flow from group commitments and financial risk mitigation."
    - name: "total_room_blocks"
      expr: COUNT(1)
      comment: "Total number of room block records; baseline volume metric for group business pipeline size and activity monitoring."
    - name: "distinct_properties_with_blocks"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with active room blocks; measures group business distribution across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room_status`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real-time room status KPIs tracking housekeeping efficiency, discrepancy rates, occupancy readiness, and maintenance activity. Supports front-office operations, housekeeping management, and guest experience leadership."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room_status`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier; primary grouping dimension for portfolio-level room status analysis."
    - name: "housekeeping_status"
      expr: housekeeping_status
      comment: "Current housekeeping status of the room (e.g., clean, dirty, inspected); core operational dimension for housekeeping management."
    - name: "front_desk_status"
      expr: front_desk_status
      comment: "Current front desk status of the room; used to identify discrepancies between housekeeping and front office systems."
    - name: "maintenance_status"
      expr: maintenance_status
      comment: "Current maintenance status of the room; used to track rooms awaiting or undergoing maintenance."
    - name: "cleaning_type"
      expr: cleaning_type
      comment: "Type of cleaning assigned (e.g., departure, stayover, deep clean); used to analyze housekeeping workload composition."
    - name: "is_out_of_order"
      expr: is_out_of_order
      comment: "Indicates whether the room is currently out of order; used to segment non-sellable inventory."
    - name: "discrepancy_flag"
      expr: discrepancy_flag
      comment: "Indicates a status discrepancy between housekeeping and front office; a key quality metric for operational alignment."
    - name: "do_not_disturb_flag"
      expr: do_not_disturb_flag
      comment: "Indicates the room has a do-not-disturb status; affects housekeeping scheduling and service delivery."
    - name: "expected_checkin_date"
      expr: expected_checkin_date
      comment: "Expected check-in date for the room; used to prioritize cleaning and readiness scheduling."
    - name: "expected_checkout_date"
      expr: expected_checkout_date
      comment: "Expected check-out date for the room; used to plan departure cleaning and room turn scheduling."
  measures:
    - name: "total_rooms_tracked"
      expr: COUNT(1)
      comment: "Total number of room status records; baseline for operational coverage and data completeness monitoring."
    - name: "clean_rooms"
      expr: COUNT(CASE WHEN is_clean = TRUE THEN 1 END)
      comment: "Number of rooms currently in clean status. Directly measures housekeeping throughput and sellable inventory readiness; a critical front-office operational KPI."
    - name: "inspected_rooms"
      expr: COUNT(CASE WHEN is_inspected = TRUE THEN 1 END)
      comment: "Number of rooms that have passed inspection. Tracks quality assurance completion; inspected rooms represent the highest-confidence sellable inventory."
    - name: "out_of_order_rooms"
      expr: COUNT(CASE WHEN is_out_of_order = TRUE THEN 1 END)
      comment: "Number of rooms currently out of order. Directly reduces sellable inventory and impacts occupancy and RevPAR; a key operational and revenue metric."
    - name: "discrepancy_rooms"
      expr: COUNT(CASE WHEN discrepancy_flag = TRUE THEN 1 END)
      comment: "Number of rooms with a status discrepancy between housekeeping and front office. High discrepancy counts indicate operational misalignment that can lead to guest service failures and revenue loss."
    - name: "blocked_rooms"
      expr: COUNT(CASE WHEN is_blocked = TRUE THEN 1 END)
      comment: "Number of rooms currently blocked from sale. Tracks inventory held back from revenue generation; informs yield management and front-office allocation decisions."
    - name: "avg_occupancy_status"
      expr: AVG(CAST(occupancy_status AS DOUBLE))
      comment: "Average occupancy status score across room status records. Provides a continuous measure of occupancy intensity; used in operational dashboards to monitor real-time demand levels."
    - name: "avg_priority_level"
      expr: AVG(CAST(priority_level AS DOUBLE))
      comment: "Average priority level assigned to room status records. Tracks urgency distribution of housekeeping and maintenance tasks; informs resource allocation and staffing decisions."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`inventory_room_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room type portfolio KPIs covering capacity configuration, accessibility compliance, sellability, and product mix. Supports product strategy, revenue management, and asset management decisions at the room category level."
  source: "`vibe_travel_hospitality_v1`.`inventory`.`room_type`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier; enables property-level room type portfolio analysis."
    - name: "room_class"
      expr: room_class
      comment: "Class of the room type (e.g., standard, deluxe, suite); used to analyze inventory mix by product tier."
    - name: "rate_category"
      expr: rate_category
      comment: "Rate category associated with the room type; used to link product configuration to pricing strategy."
    - name: "active_status"
      expr: active_status
      comment: "Current active status of the room type; used to filter analysis to sellable room type configurations."
    - name: "sellable_flag"
      expr: sellable_flag
      comment: "Indicates whether the room type is currently available for sale; critical for sellable inventory analysis."
    - name: "is_suite"
      expr: is_suite
      comment: "Indicates whether the room type is a suite; used to segment premium inventory and analyze suite revenue contribution."
    - name: "is_ada_compliant"
      expr: is_ada_compliant
      comment: "Indicates whether the room type meets ADA compliance standards; tracks regulatory compliance at the product level."
    - name: "overbooking_allowed"
      expr: overbooking_allowed
      comment: "Indicates whether overbooking is permitted for this room type; used in yield management and walk-risk analysis."
    - name: "lra_eligible"
      expr: lra_eligible
      comment: "Indicates whether the room type is eligible for Last Room Available contracts; tracks contractual inventory exposure."
    - name: "bed_type"
      expr: bed_type
      comment: "Bed configuration of the room type; used to analyze product mix alignment with guest demand patterns."
    - name: "view_category"
      expr: view_category
      comment: "View category of the room type (e.g., ocean, garden, city); used to assess premium product distribution."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Date from which the room type configuration is effective; used for product lifecycle and configuration change analysis."
  measures:
    - name: "total_room_types"
      expr: COUNT(1)
      comment: "Total number of room type configurations. Baseline metric for product portfolio breadth; informs distribution system configuration and channel management."
    - name: "sellable_room_types"
      expr: COUNT(CASE WHEN sellable_flag = TRUE THEN 1 END)
      comment: "Number of room types currently flagged as sellable. Directly measures the active product portfolio available for revenue generation."
    - name: "suite_room_types"
      expr: COUNT(CASE WHEN is_suite = TRUE THEN 1 END)
      comment: "Number of suite room types in the portfolio. Tracks premium inventory depth; informs upsell strategy and suite revenue contribution analysis."
    - name: "ada_compliant_room_types"
      expr: COUNT(CASE WHEN is_ada_compliant = TRUE THEN 1 END)
      comment: "Number of ADA-compliant room types. Tracks regulatory compliance at the product level; informs accessibility demand fulfillment capacity."
    - name: "avg_max_occupancy"
      expr: AVG(CAST(max_occupancy AS DOUBLE))
      comment: "Average maximum occupancy per room type. Used in capacity planning and revenue potential modeling across the product portfolio."
    - name: "avg_standard_occupancy"
      expr: AVG(CAST(standard_occupancy AS DOUBLE))
      comment: "Average standard occupancy per room type. Benchmarks typical occupancy configuration; used in demand forecasting and rate strategy."
    - name: "avg_square_footage"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average square footage per room type. Informs product positioning, rate premium justification, and renovation investment prioritization."
    - name: "lra_eligible_room_types"
      expr: COUNT(CASE WHEN lra_eligible = TRUE THEN 1 END)
      comment: "Number of room types eligible for Last Room Available contracts. Quantifies contractual inventory exposure at the product level; informs contract negotiation strategy."
$$;