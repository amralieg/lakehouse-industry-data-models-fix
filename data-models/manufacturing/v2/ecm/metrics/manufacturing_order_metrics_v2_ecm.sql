-- Metric views for domain: order | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 08:28:29

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over sales order headers — order volume, revenue, average order value, and order mix by type, status, and channel. Used by Sales VPs and Supply Chain leaders to steer order intake, pricing, and fulfillment strategy."
  source: "`vibe_manufacturing_v1`.`order`.`order_header`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the order (e.g. Open, Confirmed, Delivered, Cancelled) — primary filter for pipeline vs. closed analysis."
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order (e.g. Standard, Rush, Blanket Release, Return) — drives fulfillment routing and SLA assignment."
    - name: "order_priority"
      expr: order_priority
      comment: "Priority tier assigned to the order — used to segment high-priority vs. standard order performance."
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales org responsible for the order — enables revenue and volume analysis by organizational unit."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Channel through which the order was placed (e.g. Direct, Distributor, OEM) — critical for channel mix and margin analysis."
    - name: "order_currency"
      expr: order_currency
      comment: "Transaction currency of the order — needed for multi-currency revenue reporting."
    - name: "order_placed_month"
      expr: DATE_TRUNC('MONTH', order_placed_timestamp)
      comment: "Month the order was placed — primary time dimension for trend and seasonality analysis."
    - name: "requested_delivery_month"
      expr: DATE_TRUNC('MONTH', requested_delivery_date)
      comment: "Month the customer requested delivery — used to align demand signals with supply planning."
    - name: "sales_document_type"
      expr: sales_document_type
      comment: "SAP-style sales document type (e.g. OR, RE, CS) — enables segmentation by transaction category."
    - name: "incoterms"
      expr: incoterms
      comment: "Trade terms governing delivery responsibility — used in logistics cost and risk analysis."
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of sales orders — baseline volume KPI for order intake tracking and capacity planning."
    - name: "total_net_revenue"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Sum of net order amounts across all orders — primary revenue KPI for financial and sales performance reporting."
    - name: "total_gross_revenue"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Sum of gross order amounts — used alongside net revenue to assess discount and tax impact at the order level."
    - name: "total_tax_collected"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total tax amount across orders — required for tax compliance reporting and financial reconciliation."
    - name: "avg_net_order_value"
      expr: AVG(CAST(total_net_amount AS DOUBLE))
      comment: "Average net value per order — key commercial KPI; a declining AOV signals pricing pressure or mix shift toward smaller orders."
    - name: "avg_gross_order_value"
      expr: AVG(CAST(total_gross_amount AS DOUBLE))
      comment: "Average gross value per order — used with avg_net_order_value to compute average discount/tax burden per order."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight of all orders in kilograms — drives freight cost estimation and logistics capacity planning."
    - name: "total_volume_m3"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total volume of all orders in cubic metres — used for load planning and warehouse throughput forecasting."
    - name: "distinct_customers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers placing orders — measures customer breadth and concentration risk."
    - name: "orders_with_delivery_block"
      expr: SUM(CASE WHEN delivery_block = TRUE THEN 1 ELSE 0 END)
      comment: "Count of orders currently blocked from delivery — operational risk KPI; high values indicate fulfillment bottlenecks requiring intervention."
    - name: "orders_with_billing_block"
      expr: SUM(CASE WHEN billing_block = TRUE THEN 1 ELSE 0 END)
      comment: "Count of orders blocked from billing — revenue-at-risk indicator; drives collections and credit management actions."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level order metrics covering revenue, quantity, pricing, quality, and delivery performance. Used by Sales Operations, Supply Chain, and Finance to analyse product mix, pricing effectiveness, and fulfilment accuracy at the SKU level."
  source: "`vibe_manufacturing_v1`.`order`.`line`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of the order line (e.g. Not Delivered, Partially Delivered, Fully Delivered) — primary dimension for fulfilment performance analysis."
    - name: "quality_status"
      expr: quality_status
      comment: "Quality inspection status of the line item — used to track quality-related holds and rejections at the line level."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Inspection status of the line — enables quality gate tracking across order lines."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the line quantity — required for accurate volume aggregation across mixed-UOM orders."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Sales channel for the line — enables channel-level revenue and margin analysis."
    - name: "division"
      expr: division
      comment: "Business division associated with the line — supports P&L reporting by division."
    - name: "sales_org"
      expr: sales_org
      comment: "Sales organisation responsible for the line — enables revenue attribution by sales org."
    - name: "delivery_date_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month of the scheduled delivery date — primary time dimension for delivery performance trending."
    - name: "promised_date_month"
      expr: DATE_TRUNC('MONTH', promised_date)
      comment: "Month of the promised delivery date — used to measure promise-to-actual delivery gap."
    - name: "backorder_indicator"
      expr: backorder_indicator
      comment: "Flag indicating whether the line is on backorder — key operational dimension for backlog and supply risk analysis."
    - name: "pricing_condition"
      expr: pricing_condition
      comment: "Pricing condition applied to the line (e.g. list price, contract price, spot) — used for pricing strategy analysis."
  measures:
    - name: "total_line_items"
      expr: COUNT(1)
      comment: "Total number of order lines — baseline volume measure for order complexity and processing load analysis."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_price AS DOUBLE))
      comment: "Sum of net prices across all order lines — primary line-level revenue KPI for product mix and pricing analysis."
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_price AS DOUBLE))
      comment: "Sum of gross prices across all order lines — used with net revenue to compute total discount impact."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted across order lines — measures pricing leakage and discount discipline."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged across order lines — required for tax compliance and financial reconciliation."
    - name: "total_requested_quantity"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total quantity requested by customers across all lines — demand volume KPI for supply planning."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed for delivery — measures supply commitment vs. demand; gap to requested quantity signals supply shortfall."
    - name: "total_sales_quantity"
      expr: SUM(CAST(sales_quantity AS DOUBLE))
      comment: "Total quantity sold across order lines — primary volume KPI for sales performance and inventory depletion tracking."
    - name: "avg_net_price_per_line"
      expr: AVG(CAST(net_price AS DOUBLE))
      comment: "Average net price per order line — used to track pricing trends and identify mix shifts toward lower-value SKUs."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across order lines — operational quality KPI; declining scores trigger supplier or production investigations."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight AS DOUBLE))
      comment: "Total gross weight of ordered goods in kg — drives freight cost estimation and logistics capacity planning."
    - name: "total_volume"
      expr: SUM(CAST(volume AS DOUBLE))
      comment: "Total volume of ordered goods — used for load planning and warehouse throughput forecasting."
    - name: "backorder_line_count"
      expr: SUM(CASE WHEN backorder_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Number of order lines currently on backorder — supply risk KPI; high counts signal inventory or production shortfalls requiring escalation."
    - name: "fill_rate_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(requested_quantity AS DOUBLE)), 0)
      comment: "Ratio of confirmed quantity to requested quantity — measures supply chain's ability to fulfil customer demand; below-target values drive supply escalation."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbound delivery performance metrics covering on-time delivery, freight costs, weight/volume throughput, and delivery quality. Used by Logistics, Supply Chain, and Customer Service to manage delivery SLAs and freight spend."
  source: "`vibe_manufacturing_v1`.`order`.`delivery`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the delivery (e.g. Open, In Transit, Delivered, Cancelled) — primary dimension for delivery pipeline analysis."
    - name: "delivery_type"
      expr: delivery_type
      comment: "Type of delivery (e.g. Standard, Express, Partial) — used to segment delivery performance by service level."
    - name: "carrier_code"
      expr: carrier_code
      comment: "Carrier responsible for the delivery — enables carrier performance benchmarking and freight cost analysis."
    - name: "shipping_condition"
      expr: shipping_condition
      comment: "Shipping condition (e.g. Standard Ground, Air Freight) — used for freight cost and lead time analysis by mode."
    - name: "shipping_point"
      expr: shipping_point
      comment: "Shipping point / warehouse origin — enables throughput and cost analysis by dispatch location."
    - name: "country"
      expr: country
      comment: "Destination country of the delivery — used for geographic delivery performance and customs compliance analysis."
    - name: "is_partial_delivery"
      expr: is_partial_delivery
      comment: "Flag indicating whether the delivery is partial — used to measure partial fulfilment rates and their impact on customer satisfaction."
    - name: "is_backorder"
      expr: is_backorder
      comment: "Flag indicating whether the delivery originated from a backorder — used to track backorder fulfilment velocity."
    - name: "planned_delivery_month"
      expr: DATE_TRUNC('MONTH', planned_delivery_date)
      comment: "Month of the planned delivery date — primary time dimension for delivery volume and performance trending."
    - name: "actual_delivery_month"
      expr: DATE_TRUNC('MONTH', actual_delivery_date)
      comment: "Month of the actual delivery date — used alongside planned month to compute on-time delivery rates."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Flag for hazardous material deliveries — used for compliance reporting and special handling cost analysis."
  measures:
    - name: "total_deliveries"
      expr: COUNT(1)
      comment: "Total number of outbound deliveries — baseline throughput KPI for logistics capacity and workload planning."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight cost across all deliveries — primary logistics cost KPI; drives carrier negotiation and mode optimisation decisions."
    - name: "total_freight_tax"
      expr: SUM(CAST(freight_tax_amount AS DOUBLE))
      comment: "Total freight tax across deliveries — required for tax compliance and total landed cost calculation."
    - name: "total_freight_total_amount"
      expr: SUM(CAST(freight_total_amount AS DOUBLE))
      comment: "Total all-in freight amount (cost + tax) — used for total logistics spend reporting and budget variance analysis."
    - name: "avg_freight_cost_per_delivery"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per delivery — benchmarking KPI for carrier efficiency; rising averages trigger carrier or route reviews."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(total_gross_weight_kg AS DOUBLE))
      comment: "Total gross weight shipped in kg — used for freight cost normalisation (cost per kg) and load planning."
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total volume shipped in cubic metres — used for load factor analysis and warehouse throughput reporting."
    - name: "partial_delivery_rate"
      expr: SUM(CASE WHEN is_partial_delivery = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0)
      comment: "Proportion of deliveries that are partial — high rates indicate supply shortfalls or order splitting issues impacting customer satisfaction."
    - name: "on_time_delivery_count"
      expr: SUM(CASE WHEN actual_delivery_date <= planned_delivery_date THEN 1 ELSE 0 END)
      comment: "Count of deliveries completed on or before the planned date — numerator for on-time delivery rate calculation."
    - name: "late_delivery_count"
      expr: SUM(CASE WHEN actual_delivery_date > planned_delivery_date THEN 1 ELSE 0 END)
      comment: "Count of deliveries completed after the planned date — operational risk KPI; high counts trigger carrier and fulfilment process reviews."
    - name: "avg_freight_cost_per_kg"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_gross_weight_kg AS DOUBLE)), 0)
      comment: "Freight cost per kilogram shipped — normalised efficiency KPI for carrier benchmarking and mode selection decisions."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_rma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return Merchandise Authorisation (RMA) metrics covering return volumes, credit values, return reasons, and warranty claims. Used by Customer Service, Quality, and Finance to manage return rates, credit exposure, and product quality feedback loops."
  source: "`vibe_manufacturing_v1`.`order`.`order_rma`"
  dimensions:
    - name: "order_rma_status"
      expr: order_rma_status
      comment: "Current status of the RMA (e.g. Pending, Approved, Received, Closed) — primary dimension for return pipeline management."
    - name: "rma_type"
      expr: rma_type
      comment: "Type of return (e.g. Defective, Wrong Item, Overship, Warranty) — used to categorise return root causes and drive corrective actions."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Standardised reason code for the return — primary dimension for root cause analysis and supplier/production feedback."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the RMA request — used to track authorisation cycle times and approval bottlenecks."
    - name: "is_warranty_claim"
      expr: is_warranty_claim
      comment: "Flag indicating whether the return is a warranty claim — used to segment warranty liability exposure from commercial returns."
    - name: "is_damaged"
      expr: is_damaged
      comment: "Flag indicating whether returned goods are damaged — used to assess carrier damage rates and packaging quality."
    - name: "is_repairable"
      expr: is_repairable
      comment: "Flag indicating whether the returned item can be repaired — used to optimise disposition decisions and recovery value."
    - name: "return_plant"
      expr: return_plant
      comment: "Plant receiving the return — used to analyse return volumes and processing capacity by facility."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month the RMA was requested — primary time dimension for return rate trending and seasonality analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the RMA credit — required for multi-currency credit exposure reporting."
  measures:
    - name: "total_rma_requests"
      expr: COUNT(1)
      comment: "Total number of RMA requests — baseline return volume KPI; rising counts signal product quality or fulfilment issues."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit value issued for returns — primary financial exposure KPI for RMA; drives credit reserve and cash flow planning."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued — measures cash outflow from returns; used in financial reconciliation and customer satisfaction analysis."
    - name: "total_handling_fee_revenue"
      expr: SUM(CAST(handling_fee AS DOUBLE))
      comment: "Total handling fees charged on returns — measures cost recovery from return processing; low recovery rates indicate policy gaps."
    - name: "total_tax_on_returns"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount associated with RMAs — required for tax compliance and financial reconciliation of return transactions."
    - name: "total_net_return_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount of returned goods — used to calculate net return rate as a percentage of total revenue."
    - name: "warranty_claim_count"
      expr: SUM(CASE WHEN is_warranty_claim = TRUE THEN 1 ELSE 0 END)
      comment: "Number of warranty-related returns — warranty liability KPI; high counts trigger product quality and engineering reviews."
    - name: "damaged_return_count"
      expr: SUM(CASE WHEN is_damaged = TRUE THEN 1 ELSE 0 END)
      comment: "Number of returns involving damaged goods — used to assess carrier damage rates and packaging adequacy."
    - name: "avg_credit_per_rma"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average credit amount per RMA — used to benchmark return value and identify high-value return patterns requiring policy review."
    - name: "distinct_customers_returning"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers submitting RMAs — measures return breadth; high concentration in few customers signals targeted quality or service issues."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_goods_issue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods issue metrics covering inventory outflow values, quantities, and posting performance. Used by Supply Chain, Finance, and Warehouse Operations to track inventory consumption, cost of goods issued, and posting accuracy."
  source: "`vibe_manufacturing_v1`.`order`.`goods_issue`"
  dimensions:
    - name: "goods_issue_status"
      expr: goods_issue_status
      comment: "Status of the goods issue posting (e.g. Posted, Reversed, Pending) — primary dimension for goods issue pipeline and reversal analysis."
    - name: "movement_type"
      expr: movement_type
      comment: "Inventory movement type (e.g. 601 Delivery, 551 Scrapping) — used to categorise goods issue by business purpose."
    - name: "plant"
      expr: plant
      comment: "Plant from which goods were issued — enables inventory outflow analysis by production or distribution facility."
    - name: "storage_location"
      expr: storage_location
      comment: "Storage location within the plant — used for granular inventory depletion analysis."
    - name: "quality_status"
      expr: quality_status
      comment: "Quality status at time of goods issue — used to track quality-hold releases and non-conforming goods issuances."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the goods issue valuation — required for multi-currency COGS reporting."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating whether the goods issue has been reversed — used to measure posting error rates and reversal volumes."
    - name: "is_automated"
      expr: is_automated
      comment: "Flag indicating whether the goods issue was system-automated — used to track automation adoption and manual intervention rates."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_timestamp)
      comment: "Month of the goods issue posting — primary time dimension for COGS and inventory outflow trending."
    - name: "incoterms"
      expr: incoterms
      comment: "Trade terms at time of goods issue — used for logistics cost attribution and risk transfer analysis."
  measures:
    - name: "total_goods_issues"
      expr: COUNT(1)
      comment: "Total number of goods issue postings — baseline throughput KPI for warehouse and inventory operations."
    - name: "total_goods_issue_value"
      expr: SUM(CAST(total_value_cost AS DOUBLE))
      comment: "Total value of goods issued — primary COGS proxy KPI; used in financial reporting and inventory valuation reconciliation."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount of goods issued — used for revenue recognition and financial close processes."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on goods issued — required for tax compliance and financial reconciliation."
    - name: "total_quantity_issued"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of goods issued — volume KPI for inventory depletion tracking and supply planning."
    - name: "avg_goods_issue_value"
      expr: AVG(CAST(total_value_cost AS DOUBLE))
      comment: "Average value per goods issue posting — used to benchmark transaction size and identify anomalous high-value postings."
    - name: "reversal_count"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reversed goods issues — posting quality KPI; high reversal rates indicate data entry errors or process failures."
    - name: "reversal_rate"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0)
      comment: "Proportion of goods issues that were reversed — process quality KPI; high rates trigger root cause investigation of posting errors."
    - name: "automated_issue_rate"
      expr: SUM(CASE WHEN is_automated = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0)
      comment: "Proportion of goods issues processed automatically — automation adoption KPI; low rates indicate manual processing bottlenecks."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_fulfillment_sla`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fulfilment SLA configuration and coverage metrics. Used by Customer Service, Sales, and Supply Chain leadership to ensure SLA agreements are current, appropriately scoped, and aligned with customer commitments."
  source: "`vibe_manufacturing_v1`.`order`.`fulfillment_sla`"
  dimensions:
    - name: "fulfillment_sla_status"
      expr: fulfillment_sla_status
      comment: "Status of the SLA agreement (e.g. Active, Expired, Draft) — primary dimension for SLA coverage and expiry management."
    - name: "sla_type"
      expr: sla_type
      comment: "Type of SLA (e.g. On-Time Delivery, Lead Time, Order Confirmation) — used to segment SLA performance by commitment category."
    - name: "applicable_product_category_code"
      expr: applicable_product_category_code
      comment: "Product category the SLA applies to — used to analyse SLA coverage gaps by product line."
    - name: "expedite_eligible"
      expr: expedite_eligible
      comment: "Flag indicating whether expedite options are available under this SLA — used to assess premium service coverage."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the SLA became effective — used for SLA lifecycle and renewal tracking."
    - name: "effective_end_month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
      comment: "Month the SLA expires — used to proactively identify SLAs approaching expiry requiring renewal."
    - name: "sla_version"
      expr: sla_version
      comment: "Version of the SLA — used to track SLA evolution and ensure customers are on current terms."
  measures:
    - name: "total_sla_agreements"
      expr: COUNT(1)
      comment: "Total number of fulfilment SLA agreements — coverage KPI; gaps indicate customers without formal service commitments."
    - name: "active_sla_count"
      expr: SUM(CASE WHEN fulfillment_sla_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of currently active SLA agreements — measures live SLA coverage across the customer base."
    - name: "avg_on_time_delivery_threshold_pct"
      expr: AVG(CAST(on_time_delivery_threshold_pct AS DOUBLE))
      comment: "Average on-time delivery threshold committed across SLAs — used to benchmark service level commitments and identify overly aggressive SLAs."
    - name: "distinct_customers_with_sla"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers covered by a fulfilment SLA — SLA coverage breadth KPI; low coverage signals commercial risk."
    - name: "expedite_eligible_sla_count"
      expr: SUM(CASE WHEN expedite_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Number of SLAs with expedite eligibility — used to assess premium service commitment exposure and associated cost risk."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_blanket_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Blanket order commitment and release performance metrics. Used by Procurement, Sales, and Supply Chain to manage long-term supply agreements, track release velocity against commitments, and identify under-utilised or over-committed blanket orders."
  source: "`vibe_manufacturing_v1`.`order`.`blanket_order`"
  dimensions:
    - name: "blanket_order_status"
      expr: blanket_order_status
      comment: "Current status of the blanket order (e.g. Active, Expired, Closed) — primary dimension for blanket order portfolio management."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of blanket order contract (e.g. Quantity, Value, JIT) — used to segment commitment analysis by contract structure."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the blanket order — required for multi-currency commitment and release value reporting."
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organisation managing the blanket order — enables commitment analysis by sales org."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel for the blanket order — used for channel-level commitment and release analysis."
    - name: "is_jit_enabled"
      expr: is_jit_enabled
      comment: "Flag indicating whether Just-In-Time releases are enabled — used to segment JIT vs. standard blanket order performance."
    - name: "release_frequency"
      expr: release_frequency
      comment: "Frequency of releases under the blanket order (e.g. Weekly, Monthly) — used to assess release cadence compliance."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the blanket order became effective — used for cohort analysis of blanket order performance over time."
    - name: "effective_until_month"
      expr: DATE_TRUNC('MONTH', effective_until)
      comment: "Month the blanket order expires — used to proactively manage renewal and avoid supply disruption."
    - name: "region"
      expr: region
      comment: "Geographic region of the blanket order — enables regional commitment and release analysis."
  measures:
    - name: "total_blanket_orders"
      expr: COUNT(1)
      comment: "Total number of blanket orders — portfolio size KPI for long-term supply agreement management."
    - name: "total_committed_value"
      expr: SUM(CAST(total_committed_value AS DOUBLE))
      comment: "Total value committed under blanket orders — primary financial commitment KPI for supply chain and finance planning."
    - name: "total_released_value"
      expr: SUM(CAST(cumulative_released_value AS DOUBLE))
      comment: "Total value released against blanket orders — measures actual consumption of committed supply agreements."
    - name: "total_committed_quantity"
      expr: SUM(CAST(total_committed_quantity AS DOUBLE))
      comment: "Total quantity committed under blanket orders — volume commitment KPI for supply planning and capacity reservation."
    - name: "total_released_quantity"
      expr: SUM(CAST(cumulative_released_quantity AS DOUBLE))
      comment: "Total quantity released against blanket orders — measures actual volume consumption vs. commitment."
    - name: "avg_committed_value_per_order"
      expr: AVG(CAST(total_committed_value AS DOUBLE))
      comment: "Average committed value per blanket order — used to benchmark contract size and identify outlier commitments."
    - name: "value_release_utilisation_rate"
      expr: SUM(CAST(cumulative_released_value AS DOUBLE)) / NULLIF(SUM(CAST(total_committed_value AS DOUBLE)), 0)
      comment: "Ratio of released value to committed value — commitment utilisation KPI; low rates signal over-commitment or demand shortfall requiring renegotiation."
    - name: "quantity_release_utilisation_rate"
      expr: SUM(CAST(cumulative_released_quantity AS DOUBLE)) / NULLIF(SUM(CAST(total_committed_quantity AS DOUBLE)), 0)
      comment: "Ratio of released quantity to committed quantity — volume utilisation KPI for blanket order efficiency analysis."
    - name: "distinct_customers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers with blanket orders — measures breadth of long-term supply agreement coverage."
    - name: "jit_enabled_order_count"
      expr: SUM(CASE WHEN is_jit_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Number of blanket orders with JIT releases enabled — measures JIT adoption and associated supply chain agility."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order amendment metrics covering change volumes, financial impact of revisions, and amendment cycle times. Used by Sales Operations, Customer Service, and Finance to manage order change complexity, renegotiation costs, and SLA compliance."
  source: "`vibe_manufacturing_v1`.`order`.`amendment`"
  dimensions:
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current status of the amendment (e.g. Pending, Approved, Rejected) — primary dimension for amendment pipeline management."
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (e.g. Quantity Change, Price Change, Delivery Date Change) — used to categorise change drivers and their financial impact."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the amendment — used to track authorisation cycle times and approval bottlenecks."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the amendment — primary dimension for root cause analysis of order changes."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the amendment is critical — used to prioritise high-impact changes for expedited processing."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the amendment — required for multi-currency financial impact reporting."
    - name: "amendment_month"
      expr: DATE_TRUNC('MONTH', amendment_timestamp)
      comment: "Month the amendment was submitted — primary time dimension for amendment volume trending."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority of the amendment — used to triage processing effort and escalation decisions."
  measures:
    - name: "total_amendments"
      expr: COUNT(1)
      comment: "Total number of order amendments — baseline change management KPI; high volumes signal order instability or customer demand volatility."
    - name: "total_original_amount"
      expr: SUM(CAST(original_amount AS DOUBLE))
      comment: "Total original order amount before amendments — baseline for measuring financial impact of changes."
    - name: "total_revised_amount"
      expr: SUM(CAST(revised_amount AS DOUBLE))
      comment: "Total revised order amount after amendments — used with original amount to compute net financial impact of order changes."
    - name: "total_quantity_change"
      expr: SUM(CAST(revised_quantity AS DOUBLE) - CAST(original_quantity AS DOUBLE))
      comment: "Net change in quantity across all amendments — measures demand volatility and its impact on supply planning."
    - name: "total_price_change"
      expr: SUM(CAST(revised_price AS DOUBLE) - CAST(original_price AS DOUBLE))
      comment: "Net change in price across all amendments — measures pricing renegotiation impact and commercial exposure."
    - name: "critical_amendment_count"
      expr: SUM(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END)
      comment: "Number of critical amendments — escalation KPI; high counts indicate significant order disruption requiring executive attention."
    - name: "avg_revised_amount"
      expr: AVG(CAST(revised_amount AS DOUBLE))
      comment: "Average revised order amount — used to benchmark amendment size and identify disproportionately large changes."
    - name: "distinct_orders_amended"
      expr: COUNT(DISTINCT order_header_id)
      comment: "Number of unique orders that have been amended — measures order change breadth; high rates indicate systemic order quality issues."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_proof_of_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Proof of delivery (POD) metrics covering delivery confirmation rates, quantity discrepancies, and billing reconciliation. Used by Logistics, Customer Service, and Finance to manage delivery disputes, invoice accuracy, and customer satisfaction."
  source: "`vibe_manufacturing_v1`.`order`.`delivery`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the billed amount — required for multi-currency billing reconciliation."
  measures:
    - name: "total_pod_records"
      expr: COUNT(1)
      comment: "Total number of proof of delivery records — baseline delivery confirmation volume KPI."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_schedule_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule line metrics covering confirmed delivery quantities, dates, and fulfilment accuracy at the sub-line level. Used by Supply Chain Planning and Customer Service to manage delivery commitments, backorder exposure, and MRP alignment."
  source: "`vibe_manufacturing_v1`.`order`.`line`"
  dimensions:
    - name: "backorder_indicator"
      expr: backorder_indicator
      comment: "Flag indicating whether the schedule line is on backorder — key supply risk dimension for backlog management."
    - name: "plant"
      expr: plant
      comment: "Plant fulfilling the schedule line — enables delivery performance analysis by production or distribution facility."
  measures:
    - name: "total_schedule_lines"
      expr: COUNT(1)
      comment: "Total number of schedule lines — baseline delivery commitment volume KPI for supply planning workload analysis."
    - name: "total_requested_quantity"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total quantity requested across schedule lines — demand volume KPI for supply planning and capacity allocation."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed for delivery — supply commitment KPI; gap to requested quantity measures supply shortfall."
    - name: "avg_confirmed_quantity"
      expr: AVG(CAST(confirmed_quantity AS DOUBLE))
      comment: "Average confirmed quantity per schedule line — used to benchmark delivery batch sizes and identify fulfilment pattern changes."
    - name: "backorder_line_count"
      expr: SUM(CASE WHEN backorder_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Number of schedule lines on backorder — supply risk KPI; high counts signal inventory or production shortfalls requiring escalation."
    - name: "schedule_line_fill_rate"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(requested_quantity AS DOUBLE)), 0)
      comment: "Ratio of confirmed to requested quantity at schedule line level — granular fulfilment accuracy KPI for supply chain performance management."
$$;