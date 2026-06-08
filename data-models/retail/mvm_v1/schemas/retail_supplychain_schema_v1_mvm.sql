-- Schema for Domain: supplychain | Business: Retail | Version: v1_mvm
-- Generated on: 2026-05-04 13:27:44

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `retail_ecm`.`supplychain` COMMENT 'Manages end-to-end supply chain planning and execution from demand forecasting through distribution center operations, including facility management, warehouse workflows, inbound/outbound logistics, replenishment planning, purchase order lifecycle, cross-docking, and supply chain performance monitoring.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `retail_ecm`.`supplychain`.`replenishment_plan` (
    `replenishment_plan_id` BIGINT COMMENT 'Unique surrogate identifier for each replenishment plan record in the Silver layer lakehouse. Primary key for the replenishment_plan data product.',
    `assortment_plan_id` BIGINT COMMENT 'Foreign key linking to merchandising.assortment_plan. Business justification: Assortment plans define active SKUs, depth targets, and planned weeks of supply that directly govern replenishment logic. Retail replenishment systems must know which assortment plan authorized each S',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: Retail Open-to-Buy (OTB) budgeting requires replenishment plans to consume and track against finance_budget OTB allocations. replenishment_plan.otb_consumed and finance_budget.otb_amount are the two s',
    `cost_price_id` BIGINT COMMENT 'Foreign key linking to pricing.cost_price. Business justification: Replenishment order valuation uses the current landed cost price to calculate planned_order_value and assess margin. Retail supply planners reference cost_price for accurate order economics. unit_cost',
    `demand_forecast_id` BIGINT COMMENT 'Reference to the demand forecast plan from Blue Yonder Demand Planning that drove the generation of this replenishment plan. Enables traceability from replenishment decision back to the underlying demand signal.',
    `inventory_node_id` BIGINT COMMENT 'Reference to the supply chain node (store, Distribution Center (DC), or Micro-Fulfillment Center (MFC)) for which this replenishment plan is generated. Identifies the destination receiving location in the replenishment network.',
    `merch_plan_id` BIGINT COMMENT 'Foreign key linking to merchandising.merch_plan. Business justification: Replenishment plans must reconcile against merchandise plan OTB budgets and planned receipt amounts. Retail S&OP process requires planners to validate that replenishment orders stay within merch plan ',
    `plan_id` BIGINT COMMENT 'Foreign key linking to supplychain.plan. Business justification: A replenishment plan for a specific SKU/node is generated within the context of a broader aggregated supply plan. Linking replenishment_plan.plan_id → plan.plan_id provides the parent-child traceabili',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Retail replenishment planners create promotional replenishment plans (event buys / inventory builds) tied to specific campaigns. The existing promotion_flag on replenishment_plan signals this need; ',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: Replenishment plans in retail are season-scoped — seasonal items have distinct reorder points, safety stock levels, and plan horizon dates tied to season buy deadlines and clearance exit dates. Season',
    `sku_id` BIGINT COMMENT 'Reference to the specific SKU (Stock Keeping Unit) for which this replenishment plan is generated. The SKU is the primary product-level identifier used in replenishment planning across stores, DCs, and MFCs.',
    `vendor_id` BIGINT COMMENT 'Reference to the primary supplier responsible for fulfilling this replenishment plan. Links to the supplier master for MOQ enforcement, lead time, and EDI ordering constraints.',
    `approved_order_qty` DECIMAL(18,2) COMMENT 'The final order quantity approved by the buyer or auto-approved by the system after MOQ, order multiple, and buyer override adjustments. This is the quantity that will be transmitted to the supplier via EDI or purchase order.',
    `buyer_override_flag` BOOLEAN COMMENT 'Indicates whether a buyer has manually overridden the system-generated planned order quantity or parameters. True = buyer override applied; False = system-generated values accepted as-is. Supports audit trail for manual interventions.',
    `created_timestamp` TIMESTAMP COMMENT 'Audit timestamp recording when this replenishment plan record was first persisted in the Silver layer lakehouse. Supports data lineage and audit trail requirements.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the planned order value and unit cost are expressed (e.g., USD, GBP, EUR). Required for multi-currency retail operations.. Valid values are `^[A-Z]{3}$`',
    `current_on_hand_qty` DECIMAL(18,2) COMMENT 'The quantity of the SKU physically on hand at the supply node at the time the replenishment plan was generated. Sourced from Manhattan Associates WMS or SAP S/4HANA WM. Used as the starting inventory position for plan calculations.',
    `demand_variability_factor` DECIMAL(18,2) COMMENT 'A statistical measure of demand variability (coefficient of variation or standard deviation of demand) used by the planning engine to size safety stock. Higher values indicate more volatile demand and result in larger safety stock buffers.',
    `fill_rate_target_pct` DECIMAL(18,2) COMMENT 'The target order fill rate percentage (Fill Rate) for this replenishment plan, representing the percentage of demand that should be fulfilled from available inventory. Used as a supply chain performance KPI (KPI) target for this SKU-node combination.',
    `forecasted_demand_qty` DECIMAL(18,2) COMMENT 'The total forecasted demand quantity for the SKU at the supply node over the plan horizon, as generated by Blue Yonder Demand Planning. The primary input to the planned order quantity calculation.',
    `lead_time_days` STRING COMMENT 'The number of calendar days from purchase order placement to expected receipt at the supply node, as defined in the supplier contract or purchasing info record. Used to calculate reorder points and plan order release dates.',
    `min_order_value` DECIMAL(18,2) COMMENT 'The minimum monetary value of a purchase order required by the supplier, expressed in the operating currency. Replenishment plans that do not meet the minimum order value threshold are consolidated or flagged for buyer action.',
    `moq` DECIMAL(18,2) COMMENT 'The minimum number of units that must be ordered from the supplier per purchase order line, as enforced by supplier contract terms. Replenishment plans with planned_order_qty below MOQ are rounded up or flagged for buyer review.',
    `moq_compliance_flag` BOOLEAN COMMENT 'Indicates whether the planned order quantity meets or exceeds the suppliers Minimum Order Quantity (MOQ) constraint. True = compliant; False = below MOQ threshold and requires buyer review or order consolidation before release.',
    `node_type` STRING COMMENT 'Classifies the type of supply chain node receiving the replenishment. Values: store (retail store), dc (Distribution Center), mfc (Micro-Fulfillment Center), dark_store (fulfillment-only location). Drives replenishment logic and lead time parameters.. Valid values are `store|dc|mfc|dark_store`',
    `on_order_qty` DECIMAL(18,2) COMMENT 'The quantity of the SKU already on open purchase orders or in-transit to the supply node at the time of plan generation. Included in the net inventory position calculation to avoid over-ordering.',
    `order_multiple` DECIMAL(18,2) COMMENT 'The unit increment in which the SKU must be ordered (e.g., case pack size, pallet quantity). Planned order quantities are rounded up to the nearest order multiple before purchase order generation.',
    `order_release_date` DATE COMMENT 'The date on which the replenishment plan is scheduled to be released as a purchase order to the supplier. Calculated by subtracting lead time from the planned receipt date. Drives the purchasing execution calendar.',
    `override_reason_code` STRING COMMENT 'Standardized reason code explaining why a buyer manually overrode the system-generated replenishment plan. Populated only when buyer_override_flag is True. Supports root cause analysis of planning accuracy and buyer behavior patterns.. Valid values are `promotional_uplift|supplier_constraint|excess_inventory|demand_correction|system_error|other`',
    `plan_generation_timestamp` TIMESTAMP COMMENT 'The date and time when the replenishment plan was generated by the planning engine (Blue Yonder or equivalent). Represents the principal business event timestamp for this transaction. Used for plan freshness assessment and demand signal alignment.',
    `plan_horizon_end_date` DATE COMMENT 'The end date of the planning horizon covered by this replenishment plan. Defines the end of the demand forecast window. Together with plan_horizon_start_date, bounds the coverage period for this plan.',
    `plan_horizon_start_date` DATE COMMENT 'The start date of the planning horizon covered by this replenishment plan. Defines the beginning of the demand forecast window used to generate the planned order quantity.',
    `plan_status` STRING COMMENT 'Current lifecycle state of the replenishment plan within the planning and execution workflow. Drives automated ordering triggers and buyer review queues. [ENUM-REF-CANDIDATE: draft|proposed|approved|released|in_progress|completed|cancelled — promote to reference product]',
    `plan_type` STRING COMMENT 'Categorizes the origin and nature of the replenishment plan. Automated plans are system-generated by Blue Yonder; manual plans are buyer-created; override plans supersede automated recommendations; emergency plans address urgent stockout risk.. Valid values are `automated|manual|override|emergency`',
    `planned_order_qty` DECIMAL(18,2) COMMENT 'The quantity of units recommended by the planning engine to be ordered for this SKU at the specified supply node. Subject to MOQ and order multiple enforcement before release to purchasing.',
    `planned_order_value` DECIMAL(18,2) COMMENT 'The total monetary value of the planned replenishment order, calculated as planned_order_qty multiplied by unit_cost. Used for Open-to-Buy (OTB) budget management and financial planning.',
    `planned_receipt_date` DATE COMMENT 'The expected date on which the replenishment order is planned to be received at the supply node, calculated as the order release date plus supplier lead time. Used for inventory projection and DC scheduling.',
    `promotion_flag` BOOLEAN COMMENT 'Indicates whether this replenishment plan was generated or adjusted to support a planned promotional event. True = promotion-driven uplift included in forecasted demand; False = baseline replenishment. Links to promotional demand lift in Blue Yonder.',
    `reorder_point` DECIMAL(18,2) COMMENT 'The inventory level (in units) at the supply node at which a replenishment order is triggered. Calculated as safety stock plus expected demand during supplier lead time. Core parameter for reorder-point-based replenishment policies.',
    `replenishment_method` STRING COMMENT 'The replenishment policy calculation method applied to generate this plan. Min/Max triggers orders when inventory falls below minimum; Reorder Point (ROP) uses statistical triggers; Days of Supply targets coverage duration; Vendor Managed Inventory (VMI) delegates to supplier; Cross-Docking bypasses storage; Direct Store Delivery (DSD) is supplier-direct. [ENUM-REF-CANDIDATE: min_max|reorder_point|days_of_supply|vendor_managed|cross_dock|dsd — promote to reference product]. Valid values are `min_max|reorder_point|days_of_supply|vendor_managed|cross_dock|dsd`',
    `safety_stock_method` STRING COMMENT 'The methodology used to calculate the safety stock quantity. Fixed uses a static buffer; Statistical uses demand variability and lead time variance; Days of Supply targets a coverage duration; Service Level Based derives buffer from the target service level percentage.. Valid values are `fixed|statistical|days_of_supply|service_level_based`',
    `safety_stock_qty` DECIMAL(18,2) COMMENT 'The buffer stock quantity maintained at the supply node to protect against demand variability and supply uncertainty. Represents the minimum inventory floor below which replenishment is urgently triggered. Also referred to as buffer stock.',
    `service_level_target_pct` DECIMAL(18,2) COMMENT 'The target in-stock service level percentage used to calculate safety stock and replenishment parameters. Expressed as a percentage (e.g., 95.00 = 95%). Represents the probability of not experiencing a stockout during the replenishment lead time.',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record that generated or last updated this replenishment plan. Supports data lineage and Silver layer provenance tracking. Values: blue_yonder (Blue Yonder Demand Planning), sap_s4hana (SAP S/4HANA MM), orms (Oracle Retail Merchandising System), manual (buyer-created).. Valid values are `blue_yonder|sap_s4hana|orms|manual`',
    `updated_timestamp` TIMESTAMP COMMENT 'Audit timestamp recording when this replenishment plan record was last modified in the Silver layer lakehouse. Tracks buyer overrides, status transitions, and plan revisions.',
    `weeks_of_supply_target` DECIMAL(18,2) COMMENT 'The target number of weeks of inventory coverage (Weeks of Supply / WOS) that the replenishment plan aims to achieve at the supply node after order receipt. Used as a planning horizon parameter for days-of-supply replenishment methods.',
    CONSTRAINT pk_replenishment_plan PRIMARY KEY(`replenishment_plan_id`)
) COMMENT 'Replenishment plans for SKUs across all supply chain nodes (stores, DCs, MFCs), generated by Blue Yonder or equivalent planning engine. Captures planned order quantities, replenishment triggers, reorder points, safety stock levels and policy parameters (calculation method, service level target, demand variability factor), weeks-of-supply targets, plan status, and MOQ enforcement rules (minimum order quantity, order multiples, minimum order value). SSOT for automated replenishment decisions including buffer stock governance and supplier ordering constraints.';

CREATE OR REPLACE TABLE `retail_ecm`.`supplychain`.`demand_forecast` (
    `demand_forecast_id` BIGINT COMMENT 'Unique surrogate identifier for each SKU-level demand forecast record generated by Blue Yonder Demand Planning. Serves as the primary key for this table.',
    `assortment_id` BIGINT COMMENT 'Foreign key linking to product.assortment. Business justification: Assortment-scoped demand forecasting: demand forecasts are only generated for SKU-location combinations that are active in the assortment. Linking demand_forecast to assortment enables planners to val',
    `assortment_plan_id` BIGINT COMMENT 'Foreign key linking to merchandising.assortment_plan. Business justification: New item demand forecasting (is_new_item flag on demand_forecast) is seeded from assortment plans — the assortment_plan defines planned_sku_count and planned_units for new items. Retail demand planner',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Segment-driven demand planning: retail demand planners adjust forecasts based on customer segment behavior (churn risk, purchase frequency, AOV). Linking demand_forecast to the driving customer segmen',
    `location_id` BIGINT COMMENT 'Reference to the store, distribution center (DC), or fulfillment node for which the demand forecast applies. Supports store-level and DC-level replenishment planning.',
    `merch_plan_id` BIGINT COMMENT 'Foreign key linking to merchandising.merch_plan. Business justification: Demand forecasts must reconcile against merchandise plan planned_sales_amount and planned_units as top-down targets. Retail S&OP requires demand planners to show forecast vs. merch plan variance. This',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Retail demand planners build promotional demand forecasts tied to specific campaigns to model promotional lift units. The promotional_lift_units and is_promotional_period attributes on demand_fore',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: Demand forecasts in retail are inherently seasonal — seasonality_index, forecast horizon, and promotional lift are all season-driven. Linking demand_forecast to season enables season-level forecast ac',
    `sku_id` BIGINT COMMENT 'Reference to the specific Stock Keeping Unit (SKU) for which the demand forecast is generated. The SKU is the atomic unit of inventory and demand planning in retail.',
    `baseline_forecast_units` DECIMAL(18,2) COMMENT 'The pure statistical baseline demand forecast in units before any adjustments for promotions, seasonality, or manual overrides. Provides the unadjusted demand signal for comparison against the final consensus forecast.',
    `confidence_level_pct` DECIMAL(18,2) COMMENT 'The statistical confidence level (expressed as a percentage, e.g., 95.00) associated with the forecast interval. Indicates the probability that actual demand will fall within the forecast range. Used to set safety stock levels and replenishment buffers.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this demand forecast record was first written to the Silver Layer lakehouse. Supports data lineage, audit trails, and incremental load processing.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the forecasted revenue amount (e.g., USD, GBP, EUR). Supports multi-currency retail operations across international markets.. Valid values are `^[A-Z]{3}$`',
    `data_source_system` STRING COMMENT 'The operational system of record that provided the demand signal inputs used to generate this forecast (e.g., SAP_CAR for POS transaction data, Salesforce_Commerce_Cloud for e-commerce demand, ORMS for inventory positions). Supports data lineage and source system auditability.',
    `demand_category` STRING COMMENT 'Classification of the SKUs demand pattern used to select the appropriate forecasting model. regular indicates stable, predictable demand; intermittent indicates sporadic demand (Croston model); lumpy indicates irregular high-volume spikes; new_item indicates insufficient history; end_of_life indicates declining/discontinuing SKU.. Valid values are `regular|intermittent|lumpy|new_item|end_of_life`',
    `forecast_bias` DECIMAL(18,2) COMMENT 'The systematic directional error in the forecast, calculated as the mean of (forecasted units minus actual units) over a rolling period. Positive values indicate over-forecasting (excess inventory risk); negative values indicate under-forecasting (stockout risk). Critical for replenishment safety stock calibration.',
    `forecast_generation_timestamp` TIMESTAMP COMMENT 'The exact date and time when this forecast record was generated by the Blue Yonder Demand Planning engine. Serves as the principal business event timestamp for the forecast lifecycle and supports version comparison across planning cycles.',
    `forecast_horizon_weeks` STRING COMMENT 'The total number of weeks into the future covered by this forecast run, measured from the forecast generation date. Determines the planning horizon for replenishment, Open-to-Buy (OTB), and supply chain optimization.',
    `forecast_lower_bound_units` DECIMAL(18,2) COMMENT 'The lower bound of the forecast confidence interval in units at the specified confidence level. Represents the low-demand scenario used for minimum order quantity (MOQ) planning and markdown risk assessment.',
    `forecast_period_end_date` DATE COMMENT 'The last calendar date of the forecast horizon period covered by this record. Together with forecast_period_start_date, defines the time bucket granularity (daily, weekly, monthly).',
    `forecast_period_start_date` DATE COMMENT 'The first calendar date of the forecast horizon period covered by this record. Defines the beginning of the time bucket (day, week, or month) for which demand is forecasted.',
    `forecast_run_number` BIGINT COMMENT 'Identifier for the specific Blue Yonder Demand Planning batch run that generated this forecast record. Enables traceability back to the originating planning cycle and supports audit of forecast lineage.',
    `forecast_status` STRING COMMENT 'Current lifecycle state of the demand forecast record. draft indicates a preliminary run; published indicates the forecast is active for replenishment; approved indicates planner sign-off; overridden indicates a manual adjustment was applied; superseded indicates a newer run has replaced this record; archived indicates the record is retained for historical analysis only.. Valid values are `draft|published|approved|overridden|superseded|archived`',
    `forecast_type` STRING COMMENT 'Classification of the demand forecast by its planning purpose. baseline is the statistical base demand without uplift; promotional incorporates promotion lift; seasonal reflects seasonal index adjustments; event_driven accounts for specific demand events; consensus is the final agreed forecast used for replenishment and Open-to-Buy (OTB) planning.. Valid values are `baseline|promotional|seasonal|event_driven|consensus`',
    `forecast_upper_bound_units` DECIMAL(18,2) COMMENT 'The upper bound of the forecast confidence interval in units at the specified confidence level. Represents the high-demand scenario used for safety stock and maximum inventory planning to prevent stockouts.',
    `forecast_version` STRING COMMENT 'An incrementing integer version number for the forecast record for a given SKU-location-period combination. Enables tracking of forecast revisions across planning cycles and supports comparison of forecast evolution over time.',
    `forecasted_revenue` DECIMAL(18,2) COMMENT 'The projected revenue in the operating currency derived from the forecasted units multiplied by the expected selling price for the forecast period. Used in financial planning, Open-to-Buy (OTB) budgeting, and Gross Margin Return on Investment (GMROI) analysis.',
    `forecasted_units` DECIMAL(18,2) COMMENT 'The statistical models predicted demand quantity in sellable units for the SKU at the specified location during the forecast period. This is the primary quantitative output of the demand planning engine and drives replenishment order quantities.',
    `is_latest_version` BOOLEAN COMMENT 'Indicates whether this forecast record is the most current version for the given SKU-location-period combination. True means this record is the active forecast used for replenishment and OTB planning; False means it has been superseded by a newer forecast run.',
    `is_new_item` BOOLEAN COMMENT 'Indicates whether the SKU is a new item with insufficient sales history for statistical forecasting. When True, the forecast relies on analogous item modeling or planner input rather than historical demand patterns. Relevant for new product launches and assortment introductions.',
    `is_override_applied` BOOLEAN COMMENT 'Indicates whether a demand planner has manually overridden the statistical forecast for this record. True means the final forecasted_units reflect a planner adjustment; False means the forecast is purely statistical. Critical for measuring forecast bias introduced by manual intervention.',
    `is_promotional_period` BOOLEAN COMMENT 'Indicates whether the forecast period overlaps with an active promotional event. When True, the promotional_lift_units field is expected to be populated and the forecast incorporates promotion-driven demand uplift.',
    `mape` DECIMAL(18,2) COMMENT 'Mean Absolute Percentage Error (MAPE) measuring the accuracy of the statistical forecast against actual sales for the equivalent prior period. Expressed as a decimal (e.g., 0.12 = 12% error). Lower values indicate higher forecast accuracy. Used as the primary KPI for demand planning performance.',
    `model_version` STRING COMMENT 'The version identifier of the statistical forecasting model used to generate this forecast record. Supports model governance, reproducibility, and performance tracking across model upgrades in Blue Yonder Demand Planning.. Valid values are `^[0-9]+.[0-9]+.[0-9]+$`',
    `otb_impact_flag` BOOLEAN COMMENT 'Indicates whether this forecast record has been incorporated into the Open-to-Buy (OTB) financial plan. When True, the forecasted revenue and units are reflected in the merchandise financial plan and buying budget for the relevant period.',
    `override_reason_code` STRING COMMENT 'A standardized code indicating the business reason for the planners manual override of the statistical forecast (e.g., new product launch, competitor action, supply constraint, market intelligence). Populated only when is_override_applied is True. [ENUM-REF-CANDIDATE: NEW_PRODUCT|COMPETITOR_ACTION|SUPPLY_CONSTRAINT|MARKET_INTEL|PROMO_CHANGE|STORE_EVENT|WEATHER — promote to reference product]',
    `override_units` DECIMAL(18,2) COMMENT 'The manually adjusted demand quantity in units entered by a demand planner to replace or supplement the statistical forecast. Populated only when is_override_applied is True. Enables analysis of planner override magnitude and its impact on forecast accuracy.',
    `planning_channel` STRING COMMENT 'The retail fulfillment channel for which this demand forecast is generated. store covers brick-and-mortar POS demand; ecommerce covers digital commerce demand from Salesforce Commerce Cloud; omnichannel covers unified demand signals; dc_replenishment covers distribution center stock replenishment; bopis covers Buy Online Pick Up In Store (BOPIS) demand.. Valid values are `store|ecommerce|omnichannel|dc_replenishment|bopis`',
    `promotional_lift_units` DECIMAL(18,2) COMMENT 'The incremental demand units attributed to active promotions during the forecast period. Derived from promotion event modeling in Blue Yonder and used to isolate the promotional demand signal from baseline demand for Pricing and Promotions Management analysis.',
    `replenishment_recommendation_units` DECIMAL(18,2) COMMENT 'The system-recommended replenishment order quantity in units derived from the demand forecast, current inventory position, safety stock targets, and lead time. Feeds directly into Oracle Retail Merchandising System (ORMS) purchase order generation and Open-to-Buy (OTB) planning.',
    `seasonality_index` DECIMAL(18,2) COMMENT 'A multiplicative seasonal index applied to the baseline forecast to account for recurring seasonal demand patterns (e.g., holiday peaks, back-to-school). A value of 1.0 indicates no seasonal adjustment; values above 1.0 indicate above-average seasonal demand.',
    `statistical_model_code` STRING COMMENT 'The identifier or code of the statistical forecasting algorithm used by Blue Yonder Demand Planning to generate this forecast (e.g., ARIMA, Holt-Winters exponential smoothing, Croston for intermittent demand, machine learning ensemble). Enables model performance benchmarking and algorithm governance. [ENUM-REF-CANDIDATE: ARIMA|HOLT_WINTERS|CROSTON|ETS|MOVING_AVG|ML_ENSEMBLE|CAUSAL — promote to reference product]',
    `time_bucket_granularity` STRING COMMENT 'The temporal granularity of the forecast period covered by this record. daily is used for short-horizon replenishment; weekly is the standard planning cadence; monthly is used for financial and Open-to-Buy (OTB) planning.. Valid values are `daily|weekly|monthly`',
    `trend_adjustment_factor` DECIMAL(18,2) COMMENT 'A multiplicative factor representing the long-term demand trend applied to the forecast. Values above 1.0 indicate upward trend; values below 1.0 indicate declining demand trend. Used to capture secular demand shifts beyond seasonal patterns.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this demand forecast record was last modified in the Silver Layer lakehouse, including override applications, accuracy recalculations, or status changes.',
    `weeks_of_supply` DECIMAL(18,2) COMMENT 'Weeks of Supply (WOS) — the projected number of weeks the current on-hand inventory will cover demand based on the forecasted units. A key inventory health metric used in replenishment planning to identify stockout risk and excess inventory positions.',
    `wmape` DECIMAL(18,2) COMMENT 'Weighted Mean Absolute Percentage Error (WMAPE) measuring forecast accuracy weighted by sales volume, reducing the distortion caused by low-volume SKUs. Expressed as a decimal. Preferred accuracy metric for high-volume retail assortments where MAPE can be misleading.',
    CONSTRAINT pk_demand_forecast PRIMARY KEY(`demand_forecast_id`)
) COMMENT 'SKU-level demand forecast records generated by Blue Yonder Demand Planning. Captures forecasted units, revenue, forecast horizon, statistical model used, override flags, forecast accuracy (MAPE/WMAPE), and demand signals including seasonality, promotions lift, and trend adjustments. Drives replenishment and OTB planning.';

