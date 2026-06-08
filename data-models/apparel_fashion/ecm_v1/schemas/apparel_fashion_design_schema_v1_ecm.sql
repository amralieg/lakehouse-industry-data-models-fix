-- Schema for Domain: design | Business: Apparel Fashion | Version: v1_ecm
-- Generated on: 2026-05-05 15:54:34

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `apparel_fashion_ecm`.`design` COMMENT 'Manages the creative design process including concept development, mood boards, trend research, CAD/3D design, colorway development, print and pattern libraries, and design collaboration workflows';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`design`.`concept` (
    `concept_id` BIGINT COMMENT 'Unique identifier for the design concept. Primary key for the concept entity.',
    `designer_id` BIGINT COMMENT 'Reference to the lead designer or design team member responsible for developing this concept. Links to the workforce or employee master data.',
    `circular_program_id` BIGINT COMMENT 'Foreign key linking to sustainability.circular_program. Business justification: Design-for-circularity concepts are created specifically for take-back, resale, or rental programs. Real process: circular design briefs specify disassembly, mono-material, or durability requirements ',
    `collection_id` BIGINT COMMENT 'Reference to the collection or line that this concept belongs to. Links the concept to its parent collection for merchandising and planning purposes.',
    `employee_id` BIGINT COMMENT 'Reference to the user or designer who originally created this concept record. Links to workforce master data for accountability and collaboration tracking.',
    `concept_employee_id` BIGINT COMMENT 'Reference to the individual (e.g., Creative Director, Design Manager) who approved this concept for progression to the next stage. Links to workforce master data.',
    `concept_modified_by_employee_id` BIGINT COMMENT 'Reference to the user who last modified this concept record. Supports audit trail and collaboration workflow visibility.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Design concepts are budgeted and expense-tracked against design department cost centers for budget variance reporting and design labor allocation in apparel operations.',
    `ecolabel_id` BIGINT COMMENT 'Foreign key linking to sustainability.ecolabel. Business justification: Concepts target specific ecolabel certifications (GOTS, Oeko-Tex, Bluesign) as design requirements. Real process: concept briefs specify certification targets to guide material and construction choice',
    `packaging_sustainability_id` BIGINT COMMENT 'Foreign key linking to sustainability.packaging_sustainability. Business justification: Concept briefs define packaging sustainability requirements for holistic product sustainability. Real process: designers specify FSC-certified, recycled, or plastic-free packaging at concept stage to ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Collections are planned by brand/channel profit centers for P&L accountability and margin planning. Real process: collection-level profitability forecasting and actual performance tracking.',
    `sustainable_material_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainable_material. Business justification: Concept briefs specify sustainable material requirements for sustainability-focused collections. Designers select certified materials during concept development to meet ESG targets. Real process: conc',
    `target_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_target. Business justification: Concepts are designed to meet specific sustainability targets (50% recycled content, carbon reduction). Real process: concept KPIs are aligned to corporate sustainability targets; PLM tracks concept-t',
    `trend_report_id` BIGINT COMMENT 'Reference to the trend research or trend forecast that inspired or informed this concept. Links to trend analysis and market intelligence data.',
    `evolved_from_concept_id` BIGINT COMMENT 'Self-referencing FK on concept (evolved_from_concept_id)',
    `approval_date` DATE COMMENT 'The date on which this concept was formally approved to move forward in the design and development process. Key milestone for TNA (Time and Action) tracking.',
    `collaboration_notes` STRING COMMENT 'Free-text field for capturing collaboration notes, feedback from design reviews, and cross-functional input from merchandising, product development, and marketing teams.',
    `color_palette_description` STRING COMMENT 'Narrative description of the intended color palette for this concept (e.g., earthy neutrals with pops of terracotta, monochromatic blues, vibrant neons). Guides colorway development.',
    `concept_code` STRING COMMENT 'Unique alphanumeric code assigned to the concept for tracking and reference across systems. Used as the business identifier in design documentation and collaboration tools.. Valid values are `^[A-Z0-9]{6,12}$`',
    `concept_name` STRING COMMENT 'The creative name or title assigned to this design concept. Serves as the primary human-readable identifier for the concept throughout the design workflow.',
    `concept_status` STRING COMMENT 'Current lifecycle status of the design concept. Tracks progression from initial ideation through approval or rejection. Critical for workflow management and design pipeline visibility.. Valid values are `ideation|review|approved|rejected|on_hold|archived`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this concept record was first created in the system. Audit trail for concept inception and design pipeline tracking.',
    `design_direction` STRING COMMENT 'Detailed description of the design direction, including silhouette, fabrication approach, color philosophy, and intended aesthetic outcome. Serves as the creative brief for downstream design work.',
    `estimated_unit_count` STRING COMMENT 'Estimated number of individual product units (SKUs) expected to be developed from this concept. Used for capacity planning and resource allocation in the design pipeline.',
    `fabric_direction` STRING COMMENT 'High-level guidance on fabric types, textures, and material characteristics desired for this concept (e.g., sustainable cottons, technical performance fabrics, luxe knits). Guides material sourcing.',
    `gender_target` STRING COMMENT 'The target gender segment for this concept. Used for collection planning and merchandising assortment decisions.. Valid values are `mens|womens|unisex|kids|youth`',
    `inspiration_sources` STRING COMMENT 'Comma-separated list or narrative description of the inspiration sources for this concept (e.g., art movements, cultural references, nature, architecture, historical periods). Documents the creative genesis.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this concept record was last modified. Tracks iterative refinement and collaboration activity on the concept.',
    `mood_board_url` STRING COMMENT 'URL or file path to the digital mood board or visual inspiration board associated with this concept. Provides visual reference for the design team.. Valid values are `^https?://.*`',
    `mood_keywords` STRING COMMENT 'Comma-separated list of aesthetic and emotional keywords that capture the mood and feeling of the concept (e.g., bold, minimalist, playful, sophisticated, edgy). Used for mood board creation and design alignment.',
    `price_tier` STRING COMMENT 'The intended price tier or market positioning for products developed from this concept. Guides material selection, construction methods, and target MSRP (Manufacturers Suggested Retail Price) range.. Valid values are `entry|mid|premium|luxury`',
    `priority` STRING COMMENT 'Business priority level assigned to this concept. Determines resource allocation, design team focus, and sequencing in the development pipeline.. Valid values are `critical|high|medium|low`',
    `product_category` STRING COMMENT 'High-level product category this concept is intended for. Aligns the concept with merchandising hierarchy and product taxonomy.. Valid values are `apparel|footwear|accessories|activewear|outerwear|swimwear`',
    `rejection_reason` STRING COMMENT 'Explanation or rationale for why this concept was rejected or put on hold. Captures learnings for future design cycles and portfolio optimization.',
    `season` STRING COMMENT 'The fashion season this concept is designed for (e.g., SS24 for Spring/Summer 2024, FW24 for Fall/Winter 2024). Critical for collection planning and merchandising timelines.. Valid values are `^(SS|FW|AW|SP)[0-9]{2}$`',
    `silhouette_direction` STRING COMMENT 'Description of the intended silhouette and fit direction for this concept (e.g., oversized and relaxed, tailored and structured, body-conscious). Informs pattern development and fit strategy.',
    `sustainability_focus` BOOLEAN COMMENT 'Indicates whether this concept has a specific sustainability or eco-conscious design focus. Aligns with corporate sustainability goals and certifications (GOTS, BCI, OEKO-TEX).',
    `target_customer_archetype` STRING COMMENT 'Description of the target customer persona or archetype this concept is designed for (e.g., Active Millennial, Luxury Minimalist, Gen-Z Streetwear Enthusiast). Aligns design with customer segmentation strategy.',
    `target_launch_date` DATE COMMENT 'The planned market launch date for products developed from this concept. Drives the TNA (Time and Action) calendar and critical path milestones.',
    `theme` STRING COMMENT 'The overarching creative theme or narrative that defines this concept (e.g., Urban Explorer, Coastal Minimalism, Heritage Revival). Guides the aesthetic direction and storytelling.',
    CONSTRAINT pk_concept PRIMARY KEY(`concept_id`)
) COMMENT 'Master record for a creative design concept — the earliest ideation artifact in the apparel design process. Captures concept name, season, theme, design direction, inspiration sources, target customer archetype, mood/aesthetic keywords, assigned designer, concept status (ideation, review, approved, rejected), and links to the collection or trend research that inspired it. Serves as the creative brief anchor for all downstream design work.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`design`.`mood_board` (
    `mood_board_id` BIGINT COMMENT 'Unique identifier for the mood board. Primary key for the mood board entity.',
    `collection_id` BIGINT COMMENT 'Reference to the specific product collection that this mood board is associated with.',
    `concept_id` BIGINT COMMENT 'Reference to the design concept that this mood board supports. Links the mood board to the broader creative concept development phase.',
    `designer_id` BIGINT COMMENT 'Reference to the lead designer or creative owner responsible for creating and maintaining this mood board.',
    `employee_id` BIGINT COMMENT 'Reference to the user or stakeholder who approved the mood board.',
    `season_id` BIGINT COMMENT 'Reference to the fashion season or collection period for which this mood board was created (e.g., Spring/Summer 2024, Fall/Winter 2024).',
    `evolved_from_mood_board_id` BIGINT COMMENT 'Self-referencing FK on mood_board (evolved_from_mood_board_id)',
    `approval_status` STRING COMMENT 'Specific approval status indicating whether the mood board has been formally approved by design leadership or merchandising stakeholders.. Valid values are `pending|approved|rejected|conditional`',
    `approved_date` DATE COMMENT 'Date when the mood board was formally approved by design leadership or merchandising.',
    `board_code` STRING COMMENT 'Unique business identifier or code assigned to the mood board for tracking and reference purposes across design and merchandising teams.. Valid values are `^MB-[A-Z0-9]{6,12}$`',
    `brand_alignment` STRING COMMENT 'Assessment of how well the mood board aligns with the brands established aesthetic, values, and positioning.. Valid values are `on_brand|exploratory|off_brand`',
    `collaboration_notes` STRING COMMENT 'Free-text notes capturing feedback, comments, or collaboration discussions from design team members, merchandisers, or stakeholders.',
    `color_story` STRING COMMENT 'Narrative description of the color palette and color relationships featured in the mood board, including primary, secondary, and accent colors.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the mood board record was first created in the system.',
    `creative_theme` STRING COMMENT 'The overarching creative theme or narrative that the mood board communicates (e.g., Sustainable Luxury, Street Culture Fusion, Heritage Revival).',
    `cultural_references` STRING COMMENT 'Description of cultural, historical, or lifestyle references that inform the mood boards aesthetic and narrative.',
    `digital_file_path` STRING COMMENT 'File system path or cloud storage location where the digital mood board assets are stored.',
    `format_type` STRING COMMENT 'Indicates whether the mood board is digital, physical (printed/mounted), or a hybrid of both formats.. Valid values are `digital|physical|hybrid`',
    `gender_category` STRING COMMENT 'Target gender category or market segment for the design direction represented in the mood board.. Valid values are `mens|womens|unisex|kids|all`',
    `geographic_market_focus` STRING COMMENT 'Target geographic markets or regions that the mood boards aesthetic is designed to appeal to (e.g., North America, Europe, Asia Pacific, Global).',
    `inspiration_source` STRING COMMENT 'Description of the primary sources of inspiration for the mood board, such as art movements, cultural references, nature, architecture, or lifestyle trends.',
    `is_active` BOOLEAN COMMENT 'Flag indicating whether the mood board is currently active and in use for design development, or has been archived.',
    `is_confidential` BOOLEAN COMMENT 'Flag indicating whether the mood board contains confidential or proprietary design information that should have restricted access.',
    `last_modified_date` DATE COMMENT 'Date when the mood board was last updated or modified.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the mood board record was last updated in the system.',
    `merchandising_feedback` STRING COMMENT 'Specific feedback provided by merchandising teams regarding commercial viability, market alignment, or assortment planning considerations.',
    `mood_board_status` STRING COMMENT 'Current lifecycle status of the mood board in the design approval workflow.. Valid values are `draft|in_review|approved|rejected|archived`',
    `mood_board_type` STRING COMMENT 'Classification of the mood board by its purpose or scope within the design process.. Valid values are `concept|seasonal|collection|product_line|trend_research|presentation`',
    `platform_tool` STRING COMMENT 'The software platform or tool used to create and manage the mood board (e.g., Milanote, InVision, Miro, Adobe Creative Cloud, Centric PLM, Physical Board).',
    `presentation_date` DATE COMMENT 'Date when the mood board was presented to stakeholders, merchandising teams, or executive leadership.',
    `primary_color_palette` STRING COMMENT 'Comma-separated list or description of the primary colors featured in the mood board (e.g., Sage Green, Terracotta, Cream, Charcoal).',
    `product_category_focus` STRING COMMENT 'Primary product categories that the mood board is intended to inspire (e.g., Outerwear, Footwear, Accessories, Activewear).',
    `silhouette_direction` STRING COMMENT 'Description of the intended silhouette and fit direction communicated by the mood board (e.g., Oversized and Relaxed, Tailored and Structured, Fluid and Draped).',
    `sustainability_focus` STRING COMMENT 'Indicates the level of sustainability emphasis in the mood boards material, color, and design direction.. Valid values are `none|low|medium|high`',
    `target_customer_persona` STRING COMMENT 'Description of the target customer or consumer persona that the mood board is designed to appeal to, including lifestyle, values, and aesthetic preferences.',
    `target_price_point` STRING COMMENT 'Intended price tier or market segment that the mood boards aesthetic and material direction is targeting.. Valid values are `entry|mid|premium|luxury`',
    `texture_references` STRING COMMENT 'Description of key textures, materials, and surface treatments referenced in the mood board (e.g., Raw Linen, Brushed Metal, Distressed Leather, Organic Cotton).',
    `thumbnail_url` STRING COMMENT 'URL or file path to a thumbnail image representing the mood board for quick visual reference in design management systems.',
    `title` STRING COMMENT 'The descriptive title or name given to the mood board, capturing the creative theme or inspiration (e.g., Urban Nomad, Coastal Minimalism, Neo-Futurism).',
    `trend_alignment_score` DECIMAL(18,2) COMMENT 'Quantitative score (0.00 to 5.00) indicating how well the mood board aligns with current market trends and consumer preferences, as assessed by trend research teams.',
    `version_number` STRING COMMENT 'Version identifier for the mood board, tracking iterations and revisions (e.g., v1.0, v2.1).. Valid values are `^v?[0-9]+.[0-9]+(.[0-9]+)?$`',
    `creation_date` DATE COMMENT 'Date when the mood board was initially created or started by the designer.',
    CONSTRAINT pk_mood_board PRIMARY KEY(`mood_board_id`)
) COMMENT 'Master record for a digital or physical mood board created during the concept development phase. Captures mood board title, associated concept and season, creative theme, color story, texture references, silhouette direction, cultural or lifestyle references, creation date, designer owner, approval status, and the platform or tool used (e.g., Milanote, InVision, physical board). Mood boards are the primary visual communication artifact between design and merchandising.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` (
    `mood_board_asset_id` BIGINT COMMENT 'Unique identifier for the mood board asset record. Primary key for the mood board asset entity.',
    `collection_id` BIGINT COMMENT 'FK to product.collection',
    `employee_id` BIGINT COMMENT 'Reference to the user or design lead who approved the asset for inclusion in the mood board or collection. Supports governance and accountability in the creative process.',
    `mood_board_id` BIGINT COMMENT 'Reference to the parent mood board to which this asset belongs. Links the asset to its containing mood board for collection management.',
    `designer_id` BIGINT COMMENT 'Reference to the designer or user who added the asset to the mood board. Supports collaboration tracking and attribution of creative contributions.',
    `grouped_with_mood_board_asset_id` BIGINT COMMENT 'Self-referencing FK on mood_board_asset (grouped_with_mood_board_asset_id)',
    `approval_status` STRING COMMENT 'Approval state of the asset within the design review workflow. Indicates whether the asset has been approved for use, rejected, is pending review, or has not yet been submitted for approval.. Valid values are `approved|rejected|pending|not_submitted`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the asset was approved. Captures the moment of formal acceptance for audit trail and workflow tracking.',
    `asset_caption` STRING COMMENT 'Descriptive text or annotation provided by the designer to explain the inspiration, context, or relevance of the asset to the design concept. Supports creative storytelling and team collaboration.',
    `asset_file_format` STRING COMMENT 'File extension or media format of the asset. Indicates the technical format for rendering and compatibility purposes. [ENUM-REF-CANDIDATE: jpg|jpeg|png|gif|bmp|tiff|svg|mp4|mov|avi|pdf|psd|ai — 13 candidates stripped; promote to reference product]',
    `asset_file_name` STRING COMMENT 'Original file name of the uploaded or linked asset. Preserves the source file identifier for traceability and reference.',
    `asset_file_path` STRING COMMENT 'Internal storage location or file system path where the asset is stored within the Product Lifecycle Management (PLM) or Digital Asset Management (DAM) system. Enables retrieval and version control.',
    `asset_file_size_bytes` BIGINT COMMENT 'Size of the asset file measured in bytes. Used for storage management and performance optimization.',
    `asset_height` DECIMAL(18,2) COMMENT 'Height of the asset as displayed on the mood board, measured in pixels or percentage. Controls the visual scale and prominence of the asset within the composition.',
    `asset_sequence_number` STRING COMMENT 'Ordinal position of the asset within the mood board layout. Determines the display order and visual arrangement of assets on the board.',
    `asset_source_url` STRING COMMENT 'Web address or external link from which the asset was sourced. Captures the original location for reference and attribution purposes.',
    `asset_status` STRING COMMENT 'Current lifecycle state of the mood board asset. Indicates whether the asset is actively displayed, archived for reference, removed from the board, or awaiting design review.. Valid values are `active|archived|removed|pending_review`',
    `asset_tags` STRING COMMENT 'Comma-separated or pipe-separated list of keywords or labels applied to the asset for search, filtering, and categorization. Examples include trend names, color families, themes, or seasonal references.',
    `asset_type` STRING COMMENT 'Classification of the mood board asset by media type. Distinguishes between images, videos, physical material references, color samples, editorial content, design sketches, textures, and patterns. [ENUM-REF-CANDIDATE: image|video|fabric_swatch|color_chip|editorial|sketch|texture|pattern — 8 candidates stripped; promote to reference product]',
    `asset_width` DECIMAL(18,2) COMMENT 'Width of the asset as displayed on the mood board, measured in pixels or percentage. Controls the visual scale and prominence of the asset within the composition.',
    `color_palette_hex_codes` STRING COMMENT 'Comma-separated list of hexadecimal color codes extracted or associated with the asset. Supports colorway development and trend analysis by capturing dominant or inspirational colors.',
    `copyright_attribution` STRING COMMENT 'Copyright holder or source attribution for the asset. Ensures compliance with intellectual property rights and provides proper credit for external content.',
    `fabric_reference_code` STRING COMMENT 'Internal or supplier fabric code if the asset represents a fabric swatch or material sample. Links the mood board asset to the material library for sourcing and Bill of Materials (BOM) integration.',
    `inspiration_source` STRING COMMENT 'Description of the original source or context from which the asset was drawn. Examples include runway shows, street style, art exhibitions, nature, architecture, or cultural references.',
    `is_featured` BOOLEAN COMMENT 'Boolean flag indicating whether the asset is marked as a featured or hero element on the mood board. Featured assets may receive prominence in presentations or design reviews.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the asset record was last updated. Tracks changes to position, caption, tags, or other metadata for version control and collaboration visibility.',
    `linked_product_sku` STRING COMMENT 'Stock Keeping Unit (SKU) of a product that was directly inspired by or developed from this mood board asset. Establishes traceability from creative concept to final product.',
    `notes` STRING COMMENT 'Free-text field for additional comments, design rationale, or collaborative feedback related to the asset. Supports team communication and documentation of creative decisions.',
    `position_x_coordinate` DECIMAL(18,2) COMMENT 'Horizontal position of the asset on the mood board canvas, measured in pixels or percentage from the left edge. Enables precise layout control and visual composition.',
    `position_y_coordinate` DECIMAL(18,2) COMMENT 'Vertical position of the asset on the mood board canvas, measured in pixels or percentage from the top edge. Enables precise layout control and visual composition.',
    `season_code` STRING COMMENT 'Seasonal identifier for which the mood board asset is relevant. Examples include Spring/Summer 2025 (SS25), Fall/Winter 2025 (FW25). Aligns the asset with collection planning cycles.',
    `trend_theme` STRING COMMENT 'Name or identifier of the fashion trend or design theme that the asset represents or supports. Examples include seasonal trends, cultural movements, or aesthetic directions.',
    `upload_timestamp` TIMESTAMP COMMENT 'Date and time when the asset was added to the mood board. Captures the moment of creation for audit trail and chronological tracking of design evolution.',
    `usage_rights` STRING COMMENT 'Licensing or usage rights associated with the asset. Defines whether the asset can be used internally only, is licensed for commercial use, is in the public domain, or has restricted usage terms.. Valid values are `internal_only|licensed|public_domain|restricted`',
    CONSTRAINT pk_mood_board_asset PRIMARY KEY(`mood_board_asset_id`)
) COMMENT 'Individual asset record within a mood board, representing a single image, swatch, fabric reference, editorial clip, or inspirational element pinned to the board. Captures asset type (image, video, fabric swatch, color chip, editorial), asset source URL or file path, caption, position on board, upload date, and the designer who added it. Enables granular tracking of creative references and supports digital asset management integration.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`design`.`trend_report` (
    `trend_report_id` BIGINT COMMENT 'Unique identifier for the trend research report. Primary key.',
    `prior_season_trend_report_id` BIGINT COMMENT 'Self-referencing FK on trend_report (prior_season_trend_report_id)',
    `adoption_recommendation` STRING COMMENT 'Strategic recommendation for how the brand should respond to the trend: lead (be first to market, drive the trend), follow (adopt after market validation), monitor (watch for further signals), or avoid (not aligned with brand positioning).. Valid values are `lead|follow|monitor|avoid`',
    `color_palette` STRING COMMENT 'Key colors or color families highlighted in the trend report, typically represented as color names, Pantone codes, or hex values. Used to inform colorway development.',
    `consumer_segment` STRING COMMENT 'The target consumer demographic or psychographic segment for which the trend is most relevant (e.g., Gen Z, Millennials, Luxury Consumers, Athleisure Enthusiasts).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the trend report record was first created in the system.',
    `cultural_influence` STRING COMMENT 'Cultural movements, subcultures, art movements, or societal shifts that are driving or influencing the trend (e.g., Y2K revival, streetwear, cottagecore, digital culture).',
    `expiration_date` DATE COMMENT 'The date after which the trend report is considered outdated or no longer relevant for active collection planning. Typically aligned with the end of the season or trend cycle.',
    `geographic_region` STRING COMMENT 'The primary geographic market or region for which the trend report is most relevant (e.g., North America, Europe, Asia-Pacific, Global). Trends may have regional variations.',
    `key_trend_themes` STRING COMMENT 'A summary of the primary trend themes, concepts, or narratives identified in the report. May include keywords, thematic descriptors, or trend names (e.g., Neo-Nostalgia, Sustainable Minimalism, Digital Craft).',
    `material_focus` STRING COMMENT 'Key materials, fabrics, or textile innovations featured in the trend report (e.g., recycled polyester, organic cotton, technical knits, vegan leather).',
    `print_pattern_theme` STRING COMMENT 'Key print, pattern, or graphic themes featured in the trend report (e.g., florals, geometric, abstract, animal print, stripes).',
    `publication_date` DATE COMMENT 'The date on which the trend report was officially published or released by the source agency or design team.',
    `relevance_score` DECIMAL(18,2) COMMENT 'A quantitative score (0.00 to 100.00) assigned by the design team or merchandising leadership indicating the relevance and applicability of this trend report to the brands target market, aesthetic positioning, and strategic direction. Higher scores indicate stronger alignment.',
    `report_author` STRING COMMENT 'Name of the individual or team within the design organization who compiled, authored, or is responsible for the trend report (if internally generated).',
    `report_code` STRING COMMENT 'Unique business identifier or reference code assigned to the trend report for cataloging and retrieval purposes.',
    `report_document_url` STRING COMMENT 'URL or file path to the full trend report document, presentation deck, or digital asset stored in the PLM system or document management system.',
    `report_status` STRING COMMENT 'Current lifecycle status of the trend report within the organizations design workflow: draft (initial compilation), under review (being evaluated by design leadership), approved (validated for use in collection planning), archived (historical reference), or obsolete (no longer relevant).. Valid values are `draft|under review|approved|archived|obsolete`',
    `report_title` STRING COMMENT 'The full title or name of the trend research report as published by the design team or trend forecasting agency.',
    `review_date` DATE COMMENT 'The date on which the trend report was reviewed and approved by design or merchandising leadership.',
    `reviewed_by` STRING COMMENT 'Name or role of the design leadership, creative director, or merchandising executive who reviewed and approved the trend report for use in collection planning.',
    `season` STRING COMMENT 'The fashion season or collection period to which this trend report applies (e.g., Spring/Summer 2025, Fall/Winter 2024).. Valid values are `spring|summer|fall|winter|pre-fall|resort`',
    `season_year` STRING COMMENT 'The calendar year associated with the trend report season.',
    `silhouette_direction` STRING COMMENT 'Dominant silhouette or fit trends identified in the report (e.g., oversized, tailored, fluid, structured, cropped, elongated).',
    `source_agency` STRING COMMENT 'The name of the trend forecasting agency or organization that published the report (e.g., WGSN, Trendalytics, Edited, Pantone, Fashion Snoops) or Internal if compiled by the in-house design team.',
    `sustainability_focus` BOOLEAN COMMENT 'Indicates whether the trend report has a specific focus on sustainability, circular fashion, or environmentally responsible design practices.',
    `tags` STRING COMMENT 'Comma-separated list of keywords, tags, or metadata labels applied to the trend report for search, filtering, and categorization within the PLM system (e.g., sustainable, bold color, minimalist, tech-inspired).',
    `target_product_category` STRING COMMENT 'The product category or categories (e.g., womenswear, menswear, footwear, accessories) for which this trend report is most applicable. May be a comma-separated list if the trend spans multiple categories.',
    `trend_category` STRING COMMENT 'The classification of the trend report by type: macro trend (broad cultural/lifestyle shifts), micro trend (specific design details), color trend (palette forecasts), silhouette trend (shape and fit directions), material trend (fabric and textile innovations), or print trend (pattern and graphic themes).. Valid values are `macro trend|micro trend|color trend|silhouette trend|material trend|print trend`',
    `trend_description` STRING COMMENT 'Detailed narrative description of the trend report content, including insights, consumer behavior drivers, aesthetic directions, and supporting rationale.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when the trend report record was last modified or updated in the system.',
    `usage_count` STRING COMMENT 'The number of times this trend report has been referenced or linked to design concepts, mood boards, or collection plans within the PLM system. Indicates report influence and adoption.',
    CONSTRAINT pk_trend_report PRIMARY KEY(`trend_report_id`)
) COMMENT 'Master record for a seasonal or thematic trend research report compiled by the design team or sourced from trend forecasting agencies (WGSN, Trendalytics, Edited). Captures report title, season, trend category (macro trend, micro trend, color trend, silhouette trend, material trend), source agency, publication date, key trend themes, relevance score, and adoption recommendation (lead, follow, avoid). Drives concept development and collection direction.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`design`.`trend_item` (
    `trend_item_id` BIGINT COMMENT 'Unique identifier for the trend item record. Primary key.',
    `trend_report_id` BIGINT COMMENT 'Reference to the parent trend report from which this trend item was extracted or observed.',
    `related_trend_item_id` BIGINT COMMENT 'Self-referencing FK on trend_item (related_trend_item_id)',
    `adoption_score` DECIMAL(18,2) COMMENT 'Numeric score (0.00 to 100.00) representing the estimated market adoption or prevalence of this trend item based on analyst assessment.',
    `collection_adoption_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this trend item has been adopted or incorporated into an internal collection or product line (True/False).',
    `color_palette` STRING COMMENT 'Comma-separated list of color names or hex codes associated with this trend item if it is color-related or has specific color attributes.',
    `competitive_brand_adoption` STRING COMMENT 'Comma-separated list of competitive brand names that have adopted or showcased this trend item in their collections.',
    `consumer_segment` STRING COMMENT 'The target consumer segment or demographic for which this trend item is most relevant (e.g., Gen Z, Millennials, Luxury, Athleisure, Streetwear).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this trend item record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `designer_brand` STRING COMMENT 'The name of the designer or brand associated with this trend item observation.',
    `forecast_longevity_months` STRING COMMENT 'Estimated number of months this trend item is expected to remain relevant in the market based on trend forecasting analysis.',
    `gender_relevance` STRING COMMENT 'The gender category for which this trend item is most relevant (mens, womens, unisex, kids, all).. Valid values are `mens|womens|unisex|kids|all`',
    `geographic_relevance` STRING COMMENT 'Comma-separated list of 3-letter ISO country codes or region identifiers indicating where this trend item is relevant or observed (e.g., USA, GBR, FRA, JPN).',
    `image_reference_url` STRING COMMENT 'URL or file path reference to visual imagery or mood board assets associated with this trend item.',
    `influence_level` STRING COMMENT 'Qualitative assessment of the influence or impact level of this trend item on the market or collection planning (low, medium, high, critical).. Valid values are `low|medium|high|critical`',
    `item_name` STRING COMMENT 'The name or label of the trend item as observed in the market or documented in the trend report (e.g., Oversized Blazers, Neon Green, Utility Pockets).',
    `logged_by_analyst` STRING COMMENT 'The name or identifier of the trend analyst, designer, or merchandiser who logged or documented this trend item.',
    `material_composition` STRING COMMENT 'Description of the material or fabric composition associated with this trend item if it is fabric or material-related (e.g., Organic Cotton, Recycled Polyester, Silk Blend).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this trend item record was last modified or updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, observations, or commentary about this trend item by the analyst or design team.',
    `observation_date` DATE COMMENT 'The date when this trend item was observed, logged, or extracted from the source. Format: yyyy-MM-dd.',
    `price_tier_relevance` STRING COMMENT 'The price tier or market segment where this trend item is most relevant (luxury, premium, mid-market, mass-market, value).. Valid values are `luxury|premium|mid_market|mass_market|value`',
    `product_category_relevance` STRING COMMENT 'Comma-separated list of product categories where this trend item is applicable (e.g., outerwear, dresses, footwear, accessories).',
    `related_trend_items` STRING COMMENT 'Comma-separated list of related trend item IDs or names that are complementary or frequently co-occur with this trend item.',
    `runway_citation` STRING COMMENT 'Reference to the runway show, fashion week, or designer presentation where this trend item was observed (e.g., Paris Fashion Week SS24 - Chanel, Milan FW24 - Prada).',
    `season_code` STRING COMMENT 'The fashion season code for which this trend item is relevant (e.g., SS24 for Spring/Summer 2024, FW24 for Fall/Winter 2024).. Valid values are `^(SS|FW|AW|SP)[0-9]{2}$`',
    `source_reference` STRING COMMENT 'Specific reference or citation to the source material (e.g., URL, publication name, social media handle, event name).',
    `source_type` STRING COMMENT 'The type of source from which this trend item was identified (runway, street style, social media, trade show, retail observation, trend report, editorial, influencer). [ENUM-REF-CANDIDATE: runway|street_style|social_media|trade_show|retail_observation|trend_report|editorial|influencer — 8 candidates stripped; promote to reference product]',
    `sustainability_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this trend item is associated with sustainable or eco-friendly design practices (True/False).',
    `trend_category` STRING COMMENT 'The category or classification of the trend item indicating what aspect of design it represents (color, silhouette, fabric, print, embellishment, styling, accessory, footwear, texture, finish). [ENUM-REF-CANDIDATE: color|silhouette|fabric|print|embellishment|styling|accessory|footwear|texture|finish — 10 candidates stripped; promote to reference product]',
    `trend_description` STRING COMMENT 'Detailed textual description of the trend item including design characteristics, styling notes, and contextual information.',
    `trend_item_status` STRING COMMENT 'Current status of the trend item record in the system (active, archived, under_review, rejected).. Valid values are `active|archived|under_review|rejected`',
    `trend_stage` STRING COMMENT 'The lifecycle stage of the trend item indicating its current adoption and market penetration (emerging, growth, peak, maturity, declining, obsolete).. Valid values are `emerging|growth|peak|maturity|declining|obsolete`',
    CONSTRAINT pk_trend_item PRIMARY KEY(`trend_item_id`)
) COMMENT 'Individual trend signal or data point extracted from a trend report or observed in the market. Captures trend item name, trend category (color, silhouette, fabric, print, embellishment, styling), trend stage (emerging, peak, declining), geographic relevance, consumer segment relevance, competitive brand adoption, runway citation, and the designer or analyst who logged it. Enables granular trend tracking and cross-season trend analysis.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`design`.`sketch` (
    `sketch_id` BIGINT COMMENT 'Unique identifier for the design sketch record. Primary key.',
    `concept_id` BIGINT COMMENT 'Identifier linking the design sketch to its originating design concept or mood board. Traces creative lineage and thematic alignment.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Design labor hours and sketch development costs are allocated to design cost centers for activity-based costing and design department budget management in apparel product development.',
    `designer_id` BIGINT COMMENT 'Identifier of the designer who created the sketch. Links to workforce/employee master data.',
    `ecolabel_id` BIGINT COMMENT 'Foreign key linking to sustainability.ecolabel. Business justification: Design sketches are annotated with target ecolabel certifications to guide material/construction choices. Real process: designers design-to-certification, ensuring sketches meet label criteria before ',
    `employee_id` BIGINT COMMENT 'Identifier of the design director responsible for approving the sketch. Links to workforce/employee master data.',
    `previous_version_sketch_id` BIGINT COMMENT 'Identifier of the previous version of this design sketch, if applicable. Enables lineage tracking and comparison of design iterations.',
    `style_id` BIGINT COMMENT 'Identifier of the style master record created from this design sketch, if applicable. Links the creative design to the production-ready style.',
    `sustainable_material_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainable_material. Business justification: Designers annotate sketches with material codes including sustainable options. Real process: sketch approval gates verify sustainable material availability and certification status before tech pack de',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor. Business justification: Designers reference specific vendors during sketch phase for technical feasibility assessment and preliminary costing - standard practice in apparel design workflow before tech pack handoff.',
    `revised_from_sketch_id` BIGINT COMMENT 'Self-referencing FK on sketch (revised_from_sketch_id)',
    `approval_date` DATE COMMENT 'Date when the design sketch received final approval from the design director. Marks transition to technical development phase.',
    `approval_status` STRING COMMENT 'Current approval status of the design sketch by the design director or review committee. Gates progression to tech pack development.. Valid values are `pending|approved|rejected|revision_requested|on_hold`',
    `collaboration_team` STRING COMMENT 'Names or identifiers of additional team members who collaborated on the design sketch (e.g., assistant designers, technical designers, merchandisers). Supports attribution and workflow tracking.',
    `collection_name` STRING COMMENT 'Name of the collection or line to which this design sketch belongs (e.g., Performance Running, Urban Lifestyle, Premium Athleisure).',
    `color_palette_reference` STRING COMMENT 'Reference code or name of the color palette associated with the design sketch. Links to seasonal color strategy and material libraries.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the design sketch record was first created in the system. Supports audit trail and design timeline analysis.',
    `design_notes` STRING COMMENT 'Free-text notes from the designer describing design intent, construction details, inspiration, or special considerations. Provides context for downstream technical development.',
    `design_phase` STRING COMMENT 'Current phase of the design sketch in the creative development lifecycle. Tracks progression from concept through final approval.. Valid values are `concept|initial_sketch|revised_sketch|final_sketch|approved`',
    `estimated_cogs` DECIMAL(18,2) COMMENT 'Preliminary estimate of the cost of goods sold for the design sketch. Used for margin analysis and go/no-go decisions. Currency is USD unless otherwise specified.',
    `fabric_suggestion` STRING COMMENT 'Suggested fabric type or material for the design sketch (e.g., cotton jersey, performance polyester, wool blend). Preliminary input for sourcing and costing.',
    `file_format` STRING COMMENT 'File format of the design sketch (e.g., PDF, JPG, AI for Adobe Illustrator, CLO3D for 3D garment files). Determines software compatibility and rendering requirements. [ENUM-REF-CANDIDATE: pdf|jpg|png|ai|psd|clo3d|browzwear — 7 candidates stripped; promote to reference product]',
    `file_path` STRING COMMENT 'File system path or cloud storage URI to the primary design sketch file. Used for retrieval and version control integration.',
    `gender_target` STRING COMMENT 'Target gender demographic for the design sketch. Influences fit, sizing, and merchandising strategy.. Valid values are `mens|womens|unisex|youth|kids`',
    `is_active` BOOLEAN COMMENT 'Indicates whether the design sketch is currently active in the design pipeline. Inactive sketches are archived or discontinued designs.',
    `medium` STRING COMMENT 'Medium or tool used to create the design sketch (e.g., hand-drawn, CAD 2D software, 3D rendering software). Indicates technical approach and file format expectations.. Valid values are `hand_drawn|cad_2d|cad_3d|digital_illustration|mixed_media`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the design sketch record was last modified. Tracks most recent update for change management and synchronization.',
    `primary_color_code` STRING COMMENT 'Code for the dominant color in the design sketch, typically from a standardized color library (e.g., Pantone, internal color system).. Valid values are `^[A-Z0-9]{4,8}$`',
    `print_pattern_reference` STRING COMMENT 'Reference code or name of any print or pattern applied to the design sketch. Links to print library and artwork assets.',
    `product_category` STRING COMMENT 'High-level product category classification for the design sketch. Determines downstream merchandising and production workflows. [ENUM-REF-CANDIDATE: tops|bottoms|outerwear|dresses|footwear|accessories|headwear|bags — 8 candidates stripped; promote to reference product]',
    `product_subcategory` STRING COMMENT 'Detailed subcategory within the product category (e.g., t-shirt, hoodie, joggers, sneakers, backpack). Provides granular classification for design intent.',
    `rejection_reason` STRING COMMENT 'Explanation provided when a design sketch is rejected or revision is requested. Captures feedback for design iteration.',
    `season_code` STRING COMMENT 'Season and year identifier for which this design sketch was created (e.g., SS24 for Spring/Summer 2024, FW24 for Fall/Winter 2024, HO24 for Holiday 2024).. Valid values are `^(SS|FW|HO|SP)[0-9]{2}$`',
    `silhouette_type` STRING COMMENT 'Overall silhouette or fit profile of the design (e.g., slim fit, relaxed fit, oversized, tailored, A-line). Key attribute for merchandising and customer communication.',
    `sketch_number` STRING COMMENT 'Business identifier for the design sketch, typically following a season-category-sequence pattern (e.g., SS24-001234). Used for cross-functional reference and tracking.. Valid values are `^[A-Z0-9]{2,4}-[0-9]{4,6}$`',
    `sustainability_certification_target` STRING COMMENT 'Target sustainability certification for the design sketch (e.g., GOTS, OEKO-TEX, BCI, Bluesign). Guides material sourcing and compliance requirements.',
    `sustainability_flag` BOOLEAN COMMENT 'Indicates whether the design sketch incorporates sustainable design principles or materials (e.g., organic cotton, recycled polyester, low-impact dyes). Supports ESG reporting and marketing claims.',
    `target_price_point` DECIMAL(18,2) COMMENT 'Intended retail price point for the design sketch. Used for early feasibility assessment and collection planning. Currency is USD unless otherwise specified.',
    `tech_pack_generated_flag` BOOLEAN COMMENT 'Indicates whether a technical specification package (tech pack) has been generated from this design sketch. Marks transition from creative to technical phase.',
    `thumbnail_image_path` STRING COMMENT 'File path or URI to a thumbnail preview image of the design sketch. Used for quick visual reference in PLM systems and design review dashboards.',
    `trend_theme` STRING COMMENT 'Primary trend theme or inspiration driving the design sketch (e.g., Sustainable Future, Retro Revival, Tech Performance). Aligns with seasonal trend research.',
    `version_number` STRING COMMENT 'Version number of the design sketch. Increments with each revision to track design evolution and change history.',
    CONSTRAINT pk_sketch PRIMARY KEY(`sketch_id`)
) COMMENT 'Master record for an individual garment or accessory design sketch — the primary creative output of the design team. Captures sketch number, style name, season, category (top, bottom, outerwear, footwear, accessory), design phase (initial sketch, revised sketch, final sketch), sketch medium (hand-drawn, CAD, 3D), file reference, assigned designer, design director approval status, and associated concept. The sketch is the precursor to the tech pack and style master record.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`design`.`cad_file` (
    `cad_file_id` BIGINT COMMENT 'Unique identifier for the CAD or 3D digital design file record. Primary key for the cad_file product.',
    `collection_id` BIGINT COMMENT 'FK to product.collection',
    `colorway_id` BIGINT COMMENT 'Reference to the specific colorway or color variation that this CAD file represents. Null if the file is colorway-agnostic or represents the base design.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: CAD development time and software costs are tracked to design cost centers for design department expense allocation and project costing in apparel technical design operations.',
    `employee_id` BIGINT COMMENT 'Reference to the user or approver who approved this CAD file for production or next phase. Null if not yet approved. Supports approval workflow tracking.',
    `designer_id` BIGINT COMMENT 'Reference to the designer or user who originally created this CAD file. Supports accountability and design attribution.',
    `print_design_id` BIGINT COMMENT 'Reference to the print or pattern library entry that this CAD file incorporates. Null if no print or pattern is applied.',
    `sketch_id` BIGINT COMMENT 'Reference to the initial design sketch or concept that this CAD file is based on. Tracks the evolution from sketch to technical CAD file.',
    `style_id` BIGINT COMMENT 'Reference to the parent style or product design that this CAD file represents. Links the digital file to the broader product design record.',
    `superseded_by_cad_file_id` BIGINT COMMENT 'Reference to the newer CAD file that supersedes this version. Null if this is the current version. Supports version lineage and obsolescence tracking.',
    `previous_version_cad_file_id` BIGINT COMMENT 'Self-referencing FK on cad_file (previous_version_cad_file_id)',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this CAD file was approved. Null if not yet approved. Tracks approval milestone in the design lifecycle.',
    `archived_timestamp` TIMESTAMP COMMENT 'The date and time when this CAD file was archived or moved to inactive status. Null if the file is still active. Supports lifecycle management and data retention policies.',
    `checksum_hash` STRING COMMENT 'A cryptographic hash (e.g., MD5, SHA-256) of the CAD file content. Used for file integrity verification, duplicate detection, and change detection.',
    `collaboration_notes` STRING COMMENT 'Free-text field for collaboration comments, feedback, or discussion notes related to this CAD file. Supports team communication and design iteration.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this CAD file record was first created in the system. Tracks the beginning of the file lifecycle.',
    `design_complexity` STRING COMMENT 'A qualitative assessment of the design complexity of the CAD file. Used for resource planning, costing, and production feasibility analysis.. Valid values are `simple|moderate|complex|highly_complex`',
    `design_phase` STRING COMMENT 'The stage in the product design lifecycle where this CAD file is currently positioned. Tracks progression from concept through production-ready status.. Valid values are `concept|initial_design|development|pre_production|production_ready|archived`',
    `file_format` STRING COMMENT 'The technical file format of the CAD file. Common formats include Adobe Illustrator (AI), CLO3D, Browzwear VStitcher, DXF, PDF, OBJ, FBX, STEP, IGES. Determines compatibility with design software and downstream systems. [ENUM-REF-CANDIDATE: AI|CLO3D|VSTITCHER|DXF|PDF|OBJ|FBX|STEP|IGES — 9 candidates stripped; promote to reference product]',
    `file_name` STRING COMMENT 'The original file name of the CAD or 3D design file as stored in the system, including extension. Used for file identification and retrieval.',
    `file_size_bytes` BIGINT COMMENT 'The size of the CAD file in bytes. Used for storage management, transfer planning, and system capacity planning.',
    `file_status` STRING COMMENT 'Current approval and lifecycle status of the CAD file. Indicates whether the file is in draft, under review, approved for production, rejected, superseded by a newer version, or archived.. Valid values are `draft|in_review|approved|rejected|superseded|archived`',
    `garment_category` STRING COMMENT 'The high-level product category that this CAD file represents (e.g., tops, bottoms, outerwear, footwear, accessories). Supports design taxonomy and filtering.',
    `is_3d_simulation` BOOLEAN COMMENT 'Boolean indicator of whether this CAD file includes 3D simulation capabilities or is a 3D model file (e.g., CLO3D, VStitcher). True indicates 3D simulation support, False indicates 2D CAD only.',
    `is_production_ready` BOOLEAN COMMENT 'Boolean indicator of whether this CAD file has been finalized and approved for production use. True indicates production-ready, False indicates still in design or development.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this CAD file was last modified or updated. Tracks the most recent change to the file record.',
    `rejection_reason` STRING COMMENT 'Free-text explanation of why the CAD file was rejected during review. Null if not rejected. Supports quality improvement and design iteration feedback.',
    `season_code` STRING COMMENT 'The season or collection identifier that this CAD file is associated with (e.g., SS24, FW24). Links the design file to merchandising and planning cycles.',
    `storage_location_type` STRING COMMENT 'The type of storage system where the CAD file resides. Options include local server, cloud storage (e.g., AWS S3, Azure Blob), PLM system, or network drive.. Valid values are `local_server|cloud_storage|plm_system|network_drive`',
    `storage_path` STRING COMMENT 'The full file system or cloud storage path where the CAD file is stored. Enables file retrieval and access management. Classified as confidential to protect internal storage architecture.',
    `tags` STRING COMMENT 'Comma-separated list of user-defined tags or keywords associated with this CAD file. Supports search, filtering, and categorization in design libraries.',
    `technical_notes` STRING COMMENT 'Free-text field for technical notes, design instructions, or special considerations related to this CAD file. Supports collaboration and knowledge transfer among design team members.',
    `thumbnail_path` STRING COMMENT 'The file path or URL to a thumbnail preview image of the CAD file. Supports quick visual identification and browsing in design management systems.',
    `version_number` STRING COMMENT 'Version identifier for the CAD file, tracking iterations and revisions throughout the design process. Supports version control and design history tracking.',
    CONSTRAINT pk_cad_file PRIMARY KEY(`cad_file_id`)
) COMMENT 'Master record for a CAD (Computer-Aided Design) or 3D digital design file associated with a style or design sketch. Captures file name, file format (Adobe Illustrator AI, CLO3D, Browzwear VStitcher, DXF, PDF), version number, design phase, associated style or sketch reference, 3D simulation status, file size, storage path, created by designer, last modified date, and approval status. Tracks the full digital design file lifecycle from initial CAD through approved production-ready file.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`design`.`colorway_development` (
    `colorway_development_id` BIGINT COMMENT 'Unique identifier for the colorway development record. Primary key for tracking a colorway through its design and approval lifecycle before it becomes a production-approved colorway in the product domain.',
    `collection_id` BIGINT COMMENT 'Reference to the broader collection or line to which this colorway development belongs. Enables grouping of related colorways within a cohesive product offering.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Lab dip, strike-off, and color development costs are allocated to design cost centers for product development cost tracking and budget variance analysis in apparel operations.',
    `designer_id` BIGINT COMMENT 'Reference to the designer responsible for creating and developing this colorway. Links to workforce or user management systems for accountability and collaboration tracking.',
    `material_certification_id` BIGINT COMMENT 'Foreign key linking to sustainability.material_certification. Business justification: Colorway development requires certified materials with valid chain-of-custody (TC numbers). Real process: colorway approval gates verify certification status and expiry dates before lab dip approval.',
    `print_design_id` BIGINT COMMENT 'Reference to a print or pattern from the design library if this colorway includes printed or patterned elements. Links to the print and pattern libraries managed in PLM (Product Lifecycle Management) systems.',
    `style_id` BIGINT COMMENT 'Reference to the parent style for which this colorway is being developed. Links the colorway development to the base design style.',
    `supplier_factory_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_factory. Business justification: Colorway development targets specific factory capabilities for lab dip and strike-off approvals - factories have different dyeing/printing equipment, so colorways are developed with factory-specific t',
    `sustainable_material_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainable_material. Business justification: Colorway approval requires material specification for lab dips and strike-offs. Sustainable materials have specific dyeing/finishing requirements. Real process: colorway development tracks material+co',
    `vendor_id` BIGINT COMMENT 'Reference to the fabric mill or dye house supplier responsible for producing the lab dips and strike-offs. Critical for supplier performance tracking and sourcing decisions.',
    `revised_colorway_development_id` BIGINT COMMENT 'Self-referencing FK on colorway_development (revised_colorway_development_id)',
    `body_color_hex` STRING COMMENT 'Hexadecimal color code for the body color, used for digital design tools, CAD systems, and e-commerce visualization. Example: #1A2B3C.. Valid values are `^#[0-9A-Fa-f]{6}$`',
    `body_color_ncs` STRING COMMENT 'NCS (Natural Color System) code for the body color, used as an alternative or complementary color specification system. Example: S 2070-R80B.',
    `body_color_pantone` STRING COMMENT 'Pantone color reference for the main body fabric or material. Provides standardized color specification for manufacturing and quality control. Example: PANTONE 19-4052 TCX.',
    `body_color_ral` STRING COMMENT 'RAL color standard code for the body color, commonly used in European manufacturing. Example: RAL 5005.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the colorway development was cancelled (e.g., Failed to meet color standards, Market trend shift, Cost prohibitive, Supplier capability constraints). Provides learning for future design decisions.',
    `cancelled_date` DATE COMMENT 'Date when the colorway development was cancelled or rejected. Captures design decisions to discontinue a colorway before production approval.',
    `color_matching_tolerance` STRING COMMENT 'Acceptable color deviation tolerance specification (e.g., Delta E < 1.0, Grade 4-5 Grey Scale). Defines quality standards for lab dip and production approval using industry-standard color measurement systems.',
    `color_story_theme` STRING COMMENT 'Overarching theme or narrative that inspired the colorway palette (e.g., Urban Jungle, Coastal Sunset, Nordic Minimalism). Provides creative context for the color selection and guides design cohesion across the collection.',
    `colorfastness_requirement` STRING COMMENT 'Required colorfastness performance standards for washing, light, crocking, and perspiration. Example: AATCC 61-2A Grade 4 minimum. Critical for product quality and compliance with consumer safety standards.',
    `colorway_code` STRING COMMENT 'Internal alphanumeric code assigned to the colorway during development phase. May become part of the SKU (Stock Keeping Unit) structure upon production approval.',
    `colorway_name` STRING COMMENT 'Proposed name for the colorway, typically reflecting the color story or theme (e.g., Midnight Navy, Desert Sand, Ocean Breeze). Used for internal design communication and eventual product marketing.',
    `confirmed_date` DATE COMMENT 'Date when the colorway was officially confirmed for production. Marks the transition from design development to production-ready status and triggers creation of the master colorway record in the product domain.',
    `contrast_color_hex` STRING COMMENT 'Hexadecimal color code for contrast elements, used in digital design and visualization tools.. Valid values are `^#[0-9A-Fa-f]{6}$`',
    `contrast_color_pantone` STRING COMMENT 'Pantone color reference for contrast elements such as piping, stitching, or accent panels. Ensures color consistency across components.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the colorway development record was first created in the PLM (Product Lifecycle Management) system. Audit trail for design process tracking.',
    `designer_notes` STRING COMMENT 'Free-text notes from the designer capturing creative intent, inspiration sources, color matching challenges, or special instructions for production. Bridges design vision to manufacturing execution.',
    `development_status` STRING COMMENT 'Current stage in the colorway development and approval lifecycle. Tracks progression from initial proposal through lab dip and strike-off approval to final confirmation or rejection. Critical for Time and Action (TNA) calendar management. [ENUM-REF-CANDIDATE: proposed|lab_dip_requested|lab_dip_approved|lab_dip_rejected|strike_off_requested|strike_off_approved|strike_off_rejected|confirmed|cancelled — 9 candidates stripped; promote to reference product]',
    `lab_dip_approval_round` STRING COMMENT 'Number of lab dip submission rounds required to achieve approval. Tracks color matching difficulty and supplier capability. Higher numbers indicate color complexity or supplier challenges.',
    `lab_dip_approved_date` DATE COMMENT 'Date when the lab dip sample was approved by the design and technical teams. Milestone date that allows progression to strike-off or bulk production.',
    `lab_dip_received_date` DATE COMMENT 'Date when lab dip samples were received for review and approval. Used to track supplier responsiveness and TNA (Time and Action) adherence.',
    `lab_dip_requested_date` DATE COMMENT 'Date when lab dip samples were requested from the supplier or mill. Lab dips are physical color samples used to approve dye formulations before bulk production.',
    `lining_color_hex` STRING COMMENT 'Hexadecimal color code for lining fabric, used in digital design documentation and tech pack specifications.. Valid values are `^#[0-9A-Fa-f]{6}$`',
    `lining_color_pantone` STRING COMMENT 'Pantone color reference for interior lining fabric. Ensures consistency in hidden components that affect overall product quality perception.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the colorway development record. Tracks design iteration activity and collaboration workflow.',
    `mood_board_reference` STRING COMMENT 'Reference identifier or URL to the mood board or design inspiration board that guided this colorway development. Links to digital asset management systems or PLM visual libraries.',
    `season_code` STRING COMMENT 'Season and year identifier for which this colorway is being developed (e.g., SS24 for Spring/Summer 2024, FW24 for Fall/Winter 2024). Critical for collection planning and merchandising alignment.. Valid values are `^(SS|FW|AW|SP)[0-9]{2}$`',
    `strike_off_approved_date` DATE COMMENT 'Date when the strike-off sample was approved. Critical milestone for printed or patterned colorways before bulk fabric production.',
    `strike_off_requested_date` DATE COMMENT 'Date when strike-off samples (printed fabric samples) were requested for colorways involving prints or patterns. Strike-offs validate print quality and color accuracy on actual fabric.',
    `sustainability_certification` STRING COMMENT 'Sustainability or environmental certifications applicable to the colorway dyes and processes (e.g., GOTS Certified, OEKO-TEX Standard 100, bluesign approved). Supports compliance with environmental standards and brand sustainability commitments.',
    `target_cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the target cost (e.g., USD, EUR, GBP). Ensures accurate cost tracking across global sourcing operations.. Valid values are `^[A-Z]{3}$`',
    `target_cost_per_unit` DECIMAL(18,2) COMMENT 'Target cost for the colorway components (fabric, dye, trim) per unit. Used for cost estimation during design phase and informs Open-to-Buy (OTB) planning and Initial Markup (IMU) calculations.',
    `technical_notes` STRING COMMENT 'Technical observations and requirements from the product development or technical design team regarding dye processes, fabric compatibility, colorfastness requirements, or manufacturing constraints.',
    `trend_research_reference` STRING COMMENT 'Reference to trend research reports or forecasting sources that influenced the colorway selection (e.g., WGSN report ID, Pantone Color of the Year). Provides market validation for design decisions.',
    `trim_color_hex` STRING COMMENT 'Hexadecimal color code for trim components, used in digital tech packs and 3D design visualization.. Valid values are `^#[0-9A-Fa-f]{6}$`',
    `trim_color_pantone` STRING COMMENT 'Pantone color reference for trim components such as zippers, buttons, hardware, and labels. Critical for Bill of Materials (BOM) accuracy and sourcing.',
    CONSTRAINT pk_colorway_development PRIMARY KEY(`colorway_development_id`)
) COMMENT 'Design-domain record tracking the development and approval lifecycle of a colorway for a specific style during the design phase — distinct from the product.colorway master which is the approved production record. Captures style reference, proposed colorway name, color story theme, Pantone/NCS/RAL color codes per component (body, contrast, trim, lining), colorway development status (proposed, lab dip requested, lab dip approved, rejected, confirmed), season, and designer notes. Bridges design intent to production colorway approval.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`design`.`print_design` (
    `print_design_id` BIGINT COMMENT 'Unique identifier for the print design record. Primary key for the print design entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Print design development costs including artwork, licensing, and strike-offs are tracked to design cost centers for design budget management and royalty expense allocation.',
    `designer_id` BIGINT COMMENT 'Identifier of the designer or design team member who created this print design. Links to workforce management system for attribution and portfolio tracking.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who granted final approval for this print design. Typically a design director, merchandising manager, or creative director.',
    `original_print_design_id` BIGINT COMMENT 'Self-referencing FK on print_design (original_print_design_id)',
    `approval_date` DATE COMMENT 'The date when the print design received final approval. Used for Time and Action (TNA) calendar tracking and production timeline management.',
    `approval_status` STRING COMMENT 'The formal approval decision status for this print design. Determines whether the design can proceed to production sampling and manufacturing.. Valid values are `pending|approved|rejected|conditional|on_hold`',
    `collection_name` STRING COMMENT 'The name of the product collection or line that this print design belongs to. Links the design to merchandising and marketing strategies.',
    `color_count` STRING COMMENT 'The total number of distinct colors used in the print design. Impacts printing cost, complexity, and production method selection.',
    `color_profile` STRING COMMENT 'The color space or profile used in the print design file. Ensures accurate color reproduction across different media and printing technologies.. Valid values are `CMYK|RGB|Pantone|LAB`',
    `colorway_count` STRING COMMENT 'The total number of color variations developed for this print design. Each colorway represents a distinct color palette application of the same base design.',
    `copyright_year` STRING COMMENT 'The year in which copyright protection was established for this print design. Used for intellectual property protection and legal compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this print design record was first created in the system. Used for audit trail and design portfolio tracking.',
    `design_medium` STRING COMMENT 'The creative medium or technique used to create the original print artwork. Impacts file format requirements and reproduction quality.. Valid values are `hand_painted|digital|repeat_tile|photographic|mixed_media|vector`',
    `design_notes` STRING COMMENT 'Free-text field for designers and stakeholders to capture creative rationale, technical specifications, production considerations, or feedback related to the print design.',
    `design_status` STRING COMMENT 'Current lifecycle status of the print design in the approval workflow. Governs visibility and usage permissions across the organization.. Valid values are `concept|in_development|submitted|approved|rejected|archived`',
    `design_theme` STRING COMMENT 'The creative theme or inspiration concept behind the print design. Examples include floral, geometric, abstract, animal, nautical, ethnic, or seasonal themes.',
    `fabric_compatibility` STRING COMMENT 'Description of fabric types and compositions that are suitable for this print design. May include restrictions based on print technique or design characteristics.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this print design is currently active and available for use in new product development. Inactive designs are retained for historical reference.',
    `is_licensed_artwork` BOOLEAN COMMENT 'Boolean flag indicating whether this print design uses licensed artwork from an external artist or intellectual property holder versus original in-house creation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this print design record was most recently updated. Tracks design iteration and version control.',
    `license_agreement_number` STRING COMMENT 'The contract or agreement reference number governing the use of licensed artwork. Used for royalty tracking and compliance verification.',
    `license_holder_name` STRING COMMENT 'The name of the individual artist, agency, or organization that holds the intellectual property rights for licensed artwork. Null for original designs.',
    `master_file_format` STRING COMMENT 'The file format of the master print design file. Determines compatibility with design software, printing systems, and production workflows. [ENUM-REF-CANDIDATE: AI|PSD|PDF|TIFF|PNG|SVG|EPS — 7 candidates stripped; promote to reference product]',
    `master_file_path` STRING COMMENT 'The file system or cloud storage path to the master high-resolution print design file. Used for production, printing, and archival purposes.',
    `master_file_size_mb` DECIMAL(18,2) COMMENT 'The file size of the master print design file measured in megabytes. Used for storage planning and file transfer optimization.',
    `primary_color_hex` STRING COMMENT 'The dominant color in the print design represented as a hexadecimal color code. Used for color matching, merchandising, and digital asset management.. Valid values are `^#[0-9A-Fa-f]{6}$`',
    `print_code` STRING COMMENT 'Unique alphanumeric code assigned to the print design for system identification and cross-referencing in Product Lifecycle Management (PLM) and Enterprise Resource Planning (ERP) systems.. Valid values are `^[A-Z0-9]{6,12}$`',
    `print_name` STRING COMMENT 'The creative name or title assigned to this print design by the design team. Used for identification and reference in collections and tech packs.',
    `print_resolution_dpi` STRING COMMENT 'The resolution of the print design file measured in dots per inch. Higher DPI ensures better print quality and detail reproduction.',
    `print_technique` STRING COMMENT 'The recommended or required printing technique for applying this design to fabric. Impacts production cost, lead time, and fabric compatibility.. Valid values are `screen_print|digital_print|sublimation|rotary_print|discharge_print|block_print`',
    `print_type` STRING COMMENT 'Classification of the print design based on application method and placement on the garment. Determines manufacturing process and costing.. Valid values are `allover_print|engineered_print|border_print|placement_print|jacquard|embroidery`',
    `repeat_height_cm` DECIMAL(18,2) COMMENT 'The vertical height of one complete pattern repeat measured in centimeters. Used in fabric yield calculations and production planning.',
    `repeat_type` STRING COMMENT 'The pattern repeat structure used in the print design. Defines how the design tiles across fabric yardage and impacts fabric utilization and cutting efficiency.. Valid values are `full_repeat|half_drop|brick|mirror|toss|engineered`',
    `repeat_width_cm` DECIMAL(18,2) COMMENT 'The horizontal width of one complete pattern repeat measured in centimeters. Critical for fabric ordering and marker making efficiency.',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'The percentage of revenue or fixed fee per unit owed to the license holder for use of the artwork. Critical for Cost of Goods Sold (COGS) calculation.',
    `season_code` STRING COMMENT 'The fashion season and year for which this print design was created. Format: SS=Spring/Summer, FW=Fall/Winter, SP=Spring, FA=Fall, HO=Holiday followed by two-digit year.. Valid values are `^(SS|FW|SP|FA|HO)[0-9]{2}$`',
    `secondary_color_hex` STRING COMMENT 'The secondary prominent color in the print design represented as a hexadecimal color code. Supports color story development and assortment planning.. Valid values are `^#[0-9A-Fa-f]{6}$`',
    `sustainability_certification` STRING COMMENT 'Any sustainability or environmental certification applicable to the print design, particularly related to dyes, chemicals, or production methods used.. Valid values are `GOTS|OEKO_TEX|BCI|none`',
    `trend_alignment` STRING COMMENT 'The macro fashion trend or consumer insight that this print design addresses. Links design decisions to market research and trend forecasting.',
    `usage_rights` STRING COMMENT 'The scope of rights granted for use of this print design. Defines geographic, product category, or time-based restrictions on design application.. Valid values are `exclusive|non_exclusive|limited_territory|limited_category|unlimited`',
    CONSTRAINT pk_print_design PRIMARY KEY(`print_design_id`)
) COMMENT 'Master record for an original print or surface design created by the design team. Captures print name, print type (allover print, engineered print, border print, placement print, jacquard, embroidery), design medium (hand-painted, digital, repeat tile), repeat size, colorway count, season, designer, approval status, licensing flag (original vs. licensed artwork), and file references. The print library is a core creative IP asset for apparel brands.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`design`.`print_colorway` (
    `print_colorway_id` BIGINT COMMENT 'Unique identifier for the print colorway record. Primary key.',
    `designer_id` BIGINT COMMENT 'Identifier of the designer who created or specified this colorway variant.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved this colorway for production or use.',
    `print_design_id` BIGINT COMMENT 'Reference to the parent print design that this colorway is based on. Links to the master print design asset.',
    `supplier_factory_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_factory. Business justification: Print colorways are developed with specific factories for strike-off approvals - print quality varies by factory equipment, so colorways are approved against factory-specific strike-off samples before',
    `vendor_id` BIGINT COMMENT 'Identifier of the mill, printer, or supplier responsible for producing this colorway.',
    `derived_from_print_colorway_id` BIGINT COMMENT 'Self-referencing FK on print_colorway (derived_from_print_colorway_id)',
    `approval_date` DATE COMMENT 'Date when the colorway was officially approved for production or inclusion in the collection.',
    `azo_free` BOOLEAN COMMENT 'Indicates whether the colorway is produced using azo-free dyes, which are safer and more environmentally friendly.',
    `cmyk_color_formula` STRING COMMENT 'Cyan, Magenta, Yellow, Black color formula for digital printing and reproduction. Format: C:xx M:xx Y:xx K:xx.',
    `collection_name` STRING COMMENT 'Name of the collection or product line this colorway is associated with.',
    `color_fastness_rating` STRING COMMENT 'Color fastness test rating (1-5 scale) indicating resistance to fading from washing, light exposure, and rubbing. Higher numbers indicate better fastness.. Valid values are `^[1-5]$`',
    `color_palette_description` STRING COMMENT 'Narrative description of the overall color palette and color story for this colorway, including mood and aesthetic intent.',
    `colorway_code` STRING COMMENT 'Unique business identifier for the colorway variant. Used in tech packs, production orders, and material specifications.. Valid values are `^[A-Z0-9]{4,12}$`',
    `colorway_name` STRING COMMENT 'Descriptive name for the colorway variant, often reflecting the dominant color theme or inspiration (e.g., Ocean Blue, Sunset Coral, Forest Green).',
    `colorway_status` STRING COMMENT 'Current lifecycle status of the colorway in the design and production workflow.. Valid values are `draft|pending_approval|approved|rejected|in_production|discontinued`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this colorway record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `digital_file_format` STRING COMMENT 'File format of the digital artwork (e.g., AI for Adobe Illustrator, EPS, PDF, PSD for Photoshop). [ENUM-REF-CANDIDATE: AI|EPS|PDF|PSD|TIFF|PNG|JPG — 7 candidates stripped; promote to reference product]',
    `digital_file_path` STRING COMMENT 'File system path or cloud storage location of the digital artwork file for this colorway.',
    `gender_target` STRING COMMENT 'Target gender demographic for this colorway variant.. Valid values are `mens|womens|unisex|kids_boys|kids_girls|kids_unisex`',
    `hex_color_code` STRING COMMENT 'Hexadecimal color code for web and digital applications. Format: #RRGGBB.. Valid values are `^#[0-9A-Fa-f]{6}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this colorway record was last updated or modified.',
    `lead_time_days` STRING COMMENT 'Number of days required from order placement to delivery of the printed fabric in this colorway.',
    `minimum_order_quantity` STRING COMMENT 'Minimum order quantity required by the supplier to produce this colorway, typically measured in yards or meters.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this colorway variant.',
    `oeko_tex_compliant` BOOLEAN COMMENT 'Indicates whether the colorway uses dyes and chemicals that meet OEKO-TEX Standard 100 certification for textile safety.',
    `primary_pantone_code` STRING COMMENT 'Primary Pantone color reference for the dominant color in this colorway. Used for color matching and production specifications.. Valid values are `^PANTONE [0-9]{1,4}[A-Z]{0,2}$`',
    `print_layer_count` STRING COMMENT 'Number of distinct color layers or screens required to produce this colorway. Impacts production complexity and cost.',
    `print_technique` STRING COMMENT 'Printing method or technique specified for producing this colorway (e.g., screen print, digital print, sublimation). [ENUM-REF-CANDIDATE: screen_print|digital_print|sublimation|rotary_print|block_print|discharge_print|pigment_print — 7 candidates stripped; promote to reference product]',
    `product_category` STRING COMMENT 'Product category or division this colorway is intended for (e.g., Activewear, Outerwear, Swimwear, Accessories).',
    `rejection_reason` STRING COMMENT 'Explanation or reason provided if the colorway was rejected during the approval process.',
    `rgb_color_code` STRING COMMENT 'Red, Green, Blue color code for digital display and e-commerce imagery. Format: rgb(r, g, b).. Valid values are `^rgb([0-9]{1,3}, [0-9]{1,3}, [0-9]{1,3})$`',
    `season_code` STRING COMMENT 'Season identifier for which this colorway is intended (e.g., SS24 for Spring/Summer 2024, FW24 for Fall/Winter 2024).. Valid values are `^(SS|FW|AW|SP)[0-9]{2}$`',
    `secondary_pantone_code` STRING COMMENT 'Secondary Pantone color reference for accent or supporting colors in the colorway.. Valid values are `^PANTONE [0-9]{1,4}[A-Z]{0,2}$`',
    `strike_off_approval_date` DATE COMMENT 'Date when the strike-off sample was approved for bulk production.',
    `strike_off_status` STRING COMMENT 'Status of the physical strike-off sample approval process. Strike-offs are physical print samples submitted by mills or printers for color and quality approval before bulk production. [ENUM-REF-CANDIDATE: not_requested|requested|in_progress|submitted|approved|rejected|revision_required — 7 candidates stripped; promote to reference product]',
    `strike_off_submission_date` DATE COMMENT 'Date when the physical strike-off sample was submitted for approval.',
    `style_reference_codes` STRING COMMENT 'Comma-separated list of style codes or SKU (Stock Keeping Unit) references that use this colorway. Links the colorway to specific garments or products.',
    `substrate_type` STRING COMMENT 'Type of fabric or material substrate this colorway is designed for (e.g., cotton jersey, polyester knit, silk).',
    `sustainability_certification` STRING COMMENT 'Sustainability or environmental certification applicable to this colorway (e.g., GOTS, Bluesign, Cradle to Cradle).',
    `target_market` STRING COMMENT 'Geographic market or region this colorway is designed for, reflecting regional color preferences and trends.. Valid values are `north_america|europe|asia_pacific|latin_america|middle_east|global`',
    `tertiary_pantone_code` STRING COMMENT 'Tertiary Pantone color reference for additional accent colors in multi-color prints.. Valid values are `^PANTONE [0-9]{1,4}[A-Z]{0,2}$`',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit (yard or meter) to produce this colorway, including dyes, printing, and finishing.',
    CONSTRAINT pk_print_colorway PRIMARY KEY(`print_colorway_id`)
) COMMENT 'Transactional record capturing a specific color variant of a print design. A single print design may be executed in multiple colorways for different styles or markets. Captures print design reference, colorway name, color codes per print layer (Pantone, CMYK, RGB), strike-off status (requested, approved, rejected), season, and associated style references. Enables the print library to track all approved color executions of each print asset.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`design`.`pattern_block` (
    `pattern_block_id` BIGINT COMMENT 'Unique identifier for the pattern block record. Primary key.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the design team or division that owns and maintains this pattern block. Links to organizational hierarchy.',
    `employee_id` BIGINT COMMENT 'Identifier of the pattern maker or technical designer who created or owns this pattern block. Links to workforce/employee master data.',
    `base_pattern_block_id` BIGINT COMMENT 'Self-referencing FK on pattern_block (base_pattern_block_id)',
    `approval_date` DATE COMMENT 'Date when the pattern block was formally approved for use in production design. Nullable for blocks still in draft status.',
    `block_code` STRING COMMENT 'Unique alphanumeric business identifier for the pattern block used across PLM and design systems. This is the externally-known code for referencing the block in technical documentation and production systems.. Valid values are `^[A-Z0-9]{6,12}$`',
    `block_description` STRING COMMENT 'Detailed textual description of the pattern block, including key construction features, design intent, and usage guidelines (e.g., Basic bodice block with princess seams, designed for woven fabrics with 2-inch ease at bust).',
    `block_name` STRING COMMENT 'Human-readable name of the pattern block (e.g., Basic Bodice Block, Slim Fit Trouser Block, Oversized Hoodie Block). This is the primary identity label for the pattern block.',
    `block_status` STRING COMMENT 'Current lifecycle status of the pattern block (e.g., draft, approved, active, archived, deprecated). Indicates whether the block is in development, ready for use, or retired.. Valid values are `draft|approved|active|archived|deprecated`',
    `body_measurement_basis` STRING COMMENT 'Reference body measurement standard or fit model specification used as the foundation for this pattern block (e.g., ASTM D5585, ISO 8559-1, Company Fit Model Size 8, US Standard Sizing Chart).',
    `ease_allowance_inches` DECIMAL(18,2) COMMENT 'Standard ease allowance built into the pattern block, measured in inches. Represents the difference between body measurement and garment measurement at key points (e.g., 2.00 inches at bust, 1.50 inches at waist).',
    `fabric_type_recommendation` STRING COMMENT 'Recommended fabric types or fabric characteristics for which this pattern block is optimized (e.g., Woven fabrics with minimal stretch, Knit fabrics with 20-30% stretch, Structured outerwear fabrics).',
    `fit_type` STRING COMMENT 'Intended fit profile of the pattern block (e.g., slim, regular, relaxed, oversized, athletic, tailored). Defines the silhouette and ease allowance built into the block.. Valid values are `slim|regular|relaxed|oversized|athletic|tailored`',
    `garment_category` STRING COMMENT 'High-level classification of the garment type this pattern block is designed for (e.g., tops, bottoms, dresses, outerwear, activewear, accessories).. Valid values are `tops|bottoms|dresses|outerwear|activewear|accessories`',
    `garment_subcategory` STRING COMMENT 'Detailed subcategory within the garment category (e.g., T-Shirt, Blouse, Jeans, Chinos, Maxi Dress, Parka, Leggings, Sports Bra).',
    `gender_target` STRING COMMENT 'Target gender demographic for the pattern block (e.g., mens, womens, unisex, kids_boys, kids_girls). Determines body measurement standards and proportions.. Valid values are `mens|womens|unisex|kids_boys|kids_girls`',
    `grading_rules_reference` STRING COMMENT 'Reference to the grading rule set or grading specification document that defines how this pattern block scales across sizes (e.g., GR-2024-WOMENS-TOPS, Standard 2-inch Grade, Athletic Fit Grade Rule v3).',
    `is_proprietary` BOOLEAN COMMENT 'Flag indicating whether this pattern block is proprietary intellectual property developed in-house (True) or based on industry-standard blocks (False).',
    `last_modified_date` DATE COMMENT 'Date when the pattern block was last updated or revised. Tracks the most recent change to the block specifications.',
    `measurement_chart_url` STRING COMMENT 'URL or file path to the detailed measurement chart (spec sheet) that documents all key measurements for this pattern block across the size range.',
    `notes` STRING COMMENT 'Additional free-form notes, comments, or special instructions related to the pattern block. Captures ad-hoc information not covered by structured fields.',
    `pattern_file_format` STRING COMMENT 'Digital file format of the pattern block (e.g., DXF, AAMA, ASTM, PLT, PDF, proprietary CAD format). Indicates the CAD system compatibility.. Valid values are `DXF|AAMA|ASTM|PLT|PDF|proprietary_cad`',
    `pattern_file_path` STRING COMMENT 'File system path or PLM repository location where the digital pattern block file is stored (e.g., CAD file, DXF, AAMA format). Confidential IP asset location.',
    `pattern_version` STRING COMMENT 'Version number of the pattern block (e.g., v1.0, v2.3). Incremented when the block is revised or updated. Enables version control and traceability of pattern evolution.. Valid values are `^v[0-9]+.[0-9]+$`',
    `seam_allowance_inches` DECIMAL(18,2) COMMENT 'Standard seam allowance included in the pattern block, measured in inches (e.g., 0.50 inches, 0.375 inches). Defines the margin added beyond the stitching line for seam construction.',
    `size_range_end` STRING COMMENT 'Ending size in the size range this pattern block covers (e.g., XXL, 18, 42, 12). Represents the largest size for which this block is graded.',
    `size_range_start` STRING COMMENT 'Starting size in the size range this pattern block covers (e.g., XS, 2, 28, 4T). Represents the smallest size for which this block is graded.',
    `sustainability_notes` STRING COMMENT 'Notes on sustainability considerations built into the pattern block design (e.g., Optimized for zero-waste cutting, Designed for fabric efficiency, Modular construction for repair).',
    `technical_sketch_url` STRING COMMENT 'URL or file path to the technical sketch or flat drawing that illustrates the pattern block design. Used for visual reference in PLM and design collaboration.',
    `usage_count` STRING COMMENT 'Number of styles or products that have been derived from this pattern block. Tracks the reuse and value of this IP asset across collections.',
    `creation_date` DATE COMMENT 'Date when the pattern block was originally created in the PLM system. Represents the initial capture of this reusable IP asset.',
    CONSTRAINT pk_pattern_block PRIMARY KEY(`pattern_block_id`)
) COMMENT 'Master record for a base pattern block (sloper) used as the foundational template for garment construction. Captures block name, garment category, fit type (slim, regular, relaxed, oversized), gender, size range, body measurement basis, pattern version, grading rules reference, creation date, and pattern maker owner. Pattern blocks are reusable IP assets that underpin the technical construction of multiple styles across seasons.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`design`.`review` (
    `review_id` BIGINT COMMENT 'Unique identifier for the design review session. Primary key.',
    `collection_id` BIGINT COMMENT 'Reference to the collection being reviewed in this session.',
    `concept_id` BIGINT COMMENT 'Reference to the design concept under review, if applicable.',
    `employee_id` BIGINT COMMENT 'Reference to the executive or design director who provided final approval for the review outcomes.',
    `review_created_by_employee_id` BIGINT COMMENT 'Reference to the user who created the design review record.',
    `review_employee_id` BIGINT COMMENT 'Reference to the design director or lead reviewer who chaired the session.',
    `review_last_modified_by_employee_id` BIGINT COMMENT 'Reference to the user who last modified the design review record.',
    `review_next_action_owner_employee_id` BIGINT COMMENT 'Reference to the employee or designer responsible for executing the next actions following the review.',
    `follow_up_review_id` BIGINT COMMENT 'Self-referencing FK on review (follow_up_review_id)',
    `agenda` STRING COMMENT 'Detailed agenda or objectives for the design review session, outlining topics and focus areas.',
    `approval_status` STRING COMMENT 'Overall approval status of the design review session outcome (pending, approved, conditionally approved, rejected).. Valid values are `pending|approved|conditionally_approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the design review outcomes were formally approved.',
    `brand_alignment_score` DECIMAL(18,2) COMMENT 'Numeric score (0.00 to 5.00) representing how well the reviewed designs align with brand identity and strategic direction.',
    `commercial_feedback` STRING COMMENT 'Feedback from the commercial team on sales potential, customer demand, and distribution strategy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the design review record was first created in the system.',
    `end_time` TIMESTAMP COMMENT 'Timestamp when the design review session concluded.',
    `follow_up_review_date` DATE COMMENT 'Scheduled date for the follow-up design review session, if applicable.',
    `follow_up_review_scheduled` BOOLEAN COMMENT 'Indicates whether a follow-up review session has been scheduled to re-evaluate revised styles.',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the design review session and its outcomes are confidential and subject to restricted access.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the design review record was last updated.',
    `location` STRING COMMENT 'Physical or virtual location where the design review session was held (e.g., Design Studio NYC, Virtual - Zoom, Milan Showroom).',
    `meeting_minutes_url` STRING COMMENT 'URL or file path to the detailed meeting minutes document for the design review session.. Valid values are `^https?://.*`',
    `merchandising_feedback` STRING COMMENT 'Feedback provided by the merchandising team regarding commercial viability, pricing, and market fit.',
    `next_action_due_date` DATE COMMENT 'Target date by which the next actions or revisions must be completed.',
    `notes` STRING COMMENT 'General notes and observations captured during the design review session.',
    `participant_list` STRING COMMENT 'Comma-separated list of participant names or IDs who attended the design review session (design team, merchandising, commercial teams).',
    `presentation_file_path` STRING COMMENT 'File path or URL to the presentation materials used during the design review session.',
    `rejection_reason` STRING COMMENT 'Explanation for why the design review outcomes were rejected or not approved, if applicable.',
    `review_code` STRING COMMENT 'Business identifier for the design review session, used for external reference and tracking.. Valid values are `^DR-[A-Z0-9]{6,12}$`',
    `review_date` DATE COMMENT 'The date on which the design review session took place. This is the principal business event timestamp for the review.',
    `review_name` STRING COMMENT 'Descriptive name of the design review session (e.g., Spring 2025 Concept Review, Fall Line Adoption Review).',
    `review_status` STRING COMMENT 'Current lifecycle status of the design review session (scheduled, in progress, completed, cancelled, postponed).. Valid values are `scheduled|in_progress|completed|cancelled|postponed`',
    `review_type` STRING COMMENT 'Type of design review session indicating the stage in the design calendar (concept review, line review, final adoption review, pre-production review, sample review, technical review).. Valid values are `concept_review|line_review|final_adoption_review|pre_production_review|sample_review|technical_review`',
    `revision_instructions` STRING COMMENT 'Consolidated revision instructions and feedback provided to designers for styles requiring changes.',
    `season_code` STRING COMMENT 'Season identifier for the collection under review (e.g., SS25 for Spring/Summer 2025, FW24 for Fall/Winter 2024).. Valid values are `^(SS|FW|AW|SP)[0-9]{2}$`',
    `start_time` TIMESTAMP COMMENT 'Timestamp when the design review session started.',
    `styles_adopted_count` STRING COMMENT 'Number of styles approved for adoption and progression to the next stage.',
    `styles_dropped_count` STRING COMMENT 'Number of styles rejected and removed from the collection pipeline.',
    `styles_reviewed_count` STRING COMMENT 'Total number of styles or designs evaluated during this review session.',
    `styles_revised_count` STRING COMMENT 'Number of styles requiring revisions before re-submission.',
    `sustainability_assessment` STRING COMMENT 'Assessment of the sustainability aspects of the designs reviewed, including material sourcing, environmental impact, and compliance with sustainability standards (GOTS, BCI, OEKO-TEX).',
    `technical_feedback` STRING COMMENT 'Technical feedback on feasibility, construction, materials, and production considerations.',
    `trend_alignment_score` DECIMAL(18,2) COMMENT 'Numeric score (0.00 to 5.00) representing how well the reviewed designs align with current and forecasted market trends.',
    CONSTRAINT pk_review PRIMARY KEY(`review_id`)
) COMMENT 'Transactional record of a formal design review session where sketches, CAD files, or samples are evaluated by the design director, merchandising, and commercial teams. Captures review date, review type (concept review, line review, final adoption review), participants, styles reviewed, decisions per style (adopted, revised, dropped), revision instructions, and next action owner. Design reviews are the critical gate events in the seasonal design calendar.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`design`.`review_item` (
    `review_item_id` BIGINT COMMENT 'Unique identifier for the design review item record. Primary key for tracking individual style-level decisions within design review sessions.',
    `designer_id` BIGINT COMMENT 'Reference to the designer responsible for executing any required revisions or advancing this style to the next development phase.',
    `employee_id` BIGINT COMMENT 'Reference to the lead reviewer or decision-maker who provided the final decision for this item. Typically a design director or merchandising leader.',
    `review_id` BIGINT COMMENT 'Reference to the parent design review session in which this style was evaluated. Links this item to the broader review gate event.',
    `sketch_id` BIGINT COMMENT 'Reference to the design sketch being reviewed if the item is still in conceptual phase and not yet a finalized style. Nullable for finalized styles.',
    `style_id` BIGINT COMMENT 'Reference to the style or design being reviewed. May link to a finalized style master record or a design sketch depending on review stage.',
    `tertiary_review_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who most recently modified this design review item record. Supports change tracking and audit requirements.',
    `previous_review_item_id` BIGINT COMMENT 'Self-referencing FK on review_item (previous_review_item_id)',
    `brand_alignment_score` STRING COMMENT 'Numeric assessment of how well this style aligns with brand identity, aesthetic standards, and strategic positioning. Scale typically 1-10.',
    `color_story` STRING COMMENT 'Narrative description of the color palette and colorway strategy for this style. Captures the creative vision and seasonal color direction.',
    `commercial_feedback` STRING COMMENT 'Input from merchandising and commercial teams regarding market viability, pricing potential, target customer fit, and sales forecasts for this style.',
    `competitive_benchmark` STRING COMMENT 'Reference to competitor products or market comparables used to evaluate this styles positioning, pricing, and differentiation strategy.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this design review item record was first created in the system. Audit trail for data lineage and compliance.',
    `decision_rationale` STRING COMMENT 'Detailed explanation of why the reviewer decision was made. Captures strategic, commercial, or creative reasoning behind adopt, revise, drop, or hold outcomes.',
    `decision_timestamp` TIMESTAMP COMMENT 'Date and time when the reviewer decision was finalized for this item. Critical for tracking review gate progression and Time and Action (TNA) calendar adherence.',
    `estimated_cogs` DECIMAL(18,2) COMMENT 'Projected Cost of Goods Sold (COGS) for this style including materials, labor, and manufacturing overhead. Critical for margin analysis and pricing decisions.',
    `estimated_retail_price` DECIMAL(18,2) COMMENT 'Projected Manufacturers Suggested Retail Price (MSRP) for this style. Used to evaluate price tier positioning and competitive landscape fit.',
    `estimated_unit_volume` STRING COMMENT 'Projected production quantity or sales volume for this style. Used to assess commercial scale and manufacturing feasibility.',
    `estimated_wholesale_price` DECIMAL(18,2) COMMENT 'Projected wholesale price point for this style based on cost estimates and target margin. Used for commercial viability assessment during review.',
    `fabric_type` STRING COMMENT 'Primary fabric or material composition for this style. Critical for cost estimation, sustainability assessment, and technical feasibility evaluation.',
    `gender_target` STRING COMMENT 'Intended gender demographic for this style. Used for collection segmentation and merchandising planning.. Valid values are `mens|womens|unisex|kids|infant`',
    `is_active` BOOLEAN COMMENT 'Indicates whether this design review item record is currently active and valid. Supports soft-delete patterns and historical record management.',
    `item_sequence_number` STRING COMMENT 'Sequential ordering of this item within the design review session. Used to maintain presentation order and facilitate discussion flow.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this design review item record was most recently updated. Supports change tracking and audit requirements.',
    `price_tier` STRING COMMENT 'Market positioning tier for this style based on pricing strategy. Aligns with brand segmentation and customer targeting.. Valid values are `luxury|premium|mid|value|entry`',
    `priority_ranking` STRING COMMENT 'Relative priority of this style within the collection line. Lower numbers indicate higher priority. Used for resource allocation and production sequencing decisions.',
    `product_category` STRING COMMENT 'High-level product classification for this style such as tops, bottoms, outerwear, footwear, accessories. Used for portfolio balance analysis.',
    `requires_new_tooling` BOOLEAN COMMENT 'Indicates whether this style requires investment in new manufacturing tooling, molds, or equipment. Impacts cost and timeline feasibility.',
    `review_notes` STRING COMMENT 'General notes and observations captured during the review discussion for this item. Provides context and rationale for future reference.',
    `reviewer_decision` STRING COMMENT 'Final decision outcome for this style at the review gate. Adopt means approved for production, revise requires design changes, drop means rejected, hold means deferred to future review, pending means decision not yet finalized.. Valid values are `adopt|revise|drop|hold|pending`',
    `revision_comments` STRING COMMENT 'Specific feedback and instructions for design revisions when decision is revise. Details what changes are required before the style can be adopted.',
    `risk_assessment` STRING COMMENT 'Overall risk level associated with adopting this style considering technical, commercial, supply chain, and brand factors.. Valid values are `low|medium|high|critical`',
    `sample_status` STRING COMMENT 'Current status of physical sample development for this style. Tracks progression through Sample Management System (SMS) workflow.. Valid values are `not_started|in_progress|completed|approved|rejected`',
    `silhouette_type` STRING COMMENT 'Design silhouette classification such as fitted, relaxed, oversized, A-line, or other style-specific shape descriptors. Key design attribute for aesthetic evaluation.',
    `sustainability_rating` STRING COMMENT 'Assessment of the styles environmental and social sustainability based on materials, production methods, and supply chain considerations. Aligns with GOTS, BCI, and OEKO-TEX standards.. Valid values are `high|medium|low|not_assessed`',
    `target_launch_date` DATE COMMENT 'Planned market introduction date for this style if adopted. Drives Time and Action (TNA) calendar planning and production scheduling.',
    `target_margin_percentage` DECIMAL(18,2) COMMENT 'Expected gross margin percentage for this style based on estimated cost and pricing. Critical metric for commercial decision-making at review gates.',
    `technical_feasibility_score` STRING COMMENT 'Numeric assessment of how technically feasible this design is to manufacture given current capabilities, materials, and production constraints. Scale typically 1-10.',
    `trend_relevance_score` STRING COMMENT 'Numeric assessment of how well this style captures current or emerging market trends and consumer preferences. Scale typically 1-10.',
    CONSTRAINT pk_review_item PRIMARY KEY(`review_item_id`)
) COMMENT 'Individual style-level decision record within a design review session. Captures the design review reference, style or sketch being reviewed, reviewer decision (adopt, revise, drop, hold), revision comments, priority ranking within the line, commercial feedback from merchandising, and the designer responsible for any revisions. Enables granular tracking of which styles were adopted, revised, or dropped at each review gate.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`design`.`brief` (
    `brief_id` BIGINT COMMENT 'Unique identifier for the design brief record. Primary key.',
    `designer_id` BIGINT COMMENT 'Identifier of the lead designer or design team member assigned to execute this design brief.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created the design brief record.',
    `brief_employee_id` BIGINT COMMENT 'Identifier of the user or stakeholder who approved the design brief for execution.',
    `brief_modified_by_employee_id` BIGINT COMMENT 'Identifier of the user who last modified the design brief record.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Design briefs reference approved collection budgets for design spend authorization and budget consumption tracking. Real process: design budget control and variance reporting by collection.',
    `collection_id` BIGINT COMMENT 'Reference to the parent collection or product line that this design brief supports.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor. Business justification: Design briefs may target specific vendor capabilities (e.g., design collection for Vendor Xs advanced embroidery capacity) - strategic design planning aligning creative direction with manufacturing',
    `parent_brief_id` BIGINT COMMENT 'Self-referencing FK on brief (parent_brief_id)',
    `approval_date` DATE COMMENT 'Date on which the design brief was formally approved and authorized for execution.',
    `brand_alignment_score` DECIMAL(18,2) COMMENT 'Qualitative or quantitative score (0.00 to 5.00) assessing how well the design brief aligns with brand identity and positioning.',
    `brief_code` STRING COMMENT 'Externally-known unique business identifier for the design brief, used for cross-functional reference and communication.. Valid values are `^[A-Z0-9]{6,20}$`',
    `brief_status` STRING COMMENT 'Current lifecycle status of the design brief, tracking its progression from draft through completion. [ENUM-REF-CANDIDATE: draft|issued|in_progress|under_review|completed|cancelled|on_hold — 7 candidates stripped; promote to reference product]',
    `budget_allocated` DECIMAL(18,2) COMMENT 'Total budget allocated for design development activities under this brief, expressed in the companys base currency.',
    `collaboration_notes` STRING COMMENT 'Notes on cross-functional collaboration requirements, stakeholder involvement, or coordination needs for executing the design brief.',
    `commercial_objectives` STRING COMMENT 'Business and commercial goals for the design brief, including revenue targets, market share objectives, or strategic positioning goals.',
    `competitive_benchmarks` STRING COMMENT 'Competitive products, brands, or market references used as benchmarks or inspiration for positioning and differentiation.',
    `completed_date` DATE COMMENT 'Date on which all design work under the brief was completed and delivered.',
    `concept_submission_deadline` DATE COMMENT 'Deadline by which initial design concepts must be submitted for review.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the design brief record was first created in the system.',
    `delivery_milestone_date` DATE COMMENT 'Target date by which the design work under this brief must be completed and delivered.',
    `design_direction` STRING COMMENT 'High-level creative direction and design philosophy for the brief, outlining aesthetic vision, style themes, and creative intent.',
    `design_team_size` STRING COMMENT 'Number of designers or team members allocated to work on this design brief.',
    `distribution_channel_target` STRING COMMENT 'Primary distribution channel or sales channel that the design brief targets (e.g., Direct-to-Consumer, Wholesale, E-Commerce).. Valid values are `retail|wholesale|ecommerce|dtc|omnichannel`',
    `gender_target` STRING COMMENT 'Target gender segment for the design brief.. Valid values are `mens|womens|unisex|kids|youth`',
    `geographic_market_focus` STRING COMMENT 'Target geographic markets or regions for which the design brief is intended (e.g., North America, Europe, Asia-Pacific).',
    `is_confidential` BOOLEAN COMMENT 'Flag indicating whether the design brief contains confidential or proprietary information requiring restricted access.',
    `issued_date` DATE COMMENT 'Date on which the design brief was formally issued to the design team.',
    `issuing_department` STRING COMMENT 'Department or functional area that originated the design brief.. Valid values are `design|merchandising|brand_management|product_development|marketing`',
    `issuing_stakeholder` STRING COMMENT 'Name or role of the stakeholder who issued the design brief (e.g., Design Director, Merchandising Lead, Brand Manager).',
    `key_trend_references` STRING COMMENT 'List or description of key fashion trends, consumer insights, or market movements that inform the design brief.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update or modification to the design brief record.',
    `merchandising_feedback` STRING COMMENT 'Feedback or input from merchandising teams on commercial viability, assortment fit, or market alignment.',
    `priority_level` STRING COMMENT 'Business priority level assigned to the design brief, indicating urgency and resource allocation.. Valid values are `critical|high|medium|low`',
    `rejection_reason` STRING COMMENT 'Explanation or rationale if the design brief was rejected or cancelled, capturing business context for the decision.',
    `sample_delivery_date` DATE COMMENT 'Target date for delivery of physical samples or prototypes developed under this design brief.',
    `season_code` STRING COMMENT 'Season identifier for which this design brief is issued (e.g., SS24 for Spring/Summer 2024, FW24 for Fall/Winter 2024).. Valid values are `^(SS|FW|AW|SP)[0-9]{2}$`',
    `sustainability_requirements` STRING COMMENT 'Sustainability goals, material requirements, or environmental standards that must be met in the design execution (e.g., organic cotton, recycled polyester, GOTS certification).',
    `target_category` STRING COMMENT 'Product category or classification that the design brief targets (e.g., Outerwear, Footwear, Accessories, Activewear).',
    `target_customer_persona` STRING COMMENT 'Description of the target customer archetype or persona that the design brief is intended to serve, including demographic and psychographic characteristics.',
    `target_margin_percent` DECIMAL(18,2) COMMENT 'Target gross margin percentage that products developed under this brief should achieve, used for commercial viability assessment.',
    `target_price_point` DECIMAL(18,2) COMMENT 'Target retail price point or price range for products developed under this design brief, expressed in the companys base currency.',
    `target_volume_units` STRING COMMENT 'Target production or sales volume in units that the design brief aims to support.',
    `title` STRING COMMENT 'Descriptive title of the design brief that summarizes the creative project or initiative.',
    `version_number` STRING COMMENT 'Version number of the design brief, incremented with each revision or update.',
    CONSTRAINT pk_brief PRIMARY KEY(`brief_id`)
) COMMENT 'Master record for a formal design brief issued to the design team for a season, category, or specific project. Captures brief title, issuing stakeholder (design director, merchandising, brand), season, target category, commercial objectives (price point, target margin, volume), design direction, key trend references, competitive benchmarks, delivery milestones, and brief status (draft, issued, in-progress, completed). The design brief is the commercial-to-creative handoff document.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`design`.`calendar` (
    `calendar_id` BIGINT COMMENT 'Unique identifier for the design calendar record. Primary key for the design calendar entity.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Season calendars are tied to approved design budgets for phased spend tracking and milestone-based budget consumption reporting in apparel collection development operations.',
    `employee_id` BIGINT COMMENT 'Reference to the user who created the design calendar record.',
    `designer_id` BIGINT COMMENT 'Reference to the design director who approves and oversees the calendar at the executive level.',
    `calendar_employee_id` BIGINT COMMENT 'Reference to the user who approved the design calendar.',
    `calendar_lead_designer_id` BIGINT COMMENT 'Reference to the lead designer responsible for overseeing the design calendar execution.',
    `calendar_modified_by_employee_id` BIGINT COMMENT 'Reference to the user who last modified the design calendar record.',
    `collection_id` BIGINT COMMENT 'Reference to the collection this design calendar supports (e.g., Womens Sportswear, Mens Luxury).',
    `season_id` BIGINT COMMENT 'Reference to the season this design calendar is associated with (e.g., Spring/Summer 2025, Fall/Winter 2025).',
    `previous_version_calendar_id` BIGINT COMMENT 'Self-referencing FK on calendar (previous_version_calendar_id)',
    `actual_sku_count` STRING COMMENT 'Actual number of SKUs that were developed and approved through this design calendar.',
    `approval_date` DATE COMMENT 'Date when the design calendar was officially approved.',
    `calendar_code` STRING COMMENT 'Unique business identifier code for the design calendar used for external reference and tracking.',
    `calendar_name` STRING COMMENT 'Human-readable name for the design calendar (e.g., SS25 Womens Sportswear Design Calendar).',
    `calendar_status` STRING COMMENT 'Current lifecycle status of the design calendar indicating its operational state.. Valid values are `draft|active|in_progress|completed|on_hold|cancelled`',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of calendar milestones completed (0.00 to 100.00).',
    `concept_kickoff_actual_date` DATE COMMENT 'Actual date when the concept kick-off meeting occurred.',
    `concept_kickoff_planned_date` DATE COMMENT 'Planned date for the initial concept kick-off meeting to launch the design process.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the design calendar record was first created in the system.',
    `critical_path_flag` BOOLEAN COMMENT 'Indicates whether this calendar is on the critical path for the season launch (True=critical, False=non-critical).',
    `delay_days` STRING COMMENT 'Total number of days the calendar is delayed compared to planned milestones. Negative values indicate ahead of schedule.',
    `end_date` DATE COMMENT 'Official end date of the design calendar period when all milestones should be completed.',
    `gender_target` STRING COMMENT 'Target gender demographic for the design calendar (e.g., Mens, Womens, Unisex, Kids).. Valid values are `mens|womens|unisex|kids|infant`',
    `is_active` BOOLEAN COMMENT 'Indicates whether the design calendar is currently active and in use (True=active, False=inactive/archived).',
    `line_review_actual_date` DATE COMMENT 'Actual date when the line review meeting occurred.',
    `line_review_planned_date` DATE COMMENT 'Planned date for the line review meeting to evaluate and select designs for the collection.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the design calendar record was last modified.',
    `mood_board_review_actual_date` DATE COMMENT 'Actual date when the mood board review meeting took place.',
    `mood_board_review_planned_date` DATE COMMENT 'Planned date for mood board presentation and review with stakeholders.',
    `notes` STRING COMMENT 'Free-text notes and comments about the design calendar, including risks, dependencies, and special considerations.',
    `product_category` STRING COMMENT 'Primary product category this design calendar covers (e.g., Apparel, Footwear, Accessories).',
    `proto_sample_request_actual_date` DATE COMMENT 'Actual date when prototype sample requests were submitted.',
    `proto_sample_request_planned_date` DATE COMMENT 'Planned date for requesting prototype samples from manufacturers.',
    `responsible_team` STRING COMMENT 'Name of the design team or department responsible for executing this calendar (e.g., Womens Design Team, Footwear Innovation).',
    `season_year` STRING COMMENT 'The calendar year associated with the season (e.g., 2025 for SS25).',
    `sketch_submission_actual_date` DATE COMMENT 'Actual date when design sketches were submitted.',
    `sketch_submission_planned_date` DATE COMMENT 'Planned date for designers to submit initial design sketches.',
    `start_date` DATE COMMENT 'Official start date of the design calendar period.',
    `target_sku_count` STRING COMMENT 'Target number of SKUs planned to be developed through this design calendar.',
    `tech_pack_handoff_actual_date` DATE COMMENT 'Actual date when tech packs were handed off to product development.',
    `tech_pack_handoff_planned_date` DATE COMMENT 'Planned date for handing off completed technical design packages to product development and sourcing teams.',
    `version` STRING COMMENT 'Version number or identifier for the calendar to track revisions and updates (e.g., v1.0, v2.1, Final).',
    CONSTRAINT pk_calendar PRIMARY KEY(`calendar_id`)
) COMMENT 'Master record for the seasonal design calendar defining the critical path milestones from concept kick-off through design handoff to product development. Captures season, calendar version, key milestone names (concept kick-off, mood board review, sketch submission, line review, tech pack handoff, proto sample request), planned dates, actual dates, responsible team, and calendar status. The design calendar is the operational backbone of the design process.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`design`.`milestone` (
    `milestone_id` BIGINT COMMENT 'Unique identifier for the design milestone record. Primary key for the design milestone entity.',
    `calendar_id` BIGINT COMMENT 'Reference to the parent design calendar that contains this milestone. Links milestone to the seasonal design planning schedule.',
    `collection_id` BIGINT COMMENT 'Reference to the collection this milestone belongs to. Enables tracking of milestones across seasonal collections.',
    `employee_id` BIGINT COMMENT 'Reference to the user who created this milestone record. Supports accountability and audit requirements.',
    `milestone_employee_id` BIGINT COMMENT 'Reference to the individual authorized to approve milestone completion. Typically a design director, merchandiser, or product manager.',
    `milestone_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this milestone record. Supports audit trail and accountability.',
    `org_unit_id` BIGINT COMMENT 'Reference to the design team responsible for this milestone. Enables team-level workload and performance tracking.',
    `predecessor_milestone_id` BIGINT COMMENT 'Reference to the milestone that must be completed before this milestone can begin. Defines dependency relationships in the design critical path.',
    `designer_id` BIGINT COMMENT 'Reference to the lead designer accountable for completing this milestone. Primary owner for milestone deliverables.',
    `actual_completion_date` DATE COMMENT 'Actual date when the milestone was completed and signed off. Null until milestone is marked complete. Used for performance tracking and historical analysis.',
    `actual_deliverable_count` STRING COMMENT 'Actual number of deliverable items completed at milestone closure. Used to measure scope completion and productivity.',
    `actual_effort_hours` DECIMAL(18,2) COMMENT 'Actual number of labor hours spent completing this milestone. Used for productivity analysis and future estimation accuracy.',
    `approval_date` DATE COMMENT 'Date when the milestone deliverable was formally approved. Null until approval is granted.',
    `baseline_date` DATE COMMENT 'Approved baseline date for the milestone established at project kickoff. Serves as the reference point for measuring schedule performance.',
    `completion_status` STRING COMMENT 'Current lifecycle status of the milestone. Tracks progress through the design critical path and identifies at-risk milestones.. Valid values are `pending|in_progress|completed|overdue|cancelled|on_hold`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this milestone record was first created in the system. Supports audit trail and data lineage tracking.',
    `critical_path_flag` BOOLEAN COMMENT 'Indicates whether this milestone is on the critical path for the collection launch. True means any delay directly impacts the final launch date.',
    `delay_days` STRING COMMENT 'Number of calendar days the milestone is delayed compared to the planned date. Negative values indicate early completion. Used for schedule variance reporting.',
    `delay_reason_code` STRING COMMENT 'Standardized code indicating the root cause of milestone delay if overdue. Used for delay pattern analysis and process improvement. [ENUM-REF-CANDIDATE: design_change|material_unavailable|resource_constraint|approval_delay|vendor_delay|technical_issue|scope_change — promote to reference product]',
    `deliverable_count` STRING COMMENT 'Quantitative target for the number of deliverable items expected at this milestone (e.g., 15 designs, 5 mood boards, 3 prototypes).',
    `deliverable_description` STRING COMMENT 'Detailed description of the expected deliverable or output for this milestone (e.g., 20 concept sketches, approved tech pack, final colorway selection).',
    `dependency_type` STRING COMMENT 'Type of scheduling dependency relationship with the predecessor milestone. Defines how the two milestones are linked in the project schedule.. Valid values are `finish_to_start|start_to_start|finish_to_finish|start_to_finish`',
    `estimated_effort_hours` DECIMAL(18,2) COMMENT 'Estimated number of labor hours required to complete this milestone. Used for resource planning and capacity management.',
    `forecast_date` DATE COMMENT 'Current forecasted completion date based on project progress and known constraints. Updated regularly to reflect realistic expectations.',
    `gate_type` STRING COMMENT 'Classification of the milestone as a formal stage-gate checkpoint. Gates require cross-functional approval before proceeding to next phase.. Valid values are `design_gate|technical_gate|commercial_gate|compliance_gate`',
    `is_active` BOOLEAN COMMENT 'Indicates whether this milestone is currently active in the design calendar. False for cancelled or archived milestones.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this milestone record. Enables change tracking and data freshness monitoring.',
    `milestone_category` STRING COMMENT 'Functional category of the milestone indicating which business function owns the checkpoint (creative design, technical development, commercial review, compliance approval).. Valid values are `creative|technical|commercial|compliance`',
    `milestone_code` STRING COMMENT 'Short alphanumeric code identifying the milestone type for system integration and reporting (e.g., MS-CONCEPT-01, MS-SKETCH-02).',
    `milestone_name` STRING COMMENT 'Descriptive name of the design milestone event (e.g., Concept Presentation, First Sketch Review, Final Design Approval).',
    `milestone_type` STRING COMMENT 'Classification of the milestone event type. Categorizes the nature of the design phase checkpoint.. Valid values are `concept|sketch|review|handoff|approval|sampling`',
    `mitigation_plan` STRING COMMENT 'Description of actions planned to mitigate identified risks or recover from delays. Documents contingency strategies.',
    `notes` STRING COMMENT 'Free-text notes capturing important context, decisions, issues, or feedback related to this milestone. Provides audit trail for design decisions.',
    `planned_date` DATE COMMENT 'Originally scheduled target date for milestone completion as defined in the Time and Action (T&A) calendar. Used for baseline planning and variance analysis.',
    `priority_level` STRING COMMENT 'Business priority assigned to this milestone. Guides resource allocation and escalation decisions when conflicts arise.. Valid values are `critical|high|medium|low`',
    `review_meeting_date` DATE COMMENT 'Scheduled date for the formal review meeting associated with this milestone. Used for calendar coordination and stakeholder alignment.',
    `review_outcome` STRING COMMENT 'Result of the milestone review meeting. Determines whether the design can proceed to the next phase or requires rework.. Valid values are `approved|approved_with_changes|rejected|deferred`',
    `rework_required_flag` BOOLEAN COMMENT 'Indicates whether the milestone deliverable requires rework or revision before final approval. True triggers additional design cycles.',
    `risk_level` STRING COMMENT 'Current risk assessment for milestone completion. Considers factors like resource availability, complexity, and dependency risks.. Valid values are `low|medium|high|critical`',
    `season_code` STRING COMMENT 'Code representing the fashion season this milestone belongs to (e.g., SS24, FW24, HOLIDAY24). Aligns milestone to seasonal planning cycles.',
    `stakeholder_list` STRING COMMENT 'Comma-separated list of stakeholder roles or individuals who must participate in or approve this milestone (e.g., Design Director, Merchandiser, Sourcing Manager).',
    CONSTRAINT pk_milestone PRIMARY KEY(`milestone_id`)
) COMMENT 'Individual milestone record within a design calendar, tracking each critical event in the seasonal design critical path. Captures milestone name, milestone type (concept, sketch, review, handoff, approval), planned date, actual completion date, responsible designer or team, completion status (pending, in-progress, completed, overdue), and any delay reason codes. Enables T&A tracking within the design phase and feeds into the broader product development T&A calendar.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`design`.`collaboration` (
    `collaboration_id` BIGINT COMMENT 'Unique identifier for the design collaboration record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created this collaboration record.',
    `collaboration_employee_id` BIGINT COMMENT 'Identifier of the executive or decision-maker who approved the collaboration.',
    `collaboration_merchandising_contact_employee_id` BIGINT COMMENT 'Identifier of the merchandising team member coordinating the commercial aspects of the collaboration.',
    `collaboration_modified_by_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this collaboration record.',
    `collection_id` BIGINT COMMENT 'Reference to the collection that this collaboration is part of or contributes to.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Designer collaboration fees, royalties, and advance payments are allocated to specific design cost centers for collaboration program cost tracking and budget management.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Collaboration royalty payments, flat fees, and advances are posted to specific GL accounts for financial reporting, accrual accounting, and royalty expense tracking in apparel operations.',
    `designer_id` BIGINT COMMENT 'Identifier of the internal lead designer responsible for managing the collaboration project.',
    `related_collaboration_id` BIGINT COMMENT 'Self-referencing FK on collaboration (related_collaboration_id)',
    `actual_launch_date` DATE COMMENT 'The actual date when the collaboration products were launched to market.',
    `advance_payment_amount` DECIMAL(18,2) COMMENT 'The upfront advance payment made to the partner against future royalties, if applicable.',
    `approval_date` DATE COMMENT 'The date when the collaboration was officially approved.',
    `approval_status` STRING COMMENT 'The approval status of the collaboration proposal or contract.. Valid values are `pending|approved|rejected|on_hold`',
    `collaboration_code` STRING COMMENT 'Internal unique code or identifier for the collaboration project used for tracking and reference.',
    `collaboration_name` STRING COMMENT 'The official name or title of the design collaboration project (e.g., Artist X Spring Collection, Celebrity Y Capsule).',
    `collaboration_status` STRING COMMENT 'Current lifecycle status of the collaboration project. [ENUM-REF-CANDIDATE: concept|negotiation|contracted|in_design|in_production|launched|completed|cancelled — 8 candidates stripped; promote to reference product]',
    `collaboration_type` STRING COMMENT 'The category of creative partnership: artist collaboration, guest designer, brand co-branding, celebrity endorsement, influencer co-design, or licensing deal.. Valid values are `artist|designer|brand|celebrity|influencer|licensing`',
    `contract_document_url` STRING COMMENT 'URL or file path to the signed collaboration contract document.',
    `contract_end_date` DATE COMMENT 'The expiration or termination date of the collaboration contract.',
    `contract_start_date` DATE COMMENT 'The effective start date of the collaboration contract.',
    `contracted_deliverables` STRING COMMENT 'Description of the agreed-upon deliverables from the partner (e.g., Design 12 SKUs, Provide artwork for prints, Attend 3 marketing events).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this collaboration record was first created in the system.',
    `design_ownership_terms` STRING COMMENT 'Legal terms defining intellectual property ownership of the designs created through the collaboration (e.g., Joint ownership, Company retains all rights, Partner retains IP).',
    `distribution_channels` STRING COMMENT 'The sales channels through which collaboration products will be distributed (e.g., DTC only, Wholesale + E-commerce, Exclusive retail partners).',
    `estimated_sku_count` STRING COMMENT 'The estimated number of unique SKUs (Stock Keeping Units) to be produced as part of this collaboration.',
    `exclusivity_terms` STRING COMMENT 'Description of any exclusivity clauses (e.g., Partner cannot work with competitors for 12 months, Non-exclusive agreement).',
    `fee_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the collaboration fees and royalties.. Valid values are `^[A-Z]{3}$`',
    `flat_fee_amount` DECIMAL(18,2) COMMENT 'The fixed fee amount paid to the partner for the collaboration, if applicable.',
    `gender_target` STRING COMMENT 'The target gender demographic for the collaboration products.. Valid values are `mens|womens|unisex|kids|all`',
    `geographic_market_focus` STRING COMMENT 'The primary geographic markets or regions targeted for the collaboration (e.g., North America, Global, Asia-Pacific).',
    `ip_rights_structure` STRING COMMENT 'The structure of intellectual property rights granted or licensed through the collaboration.. Valid values are `exclusive|non_exclusive|limited_term|perpetual`',
    `is_confidential` BOOLEAN COMMENT 'Flag indicating whether the collaboration details are subject to confidentiality or non-disclosure agreements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this collaboration record was last updated.',
    `marketing_campaign_code` STRING COMMENT 'Code or identifier of the marketing campaign associated with the collaboration launch.',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'The minimum guaranteed payment to the partner regardless of sales performance, if applicable.',
    `notes` STRING COMMENT 'Additional notes, comments, or context about the collaboration project.',
    `partner_legal_entity` STRING COMMENT 'The legal entity name of the partner organization or individual for contractual purposes.',
    `partner_name` STRING COMMENT 'The name of the external creative partner, artist, designer, brand, celebrity, or influencer involved in the collaboration.',
    `product_category` STRING COMMENT 'The primary product category focus of the collaboration (e.g., Footwear, Apparel, Accessories, Outerwear).',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'The percentage rate of sales revenue paid as royalty to the partner, if applicable.',
    `royalty_structure` STRING COMMENT 'The type of royalty or compensation structure agreed upon (percentage of sales, flat fee, hybrid model, or no royalty).. Valid values are `percentage_of_sales|flat_fee|hybrid|none`',
    `season_code` STRING COMMENT 'The season identifier for which this collaboration is planned (e.g., SS24, FW24, Holiday23).',
    `season_year` STRING COMMENT 'The calendar year associated with the collaboration season.',
    `sustainability_focus` STRING COMMENT 'Description of any sustainability or ethical sourcing commitments specific to this collaboration.',
    `target_launch_date` DATE COMMENT 'The planned market launch date for the collaboration products.',
    CONSTRAINT pk_collaboration PRIMARY KEY(`collaboration_id`)
) COMMENT 'Transactional record capturing a design collaboration event or external creative partnership — e.g., a guest designer collaboration, artist licensing deal, brand collaboration (co-branding), or influencer co-design project. Captures collaboration name, partner name, collaboration type (artist, designer, brand, celebrity), season, contracted deliverables, design ownership terms, royalty or fee structure, approval status, and associated styles. Distinct from supplier agreements — this is a creative IP partnership.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`design`.`embellishment` (
    `embellishment_id` BIGINT COMMENT 'Unique identifier for the embellishment design record. Primary key.',
    `collection_id` BIGINT COMMENT 'Reference to the design collection or product line for which this embellishment was originally created, enabling traceability to merchandising plans.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Embellishment development costs including sampling, digitization, and vendor setup are allocated to design cost centers for product development cost tracking and budget management.',
    `designer_id` BIGINT COMMENT 'Identifier of the designer or design team member who created the embellishment design, used for attribution and workflow management.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved the embellishment design for production use, used for audit trail and accountability.',
    `embellishment_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified the embellishment design record, used for audit trail and change management.',
    `vendor_id` BIGINT COMMENT 'FK to supplier.vendor',
    `embellishment_vendor_id` BIGINT COMMENT 'Reference to the external supplier or vendor providing the embellishment if origin_type is supplier. Used for procurement and vendor management.',
    `supplier_factory_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_factory. Business justification: Embellishments may be factory-specific (e.g., Factory As beading capability) - technical feasibility assessment where designers specify which factory can execute specialized embellishment technique',
    `derived_from_embellishment_id` BIGINT COMMENT 'Self-referencing FK on embellishment (derived_from_embellishment_id)',
    `approval_date` DATE COMMENT 'Date when the embellishment design was approved for production use, following the format yyyy-MM-dd.',
    `approval_status` STRING COMMENT 'Current approval status of the embellishment design within the Product Lifecycle Management (PLM) workflow, indicating readiness for production use.. Valid values are `draft|pending_review|approved|rejected|revision_required|archived`',
    `care_instructions` STRING COMMENT 'Special care or handling instructions for garments with this embellishment, used for labeling compliance and customer communication per Federal Trade Commission (FTC) requirements.',
    `color_specification` STRING COMMENT 'Detailed color specification for the embellishment, including Pantone codes, thread colors, or ink formulations. May include multiple colors for multi-color designs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the embellishment design record was first created in the system, following the format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit cost, enabling multi-currency cost tracking for global sourcing.. Valid values are `^[A-Z]{3}$`',
    `digital_file_path` STRING COMMENT 'File system path or cloud storage location for the digital design file of the embellishment (e.g., embroidery DST file, vector artwork, print-ready PDF).',
    `embellishment_code` STRING COMMENT 'Unique business identifier code for the embellishment design, used across Product Lifecycle Management (PLM) and Enterprise Resource Planning (ERP) systems for cross-referencing and sourcing.. Valid values are `^[A-Z0-9]{6,12}$`',
    `embellishment_name` STRING COMMENT 'Descriptive name of the embellishment design, used for identification in design briefs, tech packs, and production orders.',
    `embellishment_type` STRING COMMENT 'Classification of the embellishment technique or method applied to the garment or accessory. [ENUM-REF-CANDIDATE: embroidery|applique|beading|screen_print|heat_transfer|woven_label|sequin|rhinestone|patch|foil_print|digital_print — 11 candidates stripped; promote to reference product]',
    `file_format` STRING COMMENT 'Digital file format of the embellishment design file, such as DST for embroidery, AI/EPS for vector graphics, or PDF for print-ready artwork. [ENUM-REF-CANDIDATE: DST|PES|AI|EPS|PDF|PNG|SVG|JPG — 8 candidates stripped; promote to reference product]',
    `height_cm` DECIMAL(18,2) COMMENT 'Height dimension of the embellishment design in centimeters, used for sizing specifications in tech packs and Bill of Materials (BOM).',
    `ip_ownership` STRING COMMENT 'Defines the intellectual property rights ownership for the embellishment design, critical for legal compliance and licensing agreements.. Valid values are `company_owned|licensed|supplier_owned|shared|public_domain`',
    `is_active` BOOLEAN COMMENT 'Indicates whether the embellishment design is currently active and available for use in new product development, or has been retired or archived.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the embellishment design record was last updated or modified, following the format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `lead_time_days` STRING COMMENT 'Number of days required to produce or procure the embellishment from order placement to delivery, critical for Time and Action (TNA) calendar planning.',
    `license_agreement_reference` STRING COMMENT 'Reference number or identifier for the licensing agreement if the embellishment design is licensed from a third party, used for legal and financial tracking.',
    `minimum_order_quantity` STRING COMMENT 'Minimum Order Quantity (MOQ) required by the supplier or production facility for this embellishment, used for procurement planning and inventory management.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the embellishment design, production considerations, or usage guidelines.',
    `origin_type` STRING COMMENT 'Indicates whether the embellishment design was created in-house by the design team, sourced from an external supplier, licensed from a third party, or custom-developed for a specific collection.. Valid values are `in_house|supplier|licensed|custom`',
    `placement_position` STRING COMMENT 'Designated location on the garment or accessory where the embellishment is applied, critical for tech pack specifications and production instructions. [ENUM-REF-CANDIDATE: chest_left|chest_right|chest_center|back_upper|back_lower|sleeve_left|sleeve_right|hem|collar|pocket|cuff|hood|side_panel|full_front|full_back — 15 candidates stripped; promote to reference product]',
    `reusable_flag` BOOLEAN COMMENT 'Indicates whether the embellishment design is a reusable asset that can be applied across multiple styles and collections, or is specific to a single product.',
    `season_code` STRING COMMENT 'Season identifier for which the embellishment design was created, following industry convention (e.g., SS24 for Spring/Summer 2024, FW24 for Fall/Winter 2024).. Valid values are `^(SS|FW|AW|SP)[0-9]{2}$`',
    `stitch_count` STRING COMMENT 'Total number of stitches in an embroidered embellishment design, used for production time estimation and Cost of Goods Sold (COGS) calculation.',
    `sustainability_certification` STRING COMMENT 'Sustainability or environmental certifications applicable to the embellishment materials or production process, such as OEKO-TEX, GOTS, or recycled content certifications.',
    `tags` STRING COMMENT 'Comma-separated list of descriptive tags or keywords for the embellishment design, used for search, filtering, and categorization in Product Lifecycle Management (PLM) systems.',
    `technique` STRING COMMENT 'Detailed description of the specific production technique or process used to create the embellishment, including stitch type for embroidery, application method for appliqués, or printing technology for screen prints.',
    `thread_count` STRING COMMENT 'Number of thread colors or individual threads used in embroidery or stitched embellishments, relevant for costing and production planning.',
    `thumbnail_url` STRING COMMENT 'Uniform Resource Locator (URL) or path to a thumbnail image of the embellishment design, used for visual reference in Product Lifecycle Management (PLM) systems and merchandising tools.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit to produce or procure the embellishment, used for Cost of Goods Sold (COGS) calculation and pricing strategy. Expressed in the companys base currency.',
    `usage_count` STRING COMMENT 'Number of distinct Stock Keeping Units (SKUs) or styles that currently use this embellishment design, used for asset utilization analysis.',
    `width_cm` DECIMAL(18,2) COMMENT 'Width dimension of the embellishment design in centimeters, used for sizing specifications in tech packs and Bill of Materials (BOM).',
    CONSTRAINT pk_embellishment PRIMARY KEY(`embellishment_id`)
) COMMENT 'Master record for a decorative embellishment design used on apparel or accessories — including embroidery motifs, appliqués, beading patterns, screen print placements, heat transfer designs, and woven labels. Captures embellishment name, type, technique, placement position (chest, back, sleeve, hem), size dimensions, color specification, supplier or in-house origin, IP ownership, and approval status. Embellishments are reusable design assets applied across multiple styles.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`design`.`color_palette` (
    `color_palette_id` BIGINT COMMENT 'Unique identifier for the color palette record. Primary key.',
    `designer_id` BIGINT COMMENT 'Reference to the lead designer responsible for creating and curating this color palette.',
    `collection_id` BIGINT COMMENT 'Reference to the parent collection that this color palette supports. Links palette to broader collection planning and merchandising strategy.',
    `employee_id` BIGINT COMMENT 'Reference to the user (typically Creative Director or Merchandising Lead) who approved this color palette for production use.',
    `tertiary_color_modified_by_employee_id` BIGINT COMMENT 'Reference to the user who last modified this color palette record.',
    `derived_from_color_palette_id` BIGINT COMMENT 'Self-referencing FK on color_palette (derived_from_color_palette_id)',
    `approval_date` DATE COMMENT 'Date when the color palette received final approval. Used for tracking design-to-production timelines and governance compliance.',
    `approval_status` STRING COMMENT 'Current approval state of the color palette in the design governance workflow: draft (in development), submitted (under review), approved (ready for production), rejected (not approved), archived (historical record).. Valid values are `draft|submitted|approved|rejected|archived`',
    `collaboration_notes` STRING COMMENT 'Free-text notes capturing cross-functional feedback, design rationale, or collaboration comments from merchandising, marketing, and sourcing teams.',
    `color_story_narrative` STRING COMMENT 'Descriptive narrative explaining the inspiration, mood, and strategic intent behind the color palette. Communicates the emotional and aesthetic direction to design, merchandising, and marketing teams.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the color palette record was first created in the system. Used for audit trail and design timeline analysis.',
    `design_team` STRING COMMENT 'Name or identifier of the design team or studio that developed this palette (e.g., Womens Apparel Design, Footwear Innovation Lab).',
    `digital_file_path` STRING COMMENT 'File system path or cloud storage URI where the authoritative digital palette file is stored (e.g., Adobe Swatch Exchange .ase file, Pantone Color Manager file).',
    `gender_target` STRING COMMENT 'Gender category this palette is designed for: mens, womens, unisex, kids, or all genders.. Valid values are `mens|womens|unisex|kids|all`',
    `geographic_market_focus` STRING COMMENT 'Primary geographic markets or regions this palette is tailored for (e.g., North America, EMEA, APAC). Reflects regional color preferences and cultural sensitivities.',
    `hex_codes_list` STRING COMMENT 'Comma-separated list of all hexadecimal color codes in the palette. Used for digital design, e-commerce product imagery, and web applications.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this palette is currently active and available for use in new designs. False if archived or superseded.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the color palette record. Tracks design iteration and change activity.',
    `ncs_codes_list` STRING COMMENT 'Comma-separated list of Natural Color System codes for colors in the palette. Used in European markets and for architectural/interior design applications.',
    `number_of_colors` STRING COMMENT 'Total count of distinct colors included in this palette. Typically ranges from 5 to 30 colors depending on palette type and collection scope.',
    `palette_category` STRING COMMENT 'Product category scope for which this palette is intended: apparel, footwear, accessories, or all categories.. Valid values are `apparel|footwear|accessories|all`',
    `palette_code` STRING COMMENT 'Unique alphanumeric code assigned to the color palette for system identification and cross-referencing in PLM, ERP, and merchandising systems.. Valid values are `^[A-Z0-9]{6,12}$`',
    `palette_name` STRING COMMENT 'Business name of the color palette (e.g., Spring Bloom 2024, Urban Edge Neutrals). Human-readable identifier used by design and merchandising teams.',
    `palette_type` STRING COMMENT 'Classification of the palettes strategic role within the collection: core (foundational colors), accent (highlight colors), neutral (base colors), trend (fashion-forward colors), seasonal (time-bound colors), capsule (limited edition).. Valid values are `core|accent|neutral|trend|seasonal|capsule`',
    `pantone_codes_list` STRING COMMENT 'Comma-separated list of all Pantone codes included in the palette. Authoritative reference for material sourcing and supplier communication.',
    `primary_color_name` STRING COMMENT 'Business-friendly name of the primary or hero color in the palette (e.g., Sunset Coral, Midnight Navy). Used in marketing and merchandising communications.',
    `primary_hex_code` STRING COMMENT 'Hexadecimal color code for the primary color, used in digital design, e-commerce, and web applications (e.g., #FF6347).. Valid values are `^#[0-9A-Fa-f]{6}$`',
    `primary_pantone_code` STRING COMMENT 'Pantone Matching System (PMS) code for the primary color, ensuring consistent color reproduction across materials and suppliers (e.g., 18-1664 TPX).. Valid values are `^[0-9]{2,4}[A-Z]{0,3}$`',
    `primary_rgb_code` STRING COMMENT 'RGB color code for the primary color, used in digital rendering and screen-based applications (e.g., rgb(255, 99, 71)).. Valid values are `^rgb([0-9]{1,3}, [0-9]{1,3}, [0-9]{1,3})$`',
    `ral_codes_list` STRING COMMENT 'Comma-separated list of RAL color standard codes for colors in the palette. Used for industrial and hardware applications (e.g., zippers, buttons, trims).',
    `rejection_reason` STRING COMMENT 'Free-text explanation for why the palette was rejected, if applicable. Captures feedback for design iteration and learning.',
    `season_code` STRING COMMENT 'Season identifier for which this palette is designed (e.g., SS24 for Spring/Summer 2024, FW24 for Fall/Winter 2024). Follows industry-standard season coding.. Valid values are `^(SS|FW|AW|SP)[0-9]{2}$`',
    `season_year` STRING COMMENT 'Calendar year associated with the season (e.g., 2024, 2025). Used for multi-year trend analysis and archival.',
    `secondary_color_names` STRING COMMENT 'Comma-separated list of business-friendly names for secondary colors in the palette. Supports merchandising and marketing communication.',
    `sustainability_focus` BOOLEAN COMMENT 'Indicates whether this palette prioritizes sustainable or eco-friendly dyeing processes and materials. True if sustainability is a core design principle.',
    `sustainability_notes` STRING COMMENT 'Free-text notes describing sustainability considerations, such as low-impact dyes, natural pigments, or water-saving processes associated with this palette.',
    `target_customer_segment` STRING COMMENT 'Primary customer demographic or psychographic segment this palette is designed for (e.g., Gen Z Urban, Active Lifestyle, Luxury Consumer).',
    `thumbnail_url` STRING COMMENT 'URL to a visual thumbnail or preview image of the color palette, used in PLM systems and design collaboration tools.',
    `trend_alignment_tags` STRING COMMENT 'Comma-separated tags linking this palette to macro trends, cultural movements, or trend forecasting themes (e.g., sustainability, retro revival, digital nomad).',
    `usage_count` STRING COMMENT 'Number of products, SKUs, or designs that reference this color palette. Indicates palette adoption and business impact.',
    `version_number` STRING COMMENT 'Version number of the palette, incremented with each revision. Supports design iteration tracking and change management.',
    CONSTRAINT pk_color_palette PRIMARY KEY(`color_palette_id`)
) COMMENT 'Master record for a seasonal or thematic color palette defined by the design team. Captures palette name, season, palette type (core palette, accent palette, neutral palette, trend palette), number of colors, Pantone/NCS/RAL codes for each color, color names, color story narrative, and approval status. Color palettes are the authoritative color direction documents that govern colorway development, print design, and material sourcing across a season.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`design`.`handoff` (
    `handoff_id` BIGINT COMMENT 'Unique identifier for the design handoff transaction. Primary key for the design handoff record.',
    `concept_id` BIGINT COMMENT 'Reference to the design concept that is being handed off. Links to the originating concept record.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved the design handoff. Typically a product development manager or technical design lead.',
    `handoff_employee_id` BIGINT COMMENT 'Identifier of the specific user or team lead who acknowledged receipt of the design handoff package.',
    `handoff_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified the design handoff record. Provides accountability for changes.',
    `designer_id` BIGINT COMMENT 'Identifier of the designer who submitted the design handoff package. Responsible party from the design team.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor. Business justification: Design handoffs specify target vendor for tech pack execution - production planning workflow where design team designates which vendor will manufacture the style, enabling vendor-specific technical sp',
    `reissued_handoff_id` BIGINT COMMENT 'Self-referencing FK on handoff (reissued_handoff_id)',
    `acknowledgment_date` DATE COMMENT 'Date when the receiving team acknowledged receipt of the design handoff package. Marks the start of the product development phase.',
    `approval_date` DATE COMMENT 'Date when the design handoff was formally approved by the receiving team. Indicates readiness to proceed to sourcing and production.',
    `bom_draft_included` BOOLEAN COMMENT 'Indicates whether a draft Bill of Materials listing all components, fabrics, trims, and hardware is included in the handoff.',
    `bom_draft_version` STRING COMMENT 'Version identifier for the draft BOM included in the handoff (e.g., draft_v1, draft_v2). Tracks BOM iterations during design phase.. Valid values are `^draft_v[0-9]{1,2}$`',
    `cad_file_format` STRING COMMENT 'File format of the CAD files included (e.g., AI for Adobe Illustrator, CLO for CLO3D, ZPRJ for Browzwear). Indicates the software compatibility. [ENUM-REF-CANDIDATE: AI|PDF|DXF|CLO|ZPRJ|OBJ|FBX|none — 8 candidates stripped; promote to reference product]',
    `cad_files_included` BOOLEAN COMMENT 'Indicates whether CAD design files (e.g., Adobe Illustrator, CLO3D, Browzwear) are included in the handoff package.',
    `collaboration_platform` STRING COMMENT 'Digital platform or tool used to facilitate the design handoff and collaboration between teams (e.g., Centric PLM, Infor PLM, Microsoft Teams).. Valid values are `centric_plm|infor_plm|sharepoint|teams|email|other`',
    `collection_name` STRING COMMENT 'Name of the collection to which this design belongs. Groups related styles under a cohesive theme or brand story.',
    `colorway_count` STRING COMMENT 'Number of colorway variations included in the design handoff. Each colorway represents a different color combination for the same style.',
    `colorway_specs_included` BOOLEAN COMMENT 'Indicates whether detailed colorway specifications (Pantone codes, fabric swatches, trim colors) are included in the handoff.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the design handoff record was first created in the system. Audit trail for record creation.',
    `feedback_notes` STRING COMMENT 'General feedback and comments from the receiving team regarding the design handoff. May include suggestions for improvement or clarification requests.',
    `gender_target` STRING COMMENT 'Target gender segment for the design. Determines merchandising placement and marketing strategy.. Valid values are `mens|womens|unisex|kids_boys|kids_girls`',
    `handoff_date` DATE COMMENT 'The date when the design package was formally handed off from the design team to the receiving team. Critical gate event marking the end of the design phase.',
    `handoff_number` STRING COMMENT 'Business-facing unique identifier for the design handoff, typically formatted as DH-NNNNNN. Used for tracking and reference in cross-functional communications.. Valid values are `^DH-[0-9]{6,10}$`',
    `handoff_status` STRING COMMENT 'Current lifecycle status of the design handoff. Tracks the progression from submission through acknowledgment and approval or rejection.. Valid values are `pending|submitted|acknowledged|approved|rejected|on_hold`',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the design handoff contains confidential or proprietary information requiring restricted access. Used for high-profile collaborations or innovative designs.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the design handoff record was last updated. Tracks the most recent change to the record.',
    `material_library_references` STRING COMMENT 'Comma-separated list of material codes or references from the PLM material library that are specified in the design. Links to approved fabric and trim options.',
    `outstanding_design_items` STRING COMMENT 'List of any outstanding design items, open questions, or pending decisions that need to be resolved by the receiving team. Tracks incomplete elements at handoff.',
    `package_url` STRING COMMENT 'URL or file path to the complete design handoff package stored in the PLM system or shared drive. Provides access to all handoff materials.. Valid values are `^https?://.*$`',
    `price_tier` STRING COMMENT 'Price tier classification for the design (entry, core, premium, luxury). Aligns with brand positioning and target customer segment.. Valid values are `entry|core|premium|luxury`',
    `print_files_included` BOOLEAN COMMENT 'Indicates whether print and pattern artwork files are included in the handoff package. Essential for styles with custom prints or graphics.',
    `priority_level` STRING COMMENT 'Priority classification for the design handoff. Critical and high priority items receive expedited processing by the receiving team.. Valid values are `critical|high|medium|low`',
    `product_category` STRING COMMENT 'High-level product category for the design (e.g., tops, bottoms, dresses, outerwear). Used for merchandising and assortment planning. [ENUM-REF-CANDIDATE: tops|bottoms|dresses|outerwear|activewear|footwear|accessories|swimwear — 8 candidates stripped; promote to reference product]',
    `receiving_team` STRING COMMENT 'The functional team receiving the design handoff package. Typically product development, sourcing, or technical design team.. Valid values are `product_development|sourcing|technical_design|merchandising|production`',
    `rejection_date` DATE COMMENT 'Date when the design handoff was rejected by the receiving team. Triggers rework by the design team.',
    `rejection_reason` STRING COMMENT 'Detailed explanation of why the design handoff was rejected. Provides feedback to the design team for revisions.',
    `season_code` STRING COMMENT 'Season identifier for the design handoff (e.g., SS24 for Spring/Summer 2024, FW24 for Fall/Winter 2024). Indicates the target selling season.. Valid values are `^(SS|FW|SP|FA)[0-9]{2}$`',
    `silhouette_description` STRING COMMENT 'Description of the design silhouette and fit (e.g., slim fit, relaxed, oversized, A-line). Key design characteristic communicated to product development.',
    `style_code` STRING COMMENT 'The style or sketch reference code for the design being handed off. Unique identifier for the style within the collection.. Valid values are `^[A-Z0-9]{6,15}$`',
    `sustainability_notes` STRING COMMENT 'Notes on sustainability considerations for the design, including use of organic materials, recycled content, or sustainable manufacturing processes. Supports compliance with GOTS, BCI, and OEKO-TEX standards.',
    `target_launch_date` DATE COMMENT 'Target date for the style to be available for sale. Drives the Time and Action calendar for product development and production.',
    `target_price_point` DECIMAL(18,2) COMMENT 'Target retail price point for the design as specified by the design team. Used by product development and sourcing to guide costing decisions.',
    `tech_pack_included` BOOLEAN COMMENT 'Indicates whether a technical specification package (tech pack) is included in the handoff. Tech packs contain detailed construction, measurement, and material specifications.',
    `tech_pack_version` STRING COMMENT 'Version number of the tech pack included in the handoff (e.g., v1.0, v2.3). Tracks iterations and revisions.. Valid values are `^v[0-9]{1,2}.[0-9]{1,2}$`',
    CONSTRAINT pk_handoff PRIMARY KEY(`handoff_id`)
) COMMENT 'Transactional record capturing the formal handoff of a completed design package from the design team to the product development or sourcing team. Captures handoff date, style or sketch reference, handoff package contents (tech pack, CAD files, print files, colorway specs, BOM draft), receiving team, handoff status (pending, submitted, acknowledged, rejected with feedback), and any outstanding design items. The design handoff is the critical gate event marking the end of the design phase.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`design`.`revision` (
    `revision_id` BIGINT COMMENT 'Unique identifier for the design revision record. Primary key.',
    `designer_id` BIGINT COMMENT 'Identifier of the designer assigned to execute the revision. Tracks workload distribution and designer accountability.',
    `collection_id` BIGINT COMMENT 'Reference to the product collection this design is part of. Enables analysis of revision patterns by collection.',
    `fit_session_id` BIGINT COMMENT 'Reference to the fit session that generated feedback requiring this revision. Tracks revisions driven by fit and construction issues.',
    `review_id` BIGINT COMMENT 'Reference to the design review session where this revision was discussed or decided. Links revision to formal review process.',
    `employee_id` BIGINT COMMENT 'Identifier of the person responsible for reviewing and approving the completed revision. Typically a senior designer or design director.',
    `revision_employee_id` BIGINT COMMENT 'Identifier of the person or role who requested the design revision. May be a merchandiser, product manager, design director, or technical designer.',
    `sketch_id` BIGINT COMMENT 'Reference to the parent design being revised. Links to the original design concept or CAD file that is undergoing revision.',
    `prior_revision_id` BIGINT COMMENT 'Self-referencing FK on revision (prior_revision_id)',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the revision was formally approved by the reviewer. Marks the completion of the revision lifecycle.',
    `collaboration_notes` STRING COMMENT 'Free-text field for team collaboration and communication during the revision process. Captures discussions, decisions, and context.',
    `colorway_change_description` STRING COMMENT 'Detailed description of color palette or colorway modifications. Applicable when revision_type is colorway_change.',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the designer completed the revision work and submitted for review. Marks the end of active design work.',
    `construction_change_description` STRING COMMENT 'Detailed description of changes to garment construction, seaming, or assembly methods. Applicable when revision_type is construction_change.',
    `cost_impact_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated cost impact. Examples: USD, EUR, GBP.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this revision record was first created in the system. Audit trail for data lineage.',
    `cycle_time_hours` DECIMAL(18,2) COMMENT 'Total elapsed time in hours from revision request to approval. Key performance indicator for design process efficiency.',
    `due_date` DATE COMMENT 'Target completion date for the revision. Used to manage design calendar and ensure revisions do not delay collection launch.',
    `estimated_cost_impact` DECIMAL(18,2) COMMENT 'Estimated change in unit cost resulting from this revision. Positive values indicate cost increase, negative values indicate cost reduction.',
    `instructions` STRING COMMENT 'Detailed description of the changes requested. Provides specific guidance to the designer on what modifications are needed and why.',
    `is_final_revision` BOOLEAN COMMENT 'Flag indicating whether this is the final approved revision before the design moves to technical design or sampling. True when design is locked for production.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this revision record was last updated. Audit trail for data lineage and change tracking.',
    `original_cad_file_path` STRING COMMENT 'Full file system path or cloud storage location of the original CAD design file. Enables designers to access the baseline version for comparison.',
    `print_pattern_change_description` STRING COMMENT 'Detailed description of changes to print designs or patterns. Applicable when revision_type is print_change.',
    `priority` STRING COMMENT 'Urgency level assigned to this revision. Critical revisions may be required to meet launch deadlines or address safety/compliance issues.. Valid values are `critical|high|medium|low`',
    `product_category` STRING COMMENT 'High-level product classification for the design being revised. Examples: tops, bottoms, outerwear, footwear, accessories.',
    `rejection_reason` STRING COMMENT 'Explanation provided when a revision is rejected. Captures feedback for the designer to address in a subsequent iteration.',
    `request_date` DATE COMMENT 'Date when the revision was formally requested. Marks the start of the revision lifecycle.',
    `requestor_role` STRING COMMENT 'Functional role of the person requesting the revision. Helps analyze which stakeholder groups drive the most design changes.. Valid values are `design_director|merchandiser|product_manager|technical_designer|fit_technician|sourcing_manager`',
    `revised_cad_file_path` STRING COMMENT 'Full file system path or cloud storage location of the revised CAD design file. Captures the output of the revision work.',
    `revision_number` STRING COMMENT 'Sequential revision number for this design, starting from 1. Increments with each revision cycle to maintain version history from concept through final approval.',
    `revision_status` STRING COMMENT 'Current lifecycle state of the revision request. Tracks progression from initial request through completion or cancellation.. Valid values are `pending|in_progress|under_review|approved|rejected|cancelled`',
    `revision_type` STRING COMMENT 'Category of design change being requested. Classifies the nature of the revision to track which design elements are most frequently modified.. Valid values are `silhouette_change|colorway_change|construction_change|print_change|trim_change|fabric_change`',
    `season_code` STRING COMMENT 'Season identifier for the collection this design belongs to. Examples: SS24 (Spring/Summer 2024), FW24 (Fall/Winter 2024).',
    `silhouette_change_description` STRING COMMENT 'Detailed description of changes to the garment silhouette or shape. Applicable when revision_type is silhouette_change.',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the designer began working on the revision. Enables cycle time analysis.',
    `sustainability_impact` STRING COMMENT 'Assessment of whether the revision improves, maintains, or reduces the sustainability profile of the design. Tracks alignment with environmental goals.. Valid values are `positive|neutral|negative|not_assessed`',
    `technical_feasibility_assessment` STRING COMMENT 'Evaluation of whether the requested revision can be manufactured with current capabilities and supplier base. Identifies potential production risks.. Valid values are `feasible|challenging|not_feasible|requires_testing`',
    `trigger` STRING COMMENT 'Business event or decision that initiated this revision request. Captures whether the change was driven by design review feedback, fit session results, commercial strategy shift, or other factors.. Valid values are `design_review|fit_session|commercial_direction|cost_reduction|technical_feasibility|sustainability_requirement`',
    `trim_change_description` STRING COMMENT 'Detailed description of changes to trims, buttons, zippers, labels, or other embellishments. Applicable when revision_type is trim_change.',
    CONSTRAINT pk_revision PRIMARY KEY(`revision_id`)
) COMMENT 'Transactional record of a design revision event triggered by a design review decision, fit session feedback, or commercial direction change. Captures the original sketch or CAD file reference, revision number, revision type (silhouette change, colorway change, construction change, print change, trim change), revision instructions, requestor, assigned designer, revision due date, and revision completion status. Maintains the full revision history of each design from concept through final approval.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` (
    `fabric_swatch_id` BIGINT COMMENT 'Unique identifier for the fabric swatch record. Primary key for the fabric swatch entity.',
    `designer_id` BIGINT COMMENT 'Identifier of the designer responsible for evaluating and making decisions about the fabric swatch.',
    `concept_id` BIGINT COMMENT 'Identifier linking the fabric swatch to a specific design concept or theme within the collection planning process.',
    `higg_index_assessment_id` BIGINT COMMENT 'Foreign key linking to sustainability.higg_index_assessment. Business justification: Fabric mills with Higg FEM scores provide swatches; designers consider facility environmental performance. Real process: swatch cards display Higg scores; designers prioritize high-scoring mills for s',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created the fabric swatch record in the system.',
    `supplier_esg_assessment_id` BIGINT COMMENT 'Foreign key linking to sustainability.supplier_esg_assessment. Business justification: Fabric swatches are sourced from ESG-assessed suppliers. Real process: swatch evaluation includes supplier sustainability scoring (Higg FEM, social audits); designers consider facility sustainability ',
    `supplier_mill_vendor_id` BIGINT COMMENT 'Identifier of the textile mill or fabric supplier that provided the swatch. Links to the supplier master data for sourcing and procurement workflows.',
    `sustainable_material_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainable_material. Business justification: Fabric swatches represent physical samples of sustainable materials in design libraries. Real process: swatch cards display sustainability certifications (GOTS, GRS, Oeko-Tex) and designers select swa',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor. Business justification: Fabric swatches are submitted by vendors/mills for designer evaluation and adoption decisions - core material sourcing workflow linking vendor submissions to design library. Replaces denormalized supp',
    `alternate_fabric_swatch_id` BIGINT COMMENT 'Self-referencing FK on fabric_swatch (alternate_fabric_swatch_id)',
    `adoption_decision` STRING COMMENT 'Final decision status regarding the fabric swatchs inclusion in the collection. Selected indicates approval for production, shortlisted indicates further consideration, rejected indicates exclusion, and pending indicates evaluation in progress.. Valid values are `selected|shortlisted|rejected|pending`',
    `care_instructions` STRING COMMENT 'Recommended care and maintenance instructions for the fabric, including washing, drying, ironing, and dry cleaning guidance. Required for garment labeling compliance.',
    `collection_name` STRING COMMENT 'Name of the design collection or product line for which the fabric swatch is being considered.',
    `color_code` STRING COMMENT 'Standardized color reference code, typically Pantone TPX/TCX code or supplier-specific color code, used for precise color matching and communication.',
    `color_hex_value` DECIMAL(18,2) COMMENT 'Hexadecimal color code representing the digital approximation of the fabric color for use in digital design tools and CAD systems.',
    `color_name` STRING COMMENT 'Descriptive name of the fabric color as provided by the supplier or assigned by the design team, such as Navy Heather or Sunset Orange.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the fabric swatch record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated cost, such as USD, EUR, or GBP.. Valid values are `^[A-Z]{3}$`',
    `designer_evaluation_notes` STRING COMMENT 'Detailed notes and observations recorded by the designer during swatch evaluation, including aesthetic assessment, performance considerations, and potential applications.',
    `digital_file_path` STRING COMMENT 'File system path or cloud storage URL where the digital representation of the fabric swatch is stored, including high-resolution images or 3D texture files.',
    `estimated_cost_per_meter` DECIMAL(18,2) COMMENT 'Estimated cost of the fabric per linear meter as quoted by the supplier, used for preliminary costing and feasibility analysis during design phase.',
    `fabric_finish` STRING COMMENT 'Surface treatment or finishing process applied to the fabric, such as enzyme wash, stone wash, coating, lamination, or water repellent finish.',
    `fabric_type` STRING COMMENT 'Classification of the fabric construction method. Determines the structural characteristics and performance attributes of the material.. Valid values are `woven|knit|denim|jersey|technical|non-woven`',
    `fabric_weight_gsm` DECIMAL(18,2) COMMENT 'Weight of the fabric measured in grams per square meter. Critical specification for determining fabric hand, drape, and suitability for specific garment types.',
    `fabric_width_cm` DECIMAL(18,2) COMMENT 'Width of the fabric in centimeters, measured from selvage to selvage. Important specification for pattern making and material yield calculations.',
    `fiber_composition` STRING COMMENT 'Detailed breakdown of fiber content by percentage, such as 60% Cotton, 40% Polyester. Required for compliance with FTC Textile Fiber Products Identification Act.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the fabric swatch record was last updated or modified.',
    `lead_time_days` STRING COMMENT 'Number of days required from order placement to fabric delivery, as specified by the supplier. Used for production timeline planning.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity of fabric that must be ordered from the supplier, typically measured in meters or yards. Critical constraint for production planning and feasibility.',
    `moq_unit_of_measure` STRING COMMENT 'Unit of measure for the minimum order quantity, such as meters, yards, or kilograms.. Valid values are `meters|yards|kilograms`',
    `performance_attributes` STRING COMMENT 'Special performance characteristics of the fabric, such as moisture-wicking, stretch recovery, UV protection, antimicrobial, or water resistance. Comma-separated list of attributes.',
    `physical_swatch_location` STRING COMMENT 'Storage location or bin reference for the physical fabric swatch within the design studio or material library.',
    `product_category_suitability` STRING COMMENT 'Types of garments or product categories for which the fabric is suitable, such as outerwear, activewear, dresses, or accessories. Comma-separated list.',
    `rejection_reason` STRING COMMENT 'Explanation for why the fabric swatch was rejected, such as cost constraints, performance issues, aesthetic mismatch, or sustainability concerns.',
    `season_code` STRING COMMENT 'Code representing the fashion season for which the swatch is being evaluated, such as SS24 (Spring/Summer 2024) or FW24 (Fall/Winter 2024).. Valid values are `^(SS|FW|AW|SP)[0-9]{2}$`',
    `supplier_fabric_reference` STRING COMMENT 'Suppliers own reference code or catalog number for the fabric, used for ordering and communication with the mill.',
    `sustainability_certification` STRING COMMENT 'Environmental or ethical certifications held by the fabric, such as GOTS (Global Organic Textile Standard), OEKO-TEX Standard 100, BCI (Better Cotton Initiative), or GRS (Global Recycled Standard).',
    `sustainability_score` DECIMAL(18,2) COMMENT 'Numerical score representing the environmental impact and sustainability attributes of the fabric, typically on a scale of 0-100, based on factors such as fiber source, production process, and certifications.',
    `swatch_code` STRING COMMENT 'Unique business identifier code assigned to the fabric swatch for tracking and reference purposes across design and sourcing workflows.. Valid values are `^[A-Z0-9]{6,12}$`',
    `swatch_format` STRING COMMENT 'Indicates whether the swatch is a physical sample, a digital representation, or both formats are available.. Valid values are `physical|digital|both`',
    `swatch_name` STRING COMMENT 'Descriptive name of the fabric swatch, typically including fabric type, texture, or visual characteristics for easy identification by designers.',
    `swatch_receipt_date` DATE COMMENT 'Date when the physical or digital fabric swatch was received by the design team for evaluation.',
    `swatch_status` STRING COMMENT 'Current lifecycle status of the fabric swatch record. Active indicates available for use, archived indicates historical reference, discontinued indicates supplier no longer offers, expired indicates evaluation period ended.. Valid values are `active|archived|discontinued|expired`',
    `texture_description` STRING COMMENT 'Qualitative description of the fabric texture and hand feel, such as smooth, brushed, ribbed, slub, or textured. Captures tactile characteristics important for design evaluation.',
    `trend_alignment_tags` STRING COMMENT 'Keywords or tags linking the fabric swatch to current fashion trends, consumer preferences, or market themes identified in trend research. Comma-separated list.',
    CONSTRAINT pk_fabric_swatch PRIMARY KEY(`fabric_swatch_id`)
) COMMENT 'Master record for a physical or digital fabric swatch evaluated during the design phase for potential use in a collection. Captures swatch name, fabric type (woven, knit, denim, jersey, technical), fiber composition, weight (GSM), finish, texture, color, supplier mill, swatch receipt date, designer evaluation notes, adoption decision (selected, shortlisted, rejected), and associated season or concept. Fabric swatches are the material exploration artifacts that precede formal material sourcing.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`design`.`asset` (
    `asset_id` BIGINT COMMENT 'Unique identifier for the design asset record. Primary key for the design asset entity.',
    `employee_id` BIGINT COMMENT 'Reference to the user or approver who granted final approval for this design asset, used for audit trail and accountability.',
    `asset_uploaded_by_user_employee_id` BIGINT COMMENT 'Reference to the user who uploaded or created the design asset record in the DAM system, used for audit trail and accountability.',
    `collection_id` BIGINT COMMENT 'Reference to the seasonal collection or product line that this design asset belongs to, enabling collection-level asset management.',
    `concept_id` BIGINT COMMENT 'Reference to the design concept that this asset supports or illustrates, linking assets to the creative ideation phase.',
    `designer_id` BIGINT COMMENT 'Reference to the designer or creative professional who owns or is responsible for this design asset, used for attribution and workflow routing.',
    `style_id` BIGINT COMMENT 'Reference to the product style or Stock Keeping Unit (SKU) that this design asset is associated with, linking creative assets to product records.',
    `superseded_by_asset_id` BIGINT COMMENT 'Reference to the newer design asset that supersedes or replaces this asset, used for version lineage and historical tracking.',
    `original_asset_id` BIGINT COMMENT 'Self-referencing FK on asset (original_asset_id)',
    `approval_status` STRING COMMENT 'Approval workflow status indicating whether the design asset has been reviewed and approved for use in production or marketing materials.. Valid values are `approved|pending|rejected|not_submitted`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the design asset was approved, recorded for compliance and workflow tracking.',
    `archived_timestamp` TIMESTAMP COMMENT 'Date and time when the design asset was archived or moved to inactive status, used for lifecycle management and retention policy enforcement.',
    `asset_code` STRING COMMENT 'Unique business identifier or reference code assigned to the design asset for cataloging and cross-referencing across systems.',
    `asset_description` STRING COMMENT 'Detailed textual description of the design asset content, purpose, and creative intent, used for search, cataloging, and context.',
    `asset_name` STRING COMMENT 'Human-readable name or title of the design asset, used for identification and search within the Digital Asset Management (DAM) system.',
    `asset_status` STRING COMMENT 'Current lifecycle status of the design asset within the DAM system (active, archived, restricted, pending approval, rejected, expired), controlling visibility and usage.. Valid values are `active|archived|restricted|pending_approval|rejected|expired`',
    `asset_type` STRING COMMENT 'Classification of the design asset by its creative purpose and format within the design workflow (e.g., sketch, CAD export, print file, lookbook image, runway photo, reference imagery).. Valid values are `sketch|cad_export|print_file|lookbook_image|runway_photo|reference_image`',
    `checksum_hash` STRING COMMENT 'Cryptographic hash or checksum of the asset file, used for integrity verification, duplicate detection, and change tracking.',
    `color_palette_hex_codes` STRING COMMENT 'Comma-separated list of hexadecimal color codes representing the primary color palette featured in the design asset, used for color trend analysis and coordination.',
    `copyright_attribution` STRING COMMENT 'Copyright holder or attribution statement for the design asset, required for compliance with intellectual property laws and licensing agreements.',
    `expiry_date` DATE COMMENT 'Date when the usage rights or license for this design asset expires, after which the asset may no longer be legally used without renewal.',
    `fabric_reference_code` STRING COMMENT 'Reference code linking the design asset to a specific fabric or material in the material library, used for sourcing and Bill of Materials (BOM) planning.',
    `file_format` STRING COMMENT 'Technical file format or extension of the digital asset (e.g., JPG, PNG, TIFF, PSD, AI, PDF, SVG, DXF, OBJ, FBX, MP4). [ENUM-REF-CANDIDATE: jpg|png|tiff|psd|ai|pdf|svg|dxf|obj|fbx|mp4 — 11 candidates stripped; promote to reference product]',
    `file_size_bytes` BIGINT COMMENT 'Size of the digital asset file measured in bytes, used for storage management and transfer optimization.',
    `gender_target` STRING COMMENT 'Target gender segment for the design asset (mens, womens, unisex, kids, infant), used for collection segmentation and merchandising.. Valid values are `mens|womens|unisex|kids|infant`',
    `inspiration_source` STRING COMMENT 'Description of the creative inspiration or reference source for the design asset (e.g., cultural movement, art period, geographic region, designer brand).',
    `is_confidential` BOOLEAN COMMENT 'Boolean flag indicating whether the design asset contains confidential or proprietary information requiring restricted access and handling.',
    `is_featured` BOOLEAN COMMENT 'Boolean flag indicating whether the design asset is featured or highlighted for promotional, presentation, or portfolio purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the design asset metadata or file was last modified, used for change tracking and synchronization.',
    `notes` STRING COMMENT 'Free-form notes or comments about the design asset, used for collaboration, feedback, and contextual information sharing among design team members.',
    `price_tier` STRING COMMENT 'Target price tier or market positioning for products associated with this design asset (luxury, premium, mid-tier, value, entry), used for brand alignment and merchandising strategy.. Valid values are `luxury|premium|mid_tier|value|entry`',
    `product_category` STRING COMMENT 'Product category or garment type that the design asset is intended for (e.g., tops, bottoms, outerwear, footwear, accessories), used for asset organization and filtering.',
    `season_code` STRING COMMENT 'Code representing the fashion season (e.g., SS24, FW24, Holiday 2024) for which this design asset was created, used for temporal organization and archiving.',
    `storage_location_type` STRING COMMENT 'Type of storage infrastructure hosting the asset (cloud, on-premise, hybrid, archive), used for access and retrieval planning.. Valid values are `cloud|on_premise|hybrid|archive`',
    `storage_path` STRING COMMENT 'Full file system or cloud storage path where the digital asset is stored, enabling retrieval and access control.',
    `tags` STRING COMMENT 'Comma-separated or pipe-separated list of keywords and tags applied to the design asset for search, filtering, and categorization within the DAM system.',
    `thumbnail_url` STRING COMMENT 'Web-accessible URL of the asset thumbnail image for preview and quick reference in DAM interfaces and design review tools.',
    `trend_theme` STRING COMMENT 'Trend theme or macro trend that the design asset aligns with or illustrates, used for trend tracking and collection planning.',
    `upload_timestamp` TIMESTAMP COMMENT 'Date and time when the design asset was first uploaded or ingested into the DAM system, used for audit trail and asset lifecycle tracking.',
    `usage_rights` STRING COMMENT 'Legal usage rights and permissions associated with the design asset, defining how and where the asset may be used (internal only, licensed, royalty-free, restricted, public domain).. Valid values are `internal_only|licensed|royalty_free|restricted|public_domain`',
    `version_number` STRING COMMENT 'Version number of the design asset, used to track iterations and revisions throughout the design development process.',
    CONSTRAINT pk_asset PRIMARY KEY(`asset_id`)
) COMMENT 'Master record for any digital creative asset managed within the design domains digital asset library — including final approved sketches, CAD exports, print files, lookbook images, runway photos, and reference imagery. Captures asset name, asset type, file format, file size, storage path, associated style or concept, season, designer owner, usage rights, expiry date, and asset status (active, archived, restricted). Serves as the design domains DAM (Digital Asset Management) catalog.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`design`.`designer` (
    `designer_id` BIGINT COMMENT 'Unique identifier for the designer record. Primary key for the designer entity in the design domain.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created the designer record.',
    `designer_employee_id` BIGINT COMMENT 'Identifier of the design director or manager to whom this designer reports.',
    `designer_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified the designer record.',
    `reports_to_designer_id` BIGINT COMMENT 'Self-referencing FK on designer (reports_to_designer_id)',
    `assigned_categories` STRING COMMENT 'Comma-separated list of product categories the designer is currently assigned to work on, such as tops, bottoms, outerwear, footwear, or accessories.',
    `awards_recognition` STRING COMMENT 'Summary of industry awards, recognitions, or notable achievements earned by the designer throughout their career.',
    `certifications` STRING COMMENT 'Comma-separated list of professional certifications or accreditations held by the designer, such as OEKO-TEX certification, GOTS training, or technical design credentials.',
    `collaboration_notes` STRING COMMENT 'Free-text notes capturing collaboration preferences, working style, or special considerations for team assignments and project planning.',
    `cost_center_code` STRING COMMENT 'Financial cost center code to which the designers compensation and expenses are allocated.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the designer record was first created in the system.',
    `design_team_assignment` STRING COMMENT 'Name or identifier of the design team or studio the designer is assigned to, such as Womens Apparel Team, Footwear Innovation Lab, or Print Studio.',
    `designer_code` STRING COMMENT 'Business identifier code assigned to the designer for internal reference and system integration. Format: three uppercase letters followed by four digits.. Valid values are `^[A-Z]{3}[0-9]{4}$`',
    `designer_status` STRING COMMENT 'Current lifecycle status of the designer record indicating their availability and engagement state.. Valid values are `active|inactive|on_leave|terminated|suspended`',
    `designer_type` STRING COMMENT 'Classification of the designer based on their primary creative discipline within the design function.. Valid values are `apparel_designer|footwear_designer|accessories_designer|print_designer|technical_designer|pattern_maker`',
    `education_background` STRING COMMENT 'Summary of the designers educational qualifications, including degrees, institutions, and relevant certifications in design or related fields.',
    `email_address` STRING COMMENT 'Primary email address for designer communication and collaboration.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `employment_type` STRING COMMENT 'Classification of the designers employment relationship with the organization. Full Time Employee (FTE), freelance, contractor, intern, or consultant.. Valid values are `full_time_employee|freelance|contractor|intern|consultant`',
    `full_name` STRING COMMENT 'Full legal name of the designer or creative contributor.',
    `hire_date` DATE COMMENT 'Date the designer was hired or onboarded into the organization.',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the designers identity and work are subject to confidentiality restrictions, such as for high-profile collaborations or stealth projects.',
    `language_skills` STRING COMMENT 'Languages the designer is fluent in, supporting global collaboration and market-specific design work.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the designer record was last updated or modified.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent formal performance review conducted for the designer.',
    `location_office` STRING COMMENT 'Primary office or studio location where the designer is based, such as New York HQ, Milan Design Center, or Remote.',
    `performance_rating` STRING COMMENT 'Most recent performance evaluation rating for the designer, reflecting their contribution and quality of work.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the designer.',
    `portfolio_reference_url` STRING COMMENT 'URL or file path reference to the designers portfolio showcasing their creative work and design projects.',
    `preferred_name` STRING COMMENT 'Preferred or professional name used by the designer in creative work and collaboration.',
    `seniority_level` STRING COMMENT 'Hierarchical level of the designer within the design organization, reflecting experience and responsibility.. Valid values are `junior|mid_level|senior|lead|principal|director`',
    `software_proficiency` STRING COMMENT 'Comma-separated list of design software and tools the designer is proficient in, such as Adobe Illustrator, CLO 3D, Centric PLM, or Browzwear.',
    `specialization` STRING COMMENT 'Specific area of expertise or focus within the designers discipline, such as menswear, womenswear, activewear, luxury, or sustainable design.',
    `sustainability_focus_flag` BOOLEAN COMMENT 'Indicates whether the designer has specialized expertise or focus on sustainable design practices and eco-friendly materials.',
    `termination_date` DATE COMMENT 'Date the designers employment or engagement with the organization ended. Null if currently active.',
    `years_of_experience` STRING COMMENT 'Total number of years of professional design experience the designer has in the apparel and fashion industry.',
    CONSTRAINT pk_designer PRIMARY KEY(`designer_id`)
) COMMENT 'Design-domain master record for individual designers and creative contributors working within the design function — including in-house designers, freelance designers, pattern makers, and technical designers. Captures designer name, designer type (apparel designer, footwear designer, accessories designer, print designer, technical designer, pattern maker), specialization, seniority level, assigned categories, portfolio reference, employment type (FTE, freelance, contractor), active status, and design team assignment. Distinct from workforce.employee — this is the design-domain view of creative talent with design-specific attributes.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`design`.`inspiration` (
    `inspiration_id` BIGINT COMMENT 'Unique identifier for the design inspiration record. Primary key.',
    `concept_id` BIGINT COMMENT 'Identifier of the design concept to which this inspiration has been linked or applied, if applicable.',
    `designer_id` BIGINT COMMENT 'Identifier of the designer or design team member who logged this inspiration into the system.',
    `trend_item_id` BIGINT COMMENT 'Identifier of the trend item record to which this inspiration is related, enabling linkage to formal trend analysis.',
    `derived_from_inspiration_id` BIGINT COMMENT 'Self-referencing FK on inspiration (derived_from_inspiration_id)',
    `additional_media_urls` STRING COMMENT 'Comma-separated list of additional image, video, or media URLs that provide further visual context for this inspiration.',
    `adoption_status` STRING COMMENT 'Current status of this inspiration in the design workflow: logged (newly captured), under review (being evaluated), adopted (incorporated into design), archived (stored for future reference), or rejected (not pursued).. Valid values are `logged|under_review|adopted|archived|rejected`',
    `color_palette` STRING COMMENT 'Dominant colors or color combinations observed in the inspiration, described in business terms or hex codes.',
    `construction_details` STRING COMMENT 'Key construction techniques or details observed, such as draping, pleating, tailoring, embroidery, appliqué, or innovative seaming.',
    `copyright_attribution` STRING COMMENT 'Copyright or attribution information for the inspiration source, ensuring proper credit and legal compliance when using external references.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspiration record was first created in the system.',
    `cultural_influence` STRING COMMENT 'Cultural movements, historical periods, or societal themes reflected in the inspiration, such as 1970s revival, minimalism, maximalism, or streetwear culture.',
    `design_notes` STRING COMMENT 'Internal notes or commentary from the design team regarding how this inspiration might be translated into product design or collection development.',
    `designer_brand` STRING COMMENT 'Name of the designer or brand associated with the inspiration source, particularly relevant for runway and competitive observations.',
    `fabric_elements` STRING COMMENT 'Notable fabric types, textures, or material characteristics observed, such as silk, denim, leather, knit, woven, technical fabrics, or sustainable materials.',
    `gender_target` STRING COMMENT 'Target gender segment for which this inspiration is most relevant.. Valid values are `mens|womens|unisex|kids|all`',
    `geographic_origin` STRING COMMENT 'Geographic location or region where the inspiration was observed or originated (e.g., Paris, Tokyo, New York, Milan).',
    `image_reference_url` STRING COMMENT 'URL or file path to the primary image or visual reference associated with this inspiration.',
    `inspiration_code` STRING COMMENT 'Unique business code or reference number assigned to this inspiration entry for cataloging and retrieval.',
    `inspiration_description` STRING COMMENT 'Detailed narrative description of the inspiration, capturing the designers observations, creative insights, and potential application ideas.',
    `is_active` BOOLEAN COMMENT 'Flag indicating whether this inspiration record is currently active and available for use in the design teams knowledge base.',
    `is_confidential` BOOLEAN COMMENT 'Flag indicating whether this inspiration is confidential and should be restricted to authorized design team members only.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspiration record was last updated or modified.',
    `observation_date` DATE COMMENT 'Date when the inspiration was observed, captured, or logged by the design team.',
    `price_tier_relevance` STRING COMMENT 'Price tier or market segment to which this inspiration is most applicable.. Valid values are `luxury|premium|mid_tier|value|all`',
    `print_pattern_theme` STRING COMMENT 'Print or pattern themes observed in the inspiration, such as floral, geometric, abstract, animal print, stripes, or cultural motifs.',
    `product_category_relevance` STRING COMMENT 'Product categories to which this inspiration is most applicable, such as outerwear, dresses, activewear, footwear, or accessories.',
    `relevance_score` DECIMAL(18,2) COMMENT 'Numeric score (0-100) indicating the assessed relevance or importance of this inspiration to current or future collections, assigned by design leadership.',
    `season_relevance` STRING COMMENT 'Season or seasonal period to which this inspiration is most relevant (e.g., Spring/Summer 2025, Fall/Winter 2024).',
    `season_year` STRING COMMENT 'Calendar year associated with the season relevance for time-series analysis and trend tracking.',
    `silhouette_elements` STRING COMMENT 'Key silhouette characteristics observed in the inspiration, such as oversized, fitted, A-line, boxy, flowing, structured, asymmetric, or layered.',
    `source_name` STRING COMMENT 'Name of the specific source, such as the runway show name, exhibition title, competitive brand name, location visited, or publication name.',
    `source_type` STRING COMMENT 'Category of the inspiration source: runway show, street style observation, art exhibition, nature, cultural event, competitive brand observation, travel reference, editorial content, or social media. [ENUM-REF-CANDIDATE: runway|street_style|art|nature|culture|competitive|exhibition|travel|editorial|social_media — 10 candidates stripped; promote to reference product]',
    `styling_elements` STRING COMMENT 'Notable styling details or accessory elements observed, such as layering techniques, belt usage, footwear style, or jewelry trends.',
    `sustainability_indicator` BOOLEAN COMMENT 'Flag indicating whether the inspiration includes sustainable design elements, eco-friendly materials, or circular fashion principles.',
    `tags` STRING COMMENT 'Comma-separated list of keywords or tags for search, filtering, and categorization of inspiration records within the design teams knowledge base.',
    `title` STRING COMMENT 'Descriptive title or name given to this inspiration reference by the design team.',
    `trend_alignment` STRING COMMENT 'Key trend themes or macro trends that this inspiration aligns with, linking to broader trend forecasting and market direction.',
    `usage_count` STRING COMMENT 'Number of times this inspiration has been referenced or applied in design concepts, mood boards, or product development activities.',
    `usage_rights` STRING COMMENT 'Usage rights classification indicating how this inspiration may be used: internal only, licensed for commercial use, public domain, or restricted.. Valid values are `internal_only|licensed|public_domain|restricted`',
    CONSTRAINT pk_inspiration PRIMARY KEY(`inspiration_id`)
) COMMENT 'Master record for a curated inspiration reference logged by the design team — including runway show references, street style observations, cultural events, art exhibitions, travel references, and competitive brand observations. Captures inspiration title, source type (runway, street style, art, nature, culture, competitive), source name, season relevance, geographic origin, key design elements observed (silhouette, color, fabric, construction), designer who logged it, and associated concept or trend item. Builds the design teams institutional creative knowledge base.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ADD CONSTRAINT `fk_design_concept_designer_id` FOREIGN KEY (`designer_id`) REFERENCES `apparel_fashion_ecm`.`design`.`designer`(`designer_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ADD CONSTRAINT `fk_design_concept_trend_report_id` FOREIGN KEY (`trend_report_id`) REFERENCES `apparel_fashion_ecm`.`design`.`trend_report`(`trend_report_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ADD CONSTRAINT `fk_design_concept_evolved_from_concept_id` FOREIGN KEY (`evolved_from_concept_id`) REFERENCES `apparel_fashion_ecm`.`design`.`concept`(`concept_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ADD CONSTRAINT `fk_design_mood_board_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `apparel_fashion_ecm`.`design`.`concept`(`concept_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ADD CONSTRAINT `fk_design_mood_board_designer_id` FOREIGN KEY (`designer_id`) REFERENCES `apparel_fashion_ecm`.`design`.`designer`(`designer_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ADD CONSTRAINT `fk_design_mood_board_evolved_from_mood_board_id` FOREIGN KEY (`evolved_from_mood_board_id`) REFERENCES `apparel_fashion_ecm`.`design`.`mood_board`(`mood_board_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ADD CONSTRAINT `fk_design_mood_board_asset_mood_board_id` FOREIGN KEY (`mood_board_id`) REFERENCES `apparel_fashion_ecm`.`design`.`mood_board`(`mood_board_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ADD CONSTRAINT `fk_design_mood_board_asset_designer_id` FOREIGN KEY (`designer_id`) REFERENCES `apparel_fashion_ecm`.`design`.`designer`(`designer_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ADD CONSTRAINT `fk_design_mood_board_asset_grouped_with_mood_board_asset_id` FOREIGN KEY (`grouped_with_mood_board_asset_id`) REFERENCES `apparel_fashion_ecm`.`design`.`mood_board_asset`(`mood_board_asset_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ADD CONSTRAINT `fk_design_trend_report_prior_season_trend_report_id` FOREIGN KEY (`prior_season_trend_report_id`) REFERENCES `apparel_fashion_ecm`.`design`.`trend_report`(`trend_report_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ADD CONSTRAINT `fk_design_trend_item_trend_report_id` FOREIGN KEY (`trend_report_id`) REFERENCES `apparel_fashion_ecm`.`design`.`trend_report`(`trend_report_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ADD CONSTRAINT `fk_design_trend_item_related_trend_item_id` FOREIGN KEY (`related_trend_item_id`) REFERENCES `apparel_fashion_ecm`.`design`.`trend_item`(`trend_item_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ADD CONSTRAINT `fk_design_sketch_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `apparel_fashion_ecm`.`design`.`concept`(`concept_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ADD CONSTRAINT `fk_design_sketch_designer_id` FOREIGN KEY (`designer_id`) REFERENCES `apparel_fashion_ecm`.`design`.`designer`(`designer_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ADD CONSTRAINT `fk_design_sketch_previous_version_sketch_id` FOREIGN KEY (`previous_version_sketch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`sketch`(`sketch_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ADD CONSTRAINT `fk_design_sketch_revised_from_sketch_id` FOREIGN KEY (`revised_from_sketch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`sketch`(`sketch_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ADD CONSTRAINT `fk_design_cad_file_designer_id` FOREIGN KEY (`designer_id`) REFERENCES `apparel_fashion_ecm`.`design`.`designer`(`designer_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ADD CONSTRAINT `fk_design_cad_file_print_design_id` FOREIGN KEY (`print_design_id`) REFERENCES `apparel_fashion_ecm`.`design`.`print_design`(`print_design_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ADD CONSTRAINT `fk_design_cad_file_sketch_id` FOREIGN KEY (`sketch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`sketch`(`sketch_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ADD CONSTRAINT `fk_design_cad_file_superseded_by_cad_file_id` FOREIGN KEY (`superseded_by_cad_file_id`) REFERENCES `apparel_fashion_ecm`.`design`.`cad_file`(`cad_file_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ADD CONSTRAINT `fk_design_cad_file_previous_version_cad_file_id` FOREIGN KEY (`previous_version_cad_file_id`) REFERENCES `apparel_fashion_ecm`.`design`.`cad_file`(`cad_file_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ADD CONSTRAINT `fk_design_colorway_development_designer_id` FOREIGN KEY (`designer_id`) REFERENCES `apparel_fashion_ecm`.`design`.`designer`(`designer_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ADD CONSTRAINT `fk_design_colorway_development_print_design_id` FOREIGN KEY (`print_design_id`) REFERENCES `apparel_fashion_ecm`.`design`.`print_design`(`print_design_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ADD CONSTRAINT `fk_design_colorway_development_revised_colorway_development_id` FOREIGN KEY (`revised_colorway_development_id`) REFERENCES `apparel_fashion_ecm`.`design`.`colorway_development`(`colorway_development_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ADD CONSTRAINT `fk_design_print_design_designer_id` FOREIGN KEY (`designer_id`) REFERENCES `apparel_fashion_ecm`.`design`.`designer`(`designer_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ADD CONSTRAINT `fk_design_print_design_original_print_design_id` FOREIGN KEY (`original_print_design_id`) REFERENCES `apparel_fashion_ecm`.`design`.`print_design`(`print_design_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ADD CONSTRAINT `fk_design_print_colorway_designer_id` FOREIGN KEY (`designer_id`) REFERENCES `apparel_fashion_ecm`.`design`.`designer`(`designer_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ADD CONSTRAINT `fk_design_print_colorway_print_design_id` FOREIGN KEY (`print_design_id`) REFERENCES `apparel_fashion_ecm`.`design`.`print_design`(`print_design_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ADD CONSTRAINT `fk_design_print_colorway_derived_from_print_colorway_id` FOREIGN KEY (`derived_from_print_colorway_id`) REFERENCES `apparel_fashion_ecm`.`design`.`print_colorway`(`print_colorway_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ADD CONSTRAINT `fk_design_pattern_block_base_pattern_block_id` FOREIGN KEY (`base_pattern_block_id`) REFERENCES `apparel_fashion_ecm`.`design`.`pattern_block`(`pattern_block_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ADD CONSTRAINT `fk_design_review_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `apparel_fashion_ecm`.`design`.`concept`(`concept_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ADD CONSTRAINT `fk_design_review_follow_up_review_id` FOREIGN KEY (`follow_up_review_id`) REFERENCES `apparel_fashion_ecm`.`design`.`review`(`review_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ADD CONSTRAINT `fk_design_review_item_designer_id` FOREIGN KEY (`designer_id`) REFERENCES `apparel_fashion_ecm`.`design`.`designer`(`designer_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ADD CONSTRAINT `fk_design_review_item_review_id` FOREIGN KEY (`review_id`) REFERENCES `apparel_fashion_ecm`.`design`.`review`(`review_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ADD CONSTRAINT `fk_design_review_item_sketch_id` FOREIGN KEY (`sketch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`sketch`(`sketch_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ADD CONSTRAINT `fk_design_review_item_previous_review_item_id` FOREIGN KEY (`previous_review_item_id`) REFERENCES `apparel_fashion_ecm`.`design`.`review_item`(`review_item_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ADD CONSTRAINT `fk_design_brief_designer_id` FOREIGN KEY (`designer_id`) REFERENCES `apparel_fashion_ecm`.`design`.`designer`(`designer_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ADD CONSTRAINT `fk_design_brief_parent_brief_id` FOREIGN KEY (`parent_brief_id`) REFERENCES `apparel_fashion_ecm`.`design`.`brief`(`brief_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ADD CONSTRAINT `fk_design_calendar_designer_id` FOREIGN KEY (`designer_id`) REFERENCES `apparel_fashion_ecm`.`design`.`designer`(`designer_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ADD CONSTRAINT `fk_design_calendar_calendar_lead_designer_id` FOREIGN KEY (`calendar_lead_designer_id`) REFERENCES `apparel_fashion_ecm`.`design`.`designer`(`designer_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ADD CONSTRAINT `fk_design_calendar_previous_version_calendar_id` FOREIGN KEY (`previous_version_calendar_id`) REFERENCES `apparel_fashion_ecm`.`design`.`calendar`(`calendar_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ADD CONSTRAINT `fk_design_milestone_calendar_id` FOREIGN KEY (`calendar_id`) REFERENCES `apparel_fashion_ecm`.`design`.`calendar`(`calendar_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ADD CONSTRAINT `fk_design_milestone_predecessor_milestone_id` FOREIGN KEY (`predecessor_milestone_id`) REFERENCES `apparel_fashion_ecm`.`design`.`milestone`(`milestone_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ADD CONSTRAINT `fk_design_milestone_designer_id` FOREIGN KEY (`designer_id`) REFERENCES `apparel_fashion_ecm`.`design`.`designer`(`designer_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ADD CONSTRAINT `fk_design_collaboration_designer_id` FOREIGN KEY (`designer_id`) REFERENCES `apparel_fashion_ecm`.`design`.`designer`(`designer_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ADD CONSTRAINT `fk_design_collaboration_related_collaboration_id` FOREIGN KEY (`related_collaboration_id`) REFERENCES `apparel_fashion_ecm`.`design`.`collaboration`(`collaboration_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ADD CONSTRAINT `fk_design_embellishment_designer_id` FOREIGN KEY (`designer_id`) REFERENCES `apparel_fashion_ecm`.`design`.`designer`(`designer_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ADD CONSTRAINT `fk_design_embellishment_derived_from_embellishment_id` FOREIGN KEY (`derived_from_embellishment_id`) REFERENCES `apparel_fashion_ecm`.`design`.`embellishment`(`embellishment_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ADD CONSTRAINT `fk_design_color_palette_designer_id` FOREIGN KEY (`designer_id`) REFERENCES `apparel_fashion_ecm`.`design`.`designer`(`designer_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ADD CONSTRAINT `fk_design_color_palette_derived_from_color_palette_id` FOREIGN KEY (`derived_from_color_palette_id`) REFERENCES `apparel_fashion_ecm`.`design`.`color_palette`(`color_palette_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ADD CONSTRAINT `fk_design_handoff_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `apparel_fashion_ecm`.`design`.`concept`(`concept_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ADD CONSTRAINT `fk_design_handoff_designer_id` FOREIGN KEY (`designer_id`) REFERENCES `apparel_fashion_ecm`.`design`.`designer`(`designer_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ADD CONSTRAINT `fk_design_handoff_reissued_handoff_id` FOREIGN KEY (`reissued_handoff_id`) REFERENCES `apparel_fashion_ecm`.`design`.`handoff`(`handoff_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ADD CONSTRAINT `fk_design_revision_designer_id` FOREIGN KEY (`designer_id`) REFERENCES `apparel_fashion_ecm`.`design`.`designer`(`designer_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ADD CONSTRAINT `fk_design_revision_review_id` FOREIGN KEY (`review_id`) REFERENCES `apparel_fashion_ecm`.`design`.`review`(`review_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ADD CONSTRAINT `fk_design_revision_sketch_id` FOREIGN KEY (`sketch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`sketch`(`sketch_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ADD CONSTRAINT `fk_design_revision_prior_revision_id` FOREIGN KEY (`prior_revision_id`) REFERENCES `apparel_fashion_ecm`.`design`.`revision`(`revision_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ADD CONSTRAINT `fk_design_fabric_swatch_designer_id` FOREIGN KEY (`designer_id`) REFERENCES `apparel_fashion_ecm`.`design`.`designer`(`designer_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ADD CONSTRAINT `fk_design_fabric_swatch_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `apparel_fashion_ecm`.`design`.`concept`(`concept_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ADD CONSTRAINT `fk_design_fabric_swatch_alternate_fabric_swatch_id` FOREIGN KEY (`alternate_fabric_swatch_id`) REFERENCES `apparel_fashion_ecm`.`design`.`fabric_swatch`(`fabric_swatch_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ADD CONSTRAINT `fk_design_asset_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `apparel_fashion_ecm`.`design`.`concept`(`concept_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ADD CONSTRAINT `fk_design_asset_designer_id` FOREIGN KEY (`designer_id`) REFERENCES `apparel_fashion_ecm`.`design`.`designer`(`designer_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ADD CONSTRAINT `fk_design_asset_superseded_by_asset_id` FOREIGN KEY (`superseded_by_asset_id`) REFERENCES `apparel_fashion_ecm`.`design`.`asset`(`asset_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ADD CONSTRAINT `fk_design_asset_original_asset_id` FOREIGN KEY (`original_asset_id`) REFERENCES `apparel_fashion_ecm`.`design`.`asset`(`asset_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ADD CONSTRAINT `fk_design_designer_reports_to_designer_id` FOREIGN KEY (`reports_to_designer_id`) REFERENCES `apparel_fashion_ecm`.`design`.`designer`(`designer_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ADD CONSTRAINT `fk_design_inspiration_concept_id` FOREIGN KEY (`concept_id`) REFERENCES `apparel_fashion_ecm`.`design`.`concept`(`concept_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ADD CONSTRAINT `fk_design_inspiration_designer_id` FOREIGN KEY (`designer_id`) REFERENCES `apparel_fashion_ecm`.`design`.`designer`(`designer_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ADD CONSTRAINT `fk_design_inspiration_trend_item_id` FOREIGN KEY (`trend_item_id`) REFERENCES `apparel_fashion_ecm`.`design`.`trend_item`(`trend_item_id`);
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ADD CONSTRAINT `fk_design_inspiration_derived_from_inspiration_id` FOREIGN KEY (`derived_from_inspiration_id`) REFERENCES `apparel_fashion_ecm`.`design`.`inspiration`(`inspiration_id`);

