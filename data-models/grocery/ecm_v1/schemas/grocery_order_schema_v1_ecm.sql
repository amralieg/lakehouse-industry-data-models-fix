-- Schema for Domain: order | Business: Grocery | Version: v1_ecm
-- Generated on: 2026-05-04 18:34:58

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `grocery_ecm`.`order` COMMENT 'Unified customer order management across all channels — digital commerce order capture, in-store POS transactions, click-and-collect, curbside pickup, last-mile delivery, and pharmacy prescription fills. Manages order headers, line items, payments, refunds, delivery logistics, digital storefronts, carts, checkout, and order lifecycle tracking.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `grocery_ecm`.`order`.`order_delivery_route` (
    `order_delivery_route_id` BIGINT COMMENT 'Unique identifier for the delivery route. Primary key for this entity.',
    `associate_id` BIGINT COMMENT 'Identifier of the driver assigned to execute this delivery route.',
    `dc_facility_id` BIGINT COMMENT 'Identifier of the distribution center, store, or micro-fulfillment center from which this delivery route originates.',
    `actual_end_time` TIMESTAMP COMMENT 'The actual date and time when the driver completed this delivery route.',
    `actual_start_time` TIMESTAMP COMMENT 'The actual date and time when the driver began executing this delivery route.',
    `carrier_name` STRING COMMENT 'Name of the carrier or fleet operator responsible for executing this delivery route.',
    `carrier_type` STRING COMMENT 'Classification of the carrier executing the route, distinguishing between internal fleet operations and external carrier partnerships.. Valid values are `internal_fleet|third_party_carrier|gig_economy|hybrid`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this delivery route record was first created in the system.',
    `dispatch_date` DATE COMMENT 'The date on which this delivery route was dispatched or scheduled for execution.',
    `dispatch_timestamp` TIMESTAMP COMMENT 'The precise date and time when the route was dispatched to the driver, marking the start of route execution.',
    `dispatch_window_end` TIMESTAMP COMMENT 'The end of the time window during which this route batch was dispatched for delivery.',
    `dispatch_window_start` TIMESTAMP COMMENT 'The start of the time window during which this route batch was dispatched for delivery.',
    `estimated_fuel_cost` DECIMAL(18,2) COMMENT 'The estimated fuel cost in USD for completing this delivery route based on planned mileage and current fuel rates.',
    `estimated_labor_cost` DECIMAL(18,2) COMMENT 'The estimated labor cost in USD for the driver to complete this delivery route based on planned duration and wage rates.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this delivery route record was last updated in the system.',
    `planned_end_time` TIMESTAMP COMMENT 'The planned date and time when the driver is scheduled to complete this delivery route.',
    `planned_start_time` TIMESTAMP COMMENT 'The planned date and time when the driver is scheduled to begin executing this delivery route.',
    `route_notes` STRING COMMENT 'Free-text notes or special instructions for the driver regarding this delivery route, such as traffic alerts or access restrictions.',
    `route_number` STRING COMMENT 'Business identifier for the delivery route, externally known and used for operational tracking and driver assignment.',
    `route_optimization_algorithm` STRING COMMENT 'The name or version of the route optimization algorithm used by JDA TMS to generate this route plan.',
    `route_sequence_version` STRING COMMENT 'Version number tracking route resequencing events, incremented each time the stop sequence is modified during execution.',
    `route_status` STRING COMMENT 'Current lifecycle status of the delivery route indicating its operational state.. Valid values are `planned|dispatched|in_progress|completed|partial|cancelled`',
    `route_type` STRING COMMENT 'Classification of the delivery route based on the type of fulfillment service being provided.. Valid values are `last_mile_delivery|curbside_pickup|click_and_collect|pharmacy_delivery|mixed`',
    `service_level` STRING COMMENT 'The delivery service level commitment associated with this route, defining customer expectations for delivery speed.. Valid values are `same_day|next_day|two_day|standard|express`',
    `temperature_zone` STRING COMMENT 'The temperature control requirement for this delivery route, critical for cold chain compliance in grocery delivery.. Valid values are `ambient|refrigerated|frozen|multi_temp`',
    `total_actual_duration_minutes` STRING COMMENT 'The actual duration in minutes taken to complete this delivery route from start to finish.',
    `total_actual_miles` DECIMAL(18,2) COMMENT 'The actual distance in miles traveled during the execution of this delivery route, captured from vehicle telematics or GPS.',
    `total_completed_stops` STRING COMMENT 'The actual number of delivery stops successfully completed on this route.',
    `total_failed_stops` STRING COMMENT 'The number of delivery stops that failed or could not be completed on this route.',
    `total_order_count` STRING COMMENT 'The total number of customer orders included in this delivery route across all stops.',
    `total_package_count` STRING COMMENT 'The total number of packages or totes loaded onto the vehicle for this delivery route.',
    `total_planned_duration_minutes` STRING COMMENT 'The total planned duration in minutes for completing this delivery route, including drive time and stop dwell time.',
    `total_planned_miles` DECIMAL(18,2) COMMENT 'The total distance in miles planned for this delivery route based on route optimization algorithms.',
    `total_planned_stops` STRING COMMENT 'The total number of delivery stops planned for this route at the time of route creation.',
    `total_volume_cubic_feet` DECIMAL(18,2) COMMENT 'The total volume in cubic feet of all packages and orders on this delivery route.',
    `total_weight_lbs` DECIMAL(18,2) COMMENT 'The total weight in pounds of all packages and orders on this delivery route.',
    `vehicle_code` BIGINT COMMENT 'Identifier of the vehicle assigned to this delivery route.',
    CONSTRAINT pk_order_delivery_route PRIMARY KEY(`order_delivery_route_id`)
) COMMENT 'Optimized delivery route plan and its constituent stops, generated by JDA TMS for a batch of delivery orders assigned to a single driver/vehicle for a given dispatch window. At route level: captures route ID, dispatch date, vehicle ID, driver reference, total planned stops, total planned miles, total planned duration, actual start/end timestamps, route status (planned, in-progress, completed, partial), and carrier/fleet type. At stop level (embedded detail): captures stop sequence, linked delivery order, planned/actual arrival and departure times, stop status (pending, completed, failed, skipped), failure reason code, proof-of-delivery reference, and dwell time in minutes. Enables route efficiency analysis, stop-level SLA tracking, driver performance, failed delivery root cause analysis, route resequencing, and LMD cost management. Stop-level detail is modeled within this entity as route and stops share a lifecycle and are always managed together.';