CREATE OR REPLACE TABLE `retail_ecm`.`supplychain`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Primary key for purchase_order',
    `blanket_po_purchase_order_id` BIGINT COMMENT 'Reference to the parent blanket or framework purchase order from which this release or call-off order was created. Null for standalone standard POs. Enables tracking of spend against blanket agreement limits.',
    `buyer_id` BIGINT COMMENT 'Reference to the internal buyer or purchasing agent responsible for creating and managing this purchase order. Corresponds to SAP EKKO.EKGRP (purchasing group) owner.',
    `dc_facility_id` BIGINT COMMENT 'Reference to the distribution center or store location designated as the delivery destination for this purchase order. Corresponds to SAP EKKO.WERKS (plant/site).',
    `item_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.item_hierarchy. Business justification: Open-to-Buy (OTB) and category-level PO management: buyers raise POs against a merchandise category node in the item hierarchy. Linking purchase_order to item_hierarchy replaces the denormalized merch',
    `merch_plan_id` BIGINT COMMENT 'Foreign key linking to merchandising.merch_plan. Business justification: Purchase orders consume OTB budget from merchandise plans. Supply chain teams need direct PO-to-merch-plan linkage for OTB consumption reporting without traversing buying_order. Retail finance audits ',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Retail buyers create promotional purchase orders (event buys) tied to specific campaigns for vendor-funded inventory builds. This link enables promotional spend tracking, campaign ROI analysis, and ve',
    `replenishment_plan_id` BIGINT COMMENT 'Foreign key linking to supplychain.replenishment_plan. Business justification: A purchase order header is frequently triggered by a replenishment plan. Linking purchase_order.replenishment_plan_id → replenishment_plan.replenishment_plan_id establishes the procurement-to-plan tra',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: Purchase orders in retail are season-coded — ship windows, cancel dates, and receipt dates are season-bound. Season-level PO receipt tracking and OTB reconciliation are standard retail buying reports.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier (vendor) fulfilling this purchase order. Links to the supplier master data product managed in Informatica MDM. Corresponds to SAP EKKO.LIFNR (vendor account number).',
    `actual_delivery_date` DATE COMMENT 'The date on which goods were physically received at the destination facility. Populated upon goods receipt posting in SAP (MIGO transaction). Used to calculate supplier on-time delivery performance and lead time actuals.',
    `approval_status` STRING COMMENT 'Authorization workflow status indicating whether the purchase order has been approved by the required approvers per the companys procurement authorization matrix. Distinct from po_status as it tracks the internal approval gate specifically.. Valid values are `pending|approved|rejected|escalated`',
    `approved_timestamp` TIMESTAMP COMMENT 'The timestamp when the purchase order received final authorization approval. Captures the precise moment the procurement commitment became binding. Used for approval cycle time analytics and compliance auditing.',
    `cancellation_date` DATE COMMENT 'The date by which the purchase order must be cancelled if goods have not shipped. Also known as the cancel date or cancel-by date in retail procurement. Null if the PO has not been cancelled or does not have a cancellation deadline.',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity or business unit issuing the purchase order. Used for financial reporting, P&L allocation, and intercompany reconciliation. Corresponds to SAP EKKO.BUKRS.',
    `confirmed_delivery_date` DATE COMMENT 'The delivery date confirmed by the supplier after PO acknowledgment. May differ from expected_delivery_date if the supplier cannot meet the original requested date. Used to update replenishment plans and manage weeks of supply (WOS).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the purchase order record was first created in the source system. Audit trail field for data lineage and compliance. Corresponds to SAP EKKO.AEDAT (creation date) combined with time.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this purchase order (e.g., USD, EUR, GBP, CAD). Corresponds to SAP EKKO.WAERS (currency key).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount or allowance amount applied to the purchase order by the supplier, including volume discounts, promotional allowances, and trade deals. Reduces the net payable amount. Expressed in the currency specified by currency_code.',
    `edi_transmission_status` STRING COMMENT 'Status of the EDI (Electronic Data Interchange) transmission of this purchase order to the supplier. Not Sent = EDI not applicable or not yet initiated; Pending = queued for transmission; Transmitted = EDI 850 PO sent to supplier; Acknowledged = supplier returned EDI 855 acknowledgment; Failed = transmission error; Rejected = supplier rejected the PO via EDI.. Valid values are `not_sent|pending|transmitted|acknowledged|failed|rejected`',
    `edi_transmitted_timestamp` TIMESTAMP COMMENT 'The timestamp when the purchase order was transmitted to the supplier via EDI (Electronic Data Interchange) as an EDI 850 transaction set. Null if EDI transmission has not occurred. Used for supplier communication SLA tracking.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign currency exchange rate applied to convert the purchase order amounts from the suppliers transaction currency to the companys functional currency at the time of PO creation. Corresponds to SAP EKKO.WKURS.',
    `expected_delivery_date` DATE COMMENT 'The agreed-upon date by which the supplier is expected to deliver the ordered goods to the designated distribution center or store. Used for supply chain planning, replenishment scheduling, and SLA monitoring. Corresponds to SAP EKET.EINDT (scheduled delivery date).',
    `fill_rate_pct` DECIMAL(18,2) COMMENT 'The percentage of ordered units that have been received and fulfilled by the supplier, calculated as (total_received_units / total_ordered_units) * 100. Fill Rate is a key supplier performance KPI measuring order completion. Stored as a pre-computed operational field updated upon each goods receipt.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms 2020) code defining the responsibilities of buyer and seller for delivery, risk transfer, and cost allocation (e.g., FOB = Free On Board, DDP = Delivered Duty Paid, CIF = Cost Insurance Freight). Corresponds to SAP EKKO.INCO1. Critical for import/export compliance and logistics cost allocation. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `incoterms_location` STRING COMMENT 'The named place or port associated with the Incoterms code, specifying the exact location where risk and cost transfer between buyer and seller (e.g., Port of Los Angeles for FOB). Corresponds to SAP EKKO.INCO2.',
    `is_cross_dock` BOOLEAN COMMENT 'Indicates whether this purchase order is designated for cross-docking at the distribution center, meaning goods will be transferred directly from inbound to outbound without putaway storage. Cross-docking reduces DC handling costs and accelerates store replenishment.',
    `is_drop_ship` BOOLEAN COMMENT 'Indicates whether this purchase order is a drop ship arrangement where the supplier ships goods directly to the end customer, bypassing the retailers distribution center. Drop ship POs are common in e-commerce and extended aisle assortments.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when the purchase order record was most recently modified in the source system. Used for incremental data loading, change data capture, and audit compliance.',
    `lead_time_days` STRING COMMENT 'The agreed or expected number of days from purchase order placement to goods receipt at the destination facility. Used in replenishment planning, weeks of supply (WOS) calculations, and Blue Yonder demand planning models. Corresponds to supplier lead time in the procurement master data.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The minimum quantity the supplier requires for this purchase order, as defined in the supplier agreement or item master. MOQ (Minimum Order Quantity) constraints drive order sizing decisions in replenishment planning and OTB management.',
    `net_payable_amount` DECIMAL(18,2) COMMENT 'The net amount payable to the supplier after applying all discounts, allowances, and adjustments to the gross total order amount. This is the financial commitment recorded in accounts payable. Expressed in the currency specified by currency_code.',
    `notes` STRING COMMENT 'Free-text field for buyer notes, special instructions, or remarks associated with the purchase order. May include delivery instructions, quality requirements, or supplier-specific handling notes. Corresponds to SAP EKKO.IHREZ (your reference) or header text.',
    `order_date` DATE COMMENT 'The business date on which the purchase order was officially created and issued. This is the principal real-world event date for the procurement commitment. Corresponds to SAP EKKO.BEDAT (document date).',
    `payment_terms_code` STRING COMMENT 'Code representing the agreed payment terms between the retailer and supplier (e.g., NET30, NET60, 2/10NET30 for 2% discount if paid within 10 days). Corresponds to SAP EKKO.ZTERM (terms of payment key). Drives accounts payable scheduling and early payment discount capture.',
    `po_number` STRING COMMENT 'Externally-known, human-readable purchase order number assigned by the procurement system (SAP MM or Oracle RMS). Used in EDI transmissions, supplier communications, and receiving workflows. Corresponds to SAP EKKO.EBELN field.. Valid values are `^PO-[0-9]{8,12}$`',
    `po_status` STRING COMMENT 'Current lifecycle state of the purchase order from creation through closure. Draft = created but not submitted; Pending Approval = awaiting authorization; Approved = authorized for transmission; Sent = transmitted to supplier via EDI or portal; Partially Received = some goods received; Received = all goods received; Closed = fully processed and closed; Cancelled = voided. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|sent|partially_received|received|closed|cancelled — promote to reference product]',
    `po_type` STRING COMMENT 'Classification of the purchase order by procurement method. Standard = regular replenishment PO; Blanket = open-quantity framework agreement; DSD (Direct Store Delivery) = supplier delivers directly to store; Drop Ship = vendor ships direct to customer; Consignment = inventory owned by supplier until sold; RTV (Return to Vendor) = merchandise returned to supplier. [ENUM-REF-CANDIDATE: standard|blanket|direct_store_delivery|drop_ship|consignment|return_to_vendor — promote to reference product]. Valid values are `standard|blanket|direct_store_delivery|drop_ship|consignment|return_to_vendor`',
    `purchasing_group_code` STRING COMMENT 'Code identifying the buyer group or commodity team responsible for this purchase order within the purchasing organization. Used for spend analytics by category and buyer performance reporting. Corresponds to SAP EKKO.EKGRP.',
    `purchasing_org_code` STRING COMMENT 'SAP purchasing organization code representing the organizational unit responsible for procuring goods and services. Defines the legal entity and negotiation authority for the purchase order. Corresponds to SAP EKKO.EKORG.',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this purchase order record originated. SAP_MM = SAP S/4HANA Materials Management; ORMS = Oracle Retail Merchandising System; MANUAL = manually entered; EDI = created via EDI inbound processing. Used for data lineage and reconciliation.. Valid values are `SAP_MM|ORMS|MANUAL|EDI`',
    `supplier_po_reference` STRING COMMENT 'The suppliers own reference number or acknowledgment number for this purchase order, returned via EDI 855 or supplier portal. Used for cross-referencing in supplier invoices, ASNs (Advance Ship Notices), and dispute resolution.',
    `total_order_amount` DECIMAL(18,2) COMMENT 'The gross total monetary value of the purchase order before any adjustments, representing the sum of all line item values. Expressed in the currency specified by currency_code. Used for open-to-buy (OTB) tracking, financial commitments, and accounts payable accruals.',
    `total_ordered_units` DECIMAL(18,2) COMMENT 'The total quantity of units ordered across all line items on this purchase order. Used for fill rate calculation, receiving reconciliation, and inventory planning. Expressed in the base unit of measure.',
    `total_received_units` DECIMAL(18,2) COMMENT 'The total quantity of units physically received and goods-receipted against this purchase order to date. Used to calculate fill rate (order completion percentage) and identify short shipments or over-deliveries.',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Purchase order header records representing procurement commitments to suppliers, managed in SAP MM or Oracle RMS. Captures PO number, supplier reference, buyer, order and expected delivery dates, total value, currency, payment terms, incoterms, PO type (standard, blanket, DSD), approval status, and EDI transmission status. SSOT for the PO lifecycle from creation through closure.';

CREATE OR REPLACE TABLE `retail_ecm`.`supplychain`.`po_line` (
    `po_line_id` BIGINT COMMENT 'Unique surrogate identifier for each purchase order line item in the Silver Layer lakehouse. Primary key for the po_line data product.',
    `assortment_item_id` BIGINT COMMENT 'Foreign key linking to merchandising.assortment_item. Business justification: Each PO line represents the physical order execution for a specific assortment item. Retail buyers track PO line receipts against assortment_item planned_units and planned_aur. This link enables assor',
    `buyer_id` BIGINT COMMENT 'Reference to the merchandise buyer or procurement officer responsible for this PO line. Supports buyer performance reporting, OTB management, and approval workflow tracking.',
    `cost_price_id` BIGINT COMMENT 'Foreign key linking to pricing.cost_price. Business justification: PO line cost validation and invoice matching requires tracing each lines unit_cost to the governing cost_price record. Retail buyers use this for margin reporting and accounts payable reconciliation.',
    `dc_facility_id` BIGINT COMMENT 'Reference to the specific destination location (DC, store, or fulfillment center) where this PO line is to be delivered. Supports multi-destination PO management and DC-to-store allocation.',
    `department_id` BIGINT COMMENT 'Reference to the merchandise department or category to which this PO lines SKU belongs. Supports departmental OTB tracking, assortment planning, and financial reporting by merchandise hierarchy.',
    `gtin_registry_id` BIGINT COMMENT 'Foreign key linking to product.gtin_registry. Business justification: EDI/GS1 procurement compliance: purchase order lines reference GTINs per GS1 standards for item identification in EDI transactions. Linking po_line to gtin_registry replaces the denormalized gtin text',
    `replenishment_plan_id` BIGINT COMMENT 'Foreign key linking to supplychain.replenishment_plan. Business justification: A PO line is often generated as a direct result of a replenishment plan recommendation for a specific SKU. Linking po_line.replenishment_plan_id → replenishment_plan.replenishment_plan_id provides end',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: PO lines carry season-specific cancel dates and delivery windows. Season-level receipt and cost tracking at line level is required for retail OTB reconciliation and season-end receipt performance repo',
    `sku_id` BIGINT COMMENT 'Reference to the master product record for the item being ordered on this PO line. Links to the product master for full item attributes. [RESOURCE_REFERENCE — TRANSACTION_LINE canonical category]',
    `purchase_order_id` BIGINT COMMENT 'Reference to the parent purchase order header to which this line item belongs. Establishes the header-to-line relationship for PO lifecycle tracking. [HEADER_REFERENCE — TRANSACTION_LINE canonical category]',
    `uom_id` BIGINT COMMENT 'Foreign key linking to product.uom. Business justification: Procurement UOM normalization: PO lines specify order quantities in a unit of measure that must resolve to the canonical UOM master for accurate receiving, invoicing, and inventory conversion. Linking',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier (vendor) fulfilling this PO line. Enables supplier performance analysis at the line level, including fill rate and lead time compliance.',
    `actual_delivery_date` DATE COMMENT 'The date on which goods for this PO line were physically received at the destination. Used to calculate on-time delivery performance and actual lead time versus committed lead time.',
    `allowance_amount` DECIMAL(18,2) COMMENT 'Supplier-granted trade allowance or promotional funding amount applied to this PO line (e.g., off-invoice allowance, scan allowance). Reduces net cost and impacts COGS and GMROI calculations.',
    `cancel_date` DATE COMMENT 'The latest date by which this PO line must be received; if not received by this date, the line is automatically cancelled. Critical for seasonal and fashion merchandise to prevent late deliveries.',
    `confirmed_delivery_date` DATE COMMENT 'The delivery date confirmed by the supplier for this PO line. May differ from the requested delivery date; variance drives lead time compliance KPIs and supplier scorecards.',
    `confirmed_qty` DECIMAL(18,2) COMMENT 'Quantity confirmed by the supplier as available and committed for shipment on this PO line. May differ from ordered quantity due to supplier capacity constraints or MOQ adjustments.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the country where the product on this PO line was manufactured or produced. Required for customs declarations, import compliance, and consumer labeling regulations.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this PO line record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides audit trail for PO creation and supports data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the unit cost and extended cost on this PO line (e.g., USD, EUR, GBP). Required for multi-currency supplier contracts and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `destination_type` STRING COMMENT 'Type of destination for this PO line shipment. Indicates whether goods are routed to a Distribution Center (DC), direct to store (DSD), cross-docking facility, drop ship to customer, or Micro-Fulfillment Center (MFC).. Valid values are `dc|store|cross_dock|drop_ship|mfc`',
    `extended_cost` DECIMAL(18,2) COMMENT 'Total cost for this PO line calculated as ordered_qty multiplied by unit_cost. Represents the gross financial commitment for this line item before any allowances or discounts.',
    `incoterms` STRING COMMENT 'ICC Incoterms code defining the delivery terms and transfer of risk/cost responsibility between buyer and supplier for this PO line (e.g., FOB, DDP, CIF). Critical for landed cost calculation and logistics planning. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `invoice_number` STRING COMMENT 'Supplier invoice number associated with this PO line for three-way match processing (PO, receipt, invoice). Links to accounts payable for payment processing and FASB ASC 606 revenue recognition compliance.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this PO line record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports change data capture, audit compliance, and Silver Layer incremental processing.',
    `lead_time_days` STRING COMMENT 'Committed supplier lead time in calendar days from PO placement to expected delivery for this line item. Used for replenishment planning, OTB management, and supplier SLA compliance monitoring.',
    `line_number` STRING COMMENT 'Sequential line item number within the parent purchase order, used to uniquely identify and order line items within a PO. Corresponds to SAP MM item number (EBELP). [LINE_SEQUENCE — TRANSACTION_LINE canonical category]',
    `line_status` STRING COMMENT 'Current workflow status of this PO line item, tracking progression from open through fulfillment or cancellation. Drives replenishment alerts and supplier follow-up actions. [LIFECYCLE_STATUS — TRANSACTION_LINE canonical category]. Valid values are `open|confirmed|partially_received|fully_received|cancelled|closed`',
    `moq` DECIMAL(18,2) COMMENT 'The suppliers contractual Minimum Order Quantity (MOQ) for this SKU on this PO line. Used to validate ordered_qty compliance and negotiate order consolidation.',
    `moq_compliant` BOOLEAN COMMENT 'Indicates whether the ordered quantity on this PO line meets or exceeds the suppliers Minimum Order Quantity (MOQ) requirement. Non-compliant lines may incur supplier penalties or require buyer approval.',
    `net_cost` DECIMAL(18,2) COMMENT 'Net cost per unit after applying all supplier allowances, discounts, and deductions to the unit cost. Represents the true landed cost basis for COGS and margin calculations.',
    `order_uom_qty` DECIMAL(18,2) COMMENT 'Number of base selling units (eaches) contained within one purchase unit of measure. Enables conversion between purchase UOM and retail selling UOM for inventory and sales reporting (e.g., 12 eaches per case).',
    `ordered_qty` DECIMAL(18,2) COMMENT 'Total quantity of the SKU ordered on this PO line, expressed in the purchase unit of measure. Represents the buyers original demand signal to the supplier. [LINE_QUANTITY — TRANSACTION_LINE canonical category]',
    `otb_consumed` DECIMAL(18,2) COMMENT 'Dollar value of Open to Buy (OTB) budget consumed by this PO line at the time of order placement. Used for merchandise financial planning and budget compliance monitoring.',
    `received_qty` DECIMAL(18,2) COMMENT 'Quantity of the SKU physically received and confirmed at the distribution center or store against this PO line. Drives inventory on-hand updates and three-way match for invoice processing.',
    `rejection_reason` STRING COMMENT 'Reason code or description for any quantity rejected or returned to vendor (RTV) during receiving for this PO line (e.g., damaged goods, wrong item, quality failure). Supports chargeback processing and supplier compliance management.',
    `requested_delivery_date` DATE COMMENT 'The date by which the retailer requests delivery of this PO line at the destination (DC or store). Used for lead time compliance monitoring and replenishment planning.',
    `retail_price` DECIMAL(18,2) COMMENT 'Planned retail selling price (AUR - Average Unit Retail) for this SKU at the time of PO creation. Used for initial margin calculation and GMROI planning at the line level.',
    `ship_date` DATE COMMENT 'Date on which the supplier shipped goods for this PO line, as reported via ASN or EDI 856. Used to calculate in-transit duration and validate supplier shipping compliance.',
    `shipped_qty` DECIMAL(18,2) COMMENT 'Quantity of the SKU that the supplier has physically shipped against this PO line, as reported via ASN (Advance Shipment Notice) or EDI 856. Used to calculate in-transit inventory.',
    `vendor_item_number` STRING COMMENT 'Suppliers own item number or part number for the product on this PO line. Used in EDI transactions and supplier communications to cross-reference retailer SKU with supplier catalog number.',
    CONSTRAINT pk_po_line PRIMARY KEY(`po_line_id`)
) COMMENT 'Line-item detail for each purchase order. Captures SKU/GTIN, ordered quantity, unit of measure, unit cost, extended cost, confirmed quantity, shipped quantity, received quantity, line status, MOQ compliance flag, and lead-time commitment. Enables granular PO tracking at the SKU level.';

CREATE OR REPLACE TABLE `retail_ecm`.`supplychain`.`plan` (
    `plan_id` BIGINT COMMENT 'Primary key for plan',
    `assortment_id` BIGINT COMMENT 'Foreign key linking to product.assortment. Business justification: Assortment-authorized supply planning: supply plans are created only for SKUs authorized in the assortment for a given node. Linking plan to assortment enables merchandise planners to enforce that sup',
    `dc_facility_id` BIGINT COMMENT 'Reference to the Distribution Center (DC) for which this supply plan is generated. Identifies the fulfillment node responsible for receiving, storing, and distributing the planned SKU.',
    `demand_forecast_id` BIGINT COMMENT 'Foreign key linking to supplychain.demand_forecast. Business justification: A supply plan at the SKU-DC-week level is built by reconciling demand forecasts with available supply. Linking plan.demand_forecast_id → demand_forecast.demand_forecast_id establishes the traceability',
    `margin_target_id` BIGINT COMMENT 'Foreign key linking to pricing.margin_target. Business justification: Open-to-Buy (OTB) supply planning in retail is constrained by margin targets — the plans sell_through_rate_pct and weeks_of_supply are set to meet margin_target thresholds. Retail planners need this ',
    `merch_plan_id` BIGINT COMMENT 'Foreign key linking to merchandising.merch_plan. Business justification: The supply chain consensus plan (planned_receipt_qty, safety_stock_qty, replenishment_order_qty) must be validated against merchandise plan OTB and planned receipt amounts. This is the primary S&OP in',
    `promo_campaign_id` BIGINT COMMENT 'Reference to an active promotion associated with this SKU-DC-week supply plan. Promotional events drive demand uplift adjustments to the consensus demand quantity and may require incremental supply planning.',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: Supply chain plans are season-scoped in retail — plan horizon dates, promotional uplift quantities, and sell-through rate targets are all season-driven. Season-level supply plan vs. merch plan varianc',
    `sku_id` BIGINT COMMENT 'Reference to the specific Stock Keeping Unit (SKU) being planned. The SKU is the lowest-level product identifier used for inventory tracking and replenishment planning.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Supply chain plans reference current stock positions for beginning_on_hand_qty and projected inventory calculations. Linking plan to stock_position enables plan accuracy validation and real-time plan ',
    `vendor_id` BIGINT COMMENT 'Reference to the primary supplier responsible for fulfilling the planned receipt quantities for this SKU-DC combination. Used to evaluate supplier capacity constraints during supply-demand balancing.',
    `allocation_priority_rank` STRING COMMENT 'Numeric rank (1 = highest priority) assigned to this DC for allocation of constrained supply for the SKU. Used by planners to prioritize distribution of limited inventory across DCs and stores during supply-constrained periods.',
    `approval_status` STRING COMMENT 'Approval workflow status of the supply plan record within the S&OP governance process. Pending plans await planner or manager sign-off; approved plans are authorized for execution; rejected plans require revision; escalated plans require senior leadership review.. Valid values are `pending|approved|rejected|escalated`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the supply plan record was approved in the S&OP workflow. Provides a precise audit trail for plan authorization and supports compliance with internal governance controls.',
    `approved_by` STRING COMMENT 'Name or employee identifier of the supply chain planner or manager who approved this supply plan record in the S&OP workflow. Provides audit trail for plan authorization decisions.',
    `beginning_on_hand_qty` DECIMAL(18,2) COMMENT 'Projected on-hand inventory quantity for the SKU at the DC at the start of the planning week, before any receipts or demand consumption. Used as the opening inventory position for supply-demand balancing calculations.',
    `consensus_demand_qty` DECIMAL(18,2) COMMENT 'Agreed demand quantity after S&OP consensus adjustments, incorporating planner overrides, promotional uplifts, and commercial inputs. This is the demand signal used for supply-demand balancing in the approved plan.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this supply plan record was first created in the system. Provides the audit trail creation marker for the plan lifecycle and supports data lineage tracking in the Silver layer.',
    `crossdock_qty` DECIMAL(18,2) COMMENT 'Quantity of the SKU planned for cross-docking at the DC, bypassing put-away storage and flowing directly from inbound receipt to outbound shipment. Supports DC throughput optimization and reduces handling costs for high-velocity items.',
    `demand_forecast_qty` DECIMAL(18,2) COMMENT 'Statistical demand forecast quantity for the SKU at the DC for the planning week, expressed in the SKUs unit of measure. Sourced from Blue Yonder Demand Planning and represents the baseline demand signal before supply constraints are applied.',
    `excess_inventory_flag` BOOLEAN COMMENT 'Indicates whether the projected on-hand quantity exceeds the maximum inventory target for the SKU-DC combination in the planning week. When True, signals a potential dead stock or overstock situation requiring markdown or redistribution action.',
    `in_transit_qty` DECIMAL(18,2) COMMENT 'Quantity of the SKU currently in transit from supplier or another DC, expected to arrive at the destination DC within the planning week. Represents confirmed supply pipeline inventory not yet received.',
    `max_inventory_qty` DECIMAL(18,2) COMMENT 'Maximum allowable on-hand inventory quantity for the SKU at the DC, representing the upper bound of the inventory target range. Projected on-hand quantities exceeding this threshold trigger the excess inventory flag.',
    `min_order_qty` DECIMAL(18,2) COMMENT 'Minimum Order Quantity (MOQ) required by the supplier for this SKU, representing the smallest quantity that can be ordered in a single purchase order. Constrains replenishment order quantities in the supply plan.',
    `open_po_qty` DECIMAL(18,2) COMMENT 'Quantity on open, unfulfilled Purchase Orders (POs) for this SKU-DC combination expected to be received within the planning week. Sourced from SAP S/4HANA MM and ORMS to represent committed supply.',
    `plan_number` STRING COMMENT 'Business-facing externally-known identifier for the supply plan record, used in S&OP communications, planner workflows, and cross-system references. Typically formatted as a combination of DC code, SKU, and planning week.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the supply plan record within the S&OP approval workflow. Draft plans are under construction; submitted plans await approval; approved plans are baselined for execution; locked plans are frozen for the current cycle.. Valid values are `draft|submitted|approved|rejected|superseded|locked`',
    `plan_type` STRING COMMENT 'Classification of the supply plan by planning methodology. Consensus plans reflect agreed S&OP output; unconstrained plans reflect pure demand signal; constrained plans incorporate supplier and DC capacity limits; allocation plans reflect prioritized distribution of limited supply.. Valid values are `consensus|unconstrained|constrained|allocation|replenishment`',
    `planned_receipt_qty` DECIMAL(18,2) COMMENT 'Total quantity of the SKU planned to be received at the DC during the planning week from all supply sources (open POs, in-transit, cross-dock). Core output of the supply planning process used to assess coverage against demand.',
    `planner_notes` STRING COMMENT 'Free-text notes entered by the supply chain planner to document assumptions, exceptions, override rationale, or action items associated with this supply plan record. Supports S&OP review discussions and audit trail.',
    `planning_horizon_weeks` STRING COMMENT 'Number of weeks forward from the plan week start date that this supply plan covers. Defines the rolling planning window used for demand-supply balancing and replenishment trigger decisions.',
    `projected_on_hand_qty` DECIMAL(18,2) COMMENT 'Projected ending on-hand inventory quantity for the SKU at the DC at the end of the planning week, calculated as beginning on-hand plus planned receipts minus consensus demand. Key metric for identifying coverage gaps and excess inventory.',
    `promotional_uplift_qty` DECIMAL(18,2) COMMENT 'Incremental demand quantity attributed to a promotional event for this SKU-DC-week, added on top of the baseline statistical forecast to derive the consensus demand quantity. Sourced from the promotions planning system.',
    `replenishment_order_qty` DECIMAL(18,2) COMMENT 'Recommended replenishment order quantity for the SKU-DC combination for the planning week, calculated by the planning system to bring projected on-hand to the target inventory level. Serves as the basis for generating new purchase orders.',
    `safety_stock_qty` DECIMAL(18,2) COMMENT 'Minimum buffer inventory quantity required for the SKU at the DC to protect against demand variability and supply uncertainty. Serves as the replenishment trigger threshold in the supply plan.',
    `sell_through_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of available inventory for this SKU that has been sold within the planning period, calculated as units sold divided by beginning inventory plus receipts. Used to assess demand velocity and identify slow-moving or dead stock.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this supply plan record originated. Enables data lineage tracking and reconciliation between planning systems. Values include BLUE_YONDER (Blue Yonder Demand Planning), SAP_S4 (SAP S/4HANA), ORMS (Oracle Retail Merchandising System), or MANUAL (planner-entered).. Valid values are `BLUE_YONDER|SAP_S4|ORMS|MANUAL`',
    `stockout_risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk score (0-100) indicating the probability of a stockout event for the SKU at the DC within the planning horizon. Derived from demand variability, supply reliability, and projected on-hand versus safety stock. Used to prioritize replenishment actions.',
    `supplier_fill_rate_pct` DECIMAL(18,2) COMMENT 'Historical fill rate percentage for this supplier-SKU combination, representing the percentage of ordered quantity actually delivered on time. Used as a supply reliability input to safety stock and risk score calculations.',
    `supplier_lead_time_days` STRING COMMENT 'Number of days from purchase order placement to expected receipt at the DC for this SKU-supplier combination. Used in replenishment planning to determine order timing and assess supply pipeline coverage.',
    `supply_constrained_flag` BOOLEAN COMMENT 'Indicates whether the supply plan for this SKU-DC-week is constrained by supplier capacity, lead time, or minimum order quantity (MOQ) limitations. When True, planned receipt quantity is below unconstrained demand, triggering allocation prioritization.',
    `unit_of_measure` STRING COMMENT 'Unit of measure in which all quantity fields (demand, receipt, on-hand) are expressed for this SKU in the supply plan. Common values include EA (each), CS (case), PK (pack). Ensures consistent quantity interpretation across planning systems. [ENUM-REF-CANDIDATE: EA|CS|PK|LB|KG|OZ|L|M — 8 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this supply plan record was last modified, including planner overrides, system recalculations, or status changes. Supports change tracking and version management in the S&OP process.',
    `version_number` STRING COMMENT 'Sequential version number of the supply plan, incremented each time the plan is revised within the same planning cycle. Enables planners to track plan evolution and compare versions during S&OP reviews.',
    `week_end_date` DATE COMMENT 'The last day (Sunday) of the planning week for which this supply plan record applies. Used in conjunction with plan_week_start_date to define the weekly planning horizon bucket.',
    `week_start_date` DATE COMMENT 'The first day (Monday) of the planning week for which this supply plan record applies. Defines the weekly time bucket used in S&OP reviews and demand-supply balancing at the SKU-DC-week granularity.',
    `weeks_of_supply` DECIMAL(18,2) COMMENT 'Weeks of Supply (WOS) metric representing the number of weeks the projected on-hand inventory can cover at the current consensus demand rate. A key S&OP KPI used to identify stockout risk and excess inventory positions.',
    CONSTRAINT pk_plan PRIMARY KEY(`plan_id`)
) COMMENT 'Aggregated supply plan at the SKU-DC-week level, reconciling demand forecasts with available supply, open POs, in-transit inventory, and supplier capacity constraints. Captures planned receipt quantities, projected on-hand, weeks-of-supply, stockout risk score, excess inventory flags, allocation priorities for constrained supply, and plan version/approval status. Master supply-demand balancing record used by planners in weekly S&OP reviews to identify coverage gaps, trigger replenishment actions, and prioritize allocation across stores and DCs.';

CREATE OR REPLACE TABLE `retail_ecm`.`supplychain`.`inbound_appointment` (
    `inbound_appointment_id` BIGINT COMMENT 'Unique system-generated identifier for each dock appointment scheduling record for inbound shipments at distribution centers and stores.',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier responsible for delivering the inbound shipment to the facility.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to fulfillment.carrier_service. Business justification: Dock scheduling by carrier service: carrier service determines appointment duration, dock door requirements, and unload method; linking inbound_appointment to carrier_service enables dock capacity pla',
    `dc_facility_id` BIGINT COMMENT 'Identifier of the distribution center (DC) or store location where the inbound appointment is scheduled. Links to the facility master.',
    `inbound_shipment_id` BIGINT COMMENT 'Reference to the inbound shipment record expected at this appointment. Enables traceability from appointment to physical shipment.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order associated with this inbound appointment. Links the appointment to the procurement lifecycle.',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier or vendor originating the inbound shipment associated with this appointment.',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'The actual date and time the carrier checked in or arrived at the facility gate or dock. Used to calculate on-time performance and dwell time against the scheduled start.',
    `actual_carton_count` STRING COMMENT 'The actual number of cartons or cases physically received during unloading. Discrepancies against expected carton count trigger supplier chargeback or shortage claims.',
    `actual_pallet_count` STRING COMMENT 'The actual number of pallets received and counted during the unloading process. Compared against expected pallet count to identify discrepancies and supplier compliance issues.',
    `actual_unload_end_timestamp` TIMESTAMP COMMENT 'The actual date and time when physical unloading was completed and the dock door was cleared. Used to compute actual unload duration and dock utilization.',
    `actual_unload_start_timestamp` TIMESTAMP COMMENT 'The actual date and time when physical unloading of the trailer or container began at the assigned dock door.',
    `advance_ship_notice_number` STRING COMMENT 'The Advance Ship Notice (ASN) number transmitted by the supplier via EDI 856 prior to shipment arrival. Enables pre-receiving, labor planning, and automated appointment creation.',
    `appointment_duration_minutes` STRING COMMENT 'The planned duration of the dock appointment in minutes, calculated based on expected volume (pallets/cartons) and appointment type. Drives dock door time slot blocking in the WMS scheduler.',
    `appointment_notes` STRING COMMENT 'Free-text notes or special instructions associated with the appointment, entered by DC staff, carriers, or the scheduling system. May include special handling requirements, access instructions, or exception details.',
    `appointment_number` STRING COMMENT 'Externally-known, human-readable appointment reference number used by carriers, suppliers, and DC staff to identify and communicate about the appointment. Typically generated by the WMS or carrier portal.. Valid values are `^APPT-[0-9]{8,12}$`',
    `appointment_status` STRING COMMENT 'Current lifecycle state of the dock appointment. Tracks progression from initial scheduling through completion or exception. Values: scheduled (booked but not confirmed), confirmed (carrier acknowledged), arrived (carrier checked in at gate), completed (unload finished), no_show (carrier did not arrive), cancelled (appointment voided).. Valid values are `scheduled|confirmed|arrived|completed|no_show|cancelled`',
    `appointment_type` STRING COMMENT 'Classification of the inbound appointment by unloading method. Live unload: carrier waits while freight is unloaded. Drop trailer: carrier leaves trailer at dock for later unloading. Cross-dock (cross-docking): freight transferred directly to outbound without storage. Floor load: loose cartons loaded directly on trailer floor.. Valid values are `live_unload|drop_trailer|cross_dock|floor_load`',
    `bill_of_lading_number` STRING COMMENT 'The Bill of Lading (BOL) number issued by the carrier as a receipt of freight and contract of carriage. Key document for inbound receiving reconciliation and dispute resolution.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the appointment record was first created in the system, regardless of scheduling source. Supports audit trail and data lineage requirements.',
    `dock_door_number` STRING COMMENT 'The specific dock door or bay number at the facility assigned to this inbound appointment. Used for physical routing of labor and equipment to the correct location.',
    `dock_door_zone` STRING COMMENT 'The physical zone or section of the facility where the assigned dock door is located (e.g., North Dock, Receiving Zone A). Supports labor planning and traffic flow management.',
    `driver_license_number` STRING COMMENT 'The commercial drivers license (CDL) number of the driver presenting at the facility. Captured for security verification and regulatory compliance at gate check-in.',
    `driver_name` STRING COMMENT 'The name of the truck driver who checked in at the facility for this appointment. Captured at gate check-in for security and compliance purposes.',
    `expected_carton_count` STRING COMMENT 'The total number of cartons or cases expected in the inbound shipment per the ASN or purchase order. Used for receiving accuracy validation.',
    `expected_pallet_count` STRING COMMENT 'The number of pallets expected to be unloaded during this appointment as communicated via ASN or purchase order. Used for dock labor planning and time slot duration calculation.',
    `expected_weight_kg` DECIMAL(18,2) COMMENT 'The total expected gross weight of the inbound shipment in kilograms as declared on the Bill of Lading or ASN. Used for dock equipment planning and freight audit.',
    `is_hazmat` BOOLEAN COMMENT 'Indicates whether the inbound shipment contains hazardous materials (Hazmat) requiring special handling, dock equipment, or regulatory compliance procedures at the facility.',
    `is_temperature_controlled` BOOLEAN COMMENT 'Indicates whether the inbound shipment requires temperature-controlled handling (refrigerated or frozen). Triggers assignment to a temperature-controlled dock door and cold chain receiving procedures.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when the appointment record was most recently modified. Tracks status changes, reschedules, and data corrections for audit and change management purposes.',
    `late_arrival_reason` STRING COMMENT 'Free-text or coded reason captured when a carrier arrives outside the scheduled appointment window. Used for root cause analysis of inbound logistics delays and carrier performance management. [ENUM-REF-CANDIDATE: traffic|weather|mechanical_breakdown|driver_hours|customs_delay|shipper_delay|other — promote to reference product]',
    `on_time_arrival_flag` BOOLEAN COMMENT 'Indicates whether the carrier arrived within the scheduled appointment window. Derived from comparison of actual arrival timestamp to scheduled start timestamp. Used for carrier on-time performance (OTP) reporting and SLA compliance tracking.',
    `original_scheduled_start_timestamp` TIMESTAMP COMMENT 'The original planned appointment start timestamp before any rescheduling occurred. Preserved for compliance reporting and to measure the impact of rescheduling on DC operations.',
    `pro_number` STRING COMMENT 'The carrier-assigned Progressive (PRO) number, which is the freight bill number used to track the shipment through the carriers system. Standard identifier for LTL and TL freight.',
    `reschedule_count` STRING COMMENT 'The number of times this appointment has been rescheduled. High reschedule counts indicate carrier reliability issues or supply chain disruptions and are used in supplier/carrier compliance scoring.',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'The planned date and time when the unloading activity is expected to be completed and the dock door released for the next appointment.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'The planned date and time when the carrier is expected to arrive at the dock door and unloading is scheduled to begin. Principal business event timestamp for the appointment.',
    `scheduling_source` STRING COMMENT 'Channel or method through which the appointment was originally created. Carrier portal: self-service web portal. EDI: Electronic Data Interchange automated scheduling. Manual: DC staff entered directly. API: programmatic integration from TMS or OMS.. Valid values are `carrier_portal|edi|manual|api`',
    `seal_number` STRING COMMENT 'The security seal number affixed to the trailer or container door. Verified at arrival to confirm shipment integrity and detect tampering during transit.',
    `temperature_requirement` STRING COMMENT 'The specific temperature handling requirement for the inbound shipment. Ambient: room temperature. Chilled: 0–4°C. Frozen: -18°C or below. Ultra-frozen: -40°C or below (e.g., pharmaceutical or specialty frozen goods).. Valid values are `ambient|chilled|frozen|ultra_frozen`',
    `trailer_number` STRING COMMENT 'The carrier-assigned trailer or container identification number for the inbound shipment. Used for physical asset tracking, seal verification, and RFID scanning at the dock.',
    CONSTRAINT pk_inbound_appointment PRIMARY KEY(`inbound_appointment_id`)
) COMMENT 'Dock appointment scheduling records for inbound shipments at DCs and stores. Captures appointment date/time, dock door assignment, carrier, expected shipment, appointment status (scheduled, confirmed, arrived, completed, no-show), appointment type (live unload, drop trailer), and scheduling source (carrier portal, EDI, manual). Coordinates inbound logistics flow.';

CREATE OR REPLACE TABLE `retail_ecm`.`supplychain`.`dc_facility` (
    `dc_facility_id` BIGINT COMMENT 'Unique identifier for the distribution center or micro-fulfillment center facility. Primary key for the DC facility master record.',
    `address_line_1` STRING COMMENT 'Primary street address line for the facility (street number, street name, building identifier).',
    `address_line_2` STRING COMMENT 'Secondary address line for additional location details (suite, floor, building name) if applicable.',
    `automation_level` STRING COMMENT 'Classification of the facilitys warehouse automation maturity: manual (labor-intensive), semi-automated (some mechanization), highly automated (extensive robotics and conveyors), or fully automated (lights-out operations).. Valid values are `manual|semi_automated|highly_automated|fully_automated`',
    `bonded_warehouse_flag` BOOLEAN COMMENT 'Indicates whether the facility is a customs-bonded warehouse authorized to store imported goods before duties and taxes are paid, enabling deferred duty payment and re-export options.',
    `city` STRING COMMENT 'City or municipality where the facility is located.',
    `closed_date` DATE COMMENT 'Date when the facility was permanently closed or decommissioned. Null for active facilities.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the facility is located (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility record was first created in the master data system.',
    `dock_door_count` STRING COMMENT 'Total number of loading dock doors available for inbound receiving and outbound shipping operations.',
    `facility_code` STRING COMMENT 'Business-assigned unique alphanumeric code for the facility used in operational systems, shipping documents, and cross-system integration. Typically 4-12 characters.. Valid values are `^[A-Z0-9]{4,12}$`',
    `facility_email_address` STRING COMMENT 'Primary email address for the facility used for operational communications, appointment confirmations, and document exchange.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `facility_manager_name` STRING COMMENT 'Full name of the facility manager or site director responsible for day-to-day operations and performance.',
    `facility_name` STRING COMMENT 'Official business name of the distribution center or fulfillment facility (e.g., Northeast Regional DC, Manhattan MFC-01).',
    `facility_phone_number` STRING COMMENT 'Primary contact phone number for the facility used for carrier coordination, supplier communication, and operational inquiries.',
    `facility_status` STRING COMMENT 'Current operational lifecycle status of the facility. Active facilities are fully operational; planned facilities are approved but not yet built; under construction facilities are being built; decommissioned facilities are permanently closed; temporarily closed facilities are inactive but may reopen; seasonal facilities operate only during peak periods.. Valid values are `active|planned|under_construction|decommissioned|temporarily_closed|seasonal`',
    `facility_type` STRING COMMENT 'Classification of the facility based on its primary operational purpose: regional DC (large-scale distribution), micro-fulfillment center (MFC for rapid e-commerce), dark store (fulfillment-only, no retail), cross-dock hub (transshipment), returns center (reverse logistics), or forward stocking location (FSL).. Valid values are `regional_dc|micro_fulfillment_center|dark_store|cross_dock_hub|returns_center|forward_stocking_location`',
    `gln` STRING COMMENT 'GS1-issued 13-digit Global Location Number uniquely identifying this facility in global supply chain transactions and EDI exchanges.. Valid values are `^[0-9]{13}$`',
    `hazmat_certified_flag` BOOLEAN COMMENT 'Indicates whether the facility is certified and equipped to handle, store, and ship hazardous materials in compliance with DOT and OSHA regulations.',
    `inbound_dock_door_count` STRING COMMENT 'Number of dock doors dedicated to inbound receiving operations from suppliers and carriers.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility record was most recently modified in the master data system.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the facility in decimal degrees for mapping, routing, and geospatial analytics.',
    `lease_expiration_date` DATE COMMENT 'Date when the current facility lease agreement expires. Null for owned facilities. Used for lease renewal planning and financial forecasting.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the facility in decimal degrees for mapping, routing, and geospatial analytics.',
    `opened_date` DATE COMMENT 'Date when the facility first became operational and began processing inventory and orders.',
    `operating_hours_weekday` STRING COMMENT 'Standard operating hours for the facility on weekdays (Monday-Friday) in format HH:MM-HH:MM (e.g., 06:00-22:00). Used for appointment scheduling and labor planning.',
    `operating_hours_weekend` STRING COMMENT 'Standard operating hours for the facility on weekends (Saturday-Sunday) in format HH:MM-HH:MM. May differ from weekday hours or indicate closed status.',
    `outbound_dock_door_count` STRING COMMENT 'Number of dock doors dedicated to outbound shipping operations to stores, customers, or other facilities.',
    `ownership_type` STRING COMMENT 'Indicates whether the facility is owned by the company, leased from a landlord, or operated by a third-party logistics provider (3PL). Impacts financial reporting and operational control.. Valid values are `owned|leased|third_party_operated`',
    `owning_region_code` STRING COMMENT 'Business region or geographic division code that owns and manages this facility (e.g., NORTHEAST, WEST, CENTRAL). Used for organizational hierarchy and P&L reporting.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the facility address used for mail delivery and geographic routing.',
    `state_province_code` STRING COMMENT 'Two-letter ISO 3166-2 subdivision code for the state, province, or region (e.g., CA for California, ON for Ontario).. Valid values are `^[A-Z]{2}$`',
    `storage_capacity_cubic_feet` DECIMAL(18,2) COMMENT 'Total volumetric storage capacity of the facility measured in cubic feet, accounting for vertical storage utilization.',
    `storage_capacity_pallet_positions` STRING COMMENT 'Maximum number of standard pallet positions available for inventory storage in racking and floor storage.',
    `temperature_zone_ambient_flag` BOOLEAN COMMENT 'Indicates whether the facility has ambient temperature storage zones (room temperature, non-climate-controlled) for general merchandise.',
    `temperature_zone_chilled_flag` BOOLEAN COMMENT 'Indicates whether the facility has refrigerated (chilled) storage zones typically maintained at 32-40°F for perishable goods like dairy and produce.',
    `temperature_zone_frozen_flag` BOOLEAN COMMENT 'Indicates whether the facility has frozen storage zones typically maintained at 0°F or below for frozen foods and ice cream.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the facility location (e.g., America/New_York, America/Chicago) used for scheduling and timestamp normalization.',
    `total_square_footage` DECIMAL(18,2) COMMENT 'Total building square footage of the facility including warehouse space, office space, and support areas. Measured in square feet.',
    `twenty_four_seven_operation_flag` BOOLEAN COMMENT 'Indicates whether the facility operates continuously 24 hours per day, 7 days per week to support high-volume or time-sensitive fulfillment requirements.',
    `warehouse_square_footage` DECIMAL(18,2) COMMENT 'Square footage dedicated to warehouse operations including storage, picking, packing, and staging areas. Measured in square feet.',
    `wms_instance_code` STRING COMMENT 'Identifier for the Manhattan WMS instance or system deployment that manages this facilitys warehouse operations. Used for system integration and data routing.',
    CONSTRAINT pk_dc_facility PRIMARY KEY(`dc_facility_id`)
) COMMENT 'Master record for each distribution center (DC) and micro-fulfillment center (MFC) operated by Retail. Captures facility type (regional DC, MFC, dark store, cross-dock hub, returns center), physical address, square footage, storage capacity (pallet positions, cubic feet), temperature zones (ambient, chilled, frozen), dock door count, operating hours, facility status (active, planned, decommissioned), owning region, and Manhattan WMS instance assignment. SSOT for DC/MFC identity referenced by all distribution operations including zone layout, dock scheduling, carrier assignments, and performance tracking.';

CREATE OR REPLACE TABLE `retail_ecm`.`supplychain`.`warehouse_zone` (
    `warehouse_zone_id` BIGINT COMMENT 'Unique identifier for the warehouse zone. Primary key for the warehouse zone entity.',
    `dc_facility_id` BIGINT COMMENT 'Reference to the parent distribution center or micro-fulfillment center (MFC) that contains this zone.',
    `aisle_range_end` STRING COMMENT 'Ending aisle identifier for the zone, defining the end of the physical aisle range contained within this zone for pick path optimization.. Valid values are `^[A-Z0-9]{1,5}$`',
    `aisle_range_start` STRING COMMENT 'Starting aisle identifier for the zone, defining the beginning of the physical aisle range contained within this zone for pick path optimization.. Valid values are `^[A-Z0-9]{1,5}$`',
    `automation_type` STRING COMMENT 'Level and type of automation deployed in the zone. ASRS = Automated Storage and Retrieval System, AMR = Autonomous Mobile Robot, AGV = Automated Guided Vehicle. [ENUM-REF-CANDIDATE: manual|conveyor|asrs|shuttle|amr|agv|robotic_pick — 7 candidates stripped; promote to reference product]',
    `barcode_scanning_required_flag` BOOLEAN COMMENT 'Indicates whether barcode scanning is mandatory for all inventory movements within the zone to ensure location accuracy and inventory integrity.',
    `cost_center_code` STRING COMMENT 'Financial cost center code for tracking labor, equipment, and operational expenses associated with the zone for profit and loss (P&L) reporting.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the zone record was first created in the warehouse management system, used for audit trail and data lineage.',
    `current_occupancy_pct` DECIMAL(18,2) COMMENT 'Current space utilization percentage of the zone, calculated as occupied capacity divided by total capacity, used for capacity management and slotting decisions.',
    `cycle_count_frequency` STRING COMMENT 'Scheduled frequency for physical inventory cycle counting within the zone, used for inventory accuracy management and shrinkage control.. Valid values are `daily|weekly|monthly|quarterly|annual|on_demand`',
    `effective_end_date` DATE COMMENT 'Date when the zone configuration was deactivated or retired from warehouse operations. Null indicates the zone is currently active.',
    `effective_start_date` DATE COMMENT 'Date when the zone configuration became active and available for warehouse operations.',
    `hazmat_certified_flag` BOOLEAN COMMENT 'Indicates whether the zone is certified and equipped for storage of hazardous materials per OSHA and DOT regulations.',
    `last_cycle_count_date` DATE COMMENT 'Date of the most recent physical inventory cycle count performed in the zone, used for audit trail and inventory accuracy monitoring.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the zone record was most recently modified, used for change tracking and audit trail purposes.',
    `location_count` STRING COMMENT 'Total number of individual storage locations (bins, slots, shelves, pallet positions) contained within this zone for granular inventory tracking.',
    `next_scheduled_cycle_count_date` DATE COMMENT 'Planned date for the next physical inventory cycle count in the zone, used for operational planning and resource scheduling.',
    `notes` STRING COMMENT 'Free-form text field for additional operational notes, special handling instructions, or configuration details relevant to the zone.',
    `pick_method` STRING COMMENT 'Primary order picking methodology used in the zone, determining workflow design and labor productivity metrics.. Valid values are `discrete|batch|zone|wave|cluster`',
    `rack_configuration_type` STRING COMMENT 'Type of racking system installed in the zone, determining storage density, accessibility, and material handling equipment requirements.. Valid values are `selective|drive_in|push_back|flow|pallet_flow|cantilever`',
    `replenishment_priority_rank` STRING COMMENT 'Priority ranking for zone replenishment tasks, with lower numbers indicating higher priority for maintaining forward pick face availability.',
    `rfid_enabled_flag` BOOLEAN COMMENT 'Indicates whether the zone is equipped with RFID infrastructure for automated inventory tracking and real-time location visibility.',
    `security_level` STRING COMMENT 'Security classification of the zone determining access control requirements, used for high-value merchandise, controlled substances, or restricted inventory.. Valid values are `standard|restricted|high_value|controlled_substance`',
    `slotting_strategy` STRING COMMENT 'Inventory slotting methodology applied to the zone for optimizing pick efficiency, labor productivity, and space utilization.. Valid values are `velocity_based|product_affinity|size_based|random|fixed`',
    `temperature_classification` STRING COMMENT 'Temperature control requirement for the zone, critical for grocery retail operations managing perishable goods and food safety compliance.. Valid values are `ambient|chilled|frozen|temperature_controlled`',
    `temperature_max_celsius` DECIMAL(18,2) COMMENT 'Maximum allowable temperature threshold for temperature-controlled zones, measured in degrees Celsius. Used for cold chain monitoring and food safety compliance.',
    `temperature_min_celsius` DECIMAL(18,2) COMMENT 'Minimum allowable temperature threshold for temperature-controlled zones, measured in degrees Celsius. Used for cold chain monitoring and food safety compliance.',
    `total_capacity_cubic_meters` DECIMAL(18,2) COMMENT 'Total volumetric storage capacity of the zone measured in cubic meters, used for space utilization analysis and capacity planning.',
    `total_capacity_pallet_positions` STRING COMMENT 'Total number of standard pallet positions available in the zone, critical for slotting optimization and inventory capacity management.',
    `weight_capacity_kg` DECIMAL(18,2) COMMENT 'Maximum weight capacity of the zone in kilograms, constrained by floor loading limits and rack weight ratings for safety compliance.',
    `zone_code` STRING COMMENT 'Business identifier code for the zone, used for operational reference and pick path planning within the warehouse management system (WMS).. Valid values are `^[A-Z0-9]{2,10}$`',
    `zone_name` STRING COMMENT 'Human-readable name of the zone describing its purpose or location within the facility (e.g., Receiving Dock A, Bulk Storage North, Forward Pick Zone 1, Packing Station B).',
    `zone_status` STRING COMMENT 'Current operational status of the zone indicating availability for warehouse operations and inventory placement.. Valid values are `active|inactive|maintenance|blocked|quarantine|seasonal`',
    `zone_type` STRING COMMENT 'Functional classification of the zone indicating its primary operational purpose within the distribution center workflow. [ENUM-REF-CANDIDATE: receiving|bulk_storage|forward_pick|reserve|packing|staging|dispatch|returns|cross_dock — 9 candidates stripped; promote to reference product]',
    CONSTRAINT pk_warehouse_zone PRIMARY KEY(`warehouse_zone_id`)
) COMMENT 'Defines the complete physical layout hierarchy within a DC or MFC, from zones (receiving, bulk storage, forward pick, packing, staging, dispatch, returns) down to individual storage locations (bin, slot, shelf, pallet position, floor stack). Zone-level attributes include zone code, type, temperature classification (ambient, chilled, frozen), aisle range, rack configuration (selective, drive-in, push-back, flow), automation type (manual, conveyor, AS/RS, shuttle, AMR), and zone capacity metrics. Location-level attributes include location code, aisle, bay, level, position, location type (bulk, pick face, reserve, floor, overflow), weight capacity, cubic capacity, RFID/barcode tag, and current occupancy status. SSOT for all physical space definitions within a facility — supports slotting optimization, pick path planning, capacity management, and location-level inventory tracking within Manhattan WMS.';

CREATE OR REPLACE TABLE `retail_ecm`.`supplychain`.`inbound_shipment` (
    `inbound_shipment_id` BIGINT COMMENT 'Primary key for inbound_shipment',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier responsible for delivering this shipment. Used for carrier performance tracking and freight audit.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to fulfillment.carrier_service. Business justification: Vendor compliance and freight audit: the specific carrier service used for inbound shipments determines transit time SLAs and freight cost; linking inbound_shipment to carrier_service enables vendor r',
    `dc_facility_id` BIGINT COMMENT 'Identifier of the originating facility for inter-facility transfers. Null for supplier-direct shipments.',
    `po_line_id` BIGINT COMMENT 'Foreign key linking this ASN line allocation to the specific purchase order line being fulfilled by this shipment.',
    `primary_inbound_dc_facility_id` BIGINT COMMENT 'Identifier of the distribution center or micro-fulfillment center receiving this shipment. Determines facility-specific receiving workflows and capacity planning.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supplychain.purchase_order. Business justification: An inbound shipment arrives at a DC in fulfillment of a purchase order. While inbound_appointment already carries purchase_order_id, the inbound_shipment itself needs a direct FK to purchase_order to ',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: Inbound shipments carry season-coded merchandise. Season-level receipt performance tracking (on-time arrival rate, fill rate, damage rate by season) is a standard retail DC operations and buying repor',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier or vendor originating this shipment. Links to supplier master data for performance tracking and compliance monitoring.',
    `actual_arrival_date` DATE COMMENT 'Actual date the shipment arrived at the distribution center. Used for on-time delivery performance measurement and carrier scorecarding.',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Precise date and time the shipment actually arrived at the distribution center. Captured by yard management system or gate check-in.',
    `actual_carton_count` STRING COMMENT 'Total number of cartons actually received and verified during receiving operations. Compared against expected count for discrepancy resolution.',
    `actual_pallet_count` STRING COMMENT 'Total number of pallets actually received during receiving operations. Compared against expected count for variance analysis.',
    `actual_weight_kg` DECIMAL(18,2) COMMENT 'Total actual weight of the shipment in kilograms as measured during receiving. Used for freight cost verification and variance analysis.',
    `asn_number` STRING COMMENT 'Reference number from the EDI 856 Advance Ship Notice document sent by the supplier prior to shipment arrival. Critical for pre-receiving planning and dock scheduling.',
    `bill_of_lading_number` STRING COMMENT 'Legal document number issued by the carrier acknowledging receipt of cargo for shipment. Serves as contract of carriage and receipt.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this shipment record was first created in the system. Used for audit trail and data lineage tracking.',
    `cross_dock_flag` BOOLEAN COMMENT 'Indicates whether this shipment is designated for cross-docking operations, bypassing putaway and moving directly to outbound staging.',
    `dock_door_number` STRING COMMENT 'Identifier of the specific dock door assigned for receiving this shipment. Used for yard management and receiving workflow coordination.',
    `expected_arrival_date` DATE COMMENT 'Planned date the shipment is expected to arrive at the distribution center. Used for dock scheduling and labor planning.',
    `expected_arrival_timestamp` TIMESTAMP COMMENT 'Precise date and time the shipment is expected to arrive at the distribution center. Used for appointment scheduling and dock door allocation.',
    `expected_carton_count` STRING COMMENT 'Total number of cartons expected in this shipment as communicated in the ASN. Used for receiving planning and variance detection.',
    `expected_cube_m3` DECIMAL(18,2) COMMENT 'Total expected volume of the shipment in cubic meters. Used for warehouse space planning and transportation capacity optimization.',
    `expected_pallet_count` STRING COMMENT 'Total number of pallets expected in this shipment as communicated in the ASN. Used for dock space allocation and material handling equipment planning.',
    `expected_weight_kg` DECIMAL(18,2) COMMENT 'Total expected weight of the shipment in kilograms as communicated in the ASN. Used for freight audit and capacity planning.',
    `freight_cost_amount` DECIMAL(18,2) COMMENT 'Total freight transportation cost for this inbound shipment. Used for landed cost calculation and freight spend analysis.',
    `freight_currency_code` STRING COMMENT 'Three-letter ISO currency code for the freight cost amount. Enables multi-currency freight cost tracking and consolidation.. Valid values are `^[A-Z]{3}$`',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether this shipment contains hazardous materials requiring special handling and regulatory compliance. True triggers HAZMAT receiving protocols.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this shipment record was most recently modified. Used for change tracking and data synchronization.',
    `late_arrival_reason_code` STRING COMMENT 'Standardized code explaining the reason for late arrival when on-time arrival flag is false. Used for root cause analysis and carrier accountability.',
    `notes` STRING COMMENT 'Free-text field for capturing additional information, special instructions, or exceptions related to this inbound shipment.',
    `on_time_arrival_flag` BOOLEAN COMMENT 'Indicates whether the shipment arrived within the scheduled appointment window. Used for carrier performance scorecarding and SLA compliance.',
    `pro_number` STRING COMMENT 'Carrier-assigned tracking number for the shipment. Used for freight tracking and proof of delivery.',
    `received_qty` DECIMAL(18,2) COMMENT 'Quantity of the SKU physically received and verified at the DC for this PO line on this specific inbound shipment during put-away or receiving operations. Enables line-level receipt confirmation and three-way match.',
    `receiving_complete_timestamp` TIMESTAMP COMMENT 'Date and time when all receiving operations were completed for this shipment. Marks closure of the receiving process and inventory availability.',
    `receiving_start_timestamp` TIMESTAMP COMMENT 'Date and time when receiving operations began for this shipment. Marks the start of unloading and inspection activities.',
    `seal_number` STRING COMMENT 'Security seal number applied to the trailer or container. Verified at receiving to ensure shipment integrity and prevent tampering.',
    `shipment_number` STRING COMMENT 'Business identifier for the inbound shipment, typically referenced in communications with suppliers and carriers. May be system-generated or supplier-provided.',
    `shipment_status` STRING COMMENT 'Current lifecycle status of the inbound shipment. Tracks progression from in-transit through receiving completion or cancellation.. Valid values are `in_transit|arrived|receiving|closed|cancelled|delayed`',
    `shipment_type` STRING COMMENT 'Classification of the inbound shipment based on origin and purpose. Determines receiving workflow and handling requirements.. Valid values are `supplier_direct|inter_facility_transfer|vendor_managed_inventory|drop_ship_return|cross_dock`',
    `shipped_qty` DECIMAL(18,2) COMMENT 'Quantity of the SKU that the vendor declared as shipped for this PO line on this specific inbound shipment, as communicated in the EDI 856 ASN line detail. Cannot reside on po_line (which aggregates across all shipments) or inbound_shipment (which aggregates across all PO lines).',
    `temperature_compliant_flag` BOOLEAN COMMENT 'Indicates whether the shipment maintained required temperature throughout transit. False triggers quality inspection and potential rejection.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether this shipment requires temperature-controlled handling for cold chain compliance. True for refrigerated or frozen goods.',
    `temperature_max_celsius` DECIMAL(18,2) COMMENT 'Maximum acceptable temperature in Celsius for temperature-controlled shipments. Used for cold chain compliance monitoring.',
    `temperature_min_celsius` DECIMAL(18,2) COMMENT 'Minimum acceptable temperature in Celsius for temperature-controlled shipments. Used for cold chain compliance monitoring.',
    `temperature_requirement` STRING COMMENT 'Specific temperature range requirement for this shipment. Determines receiving dock assignment and storage location.. Valid values are `ambient|refrigerated|frozen|deep_frozen`',
    `trailer_number` STRING COMMENT 'Identification number of the trailer or container used to transport the shipment. Critical for yard management and dock door assignment.',
    `unit_variance_quantity` DECIMAL(18,2) COMMENT 'Difference between shipped_qty and received_qty for this PO line on this shipment. A non-zero value triggers discrepancy resolution workflows (vendor chargebacks, shortage claims). Belongs to the intersection, not to either parent entity.',
    CONSTRAINT pk_inbound_shipment PRIMARY KEY(`inbound_shipment_id`)
) COMMENT 'Tracks inbound shipments arriving at a DC or MFC from suppliers, vendors, or inter-facility transfers. Captures ASN (Advance Ship Notice) reference, carrier, trailer number, expected and actual arrival date/time, PO references, total carton and pallet counts, shipment status (in-transit, arrived, receiving, closed), and temperature compliance flag for cold chain shipments. Integrates with EDI 856 ASN feeds and Manhattan WMS receiving workflows. SSOT for all inbound freight visibility at the distribution center level.';

CREATE OR REPLACE TABLE `retail_ecm`.`supplychain`.`receiving_event` (
    `receiving_event_id` BIGINT COMMENT 'Unique identifier for the receiving event. Primary key for this product.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier that delivered the inbound shipment.',
    `dc_facility_id` BIGINT COMMENT 'Reference to the distribution center where the receiving event occurred.',
    `gtin_registry_id` BIGINT COMMENT 'Foreign key linking to product.gtin_registry. Business justification: GS1 receiving compliance: during inbound receiving, WMS scans GTINs to identify items. Linking receiving_event to gtin_registry replaces the denormalized gtin text column with a validated FK, enabling',
    `inbound_appointment_id` BIGINT COMMENT 'Foreign key linking to supplychain.inbound_appointment. Business justification: A receiving event is the physical unloading activity that occurs when a scheduled inbound appointment arrives at the dock. Linking receiving_event.inbound_appointment_id → inbound_appointment.inbound_',
    `inbound_shipment_id` BIGINT COMMENT 'Reference to the inbound shipment being received at the dock door.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supplychain.purchase_order. Business justification: receiving_event currently stores purchase_order_number as a denormalized STRING. Replacing this with a proper FK purchase_order_id → purchase_order.purchase_order_id normalizes the reference, enables ',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: Receiving events process season-coded merchandise. Season-level receiving variance (unit_variance_quantity, damage rates) is a standard retail DC operations report used by merchandise planners to asse',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Receiving events update specific stock positions (putaway to bin/position). Linking receiving_event to stock_position enables position-level receipt traceability and post-receipt inventory accuracy va',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier who shipped the goods being received.',
    `actual_carton_count` STRING COMMENT 'The actual number of cartons physically received and verified during the receiving event.',
    `actual_pallet_count` STRING COMMENT 'The actual number of pallets physically received and verified during the receiving event.',
    `actual_unit_quantity` STRING COMMENT 'The total number of individual units (eaches) physically received and verified during the receiving event.',
    `advance_ship_notice_number` STRING COMMENT 'The ASN number provided by the supplier, used to match expected shipment details with actual received goods.',
    `bill_of_lading_number` STRING COMMENT 'The bill of lading number associated with the inbound shipment, used for carrier reconciliation.',
    `carton_variance_count` STRING COMMENT 'The difference between expected and actual carton count (actual minus expected). Positive indicates overage, negative indicates shortage.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the receiving event record was first created in the warehouse management system.',
    `damage_flag` BOOLEAN COMMENT 'Indicates whether any damaged goods were identified during the receiving event.',
    `damaged_unit_quantity` STRING COMMENT 'The number of units identified as damaged during the receiving inspection.',
    `discrepancy_reason_code` STRING COMMENT 'Code indicating the reason for any discrepancy between expected and actual quantities (e.g., supplier short ship, damaged in transit, incorrect ASN).',
    `dock_door_number` STRING COMMENT 'The specific dock door assignment where the inbound shipment was unloaded.',
    `expected_carton_count` STRING COMMENT 'The number of cartons expected to be received based on the advance shipment notice or purchase order.',
    `expected_pallet_count` STRING COMMENT 'The number of pallets expected to be received based on the advance shipment notice or purchase order.',
    `expected_unit_quantity` STRING COMMENT 'The total number of individual units (eaches) expected to be received based on the advance shipment notice or purchase order.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the received shipment contains hazardous materials requiring special handling.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when the receiving event record was last modified in the warehouse management system.',
    `overage_flag` BOOLEAN COMMENT 'Indicates whether the receiving event resulted in an overage (more units received than expected).',
    `pallet_variance_count` STRING COMMENT 'The difference between expected and actual pallet count (actual minus expected). Positive indicates overage, negative indicates shortage.',
    `putaway_task_generated_flag` BOOLEAN COMMENT 'Indicates whether putaway tasks have been automatically generated in the WMS following the receiving event.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether the received goods require quality inspection before being made available for putaway or sale.',
    `receiving_event_number` STRING COMMENT 'Business-readable unique identifier for the receiving event, used for tracking and reporting.',
    `receiving_notes` STRING COMMENT 'Free-text notes entered by the receiving clerk documenting any observations, issues, or special handling instructions.',
    `receiving_status` STRING COMMENT 'Current lifecycle status of the receiving event.. Valid values are `scheduled|in_progress|completed|cancelled|on_hold|exception`',
    `receiving_type` STRING COMMENT 'Type of receiving operation: blind receiving (no advance shipment notice), directed receiving (with ASN), cross-dock, return to vendor, or inter-facility transfer.. Valid values are `blind|directed|cross_dock|return|transfer`',
    `seal_intact_flag` BOOLEAN COMMENT 'Indicates whether the security seal was found intact upon arrival. False indicates potential tampering or security breach.',
    `seal_number` STRING COMMENT 'The security seal number on the trailer or container, verified during receiving to ensure shipment integrity.',
    `shortage_flag` BOOLEAN COMMENT 'Indicates whether the receiving event resulted in a shortage (fewer units received than expected).',
    `temperature_compliant_flag` BOOLEAN COMMENT 'Indicates whether temperature-controlled shipments arrived within the required temperature range.',
    `temperature_reading` DECIMAL(18,2) COMMENT 'The actual temperature reading (in Celsius) recorded upon arrival for temperature-controlled shipments.',
    `trailer_number` STRING COMMENT 'The trailer or container number of the vehicle that delivered the shipment.',
    `unit_variance_quantity` STRING COMMENT 'The difference between expected and actual unit quantity (actual minus expected). Positive indicates overage, negative indicates shortage.',
    `unload_duration_minutes` STRING COMMENT 'Total time in minutes taken to unload the shipment, calculated from start to end timestamp.',
    `unload_end_timestamp` TIMESTAMP COMMENT 'The timestamp when the unloading of the inbound shipment was completed.',
    `unload_start_timestamp` TIMESTAMP COMMENT 'The timestamp when the unloading of the inbound shipment began at the dock door.',
    CONSTRAINT pk_receiving_event PRIMARY KEY(`receiving_event_id`)
) COMMENT 'Captures the physical receiving activity at a DC dock door when inbound shipments are unloaded and verified. Records dock door assignment, unload start/end timestamps, cartons received vs. expected, discrepancy flags (overage, shortage, damage), receiver employee ID, pallet count, and blind vs. directed receiving mode. Each receiving event is tied to an inbound shipment and drives put-away task generation in Manhattan WMS.';

CREATE OR REPLACE TABLE `retail_ecm`.`supplychain`.`warehouse_task` (
    `warehouse_task_id` BIGINT COMMENT 'Unique identifier for the warehouse task. Primary key for the warehouse task entity.',
    `asn_id` BIGINT COMMENT 'Foreign key reference to the inbound Advanced Ship Notice associated with putaway tasks. Links receiving tasks to expected inbound shipments.',
    `dc_facility_id` BIGINT COMMENT 'Foreign key reference to the distribution center or warehouse facility where this task is being executed.',
    `fulfillment_line_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_line. Business justification: Order-line-level warehouse task traceability: warehouse tasks (pick, putaway, replenishment) are executed to fulfill specific order lines; linking warehouse_task to fulfillment_line enables line-level',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order. Business justification: Fulfillment order labor cost attribution: warehouse tasks are generated to fulfill customer orders; linking warehouse_task to fulfillment_order enables order-level labor cost reporting, SLA breach roo',
    `gtin_registry_id` BIGINT COMMENT 'Foreign key linking to product.gtin_registry. Business justification: WMS task execution via GTIN scanning: putaway, pick, and pack tasks are driven by barcode scans. Linking warehouse_task to gtin_registry replaces the denormalized gtin text column, enabling the WMS to',
    `header_id` BIGINT COMMENT 'Foreign key reference to the customer order or replenishment order driving this warehouse task. Applicable for pick and pack tasks.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Warehouse tasks for FEFO-managed items operate on specific lots (lot_number is a denormalized plain attribute on warehouse_task). Linking warehouse_task to lot enables lot-directed picking and FEFO co',
    `receiving_event_id` BIGINT COMMENT 'Foreign key linking to supplychain.receiving_event. Business justification: Putaway tasks are generated from receiving events. WMS orchestration requires linking task to originating receipt for labor tracking, exception handling, and cycle time measurement. Standard DC workfl',
    `shipment_id` BIGINT COMMENT 'Foreign key reference to the outbound shipment associated with this task. Links pick tasks to their destination shipment.',
    `sku_id` BIGINT COMMENT 'Foreign key reference to the master product entity associated with this warehouse task.',
    `warehouse_zone_id` BIGINT COMMENT 'Foreign key linking to supplychain.warehouse_zone. Business justification: warehouse_task currently stores source_zone as a STRING code. Replacing with source_warehouse_zone_id → warehouse_zone.warehouse_zone_id normalizes the zone reference, enabling joins to zone capacity,',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Warehouse tasks (putaway, replenishment, pick) operate on specific stock positions. Linking warehouse_task to stock_position enables task-level inventory impact tracking and position-level task histor',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: DC warehouse tasks for store replenishment must reference the destination store department to enable direct-to-department putaway routing and department-level replenishment task tracking. Retail DC op',
    `uom_id` BIGINT COMMENT 'Foreign key linking to product.uom. Business justification: WMS quantity accuracy: warehouse tasks (pick, pack, putaway) specify quantities in a UOM that must resolve to the canonical UOM master for labor standards, inventory accuracy, and cartonization. Linki',
    `wave_id` BIGINT COMMENT 'Wave planning identifier grouping multiple tasks released together for coordinated execution. Used in wave-based picking strategies.',
    `actual_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of units completed or processed by the warehouse operator for this task. May differ from planned quantity in case of shorts or overages.',
    `created_timestamp` TIMESTAMP COMMENT 'Audit timestamp indicating when this warehouse task record was first inserted into the data warehouse or lakehouse. System-generated for data lineage tracking.',
    `equipment_type` STRING COMMENT 'Type of material handling equipment required or used for this task: forklift (counterbalance lift), reach_truck (narrow aisle reach), pallet_jack (manual or powered), order_picker (vertical picker), conveyor (automated transport), AMR (Autonomous Mobile Robot), AGV (Automated Guided Vehicle), manual (no equipment), tugger (tow tractor), or clamp_truck (specialized forklift). [ENUM-REF-CANDIDATE: forklift|reach_truck|pallet_jack|order_picker|conveyor|amr|agv|manual|tugger|clamp_truck — 10 candidates stripped; promote to reference product]',
    `exception_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this task encountered an exception condition requiring intervention or special handling.',
    `exception_notes` STRING COMMENT 'Free-text notes entered by the warehouse operator or supervisor providing additional context about the exception or task variance.',
    `exception_reason_code` STRING COMMENT 'Standardized code indicating the reason for task exception: short_pick (insufficient inventory), damaged_product, location_blocked, equipment_failure, quality_hold, mispick, system_error, or other predefined exception types.',
    `expiration_date` DATE COMMENT 'Product expiration or best-by date for perishable goods. Used for FEFO (First Expired First Out) picking logic and inventory rotation.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Audit timestamp indicating when this warehouse task record was most recently modified in the data warehouse or lakehouse. System-generated for change tracking.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'The quantity of units originally planned or requested for this warehouse task as generated by the WMS.',
    `standard_labor_minutes` DECIMAL(18,2) COMMENT 'Engineered labor standard time in minutes expected for this task type and quantity. Used for productivity variance analysis and incentive pay calculation.',
    `substituted_sku` STRING COMMENT 'The SKU that was actually picked or used if a substitution occurred, different from the originally planned SKU.',
    `substitution_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether a product substitution occurred during task execution due to stockout or allocation rules.',
    `target_zone` STRING COMMENT 'Logical warehouse zone classification for the target location. Used for labor planning and travel time optimization.',
    `task_assigned_timestamp` TIMESTAMP COMMENT 'Date and time when the task was assigned to a warehouse operator. Used for measuring task queue time and labor allocation efficiency.',
    `task_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the task was successfully completed or closed. Used for cycle time analysis and throughput measurement.',
    `task_created_timestamp` TIMESTAMP COMMENT 'Date and time when the warehouse task was originally generated by the WMS. Represents the business event timestamp for task creation.',
    `task_duration_minutes` DECIMAL(18,2) COMMENT 'Total elapsed time in minutes from task start to completion. Used for labor standards validation and engineered labor standards comparison.',
    `task_number` STRING COMMENT 'Human-readable business identifier for the warehouse task, typically generated by Manhattan WMS for tracking and reference purposes.',
    `task_priority` STRING COMMENT 'Numeric priority ranking for task execution sequencing within Manhattan WMS labor optimization engine. Lower numbers indicate higher priority. Used for task interleaving and dynamic work assignment.',
    `task_started_timestamp` TIMESTAMP COMMENT 'Date and time when the operator began actively working on the task. Used for calculating actual labor time and productivity metrics.',
    `task_status` STRING COMMENT 'Current lifecycle status of the warehouse task: pending (created but not assigned), assigned (allocated to operator), in_progress (operator actively working), completed (successfully finished), short (completed with quantity variance), cancelled (voided before completion), suspended (temporarily paused), or error (system exception encountered). [ENUM-REF-CANDIDATE: pending|assigned|in_progress|completed|short|cancelled|suspended|error — 8 candidates stripped; promote to reference product]',
    `task_type` STRING COMMENT 'Discriminator indicating the type of warehouse task: putaway (inbound receiving to storage), discrete_pick (single order pick), cluster_pick (multiple orders picked simultaneously), batch_pick (multiple SKUs for multiple orders), zone_pick (picking within assigned zone), replenishment (moving inventory from reserve to forward pick location), move (internal location transfer), cycle_count (inventory accuracy verification), consolidation (combining picked items), or packing (preparing items for shipment). [ENUM-REF-CANDIDATE: putaway|discrete_pick|cluster_pick|batch_pick|zone_pick|replenishment|move|cycle_count|consolidation|packing — 10 candidates stripped; promote to reference product]',
    `travel_distance_feet` DECIMAL(18,2) COMMENT 'Calculated or measured travel distance in feet between source and target locations. Used for slotting optimization and labor planning.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'The difference between planned quantity and actual quantity (actual minus planned). Positive values indicate overage, negative values indicate shortage.',
    CONSTRAINT pk_warehouse_task PRIMARY KEY(`warehouse_task_id`)
) COMMENT 'Represents any directed warehouse task generated within Manhattan WMS, covering putaway, picking, replenishment, cycle count, and internal movement task types. Captures task type discriminator (putaway, discrete_pick, cluster_pick, batch_pick, zone_pick, replenishment, move), SKU, quantity, lot/expiry, source location, target location, assigned operator, equipment type (forklift, reach truck, conveyor, AMR), task priority, task status (pending, assigned, in-progress, completed, short, cancelled), creation timestamp, completion timestamp, substitution flag, and exception reason. Unified SSOT for all directed work within the DC — eliminates separate putaway and pick task entities in favor of a single task management model consistent with Manhattan WMS task interleaving and labor optimization.';

