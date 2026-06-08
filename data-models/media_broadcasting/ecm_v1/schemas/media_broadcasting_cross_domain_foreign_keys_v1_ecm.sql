-- Cross-Domain Foreign Keys for Business: Media Broadcasting | Version: v1_ecm
-- Generated on: 2026-05-08 17:13:13
-- Total cross-domain FK constraints: 1455
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: advertising, audience, billing, compliance, content, distribution, finance, mediaasset, partner, production, rights, sales, scheduling, subscriber, talent, technology, workforce

-- ========= advertising --> audience (2 constraint(s)) =========
-- Requires: advertising schema, audience schema
ALTER TABLE `media_broadcasting_ecm`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`advertising`.`rate_card` ADD CONSTRAINT `fk_advertising_rate_card_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);

-- ========= advertising --> content (2 constraint(s)) =========
-- Requires: advertising schema, content schema
ALTER TABLE `media_broadcasting_ecm`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_program_title_id` FOREIGN KEY (`program_title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);

-- ========= advertising --> partner (1 constraint(s)) =========
-- Requires: advertising schema, partner schema
ALTER TABLE `media_broadcasting_ecm`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);

-- ========= advertising --> rights (1 constraint(s)) =========
-- Requires: advertising schema, rights schema
ALTER TABLE `media_broadcasting_ecm`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);

-- ========= advertising --> scheduling (3 constraint(s)) =========
-- Requires: advertising schema, scheduling schema
ALTER TABLE `media_broadcasting_ecm`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `media_broadcasting_ecm`.`advertising`.`rate_card` ADD CONSTRAINT `fk_advertising_rate_card_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);

