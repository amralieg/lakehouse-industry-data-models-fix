-- Cross-Domain Foreign Keys for Business: Media_Broadcasting | Version: v2_mvm
-- Generated on: 2026-06-23 04:24:43
-- Total cross-domain FK constraints: 328
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: content, distribution, mediaasset, production, rights, sales, scheduling, subscriber, talent

-- ========= content --> distribution (19 constraint(s)) =========
-- Requires: content schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ADD CONSTRAINT `fk_content_series_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ADD CONSTRAINT `fk_content_series_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ADD CONSTRAINT `fk_content_season_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ADD CONSTRAINT `fk_content_version_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ADD CONSTRAINT `fk_content_version_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ADD CONSTRAINT `fk_content_version_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ADD CONSTRAINT `fk_content_package_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ADD CONSTRAINT `fk_content_package_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ADD CONSTRAINT `fk_content_package_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ADD CONSTRAINT `fk_content_title_rights_grant_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`partner`(`partner_id`);

-- ========= content --> mediaasset (11 constraint(s)) =========
-- Requires: content schema, mediaasset schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ADD CONSTRAINT `fk_content_title_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ADD CONSTRAINT `fk_content_season_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ADD CONSTRAINT `fk_content_episode_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ADD CONSTRAINT `fk_content_version_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ADD CONSTRAINT `fk_content_version_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ADD CONSTRAINT `fk_content_package_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= content --> rights (44 constraint(s)) =========
-- Requires: content schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ADD CONSTRAINT `fk_content_title_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ADD CONSTRAINT `fk_content_title_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ADD CONSTRAINT `fk_content_title_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ADD CONSTRAINT `fk_content_series_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ADD CONSTRAINT `fk_content_series_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ADD CONSTRAINT `fk_content_series_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ADD CONSTRAINT `fk_content_season_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ADD CONSTRAINT `fk_content_season_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ADD CONSTRAINT `fk_content_season_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ADD CONSTRAINT `fk_content_episode_clearance_request_id` FOREIGN KEY (`clearance_request_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`clearance_request`(`clearance_request_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ADD CONSTRAINT `fk_content_episode_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ADD CONSTRAINT `fk_content_episode_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ADD CONSTRAINT `fk_content_version_clearance_request_id` FOREIGN KEY (`clearance_request_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`clearance_request`(`clearance_request_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ADD CONSTRAINT `fk_content_version_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ADD CONSTRAINT `fk_content_version_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ADD CONSTRAINT `fk_content_version_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_clearance_request_id` FOREIGN KEY (`clearance_request_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`clearance_request`(`clearance_request_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_clearance_request_id` FOREIGN KEY (`clearance_request_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`clearance_request`(`clearance_request_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_royalty_rule_id` FOREIGN KEY (`royalty_rule_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`royalty_rule`(`royalty_rule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_clearance_request_id` FOREIGN KEY (`clearance_request_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`clearance_request`(`clearance_request_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_content_window_id` FOREIGN KEY (`content_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`content_window`(`content_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_holdback_id` FOREIGN KEY (`holdback_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holdback`(`holdback_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ADD CONSTRAINT `fk_content_package_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ADD CONSTRAINT `fk_content_package_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ADD CONSTRAINT `fk_content_package_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ADD CONSTRAINT `fk_content_package_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ADD CONSTRAINT `fk_content_title_rights_grant_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ADD CONSTRAINT `fk_content_title_rights_grant_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ADD CONSTRAINT `fk_content_title_rights_grant_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ADD CONSTRAINT `fk_content_title_rights_grant_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);

-- ========= content --> sales (2 constraint(s)) =========
-- Requires: content schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);

-- ========= content --> scheduling (1 constraint(s)) =========
-- Requires: content schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);

-- ========= content --> talent (5 constraint(s)) =========
-- Requires: content schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ADD CONSTRAINT `fk_content_series_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`profile`(`profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`profile`(`profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`profile`(`profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`role`(`role_id`);

-- ========= distribution --> content (9 constraint(s)) =========
-- Requires: distribution schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_episode_id` FOREIGN KEY (`episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`episode`(`episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`package`(`package_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel` ADD CONSTRAINT `fk_distribution_delivery_channel_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`genre`(`genre_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`package`(`package_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_season_id` FOREIGN KEY (`season_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`season`(`season_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);

-- ========= distribution --> mediaasset (4 constraint(s)) =========
-- Requires: distribution schema, mediaasset schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= distribution --> rights (16 constraint(s)) =========
-- Requires: distribution schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`ott_platform` ADD CONSTRAINT `fk_distribution_ott_platform_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint` ADD CONSTRAINT `fk_distribution_streaming_endpoint_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_content_window_id` FOREIGN KEY (`content_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`content_window`(`content_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ADD CONSTRAINT `fk_distribution_partner_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`partner` ADD CONSTRAINT `fk_distribution_partner_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_holdback_id` FOREIGN KEY (`holdback_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holdback`(`holdback_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_content_window_id` FOREIGN KEY (`content_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`content_window`(`content_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_holdback_id` FOREIGN KEY (`holdback_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holdback`(`holdback_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ADD CONSTRAINT `fk_distribution_channel_lineup_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);

-- ========= distribution --> scheduling (3 constraint(s)) =========
-- Requires: distribution schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement` ADD CONSTRAINT `fk_distribution_carriage_agreement_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration` ADD CONSTRAINT `fk_distribution_cdn_configuration_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`channel_lineup` ADD CONSTRAINT `fk_distribution_channel_lineup_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);

-- ========= distribution --> subscriber (1 constraint(s)) =========
-- Requires: distribution schema, subscriber schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`playback_session` ADD CONSTRAINT `fk_distribution_playback_session_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);

-- ========= distribution --> talent (1 constraint(s)) =========
-- Requires: distribution schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`distribution`.`release_window` ADD CONSTRAINT `fk_distribution_release_window_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);

-- ========= mediaasset --> rights (1 constraint(s)) =========
-- Requires: mediaasset schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ADD CONSTRAINT `fk_mediaasset_asset_storage_assignment_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);

-- ========= production --> content (14 constraint(s)) =========
-- Requires: production schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_season_id` FOREIGN KEY (`season_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`season`(`season_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ADD CONSTRAINT `fk_production_shoot_schedule_episode_id` FOREIGN KEY (`episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`episode`(`episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_episode_id` FOREIGN KEY (`episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`episode`(`episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`facility_booking` ADD CONSTRAINT `fk_production_facility_booking_episode_id` FOREIGN KEY (`episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`episode`(`episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ADD CONSTRAINT `fk_production_script_episode_id` FOREIGN KEY (`episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`episode`(`episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ADD CONSTRAINT `fk_production_script_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_episode_id` FOREIGN KEY (`episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`episode`(`episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_season_id` FOREIGN KEY (`season_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`season`(`season_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);

-- ========= production --> distribution (12 constraint(s)) =========
-- Requires: production schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_release_window_id` FOREIGN KEY (`release_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`release_window`(`release_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_release_window_id` FOREIGN KEY (`release_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`release_window`(`release_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_abr_profile_id` FOREIGN KEY (`abr_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`abr_profile`(`abr_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_release_window_id` FOREIGN KEY (`release_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`release_window`(`release_window_id`);

-- ========= production --> mediaasset (8 constraint(s)) =========
-- Requires: production schema, mediaasset schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`shoot_schedule` ADD CONSTRAINT `fk_production_shoot_schedule_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ADD CONSTRAINT `fk_production_script_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_qc_inspection_id` FOREIGN KEY (`qc_inspection_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection`(`qc_inspection_id`);

-- ========= production --> rights (5 constraint(s)) =========
-- Requires: production schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ADD CONSTRAINT `fk_production_script_clearance_request_id` FOREIGN KEY (`clearance_request_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`clearance_request`(`clearance_request_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ADD CONSTRAINT `fk_production_script_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ADD CONSTRAINT `fk_production_script_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);

-- ========= production --> sales (4 constraint(s)) =========
-- Requires: production schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_isci_creative_id` FOREIGN KEY (`isci_creative_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`isci_creative`(`isci_creative_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_isci_creative_id` FOREIGN KEY (`isci_creative_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`isci_creative`(`isci_creative_id`);

-- ========= production --> scheduling (6 constraint(s)) =========
-- Requires: production schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ADD CONSTRAINT `fk_production_script_program_rundown_id` FOREIGN KEY (`program_rundown_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown`(`program_rundown_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`qc_review` ADD CONSTRAINT `fk_production_qc_review_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`milestone` ADD CONSTRAINT `fk_production_milestone_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`(`program_schedule_id`);

-- ========= production --> subscriber (2 constraint(s)) =========
-- Requires: production schema, subscriber schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`project` ADD CONSTRAINT `fk_production_project_subscription_plan_id` FOREIGN KEY (`subscription_plan_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan`(`subscription_plan_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`deliverable` ADD CONSTRAINT `fk_production_deliverable_subscription_plan_id` FOREIGN KEY (`subscription_plan_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan`(`subscription_plan_id`);

-- ========= production --> talent (5 constraint(s)) =========
-- Requires: production schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`budget_line` ADD CONSTRAINT `fk_production_budget_line_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_deal_memo_id` FOREIGN KEY (`deal_memo_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`deal_memo`(`deal_memo_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`crew_assignment` ADD CONSTRAINT `fk_production_crew_assignment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`profile`(`profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`production`.`script` ADD CONSTRAINT `fk_production_script_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`profile`(`profile_id`);

-- ========= rights --> mediaasset (4 constraint(s)) =========
-- Requires: rights schema, mediaasset schema
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ADD CONSTRAINT `fk_rights_grant_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ADD CONSTRAINT `fk_rights_content_window_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ADD CONSTRAINT `fk_rights_holdback_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= rights --> talent (7 constraint(s)) =========
-- Requires: rights schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ADD CONSTRAINT `fk_rights_grant_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`profile`(`profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ADD CONSTRAINT `fk_rights_holdback_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`profile`(`profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ADD CONSTRAINT `fk_rights_royalty_rule_guild_affiliation_id` FOREIGN KEY (`guild_affiliation_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation`(`guild_affiliation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ADD CONSTRAINT `fk_rights_royalty_rule_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`profile`(`profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_guild_affiliation_id` FOREIGN KEY (`guild_affiliation_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation`(`guild_affiliation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`profile`(`profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`profile`(`profile_id`);

-- ========= sales --> content (14 constraint(s)) =========
-- Requires: sales schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`package`(`package_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_episode_id` FOREIGN KEY (`episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`episode`(`episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ADD CONSTRAINT `fk_sales_isci_creative_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`genre`(`genre_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ADD CONSTRAINT `fk_sales_isci_creative_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`rating`(`rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ADD CONSTRAINT `fk_sales_ad_pod_episode_id` FOREIGN KEY (`episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`episode`(`episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ADD CONSTRAINT `fk_sales_ad_pod_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ADD CONSTRAINT `fk_sales_ad_pod_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`rating`(`rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`package`(`package_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_episode_id` FOREIGN KEY (`episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`episode`(`episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);

-- ========= sales --> distribution (7 constraint(s)) =========
-- Requires: sales schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ADD CONSTRAINT `fk_sales_ad_pod_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);

-- ========= sales --> mediaasset (3 constraint(s)) =========
-- Requires: sales schema, mediaasset schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ADD CONSTRAINT `fk_sales_isci_creative_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ADD CONSTRAINT `fk_sales_isci_creative_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= sales --> rights (6 constraint(s)) =========
-- Requires: sales schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_content_window_id` FOREIGN KEY (`content_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`content_window`(`content_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ADD CONSTRAINT `fk_sales_isci_creative_clearance_request_id` FOREIGN KEY (`clearance_request_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`clearance_request`(`clearance_request_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ADD CONSTRAINT `fk_sales_ad_pod_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_content_window_id` FOREIGN KEY (`content_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`content_window`(`content_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);

-- ========= sales --> scheduling (13 constraint(s)) =========
-- Requires: sales schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_ad_break_id` FOREIGN KEY (`ad_break_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`ad_break`(`ad_break_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ADD CONSTRAINT `fk_sales_ad_pod_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ADD CONSTRAINT `fk_sales_ad_pod_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ADD CONSTRAINT `fk_sales_ad_pod_program_schedule_id` FOREIGN KEY (`program_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`(`program_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_daypart_id` FOREIGN KEY (`daypart_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`daypart`(`daypart_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`(`schedule_slot_id`);

-- ========= sales --> subscriber (5 constraint(s)) =========
-- Requires: sales schema, subscriber schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_viewer_profile_id` FOREIGN KEY (`viewer_profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile`(`viewer_profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ADD CONSTRAINT `fk_sales_ad_pod_subscription_plan_id` FOREIGN KEY (`subscription_plan_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan`(`subscription_plan_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_subscription_plan_id` FOREIGN KEY (`subscription_plan_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan`(`subscription_plan_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_subscription_plan_id` FOREIGN KEY (`subscription_plan_id`) REFERENCES `vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan`(`subscription_plan_id`);

-- ========= sales --> talent (6 constraint(s)) =========
-- Requires: sales schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`profile`(`profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`profile`(`profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ADD CONSTRAINT `fk_sales_isci_creative_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ADD CONSTRAINT `fk_sales_isci_creative_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`profile`(`profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`profile`(`profile_id`);

-- ========= scheduling --> content (13 constraint(s)) =========
-- Requires: scheduling schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel` ADD CONSTRAINT `fk_scheduling_channel_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`genre`(`genre_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_episode_id` FOREIGN KEY (`episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`episode`(`episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_episode_id` FOREIGN KEY (`episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`episode`(`episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ADD CONSTRAINT `fk_scheduling_scte_marker_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_episode_id` FOREIGN KEY (`episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`episode`(`episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);

-- ========= scheduling --> distribution (8 constraint(s)) =========
-- Requires: scheduling schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ADD CONSTRAINT `fk_scheduling_program_schedule_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`ad_break` ADD CONSTRAINT `fk_scheduling_ad_break_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ADD CONSTRAINT `fk_scheduling_scte_marker_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_streaming_endpoint_id` FOREIGN KEY (`streaming_endpoint_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`(`streaming_endpoint_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ADD CONSTRAINT `fk_scheduling_channel_carriage_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ADD CONSTRAINT `fk_scheduling_channel_carriage_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);

-- ========= scheduling --> mediaasset (9 constraint(s)) =========
-- Requires: scheduling schema, mediaasset schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= scheduling --> rights (8 constraint(s)) =========
-- Requires: scheduling schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_schedule` ADD CONSTRAINT `fk_scheduling_program_schedule_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_content_window_id` FOREIGN KEY (`content_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`content_window`(`content_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`epg_entry` ADD CONSTRAINT `fk_scheduling_epg_entry_content_window_id` FOREIGN KEY (`content_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`content_window`(`content_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_clearance_request_id` FOREIGN KEY (`clearance_request_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`clearance_request`(`clearance_request_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_clearance_request_id` FOREIGN KEY (`clearance_request_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`clearance_request`(`clearance_request_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage` ADD CONSTRAINT `fk_scheduling_channel_carriage_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);

-- ========= scheduling --> sales (3 constraint(s)) =========
-- Requires: scheduling schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_ad_pod_id` FOREIGN KEY (`ad_pod_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_pod`(`ad_pod_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`scte_marker` ADD CONSTRAINT `fk_scheduling_scte_marker_ad_pod_id` FOREIGN KEY (`ad_pod_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_pod`(`ad_pod_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_ad_pod_id` FOREIGN KEY (`ad_pod_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_pod`(`ad_pod_id`);

-- ========= scheduling --> talent (7 constraint(s)) =========
-- Requires: scheduling schema, talent schema
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`profile`(`profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot` ADD CONSTRAINT `fk_scheduling_schedule_slot_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`role`(`role_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`playout_event` ADD CONSTRAINT `fk_scheduling_playout_event_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`profile`(`profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`program_rundown` ADD CONSTRAINT `fk_scheduling_program_rundown_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`profile`(`profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_deal_memo_id` FOREIGN KEY (`deal_memo_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`deal_memo`(`deal_memo_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`profile`(`profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`scheduling`.`rundown_item` ADD CONSTRAINT `fk_scheduling_rundown_item_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`role`(`role_id`);

-- ========= subscriber --> content (10 constraint(s)) =========
-- Requires: subscriber schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan` ADD CONSTRAINT `fk_subscriber_subscription_plan_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`package`(`package_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`package`(`package_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_episode_id` FOREIGN KEY (`episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`episode`(`episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_season_id` FOREIGN KEY (`season_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`season`(`season_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_windowing_plan_id` FOREIGN KEY (`windowing_plan_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`windowing_plan`(`windowing_plan_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile` ADD CONSTRAINT `fk_subscriber_viewer_profile_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`genre`(`genre_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile` ADD CONSTRAINT `fk_subscriber_viewer_profile_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`rating`(`rating_id`);

-- ========= subscriber --> distribution (8 constraint(s)) =========
-- Requires: subscriber schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscription_plan` ADD CONSTRAINT `fk_subscriber_subscription_plan_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`subscription` ADD CONSTRAINT `fk_subscriber_subscription_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`device_registration` ADD CONSTRAINT `fk_subscriber_device_registration_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`device_registration` ADD CONSTRAINT `fk_subscriber_device_registration_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_drm_policy_id` FOREIGN KEY (`drm_policy_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`drm_policy`(`drm_policy_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_release_window_id` FOREIGN KEY (`release_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`release_window`(`release_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile` ADD CONSTRAINT `fk_subscriber_viewer_profile_ott_platform_id` FOREIGN KEY (`ott_platform_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`ott_platform`(`ott_platform_id`);

-- ========= subscriber --> rights (5 constraint(s)) =========
-- Requires: subscriber schema, rights schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_content_window_id` FOREIGN KEY (`content_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`content_window`(`content_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_entitlement_grant_id` FOREIGN KEY (`entitlement_grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);

-- ========= subscriber --> scheduling (3 constraint(s)) =========
-- Requires: subscriber schema, scheduling schema
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`entitlement` ADD CONSTRAINT `fk_subscriber_entitlement_schedule_slot_id` FOREIGN KEY (`schedule_slot_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`(`schedule_slot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`subscriber`.`viewer_profile` ADD CONSTRAINT `fk_subscriber_viewer_profile_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`scheduling`.`channel`(`channel_id`);

-- ========= talent --> content (9 constraint(s)) =========
-- Requires: talent schema, content schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_episode_id` FOREIGN KEY (`episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`episode`(`episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_season_id` FOREIGN KEY (`season_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`season`(`season_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);

-- ========= talent --> distribution (2 constraint(s)) =========
-- Requires: talent schema, distribution schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_delivery_channel_id` FOREIGN KEY (`delivery_channel_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`(`delivery_channel_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_release_window_id` FOREIGN KEY (`release_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`distribution`.`release_window`(`release_window_id`);

-- ========= talent --> mediaasset (2 constraint(s)) =========
-- Requires: talent schema, mediaasset schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= talent --> production (2 constraint(s)) =========
-- Requires: talent schema, production schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_media_broadcasting_v1`.`production`.`project`(`project_id`);

-- ========= talent --> sales (1 constraint(s)) =========
-- Requires: talent schema, sales schema
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`proposal`(`proposal_id`);

