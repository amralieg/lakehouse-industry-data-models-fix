-- Metric views for domain: event | Business: Sports Entertainment | Version: 1 | Generated on: 2026-05-09 01:35:39

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`event_fixture`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core event fixture metrics tracking scheduled games, matches, and events with attendance, broadcast eligibility, and operational outcomes"
  source: "`sports_entertainment_ecm`.`event`.`fixture`"
  dimensions:
    - name: "event_date"
      expr: event_date
      comment: "Date of the scheduled event"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month of the event for monthly aggregation"
    - name: "event_classification"
      expr: event_classification
      comment: "Classification of the event (e.g., regular season, playoff, exhibition)"
    - name: "event_tier"
      expr: event_tier
      comment: "Tier or importance level of the event"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the fixture (scheduled, in-progress, completed, cancelled)"
    - name: "result_status"
      expr: result_status
      comment: "Status of the result (final, provisional, under review)"
    - name: "is_broadcast_eligible"
      expr: is_broadcast_eligible
      comment: "Whether the fixture is eligible for broadcast"
    - name: "is_ppv"
      expr: is_ppv
      comment: "Whether the fixture is pay-per-view"
    - name: "is_neutral_site"
      expr: is_neutral_site
      comment: "Whether the fixture is at a neutral venue"
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition during the event"
    - name: "surface_type"
      expr: surface_type
      comment: "Type of playing surface"
    - name: "var_used"
      expr: var_used
      comment: "Whether video assistant referee technology was used"
  measures:
    - name: "total_fixtures"
      expr: COUNT(1)
      comment: "Total number of fixtures scheduled"
    - name: "total_attendance"
      expr: SUM(CAST(actual_attendance AS BIGINT))
      comment: "Total attendance across all fixtures"
    - name: "avg_attendance_per_fixture"
      expr: AVG(CAST(actual_attendance AS BIGINT))
      comment: "Average attendance per fixture"
    - name: "broadcast_eligible_fixtures"
      expr: SUM(CASE WHEN is_broadcast_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of fixtures eligible for broadcast"
    - name: "ppv_fixtures"
      expr: SUM(CASE WHEN is_ppv = TRUE THEN 1 ELSE 0 END)
      comment: "Count of pay-per-view fixtures"
    - name: "broadcast_eligible_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_broadcast_eligible = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of fixtures eligible for broadcast"
    - name: "capacity_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_attendance AS BIGINT)) / NULLIF(SUM(CAST(attendance_capacity AS BIGINT)), 0), 2)
      comment: "Overall capacity utilization rate across all fixtures"
    - name: "neutral_site_fixtures"
      expr: SUM(CASE WHEN is_neutral_site = TRUE THEN 1 ELSE 0 END)
      comment: "Count of fixtures held at neutral venues"
    - name: "var_usage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN var_used = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of fixtures where VAR technology was used"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`event_attendance_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed attendance metrics tracking ticket sales, capacity utilization, and fan engagement at events"
  source: "`sports_entertainment_ecm`.`event`.`attendance_record`"
  dimensions:
    - name: "event_date"
      expr: event_date
      comment: "Date of the event"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month of the event for monthly aggregation"
    - name: "attendance_type"
      expr: attendance_type
      comment: "Type of attendance (e.g., paid, complimentary, season ticket)"
    - name: "attendance_classification"
      expr: attendance_classification
      comment: "Classification of attendance record"
    - name: "ticket_category"
      expr: ticket_category
      comment: "Category of ticket (e.g., general admission, VIP, premium)"
    - name: "seat_section"
      expr: seat_section
      comment: "Seating section within the venue"
    - name: "sellout_flag"
      expr: sellout_flag
      comment: "Whether the event was a sellout"
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition during the event"
    - name: "weather_impact_flag"
      expr: weather_impact_flag
      comment: "Whether weather impacted attendance"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of attendance reconciliation"
    - name: "record_status"
      expr: record_status
      comment: "Status of the attendance record"
  measures:
    - name: "total_attendance_records"
      expr: COUNT(1)
      comment: "Total number of attendance records"
    - name: "total_paid_attendance"
      expr: SUM(CAST(paid_attendance AS BIGINT))
      comment: "Total paid attendance across all events"
    - name: "total_comp_tickets"
      expr: SUM(CAST(comp_tickets_used AS BIGINT))
      comment: "Total complimentary tickets used"
    - name: "total_season_ticket_holders"
      expr: SUM(CAST(season_ticket_holder_count AS BIGINT))
      comment: "Total season ticket holders attending"
    - name: "total_vip_attendance"
      expr: SUM(CAST(vip_attendance AS BIGINT))
      comment: "Total VIP attendance"
    - name: "avg_capacity_utilization"
      expr: AVG(CAST(capacity_utilization_pct AS DOUBLE))
      comment: "Average capacity utilization percentage"
    - name: "avg_engagement_score"
      expr: AVG(CAST(engagement_score AS DOUBLE))
      comment: "Average fan engagement score"
    - name: "sellout_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sellout_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events that were sellouts"
    - name: "no_show_rate"
      expr: ROUND(100.0 * SUM(CAST(no_show_count AS BIGINT)) / NULLIF(SUM(CAST(tickets_sold AS BIGINT)), 0), 2)
      comment: "Percentage of tickets sold that resulted in no-shows"
    - name: "total_loyalty_points_earned"
      expr: SUM(CAST(loyalty_points_earned AS DOUBLE))
      comment: "Total loyalty points earned by fans"
    - name: "weather_impact_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN weather_impact_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events impacted by weather"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`event_broadcast_window`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Broadcast rights and media distribution metrics tracking viewership, rights fees, and territorial coverage"
  source: "`sports_entertainment_ecm`.`event`.`broadcast_window`"
  dimensions:
    - name: "broadcast_kickoff_date"
      expr: DATE(broadcast_kickoff_timestamp)
      comment: "Date of broadcast kickoff"
    - name: "broadcast_month"
      expr: DATE_TRUNC('MONTH', broadcast_kickoff_timestamp)
      comment: "Month of broadcast for monthly aggregation"
    - name: "window_type"
      expr: window_type
      comment: "Type of broadcast window (e.g., live, delayed, highlights)"
    - name: "window_status"
      expr: window_status
      comment: "Status of the broadcast window"
    - name: "broadcast_format"
      expr: broadcast_format
      comment: "Format of the broadcast (e.g., HD, 4K, standard)"
    - name: "territory_region"
      expr: territory_region
      comment: "Geographic region for broadcast rights"
    - name: "territory_country_code"
      expr: territory_country_code
      comment: "Country code for broadcast territory"
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Whether the broadcast rights are exclusive"
    - name: "is_free_to_air"
      expr: is_free_to_air
      comment: "Whether the broadcast is free-to-air"
    - name: "is_ppv"
      expr: is_ppv
      comment: "Whether the broadcast is pay-per-view"
    - name: "exclusivity_type"
      expr: exclusivity_type
      comment: "Type of exclusivity (e.g., full, partial, non-exclusive)"
    - name: "coverage_status"
      expr: coverage_status
      comment: "Status of broadcast coverage"
  measures:
    - name: "total_broadcast_windows"
      expr: COUNT(1)
      comment: "Total number of broadcast windows scheduled"
    - name: "total_rights_fee_revenue"
      expr: SUM(CAST(rights_fee_amount AS DOUBLE))
      comment: "Total broadcast rights fee revenue"
    - name: "avg_rights_fee_per_window"
      expr: AVG(CAST(rights_fee_amount AS DOUBLE))
      comment: "Average rights fee per broadcast window"
    - name: "total_rights_fee_allocation"
      expr: SUM(CAST(rights_fee_allocation AS DOUBLE))
      comment: "Total allocated rights fees"
    - name: "total_expected_viewership"
      expr: SUM(CAST(expected_viewership AS DOUBLE))
      comment: "Total expected viewership across all windows"
    - name: "avg_expected_viewership"
      expr: AVG(CAST(expected_viewership AS DOUBLE))
      comment: "Average expected viewership per window"
    - name: "exclusive_broadcast_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_exclusive = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of broadcast windows with exclusive rights"
    - name: "ppv_broadcast_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_ppv = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of broadcast windows that are pay-per-view"
    - name: "free_to_air_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_free_to_air = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of broadcast windows that are free-to-air"
    - name: "blackout_applicable_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN blackout_applicable = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of windows subject to broadcast blackouts"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`event_tournament`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tournament financial and operational metrics tracking budget performance, prize pools, and participant engagement"
  source: "`sports_entertainment_ecm`.`event`.`tournament`"
  dimensions:
    - name: "start_date"
      expr: start_date
      comment: "Tournament start date"
    - name: "end_date"
      expr: end_date
      comment: "Tournament end date"
    - name: "tournament_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month of tournament start for monthly aggregation"
    - name: "tournament_status"
      expr: tournament_status
      comment: "Current status of the tournament"
    - name: "format_type"
      expr: format_type
      comment: "Format of the tournament (e.g., knockout, round-robin, hybrid)"
    - name: "sport_type"
      expr: sport_type
      comment: "Type of sport for the tournament"
    - name: "age_category"
      expr: age_category
      comment: "Age category of participants"
    - name: "gender_category"
      expr: gender_category
      comment: "Gender category of participants"
    - name: "host_country_code"
      expr: host_country_code
      comment: "Country code of the host nation"
    - name: "host_region"
      expr: host_region
      comment: "Geographic region hosting the tournament"
    - name: "recurrence_type"
      expr: recurrence_type
      comment: "Recurrence pattern (e.g., annual, biennial, quadrennial)"
    - name: "sustainability_certified"
      expr: sustainability_certified
      comment: "Whether the tournament is sustainability certified"
  measures:
    - name: "total_tournaments"
      expr: COUNT(1)
      comment: "Total number of tournaments"
    - name: "total_planned_budget"
      expr: SUM(CAST(planned_amount AS DOUBLE))
      comment: "Total planned budget across all tournaments"
    - name: "total_revised_budget"
      expr: SUM(CAST(revised_amount AS DOUBLE))
      comment: "Total revised budget across all tournaments"
    - name: "total_actual_spend"
      expr: SUM(CAST(actuals_amount AS DOUBLE))
      comment: "Total actual spend across all tournaments"
    - name: "avg_budget_per_tournament"
      expr: AVG(CAST(planned_amount AS DOUBLE))
      comment: "Average planned budget per tournament"
    - name: "budget_variance"
      expr: SUM((actuals_amount) - (planned_amount))
      comment: "Total budget variance (actual minus planned)"
    - name: "budget_variance_rate"
      expr: ROUND(100.0 * (SUM(CAST(actuals_amount AS DOUBLE)) - SUM(CAST(planned_amount AS DOUBLE))) / NULLIF(SUM(CAST(planned_amount AS DOUBLE)), 0), 2)
      comment: "Budget variance as percentage of planned budget"
    - name: "total_prize_pool"
      expr: SUM(CAST(prize_pool_amount AS DOUBLE))
      comment: "Total prize pool across all tournaments"
    - name: "avg_prize_pool"
      expr: AVG(CAST(prize_pool_amount AS DOUBLE))
      comment: "Average prize pool per tournament"
    - name: "total_participants"
      expr: SUM(CAST(total_participants AS BIGINT))
      comment: "Total participants across all tournaments"
    - name: "avg_participants_per_tournament"
      expr: AVG(CAST(total_participants AS BIGINT))
      comment: "Average number of participants per tournament"
    - name: "total_matches_scheduled"
      expr: SUM(CAST(total_matches_scheduled AS BIGINT))
      comment: "Total matches scheduled across all tournaments"
    - name: "sustainability_certification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sustainability_certified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tournaments with sustainability certification"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`event_post_event_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Post-event financial and operational performance metrics tracking revenue, attendance, and compliance outcomes"
  source: "`sports_entertainment_ecm`.`event`.`post_event_report`"
  dimensions:
    - name: "event_date"
      expr: event_date
      comment: "Date of the event"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month of the event for monthly aggregation"
    - name: "report_type"
      expr: report_type
      comment: "Type of post-event report"
    - name: "report_status"
      expr: report_status
      comment: "Status of the report (draft, final, approved)"
    - name: "financial_reconciliation_status"
      expr: financial_reconciliation_status
      comment: "Status of financial reconciliation"
    - name: "sponsorship_fulfillment_status"
      expr: sponsorship_fulfillment_status
      comment: "Status of sponsorship fulfillment obligations"
    - name: "compliance_checklist_complete"
      expr: compliance_checklist_complete
      comment: "Whether compliance checklist is complete"
    - name: "major_incident_flag"
      expr: major_incident_flag
      comment: "Whether a major incident occurred"
    - name: "weather_condition_code"
      expr: weather_condition_code
      comment: "Weather condition code during the event"
  measures:
    - name: "total_post_event_reports"
      expr: COUNT(1)
      comment: "Total number of post-event reports"
    - name: "total_gross_gate_revenue"
      expr: SUM(CAST(gross_gate_revenue AS DOUBLE))
      comment: "Total gross gate revenue across all events"
    - name: "total_net_gate_revenue"
      expr: SUM(CAST(net_gate_revenue AS DOUBLE))
      comment: "Total net gate revenue across all events"
    - name: "total_concession_revenue"
      expr: SUM(CAST(concession_gross_revenue AS DOUBLE))
      comment: "Total concession revenue"
    - name: "total_merchandise_revenue"
      expr: SUM(CAST(merchandise_gross_revenue AS DOUBLE))
      comment: "Total merchandise revenue"
    - name: "avg_gross_gate_revenue"
      expr: AVG(CAST(gross_gate_revenue AS DOUBLE))
      comment: "Average gross gate revenue per event"
    - name: "avg_net_gate_revenue"
      expr: AVG(CAST(net_gate_revenue AS DOUBLE))
      comment: "Average net gate revenue per event"
    - name: "total_event_revenue"
      expr: SUM(gross_gate_revenue + concession_gross_revenue + merchandise_gross_revenue)
      comment: "Total combined revenue from gate, concessions, and merchandise"
    - name: "avg_capacity_utilization"
      expr: AVG(CAST(capacity_utilization_pct AS DOUBLE))
      comment: "Average capacity utilization percentage"
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score"
    - name: "total_broadcast_viewership"
      expr: SUM(CAST(broadcast_viewership_estimate AS DOUBLE))
      comment: "Total estimated broadcast viewership"
    - name: "avg_broadcast_viewership"
      expr: AVG(CAST(broadcast_viewership_estimate AS DOUBLE))
      comment: "Average broadcast viewership per event"
    - name: "major_incident_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN major_incident_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events with major incidents"
    - name: "compliance_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_checklist_complete = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events with completed compliance checklists"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`event_pricing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event pricing strategy and revenue optimization metrics tracking dynamic pricing, discounts, and revenue share"
  source: "`sports_entertainment_ecm`.`event`.`pricing`"
  dimensions:
    - name: "on_sale_date"
      expr: DATE(on_sale_timestamp)
      comment: "Date tickets went on sale"
    - name: "on_sale_month"
      expr: DATE_TRUNC('MONTH', on_sale_timestamp)
      comment: "Month tickets went on sale"
    - name: "pricing_status"
      expr: pricing_status
      comment: "Status of the pricing configuration"
    - name: "pricing_tier"
      expr: pricing_tier
      comment: "Pricing tier (e.g., premium, standard, value)"
    - name: "strategy_type"
      expr: strategy_type
      comment: "Type of pricing strategy (e.g., fixed, dynamic, surge)"
    - name: "event_classification"
      expr: event_classification
      comment: "Classification of the event"
    - name: "dynamic_pricing_enabled"
      expr: dynamic_pricing_enabled
      comment: "Whether dynamic pricing is enabled"
    - name: "ppv_flag"
      expr: ppv_flag
      comment: "Whether the event is pay-per-view"
    - name: "presale_enabled"
      expr: presale_enabled
      comment: "Whether presale is enabled"
    - name: "season_ticket_applicable"
      expr: season_ticket_applicable
      comment: "Whether season tickets are applicable"
    - name: "rivalry_flag"
      expr: rivalry_flag
      comment: "Whether the event is a rivalry game"
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of the week for the event"
  measures:
    - name: "total_pricing_configs"
      expr: COUNT(1)
      comment: "Total number of pricing configurations"
    - name: "avg_base_ticket_price"
      expr: AVG(CAST(base_ticket_price AS DOUBLE))
      comment: "Average base ticket price"
    - name: "avg_max_ticket_price"
      expr: AVG(CAST(max_ticket_price AS DOUBLE))
      comment: "Average maximum ticket price"
    - name: "avg_ppv_price"
      expr: AVG(CAST(ppv_price AS DOUBLE))
      comment: "Average pay-per-view price"
    - name: "avg_service_fee"
      expr: AVG(CAST(service_fee_amount AS DOUBLE))
      comment: "Average service fee per ticket"
    - name: "avg_facility_fee"
      expr: AVG(CAST(facility_fee_amount AS DOUBLE))
      comment: "Average facility fee per ticket"
    - name: "avg_early_bird_discount"
      expr: AVG(CAST(early_bird_discount_pct AS DOUBLE))
      comment: "Average early bird discount percentage"
    - name: "avg_group_discount"
      expr: AVG(CAST(group_discount_pct AS DOUBLE))
      comment: "Average group discount percentage"
    - name: "avg_revenue_share"
      expr: AVG(CAST(revenue_share_pct AS DOUBLE))
      comment: "Average revenue share percentage"
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate_pct AS DOUBLE))
      comment: "Average tax rate percentage"
    - name: "dynamic_pricing_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN dynamic_pricing_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events using dynamic pricing"
    - name: "presale_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN presale_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events offering presale"
    - name: "avg_price_multiplier"
      expr: AVG(CAST(multiplier AS DOUBLE))
      comment: "Average pricing multiplier applied"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`event_scoring_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "In-game scoring and competitive outcome metrics tracking goals, points, and match momentum shifts"
  source: "`sports_entertainment_ecm`.`event`.`scoring_event`"
  dimensions:
    - name: "event_date"
      expr: DATE(event_timestamp)
      comment: "Date of the scoring event"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of the scoring event"
    - name: "scoring_method"
      expr: scoring_method
      comment: "Method of scoring (e.g., goal, touchdown, basket)"
    - name: "sport_type"
      expr: sport_type
      comment: "Type of sport"
    - name: "period_type"
      expr: period_type
      comment: "Type of period (e.g., regulation, overtime, shootout)"
    - name: "competition_phase"
      expr: competition_phase
      comment: "Phase of competition (e.g., group stage, knockout)"
    - name: "is_lead_change"
      expr: is_lead_change
      comment: "Whether the scoring event resulted in a lead change"
    - name: "is_tie"
      expr: is_tie
      comment: "Whether the scoring event resulted in a tie"
    - name: "is_own_goal"
      expr: is_own_goal
      comment: "Whether the scoring event was an own goal"
    - name: "var_review_flag"
      expr: var_review_flag
      comment: "Whether the scoring event was reviewed by VAR"
    - name: "var_review_outcome"
      expr: var_review_outcome
      comment: "Outcome of VAR review"
    - name: "event_status"
      expr: event_status
      comment: "Status of the scoring event"
  measures:
    - name: "total_scoring_events"
      expr: COUNT(1)
      comment: "Total number of scoring events"
    - name: "total_points_scored"
      expr: SUM(CAST(points_value AS BIGINT))
      comment: "Total points scored across all events"
    - name: "avg_points_per_scoring_event"
      expr: AVG(CAST(points_value AS BIGINT))
      comment: "Average points per scoring event"
    - name: "lead_change_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_lead_change = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of scoring events that resulted in lead changes"
    - name: "tie_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_tie = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of scoring events that resulted in ties"
    - name: "own_goal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_own_goal = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of scoring events that were own goals"
    - name: "var_review_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN var_review_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of scoring events reviewed by VAR"
    - name: "confirmed_scoring_events"
      expr: SUM(CASE WHEN is_confirmed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of confirmed scoring events"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`event_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event safety and operational incident metrics tracking disruptions, delays, and response effectiveness"
  source: "`sports_entertainment_ecm`.`event`.`event_incident`"
  dimensions:
    - name: "occurred_date"
      expr: DATE(occurred_at)
      comment: "Date the incident occurred"
    - name: "occurred_month"
      expr: DATE_TRUNC('MONTH', occurred_at)
      comment: "Month the incident occurred"
    - name: "incident_type"
      expr: incident_type
      comment: "Type of incident (e.g., medical, security, weather, technical)"
    - name: "incident_status"
      expr: incident_status
      comment: "Status of the incident (open, resolved, escalated)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the incident"
    - name: "subtype"
      expr: subtype
      comment: "Subtype of the incident"
    - name: "broadcast_impact"
      expr: broadcast_impact
      comment: "Whether the incident impacted broadcast"
    - name: "insurance_claim_required"
      expr: insurance_claim_required
      comment: "Whether an insurance claim is required"
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required
      comment: "Whether regulatory reporting is required"
    - name: "regulatory_report_submitted"
      expr: regulatory_report_submitted
      comment: "Whether regulatory report has been submitted"
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition during the incident"
    - name: "response_team_type"
      expr: response_team_type
      comment: "Type of response team deployed"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of incidents"
    - name: "total_game_delay_minutes"
      expr: SUM(CAST(game_delay_duration_minutes AS BIGINT))
      comment: "Total game delay duration in minutes"
    - name: "avg_game_delay_minutes"
      expr: AVG(CAST(game_delay_duration_minutes AS BIGINT))
      comment: "Average game delay duration per incident"
    - name: "total_broadcast_delay_minutes"
      expr: SUM(CAST(broadcast_delay_minutes AS BIGINT))
      comment: "Total broadcast delay in minutes"
    - name: "total_fan_impact"
      expr: SUM(CAST(fan_impact_count AS BIGINT))
      comment: "Total number of fans impacted by incidents"
    - name: "avg_fan_impact_per_incident"
      expr: AVG(CAST(fan_impact_count AS BIGINT))
      comment: "Average number of fans impacted per incident"
    - name: "broadcast_impact_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN broadcast_impact = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents that impacted broadcast"
    - name: "insurance_claim_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN insurance_claim_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents requiring insurance claims"
    - name: "regulatory_reporting_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_reporting_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents requiring regulatory reporting"
    - name: "regulatory_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_report_submitted = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN regulatory_reporting_required = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of required regulatory reports that were submitted"
    - name: "avg_temperature_celsius"
      expr: AVG(CAST(temperature_celsius AS DOUBLE))
      comment: "Average temperature during incidents"
    - name: "avg_wind_speed_kmh"
      expr: AVG(CAST(wind_speed_kmh AS DOUBLE))
      comment: "Average wind speed during incidents"
$$;