-- Schema for Domain: newsroom | Business:  | Version: v2_ecm
-- Generated on: 2026-06-23 01:12:06

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`newsroom` COMMENT '';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` (
    `newsroom_byline_credit_id` BIGINT COMMENT 'Primary key for byline credit',
    `employee_id` BIGINT COMMENT 'FK to workforce employee if contributor is internal staff',
    `newsroom_news_story_id` BIGINT COMMENT 'FK to the associated news story',
    `byline_display_text` STRING COMMENT 'Formatted display text for the byline as shown to audience',
    `contributor_affiliation` STRING COMMENT 'Organization affiliation of the contributor',
    `contributor_email` STRING COMMENT 'Email address of the contributor',
    `contributor_name` STRING COMMENT 'Full name of the contributor (reporter/photographer/editor)',
    `contributor_phone` STRING COMMENT 'Phone number of the contributor',
    `contributor_role` STRING COMMENT 'Role of the contributor (reporter/photographer/editor/producer)',
    `created_at` TIMESTAMP COMMENT 'Record creation timestamp',
    `credit_order` STRING COMMENT 'Display order of this credit in the byline',
    `credit_type` STRING COMMENT 'Type of credit (byline/contributing/photography/video/editing)',
    `effective_from_date` DATE COMMENT 'Date from which this credit is effective',
    `effective_to_date` DATE COMMENT 'Date until which this credit is effective',
    `is_anonymous_flag` BOOLEAN COMMENT 'Flag indicating if the contributor wishes to remain anonymous',
    `is_primary_byline` BOOLEAN COMMENT 'Flag indicating if this is the primary byline credit',
    `location_dateline` STRING COMMENT 'Dateline location (city/country from which the story was filed)',
    `pseudonym` STRING COMMENT 'Pseudonym or pen name used instead of real name',
    `source_code` STRING COMMENT 'Identifier in the originating source system',
    `updated_at` TIMESTAMP COMMENT 'Record last update timestamp',
    `wire_source_code` STRING COMMENT 'Wire service source code (AP/AFP/Reuters/Bloomberg)',
    CONSTRAINT pk_newsroom_byline_credit PRIMARY KEY(`newsroom_byline_credit_id`)
) COMMENT 'Reporter/photographer/editor credit distinct from talent_credit for news content';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_breaking_news_event` (
    `newsroom_breaking_news_event_id` BIGINT COMMENT 'Primary key for breaking news event',
    `channel_id` BIGINT COMMENT 'FK to the channel broadcasting the breaking news',
    `newsroom_news_story_id` BIGINT COMMENT 'FK to the associated news story',
    `program_schedule_id` BIGINT COMMENT 'FK to the program schedule entry that was pre-empted',
    `program_rundown_id` BIGINT COMMENT 'FK to the program rundown affected by this breaking news event',
    `created_at` TIMESTAMP COMMENT 'Record creation timestamp',
    `duration_seconds` STRING COMMENT 'Duration of the breaking news coverage in seconds',
    `event_slug` STRING COMMENT 'Short slug identifier for the breaking news event',
    `event_title` STRING COMMENT 'Title of the breaking news event',
    `geographic_scope` STRING COMMENT 'Geographic scope of the breaking news event (local/regional/national/international)',
    `is_national` BOOLEAN COMMENT 'Flag indicating if the event is national scope',
    `resolved_at` TIMESTAMP COMMENT 'Timestamp when the breaking news event was resolved/ended',
    `severity_level` STRING COMMENT 'Severity classification of the breaking news event',
    `source_code` STRING COMMENT 'Identifier in the originating source system',
    `newsroom_breaking_news_event_status` STRING COMMENT 'Current status of the breaking news event (active/resolved/cancelled)',
    `trigger_source` STRING COMMENT 'Source that triggered the breaking news event (e.g. wire, field, control room)',
    `triggered_at` TIMESTAMP COMMENT 'Timestamp when the breaking news event was triggered',
    `updated_at` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_newsroom_breaking_news_event PRIMARY KEY(`newsroom_breaking_news_event_id`)
) COMMENT 'Crash-out/special-report trigger feeding program_rundown for breaking news coverage';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` (
    `newsroom_editorial_workflow_state_id` BIGINT COMMENT 'Primary key for editorial workflow state',
    `employee_id` BIGINT COMMENT 'FK to the employee who made the assignment',
    `editorial_assigned_to_employee_id` BIGINT COMMENT 'FK to the employee assigned to work in this state',
    `newsroom_news_story_id` BIGINT COMMENT 'FK to the associated news story',
    `actual_duration_minutes` STRING COMMENT 'Actual time spent in this state in minutes',
    `approval_authority` STRING COMMENT 'Authority level required for approval at this state',
    `created_at` TIMESTAMP COMMENT 'Record creation timestamp',
    `editorial_desk` STRING COMMENT 'Editorial desk responsible (e.g. national, foreign, sports, business)',
    `embargo_until_timestamp` TIMESTAMP COMMENT 'Embargo timestamp - story cannot be published before this time',
    `entered_at` TIMESTAMP COMMENT 'Timestamp when this state was entered',
    `exited_at` TIMESTAMP COMMENT 'Timestamp when this state was exited',
    `is_current_state` BOOLEAN COMMENT 'Flag indicating if this is the current active state',
    `is_sla_breached` BOOLEAN COMMENT 'Flag indicating if the SLA target was breached',
    `legal_review_completed_flag` BOOLEAN COMMENT 'Flag indicating if legal review has been completed',
    `legal_review_required_flag` BOOLEAN COMMENT 'Flag indicating if legal review is required at this state',
    `notes` STRING COMMENT 'Free-text notes about this state transition',
    `priority_level` STRING COMMENT 'Priority level of the story at this state',
    `rejection_reason` STRING COMMENT 'Reason for rejection if story was sent back to a prior state',
    `sla_target_minutes` STRING COMMENT 'Target time in minutes to complete this state',
    `source_code` STRING COMMENT 'Identifier in the originating source system',
    `state_name` STRING COMMENT 'Name of the workflow state (draft/assigned/filed/edited/cleared/published)',
    `state_order` STRING COMMENT 'Sequence order of this state in the workflow',
    `target_publication_channel` STRING COMMENT 'Target channel for publication (broadcast/web/social/all)',
    `updated_at` TIMESTAMP COMMENT 'Record last update timestamp',
    `version_number` STRING COMMENT 'Version number of the story at this state',
    `word_count_at_state` STRING COMMENT 'Word count of the story at this workflow state',
    CONSTRAINT pk_newsroom_editorial_workflow_state PRIMARY KEY(`newsroom_editorial_workflow_state_id`)
) COMMENT 'Draft to assigned to filed to edited to cleared to published editorial workflow state tracking';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_wire_ingest` (
    `newsroom_wire_ingest_id` BIGINT COMMENT 'Primary key for wire ingest record',
    `wire_ingest_id` BIGINT COMMENT 'Self-referencing FK to the original wire ingest record being corrected',
    `newsroom_news_story_id` BIGINT COMMENT 'FK to the news story this wire feed is associated with',
    `wire_story_id` BIGINT COMMENT 'Unique story identifier assigned by the wire service',
    `auto_routed_to_desk` STRING COMMENT 'Editorial desk the story was automatically routed to based on category rules',
    `body_text` STRING COMMENT 'Full body text content of the wire story',
    `created_at` TIMESTAMP COMMENT 'Record creation timestamp',
    `dateline` STRING COMMENT 'Dateline of the wire story (city/location of origin)',
    `embargo_until_timestamp` TIMESTAMP COMMENT 'Embargo timestamp; story must not be published before this time',
    `geographic_region` STRING COMMENT 'Geographic region tag for the story',
    `has_media_attachment_flag` BOOLEAN COMMENT 'Flag indicating whether the wire story has media attachments',
    `headline` STRING COMMENT 'Headline text of the wire story',
    `ingested_at` TIMESTAMP COMMENT 'Timestamp when the wire story was ingested into the system',
    `is_correction_flag` BOOLEAN COMMENT 'Flag indicating this is a correction to a previously transmitted story',
    `is_kill_notice_flag` BOOLEAN COMMENT 'Flag indicating this is a kill notice retracting a prior story',
    `language_code` STRING COMMENT 'ISO 639 language code of the wire story content',
    `media_asset_url` STRING COMMENT 'URL to the media asset attachment',
    `media_type` STRING COMMENT 'Type of media attachment (e.g. photo, video, graphic)',
    `processing_status` STRING COMMENT 'Current processing status (e.g. received, routed, assigned, published, killed)',
    `slug` STRING COMMENT 'Short slug identifier for the wire story',
    `source_code` STRING COMMENT 'Source record identifier for lineage tracking',
    `subscription_tier` STRING COMMENT 'Wire service subscription tier required to receive this content',
    `updated_at` TIMESTAMP COMMENT 'Record last update timestamp',
    `wire_category` STRING COMMENT 'Category classification from the wire service (e.g. politics, sports, business)',
    `wire_priority` STRING COMMENT 'Priority level assigned by the wire service (e.g. urgent, routine, flash)',
    `wire_service_code` STRING COMMENT 'Short code identifying the wire service',
    `wire_service_name` STRING COMMENT 'Name of the wire service agency (e.g. AP, AFP, Bloomberg)',
    `wire_transmitted_at` TIMESTAMP COMMENT 'Timestamp when the wire service transmitted the story',
    `word_count` STRING COMMENT 'Word count of the wire story body',
    CONSTRAINT pk_newsroom_wire_ingest PRIMARY KEY(`newsroom_wire_ingest_id`)
) COMMENT 'Inbound feed from news agencies (AP/AFP/Bloomberg); captures raw wire content routed into editorial workflow';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` (
    `newsroom_news_story_id` BIGINT COMMENT 'Primary key for the news story.',
    `byline` STRING COMMENT 'Primary author byline for the story.',
    `content_category` STRING COMMENT 'Broad content category for taxonomy alignment.',
    `correction_count` STRING COMMENT 'Number of corrections issued for this story.',
    `created_at` TIMESTAMP COMMENT 'Record creation timestamp.',
    `dateline_city` STRING COMMENT 'City component of the dateline.',
    `dateline_country` STRING COMMENT 'Country component of the dateline.',
    `editorial_desk` STRING COMMENT 'Desk or section responsible (politics, sports, business, etc.).',
    `embargo_datetime` TIMESTAMP COMMENT 'Embargo timestamp before which the story must not be published.',
    `expiry_datetime` TIMESTAMP COMMENT 'Timestamp after which the story should be archived.',
    `geographic_focus` STRING COMMENT 'Primary geographic focus of the story.',
    `has_audio_flag` BOOLEAN COMMENT 'Whether the story has associated audio content.',
    `has_video_flag` BOOLEAN COMMENT 'Whether the story has associated video content.',
    `headline` STRING COMMENT 'Primary headline of the news story.',
    `is_breaking` BOOLEAN COMMENT 'Whether this story is classified as breaking news.',
    `killed_datetime` TIMESTAMP COMMENT 'Timestamp when the story was killed.',
    `killed_flag` BOOLEAN COMMENT 'Whether the story has been killed/retracted.',
    `language_code` STRING COMMENT 'ISO 639-1 language code of the story.',
    `media_attachment_count` STRING COMMENT 'Number of media attachments (photos, video, audio).',
    `priority_level` STRING COMMENT 'Editorial priority (flash, urgent, routine, deferred).',
    `publish_datetime` TIMESTAMP COMMENT 'Actual publication timestamp.',
    `slug` STRING COMMENT 'Short identifier/slug for the story used in newsroom systems.',
    `source_code` STRING COMMENT 'Identifier in the source system.',
    `story_status` STRING COMMENT 'Current lifecycle status (draft, filed, edited, cleared, published, killed).',
    `story_type` STRING COMMENT 'Type classification (breaking, feature, analysis, opinion, investigative).',
    `sub_headline` STRING COMMENT 'Secondary headline or deck.',
    `updated_at` TIMESTAMP COMMENT 'Record last update timestamp.',
    `wire_source` STRING COMMENT 'Originating wire service (AP, AFP, Bloomberg, Reuters).',
    `word_count` STRING COMMENT 'Total word count of the story body.',
    CONSTRAINT pk_newsroom_news_story PRIMARY KEY(`newsroom_news_story_id`)
) COMMENT 'A news story with slug, dateline, byline, wire source, embargo, and correction lifecycle tracking.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` (
    `newsroom_correction_record_id` BIGINT COMMENT 'Primary key for the correction record.',
    `employee_id` BIGINT COMMENT 'FK to the employee who approved the correction.',
    `channel_id` BIGINT COMMENT 'FK to the channel where the on-air correction was broadcast.',
    `regulatory_obligation_id` BIGINT COMMENT 'FK to the regulatory obligation driving this correction.',
    `newsroom_news_story_id` BIGINT COMMENT 'FK to the news story being corrected.',
    `affected_section` STRING COMMENT 'Section of the story affected by the correction.',
    `broadcast_datetime` TIMESTAMP COMMENT 'Timestamp of the on-air correction broadcast.',
    `correction_status` STRING COMMENT 'Status of the correction (draft, pending_approval, approved, published).',
    `correction_text` STRING COMMENT 'Full text of the correction or editors note.',
    `correction_type` STRING COMMENT 'Type of correction (editors_note, correction, clarification, retraction, update).',
    `created_at` TIMESTAMP COMMENT 'Record creation timestamp.',
    `issued_datetime` TIMESTAMP COMMENT 'Timestamp when the correction was issued.',
    `legal_review_flag` BOOLEAN COMMENT 'Whether legal review was required for this correction.',
    `on_air_correction_flag` BOOLEAN COMMENT 'Whether an on-air correction was broadcast.',
    `original_text` STRING COMMENT 'Original text that was corrected.',
    `public_acknowledgment_flag` BOOLEAN COMMENT 'Whether the correction includes a public acknowledgment.',
    `regulatory_body` STRING COMMENT 'Regulatory body mandating the correction (FCC, Ofcom, CRTC).',
    `regulatory_mandate_flag` BOOLEAN COMMENT 'Whether the correction is mandated by a regulatory body.',
    `severity_level` STRING COMMENT 'Severity of the error being corrected (minor, moderate, major, critical).',
    `source_code` STRING COMMENT 'Identifier in the source system.',
    `updated_at` TIMESTAMP COMMENT 'Record last update timestamp.',
    CONSTRAINT pk_newsroom_correction_record PRIMARY KEY(`newsroom_correction_record_id`)
) COMMENT 'Editors note, retraction, or FCC/Ofcom-mandated on-air correction linked to compliance.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` ADD CONSTRAINT `fk_newsroom_newsroom_byline_credit_newsroom_news_story_id` FOREIGN KEY (`newsroom_news_story_id`) REFERENCES `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story`(`newsroom_news_story_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_breaking_news_event` ADD CONSTRAINT `fk_newsroom_newsroom_breaking_news_event_newsroom_news_story_id` FOREIGN KEY (`newsroom_news_story_id`) REFERENCES `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story`(`newsroom_news_story_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ADD CONSTRAINT `fk_newsroom_newsroom_editorial_workflow_state_newsroom_news_story_id` FOREIGN KEY (`newsroom_news_story_id`) REFERENCES `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story`(`newsroom_news_story_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_wire_ingest` ADD CONSTRAINT `fk_newsroom_newsroom_wire_ingest_newsroom_news_story_id` FOREIGN KEY (`newsroom_news_story_id`) REFERENCES `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story`(`newsroom_news_story_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_wire_ingest` ADD CONSTRAINT `fk_newsroom_newsroom_wire_ingest_wire_story_id` FOREIGN KEY (`wire_story_id`) REFERENCES `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story`(`newsroom_news_story_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` ADD CONSTRAINT `fk_newsroom_newsroom_correction_record_newsroom_news_story_id` FOREIGN KEY (`newsroom_news_story_id`) REFERENCES `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story`(`newsroom_news_story_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`newsroom` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`newsroom` SET TAGS ('dbx_domain' = 'newsroom');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` SET TAGS ('dbx_subdomain' = 'editorial_content');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` SET TAGS ('dbx_ecm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` SET TAGS ('dbx_transactional_data' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` ALTER COLUMN `newsroom_byline_credit_id` SET TAGS ('dbx_business_glossary_term' = 'Byline Credit ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` ALTER COLUMN `newsroom_byline_credit_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contributor Employee ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` ALTER COLUMN `employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` ALTER COLUMN `newsroom_news_story_id` SET TAGS ('dbx_business_glossary_term' = 'News Story ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` ALTER COLUMN `newsroom_news_story_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` ALTER COLUMN `byline_display_text` SET TAGS ('dbx_business_glossary_term' = 'Byline Display Text');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` ALTER COLUMN `contributor_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Contributor Affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` ALTER COLUMN `contributor_email` SET TAGS ('dbx_business_glossary_term' = 'Contributor Email');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` ALTER COLUMN `contributor_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` ALTER COLUMN `contributor_name` SET TAGS ('dbx_business_glossary_term' = 'Contributor Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` ALTER COLUMN `contributor_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` ALTER COLUMN `contributor_phone` SET TAGS ('dbx_business_glossary_term' = 'Contributor Phone');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` ALTER COLUMN `contributor_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` ALTER COLUMN `contributor_role` SET TAGS ('dbx_business_glossary_term' = 'Contributor Role');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Created At');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` ALTER COLUMN `credit_order` SET TAGS ('dbx_business_glossary_term' = 'Credit Order');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` ALTER COLUMN `credit_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` ALTER COLUMN `is_anonymous_flag` SET TAGS ('dbx_business_glossary_term' = 'Is Anonymous Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` ALTER COLUMN `is_primary_byline` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Byline');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` ALTER COLUMN `location_dateline` SET TAGS ('dbx_business_glossary_term' = 'Location Dateline');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` ALTER COLUMN `pseudonym` SET TAGS ('dbx_business_glossary_term' = 'Pseudonym');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` ALTER COLUMN `source_code` SET TAGS ('dbx_business_glossary_term' = 'Source ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Updated At');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit` ALTER COLUMN `wire_source_code` SET TAGS ('dbx_business_glossary_term' = 'Wire Source Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_breaking_news_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_breaking_news_event` SET TAGS ('dbx_subdomain' = 'broadcast_corrections');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_breaking_news_event` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_breaking_news_event` SET TAGS ('dbx_ecm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_breaking_news_event` SET TAGS ('dbx_transactional_data' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_breaking_news_event` ALTER COLUMN `newsroom_breaking_news_event_id` SET TAGS ('dbx_business_glossary_term' = 'Breaking News Event ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_breaking_news_event` ALTER COLUMN `newsroom_breaking_news_event_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_breaking_news_event` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_breaking_news_event` ALTER COLUMN `channel_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_breaking_news_event` ALTER COLUMN `newsroom_news_story_id` SET TAGS ('dbx_business_glossary_term' = 'News Story ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_breaking_news_event` ALTER COLUMN `newsroom_news_story_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_breaking_news_event` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pre-empted Program Schedule ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_breaking_news_event` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_breaking_news_event` ALTER COLUMN `program_rundown_id` SET TAGS ('dbx_business_glossary_term' = 'Program Rundown ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_breaking_news_event` ALTER COLUMN `program_rundown_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_breaking_news_event` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Created At');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_breaking_news_event` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_breaking_news_event` ALTER COLUMN `event_slug` SET TAGS ('dbx_business_glossary_term' = 'Event Slug');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_breaking_news_event` ALTER COLUMN `event_title` SET TAGS ('dbx_business_glossary_term' = 'Event Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_breaking_news_event` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_breaking_news_event` ALTER COLUMN `is_national` SET TAGS ('dbx_business_glossary_term' = 'Is National');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_breaking_news_event` ALTER COLUMN `resolved_at` SET TAGS ('dbx_business_glossary_term' = 'Resolved At');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_breaking_news_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_breaking_news_event` ALTER COLUMN `source_code` SET TAGS ('dbx_business_glossary_term' = 'Source ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_breaking_news_event` ALTER COLUMN `newsroom_breaking_news_event_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_breaking_news_event` ALTER COLUMN `trigger_source` SET TAGS ('dbx_business_glossary_term' = 'Trigger Source');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_breaking_news_event` ALTER COLUMN `triggered_at` SET TAGS ('dbx_business_glossary_term' = 'Triggered At');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_breaking_news_event` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Updated At');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` SET TAGS ('dbx_subdomain' = 'editorial_content');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` SET TAGS ('dbx_ecm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` SET TAGS ('dbx_transactional_data' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `newsroom_editorial_workflow_state_id` SET TAGS ('dbx_business_glossary_term' = 'Editorial Workflow State ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `newsroom_editorial_workflow_state_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By Employee ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `editorial_assigned_to_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Employee ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `editorial_assigned_to_employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `editorial_assigned_to_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `editorial_assigned_to_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `newsroom_news_story_id` SET TAGS ('dbx_business_glossary_term' = 'News Story ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `newsroom_news_story_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `actual_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Created At');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `editorial_desk` SET TAGS ('dbx_business_glossary_term' = 'Editorial Desk');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `embargo_until_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Embargo Until Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `entered_at` SET TAGS ('dbx_business_glossary_term' = 'Entered At');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `exited_at` SET TAGS ('dbx_business_glossary_term' = 'Exited At');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `is_current_state` SET TAGS ('dbx_business_glossary_term' = 'Is Current State');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `is_sla_breached` SET TAGS ('dbx_business_glossary_term' = 'Is SLA Breached');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `legal_review_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Completed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `legal_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `sla_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `source_code` SET TAGS ('dbx_business_glossary_term' = 'Source ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `state_name` SET TAGS ('dbx_business_glossary_term' = 'State Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `state_order` SET TAGS ('dbx_business_glossary_term' = 'State Order');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `target_publication_channel` SET TAGS ('dbx_business_glossary_term' = 'Target Publication Channel');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Updated At');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state` ALTER COLUMN `word_count_at_state` SET TAGS ('dbx_business_glossary_term' = 'Word Count At State');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_wire_ingest` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_wire_ingest` SET TAGS ('dbx_subdomain' = 'editorial_content');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_wire_ingest` SET TAGS ('dbx_scope' = 'ecm');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` SET TAGS ('dbx_subdomain' = 'editorial_content');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` SET TAGS ('dbx_ecm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` ALTER COLUMN `newsroom_news_story_id` SET TAGS ('dbx_business_glossary_term' = 'News Story Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` ALTER COLUMN `newsroom_news_story_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` ALTER COLUMN `byline` SET TAGS ('dbx_business_glossary_term' = 'Byline');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` ALTER COLUMN `byline` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` ALTER COLUMN `content_category` SET TAGS ('dbx_business_glossary_term' = 'Content Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` ALTER COLUMN `correction_count` SET TAGS ('dbx_business_glossary_term' = 'Correction Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Created At');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` ALTER COLUMN `dateline_city` SET TAGS ('dbx_business_glossary_term' = 'Dateline City');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` ALTER COLUMN `dateline_country` SET TAGS ('dbx_business_glossary_term' = 'Dateline Country');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` ALTER COLUMN `editorial_desk` SET TAGS ('dbx_business_glossary_term' = 'Editorial Desk');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` ALTER COLUMN `embargo_datetime` SET TAGS ('dbx_business_glossary_term' = 'Embargo DateTime');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` ALTER COLUMN `expiry_datetime` SET TAGS ('dbx_business_glossary_term' = 'Expiry DateTime');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` ALTER COLUMN `geographic_focus` SET TAGS ('dbx_business_glossary_term' = 'Geographic Focus');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` ALTER COLUMN `has_audio_flag` SET TAGS ('dbx_business_glossary_term' = 'Has Audio Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` ALTER COLUMN `has_video_flag` SET TAGS ('dbx_business_glossary_term' = 'Has Video Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` ALTER COLUMN `headline` SET TAGS ('dbx_business_glossary_term' = 'Headline');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` ALTER COLUMN `is_breaking` SET TAGS ('dbx_business_glossary_term' = 'Is Breaking Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` ALTER COLUMN `killed_datetime` SET TAGS ('dbx_business_glossary_term' = 'Killed DateTime');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` ALTER COLUMN `killed_flag` SET TAGS ('dbx_business_glossary_term' = 'Killed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` ALTER COLUMN `media_attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Media Attachment Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` ALTER COLUMN `publish_datetime` SET TAGS ('dbx_business_glossary_term' = 'Publish DateTime');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` ALTER COLUMN `slug` SET TAGS ('dbx_business_glossary_term' = 'Story Slug');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` ALTER COLUMN `source_code` SET TAGS ('dbx_business_glossary_term' = 'Source ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` ALTER COLUMN `story_status` SET TAGS ('dbx_business_glossary_term' = 'Story Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` ALTER COLUMN `story_type` SET TAGS ('dbx_business_glossary_term' = 'Story Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` ALTER COLUMN `sub_headline` SET TAGS ('dbx_business_glossary_term' = 'Sub Headline');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Updated At');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` ALTER COLUMN `wire_source` SET TAGS ('dbx_business_glossary_term' = 'Wire Source');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story` ALTER COLUMN `word_count` SET TAGS ('dbx_business_glossary_term' = 'Word Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` SET TAGS ('dbx_subdomain' = 'broadcast_corrections');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` SET TAGS ('dbx_ecm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` ALTER COLUMN `newsroom_correction_record_id` SET TAGS ('dbx_business_glossary_term' = 'Correction Record Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` ALTER COLUMN `newsroom_correction_record_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` ALTER COLUMN `newsroom_correction_record_id` SET TAGS ('dbx_ssot_reference' = 'content.content_correction_record.content_correction_record_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` ALTER COLUMN `channel_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` ALTER COLUMN `newsroom_news_story_id` SET TAGS ('dbx_business_glossary_term' = 'News Story ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` ALTER COLUMN `newsroom_news_story_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` ALTER COLUMN `affected_section` SET TAGS ('dbx_business_glossary_term' = 'Affected Section');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` ALTER COLUMN `broadcast_datetime` SET TAGS ('dbx_business_glossary_term' = 'Broadcast DateTime');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` ALTER COLUMN `correction_status` SET TAGS ('dbx_business_glossary_term' = 'Correction Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` ALTER COLUMN `correction_text` SET TAGS ('dbx_business_glossary_term' = 'Correction Text');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` ALTER COLUMN `correction_type` SET TAGS ('dbx_business_glossary_term' = 'Correction Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Created At');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` ALTER COLUMN `issued_datetime` SET TAGS ('dbx_business_glossary_term' = 'Issued DateTime');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` ALTER COLUMN `legal_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` ALTER COLUMN `on_air_correction_flag` SET TAGS ('dbx_business_glossary_term' = 'On Air Correction Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` ALTER COLUMN `original_text` SET TAGS ('dbx_business_glossary_term' = 'Original Text');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` ALTER COLUMN `public_acknowledgment_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Acknowledgment Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` ALTER COLUMN `source_code` SET TAGS ('dbx_business_glossary_term' = 'Source ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Updated At');
