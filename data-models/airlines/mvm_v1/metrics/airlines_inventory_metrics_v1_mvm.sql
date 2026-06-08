-- Metric views for domain: inventory | Business: Airlines | Version: 1 | Generated on: 2026-05-07 15:08:57

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`inventory_flight_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core flight-level inventory KPIs tracking capacity utilisation, overbooking exposure, and seat availability across the network. Primary steering dashboard for Revenue Management and Network Planning."
  source: "`airlines_ecm`.`inventory`.`flight_inventory`"
  dimensions:
    - name: "flight_number"
      expr: flight_number
      comment: "Operating flight number for grouping inventory metrics by individual flight service."
    - name: "departure_date"
      expr: departure_date
      comment: "Scheduled departure date (yyyy-MM-dd) enabling day-level and trend analysis of inventory performance."
    - name: "destination_airport_code"
      expr: destination_airport_code
      comment: "IATA destination airport code for route-level inventory analysis."
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current inventory control status (e.g. OPEN, CLOSED, WAITLIST) for filtering active vs. closed flights."
    - name: "inventory_control_mode"
      expr: inventory_control_mode
      comment: "Revenue management control mode (e.g. LEG, SEGMENT, OD) indicating how inventory is being managed."
    - name: "revenue_management_class"
      expr: revenue_management_class
      comment: "RM class assignment for the flight, used to segment inventory performance by yield tier."
    - name: "codeshare_indicator"
      expr: codeshare_indicator
      comment: "Boolean flag indicating whether the flight operates under a codeshare arrangement."
    - name: "equipment_change_indicator"
      expr: equipment_change_indicator
      comment: "Boolean flag indicating an equipment swap has occurred, which may affect capacity and inventory."
    - name: "schedule_change_indicator"
      expr: schedule_change_indicator
      comment: "Boolean flag indicating a schedule change, relevant for re-accommodation and inventory resets."
  measures:
    - name: "total_flights"
      expr: COUNT(1)
      comment: "Total number of flight inventory records. Baseline volume measure for the fleet schedule."
    - name: "avg_load_factor_pct"
      expr: ROUND(AVG(CAST(load_factor_pct AS DOUBLE)), 2)
      comment: "Average load factor percentage across flights. Core capacity utilisation KPI used by Revenue Management and Network Planning to assess how well seats are being filled."
    - name: "avg_overbooking_factor"
      expr: ROUND(AVG(CAST(overbooking_factor AS DOUBLE)), 2)
      comment: "Average overbooking factor applied across flight inventory records. Tracks systemic overbooking exposure; high values signal elevated denied-boarding risk."
    - name: "flights_with_codeshare"
      expr: COUNT(CASE WHEN codeshare_indicator = TRUE THEN 1 END)
      comment: "Number of flights with active codeshare arrangements. Measures partnership inventory exposure for alliance and commercial teams."
    - name: "flights_with_equipment_change"
      expr: COUNT(CASE WHEN equipment_change_indicator = TRUE THEN 1 END)
      comment: "Number of flights that experienced an equipment change. Elevated counts indicate operational disruption impacting inventory integrity and customer experience."
    - name: "flights_with_schedule_change"
      expr: COUNT(CASE WHEN schedule_change_indicator = TRUE THEN 1 END)
      comment: "Number of flights with a schedule change. Tracks schedule instability that triggers inventory resets and customer re-accommodation costs."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`inventory_leg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leg-level inventory performance metrics covering load factor, overbooking, waitlist pressure, and codeshare/interline seat blocking. Used by Revenue Management, Operations, and Network Planning for leg-by-leg capacity steering."
  source: "`airlines_ecm`.`inventory`.`inventory_leg`"
  dimensions:
    - name: "destination_airport_code"
      expr: destination_airport_code
      comment: "IATA destination airport code for leg-level route segmentation."
    - name: "leg_status"
      expr: leg_status
      comment: "Current operational status of the inventory leg (e.g. ACTIVE, CANCELLED, CLOSED)."
    - name: "service_type_code"
      expr: service_type_code
      comment: "Service type (e.g. passenger, cargo, charter) for filtering leg inventory by operation type."
    - name: "operating_day_of_week"
      expr: operating_day_of_week
      comment: "Day of week the leg operates, enabling day-of-week demand pattern analysis."
    - name: "codeshare_indicator"
      expr: codeshare_indicator
      comment: "Boolean flag indicating whether the leg is operated under a codeshare arrangement."
    - name: "interline_indicator"
      expr: interline_indicator
      comment: "Boolean flag indicating interline connectivity on this leg, relevant for through-passenger inventory management."
    - name: "irop_indicator"
      expr: irop_indicator
      comment: "Boolean flag indicating an irregular operation (IROP) event, used to isolate disruption impact on inventory."
    - name: "wet_lease_indicator"
      expr: wet_lease_indicator
      comment: "Boolean flag indicating the leg is operated on a wet-lease aircraft, affecting capacity ownership and cost allocation."
    - name: "through_availability_indicator"
      expr: through_availability_indicator
      comment: "Boolean flag indicating through-availability is enabled, relevant for connecting itinerary inventory control."
  measures:
    - name: "total_legs"
      expr: COUNT(1)
      comment: "Total number of inventory legs. Baseline volume measure for network leg coverage."
    - name: "avg_load_factor"
      expr: ROUND(AVG(CAST(load_factor AS DOUBLE)), 2)
      comment: "Average load factor across inventory legs. Primary utilisation KPI for leg-level capacity management; directly informs re-fleeting and frequency decisions."
    - name: "avg_overbooking_factor"
      expr: ROUND(AVG(CAST(overbooking_factor AS DOUBLE)), 2)
      comment: "Average overbooking factor across legs. Tracks systemic overbooking levels; used by Revenue Management to calibrate denied-boarding risk vs. spoilage trade-off."
    - name: "avg_scheduled_block_hours"
      expr: ROUND(AVG(CAST(scheduled_block_hours AS DOUBLE)), 2)
      comment: "Average scheduled block hours per leg. Key input for fleet utilisation, crew planning, and cost-per-available-seat-kilometre calculations."
    - name: "total_scheduled_block_hours"
      expr: ROUND(SUM(CAST(scheduled_block_hours AS DOUBLE)), 2)
      comment: "Total scheduled block hours across all legs. Aggregate fleet utilisation measure used in capacity planning and cost management."
    - name: "legs_with_irop"
      expr: COUNT(CASE WHEN irop_indicator = TRUE THEN 1 END)
      comment: "Number of legs affected by irregular operations. Tracks operational disruption frequency; high counts signal reliability issues impacting customer satisfaction and recovery costs."
    - name: "irop_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN irop_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of legs affected by irregular operations. Normalised disruption rate for benchmarking operational reliability across routes and seasons."
    - name: "legs_with_codeshare"
      expr: COUNT(CASE WHEN codeshare_indicator = TRUE THEN 1 END)
      comment: "Number of legs with active codeshare arrangements. Measures partnership inventory exposure for commercial and alliance management."
    - name: "legs_with_wet_lease"
      expr: COUNT(CASE WHEN wet_lease_indicator = TRUE THEN 1 END)
      comment: "Number of legs operated on wet-lease aircraft. Tracks capacity sourced externally; elevated counts indicate fleet shortfall and higher unit costs."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`inventory_fare_class_bucket`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fare class bucket inventory metrics tracking booking limits, load factors, overbooking, and refundability mix across RBD buckets. Core Revenue Management tool for yield optimisation and bucket performance steering."
  source: "`airlines_ecm`.`inventory`.`fare_class_bucket`"
  dimensions:
    - name: "fare_basis_code"
      expr: fare_basis_code
      comment: "Fare basis code identifying the specific fare product associated with this bucket."
    - name: "fare_family_code"
      expr: fare_family_code
      comment: "Fare family grouping (e.g. BASIC, FLEX, BUSINESS) for aggregated family-level performance analysis."
    - name: "rbd_code"
      expr: rbd_code
      comment: "Reservation Booking Designator code (e.g. Y, B, M, Q) for bucket-level inventory analysis."
    - name: "bucket_status"
      expr: bucket_status
      comment: "Current status of the fare class bucket (e.g. OPEN, CLOSED, WAITLIST) for availability filtering."
    - name: "yield_class"
      expr: yield_class
      comment: "Yield class assignment for revenue stratification and RM decision support."
    - name: "allotment_type"
      expr: allotment_type
      comment: "Type of seat allotment (e.g. FREE_SALE, ALLOTMENT, GROUP) for inventory control segmentation."
    - name: "is_refundable"
      expr: is_refundable
      comment: "Boolean flag indicating whether the fare in this bucket is refundable. Drives revenue risk and liability analysis."
    - name: "is_changeable"
      expr: is_changeable
      comment: "Boolean flag indicating whether the fare allows changes. Relevant for flexibility mix and ancillary fee revenue."
    - name: "codeshare_indicator"
      expr: codeshare_indicator
      comment: "Boolean flag indicating whether this bucket is associated with a codeshare arrangement."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source system identifier (e.g. ALTEA, SABRE) for data lineage and reconciliation."
  measures:
    - name: "total_fare_class_buckets"
      expr: COUNT(1)
      comment: "Total number of active fare class bucket records. Baseline measure for inventory breadth across the fare structure."
    - name: "avg_load_factor_pct"
      expr: ROUND(AVG(CAST(load_factor_pct AS DOUBLE)), 2)
      comment: "Average load factor percentage across fare class buckets. Measures how effectively each RBD tier is being filled; low values in premium buckets signal yield dilution risk."
    - name: "avg_overbooking_factor"
      expr: ROUND(AVG(CAST(overbooking_factor AS DOUBLE)), 2)
      comment: "Average overbooking factor applied at the fare class bucket level. Tracks RM system overbooking calibration across yield tiers."
    - name: "avg_change_fee_amount"
      expr: ROUND(AVG(CAST(change_fee_amount AS DOUBLE)), 2)
      comment: "Average change fee amount across fare class buckets. Informs ancillary fee revenue potential and fare flexibility positioning."
    - name: "total_change_fee_revenue_exposure"
      expr: ROUND(SUM(CAST(change_fee_amount AS DOUBLE)), 2)
      comment: "Total change fee revenue exposure across all fare class buckets. Aggregate ancillary revenue opportunity from fare change fees."
    - name: "refundable_bucket_count"
      expr: COUNT(CASE WHEN is_refundable = TRUE THEN 1 END)
      comment: "Number of fare class buckets with refundable fares. Tracks refundability exposure; high counts in premium cabins indicate elevated revenue reversal risk."
    - name: "refundable_bucket_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_refundable = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of fare class buckets that are refundable. Key risk metric for Revenue Management; high refundable mix increases revenue volatility."
    - name: "open_bucket_count"
      expr: COUNT(CASE WHEN bucket_status = 'OPEN' THEN 1 END)
      comment: "Number of fare class buckets currently open for sale. Measures inventory availability breadth; declining open buckets signal tightening capacity."
    - name: "closed_bucket_count"
      expr: COUNT(CASE WHEN bucket_status = 'CLOSED' THEN 1 END)
      comment: "Number of fare class buckets closed to new bookings. Elevated closed bucket counts indicate high demand or aggressive RM closure policies."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`inventory_overbooking_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Overbooking control metrics tracking authorised overbooking levels, denied-boarding risk exposure, spoilage risk, and no-show/cancellation rate inputs. Critical for Revenue Management and Regulatory Compliance to balance revenue maximisation against passenger protection obligations."
  source: "`airlines_ecm`.`inventory`.`overbooking_control`"
  dimensions:
    - name: "departure_date"
      expr: departure_date
      comment: "Scheduled departure date for time-series analysis of overbooking control decisions."
    - name: "control_status"
      expr: control_status
      comment: "Current status of the overbooking control record (e.g. ACTIVE, OVERRIDDEN, EXPIRED)."
    - name: "day_of_week_pattern"
      expr: day_of_week_pattern
      comment: "Day-of-week operating pattern for seasonal and cyclical overbooking analysis."
    - name: "regulatory_market_code"
      expr: regulatory_market_code
      comment: "Regulatory market code identifying the jurisdiction governing denied-boarding compensation rules (e.g. EU261, DOT)."
    - name: "overbooking_model_version"
      expr: overbooking_model_version
      comment: "Version of the overbooking model used, enabling A/B comparison of model performance and calibration quality."
    - name: "rm_system_override_flag"
      expr: rm_system_override_flag
      comment: "Boolean flag indicating a manual override of the RM system recommendation. High override rates signal model distrust or exceptional market conditions."
    - name: "codeshare_inventory_flag"
      expr: codeshare_inventory_flag
      comment: "Boolean flag indicating the overbooking control applies to codeshare inventory, relevant for partner capacity management."
  measures:
    - name: "total_overbooking_controls"
      expr: COUNT(1)
      comment: "Total number of overbooking control records. Baseline measure for overbooking programme coverage across the network."
    - name: "avg_authorized_overbooking_pct"
      expr: ROUND(AVG(CAST(authorized_overbooking_pct AS DOUBLE)), 2)
      comment: "Average authorised overbooking percentage across all control records. Primary overbooking calibration KPI; directly governs denied-boarding risk and revenue recovery from no-shows."
    - name: "avg_historical_no_show_rate"
      expr: ROUND(AVG(CAST(historical_no_show_rate AS DOUBLE)), 2)
      comment: "Average historical no-show rate used as model input. Tracks no-show behaviour trends; rising rates justify higher overbooking authorisation."
    - name: "avg_cancellation_rate_input"
      expr: ROUND(AVG(CAST(cancellation_rate_input AS DOUBLE)), 2)
      comment: "Average cancellation rate input used in overbooking model calibration. Monitors cancellation trend assumptions; misalignment with actuals leads to spoilage or denied boardings."
    - name: "avg_go_show_rate_input"
      expr: ROUND(AVG(CAST(go_show_rate_input AS DOUBLE)), 2)
      comment: "Average go-show rate input used in overbooking model. Tracks walk-up demand assumptions; important for short-haul and leisure route calibration."
    - name: "avg_load_factor_forecast"
      expr: ROUND(AVG(CAST(load_factor_forecast AS DOUBLE)), 2)
      comment: "Average forecasted load factor across overbooking control records. Measures RM system demand forecast level; compared against actuals to assess forecast accuracy."
    - name: "avg_idb_compensation_exposure_usd"
      expr: ROUND(AVG(CAST(idb_compensation_exposure_usd AS DOUBLE)), 2)
      comment: "Average involuntary denied-boarding compensation exposure in USD per control record. Key financial risk metric for Regulatory Compliance and Revenue Management."
    - name: "total_idb_compensation_exposure_usd"
      expr: ROUND(SUM(CAST(idb_compensation_exposure_usd AS DOUBLE)), 2)
      comment: "Total involuntary denied-boarding compensation exposure in USD across all control records. Aggregate financial liability measure for executive risk reporting and regulatory compliance."
    - name: "avg_denied_boarding_risk_threshold"
      expr: ROUND(AVG(CAST(denied_boarding_risk_threshold AS DOUBLE)), 2)
      comment: "Average denied-boarding risk threshold set across overbooking controls. Tracks how aggressively the airline is willing to risk IDB events; used in policy calibration reviews."
    - name: "avg_spoilage_risk_threshold"
      expr: ROUND(AVG(CAST(spoilage_risk_threshold AS DOUBLE)), 2)
      comment: "Average spoilage risk threshold across overbooking controls. Measures tolerance for unsold seats; balances revenue recovery against passenger disruption risk."
    - name: "avg_avg_fare_value_usd"
      expr: ROUND(AVG(CAST(avg_fare_value_usd AS DOUBLE)), 2)
      comment: "Average fare value (USD) used in overbooking model inputs. Tracks the revenue value at stake per seat in overbooking decisions; higher fare values justify more conservative overbooking."
    - name: "rm_override_count"
      expr: COUNT(CASE WHEN rm_system_override_flag = TRUE THEN 1 END)
      comment: "Number of overbooking controls where the RM system recommendation was manually overridden. High override counts indicate model distrust or exceptional market conditions requiring investigation."
    - name: "rm_override_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rm_system_override_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of overbooking controls with manual RM overrides. Normalised override rate for benchmarking model adherence; used in RM system governance reviews."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`inventory_seat_availability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Seat availability snapshot metrics tracking load factor, overbooking, waitlist pressure, and distribution channel availability. Used by Revenue Management, Distribution, and Sales to monitor real-time and historical availability health."
  source: "`airlines_ecm`.`inventory`.`seat_availability`"
  dimensions:
    - name: "availability_status"
      expr: availability_status
      comment: "Current availability status of the seat inventory snapshot (e.g. OPEN, CLOSED, WAITLIST)."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel through which availability is published (e.g. GDS, NDC, DIRECT) for channel-level inventory analysis."
    - name: "gds_provider_code"
      expr: gds_provider_code
      comment: "GDS provider code (e.g. 1A, 1S, 1G) for GDS-specific availability performance analysis."
    - name: "inventory_control_mode"
      expr: inventory_control_mode
      comment: "Inventory control mode (e.g. LEG, SEGMENT, OD) indicating the RM control methodology applied."
    - name: "operating_carrier_code"
      expr: operating_carrier_code
      comment: "IATA operating carrier code for multi-carrier availability analysis."
    - name: "marketing_carrier_code"
      expr: marketing_carrier_code
      comment: "IATA marketing carrier code for codeshare and interline availability segmentation."
    - name: "is_current_snapshot"
      expr: is_current_snapshot
      comment: "Boolean flag indicating whether this record represents the current availability snapshot, used to filter for live vs. historical analysis."
    - name: "is_interline_eligible"
      expr: is_interline_eligible
      comment: "Boolean flag indicating interline eligibility, relevant for through-fare and interline revenue analysis."
    - name: "codeshare_indicator"
      expr: codeshare_indicator
      comment: "Boolean flag indicating codeshare availability, used to segment partner vs. own-metal inventory."
    - name: "rm_decision_code"
      expr: rm_decision_code
      comment: "Revenue management decision code driving the availability action (e.g. CLOSE, OPEN, PROTECT) for RM decision audit."
    - name: "snapshot_trigger"
      expr: snapshot_trigger
      comment: "Event that triggered the availability snapshot (e.g. BOOKING, CANCELLATION, RM_UPDATE) for change-driver analysis."
  measures:
    - name: "total_availability_snapshots"
      expr: COUNT(1)
      comment: "Total number of seat availability snapshot records. Baseline volume measure for availability monitoring coverage."
    - name: "avg_load_factor_pct"
      expr: ROUND(AVG(CAST(load_factor_pct AS DOUBLE)), 2)
      comment: "Average load factor percentage across availability snapshots. Core utilisation KPI for real-time and historical capacity management."
    - name: "avg_overbooking_factor"
      expr: ROUND(AVG(CAST(overbooking_factor AS DOUBLE)), 2)
      comment: "Average overbooking factor across availability snapshots. Tracks overbooking levels at the availability record level; used to monitor RM system behaviour."
    - name: "closed_availability_count"
      expr: COUNT(CASE WHEN availability_status = 'CLOSED' THEN 1 END)
      comment: "Number of availability snapshots in CLOSED status. Elevated counts indicate tight inventory or aggressive RM closure; impacts revenue opportunity and customer booking experience."
    - name: "closed_availability_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN availability_status = 'CLOSED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of availability snapshots in CLOSED status. Normalised closure rate for benchmarking availability health across channels and routes."
    - name: "interline_eligible_snapshot_count"
      expr: COUNT(CASE WHEN is_interline_eligible = TRUE THEN 1 END)
      comment: "Number of availability snapshots eligible for interline booking. Measures interline inventory exposure and partnership revenue opportunity."
    - name: "codeshare_snapshot_count"
      expr: COUNT(CASE WHEN codeshare_indicator = TRUE THEN 1 END)
      comment: "Number of availability snapshots associated with codeshare arrangements. Tracks partner inventory availability volume for commercial and alliance reporting."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`inventory_codeshare_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Codeshare seat allocation metrics tracking revenue share, overbooking factors, and allocation status across partner agreements. Used by Alliance Management, Commercial, and Revenue Management to govern partner inventory performance and bilateral agreement compliance."
  source: "`airlines_ecm`.`inventory`.`codeshare_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the codeshare allocation (e.g. ACTIVE, EXPIRED, SUSPENDED) for filtering live vs. historical allocations."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of codeshare allocation (e.g. FREE_FLOW, BLOCK_SPACE, PRORATE) for commercial structure analysis."
    - name: "origin_iata_code"
      expr: origin_iata_code
      comment: "IATA origin airport code for route-level codeshare allocation analysis."
    - name: "destination_iata_code"
      expr: destination_iata_code
      comment: "IATA destination airport code for route-level codeshare allocation analysis."
    - name: "marketing_flight_number"
      expr: marketing_flight_number
      comment: "Marketing carrier flight number for partner-branded inventory analysis."
    - name: "gds_availability_indicator"
      expr: gds_availability_indicator
      comment: "Boolean flag indicating whether the codeshare allocation is visible in GDS availability displays."
    - name: "interline_indicator"
      expr: interline_indicator
      comment: "Boolean flag indicating interline connectivity on this codeshare allocation."
    - name: "flight_date"
      expr: flight_date
      comment: "Flight date for the codeshare allocation, enabling time-series analysis of partner inventory performance."
  measures:
    - name: "total_codeshare_allocations"
      expr: COUNT(1)
      comment: "Total number of codeshare allocation records. Baseline measure for partner inventory programme scale."
    - name: "avg_overbooking_factor"
      expr: ROUND(AVG(CAST(overbooking_factor AS DOUBLE)), 2)
      comment: "Average overbooking factor applied to codeshare allocations. Tracks partner inventory overbooking levels; misalignment with own-metal overbooking creates denied-boarding risk."
    - name: "avg_revenue_share_percentage"
      expr: ROUND(AVG(CAST(revenue_share_percentage AS DOUBLE)), 2)
      comment: "Average revenue share percentage across codeshare allocations. Core commercial KPI for alliance and partnership profitability; directly informs bilateral agreement renegotiations."
    - name: "total_revenue_share_percentage_sum"
      expr: ROUND(SUM(CAST(revenue_share_percentage AS DOUBLE)), 2)
      comment: "Sum of revenue share percentages across all codeshare allocations. Aggregate commercial exposure measure for portfolio-level partner revenue analysis."
    - name: "gds_visible_allocation_count"
      expr: COUNT(CASE WHEN gds_availability_indicator = TRUE THEN 1 END)
      comment: "Number of codeshare allocations visible in GDS displays. Measures distribution reach of partner inventory; low GDS visibility reduces partner booking potential."
    - name: "gds_visibility_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gds_availability_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of codeshare allocations visible in GDS. Normalised distribution visibility rate for partner inventory; used in distribution strategy reviews."
    - name: "active_allocation_count"
      expr: COUNT(CASE WHEN allocation_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active codeshare allocations. Tracks live partner inventory programme scale; declining counts may signal agreement terminations or capacity reductions."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`inventory_group_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group booking block metrics tracking group fare revenue, deposit compliance, seat confirmation rates, and free-seat ratio. Used by Group Sales, Revenue Management, and Finance to manage group inventory profitability and cash flow."
  source: "`airlines_ecm`.`inventory`.`group_block`"
  dimensions:
    - name: "block_status"
      expr: block_status
      comment: "Current status of the group block (e.g. TENTATIVE, CONFIRMED, CANCELLED) for pipeline and conversion analysis."
    - name: "group_type"
      expr: group_type
      comment: "Type of group booking (e.g. TOUR, CORPORATE, INCENTIVE, SPORTS) for segment-level group revenue analysis."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel through which the group block was booked (e.g. DIRECT, AGENCY, ONLINE) for channel performance analysis."
    - name: "operating_carrier_code"
      expr: operating_carrier_code
      comment: "Operating carrier code for the group block, relevant for codeshare and interline group bookings."
    - name: "fare_currency_code"
      expr: fare_currency_code
      comment: "Currency code for the group fare, used for multi-currency revenue analysis and FX exposure tracking."
    - name: "deposit_required"
      expr: deposit_required
      comment: "Boolean flag indicating whether a deposit is required for the group block. Used to segment deposit-managed vs. free-sale group inventory."
    - name: "deposit_paid"
      expr: deposit_paid
      comment: "Boolean flag indicating whether the deposit has been paid. Used to track deposit compliance and cash flow risk."
    - name: "codeshare_indicator"
      expr: codeshare_indicator
      comment: "Boolean flag indicating whether the group block is on a codeshare flight."
    - name: "overbooking_eligible"
      expr: overbooking_eligible
      comment: "Boolean flag indicating whether the group block is eligible for overbooking, relevant for RM capacity management."
  measures:
    - name: "total_group_blocks"
      expr: COUNT(1)
      comment: "Total number of group block records. Baseline measure for group booking programme volume."
    - name: "total_group_fare_revenue"
      expr: ROUND(SUM(CAST(group_fare_amount AS DOUBLE)), 2)
      comment: "Total group fare revenue across all group blocks. Primary group revenue KPI for Sales and Finance; directly informs group pricing strategy and revenue contribution analysis."
    - name: "avg_group_fare_amount"
      expr: ROUND(AVG(CAST(group_fare_amount AS DOUBLE)), 2)
      comment: "Average group fare amount per block. Tracks group yield level; compared against individual fare yields to assess group pricing competitiveness."
    - name: "total_deposit_amount"
      expr: ROUND(SUM(CAST(deposit_amount AS DOUBLE)), 2)
      comment: "Total deposit amount collected across group blocks. Measures cash flow secured from group bookings; key Finance metric for working capital management."
    - name: "avg_free_seat_ratio"
      expr: ROUND(AVG(CAST(free_seat_ratio AS DOUBLE)), 2)
      comment: "Average free seat ratio (complimentary seats per group) across group blocks. Tracks concession cost of group contracts; high ratios reduce effective group yield."
    - name: "deposit_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN deposit_required = TRUE AND deposit_paid = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN deposit_required = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of deposit-required group blocks where the deposit has been paid. Tracks group booking cash flow compliance; low rates signal revenue risk and require proactive follow-up."
    - name: "confirmed_group_blocks"
      expr: COUNT(CASE WHEN block_status = 'CONFIRMED' THEN 1 END)
      comment: "Number of confirmed group blocks. Tracks confirmed group inventory commitment; used in capacity planning and revenue forecasting."
    - name: "cancelled_group_blocks"
      expr: COUNT(CASE WHEN block_status = 'CANCELLED' THEN 1 END)
      comment: "Number of cancelled group blocks. Tracks group booking attrition; elevated cancellations signal market softness or pricing issues requiring commercial response."
    - name: "group_cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN block_status = 'CANCELLED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of group blocks that have been cancelled. Normalised group attrition rate for benchmarking group sales quality and contract terms effectiveness."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`inventory_waitlist_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waitlist demand metrics tracking waitlist volume, clearance rates, FFP tier distribution, and upgrade activity. Used by Revenue Management, Customer Experience, and Loyalty to manage unmet demand, upgrade inventory, and high-value passenger prioritisation."
  source: "`airlines_ecm`.`inventory`.`waitlist_entry`"
  dimensions:
    - name: "waitlist_status"
      expr: waitlist_status
      comment: "Current status of the waitlist entry (e.g. ACTIVE, CLEARED, EXPIRED, CANCELLED) for demand pipeline analysis."
    - name: "waitlist_reason"
      expr: waitlist_reason
      comment: "Reason for waitlisting (e.g. CABIN_FULL, FARE_CLASS_CLOSED, UPGRADE_REQUEST) for root-cause demand analysis."
    - name: "cabin_code"
      expr: cabin_code
      comment: "Cabin code for the waitlisted seat request, enabling cabin-level unmet demand analysis."
    - name: "booking_class"
      expr: booking_class
      comment: "Booking class (RBD) for the waitlist entry, used for fare class level demand pressure analysis."
    - name: "ffp_tier"
      expr: ffp_tier
      comment: "Frequent flyer programme tier of the waitlisted passenger (e.g. GOLD, PLATINUM, SILVER). Critical for prioritising high-value passenger clearance and loyalty programme management."
    - name: "clearance_method"
      expr: clearance_method
      comment: "Method by which the waitlist entry was cleared (e.g. CANCELLATION, UPGRADE, CAPACITY_INCREASE) for clearance driver analysis."
    - name: "origin_airport_code"
      expr: origin_airport_code
      comment: "IATA origin airport code for route-level waitlist demand analysis."
    - name: "destination_airport_code"
      expr: destination_airport_code
      comment: "IATA destination airport code for route-level waitlist demand analysis."
    - name: "operating_carrier_code"
      expr: operating_carrier_code
      comment: "Operating carrier code for the waitlisted flight, relevant for codeshare waitlist management."
    - name: "is_codeshare"
      expr: is_codeshare
      comment: "Boolean flag indicating whether the waitlist entry is on a codeshare flight."
    - name: "notification_sent"
      expr: notification_sent
      comment: "Boolean flag indicating whether the passenger has been notified of their waitlist status. Tracks customer communication compliance."
    - name: "revenue_management_override"
      expr: revenue_management_override
      comment: "Boolean flag indicating a manual RM override was applied to the waitlist entry. Tracks exception handling volume."
    - name: "flight_date"
      expr: flight_date
      comment: "Flight date for the waitlist entry, enabling time-series analysis of waitlist demand patterns."
  measures:
    - name: "total_waitlist_entries"
      expr: COUNT(1)
      comment: "Total number of waitlist entries. Baseline measure for unmet demand volume across the network."
    - name: "active_waitlist_entries"
      expr: COUNT(CASE WHEN waitlist_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active waitlist entries. Measures live unmet demand; high active counts signal capacity shortfall and revenue opportunity from additional flights or re-fleeting."
    - name: "cleared_waitlist_entries"
      expr: COUNT(CASE WHEN waitlist_status = 'CLEARED' THEN 1 END)
      comment: "Number of waitlist entries successfully cleared. Measures demand fulfilment success; used to assess inventory management effectiveness."
    - name: "waitlist_clearance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN waitlist_status = 'CLEARED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of waitlist entries that were successfully cleared. Core service quality KPI; low clearance rates indicate persistent capacity shortfalls on high-demand routes."
    - name: "elite_tier_waitlist_entries"
      expr: COUNT(CASE WHEN ffp_tier IN ('GOLD', 'PLATINUM', 'DIAMOND', 'ELITE') THEN 1 END)
      comment: "Number of waitlist entries from elite-tier FFP members. Tracks high-value passenger unmet demand; elevated counts risk loyalty programme satisfaction and premium revenue."
    - name: "elite_tier_waitlist_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ffp_tier IN ('GOLD', 'PLATINUM', 'DIAMOND', 'ELITE') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of waitlist entries from elite-tier FFP members. Normalised high-value passenger unmet demand rate; used in loyalty programme and inventory prioritisation reviews."
    - name: "upgrade_waitlist_entries"
      expr: COUNT(CASE WHEN waitlist_reason = 'UPGRADE_REQUEST' THEN 1 END)
      comment: "Number of waitlist entries driven by upgrade requests. Measures upgrade demand pressure; informs upgrade inventory allocation and ancillary upgrade revenue opportunity."
    - name: "notification_pending_count"
      expr: COUNT(CASE WHEN notification_sent = FALSE AND waitlist_status = 'CLEARED' THEN 1 END)
      comment: "Number of cleared waitlist entries where the passenger has not yet been notified. Tracks customer communication gaps; unnotified cleared entries risk no-shows and seat spoilage."
    - name: "rm_override_waitlist_count"
      expr: COUNT(CASE WHEN revenue_management_override = TRUE THEN 1 END)
      comment: "Number of waitlist entries with a manual RM override applied. Tracks exception handling volume; high counts indicate model limitations or exceptional demand scenarios requiring review."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`inventory_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Segment-level inventory metrics tracking load factor, overbooking rates, waitlist pressure, and availability across origin-destination pairs. Used by Revenue Management, Network Planning, and Sales to optimise segment-level capacity and yield."
  source: "`airlines_ecm`.`inventory`.`segment`"
  dimensions:
    - name: "origin_airport_code"
      expr: origin_airport_code
      comment: "IATA origin airport code for O&D segment analysis."
    - name: "destination_airport_code"
      expr: destination_airport_code
      comment: "IATA destination airport code for O&D segment analysis."
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment inventory record (e.g. OPEN, CLOSED, CANCELLED)."
    - name: "segment_type"
      expr: segment_type
      comment: "Type of segment (e.g. LOCAL, THROUGH, CONNECTING) for itinerary-level inventory analysis."
    - name: "booking_class"
      expr: booking_class
      comment: "Booking class (RBD) for the segment, enabling fare class level inventory performance analysis."
    - name: "fare_basis_code"
      expr: fare_basis_code
      comment: "Fare basis code for the segment, used for fare product level inventory analysis."
    - name: "operating_carrier_code"
      expr: operating_carrier_code
      comment: "IATA operating carrier code for multi-carrier segment analysis."
    - name: "marketing_carrier_code"
      expr: marketing_carrier_code
      comment: "IATA marketing carrier code for codeshare segment analysis."
    - name: "availability_control_method"
      expr: availability_control_method
      comment: "Availability control method (e.g. LEG, SEGMENT, OD) indicating the RM control methodology applied at segment level."
    - name: "interline_eligible"
      expr: interline_eligible
      comment: "Boolean flag indicating interline eligibility for the segment."
    - name: "through_availability_flag"
      expr: through_availability_flag
      comment: "Boolean flag indicating through-availability is enabled for connecting itineraries."
    - name: "departure_date"
      expr: departure_date
      comment: "Scheduled departure date for time-series segment inventory analysis."
  measures:
    - name: "total_segments"
      expr: COUNT(1)
      comment: "Total number of segment inventory records. Baseline measure for O&D inventory coverage."
    - name: "avg_load_factor"
      expr: ROUND(AVG(CAST(load_factor AS DOUBLE)), 2)
      comment: "Average load factor across segments. Core segment-level utilisation KPI; used by Revenue Management and Network Planning to identify under- and over-performing O&D pairs."
    - name: "avg_overbooking_rate"
      expr: ROUND(AVG(CAST(overbooking_rate AS DOUBLE)), 2)
      comment: "Average overbooking rate applied at the segment level. Tracks RM overbooking calibration across O&D pairs; used to manage denied-boarding risk on specific routes."
    - name: "closed_segment_count"
      expr: COUNT(CASE WHEN segment_status = 'CLOSED' THEN 1 END)
      comment: "Number of segments closed to new bookings. Elevated counts on key O&D pairs signal capacity constraints and potential revenue leakage."
    - name: "closed_segment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN segment_status = 'CLOSED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of segments closed to new bookings. Normalised closure rate for benchmarking availability health across the O&D network."
    - name: "interline_eligible_segment_count"
      expr: COUNT(CASE WHEN interline_eligible = TRUE THEN 1 END)
      comment: "Number of segments eligible for interline booking. Measures interline network connectivity; used by Commercial and Alliance teams to assess partnership revenue opportunity."
    - name: "through_availability_segment_count"
      expr: COUNT(CASE WHEN through_availability_flag = TRUE THEN 1 END)
      comment: "Number of segments with through-availability enabled. Tracks connecting itinerary inventory exposure; relevant for hub connectivity and connecting passenger revenue management."
$$;