-- Schema for Domain: community | Business: Gaming | Version: v1_ecm
-- Generated on: 2026-05-08 06:58:02

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `gaming_ecm`.`community` COMMENT 'Manages player community engagement including forums, UGC submissions, social features, guilds/clans, player-reported content moderation, player support ticketing (Zendesk), knowledge bases, chat support, NPS/CSAT tracking, K-Factor viral coefficient data, and player feedback channels. SSOT for community health, player satisfaction, and player care operations.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `gaming_ecm`.`community`.`forum` (
    `forum_id` BIGINT COMMENT 'Unique surrogate identifier for each community forum or sub-forum entity within the gaming platform. Primary key for all forum-related data products.',
    `developer_account_id` BIGINT COMMENT 'Foreign key linking to platform.developer_account. Business justification: Developer accounts manage official forums for their titles. Community managers need to link forum moderation permissions, content policy enforcement, and developer portal access to developer accounts.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title this forum is associated with. Enables forum analytics to be segmented by game title for community health reporting.',
    `parent_forum_id` BIGINT COMMENT 'Self-referencing identifier pointing to the parent forum when this record represents a sub-forum. Null for top-level forums. Supports hierarchical forum structures.',
    `storefront_id` BIGINT COMMENT 'Reference to the gaming platform (e.g., PC, console, mobile) this forum is scoped to. Supports platform-specific community segmentation.',
    `allows_attachments` BOOLEAN COMMENT 'Indicates whether players are permitted to attach files, images, or media to posts in this forum. Relevant for UGC (User-Generated Content) forums and bug report forums requiring screenshots.',
    `allows_ugc_submissions` BOOLEAN COMMENT 'Indicates whether this forum accepts formal User-Generated Content (UGC) submissions such as mods, maps, or fan art. Distinct from general attachments; triggers UGC review workflows.',
    `archived_timestamp` TIMESTAMP COMMENT 'Timestamp when this forum was transitioned to archived status. Null if the forum has never been archived. Supports community lifecycle management and data retention compliance.',
    `auto_lock_days_inactive` STRING COMMENT 'Number of days of inactivity after which threads in this forum are automatically locked. Null means threads never auto-lock. Supports community hygiene and moderation efficiency.',
    `banner_image_url` STRING COMMENT 'URL to the forums banner or header image asset hosted on the CDN (Content Delivery Network). Used for visual branding of the forum on the community portal.. Valid values are `^https?://.+$`',
    `content_rating` STRING COMMENT 'Content rating assigned to this forum based on the nature of discussions permitted, aligned with ESRB and PEGI rating systems. Determines age-gating and parental control enforcement. [ENUM-REF-CANDIDATE: E|E10+|T|M|AO|RP|PEGI_3|PEGI_7|PEGI_12|PEGI_16|PEGI_18 — promote to reference product]. Valid values are `E|E10+|T|M|AO|RP|PEGI_3|PEGI_7|PEGI_12|PEGI_16|PEGI_18`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the primary geographic market this forum serves. Used for regional compliance (GDPR, COPPA) and localized community management.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this forum record was first created in the system. Audit trail field for data lineage and community lifecycle tracking.',
    `csat_score` DECIMAL(18,2) COMMENT 'Customer Satisfaction Score (CSAT) for this forum, typically on a 1–5 scale, aggregated from player feedback. Tracks community satisfaction as part of player care operations.',
    `dau` STRING COMMENT 'Count of unique players who engaged with this forum (viewed, posted, or reacted) on the most recent calendar day. Key community health KPI (Key Performance Indicator) aligned with platform-wide DAU tracking.',
    `depth_level` STRING COMMENT 'Integer indicating the nesting depth of this forum in the hierarchy. Level 0 is a top-level forum; level 1 is a direct sub-forum; higher values indicate deeper nesting.',
    `forum_category` STRING COMMENT 'Logical grouping category for the forum used to organize forums in the community portal (e.g., Game Discussion, Technical Support, Esports, Off-Topic, Announcements, UGC Showcase). [ENUM-REF-CANDIDATE: game_discussion|technical_support|esports|announcements|ugc_showcase|off_topic|bug_reports|feedback — promote to reference product]',
    `forum_description` STRING COMMENT 'Short descriptive text explaining the purpose, scope, and posting guidelines of the forum. Displayed to players on the forum landing page.',
    `forum_name` STRING COMMENT 'Human-readable display name of the forum or sub-forum as shown to players on the community platform (e.g., General Discussion, Bug Reports, Esports Strategy).',
    `forum_status` STRING COMMENT 'Current lifecycle state of the forum. active is open for posting; inactive is temporarily disabled; archived is read-only historical forum; locked prevents new posts but remains visible; pending_review is awaiting moderation approval before going live.. Valid values are `active|inactive|archived|locked|pending_review`',
    `forum_type` STRING COMMENT 'Classifies the operational purpose of the forum. standard is general discussion; announcement is read-heavy official news; support maps to Zendesk-integrated player support; esports is for competitive community; ugc is for User-Generated Content (UGC) sharing; guild is for guild/clan community spaces.. Valid values are `standard|announcement|support|esports|ugc|guild`',
    `icon_image_url` STRING COMMENT 'URL to the forums icon or thumbnail image asset hosted on the CDN (Content Delivery Network). Used in forum listings and navigation menus.. Valid values are `^https?://.+$`',
    `is_age_restricted` BOOLEAN COMMENT 'Indicates whether this forum requires age verification before access, in compliance with ESRB, PEGI, and COPPA regulations for mature content communities.',
    `is_featured` BOOLEAN COMMENT 'Indicates whether this forum is promoted as a featured community space on the platform homepage or community hub. Featured forums receive elevated visibility for player acquisition and retention.',
    `is_pinned` BOOLEAN COMMENT 'Indicates whether this forum is pinned to the top of its category listing. Pinned forums are prioritized in navigation to drive player engagement with key community spaces.',
    `last_post_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent post made in this forum. Used to determine forum activity recency, drive auto-lock logic, and surface active forums in community portal rankings.',
    `locale_code` STRING COMMENT 'IETF BCP 47 language-region code specifying the primary language and locale of the forum (e.g., en-US, fr-FR, ja-JP, ko-KR). Supports multi-language community segmentation and localization.. Valid values are `^[a-z]{2}-[A-Z]{2}$`',
    `mau` STRING COMMENT 'Count of unique players who engaged with this forum in the most recent 30-day rolling window. Used alongside DAU for community stickiness and engagement ratio analysis.',
    `max_post_length_chars` STRING COMMENT 'Maximum character count allowed per post in this forum. Enforces posting rules and prevents spam. Null means no character limit is enforced.',
    `minimum_age_years` STRING COMMENT 'Minimum player age in years required to access this forum. Enforced for age-restricted forums per ESRB, PEGI, COPPA, and regional rating body requirements. Null if no age restriction applies.',
    `moderation_mode` STRING COMMENT 'Defines the content moderation approach for this forum. pre_moderated requires approval before posts are visible; post_moderated reviews after publishing; auto_moderated uses automated tools; unmoderated has no active moderation.. Valid values are `pre_moderated|post_moderated|auto_moderated|unmoderated`',
    `nps_score` DECIMAL(18,2) COMMENT 'Net Promoter Score (NPS) for this forum, ranging from -100 to 100, derived from player satisfaction surveys. Measures community sentiment and likelihood of players recommending the forum to others.',
    `post_count` BIGINT COMMENT 'Total cumulative number of posts ever created in this forum. Used as a community health and engagement metric. Updated by the platforms community analytics pipeline.',
    `posting_permission` STRING COMMENT 'Defines which player segments are permitted to create new posts in this forum. verified_only requires email-verified accounts; moderators_only restricts to community moderators; staff_only is for official announcements.. Valid values are `all_members|verified_only|moderators_only|staff_only`',
    `requires_account_verification` BOOLEAN COMMENT 'Indicates whether players must have a verified account (email or identity verified) to post in this forum. Supports anti-spam and COPPA compliance for age-gated communities.',
    `rules_url` STRING COMMENT 'URL linking to the official posting rules and community guidelines document for this forum. Displayed to players before posting to ensure compliance with community standards.. Valid values are `^https?://.+$`',
    `slug` STRING COMMENT 'URL-safe, lowercase hyphenated identifier used in the forums web address. Ensures stable, human-readable permalinks for SEO and deep-linking purposes.. Valid values are `^[a-z0-9]+(?:-[a-z0-9]+)*$`',
    `sort_order` STRING COMMENT 'Numeric display ordering position of the forum within its parent category or parent forum. Lower values appear first in the community portal navigation.',
    `subscriber_count` BIGINT COMMENT 'Total number of players who have subscribed to receive notifications from this forum. Indicates community reach and is used in player retention and K-Factor (Viral Coefficient) analysis.',
    `thread_count` BIGINT COMMENT 'Total cumulative number of discussion threads created in this forum. Distinct from post count; a thread is the parent topic while posts are replies. Key community engagement indicator.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this forum record (e.g., settings change, status update, moderation rule change). Supports audit trail and change data capture in the Databricks Silver layer.',
    `visibility` STRING COMMENT 'Controls who can view the forum. public is visible to all including unauthenticated visitors; private is hidden from non-members; members_only requires platform account; staff_only is restricted to internal community team.. Valid values are `public|private|members_only|staff_only`',
    `zendesk_group_code` STRING COMMENT 'External identifier linking this forum to its corresponding Zendesk support group for player support ticket routing. Enables seamless escalation from community forum posts to Zendesk tickets.',
    CONSTRAINT pk_forum PRIMARY KEY(`forum_id`)
) COMMENT 'Master entity representing community discussion forums and sub-forums within the gaming platform. Tracks forum identity, category, game title association, moderation settings, posting rules, visibility (public/private/members-only), language locale, post count, subscriber count, and active status. SSOT for all community forum structures across titles and platforms.';

CREATE OR REPLACE TABLE `gaming_ecm`.`community`.`forum_thread` (
    `forum_thread_id` BIGINT COMMENT 'Unique surrogate identifier for each forum thread or post record within the community forum system. Primary key for the forum_thread data product.',
    `backlog_item_id` BIGINT COMMENT 'Foreign key linking to studio.backlog_item. Business justification: Community-driven backlog prioritization: high-visibility threads discussing bugs or feature requests spawn backlog items. Community managers link threads to track player sentiment and prioritize work.',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Community sentiment analysis aggregates forum discussion volume and sentiment by content_drop_id to measure release reception and identify issues. Marketing uses this for launch retrospectives and fut',
    `forum_id` BIGINT COMMENT 'Reference to the parent forum or sub-forum board in which this thread or post resides. Establishes the community section context (e.g., General Discussion, Bug Reports, Patch Notes).',
    `gacha_pool_id` BIGINT COMMENT 'Foreign key linking to monetization.gacha_pool. Business justification: Gacha pools generate extensive forum discussion (drop rate analysis, pull strategy, complaints about pity system). Community managers track pool-specific sentiment for monetization feedback and to ide',
    `game_title_id` BIGINT COMMENT 'Reference to the specific game title this forum thread is associated with. Enables game-specific community analytics, moderation scoping, and cross-title engagement reporting.',
    `influencer_id` BIGINT COMMENT 'Foreign key linking to marketing.influencer. Business justification: Influencers host forum threads for AMAs, announcements, and community engagement as part of marketing partnerships. Direct link enables influencer engagement tracking, contractual deliverable verifica',
    `marketing_campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Threads are created for campaign announcements, influencer AMAs, and promotional events. Direct campaign attribution enables measurement of community engagement effectiveness and content performance p',
    `offer_campaign_id` BIGINT COMMENT 'Foreign key linking to monetization.offer_campaign. Business justification: Players create forum threads discussing promotional offers (value analysis, eligibility questions, bugs). Community managers track campaign-related discussions for sentiment analysis and to identify o',
    `player_account_id` BIGINT COMMENT 'Reference to the player who authored this thread or post. Links to the player master record for identity, account standing, and community reputation context.',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to monetization.promotion. Business justification: Players discuss promotions in forums (value analysis, code sharing, eligibility bugs). Community managers track promotion-related threads for sentiment, identify configuration issues, and measure prom',
    `seasonal_event_id` BIGINT COMMENT 'Foreign key linking to content.seasonal_event. Business justification: Community engagement metrics track forum activity per seasonal event for event success measurement. Live ops uses thread volume and sentiment to evaluate event reception and inform future event design',
    `thread_root_forum_thread_id` BIGINT COMMENT 'Reference to the originating thread-starter post (depth level 0) for all replies within the same conversation. Equals forum_thread_id for root posts. Enables efficient retrieval of all posts within a thread without recursive traversal.',
    `author_display_name` STRING COMMENT 'The in-game or forum display name (gamertag/username) of the post author at the time of posting. Stored as a snapshot to preserve historical display context even if the player later changes their display name. Classified as confidential PII as it is a pseudonymous identifier traceable to an individual.',
    `author_post_count_at_time` STRING COMMENT 'Snapshot of the authors total forum post count at the time this post was submitted. Provides community seniority context for moderation decisions and trust-scoring models without requiring a join to current player stats.',
    `body_content` STRING COMMENT 'Full text body of the forum post or reply, stored as plain text or lightweight markup (BBCode/Markdown). Primary content payload for community discourse, moderation review, and NLP-based sentiment analysis.',
    `content_language_code` STRING COMMENT 'ISO 639-1 language code (optionally with ISO 3166-1 region subtag) of the post body content (e.g., en, en-US, fr, de, ja, ko). Supports multilingual community moderation routing, localization analytics, and GDPR jurisdiction determination.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `content_rating_category` STRING COMMENT 'Community content maturity classification applied to this post, aligned with ESRB/PEGI rating vocabulary. Supports age-gating of forum content, COPPA compliance for underage players, and platform certification requirements.. Valid values are `everyone|teen|mature|adult_only`',
    `created_timestamp` TIMESTAMP COMMENT 'System audit timestamp recording when this forum_thread record was first persisted to the data platform. May differ slightly from post_timestamp due to ingestion latency. Supports data lineage and Silver layer audit requirements.',
    `csat_score` STRING COMMENT 'Customer Satisfaction Score (CSAT) value (1–5) optionally collected from the post author following a community support interaction associated with this thread. Supports player care quality measurement and Zendesk integration reporting.',
    `downvote_count` STRING COMMENT 'Total number of downvotes (negative reactions) received by this post from community members. Used alongside upvote_count to compute net community sentiment score and content quality signals.',
    `edit_count` STRING COMMENT 'Total number of times this post has been edited by the author or a moderator. Supports transparency indicators and moderation audit. High edit counts may signal content manipulation patterns.',
    `flair_label` STRING COMMENT 'Community-assigned or author-selected flair tag categorizing the thread topic (e.g., Bug Report, Feedback, Guide, Lore, Patch Discussion). Supports forum navigation, filtering, and content taxonomy analytics.',
    `is_deleted` BOOLEAN COMMENT 'Soft-delete flag indicating the post has been removed from public view by the author or a moderator. Retains the record for audit, compliance, and potential restoration. Supports GDPR right-to-erasure workflows.',
    `is_edited` BOOLEAN COMMENT 'Indicates whether the post body or title has been edited after initial submission. Displayed to community members as an edit indicator. Supports transparency and moderation audit requirements.',
    `is_featured` BOOLEAN COMMENT 'Indicates whether this thread has been editorially featured by community managers for promotional or highlight purposes. Featured threads may appear in community spotlights, newsletters, or homepage widgets.',
    `is_locked` BOOLEAN COMMENT 'Indicates whether this thread has been locked by a moderator, preventing further replies. Locked threads remain visible but are closed to new community contributions. Common for resolved issues or policy-violating discussions.',
    `is_pinned` BOOLEAN COMMENT 'Indicates whether this thread has been pinned to the top of the forum board by a moderator or community manager. Pinned threads receive elevated visibility for important announcements or community resources.',
    `is_reported` BOOLEAN COMMENT 'Indicates whether this post has been reported by one or more community members for potential policy violations. Triggers moderation queue entry. Key signal for community health monitoring and trust-and-safety operations.',
    `is_ugc_submission` BOOLEAN COMMENT 'Indicates whether this post has been formally tagged as a User-Generated Content (UGC) submission (e.g., fan art showcase, mod announcement, community guide). Enables UGC pipeline routing and IP compliance review workflows.',
    `last_edited_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent edit to this posts body or title content. Displayed to community members as the edit time indicator. Supports content freshness analytics and moderation audit.',
    `last_reply_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent reply posted within this thread. Applicable to thread-root posts. Used for thread sorting by recent activity, stale thread detection, and community engagement recency metrics.',
    `moderation_action_type` STRING COMMENT 'Type of moderation action applied to this post by a community moderator or automated trust-and-safety system. Supports moderation audit trails, compliance reporting under DSA, and moderator performance analytics.. Valid values are `none|warned|edited|removed|escalated`',
    `moderation_note` STRING COMMENT 'Internal moderator-authored note documenting the rationale for a moderation action. Not visible to community members. Supports moderation audit trails, appeals processes, and DSA compliance documentation.',
    `moderation_status` STRING COMMENT 'Current moderation lifecycle state of the post. Controls visibility to community members. Drives moderation queue workflows and compliance audit trails for content policy enforcement.. Valid values are `visible|pending_review|removed|flagged|approved`',
    `moderation_timestamp` TIMESTAMP COMMENT 'Date and time when the most recent moderation action was applied to this post. Supports SLA tracking for moderation response times and DSA compliance reporting on content removal timelines.',
    `nps_score` STRING COMMENT 'Net Promoter Score (NPS) value (0–10) optionally collected from the post author via an in-forum NPS survey prompt associated with this thread interaction. Contributes to community satisfaction tracking and player sentiment analytics.',
    `parent_post_id` BIGINT COMMENT 'Self-referencing identifier pointing to the immediate parent post in a threaded reply chain. NULL for thread-starting posts (depth level 0). Enables nested conversation tree traversal.',
    `platform_source` STRING COMMENT 'The platform or client from which this post was submitted. Enables cross-platform community engagement analysis and platform-specific moderation tooling. Aligns with Steamworks/Epic Games Store/Console SDK platform taxonomy.. Valid values are `web|mobile_ios|mobile_android|console|steam|epic`',
    `post_depth_level` STRING COMMENT 'Integer indicating the nesting depth of this post within the thread hierarchy. Value 0 = thread root post; 1 = direct reply to root; 2+ = nested reply. Supports both flat and threaded conversation rendering models.',
    `post_timestamp` TIMESTAMP COMMENT 'Date and time when this post or thread was originally submitted by the author. The principal business event timestamp representing when the community discourse event occurred. Distinct from system audit created_timestamp.',
    `post_type` STRING COMMENT 'Discriminator indicating whether this record is a thread-starting post or a reply within an existing thread. Also captures special post types such as announcements and polls. Drives rendering logic and analytics segmentation.. Valid values are `thread|reply|announcement|poll|sticky`',
    `reply_count` STRING COMMENT 'Total number of direct and nested replies within this thread. Applicable to thread-root posts. Measures community engagement depth and discussion activity. Used in trending thread algorithms.',
    `report_count` STRING COMMENT 'Total number of community member reports submitted against this post. Distinct from is_reported flag; provides severity signal for moderation prioritization. High report counts may trigger automated moderation actions.',
    `title` STRING COMMENT 'Human-readable subject line of the thread, populated only for thread-starting posts (post_type = thread or announcement). NULL for reply posts. Displayed in forum index listings and search results.',
    `updated_timestamp` TIMESTAMP COMMENT 'System audit timestamp recording when this forum_thread record was last modified in the data platform. Tracks any field-level changes including moderation status updates, vote count refreshes, and flag changes.',
    `upvote_count` STRING COMMENT 'Total number of upvotes (positive reactions) received by this post from community members. Contributes to post ranking, community reputation scoring, and content quality signals.',
    `view_count` BIGINT COMMENT 'Cumulative number of times this thread has been viewed by community members. Applicable primarily to thread-root posts. Key engagement metric for community health dashboards and content popularity analysis.',
    CONSTRAINT pk_forum_thread PRIMARY KEY(`forum_thread_id`)
) COMMENT 'Transactional record of forum threads and their constituent posts within community forums. Each record represents either a thread-starting post or a reply within a thread, supporting flat and nested conversation models. Captures post title (for thread starters), body content, author player reference, parent forum reference, parent post reference for threaded replies, post depth level, pinned/locked/featured flags, view count, reply count, upvote/downvote tallies, moderation status, flair/tag labels, edit history flag, reported flag, and timestamps. Atomic unit of community forum discourse. SSOT for all forum conversation content.';

CREATE OR REPLACE TABLE `gaming_ecm`.`community`.`forum_post` (
    `forum_post_id` BIGINT COMMENT 'Unique system-generated identifier for each individual forum post or reply within the gaming community platform. Primary key for this entity.',
    `forum_category_id` BIGINT COMMENT 'Reference to the forum category or subforum this post belongs to (e.g., Bug Reports, General Discussion, Esports, Patch Notes). Used for community analytics segmentation and moderation routing.',
    `forum_thread_id` BIGINT COMMENT 'Reference to the parent forum thread that this post belongs to. Every post must be associated with exactly one thread.',
    `game_title_id` BIGINT COMMENT 'Reference to the specific game title this forum post is associated with. Enables per-title community health metrics, game-specific moderation policies, and title-level player engagement reporting.',
    `guild_id` BIGINT COMMENT 'Reference to the guild or clan associated with this post, if posted within a guild-specific forum space. Null for general community posts. Supports guild community engagement analytics.',
    `moderation_action_id` BIGINT COMMENT 'Reference to the moderation action record applied to this post, if any. Null if no moderation action has been taken.',
    `parent_post_forum_post_id` BIGINT COMMENT 'Reference to the post being directly replied to, enabling nested/threaded conversation structures. Null if this is a top-level post within the thread.',
    `player_account_id` BIGINT COMMENT 'Reference to the player account that authored this post. Links to the player master record for community engagement analytics and moderation history.',
    `support_ticket_id` BIGINT COMMENT 'External reference to the Zendesk player support ticket created from or linked to this forum post. Populated when a forum post is escalated to a formal support case. Enables cross-system traceability between community and player support operations.',
    `author_display_name` STRING COMMENT 'The in-game or community display name (gamertag/username) of the post author at the time of posting. Denormalized from the player record for historical accuracy in case the player later changes their display name.',
    `char_count` STRING COMMENT 'Total character length of the post body at the time of last save. Used for content quality analytics, spam detection heuristics, and enforcing platform post length limits.',
    `contains_spoiler` BOOLEAN COMMENT 'Indicates whether the post has been tagged as containing game story or content spoilers. Enables spoiler-blur rendering in the community UI and supports community content policy enforcement.',
    `content_warning_flag` BOOLEAN COMMENT 'Indicates whether this post has been tagged with a content warning by the author or a moderator. Relevant for ESRB/PEGI compliance and age-gating in community spaces associated with mature-rated titles.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the forum post was originally submitted by the author. This is the principal business event timestamp representing the moment of community interaction. Stored in ISO 8601 format with timezone offset.',
    `deleted_timestamp` TIMESTAMP COMMENT 'Date and time when the post was soft-deleted by the author or an administrator. Null if the post has not been deleted. Supports GDPR right-to-erasure audit trails and content lifecycle reporting.',
    `downvote_count` STRING COMMENT 'Total number of negative community votes (downvotes/dislikes) received by this post. Used alongside upvote_count to compute net community sentiment and identify potentially problematic content.',
    `edit_count` STRING COMMENT 'Total number of times this post has been edited by the author or a moderator. Used in moderation analytics to identify posts with unusual edit patterns.',
    `ip_address` STRING COMMENT 'IP address of the player at the time of post submission. Used for fraud detection, ban evasion identification, and geographic compliance enforcement. May be considered PII under GDPR in EU jurisdictions. Stored in compliance with data minimization principles.',
    `is_anonymous` BOOLEAN COMMENT 'Indicates whether the post was submitted anonymously, hiding the authors identity from other community members. Relevant for player feedback channels and GDPR data minimization compliance.',
    `is_edited` BOOLEAN COMMENT 'Indicates whether the post body has been modified after initial submission. Triggers display of an edit indicator in the community UI and flags the post for audit trail review.',
    `is_pinned` BOOLEAN COMMENT 'Indicates whether this post has been pinned to the top of the thread by a moderator or community manager for elevated visibility. Used for official announcements and important community notices.',
    `is_reported` BOOLEAN COMMENT 'Indicates whether this post has been reported by one or more community members for violating community guidelines. Triggers moderation queue entry when set to true.',
    `is_solution` BOOLEAN COMMENT 'Indicates whether this post has been marked as the accepted solution to the threads question by the original poster or a moderator. Used in player support knowledge base analytics and CSAT (Customer Satisfaction Score) tracking.',
    `is_staff_post` BOOLEAN COMMENT 'Indicates whether this post was authored by a Gaming staff member, community manager, or official representative. Used to distinguish official communications from player-generated content in community analytics.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code (optionally with ISO 3166-1 region subtag) of the post content, either author-declared or auto-detected. Used for multilingual community moderation routing and localization analytics.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_edited_timestamp` TIMESTAMP COMMENT 'Date and time when the post body was most recently modified. Null if the post has never been edited. Stored in ISO 8601 format with timezone offset.',
    `moderation_reason` STRING COMMENT 'Categorical reason code assigned by the moderation team when a moderation action is taken. Used for moderation analytics, policy enforcement reporting, and regulatory compliance. [ENUM-REF-CANDIDATE: hate_speech|harassment|spam|cheating_discussion|spoiler|off_topic|misinformation|explicit_content|other — promote to reference product]',
    `moderation_status` STRING COMMENT 'Current state of the moderation workflow for this post. not_reviewed = no moderation activity; under_review = assigned to a moderator; approved = reviewed and cleared; actioned = moderation action taken; escalated = referred to senior moderation or legal team.. Valid values are `not_reviewed|under_review|approved|actioned|escalated`',
    `nps_survey_triggered` BOOLEAN COMMENT 'Indicates whether this post interaction triggered an NPS (Net Promoter Score) or CSAT (Customer Satisfaction Score) survey prompt to the author. Used in player satisfaction measurement and community feedback channel analytics.',
    `platform_source` STRING COMMENT 'The platform or client interface from which the post was submitted. Used for community engagement analytics segmented by platform and for identifying platform-specific UX issues.. Valid values are `web|mobile_ios|mobile_android|console_overlay|desktop_client`',
    `post_body` STRING COMMENT 'Full text content of the forum post as authored by the player. May include game-related discussion, bug reports, feedback, or community conversation. Subject to content moderation policies and GDPR right-to-erasure obligations.',
    `post_format` STRING COMMENT 'Markup or formatting type used in the post body. Determines how the content is rendered in the community UI and how it is processed during content moderation and indexing.. Valid values are `plain_text|markdown|rich_text|bbcode`',
    `post_number` STRING COMMENT 'Sequential position of this post within its parent thread, used for ordering and display. Assigned at post creation time and reflects chronological order within the thread.',
    `post_status` STRING COMMENT 'Current lifecycle state of the forum post. active = visible to community; hidden = temporarily concealed pending review; removed = taken down by moderation; pending_review = flagged and awaiting moderator decision; locked = no further replies allowed; deleted = soft-deleted by author or admin.. Valid values are `active|hidden|removed|pending_review|locked|deleted`',
    `post_type` STRING COMMENT 'Classification of the post within the thread structure. original_post = first post opening the thread; reply = standard response; quote_reply = reply quoting another post; announcement = official staff post; pinned = elevated visibility post.. Valid values are `original_post|reply|quote_reply|announcement|pinned`',
    `reply_count` STRING COMMENT 'Number of direct replies to this specific post. Denormalized count maintained for performance in community engagement dashboards and thread activity metrics.',
    `report_count` STRING COMMENT 'Total number of distinct player reports submitted against this post. Higher counts may trigger automated moderation escalation thresholds.',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Automated NLP-derived sentiment score for the post body, ranging from -1.0 (most negative) to 1.0 (most positive). Used in community health dashboards, NPS (Net Promoter Score) proxy analytics, and early toxicity detection pipelines.',
    `toxicity_score` DECIMAL(18,2) COMMENT 'Automated ML-derived toxicity probability score for the post body, ranging from 0.0 (non-toxic) to 1.0 (highly toxic). Used to prioritize moderation queue items and support community health KPI (Key Performance Indicator) reporting.',
    `ugc_attachment_count` STRING COMMENT 'Number of media attachments (screenshots, videos, UGC assets) included in this post. Used for content moderation workload estimation and UGC (User-Generated Content) volume analytics.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when any field on this forum post record was last modified, including moderation actions, vote count updates, or content edits. Used for incremental data pipeline processing and audit trail.',
    `upvote_count` STRING COMMENT 'Total number of positive community votes (upvotes/likes) received by this post. Used in community health scoring, content surfacing algorithms, and player engagement analytics.',
    CONSTRAINT pk_forum_post PRIMARY KEY(`forum_post_id`)
) COMMENT 'Transactional record of individual replies and posts within a forum thread. Stores post body content, author player reference, parent thread reference, reply-to post reference for nested conversations, edit history flag, upvote/downvote counts, moderation action status, reported flag, and timestamps. Granular unit of community interaction below thread level.';

CREATE OR REPLACE TABLE `gaming_ecm`.`community`.`ugc_submission` (
    `ugc_submission_id` BIGINT COMMENT 'Unique surrogate identifier for each UGC submission record in the community domain. Primary key for the ugc_submission data product. Entity role: MASTER_RESOURCE — represents a digital asset owned and managed by the gaming platform with its own identity and lifecycle.',
    `achievement_id` BIGINT COMMENT 'Foreign key linking to title.achievement. Business justification: UGC submissions (custom maps, mods, skins) frequently unlock specific achievements in live-service games. Tracking which achievement a submission unlocks enables progression system validation, reward ',
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: UGC distributed on platforms requires age rating certification to comply with ESRB/PEGI/rating authority requirements. Platform holders mandate cert_id for UGC marketplace approval. Removes denormaliz',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: UGC moderation pipeline validates that player-created content references approved base assets. Content distribution tracks which game assets are used in UGC for licensing/IP clearance and usage analyt',
    `build_id` BIGINT COMMENT 'Foreign key linking to studio.build. Business justification: UGC compatibility validation: submissions are tested against specific builds to ensure compatibility. Moderation teams need build version to reproduce issues and validate content before approval.',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Live ops tracks UGC participation by content drop (seasonal event submissions, patch-specific creations) for engagement metrics and event ROI. Essential for measuring content-driven UGC activity and c',
    `dlc_bundle_id` BIGINT COMMENT 'Reference to the specific DLC product required to use this UGC submission, when requires_base_game_dlc is true. Used for entitlement checks during download and in-game loading.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title this UGC submission is associated with. Links the UGC asset to the specific game for which it was created (e.g., a mod, map, or skin belongs to a specific game title).',
    `influencer_id` BIGINT COMMENT 'Foreign key linking to marketing.influencer. Business justification: Influencers submit UGC as part of partnership agreements (custom maps, skins, mods). Direct link enables influencer content tracking, contractual deliverable verification, and measurement of influence',
    `invoice_line_id` BIGINT COMMENT 'Foreign key linking to billing.invoice_line. Business justification: Creator revenue recognition and payout processing requires linking UGC submissions to invoice lines for accurate revenue share calculations and tax reporting per creator agreements.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: UGC submissions have IP ownership, liability, and revenue-sharing implications. Tracking which legal entity owns/hosts the content is essential for IP rights management, creator payment processing, ta',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: UGC submissions using licensed IP (music tracks, middleware SDKs, brand assets) require tracking for IP clearance status, royalty calculation, and compliance verification. Critical for DMCA compliance',
    `marketing_campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: UGC contests and creator challenges are core marketing tactics in gaming. Tracking which campaign sourced each submission is essential for calculating campaign ROI, engagement rates, and content acqui',
    `mtx_catalog_id` BIGINT COMMENT 'Foreign key linking to monetization.mtx_catalog. Business justification: UGC submissions showcase purchased cosmetic items (outfit showcases, build tours featuring premium items). Content creators reference catalog items in submissions - marketing tracks which items drive ',
    `offer_campaign_id` BIGINT COMMENT 'Foreign key linking to monetization.offer_campaign. Business justification: Promotional campaigns incentivize UGC creation (contests, themed building challenges, cosmetic showcases). Submissions tied to campaigns for eligibility verification, reward distribution, and campaign',
    `platform_sku_id` BIGINT COMMENT 'Foreign key linking to platform.platform_sku. Business justification: UGC content (mods, maps, skins) targets specific SKUs/editions (e.g., Deluxe Edition DLC). Content compatibility validation, storefront filtering, and entitlement checks require SKU-level tracking. No',
    `player_account_id` BIGINT COMMENT 'Reference to the player who created and submitted this UGC asset. Establishes authorship and ownership for attribution, royalty eligibility, and community reputation tracking.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: UGC approval workflows require tracking which employee reviewed/approved submissions for IP clearance, content rating compliance, and monetization eligibility. Critical for audit trails, quality assur',
    `storefront_order_line_id` BIGINT COMMENT 'Foreign key linking to billing.storefront_order_line. Business justification: Paid UGC marketplace sales tracking requires linking creator submissions to storefront transactions for revenue share calculations, creator payouts, and sales analytics reporting.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the UGC submission was approved by the moderation team and made publicly available. Used to calculate moderation SLA compliance and measure time-to-publish for community content.',
    `asset_url` STRING COMMENT 'Secure HTTPS URL pointing to the hosted UGC asset package on the CDN or platform storage. Used by game clients and platform SDKs to download the UGC content. Must be a valid HTTPS endpoint.. Valid values are `^https://.*`',
    `comment_count` STRING COMMENT 'Total number of community comments posted on this UGC submissions page. Measures community engagement depth and is used to identify high-discussion content for editorial featuring and moderation prioritization.',
    `creator_revenue_share_pct` DECIMAL(18,2) COMMENT 'Percentage of monetization revenue allocated to the UGC creator under the platforms creator economy program. Applicable only when is_monetization_eligible is true. Confidential commercial term.',
    `download_count` BIGINT COMMENT 'Cumulative number of times this UGC submission has been downloaded by players. Key community engagement metric used to rank popular content, inform creator reward programs, and drive workshop recommendation algorithms.',
    `external_submission_code` STRING COMMENT 'Externally visible alphanumeric identifier for the UGC submission, used in platform workshop URLs, community portal deep links, and Steamworks/Epic Games Store SDK references. Serves as the BUSINESS_IDENTIFIER for this MASTER_RESOURCE.. Valid values are `^[A-Z0-9_-]{6,32}$`',
    `favorite_count` STRING COMMENT 'Number of players who have added this UGC submission to their favorites or wishlist. Indicates sustained player interest beyond initial download and is used for community engagement analytics and recommendation ranking.',
    `file_size_bytes` BIGINT COMMENT 'Total file size of the UGC asset package in bytes. Used for CDN storage capacity planning, download time estimation, platform certification size limit checks, and player-facing display. Serves as the principal MEASUREMENT_OR_VALUE for this MASTER_RESOURCE.',
    `game_engine_version` STRING COMMENT 'Version of the game engine (Unity or Unreal Engine) used to create or required to run this UGC submission. Critical for compatibility validation during the asset pipeline ingestion and platform certification process.',
    `ip_clearance_status` STRING COMMENT 'Status of intellectual property rights clearance review for this UGC submission. Ensures the content does not infringe on third-party IP, trademarks, or copyrights before approval and distribution.. Valid values are `cleared|pending|disputed|rejected`',
    `is_age_restricted` BOOLEAN COMMENT 'Indicates whether this UGC submission requires age verification before access, based on content rating classification. Enforces COPPA compliance for underage players and platform age-gating requirements.',
    `is_cross_platform_compatible` BOOLEAN COMMENT 'Indicates whether this UGC submission is certified as compatible across multiple gaming platforms (PC, console, mobile). Drives cross-platform distribution eligibility and platform certification routing.',
    `is_featured` BOOLEAN COMMENT 'Indicates whether this UGC submission has been editorially selected as featured content by the community management team. Featured content receives prominent placement in workshop listings and community portals.',
    `is_monetization_eligible` BOOLEAN COMMENT 'Indicates whether this UGC submission is eligible for in-game monetization programs (e.g., creator marketplace, revenue share, MTX integration). Determined by content type, approval status, and creator agreement acceptance.',
    `language_code` STRING COMMENT 'ISO 639-1 language code (optionally with ISO 3166-1 region subtag) indicating the primary language of the UGC submissions text content (e.g., en, fr, de, ja). Used for localization filtering and regional content compliance.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the UGC submission record, including creator-initiated version updates, moderation status changes, or metadata edits. Supports audit trail and change detection in the Silver layer.',
    `license_type` STRING COMMENT 'Licensing terms under which the UGC submission is distributed. Governs redistribution rights, modification permissions, and commercial use eligibility for the creators content.. Valid values are `all_rights_reserved|creative_commons|platform_exclusive|open_source`',
    `moderation_flag` STRING COMMENT 'Current moderation classification flag assigned by automated or manual review processes. Drives escalation workflows, content removal actions, and compliance reporting. [ENUM-REF-CANDIDATE: clean|flagged_violence|flagged_adult|flagged_ip_violation|flagged_spam|under_review — promote to reference product]. Valid values are `clean|flagged_violence|flagged_adult|flagged_ip_violation|flagged_spam|under_review`',
    `nps_score` STRING COMMENT 'Net Promoter Score collected from players who interacted with this UGC submission, on a scale of -100 to 100. Measures player satisfaction and likelihood to recommend the content. Feeds community health KPI dashboards in Tableau/Looker.',
    `platform_target` STRING COMMENT 'The gaming platform(s) for which this UGC submission is designed and compatible. Drives platform-specific certification checks, distribution routing, and compatibility filtering in workshop listings.. Valid values are `PC|console|mobile|cross_platform`',
    `preview_image_url` STRING COMMENT 'Secure HTTPS URL for the thumbnail or preview image of the UGC submission displayed in community portals, workshop listings, and in-game browsing interfaces. Supports player discovery and click-through engagement.. Valid values are `^https://.*`',
    `price_virtual_currency` DECIMAL(18,2) COMMENT 'Price of the UGC submission in the games virtual currency units (e.g., coins, gems, credits) if sold through the in-game marketplace. Zero or null indicates free content. Supports in-game monetization (MTX/IAP) analytics.',
    `published_date` DATE COMMENT 'Calendar date when the UGC submission was first made publicly available to the player community. Used for date-based reporting, anniversary promotions, and community content calendars.',
    `rating_count` STRING COMMENT 'Total number of individual player ratings submitted for this UGC asset. Used alongside rating_score to assess statistical confidence of the aggregate rating and prevent manipulation by low-volume outliers.',
    `rating_score` DECIMAL(18,2) COMMENT 'Aggregate community rating score for the UGC submission, typically on a 0.00–5.00 scale. Computed from player ratings and used for workshop ranking, featured content selection, and creator reputation scoring.',
    `removal_reason` STRING COMMENT 'Reason code for the removal of the UGC submission from public availability. Required for compliance reporting under the Digital Services Act and internal moderation audit trails. Null if not removed.. Valid values are `creator_request|policy_violation|ip_infringement|spam|platform_decision|other`',
    `removed_timestamp` TIMESTAMP COMMENT 'Timestamp when the UGC submission was removed from public availability, either by the creator, platform moderation, or automated policy enforcement. Null if the submission has not been removed. Supports compliance audit trails.',
    `report_count` STRING COMMENT 'Cumulative number of player-submitted reports flagging this UGC submission for policy violations (e.g., inappropriate content, IP infringement, spam). Triggers automated moderation escalation thresholds.',
    `requires_base_game_dlc` BOOLEAN COMMENT 'Indicates whether this UGC submission requires the player to own a specific Downloadable Content (DLC) pack in addition to the base game in order to use the content. Used for entitlement validation and player-facing compatibility warnings.',
    `reviewer_notes` STRING COMMENT 'Free-text notes entered by the content moderation reviewer during the approval or rejection process. Documents the rationale for moderation decisions and supports appeals handling and compliance audits.',
    `source_platform` STRING COMMENT 'The distribution platform through which this UGC submission was originally uploaded. Used for platform-specific compliance checks, certification routing, and cross-platform availability management. [ENUM-REF-CANDIDATE: steam|epic_games|playstation|xbox|nintendo|mobile_ios|mobile_android|web — promote to reference product]',
    `submission_status` STRING COMMENT 'Current lifecycle state of the UGC submission within the moderation and publishing workflow. Controls visibility, download availability, and monetization eligibility. Serves as the LIFECYCLE_STATUS for this MASTER_RESOURCE. [ENUM-REF-CANDIDATE: draft|pending_review|approved|rejected|removed|archived — promote to reference product]. Valid values are `draft|pending_review|approved|rejected|removed|archived`',
    `submission_timestamp` TIMESTAMP COMMENT 'Timestamp when the UGC submission was first submitted by the creator for review. Represents the principal business event time for this entity. Used for SLA tracking of moderation turnaround and community activity trend analysis.',
    `tags` STRING COMMENT 'Comma-separated list of community-defined tags applied to the UGC submission for discoverability and categorization (e.g., horror,multiplayer,competitive). Used for search indexing and recommendation engine inputs.',
    `title` STRING COMMENT 'Human-readable title of the UGC submission as provided by the creator. Used for display in community portals, workshop listings, and search indexing. Serves as the primary IDENTITY_LABEL for this MASTER_RESOURCE.',
    `ugc_submission_description` STRING COMMENT 'Full text description of the UGC submission as authored by the creator. Describes the content, features, installation instructions, and intended use. Used for community discovery, search indexing, and moderation review.',
    `ugc_type` STRING COMMENT 'Category of UGC asset submitted by the player. Drives content moderation workflows, monetization eligibility rules, and community portal routing. [ENUM-REF-CANDIDATE: map|mod|skin|game_mode|guide|fan_art|other — promote to reference product]',
    `version_number` STRING COMMENT 'Semantic version number of the UGC submission (e.g., 1.0, 2.3.1). Tracks iterative updates by the creator and enables compatibility checks with game engine versions. Aligns with Perforce Helix Core versioning conventions.. Valid values are `^d+.d+(.d+)?$`',
    CONSTRAINT pk_ugc_submission PRIMARY KEY(`ugc_submission_id`)
) COMMENT 'Master entity for User-Generated Content (UGC) submissions including player-created maps, mods, skins, game modes, guides, and fan art. Tracks UGC type, title, description, associated game title, creator player reference, file size, asset URL, version number, download count, rating score, approval status, content rating classification, monetization eligibility flag, and submission/approval timestamps. SSOT for all UGC assets in the community domain.';

CREATE OR REPLACE TABLE `gaming_ecm`.`community`.`ugc_review` (
    `ugc_review_id` BIGINT COMMENT 'Unique surrogate identifier for each UGC review record in the Gaming platform. Primary key for the ugc_review data product.',
    `backlog_item_id` BIGINT COMMENT 'Foreign key linking to studio.backlog_item. Business justification: UGC quality assurance: reviews reporting technical issues (crashes, compatibility problems) generate backlog items for engine or tooling fixes. Essential for maintaining UGC platform stability.',
    `employee_id` BIGINT COMMENT 'Reference to the staff member or automated moderation system that performed the most recent moderation action on this review. Supports accountability and audit trail requirements.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title context in which the UGC content and review exist. Enables game-level aggregation of community quality signals.',
    `player_account_id` BIGINT COMMENT 'Reference to the player who authored this UGC review. Links to the player master record for reviewer identity and profile context.',
    `storefront_listing_id` BIGINT COMMENT 'Foreign key linking to platform.storefront_listing. Business justification: Player reviews of UGC content are displayed on storefront listings. Content moderation, rating aggregation, and ASO optimization require linking reviews to specific listings. Core storefront content m',
    `support_ticket_id` BIGINT COMMENT 'Reference to the Zendesk player support ticket associated with this review, if a support case was opened in relation to a review dispute, moderation appeal, or content complaint. Enables cross-system traceability between community and player support operations.',
    `ugc_submission_id` BIGINT COMMENT 'Reference to the UGC submission being reviewed. Links to the ugc_submission master record for the content item under evaluation.',
    `content_rating_compliance_flag` BOOLEAN COMMENT 'Indicates whether this review has been assessed and confirmed compliant with applicable content rating standards (ESRB, PEGI, USK, CERO, GRAC) for the target audience of the associated game title.',
    `coppa_restricted` BOOLEAN COMMENT 'Indicates whether this review is subject to COPPA restrictions because the reviewer is identified as a child under 13. COPPA-restricted reviews require parental consent verification before public display.',
    `created_timestamp` TIMESTAMP COMMENT 'Audit timestamp recording when this review record was first persisted in the data platform. Distinct from submitted_timestamp which reflects the player-facing event time.',
    `deleted_timestamp` TIMESTAMP COMMENT 'Date and time when this review was soft-deleted. Null if the review has not been deleted. Supports GDPR erasure request audit trails and data retention compliance.',
    `deletion_reason` STRING COMMENT 'Reason code for the soft deletion of this review. Supports compliance audit trails for GDPR erasure requests, moderation enforcement, and account ban processing.. Valid values are `player_request|gdpr_erasure|moderation_removal|account_banned|content_violation`',
    `gdpr_consent_flag` BOOLEAN COMMENT 'Indicates whether the reviewer has provided valid GDPR consent for their review content and associated personal data to be processed and publicly displayed. Required for EU-resident reviewers.',
    `helpful_vote_count` STRING COMMENT 'Number of community players who have marked this review as helpful. Core community engagement signal used in UGC discovery ranking and review surfacing algorithms.',
    `is_deleted` BOOLEAN COMMENT 'Soft-delete flag indicating whether this review has been logically deleted from the platform (e.g., by player request under GDPR Right to Erasure or by moderation removal). Deleted reviews are retained for audit but excluded from community display.',
    `is_edited` BOOLEAN COMMENT 'Indicates whether the player has edited the review text after initial submission. Edited reviews may require re-moderation per community policy.',
    `is_featured` BOOLEAN COMMENT 'Indicates whether this review has been editorially selected or algorithmically promoted as a featured review on the UGC content page. Featured reviews receive elevated visibility in community discovery.',
    `is_spoiler` BOOLEAN COMMENT 'Indicates whether the reviewer or moderation team has flagged this review as containing spoilers for the UGC content or associated game. Triggers spoiler-blur UI treatment in community displays.',
    `is_verified_download` BOOLEAN COMMENT 'Indicates whether the reviewing player has a verified download or install of the UGC content on record. Verified reviews carry higher trust weight in community ranking algorithms.',
    `is_verified_playtime` BOOLEAN COMMENT 'Indicates whether the reviewing player has logged a minimum verified playtime threshold for the UGC content before submitting the review. Reduces low-effort or fraudulent reviews.',
    `last_edited_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent player-initiated edit to the review content. Null if the review has never been edited. Distinct from updated_timestamp which captures any record change.',
    `moderation_action_type` STRING COMMENT 'The most recent moderation action applied to this review by the community moderation team. Tracks enforcement history for compliance and appeals processes.. Valid values are `none|warned|edited|hidden|removed|escalated`',
    `moderation_reason_code` STRING COMMENT 'Standardized code identifying the reason for the moderation action applied to this review (e.g., SPAM, HATE_SPEECH, SPOILER, OFF_TOPIC, FAKE_REVIEW). [ENUM-REF-CANDIDATE: SPAM|HATE_SPEECH|SPOILER|OFF_TOPIC|FAKE_REVIEW|HARASSMENT|ADULT_CONTENT — promote to reference product]',
    `moderation_status` STRING COMMENT 'Current moderation lifecycle state of the review. Controls visibility and community surfacing. [ENUM-REF-CANDIDATE: pending|approved|rejected|escalated|removed|under_review — promote to reference product if additional states are needed]. Valid values are `pending|approved|rejected|escalated|removed|under_review`',
    `moderation_timestamp` TIMESTAMP COMMENT 'Date and time when the most recent moderation action was applied to this review. Supports SLA tracking for moderation response times and compliance audit trails.',
    `not_helpful_vote_count` STRING COMMENT 'Number of community players who have marked this review as not helpful. Used alongside helpful_vote_count to compute net helpfulness score for review ranking.',
    `platform_code` STRING COMMENT 'The gaming platform on which the reviewer played and experienced the UGC content. Enables platform-segmented quality analysis. [ENUM-REF-CANDIDATE: PC|PS5|PS4|XBOX_SERIES|XBOX_ONE|SWITCH|MOBILE_IOS|MOBILE_ANDROID — promote to reference product]',
    `playtime_at_review_minutes` STRING COMMENT 'Total minutes of playtime the reviewer had accumulated on the UGC content at the time of review submission. Used to assess review credibility and weight in ranking models.',
    `report_count` STRING COMMENT 'Number of times this review has been reported by community players for policy violations (e.g., hate speech, spam, spoilers). Triggers moderation escalation thresholds.',
    `review_body` STRING COMMENT 'Full free-text review content authored by the player describing their experience with the UGC submission. Subject to moderation and community guidelines.',
    `review_language_code` STRING COMMENT 'ISO 639-1 language code (optionally with ISO 3166-1 region subtag) of the review text (e.g., en, en-US, fr, de). Supports localized moderation workflows and multilingual community analytics.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `review_number` STRING COMMENT 'Externally visible, human-readable business identifier for this review (e.g., REV-0000123456). Used in player support, moderation workflows, and community reporting.. Valid values are `^REV-[0-9]{10}$`',
    `review_source_channel` STRING COMMENT 'The platform channel through which the player submitted this review (e.g., in-game overlay, web community portal, mobile app, Steam Workshop, Epic Games Store, console marketplace). Supports channel-level community analytics.. Valid values are `in_game|web_portal|mobile_app|steam|epic_store|console_store`',
    `review_title` STRING COMMENT 'Short headline or title of the review as entered by the player. Displayed in community listings and UGC detail pages.',
    `review_type` STRING COMMENT 'Classification of the review format submitted by the player. Distinguishes between written text reviews, video reviews, screenshot-based reviews, and quick star-only ratings without text.. Valid values are `written|video|screenshot|quick_rating`',
    `reviewer_account_age_days` STRING COMMENT 'Age of the reviewers player account in days at the time of review submission. Used in anti-fraud and fake review detection models; new accounts with reviews may be flagged for additional scrutiny.',
    `reviewer_total_reviews` STRING COMMENT 'Total number of UGC reviews the reviewer had submitted on the platform at the time this review was created. Contextualizes reviewer credibility and activity level for ranking models.',
    `sentiment_label` STRING COMMENT 'Categorical sentiment classification derived from the sentiment_score. Used for community health dashboards, NPS/CSAT correlation analysis, and UGC quality reporting.. Valid values are `positive|neutral|negative|mixed`',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Normalized sentiment analysis score for the review body text, ranging from -1.0 (most negative) to 1.0 (most positive). Computed by the NLP pipeline and stored for analytics and community health monitoring.',
    `star_rating` BOOLEAN COMMENT 'Numeric star rating assigned by the reviewer to the UGC content, on a 1–5 scale (1 = lowest quality, 5 = highest quality). Core community quality signal used for UGC discovery and ranking algorithms.',
    `submitted_timestamp` TIMESTAMP COMMENT 'The exact date and time (ISO 8601 with timezone offset) when the player submitted this review. Principal business event timestamp for the review lifecycle.',
    `total_vote_count` STRING COMMENT 'Total number of community votes (helpful + not helpful) received by this review. Indicates review engagement volume and statistical significance of helpfulness signals.',
    `updated_timestamp` TIMESTAMP COMMENT 'Audit timestamp recording when this review record was most recently modified, including moderation actions, edits, or status changes.',
    CONSTRAINT pk_ugc_review PRIMARY KEY(`ugc_review_id`)
) COMMENT 'Transactional record of player reviews and ratings submitted for UGC content. Captures reviewer player reference, UGC submission reference, star rating, review text, helpful vote count, verified download flag, moderation status, and review timestamp. Enables community-driven quality signals for UGC discovery and ranking.';

CREATE OR REPLACE TABLE `gaming_ecm`.`community`.`guild` (
    `guild_id` BIGINT COMMENT 'Unique surrogate identifier for the guild or clan social group. Primary key for the guild master entity in the community domain.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title with which this guild is associated. Guilds are scoped to a specific game title.',
    `player_account_id` BIGINT COMMENT 'Reference to the player who originally created and founded this guild.',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to billing.subscription. Business justification: Guild premium features (expanded rosters, custom emblems, private servers) are monetized via guild-level subscriptions in MMOs, requiring direct linkage for billing, feature entitlement, and guild rev',
    `age_restricted` BOOLEAN COMMENT 'Indicates whether this guild enforces an age restriction on membership, requiring members to be 18+ or meet a minimum age threshold. Supports COPPA and GDPR compliance for minor protection.',
    `banner_asset_ref` STRING COMMENT 'Reference path or URI to the guilds banner or header image asset stored in the digital asset management system. Displayed on the guilds community profile page.',
    `content_rating` STRING COMMENT 'Content maturity rating applicable to this guilds activities and communications, aligned with ESRB rating categories. Used to enforce age-appropriate community access controls.. Valid values are `E|E10+|T|M|AO|RP`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when the guild record was first created in the data platform. Supports audit trail and data lineage requirements.',
    `disbanded_date` DATE COMMENT 'Date on which the guild was officially disbanded or dissolved. Null for active guilds. Used for historical reporting and community lifecycle analytics.',
    `discord_server_code` STRING COMMENT 'External Discord server identifier linked to this guilds community communication channel. Used for cross-platform community integration and player support routing.. Valid values are `^[0-9]{17,20}$`',
    `emblem_asset_ref` STRING COMMENT 'Reference path or URI to the guilds emblem or badge image asset stored in the digital asset management system (Perforce Helix Core / CDN). Used for rendering the guild icon in-game and on community portals.',
    `external_website_url` STRING COMMENT 'URL of the guilds external website or community page, if maintained outside the game platform. Used for community discovery and marketing.',
    `founded_date` DATE COMMENT 'Calendar date on which the guild was officially created and founded by the founding player. Used for guild anniversary tracking and tenure-based analytics.',
    `guild_description` STRING COMMENT 'Free-text description of the guild written by the guild leader, outlining the guilds goals, rules, play style, and membership expectations. Displayed on the guild profile page.',
    `guild_name` STRING COMMENT 'The full display name of the guild or clan as chosen by the founder and visible to all players in-game and on community platforms.',
    `guild_status` STRING COMMENT 'Current lifecycle status of the guild. Active guilds are operational; disbanded guilds have been dissolved; suspended guilds are under moderation review; pending guilds are awaiting approval.. Valid values are `active|inactive|disbanded|suspended|pending`',
    `guild_type` STRING COMMENT 'Categorical classification of the guilds primary play style and purpose. [ENUM-REF-CANDIDATE: casual|competitive|roleplay|social|esports|pve — promote to reference product if additional types are needed]. Valid values are `casual|competitive|roleplay|social|esports|pve`',
    `is_esports_org` BOOLEAN COMMENT 'Indicates whether this guild is formally affiliated with or operates as an esports organization participating in sanctioned leagues or tournaments.',
    `is_verified` BOOLEAN COMMENT 'Indicates whether the guild has been officially verified by the platform or community team, typically for esports organizations or notable community groups. Verified guilds may receive special badges and visibility.',
    `language_code` STRING COMMENT 'Primary language spoken within the guild, expressed as an IETF BCP 47 language tag (e.g., en, fr, de, zh-CN). Used for community matching and localization.. Valid values are `^[a-z]{2,3}(-[A-Z]{2})?$`',
    `last_activity_date` DATE COMMENT 'Date of the most recent recorded activity within the guild (e.g., member login, guild event, chat message). Used to identify inactive or dormant guilds for lifecycle management.',
    `member_capacity` STRING COMMENT 'Maximum number of players allowed to be members of this guild simultaneously, as configured by the guild leader or constrained by game design rules.',
    `member_count` STRING COMMENT 'Current number of active members in the guild at the time of the last record update. Used for capacity management and community health reporting.',
    `min_player_level` STRING COMMENT 'Minimum in-game player level required to apply for or join this guild. Used to enforce skill and progression gates for guild membership.',
    `moderation_flag` BOOLEAN COMMENT 'Indicates whether this guild is currently flagged for active moderation review due to reported violations of community guidelines, toxic behavior, or policy breaches.',
    `moderation_reason` STRING COMMENT 'Categorical reason for the current moderation flag on the guild. Populated when moderation_flag is true. [ENUM-REF-CANDIDATE: harassment|hate_speech|cheating|spam|inappropriate_content|other — promote to reference product]. Valid values are `harassment|hate_speech|cheating|spam|inappropriate_content|other`',
    `nps_score` DECIMAL(18,2) COMMENT 'Net Promoter Score (NPS) aggregated from member satisfaction surveys for this guild, ranging from -100 to 100. Used to measure community health and member loyalty within the guild.',
    `platform` STRING COMMENT 'Primary gaming platform on which the guild operates. Cross-platform guilds span multiple platforms. Used for platform-specific community analytics and matchmaking.. Valid values are `PC|PlayStation|Xbox|Nintendo|Mobile|CrossPlatform`',
    `prestige_level` STRING COMMENT 'Current prestige or rank level of the guild derived from accumulated XP and achievements. Determines access to exclusive guild perks, rewards, and in-game content.',
    `privacy_level` STRING COMMENT 'Visibility setting for the guild profile. Public guilds are discoverable by all players; private guilds are hidden from search; unlisted guilds are accessible only via direct link.. Valid values are `public|private|unlisted`',
    `pve_focus` BOOLEAN COMMENT 'Indicates whether the guilds primary activity focus is Player versus Environment (PvE) content such as raids, dungeons, and cooperative missions.',
    `pvp_focus` BOOLEAN COMMENT 'Indicates whether the guilds primary activity focus is Player versus Player (PvP) content, as opposed to Player versus Environment (PvE) or social/roleplay activities.',
    `recruitment_status` STRING COMMENT 'Current recruitment posture of the guild indicating whether new members may join freely (open), by invitation only (invite_only), via application (application), or not at all (closed).. Valid values are `open|invite_only|closed|application`',
    `region` STRING COMMENT 'Geographic region the guild primarily operates in, used for matchmaking, server routing, and community segmentation (e.g., NA = North America, EU = Europe, APAC = Asia-Pacific).. Valid values are `NA|EU|APAC|LATAM|MEA|OCE`',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this guild record originated (e.g., GameAnalytics, Amplitude, Salesforce CRM, or a custom in-house platform). Supports data lineage and reconciliation.. Valid values are `GameAnalytics|Amplitude|Salesforce|Custom`',
    `tag` STRING COMMENT 'Short alphanumeric abbreviation or clan tag (2–6 characters) displayed alongside player names in-game to identify guild membership (e.g., [APEX]).. Valid values are `^[A-Z0-9]{2,6}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp recording when the guild record was most recently modified in the data platform. Supports change tracking, audit trail, and incremental ETL processing.',
    `weekly_active_members` STRING COMMENT 'Count of guild members who were active in-game during the most recent 7-day period. Key community health metric analogous to Weekly Active Users (WAU) at the guild level.',
    `xp_total` BIGINT COMMENT 'Cumulative experience points (XP) earned by the guild through collective member activity, guild quests, and in-game events. Drives guild level progression and prestige rankings.',
    CONSTRAINT pk_guild PRIMARY KEY(`guild_id`)
) COMMENT 'Master entity representing player guilds, clans, and social groups within games. Tracks guild name, tag/abbreviation, associated game title, founding player reference, member capacity, current member count, guild type (casual/competitive/roleplay), recruitment status (open/invite-only/closed), region, language, description, emblem/badge asset reference, total XP/prestige points, and active status. SSOT for all guild and clan social structures.';

CREATE OR REPLACE TABLE `gaming_ecm`.`community`.`guild_membership` (
    `guild_membership_id` BIGINT COMMENT 'Unique surrogate identifier for each guild membership record. Serves as the primary key for the guild_membership association entity, tracking the full lifecycle of a players participation within a guild or clan.',
    `game_title_id` BIGINT COMMENT 'Reference to the specific game title within which this guild membership exists. Guilds are scoped to individual game titles; this field enables cross-title community analytics and ensures membership records are correctly partitioned by game.',
    `guild_id` BIGINT COMMENT 'Reference to the guild or clan that the player belongs to. Represents the guild-side of the M:N relationship between players and guilds.',
    `player_account_id` BIGINT COMMENT 'Reference to the player who holds this guild membership. Represents the player-side of the M:N relationship between players and guilds.',
    `activity_status` STRING COMMENT 'Derived classification of the members recent engagement level within the guild context, based on login frequency and guild-specific interactions. Distinct from membership_status; used by guild leaders and community managers to identify at-risk members for retention outreach.. Valid values are `highly_active|active|low_activity|dormant`',
    `consent_timestamp` TIMESTAMP COMMENT 'The precise date and time at which the player granted data processing consent for guild membership data. Required for GDPR audit trails. Null if consent has not been obtained or is not applicable.',
    `contribution_score` STRING COMMENT 'Numeric score representing the players cumulative contributions to the guild, such as donated resources, completed guild quests, or participation in guild events. Used by guild leaders to assess member value and inform promotion or removal decisions.',
    `csat_score` STRING COMMENT 'The most recent Customer Satisfaction Score (CSAT) rating provided by this player regarding their guild experience, typically on a 1–5 scale. Complements NPS for community health measurement and player care operations.',
    `current_role_since_date` DATE COMMENT 'The date on which the player was assigned their current membership_role. Enables tenure-in-role calculations and supports promotion eligibility logic distinct from overall guild tenure.',
    `data_processing_consent` BOOLEAN COMMENT 'Indicates whether the player has provided explicit consent for processing of their guild membership and community interaction data. Required for GDPR compliance for players in EU jurisdictions. True when valid consent is on record.',
    `departure_date` DATE COMMENT 'The calendar date on which the player left or was removed from the guild. Null when the membership is still active. Used for churn analysis and guild stability reporting.',
    `departure_reason` STRING COMMENT 'Categorical reason explaining why the players membership ended. Supports community health analysis and guild churn root-cause reporting. Null when membership is still active.. Valid values are `voluntary_leave|kicked|guild_disbanded|inactivity_removal|account_banned|transferred`',
    `guild_chat_messages_sent` STRING COMMENT 'Cumulative count of messages sent by the player in the guild chat channel since joining. A key social engagement indicator used by community managers to assess member communication activity and guild cohesion.',
    `guild_events_participated` STRING COMMENT 'Cumulative count of guild-organized events (raids, tournaments, guild quests, PvP battles) in which the player has participated since joining. Used to measure event engagement and identify high-value community contributors.',
    `has_promotion_history` BOOLEAN COMMENT 'Indicates whether the player has ever been promoted to a higher role within this guild. True when at least one role promotion event exists in the membership history. Used as a quick filter for identifying experienced, trusted members.',
    `invite_source` STRING COMMENT 'The channel or mechanism through which the player was recruited into the guild. Supports K-Factor viral coefficient analysis and community growth attribution. Examples include direct officer invite, public recruitment post, player referral, automated matchmaking, social platform import, or in-game guild search.. Valid values are `direct_invite|recruitment_post|referral|auto_match|social_import|in_game_search`',
    `is_age_verified` BOOLEAN COMMENT 'Indicates whether the players age has been verified as meeting the minimum age requirement for guild participation, particularly relevant for guilds with mature content ratings. Supports COPPA compliance for guilds accessible to younger audiences.',
    `is_founder` BOOLEAN COMMENT 'Indicates whether this player was one of the founding members who created the guild. Founders may retain special privileges or recognition even if their current role has changed. Used for community heritage and loyalty analytics.',
    `is_muted` BOOLEAN COMMENT 'Indicates whether the players guild chat privileges have been temporarily muted by a guild officer or leader. True when the player is currently restricted from sending messages in guild channels. Used for community moderation tracking.',
    `join_date` DATE COMMENT 'The calendar date on which the player officially joined the guild. Used for tenure calculations, retention analysis, and D1/D7/D30 guild engagement cohort reporting.',
    `join_timestamp` TIMESTAMP COMMENT 'Precise date and time at which the players guild membership was activated. Provides sub-day precision for event sequencing, funnel analysis, and audit trails beyond what join_date alone provides.',
    `last_active_date` DATE COMMENT 'The most recent calendar date on which the player performed any guild-related activity. Used to identify dormant members, trigger re-engagement campaigns, and support inactivity-based removal workflows.',
    `membership_role` STRING COMMENT 'The functional role held by the player within the guild hierarchy. Determines permissions, responsibilities, and visibility within guild operations. Common roles include leader (guild owner), officer (elevated permissions), veteran (trusted long-term member), member (standard participant), and recruit (probationary new member).. Valid values are `leader|officer|member|recruit|veteran`',
    `membership_status` STRING COMMENT 'Current lifecycle state of the players guild membership. Active indicates full participation; inactive indicates the player has not engaged recently; suspended indicates a temporary restriction imposed by guild leadership; departed indicates the player has left or been removed; pending indicates an invitation or application awaiting acceptance.. Valid values are `active|inactive|suspended|departed|pending`',
    `membership_tier` STRING COMMENT 'Prestige or progression tier assigned to the players membership within the guild, reflecting cumulative achievement and standing. Used for tiered reward distribution, exclusive content access, and community recognition programs.. Valid values are `bronze|silver|gold|platinum|elite`',
    `mute_expiry_date` DATE COMMENT 'The date on which a temporary guild chat mute restriction is scheduled to expire. Null when is_muted is false or when the mute is permanent pending manual review. Used by community moderation workflows.',
    `notes` STRING COMMENT 'Free-text field for guild officers or community managers to record contextual notes about the membership, such as reasons for role changes, special circumstances, or moderation observations. Not displayed to the member.',
    `nps_score` STRING COMMENT 'The most recent Net Promoter Score (NPS) survey response submitted by this player in the context of their guild experience, on a scale of 0–10. Used to measure guild satisfaction and community health. Null if no NPS survey has been completed.',
    `platform_code` STRING COMMENT 'The gaming platform on which the player primarily participates in guild activities. Used for cross-platform guild analytics and to understand platform-specific community engagement patterns. [ENUM-REF-CANDIDATE: PC|PS5|PS4|XBOX|SWITCH|MOBILE|STADIA — promote to reference product if platform list grows]',
    `previous_role` STRING COMMENT 'The membership role held by the player immediately before their current role assignment. Provides a single-step promotion/demotion audit trail without requiring a full history table query for the most recent transition.. Valid values are `leader|officer|member|recruit|veteran`',
    `pvp_wins_for_guild` STRING COMMENT 'Cumulative count of PvP (Player versus Player) match victories the player has contributed to guild-ranked competitions since joining. Used to assess competitive contribution and inform officer promotion decisions.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp at which this guild membership record was first created in the data platform. Serves as the audit creation timestamp for data lineage and Silver Layer ingestion tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp at which this guild membership record was most recently modified in the data platform. Used for incremental ETL processing, change data capture, and audit trail maintenance in the Databricks Silver Layer.',
    `referrals_made` STRING COMMENT 'Count of other players this member has successfully referred or invited into the guild. Supports K-Factor (viral coefficient) analysis at the guild level and identifies high-influence community members.',
    `reports_received` STRING COMMENT 'Cumulative count of conduct or content reports filed against this player by other community members during their guild membership. Elevated counts may trigger moderation review or membership suspension.',
    `reports_submitted` STRING COMMENT 'Cumulative count of player-reported content or conduct reports submitted by this member against other guild members or community participants. Used by community moderation teams to assess reporting behavior and identify potential abuse patterns.',
    `resources_donated` STRING COMMENT 'Cumulative count of in-game resource units donated by the player to the guild treasury or shared pool since joining. Contributes to contribution_score and is used to evaluate member generosity and guild economy participation.',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this guild membership record originated or was last updated. Supports data lineage tracking in the Databricks Silver Layer and ETL audit processes.. Valid values are `GAMEANALYTICS|AMPLITUDE|SALESFORCE|ZENDESK|INTERNAL`',
    `support_tickets_raised` STRING COMMENT 'Count of Zendesk support tickets raised by this player that are related to guild or community issues (e.g., harassment reports, guild dispute escalations) during their membership tenure. Used by player support teams to identify high-friction community interactions.',
    `total_guild_sessions` STRING COMMENT 'Cumulative count of play sessions during which the player engaged in at least one guild-specific activity since joining. Supports session length and engagement depth analysis for community health reporting.',
    `weekly_active_days` STRING COMMENT 'Number of distinct days in the most recently completed calendar week on which the player was active within the guild context (e.g., participated in guild chat, guild quests, or guild events). Serves as a WAU (Weekly Active Users) proxy at the membership level for community health dashboards.',
    CONSTRAINT pk_guild_membership PRIMARY KEY(`guild_membership_id`)
) COMMENT 'Association entity tracking player membership within guilds and clans. Records player reference, guild reference, membership role (leader/officer/member/recruit), join date, promotion history flag, contribution score, activity status, invite source, and departure date/reason when applicable. Manages the M:N relationship between players and guilds with full lifecycle data.';

CREATE OR REPLACE TABLE `gaming_ecm`.`community`.`support_ticket` (
    `support_ticket_id` BIGINT COMMENT 'Unique surrogate identifier for each support ticket record in the Gaming lakehouse Silver layer. Primary key for this entity. Entity role: TRANSACTION_HEADER — represents a discrete player support interaction with a full lifecycle (open → in-progress → resolved → closed).',
    `battle_pass_entitlement_id` BIGINT COMMENT 'Foreign key linking to monetization.battle_pass_entitlement. Business justification: Battle pass issues (progression bugs, missing rewards, purchase problems) are common support category. Tickets require entitlement state verification to diagnose tier unlock issues, XP discrepancies, ',
    `compatibility_profile_id` BIGINT COMMENT 'Foreign key linking to platform.compatibility_profile. Business justification: Compatibility issues (crashes, performance, hardware requirements) are resolved by referencing compatibility profiles. Support agents need profile data for troubleshooting and escalation to platform c',
    `compliance_event_id` BIGINT COMMENT 'Foreign key linking to platform.compliance_event. Business justification: Platform compliance violations (TRC/TCR breaches, content policy violations) generate support escalations. Legal and compliance teams track remediation via support tickets. Required for audit trails a',
    `compliance_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Support tickets revealing GDPR data breaches, COPPA violations, or age gate bypasses become formal compliance incidents requiring investigation, notification, and remediation. Tracks incident discover',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Customer support escalation workflow tags tickets with content_drop_id for engineering triage and rollback decisions. Critical for identifying patch-specific issues and measuring release quality via s',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Support operations are cost centers in gaming companies. Tracking which cost center handles each ticket enables accurate operational expense allocation, headcount planning, and support cost analysis b',
    `defect_id` BIGINT COMMENT 'Foreign key linking to quality.defect. Business justification: Support tickets reporting bugs must link to defect records for resolution tracking and customer communication. Essential for support-to-engineering workflow where tickets are escalated to QA, defects ',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: Support-to-engineering escalation workflow: critical player-reported bugs are routed to specific dev projects for triage and fix assignment. Essential for bug tracking and release readiness.',
    `dlc_entitlement_id` BIGINT COMMENT 'Foreign key linking to monetization.dlc_entitlement. Business justification: DLC access issues (download failures, license verification problems, missing content) are common support requests. Tickets require entitlement verification to diagnose platform sync issues, re-grant l',
    `drm_entitlement_id` BIGINT COMMENT 'Foreign key linking to platform.drm_entitlement. Business justification: Entitlement issues (license not found, region lock, revocation) are top support drivers. Agents need direct access to entitlement records for troubleshooting, refunds, and manual grants. Core support ',
    `employee_id` BIGINT COMMENT 'Reference to the support agent currently assigned to this ticket. Used for workload balancing, agent performance reporting, and CSAT attribution. Nullable when ticket is unassigned or in queue.',
    `game_title_id` BIGINT COMMENT 'Reference to the specific game title associated with this support ticket. Enables per-title support volume analysis, issue trending by SKU, and DLC/patch correlation with ticket spikes.',
    `iap_transaction_id` BIGINT COMMENT 'Foreign key linking to monetization.iap_transaction. Business justification: Support tickets for purchase issues (refunds, missing entitlements, payment failures) require transaction context for resolution. High-volume support category in gaming - agents need transaction detai',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Billing dispute tickets require direct invoice reference for charge verification, dispute resolution, refund processing, and customer service audit trails per payment dispute handling procedures and r',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Support tickets escalating licensing disputes (middleware errors, music sync issues, brand usage violations) must reference governing IP agreement for resolution workflow, SLA tracking, and legal esca',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Multi-entity publishers must track which legal entity is responsible for each support ticket for GDPR compliance, data residency requirements, consumer protection law jurisdiction, and liability manag',
    `marketing_campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Support tickets spike during campaign launches and promotional events. Tracking campaign attribution enables quality monitoring, identifies campaign-driven issues (misleading ads, broken promo codes),',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to studio.milestone. Business justification: Release readiness assessment: critical bugs reported near milestones are tracked against those milestones for go/no-go decisions. Required for launch quality gates and certification compliance.',
    `patch_release_id` BIGINT COMMENT 'Foreign key linking to platform.patch_release. Business justification: Patch releases drive support volume spikes (download failures, regression bugs, compatibility issues). Support teams triage tickets by patch version for escalation and rollback decisions. Critical for',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: Payment failure investigations and transaction dispute tickets require direct payment reference for gateway response analysis, fraud investigation, customer verification, and payment retry coordinatio',
    `platform_cert_submission_id` BIGINT COMMENT 'Foreign key linking to platform.cert_submission. Business justification: Certification failures generate developer support escalations. Support teams troubleshoot TRC/TCR violations, waiver requests, and resubmission guidance by linking tickets to specific cert submissions',
    `player_account_id` BIGINT COMMENT 'Reference to the player who submitted this support ticket. Maps to PARTY_REFERENCE category for TRANSACTION_HEADER role. Links to the player master record for identity resolution, LTV context, and churn risk analysis.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Player complaints about loot box odds, underage purchases, or data handling trigger mandatory regulatory filings in many jurisdictions. Links support evidence to formal submissions to rating boards or',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Support-to-QA handoff requires asset_id for bug tracking integration. Content delivery troubleshooting needs asset reference for CDN validation and cache invalidation when players report missing/corru',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to billing.subscription. Business justification: Subscription support tickets (cancellation requests, billing issues, feature access problems) require direct subscription reference for account management, billing adjustments, and subscription lifecy',
    `bot_handled_flag` BOOLEAN COMMENT 'Indicates whether this ticket was fully or partially handled by an automated bot or virtual agent before human agent involvement. Used to measure automation deflection rates and evaluate chatbot effectiveness in reducing agent workload.',
    `channel` STRING COMMENT 'The intake channel through which the player submitted this ticket. Drives channel-specific SLA rules and informs omnichannel support strategy. in_game refers to the embedded support widget within the game client; api refers to programmatic submissions from third-party integrations.. Valid values are `email|chat|in_game|web|api|voice`',
    `closed_at` TIMESTAMP COMMENT 'Timestamp when the ticket was permanently closed by the system (typically 72 hours after solved status). A closed ticket cannot be reopened. Distinct from solved_at — represents the final end-of-lifecycle event.',
    `comment_count` STRING COMMENT 'Total number of comments (public and private) recorded on this ticket across its full conversation history. Indicates ticket complexity and interaction volume. Used for workload estimation and agent productivity analysis.',
    `coppa_minor_flag` BOOLEAN COMMENT 'Indicates whether the player associated with this ticket has been identified as a minor under COPPA (Childrens Online Privacy Protection Act) or equivalent regulations (GDPR Article 8, PEGI age-gating). Triggers enhanced data handling protocols and restricts certain automated responses.',
    `created_at` TIMESTAMP COMMENT 'Timestamp when this support ticket record was first ingested into the Gaming lakehouse Silver layer. Maps to RECORD_AUDIT_CREATED category for TRANSACTION_HEADER role. Distinct from opened_at which reflects the Zendesk event time.',
    `csat_comment` STRING COMMENT 'Free-text feedback provided by the player alongside their CSAT rating. Used for qualitative analysis, NPS correlation, and identifying systemic support issues. Classified confidential as it may contain player sentiment and operational details.',
    `csat_score` STRING COMMENT 'Player-submitted Customer Satisfaction (CSAT) rating for this ticket, typically on a 1–5 scale collected via post-resolution survey. Null if the player did not respond to the survey. Core metric for player care quality and agent performance evaluation.',
    `due_at` TIMESTAMP COMMENT 'The SLA deadline timestamp by which this ticket must be resolved to avoid an SLA breach. Set automatically based on ticket priority and channel SLA policy at time of creation. Used for real-time SLA monitoring and proactive escalation triggers.',
    `escalation_tier` STRING COMMENT 'Numeric tier indicating the escalation level of the ticket. Tier 1 = frontline agent; Tier 2 = senior specialist; Tier 3 = engineering/trust-and-safety; Tier 4 = executive escalation. Increments when a ticket is escalated due to complexity, SLA breach, or player demand.',
    `first_response_at` TIMESTAMP COMMENT 'Timestamp of the first public agent reply on this ticket. Used alongside opened_at to derive first_response_time_seconds and to validate SLA compliance at the event level. Distinct from first_response_time_seconds which is the computed duration.',
    `first_response_time_seconds` STRING COMMENT 'Elapsed time in seconds between ticket creation and the first public agent reply. Core SLA metric for player support operations. Used to calculate SLA compliance rates and benchmark channel performance. Maps to QUANTITATIVE_RESULT for non-monetary transaction.',
    `game_version` STRING COMMENT 'The version string of the game client the player was running when the issue occurred. Used to correlate support spikes with specific build releases, hotfixes, or DLC deployments. Aligns with Perforce Helix Core build labels.. Valid values are `^[0-9]+.[0-9]+.[0-9]+(.[0-9]+)?$`',
    `gdpr_data_request_flag` BOOLEAN COMMENT 'Indicates whether this ticket contains or is associated with a GDPR data subject request (e.g., right of access, right to erasure, right to portability). Triggers mandatory compliance workflows with statutory response deadlines under GDPR Article 12.',
    `group_name` STRING COMMENT 'Name of the Zendesk agent group or support team to which this ticket is assigned. Examples: Billing & Payments, Technical Support - PC, Trust & Safety, VIP Player Care. Used for team-level workload and performance reporting.',
    `is_first_contact_resolved` BOOLEAN COMMENT 'Indicates whether the players issue was fully resolved in a single interaction without requiring escalation, follow-up, or reopening. First Contact Resolution (FCR) is a primary KPI for support efficiency and player satisfaction.',
    `issue_category` STRING COMMENT 'Top-level classification of the players support issue. Drives routing rules, SLA assignment, and reporting dashboards. billing covers IAP/MTX disputes; technical covers FPS drops, crashes, connectivity; account covers login, bans, data requests; gameplay covers bugs, exploits, NPC behavior; harassment covers PvP/community conduct violations.. Valid values are `billing|technical|account|gameplay|harassment|other`',
    `issue_subcategory` STRING COMMENT 'Second-level classification providing granular issue detail within the parent issue_category. Examples: under billing — refund_request, duplicate_charge, iap_not_received; under technical — crash_on_launch, matchmaking_failure, save_data_corruption. [ENUM-REF-CANDIDATE: refund_request|duplicate_charge|iap_not_received|crash_on_launch|matchmaking_failure|save_data_corruption|account_ban|login_failure|data_deletion_request|harassment_report|exploit_report|other — promote to reference product]',
    `knowledge_base_article_id` STRING COMMENT 'Identifier of the Zendesk Help Center knowledge base article linked to or suggested for this ticket. Used to measure self-service deflection effectiveness and identify gaps in the knowledge base requiring new content.',
    `last_assignee_update_at` TIMESTAMP COMMENT 'Timestamp of the most recent comment or update submitted by the assigned agent on this ticket. Used to monitor agent responsiveness and identify tickets that have gone stale on the agent side.',
    `last_requester_update_at` TIMESTAMP COMMENT 'Timestamp of the most recent comment or update submitted by the player (requester) on this ticket. Used to identify stale tickets awaiting player response and to trigger automated follow-up reminders.',
    `locale` STRING COMMENT 'BCP 47 locale code representing the players language and region at time of ticket submission (e.g., en-US, fr-FR, ja-JP). Used for routing to language-appropriate agents, localization of automated responses, and regional support volume analysis.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `opened_at` TIMESTAMP COMMENT 'Timestamp when the support ticket was first created and entered the support queue. Maps to BUSINESS_EVENT_TIMESTAMP category for TRANSACTION_HEADER role. The authoritative start-of-lifecycle timestamp for SLA calculation and cohort analysis.',
    `organization_code` BIGINT COMMENT 'Reference to the Zendesk organization associated with the player, used for B2B or esports organization-level support grouping. Enables aggregated support reporting for esports teams, studio partners, or enterprise accounts.',
    `platform` STRING COMMENT 'The gaming platform on which the player experienced the issue. Critical for routing technical tickets to platform-specific engineering teams and for correlating support volume with platform-level incidents or TRC/TCR certification issues. [ENUM-REF-CANDIDATE: pc|ps5|ps4|xbox_series|xbox_one|nintendo_switch|ios|android|stadia|other — promote to reference product]',
    `player_account_type` STRING COMMENT 'Classification of the players monetization tier at the time of ticket submission. F2P (Free-to-Play) players, premium purchasers, subscribers, and high-spending whale players may receive differentiated SLA treatment. Supports priority routing and ARPPU-aware support strategies.. Valid values are `f2p|premium|subscriber|whale|vip`',
    `reopen_count` STRING COMMENT 'Number of times this ticket has been reopened after being marked as solved. A high reopen count indicates unresolved issues, poor first-contact resolution, or player dissatisfaction. Used in quality assurance and agent coaching workflows.',
    `resolution_time_seconds` STRING COMMENT 'Total elapsed time in seconds from ticket creation to the ticket being marked as solved. Key operational metric for support efficiency, SLA compliance, and player satisfaction correlation analysis.',
    `satisfaction_rating` STRING COMMENT 'Zendesk satisfaction rating state indicating whether a CSAT survey was offered, responded to, and the outcome. Distinct from the numeric csat_score — this field captures the survey delivery and response state.. Valid values are `good|bad|unoffered|offered`',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether this ticket breached its assigned Service Level Agreement (SLA) target for first response or resolution time. True = SLA was breached. Used for operational KPI reporting, agent performance reviews, and SLA compliance dashboards.',
    `solved_at` TIMESTAMP COMMENT 'Timestamp when the ticket status was first set to solved by an agent or automation. Used to calculate resolution_time_seconds and to measure time-to-resolution distributions across issue categories and platforms.',
    `subject` STRING COMMENT 'Short summary line of the players support request as entered by the player or auto-populated by the in-game support widget. Used for full-text search, NLP topic modeling, and agent triage.',
    `support_ticket_description` STRING COMMENT 'Full initial description of the players issue as submitted in the first message of the ticket. May contain account details, transaction references, or gameplay context. Classified confidential due to potential inclusion of player-specific operational data.',
    `tags` STRING COMMENT 'Comma-separated list of operational tags applied to the ticket in Zendesk for routing, reporting, and automation trigger purposes. Examples: vip_player, iap_refund, account_hack, patch_5_2_regression. Stored as a delimited string for Silver layer compatibility.',
    `ticket_priority` STRING COMMENT 'Priority level assigned to the ticket, determining SLA tier and queue routing. urgent is reserved for critical issues such as account compromise, payment fraud, or widespread outages affecting CCU.. Valid values are `low|normal|high|urgent`',
    `ticket_status` STRING COMMENT 'Current lifecycle state of the support ticket as tracked in Zendesk. Maps to LIFECYCLE_STATUS category for TRANSACTION_HEADER role. new = unassigned; open = assigned and active; pending = awaiting player response; on_hold = awaiting third-party; solved = agent-resolved; closed = system-locked after solve.. Valid values are `new|open|pending|on_hold|solved|closed`',
    `updated_at` TIMESTAMP COMMENT 'Timestamp of the most recent update to this ticket record in the lakehouse, reflecting the latest sync from Zendesk. Maps to RECORD_AUDIT_UPDATED category for TRANSACTION_HEADER role. Used for incremental ETL processing and change detection.',
    `zendesk_ticket_code` BIGINT COMMENT 'The externally-known ticket number assigned by Zendesk, used as the operational reference across player-facing communications, agent dashboards, and cross-system lookups. Maps to BUSINESS_IDENTIFIER category for TRANSACTION_HEADER role.',
    CONSTRAINT pk_support_ticket PRIMARY KEY(`support_ticket_id`)
) COMMENT 'Transactional record of player support requests including full conversation history, sourced from Zendesk. Captures ticket number (Zendesk ID), player reference, issue category (billing/technical/account/gameplay/harassment), subject, description, priority level, channel (email/chat/in-game/web), assigned agent reference, escalation tier, SLA breach flag, first response time, resolution time, CSAT score, resolution status, individual comment records (comment body, author type player/agent/bot, author reference, public/private visibility, attachment count, channel source, timestamp), reopen count, and open/closed timestamps. SSOT for all player care operations, support interaction history, and ticket conversation threads.';

CREATE OR REPLACE TABLE `gaming_ecm`.`community`.`ticket_comment` (
    `ticket_comment_id` BIGINT COMMENT 'Unique surrogate identifier for each individual comment or response within a support ticket thread. Primary key for the ticket_comment data product in the Databricks Silver Layer.',
    `employee_id` BIGINT COMMENT 'Reference to the support agent who authored or submitted this comment when author_type is agent. Null for player or bot-authored comments. Enables agent-level performance analytics, workload distribution, and quality assurance review.',
    `game_title_id` BIGINT COMMENT 'Reference to the specific game title associated with the players support issue as identified in this comment. Enables game-level support volume analytics, bug frequency tracking per title, and live operations (GaaS) health monitoring.',
    `kb_article_id` BIGINT COMMENT 'Reference to the Zendesk Guide knowledge base article linked or suggested in this comment. Enables measurement of self-service deflection effectiveness, knowledge base article utilisation rates, and identification of content gaps in player support documentation.',
    `player_account_id` BIGINT COMMENT 'Reference to the player, support agent, or bot that authored this comment. Resolves to the appropriate party record depending on author_type.',
    `support_ticket_id` BIGINT COMMENT 'Reference to the parent support ticket to which this comment belongs. Establishes the header-detail relationship between the ticket and its conversation thread.',
    `agent_display_name` STRING COMMENT 'The display name of the support agent as shown to the player in the ticket thread. May differ from the agents internal HR name. Used for player-facing communication quality review and community trust analytics.',
    `attachment_count` STRING COMMENT 'Number of file attachments (screenshots, log files, video clips) included with this comment. Used to assess evidence richness in bug reports and player-reported content moderation cases.',
    `author_type` STRING COMMENT 'Categorises the entity that authored the comment: player (end-user submitting or replying), agent (human support representative), bot (automated response system such as a Zendesk Answer Bot or AI assistant), or system (automated platform-generated message). Drives routing analytics and automation performance measurement.. Valid values are `player|agent|bot|system`',
    `channel_source` STRING COMMENT 'The support channel through which this comment was submitted or received. Enables omnichannel support analytics and channel-specific CSAT (Customer Satisfaction Score) performance tracking. [ENUM-REF-CANDIDATE: web|email|chat|api|mobile_sdk|voice|social|community_forum — promote to reference product]',
    `comment_body` STRING COMMENT 'The full plain-text content of the comment or response as submitted within the support ticket thread. May contain player-reported issues, agent instructions, bot-generated responses, or internal notes. Classified confidential due to potential inclusion of sensitive player communication.',
    `comment_body_html` STRING COMMENT 'The HTML-formatted version of the comment body as rendered in the Zendesk interface. Preserves rich-text formatting, hyperlinks, and embedded media references for accurate conversation replay and agent tooling.',
    `comment_sequence` STRING COMMENT 'Ordinal position of this comment within the parent tickets conversation thread, starting at 1. Enables chronological ordering of the full conversation history and identification of first-response, escalation points, and resolution comments.',
    `comment_type` STRING COMMENT 'Indicates the structural type of the comment as classified by Zendesk. Differentiates standard text comments from channel-specific comment types such as voice transcripts, social media replies, or native messaging interactions. [ENUM-REF-CANDIDATE: Comment|VoiceComment|TweetComment|FacebookComment|InstagramDm|NativeMessaging — promote to reference product]. Valid values are `Comment|VoiceComment|TweetComment|FacebookComment|InstagramDm|NativeMessaging`',
    `coppa_restricted_flag` BOOLEAN COMMENT 'Indicates whether this comment is associated with a player account subject to COPPA (Childrens Online Privacy Protection Act) restrictions (player age under 13). When True, additional data handling restrictions apply to comment content and player-identifying metadata.',
    `created_timestamp` TIMESTAMP COMMENT 'The exact date and time when the comment was submitted and recorded in Zendesk. Represents the principal business event timestamp for this transactional record. Used for SLA (Service Level Agreement) measurement, response time analytics, and conversation timeline reconstruction.',
    `data_source_system` STRING COMMENT 'Identifies the operational system of record from which this comment record was sourced. Currently zendesk for all records in this product. Supports data lineage tracking and multi-source reconciliation in the Databricks Silver Layer.. Valid values are `zendesk`',
    `edit_timestamp` TIMESTAMP COMMENT 'The date and time when the comment body was last edited after initial submission. Populated only when is_edited is True. Supports audit trail and GDPR compliance tracking for comment content modifications.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this comment triggered or was associated with a ticket escalation event (True). Used to identify escalation patterns, high-risk player interactions, and agent escalation rates for community health and support operations reporting.',
    `gdpr_erasure_flag` BOOLEAN COMMENT 'Indicates whether the comment body and player-identifying content has been erased or anonymised in response to a GDPR Article 17 right-to-erasure (right to be forgotten) request. When True, comment_body and related PII fields are replaced with anonymised placeholders.',
    `ingested_timestamp` TIMESTAMP COMMENT 'The date and time when this comment record was ingested into the Databricks Silver Layer from the Zendesk source system. Used for ETL (Extract Transform Load) pipeline monitoring and data latency measurement.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether this comment was generated by an automated Zendesk trigger, automation rule, or bot (True) rather than a human agent or player (False). Used to separate human-authored interactions from automated responses in support quality and deflection rate analytics.',
    `is_edited` BOOLEAN COMMENT 'Indicates whether the original comment body was subsequently edited after initial submission (True). Supports audit trail integrity, compliance with GDPR right-to-rectification tracking, and quality assurance review of agent communication accuracy.',
    `is_first_response` BOOLEAN COMMENT 'Indicates whether this comment represents the first public agent or bot response to the players initial ticket submission. Used to calculate First Response Time (FRT) KPI (Key Performance Indicator) for SLA compliance and CSAT (Customer Satisfaction Score) correlation analysis.',
    `is_public` BOOLEAN COMMENT 'Indicates whether the comment is visible to the player (public = True) or is an internal agent note not visible to the player (private = False). Critical for distinguishing player-facing communication from internal operational notes in conversation analytics.',
    `is_resolution_comment` BOOLEAN COMMENT 'Indicates whether this comment was the comment that triggered ticket resolution or closure. Enables identification of the resolution message for quality review, knowledge base article creation, and resolution time analytics.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code (optionally with ISO 3166-1 region subtag) of the comment body content (e.g., en, fr, de, ja, ko). Supports multilingual support operations, routing to language-appropriate agents, and regional community health analytics.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `macro_code` BIGINT COMMENT 'Reference to the Zendesk macro (pre-defined response template) applied by the agent to generate this comment, if applicable. Null for manually authored comments. Enables macro usage analytics and response template effectiveness measurement.',
    `moderation_reason` STRING COMMENT 'The reason code or description explaining why a comment was flagged or removed during content moderation review. Populated when moderation_status is flagged or removed. Supports compliance reporting and community policy enforcement analytics.',
    `moderation_status` STRING COMMENT 'Current moderation state of the comment content, particularly relevant for player-authored comments in community-facing ticket threads. Supports player-reported content moderation workflows and compliance with platform content policies (Apple App Store, Google Play, FTC consumer protection standards).. Valid values are `approved|pending_review|flagged|removed`',
    `platform_code` STRING COMMENT 'The gaming platform associated with the players issue as reported in this comment (e.g., PC, PS5, XBOX_SERIES, SWITCH, MOBILE_IOS). Enables platform-specific bug triage, QA (Quality Assurance) routing, and platform-level support volume analytics. [ENUM-REF-CANDIDATE: PC|PS5|PS4|XBOX_SERIES|XBOX_ONE|SWITCH|MOBILE_IOS|MOBILE_ANDROID|VR — promote to reference product]',
    `player_display_name` STRING COMMENT 'The in-game or platform display name (gamertag/username) of the player who authored this comment when author_type is player. Classified confidential as it is a player-linked identifier. Used for community moderation and player experience analytics.',
    `response_time_seconds` STRING COMMENT 'Elapsed time in seconds between the previous comment in the thread and this comment, representing the agent or player response latency. Used for SLA (Service Level Agreement) compliance measurement, First Response Time (FRT) tracking, and support efficiency analytics.',
    `satisfaction_comment` STRING COMMENT 'Free-text feedback provided by the player alongside their CSAT (Customer Satisfaction Score) rating. Captures qualitative player sentiment for support quality improvement, agent coaching, and community health reporting.',
    `satisfaction_rating` STRING COMMENT 'The Customer Satisfaction Score (CSAT) rating submitted by the player in response to this comment or the associated ticket resolution. Values: good (positive), bad (negative), unoffered (rating not yet presented to player). Core metric for community health and player support quality measurement.. Valid values are `good|bad|unoffered`',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Numeric sentiment polarity score for the comment body ranging from -1.0000 (most negative) to 1.0000 (most positive), derived from NLP (Natural Language Processing) analysis. Used for community health monitoring, proactive escalation detection, and player satisfaction trend analytics.',
    `ticket_status_at_comment` STRING COMMENT 'The status of the parent support ticket at the time this comment was submitted. Captures the ticket lifecycle state snapshot per comment, enabling analysis of comment patterns across ticket workflow stages and SLA breach risk identification.. Valid values are `new|open|pending|hold|solved|closed`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this comment record was last modified in Zendesk, such as when an agent edits a comment body or updates metadata. Supports audit trail and data freshness tracking in the Silver Layer.',
    `via_source` STRING COMMENT 'The specific Zendesk via source descriptor indicating the exact mechanism by which this comment was created (e.g., web form, email reply, API call, trigger automation, macro application). Provides granular channel attribution beyond channel_source for operational analytics.',
    `word_count` STRING COMMENT 'Number of words in the comment body. Used as a proxy for response thoroughness in agent quality assurance reviews and to identify overly brief or excessively long responses that may impact CSAT (Customer Satisfaction Score).',
    `zendesk_comment_code` BIGINT COMMENT 'The native comment identifier assigned by Zendesk at the source system level. Used for lineage tracing and reconciliation between the Silver Layer and the Zendesk operational system of record.',
    `zendesk_ticket_number` STRING COMMENT 'The human-readable, externally-known ticket reference number displayed to players and agents in Zendesk (e.g., #12345). Enables players and support staff to reference the ticket in communications without exposing internal surrogate keys.',
    CONSTRAINT pk_ticket_comment PRIMARY KEY(`ticket_comment_id`)
) COMMENT 'Transactional record of individual comments and responses within a support ticket thread sourced from Zendesk. Tracks comment body, author type (player/agent/bot), author reference, public/private visibility flag, attachment count, channel source, and comment timestamp. Provides full conversation history for each support ticket.';

CREATE OR REPLACE TABLE `gaming_ecm`.`community`.`kb_article` (
    `kb_article_id` BIGINT COMMENT 'Unique surrogate identifier for a knowledge base article in the player support portal. Primary key for this entity. MASTER_RESOURCE role — serves as the SSOT for self-service support content published via Zendesk Knowledge Base.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Support deflection system links troubleshooting articles to asset catalog for automated suggestions when players report asset-related issues (missing DLC, corrupted downloads, platform-specific proble',
    `kb_category_id` BIGINT COMMENT 'Reference to the Zendesk Help Center category under which this article is organized (e.g., Account & Billing, Gameplay, Technical Issues, In-Game Purchases). Drives portal navigation and article discoverability.',
    `certification_checklist_id` BIGINT COMMENT 'Foreign key linking to platform.certification_checklist. Business justification: Knowledge base articles document certification requirements, TRC/TCR guidance, and compliance best practices. Developer portal KB must reference specific checklist versions for accuracy. Essential for',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: Privacy and data handling articles must reference the current consent policy version to ensure players receive accurate information about data processing, withdrawal mechanisms, and third-party sharin',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Knowledge base creation is a support cost center activity. Tracking which cost center authored each article enables content creation cost allocation, deflection ROI analysis (cost savings from self-se',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: Documentation lifecycle management: KB articles document features from specific dev projects; authoring teams track which project a KB article covers for version accuracy and content updates.',
    `game_title_id` BIGINT COMMENT 'Reference to the specific game title this knowledge base article pertains to (e.g., a specific IP or SKU). Enables filtering of support content by game for players and agents. Null if the article is platform-wide or cross-title.',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Knowledge base articles documenting licensed middleware integration (Unreal Engine, Havok Physics), music library usage, or brand guidelines require linking to licensed IP for version-specific documen',
    `marketing_campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Knowledge base articles are created to support campaign launches (new feature docs, event guides, promo code instructions). Campaign attribution enables measurement of content effectiveness and self-s',
    `employee_id` BIGINT COMMENT 'Reference to the Zendesk support agent or community manager who authored or owns this article. Used for content accountability, quality review workflows, and agent performance tracking.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Help articles explaining data rights, age restrictions, or loot box mechanics must cite specific regulatory obligations (GDPR Article 15, COPPA parental consent, etc.) to ensure accuracy and legal def',
    `reviewer_agent_employee_id` BIGINT COMMENT 'Reference to the Zendesk agent or team lead who last reviewed and approved this article for publication. Supports content governance, accountability, and audit trail requirements.',
    `subscription_plan_id` BIGINT COMMENT 'Foreign key linking to monetization.subscription_plan. Business justification: Knowledge base articles document subscription features, billing cycles, cancellation policies, and benefits. Articles reference specific plans for accuracy and version control - plan changes require a',
    `support_ticket_id` BIGINT COMMENT 'Reference to the originating Zendesk support ticket that prompted the creation of this knowledge base article. Enables traceability from reactive player support cases to proactive self-service content, supporting deflection strategy analysis.',
    `archived_at` TIMESTAMP COMMENT 'Timestamp when the article was transitioned to archived status and removed from public view. Null if the article has never been archived. Supports content lifecycle audit trails and compliance record retention.',
    `article_type` STRING COMMENT 'Classification of the article by its content purpose. how_to = step-by-step guide; faq = frequently asked question; troubleshooting = diagnostic resolution guide; policy = terms, rules, or compliance content; release_notes = patch or update notes; known_issue = documented active bug or service disruption.. Valid values are `how_to|faq|troubleshooting|policy|release_notes|known_issue`',
    `comment_count` STRING COMMENT 'Total number of player comments submitted on this article. Indicates community engagement level and may surface unresolved issues or content gaps requiring article updates.',
    `content_body` STRING COMMENT 'Full HTML or plain-text body content of the knowledge base article as rendered in the player support portal. Contains step-by-step instructions, troubleshooting guidance, FAQs, or policy explanations. Sourced from Zendesk Articles API body field.',
    `content_format` STRING COMMENT 'Format of the article content body. html = rich HTML markup as rendered in Zendesk; markdown = Markdown-formatted text; plain_text = unformatted text. Determines how the content_body field is parsed and rendered by the support portal.. Valid values are `html|markdown|plain_text`',
    `content_version` STRING COMMENT 'Monotonically incrementing version number of the article content, incremented each time the article body or title is materially updated. Supports content audit trails and rollback identification. Corresponds to Zendesk article revision tracking.',
    `coppa_restricted` BOOLEAN COMMENT 'Indicates whether this article is restricted from display to players under 13 years of age in compliance with COPPA regulations. Applies to articles referencing data collection, in-app purchases (IAP), or social features for child-directed games.',
    `created_at` TIMESTAMP COMMENT 'Timestamp when this knowledge base article record was first created in the system (draft creation). Corresponds to the Zendesk article creation timestamp. Distinct from published_at, which reflects when the article became publicly visible.',
    `deflection_rate` DECIMAL(18,2) COMMENT 'Proportion of article views that resulted in the player NOT submitting a support ticket, expressed as a decimal between 0 and 1 (e.g., 0.7500 = 75% deflection). Core KPI for measuring the effectiveness of self-service support content in reducing agent workload.',
    `esrb_content_flag` BOOLEAN COMMENT 'Indicates whether this article contains content that references mature or age-restricted game content subject to ESRB rating guidelines (e.g., articles about M-rated game features). When true, the article may be restricted from display to players under the applicable age threshold.',
    `gdpr_data_flag` BOOLEAN COMMENT 'Indicates whether this article references player personal data handling procedures (e.g., data deletion requests, account privacy settings). When true, the article is subject to GDPR supervisory authority review and must align with current privacy policy.',
    `helpful_vote_count` STRING COMMENT 'Total number of player votes indicating the article was helpful (thumbs up / Yes response to the Was this article helpful? prompt). Used to measure content quality and player satisfaction with self-service support.',
    `is_comments_enabled` BOOLEAN COMMENT 'Indicates whether player comments are enabled on this article. When true, players can submit feedback comments directly on the article page. Community managers may disable comments on policy or legal articles.',
    `is_promoted` BOOLEAN COMMENT 'Indicates whether this article has been promoted to appear at the top of search results or in featured content sections of the support portal. Promoted articles are typically high-traffic or high-deflection content prioritized by the community team.',
    `label_names` STRING COMMENT 'Comma-separated list of Zendesk content labels or tags applied to this article for search and filtering purposes (e.g., account,billing,refund). Supports faceted search and related-article recommendations in the support portal.',
    `last_accuracy_review_date` DATE COMMENT 'Date on which the article content was last reviewed for factual accuracy and relevance by the content team. Articles not reviewed within a defined SLA window (e.g., 90 days) are flagged for mandatory review to prevent outdated guidance from reaching players.',
    `last_updated_at` TIMESTAMP COMMENT 'Timestamp of the most recent material update to the article content, title, or metadata. Corresponds to the Zendesk updated_at field. Displayed to players as Last Updated to indicate content freshness.',
    `locale` STRING COMMENT 'IETF BCP 47 language-region locale code for the article (e.g., en-US, fr-FR, de-DE, ja-JP, ko-KR). Supports multi-language player support portals across global markets. Aligns with PEGI, USK, CERO, and GRAC regional compliance requirements.. Valid values are `^[a-z]{2}-[A-Z]{2}$`',
    `next_review_date` DATE COMMENT 'Scheduled date by which this article must next be reviewed for accuracy and relevance. Set by the content governance workflow based on article type, game patch cadence, or regulatory change events. Drives automated review reminders for the community team.',
    `permission_group` STRING COMMENT 'Access control group determining which audience can view this article. everyone = publicly accessible without login; signed_in = requires player account authentication; agents_only = internal support agent reference content not visible to players. Aligns with Zendesk user segment permissions.. Valid values are `everyone|signed_in|agents_only`',
    `platform` STRING COMMENT 'Gaming platform(s) this article applies to (e.g., PC, PlayStation, Xbox, Nintendo Switch, iOS, Android). Enables platform-specific filtering in the support portal. [ENUM-REF-CANDIDATE: pc|playstation|xbox|nintendo_switch|ios|android|cross_platform — promote to reference product]',
    `publication_status` STRING COMMENT 'Current lifecycle state of the knowledge base article within the Zendesk content workflow. draft = authored but not yet visible to players; published = live and searchable in the support portal; archived = retired from public view but retained for historical reference.. Valid values are `draft|published|archived`',
    `published_at` TIMESTAMP COMMENT 'Timestamp when the article was first published and made visible to players in the support portal. Corresponds to the Zendesk created_at field for published articles. Used for content age analysis and SLA reporting.',
    `reading_time_minutes` STRING COMMENT 'Estimated time in minutes for a player to read the article, calculated from word_count using a standard reading speed baseline. Displayed in the support portal to set player expectations and improve user experience.',
    `related_article_ids` STRING COMMENT 'Comma-separated list of kb_article_id values for articles editorially linked as related content. Drives Related Articles recommendations in the support portal to improve player self-service navigation and reduce ticket submission.',
    `review_status` STRING COMMENT 'Editorial review state of the article within the content governance workflow. pending_review = awaiting QA or editorial sign-off; approved = cleared for publication; needs_update = flagged for content refresh; flagged = escalated for compliance or accuracy concerns.. Valid values are `pending_review|approved|needs_update|flagged`',
    `search_rank_score` DECIMAL(18,2) COMMENT 'Relevance score assigned by the Zendesk search engine or internal ranking algorithm to determine article ordering in search results. Higher scores indicate greater relevance for common player queries. Used to optimize content discoverability.',
    `section_id` BIGINT COMMENT 'Reference to the Zendesk Help Center section (sub-category) under which this article is nested. Sections provide a second level of hierarchy beneath categories for finer-grained content organization.',
    `seo_slug` STRING COMMENT 'URL-friendly slug derived from the article title, used in the canonical URL of the support portal article page. Supports App Store Optimization (ASO) and organic search discoverability. Must be lowercase alphanumeric with hyphens.. Valid values are `^[a-z0-9]+(?:-[a-z0-9]+)*$`',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this article record was ingested into the lakehouse silver layer. zendesk = sourced directly from Zendesk Knowledge Base API; internal_cms = authored in an internal content management system; imported = bulk-migrated legacy content.. Valid values are `zendesk|internal_cms|imported`',
    `title` STRING COMMENT 'Human-readable title of the knowledge base article as displayed to players in the support portal. Used for search indexing, navigation, and SEO. Corresponds to the title field in Zendesk Articles API.',
    `unhelpful_vote_count` STRING COMMENT 'Total number of player votes indicating the article was not helpful (thumbs down / No response). Used alongside helpful_vote_count to compute article satisfaction ratio and identify content requiring revision.',
    `view_count` BIGINT COMMENT 'Cumulative number of times this article has been viewed by players in the support portal since publication. Key metric for measuring self-service content reach and ticket deflection effectiveness. Sourced from Zendesk article analytics.',
    `vote_sum` STRING COMMENT 'Net vote score for the article, calculated as helpful_vote_count minus unhelpful_vote_count. Provides a single signed integer representing overall player sentiment toward the article. Used for content quality ranking and surfacing top-rated support articles.',
    `word_count` STRING COMMENT 'Total word count of the article content body (excluding HTML markup). Used by content teams to assess article depth, readability, and SEO quality. Articles below a minimum threshold may be flagged for expansion.',
    `zendesk_article_code` BIGINT COMMENT 'External article identifier assigned by Zendesk Knowledge Base, used to cross-reference the article in the source system of record. Enables reconciliation between the lakehouse silver layer and the operational Zendesk platform.',
    CONSTRAINT pk_kb_article PRIMARY KEY(`kb_article_id`)
) COMMENT 'Master entity for knowledge base articles published in the player support portal (Zendesk Knowledge Base). Tracks article title, category, associated game title, author agent reference, content body, language locale, view count, helpful vote count, unhelpful vote count, deflection rate, SEO slug, publication status (draft/published/archived), and publish/last-updated timestamps. SSOT for self-service support content.';

CREATE OR REPLACE TABLE `gaming_ecm`.`community`.`moderation_action` (
    `moderation_action_id` BIGINT COMMENT 'Unique surrogate identifier for each moderation action record. Primary key for the moderation_action data product in the community domain.',
    `ad_creative_id` BIGINT COMMENT 'Foreign key linking to marketing.ad_creative. Business justification: Moderation flags ad creative violations in UGC or forums (copyright infringement, misleading claims). Direct link enables compliance tracking, ad creative quality monitoring, and regulatory reporting ',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Compliance audits analyze moderation action patterns to identify control gaps (inadequate age verification, inconsistent content enforcement). Links moderation evidence to formal audit findings requir',
    `backlog_item_id` BIGINT COMMENT 'Foreign key linking to studio.backlog_item. Business justification: Exploit remediation workflow: moderation actions revealing game exploits or bugs create backlog items for fixes. Essential for closing exploit vectors and maintaining competitive integrity.',
    `compliance_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Moderation actions revealing systemic issues (minors in adult forums, COPPA violations, content rating breaches) trigger formal compliance incidents requiring root cause analysis, regulatory notificat',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Moderation is a cost center function (community operations, trust & safety). Tracking which cost center performed each action enables workforce cost allocation, moderation efficiency analysis, and cos',
    `employee_id` BIGINT COMMENT 'Reference to the moderator (human staff member or automated moderation system agent) who executed this moderation action.',
    `game_title_id` BIGINT COMMENT 'Reference to the specific game title within which the violation occurred or to which the moderation action applies. Null for platform-wide or cross-game community actions.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Moderation actions enforcing licensed IP terms (DMCA takedowns, brand guideline violations, unauthorized music use in streams) must reference governing agreement for legal defensibility, audit trails,',
    `player_account_id` BIGINT COMMENT 'Reference to the player account against whom this moderation action is applied. The subject of the enforcement action.',
    `refund_id` BIGINT COMMENT 'Foreign key linking to billing.refund. Business justification: Policy violations resulting in permanent bans often trigger automatic refunds per terms of service, requiring linkage for refund processing, policy enforcement tracking, and financial impact analysis ',
    `support_ticket_id` BIGINT COMMENT 'Reference to the originating Zendesk player support ticket that triggered or is associated with this moderation action. Links enforcement to the player support workflow.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Content policy enforcement requires linking moderation decisions to asset catalog for CDN removal and audit trail. Regulatory compliance (ESRB, PEGI, COPPA) mandates tracking which assets were flagged',
    `action_reference_number` STRING COMMENT 'Externally visible, human-readable reference number for this moderation action. Used in player-facing communications, appeals correspondence, and audit trails. Format: MOD- followed by 8–12 digits.. Valid values are `^MOD-[0-9]{8,12}$`',
    `action_status` STRING COMMENT 'Current lifecycle state of the moderation action. active = enforcement currently in effect; expired = time-limited ban has naturally elapsed; reinstated = ban re-applied after appeal overturn; overturned = action reversed via appeal; pending = action queued for review or delayed enforcement.. Valid values are `active|expired|reinstated|overturned|pending`',
    `action_timestamp` TIMESTAMP COMMENT 'The principal real-world business event timestamp recording when the moderation action was formally applied and took effect. This is the authoritative enforcement time used for ban state derivation, duration calculations, and historical ban records.',
    `action_type` STRING COMMENT 'Classification of the enforcement action applied: warn (formal warning issued), mute (player silenced in chat/forums), temp_ban (temporary account suspension), perma_ban (permanent account ban), content_removal (specific content removed), escalation (case escalated to senior moderation or legal team).. Valid values are `warn|mute|temp_ban|perma_ban|content_removal|escalation`',
    `appeal_eligible` BOOLEAN COMMENT 'Indicates whether the targeted player is eligible to submit a formal appeal against this moderation action. Eligibility may be restricted for certain violation types (e.g., confirmed cheating, COPPA violations) or repeat offenders.',
    `appeal_outcome` STRING COMMENT 'The final decision on the players appeal: upheld (original action confirmed), overturned (action reversed and player reinstated), modified (action reduced or changed), pending (decision not yet issued). Null if no appeal was submitted.. Valid values are `upheld|overturned|modified|pending`',
    `appeal_resolved_timestamp` TIMESTAMP COMMENT 'The date and time at which the appeal review was completed and a final outcome was issued. Null if the appeal is still pending or was not submitted. Used to measure appeal resolution cycle time.',
    `appeal_status` STRING COMMENT 'Current status of the players appeal against this moderation action: not_submitted (no appeal filed), submitted (appeal received, pending review), under_review (appeal actively being assessed), resolved (appeal decision issued), withdrawn (player retracted the appeal).. Valid values are `not_submitted|submitted|under_review|resolved|withdrawn`',
    `appeal_submitted_timestamp` TIMESTAMP COMMENT 'The date and time at which the player formally submitted their appeal against this moderation action. Null if no appeal was filed. Used to track appeal response time SLAs.',
    `automation_confidence_score` DECIMAL(18,2) COMMENT 'For automated moderation actions, the confidence score (0.0000–1.0000) produced by the automated moderation model at the time of action. Null for human-executed actions. Used to assess model accuracy, calibrate thresholds, and flag low-confidence decisions for human review.',
    `ban_duration_hours` STRING COMMENT 'The length of a temporary ban or mute expressed in hours. Null for permanent bans (perma_ban) or non-ban action types. Used to calculate ban_end_timestamp and to support duration-based analytics and escalation policies.',
    `ban_end_timestamp` TIMESTAMP COMMENT 'The date and time at which a temporary ban or mute is scheduled to expire and the players access is automatically restored. Null for permanent bans or non-ban action types. Stored in ISO 8601 format with timezone offset.',
    `ban_scope` STRING COMMENT 'The community surface or platform area to which the ban or mute restriction applies: forum (forum posting only), chat (in-game and community chat), ugc (User-Generated Content (UGC) submission), all_community (all community surfaces), game (full game access suspension).. Valid values are `forum|chat|ugc|all_community|game`',
    `content_category` STRING COMMENT 'The content classification category of the violating material as assessed by the moderator (e.g., HATE_SPEECH, ADULT_CONTENT, VIOLENCE, CHEATING_EXPLOIT, SPAM_ADVERTISING). Aligns with ESRB and PEGI content descriptors for regulatory reporting. [ENUM-REF-CANDIDATE: HATE_SPEECH|ADULT_CONTENT|VIOLENCE|CHEATING_EXPLOIT|SPAM_ADVERTISING|MINOR_ENDANGERMENT|FRAUD|IMPERSONATION — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this moderation action record was first created in the system. Represents the audit record creation time, which may differ from action_timestamp if there is a processing delay.',
    `escalation_tier` STRING COMMENT 'The escalation level to which this action has been routed: tier_1 (frontline community moderation), tier_2 (senior moderation review), tier_3 (trust and safety team), legal (referred to legal or compliance team). Null for non-escalated actions.. Valid values are `tier_1|tier_2|tier_3|legal`',
    `evidence_reference` STRING COMMENT 'Identifier or URI pointing to the stored evidence package (screenshots, chat logs, replay files, UGC assets) that supports this moderation decision. May reference a content delivery network (CDN) path, internal document store, or case management system artifact.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether this moderation action was executed by an automated moderation system (True) or by a human moderator (False). Supports audit requirements, accuracy tracking, and human-review escalation workflows.',
    `is_permanent` BOOLEAN COMMENT 'Indicates whether this moderation action constitutes a permanent, indefinite enforcement with no scheduled expiry. True for perma_ban action types; False for all time-limited or non-ban actions.',
    `moderator_notes` STRING COMMENT 'Internal free-text notes recorded by the moderator for case context, coordination with other team members, or documentation of edge-case circumstances. Not visible to the player. Supports case handoff and audit review.',
    `notification_timestamp` TIMESTAMP COMMENT 'The date and time at which the player was formally notified of this moderation action. Null if notification has not yet been sent. Supports GDPR transparency compliance and SLA tracking for player communication.',
    `platform_code` STRING COMMENT 'The gaming platform on which the moderation action was applied or the violation occurred (e.g., PC, PS5, XBOX, MOBILE). Supports platform-specific moderation reporting and cross-platform ban enforcement coordination. [ENUM-REF-CANDIDATE: PC|PS5|PS4|XBOX|SWITCH|MOBILE|WEB — 7 candidates stripped; promote to reference product]',
    `player_notified` BOOLEAN COMMENT 'Indicates whether the targeted player has been formally notified of this moderation action via in-game notification, email, or support ticket. Required for GDPR transparency obligations and internal player communication standards.',
    `prior_action_count` STRING COMMENT 'The number of previous moderation actions recorded against the target player at the time this action was issued. Captured as a point-in-time snapshot to support escalation logic, recidivism analysis, and progressive discipline enforcement.',
    `reason_code` STRING COMMENT 'Standardized code identifying the policy violation or reason for the moderation action (e.g., HATE_SPEECH, HARASSMENT, CHEATING, SPAM, EXPLICIT_CONTENT, IMPERSONATION, FRAUD, MINOR_SAFETY). Drives reporting, trend analysis, and policy enforcement metrics. [ENUM-REF-CANDIDATE: HATE_SPEECH|HARASSMENT|CHEATING|SPAM|EXPLICIT_CONTENT|IMPERSONATION|FRAUD|MINOR_SAFETY|THREATS|DOXXING — promote to reference product]',
    `reason_description` STRING COMMENT 'Free-text narrative provided by the moderator elaborating on the specific circumstances, policy violation details, or contextual factors that informed the moderation decision. Supplements the structured reason_code.',
    `regulatory_flag` BOOLEAN COMMENT 'Indicates whether this moderation action has been flagged as potentially involving a regulatory compliance obligation (e.g., COPPA minor safety incident, GDPR data misuse, illegal content under DSA). Triggers mandatory regulatory review and reporting workflows.',
    `regulatory_framework_code` STRING COMMENT 'Identifies the specific regulatory framework applicable to this moderation action when regulatory_flag is True (e.g., GDPR for EU player data, COPPA for under-13 player content, DSA for illegal content under the EU Digital Services Act). Null or NONE when no regulatory obligation applies. [ENUM-REF-CANDIDATE: GDPR|COPPA|DSA|ESRB|PEGI|PCI_DSS|NONE — 7 candidates stripped; promote to reference product]',
    `reinstatement_timestamp` TIMESTAMP COMMENT 'The date and time at which the players access was reinstated following a successful appeal overturn, manual moderator reversal, or natural ban expiry. Null if the action has not been lifted.',
    `reported_content_reference` BIGINT COMMENT 'Reference to the specific player-reported content record (forum post, UGC submission, chat message, or other community content) that is the subject of this moderation action.',
    `severity_level` STRING COMMENT 'Categorical severity rating assigned to the moderation action reflecting the seriousness of the policy violation: low (minor infraction), medium (repeated or moderate violation), high (serious violation), critical (legal risk, child safety, or platform-threatening behavior). Drives escalation routing and reporting.. Valid values are `low|medium|high|critical`',
    `source_system` STRING COMMENT 'The originating system or channel through which this moderation action was initiated: zendesk (player support ticket), in_game_report (in-game player report tool), auto_detection (automated moderation system), moderator_initiated (proactive moderator action), community_portal (community forum report).. Valid values are `zendesk|in_game_report|auto_detection|moderator_initiated|community_portal`',
    `target_entity_reference` STRING COMMENT 'The system-specific identifier of the targeted entity (e.g., forum post ID, UGC asset ID, chat message ID, guild ID). Stored as a string to accommodate identifiers from multiple source systems. Used in conjunction with target_entity_type to locate the exact subject of enforcement.',
    `target_entity_type` STRING COMMENT 'The type of community entity against which this moderation action is directed. Distinguishes whether the action targets a player account, a specific piece of content (forum post, UGC submission, chat message), a guild/clan, or a player review.. Valid values are `player_account|forum_post|ugc_submission|chat_message|guild|review`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time at which this moderation action record was most recently modified (e.g., appeal status update, reinstatement, regulatory flag change). Supports audit trail and change tracking requirements.',
    CONSTRAINT pk_moderation_action PRIMARY KEY(`moderation_action_id`)
) COMMENT 'Transactional record of content moderation actions and the definitive enforcement state for all community bans and suspensions. Covers warnings, mutes, temporary bans, permanent bans, content removals, and escalations applied against player-reported content, forum posts, UGC submissions, or player accounts. Captures action type (warn/mute/temp-ban/perma-ban/content-removal/escalation), target entity type and reference, reporting player reference, moderator agent reference, reason code, evidence reference, ban scope (forum/chat/ugc/all-community), duration and end date for temporary enforcement, ban active/expired/reinstated status, appeal eligibility flag, appeal status, appeal outcome, reinstatement timestamp, and action timestamp. SSOT for all community moderation enforcement, active ban state derivation, and historical ban records.';

CREATE OR REPLACE TABLE `gaming_ecm`.`community`.`player_report` (
    `player_report_id` BIGINT COMMENT 'Unique surrogate identifier for each player-submitted report record in the community moderation system. Primary key for the player_report data product.',
    `ad_creative_id` BIGINT COMMENT 'Foreign key linking to marketing.ad_creative. Business justification: Players report misleading ad creative (false gameplay footage, deceptive offers). Consumer protection requirement; link enables ad quality monitoring, regulatory compliance (FTC guidelines), and creat',
    `backlog_item_id` BIGINT COMMENT 'Foreign key linking to studio.backlog_item. Business justification: Player-reported issue triage: reports of cheating, bugs, or exploits generate backlog items for investigation. Essential for tracking resolution status and communicating fixes back to reporters.',
    `build_submission_id` BIGINT COMMENT 'Foreign key linking to platform.build_submission. Business justification: Exploit/cheat reports tied to specific build submissions enable anti-cheat teams to identify vulnerable builds and coordinate hotfixes. Critical for live ops security response and certification resubm',
    `compliance_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Player reports of minors bypassing age gates, inappropriate monetization targeting children, or data misuse trigger formal compliance incidents requiring investigation, regulatory notification (if mat',
    `crossplay_feature_id` BIGINT COMMENT 'Foreign key linking to platform.crossplay_feature. Business justification: Crossplay features generate platform-specific reports (input imbalance, matchmaking issues, voice chat failures). Support and engineering teams need to segment reports by crossplay configuration for f',
    `defect_id` BIGINT COMMENT 'Foreign key linking to quality.defect. Business justification: Player reports identifying bugs must link to QA defect tracking for resolution workflow. Essential for bug triage process where community-reported issues are validated and tracked through development ',
    `employee_id` BIGINT COMMENT 'Reference to the community moderator or support agent assigned to review and action this report. Maps to the workforce or agent record.',
    `gacha_pull_id` BIGINT COMMENT 'Foreign key linking to monetization.gacha_pull. Business justification: Players report perceived unfair gacha outcomes or regulatory concerns about drop rates. Reports reference specific pull events for investigation - moderation verifies disclosed rates match actual outc',
    `session_id` BIGINT COMMENT 'Identifier of the game session during which the alleged violation occurred. Enables cross-referencing with session telemetry for evidence corroboration.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title within which the reported incident occurred. Enables per-title moderation analytics and policy enforcement.',
    `iap_transaction_id` BIGINT COMMENT 'Foreign key linking to monetization.iap_transaction. Business justification: Players report fraudulent purchases or account compromise involving transactions. Moderation teams need transaction evidence to investigate fraud claims, verify unauthorized purchases, and coordinate ',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Player reports flagging licensed content violations (copyrighted music in UGC, brand misuse, middleware exploits) require linking to licensed IP asset for violation tracking, licensor notification, an',
    `match_id` BIGINT COMMENT 'Identifier of the specific PvP or PvE match in which the alleged violation occurred. Supports replay review and anti-cheat investigation workflows.',
    `player_account_id` BIGINT COMMENT 'Reference to the player who submitted this report. Identifies the originating party of the moderation action.',
    `refund_id` BIGINT COMMENT 'Foreign key linking to billing.refund. Business justification: Player reports of fraudulent purchases or unauthorized transactions require direct refund linkage for fraud investigation, chargeback prevention, account security verification, and financial loss trac',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Community moderation workflow routes asset reports (inappropriate UGC, broken content) to content review team. Regulatory compliance requires tracking reported assets for COPPA/GDPR data subject reque',
    `storefront_id` BIGINT COMMENT 'Reference to the platform (console, PC, mobile) on which the reported incident occurred. Supports platform-specific moderation workflows and compliance.',
    `appeal_resolved_timestamp` TIMESTAMP COMMENT 'Date and time when the appeal against the enforcement action was resolved. Null if no appeal was filed or if the appeal is still pending.',
    `appeal_status` STRING COMMENT 'Status of any appeal filed by the reported player against the enforcement action resulting from this report. Tracks the appeals lifecycle for compliance and fairness reporting.. Valid values are `not_appealed|appeal_pending|appeal_upheld|appeal_denied`',
    `auto_moderation_score` DECIMAL(18,2) COMMENT 'Confidence score (0.0000–1.0000) assigned by the automated content moderation system indicating the likelihood that the reported content violates community guidelines. Supports moderator prioritization.',
    `content_rating_concern` STRING COMMENT 'Classification of the content rating concern raised by this report, aligned with ESRB/PEGI content descriptors. Supports compliance reporting to rating bodies and content policy enforcement.. Valid values are `none|violence|sexual_content|hate_speech|drug_reference|language`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this player_report record was first persisted in the data platform. Serves as the audit creation timestamp for data lineage and compliance purposes.',
    `evidence_attachment_count` STRING COMMENT 'Number of evidence files (screenshots, video clips, chat logs) attached to this report by the reporting player. Indicates evidentiary strength for moderator prioritization.',
    `evidence_attachment_urls` STRING COMMENT 'Comma-separated list of CDN-hosted URLs pointing to evidence files (screenshots, video clips, chat exports) submitted with the report. Stored as a delimited string per Silver layer conventions.',
    `incident_timestamp` TIMESTAMP COMMENT 'The real-world date and time when the alleged violation occurred, as reported by the submitting player or inferred from game session logs. Distinct from the report submission timestamp.',
    `is_automated_flag` BOOLEAN COMMENT 'Indicates whether this report was generated by an automated detection system (e.g., anti-cheat engine, chat filter, UGC scanner) rather than a player submission. Distinguishes system-generated from player-generated reports.',
    `is_minor_involved` BOOLEAN COMMENT 'Indicates whether the reporting or reported player is identified as a minor (under 13 or under 18 depending on jurisdiction). Triggers COPPA-compliant handling procedures and elevated moderation priority.',
    `is_repeat_report` BOOLEAN COMMENT 'Indicates whether the reporting player has previously submitted a report against the same reported entity. True signals potential targeted harassment by the reporter or a persistent offender pattern.',
    `moderation_queue` STRING COMMENT 'The moderation queue to which this report was routed based on violation severity, reporter history, and automated triage rules. Determines handling SLA tier.. Valid values are `standard|priority|trust_and_safety|legal|automated`',
    `regulatory_jurisdiction` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the regulatory jurisdiction applicable to this report based on the reporting players registered region. Determines applicable data protection and content moderation regulations (GDPR, COPPA, DSA, etc.).',
    `report_description` STRING COMMENT 'Free-text narrative provided by the reporting player describing the alleged violation in their own words. Primary evidence input for moderator review.',
    `report_number` STRING COMMENT 'Human-readable, externally referenceable business identifier for the report (e.g., RPT-0000123456). Used in player communications, Zendesk tickets, and audit trails.. Valid values are `^RPT-[0-9]{10}$`',
    `report_source_channel` STRING COMMENT 'The channel through which the report was submitted (e.g., in-game report UI, web portal, mobile app, Zendesk support form). Informs channel-specific moderation workflow routing.. Valid values are `in_game|web_portal|mobile_app|zendesk|community_forum|discord`',
    `report_status` STRING COMMENT 'Current lifecycle state of the player report within the moderation workflow. Drives queue management and SLA tracking. [ENUM-REF-CANDIDATE: pending|under_review|actioned|dismissed|escalated|closed — promote to reference product if additional statuses are required]. Valid values are `pending|under_review|actioned|dismissed|escalated|closed`',
    `reported_entity_prior_violation_count` STRING COMMENT 'Number of confirmed prior violations on the reported entitys record at the time of this report. Informs severity escalation and repeat-offender enforcement policies.',
    `reported_entity_reference` BIGINT COMMENT 'Identifier of the entity being reported (player, post, UGC item, or chat message). The entity type is specified in reported_entity_type.',
    `reported_entity_type` STRING COMMENT 'Discriminator indicating the type of entity being reported. Determines which downstream moderation workflow and evidence schema applies. [ENUM-REF-CANDIDATE: player|post|ugc|chat|clan|profile — promote to reference product if additional types are required]. Valid values are `player|post|ugc|chat|clan|profile`',
    `reporter_account_age_days` STRING COMMENT 'Age of the reporting players account in days at the time of report submission. Used in automated triage to weight report credibility and detect smurf or throwaway accounts.',
    `reporter_prior_report_count` STRING COMMENT 'Total number of reports previously submitted by the reporting player at the time of this submission. Supports reporter credibility scoring and abuse-of-report-system detection.',
    `resolution_action` STRING COMMENT 'The specific enforcement action taken as a result of this report. Drives enforcement analytics and appeals tracking. [ENUM-REF-CANDIDATE: warning_issued|account_suspended|account_banned|content_removed|no_action|escalated_to_trust_safety — promote to reference product if additional actions are required]. Valid values are `warning_issued|account_suspended|account_banned|content_removed|no_action|escalated_to_trust_safety`',
    `resolution_notes` STRING COMMENT 'Moderator-authored free-text notes documenting the rationale for the resolution decision, evidence reviewed, and any mitigating factors considered. Critical for appeals and audit trails.',
    `resolution_time_hours` DECIMAL(18,2) COMMENT 'Actual elapsed time in hours from report submission to resolution. Calculated field stored for operational reporting; used to assess moderation efficiency and SLA adherence.',
    `resolved_timestamp` TIMESTAMP COMMENT 'Date and time when the report was fully resolved (actioned or dismissed). Used to calculate end-to-end resolution time and SLA compliance.',
    `reviewed_timestamp` TIMESTAMP COMMENT 'Date and time when a moderator first opened and began reviewing this report. Used to calculate time-to-first-review SLA metrics.',
    `severity_level` STRING COMMENT 'Assessed severity of the reported violation, assigned by automated triage or moderator review. Drives prioritization within the moderation queue and escalation thresholds.. Valid values are `low|medium|high|critical`',
    `sla_target_hours` DECIMAL(18,2) COMMENT 'The target resolution time in hours for this report based on its severity level and moderation queue tier. Used to measure SLA compliance and moderator performance.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the reporting player formally submitted this report to the moderation system. Used as the BUSINESS_EVENT_TIMESTAMP for SLA measurement and queue aging.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this player_report record was last modified in the data platform. Tracks moderator actions, status transitions, and resolution updates for audit compliance.',
    `violation_category` STRING COMMENT 'Primary classification of the alleged violation (e.g., harassment, cheating, hate_speech, spam, inappropriate_ugc, account_sharing, exploiting). Drives routing to specialized moderation queues. [ENUM-REF-CANDIDATE: harassment|cheating|hate_speech|spam|inappropriate_ugc|account_sharing|exploiting|other — promote to reference product]',
    `violation_subcategory` STRING COMMENT 'Secondary classification providing granular detail within the violation category (e.g., within harassment: verbal_abuse, sexual_harassment, doxxing). Enables fine-grained moderation analytics and policy tuning.',
    `zendesk_ticket_code` STRING COMMENT 'External reference to the corresponding Zendesk support ticket created for this report, when escalated to player support. Enables bidirectional traceability between the data platform and the operational CRM.',
    CONSTRAINT pk_player_report PRIMARY KEY(`player_report_id`)
) COMMENT 'Transactional record of player-submitted reports against other players or content for violations (harassment, cheating, hate speech, spam, inappropriate UGC). Tracks reporting player reference, reported entity type (player/post/ugc/chat), reported entity reference, violation category, description, evidence attachments, report status (pending/reviewed/actioned/dismissed), assigned moderator reference, resolution notes, and report/resolution timestamps.';

CREATE OR REPLACE TABLE `gaming_ecm`.`community`.`survey_response` (
    `survey_response_id` BIGINT COMMENT 'Primary key for survey_response',
    `game_title_id` BIGINT COMMENT 'Reference to the specific game title associated with this survey response, enabling per-title satisfaction and NPS/CSAT benchmarking.',
    `marketing_campaign_id` BIGINT COMMENT 'Reference to the marketing or CRM campaign that distributed this survey, if the survey was delivered via an email or push notification campaign. Null for in-game triggered surveys.',
    `player_account_id` BIGINT COMMENT 'Reference to the player who submitted this survey response. Core party reference enabling player-level satisfaction analytics and retention modeling.',
    `player_ltv_segment_id` BIGINT COMMENT 'Foreign key linking to monetization.player_ltv_segment. Business justification: Survey targeting segments by LTV (whales get retention surveys, non-payers get monetization friction surveys). Responses analyzed by player value tier for product decisions - different segments have d',
    `promo_redemption_id` BIGINT COMMENT 'Foreign key linking to billing.promo_redemption. Business justification: Survey incentive programs offer promo codes upon completion, requiring linkage to track redemption rates, measure survey ROI, validate reward fulfillment, and analyze conversion from survey participat',
    `session_id` BIGINT COMMENT 'Reference to the specific game session during which the survey was triggered. Enables correlation of satisfaction scores with session-level behavioral data such as session length, FPS performance, and in-session events.',
    `support_ticket_id` BIGINT COMMENT 'Reference to the Zendesk support ticket that triggered this post-interaction survey, if applicable. Null for in-game or email campaign surveys.',
    `survey_id` BIGINT COMMENT 'Reference to the parent survey definition that this response belongs to, linking back to the survey catalog.',
    `answered_question_count` STRING COMMENT 'The number of survey questions the player actually answered. Compared against question_count to determine partial completion rate and identify drop-off points in the survey flow.',
    `ces_score` STRING COMMENT 'The players raw Customer Effort Score on a 1–7 scale measuring how easy it was to resolve their issue or complete an in-game action. Null for non-CES survey types. Lower scores indicate higher effort and friction.',
    `collection_channel` STRING COMMENT 'The channel through which the survey was delivered to the player. In_game indicates an in-game prompt; email indicates an email campaign; push_notification indicates a mobile push; web_portal indicates the player support portal; support_chat indicates a Zendesk chat trigger; post_ticket indicates a post-resolution Zendesk CSAT survey. [ENUM-REF-CANDIDATE: in_game|email|push_notification|web_portal|support_chat|post_ticket — promote to reference product]. Valid values are `in_game|email|push_notification|web_portal|support_chat|post_ticket`',
    `coppa_verified_age` BOOLEAN COMMENT 'Indicates whether the players age was verified as 13 or older (True) prior to survey collection, as required by COPPA for US-based players. False or null indicates age verification was not completed, and the response must be handled with restricted data processing.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time (UTC) when this survey response record was first ingested into the data platform. Audit trail field for data lineage and compliance.',
    `csat_score` STRING COMMENT 'The players raw CSAT rating, typically on a 1–5 scale, measuring satisfaction with a specific support interaction or in-game experience. Null for non-CSAT survey types. Used to compute CSAT percentage for community health KPIs.',
    `custom_score` DECIMAL(18,2) COMMENT 'Numeric score captured for custom or bespoke survey instruments that do not conform to NPS, CSAT, or CES scales. The scale and interpretation are defined by the parent survey definition. Null for standard survey types.',
    `data_source_system` STRING COMMENT 'The operational system of record from which this survey response was ingested into the data platform. Enables data lineage tracking and source-level quality auditing. [ENUM-REF-CANDIDATE: zendesk|salesforce|in_game_sdk|email_platform|web_portal|amplitude|surveymonkey|qualtrics — promote to reference product]. Valid values are `zendesk|salesforce|in_game_sdk|email_platform|web_portal|amplitude`',
    `device_type` STRING COMMENT 'The category of device used by the player when the survey was presented. Supports device-level satisfaction analysis and optimization of survey delivery formats.. Valid values are `smartphone|tablet|PC|console|handheld|VR_headset`',
    `esrb_rating_context` STRING COMMENT 'The ESRB content rating of the game title associated with this survey response at the time of collection. Used to ensure age-appropriate survey content and to apply correct data handling rules for minors (COPPA compliance for E/E10+ rated titles).. Valid values are `E|E10+|T|M|AO|RP`',
    `followup_status` STRING COMMENT 'Current status of the player follow-up action triggered by this survey response. Pending indicates follow-up is queued; contacted indicates the player has been reached; resolved indicates the issue was addressed; no_action_required indicates the response did not warrant follow-up; opted_out indicates the player declined contact.. Valid values are `pending|contacted|resolved|no_action_required|opted_out`',
    `game_version` STRING COMMENT 'The version string of the game build the player was running when the survey was triggered (e.g., 2.4.1.build.1023). Enables correlation of satisfaction scores with specific game releases, patches, or DLC drops.',
    `gdpr_consent_recorded` BOOLEAN COMMENT 'Indicates whether explicit GDPR consent for processing this survey response and associated personal data was recorded at the time of collection (True = consent on file). Required for EU player data processing compliance.',
    `is_anonymous` BOOLEAN COMMENT 'Indicates whether the survey response was submitted anonymously (True) or linked to an identified player account (False). Anonymous responses are excluded from player-level analytics but included in aggregate community health metrics.',
    `is_opted_in_followup` BOOLEAN COMMENT 'Indicates whether the player consented to being contacted for follow-up based on their survey response (True = opted in). Used by the community management and player support teams to prioritize outreach to detractors and high-effort players.',
    `k_factor_referral_code` STRING COMMENT 'The referral or invite code associated with this survey response when the survey is part of a viral referral or K-Factor measurement program. Enables tracking of organic player advocacy and viral growth driven by promoter-segment players.',
    `moderation_flag` STRING COMMENT 'Content moderation status of the verbatim feedback field. Clean indicates no policy violations detected; flagged indicates the content has been queued for human review; reviewed indicates a moderator has assessed the content; removed indicates the content was removed for policy violation. Supports community content moderation operations.. Valid values are `clean|flagged|reviewed|removed`',
    `nps_category` STRING COMMENT 'Derived classification of the NPS respondent based on their nps_score: promoter (9–10), passive (7–8), or detractor (0–6). Populated only for NPS survey type responses. Used directly in NPS calculation and community health reporting.. Valid values are `promoter|passive|detractor`',
    `nps_score` STRING COMMENT 'The players raw NPS response on a 0–10 scale indicating likelihood to recommend the game or service to a friend or colleague. 0–6 = Detractor, 7–8 = Passive, 9–10 = Promoter. Null for non-NPS survey types.',
    `operating_system` STRING COMMENT 'The operating system of the players device at the time of survey response (e.g., iOS 17, Android 14, Windows 11, PlayStation 5 OS). Used for platform-specific quality and satisfaction analysis.',
    `platform` STRING COMMENT 'The gaming platform on which the player was active when the survey was triggered or completed. Enables platform-level satisfaction segmentation (e.g., console vs. mobile NPS comparison).. Valid values are `PC|console|mobile|web|cross_platform`',
    `player_country_code` STRING COMMENT 'The ISO 3166-1 alpha-3 three-letter country code of the players registered or detected location at the time of survey response. Enables regional satisfaction benchmarking and compliance with jurisdiction-specific data handling (GDPR, COPPA).. Valid values are `^[A-Z]{3}$`',
    `player_segment` STRING COMMENT 'The monetization or engagement segment of the player at the time of survey response. Whale indicates high-spending players; dolphin indicates mid-tier spenders; minnow indicates low spenders; f2p (Free-to-Play) indicates non-paying players. Enables satisfaction analysis by player value tier. [ENUM-REF-CANDIDATE: whale|dolphin|minnow|f2p|new_player|churned|returning — 7 candidates stripped; promote to reference product]',
    `player_tenure_days` STRING COMMENT 'The number of days since the players first recorded session at the time of survey response. Used to segment satisfaction scores by player lifecycle stage (e.g., new vs. veteran players) and correlate with D1/D7/D30 retention metrics.',
    `question_count` STRING COMMENT 'The total number of questions presented to the player in this survey instance. Used to normalize completion rates and assess survey fatigue impact on response quality.',
    `response_completion_seconds` STRING COMMENT 'The number of seconds the player took to complete the survey from first open to submission. Used to assess survey quality (very fast responses may indicate low-effort or bot submissions) and optimize survey length.',
    `response_external_ref` STRING COMMENT 'Externally-known unique identifier for this survey response as assigned by the survey platform (e.g., SurveyMonkey response ID, Qualtrics response ID, or Zendesk CSAT token). Used for cross-system reconciliation.',
    `response_language` STRING COMMENT 'The ISO 639-1 two-letter language code of the language in which the player completed the survey (e.g., en, fr, de, ja, ko). Used for localization quality analysis and multilingual NLP processing of verbatim feedback.',
    `response_status` STRING COMMENT 'Current lifecycle state of the survey response. Submitted indicates a fully completed response; partial indicates the player started but did not finish; abandoned indicates the survey was opened but no answers recorded; disqualified indicates the response was flagged as invalid; duplicate indicates a detected duplicate submission.. Valid values are `submitted|partial|abandoned|disqualified|duplicate`',
    `response_timestamp` TIMESTAMP COMMENT 'The exact date and time (UTC) when the player submitted the survey response. This is the principal business event timestamp for this transaction record.',
    `sentiment_label` STRING COMMENT 'Automated sentiment classification applied to the verbatim_feedback field by the NLP/text analytics pipeline. Indicates the overall emotional tone of the players open-ended response. Used for community health monitoring and escalation routing.. Valid values are `positive|neutral|negative|mixed`',
    `survey_sent_timestamp` TIMESTAMP COMMENT 'The date and time (UTC) when the survey invitation was dispatched to the player via the collection channel. Used to calculate response latency and optimize send-time strategies.',
    `survey_trigger_event` STRING COMMENT 'The specific in-game or system event that caused the survey to be presented to the player (e.g., session_end, level_complete, ticket_resolved, purchase_complete, ftue_complete, d7_retention_check). Enables event-level satisfaction attribution. [ENUM-REF-CANDIDATE: session_end|level_complete|ticket_resolved|purchase_complete|ftue_complete|d7_retention_check|match_end|onboarding_complete — promote to reference product]',
    `survey_type` STRING COMMENT 'Classification of the survey instrument used. NPS (Net Promoter Score) measures likelihood to recommend; CSAT (Customer Satisfaction Score) measures satisfaction with a specific interaction; CES (Customer Effort Score) measures ease of resolution; custom covers bespoke surveys; onboarding covers First-Time User Experience (FTUE) surveys; exit covers churn surveys.. Valid values are `NPS|CSAT|CES|custom|onboarding|exit`',
    `survey_version` STRING COMMENT 'The version identifier of the survey instrument used to collect this response (e.g., v1.0, v2.3). Enables longitudinal comparison of satisfaction scores across survey redesigns and question changes.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time (UTC) when this survey response record was last modified in the data platform, such as after a data quality correction or status update.',
    `verbatim_feedback` STRING COMMENT 'The players free-text open-ended response providing qualitative context for their score. May contain opinions about game quality, support experience, or community sentiment. Used for text analytics, sentiment analysis, and AI/ML topic modeling. Classified confidential as it may contain player-identifiable opinions.',
    CONSTRAINT pk_survey_response PRIMARY KEY(`survey_response_id`)
) COMMENT 'Transactional record of all player satisfaction survey responses including NPS, CSAT, and custom surveys collected after support interactions, in-game prompts, or email campaigns. Captures survey type, response scores, verbatim feedback, and collection channel.';

CREATE OR REPLACE TABLE `gaming_ecm`.`community`.`player_feedback` (
    `player_feedback_id` BIGINT COMMENT 'Unique surrogate identifier for each player feedback record in the silver layer lakehouse. Primary key for the player_feedback data product.',
    `ad_creative_id` BIGINT COMMENT 'Foreign key linking to marketing.ad_creative. Business justification: Feedback references specific ad creative (misleading ads, expectation gaps, creative quality). Real business need for ad effectiveness monitoring, creative testing validation, and identifying disconne',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Player feedback triage and resolution workflows require tracking assignment to specific product managers, designers, or engineers. Enables accountability metrics (resolution time by assignee), workloa',
    `backlog_item_id` BIGINT COMMENT 'Foreign key linking to studio.backlog_item. Business justification: Feedback-to-backlog pipeline: player feedback submissions are triaged into backlog items for feature requests or bug fixes. Core process for player-driven product roadmap and quality improvement.',
    `build_id` BIGINT COMMENT 'Internal build identifier from the CI/CD pipeline (e.g., Perforce changelist number or Jenkins build tag) corresponding to the game version active at feedback submission. Provides finer-grained traceability than the semantic version string for engineering root-cause analysis.',
    `build_submission_id` BIGINT COMMENT 'Foreign key linking to platform.build_submission. Business justification: Players report bugs against specific builds (version, platform, submission). QA teams triage feedback by build_id for regression tracking and patch prioritization. Already has build_id FK to studio.bu',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Live ops teams analyze player feedback by content drop to measure release reception, prioritize hotfixes, and inform future content roadmaps. Essential for post-launch content performance tracking and',
    `game_title_id` BIGINT COMMENT 'Reference to the game title against which the feedback was submitted. Enables per-title feedback aggregation and product team routing.',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Player feedback reporting bugs/issues with licensed game engines, middleware, or music tracks requires linking to licensed IP for vendor escalation, support ticket routing to licensors, and performanc',
    `marketing_campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Feedback often references campaign promises, promotional content, or advertised features. Linking feedback to campaigns enables measurement of expectation vs. reality gaps, ad creative effectiveness, ',
    `patch_release_id` BIGINT COMMENT 'Foreign key linking to platform.patch_release. Business justification: Players provide feedback on patch quality (performance, bugs, balance changes). QA and live ops teams aggregate feedback by patch version for hotfix prioritization and future patch planning.',
    `player_account_id` BIGINT COMMENT 'Reference to the player who submitted the feedback. Links to the player master record for identity resolution, segmentation, and cohort analysis.',
    `privacy_impact_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_impact_assessment. Business justification: Player feedback about data collection, sharing, or retention practices triggers privacy impact assessments under GDPR Article 35. Links community concerns to formal risk evaluation and mitigation for ',
    `regulatory_change_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_change. Business justification: Player feedback about loot box mechanics, data handling, or age restrictions informs impact assessments and response plans for new regulations (e.g., EU loot box restrictions). Links community sentime',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: QA triage workflow links player-reported bugs (broken textures, missing models, audio glitches) to specific assets for artist/engineer assignment. Content quality dashboards aggregate feedback-per-ass',
    `session_id` BIGINT COMMENT 'Unique identifier of the game session during which the feedback was submitted. Enables cross-referencing with session telemetry in GameAnalytics/Amplitude to reconstruct the players in-session context (session length, events, funnel stage) at the moment of feedback.',
    `content_reference` STRING COMMENT 'Identifier of the specific in-game content item (DLC, UGC, quest, event, cosmetic) the feedback relates to, if applicable. Enables content-level feedback aggregation for live-ops and content teams to assess reception of specific releases.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the players registered region at the time of feedback submission (e.g., USA, GBR, JPN, KOR). Supports regional community health analysis, PEGI/ESRB/CERO/GRAC regulatory context, and GDPR supervisory authority jurisdiction determination.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this feedback record was first written to the silver layer data product. Represents the audit creation time, distinct from the player-facing submission timestamp. Used for data lineage and pipeline monitoring.',
    `device_type` STRING COMMENT 'Broad category of the hardware device used by the player at submission time. Complements the platform field with hardware-class context for performance and UX feedback triage.. Valid values are `console|pc|mobile|handheld|vr_headset`',
    `esrb_content_flag` BOOLEAN COMMENT 'Indicates whether the feedback references content that may have ESRB rating implications (e.g., player-reported inappropriate content, loot box mechanics, or violence concerns). Flagged records are routed to the compliance team for ESRB/PEGI regulatory review.',
    `feedback_body` STRING COMMENT 'The full unstructured text of the players feedback submission. Contains the players verbatim input describing their experience, issue, or suggestion. Subject to content moderation and PII scrubbing before use in analytics. Classified confidential due to potential inclusion of personal expressions and opinions.',
    `feedback_category` STRING COMMENT 'Primary classification of the feedback topic as selected by the player or auto-classified at submission. Drives routing to the appropriate product, engineering, or live-ops team. Values: gameplay (mechanics, controls, balance), ui (interface, UX), performance (FPS, latency, crashes), content (story, levels, DLC), monetization (MTX, IAP, pricing), other.. Valid values are `gameplay|ui|performance|content|monetization|other`',
    `feedback_reference_number` STRING COMMENT 'Human-readable, externally visible reference number assigned to the feedback submission. Used by community managers and player support agents to reference a specific submission in communications. Sourced from the in-game feedback tool or community portal at submission time.. Valid values are `^FB-[0-9]{8,12}$`',
    `feedback_status` STRING COMMENT 'Current workflow lifecycle state of the feedback record. Tracks progression from initial submission through triage, actioning, and closure by community or product teams. [ENUM-REF-CANDIDATE: submitted|under_review|actioned|closed|duplicate|rejected — promote to reference product]. Valid values are `submitted|under_review|actioned|closed|duplicate|rejected`',
    `feedback_subcategory` STRING COMMENT 'Secondary classification providing granular topic detail within the primary feedback category (e.g., matchmaking under gameplay, loot_box_pricing under monetization, menu_navigation under ui). Populated from a controlled taxonomy maintained by the community team. [ENUM-REF-CANDIDATE: promote to reference product — values vary by category]',
    `feedback_title` STRING COMMENT 'Short, player-provided or auto-generated title summarising the feedback submission. Used in community portal listings, moderation queues, and reporting dashboards for quick identification without reading the full body text.',
    `game_mode` STRING COMMENT 'The game mode the player was engaged in when the feedback was submitted (e.g., PvP, PvE, co-op, single player, MMO, ranked). Enables mode-specific feedback analysis to identify issues isolated to particular play contexts. [ENUM-REF-CANDIDATE: pvp|pve|co_op|single_player|mmo|battle_royale|ranked|casual|tutorial — promote to reference product]',
    `game_version` STRING COMMENT 'The semantic version string of the game build active at the time of feedback submission (e.g., 2.4.1.1023). Enables engineering teams to correlate feedback spikes with specific releases, hotfixes, or patches. Sourced from the game client at submission time.. Valid values are `^[0-9]+.[0-9]+.[0-9]+(.[0-9]+)?$`',
    `is_beta_participant` BOOLEAN COMMENT 'Indicates whether the feedback was submitted by a player participating in a beta or soft launch programme. Beta feedback is typically weighted differently in product prioritisation and is subject to separate NDA and data handling policies.',
    `is_moderated` BOOLEAN COMMENT 'Indicates whether the feedback body text has been reviewed by a community moderator or automated moderation system. Unmoderated feedback should not be surfaced in public-facing community portals or shared externally.',
    `is_paying_player` BOOLEAN COMMENT 'Indicates whether the player had made at least one IAP or MTX purchase prior to submitting the feedback. Enables differentiation of paying vs. F2P player feedback, particularly relevant for monetisation category feedback analysis.',
    `jira_issue_key` STRING COMMENT 'Reference to the Jira issue (bug, story, or task) created as a result of this feedback, if actioned by the product or engineering team. Enables traceability from player feedback to development backlog items and sprint planning.. Valid values are `^[A-Z]+-[0-9]+$`',
    `language_code` STRING COMMENT 'IETF BCP 47 language tag of the feedback body text (e.g., en-US, fr-FR, ja-JP, ko-KR). Enables language-specific routing to localised community teams and supports multilingual NLP model selection for sentiment analysis.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `map_or_level_name` STRING COMMENT 'The name of the in-game map, level, zone, or area the player was in when the feedback was submitted. Enables spatial correlation of feedback to specific content areas, supporting level design and QA triage.',
    `moderation_outcome` STRING COMMENT 'Result of the content moderation review for this feedback submission. Approved records are safe for internal analytics and community reporting. Flagged or removed records indicate policy violations. Escalated records require senior review or legal assessment.. Valid values are `approved|flagged|removed|escalated|pending`',
    `moderation_reason` STRING COMMENT 'Free-text or coded reason provided by the moderator or automated system explaining the moderation outcome (e.g., contains PII, hate speech, spam, off-topic). Required for audit trail and appeals processing.',
    `operating_system` STRING COMMENT 'Operating system name and version reported by the players device at feedback submission (e.g., Windows 11 23H2, iOS 17.4, Android 14). Critical for PC and mobile platform bug triage and compatibility analysis.',
    `pii_detected` BOOLEAN COMMENT 'Indicates whether the automated PII detection pipeline identified personally identifiable information within the feedback body text. When true, the feedback_body field must be treated as restricted and the PII scrubbed before downstream use. Supports GDPR and COPPA compliance.',
    `platform` STRING COMMENT 'The gaming platform on which the player was playing when the feedback was submitted (e.g., PC, PS5, Xbox Series X, Nintendo Switch, iOS, Android, VR). Critical for platform-specific bug triage, TRC/TCR compliance tracking, and platform-level sentiment analysis. [ENUM-REF-CANDIDATE: pc|ps5|ps4|xbox_series|xbox_one|nintendo_switch|ios|android|vr — promote to reference product]',
    `player_account_age_days` STRING COMMENT 'Number of days since the players account was created at the time of feedback submission. Enables segmentation of feedback by player tenure (new vs. veteran players), supporting FTUE analysis and long-term retention insights.',
    `player_rating` BOOLEAN COMMENT 'Optional numeric rating (1–5) provided by the player alongside their feedback, representing their overall satisfaction with the specific feature or experience being commented on. Distinct from NPS/CSAT scores which are survey-driven; this is feature-specific and submission-attached.',
    `player_segment` STRING COMMENT 'Behavioural or monetisation segment of the player at the time of feedback submission (e.g., new player, casual, core, hardcore, whale, lapsed, returning). Enables segment-level feedback analysis to understand how different player cohorts perceive the game. [ENUM-REF-CANDIDATE: new_player|casual|core|hardcore|whale|lapsed|returning — promote to reference product]',
    `priority_level` STRING COMMENT 'Triage priority assigned to the feedback by community managers or automated scoring, indicating urgency for product team review. Critical priority feedback (e.g., game-breaking bugs, safety concerns) triggers immediate escalation workflows.. Valid values are `critical|high|medium|low`',
    `sentiment_classification` STRING COMMENT 'Sentiment label assigned to the feedback body text, either by an NLP model or manual review. Used to track community health trends, identify emerging negative sentiment spikes, and measure the impact of live-ops changes on player satisfaction. Distinct from NPS/CSAT scores.. Valid values are `positive|neutral|negative|mixed`',
    `sentiment_confidence_score` DECIMAL(18,2) COMMENT 'Probability score (0.0000–1.0000) representing the NLP models confidence in the assigned sentiment classification. Scores below a defined threshold flag the record for manual review. Supports model performance monitoring and quality assurance of automated classification.',
    `session_length_seconds` STRING COMMENT 'Duration in seconds of the game session at the point the feedback was submitted. Provides context on whether feedback was submitted early (FTUE friction) or late in a session (deep gameplay issues). Sourced from the game client session context.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this feedback record was ingested into the silver layer (e.g., in-game SDK, community portal CMS, Zendesk, GameAnalytics, Amplitude). Supports data lineage tracking and ETL pipeline monitoring.. Valid values are `in_game_sdk|community_portal|zendesk|gameanalytics|amplitude|manual_entry`',
    `submission_channel` STRING COMMENT 'The interface or channel through which the player submitted the feedback. Enables channel-level analysis of feedback volume and quality. In-game tool submissions are typically contextually richer (session data attached); community portal submissions may be more deliberate. [ENUM-REF-CANDIDATE: in_game_tool|community_portal|beta_channel|playtesting|support_ticket|social_media — promote to reference product]. Valid values are `in_game_tool|community_portal|beta_channel|playtesting|support_ticket|social_media`',
    `submitted_timestamp` TIMESTAMP COMMENT 'The precise date and time (ISO 8601 with timezone offset) at which the player submitted the feedback. This is the principal business event timestamp — distinct from ETL ingestion time. Critical for time-series analysis, D1/D7/D30 retention correlation, and live-ops response SLA measurement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this feedback record, including status changes, moderation actions, or enrichment updates. Supports incremental processing and audit trail requirements.',
    `upvote_count` STRING COMMENT 'Number of upvotes or me too endorsements received from other community members on this feedback submission via the community portal. High upvote counts signal widespread player concern and elevate the feedbacks priority for product teams.',
    `zendesk_ticket_code` STRING COMMENT 'Reference to the associated Zendesk support ticket if the feedback was escalated to or originated from the player support system. Enables cross-referencing between community feedback and formal support cases for holistic player care analysis.',
    CONSTRAINT pk_player_feedback PRIMARY KEY(`player_feedback_id`)
) COMMENT 'Transactional record of structured and unstructured player feedback submitted through in-game feedback tools, community portals, and beta/playtesting channels. Captures player reference, game title reference, feedback category (gameplay/UI/performance/content/monetization/other), sentiment classification, feedback body text, platform, game version, session context, submission channel, and timestamp. Distinct from NPS/CSAT as it is unsolicited or feature-specific feedback.';

CREATE OR REPLACE TABLE `gaming_ecm`.`community`.`viral_referral` (
    `viral_referral_id` BIGINT COMMENT 'Unique surrogate identifier for each player-to-player referral event record. Primary key for the viral_referral data product. Entity role: TRANSACTION_HEADER — discrete referral lifecycle event with its own status funnel, timestamps, and reward state.',
    `promo_code_id` BIGINT COMMENT 'Foreign key linking to billing.promo_code. Business justification: Referral codes are promotional codes requiring direct linkage for redemption tracking, discount application, referrer reward calculation, and viral marketing campaign performance measurement across re',
    `game_title_id` BIGINT COMMENT 'Identifier of the game title for which this referral was generated. Enables K-Factor and referral conversion analysis segmented by game title.',
    `marketing_campaign_id` BIGINT COMMENT 'Identifier of the marketing or in-game referral campaign under which this referral was generated. Links to campaign master for ROI measurement and reward program configuration.',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: Referral reward eligibility verification requires linking to referred players first payment to confirm conversion, trigger referrer rewards, and calculate customer acquisition cost per referral progr',
    `player_account_id` BIGINT COMMENT 'Identifier of the player who initiated the referral (the referrer). Used to attribute K-Factor viral coefficient contributions and calculate referral program ROI per player. Maps to the player master entity. PARTY_REFERENCE (referrer side).',
    `attribution_confidence_score` DECIMAL(18,2) COMMENT 'A probabilistic score between 0.0000 and 1.0000 representing the attribution providers confidence that this referral is correctly attributed to the referring player (e.g., based on device fingerprint match strength). Used to weight K-Factor calculations and filter low-confidence attributions.',
    `attribution_provider` STRING COMMENT 'The mobile measurement partner (MMP) or internal system that attributed this referral event. Identifies the source of attribution data for auditability and cross-provider reconciliation. [ENUM-REF-CANDIDATE: appsflyer|adjust|internal|branch|singular — promote to reference product if providers expand]. Valid values are `appsflyer|adjust|internal|branch|singular`',
    `clicked_timestamp` TIMESTAMP COMMENT 'The date and time when the referred player first clicked the referral link or entered the friend code. Null if the referral has not yet been clicked. Used to compute click-through latency and CTR (Click-Through Rate) for referral campaigns.',
    `converted_timestamp` TIMESTAMP COMMENT 'The date and time when the referred player completed the qualifying conversion action (e.g., first purchase, first match played, reaching a level threshold) as defined by the referral campaign. Null if conversion has not occurred. Used for days-to-conversion calculation and referral ROI measurement.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code of the referred players geographic location at the time of install or registration. Used for geo-segmented K-Factor analysis, regional campaign performance, and GDPR/COPPA jurisdictional compliance determination.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this referral record was first created in the data platform (Silver Layer ingestion timestamp). RECORD_AUDIT_CREATED — distinct from the business event timestamp (sent_timestamp). Used for data lineage, SLA monitoring, and audit trail compliance.',
    `days_to_conversion` STRING COMMENT 'Number of calendar days elapsed between the referral sent date and the conversion event date. Null if conversion has not occurred. Used to benchmark referral program velocity and optimize campaign reward timing windows.',
    `device_type` STRING COMMENT 'The device category used by the referred player at the time of install or registration. Used for device-level referral conversion analysis and platform-specific campaign optimization.. Valid values are `smartphone|tablet|pc|console|smart_tv`',
    `first_iap_flag` BOOLEAN COMMENT 'Indicates whether the referred player made their first In-App Purchase (IAP) within the attribution window of this referral. True = first IAP made; False = no IAP made. Used to measure referral-to-payer conversion rate and ARPPU (Average Revenue Per Paying User) impact of referral programs.',
    `fraud_flag` BOOLEAN COMMENT 'Indicates whether this referral event has been flagged as potentially fraudulent (e.g., self-referral, bot-generated install, duplicate device fingerprint). True = flagged for fraud review; False = clean. Fraudulent referrals are excluded from K-Factor calculations and reward payouts.',
    `fraud_reason` STRING COMMENT 'The specific reason code assigned when a referral is flagged as fraudulent. Null or none for clean referrals. Used by the trust and safety team to categorize fraud patterns and refine detection rules. [ENUM-REF-CANDIDATE: self_referral|duplicate_device|bot_install|vpn_detected|velocity_abuse|none — promote to reference product if reasons expand]. Valid values are `self_referral|duplicate_device|bot_install|vpn_detected|velocity_abuse|none`',
    `ftue_completed_flag` BOOLEAN COMMENT 'Indicates whether the referred player completed the First-Time User Experience (FTUE) onboarding flow after install. True = FTUE completed; False = FTUE not completed. Used to measure onboarding quality for referred cohorts and identify drop-off points in the referral-to-engagement funnel.',
    `installed_timestamp` TIMESTAMP COMMENT 'The date and time when the referred player completed the game installation attributed to this referral. Null if install has not occurred. Used to compute install latency and CPI (Cost Per Install) attribution for organic referral channels.',
    `k_factor_contribution` DECIMAL(18,2) COMMENT 'The fractional K-Factor (viral coefficient) contribution of this individual referral event, calculated as the conversion indicator (1 if converted, 0 otherwise) divided by the total invites sent by the referring player in the same campaign window. Aggregated across all referrals to compute the overall K-Factor for the game title and campaign.',
    `notes` STRING COMMENT 'Free-text field for operational notes or manual annotations added by the community management or trust and safety team regarding this referral event (e.g., manual fraud review outcome, exception handling notes).',
    `platform` STRING COMMENT 'The gaming platform on which the referred player installed and/or converted. Enables cross-platform K-Factor analysis and platform-specific referral program optimization. [ENUM-REF-CANDIDATE: PC|console|mobile_ios|mobile_android|console_playstation|console_xbox|console_nintendo — promote to reference product if platforms expand]',
    `referral_channel` STRING COMMENT 'The distribution channel through which the referral was sent or shared. Drives channel-level K-Factor decomposition and informs which acquisition channels generate the highest organic growth. [ENUM-REF-CANDIDATE: invite_link|social_share|friend_code|in_game_invite|email_invite|push_notification — promote to reference product if channels expand]. Valid values are `invite_link|social_share|friend_code|in_game_invite|email_invite|push_notification`',
    `referral_code` STRING COMMENT 'The unique alphanumeric friend-code or invite-code string shared by the referring player to recruit the referred player. Used as the BUSINESS_IDENTIFIER for this referral event and as the lookup key for attribution matching in AppsFlyer/Adjust.. Valid values are `^[A-Z0-9]{6,20}$`',
    `referral_expiry_date` DATE COMMENT 'The date on which this referral invite expires and is no longer eligible for conversion credit or reward payout. Null for referrals with no expiry. Used to enforce campaign time-boxing and clean up stale referral records.',
    `referral_source_url` STRING COMMENT 'The deep-link or tracking URL through which the referral was delivered (e.g., invite link shared on social media or in-game). Used by AppsFlyer/Adjust for attribution matching and channel source verification. May be null for friend-code or in-game-invite channels.',
    `referral_status` STRING COMMENT 'Current stage of the referral in the conversion funnel: sent (invite dispatched), clicked (link opened), installed (game installed), registered (account created), converted (qualifying in-game action completed). LIFECYCLE_STATUS for the TRANSACTION_HEADER role. Drives funnel drop-off analytics and K-Factor computation.. Valid values are `sent|clicked|installed|registered|converted`',
    `referred_player_d30_retained` BOOLEAN COMMENT 'Indicates whether the referred player was still active in the game 30 days after their first session (D30 retention). True = retained at D30; False = churned before D30; Null = D30 window not yet elapsed. Used to evaluate the long-term quality of referred player cohorts and referral program LTV impact.',
    `referred_player_d7_retained` BOOLEAN COMMENT 'Indicates whether the referred player was still active in the game 7 days after their first session (D7 retention). True = retained at D7; False = churned before D7; Null = D7 window not yet elapsed. Key metric for assessing referral quality and long-term LTV (Lifetime Value) of referred cohorts.',
    `referred_player_is_new` BOOLEAN COMMENT 'Indicates whether the referred player was a genuinely new account at the time of referral attribution (True) or an existing player who re-engaged via a referral link (False). Critical for fraud prevention, reward eligibility validation, and accurate K-Factor computation.',
    `registered_timestamp` TIMESTAMP COMMENT 'The date and time when the referred player completed account registration attributed to this referral. Null if registration has not occurred. Key milestone for funnel conversion rate analysis.',
    `reward_claimed_flag` BOOLEAN COMMENT 'Indicates whether the referring player has claimed the reward associated with this eligible referral. True = reward claimed; False = reward not yet claimed. Used to track reward redemption rates and outstanding reward liabilities.',
    `reward_claimed_timestamp` TIMESTAMP COMMENT 'The date and time when the referring player claimed or was granted the referral reward. Null if reward has not been claimed. Used for reward fulfillment SLA tracking and financial accrual timing.',
    `reward_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the reward value when the reward is denominated in fiat currency (e.g., USD, EUR, GBP). Null or a game-specific virtual currency code (e.g., GEMS, COINS) for virtual currency rewards. Required for financial reporting and PCI DSS compliance.. Valid values are `^[A-Z]{3}$`',
    `reward_eligible_flag` BOOLEAN COMMENT 'Indicates whether this referral event qualifies for a reward payout to the referring player based on campaign eligibility rules (e.g., referred player must be a new account, must convert within the campaign window). True = eligible; False = not eligible.',
    `reward_type` STRING COMMENT 'The category of reward granted to the referring player upon successful referral conversion. Drives reward fulfillment routing and in-game economy impact analysis. [ENUM-REF-CANDIDATE: virtual_currency|premium_item|dlc_unlock|subscription_days|real_money — promote to reference product if reward types expand]. Valid values are `virtual_currency|premium_item|dlc_unlock|subscription_days|real_money`',
    `reward_value` DECIMAL(18,2) COMMENT 'The quantity or monetary value of the reward granted for this referral. For virtual currency rewards, this is the number of in-game currency units. For real-money rewards, this is the fiat amount in the campaigns base currency. Used for referral program cost accounting and ROI measurement.',
    `sent_timestamp` TIMESTAMP COMMENT 'The date and time when the referral invite was dispatched by the referring player. BUSINESS_EVENT_TIMESTAMP — the principal real-world event time marking the start of the referral lifecycle. Stored in ISO 8601 format with timezone offset.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this referral record was last modified in the data platform (e.g., status funnel progression, reward claim update). RECORD_AUDIT_UPDATED — used for incremental ETL processing, change data capture, and audit trail compliance.',
    `utm_campaign` STRING COMMENT 'The UTM campaign parameter captured from the referral tracking URL, identifying the specific campaign name or code. Enables campaign-level referral conversion and ROI analysis.',
    `utm_medium` STRING COMMENT 'The UTM medium parameter captured from the referral tracking URL, identifying the marketing medium (e.g., social, referral, in-game). Complements utm_source for multi-dimensional attribution analysis.',
    `utm_source` STRING COMMENT 'The UTM source parameter captured from the referral tracking URL, identifying the originating platform or network (e.g., twitter, discord, facebook). Used for marketing attribution and channel-level referral performance reporting.',
    CONSTRAINT pk_viral_referral PRIMARY KEY(`viral_referral_id`)
) COMMENT 'Transactional record of player-to-player referral events used to compute K-Factor (viral coefficient) and measure organic community growth. Tracks referring player reference, referred player reference, referral channel (invite-link/social-share/friend-code/in-game-invite), game title reference, referral campaign reference, referral status funnel (sent/clicked/installed/registered/converted), days-to-conversion, conversion timestamp, reward eligibility flag, reward claimed flag, and referred player retention flag at D7/D30. SSOT for viral growth analytics and referral program ROI measurement.';

CREATE OR REPLACE TABLE `gaming_ecm`.`community`.`chat_session` (
    `chat_session_id` BIGINT COMMENT 'Unique surrogate identifier for each live chat support session record in the Zendesk Chat platform. Primary key for the chat_session data product.',
    `age_verification_event_id` BIGINT COMMENT 'Foreign key linking to compliance.age_verification_event. Business justification: Live chat support agents verify player age when discussing age-restricted content, purchases, or COPPA-protected data. Links support interaction to formal age verification audit trail required for reg',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Live chat support is a cost center function. Tracking which cost center handled each session enables accurate support cost allocation by game title or region, cost-per-contact metrics, and workforce p',
    `employee_id` BIGINT COMMENT 'Reference to the human support agent who handled or was assigned to the chat session. Null when the session was fully handled by a bot without human escalation.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title that provides context for the support session. Identifies which game the player was seeking help with, enabling per-title support volume and quality analytics.',
    `iap_transaction_id` BIGINT COMMENT 'Foreign key linking to monetization.iap_transaction. Business justification: Real-time purchase support via live chat resolves transaction issues immediately (payment failures, missing items, receipt verification). Chat agents need transaction context to process refunds, verif',
    `marketing_campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Live chat sessions spike during campaign launches (promo code issues, event questions, new feature support). Campaign attribution enables support capacity planning, campaign quality monitoring, and me',
    `player_account_id` BIGINT COMMENT 'Reference to the player who initiated the chat support session. Links to the player master record for identity resolution and player-level analytics.',
    `player_subscription_id` BIGINT COMMENT 'Foreign key linking to monetization.player_subscription. Business justification: Subscription billing inquiries handled via live chat (cancellation requests, payment method updates, billing cycle questions). Chat sessions need subscription context to verify status, process cancell',
    `support_ticket_id` BIGINT COMMENT 'Reference to the associated Zendesk support ticket created from or linked to this chat session. Enables cross-referencing between chat sessions and the broader ticket lifecycle.',
    `agent_team` STRING COMMENT 'The support team or group to which the handling agent belongs (e.g., Tier 1 General, Tier 2 Technical, VIP Concierge, Esports Player Support). Enables team-level performance benchmarking and workload distribution analysis.',
    `channel` STRING COMMENT 'The interface channel through which the player initiated the chat session. Distinguishes between web-widget (browser-based support portal), in-game (native in-game chat overlay), mobile_app (mobile support UI), and sdk_embedded (SDK-integrated chat within game client).. Valid values are `web_widget|in_game|mobile_app|sdk_embedded`',
    `coppa_minor_flag` BOOLEAN COMMENT 'Indicates whether the player associated with this chat session is identified as a minor (under 13 in the US, under 16 in the EU) subject to Childrens Online Privacy Protection Act (COPPA) or GDPR child data protections. True = minor player; False = adult player. Triggers special handling protocols for transcript retention, data access, and parental consent verification.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this chat session record was first captured and written to the data platform. Serves as the audit creation timestamp for data lineage and Silver layer ingestion tracking.',
    `csat_comment` STRING COMMENT 'Free-text qualitative feedback provided by the player alongside the CSAT score in the post-chat survey. Contains player sentiment and specific feedback about the support experience. Classified confidential due to potentially sensitive player-expressed content.',
    `csat_score` STRING COMMENT 'The Customer Satisfaction (CSAT) score provided by the player following the chat session, typically on a 1–5 scale (or binary Good/Bad mapped to 1/0). Null if the player did not respond to the post-chat survey. Core KPI for player support quality measurement.',
    `csat_survey_sent` BOOLEAN COMMENT 'Indicates whether a post-chat CSAT survey was sent to the player after session close. True = survey dispatched; False = survey not sent (e.g., session abandoned, player opted out, bot-only session below threshold). Enables accurate CSAT response rate calculation.',
    `escalation_reason` STRING COMMENT 'The reason the chat session was escalated from bot to human agent. Populated only when is_escalated_to_human is True. Enables root cause analysis of bot failure modes and escalation pattern optimization.. Valid values are `player_request|bot_failure|complexity|policy_exception|vip_player|unresolved_loop`',
    `first_response_time_seconds` STRING COMMENT 'The number of seconds elapsed from when the session was assigned to an agent or bot until the first message was sent to the player. Distinct from wait_time_seconds which measures queue time; this measures agent responsiveness after assignment.',
    `gdpr_data_subject_request` BOOLEAN COMMENT 'Indicates whether this chat session is associated with or triggered by a GDPR data subject request (e.g., right of access, right to erasure, data portability). True = session is linked to a DSR; False = standard support session. Enables compliance workflow tracking and audit trail for GDPR supervisory authority reporting.',
    `handle_time_seconds` STRING COMMENT 'The total number of seconds from first agent/bot response to session close. Represents the active engagement duration and is a primary operational efficiency KPI for the player support team.',
    `is_bot_handled` BOOLEAN COMMENT 'Indicates whether the chat session was fully handled by an automated bot (chatbot/virtual agent) without any human agent involvement. True = bot-only session; False = human agent was involved at some point. Key metric for bot deflection rate reporting.',
    `is_escalated_to_human` BOOLEAN COMMENT 'Indicates whether the chat session was escalated from a bot or initial automated routing to a live human support agent. True = escalation occurred; False = no escalation. Used to measure bot containment rate and escalation triggers.',
    `is_first_contact` BOOLEAN COMMENT 'Indicates whether this chat session represents the players first-ever contact with player support. True = first contact; False = returning contact. Used to measure First-Time User Experience (FTUE) support rates and new player onboarding friction.',
    `is_repeat_contact` BOOLEAN COMMENT 'Indicates whether the player contacted support again for the same issue within a defined lookback window (typically 7 days), signaling an unresolved prior interaction. True = repeat contact on same issue; False = new or unrelated contact. Key metric for First Contact Resolution (FCR) quality measurement.',
    `issue_category` STRING COMMENT 'The primary category of the players support issue as classified by the agent or automated tagging system. Examples include account_access, billing, gameplay_bug, in_game_purchase, ban_appeal, technical_performance. [ENUM-REF-CANDIDATE: account_access|billing|gameplay_bug|in_game_purchase|ban_appeal|technical_performance|content_report|other — promote to reference product]',
    `issue_subcategory` STRING COMMENT 'The secondary classification of the players support issue, providing granular detail beneath issue_category. For example, under billing: refund_request, charge_dispute, subscription_cancellation. Enables detailed support trend analysis and knowledge base optimization.',
    `message_count` STRING COMMENT 'Total number of messages exchanged (both player and agent/bot) during the chat session. Indicates session complexity and engagement depth; used in workload analysis and bot deflection effectiveness measurement.',
    `pci_sensitive_data_shared` BOOLEAN COMMENT 'Indicates whether the player shared or attempted to share payment card or PCI-sensitive data during the chat session. True = PCI-sensitive data detected in transcript; False = no PCI data detected. Triggers mandatory transcript masking, security review, and PCI DSS compliance escalation procedures.',
    `platform` STRING COMMENT 'The gaming or device platform from which the player initiated the chat session. Enables platform-specific support volume analysis and agent routing optimization. [ENUM-REF-CANDIDATE: PC|console_playstation|console_xbox|console_nintendo|mobile_ios|mobile_android|web — promote to reference product]',
    `player_account_age_days` STRING COMMENT 'The age of the players account in days at the time the chat session was initiated. Enables segmentation of support contacts by player tenure (e.g., new player FTUE issues vs. veteran player issues) and informs retention risk analysis.',
    `player_locale` STRING COMMENT 'The locale code (IETF BCP 47 format, e.g., en_US, fr_FR, de_DE, ja_JP) of the player at the time of the chat session. Drives language routing, localization of support responses, and regional support volume analysis.. Valid values are `^[a-z]{2}_[A-Z]{2}$`',
    `player_segment` STRING COMMENT 'The monetization segment of the player at the time of the chat session, derived from spending behavior. whale = high-spending player; dolphin = moderate spender; minnow = low spender; f2p_non_payer = Free-to-Play (F2P) non-paying; lapsed = previously active, now inactive; new = recently acquired. Enables prioritized support routing and VIP handling.. Valid values are `whale|dolphin|minnow|f2p_non_payer|lapsed|new`',
    `queue_name` STRING COMMENT 'The name of the Zendesk Chat department or routing queue to which the session was assigned. Examples: Billing Support, Technical Support, VIP Player Care, Ban Appeals. Enables queue-level performance analysis and staffing optimization.',
    `resolution_status` STRING COMMENT 'The outcome resolution state of the chat session at close. resolved = issue addressed to completion; unresolved = issue not resolved during session; follow_up_required = agent flagged need for further action; transferred = session handed off to another channel or team.. Valid values are `resolved|unresolved|follow_up_required|transferred`',
    `satisfaction_rating` STRING COMMENT 'The binary satisfaction rating as recorded in Zendesks native Good/Bad CSAT system, distinct from the numeric csat_score. good = positive rating; bad = negative rating; unoffered = survey not offered. Aligns with Zendesks native satisfaction_rating field for source system reconciliation.. Valid values are `good|bad|unoffered`',
    `session_date` DATE COMMENT 'The calendar date (yyyy-MM-dd) on which the chat session was initiated. Derived from session_start_timestamp for partitioning, daily reporting, and date-grain analytics without requiring timestamp parsing. Used as the Databricks Silver layer partition key.',
    `session_end_timestamp` TIMESTAMP COMMENT 'The exact date and time when the chat session was closed, resolved, or abandoned. Null if the session is still active. Used in conjunction with session_start_timestamp to derive handle time.',
    `session_key` STRING COMMENT 'Externally-known alphanumeric identifier for the chat session as assigned by Zendesk Chat. Used for cross-system referencing, audit trails, and player-facing session references.',
    `session_start_timestamp` TIMESTAMP COMMENT 'The exact date and time (ISO 8601 with timezone offset) when the player initiated the chat session and entered the support queue. This is the principal business event timestamp for the session lifecycle.',
    `session_status` STRING COMMENT 'Current lifecycle state of the chat session. open = session initiated and in queue; active = agent/bot engaged; waiting = awaiting player response; resolved = session closed with resolution; abandoned = player left before resolution; missed = no agent available.. Valid values are `open|active|waiting|resolved|abandoned|missed`',
    `source_system` STRING COMMENT 'Identifies the originating operational system that generated this chat session record. Enables data lineage tracking and multi-source reconciliation in the Silver layer. zendesk_chat = Zendesk Chat platform; in_game_sdk = in-game SDK chat integration; mobile_sdk = mobile SDK chat integration.. Valid values are `zendesk_chat|in_game_sdk|mobile_sdk`',
    `tags` STRING COMMENT 'Comma-separated list of operational tags applied to the chat session in Zendesk by agents or automated rules (e.g., ban_appeal,high_priority,vip). Supports flexible categorization, reporting filters, and workflow automation triggers beyond the structured issue_category field.',
    `transcript_reference` STRING COMMENT 'Reference key or storage path pointing to the full chat transcript stored in the secure transcript repository (e.g., cloud object storage path or Zendesk transcript ID). The transcript itself is not stored inline; this field enables retrieval for QA, compliance, and dispute resolution.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this chat session record was last modified in the data platform, reflecting any updates from Zendesk (e.g., CSAT score received post-session, status change). Supports incremental load and change detection.',
    `wait_time_seconds` STRING COMMENT 'The number of seconds the player waited in the support queue from session initiation until an agent or bot first responded. Key metric for queue performance, staffing adequacy, and player experience benchmarking.',
    CONSTRAINT pk_chat_session PRIMARY KEY(`chat_session_id`)
) COMMENT 'Transactional record of live chat support sessions initiated by players through Zendesk Chat or in-game chat support. Captures player reference, agent reference, session channel (web-widget/in-game/mobile), game title context, session start/end timestamps, wait time, handle time, chat transcript reference, CSAT score, bot-handled flag, escalation-to-human flag, and session resolution status.';

CREATE OR REPLACE TABLE `gaming_ecm`.`community`.`community_event` (
    `community_event_id` BIGINT COMMENT 'Unique surrogate identifier for the community event record. Primary key for the community_event data product in the Silver Layer lakehouse.',
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Community events with prizes, monetization, or user-generated content require age rating certification to comply with platform policies and rating authority requirements. Ensures event eligibility ali',
    `battle_pass_id` BIGINT COMMENT 'Foreign key linking to monetization.battle_pass. Business justification: Community events promote battle pass engagement (season launch events, tier unlock challenges, reward showcases). Events tied to passes for cross-promotion tracking, participation measurement, and con',
    `promo_code_id` BIGINT COMMENT 'Foreign key linking to billing.promo_code. Business justification: Community events frequently offer exclusive promotional codes to participants for in-game purchases, requiring direct linkage for redemption tracking, attribution analysis, and event ROI measurement.',
    `brand_partnership_id` BIGINT COMMENT 'Foreign key linking to licensing.brand_partnership. Business justification: Community events (tournaments, creator contests, live streams) with brand sponsors require linking to brand partnership for co-marketing obligation tracking, brand usage approval workflows, and revenu',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Marketing and live ops coordinate community events (contests, challenges) with content releases for launch amplification. Event planning requires linking to content calendar for timing coordination an',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Community events incur costs (prizes, infrastructure, moderation, marketing). Tracking cost center enables budget vs. actual tracking, expense allocation to marketing or community operations, and ROI ',
    `employee_id` BIGINT COMMENT 'Reference to the entity (player, community manager, studio, or esports team) responsible for organizing and running this community event.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Community events are planned marketing activities with allocated budgets. Direct link to budget enables real-time budget vs. actual tracking, variance analysis, and spend control for community marketi',
    `game_mode_id` BIGINT COMMENT 'Foreign key linking to title.game_mode. Business justification: Community events (tournaments, limited-time challenges) target specific game modes (e.g., Battle Royale tournament, Capture-the-Flag challenge). Tracking which mode an event uses is required for event',
    `game_title_id` BIGINT COMMENT 'Reference to the game title associated with this community event. Links the event to the specific game or franchise it belongs to.',
    `influencer_id` BIGINT COMMENT 'Foreign key linking to marketing.influencer. Business justification: Influencers host or participate in community events (tournaments, creator showcases, charity streams). Direct link enables influencer campaign ROI tracking, engagement measurement, and contractual del',
    `marketing_campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Community events (tournaments, creator showcases, seasonal festivals) are marketing campaigns or closely tied to them. Direct link enables event marketing ROI tracking, budget allocation, and cross-ch',
    `parent_event_community_event_id` BIGINT COMMENT 'Self-referencing identifier linking this event to its parent event in a series or campaign hierarchy (e.g., a weekly challenge belonging to a seasonal campaign). Null for top-level events.',
    `seasonal_event_id` BIGINT COMMENT 'Foreign key linking to content.seasonal_event. Business justification: Event planning and execution requires linking community-driven activities (fan art contests, cosplay competitions) to seasonal event calendar for coordination and unified reporting. Enables nested eve',
    `release_schedule_id` BIGINT COMMENT 'Foreign key linking to platform.release_schedule. Business justification: Launch events, tournaments, and content drops are coordinated with release schedules. Marketing and community teams need to sync event timing with platform approval dates, embargo lifts, and preorder ',
    `storefront_id` BIGINT COMMENT 'Reference to the gaming platform (console, PC, mobile) on which this community event is hosted or accessible.',
    `storefront_order_id` BIGINT COMMENT 'Foreign key linking to billing.storefront_order. Business justification: Event-driven purchases like tournament entry fees, exclusive bundles, or ticketed events require linking orders to events for revenue attribution, event profitability analysis, and participant verific',
    `title_season_id` BIGINT COMMENT 'Foreign key linking to title.title_season. Business justification: Community events (tournaments, challenges, contests) are scheduled within title seasons in live-service games. Linking events to seasons enables seasonal event planning, rewards distribution tied to b',
    `cancellation_reason` STRING COMMENT 'Textual explanation for why the community event was cancelled or postponed. Populated only when event_status is cancelled or postponed. Used for post-mortem analysis and player communication.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this community event record was first created in the system. Audit trail field for data lineage and governance.',
    `csat_score` DECIMAL(18,2) COMMENT 'The Customer Satisfaction Score (CSAT) collected from participants after the community event, typically on a 1-5 scale. Measures overall satisfaction with the event experience. Sourced from Zendesk post-event surveys.',
    `eligibility_criteria` STRING COMMENT 'Textual description of the requirements a player must meet to participate in the event (e.g., minimum account level, geographic restrictions, age requirements, game ownership). Supports COPPA and GDPR compliance for age-gated events.',
    `end_timestamp` TIMESTAMP COMMENT 'The exact date and time (with timezone offset) when the community event officially closes and participation is no longer accepted.',
    `event_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the community event, used in marketing materials, URLs, and cross-system references (e.g., CE-SUMFAN24).. Valid values are `^CE-[A-Z0-9]{6,12}$`',
    `event_description` STRING COMMENT 'Full narrative description of the community event including objectives, rules, theme, and any special instructions for participants. Displayed on community portals and in-game event hubs.',
    `event_name` STRING COMMENT 'Official display name of the community event as shown to players and community members (e.g., Summer Fan Art Contest 2024, Developer AMA — Season 5 Launch).',
    `event_status` STRING COMMENT 'Current lifecycle state of the community event. Controls visibility, registration availability, and operational workflows. Values: upcoming (scheduled, not yet started), active (currently running), completed (ended successfully), cancelled (terminated before completion), postponed (rescheduled), draft (not yet published).. Valid values are `upcoming|active|completed|cancelled|postponed|draft`',
    `event_type` STRING COMMENT 'Classification of the community event by its format and purpose. Drives eligibility rules, prize structures, and reporting segmentation. [ENUM-REF-CANDIDATE: in_game_challenge|fan_tournament|developer_ama|community_contest|seasonal_campaign|community_challenge|ugc_submission|charity_stream — promote to reference product]. Valid values are `in_game_challenge|fan_tournament|developer_ama|community_contest|seasonal_campaign|community_challenge`',
    `external_url` STRING COMMENT 'The public-facing URL for the community event landing page, registration portal, or official announcement. Used in marketing campaigns, in-game notifications, and community portal links.. Valid values are `^https?://.+`',
    `geographic_restriction` STRING COMMENT 'Pipe-separated list of ISO 3166-1 alpha-3 country codes where participation is permitted or restricted. Null indicates globally open. Used for regulatory compliance and prize distribution legality (e.g., USA|CAN|GBR).',
    `is_age_restricted` BOOLEAN COMMENT 'Indicates whether this community event has age-based eligibility restrictions (e.g., 18+ for prize-bearing contests). Triggers additional COPPA/GDPR compliance workflows when True.',
    `is_featured` BOOLEAN COMMENT 'Indicates whether this community event is designated as a featured or promoted event, receiving elevated visibility on community portals, in-game hubs, and marketing channels.',
    `is_recurring` BOOLEAN COMMENT 'Indicates whether this community event is part of a recurring series (e.g., weekly community challenges, annual seasonal campaigns). When True, recurrence_pattern provides scheduling details.',
    `k_factor_tracking_enabled` BOOLEAN COMMENT 'Indicates whether viral referral and K-Factor (Viral Coefficient) tracking is enabled for this community event. When True, referral attribution data is captured to measure the events organic growth and word-of-mouth amplification.',
    `max_registrations` STRING COMMENT 'The maximum number of players or teams allowed to register for this community event. Null indicates unlimited registrations. Used for capacity planning and waitlist management.',
    `min_player_level` STRING COMMENT 'The minimum in-game player level or rank required to be eligible to participate in this community event. Null indicates no level restriction.',
    `moderation_required` BOOLEAN COMMENT 'Indicates whether player submissions or participation in this event requires human or automated content moderation review before being published or counted. Critical for UGC events and community contests.',
    `nps_score` DECIMAL(18,2) COMMENT 'The Net Promoter Score (NPS) collected from participants after the community event concludes, ranging from -100 to 100. Measures player satisfaction and likelihood to recommend the event. Sourced from post-event surveys.',
    `organizer_type` STRING COMMENT 'Classification of the entity organizing the event. Distinguishes first-party developer-run events from community-led or third-party organized events, which affects moderation requirements and prize liability.. Valid values are `developer|community_manager|player|esports_team|third_party`',
    `participant_count` STRING COMMENT 'The total number of players or teams that actively participated in the community event (distinct from registrations, which may include no-shows). Key metric for community engagement reporting.',
    `prize_description` STRING COMMENT 'Narrative description of prizes, rewards, or incentives offered to participants or winners of the community event (e.g., Exclusive in-game cosmetic skin, 1000 virtual currency, and a physical trophy for top 3 finishers).',
    `prize_type` STRING COMMENT 'Classification of the primary prize category offered in this community event. Drives tax reporting obligations and prize fulfillment workflows. Virtual prizes (MTX items, virtual currency) are distinguished from physical or cash prizes for regulatory purposes.. Valid values are `virtual_currency|cosmetic_item|physical_prize|cash|title_recognition|no_prize`',
    `prize_value_usd` DECIMAL(18,2) COMMENT 'The total declared monetary value of all prizes for this community event in US Dollars. Required for tax reporting, legal compliance, and prize pool disclosures. Applies to both cash and fair-market-value of physical/virtual prizes.',
    `recurrence_pattern` STRING COMMENT 'The frequency pattern for recurring community events. Null for one-time events. Used for automated event scheduling and community calendar management. [ENUM-REF-CANDIDATE: daily|weekly|biweekly|monthly|quarterly|annually|seasonal — 7 candidates stripped; promote to reference product]',
    `referral_count` STRING COMMENT 'The total number of new player registrations attributed to referrals from existing participants in this community event. Used to calculate the K-Factor (Viral Coefficient) and measure organic community growth.',
    `registration_close_timestamp` TIMESTAMP COMMENT 'The date and time when player registration for the community event closes. After this point, no new registrations are accepted.',
    `registration_count` STRING COMMENT 'The current total number of players or teams that have registered for this community event. Updated in near-real-time from the registration system.',
    `registration_open_timestamp` TIMESTAMP COMMENT 'The date and time when player registration for the community event opens. May precede the event start timestamp to allow advance sign-ups.',
    `short_description` STRING COMMENT 'Concise summary of the community event (max 280 characters) used in promotional banners, push notifications, and social media previews.',
    `start_timestamp` TIMESTAMP COMMENT 'The exact date and time (with timezone offset) when the community event officially begins and becomes active for player participation.',
    `submission_type` STRING COMMENT 'The type of submission or participation action required from players in this community event. Determines the UGC (User-Generated Content) moderation workflow and submission portal configuration. [ENUM-REF-CANDIDATE: ugc_artwork|ugc_video|ugc_screenshot|gameplay_score|leaderboard|vote|registration_only|written_entry — promote to reference product]',
    `survey_response_count` STRING COMMENT 'The total number of post-event survey responses received from participants. Provides the denominator context for interpreting NPS and CSAT scores.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this community event record was last modified. Used for incremental data pipeline processing and audit compliance.',
    `voting_enabled` BOOLEAN COMMENT 'Indicates whether community members can vote on submissions or outcomes in this event (e.g., fan art contests with community voting). Drives the voting module configuration.',
    CONSTRAINT pk_community_event PRIMARY KEY(`community_event_id`)
) COMMENT 'Master entity for community-organized events including in-game community challenges, fan tournaments, developer AMAs (Ask Me Anything), community contests, and seasonal community campaigns. Tracks event name, event type, associated game title, organizer reference, start/end dates, participation eligibility, prize/reward description, registration count, participant count, platform, and event status (upcoming/active/completed/cancelled).';

CREATE OR REPLACE TABLE `gaming_ecm`.`community`.`social_connection` (
    `social_connection_id` BIGINT COMMENT 'Unique surrogate identifier for each social graph relationship record between two players. Primary key for the social_connection entity.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title context in which this social connection was established, if applicable. Null for platform-level or cross-game connections.',
    `guild_id` BIGINT COMMENT 'Reference to the guild or clan through which this social connection was established, when connection_source is guild. Null for connections originating from other sources.',
    `marketing_campaign_id` BIGINT COMMENT 'Reference to the marketing or referral campaign that drove this social connection, when applicable. Supports K-Factor viral coefficient measurement and player acquisition attribution via AppsFlyer/Adjust.',
    `player_account_id` BIGINT COMMENT 'Reference to the player who originated or initiated the social connection request (the source node in the social graph). Used to determine directionality of the relationship.',
    `target_player_player_account_id` BIGINT COMMENT 'Reference to the player who is the recipient or target of the social connection request (the destination node in the social graph). Used to determine directionality of the relationship.',
    `block_reason_code` STRING COMMENT 'Standardized reason code provided by the initiating player when blocking the target player. Populated only when connection_type is blocked. Supports community safety analytics and moderation reporting.. Valid values are `harassment|spam|inappropriate_content|cheating|other`',
    `co_play_session_count` STRING COMMENT 'Number of game sessions in which both the initiating and target players participated together since the connection was established. Key metric for measuring social engagement depth and retention correlation.',
    `connection_direction` STRING COMMENT 'Indicates whether the social relationship is unidirectional (e.g., follower, blocked, muted — only the initiating players perspective applies) or bidirectional (e.g., mutual friend where both parties have accepted).. Valid values are `unidirectional|bidirectional`',
    `connection_label` STRING COMMENT 'Optional free-text label or nickname assigned by the initiating player to categorize or personalize this connection (e.g., Raid Team, IRL Friend, Clan Leader). Supports player-defined social graph organization.',
    `connection_number` STRING COMMENT 'Human-readable business identifier for the social connection record, used for support, audit, and operational reference. Format: SC- followed by 10 digits.. Valid values are `^SC-[0-9]{10}$`',
    `connection_source` STRING COMMENT 'The channel or surface through which the social connection was initiated. Supports attribution analysis for community growth and K-Factor viral coefficient measurement. Values: in_game (initiated during gameplay), forum (community forum), guild (guild/clan membership), external (external social platform import), platform (console or PC platform friend list).. Valid values are `in_game|forum|guild|external|platform`',
    `connection_status` STRING COMMENT 'Current lifecycle state of the social connection. pending means the request has been sent but not yet acted upon; accepted means the connection is active; declined means the target player rejected the request; removed means a previously accepted connection was dissolved.. Valid values are `pending|accepted|declined|removed`',
    `connection_strength_score` DECIMAL(18,2) COMMENT 'Numeric score (0.00–100.00) representing the strength or closeness of the social connection based on interaction frequency, co-play sessions, and engagement signals. Used in community analytics, recommendation engines, and K-Factor viral coefficient modeling.',
    `connection_tier` STRING COMMENT 'Player-assigned or system-inferred tier classifying the closeness of the social relationship. Used for prioritized content feeds, notification filtering, and social graph segmentation in community analytics.. Valid values are `close_friend|acquaintance|follower|contact`',
    `connection_type` STRING COMMENT 'Categorical classification of the social relationship between the two players. friend indicates a mutual bidirectional relationship; follower indicates a unidirectional follow; blocked indicates the initiating player has blocked the target; muted indicates the initiating player has silenced the target without blocking.. Valid values are `friend|follower|blocked|muted`',
    `connection_version` STRING COMMENT 'Optimistic locking version counter incremented on each update to the social connection record. Supports concurrent update conflict detection and Silver Layer SCD (Slowly Changing Dimension) processing in the Databricks Lakehouse.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this social connection record was first created in the system. Represents the audit trail creation event, distinct from the business event timestamps (request_sent_timestamp, established_timestamp).',
    `established_timestamp` TIMESTAMP COMMENT 'Timestamp when the social connection transitioned to an active/accepted state. Represents the real-world business event time of the connection being formed. Distinct from the record creation timestamp.',
    `gdpr_consent_flag` BOOLEAN COMMENT 'Indicates whether valid GDPR consent has been obtained from both players for processing their social connection data, applicable for players in EU jurisdictions. Required for compliance with GDPR supervisory authority reporting.',
    `interaction_count` STRING COMMENT 'Cumulative count of social interactions (messages, co-play sessions, gift exchanges, reactions) recorded between the two players since the connection was established. Raw signal used for connection strength scoring and community engagement analytics.',
    `is_cross_game` BOOLEAN COMMENT 'Indicates whether this social connection spans multiple game titles within the platform ecosystem, as opposed to being scoped to a single game title. Supports cross-title community analytics.',
    `is_favorite` BOOLEAN COMMENT 'Indicates whether the initiating player has marked this connection as a favorite or best friend, enabling prioritized display and notification preferences within the social graph.',
    `is_minor_restricted` BOOLEAN COMMENT 'Indicates whether this social connection involves at least one player identified as a minor, triggering COPPA-compliant restrictions on social features, messaging, and data processing.',
    `is_mutual` BOOLEAN COMMENT 'Indicates whether the social connection is bidirectional and mutually acknowledged by both players. True for accepted friend relationships; False for unidirectional follower, blocked, or muted connections.',
    `is_reported` BOOLEAN COMMENT 'Indicates whether this social connection or an interaction within it has been flagged via a player report. Links community safety monitoring to the social graph for moderation workflow prioritization.',
    `k_factor_contribution` DECIMAL(18,2) COMMENT 'Numeric value representing this social connections contribution to the K-Factor (Viral Coefficient) calculation, measuring how effectively connected players invite or recruit new players. Used in player acquisition and community growth analytics.',
    `last_interaction_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent social interaction between the two connected players. Used to identify dormant connections, calculate connection recency, and support churn prediction models.',
    `moderation_flag` STRING COMMENT 'Current moderation status of the social connection from a community safety perspective. clean indicates no concerns; under_review means a report is being assessed; escalated means the case has been raised to senior moderation; actioned means a moderation action has been applied.. Valid values are `clean|under_review|escalated|actioned`',
    `mute_reason_code` STRING COMMENT 'Standardized reason code provided by the initiating player when muting the target player. Populated only when connection_type is muted. Supports community health and player experience analytics.. Valid values are `spam|noise|personal|other`',
    `notification_enabled` BOOLEAN COMMENT 'Indicates whether the initiating player has enabled activity notifications for this specific social connection (e.g., when the connected player goes online, achieves a milestone, or posts content).',
    `nps_influence_flag` BOOLEAN COMMENT 'Indicates whether this social connection was established as a result of an NPS (Net Promoter Score) promoter referral, linking community satisfaction data to social graph growth for player advocacy analytics.',
    `platform_code` STRING COMMENT 'The gaming platform on which the social connection was initiated. Supports cross-platform social graph analysis and platform-specific community health reporting. Aligned with Steamworks/Epic Games Store/Console SDK platform identifiers. [ENUM-REF-CANDIDATE: PC|PS5|PS4|XBOX|SWITCH|MOBILE|WEB — 7 candidates stripped; promote to reference product]',
    `privacy_visibility` STRING COMMENT 'Privacy setting controlling who can see this social connection in the players social graph. public allows all players to see the connection; friends_only restricts visibility to mutual friends; private hides the connection entirely.. Valid values are `public|friends_only|private`',
    `regulatory_jurisdiction` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the regulatory jurisdiction applicable to this social connection record, used for GDPR, COPPA, and regional data protection compliance. [ENUM-REF-CANDIDATE: USA|GBR|DEU|FRA|JPN|KOR|AUS|CAN|BRA|IND — promote to reference product]',
    `removed_timestamp` TIMESTAMP COMMENT 'Timestamp when the social connection was dissolved or removed by either party. Populated only when connection_status is removed. Used for social graph churn analysis and community health monitoring.',
    `request_message` STRING COMMENT 'Optional personalized message submitted by the initiating player when sending a friend or follow request. Captured for community moderation review and player experience analytics.',
    `request_sent_timestamp` TIMESTAMP COMMENT 'Timestamp when the initiating player sent the social connection request. Captures the origination event for funnel analysis, pending request aging, and FTUE (First-Time User Experience) social onboarding analytics.',
    `responded_timestamp` TIMESTAMP COMMENT 'Timestamp when the target player responded to the connection request (accepted, declined, or blocked). Used to calculate request response latency and pending request conversion rates.',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this social connection record originated. Supports data lineage tracking and ETL reconciliation in the Databricks Silver Layer. Aligned with operational systems including Salesforce CRM, GameAnalytics/Amplitude, and Platform SDKs.. Valid values are `SALESFORCE_CRM|GAME_ANALYTICS|IN_GAME_API|FORUM_PLATFORM|GUILD_SERVICE|PLATFORM_SDK`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this social connection record was last modified. Tracks the most recent state change for audit trail, data lineage, and Silver Layer incremental processing in the Databricks Lakehouse.',
    CONSTRAINT pk_social_connection PRIMARY KEY(`social_connection_id`)
) COMMENT 'Association entity representing social graph relationships between players including friends, followers, and blocked connections. Tracks initiating player reference, target player reference, connection type (friend/follower/blocked/muted), connection status (pending/accepted/declined/removed), connection source (in-game/forum/guild/external), and connection established/updated timestamps. SSOT for player social graph within the community domain.';

CREATE OR REPLACE TABLE `gaming_ecm`.`community`.`ban` (
    `ban_id` BIGINT COMMENT 'Unique surrogate identifier for each community ban or suspension record. Primary key for the community_ban entity in the Silver Layer lakehouse.',
    `employee_id` BIGINT COMMENT 'Reference to the moderator or senior staff member who reviewed and resolved the appeal. Supports accountability and separation of duties between ban issuance and appeal review.',
    `ban_employee_id` BIGINT COMMENT 'Reference to the moderator or staff member who issued this ban. Used for accountability, audit trails, and moderator performance tracking.',
    `game_title_id` BIGINT COMMENT 'Reference to the specific game title within which this ban applies, if the ban is scoped to a single title. Null for platform-wide or cross-title community bans.',
    `moderation_action_id` BIGINT COMMENT 'Reference to the originating moderation action event that triggered this ban. Distinguishes the standing ban state from the discrete moderation event.',
    `player_account_id` BIGINT COMMENT 'Reference to the player account subject to this community ban. Links to the player master entity.',
    `player_report_id` BIGINT COMMENT 'Reference to the player report that initiated or contributed to this ban, if applicable. Enables traceability from community report through to enforcement outcome.',
    `refund_id` BIGINT COMMENT 'Foreign key linking to billing.refund. Business justification: Permanent account bans trigger refund processing per consumer protection regulations and platform policies, requiring direct linkage for automated refund workflows, ban appeal financial review, and re',
    `sanctions_screening_result_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_result. Business justification: Permanent bans for fraud, money laundering, or export control violations link to sanctions screening results. Enables AML/CFT compliance by connecting enforcement actions to OFAC/sanctions list matche',
    `support_ticket_id` BIGINT COMMENT 'External reference to the Zendesk support ticket associated with this ban, if a player support case was opened. Enables cross-system traceability between community enforcement and player support operations.',
    `appeal_notes` STRING COMMENT 'Free-text notes recorded by the appeal reviewer documenting the rationale for the appeal outcome. Supports audit trails and policy consistency reviews.',
    `appeal_outcome` STRING COMMENT 'Final decision on the players appeal. upheld means the original ban stands; overturned means the ban is reversed; modified means the ban terms were changed (e.g., duration reduced); withdrawn means the player withdrew the appeal before resolution.. Valid values are `upheld|overturned|modified|withdrawn`',
    `appeal_resolved_timestamp` TIMESTAMP COMMENT 'Date and time when the appeal review was completed and a final outcome was recorded. Null if appeal is still pending or not submitted. Used to measure appeal resolution time and SLA adherence.',
    `appeal_status` STRING COMMENT 'Current status of the players appeal against this ban. not_appealed means no appeal has been submitted; pending means appeal submitted but not yet reviewed; under_review means actively being reviewed; upheld means ban confirmed; overturned means ban reversed; withdrawn means player withdrew the appeal.. Valid values are `not_appealed|pending|under_review|upheld|overturned|withdrawn`',
    `appeal_submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the player submitted their appeal against this ban. Null if no appeal has been filed. Used to track appeal SLA compliance.',
    `auto_moderation_score` DECIMAL(18,2) COMMENT 'Confidence score (0.0000–1.0000) assigned by the automated moderation system that triggered or contributed to this ban. Populated only when is_automated is True. Used to calibrate and audit automated enforcement thresholds.',
    `ban_number` STRING COMMENT 'Human-readable, externally referenceable identifier for this ban (e.g., BAN-202400012345). Used in player communications, appeal correspondence, and support tickets.. Valid values are `^BAN-[0-9]{8,12}$`',
    `ban_scope` STRING COMMENT 'The community feature area(s) to which this ban applies. forum restricts forum posting; chat restricts in-game and community chat; ugc restricts User-Generated Content (UGC) submissions; all_community applies a full community ban across all features.. Valid values are `forum|chat|ugc|all_community`',
    `ban_status` STRING COMMENT 'Current lifecycle state of the community ban. active means the ban is currently enforced; expired means the ban end date has passed; lifted means the ban was manually removed; appealed means an appeal is in progress; pending_review means the ban is under internal review.. Valid values are `active|expired|lifted|appealed|pending_review`',
    `ban_type` STRING COMMENT 'Classification of the ban duration model. temporary bans have a defined end date; permanent bans have no end date (null ban_end_timestamp); shadow bans restrict visibility without notifying the player, used for spam and bot suppression.. Valid values are `temporary|permanent|shadow`',
    `content_rating_concern` BOOLEAN COMMENT 'Indicates whether the violation underlying this ban involved content that may affect the games content rating classification (e.g., extreme violence, sexual content, hate speech). Flags for escalation to the content compliance team for ESRB/PEGI review.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this community ban record was first created in the system. Serves as the audit creation timestamp for data lineage and compliance purposes.',
    `duration_hours` STRING COMMENT 'The originally assigned duration of the ban in hours at the time of issuance. Null for permanent bans. Enables duration-based analytics and policy benchmarking independent of actual start/end timestamps.',
    `end_timestamp` TIMESTAMP COMMENT 'The date and time when this ban is scheduled to expire. Null for permanent bans (ban_type = permanent). When the current timestamp exceeds this value, ban_status transitions to expired.',
    `evidence_attachment_count` STRING COMMENT 'Number of evidence files (screenshots, chat logs, video clips) attached to this ban record to substantiate the violation. Supports audit completeness checks and appeal review.',
    `gdpr_consent_flag` BOOLEAN COMMENT 'Indicates whether the player has provided valid GDPR consent for processing of their personal data in connection with this ban record. Relevant for EU-jurisdiction players and required for lawful processing under GDPR Article 6.',
    `internal_notes` STRING COMMENT 'Confidential free-text notes recorded by moderators for internal use only, not shared with the player. May include context about ongoing investigations, escalation history, or coordination with trust and safety teams.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether this ban was issued automatically by an automated moderation system (e.g., anti-cheat engine, spam detection, toxicity classifier) rather than by a human moderator. Supports audit of automated enforcement accuracy.',
    `is_minor_involved` BOOLEAN COMMENT 'Indicates whether the banned player is identified as a minor (under 18, or under 13 for COPPA purposes). Triggers enhanced data handling, parental notification workflows, and stricter enforcement protocols.',
    `is_permanent` BOOLEAN COMMENT 'Indicates whether this ban is permanent with no scheduled end date. True when ban_type is permanent and ban_end_timestamp is null. Provides a direct boolean filter for permanent ban analytics and enforcement dashboards.',
    `is_repeat_offender` BOOLEAN COMMENT 'Indicates whether the player was classified as a repeat offender at the time of ban issuance (prior_ban_count > 0 or per policy threshold). Drives escalated enforcement actions and permanent ban eligibility.',
    `notification_sent` BOOLEAN COMMENT 'Indicates whether the player was notified of this ban via the standard communication channel (in-game notification, email, or support ticket). Supports compliance with consumer protection notification requirements.',
    `notification_timestamp` TIMESTAMP COMMENT 'Date and time when the ban notification was sent to the player. Null if notification_sent is False. Used to measure notification SLA compliance and support regulatory audit.',
    `platform_code` STRING COMMENT 'The gaming platform on which this ban is enforced. ALL indicates a cross-platform ban. Supports platform-specific enforcement and compliance with first-party platform certification requirements (TRC/TCR). [ENUM-REF-CANDIDATE: PC|PS5|PS4|XBOX|SWITCH|MOBILE|ALL — 7 candidates stripped; promote to reference product]',
    `prior_ban_count` STRING COMMENT 'Number of previous community bans on record for this player at the time this ban was issued. Supports repeat offender escalation policies and ban duration calibration.',
    `reason` STRING COMMENT 'Free-text description of the specific reason for issuing this ban, as documented by the moderator. Provides context beyond the structured violation category for audit and appeal review purposes.',
    `regulatory_jurisdiction` STRING COMMENT 'ISO 3166-1 alpha-3 country code or regional code indicating the regulatory jurisdiction applicable to this ban record (e.g., DEU for Germany under USK/GDPR, KOR for South Korea under GRAC). Supports jurisdiction-specific compliance reporting.',
    `reinstatement_reason` STRING COMMENT 'Reason code explaining why the player was reinstated. appeal_overturned means a successful appeal; ban_expired means the ban duration elapsed; manual_lift means a moderator manually removed the ban; policy_change means a policy update retroactively affected the ban; error_correction means the ban was issued in error.. Valid values are `appeal_overturned|ban_expired|manual_lift|policy_change|error_correction`',
    `reinstatement_timestamp` TIMESTAMP COMMENT 'Date and time when the players community access was reinstated following a ban lift, expiry, or successful appeal. Null if the ban is still active or the player has not been reinstated.',
    `severity_level` STRING COMMENT 'Assessed severity of the violation that triggered this ban. Drives escalation workflows, ban duration recommendations, and repeat offender policies.. Valid values are `low|medium|high|critical`',
    `start_timestamp` TIMESTAMP COMMENT 'The exact date and time (ISO 8601 with timezone) when this ban became effective and enforcement began. Principal business event timestamp for the ban lifecycle.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this community ban record was last modified. Tracks any changes to ban status, appeal outcome, or reinstatement. Essential for Silver Layer incremental processing and audit trails.',
    `violation_category` STRING COMMENT 'Primary category of the community guideline violation that led to this ban (e.g., harassment, hate_speech, cheating, spam, inappropriate_content, impersonation, exploitation). [ENUM-REF-CANDIDATE: harassment|hate_speech|cheating|spam|inappropriate_content|impersonation|exploitation|other — promote to reference product]',
    `violation_subcategory` STRING COMMENT 'Secondary classification providing more granular detail on the violation type within the primary violation_category (e.g., within harassment: targeted_harassment, doxxing, sexual_harassment). Supports detailed moderation analytics and policy refinement.',
    CONSTRAINT pk_ban PRIMARY KEY(`ban_id`)
) COMMENT 'Master entity representing active and historical community bans and suspensions applied to players across forums, chat, UGC, and community features. Tracks player reference, ban scope (forum/chat/ugc/all-community), ban reason, issuing moderator reference, linked moderation action reference, ban start date, ban end date (null for permanent), appeal status, appeal outcome, and reinstatement timestamp. Distinct from moderation_action as it represents the standing ban state, not the event.';

CREATE OR REPLACE TABLE `gaming_ecm`.`community`.`player_reputation` (
    `player_reputation_id` BIGINT COMMENT 'Unique identifier for the player reputation record. Primary key for the player reputation entity.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title for which this reputation is tracked. Enables game-specific reputation systems.',
    `player_account_id` BIGINT COMMENT 'Reference to the player whose reputation is being tracked. Links to the player master entity.',
    `previous_player_reputation_id` BIGINT COMMENT 'Self-referencing FK on player_reputation (previous_player_reputation_id)',
    `auto_moderation_score` DECIMAL(18,2) COMMENT 'Machine learning-derived score indicating likelihood of future violations. Used to adjust moderation thresholds and flag high-risk content.',
    `can_invite` BOOLEAN COMMENT 'Boolean flag indicating whether the player can send guild or event invitations. Privilege earned through positive community standing.',
    `can_moderate` BOOLEAN COMMENT 'Boolean flag indicating whether the player has community moderation privileges. Reserved for leader and moderator trust tiers.',
    `can_post` BOOLEAN COMMENT 'Boolean flag indicating whether the player has privilege to post in community forums. Gated by trust tier and violation history.',
    `can_upload_ugc` BOOLEAN COMMENT 'Boolean flag indicating whether the player has privilege to upload UGC submissions. Requires minimum trust tier and clean moderation record.',
    `can_vote` BOOLEAN COMMENT 'Boolean flag indicating whether the player can vote on community content, polls, or UGC submissions. Basic privilege for established members.',
    `consent_timestamp` TIMESTAMP COMMENT 'Timestamp when GDPR consent was granted. Required for regulatory compliance and audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reputation record was first created in the system. Audit field for data lineage.',
    `csat_score` STRING COMMENT 'Most recent CSAT score provided by the player regarding community interactions. Range 1-5. Measures player satisfaction with community features.',
    `endorsement_count` STRING COMMENT 'Total number of endorsements received from other community members. Reflects peer recognition of positive contributions.',
    `gdpr_consent_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the player has provided GDPR consent for community data processing and reputation tracking.',
    `helpful_contribution_count` STRING COMMENT 'Number of forum posts, UGC submissions, or support responses marked as helpful by the community. Key metric for reputation advancement.',
    `is_age_verified` BOOLEAN COMMENT 'Boolean flag indicating whether the players age has been verified for compliance with age-restricted community features and content.',
    `is_verified_contributor` BOOLEAN COMMENT 'Boolean flag indicating whether the player has been verified as a trusted content contributor. Verified status displayed publicly and influences trust tier.',
    `k_factor_contribution` DECIMAL(18,2) COMMENT 'Players contribution to viral growth through community referrals and invitations. Measures organic community expansion driven by this player.',
    `last_activity_date` DATE COMMENT 'Date of the players most recent community activity (post, vote, endorsement, etc.). Used to calculate inactivity-based reputation decay.',
    `moderation_threshold_level` STRING COMMENT 'Automated moderation sensitivity level applied to this player based on trust tier and history. Higher trust tiers receive relaxed thresholds.. Valid values are `strict|standard|relaxed|exempt`',
    `notes` STRING COMMENT 'Internal notes for moderators and community managers regarding this players reputation history, special circumstances, or manual adjustments.',
    `nps_score` STRING COMMENT 'Most recent NPS score provided by the player regarding community experience. Range -100 to +100. Tracks community satisfaction at player level.',
    `platform_code` STRING COMMENT 'Primary platform where the player engages with the community. Enables platform-specific reputation tracking and moderation policies. [ENUM-REF-CANDIDATE: PC|PS5|PS4|XBOX_SERIES|XBOX_ONE|SWITCH|MOBILE_IOS|MOBILE_ANDROID|WEB — 9 candidates stripped; promote to reference product]',
    `previous_trust_tier` STRING COMMENT 'The trust tier held immediately before the most recent tier change. Enables tier transition analysis and rollback scenarios.. Valid values are `new|basic|member|regular|leader|moderator`',
    `referral_count` STRING COMMENT 'Total number of successful referrals made by this player that resulted in new community members. Positive reputation indicator.',
    `regulatory_jurisdiction` STRING COMMENT 'Three-letter ISO country code indicating the primary regulatory jurisdiction governing this players community data. Determines applicable privacy and content regulations.. Valid values are `^[A-Z]{3}$`',
    `reputation_decay_rate` DECIMAL(18,2) COMMENT 'Percentage rate at which reputation points decay due to inactivity or negative behavior. Applied periodically to maintain active community engagement.',
    `reputation_number` STRING COMMENT 'Human-readable business identifier for the reputation record. Format: REP-XXXXXXXXXX.. Valid values are `^REP-[0-9]{10}$`',
    `reputation_points` STRING COMMENT 'Total accumulated reputation score based on positive community contributions, endorsements, and helpful actions. Used to calculate trust tier and privilege eligibility.',
    `reputation_status` STRING COMMENT 'Current lifecycle status of the reputation record. Active indicates normal operation; suspended/frozen indicates temporary restriction; under_review indicates pending moderation action; banned indicates permanent revocation.. Valid values are `active|suspended|frozen|under_review|banned`',
    `source_system_code` STRING COMMENT 'Identifier of the operational system that originated this reputation record. Supports multi-system integration and data lineage.',
    `suspension_end_date` DATE COMMENT 'Date when temporary reputation suspension expires and privileges are restored. Null for permanent bans or active reputations.',
    `suspension_reason` STRING COMMENT 'Free-text explanation for reputation suspension or restriction. Provides context for moderation actions and player communication.',
    `tier_change_reason` STRING COMMENT 'Reason code for the most recent trust tier change. Supports audit trail and player communication.. Valid values are `promotion_earned|demotion_violation|demotion_inactivity|manual_adjustment|appeal_granted|system_reset`',
    `tier_demotion_date` DATE COMMENT 'Date when the player was last demoted to a lower trust tier due to violations or inactivity. Tracks negative reputation events.',
    `tier_promotion_date` DATE COMMENT 'Date when the player was last promoted to a higher trust tier. Tracks progression through the reputation system.',
    `trust_tier` STRING COMMENT 'Current trust level classification earned through positive community participation. Determines privilege access and automated moderation thresholds. Values: new (new account), basic (minimal activity), member (established presence), regular (consistent positive contributor), leader (community influencer), moderator (elevated privileges).. Valid values are `new|basic|member|regular|leader|moderator`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the reputation record was last modified. Audit field for change tracking.',
    `verification_date` DATE COMMENT 'Date when the player achieved verified contributor status. Null if not verified.',
    `violation_count` STRING COMMENT 'Total number of confirmed community guideline violations. Impacts trust tier and may result in privilege revocation.',
    `warning_count` STRING COMMENT 'Total number of moderation warnings issued to the player. Negative indicator that may trigger reputation decay or tier demotion.',
    CONSTRAINT pk_player_reputation PRIMARY KEY(`player_reputation_id`)
) COMMENT 'Master entity tracking player community reputation scores, trust levels, and privilege tiers earned through positive community participation. Captures player reference, reputation points, trust tier (new/basic/member/regular/leader), endorsement count, helpful contribution count, warning count, privilege set (post/upload/moderate/invite), reputation decay rate, last activity date, and tier promotion/demotion history. Drives automated moderation thresholds and community privilege gating. SSOT for player standing within the community ecosystem.';

CREATE OR REPLACE TABLE `gaming_ecm`.`community`.`forum_category` (
    `forum_category_id` BIGINT COMMENT 'Primary key for forum_category',
    `game_title_id` BIGINT COMMENT 'Reference to the specific game title this forum category is associated with. Null for general or cross-game categories.',
    `modified_by_user_player_account_id` BIGINT COMMENT 'Reference to the administrator or moderator user who last modified this forum category.',
    `parent_category_id` BIGINT COMMENT 'Reference to the parent forum category for hierarchical category structures. Null for top-level categories.',
    `player_account_id` BIGINT COMMENT 'Reference to the administrator or moderator user who created this forum category.',
    `parent_forum_category_id` BIGINT COMMENT 'Self-referencing FK on forum_category (parent_forum_category_id)',
    `active_threads` BIGINT COMMENT 'Current count of active, non-archived discussion threads in this forum category.',
    `allowed_content_types` STRING COMMENT 'Comma-separated list of content types allowed in this category such as text, images, videos, polls, or attachments.',
    `auto_archive_days` STRING COMMENT 'Number of days of inactivity after which threads in this category are automatically archived. Null if auto-archiving is disabled.',
    `banner_image_url` STRING COMMENT 'URL path to the banner image displayed at the top of the forum category page.',
    `forum_category_code` STRING COMMENT 'Unique business identifier code for the forum category used for system integration and API references.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this forum category record was first created in the system.',
    `custom_css_class` STRING COMMENT 'Custom CSS class name applied to this forum category for specialized styling and theming in the user interface.',
    `forum_category_description` STRING COMMENT 'Detailed description of the forum category explaining its purpose, scope, and the types of discussions it hosts.',
    `display_order` STRING COMMENT 'Numeric sequence controlling the display order of forum categories in the user interface. Lower numbers appear first.',
    `effective_end_date` DATE COMMENT 'Date when this forum category is scheduled to be deactivated or archived. Null for indefinite categories.',
    `effective_start_date` DATE COMMENT 'Date when this forum category becomes active and visible to players.',
    `external_code` STRING COMMENT 'Identifier used by external or legacy systems to reference this forum category for integration and migration purposes.',
    `featured_priority` STRING COMMENT 'Priority ranking for featuring this category on the homepage or community hub. Higher numbers indicate higher priority. Null if not featured.',
    `icon_url` STRING COMMENT 'URL path to the icon image representing this forum category in the user interface.',
    `is_moderated` BOOLEAN COMMENT 'Indicates whether posts in this forum category require moderator approval before being published.',
    `is_private` BOOLEAN COMMENT 'Indicates whether this forum category is private and requires special permissions or membership to access.',
    `is_read_only` BOOLEAN COMMENT 'Indicates whether this forum category is read-only, preventing new posts or replies from being created.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the primary language for content in this forum category.',
    `last_post_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent post or reply made in this forum category.',
    `max_attachment_size_mb` STRING COMMENT 'Maximum file size in megabytes allowed for attachments in posts within this forum category.',
    `meta_description` STRING COMMENT 'HTML meta description tag content for search engine optimization of the forum category page.',
    `meta_title` STRING COMMENT 'HTML meta title tag content for search engine optimization of the forum category page.',
    `minimum_player_level` STRING COMMENT 'The minimum player level required to view or post in this forum category. Null if no level restriction applies.',
    `moderation_level` STRING COMMENT 'The intensity level of content moderation applied to posts and discussions in this forum category.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this forum category record was last updated or modified.',
    `forum_category_name` STRING COMMENT 'The display name of the forum category as shown to players in the community forums.',
    `notification_enabled` BOOLEAN COMMENT 'Indicates whether players can subscribe to notifications for new posts and activity in this forum category.',
    `platform_type` STRING COMMENT 'The gaming platform this forum category is focused on or applicable to.',
    `post_cooldown_minutes` STRING COMMENT 'Minimum number of minutes a player must wait between consecutive posts in this forum category to prevent spam.',
    `region_code` STRING COMMENT 'Three-letter geographic region code indicating the target region for this forum category.',
    `seo_slug` STRING COMMENT 'URL-friendly slug used for search engine optimization and clean URLs for this forum category.',
    `forum_category_status` STRING COMMENT 'Current lifecycle status of the forum category indicating its availability and visibility to players.',
    `total_posts` BIGINT COMMENT 'Cumulative count of all posts and replies made in this forum category since inception.',
    `total_threads` BIGINT COMMENT 'Cumulative count of all discussion threads created in this forum category since inception.',
    `forum_category_type` STRING COMMENT 'Classification of the forum category by its primary purpose and content focus.',
    CONSTRAINT pk_forum_category PRIMARY KEY(`forum_category_id`)
) COMMENT 'Master reference table for forum_category. Referenced by forum_category_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`community`.`kb_category` (
    `kb_category_id` BIGINT COMMENT 'Primary key for kb_category',
    `archived_by_user_employee_id` BIGINT COMMENT 'Reference to the user who archived this category. Null if category is not archived.',
    `created_by_user_employee_id` BIGINT COMMENT 'Reference to the user who created this category record.',
    `employee_id` BIGINT COMMENT 'Reference to the support agent or content manager responsible for maintaining this category.',
    `modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this category record.',
    `parent_category_id` BIGINT COMMENT 'Reference to the parent category for hierarchical organization. Null for top-level categories.',
    `parent_kb_category_id` BIGINT COMMENT 'Self-referencing FK on kb_category (parent_kb_category_id)',
    `archived_timestamp` TIMESTAMP COMMENT 'Date and time when this category was archived. Null if category is not archived.',
    `article_count` STRING COMMENT 'Total number of knowledge base articles currently assigned to this category.',
    `banner_url` STRING COMMENT 'URL path to the banner image displayed at the top of the category page.',
    `category_code` STRING COMMENT 'Unique business identifier code for the category used in external systems and reporting.',
    `category_name` STRING COMMENT 'Human-readable name of the knowledge base category.',
    `category_type` STRING COMMENT 'Classification of the knowledge base category by subject area.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this knowledge base category record was first created in the system.',
    `kb_category_description` STRING COMMENT 'Detailed description of the knowledge base category purpose and scope.',
    `display_order` STRING COMMENT 'Numeric sequence for ordering categories in user interfaces and navigation menus.',
    `effective_end_date` DATE COMMENT 'Date when this category is scheduled to be archived or deactivated. Null for indefinite categories.',
    `effective_start_date` DATE COMMENT 'Date when this category becomes active and visible to users.',
    `external_system_code` STRING COMMENT 'Identifier for this category in external support systems such as Zendesk or other knowledge management platforms.',
    `external_system_name` STRING COMMENT 'Name of the external system where this category originates or is synchronized to.',
    `game_title_filter` STRING COMMENT 'Specific game title this category is associated with, or null for cross-game categories.',
    `hierarchy_level` STRING COMMENT 'Depth level in the category hierarchy tree, with 1 being top-level.',
    `hierarchy_path` STRING COMMENT 'Full path from root to current category using category codes or IDs, delimited by forward slashes.',
    `icon_url` STRING COMMENT 'URL path to the icon image representing this category in user interfaces.',
    `is_featured` BOOLEAN COMMENT 'Indicates whether this category is featured prominently on the knowledge base home page.',
    `is_searchable` BOOLEAN COMMENT 'Indicates whether articles in this category are included in knowledge base search results.',
    `locale_code` STRING COMMENT 'Language and region code (ISO 639-1 and ISO 3166-1) for localized category content.',
    `moderation_required` BOOLEAN COMMENT 'Indicates whether new articles in this category require approval before publication.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this category record was last updated.',
    `platform_filter` STRING COMMENT 'Gaming platform(s) this category applies to for platform-specific knowledge base content.',
    `requires_authentication` BOOLEAN COMMENT 'Indicates whether users must be logged in to access articles in this category.',
    `search_keywords` STRING COMMENT 'Comma-separated list of keywords and tags to improve category discoverability in search.',
    `seo_description` STRING COMMENT 'Meta description for search engine optimization and social media sharing.',
    `seo_slug` STRING COMMENT 'URL-friendly identifier used in the category page web address.',
    `seo_title` STRING COMMENT 'Optimized title for search engine indexing and display in search results.',
    `kb_category_status` STRING COMMENT 'Current lifecycle status of the knowledge base category.',
    `sync_timestamp` TIMESTAMP COMMENT 'Date and time when this category was last synchronized with external support systems.',
    `view_count` BIGINT COMMENT 'Cumulative number of times articles in this category have been viewed by users.',
    `visibility_scope` STRING COMMENT 'Access level determining which user roles can view articles in this category.',
    CONSTRAINT pk_kb_category PRIMARY KEY(`kb_category_id`)
) COMMENT 'Master reference table for kb_category. Referenced by category_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`community`.`kb_section` (
    `kb_section_id` BIGINT COMMENT 'Primary key for kb_section',
    `employee_id` BIGINT COMMENT 'Reference to the internal user (support agent or content manager) who authored this section.',
    `game_title_id` BIGINT COMMENT 'Reference to the specific game title this section relates to. Null if the section applies to general platform or account topics.',
    `kb_article_id` BIGINT COMMENT 'Reference to the parent knowledge base article that this section belongs to.',
    `replacement_section_id` BIGINT COMMENT 'Reference to the kb_section that replaces this deprecated section. Used to redirect players to current content.',
    `reviewer_user_employee_id` BIGINT COMMENT 'Reference to the internal user who reviewed and approved this section for publication. Null if not yet reviewed.',
    `parent_kb_section_id` BIGINT COMMENT 'Self-referencing FK on kb_section (parent_kb_section_id)',
    `archived_timestamp` TIMESTAMP COMMENT 'Date and time when this section was archived and removed from active player-facing knowledge base. Null if currently active.',
    `average_rating` DECIMAL(18,2) COMMENT 'Average player rating for this section on a scale of 0.00 to 5.00. Aggregated from player feedback submissions.',
    `canonical_url` STRING COMMENT 'Canonical URL path for this section in the public-facing knowledge base. Used for SEO and direct linking from external sources.',
    `content_body` STRING COMMENT 'The main text content of the knowledge base section. May include formatted text, links, and embedded media references.',
    `content_format` STRING COMMENT 'Format specification for the content_body field. Determines how the content should be rendered in the player-facing interface.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this knowledge base section record was first created in the system.',
    `deprecation_reason` STRING COMMENT 'Explanation of why this section was deprecated. Null if the section is not deprecated. Used for content audit trails.',
    `difficulty_level` STRING COMMENT 'Complexity level of the content. Helps players assess whether the section matches their technical proficiency.',
    `display_order` STRING COMMENT 'Numeric sequence number determining the order in which sections appear within the parent article. Lower numbers appear first.',
    `estimated_read_time_minutes` STRING COMMENT 'Estimated time in minutes for a player to read and understand this section. Calculated based on word count and content complexity.',
    `feedback_comment_count` STRING COMMENT 'Number of player feedback comments submitted for this section. Used to identify content requiring attention or clarification.',
    `helpful_vote_count` STRING COMMENT 'Number of players who marked this section as helpful. Used to measure content quality and relevance.',
    `is_deprecated` BOOLEAN COMMENT 'Flag indicating whether this section content is outdated and scheduled for removal or replacement. Used to manage content lifecycle.',
    `is_featured` BOOLEAN COMMENT 'Flag indicating whether this section is featured prominently in the knowledge base interface. Used to highlight important or frequently needed content.',
    `language_code` STRING COMMENT 'ISO 639-1 language code (with optional ISO 3166-1 country code) indicating the language of the section content. Supports multi-language knowledge base.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this section was last updated. Used to track content freshness and trigger review workflows.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Date and time when this section was last reviewed for accuracy and relevance. Used to schedule periodic content audits.',
    `linked_ticket_category` STRING COMMENT 'Support ticket category code that this section addresses. Used to suggest relevant KB articles during ticket creation and deflect support volume.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next content review cycle. Used to ensure knowledge base content remains current and accurate.',
    `platform_applicability` STRING COMMENT 'Gaming platform(s) to which this section content applies. Enables platform-specific help content filtering.',
    `published_timestamp` TIMESTAMP COMMENT 'Date and time when this section was first published and made visible to players. Null if never published.',
    `related_section_ids` STRING COMMENT 'Comma-separated list of kb_section_id values for related sections. Used to provide cross-references and improve player navigation.',
    `requires_authentication` BOOLEAN COMMENT 'Flag indicating whether players must be logged in to view this section. Used for account-specific or sensitive support content.',
    `search_keywords` STRING COMMENT 'Comma-separated list of keywords and phrases used to improve search discoverability of the section. Includes common player terminology and synonyms.',
    `section_code` STRING COMMENT 'Unique business identifier code for the section, used for cross-referencing and integration with support ticketing systems.',
    `section_title` STRING COMMENT 'The human-readable title of the knowledge base section. Used for navigation and display in help documentation.',
    `section_type` STRING COMMENT 'Classification of the section content type. Determines how the section is presented and indexed for player search.',
    `seo_meta_description` STRING COMMENT 'Meta description text for search engine optimization. Used when the knowledge base is publicly indexed by search engines.',
    `kb_section_status` STRING COMMENT 'Current lifecycle status of the knowledge base section. Controls visibility to players and availability in search results.',
    `unhelpful_vote_count` STRING COMMENT 'Number of players who marked this section as not helpful. Indicates content that may need revision or clarification.',
    `version_number` STRING COMMENT 'Sequential version number of the section content. Incremented with each published revision to track content evolution.',
    `video_url` STRING COMMENT 'URL to an embedded video tutorial or demonstration related to this section content. Null if no video is associated.',
    `view_count` BIGINT COMMENT 'Total number of times this section has been viewed by players. Used for content effectiveness analytics.',
    `visibility_level` STRING COMMENT 'Access control level determining which player segments can view this section. Used for tiered support content delivery.',
    CONSTRAINT pk_kb_section PRIMARY KEY(`kb_section_id`)
) COMMENT 'Master reference table for kb_section. Referenced by section_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`community`.`survey` (
    `survey_id` BIGINT COMMENT 'Primary key for survey',
    `follow_up_survey_id` BIGINT COMMENT 'Self-referencing FK on survey (follow_up_survey_id)',
    `anonymous_responses_allowed` BOOLEAN COMMENT 'Indicates whether players can submit responses anonymously without player identification.',
    `archived_timestamp` TIMESTAMP COMMENT 'Timestamp when the survey was archived and removed from active distribution.',
    `average_csat_score` DECIMAL(18,2) COMMENT 'Average Customer Satisfaction score calculated from survey responses (scale 1-5).',
    `average_nps_score` DECIMAL(18,2) COMMENT 'Average Net Promoter Score calculated from survey responses (scale 0-10).',
    `survey_category` STRING COMMENT 'Business category of the survey focus area.',
    `completion_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of players who completed the survey after starting it.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the survey record was first created in the system.',
    `data_retention_days` STRING COMMENT 'Number of days survey response data is retained before archival or deletion per privacy policy.',
    `survey_description` STRING COMMENT 'Detailed description of the survey purpose and scope.',
    `distribution_channel` STRING COMMENT 'Channel through which the survey is distributed to players.',
    `end_date` DATE COMMENT 'Date when the survey closes and stops accepting responses.',
    `estimated_completion_minutes` STRING COMMENT 'Estimated time in minutes for a player to complete the survey.',
    `external_survey_url` STRING COMMENT 'URL link to an external survey platform (e.g., SurveyMonkey, Qualtrics) if the survey is hosted externally.',
    `game_title_filter` STRING COMMENT 'Specific game title(s) for which this survey is targeted, or all for cross-game surveys.',
    `incentive_description` STRING COMMENT 'Description of the incentive offered for completing the survey (e.g., 100 gems, exclusive skin).',
    `incentive_offered` BOOLEAN COMMENT 'Indicates whether an incentive (e.g., in-game currency, items) is offered for survey completion.',
    `integration_platform` STRING COMMENT 'Third-party platform integrated for survey distribution and response collection.',
    `language_code` STRING COMMENT 'ISO 639-1 language code for the survey (e.g., en, es, ja, zh-CN).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the survey record was last updated.',
    `localization_available` BOOLEAN COMMENT 'Indicates whether the survey is available in multiple languages.',
    `max_responses_target` STRING COMMENT 'Target maximum number of responses to collect before closing the survey.',
    `notes` STRING COMMENT 'Internal notes or comments about the survey for team reference.',
    `owner_team` STRING COMMENT 'Business team responsible for managing and analyzing this survey.',
    `platform_filter` STRING COMMENT 'Comma-separated list of platforms where the survey is displayed (e.g., PC, console, mobile, all).',
    `privacy_policy_version` STRING COMMENT 'Version of the privacy policy acknowledged by players when taking the survey.',
    `published_timestamp` TIMESTAMP COMMENT 'Timestamp when the survey was published and made active to players.',
    `question_count` STRING COMMENT 'Total number of questions in the survey.',
    `region_filter` STRING COMMENT 'Geographic region(s) where the survey is distributed (e.g., NA, EU, APAC, all).',
    `response_count` STRING COMMENT 'Current count of responses received for this survey.',
    `response_required` BOOLEAN COMMENT 'Indicates whether survey completion is mandatory for the player.',
    `start_date` DATE COMMENT 'Date when the survey becomes active and available to players.',
    `survey_status` STRING COMMENT 'Current lifecycle status of the survey.',
    `survey_code` STRING COMMENT 'Business-readable unique code for the survey (e.g., NPS_Q1_2024, CSAT_POST_MATCH).',
    `survey_type` STRING COMMENT 'Classification of the survey type: Net Promoter Score (NPS), Customer Satisfaction (CSAT), Customer Effort Score (CES), general feedback, bug report, or feature request.',
    `tags` STRING COMMENT 'Comma-separated tags for categorization and search (e.g., seasonal, event-driven, post-launch).',
    `target_audience` STRING COMMENT 'Player segment targeted for this survey.',
    `title` STRING COMMENT 'The display title of the survey shown to players.',
    `trigger_event` STRING COMMENT 'The in-game or platform event that triggers the survey display (e.g., match_completion, level_up, support_ticket_closed).',
    `created_by` STRING COMMENT 'Username or identifier of the community manager or analyst who created the survey.',
    CONSTRAINT pk_survey PRIMARY KEY(`survey_id`)
) COMMENT 'Master reference table for survey. Referenced by survey_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `gaming_ecm`.`community`.`forum` ADD CONSTRAINT `fk_community_forum_parent_forum_id` FOREIGN KEY (`parent_forum_id`) REFERENCES `gaming_ecm`.`community`.`forum`(`forum_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_forum_id` FOREIGN KEY (`forum_id`) REFERENCES `gaming_ecm`.`community`.`forum`(`forum_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ADD CONSTRAINT `fk_community_forum_thread_thread_root_forum_thread_id` FOREIGN KEY (`thread_root_forum_thread_id`) REFERENCES `gaming_ecm`.`community`.`forum_thread`(`forum_thread_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ADD CONSTRAINT `fk_community_forum_post_forum_category_id` FOREIGN KEY (`forum_category_id`) REFERENCES `gaming_ecm`.`community`.`forum_category`(`forum_category_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ADD CONSTRAINT `fk_community_forum_post_forum_thread_id` FOREIGN KEY (`forum_thread_id`) REFERENCES `gaming_ecm`.`community`.`forum_thread`(`forum_thread_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ADD CONSTRAINT `fk_community_forum_post_guild_id` FOREIGN KEY (`guild_id`) REFERENCES `gaming_ecm`.`community`.`guild`(`guild_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ADD CONSTRAINT `fk_community_forum_post_moderation_action_id` FOREIGN KEY (`moderation_action_id`) REFERENCES `gaming_ecm`.`community`.`moderation_action`(`moderation_action_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ADD CONSTRAINT `fk_community_forum_post_parent_post_forum_post_id` FOREIGN KEY (`parent_post_forum_post_id`) REFERENCES `gaming_ecm`.`community`.`forum_post`(`forum_post_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ADD CONSTRAINT `fk_community_forum_post_support_ticket_id` FOREIGN KEY (`support_ticket_id`) REFERENCES `gaming_ecm`.`community`.`support_ticket`(`support_ticket_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ADD CONSTRAINT `fk_community_ugc_review_support_ticket_id` FOREIGN KEY (`support_ticket_id`) REFERENCES `gaming_ecm`.`community`.`support_ticket`(`support_ticket_id`);
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ADD CONSTRAINT `fk_community_ugc_review_ugc_submission_id` FOREIGN KEY (`ugc_submission_id`) REFERENCES `gaming_ecm`.`community`.`ugc_submission`(`ugc_submission_id`);
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ADD CONSTRAINT `fk_community_guild_membership_guild_id` FOREIGN KEY (`guild_id`) REFERENCES `gaming_ecm`.`community`.`guild`(`guild_id`);
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ADD CONSTRAINT `fk_community_ticket_comment_kb_article_id` FOREIGN KEY (`kb_article_id`) REFERENCES `gaming_ecm`.`community`.`kb_article`(`kb_article_id`);
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ADD CONSTRAINT `fk_community_ticket_comment_support_ticket_id` FOREIGN KEY (`support_ticket_id`) REFERENCES `gaming_ecm`.`community`.`support_ticket`(`support_ticket_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_kb_category_id` FOREIGN KEY (`kb_category_id`) REFERENCES `gaming_ecm`.`community`.`kb_category`(`kb_category_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ADD CONSTRAINT `fk_community_kb_article_support_ticket_id` FOREIGN KEY (`support_ticket_id`) REFERENCES `gaming_ecm`.`community`.`support_ticket`(`support_ticket_id`);
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ADD CONSTRAINT `fk_community_moderation_action_support_ticket_id` FOREIGN KEY (`support_ticket_id`) REFERENCES `gaming_ecm`.`community`.`support_ticket`(`support_ticket_id`);
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ADD CONSTRAINT `fk_community_survey_response_support_ticket_id` FOREIGN KEY (`support_ticket_id`) REFERENCES `gaming_ecm`.`community`.`support_ticket`(`support_ticket_id`);
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ADD CONSTRAINT `fk_community_survey_response_survey_id` FOREIGN KEY (`survey_id`) REFERENCES `gaming_ecm`.`community`.`survey`(`survey_id`);
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ADD CONSTRAINT `fk_community_chat_session_support_ticket_id` FOREIGN KEY (`support_ticket_id`) REFERENCES `gaming_ecm`.`community`.`support_ticket`(`support_ticket_id`);
ALTER TABLE `gaming_ecm`.`community`.`community_event` ADD CONSTRAINT `fk_community_community_event_parent_event_community_event_id` FOREIGN KEY (`parent_event_community_event_id`) REFERENCES `gaming_ecm`.`community`.`community_event`(`community_event_id`);
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ADD CONSTRAINT `fk_community_social_connection_guild_id` FOREIGN KEY (`guild_id`) REFERENCES `gaming_ecm`.`community`.`guild`(`guild_id`);
ALTER TABLE `gaming_ecm`.`community`.`ban` ADD CONSTRAINT `fk_community_ban_moderation_action_id` FOREIGN KEY (`moderation_action_id`) REFERENCES `gaming_ecm`.`community`.`moderation_action`(`moderation_action_id`);
ALTER TABLE `gaming_ecm`.`community`.`ban` ADD CONSTRAINT `fk_community_ban_player_report_id` FOREIGN KEY (`player_report_id`) REFERENCES `gaming_ecm`.`community`.`player_report`(`player_report_id`);
ALTER TABLE `gaming_ecm`.`community`.`ban` ADD CONSTRAINT `fk_community_ban_support_ticket_id` FOREIGN KEY (`support_ticket_id`) REFERENCES `gaming_ecm`.`community`.`support_ticket`(`support_ticket_id`);
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ADD CONSTRAINT `fk_community_player_reputation_previous_player_reputation_id` FOREIGN KEY (`previous_player_reputation_id`) REFERENCES `gaming_ecm`.`community`.`player_reputation`(`player_reputation_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_category` ADD CONSTRAINT `fk_community_forum_category_parent_category_id` FOREIGN KEY (`parent_category_id`) REFERENCES `gaming_ecm`.`community`.`forum_category`(`forum_category_id`);
ALTER TABLE `gaming_ecm`.`community`.`forum_category` ADD CONSTRAINT `fk_community_forum_category_parent_forum_category_id` FOREIGN KEY (`parent_forum_category_id`) REFERENCES `gaming_ecm`.`community`.`forum_category`(`forum_category_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_category` ADD CONSTRAINT `fk_community_kb_category_parent_category_id` FOREIGN KEY (`parent_category_id`) REFERENCES `gaming_ecm`.`community`.`kb_category`(`kb_category_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_category` ADD CONSTRAINT `fk_community_kb_category_parent_kb_category_id` FOREIGN KEY (`parent_kb_category_id`) REFERENCES `gaming_ecm`.`community`.`kb_category`(`kb_category_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_section` ADD CONSTRAINT `fk_community_kb_section_kb_article_id` FOREIGN KEY (`kb_article_id`) REFERENCES `gaming_ecm`.`community`.`kb_article`(`kb_article_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_section` ADD CONSTRAINT `fk_community_kb_section_replacement_section_id` FOREIGN KEY (`replacement_section_id`) REFERENCES `gaming_ecm`.`community`.`kb_section`(`kb_section_id`);
ALTER TABLE `gaming_ecm`.`community`.`kb_section` ADD CONSTRAINT `fk_community_kb_section_parent_kb_section_id` FOREIGN KEY (`parent_kb_section_id`) REFERENCES `gaming_ecm`.`community`.`kb_section`(`kb_section_id`);
ALTER TABLE `gaming_ecm`.`community`.`survey` ADD CONSTRAINT `fk_community_survey_follow_up_survey_id` FOREIGN KEY (`follow_up_survey_id`) REFERENCES `gaming_ecm`.`community`.`survey`(`survey_id`);

-- ========= TAGS =========
ALTER SCHEMA `gaming_ecm`.`community` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `gaming_ecm`.`community` SET TAGS ('dbx_domain' = 'community');
ALTER TABLE `gaming_ecm`.`community`.`forum` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`community`.`forum` SET TAGS ('dbx_subdomain' = 'discussion_forums');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `forum_id` SET TAGS ('dbx_business_glossary_term' = 'Forum ID');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `developer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Developer Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `parent_forum_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Forum ID');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `allows_attachments` SET TAGS ('dbx_business_glossary_term' = 'Forum Allows Attachments Flag');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `allows_ugc_submissions` SET TAGS ('dbx_business_glossary_term' = 'Forum Allows User-Generated Content (UGC) Submissions Flag');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forum Archived Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `auto_lock_days_inactive` SET TAGS ('dbx_business_glossary_term' = 'Forum Auto-Lock Inactive Days');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `banner_image_url` SET TAGS ('dbx_business_glossary_term' = 'Forum Banner Image URL');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `banner_image_url` SET TAGS ('dbx_value_regex' = '^https?://.+$');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Forum Content Rating');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `content_rating` SET TAGS ('dbx_value_regex' = 'E|E10+|T|M|AO|RP|PEGI_3|PEGI_7|PEGI_12|PEGI_16|PEGI_18');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Forum Country Code');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forum Created Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `csat_score` SET TAGS ('dbx_business_glossary_term' = 'Forum Customer Satisfaction Score (CSAT)');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `dau` SET TAGS ('dbx_business_glossary_term' = 'Forum Daily Active Users (DAU)');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `depth_level` SET TAGS ('dbx_business_glossary_term' = 'Forum Hierarchy Depth Level');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `forum_category` SET TAGS ('dbx_business_glossary_term' = 'Forum Category');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `forum_description` SET TAGS ('dbx_business_glossary_term' = 'Forum Description');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `forum_name` SET TAGS ('dbx_business_glossary_term' = 'Forum Name');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `forum_status` SET TAGS ('dbx_business_glossary_term' = 'Forum Status');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `forum_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|locked|pending_review');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `forum_type` SET TAGS ('dbx_business_glossary_term' = 'Forum Type');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `forum_type` SET TAGS ('dbx_value_regex' = 'standard|announcement|support|esports|ugc|guild');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `icon_image_url` SET TAGS ('dbx_business_glossary_term' = 'Forum Icon Image URL');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `icon_image_url` SET TAGS ('dbx_value_regex' = '^https?://.+$');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `is_age_restricted` SET TAGS ('dbx_business_glossary_term' = 'Forum Age Restriction Flag');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `is_featured` SET TAGS ('dbx_business_glossary_term' = 'Forum Featured Flag');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `is_pinned` SET TAGS ('dbx_business_glossary_term' = 'Forum Pinned Flag');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `last_post_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forum Last Post Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `locale_code` SET TAGS ('dbx_business_glossary_term' = 'Forum Locale Code');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `locale_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}-[A-Z]{2}$');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `mau` SET TAGS ('dbx_business_glossary_term' = 'Forum Monthly Active Users (MAU)');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `max_post_length_chars` SET TAGS ('dbx_business_glossary_term' = 'Forum Maximum Post Length (Characters)');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `minimum_age_years` SET TAGS ('dbx_business_glossary_term' = 'Forum Minimum Age Requirement (Years)');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `moderation_mode` SET TAGS ('dbx_business_glossary_term' = 'Forum Moderation Mode');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `moderation_mode` SET TAGS ('dbx_value_regex' = 'pre_moderated|post_moderated|auto_moderated|unmoderated');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Forum Net Promoter Score (NPS)');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `post_count` SET TAGS ('dbx_business_glossary_term' = 'Forum Post Count');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `posting_permission` SET TAGS ('dbx_business_glossary_term' = 'Forum Posting Permission');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `posting_permission` SET TAGS ('dbx_value_regex' = 'all_members|verified_only|moderators_only|staff_only');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `requires_account_verification` SET TAGS ('dbx_business_glossary_term' = 'Forum Requires Account Verification Flag');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `rules_url` SET TAGS ('dbx_business_glossary_term' = 'Forum Rules URL');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `rules_url` SET TAGS ('dbx_value_regex' = '^https?://.+$');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `slug` SET TAGS ('dbx_business_glossary_term' = 'Forum URL Slug');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `slug` SET TAGS ('dbx_value_regex' = '^[a-z0-9]+(?:-[a-z0-9]+)*$');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Forum Sort Order');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `subscriber_count` SET TAGS ('dbx_business_glossary_term' = 'Forum Subscriber Count');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `thread_count` SET TAGS ('dbx_business_glossary_term' = 'Forum Thread Count');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forum Last Updated Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `visibility` SET TAGS ('dbx_business_glossary_term' = 'Forum Visibility');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `visibility` SET TAGS ('dbx_value_regex' = 'public|private|members_only|staff_only');
ALTER TABLE `gaming_ecm`.`community`.`forum` ALTER COLUMN `zendesk_group_code` SET TAGS ('dbx_business_glossary_term' = 'Zendesk Support Group ID');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` SET TAGS ('dbx_subdomain' = 'discussion_forums');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `forum_thread_id` SET TAGS ('dbx_business_glossary_term' = 'Forum Thread ID');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `backlog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Backlog Item Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `forum_id` SET TAGS ('dbx_business_glossary_term' = 'Forum ID');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `gacha_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Gacha Pool Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `influencer_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `offer_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Campaign Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Author Player ID');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `seasonal_event_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `thread_root_forum_thread_id` SET TAGS ('dbx_business_glossary_term' = 'Thread Root ID');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `author_display_name` SET TAGS ('dbx_business_glossary_term' = 'Author Display Name');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `author_display_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `author_display_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `author_post_count_at_time` SET TAGS ('dbx_business_glossary_term' = 'Author Post Count at Time of Posting');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `body_content` SET TAGS ('dbx_business_glossary_term' = 'Post Body Content');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `content_language_code` SET TAGS ('dbx_business_glossary_term' = 'Content Language Code');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `content_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `content_rating_category` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Category');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `content_rating_category` SET TAGS ('dbx_value_regex' = 'everyone|teen|mature|adult_only');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `csat_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Score (CSAT)');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `downvote_count` SET TAGS ('dbx_business_glossary_term' = 'Downvote Count');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `edit_count` SET TAGS ('dbx_business_glossary_term' = 'Edit Count');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `flair_label` SET TAGS ('dbx_business_glossary_term' = 'Flair Label');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `is_deleted` SET TAGS ('dbx_business_glossary_term' = 'Is Deleted Flag');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `is_edited` SET TAGS ('dbx_business_glossary_term' = 'Is Edited Flag');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `is_featured` SET TAGS ('dbx_business_glossary_term' = 'Is Featured Flag');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Is Locked Flag');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `is_pinned` SET TAGS ('dbx_business_glossary_term' = 'Is Pinned Flag');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `is_reported` SET TAGS ('dbx_business_glossary_term' = 'Is Reported Flag');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `is_ugc_submission` SET TAGS ('dbx_business_glossary_term' = 'Is User-Generated Content (UGC) Submission Flag');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `last_edited_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Edited Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `last_reply_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reply Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `moderation_action_type` SET TAGS ('dbx_business_glossary_term' = 'Moderation Action Type');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `moderation_action_type` SET TAGS ('dbx_value_regex' = 'none|warned|edited|removed|escalated');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `moderation_note` SET TAGS ('dbx_business_glossary_term' = 'Moderation Note');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `moderation_note` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `moderation_status` SET TAGS ('dbx_business_glossary_term' = 'Moderation Status');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `moderation_status` SET TAGS ('dbx_value_regex' = 'visible|pending_review|removed|flagged|approved');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `moderation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Moderation Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `parent_post_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Post ID');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `platform_source` SET TAGS ('dbx_business_glossary_term' = 'Platform Source');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `platform_source` SET TAGS ('dbx_value_regex' = 'web|mobile_ios|mobile_android|console|steam|epic');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `post_depth_level` SET TAGS ('dbx_business_glossary_term' = 'Post Depth Level');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `post_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Post Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `post_type` SET TAGS ('dbx_business_glossary_term' = 'Post Type');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `post_type` SET TAGS ('dbx_value_regex' = 'thread|reply|announcement|poll|sticky');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `reply_count` SET TAGS ('dbx_business_glossary_term' = 'Reply Count');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `report_count` SET TAGS ('dbx_business_glossary_term' = 'Report Count');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Thread Title');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `upvote_count` SET TAGS ('dbx_business_glossary_term' = 'Upvote Count');
ALTER TABLE `gaming_ecm`.`community`.`forum_thread` ALTER COLUMN `view_count` SET TAGS ('dbx_business_glossary_term' = 'View Count');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` SET TAGS ('dbx_subdomain' = 'discussion_forums');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `forum_post_id` SET TAGS ('dbx_business_glossary_term' = 'Forum Post ID');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `forum_category_id` SET TAGS ('dbx_business_glossary_term' = 'Forum Category ID');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `forum_thread_id` SET TAGS ('dbx_business_glossary_term' = 'Forum Thread ID');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `guild_id` SET TAGS ('dbx_business_glossary_term' = 'Guild / Clan ID');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `moderation_action_id` SET TAGS ('dbx_business_glossary_term' = 'Moderation Action ID');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `parent_post_forum_post_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Post ID');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Author Player ID');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `support_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Zendesk Support Ticket ID');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `author_display_name` SET TAGS ('dbx_business_glossary_term' = 'Author Display Name');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `author_display_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `char_count` SET TAGS ('dbx_business_glossary_term' = 'Post Character Count');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `contains_spoiler` SET TAGS ('dbx_business_glossary_term' = 'Spoiler Content Flag');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `content_warning_flag` SET TAGS ('dbx_business_glossary_term' = 'Content Warning Flag');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Post Created Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `deleted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Post Deleted Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `downvote_count` SET TAGS ('dbx_business_glossary_term' = 'Downvote Count');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `edit_count` SET TAGS ('dbx_business_glossary_term' = 'Post Edit Count');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Author IP Address');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `is_anonymous` SET TAGS ('dbx_business_glossary_term' = 'Anonymous Post Flag');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `is_edited` SET TAGS ('dbx_business_glossary_term' = 'Post Edited Flag');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `is_pinned` SET TAGS ('dbx_business_glossary_term' = 'Pinned Post Flag');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `is_reported` SET TAGS ('dbx_business_glossary_term' = 'Player Reported Flag');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `is_solution` SET TAGS ('dbx_business_glossary_term' = 'Accepted Solution Flag');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `is_staff_post` SET TAGS ('dbx_business_glossary_term' = 'Staff Post Indicator');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Post Language Code');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `last_edited_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Edited Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `moderation_reason` SET TAGS ('dbx_business_glossary_term' = 'Moderation Reason Code');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `moderation_status` SET TAGS ('dbx_business_glossary_term' = 'Moderation Status');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `moderation_status` SET TAGS ('dbx_value_regex' = 'not_reviewed|under_review|approved|actioned|escalated');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `nps_survey_triggered` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Survey Triggered Flag');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `platform_source` SET TAGS ('dbx_business_glossary_term' = 'Platform Source');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `platform_source` SET TAGS ('dbx_value_regex' = 'web|mobile_ios|mobile_android|console_overlay|desktop_client');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `post_body` SET TAGS ('dbx_business_glossary_term' = 'Post Body Content');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `post_body` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `post_format` SET TAGS ('dbx_business_glossary_term' = 'Post Content Format');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `post_format` SET TAGS ('dbx_value_regex' = 'plain_text|markdown|rich_text|bbcode');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `post_number` SET TAGS ('dbx_business_glossary_term' = 'Post Sequence Number');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `post_status` SET TAGS ('dbx_business_glossary_term' = 'Post Status');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `post_status` SET TAGS ('dbx_value_regex' = 'active|hidden|removed|pending_review|locked|deleted');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `post_type` SET TAGS ('dbx_business_glossary_term' = 'Post Type');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `post_type` SET TAGS ('dbx_value_regex' = 'original_post|reply|quote_reply|announcement|pinned');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `reply_count` SET TAGS ('dbx_business_glossary_term' = 'Reply Count');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `report_count` SET TAGS ('dbx_business_glossary_term' = 'Player Report Count');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Post Sentiment Score');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `toxicity_score` SET TAGS ('dbx_business_glossary_term' = 'Post Toxicity Score');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `ugc_attachment_count` SET TAGS ('dbx_business_glossary_term' = 'User-Generated Content (UGC) Attachment Count');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Post Last Updated Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`forum_post` ALTER COLUMN `upvote_count` SET TAGS ('dbx_business_glossary_term' = 'Upvote Count');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` SET TAGS ('dbx_subdomain' = 'content_creation');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `ugc_submission_id` SET TAGS ('dbx_business_glossary_term' = 'User-Generated Content (UGC) Submission ID');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `achievement_id` SET TAGS ('dbx_business_glossary_term' = 'Achievement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Base Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `build_id` SET TAGS ('dbx_business_glossary_term' = 'Build Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `dlc_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Required DLC ID');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `influencer_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `mtx_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Mtx Catalog Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `offer_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Campaign Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `platform_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Sku Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Creator Player ID');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `storefront_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Order Line Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'UGC Approval Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `asset_url` SET TAGS ('dbx_business_glossary_term' = 'UGC Asset URL');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `asset_url` SET TAGS ('dbx_value_regex' = '^https://.*');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `comment_count` SET TAGS ('dbx_business_glossary_term' = 'UGC Comment Count');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `creator_revenue_share_pct` SET TAGS ('dbx_business_glossary_term' = 'Creator Revenue Share Percentage');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `creator_revenue_share_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `download_count` SET TAGS ('dbx_business_glossary_term' = 'UGC Download Count');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `external_submission_code` SET TAGS ('dbx_business_glossary_term' = 'External UGC Submission Code');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `external_submission_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{6,32}$');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `favorite_count` SET TAGS ('dbx_business_glossary_term' = 'UGC Favorite Count');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'UGC File Size (Bytes)');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `game_engine_version` SET TAGS ('dbx_business_glossary_term' = 'Game Engine Version');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `ip_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Clearance Status');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `ip_clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|disputed|rejected');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `is_age_restricted` SET TAGS ('dbx_business_glossary_term' = 'UGC Age Restriction Flag');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `is_cross_platform_compatible` SET TAGS ('dbx_business_glossary_term' = 'UGC Cross-Platform Compatibility Flag');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `is_featured` SET TAGS ('dbx_business_glossary_term' = 'UGC Featured Flag');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `is_monetization_eligible` SET TAGS ('dbx_business_glossary_term' = 'UGC Monetization Eligibility Flag');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'UGC Language Code');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'UGC Last Updated Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'UGC License Type');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'all_rights_reserved|creative_commons|platform_exclusive|open_source');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `moderation_flag` SET TAGS ('dbx_business_glossary_term' = 'UGC Moderation Flag');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `moderation_flag` SET TAGS ('dbx_value_regex' = 'clean|flagged_violence|flagged_adult|flagged_ip_violation|flagged_spam|under_review');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `platform_target` SET TAGS ('dbx_business_glossary_term' = 'UGC Target Platform');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `platform_target` SET TAGS ('dbx_value_regex' = 'PC|console|mobile|cross_platform');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `preview_image_url` SET TAGS ('dbx_business_glossary_term' = 'UGC Preview Image URL');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `preview_image_url` SET TAGS ('dbx_value_regex' = '^https://.*');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `price_virtual_currency` SET TAGS ('dbx_business_glossary_term' = 'UGC Price in Virtual Currency');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `published_date` SET TAGS ('dbx_business_glossary_term' = 'UGC Published Date');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `rating_count` SET TAGS ('dbx_business_glossary_term' = 'UGC Rating Count');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `rating_score` SET TAGS ('dbx_business_glossary_term' = 'UGC Rating Score');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `removal_reason` SET TAGS ('dbx_business_glossary_term' = 'UGC Removal Reason');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `removal_reason` SET TAGS ('dbx_value_regex' = 'creator_request|policy_violation|ip_infringement|spam|platform_decision|other');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `removed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'UGC Removal Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `report_count` SET TAGS ('dbx_business_glossary_term' = 'UGC Player Report Count');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `requires_base_game_dlc` SET TAGS ('dbx_business_glossary_term' = 'UGC Requires Base Game DLC Flag');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `reviewer_notes` SET TAGS ('dbx_business_glossary_term' = 'UGC Reviewer Notes');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `source_platform` SET TAGS ('dbx_business_glossary_term' = 'UGC Source Platform');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'UGC Submission Status');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|removed|archived');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'UGC Submission Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'UGC Submission Tags');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'UGC Submission Title');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `ugc_submission_description` SET TAGS ('dbx_business_glossary_term' = 'UGC Submission Description');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `ugc_type` SET TAGS ('dbx_business_glossary_term' = 'User-Generated Content (UGC) Type');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'UGC Version Number');
ALTER TABLE `gaming_ecm`.`community`.`ugc_submission` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^d+.d+(.d+)?$');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` SET TAGS ('dbx_subdomain' = 'content_creation');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `ugc_review_id` SET TAGS ('dbx_business_glossary_term' = 'User-Generated Content (UGC) Review ID');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `backlog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Backlog Item Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Moderator ID');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `storefront_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Listing Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `support_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Zendesk Support Ticket ID');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `ugc_submission_id` SET TAGS ('dbx_business_glossary_term' = 'User-Generated Content (UGC) Submission ID');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `content_rating_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Compliance Flag');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `coppa_restricted` SET TAGS ('dbx_business_glossary_term' = 'COPPA Restricted Flag');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `deleted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Deleted Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `deletion_reason` SET TAGS ('dbx_business_glossary_term' = 'Deletion Reason');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `deletion_reason` SET TAGS ('dbx_value_regex' = 'player_request|gdpr_erasure|moderation_removal|account_banned|content_violation');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'GDPR Consent Flag');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `helpful_vote_count` SET TAGS ('dbx_business_glossary_term' = 'Helpful Vote Count');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `is_deleted` SET TAGS ('dbx_business_glossary_term' = 'Soft Delete Flag');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `is_edited` SET TAGS ('dbx_business_glossary_term' = 'Review Edited Flag');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `is_featured` SET TAGS ('dbx_business_glossary_term' = 'Featured Review Flag');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `is_spoiler` SET TAGS ('dbx_business_glossary_term' = 'Spoiler Flag');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `is_verified_download` SET TAGS ('dbx_business_glossary_term' = 'Verified Download Flag');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `is_verified_playtime` SET TAGS ('dbx_business_glossary_term' = 'Verified Playtime Flag');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `last_edited_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Last Edited Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `moderation_action_type` SET TAGS ('dbx_business_glossary_term' = 'Moderation Action Type');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `moderation_action_type` SET TAGS ('dbx_value_regex' = 'none|warned|edited|hidden|removed|escalated');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `moderation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Moderation Reason Code');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `moderation_status` SET TAGS ('dbx_business_glossary_term' = 'Moderation Status');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `moderation_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated|removed|under_review');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `moderation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Moderation Action Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `not_helpful_vote_count` SET TAGS ('dbx_business_glossary_term' = 'Not Helpful Vote Count');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Code');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `playtime_at_review_minutes` SET TAGS ('dbx_business_glossary_term' = 'Playtime at Review (Minutes)');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `report_count` SET TAGS ('dbx_business_glossary_term' = 'Player Report Count');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `review_body` SET TAGS ('dbx_business_glossary_term' = 'Review Body Text');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `review_language_code` SET TAGS ('dbx_business_glossary_term' = 'Review Language Code');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `review_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Review Number');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `review_number` SET TAGS ('dbx_value_regex' = '^REV-[0-9]{10}$');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `review_source_channel` SET TAGS ('dbx_business_glossary_term' = 'Review Source Channel');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `review_source_channel` SET TAGS ('dbx_value_regex' = 'in_game|web_portal|mobile_app|steam|epic_store|console_store');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `review_title` SET TAGS ('dbx_business_glossary_term' = 'Review Title');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'written|video|screenshot|quick_rating');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `reviewer_account_age_days` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Account Age (Days)');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `reviewer_total_reviews` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Total Review Count');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `sentiment_label` SET TAGS ('dbx_business_glossary_term' = 'Review Sentiment Label');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `sentiment_label` SET TAGS ('dbx_value_regex' = 'positive|neutral|negative|mixed');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Review Sentiment Score');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `star_rating` SET TAGS ('dbx_business_glossary_term' = 'Star Rating');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Submitted Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `total_vote_count` SET TAGS ('dbx_business_glossary_term' = 'Total Vote Count');
ALTER TABLE `gaming_ecm`.`community`.`ugc_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`guild` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`community`.`guild` SET TAGS ('dbx_subdomain' = 'social_groups');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `guild_id` SET TAGS ('dbx_business_glossary_term' = 'Guild ID');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Founder Player ID');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `age_restricted` SET TAGS ('dbx_business_glossary_term' = 'Guild Age Restriction Flag');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `banner_asset_ref` SET TAGS ('dbx_business_glossary_term' = 'Guild Banner Asset Reference');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Guild Content Rating');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `content_rating` SET TAGS ('dbx_value_regex' = 'E|E10+|T|M|AO|RP');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Guild Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `disbanded_date` SET TAGS ('dbx_business_glossary_term' = 'Guild Disbanded Date');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `discord_server_code` SET TAGS ('dbx_business_glossary_term' = 'Guild Discord Server ID');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `discord_server_code` SET TAGS ('dbx_value_regex' = '^[0-9]{17,20}$');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `emblem_asset_ref` SET TAGS ('dbx_business_glossary_term' = 'Guild Emblem Asset Reference');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `external_website_url` SET TAGS ('dbx_business_glossary_term' = 'Guild External Website URL');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `founded_date` SET TAGS ('dbx_business_glossary_term' = 'Guild Founded Date');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `guild_description` SET TAGS ('dbx_business_glossary_term' = 'Guild Description');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `guild_name` SET TAGS ('dbx_business_glossary_term' = 'Guild Name');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `guild_status` SET TAGS ('dbx_business_glossary_term' = 'Guild Status');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `guild_status` SET TAGS ('dbx_value_regex' = 'active|inactive|disbanded|suspended|pending');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `guild_type` SET TAGS ('dbx_business_glossary_term' = 'Guild Type');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `guild_type` SET TAGS ('dbx_value_regex' = 'casual|competitive|roleplay|social|esports|pve');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `is_esports_org` SET TAGS ('dbx_business_glossary_term' = 'Esports Organization Flag');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `is_verified` SET TAGS ('dbx_business_glossary_term' = 'Guild Verified Flag');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Guild Primary Language Code');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}(-[A-Z]{2})?$');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Guild Last Activity Date');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `member_capacity` SET TAGS ('dbx_business_glossary_term' = 'Guild Member Capacity');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `member_count` SET TAGS ('dbx_business_glossary_term' = 'Guild Member Count');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `min_player_level` SET TAGS ('dbx_business_glossary_term' = 'Guild Minimum Player Level Requirement');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `moderation_flag` SET TAGS ('dbx_business_glossary_term' = 'Guild Moderation Flag');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `moderation_reason` SET TAGS ('dbx_business_glossary_term' = 'Guild Moderation Reason');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `moderation_reason` SET TAGS ('dbx_value_regex' = 'harassment|hate_speech|cheating|spam|inappropriate_content|other');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Guild Net Promoter Score (NPS)');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Guild Platform');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `platform` SET TAGS ('dbx_value_regex' = 'PC|PlayStation|Xbox|Nintendo|Mobile|CrossPlatform');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `prestige_level` SET TAGS ('dbx_business_glossary_term' = 'Guild Prestige Level');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `privacy_level` SET TAGS ('dbx_business_glossary_term' = 'Guild Privacy Level');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `privacy_level` SET TAGS ('dbx_value_regex' = 'public|private|unlisted');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `pve_focus` SET TAGS ('dbx_business_glossary_term' = 'Player versus Environment (PvE) Focus Flag');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `pvp_focus` SET TAGS ('dbx_business_glossary_term' = 'Player versus Player (PvP) Focus Flag');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `recruitment_status` SET TAGS ('dbx_business_glossary_term' = 'Guild Recruitment Status');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `recruitment_status` SET TAGS ('dbx_value_regex' = 'open|invite_only|closed|application');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Guild Region');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = 'NA|EU|APAC|LATAM|MEA|OCE');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Guild Source System');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'GameAnalytics|Amplitude|Salesforce|Custom');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `tag` SET TAGS ('dbx_business_glossary_term' = 'Guild Tag');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `tag` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Guild Record Last Updated Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `weekly_active_members` SET TAGS ('dbx_business_glossary_term' = 'Guild Weekly Active Members (WAM)');
ALTER TABLE `gaming_ecm`.`community`.`guild` ALTER COLUMN `xp_total` SET TAGS ('dbx_business_glossary_term' = 'Guild Total Experience Points (XP)');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` SET TAGS ('dbx_subdomain' = 'social_groups');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `guild_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Membership ID');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `guild_id` SET TAGS ('dbx_business_glossary_term' = 'Guild ID');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `activity_status` SET TAGS ('dbx_business_glossary_term' = 'Guild Member Activity Status');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `activity_status` SET TAGS ('dbx_value_regex' = 'highly_active|active|low_activity|dormant');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Consent Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `contribution_score` SET TAGS ('dbx_business_glossary_term' = 'Guild Contribution Score');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `csat_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Score (CSAT)');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `current_role_since_date` SET TAGS ('dbx_business_glossary_term' = 'Current Role Since Date');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `data_processing_consent` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Consent Flag');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `departure_date` SET TAGS ('dbx_business_glossary_term' = 'Guild Departure Date');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `departure_reason` SET TAGS ('dbx_business_glossary_term' = 'Guild Departure Reason');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `departure_reason` SET TAGS ('dbx_value_regex' = 'voluntary_leave|kicked|guild_disbanded|inactivity_removal|account_banned|transferred');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `guild_chat_messages_sent` SET TAGS ('dbx_business_glossary_term' = 'Guild Chat Messages Sent');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `guild_events_participated` SET TAGS ('dbx_business_glossary_term' = 'Guild Events Participated');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `has_promotion_history` SET TAGS ('dbx_business_glossary_term' = 'Has Promotion History Flag');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `invite_source` SET TAGS ('dbx_business_glossary_term' = 'Guild Invite Source');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `invite_source` SET TAGS ('dbx_value_regex' = 'direct_invite|recruitment_post|referral|auto_match|social_import|in_game_search');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `is_age_verified` SET TAGS ('dbx_business_glossary_term' = 'Age Verification Flag');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `is_founder` SET TAGS ('dbx_business_glossary_term' = 'Guild Founder Flag');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `is_muted` SET TAGS ('dbx_business_glossary_term' = 'Guild Chat Muted Flag');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `join_date` SET TAGS ('dbx_business_glossary_term' = 'Guild Join Date');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `join_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Guild Join Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `last_active_date` SET TAGS ('dbx_business_glossary_term' = 'Last Active Date');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `membership_role` SET TAGS ('dbx_business_glossary_term' = 'Guild Membership Role');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `membership_role` SET TAGS ('dbx_value_regex' = 'leader|officer|member|recruit|veteran');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Guild Membership Status');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|departed|pending');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `membership_tier` SET TAGS ('dbx_business_glossary_term' = 'Guild Membership Tier');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `membership_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum|elite');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `mute_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Guild Chat Mute Expiry Date');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Guild Membership Notes');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Code');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `previous_role` SET TAGS ('dbx_business_glossary_term' = 'Previous Guild Role');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `previous_role` SET TAGS ('dbx_value_regex' = 'leader|officer|member|recruit|veteran');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `pvp_wins_for_guild` SET TAGS ('dbx_business_glossary_term' = 'Player versus Player (PvP) Wins for Guild');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `referrals_made` SET TAGS ('dbx_business_glossary_term' = 'Guild Referrals Made');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `reports_received` SET TAGS ('dbx_business_glossary_term' = 'Player Reports Received');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `reports_submitted` SET TAGS ('dbx_business_glossary_term' = 'Player Reports Submitted');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `resources_donated` SET TAGS ('dbx_business_glossary_term' = 'Resources Donated to Guild');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'GAMEANALYTICS|AMPLITUDE|SALESFORCE|ZENDESK|INTERNAL');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `support_tickets_raised` SET TAGS ('dbx_business_glossary_term' = 'Support Tickets Raised');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `total_guild_sessions` SET TAGS ('dbx_business_glossary_term' = 'Total Guild Sessions');
ALTER TABLE `gaming_ecm`.`community`.`guild_membership` ALTER COLUMN `weekly_active_days` SET TAGS ('dbx_business_glossary_term' = 'Weekly Active Days (WAU Proxy)');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` SET TAGS ('dbx_subdomain' = 'player_support');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `support_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Support Ticket ID');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `battle_pass_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Battle Pass Entitlement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `compatibility_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Profile Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `compliance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `compliance_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `defect_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `dlc_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Dlc Entitlement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `drm_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Drm Entitlement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Agent ID');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `iap_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Iap Transaction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `patch_release_id` SET TAGS ('dbx_business_glossary_term' = 'Patch Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `platform_cert_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Cert Submission Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Reported Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `bot_handled_flag` SET TAGS ('dbx_business_glossary_term' = 'Bot Handled Flag');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Support Channel');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'email|chat|in_game|web|api|voice');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `closed_at` SET TAGS ('dbx_business_glossary_term' = 'Ticket Closed Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `comment_count` SET TAGS ('dbx_business_glossary_term' = 'Comment Count');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `coppa_minor_flag` SET TAGS ('dbx_business_glossary_term' = 'COPPA Minor Flag');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `csat_comment` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Comment');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `csat_comment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `csat_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Score');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `due_at` SET TAGS ('dbx_business_glossary_term' = 'Ticket Due Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `escalation_tier` SET TAGS ('dbx_business_glossary_term' = 'Escalation Tier');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `first_response_at` SET TAGS ('dbx_business_glossary_term' = 'First Response Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `first_response_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'First Response Time (Seconds)');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `game_version` SET TAGS ('dbx_business_glossary_term' = 'Game Version');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `game_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `gdpr_data_request_flag` SET TAGS ('dbx_business_glossary_term' = 'GDPR Data Request Flag');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `group_name` SET TAGS ('dbx_business_glossary_term' = 'Support Group Name');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `is_first_contact_resolved` SET TAGS ('dbx_business_glossary_term' = 'First Contact Resolution (FCR) Flag');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `issue_category` SET TAGS ('dbx_business_glossary_term' = 'Issue Category');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `issue_category` SET TAGS ('dbx_value_regex' = 'billing|technical|account|gameplay|harassment|other');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `issue_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Issue Subcategory');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `knowledge_base_article_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Base Article ID');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `last_assignee_update_at` SET TAGS ('dbx_business_glossary_term' = 'Last Agent Update Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `last_requester_update_at` SET TAGS ('dbx_business_glossary_term' = 'Last Player Update Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `locale` SET TAGS ('dbx_business_glossary_term' = 'Player Locale');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `locale` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `opened_at` SET TAGS ('dbx_business_glossary_term' = 'Ticket Opened Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `organization_code` SET TAGS ('dbx_business_glossary_term' = 'Organization ID');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Gaming Platform');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `player_account_type` SET TAGS ('dbx_business_glossary_term' = 'Player Account Type');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `player_account_type` SET TAGS ('dbx_value_regex' = 'f2p|premium|subscriber|whale|vip');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `reopen_count` SET TAGS ('dbx_business_glossary_term' = 'Ticket Reopen Count');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `resolution_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Resolution Time (Seconds)');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Satisfaction Rating Status');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `satisfaction_rating` SET TAGS ('dbx_value_regex' = 'good|bad|unoffered|offered');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Flag');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `solved_at` SET TAGS ('dbx_business_glossary_term' = 'Ticket Solved Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Ticket Subject');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `support_ticket_description` SET TAGS ('dbx_business_glossary_term' = 'Ticket Description');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `support_ticket_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Ticket Tags');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `ticket_priority` SET TAGS ('dbx_business_glossary_term' = 'Ticket Priority');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `ticket_priority` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `ticket_status` SET TAGS ('dbx_business_glossary_term' = 'Ticket Status');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `ticket_status` SET TAGS ('dbx_value_regex' = 'new|open|pending|on_hold|solved|closed');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`support_ticket` ALTER COLUMN `zendesk_ticket_code` SET TAGS ('dbx_business_glossary_term' = 'Zendesk Ticket ID');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` SET TAGS ('dbx_subdomain' = 'player_support');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `ticket_comment_id` SET TAGS ('dbx_business_glossary_term' = 'Ticket Comment ID');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Support Agent ID');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `kb_article_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Base Article ID');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Comment Author ID');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `support_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Support Ticket ID');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `agent_display_name` SET TAGS ('dbx_business_glossary_term' = 'Agent Display Name');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `author_type` SET TAGS ('dbx_business_glossary_term' = 'Comment Author Type');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `author_type` SET TAGS ('dbx_value_regex' = 'player|agent|bot|system');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `channel_source` SET TAGS ('dbx_business_glossary_term' = 'Channel Source');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `comment_body` SET TAGS ('dbx_business_glossary_term' = 'Comment Body');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `comment_body` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `comment_body_html` SET TAGS ('dbx_business_glossary_term' = 'Comment Body HTML');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `comment_body_html` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `comment_sequence` SET TAGS ('dbx_business_glossary_term' = 'Comment Sequence Number');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `comment_type` SET TAGS ('dbx_business_glossary_term' = 'Comment Type');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `comment_type` SET TAGS ('dbx_value_regex' = 'Comment|VoiceComment|TweetComment|FacebookComment|InstagramDm|NativeMessaging');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `coppa_restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'COPPA Restricted Flag');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Comment Created Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'zendesk');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `edit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Comment Edit Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `gdpr_erasure_flag` SET TAGS ('dbx_business_glossary_term' = 'GDPR Erasure Flag');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `ingested_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Ingested Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Automated Comment Flag');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `is_edited` SET TAGS ('dbx_business_glossary_term' = 'Comment Edited Flag');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `is_first_response` SET TAGS ('dbx_business_glossary_term' = 'First Response Flag');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `is_public` SET TAGS ('dbx_business_glossary_term' = 'Public Comment Flag');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `is_resolution_comment` SET TAGS ('dbx_business_glossary_term' = 'Resolution Comment Flag');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Comment Language Code');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `macro_code` SET TAGS ('dbx_business_glossary_term' = 'Zendesk Macro ID');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `moderation_reason` SET TAGS ('dbx_business_glossary_term' = 'Moderation Reason');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `moderation_status` SET TAGS ('dbx_business_glossary_term' = 'Comment Moderation Status');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `moderation_status` SET TAGS ('dbx_value_regex' = 'approved|pending_review|flagged|removed');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Code');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `player_display_name` SET TAGS ('dbx_business_glossary_term' = 'Player Display Name');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `player_display_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `player_display_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `response_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Response Time Seconds');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `satisfaction_comment` SET TAGS ('dbx_business_glossary_term' = 'CSAT Satisfaction Comment');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `satisfaction_comment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'CSAT Satisfaction Rating');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `satisfaction_rating` SET TAGS ('dbx_value_regex' = 'good|bad|unoffered');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Comment Sentiment Score');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `ticket_status_at_comment` SET TAGS ('dbx_business_glossary_term' = 'Ticket Status at Comment');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `ticket_status_at_comment` SET TAGS ('dbx_value_regex' = 'new|open|pending|hold|solved|closed');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Comment Updated Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `via_source` SET TAGS ('dbx_business_glossary_term' = 'Via Source');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `word_count` SET TAGS ('dbx_business_glossary_term' = 'Comment Word Count');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `zendesk_comment_code` SET TAGS ('dbx_business_glossary_term' = 'Zendesk Comment ID');
ALTER TABLE `gaming_ecm`.`community`.`ticket_comment` ALTER COLUMN `zendesk_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Zendesk Ticket Number');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` SET TAGS ('dbx_subdomain' = 'player_support');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `kb_article_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Base (KB) Article ID');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Related Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `kb_category_id` SET TAGS ('dbx_business_glossary_term' = 'Article Category ID');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `certification_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Checklist Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Author Agent ID');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `reviewer_agent_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Agent ID');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `reviewer_agent_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `reviewer_agent_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `subscription_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Plan Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `support_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Source Ticket ID');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `archived_at` SET TAGS ('dbx_business_glossary_term' = 'Archived At Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `article_type` SET TAGS ('dbx_business_glossary_term' = 'Article Type');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `article_type` SET TAGS ('dbx_value_regex' = 'how_to|faq|troubleshooting|policy|release_notes|known_issue');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `comment_count` SET TAGS ('dbx_business_glossary_term' = 'Article Comment Count');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `content_body` SET TAGS ('dbx_business_glossary_term' = 'Article Content Body');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `content_format` SET TAGS ('dbx_business_glossary_term' = 'Content Format');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `content_format` SET TAGS ('dbx_value_regex' = 'html|markdown|plain_text');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `content_version` SET TAGS ('dbx_business_glossary_term' = 'Content Version Number');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `coppa_restricted` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Restricted Flag');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `deflection_rate` SET TAGS ('dbx_business_glossary_term' = 'Ticket Deflection Rate');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `esrb_content_flag` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Software Rating Board (ESRB) Content Flag');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `gdpr_data_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Data Reference Flag');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `helpful_vote_count` SET TAGS ('dbx_business_glossary_term' = 'Helpful Vote Count');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `is_comments_enabled` SET TAGS ('dbx_business_glossary_term' = 'Is Comments Enabled Flag');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `is_promoted` SET TAGS ('dbx_business_glossary_term' = 'Is Promoted Article Flag');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `label_names` SET TAGS ('dbx_business_glossary_term' = 'Article Label Names');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `last_accuracy_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Accuracy Review Date');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `last_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Last Updated At Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `locale` SET TAGS ('dbx_business_glossary_term' = 'Language Locale');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `locale` SET TAGS ('dbx_value_regex' = '^[a-z]{2}-[A-Z]{2}$');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `permission_group` SET TAGS ('dbx_business_glossary_term' = 'Article Permission Group');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `permission_group` SET TAGS ('dbx_value_regex' = 'everyone|signed_in|agents_only');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Target Platform');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `publication_status` SET TAGS ('dbx_business_glossary_term' = 'Publication Status');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `publication_status` SET TAGS ('dbx_value_regex' = 'draft|published|archived');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `published_at` SET TAGS ('dbx_business_glossary_term' = 'Published At Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `reading_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Reading Time (Minutes)');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `related_article_ids` SET TAGS ('dbx_business_glossary_term' = 'Related Article IDs');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Content Review Status');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending_review|approved|needs_update|flagged');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `search_rank_score` SET TAGS ('dbx_business_glossary_term' = 'Search Rank Score');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `section_id` SET TAGS ('dbx_business_glossary_term' = 'Article Section ID');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `seo_slug` SET TAGS ('dbx_business_glossary_term' = 'Search Engine Optimization (SEO) URL Slug');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `seo_slug` SET TAGS ('dbx_value_regex' = '^[a-z0-9]+(?:-[a-z0-9]+)*$');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'zendesk|internal_cms|imported');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Article Title');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `unhelpful_vote_count` SET TAGS ('dbx_business_glossary_term' = 'Unhelpful Vote Count');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `view_count` SET TAGS ('dbx_business_glossary_term' = 'Article View Count');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `vote_sum` SET TAGS ('dbx_business_glossary_term' = 'Article Vote Sum');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `word_count` SET TAGS ('dbx_business_glossary_term' = 'Article Word Count');
ALTER TABLE `gaming_ecm`.`community`.`kb_article` ALTER COLUMN `zendesk_article_code` SET TAGS ('dbx_business_glossary_term' = 'Zendesk Article ID');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` SET TAGS ('dbx_subdomain' = 'content_creation');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `moderation_action_id` SET TAGS ('dbx_business_glossary_term' = 'Moderation Action ID');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `ad_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Creative Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `backlog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Backlog Item Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `compliance_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Moderator Agent ID');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Target Player ID');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `refund_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `support_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Zendesk Ticket ID');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Violating Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `action_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Moderation Action Reference Number');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `action_reference_number` SET TAGS ('dbx_value_regex' = '^MOD-[0-9]{8,12}$');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Moderation Action Status');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'active|expired|reinstated|overturned|pending');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `action_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Moderation Action Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Moderation Action Type');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'warn|mute|temp_ban|perma_ban|content_removal|escalation');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `appeal_eligible` SET TAGS ('dbx_business_glossary_term' = 'Appeal Eligible Flag');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'upheld|overturned|modified|pending');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `appeal_resolved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Appeal Resolved Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'not_submitted|submitted|under_review|resolved|withdrawn');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `appeal_submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Appeal Submitted Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `automation_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Automation Confidence Score');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `ban_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Ban Duration (Hours)');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `ban_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ban End Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `ban_scope` SET TAGS ('dbx_business_glossary_term' = 'Ban Scope');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `ban_scope` SET TAGS ('dbx_value_regex' = 'forum|chat|ugc|all_community|game');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `content_category` SET TAGS ('dbx_business_glossary_term' = 'Content Category');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `escalation_tier` SET TAGS ('dbx_business_glossary_term' = 'Escalation Tier');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `escalation_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|legal');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Reference');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Is Automated Action Flag');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `is_permanent` SET TAGS ('dbx_business_glossary_term' = 'Is Permanent Ban Flag');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `moderator_notes` SET TAGS ('dbx_business_glossary_term' = 'Moderator Internal Notes');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Player Notification Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Code');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `player_notified` SET TAGS ('dbx_business_glossary_term' = 'Player Notified Flag');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `prior_action_count` SET TAGS ('dbx_business_glossary_term' = 'Prior Moderation Action Count');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Moderation Reason Code');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Moderation Reason Description');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `regulatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Flag');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `regulatory_framework_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Code');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `reinstatement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `reported_content_reference` SET TAGS ('dbx_business_glossary_term' = 'Reported Content ID');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Moderation Severity Level');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'zendesk|in_game_report|auto_detection|moderator_initiated|community_portal');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `target_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Target Entity Reference');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `target_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Target Entity Type');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `target_entity_type` SET TAGS ('dbx_value_regex' = 'player_account|forum_post|ugc_submission|chat_message|guild|review');
ALTER TABLE `gaming_ecm`.`community`.`moderation_action` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`player_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`community`.`player_report` SET TAGS ('dbx_subdomain' = 'content_creation');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `player_report_id` SET TAGS ('dbx_business_glossary_term' = 'Player Report ID');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `ad_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Creative Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `backlog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Backlog Item Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `build_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Build Submission Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `compliance_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `crossplay_feature_id` SET TAGS ('dbx_business_glossary_term' = 'Crossplay Feature Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `defect_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Moderator ID');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `gacha_pull_id` SET TAGS ('dbx_business_glossary_term' = 'Gacha Pull Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Game Session ID');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `iap_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Iap Transaction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `match_id` SET TAGS ('dbx_business_glossary_term' = 'Match ID');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Player ID');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `refund_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Reported Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `appeal_resolved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Appeal Resolved Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'not_appealed|appeal_pending|appeal_upheld|appeal_denied');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `auto_moderation_score` SET TAGS ('dbx_business_glossary_term' = 'Auto-Moderation Confidence Score');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `content_rating_concern` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Concern');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `content_rating_concern` SET TAGS ('dbx_value_regex' = 'none|violence|sexual_content|hate_speech|drug_reference|language');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `evidence_attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Evidence Attachment Count');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `evidence_attachment_urls` SET TAGS ('dbx_business_glossary_term' = 'Evidence Attachment URLs');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `incident_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `is_automated_flag` SET TAGS ('dbx_business_glossary_term' = 'Is Automated Flag');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `is_minor_involved` SET TAGS ('dbx_business_glossary_term' = 'Is Minor Involved Flag');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `is_repeat_report` SET TAGS ('dbx_business_glossary_term' = 'Is Repeat Report Flag');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `moderation_queue` SET TAGS ('dbx_business_glossary_term' = 'Moderation Queue');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `moderation_queue` SET TAGS ('dbx_value_regex' = 'standard|priority|trust_and_safety|legal|automated');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `report_description` SET TAGS ('dbx_business_glossary_term' = 'Report Description');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Report Number');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `report_number` SET TAGS ('dbx_value_regex' = '^RPT-[0-9]{10}$');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `report_source_channel` SET TAGS ('dbx_business_glossary_term' = 'Report Source Channel');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `report_source_channel` SET TAGS ('dbx_value_regex' = 'in_game|web_portal|mobile_app|zendesk|community_forum|discord');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'pending|under_review|actioned|dismissed|escalated|closed');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `reported_entity_prior_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Reported Entity Prior Violation Count');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `reported_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Reported Entity ID');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `reported_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Reported Entity Type');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `reported_entity_type` SET TAGS ('dbx_value_regex' = 'player|post|ugc|chat|clan|profile');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `reporter_account_age_days` SET TAGS ('dbx_business_glossary_term' = 'Reporter Account Age (Days)');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `reporter_prior_report_count` SET TAGS ('dbx_business_glossary_term' = 'Reporter Prior Report Count');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `resolution_action` SET TAGS ('dbx_value_regex' = 'warning_issued|account_suspended|account_banned|content_removed|no_action|escalated_to_trust_safety');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `resolution_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Resolution Time (Hours)');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `resolved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Resolved Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Reviewed Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Resolution Hours');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Submitted Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `violation_category` SET TAGS ('dbx_business_glossary_term' = 'Violation Category');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `violation_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Violation Subcategory');
ALTER TABLE `gaming_ecm`.`community`.`player_report` ALTER COLUMN `zendesk_ticket_code` SET TAGS ('dbx_business_glossary_term' = 'Zendesk Ticket ID');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` SET TAGS ('dbx_subdomain' = 'player_support');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `survey_response_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Response Identifier');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `player_ltv_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Player Ltv Segment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `promo_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Redemption Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `support_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Support Ticket ID');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `survey_id` SET TAGS ('dbx_business_glossary_term' = 'Survey ID');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `answered_question_count` SET TAGS ('dbx_business_glossary_term' = 'Answered Question Count');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `ces_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Effort Score (CES) Score');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `collection_channel` SET TAGS ('dbx_business_glossary_term' = 'Collection Channel');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `collection_channel` SET TAGS ('dbx_value_regex' = 'in_game|email|push_notification|web_portal|support_chat|post_ticket');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `coppa_verified_age` SET TAGS ('dbx_business_glossary_term' = 'COPPA Verified Age');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `csat_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Score (CSAT) Score');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `custom_score` SET TAGS ('dbx_business_glossary_term' = 'Custom Survey Score');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'zendesk|salesforce|in_game_sdk|email_platform|web_portal|amplitude');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'smartphone|tablet|PC|console|handheld|VR_headset');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `esrb_rating_context` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Software Rating Board (ESRB) Rating Context');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `esrb_rating_context` SET TAGS ('dbx_value_regex' = 'E|E10+|T|M|AO|RP');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `followup_status` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Status');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `followup_status` SET TAGS ('dbx_value_regex' = 'pending|contacted|resolved|no_action_required|opted_out');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `game_version` SET TAGS ('dbx_business_glossary_term' = 'Game Version');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `gdpr_consent_recorded` SET TAGS ('dbx_business_glossary_term' = 'GDPR Consent Recorded');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `is_anonymous` SET TAGS ('dbx_business_glossary_term' = 'Is Anonymous Response');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `is_opted_in_followup` SET TAGS ('dbx_business_glossary_term' = 'Is Opted In for Follow-Up');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `k_factor_referral_code` SET TAGS ('dbx_business_glossary_term' = 'K-Factor (Viral Coefficient) Referral Code');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `moderation_flag` SET TAGS ('dbx_business_glossary_term' = 'Moderation Flag');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `moderation_flag` SET TAGS ('dbx_value_regex' = 'clean|flagged|reviewed|removed');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `nps_category` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Category');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `nps_category` SET TAGS ('dbx_value_regex' = 'promoter|passive|detractor');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Score');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Platform');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `platform` SET TAGS ('dbx_value_regex' = 'PC|console|mobile|web|cross_platform');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `player_country_code` SET TAGS ('dbx_business_glossary_term' = 'Player Country Code');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `player_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `player_segment` SET TAGS ('dbx_business_glossary_term' = 'Player Segment');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `player_tenure_days` SET TAGS ('dbx_business_glossary_term' = 'Player Tenure Days');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `question_count` SET TAGS ('dbx_business_glossary_term' = 'Question Count');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `response_completion_seconds` SET TAGS ('dbx_business_glossary_term' = 'Response Completion Time (Seconds)');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `response_external_ref` SET TAGS ('dbx_business_glossary_term' = 'Response External Reference');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `response_language` SET TAGS ('dbx_business_glossary_term' = 'Response Language');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `response_status` SET TAGS ('dbx_value_regex' = 'submitted|partial|abandoned|disqualified|duplicate');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `sentiment_label` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Label');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `sentiment_label` SET TAGS ('dbx_value_regex' = 'positive|neutral|negative|mixed');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `survey_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Survey Sent Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `survey_trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Survey Trigger Event');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'NPS|CSAT|CES|custom|onboarding|exit');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `survey_version` SET TAGS ('dbx_business_glossary_term' = 'Survey Version');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `verbatim_feedback` SET TAGS ('dbx_business_glossary_term' = 'Verbatim Feedback');
ALTER TABLE `gaming_ecm`.`community`.`survey_response` ALTER COLUMN `verbatim_feedback` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` SET TAGS ('dbx_subdomain' = 'content_creation');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `player_feedback_id` SET TAGS ('dbx_business_glossary_term' = 'Player Feedback ID');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `ad_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Creative Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `backlog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Backlog Item Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `build_id` SET TAGS ('dbx_business_glossary_term' = 'Build ID');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `build_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Build Submission Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `patch_release_id` SET TAGS ('dbx_business_glossary_term' = 'Patch Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `privacy_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Impact Assessment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `regulatory_change_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Reported Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `content_reference` SET TAGS ('dbx_business_glossary_term' = 'Content ID');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'console|pc|mobile|handheld|vr_headset');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `esrb_content_flag` SET TAGS ('dbx_business_glossary_term' = 'ESRB Content Flag');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `feedback_body` SET TAGS ('dbx_business_glossary_term' = 'Feedback Body Text');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `feedback_body` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `feedback_category` SET TAGS ('dbx_business_glossary_term' = 'Feedback Category');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `feedback_category` SET TAGS ('dbx_value_regex' = 'gameplay|ui|performance|content|monetization|other');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `feedback_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Feedback Reference Number');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `feedback_reference_number` SET TAGS ('dbx_value_regex' = '^FB-[0-9]{8,12}$');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `feedback_status` SET TAGS ('dbx_business_glossary_term' = 'Feedback Status');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `feedback_status` SET TAGS ('dbx_value_regex' = 'submitted|under_review|actioned|closed|duplicate|rejected');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `feedback_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Feedback Subcategory');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `feedback_title` SET TAGS ('dbx_business_glossary_term' = 'Feedback Title');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `game_mode` SET TAGS ('dbx_business_glossary_term' = 'Game Mode');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `game_version` SET TAGS ('dbx_business_glossary_term' = 'Game Version');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `game_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `is_beta_participant` SET TAGS ('dbx_business_glossary_term' = 'Is Beta Participant Flag');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `is_moderated` SET TAGS ('dbx_business_glossary_term' = 'Is Moderated Flag');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `is_paying_player` SET TAGS ('dbx_business_glossary_term' = 'Is Paying Player Flag');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `jira_issue_key` SET TAGS ('dbx_business_glossary_term' = 'Jira Issue Key');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `jira_issue_key` SET TAGS ('dbx_value_regex' = '^[A-Z]+-[0-9]+$');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `map_or_level_name` SET TAGS ('dbx_business_glossary_term' = 'Map or Level Name');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `moderation_outcome` SET TAGS ('dbx_business_glossary_term' = 'Moderation Outcome');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `moderation_outcome` SET TAGS ('dbx_value_regex' = 'approved|flagged|removed|escalated|pending');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `moderation_reason` SET TAGS ('dbx_business_glossary_term' = 'Moderation Reason');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `pii_detected` SET TAGS ('dbx_business_glossary_term' = 'PII Detected Flag');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Platform');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `player_account_age_days` SET TAGS ('dbx_business_glossary_term' = 'Player Account Age (Days)');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `player_rating` SET TAGS ('dbx_business_glossary_term' = 'Player Rating');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `player_segment` SET TAGS ('dbx_business_glossary_term' = 'Player Segment');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `sentiment_classification` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Classification');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `sentiment_classification` SET TAGS ('dbx_value_regex' = 'positive|neutral|negative|mixed');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `sentiment_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Confidence Score');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `session_length_seconds` SET TAGS ('dbx_business_glossary_term' = 'Session Length (Seconds)');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'in_game_sdk|community_portal|zendesk|gameanalytics|amplitude|manual_entry');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `submission_channel` SET TAGS ('dbx_business_glossary_term' = 'Submission Channel');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `submission_channel` SET TAGS ('dbx_value_regex' = 'in_game_tool|community_portal|beta_channel|playtesting|support_ticket|social_media');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Feedback Submitted Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `upvote_count` SET TAGS ('dbx_business_glossary_term' = 'Upvote Count');
ALTER TABLE `gaming_ecm`.`community`.`player_feedback` ALTER COLUMN `zendesk_ticket_code` SET TAGS ('dbx_business_glossary_term' = 'Zendesk Ticket ID');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` SET TAGS ('dbx_subdomain' = 'social_groups');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `viral_referral_id` SET TAGS ('dbx_business_glossary_term' = 'Viral Referral ID');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `promo_code_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Promo Code Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Campaign ID');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Player ID');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `attribution_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Attribution Confidence Score');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `attribution_provider` SET TAGS ('dbx_business_glossary_term' = 'Attribution Provider');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `attribution_provider` SET TAGS ('dbx_value_regex' = 'appsflyer|adjust|internal|branch|singular');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `clicked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Referral Link Clicked Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `converted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Referral Conversion Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Referred Player Country Code');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `days_to_conversion` SET TAGS ('dbx_business_glossary_term' = 'Days to Conversion');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Referred Player Device Type');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'smartphone|tablet|pc|console|smart_tv');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `first_iap_flag` SET TAGS ('dbx_business_glossary_term' = 'First In-App Purchase (IAP) Flag');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Referral Fraud Flag');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `fraud_reason` SET TAGS ('dbx_business_glossary_term' = 'Referral Fraud Reason');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `fraud_reason` SET TAGS ('dbx_value_regex' = 'self_referral|duplicate_device|bot_install|vpn_detected|velocity_abuse|none');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `ftue_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'First-Time User Experience (FTUE) Completed Flag');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `installed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Game Install Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `k_factor_contribution` SET TAGS ('dbx_business_glossary_term' = 'K-Factor (Viral Coefficient) Contribution');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Referral Notes');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Platform');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `referral_channel` SET TAGS ('dbx_business_glossary_term' = 'Referral Channel');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `referral_channel` SET TAGS ('dbx_value_regex' = 'invite_link|social_share|friend_code|in_game_invite|email_invite|push_notification');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `referral_code` SET TAGS ('dbx_business_glossary_term' = 'Referral Code');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `referral_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `referral_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Expiry Date');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `referral_source_url` SET TAGS ('dbx_business_glossary_term' = 'Referral Source URL');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `referral_status` SET TAGS ('dbx_business_glossary_term' = 'Referral Status Funnel Stage');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `referral_status` SET TAGS ('dbx_value_regex' = 'sent|clicked|installed|registered|converted');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `referred_player_d30_retained` SET TAGS ('dbx_business_glossary_term' = 'Referred Player Day 30 (D30) Retention Flag');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `referred_player_d7_retained` SET TAGS ('dbx_business_glossary_term' = 'Referred Player Day 7 (D7) Retention Flag');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `referred_player_is_new` SET TAGS ('dbx_business_glossary_term' = 'Referred Player Is New Account Flag');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `registered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Player Registration Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `reward_claimed_flag` SET TAGS ('dbx_business_glossary_term' = 'Reward Claimed Flag');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `reward_claimed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reward Claimed Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `reward_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reward Currency Code');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `reward_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `reward_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Reward Eligibility Flag');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `reward_type` SET TAGS ('dbx_business_glossary_term' = 'Referral Reward Type');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `reward_type` SET TAGS ('dbx_value_regex' = 'virtual_currency|premium_item|dlc_unlock|subscription_days|real_money');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `reward_value` SET TAGS ('dbx_business_glossary_term' = 'Referral Reward Value');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Referral Sent Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `utm_campaign` SET TAGS ('dbx_business_glossary_term' = 'UTM Campaign');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `utm_medium` SET TAGS ('dbx_business_glossary_term' = 'UTM Medium');
ALTER TABLE `gaming_ecm`.`community`.`viral_referral` ALTER COLUMN `utm_source` SET TAGS ('dbx_business_glossary_term' = 'UTM Source');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` SET TAGS ('dbx_subdomain' = 'player_support');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `chat_session_id` SET TAGS ('dbx_business_glossary_term' = 'Chat Session ID');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `age_verification_event_id` SET TAGS ('dbx_business_glossary_term' = 'Age Verification Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Support Agent ID');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `iap_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Iap Transaction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `player_subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Player Subscription Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `support_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Zendesk Ticket ID');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `agent_team` SET TAGS ('dbx_business_glossary_term' = 'Support Agent Team');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Chat Channel');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'web_widget|in_game|mobile_app|sdk_embedded');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `coppa_minor_flag` SET TAGS ('dbx_business_glossary_term' = 'COPPA Minor Flag');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `csat_comment` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Comment');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `csat_comment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `csat_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Score');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `csat_survey_sent` SET TAGS ('dbx_business_glossary_term' = 'CSAT Survey Sent Flag');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_value_regex' = 'player_request|bot_failure|complexity|policy_exception|vip_player|unresolved_loop');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `first_response_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'First Response Time (Seconds)');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `gdpr_data_subject_request` SET TAGS ('dbx_business_glossary_term' = 'GDPR Data Subject Request Flag');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `handle_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Chat Handle Time (Seconds)');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `is_bot_handled` SET TAGS ('dbx_business_glossary_term' = 'Bot Handled Flag');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `is_escalated_to_human` SET TAGS ('dbx_business_glossary_term' = 'Escalated to Human Agent Flag');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `is_first_contact` SET TAGS ('dbx_business_glossary_term' = 'First Contact Flag');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `is_repeat_contact` SET TAGS ('dbx_business_glossary_term' = 'Repeat Contact Flag');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `issue_category` SET TAGS ('dbx_business_glossary_term' = 'Support Issue Category');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `issue_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Support Issue Subcategory');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `message_count` SET TAGS ('dbx_business_glossary_term' = 'Chat Message Count');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `pci_sensitive_data_shared` SET TAGS ('dbx_business_glossary_term' = 'PCI Sensitive Data Shared Flag');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Gaming Platform');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `player_account_age_days` SET TAGS ('dbx_business_glossary_term' = 'Player Account Age (Days)');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `player_locale` SET TAGS ('dbx_business_glossary_term' = 'Player Locale');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `player_locale` SET TAGS ('dbx_value_regex' = '^[a-z]{2}_[A-Z]{2}$');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `player_segment` SET TAGS ('dbx_business_glossary_term' = 'Player Monetization Segment');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `player_segment` SET TAGS ('dbx_value_regex' = 'whale|dolphin|minnow|f2p_non_payer|lapsed|new');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `queue_name` SET TAGS ('dbx_business_glossary_term' = 'Support Queue Name');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Session Resolution Status');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'resolved|unresolved|follow_up_required|transferred');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Zendesk Satisfaction Rating');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `satisfaction_rating` SET TAGS ('dbx_value_regex' = 'good|bad|unoffered');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `session_date` SET TAGS ('dbx_business_glossary_term' = 'Chat Session Date');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `session_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Chat Session End Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `session_key` SET TAGS ('dbx_business_glossary_term' = 'Chat Session Key');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `session_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Chat Session Start Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `session_status` SET TAGS ('dbx_business_glossary_term' = 'Chat Session Status');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `session_status` SET TAGS ('dbx_value_regex' = 'open|active|waiting|resolved|abandoned|missed');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'zendesk_chat|in_game_sdk|mobile_sdk');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Chat Session Tags');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `transcript_reference` SET TAGS ('dbx_business_glossary_term' = 'Chat Transcript Reference');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `transcript_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`chat_session` ALTER COLUMN `wait_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Chat Wait Time (Seconds)');
ALTER TABLE `gaming_ecm`.`community`.`community_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`community`.`community_event` SET TAGS ('dbx_subdomain' = 'social_groups');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `community_event_id` SET TAGS ('dbx_business_glossary_term' = 'Community Event ID');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `battle_pass_id` SET TAGS ('dbx_business_glossary_term' = 'Battle Pass Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `promo_code_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Promo Code Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `brand_partnership_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Partnership Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Organizer ID');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `game_mode_id` SET TAGS ('dbx_business_glossary_term' = 'Game Mode Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `influencer_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `parent_event_community_event_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Community Event ID');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `seasonal_event_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Seasonal Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `release_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Release Schedule Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `storefront_order_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Order Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `title_season_id` SET TAGS ('dbx_business_glossary_term' = 'Title Season Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Event Cancellation Reason');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `csat_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Score (CSAT)');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Participation Eligibility Criteria');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event End Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `event_code` SET TAGS ('dbx_business_glossary_term' = 'Community Event Code');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `event_code` SET TAGS ('dbx_value_regex' = '^CE-[A-Z0-9]{6,12}$');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Community Event Description');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `event_name` SET TAGS ('dbx_business_glossary_term' = 'Community Event Name');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Community Event Status');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'upcoming|active|completed|cancelled|postponed|draft');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Community Event Type');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'in_game_challenge|fan_tournament|developer_ama|community_contest|seasonal_campaign|community_challenge');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `external_url` SET TAGS ('dbx_business_glossary_term' = 'External Event URL');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `external_url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `geographic_restriction` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `is_age_restricted` SET TAGS ('dbx_business_glossary_term' = 'Age Restriction Flag');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `is_featured` SET TAGS ('dbx_business_glossary_term' = 'Featured Event Flag');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Recurring Event Flag');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `k_factor_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'K-Factor (Viral Coefficient) Tracking Enabled Flag');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `max_registrations` SET TAGS ('dbx_business_glossary_term' = 'Maximum Registration Cap');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `min_player_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Player Level Requirement');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `moderation_required` SET TAGS ('dbx_business_glossary_term' = 'Moderation Required Flag');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `organizer_type` SET TAGS ('dbx_business_glossary_term' = 'Organizer Type');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `organizer_type` SET TAGS ('dbx_value_regex' = 'developer|community_manager|player|esports_team|third_party');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `participant_count` SET TAGS ('dbx_business_glossary_term' = 'Participant Count');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `prize_description` SET TAGS ('dbx_business_glossary_term' = 'Prize and Reward Description');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `prize_type` SET TAGS ('dbx_business_glossary_term' = 'Prize Type');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `prize_type` SET TAGS ('dbx_value_regex' = 'virtual_currency|cosmetic_item|physical_prize|cash|title_recognition|no_prize');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `prize_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Prize Total Value (USD)');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `prize_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `referral_count` SET TAGS ('dbx_business_glossary_term' = 'Referral Count');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `registration_close_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Registration Close Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `registration_count` SET TAGS ('dbx_business_glossary_term' = 'Registration Count');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `registration_open_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Registration Open Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Community Event Short Description');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Start Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `survey_response_count` SET TAGS ('dbx_business_glossary_term' = 'Survey Response Count');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`community_event` ALTER COLUMN `voting_enabled` SET TAGS ('dbx_business_glossary_term' = 'Community Voting Enabled Flag');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` SET TAGS ('dbx_subdomain' = 'social_groups');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `social_connection_id` SET TAGS ('dbx_business_glossary_term' = 'Social Connection ID');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `guild_id` SET TAGS ('dbx_business_glossary_term' = 'Guild ID');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Campaign ID');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Initiating Player ID');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `target_player_player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Target Player ID');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `block_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Block Reason Code');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `block_reason_code` SET TAGS ('dbx_value_regex' = 'harassment|spam|inappropriate_content|cheating|other');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `co_play_session_count` SET TAGS ('dbx_business_glossary_term' = 'Co-Play Session Count');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `connection_direction` SET TAGS ('dbx_business_glossary_term' = 'Social Connection Direction');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `connection_direction` SET TAGS ('dbx_value_regex' = 'unidirectional|bidirectional');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `connection_label` SET TAGS ('dbx_business_glossary_term' = 'Social Connection Label');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `connection_number` SET TAGS ('dbx_business_glossary_term' = 'Social Connection Number');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `connection_number` SET TAGS ('dbx_value_regex' = '^SC-[0-9]{10}$');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `connection_source` SET TAGS ('dbx_business_glossary_term' = 'Social Connection Source Channel');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `connection_source` SET TAGS ('dbx_value_regex' = 'in_game|forum|guild|external|platform');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `connection_status` SET TAGS ('dbx_business_glossary_term' = 'Social Connection Status');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `connection_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|declined|removed');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `connection_strength_score` SET TAGS ('dbx_business_glossary_term' = 'Social Connection Strength Score');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `connection_tier` SET TAGS ('dbx_business_glossary_term' = 'Social Connection Tier');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `connection_tier` SET TAGS ('dbx_value_regex' = 'close_friend|acquaintance|follower|contact');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `connection_type` SET TAGS ('dbx_business_glossary_term' = 'Social Connection Type');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `connection_type` SET TAGS ('dbx_value_regex' = 'friend|follower|blocked|muted');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `connection_version` SET TAGS ('dbx_business_glossary_term' = 'Social Connection Record Version');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `established_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Connection Established Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'GDPR Consent Flag');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `interaction_count` SET TAGS ('dbx_business_glossary_term' = 'Social Interaction Count');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `is_cross_game` SET TAGS ('dbx_business_glossary_term' = 'Is Cross-Game Connection Flag');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `is_favorite` SET TAGS ('dbx_business_glossary_term' = 'Is Favorite Connection Flag');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `is_minor_restricted` SET TAGS ('dbx_business_glossary_term' = 'Is Minor Restricted Flag');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `is_mutual` SET TAGS ('dbx_business_glossary_term' = 'Is Mutual Connection Flag');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `is_reported` SET TAGS ('dbx_business_glossary_term' = 'Is Reported Flag');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `k_factor_contribution` SET TAGS ('dbx_business_glossary_term' = 'K-Factor (Viral Coefficient) Contribution');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `last_interaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Social Interaction Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `moderation_flag` SET TAGS ('dbx_business_glossary_term' = 'Social Connection Moderation Flag');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `moderation_flag` SET TAGS ('dbx_value_regex' = 'clean|under_review|escalated|actioned');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `mute_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Mute Reason Code');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `mute_reason_code` SET TAGS ('dbx_value_regex' = 'spam|noise|personal|other');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `notification_enabled` SET TAGS ('dbx_business_glossary_term' = 'Connection Notification Enabled Flag');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `nps_influence_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Influence Flag');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Code');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `privacy_visibility` SET TAGS ('dbx_business_glossary_term' = 'Connection Privacy Visibility');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `privacy_visibility` SET TAGS ('dbx_value_regex' = 'public|friends_only|private');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `removed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Connection Removed Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `request_message` SET TAGS ('dbx_business_glossary_term' = 'Connection Request Message');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `request_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Connection Request Sent Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `responded_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Connection Response Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SALESFORCE_CRM|GAME_ANALYTICS|IN_GAME_API|FORUM_PLATFORM|GUILD_SERVICE|PLATFORM_SDK');
ALTER TABLE `gaming_ecm`.`community`.`social_connection` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`ban` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`community`.`ban` SET TAGS ('dbx_subdomain' = 'content_creation');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `ban_id` SET TAGS ('dbx_business_glossary_term' = 'Community Ban ID');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Reviewer ID');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `ban_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Moderator ID');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `ban_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `ban_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `moderation_action_id` SET TAGS ('dbx_business_glossary_term' = 'Moderation Action ID');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `player_report_id` SET TAGS ('dbx_business_glossary_term' = 'Player Report ID');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `refund_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `sanctions_screening_result_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Result Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `support_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Zendesk Ticket ID');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `appeal_notes` SET TAGS ('dbx_business_glossary_term' = 'Appeal Notes');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'upheld|overturned|modified|withdrawn');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `appeal_resolved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Appeal Resolved Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'not_appealed|pending|under_review|upheld|overturned|withdrawn');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `appeal_submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Appeal Submitted Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `auto_moderation_score` SET TAGS ('dbx_business_glossary_term' = 'Auto-Moderation Score');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `ban_number` SET TAGS ('dbx_business_glossary_term' = 'Ban Number');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `ban_number` SET TAGS ('dbx_value_regex' = '^BAN-[0-9]{8,12}$');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `ban_scope` SET TAGS ('dbx_business_glossary_term' = 'Ban Scope');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `ban_scope` SET TAGS ('dbx_value_regex' = 'forum|chat|ugc|all_community');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `ban_status` SET TAGS ('dbx_business_glossary_term' = 'Ban Status');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `ban_status` SET TAGS ('dbx_value_regex' = 'active|expired|lifted|appealed|pending_review');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `ban_type` SET TAGS ('dbx_business_glossary_term' = 'Ban Type');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `ban_type` SET TAGS ('dbx_value_regex' = 'temporary|permanent|shadow');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `content_rating_concern` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Concern Flag');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Ban Duration Hours');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ban End Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `evidence_attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Evidence Attachment Count');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'GDPR Consent Flag');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Moderation Notes');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Is Automated Ban Flag');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `is_minor_involved` SET TAGS ('dbx_business_glossary_term' = 'Is Minor Involved Flag');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `is_permanent` SET TAGS ('dbx_business_glossary_term' = 'Is Permanent Ban Flag');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `is_repeat_offender` SET TAGS ('dbx_business_glossary_term' = 'Is Repeat Offender Flag');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Code');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `prior_ban_count` SET TAGS ('dbx_business_glossary_term' = 'Prior Ban Count');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Ban Reason');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `reinstatement_reason` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Reason');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `reinstatement_reason` SET TAGS ('dbx_value_regex' = 'appeal_overturned|ban_expired|manual_lift|policy_change|error_correction');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `reinstatement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ban Start Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `violation_category` SET TAGS ('dbx_business_glossary_term' = 'Violation Category');
ALTER TABLE `gaming_ecm`.`community`.`ban` ALTER COLUMN `violation_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Violation Subcategory');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` SET TAGS ('dbx_subdomain' = 'content_creation');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `player_reputation_id` SET TAGS ('dbx_business_glossary_term' = 'Player Reputation ID');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `previous_player_reputation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `auto_moderation_score` SET TAGS ('dbx_business_glossary_term' = 'Automated Moderation Score');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `can_invite` SET TAGS ('dbx_business_glossary_term' = 'Can Invite Privilege');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `can_moderate` SET TAGS ('dbx_business_glossary_term' = 'Can Moderate Privilege');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `can_post` SET TAGS ('dbx_business_glossary_term' = 'Can Post Privilege');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `can_upload_ugc` SET TAGS ('dbx_business_glossary_term' = 'Can Upload User-Generated Content (UGC) Privilege');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `can_vote` SET TAGS ('dbx_business_glossary_term' = 'Can Vote Privilege');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `csat_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Score (CSAT)');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `endorsement_count` SET TAGS ('dbx_business_glossary_term' = 'Endorsement Count');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Flag');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `helpful_contribution_count` SET TAGS ('dbx_business_glossary_term' = 'Helpful Contribution Count');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `is_age_verified` SET TAGS ('dbx_business_glossary_term' = 'Is Age Verified Flag');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `is_verified_contributor` SET TAGS ('dbx_business_glossary_term' = 'Is Verified Contributor Flag');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `k_factor_contribution` SET TAGS ('dbx_business_glossary_term' = 'K-Factor Viral Coefficient Contribution');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `moderation_threshold_level` SET TAGS ('dbx_business_glossary_term' = 'Moderation Threshold Level');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `moderation_threshold_level` SET TAGS ('dbx_value_regex' = 'strict|standard|relaxed|exempt');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Code');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `previous_trust_tier` SET TAGS ('dbx_business_glossary_term' = 'Previous Trust Tier');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `previous_trust_tier` SET TAGS ('dbx_value_regex' = 'new|basic|member|regular|leader|moderator');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `referral_count` SET TAGS ('dbx_business_glossary_term' = 'Referral Count');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Code');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `reputation_decay_rate` SET TAGS ('dbx_business_glossary_term' = 'Reputation Decay Rate Percentage');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `reputation_number` SET TAGS ('dbx_business_glossary_term' = 'Reputation Record Number');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `reputation_number` SET TAGS ('dbx_value_regex' = '^REP-[0-9]{10}$');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `reputation_points` SET TAGS ('dbx_business_glossary_term' = 'Reputation Points');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `reputation_status` SET TAGS ('dbx_business_glossary_term' = 'Reputation Status');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `reputation_status` SET TAGS ('dbx_value_regex' = 'active|suspended|frozen|under_review|banned');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension End Date');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `tier_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Trust Tier Change Reason');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `tier_change_reason` SET TAGS ('dbx_value_regex' = 'promotion_earned|demotion_violation|demotion_inactivity|manual_adjustment|appeal_granted|system_reset');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `tier_demotion_date` SET TAGS ('dbx_business_glossary_term' = 'Trust Tier Demotion Date');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `tier_promotion_date` SET TAGS ('dbx_business_glossary_term' = 'Trust Tier Promotion Date');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `trust_tier` SET TAGS ('dbx_business_glossary_term' = 'Trust Tier');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `trust_tier` SET TAGS ('dbx_value_regex' = 'new|basic|member|regular|leader|moderator');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `violation_count` SET TAGS ('dbx_business_glossary_term' = 'Violation Count');
ALTER TABLE `gaming_ecm`.`community`.`player_reputation` ALTER COLUMN `warning_count` SET TAGS ('dbx_business_glossary_term' = 'Warning Count');
ALTER TABLE `gaming_ecm`.`community`.`forum_category` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`community`.`forum_category` SET TAGS ('dbx_subdomain' = 'discussion_forums');
ALTER TABLE `gaming_ecm`.`community`.`forum_category` ALTER COLUMN `forum_category_id` SET TAGS ('dbx_business_glossary_term' = 'Forum Category Identifier');
ALTER TABLE `gaming_ecm`.`community`.`forum_category` ALTER COLUMN `parent_forum_category_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`kb_category` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`community`.`kb_category` SET TAGS ('dbx_subdomain' = 'player_support');
ALTER TABLE `gaming_ecm`.`community`.`kb_category` ALTER COLUMN `kb_category_id` SET TAGS ('dbx_business_glossary_term' = 'Kb Category Identifier');
ALTER TABLE `gaming_ecm`.`community`.`kb_category` ALTER COLUMN `parent_kb_category_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`kb_section` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`community`.`kb_section` SET TAGS ('dbx_subdomain' = 'player_support');
ALTER TABLE `gaming_ecm`.`community`.`kb_section` ALTER COLUMN `kb_section_id` SET TAGS ('dbx_business_glossary_term' = 'Kb Section Identifier');
ALTER TABLE `gaming_ecm`.`community`.`kb_section` ALTER COLUMN `parent_kb_section_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`community`.`survey` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`community`.`survey` SET TAGS ('dbx_subdomain' = 'player_support');
ALTER TABLE `gaming_ecm`.`community`.`survey` ALTER COLUMN `survey_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Identifier');
ALTER TABLE `gaming_ecm`.`community`.`survey` ALTER COLUMN `follow_up_survey_id` SET TAGS ('dbx_self_ref_fk' = 'true');