-- ========= TAGS =========
ALTER SCHEMA `apparel_fashion_ecm`.`design` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `apparel_fashion_ecm`.`design` SET TAGS ('dbx_domain' = 'design');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` SET TAGS ('dbx_subdomain' = 'creative_ideation');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `designer_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Designer ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `circular_program_id` SET TAGS ('dbx_business_glossary_term' = 'Circular Program Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `concept_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `concept_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `concept_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `concept_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `concept_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `concept_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `ecolabel_id` SET TAGS ('dbx_business_glossary_term' = 'Ecolabel Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `packaging_sustainability_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Sustainability Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `sustainable_material_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Material Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `trend_report_id` SET TAGS ('dbx_business_glossary_term' = 'Trend Research ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `evolved_from_concept_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `collaboration_notes` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Notes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `color_palette_description` SET TAGS ('dbx_business_glossary_term' = 'Color Palette Description');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `concept_code` SET TAGS ('dbx_business_glossary_term' = 'Concept Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `concept_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `concept_name` SET TAGS ('dbx_business_glossary_term' = 'Concept Name');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `concept_status` SET TAGS ('dbx_business_glossary_term' = 'Concept Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `concept_status` SET TAGS ('dbx_value_regex' = 'ideation|review|approved|rejected|on_hold|archived');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `design_direction` SET TAGS ('dbx_business_glossary_term' = 'Design Direction');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `estimated_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Estimated Unit Count');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `fabric_direction` SET TAGS ('dbx_business_glossary_term' = 'Fabric Direction');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `gender_target` SET TAGS ('dbx_business_glossary_term' = 'Gender Target');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `gender_target` SET TAGS ('dbx_value_regex' = 'mens|womens|unisex|kids|youth');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `gender_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `gender_target` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `inspiration_sources` SET TAGS ('dbx_business_glossary_term' = 'Inspiration Sources');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `mood_board_url` SET TAGS ('dbx_business_glossary_term' = 'Mood Board URL');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `mood_board_url` SET TAGS ('dbx_value_regex' = '^https?://.*');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `mood_keywords` SET TAGS ('dbx_business_glossary_term' = 'Mood Keywords');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `price_tier` SET TAGS ('dbx_business_glossary_term' = 'Price Tier');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `price_tier` SET TAGS ('dbx_value_regex' = 'entry|mid|premium|luxury');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Concept Priority');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `product_category` SET TAGS ('dbx_value_regex' = 'apparel|footwear|accessories|activewear|outerwear|swimwear');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `season` SET TAGS ('dbx_business_glossary_term' = 'Season');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `season` SET TAGS ('dbx_value_regex' = '^(SS|FW|AW|SP)[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `silhouette_direction` SET TAGS ('dbx_business_glossary_term' = 'Silhouette Direction');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `sustainability_focus` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Focus');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `target_customer_archetype` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Archetype');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `target_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Target Launch Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`concept` ALTER COLUMN `theme` SET TAGS ('dbx_business_glossary_term' = 'Design Theme');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` SET TAGS ('dbx_subdomain' = 'creative_ideation');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `mood_board_id` SET TAGS ('dbx_business_glossary_term' = 'Mood Board ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `designer_id` SET TAGS ('dbx_business_glossary_term' = 'Designer ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `evolved_from_mood_board_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `board_code` SET TAGS ('dbx_business_glossary_term' = 'Mood Board Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `board_code` SET TAGS ('dbx_value_regex' = '^MB-[A-Z0-9]{6,12}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `brand_alignment` SET TAGS ('dbx_business_glossary_term' = 'Brand Alignment');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `brand_alignment` SET TAGS ('dbx_value_regex' = 'on_brand|exploratory|off_brand');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `collaboration_notes` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Notes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `color_story` SET TAGS ('dbx_business_glossary_term' = 'Color Story');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `creative_theme` SET TAGS ('dbx_business_glossary_term' = 'Creative Theme');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `cultural_references` SET TAGS ('dbx_business_glossary_term' = 'Cultural References');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `digital_file_path` SET TAGS ('dbx_business_glossary_term' = 'Digital File Path');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `digital_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `format_type` SET TAGS ('dbx_business_glossary_term' = 'Format Type');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `format_type` SET TAGS ('dbx_value_regex' = 'digital|physical|hybrid');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `gender_category` SET TAGS ('dbx_business_glossary_term' = 'Gender Category');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `gender_category` SET TAGS ('dbx_value_regex' = 'mens|womens|unisex|kids|all');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `gender_category` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `gender_category` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `geographic_market_focus` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market Focus');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `inspiration_source` SET TAGS ('dbx_business_glossary_term' = 'Inspiration Source');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Is Confidential');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `merchandising_feedback` SET TAGS ('dbx_business_glossary_term' = 'Merchandising Feedback');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `mood_board_status` SET TAGS ('dbx_business_glossary_term' = 'Mood Board Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `mood_board_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|rejected|archived');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `mood_board_type` SET TAGS ('dbx_business_glossary_term' = 'Mood Board Type');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `mood_board_type` SET TAGS ('dbx_value_regex' = 'concept|seasonal|collection|product_line|trend_research|presentation');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `platform_tool` SET TAGS ('dbx_business_glossary_term' = 'Platform Tool');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `presentation_date` SET TAGS ('dbx_business_glossary_term' = 'Presentation Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `primary_color_palette` SET TAGS ('dbx_business_glossary_term' = 'Primary Color Palette');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `product_category_focus` SET TAGS ('dbx_business_glossary_term' = 'Product Category Focus');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `silhouette_direction` SET TAGS ('dbx_business_glossary_term' = 'Silhouette Direction');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `sustainability_focus` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Focus');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `sustainability_focus` SET TAGS ('dbx_value_regex' = 'none|low|medium|high');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `target_customer_persona` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Persona');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `target_price_point` SET TAGS ('dbx_business_glossary_term' = 'Target Price Point');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `target_price_point` SET TAGS ('dbx_value_regex' = 'entry|mid|premium|luxury');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `texture_references` SET TAGS ('dbx_business_glossary_term' = 'Texture References');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_business_glossary_term' = 'Thumbnail URL (Uniform Resource Locator)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Mood Board Title');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `trend_alignment_score` SET TAGS ('dbx_business_glossary_term' = 'Trend Alignment Score');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^v?[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board` ALTER COLUMN `creation_date` SET TAGS ('dbx_business_glossary_term' = 'Creation Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` SET TAGS ('dbx_subdomain' = 'creative_ideation');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `mood_board_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Mood Board Asset Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `collection_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `mood_board_id` SET TAGS ('dbx_business_glossary_term' = 'Mood Board Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `designer_id` SET TAGS ('dbx_business_glossary_term' = 'Uploaded By Designer Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `grouped_with_mood_board_asset_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending|not_submitted');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `asset_caption` SET TAGS ('dbx_business_glossary_term' = 'Asset Caption');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `asset_file_format` SET TAGS ('dbx_business_glossary_term' = 'Asset File Format');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `asset_file_name` SET TAGS ('dbx_business_glossary_term' = 'Asset File Name');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `asset_file_path` SET TAGS ('dbx_business_glossary_term' = 'Asset File Path');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `asset_file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Asset File Size in Bytes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `asset_height` SET TAGS ('dbx_business_glossary_term' = 'Asset Height');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `asset_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Sequence Number');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `asset_source_url` SET TAGS ('dbx_business_glossary_term' = 'Asset Source Uniform Resource Locator (URL)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_value_regex' = 'active|archived|removed|pending_review');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `asset_tags` SET TAGS ('dbx_business_glossary_term' = 'Asset Tags');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `asset_width` SET TAGS ('dbx_business_glossary_term' = 'Asset Width');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `color_palette_hex_codes` SET TAGS ('dbx_business_glossary_term' = 'Color Palette Hexadecimal (HEX) Codes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `copyright_attribution` SET TAGS ('dbx_business_glossary_term' = 'Copyright Attribution');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `fabric_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Fabric Reference Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `inspiration_source` SET TAGS ('dbx_business_glossary_term' = 'Inspiration Source');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `is_featured` SET TAGS ('dbx_business_glossary_term' = 'Is Featured Flag');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `linked_product_sku` SET TAGS ('dbx_business_glossary_term' = 'Linked Product Stock Keeping Unit (SKU)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `position_x_coordinate` SET TAGS ('dbx_business_glossary_term' = 'Position X Coordinate');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `position_y_coordinate` SET TAGS ('dbx_business_glossary_term' = 'Position Y Coordinate');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `trend_theme` SET TAGS ('dbx_business_glossary_term' = 'Trend Theme');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `upload_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Upload Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `usage_rights` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights');
ALTER TABLE `apparel_fashion_ecm`.`design`.`mood_board_asset` ALTER COLUMN `usage_rights` SET TAGS ('dbx_value_regex' = 'internal_only|licensed|public_domain|restricted');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` SET TAGS ('dbx_subdomain' = 'creative_ideation');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `trend_report_id` SET TAGS ('dbx_business_glossary_term' = 'Trend Report ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `prior_season_trend_report_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `adoption_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Adoption Recommendation');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `adoption_recommendation` SET TAGS ('dbx_value_regex' = 'lead|follow|monitor|avoid');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `color_palette` SET TAGS ('dbx_business_glossary_term' = 'Color Palette');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `consumer_segment` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `cultural_influence` SET TAGS ('dbx_business_glossary_term' = 'Cultural Influence');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `key_trend_themes` SET TAGS ('dbx_business_glossary_term' = 'Key Trend Themes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `material_focus` SET TAGS ('dbx_business_glossary_term' = 'Material Focus');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `print_pattern_theme` SET TAGS ('dbx_business_glossary_term' = 'Print and Pattern Theme');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `relevance_score` SET TAGS ('dbx_business_glossary_term' = 'Relevance Score');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `report_author` SET TAGS ('dbx_business_glossary_term' = 'Report Author');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `report_code` SET TAGS ('dbx_business_glossary_term' = 'Report Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `report_document_url` SET TAGS ('dbx_business_glossary_term' = 'Report Document URL');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `report_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'draft|under review|approved|archived|obsolete');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `report_title` SET TAGS ('dbx_business_glossary_term' = 'Report Title');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `season` SET TAGS ('dbx_business_glossary_term' = 'Season');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `season` SET TAGS ('dbx_value_regex' = 'spring|summer|fall|winter|pre-fall|resort');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `season_year` SET TAGS ('dbx_business_glossary_term' = 'Season Year');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `silhouette_direction` SET TAGS ('dbx_business_glossary_term' = 'Silhouette Direction');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `source_agency` SET TAGS ('dbx_business_glossary_term' = 'Source Agency');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `sustainability_focus` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Focus');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Tags');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `target_product_category` SET TAGS ('dbx_business_glossary_term' = 'Target Product Category');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `trend_category` SET TAGS ('dbx_business_glossary_term' = 'Trend Category');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `trend_category` SET TAGS ('dbx_value_regex' = 'macro trend|micro trend|color trend|silhouette trend|material trend|print trend');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `trend_description` SET TAGS ('dbx_business_glossary_term' = 'Trend Description');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_report` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` SET TAGS ('dbx_subdomain' = 'creative_ideation');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `trend_item_id` SET TAGS ('dbx_business_glossary_term' = 'Trend Item Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `trend_report_id` SET TAGS ('dbx_business_glossary_term' = 'Trend Report Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `related_trend_item_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `adoption_score` SET TAGS ('dbx_business_glossary_term' = 'Adoption Score');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `collection_adoption_flag` SET TAGS ('dbx_business_glossary_term' = 'Collection Adoption Flag');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `color_palette` SET TAGS ('dbx_business_glossary_term' = 'Color Palette');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `competitive_brand_adoption` SET TAGS ('dbx_business_glossary_term' = 'Competitive Brand Adoption');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `consumer_segment` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Relevance');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `designer_brand` SET TAGS ('dbx_business_glossary_term' = 'Designer or Brand');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `forecast_longevity_months` SET TAGS ('dbx_business_glossary_term' = 'Forecast Longevity in Months');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `gender_relevance` SET TAGS ('dbx_business_glossary_term' = 'Gender Relevance');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `gender_relevance` SET TAGS ('dbx_value_regex' = 'mens|womens|unisex|kids|all');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `gender_relevance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `gender_relevance` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `geographic_relevance` SET TAGS ('dbx_business_glossary_term' = 'Geographic Relevance');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `image_reference_url` SET TAGS ('dbx_business_glossary_term' = 'Image Reference Uniform Resource Locator (URL)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `influence_level` SET TAGS ('dbx_business_glossary_term' = 'Influence Level');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `influence_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `item_name` SET TAGS ('dbx_business_glossary_term' = 'Trend Item Name');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `logged_by_analyst` SET TAGS ('dbx_business_glossary_term' = 'Logged By Analyst');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `material_composition` SET TAGS ('dbx_business_glossary_term' = 'Material Composition');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `observation_date` SET TAGS ('dbx_business_glossary_term' = 'Observation Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `price_tier_relevance` SET TAGS ('dbx_business_glossary_term' = 'Price Tier Relevance');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `price_tier_relevance` SET TAGS ('dbx_value_regex' = 'luxury|premium|mid_market|mass_market|value');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `product_category_relevance` SET TAGS ('dbx_business_glossary_term' = 'Product Category Relevance');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `related_trend_items` SET TAGS ('dbx_business_glossary_term' = 'Related Trend Items');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `runway_citation` SET TAGS ('dbx_business_glossary_term' = 'Runway Citation');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^(SS|FW|AW|SP)[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `source_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Reference');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Source Type');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `sustainability_indicator` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Indicator');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `trend_category` SET TAGS ('dbx_business_glossary_term' = 'Trend Category');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `trend_description` SET TAGS ('dbx_business_glossary_term' = 'Trend Description');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `trend_item_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `trend_item_status` SET TAGS ('dbx_value_regex' = 'active|archived|under_review|rejected');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `trend_stage` SET TAGS ('dbx_business_glossary_term' = 'Trend Stage');
ALTER TABLE `apparel_fashion_ecm`.`design`.`trend_item` ALTER COLUMN `trend_stage` SET TAGS ('dbx_value_regex' = 'emerging|growth|peak|maturity|declining|obsolete');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` SET TAGS ('dbx_subdomain' = 'style_development');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `sketch_id` SET TAGS ('dbx_business_glossary_term' = 'Design Sketch ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `designer_id` SET TAGS ('dbx_business_glossary_term' = 'Designer ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `ecolabel_id` SET TAGS ('dbx_business_glossary_term' = 'Ecolabel Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Design Director ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `previous_version_sketch_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Version ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style Master ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `sustainable_material_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Material Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `revised_from_sketch_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revision_requested|on_hold');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `collaboration_team` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Team');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `collection_name` SET TAGS ('dbx_business_glossary_term' = 'Collection Name');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `color_palette_reference` SET TAGS ('dbx_business_glossary_term' = 'Color Palette Reference');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `design_notes` SET TAGS ('dbx_business_glossary_term' = 'Design Notes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `design_phase` SET TAGS ('dbx_business_glossary_term' = 'Design Phase');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `design_phase` SET TAGS ('dbx_value_regex' = 'concept|initial_sketch|revised_sketch|final_sketch|approved');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `estimated_cogs` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost of Goods Sold (COGS)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `estimated_cogs` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `fabric_suggestion` SET TAGS ('dbx_business_glossary_term' = 'Fabric Suggestion');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'Sketch File Format');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `file_path` SET TAGS ('dbx_business_glossary_term' = 'Sketch File Path');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `gender_target` SET TAGS ('dbx_business_glossary_term' = 'Gender Target');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `gender_target` SET TAGS ('dbx_value_regex' = 'mens|womens|unisex|youth|kids');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `gender_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `gender_target` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `medium` SET TAGS ('dbx_business_glossary_term' = 'Sketch Medium');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `medium` SET TAGS ('dbx_value_regex' = 'hand_drawn|cad_2d|cad_3d|digital_illustration|mixed_media');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `primary_color_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Color Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `primary_color_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,8}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `print_pattern_reference` SET TAGS ('dbx_business_glossary_term' = 'Print Pattern Reference');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `product_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Product Subcategory');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^(SS|FW|HO|SP)[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `silhouette_type` SET TAGS ('dbx_business_glossary_term' = 'Silhouette Type');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `sketch_number` SET TAGS ('dbx_business_glossary_term' = 'Sketch Number');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `sketch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}-[0-9]{4,6}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `sustainability_certification_target` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification Target');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `sustainability_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Flag');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `target_price_point` SET TAGS ('dbx_business_glossary_term' = 'Target Price Point');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `target_price_point` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `tech_pack_generated_flag` SET TAGS ('dbx_business_glossary_term' = 'Tech Pack Generated Flag');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `thumbnail_image_path` SET TAGS ('dbx_business_glossary_term' = 'Thumbnail Image Path');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `trend_theme` SET TAGS ('dbx_business_glossary_term' = 'Trend Theme');
ALTER TABLE `apparel_fashion_ecm`.`design`.`sketch` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` SET TAGS ('dbx_subdomain' = 'style_development');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `cad_file_id` SET TAGS ('dbx_business_glossary_term' = 'Computer-Aided Design (CAD) File ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `collection_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `colorway_id` SET TAGS ('dbx_business_glossary_term' = 'Colorway ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `designer_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Designer ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `print_design_id` SET TAGS ('dbx_business_glossary_term' = 'Print Pattern ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `sketch_id` SET TAGS ('dbx_business_glossary_term' = 'Design Sketch ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `superseded_by_cad_file_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By CAD File ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `previous_version_cad_file_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Archived Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `checksum_hash` SET TAGS ('dbx_business_glossary_term' = 'File Checksum Hash');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `collaboration_notes` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Notes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'File Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `design_complexity` SET TAGS ('dbx_business_glossary_term' = 'Design Complexity Level');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `design_complexity` SET TAGS ('dbx_value_regex' = 'simple|moderate|complex|highly_complex');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `design_phase` SET TAGS ('dbx_business_glossary_term' = 'Design Phase');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `design_phase` SET TAGS ('dbx_value_regex' = 'concept|initial_design|development|pre_production|production_ready|archived');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'CAD File Format');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `file_name` SET TAGS ('dbx_business_glossary_term' = 'CAD File Name');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `file_status` SET TAGS ('dbx_business_glossary_term' = 'CAD File Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `file_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|rejected|superseded|archived');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `garment_category` SET TAGS ('dbx_business_glossary_term' = 'Garment Category');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `is_3d_simulation` SET TAGS ('dbx_business_glossary_term' = '3D Simulation Flag');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `is_production_ready` SET TAGS ('dbx_business_glossary_term' = 'Production Ready Flag');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `storage_location_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Type');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `storage_location_type` SET TAGS ('dbx_value_regex' = 'local_server|cloud_storage|plm_system|network_drive');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `storage_path` SET TAGS ('dbx_business_glossary_term' = 'File Storage Path');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `storage_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Design Tags');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `technical_notes` SET TAGS ('dbx_business_glossary_term' = 'Technical Design Notes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `thumbnail_path` SET TAGS ('dbx_business_glossary_term' = 'Thumbnail Image Path');
ALTER TABLE `apparel_fashion_ecm`.`design`.`cad_file` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'File Version Number');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` SET TAGS ('dbx_subdomain' = 'style_development');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `colorway_development_id` SET TAGS ('dbx_business_glossary_term' = 'Colorway Development ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `designer_id` SET TAGS ('dbx_business_glossary_term' = 'Designer ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `material_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Certification Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `print_design_id` SET TAGS ('dbx_business_glossary_term' = 'Print Pattern ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `supplier_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `sustainable_material_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Material Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `revised_colorway_development_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `body_color_hex` SET TAGS ('dbx_business_glossary_term' = 'Body Color Hexadecimal Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `body_color_hex` SET TAGS ('dbx_value_regex' = '^#[0-9A-Fa-f]{6}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `body_color_ncs` SET TAGS ('dbx_business_glossary_term' = 'Body Color Natural Color System (NCS) Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `body_color_pantone` SET TAGS ('dbx_business_glossary_term' = 'Body Color Pantone Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `body_color_ral` SET TAGS ('dbx_business_glossary_term' = 'Body Color RAL Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `cancelled_date` SET TAGS ('dbx_business_glossary_term' = 'Colorway Cancelled Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `color_matching_tolerance` SET TAGS ('dbx_business_glossary_term' = 'Color Matching Tolerance');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `color_story_theme` SET TAGS ('dbx_business_glossary_term' = 'Color Story Theme');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `colorfastness_requirement` SET TAGS ('dbx_business_glossary_term' = 'Colorfastness Requirement');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `colorway_code` SET TAGS ('dbx_business_glossary_term' = 'Colorway Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `colorway_name` SET TAGS ('dbx_business_glossary_term' = 'Colorway Name');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `confirmed_date` SET TAGS ('dbx_business_glossary_term' = 'Colorway Confirmed Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `contrast_color_hex` SET TAGS ('dbx_business_glossary_term' = 'Contrast Color Hexadecimal Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `contrast_color_hex` SET TAGS ('dbx_value_regex' = '^#[0-9A-Fa-f]{6}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `contrast_color_pantone` SET TAGS ('dbx_business_glossary_term' = 'Contrast Color Pantone Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `designer_notes` SET TAGS ('dbx_business_glossary_term' = 'Designer Notes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `development_status` SET TAGS ('dbx_business_glossary_term' = 'Colorway Development Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `lab_dip_approval_round` SET TAGS ('dbx_business_glossary_term' = 'Lab Dip Approval Round');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `lab_dip_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Lab Dip Approved Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `lab_dip_received_date` SET TAGS ('dbx_business_glossary_term' = 'Lab Dip Received Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `lab_dip_requested_date` SET TAGS ('dbx_business_glossary_term' = 'Lab Dip Requested Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `lining_color_hex` SET TAGS ('dbx_business_glossary_term' = 'Lining Color Hexadecimal Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `lining_color_hex` SET TAGS ('dbx_value_regex' = '^#[0-9A-Fa-f]{6}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `lining_color_pantone` SET TAGS ('dbx_business_glossary_term' = 'Lining Color Pantone Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `mood_board_reference` SET TAGS ('dbx_business_glossary_term' = 'Mood Board Reference');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^(SS|FW|AW|SP)[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `strike_off_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Strike-Off Approved Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `strike_off_requested_date` SET TAGS ('dbx_business_glossary_term' = 'Strike-Off Requested Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `target_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Target Cost Currency');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `target_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `target_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Target Cost Per Unit');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `target_cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `technical_notes` SET TAGS ('dbx_business_glossary_term' = 'Technical Notes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `trend_research_reference` SET TAGS ('dbx_business_glossary_term' = 'Trend Research Reference');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `trim_color_hex` SET TAGS ('dbx_business_glossary_term' = 'Trim Color Hexadecimal Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `trim_color_hex` SET TAGS ('dbx_value_regex' = '^#[0-9A-Fa-f]{6}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`colorway_development` ALTER COLUMN `trim_color_pantone` SET TAGS ('dbx_business_glossary_term' = 'Trim Color Pantone Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` SET TAGS ('dbx_subdomain' = 'style_development');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `print_design_id` SET TAGS ('dbx_business_glossary_term' = 'Print Design ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `designer_id` SET TAGS ('dbx_business_glossary_term' = 'Designer ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `original_print_design_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional|on_hold');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `collection_name` SET TAGS ('dbx_business_glossary_term' = 'Collection Name');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `color_count` SET TAGS ('dbx_business_glossary_term' = 'Color Count');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `color_profile` SET TAGS ('dbx_business_glossary_term' = 'Color Profile');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `color_profile` SET TAGS ('dbx_value_regex' = 'CMYK|RGB|Pantone|LAB');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `colorway_count` SET TAGS ('dbx_business_glossary_term' = 'Colorway Count');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `copyright_year` SET TAGS ('dbx_business_glossary_term' = 'Copyright Year');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `design_medium` SET TAGS ('dbx_business_glossary_term' = 'Design Medium');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `design_medium` SET TAGS ('dbx_value_regex' = 'hand_painted|digital|repeat_tile|photographic|mixed_media|vector');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `design_notes` SET TAGS ('dbx_business_glossary_term' = 'Design Notes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `design_status` SET TAGS ('dbx_business_glossary_term' = 'Design Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `design_status` SET TAGS ('dbx_value_regex' = 'concept|in_development|submitted|approved|rejected|archived');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `design_theme` SET TAGS ('dbx_business_glossary_term' = 'Design Theme');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `fabric_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Fabric Compatibility');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `is_licensed_artwork` SET TAGS ('dbx_business_glossary_term' = 'Is Licensed Artwork Flag');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `license_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Number');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `license_agreement_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `license_holder_name` SET TAGS ('dbx_business_glossary_term' = 'License Holder Name');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `license_holder_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `master_file_format` SET TAGS ('dbx_business_glossary_term' = 'Master File Format');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `master_file_path` SET TAGS ('dbx_business_glossary_term' = 'Master File Path');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `master_file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'Master File Size in Megabytes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `primary_color_hex` SET TAGS ('dbx_business_glossary_term' = 'Primary Color Hexadecimal Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `primary_color_hex` SET TAGS ('dbx_value_regex' = '^#[0-9A-Fa-f]{6}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `print_code` SET TAGS ('dbx_business_glossary_term' = 'Print Design Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `print_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `print_name` SET TAGS ('dbx_business_glossary_term' = 'Print Design Name');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `print_resolution_dpi` SET TAGS ('dbx_business_glossary_term' = 'Print Resolution in Dots Per Inch (DPI)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `print_technique` SET TAGS ('dbx_business_glossary_term' = 'Print Technique');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `print_technique` SET TAGS ('dbx_value_regex' = 'screen_print|digital_print|sublimation|rotary_print|discharge_print|block_print');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `print_type` SET TAGS ('dbx_business_glossary_term' = 'Print Type');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `print_type` SET TAGS ('dbx_value_regex' = 'allover_print|engineered_print|border_print|placement_print|jacquard|embroidery');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `repeat_height_cm` SET TAGS ('dbx_business_glossary_term' = 'Repeat Height in Centimeters');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `repeat_type` SET TAGS ('dbx_business_glossary_term' = 'Repeat Type');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `repeat_type` SET TAGS ('dbx_value_regex' = 'full_repeat|half_drop|brick|mirror|toss|engineered');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `repeat_width_cm` SET TAGS ('dbx_business_glossary_term' = 'Repeat Width in Centimeters');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percentage');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^(SS|FW|SP|FA|HO)[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `secondary_color_hex` SET TAGS ('dbx_business_glossary_term' = 'Secondary Color Hexadecimal Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `secondary_color_hex` SET TAGS ('dbx_value_regex' = '^#[0-9A-Fa-f]{6}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_value_regex' = 'GOTS|OEKO_TEX|BCI|none');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `trend_alignment` SET TAGS ('dbx_business_glossary_term' = 'Trend Alignment');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `usage_rights` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_design` ALTER COLUMN `usage_rights` SET TAGS ('dbx_value_regex' = 'exclusive|non_exclusive|limited_territory|limited_category|unlimited');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` SET TAGS ('dbx_subdomain' = 'style_development');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `print_colorway_id` SET TAGS ('dbx_business_glossary_term' = 'Print Colorway ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `designer_id` SET TAGS ('dbx_business_glossary_term' = 'Designer ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `print_design_id` SET TAGS ('dbx_business_glossary_term' = 'Print Design ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `supplier_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `derived_from_print_colorway_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `azo_free` SET TAGS ('dbx_business_glossary_term' = 'Azo-Free');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `cmyk_color_formula` SET TAGS ('dbx_business_glossary_term' = 'CMYK Color Formula');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `collection_name` SET TAGS ('dbx_business_glossary_term' = 'Collection Name');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `color_fastness_rating` SET TAGS ('dbx_business_glossary_term' = 'Color Fastness Rating');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `color_fastness_rating` SET TAGS ('dbx_value_regex' = '^[1-5]$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `color_palette_description` SET TAGS ('dbx_business_glossary_term' = 'Color Palette Description');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `colorway_code` SET TAGS ('dbx_business_glossary_term' = 'Colorway Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `colorway_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `colorway_name` SET TAGS ('dbx_business_glossary_term' = 'Colorway Name');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `colorway_status` SET TAGS ('dbx_business_glossary_term' = 'Colorway Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `colorway_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|in_production|discontinued');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `digital_file_format` SET TAGS ('dbx_business_glossary_term' = 'Digital File Format');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `digital_file_path` SET TAGS ('dbx_business_glossary_term' = 'Digital File Path');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `gender_target` SET TAGS ('dbx_business_glossary_term' = 'Gender Target');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `gender_target` SET TAGS ('dbx_value_regex' = 'mens|womens|unisex|kids_boys|kids_girls|kids_unisex');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `gender_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `gender_target` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `hex_color_code` SET TAGS ('dbx_business_glossary_term' = 'Hexadecimal Color Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `hex_color_code` SET TAGS ('dbx_value_regex' = '^#[0-9A-Fa-f]{6}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `oeko_tex_compliant` SET TAGS ('dbx_business_glossary_term' = 'OEKO-TEX Compliant');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `primary_pantone_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Pantone Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `primary_pantone_code` SET TAGS ('dbx_value_regex' = '^PANTONE [0-9]{1,4}[A-Z]{0,2}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `print_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Print Layer Count');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `print_technique` SET TAGS ('dbx_business_glossary_term' = 'Print Technique');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `rgb_color_code` SET TAGS ('dbx_business_glossary_term' = 'RGB Color Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `rgb_color_code` SET TAGS ('dbx_value_regex' = '^rgb([0-9]{1,3}, [0-9]{1,3}, [0-9]{1,3})$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^(SS|FW|AW|SP)[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `secondary_pantone_code` SET TAGS ('dbx_business_glossary_term' = 'Secondary Pantone Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `secondary_pantone_code` SET TAGS ('dbx_value_regex' = '^PANTONE [0-9]{1,4}[A-Z]{0,2}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `strike_off_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Strike-Off Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `strike_off_status` SET TAGS ('dbx_business_glossary_term' = 'Strike-Off Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `strike_off_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Strike-Off Submission Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `style_reference_codes` SET TAGS ('dbx_business_glossary_term' = 'Style Reference Codes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `substrate_type` SET TAGS ('dbx_business_glossary_term' = 'Substrate Type');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `target_market` SET TAGS ('dbx_business_glossary_term' = 'Target Market');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `target_market` SET TAGS ('dbx_value_regex' = 'north_america|europe|asia_pacific|latin_america|middle_east|global');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `tertiary_pantone_code` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Pantone Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `tertiary_pantone_code` SET TAGS ('dbx_value_regex' = '^PANTONE [0-9]{1,4}[A-Z]{0,2}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `apparel_fashion_ecm`.`design`.`print_colorway` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` SET TAGS ('dbx_subdomain' = 'style_development');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `pattern_block_id` SET TAGS ('dbx_business_glossary_term' = 'Pattern Block ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Design Team ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Pattern Maker ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `base_pattern_block_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `block_code` SET TAGS ('dbx_business_glossary_term' = 'Pattern Block Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `block_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `block_description` SET TAGS ('dbx_business_glossary_term' = 'Pattern Block Description');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `block_name` SET TAGS ('dbx_business_glossary_term' = 'Pattern Block Name');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `block_status` SET TAGS ('dbx_business_glossary_term' = 'Pattern Block Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `block_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|archived|deprecated');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `body_measurement_basis` SET TAGS ('dbx_business_glossary_term' = 'Body Measurement Basis');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `ease_allowance_inches` SET TAGS ('dbx_business_glossary_term' = 'Ease Allowance (Inches)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `fabric_type_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Fabric Type Recommendation');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `fit_type` SET TAGS ('dbx_business_glossary_term' = 'Fit Type');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `fit_type` SET TAGS ('dbx_value_regex' = 'slim|regular|relaxed|oversized|athletic|tailored');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `garment_category` SET TAGS ('dbx_business_glossary_term' = 'Garment Category');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `garment_category` SET TAGS ('dbx_value_regex' = 'tops|bottoms|dresses|outerwear|activewear|accessories');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `garment_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Garment Subcategory');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `gender_target` SET TAGS ('dbx_business_glossary_term' = 'Gender Target');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `gender_target` SET TAGS ('dbx_value_regex' = 'mens|womens|unisex|kids_boys|kids_girls');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `gender_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `gender_target` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `grading_rules_reference` SET TAGS ('dbx_business_glossary_term' = 'Grading Rules Reference');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `is_proprietary` SET TAGS ('dbx_business_glossary_term' = 'Is Proprietary');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `measurement_chart_url` SET TAGS ('dbx_business_glossary_term' = 'Measurement Chart URL');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Pattern Block Notes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `pattern_file_format` SET TAGS ('dbx_business_glossary_term' = 'Pattern File Format');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `pattern_file_format` SET TAGS ('dbx_value_regex' = 'DXF|AAMA|ASTM|PLT|PDF|proprietary_cad');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `pattern_file_path` SET TAGS ('dbx_business_glossary_term' = 'Pattern File Path');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `pattern_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `pattern_version` SET TAGS ('dbx_business_glossary_term' = 'Pattern Version');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `pattern_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `seam_allowance_inches` SET TAGS ('dbx_business_glossary_term' = 'Seam Allowance (Inches)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `size_range_end` SET TAGS ('dbx_business_glossary_term' = 'Size Range End');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `size_range_start` SET TAGS ('dbx_business_glossary_term' = 'Size Range Start');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `sustainability_notes` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Notes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `technical_sketch_url` SET TAGS ('dbx_business_glossary_term' = 'Technical Sketch URL');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `apparel_fashion_ecm`.`design`.`pattern_block` ALTER COLUMN `creation_date` SET TAGS ('dbx_business_glossary_term' = 'Pattern Block Creation Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` SET TAGS ('dbx_subdomain' = 'approval_governance');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `review_id` SET TAGS ('dbx_business_glossary_term' = 'Design Review ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `review_created_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `review_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `review_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `review_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Reviewer ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `review_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `review_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `review_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `review_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `review_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `review_next_action_owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Next Action Owner ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `review_next_action_owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `review_next_action_owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `follow_up_review_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `agenda` SET TAGS ('dbx_business_glossary_term' = 'Review Agenda');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|conditionally_approved|rejected');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `brand_alignment_score` SET TAGS ('dbx_business_glossary_term' = 'Brand Alignment Score');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `commercial_feedback` SET TAGS ('dbx_business_glossary_term' = 'Commercial Feedback');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Review End Time');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `follow_up_review_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Review Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `follow_up_review_scheduled` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Review Scheduled');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Is Confidential');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Review Location');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `meeting_minutes_url` SET TAGS ('dbx_business_glossary_term' = 'Meeting Minutes URL');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `meeting_minutes_url` SET TAGS ('dbx_value_regex' = '^https?://.*');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `merchandising_feedback` SET TAGS ('dbx_business_glossary_term' = 'Merchandising Feedback');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `next_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Action Due Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `participant_list` SET TAGS ('dbx_business_glossary_term' = 'Participant List');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `presentation_file_path` SET TAGS ('dbx_business_glossary_term' = 'Presentation File Path');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `review_code` SET TAGS ('dbx_business_glossary_term' = 'Design Review Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `review_code` SET TAGS ('dbx_value_regex' = '^DR-[A-Z0-9]{6,12}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `review_name` SET TAGS ('dbx_business_glossary_term' = 'Design Review Name');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|postponed');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Design Review Type');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'concept_review|line_review|final_adoption_review|pre_production_review|sample_review|technical_review');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `revision_instructions` SET TAGS ('dbx_business_glossary_term' = 'Revision Instructions');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^(SS|FW|AW|SP)[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Review Start Time');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `styles_adopted_count` SET TAGS ('dbx_business_glossary_term' = 'Styles Adopted Count');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `styles_dropped_count` SET TAGS ('dbx_business_glossary_term' = 'Styles Dropped Count');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `styles_reviewed_count` SET TAGS ('dbx_business_glossary_term' = 'Styles Reviewed Count');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `styles_revised_count` SET TAGS ('dbx_business_glossary_term' = 'Styles Revised Count');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `sustainability_assessment` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Assessment');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `technical_feedback` SET TAGS ('dbx_business_glossary_term' = 'Technical Feedback');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review` ALTER COLUMN `trend_alignment_score` SET TAGS ('dbx_business_glossary_term' = 'Trend Alignment Score');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` SET TAGS ('dbx_subdomain' = 'approval_governance');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `review_item_id` SET TAGS ('dbx_business_glossary_term' = 'Design Review Item ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `designer_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Designer ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Reviewer ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `review_id` SET TAGS ('dbx_business_glossary_term' = 'Design Review ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `sketch_id` SET TAGS ('dbx_business_glossary_term' = 'Sketch ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `tertiary_review_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `tertiary_review_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `tertiary_review_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `previous_review_item_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `brand_alignment_score` SET TAGS ('dbx_business_glossary_term' = 'Brand Alignment Score');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `color_story` SET TAGS ('dbx_business_glossary_term' = 'Color Story');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `commercial_feedback` SET TAGS ('dbx_business_glossary_term' = 'Commercial Feedback');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `competitive_benchmark` SET TAGS ('dbx_business_glossary_term' = 'Competitive Benchmark');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Decision Rationale');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decision Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `estimated_cogs` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost of Goods Sold (COGS)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `estimated_cogs` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `estimated_retail_price` SET TAGS ('dbx_business_glossary_term' = 'Estimated Retail Price (MSRP)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `estimated_retail_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `estimated_unit_volume` SET TAGS ('dbx_business_glossary_term' = 'Estimated Unit Volume');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `estimated_unit_volume` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `estimated_wholesale_price` SET TAGS ('dbx_business_glossary_term' = 'Estimated Wholesale Price');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `estimated_wholesale_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `fabric_type` SET TAGS ('dbx_business_glossary_term' = 'Fabric Type');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `gender_target` SET TAGS ('dbx_business_glossary_term' = 'Gender Target');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `gender_target` SET TAGS ('dbx_value_regex' = 'mens|womens|unisex|kids|infant');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `gender_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `gender_target` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `item_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Item Sequence Number');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `price_tier` SET TAGS ('dbx_business_glossary_term' = 'Price Tier');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `price_tier` SET TAGS ('dbx_value_regex' = 'luxury|premium|mid|value|entry');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `priority_ranking` SET TAGS ('dbx_business_glossary_term' = 'Priority Ranking');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `requires_new_tooling` SET TAGS ('dbx_business_glossary_term' = 'Requires New Tooling');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `reviewer_decision` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Decision');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `reviewer_decision` SET TAGS ('dbx_value_regex' = 'adopt|revise|drop|hold|pending');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `revision_comments` SET TAGS ('dbx_business_glossary_term' = 'Revision Comments');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `sample_status` SET TAGS ('dbx_business_glossary_term' = 'Sample Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `sample_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|approved|rejected');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `silhouette_type` SET TAGS ('dbx_business_glossary_term' = 'Silhouette Type');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `sustainability_rating` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Rating');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `sustainability_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low|not_assessed');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `target_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Target Launch Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `target_margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Margin Percentage');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `target_margin_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `technical_feasibility_score` SET TAGS ('dbx_business_glossary_term' = 'Technical Feasibility Score');
ALTER TABLE `apparel_fashion_ecm`.`design`.`review_item` ALTER COLUMN `trend_relevance_score` SET TAGS ('dbx_business_glossary_term' = 'Trend Relevance Score');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` SET TAGS ('dbx_subdomain' = 'creative_ideation');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `brief_id` SET TAGS ('dbx_business_glossary_term' = 'Design Brief ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `designer_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Designer ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `brief_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `brief_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `brief_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `brief_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `brief_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `brief_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `parent_brief_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `brand_alignment_score` SET TAGS ('dbx_business_glossary_term' = 'Brand Alignment Score');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `brief_code` SET TAGS ('dbx_business_glossary_term' = 'Design Brief Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `brief_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `brief_status` SET TAGS ('dbx_business_glossary_term' = 'Design Brief Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `budget_allocated` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocated');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `budget_allocated` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `collaboration_notes` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Notes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `commercial_objectives` SET TAGS ('dbx_business_glossary_term' = 'Commercial Objectives');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `commercial_objectives` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `competitive_benchmarks` SET TAGS ('dbx_business_glossary_term' = 'Competitive Benchmarks');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `competitive_benchmarks` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `completed_date` SET TAGS ('dbx_business_glossary_term' = 'Completed Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `concept_submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Concept Submission Deadline');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `delivery_milestone_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Milestone Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `design_direction` SET TAGS ('dbx_business_glossary_term' = 'Design Direction');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `design_team_size` SET TAGS ('dbx_business_glossary_term' = 'Design Team Size');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `distribution_channel_target` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Target');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `distribution_channel_target` SET TAGS ('dbx_value_regex' = 'retail|wholesale|ecommerce|dtc|omnichannel');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `gender_target` SET TAGS ('dbx_business_glossary_term' = 'Gender Target');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `gender_target` SET TAGS ('dbx_value_regex' = 'mens|womens|unisex|kids|youth');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `gender_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `gender_target` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `geographic_market_focus` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market Focus');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Is Confidential');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `issued_date` SET TAGS ('dbx_business_glossary_term' = 'Issued Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `issuing_department` SET TAGS ('dbx_business_glossary_term' = 'Issuing Department');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `issuing_department` SET TAGS ('dbx_value_regex' = 'design|merchandising|brand_management|product_development|marketing');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `issuing_stakeholder` SET TAGS ('dbx_business_glossary_term' = 'Issuing Stakeholder');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `key_trend_references` SET TAGS ('dbx_business_glossary_term' = 'Key Trend References');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `merchandising_feedback` SET TAGS ('dbx_business_glossary_term' = 'Merchandising Feedback');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `sample_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^(SS|FW|AW|SP)[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `sustainability_requirements` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Requirements');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `target_category` SET TAGS ('dbx_business_glossary_term' = 'Target Product Category');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `target_customer_persona` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Persona');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `target_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Margin Percentage');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `target_margin_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `target_price_point` SET TAGS ('dbx_business_glossary_term' = 'Target Price Point');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `target_volume_units` SET TAGS ('dbx_business_glossary_term' = 'Target Volume Units');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `target_volume_units` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Design Brief Title');
ALTER TABLE `apparel_fashion_ecm`.`design`.`brief` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` SET TAGS ('dbx_subdomain' = 'approval_governance');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Design Calendar ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `designer_id` SET TAGS ('dbx_business_glossary_term' = 'Design Director ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `calendar_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `calendar_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `calendar_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `calendar_lead_designer_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Designer ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `calendar_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `calendar_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `calendar_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `previous_version_calendar_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `actual_sku_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Stock Keeping Unit (SKU) Count');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `calendar_code` SET TAGS ('dbx_business_glossary_term' = 'Calendar Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `calendar_name` SET TAGS ('dbx_business_glossary_term' = 'Calendar Name');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `calendar_status` SET TAGS ('dbx_business_glossary_term' = 'Calendar Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `calendar_status` SET TAGS ('dbx_value_regex' = 'draft|active|in_progress|completed|on_hold|cancelled');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `concept_kickoff_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Concept Kick-Off Actual Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `concept_kickoff_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Concept Kick-Off Planned Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `delay_days` SET TAGS ('dbx_business_glossary_term' = 'Delay Days');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Calendar End Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `gender_target` SET TAGS ('dbx_business_glossary_term' = 'Gender Target');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `gender_target` SET TAGS ('dbx_value_regex' = 'mens|womens|unisex|kids|infant');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `gender_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `gender_target` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `line_review_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Line Review Actual Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `line_review_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Line Review Planned Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `mood_board_review_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Mood Board Review Actual Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `mood_board_review_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Mood Board Review Planned Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `proto_sample_request_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Proto Sample Request Actual Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `proto_sample_request_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Proto Sample Request Planned Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `responsible_team` SET TAGS ('dbx_business_glossary_term' = 'Responsible Team');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `season_year` SET TAGS ('dbx_business_glossary_term' = 'Season Year');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `sketch_submission_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Sketch Submission Actual Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `sketch_submission_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Sketch Submission Planned Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Calendar Start Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `target_sku_count` SET TAGS ('dbx_business_glossary_term' = 'Target Stock Keeping Unit (SKU) Count');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `tech_pack_handoff_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Tech Pack Handoff Actual Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `tech_pack_handoff_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Tech Pack Handoff Planned Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`calendar` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Calendar Version');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` SET TAGS ('dbx_subdomain' = 'approval_governance');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Design Milestone ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Design Calendar ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `milestone_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `milestone_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `milestone_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `milestone_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `milestone_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `milestone_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Team ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `predecessor_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Milestone ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `designer_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Designer ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `actual_deliverable_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Deliverable Count');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `actual_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Effort Hours');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|overdue|cancelled|on_hold');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `delay_days` SET TAGS ('dbx_business_glossary_term' = 'Delay Days');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `delay_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Delay Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `deliverable_count` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Count');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `deliverable_description` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Description');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `dependency_type` SET TAGS ('dbx_business_glossary_term' = 'Dependency Type');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `dependency_type` SET TAGS ('dbx_value_regex' = 'finish_to_start|start_to_start|finish_to_finish|start_to_finish');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `estimated_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Effort Hours');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `forecast_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `gate_type` SET TAGS ('dbx_business_glossary_term' = 'Gate Type');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `gate_type` SET TAGS ('dbx_value_regex' = 'design_gate|technical_gate|commercial_gate|compliance_gate');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `milestone_category` SET TAGS ('dbx_business_glossary_term' = 'Milestone Category');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `milestone_category` SET TAGS ('dbx_value_regex' = 'creative|technical|commercial|compliance');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `milestone_code` SET TAGS ('dbx_business_glossary_term' = 'Milestone Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_value_regex' = 'concept|sketch|review|handoff|approval|sampling');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Milestone Notes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `review_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Review Meeting Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Review Outcome');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `review_outcome` SET TAGS ('dbx_value_regex' = 'approved|approved_with_changes|rejected|deferred');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `rework_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Rework Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`milestone` ALTER COLUMN `stakeholder_list` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder List');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` SET TAGS ('dbx_subdomain' = 'approval_governance');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `collaboration_id` SET TAGS ('dbx_business_glossary_term' = 'Design Collaboration ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `collaboration_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `collaboration_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `collaboration_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `collaboration_merchandising_contact_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Merchandising Contact ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `collaboration_merchandising_contact_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `collaboration_merchandising_contact_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `collaboration_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `collaboration_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `collaboration_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `designer_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Designer ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `related_collaboration_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `actual_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Launch Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `advance_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Amount');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `advance_payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|on_hold');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `collaboration_code` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `collaboration_name` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Name');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `collaboration_status` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `collaboration_type` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Type');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `collaboration_type` SET TAGS ('dbx_value_regex' = 'artist|designer|brand|celebrity|influencer|licensing');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Uniform Resource Locator (URL)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `contracted_deliverables` SET TAGS ('dbx_business_glossary_term' = 'Contracted Deliverables');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `contracted_deliverables` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `design_ownership_terms` SET TAGS ('dbx_business_glossary_term' = 'Design Ownership Terms');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `design_ownership_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `distribution_channels` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channels');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `estimated_sku_count` SET TAGS ('dbx_business_glossary_term' = 'Estimated Stock Keeping Unit (SKU) Count');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `exclusivity_terms` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Terms');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `exclusivity_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `flat_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Flat Fee Amount');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `flat_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `gender_target` SET TAGS ('dbx_business_glossary_term' = 'Gender Target');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `gender_target` SET TAGS ('dbx_value_regex' = 'mens|womens|unisex|kids|all');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `gender_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `gender_target` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `geographic_market_focus` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market Focus');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `ip_rights_structure` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Rights Structure');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `ip_rights_structure` SET TAGS ('dbx_value_regex' = 'exclusive|non_exclusive|limited_term|perpetual');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `ip_rights_structure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Is Confidential');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `marketing_campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Notes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `partner_legal_entity` SET TAGS ('dbx_business_glossary_term' = 'Partner Legal Entity');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `partner_legal_entity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `partner_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Name');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `partner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percent');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `royalty_structure` SET TAGS ('dbx_business_glossary_term' = 'Royalty Structure');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `royalty_structure` SET TAGS ('dbx_value_regex' = 'percentage_of_sales|flat_fee|hybrid|none');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `royalty_structure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `season_year` SET TAGS ('dbx_business_glossary_term' = 'Season Year');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `sustainability_focus` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Focus');
ALTER TABLE `apparel_fashion_ecm`.`design`.`collaboration` ALTER COLUMN `target_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Target Launch Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` SET TAGS ('dbx_subdomain' = 'style_development');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `embellishment_id` SET TAGS ('dbx_business_glossary_term' = 'Embellishment ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `designer_id` SET TAGS ('dbx_business_glossary_term' = 'Designer ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `embellishment_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `embellishment_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `embellishment_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `embellishment_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `supplier_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `derived_from_embellishment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|revision_required|archived');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `care_instructions` SET TAGS ('dbx_business_glossary_term' = 'Care Instructions');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `color_specification` SET TAGS ('dbx_business_glossary_term' = 'Color Specification');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `digital_file_path` SET TAGS ('dbx_business_glossary_term' = 'Digital File Path');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `embellishment_code` SET TAGS ('dbx_business_glossary_term' = 'Embellishment Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `embellishment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `embellishment_name` SET TAGS ('dbx_business_glossary_term' = 'Embellishment Name');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `embellishment_type` SET TAGS ('dbx_business_glossary_term' = 'Embellishment Type');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Embellishment Height (Centimeters)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `ip_ownership` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Ownership');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `ip_ownership` SET TAGS ('dbx_value_regex' = 'company_owned|licensed|supplier_owned|shared|public_domain');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `license_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Reference');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `license_agreement_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `origin_type` SET TAGS ('dbx_business_glossary_term' = 'Origin Type');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `origin_type` SET TAGS ('dbx_value_regex' = 'in_house|supplier|licensed|custom');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `placement_position` SET TAGS ('dbx_business_glossary_term' = 'Placement Position');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `reusable_flag` SET TAGS ('dbx_business_glossary_term' = 'Reusable Flag');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^(SS|FW|AW|SP)[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `stitch_count` SET TAGS ('dbx_business_glossary_term' = 'Stitch Count');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Tags');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `technique` SET TAGS ('dbx_business_glossary_term' = 'Embellishment Technique');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `thread_count` SET TAGS ('dbx_business_glossary_term' = 'Thread Count');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_business_glossary_term' = 'Thumbnail Uniform Resource Locator (URL)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `apparel_fashion_ecm`.`design`.`embellishment` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Embellishment Width (Centimeters)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` SET TAGS ('dbx_subdomain' = 'style_development');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `color_palette_id` SET TAGS ('dbx_business_glossary_term' = 'Color Palette ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `designer_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Designer ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `tertiary_color_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `tertiary_color_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `tertiary_color_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `derived_from_color_palette_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|archived');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `collaboration_notes` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Notes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `color_story_narrative` SET TAGS ('dbx_business_glossary_term' = 'Color Story Narrative');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `design_team` SET TAGS ('dbx_business_glossary_term' = 'Design Team');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `digital_file_path` SET TAGS ('dbx_business_glossary_term' = 'Digital File Path');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `digital_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `gender_target` SET TAGS ('dbx_business_glossary_term' = 'Gender Target');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `gender_target` SET TAGS ('dbx_value_regex' = 'mens|womens|unisex|kids|all');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `gender_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `gender_target` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `geographic_market_focus` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market Focus');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `hex_codes_list` SET TAGS ('dbx_business_glossary_term' = 'Hexadecimal (HEX) Codes List');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `ncs_codes_list` SET TAGS ('dbx_business_glossary_term' = 'Natural Color System (NCS) Codes List');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `number_of_colors` SET TAGS ('dbx_business_glossary_term' = 'Number of Colors');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `palette_category` SET TAGS ('dbx_business_glossary_term' = 'Palette Category');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `palette_category` SET TAGS ('dbx_value_regex' = 'apparel|footwear|accessories|all');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `palette_code` SET TAGS ('dbx_business_glossary_term' = 'Palette Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `palette_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `palette_name` SET TAGS ('dbx_business_glossary_term' = 'Palette Name');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `palette_type` SET TAGS ('dbx_business_glossary_term' = 'Palette Type');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `palette_type` SET TAGS ('dbx_value_regex' = 'core|accent|neutral|trend|seasonal|capsule');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `pantone_codes_list` SET TAGS ('dbx_business_glossary_term' = 'Pantone Codes List');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `primary_color_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Color Name');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `primary_hex_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Hexadecimal (HEX) Color Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `primary_hex_code` SET TAGS ('dbx_value_regex' = '^#[0-9A-Fa-f]{6}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `primary_pantone_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Pantone Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `primary_pantone_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2,4}[A-Z]{0,3}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `primary_rgb_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Red Green Blue (RGB) Color Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `primary_rgb_code` SET TAGS ('dbx_value_regex' = '^rgb([0-9]{1,3}, [0-9]{1,3}, [0-9]{1,3})$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `ral_codes_list` SET TAGS ('dbx_business_glossary_term' = 'RAL Color Codes List');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^(SS|FW|AW|SP)[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `season_year` SET TAGS ('dbx_business_glossary_term' = 'Season Year');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `secondary_color_names` SET TAGS ('dbx_business_glossary_term' = 'Secondary Color Names');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `sustainability_focus` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Focus Flag');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `sustainability_notes` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Notes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `target_customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Segment');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_business_glossary_term' = 'Thumbnail Uniform Resource Locator (URL)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `trend_alignment_tags` SET TAGS ('dbx_business_glossary_term' = 'Trend Alignment Tags');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `apparel_fashion_ecm`.`design`.`color_palette` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` SET TAGS ('dbx_subdomain' = 'approval_governance');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `handoff_id` SET TAGS ('dbx_business_glossary_term' = 'Design Handoff ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `handoff_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving User ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `handoff_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `handoff_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `handoff_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `handoff_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `handoff_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `designer_id` SET TAGS ('dbx_business_glossary_term' = 'Submitting Designer ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `reissued_handoff_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `bom_draft_included` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Draft Included Flag');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `bom_draft_version` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Draft Version');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `bom_draft_version` SET TAGS ('dbx_value_regex' = '^draft_v[0-9]{1,2}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `cad_file_format` SET TAGS ('dbx_business_glossary_term' = 'Computer-Aided Design (CAD) File Format');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `cad_files_included` SET TAGS ('dbx_business_glossary_term' = 'Computer-Aided Design (CAD) Files Included Flag');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `collaboration_platform` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Platform');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `collaboration_platform` SET TAGS ('dbx_value_regex' = 'centric_plm|infor_plm|sharepoint|teams|email|other');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `collection_name` SET TAGS ('dbx_business_glossary_term' = 'Collection Name');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `colorway_count` SET TAGS ('dbx_business_glossary_term' = 'Colorway Count');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `colorway_specs_included` SET TAGS ('dbx_business_glossary_term' = 'Colorway Specifications Included Flag');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `feedback_notes` SET TAGS ('dbx_business_glossary_term' = 'Feedback Notes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `gender_target` SET TAGS ('dbx_business_glossary_term' = 'Gender Target');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `gender_target` SET TAGS ('dbx_value_regex' = 'mens|womens|unisex|kids_boys|kids_girls');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `gender_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `gender_target` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `handoff_date` SET TAGS ('dbx_business_glossary_term' = 'Design Handoff Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `handoff_number` SET TAGS ('dbx_business_glossary_term' = 'Design Handoff Number');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `handoff_number` SET TAGS ('dbx_value_regex' = '^DH-[0-9]{6,10}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `handoff_status` SET TAGS ('dbx_business_glossary_term' = 'Design Handoff Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `handoff_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|acknowledged|approved|rejected|on_hold');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Design Flag');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `material_library_references` SET TAGS ('dbx_business_glossary_term' = 'Material Library References');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `outstanding_design_items` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Design Items');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `package_url` SET TAGS ('dbx_business_glossary_term' = 'Design Handoff Package Uniform Resource Locator (URL)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `package_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `price_tier` SET TAGS ('dbx_business_glossary_term' = 'Price Tier');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `price_tier` SET TAGS ('dbx_value_regex' = 'entry|core|premium|luxury');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `print_files_included` SET TAGS ('dbx_business_glossary_term' = 'Print Files Included Flag');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `receiving_team` SET TAGS ('dbx_business_glossary_term' = 'Receiving Team');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `receiving_team` SET TAGS ('dbx_value_regex' = 'product_development|sourcing|technical_design|merchandising|production');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^(SS|FW|SP|FA)[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `silhouette_description` SET TAGS ('dbx_business_glossary_term' = 'Silhouette Description');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `style_code` SET TAGS ('dbx_business_glossary_term' = 'Style Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `style_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,15}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `sustainability_notes` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Notes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `target_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Target Launch Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `target_price_point` SET TAGS ('dbx_business_glossary_term' = 'Target Price Point');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `tech_pack_included` SET TAGS ('dbx_business_glossary_term' = 'Tech Pack Included Flag');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `tech_pack_version` SET TAGS ('dbx_business_glossary_term' = 'Tech Pack Version');
ALTER TABLE `apparel_fashion_ecm`.`design`.`handoff` ALTER COLUMN `tech_pack_version` SET TAGS ('dbx_value_regex' = '^v[0-9]{1,2}.[0-9]{1,2}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` SET TAGS ('dbx_subdomain' = 'approval_governance');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Design Revision ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `designer_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Designer ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `fit_session_id` SET TAGS ('dbx_business_glossary_term' = 'Fit Session ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `review_id` SET TAGS ('dbx_business_glossary_term' = 'Design Review Meeting ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `revision_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `revision_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `revision_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `sketch_id` SET TAGS ('dbx_business_glossary_term' = 'Design ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `prior_revision_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Revision Approval Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `collaboration_notes` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Notes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `colorway_change_description` SET TAGS ('dbx_business_glossary_term' = 'Colorway Change Description');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Revision Completion Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `construction_change_description` SET TAGS ('dbx_business_glossary_term' = 'Construction Change Description');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `cost_impact_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `cost_impact_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `cycle_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Revision Cycle Time Hours');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Due Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `estimated_cost_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Impact');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `instructions` SET TAGS ('dbx_business_glossary_term' = 'Revision Instructions');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `is_final_revision` SET TAGS ('dbx_business_glossary_term' = 'Is Final Revision');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `original_cad_file_path` SET TAGS ('dbx_business_glossary_term' = 'Original Computer-Aided Design (CAD) File Path');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `print_pattern_change_description` SET TAGS ('dbx_business_glossary_term' = 'Print Pattern Change Description');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Revision Priority');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Rejection Reason');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Request Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `requestor_role` SET TAGS ('dbx_business_glossary_term' = 'Requestor Role');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `requestor_role` SET TAGS ('dbx_value_regex' = 'design_director|merchandiser|product_manager|technical_designer|fit_technician|sourcing_manager');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `revised_cad_file_path` SET TAGS ('dbx_business_glossary_term' = 'Revised Computer-Aided Design (CAD) File Path');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `revision_status` SET TAGS ('dbx_business_glossary_term' = 'Revision Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `revision_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|under_review|approved|rejected|cancelled');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `revision_type` SET TAGS ('dbx_business_glossary_term' = 'Revision Type');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `revision_type` SET TAGS ('dbx_value_regex' = 'silhouette_change|colorway_change|construction_change|print_change|trim_change|fabric_change');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `silhouette_change_description` SET TAGS ('dbx_business_glossary_term' = 'Silhouette Change Description');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Revision Start Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `sustainability_impact` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Impact');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `sustainability_impact` SET TAGS ('dbx_value_regex' = 'positive|neutral|negative|not_assessed');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `technical_feasibility_assessment` SET TAGS ('dbx_business_glossary_term' = 'Technical Feasibility Assessment');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `technical_feasibility_assessment` SET TAGS ('dbx_value_regex' = 'feasible|challenging|not_feasible|requires_testing');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `trigger` SET TAGS ('dbx_business_glossary_term' = 'Revision Trigger');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `trigger` SET TAGS ('dbx_value_regex' = 'design_review|fit_session|commercial_direction|cost_reduction|technical_feasibility|sustainability_requirement');
ALTER TABLE `apparel_fashion_ecm`.`design`.`revision` ALTER COLUMN `trim_change_description` SET TAGS ('dbx_business_glossary_term' = 'Trim Change Description');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` SET TAGS ('dbx_subdomain' = 'style_development');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `fabric_swatch_id` SET TAGS ('dbx_business_glossary_term' = 'Fabric Swatch ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `designer_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Designer ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `higg_index_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Higg Index Assessment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `supplier_esg_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Esg Assessment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `supplier_mill_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Mill ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `sustainable_material_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Material Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `alternate_fabric_swatch_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `adoption_decision` SET TAGS ('dbx_business_glossary_term' = 'Adoption Decision');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `adoption_decision` SET TAGS ('dbx_value_regex' = 'selected|shortlisted|rejected|pending');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `care_instructions` SET TAGS ('dbx_business_glossary_term' = 'Care Instructions');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `collection_name` SET TAGS ('dbx_business_glossary_term' = 'Collection Name');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `color_code` SET TAGS ('dbx_business_glossary_term' = 'Color Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `color_hex_value` SET TAGS ('dbx_business_glossary_term' = 'Color Hexadecimal Value');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `color_name` SET TAGS ('dbx_business_glossary_term' = 'Color Name');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `designer_evaluation_notes` SET TAGS ('dbx_business_glossary_term' = 'Designer Evaluation Notes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `digital_file_path` SET TAGS ('dbx_business_glossary_term' = 'Digital File Path');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `estimated_cost_per_meter` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Per Meter');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `estimated_cost_per_meter` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `fabric_finish` SET TAGS ('dbx_business_glossary_term' = 'Fabric Finish');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `fabric_type` SET TAGS ('dbx_business_glossary_term' = 'Fabric Type');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `fabric_type` SET TAGS ('dbx_value_regex' = 'woven|knit|denim|jersey|technical|non-woven');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `fabric_weight_gsm` SET TAGS ('dbx_business_glossary_term' = 'Fabric Weight Grams per Square Meter (GSM)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `fabric_width_cm` SET TAGS ('dbx_business_glossary_term' = 'Fabric Width Centimeters');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `fiber_composition` SET TAGS ('dbx_business_glossary_term' = 'Fiber Composition');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `moq_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Unit of Measure');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `moq_unit_of_measure` SET TAGS ('dbx_value_regex' = 'meters|yards|kilograms');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `performance_attributes` SET TAGS ('dbx_business_glossary_term' = 'Performance Attributes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `physical_swatch_location` SET TAGS ('dbx_business_glossary_term' = 'Physical Swatch Location');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `product_category_suitability` SET TAGS ('dbx_business_glossary_term' = 'Product Category Suitability');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^(SS|FW|AW|SP)[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `supplier_fabric_reference` SET TAGS ('dbx_business_glossary_term' = 'Supplier Fabric Reference');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `sustainability_score` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Score');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `swatch_code` SET TAGS ('dbx_business_glossary_term' = 'Swatch Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `swatch_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `swatch_format` SET TAGS ('dbx_business_glossary_term' = 'Swatch Format');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `swatch_format` SET TAGS ('dbx_value_regex' = 'physical|digital|both');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `swatch_name` SET TAGS ('dbx_business_glossary_term' = 'Swatch Name');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `swatch_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Swatch Receipt Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `swatch_status` SET TAGS ('dbx_business_glossary_term' = 'Swatch Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `swatch_status` SET TAGS ('dbx_value_regex' = 'active|archived|discontinued|expired');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `texture_description` SET TAGS ('dbx_business_glossary_term' = 'Texture Description');
ALTER TABLE `apparel_fashion_ecm`.`design`.`fabric_swatch` ALTER COLUMN `trend_alignment_tags` SET TAGS ('dbx_business_glossary_term' = 'Trend Alignment Tags');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` SET TAGS ('dbx_subdomain' = 'style_development');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Design Asset ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `asset_uploaded_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Uploaded By User ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `asset_uploaded_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `asset_uploaded_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `designer_id` SET TAGS ('dbx_business_glossary_term' = 'Designer Owner ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `superseded_by_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Asset ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `original_asset_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|not_submitted');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Archived Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `asset_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_value_regex' = 'active|archived|restricted|pending_approval|rejected|expired');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_value_regex' = 'sketch|cad_export|print_file|lookbook_image|runway_photo|reference_image');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `checksum_hash` SET TAGS ('dbx_business_glossary_term' = 'Checksum Hash');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `color_palette_hex_codes` SET TAGS ('dbx_business_glossary_term' = 'Color Palette Hexadecimal (HEX) Codes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `copyright_attribution` SET TAGS ('dbx_business_glossary_term' = 'Copyright Attribution');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `fabric_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Fabric Reference Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `gender_target` SET TAGS ('dbx_business_glossary_term' = 'Gender Target');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `gender_target` SET TAGS ('dbx_value_regex' = 'mens|womens|unisex|kids|infant');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `gender_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `gender_target` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `inspiration_source` SET TAGS ('dbx_business_glossary_term' = 'Inspiration Source');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Is Confidential Flag');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `is_featured` SET TAGS ('dbx_business_glossary_term' = 'Is Featured Flag');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `price_tier` SET TAGS ('dbx_business_glossary_term' = 'Price Tier');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `price_tier` SET TAGS ('dbx_value_regex' = 'luxury|premium|mid_tier|value|entry');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `storage_location_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Type');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `storage_location_type` SET TAGS ('dbx_value_regex' = 'cloud|on_premise|hybrid|archive');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `storage_path` SET TAGS ('dbx_business_glossary_term' = 'Storage Path');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `storage_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Asset Tags');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_business_glossary_term' = 'Thumbnail Uniform Resource Locator (URL)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `trend_theme` SET TAGS ('dbx_business_glossary_term' = 'Trend Theme');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `upload_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Upload Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `usage_rights` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `usage_rights` SET TAGS ('dbx_value_regex' = 'internal_only|licensed|royalty_free|restricted|public_domain');
ALTER TABLE `apparel_fashion_ecm`.`design`.`asset` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` SET TAGS ('dbx_subdomain' = 'approval_governance');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `designer_id` SET TAGS ('dbx_business_glossary_term' = 'Designer Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `designer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Manager Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `designer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `designer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `designer_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `designer_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `designer_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `reports_to_designer_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `assigned_categories` SET TAGS ('dbx_business_glossary_term' = 'Assigned Product Categories');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `awards_recognition` SET TAGS ('dbx_business_glossary_term' = 'Awards and Recognition');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `certifications` SET TAGS ('dbx_business_glossary_term' = 'Professional Certifications');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `collaboration_notes` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Notes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `design_team_assignment` SET TAGS ('dbx_business_glossary_term' = 'Design Team Assignment');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `designer_code` SET TAGS ('dbx_business_glossary_term' = 'Designer Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `designer_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `designer_status` SET TAGS ('dbx_business_glossary_term' = 'Designer Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `designer_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|terminated|suspended');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `designer_type` SET TAGS ('dbx_business_glossary_term' = 'Designer Type');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `designer_type` SET TAGS ('dbx_value_regex' = 'apparel_designer|footwear_designer|accessories_designer|print_designer|technical_designer|pattern_maker');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `education_background` SET TAGS ('dbx_business_glossary_term' = 'Education Background');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Designer Email Address');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time_employee|freelance|contractor|intern|consultant');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Designer Full Name');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Designer Hire Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Designer Flag');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `language_skills` SET TAGS ('dbx_business_glossary_term' = 'Language Skills');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `location_office` SET TAGS ('dbx_business_glossary_term' = 'Designer Office Location');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Designer Phone Number');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `portfolio_reference_url` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Reference Uniform Resource Locator (URL)');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Designer Preferred Name');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `seniority_level` SET TAGS ('dbx_business_glossary_term' = 'Designer Seniority Level');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `seniority_level` SET TAGS ('dbx_value_regex' = 'junior|mid_level|senior|lead|principal|director');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `software_proficiency` SET TAGS ('dbx_business_glossary_term' = 'Software Proficiency');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `specialization` SET TAGS ('dbx_business_glossary_term' = 'Designer Specialization');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `sustainability_focus_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Focus Flag');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Designer Termination Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`designer` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Experience');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` SET TAGS ('dbx_subdomain' = 'creative_ideation');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `inspiration_id` SET TAGS ('dbx_business_glossary_term' = 'Design Inspiration ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Concept ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `designer_id` SET TAGS ('dbx_business_glossary_term' = 'Logged By Designer ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `trend_item_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Trend Item ID');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `derived_from_inspiration_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `additional_media_urls` SET TAGS ('dbx_business_glossary_term' = 'Additional Media URLs');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `adoption_status` SET TAGS ('dbx_business_glossary_term' = 'Adoption Status');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `adoption_status` SET TAGS ('dbx_value_regex' = 'logged|under_review|adopted|archived|rejected');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `color_palette` SET TAGS ('dbx_business_glossary_term' = 'Color Palette');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `construction_details` SET TAGS ('dbx_business_glossary_term' = 'Construction Details');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `copyright_attribution` SET TAGS ('dbx_business_glossary_term' = 'Copyright Attribution');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `cultural_influence` SET TAGS ('dbx_business_glossary_term' = 'Cultural Influence');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `design_notes` SET TAGS ('dbx_business_glossary_term' = 'Design Notes');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `designer_brand` SET TAGS ('dbx_business_glossary_term' = 'Designer Brand');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `fabric_elements` SET TAGS ('dbx_business_glossary_term' = 'Fabric Elements');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `gender_target` SET TAGS ('dbx_business_glossary_term' = 'Gender Target');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `gender_target` SET TAGS ('dbx_value_regex' = 'mens|womens|unisex|kids|all');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `gender_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `gender_target` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `geographic_origin` SET TAGS ('dbx_business_glossary_term' = 'Geographic Origin');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `image_reference_url` SET TAGS ('dbx_business_glossary_term' = 'Image Reference URL');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `inspiration_code` SET TAGS ('dbx_business_glossary_term' = 'Inspiration Code');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `inspiration_description` SET TAGS ('dbx_business_glossary_term' = 'Inspiration Description');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Is Confidential');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `observation_date` SET TAGS ('dbx_business_glossary_term' = 'Observation Date');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `price_tier_relevance` SET TAGS ('dbx_business_glossary_term' = 'Price Tier Relevance');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `price_tier_relevance` SET TAGS ('dbx_value_regex' = 'luxury|premium|mid_tier|value|all');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `print_pattern_theme` SET TAGS ('dbx_business_glossary_term' = 'Print Pattern Theme');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `product_category_relevance` SET TAGS ('dbx_business_glossary_term' = 'Product Category Relevance');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `relevance_score` SET TAGS ('dbx_business_glossary_term' = 'Relevance Score');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `season_relevance` SET TAGS ('dbx_business_glossary_term' = 'Season Relevance');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `season_year` SET TAGS ('dbx_business_glossary_term' = 'Season Year');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `silhouette_elements` SET TAGS ('dbx_business_glossary_term' = 'Silhouette Elements');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `source_name` SET TAGS ('dbx_business_glossary_term' = 'Source Name');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Source Type');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `styling_elements` SET TAGS ('dbx_business_glossary_term' = 'Styling Elements');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `sustainability_indicator` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Indicator');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Tags');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Inspiration Title');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `trend_alignment` SET TAGS ('dbx_business_glossary_term' = 'Trend Alignment');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `usage_rights` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights');
ALTER TABLE `apparel_fashion_ecm`.`design`.`inspiration` ALTER COLUMN `usage_rights` SET TAGS ('dbx_value_regex' = 'internal_only|licensed|public_domain|restricted');