CREATE OR REPLACE TABLE `grocery_ecm`.`order`.`catalog_item` (
    `catalog_item_id` BIGINT COMMENT 'Primary key for catalog_item',
    `brand_id` BIGINT COMMENT 'FK to product.brand',
    `department_id` BIGINT COMMENT 'FK to store.department',
    `age_restricted_flag` BOOLEAN COMMENT 'Indicates whether this item requires age verification at checkout (e.g., alcohol, tobacco, certain medications).',
    `average_customer_rating` DECIMAL(18,2) COMMENT 'Average customer rating for this item on a scale of 0.00 to 5.00, calculated from customer reviews.',
    `category_path` STRING COMMENT 'Hierarchical category path for navigation and filtering (e.g., Grocery > Dairy > Milk > Whole Milk).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this digital catalog item record was first created in the system.',
    `digital_availability_status` STRING COMMENT 'Current availability status of the item in the digital catalog. Controls whether the item can be added to cart.. Valid values are `available|out_of_stock|discontinued|coming_soon|preorder|backorder`',
    `digital_discontinuation_date` DATE COMMENT 'The date this item was or will be removed from the digital catalog. Null if still active.',
    `digital_display_price` DECIMAL(18,2) COMMENT 'The price displayed to customers on the digital storefront. May differ from store-specific pricing.',
    `digital_item_description` STRING COMMENT 'Detailed product description for the digital catalog, including features, benefits, ingredients, and usage instructions.',
    `digital_item_title` STRING COMMENT 'The customer-facing title displayed on the digital storefront. Optimized for online presentation and may differ from physical product name.',
    `digital_launch_date` DATE COMMENT 'The date this item was first made available in the digital catalog.',
    `ebt_eligible_flag` BOOLEAN COMMENT 'Indicates whether this item can be purchased using Electronic Benefits Transfer payment methods.',
    `gtin` STRING COMMENT 'Global Trade Item Number assigned by GS1 for worldwide product identification. May be 8, 12, 13, or 14 digits.. Valid values are `^[0-9]{8,14}$`',
    `hero_image_alt_text` STRING COMMENT 'Alternative text for the hero image, used for accessibility (screen readers) and SEO purposes.',
    `hero_image_url` STRING COMMENT 'Primary product image URL displayed prominently on product detail pages and search results.. Valid values are `^https?://.*.(jpg|jpeg|png|webp)$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this digital catalog item record was last updated.',
    `loyalty_points_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base loyalty points earned when purchasing this item. Default is 1.0.',
    `minimum_age_required` STRING COMMENT 'Minimum age in years required to purchase this item. Null if no age restriction applies.',
    `online_exclusive_flag` BOOLEAN COMMENT 'Indicates whether this item is available exclusively through digital channels and not sold in physical stores.',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicates whether this item carries USDA Organic certification.',
    `package_size` STRING COMMENT 'The size or quantity of the package as displayed to customers (e.g., 12 oz, 1 gallon, 6-pack).',
    `perishable_flag` BOOLEAN COMMENT 'Indicates whether this item is perishable and requires temperature-controlled handling and expedited delivery.',
    `price_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the digital display price.. Valid values are `^[A-Z]{3}$`',
    `private_label_flag` BOOLEAN COMMENT 'Indicates whether this item is a store-owned brand (private label) product rather than a national Consumer Packaged Goods (CPG) brand.',
    `promotion_eligible_flag` BOOLEAN COMMENT 'Indicates whether this item can be included in promotional campaigns and discounts.',
    `search_keywords` STRING COMMENT 'Comma-separated list of keywords and phrases used to improve internal site search relevance and product discoverability.',
    `seo_meta_description` STRING COMMENT 'HTML meta description tag content that appears in search engine results. Typically 150-160 characters.',
    `seo_meta_title` STRING COMMENT 'HTML meta title tag content optimized for search engine results pages. Typically 50-60 characters.',
    `sku` STRING COMMENT 'The physical product SKU that this digital catalog item represents. Links the digital presentation layer to the physical product domain.',
    `snap_eligible_flag` BOOLEAN COMMENT 'Indicates whether this item is eligible for purchase using SNAP Electronic Benefits Transfer (EBT) benefits.',
    `source_system` STRING COMMENT 'The source system that provided this digital catalog item data (e.g., Salesforce Commerce Cloud, Oracle Retail).',
    `substitution_eligible_flag` BOOLEAN COMMENT 'Indicates whether this item can be substituted with an alternative product during order fulfillment if out of stock.',
    `temperature_zone` STRING COMMENT 'Required storage and transportation temperature zone for this item. Critical for cold chain logistics.. Valid values are `ambient|refrigerated|frozen`',
    `thumbnail_image_url` STRING COMMENT 'Smaller thumbnail image URL used in product listings, carousels, and grid views.. Valid values are `^https?://.*.(jpg|jpeg|png|webp)$`',
    `total_review_count` STRING COMMENT 'Total number of customer reviews submitted for this item.',
    `unit_of_measure` STRING COMMENT 'The unit in which this item is sold (e.g., each, pound, ounce, gallon, liter).',
    `upc` STRING COMMENT '12-digit Universal Product Code for the item, used for barcode scanning and product identification.. Valid values are `^[0-9]{12}$`',
    `wic_eligible_flag` BOOLEAN COMMENT 'Indicates whether this item is eligible for purchase using WIC program benefits.',
    CONSTRAINT pk_catalog_item PRIMARY KEY(`catalog_item_id`)
) COMMENT 'Individual SKU-level entry within the digital catalog, capturing online-specific attributes such as digital item title, hero image URL, alt text, SEO metadata, search keywords, substitution eligibility, age-restricted flag, SNAP/EBT eligibility flag, WIC eligibility flag, and digital availability status. Bridges the physical product domain SKU to the commerce presentation layer.';