CREATE OR REPLACE TABLE `retail_ecm`.`supplychain`.`outbound_order` (
    `outbound_order_id` BIGINT COMMENT 'Unique identifier for the distribution center outbound order. Primary key for this entity. Role: TRANSACTION_HEADER.',
    `assortment_plan_id` BIGINT COMMENT 'Foreign key linking to merchandising.assortment_plan. Business justification: DC-to-store outbound orders must be traceable to the assortment plan authorizing the SKU mix being shipped. Retail assortment compliance reporting requires knowing whether outbound shipments match the',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier assigned to deliver this outbound order.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: B2B wholesale DC fulfillment: retail DCs fulfill outbound orders against B2B customer accounts (wholesale buyers, franchise operators). Linking outbound_order to customer account enables account-level',
    `plan_id` BIGINT COMMENT 'Reference to the demand planning forecast or consensus demand plan that triggered this replenishment order. Links outbound execution to upstream planning.',
    `dc_facility_id` BIGINT COMMENT 'Identifier of the destination node (store, customer, DC, 3PL facility) receiving this shipment. Polymorphic reference interpreted based on destination_type.',
    `location_id` BIGINT COMMENT 'Foreign key linking to store.location. Business justification: DC-to-store replenishment outbound orders must reference the destination store location for store-level fill-rate reporting, delivery scheduling, and replenishment performance tracking. Retail supply ',
    `primary_outbound_dc_facility_id` BIGINT COMMENT 'Identifier of the distribution center or micro-fulfillment center (MFC) fulfilling this outbound order.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to customer.profile. Business justification: Direct-to-consumer DC fulfillment: in e-commerce and drop-ship retail, outbound orders from the DC fulfill a specific customers purchase. Linking outbound_order to customer profile enables order-to-c',
    `replenishment_order_id` BIGINT COMMENT 'Foreign key linking to inventory.replenishment_order. Business justification: A store replenishment_order is fulfilled as an outbound_order from the DC. Linking outbound_order to replenishment_order enables end-to-end replenishment cycle tracking from order creation to DC outbo',
    `replenishment_plan_id` BIGINT COMMENT 'Reference to the replenishment plan that generated this outbound order. Links execution to planning layer.',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: Outbound orders carry season-coded merchandise with specific ship windows and clearance timelines. Season-level outbound fill rate and on-time delivery are standard retail supply chain KPIs used in se',
    `sfs_fulfillment_node_id` BIGINT COMMENT 'Foreign key linking to store.sfs_fulfillment_node. Business justification: Ship-from-store outbound orders must reference the SFS fulfillment node executing the order for SFS capacity planning, node performance reporting, and order routing decisions. Retail omnichannel opera',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: DTC fulfillment address management: outbound_order stores denormalized destination address fields that duplicate customer.address. Replacing with a FK enforces 3NF, ensures address validation consiste',
    `sla_id` BIGINT COMMENT 'Foreign key linking to fulfillment.sla. Business justification: DC outbound order SLA compliance: outbound orders (DC-to-store, DC-to-DC replenishment) are governed by delivery SLAs; linking outbound_order to sla enables SLA breach detection, carrier selection dec',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Outbound orders from DCs consume inventory from specific stock positions. Linking outbound_order to stock_position enables ATP validation at order creation and inventory allocation for outbound fulfil',
    `wave_id` BIGINT COMMENT 'Identifier of the warehouse wave to which this order has been assigned for picking. Wave assignment groups orders for efficient batch picking.',
    `actual_delivery_date` DATE COMMENT 'Date when the order was confirmed delivered to the destination. Null until delivery confirmation is received.',
    `actual_ship_date` DATE COMMENT 'Date when the order was actually shipped from the facility. Null until shipment occurs.',
    `bill_of_lading_number` STRING COMMENT 'Bill of lading number issued for this shipment. Legal document acknowledging receipt of cargo for shipment.',
    `cancellation_reason_code` STRING COMMENT 'Code indicating the reason for order cancellation: inventory unavailable, destination closed, carrier unavailable, customer request, etc. Null if order not cancelled.',
    `carrier_service_level` STRING COMMENT 'Transportation service level selected for this shipment: ground (standard), express (expedited), next-day, two-day, same-day, LTL (Less Than Truckload), or FTL (Full Truckload). [ENUM-REF-CANDIDATE: ground|express|next_day|two_day|same_day|ltl|ftl — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this outbound order record was first created in the warehouse management system. Audit trail for record inception.',
    `destination_type` STRING COMMENT 'Type of destination node receiving this outbound shipment: store (retail location), customer (direct-to-consumer), distribution center (inter-DC transfer), 3PL node (third-party logistics partner), or supplier (return to vendor).. Valid values are `store|customer|distribution_center|3pl_node|supplier`',
    `dock_door_number` STRING COMMENT 'Outbound dock door number from which this order was loaded for shipment.',
    `fill_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of ordered units successfully fulfilled and shipped. Calculated as (shipped units / ordered units) * 100. Key supply chain KPI.',
    `is_cross_dock` BOOLEAN COMMENT 'Boolean flag indicating whether this order was fulfilled via cross-docking (direct transfer from inbound to outbound without storage).',
    `is_drop_ship` BOOLEAN COMMENT 'Boolean flag indicating whether this order is fulfilled via drop ship (vendor ships directly to customer, bypassing DC).',
    `is_hazmat` BOOLEAN COMMENT 'Boolean flag indicating whether this order contains hazardous materials requiring special handling and documentation.',
    `is_temperature_controlled` BOOLEAN COMMENT 'Boolean flag indicating whether this order requires temperature-controlled transportation (refrigerated or frozen goods).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this outbound order record was last modified. Audit trail for record changes.',
    `notes` STRING COMMENT 'Free-text notes or special instructions for this outbound order. May include handling instructions, delivery requirements, or operational comments.',
    `order_date` DATE COMMENT 'Date when the outbound order was created in the warehouse management system. Business event timestamp representing order inception.',
    `order_number` STRING COMMENT 'Business-facing unique order number assigned to this outbound shipment. Used for tracking and communication with destination nodes.',
    `order_status` STRING COMMENT 'Current lifecycle status of the outbound order in the warehouse management workflow. Tracks progression from order creation through final delivery or cancellation. [ENUM-REF-CANDIDATE: draft|released|waved|picking|picked|packing|packed|shipped|in_transit|delivered|closed|cancelled — 12 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the outbound order indicating the fulfillment purpose: store replenishment (push inventory to stores), e-commerce fulfillment (direct-to-customer), BOPIS (Buy Online Pick Up In Store), ROPIS (Reserve Online Pick Up In Store), inter-DC transfer (distribution center to distribution center), or DSD bypass (Direct Store Delivery bypass).. Valid values are `store_replenishment|ecommerce_fulfillment|bopis|ropis|inter_dc_transfer|dsd_bypass`',
    `priority_level` STRING COMMENT 'Priority classification for order fulfillment. Critical orders (e.g., stockout replenishment, promotional merchandise) are processed ahead of normal flow.. Valid values are `critical|high|normal|low`',
    `pro_number` STRING COMMENT 'Progressive number assigned by LTL carriers for freight tracking and billing.',
    `replenishment_reason_code` STRING COMMENT 'Code indicating the business reason for this replenishment order: stockout prevention, promotional support, seasonal refresh, new item introduction, etc.',
    `replenishment_type` STRING COMMENT 'For store replenishment orders: method used to determine replenishment quantities. Push (DC-initiated based on forecast), pull (store-requested), min-max (reorder point triggered), VMI (Vendor Managed Inventory), promotional (event-driven), seasonal (seasonal assortment), or new store (initial stock). [ENUM-REF-CANDIDATE: push|pull|min_max|vmi|promotional|seasonal|new_store — 7 candidates stripped; promote to reference product]',
    `requested_ship_date` DATE COMMENT 'Date by which the order is requested to ship from the distribution center or micro-fulfillment center. Used for planning and wave assignment.',
    `required_delivery_date` DATE COMMENT 'Date by which the order must be delivered to the destination node to meet business commitments or replenishment schedules.',
    `temperature_requirement` STRING COMMENT 'Temperature control requirement for this shipment: ambient (room temperature), refrigerated (2-8°C), frozen (below -18°C), or climate-controlled (specific range).. Valid values are `ambient|refrigerated|frozen|climate_controlled`',
    `total_cartons` STRING COMMENT 'Total number of cartons or cases packed for this outbound order.',
    `total_cube_m3` DECIMAL(18,2) COMMENT 'Total cubic volume of the outbound order in cubic meters. Used for trailer capacity planning and freight optimization.',
    `total_lines` STRING COMMENT 'Total number of distinct SKU line items included in this outbound order.',
    `total_pallets` STRING COMMENT 'Total number of pallets loaded for this outbound order.',
    `total_units` STRING COMMENT 'Total quantity of units (eaches) across all lines in this outbound order.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the outbound order in kilograms. Used for carrier selection and freight cost calculation.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking number for this shipment. Used for shipment visibility and proof of delivery.',
    `trailer_number` STRING COMMENT 'Identifier of the trailer or container loaded with this outbound order.',
    CONSTRAINT pk_outbound_order PRIMARY KEY(`outbound_order_id`)
) COMMENT 'Represents a distribution outbound order directing the DC or MFC to fulfill and ship goods to a destination (store, customer, 3PL node). Captures order type (store replenishment, e-commerce, BOPIS, DSD bypass, inter-DC transfer), destination node, requested ship date, required delivery date, priority level, total lines/units/weight/cube, wave assignment, and order status lifecycle (released, waved, picking, packed, shipped, closed). For store replenishment: captures replenishment type (push, pull, min-max, VMI), replenishment reason, demand planning source reference, and replenishment frequency. Central transactional entity for all DC outbound execution including store replenishment, e-commerce fulfillment, and inter-facility transfers.';

CREATE OR REPLACE TABLE `retail_ecm`.`supplychain`.`wave` (
    `wave_id` BIGINT COMMENT 'Unique identifier for the wave batch. Primary key.',
    `carrier_id` BIGINT COMMENT 'Shipping carrier assigned to transport the outbound shipments generated from this wave.',
    `dc_facility_id` BIGINT COMMENT 'Distribution center where this wave is being executed.',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: DC operations create promotional pick waves tied to specific campaigns for prioritized fulfillment of promotional inventory. The existing is_promotional flag on wave requires a direct FK to promo_ca',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: Waves in retail DCs are organized by season — seasonal merchandise pick waves have distinct priority, temperature, and timing requirements. Season-level wave pick productivity and fill rate reporting ',
    `sla_id` BIGINT COMMENT 'Foreign key linking to fulfillment.sla. Business justification: Wave prioritization by SLA: retail DCs build and prioritize waves based on SLA commitments (same-day, next-day); linking wave to sla enables SLA-driven wave sequencing, breach risk scoring, and carrie',
    `actual_pick_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the last pick task in this wave was completed.',
    `actual_pick_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the first pick task in this wave was started by warehouse associates.',
    `assigned_pick_zones` STRING COMMENT 'Comma-separated list of warehouse pick zone identifiers assigned to this wave for zone-based picking strategies.',
    `carrier_service_level` STRING COMMENT 'Shipping service level for this wave (e.g., ground, two-day, next-day, same-day) determining delivery speed and cost.',
    `channel` STRING COMMENT 'Destination channel for orders in this wave: store_replenishment (DC to store), ecommerce (DC to customer), BOPIS (buy online pick up in store), ship_from_store, wholesale (B2B), marketplace (third-party platform).. Valid values are `store_replenishment|ecommerce|bopis|ship_from_store|wholesale|marketplace`',
    `consolidation_location` STRING COMMENT 'Warehouse staging area or dock door where picked items from this wave are consolidated for packing and shipping.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this wave record was first created in the WMS system.',
    `equipment_type` STRING COMMENT 'Primary material handling equipment or picking technology allocated for this wave execution.. Valid values are `cart|pallet_jack|forklift|pick_to_light|voice_pick|rf_scanner`',
    `fill_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of ordered units successfully picked, calculated as (picked_units / total_units) * 100, measuring wave execution effectiveness.',
    `generation_method` STRING COMMENT 'Method used to create this wave: scheduled (time-based automatic), manual (planner-initiated), demand_triggered (order volume threshold), threshold_based (inventory or capacity rule).. Valid values are `scheduled|manual|demand_triggered|threshold_based`',
    `is_hazmat` BOOLEAN COMMENT 'Indicates whether this wave contains hazardous materials requiring special handling, labeling, and compliance documentation per DOT regulations.',
    `is_promotional` BOOLEAN COMMENT 'Indicates whether this wave contains orders driven by promotional campaigns or special marketing events requiring expedited handling.',
    `is_temperature_controlled` BOOLEAN COMMENT 'Indicates whether this wave requires temperature-controlled handling and storage (refrigerated or frozen goods).',
    `labor_hours_actual` DECIMAL(18,2) COMMENT 'Actual total labor hours consumed by warehouse associates to complete this wave, measured from task start to completion.',
    `labor_hours_planned` DECIMAL(18,2) COMMENT 'Estimated total labor hours required to complete picking, packing, and staging for this wave, used for workforce scheduling.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this wave record was most recently modified, tracking status changes and execution progress.',
    `notes` STRING COMMENT 'Free-text operational notes or special instructions for warehouse associates executing this wave (e.g., gift wrap required, fragile items, rush processing).',
    `picked_units` STRING COMMENT 'Actual quantity of units successfully picked and confirmed for this wave.',
    `planned_pick_end_timestamp` TIMESTAMP COMMENT 'Scheduled date and time for picking operations to complete for this wave.',
    `planned_pick_start_timestamp` TIMESTAMP COMMENT 'Scheduled date and time for picking operations to begin for this wave.',
    `priority_rank` STRING COMMENT 'Numeric priority ranking for wave execution sequencing, with lower numbers indicating higher priority for labor allocation and equipment assignment.',
    `release_timestamp` TIMESTAMP COMMENT 'Date and time when the wave was released to the warehouse floor for picking execution.',
    `short_ship_disposition` STRING COMMENT 'Business rule applied to handle short-picked units: cancel (remove from order), backorder (fulfill later), substitute (offer alternative SKU), split_shipment (ship partial now).. Valid values are `cancel|backorder|substitute|split_shipment`',
    `short_units` STRING COMMENT 'Quantity of units that could not be picked due to inventory shortage or location discrepancies.',
    `temperature_zone` STRING COMMENT 'Required temperature control zone for this wave: ambient (room temperature), refrigerated (33-40°F), frozen (0°F or below).. Valid values are `ambient|refrigerated|frozen`',
    `template_code` BIGINT COMMENT 'Reference to the wave template configuration that defines the rules and parameters used to generate this wave.',
    `total_cartons` STRING COMMENT 'Total number of cartons or shipping containers generated from this wave for outbound shipment.',
    `total_order_lines` STRING COMMENT 'Total count of order line items included in this wave batch for picking.',
    `total_units` STRING COMMENT 'Total quantity of individual units (eaches) to be picked across all lines in this wave.',
    `units_per_hour` DECIMAL(18,2) COMMENT 'Productivity metric calculated as picked_units divided by labor_hours_actual, measuring warehouse picking efficiency.',
    `wave_number` STRING COMMENT 'Business-facing wave identifier used for operational tracking and communication across warehouse teams.',
    `wave_status` STRING COMMENT 'Current lifecycle state of the wave: planned (created but not released), released (available for picking), in-progress (actively being picked), short-closed (closed with shortages), complete (all lines picked), cancelled (wave aborted).. Valid values are `planned|released|in_progress|short_closed|complete|cancelled`',
    `wave_type` STRING COMMENT 'Classification of wave picking strategy: single-order (discrete pick per order), multi-order (batch pick across orders), cluster (cart-based multi-order), zone (pick within assigned zones), wave-less (continuous release), demand-based (dynamic priority-driven release).. Valid values are `single_order|multi_order|cluster|zone|wave_less|demand_based`',
    CONSTRAINT pk_wave PRIMARY KEY(`wave_id`)
) COMMENT 'A wave is a batch grouping of outbound order lines released together for coordinated picking within a DC. Captures wave number, wave type (single-order, multi-order, cluster, zone, demand-based), release timestamp, planned pick start/end, total lines, total units, assigned pick zones, wave status (planned, released, in-progress, short-closed, complete), fill rate, and short-ship disposition rule. Wave management is a core Manhattan WMS workflow that drives labor scheduling, equipment allocation, and pick zone sequencing for optimal DC throughput.';

