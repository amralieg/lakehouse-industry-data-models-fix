-- Cross-Domain Foreign Keys for Business: Media Broadcasting | Version: v1_mvm
-- Generated on: 2026-05-08 19:23:34
-- Total cross-domain FK constraints: 1332
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: audience, billing, compliance, content, distribution, finance, mediaasset, partner, production, rights, sales, scheduling, subscriber, talent

-- ========= audience --> compliance (22 constraint(s)) =========
-- Requires: audience schema, compliance schema
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_eas_log_id` FOREIGN KEY (`eas_log_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`eas_log`(`eas_log_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_political_ad_record_id` FOREIGN KEY (`political_ad_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`political_ad_record`(`political_ad_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`demographic_segment` ADD CONSTRAINT `fk_audience_demographic_segment_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`panel` ADD CONSTRAINT `fk_audience_panel_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`panel` ADD CONSTRAINT `fk_audience_panel_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_privacy_request_id` FOREIGN KEY (`privacy_request_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`privacy_request`(`privacy_request_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_political_ad_record_id` FOREIGN KEY (`political_ad_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`political_ad_record`(`political_ad_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`market_coverage` ADD CONSTRAINT `fk_audience_market_coverage_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`market_coverage` ADD CONSTRAINT `fk_audience_market_coverage_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`segment` ADD CONSTRAINT `fk_audience_segment_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= audience --> content (7 constraint(s)) =========
-- Requires: audience schema, content schema
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_version_id` FOREIGN KEY (`version_id`) REFERENCES `media_broadcasting_ecm`.`content`.`version`(`version_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_version_id` FOREIGN KEY (`version_id`) REFERENCES `media_broadcasting_ecm`.`content`.`version`(`version_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);

-- ========= audience --> distribution (14 constraint(s)) =========
-- Requires: audience schema, distribution schema
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`panel` ADD CONSTRAINT `fk_audience_panel_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_device_type_id` FOREIGN KEY (`device_type_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`device_type`(`device_type_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_playback_session_id` FOREIGN KEY (`playback_session_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`playback_session`(`playback_session_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_device_type_id` FOREIGN KEY (`device_type_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`device_type`(`device_type_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_playback_session_id` FOREIGN KEY (`playback_session_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`playback_session`(`playback_session_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);

-- ========= audience --> finance (16 constraint(s)) =========
-- Requires: audience schema, finance schema
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`panel` ADD CONSTRAINT `fk_audience_panel_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`panel` ADD CONSTRAINT `fk_audience_panel_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`market_coverage` ADD CONSTRAINT `fk_audience_market_coverage_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);

-- ========= audience --> mediaasset (2 constraint(s)) =========
-- Requires: audience schema, mediaasset schema
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);

-- ========= audience --> partner (3 constraint(s)) =========
-- Requires: audience schema, partner schema
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);

-- ========= audience --> production (9 constraint(s)) =========
-- Requires: audience schema, production schema
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `media_broadcasting_ecm`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `media_broadcasting_ecm`.`production`.`deliverable`(`deliverable_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `media_broadcasting_ecm`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `media_broadcasting_ecm`.`production`.`deliverable`(`deliverable_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `media_broadcasting_ecm`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);

-- ========= audience --> sales (18 constraint(s)) =========
-- Requires: audience schema, sales schema
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_ad_spot_id` FOREIGN KEY (`ad_spot_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_spot`(`ad_spot_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_advertising_audience_guarantee_id` FOREIGN KEY (`advertising_audience_guarantee_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee`(`advertising_audience_guarantee_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`proposal`(`proposal_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`market_coverage` ADD CONSTRAINT `fk_audience_market_coverage_sales_territory_id` FOREIGN KEY (`sales_territory_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_territory`(`sales_territory_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_ad_spot_id` FOREIGN KEY (`ad_spot_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_spot`(`ad_spot_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`proposal`(`proposal_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);

-- ========= audience --> scheduling (17 constraint(s)) =========
-- Requires: audience schema, scheduling schema
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_epg_entry_id` FOREIGN KEY (`epg_entry_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`epg_entry`(`epg_entry_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_program_rundown_id` FOREIGN KEY (`program_rundown_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`program_rundown`(`program_rundown_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_ad_break_id` FOREIGN KEY (`ad_break_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`ad_break`(`ad_break_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_guarantee_network_channel_id` FOREIGN KEY (`guarantee_network_channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`daypart`(`daypart_id`);

-- ========= audience --> subscriber (4 constraint(s)) =========
-- Requires: audience schema, subscriber schema
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_household_id` FOREIGN KEY (`household_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`household`(`household_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_viewer_profile_id` FOREIGN KEY (`viewer_profile_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`viewer_profile`(`viewer_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_viewer_profile_id` FOREIGN KEY (`viewer_profile_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`viewer_profile`(`viewer_profile_id`);

-- ========= audience --> talent (1 constraint(s)) =========
-- Requires: audience schema, talent schema
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`contract`(`contract_id`);

-- ========= billing --> audience (3 constraint(s)) =========
-- Requires: billing schema, audience schema
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_nielsen_rating_id` FOREIGN KEY (`nielsen_rating_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`nielsen_rating`(`nielsen_rating_id`);

-- ========= billing --> compliance (7 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_political_ad_record_id` FOREIGN KEY (`political_ad_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`political_ad_record`(`political_ad_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= billing --> content (21 constraint(s)) =========
-- Requires: billing schema, content schema
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_acquisition_id` FOREIGN KEY (`acquisition_id`) REFERENCES `media_broadcasting_ecm`.`content`.`acquisition`(`acquisition_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_package_id` FOREIGN KEY (`package_id`) REFERENCES `media_broadcasting_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_version_id` FOREIGN KEY (`version_id`) REFERENCES `media_broadcasting_ecm`.`content`.`version`(`version_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_localization_id` FOREIGN KEY (`localization_id`) REFERENCES `media_broadcasting_ecm`.`content`.`localization`(`localization_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_season_id` FOREIGN KEY (`season_id`) REFERENCES `media_broadcasting_ecm`.`content`.`season`(`season_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_windowing_plan_id` FOREIGN KEY (`windowing_plan_id`) REFERENCES `media_broadcasting_ecm`.`content`.`windowing_plan`(`windowing_plan_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_acquisition_id` FOREIGN KEY (`acquisition_id`) REFERENCES `media_broadcasting_ecm`.`content`.`acquisition`(`acquisition_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_localization_id` FOREIGN KEY (`localization_id`) REFERENCES `media_broadcasting_ecm`.`content`.`localization`(`localization_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_acquisition_id` FOREIGN KEY (`acquisition_id`) REFERENCES `media_broadcasting_ecm`.`content`.`acquisition`(`acquisition_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_windowing_plan_id` FOREIGN KEY (`windowing_plan_id`) REFERENCES `media_broadcasting_ecm`.`content`.`windowing_plan`(`windowing_plan_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_package_id` FOREIGN KEY (`package_id`) REFERENCES `media_broadcasting_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_version_id` FOREIGN KEY (`version_id`) REFERENCES `media_broadcasting_ecm`.`content`.`version`(`version_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_season_id` FOREIGN KEY (`season_id`) REFERENCES `media_broadcasting_ecm`.`content`.`season`(`season_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);

-- ========= billing --> finance (16 constraint(s)) =========
-- Requires: billing schema, finance schema
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);

-- ========= billing --> mediaasset (4 constraint(s)) =========
-- Requires: billing schema, mediaasset schema
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_asset_collection_id` FOREIGN KEY (`asset_collection_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_collection`(`asset_collection_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_transcode_job_id` FOREIGN KEY (`transcode_job_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`transcode_job`(`transcode_job_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_asset_collection_id` FOREIGN KEY (`asset_collection_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_collection`(`asset_collection_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= billing --> partner (16 constraint(s)) =========
-- Requires: billing schema, partner schema
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`syndication_agreement`(`syndication_agreement_id`);

-- ========= billing --> production (8 constraint(s)) =========
-- Requires: billing schema, production schema
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `media_broadcasting_ecm`.`production`.`budget_line`(`budget_line_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_crew_assignment_id` FOREIGN KEY (`crew_assignment_id`) REFERENCES `media_broadcasting_ecm`.`production`.`crew_assignment`(`crew_assignment_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `media_broadcasting_ecm`.`production`.`deliverable`(`deliverable_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_facility_booking_id` FOREIGN KEY (`facility_booking_id`) REFERENCES `media_broadcasting_ecm`.`production`.`facility_booking`(`facility_booking_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `media_broadcasting_ecm`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `media_broadcasting_ecm`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);

-- ========= billing --> rights (10 constraint(s)) =========
-- Requires: billing schema, rights schema
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_rights_content_window_id` FOREIGN KEY (`rights_content_window_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_content_window`(`rights_content_window_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_royalty_statement_id` FOREIGN KEY (`royalty_statement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`royalty_statement`(`royalty_statement_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_music_sync_license_id` FOREIGN KEY (`music_sync_license_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`music_sync_license`(`music_sync_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_royalty_rule_id` FOREIGN KEY (`royalty_rule_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`royalty_rule`(`royalty_rule_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_royalty_statement_id` FOREIGN KEY (`royalty_statement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`royalty_statement`(`royalty_statement_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);

-- ========= billing --> sales (16 constraint(s)) =========
-- Requires: billing schema, sales schema
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_makegood_id` FOREIGN KEY (`makegood_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`makegood`(`makegood_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_makegood_id` FOREIGN KEY (`makegood_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`makegood`(`makegood_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_ad_spot_id` FOREIGN KEY (`ad_spot_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_spot`(`ad_spot_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);

-- ========= billing --> subscriber (11 constraint(s)) =========
-- Requires: billing schema, subscriber schema
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscription`(`subscription_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_subscription_plan_id` FOREIGN KEY (`subscription_plan_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscription_plan`(`subscription_plan_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscription`(`subscription_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`payment_method` ADD CONSTRAINT `fk_billing_payment_method_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscription`(`subscription_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscription`(`subscription_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscription`(`subscription_id`);

-- ========= compliance --> content (4 constraint(s)) =========
-- Requires: compliance schema, content schema
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`content_rating` ADD CONSTRAINT `fk_compliance_content_rating_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `media_broadcasting_ecm`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_version_id` FOREIGN KEY (`version_id`) REFERENCES `media_broadcasting_ecm`.`content`.`version`(`version_id`);

-- ========= compliance --> distribution (1 constraint(s)) =========
-- Requires: compliance schema, distribution schema
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);

-- ========= compliance --> mediaasset (6 constraint(s)) =========
-- Requires: compliance schema, mediaasset schema
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`public_inspection_file` ADD CONSTRAINT `fk_compliance_public_inspection_file_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`content_rating` ADD CONSTRAINT `fk_compliance_content_rating_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`eas_log` ADD CONSTRAINT `fk_compliance_eas_log_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`political_ad_record` ADD CONSTRAINT `fk_compliance_political_ad_record_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= compliance --> partner (2 constraint(s)) =========
-- Requires: compliance schema, partner schema
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`political_ad_record` ADD CONSTRAINT `fk_compliance_political_ad_record_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);

-- ========= compliance --> sales (1 constraint(s)) =========
-- Requires: compliance schema, sales schema
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`political_ad_record` ADD CONSTRAINT `fk_compliance_political_ad_record_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_order`(`ad_order_id`);

-- ========= compliance --> scheduling (2 constraint(s)) =========
-- Requires: compliance schema, scheduling schema
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`public_inspection_file` ADD CONSTRAINT `fk_compliance_public_inspection_file_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`eas_log` ADD CONSTRAINT `fk_compliance_eas_log_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);

-- ========= compliance --> subscriber (1 constraint(s)) =========
-- Requires: compliance schema, subscriber schema
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);

-- ========= compliance --> talent (2 constraint(s)) =========
-- Requires: compliance schema, talent schema
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`political_ad_record` ADD CONSTRAINT `fk_compliance_political_ad_record_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= content --> billing (1 constraint(s)) =========
-- Requires: content schema, billing schema
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= content --> compliance (8 constraint(s)) =========
-- Requires: content schema, compliance schema
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_compliance_content_rating_id` FOREIGN KEY (`compliance_content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);

-- ========= content --> distribution (17 constraint(s)) =========
-- Requires: content schema, distribution schema
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ADD CONSTRAINT `fk_content_title_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`distribution_partner`(`distribution_partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ADD CONSTRAINT `fk_content_version_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ADD CONSTRAINT `fk_content_version_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ADD CONSTRAINT `fk_content_version_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ADD CONSTRAINT `fk_content_package_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ADD CONSTRAINT `fk_content_package_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`distribution_partner`(`distribution_partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ADD CONSTRAINT `fk_content_package_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);

-- ========= content --> finance (29 constraint(s)) =========
-- Requires: content schema, finance schema
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ADD CONSTRAINT `fk_content_title_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ADD CONSTRAINT `fk_content_title_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ADD CONSTRAINT `fk_content_title_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ADD CONSTRAINT `fk_content_title_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ADD CONSTRAINT `fk_content_series_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ADD CONSTRAINT `fk_content_series_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ADD CONSTRAINT `fk_content_series_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ADD CONSTRAINT `fk_content_series_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ADD CONSTRAINT `fk_content_season_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ADD CONSTRAINT `fk_content_season_production_budget_id` FOREIGN KEY (`production_budget_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`production_budget`(`production_budget_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ADD CONSTRAINT `fk_content_season_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ADD CONSTRAINT `fk_content_season_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_production_budget_id` FOREIGN KEY (`production_budget_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`production_budget`(`production_budget_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ADD CONSTRAINT `fk_content_version_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ADD CONSTRAINT `fk_content_version_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_revenue_recognition_event_id` FOREIGN KEY (`revenue_recognition_event_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ADD CONSTRAINT `fk_content_package_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ADD CONSTRAINT `fk_content_package_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);

-- ========= content --> mediaasset (14 constraint(s)) =========
-- Requires: content schema, mediaasset schema
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ADD CONSTRAINT `fk_content_title_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ADD CONSTRAINT `fk_content_season_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ADD CONSTRAINT `fk_content_version_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ADD CONSTRAINT `fk_content_version_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_ingest_job_id` FOREIGN KEY (`ingest_job_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`ingest_job`(`ingest_job_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ADD CONSTRAINT `fk_content_package_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= content --> partner (10 constraint(s)) =========
-- Requires: content schema, partner schema
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ADD CONSTRAINT `fk_content_series_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ADD CONSTRAINT `fk_content_season_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ADD CONSTRAINT `fk_content_package_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);

-- ========= content --> production (5 constraint(s)) =========
-- Requires: content schema, production schema
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ADD CONSTRAINT `fk_content_version_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `media_broadcasting_ecm`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `media_broadcasting_ecm`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `media_broadcasting_ecm`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `media_broadcasting_ecm`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);

-- ========= content --> rights (40 constraint(s)) =========
-- Requires: content schema, rights schema
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ADD CONSTRAINT `fk_content_title_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ADD CONSTRAINT `fk_content_title_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`holder`(`holder_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ADD CONSTRAINT `fk_content_title_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ADD CONSTRAINT `fk_content_series_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`holder`(`holder_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ADD CONSTRAINT `fk_content_series_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ADD CONSTRAINT `fk_content_season_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ADD CONSTRAINT `fk_content_season_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ADD CONSTRAINT `fk_content_season_royalty_rule_id` FOREIGN KEY (`royalty_rule_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`royalty_rule`(`royalty_rule_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_rights_content_window_id` FOREIGN KEY (`rights_content_window_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_content_window`(`rights_content_window_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_royalty_rule_id` FOREIGN KEY (`royalty_rule_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`royalty_rule`(`royalty_rule_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ADD CONSTRAINT `fk_content_version_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ADD CONSTRAINT `fk_content_version_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ADD CONSTRAINT `fk_content_version_rights_content_window_id` FOREIGN KEY (`rights_content_window_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_content_window`(`rights_content_window_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ADD CONSTRAINT `fk_content_version_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ADD CONSTRAINT `fk_content_version_royalty_rule_id` FOREIGN KEY (`royalty_rule_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`royalty_rule`(`royalty_rule_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_music_sync_license_id` FOREIGN KEY (`music_sync_license_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`music_sync_license`(`music_sync_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_rights_content_window_id` FOREIGN KEY (`rights_content_window_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_content_window`(`rights_content_window_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_rights_content_window_id` FOREIGN KEY (`rights_content_window_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_content_window`(`rights_content_window_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_royalty_rule_id` FOREIGN KEY (`royalty_rule_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`royalty_rule`(`royalty_rule_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_holdback_id` FOREIGN KEY (`holdback_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`holdback`(`holdback_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_rights_availability_window_id` FOREIGN KEY (`rights_availability_window_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_availability_window`(`rights_availability_window_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_rights_content_window_id` FOREIGN KEY (`rights_content_window_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_content_window`(`rights_content_window_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_royalty_rule_id` FOREIGN KEY (`royalty_rule_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`royalty_rule`(`royalty_rule_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ADD CONSTRAINT `fk_content_package_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ADD CONSTRAINT `fk_content_package_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ADD CONSTRAINT `fk_content_package_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`holder`(`holder_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ADD CONSTRAINT `fk_content_package_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_territory`(`rights_territory_id`);

-- ========= content --> sales (4 constraint(s)) =========
-- Requires: content schema, sales schema
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ADD CONSTRAINT `fk_content_title_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_upfront_deal_id` FOREIGN KEY (`upfront_deal_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`upfront_deal`(`upfront_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ADD CONSTRAINT `fk_content_package_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);

-- ========= content --> scheduling (5 constraint(s)) =========
-- Requires: content schema, scheduling schema
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ADD CONSTRAINT `fk_content_series_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ADD CONSTRAINT `fk_content_package_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);

-- ========= content --> subscriber (1 constraint(s)) =========
-- Requires: content schema, subscriber schema
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_subscription_plan_id` FOREIGN KEY (`subscription_plan_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscription_plan`(`subscription_plan_id`);

-- ========= content --> talent (5 constraint(s)) =========
-- Requires: content schema, talent schema
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`contract`(`contract_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`contract`(`contract_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_role_id` FOREIGN KEY (`role_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`role`(`role_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= distribution --> audience (18 constraint(s)) =========
-- Requires: distribution schema, audience schema
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_audience_profile_id` FOREIGN KEY (`audience_profile_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`audience_profile`(`audience_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ADD CONSTRAINT `fk_distribution_dai_configuration_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ADD CONSTRAINT `fk_distribution_dai_configuration_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ADD CONSTRAINT `fk_distribution_signal_route_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_audience_profile_id` FOREIGN KEY (`audience_profile_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`audience_profile`(`audience_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);

-- ========= distribution --> billing (8 constraint(s)) =========
-- Requires: distribution schema, billing schema
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ADD CONSTRAINT `fk_distribution_carriage_fee_invoice_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ADD CONSTRAINT `fk_distribution_carriage_fee_invoice_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= distribution --> compliance (21 constraint(s)) =========
-- Requires: distribution schema, compliance schema
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_eas_log_id` FOREIGN KEY (`eas_log_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`eas_log`(`eas_log_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ADD CONSTRAINT `fk_distribution_signal_route_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ADD CONSTRAINT `fk_distribution_signal_route_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_closed_caption_record_id` FOREIGN KEY (`closed_caption_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`closed_caption_record`(`closed_caption_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_eas_log_id` FOREIGN KEY (`eas_log_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`eas_log`(`eas_log_id`);

-- ========= distribution --> content (13 constraint(s)) =========
-- Requires: distribution schema, content schema
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `media_broadcasting_ecm`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_version_id` FOREIGN KEY (`version_id`) REFERENCES `media_broadcasting_ecm`.`content`.`version`(`version_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_package_id` FOREIGN KEY (`package_id`) REFERENCES `media_broadcasting_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `media_broadcasting_ecm`.`content`.`genre`(`genre_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `media_broadcasting_ecm`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_version_id` FOREIGN KEY (`version_id`) REFERENCES `media_broadcasting_ecm`.`content`.`version`(`version_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_season_id` FOREIGN KEY (`season_id`) REFERENCES `media_broadcasting_ecm`.`content`.`season`(`season_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `media_broadcasting_ecm`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_version_id` FOREIGN KEY (`version_id`) REFERENCES `media_broadcasting_ecm`.`content`.`version`(`version_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);

-- ========= distribution --> finance (31 constraint(s)) =========
-- Requires: distribution schema, finance schema
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_revenue_recognition_event_id` FOREIGN KEY (`revenue_recognition_event_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ADD CONSTRAINT `fk_distribution_dai_configuration_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ADD CONSTRAINT `fk_distribution_carriage_fee_invoice_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ADD CONSTRAINT `fk_distribution_carriage_fee_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ADD CONSTRAINT `fk_distribution_carriage_fee_invoice_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ADD CONSTRAINT `fk_distribution_carriage_fee_invoice_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ADD CONSTRAINT `fk_distribution_carriage_fee_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ADD CONSTRAINT `fk_distribution_carriage_fee_invoice_revenue_recognition_event_id` FOREIGN KEY (`revenue_recognition_event_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ADD CONSTRAINT `fk_distribution_cdn_configuration_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ADD CONSTRAINT `fk_distribution_signal_route_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);

-- ========= distribution --> mediaasset (8 constraint(s)) =========
-- Requires: distribution schema, mediaasset schema
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ADD CONSTRAINT `fk_distribution_abr_profile_format_specification_id` FOREIGN KEY (`format_specification_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`format_specification`(`format_specification_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_format_specification_id` FOREIGN KEY (`format_specification_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`format_specification`(`format_specification_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_asset_collection_id` FOREIGN KEY (`asset_collection_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_collection`(`asset_collection_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= distribution --> partner (6 constraint(s)) =========
-- Requires: distribution schema, partner schema
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_territory_grant_id` FOREIGN KEY (`territory_grant_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`territory_grant`(`territory_grant_id`);

-- ========= distribution --> rights (23 constraint(s)) =========
-- Requires: distribution schema, rights schema
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_rights_content_window_id` FOREIGN KEY (`rights_content_window_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_content_window`(`rights_content_window_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ADD CONSTRAINT `fk_distribution_dai_configuration_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_holdback_id` FOREIGN KEY (`holdback_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`holdback`(`holdback_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_rights_content_window_id` FOREIGN KEY (`rights_content_window_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_content_window`(`rights_content_window_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ADD CONSTRAINT `fk_distribution_drm_policy_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ADD CONSTRAINT `fk_distribution_cdn_configuration_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ADD CONSTRAINT `fk_distribution_signal_route_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_holdback_id` FOREIGN KEY (`holdback_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`holdback`(`holdback_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_rights_content_window_id` FOREIGN KEY (`rights_content_window_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_content_window`(`rights_content_window_id`);

-- ========= distribution --> sales (11 constraint(s)) =========
-- Requires: distribution schema, sales schema
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_sales_territory_id` FOREIGN KEY (`sales_territory_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_territory`(`sales_territory_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_sales_territory_id` FOREIGN KEY (`sales_territory_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_territory`(`sales_territory_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_upfront_deal_id` FOREIGN KEY (`upfront_deal_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`upfront_deal`(`upfront_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice` ADD CONSTRAINT `fk_distribution_carriage_fee_invoice_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);

-- ========= distribution --> scheduling (4 constraint(s)) =========
-- Requires: distribution schema, scheduling schema
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ADD CONSTRAINT `fk_distribution_cdn_configuration_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ADD CONSTRAINT `fk_distribution_signal_route_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);

-- ========= distribution --> subscriber (1 constraint(s)) =========
-- Requires: distribution schema, subscriber schema
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);

-- ========= distribution --> talent (3 constraint(s)) =========
-- Requires: distribution schema, talent schema
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_role_id` FOREIGN KEY (`role_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`role`(`role_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`contract`(`contract_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_role_id` FOREIGN KEY (`role_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`role`(`role_id`);

-- ========= finance --> billing (6 constraint(s)) =========
-- Requires: finance schema, billing schema
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_credit_memo_id` FOREIGN KEY (`credit_memo_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`credit_memo`(`credit_memo_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_refund_id` FOREIGN KEY (`refund_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`refund`(`refund_id`);

-- ========= finance --> compliance (7 constraint(s)) =========
-- Requires: finance schema, compliance schema
ALTER TABLE `media_broadcasting_ecm`.`finance`.`chart_of_accounts` ADD CONSTRAINT `fk_finance_chart_of_accounts_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ADD CONSTRAINT `fk_finance_production_budget_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ADD CONSTRAINT `fk_finance_revenue_stream_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_stream` ADD CONSTRAINT `fk_finance_revenue_stream_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_political_ad_record_id` FOREIGN KEY (`political_ad_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`political_ad_record`(`political_ad_record_id`);

-- ========= finance --> content (1 constraint(s)) =========
-- Requires: finance schema, content schema
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);

-- ========= finance --> partner (1 constraint(s)) =========
-- Requires: finance schema, partner schema
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`vendor`(`vendor_id`);

-- ========= finance --> production (2 constraint(s)) =========
-- Requires: finance schema, production schema
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ADD CONSTRAINT `fk_finance_production_budget_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `media_broadcasting_ecm`.`production`.`production_episode`(`production_episode_id`);

-- ========= finance --> rights (4 constraint(s)) =========
-- Requires: finance schema, rights schema
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ADD CONSTRAINT `fk_finance_production_budget_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);

-- ========= finance --> subscriber (2 constraint(s)) =========
-- Requires: finance schema, subscriber schema
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);

-- ========= mediaasset --> audience (3 constraint(s)) =========
-- Requires: mediaasset schema, audience schema
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ADD CONSTRAINT `fk_mediaasset_asset_version_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ADD CONSTRAINT `fk_mediaasset_asset_collection_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ADD CONSTRAINT `fk_mediaasset_asset_collection_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);

-- ========= mediaasset --> compliance (5 constraint(s)) =========
-- Requires: mediaasset schema, compliance schema
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ADD CONSTRAINT `fk_mediaasset_qc_inspection_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ADD CONSTRAINT `fk_mediaasset_qc_inspection_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ADD CONSTRAINT `fk_mediaasset_retention_policy_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ADD CONSTRAINT `fk_mediaasset_format_specification_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ADD CONSTRAINT `fk_mediaasset_archive_record_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= mediaasset --> finance (14 constraint(s)) =========
-- Requires: mediaasset schema, finance schema
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ADD CONSTRAINT `fk_mediaasset_media_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ADD CONSTRAINT `fk_mediaasset_media_asset_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ADD CONSTRAINT `fk_mediaasset_media_asset_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ADD CONSTRAINT `fk_mediaasset_asset_version_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ADD CONSTRAINT `fk_mediaasset_ingest_job_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ADD CONSTRAINT `fk_mediaasset_transcode_job_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ADD CONSTRAINT `fk_mediaasset_transcode_job_production_budget_id` FOREIGN KEY (`production_budget_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`production_budget`(`production_budget_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ADD CONSTRAINT `fk_mediaasset_qc_inspection_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ADD CONSTRAINT `fk_mediaasset_storage_location_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ADD CONSTRAINT `fk_mediaasset_asset_storage_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ADD CONSTRAINT `fk_mediaasset_asset_collection_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ADD CONSTRAINT `fk_mediaasset_asset_collection_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ADD CONSTRAINT `fk_mediaasset_asset_collection_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ADD CONSTRAINT `fk_mediaasset_archive_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= mediaasset --> partner (6 constraint(s)) =========
-- Requires: mediaasset schema, partner schema
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ADD CONSTRAINT `fk_mediaasset_asset_version_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ADD CONSTRAINT `fk_mediaasset_ingest_job_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ADD CONSTRAINT `fk_mediaasset_transcode_job_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ADD CONSTRAINT `fk_mediaasset_qc_inspection_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ADD CONSTRAINT `fk_mediaasset_storage_location_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ADD CONSTRAINT `fk_mediaasset_archive_record_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);

-- ========= mediaasset --> rights (5 constraint(s)) =========
-- Requires: mediaasset schema, rights schema
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ADD CONSTRAINT `fk_mediaasset_asset_version_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ADD CONSTRAINT `fk_mediaasset_asset_version_rights_content_window_id` FOREIGN KEY (`rights_content_window_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_content_window`(`rights_content_window_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ADD CONSTRAINT `fk_mediaasset_ingest_job_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ADD CONSTRAINT `fk_mediaasset_qc_inspection_clearance_request_id` FOREIGN KEY (`clearance_request_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`clearance_request`(`clearance_request_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ADD CONSTRAINT `fk_mediaasset_archive_record_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);

-- ========= partner --> audience (10 constraint(s)) =========
-- Requires: partner schema, audience schema
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ADD CONSTRAINT `fk_partner_acquisition_deal_line_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ADD CONSTRAINT `fk_partner_distribution_agreement_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ADD CONSTRAINT `fk_partner_affiliate_agreement_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ADD CONSTRAINT `fk_partner_affiliate_agreement_panel_id` FOREIGN KEY (`panel_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`panel`(`panel_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ADD CONSTRAINT `fk_partner_affiliate_agreement_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ADD CONSTRAINT `fk_partner_carriage_fee_schedule_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ADD CONSTRAINT `fk_partner_partner_content_window_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);

-- ========= partner --> billing (1 constraint(s)) =========
-- Requires: partner schema, billing schema
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ADD CONSTRAINT `fk_partner_minimum_guarantee_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= partner --> compliance (15 constraint(s)) =========
-- Requires: partner schema, compliance schema
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ADD CONSTRAINT `fk_partner_partner_partner_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ADD CONSTRAINT `fk_partner_acquisition_deal_line_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ADD CONSTRAINT `fk_partner_distribution_agreement_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ADD CONSTRAINT `fk_partner_affiliate_agreement_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_closed_caption_record_id` FOREIGN KEY (`closed_caption_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`closed_caption_record`(`closed_caption_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ADD CONSTRAINT `fk_partner_carriage_fee_schedule_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ADD CONSTRAINT `fk_partner_partner_content_window_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`vendor` ADD CONSTRAINT `fk_partner_vendor_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= partner --> content (9 constraint(s)) =========
-- Requires: partner schema, content schema
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ADD CONSTRAINT `fk_partner_acquisition_deal_line_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_version_id` FOREIGN KEY (`version_id`) REFERENCES `media_broadcasting_ecm`.`content`.`version`(`version_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ADD CONSTRAINT `fk_partner_carriage_fee_schedule_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `media_broadcasting_ecm`.`content`.`genre`(`genre_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ADD CONSTRAINT `fk_partner_partner_content_window_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ADD CONSTRAINT `fk_partner_partner_content_window_version_id` FOREIGN KEY (`version_id`) REFERENCES `media_broadcasting_ecm`.`content`.`version`(`version_id`);

-- ========= partner --> distribution (1 constraint(s)) =========
-- Requires: partner schema, distribution schema
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ADD CONSTRAINT `fk_partner_carriage_fee_schedule_carriage_agreement_id` FOREIGN KEY (`carriage_agreement_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`carriage_agreement`(`carriage_agreement_id`);

-- ========= partner --> finance (33 constraint(s)) =========
-- Requires: partner schema, finance schema
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ADD CONSTRAINT `fk_partner_partner_partner_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ADD CONSTRAINT `fk_partner_acquisition_deal_line_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ADD CONSTRAINT `fk_partner_distribution_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ADD CONSTRAINT `fk_partner_distribution_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ADD CONSTRAINT `fk_partner_distribution_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ADD CONSTRAINT `fk_partner_affiliate_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ADD CONSTRAINT `fk_partner_affiliate_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ADD CONSTRAINT `fk_partner_affiliate_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ADD CONSTRAINT `fk_partner_carriage_fee_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ADD CONSTRAINT `fk_partner_carriage_fee_schedule_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ADD CONSTRAINT `fk_partner_carriage_fee_schedule_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ADD CONSTRAINT `fk_partner_minimum_guarantee_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ADD CONSTRAINT `fk_partner_minimum_guarantee_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ADD CONSTRAINT `fk_partner_minimum_guarantee_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ADD CONSTRAINT `fk_partner_minimum_guarantee_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ADD CONSTRAINT `fk_partner_payment_term_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ADD CONSTRAINT `fk_partner_payment_term_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ADD CONSTRAINT `fk_partner_partner_content_window_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`vendor` ADD CONSTRAINT `fk_partner_vendor_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= partner --> mediaasset (6 constraint(s)) =========
-- Requires: partner schema, mediaasset schema
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ADD CONSTRAINT `fk_partner_acquisition_deal_line_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ADD CONSTRAINT `fk_partner_partner_content_window_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= partner --> production (1 constraint(s)) =========
-- Requires: partner schema, production schema
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);

-- ========= partner --> rights (12 constraint(s)) =========
-- Requires: partner schema, rights schema
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ADD CONSTRAINT `fk_partner_acquisition_deal_line_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ADD CONSTRAINT `fk_partner_acquisition_deal_line_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ADD CONSTRAINT `fk_partner_minimum_guarantee_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ADD CONSTRAINT `fk_partner_payment_term_royalty_rule_id` FOREIGN KEY (`royalty_rule_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`royalty_rule`(`royalty_rule_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ADD CONSTRAINT `fk_partner_partner_content_window_rights_content_window_id` FOREIGN KEY (`rights_content_window_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_content_window`(`rights_content_window_id`);

-- ========= partner --> sales (7 constraint(s)) =========
-- Requires: partner schema, sales schema
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ADD CONSTRAINT `fk_partner_distribution_agreement_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ADD CONSTRAINT `fk_partner_affiliate_agreement_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_account`(`sales_account_id`);

-- ========= partner --> scheduling (7 constraint(s)) =========
-- Requires: partner schema, scheduling schema
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ADD CONSTRAINT `fk_partner_distribution_agreement_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ADD CONSTRAINT `fk_partner_affiliate_agreement_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ADD CONSTRAINT `fk_partner_affiliate_agreement_tertiary_affiliate_network_channel_id` FOREIGN KEY (`tertiary_affiliate_network_channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ADD CONSTRAINT `fk_partner_carriage_fee_schedule_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);

-- ========= partner --> talent (4 constraint(s)) =========
-- Requires: partner schema, talent schema
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ADD CONSTRAINT `fk_partner_contact_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ADD CONSTRAINT `fk_partner_acquisition_deal_line_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= production --> billing (1 constraint(s)) =========
-- Requires: production schema, billing schema
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ADD CONSTRAINT `fk_production_project_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`billing_account`(`billing_account_id`);

-- ========= production --> compliance (16 constraint(s)) =========
-- Requires: production schema, compliance schema
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ADD CONSTRAINT `fk_production_project_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ADD CONSTRAINT `fk_production_script_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_closed_caption_record_id` FOREIGN KEY (`closed_caption_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`closed_caption_record`(`closed_caption_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ADD CONSTRAINT `fk_production_format_spec_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= production --> content (21 constraint(s)) =========
-- Requires: production schema, content schema
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ADD CONSTRAINT `fk_production_project_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ADD CONSTRAINT `fk_production_shoot_schedule_season_id` FOREIGN KEY (`season_id`) REFERENCES `media_broadcasting_ecm`.`content`.`season`(`season_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ADD CONSTRAINT `fk_production_budget_season_id` FOREIGN KEY (`season_id`) REFERENCES `media_broadcasting_ecm`.`content`.`season`(`season_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ADD CONSTRAINT `fk_production_budget_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_season_id` FOREIGN KEY (`season_id`) REFERENCES `media_broadcasting_ecm`.`content`.`season`(`season_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ADD CONSTRAINT `fk_production_script_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `media_broadcasting_ecm`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ADD CONSTRAINT `fk_production_script_season_id` FOREIGN KEY (`season_id`) REFERENCES `media_broadcasting_ecm`.`content`.`season`(`season_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ADD CONSTRAINT `fk_production_script_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ADD CONSTRAINT `fk_production_script_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_version_id` FOREIGN KEY (`version_id`) REFERENCES `media_broadcasting_ecm`.`content`.`version`(`version_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_version_id` FOREIGN KEY (`version_id`) REFERENCES `media_broadcasting_ecm`.`content`.`version`(`version_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_season_id` FOREIGN KEY (`season_id`) REFERENCES `media_broadcasting_ecm`.`content`.`season`(`season_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_version_id` FOREIGN KEY (`version_id`) REFERENCES `media_broadcasting_ecm`.`content`.`version`(`version_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_season_id` FOREIGN KEY (`season_id`) REFERENCES `media_broadcasting_ecm`.`content`.`season`(`season_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ADD CONSTRAINT `fk_production_format_spec_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);

-- ========= production --> distribution (19 constraint(s)) =========
-- Requires: production schema, distribution schema
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ADD CONSTRAINT `fk_production_project_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ADD CONSTRAINT `fk_production_project_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`distribution_partner`(`distribution_partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ADD CONSTRAINT `fk_production_project_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_release_window_id` FOREIGN KEY (`release_window_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`release_window`(`release_window_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_release_window_id` FOREIGN KEY (`release_window_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`release_window`(`release_window_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ADD CONSTRAINT `fk_production_format_spec_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ADD CONSTRAINT `fk_production_format_spec_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ADD CONSTRAINT `fk_production_format_spec_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);

-- ========= production --> finance (15 constraint(s)) =========
-- Requires: production schema, finance schema
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ADD CONSTRAINT `fk_production_project_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ADD CONSTRAINT `fk_production_project_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ADD CONSTRAINT `fk_production_budget_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ADD CONSTRAINT `fk_production_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ADD CONSTRAINT `fk_production_budget_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ADD CONSTRAINT `fk_production_budget_production_budget_id` FOREIGN KEY (`production_budget_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`production_budget`(`production_budget_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ADD CONSTRAINT `fk_production_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ADD CONSTRAINT `fk_production_facility_booking_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ADD CONSTRAINT `fk_production_equipment_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= production --> mediaasset (13 constraint(s)) =========
-- Requires: production schema, mediaasset schema
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ADD CONSTRAINT `fk_production_project_asset_collection_id` FOREIGN KEY (`asset_collection_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_collection`(`asset_collection_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_asset_collection_id` FOREIGN KEY (`asset_collection_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_collection`(`asset_collection_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ADD CONSTRAINT `fk_production_script_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_ingest_job_id` FOREIGN KEY (`ingest_job_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`ingest_job`(`ingest_job_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_transcode_job_id` FOREIGN KEY (`transcode_job_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`transcode_job`(`transcode_job_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_ingest_job_id` FOREIGN KEY (`ingest_job_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`ingest_job`(`ingest_job_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_qc_inspection_id` FOREIGN KEY (`qc_inspection_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`qc_inspection`(`qc_inspection_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ADD CONSTRAINT `fk_production_format_spec_format_specification_id` FOREIGN KEY (`format_specification_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`format_specification`(`format_specification_id`);

-- ========= production --> partner (24 constraint(s)) =========
-- Requires: production schema, partner schema
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ADD CONSTRAINT `fk_production_project_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ADD CONSTRAINT `fk_production_project_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ADD CONSTRAINT `fk_production_project_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ADD CONSTRAINT `fk_production_budget_coproduction_agreement_id` FOREIGN KEY (`coproduction_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`coproduction_agreement`(`coproduction_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ADD CONSTRAINT `fk_production_facility_booking_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ADD CONSTRAINT `fk_production_equipment_allocation_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_delivery_obligation_id` FOREIGN KEY (`delivery_obligation_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`delivery_obligation`(`delivery_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_delivery_obligation_id` FOREIGN KEY (`delivery_obligation_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`delivery_obligation`(`delivery_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_partner_content_window_id` FOREIGN KEY (`partner_content_window_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_content_window`(`partner_content_window_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_territory_grant_id` FOREIGN KEY (`territory_grant_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`territory_grant`(`territory_grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_delivery_obligation_id` FOREIGN KEY (`delivery_obligation_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`delivery_obligation`(`delivery_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_coproduction_agreement_id` FOREIGN KEY (`coproduction_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`coproduction_agreement`(`coproduction_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_delivery_obligation_id` FOREIGN KEY (`delivery_obligation_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`delivery_obligation`(`delivery_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ADD CONSTRAINT `fk_production_location_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ADD CONSTRAINT `fk_production_format_spec_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_item` ADD CONSTRAINT `fk_production_equipment_item_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`vendor`(`vendor_id`);

-- ========= production --> rights (6 constraint(s)) =========
-- Requires: production schema, rights schema
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ADD CONSTRAINT `fk_production_project_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_royalty_rule_id` FOREIGN KEY (`royalty_rule_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`royalty_rule`(`royalty_rule_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ADD CONSTRAINT `fk_production_script_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`holder`(`holder_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_clearance_request_id` FOREIGN KEY (`clearance_request_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`clearance_request`(`clearance_request_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);

-- ========= production --> sales (10 constraint(s)) =========
-- Requires: production schema, sales schema
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ADD CONSTRAINT `fk_production_project_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ADD CONSTRAINT `fk_production_project_upfront_deal_id` FOREIGN KEY (`upfront_deal_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`upfront_deal`(`upfront_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ADD CONSTRAINT `fk_production_budget_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_sponsorship_id` FOREIGN KEY (`sponsorship_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sponsorship`(`sponsorship_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ADD CONSTRAINT `fk_production_script_sponsorship_id` FOREIGN KEY (`sponsorship_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sponsorship`(`sponsorship_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_sponsorship_id` FOREIGN KEY (`sponsorship_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sponsorship`(`sponsorship_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_upfront_deal_id` FOREIGN KEY (`upfront_deal_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`upfront_deal`(`upfront_deal_id`);

-- ========= production --> scheduling (7 constraint(s)) =========
-- Requires: production schema, scheduling schema
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ADD CONSTRAINT `fk_production_project_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_program_rundown_id` FOREIGN KEY (`program_rundown_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`program_rundown`(`program_rundown_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ADD CONSTRAINT `fk_production_facility_booking_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ADD CONSTRAINT `fk_production_format_spec_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);

-- ========= production --> talent (5 constraint(s)) =========
-- Requires: production schema, talent schema
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`contract`(`contract_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_cba_rate_card_id` FOREIGN KEY (`cba_rate_card_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`cba_rate_card`(`cba_rate_card_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`contract`(`contract_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_guild_affiliation_id` FOREIGN KEY (`guild_affiliation_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`guild_affiliation`(`guild_affiliation_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= rights --> audience (4 constraint(s)) =========
-- Requires: rights schema, audience schema
ALTER TABLE `media_broadcasting_ecm`.`rights`.`rights_territory` ADD CONSTRAINT `fk_rights_rights_territory_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`royalty_rule` ADD CONSTRAINT `fk_rights_royalty_rule_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_nielsen_rating_id` FOREIGN KEY (`nielsen_rating_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`nielsen_rating`(`nielsen_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_nielsen_rating_id` FOREIGN KEY (`nielsen_rating_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`nielsen_rating`(`nielsen_rating_id`);

-- ========= rights --> compliance (21 constraint(s)) =========
-- Requires: rights schema, compliance schema
ALTER TABLE `media_broadcasting_ecm`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`grant` ADD CONSTRAINT `fk_rights_grant_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`grant` ADD CONSTRAINT `fk_rights_grant_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`grant` ADD CONSTRAINT `fk_rights_grant_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`rights_content_window` ADD CONSTRAINT `fk_rights_rights_content_window_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`holdback` ADD CONSTRAINT `fk_rights_holdback_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`rights_territory` ADD CONSTRAINT `fk_rights_rights_territory_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`royalty_rule` ADD CONSTRAINT `fk_rights_royalty_rule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`music_sync_license` ADD CONSTRAINT `fk_rights_music_sync_license_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`music_sync_license` ADD CONSTRAINT `fk_rights_music_sync_license_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`rights_availability_window` ADD CONSTRAINT `fk_rights_rights_availability_window_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`rights_availability_window` ADD CONSTRAINT `fk_rights_rights_availability_window_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= rights --> finance (18 constraint(s)) =========
-- Requires: rights schema, finance schema
ALTER TABLE `media_broadcasting_ecm`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`grant` ADD CONSTRAINT `fk_rights_grant_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`grant` ADD CONSTRAINT `fk_rights_grant_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`rights_content_window` ADD CONSTRAINT `fk_rights_rights_content_window_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`royalty_rule` ADD CONSTRAINT `fk_rights_royalty_rule_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`royalty_rule` ADD CONSTRAINT `fk_rights_royalty_rule_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`music_sync_license` ADD CONSTRAINT `fk_rights_music_sync_license_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`music_sync_license` ADD CONSTRAINT `fk_rights_music_sync_license_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`holder` ADD CONSTRAINT `fk_rights_holder_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= rights --> mediaasset (14 constraint(s)) =========
-- Requires: rights schema, mediaasset schema
ALTER TABLE `media_broadcasting_ecm`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_asset_collection_id` FOREIGN KEY (`asset_collection_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_collection`(`asset_collection_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`grant` ADD CONSTRAINT `fk_rights_grant_asset_collection_id` FOREIGN KEY (`asset_collection_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_collection`(`asset_collection_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`grant` ADD CONSTRAINT `fk_rights_grant_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`rights_content_window` ADD CONSTRAINT `fk_rights_rights_content_window_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`holdback` ADD CONSTRAINT `fk_rights_holdback_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`holdback` ADD CONSTRAINT `fk_rights_holdback_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`music_sync_license` ADD CONSTRAINT `fk_rights_music_sync_license_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`music_sync_license` ADD CONSTRAINT `fk_rights_music_sync_license_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`rights_availability_window` ADD CONSTRAINT `fk_rights_rights_availability_window_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`rights_availability_window` ADD CONSTRAINT `fk_rights_rights_availability_window_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= rights --> partner (15 constraint(s)) =========
-- Requires: rights schema, partner schema
ALTER TABLE `media_broadcasting_ecm`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`grant` ADD CONSTRAINT `fk_rights_grant_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`holdback` ADD CONSTRAINT `fk_rights_holdback_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`music_sync_license` ADD CONSTRAINT `fk_rights_music_sync_license_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`holder` ADD CONSTRAINT `fk_rights_holder_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);

-- ========= rights --> production (2 constraint(s)) =========
-- Requires: rights schema, production schema
ALTER TABLE `media_broadcasting_ecm`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `media_broadcasting_ecm`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`music_sync_license` ADD CONSTRAINT `fk_rights_music_sync_license_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `media_broadcasting_ecm`.`production`.`production_episode`(`production_episode_id`);

-- ========= rights --> sales (4 constraint(s)) =========
-- Requires: rights schema, sales schema
ALTER TABLE `media_broadcasting_ecm`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_sponsorship_id` FOREIGN KEY (`sponsorship_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sponsorship`(`sponsorship_id`);

-- ========= rights --> subscriber (1 constraint(s)) =========
-- Requires: rights schema, subscriber schema
ALTER TABLE `media_broadcasting_ecm`.`rights`.`rights_availability_window` ADD CONSTRAINT `fk_rights_rights_availability_window_subscription_plan_id` FOREIGN KEY (`subscription_plan_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscription_plan`(`subscription_plan_id`);

-- ========= rights --> talent (10 constraint(s)) =========
-- Requires: rights schema, talent schema
ALTER TABLE `media_broadcasting_ecm`.`rights`.`holdback` ADD CONSTRAINT `fk_rights_holdback_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`contract`(`contract_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`royalty_rule` ADD CONSTRAINT `fk_rights_royalty_rule_cba_rate_card_id` FOREIGN KEY (`cba_rate_card_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`cba_rate_card`(`cba_rate_card_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`contract`(`contract_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_guild_affiliation_id` FOREIGN KEY (`guild_affiliation_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`guild_affiliation`(`guild_affiliation_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`music_sync_license` ADD CONSTRAINT `fk_rights_music_sync_license_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`contract`(`contract_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`music_sync_license` ADD CONSTRAINT `fk_rights_music_sync_license_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`contract`(`contract_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`holder` ADD CONSTRAINT `fk_rights_holder_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= sales --> audience (13 constraint(s)) =========
-- Requires: sales schema, audience schema
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ADD CONSTRAINT `fk_sales_makegood_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ADD CONSTRAINT `fk_sales_advertising_audience_guarantee_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);

-- ========= sales --> billing (2 constraint(s)) =========
-- Requires: sales schema, billing schema
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`billing_account`(`billing_account_id`);

-- ========= sales --> compliance (12 constraint(s)) =========
-- Requires: sales schema, compliance schema
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_political_ad_record_id` FOREIGN KEY (`political_ad_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`political_ad_record`(`political_ad_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ADD CONSTRAINT `fk_sales_makegood_political_ad_record_id` FOREIGN KEY (`political_ad_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`political_ad_record`(`political_ad_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);

-- ========= sales --> content (14 constraint(s)) =========
-- Requires: sales schema, content schema
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `media_broadcasting_ecm`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ADD CONSTRAINT `fk_sales_makegood_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `media_broadcasting_ecm`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ADD CONSTRAINT `fk_sales_advertising_audience_guarantee_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_season_id` FOREIGN KEY (`season_id`) REFERENCES `media_broadcasting_ecm`.`content`.`season`(`season_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `media_broadcasting_ecm`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);

-- ========= sales --> distribution (13 constraint(s)) =========
-- Requires: sales schema, distribution schema
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_device_type_id` FOREIGN KEY (`device_type_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`device_type`(`device_type_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_device_type_id` FOREIGN KEY (`device_type_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`device_type`(`device_type_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_playback_session_id` FOREIGN KEY (`playback_session_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`playback_session`(`playback_session_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);

-- ========= sales --> finance (20 constraint(s)) =========
-- Requires: sales schema, finance schema
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ADD CONSTRAINT `fk_sales_advertiser_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_agency` ADD CONSTRAINT `fk_sales_sales_agency_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_revenue_recognition_event_id` FOREIGN KEY (`revenue_recognition_event_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ADD CONSTRAINT `fk_sales_makegood_revenue_recognition_event_id` FOREIGN KEY (`revenue_recognition_event_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ADD CONSTRAINT `fk_sales_advertising_audience_guarantee_revenue_recognition_event_id` FOREIGN KEY (`revenue_recognition_event_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ADD CONSTRAINT `fk_sales_sales_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ADD CONSTRAINT `fk_sales_sales_territory_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= sales --> mediaasset (5 constraint(s)) =========
-- Requires: sales schema, mediaasset schema
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_asset_collection_id` FOREIGN KEY (`asset_collection_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_collection`(`asset_collection_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_asset_collection_id` FOREIGN KEY (`asset_collection_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_collection`(`asset_collection_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= sales --> partner (7 constraint(s)) =========
-- Requires: sales schema, partner schema
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ADD CONSTRAINT `fk_sales_sales_account_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);

-- ========= sales --> rights (9 constraint(s)) =========
-- Requires: sales schema, rights schema
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_music_sync_license_id` FOREIGN KEY (`music_sync_license_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`music_sync_license`(`music_sync_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_rights_availability_window_id` FOREIGN KEY (`rights_availability_window_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_availability_window`(`rights_availability_window_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_rights_availability_window_id` FOREIGN KEY (`rights_availability_window_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_availability_window`(`rights_availability_window_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_territory`(`rights_territory_id`);

-- ========= sales --> scheduling (19 constraint(s)) =========
-- Requires: sales schema, scheduling schema
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_ad_break_id` FOREIGN KEY (`ad_break_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`ad_break`(`ad_break_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ADD CONSTRAINT `fk_sales_makegood_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ADD CONSTRAINT `fk_sales_makegood_makegood_proposed_channel_id` FOREIGN KEY (`makegood_proposed_channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ADD CONSTRAINT `fk_sales_makegood_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ADD CONSTRAINT `fk_sales_advertising_audience_guarantee_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ADD CONSTRAINT `fk_sales_advertising_audience_guarantee_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_ad_break_id` FOREIGN KEY (`ad_break_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`ad_break`(`ad_break_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_ad_break_id` FOREIGN KEY (`ad_break_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`ad_break`(`ad_break_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`daypart`(`daypart_id`);

-- ========= sales --> subscriber (2 constraint(s)) =========
-- Requires: sales schema, subscriber schema
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);

-- ========= sales --> talent (4 constraint(s)) =========
-- Requires: sales schema, talent schema
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= scheduling --> audience (5 constraint(s)) =========
-- Requires: scheduling schema, audience schema
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`channel` ADD CONSTRAINT `fk_scheduling_channel_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`daypart` ADD CONSTRAINT `fk_scheduling_daypart_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_schedule` ADD CONSTRAINT `fk_scheduling_program_schedule_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`ad_break` ADD CONSTRAINT `fk_scheduling_ad_break_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`scheduling_availability_window` ADD CONSTRAINT `fk_scheduling_scheduling_availability_window_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);

-- ========= scheduling --> billing (1 constraint(s)) =========
-- Requires: scheduling schema, billing schema
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`channel` ADD CONSTRAINT `fk_scheduling_channel_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`billing_account`(`billing_account_id`);

-- ========= scheduling --> compliance (12 constraint(s)) =========
-- Requires: scheduling schema, compliance schema
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`channel` ADD CONSTRAINT `fk_scheduling_channel_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`daypart` ADD CONSTRAINT `fk_scheduling_daypart_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_schedule` ADD CONSTRAINT `fk_scheduling_program_schedule_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_schedule` ADD CONSTRAINT `fk_scheduling_program_schedule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`ad_break` ADD CONSTRAINT `fk_scheduling_ad_break_political_ad_record_id` FOREIGN KEY (`political_ad_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`political_ad_record`(`political_ad_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_closed_caption_record_id` FOREIGN KEY (`closed_caption_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`closed_caption_record`(`closed_caption_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_eas_log_id` FOREIGN KEY (`eas_log_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`eas_log`(`eas_log_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`scheduling_availability_window` ADD CONSTRAINT `fk_scheduling_scheduling_availability_window_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= scheduling --> content (20 constraint(s)) =========
-- Requires: scheduling schema, content schema
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`channel` ADD CONSTRAINT `fk_scheduling_channel_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `media_broadcasting_ecm`.`content`.`genre`(`genre_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`daypart` ADD CONSTRAINT `fk_scheduling_daypart_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `media_broadcasting_ecm`.`content`.`genre`(`genre_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `media_broadcasting_ecm`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_version_id` FOREIGN KEY (`version_id`) REFERENCES `media_broadcasting_ecm`.`content`.`version`(`version_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `media_broadcasting_ecm`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_version_id` FOREIGN KEY (`version_id`) REFERENCES `media_broadcasting_ecm`.`content`.`version`(`version_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `media_broadcasting_ecm`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_version_id` FOREIGN KEY (`version_id`) REFERENCES `media_broadcasting_ecm`.`content`.`version`(`version_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `media_broadcasting_ecm`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_version_id` FOREIGN KEY (`version_id`) REFERENCES `media_broadcasting_ecm`.`content`.`version`(`version_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `media_broadcasting_ecm`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_version_id` FOREIGN KEY (`version_id`) REFERENCES `media_broadcasting_ecm`.`content`.`version`(`version_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`scheduling_availability_window` ADD CONSTRAINT `fk_scheduling_scheduling_availability_window_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`scheduling_availability_window` ADD CONSTRAINT `fk_scheduling_scheduling_availability_window_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`scheduling_availability_window` ADD CONSTRAINT `fk_scheduling_scheduling_availability_window_version_id` FOREIGN KEY (`version_id`) REFERENCES `media_broadcasting_ecm`.`content`.`version`(`version_id`);

-- ========= scheduling --> distribution (21 constraint(s)) =========
-- Requires: scheduling schema, distribution schema
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`daypart` ADD CONSTRAINT `fk_scheduling_daypart_dai_configuration_id` FOREIGN KEY (`dai_configuration_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`dai_configuration`(`dai_configuration_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_schedule` ADD CONSTRAINT `fk_scheduling_program_schedule_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_schedule` ADD CONSTRAINT `fk_scheduling_program_schedule_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`ad_break` ADD CONSTRAINT `fk_scheduling_ad_break_dai_configuration_id` FOREIGN KEY (`dai_configuration_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`dai_configuration`(`dai_configuration_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`ad_break` ADD CONSTRAINT `fk_scheduling_ad_break_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_dai_configuration_id` FOREIGN KEY (`dai_configuration_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`dai_configuration`(`dai_configuration_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`scheduling_availability_window` ADD CONSTRAINT `fk_scheduling_scheduling_availability_window_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`scheduling_availability_window` ADD CONSTRAINT `fk_scheduling_scheduling_availability_window_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`drm_policy`(`drm_policy_id`);

-- ========= scheduling --> finance (11 constraint(s)) =========
-- Requires: scheduling schema, finance schema
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`channel` ADD CONSTRAINT `fk_scheduling_channel_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`channel` ADD CONSTRAINT `fk_scheduling_channel_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`daypart` ADD CONSTRAINT `fk_scheduling_daypart_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_schedule` ADD CONSTRAINT `fk_scheduling_program_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_schedule` ADD CONSTRAINT `fk_scheduling_program_schedule_production_budget_id` FOREIGN KEY (`production_budget_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`production_budget`(`production_budget_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`ad_break` ADD CONSTRAINT `fk_scheduling_ad_break_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_production_budget_id` FOREIGN KEY (`production_budget_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`production_budget`(`production_budget_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`scheduling_availability_window` ADD CONSTRAINT `fk_scheduling_scheduling_availability_window_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);

-- ========= scheduling --> mediaasset (15 constraint(s)) =========
-- Requires: scheduling schema, mediaasset schema
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`channel` ADD CONSTRAINT `fk_scheduling_channel_format_specification_id` FOREIGN KEY (`format_specification_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`format_specification`(`format_specification_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_schedule` ADD CONSTRAINT `fk_scheduling_program_schedule_asset_collection_id` FOREIGN KEY (`asset_collection_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_collection`(`asset_collection_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_format_specification_id` FOREIGN KEY (`format_specification_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`format_specification`(`format_specification_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`scheduling_availability_window` ADD CONSTRAINT `fk_scheduling_scheduling_availability_window_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`scheduling_availability_window` ADD CONSTRAINT `fk_scheduling_scheduling_availability_window_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= scheduling --> partner (20 constraint(s)) =========
-- Requires: scheduling schema, partner schema
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`channel` ADD CONSTRAINT `fk_scheduling_channel_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_schedule` ADD CONSTRAINT `fk_scheduling_program_schedule_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_schedule` ADD CONSTRAINT `fk_scheduling_program_schedule_affiliate_agreement_id` FOREIGN KEY (`affiliate_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`affiliate_agreement`(`affiliate_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_schedule` ADD CONSTRAINT `fk_scheduling_program_schedule_coproduction_agreement_id` FOREIGN KEY (`coproduction_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`coproduction_agreement`(`coproduction_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_schedule` ADD CONSTRAINT `fk_scheduling_program_schedule_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_schedule` ADD CONSTRAINT `fk_scheduling_program_schedule_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_affiliate_agreement_id` FOREIGN KEY (`affiliate_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`affiliate_agreement`(`affiliate_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_affiliate_agreement_id` FOREIGN KEY (`affiliate_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`affiliate_agreement`(`affiliate_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`scheduling_availability_window` ADD CONSTRAINT `fk_scheduling_scheduling_availability_window_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`acquisition_deal`(`acquisition_deal_id`);

-- ========= scheduling --> rights (16 constraint(s)) =========
-- Requires: scheduling schema, rights schema
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_schedule` ADD CONSTRAINT `fk_scheduling_program_schedule_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_holdback_id` FOREIGN KEY (`holdback_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`holdback`(`holdback_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_rights_availability_window_id` FOREIGN KEY (`rights_availability_window_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_availability_window`(`rights_availability_window_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_holdback_id` FOREIGN KEY (`holdback_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`holdback`(`holdback_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_clearance_request_id` FOREIGN KEY (`clearance_request_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`clearance_request`(`clearance_request_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_holdback_id` FOREIGN KEY (`holdback_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`holdback`(`holdback_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_clearance_request_id` FOREIGN KEY (`clearance_request_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`clearance_request`(`clearance_request_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_clearance_request_id` FOREIGN KEY (`clearance_request_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`clearance_request`(`clearance_request_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_music_sync_license_id` FOREIGN KEY (`music_sync_license_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`music_sync_license`(`music_sync_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`scheduling_availability_window` ADD CONSTRAINT `fk_scheduling_scheduling_availability_window_rights_availability_window_id` FOREIGN KEY (`rights_availability_window_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_availability_window`(`rights_availability_window_id`);

-- ========= scheduling --> subscriber (2 constraint(s)) =========
-- Requires: scheduling schema, subscriber schema
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_subscription_plan_id` FOREIGN KEY (`subscription_plan_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscription_plan`(`subscription_plan_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`scheduling_availability_window` ADD CONSTRAINT `fk_scheduling_scheduling_availability_window_subscription_plan_id` FOREIGN KEY (`subscription_plan_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscription_plan`(`subscription_plan_id`);

-- ========= scheduling --> talent (11 constraint(s)) =========
-- Requires: scheduling schema, talent schema
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`contract`(`contract_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_appearance_schedule_id` FOREIGN KEY (`appearance_schedule_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`appearance_schedule`(`appearance_schedule_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`contract`(`contract_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_role_id` FOREIGN KEY (`role_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`role`(`role_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_appearance_schedule_id` FOREIGN KEY (`appearance_schedule_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`appearance_schedule`(`appearance_schedule_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_role_id` FOREIGN KEY (`role_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`role`(`role_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= subscriber --> audience (10 constraint(s)) =========
-- Requires: subscriber schema, audience schema
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscriber` ADD CONSTRAINT `fk_subscriber_subscriber_audience_profile_id` FOREIGN KEY (`audience_profile_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`audience_profile`(`audience_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`household` ADD CONSTRAINT `fk_subscriber_household_audience_profile_id` FOREIGN KEY (`audience_profile_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`audience_profile`(`audience_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`household` ADD CONSTRAINT `fk_subscriber_household_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscription_plan` ADD CONSTRAINT `fk_subscriber_subscription_plan_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`device_registration` ADD CONSTRAINT `fk_subscriber_device_registration_audience_profile_id` FOREIGN KEY (`audience_profile_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`audience_profile`(`audience_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`viewer_profile` ADD CONSTRAINT `fk_subscriber_viewer_profile_audience_profile_id` FOREIGN KEY (`audience_profile_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`audience_profile`(`audience_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`viewer_profile` ADD CONSTRAINT `fk_subscriber_viewer_profile_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`offer` ADD CONSTRAINT `fk_subscriber_offer_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`offer` ADD CONSTRAINT `fk_subscriber_offer_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);

-- ========= subscriber --> billing (9 constraint(s)) =========
-- Requires: subscriber schema, billing schema
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscription` ADD CONSTRAINT `fk_subscriber_subscription_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscription` ADD CONSTRAINT `fk_subscriber_subscription_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`payment_method`(`payment_method_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_credit_memo_id` FOREIGN KEY (`credit_memo_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`credit_memo`(`credit_memo_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_refund_id` FOREIGN KEY (`refund_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`refund`(`refund_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscription_change` ADD CONSTRAINT `fk_subscriber_subscription_change_credit_memo_id` FOREIGN KEY (`credit_memo_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`credit_memo`(`credit_memo_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscription_change` ADD CONSTRAINT `fk_subscriber_subscription_change_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`payment_instrument` ADD CONSTRAINT `fk_subscriber_payment_instrument_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`payment_method`(`payment_method_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`offer_redemption` ADD CONSTRAINT `fk_subscriber_offer_redemption_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= subscriber --> compliance (6 constraint(s)) =========
-- Requires: subscriber schema, compliance schema
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`household` ADD CONSTRAINT `fk_subscriber_household_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscription_plan` ADD CONSTRAINT `fk_subscriber_subscription_plan_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`viewer_profile` ADD CONSTRAINT `fk_subscriber_viewer_profile_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`offer` ADD CONSTRAINT `fk_subscriber_offer_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= subscriber --> content (14 constraint(s)) =========
-- Requires: subscriber schema, content schema
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`household` ADD CONSTRAINT `fk_subscriber_household_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `media_broadcasting_ecm`.`content`.`rating`(`rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscription_plan` ADD CONSTRAINT `fk_subscriber_subscription_plan_package_id` FOREIGN KEY (`package_id`) REFERENCES `media_broadcasting_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscription` ADD CONSTRAINT `fk_subscriber_subscription_package_id` FOREIGN KEY (`package_id`) REFERENCES `media_broadcasting_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_package_id` FOREIGN KEY (`package_id`) REFERENCES `media_broadcasting_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `media_broadcasting_ecm`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_version_id` FOREIGN KEY (`version_id`) REFERENCES `media_broadcasting_ecm`.`content`.`version`(`version_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_season_id` FOREIGN KEY (`season_id`) REFERENCES `media_broadcasting_ecm`.`content`.`season`(`season_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`parental_control` ADD CONSTRAINT `fk_subscriber_parental_control_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `media_broadcasting_ecm`.`content`.`rating`(`rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`viewer_profile` ADD CONSTRAINT `fk_subscriber_viewer_profile_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `media_broadcasting_ecm`.`content`.`genre`(`genre_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`offer_redemption` ADD CONSTRAINT `fk_subscriber_offer_redemption_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`offer` ADD CONSTRAINT `fk_subscriber_offer_package_id` FOREIGN KEY (`package_id`) REFERENCES `media_broadcasting_ecm`.`content`.`package`(`package_id`);

-- ========= subscriber --> distribution (16 constraint(s)) =========
-- Requires: subscriber schema, distribution schema
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`household` ADD CONSTRAINT `fk_subscriber_household_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`distribution_partner`(`distribution_partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscription_plan` ADD CONSTRAINT `fk_subscriber_subscription_plan_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscription` ADD CONSTRAINT `fk_subscriber_subscription_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`device_registration` ADD CONSTRAINT `fk_subscriber_device_registration_device_type_id` FOREIGN KEY (`device_type_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`device_type`(`device_type_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`device_registration` ADD CONSTRAINT `fk_subscriber_device_registration_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_release_window_id` FOREIGN KEY (`release_window_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`release_window`(`release_window_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`parental_control` ADD CONSTRAINT `fk_subscriber_parental_control_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`viewer_profile` ADD CONSTRAINT `fk_subscriber_viewer_profile_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`viewer_profile` ADD CONSTRAINT `fk_subscriber_viewer_profile_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`distribution_partner`(`distribution_partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscription_change` ADD CONSTRAINT `fk_subscriber_subscription_change_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`offer` ADD CONSTRAINT `fk_subscriber_offer_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);

-- ========= subscriber --> finance (16 constraint(s)) =========
-- Requires: subscriber schema, finance schema
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscription_plan` ADD CONSTRAINT `fk_subscriber_subscription_plan_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscription_plan` ADD CONSTRAINT `fk_subscriber_subscription_plan_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscription` ADD CONSTRAINT `fk_subscriber_subscription_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscription` ADD CONSTRAINT `fk_subscriber_subscription_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_revenue_recognition_event_id` FOREIGN KEY (`revenue_recognition_event_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscription_change` ADD CONSTRAINT `fk_subscriber_subscription_change_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscription_change` ADD CONSTRAINT `fk_subscriber_subscription_change_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`payment_instrument` ADD CONSTRAINT `fk_subscriber_payment_instrument_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`offer_redemption` ADD CONSTRAINT `fk_subscriber_offer_redemption_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`offer_redemption` ADD CONSTRAINT `fk_subscriber_offer_redemption_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`offer_redemption` ADD CONSTRAINT `fk_subscriber_offer_redemption_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`offer` ADD CONSTRAINT `fk_subscriber_offer_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`offer` ADD CONSTRAINT `fk_subscriber_offer_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);

-- ========= subscriber --> mediaasset (4 constraint(s)) =========
-- Requires: subscriber schema, mediaasset schema
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_format_specification_id` FOREIGN KEY (`format_specification_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`format_specification`(`format_specification_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`viewer_profile` ADD CONSTRAINT `fk_subscriber_viewer_profile_format_specification_id` FOREIGN KEY (`format_specification_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`format_specification`(`format_specification_id`);

-- ========= subscriber --> partner (9 constraint(s)) =========
-- Requires: subscriber schema, partner schema
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`household` ADD CONSTRAINT `fk_subscriber_household_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscription_plan` ADD CONSTRAINT `fk_subscriber_subscription_plan_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscription` ADD CONSTRAINT `fk_subscriber_subscription_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_partner_content_window_id` FOREIGN KEY (`partner_content_window_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_content_window`(`partner_content_window_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscription_change` ADD CONSTRAINT `fk_subscriber_subscription_change_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`offer_redemption` ADD CONSTRAINT `fk_subscriber_offer_redemption_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`offer` ADD CONSTRAINT `fk_subscriber_offer_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);

-- ========= subscriber --> rights (4 constraint(s)) =========
-- Requires: subscriber schema, rights schema
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscription_plan` ADD CONSTRAINT `fk_subscriber_subscription_plan_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscription` ADD CONSTRAINT `fk_subscriber_subscription_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_holdback_id` FOREIGN KEY (`holdback_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`holdback`(`holdback_id`);

-- ========= subscriber --> sales (3 constraint(s)) =========
-- Requires: subscriber schema, sales schema
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_sponsorship_id` FOREIGN KEY (`sponsorship_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sponsorship`(`sponsorship_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`offer_redemption` ADD CONSTRAINT `fk_subscriber_offer_redemption_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`offer` ADD CONSTRAINT `fk_subscriber_offer_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);

-- ========= subscriber --> scheduling (2 constraint(s)) =========
-- Requires: subscriber schema, scheduling schema
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_scheduling_availability_window_id` FOREIGN KEY (`scheduling_availability_window_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`scheduling_availability_window`(`scheduling_availability_window_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);

-- ========= talent --> audience (5 constraint(s)) =========
-- Requires: talent schema, audience schema
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ADD CONSTRAINT `fk_talent_compensation_structure_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_nielsen_rating_id` FOREIGN KEY (`nielsen_rating_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`nielsen_rating`(`nielsen_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);

-- ========= talent --> billing (4 constraint(s)) =========
-- Requires: talent schema, billing schema
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`payment`(`payment_id`);

-- ========= talent --> compliance (9 constraint(s)) =========
-- Requires: talent schema, compliance schema
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ADD CONSTRAINT `fk_talent_guild_affiliation_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ADD CONSTRAINT `fk_talent_compensation_structure_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ADD CONSTRAINT `fk_talent_talent_agency_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ADD CONSTRAINT `fk_talent_representation_agreement_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ADD CONSTRAINT `fk_talent_cba_rate_card_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= talent --> content (14 constraint(s)) =========
-- Requires: talent schema, content schema
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_season_id` FOREIGN KEY (`season_id`) REFERENCES `media_broadcasting_ecm`.`content`.`season`(`season_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `media_broadcasting_ecm`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `media_broadcasting_ecm`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_season_id` FOREIGN KEY (`season_id`) REFERENCES `media_broadcasting_ecm`.`content`.`season`(`season_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_season_id` FOREIGN KEY (`season_id`) REFERENCES `media_broadcasting_ecm`.`content`.`season`(`season_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ADD CONSTRAINT `fk_talent_availability_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);

-- ========= talent --> distribution (2 constraint(s)) =========
-- Requires: talent schema, distribution schema
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);

-- ========= talent --> finance (15 constraint(s)) =========
-- Requires: talent schema, finance schema
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ADD CONSTRAINT `fk_talent_talent_profile_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ADD CONSTRAINT `fk_talent_guild_affiliation_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ADD CONSTRAINT `fk_talent_compensation_structure_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ADD CONSTRAINT `fk_talent_compensation_structure_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ADD CONSTRAINT `fk_talent_compensation_structure_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_production_budget_id` FOREIGN KEY (`production_budget_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`production_budget`(`production_budget_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ADD CONSTRAINT `fk_talent_talent_agency_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ADD CONSTRAINT `fk_talent_cba_rate_card_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);

-- ========= talent --> mediaasset (3 constraint(s)) =========
-- Requires: talent schema, mediaasset schema
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= talent --> partner (6 constraint(s)) =========
-- Requires: talent schema, partner schema
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ADD CONSTRAINT `fk_talent_talent_agency_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);

-- ========= talent --> production (6 constraint(s)) =========
-- Requires: talent schema, production schema
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_shoot_schedule_id` FOREIGN KEY (`shoot_schedule_id`) REFERENCES `media_broadcasting_ecm`.`production`.`shoot_schedule`(`shoot_schedule_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `media_broadcasting_ecm`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `media_broadcasting_ecm`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ADD CONSTRAINT `fk_talent_availability_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);

-- ========= talent --> sales (3 constraint(s)) =========
-- Requires: talent schema, sales schema
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ADD CONSTRAINT `fk_talent_talent_agency_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ADD CONSTRAINT `fk_talent_availability_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);

