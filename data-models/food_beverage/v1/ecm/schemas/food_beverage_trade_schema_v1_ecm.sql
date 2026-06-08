-- Schema for Domain: trade | Business: Food Beverage | Version: v1_ecm
-- Generated on: 2026-05-05 21:26:26

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `food_beverage_ecm`.`trade` COMMENT 'Trade promotion management and optimization (TPM/TPO) including promotional planning, accruals, deductions, chargebacks, slotting fees, retailer agreement terms, category captain agreements, trade spend analytics, and promotional ROI measurement.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `food_beverage_ecm`.`trade`.`promotion_plan` (
    `promotion_plan_id` BIGINT COMMENT 'System-generated unique identifier for the promotion plan record.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand‑level promotion planning uses this FK to allocate spend and track performance per brand.',
    `employee_id` BIGINT COMMENT 'User identifier of the person who approved the promotion plan.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to trade.fund. Business justification: Promotion plans allocate financial resources from funds; linking promotion_plan to fund enables budget tracking.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Promotion planning requires linking each promotion plan to the specific price list used for its promotional pricing, enabling the Promotion Planning Report to trace pricing decisions.',
    `account_id` BIGINT COMMENT 'Identifier of the retailer account targeted by the promotion.',
    `promotion_account_id` BIGINT COMMENT 'FK to customer.account.account_id — Trade promotions target specific customer accounts. Without this FK, cannot query which promotions are planned for which retailer — core TPM functionality.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Promotion plans are created for new product launches; linking to rd_project enables ROI analysis per R&D project.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Promotion plans are often co‑funded by suppliers; the Promotion Planning process records the responsible supplier for budgeting and ROI analysis.',
    `target_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_target. Business justification: Sustainability Impact Assessment Report links each promotion plan to the ESG target it supports, enabling carbon‑reduction tracking of promotional spend.',
    `approval_status` STRING COMMENT 'Approval workflow status for the promotion plan.. Valid values are `not_submitted|submitted|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the promotion plan received final approval.',
    `baseline_volume` BIGINT COMMENT 'Projected sales volume without the promotion (historical baseline).',
    `channel` STRING COMMENT 'Primary sales channel targeted by the promotion.. Valid values are `dsd|retail|online|foodservice|direct`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the promotion plan record was created.',
    `effective_end_date` DATE COMMENT 'Planned end date when the promotion expires.',
    `effective_start_date` DATE COMMENT 'Planned start date when the promotion becomes active.',
    `estimated_roi_percent` DECIMAL(18,2) COMMENT 'Projected return on investment expressed as a percentage.',
    `forecast_created_by` STRING COMMENT 'User identifier of the analyst who created the forecast.',
    `forecast_created_timestamp` TIMESTAMP COMMENT 'Date and time when the forecast was generated.',
    `forecast_method` STRING COMMENT 'Method used to generate the promotion forecast.. Valid values are `statistical|historical|sales_rep`',
    `forecast_version` STRING COMMENT 'Identifier for the version of the forecast model or scenario.',
    `funding_source` STRING COMMENT 'Origin of the financial resources allocated to the promotion.. Valid values are `internal|manufacturer|co_op|vendor|third_party`',
    `incremental_lift_estimate` BIGINT COMMENT 'Estimated additional units sold due to the promotion.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the promotion is exclusive to the retailer (true) or shared with other retailers (false).',
    `net_revenue_impact` DECIMAL(18,2) COMMENT 'Projected net revenue change after accounting for trade spend and incremental sales.',
    `notes` STRING COMMENT 'Free‑form comments or special instructions for the promotion.',
    `promotion_code` STRING COMMENT 'External code used by trade marketing to reference the promotion plan.',
    `promotion_mechanic` STRING COMMENT 'Mechanic used to deliver the promotion (e.g., discount, rebate, free gift).. Valid values are `discount|rebate|gift|cashback|free_gift|price_reduction`',
    `promotion_name` STRING COMMENT 'Descriptive name of the promotion plan for reporting and UI display.',
    `promotion_plan_status` STRING COMMENT 'Current lifecycle state of the promotion plan.. Valid values are `draft|pending|approved|active|closed|cancelled`',
    `promotion_type` STRING COMMENT 'Category of promotional event (e.g., temporary price reduction, display, BOGO).. Valid values are `tpr|display|feature_ad|bogo|scan_back|bundle`',
    `promotional_budget_currency` STRING COMMENT 'ISO 4217 currency code for all monetary fields in the promotion plan.',
    `region` STRING COMMENT 'Geographic region or market where the promotion is executed (e.g., NA, EU).',
    `sku_ids` STRING COMMENT 'Comma‑separated list of SKU identifiers participating in the promotion.',
    `target_sales_units` BIGINT COMMENT 'Sales unit target set for the promotion period.',
    `target_sales_value` DECIMAL(18,2) COMMENT 'Monetary sales target (e.g., USD) for the promotion.',
    `total_promoted_volume` BIGINT COMMENT 'Sum of baseline and incremental lift – total units expected to be sold under the promotion.',
    `trade_spend_investment` DECIMAL(18,2) COMMENT 'Total monetary amount allocated to the promotion (discounts, rebates, fees).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the promotion plan.',
    CONSTRAINT pk_promotion_plan PRIMARY KEY(`promotion_plan_id`)
) COMMENT 'Master record for trade promotion plans created by sales/trade marketing teams. Defines the complete promotional event including promotion type (TPR, display, feature ad, BOGO, scan-back), planned start/end dates, target retailer accounts, participating SKUs, funding source, promotional mechanic, approval status, and volume/ROI forecast. Includes planning-stage forecasts: baseline volume, incremental lift estimate, total promoted volume, net revenue impact, trade spend investment, estimated ROI, forecast method (statistical model, historical analogy, sales rep input), and forecast version. Serves as the authoritative header for all downstream execution, accrual, deduction, and settlement tracking. Sourced from SAP S/4HANA SD, TPM modules, and SAP IBP demand sensing.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`trade`.`promotion_event` (
    `promotion_event_id` BIGINT COMMENT 'Unique identifier for the promotion event record.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Required for Campaign‑Promotion ROI report linking each promotion event to its originating marketing campaign.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Promotion expense must be posted to a Cost Center for budgeting and P&L reporting; finance cost_center tracks these allocations.',
    `employee_id` BIGINT COMMENT 'User identifier who created the promotion event record.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Promotion events generate price list updates; linking event to the price list allows the Promotion Execution Dashboard to associate price changes with the originating event.',
    `promotion_plan_id` BIGINT COMMENT 'Identifier of the parent promotion plan.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Promotion events execute the launch of a product defined by an R&D project; linking tracks spend per project.',
    `account_id` BIGINT COMMENT 'Identifier of the retailer account where the promotion was executed.',
    `store_cluster_id` BIGINT COMMENT 'Identifier of the store cluster (geographic grouping) for the promotion execution.',
    `actual_end_date` DATE COMMENT 'Actual end date when the promotion concluded at the retailer.',
    `actual_revenue` DECIMAL(18,2) COMMENT 'Actual revenue generated by the promotion.',
    `actual_sales_volume` STRING COMMENT 'Actual sales volume achieved during the promotion.',
    `actual_start_date` DATE COMMENT 'Actual start date when the promotion began at the retailer.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the promotion event record was approved by audit.',
    `audit_status` STRING COMMENT 'Internal audit status of the promotion event record.. Valid values are `pending|approved|rejected`',
    `channel` STRING COMMENT 'Sales channel(s) where the promotion was applied.. Valid values are `in_store|online|both`',
    `compliance_notes` STRING COMMENT 'Free-text notes regarding compliance observations.',
    `compliance_status` STRING COMMENT 'Compliance assessment result for the promotion execution.. Valid values are `compliant|non_compliant|partial|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the promotion event record was created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for monetary amounts.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `event_number` STRING COMMENT 'Business reference number for the promotion event.',
    `execution_timestamp` TIMESTAMP COMMENT 'Timestamp when the promotion event was actually executed in the field.',
    `field_verification_timestamp` TIMESTAMP COMMENT 'Timestamp of the field verification.',
    `is_field_verified` BOOLEAN COMMENT 'Indicates whether field execution was verified by a supervisor.',
    `last_modified_by` STRING COMMENT 'User identifier who last modified the promotion event record.',
    `mechanic_type` STRING COMMENT 'Type of promotional mechanic deployed for the event.. Valid values are `end_cap|circular_feature|tpr_shelf_tag|floor_graphic|in_store_demo`',
    `notes` STRING COMMENT 'Additional free-text notes about the promotion event.',
    `planned_end_date` DATE COMMENT 'Planned end date of the promotion as per the promotion plan.',
    `planned_start_date` DATE COMMENT 'Planned start date of the promotion as per the promotion plan.',
    `product_category` STRING COMMENT 'High-level product category targeted by the promotion.',
    `promotion_event_status` STRING COMMENT 'Current lifecycle status of the promotion event.. Valid values are `planned|executed|cancelled|postponed|closed`',
    `promotion_objective` STRING COMMENT 'Primary business objective of the promotion.. Valid values are `awareness|trial|sales|distribution`',
    `promotion_type` STRING COMMENT 'Category of promotion type applied.. Valid values are `price_discount|buy_one_get_one|bundle|gift_with_purchase|sampling`',
    `promotional_materials_delivered` BOOLEAN COMMENT 'Flag indicating if promotional materials were delivered to the store.',
    `promotional_materials_quantity` STRING COMMENT 'Quantity of promotional materials delivered.',
    `promotional_materials_type` STRING COMMENT 'Type of promotional materials used for the event.. Valid values are `display|shelf_tag|flyer|digital|sample`',
    `promotional_spend_discount` DECIMAL(18,2) COMMENT 'Total discount or chargeback amount applied to the promotional spend.',
    `promotional_spend_gross` DECIMAL(18,2) COMMENT 'Gross promotional spend amount before any deductions.',
    `promotional_spend_net` DECIMAL(18,2) COMMENT 'Net promotional spend after discounts and chargebacks.',
    `region_code` STRING COMMENT 'Three-letter region code (e.g., USA, CAN) for the promotion execution.. Valid values are `^[A-Z]{3}$`',
    `sku_list` STRING COMMENT 'Comma-separated list of SKUs included in the promotion.',
    `store_count_actual` STRING COMMENT 'Number of stores that actually executed the promotion.',
    `store_count_planned` STRING COMMENT 'Number of stores originally scheduled to participate in the promotion.',
    `target_revenue` DECIMAL(18,2) COMMENT 'Planned revenue target for the promotion.',
    `target_sales_volume` STRING COMMENT 'Planned sales volume target (units) for the promotion.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the promotion event record.',
    CONSTRAINT pk_promotion_event PRIMARY KEY(`promotion_event_id`)
) COMMENT 'Transactional record capturing the execution of a trade promotion event at a specific retailer account and store cluster. Tracks actual execution dates, participating store count, promotional mechanic deployed (e.g., end-cap display, circular feature, TPR shelf tag), compliance status, and field execution confirmation. Links to the parent promotion plan and captures variance between planned and actual execution. Sourced from Salesforce CRM Sales Cloud and field execution data.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`trade`.`promotion_line` (
    `promotion_line_id` BIGINT COMMENT 'Unique identifier for the promotion line item.',
    `account_id` BIGINT COMMENT 'Identifier of the retailer receiving the promotion.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand reporting requires each promotion line (SKU) to be associated with its brand for ACV and TDP calculations.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Each promotion line generates revenue/expense entries; linking to GL Account enables accurate journal posting and audit.',
    `nutrition_label_id` BIGINT COMMENT 'Foreign key linking to regulatory.nutrition_label. Business justification: Each promotional line must reference the correct nutrition label for the SKU to meet labeling regulations and marketing material compliance.',
    `price_list_line_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list_line. Business justification: Each promotion line adjusts a specific price list line; the link supports the Promotion Line‑to‑Price Traceability report used by pricing analysts.',
    `promotion_event_id` BIGINT COMMENT 'Identifier of the parent promotion plan (header).',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Promotion line records financial impact per SKU; adding SKU FK enables detailed analysis.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.customer_segment. Business justification: REQUIRED: Promotion lines are built to target specific customer segments; the segment ID is needed for segment‑based promotion planning reports.',
    `allocation_method` STRING COMMENT 'Method used to allocate promotion funding across SKUs.. Valid values are `proportional|fixed|volume_based`',
    `approval_status` STRING COMMENT 'Current approval state of the promotion line.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the promotion line was approved or rejected.',
    `baseline_volume` DECIMAL(18,2) COMMENT 'Expected sales volume without the promotion.',
    `bill_back_rate` DECIMAL(18,2) COMMENT 'Rate used for bill‑back calculations on promotional sales.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total budget allocated for the promotion line.',
    `cost_of_goods_sold_per_unit` DECIMAL(18,2) COMMENT 'COGS for the SKU used to calculate margin on promotional sales.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the promotion line record was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `USD|CAD|EUR|GBP|JPY`',
    `end_date` DATE COMMENT 'Date when the promotion ends for this line.',
    `funding_amount_per_unit` DECIMAL(18,2) COMMENT 'Funding allocated to the retailer per unit sold under the promotion.',
    `incremental_volume_target` DECIMAL(18,2) COMMENT 'Targeted additional units to be sold beyond baseline.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the promotion is exclusive to the retailer.',
    `line_number` STRING COMMENT 'Sequential order of the line within the promotion.',
    `margin_per_unit` DECIMAL(18,2) COMMENT 'Profit margin per unit after accounting for promotion funding.',
    `notes` STRING COMMENT 'Free‑form text for additional remarks or instructions.',
    `off_invoice_allowance_rate` DECIMAL(18,2) COMMENT 'Rate of off‑invoice allowance expressed as a decimal (e.g., 0.10 = 10%).',
    `planned_price` DECIMAL(18,2) COMMENT 'Planned promotional price per unit for the SKU.',
    `planned_volume_lift` DECIMAL(18,2) COMMENT 'Projected increase in units sold due to the promotion.',
    `promotion_category` STRING COMMENT 'High‑level category of the promotion strategy.. Valid values are `volume|price|mix`',
    `promotion_line_status` STRING COMMENT 'Current lifecycle status of the promotion line.. Valid values are `planned|active|completed|cancelled`',
    `promotion_type` STRING COMMENT 'Mechanism of the promotion applied to the SKU.. Valid values are `price_discount|buy_one_get_one|rebate|coupon|slotting_fee`',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of units allocated or expected for the promotion line.',
    `region_code` STRING COMMENT 'Geographic region code for the promotion line.. Valid values are `NA|EU|APAC`',
    `sales_channel` STRING COMMENT 'Channel through which the promotion is offered.. Valid values are `retail|foodservice|direct`',
    `scan_back_rate` DECIMAL(18,2) COMMENT 'Rate applied to retailer‑scanned sales for reimbursement.',
    `sku` STRING COMMENT 'SKU of the product included in the promotion line.',
    `start_date` DATE COMMENT 'Date when the promotion becomes effective for this line.',
    `target_store_type` STRING COMMENT 'Type of store (e.g., supermarket, convenience) targeted by the promotion.',
    `total_funding_amount` DECIMAL(18,2) COMMENT 'Total monetary funding for the promotion line (derived from volume and per‑unit funding).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the promotion line record.',
    CONSTRAINT pk_promotion_line PRIMARY KEY(`promotion_line_id`)
) COMMENT 'Line-item detail within a trade promotion plan representing a specific SKU or product group included in the promotion. Captures planned promotional price, off-invoice allowance rate, scan-back rate, bill-back rate, planned volume lift, baseline volume, incremental volume target, and funding amount per unit. Enables SKU-level trade spend allocation and ROI measurement. Sourced from SAP S/4HANA SD condition records and TPM line detail.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`trade`.`fund` (
    `fund_id` BIGINT COMMENT 'System-generated unique identifier for each trade fund record.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Trade fund allocation is performed per brand; this FK enables fund‑to‑brand reconciliation reports.',
    `employee_id` BIGINT COMMENT 'Internal party (e.g., trade manager) responsible for the fund.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Trade funds are allocated to specific Profit Centers for performance measurement and internal reporting.',
    `target_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_target. Business justification: Trade fund allocations are tracked against specific ESG targets for the Trade Fund ESG Allocation Report.',
    `accrued_amount` DECIMAL(18,2) COMMENT 'Amount accrued based on spend that has been recognized but not yet paid.',
    `allocation_method` STRING COMMENT 'Method used to distribute the fund across eligible promotions.. Valid values are `proportional|fixed|tiered`',
    `allocation_scope` STRING COMMENT 'Level at which the fund is allocated (e.g., retailer, sales territory, brand/category).. Valid values are `retailer|sales_territory|brand_category`',
    `approval_date` DATE COMMENT 'Date when the fund was approved by finance or trade management.',
    `classification` STRING COMMENT 'High‑level category of the fund purpose (e.g., marketing, price promotion, slotting).. Valid values are `marketing|price_promotion|slotting|display|trade`',
    `committed_amount` DECIMAL(18,2) COMMENT 'Sum of amounts already committed to promotion plans.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fund record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the fund amounts.. Valid values are `^[A-Z]{3}$`',
    `effective_from` DATE COMMENT 'Date when the fund becomes effective for spend.',
    `effective_until` DATE COMMENT 'Date when the fund expires or is no longer available (nullable for open‑ended).',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the fund belongs.',
    `fund_code` STRING COMMENT 'Business code used to reference the trade fund in external systems and contracts.',
    `fund_description` STRING COMMENT 'Free‑form description providing context or notes about the fund.',
    `fund_name` STRING COMMENT 'Descriptive name of the trade fund for reporting and analysis.',
    `fund_status` STRING COMMENT 'Current lifecycle status of the fund.. Valid values are `active|inactive|closed|pending`',
    `fund_type` STRING COMMENT 'Indicates whether the fund is a lump‑sum, accrual‑based, or fixed allowance allocation.. Valid values are `lump_sum|accrual|fixed_allowance`',
    `paid_amount` DECIMAL(18,2) COMMENT 'Total amount that has been paid out to retailers or partners.',
    `region_code` STRING COMMENT 'Three‑letter code representing the geographic region for the fund allocation.. Valid values are `^[A-Z]{3}$`',
    `remaining_balance` DECIMAL(18,2) COMMENT 'Remaining budget available for future commitments.',
    `source_system` STRING COMMENT 'Name of the source system that supplied the fund data (e.g., SAP S/4HANA, Oracle ERP).',
    `total_approved_amount` DECIMAL(18,2) COMMENT 'Total budget approved for the fund, expressed in the fund currency.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the fund record.',
    CONSTRAINT pk_fund PRIMARY KEY(`fund_id`)
) COMMENT 'Master record for trade spending funds and budgets allocated to retailer accounts, sales territories, or brand/category buckets. Tracks fund type (lump sum, accrual-based, fixed allowance), total approved budget, amount committed to promotion plans, amount accrued, amount paid, and remaining balance. Supports trade spend governance and budget control. Sourced from SAP S/4HANA CO and TPM fund management modules.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`trade`.`accrual` (
    `accrual_id` BIGINT COMMENT 'System-generated unique identifier for the accrual record.',
    `account_id` BIGINT COMMENT 'Identifier of the retailer with which the promotion is executed.',
    `promotion_event_id` BIGINT COMMENT 'Reference to the promotional agreement that generated this accrual.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Financial accruals must be tied to a specific SKU for GAAP reporting; linking ensures accurate cost allocation per product.',
    `accrual_number` STRING COMMENT 'Business identifier assigned to the accrual, used in reporting and audit trails.. Valid values are `^ACR[0-9]{8}$`',
    `accrual_status` STRING COMMENT 'Current lifecycle status of the accrual record.. Valid values are `active|reversed|closed|pending`',
    `accrual_type` STRING COMMENT 'Mechanism by which the accrual is calculated (e.g., off‑invoice, bill‑back, scan‑back, lump‑sum).. Valid values are `off_invoice|bill_back|scan_back|lump_sum`',
    `amount` DECIMAL(18,2) COMMENT 'Monetary value of the accrual liability recognized for the period.',
    `basis` STRING COMMENT 'Basis used to compute the accrual (per case, per unit, or percentage of net sales).. Valid values are `per_case|per_unit|percentage_of_net_sales`',
    `basis_quantity` DECIMAL(18,2) COMMENT 'Quantity (cases, units, etc.) used as the denominator for the accrual calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the accrual record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the accrual amount.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `effective_date` DATE COMMENT 'Date on which the accrual becomes effective for accounting purposes.',
    `expiration_date` DATE COMMENT 'Date on which the accrual liability expires or is no longer valid.',
    `gl_account` STRING COMMENT 'General Ledger account to which the accrual is posted.',
    `net_sales_amount` DECIMAL(18,2) COMMENT 'Net sales value for the period, used when the accrual basis is a percentage of net sales.',
    `period_end` DATE COMMENT 'Last calendar date of the period for which the accrual is calculated.',
    `period_start` DATE COMMENT 'First calendar date of the period for which the accrual is calculated.',
    `posting_reference` STRING COMMENT 'Reference identifier for the GL posting transaction generated from this accrual.',
    `rate` DECIMAL(18,2) COMMENT 'Rate applied to the accrual basis (e.g., $0.25 per case or 2.5% of net sales).',
    `reason` STRING COMMENT 'Free‑text description explaining the business rationale for the accrual.',
    `recognition_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the accrual was recognized in the financial system.',
    `reversal_flag` BOOLEAN COMMENT 'True if the accrual has been reversed or cancelled; otherwise False.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the accrual record.',
    CONSTRAINT pk_accrual PRIMARY KEY(`accrual_id`)
) COMMENT 'Transactional record capturing trade promotion accruals — the financial liability recognized as products are sold under a promotional agreement. Tracks accrual type (off-invoice, bill-back, scan-back, lump sum), accrual rate, accrual basis (per case, per unit, percentage of net sales), accrual period, accrued amount, reversal status, and GL posting reference. Critical for accurate P&L and COGS reporting. Sourced from SAP S/4HANA FI/CO accrual engine.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`trade`.`deduction` (
    `deduction_id` BIGINT COMMENT 'System-generated unique identifier for the trade deduction record.',
    `account_id` BIGINT COMMENT 'Unique identifier of the retail customer or distributor that submitted the deduction claim.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal user who approved the deduction.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Deduction amounts must be posted to a GL Account to reflect chargebacks and adjustments in the general ledger.',
    `invoice_id` BIGINT COMMENT 'Identifier of the invoice against which the deduction is applied.',
    `promotion_event_id` BIGINT COMMENT 'Identifier of the promotion linked to the deduction.',
    `retailer_agreement_id` BIGINT COMMENT 'Reference to the trade agreement or contract governing the deduction terms.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Chargeback deductions are calculated per SKU; FK enables traceability of deductions to the exact product for audit and rebate reconciliation.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Chargeback deductions adjust inventory; referencing the exact stock_position ensures accurate inventory accounting and audit trails.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Sum of adjustments (e.g., discounts, fees) applied to the gross amount.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the deduction was approved.',
    `audit_trail_reference` BIGINT COMMENT 'Reference to the audit log entry capturing change history for this deduction.',
    `batch_number` STRING COMMENT 'Batch identifier for the product lot involved in the deduction.',
    `chargeback_rate_percent` DECIMAL(18,2) COMMENT 'Percentage rate applied for chargeback calculations.',
    `comments` STRING COMMENT 'Additional free‑form notes captured by users.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the deduction record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the deduction amounts.',
    `deduction_category` STRING COMMENT 'High‑level category classifying the nature of the deduction.. Valid values are `price|volume|term|other`',
    `deduction_date` DATE COMMENT 'Date the deduction was recorded or became effective.',
    `deduction_description` STRING COMMENT 'Free‑text description providing additional context for the deduction.',
    `deduction_number` STRING COMMENT 'External business identifier assigned to the deduction by the retailer or distributor.',
    `deduction_status` STRING COMMENT 'Current processing status of the deduction.. Valid values are `pending|approved|rejected|settled|in_dispute`',
    `deduction_type` STRING COMMENT 'Category describing why the deduction was recorded.. Valid values are `short_payment|promo_claim|chargeback|unauthorized|other`',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the deduction is currently under dispute.',
    `dispute_reason` STRING COMMENT 'Explanation for why the deduction is disputed.',
    `expiration_date` DATE COMMENT 'Date the product lot expires, relevant for quality‑related deductions.',
    `freight_amount` DECIMAL(18,2) COMMENT 'Freight cost component related to the deduction.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Original amount claimed before any adjustments or offsets.',
    `handling_fee_amount` DECIMAL(18,2) COMMENT 'Handling fee component associated with the deduction.',
    `is_manual_entry` BOOLEAN COMMENT 'True if the deduction was entered manually rather than via automated feed.',
    `lot_number` STRING COMMENT 'Lot number used for traceability of the product.',
    `market_segment` STRING COMMENT 'Business segment of the retailer or distributor.. Valid values are `Retail|Foodservice|Direct`',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount after adjustments, representing the amount to be deducted from payment.',
    `processing_timestamp` TIMESTAMP COMMENT 'Timestamp when the deduction was processed in the downstream system.',
    `purchase_order_number` STRING COMMENT 'Purchase order reference associated with the original sale.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of product units associated with the deduction.',
    `reason_code` STRING COMMENT 'Standardized code representing the specific reason for the deduction.',
    `region_code` STRING COMMENT 'Three‑letter code of the geographic region where the deduction originated.',
    `source_system` STRING COMMENT 'Originating source system that created the deduction record.. Valid values are `SAP|Oracle|Salesforce|Other`',
    `supporting_document_number` STRING COMMENT 'Reference to external documentation (e.g., claim form) that supports the deduction.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component associated with the deduction, if applicable.',
    `tax_code` STRING COMMENT 'Code representing the tax jurisdiction or rule applied.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity field.. Valid values are `EA|KG|L|ML|CASE`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the deduction record.',
    CONSTRAINT pk_deduction PRIMARY KEY(`deduction_id`)
) COMMENT 'Transactional record for all trade-related deductions taken against invoices by retail customers and distributors — including short payments, promotional claims, chargebacks reconciling contracted vs. list price differences, and unauthorized deductions requiring resolution.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`trade`.`slotting_fee` (
    `slotting_fee_id` BIGINT COMMENT 'System-generated unique identifier for the slotting fee record.',
    `employee_id` BIGINT COMMENT 'Name of the individual who approved the slotting fee agreement.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: Slotting‑fee contracts are negotiated per store location; linking supports the Slotting Fee Allocation report by node.',
    `packaging_profile_id` BIGINT COMMENT 'Foreign key linking to sustainability.packaging_profile. Business justification: Slotting fees depend on packaging type; linking enables the Slotting Fee Packaging Sustainability Cost Analysis.',
    `account_id` BIGINT COMMENT 'Unique identifier of the retailer receiving the slotting fee.',
    `retailer_agreement_id` BIGINT COMMENT 'Foreign key linking to trade.retailer_agreement. Business justification: Slotting fees are negotiated per retailer agreement; linking slotting_fee to retailer_agreement captures this hierarchy.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Slotting fee contracts specify shelf placement; linking to storage_location enables tracking fees per shelf for compliance and accounting.',
    `accrual_flag` BOOLEAN COMMENT 'Indicates whether the fee is accrued over the contract period.',
    `agreement_number` STRING COMMENT 'External contract number assigned by the retailer for the slotting fee agreement.',
    `approval_date` DATE COMMENT 'Date on which the slotting fee agreement was approved.',
    `compliance_flag` BOOLEAN COMMENT 'True if the slotting fee arrangement complies with FDA/USDA/GFSI regulations.',
    `contract_end_date` DATE COMMENT 'Effective end date of the slotting fee agreement; null if open‑ended.',
    `contract_start_date` DATE COMMENT 'Effective start date of the slotting fee agreement.',
    `contract_term_months` STRING COMMENT 'Duration of the agreement expressed in months.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the slotting fee record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the fee amounts (e.g., USD, EUR).',
    `fee_description` STRING COMMENT 'Free‑form description of the slotting fee purpose and terms.',
    `fee_per_store` DECIMAL(18,2) COMMENT 'Monetary amount charged for each store covered by the agreement.',
    `fee_status` STRING COMMENT 'Current lifecycle status of the slotting fee.. Valid values are `pending|approved|paid|cancelled`',
    `fee_tax_amount` DECIMAL(18,2) COMMENT 'Tax amount calculated on the slotting fee, if taxable.',
    `fee_taxable_flag` BOOLEAN COMMENT 'Indicates whether the slotting fee is subject to tax.',
    `fee_type` STRING COMMENT 'Classification of the slotting fee (e.g., new item introduction, reset, promotional).. Valid values are `new_item|reset|promotion|replenishment`',
    `invoice_number` STRING COMMENT 'Identifier of the invoice generated for the slotting fee payment.',
    `last_modified_by` STRING COMMENT 'System user who last updated the slotting fee record.',
    `net_fee_amount` DECIMAL(18,2) COMMENT 'Fee amount after tax and any discounts (total_fee_commitment – fee_tax_amount).',
    `notes` STRING COMMENT 'Additional free‑text comments or special conditions.',
    `payment_due_date` DATE COMMENT 'Date by which the slotting fee payment must be received.',
    `payment_method` STRING COMMENT 'Method used to remit the slotting fee payment.. Valid values are `check|wire|eft|credit`',
    `payment_schedule` STRING COMMENT 'Frequency or trigger for fee payments.. Valid values are `monthly|quarterly|annually|upon_invoice`',
    `payment_status` STRING COMMENT 'Current payment status of the slotting fee.. Valid values are `unpaid|partial|paid`',
    `shelf_facing_count` STRING COMMENT 'Number of product facings allocated on the shelf as part of the agreement.',
    `shelf_position` STRING COMMENT 'Preferred vertical position on the shelf for the product.. Valid values are `eye_level|top|bottom|mid_shelf`',
    `sku_list` STRING COMMENT 'Comma‑separated list of SKUs included in the slotting fee arrangement.',
    `slotting_fee_category` STRING COMMENT 'Primary product category for which the slotting fee applies (e.g., Beverages, Snacks).',
    `store_count` STRING COMMENT 'Number of retailer locations covered by the slotting fee agreement.',
    `total_fee_commitment` DECIMAL(18,2) COMMENT 'Total monetary commitment for the entire contract period (fee_per_store × store_count).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the slotting fee record.',
    `created_by` STRING COMMENT 'System user who created the slotting fee record.',
    CONSTRAINT pk_slotting_fee PRIMARY KEY(`slotting_fee_id`)
) COMMENT 'Master and transactional record for slotting fees paid to retailers for shelf space allocation, new item placement, or reset participation. Captures retailer account, store count, category, SKU list, fee amount per store, total fee commitment, payment schedule, shelf placement terms (number of facings, shelf position), and contract period. Tracks slotting fee spend as a component of total trade investment. Sourced from SAP S/4HANA SD and retailer agreement documentation.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` (
    `retailer_agreement_id` BIGINT COMMENT 'System-generated unique identifier for the retailer agreement record.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: REQUIRED: Retailer agreements must record the primary retailer contact for contract execution and compliance; linking to contact provides the needed reference.',
    `employee_id` BIGINT COMMENT 'Name of the individual who approved the agreement.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_initiative. Business justification: Retailer agreements often contain sustainability commitments; linking allows the Retailer Sustainability Commitment Dashboard to monitor compliance.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: Retailer agreements are scoped to geographic price zones; the link enables the Agreement‑Zone Compliance report required by regional pricing governance.',
    `account_id` BIGINT COMMENT 'FK to customer.account',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Retailer agreements for new product introductions are tied to the originating R&D project for compliance and performance monitoring.',
    `retailer_account_id` BIGINT COMMENT 'Unique identifier of the retailer party associated with this agreement.',
    `agreement_name` STRING COMMENT 'Descriptive name of the retailer agreement for easy reference.',
    `agreement_number` STRING COMMENT 'External business identifier assigned to the agreement (e.g., contract number).',
    `agreement_type` STRING COMMENT 'Category of the agreement defining the primary commercial mechanism.. Valid values are `volume_rebate|promotional_funding|edlp|display_compliance|scan_back|co_op_advertising`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the agreement was approved.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'Monetary bonus awarded for exceeding performance thresholds.',
    `bonus_clause` STRING COMMENT 'Text describing bonuses for exceeding performance thresholds.',
    `category_scope` STRING COMMENT 'List of product categories covered by the agreement (comma‑separated).',
    `co_op_advertising_allowance` DECIMAL(18,2) COMMENT 'Monetary allowance for cooperative advertising activities.',
    `compliance_measure_method` STRING COMMENT 'Method used to verify retailer compliance with agreement terms.. Valid values are `sales_data|scan_back|audit|third_party|self_report|system`',
    `creation_timestamp` TIMESTAMP COMMENT 'Timestamp when the agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for monetary fields.. Valid values are `USD|EUR|CAD|GBP|JPY|AUD`',
    `display_compliance_requirement` STRING COMMENT 'Specification of shelf‑display or facings required for the retailer.',
    `edlp_price_commitment` DECIMAL(18,2) COMMENT 'Committed price for Everyday Low Price (EDLP) items.',
    `edlp_price_uom` STRING COMMENT 'Unit of measure for the EDLP price commitment.. Valid values are `per_unit|per_case|per_liter`',
    `effective_end_date` DATE COMMENT 'Date the agreement expires or is terminated (nullable for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date the agreement becomes binding.',
    `funding_commitment_amount` DECIMAL(18,2) COMMENT 'Monetary amount the retailer commits to fund promotional activities.',
    `is_exclusive_agreement` BOOLEAN COMMENT 'Indicates whether the retailer is prohibited from similar agreements with competitors.',
    `is_multi_year` BOOLEAN COMMENT 'True if the agreement spans multiple fiscal years.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the agreement record.',
    `mdf_allocation_amount` DECIMAL(18,2) COMMENT 'Allocated amount for Marketing Development Funds (MDF).',
    `notes` STRING COMMENT 'Free‑form text for additional comments or special conditions.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty applied when performance thresholds are not met.',
    `penalty_clause` STRING COMMENT 'Text describing penalties for non‑performance.',
    `performance_measure_period` STRING COMMENT 'Frequency at which performance is evaluated.. Valid values are `monthly|quarterly|annually`',
    `performance_threshold` DECIMAL(18,2) COMMENT 'Minimum performance metric (e.g., sales %) required to avoid penalties.',
    `promotional_event_count` STRING COMMENT 'Number of promotional events scheduled under the agreement.',
    `rebate_tier_structure` STRING COMMENT 'JSON‑encoded definition of volume rebate tiers and rates.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes an automatic renewal option.',
    `retailer_agreement_status` STRING COMMENT 'Current lifecycle status of the agreement.. Valid values are `draft|active|suspended|terminated|expired|pending`',
    `scan_back_rate` DECIMAL(18,2) COMMENT 'Percentage of sales that must be reported back via scan‑back.',
    `scan_back_uom` STRING COMMENT 'Unit of measure for the scan‑back rate.. Valid values are `percent|per_unit`',
    `sku_scope` STRING COMMENT 'List of specific SKUs covered by the agreement (comma‑separated).',
    `termination_notice_period_days` STRING COMMENT 'Number of days required to give notice before terminating the agreement.',
    `total_funding_amount` DECIMAL(18,2) COMMENT 'Aggregate monetary amount committed for promotional funding under the agreement.',
    `volume_target` DECIMAL(18,2) COMMENT 'Committed sales volume target for the retailer (e.g., cases, units).',
    `volume_target_uom` STRING COMMENT 'Unit of measure for the volume target.. Valid values are `cases|units|kg|liters|pallets`',
    CONSTRAINT pk_retailer_agreement PRIMARY KEY(`retailer_agreement_id`)
) COMMENT 'Master record for formal trade agreements with retail customers including annual joint business plans (JBPs), volume rebate agreements, promotional calendars, EDLP pricing commitments, and category captain agreements. Captures agreement type, effective dates, retailer account, committed volume targets, promotional event count, funding commitments, performance thresholds, and penalty/bonus clauses. Contains granular line-item terms as child records: each term specifies type (volume rebate tier, promotional funding rate, EDLP price commitment, display compliance requirement, scan-back rate, co-op advertising allowance, MDF allocation), applicable SKU or category scope, threshold conditions, rate or amount, measurement period, and compliance measurement method. Supports multi-term agreement governance, compliance monitoring, and earned income calculation. SSOT for all retailer commercial terms. Sourced from Salesforce CRM and SAP S/4HANA SD contracts.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`trade`.`agreement_term` (
    `agreement_term_id` BIGINT COMMENT 'System-generated unique identifier for the agreement term record.',
    `account_id` BIGINT COMMENT 'Identifier of the retailer party associated with the agreement.',
    `category_strategy_id` BIGINT COMMENT 'Identifier of the product category scope for the term (if not SKU‑specific).',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Agreement terms (e.g., slotting fees, rebates) are negotiated per product launch; linking to rd_project aligns terms with the correct project.',
    `retailer_agreement_id` BIGINT COMMENT 'Identifier of the retailer agreement to which this term belongs.',
    `sku_id` BIGINT COMMENT 'Identifier of the specific SKU to which the term applies (if scoped to a single product).',
    `accrual_method` STRING COMMENT 'Method used to accrue the terms financial impact.. Valid values are `post_invoice|prepay|on_sale`',
    `agreement_term_status` STRING COMMENT 'Current lifecycle status of the term.. Valid values are `active|inactive|pending|expired`',
    `chargeback_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied for chargeback calculations.',
    `chargeback_type` STRING COMMENT 'Type of chargeback (e.g., scan‑back, sell‑through).. Valid values are `scan_back|sell_through`',
    `compliance_actual` DECIMAL(18,2) COMMENT 'Actual measured value for the compliance metric.',
    `compliance_metric` STRING COMMENT 'Metric used to assess compliance (e.g., display facing count).',
    `compliance_required` BOOLEAN COMMENT 'Indicates whether compliance monitoring is required for this term.',
    `compliance_target` DECIMAL(18,2) COMMENT 'Target value for the compliance metric.',
    `contract_term_code` BIGINT COMMENT 'Identifier linking this term to a higher‑level contract term grouping, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the agreement term record was first created.',
    `edlp_price` DECIMAL(18,2) COMMENT 'Committed Everyday Low Price for the SKU or category.',
    `edlp_price_currency` STRING COMMENT 'Currency of the EDLP price.. Valid values are `USD|CAD|EUR|GBP|JPY`',
    `effective_from` DATE COMMENT 'Date when the term becomes binding.',
    `effective_until` DATE COMMENT 'Date when the term expires or is superseded (null for open‑ended).',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the term grants exclusive rights or conditions.',
    `measurement_period` STRING COMMENT 'Reporting period over which the term is measured.. Valid values are `weekly|monthly|quarterly|yearly`',
    `notes` STRING COMMENT 'Additional free‑form comments or remarks about the term.',
    `promotional_funding_rate` DECIMAL(18,2) COMMENT 'Rate (percentage) of promotional funding provided to the retailer.',
    `promotional_funding_type` STRING COMMENT 'Indicates whether the funding is a percentage of sales or a fixed amount.. Valid values are `percentage|fixed`',
    `rate_amount` DECIMAL(18,2) COMMENT 'Monetary amount or rate associated with the term (e.g., rebate per unit, funding amount).',
    `rate_currency` STRING COMMENT 'Three‑letter ISO currency code for the rate amount.. Valid values are `USD|CAD|EUR|GBP|JPY`',
    `region_code` STRING COMMENT 'Three‑letter ISO country code representing the geographic region of the agreement.. Valid values are `USA|CAN|MEX|GBR|FRA|DEU`',
    `slotting_fee_amount` DECIMAL(18,2) COMMENT 'Monetary amount charged for slotting the product.',
    `slotting_fee_currency` STRING COMMENT 'Currency of the slotting fee.. Valid values are `USD|CAD|EUR|GBP|JPY`',
    `term_description` STRING COMMENT 'Free‑text description providing details of the term.',
    `term_type` STRING COMMENT 'Category of the commercial term (e.g., volume rebate, promotional funding, EDLP price commitment).. Valid values are `volume_rebate|promotional_funding|edlp_price_commitment|display_compliance|scan_back|co_op_advertising`',
    `threshold_quantity` DECIMAL(18,2) COMMENT 'Quantity threshold that triggers the term (e.g., units sold for a rebate tier).',
    `threshold_unit` STRING COMMENT 'Unit of measure for the threshold quantity.. Valid values are `units|cases|kg|liters`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the agreement term record.',
    CONSTRAINT pk_agreement_term PRIMARY KEY(`agreement_term_id`)
) COMMENT 'Line-item detail of specific commercial terms within a retailer agreement. Each record captures a single term type (volume rebate tier, promotional funding rate, EDLP price commitment, display compliance requirement, scan-back rate, co-op advertising allowance), the applicable SKU or category scope, threshold conditions, rate or amount, and measurement period. Enables granular tracking of multi-term retailer agreements and compliance monitoring.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`trade`.`volume_rebate` (
    `volume_rebate_id` BIGINT COMMENT 'Unique identifier for the volume rebate record.',
    `account_id` BIGINT COMMENT 'Identifier of the retail customer receiving the rebate.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved the rebate.',
    `retailer_agreement_id` BIGINT COMMENT 'Foreign key linking to trade.retailer_agreement. Business justification: Volume rebates are earned under specific retailer agreements; linking volume_rebate to retailer_agreement records this relationship.',
    `sales_contract_id` BIGINT COMMENT 'Identifier of the underlying rebate agreement contract.',
    `accrual_flag` BOOLEAN COMMENT 'Indicates whether the rebate has been accrued in financial statements.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the rebate was approved.',
    `batch_reference` STRING COMMENT 'Identifier of the data load or processing batch.',
    `contract_number` STRING COMMENT 'External reference number of the rebate agreement.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the rebate amount.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the rebate is exclusive to the customer.',
    `measurement_period_end` DATE COMMENT 'End date of the volume measurement period for the rebate.',
    `measurement_period_start` DATE COMMENT 'Start date of the volume measurement period for the rebate.',
    `net_rebate_amount` DECIMAL(18,2) COMMENT 'Rebate amount after tax adjustments.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the rebate.',
    `party_name` STRING COMMENT 'Name of the retail customer or account holder.',
    `payment_method` STRING COMMENT 'Method used to settle the rebate with the customer.. Valid values are `credit_memo|check|off_invoice`',
    `product_category` STRING COMMENT 'Product category covered by the rebate program.',
    `purchase_volume` DECIMAL(18,2) COMMENT 'Total volume of product purchased by the customer during the measurement period.',
    `rebate_amount` DECIMAL(18,2) COMMENT 'Monetary amount earned from the rebate before tax.',
    `rebate_calculation_timestamp` TIMESTAMP COMMENT 'Timestamp when the rebate calculation was performed.',
    `rebate_program_code` STRING COMMENT 'Code identifying the rebate program as defined in the retailer agreement.',
    `rebate_program_name` STRING COMMENT 'Descriptive name of the rebate program.',
    `rebate_rate` DECIMAL(18,2) COMMENT 'Rebate rate applied to the qualified volume (e.g., $ per case or percentage).',
    `rebate_type` STRING COMMENT 'Classification of the rebate (e.g., volume‑based, growth‑based, mix‑based).. Valid values are `volume|growth|mix`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the rebate record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rebate record.',
    `region_code` STRING COMMENT 'Three‑letter code representing the geographic region applicable to the rebate.',
    `settlement_date` DATE COMMENT 'Date on which the rebate was settled.',
    `settlement_status` STRING COMMENT 'Current status of the rebate settlement process.. Valid values are `pending|settled|rejected|in_process`',
    `source_system` STRING COMMENT 'System of record that originated the rebate data (e.g., SAP S/4HANA).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component associated with the rebate amount.',
    `tax_included_flag` BOOLEAN COMMENT 'Specifies if tax is included in the rebate amount.',
    `threshold_volume` DECIMAL(18,2) COMMENT 'Purchase volume required to qualify for the tier.',
    `tier_level` STRING COMMENT 'Rebate tier achieved based on purchase volume.. Valid values are `Tier1|Tier2|Tier3|Tier4`',
    `volume_rebate_status` STRING COMMENT 'Lifecycle status of the rebate record.. Valid values are `draft|active|closed|cancelled`',
    `volume_uom` STRING COMMENT 'Unit of measure for the purchase volume (e.g., cases, liters).. Valid values are `cases|liters|kg|gallons`',
    `created_by` STRING COMMENT 'User identifier who initially created the rebate record.',
    CONSTRAINT pk_volume_rebate PRIMARY KEY(`volume_rebate_id`)
) COMMENT 'Transactional record for volume-based rebates earned by retail customers upon achieving purchase volume thresholds defined in retailer agreements. Captures rebate program reference, measurement period, actual volume purchased, threshold tier achieved, rebate rate, earned rebate amount, payment method (credit memo, check, off-invoice), and settlement status. Supports accurate rebate liability accrual and settlement. Sourced from SAP S/4HANA SD rebate processing.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`trade`.`category_captain` (
    `category_captain_id` BIGINT COMMENT 'System-generated unique identifier for the category captain agreement record.',
    `account_id` BIGINT COMMENT 'Unique identifier of the retailer partner stored in Salesforce CRM.',
    `promotion_plan_id` BIGINT COMMENT 'Foreign key linking to trade.promotion_plan. Business justification: Category captain agreements are scoped to a promotion plan; linking provides parent context.',
    `agreement_number` STRING COMMENT 'External reference number assigned to the category captain agreement by the business.',
    `agreement_type` STRING COMMENT 'Classification of the agreement; indicates whether Food Beverage acts as a category captain or advisor.. Valid values are `category_captain|category_advisor`',
    `agreement_version` STRING COMMENT 'Version identifier for the agreement document, incremented on each amendment.',
    `approval_status` STRING COMMENT 'Current approval state of the agreement within internal governance.. Valid values are `pending|approved|rejected`',
    `assortment_authority` STRING COMMENT 'Degree of authority to recommend product assortment within the category.. Valid values are `exclusive|shared|none`',
    `audit_trail` STRING COMMENT 'Compact log of key audit events (creation, approval, amendment) for the agreement.',
    `category_captain_status` STRING COMMENT 'Current state of the agreement in its lifecycle.. Valid values are `draft|active|suspended|terminated|expired`',
    `category_scope` STRING COMMENT 'Comma‑separated list of product categories covered by the agreement (e.g., snacks, beverages).',
    `competitive_exclusion_terms` STRING COMMENT 'Textual description of competitor products that must be excluded from the assortment.',
    `competitive_inclusion_terms` STRING COMMENT 'Textual description of competitor products that may be included in the assortment.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the agreement meets all applicable FDA/USDA/GFSI regulatory requirements.',
    `contract_document_url` STRING COMMENT 'Link to the stored contract document in the document management system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the agreement record was first created in the lakehouse.',
    `effective_from` DATE COMMENT 'Date on which the agreement becomes binding.',
    `effective_until` DATE COMMENT 'Date on which the agreement expires; null for open‑ended agreements.',
    `kpi_acv_target` DECIMAL(18,2) COMMENT 'Monetary target for All Commodity Volume generated by the category.',
    `kpi_category_growth_target` DECIMAL(18,2) COMMENT 'Desired percentage growth in category sales over the agreement period.',
    `kpi_tdp_target` STRING COMMENT 'Target value for Total Distribution Points to be achieved under the agreement.',
    `notes` STRING COMMENT 'Additional comments or observations related to the agreement.',
    `planogram_ownership` STRING COMMENT 'Level of control Food Beverage has over planogram design for the retailer.. Valid values are `full|partial|none`',
    `review_cycle_months` STRING COMMENT 'Number of months between formal agreement performance reviews.',
    `shelf_space_target_pct` DECIMAL(18,2) COMMENT 'Target percentage of shelf space to be allocated to Food Beverage products.',
    `signed_date` DATE COMMENT 'Date on which the agreement was formally signed by both parties.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the agreement record.',
    CONSTRAINT pk_category_captain PRIMARY KEY(`category_captain_id`)
) COMMENT 'Master record for category captain agreements where Food Beverage serves as the designated category advisor for a retailer. Captures retailer account, category scope, agreement effective dates, planogram ownership rights, assortment recommendation authority, shelf space allocation targets, review cycle frequency, performance KPIs (TDP, ACV, category growth targets), and competitive product inclusion/exclusion terms. Sourced from Salesforce CRM and category management documentation.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`trade`.`settlement` (
    `settlement_id` BIGINT COMMENT 'Primary key for settlement',
    `account_id` BIGINT COMMENT 'Unique identifier of the retailer receiving the settlement.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Spend settlements are charged to Cost Centers for expense tracking and variance analysis.',
    `gl_account_id` BIGINT COMMENT 'FK to finance.gl_account',
    `profit_center_id` BIGINT COMMENT 'FK to finance.profit_center',
    `promotion_claim_id` BIGINT COMMENT 'Foreign key linking to trade.promotion_claim. Business justification: Settlements finalize payments for approved promotion claims; required for the Promotion Claim Settlement reconciliation process.',
    `accounting_date` DATE COMMENT 'Date on which the settlement is recorded in the general ledger.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Sum of all adjustments (taxes, fees, discounts) applied to the gross amount.',
    `approval_status` STRING COMMENT 'Current approval state of the settlement request.. Valid values are `approved|rejected|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the settlement amount.. Valid values are `^[A-Z]{3}$`',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before any adjustments, taxes, or deductions.',
    `is_manual_settlement` BOOLEAN COMMENT 'True if the settlement was processed manually; otherwise False.',
    `is_tax_included` BOOLEAN COMMENT 'Indicates whether tax is included in the net settlement amount.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount payable after adjustments; the amount actually settled.',
    `original_claim_amount` DECIMAL(18,2) COMMENT 'Amount originally claimed by the retailer before settlement.',
    `payment_reference` STRING COMMENT 'Reference number from the payment instrument (e.g., check number, wire transfer ID).',
    `period` STRING COMMENT 'Fiscal period (e.g., 2023Q4) to which the settlement belongs.',
    `posted_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement entry was posted to the accounting system.',
    `reconciliation_status` STRING COMMENT 'Indicates whether the settlement has been reconciled with the claim.. Valid values are `reconciled|unreconciled|exception`',
    `settlement_description` STRING COMMENT 'Free‑text description providing context or notes about the settlement.',
    `settlement_method` STRING COMMENT 'Method used to deliver the settlement funds.. Valid values are `bank_transfer|check|wire|electronic|cash`',
    `settlement_number` STRING COMMENT 'External settlement reference number assigned by finance for tracking.',
    `settlement_status` STRING COMMENT 'Current workflow state of the settlement.. Valid values are `pending|approved|rejected|paid|closed`',
    `settlement_timestamp` TIMESTAMP COMMENT 'Date and time when the settlement was executed.',
    `settlement_type` STRING COMMENT 'Category of settlement transaction indicating the payment mechanism.. Valid values are `credit_memo|check|off_invoice|wire_transfer|adjustment|rebate`',
    `source_system` STRING COMMENT 'Originating ERP or financial system that generated the settlement record.. Valid values are `SAP|Oracle|Other`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component of the settlement, if applicable.',
    `tax_code` STRING COMMENT 'Accounting tax code used for the settlement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the settlement record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between original claim amount and net settlement amount.',
    CONSTRAINT pk_settlement PRIMARY KEY(`settlement_id`)
) COMMENT 'Transactional record for the financial settlement of trade promotion claims and deduction resolutions — the actual payment or credit issued to close a validated promotional claim, resolve a retailer deduction, or pay a volume rebate. Captures settlement type (credit memo, check, off-invoice deduction, wire transfer), settlement amount, original claim/deduction amount, variance, settlement date, payment reference, GL account, cost center, profit center, reconciliation status, and approval workflow state. Bridges trade promotion execution and accounts receivable/payable. Enables trade spend close-out reporting and period-end reconciliation. Sourced from SAP S/4HANA FI.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`trade`.`promotion_claim` (
    `promotion_claim_id` BIGINT COMMENT 'Unique system-generated identifier for the promotion claim record.',
    `account_id` BIGINT COMMENT 'Identifier of the retailer submitting the promotional claim.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Promotion claim validation requires confirming the claimed SKU is registered; linking claim to product_registration enables compliance checks and audit reporting.',
    `promotion_event_id` BIGINT COMMENT 'Identifier of the trade promotion to which this claim relates.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Promotion claim validation requires matching claimed sales to the specific inventory stock position from which the product was sold.',
    `approved_amount` DECIMAL(18,2) COMMENT 'Monetary amount approved for reimbursement after validation.',
    `claim_adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary adjustment applied to the claim (e.g., penalties or bonuses).',
    `claim_adjustment_reason` STRING COMMENT 'Reason for any monetary adjustment to the claim.',
    `claim_date` DATE COMMENT 'Business event date representing the day the claim was generated.',
    `claim_line_item_description` STRING COMMENT 'Free‑text description of the promotional activity or SKU(s) covered by the claim.',
    `claim_number` STRING COMMENT 'External claim reference number assigned by the retailer or trading partner.',
    `claim_original_amount` DECIMAL(18,2) COMMENT 'Original monetary amount before any adjustments.',
    `claim_period_end` DATE COMMENT 'Last day of the period for which the promotion claim is submitted.',
    `claim_period_start` DATE COMMENT 'First day of the period for which the promotion claim is submitted.',
    `claim_processing_status` STRING COMMENT 'Current status of claim processing in the back‑office system.. Valid values are `in_queue|processing|completed`',
    `claim_source_system` STRING COMMENT 'System of origin for the claim data (e.g., SAP S/4HANA, EDI, third‑party portal).',
    `claim_submission_timestamp` TIMESTAMP COMMENT 'Date‑time when the claim was received in the system.',
    `claim_type` STRING COMMENT 'Method used for the claim: scan data, bill‑back, or off‑invoice reconciliation.. Valid values are `scan|bill_back|off_invoice`',
    `claimed_amount` DECIMAL(18,2) COMMENT 'Monetary value of the claim before any adjustments.',
    `claimed_volume` DECIMAL(18,2) COMMENT 'Quantity of product units (e.g., liters, cases) claimed for reimbursement.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the claim is under dispute.',
    `lifecycle_status` STRING COMMENT 'Current workflow state of the claim.. Valid values are `draft|submitted|approved|rejected|disputed|closed`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the claim record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the claim record.',
    `rejection_reason` STRING COMMENT 'Explanation why a claim was rejected, if applicable.',
    `supporting_document_ref` STRING COMMENT 'Reference (e.g., file name or URL) to documentation that validates the claim.',
    `validation_status` STRING COMMENT 'Result of automated or manual validation of the claim.. Valid values are `pending|passed|failed`',
    CONSTRAINT pk_promotion_claim PRIMARY KEY(`promotion_claim_id`)
) COMMENT 'Transactional record for retailer-submitted promotional claims requesting reimbursement for executed trade promotions. Captures claim type (scan data, bill-back, off-invoice reconciliation), retailer account, promotion reference, claim period, claimed volume, claimed amount, supporting documentation reference, validation status, approved amount, rejection reason, and dispute flag. Central to the trade deduction management and claim validation workflow. Sourced from SAP S/4HANA SD and EDI claim transactions.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`trade`.`spend_budget` (
    `spend_budget_id` BIGINT COMMENT 'Primary key for spend_budget',
    `employee_id` BIGINT COMMENT 'Identifier of the internal owner (e.g., brand manager) responsible for the budget.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Budget amounts are tied to GL Accounts to enable budget vs. actual comparisons in financial reporting.',
    `ibp_scenario_id` BIGINT COMMENT 'Foreign key linking to supply.ibp_scenario. Business justification: Trade‑spend budgets are aligned to IBP scenarios; linking enables the Budget‑to‑Scenario allocation dashboard.',
    `promotion_plan_id` BIGINT COMMENT 'Foreign key linking to trade.promotion_plan. Business justification: Spend budgets are created for specific promotion plans; linking enables aggregation of budget data.',
    `accrued_amount` DECIMAL(18,2) COMMENT 'Amount accrued from executed promotions but not yet paid.',
    `allocation_method` STRING COMMENT 'Method used to allocate the budget across sub‑periods or promotion types.. Valid values are `percentage|fixed|manual`',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the total budget allocated when the allocation method is percentage‑based.',
    `approval_status` STRING COMMENT 'Current approval workflow state of the budget.. Valid values are `pending|approved|rejected`',
    `brand` STRING COMMENT 'Brand to which the budget applies.',
    `budget_code` STRING COMMENT 'External business code or number used to reference the budget in financial and trade systems.',
    `budget_name` STRING COMMENT 'Human‑readable name describing the purpose or scope of the budget.',
    `budget_period` STRING COMMENT 'Planning period for the budget (full fiscal year or specific quarter).. Valid values are `FY|Q1|Q2|Q3|Q4`',
    `budget_type` STRING COMMENT 'Classification of the budget by its planning horizon or promotional focus.. Valid values are `annual|quarterly|promo|slotting|co_op|other`',
    `channel` STRING COMMENT 'Sales channel covered by the budget (e.g., Retail, Foodservice, Direct‑to‑Consumer).',
    `co_op_budget_amount` DECIMAL(18,2) COMMENT 'Allocated budget for manufacturer‑retailer co‑operative advertising spend.',
    `committed_amount` DECIMAL(18,2) COMMENT 'Portion of the budget that has been formally committed to approved promotions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the budget record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts in the budget.. Valid values are `USD|EUR|GBP|CAD|JPY|AUD`',
    `customer_tier` STRING COMMENT 'Retailer or customer tier classification (e.g., Tier 1, Tier 2).',
    `display_budget_amount` DECIMAL(18,2) COMMENT 'Allocated budget for in‑store display promotional spend.',
    `end_date` DATE COMMENT 'Date on which the budget expires or is no longer valid; null for open‑ended budgets.',
    `feature_budget_amount` DECIMAL(18,2) COMMENT 'Allocated budget for feature (end‑cap) promotional spend.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the budget belongs.',
    `fund_type` STRING COMMENT 'Mechanism by which the budget is managed and disbursed.. Valid values are `lump_sum|accrual|fixed_allowance`',
    `last_revision_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent change to the budget record.',
    `notes` STRING COMMENT 'Supplementary remarks or comments from budget owners or approvers.',
    `paid_amount` DECIMAL(18,2) COMMENT 'Total amount already paid out against the budget.',
    `remaining_balance` DECIMAL(18,2) COMMENT 'Funds still available for future promotional spend.',
    `slotting_budget_amount` DECIMAL(18,2) COMMENT 'Allocated budget for slotting fee or shelf‑space purchase spend.',
    `spend_budget_category` STRING COMMENT 'Product category scope of the budget (e.g., Snacks, Beverages).',
    `spend_budget_description` STRING COMMENT 'Free‑form text describing the purpose, constraints, or notes for the budget.',
    `spend_budget_status` STRING COMMENT 'Current lifecycle state of the budget record.. Valid values are `draft|approved|active|closed|revised`',
    `start_date` DATE COMMENT 'Date on which the budget becomes effective for spend planning.',
    `total_approved_amount` DECIMAL(18,2) COMMENT 'Sum of all approved funds for the budget across all promotion types.',
    `tpr_budget_amount` DECIMAL(18,2) COMMENT 'Allocated budget for temporary price reduction promotions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to any field in the budget record.',
    CONSTRAINT pk_spend_budget PRIMARY KEY(`spend_budget_id`)
) COMMENT 'Master record for all trade spending funds and budgets — the single source of truth for financial governance of trade investments. Encompasses annual brand/category/channel budgets, retailer account fund allocations, territory-level funds, and promotion-type-specific pools. Captures budget period, scope (brand, category, channel, customer tier), total approved budget, budget by promotion type (TPR, display, feature, slotting, co-op), phasing by period, fund type (lump sum, accrual-based, fixed allowance), committed amount, accrued amount, paid amount, remaining balance, budget owner, approval status, and last revision date. Supports real-time trade spend governance, promotion plan approval guardrails, and budget vs actual variance reporting. Sourced from SAP S/4HANA CO, TPM fund management modules, and Oracle Cloud Financials.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`trade`.`route_allowance` (
    `route_allowance_id` BIGINT COMMENT 'Primary key for route_allowance',
    `account_id` BIGINT COMMENT 'Unique identifier of the distributor account receiving the allowance.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to maintenance.asset. Business justification: DSD route allowance is paid to delivery‑truck assets; linking enables allocation of allowance per vehicle for compliance and cost tracking.',
    `compliance_document_id` BIGINT COMMENT 'Reference to the compliance document governing the allowance.',
    `delivery_route_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_route. Business justification: Route allowances are budgeted per DSD delivery route; linking allows allowance calculations and route‑level financial reporting.',
    `dsd_route_id` BIGINT COMMENT 'Identifier of the Direct Store Delivery route to which the allowance applies.',
    `lane_id` BIGINT COMMENT 'Foreign key linking to supply.lane. Business justification: DSD route allowances are defined per transportation lane; needed for the Route Allowance Calculation report.',
    `promotion_plan_id` BIGINT COMMENT 'Foreign key linking to trade.promotion_plan. Business justification: Route allowances are defined per promotion plan to support DSD routes; linking provides plan context.',
    `sku_id` BIGINT COMMENT 'Identifier of the product/SKU to which the allowance is tied.',
    `allowance_code` STRING COMMENT 'Business identifier code assigned to the allowance agreement.',
    `allowance_rate` DECIMAL(18,2) COMMENT 'Monetary or percentage rate of the allowance.',
    `allowance_rate_unit` STRING COMMENT 'Unit of measure for the allowance rate.. Valid values are `percent|currency_per_unit|fixed_amount`',
    `allowance_type` STRING COMMENT 'Category of the allowance applied to the DSD route.. Valid values are `route_allowance|fuel_surcharge_offset|handling_allowance`',
    `channel` STRING COMMENT 'Distribution channel (e.g., DSD, warehouse‑to‑store).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the allowance record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary allowances.',
    `effective_end_date` DATE COMMENT 'Date when the allowance expires or is terminated (null for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the allowance becomes effective.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the allowance.',
    `region` STRING COMMENT 'Geographic region associated with the DSD route.',
    `regulatory_approval_status` STRING COMMENT 'Status of regulatory review for the allowance (e.g., price compliance).. Valid values are `approved|pending|rejected`',
    `route_allowance_status` STRING COMMENT 'Current lifecycle status of the allowance agreement.. Valid values are `active|inactive|pending|terminated`',
    `settlement_frequency` STRING COMMENT 'How often the allowance is settled with the distributor.. Valid values are `monthly|quarterly|annually`',
    `store_list` STRING COMMENT 'JSON‑encoded list of store identifiers covered by the allowance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the allowance record.',
    CONSTRAINT pk_route_allowance PRIMARY KEY(`route_allowance_id`)
) COMMENT 'Master and transactional record for allowances and pricing adjustments specific to Direct Store Delivery (DSD) routes. Captures DSD route identifier, distributor account, store list, product/SKU, allowance type (route allowance, fuel surcharge offset, handling allowance), allowance rate, effective date range, and settlement frequency. Manages the unique trade economics of DSD channel execution distinct from warehouse-delivered retail. Sourced from SAP S/4HANA SD DSD module.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`trade`.`coop_advertising` (
    `coop_advertising_id` BIGINT COMMENT 'Primary key for coop_advertising',
    `promotion_plan_id` BIGINT COMMENT 'Foreign key linking to trade.promotion_plan. Business justification: Co‑op advertising programs are a type of promotion; linking ties spend to the underlying promotion plan for ROI analysis.',
    `account_id` BIGINT COMMENT 'Identifier of the retailer partner receiving co‑op funding.',
    `target_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_target. Business justification: Co‑op advertising budgets are tied to sustainability initiatives; required for the Co‑op Advertising ESG Alignment Report.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the co‑op advertising claim was approved by Food Beverage.',
    `business_event_timestamp` TIMESTAMP COMMENT 'Timestamp when the co‑op advertising program was officially created or approved.',
    `channel` STRING COMMENT 'Primary distribution channel for the advertising (retail stores, online platforms, or both).. Valid values are `retail|online|both`',
    `claim_status` STRING COMMENT 'Current processing state of the co‑op advertising claim.. Valid values are `pending|approved|rejected|paid`',
    `co_op_program_code` STRING COMMENT 'External code or number used to reference the cooperative advertising program in contracts and reports.',
    `coop_advertising_description` STRING COMMENT 'Free‑form text describing the objectives and creative details of the co‑op advertising program.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code representing the currency of monetary amounts.. Valid values are `[A-Z]{3}`',
    `food_beverage_funding_amount` DECIMAL(18,2) COMMENT 'Portion of the total cost funded by Food Beverage.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the co‑op advertising is exclusive to the retailer (true) or shared with other partners (false).',
    `lifecycle_status` STRING COMMENT 'Overall lifecycle stage of the co‑op advertising record.. Valid values are `draft|active|closed|cancelled`',
    `media_vehicle` STRING COMMENT 'Specific media channel or placement used for the advertisement (e.g., TV spot, radio slot, banner URL).',
    `media_vehicle_type` STRING COMMENT 'Broad classification of the media vehicle.. Valid values are `TV|Radio|Digital|Print`',
    `payment_status` STRING COMMENT 'Settlement status of the retailer’s portion of the co‑op funding.. Valid values are `unpaid|paid|partial|failed`',
    `program_type` STRING COMMENT 'Category of the co‑op advertising activity (e.g., circular feature, digital ad, in‑store radio, loyalty app feature).. Valid values are `circular_feature|digital_ad|in_store_radio|loyalty_app_feature`',
    `proof_of_performance_ref` STRING COMMENT 'Document or system reference that validates the advertising run was executed as planned.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when this record was first inserted into the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to this record.',
    `region` STRING COMMENT 'Geographic region where the advertising is targeted.. Valid values are `NORTH|SOUTH|EAST|WEST|MIDWEST`',
    `retailer_funding_amount` DECIMAL(18,2) COMMENT 'Portion of the total cost funded by the retailer partner.',
    `run_end_date` DATE COMMENT 'Last calendar date the co‑op advertising is scheduled to run.',
    `run_start_date` DATE COMMENT 'First calendar date the co‑op advertising is scheduled to run.',
    `target_sku_list` STRING COMMENT 'Comma‑separated list of SKU identifiers that are covered by the co‑op advertising program.',
    `total_program_cost` DECIMAL(18,2) COMMENT 'Aggregate cost of the advertising program before any funding allocations.',
    `created_by` STRING COMMENT 'User identifier of the employee who created the co‑op advertising record.',
    CONSTRAINT pk_coop_advertising PRIMARY KEY(`coop_advertising_id`)
) COMMENT 'Transactional record for cooperative advertising programs funded jointly by Food Beverage and retail customers. Captures co-op program type (circular feature, digital ad, in-store radio, loyalty app feature), retailer account, media vehicle, run dates, total program cost, Food Beverage funding amount, retailer funding amount, proof-of-performance documentation reference, claim status, and payment status. Tracks co-op advertising as a distinct component of total trade investment. Sourced from Salesforce CRM Marketing Cloud and SAP S/4HANA.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`trade`.`promotion_price_assignment` (
    `promotion_price_assignment_id` BIGINT COMMENT 'Primary key for the promotion_price_assignment association',
    `price_list_line_id` BIGINT COMMENT 'Foreign key linking to the price_list_line',
    `promotion_event_id` BIGINT COMMENT 'Foreign key linking to the promotion_event',
    `discount_percent` DECIMAL(18,2) COMMENT 'Discount percentage applied by the promotion to the price list line',
    `effective_end_date` DATE COMMENT 'Date when the promotion discount ends for this price list line',
    `effective_start_date` DATE COMMENT 'Date when the promotion discount starts for this price list line',
    CONSTRAINT pk_promotion_price_assignment PRIMARY KEY(`promotion_price_assignment_id`)
) COMMENT 'This association captures the operational link between a trade promotion_event and the price_list_line records it affects. It stores the discount percent applied by the promotion and the effective date range of that discount for each SKU.. Existence Justification: A promotion_event can apply to many price_list_line records, each representing a SKU price, and a single price_list_line can be included in multiple promotion events over time. The link between them carries operational data such as the discount percent and the effective dates of the promotion, which are managed by users when creating or editing promotions.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`trade`.`store_cluster` (
    `store_cluster_id` BIGINT COMMENT 'Primary key for store_cluster',
    `parent_store_cluster_id` BIGINT COMMENT 'Self-referencing FK on store_cluster (parent_store_cluster_id)',
    `average_sales_amount` DECIMAL(18,2) COMMENT 'Average sales revenue generated by the cluster over the most recent fiscal period.',
    `store_cluster_code` STRING COMMENT 'Business code used to reference the store cluster in external systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the store cluster record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for monetary values associated with the cluster.',
    `store_cluster_description` STRING COMMENT 'Detailed free‑text description of the store cluster.',
    `effective_from` DATE COMMENT 'Date when the store cluster became effective for planning and reporting.',
    `effective_until` DATE COMMENT 'Date when the store cluster ceases to be effective (null if open‑ended).',
    `is_flagship` BOOLEAN COMMENT 'True if the cluster contains flagship or high‑visibility stores.',
    `market_segment` STRING COMMENT 'Target market segment for the cluster (e.g., premium, value, health‑conscious).',
    `store_cluster_name` STRING COMMENT 'Human‑readable name of the store cluster.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information about the cluster.',
    `region` STRING COMMENT 'Geographic region (e.g., Northeast, Midwest) where the cluster is located.',
    `store_cluster_status` STRING COMMENT 'Current lifecycle status of the store cluster.',
    `store_count` STRING COMMENT 'Count of individual retail locations that belong to this cluster.',
    `store_cluster_type` STRING COMMENT 'Classification of the cluster based on its purpose or composition.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the store cluster record.',
    CONSTRAINT pk_store_cluster PRIMARY KEY(`store_cluster_id`)
) COMMENT 'Master reference table for store_cluster. Referenced by store_cluster_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ADD CONSTRAINT `fk_trade_promotion_plan_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `food_beverage_ecm`.`trade`.`fund`(`fund_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ADD CONSTRAINT `fk_trade_promotion_event_promotion_plan_id` FOREIGN KEY (`promotion_plan_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_plan`(`promotion_plan_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ADD CONSTRAINT `fk_trade_promotion_event_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `food_beverage_ecm`.`trade`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ADD CONSTRAINT `fk_trade_promotion_line_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ADD CONSTRAINT `fk_trade_accrual_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ADD CONSTRAINT `fk_trade_deduction_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ADD CONSTRAINT `fk_trade_deduction_retailer_agreement_id` FOREIGN KEY (`retailer_agreement_id`) REFERENCES `food_beverage_ecm`.`trade`.`retailer_agreement`(`retailer_agreement_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ADD CONSTRAINT `fk_trade_slotting_fee_retailer_agreement_id` FOREIGN KEY (`retailer_agreement_id`) REFERENCES `food_beverage_ecm`.`trade`.`retailer_agreement`(`retailer_agreement_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ADD CONSTRAINT `fk_trade_agreement_term_retailer_agreement_id` FOREIGN KEY (`retailer_agreement_id`) REFERENCES `food_beverage_ecm`.`trade`.`retailer_agreement`(`retailer_agreement_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ADD CONSTRAINT `fk_trade_volume_rebate_retailer_agreement_id` FOREIGN KEY (`retailer_agreement_id`) REFERENCES `food_beverage_ecm`.`trade`.`retailer_agreement`(`retailer_agreement_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ADD CONSTRAINT `fk_trade_category_captain_promotion_plan_id` FOREIGN KEY (`promotion_plan_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_plan`(`promotion_plan_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ADD CONSTRAINT `fk_trade_settlement_promotion_claim_id` FOREIGN KEY (`promotion_claim_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_claim`(`promotion_claim_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ADD CONSTRAINT `fk_trade_promotion_claim_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ADD CONSTRAINT `fk_trade_spend_budget_promotion_plan_id` FOREIGN KEY (`promotion_plan_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_plan`(`promotion_plan_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ADD CONSTRAINT `fk_trade_route_allowance_promotion_plan_id` FOREIGN KEY (`promotion_plan_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_plan`(`promotion_plan_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ADD CONSTRAINT `fk_trade_coop_advertising_promotion_plan_id` FOREIGN KEY (`promotion_plan_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_plan`(`promotion_plan_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_price_assignment` ADD CONSTRAINT `fk_trade_promotion_price_assignment_promotion_event_id` FOREIGN KEY (`promotion_event_id`) REFERENCES `food_beverage_ecm`.`trade`.`promotion_event`(`promotion_event_id`);
ALTER TABLE `food_beverage_ecm`.`trade`.`store_cluster` ADD CONSTRAINT `fk_trade_store_cluster_parent_store_cluster_id` FOREIGN KEY (`parent_store_cluster_id`) REFERENCES `food_beverage_ecm`.`trade`.`store_cluster`(`store_cluster_id`);

-- ========= TAGS =========
ALTER SCHEMA `food_beverage_ecm`.`trade` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `food_beverage_ecm`.`trade` SET TAGS ('dbx_domain' = 'trade');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` SET TAGS ('dbx_subdomain' = 'promotion_planning');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `promotion_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Plan Identifier');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer Identifier');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Promotion Approval Status');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|submitted|approved|rejected');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `baseline_volume` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'dsd|retail|online|foodservice|direct');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Effective End Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `estimated_roi_percent` SET TAGS ('dbx_business_glossary_term' = 'Estimated ROI (Percent)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `forecast_created_by` SET TAGS ('dbx_business_glossary_term' = 'Forecast Created By');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `forecast_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `forecast_method` SET TAGS ('dbx_business_glossary_term' = 'Forecast Method');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `forecast_method` SET TAGS ('dbx_value_regex' = 'statistical|historical|sales_rep');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `forecast_version` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'internal|manufacturer|co_op|vendor|third_party');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `incremental_lift_estimate` SET TAGS ('dbx_business_glossary_term' = 'Incremental Lift Estimate');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `net_revenue_impact` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Impact');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Promotion Plan Notes');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `promotion_code` SET TAGS ('dbx_business_glossary_term' = 'Promotion Plan Code');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `promotion_mechanic` SET TAGS ('dbx_business_glossary_term' = 'Promotion Mechanic');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `promotion_mechanic` SET TAGS ('dbx_value_regex' = 'discount|rebate|gift|cashback|free_gift|price_reduction');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `promotion_name` SET TAGS ('dbx_business_glossary_term' = 'Promotion Plan Name');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `promotion_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Promotion Plan Status');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `promotion_plan_status` SET TAGS ('dbx_value_regex' = 'draft|pending|approved|active|closed|cancelled');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `promotion_type` SET TAGS ('dbx_business_glossary_term' = 'Promotion Type');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `promotion_type` SET TAGS ('dbx_value_regex' = 'tpr|display|feature_ad|bogo|scan_back|bundle');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `promotional_budget_currency` SET TAGS ('dbx_business_glossary_term' = 'Promotional Budget Currency');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `sku_ids` SET TAGS ('dbx_business_glossary_term' = 'SKU Identifier List');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `target_sales_units` SET TAGS ('dbx_business_glossary_term' = 'Target Sales Units');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `target_sales_value` SET TAGS ('dbx_business_glossary_term' = 'Target Sales Value');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `total_promoted_volume` SET TAGS ('dbx_business_glossary_term' = 'Total Promoted Volume');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `trade_spend_investment` SET TAGS ('dbx_business_glossary_term' = 'Trade Spend Investment');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` SET TAGS ('dbx_subdomain' = 'store_operations');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event ID');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `promotion_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Plan ID');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer Account ID');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `store_cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster ID');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `actual_revenue` SET TAGS ('dbx_business_glossary_term' = 'Actual Revenue');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `actual_sales_volume` SET TAGS ('dbx_business_glossary_term' = 'Actual Sales Volume');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'in_store|online|both');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial|pending_review');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Number');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `field_verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Field Verification Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `is_field_verified` SET TAGS ('dbx_business_glossary_term' = 'Field Verification Flag');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `mechanic_type` SET TAGS ('dbx_business_glossary_term' = 'Promotional Mechanic Type');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `mechanic_type` SET TAGS ('dbx_value_regex' = 'end_cap|circular_feature|tpr_shelf_tag|floor_graphic|in_store_demo');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Notes');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `promotion_event_status` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Status');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `promotion_event_status` SET TAGS ('dbx_value_regex' = 'planned|executed|cancelled|postponed|closed');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `promotion_objective` SET TAGS ('dbx_business_glossary_term' = 'Promotion Objective');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `promotion_objective` SET TAGS ('dbx_value_regex' = 'awareness|trial|sales|distribution');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `promotion_type` SET TAGS ('dbx_business_glossary_term' = 'Promotion Type');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `promotion_type` SET TAGS ('dbx_value_regex' = 'price_discount|buy_one_get_one|bundle|gift_with_purchase|sampling');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `promotional_materials_delivered` SET TAGS ('dbx_business_glossary_term' = 'Promotional Materials Delivered');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `promotional_materials_quantity` SET TAGS ('dbx_business_glossary_term' = 'Promotional Materials Quantity');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `promotional_materials_type` SET TAGS ('dbx_business_glossary_term' = 'Promotional Materials Type');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `promotional_materials_type` SET TAGS ('dbx_value_regex' = 'display|shelf_tag|flyer|digital|sample');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `promotional_spend_discount` SET TAGS ('dbx_business_glossary_term' = 'Promotional Spend Discount');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `promotional_spend_gross` SET TAGS ('dbx_business_glossary_term' = 'Promotional Spend Gross');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `promotional_spend_net` SET TAGS ('dbx_business_glossary_term' = 'Promotional Spend Net');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `sku_list` SET TAGS ('dbx_business_glossary_term' = 'SKU List');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `store_count_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Store Count');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `store_count_planned` SET TAGS ('dbx_business_glossary_term' = 'Planned Store Count');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `target_revenue` SET TAGS ('dbx_business_glossary_term' = 'Target Revenue');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `target_sales_volume` SET TAGS ('dbx_business_glossary_term' = 'Target Sales Volume');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` SET TAGS ('dbx_subdomain' = 'promotion_planning');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `promotion_line_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Line ID (PLID)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer ID (RID)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `nutrition_label_id` SET TAGS ('dbx_business_glossary_term' = 'Nutrition Label Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `price_list_line_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Line Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID (PID)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Segment Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method (AM)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'proportional|fixed|volume_based');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (AS)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (AT)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `baseline_volume` SET TAGS ('dbx_business_glossary_term' = 'Baseline Volume (BV)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `bill_back_rate` SET TAGS ('dbx_business_glossary_term' = 'Bill‑Back Rate (BBR)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Promotion Budget Amount (PBA)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `cost_of_goods_sold_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold Per Unit (COGS/U)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CC)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion End Date (PED)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `funding_amount_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Funding Amount Per Unit (FAPU)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `incremental_volume_target` SET TAGS ('dbx_business_glossary_term' = 'Incremental Volume Target (IVT)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Promotion Flag (EPF)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `margin_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Margin Per Unit (MPU)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Promotion Line Notes (PLN)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `off_invoice_allowance_rate` SET TAGS ('dbx_business_glossary_term' = 'Off-Invoice Allowance Rate (OAR)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `planned_price` SET TAGS ('dbx_business_glossary_term' = 'Planned Promotional Price (PPP)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `planned_volume_lift` SET TAGS ('dbx_business_glossary_term' = 'Planned Volume Lift (PVL)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `promotion_category` SET TAGS ('dbx_business_glossary_term' = 'Promotion Category (PC)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `promotion_category` SET TAGS ('dbx_value_regex' = 'volume|price|mix');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `promotion_line_status` SET TAGS ('dbx_business_glossary_term' = 'Promotion Line Status (PLS)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `promotion_line_status` SET TAGS ('dbx_value_regex' = 'planned|active|completed|cancelled');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `promotion_type` SET TAGS ('dbx_business_glossary_term' = 'Promotion Type (PT)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `promotion_type` SET TAGS ('dbx_value_regex' = 'price_discount|buy_one_get_one|rebate|coupon|slotting_fee');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Promotion Line Quantity (PLQ)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (RC)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = 'NA|EU|APAC');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel (SC)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'retail|foodservice|direct');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `scan_back_rate` SET TAGS ('dbx_business_glossary_term' = 'Scan‑Back Rate (SBR)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Start Date (PSD)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `target_store_type` SET TAGS ('dbx_business_glossary_term' = 'Target Store Type (TST)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `total_funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Funding Amount (TFA)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` SET TAGS ('dbx_subdomain' = 'funding_allocation');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Fund Identifier');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner Identifier');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `accrued_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued Fund Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'proportional|fixed|tiered');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `allocation_scope` SET TAGS ('dbx_business_glossary_term' = 'Allocation Scope');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `allocation_scope` SET TAGS ('dbx_value_regex' = 'retailer|sales_territory|brand_category');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Fund Approval Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Trade Fund Classification');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'marketing|price_promotion|slotting|display|trade');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Fund Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Fund Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Fund Effective End Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `fund_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Fund Code');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `fund_description` SET TAGS ('dbx_business_glossary_term' = 'Fund Description');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `fund_name` SET TAGS ('dbx_business_glossary_term' = 'Trade Fund Name');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `fund_status` SET TAGS ('dbx_business_glossary_term' = 'Trade Fund Status');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `fund_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|pending');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `fund_type` SET TAGS ('dbx_business_glossary_term' = 'Trade Fund Type');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `fund_type` SET TAGS ('dbx_value_regex' = 'lump_sum|accrual|fixed_allowance');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Fund Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `remaining_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Fund Balance');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `total_approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Approved Fund Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`fund` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` SET TAGS ('dbx_subdomain' = 'rebate_settlement');
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ALTER COLUMN `accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Accrual Identifier');
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer Identifier');
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Identifier');
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ALTER COLUMN `accrual_number` SET TAGS ('dbx_business_glossary_term' = 'Accrual Number');
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ALTER COLUMN `accrual_number` SET TAGS ('dbx_value_regex' = '^ACR[0-9]{8}$');
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ALTER COLUMN `accrual_status` SET TAGS ('dbx_business_glossary_term' = 'Accrual Status');
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ALTER COLUMN `accrual_status` SET TAGS ('dbx_value_regex' = 'active|reversed|closed|pending');
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ALTER COLUMN `accrual_type` SET TAGS ('dbx_business_glossary_term' = 'Accrual Type');
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ALTER COLUMN `accrual_type` SET TAGS ('dbx_value_regex' = 'off_invoice|bill_back|scan_back|lump_sum');
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Accrual Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ALTER COLUMN `basis` SET TAGS ('dbx_business_glossary_term' = 'Accrual Basis');
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ALTER COLUMN `basis` SET TAGS ('dbx_value_regex' = 'per_case|per_unit|percentage_of_net_sales');
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ALTER COLUMN `basis_quantity` SET TAGS ('dbx_business_glossary_term' = 'Accrual Basis Quantity');
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Accrual Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Effective Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Expiration Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'GL Account Code');
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ALTER COLUMN `net_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Sales Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ALTER COLUMN `period_end` SET TAGS ('dbx_business_glossary_term' = 'Accrual Period End Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ALTER COLUMN `period_start` SET TAGS ('dbx_business_glossary_term' = 'Accrual Period Start Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ALTER COLUMN `posting_reference` SET TAGS ('dbx_business_glossary_term' = 'Posting Reference');
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ALTER COLUMN `rate` SET TAGS ('dbx_business_glossary_term' = 'Accrual Rate');
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Accrual Reason');
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ALTER COLUMN `recognition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Accrual Recognition Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Accrual Reversal Indicator');
ALTER TABLE `food_beverage_ecm`.`trade`.`accrual` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Accrual Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` SET TAGS ('dbx_subdomain' = 'rebate_settlement');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `deduction_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Deduction Identifier');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer Identifier (RID)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ABU_ID)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (INV_ID)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Event Identifier (PE_ID)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `retailer_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (CT_ID)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Deduction Adjustment Amount (DAA)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (AT)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Identifier (AT_ID)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number (BN)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `chargeback_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Rate Percent (CRP)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments (CM)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CC)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `deduction_category` SET TAGS ('dbx_business_glossary_term' = 'Deduction Category (DCAT)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `deduction_category` SET TAGS ('dbx_value_regex' = 'price|volume|term|other');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `deduction_date` SET TAGS ('dbx_business_glossary_term' = 'Deduction Date (DDATE)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `deduction_description` SET TAGS ('dbx_business_glossary_term' = 'Deduction Description (DD)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `deduction_number` SET TAGS ('dbx_business_glossary_term' = 'Deduction Number (DN)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `deduction_status` SET TAGS ('dbx_business_glossary_term' = 'Deduction Status (DS)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `deduction_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|settled|in_dispute');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `deduction_type` SET TAGS ('dbx_business_glossary_term' = 'Deduction Type (DT)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `deduction_type` SET TAGS ('dbx_value_regex' = 'short_payment|promo_claim|chargeback|unauthorized|other');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag (DF)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason (DR)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXP_DATE)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Amount (FA)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Deduction Gross Amount (DGA)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `handling_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Handling Fee Amount (HFA)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `is_manual_entry` SET TAGS ('dbx_business_glossary_term' = 'Manual Entry Flag (MEF)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (LN)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment (MS)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `market_segment` SET TAGS ('dbx_value_regex' = 'Retail|Foodservice|Direct');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Deduction Net Amount (DNA)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `processing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processing Timestamp (PT)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number (PO)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Deduction Quantity (DQ)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Deduction Reason Code (DRC)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (RC)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SS)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP|Oracle|Salesforce|Other');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `supporting_document_number` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Number (SDN)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TA)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code (TC)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|KG|L|ML|CASE');
ALTER TABLE `food_beverage_ecm`.`trade`.`deduction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` SET TAGS ('dbx_subdomain' = 'store_operations');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `slotting_fee_id` SET TAGS ('dbx_business_glossary_term' = 'Slotting Fee ID');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Network Node Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `packaging_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Profile Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer ID');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `retailer_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer Agreement Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `accrual_flag` SET TAGS ('dbx_business_glossary_term' = 'Accrual Flag');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term (Months)');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `fee_description` SET TAGS ('dbx_business_glossary_term' = 'Fee Description');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `fee_per_store` SET TAGS ('dbx_business_glossary_term' = 'Fee Per Store');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `fee_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Status');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `fee_status` SET TAGS ('dbx_value_regex' = 'pending|approved|paid|cancelled');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `fee_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Tax Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `fee_taxable_flag` SET TAGS ('dbx_business_glossary_term' = 'Fee Taxable Flag');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `fee_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Type');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `fee_type` SET TAGS ('dbx_value_regex' = 'new_item|reset|promotion|replenishment');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `net_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Fee Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|wire|eft|credit');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|upon_invoice');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|partial|paid');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `shelf_facing_count` SET TAGS ('dbx_business_glossary_term' = 'Shelf Facing Count');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `shelf_position` SET TAGS ('dbx_business_glossary_term' = 'Shelf Position');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `shelf_position` SET TAGS ('dbx_value_regex' = 'eye_level|top|bottom|mid_shelf');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `sku_list` SET TAGS ('dbx_business_glossary_term' = 'SKU List');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `slotting_fee_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `store_count` SET TAGS ('dbx_business_glossary_term' = 'Store Count');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `total_fee_commitment` SET TAGS ('dbx_business_glossary_term' = 'Total Fee Commitment');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`slotting_fee` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` SET TAGS ('dbx_subdomain' = 'retail_agreements');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `retailer_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer Agreement Identifier');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Initiative Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `retailer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer Identifier');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Name');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'volume_rebate|promotional_funding|edlp|display_compliance|scan_back|co_op_advertising');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `bonus_clause` SET TAGS ('dbx_business_glossary_term' = 'Bonus Clause');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `category_scope` SET TAGS ('dbx_business_glossary_term' = 'Category Scope');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `co_op_advertising_allowance` SET TAGS ('dbx_business_glossary_term' = 'Co‑Op Advertising Allowance');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `compliance_measure_method` SET TAGS ('dbx_business_glossary_term' = 'Compliance Measurement Method');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `compliance_measure_method` SET TAGS ('dbx_value_regex' = 'sales_data|scan_back|audit|third_party|self_report|system');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|CAD|GBP|JPY|AUD');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `display_compliance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Display Compliance Requirement');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `edlp_price_commitment` SET TAGS ('dbx_business_glossary_term' = 'EDLP Price Commitment');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `edlp_price_uom` SET TAGS ('dbx_business_glossary_term' = 'EDLP Price Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `edlp_price_uom` SET TAGS ('dbx_value_regex' = 'per_unit|per_case|per_liter');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `funding_commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Funding Commitment Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `is_exclusive_agreement` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Agreement Flag');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `is_multi_year` SET TAGS ('dbx_business_glossary_term' = 'Multi‑Year Agreement Flag');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `mdf_allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Marketing Development Fund Allocation');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `performance_measure_period` SET TAGS ('dbx_business_glossary_term' = 'Performance Measure Period');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `performance_measure_period` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `performance_threshold` SET TAGS ('dbx_business_glossary_term' = 'Performance Threshold');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `promotional_event_count` SET TAGS ('dbx_business_glossary_term' = 'Promotional Event Count');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `rebate_tier_structure` SET TAGS ('dbx_business_glossary_term' = 'Rebate Tier Structure');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `retailer_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `retailer_agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired|pending');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `scan_back_rate` SET TAGS ('dbx_business_glossary_term' = 'Scan‑Back Rate');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `scan_back_uom` SET TAGS ('dbx_business_glossary_term' = 'Scan‑Back Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `scan_back_uom` SET TAGS ('dbx_value_regex' = 'percent|per_unit');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `sku_scope` SET TAGS ('dbx_business_glossary_term' = 'SKU Scope');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `total_funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Funding Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `volume_target` SET TAGS ('dbx_business_glossary_term' = 'Volume Target');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `volume_target_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Target Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`trade`.`retailer_agreement` ALTER COLUMN `volume_target_uom` SET TAGS ('dbx_value_regex' = 'cases|units|kg|liters|pallets');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` SET TAGS ('dbx_subdomain' = 'retail_agreements');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `agreement_term_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Term ID');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer ID');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `category_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category ID');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `retailer_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement ID');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'SKU ID');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `accrual_method` SET TAGS ('dbx_business_glossary_term' = 'Accrual Method');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `accrual_method` SET TAGS ('dbx_value_regex' = 'post_invoice|prepay|on_sale');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `agreement_term_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Term Status');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `agreement_term_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `chargeback_rate` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Rate');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `chargeback_type` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Type');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `chargeback_type` SET TAGS ('dbx_value_regex' = 'scan_back|sell_through');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `compliance_actual` SET TAGS ('dbx_business_glossary_term' = 'Compliance Actual Value');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `compliance_metric` SET TAGS ('dbx_business_glossary_term' = 'Compliance Metric');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Required Flag');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `compliance_target` SET TAGS ('dbx_business_glossary_term' = 'Compliance Target Value');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `contract_term_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Term Group ID');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `edlp_price` SET TAGS ('dbx_business_glossary_term' = 'EDLP Price');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `edlp_price_currency` SET TAGS ('dbx_business_glossary_term' = 'EDLP Price Currency');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `edlp_price_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Term Flag');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `measurement_period` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `measurement_period` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|yearly');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Term Notes');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `promotional_funding_rate` SET TAGS ('dbx_business_glossary_term' = 'Promotional Funding Rate');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `promotional_funding_type` SET TAGS ('dbx_business_glossary_term' = 'Promotional Funding Type');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `promotional_funding_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `rate_currency` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `rate_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX|GBR|FRA|DEU');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `slotting_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Slotting Fee Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `slotting_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Slotting Fee Currency');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `slotting_fee_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `term_description` SET TAGS ('dbx_business_glossary_term' = 'Agreement Term Description');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `term_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Term Type');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `term_type` SET TAGS ('dbx_value_regex' = 'volume_rebate|promotional_funding|edlp_price_commitment|display_compliance|scan_back|co_op_advertising');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `threshold_quantity` SET TAGS ('dbx_business_glossary_term' = 'Threshold Quantity');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_value_regex' = 'units|cases|kg|liters');
ALTER TABLE `food_beverage_ecm`.`trade`.`agreement_term` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` SET TAGS ('dbx_subdomain' = 'rebate_settlement');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `volume_rebate_id` SET TAGS ('dbx_business_glossary_term' = 'Volume Rebate ID');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approval User ID');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `retailer_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer Agreement Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `accrual_flag` SET TAGS ('dbx_business_glossary_term' = 'Accrual Flag (AF)');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number (CN)');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CC)');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Rebate Flag (ERF)');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `measurement_period_end` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `measurement_period_start` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `net_rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Rebate Amount (NRA)');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `party_name` SET TAGS ('dbx_business_glossary_term' = 'Party Name');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method (PM)');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_memo|check|off_invoice');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `purchase_volume` SET TAGS ('dbx_business_glossary_term' = 'Purchase Volume (PV)');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Amount (RA)');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `rebate_calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rebate Calculation Timestamp (RCT)');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `rebate_program_code` SET TAGS ('dbx_business_glossary_term' = 'Rebate Program Code (RPC)');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `rebate_program_name` SET TAGS ('dbx_business_glossary_term' = 'Rebate Program Name (RPN)');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `rebate_rate` SET TAGS ('dbx_business_glossary_term' = 'Rebate Rate (RR)');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `rebate_type` SET TAGS ('dbx_business_glossary_term' = 'Rebate Type (RT)');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `rebate_type` SET TAGS ('dbx_value_regex' = 'volume|growth|mix');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp (RACT)');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp (RAUT)');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (RC)');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date (SD)');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status (SS)');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|rejected|in_process');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TA)');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `tax_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Included Flag (TIF)');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `threshold_volume` SET TAGS ('dbx_business_glossary_term' = 'Threshold Volume (TV)');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `tier_level` SET TAGS ('dbx_business_glossary_term' = 'Tier Level (TL)');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `tier_level` SET TAGS ('dbx_value_regex' = 'Tier1|Tier2|Tier3|Tier4');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `volume_rebate_status` SET TAGS ('dbx_business_glossary_term' = 'Rebate Record Status (RRS)');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `volume_rebate_status` SET TAGS ('dbx_value_regex' = 'draft|active|closed|cancelled');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'cases|liters|kg|gallons');
ALTER TABLE `food_beverage_ecm`.`trade`.`volume_rebate` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` SET TAGS ('dbx_subdomain' = 'retail_agreements');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `category_captain_id` SET TAGS ('dbx_business_glossary_term' = 'Category Captain Agreement ID');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer Identifier (RET_ID)');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `promotion_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Plan Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number (AGMT_NO)');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type (AGMT_TYPE)');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'category_captain|category_advisor');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `agreement_version` SET TAGS ('dbx_business_glossary_term' = 'Agreement Version (AGMT_VER)');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (APPROVAL_STATUS)');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `assortment_authority` SET TAGS ('dbx_business_glossary_term' = 'Assortment Recommendation Authority (ASSORT_AUTH)');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `assortment_authority` SET TAGS ('dbx_value_regex' = 'exclusive|shared|none');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Summary (AUDIT_TRAIL)');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `category_captain_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Lifecycle Status (STATUS)');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `category_captain_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `category_scope` SET TAGS ('dbx_business_glossary_term' = 'Category Scope (CAT_SCOPE)');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `competitive_exclusion_terms` SET TAGS ('dbx_business_glossary_term' = 'Competitive Exclusion Terms (COMP_EXCL)');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `competitive_inclusion_terms` SET TAGS ('dbx_business_glossary_term' = 'Competitive Inclusion Terms (COMP_INCL)');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag (COMPLIANCE_FLAG)');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL (DOC_URL)');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFF_FROM)');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFF_UNTIL)');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `kpi_acv_target` SET TAGS ('dbx_business_glossary_term' = 'All Commodity Volume Target (KPI_ACV_TGT)');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `kpi_category_growth_target` SET TAGS ('dbx_business_glossary_term' = 'Category Growth Target Percentage (KPI_GROWTH_TGT_PCT)');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `kpi_tdp_target` SET TAGS ('dbx_business_glossary_term' = 'Total Distribution Points Target (KPI_TDP_TGT)');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `planogram_ownership` SET TAGS ('dbx_business_glossary_term' = 'Planogram Ownership Rights (PLANOGRAM_OWN)');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `planogram_ownership` SET TAGS ('dbx_value_regex' = 'full|partial|none');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Frequency (REVIEW_CYCLE_MTH)');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `shelf_space_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Shelf Space Target Percentage (SHELF_TGT_PCT)');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date (SIGNED_DT)');
ALTER TABLE `food_beverage_ecm`.`trade`.`category_captain` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` SET TAGS ('dbx_subdomain' = 'rebate_settlement');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Identifier');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer ID');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `promotion_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Claim Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `accounting_date` SET TAGS ('dbx_business_glossary_term' = 'Accounting Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Settlement Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `is_manual_settlement` SET TAGS ('dbx_business_glossary_term' = 'Manual Settlement Indicator');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `is_tax_included` SET TAGS ('dbx_business_glossary_term' = 'Tax Included Indicator');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Settlement Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `original_claim_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Claim Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `period` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'reconciled|unreconciled|exception');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `settlement_description` SET TAGS ('dbx_business_glossary_term' = 'Settlement Description');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'bank_transfer|check|wire|electronic|cash');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `settlement_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Number');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|paid|closed');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `settlement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `settlement_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Type');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `settlement_type` SET TAGS ('dbx_value_regex' = 'credit_memo|check|off_invoice|wire_transfer|adjustment|rebate');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP|Oracle|Other');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`settlement` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` SET TAGS ('dbx_subdomain' = 'rebate_settlement');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `promotion_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Claim ID');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer ID');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `claim_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Claim Adjustment Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `claim_adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Claim Adjustment Reason');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `claim_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `claim_line_item_description` SET TAGS ('dbx_business_glossary_term' = 'Claim Line Item Description');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Number');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `claim_original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Claim Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `claim_period_end` SET TAGS ('dbx_business_glossary_term' = 'Claim Period End Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `claim_period_start` SET TAGS ('dbx_business_glossary_term' = 'Claim Period Start Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `claim_processing_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Processing Status');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `claim_processing_status` SET TAGS ('dbx_value_regex' = 'in_queue|processing|completed');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `claim_source_system` SET TAGS ('dbx_business_glossary_term' = 'Claim Source System');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `claim_submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Claim Submission Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Type');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_value_regex' = 'scan|bill_back|off_invoice');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `claimed_amount` SET TAGS ('dbx_business_glossary_term' = 'Claimed Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `claimed_volume` SET TAGS ('dbx_business_glossary_term' = 'Claimed Volume');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|disputed|closed');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `supporting_document_ref` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_claim` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` SET TAGS ('dbx_subdomain' = 'funding_allocation');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `spend_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Budget Identifier');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner Identifier');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `ibp_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Ibp Scenario Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `promotion_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Plan Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `accrued_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued Budget Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'percentage|fixed|manual');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `brand` SET TAGS ('dbx_business_glossary_term' = 'Brand');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Code');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `budget_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Name');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `budget_period` SET TAGS ('dbx_business_glossary_term' = 'Budget Period');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `budget_period` SET TAGS ('dbx_value_regex' = 'FY|Q1|Q2|Q3|Q4');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly|promo|slotting|co_op|other');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `co_op_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Co‑Op Budget Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Budget Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY|AUD');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `customer_tier` SET TAGS ('dbx_business_glossary_term' = 'Customer Tier');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `display_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Display Budget Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Effective End Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `feature_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Feature Budget Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `fund_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Type');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `fund_type` SET TAGS ('dbx_value_regex' = 'lump_sum|accrual|fixed_allowance');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `last_revision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Revision Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Budget Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `remaining_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Budget Balance');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `slotting_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Slotting Budget Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `spend_budget_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `spend_budget_description` SET TAGS ('dbx_business_glossary_term' = 'Budget Description');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `spend_budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `spend_budget_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|closed|revised');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `total_approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Approved Budget Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `tpr_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion (TPR) Budget Amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`spend_budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` SET TAGS ('dbx_subdomain' = 'funding_allocation');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ALTER COLUMN `route_allowance_id` SET TAGS ('dbx_business_glossary_term' = 'Route Allowance Identifier');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Distributor ID (DIST_ID)');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ALTER COLUMN `compliance_document_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document ID (COMP_DOC_ID)');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ALTER COLUMN `delivery_route_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Route Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ALTER COLUMN `dsd_route_id` SET TAGS ('dbx_business_glossary_term' = 'DSD Route Identifier (ROUTE_ID)');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ALTER COLUMN `promotion_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Plan Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'SKU ID (SKU_ID)');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ALTER COLUMN `allowance_code` SET TAGS ('dbx_business_glossary_term' = 'Allowance Code (ALW_CODE)');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ALTER COLUMN `allowance_rate` SET TAGS ('dbx_business_glossary_term' = 'Allowance Rate (ALW_RATE)');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ALTER COLUMN `allowance_rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Allowance Rate Unit (ALW_RATE_UNIT)');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ALTER COLUMN `allowance_rate_unit` SET TAGS ('dbx_value_regex' = 'percent|currency_per_unit|fixed_amount');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ALTER COLUMN `allowance_type` SET TAGS ('dbx_business_glossary_term' = 'Allowance Type (ALW_TYPE)');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ALTER COLUMN `allowance_type` SET TAGS ('dbx_value_regex' = 'route_allowance|fuel_surcharge_offset|handling_allowance');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel (CHANNEL)');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CODE)');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (ALW_EFF_END)');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (ALW_EFF_START)');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region (REGION)');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status (REG_APPROVAL)');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ALTER COLUMN `route_allowance_status` SET TAGS ('dbx_business_glossary_term' = 'Allowance Status (ALW_STATUS)');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ALTER COLUMN `route_allowance_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Frequency (SETTLE_FREQ)');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ALTER COLUMN `store_list` SET TAGS ('dbx_business_glossary_term' = 'Store List (STORE_LIST)');
ALTER TABLE `food_beverage_ecm`.`trade`.`route_allowance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` SET TAGS ('dbx_subdomain' = 'funding_allocation');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `coop_advertising_id` SET TAGS ('dbx_business_glossary_term' = 'Coop Advertising Identifier');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `promotion_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Plan Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer Account ID');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Co‑Op Advertising Approved Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `business_event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Co‑Op Advertising Event Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Advertising Channel');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'retail|online|both');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Co‑Op Claim Status');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `claim_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|paid');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `co_op_program_code` SET TAGS ('dbx_business_glossary_term' = 'Co‑Op Advertising Program Code');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `coop_advertising_description` SET TAGS ('dbx_business_glossary_term' = 'Co‑Op Advertising Description');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `food_beverage_funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Food Beverage Funding Amount (USD)');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Advertising Flag');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Co‑Op Advertising Lifecycle Status');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|active|closed|cancelled');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `media_vehicle` SET TAGS ('dbx_business_glossary_term' = 'Media Vehicle');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `media_vehicle_type` SET TAGS ('dbx_business_glossary_term' = 'Media Vehicle Type');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `media_vehicle_type` SET TAGS ('dbx_value_regex' = 'TV|Radio|Digital|Print');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Co‑Op Payment Status');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|paid|partial|failed');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Co‑Op Advertising Program Type');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'circular_feature|digital_ad|in_store_radio|loyalty_app_feature');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `proof_of_performance_ref` SET TAGS ('dbx_business_glossary_term' = 'Proof of Performance Reference');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = 'NORTH|SOUTH|EAST|WEST|MIDWEST');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `retailer_funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Retailer Funding Amount (USD)');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `run_end_date` SET TAGS ('dbx_business_glossary_term' = 'Advertising Run End Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `run_start_date` SET TAGS ('dbx_business_glossary_term' = 'Advertising Run Start Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `target_sku_list` SET TAGS ('dbx_business_glossary_term' = 'Target SKU List');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `total_program_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Program Cost (USD)');
ALTER TABLE `food_beverage_ecm`.`trade`.`coop_advertising` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_price_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_price_assignment` SET TAGS ('dbx_subdomain' = 'promotion_planning');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_price_assignment` SET TAGS ('dbx_association_edges' = 'trade.promotion_event,pricing.price_list_line');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_price_assignment` ALTER COLUMN `promotion_price_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Price Assignment - Promotion Price Assignment Id');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_price_assignment` ALTER COLUMN `price_list_line_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Price Assignment - Price List Line Id');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_price_assignment` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Price Assignment - Promotion Event Id');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_price_assignment` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Promotion Discount Percent');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_price_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Effective End Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`promotion_price_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`trade`.`store_cluster` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`trade`.`store_cluster` SET TAGS ('dbx_subdomain' = 'store_operations');
ALTER TABLE `food_beverage_ecm`.`trade`.`store_cluster` ALTER COLUMN `store_cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Identifier');
ALTER TABLE `food_beverage_ecm`.`trade`.`store_cluster` ALTER COLUMN `parent_store_cluster_id` SET TAGS ('dbx_self_ref_fk' = 'true');