CREATE OR REPLACE TABLE `retail_ecm`.`supplychain`.`outbound_shipment` (
    `outbound_shipment_id` BIGINT COMMENT 'Primary key for outbound_shipment',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier responsible for moving the shipment from origin to destination.',
    `carrier_rate_id` BIGINT COMMENT 'Foreign key linking to fulfillment.carrier_rate. Business justification: Freight cost reconciliation for DC outbound shipments: carrier rates applied to outbound shipments must be traceable for freight invoice auditing, contract compliance, and transportation spend analyti',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to fulfillment.carrier_service. Business justification: DC outbound shipment SLA and cost tracking: carrier service governs transit time SLA and rate for DC-to-store/DC-to-DC shipments; linking outbound_shipment to carrier_service enables service-level com',
    `dc_facility_id` BIGINT COMMENT 'Identifier of the destination entity (store, customer address, 3PL node, or DC) receiving the shipment.',
    `outbound_order_id` BIGINT COMMENT 'Foreign key linking to supplychain.outbound_order. Business justification: An outbound shipment is the physical dispatch that fulfills an outbound order. Without this FK, outbound_shipment is only connected to wave and dc_facility, with no direct link to the order it fulfill',
    `primary_outbound_dc_facility_id` BIGINT COMMENT 'Identifier of the distribution center, micro-fulfillment center, or dark store from which the shipment originates.',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: Outbound shipments carry season-coded merchandise to stores. Season-level outbound fill rate and on-time delivery performance are standard retail supply chain KPIs reported in seasonal merchandise rev',
    `wave_id` BIGINT COMMENT 'Identifier of the warehouse picking wave that generated the orders included in this shipment.',
    `actual_delivery_date` DATE COMMENT 'The actual calendar date on which the shipment was delivered and received at the destination.',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'The precise date and time when the shipment was delivered and signed for at the destination.',
    `bill_of_lading_number` STRING COMMENT 'Legal document number issued by the carrier acknowledging receipt of cargo for shipment.',
    `carrier_scac_code` STRING COMMENT 'Four-letter code uniquely identifying the transportation carrier, assigned by the National Motor Freight Traffic Association.. Valid values are `^[A-Z]{2,4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the shipment record was first created in the warehouse management system.',
    `destination_type` STRING COMMENT 'Classification of the destination entity type to which the shipment is being sent.. Valid values are `store|customer|3pl_node|dc|vendor`',
    `dock_door_number` STRING COMMENT 'Identifier of the loading dock door from which the shipment was dispatched at the origin facility.',
    `estimated_delivery_date` DATE COMMENT 'The carrier-provided or system-calculated expected delivery date at the destination.',
    `exception_code` STRING COMMENT 'Code identifying the type of exception or issue encountered during shipment processing or transit (e.g., damaged, delayed, refused).',
    `exception_description` STRING COMMENT 'Detailed description of any exception or issue encountered during shipment processing, loading, transit, or delivery.',
    `freight_cost` DECIMAL(18,2) COMMENT 'Total transportation cost charged by the carrier for moving the shipment from origin to destination.',
    `freight_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the freight cost amount.. Valid values are `^[A-Z]{3}$`',
    `is_hazmat` BOOLEAN COMMENT 'Indicates whether the shipment contains hazardous materials requiring special handling and documentation.',
    `is_temperature_controlled` BOOLEAN COMMENT 'Indicates whether the shipment requires temperature-controlled transportation (refrigerated or frozen).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when the shipment record was most recently modified or updated.',
    `manifest_number` STRING COMMENT 'Unique identifier for the carrier manifest document that groups multiple shipments for a single carrier pickup or route.',
    `notes` STRING COMMENT 'Free-form text field for additional shipment instructions, special handling requirements, or operational notes.',
    `on_time_delivery_flag` BOOLEAN COMMENT 'Indicates whether the shipment was delivered on or before the estimated delivery date, used for carrier performance measurement.',
    `pro_number` STRING COMMENT 'Progressive number assigned by Less-Than-Truckload (LTL) carriers to track freight shipments.',
    `seal_number` STRING COMMENT 'Unique identifier of the tamper-evident seal applied to the trailer or container to ensure shipment integrity during transit.',
    `service_level` STRING COMMENT 'The transportation service tier selected for this shipment, defining speed and handling characteristics. [ENUM-REF-CANDIDATE: ground|express|same_day|next_day|two_day|ltl|ftl|parcel — 8 candidates stripped; promote to reference product]',
    `ship_date` DATE COMMENT 'The calendar date on which the shipment departed the origin facility.',
    `ship_timestamp` TIMESTAMP COMMENT 'The precise date and time when the shipment departed the origin facility and was handed over to the carrier.',
    `shipment_number` STRING COMMENT 'Business-facing unique shipment number used for tracking and reference across systems and with carriers.',
    `shipment_status` STRING COMMENT 'Current lifecycle status of the outbound shipment indicating its position in the fulfillment workflow. [ENUM-REF-CANDIDATE: manifested|loading|staged|in_transit|delivered|exception|cancelled — 7 candidates stripped; promote to reference product]',
    `shipment_type` STRING COMMENT 'Classification of the shipment based on its business purpose and destination type.. Valid values are `store_replenishment|customer_direct|cross_dock|transfer|return_to_vendor`',
    `temperature_requirement` STRING COMMENT 'Specifies the temperature control requirement for the shipment during transportation.. Valid values are `ambient|refrigerated|frozen|climate_controlled`',
    `total_cartons` STRING COMMENT 'Total number of cartons or packages included in the shipment.',
    `total_cube_m3` DECIMAL(18,2) COMMENT 'Total volumetric cube of the shipment in cubic meters, used for capacity planning and freight costing.',
    `total_pallets` STRING COMMENT 'Total number of pallets included in the shipment.',
    `total_units` STRING COMMENT 'Total number of individual SKU units included across all cartons in the shipment.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the shipment in kilograms, including packaging materials.',
    `tracking_number` STRING COMMENT 'Primary carrier-assigned tracking number used to monitor shipment progress and delivery status.',
    `trailer_number` STRING COMMENT 'Unique identifier of the trailer or vehicle used to transport the shipment.',
    CONSTRAINT pk_outbound_shipment PRIMARY KEY(`outbound_shipment_id`)
) COMMENT 'Represents a physical outbound shipment dispatched from a DC or MFC to a destination (store, customer, 3PL node). Captures shipment number, carrier and SCAC code, service level (ground, express, same-day, LTL, FTL), trailer/vehicle ID, seal number, manifest ID, total cartons, total pallets, total weight/cube, ship date/time, estimated and actual delivery dates, shipment status (manifested, loading, in-transit, delivered, exception), and tracking numbers. Includes carton-level packing detail: pack station ID, operator, carton/tote ID, items packed (SKU, quantity, lot), carton weight/dimensions, void fill, shipping label reference, packing slip, QC check result (pass/fail/repack), and pack completion timestamp. SSOT for outbound shipment execution, carton-level tracking, and carrier manifesting within the distribution domain.';

CREATE OR REPLACE TABLE `retail_ecm`.`supplychain`.`inventory_transfer` (
    `inventory_transfer_id` BIGINT COMMENT 'Unique identifier for the inventory transfer transaction. Primary key for the inventory transfer entity.',
    `carrier_id` BIGINT COMMENT 'Identifier of the carrier or logistics provider handling the transfer shipment. Links to the carrier master record for transportation tracking.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to fulfillment.carrier_service. Business justification: Inter-facility transfer transit time and cost tracking: the carrier service used for inventory transfers determines transit days and freight cost; linking inventory_transfer to carrier_service enables',
    `cost_price_id` BIGINT COMMENT 'Foreign key linking to pricing.cost_price. Business justification: Inventory transfer valuation for intercompany accounting and financial reporting requires referencing the governing cost_price record. Retail finance teams use this for stock transfer order (STO) cost',
    `dc_facility_id` BIGINT COMMENT 'Identifier of the facility to which inventory is being transferred. Target location for the stock movement.',
    `location_id` BIGINT COMMENT 'Foreign key linking to store.location. Business justification: DC-to-store and store-to-store inventory transfers must reference the destination store location for transfer tracking, store inventory reconciliation, and inter-store balancing reports. Retail operat',
    `gtin_registry_id` BIGINT COMMENT 'Foreign key linking to product.gtin_registry. Business justification: Inter-facility transfer documentation: inventory transfers reference GTINs for item tracking across DC and store locations. Linking inventory_transfer to gtin_registry replaces the denormalized gtin t',
    `merch_plan_id` BIGINT COMMENT 'Foreign key linking to merchandising.merch_plan. Business justification: Inter-DC and DC-to-store inventory transfers are authorized within merchandise plan OTB and inventory rebalancing budgets. Retail finance requires transfer costs to be tracked against merch plan cost ',
    `inventory_node_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_node. Business justification: Store-to-store and DC-to-store transfers require origin_inventory_node_id to track stock movement from specific nodes. Existing origin_facility_id targets dc_facility only; retail needs inventory_node',
    `primary_inventory_dc_facility_id` BIGINT COMMENT 'Identifier of the facility from which inventory is being transferred. Source location for the stock movement.',
    `replenishment_plan_id` BIGINT COMMENT 'Identifier linking this transfer to a replenishment plan if the transfer is driven by automated replenishment logic. References the supply planning record that triggered the transfer.',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: Inventory transfers in retail are frequently triggered by end-of-season clearance rebalancing or seasonal stock positioning. Season-level transfer cost and inventory rebalancing reporting is a standar',
    `sku_id` BIGINT COMMENT 'Identifier of the product being transferred. Links to the master product record for the Stock Keeping Unit (SKU) being moved.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Inventory transfers move stock from a specific origin stock_position. Linking inventory_transfer to stock_position enables position-level transfer traceability and in-transit inventory valuation — req',
    `uom_id` BIGINT COMMENT 'Foreign key linking to product.uom. Business justification: Transfer quantity normalization: inventory transfers specify quantities in a UOM that must resolve to the canonical UOM master for accurate inventory accounting across origin and destination facilitie',
    `actual_receipt_date` DATE COMMENT 'Date when the inventory was actually received and confirmed at the destination facility. Marks completion of the transfer transaction.',
    `actual_ship_date` DATE COMMENT 'Date when the inventory was actually shipped from the origin facility. Used for performance tracking and transit time calculation.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the transfer order was approved. Marks the authorization point in the transfer lifecycle for audit and compliance purposes.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the transfer order. Used for audit trail and accountability in inventory movement authorization.',
    `asn_number` STRING COMMENT 'Advanced Ship Notice number sent to the destination facility. EDI 856 transaction identifier providing advance notification of incoming inventory.. Valid values are `^ASN-[0-9]{8,12}$`',
    `carrier_scac_code` STRING COMMENT 'Standard Carrier Alpha Code identifying the transportation carrier. Four-letter code assigned by the National Motor Freight Traffic Association (NMFTA) for carrier identification.. Valid values are `^[A-Z]{2,4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the transfer order record was first created in the system. Audit field tracking the initial creation of the transfer transaction.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transfer value. Indicates the currency in which inventory costs are denominated.. Valid values are `^[A-Z]{3}$`',
    `destination_facility_type` STRING COMMENT 'Type classification of the destination facility. Indicates whether the target is a Distribution Center (DC), Micro-Fulfillment Center (MFC), store, Third-Party Logistics (3PL) provider, or vendor location.. Valid values are `dc|mfc|store|3pl|vendor`',
    `expected_receipt_date` DATE COMMENT 'Date when the inventory is expected to arrive at the destination facility. Used for receiving planning and inventory availability forecasting.',
    `freight_cost` DECIMAL(18,2) COMMENT 'Transportation cost incurred for moving the inventory between facilities. Used for total cost of ownership analysis and logistics expense tracking.',
    `is_cross_dock` BOOLEAN COMMENT 'Flag indicating whether this transfer is part of a cross-docking operation where inventory moves directly from inbound to outbound without storage. True if cross-dock, false otherwise.',
    `is_hazmat` BOOLEAN COMMENT 'Flag indicating whether the transferred inventory contains hazardous materials requiring special handling and compliance. True if hazmat, false otherwise.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the transfer order record was last modified. Audit field tracking the most recent change to any attribute of the transfer transaction.',
    `lot_number` STRING COMMENT 'Lot or batch number for the inventory being transferred. Used for traceability, quality control, and recall management, particularly for perishable or regulated goods.. Valid values are `^[A-Z0-9-]{4,30}$`',
    `notes` STRING COMMENT 'Free-text notes or comments about the transfer. Captures special instructions, handling requirements, or contextual information for the transfer transaction.',
    `origin_facility_type` STRING COMMENT 'Type classification of the origin facility. Indicates whether the source is a Distribution Center (DC), Micro-Fulfillment Center (MFC), store, Third-Party Logistics (3PL) provider, or vendor location.. Valid values are `dc|mfc|store|3pl|vendor`',
    `priority_level` STRING COMMENT 'Priority classification for the transfer order. Determines handling urgency and shipping method selection for time-sensitive inventory movements.. Valid values are `urgent|high|normal|low`',
    `received_quantity` DECIMAL(18,2) COMMENT 'Actual quantity received and confirmed at the destination facility. May differ from shipped quantity due to damage, loss, or discrepancies during transit.',
    `requested_ship_date` DATE COMMENT 'Date when the inventory is requested to be shipped from the origin facility. Represents the planned or desired shipment date for supply chain planning.',
    `serial_number` STRING COMMENT 'Serial number for serialized inventory items being transferred. Provides unit-level traceability for high-value or regulated products.. Valid values are `^[A-Z0-9-]{6,40}$`',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'Actual quantity shipped from the origin facility. May differ from transfer quantity due to stock availability or last-minute adjustments.',
    `temperature_controlled` BOOLEAN COMMENT 'Flag indicating whether the inventory requires temperature-controlled transportation and storage. True if temperature-sensitive, false otherwise.',
    `temperature_requirement` STRING COMMENT 'Specific temperature control requirement for the transferred inventory. Defines the storage and transit temperature range needed to maintain product quality and safety.. Valid values are `frozen|refrigerated|ambient|controlled`',
    `total_transfer_value` DECIMAL(18,2) COMMENT 'Total monetary value of the inventory transfer calculated as unit cost multiplied by transfer quantity. Used for financial reporting and inventory valuation.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking number for the transfer shipment. Used for real-time shipment visibility and proof of delivery.. Valid values are `^[A-Z0-9-]{8,40}$`',
    `transfer_order_number` STRING COMMENT 'Business-facing unique transfer order number used for tracking and reference across systems and facilities. Externally visible identifier for the transfer transaction.. Valid values are `^TO-[0-9]{8,12}$`',
    `transfer_quantity` DECIMAL(18,2) COMMENT 'Quantity of units being transferred from origin to destination facility. Represents the planned or actual number of items moved in the transfer transaction.',
    `transfer_reason_code` STRING COMMENT 'Coded reason for the inventory transfer. Provides standardized classification of why the stock movement is occurring for analytics and operational planning. [ENUM-REF-CANDIDATE: rebalancing|replenishment|returns|excess_stock|damaged_goods|recall|seasonal_shift — 7 candidates stripped; promote to reference product]',
    `transfer_status` STRING COMMENT 'Current lifecycle status of the inventory transfer order. Tracks progression from draft through approval, shipment, and receipt confirmation.. Valid values are `draft|approved|in_transit|received|cancelled|rejected`',
    `transfer_type` STRING COMMENT 'Classification of the transfer purpose. Indicates the business reason driving the inventory movement between facilities.. Valid values are `rebalancing|store_replenishment|returns_consolidation|emergency_stock|seasonal_redistribution|new_store_stocking`',
    CONSTRAINT pk_inventory_transfer PRIMARY KEY(`inventory_transfer_id`)
) COMMENT 'Records inter-facility inventory transfer orders and movements between DCs, MFCs, stores, and 3PL nodes. Captures transfer order number, origin facility, destination facility, SKU, transfer quantity, unit of measure, lot/batch, transfer reason (rebalancing, store replenishment, returns consolidation), requested ship date, actual ship date, receipt confirmation date, and transfer status. Distinct from inbound supplier shipments — this entity owns internal stock movement.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ADD CONSTRAINT `fk_supplychain_replenishment_plan_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `retail_ecm`.`supplychain`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ADD CONSTRAINT `fk_supplychain_replenishment_plan_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `retail_ecm`.`supplychain`.`plan`(`plan_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ADD CONSTRAINT `fk_supplychain_purchase_order_blanket_po_purchase_order_id` FOREIGN KEY (`blanket_po_purchase_order_id`) REFERENCES `retail_ecm`.`supplychain`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ADD CONSTRAINT `fk_supplychain_purchase_order_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ADD CONSTRAINT `fk_supplychain_purchase_order_replenishment_plan_id` FOREIGN KEY (`replenishment_plan_id`) REFERENCES `retail_ecm`.`supplychain`.`replenishment_plan`(`replenishment_plan_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ADD CONSTRAINT `fk_supplychain_po_line_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ADD CONSTRAINT `fk_supplychain_po_line_replenishment_plan_id` FOREIGN KEY (`replenishment_plan_id`) REFERENCES `retail_ecm`.`supplychain`.`replenishment_plan`(`replenishment_plan_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ADD CONSTRAINT `fk_supplychain_po_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `retail_ecm`.`supplychain`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ADD CONSTRAINT `fk_supplychain_plan_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ADD CONSTRAINT `fk_supplychain_plan_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `retail_ecm`.`supplychain`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ADD CONSTRAINT `fk_supplychain_inbound_appointment_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ADD CONSTRAINT `fk_supplychain_inbound_appointment_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `retail_ecm`.`supplychain`.`inbound_shipment`(`inbound_shipment_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ADD CONSTRAINT `fk_supplychain_inbound_appointment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `retail_ecm`.`supplychain`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ADD CONSTRAINT `fk_supplychain_warehouse_zone_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ADD CONSTRAINT `fk_supplychain_inbound_shipment_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ADD CONSTRAINT `fk_supplychain_inbound_shipment_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `retail_ecm`.`supplychain`.`po_line`(`po_line_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ADD CONSTRAINT `fk_supplychain_inbound_shipment_primary_inbound_dc_facility_id` FOREIGN KEY (`primary_inbound_dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ADD CONSTRAINT `fk_supplychain_inbound_shipment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `retail_ecm`.`supplychain`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ADD CONSTRAINT `fk_supplychain_receiving_event_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ADD CONSTRAINT `fk_supplychain_receiving_event_inbound_appointment_id` FOREIGN KEY (`inbound_appointment_id`) REFERENCES `retail_ecm`.`supplychain`.`inbound_appointment`(`inbound_appointment_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ADD CONSTRAINT `fk_supplychain_receiving_event_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `retail_ecm`.`supplychain`.`inbound_shipment`(`inbound_shipment_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ADD CONSTRAINT `fk_supplychain_receiving_event_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `retail_ecm`.`supplychain`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ADD CONSTRAINT `fk_supplychain_warehouse_task_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ADD CONSTRAINT `fk_supplychain_warehouse_task_receiving_event_id` FOREIGN KEY (`receiving_event_id`) REFERENCES `retail_ecm`.`supplychain`.`receiving_event`(`receiving_event_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ADD CONSTRAINT `fk_supplychain_warehouse_task_warehouse_zone_id` FOREIGN KEY (`warehouse_zone_id`) REFERENCES `retail_ecm`.`supplychain`.`warehouse_zone`(`warehouse_zone_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ADD CONSTRAINT `fk_supplychain_warehouse_task_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `retail_ecm`.`supplychain`.`wave`(`wave_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ADD CONSTRAINT `fk_supplychain_outbound_order_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `retail_ecm`.`supplychain`.`plan`(`plan_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ADD CONSTRAINT `fk_supplychain_outbound_order_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ADD CONSTRAINT `fk_supplychain_outbound_order_primary_outbound_dc_facility_id` FOREIGN KEY (`primary_outbound_dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ADD CONSTRAINT `fk_supplychain_outbound_order_replenishment_plan_id` FOREIGN KEY (`replenishment_plan_id`) REFERENCES `retail_ecm`.`supplychain`.`replenishment_plan`(`replenishment_plan_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ADD CONSTRAINT `fk_supplychain_outbound_order_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `retail_ecm`.`supplychain`.`wave`(`wave_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ADD CONSTRAINT `fk_supplychain_wave_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ADD CONSTRAINT `fk_supplychain_outbound_shipment_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ADD CONSTRAINT `fk_supplychain_outbound_shipment_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `retail_ecm`.`supplychain`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ADD CONSTRAINT `fk_supplychain_outbound_shipment_primary_outbound_dc_facility_id` FOREIGN KEY (`primary_outbound_dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ADD CONSTRAINT `fk_supplychain_outbound_shipment_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `retail_ecm`.`supplychain`.`wave`(`wave_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ADD CONSTRAINT `fk_supplychain_inventory_transfer_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ADD CONSTRAINT `fk_supplychain_inventory_transfer_primary_inventory_dc_facility_id` FOREIGN KEY (`primary_inventory_dc_facility_id`) REFERENCES `retail_ecm`.`supplychain`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ADD CONSTRAINT `fk_supplychain_inventory_transfer_replenishment_plan_id` FOREIGN KEY (`replenishment_plan_id`) REFERENCES `retail_ecm`.`supplychain`.`replenishment_plan`(`replenishment_plan_id`);