-- ========= TAGS =========
ALTER SCHEMA `grocery_ecm`.`order` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `grocery_ecm`.`order` SET TAGS ('dbx_domain' = 'order');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` SET TAGS ('dbx_subdomain' = 'order_core');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `order_delivery_route_id` SET TAGS ('dbx_business_glossary_term' = 'Order Delivery Route ID');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility ID');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `carrier_type` SET TAGS ('dbx_business_glossary_term' = 'Carrier Type');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `carrier_type` SET TAGS ('dbx_value_regex' = 'internal_fleet|third_party_carrier|gig_economy|hybrid');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `dispatch_date` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Date');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `dispatch_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Timestamp');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `dispatch_window_end` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Window End');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `dispatch_window_start` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Window Start');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `estimated_fuel_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Fuel Cost');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `estimated_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Cost');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `planned_end_time` SET TAGS ('dbx_business_glossary_term' = 'Planned End Time');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `planned_start_time` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Time');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `route_notes` SET TAGS ('dbx_business_glossary_term' = 'Route Notes');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `route_number` SET TAGS ('dbx_business_glossary_term' = 'Route Number');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `route_optimization_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Route Optimization Algorithm');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `route_sequence_version` SET TAGS ('dbx_business_glossary_term' = 'Route Sequence Version');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `route_status` SET TAGS ('dbx_business_glossary_term' = 'Route Status');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `route_status` SET TAGS ('dbx_value_regex' = 'planned|dispatched|in_progress|completed|partial|cancelled');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `route_type` SET TAGS ('dbx_business_glossary_term' = 'Route Type');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `route_type` SET TAGS ('dbx_value_regex' = 'last_mile_delivery|curbside_pickup|click_and_collect|pharmacy_delivery|mixed');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'same_day|next_day|two_day|standard|express');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|multi_temp');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `total_actual_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Actual Duration Minutes');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `total_actual_miles` SET TAGS ('dbx_business_glossary_term' = 'Total Actual Miles');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `total_completed_stops` SET TAGS ('dbx_business_glossary_term' = 'Total Completed Stops');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `total_failed_stops` SET TAGS ('dbx_business_glossary_term' = 'Total Failed Stops');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `total_order_count` SET TAGS ('dbx_business_glossary_term' = 'Total Order Count');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `total_package_count` SET TAGS ('dbx_business_glossary_term' = 'Total Package Count');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `total_planned_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Duration Minutes');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `total_planned_miles` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Miles');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `total_planned_stops` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Stops');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `total_volume_cubic_feet` SET TAGS ('dbx_business_glossary_term' = 'Total Volume Cubic Feet');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `total_weight_lbs` SET TAGS ('dbx_business_glossary_term' = 'Total Weight Pounds');
ALTER TABLE `grocery_ecm`.`order`.`order_delivery_route` ALTER COLUMN `vehicle_code` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` SET TAGS ('dbx_subdomain' = 'order_core');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Identifier');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `brand_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `department_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `age_restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'Age Restricted Flag');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `average_customer_rating` SET TAGS ('dbx_business_glossary_term' = 'Average Customer Rating');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `category_path` SET TAGS ('dbx_business_glossary_term' = 'Category Path');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `digital_availability_status` SET TAGS ('dbx_business_glossary_term' = 'Digital Availability Status');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `digital_availability_status` SET TAGS ('dbx_value_regex' = 'available|out_of_stock|discontinued|coming_soon|preorder|backorder');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `digital_discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Digital Discontinuation Date');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `digital_display_price` SET TAGS ('dbx_business_glossary_term' = 'Digital Display Price');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `digital_item_description` SET TAGS ('dbx_business_glossary_term' = 'Digital Item Description');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `digital_item_title` SET TAGS ('dbx_business_glossary_term' = 'Digital Item Title');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `digital_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Digital Launch Date');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `ebt_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Benefits Transfer (EBT) Eligible Flag');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `hero_image_alt_text` SET TAGS ('dbx_business_glossary_term' = 'Hero Image Alt Text');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `hero_image_url` SET TAGS ('dbx_business_glossary_term' = 'Hero Image URL');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `hero_image_url` SET TAGS ('dbx_value_regex' = '^https?://.*.(jpg|jpeg|png|webp)$');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `loyalty_points_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Multiplier');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `minimum_age_required` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Required');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `online_exclusive_flag` SET TAGS ('dbx_business_glossary_term' = 'Online Exclusive Flag');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `package_size` SET TAGS ('dbx_business_glossary_term' = 'Package Size');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `perishable_flag` SET TAGS ('dbx_business_glossary_term' = 'Perishable Flag');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `price_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Price Currency Code');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `price_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `private_label_flag` SET TAGS ('dbx_business_glossary_term' = 'Private Label Flag');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `promotion_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Eligible Flag');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `search_keywords` SET TAGS ('dbx_business_glossary_term' = 'Search Keywords');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `seo_meta_description` SET TAGS ('dbx_business_glossary_term' = 'Search Engine Optimization (SEO) Meta Description');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `seo_meta_title` SET TAGS ('dbx_business_glossary_term' = 'Search Engine Optimization (SEO) Meta Title');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `snap_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Supplemental Nutrition Assistance Program (SNAP) Eligible Flag');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `substitution_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Eligible Flag');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `thumbnail_image_url` SET TAGS ('dbx_business_glossary_term' = 'Thumbnail Image URL');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `thumbnail_image_url` SET TAGS ('dbx_value_regex' = '^https?://.*.(jpg|jpeg|png|webp)$');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `total_review_count` SET TAGS ('dbx_business_glossary_term' = 'Total Review Count');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `grocery_ecm`.`order`.`catalog_item` ALTER COLUMN `wic_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Women Infants and Children (WIC) Eligible Flag');
