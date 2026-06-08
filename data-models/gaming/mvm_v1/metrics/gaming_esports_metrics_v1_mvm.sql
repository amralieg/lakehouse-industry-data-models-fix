-- Metric views for domain: esports | Business: Gaming | Version: 1 | Generated on: 2026-05-08 09:44:33

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
    - name: "Platform Type"
      expr: platform_type
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
    - name: "Server Region"
      expr: server_region
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
    - name: "Season End Date"
      expr: season_end_date
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
    - name: "Broadcast Flag"
      expr: broadcast_flag
    - name: "Broadcast Platform"
      expr: broadcast_platform
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
    - name: "Registration Close Date"
      expr: registration_close_date
    - name: "Registration Open Date"
      expr: registration_open_date
    - name: "Rules Document Url"
      expr: rules_document_url
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

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`esports_venue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Venue business metrics"
  source: "`gaming_ecm`.`esports`.`venue`"
  dimensions:
    - name: "Accessibility Compliant"
      expr: accessibility_compliant
    - name: "Address Line 1"
      expr: address_line_1
    - name: "Address Line 2"
      expr: address_line_2
    - name: "Broadcast Infrastructure Tier"
      expr: broadcast_infrastructure_tier
    - name: "City"
      expr: city
    - name: "Concession Available"
      expr: concession_available
    - name: "Contract Expiration Date"
      expr: contract_expiration_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Email Address"
      expr: email_address
    - name: "Last Renovation Date"
      expr: last_renovation_date
    - name: "Merchandise Store Available"
      expr: merchandise_store_available
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Opened Date"
      expr: opened_date
    - name: "Operator Organization"
      expr: operator_organization
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Venue"
      expr: COUNT(DISTINCT venue_id)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Network Bandwidth Gbps"
      expr: SUM(network_bandwidth_gbps)
    - name: "Average Network Bandwidth Gbps"
      expr: AVG(network_bandwidth_gbps)
    - name: "Total Rental Rate Per Day Usd"
      expr: SUM(rental_rate_per_day_usd)
    - name: "Average Rental Rate Per Day Usd"
      expr: AVG(rental_rate_per_day_usd)
$$;