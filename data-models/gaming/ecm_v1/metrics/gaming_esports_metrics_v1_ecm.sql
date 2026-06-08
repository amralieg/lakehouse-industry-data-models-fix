-- Metric views for domain: esports | Business: Gaming | Version: 1 | Generated on: 2026-05-08 07:57:15

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`esports_bracket`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bracket business metrics"
  source: "`gaming_ecm`.`esports`.`bracket`"
  dimensions:
    - name: "Actual End Timestamp"
      expr: actual_end_timestamp
    - name: "Actual Start Timestamp"
      expr: actual_start_timestamp
    - name: "Advancement Rule"
      expr: advancement_rule
    - name: "Average Minute Audience"
      expr: average_minute_audience
    - name: "Best Of Format"
      expr: best_of_format
    - name: "Bracket Name"
      expr: bracket_name
    - name: "Bracket Status"
      expr: bracket_status
    - name: "Bracket Type"
      expr: bracket_type
    - name: "Broadcast Language Codes"
      expr: broadcast_language_codes
    - name: "Broadcast Priority"
      expr: broadcast_priority
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "End Date"
      expr: end_date
    - name: "Game Version"
      expr: game_version
    - name: "Grand Final Reset Flag"
      expr: grand_final_reset_flag
    - name: "Match Scheduling Buffer Minutes"
      expr: match_scheduling_buffer_minutes
    - name: "Modified Timestamp"
      expr: modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bracket"
      expr: COUNT(DISTINCT bracket_id)
    - name: "Total Prize Pool Allocation Pct"
      expr: SUM(prize_pool_allocation_pct)
    - name: "Average Prize Pool Allocation Pct"
      expr: AVG(prize_pool_allocation_pct)
    - name: "Total Total Viewership"
      expr: SUM(total_viewership)
    - name: "Average Total Viewership"
      expr: AVG(total_viewership)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`esports_broadcast_rights`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Broadcast Rights business metrics"
  source: "`gaming_ecm`.`esports`.`broadcast_rights`"
  dimensions:
    - name: "Advertising Rights"
      expr: advertising_rights
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Compliance Requirements"
      expr: compliance_requirements
    - name: "Content Scope"
      expr: content_scope
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Exclusivity Flag"
      expr: exclusivity_flag
    - name: "Exclusivity Scope"
      expr: exclusivity_scope
    - name: "Highlights Rights Flag"
      expr: highlights_rights_flag
    - name: "Language Requirements"
      expr: language_requirements
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "License Fee Currency"
      expr: license_fee_currency
    - name: "Live Broadcast Flag"
      expr: live_broadcast_flag
    - name: "Localization Requirements"
      expr: localization_requirements
    - name: "Notes"
      expr: notes
    - name: "Performance Bonus Structure"
      expr: performance_bonus_structure
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Broadcast Rights"
      expr: COUNT(DISTINCT broadcast_rights_id)
    - name: "Total License Fee Amount"
      expr: SUM(license_fee_amount)
    - name: "Average License Fee Amount"
      expr: AVG(license_fee_amount)
    - name: "Total Minimum Guaranteed Viewership"
      expr: SUM(minimum_guaranteed_viewership)
    - name: "Average Minimum Guaranteed Viewership"
      expr: AVG(minimum_guaranteed_viewership)
    - name: "Total Revenue Share Percentage"
      expr: SUM(revenue_share_percentage)
    - name: "Average Revenue Share Percentage"
      expr: AVG(revenue_share_percentage)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`esports_broadcast_viewership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Broadcast Viewership business metrics"
  source: "`gaming_ecm`.`esports`.`broadcast_viewership`"
  dimensions:
    - name: "Ad Break Active"
      expr: ad_break_active
    - name: "Bitrate Kbps"
      expr: bitrate_kbps
    - name: "Broadcast Language"
      expr: broadcast_language
    - name: "Broadcast Platform"
      expr: broadcast_platform
    - name: "Broadcast Start Timestamp"
      expr: broadcast_start_timestamp
    - name: "Broadcast Status"
      expr: broadcast_status
    - name: "Co Stream Count"
      expr: co_stream_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Geographic Distribution Snapshot"
      expr: geographic_distribution_snapshot
    - name: "Measurement Timestamp"
      expr: measurement_timestamp
    - name: "Peak Timestamp"
      expr: peak_timestamp
    - name: "Sponsorship Overlay Active"
      expr: sponsorship_overlay_active
    - name: "Stream Quality Tier"
      expr: stream_quality_tier
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Vod Availability"
      expr: vod_availability
    - name: "Broadcast Start Timestamp Month"
      expr: DATE_TRUNC('MONTH', broadcast_start_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Broadcast Viewership"
      expr: COUNT(DISTINCT broadcast_viewership_id)
    - name: "Total Average Watch Time Minutes"
      expr: SUM(average_watch_time_minutes)
    - name: "Average Average Watch Time Minutes"
      expr: AVG(average_watch_time_minutes)
    - name: "Total Buffering Ratio"
      expr: SUM(buffering_ratio)
    - name: "Average Buffering Ratio"
      expr: AVG(buffering_ratio)
    - name: "Total Ccu"
      expr: SUM(ccu)
    - name: "Average Ccu"
      expr: AVG(ccu)
    - name: "Total Chat Message Volume"
      expr: SUM(chat_message_volume)
    - name: "Average Chat Message Volume"
      expr: AVG(chat_message_volume)
    - name: "Total Console Viewer Percentage"
      expr: SUM(console_viewer_percentage)
    - name: "Average Console Viewer Percentage"
      expr: AVG(console_viewer_percentage)
    - name: "Total Desktop Viewer Percentage"
      expr: SUM(desktop_viewer_percentage)
    - name: "Average Desktop Viewer Percentage"
      expr: AVG(desktop_viewer_percentage)
    - name: "Total Follower Viewer Count"
      expr: SUM(follower_viewer_count)
    - name: "Average Follower Viewer Count"
      expr: AVG(follower_viewer_count)
    - name: "Total Mobile Viewer Percentage"
      expr: SUM(mobile_viewer_percentage)
    - name: "Average Mobile Viewer Percentage"
      expr: AVG(mobile_viewer_percentage)
    - name: "Total New Viewer Count"
      expr: SUM(new_viewer_count)
    - name: "Average New Viewer Count"
      expr: AVG(new_viewer_count)
    - name: "Total Pcu"
      expr: SUM(pcu)
    - name: "Average Pcu"
      expr: AVG(pcu)
    - name: "Total Raid Incoming Viewers"
      expr: SUM(raid_incoming_viewers)
    - name: "Average Raid Incoming Viewers"
      expr: AVG(raid_incoming_viewers)
    - name: "Total Subscriber Viewer Count"
      expr: SUM(subscriber_viewer_count)
    - name: "Average Subscriber Viewer Count"
      expr: AVG(subscriber_viewer_count)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`esports_esports_season`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Esports Season business metrics"
  source: "`gaming_ecm`.`esports`.`esports_season`"
  dimensions:
    - name: "Broadcast Language"
      expr: broadcast_language
    - name: "Broadcast Rights Holder"
      expr: broadcast_rights_holder
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "End Date"
      expr: end_date
    - name: "Format Type"
      expr: format_type
    - name: "Is Lan Event"
      expr: is_lan_event
    - name: "Max Teams"
      expr: max_teams
    - name: "Min Teams"
      expr: min_teams
    - name: "Ordinal"
      expr: ordinal
    - name: "Peak Ccu"
      expr: peak_ccu
    - name: "Prize Pool Currency"
      expr: prize_pool_currency
    - name: "Qualification Slots"
      expr: qualification_slots
    - name: "Region"
      expr: region
    - name: "Registered Teams Count"
      expr: registered_teams_count
    - name: "Registration End Date"
      expr: registration_end_date
    - name: "Registration Start Date"
      expr: registration_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Esports Season"
      expr: COUNT(DISTINCT esports_season_id)
    - name: "Total Crowdfunded Amount"
      expr: SUM(crowdfunded_amount)
    - name: "Average Crowdfunded Amount"
      expr: AVG(crowdfunded_amount)
    - name: "Total Total Prize Pool Amount"
      expr: SUM(total_prize_pool_amount)
    - name: "Average Total Prize Pool Amount"
      expr: AVG(total_prize_pool_amount)
    - name: "Total Total Viewership Hours"
      expr: SUM(total_viewership_hours)
    - name: "Average Total Viewership Hours"
      expr: AVG(total_viewership_hours)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`esports_game_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Game Result business metrics"
  source: "`gaming_ecm`.`esports`.`game_result`"
  dimensions:
    - name: "Broadcast Flag"
      expr: broadcast_flag
    - name: "Competitive Tier"
      expr: competitive_tier
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source"
      expr: data_source
    - name: "Disqualification Flag"
      expr: disqualification_flag
    - name: "Disqualification Reason"
      expr: disqualification_reason
    - name: "Duration Seconds"
      expr: duration_seconds
    - name: "Game End Timestamp"
      expr: game_end_timestamp
    - name: "Game Mode"
      expr: game_mode
    - name: "Game Number"
      expr: game_number
    - name: "Game Start Timestamp"
      expr: game_start_timestamp
    - name: "Game Status"
      expr: game_status
    - name: "Notes"
      expr: notes
    - name: "Pause Count"
      expr: pause_count
    - name: "Prize Pool Contribution Flag"
      expr: prize_pool_contribution_flag
    - name: "Replay File Url"
      expr: replay_file_url
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Game Result"
      expr: COUNT(DISTINCT game_result_id)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`esports_league`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "League business metrics"
  source: "`gaming_ecm`.`esports`.`league`"
  dimensions:
    - name: "Age Restriction"
      expr: age_restriction
    - name: "Broadcast Language"
      expr: broadcast_language
    - name: "Broadcast Rights Holder"
      expr: broadcast_rights_holder
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Format"
      expr: format
    - name: "League Code"
      expr: league_code
    - name: "League Name"
      expr: league_name
    - name: "League Status"
      expr: league_status
    - name: "League Tier"
      expr: league_tier
    - name: "Match Count"
      expr: match_count
    - name: "Organizer Name"
      expr: organizer_name
    - name: "Organizer Type"
      expr: organizer_type
    - name: "Patch Version End"
      expr: patch_version_end
    - name: "Patch Version Start"
      expr: patch_version_start
    - name: "Qualification Slots"
      expr: qualification_slots
    - name: "Relegation Slots"
      expr: relegation_slots
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct League"
      expr: COUNT(DISTINCT league_id)
    - name: "Total Prize Pool Ceiling Usd"
      expr: SUM(prize_pool_ceiling_usd)
    - name: "Average Prize Pool Ceiling Usd"
      expr: AVG(prize_pool_ceiling_usd)
    - name: "Total Revenue Share Percentage"
      expr: SUM(revenue_share_percentage)
    - name: "Average Revenue Share Percentage"
      expr: AVG(revenue_share_percentage)
    - name: "Total Season Prize Pool Usd"
      expr: SUM(season_prize_pool_usd)
    - name: "Average Season Prize Pool Usd"
      expr: AVG(season_prize_pool_usd)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`esports_league_influencer_partnership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "League Influencer Partnership business metrics"
  source: "`gaming_ecm`.`esports`.`league_influencer_partnership`"
  dimensions:
    - name: "Brand Safety Guidelines"
      expr: brand_safety_guidelines
    - name: "Compensation Currency"
      expr: compensation_currency
    - name: "Content Approval Required"
      expr: content_approval_required
    - name: "Content Deliverables"
      expr: content_deliverables
    - name: "Exclusivity Scope"
      expr: exclusivity_scope
    - name: "Partnership End Date"
      expr: partnership_end_date
    - name: "Partnership Start Date"
      expr: partnership_start_date
    - name: "Partnership Status"
      expr: partnership_status
    - name: "Performance Metrics Target"
      expr: performance_metrics_target
    - name: "Partnership End Date Month"
      expr: DATE_TRUNC('MONTH', partnership_end_date)
    - name: "Partnership Start Date Month"
      expr: DATE_TRUNC('MONTH', partnership_start_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct League Influencer Partnership"
      expr: COUNT(DISTINCT league_influencer_partnership_id)
    - name: "Total Compensation Amount"
      expr: SUM(compensation_amount)
    - name: "Average Compensation Amount"
      expr: AVG(compensation_amount)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`esports_match`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Match business metrics"
  source: "`gaming_ecm`.`esports`.`match`"
  dimensions:
    - name: "Actual End Timestamp"
      expr: actual_end_timestamp
    - name: "Actual Start Timestamp"
      expr: actual_start_timestamp
    - name: "Average Ccu"
      expr: average_ccu
    - name: "Best Of Format"
      expr: best_of_format
    - name: "Broadcast Delay Seconds"
      expr: broadcast_delay_seconds
    - name: "Broadcast Url"
      expr: broadcast_url
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source System"
      expr: data_source_system
    - name: "Disqualification Flag"
      expr: disqualification_flag
    - name: "Disqualification Reason"
      expr: disqualification_reason
    - name: "Duration Seconds"
      expr: duration_seconds
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Match Number"
      expr: match_number
    - name: "Match Status"
      expr: match_status
    - name: "Notes"
      expr: notes
    - name: "Peak Ccu"
      expr: peak_ccu
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Match"
      expr: COUNT(DISTINCT match_id)
    - name: "Total Prize Pool Amount"
      expr: SUM(prize_pool_amount)
    - name: "Average Prize Pool Amount"
      expr: AVG(prize_pool_amount)
    - name: "Total Total Views"
      expr: SUM(total_views)
    - name: "Average Total Views"
      expr: AVG(total_views)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`esports_match_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Match Incident business metrics"
  source: "`gaming_ecm`.`esports`.`match_incident`"
  dimensions:
    - name: "Appeal Deadline"
      expr: appeal_deadline
    - name: "Appeal Filed"
      expr: appeal_filed
    - name: "Appeal Filed Timestamp"
      expr: appeal_filed_timestamp
    - name: "Appeal Outcome"
      expr: appeal_outcome
    - name: "Appeal Ruling Timestamp"
      expr: appeal_ruling_timestamp
    - name: "Assigned Timestamp"
      expr: assigned_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Disclosure Timestamp"
      expr: disclosure_timestamp
    - name: "Evidence References"
      expr: evidence_references
    - name: "Game Number"
      expr: game_number
    - name: "In Game Time"
      expr: in_game_time
    - name: "Incident Description"
      expr: incident_description
    - name: "Incident Number"
      expr: incident_number
    - name: "Incident Status"
      expr: incident_status
    - name: "Incident Timestamp"
      expr: incident_timestamp
    - name: "Incident Type"
      expr: incident_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Match Incident"
      expr: COUNT(DISTINCT match_incident_id)
    - name: "Total Penalty Amount Usd"
      expr: SUM(penalty_amount_usd)
    - name: "Average Penalty Amount Usd"
      expr: AVG(penalty_amount_usd)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`esports_match_stat`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Match Stat business metrics"
  source: "`gaming_ecm`.`esports`.`match_stat`"
  dimensions:
    - name: "Apm"
      expr: apm
    - name: "Assists"
      expr: assists
    - name: "Clutch Rounds Won"
      expr: clutch_rounds_won
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deaths"
      expr: deaths
    - name: "Economy Score"
      expr: economy_score
    - name: "First Blood Flag"
      expr: first_blood_flag
    - name: "In Game Name"
      expr: in_game_name
    - name: "Items Purchased"
      expr: items_purchased
    - name: "Kills"
      expr: kills
    - name: "Match Format"
      expr: match_format
    - name: "Match Timestamp"
      expr: match_timestamp
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Multikill Count"
      expr: multikill_count
    - name: "Mvp Flag"
      expr: mvp_flag
    - name: "Objective Score"
      expr: objective_score
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Match Stat"
      expr: COUNT(DISTINCT match_stat_id)
    - name: "Total Accuracy Percentage"
      expr: SUM(accuracy_percentage)
    - name: "Average Accuracy Percentage"
      expr: AVG(accuracy_percentage)
    - name: "Total Crowd Control Duration Seconds"
      expr: SUM(crowd_control_duration_seconds)
    - name: "Average Crowd Control Duration Seconds"
      expr: AVG(crowd_control_duration_seconds)
    - name: "Total Cs Per Min"
      expr: SUM(cs_per_min)
    - name: "Average Cs Per Min"
      expr: AVG(cs_per_min)
    - name: "Total Damage Dealt"
      expr: SUM(damage_dealt)
    - name: "Average Damage Dealt"
      expr: AVG(damage_dealt)
    - name: "Total Damage Taken"
      expr: SUM(damage_taken)
    - name: "Average Damage Taken"
      expr: AVG(damage_taken)
    - name: "Total Headshot Rate"
      expr: SUM(headshot_rate)
    - name: "Average Headshot Rate"
      expr: AVG(headshot_rate)
    - name: "Total Healing Done"
      expr: SUM(healing_done)
    - name: "Average Healing Done"
      expr: AVG(healing_done)
    - name: "Total Performance Rating"
      expr: SUM(performance_rating)
    - name: "Average Performance Rating"
      expr: AVG(performance_rating)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`esports_player_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Player Contract business metrics"
  source: "`gaming_ecm`.`esports`.`player_contract`"
  dimensions:
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Buyout Clause Currency"
      expr: buyout_clause_currency
    - name: "Confidentiality Terms"
      expr: confidentiality_terms
    - name: "Contract Language"
      expr: contract_language
    - name: "Contract Number"
      expr: contract_number
    - name: "Contract Status"
      expr: contract_status
    - name: "Contract Type"
      expr: contract_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dispute Resolution Method"
      expr: dispute_resolution_method
    - name: "End Date"
      expr: end_date
    - name: "Equipment Provided Flag"
      expr: equipment_provided_flag
    - name: "Exclusivity Clause"
      expr: exclusivity_clause
    - name: "Health Insurance Provided Flag"
      expr: health_insurance_provided_flag
    - name: "Housing Provided Flag"
      expr: housing_provided_flag
    - name: "Image Rights Terms"
      expr: image_rights_terms
    - name: "Non Compete Terms"
      expr: non_compete_terms
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Player Contract"
      expr: COUNT(DISTINCT player_contract_id)
    - name: "Total Buyout Clause Amount"
      expr: SUM(buyout_clause_amount)
    - name: "Average Buyout Clause Amount"
      expr: AVG(buyout_clause_amount)
    - name: "Total Relocation Assistance Amount"
      expr: SUM(relocation_assistance_amount)
    - name: "Average Relocation Assistance Amount"
      expr: AVG(relocation_assistance_amount)
    - name: "Total Revenue Share Percentage"
      expr: SUM(revenue_share_percentage)
    - name: "Average Revenue Share Percentage"
      expr: AVG(revenue_share_percentage)
    - name: "Total Salary Amount"
      expr: SUM(salary_amount)
    - name: "Average Salary Amount"
      expr: AVG(salary_amount)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`esports_prize_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prize Allocation business metrics"
  source: "`gaming_ecm`.`esports`.`prize_allocation`"
  dimensions:
    - name: "Allocation Notes"
      expr: allocation_notes
    - name: "Allocation Number"
      expr: allocation_number
    - name: "Allocation Timestamp"
      expr: allocation_timestamp
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Bonus Prize Category"
      expr: bonus_prize_category
    - name: "Contract Reference Number"
      expr: contract_reference_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Is Bonus Prize"
      expr: is_bonus_prize
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Payee Type"
      expr: payee_type
    - name: "Payment Date"
      expr: payment_date
    - name: "Payment Method"
      expr: payment_method
    - name: "Payment Status"
      expr: payment_status
    - name: "Placement Description"
      expr: placement_description
    - name: "Placement Rank"
      expr: placement_rank
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Prize Allocation"
      expr: COUNT(DISTINCT prize_allocation_id)
    - name: "Total Allocated Amount"
      expr: SUM(allocated_amount)
    - name: "Average Allocated Amount"
      expr: AVG(allocated_amount)
    - name: "Total Net Payout Amount"
      expr: SUM(net_payout_amount)
    - name: "Average Net Payout Amount"
      expr: AVG(net_payout_amount)
    - name: "Total Other Deductions Amount"
      expr: SUM(other_deductions_amount)
    - name: "Average Other Deductions Amount"
      expr: AVG(other_deductions_amount)
    - name: "Total Payee Bank Account Number"
      expr: SUM(payee_bank_account_number)
    - name: "Average Payee Bank Account Number"
      expr: AVG(payee_bank_account_number)
    - name: "Total Platform Fee Amount"
      expr: SUM(platform_fee_amount)
    - name: "Average Platform Fee Amount"
      expr: AVG(platform_fee_amount)
    - name: "Total Split Percentage"
      expr: SUM(split_percentage)
    - name: "Average Split Percentage"
      expr: AVG(split_percentage)
    - name: "Total Tax Withholding Amount"
      expr: SUM(tax_withholding_amount)
    - name: "Average Tax Withholding Amount"
      expr: AVG(tax_withholding_amount)
    - name: "Total Tax Withholding Rate"
      expr: SUM(tax_withholding_rate)
    - name: "Average Tax Withholding Rate"
      expr: AVG(tax_withholding_rate)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`esports_prize_pool`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prize Pool business metrics"
  source: "`gaming_ecm`.`esports`.`prize_pool`"
  dimensions:
    - name: "Broadcast Rights Linked"
      expr: broadcast_rights_linked
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Distribution Completion Date"
      expr: distribution_completion_date
    - name: "Distribution Method"
      expr: distribution_method
    - name: "Distribution Start Date"
      expr: distribution_start_date
    - name: "Funding Source"
      expr: funding_source
    - name: "Notes"
      expr: notes
    - name: "Number Of Paid Placements"
      expr: number_of_paid_placements
    - name: "Payee Type Default"
      expr: payee_type_default
    - name: "Payment Processor"
      expr: payment_processor
    - name: "Pool Announcement Date"
      expr: pool_announcement_date
    - name: "Pool Lock Date"
      expr: pool_lock_date
    - name: "Pool Name"
      expr: pool_name
    - name: "Pool Status"
      expr: pool_status
    - name: "Tax Withholding Rule"
      expr: tax_withholding_rule
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Prize Pool"
      expr: COUNT(DISTINCT prize_pool_id)
    - name: "Total Crowdfund Amount"
      expr: SUM(crowdfund_amount)
    - name: "Average Crowdfund Amount"
      expr: AVG(crowdfund_amount)
    - name: "Total Default Tax Rate"
      expr: SUM(default_tax_rate)
    - name: "Average Default Tax Rate"
      expr: AVG(default_tax_rate)
    - name: "Total First Place Amount"
      expr: SUM(first_place_amount)
    - name: "Average First Place Amount"
      expr: AVG(first_place_amount)
    - name: "Total Minimum Guaranteed Amount"
      expr: SUM(minimum_guaranteed_amount)
    - name: "Average Minimum Guaranteed Amount"
      expr: AVG(minimum_guaranteed_amount)
    - name: "Total Second Place Amount"
      expr: SUM(second_place_amount)
    - name: "Average Second Place Amount"
      expr: AVG(second_place_amount)
    - name: "Total Sponsor Amount"
      expr: SUM(sponsor_amount)
    - name: "Average Sponsor Amount"
      expr: AVG(sponsor_amount)
    - name: "Total Third Place Amount"
      expr: SUM(third_place_amount)
    - name: "Average Third Place Amount"
      expr: AVG(third_place_amount)
    - name: "Total Total Pool Amount"
      expr: SUM(total_pool_amount)
    - name: "Average Total Pool Amount"
      expr: AVG(total_pool_amount)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`esports_roster`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Roster business metrics"
  source: "`gaming_ecm`.`esports`.`roster`"
  dimensions:
    - name: "Age At Roster Lock"
      expr: age_at_roster_lock
    - name: "Announcement Date"
      expr: announcement_date
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Approved By"
      expr: approved_by
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Departure Date"
      expr: departure_date
    - name: "Eligibility Status"
      expr: eligibility_status
    - name: "In Game Name"
      expr: in_game_name
    - name: "Is Academy Promotion"
      expr: is_academy_promotion
    - name: "Is Captain"
      expr: is_captain
    - name: "Is Starter"
      expr: is_starter
    - name: "Jersey Number"
      expr: jersey_number
    - name: "Join Date"
      expr: join_date
    - name: "Lock Date"
      expr: lock_date
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Nationality"
      expr: nationality
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Roster"
      expr: COUNT(DISTINCT roster_id)
    - name: "Total Transfer Fee Amount"
      expr: SUM(transfer_fee_amount)
    - name: "Average Transfer Fee Amount"
      expr: AVG(transfer_fee_amount)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`esports_round`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Round business metrics"
  source: "`gaming_ecm`.`esports`.`round`"
  dimensions:
    - name: "Actual End Timestamp"
      expr: actual_end_timestamp
    - name: "Actual Start Timestamp"
      expr: actual_start_timestamp
    - name: "Advancement Count"
      expr: advancement_count
    - name: "Best Of Format"
      expr: best_of_format
    - name: "Bracket Type"
      expr: bracket_type
    - name: "Broadcast Language"
      expr: broadcast_language
    - name: "Broadcast Rights Holder"
      expr: broadcast_rights_holder
    - name: "Completed Matches"
      expr: completed_matches
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Elimination Count"
      expr: elimination_count
    - name: "Game Version"
      expr: game_version
    - name: "Is Online"
      expr: is_online
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Primary Sponsor Name"
      expr: primary_sponsor_name
    - name: "Prize Pool Currency"
      expr: prize_pool_currency
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Round"
      expr: COUNT(DISTINCT round_id)
    - name: "Total Average Concurrent Users"
      expr: SUM(average_concurrent_users)
    - name: "Average Average Concurrent Users"
      expr: AVG(average_concurrent_users)
    - name: "Total Peak Concurrent Users"
      expr: SUM(peak_concurrent_users)
    - name: "Average Peak Concurrent Users"
      expr: AVG(peak_concurrent_users)
    - name: "Total Prize Pool Amount"
      expr: SUM(prize_pool_amount)
    - name: "Average Prize Pool Amount"
      expr: AVG(prize_pool_amount)
    - name: "Total Total Viewership"
      expr: SUM(total_viewership)
    - name: "Average Total Viewership"
      expr: AVG(total_viewership)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`esports_sponsorship`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sponsorship business metrics"
  source: "`gaming_ecm`.`esports`.`sponsorship`"
  dimensions:
    - name: "Activation Type"
      expr: activation_type
    - name: "Broadcast Rights Included"
      expr: broadcast_rights_included
    - name: "Contract Number"
      expr: contract_number
    - name: "Contract Signed Date"
      expr: contract_signed_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Deliverables List"
      expr: deliverables_list
    - name: "Digital Rights Included"
      expr: digital_rights_included
    - name: "End Date"
      expr: end_date
    - name: "Exclusivity Category"
      expr: exclusivity_category
    - name: "Exclusivity Flag"
      expr: exclusivity_flag
    - name: "Hospitality Package Included"
      expr: hospitality_package_included
    - name: "In Game Branding Included"
      expr: in_game_branding_included
    - name: "Notes"
      expr: notes
    - name: "Payment Terms"
      expr: payment_terms
    - name: "Performance Metrics"
      expr: performance_metrics
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sponsorship"
      expr: COUNT(DISTINCT sponsorship_id)
    - name: "Total Contracted Value"
      expr: SUM(contracted_value)
    - name: "Average Contracted Value"
      expr: AVG(contracted_value)
    - name: "Total In Kind Value"
      expr: SUM(in_kind_value)
    - name: "Average In Kind Value"
      expr: AVG(in_kind_value)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`esports_standing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Standing business metrics"
  source: "`gaming_ecm`.`esports`.`standing`"
  dimensions:
    - name: "Clinched Playoff"
      expr: clinched_playoff
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Current Streak"
      expr: current_streak
    - name: "Effective Date"
      expr: effective_date
    - name: "Eliminated"
      expr: eliminated
    - name: "Last Match Date"
      expr: last_match_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Longest Loss Streak"
      expr: longest_loss_streak
    - name: "Longest Win Streak"
      expr: longest_win_streak
    - name: "Map Differential"
      expr: map_differential
    - name: "Maps Lost"
      expr: maps_lost
    - name: "Maps Won"
      expr: maps_won
    - name: "Matches Drawn"
      expr: matches_drawn
    - name: "Matches Lost"
      expr: matches_lost
    - name: "Matches Played"
      expr: matches_played
    - name: "Matches Won"
      expr: matches_won
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Standing"
      expr: COUNT(DISTINCT standing_id)
    - name: "Total Win Rate"
      expr: SUM(win_rate)
    - name: "Average Win Rate"
      expr: AVG(win_rate)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`esports_team`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Team business metrics"
  source: "`gaming_ecm`.`esports`.`team`"
  dimensions:
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Contract Expiry Date"
      expr: contract_expiry_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Current World Ranking"
      expr: current_world_ranking
    - name: "Discord Server Code"
      expr: discord_server_code
    - name: "Founding Date"
      expr: founding_date
    - name: "General Manager Name"
      expr: general_manager_name
    - name: "Head Coach Name"
      expr: head_coach_name
    - name: "Headquarters Address"
      expr: headquarters_address
    - name: "Headquarters City"
      expr: headquarters_city
    - name: "Headquarters Postal Code"
      expr: headquarters_postal_code
    - name: "Is Franchise Team"
      expr: is_franchise_team
    - name: "Is Verified"
      expr: is_verified
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "League Championships"
      expr: league_championships
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Team"
      expr: COUNT(DISTINCT team_id)
    - name: "Total Franchise Fee Paid"
      expr: SUM(franchise_fee_paid)
    - name: "Average Franchise Fee Paid"
      expr: AVG(franchise_fee_paid)
    - name: "Total Revenue Share Percentage"
      expr: SUM(revenue_share_percentage)
    - name: "Average Revenue Share Percentage"
      expr: AVG(revenue_share_percentage)
    - name: "Total Total Prize Money Won"
      expr: SUM(total_prize_money_won)
    - name: "Average Total Prize Money Won"
      expr: AVG(total_prize_money_won)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`esports_team_asset_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Team Asset License business metrics"
  source: "`gaming_ecm`.`esports`.`team_asset_license`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Asset Type"
      expr: asset_type
    - name: "Created Date"
      expr: created_date
    - name: "Exclusivity Flag"
      expr: exclusivity_flag
    - name: "Last Modified Date"
      expr: last_modified_date
    - name: "License Terms"
      expr: license_terms
    - name: "Logo Asset Url"
      expr: logo_asset_url
    - name: "Usage Context"
      expr: usage_context
    - name: "Usage Rights End Date"
      expr: usage_rights_end_date
    - name: "Usage Rights Start Date"
      expr: usage_rights_start_date
    - name: "Version Number"
      expr: version_number
    - name: "Approval Date Month"
      expr: DATE_TRUNC('MONTH', approval_date)
    - name: "Created Date Month"
      expr: DATE_TRUNC('MONTH', created_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Team Asset License"
      expr: COUNT(DISTINCT team_asset_license_id)
    - name: "Total License Fee Amount"
      expr: SUM(license_fee_amount)
    - name: "Average License Fee Amount"
      expr: AVG(license_fee_amount)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`esports_team_event_participation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Team Event Participation business metrics"
  source: "`gaming_ecm`.`esports`.`team_event_participation`"
  dimensions:
    - name: "Attendance Count"
      expr: attendance_count
    - name: "Confirmation Date"
      expr: confirmation_date
    - name: "Confirmation Status"
      expr: confirmation_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Event Role"
      expr: event_role
    - name: "Invitation Date"
      expr: invitation_date
    - name: "Participation Type"
      expr: participation_type
    - name: "Sponsorship Tier"
      expr: sponsorship_tier
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Confirmation Date Month"
      expr: DATE_TRUNC('MONTH', confirmation_date)
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Team Event Participation"
      expr: COUNT(DISTINCT team_event_participation_id)
    - name: "Total Appearance Fee"
      expr: SUM(appearance_fee)
    - name: "Average Appearance Fee"
      expr: AVG(appearance_fee)
    - name: "Total Engagement Score"
      expr: SUM(engagement_score)
    - name: "Average Engagement Score"
      expr: AVG(engagement_score)
    - name: "Total Social Media Reach"
      expr: SUM(social_media_reach)
    - name: "Average Social Media Reach"
      expr: AVG(social_media_reach)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`esports_tournament`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tournament business metrics"
  source: "`gaming_ecm`.`esports`.`tournament`"
  dimensions:
    - name: "Actual End Timestamp"
      expr: actual_end_timestamp
    - name: "Actual Start Timestamp"
      expr: actual_start_timestamp
    - name: "Age Restriction"
      expr: age_restriction
    - name: "Broadcast Flag"
      expr: broadcast_flag
    - name: "Broadcast Platform"
      expr: broadcast_platform
    - name: "Certification Body"
      expr: certification_body
    - name: "Certification Status"
      expr: certification_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Entry Fee Currency Code"
      expr: entry_fee_currency_code
    - name: "Format"
      expr: format
    - name: "Max Team Capacity"
      expr: max_team_capacity
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Organizer Type"
      expr: organizer_type
    - name: "Peak Ccu"
      expr: peak_ccu
    - name: "Prize Pool Currency Code"
      expr: prize_pool_currency_code
    - name: "Registered Team Count"
      expr: registered_team_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tournament"
      expr: COUNT(DISTINCT tournament_id)
    - name: "Total Entry Fee Amount"
      expr: SUM(entry_fee_amount)
    - name: "Average Entry Fee Amount"
      expr: AVG(entry_fee_amount)
    - name: "Total Prize Pool Total"
      expr: SUM(prize_pool_total)
    - name: "Average Prize Pool Total"
      expr: AVG(prize_pool_total)
    - name: "Total Total Viewership"
      expr: SUM(total_viewership)
    - name: "Average Total Viewership"
      expr: AVG(total_viewership)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`esports_tournament_asset_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tournament Asset Usage business metrics"
  source: "`gaming_ecm`.`esports`.`tournament_asset_usage`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Display Duration Seconds"
      expr: display_duration_seconds
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Placement Location"
      expr: placement_location
    - name: "Rights Clearance Status"
      expr: rights_clearance_status
    - name: "Sponsor Attribution"
      expr: sponsor_attribution
    - name: "Usage Context"
      expr: usage_context
    - name: "Usage Status"
      expr: usage_status
    - name: "Usage Timestamp"
      expr: usage_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Last Modified Timestamp Month"
      expr: DATE_TRUNC('MONTH', last_modified_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tournament Asset Usage"
      expr: COUNT(DISTINCT tournament_asset_usage_id)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`esports_tournament_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tournament Promotion business metrics"
  source: "`gaming_ecm`.`esports`.`tournament_promotion`"
  dimensions:
    - name: "Activation Status"
      expr: activation_status
    - name: "End Timestamp"
      expr: end_timestamp
    - name: "Priority"
      expr: priority
    - name: "Start Timestamp"
      expr: start_timestamp
    - name: "End Timestamp Month"
      expr: DATE_TRUNC('MONTH', end_timestamp)
    - name: "Start Timestamp Month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tournament Promotion"
      expr: COUNT(DISTINCT tournament_promotion_id)
    - name: "Total Conversion Count"
      expr: SUM(conversion_count)
    - name: "Average Conversion Count"
      expr: AVG(conversion_count)
    - name: "Total Impression Count"
      expr: SUM(impression_count)
    - name: "Average Impression Count"
      expr: AVG(impression_count)
    - name: "Total Revenue Generated"
      expr: SUM(revenue_generated)
    - name: "Average Revenue Generated"
      expr: AVG(revenue_generated)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`esports_tournament_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tournament Registration business metrics"
  source: "`gaming_ecm`.`esports`.`tournament_registration`"
  dimensions:
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Check In Status"
      expr: check_in_status
    - name: "Check In Timestamp"
      expr: check_in_timestamp
    - name: "Contact Discord"
      expr: contact_discord
    - name: "Contact Email"
      expr: contact_email
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Disqualification Reason"
      expr: disqualification_reason
    - name: "Eligibility Status"
      expr: eligibility_status
    - name: "Eligibility Verified Timestamp"
      expr: eligibility_verified_timestamp
    - name: "Entry Fee Currency"
      expr: entry_fee_currency
    - name: "Notes"
      expr: notes
    - name: "Payment Reference"
      expr: payment_reference
    - name: "Payment Status"
      expr: payment_status
    - name: "Platform"
      expr: platform
    - name: "Previous Tournament Wins"
      expr: previous_tournament_wins
    - name: "Region"
      expr: region
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tournament Registration"
      expr: COUNT(DISTINCT tournament_registration_id)
    - name: "Total Entry Fee Amount"
      expr: SUM(entry_fee_amount)
    - name: "Average Entry Fee Amount"
      expr: AVG(entry_fee_amount)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`esports_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transfer business metrics"
  source: "`gaming_ecm`.`esports`.`transfer`"
  dimensions:
    - name: "Announcement Date"
      expr: announcement_date
    - name: "Announcement Timestamp"
      expr: announcement_timestamp
    - name: "Buyout Clause Triggered"
      expr: buyout_clause_triggered
    - name: "Contract Expiry Date"
      expr: contract_expiry_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Fee Currency"
      expr: fee_currency
    - name: "League Approval Date"
      expr: league_approval_date
    - name: "League Approval Required"
      expr: league_approval_required
    - name: "League Approval Status"
      expr: league_approval_status
    - name: "Loan Duration Months"
      expr: loan_duration_months
    - name: "Loan Option To Buy"
      expr: loan_option_to_buy
    - name: "Medical Clearance Date"
      expr: medical_clearance_date
    - name: "Medical Clearance Required"
      expr: medical_clearance_required
    - name: "Modified By"
      expr: modified_by
    - name: "Modified Timestamp"
      expr: modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Transfer"
      expr: COUNT(DISTINCT transfer_id)
    - name: "Total Agent Commission Amount"
      expr: SUM(agent_commission_amount)
    - name: "Average Agent Commission Amount"
      expr: AVG(agent_commission_amount)
    - name: "Total Buyout Clause Amount"
      expr: SUM(buyout_clause_amount)
    - name: "Average Buyout Clause Amount"
      expr: AVG(buyout_clause_amount)
    - name: "Total Fee Amount"
      expr: SUM(fee_amount)
    - name: "Average Fee Amount"
      expr: AVG(fee_amount)
    - name: "Total Loan Fee Amount"
      expr: SUM(loan_fee_amount)
    - name: "Average Loan Fee Amount"
      expr: AVG(loan_fee_amount)
    - name: "Total Option To Buy Amount"
      expr: SUM(option_to_buy_amount)
    - name: "Average Option To Buy Amount"
      expr: AVG(option_to_buy_amount)
    - name: "Total Salary Responsibility Percentage"
      expr: SUM(salary_responsibility_percentage)
    - name: "Average Salary Responsibility Percentage"
      expr: AVG(salary_responsibility_percentage)
    - name: "Total Sell On Clause Percentage"
      expr: SUM(sell_on_clause_percentage)
    - name: "Average Sell On Clause Percentage"
      expr: AVG(sell_on_clause_percentage)
$$;