-- Schema for Domain: supply | Business: Consumer Goods | Version: v1_mvm
-- Generated on: 2026-05-05 11:04:15

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `consumer_goods_ecm`.`supply` COMMENT 'Owns end-to-end supply chain planning and orchestration including demand planning, supply planning, inventory optimization, S&OP/IBP processes, DRP execution, safety stock targets, ATP/CTP calculations, supply network design, demand sensing, forecast accuracy tracking, and supply risk management. Integrates with SAP IBP.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `consumer_goods_ecm`.`supply`.`demand_plan` (
    `demand_plan_id` BIGINT COMMENT 'Unique identifier for the demand plan record. Primary key representing a specific version-point in the S&OP/IBP cycle for a SKU/location/channel/planning period combination.',
    `baseline_volume_id` BIGINT COMMENT 'Foreign key linking to promotion.baseline_volume. Business justification: demand_plan carries statistical_baseline_quantity that must be reconciled with the promotional baseline_volume used for lift measurement. Direct FK enables S&OP baseline alignment, forecast accuracy b',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: In Consumer Goods S&OP, demand plans incorporate campaign-driven volume uplifts (marketing_event_uplift_quantity, promotional_overlay_quantity). Linking demand_plan directly to the campaign driving th',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: demand_plan carries promotional_overlay_quantity and marketing_event_uplift_quantity tied to a specific promotion_event. Direct FK enables S&OP drill-down from demand plan version to the driving promo',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: Integrated Business Planning (IBP) reconciliation: demand plans are the volume input to financial budgets. Finance controllers and supply planners jointly reconcile consensus volume against the approv',
    `hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.hierarchy. Business justification: S&OP/IBP aggregate demand planning in consumer goods operates at brand, category, and sub-brand hierarchy levels for top-down/bottom-up reconciliation. Planners create demand plans at hierarchy nodes ',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Integrated Demand Planning uses brand forecasts; brand_id links demand plan to specific brand for Brand Demand Forecast report.',
    `media_plan_id` BIGINT COMMENT 'Foreign key linking to marketing.media_plan. Business justification: In Consumer Goods integrated business planning, demand planners reference the media plan schedule to quantify marketing-driven demand uplifts (demand_plan.marketing_event_uplift_quantity). A direct FK',
    `planning_period_id` BIGINT COMMENT 'Foreign key linking to supply.planning_period. Business justification: demand_plan has planning_period_start_date and planning_period_end_date as raw date fields. Normalizing to a planning_period_id FK eliminates this redundancy since planning_period.start_date and plann',
    `registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_registration. Business justification: Demand plans for regulated SKUs (OTC, biocides, cosmetics) must reference the market authorization governing that SKU. S&OP planners must validate registration status before committing demand volumes ',
    `sku_id` BIGINT COMMENT 'Reference to the product SKU for which demand is being planned.',
    `sku_planning_param_id` BIGINT COMMENT 'Foreign key linking to supply.sku_planning_param. Business justification: The demand plan is generated for a specific SKU/node combination, and sku_planning_param stores the planning parameters for that same SKU/node combination (forecast_model_type, demand_pattern_type, pl',
    `network_node_id` BIGINT COMMENT 'Reference to the distribution location, warehouse, or market geography for which demand is planned.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Demand plans in consumer goods are structured by sales territory to align supply forecasts with field sales coverage and quota. Territory-level demand planning feeds into sales quota setting and regio',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to customer.trade_account. Business justification: REQUIRED: Account‑level demand forecast used in S&OP planning; planners need trade_account context for each demand_plan.',
    `trade_calendar_id` BIGINT COMMENT 'Foreign key linking to promotion.trade_calendar. Business justification: Consumer goods demand plans are built against trade calendar planning cycles. Direct FK aligns demand_plan planning_bucket to the trade calendar, enabling integrated business planning (IBP) calendar-s',
    `trade_promotion_id` BIGINT COMMENT 'Foreign key linking to promotion.trade_promotion. Business justification: Demand planners in consumer goods apply promotional_overlay_quantity driven by a specific trade promotion. Direct FK enables S&OP trade promotion volume reconciliation and forecast accuracy reporting ',
    `approval_status` STRING COMMENT 'Current approval state of the demand plan version within the S&OP governance workflow.. Valid values are `draft|submitted|under_review|approved|rejected|locked`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this demand plan version was formally approved and locked for supply planning execution.',
    `commercial_overlay_quantity` DECIMAL(18,2) COMMENT 'Demand adjustment quantity applied by field sales teams based on customer intelligence, market conditions, and sales pipeline visibility.',
    `confidence_level` STRING COMMENT 'Planner-assigned confidence rating in the demand forecast based on data quality, market visibility, and forecast stability.. Valid values are `high|medium|low`',
    `consensus_quantity` DECIMAL(18,2) COMMENT 'Agreed demand forecast quantity representing the single demand signal passed to supply planning after S&OP consensus process. This is the authoritative demand plan.',
    `created_by_persona` STRING COMMENT 'Role or persona of the user who created this demand plan version, used for accountability and collaboration tracking.. Valid values are `demand_planner|sales_manager|marketing_analyst|supply_planner|system_generated`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this demand plan version record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code used for any monetary values associated with this demand plan (e.g., revenue forecasts).. Valid values are `^[A-Z]{3}$`',
    `demand_pattern_type` STRING COMMENT 'Classification of historical demand behavior pattern used to select appropriate statistical forecasting algorithm.. Valid values are `stable|seasonal|trending|intermittent|lumpy|erratic`',
    `demand_sensing_signal` STRING COMMENT 'Short-term demand trend indicator derived from real-time POS data, shipment data, and market signals to enable rapid forecast adjustments.. Valid values are `increasing|stable|decreasing|volatile`',
    `effective_from_date` DATE COMMENT 'Date from which this demand plan version becomes active and is used for supply planning and ATP calculations.',
    `effective_to_date` DATE COMMENT 'Date until which this demand plan version remains active. Null indicates the version is currently active with no planned expiration.',
    `forecast_accuracy_percentage` DECIMAL(18,2) COMMENT 'Historical forecast accuracy metric for this SKU/location/channel combination, used for forecast quality benchmarking and continuous improvement.',
    `forecast_bias_percentage` DECIMAL(18,2) COMMENT 'Systematic tendency to over-forecast or under-forecast, calculated as average percentage deviation from actual demand.',
    `is_consensus_version` BOOLEAN COMMENT 'Flag indicating whether this version represents the official consensus demand plan approved through the S&OP process and used for supply planning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this demand plan version was last updated or adjusted.',
    `lifecycle_stage` STRING COMMENT 'Product lifecycle stage classification used to apply appropriate forecasting models and demand shaping strategies.. Valid values are `introduction|growth|maturity|decline|phase_out`',
    `marketing_event_uplift_quantity` DECIMAL(18,2) COMMENT 'Incremental demand quantity expected from planned marketing campaigns, promotions, and brand activation events.',
    `npd_launch_volume_quantity` DECIMAL(18,2) COMMENT 'Forecasted demand quantity for new product launches or product line extensions during the planning period.',
    `planner_notes` STRING COMMENT 'Free-text comments and annotations from demand planners explaining assumptions, adjustments, risks, or special considerations for this forecast.',
    `planning_bucket` STRING COMMENT 'Time granularity of the demand plan (daily, weekly, monthly, quarterly) used for aggregation and reporting.. Valid values are `daily|weekly|monthly|quarterly`',
    `promotional_overlay_quantity` DECIMAL(18,2) COMMENT 'Demand uplift quantity attributed to trade promotions, price discounts, and retail execution activities.',
    `risk_category` STRING COMMENT 'Classification of the primary risk factor affecting demand plan reliability and supply fulfillment capability.. Valid values are `supply_constraint|demand_volatility|new_product_uncertainty|promotional_risk|market_disruption|none`',
    `risk_flag` BOOLEAN COMMENT 'Indicator that this demand plan carries elevated supply risk due to capacity constraints, material shortages, or demand volatility.',
    `source_system` STRING COMMENT 'Identifier of the source system from which this demand plan was extracted (e.g., SAP IBP, TradeEdge, Nielsen IQ integration).',
    `source_system_record_code` STRING COMMENT 'Original unique identifier of this demand plan record in the source system, used for data lineage and reconciliation.',
    `statistical_baseline_quantity` DECIMAL(18,2) COMMENT 'Unconstrained demand forecast quantity generated by statistical forecasting algorithms before any commercial overlays or adjustments.',
    `unit_of_measure` STRING COMMENT 'Unit in which demand quantities are expressed (each, case, pallet, kilogram, liter, etc.). [ENUM-REF-CANDIDATE: EA|CS|PL|KG|LB|L|GAL — 7 candidates stripped; promote to reference product]',
    `variance_to_baseline_quantity` DECIMAL(18,2) COMMENT 'Difference between consensus quantity and statistical baseline quantity, indicating the net impact of all commercial adjustments and overlays.',
    `version_name` STRING COMMENT 'Human-readable name of the demand plan version (e.g., Statistical Baseline Q1 2024, Consensus Final March 2024).',
    `version_sequence_number` STRING COMMENT 'Sequential version number within the planning cycle, used to track iteration history and version progression.',
    `version_type` STRING COMMENT 'Classification of the demand plan version indicating its stage in the S&OP process. Statistical baseline represents unconstrained forecast; consensus represents agreed demand signal passed to supply planning.. Valid values are `statistical_baseline|field_sales_overlay|marketing_adjusted|consensus|final_approved|promotional_overlay`',
    CONSTRAINT pk_demand_plan PRIMARY KEY(`demand_plan_id`)
) COMMENT 'Core master entity representing the demand plan across all versions, stages, and consensus outcomes within the S&OP/IBP cycle for each SKU/location/channel/planning period combination. Each record represents a specific version-point: captures version name, version type (statistical baseline/field sales overlay/marketing-adjusted/consensus/final approved), planning cycle reference, created-by persona, approval status, effective date range, planning bucket (weekly/monthly), statistical baseline quantity, commercial overlay, marketing event uplift, new product launch volume, consensus quantity, variance to statistical baseline, channel disaggregation, promotional overlays, and lifecycle stage. The consensus version represents the single agreed demand signal passed to supply planning. Enables forecast accuracy benchmarking across versions. Sourced from SAP IBP Demand Planning module.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`supply`.`plan` (
    `plan_id` BIGINT COMMENT 'Unique identifier for the supply plan record. Primary key for the supply plan entity.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Production scheduling must align with marketing campaign launches; campaign_id enables Campaign‑Supply Execution dashboard.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: CARRIER_ASSIGNMENT: Supply plan assigns a primary carrier for the planned shipments, required for cost and SLA calculations.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Supply plans are constrained by compliance obligations such as import quotas, mandatory testing holds, or market entry requirements. IBP/S&OP planners must link plans to the specific compliance obliga',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost allocation of each supply plan to a finance cost center for budgeting and variance analysis; planners routinely charge production plans to cost centers.',
    `demand_plan_id` BIGINT COMMENT 'Foreign key linking to supply.demand_plan. Business justification: A supply plan is derived from a specific demand plan; linking plan to demand_plan captures the parent‑child relationship and enables traceability of plan origins.',
    `distribution_facility_id` BIGINT COMMENT 'Reference to the distribution center or warehouse location for which this supply plan applies.',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: REQUIRED: S&OP supply planning must align production/replenishment with upcoming promotion events to meet forecasted uplift.',
    `hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.hierarchy. Business justification: Rough-cut capacity planning and aggregate supply planning in IBP operate at product hierarchy levels (brand, category). Supply planners create aggregate plans at hierarchy nodes for capacity allocatio',
    `inspection_plan_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_plan. Business justification: S&OP/IBP process: supply plans for manufactured or procured SKUs must reference the applicable inspection plan to embed quality gates in production and procurement planning. Consumer goods planners us',
    `lane_id` BIGINT COMMENT 'Foreign key linking to logistics.lane. Business justification: TRANSPORT_PLANNING: Supply plan defines the transportation lane for moving goods; planners need lane_id to generate accurate movement schedules.',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: MRP generates component-level supply plans (purchase plans, material plans) for raw materials and packaging alongside finished-good plans. Consumer goods supply planners need material supply plans lin',
    `network_lane_id` BIGINT COMMENT 'Foreign key linking to supply.network_lane. Business justification: The supply plan determines which network lane to use for replenishment of each SKU at each node. Linking plan to network_lane enables supply network routing analysis and lane utilization reporting. On',
    `planning_period_id` BIGINT COMMENT 'Foreign key linking to supply.planning_period. Business justification: The supply plan is organized by planning periods. plan.planning_bucket is a string field that conceptually maps to a planning_period. Adding planning_period_id normalizes this relationship and enables',
    `product_bom_id` BIGINT COMMENT 'Foreign key linking to product.product_bom. Business justification: MRP/IBP production planning requires explicit BOM reference to explode component requirements from planned production quantities. Consumer goods planners must know which BOM version drives a productio',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Supply plan financial accountability: every supply plan commits costs and inventory investment tracked against a profit center for brand/channel P&L reporting. IBP financial reconciliation requires su',
    `registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.registration. Business justification: Supply planning must avoid producing or allocating unregistered SKUs; registration link validates plan feasibility.',
    `safety_stock_id` BIGINT COMMENT 'Foreign key linking to supply.safety_stock. Business justification: plan.safety_stock_quantity is a denormalized field. Formalizing this as a FK to safety_stock links the plan to the approved safety stock record that informed its safety stock target. This enables trac',
    `sku_id` BIGINT COMMENT 'Reference to the specific SKU for which this supply plan is created.',
    `sku_planning_param_id` BIGINT COMMENT 'Foreign key linking to supply.sku_planning_param. Business justification: The supply plan is generated using SKU-level planning parameters (lead times, lot sizes, MRP type, planning strategy) stored in sku_planning_param. Linking plan to sku_planning_param enables traceabil',
    `standard_cost_id` BIGINT COMMENT 'Foreign key linking to finance.standard_cost. Business justification: Supply plan financial valuation: planned production and replenishment quantities must be valued at standard cost to produce the financial supply plan (cost of goods planned). Finance and supply planni',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_contract. Business justification: Supply planners validate planned procurement quantities against contracted min/max volumes and pricing terms. Linking plan to supplier_contract enables contract compliance checking during S&OP and ens',
    `supplier_id` BIGINT COMMENT 'Reference to the external supplier if the supply source is external procurement or contract manufacturing.',
    `network_node_id` BIGINT COMMENT 'Reference to the source location (plant or DC) if the supply source is a transfer from another internal location.',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to customer.trade_account. Business justification: REQUIRED: Store‑specific supply plan ties replenishment to the owning trade_account; essential for execution and KPI reporting.',
    `trade_promotion_id` BIGINT COMMENT 'Foreign key linking to promotion.trade_promotion. Business justification: Supply plans in consumer goods are built at the trade promotion level for budget allocation and volume planning. Direct FK enables trade promotion supply plan vs. actual volume variance reporting and ',
    `atp_quantity` DECIMAL(18,2) COMMENT 'The quantity of the SKU that is available to promise to customers for delivery during the planning period, based on projected supply and committed demand.',
    `capacity_constraint_flag` BOOLEAN COMMENT 'Indicates whether the supply plan is constrained by production or distribution capacity limitations.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this supply plan record was first created in the system.',
    `ctp_quantity` DECIMAL(18,2) COMMENT 'The quantity of the SKU that can be promised to customers considering both current inventory and planned production capacity.',
    `demand_forecast_quantity` DECIMAL(18,2) COMMENT 'The forecasted demand quantity for this SKU at this location during the planning period, used as input to the supply planning process.',
    `execution_date` DATE COMMENT 'The date when this supply plan was executed or committed, triggering downstream production orders or purchase requisitions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this supply plan record was last updated or modified.',
    `lead_time_days` STRING COMMENT 'The number of days required from order release to receipt, including production time, procurement time, or transfer time.',
    `material_constraint_flag` BOOLEAN COMMENT 'Indicates whether the supply plan is constrained by raw material or component availability.',
    `notes` STRING COMMENT 'Free-text notes or comments from the supply planner regarding assumptions, constraints, or special considerations for this supply plan.',
    `plan_status` STRING COMMENT 'The current lifecycle status of the supply plan record indicating its approval and execution state.. Valid values are `draft|approved|committed|executed|archived`',
    `plan_type` STRING COMMENT 'Classification of the supply plan indicating whether it is constrained by capacity and material availability, unconstrained (infinite capacity), a scenario analysis, or a simulation.. Valid values are `constrained|unconstrained|scenario|simulation`',
    `planned_order_release_date` DATE COMMENT 'The date when the production order or purchase order should be released to meet the planned receipt date, accounting for lead times.',
    `planned_production_quantity` DECIMAL(18,2) COMMENT 'The quantity of the SKU planned to be produced at the specified plant during the planning period.',
    `planned_receipt_date` DATE COMMENT 'The date when the planned supply quantity is expected to be received or available at the destination location.',
    `planned_replenishment_quantity` DECIMAL(18,2) COMMENT 'The quantity of the SKU planned to be replenished or transferred to the distribution center during the planning period.',
    `planning_bucket` STRING COMMENT 'The time granularity or bucket size used for this supply plan (daily, weekly, monthly, or quarterly aggregation).. Valid values are `daily|weekly|monthly|quarterly`',
    `planning_group` STRING COMMENT 'The organizational planning group or team responsible for managing supply planning for this SKU or location combination.',
    `planning_horizon_end_date` DATE COMMENT 'The end date of the planning horizon covered by this supply plan record.',
    `planning_horizon_start_date` DATE COMMENT 'The start date of the planning horizon covered by this supply plan record.',
    `projected_inventory_balance` DECIMAL(18,2) COMMENT 'The projected on-hand inventory balance at the end of the planning period after accounting for planned supply and demand.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'The target safety stock quantity maintained as a buffer against demand variability and supply uncertainty for this SKU at this location.',
    `source_system` STRING COMMENT 'The name or identifier of the source system from which this supply plan record originated (e.g., SAP IBP, Oracle Cloud Supply Chain).',
    `supply_risk_score` DECIMAL(18,2) COMMENT 'A calculated risk score indicating the likelihood of supply disruption or shortage for this SKU at this location, based on supplier reliability, lead time variability, and demand volatility.',
    `supply_source` STRING COMMENT 'The source from which the supply will be obtained: internal production, external procurement from suppliers, transfer from another location, or contract manufacturing.. Valid values are `internal_production|external_procurement|transfer|contract_manufacturing`',
    `transportation_constraint_flag` BOOLEAN COMMENT 'Indicates whether the supply plan is constrained by transportation or logistics capacity limitations.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the planned quantities (e.g., cases, pallets, kilograms, liters).',
    `version` STRING COMMENT 'Version identifier for the supply plan, enabling tracking of plan iterations and scenario comparisons (e.g., baseline, consensus, committed).',
    CONSTRAINT pk_plan PRIMARY KEY(`plan_id`)
) COMMENT 'Core master entity representing the constrained and unconstrained supply plan for each SKU/plant/DC combination. Captures planned production quantities, planned replenishment orders, supply source, planning horizon, constraint flags, and IBP supply planning run metadata. Sourced from SAP IBP Supply Planning module.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`supply`.`safety_stock` (
    `safety_stock_id` BIGINT COMMENT 'Unique identifier for the safety stock calculation record. Primary key for the safety stock entity.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Safety‑stock calculations must respect compliance constraints such as shelf‑life limits; link provides required obligation data.',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Safety stock buffers are set per promotion event in consumer goods OOS-risk management. Direct FK enables event-level safety stock adequacy reporting, post-event analysis of stockout incidents, and pr',
    `inspection_plan_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_plan. Business justification: Safety stock calculation for GMP/regulated consumer goods SKUs must incorporate inspection_lead_time_days from the inspection_plan. Without this link, safety stock models underestimate required buffer',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Raw material and packaging component safety stock management is a standard supply planning practice in consumer goods manufacturing. MRP planners set safety stock targets for critical materials (e.g.,',
    `planning_period_id` BIGINT COMMENT 'Foreign key linking to supply.planning_period. Business justification: safety_stock has planning_period_start_date and planning_period_end_date as raw date fields. Normalizing to a planning_period_id FK eliminates this redundancy since planning_period.start_date and plan',
    `registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_registration. Business justification: Safety stock targets for regulated products must account for registration expiry — approaching expiry triggers drawdown strategies to avoid holding unsaleable inventory. Supply planners need direct re',
    `sku_id` BIGINT COMMENT 'Reference to the specific product SKU for which safety stock is calculated. Links to the product master data.',
    `sku_planning_param_id` BIGINT COMMENT 'Foreign key linking to supply.sku_planning_param. Business justification: Safety stock is calculated by applying the parameters defined in sku_planning_param (safety_stock_method, service_level_target_percent, lot_size_method, etc.). The safety_stock record is the OUTPUT of',
    `standard_cost_id` BIGINT COMMENT 'Foreign key linking to finance.standard_cost. Business justification: Inventory carrying cost and balance sheet valuation: safety stock levels are valued at standard cost for working capital reporting and inventory optimization. The safety_stock table has holding_cost_p',
    `network_node_id` BIGINT COMMENT 'Reference to the storage location, distribution center, or facility where the safety stock applies. Links to distribution facility master data.',
    `trade_promotion_id` BIGINT COMMENT 'Foreign key linking to promotion.trade_promotion. Business justification: In consumer goods, safety stock levels are explicitly elevated for promotional periods to prevent OOS. Direct FK to trade_promotion enables promotional safety stock override tracking, review_status re',
    `abc_classification` STRING COMMENT 'The ABC classification of the SKU based on revenue contribution or volume. A items are high-value requiring tight control; B items are moderate; C items are low-value. Influences service level targets and safety stock investment decisions.. Valid values are `A|B|C`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the safety stock calculation was approved by the planner. Marks the transition from calculated to approved state in the workflow.',
    `approved_safety_stock_units` DECIMAL(18,2) COMMENT 'The final approved safety stock quantity in base units of measure after planner review and adjustment. This is the target value used for inventory policy execution and Available to Promise (ATP) calculations.',
    `average_daily_demand_units` DECIMAL(18,2) COMMENT 'The mean daily demand quantity in base units of measure. Used as input to safety stock calculations and represents expected consumption rate.',
    `average_lead_time_days` DECIMAL(18,2) COMMENT 'The mean replenishment lead time in days from order placement to receipt. Used in safety stock calculations to determine the exposure period for demand and supply variability.',
    `calculated_safety_stock_units` DECIMAL(18,2) COMMENT 'The system-calculated safety stock quantity in base units of measure. This is the raw output from the calculation engine before any manual adjustments or approvals.',
    `calculation_method` STRING COMMENT 'The methodology used to calculate the safety stock quantity. Statistical methods use demand and lead time variability; days-of-supply uses fixed coverage targets; manual override represents planner judgment; service level and lead time methods focus on specific risk factors; hybrid combines multiple approaches.. Valid values are `statistical|days_of_supply|manual_override|service_level_based|lead_time_based|hybrid`',
    `calculation_timestamp` TIMESTAMP COMMENT 'The date and time when the safety stock calculation was executed by the planning system. Provides audit trail for calculation runs and version control.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this safety stock record was first created in the system. Provides audit trail for record lifecycle tracking.',
    `days_of_supply_target` DECIMAL(18,2) COMMENT 'The target safety stock coverage expressed in days of average demand. Used when calculation method is days-of-supply based. Represents the buffer duration to protect against stockouts.',
    `demand_classification` STRING COMMENT 'The demand pattern category for this SKU-location. Steady indicates consistent demand; seasonal shows periodic peaks; erratic has high variability; lumpy has infrequent large orders; intermittent has sporadic demand; obsolete indicates phase-out. Influences calculation method selection.. Valid values are `steady|seasonal|erratic|lumpy|intermittent|obsolete`',
    `demand_variability_coefficient` DECIMAL(18,2) COMMENT 'Statistical measure of demand volatility expressed as coefficient of variation or standard deviation. Used in statistical safety stock calculations to quantify demand uncertainty.',
    `effective_date` DATE COMMENT 'The date when this safety stock target becomes active and is used for inventory policy execution, Distribution Requirements Planning (DRP), and Available to Promise (ATP) calculations.',
    `expiration_date` DATE COMMENT 'The date when this safety stock target expires and is replaced by a new calculation. Used to manage the lifecycle of safety stock policies and trigger recalculation cycles.',
    `forecast_accuracy_percent` DECIMAL(18,2) COMMENT 'The historical forecast accuracy for this SKU-location combination expressed as a percentage. Used to adjust safety stock calculations based on forecasting reliability. Lower accuracy typically requires higher safety stock.',
    `holding_cost_per_unit` DECIMAL(18,2) COMMENT 'The annual cost to hold one unit of inventory including warehousing, insurance, obsolescence, and capital cost. Used in inventory optimization to balance service level against carrying cost. Expressed in local currency.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this safety stock record is currently active and being used for inventory policy execution. True means active; False means superseded or inactive.',
    `last_review_timestamp` TIMESTAMP COMMENT 'The date and time when the safety stock record was last reviewed by a planner, regardless of whether changes were made. Used to track planner engagement and ensure regular review cycles.',
    `lead_time_variability_days` DECIMAL(18,2) COMMENT 'Measure of supply lead time uncertainty expressed in days. Represents the standard deviation or range of lead time fluctuation used in safety stock calculations.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The minimum order quantity constraint from the supplier or manufacturing process. Safety stock calculations must consider MOQ to ensure replenishment orders are feasible.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this safety stock record was last modified. Updated whenever any field changes. Supports change tracking and audit requirements.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next safety stock review cycle. Used in Sales and Operations Planning (S&OP) and Integrated Business Planning (IBP) processes to ensure regular policy updates.',
    `order_multiple` DECIMAL(18,2) COMMENT 'The order quantity increment or lot size multiple required by supplier or production constraints. Safety stock and reorder quantities must align with this multiple.',
    `override_notes` STRING COMMENT 'Free-text explanation provided by the planner when manually overriding the calculated safety stock. Documents the business context and rationale for the adjustment.',
    `override_reason_code` STRING COMMENT 'The business reason code when approved safety stock differs from calculated safety stock. Captures planner judgment factors such as promotional events, seasonal peaks, supply chain risks, new product introductions, product phase-outs, or quality concerns.. Valid values are `promotional_event|seasonal_peak|supply_risk|new_product_launch|phase_out|quality_issue`',
    `review_status` STRING COMMENT 'The approval workflow status of the safety stock calculation. Pending review indicates awaiting planner action; approved means active for execution; rejected requires recalculation; under revision is being adjusted; expired indicates the planning period has passed.. Valid values are `pending_review|approved|rejected|under_revision|expired`',
    `shelf_life_days` STRING COMMENT 'The shelf life or expiration period of the product in days. Critical for Fast-Moving Consumer Goods (FMCG) and Consumer Packaged Goods (CPG) safety stock decisions to prevent obsolescence. Influences maximum safety stock levels and First Expired First Out (FEFO) policies.',
    `source_system` STRING COMMENT 'The system of record that generated or last updated this safety stock calculation. SAP IBP for integrated business planning, SAP S/4HANA for ERP-based calculations, Oracle Cloud SCM for Oracle supply chain, Blue Yonder for advanced optimization, TradeEdge for demand sensing, or Manual for planner-entered values.. Valid values are `SAP_IBP|SAP_S4HANA|Oracle_Cloud_SCM|Blue_Yonder|TradeEdge|Manual`',
    `stockout_cost_per_unit` DECIMAL(18,2) COMMENT 'The estimated cost of a stockout per unit including lost sales, expediting costs, customer dissatisfaction, and brand impact. Used in service level optimization to quantify the cost of Out of Stock (OOS) events. Expressed in local currency.',
    `supply_risk_score` DECIMAL(18,2) COMMENT 'A quantitative risk score assessing supply chain vulnerability for this SKU-location. Higher scores indicate greater risk from supplier reliability, geopolitical factors, transportation disruptions, or single-source dependencies. Used to adjust safety stock buffers.',
    `target_service_level_percent` DECIMAL(18,2) COMMENT 'The desired in-stock probability or fill rate target expressed as a percentage (e.g., 95.00, 98.50). Drives the safety stock buffer size to achieve the specified On Shelf Availability (OSA) or Service Level Agreement (SLA).',
    `unit_of_measure` STRING COMMENT 'The unit of measure for safety stock quantities. EA=Each, CS=Case, PL=Pallet, KG=Kilogram, LB=Pound, L=Liter, GAL=Gallon. Must align with SKU base unit of measure. [ENUM-REF-CANDIDATE: EA|CS|PL|KG|LB|L|GAL — 7 candidates stripped; promote to reference product]',
    `xyz_classification` STRING COMMENT 'The XYZ classification based on demand variability. X items have low variability (predictable); Y items have moderate variability; Z items have high variability (unpredictable). Used alongside ABC to determine safety stock strategy.. Valid values are `X|Y|Z`',
    `z_score` DECIMAL(18,2) COMMENT 'The standard normal distribution value corresponding to the target service level. Used in statistical safety stock formulas to translate service level percentage into buffer quantity.',
    CONSTRAINT pk_safety_stock PRIMARY KEY(`safety_stock_id`)
) COMMENT 'Transactional record capturing the calculated and approved safety stock quantity for each SKU/location/time-period combination. Stores calculation method (statistical, days-of-supply, manual override), demand variability, lead time variability, service level input, calculated SS units, approved SS units, effective date, and review status. Distinct from inventory_policy (policy target) as this captures the actual calculated output.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` (
    `supply_replenishment_order_id` BIGINT COMMENT 'Unique identifier for the supply replenishment order record. Primary key for this entity.',
    `batch_release_id` BIGINT COMMENT 'Foreign key linking to quality.batch_release. Business justification: Replenishment orders for finished goods in consumer goods distribution are held pending QA batch release. Linking supply_replenishment_order to batch_release enables automated order fulfillment trigge',
    `carrier_contract_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_contract. Business justification: CONTRACT_COMPLIANCE: Each replenishment order is governed by a carrier contract; needed for rate and penalty enforcement.',
    `carrier_id` BIGINT COMMENT 'Identifier of the logistics carrier or transportation provider assigned to execute this replenishment shipment.',
    `certificate_of_analysis_id` BIGINT COMMENT 'Foreign key linking to quality.certificate_of_analysis. Business justification: Inbound replenishment orders for raw materials and finished goods in consumer goods require a Certificate of Analysis to accompany the shipment for goods receipt and regulatory compliance. Linking CoA',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Replenishment orders incur expenses that must be tracked against the responsible cost center for expense reporting and internal charge‑backs.',
    `network_node_id` BIGINT COMMENT 'Identifier of the supply network node to which inventory will be delivered (distribution center, warehouse, or retail location).',
    `distribution_shipment_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_shipment. Business justification: Replenishment orders are executed as distribution shipments. This link enables end-to-end traceability from replenishment planning to physical shipment execution — critical for OTIF tracking, supply c',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: REQUIRED: Replenishment orders are often generated to satisfy demand generated by a specific promotion event.',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to logistics.freight_order. Business justification: A replenishment order triggers a freight order for physical movement. Linking enables freight cost allocation to replenishment orders and audit of freight bookings per replenishment — standard in cons',
    `lane_id` BIGINT COMMENT 'Foreign key linking to logistics.lane. Business justification: ORDER_EXECUTION: Replenishment order execution follows a specific lane; lane_id links order to transportation routing.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Lot traceability compliance: consumer goods companies must trace lot/batch numbers from supply receipt through stock position for regulatory traceability and recall readiness. When a supply replenishm',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: MRP generates purchase requisitions and replenishment orders for raw materials and packaging components, not just finished-good SKUs. Consumer goods supply planners track material-level replenishment ',
    `network_lane_id` BIGINT COMMENT 'Foreign key linking to supply.network_lane. Business justification: A replenishment order executes along a specific supply network lane (source node to destination node). The network_lane is the in-domain supply entity defining the sourcing lane, distinct from the cro',
    `plan_id` BIGINT COMMENT 'Foreign key linking to supply.plan. Business justification: A replenishment order is generated by DRP execution driven by the supply plan. Linking supply_replenishment_order to the plan that originated it enables full traceability from planning to execution. O',
    `primary_supply_network_node_id` BIGINT COMMENT 'Identifier of the supply network node from which inventory will be shipped (plant, distribution center, or warehouse).',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: In make-to-stock consumer goods operations, DRP replenishment orders are fulfilled by manufacturing production orders. Linking supply_replenishment_order to the fulfilling production_order enables end',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Replenishment cost allocation to P&L: replenishment orders generate freight, handling, and inventory costs that must be allocated to profit centers for brand/channel P&L reporting. Consumer goods fina',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: DRP-to-PO traceability: a supply replenishment order is executed by raising a purchase order. Linking them enables end-to-end order-to-receipt matching, OTIF tracking, and cost reconciliation — a stan',
    `purchase_requisition_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_requisition. Business justification: In standard DRP-to-procure flow, a supply replenishment order is converted into a purchase requisition before PO creation. This link enables end-to-end DRP-to-PR traceability, requisition status monit',
    `registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.registration. Business justification: Regulatory compliance verification before order release ensures SKU has active registration; essential for legal shipment.',
    `safety_stock_id` BIGINT COMMENT 'Foreign key linking to supply.safety_stock. Business justification: supply_replenishment_order has a safety_stock_trigger_flag boolean indicating the order was triggered by a safety stock breach. Adding safety_stock_id formalizes this relationship, allowing traceabili',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Order-to-replenishment pegging is critical for OTIF tracking and supply chain visibility in consumer goods. A customer sales order triggers a supply replenishment order; this FK enables end-to-end ord',
    `sku_id` BIGINT COMMENT 'Identifier of the product SKU being replenished through this order.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Goods receipt reconciliation: when a supply replenishment order is received, it updates a specific stock position. Supply planners and inventory controllers use this link for OTIF reporting and invent',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_contract. Business justification: Replenishment orders must reference the governing supplier contract to enforce pricing, delivery terms, and quantity constraints at order execution. Contract compliance on replenishment orders is a st',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: The replenishment order execution artifact must identify the sourcing supplier for supplier performance tracking, OTIF measurement, and risk management. plan.supplier_id exists at planning level but t',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to sales.trade_account. Business justification: VMI and customer-triggered replenishment orders must be traceable to the trade account they serve. OTIF performance reporting, retailer-specific replenishment SLA tracking, and VMI reconciliation all ',
    `actual_receipt_date` DATE COMMENT 'Actual date the goods were received at the destination location.',
    `actual_ship_date` DATE COMMENT 'Actual date the shipment departed from the source location.',
    `available_to_promise_quantity` DECIMAL(18,2) COMMENT 'ATP quantity at the source location at the time the replenishment order was created, used to validate supply availability.',
    `cancellation_reason` STRING COMMENT 'Reason code or description explaining why the replenishment order was cancelled, if applicable.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Quantity of the SKU confirmed for shipment by the source location, may differ from requested quantity due to supply constraints.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this replenishment order record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this order.. Valid values are `^[A-Z]{3}$`',
    `drp_run_timestamp` TIMESTAMP COMMENT 'Date and time when the DRP execution run that generated this order was executed.',
    `forecast_demand_quantity` DECIMAL(18,2) COMMENT 'Forecasted demand quantity at the destination location that drove the replenishment calculation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this replenishment order record was last modified in the system.',
    `order_cost_amount` DECIMAL(18,2) COMMENT 'Total cost associated with this replenishment order, including product cost, transportation cost, and handling fees.',
    `order_notes` STRING COMMENT 'Free-text notes or special instructions related to this replenishment order, such as handling requirements or routing constraints.',
    `order_status` STRING COMMENT 'Current execution status of the replenishment order in the supply chain workflow.. Valid values are `draft|open|in_transit|received|cancelled|closed`',
    `order_type` STRING COMMENT 'Classification of the replenishment order lifecycle stage: planned (system-generated recommendation), firmed (manually confirmed but not released), or released (committed for execution).. Valid values are `planned|firmed|released`',
    `planned_receipt_date` DATE COMMENT 'Target date for goods receipt at the destination location, accounting for transit lead time.',
    `planned_ship_date` DATE COMMENT 'Target date for shipment departure from the source location as calculated by the DRP engine.',
    `priority_code` STRING COMMENT 'Priority classification for order fulfillment, typically driven by stock-out risk, customer service level, or strategic importance.. Valid values are `critical|high|normal|low`',
    `received_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of the SKU received at the destination location, captured at goods receipt.',
    `replenishment_order_number` STRING COMMENT 'Business-facing unique order number for the replenishment order, used for tracking and reference across systems and communications.. Valid values are `^REP-[0-9]{10}$`',
    `requested_quantity` DECIMAL(18,2) COMMENT 'Quantity of the SKU requested for replenishment as calculated by the DRP engine or demand planner.',
    `safety_stock_trigger_flag` BOOLEAN COMMENT 'Indicates whether this replenishment order was triggered by inventory falling below safety stock threshold at the destination location.',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of the SKU shipped from the source location, captured at dispatch.',
    `transit_lead_time_days` STRING COMMENT 'Planned number of days for goods to travel from source to destination location.',
    `transportation_mode` STRING COMMENT 'Primary mode of transportation planned or used for this replenishment shipment.. Valid values are `truck|rail|air|ocean|intermodal`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for all quantity fields in this order (EA=Each, CS=Case, PL=Pallet, KG=Kilogram, LB=Pound, L=Liter, GAL=Gallon). [ENUM-REF-CANDIDATE: EA|CS|PL|EA|KG|LB|L|GAL — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_supply_replenishment_order PRIMARY KEY(`supply_replenishment_order_id`)
) COMMENT 'Transactional record representing a planned or released replenishment order generated by DRP execution for moving inventory between supply network nodes (plant-to-DC, DC-to-DC). Captures order type (planned/firmed/released), source location, destination location, SKU, requested quantity, confirmed quantity, planned ship date, planned receipt date, and DRP run reference. Distinct from purchase orders (owned by procurement) and production orders (owned by manufacturing).';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`supply`.`network_node` (
    `network_node_id` BIGINT COMMENT 'Primary key for network_node',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Legal entity assignment for intercompany flows: every supply network node operates under a legal entity (company code) for intercompany transaction processing, tax jurisdiction determination, and stat',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Operating costs of each network node (warehouse, DC) are allocated to a cost center for overhead accounting and performance tracking.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Node location must comply with jurisdictional regulations (e.g., hazardous material storage); linking enforces local compliance.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Node-level P&L reporting: supply network nodes (DCs, plants, 3PLs) are mapped to profit centers for financial reporting of distribution and warehousing costs. Consumer goods multinationals require nod',
    `address_line_1` STRING COMMENT 'Primary street address line for the supply network node location. Organizational contact data classified as confidential.',
    `address_line_2` STRING COMMENT 'Secondary address line (suite, building, floor) for the supply network node location. Organizational contact data classified as confidential.',
    `capacity_class` STRING COMMENT 'Classification of the supply network node storage and throughput capacity used in IBP supply planning for capacity-constrained optimization.. Valid values are `small|medium|large|extra_large|mega`',
    `city` STRING COMMENT 'City where the supply network node is located. Used for geographic analysis and transportation planning. Organizational contact data classified as confidential.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this supply network node record was first created in the system. Used for audit trail and data lineage.',
    `cross_dock_enabled_flag` BOOLEAN COMMENT 'Indicates whether this supply network node supports cross-docking operations (direct transfer without storage). Used in transportation and distribution planning.',
    `dsd_enabled_flag` BOOLEAN COMMENT 'Indicates whether this supply network node supports Direct Store Delivery operations. Used in distribution planning and route optimization.',
    `effective_end_date` DATE COMMENT 'Date when this supply network node was decommissioned or removed from the active supply network. Null for currently active nodes.',
    `effective_start_date` DATE COMMENT 'Date when this supply network node became operational and active in the supply network. Used for historical network analysis and planning.',
    `gln` STRING COMMENT 'GS1 Global Location Number uniquely identifying the physical location of the supply network node for EDI transactions and supply chain visibility.. Valid values are `^[0-9]{13}$`',
    `hazmat_certified_flag` BOOLEAN COMMENT 'Indicates whether this supply network node is certified to handle and store hazardous materials. Used for product allocation and regulatory compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this supply network node record was last updated. Used for change tracking and data synchronization.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the supply network node in decimal degrees. Used for transportation optimization and network design analytics.',
    `lead_time_days` STRING COMMENT 'Standard lead time in days from this supply network node to downstream nodes or customers. Used in DRP execution and ATP/CTP calculations.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the supply network node in decimal degrees. Used for transportation optimization and network design analytics.',
    `node_code` STRING COMMENT 'Business identifier code for the supply network node used across planning and execution systems. Typically a short alphanumeric code used in SAP IBP and ERP systems.. Valid values are `^[A-Z0-9]{4,20}$`',
    `node_name` STRING COMMENT 'Human-readable name of the supply network node (e.g., Chicago Regional DC, Memphis Manufacturing Plant, Dallas Forward DC).',
    `node_status` STRING COMMENT 'Current operational status of the supply network node in the supply planning system. Active nodes participate in DRP and IBP planning runs.. Valid values are `active|inactive|planned|decommissioned|temporarily_closed`',
    `node_type` STRING COMMENT 'Classification of the supply network node indicating its role in the supply chain (manufacturing plant, regional distribution center, forward distribution center, co-manufacturer, third-party logistics warehouse, cross-dock facility, or supplier location). [ENUM-REF-CANDIDATE: manufacturing_plant|regional_dc|forward_dc|co_manufacturer|3pl_warehouse|cross_dock|supplier_location — 7 candidates stripped; promote to reference product]',
    `ownership_type` STRING COMMENT 'Ownership model of the supply network node (company-owned, leased, third-party logistics managed, co-manufacturer, or contract facility). Used for cost allocation and strategic network design.. Valid values are `owned|leased|3pl_managed|co_manufacturer|contract`',
    `planning_group` STRING COMMENT 'Planning group or cluster assignment for the supply network node used in IBP and S&OP processes to aggregate nodes for planning purposes.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the supply network node location. Used for logistics routing and delivery planning. Organizational contact data classified as confidential.',
    `replenishment_frequency` STRING COMMENT 'Standard replenishment frequency for inventory at this supply network node. Used in DRP planning and inventory policy definition.. Valid values are `daily|weekly|biweekly|monthly|on_demand`',
    `safety_stock_days` STRING COMMENT 'Target safety stock coverage in days of supply maintained at this network node. Used in inventory optimization and S&OP planning.',
    `sourcing_priority` STRING COMMENT 'Priority ranking of this supply network node in sourcing rules and allocation logic (lower number = higher priority). Used in IBP supply planning and ATP/CTP allocation.',
    `state_province` STRING COMMENT 'State or province code where the supply network node is located. Used for tax jurisdiction and regulatory compliance. Organizational contact data classified as confidential.',
    `storage_capacity_units` DECIMAL(18,2) COMMENT 'Maximum storage capacity of the supply network node measured in standard storage units (pallets, cases, or cubic meters). Used for inventory optimization and DRP planning.',
    `storage_capacity_uom` STRING COMMENT 'Unit of measure for the storage capacity (pallets, cases, cubic meters, square meters). Aligns with WMS and IBP planning units.. Valid values are `pallets|cases|cubic_meters|square_meters`',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether this supply network node has temperature-controlled storage capabilities for temperature-sensitive products. Used in product allocation and quality management.',
    `throughput_capacity_daily` DECIMAL(18,2) COMMENT 'Maximum daily throughput capacity of the supply network node measured in standard units (cases, pallets, or production units per day). Used for production and distribution planning.',
    `throughput_capacity_uom` STRING COMMENT 'Unit of measure for the daily throughput capacity. Used in production scheduling and distribution planning.. Valid values are `cases_per_day|pallets_per_day|units_per_day|tons_per_day`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the supply network node location (e.g., America/Chicago, America/New_York). Used for scheduling and ATP/CTP calculations.',
    `vmi_enabled_flag` BOOLEAN COMMENT 'Indicates whether this supply network node participates in Vendor Managed Inventory programs. Used in collaborative planning and replenishment processes.',
    CONSTRAINT pk_network_node PRIMARY KEY(`network_node_id`)
) COMMENT 'Master entity representing each node in the supply network (manufacturing plant, regional DC, forward DC, co-manufacturer, 3PL site). Captures node type, geographic location, capacity class, lead time to downstream nodes, sourcing rules, and active status. Forms the backbone of the supply network design used in IBP supply planning and DRP.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`supply`.`network_lane` (
    `network_lane_id` BIGINT COMMENT 'Primary key for network_lane',
    `carrier_id` BIGINT COMMENT 'Identifier of the preferred or contracted transportation carrier servicing this lane. Used for freight planning and cost estimation.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Network lanes crossing borders are subject to compliance obligations (import/export permits, cross-border transport regulations, customs compliance programs). The existing plain-text compliance_requir',
    `network_node_id` BIGINT COMMENT 'Identifier of the receiving supply network node (distribution center, warehouse, retail store, or customer location) to which goods are delivered.',
    `freight_rate_id` BIGINT COMMENT 'Foreign key linking to logistics.freight_rate. Business justification: Supply network lanes require freight rate references for landed cost modeling during supply network design and S&OP. Planners select optimal sourcing lanes based on freight rates — a core consumer goo',
    `lane_id` BIGINT COMMENT 'Foreign key linking to logistics.lane. Business justification: Supply network lanes map to logistics execution lanes for carrier assignment and rate lookup. This link enables planners to resolve the logistics execution lane for a supply network lane — essential f',
    `primary_supply_network_node_id` BIGINT COMMENT 'Identifier of the originating supply network node (plant, distribution center, warehouse, or external supplier) from which goods are sourced.',
    `capacity_quantity` DECIMAL(18,2) COMMENT 'Maximum throughput capacity of this lane per planning period (day, week, month), representing the upper limit of goods that can be moved. Used by Supply Planning and Sales and Operations Planning (S&OP) for capacity-constrained optimization.',
    `capacity_uom` STRING COMMENT 'Unit of measure for the capacity quantity field, indicating how lane capacity is measured and constrained. [ENUM-REF-CANDIDATE: EA|CS|PL|TU|KG|LB|L|GAL — 8 candidates stripped; promote to reference product]',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard transportation or transfer cost per unit of measure for moving goods along this lane. Used for supply chain cost modeling and total landed cost calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this supply network lane record was first created in the system, following ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost and pricing on this lane (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when this supply network lane ceases or will cease to be effective. Null for lanes with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this supply network lane becomes or became effective and available for use in planning and execution systems.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this lane is currently active and available for use in supply planning and replenishment. True if active; false if temporarily or permanently disabled.',
    `is_primary_lane` BOOLEAN COMMENT 'Boolean flag indicating whether this lane is the primary (preferred) sourcing route for the destination. True if this is the default lane used under normal conditions; false for backup or secondary lanes.',
    `lane_type` STRING COMMENT 'Classification of the supply network lane based on the nature of the sourcing relationship: production (from manufacturing plant), transfer (between internal facilities), external procurement (from supplier), direct shipment (plant to customer), cross-dock (no storage), or drop-ship (supplier to customer).. Valid values are `production|transfer|external_procurement|direct_shipment|cross_dock|drop_ship`',
    `last_modified_by` STRING COMMENT 'Identifier of the user or system process that last modified this supply network lane record, used for audit trail and data governance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this supply network lane record was most recently updated, following ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `lot_size_quantity` DECIMAL(18,2) COMMENT 'Standard batch or lot size for replenishment orders on this lane. Orders are typically rounded to multiples of this quantity for operational efficiency (e.g., full pallet, full truckload).',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity that can be ordered or shipped on this lane in a single replenishment cycle, constrained by capacity, vehicle limits, or storage restrictions.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered or shipped on this lane to meet operational or economic constraints. Used by DRP to ensure replenishment orders meet minimum thresholds.',
    `network_lane_status` STRING COMMENT 'Current lifecycle status of the supply network lane: active (operational), inactive (temporarily disabled), suspended (on hold), planned (future activation), or decommissioned (permanently closed).. Valid values are `active|inactive|suspended|planned|decommissioned`',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special handling instructions, or contextual information about this supply network lane.',
    `otif_target_pct` DECIMAL(18,2) COMMENT 'Specific target percentage for On Time In Full delivery performance on this lane, a key supply chain Key Performance Indicator (KPI) measuring the percentage of orders delivered on time and complete.',
    `planning_group` STRING COMMENT 'Organizational grouping or planning segment to which this lane belongs, used for segmented planning and reporting in Sales and Operations Planning (S&OP) and Integrated Business Planning (IBP).',
    `processing_lead_time_days` DECIMAL(18,2) COMMENT 'Time in days required for order processing, picking, packing, and loading at the source location before shipment begins.',
    `risk_category` STRING COMMENT 'Supply risk classification for this lane based on factors such as lead time variability, carrier reliability, geopolitical risk, and single-source dependency. Used for supply risk management and contingency planning.. Valid values are `low|medium|high|critical`',
    `safety_stock_days` DECIMAL(18,2) COMMENT 'Number of days of safety stock coverage recommended at the destination to buffer against variability in this lanes lead time and demand. Used by Inventory Optimization to calculate safety stock targets.',
    `service_level_target_pct` DECIMAL(18,2) COMMENT 'Target service level percentage for on-time and in-full delivery performance on this lane, expressed as a percentage (e.g., 95.00 for 95%). Used to measure On Time In Full (OTIF) performance.',
    `sourcing_priority` STRING COMMENT 'Numeric ranking indicating the preference order for this lane when multiple sourcing options exist for the same destination. Lower numbers indicate higher priority (1 = primary, 2 = secondary, etc.). Used by Distribution Requirements Planning (DRP) and Integrated Business Planning (IBP) to determine replenishment routing.',
    `standard_lead_time_days` DECIMAL(18,2) COMMENT 'Total planned lead time in days from order placement to goods receipt at destination, including processing time, transportation time, and buffer. Used by Material Requirements Planning (MRP) and Distribution Requirements Planning (DRP) for replenishment calculations.',
    `transportation_lead_time_days` DECIMAL(18,2) COMMENT 'Transit time in days for goods to move from source to destination, excluding processing and handling time. Component of the total standard lead time.',
    `transportation_mode` STRING COMMENT 'Primary method of transportation used for moving goods along this lane: truck (road freight), rail (train), ocean (sea freight), air (air cargo), intermodal (combination), or parcel (small package delivery).. Valid values are `truck|rail|ocean|air|intermodal|parcel`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for quantities on this lane: EA (each), CS (case), PL (pallet), TU (truck unit), KG (kilogram), LB (pound), L (liter), GAL (gallon). Aligns with GS1 standards. [ENUM-REF-CANDIDATE: EA|CS|PL|TU|KG|LB|L|GAL — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_network_lane PRIMARY KEY(`network_lane_id`)
) COMMENT 'Master entity defining the sourcing lane between two supply network nodes (source-destination pair). Captures lane type (production, transfer, external procurement), primary/secondary sourcing priority, standard lead time, transportation lead time, minimum order quantity (MOQ), lot size, and active status. Used by DRP and IBP to determine replenishment routing.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`supply`.`atp_record` (
    `atp_record_id` BIGINT COMMENT 'Primary key for atp_record',
    `batch_release_id` BIGINT COMMENT 'Foreign key linking to quality.batch_release. Business justification: ATP systems in consumer goods must filter available stock to released batches only. Direct FK to batch_release avoids multi-hop joins (lot_batch → inspection_lot → batch_release) in time-critical ATP ',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: ATP/CTP confirmation in consumer goods promotional order promising requires direct reference to the promotion_event driving the demand. Enables promotional ATP allocation reporting, event-level supply',
    `event_sku_id` BIGINT COMMENT 'Foreign key linking to promotion.event_sku. Business justification: ATP confirmation for promoted SKUs in consumer goods must reference the event_sku record to validate planned_promotional_volume_cases against available supply. Direct FK enables promotional ATP alloca',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: ATP calculation in consumer goods must exclude inventory quantities under active quality inspection or hold. Direct FK to inspection_lot allows ATP engine to filter blocked stock in real time, prevent',
    `inventory_position_id` BIGINT COMMENT 'Foreign key linking to distribution.inventory_position. Business justification: ATP calculations are directly backed by specific inventory positions at distribution facilities. Linking atp_record to inventory_position enables allocation and reservation management — supply planner',
    `lot_batch_id` BIGINT COMMENT 'Reference to the specific lot or batch for lot-controlled SKUs where ATP is tracked at the batch level.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to supply.plan. Business justification: ATP/CTP calculations are derived from the supply plan (planned receipts, production orders, projected inventory). An atp_record should reference the plan version it was computed from to enable plan-to',
    `planned_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.planned_order. Business justification: ATP records peg planned orders as future supply receipts (planned_receipt_quantity). Linking atp_record to planned_order enables capable-to-promise (CTP) calculations and supply pegging traceability f',
    `planning_period_id` BIGINT COMMENT 'Foreign key linking to supply.planning_period. Business justification: ATP records are computed for specific planning periods. Linking atp_record to planning_period enables period-based ATP analysis and S&OP reporting. One planning_period can have many ATP records (diffe',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: ATP calculations peg confirmed production orders as committed supply. atp_record.production_order_quantity is an aggregate metric; the FK to production_order enables supply pegging traceability for or',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: ATP/CTP calculations peg open purchase orders as confirmed supply receipts. Linking atp_record directly to purchase_order enables supply pegging (which PO covers which demand), available-to-promise co',
    `registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.registration. Business justification: ATP calculations need to confirm inventory belongs to registered products to meet legal availability commitments.',
    `safety_stock_id` BIGINT COMMENT 'Foreign key linking to supply.safety_stock. Business justification: atp_record.safety_stock_quantity is a denormalized field used as a floor in ATP calculations. Formalizing this as a FK to safety_stock enables traceability to the approved safety stock record that inf',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: ATP demand pegging links supply availability to specific sales orders for order promising and OTIF tracking. The existing demand_pegging_reference is a plain text field; a proper FK to sales.order is ',
    `sku_id` BIGINT COMMENT 'Reference to the SKU for which ATP is calculated.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: ATP calculation process: ATP records are derived directly from physical stock positions. This link enables ATP accuracy audits and real-time ATP recalculation when stock changes. Consumer goods ATP en',
    `network_node_id` BIGINT COMMENT 'Reference to the distribution facility or warehouse location where ATP is calculated.',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to sales.trade_account. Business justification: Customer-specific ATP allocation is standard in consumer goods — major retailers receive dedicated ATP buckets. Order promising, customer priority tier management, and account-level available inventor',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'The quantity already committed or reserved for existing sales orders, reducing available ATP.',
    `atp_calculation_method` STRING COMMENT 'The method used to calculate ATP. Simple ATP considers only on-hand inventory minus allocations. Cumulative ATP includes planned receipts over time. Multi-level ATP considers BOM components. Product allocation ATP applies allocation rules across customer segments.. Valid values are `simple|cumulative|multi_level|product_allocation`',
    `atp_check_horizon_days` STRING COMMENT 'The number of days into the future that the ATP check considers for availability. Defines the planning horizon for promise calculations.',
    `atp_confirmation_number` STRING COMMENT 'Unique confirmation number generated when ATP is reserved for a sales order, providing traceability between ATP records and order promising.',
    `atp_date` DATE COMMENT 'The date for which ATP quantity is calculated. Represents the promise date for order fulfillment.',
    `atp_quantity` DECIMAL(18,2) COMMENT 'The confirmed quantity available to promise to customers for the given SKU, location, and date. Represents uncommitted inventory available for new orders.',
    `atp_status` STRING COMMENT 'The current status of the ATP record. Available indicates positive ATP. Constrained indicates limited availability. Blocked indicates ATP is not available for promising. Expired indicates the ATP date has passed.. Valid values are `available|constrained|blocked|expired`',
    `backorder_quantity` DECIMAL(18,2) COMMENT 'The quantity of unfulfilled demand from previous periods that impacts current ATP availability.',
    `calculation_timestamp` TIMESTAMP COMMENT 'The exact date and time when this ATP record was calculated. Critical for understanding data freshness and order promising accuracy.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this ATP record was first created in the lakehouse silver layer.',
    `ctp_quantity` DECIMAL(18,2) COMMENT 'The quantity that can be promised considering both current inventory and planned production or supply receipts. Extends ATP by including future supply.',
    `cumulative_atp_quantity` DECIMAL(18,2) COMMENT 'The cumulative ATP quantity calculated across multiple time periods, showing total available quantity from current date through the ATP date.',
    `customer_priority_tier` STRING COMMENT 'The priority tier of the customer or channel for which ATP is being calculated, used in allocation scenarios where high-priority customers receive preferential ATP.. Valid values are `tier_1|tier_2|tier_3|standard`',
    `demand_pegging_reference` STRING COMMENT 'Reference identifier linking ATP consumption to specific demand sources such as sales orders, forecasts, or customer reservations.',
    `expiration_date` DATE COMMENT 'The expiration date of the inventory lot or batch, relevant for FEFO (First Expired First Out) ATP logic in consumer goods with shelf life constraints.',
    `forecast_consumption_quantity` DECIMAL(18,2) COMMENT 'The quantity of forecast demand consumed by actual sales orders, used in ATP calculations to avoid double-counting demand.',
    `intransit_quantity` DECIMAL(18,2) COMMENT 'The quantity currently in transit to the location that will contribute to ATP upon arrival.',
    `minimum_shelf_life_days` STRING COMMENT 'The minimum remaining shelf life in days required for the product to be available for promising, ensuring customers receive products with adequate shelf life.',
    `planned_receipt_quantity` DECIMAL(18,2) COMMENT 'The quantity expected to be received from production orders, purchase orders, or transfers by the ATP date.',
    `planning_version` STRING COMMENT 'The planning scenario or version identifier in SAP IBP under which this ATP calculation was performed, enabling what-if analysis and scenario planning.',
    `product_allocation_group` STRING COMMENT 'The allocation group or priority segment assigned to this ATP calculation, used when ATP is allocated across customer tiers or channels.',
    `production_order_quantity` DECIMAL(18,2) COMMENT 'The quantity scheduled for production that will be available by the ATP date.',
    `purchase_order_quantity` DECIMAL(18,2) COMMENT 'The quantity on open purchase orders expected to be received by the ATP date.',
    `source_system` STRING COMMENT 'The operational system that generated this ATP record (e.g., SAP IBP, SAP S/4HANA, Oracle Cloud SCM).',
    `source_system_record_code` STRING COMMENT 'The unique identifier of this ATP record in the source operational system, enabling traceability and reconciliation.',
    `supply_pegging_reference` STRING COMMENT 'Reference identifier linking ATP availability to specific supply sources such as production orders, purchase orders, or stock transfers.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for all quantity fields in this record. Common values: EA (each), CS (case), PL (pallet), KG (kilogram), LB (pound), L (liter), GAL (gallon). [ENUM-REF-CANDIDATE: EA|CS|PL|KG|LB|L|GAL — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this ATP record was last updated in the lakehouse silver layer.',
    CONSTRAINT pk_atp_record PRIMARY KEY(`atp_record_id`)
) COMMENT 'Transactional record capturing the Available-to-Promise (ATP) and Capable-to-Promise (CTP) calculation results for each SKU/location/date combination. Stores confirmed ATP quantity, CTP quantity, cumulative ATP, demand pegging reference, supply pegging reference, calculation timestamp, and ATP method (simple, cumulative, multi-level). Consumed by sales order management for order promising.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` (
    `consensus_demand_id` BIGINT COMMENT 'Unique identifier for the consensus demand record. Primary key for this entity representing a single agreed demand signal from the S&OP demand review process.',
    `baseline_volume_id` BIGINT COMMENT 'Foreign key linking to promotion.baseline_volume. Business justification: consensus_demand carries statistical_forecast_quantity and variance_to_statistical that are benchmarked against the promotional baseline_volume. Direct FK enables S&OP consensus review to validate tha',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Consensus demand records carry marketing_event_uplift_quantity and promotion_flag. In Consumer Goods S&OP, the agreed consensus volume must be pegged to the specific campaign driving the uplift for ac',
    `consumer_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.consumer_segment. Business justification: Consumer Goods demand planning increasingly builds segment-level consensus demand views (e.g., premium vs. value segment volumes) to support portfolio and innovation pipeline decisions. Linking consen',
    `demand_plan_id` BIGINT COMMENT 'FK to supply.demand_plan.demand_plan_id — Links consensus demand records to demand plan header. Required for S&OP process tracking and forecast accuracy measurement.',
    `event_id` BIGINT COMMENT 'Reference to the specific trade promotion or marketing event driving incremental demand. Populated only when promotion_flag is true.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: IBP volume-to-value translation: consensus demand is the agreed volume plan used as direct input to financial revenue budgeting. Finance teams translate consensus demand quantities into revenue budget',
    `hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.hierarchy. Business justification: Consensus demand reconciliation in S&OP is performed at brand and category hierarchy levels before disaggregation to SKU. Consumer goods IBP processes require consensus demand records at aggregate hie',
    `planning_period_id` BIGINT COMMENT 'Reference to the time bucket (week, month, quarter) for which this consensus demand is valid. Links to the planning calendar.',
    `registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_registration. Business justification: Consensus demand finalization in IBP/S&OP requires validation against active market registrations. If a registration is suspended or expired for a SKU-market combination, consensus demand must be zero',
    `sku_id` BIGINT COMMENT 'Reference to the product SKU for which consensus demand is being planned. Links to the product master data.',
    `sku_planning_param_id` BIGINT COMMENT 'Foreign key linking to supply.sku_planning_param. Business justification: consensus_demand is the final agreed demand volume for a specific SKU/node/period combination. sku_planning_param stores the planning parameters for that same SKU/node combination. Linking consensus_d',
    `network_node_id` BIGINT COMMENT 'Reference to the planning location (distribution center, plant, or market) for which this consensus demand applies.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Territory-level consensus demand is used in consumer goods S&OP to align supply plans with sales force coverage and regional quota. Field sales teams validate consensus demand by territory; this link ',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to sales.trade_account. Business justification: Key account-level consensus demand is a standard S&OP input in consumer goods. Planners build consensus demand per major retailer to align supply with account commitments. Joint Business Planning (JBP',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this consensus demand record is currently active and should be used by supply planning. False indicates the record has been superseded or deactivated.',
    `approval_status` STRING COMMENT 'Current approval state of the consensus demand record within the S&OP workflow. Only approved records are released to supply planning.. Valid values are `draft|submitted|approved|rejected|revised`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the consensus demand was formally approved and released to supply planning. Marks the transition from draft to official demand signal.',
    `bias_indicator` STRING COMMENT 'Indicator of systematic forecasting bias based on historical performance. Over-forecast indicates consistent overestimation; under-forecast indicates consistent underestimation; neutral indicates balanced accuracy.. Valid values are `over_forecast|under_forecast|neutral`',
    `comments` STRING COMMENT 'Free-text field for demand planners to capture additional context, assumptions, risks, or special considerations related to this consensus demand record.',
    `commercial_overlay_quantity` DECIMAL(18,2) COMMENT 'The demand adjustment applied by commercial teams based on market intelligence, customer commitments, and sales insights. Can be positive or negative.',
    `confidence_level` STRING COMMENT 'Qualitative assessment of confidence in the consensus demand figure based on data quality, market stability, and input reliability. Used for risk-based supply planning.. Valid values are `high|medium|low`',
    `consensus_quantity` DECIMAL(18,2) COMMENT 'The final agreed demand volume for this SKU/location/period after all inputs and overlays have been applied. This is the single demand signal passed to supply planning and represents the official forecast.',
    `constrained_flag` BOOLEAN COMMENT 'Indicates whether the consensus demand has been adjusted downward due to known supply constraints. True means demand was constrained; false means demand is unconstrained.',
    `constraint_reason` STRING COMMENT 'Explanation of the supply constraint that limited consensus demand (e.g., production capacity, raw material shortage, distribution capacity). Populated only when constrained_flag is true.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this consensus demand record was first created in the system. Part of standard audit trail.',
    `customer_commitment_quantity` DECIMAL(18,2) COMMENT 'Demand volume backed by firm customer orders, contracts, or commitments for this planning period. Represents the most reliable component of consensus demand.',
    `demand_category` STRING COMMENT 'Classification of the demand type to enable segmented planning and analysis. Base demand represents ongoing business; promotional and seasonal reflect event-driven spikes; new launch and phase-out support lifecycle transitions.. Valid values are `base|promotional|seasonal|new_launch|phase_out|special_order`',
    `demand_driver_code` STRING COMMENT 'Code identifying the primary business driver or causal factor influencing this demand (e.g., holiday season, weather pattern, competitive action, regulatory change). Supports root-cause analysis.',
    `demand_driver_description` STRING COMMENT 'Detailed explanation of the demand driver or business rationale behind the consensus demand figure. Captures qualitative insights from demand planners and commercial teams.',
    `demand_volatility_index` DECIMAL(18,2) COMMENT 'Statistical measure of demand variability for this SKU/location combination, typically expressed as coefficient of variation. Higher values indicate greater uncertainty and require higher safety stock.',
    `forecast_accuracy_previous_period` DECIMAL(18,2) COMMENT 'The forecast accuracy percentage achieved for this SKU/location combination in the previous planning period. Used to assess forecasting performance trends and adjust confidence levels.',
    `forecast_model_code` STRING COMMENT 'Identifier of the statistical forecasting model or algorithm used to generate the baseline statistical forecast (e.g., exponential smoothing, ARIMA, machine learning model).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this consensus demand record was last updated. Tracks the most recent change to any field in the record.',
    `last_review_date` DATE COMMENT 'Date when this consensus demand record was last reviewed and validated by the demand planning team during the S&OP demand review meeting.',
    `marketing_event_uplift_quantity` DECIMAL(18,2) COMMENT 'Incremental demand volume expected from planned marketing campaigns, promotions, or trade events during this planning period.',
    `new_product_launch_quantity` DECIMAL(18,2) COMMENT 'Demand volume attributed to new product introductions or product launches scheduled for this planning period. Typically based on launch plans and market sizing.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next S&OP demand review when this consensus demand will be re-evaluated and updated based on latest market intelligence.',
    `planning_horizon_type` STRING COMMENT 'Classification of the planning time horizon for this demand record. Short-term (0-3 months) is firm; medium-term (3-12 months) is flexible; long-term (12+ months) is strategic.. Valid values are `short_term|medium_term|long_term`',
    `promotion_flag` BOOLEAN COMMENT 'Indicates whether this consensus demand includes uplift from planned trade promotions or marketing events. True means promotional activity is planned; false means base demand only.',
    `seasonality_factor` DECIMAL(18,2) COMMENT 'Multiplicative factor representing seasonal demand patterns for this planning period. Values above 1.0 indicate peak season; below 1.0 indicate off-season.',
    `statistical_forecast_quantity` DECIMAL(18,2) COMMENT 'The baseline demand forecast generated by statistical forecasting algorithms before any manual adjustments or commercial overlays. Serves as the starting point for consensus demand.',
    `unconstrained_demand_quantity` DECIMAL(18,2) COMMENT 'The theoretical demand volume if all supply constraints (capacity, materials, inventory) were removed. Used for capacity planning and investment decisions.',
    `unit_of_measure` STRING COMMENT 'The unit in which consensus demand quantity is expressed (each, case, pallet, kilogram, liter, etc.). Must align with product master UOM. [ENUM-REF-CANDIDATE: EA|CS|PAL|KG|LB|L|GAL — 7 candidates stripped; promote to reference product]',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The percentage variance between consensus demand and statistical forecast, calculated as (variance_to_statistical / statistical_forecast_quantity) * 100. Used to monitor forecast override patterns.',
    `variance_to_statistical` DECIMAL(18,2) COMMENT 'The difference between consensus demand quantity and statistical forecast quantity. Positive values indicate upward adjustments; negative values indicate downward adjustments. Key metric for forecast bias analysis.',
    `version_number` STRING COMMENT 'Sequential version number tracking iterations of this consensus demand record within the same S&OP cycle. Increments with each revision to support change history.',
    CONSTRAINT pk_consensus_demand PRIMARY KEY(`consensus_demand_id`)
) COMMENT 'Transactional record capturing the final consensus demand volume agreed upon during the S&OP demand review for each SKU/location/planning period. Stores statistical forecast input, commercial overlay, marketing event uplift, new product launch volume, consensus quantity, variance to statistical baseline, approver, and S&OP cycle reference. Represents the single agreed demand signal passed to supply planning.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` (
    `sku_planning_param_id` BIGINT COMMENT 'Unique identifier for the SKU planning parameter record. Primary key for this entity.',
    `approved_supplier_list_id` BIGINT COMMENT 'Foreign key linking to procurement.approved_supplier_list. Business justification: SKU planning parameters define sourcing strategy and procurement type per SKU/node. Linking to the approved supplier list enables MRP to automatically select the correct approved supplier when generat',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: SKU planning parameters (minimum_remaining_shelf_life_days, safety_stock_method, shelf_life_days) are directly driven by compliance obligations — e.g., a market obligation mandating minimum shelf life',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the manufacturing plant or production facility where this SKU is produced or sourced. Used for plant-specific planning parameters.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU in the product master. Links planning parameters to the specific product variant being planned.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: SKU planning parameters for shelf-life-sensitive consumer goods (personal care, health, hygiene) must reference the quality specification to enforce minimum remaining shelf life, retest intervals, and',
    `standard_cost_id` BIGINT COMMENT 'Foreign key linking to finance.standard_cost. Business justification: Planning parameter cost calibration: SKU planning parameters (lot sizes, reorder points, safety stock methods, inventory valuation method) are set using standard cost inputs. Consumer goods supply pla',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_contract. Business justification: SKU planning parameters (lead times, MOQ, delivery time) are derived from the active supplier contract. Linking sku_planning_param to supplier_contract enables automatic parameter refresh when contrac',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: sku_planning_param needs to be associated with the network node it applies to; added new FK supply_network_node_id referencing network_node.supply_network_node_id.',
    `abc_classification` STRING COMMENT 'ABC inventory classification based on revenue contribution or consumption value. A items are high-value requiring tight control, C items are low-value with relaxed control.. Valid values are `A|B|C`',
    `backorder_allowed_flag` BOOLEAN COMMENT 'Indicates whether backorders are permitted for this SKU when inventory is insufficient. True allows demand to be backordered, false requires immediate fulfillment or cancellation.',
    `coverage_profile_days` STRING COMMENT 'Target days of supply to maintain in inventory. Represents desired inventory coverage horizon based on demand forecast and replenishment frequency.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this planning parameter record was first created in the system. Supports audit trail and data lineage tracking.',
    `critical_part_flag` BOOLEAN COMMENT 'Indicates whether this SKU is classified as a critical part requiring special planning attention. Critical parts may have higher service levels or expedited replenishment.',
    `demand_pattern_type` STRING COMMENT 'Characterization of the SKUs historical demand pattern. Determines appropriate forecasting method and safety stock calculation approach.. Valid values are `steady|seasonal|trending|intermittent|lumpy|erratic`',
    `effective_end_date` DATE COMMENT 'Date after which these planning parameters are no longer active. Null indicates parameters are currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date from which these planning parameters become active and are used by planning systems. Supports time-phased parameter changes.',
    `fixed_lot_size_quantity` DECIMAL(18,2) COMMENT 'Fixed production or procurement lot size quantity when using fixed lot size method. Represents standard batch size for manufacturing or ordering.',
    `forecast_model_type` STRING COMMENT 'Statistical or machine learning model used for demand forecasting. Determines the algorithm applied during forecast generation in IBP or demand planning systems.. Valid values are `moving_average|exponential_smoothing|holt_winters|arima|machine_learning|consensus`',
    `goods_receipt_processing_time_days` STRING COMMENT 'Time required for quality inspection and goods receipt processing after physical delivery. Adds to total replenishment lead time.',
    `inventory_valuation_method` STRING COMMENT 'Method used for inventory valuation and consumption. FIFO (First In First Out), FEFO (First Expired First Out), LIFO (Last In First Out), or weighted average costing.. Valid values are `fifo|fefo|lifo|weighted_average|standard_cost`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this planning parameter record was last updated. Tracks most recent change for change management and audit purposes.',
    `last_review_date` DATE COMMENT 'Date when planning parameters were last reviewed and validated by the planning team. Supports periodic parameter maintenance and accuracy audits.',
    `lot_size_method` STRING COMMENT 'Method used to calculate production or procurement lot sizes. Determines how order quantities are calculated in MRP and supply planning runs.. Valid values are `fixed_lot_size|economic_order_quantity|lot_for_lot|period_order_quantity|weekly_lot_size|monthly_lot_size`',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity that can be ordered or produced in a single transaction. Limited by production capacity, storage constraints, or supplier capabilities.',
    `maximum_stock_level_quantity` DECIMAL(18,2) COMMENT 'Maximum inventory level target for this SKU. Used in min-max planning to cap inventory investment and prevent overstock situations.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered or produced in a single transaction. Enforced by supplier contracts or manufacturing constraints.',
    `minimum_remaining_shelf_life_days` STRING COMMENT 'Minimum remaining shelf life required at time of shipment to customer or retail delivery. Ensures product quality and retailer acceptance.',
    `mrp_controller_code` STRING COMMENT 'Code identifying the MRP controller or planner responsible for this SKU. Used for workload assignment and exception management routing.',
    `mrp_type` STRING COMMENT 'MRP procedure that controls how the planning system generates procurement proposals. Determines planning logic and automation level.. Valid values are `mrp|reorder_point|forecast_based|time_phased|no_planning`',
    `next_review_date` DATE COMMENT 'Scheduled date for next planning parameter review. Ensures regular validation of planning assumptions and parameter accuracy.',
    `order_multiple_quantity` DECIMAL(18,2) COMMENT 'Quantity increment in which orders must be placed. All order quantities must be multiples of this value due to packaging or production constraints.',
    `parameter_notes` STRING COMMENT 'Free-text notes documenting special planning considerations, parameter rationale, or exceptions for this SKU. Provides context for planning decisions.',
    `parameter_status` STRING COMMENT 'Current lifecycle status of the planning parameter record. Active parameters are used in planning runs, inactive parameters are ignored.. Valid values are `active|inactive|pending_approval|obsolete`',
    `planned_delivery_time_days` STRING COMMENT 'Standard lead time in days from order placement to goods receipt. Used for MRP scheduling and supply plan timing calculations.',
    `planning_group` STRING COMMENT 'IBP planning group assignment for demand and supply planning segmentation. Groups SKUs with similar planning characteristics for collaborative planning processes.',
    `planning_horizon_days` STRING COMMENT 'Number of days into the future for which demand and supply planning is performed. Defines the forward-looking planning window for this SKU.',
    `planning_strategy` STRING COMMENT 'Manufacturing planning strategy that determines how the SKU is planned and produced. Make-to-stock produces to forecast, make-to-order produces against customer orders.. Valid values are `make_to_stock|make_to_order|assemble_to_order|engineer_to_order|planning_without_final_assembly`',
    `planning_time_fence_days` STRING COMMENT 'Number of days within which the planning system cannot automatically change planned orders without planner approval. Protects near-term production schedule stability.',
    `procurement_type` STRING COMMENT 'Indicates whether the SKU is externally procured from suppliers, produced in-house, or both. Determines supply planning logic and sourcing strategy.. Valid values are `external_procurement|in_house_production|both|subcontracting`',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT 'Inventory level that triggers a replenishment order. Calculated based on lead time demand plus safety stock to prevent stockouts.',
    `rounding_profile_code` STRING COMMENT 'Code defining rounding rules for planned order quantities. Ensures quantities align with packaging units, pallet configurations, or production batch constraints.',
    `safety_stock_method` STRING COMMENT 'Method used to calculate safety stock levels. Fixed quantity uses static buffer, service level based uses demand variability and lead time uncertainty.. Valid values are `fixed_quantity|days_of_supply|dynamic_calculation|service_level_based`',
    `seasonality_profile_code` STRING COMMENT 'Code identifying the seasonality pattern applied to this SKU for demand forecasting. Links to predefined seasonal index curves (e.g., summer peak, holiday spike).',
    `service_level_target_percent` DECIMAL(18,2) COMMENT 'Target service level percentage for this SKU (e.g., 95%, 98%, 99%). Drives safety stock calculation to achieve desired product availability.',
    `shelf_life_days` STRING COMMENT 'Total shelf life of the SKU in days from production date to expiration. Critical for FEFO inventory management and demand planning for perishable goods.',
    `unit_of_measure` STRING COMMENT 'Base unit of measure for all planning quantities (e.g., EA for each, CS for case, KG for kilogram). Standardizes quantity representation across planning processes.',
    `xyz_classification` STRING COMMENT 'XYZ demand variability classification. X items have stable demand, Y items have moderate variability, Z items have highly erratic or sporadic demand patterns.. Valid values are `X|Y|Z`',
    CONSTRAINT pk_sku_planning_param PRIMARY KEY(`sku_planning_param_id`)
) COMMENT 'Master entity storing SKU-level planning parameters used in demand and supply planning calculations. Captures planning horizon, lot size, minimum order quantity (MOQ), shelf life (days), FEFO/FIFO flag, planning strategy (make-to-stock/make-to-order), ABC/XYZ classification, demand pattern type, seasonality index, and IBP planning group assignment. Distinct from product master (owned by product domain) as this captures supply-planning-specific parameters.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`supply`.`planning_period` (
    `planning_period_id` BIGINT COMMENT 'Primary key for planning_period',
    `previous_planning_period_id` BIGINT COMMENT 'Self-referencing FK on planning_period (previous_planning_period_id)',
    `trade_calendar_id` BIGINT COMMENT 'Foreign key linking to promotion.trade_calendar. Business justification: In consumer goods integrated business planning, supply planning periods are aligned to trade calendar cycles. Direct FK enables IBP calendar synchronization, ensuring supply plans and promotional plan',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the planning period record was created.',
    `duration_days` STRING COMMENT 'Number of days covered by the planning period.',
    `effective_from` DATE COMMENT 'Date when the period becomes effective for planning purposes.',
    `effective_until` DATE COMMENT 'Date when the period ceases to be effective (nullable for open‑ended).',
    `end_date` DATE COMMENT 'Last calendar day of the planning period.',
    `is_historical` BOOLEAN COMMENT 'Indicates whether the period is historical (true) or future (false).',
    `period_code` STRING COMMENT 'External code used in planning systems to reference the period.',
    `period_name` STRING COMMENT 'Human‑readable name of the planning period (e.g., FY2024 Q1).',
    `period_type` STRING COMMENT 'Category of the period (fiscal, calendar, rolling, forecast).',
    `planning_horizon` STRING COMMENT 'Planning horizon classification for the period.',
    `planning_period_description` STRING COMMENT 'Free‑text description of the planning period purpose.',
    `planning_period_status` STRING COMMENT 'Current lifecycle status of the period.',
    `start_date` DATE COMMENT 'First calendar day of the planning period.',
    `time_zone` STRING COMMENT 'Time zone applicable to the period timestamps.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the planning period record.',
    CONSTRAINT pk_planning_period PRIMARY KEY(`planning_period_id`)
) COMMENT 'Master reference table for planning_period. Referenced by planning_period_id.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`supply`.`sku_lane_assignment` (
    `sku_lane_assignment_id` BIGINT COMMENT 'Primary key for the sku_lane_assignment association',
    `network_lane_id` BIGINT COMMENT 'Foreign key linking to the network lane that is being assigned as a valid sourcing option for the SKU',
    `sku_planning_param_id` BIGINT COMMENT 'Foreign key linking to the SKU planning parameter record for which this lane assignment applies',
    `assignment_status` STRING COMMENT 'Current lifecycle status of this SKU-lane assignment. Active assignments are used by planning engines; inactive or suspended assignments are retained for audit and reactivation purposes.',
    `effective_end_date` DATE COMMENT 'Date after which this SKU-lane assignment is no longer active. Null indicates the assignment is open-ended. May differ from the lanes own effective_end_date.',
    `effective_start_date` DATE COMMENT 'Date from which this SKU-lane assignment becomes active and is used by planning engines for replenishment routing. May differ from the lanes own effective_start_date.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity specific to this SKU on this lane. Overrides both the lanes general MOQ and the SKUs general MOQ when this assignment is active, reflecting negotiated or operational constraints for this specific SKU-lane combination.',
    `sourcing_priority` STRING COMMENT 'Numeric ranking indicating the preference order for this lane when multiple sourcing lanes are valid for the same SKU. Lower values indicate higher priority. Distinct from the lanes general sourcing_priority as it is specific to this SKU-lane combination.',
    `standard_lead_time_days` DECIMAL(18,2) COMMENT 'Standard lead time in days for this specific SKU on this lane, from order placement to goods receipt. May differ from the lanes general lead time due to SKU-specific handling, inspection, or processing requirements.',
    CONSTRAINT pk_sku_lane_assignment PRIMARY KEY(`sku_lane_assignment_id`)
) COMMENT 'This association product represents the operational assignment (sourcing rule) between a network_lane and a sku_planning_param. It captures which network lanes are valid sourcing options for a given SKU at a given planning node, along with the lane-specific planning parameters (priority, lead time, MOQ) that govern how the planning system uses each lane for that SKU. Each record links one network_lane to one sku_planning_param with attributes that exist only in the context of this SKU-lane sourcing relationship, and is actively managed during supply network design and S&OP reviews.. Existence Justification: In consumer goods supply chain planning, a network lane (source-destination pair) services many SKUs, and a single SKU may have multiple valid sourcing lanes with different priorities, lead times, and order quantities. This SKU-to-lane assignment is a recognized operational concept in planning systems like SAP IBP and is actively managed during supply network design reviews — planners create, update, and deactivate these assignments as sourcing strategies evolve. The relationship carries its own data (sourcing priority, effective dates, MOQ per lane) that belongs neither to the lane alone nor to the SKU planning parameters alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_planning_period_id` FOREIGN KEY (`planning_period_id`) REFERENCES `consumer_goods_ecm`.`supply`.`planning_period`(`planning_period_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_sku_planning_param_id` FOREIGN KEY (`sku_planning_param_id`) REFERENCES `consumer_goods_ecm`.`supply`.`sku_planning_param`(`sku_planning_param_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `consumer_goods_ecm`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_demand_plan_id` FOREIGN KEY (`demand_plan_id`) REFERENCES `consumer_goods_ecm`.`supply`.`demand_plan`(`demand_plan_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_network_lane_id` FOREIGN KEY (`network_lane_id`) REFERENCES `consumer_goods_ecm`.`supply`.`network_lane`(`network_lane_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_planning_period_id` FOREIGN KEY (`planning_period_id`) REFERENCES `consumer_goods_ecm`.`supply`.`planning_period`(`planning_period_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_safety_stock_id` FOREIGN KEY (`safety_stock_id`) REFERENCES `consumer_goods_ecm`.`supply`.`safety_stock`(`safety_stock_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_sku_planning_param_id` FOREIGN KEY (`sku_planning_param_id`) REFERENCES `consumer_goods_ecm`.`supply`.`sku_planning_param`(`sku_planning_param_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `consumer_goods_ecm`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_planning_period_id` FOREIGN KEY (`planning_period_id`) REFERENCES `consumer_goods_ecm`.`supply`.`planning_period`(`planning_period_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_sku_planning_param_id` FOREIGN KEY (`sku_planning_param_id`) REFERENCES `consumer_goods_ecm`.`supply`.`sku_planning_param`(`sku_planning_param_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `consumer_goods_ecm`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `consumer_goods_ecm`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_network_lane_id` FOREIGN KEY (`network_lane_id`) REFERENCES `consumer_goods_ecm`.`supply`.`network_lane`(`network_lane_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `consumer_goods_ecm`.`supply`.`plan`(`plan_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_primary_supply_network_node_id` FOREIGN KEY (`primary_supply_network_node_id`) REFERENCES `consumer_goods_ecm`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_safety_stock_id` FOREIGN KEY (`safety_stock_id`) REFERENCES `consumer_goods_ecm`.`supply`.`safety_stock`(`safety_stock_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ADD CONSTRAINT `fk_supply_network_lane_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `consumer_goods_ecm`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ADD CONSTRAINT `fk_supply_network_lane_primary_supply_network_node_id` FOREIGN KEY (`primary_supply_network_node_id`) REFERENCES `consumer_goods_ecm`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `consumer_goods_ecm`.`supply`.`plan`(`plan_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_planning_period_id` FOREIGN KEY (`planning_period_id`) REFERENCES `consumer_goods_ecm`.`supply`.`planning_period`(`planning_period_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_safety_stock_id` FOREIGN KEY (`safety_stock_id`) REFERENCES `consumer_goods_ecm`.`supply`.`safety_stock`(`safety_stock_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `consumer_goods_ecm`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_demand_plan_id` FOREIGN KEY (`demand_plan_id`) REFERENCES `consumer_goods_ecm`.`supply`.`demand_plan`(`demand_plan_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_planning_period_id` FOREIGN KEY (`planning_period_id`) REFERENCES `consumer_goods_ecm`.`supply`.`planning_period`(`planning_period_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_sku_planning_param_id` FOREIGN KEY (`sku_planning_param_id`) REFERENCES `consumer_goods_ecm`.`supply`.`sku_planning_param`(`sku_planning_param_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `consumer_goods_ecm`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ADD CONSTRAINT `fk_supply_sku_planning_param_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `consumer_goods_ecm`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`planning_period` ADD CONSTRAINT `fk_supply_planning_period_previous_planning_period_id` FOREIGN KEY (`previous_planning_period_id`) REFERENCES `consumer_goods_ecm`.`supply`.`planning_period`(`planning_period_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_lane_assignment` ADD CONSTRAINT `fk_supply_sku_lane_assignment_network_lane_id` FOREIGN KEY (`network_lane_id`) REFERENCES `consumer_goods_ecm`.`supply`.`network_lane`(`network_lane_id`);
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_lane_assignment` ADD CONSTRAINT `fk_supply_sku_lane_assignment_sku_planning_param_id` FOREIGN KEY (`sku_planning_param_id`) REFERENCES `consumer_goods_ecm`.`supply`.`sku_planning_param`(`sku_planning_param_id`);

-- ========= TAGS =========
ALTER SCHEMA `consumer_goods_ecm`.`supply` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `consumer_goods_ecm`.`supply` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` SET TAGS ('dbx_subdomain' = 'demand_planning');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `demand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan ID');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `baseline_volume_id` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `media_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `planning_period_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `sku_planning_param_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Planning Param Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `trade_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Calendar Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|locked');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `commercial_overlay_quantity` SET TAGS ('dbx_business_glossary_term' = 'Commercial Overlay Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `consensus_quantity` SET TAGS ('dbx_business_glossary_term' = 'Consensus Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `created_by_persona` SET TAGS ('dbx_business_glossary_term' = 'Created By Persona');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `created_by_persona` SET TAGS ('dbx_value_regex' = 'demand_planner|sales_manager|marketing_analyst|supply_planner|system_generated');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `demand_pattern_type` SET TAGS ('dbx_business_glossary_term' = 'Demand Pattern Type');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `demand_pattern_type` SET TAGS ('dbx_value_regex' = 'stable|seasonal|trending|intermittent|lumpy|erratic');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `demand_sensing_signal` SET TAGS ('dbx_business_glossary_term' = 'Demand Sensing Signal');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `demand_sensing_signal` SET TAGS ('dbx_value_regex' = 'increasing|stable|decreasing|volatile');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `forecast_accuracy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy Percentage');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `forecast_bias_percentage` SET TAGS ('dbx_business_glossary_term' = 'Forecast Bias Percentage');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `is_consensus_version` SET TAGS ('dbx_business_glossary_term' = 'Is Consensus Version');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_value_regex' = 'introduction|growth|maturity|decline|phase_out');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `marketing_event_uplift_quantity` SET TAGS ('dbx_business_glossary_term' = 'Marketing Event Uplift Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `npd_launch_volume_quantity` SET TAGS ('dbx_business_glossary_term' = 'New Product Development (NPD) Launch Volume Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `planner_notes` SET TAGS ('dbx_business_glossary_term' = 'Planner Notes');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `planning_bucket` SET TAGS ('dbx_business_glossary_term' = 'Planning Bucket');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `planning_bucket` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `promotional_overlay_quantity` SET TAGS ('dbx_business_glossary_term' = 'Promotional Overlay Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'supply_constraint|demand_volatility|new_product_uncertainty|promotional_risk|market_disruption|none');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Flag');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `statistical_baseline_quantity` SET TAGS ('dbx_business_glossary_term' = 'Statistical Baseline Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `variance_to_baseline_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance to Baseline Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `version_name` SET TAGS ('dbx_business_glossary_term' = 'Version Name');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `version_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Version Sequence Number');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `version_type` SET TAGS ('dbx_business_glossary_term' = 'Version Type');
ALTER TABLE `consumer_goods_ecm`.`supply`.`demand_plan` ALTER COLUMN `version_type` SET TAGS ('dbx_value_regex' = 'statistical_baseline|field_sales_overlay|marketing_adjusted|consensus|final_approved|promotional_overlay');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` SET TAGS ('dbx_subdomain' = 'supply_execution');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `demand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) Identifier');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `network_lane_id` SET TAGS ('dbx_business_glossary_term' = 'Network Lane Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `planning_period_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `product_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Product Bom Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `safety_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `sku_planning_param_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Planning Param Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `atp_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available to Promise (ATP) Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `capacity_constraint_flag` SET TAGS ('dbx_business_glossary_term' = 'Capacity Constraint Flag');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `ctp_quantity` SET TAGS ('dbx_business_glossary_term' = 'Capable to Promise (CTP) Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `demand_forecast_quantity` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Execution Date');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time in Days');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `material_constraint_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Constraint Flag');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Notes');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Status');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|approved|committed|executed|archived');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Type');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'constrained|unconstrained|scenario|simulation');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `planned_order_release_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Release Date');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `planned_production_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Production Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `planned_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Receipt Date');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `planned_replenishment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Replenishment Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `planning_bucket` SET TAGS ('dbx_business_glossary_term' = 'Planning Time Bucket');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `planning_bucket` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `planning_group` SET TAGS ('dbx_business_glossary_term' = 'Supply Planning Group');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `planning_horizon_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon End Date');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `planning_horizon_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Start Date');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `projected_inventory_balance` SET TAGS ('dbx_business_glossary_term' = 'Projected Inventory Balance');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `supply_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Supply Risk Score');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `supply_source` SET TAGS ('dbx_business_glossary_term' = 'Supply Source Type');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `supply_source` SET TAGS ('dbx_value_regex' = 'internal_production|external_procurement|transfer|contract_manufacturing');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `transportation_constraint_flag` SET TAGS ('dbx_business_glossary_term' = 'Transportation Constraint Flag');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`plan` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Version');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` SET TAGS ('dbx_subdomain' = 'supply_execution');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `safety_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `planning_period_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `sku_planning_param_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Planning Param Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Inventory Classification');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Approval Timestamp');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `approved_safety_stock_units` SET TAGS ('dbx_business_glossary_term' = 'Approved Safety Stock Quantity (Units)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `average_daily_demand_units` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Demand (Units)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `average_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Average Lead Time (Days)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `calculated_safety_stock_units` SET TAGS ('dbx_business_glossary_term' = 'Calculated Safety Stock Quantity (Units)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Calculation Method');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'statistical|days_of_supply|manual_override|service_level_based|lead_time_based|hybrid');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Calculation Timestamp');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `days_of_supply_target` SET TAGS ('dbx_business_glossary_term' = 'Days of Supply Target');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `demand_classification` SET TAGS ('dbx_business_glossary_term' = 'Demand Pattern Classification');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `demand_classification` SET TAGS ('dbx_value_regex' = 'steady|seasonal|erratic|lumpy|intermittent|obsolete');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `demand_variability_coefficient` SET TAGS ('dbx_business_glossary_term' = 'Demand Variability Coefficient');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Effective Date');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Expiration Date');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `forecast_accuracy_percent` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy Percentage');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `holding_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Inventory Holding Cost Per Unit');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `holding_cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Indicator');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `lead_time_variability_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Variability (Days)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modification Timestamp');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `order_multiple` SET TAGS ('dbx_business_glossary_term' = 'Order Multiple Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `override_notes` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Override Notes');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `override_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Override Reason Code');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `override_reason_code` SET TAGS ('dbx_value_regex' = 'promotional_event|seasonal_peak|supply_risk|new_product_launch|phase_out|quality_issue');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Review Status');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending_review|approved|rejected|under_revision|expired');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Product Shelf Life (Days)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_IBP|SAP_S4HANA|Oracle_Cloud_SCM|Blue_Yonder|TradeEdge|Manual');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `stockout_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Stockout Cost Per Unit');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `stockout_cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `supply_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Supply Risk Score');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `target_service_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Service Level Percentage');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `xyz_classification` SET TAGS ('dbx_business_glossary_term' = 'XYZ Demand Variability Classification');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `xyz_classification` SET TAGS ('dbx_value_regex' = 'X|Y|Z');
ALTER TABLE `consumer_goods_ecm`.`supply`.`safety_stock` ALTER COLUMN `z_score` SET TAGS ('dbx_business_glossary_term' = 'Z-Score (Standard Normal Deviate)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` SET TAGS ('dbx_subdomain' = 'supply_execution');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `supply_replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Replenishment Order ID');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `batch_release_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Release Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `certificate_of_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Of Analysis Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `distribution_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Shipment Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `network_lane_id` SET TAGS ('dbx_business_glossary_term' = 'Network Lane Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `primary_supply_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location ID');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `safety_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `actual_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Receipt Date');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `available_to_promise_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available to Promise (ATP) Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `drp_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Distribution Requirements Planning (DRP) Run Timestamp');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `forecast_demand_quantity` SET TAGS ('dbx_business_glossary_term' = 'Forecast Demand Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `order_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Cost Amount');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `order_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `order_notes` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Notes');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Status');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'draft|open|in_transit|received|cancelled|closed');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Type');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'planned|firmed|released');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `planned_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Receipt Date');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `planned_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Ship Date');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Priority Code');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `replenishment_order_number` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Number');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `replenishment_order_number` SET TAGS ('dbx_value_regex' = '^REP-[0-9]{10}$');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `requested_quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `safety_stock_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Trigger Flag');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `transit_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Transit Lead Time (Days)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_business_glossary_term' = 'Transportation Mode');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_value_regex' = 'truck|rail|air|ocean|intermodal');
ALTER TABLE `consumer_goods_ecm`.`supply`.`supply_replenishment_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` SET TAGS ('dbx_subdomain' = 'network_configuration');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Network Node Identifier');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `capacity_class` SET TAGS ('dbx_business_glossary_term' = 'Capacity Class');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `capacity_class` SET TAGS ('dbx_value_regex' = 'small|medium|large|extra_large|mega');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `cross_dock_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Dock Enabled Flag');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `dsd_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Enabled Flag');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `gln` SET TAGS ('dbx_business_glossary_term' = 'Global Location Number (GLN)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `gln` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified Flag');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'Node Code');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `node_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'Node Name');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `node_status` SET TAGS ('dbx_business_glossary_term' = 'Node Status');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `node_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|decommissioned|temporarily_closed');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `node_type` SET TAGS ('dbx_business_glossary_term' = 'Node Type');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|3pl_managed|co_manufacturer|contract');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `planning_group` SET TAGS ('dbx_business_glossary_term' = 'Planning Group');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `replenishment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Frequency');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `replenishment_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly|monthly|on_demand');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `safety_stock_days` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Days');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `sourcing_priority` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Priority');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `storage_capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity Units');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `storage_capacity_uom` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `storage_capacity_uom` SET TAGS ('dbx_value_regex' = 'pallets|cases|cubic_meters|square_meters');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `throughput_capacity_daily` SET TAGS ('dbx_business_glossary_term' = 'Daily Throughput Capacity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `throughput_capacity_uom` SET TAGS ('dbx_business_glossary_term' = 'Throughput Capacity Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `throughput_capacity_uom` SET TAGS ('dbx_value_regex' = 'cases_per_day|pallets_per_day|units_per_day|tons_per_day');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_node` ALTER COLUMN `vmi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Enabled Flag');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` SET TAGS ('dbx_subdomain' = 'network_configuration');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `network_lane_id` SET TAGS ('dbx_business_glossary_term' = 'Network Lane Identifier');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `freight_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `primary_supply_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location ID');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `capacity_quantity` SET TAGS ('dbx_business_glossary_term' = 'Capacity Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `capacity_uom` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `is_primary_lane` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Lane Flag');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `lane_type` SET TAGS ('dbx_business_glossary_term' = 'Lane Type');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `lane_type` SET TAGS ('dbx_value_regex' = 'production|transfer|external_procurement|direct_shipment|cross_dock|drop_ship');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `lot_size_quantity` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `network_lane_status` SET TAGS ('dbx_business_glossary_term' = 'Lane Status');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `network_lane_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|planned|decommissioned');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Lane Notes');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `otif_target_pct` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Target Percentage');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `planning_group` SET TAGS ('dbx_business_glossary_term' = 'Planning Group');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `processing_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Processing Lead Time (Days)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `safety_stock_days` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Days');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `service_level_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Service Level Target Percentage');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `sourcing_priority` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Priority');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `standard_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Lead Time (Days)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `transportation_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Transportation Lead Time (Days)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_business_glossary_term' = 'Transportation Mode');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_value_regex' = 'truck|rail|ocean|air|intermodal|parcel');
ALTER TABLE `consumer_goods_ecm`.`supply`.`network_lane` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` SET TAGS ('dbx_subdomain' = 'supply_execution');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `atp_record_id` SET TAGS ('dbx_business_glossary_term' = 'Atp Record Identifier');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `batch_release_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Release Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `event_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Event Sku Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `inventory_position_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Position Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch ID');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `planning_period_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `safety_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `atp_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Available-to-Promise (ATP) Calculation Method');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `atp_calculation_method` SET TAGS ('dbx_value_regex' = 'simple|cumulative|multi_level|product_allocation');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `atp_check_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Available-to-Promise (ATP) Check Horizon Days');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `atp_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Available-to-Promise (ATP) Confirmation Number');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `atp_date` SET TAGS ('dbx_business_glossary_term' = 'Available-to-Promise (ATP) Date');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `atp_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available-to-Promise (ATP) Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `atp_status` SET TAGS ('dbx_business_glossary_term' = 'Available-to-Promise (ATP) Status');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `atp_status` SET TAGS ('dbx_value_regex' = 'available|constrained|blocked|expired');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `backorder_quantity` SET TAGS ('dbx_business_glossary_term' = 'Backorder Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'ATP Calculation Timestamp');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `ctp_quantity` SET TAGS ('dbx_business_glossary_term' = 'Capable-to-Promise (CTP) Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `cumulative_atp_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Available-to-Promise (ATP) Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `customer_priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Customer Priority Tier');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `customer_priority_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|standard');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `demand_pegging_reference` SET TAGS ('dbx_business_glossary_term' = 'Demand Pegging Reference');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `forecast_consumption_quantity` SET TAGS ('dbx_business_glossary_term' = 'Forecast Consumption Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `intransit_quantity` SET TAGS ('dbx_business_glossary_term' = 'In-Transit Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `minimum_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Shelf Life Days');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `planned_receipt_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Receipt Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `planning_version` SET TAGS ('dbx_business_glossary_term' = 'Planning Version');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `product_allocation_group` SET TAGS ('dbx_business_glossary_term' = 'Product Allocation Group');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `production_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Production Order Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `purchase_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `supply_pegging_reference` SET TAGS ('dbx_business_glossary_term' = 'Supply Pegging Reference');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`atp_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` SET TAGS ('dbx_subdomain' = 'demand_planning');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `consensus_demand_id` SET TAGS ('dbx_business_glossary_term' = 'Consensus Demand ID');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `baseline_volume_id` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `consumer_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `planning_period_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Period ID');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `sku_planning_param_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Planning Param Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Location ID');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|revised');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `bias_indicator` SET TAGS ('dbx_business_glossary_term' = 'Forecast Bias Indicator');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `bias_indicator` SET TAGS ('dbx_value_regex' = 'over_forecast|under_forecast|neutral');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Planning Comments');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `commercial_overlay_quantity` SET TAGS ('dbx_business_glossary_term' = 'Commercial Overlay Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Forecast Confidence Level');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `consensus_quantity` SET TAGS ('dbx_business_glossary_term' = 'Consensus Demand Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `constrained_flag` SET TAGS ('dbx_business_glossary_term' = 'Constrained Demand Flag');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `constraint_reason` SET TAGS ('dbx_business_glossary_term' = 'Constraint Reason');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `customer_commitment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Customer Commitment Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `demand_category` SET TAGS ('dbx_business_glossary_term' = 'Demand Category');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `demand_category` SET TAGS ('dbx_value_regex' = 'base|promotional|seasonal|new_launch|phase_out|special_order');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `demand_driver_code` SET TAGS ('dbx_business_glossary_term' = 'Demand Driver Code');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `demand_driver_description` SET TAGS ('dbx_business_glossary_term' = 'Demand Driver Description');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `demand_volatility_index` SET TAGS ('dbx_business_glossary_term' = 'Demand Volatility Index');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `forecast_accuracy_previous_period` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy Previous Period');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `forecast_model_code` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Code');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `marketing_event_uplift_quantity` SET TAGS ('dbx_business_glossary_term' = 'Marketing Event Uplift Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `new_product_launch_quantity` SET TAGS ('dbx_business_glossary_term' = 'New Product Development (NPD) Launch Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `planning_horizon_type` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Type');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `planning_horizon_type` SET TAGS ('dbx_value_regex' = 'short_term|medium_term|long_term');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `promotion_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Flag');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `seasonality_factor` SET TAGS ('dbx_business_glossary_term' = 'Seasonality Factor');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `statistical_forecast_quantity` SET TAGS ('dbx_business_glossary_term' = 'Statistical Forecast Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `unconstrained_demand_quantity` SET TAGS ('dbx_business_glossary_term' = 'Unconstrained Demand Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `variance_to_statistical` SET TAGS ('dbx_business_glossary_term' = 'Variance to Statistical Forecast');
ALTER TABLE `consumer_goods_ecm`.`supply`.`consensus_demand` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` SET TAGS ('dbx_subdomain' = 'demand_planning');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `sku_planning_param_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Planning Parameter ID');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `approved_supplier_list_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier List Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Plant ID');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Network Node Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `backorder_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Backorder Allowed Flag');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `coverage_profile_days` SET TAGS ('dbx_business_glossary_term' = 'Coverage Profile Days');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `critical_part_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Part Flag');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `demand_pattern_type` SET TAGS ('dbx_business_glossary_term' = 'Demand Pattern Type');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `demand_pattern_type` SET TAGS ('dbx_value_regex' = 'steady|seasonal|trending|intermittent|lumpy|erratic');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `fixed_lot_size_quantity` SET TAGS ('dbx_business_glossary_term' = 'Fixed Lot Size Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `forecast_model_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Type');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `forecast_model_type` SET TAGS ('dbx_value_regex' = 'moving_average|exponential_smoothing|holt_winters|arima|machine_learning|consensus');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `goods_receipt_processing_time_days` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Processing Time Days');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `inventory_valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Inventory Valuation Method');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `inventory_valuation_method` SET TAGS ('dbx_value_regex' = 'fifo|fefo|lifo|weighted_average|standard_cost');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `lot_size_method` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Method');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `lot_size_method` SET TAGS ('dbx_value_regex' = 'fixed_lot_size|economic_order_quantity|lot_for_lot|period_order_quantity|weekly_lot_size|monthly_lot_size');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `maximum_stock_level_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `minimum_remaining_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Remaining Shelf Life Days');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `mrp_controller_code` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Controller Code');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `mrp_type` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Type');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `mrp_type` SET TAGS ('dbx_value_regex' = 'mrp|reorder_point|forecast_based|time_phased|no_planning');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `order_multiple_quantity` SET TAGS ('dbx_business_glossary_term' = 'Order Multiple Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `parameter_notes` SET TAGS ('dbx_business_glossary_term' = 'Parameter Notes');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `parameter_status` SET TAGS ('dbx_business_glossary_term' = 'Parameter Status');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `parameter_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|obsolete');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `planned_delivery_time_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Time Days');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `planning_group` SET TAGS ('dbx_business_glossary_term' = 'Integrated Business Planning (IBP) Planning Group');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `planning_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Days');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `planning_strategy` SET TAGS ('dbx_business_glossary_term' = 'Planning Strategy');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `planning_strategy` SET TAGS ('dbx_value_regex' = 'make_to_stock|make_to_order|assemble_to_order|engineer_to_order|planning_without_final_assembly');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `planning_time_fence_days` SET TAGS ('dbx_business_glossary_term' = 'Planning Time Fence Days');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'external_procurement|in_house_production|both|subcontracting');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `rounding_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Rounding Profile Code');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `safety_stock_method` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Calculation Method');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `safety_stock_method` SET TAGS ('dbx_value_regex' = 'fixed_quantity|days_of_supply|dynamic_calculation|service_level_based');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `seasonality_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Seasonality Profile Code');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `service_level_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Target Percent');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `xyz_classification` SET TAGS ('dbx_business_glossary_term' = 'XYZ Classification');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_planning_param` ALTER COLUMN `xyz_classification` SET TAGS ('dbx_value_regex' = 'X|Y|Z');
ALTER TABLE `consumer_goods_ecm`.`supply`.`planning_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`supply`.`planning_period` SET TAGS ('dbx_subdomain' = 'demand_planning');
ALTER TABLE `consumer_goods_ecm`.`supply`.`planning_period` ALTER COLUMN `planning_period_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Identifier');
ALTER TABLE `consumer_goods_ecm`.`supply`.`planning_period` ALTER COLUMN `previous_planning_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `consumer_goods_ecm`.`supply`.`planning_period` ALTER COLUMN `trade_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Calendar Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_lane_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_lane_assignment` SET TAGS ('dbx_subdomain' = 'network_configuration');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_lane_assignment` SET TAGS ('dbx_association_edges' = 'supply.network_lane,supply.sku_planning_param');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_lane_assignment` ALTER COLUMN `sku_lane_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Lane Assignment - Sku Lane Assignment Id');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_lane_assignment` ALTER COLUMN `network_lane_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Lane Assignment - Network Lane Id');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_lane_assignment` ALTER COLUMN `sku_planning_param_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Lane Assignment - Sku Planning Param Id');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_lane_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_lane_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective End Date');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_lane_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective Start Date');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_lane_assignment` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Assignment Minimum Order Quantity');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_lane_assignment` ALTER COLUMN `sourcing_priority` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Priority');
ALTER TABLE `consumer_goods_ecm`.`supply`.`sku_lane_assignment` ALTER COLUMN `standard_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Assignment Standard Lead Time');