-- ========= TAGS =========
ALTER SCHEMA `retail_ecm`.`supplychain` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `retail_ecm`.`supplychain` SET TAGS ('dbx_domain' = 'supplychain');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` SET TAGS ('dbx_subdomain' = 'demand_planning');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `replenishment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Plan ID');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `assortment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Plan Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `cost_price_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Price Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `demand_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan ID');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `inventory_node_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Chain Node ID');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `merch_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Merch Plan Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `approved_order_qty` SET TAGS ('dbx_business_glossary_term' = 'Approved Order Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `buyer_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Buyer Override Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `current_on_hand_qty` SET TAGS ('dbx_business_glossary_term' = 'Current On-Hand Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `demand_variability_factor` SET TAGS ('dbx_business_glossary_term' = 'Demand Variability Factor (Coefficient of Variation)');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `fill_rate_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Target Percentage');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `forecasted_demand_qty` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Demand Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Supplier Lead Time (Days)');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `min_order_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Value (MOV)');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `moq` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `moq_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Compliance Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `node_type` SET TAGS ('dbx_business_glossary_term' = 'Supply Chain Node Type');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `node_type` SET TAGS ('dbx_value_regex' = 'store|dc|mfc|dark_store');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `on_order_qty` SET TAGS ('dbx_business_glossary_term' = 'On-Order Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `order_multiple` SET TAGS ('dbx_business_glossary_term' = 'Order Multiple (Pack Size)');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `order_release_date` SET TAGS ('dbx_business_glossary_term' = 'Order Release Date');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `override_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Buyer Override Reason Code');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `override_reason_code` SET TAGS ('dbx_value_regex' = 'promotional_uplift|supplier_constraint|excess_inventory|demand_correction|system_error|other');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `plan_generation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Plan Generation Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `plan_horizon_end_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Horizon End Date');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `plan_horizon_start_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Horizon Start Date');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Plan Status');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Plan Type');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'automated|manual|override|emergency');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `planned_order_qty` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `planned_order_value` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Value');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `planned_order_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `planned_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Receipt Date');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `promotion_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion-Driven Replenishment Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point (ROP)');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `replenishment_method` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Method');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `replenishment_method` SET TAGS ('dbx_value_regex' = 'min_max|reorder_point|days_of_supply|vendor_managed|cross_dock|dsd');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `safety_stock_method` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Calculation Method');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `safety_stock_method` SET TAGS ('dbx_value_regex' = 'fixed|statistical|days_of_supply|service_level_based');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `safety_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `service_level_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Service Level Target Percentage');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'blue_yonder|sap_s4hana|orms|manual');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`replenishment_plan` ALTER COLUMN `weeks_of_supply_target` SET TAGS ('dbx_business_glossary_term' = 'Weeks of Supply (WOS) Target');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` SET TAGS ('dbx_subdomain' = 'demand_planning');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `demand_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast ID');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `assortment_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `assortment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Plan Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `merch_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Merch Plan Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `baseline_forecast_units` SET TAGS ('dbx_business_glossary_term' = 'Baseline Forecast Units');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `confidence_level_pct` SET TAGS ('dbx_business_glossary_term' = 'Forecast Confidence Level Percentage');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `demand_category` SET TAGS ('dbx_business_glossary_term' = 'Demand Category');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `demand_category` SET TAGS ('dbx_value_regex' = 'regular|intermittent|lumpy|new_item|end_of_life');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `forecast_bias` SET TAGS ('dbx_business_glossary_term' = 'Forecast Bias');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `forecast_generation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Generation Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `forecast_horizon_weeks` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon (Weeks)');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `forecast_lower_bound_units` SET TAGS ('dbx_business_glossary_term' = 'Forecast Lower Bound Units');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `forecast_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period End Date');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `forecast_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period Start Date');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `forecast_run_number` SET TAGS ('dbx_business_glossary_term' = 'Forecast Run ID');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Status');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_value_regex' = 'draft|published|approved|overridden|superseded|archived');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Type');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_value_regex' = 'baseline|promotional|seasonal|event_driven|consensus');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `forecast_upper_bound_units` SET TAGS ('dbx_business_glossary_term' = 'Forecast Upper Bound Units');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `forecast_version` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `forecasted_revenue` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Revenue');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `forecasted_units` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Units');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `is_latest_version` SET TAGS ('dbx_business_glossary_term' = 'Latest Version Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `is_new_item` SET TAGS ('dbx_business_glossary_term' = 'New Item Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `is_override_applied` SET TAGS ('dbx_business_glossary_term' = 'Override Applied Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `is_promotional_period` SET TAGS ('dbx_business_glossary_term' = 'Promotional Period Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `mape` SET TAGS ('dbx_business_glossary_term' = 'Mean Absolute Percentage Error (MAPE)');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Statistical Model Version');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `model_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+$');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `otb_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Open-to-Buy (OTB) Impact Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `override_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Override Reason Code');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `override_units` SET TAGS ('dbx_business_glossary_term' = 'Override Units');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `planning_channel` SET TAGS ('dbx_business_glossary_term' = 'Planning Channel');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `planning_channel` SET TAGS ('dbx_value_regex' = 'store|ecommerce|omnichannel|dc_replenishment|bopis');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `promotional_lift_units` SET TAGS ('dbx_business_glossary_term' = 'Promotional Lift Units');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `replenishment_recommendation_units` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Recommendation Units');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `seasonality_index` SET TAGS ('dbx_business_glossary_term' = 'Seasonality Index');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `statistical_model_code` SET TAGS ('dbx_business_glossary_term' = 'Statistical Model Code');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `time_bucket_granularity` SET TAGS ('dbx_business_glossary_term' = 'Time Bucket Granularity');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `time_bucket_granularity` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `trend_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Trend Adjustment Factor');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `weeks_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Weeks of Supply (WOS)');
ALTER TABLE `retail_ecm`.`supplychain`.`demand_forecast` ALTER COLUMN `wmape` SET TAGS ('dbx_business_glossary_term' = 'Weighted Mean Absolute Percentage Error (WMAPE)');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` SET TAGS ('dbx_subdomain' = 'procurement_sourcing');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Identifier');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `blanket_po_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Purchase Order ID');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `buyer_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer ID');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Item Hierarchy Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `merch_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Merch Plan Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `replenishment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Plan Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Approval Status');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Approved Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Cancellation Date');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Discount Amount');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `edi_transmission_status` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transmission Status');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `edi_transmission_status` SET TAGS ('dbx_value_regex' = 'not_sent|pending|transmitted|acknowledged|failed|rejected');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `edi_transmitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'EDI Transmitted Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `fill_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Percentage');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Named Place or Port');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `is_cross_dock` SET TAGS ('dbx_business_glossary_term' = 'Cross-Docking Indicator');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `is_drop_ship` SET TAGS ('dbx_business_glossary_term' = 'Drop Ship Indicator');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `net_payable_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payable Amount');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `net_payable_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Notes');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Date');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_value_regex' = '^PO-[0-9]{8,12}$');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Status');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Type');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_value_regex' = 'standard|blanket|direct_store_delivery|drop_ship|consignment|return_to_vendor');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `purchasing_group_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group Code');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `purchasing_org_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization Code');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_MM|ORMS|MANUAL|EDI');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `supplier_po_reference` SET TAGS ('dbx_business_glossary_term' = 'Supplier Purchase Order Reference Number');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `total_order_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order Amount');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `total_order_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `total_ordered_units` SET TAGS ('dbx_business_glossary_term' = 'Total Ordered Units');
ALTER TABLE `retail_ecm`.`supplychain`.`purchase_order` ALTER COLUMN `total_received_units` SET TAGS ('dbx_business_glossary_term' = 'Total Received Units');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` SET TAGS ('dbx_subdomain' = 'procurement_sourcing');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line ID');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `assortment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Item Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `buyer_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer ID');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `cost_price_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Price Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Destination ID');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `gtin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Gtin Registry Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `replenishment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Plan Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'Uom Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowance Amount');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `cancel_date` SET TAGS ('dbx_business_glossary_term' = 'Cancel Date');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `confirmed_qty` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `destination_type` SET TAGS ('dbx_business_glossary_term' = 'Destination Type');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `destination_type` SET TAGS ('dbx_value_regex' = 'dc|store|cross_dock|drop_ship|mfc');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `extended_cost` SET TAGS ('dbx_business_glossary_term' = 'Extended Cost');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `extended_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Number');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Status');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|confirmed|partially_received|fully_received|cancelled|closed');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `moq` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `moq_compliant` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Compliant Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `net_cost` SET TAGS ('dbx_business_glossary_term' = 'Net Cost');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `net_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `order_uom_qty` SET TAGS ('dbx_business_glossary_term' = 'Order Unit of Measure Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `ordered_qty` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `otb_consumed` SET TAGS ('dbx_business_glossary_term' = 'Open to Buy (OTB) Consumed');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `otb_consumed` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `received_qty` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `retail_price` SET TAGS ('dbx_business_glossary_term' = 'Retail Price');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `retail_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `ship_date` SET TAGS ('dbx_business_glossary_term' = 'Ship Date');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `shipped_qty` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`po_line` ALTER COLUMN `vendor_item_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Number');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` SET TAGS ('dbx_subdomain' = 'demand_planning');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Identifier');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `assortment_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `demand_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `margin_target_id` SET TAGS ('dbx_business_glossary_term' = 'Margin Target Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `merch_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Merch Plan Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `allocation_priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Allocation Priority Rank');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Approval Status');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Plan Approval Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `beginning_on_hand_qty` SET TAGS ('dbx_business_glossary_term' = 'Beginning On-Hand Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `consensus_demand_qty` SET TAGS ('dbx_business_glossary_term' = 'Consensus Demand Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Plan Created Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `crossdock_qty` SET TAGS ('dbx_business_glossary_term' = 'Cross-Docking (Cross-Dock) Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `demand_forecast_qty` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `excess_inventory_flag` SET TAGS ('dbx_business_glossary_term' = 'Excess Inventory Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `in_transit_qty` SET TAGS ('dbx_business_glossary_term' = 'In-Transit Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `max_inventory_qty` SET TAGS ('dbx_business_glossary_term' = 'Maximum Inventory Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `min_order_qty` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `open_po_qty` SET TAGS ('dbx_business_glossary_term' = 'Open Purchase Order (PO) Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Number');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Status');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|superseded|locked');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Type');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'consensus|unconstrained|constrained|allocation|replenishment');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `planned_receipt_qty` SET TAGS ('dbx_business_glossary_term' = 'Planned Receipt Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `planner_notes` SET TAGS ('dbx_business_glossary_term' = 'Planner Notes');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `planning_horizon_weeks` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon (Weeks)');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `projected_on_hand_qty` SET TAGS ('dbx_business_glossary_term' = 'Projected On-Hand Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `promotional_uplift_qty` SET TAGS ('dbx_business_glossary_term' = 'Promotional Uplift Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `replenishment_order_qty` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `safety_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `sell_through_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Sell-Through Rate Percentage');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'BLUE_YONDER|SAP_S4|ORMS|MANUAL');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `stockout_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Stockout Risk Score');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `supplier_fill_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Supplier Fill Rate Percentage');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `supplier_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Supplier Lead Time (Days)');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `supply_constrained_flag` SET TAGS ('dbx_business_glossary_term' = 'Supply Constrained Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Plan Updated Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Number');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `week_end_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Week End Date');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `week_start_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Week Start Date');
ALTER TABLE `retail_ecm`.`supplychain`.`plan` ALTER COLUMN `weeks_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Weeks of Supply (WOS)');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` SET TAGS ('dbx_subdomain' = 'procurement_sourcing');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `inbound_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Appointment ID');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `inbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `actual_carton_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Carton Count');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `actual_pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Pallet Count');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `actual_unload_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Unload End Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `actual_unload_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Unload Start Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `advance_ship_notice_number` SET TAGS ('dbx_business_glossary_term' = 'Advance Ship Notice (ASN) Number');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `appointment_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Appointment Duration (Minutes)');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `appointment_notes` SET TAGS ('dbx_business_glossary_term' = 'Appointment Notes');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `appointment_number` SET TAGS ('dbx_business_glossary_term' = 'Appointment Number');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `appointment_number` SET TAGS ('dbx_value_regex' = '^APPT-[0-9]{8,12}$');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `appointment_status` SET TAGS ('dbx_business_glossary_term' = 'Appointment Status');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `appointment_status` SET TAGS ('dbx_value_regex' = 'scheduled|confirmed|arrived|completed|no_show|cancelled');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `appointment_type` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `appointment_type` SET TAGS ('dbx_value_regex' = 'live_unload|drop_trailer|cross_dock|floor_load');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Number');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `dock_door_zone` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Zone');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `driver_license_number` SET TAGS ('dbx_business_glossary_term' = 'Driver License Number');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `driver_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `driver_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `driver_name` SET TAGS ('dbx_business_glossary_term' = 'Driver Name');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `driver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `expected_carton_count` SET TAGS ('dbx_business_glossary_term' = 'Expected Carton Count');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `expected_pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Expected Pallet Count');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `expected_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Expected Shipment Weight (kg)');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `is_hazmat` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (Hazmat) Indicator');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `is_temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Indicator');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `late_arrival_reason` SET TAGS ('dbx_business_glossary_term' = 'Late Arrival Reason');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `on_time_arrival_flag` SET TAGS ('dbx_business_glossary_term' = 'On-Time Arrival Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `original_scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Original Scheduled Start Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `pro_number` SET TAGS ('dbx_business_glossary_term' = 'Progressive (PRO) Number');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `reschedule_count` SET TAGS ('dbx_business_glossary_term' = 'Reschedule Count');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `scheduled_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `scheduling_source` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Source');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `scheduling_source` SET TAGS ('dbx_value_regex' = 'carrier_portal|edi|manual|api');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `temperature_requirement` SET TAGS ('dbx_business_glossary_term' = 'Temperature Requirement');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `temperature_requirement` SET TAGS ('dbx_value_regex' = 'ambient|chilled|frozen|ultra_frozen');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_appointment` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Number');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) Facility ID');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `automation_level` SET TAGS ('dbx_business_glossary_term' = 'Automation Level');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `automation_level` SET TAGS ('dbx_value_regex' = 'manual|semi_automated|highly_automated|fully_automated');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `bonded_warehouse_flag` SET TAGS ('dbx_business_glossary_term' = 'Bonded Warehouse Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `dock_door_count` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Count');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Code');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `facility_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `facility_email_address` SET TAGS ('dbx_business_glossary_term' = 'Facility Email Address');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `facility_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `facility_email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `facility_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `facility_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Manager Name');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `facility_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Facility Phone Number');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `facility_phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `facility_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `facility_status` SET TAGS ('dbx_business_glossary_term' = 'Facility Status');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `facility_status` SET TAGS ('dbx_value_regex' = 'active|planned|under_construction|decommissioned|temporarily_closed|seasonal');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'regional_dc|micro_fulfillment_center|dark_store|cross_dock_hub|returns_center|forward_stocking_location');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `gln` SET TAGS ('dbx_business_glossary_term' = 'Global Location Number (GLN)');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `gln` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `inbound_dock_door_count` SET TAGS ('dbx_business_glossary_term' = 'Inbound Dock Door Count');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `lease_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiration Date');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `opened_date` SET TAGS ('dbx_business_glossary_term' = 'Opened Date');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `operating_hours_weekday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Weekday');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `operating_hours_weekend` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Weekend');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `outbound_dock_door_count` SET TAGS ('dbx_business_glossary_term' = 'Outbound Dock Door Count');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|third_party_operated');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `owning_region_code` SET TAGS ('dbx_business_glossary_term' = 'Owning Region Code');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `state_province_code` SET TAGS ('dbx_business_glossary_term' = 'State or Province Code');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `state_province_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `state_province_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `state_province_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `storage_capacity_cubic_feet` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity in Cubic Feet');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `storage_capacity_pallet_positions` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity in Pallet Positions');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `temperature_zone_ambient_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone Ambient Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `temperature_zone_chilled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone Chilled Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `temperature_zone_frozen_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone Frozen Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `total_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Total Square Footage');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `twenty_four_seven_operation_flag` SET TAGS ('dbx_business_glossary_term' = '24/7 Operation Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `warehouse_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Square Footage');
ALTER TABLE `retail_ecm`.`supplychain`.`dc_facility` ALTER COLUMN `wms_instance_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Instance ID');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `warehouse_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Zone ID');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `aisle_range_end` SET TAGS ('dbx_business_glossary_term' = 'Aisle Range End');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `aisle_range_end` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `aisle_range_start` SET TAGS ('dbx_business_glossary_term' = 'Aisle Range Start');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `aisle_range_start` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `automation_type` SET TAGS ('dbx_business_glossary_term' = 'Automation Type');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `barcode_scanning_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Barcode Scanning Required Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `current_occupancy_pct` SET TAGS ('dbx_business_glossary_term' = 'Current Occupancy Percentage');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `cycle_count_frequency` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Frequency');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `cycle_count_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|on_demand');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `last_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Date');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `location_count` SET TAGS ('dbx_business_glossary_term' = 'Location Count');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `next_scheduled_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Cycle Count Date');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `pick_method` SET TAGS ('dbx_business_glossary_term' = 'Pick Method');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `pick_method` SET TAGS ('dbx_value_regex' = 'discrete|batch|zone|wave|cluster');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `rack_configuration_type` SET TAGS ('dbx_business_glossary_term' = 'Rack Configuration Type');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `rack_configuration_type` SET TAGS ('dbx_value_regex' = 'selective|drive_in|push_back|flow|pallet_flow|cantilever');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `replenishment_priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Priority Rank');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `rfid_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Enabled Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'standard|restricted|high_value|controlled_substance');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `slotting_strategy` SET TAGS ('dbx_business_glossary_term' = 'Slotting Strategy');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `slotting_strategy` SET TAGS ('dbx_value_regex' = 'velocity_based|product_affinity|size_based|random|fixed');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `temperature_classification` SET TAGS ('dbx_business_glossary_term' = 'Temperature Classification');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `temperature_classification` SET TAGS ('dbx_value_regex' = 'ambient|chilled|frozen|temperature_controlled');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `temperature_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (Celsius)');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `temperature_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (Celsius)');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `total_capacity_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Total Capacity (Cubic Meters)');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `total_capacity_pallet_positions` SET TAGS ('dbx_business_glossary_term' = 'Total Capacity (Pallet Positions)');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `weight_capacity_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Capacity (Kilograms)');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Zone Code');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `zone_name` SET TAGS ('dbx_business_glossary_term' = 'Zone Name');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `zone_status` SET TAGS ('dbx_business_glossary_term' = 'Zone Status');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `zone_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|blocked|quarantine|seasonal');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_zone` ALTER COLUMN `zone_type` SET TAGS ('dbx_business_glossary_term' = 'Zone Type');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` SET TAGS ('dbx_subdomain' = 'procurement_sourcing');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `inbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment Identifier');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility ID');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Asn Line - Po Line Id');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `primary_inbound_dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `actual_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Date');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `actual_carton_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Carton Count');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `actual_pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Pallet Count');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `actual_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Actual Weight (Kilograms)');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advance Ship Notice (ASN) Number');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `cross_dock_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Dock Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Number');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `expected_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Arrival Date');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `expected_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expected Arrival Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `expected_carton_count` SET TAGS ('dbx_business_glossary_term' = 'Expected Carton Count');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `expected_cube_m3` SET TAGS ('dbx_business_glossary_term' = 'Expected Cube (Cubic Meters)');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `expected_pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Expected Pallet Count');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `expected_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Expected Weight (Kilograms)');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Amount');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `freight_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Currency Code');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `freight_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `late_arrival_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Late Arrival Reason Code');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Shipment Notes');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `on_time_arrival_flag` SET TAGS ('dbx_business_glossary_term' = 'On-Time Arrival Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `pro_number` SET TAGS ('dbx_business_glossary_term' = 'Progressive Number (PRO)');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `received_qty` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `receiving_complete_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receiving Complete Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `receiving_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receiving Start Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_value_regex' = 'in_transit|arrived|receiving|closed|cancelled|delayed');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `shipment_type` SET TAGS ('dbx_business_glossary_term' = 'Shipment Type');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `shipment_type` SET TAGS ('dbx_value_regex' = 'supplier_direct|inter_facility_transfer|vendor_managed_inventory|drop_ship_return|cross_dock');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `shipped_qty` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `temperature_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compliant Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `temperature_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (Celsius)');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `temperature_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (Celsius)');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `temperature_requirement` SET TAGS ('dbx_business_glossary_term' = 'Temperature Requirement');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `temperature_requirement` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|deep_frozen');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Number');
ALTER TABLE `retail_ecm`.`supplychain`.`inbound_shipment` ALTER COLUMN `unit_variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Unit Variance Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `receiving_event_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Event ID');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `gtin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Gtin Registry Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `inbound_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Appointment Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `inbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment ID');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `actual_carton_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Carton Count');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `actual_pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Pallet Count');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `actual_unit_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Unit Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `advance_ship_notice_number` SET TAGS ('dbx_business_glossary_term' = 'Advance Ship Notice (ASN) Number');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `carton_variance_count` SET TAGS ('dbx_business_glossary_term' = 'Carton Variance Count');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `damage_flag` SET TAGS ('dbx_business_glossary_term' = 'Damage Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `damaged_unit_quantity` SET TAGS ('dbx_business_glossary_term' = 'Damaged Unit Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `discrepancy_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Reason Code');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Number');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `expected_carton_count` SET TAGS ('dbx_business_glossary_term' = 'Expected Carton Count');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `expected_pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Expected Pallet Count');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `expected_unit_quantity` SET TAGS ('dbx_business_glossary_term' = 'Expected Unit Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `overage_flag` SET TAGS ('dbx_business_glossary_term' = 'Overage Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `pallet_variance_count` SET TAGS ('dbx_business_glossary_term' = 'Pallet Variance Count');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `putaway_task_generated_flag` SET TAGS ('dbx_business_glossary_term' = 'Putaway Task Generated Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `receiving_event_number` SET TAGS ('dbx_business_glossary_term' = 'Receiving Event Number');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `receiving_notes` SET TAGS ('dbx_business_glossary_term' = 'Receiving Notes');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `receiving_status` SET TAGS ('dbx_business_glossary_term' = 'Receiving Status');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `receiving_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|on_hold|exception');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `receiving_type` SET TAGS ('dbx_business_glossary_term' = 'Receiving Type');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `receiving_type` SET TAGS ('dbx_value_regex' = 'blind|directed|cross_dock|return|transfer');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `seal_intact_flag` SET TAGS ('dbx_business_glossary_term' = 'Seal Intact Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `shortage_flag` SET TAGS ('dbx_business_glossary_term' = 'Shortage Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `temperature_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compliant Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `temperature_reading` SET TAGS ('dbx_business_glossary_term' = 'Temperature Reading');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Number');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `unit_variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Unit Variance Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `unload_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Unload Duration Minutes');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `unload_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Unload End Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`receiving_event` ALTER COLUMN `unload_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Unload Start Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `warehouse_task_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Task ID');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `asn_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Ship Notice (ASN) ID');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `fulfillment_line_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Line Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `gtin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Gtin Registry Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `receiving_event_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Event Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `warehouse_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Source Warehouse Zone Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Target Department Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'Uom Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave ID');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `actual_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Notes');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `exception_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason Code');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `standard_labor_minutes` SET TAGS ('dbx_business_glossary_term' = 'Standard Labor Minutes');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `substituted_sku` SET TAGS ('dbx_business_glossary_term' = 'Substituted Stock Keeping Unit (SKU)');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `substitution_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `target_zone` SET TAGS ('dbx_business_glossary_term' = 'Target Zone');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `task_assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Assigned Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `task_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Completed Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `task_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Created Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `task_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Task Duration Minutes');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `task_number` SET TAGS ('dbx_business_glossary_term' = 'Task Number');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `task_priority` SET TAGS ('dbx_business_glossary_term' = 'Task Priority');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `task_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Started Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Task Status');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `task_type` SET TAGS ('dbx_business_glossary_term' = 'Task Type');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `travel_distance_feet` SET TAGS ('dbx_business_glossary_term' = 'Travel Distance Feet');
ALTER TABLE `retail_ecm`.`supplychain`.`warehouse_task` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` SET TAGS ('dbx_subdomain' = 'fulfillment_distribution');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `outbound_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order ID');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `assortment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Plan Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan ID');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Destination ID');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `primary_outbound_dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `replenishment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Plan ID');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `sfs_fulfillment_node_id` SET TAGS ('dbx_business_glossary_term' = 'Sfs Fulfillment Node Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave ID');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `destination_type` SET TAGS ('dbx_business_glossary_term' = 'Destination Type');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `destination_type` SET TAGS ('dbx_value_regex' = 'store|customer|distribution_center|3pl_node|supplier');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Number');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `fill_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Percentage');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `is_cross_dock` SET TAGS ('dbx_business_glossary_term' = 'Is Cross-Dock Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `is_drop_ship` SET TAGS ('dbx_business_glossary_term' = 'Is Drop Ship Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `is_hazmat` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous Material (HAZMAT) Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `is_temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Is Temperature Controlled Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Order Notes');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Number');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Status');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Type');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'store_replenishment|ecommerce_fulfillment|bopis|ropis|inter_dc_transfer|dsd_bypass');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Order Priority Level');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `pro_number` SET TAGS ('dbx_business_glossary_term' = 'Progressive (PRO) Number');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `replenishment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Reason Code');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `replenishment_type` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Type');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `requested_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Ship Date');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `temperature_requirement` SET TAGS ('dbx_business_glossary_term' = 'Temperature Requirement');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `temperature_requirement` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|climate_controlled');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `total_cartons` SET TAGS ('dbx_business_glossary_term' = 'Total Cartons');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `total_cube_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Cube (Cubic Meters)');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `total_lines` SET TAGS ('dbx_business_glossary_term' = 'Total Order Lines');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `total_pallets` SET TAGS ('dbx_business_glossary_term' = 'Total Pallets');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `total_units` SET TAGS ('dbx_business_glossary_term' = 'Total Units');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight (Kilograms)');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tracking Number');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_order` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Number');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` SET TAGS ('dbx_subdomain' = 'fulfillment_distribution');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave Identifier (ID)');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (ID)');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) Identifier (ID)');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `actual_pick_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Pick End Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `actual_pick_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Pick Start Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `assigned_pick_zones` SET TAGS ('dbx_business_glossary_term' = 'Assigned Pick Zones');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Channel');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'store_replenishment|ecommerce|bopis|ship_from_store|wholesale|marketplace');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `consolidation_location` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Location');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `equipment_type` SET TAGS ('dbx_value_regex' = 'cart|pallet_jack|forklift|pick_to_light|voice_pick|rf_scanner');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `fill_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Percentage (Pct)');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `generation_method` SET TAGS ('dbx_business_glossary_term' = 'Wave Generation Method');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `generation_method` SET TAGS ('dbx_value_regex' = 'scheduled|manual|demand_triggered|threshold_based');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `is_hazmat` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `is_promotional` SET TAGS ('dbx_business_glossary_term' = 'Is Promotional Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `is_temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Is Temperature Controlled Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `labor_hours_actual` SET TAGS ('dbx_business_glossary_term' = 'Labor Hours Actual');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `labor_hours_planned` SET TAGS ('dbx_business_glossary_term' = 'Labor Hours Planned');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Wave Notes');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `picked_units` SET TAGS ('dbx_business_glossary_term' = 'Picked Units');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `planned_pick_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Pick End Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `planned_pick_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Pick Start Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Wave Release Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `short_ship_disposition` SET TAGS ('dbx_business_glossary_term' = 'Short Ship Disposition');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `short_ship_disposition` SET TAGS ('dbx_value_regex' = 'cancel|backorder|substitute|split_shipment');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `short_units` SET TAGS ('dbx_business_glossary_term' = 'Short Units');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Wave Template Identifier (ID)');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `total_cartons` SET TAGS ('dbx_business_glossary_term' = 'Total Cartons');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `total_order_lines` SET TAGS ('dbx_business_glossary_term' = 'Total Order Lines');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `total_units` SET TAGS ('dbx_business_glossary_term' = 'Total Units');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `units_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Units Per Hour (UPH)');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `wave_number` SET TAGS ('dbx_business_glossary_term' = 'Wave Number');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `wave_status` SET TAGS ('dbx_business_glossary_term' = 'Wave Status');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `wave_status` SET TAGS ('dbx_value_regex' = 'planned|released|in_progress|short_closed|complete|cancelled');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `wave_type` SET TAGS ('dbx_business_glossary_term' = 'Wave Type');
ALTER TABLE `retail_ecm`.`supplychain`.`wave` ALTER COLUMN `wave_type` SET TAGS ('dbx_value_regex' = 'single_order|multi_order|cluster|zone|wave_less|demand_based');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` SET TAGS ('dbx_subdomain' = 'fulfillment_distribution');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `outbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Shipment Identifier');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `carrier_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Rate Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Destination ID');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `outbound_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `primary_outbound_dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility ID');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave ID');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `carrier_scac_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Carrier Alpha Code (SCAC)');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `carrier_scac_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `destination_type` SET TAGS ('dbx_business_glossary_term' = 'Destination Type');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `destination_type` SET TAGS ('dbx_value_regex' = 'store|customer|3pl_node|dc|vendor');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Number');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `estimated_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Date');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `freight_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Currency Code');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `freight_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `is_hazmat` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `is_temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `manifest_number` SET TAGS ('dbx_business_glossary_term' = 'Manifest ID');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Shipment Notes');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `on_time_delivery_flag` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Flag');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `pro_number` SET TAGS ('dbx_business_glossary_term' = 'Progressive Number (PRO)');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `ship_date` SET TAGS ('dbx_business_glossary_term' = 'Ship Date');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `ship_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ship Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `shipment_type` SET TAGS ('dbx_business_glossary_term' = 'Shipment Type');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `shipment_type` SET TAGS ('dbx_value_regex' = 'store_replenishment|customer_direct|cross_dock|transfer|return_to_vendor');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `temperature_requirement` SET TAGS ('dbx_business_glossary_term' = 'Temperature Requirement');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `temperature_requirement` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|climate_controlled');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `total_cartons` SET TAGS ('dbx_business_glossary_term' = 'Total Cartons');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `total_cube_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Cube (Cubic Meters)');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `total_pallets` SET TAGS ('dbx_business_glossary_term' = 'Total Pallets');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `total_units` SET TAGS ('dbx_business_glossary_term' = 'Total Units');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight (Kilograms)');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `retail_ecm`.`supplychain`.`outbound_shipment` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Number');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` SET TAGS ('dbx_subdomain' = 'fulfillment_distribution');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `inventory_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Transfer ID');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `cost_price_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Price Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility ID');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `gtin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Gtin Registry Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `merch_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Merch Plan Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `inventory_node_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Inventory Node Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `primary_inventory_dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility ID');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `replenishment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Plan ID');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'Uom Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `actual_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Receipt Date');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Ship Notice (ASN) Number');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `asn_number` SET TAGS ('dbx_value_regex' = '^ASN-[0-9]{8,12}$');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `carrier_scac_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Carrier Alpha Code (SCAC)');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `carrier_scac_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `destination_facility_type` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility Type');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `destination_facility_type` SET TAGS ('dbx_value_regex' = 'dc|mfc|store|3pl|vendor');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `expected_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Receipt Date');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `freight_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `is_cross_dock` SET TAGS ('dbx_business_glossary_term' = 'Is Cross-Dock Transfer');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `is_hazmat` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous Material (HAZMAT)');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,30}$');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transfer Notes');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `origin_facility_type` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility Type');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `origin_facility_type` SET TAGS ('dbx_value_regex' = 'dc|mfc|store|3pl|vendor');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `requested_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Ship Date');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,40}$');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `temperature_requirement` SET TAGS ('dbx_business_glossary_term' = 'Temperature Requirement');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `temperature_requirement` SET TAGS ('dbx_value_regex' = 'frozen|refrigerated|ambient|controlled');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `total_transfer_value` SET TAGS ('dbx_business_glossary_term' = 'Total Transfer Value');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `total_transfer_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `tracking_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,40}$');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `transfer_order_number` SET TAGS ('dbx_business_glossary_term' = 'Transfer Order Number');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `transfer_order_number` SET TAGS ('dbx_value_regex' = '^TO-[0-9]{8,12}$');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `transfer_quantity` SET TAGS ('dbx_business_glossary_term' = 'Transfer Quantity');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `transfer_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Transfer Reason Code');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Status');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_value_regex' = 'draft|approved|in_transit|received|cancelled|rejected');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Type');
ALTER TABLE `retail_ecm`.`supplychain`.`inventory_transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_value_regex' = 'rebalancing|store_replenishment|returns_consolidation|emergency_stock|seasonal_redistribution|new_store_stocking');
