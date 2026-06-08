-- Cross-Domain Foreign Keys for Business: Sports Entertainment | Version: v1_ecm
-- Generated on: 2026-05-09 01:42:59
-- Total cross-domain FK constraints: 3029
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: analytics, athlete, broadcast, compliance, content, event, fan, finance, gaming, league, legal, merchandise, partner, platform, security, sponsorship, ticketing, venue, workforce

-- ========= analytics --> athlete (4 constraint(s)) =========
-- Requires: analytics schema, athlete schema
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`performance_analytics_snapshot` ADD CONSTRAINT `fk_analytics_performance_analytics_snapshot_athlete_athlete_profile_id` FOREIGN KEY (`athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`performance_analytics_snapshot` ADD CONSTRAINT `fk_analytics_performance_analytics_snapshot_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`performance_analytics_snapshot` ADD CONSTRAINT `fk_analytics_performance_analytics_snapshot_performance_stat_id` FOREIGN KEY (`performance_stat_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`performance_stat`(`performance_stat_id`);

-- ========= analytics --> broadcast (17 constraint(s)) =========
-- Requires: analytics schema, broadcast schema
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_media_rights_deal_id` FOREIGN KEY (`media_rights_deal_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`media_rights_deal`(`media_rights_deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`audience_measurement` ADD CONSTRAINT `fk_analytics_audience_measurement_broadcast_rights_window_id` FOREIGN KEY (`broadcast_rights_window_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_rights_window`(`broadcast_rights_window_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`audience_measurement` ADD CONSTRAINT `fk_analytics_audience_measurement_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`audience_measurement` ADD CONSTRAINT `fk_analytics_audience_measurement_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`channel`(`channel_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`audience_measurement` ADD CONSTRAINT `fk_analytics_audience_measurement_live_feed_id` FOREIGN KEY (`live_feed_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`live_feed`(`live_feed_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`audience_measurement` ADD CONSTRAINT `fk_analytics_audience_measurement_media_rights_deal_id` FOREIGN KEY (`media_rights_deal_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`media_rights_deal`(`media_rights_deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`audience_measurement` ADD CONSTRAINT `fk_analytics_audience_measurement_ppv_package_id` FOREIGN KEY (`ppv_package_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`ppv_package`(`ppv_package_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`audience_demographic` ADD CONSTRAINT `fk_analytics_audience_demographic_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`channel`(`channel_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`audience_demographic` ADD CONSTRAINT `fk_analytics_audience_demographic_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`audience_demographic` ADD CONSTRAINT `fk_analytics_audience_demographic_media_rights_deal_id` FOREIGN KEY (`media_rights_deal_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`media_rights_deal`(`media_rights_deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`attribution_model` ADD CONSTRAINT `fk_analytics_attribution_model_media_rights_deal_id` FOREIGN KEY (`media_rights_deal_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`media_rights_deal`(`media_rights_deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`attribution_result` ADD CONSTRAINT `fk_analytics_attribution_result_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`channel`(`channel_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`attribution_result` ADD CONSTRAINT `fk_analytics_attribution_result_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_output` ADD CONSTRAINT `fk_analytics_forecast_output_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_output` ADD CONSTRAINT `fk_analytics_forecast_output_media_rights_deal_id` FOREIGN KEY (`media_rights_deal_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`media_rights_deal`(`media_rights_deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`engagement_index` ADD CONSTRAINT `fk_analytics_engagement_index_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`engagement_index` ADD CONSTRAINT `fk_analytics_engagement_index_media_rights_deal_id` FOREIGN KEY (`media_rights_deal_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`media_rights_deal`(`media_rights_deal_id`);

-- ========= analytics --> compliance (1 constraint(s)) =========
-- Requires: analytics schema, compliance schema
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`fan_behavior_model` ADD CONSTRAINT `fk_analytics_fan_behavior_model_pia_assessment_id` FOREIGN KEY (`pia_assessment_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`pia_assessment`(`pia_assessment_id`);

-- ========= analytics --> content (7 constraint(s)) =========
-- Requires: analytics schema, content schema
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`audience_measurement` ADD CONSTRAINT `fk_analytics_audience_measurement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`audience_measurement` ADD CONSTRAINT `fk_analytics_audience_measurement_platform_channel_id` FOREIGN KEY (`platform_channel_id`) REFERENCES `sports_entertainment_ecm`.`content`.`platform_channel`(`platform_channel_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`audience_measurement` ADD CONSTRAINT `fk_analytics_audience_measurement_publish_event_id` FOREIGN KEY (`publish_event_id`) REFERENCES `sports_entertainment_ecm`.`content`.`publish_event`(`publish_event_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`feature_store_entity` ADD CONSTRAINT `fk_analytics_feature_store_entity_metadata_tag_id` FOREIGN KEY (`metadata_tag_id`) REFERENCES `sports_entertainment_ecm`.`content`.`metadata_tag`(`metadata_tag_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`attribution_result` ADD CONSTRAINT `fk_analytics_attribution_result_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_output` ADD CONSTRAINT `fk_analytics_forecast_output_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_output` ADD CONSTRAINT `fk_analytics_forecast_output_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `sports_entertainment_ecm`.`content`.`collection`(`collection_id`);

-- ========= analytics --> event (15 constraint(s)) =========
-- Requires: analytics schema, event schema
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`audience_measurement` ADD CONSTRAINT `fk_analytics_audience_measurement_broadcast_window_id` FOREIGN KEY (`broadcast_window_id`) REFERENCES `sports_entertainment_ecm`.`event`.`broadcast_window`(`broadcast_window_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`audience_measurement` ADD CONSTRAINT `fk_analytics_audience_measurement_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`audience_measurement` ADD CONSTRAINT `fk_analytics_audience_measurement_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`performance_analytics_snapshot` ADD CONSTRAINT `fk_analytics_performance_analytics_snapshot_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`performance_analytics_snapshot` ADD CONSTRAINT `fk_analytics_performance_analytics_snapshot_match_result_id` FOREIGN KEY (`match_result_id`) REFERENCES `sports_entertainment_ecm`.`event`.`match_result`(`match_result_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`insight_request` ADD CONSTRAINT `fk_analytics_insight_request_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`attribution_result` ADD CONSTRAINT `fk_analytics_attribution_result_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`attribution_result` ADD CONSTRAINT `fk_analytics_attribution_result_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_output` ADD CONSTRAINT `fk_analytics_forecast_output_competition_round_id` FOREIGN KEY (`competition_round_id`) REFERENCES `sports_entertainment_ecm`.`event`.`competition_round`(`competition_round_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_output` ADD CONSTRAINT `fk_analytics_forecast_output_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_output` ADD CONSTRAINT `fk_analytics_forecast_output_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_output` ADD CONSTRAINT `fk_analytics_forecast_output_match_result_id` FOREIGN KEY (`match_result_id`) REFERENCES `sports_entertainment_ecm`.`event`.`match_result`(`match_result_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`engagement_index` ADD CONSTRAINT `fk_analytics_engagement_index_competition_round_id` FOREIGN KEY (`competition_round_id`) REFERENCES `sports_entertainment_ecm`.`event`.`competition_round`(`competition_round_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`engagement_index` ADD CONSTRAINT `fk_analytics_engagement_index_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`engagement_index` ADD CONSTRAINT `fk_analytics_engagement_index_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);

-- ========= analytics --> fan (8 constraint(s)) =========
-- Requires: analytics schema, fan schema
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`fan_score` ADD CONSTRAINT `fk_analytics_fan_score_fan_fan_profile_id` FOREIGN KEY (`fan_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`fan_score` ADD CONSTRAINT `fk_analytics_fan_score_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`audience_demographic` ADD CONSTRAINT `fk_analytics_audience_demographic_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`segment`(`segment_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`insight_request` ADD CONSTRAINT `fk_analytics_insight_request_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`segment`(`segment_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`attribution_result` ADD CONSTRAINT `fk_analytics_attribution_result_engagement_event_id` FOREIGN KEY (`engagement_event_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`engagement_event`(`engagement_event_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`attribution_result` ADD CONSTRAINT `fk_analytics_attribution_result_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_output` ADD CONSTRAINT `fk_analytics_forecast_output_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`loyalty_program`(`loyalty_program_id`);

-- ========= analytics --> finance (22 constraint(s)) =========
-- Requires: analytics schema, finance schema
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`model_run` ADD CONSTRAINT `fk_analytics_model_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`audience_measurement` ADD CONSTRAINT `fk_analytics_audience_measurement_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`pipeline_run` ADD CONSTRAINT `fk_analytics_pipeline_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`dashboard_definition` ADD CONSTRAINT `fk_analytics_dashboard_definition_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`attribution_model` ADD CONSTRAINT `fk_analytics_attribution_model_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`attribution_result` ADD CONSTRAINT `fk_analytics_attribution_result_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_model` ADD CONSTRAINT `fk_analytics_forecast_model_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_model` ADD CONSTRAINT `fk_analytics_forecast_model_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_model` ADD CONSTRAINT `fk_analytics_forecast_model_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_output` ADD CONSTRAINT `fk_analytics_forecast_output_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_output` ADD CONSTRAINT `fk_analytics_forecast_output_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_output` ADD CONSTRAINT `fk_analytics_forecast_output_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_output` ADD CONSTRAINT `fk_analytics_forecast_output_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_output` ADD CONSTRAINT `fk_analytics_forecast_output_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);

-- ========= analytics --> gaming (6 constraint(s)) =========
-- Requires: analytics schema, gaming schema
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`fan_score` ADD CONSTRAINT `fk_analytics_fan_score_bettor_account_id` FOREIGN KEY (`bettor_account_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`bettor_account`(`bettor_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`attribution_result` ADD CONSTRAINT `fk_analytics_attribution_result_bonus_redemption_id` FOREIGN KEY (`bonus_redemption_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`bonus_redemption`(`bonus_redemption_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`attribution_result` ADD CONSTRAINT `fk_analytics_attribution_result_wager_id` FOREIGN KEY (`wager_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`wager`(`wager_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_model` ADD CONSTRAINT `fk_analytics_forecast_model_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_output` ADD CONSTRAINT `fk_analytics_forecast_output_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`jurisdiction`(`jurisdiction_id`);

-- ========= analytics --> league (30 constraint(s)) =========
-- Requires: analytics schema, league schema
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`fan_behavior_model` ADD CONSTRAINT `fk_analytics_fan_behavior_model_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`fan_score` ADD CONSTRAINT `fk_analytics_fan_score_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`fan_score` ADD CONSTRAINT `fk_analytics_fan_score_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`fan_score` ADD CONSTRAINT `fk_analytics_fan_score_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`fan_score` ADD CONSTRAINT `fk_analytics_fan_score_team_franchise_id` FOREIGN KEY (`team_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`audience_measurement` ADD CONSTRAINT `fk_analytics_audience_measurement_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`audience_measurement` ADD CONSTRAINT `fk_analytics_audience_measurement_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`audience_demographic` ADD CONSTRAINT `fk_analytics_audience_demographic_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`audience_demographic` ADD CONSTRAINT `fk_analytics_audience_demographic_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`performance_analytics_snapshot` ADD CONSTRAINT `fk_analytics_performance_analytics_snapshot_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`performance_analytics_snapshot` ADD CONSTRAINT `fk_analytics_performance_analytics_snapshot_game_result_id` FOREIGN KEY (`game_result_id`) REFERENCES `sports_entertainment_ecm`.`league`.`game_result`(`game_result_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`performance_analytics_snapshot` ADD CONSTRAINT `fk_analytics_performance_analytics_snapshot_opponent_team_franchise_id` FOREIGN KEY (`opponent_team_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`performance_analytics_snapshot` ADD CONSTRAINT `fk_analytics_performance_analytics_snapshot_primary_performance_franchise_id` FOREIGN KEY (`primary_performance_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`performance_analytics_snapshot` ADD CONSTRAINT `fk_analytics_performance_analytics_snapshot_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`insight_request` ADD CONSTRAINT `fk_analytics_insight_request_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`dashboard_definition` ADD CONSTRAINT `fk_analytics_dashboard_definition_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`dashboard_definition` ADD CONSTRAINT `fk_analytics_dashboard_definition_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`attribution_result` ADD CONSTRAINT `fk_analytics_attribution_result_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_model` ADD CONSTRAINT `fk_analytics_forecast_model_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_model` ADD CONSTRAINT `fk_analytics_forecast_model_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_output` ADD CONSTRAINT `fk_analytics_forecast_output_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_output` ADD CONSTRAINT `fk_analytics_forecast_output_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_output` ADD CONSTRAINT `fk_analytics_forecast_output_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`engagement_index` ADD CONSTRAINT `fk_analytics_engagement_index_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`engagement_index` ADD CONSTRAINT `fk_analytics_engagement_index_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`engagement_index` ADD CONSTRAINT `fk_analytics_engagement_index_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);

-- ========= analytics --> legal (3 constraint(s)) =========
-- Requires: analytics schema, legal schema
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`insight_request` ADD CONSTRAINT `fk_analytics_insight_request_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_output` ADD CONSTRAINT `fk_analytics_forecast_output_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);

-- ========= analytics --> merchandise (4 constraint(s)) =========
-- Requires: analytics schema, merchandise schema
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`attribution_result` ADD CONSTRAINT `fk_analytics_attribution_result_merch_order_id` FOREIGN KEY (`merch_order_id`) REFERENCES `sports_entertainment_ecm`.`merchandise`.`merch_order`(`merch_order_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`attribution_result` ADD CONSTRAINT `fk_analytics_attribution_result_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `sports_entertainment_ecm`.`merchandise`.`promotion`(`promotion_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_output` ADD CONSTRAINT `fk_analytics_forecast_output_retail_location_id` FOREIGN KEY (`retail_location_id`) REFERENCES `sports_entertainment_ecm`.`merchandise`.`retail_location`(`retail_location_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_output` ADD CONSTRAINT `fk_analytics_forecast_output_sku_catalog_id` FOREIGN KEY (`sku_catalog_id`) REFERENCES `sports_entertainment_ecm`.`merchandise`.`sku_catalog`(`sku_catalog_id`);

-- ========= analytics --> platform (8 constraint(s)) =========
-- Requires: analytics schema, platform schema
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`audience_measurement` ADD CONSTRAINT `fk_analytics_audience_measurement_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`dashboard_definition` ADD CONSTRAINT `fk_analytics_dashboard_definition_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`attribution_result` ADD CONSTRAINT `fk_analytics_attribution_result_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`attribution_result` ADD CONSTRAINT `fk_analytics_attribution_result_notification_campaign_id` FOREIGN KEY (`notification_campaign_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`notification_campaign`(`notification_campaign_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_model` ADD CONSTRAINT `fk_analytics_forecast_model_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`engagement_index` ADD CONSTRAINT `fk_analytics_engagement_index_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`engagement_index` ADD CONSTRAINT `fk_analytics_engagement_index_fan_segment_id` FOREIGN KEY (`fan_segment_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`fan_segment`(`fan_segment_id`);

-- ========= analytics --> security (1 constraint(s)) =========
-- Requires: analytics schema, security schema
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`insight_request` ADD CONSTRAINT `fk_analytics_insight_request_after_action_report_id` FOREIGN KEY (`after_action_report_id`) REFERENCES `sports_entertainment_ecm`.`security`.`after_action_report`(`after_action_report_id`);

-- ========= analytics --> ticketing (5 constraint(s)) =========
-- Requires: analytics schema, ticketing schema
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`fan_score` ADD CONSTRAINT `fk_analytics_fan_score_season_ticket_account_id` FOREIGN KEY (`season_ticket_account_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`season_ticket_account`(`season_ticket_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`attribution_result` ADD CONSTRAINT `fk_analytics_attribution_result_season_ticket_package_id` FOREIGN KEY (`season_ticket_package_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`season_ticket_package`(`season_ticket_package_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`attribution_result` ADD CONSTRAINT `fk_analytics_attribution_result_ticket_order_id` FOREIGN KEY (`ticket_order_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`ticket_order`(`ticket_order_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_output` ADD CONSTRAINT `fk_analytics_forecast_output_price_tier_id` FOREIGN KEY (`price_tier_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`price_tier`(`price_tier_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_output` ADD CONSTRAINT `fk_analytics_forecast_output_season_ticket_package_id` FOREIGN KEY (`season_ticket_package_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`season_ticket_package`(`season_ticket_package_id`);

-- ========= analytics --> venue (7 constraint(s)) =========
-- Requires: analytics schema, venue schema
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`facility`(`facility_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`audience_measurement` ADD CONSTRAINT `fk_analytics_audience_measurement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`facility`(`facility_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`performance_analytics_snapshot` ADD CONSTRAINT `fk_analytics_performance_analytics_snapshot_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_output` ADD CONSTRAINT `fk_analytics_forecast_output_capacity_config_id` FOREIGN KEY (`capacity_config_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`capacity_config`(`capacity_config_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_output` ADD CONSTRAINT `fk_analytics_forecast_output_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`facility`(`facility_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`engagement_index` ADD CONSTRAINT `fk_analytics_engagement_index_capacity_config_id` FOREIGN KEY (`capacity_config_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`capacity_config`(`capacity_config_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`engagement_index` ADD CONSTRAINT `fk_analytics_engagement_index_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);

-- ========= analytics --> workforce (25 constraint(s)) =========
-- Requires: analytics schema, workforce schema
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`fan_behavior_model` ADD CONSTRAINT `fk_analytics_fan_behavior_model_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`fan_behavior_model` ADD CONSTRAINT `fk_analytics_fan_behavior_model_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`model_run` ADD CONSTRAINT `fk_analytics_model_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`model_run` ADD CONSTRAINT `fk_analytics_model_run_initiated_by_user_employee_id` FOREIGN KEY (`initiated_by_user_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`pipeline_definition` ADD CONSTRAINT `fk_analytics_pipeline_definition_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`pipeline_definition` ADD CONSTRAINT `fk_analytics_pipeline_definition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`pipeline_run` ADD CONSTRAINT `fk_analytics_pipeline_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`insight_request` ADD CONSTRAINT `fk_analytics_insight_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`insight_request` ADD CONSTRAINT `fk_analytics_insight_request_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`dashboard_definition` ADD CONSTRAINT `fk_analytics_dashboard_definition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`feature_store_entity` ADD CONSTRAINT `fk_analytics_feature_store_entity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`experiment` ADD CONSTRAINT `fk_analytics_experiment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`experiment` ADD CONSTRAINT `fk_analytics_experiment_experiment_employee_id` FOREIGN KEY (`experiment_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`experiment` ADD CONSTRAINT `fk_analytics_experiment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`experiment` ADD CONSTRAINT `fk_analytics_experiment_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`experiment` ADD CONSTRAINT `fk_analytics_experiment_reviewer_id` FOREIGN KEY (`reviewer_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`attribution_model` ADD CONSTRAINT `fk_analytics_attribution_model_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`attribution_model` ADD CONSTRAINT `fk_analytics_attribution_model_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_model` ADD CONSTRAINT `fk_analytics_forecast_model_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_model` ADD CONSTRAINT `fk_analytics_forecast_model_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`analytics`.`forecast_output` ADD CONSTRAINT `fk_analytics_forecast_output_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`org_unit`(`org_unit_id`);

-- ========= athlete --> analytics (4 constraint(s)) =========
-- Requires: athlete schema, analytics schema
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ADD CONSTRAINT `fk_athlete_athlete_contract_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ADD CONSTRAINT `fk_athlete_performance_stat_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ADD CONSTRAINT `fk_athlete_performance_stat_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ADD CONSTRAINT `fk_athlete_award_honor_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);

-- ========= athlete --> broadcast (3 constraint(s)) =========
-- Requires: athlete schema, broadcast schema
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ADD CONSTRAINT `fk_athlete_scouting_report_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`media_asset`(`media_asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ADD CONSTRAINT `fk_athlete_award_honor_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`media_asset`(`media_asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ADD CONSTRAINT `fk_athlete_international_cap_broadcast_rights_window_id` FOREIGN KEY (`broadcast_rights_window_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_rights_window`(`broadcast_rights_window_id`);

-- ========= athlete --> compliance (15 constraint(s)) =========
-- Requires: athlete schema, compliance schema
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ADD CONSTRAINT `fk_athlete_athlete_contract_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ADD CONSTRAINT `fk_athlete_eligibility_status_exemption_id` FOREIGN KEY (`exemption_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`exemption`(`exemption_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ADD CONSTRAINT `fk_athlete_eligibility_status_governing_body_id` FOREIGN KEY (`governing_body_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`governing_body`(`governing_body_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ADD CONSTRAINT `fk_athlete_eligibility_status_incident_report_id` FOREIGN KEY (`incident_report_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`incident_report`(`incident_report_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ADD CONSTRAINT `fk_athlete_eligibility_status_sanction_id` FOREIGN KEY (`sanction_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`sanction`(`sanction_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ADD CONSTRAINT `fk_athlete_nil_agreement_governing_body_id` FOREIGN KEY (`governing_body_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`governing_body`(`governing_body_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ADD CONSTRAINT `fk_athlete_nil_agreement_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ADD CONSTRAINT `fk_athlete_agent_relationship_governing_body_id` FOREIGN KEY (`governing_body_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`governing_body`(`governing_body_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ADD CONSTRAINT `fk_athlete_suspension_record_doping_violation_id` FOREIGN KEY (`doping_violation_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`doping_violation`(`doping_violation_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ADD CONSTRAINT `fk_athlete_suspension_record_governing_body_id` FOREIGN KEY (`governing_body_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`governing_body`(`governing_body_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ADD CONSTRAINT `fk_athlete_suspension_record_sanction_id` FOREIGN KEY (`sanction_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`sanction`(`sanction_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ADD CONSTRAINT `fk_athlete_combine_result_doping_test_id` FOREIGN KEY (`doping_test_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`doping_test`(`doping_test_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ADD CONSTRAINT `fk_athlete_award_honor_sanction_id` FOREIGN KEY (`sanction_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`sanction`(`sanction_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ADD CONSTRAINT `fk_athlete_salary_cap_entry_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ADD CONSTRAINT `fk_athlete_international_cap_whereabouts_filing_id` FOREIGN KEY (`whereabouts_filing_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`whereabouts_filing`(`whereabouts_filing_id`);

-- ========= athlete --> content (4 constraint(s)) =========
-- Requires: athlete schema, content schema
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ADD CONSTRAINT `fk_athlete_draft_selection_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ADD CONSTRAINT `fk_athlete_combine_result_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ADD CONSTRAINT `fk_athlete_scouting_report_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ADD CONSTRAINT `fk_athlete_award_honor_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);

-- ========= athlete --> event (8 constraint(s)) =========
-- Requires: athlete schema, event schema
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ADD CONSTRAINT `fk_athlete_performance_stat_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ADD CONSTRAINT `fk_athlete_injury_record_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ADD CONSTRAINT `fk_athlete_injury_record_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ADD CONSTRAINT `fk_athlete_combine_result_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ADD CONSTRAINT `fk_athlete_international_cap_competition_tournament_id` FOREIGN KEY (`competition_tournament_id`) REFERENCES `sports_entertainment_ecm`.`event`.`tournament`(`tournament_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ADD CONSTRAINT `fk_athlete_international_cap_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ADD CONSTRAINT `fk_athlete_international_cap_match_fixture_id` FOREIGN KEY (`match_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ADD CONSTRAINT `fk_athlete_international_cap_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `sports_entertainment_ecm`.`event`.`tournament`(`tournament_id`);

-- ========= athlete --> finance (12 constraint(s)) =========
-- Requires: athlete schema, finance schema
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ADD CONSTRAINT `fk_athlete_athlete_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ADD CONSTRAINT `fk_athlete_athlete_contract_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ADD CONSTRAINT `fk_athlete_athlete_contract_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ADD CONSTRAINT `fk_athlete_injury_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ADD CONSTRAINT `fk_athlete_injury_record_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ADD CONSTRAINT `fk_athlete_draft_selection_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ADD CONSTRAINT `fk_athlete_nil_agreement_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ADD CONSTRAINT `fk_athlete_nil_agreement_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ADD CONSTRAINT `fk_athlete_suspension_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ADD CONSTRAINT `fk_athlete_salary_cap_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ADD CONSTRAINT `fk_athlete_salary_cap_entry_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ADD CONSTRAINT `fk_athlete_international_cap_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);

-- ========= athlete --> league (64 constraint(s)) =========
-- Requires: athlete schema, league schema
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ADD CONSTRAINT `fk_athlete_roster_cba_agreement_id` FOREIGN KEY (`cba_agreement_id`) REFERENCES `sports_entertainment_ecm`.`league`.`cba_agreement`(`cba_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ADD CONSTRAINT `fk_athlete_roster_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ADD CONSTRAINT `fk_athlete_roster_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ADD CONSTRAINT `fk_athlete_roster_loaned_from_team_franchise_id` FOREIGN KEY (`loaned_from_team_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ADD CONSTRAINT `fk_athlete_roster_primary_roster_franchise_id` FOREIGN KEY (`primary_roster_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ADD CONSTRAINT `fk_athlete_roster_roster_franchise_id` FOREIGN KEY (`roster_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ADD CONSTRAINT `fk_athlete_roster_roster_loaned_from_team_franchise_id` FOREIGN KEY (`roster_loaned_from_team_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ADD CONSTRAINT `fk_athlete_roster_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ADD CONSTRAINT `fk_athlete_roster_transaction_window_id` FOREIGN KEY (`transaction_window_id`) REFERENCES `sports_entertainment_ecm`.`league`.`transaction_window`(`transaction_window_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ADD CONSTRAINT `fk_athlete_athlete_profile_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ADD CONSTRAINT `fk_athlete_athlete_profile_team_id` FOREIGN KEY (`team_id`) REFERENCES `sports_entertainment_ecm`.`league`.`team`(`team_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ADD CONSTRAINT `fk_athlete_athlete_contract_cba_agreement_id` FOREIGN KEY (`cba_agreement_id`) REFERENCES `sports_entertainment_ecm`.`league`.`cba_agreement`(`cba_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ADD CONSTRAINT `fk_athlete_athlete_contract_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ADD CONSTRAINT `fk_athlete_athlete_contract_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ADD CONSTRAINT `fk_athlete_athlete_contract_team_franchise_id` FOREIGN KEY (`team_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ADD CONSTRAINT `fk_athlete_performance_stat_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ADD CONSTRAINT `fk_athlete_performance_stat_game_result_id` FOREIGN KEY (`game_result_id`) REFERENCES `sports_entertainment_ecm`.`league`.`game_result`(`game_result_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ADD CONSTRAINT `fk_athlete_performance_stat_opponent_team_franchise_id` FOREIGN KEY (`opponent_team_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ADD CONSTRAINT `fk_athlete_performance_stat_primary_performance_franchise_id` FOREIGN KEY (`primary_performance_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ADD CONSTRAINT `fk_athlete_performance_stat_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ADD CONSTRAINT `fk_athlete_injury_record_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ADD CONSTRAINT `fk_athlete_injury_record_game_result_id` FOREIGN KEY (`game_result_id`) REFERENCES `sports_entertainment_ecm`.`league`.`game_result`(`game_result_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ADD CONSTRAINT `fk_athlete_injury_record_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ADD CONSTRAINT `fk_athlete_injury_record_team_franchise_id` FOREIGN KEY (`team_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ADD CONSTRAINT `fk_athlete_draft_selection_cba_agreement_id` FOREIGN KEY (`cba_agreement_id`) REFERENCES `sports_entertainment_ecm`.`league`.`cba_agreement`(`cba_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ADD CONSTRAINT `fk_athlete_draft_selection_draft_class_draft_id` FOREIGN KEY (`draft_class_draft_id`) REFERENCES `sports_entertainment_ecm`.`league`.`draft`(`draft_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ADD CONSTRAINT `fk_athlete_draft_selection_draft_id` FOREIGN KEY (`draft_id`) REFERENCES `sports_entertainment_ecm`.`league`.`draft`(`draft_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ADD CONSTRAINT `fk_athlete_draft_selection_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ADD CONSTRAINT `fk_athlete_draft_selection_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ADD CONSTRAINT `fk_athlete_draft_selection_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ADD CONSTRAINT `fk_athlete_draft_selection_original_team_franchise_id` FOREIGN KEY (`original_team_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ADD CONSTRAINT `fk_athlete_draft_selection_primary_draft_franchise_id` FOREIGN KEY (`primary_draft_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ADD CONSTRAINT `fk_athlete_eligibility_status_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ADD CONSTRAINT `fk_athlete_eligibility_status_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ADD CONSTRAINT `fk_athlete_nil_agreement_cba_agreement_id` FOREIGN KEY (`cba_agreement_id`) REFERENCES `sports_entertainment_ecm`.`league`.`cba_agreement`(`cba_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ADD CONSTRAINT `fk_athlete_agent_relationship_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ADD CONSTRAINT `fk_athlete_suspension_record_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ADD CONSTRAINT `fk_athlete_suspension_record_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ADD CONSTRAINT `fk_athlete_suspension_record_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ADD CONSTRAINT `fk_athlete_suspension_record_team_franchise_id` FOREIGN KEY (`team_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ADD CONSTRAINT `fk_athlete_combine_result_draft_id` FOREIGN KEY (`draft_id`) REFERENCES `sports_entertainment_ecm`.`league`.`draft`(`draft_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ADD CONSTRAINT `fk_athlete_combine_result_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ADD CONSTRAINT `fk_athlete_scouting_report_draft_id` FOREIGN KEY (`draft_id`) REFERENCES `sports_entertainment_ecm`.`league`.`draft`(`draft_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ADD CONSTRAINT `fk_athlete_scouting_report_draft_pick_id` FOREIGN KEY (`draft_pick_id`) REFERENCES `sports_entertainment_ecm`.`league`.`draft_pick`(`draft_pick_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ADD CONSTRAINT `fk_athlete_scouting_report_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ADD CONSTRAINT `fk_athlete_award_honor_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ADD CONSTRAINT `fk_athlete_award_honor_game_result_id` FOREIGN KEY (`game_result_id`) REFERENCES `sports_entertainment_ecm`.`league`.`game_result`(`game_result_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ADD CONSTRAINT `fk_athlete_award_honor_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ADD CONSTRAINT `fk_athlete_award_honor_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ADD CONSTRAINT `fk_athlete_award_honor_team_franchise_id` FOREIGN KEY (`team_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ADD CONSTRAINT `fk_athlete_salary_cap_entry_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ADD CONSTRAINT `fk_athlete_salary_cap_entry_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ADD CONSTRAINT `fk_athlete_salary_cap_entry_salary_cap_id` FOREIGN KEY (`salary_cap_id`) REFERENCES `sports_entertainment_ecm`.`league`.`salary_cap`(`salary_cap_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ADD CONSTRAINT `fk_athlete_salary_cap_entry_team_franchise_id` FOREIGN KEY (`team_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ADD CONSTRAINT `fk_athlete_free_agency_status_cba_agreement_id` FOREIGN KEY (`cba_agreement_id`) REFERENCES `sports_entertainment_ecm`.`league`.`cba_agreement`(`cba_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ADD CONSTRAINT `fk_athlete_free_agency_status_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ADD CONSTRAINT `fk_athlete_free_agency_status_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ADD CONSTRAINT `fk_athlete_free_agency_status_primary_free_franchise_id` FOREIGN KEY (`primary_free_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ADD CONSTRAINT `fk_athlete_free_agency_status_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ADD CONSTRAINT `fk_athlete_free_agency_status_signing_team_franchise_id` FOREIGN KEY (`signing_team_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ADD CONSTRAINT `fk_athlete_free_agency_status_transaction_window_id` FOREIGN KEY (`transaction_window_id`) REFERENCES `sports_entertainment_ecm`.`league`.`transaction_window`(`transaction_window_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ADD CONSTRAINT `fk_athlete_international_cap_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ADD CONSTRAINT `fk_athlete_international_cap_international_federation_id` FOREIGN KEY (`international_federation_id`) REFERENCES `sports_entertainment_ecm`.`league`.`international_federation`(`international_federation_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ADD CONSTRAINT `fk_athlete_international_cap_national_team_franchise_id` FOREIGN KEY (`national_team_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);

-- ========= athlete --> legal (16 constraint(s)) =========
-- Requires: athlete schema, legal schema
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ADD CONSTRAINT `fk_athlete_athlete_contract_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ADD CONSTRAINT `fk_athlete_athlete_contract_insurance_policy_id` FOREIGN KEY (`insurance_policy_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`insurance_policy`(`insurance_policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ADD CONSTRAINT `fk_athlete_athlete_contract_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ADD CONSTRAINT `fk_athlete_injury_record_insurance_claim_id` FOREIGN KEY (`insurance_claim_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`insurance_claim`(`insurance_claim_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ADD CONSTRAINT `fk_athlete_draft_selection_contract_template_id` FOREIGN KEY (`contract_template_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`contract_template`(`contract_template_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ADD CONSTRAINT `fk_athlete_eligibility_status_litigation_case_id` FOREIGN KEY (`litigation_case_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`litigation_case`(`litigation_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ADD CONSTRAINT `fk_athlete_eligibility_status_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ADD CONSTRAINT `fk_athlete_nil_agreement_contract_template_id` FOREIGN KEY (`contract_template_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`contract_template`(`contract_template_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ADD CONSTRAINT `fk_athlete_nil_agreement_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ADD CONSTRAINT `fk_athlete_nil_agreement_ip_portfolio_id` FOREIGN KEY (`ip_portfolio_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`ip_portfolio`(`ip_portfolio_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ADD CONSTRAINT `fk_athlete_nil_agreement_nda_id` FOREIGN KEY (`nda_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`nda`(`nda_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ADD CONSTRAINT `fk_athlete_agent_relationship_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ADD CONSTRAINT `fk_athlete_agent_relationship_nda_id` FOREIGN KEY (`nda_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`nda`(`nda_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ADD CONSTRAINT `fk_athlete_suspension_record_litigation_case_id` FOREIGN KEY (`litigation_case_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`litigation_case`(`litigation_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ADD CONSTRAINT `fk_athlete_suspension_record_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ADD CONSTRAINT `fk_athlete_free_agency_status_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);

-- ========= athlete --> merchandise (1 constraint(s)) =========
-- Requires: athlete schema, merchandise schema
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ADD CONSTRAINT `fk_athlete_nil_agreement_sku_catalog_id` FOREIGN KEY (`sku_catalog_id`) REFERENCES `sports_entertainment_ecm`.`merchandise`.`sku_catalog`(`sku_catalog_id`);

-- ========= athlete --> partner (1 constraint(s)) =========
-- Requires: athlete schema, partner schema
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ADD CONSTRAINT `fk_athlete_performance_stat_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);

-- ========= athlete --> security (1 constraint(s)) =========
-- Requires: athlete schema, security schema
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ADD CONSTRAINT `fk_athlete_injury_record_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `sports_entertainment_ecm`.`security`.`security_incident`(`security_incident_id`);

-- ========= athlete --> sponsorship (6 constraint(s)) =========
-- Requires: athlete schema, sponsorship schema
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ADD CONSTRAINT `fk_athlete_nil_agreement_brand_partner_sponsor_id` FOREIGN KEY (`brand_partner_sponsor_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`sponsor`(`sponsor_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ADD CONSTRAINT `fk_athlete_nil_agreement_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`deal`(`deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ADD CONSTRAINT `fk_athlete_nil_agreement_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`sponsor`(`sponsor_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ADD CONSTRAINT `fk_athlete_combine_result_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`prospect`(`prospect_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ADD CONSTRAINT `fk_athlete_scouting_report_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`prospect`(`prospect_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ADD CONSTRAINT `fk_athlete_award_honor_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`sponsor`(`sponsor_id`);

-- ========= athlete --> venue (6 constraint(s)) =========
-- Requires: athlete schema, venue schema
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ADD CONSTRAINT `fk_athlete_performance_stat_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`facility`(`facility_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ADD CONSTRAINT `fk_athlete_injury_record_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`facility`(`facility_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ADD CONSTRAINT `fk_athlete_draft_selection_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`facility`(`facility_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ADD CONSTRAINT `fk_athlete_nil_agreement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`facility`(`facility_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ADD CONSTRAINT `fk_athlete_combine_result_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`facility`(`facility_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_event` ADD CONSTRAINT `fk_athlete_combine_event_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);

-- ========= athlete --> workforce (7 constraint(s)) =========
-- Requires: athlete schema, workforce schema
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ADD CONSTRAINT `fk_athlete_roster_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ADD CONSTRAINT `fk_athlete_athlete_contract_position_id` FOREIGN KEY (`position_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ADD CONSTRAINT `fk_athlete_injury_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ADD CONSTRAINT `fk_athlete_combine_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ADD CONSTRAINT `fk_athlete_combine_result_scout_employee_id` FOREIGN KEY (`scout_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ADD CONSTRAINT `fk_athlete_scouting_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ADD CONSTRAINT `fk_athlete_scouting_report_evaluator_employee_id` FOREIGN KEY (`evaluator_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= broadcast --> athlete (1 constraint(s)) =========
-- Requires: broadcast schema, athlete schema
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`media_asset` ADD CONSTRAINT `fk_broadcast_media_asset_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);

-- ========= broadcast --> compliance (6 constraint(s)) =========
-- Requires: broadcast schema, compliance schema
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`media_rights_deal` ADD CONSTRAINT `fk_broadcast_media_rights_deal_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`channel` ADD CONSTRAINT `fk_broadcast_channel_governing_body_id` FOREIGN KEY (`governing_body_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`governing_body`(`governing_body_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`ppv_transaction` ADD CONSTRAINT `fk_broadcast_ppv_transaction_data_processing_record_id` FOREIGN KEY (`data_processing_record_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`data_processing_record`(`data_processing_record_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`streaming_subscription` ADD CONSTRAINT `fk_broadcast_streaming_subscription_data_processing_record_id` FOREIGN KEY (`data_processing_record_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`data_processing_record`(`data_processing_record_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`rights_violation` ADD CONSTRAINT `fk_broadcast_rights_violation_incident_report_id` FOREIGN KEY (`incident_report_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`incident_report`(`incident_report_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`sublicense_agreement` ADD CONSTRAINT `fk_broadcast_sublicense_agreement_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= broadcast --> content (23 constraint(s)) =========
-- Requires: broadcast schema, content schema
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule` ADD CONSTRAINT `fk_broadcast_broadcast_schedule_content_drm_policy_id` FOREIGN KEY (`content_drm_policy_id`) REFERENCES `sports_entertainment_ecm`.`content`.`content_drm_policy`(`content_drm_policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule` ADD CONSTRAINT `fk_broadcast_broadcast_schedule_platform_channel_id` FOREIGN KEY (`platform_channel_id`) REFERENCES `sports_entertainment_ecm`.`content`.`platform_channel`(`platform_channel_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`live_feed` ADD CONSTRAINT `fk_broadcast_live_feed_content_rights_window_id` FOREIGN KEY (`content_rights_window_id`) REFERENCES `sports_entertainment_ecm`.`content`.`content_rights_window`(`content_rights_window_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`live_feed` ADD CONSTRAINT `fk_broadcast_live_feed_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`live_feed` ADD CONSTRAINT `fk_broadcast_live_feed_platform_channel_id` FOREIGN KEY (`platform_channel_id`) REFERENCES `sports_entertainment_ecm`.`content`.`platform_channel`(`platform_channel_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`ppv_package` ADD CONSTRAINT `fk_broadcast_ppv_package_syndication_deal_id` FOREIGN KEY (`syndication_deal_id`) REFERENCES `sports_entertainment_ecm`.`content`.`syndication_deal`(`syndication_deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`media_asset` ADD CONSTRAINT `fk_broadcast_media_asset_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`media_asset` ADD CONSTRAINT `fk_broadcast_media_asset_rights_clearance_id` FOREIGN KEY (`rights_clearance_id`) REFERENCES `sports_entertainment_ecm`.`content`.`rights_clearance`(`rights_clearance_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`broadcast_rights_window` ADD CONSTRAINT `fk_broadcast_broadcast_rights_window_content_category_id` FOREIGN KEY (`content_category_id`) REFERENCES `sports_entertainment_ecm`.`content`.`content_category`(`content_category_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`rights_violation` ADD CONSTRAINT `fk_broadcast_rights_violation_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`rights_violation` ADD CONSTRAINT `fk_broadcast_rights_violation_content_drm_policy_id` FOREIGN KEY (`content_drm_policy_id`) REFERENCES `sports_entertainment_ecm`.`content`.`content_drm_policy`(`content_drm_policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`rights_violation` ADD CONSTRAINT `fk_broadcast_rights_violation_rights_clearance_id` FOREIGN KEY (`rights_clearance_id`) REFERENCES `sports_entertainment_ecm`.`content`.`rights_clearance`(`rights_clearance_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`audience_rating` ADD CONSTRAINT `fk_broadcast_audience_rating_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`audience_rating` ADD CONSTRAINT `fk_broadcast_audience_rating_content_asset_id` FOREIGN KEY (`content_asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`audience_rating` ADD CONSTRAINT `fk_broadcast_audience_rating_platform_channel_id` FOREIGN KEY (`platform_channel_id`) REFERENCES `sports_entertainment_ecm`.`content`.`platform_channel`(`platform_channel_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`broadcast_ad_inventory` ADD CONSTRAINT `fk_broadcast_broadcast_ad_inventory_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`ad_placement` ADD CONSTRAINT `fk_broadcast_ad_placement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`sublicense_agreement` ADD CONSTRAINT `fk_broadcast_sublicense_agreement_content_license_id` FOREIGN KEY (`content_license_id`) REFERENCES `sports_entertainment_ecm`.`content`.`content_license`(`content_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`sublicense_agreement` ADD CONSTRAINT `fk_broadcast_sublicense_agreement_rights_clearance_id` FOREIGN KEY (`rights_clearance_id`) REFERENCES `sports_entertainment_ecm`.`content`.`rights_clearance`(`rights_clearance_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`rights_royalty` ADD CONSTRAINT `fk_broadcast_rights_royalty_content_drm_policy_id` FOREIGN KEY (`content_drm_policy_id`) REFERENCES `sports_entertainment_ecm`.`content`.`content_drm_policy`(`content_drm_policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`rights_royalty` ADD CONSTRAINT `fk_broadcast_rights_royalty_content_license_id` FOREIGN KEY (`content_license_id`) REFERENCES `sports_entertainment_ecm`.`content`.`content_license`(`content_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`rights_royalty` ADD CONSTRAINT `fk_broadcast_rights_royalty_rights_clearance_id` FOREIGN KEY (`rights_clearance_id`) REFERENCES `sports_entertainment_ecm`.`content`.`rights_clearance`(`rights_clearance_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`rights_window_channel_authorization` ADD CONSTRAINT `fk_broadcast_rights_window_channel_authorization_platform_channel_id` FOREIGN KEY (`platform_channel_id`) REFERENCES `sports_entertainment_ecm`.`content`.`platform_channel`(`platform_channel_id`);

-- ========= broadcast --> event (16 constraint(s)) =========
-- Requires: broadcast schema, event schema
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule` ADD CONSTRAINT `fk_broadcast_broadcast_schedule_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule` ADD CONSTRAINT `fk_broadcast_broadcast_schedule_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`blackout_rule` ADD CONSTRAINT `fk_broadcast_blackout_rule_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`blackout_rule` ADD CONSTRAINT `fk_broadcast_blackout_rule_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`live_feed` ADD CONSTRAINT `fk_broadcast_live_feed_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`live_feed` ADD CONSTRAINT `fk_broadcast_live_feed_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`ppv_package` ADD CONSTRAINT `fk_broadcast_ppv_package_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`ppv_package` ADD CONSTRAINT `fk_broadcast_ppv_package_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`ppv_transaction` ADD CONSTRAINT `fk_broadcast_ppv_transaction_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`ppv_transaction` ADD CONSTRAINT `fk_broadcast_ppv_transaction_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`media_asset` ADD CONSTRAINT `fk_broadcast_media_asset_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`media_asset` ADD CONSTRAINT `fk_broadcast_media_asset_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`broadcast_rights_window` ADD CONSTRAINT `fk_broadcast_broadcast_rights_window_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`broadcast_rights_window` ADD CONSTRAINT `fk_broadcast_broadcast_rights_window_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`production` ADD CONSTRAINT `fk_broadcast_production_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`production` ADD CONSTRAINT `fk_broadcast_production_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);

-- ========= broadcast --> fan (8 constraint(s)) =========
-- Requires: broadcast schema, fan schema
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`ppv_package` ADD CONSTRAINT `fk_broadcast_ppv_package_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`ppv_transaction` ADD CONSTRAINT `fk_broadcast_ppv_transaction_buyer_fan_profile_id` FOREIGN KEY (`buyer_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`ppv_transaction` ADD CONSTRAINT `fk_broadcast_ppv_transaction_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`payment_method`(`payment_method_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`ppv_transaction` ADD CONSTRAINT `fk_broadcast_ppv_transaction_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`streaming_subscription` ADD CONSTRAINT `fk_broadcast_streaming_subscription_fan_fan_profile_id` FOREIGN KEY (`fan_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`streaming_subscription` ADD CONSTRAINT `fk_broadcast_streaming_subscription_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`payment_method`(`payment_method_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`streaming_subscription` ADD CONSTRAINT `fk_broadcast_streaming_subscription_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`streaming_subscription` ADD CONSTRAINT `fk_broadcast_streaming_subscription_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`loyalty_program`(`loyalty_program_id`);

-- ========= broadcast --> finance (28 constraint(s)) =========
-- Requires: broadcast schema, finance schema
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`media_rights_deal` ADD CONSTRAINT `fk_broadcast_media_rights_deal_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`media_rights_deal` ADD CONSTRAINT `fk_broadcast_media_rights_deal_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`channel` ADD CONSTRAINT `fk_broadcast_channel_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`channel` ADD CONSTRAINT `fk_broadcast_channel_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`channel` ADD CONSTRAINT `fk_broadcast_channel_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`live_feed` ADD CONSTRAINT `fk_broadcast_live_feed_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`ppv_package` ADD CONSTRAINT `fk_broadcast_ppv_package_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`ppv_transaction` ADD CONSTRAINT `fk_broadcast_ppv_transaction_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`ppv_transaction` ADD CONSTRAINT `fk_broadcast_ppv_transaction_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`payment`(`payment_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`ppv_transaction` ADD CONSTRAINT `fk_broadcast_ppv_transaction_payment_transaction_payment_id` FOREIGN KEY (`payment_transaction_payment_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`payment`(`payment_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`ppv_transaction` ADD CONSTRAINT `fk_broadcast_ppv_transaction_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`streaming_subscription` ADD CONSTRAINT `fk_broadcast_streaming_subscription_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`streaming_subscription` ADD CONSTRAINT `fk_broadcast_streaming_subscription_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`broadcast_rights_window` ADD CONSTRAINT `fk_broadcast_broadcast_rights_window_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`production` ADD CONSTRAINT `fk_broadcast_production_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`production` ADD CONSTRAINT `fk_broadcast_production_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`production` ADD CONSTRAINT `fk_broadcast_production_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`rights_violation` ADD CONSTRAINT `fk_broadcast_rights_violation_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`rights_violation` ADD CONSTRAINT `fk_broadcast_rights_violation_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`broadcast_ad_inventory` ADD CONSTRAINT `fk_broadcast_broadcast_ad_inventory_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`ad_placement` ADD CONSTRAINT `fk_broadcast_ad_placement_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`sublicense_agreement` ADD CONSTRAINT `fk_broadcast_sublicense_agreement_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`rights_royalty` ADD CONSTRAINT `fk_broadcast_rights_royalty_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`rights_royalty` ADD CONSTRAINT `fk_broadcast_rights_royalty_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`rights_royalty` ADD CONSTRAINT `fk_broadcast_rights_royalty_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`rights_royalty` ADD CONSTRAINT `fk_broadcast_rights_royalty_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`rights_royalty` ADD CONSTRAINT `fk_broadcast_rights_royalty_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`rights_royalty` ADD CONSTRAINT `fk_broadcast_rights_royalty_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);

-- ========= broadcast --> league (10 constraint(s)) =========
-- Requires: broadcast schema, league schema
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`media_rights_deal` ADD CONSTRAINT `fk_broadcast_media_rights_deal_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule` ADD CONSTRAINT `fk_broadcast_broadcast_schedule_league_schedule_id` FOREIGN KEY (`league_schedule_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league_schedule`(`league_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule` ADD CONSTRAINT `fk_broadcast_broadcast_schedule_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule` ADD CONSTRAINT `fk_broadcast_broadcast_schedule_playoff_bracket_id` FOREIGN KEY (`playoff_bracket_id`) REFERENCES `sports_entertainment_ecm`.`league`.`playoff_bracket`(`playoff_bracket_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`media_asset` ADD CONSTRAINT `fk_broadcast_media_asset_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`broadcast_rights_window` ADD CONSTRAINT `fk_broadcast_broadcast_rights_window_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`broadcast_rights_window` ADD CONSTRAINT `fk_broadcast_broadcast_rights_window_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`audience_rating` ADD CONSTRAINT `fk_broadcast_audience_rating_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`sublicense_agreement` ADD CONSTRAINT `fk_broadcast_sublicense_agreement_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`rights_agreement` ADD CONSTRAINT `fk_broadcast_rights_agreement_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);

-- ========= broadcast --> legal (18 constraint(s)) =========
-- Requires: broadcast schema, legal schema
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`media_rights_deal` ADD CONSTRAINT `fk_broadcast_media_rights_deal_ip_portfolio_id` FOREIGN KEY (`ip_portfolio_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`ip_portfolio`(`ip_portfolio_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`media_rights_deal` ADD CONSTRAINT `fk_broadcast_media_rights_deal_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`media_rights_deal` ADD CONSTRAINT `fk_broadcast_media_rights_deal_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`channel` ADD CONSTRAINT `fk_broadcast_channel_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`channel` ADD CONSTRAINT `fk_broadcast_channel_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`media_asset` ADD CONSTRAINT `fk_broadcast_media_asset_ip_portfolio_id` FOREIGN KEY (`ip_portfolio_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`ip_portfolio`(`ip_portfolio_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`broadcast_rights_window` ADD CONSTRAINT `fk_broadcast_broadcast_rights_window_ip_portfolio_id` FOREIGN KEY (`ip_portfolio_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`ip_portfolio`(`ip_portfolio_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`broadcast_rights_window` ADD CONSTRAINT `fk_broadcast_broadcast_rights_window_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`broadcast_rights_window` ADD CONSTRAINT `fk_broadcast_broadcast_rights_window_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`broadcast_rights_window` ADD CONSTRAINT `fk_broadcast_broadcast_rights_window_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`rights_violation` ADD CONSTRAINT `fk_broadcast_rights_violation_ip_enforcement_action_id` FOREIGN KEY (`ip_enforcement_action_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`ip_enforcement_action`(`ip_enforcement_action_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`rights_violation` ADD CONSTRAINT `fk_broadcast_rights_violation_litigation_case_id` FOREIGN KEY (`litigation_case_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`litigation_case`(`litigation_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`rights_violation` ADD CONSTRAINT `fk_broadcast_rights_violation_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`sublicense_agreement` ADD CONSTRAINT `fk_broadcast_sublicense_agreement_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`sublicense_agreement` ADD CONSTRAINT `fk_broadcast_sublicense_agreement_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`sublicense_agreement` ADD CONSTRAINT `fk_broadcast_sublicense_agreement_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`rights_royalty` ADD CONSTRAINT `fk_broadcast_rights_royalty_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`rights_royalty` ADD CONSTRAINT `fk_broadcast_rights_royalty_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);

-- ========= broadcast --> merchandise (1 constraint(s)) =========
-- Requires: broadcast schema, merchandise schema
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`ppv_transaction` ADD CONSTRAINT `fk_broadcast_ppv_transaction_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `sports_entertainment_ecm`.`merchandise`.`promotion`(`promotion_id`);

-- ========= broadcast --> partner (11 constraint(s)) =========
-- Requires: broadcast schema, partner schema
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`media_rights_deal` ADD CONSTRAINT `fk_broadcast_media_rights_deal_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule` ADD CONSTRAINT `fk_broadcast_broadcast_schedule_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`channel` ADD CONSTRAINT `fk_broadcast_channel_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`channel` ADD CONSTRAINT `fk_broadcast_channel_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`live_feed` ADD CONSTRAINT `fk_broadcast_live_feed_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`ppv_transaction` ADD CONSTRAINT `fk_broadcast_ppv_transaction_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`media_asset` ADD CONSTRAINT `fk_broadcast_media_asset_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`production` ADD CONSTRAINT `fk_broadcast_production_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`audience_rating` ADD CONSTRAINT `fk_broadcast_audience_rating_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`sublicense_agreement` ADD CONSTRAINT `fk_broadcast_sublicense_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`rights_royalty` ADD CONSTRAINT `fk_broadcast_rights_royalty_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);

-- ========= broadcast --> platform (15 constraint(s)) =========
-- Requires: broadcast schema, platform schema
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule` ADD CONSTRAINT `fk_broadcast_broadcast_schedule_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`live_feed` ADD CONSTRAINT `fk_broadcast_live_feed_sla_policy_id` FOREIGN KEY (`sla_policy_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`sla_policy`(`sla_policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`ppv_package` ADD CONSTRAINT `fk_broadcast_ppv_package_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`ppv_transaction` ADD CONSTRAINT `fk_broadcast_ppv_transaction_device_registration_id` FOREIGN KEY (`device_registration_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`device_registration`(`device_registration_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`ppv_transaction` ADD CONSTRAINT `fk_broadcast_ppv_transaction_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`streaming_subscription` ADD CONSTRAINT `fk_broadcast_streaming_subscription_device_registration_id` FOREIGN KEY (`device_registration_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`device_registration`(`device_registration_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`streaming_subscription` ADD CONSTRAINT `fk_broadcast_streaming_subscription_digital_subscription_id` FOREIGN KEY (`digital_subscription_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_subscription`(`digital_subscription_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`streaming_subscription` ADD CONSTRAINT `fk_broadcast_streaming_subscription_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`streaming_subscription` ADD CONSTRAINT `fk_broadcast_streaming_subscription_sla_policy_id` FOREIGN KEY (`sla_policy_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`sla_policy`(`sla_policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`broadcast_rights_window` ADD CONSTRAINT `fk_broadcast_broadcast_rights_window_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`audience_rating` ADD CONSTRAINT `fk_broadcast_audience_rating_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`broadcast_ad_inventory` ADD CONSTRAINT `fk_broadcast_broadcast_ad_inventory_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`ad_placement` ADD CONSTRAINT `fk_broadcast_ad_placement_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`sublicense_agreement` ADD CONSTRAINT `fk_broadcast_sublicense_agreement_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`platform_rights_grant` ADD CONSTRAINT `fk_broadcast_platform_rights_grant_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);

-- ========= broadcast --> sponsorship (11 constraint(s)) =========
-- Requires: broadcast schema, sponsorship schema
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule` ADD CONSTRAINT `fk_broadcast_broadcast_schedule_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`deal`(`deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`production` ADD CONSTRAINT `fk_broadcast_production_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`deal`(`deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`audience_rating` ADD CONSTRAINT `fk_broadcast_audience_rating_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`deal`(`deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`broadcast_ad_inventory` ADD CONSTRAINT `fk_broadcast_broadcast_ad_inventory_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`advertiser`(`advertiser_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`broadcast_ad_inventory` ADD CONSTRAINT `fk_broadcast_broadcast_ad_inventory_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`deal`(`deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`broadcast_ad_inventory` ADD CONSTRAINT `fk_broadcast_broadcast_ad_inventory_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`sponsor`(`sponsor_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`broadcast_ad_inventory` ADD CONSTRAINT `fk_broadcast_broadcast_ad_inventory_sponsorship_activation_id` FOREIGN KEY (`sponsorship_activation_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation`(`sponsorship_activation_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`broadcast_ad_inventory` ADD CONSTRAINT `fk_broadcast_broadcast_ad_inventory_sponsorship_ad_inventory_id` FOREIGN KEY (`sponsorship_ad_inventory_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`sponsorship_ad_inventory`(`sponsorship_ad_inventory_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`ad_placement` ADD CONSTRAINT `fk_broadcast_ad_placement_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`advertiser`(`advertiser_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`ad_placement` ADD CONSTRAINT `fk_broadcast_ad_placement_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`sponsor`(`sponsor_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`ad_placement` ADD CONSTRAINT `fk_broadcast_ad_placement_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`deal`(`deal_id`);

-- ========= broadcast --> ticketing (4 constraint(s)) =========
-- Requires: broadcast schema, ticketing schema
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`ppv_transaction` ADD CONSTRAINT `fk_broadcast_ppv_transaction_access_entitlement_id` FOREIGN KEY (`access_entitlement_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`access_entitlement`(`access_entitlement_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`ppv_transaction` ADD CONSTRAINT `fk_broadcast_ppv_transaction_ticket_order_id` FOREIGN KEY (`ticket_order_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`ticket_order`(`ticket_order_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`streaming_subscription` ADD CONSTRAINT `fk_broadcast_streaming_subscription_season_ticket_account_id` FOREIGN KEY (`season_ticket_account_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`season_ticket_account`(`season_ticket_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`streaming_subscription` ADD CONSTRAINT `fk_broadcast_streaming_subscription_season_ticket_package_id` FOREIGN KEY (`season_ticket_package_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`season_ticket_package`(`season_ticket_package_id`);

-- ========= broadcast --> venue (6 constraint(s)) =========
-- Requires: broadcast schema, venue schema
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule` ADD CONSTRAINT `fk_broadcast_broadcast_schedule_capacity_config_id` FOREIGN KEY (`capacity_config_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`capacity_config`(`capacity_config_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule` ADD CONSTRAINT `fk_broadcast_broadcast_schedule_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`live_feed` ADD CONSTRAINT `fk_broadcast_live_feed_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`production` ADD CONSTRAINT `fk_broadcast_production_capacity_config_id` FOREIGN KEY (`capacity_config_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`capacity_config`(`capacity_config_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`production` ADD CONSTRAINT `fk_broadcast_production_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`production_team` ADD CONSTRAINT `fk_broadcast_production_team_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);

-- ========= broadcast --> workforce (1 constraint(s)) =========
-- Requires: broadcast schema, workforce schema
ALTER TABLE `sports_entertainment_ecm`.`broadcast`.`production` ADD CONSTRAINT `fk_broadcast_production_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= compliance --> analytics (7 constraint(s)) =========
-- Requires: compliance schema, analytics schema
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_dashboard_definition_id` FOREIGN KEY (`dashboard_definition_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`dashboard_definition`(`dashboard_definition_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`doping_test` ADD CONSTRAINT `fk_compliance_doping_test_pipeline_definition_id` FOREIGN KEY (`pipeline_definition_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`pipeline_definition`(`pipeline_definition_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`whereabouts_filing` ADD CONSTRAINT `fk_compliance_whereabouts_filing_pipeline_definition_id` FOREIGN KEY (`pipeline_definition_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`pipeline_definition`(`pipeline_definition_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`breach_notification` ADD CONSTRAINT `fk_compliance_breach_notification_dashboard_definition_id` FOREIGN KEY (`dashboard_definition_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`dashboard_definition`(`dashboard_definition_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`pia_assessment` ADD CONSTRAINT `fk_compliance_pia_assessment_dashboard_definition_id` FOREIGN KEY (`dashboard_definition_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`dashboard_definition`(`dashboard_definition_id`);

-- ========= compliance --> athlete (11 constraint(s)) =========
-- Requires: compliance schema, athlete schema
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`doping_test` ADD CONSTRAINT `fk_compliance_doping_test_athlete_athlete_profile_id` FOREIGN KEY (`athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`doping_test` ADD CONSTRAINT `fk_compliance_doping_test_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`doping_violation` ADD CONSTRAINT `fk_compliance_doping_violation_athlete_athlete_profile_id` FOREIGN KEY (`athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`doping_violation` ADD CONSTRAINT `fk_compliance_doping_violation_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`whereabouts_filing` ADD CONSTRAINT `fk_compliance_whereabouts_filing_athlete_athlete_profile_id` FOREIGN KEY (`athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`whereabouts_filing` ADD CONSTRAINT `fk_compliance_whereabouts_filing_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`eligibility_certification` ADD CONSTRAINT `fk_compliance_eligibility_certification_athlete_athlete_profile_id` FOREIGN KEY (`athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`eligibility_certification` ADD CONSTRAINT `fk_compliance_eligibility_certification_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`sanction` ADD CONSTRAINT `fk_compliance_sanction_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`exemption` ADD CONSTRAINT `fk_compliance_exemption_applicant_athlete_athlete_profile_id` FOREIGN KEY (`applicant_athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`exemption` ADD CONSTRAINT `fk_compliance_exemption_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);

-- ========= compliance --> event (10 constraint(s)) =========
-- Requires: compliance schema, event schema
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`doping_test` ADD CONSTRAINT `fk_compliance_doping_test_competition_event_fixture_id` FOREIGN KEY (`competition_event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`doping_test` ADD CONSTRAINT `fk_compliance_doping_test_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`eligibility_certification` ADD CONSTRAINT `fk_compliance_eligibility_certification_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`eligibility_certification` ADD CONSTRAINT `fk_compliance_eligibility_certification_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`ada_accommodation` ADD CONSTRAINT `fk_compliance_ada_accommodation_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`ada_accommodation` ADD CONSTRAINT `fk_compliance_ada_accommodation_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`incident_report` ADD CONSTRAINT `fk_compliance_incident_report_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`license_permit` ADD CONSTRAINT `fk_compliance_license_permit_calendar_id` FOREIGN KEY (`calendar_id`) REFERENCES `sports_entertainment_ecm`.`event`.`calendar`(`calendar_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`license_permit` ADD CONSTRAINT `fk_compliance_license_permit_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`license_permit` ADD CONSTRAINT `fk_compliance_license_permit_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `sports_entertainment_ecm`.`event`.`tournament`(`tournament_id`);

-- ========= compliance --> fan (2 constraint(s)) =========
-- Requires: compliance schema, fan schema
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_fan_fan_profile_id` FOREIGN KEY (`fan_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);

-- ========= compliance --> finance (13 constraint(s)) =========
-- Requires: compliance schema, finance schema
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`audit_schedule` ADD CONSTRAINT `fk_compliance_audit_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`audit_schedule` ADD CONSTRAINT `fk_compliance_audit_schedule_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`sox_control`(`sox_control_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`sox_control`(`sox_control_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`sox_control`(`sox_control_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`arbitration_case` ADD CONSTRAINT `fk_compliance_arbitration_case_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`data_processing_record` ADD CONSTRAINT `fk_compliance_data_processing_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`incident_report` ADD CONSTRAINT `fk_compliance_incident_report_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`incident_report` ADD CONSTRAINT `fk_compliance_incident_report_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`sanction` ADD CONSTRAINT `fk_compliance_sanction_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`breach_notification` ADD CONSTRAINT `fk_compliance_breach_notification_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`license_permit` ADD CONSTRAINT `fk_compliance_license_permit_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`company_code`(`company_code_id`);

-- ========= compliance --> gaming (2 constraint(s)) =========
-- Requires: compliance schema, gaming schema
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`jurisdiction`(`jurisdiction_id`);

-- ========= compliance --> league (11 constraint(s)) =========
-- Requires: compliance schema, league schema
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_cba_agreement_id` FOREIGN KEY (`cba_agreement_id`) REFERENCES `sports_entertainment_ecm`.`league`.`cba_agreement`(`cba_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`audit_schedule` ADD CONSTRAINT `fk_compliance_audit_schedule_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_cba_agreement_id` FOREIGN KEY (`cba_agreement_id`) REFERENCES `sports_entertainment_ecm`.`league`.`cba_agreement`(`cba_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_salary_cap_id` FOREIGN KEY (`salary_cap_id`) REFERENCES `sports_entertainment_ecm`.`league`.`salary_cap`(`salary_cap_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_cap_compliance_id` FOREIGN KEY (`cap_compliance_id`) REFERENCES `sports_entertainment_ecm`.`league`.`cap_compliance`(`cap_compliance_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`doping_test` ADD CONSTRAINT `fk_compliance_doping_test_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`arbitration_case` ADD CONSTRAINT `fk_compliance_arbitration_case_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`license_permit` ADD CONSTRAINT `fk_compliance_license_permit_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);

-- ========= compliance --> legal (14 constraint(s)) =========
-- Requires: compliance schema, legal schema
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_governance_document_id` FOREIGN KEY (`governance_document_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`governance_document`(`governance_document_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_litigation_case_id` FOREIGN KEY (`litigation_case_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`litigation_case`(`litigation_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`eligibility_certification` ADD CONSTRAINT `fk_compliance_eligibility_certification_litigation_case_id` FOREIGN KEY (`litigation_case_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`litigation_case`(`litigation_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`arbitration_case` ADD CONSTRAINT `fk_compliance_arbitration_case_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`arbitration_case` ADD CONSTRAINT `fk_compliance_arbitration_case_outside_counsel_id` FOREIGN KEY (`outside_counsel_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`outside_counsel`(`outside_counsel_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`data_processing_record` ADD CONSTRAINT `fk_compliance_data_processing_record_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`ada_accommodation` ADD CONSTRAINT `fk_compliance_ada_accommodation_litigation_case_id` FOREIGN KEY (`litigation_case_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`litigation_case`(`litigation_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`incident_report` ADD CONSTRAINT `fk_compliance_incident_report_litigation_case_id` FOREIGN KEY (`litigation_case_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`litigation_case`(`litigation_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`sanction` ADD CONSTRAINT `fk_compliance_sanction_litigation_case_id` FOREIGN KEY (`litigation_case_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`litigation_case`(`litigation_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`sanction` ADD CONSTRAINT `fk_compliance_sanction_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`breach_notification` ADD CONSTRAINT `fk_compliance_breach_notification_litigation_case_id` FOREIGN KEY (`litigation_case_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`litigation_case`(`litigation_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`license_permit` ADD CONSTRAINT `fk_compliance_license_permit_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);

-- ========= compliance --> partner (2 constraint(s)) =========
-- Requires: compliance schema, partner schema
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`accreditation` ADD CONSTRAINT `fk_compliance_accreditation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);

-- ========= compliance --> security (1 constraint(s)) =========
-- Requires: compliance schema, security schema
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `sports_entertainment_ecm`.`security`.`security_incident`(`security_incident_id`);

-- ========= compliance --> sponsorship (1 constraint(s)) =========
-- Requires: compliance schema, sponsorship schema
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`deal`(`deal_id`);

-- ========= compliance --> ticketing (4 constraint(s)) =========
-- Requires: compliance schema, ticketing schema
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_ticket_order_id` FOREIGN KEY (`ticket_order_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`ticket_order`(`ticket_order_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`ada_accommodation` ADD CONSTRAINT `fk_compliance_ada_accommodation_ticket_inventory_id` FOREIGN KEY (`ticket_inventory_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`ticket_inventory`(`ticket_inventory_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`ada_accommodation` ADD CONSTRAINT `fk_compliance_ada_accommodation_ticket_order_id` FOREIGN KEY (`ticket_order_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`ticket_order`(`ticket_order_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`breach_notification` ADD CONSTRAINT `fk_compliance_breach_notification_ticket_payment_id` FOREIGN KEY (`ticket_payment_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`ticket_payment`(`ticket_payment_id`);

-- ========= compliance --> venue (14 constraint(s)) =========
-- Requires: compliance schema, venue schema
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`audit_schedule` ADD CONSTRAINT `fk_compliance_audit_schedule_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_bms_system_id` FOREIGN KEY (`bms_system_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`bms_system`(`bms_system_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`eligibility_certification` ADD CONSTRAINT `fk_compliance_eligibility_certification_staff_plan_id` FOREIGN KEY (`staff_plan_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`staff_plan`(`staff_plan_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`eligibility_certification` ADD CONSTRAINT `fk_compliance_eligibility_certification_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`ada_accommodation` ADD CONSTRAINT `fk_compliance_ada_accommodation_accessibility_feature_id` FOREIGN KEY (`accessibility_feature_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`accessibility_feature`(`accessibility_feature_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`ada_accommodation` ADD CONSTRAINT `fk_compliance_ada_accommodation_parking_lot_id` FOREIGN KEY (`parking_lot_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`parking_lot`(`parking_lot_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`ada_accommodation` ADD CONSTRAINT `fk_compliance_ada_accommodation_seating_section_id` FOREIGN KEY (`seating_section_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`seating_section`(`seating_section_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`ada_accommodation` ADD CONSTRAINT `fk_compliance_ada_accommodation_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`incident_report` ADD CONSTRAINT `fk_compliance_incident_report_concession_stand_id` FOREIGN KEY (`concession_stand_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`concession_stand`(`concession_stand_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`license_permit` ADD CONSTRAINT `fk_compliance_license_permit_concession_stand_id` FOREIGN KEY (`concession_stand_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`concession_stand`(`concession_stand_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`license_permit` ADD CONSTRAINT `fk_compliance_license_permit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`facility`(`facility_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`license_permit` ADD CONSTRAINT `fk_compliance_license_permit_parking_lot_id` FOREIGN KEY (`parking_lot_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`parking_lot`(`parking_lot_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`license_permit` ADD CONSTRAINT `fk_compliance_license_permit_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);

-- ========= compliance --> workforce (20 constraint(s)) =========
-- Requires: compliance schema, workforce schema
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`governing_body` ADD CONSTRAINT `fk_compliance_governing_body_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`audit_schedule` ADD CONSTRAINT `fk_compliance_audit_schedule_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`audit_schedule` ADD CONSTRAINT `fk_compliance_audit_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`audit_schedule` ADD CONSTRAINT `fk_compliance_audit_schedule_lead_auditor_employee_id` FOREIGN KEY (`lead_auditor_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`audit_engagement` ADD CONSTRAINT `fk_compliance_audit_engagement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`arbitration_case` ADD CONSTRAINT `fk_compliance_arbitration_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`arbitration_case` ADD CONSTRAINT `fk_compliance_arbitration_case_internal_counsel_employee_id` FOREIGN KEY (`internal_counsel_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`data_processing_record` ADD CONSTRAINT `fk_compliance_data_processing_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`ada_accommodation` ADD CONSTRAINT `fk_compliance_ada_accommodation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`ada_accommodation` ADD CONSTRAINT `fk_compliance_ada_accommodation_primary_ada_employee_id` FOREIGN KEY (`primary_ada_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`incident_report` ADD CONSTRAINT `fk_compliance_incident_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`breach_notification` ADD CONSTRAINT `fk_compliance_breach_notification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`pia_assessment` ADD CONSTRAINT `fk_compliance_pia_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`license_permit` ADD CONSTRAINT `fk_compliance_license_permit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`investigation` ADD CONSTRAINT `fk_compliance_investigation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`compliance`.`investigation` ADD CONSTRAINT `fk_compliance_investigation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`org_unit`(`org_unit_id`);

-- ========= content --> analytics (3 constraint(s)) =========
-- Requires: content schema, analytics schema
ALTER TABLE `sports_entertainment_ecm`.`content`.`ingest_job` ADD CONSTRAINT `fk_content_ingest_job_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`publish_event` ADD CONSTRAINT `fk_content_publish_event_pipeline_definition_id` FOREIGN KEY (`pipeline_definition_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`pipeline_definition`(`pipeline_definition_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`transcript` ADD CONSTRAINT `fk_content_transcript_pipeline_definition_id` FOREIGN KEY (`pipeline_definition_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`pipeline_definition`(`pipeline_definition_id`);

-- ========= content --> athlete (14 constraint(s)) =========
-- Requires: content schema, athlete schema
ALTER TABLE `sports_entertainment_ecm`.`content`.`asset` ADD CONSTRAINT `fk_content_asset_athlete_athlete_profile_id` FOREIGN KEY (`athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`asset` ADD CONSTRAINT `fk_content_asset_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`asset` ADD CONSTRAINT `fk_content_asset_nil_agreement_id` FOREIGN KEY (`nil_agreement_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`nil_agreement`(`nil_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`rights_clearance` ADD CONSTRAINT `fk_content_rights_clearance_nil_agreement_id` FOREIGN KEY (`nil_agreement_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`nil_agreement`(`nil_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`production_order` ADD CONSTRAINT `fk_content_production_order_athlete_athlete_profile_id` FOREIGN KEY (`athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`production_order` ADD CONSTRAINT `fk_content_production_order_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`production_order` ADD CONSTRAINT `fk_content_production_order_nil_agreement_id` FOREIGN KEY (`nil_agreement_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`nil_agreement`(`nil_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`collection` ADD CONSTRAINT `fk_content_collection_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`ugc_submission` ADD CONSTRAINT `fk_content_ugc_submission_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`ugc_submission` ADD CONSTRAINT `fk_content_ugc_submission_featured_athlete_athlete_profile_id` FOREIGN KEY (`featured_athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`editorial_brief` ADD CONSTRAINT `fk_content_editorial_brief_athlete_athlete_profile_id` FOREIGN KEY (`athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`editorial_brief` ADD CONSTRAINT `fk_content_editorial_brief_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`asset_usage` ADD CONSTRAINT `fk_content_asset_usage_nil_agreement_id` FOREIGN KEY (`nil_agreement_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`nil_agreement`(`nil_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`syndication_deal` ADD CONSTRAINT `fk_content_syndication_deal_athlete_contract_id` FOREIGN KEY (`athlete_contract_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_contract`(`athlete_contract_id`);

-- ========= content --> broadcast (13 constraint(s)) =========
-- Requires: content schema, broadcast schema
ALTER TABLE `sports_entertainment_ecm`.`content`.`content_rights_window` ADD CONSTRAINT `fk_content_content_rights_window_media_rights_deal_id` FOREIGN KEY (`media_rights_deal_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`media_rights_deal`(`media_rights_deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`content_rights_window` ADD CONSTRAINT `fk_content_content_rights_window_rights_agreement_id` FOREIGN KEY (`rights_agreement_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`rights_agreement`(`rights_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`ingest_job` ADD CONSTRAINT `fk_content_ingest_job_live_feed_id` FOREIGN KEY (`live_feed_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`live_feed`(`live_feed_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`publish_event` ADD CONSTRAINT `fk_content_publish_event_rights_agreement_id` FOREIGN KEY (`rights_agreement_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`rights_agreement`(`rights_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`publish_event` ADD CONSTRAINT `fk_content_publish_event_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`publish_event` ADD CONSTRAINT `fk_content_publish_event_media_rights_deal_id` FOREIGN KEY (`media_rights_deal_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`media_rights_deal`(`media_rights_deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`collection` ADD CONSTRAINT `fk_content_collection_broadcast_rights_window_id` FOREIGN KEY (`broadcast_rights_window_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_rights_window`(`broadcast_rights_window_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`platform_channel` ADD CONSTRAINT `fk_content_platform_channel_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`channel`(`channel_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`rights_conflict` ADD CONSTRAINT `fk_content_rights_conflict_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`channel`(`channel_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`rights_conflict` ADD CONSTRAINT `fk_content_rights_conflict_broadcast_rights_window_id` FOREIGN KEY (`broadcast_rights_window_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_rights_window`(`broadcast_rights_window_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`asset_usage` ADD CONSTRAINT `fk_content_asset_usage_broadcast_rights_window_id` FOREIGN KEY (`broadcast_rights_window_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_rights_window`(`broadcast_rights_window_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`asset_usage` ADD CONSTRAINT `fk_content_asset_usage_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`media_asset`(`media_asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`syndication_deal` ADD CONSTRAINT `fk_content_syndication_deal_broadcast_rights_window_id` FOREIGN KEY (`broadcast_rights_window_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_rights_window`(`broadcast_rights_window_id`);

-- ========= content --> compliance (13 constraint(s)) =========
-- Requires: content schema, compliance schema
ALTER TABLE `sports_entertainment_ecm`.`content`.`rights_clearance` ADD CONSTRAINT `fk_content_rights_clearance_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`rights_clearance` ADD CONSTRAINT `fk_content_rights_clearance_governing_body_id` FOREIGN KEY (`governing_body_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`governing_body`(`governing_body_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`content_rights_window` ADD CONSTRAINT `fk_content_content_rights_window_governing_body_id` FOREIGN KEY (`governing_body_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`governing_body`(`governing_body_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`ingest_job` ADD CONSTRAINT `fk_content_ingest_job_data_processing_record_id` FOREIGN KEY (`data_processing_record_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`data_processing_record`(`data_processing_record_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`publish_event` ADD CONSTRAINT `fk_content_publish_event_license_permit_id` FOREIGN KEY (`license_permit_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`license_permit`(`license_permit_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`ugc_submission` ADD CONSTRAINT `fk_content_ugc_submission_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`ugc_submission` ADD CONSTRAINT `fk_content_ugc_submission_data_processing_record_id` FOREIGN KEY (`data_processing_record_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`data_processing_record`(`data_processing_record_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`platform_channel` ADD CONSTRAINT `fk_content_platform_channel_license_permit_id` FOREIGN KEY (`license_permit_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`license_permit`(`license_permit_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`rights_conflict` ADD CONSTRAINT `fk_content_rights_conflict_incident_report_id` FOREIGN KEY (`incident_report_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`incident_report`(`incident_report_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`approval` ADD CONSTRAINT `fk_content_approval_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`syndication_deal` ADD CONSTRAINT `fk_content_syndication_deal_governing_body_id` FOREIGN KEY (`governing_body_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`governing_body`(`governing_body_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`transcript` ADD CONSTRAINT `fk_content_transcript_governing_body_id` FOREIGN KEY (`governing_body_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`governing_body`(`governing_body_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`creator_profile` ADD CONSTRAINT `fk_content_creator_profile_data_processing_record_id` FOREIGN KEY (`data_processing_record_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`data_processing_record`(`data_processing_record_id`);

-- ========= content --> event (30 constraint(s)) =========
-- Requires: content schema, event schema
ALTER TABLE `sports_entertainment_ecm`.`content`.`asset` ADD CONSTRAINT `fk_content_asset_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`asset` ADD CONSTRAINT `fk_content_asset_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`content_rights_window` ADD CONSTRAINT `fk_content_content_rights_window_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `sports_entertainment_ecm`.`event`.`tournament`(`tournament_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`production_order` ADD CONSTRAINT `fk_content_production_order_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`production_order` ADD CONSTRAINT `fk_content_production_order_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`production_order` ADD CONSTRAINT `fk_content_production_order_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `sports_entertainment_ecm`.`event`.`tournament`(`tournament_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`ingest_job` ADD CONSTRAINT `fk_content_ingest_job_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`ingest_job` ADD CONSTRAINT `fk_content_ingest_job_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`ingest_job` ADD CONSTRAINT `fk_content_ingest_job_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `sports_entertainment_ecm`.`event`.`tournament`(`tournament_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`publish_event` ADD CONSTRAINT `fk_content_publish_event_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`publish_event` ADD CONSTRAINT `fk_content_publish_event_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`publish_event` ADD CONSTRAINT `fk_content_publish_event_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `sports_entertainment_ecm`.`event`.`tournament`(`tournament_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`collection` ADD CONSTRAINT `fk_content_collection_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`collection` ADD CONSTRAINT `fk_content_collection_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`collection` ADD CONSTRAINT `fk_content_collection_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `sports_entertainment_ecm`.`event`.`tournament`(`tournament_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`ugc_submission` ADD CONSTRAINT `fk_content_ugc_submission_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`ugc_submission` ADD CONSTRAINT `fk_content_ugc_submission_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`content_license` ADD CONSTRAINT `fk_content_content_license_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `sports_entertainment_ecm`.`event`.`tournament`(`tournament_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`editorial_brief` ADD CONSTRAINT `fk_content_editorial_brief_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`editorial_brief` ADD CONSTRAINT `fk_content_editorial_brief_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`editorial_brief` ADD CONSTRAINT `fk_content_editorial_brief_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `sports_entertainment_ecm`.`event`.`tournament`(`tournament_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`rights_conflict` ADD CONSTRAINT `fk_content_rights_conflict_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`rights_conflict` ADD CONSTRAINT `fk_content_rights_conflict_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`rights_conflict` ADD CONSTRAINT `fk_content_rights_conflict_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `sports_entertainment_ecm`.`event`.`tournament`(`tournament_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`asset_usage` ADD CONSTRAINT `fk_content_asset_usage_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`asset_usage` ADD CONSTRAINT `fk_content_asset_usage_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`asset_usage` ADD CONSTRAINT `fk_content_asset_usage_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `sports_entertainment_ecm`.`event`.`tournament`(`tournament_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`syndication_deal` ADD CONSTRAINT `fk_content_syndication_deal_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `sports_entertainment_ecm`.`event`.`tournament`(`tournament_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`transcript` ADD CONSTRAINT `fk_content_transcript_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`transcript` ADD CONSTRAINT `fk_content_transcript_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);

-- ========= content --> fan (5 constraint(s)) =========
-- Requires: content schema, fan schema
ALTER TABLE `sports_entertainment_ecm`.`content`.`collection` ADD CONSTRAINT `fk_content_collection_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`segment`(`segment_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`ugc_submission` ADD CONSTRAINT `fk_content_ugc_submission_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`editorial_brief` ADD CONSTRAINT `fk_content_editorial_brief_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`segment`(`segment_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`asset_usage` ADD CONSTRAINT `fk_content_asset_usage_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`segment`(`segment_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`creator_profile` ADD CONSTRAINT `fk_content_creator_profile_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);

-- ========= content --> finance (15 constraint(s)) =========
-- Requires: content schema, finance schema
ALTER TABLE `sports_entertainment_ecm`.`content`.`rights_clearance` ADD CONSTRAINT `fk_content_rights_clearance_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`rights_clearance` ADD CONSTRAINT `fk_content_rights_clearance_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`content_rights_window` ADD CONSTRAINT `fk_content_content_rights_window_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`production_order` ADD CONSTRAINT `fk_content_production_order_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`production_order` ADD CONSTRAINT `fk_content_production_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`production_order` ADD CONSTRAINT `fk_content_production_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`content_license` ADD CONSTRAINT `fk_content_content_license_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`content_license` ADD CONSTRAINT `fk_content_content_license_revenue_recognition_schedule_id` FOREIGN KEY (`revenue_recognition_schedule_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_recognition_schedule`(`revenue_recognition_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`content_license` ADD CONSTRAINT `fk_content_content_license_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`asset_usage` ADD CONSTRAINT `fk_content_asset_usage_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`syndication_deal` ADD CONSTRAINT `fk_content_syndication_deal_revenue_recognition_schedule_id` FOREIGN KEY (`revenue_recognition_schedule_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_recognition_schedule`(`revenue_recognition_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`syndication_deal` ADD CONSTRAINT `fk_content_syndication_deal_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`syndication_deal` ADD CONSTRAINT `fk_content_syndication_deal_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`syndication_deal` ADD CONSTRAINT `fk_content_syndication_deal_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`revenue_attribution` ADD CONSTRAINT `fk_content_revenue_attribution_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);

-- ========= content --> gaming (5 constraint(s)) =========
-- Requires: content schema, gaming schema
ALTER TABLE `sports_entertainment_ecm`.`content`.`ingest_job` ADD CONSTRAINT `fk_content_ingest_job_esports_match_id` FOREIGN KEY (`esports_match_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`esports_match`(`esports_match_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`publish_event` ADD CONSTRAINT `fk_content_publish_event_betting_market_id` FOREIGN KEY (`betting_market_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`betting_market`(`betting_market_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`editorial_brief` ADD CONSTRAINT `fk_content_editorial_brief_prop_bet_id` FOREIGN KEY (`prop_bet_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`prop_bet`(`prop_bet_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`asset_usage` ADD CONSTRAINT `fk_content_asset_usage_contest_id` FOREIGN KEY (`contest_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`contest`(`contest_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`channel_jurisdiction_authorization` ADD CONSTRAINT `fk_content_channel_jurisdiction_authorization_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`jurisdiction`(`jurisdiction_id`);

-- ========= content --> league (15 constraint(s)) =========
-- Requires: content schema, league schema
ALTER TABLE `sports_entertainment_ecm`.`content`.`asset` ADD CONSTRAINT `fk_content_asset_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`production_order` ADD CONSTRAINT `fk_content_production_order_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`production_order` ADD CONSTRAINT `fk_content_production_order_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`ingest_job` ADD CONSTRAINT `fk_content_ingest_job_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`publish_event` ADD CONSTRAINT `fk_content_publish_event_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`collection` ADD CONSTRAINT `fk_content_collection_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`collection` ADD CONSTRAINT `fk_content_collection_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`collection` ADD CONSTRAINT `fk_content_collection_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`ugc_submission` ADD CONSTRAINT `fk_content_ugc_submission_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`content_license` ADD CONSTRAINT `fk_content_content_license_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`editorial_brief` ADD CONSTRAINT `fk_content_editorial_brief_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`editorial_brief` ADD CONSTRAINT `fk_content_editorial_brief_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`rights_conflict` ADD CONSTRAINT `fk_content_rights_conflict_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`asset_usage` ADD CONSTRAINT `fk_content_asset_usage_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`syndication_deal` ADD CONSTRAINT `fk_content_syndication_deal_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);

-- ========= content --> legal (29 constraint(s)) =========
-- Requires: content schema, legal schema
ALTER TABLE `sports_entertainment_ecm`.`content`.`rights_clearance` ADD CONSTRAINT `fk_content_rights_clearance_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`rights_clearance` ADD CONSTRAINT `fk_content_rights_clearance_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`rights_clearance` ADD CONSTRAINT `fk_content_rights_clearance_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`content_rights_window` ADD CONSTRAINT `fk_content_content_rights_window_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`content_rights_window` ADD CONSTRAINT `fk_content_content_rights_window_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`content_rights_window` ADD CONSTRAINT `fk_content_content_rights_window_primary_content_corporate_entity_id` FOREIGN KEY (`primary_content_corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`content_rights_window` ADD CONSTRAINT `fk_content_content_rights_window_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`publish_event` ADD CONSTRAINT `fk_content_publish_event_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`publish_event` ADD CONSTRAINT `fk_content_publish_event_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`publish_event` ADD CONSTRAINT `fk_content_publish_event_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`ugc_submission` ADD CONSTRAINT `fk_content_ugc_submission_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`content_license` ADD CONSTRAINT `fk_content_content_license_contract_template_id` FOREIGN KEY (`contract_template_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`contract_template`(`contract_template_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`content_license` ADD CONSTRAINT `fk_content_content_license_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`content_license` ADD CONSTRAINT `fk_content_content_license_ip_portfolio_id` FOREIGN KEY (`ip_portfolio_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`ip_portfolio`(`ip_portfolio_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`content_license` ADD CONSTRAINT `fk_content_content_license_licensee_corporate_entity_id` FOREIGN KEY (`licensee_corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`content_license` ADD CONSTRAINT `fk_content_content_license_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`content_license` ADD CONSTRAINT `fk_content_content_license_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`rights_conflict` ADD CONSTRAINT `fk_content_rights_conflict_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`rights_conflict` ADD CONSTRAINT `fk_content_rights_conflict_litigation_case_id` FOREIGN KEY (`litigation_case_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`litigation_case`(`litigation_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`rights_conflict` ADD CONSTRAINT `fk_content_rights_conflict_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`rights_conflict` ADD CONSTRAINT `fk_content_rights_conflict_settlement_agreement_id` FOREIGN KEY (`settlement_agreement_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`settlement_agreement`(`settlement_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`asset_usage` ADD CONSTRAINT `fk_content_asset_usage_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`syndication_deal` ADD CONSTRAINT `fk_content_syndication_deal_contract_template_id` FOREIGN KEY (`contract_template_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`contract_template`(`contract_template_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`syndication_deal` ADD CONSTRAINT `fk_content_syndication_deal_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`syndication_deal` ADD CONSTRAINT `fk_content_syndication_deal_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`syndication_deal` ADD CONSTRAINT `fk_content_syndication_deal_nda_id` FOREIGN KEY (`nda_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`nda`(`nda_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`creator_profile` ADD CONSTRAINT `fk_content_creator_profile_contract_template_id` FOREIGN KEY (`contract_template_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`contract_template`(`contract_template_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`creator_profile` ADD CONSTRAINT `fk_content_creator_profile_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`creator_profile` ADD CONSTRAINT `fk_content_creator_profile_nda_id` FOREIGN KEY (`nda_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`nda`(`nda_id`);

-- ========= content --> partner (12 constraint(s)) =========
-- Requires: content schema, partner schema
ALTER TABLE `sports_entertainment_ecm`.`content`.`asset_version` ADD CONSTRAINT `fk_content_asset_version_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`production_order` ADD CONSTRAINT `fk_content_production_order_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`ingest_job` ADD CONSTRAINT `fk_content_ingest_job_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`publish_event` ADD CONSTRAINT `fk_content_publish_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`content_license` ADD CONSTRAINT `fk_content_content_license_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`editorial_brief` ADD CONSTRAINT `fk_content_editorial_brief_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`platform_channel` ADD CONSTRAINT `fk_content_platform_channel_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`rights_conflict` ADD CONSTRAINT `fk_content_rights_conflict_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`syndication_deal` ADD CONSTRAINT `fk_content_syndication_deal_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`syndication_deal` ADD CONSTRAINT `fk_content_syndication_deal_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`transcript` ADD CONSTRAINT `fk_content_transcript_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`creator_profile` ADD CONSTRAINT `fk_content_creator_profile_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);

-- ========= content --> platform (19 constraint(s)) =========
-- Requires: content schema, platform schema
ALTER TABLE `sports_entertainment_ecm`.`content`.`asset_version` ADD CONSTRAINT `fk_content_asset_version_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`rights_clearance` ADD CONSTRAINT `fk_content_rights_clearance_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`content_rights_window` ADD CONSTRAINT `fk_content_content_rights_window_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`production_order` ADD CONSTRAINT `fk_content_production_order_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`ingest_job` ADD CONSTRAINT `fk_content_ingest_job_api_integration_id` FOREIGN KEY (`api_integration_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`api_integration`(`api_integration_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`publish_event` ADD CONSTRAINT `fk_content_publish_event_api_integration_id` FOREIGN KEY (`api_integration_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`api_integration`(`api_integration_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`publish_event` ADD CONSTRAINT `fk_content_publish_event_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`collection` ADD CONSTRAINT `fk_content_collection_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`collection` ADD CONSTRAINT `fk_content_collection_fan_segment_id` FOREIGN KEY (`fan_segment_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`fan_segment`(`fan_segment_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`ugc_submission` ADD CONSTRAINT `fk_content_ugc_submission_notification_campaign_id` FOREIGN KEY (`notification_campaign_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`notification_campaign`(`notification_campaign_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`ugc_submission` ADD CONSTRAINT `fk_content_ugc_submission_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`ugc_submission` ADD CONSTRAINT `fk_content_ugc_submission_fan_account_id` FOREIGN KEY (`fan_account_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`fan_account`(`fan_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`content_license` ADD CONSTRAINT `fk_content_content_license_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`editorial_brief` ADD CONSTRAINT `fk_content_editorial_brief_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`rights_conflict` ADD CONSTRAINT `fk_content_rights_conflict_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`asset_usage` ADD CONSTRAINT `fk_content_asset_usage_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`approval` ADD CONSTRAINT `fk_content_approval_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`syndication_deal` ADD CONSTRAINT `fk_content_syndication_deal_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`creator_profile` ADD CONSTRAINT `fk_content_creator_profile_fan_account_id` FOREIGN KEY (`fan_account_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`fan_account`(`fan_account_id`);

-- ========= content --> security (3 constraint(s)) =========
-- Requires: content schema, security schema
ALTER TABLE `sports_entertainment_ecm`.`content`.`publish_event` ADD CONSTRAINT `fk_content_publish_event_emergency_activation_id` FOREIGN KEY (`emergency_activation_id`) REFERENCES `sports_entertainment_ecm`.`security`.`emergency_activation`(`emergency_activation_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`publish_event` ADD CONSTRAINT `fk_content_publish_event_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `sports_entertainment_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`asset_usage` ADD CONSTRAINT `fk_content_asset_usage_post_id` FOREIGN KEY (`post_id`) REFERENCES `sports_entertainment_ecm`.`security`.`post`(`post_id`);

-- ========= content --> sponsorship (10 constraint(s)) =========
-- Requires: content schema, sponsorship schema
ALTER TABLE `sports_entertainment_ecm`.`content`.`content_rights_window` ADD CONSTRAINT `fk_content_content_rights_window_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`deal`(`deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`production_order` ADD CONSTRAINT `fk_content_production_order_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`sponsor`(`sponsor_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`publish_event` ADD CONSTRAINT `fk_content_publish_event_sponsorship_activation_id` FOREIGN KEY (`sponsorship_activation_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation`(`sponsorship_activation_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`publish_event` ADD CONSTRAINT `fk_content_publish_event_sponsorship_overlay_sponsorship_activation_id` FOREIGN KEY (`sponsorship_overlay_sponsorship_activation_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation`(`sponsorship_activation_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`collection` ADD CONSTRAINT `fk_content_collection_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`sponsor`(`sponsor_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`ugc_submission` ADD CONSTRAINT `fk_content_ugc_submission_sponsorship_activation_id` FOREIGN KEY (`sponsorship_activation_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation`(`sponsorship_activation_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`content_license` ADD CONSTRAINT `fk_content_content_license_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`deal`(`deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`editorial_brief` ADD CONSTRAINT `fk_content_editorial_brief_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`sponsor`(`sponsor_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`asset_usage` ADD CONSTRAINT `fk_content_asset_usage_sponsorship_activation_id` FOREIGN KEY (`sponsorship_activation_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation`(`sponsorship_activation_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`approval` ADD CONSTRAINT `fk_content_approval_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`deal`(`deal_id`);

-- ========= content --> venue (5 constraint(s)) =========
-- Requires: content schema, venue schema
ALTER TABLE `sports_entertainment_ecm`.`content`.`asset` ADD CONSTRAINT `fk_content_asset_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`ingest_job` ADD CONSTRAINT `fk_content_ingest_job_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`collection` ADD CONSTRAINT `fk_content_collection_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`facility`(`facility_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`ugc_submission` ADD CONSTRAINT `fk_content_ugc_submission_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`asset_usage` ADD CONSTRAINT `fk_content_asset_usage_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`facility`(`facility_id`);

-- ========= content --> workforce (39 constraint(s)) =========
-- Requires: content schema, workforce schema
ALTER TABLE `sports_entertainment_ecm`.`content`.`asset_version` ADD CONSTRAINT `fk_content_asset_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`rights_clearance` ADD CONSTRAINT `fk_content_rights_clearance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`rights_clearance` ADD CONSTRAINT `fk_content_rights_clearance_rights_manager_employee_id` FOREIGN KEY (`rights_manager_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`content_rights_window` ADD CONSTRAINT `fk_content_content_rights_window_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`production_order` ADD CONSTRAINT `fk_content_production_order_commissioning_editor_employee_id` FOREIGN KEY (`commissioning_editor_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`production_order` ADD CONSTRAINT `fk_content_production_order_contingent_worker_id` FOREIGN KEY (`contingent_worker_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`contingent_worker`(`contingent_worker_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`production_order` ADD CONSTRAINT `fk_content_production_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`production_order` ADD CONSTRAINT `fk_content_production_order_primary_production_commissioning_editor_employee_id` FOREIGN KEY (`primary_production_commissioning_editor_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`ingest_job` ADD CONSTRAINT `fk_content_ingest_job_contingent_worker_id` FOREIGN KEY (`contingent_worker_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`contingent_worker`(`contingent_worker_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`ingest_job` ADD CONSTRAINT `fk_content_ingest_job_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`publish_event` ADD CONSTRAINT `fk_content_publish_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`publish_event` ADD CONSTRAINT `fk_content_publish_event_operator_employee_id` FOREIGN KEY (`operator_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`metadata_tag` ADD CONSTRAINT `fk_content_metadata_tag_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`collection` ADD CONSTRAINT `fk_content_collection_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`collection` ADD CONSTRAINT `fk_content_collection_collection_approved_by_user_employee_id` FOREIGN KEY (`collection_approved_by_user_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`collection` ADD CONSTRAINT `fk_content_collection_collection_employee_id` FOREIGN KEY (`collection_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`collection` ADD CONSTRAINT `fk_content_collection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`ugc_submission` ADD CONSTRAINT `fk_content_ugc_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`content_license` ADD CONSTRAINT `fk_content_content_license_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`content_drm_policy` ADD CONSTRAINT `fk_content_content_drm_policy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`editorial_brief` ADD CONSTRAINT `fk_content_editorial_brief_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`editorial_brief` ADD CONSTRAINT `fk_content_editorial_brief_approver_id` FOREIGN KEY (`approver_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`editorial_brief` ADD CONSTRAINT `fk_content_editorial_brief_contingent_worker_id` FOREIGN KEY (`contingent_worker_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`contingent_worker`(`contingent_worker_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`editorial_brief` ADD CONSTRAINT `fk_content_editorial_brief_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`editorial_brief` ADD CONSTRAINT `fk_content_editorial_brief_primary_editorial_employee_id` FOREIGN KEY (`primary_editorial_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`rights_conflict` ADD CONSTRAINT `fk_content_rights_conflict_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`rights_conflict` ADD CONSTRAINT `fk_content_rights_conflict_rights_manager_employee_id` FOREIGN KEY (`rights_manager_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`asset_usage` ADD CONSTRAINT `fk_content_asset_usage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`approval` ADD CONSTRAINT `fk_content_approval_approval_employee_id` FOREIGN KEY (`approval_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`approval` ADD CONSTRAINT `fk_content_approval_approval_escalated_to_reviewer_employee_id` FOREIGN KEY (`approval_escalated_to_reviewer_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`approval` ADD CONSTRAINT `fk_content_approval_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`approval` ADD CONSTRAINT `fk_content_approval_escalated_to_reviewer_employee_id` FOREIGN KEY (`escalated_to_reviewer_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`syndication_deal` ADD CONSTRAINT `fk_content_syndication_deal_contract_owner_employee_id` FOREIGN KEY (`contract_owner_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`syndication_deal` ADD CONSTRAINT `fk_content_syndication_deal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`transcript` ADD CONSTRAINT `fk_content_transcript_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`transcript` ADD CONSTRAINT `fk_content_transcript_review_operator_employee_id` FOREIGN KEY (`review_operator_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`creator_profile` ADD CONSTRAINT `fk_content_creator_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`distribution_request` ADD CONSTRAINT `fk_content_distribution_request_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`content`.`distribution_request` ADD CONSTRAINT `fk_content_distribution_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= event --> athlete (9 constraint(s)) =========
-- Requires: event schema, athlete schema
ALTER TABLE `sports_entertainment_ecm`.`event`.`scoring_event` ADD CONSTRAINT `fk_event_scoring_event_assist_athlete_athlete_profile_id` FOREIGN KEY (`assist_athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`scoring_event` ADD CONSTRAINT `fk_event_scoring_event_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`scoring_event` ADD CONSTRAINT `fk_event_scoring_event_primary_scoring_athlete_profile_id` FOREIGN KEY (`primary_scoring_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`production_schedule` ADD CONSTRAINT `fk_event_production_schedule_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`participant` ADD CONSTRAINT `fk_event_participant_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`participant` ADD CONSTRAINT `fk_event_participant_eligibility_status_id` FOREIGN KEY (`eligibility_status_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`eligibility_status`(`eligibility_status_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`participant` ADD CONSTRAINT `fk_event_participant_nil_agreement_id` FOREIGN KEY (`nil_agreement_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`nil_agreement`(`nil_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`event_incident` ADD CONSTRAINT `fk_event_event_incident_athlete_athlete_profile_id` FOREIGN KEY (`athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`event_incident` ADD CONSTRAINT `fk_event_event_incident_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);

-- ========= event --> broadcast (17 constraint(s)) =========
-- Requires: event schema, broadcast schema
ALTER TABLE `sports_entertainment_ecm`.`event`.`fixture` ADD CONSTRAINT `fk_event_fixture_broadcast_channel_id` FOREIGN KEY (`broadcast_channel_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`channel`(`channel_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`fixture` ADD CONSTRAINT `fk_event_fixture_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`channel`(`channel_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`bracket` ADD CONSTRAINT `fk_event_bracket_broadcast_rights_window_id` FOREIGN KEY (`broadcast_rights_window_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_rights_window`(`broadcast_rights_window_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`bracket` ADD CONSTRAINT `fk_event_bracket_media_rights_deal_id` FOREIGN KEY (`media_rights_deal_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`media_rights_deal`(`media_rights_deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`fixture_calendar` ADD CONSTRAINT `fk_event_fixture_calendar_media_rights_deal_id` FOREIGN KEY (`media_rights_deal_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`media_rights_deal`(`media_rights_deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`scoring_event` ADD CONSTRAINT `fk_event_scoring_event_live_feed_id` FOREIGN KEY (`live_feed_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`live_feed`(`live_feed_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`scoring_event` ADD CONSTRAINT `fk_event_scoring_event_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`media_asset`(`media_asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`status_history` ADD CONSTRAINT `fk_event_status_history_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`production_schedule` ADD CONSTRAINT `fk_event_production_schedule_production_id` FOREIGN KEY (`production_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`production`(`production_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`competition_round` ADD CONSTRAINT `fk_event_competition_round_media_rights_deal_id` FOREIGN KEY (`media_rights_deal_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`media_rights_deal`(`media_rights_deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`post_event_report` ADD CONSTRAINT `fk_event_post_event_report_audience_rating_id` FOREIGN KEY (`audience_rating_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`audience_rating`(`audience_rating_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`weather_contingency` ADD CONSTRAINT `fk_event_weather_contingency_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`broadcast_window` ADD CONSTRAINT `fk_event_broadcast_window_production_id` FOREIGN KEY (`production_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`production`(`production_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`broadcast_window` ADD CONSTRAINT `fk_event_broadcast_window_broadcast_rights_window_id` FOREIGN KEY (`broadcast_rights_window_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_rights_window`(`broadcast_rights_window_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`broadcast_window` ADD CONSTRAINT `fk_event_broadcast_window_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`channel`(`channel_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`broadcast_window` ADD CONSTRAINT `fk_event_broadcast_window_media_rights_deal_id` FOREIGN KEY (`media_rights_deal_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`media_rights_deal`(`media_rights_deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`pricing` ADD CONSTRAINT `fk_event_pricing_ppv_package_id` FOREIGN KEY (`ppv_package_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`ppv_package`(`ppv_package_id`);

-- ========= event --> compliance (15 constraint(s)) =========
-- Requires: event schema, compliance schema
ALTER TABLE `sports_entertainment_ecm`.`event`.`calendar` ADD CONSTRAINT `fk_event_calendar_calendar_governing_body_id` FOREIGN KEY (`calendar_governing_body_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`governing_body`(`governing_body_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`calendar` ADD CONSTRAINT `fk_event_calendar_calendar_scheduling_authority_governing_body_id` FOREIGN KEY (`calendar_scheduling_authority_governing_body_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`governing_body`(`governing_body_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`calendar` ADD CONSTRAINT `fk_event_calendar_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`calendar` ADD CONSTRAINT `fk_event_calendar_governing_body_id` FOREIGN KEY (`governing_body_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`governing_body`(`governing_body_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`tournament` ADD CONSTRAINT `fk_event_tournament_governing_body_id` FOREIGN KEY (`governing_body_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`governing_body`(`governing_body_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`bracket` ADD CONSTRAINT `fk_event_bracket_eligibility_certification_id` FOREIGN KEY (`eligibility_certification_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`eligibility_certification`(`eligibility_certification_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`fixture_calendar` ADD CONSTRAINT `fk_event_fixture_calendar_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`fixture_calendar` ADD CONSTRAINT `fk_event_fixture_calendar_governing_body_id` FOREIGN KEY (`governing_body_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`governing_body`(`governing_body_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`fixture_calendar` ADD CONSTRAINT `fk_event_fixture_calendar_scheduling_authority_governing_body_id` FOREIGN KEY (`scheduling_authority_governing_body_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`governing_body`(`governing_body_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`status_history` ADD CONSTRAINT `fk_event_status_history_incident_report_id` FOREIGN KEY (`incident_report_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`incident_report`(`incident_report_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`participant` ADD CONSTRAINT `fk_event_participant_eligibility_certification_id` FOREIGN KEY (`eligibility_certification_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`eligibility_certification`(`eligibility_certification_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`officiating_assignment` ADD CONSTRAINT `fk_event_officiating_assignment_eligibility_certification_id` FOREIGN KEY (`eligibility_certification_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`eligibility_certification`(`eligibility_certification_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`post_event_report` ADD CONSTRAINT `fk_event_post_event_report_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`broadcast_window` ADD CONSTRAINT `fk_event_broadcast_window_license_permit_id` FOREIGN KEY (`license_permit_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`license_permit`(`license_permit_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`attendance_record` ADD CONSTRAINT `fk_event_attendance_record_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= event --> content (3 constraint(s)) =========
-- Requires: event schema, content schema
ALTER TABLE `sports_entertainment_ecm`.`event`.`scoring_event` ADD CONSTRAINT `fk_event_scoring_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`production_schedule` ADD CONSTRAINT `fk_event_production_schedule_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`post_event_report` ADD CONSTRAINT `fk_event_post_event_report_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);

-- ========= event --> fan (1 constraint(s)) =========
-- Requires: event schema, fan schema
ALTER TABLE `sports_entertainment_ecm`.`event`.`attendance_record` ADD CONSTRAINT `fk_event_attendance_record_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);

-- ========= event --> finance (22 constraint(s)) =========
-- Requires: event schema, finance schema
ALTER TABLE `sports_entertainment_ecm`.`event`.`fixture` ADD CONSTRAINT `fk_event_fixture_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`fixture` ADD CONSTRAINT `fk_event_fixture_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`fixture` ADD CONSTRAINT `fk_event_fixture_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`fixture` ADD CONSTRAINT `fk_event_fixture_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`fixture` ADD CONSTRAINT `fk_event_fixture_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`tournament` ADD CONSTRAINT `fk_event_tournament_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`tournament` ADD CONSTRAINT `fk_event_tournament_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`tournament` ADD CONSTRAINT `fk_event_tournament_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`production_schedule` ADD CONSTRAINT `fk_event_production_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`production_schedule` ADD CONSTRAINT `fk_event_production_schedule_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`participant` ADD CONSTRAINT `fk_event_participant_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`officiating_assignment` ADD CONSTRAINT `fk_event_officiating_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`venue_assignment` ADD CONSTRAINT `fk_event_venue_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`venue_assignment` ADD CONSTRAINT `fk_event_venue_assignment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`post_event_report` ADD CONSTRAINT `fk_event_post_event_report_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`post_event_report` ADD CONSTRAINT `fk_event_post_event_report_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`post_event_report` ADD CONSTRAINT `fk_event_post_event_report_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`post_event_report` ADD CONSTRAINT `fk_event_post_event_report_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`broadcast_window` ADD CONSTRAINT `fk_event_broadcast_window_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`attendance_record` ADD CONSTRAINT `fk_event_attendance_record_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`pricing` ADD CONSTRAINT `fk_event_pricing_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`pricing` ADD CONSTRAINT `fk_event_pricing_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);

-- ========= event --> league (49 constraint(s)) =========
-- Requires: event schema, league schema
ALTER TABLE `sports_entertainment_ecm`.`event`.`fixture` ADD CONSTRAINT `fk_event_fixture_away_team_franchise_id` FOREIGN KEY (`away_team_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`fixture` ADD CONSTRAINT `fk_event_fixture_fixture_away_team_franchise_id` FOREIGN KEY (`fixture_away_team_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`fixture` ADD CONSTRAINT `fk_event_fixture_fixture_franchise_id` FOREIGN KEY (`fixture_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`fixture` ADD CONSTRAINT `fk_event_fixture_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`fixture` ADD CONSTRAINT `fk_event_fixture_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`fixture` ADD CONSTRAINT `fk_event_fixture_league_schedule_id` FOREIGN KEY (`league_schedule_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league_schedule`(`league_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`fixture` ADD CONSTRAINT `fk_event_fixture_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`calendar` ADD CONSTRAINT `fk_event_calendar_cba_agreement_id` FOREIGN KEY (`cba_agreement_id`) REFERENCES `sports_entertainment_ecm`.`league`.`cba_agreement`(`cba_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`calendar` ADD CONSTRAINT `fk_event_calendar_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`tournament` ADD CONSTRAINT `fk_event_tournament_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`tournament` ADD CONSTRAINT `fk_event_tournament_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`bracket` ADD CONSTRAINT `fk_event_bracket_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`bracket` ADD CONSTRAINT `fk_event_bracket_playoff_bracket_id` FOREIGN KEY (`playoff_bracket_id`) REFERENCES `sports_entertainment_ecm`.`league`.`playoff_bracket`(`playoff_bracket_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`bracket` ADD CONSTRAINT `fk_event_bracket_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`fixture_calendar` ADD CONSTRAINT `fk_event_fixture_calendar_cba_agreement_id` FOREIGN KEY (`cba_agreement_id`) REFERENCES `sports_entertainment_ecm`.`league`.`cba_agreement`(`cba_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`fixture_calendar` ADD CONSTRAINT `fk_event_fixture_calendar_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`fixture_calendar` ADD CONSTRAINT `fk_event_fixture_calendar_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`match_result` ADD CONSTRAINT `fk_event_match_result_away_team_franchise_id` FOREIGN KEY (`away_team_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`match_result` ADD CONSTRAINT `fk_event_match_result_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`match_result` ADD CONSTRAINT `fk_event_match_result_official_id` FOREIGN KEY (`official_id`) REFERENCES `sports_entertainment_ecm`.`league`.`official`(`official_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`match_result` ADD CONSTRAINT `fk_event_match_result_playoff_bracket_id` FOREIGN KEY (`playoff_bracket_id`) REFERENCES `sports_entertainment_ecm`.`league`.`playoff_bracket`(`playoff_bracket_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`match_result` ADD CONSTRAINT `fk_event_match_result_primary_match_franchise_id` FOREIGN KEY (`primary_match_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`match_result` ADD CONSTRAINT `fk_event_match_result_referee_official_id` FOREIGN KEY (`referee_official_id`) REFERENCES `sports_entertainment_ecm`.`league`.`official`(`official_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`match_result` ADD CONSTRAINT `fk_event_match_result_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`match_result` ADD CONSTRAINT `fk_event_match_result_tertiary_match_winning_team_franchise_id` FOREIGN KEY (`tertiary_match_winning_team_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`match_result` ADD CONSTRAINT `fk_event_match_result_winning_team_franchise_id` FOREIGN KEY (`winning_team_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`scoring_event` ADD CONSTRAINT `fk_event_scoring_event_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`scoring_event` ADD CONSTRAINT `fk_event_scoring_event_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`scoring_event` ADD CONSTRAINT `fk_event_scoring_event_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`scoring_event` ADD CONSTRAINT `fk_event_scoring_event_team_franchise_id` FOREIGN KEY (`team_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`production_schedule` ADD CONSTRAINT `fk_event_production_schedule_league_schedule_id` FOREIGN KEY (`league_schedule_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league_schedule`(`league_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`participant` ADD CONSTRAINT `fk_event_participant_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`participant` ADD CONSTRAINT `fk_event_participant_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`officiating_assignment` ADD CONSTRAINT `fk_event_officiating_assignment_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`officiating_assignment` ADD CONSTRAINT `fk_event_officiating_assignment_official_id` FOREIGN KEY (`official_id`) REFERENCES `sports_entertainment_ecm`.`league`.`official`(`official_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`officiating_assignment` ADD CONSTRAINT `fk_event_officiating_assignment_officiating_crew_id` FOREIGN KEY (`officiating_crew_id`) REFERENCES `sports_entertainment_ecm`.`league`.`officiating_crew`(`officiating_crew_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`officiating_assignment` ADD CONSTRAINT `fk_event_officiating_assignment_primary_officiating_official_id` FOREIGN KEY (`primary_officiating_official_id`) REFERENCES `sports_entertainment_ecm`.`league`.`official`(`official_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`officiating_assignment` ADD CONSTRAINT `fk_event_officiating_assignment_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`event_incident` ADD CONSTRAINT `fk_event_event_incident_disciplinary_action_id` FOREIGN KEY (`disciplinary_action_id`) REFERENCES `sports_entertainment_ecm`.`league`.`disciplinary_action`(`disciplinary_action_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`event_incident` ADD CONSTRAINT `fk_event_event_incident_officiating_crew_id` FOREIGN KEY (`officiating_crew_id`) REFERENCES `sports_entertainment_ecm`.`league`.`officiating_crew`(`officiating_crew_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`competition_round` ADD CONSTRAINT `fk_event_competition_round_conference_id` FOREIGN KEY (`conference_id`) REFERENCES `sports_entertainment_ecm`.`league`.`conference`(`conference_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`competition_round` ADD CONSTRAINT `fk_event_competition_round_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`competition_round` ADD CONSTRAINT `fk_event_competition_round_playoff_bracket_id` FOREIGN KEY (`playoff_bracket_id`) REFERENCES `sports_entertainment_ecm`.`league`.`playoff_bracket`(`playoff_bracket_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`competition_round` ADD CONSTRAINT `fk_event_competition_round_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`post_event_report` ADD CONSTRAINT `fk_event_post_event_report_game_result_id` FOREIGN KEY (`game_result_id`) REFERENCES `sports_entertainment_ecm`.`league`.`game_result`(`game_result_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`attendance_record` ADD CONSTRAINT `fk_event_attendance_record_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`pricing` ADD CONSTRAINT `fk_event_pricing_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`pricing` ADD CONSTRAINT `fk_event_pricing_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`pricing` ADD CONSTRAINT `fk_event_pricing_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);

-- ========= event --> legal (8 constraint(s)) =========
-- Requires: event schema, legal schema
ALTER TABLE `sports_entertainment_ecm`.`event`.`fixture` ADD CONSTRAINT `fk_event_fixture_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`calendar` ADD CONSTRAINT `fk_event_calendar_governance_document_id` FOREIGN KEY (`governance_document_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`governance_document`(`governance_document_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`tournament` ADD CONSTRAINT `fk_event_tournament_governance_document_id` FOREIGN KEY (`governance_document_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`governance_document`(`governance_document_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`tournament` ADD CONSTRAINT `fk_event_tournament_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`fixture_calendar` ADD CONSTRAINT `fk_event_fixture_calendar_governance_document_id` FOREIGN KEY (`governance_document_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`governance_document`(`governance_document_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`post_event_report` ADD CONSTRAINT `fk_event_post_event_report_insurance_claim_id` FOREIGN KEY (`insurance_claim_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`insurance_claim`(`insurance_claim_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`post_event_report` ADD CONSTRAINT `fk_event_post_event_report_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`broadcast_window` ADD CONSTRAINT `fk_event_broadcast_window_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);

-- ========= event --> platform (12 constraint(s)) =========
-- Requires: event schema, platform schema
ALTER TABLE `sports_entertainment_ecm`.`event`.`fixture` ADD CONSTRAINT `fk_event_fixture_sla_policy_id` FOREIGN KEY (`sla_policy_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`sla_policy`(`sla_policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`fixture_calendar` ADD CONSTRAINT `fk_event_fixture_calendar_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`match_result` ADD CONSTRAINT `fk_event_match_result_notification_campaign_id` FOREIGN KEY (`notification_campaign_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`notification_campaign`(`notification_campaign_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`scoring_event` ADD CONSTRAINT `fk_event_scoring_event_push_notification_id` FOREIGN KEY (`push_notification_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`push_notification`(`push_notification_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`status_history` ADD CONSTRAINT `fk_event_status_history_notification_campaign_id` FOREIGN KEY (`notification_campaign_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`notification_campaign`(`notification_campaign_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`production_schedule` ADD CONSTRAINT `fk_event_production_schedule_sla_policy_id` FOREIGN KEY (`sla_policy_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`sla_policy`(`sla_policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`venue_assignment` ADD CONSTRAINT `fk_event_venue_assignment_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`post_event_report` ADD CONSTRAINT `fk_event_post_event_report_notification_campaign_id` FOREIGN KEY (`notification_campaign_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`notification_campaign`(`notification_campaign_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`weather_contingency` ADD CONSTRAINT `fk_event_weather_contingency_notification_campaign_id` FOREIGN KEY (`notification_campaign_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`notification_campaign`(`notification_campaign_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`broadcast_window` ADD CONSTRAINT `fk_event_broadcast_window_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`broadcast_window` ADD CONSTRAINT `fk_event_broadcast_window_sla_policy_id` FOREIGN KEY (`sla_policy_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`sla_policy`(`sla_policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`pricing` ADD CONSTRAINT `fk_event_pricing_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);

-- ========= event --> security (11 constraint(s)) =========
-- Requires: event schema, security schema
ALTER TABLE `sports_entertainment_ecm`.`event`.`match_result` ADD CONSTRAINT `fk_event_match_result_after_action_report_id` FOREIGN KEY (`after_action_report_id`) REFERENCES `sports_entertainment_ecm`.`security`.`after_action_report`(`after_action_report_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`production_schedule` ADD CONSTRAINT `fk_event_production_schedule_briefing_id` FOREIGN KEY (`briefing_id`) REFERENCES `sports_entertainment_ecm`.`security`.`briefing`(`briefing_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`production_schedule` ADD CONSTRAINT `fk_event_production_schedule_crowd_management_plan_id` FOREIGN KEY (`crowd_management_plan_id`) REFERENCES `sports_entertainment_ecm`.`security`.`crowd_management_plan`(`crowd_management_plan_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`production_schedule` ADD CONSTRAINT `fk_event_production_schedule_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `sports_entertainment_ecm`.`security`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`production_schedule` ADD CONSTRAINT `fk_event_production_schedule_staffing_plan_id` FOREIGN KEY (`staffing_plan_id`) REFERENCES `sports_entertainment_ecm`.`security`.`staffing_plan`(`staffing_plan_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`officiating_assignment` ADD CONSTRAINT `fk_event_officiating_assignment_credential_id` FOREIGN KEY (`credential_id`) REFERENCES `sports_entertainment_ecm`.`security`.`credential`(`credential_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`event_incident` ADD CONSTRAINT `fk_event_event_incident_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `sports_entertainment_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`venue_assignment` ADD CONSTRAINT `fk_event_venue_assignment_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `sports_entertainment_ecm`.`security`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`post_event_report` ADD CONSTRAINT `fk_event_post_event_report_after_action_report_id` FOREIGN KEY (`after_action_report_id`) REFERENCES `sports_entertainment_ecm`.`security`.`after_action_report`(`after_action_report_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`weather_contingency` ADD CONSTRAINT `fk_event_weather_contingency_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `sports_entertainment_ecm`.`security`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`attendance_record` ADD CONSTRAINT `fk_event_attendance_record_occupancy_snapshot_id` FOREIGN KEY (`occupancy_snapshot_id`) REFERENCES `sports_entertainment_ecm`.`security`.`occupancy_snapshot`(`occupancy_snapshot_id`);

-- ========= event --> sponsorship (6 constraint(s)) =========
-- Requires: event schema, sponsorship schema
ALTER TABLE `sports_entertainment_ecm`.`event`.`bracket` ADD CONSTRAINT `fk_event_bracket_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`deal`(`deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`bracket` ADD CONSTRAINT `fk_event_bracket_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`sponsor`(`sponsor_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`production_schedule` ADD CONSTRAINT `fk_event_production_schedule_sponsorship_activation_id` FOREIGN KEY (`sponsorship_activation_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation`(`sponsorship_activation_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`venue_assignment` ADD CONSTRAINT `fk_event_venue_assignment_naming_right_id` FOREIGN KEY (`naming_right_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`naming_right`(`naming_right_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`competition_round` ADD CONSTRAINT `fk_event_competition_round_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`deal`(`deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`post_event_report` ADD CONSTRAINT `fk_event_post_event_report_roi_report_id` FOREIGN KEY (`roi_report_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`roi_report`(`roi_report_id`);

-- ========= event --> ticketing (3 constraint(s)) =========
-- Requires: event schema, ticketing schema
ALTER TABLE `sports_entertainment_ecm`.`event`.`post_event_report` ADD CONSTRAINT `fk_event_post_event_report_venue_manifest_id` FOREIGN KEY (`venue_manifest_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`venue_manifest`(`venue_manifest_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`attendance_record` ADD CONSTRAINT `fk_event_attendance_record_venue_manifest_id` FOREIGN KEY (`venue_manifest_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`venue_manifest`(`venue_manifest_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`pricing` ADD CONSTRAINT `fk_event_pricing_price_tier_id` FOREIGN KEY (`price_tier_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`price_tier`(`price_tier_id`);

-- ========= event --> venue (16 constraint(s)) =========
-- Requires: event schema, venue schema
ALTER TABLE `sports_entertainment_ecm`.`event`.`fixture` ADD CONSTRAINT `fk_event_fixture_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`tournament` ADD CONSTRAINT `fk_event_tournament_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`bracket` ADD CONSTRAINT `fk_event_bracket_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`match_result` ADD CONSTRAINT `fk_event_match_result_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`scoring_event` ADD CONSTRAINT `fk_event_scoring_event_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`production_schedule` ADD CONSTRAINT `fk_event_production_schedule_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`officiating_assignment` ADD CONSTRAINT `fk_event_officiating_assignment_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`event_incident` ADD CONSTRAINT `fk_event_event_incident_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`venue_assignment` ADD CONSTRAINT `fk_event_venue_assignment_capacity_config_id` FOREIGN KEY (`capacity_config_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`capacity_config`(`capacity_config_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`venue_assignment` ADD CONSTRAINT `fk_event_venue_assignment_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`competition_round` ADD CONSTRAINT `fk_event_competition_round_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`post_event_report` ADD CONSTRAINT `fk_event_post_event_report_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`weather_contingency` ADD CONSTRAINT `fk_event_weather_contingency_staff_plan_id` FOREIGN KEY (`staff_plan_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`staff_plan`(`staff_plan_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`weather_contingency` ADD CONSTRAINT `fk_event_weather_contingency_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`attendance_record` ADD CONSTRAINT `fk_event_attendance_record_capacity_config_id` FOREIGN KEY (`capacity_config_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`capacity_config`(`capacity_config_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`attendance_record` ADD CONSTRAINT `fk_event_attendance_record_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);

-- ========= event --> workforce (17 constraint(s)) =========
-- Requires: event schema, workforce schema
ALTER TABLE `sports_entertainment_ecm`.`event`.`fixture_calendar` ADD CONSTRAINT `fk_event_fixture_calendar_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`status_history` ADD CONSTRAINT `fk_event_status_history_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`status_history` ADD CONSTRAINT `fk_event_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`status_history` ADD CONSTRAINT `fk_event_status_history_primary_status_employee_id` FOREIGN KEY (`primary_status_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`production_schedule` ADD CONSTRAINT `fk_event_production_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`production_schedule` ADD CONSTRAINT `fk_event_production_schedule_production_coordinator_employee_id` FOREIGN KEY (`production_coordinator_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`officiating_assignment` ADD CONSTRAINT `fk_event_officiating_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`event_incident` ADD CONSTRAINT `fk_event_event_incident_contingent_worker_id` FOREIGN KEY (`contingent_worker_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`contingent_worker`(`contingent_worker_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`event_incident` ADD CONSTRAINT `fk_event_event_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`event_incident` ADD CONSTRAINT `fk_event_event_incident_reported_by_staff_employee_id` FOREIGN KEY (`reported_by_staff_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`venue_assignment` ADD CONSTRAINT `fk_event_venue_assignment_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`venue_assignment` ADD CONSTRAINT `fk_event_venue_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`venue_assignment` ADD CONSTRAINT `fk_event_venue_assignment_primary_venue_employee_id` FOREIGN KEY (`primary_venue_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`post_event_report` ADD CONSTRAINT `fk_event_post_event_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`weather_contingency` ADD CONSTRAINT `fk_event_weather_contingency_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`attendance_record` ADD CONSTRAINT `fk_event_attendance_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`event`.`pricing` ADD CONSTRAINT `fk_event_pricing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= fan --> analytics (5 constraint(s)) =========
-- Requires: fan schema, analytics schema
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ADD CONSTRAINT `fk_fan_loyalty_transaction_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ADD CONSTRAINT `fk_fan_segment_fan_behavior_model_id` FOREIGN KEY (`fan_behavior_model_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`fan_behavior_model`(`fan_behavior_model_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ADD CONSTRAINT `fk_fan_segment_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ADD CONSTRAINT `fk_fan_segment_assignment_fan_behavior_model_id` FOREIGN KEY (`fan_behavior_model_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`fan_behavior_model`(`fan_behavior_model_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ADD CONSTRAINT `fk_fan_segment_assignment_model_run_id` FOREIGN KEY (`model_run_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`model_run`(`model_run_id`);

-- ========= fan --> athlete (5 constraint(s)) =========
-- Requires: fan schema, athlete schema
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ADD CONSTRAINT `fk_fan_membership_benefit_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ADD CONSTRAINT `fk_fan_nps_survey_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ADD CONSTRAINT `fk_fan_engagement_event_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ADD CONSTRAINT `fk_fan_club_affiliated_athlete_athlete_profile_id` FOREIGN KEY (`affiliated_athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ADD CONSTRAINT `fk_fan_club_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);

-- ========= fan --> broadcast (10 constraint(s)) =========
-- Requires: fan schema, broadcast schema
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ADD CONSTRAINT `fk_fan_loyalty_transaction_ppv_package_id` FOREIGN KEY (`ppv_package_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`ppv_package`(`ppv_package_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ADD CONSTRAINT `fk_fan_membership_benefit_ppv_package_id` FOREIGN KEY (`ppv_package_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`ppv_package`(`ppv_package_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ADD CONSTRAINT `fk_fan_nps_response_streaming_subscription_id` FOREIGN KEY (`streaming_subscription_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`streaming_subscription`(`streaming_subscription_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ADD CONSTRAINT `fk_fan_engagement_event_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ADD CONSTRAINT `fk_fan_engagement_event_broadcast_stream_live_feed_id` FOREIGN KEY (`broadcast_stream_live_feed_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`live_feed`(`live_feed_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ADD CONSTRAINT `fk_fan_engagement_event_live_feed_id` FOREIGN KEY (`live_feed_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`live_feed`(`live_feed_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ADD CONSTRAINT `fk_fan_engagement_event_ppv_transaction_id` FOREIGN KEY (`ppv_transaction_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`ppv_transaction`(`ppv_transaction_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ADD CONSTRAINT `fk_fan_communication_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ADD CONSTRAINT `fk_fan_service_case_ppv_transaction_id` FOREIGN KEY (`ppv_transaction_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`ppv_transaction`(`ppv_transaction_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ADD CONSTRAINT `fk_fan_service_case_streaming_subscription_id` FOREIGN KEY (`streaming_subscription_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`streaming_subscription`(`streaming_subscription_id`);

-- ========= fan --> compliance (9 constraint(s)) =========
-- Requires: fan schema, compliance schema
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ADD CONSTRAINT `fk_fan_loyalty_program_data_processing_record_id` FOREIGN KEY (`data_processing_record_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`data_processing_record`(`data_processing_record_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ADD CONSTRAINT `fk_fan_loyalty_program_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ADD CONSTRAINT `fk_fan_membership_benefit_ada_accommodation_id` FOREIGN KEY (`ada_accommodation_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`ada_accommodation`(`ada_accommodation_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ADD CONSTRAINT `fk_fan_segment_data_processing_record_id` FOREIGN KEY (`data_processing_record_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`data_processing_record`(`data_processing_record_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ADD CONSTRAINT `fk_fan_segment_pia_assessment_id` FOREIGN KEY (`pia_assessment_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`pia_assessment`(`pia_assessment_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ADD CONSTRAINT `fk_fan_consent_preference_data_processing_record_id` FOREIGN KEY (`data_processing_record_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`data_processing_record`(`data_processing_record_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ADD CONSTRAINT `fk_fan_consent_preference_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ADD CONSTRAINT `fk_fan_service_case_ada_accommodation_id` FOREIGN KEY (`ada_accommodation_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`ada_accommodation`(`ada_accommodation_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ADD CONSTRAINT `fk_fan_service_case_incident_report_id` FOREIGN KEY (`incident_report_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`incident_report`(`incident_report_id`);

-- ========= fan --> content (8 constraint(s)) =========
-- Requires: fan schema, content schema
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ADD CONSTRAINT `fk_fan_loyalty_program_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ADD CONSTRAINT `fk_fan_membership_benefit_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ADD CONSTRAINT `fk_fan_nps_survey_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ADD CONSTRAINT `fk_fan_nps_response_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ADD CONSTRAINT `fk_fan_engagement_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ADD CONSTRAINT `fk_fan_communication_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ADD CONSTRAINT `fk_fan_service_case_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`personalization_rule` ADD CONSTRAINT `fk_fan_personalization_rule_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);

-- ========= fan --> event (17 constraint(s)) =========
-- Requires: fan schema, event schema
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ADD CONSTRAINT `fk_fan_loyalty_transaction_calendar_id` FOREIGN KEY (`calendar_id`) REFERENCES `sports_entertainment_ecm`.`event`.`calendar`(`calendar_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ADD CONSTRAINT `fk_fan_membership_calendar_id` FOREIGN KEY (`calendar_id`) REFERENCES `sports_entertainment_ecm`.`event`.`calendar`(`calendar_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ADD CONSTRAINT `fk_fan_membership_benefit_competition_round_id` FOREIGN KEY (`competition_round_id`) REFERENCES `sports_entertainment_ecm`.`event`.`competition_round`(`competition_round_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ADD CONSTRAINT `fk_fan_membership_benefit_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ADD CONSTRAINT `fk_fan_membership_benefit_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ADD CONSTRAINT `fk_fan_membership_benefit_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `sports_entertainment_ecm`.`event`.`tournament`(`tournament_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ADD CONSTRAINT `fk_fan_nps_survey_calendar_id` FOREIGN KEY (`calendar_id`) REFERENCES `sports_entertainment_ecm`.`event`.`calendar`(`calendar_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ADD CONSTRAINT `fk_fan_nps_survey_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ADD CONSTRAINT `fk_fan_nps_survey_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ADD CONSTRAINT `fk_fan_nps_survey_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `sports_entertainment_ecm`.`event`.`tournament`(`tournament_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ADD CONSTRAINT `fk_fan_nps_response_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ADD CONSTRAINT `fk_fan_nps_response_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ADD CONSTRAINT `fk_fan_engagement_event_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ADD CONSTRAINT `fk_fan_engagement_event_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ADD CONSTRAINT `fk_fan_communication_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ADD CONSTRAINT `fk_fan_service_case_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ADD CONSTRAINT `fk_fan_service_case_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);

-- ========= fan --> finance (7 constraint(s)) =========
-- Requires: fan schema, finance schema
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ADD CONSTRAINT `fk_fan_loyalty_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ADD CONSTRAINT `fk_fan_loyalty_program_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ADD CONSTRAINT `fk_fan_loyalty_transaction_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ADD CONSTRAINT `fk_fan_membership_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ADD CONSTRAINT `fk_fan_membership_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ADD CONSTRAINT `fk_fan_club_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ADD CONSTRAINT `fk_fan_club_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);

-- ========= fan --> gaming (5 constraint(s)) =========
-- Requires: fan schema, gaming schema
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ADD CONSTRAINT `fk_fan_loyalty_transaction_wager_id` FOREIGN KEY (`wager_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`wager`(`wager_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ADD CONSTRAINT `fk_fan_nps_response_session_id` FOREIGN KEY (`session_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`session`(`session_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ADD CONSTRAINT `fk_fan_engagement_event_contest_id` FOREIGN KEY (`contest_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`contest`(`contest_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ADD CONSTRAINT `fk_fan_communication_bonus_offer_id` FOREIGN KEY (`bonus_offer_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`bonus_offer`(`bonus_offer_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ADD CONSTRAINT `fk_fan_service_case_wager_id` FOREIGN KEY (`wager_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`wager`(`wager_id`);

-- ========= fan --> league (31 constraint(s)) =========
-- Requires: fan schema, league schema
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ADD CONSTRAINT `fk_fan_fan_profile_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ADD CONSTRAINT `fk_fan_account_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ADD CONSTRAINT `fk_fan_account_team_id` FOREIGN KEY (`team_id`) REFERENCES `sports_entertainment_ecm`.`league`.`team`(`team_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ADD CONSTRAINT `fk_fan_household_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ADD CONSTRAINT `fk_fan_household_team_id` FOREIGN KEY (`team_id`) REFERENCES `sports_entertainment_ecm`.`league`.`team`(`team_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ADD CONSTRAINT `fk_fan_loyalty_program_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ADD CONSTRAINT `fk_fan_loyalty_program_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ADD CONSTRAINT `fk_fan_loyalty_enrollment_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ADD CONSTRAINT `fk_fan_loyalty_enrollment_team_id` FOREIGN KEY (`team_id`) REFERENCES `sports_entertainment_ecm`.`league`.`team`(`team_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ADD CONSTRAINT `fk_fan_loyalty_enrollment_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ADD CONSTRAINT `fk_fan_loyalty_transaction_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ADD CONSTRAINT `fk_fan_loyalty_transaction_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ADD CONSTRAINT `fk_fan_membership_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ADD CONSTRAINT `fk_fan_membership_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ADD CONSTRAINT `fk_fan_membership_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ADD CONSTRAINT `fk_fan_membership_team_id` FOREIGN KEY (`team_id`) REFERENCES `sports_entertainment_ecm`.`league`.`team`(`team_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ADD CONSTRAINT `fk_fan_membership_benefit_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ADD CONSTRAINT `fk_fan_segment_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ADD CONSTRAINT `fk_fan_segment_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ADD CONSTRAINT `fk_fan_segment_team_id` FOREIGN KEY (`team_id`) REFERENCES `sports_entertainment_ecm`.`league`.`team`(`team_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ADD CONSTRAINT `fk_fan_nps_survey_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ADD CONSTRAINT `fk_fan_nps_survey_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ADD CONSTRAINT `fk_fan_nps_survey_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ADD CONSTRAINT `fk_fan_nps_response_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ADD CONSTRAINT `fk_fan_nps_response_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ADD CONSTRAINT `fk_fan_nps_response_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ADD CONSTRAINT `fk_fan_service_case_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ADD CONSTRAINT `fk_fan_club_team_id` FOREIGN KEY (`team_id`) REFERENCES `sports_entertainment_ecm`.`league`.`team`(`team_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ADD CONSTRAINT `fk_fan_club_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ADD CONSTRAINT `fk_fan_club_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club_membership` ADD CONSTRAINT `fk_fan_club_membership_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);

-- ========= fan --> legal (12 constraint(s)) =========
-- Requires: fan schema, legal schema
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ADD CONSTRAINT `fk_fan_loyalty_program_contract_template_id` FOREIGN KEY (`contract_template_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`contract_template`(`contract_template_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ADD CONSTRAINT `fk_fan_loyalty_program_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ADD CONSTRAINT `fk_fan_membership_contract_template_id` FOREIGN KEY (`contract_template_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`contract_template`(`contract_template_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ADD CONSTRAINT `fk_fan_consent_preference_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ADD CONSTRAINT `fk_fan_consent_preference_data_controller_corporate_entity_id` FOREIGN KEY (`data_controller_corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ADD CONSTRAINT `fk_fan_consent_preference_data_processor_corporate_entity_id` FOREIGN KEY (`data_processor_corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ADD CONSTRAINT `fk_fan_consent_preference_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ADD CONSTRAINT `fk_fan_service_case_insurance_claim_id` FOREIGN KEY (`insurance_claim_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`insurance_claim`(`insurance_claim_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ADD CONSTRAINT `fk_fan_service_case_litigation_case_id` FOREIGN KEY (`litigation_case_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`litigation_case`(`litigation_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ADD CONSTRAINT `fk_fan_service_case_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ADD CONSTRAINT `fk_fan_service_case_settlement_agreement_id` FOREIGN KEY (`settlement_agreement_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`settlement_agreement`(`settlement_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ADD CONSTRAINT `fk_fan_club_governance_document_id` FOREIGN KEY (`governance_document_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`governance_document`(`governance_document_id`);

-- ========= fan --> merchandise (8 constraint(s)) =========
-- Requires: fan schema, merchandise schema
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ADD CONSTRAINT `fk_fan_loyalty_transaction_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `sports_entertainment_ecm`.`merchandise`.`promotion`(`promotion_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ADD CONSTRAINT `fk_fan_membership_benefit_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `sports_entertainment_ecm`.`merchandise`.`promotion`(`promotion_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ADD CONSTRAINT `fk_fan_membership_benefit_sku_catalog_id` FOREIGN KEY (`sku_catalog_id`) REFERENCES `sports_entertainment_ecm`.`merchandise`.`sku_catalog`(`sku_catalog_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ADD CONSTRAINT `fk_fan_engagement_event_merch_order_id` FOREIGN KEY (`merch_order_id`) REFERENCES `sports_entertainment_ecm`.`merchandise`.`merch_order`(`merch_order_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ADD CONSTRAINT `fk_fan_engagement_event_sku_catalog_id` FOREIGN KEY (`sku_catalog_id`) REFERENCES `sports_entertainment_ecm`.`merchandise`.`sku_catalog`(`sku_catalog_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ADD CONSTRAINT `fk_fan_communication_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `sports_entertainment_ecm`.`merchandise`.`promotion`(`promotion_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ADD CONSTRAINT `fk_fan_service_case_merch_order_id` FOREIGN KEY (`merch_order_id`) REFERENCES `sports_entertainment_ecm`.`merchandise`.`merch_order`(`merch_order_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ADD CONSTRAINT `fk_fan_service_case_return_request_id` FOREIGN KEY (`return_request_id`) REFERENCES `sports_entertainment_ecm`.`merchandise`.`return_request`(`return_request_id`);

-- ========= fan --> partner (10 constraint(s)) =========
-- Requires: fan schema, partner schema
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ADD CONSTRAINT `fk_fan_loyalty_program_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ADD CONSTRAINT `fk_fan_loyalty_program_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ADD CONSTRAINT `fk_fan_membership_benefit_service_order_id` FOREIGN KEY (`service_order_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`service_order`(`service_order_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ADD CONSTRAINT `fk_fan_membership_benefit_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ADD CONSTRAINT `fk_fan_membership_benefit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ADD CONSTRAINT `fk_fan_consent_preference_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ADD CONSTRAINT `fk_fan_nps_survey_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ADD CONSTRAINT `fk_fan_service_case_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ADD CONSTRAINT `fk_fan_club_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`reward` ADD CONSTRAINT `fk_fan_reward_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);

-- ========= fan --> platform (14 constraint(s)) =========
-- Requires: fan schema, platform schema
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ADD CONSTRAINT `fk_fan_loyalty_enrollment_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ADD CONSTRAINT `fk_fan_loyalty_transaction_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ADD CONSTRAINT `fk_fan_membership_digital_subscription_id` FOREIGN KEY (`digital_subscription_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_subscription`(`digital_subscription_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment` ADD CONSTRAINT `fk_fan_segment_fan_segment_id` FOREIGN KEY (`fan_segment_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`fan_segment`(`fan_segment_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ADD CONSTRAINT `fk_fan_segment_assignment_notification_campaign_id` FOREIGN KEY (`notification_campaign_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`notification_campaign`(`notification_campaign_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`consent_preference` ADD CONSTRAINT `fk_fan_consent_preference_auth_session_id` FOREIGN KEY (`auth_session_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`auth_session`(`auth_session_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ADD CONSTRAINT `fk_fan_nps_survey_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ADD CONSTRAINT `fk_fan_nps_survey_notification_campaign_id` FOREIGN KEY (`notification_campaign_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`notification_campaign`(`notification_campaign_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ADD CONSTRAINT `fk_fan_nps_response_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ADD CONSTRAINT `fk_fan_engagement_event_auth_session_id` FOREIGN KEY (`auth_session_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`auth_session`(`auth_session_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ADD CONSTRAINT `fk_fan_engagement_event_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ADD CONSTRAINT `fk_fan_communication_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ADD CONSTRAINT `fk_fan_communication_notification_campaign_id` FOREIGN KEY (`notification_campaign_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`notification_campaign`(`notification_campaign_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ADD CONSTRAINT `fk_fan_service_case_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);

-- ========= fan --> security (4 constraint(s)) =========
-- Requires: fan schema, security schema
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ADD CONSTRAINT `fk_fan_membership_access_zone_id` FOREIGN KEY (`access_zone_id`) REFERENCES `sports_entertainment_ecm`.`security`.`access_zone`(`access_zone_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ADD CONSTRAINT `fk_fan_nps_response_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `sports_entertainment_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ADD CONSTRAINT `fk_fan_engagement_event_access_zone_id` FOREIGN KEY (`access_zone_id`) REFERENCES `sports_entertainment_ecm`.`security`.`access_zone`(`access_zone_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ADD CONSTRAINT `fk_fan_service_case_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `sports_entertainment_ecm`.`security`.`security_incident`(`security_incident_id`);

-- ========= fan --> sponsorship (9 constraint(s)) =========
-- Requires: fan schema, sponsorship schema
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ADD CONSTRAINT `fk_fan_loyalty_program_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`sponsor`(`sponsor_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ADD CONSTRAINT `fk_fan_membership_benefit_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`deal`(`deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ADD CONSTRAINT `fk_fan_membership_benefit_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`sponsor`(`sponsor_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ADD CONSTRAINT `fk_fan_nps_response_sponsorship_activation_id` FOREIGN KEY (`sponsorship_activation_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation`(`sponsorship_activation_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ADD CONSTRAINT `fk_fan_engagement_event_sponsorship_activation_id` FOREIGN KEY (`sponsorship_activation_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation`(`sponsorship_activation_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`communication` ADD CONSTRAINT `fk_fan_communication_sponsorship_activation_id` FOREIGN KEY (`sponsorship_activation_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation`(`sponsorship_activation_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ADD CONSTRAINT `fk_fan_club_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`deal`(`deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ADD CONSTRAINT `fk_fan_club_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`sponsor`(`sponsor_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ADD CONSTRAINT `fk_fan_club_sponsorship_partner_sponsor_id` FOREIGN KEY (`sponsorship_partner_sponsor_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`sponsor`(`sponsor_id`);

-- ========= fan --> ticketing (9 constraint(s)) =========
-- Requires: fan schema, ticketing schema
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ADD CONSTRAINT `fk_fan_household_season_ticket_account_id` FOREIGN KEY (`season_ticket_account_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`season_ticket_account`(`season_ticket_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ADD CONSTRAINT `fk_fan_loyalty_transaction_ticket_order_id` FOREIGN KEY (`ticket_order_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`ticket_order`(`ticket_order_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ADD CONSTRAINT `fk_fan_membership_season_ticket_package_id` FOREIGN KEY (`season_ticket_package_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`season_ticket_package`(`season_ticket_package_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ADD CONSTRAINT `fk_fan_membership_benefit_access_entitlement_id` FOREIGN KEY (`access_entitlement_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`access_entitlement`(`access_entitlement_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ADD CONSTRAINT `fk_fan_nps_survey_ticket_order_id` FOREIGN KEY (`ticket_order_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`ticket_order`(`ticket_order_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ADD CONSTRAINT `fk_fan_nps_response_ticket_order_id` FOREIGN KEY (`ticket_order_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`ticket_order`(`ticket_order_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ADD CONSTRAINT `fk_fan_engagement_event_ticket_inventory_id` FOREIGN KEY (`ticket_inventory_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`ticket_inventory`(`ticket_inventory_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ADD CONSTRAINT `fk_fan_engagement_event_ticket_order_line_id` FOREIGN KEY (`ticket_order_line_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`ticket_order_line`(`ticket_order_line_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ADD CONSTRAINT `fk_fan_service_case_ticket_order_id` FOREIGN KEY (`ticket_order_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`ticket_order`(`ticket_order_id`);

-- ========= fan --> venue (18 constraint(s)) =========
-- Requires: fan schema, venue schema
ALTER TABLE `sports_entertainment_ecm`.`fan`.`fan_profile` ADD CONSTRAINT `fk_fan_fan_profile_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`account` ADD CONSTRAINT `fk_fan_account_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`household` ADD CONSTRAINT `fk_fan_household_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_program` ADD CONSTRAINT `fk_fan_loyalty_program_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_enrollment` ADD CONSTRAINT `fk_fan_loyalty_enrollment_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`loyalty_transaction` ADD CONSTRAINT `fk_fan_loyalty_transaction_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ADD CONSTRAINT `fk_fan_membership_seat_id` FOREIGN KEY (`seat_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`seat`(`seat_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ADD CONSTRAINT `fk_fan_membership_parking_lot_id` FOREIGN KEY (`parking_lot_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`parking_lot`(`parking_lot_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ADD CONSTRAINT `fk_fan_membership_seating_section_id` FOREIGN KEY (`seating_section_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`seating_section`(`seating_section_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ADD CONSTRAINT `fk_fan_membership_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership_benefit` ADD CONSTRAINT `fk_fan_membership_benefit_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_survey` ADD CONSTRAINT `fk_fan_nps_survey_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ADD CONSTRAINT `fk_fan_nps_response_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`engagement_event` ADD CONSTRAINT `fk_fan_engagement_event_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ADD CONSTRAINT `fk_fan_service_case_concession_stand_id` FOREIGN KEY (`concession_stand_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`concession_stand`(`concession_stand_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ADD CONSTRAINT `fk_fan_service_case_seat_id` FOREIGN KEY (`seat_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`seat`(`seat_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ADD CONSTRAINT `fk_fan_service_case_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ADD CONSTRAINT `fk_fan_club_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);

-- ========= fan --> workforce (10 constraint(s)) =========
-- Requires: fan schema, workforce schema
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ADD CONSTRAINT `fk_fan_membership_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`membership` ADD CONSTRAINT `fk_fan_membership_sales_rep_employee_id` FOREIGN KEY (`sales_rep_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ADD CONSTRAINT `fk_fan_segment_assignment_assigned_by_user_employee_id` FOREIGN KEY (`assigned_by_user_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`segment_assignment` ADD CONSTRAINT `fk_fan_segment_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`nps_response` ADD CONSTRAINT `fk_fan_nps_response_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ADD CONSTRAINT `fk_fan_service_case_assigned_agent_employee_id` FOREIGN KEY (`assigned_agent_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`service_case` ADD CONSTRAINT `fk_fan_service_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`club` ADD CONSTRAINT `fk_fan_club_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`campaign` ADD CONSTRAINT `fk_fan_campaign_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`fan`.`campaign` ADD CONSTRAINT `fk_fan_campaign_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= finance --> athlete (3 constraint(s)) =========
-- Requires: finance schema, athlete schema
ALTER TABLE `sports_entertainment_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_athlete_contract_id` FOREIGN KEY (`athlete_contract_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_contract`(`athlete_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_finance_revenue_recognition_schedule_athlete_contract_id` FOREIGN KEY (`athlete_contract_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_contract`(`athlete_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`recurring_revenue` ADD CONSTRAINT `fk_finance_recurring_revenue_athlete_contract_id` FOREIGN KEY (`athlete_contract_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_contract`(`athlete_contract_id`);

-- ========= finance --> broadcast (6 constraint(s)) =========
-- Requires: finance schema, broadcast schema
ALTER TABLE `sports_entertainment_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_media_rights_deal_id` FOREIGN KEY (`media_rights_deal_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`media_rights_deal`(`media_rights_deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_media_rights_deal_id` FOREIGN KEY (`media_rights_deal_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`media_rights_deal`(`media_rights_deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_sublicense_agreement_id` FOREIGN KEY (`sublicense_agreement_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`sublicense_agreement`(`sublicense_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_finance_revenue_recognition_schedule_media_rights_deal_id` FOREIGN KEY (`media_rights_deal_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`media_rights_deal`(`media_rights_deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`recurring_revenue` ADD CONSTRAINT `fk_finance_recurring_revenue_streaming_subscription_id` FOREIGN KEY (`streaming_subscription_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`streaming_subscription`(`streaming_subscription_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_media_rights_deal_id` FOREIGN KEY (`media_rights_deal_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`media_rights_deal`(`media_rights_deal_id`);

-- ========= finance --> fan (13 constraint(s)) =========
-- Requires: finance schema, fan schema
ALTER TABLE `sports_entertainment_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`segment`(`segment_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_account_id` FOREIGN KEY (`account_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`account`(`account_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`membership`(`membership_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_account_id` FOREIGN KEY (`account_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`account`(`account_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`account`(`account_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`membership`(`membership_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_finance_revenue_recognition_schedule_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`membership`(`membership_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`recurring_revenue` ADD CONSTRAINT `fk_finance_recurring_revenue_account_id` FOREIGN KEY (`account_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`account`(`account_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`recurring_revenue` ADD CONSTRAINT `fk_finance_recurring_revenue_club_membership_id` FOREIGN KEY (`club_membership_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`club_membership`(`club_membership_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`recurring_revenue` ADD CONSTRAINT `fk_finance_recurring_revenue_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`recurring_revenue` ADD CONSTRAINT `fk_finance_recurring_revenue_loyalty_enrollment_id` FOREIGN KEY (`loyalty_enrollment_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`loyalty_enrollment`(`loyalty_enrollment_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`recurring_revenue` ADD CONSTRAINT `fk_finance_recurring_revenue_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`membership`(`membership_id`);

-- ========= finance --> league (1 constraint(s)) =========
-- Requires: finance schema, league schema
ALTER TABLE `sports_entertainment_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);

-- ========= finance --> legal (12 constraint(s)) =========
-- Requires: finance schema, legal schema
ALTER TABLE `sports_entertainment_ecm`.`finance`.`company_code` ADD CONSTRAINT `fk_finance_company_code_company_corporate_entity_id` FOREIGN KEY (`company_corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`company_code` ADD CONSTRAINT `fk_finance_company_code_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_settlement_agreement_id` FOREIGN KEY (`settlement_agreement_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`settlement_agreement`(`settlement_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`invoice`(`invoice_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_settlement_agreement_id` FOREIGN KEY (`settlement_agreement_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`settlement_agreement`(`settlement_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_ip_portfolio_id` FOREIGN KEY (`ip_portfolio_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`ip_portfolio`(`ip_portfolio_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`intercompany_settlement` ADD CONSTRAINT `fk_finance_intercompany_settlement_governance_document_id` FOREIGN KEY (`governance_document_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`governance_document`(`governance_document_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_finance_revenue_recognition_schedule_ip_portfolio_id` FOREIGN KEY (`ip_portfolio_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`ip_portfolio`(`ip_portfolio_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`revenue_stream` ADD CONSTRAINT `fk_finance_revenue_stream_ip_portfolio_id` FOREIGN KEY (`ip_portfolio_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`ip_portfolio`(`ip_portfolio_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_litigation_case_id` FOREIGN KEY (`litigation_case_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`litigation_case`(`litigation_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`audit_trail` ADD CONSTRAINT `fk_finance_audit_trail_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`hold`(`hold_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);

-- ========= finance --> merchandise (1 constraint(s)) =========
-- Requires: finance schema, merchandise schema
ALTER TABLE `sports_entertainment_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_merch_order_id` FOREIGN KEY (`merch_order_id`) REFERENCES `sports_entertainment_ecm`.`merchandise`.`merch_order`(`merch_order_id`);

-- ========= finance --> partner (4 constraint(s)) =========
-- Requires: finance schema, partner schema
ALTER TABLE `sports_entertainment_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);

-- ========= finance --> platform (6 constraint(s)) =========
-- Requires: finance schema, platform schema
ALTER TABLE `sports_entertainment_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_digital_subscription_id` FOREIGN KEY (`digital_subscription_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_subscription`(`digital_subscription_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_sla_incident_id` FOREIGN KEY (`sla_incident_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`sla_incident`(`sla_incident_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_digital_subscription_id` FOREIGN KEY (`digital_subscription_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_subscription`(`digital_subscription_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_finance_revenue_recognition_schedule_digital_subscription_id` FOREIGN KEY (`digital_subscription_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_subscription`(`digital_subscription_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`recurring_revenue` ADD CONSTRAINT `fk_finance_recurring_revenue_digital_subscription_id` FOREIGN KEY (`digital_subscription_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_subscription`(`digital_subscription_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`audit_trail` ADD CONSTRAINT `fk_finance_audit_trail_auth_session_id` FOREIGN KEY (`auth_session_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`auth_session`(`auth_session_id`);

-- ========= finance --> security (1 constraint(s)) =========
-- Requires: finance schema, security schema
ALTER TABLE `sports_entertainment_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_security_contract_id` FOREIGN KEY (`security_contract_id`) REFERENCES `sports_entertainment_ecm`.`security`.`security_contract`(`security_contract_id`);

-- ========= finance --> ticketing (6 constraint(s)) =========
-- Requires: finance schema, ticketing schema
ALTER TABLE `sports_entertainment_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_group_sale_id` FOREIGN KEY (`group_sale_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`group_sale`(`group_sale_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_season_ticket_account_id` FOREIGN KEY (`season_ticket_account_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`season_ticket_account`(`season_ticket_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_ticket_order_id` FOREIGN KEY (`ticket_order_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`ticket_order`(`ticket_order_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_ticket_payment_id` FOREIGN KEY (`ticket_payment_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`ticket_payment`(`ticket_payment_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_finance_revenue_recognition_schedule_season_ticket_package_id` FOREIGN KEY (`season_ticket_package_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`season_ticket_package`(`season_ticket_package_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`recurring_revenue` ADD CONSTRAINT `fk_finance_recurring_revenue_season_ticket_package_id` FOREIGN KEY (`season_ticket_package_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`season_ticket_package`(`season_ticket_package_id`);

-- ========= finance --> venue (2 constraint(s)) =========
-- Requires: finance schema, venue schema
ALTER TABLE `sports_entertainment_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);

-- ========= finance --> workforce (30 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `sports_entertainment_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_primary_cost_employee_id` FOREIGN KEY (`primary_cost_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_primary_journal_employee_id` FOREIGN KEY (`primary_journal_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_sox_approver_user_employee_id` FOREIGN KEY (`sox_approver_user_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_approver_id` FOREIGN KEY (`approver_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_budget_employee_id` FOREIGN KEY (`budget_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`intercompany_settlement` ADD CONSTRAINT `fk_finance_intercompany_settlement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`sox_control` ADD CONSTRAINT `fk_finance_sox_control_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`sox_control` ADD CONSTRAINT `fk_finance_sox_control_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`revenue_stream` ADD CONSTRAINT `fk_finance_revenue_stream_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`audit_trail` ADD CONSTRAINT `fk_finance_audit_trail_approver_user_employee_id` FOREIGN KEY (`approver_user_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`audit_trail` ADD CONSTRAINT `fk_finance_audit_trail_approver_user_id` FOREIGN KEY (`approver_user_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`audit_trail` ADD CONSTRAINT `fk_finance_audit_trail_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`audit_trail` ADD CONSTRAINT `fk_finance_audit_trail_primary_audit_employee_id` FOREIGN KEY (`primary_audit_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`audit_trail` ADD CONSTRAINT `fk_finance_audit_trail_reviewed_by_user_employee_id` FOREIGN KEY (`reviewed_by_user_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`budget_allocation` ADD CONSTRAINT `fk_finance_budget_allocation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_closed_by_user_employee_id` FOREIGN KEY (`closed_by_user_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= gaming --> analytics (4 constraint(s)) =========
-- Requires: gaming schema, analytics schema
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`prop_bet` ADD CONSTRAINT `fk_gaming_prop_bet_performance_analytics_snapshot_id` FOREIGN KEY (`performance_analytics_snapshot_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`performance_analytics_snapshot`(`performance_analytics_snapshot_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`responsible_gaming_limit` ADD CONSTRAINT `fk_gaming_responsible_gaming_limit_fan_score_id` FOREIGN KEY (`fan_score_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`fan_score`(`fan_score_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`bonus_offer` ADD CONSTRAINT `fk_gaming_bonus_offer_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`experiment`(`experiment_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`bonus_offer` ADD CONSTRAINT `fk_gaming_bonus_offer_fan_behavior_model_id` FOREIGN KEY (`fan_behavior_model_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`fan_behavior_model`(`fan_behavior_model_id`);

-- ========= gaming --> athlete (23 constraint(s)) =========
-- Requires: gaming schema, athlete schema
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`prop_bet` ADD CONSTRAINT `fk_gaming_prop_bet_athlete_athlete_profile_id` FOREIGN KEY (`athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`prop_bet` ADD CONSTRAINT `fk_gaming_prop_bet_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`prop_bet` ADD CONSTRAINT `fk_gaming_prop_bet_award_honor_id` FOREIGN KEY (`award_honor_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`award_honor`(`award_honor_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`prop_bet` ADD CONSTRAINT `fk_gaming_prop_bet_combine_result_id` FOREIGN KEY (`combine_result_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`combine_result`(`combine_result_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`prop_bet` ADD CONSTRAINT `fk_gaming_prop_bet_eligibility_status_id` FOREIGN KEY (`eligibility_status_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`eligibility_status`(`eligibility_status_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`prop_bet` ADD CONSTRAINT `fk_gaming_prop_bet_injury_record_id` FOREIGN KEY (`injury_record_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`injury_record`(`injury_record_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`prop_bet` ADD CONSTRAINT `fk_gaming_prop_bet_performance_stat_id` FOREIGN KEY (`performance_stat_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`performance_stat`(`performance_stat_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`prop_bet` ADD CONSTRAINT `fk_gaming_prop_bet_suspension_record_id` FOREIGN KEY (`suspension_record_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`suspension_record`(`suspension_record_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`fantasy_roster` ADD CONSTRAINT `fk_gaming_fantasy_roster_athlete_athlete_profile_id` FOREIGN KEY (`athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`fantasy_roster` ADD CONSTRAINT `fk_gaming_fantasy_roster_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`fantasy_roster` ADD CONSTRAINT `fk_gaming_fantasy_roster_eligibility_status_id` FOREIGN KEY (`eligibility_status_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`eligibility_status`(`eligibility_status_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`fantasy_roster` ADD CONSTRAINT `fk_gaming_fantasy_roster_injury_record_id` FOREIGN KEY (`injury_record_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`injury_record`(`injury_record_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`fantasy_roster` ADD CONSTRAINT `fk_gaming_fantasy_roster_roster_id` FOREIGN KEY (`roster_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`roster`(`roster_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`fantasy_roster` ADD CONSTRAINT `fk_gaming_fantasy_roster_suspension_record_id` FOREIGN KEY (`suspension_record_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`suspension_record`(`suspension_record_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`fantasy_draft` ADD CONSTRAINT `fk_gaming_fantasy_draft_athlete_athlete_profile_id` FOREIGN KEY (`athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`fantasy_draft` ADD CONSTRAINT `fk_gaming_fantasy_draft_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`fantasy_draft` ADD CONSTRAINT `fk_gaming_fantasy_draft_combine_result_id` FOREIGN KEY (`combine_result_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`combine_result`(`combine_result_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`fantasy_transaction` ADD CONSTRAINT `fk_gaming_fantasy_transaction_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`fantasy_transaction` ADD CONSTRAINT `fk_gaming_fantasy_transaction_dropped_athlete_athlete_profile_id` FOREIGN KEY (`dropped_athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`fantasy_transaction` ADD CONSTRAINT `fk_gaming_fantasy_transaction_free_agency_status_id` FOREIGN KEY (`free_agency_status_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`free_agency_status`(`free_agency_status_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`fantasy_transaction` ADD CONSTRAINT `fk_gaming_fantasy_transaction_primary_fantasy_athlete_profile_id` FOREIGN KEY (`primary_fantasy_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`integrity_alert` ADD CONSTRAINT `fk_gaming_integrity_alert_athlete_athlete_profile_id` FOREIGN KEY (`athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`integrity_alert` ADD CONSTRAINT `fk_gaming_integrity_alert_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);

-- ========= gaming --> broadcast (9 constraint(s)) =========
-- Requires: gaming schema, broadcast schema
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`betting_market` ADD CONSTRAINT `fk_gaming_betting_market_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`odds_feed` ADD CONSTRAINT `fk_gaming_odds_feed_live_feed_id` FOREIGN KEY (`live_feed_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`live_feed`(`live_feed_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`wager` ADD CONSTRAINT `fk_gaming_wager_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`market_suspension` ADD CONSTRAINT `fk_gaming_market_suspension_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`integrity_alert` ADD CONSTRAINT `fk_gaming_integrity_alert_live_feed_id` FOREIGN KEY (`live_feed_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`live_feed`(`live_feed_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`contest` ADD CONSTRAINT `fk_gaming_contest_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`esports_match` ADD CONSTRAINT `fk_gaming_esports_match_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`channel`(`channel_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`esports_match` ADD CONSTRAINT `fk_gaming_esports_match_production_id` FOREIGN KEY (`production_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`production`(`production_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`esports_match` ADD CONSTRAINT `fk_gaming_esports_match_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);

-- ========= gaming --> compliance (6 constraint(s)) =========
-- Requires: gaming schema, compliance schema
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`wallet_transaction` ADD CONSTRAINT `fk_gaming_wallet_transaction_license_permit_id` FOREIGN KEY (`license_permit_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`license_permit`(`license_permit_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`jurisdiction` ADD CONSTRAINT `fk_gaming_jurisdiction_governing_body_id` FOREIGN KEY (`governing_body_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`governing_body`(`governing_body_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`responsible_gaming_limit` ADD CONSTRAINT `fk_gaming_responsible_gaming_limit_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`regulatory_report` ADD CONSTRAINT `fk_gaming_regulatory_report_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`regulatory_report` ADD CONSTRAINT `fk_gaming_regulatory_report_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`integrity_alert` ADD CONSTRAINT `fk_gaming_integrity_alert_incident_report_id` FOREIGN KEY (`incident_report_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`incident_report`(`incident_report_id`);

-- ========= gaming --> content (5 constraint(s)) =========
-- Requires: gaming schema, content schema
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`wallet_transaction` ADD CONSTRAINT `fk_gaming_wallet_transaction_content_license_id` FOREIGN KEY (`content_license_id`) REFERENCES `sports_entertainment_ecm`.`content`.`content_license`(`content_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`bonus_offer` ADD CONSTRAINT `fk_gaming_bonus_offer_platform_channel_id` FOREIGN KEY (`platform_channel_id`) REFERENCES `sports_entertainment_ecm`.`content`.`platform_channel`(`platform_channel_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`integrity_alert` ADD CONSTRAINT `fk_gaming_integrity_alert_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`contest` ADD CONSTRAINT `fk_gaming_contest_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`esports_match` ADD CONSTRAINT `fk_gaming_esports_match_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);

-- ========= gaming --> event (27 constraint(s)) =========
-- Requires: gaming schema, event schema
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`betting_market` ADD CONSTRAINT `fk_gaming_betting_market_competition_round_id` FOREIGN KEY (`competition_round_id`) REFERENCES `sports_entertainment_ecm`.`event`.`competition_round`(`competition_round_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`betting_market` ADD CONSTRAINT `fk_gaming_betting_market_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`betting_market` ADD CONSTRAINT `fk_gaming_betting_market_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`betting_market` ADD CONSTRAINT `fk_gaming_betting_market_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `sports_entertainment_ecm`.`event`.`tournament`(`tournament_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`odds_feed` ADD CONSTRAINT `fk_gaming_odds_feed_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`odds_feed` ADD CONSTRAINT `fk_gaming_odds_feed_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`wager` ADD CONSTRAINT `fk_gaming_wager_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`wager` ADD CONSTRAINT `fk_gaming_wager_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`prop_bet` ADD CONSTRAINT `fk_gaming_prop_bet_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`prop_bet` ADD CONSTRAINT `fk_gaming_prop_bet_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`prop_bet` ADD CONSTRAINT `fk_gaming_prop_bet_scoring_event_id` FOREIGN KEY (`scoring_event_id`) REFERENCES `sports_entertainment_ecm`.`event`.`scoring_event`(`scoring_event_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`parlay_leg` ADD CONSTRAINT `fk_gaming_parlay_leg_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`parlay_leg` ADD CONSTRAINT `fk_gaming_parlay_leg_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`fantasy_league` ADD CONSTRAINT `fk_gaming_fantasy_league_calendar_id` FOREIGN KEY (`calendar_id`) REFERENCES `sports_entertainment_ecm`.`event`.`calendar`(`calendar_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`fantasy_roster` ADD CONSTRAINT `fk_gaming_fantasy_roster_competition_round_id` FOREIGN KEY (`competition_round_id`) REFERENCES `sports_entertainment_ecm`.`event`.`competition_round`(`competition_round_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`market_suspension` ADD CONSTRAINT `fk_gaming_market_suspension_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`market_suspension` ADD CONSTRAINT `fk_gaming_market_suspension_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`integrity_alert` ADD CONSTRAINT `fk_gaming_integrity_alert_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`integrity_alert` ADD CONSTRAINT `fk_gaming_integrity_alert_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`contest` ADD CONSTRAINT `fk_gaming_contest_bracket_id` FOREIGN KEY (`bracket_id`) REFERENCES `sports_entertainment_ecm`.`event`.`bracket`(`bracket_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`contest` ADD CONSTRAINT `fk_gaming_contest_competition_round_id` FOREIGN KEY (`competition_round_id`) REFERENCES `sports_entertainment_ecm`.`event`.`competition_round`(`competition_round_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`contest` ADD CONSTRAINT `fk_gaming_contest_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`contest` ADD CONSTRAINT `fk_gaming_contest_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `sports_entertainment_ecm`.`event`.`tournament`(`tournament_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`esports_match` ADD CONSTRAINT `fk_gaming_esports_match_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `sports_entertainment_ecm`.`event`.`tournament`(`tournament_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`selection` ADD CONSTRAINT `fk_gaming_selection_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`selection` ADD CONSTRAINT `fk_gaming_selection_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `sports_entertainment_ecm`.`event`.`participant`(`participant_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`lineup` ADD CONSTRAINT `fk_gaming_lineup_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);

-- ========= gaming --> fan (3 constraint(s)) =========
-- Requires: gaming schema, fan schema
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`bettor_account` ADD CONSTRAINT `fk_gaming_bettor_account_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`self_exclusion` ADD CONSTRAINT `fk_gaming_self_exclusion_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`bonus_offer` ADD CONSTRAINT `fk_gaming_bonus_offer_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`segment`(`segment_id`);

-- ========= gaming --> finance (27 constraint(s)) =========
-- Requires: gaming schema, finance schema
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`wager` ADD CONSTRAINT `fk_gaming_wager_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`wager` ADD CONSTRAINT `fk_gaming_wager_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`bettor_account` ADD CONSTRAINT `fk_gaming_bettor_account_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`fantasy_league` ADD CONSTRAINT `fk_gaming_fantasy_league_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`wallet` ADD CONSTRAINT `fk_gaming_wallet_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`wallet` ADD CONSTRAINT `fk_gaming_wallet_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`wallet_transaction` ADD CONSTRAINT `fk_gaming_wallet_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`jurisdiction` ADD CONSTRAINT `fk_gaming_jurisdiction_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`regulatory_report` ADD CONSTRAINT `fk_gaming_regulatory_report_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`regulatory_report` ADD CONSTRAINT `fk_gaming_regulatory_report_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`regulatory_report` ADD CONSTRAINT `fk_gaming_regulatory_report_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`regulatory_report` ADD CONSTRAINT `fk_gaming_regulatory_report_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`bonus_offer` ADD CONSTRAINT `fk_gaming_bonus_offer_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`bonus_offer` ADD CONSTRAINT `fk_gaming_bonus_offer_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`bonus_redemption` ADD CONSTRAINT `fk_gaming_bonus_redemption_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`bonus_redemption` ADD CONSTRAINT `fk_gaming_bonus_redemption_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`contest` ADD CONSTRAINT `fk_gaming_contest_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`contest` ADD CONSTRAINT `fk_gaming_contest_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`contest` ADD CONSTRAINT `fk_gaming_contest_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`contest_entry` ADD CONSTRAINT `fk_gaming_contest_entry_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`payout` ADD CONSTRAINT `fk_gaming_payout_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`payout` ADD CONSTRAINT `fk_gaming_payout_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`payout` ADD CONSTRAINT `fk_gaming_payout_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`esports_team` ADD CONSTRAINT `fk_gaming_esports_team_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`esports_team` ADD CONSTRAINT `fk_gaming_esports_team_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`esports_match` ADD CONSTRAINT `fk_gaming_esports_match_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`esports_match` ADD CONSTRAINT `fk_gaming_esports_match_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);

-- ========= gaming --> league (25 constraint(s)) =========
-- Requires: gaming schema, league schema
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`betting_market` ADD CONSTRAINT `fk_gaming_betting_market_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`betting_market` ADD CONSTRAINT `fk_gaming_betting_market_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`betting_market` ADD CONSTRAINT `fk_gaming_betting_market_playoff_bracket_id` FOREIGN KEY (`playoff_bracket_id`) REFERENCES `sports_entertainment_ecm`.`league`.`playoff_bracket`(`playoff_bracket_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`prop_bet` ADD CONSTRAINT `fk_gaming_prop_bet_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`prop_bet` ADD CONSTRAINT `fk_gaming_prop_bet_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`prop_bet` ADD CONSTRAINT `fk_gaming_prop_bet_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`fantasy_league` ADD CONSTRAINT `fk_gaming_fantasy_league_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`fantasy_league` ADD CONSTRAINT `fk_gaming_fantasy_league_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`fantasy_roster` ADD CONSTRAINT `fk_gaming_fantasy_roster_trade_transaction_id` FOREIGN KEY (`trade_transaction_id`) REFERENCES `sports_entertainment_ecm`.`league`.`trade_transaction`(`trade_transaction_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`fantasy_team` ADD CONSTRAINT `fk_gaming_fantasy_team_division_id` FOREIGN KEY (`division_id`) REFERENCES `sports_entertainment_ecm`.`league`.`division`(`division_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`fantasy_team` ADD CONSTRAINT `fk_gaming_fantasy_team_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`fantasy_team` ADD CONSTRAINT `fk_gaming_fantasy_team_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`fantasy_draft` ADD CONSTRAINT `fk_gaming_fantasy_draft_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`fantasy_draft` ADD CONSTRAINT `fk_gaming_fantasy_draft_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`regulatory_report` ADD CONSTRAINT `fk_gaming_regulatory_report_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`market_suspension` ADD CONSTRAINT `fk_gaming_market_suspension_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`integrity_alert` ADD CONSTRAINT `fk_gaming_integrity_alert_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`integrity_alert` ADD CONSTRAINT `fk_gaming_integrity_alert_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`integrity_alert` ADD CONSTRAINT `fk_gaming_integrity_alert_official_id` FOREIGN KEY (`official_id`) REFERENCES `sports_entertainment_ecm`.`league`.`official`(`official_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`contest` ADD CONSTRAINT `fk_gaming_contest_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`contest` ADD CONSTRAINT `fk_gaming_contest_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`esports_team` ADD CONSTRAINT `fk_gaming_esports_team_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`lineup` ADD CONSTRAINT `fk_gaming_lineup_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`lineup` ADD CONSTRAINT `fk_gaming_lineup_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`lineup` ADD CONSTRAINT `fk_gaming_lineup_team_id` FOREIGN KEY (`team_id`) REFERENCES `sports_entertainment_ecm`.`league`.`team`(`team_id`);

-- ========= gaming --> legal (10 constraint(s)) =========
-- Requires: gaming schema, legal schema
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`betting_market` ADD CONSTRAINT `fk_gaming_betting_market_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`fantasy_league` ADD CONSTRAINT `fk_gaming_fantasy_league_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`self_exclusion` ADD CONSTRAINT `fk_gaming_self_exclusion_litigation_case_id` FOREIGN KEY (`litigation_case_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`litigation_case`(`litigation_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`regulatory_report` ADD CONSTRAINT `fk_gaming_regulatory_report_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`regulatory_report` ADD CONSTRAINT `fk_gaming_regulatory_report_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`bonus_offer` ADD CONSTRAINT `fk_gaming_bonus_offer_contract_template_id` FOREIGN KEY (`contract_template_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`contract_template`(`contract_template_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`integrity_alert` ADD CONSTRAINT `fk_gaming_integrity_alert_litigation_case_id` FOREIGN KEY (`litigation_case_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`litigation_case`(`litigation_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`integrity_alert` ADD CONSTRAINT `fk_gaming_integrity_alert_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`contest` ADD CONSTRAINT `fk_gaming_contest_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`payout` ADD CONSTRAINT `fk_gaming_payout_insurance_policy_id` FOREIGN KEY (`insurance_policy_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`insurance_policy`(`insurance_policy_id`);

-- ========= gaming --> merchandise (4 constraint(s)) =========
-- Requires: gaming schema, merchandise schema
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`wager` ADD CONSTRAINT `fk_gaming_wager_retail_location_id` FOREIGN KEY (`retail_location_id`) REFERENCES `sports_entertainment_ecm`.`merchandise`.`retail_location`(`retail_location_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`bonus_offer` ADD CONSTRAINT `fk_gaming_bonus_offer_sku_catalog_id` FOREIGN KEY (`sku_catalog_id`) REFERENCES `sports_entertainment_ecm`.`merchandise`.`sku_catalog`(`sku_catalog_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`contest` ADD CONSTRAINT `fk_gaming_contest_sku_catalog_id` FOREIGN KEY (`sku_catalog_id`) REFERENCES `sports_entertainment_ecm`.`merchandise`.`sku_catalog`(`sku_catalog_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`session` ADD CONSTRAINT `fk_gaming_session_retail_location_id` FOREIGN KEY (`retail_location_id`) REFERENCES `sports_entertainment_ecm`.`merchandise`.`retail_location`(`retail_location_id`);

-- ========= gaming --> partner (1 constraint(s)) =========
-- Requires: gaming schema, partner schema
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`odds_feed` ADD CONSTRAINT `fk_gaming_odds_feed_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);

-- ========= gaming --> platform (18 constraint(s)) =========
-- Requires: gaming schema, platform schema
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`wager` ADD CONSTRAINT `fk_gaming_wager_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`bettor_account` ADD CONSTRAINT `fk_gaming_bettor_account_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`bettor_account` ADD CONSTRAINT `fk_gaming_bettor_account_fan_account_id` FOREIGN KEY (`fan_account_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`fan_account`(`fan_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`fantasy_league` ADD CONSTRAINT `fk_gaming_fantasy_league_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`responsible_gaming_limit` ADD CONSTRAINT `fk_gaming_responsible_gaming_limit_fan_account_id` FOREIGN KEY (`fan_account_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`fan_account`(`fan_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`self_exclusion` ADD CONSTRAINT `fk_gaming_self_exclusion_fan_account_id` FOREIGN KEY (`fan_account_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`fan_account`(`fan_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`regulatory_report` ADD CONSTRAINT `fk_gaming_regulatory_report_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`bonus_offer` ADD CONSTRAINT `fk_gaming_bonus_offer_fan_segment_id` FOREIGN KEY (`fan_segment_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`fan_segment`(`fan_segment_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`bonus_offer` ADD CONSTRAINT `fk_gaming_bonus_offer_notification_campaign_id` FOREIGN KEY (`notification_campaign_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`notification_campaign`(`notification_campaign_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`bonus_redemption` ADD CONSTRAINT `fk_gaming_bonus_redemption_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`bonus_redemption` ADD CONSTRAINT `fk_gaming_bonus_redemption_notification_campaign_id` FOREIGN KEY (`notification_campaign_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`notification_campaign`(`notification_campaign_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`integrity_alert` ADD CONSTRAINT `fk_gaming_integrity_alert_fan_account_id` FOREIGN KEY (`fan_account_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`fan_account`(`fan_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`kyc_verification` ADD CONSTRAINT `fk_gaming_kyc_verification_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`contest` ADD CONSTRAINT `fk_gaming_contest_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`contest` ADD CONSTRAINT `fk_gaming_contest_fan_segment_id` FOREIGN KEY (`fan_segment_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`fan_segment`(`fan_segment_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`contest_entry` ADD CONSTRAINT `fk_gaming_contest_entry_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`session` ADD CONSTRAINT `fk_gaming_session_auth_session_id` FOREIGN KEY (`auth_session_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`auth_session`(`auth_session_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`session` ADD CONSTRAINT `fk_gaming_session_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);

-- ========= gaming --> security (1 constraint(s)) =========
-- Requires: gaming schema, security schema
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`regulatory_report` ADD CONSTRAINT `fk_gaming_regulatory_report_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `sports_entertainment_ecm`.`security`.`security_incident`(`security_incident_id`);

-- ========= gaming --> ticketing (3 constraint(s)) =========
-- Requires: gaming schema, ticketing schema
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`bettor_account` ADD CONSTRAINT `fk_gaming_bettor_account_season_ticket_account_id` FOREIGN KEY (`season_ticket_account_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`season_ticket_account`(`season_ticket_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`wallet_transaction` ADD CONSTRAINT `fk_gaming_wallet_transaction_ticket_order_id` FOREIGN KEY (`ticket_order_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`ticket_order`(`ticket_order_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`contest_entry` ADD CONSTRAINT `fk_gaming_contest_entry_ticket_order_id` FOREIGN KEY (`ticket_order_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`ticket_order`(`ticket_order_id`);

-- ========= gaming --> venue (7 constraint(s)) =========
-- Requires: gaming schema, venue schema
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`regulatory_report` ADD CONSTRAINT `fk_gaming_regulatory_report_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`facility`(`facility_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`integrity_alert` ADD CONSTRAINT `fk_gaming_integrity_alert_safety_incident_id` FOREIGN KEY (`safety_incident_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`safety_incident`(`safety_incident_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`session` ADD CONSTRAINT `fk_gaming_session_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`facility`(`facility_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`esports_match` ADD CONSTRAINT `fk_gaming_esports_match_capacity_config_id` FOREIGN KEY (`capacity_config_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`capacity_config`(`capacity_config_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`esports_match` ADD CONSTRAINT `fk_gaming_esports_match_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`facility`(`facility_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`esports_match` ADD CONSTRAINT `fk_gaming_esports_match_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`lineup` ADD CONSTRAINT `fk_gaming_lineup_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);

-- ========= gaming --> workforce (17 constraint(s)) =========
-- Requires: gaming schema, workforce schema
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`bettor_account` ADD CONSTRAINT `fk_gaming_bettor_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`fantasy_transaction` ADD CONSTRAINT `fk_gaming_fantasy_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`responsible_gaming_limit` ADD CONSTRAINT `fk_gaming_responsible_gaming_limit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`self_exclusion` ADD CONSTRAINT `fk_gaming_self_exclusion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`regulatory_report` ADD CONSTRAINT `fk_gaming_regulatory_report_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`regulatory_report` ADD CONSTRAINT `fk_gaming_regulatory_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`regulatory_report` ADD CONSTRAINT `fk_gaming_regulatory_report_primary_regulatory_employee_id` FOREIGN KEY (`primary_regulatory_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`regulatory_report` ADD CONSTRAINT `fk_gaming_regulatory_report_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`bonus_offer` ADD CONSTRAINT `fk_gaming_bonus_offer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`market_suspension` ADD CONSTRAINT `fk_gaming_market_suspension_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`market_suspension` ADD CONSTRAINT `fk_gaming_market_suspension_primary_market_employee_id` FOREIGN KEY (`primary_market_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`market_suspension` ADD CONSTRAINT `fk_gaming_market_suspension_reinstated_by_user_employee_id` FOREIGN KEY (`reinstated_by_user_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`integrity_alert` ADD CONSTRAINT `fk_gaming_integrity_alert_assigned_investigator_employee_id` FOREIGN KEY (`assigned_investigator_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`integrity_alert` ADD CONSTRAINT `fk_gaming_integrity_alert_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`kyc_verification` ADD CONSTRAINT `fk_gaming_kyc_verification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`kyc_verification` ADD CONSTRAINT `fk_gaming_kyc_verification_verifying_agent_employee_id` FOREIGN KEY (`verifying_agent_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`gaming`.`lineup` ADD CONSTRAINT `fk_gaming_lineup_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= league --> athlete (8 constraint(s)) =========
-- Requires: league schema, athlete schema
ALTER TABLE `sports_entertainment_ecm`.`league`.`playoff_bracket` ADD CONSTRAINT `fk_league_playoff_bracket_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`playoff_bracket` ADD CONSTRAINT `fk_league_playoff_bracket_mvp_athlete_athlete_profile_id` FOREIGN KEY (`mvp_athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`draft_pick` ADD CONSTRAINT `fk_league_draft_pick_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`draft_pick` ADD CONSTRAINT `fk_league_draft_pick_selected_athlete_athlete_profile_id` FOREIGN KEY (`selected_athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`trade_transaction` ADD CONSTRAINT `fk_league_trade_transaction_athlete_athlete_profile_id` FOREIGN KEY (`athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`trade_transaction` ADD CONSTRAINT `fk_league_trade_transaction_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`waiver_claim` ADD CONSTRAINT `fk_league_waiver_claim_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`waiver_claim` ADD CONSTRAINT `fk_league_waiver_claim_player_athlete_profile_id` FOREIGN KEY (`player_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);

-- ========= league --> broadcast (4 constraint(s)) =========
-- Requires: league schema, broadcast schema
ALTER TABLE `sports_entertainment_ecm`.`league`.`playoff_bracket` ADD CONSTRAINT `fk_league_playoff_bracket_broadcast_rights_package_media_rights_deal_id` FOREIGN KEY (`broadcast_rights_package_media_rights_deal_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`media_rights_deal`(`media_rights_deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`playoff_bracket` ADD CONSTRAINT `fk_league_playoff_bracket_media_rights_deal_id` FOREIGN KEY (`media_rights_deal_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`media_rights_deal`(`media_rights_deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`game_result` ADD CONSTRAINT `fk_league_game_result_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`franchise_agreement` ADD CONSTRAINT `fk_league_franchise_agreement_media_rights_deal_id` FOREIGN KEY (`media_rights_deal_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`media_rights_deal`(`media_rights_deal_id`);

-- ========= league --> compliance (5 constraint(s)) =========
-- Requires: league schema, compliance schema
ALTER TABLE `sports_entertainment_ecm`.`league`.`league` ADD CONSTRAINT `fk_league_league_governing_body_id` FOREIGN KEY (`governing_body_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`governing_body`(`governing_body_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`disciplinary_action` ADD CONSTRAINT `fk_league_disciplinary_action_doping_violation_id` FOREIGN KEY (`doping_violation_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`doping_violation`(`doping_violation_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`disciplinary_action` ADD CONSTRAINT `fk_league_disciplinary_action_governing_body_id` FOREIGN KEY (`governing_body_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`governing_body`(`governing_body_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`international_federation` ADD CONSTRAINT `fk_league_international_federation_governing_body_id` FOREIGN KEY (`governing_body_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`governing_body`(`governing_body_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`regulatory_oversight` ADD CONSTRAINT `fk_league_regulatory_oversight_governing_body_id` FOREIGN KEY (`governing_body_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`governing_body`(`governing_body_id`);

-- ========= league --> event (2 constraint(s)) =========
-- Requires: league schema, event schema
ALTER TABLE `sports_entertainment_ecm`.`league`.`game_result` ADD CONSTRAINT `fk_league_game_result_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`disciplinary_action` ADD CONSTRAINT `fk_league_disciplinary_action_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);

-- ========= league --> fan (1 constraint(s)) =========
-- Requires: league schema, fan schema
ALTER TABLE `sports_entertainment_ecm`.`league`.`draft_pick` ADD CONSTRAINT `fk_league_draft_pick_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`segment`(`segment_id`);

-- ========= league --> finance (20 constraint(s)) =========
-- Requires: league schema, finance schema
ALTER TABLE `sports_entertainment_ecm`.`league`.`league` ADD CONSTRAINT `fk_league_league_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`franchise` ADD CONSTRAINT `fk_league_franchise_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`franchise` ADD CONSTRAINT `fk_league_franchise_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`franchise` ADD CONSTRAINT `fk_league_franchise_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`franchise` ADD CONSTRAINT `fk_league_franchise_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`game_result` ADD CONSTRAINT `fk_league_game_result_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`disciplinary_action` ADD CONSTRAINT `fk_league_disciplinary_action_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`cba_agreement` ADD CONSTRAINT `fk_league_cba_agreement_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`sox_control`(`sox_control_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`salary_cap` ADD CONSTRAINT `fk_league_salary_cap_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`salary_cap` ADD CONSTRAINT `fk_league_salary_cap_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`salary_cap` ADD CONSTRAINT `fk_league_salary_cap_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`salary_cap` ADD CONSTRAINT `fk_league_salary_cap_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`draft` ADD CONSTRAINT `fk_league_draft_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`draft` ADD CONSTRAINT `fk_league_draft_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`franchise_agreement` ADD CONSTRAINT `fk_league_franchise_agreement_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`franchise_agreement` ADD CONSTRAINT `fk_league_franchise_agreement_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`trade_transaction` ADD CONSTRAINT `fk_league_trade_transaction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`waiver_claim` ADD CONSTRAINT `fk_league_waiver_claim_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`international_federation` ADD CONSTRAINT `fk_league_international_federation_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`revenue_allocation` ADD CONSTRAINT `fk_league_revenue_allocation_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);

-- ========= league --> legal (5 constraint(s)) =========
-- Requires: league schema, legal schema
ALTER TABLE `sports_entertainment_ecm`.`league`.`league` ADD CONSTRAINT `fk_league_league_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`franchise` ADD CONSTRAINT `fk_league_franchise_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`cba_agreement` ADD CONSTRAINT `fk_league_cba_agreement_outside_counsel_id` FOREIGN KEY (`outside_counsel_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`outside_counsel`(`outside_counsel_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`franchise_agreement` ADD CONSTRAINT `fk_league_franchise_agreement_insurance_policy_id` FOREIGN KEY (`insurance_policy_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`insurance_policy`(`insurance_policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`international_federation` ADD CONSTRAINT `fk_league_international_federation_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);

-- ========= league --> partner (3 constraint(s)) =========
-- Requires: league schema, partner schema
ALTER TABLE `sports_entertainment_ecm`.`league`.`officiating_crew` ADD CONSTRAINT `fk_league_officiating_crew_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`officiating_crew` ADD CONSTRAINT `fk_league_officiating_crew_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`partnership` ADD CONSTRAINT `fk_league_partnership_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);

-- ========= league --> platform (2 constraint(s)) =========
-- Requires: league schema, platform schema
ALTER TABLE `sports_entertainment_ecm`.`league`.`franchise_distribution_right` ADD CONSTRAINT `fk_league_franchise_distribution_right_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`streaming_rights_authorization` ADD CONSTRAINT `fk_league_streaming_rights_authorization_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);

-- ========= league --> venue (9 constraint(s)) =========
-- Requires: league schema, venue schema
ALTER TABLE `sports_entertainment_ecm`.`league`.`franchise` ADD CONSTRAINT `fk_league_franchise_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`season` ADD CONSTRAINT `fk_league_season_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`league_schedule` ADD CONSTRAINT `fk_league_league_schedule_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`playoff_bracket` ADD CONSTRAINT `fk_league_playoff_bracket_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`game_result` ADD CONSTRAINT `fk_league_game_result_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`officiating_crew` ADD CONSTRAINT `fk_league_officiating_crew_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`draft` ADD CONSTRAINT `fk_league_draft_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`team` ADD CONSTRAINT `fk_league_team_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`team` ADD CONSTRAINT `fk_league_team_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`facility`(`facility_id`);

-- ========= league --> workforce (9 constraint(s)) =========
-- Requires: league schema, workforce schema
ALTER TABLE `sports_entertainment_ecm`.`league`.`franchise` ADD CONSTRAINT `fk_league_franchise_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`cba_agreement` ADD CONSTRAINT `fk_league_cba_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`trade_transaction` ADD CONSTRAINT `fk_league_trade_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`trade_transaction` ADD CONSTRAINT `fk_league_trade_transaction_league_approver_employee_id` FOREIGN KEY (`league_approver_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`waiver_claim` ADD CONSTRAINT `fk_league_waiver_claim_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`roster_filing` ADD CONSTRAINT `fk_league_roster_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`team` ADD CONSTRAINT `fk_league_team_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`team` ADD CONSTRAINT `fk_league_team_general_manager_employee_id` FOREIGN KEY (`general_manager_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`league`.`team` ADD CONSTRAINT `fk_league_team_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= legal --> athlete (3 constraint(s)) =========
-- Requires: legal schema, athlete schema
ALTER TABLE `sports_entertainment_ecm`.`legal`.`contract_obligation` ADD CONSTRAINT `fk_legal_contract_obligation_athlete_contract_id` FOREIGN KEY (`athlete_contract_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_contract`(`athlete_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`opinion` ADD CONSTRAINT `fk_legal_opinion_athlete_contract_id` FOREIGN KEY (`athlete_contract_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_contract`(`athlete_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`opinion` ADD CONSTRAINT `fk_legal_opinion_opinion_related_contract_athlete_contract_id` FOREIGN KEY (`opinion_related_contract_athlete_contract_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_contract`(`athlete_contract_id`);

-- ========= legal --> compliance (6 constraint(s)) =========
-- Requires: legal schema, compliance schema
ALTER TABLE `sports_entertainment_ecm`.`legal`.`hold` ADD CONSTRAINT `fk_legal_hold_breach_notification_id` FOREIGN KEY (`breach_notification_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`breach_notification`(`breach_notification_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`hold` ADD CONSTRAINT `fk_legal_hold_incident_report_id` FOREIGN KEY (`incident_report_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`incident_report`(`incident_report_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`insurance_claim` ADD CONSTRAINT `fk_legal_insurance_claim_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`regulatory_license` ADD CONSTRAINT `fk_legal_regulatory_license_governing_body_id` FOREIGN KEY (`governing_body_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`governing_body`(`governing_body_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`settlement_agreement` ADD CONSTRAINT `fk_legal_settlement_agreement_arbitration_case_id` FOREIGN KEY (`arbitration_case_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`arbitration_case`(`arbitration_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`settlement_agreement` ADD CONSTRAINT `fk_legal_settlement_agreement_sanction_id` FOREIGN KEY (`sanction_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`sanction`(`sanction_id`);

-- ========= legal --> content (3 constraint(s)) =========
-- Requires: legal schema, content schema
ALTER TABLE `sports_entertainment_ecm`.`legal`.`ip_enforcement_action` ADD CONSTRAINT `fk_legal_ip_enforcement_action_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`contract_obligation` ADD CONSTRAINT `fk_legal_contract_obligation_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`opinion` ADD CONSTRAINT `fk_legal_opinion_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);

-- ========= legal --> event (9 constraint(s)) =========
-- Requires: legal schema, event schema
ALTER TABLE `sports_entertainment_ecm`.`legal`.`litigation_case` ADD CONSTRAINT `fk_legal_litigation_case_event_incident_id` FOREIGN KEY (`event_incident_id`) REFERENCES `sports_entertainment_ecm`.`event`.`event_incident`(`event_incident_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`litigation_case` ADD CONSTRAINT `fk_legal_litigation_case_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`matter` ADD CONSTRAINT `fk_legal_matter_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `sports_entertainment_ecm`.`event`.`tournament`(`tournament_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`insurance_claim` ADD CONSTRAINT `fk_legal_insurance_claim_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`insurance_claim` ADD CONSTRAINT `fk_legal_insurance_claim_event_incident_id` FOREIGN KEY (`event_incident_id`) REFERENCES `sports_entertainment_ecm`.`event`.`event_incident`(`event_incident_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`insurance_claim` ADD CONSTRAINT `fk_legal_insurance_claim_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`insurance_claim` ADD CONSTRAINT `fk_legal_insurance_claim_status_history_id` FOREIGN KEY (`status_history_id`) REFERENCES `sports_entertainment_ecm`.`event`.`status_history`(`status_history_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`insurance_claim` ADD CONSTRAINT `fk_legal_insurance_claim_weather_contingency_id` FOREIGN KEY (`weather_contingency_id`) REFERENCES `sports_entertainment_ecm`.`event`.`weather_contingency`(`weather_contingency_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`contract_obligation` ADD CONSTRAINT `fk_legal_contract_obligation_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `sports_entertainment_ecm`.`event`.`participant`(`participant_id`);

-- ========= legal --> fan (1 constraint(s)) =========
-- Requires: legal schema, fan schema
ALTER TABLE `sports_entertainment_ecm`.`legal`.`settlement_agreement` ADD CONSTRAINT `fk_legal_settlement_agreement_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);

-- ========= legal --> gaming (1 constraint(s)) =========
-- Requires: legal schema, gaming schema
ALTER TABLE `sports_entertainment_ecm`.`legal`.`litigation_case` ADD CONSTRAINT `fk_legal_litigation_case_bettor_account_id` FOREIGN KEY (`bettor_account_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`bettor_account`(`bettor_account_id`);

-- ========= legal --> league (33 constraint(s)) =========
-- Requires: legal schema, league schema
ALTER TABLE `sports_entertainment_ecm`.`legal`.`ip_portfolio` ADD CONSTRAINT `fk_legal_ip_portfolio_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`ip_portfolio` ADD CONSTRAINT `fk_legal_ip_portfolio_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`litigation_case` ADD CONSTRAINT `fk_legal_litigation_case_cba_agreement_id` FOREIGN KEY (`cba_agreement_id`) REFERENCES `sports_entertainment_ecm`.`league`.`cba_agreement`(`cba_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`litigation_case` ADD CONSTRAINT `fk_legal_litigation_case_disciplinary_action_id` FOREIGN KEY (`disciplinary_action_id`) REFERENCES `sports_entertainment_ecm`.`league`.`disciplinary_action`(`disciplinary_action_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`litigation_case` ADD CONSTRAINT `fk_legal_litigation_case_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`litigation_case` ADD CONSTRAINT `fk_legal_litigation_case_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`litigation_case` ADD CONSTRAINT `fk_legal_litigation_case_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`contract_template` ADD CONSTRAINT `fk_legal_contract_template_cba_agreement_id` FOREIGN KEY (`cba_agreement_id`) REFERENCES `sports_entertainment_ecm`.`league`.`cba_agreement`(`cba_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`matter` ADD CONSTRAINT `fk_legal_matter_cap_compliance_id` FOREIGN KEY (`cap_compliance_id`) REFERENCES `sports_entertainment_ecm`.`league`.`cap_compliance`(`cap_compliance_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`matter` ADD CONSTRAINT `fk_legal_matter_cba_agreement_id` FOREIGN KEY (`cba_agreement_id`) REFERENCES `sports_entertainment_ecm`.`league`.`cba_agreement`(`cba_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`matter` ADD CONSTRAINT `fk_legal_matter_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`matter` ADD CONSTRAINT `fk_legal_matter_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`matter` ADD CONSTRAINT `fk_legal_matter_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`matter` ADD CONSTRAINT `fk_legal_matter_salary_cap_id` FOREIGN KEY (`salary_cap_id`) REFERENCES `sports_entertainment_ecm`.`league`.`salary_cap`(`salary_cap_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`insurance_policy` ADD CONSTRAINT `fk_legal_insurance_policy_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`insurance_policy` ADD CONSTRAINT `fk_legal_insurance_policy_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`governance_document` ADD CONSTRAINT `fk_legal_governance_document_cba_agreement_id` FOREIGN KEY (`cba_agreement_id`) REFERENCES `sports_entertainment_ecm`.`league`.`cba_agreement`(`cba_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`nda` ADD CONSTRAINT `fk_legal_nda_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`nda` ADD CONSTRAINT `fk_legal_nda_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`regulatory_license` ADD CONSTRAINT `fk_legal_regulatory_license_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`regulatory_license` ADD CONSTRAINT `fk_legal_regulatory_license_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`spend_budget` ADD CONSTRAINT `fk_legal_spend_budget_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`spend_budget` ADD CONSTRAINT `fk_legal_spend_budget_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`contract_obligation` ADD CONSTRAINT `fk_legal_contract_obligation_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`opinion` ADD CONSTRAINT `fk_legal_opinion_cba_agreement_id` FOREIGN KEY (`cba_agreement_id`) REFERENCES `sports_entertainment_ecm`.`league`.`cba_agreement`(`cba_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`opinion` ADD CONSTRAINT `fk_legal_opinion_disciplinary_action_id` FOREIGN KEY (`disciplinary_action_id`) REFERENCES `sports_entertainment_ecm`.`league`.`disciplinary_action`(`disciplinary_action_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`opinion` ADD CONSTRAINT `fk_legal_opinion_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`opinion` ADD CONSTRAINT `fk_legal_opinion_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`opinion` ADD CONSTRAINT `fk_legal_opinion_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`settlement_agreement` ADD CONSTRAINT `fk_legal_settlement_agreement_cba_agreement_id` FOREIGN KEY (`cba_agreement_id`) REFERENCES `sports_entertainment_ecm`.`league`.`cba_agreement`(`cba_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`settlement_agreement` ADD CONSTRAINT `fk_legal_settlement_agreement_disciplinary_action_id` FOREIGN KEY (`disciplinary_action_id`) REFERENCES `sports_entertainment_ecm`.`league`.`disciplinary_action`(`disciplinary_action_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`settlement_agreement` ADD CONSTRAINT `fk_legal_settlement_agreement_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`settlement_agreement` ADD CONSTRAINT `fk_legal_settlement_agreement_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);

-- ========= legal --> merchandise (2 constraint(s)) =========
-- Requires: legal schema, merchandise schema
ALTER TABLE `sports_entertainment_ecm`.`legal`.`contract_obligation` ADD CONSTRAINT `fk_legal_contract_obligation_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `sports_entertainment_ecm`.`merchandise`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`settlement_agreement` ADD CONSTRAINT `fk_legal_settlement_agreement_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `sports_entertainment_ecm`.`merchandise`.`licensing_agreement`(`licensing_agreement_id`);

-- ========= legal --> partner (1 constraint(s)) =========
-- Requires: legal schema, partner schema
ALTER TABLE `sports_entertainment_ecm`.`legal`.`nda` ADD CONSTRAINT `fk_legal_nda_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);

-- ========= legal --> sponsorship (1 constraint(s)) =========
-- Requires: legal schema, sponsorship schema
ALTER TABLE `sports_entertainment_ecm`.`legal`.`contract_obligation` ADD CONSTRAINT `fk_legal_contract_obligation_deal_term_id` FOREIGN KEY (`deal_term_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`deal_term`(`deal_term_id`);

-- ========= legal --> venue (3 constraint(s)) =========
-- Requires: legal schema, venue schema
ALTER TABLE `sports_entertainment_ecm`.`legal`.`insurance_claim` ADD CONSTRAINT `fk_legal_insurance_claim_safety_incident_id` FOREIGN KEY (`safety_incident_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`safety_incident`(`safety_incident_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`insurance_claim` ADD CONSTRAINT `fk_legal_insurance_claim_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`regulatory_license` ADD CONSTRAINT `fk_legal_regulatory_license_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`facility`(`facility_id`);

-- ========= legal --> workforce (28 constraint(s)) =========
-- Requires: legal schema, workforce schema
ALTER TABLE `sports_entertainment_ecm`.`legal`.`trademark_registration` ADD CONSTRAINT `fk_legal_trademark_registration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`litigation_case` ADD CONSTRAINT `fk_legal_litigation_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`litigation_event` ADD CONSTRAINT `fk_legal_litigation_event_attorney_employee_id` FOREIGN KEY (`attorney_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`litigation_event` ADD CONSTRAINT `fk_legal_litigation_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`hold` ADD CONSTRAINT `fk_legal_hold_approving_counsel_employee_id` FOREIGN KEY (`approving_counsel_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`hold` ADD CONSTRAINT `fk_legal_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`hold` ADD CONSTRAINT `fk_legal_hold_hold_approving_counsel_employee_id` FOREIGN KEY (`hold_approving_counsel_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`hold` ADD CONSTRAINT `fk_legal_hold_hold_employee_id` FOREIGN KEY (`hold_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`contract_template` ADD CONSTRAINT `fk_legal_contract_template_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`contract_template` ADD CONSTRAINT `fk_legal_contract_template_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`contract_template` ADD CONSTRAINT `fk_legal_contract_template_primary_contract_employee_id` FOREIGN KEY (`primary_contract_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`matter` ADD CONSTRAINT `fk_legal_matter_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`matter` ADD CONSTRAINT `fk_legal_matter_supervising_counsel_employee_id` FOREIGN KEY (`supervising_counsel_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`matter` ADD CONSTRAINT `fk_legal_matter_supervising_counsel_id` FOREIGN KEY (`supervising_counsel_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`counsel_engagement` ADD CONSTRAINT `fk_legal_counsel_engagement_approving_counsel_employee_id` FOREIGN KEY (`approving_counsel_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`counsel_engagement` ADD CONSTRAINT `fk_legal_counsel_engagement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`invoice` ADD CONSTRAINT `fk_legal_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`invoice` ADD CONSTRAINT `fk_legal_invoice_reviewing_counsel_employee_id` FOREIGN KEY (`reviewing_counsel_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`insurance_claim` ADD CONSTRAINT `fk_legal_insurance_claim_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`insurance_claim` ADD CONSTRAINT `fk_legal_insurance_claim_primary_insurance_employee_id` FOREIGN KEY (`primary_insurance_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`deadline` ADD CONSTRAINT `fk_legal_deadline_attorney_employee_id` FOREIGN KEY (`attorney_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`deadline` ADD CONSTRAINT `fk_legal_deadline_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`opinion` ADD CONSTRAINT `fk_legal_opinion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`opinion` ADD CONSTRAINT `fk_legal_opinion_issuing_counsel_employee_id` FOREIGN KEY (`issuing_counsel_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`opinion` ADD CONSTRAINT `fk_legal_opinion_opinion_employee_id` FOREIGN KEY (`opinion_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`opinion` ADD CONSTRAINT `fk_legal_opinion_opinion_issuing_counsel_employee_id` FOREIGN KEY (`opinion_issuing_counsel_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`settlement_agreement` ADD CONSTRAINT `fk_legal_settlement_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`legal`.`settlement_agreement` ADD CONSTRAINT `fk_legal_settlement_agreement_inhouse_counsel_employee_id` FOREIGN KEY (`inhouse_counsel_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= merchandise --> athlete (11 constraint(s)) =========
-- Requires: merchandise schema, athlete schema
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`sku_catalog` ADD CONSTRAINT `fk_merchandise_sku_catalog_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`order_line` ADD CONSTRAINT `fk_merchandise_order_line_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`licensing_agreement` ADD CONSTRAINT `fk_merchandise_licensing_agreement_athlete_athlete_profile_id` FOREIGN KEY (`athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`licensing_agreement` ADD CONSTRAINT `fk_merchandise_licensing_agreement_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`licensing_agreement` ADD CONSTRAINT `fk_merchandise_licensing_agreement_nil_agreement_id` FOREIGN KEY (`nil_agreement_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`nil_agreement`(`nil_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`royalty_payment` ADD CONSTRAINT `fk_merchandise_royalty_payment_nil_agreement_id` FOREIGN KEY (`nil_agreement_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`nil_agreement`(`nil_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`promotion` ADD CONSTRAINT `fk_merchandise_promotion_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`memorabilia_item` ADD CONSTRAINT `fk_merchandise_memorabilia_item_athlete_athlete_profile_id` FOREIGN KEY (`athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`memorabilia_item` ADD CONSTRAINT `fk_merchandise_memorabilia_item_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`memorabilia_item` ADD CONSTRAINT `fk_merchandise_memorabilia_item_award_honor_id` FOREIGN KEY (`award_honor_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`award_honor`(`award_honor_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`memorabilia_item` ADD CONSTRAINT `fk_merchandise_memorabilia_item_nil_agreement_id` FOREIGN KEY (`nil_agreement_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`nil_agreement`(`nil_agreement_id`);

-- ========= merchandise --> broadcast (3 constraint(s)) =========
-- Requires: merchandise schema, broadcast schema
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`licensing_agreement` ADD CONSTRAINT `fk_merchandise_licensing_agreement_media_rights_deal_id` FOREIGN KEY (`media_rights_deal_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`media_rights_deal`(`media_rights_deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`promotion` ADD CONSTRAINT `fk_merchandise_promotion_ppv_package_id` FOREIGN KEY (`ppv_package_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`ppv_package`(`ppv_package_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`memorabilia_item` ADD CONSTRAINT `fk_merchandise_memorabilia_item_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);

-- ========= merchandise --> compliance (22 constraint(s)) =========
-- Requires: merchandise schema, compliance schema
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`retail_location` ADD CONSTRAINT `fk_merchandise_retail_location_license_permit_id` FOREIGN KEY (`license_permit_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`license_permit`(`license_permit_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`merch_order` ADD CONSTRAINT `fk_merchandise_merch_order_incident_report_id` FOREIGN KEY (`incident_report_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`incident_report`(`incident_report_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`licensing_agreement` ADD CONSTRAINT `fk_merchandise_licensing_agreement_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`licensing_agreement` ADD CONSTRAINT `fk_merchandise_licensing_agreement_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`licensing_agreement` ADD CONSTRAINT `fk_merchandise_licensing_agreement_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`licensing_agreement` ADD CONSTRAINT `fk_merchandise_licensing_agreement_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`royalty_payment` ADD CONSTRAINT `fk_merchandise_royalty_payment_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`royalty_payment` ADD CONSTRAINT `fk_merchandise_royalty_payment_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`merchandise_goods_receipt` ADD CONSTRAINT `fk_merchandise_merchandise_goods_receipt_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`merchandise_goods_receipt` ADD CONSTRAINT `fk_merchandise_merchandise_goods_receipt_incident_report_id` FOREIGN KEY (`incident_report_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`incident_report`(`incident_report_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`return_request` ADD CONSTRAINT `fk_merchandise_return_request_incident_report_id` FOREIGN KEY (`incident_report_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`incident_report`(`incident_report_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`promotion` ADD CONSTRAINT `fk_merchandise_promotion_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`promotion` ADD CONSTRAINT `fk_merchandise_promotion_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`compliance_check` ADD CONSTRAINT `fk_merchandise_compliance_check_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`compliance_check` ADD CONSTRAINT `fk_merchandise_compliance_check_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`compliance_check` ADD CONSTRAINT `fk_merchandise_compliance_check_incident_report_id` FOREIGN KEY (`incident_report_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`incident_report`(`incident_report_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`compliance_check` ADD CONSTRAINT `fk_merchandise_compliance_check_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`supplier` ADD CONSTRAINT `fk_merchandise_supplier_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`supplier` ADD CONSTRAINT `fk_merchandise_supplier_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`supplier` ADD CONSTRAINT `fk_merchandise_supplier_incident_report_id` FOREIGN KEY (`incident_report_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`incident_report`(`incident_report_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`supplier` ADD CONSTRAINT `fk_merchandise_supplier_license_permit_id` FOREIGN KEY (`license_permit_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`license_permit`(`license_permit_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`memorabilia_item` ADD CONSTRAINT `fk_merchandise_memorabilia_item_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);

-- ========= merchandise --> content (3 constraint(s)) =========
-- Requires: merchandise schema, content schema
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`promotion` ADD CONSTRAINT `fk_merchandise_promotion_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`compliance_check` ADD CONSTRAINT `fk_merchandise_compliance_check_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`memorabilia_item` ADD CONSTRAINT `fk_merchandise_memorabilia_item_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);

-- ========= merchandise --> event (21 constraint(s)) =========
-- Requires: merchandise schema, event schema
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`inventory_position` ADD CONSTRAINT `fk_merchandise_inventory_position_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`inventory_position` ADD CONSTRAINT `fk_merchandise_inventory_position_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`merch_order` ADD CONSTRAINT `fk_merchandise_merch_order_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`merch_order` ADD CONSTRAINT `fk_merchandise_merch_order_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`order_line` ADD CONSTRAINT `fk_merchandise_order_line_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`order_line` ADD CONSTRAINT `fk_merchandise_order_line_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`licensing_agreement` ADD CONSTRAINT `fk_merchandise_licensing_agreement_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `sports_entertainment_ecm`.`event`.`tournament`(`tournament_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`price_list` ADD CONSTRAINT `fk_merchandise_price_list_competition_round_id` FOREIGN KEY (`competition_round_id`) REFERENCES `sports_entertainment_ecm`.`event`.`competition_round`(`competition_round_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`price_list` ADD CONSTRAINT `fk_merchandise_price_list_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`price_list` ADD CONSTRAINT `fk_merchandise_price_list_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`price_list` ADD CONSTRAINT `fk_merchandise_price_list_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `sports_entertainment_ecm`.`event`.`tournament`(`tournament_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`promotion` ADD CONSTRAINT `fk_merchandise_promotion_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`promotion` ADD CONSTRAINT `fk_merchandise_promotion_associated_fixture_id` FOREIGN KEY (`associated_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`promotion` ADD CONSTRAINT `fk_merchandise_promotion_competition_round_id` FOREIGN KEY (`competition_round_id`) REFERENCES `sports_entertainment_ecm`.`event`.`competition_round`(`competition_round_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`promotion` ADD CONSTRAINT `fk_merchandise_promotion_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `sports_entertainment_ecm`.`event`.`tournament`(`tournament_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`inventory_transfer` ADD CONSTRAINT `fk_merchandise_inventory_transfer_competition_round_id` FOREIGN KEY (`competition_round_id`) REFERENCES `sports_entertainment_ecm`.`event`.`competition_round`(`competition_round_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`inventory_transfer` ADD CONSTRAINT `fk_merchandise_inventory_transfer_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`inventory_transfer` ADD CONSTRAINT `fk_merchandise_inventory_transfer_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`memorabilia_item` ADD CONSTRAINT `fk_merchandise_memorabilia_item_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`memorabilia_item` ADD CONSTRAINT `fk_merchandise_memorabilia_item_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`memorabilia_item` ADD CONSTRAINT `fk_merchandise_memorabilia_item_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `sports_entertainment_ecm`.`event`.`tournament`(`tournament_id`);

-- ========= merchandise --> fan (9 constraint(s)) =========
-- Requires: merchandise schema, fan schema
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`merch_order` ADD CONSTRAINT `fk_merchandise_merch_order_fan_fan_profile_id` FOREIGN KEY (`fan_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`merch_order` ADD CONSTRAINT `fk_merchandise_merch_order_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`payment_method`(`payment_method_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`merch_order` ADD CONSTRAINT `fk_merchandise_merch_order_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`merch_order` ADD CONSTRAINT `fk_merchandise_merch_order_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`membership`(`membership_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`fulfillment_shipment` ADD CONSTRAINT `fk_merchandise_fulfillment_shipment_fan_fan_profile_id` FOREIGN KEY (`fan_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`fulfillment_shipment` ADD CONSTRAINT `fk_merchandise_fulfillment_shipment_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`return_request` ADD CONSTRAINT `fk_merchandise_return_request_customer_fan_profile_id` FOREIGN KEY (`customer_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`return_request` ADD CONSTRAINT `fk_merchandise_return_request_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`promotion` ADD CONSTRAINT `fk_merchandise_promotion_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`segment`(`segment_id`);

-- ========= merchandise --> finance (30 constraint(s)) =========
-- Requires: merchandise schema, finance schema
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`sku_catalog` ADD CONSTRAINT `fk_merchandise_sku_catalog_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`sku_catalog` ADD CONSTRAINT `fk_merchandise_sku_catalog_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`inventory_position` ADD CONSTRAINT `fk_merchandise_inventory_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`inventory_position` ADD CONSTRAINT `fk_merchandise_inventory_position_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`retail_location` ADD CONSTRAINT `fk_merchandise_retail_location_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`retail_location` ADD CONSTRAINT `fk_merchandise_retail_location_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`retail_location` ADD CONSTRAINT `fk_merchandise_retail_location_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`retail_location` ADD CONSTRAINT `fk_merchandise_retail_location_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`merch_order` ADD CONSTRAINT `fk_merchandise_merch_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`merch_order` ADD CONSTRAINT `fk_merchandise_merch_order_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`merch_order` ADD CONSTRAINT `fk_merchandise_merch_order_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`order_line` ADD CONSTRAINT `fk_merchandise_order_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`licensing_agreement` ADD CONSTRAINT `fk_merchandise_licensing_agreement_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`licensing_agreement` ADD CONSTRAINT `fk_merchandise_licensing_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`licensing_agreement` ADD CONSTRAINT `fk_merchandise_licensing_agreement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`licensing_agreement` ADD CONSTRAINT `fk_merchandise_licensing_agreement_revenue_recognition_schedule_id` FOREIGN KEY (`revenue_recognition_schedule_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_recognition_schedule`(`revenue_recognition_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`royalty_payment` ADD CONSTRAINT `fk_merchandise_royalty_payment_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`royalty_payment` ADD CONSTRAINT `fk_merchandise_royalty_payment_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`royalty_payment` ADD CONSTRAINT `fk_merchandise_royalty_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`royalty_payment` ADD CONSTRAINT `fk_merchandise_royalty_payment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`merchandise_goods_receipt` ADD CONSTRAINT `fk_merchandise_merchandise_goods_receipt_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`return_request` ADD CONSTRAINT `fk_merchandise_return_request_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`price_list` ADD CONSTRAINT `fk_merchandise_price_list_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`promotion` ADD CONSTRAINT `fk_merchandise_promotion_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`promotion` ADD CONSTRAINT `fk_merchandise_promotion_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`promotion` ADD CONSTRAINT `fk_merchandise_promotion_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`inventory_transfer` ADD CONSTRAINT `fk_merchandise_inventory_transfer_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`wholesale_account` ADD CONSTRAINT `fk_merchandise_wholesale_account_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`memorabilia_item` ADD CONSTRAINT `fk_merchandise_memorabilia_item_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`memorabilia_item` ADD CONSTRAINT `fk_merchandise_memorabilia_item_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= merchandise --> gaming (6 constraint(s)) =========
-- Requires: merchandise schema, gaming schema
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`sku_catalog` ADD CONSTRAINT `fk_merchandise_sku_catalog_esports_team_id` FOREIGN KEY (`esports_team_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`esports_team`(`esports_team_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`merch_order` ADD CONSTRAINT `fk_merchandise_merch_order_session_id` FOREIGN KEY (`session_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`session`(`session_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`licensing_agreement` ADD CONSTRAINT `fk_merchandise_licensing_agreement_esports_team_id` FOREIGN KEY (`esports_team_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`esports_team`(`esports_team_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`promotion` ADD CONSTRAINT `fk_merchandise_promotion_bonus_offer_id` FOREIGN KEY (`bonus_offer_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`bonus_offer`(`bonus_offer_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`promotion` ADD CONSTRAINT `fk_merchandise_promotion_contest_id` FOREIGN KEY (`contest_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`contest`(`contest_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`memorabilia_item` ADD CONSTRAINT `fk_merchandise_memorabilia_item_esports_match_id` FOREIGN KEY (`esports_match_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`esports_match`(`esports_match_id`);

-- ========= merchandise --> league (30 constraint(s)) =========
-- Requires: merchandise schema, league schema
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`sku_catalog` ADD CONSTRAINT `fk_merchandise_sku_catalog_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`sku_catalog` ADD CONSTRAINT `fk_merchandise_sku_catalog_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`sku_catalog` ADD CONSTRAINT `fk_merchandise_sku_catalog_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`merch_order` ADD CONSTRAINT `fk_merchandise_merch_order_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`merch_order` ADD CONSTRAINT `fk_merchandise_merch_order_team_franchise_id` FOREIGN KEY (`team_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`order_line` ADD CONSTRAINT `fk_merchandise_order_line_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`order_line` ADD CONSTRAINT `fk_merchandise_order_line_team_franchise_id` FOREIGN KEY (`team_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`licensing_agreement` ADD CONSTRAINT `fk_merchandise_licensing_agreement_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`licensing_agreement` ADD CONSTRAINT `fk_merchandise_licensing_agreement_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`licensing_agreement` ADD CONSTRAINT `fk_merchandise_licensing_agreement_licensor_franchise_id` FOREIGN KEY (`licensor_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`royalty_payment` ADD CONSTRAINT `fk_merchandise_royalty_payment_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`royalty_payment` ADD CONSTRAINT `fk_merchandise_royalty_payment_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`return_request` ADD CONSTRAINT `fk_merchandise_return_request_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`return_request` ADD CONSTRAINT `fk_merchandise_return_request_team_franchise_id` FOREIGN KEY (`team_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`price_list` ADD CONSTRAINT `fk_merchandise_price_list_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`price_list` ADD CONSTRAINT `fk_merchandise_price_list_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`price_list` ADD CONSTRAINT `fk_merchandise_price_list_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`promotion` ADD CONSTRAINT `fk_merchandise_promotion_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`promotion` ADD CONSTRAINT `fk_merchandise_promotion_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`promotion` ADD CONSTRAINT `fk_merchandise_promotion_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`promotion` ADD CONSTRAINT `fk_merchandise_promotion_promotion_league_id` FOREIGN KEY (`promotion_league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`compliance_check` ADD CONSTRAINT `fk_merchandise_compliance_check_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`compliance_check` ADD CONSTRAINT `fk_merchandise_compliance_check_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`compliance_check` ADD CONSTRAINT `fk_merchandise_compliance_check_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`compliance_check` ADD CONSTRAINT `fk_merchandise_compliance_check_team_franchise_id` FOREIGN KEY (`team_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`wholesale_account` ADD CONSTRAINT `fk_merchandise_wholesale_account_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`wholesale_account` ADD CONSTRAINT `fk_merchandise_wholesale_account_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`memorabilia_item` ADD CONSTRAINT `fk_merchandise_memorabilia_item_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`memorabilia_item` ADD CONSTRAINT `fk_merchandise_memorabilia_item_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`memorabilia_item` ADD CONSTRAINT `fk_merchandise_memorabilia_item_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);

-- ========= merchandise --> legal (16 constraint(s)) =========
-- Requires: merchandise schema, legal schema
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`sku_catalog` ADD CONSTRAINT `fk_merchandise_sku_catalog_ip_portfolio_id` FOREIGN KEY (`ip_portfolio_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`ip_portfolio`(`ip_portfolio_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`retail_location` ADD CONSTRAINT `fk_merchandise_retail_location_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`licensing_agreement` ADD CONSTRAINT `fk_merchandise_licensing_agreement_ip_portfolio_id` FOREIGN KEY (`ip_portfolio_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`ip_portfolio`(`ip_portfolio_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`licensing_agreement` ADD CONSTRAINT `fk_merchandise_licensing_agreement_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`licensing_agreement` ADD CONSTRAINT `fk_merchandise_licensing_agreement_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`licensing_agreement` ADD CONSTRAINT `fk_merchandise_licensing_agreement_insurance_policy_id` FOREIGN KEY (`insurance_policy_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`insurance_policy`(`insurance_policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`licensing_agreement` ADD CONSTRAINT `fk_merchandise_licensing_agreement_trademark_registration_id` FOREIGN KEY (`trademark_registration_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`trademark_registration`(`trademark_registration_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`royalty_payment` ADD CONSTRAINT `fk_merchandise_royalty_payment_ip_portfolio_id` FOREIGN KEY (`ip_portfolio_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`ip_portfolio`(`ip_portfolio_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`royalty_payment` ADD CONSTRAINT `fk_merchandise_royalty_payment_litigation_case_id` FOREIGN KEY (`litigation_case_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`litigation_case`(`litigation_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`royalty_payment` ADD CONSTRAINT `fk_merchandise_royalty_payment_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`compliance_check` ADD CONSTRAINT `fk_merchandise_compliance_check_ip_enforcement_action_id` FOREIGN KEY (`ip_enforcement_action_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`ip_enforcement_action`(`ip_enforcement_action_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`compliance_check` ADD CONSTRAINT `fk_merchandise_compliance_check_ip_portfolio_id` FOREIGN KEY (`ip_portfolio_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`ip_portfolio`(`ip_portfolio_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`compliance_check` ADD CONSTRAINT `fk_merchandise_compliance_check_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`compliance_check` ADD CONSTRAINT `fk_merchandise_compliance_check_trademark_registration_id` FOREIGN KEY (`trademark_registration_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`trademark_registration`(`trademark_registration_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`wholesale_account` ADD CONSTRAINT `fk_merchandise_wholesale_account_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`memorabilia_item` ADD CONSTRAINT `fk_merchandise_memorabilia_item_ip_portfolio_id` FOREIGN KEY (`ip_portfolio_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`ip_portfolio`(`ip_portfolio_id`);

-- ========= merchandise --> partner (12 constraint(s)) =========
-- Requires: merchandise schema, partner schema
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`licensing_agreement` ADD CONSTRAINT `fk_merchandise_licensing_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`royalty_payment` ADD CONSTRAINT `fk_merchandise_royalty_payment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`royalty_payment` ADD CONSTRAINT `fk_merchandise_royalty_payment_vendor_invoice_id` FOREIGN KEY (`vendor_invoice_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_invoice`(`vendor_invoice_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`merchandise_goods_receipt` ADD CONSTRAINT `fk_merchandise_merchandise_goods_receipt_partner_purchase_order_id` FOREIGN KEY (`partner_purchase_order_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`merchandise_goods_receipt` ADD CONSTRAINT `fk_merchandise_merchandise_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`merchandise_goods_receipt` ADD CONSTRAINT `fk_merchandise_merchandise_goods_receipt_vendor_invoice_id` FOREIGN KEY (`vendor_invoice_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_invoice`(`vendor_invoice_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`fulfillment_shipment` ADD CONSTRAINT `fk_merchandise_fulfillment_shipment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`promotion` ADD CONSTRAINT `fk_merchandise_promotion_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`compliance_check` ADD CONSTRAINT `fk_merchandise_compliance_check_vendor_certification_id` FOREIGN KEY (`vendor_certification_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_certification`(`vendor_certification_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`supplier` ADD CONSTRAINT `fk_merchandise_supplier_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`supplier` ADD CONSTRAINT `fk_merchandise_supplier_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`memorabilia_item` ADD CONSTRAINT `fk_merchandise_memorabilia_item_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);

-- ========= merchandise --> platform (8 constraint(s)) =========
-- Requires: merchandise schema, platform schema
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`merch_order` ADD CONSTRAINT `fk_merchandise_merch_order_auth_session_id` FOREIGN KEY (`auth_session_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`auth_session`(`auth_session_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`merch_order` ADD CONSTRAINT `fk_merchandise_merch_order_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`merch_order` ADD CONSTRAINT `fk_merchandise_merch_order_fan_account_id` FOREIGN KEY (`fan_account_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`fan_account`(`fan_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`merch_order` ADD CONSTRAINT `fk_merchandise_merch_order_notification_campaign_id` FOREIGN KEY (`notification_campaign_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`notification_campaign`(`notification_campaign_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`price_list` ADD CONSTRAINT `fk_merchandise_price_list_fan_segment_id` FOREIGN KEY (`fan_segment_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`fan_segment`(`fan_segment_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`price_list` ADD CONSTRAINT `fk_merchandise_price_list_notification_campaign_id` FOREIGN KEY (`notification_campaign_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`notification_campaign`(`notification_campaign_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`promotion` ADD CONSTRAINT `fk_merchandise_promotion_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`promotion` ADD CONSTRAINT `fk_merchandise_promotion_fan_segment_id` FOREIGN KEY (`fan_segment_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`fan_segment`(`fan_segment_id`);

-- ========= merchandise --> security (4 constraint(s)) =========
-- Requires: merchandise schema, security schema
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`retail_location` ADD CONSTRAINT `fk_merchandise_retail_location_access_zone_id` FOREIGN KEY (`access_zone_id`) REFERENCES `sports_entertainment_ecm`.`security`.`access_zone`(`access_zone_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`retail_location` ADD CONSTRAINT `fk_merchandise_retail_location_surveillance_camera_id` FOREIGN KEY (`surveillance_camera_id`) REFERENCES `sports_entertainment_ecm`.`security`.`surveillance_camera`(`surveillance_camera_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`compliance_check` ADD CONSTRAINT `fk_merchandise_compliance_check_confiscation_record_id` FOREIGN KEY (`confiscation_record_id`) REFERENCES `sports_entertainment_ecm`.`security`.`confiscation_record`(`confiscation_record_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`compliance_check` ADD CONSTRAINT `fk_merchandise_compliance_check_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `sports_entertainment_ecm`.`security`.`security_incident`(`security_incident_id`);

-- ========= merchandise --> sponsorship (5 constraint(s)) =========
-- Requires: merchandise schema, sponsorship schema
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`sku_catalog` ADD CONSTRAINT `fk_merchandise_sku_catalog_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`deal`(`deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`licensing_agreement` ADD CONSTRAINT `fk_merchandise_licensing_agreement_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`deal`(`deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`promotion` ADD CONSTRAINT `fk_merchandise_promotion_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`deal`(`deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`promotion` ADD CONSTRAINT `fk_merchandise_promotion_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`sponsor`(`sponsor_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`inventory_transfer` ADD CONSTRAINT `fk_merchandise_inventory_transfer_sponsorship_activation_id` FOREIGN KEY (`sponsorship_activation_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation`(`sponsorship_activation_id`);

-- ========= merchandise --> ticketing (3 constraint(s)) =========
-- Requires: merchandise schema, ticketing schema
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`merch_order` ADD CONSTRAINT `fk_merchandise_merch_order_promo_code_id` FOREIGN KEY (`promo_code_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`promo_code`(`promo_code_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`merch_order` ADD CONSTRAINT `fk_merchandise_merch_order_ticket_order_id` FOREIGN KEY (`ticket_order_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`ticket_order`(`ticket_order_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`promotion` ADD CONSTRAINT `fk_merchandise_promotion_season_ticket_package_id` FOREIGN KEY (`season_ticket_package_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`season_ticket_package`(`season_ticket_package_id`);

-- ========= merchandise --> venue (7 constraint(s)) =========
-- Requires: merchandise schema, venue schema
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`retail_location` ADD CONSTRAINT `fk_merchandise_retail_location_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`facility`(`facility_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`retail_location` ADD CONSTRAINT `fk_merchandise_retail_location_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`merch_order` ADD CONSTRAINT `fk_merchandise_merch_order_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`order_line` ADD CONSTRAINT `fk_merchandise_order_line_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`return_request` ADD CONSTRAINT `fk_merchandise_return_request_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`price_list` ADD CONSTRAINT `fk_merchandise_price_list_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`memorabilia_item` ADD CONSTRAINT `fk_merchandise_memorabilia_item_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`facility`(`facility_id`);

-- ========= merchandise --> workforce (17 constraint(s)) =========
-- Requires: merchandise schema, workforce schema
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`inventory_position` ADD CONSTRAINT `fk_merchandise_inventory_position_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`merch_order` ADD CONSTRAINT `fk_merchandise_merch_order_cashier_employee_id` FOREIGN KEY (`cashier_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`merch_order` ADD CONSTRAINT `fk_merchandise_merch_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`licensing_agreement` ADD CONSTRAINT `fk_merchandise_licensing_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`merchandise_goods_receipt` ADD CONSTRAINT `fk_merchandise_merchandise_goods_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`merchandise_goods_receipt` ADD CONSTRAINT `fk_merchandise_merchandise_goods_receipt_inspector_employee_id` FOREIGN KEY (`inspector_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`fulfillment_shipment` ADD CONSTRAINT `fk_merchandise_fulfillment_shipment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`return_request` ADD CONSTRAINT `fk_merchandise_return_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`price_list` ADD CONSTRAINT `fk_merchandise_price_list_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`promotion` ADD CONSTRAINT `fk_merchandise_promotion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`compliance_check` ADD CONSTRAINT `fk_merchandise_compliance_check_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`compliance_check` ADD CONSTRAINT `fk_merchandise_compliance_check_inspector_employee_id` FOREIGN KEY (`inspector_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`supplier` ADD CONSTRAINT `fk_merchandise_supplier_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`inventory_transfer` ADD CONSTRAINT `fk_merchandise_inventory_transfer_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`inventory_transfer` ADD CONSTRAINT `fk_merchandise_inventory_transfer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`inventory_transfer` ADD CONSTRAINT `fk_merchandise_inventory_transfer_primary_inventory_employee_id` FOREIGN KEY (`primary_inventory_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`merchandise`.`wholesale_account` ADD CONSTRAINT `fk_merchandise_wholesale_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= partner --> analytics (8 constraint(s)) =========
-- Requires: partner schema, analytics schema
ALTER TABLE `sports_entertainment_ecm`.`partner`.`sla_definition` ADD CONSTRAINT `fk_partner_sla_definition_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`sla_measurement` ADD CONSTRAINT `fk_partner_sla_measurement_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`sla_measurement` ADD CONSTRAINT `fk_partner_sla_measurement_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`rfp` ADD CONSTRAINT `fk_partner_rfp_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_scorecard` ADD CONSTRAINT `fk_partner_vendor_scorecard_dashboard_definition_id` FOREIGN KEY (`dashboard_definition_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`dashboard_definition`(`dashboard_definition_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_scorecard` ADD CONSTRAINT `fk_partner_vendor_scorecard_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_scorecard` ADD CONSTRAINT `fk_partner_vendor_scorecard_pipeline_definition_id` FOREIGN KEY (`pipeline_definition_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`pipeline_definition`(`pipeline_definition_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_incident` ADD CONSTRAINT `fk_partner_vendor_incident_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);

-- ========= partner --> athlete (1 constraint(s)) =========
-- Requires: partner schema, athlete schema
ALTER TABLE `sports_entertainment_ecm`.`partner`.`sla_measurement` ADD CONSTRAINT `fk_partner_sla_measurement_athlete_contract_id` FOREIGN KEY (`athlete_contract_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_contract`(`athlete_contract_id`);

-- ========= partner --> broadcast (4 constraint(s)) =========
-- Requires: partner schema, broadcast schema
ALTER TABLE `sports_entertainment_ecm`.`partner`.`sla_measurement` ADD CONSTRAINT `fk_partner_sla_measurement_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`sla_measurement` ADD CONSTRAINT `fk_partner_sla_measurement_live_feed_id` FOREIGN KEY (`live_feed_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`live_feed`(`live_feed_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`service_order` ADD CONSTRAINT `fk_partner_service_order_production_id` FOREIGN KEY (`production_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`production`(`production_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_incident` ADD CONSTRAINT `fk_partner_vendor_incident_live_feed_id` FOREIGN KEY (`live_feed_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`live_feed`(`live_feed_id`);

-- ========= partner --> compliance (8 constraint(s)) =========
-- Requires: partner schema, compliance schema
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_contract` ADD CONSTRAINT `fk_partner_vendor_contract_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`sla_definition` ADD CONSTRAINT `fk_partner_sla_definition_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`purchase_order` ADD CONSTRAINT `fk_partner_purchase_order_license_permit_id` FOREIGN KEY (`license_permit_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`license_permit`(`license_permit_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`rfp` ADD CONSTRAINT `fk_partner_rfp_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_scorecard` ADD CONSTRAINT `fk_partner_vendor_scorecard_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_incident` ADD CONSTRAINT `fk_partner_vendor_incident_incident_report_id` FOREIGN KEY (`incident_report_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`incident_report`(`incident_report_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_certification` ADD CONSTRAINT `fk_partner_vendor_certification_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_certification` ADD CONSTRAINT `fk_partner_vendor_certification_governing_body_id` FOREIGN KEY (`governing_body_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`governing_body`(`governing_body_id`);

-- ========= partner --> event (13 constraint(s)) =========
-- Requires: partner schema, event schema
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_contract` ADD CONSTRAINT `fk_partner_vendor_contract_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `sports_entertainment_ecm`.`event`.`tournament`(`tournament_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`sla_measurement` ADD CONSTRAINT `fk_partner_sla_measurement_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`sla_measurement` ADD CONSTRAINT `fk_partner_sla_measurement_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`purchase_order` ADD CONSTRAINT `fk_partner_purchase_order_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`partner_goods_receipt` ADD CONSTRAINT `fk_partner_partner_goods_receipt_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_invoice` ADD CONSTRAINT `fk_partner_vendor_invoice_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`rfp` ADD CONSTRAINT `fk_partner_rfp_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `sports_entertainment_ecm`.`event`.`tournament`(`tournament_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`service_order` ADD CONSTRAINT `fk_partner_service_order_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`service_order` ADD CONSTRAINT `fk_partner_service_order_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`service_order` ADD CONSTRAINT `fk_partner_service_order_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `sports_entertainment_ecm`.`event`.`tournament`(`tournament_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_incident` ADD CONSTRAINT `fk_partner_vendor_incident_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_incident` ADD CONSTRAINT `fk_partner_vendor_incident_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `sports_entertainment_ecm`.`event`.`tournament`(`tournament_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_activation` ADD CONSTRAINT `fk_partner_vendor_activation_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);

-- ========= partner --> finance (23 constraint(s)) =========
-- Requires: partner schema, finance schema
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_contract` ADD CONSTRAINT `fk_partner_vendor_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_contract` ADD CONSTRAINT `fk_partner_vendor_contract_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_contract` ADD CONSTRAINT `fk_partner_vendor_contract_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_contract` ADD CONSTRAINT `fk_partner_vendor_contract_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`purchase_order` ADD CONSTRAINT `fk_partner_purchase_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`purchase_order` ADD CONSTRAINT `fk_partner_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`purchase_order` ADD CONSTRAINT `fk_partner_purchase_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`partner_goods_receipt` ADD CONSTRAINT `fk_partner_partner_goods_receipt_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`partner_goods_receipt` ADD CONSTRAINT `fk_partner_partner_goods_receipt_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`partner_goods_receipt` ADD CONSTRAINT `fk_partner_partner_goods_receipt_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_invoice` ADD CONSTRAINT `fk_partner_vendor_invoice_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_invoice` ADD CONSTRAINT `fk_partner_vendor_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_invoice` ADD CONSTRAINT `fk_partner_vendor_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_invoice` ADD CONSTRAINT `fk_partner_vendor_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_invoice` ADD CONSTRAINT `fk_partner_vendor_invoice_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_payment` ADD CONSTRAINT `fk_partner_vendor_payment_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_payment` ADD CONSTRAINT `fk_partner_vendor_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_payment` ADD CONSTRAINT `fk_partner_vendor_payment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_payment` ADD CONSTRAINT `fk_partner_vendor_payment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_payment` ADD CONSTRAINT `fk_partner_vendor_payment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`rfp` ADD CONSTRAINT `fk_partner_rfp_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`rfp` ADD CONSTRAINT `fk_partner_rfp_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`service_order` ADD CONSTRAINT `fk_partner_service_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= partner --> gaming (5 constraint(s)) =========
-- Requires: partner schema, gaming schema
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_contract` ADD CONSTRAINT `fk_partner_vendor_contract_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`rfp` ADD CONSTRAINT `fk_partner_rfp_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_incident` ADD CONSTRAINT `fk_partner_vendor_incident_integrity_alert_id` FOREIGN KEY (`integrity_alert_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`integrity_alert`(`integrity_alert_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_incident` ADD CONSTRAINT `fk_partner_vendor_incident_regulatory_report_id` FOREIGN KEY (`regulatory_report_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`regulatory_report`(`regulatory_report_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_certification` ADD CONSTRAINT `fk_partner_vendor_certification_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`jurisdiction`(`jurisdiction_id`);

-- ========= partner --> league (15 constraint(s)) =========
-- Requires: partner schema, league schema
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_contract` ADD CONSTRAINT `fk_partner_vendor_contract_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_contract` ADD CONSTRAINT `fk_partner_vendor_contract_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_contract` ADD CONSTRAINT `fk_partner_vendor_contract_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`sla_definition` ADD CONSTRAINT `fk_partner_sla_definition_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`sla_measurement` ADD CONSTRAINT `fk_partner_sla_measurement_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`purchase_order` ADD CONSTRAINT `fk_partner_purchase_order_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`purchase_order` ADD CONSTRAINT `fk_partner_purchase_order_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`purchase_order` ADD CONSTRAINT `fk_partner_purchase_order_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`rfp` ADD CONSTRAINT `fk_partner_rfp_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`rfp` ADD CONSTRAINT `fk_partner_rfp_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`rfp` ADD CONSTRAINT `fk_partner_rfp_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_scorecard` ADD CONSTRAINT `fk_partner_vendor_scorecard_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`service_order` ADD CONSTRAINT `fk_partner_service_order_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_incident` ADD CONSTRAINT `fk_partner_vendor_incident_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_incident` ADD CONSTRAINT `fk_partner_vendor_incident_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);

-- ========= partner --> legal (10 constraint(s)) =========
-- Requires: partner schema, legal schema
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor` ADD CONSTRAINT `fk_partner_vendor_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_contract` ADD CONSTRAINT `fk_partner_vendor_contract_board_resolution_id` FOREIGN KEY (`board_resolution_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`board_resolution`(`board_resolution_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_contract` ADD CONSTRAINT `fk_partner_vendor_contract_contract_template_id` FOREIGN KEY (`contract_template_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`contract_template`(`contract_template_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_contract` ADD CONSTRAINT `fk_partner_vendor_contract_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_contract` ADD CONSTRAINT `fk_partner_vendor_contract_nda_id` FOREIGN KEY (`nda_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`nda`(`nda_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`rfp` ADD CONSTRAINT `fk_partner_rfp_nda_id` FOREIGN KEY (`nda_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`nda`(`nda_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_incident` ADD CONSTRAINT `fk_partner_vendor_incident_insurance_claim_id` FOREIGN KEY (`insurance_claim_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`insurance_claim`(`insurance_claim_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_incident` ADD CONSTRAINT `fk_partner_vendor_incident_litigation_case_id` FOREIGN KEY (`litigation_case_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`litigation_case`(`litigation_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_incident` ADD CONSTRAINT `fk_partner_vendor_incident_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`ip_license_grant` ADD CONSTRAINT `fk_partner_ip_license_grant_ip_portfolio_id` FOREIGN KEY (`ip_portfolio_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`ip_portfolio`(`ip_portfolio_id`);

-- ========= partner --> security (1 constraint(s)) =========
-- Requires: partner schema, security schema
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_incident` ADD CONSTRAINT `fk_partner_vendor_incident_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `sports_entertainment_ecm`.`security`.`security_incident`(`security_incident_id`);

-- ========= partner --> sponsorship (1 constraint(s)) =========
-- Requires: partner schema, sponsorship schema
ALTER TABLE `sports_entertainment_ecm`.`partner`.`service_order` ADD CONSTRAINT `fk_partner_service_order_sponsorship_activation_id` FOREIGN KEY (`sponsorship_activation_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation`(`sponsorship_activation_id`);

-- ========= partner --> venue (6 constraint(s)) =========
-- Requires: partner schema, venue schema
ALTER TABLE `sports_entertainment_ecm`.`partner`.`sla_measurement` ADD CONSTRAINT `fk_partner_sla_measurement_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`purchase_order` ADD CONSTRAINT `fk_partner_purchase_order_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`partner_goods_receipt` ADD CONSTRAINT `fk_partner_partner_goods_receipt_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`facility`(`facility_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`partner_goods_receipt` ADD CONSTRAINT `fk_partner_partner_goods_receipt_receiving_location_facility_id` FOREIGN KEY (`receiving_location_facility_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`facility`(`facility_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`service_order` ADD CONSTRAINT `fk_partner_service_order_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_incident` ADD CONSTRAINT `fk_partner_vendor_incident_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);

-- ========= partner --> workforce (15 constraint(s)) =========
-- Requires: partner schema, workforce schema
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_contact` ADD CONSTRAINT `fk_partner_vendor_contact_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_contract` ADD CONSTRAINT `fk_partner_vendor_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`sla_measurement` ADD CONSTRAINT `fk_partner_sla_measurement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`purchase_order` ADD CONSTRAINT `fk_partner_purchase_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`partner_goods_receipt` ADD CONSTRAINT `fk_partner_partner_goods_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_invoice` ADD CONSTRAINT `fk_partner_vendor_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`rfp` ADD CONSTRAINT `fk_partner_rfp_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`rfp_response` ADD CONSTRAINT `fk_partner_rfp_response_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`rfp_response` ADD CONSTRAINT `fk_partner_rfp_response_evaluator_employee_id` FOREIGN KEY (`evaluator_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_scorecard` ADD CONSTRAINT `fk_partner_vendor_scorecard_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_scorecard` ADD CONSTRAINT `fk_partner_vendor_scorecard_evaluator_employee_id` FOREIGN KEY (`evaluator_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`service_order` ADD CONSTRAINT `fk_partner_service_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_incident` ADD CONSTRAINT `fk_partner_vendor_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_certification` ADD CONSTRAINT `fk_partner_vendor_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`partner`.`vendor_assignment` ADD CONSTRAINT `fk_partner_vendor_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= platform --> analytics (8 constraint(s)) =========
-- Requires: platform schema, analytics schema
ALTER TABLE `sports_entertainment_ecm`.`platform`.`personalization_profile` ADD CONSTRAINT `fk_platform_personalization_profile_fan_behavior_model_id` FOREIGN KEY (`fan_behavior_model_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`fan_behavior_model`(`fan_behavior_model_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`fan_segment` ADD CONSTRAINT `fk_platform_fan_segment_fan_behavior_model_id` FOREIGN KEY (`fan_behavior_model_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`fan_behavior_model`(`fan_behavior_model_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`digital_subscription` ADD CONSTRAINT `fk_platform_digital_subscription_fan_behavior_model_id` FOREIGN KEY (`fan_behavior_model_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`fan_behavior_model`(`fan_behavior_model_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`notification_campaign` ADD CONSTRAINT `fk_platform_notification_campaign_attribution_model_id` FOREIGN KEY (`attribution_model_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`attribution_model`(`attribution_model_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`notification_campaign` ADD CONSTRAINT `fk_platform_notification_campaign_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`ab_test` ADD CONSTRAINT `fk_platform_ab_test_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`experiment`(`experiment_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`ab_test` ADD CONSTRAINT `fk_platform_ab_test_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`content_recommendation` ADD CONSTRAINT `fk_platform_content_recommendation_fan_behavior_model_id` FOREIGN KEY (`fan_behavior_model_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`fan_behavior_model`(`fan_behavior_model_id`);

-- ========= platform --> athlete (9 constraint(s)) =========
-- Requires: platform schema, athlete schema
ALTER TABLE `sports_entertainment_ecm`.`platform`.`fan_interaction` ADD CONSTRAINT `fk_platform_fan_interaction_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`fan_interaction` ADD CONSTRAINT `fk_platform_fan_interaction_nil_agreement_id` FOREIGN KEY (`nil_agreement_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`nil_agreement`(`nil_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`notification_campaign` ADD CONSTRAINT `fk_platform_notification_campaign_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`content_recommendation` ADD CONSTRAINT `fk_platform_content_recommendation_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`push_notification` ADD CONSTRAINT `fk_platform_push_notification_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`push_notification` ADD CONSTRAINT `fk_platform_push_notification_award_honor_id` FOREIGN KEY (`award_honor_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`award_honor`(`award_honor_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`push_notification` ADD CONSTRAINT `fk_platform_push_notification_draft_selection_id` FOREIGN KEY (`draft_selection_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`draft_selection`(`draft_selection_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`push_notification` ADD CONSTRAINT `fk_platform_push_notification_injury_record_id` FOREIGN KEY (`injury_record_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`injury_record`(`injury_record_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`push_notification` ADD CONSTRAINT `fk_platform_push_notification_suspension_record_id` FOREIGN KEY (`suspension_record_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`suspension_record`(`suspension_record_id`);

-- ========= platform --> broadcast (13 constraint(s)) =========
-- Requires: platform schema, broadcast schema
ALTER TABLE `sports_entertainment_ecm`.`platform`.`digital_touchpoint` ADD CONSTRAINT `fk_platform_digital_touchpoint_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`channel`(`channel_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`digital_touchpoint` ADD CONSTRAINT `fk_platform_digital_touchpoint_broadcast_drm_policy_id` FOREIGN KEY (`broadcast_drm_policy_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_drm_policy`(`broadcast_drm_policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`feature_entitlement` ADD CONSTRAINT `fk_platform_feature_entitlement_broadcast_rights_window_id` FOREIGN KEY (`broadcast_rights_window_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_rights_window`(`broadcast_rights_window_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`feature_entitlement` ADD CONSTRAINT `fk_platform_feature_entitlement_ppv_event_ppv_package_id` FOREIGN KEY (`ppv_event_ppv_package_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`ppv_package`(`ppv_package_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`feature_entitlement` ADD CONSTRAINT `fk_platform_feature_entitlement_ppv_package_id` FOREIGN KEY (`ppv_package_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`ppv_package`(`ppv_package_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`sla_incident` ADD CONSTRAINT `fk_platform_sla_incident_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`sla_incident` ADD CONSTRAINT `fk_platform_sla_incident_live_feed_id` FOREIGN KEY (`live_feed_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`live_feed`(`live_feed_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`digital_subscription` ADD CONSTRAINT `fk_platform_digital_subscription_broadcast_rights_window_id` FOREIGN KEY (`broadcast_rights_window_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_rights_window`(`broadcast_rights_window_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`fan_interaction` ADD CONSTRAINT `fk_platform_fan_interaction_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`fan_interaction` ADD CONSTRAINT `fk_platform_fan_interaction_live_feed_id` FOREIGN KEY (`live_feed_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`live_feed`(`live_feed_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`notification_campaign` ADD CONSTRAINT `fk_platform_notification_campaign_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`content_recommendation` ADD CONSTRAINT `fk_platform_content_recommendation_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`push_notification` ADD CONSTRAINT `fk_platform_push_notification_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);

-- ========= platform --> compliance (11 constraint(s)) =========
-- Requires: platform schema, compliance schema
ALTER TABLE `sports_entertainment_ecm`.`platform`.`digital_touchpoint` ADD CONSTRAINT `fk_platform_digital_touchpoint_data_processing_record_id` FOREIGN KEY (`data_processing_record_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`data_processing_record`(`data_processing_record_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`auth_session` ADD CONSTRAINT `fk_platform_auth_session_privacy_request_id` FOREIGN KEY (`privacy_request_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`privacy_request`(`privacy_request_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`sla_incident` ADD CONSTRAINT `fk_platform_sla_incident_incident_report_id` FOREIGN KEY (`incident_report_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`incident_report`(`incident_report_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`api_integration` ADD CONSTRAINT `fk_platform_api_integration_data_processing_record_id` FOREIGN KEY (`data_processing_record_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`data_processing_record`(`data_processing_record_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`personalization_profile` ADD CONSTRAINT `fk_platform_personalization_profile_data_processing_record_id` FOREIGN KEY (`data_processing_record_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`data_processing_record`(`data_processing_record_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`fan_segment` ADD CONSTRAINT `fk_platform_fan_segment_data_processing_record_id` FOREIGN KEY (`data_processing_record_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`data_processing_record`(`data_processing_record_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`digital_subscription` ADD CONSTRAINT `fk_platform_digital_subscription_data_processing_record_id` FOREIGN KEY (`data_processing_record_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`data_processing_record`(`data_processing_record_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`notification_campaign` ADD CONSTRAINT `fk_platform_notification_campaign_data_processing_record_id` FOREIGN KEY (`data_processing_record_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`data_processing_record`(`data_processing_record_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`ab_test` ADD CONSTRAINT `fk_platform_ab_test_data_processing_record_id` FOREIGN KEY (`data_processing_record_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`data_processing_record`(`data_processing_record_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`ab_test` ADD CONSTRAINT `fk_platform_ab_test_pia_assessment_id` FOREIGN KEY (`pia_assessment_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`pia_assessment`(`pia_assessment_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`content_recommendation` ADD CONSTRAINT `fk_platform_content_recommendation_data_processing_record_id` FOREIGN KEY (`data_processing_record_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`data_processing_record`(`data_processing_record_id`);

-- ========= platform --> content (6 constraint(s)) =========
-- Requires: platform schema, content schema
ALTER TABLE `sports_entertainment_ecm`.`platform`.`auth_session` ADD CONSTRAINT `fk_platform_auth_session_platform_channel_id` FOREIGN KEY (`platform_channel_id`) REFERENCES `sports_entertainment_ecm`.`content`.`platform_channel`(`platform_channel_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`feature_entitlement` ADD CONSTRAINT `fk_platform_feature_entitlement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`digital_subscription` ADD CONSTRAINT `fk_platform_digital_subscription_content_drm_policy_id` FOREIGN KEY (`content_drm_policy_id`) REFERENCES `sports_entertainment_ecm`.`content`.`content_drm_policy`(`content_drm_policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`fan_interaction` ADD CONSTRAINT `fk_platform_fan_interaction_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`content_recommendation` ADD CONSTRAINT `fk_platform_content_recommendation_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`push_notification` ADD CONSTRAINT `fk_platform_push_notification_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);

-- ========= platform --> event (12 constraint(s)) =========
-- Requires: platform schema, event schema
ALTER TABLE `sports_entertainment_ecm`.`platform`.`sla_incident` ADD CONSTRAINT `fk_platform_sla_incident_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`sla_incident` ADD CONSTRAINT `fk_platform_sla_incident_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`fan_interaction` ADD CONSTRAINT `fk_platform_fan_interaction_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`fan_interaction` ADD CONSTRAINT `fk_platform_fan_interaction_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`notification_campaign` ADD CONSTRAINT `fk_platform_notification_campaign_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`content_recommendation` ADD CONSTRAINT `fk_platform_content_recommendation_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`content_recommendation` ADD CONSTRAINT `fk_platform_content_recommendation_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`push_notification` ADD CONSTRAINT `fk_platform_push_notification_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`push_notification` ADD CONSTRAINT `fk_platform_push_notification_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`search_query` ADD CONSTRAINT `fk_platform_search_query_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`search_query` ADD CONSTRAINT `fk_platform_search_query_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`poll_question` ADD CONSTRAINT `fk_platform_poll_question_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);

-- ========= platform --> fan (15 constraint(s)) =========
-- Requires: platform schema, fan schema
ALTER TABLE `sports_entertainment_ecm`.`platform`.`auth_session` ADD CONSTRAINT `fk_platform_auth_session_fan_fan_profile_id` FOREIGN KEY (`fan_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`auth_session` ADD CONSTRAINT `fk_platform_auth_session_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`feature_entitlement` ADD CONSTRAINT `fk_platform_feature_entitlement_loyalty_enrollment_id` FOREIGN KEY (`loyalty_enrollment_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`loyalty_enrollment`(`loyalty_enrollment_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`feature_entitlement` ADD CONSTRAINT `fk_platform_feature_entitlement_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`membership`(`membership_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`personalization_profile` ADD CONSTRAINT `fk_platform_personalization_profile_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`digital_subscription` ADD CONSTRAINT `fk_platform_digital_subscription_fan_fan_profile_id` FOREIGN KEY (`fan_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`digital_subscription` ADD CONSTRAINT `fk_platform_digital_subscription_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`payment_method`(`payment_method_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`digital_subscription` ADD CONSTRAINT `fk_platform_digital_subscription_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`digital_subscription` ADD CONSTRAINT `fk_platform_digital_subscription_loyalty_enrollment_id` FOREIGN KEY (`loyalty_enrollment_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`loyalty_enrollment`(`loyalty_enrollment_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`fan_interaction` ADD CONSTRAINT `fk_platform_fan_interaction_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`fan_interaction` ADD CONSTRAINT `fk_platform_fan_interaction_personalization_rule_id` FOREIGN KEY (`personalization_rule_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`personalization_rule`(`personalization_rule_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`notification_campaign` ADD CONSTRAINT `fk_platform_notification_campaign_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`device_registration` ADD CONSTRAINT `fk_platform_device_registration_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`ab_test` ADD CONSTRAINT `fk_platform_ab_test_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`search_query` ADD CONSTRAINT `fk_platform_search_query_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);

-- ========= platform --> gaming (9 constraint(s)) =========
-- Requires: platform schema, gaming schema
ALTER TABLE `sports_entertainment_ecm`.`platform`.`digital_touchpoint` ADD CONSTRAINT `fk_platform_digital_touchpoint_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`feature_entitlement` ADD CONSTRAINT `fk_platform_feature_entitlement_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`personalization_profile` ADD CONSTRAINT `fk_platform_personalization_profile_bettor_account_id` FOREIGN KEY (`bettor_account_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`bettor_account`(`bettor_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`fan_interaction` ADD CONSTRAINT `fk_platform_fan_interaction_session_id` FOREIGN KEY (`session_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`session`(`session_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`fan_interaction` ADD CONSTRAINT `fk_platform_fan_interaction_wager_id` FOREIGN KEY (`wager_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`wager`(`wager_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`notification_campaign` ADD CONSTRAINT `fk_platform_notification_campaign_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`push_notification` ADD CONSTRAINT `fk_platform_push_notification_bonus_offer_id` FOREIGN KEY (`bonus_offer_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`bonus_offer`(`bonus_offer_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`push_notification` ADD CONSTRAINT `fk_platform_push_notification_wager_id` FOREIGN KEY (`wager_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`wager`(`wager_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`app_release` ADD CONSTRAINT `fk_platform_app_release_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`jurisdiction`(`jurisdiction_id`);

-- ========= platform --> league (12 constraint(s)) =========
-- Requires: platform schema, league schema
ALTER TABLE `sports_entertainment_ecm`.`platform`.`fan_account` ADD CONSTRAINT `fk_platform_fan_account_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`feature_entitlement` ADD CONSTRAINT `fk_platform_feature_entitlement_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`personalization_profile` ADD CONSTRAINT `fk_platform_personalization_profile_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`personalization_profile` ADD CONSTRAINT `fk_platform_personalization_profile_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`personalization_profile` ADD CONSTRAINT `fk_platform_personalization_profile_preferred_team_franchise_id` FOREIGN KEY (`preferred_team_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`fan_segment` ADD CONSTRAINT `fk_platform_fan_segment_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`digital_subscription` ADD CONSTRAINT `fk_platform_digital_subscription_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`digital_subscription` ADD CONSTRAINT `fk_platform_digital_subscription_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`notification_campaign` ADD CONSTRAINT `fk_platform_notification_campaign_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`notification_campaign` ADD CONSTRAINT `fk_platform_notification_campaign_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`notification_campaign` ADD CONSTRAINT `fk_platform_notification_campaign_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`content_recommendation` ADD CONSTRAINT `fk_platform_content_recommendation_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);

-- ========= platform --> legal (11 constraint(s)) =========
-- Requires: platform schema, legal schema
ALTER TABLE `sports_entertainment_ecm`.`platform`.`digital_touchpoint` ADD CONSTRAINT `fk_platform_digital_touchpoint_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`digital_touchpoint` ADD CONSTRAINT `fk_platform_digital_touchpoint_ip_portfolio_id` FOREIGN KEY (`ip_portfolio_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`ip_portfolio`(`ip_portfolio_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`digital_touchpoint` ADD CONSTRAINT `fk_platform_digital_touchpoint_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`fan_account` ADD CONSTRAINT `fk_platform_fan_account_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`feature_entitlement` ADD CONSTRAINT `fk_platform_feature_entitlement_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`sla_incident` ADD CONSTRAINT `fk_platform_sla_incident_litigation_case_id` FOREIGN KEY (`litigation_case_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`litigation_case`(`litigation_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`api_integration` ADD CONSTRAINT `fk_platform_api_integration_nda_id` FOREIGN KEY (`nda_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`nda`(`nda_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`digital_subscription` ADD CONSTRAINT `fk_platform_digital_subscription_contract_template_id` FOREIGN KEY (`contract_template_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`contract_template`(`contract_template_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`notification_campaign` ADD CONSTRAINT `fk_platform_notification_campaign_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`ab_test` ADD CONSTRAINT `fk_platform_ab_test_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`app_release` ADD CONSTRAINT `fk_platform_app_release_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);

-- ========= platform --> partner (15 constraint(s)) =========
-- Requires: platform schema, partner schema
ALTER TABLE `sports_entertainment_ecm`.`platform`.`digital_touchpoint` ADD CONSTRAINT `fk_platform_digital_touchpoint_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`digital_touchpoint` ADD CONSTRAINT `fk_platform_digital_touchpoint_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`feature_entitlement` ADD CONSTRAINT `fk_platform_feature_entitlement_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`sla_policy` ADD CONSTRAINT `fk_platform_sla_policy_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`sla_incident` ADD CONSTRAINT `fk_platform_sla_incident_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`sla_incident` ADD CONSTRAINT `fk_platform_sla_incident_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`sla_incident` ADD CONSTRAINT `fk_platform_sla_incident_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`api_integration` ADD CONSTRAINT `fk_platform_api_integration_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`api_integration` ADD CONSTRAINT `fk_platform_api_integration_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`api_integration` ADD CONSTRAINT `fk_platform_api_integration_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`digital_subscription` ADD CONSTRAINT `fk_platform_digital_subscription_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`digital_subscription` ADD CONSTRAINT `fk_platform_digital_subscription_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`notification_campaign` ADD CONSTRAINT `fk_platform_notification_campaign_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`push_notification` ADD CONSTRAINT `fk_platform_push_notification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`app_release` ADD CONSTRAINT `fk_platform_app_release_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);

-- ========= platform --> security (6 constraint(s)) =========
-- Requires: platform schema, security schema
ALTER TABLE `sports_entertainment_ecm`.`platform`.`feature_entitlement` ADD CONSTRAINT `fk_platform_feature_entitlement_venue_ban_id` FOREIGN KEY (`venue_ban_id`) REFERENCES `sports_entertainment_ecm`.`security`.`venue_ban`(`venue_ban_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`sla_incident` ADD CONSTRAINT `fk_platform_sla_incident_emergency_activation_id` FOREIGN KEY (`emergency_activation_id`) REFERENCES `sports_entertainment_ecm`.`security`.`emergency_activation`(`emergency_activation_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`sla_incident` ADD CONSTRAINT `fk_platform_sla_incident_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `sports_entertainment_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`notification_campaign` ADD CONSTRAINT `fk_platform_notification_campaign_crowd_management_plan_id` FOREIGN KEY (`crowd_management_plan_id`) REFERENCES `sports_entertainment_ecm`.`security`.`crowd_management_plan`(`crowd_management_plan_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`notification_campaign` ADD CONSTRAINT `fk_platform_notification_campaign_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `sports_entertainment_ecm`.`security`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`push_notification` ADD CONSTRAINT `fk_platform_push_notification_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `sports_entertainment_ecm`.`security`.`security_incident`(`security_incident_id`);

-- ========= platform --> sponsorship (2 constraint(s)) =========
-- Requires: platform schema, sponsorship schema
ALTER TABLE `sports_entertainment_ecm`.`platform`.`feature_entitlement` ADD CONSTRAINT `fk_platform_feature_entitlement_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`sponsor`(`sponsor_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`sla_incident` ADD CONSTRAINT `fk_platform_sla_incident_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`sponsor`(`sponsor_id`);

-- ========= platform --> venue (2 constraint(s)) =========
-- Requires: platform schema, venue schema
ALTER TABLE `sports_entertainment_ecm`.`platform`.`digital_touchpoint` ADD CONSTRAINT `fk_platform_digital_touchpoint_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`facility`(`facility_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`api_integration` ADD CONSTRAINT `fk_platform_api_integration_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`facility`(`facility_id`);

-- ========= platform --> workforce (17 constraint(s)) =========
-- Requires: platform schema, workforce schema
ALTER TABLE `sports_entertainment_ecm`.`platform`.`digital_touchpoint` ADD CONSTRAINT `fk_platform_digital_touchpoint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`sla_policy` ADD CONSTRAINT `fk_platform_sla_policy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`sla_incident` ADD CONSTRAINT `fk_platform_sla_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`api_integration` ADD CONSTRAINT `fk_platform_api_integration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`fan_segment` ADD CONSTRAINT `fk_platform_fan_segment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`fan_segment` ADD CONSTRAINT `fk_platform_fan_segment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`notification_campaign` ADD CONSTRAINT `fk_platform_notification_campaign_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`notification_campaign` ADD CONSTRAINT `fk_platform_notification_campaign_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`notification_campaign` ADD CONSTRAINT `fk_platform_notification_campaign_primary_notification_employee_id` FOREIGN KEY (`primary_notification_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`ab_test` ADD CONSTRAINT `fk_platform_ab_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`ab_test` ADD CONSTRAINT `fk_platform_ab_test_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`app_release` ADD CONSTRAINT `fk_platform_app_release_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`poll_question` ADD CONSTRAINT `fk_platform_poll_question_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`poll_question` ADD CONSTRAINT `fk_platform_poll_question_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`change_request` ADD CONSTRAINT `fk_platform_change_request_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`change_request` ADD CONSTRAINT `fk_platform_change_request_assigned_to_user_employee_id` FOREIGN KEY (`assigned_to_user_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`platform`.`change_request` ADD CONSTRAINT `fk_platform_change_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= security --> analytics (4 constraint(s)) =========
-- Requires: security schema, analytics schema
ALTER TABLE `sports_entertainment_ecm`.`security`.`crowd_management_plan` ADD CONSTRAINT `fk_security_crowd_management_plan_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`law_enforcement_deployment` ADD CONSTRAINT `fk_security_law_enforcement_deployment_forecast_output_id` FOREIGN KEY (`forecast_output_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`forecast_output`(`forecast_output_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`after_action_report` ADD CONSTRAINT `fk_security_after_action_report_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`staffing_plan` ADD CONSTRAINT `fk_security_staffing_plan_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);

-- ========= security --> athlete (4 constraint(s)) =========
-- Requires: security schema, athlete schema
ALTER TABLE `sports_entertainment_ecm`.`security`.`credential` ADD CONSTRAINT `fk_security_credential_eligibility_status_id` FOREIGN KEY (`eligibility_status_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`eligibility_status`(`eligibility_status_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`venue_ban` ADD CONSTRAINT `fk_security_venue_ban_suspension_record_id` FOREIGN KEY (`suspension_record_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`suspension_record`(`suspension_record_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`threat_assessment` ADD CONSTRAINT `fk_security_threat_assessment_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`threat_assessment` ADD CONSTRAINT `fk_security_threat_assessment_suspension_record_id` FOREIGN KEY (`suspension_record_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`suspension_record`(`suspension_record_id`);

-- ========= security --> broadcast (8 constraint(s)) =========
-- Requires: security schema, broadcast schema
ALTER TABLE `sports_entertainment_ecm`.`security`.`credential` ADD CONSTRAINT `fk_security_credential_production_id` FOREIGN KEY (`production_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`production`(`production_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`emergency_activation` ADD CONSTRAINT `fk_security_emergency_activation_production_id` FOREIGN KEY (`production_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`production`(`production_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`emergency_activation` ADD CONSTRAINT `fk_security_emergency_activation_live_feed_id` FOREIGN KEY (`live_feed_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`live_feed`(`live_feed_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`law_enforcement_deployment` ADD CONSTRAINT `fk_security_law_enforcement_deployment_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`threat_assessment` ADD CONSTRAINT `fk_security_threat_assessment_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`briefing` ADD CONSTRAINT `fk_security_briefing_production_id` FOREIGN KEY (`production_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`production`(`production_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`after_action_report` ADD CONSTRAINT `fk_security_after_action_report_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`staffing_plan` ADD CONSTRAINT `fk_security_staffing_plan_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);

-- ========= security --> compliance (15 constraint(s)) =========
-- Requires: security schema, compliance schema
ALTER TABLE `sports_entertainment_ecm`.`security`.`screening_event` ADD CONSTRAINT `fk_security_screening_event_ada_accommodation_id` FOREIGN KEY (`ada_accommodation_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`ada_accommodation`(`ada_accommodation_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`post_assignment` ADD CONSTRAINT `fk_security_post_assignment_incident_report_id` FOREIGN KEY (`incident_report_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`incident_report`(`incident_report_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`venue_ban` ADD CONSTRAINT `fk_security_venue_ban_doping_violation_id` FOREIGN KEY (`doping_violation_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`doping_violation`(`doping_violation_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`venue_ban` ADD CONSTRAINT `fk_security_venue_ban_sanction_id` FOREIGN KEY (`sanction_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`sanction`(`sanction_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`crowd_management_plan` ADD CONSTRAINT `fk_security_crowd_management_plan_governing_body_id` FOREIGN KEY (`governing_body_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`governing_body`(`governing_body_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`surveillance_camera` ADD CONSTRAINT `fk_security_surveillance_camera_data_processing_record_id` FOREIGN KEY (`data_processing_record_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`data_processing_record`(`data_processing_record_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`surveillance_camera` ADD CONSTRAINT `fk_security_surveillance_camera_pia_assessment_id` FOREIGN KEY (`pia_assessment_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`pia_assessment`(`pia_assessment_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`surveillance_footage_request` ADD CONSTRAINT `fk_security_surveillance_footage_request_breach_notification_id` FOREIGN KEY (`breach_notification_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`breach_notification`(`breach_notification_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`surveillance_footage_request` ADD CONSTRAINT `fk_security_surveillance_footage_request_privacy_request_id` FOREIGN KEY (`privacy_request_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`privacy_request`(`privacy_request_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`emergency_response_plan` ADD CONSTRAINT `fk_security_emergency_response_plan_governing_body_id` FOREIGN KEY (`governing_body_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`governing_body`(`governing_body_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`emergency_activation` ADD CONSTRAINT `fk_security_emergency_activation_incident_report_id` FOREIGN KEY (`incident_report_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`incident_report`(`incident_report_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`emergency_activation` ADD CONSTRAINT `fk_security_emergency_activation_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`prohibited_item` ADD CONSTRAINT `fk_security_prohibited_item_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`after_action_report` ADD CONSTRAINT `fk_security_after_action_report_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`security_contract` ADD CONSTRAINT `fk_security_security_contract_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);

-- ========= security --> content (4 constraint(s)) =========
-- Requires: security schema, content schema
ALTER TABLE `sports_entertainment_ecm`.`security`.`credential_assignment` ADD CONSTRAINT `fk_security_credential_assignment_creator_profile_id` FOREIGN KEY (`creator_profile_id`) REFERENCES `sports_entertainment_ecm`.`content`.`creator_profile`(`creator_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`security_incident` ADD CONSTRAINT `fk_security_security_incident_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`surveillance_footage_request` ADD CONSTRAINT `fk_security_surveillance_footage_request_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`surveillance_footage_request` ADD CONSTRAINT `fk_security_surveillance_footage_request_ingest_job_id` FOREIGN KEY (`ingest_job_id`) REFERENCES `sports_entertainment_ecm`.`content`.`ingest_job`(`ingest_job_id`);

-- ========= security --> event (41 constraint(s)) =========
-- Requires: security schema, event schema
ALTER TABLE `sports_entertainment_ecm`.`security`.`credential` ADD CONSTRAINT `fk_security_credential_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`credential` ADD CONSTRAINT `fk_security_credential_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`credential_assignment` ADD CONSTRAINT `fk_security_credential_assignment_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`credential_assignment` ADD CONSTRAINT `fk_security_credential_assignment_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`access_event` ADD CONSTRAINT `fk_security_access_event_calendar_id` FOREIGN KEY (`calendar_id`) REFERENCES `sports_entertainment_ecm`.`event`.`calendar`(`calendar_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`access_event` ADD CONSTRAINT `fk_security_access_event_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`access_event` ADD CONSTRAINT `fk_security_access_event_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`screening_event` ADD CONSTRAINT `fk_security_screening_event_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`screening_event` ADD CONSTRAINT `fk_security_screening_event_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`post` ADD CONSTRAINT `fk_security_post_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`post` ADD CONSTRAINT `fk_security_post_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`post_assignment` ADD CONSTRAINT `fk_security_post_assignment_calendar_id` FOREIGN KEY (`calendar_id`) REFERENCES `sports_entertainment_ecm`.`event`.`calendar`(`calendar_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`post_assignment` ADD CONSTRAINT `fk_security_post_assignment_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`security_incident` ADD CONSTRAINT `fk_security_security_incident_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`security_incident` ADD CONSTRAINT `fk_security_security_incident_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`ejection_record` ADD CONSTRAINT `fk_security_ejection_record_calendar_id` FOREIGN KEY (`calendar_id`) REFERENCES `sports_entertainment_ecm`.`event`.`calendar`(`calendar_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`ejection_record` ADD CONSTRAINT `fk_security_ejection_record_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`venue_ban` ADD CONSTRAINT `fk_security_venue_ban_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`venue_ban` ADD CONSTRAINT `fk_security_venue_ban_specific_event_fixture_id` FOREIGN KEY (`specific_event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`crowd_management_plan` ADD CONSTRAINT `fk_security_crowd_management_plan_calendar_id` FOREIGN KEY (`calendar_id`) REFERENCES `sports_entertainment_ecm`.`event`.`calendar`(`calendar_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`crowd_management_plan` ADD CONSTRAINT `fk_security_crowd_management_plan_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`occupancy_snapshot` ADD CONSTRAINT `fk_security_occupancy_snapshot_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`occupancy_snapshot` ADD CONSTRAINT `fk_security_occupancy_snapshot_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`surveillance_footage_request` ADD CONSTRAINT `fk_security_surveillance_footage_request_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`surveillance_footage_request` ADD CONSTRAINT `fk_security_surveillance_footage_request_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`emergency_response_plan` ADD CONSTRAINT `fk_security_emergency_response_plan_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`emergency_response_plan` ADD CONSTRAINT `fk_security_emergency_response_plan_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`emergency_activation` ADD CONSTRAINT `fk_security_emergency_activation_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`emergency_activation` ADD CONSTRAINT `fk_security_emergency_activation_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`law_enforcement_deployment` ADD CONSTRAINT `fk_security_law_enforcement_deployment_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`law_enforcement_deployment` ADD CONSTRAINT `fk_security_law_enforcement_deployment_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`threat_assessment` ADD CONSTRAINT `fk_security_threat_assessment_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`threat_assessment` ADD CONSTRAINT `fk_security_threat_assessment_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`confiscation_record` ADD CONSTRAINT `fk_security_confiscation_record_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`confiscation_record` ADD CONSTRAINT `fk_security_confiscation_record_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`briefing` ADD CONSTRAINT `fk_security_briefing_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`briefing` ADD CONSTRAINT `fk_security_briefing_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`after_action_report` ADD CONSTRAINT `fk_security_after_action_report_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`after_action_report` ADD CONSTRAINT `fk_security_after_action_report_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`staffing_plan` ADD CONSTRAINT `fk_security_staffing_plan_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`staffing_plan` ADD CONSTRAINT `fk_security_staffing_plan_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);

-- ========= security --> fan (15 constraint(s)) =========
-- Requires: security schema, fan schema
ALTER TABLE `sports_entertainment_ecm`.`security`.`access_event` ADD CONSTRAINT `fk_security_access_event_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`screening_event` ADD CONSTRAINT `fk_security_screening_event_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`screening_event` ADD CONSTRAINT `fk_security_screening_event_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`membership`(`membership_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`screening_event` ADD CONSTRAINT `fk_security_screening_event_screened_person_fan_profile_id` FOREIGN KEY (`screened_person_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`security_incident` ADD CONSTRAINT `fk_security_security_incident_fan_fan_profile_id` FOREIGN KEY (`fan_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`security_incident` ADD CONSTRAINT `fk_security_security_incident_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`security_incident` ADD CONSTRAINT `fk_security_security_incident_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`membership`(`membership_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`ejection_record` ADD CONSTRAINT `fk_security_ejection_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`account`(`account_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`ejection_record` ADD CONSTRAINT `fk_security_ejection_record_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`ejection_record` ADD CONSTRAINT `fk_security_ejection_record_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`service_case`(`service_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`venue_ban` ADD CONSTRAINT `fk_security_venue_ban_account_id` FOREIGN KEY (`account_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`account`(`account_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`venue_ban` ADD CONSTRAINT `fk_security_venue_ban_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`venue_ban` ADD CONSTRAINT `fk_security_venue_ban_service_case_id` FOREIGN KEY (`service_case_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`service_case`(`service_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`threat_assessment` ADD CONSTRAINT `fk_security_threat_assessment_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`confiscation_record` ADD CONSTRAINT `fk_security_confiscation_record_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);

-- ========= security --> finance (6 constraint(s)) =========
-- Requires: security schema, finance schema
ALTER TABLE `sports_entertainment_ecm`.`security`.`law_enforcement_deployment` ADD CONSTRAINT `fk_security_law_enforcement_deployment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`security_contract` ADD CONSTRAINT `fk_security_security_contract_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`security_contract` ADD CONSTRAINT `fk_security_security_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`staffing_plan` ADD CONSTRAINT `fk_security_staffing_plan_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`staffing_plan` ADD CONSTRAINT `fk_security_staffing_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`staffing_plan` ADD CONSTRAINT `fk_security_staffing_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= security --> gaming (4 constraint(s)) =========
-- Requires: security schema, gaming schema
ALTER TABLE `sports_entertainment_ecm`.`security`.`surveillance_footage_request` ADD CONSTRAINT `fk_security_surveillance_footage_request_integrity_alert_id` FOREIGN KEY (`integrity_alert_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`integrity_alert`(`integrity_alert_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`threat_assessment` ADD CONSTRAINT `fk_security_threat_assessment_integrity_alert_id` FOREIGN KEY (`integrity_alert_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`integrity_alert`(`integrity_alert_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`briefing` ADD CONSTRAINT `fk_security_briefing_integrity_alert_id` FOREIGN KEY (`integrity_alert_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`integrity_alert`(`integrity_alert_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`after_action_report` ADD CONSTRAINT `fk_security_after_action_report_integrity_alert_id` FOREIGN KEY (`integrity_alert_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`integrity_alert`(`integrity_alert_id`);

-- ========= security --> league (38 constraint(s)) =========
-- Requires: security schema, league schema
ALTER TABLE `sports_entertainment_ecm`.`security`.`credential` ADD CONSTRAINT `fk_security_credential_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`credential` ADD CONSTRAINT `fk_security_credential_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`credential_assignment` ADD CONSTRAINT `fk_security_credential_assignment_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`credential_assignment` ADD CONSTRAINT `fk_security_credential_assignment_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`screening_event` ADD CONSTRAINT `fk_security_screening_event_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`screening_event` ADD CONSTRAINT `fk_security_screening_event_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`post` ADD CONSTRAINT `fk_security_post_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`post` ADD CONSTRAINT `fk_security_post_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`security_incident` ADD CONSTRAINT `fk_security_security_incident_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`security_incident` ADD CONSTRAINT `fk_security_security_incident_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`ejection_record` ADD CONSTRAINT `fk_security_ejection_record_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`ejection_record` ADD CONSTRAINT `fk_security_ejection_record_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`venue_ban` ADD CONSTRAINT `fk_security_venue_ban_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`venue_ban` ADD CONSTRAINT `fk_security_venue_ban_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`venue_ban` ADD CONSTRAINT `fk_security_venue_ban_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`crowd_management_plan` ADD CONSTRAINT `fk_security_crowd_management_plan_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`crowd_management_plan` ADD CONSTRAINT `fk_security_crowd_management_plan_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`occupancy_snapshot` ADD CONSTRAINT `fk_security_occupancy_snapshot_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`occupancy_snapshot` ADD CONSTRAINT `fk_security_occupancy_snapshot_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`surveillance_footage_request` ADD CONSTRAINT `fk_security_surveillance_footage_request_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`surveillance_footage_request` ADD CONSTRAINT `fk_security_surveillance_footage_request_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`emergency_response_plan` ADD CONSTRAINT `fk_security_emergency_response_plan_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`emergency_response_plan` ADD CONSTRAINT `fk_security_emergency_response_plan_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`emergency_activation` ADD CONSTRAINT `fk_security_emergency_activation_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`emergency_activation` ADD CONSTRAINT `fk_security_emergency_activation_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`law_enforcement_deployment` ADD CONSTRAINT `fk_security_law_enforcement_deployment_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`law_enforcement_deployment` ADD CONSTRAINT `fk_security_law_enforcement_deployment_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`threat_assessment` ADD CONSTRAINT `fk_security_threat_assessment_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`threat_assessment` ADD CONSTRAINT `fk_security_threat_assessment_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`prohibited_item` ADD CONSTRAINT `fk_security_prohibited_item_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`confiscation_record` ADD CONSTRAINT `fk_security_confiscation_record_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`briefing` ADD CONSTRAINT `fk_security_briefing_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`after_action_report` ADD CONSTRAINT `fk_security_after_action_report_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`after_action_report` ADD CONSTRAINT `fk_security_after_action_report_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`security_contract` ADD CONSTRAINT `fk_security_security_contract_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`security_contract` ADD CONSTRAINT `fk_security_security_contract_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`staffing_plan` ADD CONSTRAINT `fk_security_staffing_plan_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`staffing_plan` ADD CONSTRAINT `fk_security_staffing_plan_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);

-- ========= security --> legal (14 constraint(s)) =========
-- Requires: security schema, legal schema
ALTER TABLE `sports_entertainment_ecm`.`security`.`ejection_record` ADD CONSTRAINT `fk_security_ejection_record_litigation_case_id` FOREIGN KEY (`litigation_case_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`litigation_case`(`litigation_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`venue_ban` ADD CONSTRAINT `fk_security_venue_ban_litigation_case_id` FOREIGN KEY (`litigation_case_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`litigation_case`(`litigation_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`venue_ban` ADD CONSTRAINT `fk_security_venue_ban_settlement_agreement_id` FOREIGN KEY (`settlement_agreement_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`settlement_agreement`(`settlement_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`crowd_management_plan` ADD CONSTRAINT `fk_security_crowd_management_plan_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`surveillance_footage_request` ADD CONSTRAINT `fk_security_surveillance_footage_request_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`hold`(`hold_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`surveillance_footage_request` ADD CONSTRAINT `fk_security_surveillance_footage_request_litigation_case_id` FOREIGN KEY (`litigation_case_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`litigation_case`(`litigation_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`emergency_response_plan` ADD CONSTRAINT `fk_security_emergency_response_plan_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`emergency_activation` ADD CONSTRAINT `fk_security_emergency_activation_litigation_case_id` FOREIGN KEY (`litigation_case_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`litigation_case`(`litigation_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`law_enforcement_deployment` ADD CONSTRAINT `fk_security_law_enforcement_deployment_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`threat_assessment` ADD CONSTRAINT `fk_security_threat_assessment_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`confiscation_record` ADD CONSTRAINT `fk_security_confiscation_record_litigation_case_id` FOREIGN KEY (`litigation_case_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`litigation_case`(`litigation_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`after_action_report` ADD CONSTRAINT `fk_security_after_action_report_litigation_case_id` FOREIGN KEY (`litigation_case_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`litigation_case`(`litigation_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`security_contract` ADD CONSTRAINT `fk_security_security_contract_insurance_policy_id` FOREIGN KEY (`insurance_policy_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`insurance_policy`(`insurance_policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`security_contract` ADD CONSTRAINT `fk_security_security_contract_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);

-- ========= security --> merchandise (1 constraint(s)) =========
-- Requires: security schema, merchandise schema
ALTER TABLE `sports_entertainment_ecm`.`security`.`security_incident` ADD CONSTRAINT `fk_security_security_incident_retail_location_id` FOREIGN KEY (`retail_location_id`) REFERENCES `sports_entertainment_ecm`.`merchandise`.`retail_location`(`retail_location_id`);

-- ========= security --> partner (6 constraint(s)) =========
-- Requires: security schema, partner schema
ALTER TABLE `sports_entertainment_ecm`.`security`.`law_enforcement_deployment` ADD CONSTRAINT `fk_security_law_enforcement_deployment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`security_contract` ADD CONSTRAINT `fk_security_security_contract_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`security_contract` ADD CONSTRAINT `fk_security_security_contract_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`security_contract` ADD CONSTRAINT `fk_security_security_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`staffing_plan` ADD CONSTRAINT `fk_security_staffing_plan_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`staffing_plan` ADD CONSTRAINT `fk_security_staffing_plan_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);

-- ========= security --> sponsorship (1 constraint(s)) =========
-- Requires: security schema, sponsorship schema
ALTER TABLE `sports_entertainment_ecm`.`security`.`credential` ADD CONSTRAINT `fk_security_credential_hospitality_entitlement_id` FOREIGN KEY (`hospitality_entitlement_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`hospitality_entitlement`(`hospitality_entitlement_id`);

-- ========= security --> venue (28 constraint(s)) =========
-- Requires: security schema, venue schema
ALTER TABLE `sports_entertainment_ecm`.`security`.`credential` ADD CONSTRAINT `fk_security_credential_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`access_zone` ADD CONSTRAINT `fk_security_access_zone_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`facility`(`facility_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`access_zone` ADD CONSTRAINT `fk_security_access_zone_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`credential_assignment` ADD CONSTRAINT `fk_security_credential_assignment_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`access_event` ADD CONSTRAINT `fk_security_access_event_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`screening_checkpoint` ADD CONSTRAINT `fk_security_screening_checkpoint_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`screening_event` ADD CONSTRAINT `fk_security_screening_event_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`post` ADD CONSTRAINT `fk_security_post_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`post_assignment` ADD CONSTRAINT `fk_security_post_assignment_staff_plan_id` FOREIGN KEY (`staff_plan_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`staff_plan`(`staff_plan_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`post_assignment` ADD CONSTRAINT `fk_security_post_assignment_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`security_incident` ADD CONSTRAINT `fk_security_security_incident_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`ejection_record` ADD CONSTRAINT `fk_security_ejection_record_staff_plan_id` FOREIGN KEY (`staff_plan_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`staff_plan`(`staff_plan_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`ejection_record` ADD CONSTRAINT `fk_security_ejection_record_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`venue_ban` ADD CONSTRAINT `fk_security_venue_ban_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`crowd_management_plan` ADD CONSTRAINT `fk_security_crowd_management_plan_staff_plan_id` FOREIGN KEY (`staff_plan_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`staff_plan`(`staff_plan_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`crowd_management_plan` ADD CONSTRAINT `fk_security_crowd_management_plan_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`occupancy_snapshot` ADD CONSTRAINT `fk_security_occupancy_snapshot_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`surveillance_camera` ADD CONSTRAINT `fk_security_surveillance_camera_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`surveillance_footage_request` ADD CONSTRAINT `fk_security_surveillance_footage_request_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`emergency_response_plan` ADD CONSTRAINT `fk_security_emergency_response_plan_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`emergency_activation` ADD CONSTRAINT `fk_security_emergency_activation_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`law_enforcement_deployment` ADD CONSTRAINT `fk_security_law_enforcement_deployment_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`threat_assessment` ADD CONSTRAINT `fk_security_threat_assessment_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`confiscation_record` ADD CONSTRAINT `fk_security_confiscation_record_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`briefing` ADD CONSTRAINT `fk_security_briefing_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`after_action_report` ADD CONSTRAINT `fk_security_after_action_report_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`security_contract` ADD CONSTRAINT `fk_security_security_contract_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`staffing_plan` ADD CONSTRAINT `fk_security_staffing_plan_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);

-- ========= security --> workforce (59 constraint(s)) =========
-- Requires: security schema, workforce schema
ALTER TABLE `sports_entertainment_ecm`.`security`.`credential` ADD CONSTRAINT `fk_security_credential_contingent_worker_id` FOREIGN KEY (`contingent_worker_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`contingent_worker`(`contingent_worker_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`credential` ADD CONSTRAINT `fk_security_credential_credential_employee_id` FOREIGN KEY (`credential_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`credential` ADD CONSTRAINT `fk_security_credential_credential_holder_employee_id` FOREIGN KEY (`credential_holder_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`credential` ADD CONSTRAINT `fk_security_credential_credential_revoked_by_user_employee_id` FOREIGN KEY (`credential_revoked_by_user_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`credential` ADD CONSTRAINT `fk_security_credential_employee_certification_id` FOREIGN KEY (`employee_certification_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee_certification`(`employee_certification_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`credential` ADD CONSTRAINT `fk_security_credential_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`credential` ADD CONSTRAINT `fk_security_credential_issued_by_user_employee_id` FOREIGN KEY (`issued_by_user_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`credential` ADD CONSTRAINT `fk_security_credential_revoked_by_user_employee_id` FOREIGN KEY (`revoked_by_user_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`credential_assignment` ADD CONSTRAINT `fk_security_credential_assignment_assigned_by_officer_employee_id` FOREIGN KEY (`assigned_by_officer_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`credential_assignment` ADD CONSTRAINT `fk_security_credential_assignment_contingent_worker_id` FOREIGN KEY (`contingent_worker_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`contingent_worker`(`contingent_worker_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`credential_assignment` ADD CONSTRAINT `fk_security_credential_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`credential_assignment` ADD CONSTRAINT `fk_security_credential_assignment_primary_credential_holder_employee_id` FOREIGN KEY (`primary_credential_holder_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`access_event` ADD CONSTRAINT `fk_security_access_event_contingent_worker_id` FOREIGN KEY (`contingent_worker_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`contingent_worker`(`contingent_worker_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`access_event` ADD CONSTRAINT `fk_security_access_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`access_event` ADD CONSTRAINT `fk_security_access_event_officer_employee_id` FOREIGN KEY (`officer_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`screening_event` ADD CONSTRAINT `fk_security_screening_event_contingent_worker_id` FOREIGN KEY (`contingent_worker_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`contingent_worker`(`contingent_worker_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`screening_event` ADD CONSTRAINT `fk_security_screening_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`screening_event` ADD CONSTRAINT `fk_security_screening_event_primary_screening_employee_id` FOREIGN KEY (`primary_screening_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`screening_event` ADD CONSTRAINT `fk_security_screening_event_shift_assignment_id` FOREIGN KEY (`shift_assignment_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`shift_assignment`(`shift_assignment_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`screening_event` ADD CONSTRAINT `fk_security_screening_event_shift_shift_assignment_id` FOREIGN KEY (`shift_shift_assignment_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`shift_assignment`(`shift_assignment_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`screening_event` ADD CONSTRAINT `fk_security_screening_event_supervisor_employee_id` FOREIGN KEY (`supervisor_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`post` ADD CONSTRAINT `fk_security_post_position_id` FOREIGN KEY (`position_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`post_assignment` ADD CONSTRAINT `fk_security_post_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`post_assignment` ADD CONSTRAINT `fk_security_post_assignment_primary_post_employee_id` FOREIGN KEY (`primary_post_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`post_assignment` ADD CONSTRAINT `fk_security_post_assignment_relief_officer_employee_id` FOREIGN KEY (`relief_officer_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`post_assignment` ADD CONSTRAINT `fk_security_post_assignment_supervisor_employee_id` FOREIGN KEY (`supervisor_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`post_assignment` ADD CONSTRAINT `fk_security_post_assignment_tertiary_post_supervisor_employee_id` FOREIGN KEY (`tertiary_post_supervisor_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`security_incident` ADD CONSTRAINT `fk_security_security_incident_contingent_worker_id` FOREIGN KEY (`contingent_worker_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`contingent_worker`(`contingent_worker_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`security_incident` ADD CONSTRAINT `fk_security_security_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`security_incident` ADD CONSTRAINT `fk_security_security_incident_primary_security_employee_id` FOREIGN KEY (`primary_security_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`security_incident` ADD CONSTRAINT `fk_security_security_incident_supervisor_employee_id` FOREIGN KEY (`supervisor_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`ejection_record` ADD CONSTRAINT `fk_security_ejection_record_contingent_worker_id` FOREIGN KEY (`contingent_worker_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`contingent_worker`(`contingent_worker_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`ejection_record` ADD CONSTRAINT `fk_security_ejection_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`ejection_record` ADD CONSTRAINT `fk_security_ejection_record_primary_ejection_employee_id` FOREIGN KEY (`primary_ejection_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`ejection_record` ADD CONSTRAINT `fk_security_ejection_record_supervisor_employee_id` FOREIGN KEY (`supervisor_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`surveillance_footage_request` ADD CONSTRAINT `fk_security_surveillance_footage_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`surveillance_footage_request` ADD CONSTRAINT `fk_security_surveillance_footage_request_requesting_officer_employee_id` FOREIGN KEY (`requesting_officer_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`emergency_activation` ADD CONSTRAINT `fk_security_emergency_activation_activating_authority_employee_id` FOREIGN KEY (`activating_authority_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`emergency_activation` ADD CONSTRAINT `fk_security_emergency_activation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`threat_assessment` ADD CONSTRAINT `fk_security_threat_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`threat_assessment` ADD CONSTRAINT `fk_security_threat_assessment_primary_threat_employee_id` FOREIGN KEY (`primary_threat_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`threat_assessment` ADD CONSTRAINT `fk_security_threat_assessment_reviewing_officer_employee_id` FOREIGN KEY (`reviewing_officer_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`confiscation_record` ADD CONSTRAINT `fk_security_confiscation_record_contingent_worker_id` FOREIGN KEY (`contingent_worker_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`contingent_worker`(`contingent_worker_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`confiscation_record` ADD CONSTRAINT `fk_security_confiscation_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`confiscation_record` ADD CONSTRAINT `fk_security_confiscation_record_primary_confiscation_employee_id` FOREIGN KEY (`primary_confiscation_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`confiscation_record` ADD CONSTRAINT `fk_security_confiscation_record_shift_assignment_id` FOREIGN KEY (`shift_assignment_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`shift_assignment`(`shift_assignment_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`confiscation_record` ADD CONSTRAINT `fk_security_confiscation_record_shift_shift_assignment_id` FOREIGN KEY (`shift_shift_assignment_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`shift_assignment`(`shift_assignment_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`confiscation_record` ADD CONSTRAINT `fk_security_confiscation_record_supervisor_employee_id` FOREIGN KEY (`supervisor_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`briefing` ADD CONSTRAINT `fk_security_briefing_contingent_worker_id` FOREIGN KEY (`contingent_worker_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`contingent_worker`(`contingent_worker_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`briefing` ADD CONSTRAINT `fk_security_briefing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`briefing` ADD CONSTRAINT `fk_security_briefing_officer_employee_id` FOREIGN KEY (`officer_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`after_action_report` ADD CONSTRAINT `fk_security_after_action_report_approving_director_employee_id` FOREIGN KEY (`approving_director_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`after_action_report` ADD CONSTRAINT `fk_security_after_action_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`after_action_report` ADD CONSTRAINT `fk_security_after_action_report_primary_after_employee_id` FOREIGN KEY (`primary_after_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`security_contract` ADD CONSTRAINT `fk_security_security_contract_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`security_contract` ADD CONSTRAINT `fk_security_security_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`security_contract` ADD CONSTRAINT `fk_security_security_contract_primary_security_employee_id` FOREIGN KEY (`primary_security_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`staffing_plan` ADD CONSTRAINT `fk_security_staffing_plan_approved_by_officer_employee_id` FOREIGN KEY (`approved_by_officer_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`security`.`staffing_plan` ADD CONSTRAINT `fk_security_staffing_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= sponsorship --> analytics (15 constraint(s)) =========
-- Requires: sponsorship schema, analytics schema
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal` ADD CONSTRAINT `fk_sponsorship_deal_forecast_model_id` FOREIGN KEY (`forecast_model_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`forecast_model`(`forecast_model_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`activation_fulfillment` ADD CONSTRAINT `fk_sponsorship_activation_fulfillment_audience_measurement_id` FOREIGN KEY (`audience_measurement_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`audience_measurement`(`audience_measurement_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`activation_fulfillment` ADD CONSTRAINT `fk_sponsorship_activation_fulfillment_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_ad_inventory` ADD CONSTRAINT `fk_sponsorship_sponsorship_ad_inventory_audience_measurement_id` FOREIGN KEY (`audience_measurement_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`audience_measurement`(`audience_measurement_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`broadcast_integration` ADD CONSTRAINT `fk_sponsorship_broadcast_integration_audience_measurement_id` FOREIGN KEY (`audience_measurement_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`audience_measurement`(`audience_measurement_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`digital_partnership` ADD CONSTRAINT `fk_sponsorship_digital_partnership_attribution_model_id` FOREIGN KEY (`attribution_model_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`attribution_model`(`attribution_model_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`performance_metric` ADD CONSTRAINT `fk_sponsorship_performance_metric_audience_measurement_id` FOREIGN KEY (`audience_measurement_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`audience_measurement`(`audience_measurement_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`performance_metric` ADD CONSTRAINT `fk_sponsorship_performance_metric_forecast_output_id` FOREIGN KEY (`forecast_output_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`forecast_output`(`forecast_output_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`performance_metric` ADD CONSTRAINT `fk_sponsorship_performance_metric_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`performance_metric` ADD CONSTRAINT `fk_sponsorship_performance_metric_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`roi_report` ADD CONSTRAINT `fk_sponsorship_roi_report_dashboard_definition_id` FOREIGN KEY (`dashboard_definition_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`dashboard_definition`(`dashboard_definition_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`roi_report` ADD CONSTRAINT `fk_sponsorship_roi_report_engagement_index_id` FOREIGN KEY (`engagement_index_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`engagement_index`(`engagement_index_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`roi_report` ADD CONSTRAINT `fk_sponsorship_roi_report_forecast_output_id` FOREIGN KEY (`forecast_output_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`forecast_output`(`forecast_output_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`roi_report` ADD CONSTRAINT `fk_sponsorship_roi_report_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`asset_valuation` ADD CONSTRAINT `fk_sponsorship_asset_valuation_forecast_model_id` FOREIGN KEY (`forecast_model_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`forecast_model`(`forecast_model_id`);

-- ========= sponsorship --> athlete (8 constraint(s)) =========
-- Requires: sponsorship schema, athlete schema
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation` ADD CONSTRAINT `fk_sponsorship_sponsorship_activation_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation` ADD CONSTRAINT `fk_sponsorship_sponsorship_activation_nil_agreement_id` FOREIGN KEY (`nil_agreement_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`nil_agreement`(`nil_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`jersey_sponsorship` ADD CONSTRAINT `fk_sponsorship_jersey_sponsorship_athlete_athlete_profile_id` FOREIGN KEY (`athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`jersey_sponsorship` ADD CONSTRAINT `fk_sponsorship_jersey_sponsorship_athlete_contract_id` FOREIGN KEY (`athlete_contract_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_contract`(`athlete_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`jersey_sponsorship` ADD CONSTRAINT `fk_sponsorship_jersey_sponsorship_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`broadcast_integration` ADD CONSTRAINT `fk_sponsorship_broadcast_integration_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`digital_partnership` ADD CONSTRAINT `fk_sponsorship_digital_partnership_athlete_contract_id` FOREIGN KEY (`athlete_contract_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_contract`(`athlete_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`performance_metric` ADD CONSTRAINT `fk_sponsorship_performance_metric_athlete_contract_id` FOREIGN KEY (`athlete_contract_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_contract`(`athlete_contract_id`);

-- ========= sponsorship --> broadcast (13 constraint(s)) =========
-- Requires: sponsorship schema, broadcast schema
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal` ADD CONSTRAINT `fk_sponsorship_deal_media_rights_deal_id` FOREIGN KEY (`media_rights_deal_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`media_rights_deal`(`media_rights_deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation` ADD CONSTRAINT `fk_sponsorship_sponsorship_activation_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`activation_fulfillment` ADD CONSTRAINT `fk_sponsorship_activation_fulfillment_audience_rating_id` FOREIGN KEY (`audience_rating_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`audience_rating`(`audience_rating_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`activation_fulfillment` ADD CONSTRAINT `fk_sponsorship_activation_fulfillment_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`naming_right` ADD CONSTRAINT `fk_sponsorship_naming_right_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`jersey_sponsorship` ADD CONSTRAINT `fk_sponsorship_jersey_sponsorship_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`broadcast_integration` ADD CONSTRAINT `fk_sponsorship_broadcast_integration_broadcast_ad_inventory_id` FOREIGN KEY (`broadcast_ad_inventory_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_ad_inventory`(`broadcast_ad_inventory_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`broadcast_integration` ADD CONSTRAINT `fk_sponsorship_broadcast_integration_broadcast_schedule_id` FOREIGN KEY (`broadcast_schedule_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`broadcast_schedule`(`broadcast_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`broadcast_integration` ADD CONSTRAINT `fk_sponsorship_broadcast_integration_live_feed_id` FOREIGN KEY (`live_feed_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`live_feed`(`live_feed_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`broadcast_integration` ADD CONSTRAINT `fk_sponsorship_broadcast_integration_production_id` FOREIGN KEY (`production_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`production`(`production_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`performance_metric` ADD CONSTRAINT `fk_sponsorship_performance_metric_audience_rating_id` FOREIGN KEY (`audience_rating_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`audience_rating`(`audience_rating_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`roi_report` ADD CONSTRAINT `fk_sponsorship_roi_report_audience_rating_id` FOREIGN KEY (`audience_rating_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`audience_rating`(`audience_rating_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`asset_valuation` ADD CONSTRAINT `fk_sponsorship_asset_valuation_audience_rating_id` FOREIGN KEY (`audience_rating_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`audience_rating`(`audience_rating_id`);

-- ========= sponsorship --> compliance (25 constraint(s)) =========
-- Requires: sponsorship schema, compliance schema
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal` ADD CONSTRAINT `fk_sponsorship_deal_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal` ADD CONSTRAINT `fk_sponsorship_deal_governing_body_id` FOREIGN KEY (`governing_body_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`governing_body`(`governing_body_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal` ADD CONSTRAINT `fk_sponsorship_deal_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal_term` ADD CONSTRAINT `fk_sponsorship_deal_term_governing_body_id` FOREIGN KEY (`governing_body_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`governing_body`(`governing_body_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal_amendment` ADD CONSTRAINT `fk_sponsorship_deal_amendment_incident_report_id` FOREIGN KEY (`incident_report_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`incident_report`(`incident_report_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal_amendment` ADD CONSTRAINT `fk_sponsorship_deal_amendment_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation` ADD CONSTRAINT `fk_sponsorship_sponsorship_activation_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`activation_fulfillment` ADD CONSTRAINT `fk_sponsorship_activation_fulfillment_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`naming_right` ADD CONSTRAINT `fk_sponsorship_naming_right_governing_body_id` FOREIGN KEY (`governing_body_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`governing_body`(`governing_body_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`naming_right` ADD CONSTRAINT `fk_sponsorship_naming_right_license_permit_id` FOREIGN KEY (`license_permit_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`license_permit`(`license_permit_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`naming_right` ADD CONSTRAINT `fk_sponsorship_naming_right_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`jersey_sponsorship` ADD CONSTRAINT `fk_sponsorship_jersey_sponsorship_governing_body_id` FOREIGN KEY (`governing_body_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`governing_body`(`governing_body_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`jersey_sponsorship` ADD CONSTRAINT `fk_sponsorship_jersey_sponsorship_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_ad_inventory` ADD CONSTRAINT `fk_sponsorship_sponsorship_ad_inventory_governing_body_id` FOREIGN KEY (`governing_body_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`governing_body`(`governing_body_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_ad_inventory` ADD CONSTRAINT `fk_sponsorship_sponsorship_ad_inventory_license_permit_id` FOREIGN KEY (`license_permit_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`license_permit`(`license_permit_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`broadcast_integration` ADD CONSTRAINT `fk_sponsorship_broadcast_integration_license_permit_id` FOREIGN KEY (`license_permit_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`license_permit`(`license_permit_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`broadcast_integration` ADD CONSTRAINT `fk_sponsorship_broadcast_integration_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`digital_partnership` ADD CONSTRAINT `fk_sponsorship_digital_partnership_data_processing_record_id` FOREIGN KEY (`data_processing_record_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`data_processing_record`(`data_processing_record_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`digital_partnership` ADD CONSTRAINT `fk_sponsorship_digital_partnership_pia_assessment_id` FOREIGN KEY (`pia_assessment_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`pia_assessment`(`pia_assessment_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`performance_metric` ADD CONSTRAINT `fk_sponsorship_performance_metric_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`roi_report` ADD CONSTRAINT `fk_sponsorship_roi_report_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`hospitality_entitlement` ADD CONSTRAINT `fk_sponsorship_hospitality_entitlement_governing_body_id` FOREIGN KEY (`governing_body_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`governing_body`(`governing_body_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`hospitality_entitlement` ADD CONSTRAINT `fk_sponsorship_hospitality_entitlement_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`renewal` ADD CONSTRAINT `fk_sponsorship_renewal_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`asset_valuation` ADD CONSTRAINT `fk_sponsorship_asset_valuation_audit_engagement_id` FOREIGN KEY (`audit_engagement_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`audit_engagement`(`audit_engagement_id`);

-- ========= sponsorship --> content (17 constraint(s)) =========
-- Requires: sponsorship schema, content schema
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal_term` ADD CONSTRAINT `fk_sponsorship_deal_term_content_license_id` FOREIGN KEY (`content_license_id`) REFERENCES `sports_entertainment_ecm`.`content`.`content_license`(`content_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation` ADD CONSTRAINT `fk_sponsorship_sponsorship_activation_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`activation_fulfillment` ADD CONSTRAINT `fk_sponsorship_activation_fulfillment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`naming_right` ADD CONSTRAINT `fk_sponsorship_naming_right_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`jersey_sponsorship` ADD CONSTRAINT `fk_sponsorship_jersey_sponsorship_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_ad_inventory` ADD CONSTRAINT `fk_sponsorship_sponsorship_ad_inventory_content_drm_policy_id` FOREIGN KEY (`content_drm_policy_id`) REFERENCES `sports_entertainment_ecm`.`content`.`content_drm_policy`(`content_drm_policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_ad_inventory` ADD CONSTRAINT `fk_sponsorship_sponsorship_ad_inventory_platform_channel_id` FOREIGN KEY (`platform_channel_id`) REFERENCES `sports_entertainment_ecm`.`content`.`platform_channel`(`platform_channel_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`inventory_allocation` ADD CONSTRAINT `fk_sponsorship_inventory_allocation_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`broadcast_integration` ADD CONSTRAINT `fk_sponsorship_broadcast_integration_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`broadcast_integration` ADD CONSTRAINT `fk_sponsorship_broadcast_integration_platform_channel_id` FOREIGN KEY (`platform_channel_id`) REFERENCES `sports_entertainment_ecm`.`content`.`platform_channel`(`platform_channel_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`broadcast_integration` ADD CONSTRAINT `fk_sponsorship_broadcast_integration_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `sports_entertainment_ecm`.`content`.`production_order`(`production_order_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`digital_partnership` ADD CONSTRAINT `fk_sponsorship_digital_partnership_content_drm_policy_id` FOREIGN KEY (`content_drm_policy_id`) REFERENCES `sports_entertainment_ecm`.`content`.`content_drm_policy`(`content_drm_policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`digital_partnership` ADD CONSTRAINT `fk_sponsorship_digital_partnership_platform_channel_id` FOREIGN KEY (`platform_channel_id`) REFERENCES `sports_entertainment_ecm`.`content`.`platform_channel`(`platform_channel_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`asset_valuation` ADD CONSTRAINT `fk_sponsorship_asset_valuation_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`asset_valuation` ADD CONSTRAINT `fk_sponsorship_asset_valuation_platform_channel_id` FOREIGN KEY (`platform_channel_id`) REFERENCES `sports_entertainment_ecm`.`content`.`platform_channel`(`platform_channel_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`creator_deal` ADD CONSTRAINT `fk_sponsorship_creator_deal_creator_profile_id` FOREIGN KEY (`creator_profile_id`) REFERENCES `sports_entertainment_ecm`.`content`.`creator_profile`(`creator_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`channel_activation` ADD CONSTRAINT `fk_sponsorship_channel_activation_platform_channel_id` FOREIGN KEY (`platform_channel_id`) REFERENCES `sports_entertainment_ecm`.`content`.`platform_channel`(`platform_channel_id`);

-- ========= sponsorship --> event (14 constraint(s)) =========
-- Requires: sponsorship schema, event schema
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation` ADD CONSTRAINT `fk_sponsorship_sponsorship_activation_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation` ADD CONSTRAINT `fk_sponsorship_sponsorship_activation_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`activation_fulfillment` ADD CONSTRAINT `fk_sponsorship_activation_fulfillment_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`activation_fulfillment` ADD CONSTRAINT `fk_sponsorship_activation_fulfillment_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`inventory_allocation` ADD CONSTRAINT `fk_sponsorship_inventory_allocation_broadcast_window_id` FOREIGN KEY (`broadcast_window_id`) REFERENCES `sports_entertainment_ecm`.`event`.`broadcast_window`(`broadcast_window_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`inventory_allocation` ADD CONSTRAINT `fk_sponsorship_inventory_allocation_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`inventory_allocation` ADD CONSTRAINT `fk_sponsorship_inventory_allocation_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`performance_metric` ADD CONSTRAINT `fk_sponsorship_performance_metric_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`performance_metric` ADD CONSTRAINT `fk_sponsorship_performance_metric_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`hospitality_entitlement` ADD CONSTRAINT `fk_sponsorship_hospitality_entitlement_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`hospitality_entitlement` ADD CONSTRAINT `fk_sponsorship_hospitality_entitlement_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`entitlement_redemption` ADD CONSTRAINT `fk_sponsorship_entitlement_redemption_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`entitlement_redemption` ADD CONSTRAINT `fk_sponsorship_entitlement_redemption_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`inventory_unit` ADD CONSTRAINT `fk_sponsorship_inventory_unit_event_type_id` FOREIGN KEY (`event_type_id`) REFERENCES `sports_entertainment_ecm`.`event`.`event_type`(`event_type_id`);

-- ========= sponsorship --> fan (5 constraint(s)) =========
-- Requires: sponsorship schema, fan schema
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal` ADD CONSTRAINT `fk_sponsorship_deal_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`segment`(`segment_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation` ADD CONSTRAINT `fk_sponsorship_sponsorship_activation_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`segment`(`segment_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`hospitality_entitlement` ADD CONSTRAINT `fk_sponsorship_hospitality_entitlement_account_id` FOREIGN KEY (`account_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`account`(`account_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`entitlement_redemption` ADD CONSTRAINT `fk_sponsorship_entitlement_redemption_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`inventory_unit` ADD CONSTRAINT `fk_sponsorship_inventory_unit_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`brand`(`brand_id`);

-- ========= sponsorship --> finance (24 constraint(s)) =========
-- Requires: sponsorship schema, finance schema
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal` ADD CONSTRAINT `fk_sponsorship_deal_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal` ADD CONSTRAINT `fk_sponsorship_deal_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal` ADD CONSTRAINT `fk_sponsorship_deal_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal` ADD CONSTRAINT `fk_sponsorship_deal_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal` ADD CONSTRAINT `fk_sponsorship_deal_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal_term` ADD CONSTRAINT `fk_sponsorship_deal_term_revenue_recognition_schedule_id` FOREIGN KEY (`revenue_recognition_schedule_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_recognition_schedule`(`revenue_recognition_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal_term` ADD CONSTRAINT `fk_sponsorship_deal_term_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal_amendment` ADD CONSTRAINT `fk_sponsorship_deal_amendment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal_amendment` ADD CONSTRAINT `fk_sponsorship_deal_amendment_revenue_recognition_schedule_id` FOREIGN KEY (`revenue_recognition_schedule_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_recognition_schedule`(`revenue_recognition_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation` ADD CONSTRAINT `fk_sponsorship_sponsorship_activation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`activation_fulfillment` ADD CONSTRAINT `fk_sponsorship_activation_fulfillment_revenue_recognition_schedule_id` FOREIGN KEY (`revenue_recognition_schedule_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_recognition_schedule`(`revenue_recognition_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`naming_right` ADD CONSTRAINT `fk_sponsorship_naming_right_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`naming_right` ADD CONSTRAINT `fk_sponsorship_naming_right_revenue_recognition_schedule_id` FOREIGN KEY (`revenue_recognition_schedule_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_recognition_schedule`(`revenue_recognition_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`naming_right` ADD CONSTRAINT `fk_sponsorship_naming_right_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`jersey_sponsorship` ADD CONSTRAINT `fk_sponsorship_jersey_sponsorship_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_ad_inventory` ADD CONSTRAINT `fk_sponsorship_sponsorship_ad_inventory_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`digital_partnership` ADD CONSTRAINT `fk_sponsorship_digital_partnership_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`performance_metric` ADD CONSTRAINT `fk_sponsorship_performance_metric_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`roi_report` ADD CONSTRAINT `fk_sponsorship_roi_report_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`payment_schedule` ADD CONSTRAINT `fk_sponsorship_payment_schedule_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`payment_schedule` ADD CONSTRAINT `fk_sponsorship_payment_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`payment_schedule` ADD CONSTRAINT `fk_sponsorship_payment_schedule_revenue_recognition_schedule_id` FOREIGN KEY (`revenue_recognition_schedule_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_recognition_schedule`(`revenue_recognition_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`payment_schedule` ADD CONSTRAINT `fk_sponsorship_payment_schedule_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`asset_valuation` ADD CONSTRAINT `fk_sponsorship_asset_valuation_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);

-- ========= sponsorship --> gaming (13 constraint(s)) =========
-- Requires: sponsorship schema, gaming schema
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal` ADD CONSTRAINT `fk_sponsorship_deal_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal_term` ADD CONSTRAINT `fk_sponsorship_deal_term_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation` ADD CONSTRAINT `fk_sponsorship_sponsorship_activation_betting_market_id` FOREIGN KEY (`betting_market_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`betting_market`(`betting_market_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation` ADD CONSTRAINT `fk_sponsorship_sponsorship_activation_bonus_offer_id` FOREIGN KEY (`bonus_offer_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`bonus_offer`(`bonus_offer_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation` ADD CONSTRAINT `fk_sponsorship_sponsorship_activation_contest_id` FOREIGN KEY (`contest_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`contest`(`contest_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`jersey_sponsorship` ADD CONSTRAINT `fk_sponsorship_jersey_sponsorship_esports_team_id` FOREIGN KEY (`esports_team_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`esports_team`(`esports_team_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_ad_inventory` ADD CONSTRAINT `fk_sponsorship_sponsorship_ad_inventory_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`broadcast_integration` ADD CONSTRAINT `fk_sponsorship_broadcast_integration_betting_market_id` FOREIGN KEY (`betting_market_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`betting_market`(`betting_market_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`broadcast_integration` ADD CONSTRAINT `fk_sponsorship_broadcast_integration_esports_match_id` FOREIGN KEY (`esports_match_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`esports_match`(`esports_match_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`digital_partnership` ADD CONSTRAINT `fk_sponsorship_digital_partnership_bonus_offer_id` FOREIGN KEY (`bonus_offer_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`bonus_offer`(`bonus_offer_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`digital_partnership` ADD CONSTRAINT `fk_sponsorship_digital_partnership_fantasy_league_id` FOREIGN KEY (`fantasy_league_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`fantasy_league`(`fantasy_league_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`digital_partnership` ADD CONSTRAINT `fk_sponsorship_digital_partnership_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`performance_metric` ADD CONSTRAINT `fk_sponsorship_performance_metric_betting_market_id` FOREIGN KEY (`betting_market_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`betting_market`(`betting_market_id`);

-- ========= sponsorship --> league (38 constraint(s)) =========
-- Requires: sponsorship schema, league schema
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal` ADD CONSTRAINT `fk_sponsorship_deal_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal_term` ADD CONSTRAINT `fk_sponsorship_deal_term_cba_agreement_id` FOREIGN KEY (`cba_agreement_id`) REFERENCES `sports_entertainment_ecm`.`league`.`cba_agreement`(`cba_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal_term` ADD CONSTRAINT `fk_sponsorship_deal_term_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal_amendment` ADD CONSTRAINT `fk_sponsorship_deal_amendment_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation` ADD CONSTRAINT `fk_sponsorship_sponsorship_activation_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`activation_fulfillment` ADD CONSTRAINT `fk_sponsorship_activation_fulfillment_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`naming_right` ADD CONSTRAINT `fk_sponsorship_naming_right_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`jersey_sponsorship` ADD CONSTRAINT `fk_sponsorship_jersey_sponsorship_cba_agreement_id` FOREIGN KEY (`cba_agreement_id`) REFERENCES `sports_entertainment_ecm`.`league`.`cba_agreement`(`cba_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`jersey_sponsorship` ADD CONSTRAINT `fk_sponsorship_jersey_sponsorship_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`jersey_sponsorship` ADD CONSTRAINT `fk_sponsorship_jersey_sponsorship_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`jersey_sponsorship` ADD CONSTRAINT `fk_sponsorship_jersey_sponsorship_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`jersey_sponsorship` ADD CONSTRAINT `fk_sponsorship_jersey_sponsorship_team_franchise_id` FOREIGN KEY (`team_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_ad_inventory` ADD CONSTRAINT `fk_sponsorship_sponsorship_ad_inventory_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_ad_inventory` ADD CONSTRAINT `fk_sponsorship_sponsorship_ad_inventory_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_ad_inventory` ADD CONSTRAINT `fk_sponsorship_sponsorship_ad_inventory_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`inventory_allocation` ADD CONSTRAINT `fk_sponsorship_inventory_allocation_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`inventory_allocation` ADD CONSTRAINT `fk_sponsorship_inventory_allocation_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`inventory_allocation` ADD CONSTRAINT `fk_sponsorship_inventory_allocation_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`broadcast_integration` ADD CONSTRAINT `fk_sponsorship_broadcast_integration_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`digital_partnership` ADD CONSTRAINT `fk_sponsorship_digital_partnership_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`digital_partnership` ADD CONSTRAINT `fk_sponsorship_digital_partnership_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`performance_metric` ADD CONSTRAINT `fk_sponsorship_performance_metric_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`performance_metric` ADD CONSTRAINT `fk_sponsorship_performance_metric_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`roi_report` ADD CONSTRAINT `fk_sponsorship_roi_report_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`roi_report` ADD CONSTRAINT `fk_sponsorship_roi_report_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`roi_report` ADD CONSTRAINT `fk_sponsorship_roi_report_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`payment_schedule` ADD CONSTRAINT `fk_sponsorship_payment_schedule_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`hospitality_entitlement` ADD CONSTRAINT `fk_sponsorship_hospitality_entitlement_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`hospitality_entitlement` ADD CONSTRAINT `fk_sponsorship_hospitality_entitlement_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`entitlement_redemption` ADD CONSTRAINT `fk_sponsorship_entitlement_redemption_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`entitlement_redemption` ADD CONSTRAINT `fk_sponsorship_entitlement_redemption_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`prospect` ADD CONSTRAINT `fk_sponsorship_prospect_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`prospect` ADD CONSTRAINT `fk_sponsorship_prospect_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`renewal` ADD CONSTRAINT `fk_sponsorship_renewal_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`asset_valuation` ADD CONSTRAINT `fk_sponsorship_asset_valuation_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`asset_valuation` ADD CONSTRAINT `fk_sponsorship_asset_valuation_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`asset_valuation` ADD CONSTRAINT `fk_sponsorship_asset_valuation_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`property` ADD CONSTRAINT `fk_sponsorship_property_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);

-- ========= sponsorship --> legal (17 constraint(s)) =========
-- Requires: sponsorship schema, legal schema
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal` ADD CONSTRAINT `fk_sponsorship_deal_contract_template_id` FOREIGN KEY (`contract_template_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`contract_template`(`contract_template_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal` ADD CONSTRAINT `fk_sponsorship_deal_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal` ADD CONSTRAINT `fk_sponsorship_deal_insurance_policy_id` FOREIGN KEY (`insurance_policy_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`insurance_policy`(`insurance_policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal` ADD CONSTRAINT `fk_sponsorship_deal_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal` ADD CONSTRAINT `fk_sponsorship_deal_nda_id` FOREIGN KEY (`nda_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`nda`(`nda_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal_term` ADD CONSTRAINT `fk_sponsorship_deal_term_contract_template_id` FOREIGN KEY (`contract_template_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`contract_template`(`contract_template_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal_amendment` ADD CONSTRAINT `fk_sponsorship_deal_amendment_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation` ADD CONSTRAINT `fk_sponsorship_sponsorship_activation_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`naming_right` ADD CONSTRAINT `fk_sponsorship_naming_right_board_resolution_id` FOREIGN KEY (`board_resolution_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`board_resolution`(`board_resolution_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`naming_right` ADD CONSTRAINT `fk_sponsorship_naming_right_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`naming_right` ADD CONSTRAINT `fk_sponsorship_naming_right_ip_portfolio_id` FOREIGN KEY (`ip_portfolio_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`ip_portfolio`(`ip_portfolio_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`jersey_sponsorship` ADD CONSTRAINT `fk_sponsorship_jersey_sponsorship_ip_portfolio_id` FOREIGN KEY (`ip_portfolio_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`ip_portfolio`(`ip_portfolio_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`broadcast_integration` ADD CONSTRAINT `fk_sponsorship_broadcast_integration_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`digital_partnership` ADD CONSTRAINT `fk_sponsorship_digital_partnership_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`prospect` ADD CONSTRAINT `fk_sponsorship_prospect_nda_id` FOREIGN KEY (`nda_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`nda`(`nda_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`property` ADD CONSTRAINT `fk_sponsorship_property_contract_template_id` FOREIGN KEY (`contract_template_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`contract_template`(`contract_template_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`property` ADD CONSTRAINT `fk_sponsorship_property_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);

-- ========= sponsorship --> merchandise (2 constraint(s)) =========
-- Requires: sponsorship schema, merchandise schema
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation` ADD CONSTRAINT `fk_sponsorship_sponsorship_activation_sku_catalog_id` FOREIGN KEY (`sku_catalog_id`) REFERENCES `sports_entertainment_ecm`.`merchandise`.`sku_catalog`(`sku_catalog_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`jersey_sponsorship` ADD CONSTRAINT `fk_sponsorship_jersey_sponsorship_sku_catalog_id` FOREIGN KEY (`sku_catalog_id`) REFERENCES `sports_entertainment_ecm`.`merchandise`.`sku_catalog`(`sku_catalog_id`);

-- ========= sponsorship --> partner (8 constraint(s)) =========
-- Requires: sponsorship schema, partner schema
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation` ADD CONSTRAINT `fk_sponsorship_sponsorship_activation_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`activation_fulfillment` ADD CONSTRAINT `fk_sponsorship_activation_fulfillment_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`jersey_sponsorship` ADD CONSTRAINT `fk_sponsorship_jersey_sponsorship_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`jersey_sponsorship` ADD CONSTRAINT `fk_sponsorship_jersey_sponsorship_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_ad_inventory` ADD CONSTRAINT `fk_sponsorship_sponsorship_ad_inventory_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`broadcast_integration` ADD CONSTRAINT `fk_sponsorship_broadcast_integration_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`digital_partnership` ADD CONSTRAINT `fk_sponsorship_digital_partnership_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`asset_valuation` ADD CONSTRAINT `fk_sponsorship_asset_valuation_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);

-- ========= sponsorship --> platform (14 constraint(s)) =========
-- Requires: sponsorship schema, platform schema
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation` ADD CONSTRAINT `fk_sponsorship_sponsorship_activation_fan_segment_id` FOREIGN KEY (`fan_segment_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`fan_segment`(`fan_segment_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`activation_fulfillment` ADD CONSTRAINT `fk_sponsorship_activation_fulfillment_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`naming_right` ADD CONSTRAINT `fk_sponsorship_naming_right_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_ad_inventory` ADD CONSTRAINT `fk_sponsorship_sponsorship_ad_inventory_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`broadcast_integration` ADD CONSTRAINT `fk_sponsorship_broadcast_integration_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`broadcast_integration` ADD CONSTRAINT `fk_sponsorship_broadcast_integration_sla_policy_id` FOREIGN KEY (`sla_policy_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`sla_policy`(`sla_policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`digital_partnership` ADD CONSTRAINT `fk_sponsorship_digital_partnership_api_integration_id` FOREIGN KEY (`api_integration_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`api_integration`(`api_integration_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`digital_partnership` ADD CONSTRAINT `fk_sponsorship_digital_partnership_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`digital_partnership` ADD CONSTRAINT `fk_sponsorship_digital_partnership_fan_segment_id` FOREIGN KEY (`fan_segment_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`fan_segment`(`fan_segment_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`digital_partnership` ADD CONSTRAINT `fk_sponsorship_digital_partnership_sla_policy_id` FOREIGN KEY (`sla_policy_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`sla_policy`(`sla_policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`performance_metric` ADD CONSTRAINT `fk_sponsorship_performance_metric_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`performance_metric` ADD CONSTRAINT `fk_sponsorship_performance_metric_fan_segment_id` FOREIGN KEY (`fan_segment_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`fan_segment`(`fan_segment_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`roi_report` ADD CONSTRAINT `fk_sponsorship_roi_report_fan_segment_id` FOREIGN KEY (`fan_segment_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`fan_segment`(`fan_segment_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`audience_targeting_allocation` ADD CONSTRAINT `fk_sponsorship_audience_targeting_allocation_fan_segment_id` FOREIGN KEY (`fan_segment_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`fan_segment`(`fan_segment_id`);

-- ========= sponsorship --> security (4 constraint(s)) =========
-- Requires: sponsorship schema, security schema
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation` ADD CONSTRAINT `fk_sponsorship_sponsorship_activation_access_zone_id` FOREIGN KEY (`access_zone_id`) REFERENCES `sports_entertainment_ecm`.`security`.`access_zone`(`access_zone_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`hospitality_entitlement` ADD CONSTRAINT `fk_sponsorship_hospitality_entitlement_access_zone_id` FOREIGN KEY (`access_zone_id`) REFERENCES `sports_entertainment_ecm`.`security`.`access_zone`(`access_zone_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`entitlement_redemption` ADD CONSTRAINT `fk_sponsorship_entitlement_redemption_access_zone_id` FOREIGN KEY (`access_zone_id`) REFERENCES `sports_entertainment_ecm`.`security`.`access_zone`(`access_zone_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`entitlement_redemption` ADD CONSTRAINT `fk_sponsorship_entitlement_redemption_credential_id` FOREIGN KEY (`credential_id`) REFERENCES `sports_entertainment_ecm`.`security`.`credential`(`credential_id`);

-- ========= sponsorship --> ticketing (7 constraint(s)) =========
-- Requires: sponsorship schema, ticketing schema
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation` ADD CONSTRAINT `fk_sponsorship_sponsorship_activation_promo_code_id` FOREIGN KEY (`promo_code_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`promo_code`(`promo_code_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`hospitality_entitlement` ADD CONSTRAINT `fk_sponsorship_hospitality_entitlement_hold_allocation_id` FOREIGN KEY (`hold_allocation_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`hold_allocation`(`hold_allocation_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`hospitality_entitlement` ADD CONSTRAINT `fk_sponsorship_hospitality_entitlement_parking_pass_id` FOREIGN KEY (`parking_pass_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`parking_pass`(`parking_pass_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`hospitality_entitlement` ADD CONSTRAINT `fk_sponsorship_hospitality_entitlement_ticket_order_id` FOREIGN KEY (`ticket_order_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`ticket_order`(`ticket_order_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`entitlement_redemption` ADD CONSTRAINT `fk_sponsorship_entitlement_redemption_access_entitlement_id` FOREIGN KEY (`access_entitlement_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`access_entitlement`(`access_entitlement_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`entitlement_redemption` ADD CONSTRAINT `fk_sponsorship_entitlement_redemption_parking_pass_id` FOREIGN KEY (`parking_pass_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`parking_pass`(`parking_pass_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`entitlement_redemption` ADD CONSTRAINT `fk_sponsorship_entitlement_redemption_ticket_order_id` FOREIGN KEY (`ticket_order_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`ticket_order`(`ticket_order_id`);

-- ========= sponsorship --> venue (13 constraint(s)) =========
-- Requires: sponsorship schema, venue schema
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal` ADD CONSTRAINT `fk_sponsorship_deal_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation` ADD CONSTRAINT `fk_sponsorship_sponsorship_activation_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`activation_fulfillment` ADD CONSTRAINT `fk_sponsorship_activation_fulfillment_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`naming_right` ADD CONSTRAINT `fk_sponsorship_naming_right_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_ad_inventory` ADD CONSTRAINT `fk_sponsorship_sponsorship_ad_inventory_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`inventory_allocation` ADD CONSTRAINT `fk_sponsorship_inventory_allocation_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`performance_metric` ADD CONSTRAINT `fk_sponsorship_performance_metric_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`hospitality_entitlement` ADD CONSTRAINT `fk_sponsorship_hospitality_entitlement_suite_id` FOREIGN KEY (`suite_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`suite`(`suite_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`hospitality_entitlement` ADD CONSTRAINT `fk_sponsorship_hospitality_entitlement_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`entitlement_redemption` ADD CONSTRAINT `fk_sponsorship_entitlement_redemption_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`asset_valuation` ADD CONSTRAINT `fk_sponsorship_asset_valuation_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`property` ADD CONSTRAINT `fk_sponsorship_property_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`inventory_unit` ADD CONSTRAINT `fk_sponsorship_inventory_unit_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);

-- ========= sponsorship --> workforce (21 constraint(s)) =========
-- Requires: sponsorship schema, workforce schema
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsor` ADD CONSTRAINT `fk_sponsorship_sponsor_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal` ADD CONSTRAINT `fk_sponsorship_deal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal_amendment` ADD CONSTRAINT `fk_sponsorship_deal_amendment_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`deal_amendment` ADD CONSTRAINT `fk_sponsorship_deal_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_activation` ADD CONSTRAINT `fk_sponsorship_sponsorship_activation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`activation_fulfillment` ADD CONSTRAINT `fk_sponsorship_activation_fulfillment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`naming_right` ADD CONSTRAINT `fk_sponsorship_naming_right_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`sponsorship_ad_inventory` ADD CONSTRAINT `fk_sponsorship_sponsorship_ad_inventory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`broadcast_integration` ADD CONSTRAINT `fk_sponsorship_broadcast_integration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`digital_partnership` ADD CONSTRAINT `fk_sponsorship_digital_partnership_account_manager_employee_id` FOREIGN KEY (`account_manager_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`digital_partnership` ADD CONSTRAINT `fk_sponsorship_digital_partnership_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`roi_report` ADD CONSTRAINT `fk_sponsorship_roi_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`hospitality_entitlement` ADD CONSTRAINT `fk_sponsorship_hospitality_entitlement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`hospitality_entitlement` ADD CONSTRAINT `fk_sponsorship_hospitality_entitlement_fulfilment_owner_employee_id` FOREIGN KEY (`fulfilment_owner_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`entitlement_redemption` ADD CONSTRAINT `fk_sponsorship_entitlement_redemption_account_manager_employee_id` FOREIGN KEY (`account_manager_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`entitlement_redemption` ADD CONSTRAINT `fk_sponsorship_entitlement_redemption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`prospect` ADD CONSTRAINT `fk_sponsorship_prospect_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`renewal` ADD CONSTRAINT `fk_sponsorship_renewal_account_manager_employee_id` FOREIGN KEY (`account_manager_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`renewal` ADD CONSTRAINT `fk_sponsorship_renewal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`asset_valuation` ADD CONSTRAINT `fk_sponsorship_asset_valuation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`sponsorship`.`property` ADD CONSTRAINT `fk_sponsorship_property_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= ticketing --> athlete (5 constraint(s)) =========
-- Requires: ticketing schema, athlete schema
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`dynamic_price_rule` ADD CONSTRAINT `fk_ticketing_dynamic_price_rule_performance_stat_id` FOREIGN KEY (`performance_stat_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`performance_stat`(`performance_stat_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`hold_allocation` ADD CONSTRAINT `fk_ticketing_hold_allocation_athlete_contract_id` FOREIGN KEY (`athlete_contract_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_contract`(`athlete_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`hold_allocation` ADD CONSTRAINT `fk_ticketing_hold_allocation_roster_id` FOREIGN KEY (`roster_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`roster`(`roster_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`promo_code` ADD CONSTRAINT `fk_ticketing_promo_code_nil_agreement_id` FOREIGN KEY (`nil_agreement_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`nil_agreement`(`nil_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`parking_pass` ADD CONSTRAINT `fk_ticketing_parking_pass_athlete_contract_id` FOREIGN KEY (`athlete_contract_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_contract`(`athlete_contract_id`);

-- ========= ticketing --> compliance (1 constraint(s)) =========
-- Requires: ticketing schema, compliance schema
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`venue_manifest` ADD CONSTRAINT `fk_ticketing_venue_manifest_license_permit_id` FOREIGN KEY (`license_permit_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`license_permit`(`license_permit_id`);

-- ========= ticketing --> content (8 constraint(s)) =========
-- Requires: ticketing schema, content schema
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_order` ADD CONSTRAINT `fk_ticketing_ticket_order_platform_channel_id` FOREIGN KEY (`platform_channel_id`) REFERENCES `sports_entertainment_ecm`.`content`.`platform_channel`(`platform_channel_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_order` ADD CONSTRAINT `fk_ticketing_ticket_order_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`season_ticket_account` ADD CONSTRAINT `fk_ticketing_season_ticket_account_platform_channel_id` FOREIGN KEY (`platform_channel_id`) REFERENCES `sports_entertainment_ecm`.`content`.`platform_channel`(`platform_channel_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`access_entitlement` ADD CONSTRAINT `fk_ticketing_access_entitlement_content_drm_policy_id` FOREIGN KEY (`content_drm_policy_id`) REFERENCES `sports_entertainment_ecm`.`content`.`content_drm_policy`(`content_drm_policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`access_entitlement` ADD CONSTRAINT `fk_ticketing_access_entitlement_content_license_id` FOREIGN KEY (`content_license_id`) REFERENCES `sports_entertainment_ecm`.`content`.`content_license`(`content_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`access_entitlement` ADD CONSTRAINT `fk_ticketing_access_entitlement_platform_channel_id` FOREIGN KEY (`platform_channel_id`) REFERENCES `sports_entertainment_ecm`.`content`.`platform_channel`(`platform_channel_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`access_entitlement` ADD CONSTRAINT `fk_ticketing_access_entitlement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`promo_code` ADD CONSTRAINT `fk_ticketing_promo_code_platform_channel_id` FOREIGN KEY (`platform_channel_id`) REFERENCES `sports_entertainment_ecm`.`content`.`platform_channel`(`platform_channel_id`);

-- ========= ticketing --> event (37 constraint(s)) =========
-- Requires: ticketing schema, event schema
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_inventory` ADD CONSTRAINT `fk_ticketing_ticket_inventory_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_inventory` ADD CONSTRAINT `fk_ticketing_ticket_inventory_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_inventory` ADD CONSTRAINT `fk_ticketing_ticket_inventory_pricing_id` FOREIGN KEY (`pricing_id`) REFERENCES `sports_entertainment_ecm`.`event`.`pricing`(`pricing_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_order` ADD CONSTRAINT `fk_ticketing_ticket_order_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_order` ADD CONSTRAINT `fk_ticketing_ticket_order_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_order` ADD CONSTRAINT `fk_ticketing_ticket_order_pricing_id` FOREIGN KEY (`pricing_id`) REFERENCES `sports_entertainment_ecm`.`event`.`pricing`(`pricing_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_order_line` ADD CONSTRAINT `fk_ticketing_ticket_order_line_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_order_line` ADD CONSTRAINT `fk_ticketing_ticket_order_line_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`price_tier` ADD CONSTRAINT `fk_ticketing_price_tier_event_type_id` FOREIGN KEY (`event_type_id`) REFERENCES `sports_entertainment_ecm`.`event`.`event_type`(`event_type_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`dynamic_price_rule` ADD CONSTRAINT `fk_ticketing_dynamic_price_rule_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`dynamic_price_rule` ADD CONSTRAINT `fk_ticketing_dynamic_price_rule_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`dynamic_price_rule` ADD CONSTRAINT `fk_ticketing_dynamic_price_rule_pricing_id` FOREIGN KEY (`pricing_id`) REFERENCES `sports_entertainment_ecm`.`event`.`pricing`(`pricing_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`season_ticket_package` ADD CONSTRAINT `fk_ticketing_season_ticket_package_calendar_id` FOREIGN KEY (`calendar_id`) REFERENCES `sports_entertainment_ecm`.`event`.`calendar`(`calendar_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`season_ticket_package` ADD CONSTRAINT `fk_ticketing_season_ticket_package_fixture_calendar_id` FOREIGN KEY (`fixture_calendar_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture_calendar`(`fixture_calendar_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`group_sale` ADD CONSTRAINT `fk_ticketing_group_sale_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`group_sale` ADD CONSTRAINT `fk_ticketing_group_sale_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`resale` ADD CONSTRAINT `fk_ticketing_resale_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`resale` ADD CONSTRAINT `fk_ticketing_resale_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`resale` ADD CONSTRAINT `fk_ticketing_resale_pricing_id` FOREIGN KEY (`pricing_id`) REFERENCES `sports_entertainment_ecm`.`event`.`pricing`(`pricing_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`access_entitlement` ADD CONSTRAINT `fk_ticketing_access_entitlement_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`access_entitlement` ADD CONSTRAINT `fk_ticketing_access_entitlement_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`gate_scan` ADD CONSTRAINT `fk_ticketing_gate_scan_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`gate_scan` ADD CONSTRAINT `fk_ticketing_gate_scan_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`gate_scan` ADD CONSTRAINT `fk_ticketing_gate_scan_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `sports_entertainment_ecm`.`event`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`refund` ADD CONSTRAINT `fk_ticketing_refund_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`refund` ADD CONSTRAINT `fk_ticketing_refund_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`refund` ADD CONSTRAINT `fk_ticketing_refund_status_history_id` FOREIGN KEY (`status_history_id`) REFERENCES `sports_entertainment_ecm`.`event`.`status_history`(`status_history_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`hold_allocation` ADD CONSTRAINT `fk_ticketing_hold_allocation_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`hold_allocation` ADD CONSTRAINT `fk_ticketing_hold_allocation_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`waitlist` ADD CONSTRAINT `fk_ticketing_waitlist_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`waitlist` ADD CONSTRAINT `fk_ticketing_waitlist_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_transfer` ADD CONSTRAINT `fk_ticketing_ticket_transfer_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_transfer` ADD CONSTRAINT `fk_ticketing_ticket_transfer_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`promo_code` ADD CONSTRAINT `fk_ticketing_promo_code_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`promo_code` ADD CONSTRAINT `fk_ticketing_promo_code_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`parking_pass` ADD CONSTRAINT `fk_ticketing_parking_pass_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`parking_pass` ADD CONSTRAINT `fk_ticketing_parking_pass_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);

-- ========= ticketing --> fan (28 constraint(s)) =========
-- Requires: ticketing schema, fan schema
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_order` ADD CONSTRAINT `fk_ticketing_ticket_order_fan_fan_profile_id` FOREIGN KEY (`fan_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_order` ADD CONSTRAINT `fk_ticketing_ticket_order_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_order_line` ADD CONSTRAINT `fk_ticketing_ticket_order_line_fan_fan_profile_id` FOREIGN KEY (`fan_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_order_line` ADD CONSTRAINT `fk_ticketing_ticket_order_line_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`season_ticket_package` ADD CONSTRAINT `fk_ticketing_season_ticket_package_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`season_ticket_account` ADD CONSTRAINT `fk_ticketing_season_ticket_account_account_id` FOREIGN KEY (`account_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`account`(`account_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`group_sale` ADD CONSTRAINT `fk_ticketing_group_sale_account_id` FOREIGN KEY (`account_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`account`(`account_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`resale` ADD CONSTRAINT `fk_ticketing_resale_buyer_fan_fan_profile_id` FOREIGN KEY (`buyer_fan_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`resale` ADD CONSTRAINT `fk_ticketing_resale_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`resale` ADD CONSTRAINT `fk_ticketing_resale_resale_buyer_fan_fan_profile_id` FOREIGN KEY (`resale_buyer_fan_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`resale` ADD CONSTRAINT `fk_ticketing_resale_resale_fan_profile_id` FOREIGN KEY (`resale_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`access_entitlement` ADD CONSTRAINT `fk_ticketing_access_entitlement_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`access_entitlement` ADD CONSTRAINT `fk_ticketing_access_entitlement_original_fan_fan_profile_id` FOREIGN KEY (`original_fan_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`access_entitlement` ADD CONSTRAINT `fk_ticketing_access_entitlement_primary_access_fan_profile_id` FOREIGN KEY (`primary_access_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`gate_scan` ADD CONSTRAINT `fk_ticketing_gate_scan_fan_fan_profile_id` FOREIGN KEY (`fan_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`gate_scan` ADD CONSTRAINT `fk_ticketing_gate_scan_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_payment` ADD CONSTRAINT `fk_ticketing_ticket_payment_fan_fan_profile_id` FOREIGN KEY (`fan_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_payment` ADD CONSTRAINT `fk_ticketing_ticket_payment_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`refund` ADD CONSTRAINT `fk_ticketing_refund_fan_fan_profile_id` FOREIGN KEY (`fan_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`refund` ADD CONSTRAINT `fk_ticketing_refund_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`hold_allocation` ADD CONSTRAINT `fk_ticketing_hold_allocation_club_id` FOREIGN KEY (`club_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`club`(`club_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`waitlist` ADD CONSTRAINT `fk_ticketing_waitlist_fan_fan_profile_id` FOREIGN KEY (`fan_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`waitlist` ADD CONSTRAINT `fk_ticketing_waitlist_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_transfer` ADD CONSTRAINT `fk_ticketing_ticket_transfer_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_transfer` ADD CONSTRAINT `fk_ticketing_ticket_transfer_primary_ticket_fan_profile_id` FOREIGN KEY (`primary_ticket_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_transfer` ADD CONSTRAINT `fk_ticketing_ticket_transfer_recipient_fan_fan_profile_id` FOREIGN KEY (`recipient_fan_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`parking_pass` ADD CONSTRAINT `fk_ticketing_parking_pass_fan_fan_profile_id` FOREIGN KEY (`fan_fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`parking_pass` ADD CONSTRAINT `fk_ticketing_parking_pass_fan_profile_id` FOREIGN KEY (`fan_profile_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`fan_profile`(`fan_profile_id`);

-- ========= ticketing --> finance (20 constraint(s)) =========
-- Requires: ticketing schema, finance schema
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_order` ADD CONSTRAINT `fk_ticketing_ticket_order_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_order` ADD CONSTRAINT `fk_ticketing_ticket_order_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_order_line` ADD CONSTRAINT `fk_ticketing_ticket_order_line_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`price_tier` ADD CONSTRAINT `fk_ticketing_price_tier_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`price_tier` ADD CONSTRAINT `fk_ticketing_price_tier_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`price_tier` ADD CONSTRAINT `fk_ticketing_price_tier_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`season_ticket_package` ADD CONSTRAINT `fk_ticketing_season_ticket_package_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`season_ticket_package` ADD CONSTRAINT `fk_ticketing_season_ticket_package_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`group_sale` ADD CONSTRAINT `fk_ticketing_group_sale_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`group_sale` ADD CONSTRAINT `fk_ticketing_group_sale_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`resale` ADD CONSTRAINT `fk_ticketing_resale_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`resale` ADD CONSTRAINT `fk_ticketing_resale_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_payment` ADD CONSTRAINT `fk_ticketing_ticket_payment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`refund` ADD CONSTRAINT `fk_ticketing_refund_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`refund` ADD CONSTRAINT `fk_ticketing_refund_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`hold_allocation` ADD CONSTRAINT `fk_ticketing_hold_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`promo_code` ADD CONSTRAINT `fk_ticketing_promo_code_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`promo_code` ADD CONSTRAINT `fk_ticketing_promo_code_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`parking_pass` ADD CONSTRAINT `fk_ticketing_parking_pass_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`parking_pass` ADD CONSTRAINT `fk_ticketing_parking_pass_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= ticketing --> league (27 constraint(s)) =========
-- Requires: ticketing schema, league schema
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`price_tier` ADD CONSTRAINT `fk_ticketing_price_tier_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`price_tier` ADD CONSTRAINT `fk_ticketing_price_tier_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`price_tier` ADD CONSTRAINT `fk_ticketing_price_tier_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`dynamic_price_rule` ADD CONSTRAINT `fk_ticketing_dynamic_price_rule_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`dynamic_price_rule` ADD CONSTRAINT `fk_ticketing_dynamic_price_rule_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`dynamic_price_rule` ADD CONSTRAINT `fk_ticketing_dynamic_price_rule_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`season_ticket_package` ADD CONSTRAINT `fk_ticketing_season_ticket_package_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`season_ticket_package` ADD CONSTRAINT `fk_ticketing_season_ticket_package_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`season_ticket_package` ADD CONSTRAINT `fk_ticketing_season_ticket_package_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`season_ticket_package` ADD CONSTRAINT `fk_ticketing_season_ticket_package_team_franchise_id` FOREIGN KEY (`team_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`season_ticket_account` ADD CONSTRAINT `fk_ticketing_season_ticket_account_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`season_ticket_account` ADD CONSTRAINT `fk_ticketing_season_ticket_account_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`group_sale` ADD CONSTRAINT `fk_ticketing_group_sale_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`group_sale` ADD CONSTRAINT `fk_ticketing_group_sale_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`resale` ADD CONSTRAINT `fk_ticketing_resale_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`resale` ADD CONSTRAINT `fk_ticketing_resale_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`refund` ADD CONSTRAINT `fk_ticketing_refund_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`hold_allocation` ADD CONSTRAINT `fk_ticketing_hold_allocation_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`hold_allocation` ADD CONSTRAINT `fk_ticketing_hold_allocation_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`waitlist` ADD CONSTRAINT `fk_ticketing_waitlist_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`waitlist` ADD CONSTRAINT `fk_ticketing_waitlist_league_id` FOREIGN KEY (`league_id`) REFERENCES `sports_entertainment_ecm`.`league`.`league`(`league_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`waitlist` ADD CONSTRAINT `fk_ticketing_waitlist_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`waitlist` ADD CONSTRAINT `fk_ticketing_waitlist_team_franchise_id` FOREIGN KEY (`team_franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`venue_manifest` ADD CONSTRAINT `fk_ticketing_venue_manifest_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`venue_manifest` ADD CONSTRAINT `fk_ticketing_venue_manifest_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`promo_code` ADD CONSTRAINT `fk_ticketing_promo_code_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`promo_code` ADD CONSTRAINT `fk_ticketing_promo_code_season_id` FOREIGN KEY (`season_id`) REFERENCES `sports_entertainment_ecm`.`league`.`season`(`season_id`);

-- ========= ticketing --> legal (6 constraint(s)) =========
-- Requires: ticketing schema, legal schema
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`group_sale` ADD CONSTRAINT `fk_ticketing_group_sale_nda_id` FOREIGN KEY (`nda_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`nda`(`nda_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`hold_allocation` ADD CONSTRAINT `fk_ticketing_hold_allocation_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`hold`(`hold_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`hold_allocation` ADD CONSTRAINT `fk_ticketing_hold_allocation_contract_obligation_id` FOREIGN KEY (`contract_obligation_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`contract_obligation`(`contract_obligation_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`venue_manifest` ADD CONSTRAINT `fk_ticketing_venue_manifest_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`promo_code` ADD CONSTRAINT `fk_ticketing_promo_code_contract_obligation_id` FOREIGN KEY (`contract_obligation_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`contract_obligation`(`contract_obligation_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`promo_code` ADD CONSTRAINT `fk_ticketing_promo_code_ip_portfolio_id` FOREIGN KEY (`ip_portfolio_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`ip_portfolio`(`ip_portfolio_id`);

-- ========= ticketing --> merchandise (2 constraint(s)) =========
-- Requires: ticketing schema, merchandise schema
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_order_line` ADD CONSTRAINT `fk_ticketing_ticket_order_line_sku_catalog_id` FOREIGN KEY (`sku_catalog_id`) REFERENCES `sports_entertainment_ecm`.`merchandise`.`sku_catalog`(`sku_catalog_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`season_ticket_package` ADD CONSTRAINT `fk_ticketing_season_ticket_package_sku_catalog_id` FOREIGN KEY (`sku_catalog_id`) REFERENCES `sports_entertainment_ecm`.`merchandise`.`sku_catalog`(`sku_catalog_id`);

-- ========= ticketing --> partner (7 constraint(s)) =========
-- Requires: ticketing schema, partner schema
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_order` ADD CONSTRAINT `fk_ticketing_ticket_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`dynamic_price_rule` ADD CONSTRAINT `fk_ticketing_dynamic_price_rule_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`group_sale` ADD CONSTRAINT `fk_ticketing_group_sale_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`resale` ADD CONSTRAINT `fk_ticketing_resale_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_payment` ADD CONSTRAINT `fk_ticketing_ticket_payment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`hold_allocation` ADD CONSTRAINT `fk_ticketing_hold_allocation_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`parking_pass` ADD CONSTRAINT `fk_ticketing_parking_pass_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);

-- ========= ticketing --> platform (11 constraint(s)) =========
-- Requires: ticketing schema, platform schema
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_order` ADD CONSTRAINT `fk_ticketing_ticket_order_ab_test_id` FOREIGN KEY (`ab_test_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`ab_test`(`ab_test_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_order` ADD CONSTRAINT `fk_ticketing_ticket_order_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`dynamic_price_rule` ADD CONSTRAINT `fk_ticketing_dynamic_price_rule_fan_segment_id` FOREIGN KEY (`fan_segment_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`fan_segment`(`fan_segment_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`season_ticket_account` ADD CONSTRAINT `fk_ticketing_season_ticket_account_digital_subscription_id` FOREIGN KEY (`digital_subscription_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_subscription`(`digital_subscription_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`resale` ADD CONSTRAINT `fk_ticketing_resale_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`gate_scan` ADD CONSTRAINT `fk_ticketing_gate_scan_device_registration_id` FOREIGN KEY (`device_registration_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`device_registration`(`device_registration_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_payment` ADD CONSTRAINT `fk_ticketing_ticket_payment_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`hold_allocation` ADD CONSTRAINT `fk_ticketing_hold_allocation_notification_campaign_id` FOREIGN KEY (`notification_campaign_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`notification_campaign`(`notification_campaign_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`promo_code` ADD CONSTRAINT `fk_ticketing_promo_code_notification_campaign_id` FOREIGN KEY (`notification_campaign_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`notification_campaign`(`notification_campaign_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`promo_code` ADD CONSTRAINT `fk_ticketing_promo_code_fan_segment_id` FOREIGN KEY (`fan_segment_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`fan_segment`(`fan_segment_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`presale_access` ADD CONSTRAINT `fk_ticketing_presale_access_fan_segment_id` FOREIGN KEY (`fan_segment_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`fan_segment`(`fan_segment_id`);

-- ========= ticketing --> security (9 constraint(s)) =========
-- Requires: ticketing schema, security schema
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_inventory` ADD CONSTRAINT `fk_ticketing_ticket_inventory_access_zone_id` FOREIGN KEY (`access_zone_id`) REFERENCES `sports_entertainment_ecm`.`security`.`access_zone`(`access_zone_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`access_entitlement` ADD CONSTRAINT `fk_ticketing_access_entitlement_access_zone_id` FOREIGN KEY (`access_zone_id`) REFERENCES `sports_entertainment_ecm`.`security`.`access_zone`(`access_zone_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`access_entitlement` ADD CONSTRAINT `fk_ticketing_access_entitlement_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `sports_entertainment_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`gate_scan` ADD CONSTRAINT `fk_ticketing_gate_scan_access_zone_id` FOREIGN KEY (`access_zone_id`) REFERENCES `sports_entertainment_ecm`.`security`.`access_zone`(`access_zone_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`gate_scan` ADD CONSTRAINT `fk_ticketing_gate_scan_screening_checkpoint_id` FOREIGN KEY (`screening_checkpoint_id`) REFERENCES `sports_entertainment_ecm`.`security`.`screening_checkpoint`(`screening_checkpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`refund` ADD CONSTRAINT `fk_ticketing_refund_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `sports_entertainment_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`venue_manifest` ADD CONSTRAINT `fk_ticketing_venue_manifest_access_zone_id` FOREIGN KEY (`access_zone_id`) REFERENCES `sports_entertainment_ecm`.`security`.`access_zone`(`access_zone_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`parking_pass` ADD CONSTRAINT `fk_ticketing_parking_pass_access_zone_id` FOREIGN KEY (`access_zone_id`) REFERENCES `sports_entertainment_ecm`.`security`.`access_zone`(`access_zone_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`parking_pass` ADD CONSTRAINT `fk_ticketing_parking_pass_screening_checkpoint_id` FOREIGN KEY (`screening_checkpoint_id`) REFERENCES `sports_entertainment_ecm`.`security`.`screening_checkpoint`(`screening_checkpoint_id`);

-- ========= ticketing --> sponsorship (5 constraint(s)) =========
-- Requires: ticketing schema, sponsorship schema
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`access_entitlement` ADD CONSTRAINT `fk_ticketing_access_entitlement_hospitality_entitlement_id` FOREIGN KEY (`hospitality_entitlement_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`hospitality_entitlement`(`hospitality_entitlement_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`hold_allocation` ADD CONSTRAINT `fk_ticketing_hold_allocation_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`deal`(`deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`hold_allocation` ADD CONSTRAINT `fk_ticketing_hold_allocation_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`sponsor`(`sponsor_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`promo_code` ADD CONSTRAINT `fk_ticketing_promo_code_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`deal`(`deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`promo_code` ADD CONSTRAINT `fk_ticketing_promo_code_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`sponsor`(`sponsor_id`);

-- ========= ticketing --> venue (30 constraint(s)) =========
-- Requires: ticketing schema, venue schema
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_inventory` ADD CONSTRAINT `fk_ticketing_ticket_inventory_capacity_config_id` FOREIGN KEY (`capacity_config_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`capacity_config`(`capacity_config_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_inventory` ADD CONSTRAINT `fk_ticketing_ticket_inventory_seat_id` FOREIGN KEY (`seat_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`seat`(`seat_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_inventory` ADD CONSTRAINT `fk_ticketing_ticket_inventory_seating_section_id` FOREIGN KEY (`seating_section_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`seating_section`(`seating_section_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_inventory` ADD CONSTRAINT `fk_ticketing_ticket_inventory_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_order` ADD CONSTRAINT `fk_ticketing_ticket_order_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_order_line` ADD CONSTRAINT `fk_ticketing_ticket_order_line_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`price_tier` ADD CONSTRAINT `fk_ticketing_price_tier_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`dynamic_price_rule` ADD CONSTRAINT `fk_ticketing_dynamic_price_rule_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`season_ticket_package` ADD CONSTRAINT `fk_ticketing_season_ticket_package_seating_section_id` FOREIGN KEY (`seating_section_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`seating_section`(`seating_section_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`season_ticket_package` ADD CONSTRAINT `fk_ticketing_season_ticket_package_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`season_ticket_account` ADD CONSTRAINT `fk_ticketing_season_ticket_account_seating_section_id` FOREIGN KEY (`seating_section_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`seating_section`(`seating_section_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`season_ticket_account` ADD CONSTRAINT `fk_ticketing_season_ticket_account_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`group_sale` ADD CONSTRAINT `fk_ticketing_group_sale_seating_section_id` FOREIGN KEY (`seating_section_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`seating_section`(`seating_section_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`group_sale` ADD CONSTRAINT `fk_ticketing_group_sale_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`resale` ADD CONSTRAINT `fk_ticketing_resale_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`access_entitlement` ADD CONSTRAINT `fk_ticketing_access_entitlement_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`gate_scan` ADD CONSTRAINT `fk_ticketing_gate_scan_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`hold_allocation` ADD CONSTRAINT `fk_ticketing_hold_allocation_capacity_config_id` FOREIGN KEY (`capacity_config_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`capacity_config`(`capacity_config_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`hold_allocation` ADD CONSTRAINT `fk_ticketing_hold_allocation_seating_section_id` FOREIGN KEY (`seating_section_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`seating_section`(`seating_section_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`hold_allocation` ADD CONSTRAINT `fk_ticketing_hold_allocation_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`waitlist` ADD CONSTRAINT `fk_ticketing_waitlist_seating_section_id` FOREIGN KEY (`seating_section_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`seating_section`(`seating_section_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`waitlist` ADD CONSTRAINT `fk_ticketing_waitlist_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`venue_manifest` ADD CONSTRAINT `fk_ticketing_venue_manifest_capacity_config_id` FOREIGN KEY (`capacity_config_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`capacity_config`(`capacity_config_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`venue_manifest` ADD CONSTRAINT `fk_ticketing_venue_manifest_seating_section_id` FOREIGN KEY (`seating_section_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`seating_section`(`seating_section_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`venue_manifest` ADD CONSTRAINT `fk_ticketing_venue_manifest_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_transfer` ADD CONSTRAINT `fk_ticketing_ticket_transfer_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`promo_code` ADD CONSTRAINT `fk_ticketing_promo_code_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`parking_pass` ADD CONSTRAINT `fk_ticketing_parking_pass_parking_lot_id` FOREIGN KEY (`parking_lot_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`parking_lot`(`parking_lot_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`parking_pass` ADD CONSTRAINT `fk_ticketing_parking_pass_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`price_zone` ADD CONSTRAINT `fk_ticketing_price_zone_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);

-- ========= ticketing --> workforce (13 constraint(s)) =========
-- Requires: ticketing schema, workforce schema
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_order` ADD CONSTRAINT `fk_ticketing_ticket_order_cashier_agent_employee_id` FOREIGN KEY (`cashier_agent_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`ticket_order` ADD CONSTRAINT `fk_ticketing_ticket_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`dynamic_price_rule` ADD CONSTRAINT `fk_ticketing_dynamic_price_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`season_ticket_account` ADD CONSTRAINT `fk_ticketing_season_ticket_account_account_rep_employee_id` FOREIGN KEY (`account_rep_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`season_ticket_account` ADD CONSTRAINT `fk_ticketing_season_ticket_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`group_sale` ADD CONSTRAINT `fk_ticketing_group_sale_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`group_sale` ADD CONSTRAINT `fk_ticketing_group_sale_sales_rep_employee_id` FOREIGN KEY (`sales_rep_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`gate_scan` ADD CONSTRAINT `fk_ticketing_gate_scan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`gate_scan` ADD CONSTRAINT `fk_ticketing_gate_scan_operator_employee_id` FOREIGN KEY (`operator_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`refund` ADD CONSTRAINT `fk_ticketing_refund_approval_agent_employee_id` FOREIGN KEY (`approval_agent_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`refund` ADD CONSTRAINT `fk_ticketing_refund_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`hold_allocation` ADD CONSTRAINT `fk_ticketing_hold_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`ticketing`.`promo_code` ADD CONSTRAINT `fk_ticketing_promo_code_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= venue --> athlete (2 constraint(s)) =========
-- Requires: venue schema, athlete schema
ALTER TABLE `sports_entertainment_ecm`.`venue`.`suite_license` ADD CONSTRAINT `fk_venue_suite_license_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`rental` ADD CONSTRAINT `fk_venue_rental_athlete_contract_id` FOREIGN KEY (`athlete_contract_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_contract`(`athlete_contract_id`);

-- ========= venue --> broadcast (2 constraint(s)) =========
-- Requires: venue schema, broadcast schema
ALTER TABLE `sports_entertainment_ecm`.`venue`.`event_day_ops` ADD CONSTRAINT `fk_venue_event_day_ops_production_id` FOREIGN KEY (`production_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`production`(`production_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`operational_readiness` ADD CONSTRAINT `fk_venue_operational_readiness_production_id` FOREIGN KEY (`production_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`production`(`production_id`);

-- ========= venue --> compliance (10 constraint(s)) =========
-- Requires: venue schema, compliance schema
ALTER TABLE `sports_entertainment_ecm`.`venue`.`maintenance_work_order` ADD CONSTRAINT `fk_venue_maintenance_work_order_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`maintenance_work_order` ADD CONSTRAINT `fk_venue_maintenance_work_order_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`safety_inspection` ADD CONSTRAINT `fk_venue_safety_inspection_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`safety_inspection` ADD CONSTRAINT `fk_venue_safety_inspection_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`safety_incident` ADD CONSTRAINT `fk_venue_safety_incident_incident_report_id` FOREIGN KEY (`incident_report_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`incident_report`(`incident_report_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`safety_incident` ADD CONSTRAINT `fk_venue_safety_incident_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`event_day_ops` ADD CONSTRAINT `fk_venue_event_day_ops_incident_report_id` FOREIGN KEY (`incident_report_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`incident_report`(`incident_report_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`accessibility_feature` ADD CONSTRAINT `fk_venue_accessibility_feature_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`operational_readiness` ADD CONSTRAINT `fk_venue_operational_readiness_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`facility_obligation_applicability` ADD CONSTRAINT `fk_venue_facility_obligation_applicability_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`obligation`(`obligation_id`);

-- ========= venue --> content (3 constraint(s)) =========
-- Requires: venue schema, content schema
ALTER TABLE `sports_entertainment_ecm`.`venue`.`safety_inspection` ADD CONSTRAINT `fk_venue_safety_inspection_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`safety_incident` ADD CONSTRAINT `fk_venue_safety_incident_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`content_placement` ADD CONSTRAINT `fk_venue_content_placement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `sports_entertainment_ecm`.`content`.`asset`(`asset_id`);

-- ========= venue --> event (18 constraint(s)) =========
-- Requires: venue schema, event schema
ALTER TABLE `sports_entertainment_ecm`.`venue`.`maintenance_work_order` ADD CONSTRAINT `fk_venue_maintenance_work_order_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`maintenance_work_order` ADD CONSTRAINT `fk_venue_maintenance_work_order_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`safety_inspection` ADD CONSTRAINT `fk_venue_safety_inspection_calendar_id` FOREIGN KEY (`calendar_id`) REFERENCES `sports_entertainment_ecm`.`event`.`calendar`(`calendar_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`safety_inspection` ADD CONSTRAINT `fk_venue_safety_inspection_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`safety_inspection` ADD CONSTRAINT `fk_venue_safety_inspection_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`safety_incident` ADD CONSTRAINT `fk_venue_safety_incident_calendar_id` FOREIGN KEY (`calendar_id`) REFERENCES `sports_entertainment_ecm`.`event`.`calendar`(`calendar_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`safety_incident` ADD CONSTRAINT `fk_venue_safety_incident_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`safety_incident` ADD CONSTRAINT `fk_venue_safety_incident_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`event_day_ops` ADD CONSTRAINT `fk_venue_event_day_ops_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`event_day_ops` ADD CONSTRAINT `fk_venue_event_day_ops_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`concession_transaction` ADD CONSTRAINT `fk_venue_concession_transaction_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`concession_transaction` ADD CONSTRAINT `fk_venue_concession_transaction_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`suite_license` ADD CONSTRAINT `fk_venue_suite_license_calendar_id` FOREIGN KEY (`calendar_id`) REFERENCES `sports_entertainment_ecm`.`event`.`calendar`(`calendar_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`rental` ADD CONSTRAINT `fk_venue_rental_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`operational_readiness` ADD CONSTRAINT `fk_venue_operational_readiness_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`operational_readiness` ADD CONSTRAINT `fk_venue_operational_readiness_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`staff_plan` ADD CONSTRAINT `fk_venue_staff_plan_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`staff_plan` ADD CONSTRAINT `fk_venue_staff_plan_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);

-- ========= venue --> fan (3 constraint(s)) =========
-- Requires: venue schema, fan schema
ALTER TABLE `sports_entertainment_ecm`.`venue`.`concession_transaction` ADD CONSTRAINT `fk_venue_concession_transaction_loyalty_enrollment_id` FOREIGN KEY (`loyalty_enrollment_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`loyalty_enrollment`(`loyalty_enrollment_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`concession_transaction` ADD CONSTRAINT `fk_venue_concession_transaction_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`membership`(`membership_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`suite_license` ADD CONSTRAINT `fk_venue_suite_license_account_id` FOREIGN KEY (`account_id`) REFERENCES `sports_entertainment_ecm`.`fan`.`account`(`account_id`);

-- ========= venue --> finance (21 constraint(s)) =========
-- Requires: venue schema, finance schema
ALTER TABLE `sports_entertainment_ecm`.`venue`.`facility` ADD CONSTRAINT `fk_venue_facility_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`facility` ADD CONSTRAINT `fk_venue_facility_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`capacity_config` ADD CONSTRAINT `fk_venue_capacity_config_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`bms_system` ADD CONSTRAINT `fk_venue_bms_system_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`bms_system` ADD CONSTRAINT `fk_venue_bms_system_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`maintenance_work_order` ADD CONSTRAINT `fk_venue_maintenance_work_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`maintenance_work_order` ADD CONSTRAINT `fk_venue_maintenance_work_order_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`maintenance_work_order` ADD CONSTRAINT `fk_venue_maintenance_work_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`maintenance_work_order` ADD CONSTRAINT `fk_venue_maintenance_work_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`concession_stand` ADD CONSTRAINT `fk_venue_concession_stand_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`concession_stand` ADD CONSTRAINT `fk_venue_concession_stand_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`concession_stand` ADD CONSTRAINT `fk_venue_concession_stand_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`concession_stand` ADD CONSTRAINT `fk_venue_concession_stand_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`concession_transaction` ADD CONSTRAINT `fk_venue_concession_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`concession_transaction` ADD CONSTRAINT `fk_venue_concession_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`concession_transaction` ADD CONSTRAINT `fk_venue_concession_transaction_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`suite` ADD CONSTRAINT `fk_venue_suite_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`accessibility_feature` ADD CONSTRAINT `fk_venue_accessibility_feature_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`rental` ADD CONSTRAINT `fk_venue_rental_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`staff_plan` ADD CONSTRAINT `fk_venue_staff_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`venue` ADD CONSTRAINT `fk_venue_venue_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= venue --> gaming (1 constraint(s)) =========
-- Requires: venue schema, gaming schema
ALTER TABLE `sports_entertainment_ecm`.`venue`.`facility` ADD CONSTRAINT `fk_venue_facility_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`jurisdiction`(`jurisdiction_id`);

-- ========= venue --> league (6 constraint(s)) =========
-- Requires: venue schema, league schema
ALTER TABLE `sports_entertainment_ecm`.`venue`.`parking_lot` ADD CONSTRAINT `fk_venue_parking_lot_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`maintenance_work_order` ADD CONSTRAINT `fk_venue_maintenance_work_order_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`safety_inspection` ADD CONSTRAINT `fk_venue_safety_inspection_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`suite_license` ADD CONSTRAINT `fk_venue_suite_license_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`rental` ADD CONSTRAINT `fk_venue_rental_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`tenancy` ADD CONSTRAINT `fk_venue_tenancy_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);

-- ========= venue --> legal (6 constraint(s)) =========
-- Requires: venue schema, legal schema
ALTER TABLE `sports_entertainment_ecm`.`venue`.`facility` ADD CONSTRAINT `fk_venue_facility_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`safety_inspection` ADD CONSTRAINT `fk_venue_safety_inspection_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`concession_stand` ADD CONSTRAINT `fk_venue_concession_stand_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`suite_license` ADD CONSTRAINT `fk_venue_suite_license_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`rental` ADD CONSTRAINT `fk_venue_rental_insurance_policy_id` FOREIGN KEY (`insurance_policy_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`insurance_policy`(`insurance_policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`rental` ADD CONSTRAINT `fk_venue_rental_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);

-- ========= venue --> partner (16 constraint(s)) =========
-- Requires: venue schema, partner schema
ALTER TABLE `sports_entertainment_ecm`.`venue`.`parking_lot` ADD CONSTRAINT `fk_venue_parking_lot_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`parking_lot` ADD CONSTRAINT `fk_venue_parking_lot_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`bms_system` ADD CONSTRAINT `fk_venue_bms_system_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`bms_system` ADD CONSTRAINT `fk_venue_bms_system_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`maintenance_work_order` ADD CONSTRAINT `fk_venue_maintenance_work_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`maintenance_work_order` ADD CONSTRAINT `fk_venue_maintenance_work_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`safety_inspection` ADD CONSTRAINT `fk_venue_safety_inspection_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`concession_stand` ADD CONSTRAINT `fk_venue_concession_stand_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`concession_stand` ADD CONSTRAINT `fk_venue_concession_stand_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`accessibility_feature` ADD CONSTRAINT `fk_venue_accessibility_feature_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`staff_plan` ADD CONSTRAINT `fk_venue_staff_plan_staffing_agency_vendor_id` FOREIGN KEY (`staffing_agency_vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`staff_plan` ADD CONSTRAINT `fk_venue_staff_plan_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`staff_plan` ADD CONSTRAINT `fk_venue_staff_plan_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`facility_vendor_engagement` ADD CONSTRAINT `fk_venue_facility_vendor_engagement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`menu` ADD CONSTRAINT `fk_venue_menu_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`maintenance_plan` ADD CONSTRAINT `fk_venue_maintenance_plan_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);

-- ========= venue --> platform (5 constraint(s)) =========
-- Requires: venue schema, platform schema
ALTER TABLE `sports_entertainment_ecm`.`venue`.`maintenance_work_order` ADD CONSTRAINT `fk_venue_maintenance_work_order_sla_incident_id` FOREIGN KEY (`sla_incident_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`sla_incident`(`sla_incident_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`event_day_ops` ADD CONSTRAINT `fk_venue_event_day_ops_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`concession_stand` ADD CONSTRAINT `fk_venue_concession_stand_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`concession_transaction` ADD CONSTRAINT `fk_venue_concession_transaction_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`rental` ADD CONSTRAINT `fk_venue_rental_digital_touchpoint_id` FOREIGN KEY (`digital_touchpoint_id`) REFERENCES `sports_entertainment_ecm`.`platform`.`digital_touchpoint`(`digital_touchpoint_id`);

-- ========= venue --> security (18 constraint(s)) =========
-- Requires: venue schema, security schema
ALTER TABLE `sports_entertainment_ecm`.`venue`.`seating_section` ADD CONSTRAINT `fk_venue_seating_section_access_zone_id` FOREIGN KEY (`access_zone_id`) REFERENCES `sports_entertainment_ecm`.`security`.`access_zone`(`access_zone_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`parking_lot` ADD CONSTRAINT `fk_venue_parking_lot_access_zone_id` FOREIGN KEY (`access_zone_id`) REFERENCES `sports_entertainment_ecm`.`security`.`access_zone`(`access_zone_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`parking_lot` ADD CONSTRAINT `fk_venue_parking_lot_screening_checkpoint_id` FOREIGN KEY (`screening_checkpoint_id`) REFERENCES `sports_entertainment_ecm`.`security`.`screening_checkpoint`(`screening_checkpoint_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`maintenance_work_order` ADD CONSTRAINT `fk_venue_maintenance_work_order_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `sports_entertainment_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`safety_incident` ADD CONSTRAINT `fk_venue_safety_incident_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `sports_entertainment_ecm`.`security`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`safety_incident` ADD CONSTRAINT `fk_venue_safety_incident_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `sports_entertainment_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`event_day_ops` ADD CONSTRAINT `fk_venue_event_day_ops_crowd_management_plan_id` FOREIGN KEY (`crowd_management_plan_id`) REFERENCES `sports_entertainment_ecm`.`security`.`crowd_management_plan`(`crowd_management_plan_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`event_day_ops` ADD CONSTRAINT `fk_venue_event_day_ops_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `sports_entertainment_ecm`.`security`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`event_day_ops` ADD CONSTRAINT `fk_venue_event_day_ops_staffing_plan_id` FOREIGN KEY (`staffing_plan_id`) REFERENCES `sports_entertainment_ecm`.`security`.`staffing_plan`(`staffing_plan_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`concession_stand` ADD CONSTRAINT `fk_venue_concession_stand_access_zone_id` FOREIGN KEY (`access_zone_id`) REFERENCES `sports_entertainment_ecm`.`security`.`access_zone`(`access_zone_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`suite` ADD CONSTRAINT `fk_venue_suite_access_zone_id` FOREIGN KEY (`access_zone_id`) REFERENCES `sports_entertainment_ecm`.`security`.`access_zone`(`access_zone_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`accessibility_feature` ADD CONSTRAINT `fk_venue_accessibility_feature_access_zone_id` FOREIGN KEY (`access_zone_id`) REFERENCES `sports_entertainment_ecm`.`security`.`access_zone`(`access_zone_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`rental` ADD CONSTRAINT `fk_venue_rental_crowd_management_plan_id` FOREIGN KEY (`crowd_management_plan_id`) REFERENCES `sports_entertainment_ecm`.`security`.`crowd_management_plan`(`crowd_management_plan_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`rental` ADD CONSTRAINT `fk_venue_rental_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `sports_entertainment_ecm`.`security`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`operational_readiness` ADD CONSTRAINT `fk_venue_operational_readiness_crowd_management_plan_id` FOREIGN KEY (`crowd_management_plan_id`) REFERENCES `sports_entertainment_ecm`.`security`.`crowd_management_plan`(`crowd_management_plan_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`operational_readiness` ADD CONSTRAINT `fk_venue_operational_readiness_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `sports_entertainment_ecm`.`security`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`operational_readiness` ADD CONSTRAINT `fk_venue_operational_readiness_staffing_plan_id` FOREIGN KEY (`staffing_plan_id`) REFERENCES `sports_entertainment_ecm`.`security`.`staffing_plan`(`staffing_plan_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`staff_plan` ADD CONSTRAINT `fk_venue_staff_plan_staffing_plan_id` FOREIGN KEY (`staffing_plan_id`) REFERENCES `sports_entertainment_ecm`.`security`.`staffing_plan`(`staffing_plan_id`);

-- ========= venue --> sponsorship (5 constraint(s)) =========
-- Requires: venue schema, sponsorship schema
ALTER TABLE `sports_entertainment_ecm`.`venue`.`seating_section` ADD CONSTRAINT `fk_venue_seating_section_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`deal`(`deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`concession_stand` ADD CONSTRAINT `fk_venue_concession_stand_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`sponsor`(`sponsor_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`suite_license` ADD CONSTRAINT `fk_venue_suite_license_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`deal`(`deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`rental` ADD CONSTRAINT `fk_venue_rental_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`deal`(`deal_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`venue_activation` ADD CONSTRAINT `fk_venue_venue_activation_deal_id` FOREIGN KEY (`deal_id`) REFERENCES `sports_entertainment_ecm`.`sponsorship`.`deal`(`deal_id`);

-- ========= venue --> ticketing (4 constraint(s)) =========
-- Requires: venue schema, ticketing schema
ALTER TABLE `sports_entertainment_ecm`.`venue`.`event_day_ops` ADD CONSTRAINT `fk_venue_event_day_ops_venue_manifest_id` FOREIGN KEY (`venue_manifest_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`venue_manifest`(`venue_manifest_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`suite_license` ADD CONSTRAINT `fk_venue_suite_license_season_ticket_package_id` FOREIGN KEY (`season_ticket_package_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`season_ticket_package`(`season_ticket_package_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`operational_readiness` ADD CONSTRAINT `fk_venue_operational_readiness_venue_manifest_id` FOREIGN KEY (`venue_manifest_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`venue_manifest`(`venue_manifest_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`section_pricing_assignment` ADD CONSTRAINT `fk_venue_section_pricing_assignment_price_tier_id` FOREIGN KEY (`price_tier_id`) REFERENCES `sports_entertainment_ecm`.`ticketing`.`price_tier`(`price_tier_id`);

-- ========= venue --> workforce (19 constraint(s)) =========
-- Requires: venue schema, workforce schema
ALTER TABLE `sports_entertainment_ecm`.`venue`.`facility` ADD CONSTRAINT `fk_venue_facility_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`capacity_config` ADD CONSTRAINT `fk_venue_capacity_config_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`maintenance_work_order` ADD CONSTRAINT `fk_venue_maintenance_work_order_approved_by_manager_employee_id` FOREIGN KEY (`approved_by_manager_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`maintenance_work_order` ADD CONSTRAINT `fk_venue_maintenance_work_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`maintenance_work_order` ADD CONSTRAINT `fk_venue_maintenance_work_order_primary_maintenance_requested_by_employee_id` FOREIGN KEY (`primary_maintenance_requested_by_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`maintenance_work_order` ADD CONSTRAINT `fk_venue_maintenance_work_order_tertiary_maintenance_approved_by_manager_employee_id` FOREIGN KEY (`tertiary_maintenance_approved_by_manager_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`safety_inspection` ADD CONSTRAINT `fk_venue_safety_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`safety_incident` ADD CONSTRAINT `fk_venue_safety_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`event_day_ops` ADD CONSTRAINT `fk_venue_event_day_ops_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`event_day_ops` ADD CONSTRAINT `fk_venue_event_day_ops_facility_manager_employee_id` FOREIGN KEY (`facility_manager_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`suite` ADD CONSTRAINT `fk_venue_suite_account_manager_employee_id` FOREIGN KEY (`account_manager_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`suite` ADD CONSTRAINT `fk_venue_suite_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`suite_license` ADD CONSTRAINT `fk_venue_suite_license_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`rental` ADD CONSTRAINT `fk_venue_rental_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`operational_readiness` ADD CONSTRAINT `fk_venue_operational_readiness_approving_manager_employee_id` FOREIGN KEY (`approving_manager_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`operational_readiness` ADD CONSTRAINT `fk_venue_operational_readiness_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`staff_plan` ADD CONSTRAINT `fk_venue_staff_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`staff_plan` ADD CONSTRAINT `fk_venue_staff_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `sports_entertainment_ecm`.`venue`.`venue` ADD CONSTRAINT `fk_venue_venue_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= workforce --> analytics (1 constraint(s)) =========
-- Requires: workforce schema, analytics schema
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `sports_entertainment_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);

-- ========= workforce --> athlete (3 constraint(s)) =========
-- Requires: workforce schema, athlete schema
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_athlete_contract_id` FOREIGN KEY (`athlete_contract_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_contract`(`athlete_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_injury_record_id` FOREIGN KEY (`injury_record_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`injury_record`(`injury_record_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ADD CONSTRAINT `fk_workforce_labor_relations_case_suspension_record_id` FOREIGN KEY (`suspension_record_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`suspension_record`(`suspension_record_id`);

-- ========= workforce --> broadcast (3 constraint(s)) =========
-- Requires: workforce schema, broadcast schema
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_production_id` FOREIGN KEY (`production_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`production`(`production_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_production_id` FOREIGN KEY (`production_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`production`(`production_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_production_id` FOREIGN KEY (`production_id`) REFERENCES `sports_entertainment_ecm`.`broadcast`.`production`(`production_id`);

-- ========= workforce --> compliance (4 constraint(s)) =========
-- Requires: workforce schema, compliance schema
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ADD CONSTRAINT `fk_workforce_learning_enrollment_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_incident_report_id` FOREIGN KEY (`incident_report_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`incident_report`(`incident_report_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ADD CONSTRAINT `fk_workforce_employee_certification_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ADD CONSTRAINT `fk_workforce_labor_relations_case_incident_report_id` FOREIGN KEY (`incident_report_id`) REFERENCES `sports_entertainment_ecm`.`compliance`.`incident_report`(`incident_report_id`);

-- ========= workforce --> event (5 constraint(s)) =========
-- Requires: workforce schema, event schema
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_event_fixture_id` FOREIGN KEY (`event_fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ADD CONSTRAINT `fk_workforce_contingent_worker_fixture_id` FOREIGN KEY (`fixture_id`) REFERENCES `sports_entertainment_ecm`.`event`.`fixture`(`fixture_id`);

-- ========= workforce --> finance (21 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ADD CONSTRAINT `fk_workforce_job_application_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_tax_jurisdiction_id` FOREIGN KEY (`tax_jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`tax_jurisdiction`(`tax_jurisdiction_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ADD CONSTRAINT `fk_workforce_learning_enrollment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ADD CONSTRAINT `fk_workforce_employee_certification_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ADD CONSTRAINT `fk_workforce_labor_relations_case_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ADD CONSTRAINT `fk_workforce_contingent_worker_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ADD CONSTRAINT `fk_workforce_contingent_worker_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position_cost_allocation` ADD CONSTRAINT `fk_workforce_position_cost_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `sports_entertainment_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= workforce --> gaming (2 constraint(s)) =========
-- Requires: workforce schema, gaming schema
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ADD CONSTRAINT `fk_workforce_labor_relations_case_integrity_alert_id` FOREIGN KEY (`integrity_alert_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`integrity_alert`(`integrity_alert_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`jurisdiction_license` ADD CONSTRAINT `fk_workforce_jurisdiction_license_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `sports_entertainment_ecm`.`gaming`.`jurisdiction`(`jurisdiction_id`);

-- ========= workforce --> league (8 constraint(s)) =========
-- Requires: workforce schema, league schema
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ADD CONSTRAINT `fk_workforce_labor_relations_case_cba_agreement_id` FOREIGN KEY (`cba_agreement_id`) REFERENCES `sports_entertainment_ecm`.`league`.`cba_agreement`(`cba_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ADD CONSTRAINT `fk_workforce_labor_relations_case_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_cba_agreement_id` FOREIGN KEY (`cba_agreement_id`) REFERENCES `sports_entertainment_ecm`.`league`.`cba_agreement`(`cba_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_franchise_id` FOREIGN KEY (`franchise_id`) REFERENCES `sports_entertainment_ecm`.`league`.`franchise`(`franchise_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`open_enrollment_period` ADD CONSTRAINT `fk_workforce_open_enrollment_period_cba_agreement_id` FOREIGN KEY (`cba_agreement_id`) REFERENCES `sports_entertainment_ecm`.`league`.`cba_agreement`(`cba_agreement_id`);

-- ========= workforce --> legal (13 constraint(s)) =========
-- Requires: workforce schema, legal schema
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_insurance_claim_id` FOREIGN KEY (`insurance_claim_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`insurance_claim`(`insurance_claim_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_litigation_case_id` FOREIGN KEY (`litigation_case_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`litigation_case`(`litigation_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ADD CONSTRAINT `fk_workforce_employee_certification_regulatory_license_id` FOREIGN KEY (`regulatory_license_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`regulatory_license`(`regulatory_license_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ADD CONSTRAINT `fk_workforce_labor_relations_case_insurance_policy_id` FOREIGN KEY (`insurance_policy_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`insurance_policy`(`insurance_policy_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ADD CONSTRAINT `fk_workforce_labor_relations_case_litigation_case_id` FOREIGN KEY (`litigation_case_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`litigation_case`(`litigation_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ADD CONSTRAINT `fk_workforce_labor_relations_case_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`matter`(`matter_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ADD CONSTRAINT `fk_workforce_contingent_worker_corporate_entity_id` FOREIGN KEY (`corporate_entity_id`) REFERENCES `sports_entertainment_ecm`.`legal`.`corporate_entity`(`corporate_entity_id`);

-- ========= workforce --> merchandise (1 constraint(s)) =========
-- Requires: workforce schema, merchandise schema
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_retail_location_id` FOREIGN KEY (`retail_location_id`) REFERENCES `sports_entertainment_ecm`.`merchandise`.`retail_location`(`retail_location_id`);

-- ========= workforce --> partner (6 constraint(s)) =========
-- Requires: workforce schema, partner schema
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ADD CONSTRAINT `fk_workforce_learning_enrollment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ADD CONSTRAINT `fk_workforce_employee_certification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ADD CONSTRAINT `fk_workforce_contingent_worker_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ADD CONSTRAINT `fk_workforce_contingent_worker_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `sports_entertainment_ecm`.`partner`.`vendor_contract`(`vendor_contract_id`);

-- ========= workforce --> security (5 constraint(s)) =========
-- Requires: workforce schema, security schema
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_credential_assignment_id` FOREIGN KEY (`credential_assignment_id`) REFERENCES `sports_entertainment_ecm`.`security`.`credential_assignment`(`credential_assignment_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_staffing_plan_id` FOREIGN KEY (`staffing_plan_id`) REFERENCES `sports_entertainment_ecm`.`security`.`staffing_plan`(`staffing_plan_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `sports_entertainment_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ADD CONSTRAINT `fk_workforce_labor_relations_case_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `sports_entertainment_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_credential_id` FOREIGN KEY (`credential_id`) REFERENCES `sports_entertainment_ecm`.`security`.`credential`(`credential_id`);

-- ========= workforce --> venue (12 constraint(s)) =========
-- Requires: workforce schema, venue schema
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`facility`(`facility_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_location_facility_id` FOREIGN KEY (`location_facility_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`facility`(`facility_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ADD CONSTRAINT `fk_workforce_employee_certification_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ADD CONSTRAINT `fk_workforce_labor_relations_case_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_staff_plan_id` FOREIGN KEY (`staff_plan_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`staff_plan`(`staff_plan_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_to_venue_id` FOREIGN KEY (`to_venue_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`venue`(`venue_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_to_venue_venue_staff_plan_id` FOREIGN KEY (`to_venue_venue_staff_plan_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`staff_plan`(`staff_plan_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `sports_entertainment_ecm`.`venue`.`facility`(`facility_id`);