-- ========= advertising --> workforce (1 constraint(s)) =========
-- Requires: advertising schema, workforce schema
ALTER TABLE `media_broadcasting_ecm`.`advertising`.`rate_card` ADD CONSTRAINT `fk_advertising_rate_card_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= audience --> compliance (30 constraint(s)) =========
-- Requires: audience schema, compliance schema
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_closed_caption_record_id` FOREIGN KEY (`closed_caption_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`closed_caption_record`(`closed_caption_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_eas_log_id` FOREIGN KEY (`eas_log_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`eas_log`(`eas_log_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_political_ad_record_id` FOREIGN KEY (`political_ad_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`political_ad_record`(`political_ad_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`sweeps_period` ADD CONSTRAINT `fk_audience_sweeps_period_calendar_id` FOREIGN KEY (`calendar_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`calendar`(`calendar_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`sweeps_period` ADD CONSTRAINT `fk_audience_sweeps_period_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`panel` ADD CONSTRAINT `fk_audience_panel_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_closed_caption_record_id` FOREIGN KEY (`closed_caption_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`closed_caption_record`(`closed_caption_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_compliance_consent_record_id` FOREIGN KEY (`compliance_consent_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`compliance_consent_record`(`compliance_consent_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_privacy_request_id` FOREIGN KEY (`privacy_request_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`privacy_request`(`privacy_request_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_political_ad_record_id` FOREIGN KEY (`political_ad_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`political_ad_record`(`political_ad_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`market_coverage` ADD CONSTRAINT `fk_audience_market_coverage_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`market_coverage` ADD CONSTRAINT `fk_audience_market_coverage_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_compliance_consent_record_id` FOREIGN KEY (`compliance_consent_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`compliance_consent_record`(`compliance_consent_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_privacy_request_id` FOREIGN KEY (`privacy_request_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`privacy_request`(`privacy_request_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_political_ad_record_id` FOREIGN KEY (`political_ad_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`political_ad_record`(`political_ad_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`segment` ADD CONSTRAINT `fk_audience_segment_coppa_declaration_id` FOREIGN KEY (`coppa_declaration_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`coppa_declaration`(`coppa_declaration_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`segment_regulatory_compliance` ADD CONSTRAINT `fk_audience_segment_regulatory_compliance_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= audience --> content (4 constraint(s)) =========
-- Requires: audience schema, content schema
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);

-- ========= audience --> distribution (4 constraint(s)) =========
-- Requires: audience schema, distribution schema
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_device_type_id` FOREIGN KEY (`device_type_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`device_type`(`device_type_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_playback_session_id` FOREIGN KEY (`playback_session_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`playback_session`(`playback_session_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_playback_session_id` FOREIGN KEY (`playback_session_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`playback_session`(`playback_session_id`);

-- ========= audience --> finance (7 constraint(s)) =========
-- Requires: audience schema, finance schema
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= audience --> partner (6 constraint(s)) =========
-- Requires: audience schema, partner schema
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`market_distribution_agreement` ADD CONSTRAINT `fk_audience_market_distribution_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`partner_demographic_target` ADD CONSTRAINT `fk_audience_partner_demographic_target_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);

-- ========= audience --> production (9 constraint(s)) =========
-- Requires: audience schema, production schema
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `media_broadcasting_ecm`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `media_broadcasting_ecm`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `media_broadcasting_ecm`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `media_broadcasting_ecm`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);

-- ========= audience --> sales (15 constraint(s)) =========
-- Requires: audience schema, sales schema
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_sales_proposal_id` FOREIGN KEY (`sales_proposal_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_proposal`(`sales_proposal_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);

-- ========= audience --> scheduling (10 constraint(s)) =========
-- Requires: audience schema, scheduling schema
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_network_channel_id` FOREIGN KEY (`network_channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`daypart`(`daypart_id`);

-- ========= audience --> subscriber (4 constraint(s)) =========
-- Requires: audience schema, subscriber schema
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_household_id` FOREIGN KEY (`household_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`household`(`household_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_viewer_profile_id` FOREIGN KEY (`viewer_profile_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`viewer_profile`(`viewer_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_viewer_profile_id` FOREIGN KEY (`viewer_profile_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`viewer_profile`(`viewer_profile_id`);

-- ========= audience --> talent (2 constraint(s)) =========
-- Requires: audience schema, talent schema
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`contract`(`contract_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`talent_demographic_appeal` ADD CONSTRAINT `fk_audience_talent_demographic_appeal_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= audience --> technology (5 constraint(s)) =========
-- Requires: audience schema, technology schema
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`panel` ADD CONSTRAINT `fk_audience_panel_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`market_coverage` ADD CONSTRAINT `fk_audience_market_coverage_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`engagement_event` ADD CONSTRAINT `fk_audience_engagement_event_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);

-- ========= audience --> workforce (6 constraint(s)) =========
-- Requires: audience schema, workforce schema
ALTER TABLE `media_broadcasting_ecm`.`audience`.`nielsen_rating` ADD CONSTRAINT `fk_audience_nielsen_rating_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`panel` ADD CONSTRAINT `fk_audience_panel_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`viewership_record` ADD CONSTRAINT `fk_audience_viewership_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`reach_frequency_report` ADD CONSTRAINT `fk_audience_reach_frequency_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`guarantee` ADD CONSTRAINT `fk_audience_guarantee_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`audience`.`cross_platform_measurement` ADD CONSTRAINT `fk_audience_cross_platform_measurement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= billing --> audience (5 constraint(s)) =========
-- Requires: billing schema, audience schema
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_nielsen_rating_id` FOREIGN KEY (`nielsen_rating_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`nielsen_rating`(`nielsen_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_nielsen_rating_id` FOREIGN KEY (`nielsen_rating_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`nielsen_rating`(`nielsen_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`ad_billing_reconciliation` ADD CONSTRAINT `fk_billing_ad_billing_reconciliation_nielsen_rating_id` FOREIGN KEY (`nielsen_rating_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`nielsen_rating`(`nielsen_rating_id`);

-- ========= billing --> compliance (10 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_political_ad_record_id` FOREIGN KEY (`political_ad_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`political_ad_record`(`political_ad_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_political_ad_record_id` FOREIGN KEY (`political_ad_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`political_ad_record`(`political_ad_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`syndication_license_fee` ADD CONSTRAINT `fk_billing_syndication_license_fee_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`tax_record` ADD CONSTRAINT `fk_billing_tax_record_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= billing --> content (5 constraint(s)) =========
-- Requires: billing schema, content schema
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`syndication_license_fee` ADD CONSTRAINT `fk_billing_syndication_license_fee_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_compliance_finding_id` FOREIGN KEY (`compliance_finding_id`) REFERENCES `media_broadcasting_ecm`.`content`.`compliance_finding`(`compliance_finding_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`ad_billing_reconciliation` ADD CONSTRAINT `fk_billing_ad_billing_reconciliation_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);

-- ========= billing --> distribution (2 constraint(s)) =========
-- Requires: billing schema, distribution schema
ALTER TABLE `media_broadcasting_ecm`.`billing`.`billing_carriage_fee_invoice` ADD CONSTRAINT `fk_billing_billing_carriage_fee_invoice_carriage_agreement_id` FOREIGN KEY (`carriage_agreement_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`carriage_agreement`(`carriage_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`billing_carriage_fee_invoice` ADD CONSTRAINT `fk_billing_billing_carriage_fee_invoice_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`distribution_partner`(`distribution_partner_id`);

-- ========= billing --> finance (25 constraint(s)) =========
-- Requires: billing schema, finance schema
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`subscription_invoice` ADD CONSTRAINT `fk_billing_subscription_invoice_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`billing_carriage_fee_invoice` ADD CONSTRAINT `fk_billing_billing_carriage_fee_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`billing_carriage_fee_invoice` ADD CONSTRAINT `fk_billing_billing_carriage_fee_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`billing_carriage_fee_invoice` ADD CONSTRAINT `fk_billing_billing_carriage_fee_invoice_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`syndication_license_fee` ADD CONSTRAINT `fk_billing_syndication_license_fee_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`syndication_license_fee` ADD CONSTRAINT `fk_billing_syndication_license_fee_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`syndication_license_fee` ADD CONSTRAINT `fk_billing_syndication_license_fee_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`ad_billing_reconciliation` ADD CONSTRAINT `fk_billing_ad_billing_reconciliation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`ad_billing_reconciliation` ADD CONSTRAINT `fk_billing_ad_billing_reconciliation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= billing --> partner (9 constraint(s)) =========
-- Requires: billing schema, partner schema
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_performance_obligation_id` FOREIGN KEY (`performance_obligation_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`performance_obligation`(`performance_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`billing_carriage_fee_invoice` ADD CONSTRAINT `fk_billing_billing_carriage_fee_invoice_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`syndication_license_fee` ADD CONSTRAINT `fk_billing_syndication_license_fee_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`syndication_license_fee` ADD CONSTRAINT `fk_billing_syndication_license_fee_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`syndication_license_fee` ADD CONSTRAINT `fk_billing_syndication_license_fee_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);

-- ========= billing --> rights (3 constraint(s)) =========
-- Requires: billing schema, rights schema
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_rights_content_window_id` FOREIGN KEY (`rights_content_window_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_content_window`(`rights_content_window_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`syndication_license_fee` ADD CONSTRAINT `fk_billing_syndication_license_fee_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);

-- ========= billing --> sales (23 constraint(s)) =========
-- Requires: billing schema, sales schema
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_ad_order_line_id` FOREIGN KEY (`ad_order_line_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_order_line`(`ad_order_line_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_makegood_id` FOREIGN KEY (`makegood_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`makegood`(`makegood_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_upfront_deal_id` FOREIGN KEY (`upfront_deal_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`upfront_deal`(`upfront_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_makegood_id` FOREIGN KEY (`makegood_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`makegood`(`makegood_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_ad_spot_id` FOREIGN KEY (`ad_spot_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_spot`(`ad_spot_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`ad_billing_reconciliation` ADD CONSTRAINT `fk_billing_ad_billing_reconciliation_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`ad_billing_reconciliation` ADD CONSTRAINT `fk_billing_ad_billing_reconciliation_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`ad_billing_reconciliation` ADD CONSTRAINT `fk_billing_ad_billing_reconciliation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`ad_billing_reconciliation` ADD CONSTRAINT `fk_billing_ad_billing_reconciliation_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_agency`(`sales_agency_id`);

-- ========= billing --> subscriber (11 constraint(s)) =========
-- Requires: billing schema, subscriber schema
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_subscription_plan_id` FOREIGN KEY (`subscription_plan_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscription_plan`(`subscription_plan_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscription`(`subscription_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`payment_method` ADD CONSTRAINT `fk_billing_payment_method_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`subscription_invoice` ADD CONSTRAINT `fk_billing_subscription_invoice_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`subscription_invoice` ADD CONSTRAINT `fk_billing_subscription_invoice_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscription`(`subscription_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`dunning_event` ADD CONSTRAINT `fk_billing_dunning_event_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);

-- ========= billing --> talent (2 constraint(s)) =========
-- Requires: billing schema, talent schema
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`contract`(`contract_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`contract`(`contract_id`);

-- ========= billing --> technology (14 constraint(s)) =========
-- Requires: billing schema, technology schema
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`syndication_license_fee` ADD CONSTRAINT `fk_billing_syndication_license_fee_satellite_transponder_id` FOREIGN KEY (`satellite_transponder_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`satellite_transponder`(`satellite_transponder_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_outage_record_id` FOREIGN KEY (`outage_record_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`outage_record`(`outage_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_outage_record_id` FOREIGN KEY (`outage_record_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`outage_record`(`outage_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_outage_record_id` FOREIGN KEY (`outage_record_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`outage_record`(`outage_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`ad_billing_reconciliation` ADD CONSTRAINT `fk_billing_ad_billing_reconciliation_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`ad_billing_reconciliation` ADD CONSTRAINT `fk_billing_ad_billing_reconciliation_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`transmission_equipment`(`transmission_equipment_id`);

-- ========= billing --> workforce (20 constraint(s)) =========
-- Requires: billing schema, workforce schema
ALTER TABLE `media_broadcasting_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`payment_method` ADD CONSTRAINT `fk_billing_payment_method_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`subscription_invoice` ADD CONSTRAINT `fk_billing_subscription_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`ad_billing_order` ADD CONSTRAINT `fk_billing_ad_billing_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`billing_carriage_fee_invoice` ADD CONSTRAINT `fk_billing_billing_carriage_fee_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`syndication_license_fee` ADD CONSTRAINT `fk_billing_syndication_license_fee_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_tertiary_credit_modified_by_user_employee_id` FOREIGN KEY (`tertiary_credit_modified_by_user_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`dunning_event` ADD CONSTRAINT `fk_billing_dunning_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule` ADD CONSTRAINT `fk_billing_revenue_recognition_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`tax_record` ADD CONSTRAINT `fk_billing_tax_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`run` ADD CONSTRAINT `fk_billing_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`run` ADD CONSTRAINT `fk_billing_run_run_employee_id` FOREIGN KEY (`run_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`billing`.`ad_billing_reconciliation` ADD CONSTRAINT `fk_billing_ad_billing_reconciliation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= compliance --> content (6 constraint(s)) =========
-- Requires: compliance schema, content schema
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`content_rating` ADD CONSTRAINT `fk_compliance_content_rating_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`coppa_declaration` ADD CONSTRAINT `fk_compliance_coppa_declaration_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `media_broadcasting_ecm`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);

-- ========= compliance --> distribution (3 constraint(s)) =========
-- Requires: compliance schema, distribution schema
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`coppa_declaration` ADD CONSTRAINT `fk_compliance_coppa_declaration_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`compliance_consent_record` ADD CONSTRAINT `fk_compliance_compliance_consent_record_device_type_id` FOREIGN KEY (`device_type_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`device_type`(`device_type_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`delivery_channel`(`delivery_channel_id`);

-- ========= compliance --> mediaasset (10 constraint(s)) =========
-- Requires: compliance schema, mediaasset schema
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`public_inspection_file` ADD CONSTRAINT `fk_compliance_public_inspection_file_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`content_rating` ADD CONSTRAINT `fk_compliance_content_rating_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`coppa_declaration` ADD CONSTRAINT `fk_compliance_coppa_declaration_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`eas_log` ADD CONSTRAINT `fk_compliance_eas_log_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`political_ad_record` ADD CONSTRAINT `fk_compliance_political_ad_record_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`ad_standards_clearance` ADD CONSTRAINT `fk_compliance_ad_standards_clearance_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= compliance --> partner (2 constraint(s)) =========
-- Requires: compliance schema, partner schema
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`political_ad_record` ADD CONSTRAINT `fk_compliance_political_ad_record_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);

-- ========= compliance --> sales (3 constraint(s)) =========
-- Requires: compliance schema, sales schema
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`political_ad_record` ADD CONSTRAINT `fk_compliance_political_ad_record_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`ad_standards_clearance` ADD CONSTRAINT `fk_compliance_ad_standards_clearance_isci_creative_id` FOREIGN KEY (`isci_creative_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`isci_creative`(`isci_creative_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`ad_standards_clearance` ADD CONSTRAINT `fk_compliance_ad_standards_clearance_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`advertiser`(`advertiser_id`);

-- ========= compliance --> scheduling (4 constraint(s)) =========
-- Requires: compliance schema, scheduling schema
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`public_inspection_file` ADD CONSTRAINT `fk_compliance_public_inspection_file_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`eas_log` ADD CONSTRAINT `fk_compliance_eas_log_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`calendar` ADD CONSTRAINT `fk_compliance_calendar_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);

-- ========= compliance --> subscriber (2 constraint(s)) =========
-- Requires: compliance schema, subscriber schema
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`compliance_consent_record` ADD CONSTRAINT `fk_compliance_compliance_consent_record_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);

-- ========= compliance --> talent (2 constraint(s)) =========
-- Requires: compliance schema, talent schema
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`political_ad_record` ADD CONSTRAINT `fk_compliance_political_ad_record_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= compliance --> technology (15 constraint(s)) =========
-- Requires: compliance schema, technology schema
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`broadcast_license` ADD CONSTRAINT `fk_compliance_broadcast_license_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`broadcast_license` ADD CONSTRAINT `fk_compliance_broadcast_license_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_encoder_config_id` FOREIGN KEY (`encoder_config_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`encoder_config`(`encoder_config_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`eas_log` ADD CONSTRAINT `fk_compliance_eas_log_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_encoder_config_id` FOREIGN KEY (`encoder_config_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`encoder_config`(`encoder_config_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`technical_standard_cert` ADD CONSTRAINT `fk_compliance_technical_standard_cert_encoder_config_id` FOREIGN KEY (`encoder_config_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`encoder_config`(`encoder_config_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`technical_standard_cert` ADD CONSTRAINT `fk_compliance_technical_standard_cert_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`calendar` ADD CONSTRAINT `fk_compliance_calendar_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`facility_compliance_obligation` ADD CONSTRAINT `fk_compliance_facility_compliance_obligation_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`facility_compliance` ADD CONSTRAINT `fk_compliance_facility_compliance_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);

-- ========= compliance --> workforce (20 constraint(s)) =========
-- Requires: compliance schema, workforce schema
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`broadcast_license` ADD CONSTRAINT `fk_compliance_broadcast_license_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`license_renewal` ADD CONSTRAINT `fk_compliance_license_renewal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`public_inspection_file` ADD CONSTRAINT `fk_compliance_public_inspection_file_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`content_rating` ADD CONSTRAINT `fk_compliance_content_rating_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`coppa_declaration` ADD CONSTRAINT `fk_compliance_coppa_declaration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`compliance_consent_record` ADD CONSTRAINT `fk_compliance_compliance_consent_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`closed_caption_record` ADD CONSTRAINT `fk_compliance_closed_caption_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`accessibility_obligation` ADD CONSTRAINT `fk_compliance_accessibility_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`eas_log` ADD CONSTRAINT `fk_compliance_eas_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`political_ad_record` ADD CONSTRAINT `fk_compliance_political_ad_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`sox_control` ADD CONSTRAINT `fk_compliance_sox_control_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`ad_standards_clearance` ADD CONSTRAINT `fk_compliance_ad_standards_clearance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`technical_standard_cert` ADD CONSTRAINT `fk_compliance_technical_standard_cert_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`calendar` ADD CONSTRAINT `fk_compliance_calendar_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= content --> billing (4 constraint(s)) =========
-- Requires: content schema, billing schema
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ADD CONSTRAINT `fk_content_package_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`billing_line` ADD CONSTRAINT `fk_content_billing_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= content --> compliance (7 constraint(s)) =========
-- Requires: content schema, compliance schema
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_coppa_declaration_id` FOREIGN KEY (`coppa_declaration_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`coppa_declaration`(`coppa_declaration_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`compliance_finding` ADD CONSTRAINT `fk_content_compliance_finding_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`compliance_finding` ADD CONSTRAINT `fk_content_compliance_finding_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`compliance_finding` ADD CONSTRAINT `fk_content_compliance_finding_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= content --> distribution (11 constraint(s)) =========
-- Requires: content schema, distribution schema
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ADD CONSTRAINT `fk_content_version_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ADD CONSTRAINT `fk_content_version_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`ingest_event` ADD CONSTRAINT `fk_content_ingest_event_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ADD CONSTRAINT `fk_content_package_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`distribution_partner`(`distribution_partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ADD CONSTRAINT `fk_content_package_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);

-- ========= content --> finance (6 constraint(s)) =========
-- Requires: content schema, finance schema
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ADD CONSTRAINT `fk_content_season_production_budget_id` FOREIGN KEY (`production_budget_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`production_budget`(`production_budget_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_production_budget_id` FOREIGN KEY (`production_budget_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`production_budget`(`production_budget_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ADD CONSTRAINT `fk_content_package_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);

-- ========= content --> mediaasset (8 constraint(s)) =========
-- Requires: content schema, mediaasset schema
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ADD CONSTRAINT `fk_content_season_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ADD CONSTRAINT `fk_content_version_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`ingest_event` ADD CONSTRAINT `fk_content_ingest_event_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_asset_usage` ADD CONSTRAINT `fk_content_title_asset_usage_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= content --> partner (7 constraint(s)) =========
-- Requires: content schema, partner schema
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`ingest_event` ADD CONSTRAINT `fk_content_ingest_event_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`compliance_finding` ADD CONSTRAINT `fk_content_compliance_finding_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`distribution_package` ADD CONSTRAINT `fk_content_distribution_package_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);

-- ========= content --> rights (20 constraint(s)) =========
-- Requires: content schema, rights schema
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ADD CONSTRAINT `fk_content_title_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ADD CONSTRAINT `fk_content_title_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`holder`(`holder_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ADD CONSTRAINT `fk_content_title_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ADD CONSTRAINT `fk_content_series_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ADD CONSTRAINT `fk_content_series_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`holder`(`holder_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ADD CONSTRAINT `fk_content_season_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ADD CONSTRAINT `fk_content_version_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ADD CONSTRAINT `fk_content_version_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_clearance` ADD CONSTRAINT `fk_content_content_clearance_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_clearance` ADD CONSTRAINT `fk_content_content_clearance_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_clearance` ADD CONSTRAINT `fk_content_content_clearance_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ADD CONSTRAINT `fk_content_package_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`compliance_finding` ADD CONSTRAINT `fk_content_compliance_finding_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`compliance_finding` ADD CONSTRAINT `fk_content_compliance_finding_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_rights_grant` ADD CONSTRAINT `fk_content_title_rights_grant_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);

-- ========= content --> sales (7 constraint(s)) =========
-- Requires: content schema, sales schema
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ADD CONSTRAINT `fk_content_title_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ADD CONSTRAINT `fk_content_title_sales_proposal_id` FOREIGN KEY (`sales_proposal_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_proposal`(`sales_proposal_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ADD CONSTRAINT `fk_content_series_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ADD CONSTRAINT `fk_content_package_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre_buy_agreement` ADD CONSTRAINT `fk_content_genre_buy_agreement_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`advertiser`(`advertiser_id`);

-- ========= content --> talent (7 constraint(s)) =========
-- Requires: content schema, talent schema
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`contract`(`contract_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_role_id` FOREIGN KEY (`role_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`role`(`role_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`series_talent_credit` ADD CONSTRAINT `fk_content_series_talent_credit_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`contract`(`contract_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`series_talent_credit` ADD CONSTRAINT `fk_content_series_talent_credit_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`credit` ADD CONSTRAINT `fk_content_credit_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= content --> technology (13 constraint(s)) =========
-- Requires: content schema, technology schema
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ADD CONSTRAINT `fk_content_series_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ADD CONSTRAINT `fk_content_season_studio_facility_id` FOREIGN KEY (`studio_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`studio_facility`(`studio_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_studio_facility_id` FOREIGN KEY (`studio_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`studio_facility`(`studio_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ADD CONSTRAINT `fk_content_version_encoder_config_id` FOREIGN KEY (`encoder_config_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`encoder_config`(`encoder_config_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_encoder_config_id` FOREIGN KEY (`encoder_config_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`encoder_config`(`encoder_config_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_satellite_transponder_id` FOREIGN KEY (`satellite_transponder_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`satellite_transponder`(`satellite_transponder_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`lifecycle_event` ADD CONSTRAINT `fk_content_lifecycle_event_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_encoder_config_id` FOREIGN KEY (`encoder_config_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`encoder_config`(`encoder_config_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`ingest_event` ADD CONSTRAINT `fk_content_ingest_event_encoder_config_id` FOREIGN KEY (`encoder_config_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`encoder_config`(`encoder_config_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`ingest_event` ADD CONSTRAINT `fk_content_ingest_event_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`compliance_finding` ADD CONSTRAINT `fk_content_compliance_finding_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`compliance_finding` ADD CONSTRAINT `fk_content_compliance_finding_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`episode_transmission` ADD CONSTRAINT `fk_content_episode_transmission_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`transmission_equipment`(`transmission_equipment_id`);

-- ========= content --> workforce (13 constraint(s)) =========
-- Requires: content schema, workforce schema
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`lifecycle_event` ADD CONSTRAINT `fk_content_lifecycle_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_clearance` ADD CONSTRAINT `fk_content_content_clearance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ADD CONSTRAINT `fk_content_tag_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ADD CONSTRAINT `fk_content_tag_tag_reviewed_by_user_employee_id` FOREIGN KEY (`tag_reviewed_by_user_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`ingest_event` ADD CONSTRAINT `fk_content_ingest_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ADD CONSTRAINT `fk_content_package_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`compliance_finding` ADD CONSTRAINT `fk_content_compliance_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre_buy_agreement` ADD CONSTRAINT `fk_content_genre_buy_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`series_crew_assignment` ADD CONSTRAINT `fk_content_series_crew_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= distribution --> audience (17 constraint(s)) =========
-- Requires: distribution schema, audience schema
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`qos_event` ADD CONSTRAINT `fk_distribution_qos_event_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`qos_event` ADD CONSTRAINT `fk_distribution_qos_event_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`sla_performance` ADD CONSTRAINT `fk_distribution_sla_performance_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`personalization_engine` ADD CONSTRAINT `fk_distribution_personalization_engine_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`personalization_engine` ADD CONSTRAINT `fk_distribution_personalization_engine_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_session` ADD CONSTRAINT `fk_distribution_dai_session_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_session` ADD CONSTRAINT `fk_distribution_dai_session_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`subscriber_count_report` ADD CONSTRAINT `fk_distribution_subscriber_count_report_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`channel_lineup` ADD CONSTRAINT `fk_distribution_channel_lineup_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);

-- ========= distribution --> billing (7 constraint(s)) =========
-- Requires: distribution schema, billing schema
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`sla_performance` ADD CONSTRAINT `fk_distribution_sla_performance_credit_memo_id` FOREIGN KEY (`credit_memo_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`credit_memo`(`credit_memo_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= distribution --> compliance (30 constraint(s)) =========
-- Requires: distribution schema, compliance schema
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`app_version` ADD CONSTRAINT `fk_distribution_app_version_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_technical_standard_cert_id` FOREIGN KEY (`technical_standard_cert_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`technical_standard_cert`(`technical_standard_cert_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ADD CONSTRAINT `fk_distribution_abr_profile_technical_standard_cert_id` FOREIGN KEY (`technical_standard_cert_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`technical_standard_cert`(`technical_standard_cert_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_closed_caption_record_id` FOREIGN KEY (`closed_caption_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`closed_caption_record`(`closed_caption_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_compliance_consent_record_id` FOREIGN KEY (`compliance_consent_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`compliance_consent_record`(`compliance_consent_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`qos_event` ADD CONSTRAINT `fk_distribution_qos_event_closed_caption_record_id` FOREIGN KEY (`closed_caption_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`closed_caption_record`(`closed_caption_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`api_endpoint` ADD CONSTRAINT `fk_distribution_api_endpoint_compliance_consent_record_id` FOREIGN KEY (`compliance_consent_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`compliance_consent_record`(`compliance_consent_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`personalization_engine` ADD CONSTRAINT `fk_distribution_personalization_engine_compliance_consent_record_id` FOREIGN KEY (`compliance_consent_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`compliance_consent_record`(`compliance_consent_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`drm_policy` ADD CONSTRAINT `fk_distribution_drm_policy_technical_standard_cert_id` FOREIGN KEY (`technical_standard_cert_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`technical_standard_cert`(`technical_standard_cert_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ADD CONSTRAINT `fk_distribution_signal_route_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_coppa_declaration_id` FOREIGN KEY (`coppa_declaration_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`coppa_declaration`(`coppa_declaration_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_eas_log_id` FOREIGN KEY (`eas_log_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`eas_log`(`eas_log_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`sla_breach` ADD CONSTRAINT `fk_distribution_sla_breach_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_session` ADD CONSTRAINT `fk_distribution_dai_session_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_session` ADD CONSTRAINT `fk_distribution_dai_session_political_ad_record_id` FOREIGN KEY (`political_ad_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`political_ad_record`(`political_ad_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`retransmission_consent` ADD CONSTRAINT `fk_distribution_retransmission_consent_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`channel_compliance` ADD CONSTRAINT `fk_distribution_channel_compliance_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= distribution --> content (2 constraint(s)) =========
-- Requires: distribution schema, content schema
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`qos_event` ADD CONSTRAINT `fk_distribution_qos_event_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);

-- ========= distribution --> finance (13 constraint(s)) =========
-- Requires: distribution schema, finance schema
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_carriage_fee_invoice` ADD CONSTRAINT `fk_distribution_distribution_carriage_fee_invoice_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_carriage_fee_invoice` ADD CONSTRAINT `fk_distribution_distribution_carriage_fee_invoice_revenue_recognition_event_id` FOREIGN KEY (`revenue_recognition_event_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`sla_breach` ADD CONSTRAINT `fk_distribution_sla_breach_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_session` ADD CONSTRAINT `fk_distribution_dai_session_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`deal` ADD CONSTRAINT `fk_distribution_deal_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= distribution --> mediaasset (8 constraint(s)) =========
-- Requires: distribution schema, mediaasset schema
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ADD CONSTRAINT `fk_distribution_abr_profile_format_specification_id` FOREIGN KEY (`format_specification_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`format_specification`(`format_specification_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_session` ADD CONSTRAINT `fk_distribution_dai_session_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playout` ADD CONSTRAINT `fk_distribution_playout_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= distribution --> partner (3 constraint(s)) =========
-- Requires: distribution schema, partner schema
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`retransmission_consent` ADD CONSTRAINT `fk_distribution_retransmission_consent_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`platform_distribution_agreement` ADD CONSTRAINT `fk_distribution_platform_distribution_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`endpoint_allocation` ADD CONSTRAINT `fk_distribution_endpoint_allocation_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);

-- ========= distribution --> rights (12 constraint(s)) =========
-- Requires: distribution schema, rights schema
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_territory`(`rights_territory_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_session` ADD CONSTRAINT `fk_distribution_dai_session_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`retransmission_consent` ADD CONSTRAINT `fk_distribution_retransmission_consent_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`deal` ADD CONSTRAINT `fk_distribution_deal_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_rights_availability_window_id` FOREIGN KEY (`rights_availability_window_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_availability_window`(`rights_availability_window_id`);

-- ========= distribution --> sales (12 constraint(s)) =========
-- Requires: distribution schema, sales schema
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_sales_territory_id` FOREIGN KEY (`sales_territory_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_territory`(`sales_territory_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_carriage_fee_invoice` ADD CONSTRAINT `fk_distribution_distribution_carriage_fee_invoice_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_session` ADD CONSTRAINT `fk_distribution_dai_session_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_session` ADD CONSTRAINT `fk_distribution_dai_session_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`retransmission_consent` ADD CONSTRAINT `fk_distribution_retransmission_consent_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`deal` ADD CONSTRAINT `fk_distribution_deal_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);

-- ========= distribution --> scheduling (8 constraint(s)) =========
-- Requires: distribution schema, scheduling schema
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`cdn_configuration` ADD CONSTRAINT `fk_distribution_cdn_configuration_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ADD CONSTRAINT `fk_distribution_signal_route_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_session` ADD CONSTRAINT `fk_distribution_dai_session_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`subscriber_count_report` ADD CONSTRAINT `fk_distribution_subscriber_count_report_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`channel_lineup` ADD CONSTRAINT `fk_distribution_channel_lineup_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playout_feed` ADD CONSTRAINT `fk_distribution_playout_feed_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);

-- ========= distribution --> subscriber (2 constraint(s)) =========
-- Requires: distribution schema, subscriber schema
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_session` ADD CONSTRAINT `fk_distribution_dai_session_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);

-- ========= distribution --> talent (5 constraint(s)) =========
-- Requires: distribution schema, talent schema
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`qos_event` ADD CONSTRAINT `fk_distribution_qos_event_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`contract`(`contract_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_session` ADD CONSTRAINT `fk_distribution_dai_session_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`contract`(`contract_id`);

-- ========= distribution --> technology (42 constraint(s)) =========
-- Requires: distribution schema, technology schema
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_tech_project_id` FOREIGN KEY (`tech_project_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`tech_project`(`tech_project_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ADD CONSTRAINT `fk_distribution_device_type_broadcast_standard_id` FOREIGN KEY (`broadcast_standard_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_standard`(`broadcast_standard_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`device_type` ADD CONSTRAINT `fk_distribution_device_type_maintenance_work_order_id` FOREIGN KEY (`maintenance_work_order_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`maintenance_work_order`(`maintenance_work_order_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_encoder_config_id` FOREIGN KEY (`encoder_config_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`encoder_config`(`encoder_config_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_maintenance_work_order_id` FOREIGN KEY (`maintenance_work_order_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`maintenance_work_order`(`maintenance_work_order_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_network_circuit_id` FOREIGN KEY (`network_circuit_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`network_circuit`(`network_circuit_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_noc_monitor_id` FOREIGN KEY (`noc_monitor_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`noc_monitor`(`noc_monitor_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_outage_record_id` FOREIGN KEY (`outage_record_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`outage_record`(`outage_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_software_license_id` FOREIGN KEY (`software_license_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`software_license`(`software_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_tech_project_id` FOREIGN KEY (`tech_project_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`tech_project`(`tech_project_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_tech_sla_id` FOREIGN KEY (`tech_sla_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`tech_sla`(`tech_sla_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ADD CONSTRAINT `fk_distribution_abr_profile_broadcast_standard_id` FOREIGN KEY (`broadcast_standard_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_standard`(`broadcast_standard_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`abr_profile` ADD CONSTRAINT `fk_distribution_abr_profile_encoder_config_id` FOREIGN KEY (`encoder_config_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`encoder_config`(`encoder_config_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_tech_incident_id` FOREIGN KEY (`tech_incident_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`tech_incident`(`tech_incident_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`qos_event` ADD CONSTRAINT `fk_distribution_qos_event_noc_alert_id` FOREIGN KEY (`noc_alert_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`noc_alert`(`noc_alert_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`qos_event` ADD CONSTRAINT `fk_distribution_qos_event_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`sla_performance` ADD CONSTRAINT `fk_distribution_sla_performance_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`sla_performance` ADD CONSTRAINT `fk_distribution_sla_performance_tech_incident_id` FOREIGN KEY (`tech_incident_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`tech_incident`(`tech_incident_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`api_endpoint` ADD CONSTRAINT `fk_distribution_api_endpoint_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`api_endpoint` ADD CONSTRAINT `fk_distribution_api_endpoint_noc_monitor_id` FOREIGN KEY (`noc_monitor_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`noc_monitor`(`noc_monitor_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`api_endpoint` ADD CONSTRAINT `fk_distribution_api_endpoint_tech_project_id` FOREIGN KEY (`tech_project_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`tech_project`(`tech_project_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`api_endpoint` ADD CONSTRAINT `fk_distribution_api_endpoint_tech_sla_id` FOREIGN KEY (`tech_sla_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`tech_sla`(`tech_sla_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`personalization_engine` ADD CONSTRAINT `fk_distribution_personalization_engine_software_license_id` FOREIGN KEY (`software_license_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`software_license`(`software_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`personalization_engine` ADD CONSTRAINT `fk_distribution_personalization_engine_tech_project_id` FOREIGN KEY (`tech_project_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`tech_project`(`tech_project_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_network_circuit_id` FOREIGN KEY (`network_circuit_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`network_circuit`(`network_circuit_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_network_circuit_id` FOREIGN KEY (`network_circuit_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`network_circuit`(`network_circuit_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_encoder_config_id` FOREIGN KEY (`encoder_config_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`encoder_config`(`encoder_config_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_outage_record_id` FOREIGN KEY (`outage_record_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`outage_record`(`outage_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ADD CONSTRAINT `fk_distribution_signal_route_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ADD CONSTRAINT `fk_distribution_signal_route_network_circuit_id` FOREIGN KEY (`network_circuit_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`network_circuit`(`network_circuit_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ADD CONSTRAINT `fk_distribution_signal_route_satellite_transponder_id` FOREIGN KEY (`satellite_transponder_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`satellite_transponder`(`satellite_transponder_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_event` ADD CONSTRAINT `fk_distribution_delivery_event_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`sla_breach` ADD CONSTRAINT `fk_distribution_sla_breach_noc_alert_id` FOREIGN KEY (`noc_alert_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`noc_alert`(`noc_alert_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playout_feed` ADD CONSTRAINT `fk_distribution_playout_feed_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playout_feed` ADD CONSTRAINT `fk_distribution_playout_feed_encoder_config_id` FOREIGN KEY (`encoder_config_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`encoder_config`(`encoder_config_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playout_feed` ADD CONSTRAINT `fk_distribution_playout_feed_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`transmission_equipment`(`transmission_equipment_id`);

-- ========= distribution --> workforce (17 constraint(s)) =========
-- Requires: distribution schema, workforce schema
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`api_endpoint` ADD CONSTRAINT `fk_distribution_api_endpoint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`personalization_engine` ADD CONSTRAINT `fk_distribution_personalization_engine_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`dai_configuration` ADD CONSTRAINT `fk_distribution_dai_configuration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`feature_flag` ADD CONSTRAINT `fk_distribution_feature_flag_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`distribution_partner` ADD CONSTRAINT `fk_distribution_distribution_partner_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`delivery_sla` ADD CONSTRAINT `fk_distribution_delivery_sla_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`signal_route` ADD CONSTRAINT `fk_distribution_signal_route_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`sla_breach` ADD CONSTRAINT `fk_distribution_sla_breach_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`retransmission_consent` ADD CONSTRAINT `fk_distribution_retransmission_consent_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`subscriber_count_report` ADD CONSTRAINT `fk_distribution_subscriber_count_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`playout_feed` ADD CONSTRAINT `fk_distribution_playout_feed_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`deal` ADD CONSTRAINT `fk_distribution_deal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`distribution`.`content_delivery_order` ADD CONSTRAINT `fk_distribution_content_delivery_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= finance --> billing (2 constraint(s)) =========
-- Requires: finance schema, billing schema
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= finance --> compliance (15 constraint(s)) =========
-- Requires: finance schema, compliance schema
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_coppa_declaration_id` FOREIGN KEY (`coppa_declaration_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`coppa_declaration`(`coppa_declaration_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_political_ad_record_id` FOREIGN KEY (`political_ad_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`political_ad_record`(`political_ad_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`capex_project` ADD CONSTRAINT `fk_finance_capex_project_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`ebitda_snapshot` ADD CONSTRAINT `fk_finance_ebitda_snapshot_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`financial_reconciliation` ADD CONSTRAINT `fk_finance_financial_reconciliation_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`obligation_gl_mapping` ADD CONSTRAINT `fk_finance_obligation_gl_mapping_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center_obligation_allocation` ADD CONSTRAINT `fk_finance_cost_center_obligation_allocation_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= finance --> content (1 constraint(s)) =========
-- Requires: finance schema, content schema
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);

-- ========= finance --> partner (4 constraint(s)) =========
-- Requires: finance schema, partner schema
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_performance_obligation_id` FOREIGN KEY (`performance_obligation_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`performance_obligation`(`performance_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`source_document` ADD CONSTRAINT `fk_finance_source_document_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`vendor`(`vendor_id`);

-- ========= finance --> production (3 constraint(s)) =========
-- Requires: finance schema, production schema
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ADD CONSTRAINT `fk_finance_production_budget_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`budget_version` ADD CONSTRAINT `fk_finance_budget_version_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `media_broadcasting_ecm`.`production`.`budget`(`budget_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`budget_version` ADD CONSTRAINT `fk_finance_budget_version_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);

-- ========= finance --> rights (1 constraint(s)) =========
-- Requires: finance schema, rights schema
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ADD CONSTRAINT `fk_finance_production_budget_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);

-- ========= finance --> sales (2 constraint(s)) =========
-- Requires: finance schema, sales schema
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_ad_sales_order_id` FOREIGN KEY (`ad_sales_order_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_sales_order`(`ad_sales_order_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`source_document` ADD CONSTRAINT `fk_finance_source_document_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_account`(`sales_account_id`);

-- ========= finance --> subscriber (3 constraint(s)) =========
-- Requires: finance schema, subscriber schema
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);

-- ========= finance --> talent (1 constraint(s)) =========
-- Requires: finance schema, talent schema
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`contract`(`contract_id`);

-- ========= finance --> technology (15 constraint(s)) =========
-- Requires: finance schema, technology schema
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_maintenance_work_order_id` FOREIGN KEY (`maintenance_work_order_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`maintenance_work_order`(`maintenance_work_order_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ADD CONSTRAINT `fk_finance_production_budget_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`production_budget` ADD CONSTRAINT `fk_finance_production_budget_studio_facility_id` FOREIGN KEY (`studio_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`studio_facility`(`studio_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_equipment_procurement_id` FOREIGN KEY (`equipment_procurement_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`equipment_procurement`(`equipment_procurement_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_studio_facility_id` FOREIGN KEY (`studio_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`studio_facility`(`studio_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`capex_project` ADD CONSTRAINT `fk_finance_capex_project_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`financial_reconciliation` ADD CONSTRAINT `fk_finance_financial_reconciliation_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`facility_legal_assignment` ADD CONSTRAINT `fk_finance_facility_legal_assignment_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`facility_cost_allocation` ADD CONSTRAINT `fk_finance_facility_cost_allocation_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);

-- ========= finance --> workforce (19 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `media_broadcasting_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_primary_journal_employee_id` FOREIGN KEY (`primary_journal_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`budget_version` ADD CONSTRAINT `fk_finance_budget_version_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`budget_version` ADD CONSTRAINT `fk_finance_budget_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`revenue_recognition_event` ADD CONSTRAINT `fk_finance_revenue_recognition_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`financial_reconciliation` ADD CONSTRAINT `fk_finance_financial_reconciliation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`financial_reconciliation` ADD CONSTRAINT `fk_finance_financial_reconciliation_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`project_assignment` ADD CONSTRAINT `fk_finance_project_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`project_assignment` ADD CONSTRAINT `fk_finance_project_assignment_project_manager_employee_id` FOREIGN KEY (`project_manager_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center_obligation_allocation` ADD CONSTRAINT `fk_finance_cost_center_obligation_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center_authorization` ADD CONSTRAINT `fk_finance_cost_center_authorization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center_authorization` ADD CONSTRAINT `fk_finance_cost_center_authorization_granted_by_employee_id` FOREIGN KEY (`granted_by_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`cost_center_authorization` ADD CONSTRAINT `fk_finance_cost_center_authorization_revoked_by_employee_id` FOREIGN KEY (`revoked_by_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`facility_cost_allocation` ADD CONSTRAINT `fk_finance_facility_cost_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`recurring_entry_template` ADD CONSTRAINT `fk_finance_recurring_entry_template_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`recurring_entry_template` ADD CONSTRAINT `fk_finance_recurring_entry_template_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`recurring_entry_template` ADD CONSTRAINT `fk_finance_recurring_entry_template_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`finance`.`recurring_entry_template` ADD CONSTRAINT `fk_finance_recurring_entry_template_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= mediaasset --> finance (10 constraint(s)) =========
-- Requires: mediaasset schema, finance schema
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ADD CONSTRAINT `fk_mediaasset_media_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ADD CONSTRAINT `fk_mediaasset_media_asset_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ADD CONSTRAINT `fk_mediaasset_ingest_job_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ADD CONSTRAINT `fk_mediaasset_transcode_job_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ADD CONSTRAINT `fk_mediaasset_qc_inspection_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_lifecycle_event` ADD CONSTRAINT `fk_mediaasset_asset_lifecycle_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ADD CONSTRAINT `fk_mediaasset_asset_collection_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ADD CONSTRAINT `fk_mediaasset_asset_collection_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ADD CONSTRAINT `fk_mediaasset_archive_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_migration` ADD CONSTRAINT `fk_mediaasset_format_migration_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= mediaasset --> partner (6 constraint(s)) =========
-- Requires: mediaasset schema, partner schema
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ADD CONSTRAINT `fk_mediaasset_asset_version_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ADD CONSTRAINT `fk_mediaasset_ingest_job_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ADD CONSTRAINT `fk_mediaasset_archive_record_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_access_request` ADD CONSTRAINT `fk_mediaasset_asset_access_request_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_rights_grant` ADD CONSTRAINT `fk_mediaasset_asset_rights_grant_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`deal_asset_license` ADD CONSTRAINT `fk_mediaasset_deal_asset_license_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`acquisition_deal`(`acquisition_deal_id`);

-- ========= mediaasset --> sales (1 constraint(s)) =========
-- Requires: mediaasset schema, sales schema
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`syndication_inventory` ADD CONSTRAINT `fk_mediaasset_syndication_inventory_sales_syndication_deal_id` FOREIGN KEY (`sales_syndication_deal_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_syndication_deal`(`sales_syndication_deal_id`);

-- ========= mediaasset --> talent (1 constraint(s)) =========
-- Requires: mediaasset schema, talent schema
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`legal_hold` ADD CONSTRAINT `fk_mediaasset_legal_hold_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= mediaasset --> technology (4 constraint(s)) =========
-- Requires: mediaasset schema, technology schema
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ADD CONSTRAINT `fk_mediaasset_ingest_job_tech_change_request_id` FOREIGN KEY (`tech_change_request_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`tech_change_request`(`tech_change_request_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ADD CONSTRAINT `fk_mediaasset_transcode_job_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ADD CONSTRAINT `fk_mediaasset_asset_storage_assignment_maintenance_work_order_id` FOREIGN KEY (`maintenance_work_order_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`maintenance_work_order`(`maintenance_work_order_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_lifecycle_event` ADD CONSTRAINT `fk_mediaasset_asset_lifecycle_event_tech_change_request_id` FOREIGN KEY (`tech_change_request_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`tech_change_request`(`tech_change_request_id`);

-- ========= mediaasset --> workforce (10 constraint(s)) =========
-- Requires: mediaasset schema, workforce schema
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ADD CONSTRAINT `fk_mediaasset_ingest_job_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ADD CONSTRAINT `fk_mediaasset_transcode_job_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ADD CONSTRAINT `fk_mediaasset_qc_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ADD CONSTRAINT `fk_mediaasset_asset_storage_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ADD CONSTRAINT `fk_mediaasset_archive_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_migration` ADD CONSTRAINT `fk_mediaasset_format_migration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_access_request` ADD CONSTRAINT `fk_mediaasset_asset_access_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_access_request` ADD CONSTRAINT `fk_mediaasset_asset_access_request_primary_asset_employee_id` FOREIGN KEY (`primary_asset_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_rights_grant` ADD CONSTRAINT `fk_mediaasset_asset_rights_grant_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_legal_hold` ADD CONSTRAINT `fk_mediaasset_asset_legal_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= partner --> audience (10 constraint(s)) =========
-- Requires: partner schema, audience schema
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ADD CONSTRAINT `fk_partner_distribution_agreement_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ADD CONSTRAINT `fk_partner_affiliate_agreement_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`deal_negotiation` ADD CONSTRAINT `fk_partner_deal_negotiation_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`deal_negotiation` ADD CONSTRAINT `fk_partner_deal_negotiation_sweeps_period_id` FOREIGN KEY (`sweeps_period_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`sweeps_period`(`sweeps_period_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ADD CONSTRAINT `fk_partner_carriage_fee_schedule_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`performance_obligation` ADD CONSTRAINT `fk_partner_performance_obligation_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`performance_obligation` ADD CONSTRAINT `fk_partner_performance_obligation_sweeps_period_id` FOREIGN KEY (`sweeps_period_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`sweeps_period`(`sweeps_period_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ADD CONSTRAINT `fk_partner_partner_content_window_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);

-- ========= partner --> billing (3 constraint(s)) =========
-- Requires: partner schema, billing schema
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ADD CONSTRAINT `fk_partner_minimum_guarantee_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ADD CONSTRAINT `fk_partner_payment_term_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_audit_event` ADD CONSTRAINT `fk_partner_partner_audit_event_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= partner --> compliance (25 constraint(s)) =========
-- Requires: partner schema, compliance schema
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_contact` ADD CONSTRAINT `fk_partner_partner_contact_compliance_consent_record_id` FOREIGN KEY (`compliance_consent_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`compliance_consent_record`(`compliance_consent_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_coppa_declaration_id` FOREIGN KEY (`coppa_declaration_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`coppa_declaration`(`coppa_declaration_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ADD CONSTRAINT `fk_partner_acquisition_deal_line_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ADD CONSTRAINT `fk_partner_distribution_agreement_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_coppa_declaration_id` FOREIGN KEY (`coppa_declaration_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`coppa_declaration`(`coppa_declaration_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_coppa_declaration_id` FOREIGN KEY (`coppa_declaration_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`coppa_declaration`(`coppa_declaration_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ADD CONSTRAINT `fk_partner_affiliate_agreement_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`deal_negotiation` ADD CONSTRAINT `fk_partner_deal_negotiation_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_closed_caption_record_id` FOREIGN KEY (`closed_caption_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`closed_caption_record`(`closed_caption_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ADD CONSTRAINT `fk_partner_carriage_fee_schedule_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`performance_obligation` ADD CONSTRAINT `fk_partner_performance_obligation_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_audit_event` ADD CONSTRAINT `fk_partner_partner_audit_event_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ADD CONSTRAINT `fk_partner_partner_content_window_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_deal_approval` ADD CONSTRAINT `fk_partner_partner_deal_approval_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_deal_approval` ADD CONSTRAINT `fk_partner_partner_deal_approval_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`license_ownership` ADD CONSTRAINT `fk_partner_license_ownership_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`deal_compliance_obligation` ADD CONSTRAINT `fk_partner_deal_compliance_obligation_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= partner --> content (12 constraint(s)) =========
-- Requires: partner schema, content schema
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ADD CONSTRAINT `fk_partner_acquisition_deal_line_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`deal_negotiation` ADD CONSTRAINT `fk_partner_deal_negotiation_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `media_broadcasting_ecm`.`content`.`genre`(`genre_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_version_id` FOREIGN KEY (`version_id`) REFERENCES `media_broadcasting_ecm`.`content`.`version`(`version_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ADD CONSTRAINT `fk_partner_carriage_fee_schedule_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `media_broadcasting_ecm`.`content`.`genre`(`genre_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_audit_event` ADD CONSTRAINT `fk_partner_partner_audit_event_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ADD CONSTRAINT `fk_partner_partner_content_window_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ADD CONSTRAINT `fk_partner_partner_content_window_version_id` FOREIGN KEY (`version_id`) REFERENCES `media_broadcasting_ecm`.`content`.`version`(`version_id`);

-- ========= partner --> distribution (1 constraint(s)) =========
-- Requires: partner schema, distribution schema
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ADD CONSTRAINT `fk_partner_carriage_fee_schedule_carriage_agreement_id` FOREIGN KEY (`carriage_agreement_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`carriage_agreement`(`carriage_agreement_id`);

-- ========= partner --> finance (18 constraint(s)) =========
-- Requires: partner schema, finance schema
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ADD CONSTRAINT `fk_partner_partner_partner_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ADD CONSTRAINT `fk_partner_distribution_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ADD CONSTRAINT `fk_partner_affiliate_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`deal_negotiation` ADD CONSTRAINT `fk_partner_deal_negotiation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`deal_negotiation` ADD CONSTRAINT `fk_partner_deal_negotiation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ADD CONSTRAINT `fk_partner_carriage_fee_schedule_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ADD CONSTRAINT `fk_partner_minimum_guarantee_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ADD CONSTRAINT `fk_partner_minimum_guarantee_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ADD CONSTRAINT `fk_partner_payment_term_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_deal_approval` ADD CONSTRAINT `fk_partner_partner_deal_approval_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_deal_approval` ADD CONSTRAINT `fk_partner_partner_deal_approval_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_agreement` ADD CONSTRAINT `fk_partner_partner_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= partner --> mediaasset (8 constraint(s)) =========
-- Requires: partner schema, mediaasset schema
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ADD CONSTRAINT `fk_partner_acquisition_deal_line_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`performance_obligation` ADD CONSTRAINT `fk_partner_performance_obligation_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ADD CONSTRAINT `fk_partner_minimum_guarantee_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ADD CONSTRAINT `fk_partner_partner_content_window_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= partner --> production (2 constraint(s)) =========
-- Requires: partner schema, production schema
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`deal_negotiation` ADD CONSTRAINT `fk_partner_deal_negotiation_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);

-- ========= partner --> rights (2 constraint(s)) =========
-- Requires: partner schema, rights schema
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);

-- ========= partner --> sales (3 constraint(s)) =========
-- Requires: partner schema, sales schema
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`deal_negotiation` ADD CONSTRAINT `fk_partner_deal_negotiation_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);

-- ========= partner --> scheduling (9 constraint(s)) =========
-- Requires: partner schema, scheduling schema
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ADD CONSTRAINT `fk_partner_distribution_agreement_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ADD CONSTRAINT `fk_partner_affiliate_agreement_affiliate_station_channel_id` FOREIGN KEY (`affiliate_station_channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ADD CONSTRAINT `fk_partner_affiliate_agreement_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ADD CONSTRAINT `fk_partner_affiliate_agreement_network_channel_id` FOREIGN KEY (`network_channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ADD CONSTRAINT `fk_partner_carriage_fee_schedule_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_scheduling_availability_window_id` FOREIGN KEY (`scheduling_availability_window_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`scheduling_availability_window`(`scheduling_availability_window_id`);

-- ========= partner --> talent (6 constraint(s)) =========
-- Requires: partner schema, talent schema
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_contact` ADD CONSTRAINT `fk_partner_partner_contact_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ADD CONSTRAINT `fk_partner_acquisition_deal_line_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`contract`(`contract_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_schedule` ADD CONSTRAINT `fk_partner_payment_schedule_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`contract`(`contract_id`);

-- ========= partner --> workforce (19 constraint(s)) =========
-- Requires: partner schema, workforce schema
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_contact` ADD CONSTRAINT `fk_partner_partner_contact_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`deal_negotiation` ADD CONSTRAINT `fk_partner_deal_negotiation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`deal_negotiation` ADD CONSTRAINT `fk_partner_deal_negotiation_tertiary_deal_legal_reviewer_employee_id` FOREIGN KEY (`tertiary_deal_legal_reviewer_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`deal_amendment` ADD CONSTRAINT `fk_partner_deal_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`performance_obligation` ADD CONSTRAINT `fk_partner_performance_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ADD CONSTRAINT `fk_partner_payment_term_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_audit_event` ADD CONSTRAINT `fk_partner_partner_audit_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ADD CONSTRAINT `fk_partner_partner_content_window_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`renewal` ADD CONSTRAINT `fk_partner_renewal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`renewal` ADD CONSTRAINT `fk_partner_renewal_renewal_executive_approver_employee_id` FOREIGN KEY (`renewal_executive_approver_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`renewal` ADD CONSTRAINT `fk_partner_renewal_renewal_finance_approver_employee_id` FOREIGN KEY (`renewal_finance_approver_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`renewal` ADD CONSTRAINT `fk_partner_renewal_renewal_legal_reviewer_employee_id` FOREIGN KEY (`renewal_legal_reviewer_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_deal_approval` ADD CONSTRAINT `fk_partner_partner_deal_approval_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= production --> billing (1 constraint(s)) =========
-- Requires: production schema, billing schema
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ADD CONSTRAINT `fk_production_project_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`billing_account`(`billing_account_id`);

-- ========= production --> compliance (17 constraint(s)) =========
-- Requires: production schema, compliance schema
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ADD CONSTRAINT `fk_production_project_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ADD CONSTRAINT `fk_production_project_coppa_declaration_id` FOREIGN KEY (`coppa_declaration_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`coppa_declaration`(`coppa_declaration_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ADD CONSTRAINT `fk_production_project_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_coppa_declaration_id` FOREIGN KEY (`coppa_declaration_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`coppa_declaration`(`coppa_declaration_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_closed_caption_record_id` FOREIGN KEY (`closed_caption_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`closed_caption_record`(`closed_caption_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_closed_caption_record_id` FOREIGN KEY (`closed_caption_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`closed_caption_record`(`closed_caption_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`insurance_policy` ADD CONSTRAINT `fk_production_insurance_policy_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_clearance` ADD CONSTRAINT `fk_production_production_clearance_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_clearance` ADD CONSTRAINT `fk_production_production_clearance_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`rating_submission` ADD CONSTRAINT `fk_production_rating_submission_compliance_content_rating_id` FOREIGN KEY (`compliance_content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`rating_submission` ADD CONSTRAINT `fk_production_rating_submission_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`incident`(`incident_id`);

-- ========= production --> content (18 constraint(s)) =========
-- Requires: production schema, content schema
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ADD CONSTRAINT `fk_production_project_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ADD CONSTRAINT `fk_production_project_project_title_id` FOREIGN KEY (`project_title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `media_broadcasting_ecm`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ADD CONSTRAINT `fk_production_facility_booking_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `media_broadcasting_ecm`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_season_id` FOREIGN KEY (`season_id`) REFERENCES `media_broadcasting_ecm`.`content`.`season`(`season_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ADD CONSTRAINT `fk_production_script_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `media_broadcasting_ecm`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_version_id` FOREIGN KEY (`version_id`) REFERENCES `media_broadcasting_ecm`.`content`.`version`(`version_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`vfx_shot` ADD CONSTRAINT `fk_production_vfx_shot_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_version_id` FOREIGN KEY (`version_id`) REFERENCES `media_broadcasting_ecm`.`content`.`version`(`version_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`ingest_record` ADD CONSTRAINT `fk_production_ingest_record_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_clearance` ADD CONSTRAINT `fk_production_production_clearance_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`rating_submission` ADD CONSTRAINT `fk_production_rating_submission_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `media_broadcasting_ecm`.`content`.`rating`(`rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`daily_production_report` ADD CONSTRAINT `fk_production_daily_production_report_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`call_sheet` ADD CONSTRAINT `fk_production_call_sheet_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);

-- ========= production --> distribution (9 constraint(s)) =========
-- Requires: production schema, distribution schema
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ADD CONSTRAINT `fk_production_project_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_release_window_id` FOREIGN KEY (`release_window_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`release_window`(`release_window_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_content_delivery_order_id` FOREIGN KEY (`content_delivery_order_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`content_delivery_order`(`content_delivery_order_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ADD CONSTRAINT `fk_production_format_spec_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`abr_profile`(`abr_profile_id`);

-- ========= production --> finance (12 constraint(s)) =========
-- Requires: production schema, finance schema
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ADD CONSTRAINT `fk_production_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ADD CONSTRAINT `fk_production_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ADD CONSTRAINT `fk_production_facility_booking_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ADD CONSTRAINT `fk_production_equipment_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`cost_transaction` ADD CONSTRAINT `fk_production_cost_transaction_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`cost_transaction` ADD CONSTRAINT `fk_production_cost_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`cost_transaction` ADD CONSTRAINT `fk_production_cost_transaction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`insurance_policy` ADD CONSTRAINT `fk_production_insurance_policy_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_clearance` ADD CONSTRAINT `fk_production_production_clearance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`daily_production_report` ADD CONSTRAINT `fk_production_daily_production_report_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= production --> mediaasset (8 constraint(s)) =========
-- Requires: production schema, mediaasset schema
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ADD CONSTRAINT `fk_production_shoot_schedule_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`vfx_shot` ADD CONSTRAINT `fk_production_vfx_shot_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`ingest_record` ADD CONSTRAINT `fk_production_ingest_record_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`daily_production_report` ADD CONSTRAINT `fk_production_daily_production_report_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= production --> partner (13 constraint(s)) =========
-- Requires: production schema, partner schema
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ADD CONSTRAINT `fk_production_project_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ADD CONSTRAINT `fk_production_facility_booking_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ADD CONSTRAINT `fk_production_equipment_allocation_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`vfx_shot` ADD CONSTRAINT `fk_production_vfx_shot_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`location` ADD CONSTRAINT `fk_production_location_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`cost_transaction` ADD CONSTRAINT `fk_production_cost_transaction_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`insurance_policy` ADD CONSTRAINT `fk_production_insurance_policy_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_clearance` ADD CONSTRAINT `fk_production_production_clearance_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_item` ADD CONSTRAINT `fk_production_equipment_item_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`vendor`(`vendor_id`);

-- ========= production --> rights (6 constraint(s)) =========
-- Requires: production schema, rights schema
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ADD CONSTRAINT `fk_production_project_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_episode` ADD CONSTRAINT `fk_production_production_episode_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ADD CONSTRAINT `fk_production_script_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`holder`(`holder_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_clearance` ADD CONSTRAINT `fk_production_production_clearance_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`broadcast` ADD CONSTRAINT `fk_production_broadcast_rights_content_window_id` FOREIGN KEY (`rights_content_window_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_content_window`(`rights_content_window_id`);

-- ========= production --> sales (8 constraint(s)) =========
-- Requires: production schema, sales schema
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ADD CONSTRAINT `fk_production_project_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ADD CONSTRAINT `fk_production_project_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ADD CONSTRAINT `fk_production_script_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_isci_creative_id` FOREIGN KEY (`isci_creative_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`isci_creative`(`isci_creative_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_clearance` ADD CONSTRAINT `fk_production_production_clearance_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`episode_sponsorship` ADD CONSTRAINT `fk_production_episode_sponsorship_sponsorship_id` FOREIGN KEY (`sponsorship_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sponsorship`(`sponsorship_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`project_sponsorship` ADD CONSTRAINT `fk_production_project_sponsorship_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`advertiser`(`advertiser_id`);

-- ========= production --> scheduling (5 constraint(s)) =========
-- Requires: production schema, scheduling schema
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ADD CONSTRAINT `fk_production_project_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`format_spec` ADD CONSTRAINT `fk_production_format_spec_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`rating_submission` ADD CONSTRAINT `fk_production_rating_submission_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`broadcast` ADD CONSTRAINT `fk_production_broadcast_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`schedule_slot`(`schedule_slot_id`);

-- ========= production --> talent (1 constraint(s)) =========
-- Requires: production schema, talent schema
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= production --> technology (8 constraint(s)) =========
-- Requires: production schema, technology schema
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ADD CONSTRAINT `fk_production_project_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ADD CONSTRAINT `fk_production_shoot_schedule_studio_facility_id` FOREIGN KEY (`studio_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`studio_facility`(`studio_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ADD CONSTRAINT `fk_production_facility_booking_studio_facility_id` FOREIGN KEY (`studio_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`studio_facility`(`studio_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_studio_facility_id` FOREIGN KEY (`studio_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`studio_facility`(`studio_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`vfx_shot` ADD CONSTRAINT `fk_production_vfx_shot_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_encoder_config_id` FOREIGN KEY (`encoder_config_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`encoder_config`(`encoder_config_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`ingest_record` ADD CONSTRAINT `fk_production_ingest_record_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);

-- ========= production --> workforce (27 constraint(s)) =========
-- Requires: production schema, workforce schema
ALTER TABLE `media_broadcasting_ecm`.`production`.`project` ADD CONSTRAINT `fk_production_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_schedule` ADD CONSTRAINT `fk_production_shoot_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget` ADD CONSTRAINT `fk_production_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`facility_booking` ADD CONSTRAINT `fk_production_facility_booking_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_allocation` ADD CONSTRAINT `fk_production_equipment_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`script` ADD CONSTRAINT `fk_production_script_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`post_production_task` ADD CONSTRAINT `fk_production_post_production_task_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`vfx_shot` ADD CONSTRAINT `fk_production_vfx_shot_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_primary_qc_employee_id` FOREIGN KEY (`primary_qc_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`ingest_record` ADD CONSTRAINT `fk_production_ingest_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`cost_transaction` ADD CONSTRAINT `fk_production_cost_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`insurance_policy` ADD CONSTRAINT `fk_production_insurance_policy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`production_clearance` ADD CONSTRAINT `fk_production_production_clearance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`rating_submission` ADD CONSTRAINT `fk_production_rating_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`daily_production_report` ADD CONSTRAINT `fk_production_daily_production_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`daily_production_report` ADD CONSTRAINT `fk_production_daily_production_report_quaternary_daily_approved_by_user_employee_id` FOREIGN KEY (`quaternary_daily_approved_by_user_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`daily_production_report` ADD CONSTRAINT `fk_production_daily_production_report_tertiary_daily_submitted_by_user_employee_id` FOREIGN KEY (`tertiary_daily_submitted_by_user_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`call_sheet` ADD CONSTRAINT `fk_production_call_sheet_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`episode_sponsorship` ADD CONSTRAINT `fk_production_episode_sponsorship_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_day` ADD CONSTRAINT `fk_production_shoot_day_director_of_photography_employee_id` FOREIGN KEY (`director_of_photography_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_day` ADD CONSTRAINT `fk_production_shoot_day_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`shoot_day` ADD CONSTRAINT `fk_production_shoot_day_first_assistant_director_employee_id` FOREIGN KEY (`first_assistant_director_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`production`.`equipment_item` ADD CONSTRAINT `fk_production_equipment_item_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= rights --> audience (5 constraint(s)) =========
-- Requires: rights schema, audience schema
ALTER TABLE `media_broadcasting_ecm`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_guarantee_id` FOREIGN KEY (`guarantee_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`guarantee`(`guarantee_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`exploitation_report` ADD CONSTRAINT `fk_rights_exploitation_report_cross_platform_measurement_id` FOREIGN KEY (`cross_platform_measurement_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`cross_platform_measurement`(`cross_platform_measurement_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`exploitation_report` ADD CONSTRAINT `fk_rights_exploitation_report_nielsen_rating_id` FOREIGN KEY (`nielsen_rating_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`nielsen_rating`(`nielsen_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`exploitation_report` ADD CONSTRAINT `fk_rights_exploitation_report_reach_frequency_report_id` FOREIGN KEY (`reach_frequency_report_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`reach_frequency_report`(`reach_frequency_report_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`exploitation_report` ADD CONSTRAINT `fk_rights_exploitation_report_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);

-- ========= rights --> compliance (13 constraint(s)) =========
-- Requires: rights schema, compliance schema
ALTER TABLE `media_broadcasting_ecm`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`grant` ADD CONSTRAINT `fk_rights_grant_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`grant` ADD CONSTRAINT `fk_rights_grant_coppa_declaration_id` FOREIGN KEY (`coppa_declaration_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`coppa_declaration`(`coppa_declaration_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`rights_content_window` ADD CONSTRAINT `fk_rights_rights_content_window_closed_caption_record_id` FOREIGN KEY (`closed_caption_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`closed_caption_record`(`closed_caption_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_coppa_declaration_id` FOREIGN KEY (`coppa_declaration_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`coppa_declaration`(`coppa_declaration_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`rights_availability_window` ADD CONSTRAINT `fk_rights_rights_availability_window_accessibility_obligation_id` FOREIGN KEY (`accessibility_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`accessibility_obligation`(`accessibility_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`conflict` ADD CONSTRAINT `fk_rights_conflict_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`license_amendment` ADD CONSTRAINT `fk_rights_license_amendment_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`exploitation_report` ADD CONSTRAINT `fk_rights_exploitation_report_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`rights_syndication_deal` ADD CONSTRAINT `fk_rights_rights_syndication_deal_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`rights_audit_event` ADD CONSTRAINT `fk_rights_rights_audit_event_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);

-- ========= rights --> content (1 constraint(s)) =========
-- Requires: rights schema, content schema
ALTER TABLE `media_broadcasting_ecm`.`rights`.`rights_audit_session` ADD CONSTRAINT `fk_rights_rights_audit_session_content_portfolio_id` FOREIGN KEY (`content_portfolio_id`) REFERENCES `media_broadcasting_ecm`.`content`.`content_portfolio`(`content_portfolio_id`);

-- ========= rights --> distribution (1 constraint(s)) =========
-- Requires: rights schema, distribution schema
ALTER TABLE `media_broadcasting_ecm`.`rights`.`exploitation_report` ADD CONSTRAINT `fk_rights_exploitation_report_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);

-- ========= rights --> finance (10 constraint(s)) =========
-- Requires: rights schema, finance schema
ALTER TABLE `media_broadcasting_ecm`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`royalty_statement_line` ADD CONSTRAINT `fk_rights_royalty_statement_line_revenue_recognition_event_id` FOREIGN KEY (`revenue_recognition_event_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`music_sync_license` ADD CONSTRAINT `fk_rights_music_sync_license_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`exploitation_report` ADD CONSTRAINT `fk_rights_exploitation_report_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`exploitation_report` ADD CONSTRAINT `fk_rights_exploitation_report_revenue_recognition_event_id` FOREIGN KEY (`revenue_recognition_event_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`license_fee_schedule` ADD CONSTRAINT `fk_rights_license_fee_schedule_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);

-- ========= rights --> mediaasset (12 constraint(s)) =========
-- Requires: rights schema, mediaasset schema
ALTER TABLE `media_broadcasting_ecm`.`rights`.`grant` ADD CONSTRAINT `fk_rights_grant_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`rights_content_window` ADD CONSTRAINT `fk_rights_rights_content_window_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`holdback` ADD CONSTRAINT `fk_rights_holdback_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`royalty_statement_line` ADD CONSTRAINT `fk_rights_royalty_statement_line_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`music_sync_license` ADD CONSTRAINT `fk_rights_music_sync_license_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`rights_availability_window` ADD CONSTRAINT `fk_rights_rights_availability_window_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`conflict` ADD CONSTRAINT `fk_rights_conflict_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`exploitation_report` ADD CONSTRAINT `fk_rights_exploitation_report_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`rights_blackout_rule` ADD CONSTRAINT `fk_rights_rights_blackout_rule_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`rights_audit_event` ADD CONSTRAINT `fk_rights_rights_audit_event_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= rights --> partner (6 constraint(s)) =========
-- Requires: rights schema, partner schema
ALTER TABLE `media_broadcasting_ecm`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`holdback` ADD CONSTRAINT `fk_rights_holdback_partner_content_window_id` FOREIGN KEY (`partner_content_window_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_content_window`(`partner_content_window_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`rights_availability_window` ADD CONSTRAINT `fk_rights_rights_availability_window_partner_content_window_id` FOREIGN KEY (`partner_content_window_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_content_window`(`partner_content_window_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`license_amendment` ADD CONSTRAINT `fk_rights_license_amendment_partner_partner_id` FOREIGN KEY (`partner_partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`license_amendment` ADD CONSTRAINT `fk_rights_license_amendment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`rights_syndication_deal` ADD CONSTRAINT `fk_rights_rights_syndication_deal_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);

-- ========= rights --> sales (2 constraint(s)) =========
-- Requires: rights schema, sales schema
ALTER TABLE `media_broadcasting_ecm`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);

-- ========= rights --> scheduling (1 constraint(s)) =========
-- Requires: rights schema, scheduling schema
ALTER TABLE `media_broadcasting_ecm`.`rights`.`exploitation_report` ADD CONSTRAINT `fk_rights_exploitation_report_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);

-- ========= rights --> talent (3 constraint(s)) =========
-- Requires: rights schema, talent schema
ALTER TABLE `media_broadcasting_ecm`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`contract`(`contract_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`residual` ADD CONSTRAINT `fk_rights_residual_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`music_sync_license` ADD CONSTRAINT `fk_rights_music_sync_license_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= rights --> technology (2 constraint(s)) =========
-- Requires: rights schema, technology schema
ALTER TABLE `media_broadcasting_ecm`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`rights_blackout_rule` ADD CONSTRAINT `fk_rights_rights_blackout_rule_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);

-- ========= rights --> workforce (17 constraint(s)) =========
-- Requires: rights schema, workforce schema
ALTER TABLE `media_broadcasting_ecm`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`music_sync_license` ADD CONSTRAINT `fk_rights_music_sync_license_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`conflict` ADD CONSTRAINT `fk_rights_conflict_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`conflict` ADD CONSTRAINT `fk_rights_conflict_conflict_legal_reviewer_employee_id` FOREIGN KEY (`conflict_legal_reviewer_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`conflict` ADD CONSTRAINT `fk_rights_conflict_conflict_resolved_by_analyst_employee_id` FOREIGN KEY (`conflict_resolved_by_analyst_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`license_amendment` ADD CONSTRAINT `fk_rights_license_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`exploitation_report` ADD CONSTRAINT `fk_rights_exploitation_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`rights_blackout_rule` ADD CONSTRAINT `fk_rights_rights_blackout_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`rights_syndication_deal` ADD CONSTRAINT `fk_rights_rights_syndication_deal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`rights_audit_event` ADD CONSTRAINT `fk_rights_rights_audit_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`rights_audit_event` ADD CONSTRAINT `fk_rights_rights_audit_event_primary_rights_employee_id` FOREIGN KEY (`primary_rights_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`rights_audit_session` ADD CONSTRAINT `fk_rights_rights_audit_session_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`rights_audit_session` ADD CONSTRAINT `fk_rights_rights_audit_session_created_by_employee_id` FOREIGN KEY (`created_by_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`rights_audit_session` ADD CONSTRAINT `fk_rights_rights_audit_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`rights`.`rights_audit_session` ADD CONSTRAINT `fk_rights_rights_audit_session_modified_by_employee_id` FOREIGN KEY (`modified_by_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= sales --> advertising (3 constraint(s)) =========
-- Requires: sales schema, advertising schema
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_proposal` ADD CONSTRAINT `fk_sales_sales_proposal_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `media_broadcasting_ecm`.`advertising`.`rate_card`(`rate_card_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal_line` ADD CONSTRAINT `fk_sales_proposal_line_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `media_broadcasting_ecm`.`advertising`.`rate_card`(`rate_card_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `media_broadcasting_ecm`.`advertising`.`rate_card`(`rate_card_id`);

-- ========= sales --> audience (10 constraint(s)) =========
-- Requires: sales schema, audience schema
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_proposal` ADD CONSTRAINT `fk_sales_sales_proposal_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ADD CONSTRAINT `fk_sales_advertising_audience_guarantee_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`dai_event` ADD CONSTRAINT `fk_sales_dai_event_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_scatter_order` ADD CONSTRAINT `fk_sales_sales_scatter_order_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);

-- ========= sales --> billing (9 constraint(s)) =========
-- Requires: sales schema, billing schema
ALTER TABLE `media_broadcasting_ecm`.`sales`.`affidavit` ADD CONSTRAINT `fk_sales_affidavit_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_proposal` ADD CONSTRAINT `fk_sales_sales_proposal_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_scatter_order` ADD CONSTRAINT `fk_sales_sales_scatter_order_ad_billing_order_id` FOREIGN KEY (`ad_billing_order_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`ad_billing_order`(`ad_billing_order_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_commitment` ADD CONSTRAINT `fk_sales_upfront_commitment_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_sales_order` ADD CONSTRAINT `fk_sales_ad_sales_order_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`content_license_deal` ADD CONSTRAINT `fk_sales_content_license_deal_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`agency_commission` ADD CONSTRAINT `fk_sales_agency_commission_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= sales --> compliance (13 constraint(s)) =========
-- Requires: sales schema, compliance schema
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_coppa_declaration_id` FOREIGN KEY (`coppa_declaration_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`coppa_declaration`(`coppa_declaration_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_closed_caption_record_id` FOREIGN KEY (`closed_caption_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`closed_caption_record`(`closed_caption_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`isci_creative` ADD CONSTRAINT `fk_sales_isci_creative_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_pod` ADD CONSTRAINT `fk_sales_ad_pod_closed_caption_record_id` FOREIGN KEY (`closed_caption_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`closed_caption_record`(`closed_caption_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`affidavit` ADD CONSTRAINT `fk_sales_affidavit_public_inspection_file_id` FOREIGN KEY (`public_inspection_file_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`public_inspection_file`(`public_inspection_file_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_scatter_order` ADD CONSTRAINT `fk_sales_sales_scatter_order_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`political_ad_disclosure` ADD CONSTRAINT `fk_sales_political_ad_disclosure_public_inspection_file_id` FOREIGN KEY (`public_inspection_file_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`public_inspection_file`(`public_inspection_file_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_sales_order` ADD CONSTRAINT `fk_sales_ad_sales_order_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`content_license_deal` ADD CONSTRAINT `fk_sales_content_license_deal_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`carriage_deal` ADD CONSTRAINT `fk_sales_carriage_deal_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);

-- ========= sales --> content (12 constraint(s)) =========
-- Requires: sales schema, content schema
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`isci_creative` ADD CONSTRAINT `fk_sales_isci_creative_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `media_broadcasting_ecm`.`content`.`genre`(`genre_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_pod` ADD CONSTRAINT `fk_sales_ad_pod_program_title_id` FOREIGN KEY (`program_title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_pod` ADD CONSTRAINT `fk_sales_ad_pod_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`affidavit` ADD CONSTRAINT `fk_sales_affidavit_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`content_license_deal` ADD CONSTRAINT `fk_sales_content_license_deal_content_library_id` FOREIGN KEY (`content_library_id`) REFERENCES `media_broadcasting_ecm`.`content`.`content_library`(`content_library_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`content_license_deal` ADD CONSTRAINT `fk_sales_content_license_deal_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_syndication_deal` ADD CONSTRAINT `fk_sales_sales_syndication_deal_package_id` FOREIGN KEY (`package_id`) REFERENCES `media_broadcasting_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);

-- ========= sales --> distribution (10 constraint(s)) =========
-- Requires: sales schema, distribution schema
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_device_type_id` FOREIGN KEY (`device_type_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`device_type`(`device_type_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`dai_event` ADD CONSTRAINT `fk_sales_dai_event_device_type_id` FOREIGN KEY (`device_type_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`device_type`(`device_type_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`dai_event` ADD CONSTRAINT `fk_sales_dai_event_playback_session_id` FOREIGN KEY (`playback_session_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`playback_session`(`playback_session_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`dai_event` ADD CONSTRAINT `fk_sales_dai_event_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_device_type_id` FOREIGN KEY (`device_type_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`device_type`(`device_type_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_playback_session_id` FOREIGN KEY (`playback_session_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`playback_session`(`playback_session_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`carriage_deal` ADD CONSTRAINT `fk_sales_carriage_deal_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`distribution_partner`(`distribution_partner_id`);

-- ========= sales --> finance (28 constraint(s)) =========
-- Requires: sales schema, finance schema
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_revenue_recognition_event_id` FOREIGN KEY (`revenue_recognition_event_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`affidavit` ADD CONSTRAINT `fk_sales_affidavit_revenue_recognition_event_id` FOREIGN KEY (`revenue_recognition_event_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ADD CONSTRAINT `fk_sales_makegood_cost_allocation_id` FOREIGN KEY (`cost_allocation_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_allocation`(`cost_allocation_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_proposal` ADD CONSTRAINT `fk_sales_sales_proposal_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_proposal` ADD CONSTRAINT `fk_sales_sales_proposal_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`dai_event` ADD CONSTRAINT `fk_sales_dai_event_revenue_recognition_event_id` FOREIGN KEY (`revenue_recognition_event_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_revenue_recognition_event_id` FOREIGN KEY (`revenue_recognition_event_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_scatter_order` ADD CONSTRAINT `fk_sales_sales_scatter_order_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`political_ad_disclosure` ADD CONSTRAINT `fk_sales_political_ad_disclosure_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_account` ADD CONSTRAINT `fk_sales_sales_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_commitment` ADD CONSTRAINT `fk_sales_upfront_commitment_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_sales_order` ADD CONSTRAINT `fk_sales_ad_sales_order_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_sales_order` ADD CONSTRAINT `fk_sales_ad_sales_order_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`content_license_deal` ADD CONSTRAINT `fk_sales_content_license_deal_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`content_license_deal` ADD CONSTRAINT `fk_sales_content_license_deal_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_syndication_deal` ADD CONSTRAINT `fk_sales_sales_syndication_deal_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`carriage_deal` ADD CONSTRAINT `fk_sales_carriage_deal_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`carriage_deal` ADD CONSTRAINT `fk_sales_carriage_deal_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);

-- ========= sales --> mediaasset (8 constraint(s)) =========
-- Requires: sales schema, mediaasset schema
ALTER TABLE `media_broadcasting_ecm`.`sales`.`isci_creative` ADD CONSTRAINT `fk_sales_isci_creative_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_proposal` ADD CONSTRAINT `fk_sales_sales_proposal_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`dai_event` ADD CONSTRAINT `fk_sales_dai_event_content_asset_id` FOREIGN KEY (`content_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`dai_event` ADD CONSTRAINT `fk_sales_dai_event_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal_line` ADD CONSTRAINT `fk_sales_proposal_line_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`content_license_deal` ADD CONSTRAINT `fk_sales_content_license_deal_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_syndication_deal` ADD CONSTRAINT `fk_sales_sales_syndication_deal_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= sales --> partner (6 constraint(s)) =========
-- Requires: sales schema, partner schema
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_scatter_order` ADD CONSTRAINT `fk_sales_sales_scatter_order_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`content_license_deal` ADD CONSTRAINT `fk_sales_content_license_deal_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);

-- ========= sales --> production (1 constraint(s)) =========
-- Requires: sales schema, production schema
ALTER TABLE `media_broadcasting_ecm`.`sales`.`content_license_deal` ADD CONSTRAINT `fk_sales_content_license_deal_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);

-- ========= sales --> rights (9 constraint(s)) =========
-- Requires: sales schema, rights schema
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_pod` ADD CONSTRAINT `fk_sales_ad_pod_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`affidavit` ADD CONSTRAINT `fk_sales_affidavit_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_proposal` ADD CONSTRAINT `fk_sales_sales_proposal_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);

-- ========= sales --> scheduling (25 constraint(s)) =========
-- Requires: sales schema, scheduling schema
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_pod` ADD CONSTRAINT `fk_sales_ad_pod_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_pod` ADD CONSTRAINT `fk_sales_ad_pod_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`affidavit` ADD CONSTRAINT `fk_sales_affidavit_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`affidavit` ADD CONSTRAINT `fk_sales_affidavit_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ADD CONSTRAINT `fk_sales_makegood_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ADD CONSTRAINT `fk_sales_makegood_makegood_proposed_channel_id` FOREIGN KEY (`makegood_proposed_channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_proposal` ADD CONSTRAINT `fk_sales_sales_proposal_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`dai_event` ADD CONSTRAINT `fk_sales_dai_event_scte_marker_id` FOREIGN KEY (`scte_marker_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`scte_marker`(`scte_marker_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_scte_marker_id` FOREIGN KEY (`scte_marker_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`scte_marker`(`scte_marker_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_scatter_order` ADD CONSTRAINT `fk_sales_sales_scatter_order_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_scatter_order` ADD CONSTRAINT `fk_sales_sales_scatter_order_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal_line` ADD CONSTRAINT `fk_sales_proposal_line_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal_line` ADD CONSTRAINT `fk_sales_proposal_line_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_sales_order` ADD CONSTRAINT `fk_sales_ad_sales_order_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`content_license_deal` ADD CONSTRAINT `fk_sales_content_license_deal_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`carriage_deal` ADD CONSTRAINT `fk_sales_carriage_deal_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`daypart`(`daypart_id`);

-- ========= sales --> subscriber (5 constraint(s)) =========
-- Requires: sales schema, subscriber schema
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`dai_event` ADD CONSTRAINT `fk_sales_dai_event_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);

-- ========= sales --> talent (5 constraint(s)) =========
-- Requires: sales schema, talent schema
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`isci_creative` ADD CONSTRAINT `fk_sales_isci_creative_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= sales --> technology (6 constraint(s)) =========
-- Requires: sales schema, technology schema
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_proposal` ADD CONSTRAINT `fk_sales_sales_proposal_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`content_license_deal` ADD CONSTRAINT `fk_sales_content_license_deal_broadcast_standard_id` FOREIGN KEY (`broadcast_standard_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_standard`(`broadcast_standard_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`carriage_deal` ADD CONSTRAINT `fk_sales_carriage_deal_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`facility_service_agreement` ADD CONSTRAINT `fk_sales_facility_service_agreement_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);

-- ========= sales --> workforce (38 constraint(s)) =========
-- Requires: sales schema, workforce schema
ALTER TABLE `media_broadcasting_ecm`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_campaign_employee_id` FOREIGN KEY (`campaign_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ADD CONSTRAINT `fk_sales_advertiser_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ADD CONSTRAINT `fk_sales_advertiser_advertiser_employee_id` FOREIGN KEY (`advertiser_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertiser` ADD CONSTRAINT `fk_sales_advertiser_advertiser_updated_by_user_employee_id` FOREIGN KEY (`advertiser_updated_by_user_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`isci_creative` ADD CONSTRAINT `fk_sales_isci_creative_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`affidavit` ADD CONSTRAINT `fk_sales_affidavit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`makegood` ADD CONSTRAINT `fk_sales_makegood_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_proposal` ADD CONSTRAINT `fk_sales_sales_proposal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_quaternary_upfront_account_executive_employee_id` FOREIGN KEY (`quaternary_upfront_account_executive_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_tertiary_upfront_modified_by_user_employee_id` FOREIGN KEY (`tertiary_upfront_modified_by_user_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`advertising_audience_guarantee` ADD CONSTRAINT `fk_sales_advertising_audience_guarantee_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_scatter_order` ADD CONSTRAINT `fk_sales_sales_scatter_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_sponsorship_created_by_user_employee_id` FOREIGN KEY (`sponsorship_created_by_user_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_sponsorship_employee_id` FOREIGN KEY (`sponsorship_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_sponsorship_modified_by_user_employee_id` FOREIGN KEY (`sponsorship_modified_by_user_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`political_ad_disclosure` ADD CONSTRAINT `fk_sales_political_ad_disclosure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_contact` ADD CONSTRAINT `fk_sales_sales_contact_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_contact` ADD CONSTRAINT `fk_sales_sales_contact_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`proposal_line` ADD CONSTRAINT `fk_sales_proposal_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`content_license_deal` ADD CONSTRAINT `fk_sales_content_license_deal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_syndication_deal` ADD CONSTRAINT `fk_sales_sales_syndication_deal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_territory` ADD CONSTRAINT `fk_sales_sales_territory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_avail_last_modified_by_user_employee_id` FOREIGN KEY (`avail_last_modified_by_user_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_option_exercise` ADD CONSTRAINT `fk_sales_upfront_option_exercise_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`upfront_option_exercise` ADD CONSTRAINT `fk_sales_upfront_option_exercise_tertiary_upfront_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_upfront_last_modified_by_user_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_deal_approval` ADD CONSTRAINT `fk_sales_sales_deal_approval_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_deal_approval` ADD CONSTRAINT `fk_sales_sales_deal_approval_quaternary_sales_created_by_user_employee_id` FOREIGN KEY (`quaternary_sales_created_by_user_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_deal_approval` ADD CONSTRAINT `fk_sales_sales_deal_approval_quinary_sales_last_modified_by_user_employee_id` FOREIGN KEY (`quinary_sales_last_modified_by_user_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_deal_approval` ADD CONSTRAINT `fk_sales_sales_deal_approval_tertiary_sales_submitted_by_user_employee_id` FOREIGN KEY (`tertiary_sales_submitted_by_user_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`sales`.`sales_team` ADD CONSTRAINT `fk_sales_sales_team_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= scheduling --> audience (1 constraint(s)) =========
-- Requires: scheduling schema, audience schema
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`channel_targeting` ADD CONSTRAINT `fk_scheduling_channel_targeting_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);

-- ========= scheduling --> billing (8 constraint(s)) =========
-- Requires: scheduling schema, billing schema
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`channel` ADD CONSTRAINT `fk_scheduling_channel_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_schedule` ADD CONSTRAINT `fk_scheduling_program_schedule_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`ad_break` ADD CONSTRAINT `fk_scheduling_ad_break_ad_billing_order_id` FOREIGN KEY (`ad_billing_order_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`ad_billing_order`(`ad_billing_order_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`scte_marker` ADD CONSTRAINT `fk_scheduling_scte_marker_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_billing_carriage_fee_invoice_id` FOREIGN KEY (`billing_carriage_fee_invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`billing_carriage_fee_invoice`(`billing_carriage_fee_invoice_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`scheduling_blackout_rule` ADD CONSTRAINT `fk_scheduling_scheduling_blackout_rule_credit_memo_id` FOREIGN KEY (`credit_memo_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`credit_memo`(`credit_memo_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`scheduling_availability_window` ADD CONSTRAINT `fk_scheduling_scheduling_availability_window_syndication_license_fee_id` FOREIGN KEY (`syndication_license_fee_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`syndication_license_fee`(`syndication_license_fee_id`);

-- ========= scheduling --> compliance (10 constraint(s)) =========
-- Requires: scheduling schema, compliance schema
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`channel` ADD CONSTRAINT `fk_scheduling_channel_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_schedule` ADD CONSTRAINT `fk_scheduling_program_schedule_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`ad_break` ADD CONSTRAINT `fk_scheduling_ad_break_political_ad_record_id` FOREIGN KEY (`political_ad_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`political_ad_record`(`political_ad_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`scheduling_blackout_rule` ADD CONSTRAINT `fk_scheduling_scheduling_blackout_rule_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_closed_caption_record_id` FOREIGN KEY (`closed_caption_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`closed_caption_record`(`closed_caption_record_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_eas_log_id` FOREIGN KEY (`eas_log_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`eas_log`(`eas_log_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_coppa_declaration_id` FOREIGN KEY (`coppa_declaration_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`coppa_declaration`(`coppa_declaration_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`scheduling_availability_window` ADD CONSTRAINT `fk_scheduling_scheduling_availability_window_compliance_consent_record_id` FOREIGN KEY (`compliance_consent_record_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`compliance_consent_record`(`compliance_consent_record_id`);

-- ========= scheduling --> content (7 constraint(s)) =========
-- Requires: scheduling schema, content schema
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`scte_marker` ADD CONSTRAINT `fk_scheduling_scte_marker_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`scheduling_blackout_rule` ADD CONSTRAINT `fk_scheduling_scheduling_blackout_rule_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `media_broadcasting_ecm`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`scheduling_availability_window` ADD CONSTRAINT `fk_scheduling_scheduling_availability_window_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`channel_license` ADD CONSTRAINT `fk_scheduling_channel_license_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);

-- ========= scheduling --> distribution (9 constraint(s)) =========
-- Requires: scheduling schema, distribution schema
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`daypart` ADD CONSTRAINT `fk_scheduling_daypart_dai_configuration_id` FOREIGN KEY (`dai_configuration_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`dai_configuration`(`dai_configuration_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`ad_break` ADD CONSTRAINT `fk_scheduling_ad_break_dai_configuration_id` FOREIGN KEY (`dai_configuration_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`dai_configuration`(`dai_configuration_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_dai_configuration_id` FOREIGN KEY (`dai_configuration_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`dai_configuration`(`dai_configuration_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_retransmission_consent_id` FOREIGN KEY (`retransmission_consent_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`retransmission_consent`(`retransmission_consent_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`scheduling_availability_window` ADD CONSTRAINT `fk_scheduling_scheduling_availability_window_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`channel_carriage` ADD CONSTRAINT `fk_scheduling_channel_carriage_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`channel_abr_assignment` ADD CONSTRAINT `fk_scheduling_channel_abr_assignment_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`abr_profile`(`abr_profile_id`);

-- ========= scheduling --> finance (6 constraint(s)) =========
-- Requires: scheduling schema, finance schema
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`channel` ADD CONSTRAINT `fk_scheduling_channel_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`channel` ADD CONSTRAINT `fk_scheduling_channel_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_schedule` ADD CONSTRAINT `fk_scheduling_program_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`ad_break` ADD CONSTRAINT `fk_scheduling_ad_break_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= scheduling --> mediaasset (7 constraint(s)) =========
-- Requires: scheduling schema, mediaasset schema
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`scheduling_availability_window` ADD CONSTRAINT `fk_scheduling_scheduling_availability_window_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`channel_asset_playout` ADD CONSTRAINT `fk_scheduling_channel_asset_playout_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= scheduling --> partner (3 constraint(s)) =========
-- Requires: scheduling schema, partner schema
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`channel` ADD CONSTRAINT `fk_scheduling_channel_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`scheduling_blackout_rule` ADD CONSTRAINT `fk_scheduling_scheduling_blackout_rule_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);

-- ========= scheduling --> rights (4 constraint(s)) =========
-- Requires: scheduling schema, rights schema
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_rights_availability_window_id` FOREIGN KEY (`rights_availability_window_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_availability_window`(`rights_availability_window_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`scheduling_blackout_rule` ADD CONSTRAINT `fk_scheduling_scheduling_blackout_rule_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`scheduling_blackout_rule` ADD CONSTRAINT `fk_scheduling_scheduling_blackout_rule_rights_availability_window_id` FOREIGN KEY (`rights_availability_window_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_availability_window`(`rights_availability_window_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`scheduling_availability_window` ADD CONSTRAINT `fk_scheduling_scheduling_availability_window_rights_availability_window_id` FOREIGN KEY (`rights_availability_window_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_availability_window`(`rights_availability_window_id`);

-- ========= scheduling --> sales (5 constraint(s)) =========
-- Requires: scheduling schema, sales schema
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_ad_pod_id` FOREIGN KEY (`ad_pod_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_pod`(`ad_pod_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`scte_marker` ADD CONSTRAINT `fk_scheduling_scte_marker_ad_pod_id` FOREIGN KEY (`ad_pod_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_pod`(`ad_pod_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_ad_pod_id` FOREIGN KEY (`ad_pod_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_pod`(`ad_pod_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_affidavit_id` FOREIGN KEY (`affidavit_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`affidavit`(`affidavit_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`channel_allocation` ADD CONSTRAINT `fk_scheduling_channel_allocation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);

-- ========= scheduling --> talent (5 constraint(s)) =========
-- Requires: scheduling schema, talent schema
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);

-- ========= scheduling --> technology (11 constraint(s)) =========
-- Requires: scheduling schema, technology schema
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`channel` ADD CONSTRAINT `fk_scheduling_channel_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`channel` ADD CONSTRAINT `fk_scheduling_channel_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_schedule` ADD CONSTRAINT `fk_scheduling_program_schedule_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`ad_break` ADD CONSTRAINT `fk_scheduling_ad_break_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`scte_marker` ADD CONSTRAINT `fk_scheduling_scte_marker_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_transmission_equipment_id` FOREIGN KEY (`transmission_equipment_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`transmission_equipment`(`transmission_equipment_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);

-- ========= scheduling --> workforce (11 constraint(s)) =========
-- Requires: scheduling schema, workforce schema
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`channel` ADD CONSTRAINT `fk_scheduling_channel_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_schedule` ADD CONSTRAINT `fk_scheduling_program_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`ad_break` ADD CONSTRAINT `fk_scheduling_ad_break_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`simulcast_config` ADD CONSTRAINT `fk_scheduling_simulcast_config_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`scheduling_blackout_rule` ADD CONSTRAINT `fk_scheduling_scheduling_blackout_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`channel_abr_assignment` ADD CONSTRAINT `fk_scheduling_channel_abr_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`scheduling`.`daypart_assignment` ADD CONSTRAINT `fk_scheduling_daypart_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= subscriber --> audience (6 constraint(s)) =========
-- Requires: subscriber schema, audience schema
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscriber` ADD CONSTRAINT `fk_subscriber_subscriber_audience_profile_id` FOREIGN KEY (`audience_profile_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`audience_profile`(`audience_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscription_plan` ADD CONSTRAINT `fk_subscriber_subscription_plan_demographic_segment_id` FOREIGN KEY (`demographic_segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`demographic_segment`(`demographic_segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`device_registration` ADD CONSTRAINT `fk_subscriber_device_registration_audience_profile_id` FOREIGN KEY (`audience_profile_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`audience_profile`(`audience_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`communication_preference` ADD CONSTRAINT `fk_subscriber_communication_preference_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`mvpd_affiliation` ADD CONSTRAINT `fk_subscriber_mvpd_affiliation_market_coverage_id` FOREIGN KEY (`market_coverage_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`market_coverage`(`market_coverage_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`offer` ADD CONSTRAINT `fk_subscriber_offer_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`segment`(`segment_id`);

-- ========= subscriber --> billing (4 constraint(s)) =========
-- Requires: subscriber schema, billing schema
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscription` ADD CONSTRAINT `fk_subscriber_subscription_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`payment_method`(`payment_method_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscription_change` ADD CONSTRAINT `fk_subscriber_subscription_change_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`payment_instrument` ADD CONSTRAINT `fk_subscriber_payment_instrument_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`payment_method`(`payment_method_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`add_on` ADD CONSTRAINT `fk_subscriber_add_on_product_id` FOREIGN KEY (`product_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`product`(`product_id`);

-- ========= subscriber --> compliance (1 constraint(s)) =========
-- Requires: subscriber schema, compliance schema
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);

-- ========= subscriber --> content (9 constraint(s)) =========
-- Requires: subscriber schema, content schema
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_package_id` FOREIGN KEY (`package_id`) REFERENCES `media_broadcasting_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `media_broadcasting_ecm`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_season_id` FOREIGN KEY (`season_id`) REFERENCES `media_broadcasting_ecm`.`content`.`season`(`season_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_vod_library_id` FOREIGN KEY (`vod_library_id`) REFERENCES `media_broadcasting_ecm`.`content`.`vod_library`(`vod_library_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`viewer_profile` ADD CONSTRAINT `fk_subscriber_viewer_profile_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `media_broadcasting_ecm`.`content`.`genre`(`genre_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`offer_redemption` ADD CONSTRAINT `fk_subscriber_offer_redemption_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);

-- ========= subscriber --> distribution (7 constraint(s)) =========
-- Requires: subscriber schema, distribution schema
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscription_plan` ADD CONSTRAINT `fk_subscriber_subscription_plan_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`device_registration` ADD CONSTRAINT `fk_subscriber_device_registration_app_version_id` FOREIGN KEY (`app_version_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`app_version`(`app_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`device_registration` ADD CONSTRAINT `fk_subscriber_device_registration_device_type_id` FOREIGN KEY (`device_type_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`device_type`(`device_type_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_release_window_id` FOREIGN KEY (`release_window_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`release_window`(`release_window_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`viewer_profile` ADD CONSTRAINT `fk_subscriber_viewer_profile_personalization_engine_id` FOREIGN KEY (`personalization_engine_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`personalization_engine`(`personalization_engine_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_distribution_partner_id` FOREIGN KEY (`distribution_partner_id`) REFERENCES `media_broadcasting_ecm`.`distribution`.`distribution_partner`(`distribution_partner_id`);

-- ========= subscriber --> finance (8 constraint(s)) =========
-- Requires: subscriber schema, finance schema
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscription_plan` ADD CONSTRAINT `fk_subscriber_subscription_plan_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscription` ADD CONSTRAINT `fk_subscriber_subscription_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscription_change` ADD CONSTRAINT `fk_subscriber_subscription_change_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`offer_redemption` ADD CONSTRAINT `fk_subscriber_offer_redemption_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`offer_redemption` ADD CONSTRAINT `fk_subscriber_offer_redemption_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`mvpd_affiliation` ADD CONSTRAINT `fk_subscriber_mvpd_affiliation_revenue_stream_id` FOREIGN KEY (`revenue_stream_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`revenue_stream`(`revenue_stream_id`);

-- ========= subscriber --> mediaasset (1 constraint(s)) =========
-- Requires: subscriber schema, mediaasset schema
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= subscriber --> partner (3 constraint(s)) =========
-- Requires: subscriber schema, partner schema
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscription_change` ADD CONSTRAINT `fk_subscriber_subscription_change_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`offer_redemption` ADD CONSTRAINT `fk_subscriber_offer_redemption_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`mvpd_affiliation` ADD CONSTRAINT `fk_subscriber_mvpd_affiliation_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);

-- ========= subscriber --> sales (2 constraint(s)) =========
-- Requires: subscriber schema, sales schema
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`offer_redemption` ADD CONSTRAINT `fk_subscriber_offer_redemption_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`win_back_offer` ADD CONSTRAINT `fk_subscriber_win_back_offer_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`campaign`(`campaign_id`);

-- ========= subscriber --> technology (1 constraint(s)) =========
-- Requires: subscriber schema, technology schema
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_outage_record_id` FOREIGN KEY (`outage_record_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`outage_record`(`outage_record_id`);

-- ========= subscriber --> workforce (7 constraint(s)) =========
-- Requires: subscriber schema, workforce schema
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`churn_event` ADD CONSTRAINT `fk_subscriber_churn_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscription_change` ADD CONSTRAINT `fk_subscriber_subscription_change_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`payment_instrument` ADD CONSTRAINT `fk_subscriber_payment_instrument_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`offer_redemption` ADD CONSTRAINT `fk_subscriber_offer_redemption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`subscriber_consent_record` ADD CONSTRAINT `fk_subscriber_subscriber_consent_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`communication_preference` ADD CONSTRAINT `fk_subscriber_communication_preference_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`subscriber`.`mvpd_affiliation` ADD CONSTRAINT `fk_subscriber_mvpd_affiliation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= talent --> audience (2 constraint(s)) =========
-- Requires: talent schema, audience schema
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_sweeps_period_id` FOREIGN KEY (`sweeps_period_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`sweeps_period`(`sweeps_period_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_guarantee_id` FOREIGN KEY (`guarantee_id`) REFERENCES `media_broadcasting_ecm`.`audience`.`guarantee`(`guarantee_id`);

-- ========= talent --> billing (5 constraint(s)) =========
-- Requires: talent schema, billing schema
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ADD CONSTRAINT `fk_talent_talent_agency_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`pension_health_contribution` ADD CONSTRAINT `fk_talent_pension_health_contribution_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= talent --> compliance (7 constraint(s)) =========
-- Requires: talent schema, compliance schema
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ADD CONSTRAINT `fk_talent_talent_profile_coppa_declaration_id` FOREIGN KEY (`coppa_declaration_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`coppa_declaration`(`coppa_declaration_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ADD CONSTRAINT `fk_talent_talent_profile_privacy_request_id` FOREIGN KEY (`privacy_request_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`privacy_request`(`privacy_request_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ADD CONSTRAINT `fk_talent_guild_affiliation_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_content_rating_id` FOREIGN KEY (`content_rating_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`content_rating`(`content_rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_coppa_declaration_id` FOREIGN KEY (`coppa_declaration_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`coppa_declaration`(`coppa_declaration_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`pension_health_contribution` ADD CONSTRAINT `fk_talent_pension_health_contribution_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= talent --> content (14 constraint(s)) =========
-- Requires: talent schema, content schema
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `media_broadcasting_ecm`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`credit_attribution` ADD CONSTRAINT `fk_talent_credit_attribution_season_id` FOREIGN KEY (`season_id`) REFERENCES `media_broadcasting_ecm`.`content`.`season`(`season_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`credit_attribution` ADD CONSTRAINT `fk_talent_credit_attribution_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`credit_attribution` ADD CONSTRAINT `fk_talent_credit_attribution_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_season_id` FOREIGN KEY (`season_id`) REFERENCES `media_broadcasting_ecm`.`content`.`season`(`season_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`usage_right` ADD CONSTRAINT `fk_talent_usage_right_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`pension_health_contribution` ADD CONSTRAINT `fk_talent_pension_health_contribution_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_clearance` ADD CONSTRAINT `fk_talent_talent_clearance_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);

-- ========= talent --> finance (7 constraint(s)) =========
-- Requires: talent schema, finance schema
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_production_budget_id` FOREIGN KEY (`production_budget_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`production_budget`(`production_budget_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ADD CONSTRAINT `fk_talent_compensation_structure_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`pension_health_contribution` ADD CONSTRAINT `fk_talent_pension_health_contribution_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`pension_health_contribution` ADD CONSTRAINT `fk_talent_pension_health_contribution_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);

-- ========= talent --> mediaasset (5 constraint(s)) =========
-- Requires: talent schema, mediaasset schema
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_eligibility` ADD CONSTRAINT `fk_talent_residual_eligibility_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`usage_right` ADD CONSTRAINT `fk_talent_usage_right_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_clearance` ADD CONSTRAINT `fk_talent_talent_clearance_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= talent --> partner (4 constraint(s)) =========
-- Requires: talent schema, partner schema
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ADD CONSTRAINT `fk_talent_talent_agency_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`partner_relationship` ADD CONSTRAINT `fk_talent_partner_relationship_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);

-- ========= talent --> production (6 constraint(s)) =========
-- Requires: talent schema, production schema
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_production_episode_id` FOREIGN KEY (`production_episode_id`) REFERENCES `media_broadcasting_ecm`.`production`.`production_episode`(`production_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ADD CONSTRAINT `fk_talent_availability_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_clearance` ADD CONSTRAINT `fk_talent_talent_clearance_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_grievance` ADD CONSTRAINT `fk_talent_talent_grievance_project_id` FOREIGN KEY (`project_id`) REFERENCES `media_broadcasting_ecm`.`production`.`project`(`project_id`);

-- ========= talent --> rights (3 constraint(s)) =========
-- Requires: talent schema, rights schema
ALTER TABLE `media_broadcasting_ecm`.`talent`.`usage_right` ADD CONSTRAINT `fk_talent_usage_right_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`grant`(`grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`usage_right` ADD CONSTRAINT `fk_talent_usage_right_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_clearance` ADD CONSTRAINT `fk_talent_talent_clearance_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`license_agreement`(`license_agreement_id`);

-- ========= talent --> sales (7 constraint(s)) =========
-- Requires: talent schema, sales schema
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_content_license_deal_id` FOREIGN KEY (`content_license_deal_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`content_license_deal`(`content_license_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ADD CONSTRAINT `fk_talent_talent_agency_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`usage_right` ADD CONSTRAINT `fk_talent_usage_right_content_license_deal_id` FOREIGN KEY (`content_license_deal_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`content_license_deal`(`content_license_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ADD CONSTRAINT `fk_talent_availability_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_clearance` ADD CONSTRAINT `fk_talent_talent_clearance_ad_sales_order_id` FOREIGN KEY (`ad_sales_order_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`ad_sales_order`(`ad_sales_order_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`endorsement_deal` ADD CONSTRAINT `fk_talent_endorsement_deal_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `media_broadcasting_ecm`.`sales`.`sales_account`(`sales_account_id`);

-- ========= talent --> technology (5 constraint(s)) =========
-- Requires: talent schema, technology schema
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_studio_facility_id` FOREIGN KEY (`studio_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`studio_facility`(`studio_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ADD CONSTRAINT `fk_talent_availability_studio_facility_id` FOREIGN KEY (`studio_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`studio_facility`(`studio_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_clearance` ADD CONSTRAINT `fk_talent_talent_clearance_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`facility_access` ADD CONSTRAINT `fk_talent_facility_access_broadcast_facility_id` FOREIGN KEY (`broadcast_facility_id`) REFERENCES `media_broadcasting_ecm`.`technology`.`broadcast_facility`(`broadcast_facility_id`);

-- ========= talent --> workforce (11 constraint(s)) =========
-- Requires: talent schema, workforce schema
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ADD CONSTRAINT `fk_talent_talent_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ADD CONSTRAINT `fk_talent_compensation_structure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_clearance` ADD CONSTRAINT `fk_talent_talent_clearance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ADD CONSTRAINT `fk_talent_cba_rate_card_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract_amendment` ADD CONSTRAINT `fk_talent_contract_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_grievance` ADD CONSTRAINT `fk_talent_talent_grievance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`endorsement_deal` ADD CONSTRAINT `fk_talent_endorsement_deal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`facility_access` ADD CONSTRAINT `fk_talent_facility_access_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= technology --> compliance (4 constraint(s)) =========
-- Requires: technology schema, compliance schema
ALTER TABLE `media_broadcasting_ecm`.`technology`.`noc_alert` ADD CONSTRAINT `fk_technology_noc_alert_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `media_broadcasting_ecm`.`technology`.`maintenance_work_order` ADD CONSTRAINT `fk_technology_maintenance_work_order_broadcast_license_id` FOREIGN KEY (`broadcast_license_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`broadcast_license`(`broadcast_license_id`);
ALTER TABLE `media_broadcasting_ecm`.`technology`.`outage_record` ADD CONSTRAINT `fk_technology_outage_record_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `media_broadcasting_ecm`.`technology`.`tech_incident` ADD CONSTRAINT `fk_technology_tech_incident_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `media_broadcasting_ecm`.`compliance`.`incident`(`incident_id`);

-- ========= technology --> partner (6 constraint(s)) =========
-- Requires: technology schema, partner schema
ALTER TABLE `media_broadcasting_ecm`.`technology`.`transmission_equipment` ADD CONSTRAINT `fk_technology_transmission_equipment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`technology`.`noc_alert` ADD CONSTRAINT `fk_technology_noc_alert_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`technology`.`maintenance_work_order` ADD CONSTRAINT `fk_technology_maintenance_work_order_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`technology`.`vendor_contract` ADD CONSTRAINT `fk_technology_vendor_contract_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`technology`.`equipment_procurement` ADD CONSTRAINT `fk_technology_equipment_procurement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`technology`.`tech_asset_lifecycle` ADD CONSTRAINT `fk_technology_tech_asset_lifecycle_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);

-- ========= technology --> rights (1 constraint(s)) =========
-- Requires: technology schema, rights schema
ALTER TABLE `media_broadcasting_ecm`.`technology`.`broadcast_facility` ADD CONSTRAINT `fk_technology_broadcast_facility_rights_territory_id` FOREIGN KEY (`rights_territory_id`) REFERENCES `media_broadcasting_ecm`.`rights`.`rights_territory`(`rights_territory_id`);

-- ========= technology --> scheduling (3 constraint(s)) =========
-- Requires: technology schema, scheduling schema
ALTER TABLE `media_broadcasting_ecm`.`technology`.`noc_alert` ADD CONSTRAINT `fk_technology_noc_alert_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`technology`.`tech_incident` ADD CONSTRAINT `fk_technology_tech_incident_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`technology`.`encoder_config` ADD CONSTRAINT `fk_technology_encoder_config_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);

-- ========= technology --> subscriber (1 constraint(s)) =========
-- Requires: technology schema, subscriber schema
ALTER TABLE `media_broadcasting_ecm`.`technology`.`noc_alert` ADD CONSTRAINT `fk_technology_noc_alert_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `media_broadcasting_ecm`.`subscriber`.`subscriber`(`subscriber_id`);

-- ========= technology --> workforce (13 constraint(s)) =========
-- Requires: technology schema, workforce schema
ALTER TABLE `media_broadcasting_ecm`.`technology`.`noc_alert` ADD CONSTRAINT `fk_technology_noc_alert_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`technology`.`maintenance_work_order` ADD CONSTRAINT `fk_technology_maintenance_work_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`technology`.`maintenance_work_order` ADD CONSTRAINT `fk_technology_maintenance_work_order_tertiary_maintenance_approved_by_employee_id` FOREIGN KEY (`tertiary_maintenance_approved_by_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`technology`.`maintenance_schedule` ADD CONSTRAINT `fk_technology_maintenance_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`technology`.`maintenance_schedule` ADD CONSTRAINT `fk_technology_maintenance_schedule_tertiary_maintenance_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_maintenance_last_modified_by_user_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`technology`.`vendor_contract` ADD CONSTRAINT `fk_technology_vendor_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`technology`.`vendor_contract` ADD CONSTRAINT `fk_technology_vendor_contract_primary_vendor_employee_id` FOREIGN KEY (`primary_vendor_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`technology`.`tech_incident` ADD CONSTRAINT `fk_technology_tech_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`technology`.`tech_incident` ADD CONSTRAINT `fk_technology_tech_incident_quaternary_tech_closed_by_user_employee_id` FOREIGN KEY (`quaternary_tech_closed_by_user_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`technology`.`tech_incident` ADD CONSTRAINT `fk_technology_tech_incident_tertiary_tech_resolved_by_user_employee_id` FOREIGN KEY (`tertiary_tech_resolved_by_user_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`technology`.`tech_asset_lifecycle` ADD CONSTRAINT `fk_technology_tech_asset_lifecycle_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`technology`.`tech_asset_lifecycle` ADD CONSTRAINT `fk_technology_tech_asset_lifecycle_quaternary_tech_last_modified_by_user_employee_id` FOREIGN KEY (`quaternary_tech_last_modified_by_user_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `media_broadcasting_ecm`.`technology`.`tech_asset_lifecycle` ADD CONSTRAINT `fk_technology_tech_asset_lifecycle_tertiary_tech_created_by_user_employee_id` FOREIGN KEY (`tertiary_tech_created_by_user_employee_id`) REFERENCES `media_broadcasting_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= workforce --> billing (1 constraint(s)) =========
-- Requires: workforce schema, billing schema
ALTER TABLE `media_broadcasting_ecm`.`workforce`.`goal` ADD CONSTRAINT `fk_workforce_goal_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `media_broadcasting_ecm`.`billing`.`cycle`(`cycle_id`);

-- ========= workforce --> finance (2 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `media_broadcasting_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `media_broadcasting_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `media_broadcasting_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= workforce --> production (7 constraint(s)) =========
-- Requires: workforce schema, production schema
ALTER TABLE `media_broadcasting_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_location_id` FOREIGN KEY (`location_id`) REFERENCES `media_broadcasting_ecm`.`production`.`location`(`location_id`);
ALTER TABLE `media_broadcasting_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_location_id` FOREIGN KEY (`location_id`) REFERENCES `media_broadcasting_ecm`.`production`.`location`(`location_id`);
ALTER TABLE `media_broadcasting_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_location_id` FOREIGN KEY (`location_id`) REFERENCES `media_broadcasting_ecm`.`production`.`location`(`location_id`);
ALTER TABLE `media_broadcasting_ecm`.`workforce`.`employment_record` ADD CONSTRAINT `fk_workforce_employment_record_location_id` FOREIGN KEY (`location_id`) REFERENCES `media_broadcasting_ecm`.`production`.`location`(`location_id`);
ALTER TABLE `media_broadcasting_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_location_id` FOREIGN KEY (`location_id`) REFERENCES `media_broadcasting_ecm`.`production`.`location`(`location_id`);
ALTER TABLE `media_broadcasting_ecm`.`workforce`.`onboarding_task` ADD CONSTRAINT `fk_workforce_onboarding_task_location_id` FOREIGN KEY (`location_id`) REFERENCES `media_broadcasting_ecm`.`production`.`location`(`location_id`);
ALTER TABLE `media_broadcasting_ecm`.`workforce`.`union_membership` ADD CONSTRAINT `fk_workforce_union_membership_location_id` FOREIGN KEY (`location_id`) REFERENCES `media_broadcasting_ecm`.`production`.`location`(`location_id`);

-- ========= workforce --> scheduling (6 constraint(s)) =========
-- Requires: workforce schema, scheduling schema
ALTER TABLE `media_broadcasting_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `media_broadcasting_ecm`.`workforce`.`work_schedule` ADD CONSTRAINT `fk_workforce_work_schedule_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `media_broadcasting_ecm`.`workforce`.`goal` ADD CONSTRAINT `fk_workforce_goal_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `media_broadcasting_ecm`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `media_broadcasting_ecm`.`scheduling`.`daypart`(`daypart_id`);

