-- Schema for Domain: service | Business: Ecommerce | Version: v1_ecm
-- Generated on: 2026-05-04 23:24:13

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `ecommerce_ecm`.`service` COMMENT 'Manages customer support cases, RMA processing, returns and refunds workflows, customer inquiries, and service tickets. Tracks NPS, CSAT, resolution time, and support SLA compliance. Integrates with CRM for unified customer service experience and case management.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `ecommerce_ecm`.`service`.`service_support_case` (
    `service_support_case_id` BIGINT COMMENT 'Unique identifier for the customer support case or service ticket. Primary key for the service support case entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Account‑level case reporting KPI for B2B customers requires linking each support case directly to the billing account.',
    `agent_id` BIGINT COMMENT 'Reference to the customer service agent currently assigned to work on this case. May be null if case is unassigned or in queue.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Required for Campaign Effectiveness Support Impact Report linking each support case to the marketing campaign that caused the issue.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Support case investigations often need the carrier responsible for the shipment to resolve delivery issues; agents reference carrier_id for accurate root‑cause analysis.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_service. Business justification: When a case concerns service level or transit time, the specific carrier service used must be known for SLA compliance reporting.',
    `center_id` BIGINT COMMENT 'Foreign key linking to fulfillment.center. Business justification: Support cases often arise from issues at a specific fulfillment center (e.g., inventory or pickup problems); linking enables Center‑Level case reporting and SLA tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost allocation report requires each support case to be charged to a cost center for internal accounting.',
    `fulfillment_shipment_id` BIGINT COMMENT 'Foreign key linking to fulfillment.shipment. Business justification: Customer service cases about delivery delays, tracking errors, or lost parcels need a direct reference to the shipment for root‑cause analysis and compensation decisions.',
    `header_id` BIGINT COMMENT 'Reference to the order associated with this support case, if the case relates to a specific order (e.g., shipping issue, order cancellation, item defect).',
    `item_id` BIGINT COMMENT 'Foreign key linking to content.content_item. Business justification: Support Case Investigation process records the specific content item that triggered the case, enabling root‑cause analysis and content quality reports.',
    `knowledge_article_id` BIGINT COMMENT 'Reference to the knowledge base article used to resolve this case. Links case resolution to documented solutions for knowledge management and self-service improvement.',
    `lead_id` BIGINT COMMENT 'Foreign key linking to marketing.lead. Business justification: Needed for Lead‑to‑Support Conversion tracking, showing which marketing leads become support cases.',
    `marketplace_transaction_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace_transaction. Business justification: Required for support case reporting: each case must reference the specific marketplace transaction that triggered the issue, enabling accurate SLA tracking and root‑cause analysis.',
    `parent_case_service_support_case_id` BIGINT COMMENT 'Reference to a parent case if this case is a child or follow-up case. Used for linking related cases and tracking case hierarchies (e.g., original case and subsequent escalation or related inquiry).',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability analysis of support services links cases to profit centers to measure contribution.',
    `promotional_campaign_id` BIGINT COMMENT 'Foreign key linking to pricing.promotional_campaign. Business justification: Required for Promotion Impact on Support Cases report, linking each case to the promotional campaign that triggered the purchase, enabling analysis of support volume per campaign.',
    `regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulation. Business justification: Privacy incident case tracking requires linking each support case to the specific regulation (e.g., GDPR) for reporting and audit compliance.',
    `rma_id` BIGINT COMMENT 'Reference to the RMA record if this support case resulted in or is associated with a product return authorization.',
    `seller_profile_id` BIGINT COMMENT 'Reference to the marketplace seller if this case involves a third-party seller transaction or marketplace dispute. Null for first-party sales.',
    `sku_id` BIGINT COMMENT 'Stock Keeping Unit of the product related to this support case, if the case involves a specific product (e.g., defect, return, compatibility issue).',
    `assigned_queue` STRING COMMENT 'The service queue or team to which this case is currently assigned (e.g., Tier1_Support, Billing_Team, Returns_Processing, Escalations, VIP_Support).',
    `case_number` STRING COMMENT 'Externally visible unique case identifier displayed to customers and agents. Typically follows a format like CS-12345678 or CASE-0001234567.. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `case_type` STRING COMMENT 'Classification of the support case by the nature of the customer issue: billing inquiry, shipping problem, product defect, account access issue, returns processing, refund request, marketplace dispute, or general inquiry. [ENUM-REF-CANDIDATE: billing|shipping|product_defect|account_access|returns|refund|marketplace_dispute|general_inquiry — 8 candidates stripped; promote to reference product]',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the case was formally closed and removed from active case inventory. May occur after resolution once customer confirms satisfaction or after a waiting period.',
    `compensation_amount` DECIMAL(18,2) COMMENT 'Monetary compensation or goodwill credit provided to the customer as part of case resolution (e.g., account credit, discount voucher, refund). Null if no compensation was provided.',
    `contact_attempts` STRING COMMENT 'Number of times the support team attempted to contact the customer regarding this case. Used for tracking customer responsiveness and case aging.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the country from which the customer initiated the support case (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the support case was first created in the system. Marks the beginning of the case lifecycle and SLA clock.',
    `csat_score` DECIMAL(18,2) COMMENT 'Customer satisfaction score collected after case resolution, typically on a scale of 1.00 to 5.00. Measures customer satisfaction with the support experience and resolution quality.',
    `customer_entitlement_tier` STRING COMMENT 'The service entitlement level of the customer at the time the case was created: standard (basic support), premium (priority support), VIP (dedicated support), enterprise (white-glove service). Influences SLA targets and routing.. Valid values are `standard|premium|vip|enterprise`',
    `escalation_status` STRING COMMENT 'Indicates whether and to what level the case has been escalated: not_escalated (standard handling), tier2 (specialist support), tier3 (expert/engineering), management (supervisor review), executive (C-level attention).. Valid values are `not_escalated|tier2|tier3|management|executive`',
    `feedback_comments` STRING COMMENT 'Free-text feedback comments provided by the customer in post-case surveys. Captures qualitative insights about the support experience, agent performance, and areas for improvement.',
    `first_response_timestamp` TIMESTAMP COMMENT 'Date and time when the first substantive response was provided to the customer by an agent. Key SLA metric for measuring initial response time.',
    `interaction_count` STRING COMMENT 'Total number of customer-agent interactions (calls, emails, chats) associated with this case. Indicates case complexity and effort required for resolution.',
    `is_vip_case` BOOLEAN COMMENT 'Boolean flag indicating whether this case involves a VIP or high-value customer requiring special handling, expedited service, or executive attention. True for VIP cases, False otherwise.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the language in which the case was handled (e.g., en for English, es for Spanish, fr for French).. Valid values are `^[a-z]{2}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to any field in the case record. Used for tracking case activity and audit purposes.',
    `nps_score` STRING COMMENT 'Net Promoter Score collected from the customer after case resolution, on a scale of 0 to 10. Measures customer loyalty and likelihood to recommend the company based on the support experience.',
    `originating_channel` STRING COMMENT 'The customer service channel through which the case was initially created: phone call, email, live chat, social media (Twitter, Facebook), self-service portal, or mobile app.. Valid values are `phone|email|chat|social_media|self_service|mobile_app`',
    `outcome_disposition` STRING COMMENT 'Final disposition of the case: resolved (issue successfully addressed), unresolved (could not be resolved), duplicate (merged with another case), transferred (moved to another system or team), withdrawn (customer cancelled request).. Valid values are `resolved|unresolved|duplicate|transferred|withdrawn`',
    `priority_level` STRING COMMENT 'Business priority assigned to the case based on urgency and impact. P1 (critical/urgent), P2 (high), P3 (medium), P4 (low). Determines SLA targets and routing rules.. Valid values are `P1|P2|P3|P4`',
    `reopened_count` STRING COMMENT 'Number of times this case has been reopened after being marked as resolved or closed. Indicates resolution quality issues or recurring customer problems.',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the resolution provided to the customer, actions taken, root cause identified, and any follow-up required. Populated when case is resolved or closed.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the case was marked as resolved, indicating that a solution was provided to the customer. Key SLA metric for measuring time-to-resolution.',
    `root_cause_category` STRING COMMENT 'Classification of the underlying root cause identified during case resolution (e.g., system_error, process_gap, product_defect, user_error, policy_exception, carrier_issue). Used for trend analysis and continuous improvement. [ENUM-REF-CANDIDATE: system_error|process_gap|product_defect|user_error|policy_exception|carrier_issue|payment_failure|inventory_issue|data_quality — promote to reference product]',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Automated sentiment analysis score derived from customer communications (emails, chat transcripts) during the case lifecycle. Scale typically -1.00 (very negative) to +1.00 (very positive).',
    `service_support_case_description` STRING COMMENT 'Detailed description of the customer issue, inquiry, or request as captured during case creation. May include customer-provided details, agent notes, and initial diagnostic information.',
    `service_support_case_status` STRING COMMENT 'Current lifecycle status of the support case: new (just created), open (assigned), pending_customer (awaiting customer response), pending_internal (awaiting internal action), in_progress (actively being worked), escalated (moved to higher tier), resolved (solution provided), closed (finalized), cancelled (withdrawn). [ENUM-REF-CANDIDATE: new|open|pending_customer|pending_internal|in_progress|escalated|resolved|closed|cancelled — 9 candidates stripped; promote to reference product]',
    `sla_breach_flag` BOOLEAN COMMENT 'Boolean indicator of whether this case breached its SLA targets for first response time or resolution time. True indicates SLA was breached, False indicates SLA was met.',
    `sla_policy_code` STRING COMMENT 'Reference code for the SLA policy governing response and resolution time targets for this case, based on customer tier, case priority, and case type.',
    `subject` STRING COMMENT 'Brief summary or subject line describing the customer issue or inquiry. Typically 100-200 characters.',
    CONSTRAINT pk_service_support_case PRIMARY KEY(`service_support_case_id`)
) COMMENT 'Core master entity representing a customer support case or service ticket. Tracks the full lifecycle from creation through resolution including case type (billing, shipping, product defect, account access, returns, marketplace dispute referral), priority level (P1-P4), originating channel (phone, email, chat, social, self-service), assigned agent, current queue, escalation status, SLA policy reference, customer entitlement tier, first response timestamp, resolution timestamp, CSAT score, NPS score, and outcome disposition (resolved, unresolved, duplicate, transferred). Serves as the central operational record linking all service interactions, escalations, RMAs, refunds, and feedback for a single customer issue.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`service`.`case_interaction` (
    `case_interaction_id` BIGINT COMMENT 'Unique identifier for the case interaction record. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Interaction logs are aggregated by account to compute enterprise support metrics and SLA compliance per account.',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the customer involved in this interaction. Links to customer master entity.',
    `marketplace_transaction_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace_transaction. Business justification: Interaction logs need the transaction context to surface correct communication history in support dashboards.',
    `agent_id` BIGINT COMMENT 'Identifier of the customer service agent who handled this interaction. Links to employee or agent entity.',
    `service_support_case_id` BIGINT COMMENT 'Reference to the parent support case that this interaction belongs to. Links to the service case entity.',
    `attachment_count` STRING COMMENT 'Number of file attachments associated with this interaction (screenshots, documents, logs).',
    `attachment_references` STRING COMMENT 'Comma-separated list of attachment identifiers or URIs pointing to files stored in external document management system.',
    `channel` STRING COMMENT 'The communication channel through which the interaction occurred: phone, email, live chat, mobile app, web portal, or social media platform.. Valid values are `phone|email|live_chat|mobile_app|web_portal|social_media`',
    `contact_method` STRING COMMENT 'The specific contact method used for this interaction (phone number, email address, chat handle, social media handle).',
    `content_summary` STRING COMMENT 'Summarized content or transcript of the interaction, capturing key points discussed without full verbatim text.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the country from which the interaction originated (e.g., USA, GBR, CAN).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this interaction record was first created in the system in the format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `csat_score` STRING COMMENT 'Customer Satisfaction (CSAT) score provided by the customer for this specific interaction, typically on a scale of 1-5 or 1-10.',
    `direction` STRING COMMENT 'Direction of the interaction: inbound (customer-initiated) or outbound (agent-initiated).. Valid values are `inbound|outbound`',
    `duration_seconds` STRING COMMENT 'Total duration of the interaction in seconds, applicable for calls and chat sessions.',
    `escalation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this interaction resulted in an escalation to a higher support tier or management (True/False).',
    `escalation_reason` STRING COMMENT 'Reason or justification for escalating the interaction, if escalation occurred.',
    `external_interaction_reference` STRING COMMENT 'Unique identifier for this interaction in the external source system, used for cross-system reconciliation and traceability.',
    `feedback_comment` STRING COMMENT 'Free-text feedback or comment provided by the customer about this interaction.',
    `full_transcript_reference` STRING COMMENT 'Reference pointer or URI to the full transcript or recording stored in external system (e.g., CDN (Content Delivery Network), document management system).',
    `interaction_number` STRING COMMENT 'Human-readable business identifier for the interaction, typically formatted as INT- followed by numeric sequence.. Valid values are `^INT-[0-9]{8,12}$`',
    `interaction_sequence` STRING COMMENT 'Sequential ordering of this interaction within the parent case lifecycle, starting from 1.',
    `interaction_status` STRING COMMENT 'Current status of the interaction: completed, pending follow-up, escalated to higher tier, abandoned by customer, or transferred to another agent.. Valid values are `completed|pending|escalated|abandoned|transferred`',
    `interaction_timestamp` TIMESTAMP COMMENT 'The exact date and time when the interaction event occurred in the format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `interaction_type` STRING COMMENT 'The type or category of interaction event: call, email, chat, SMS, social media, or web form submission.. Valid values are `call|email|chat|sms|social_media|web_form`',
    `internal_notes` STRING COMMENT 'Internal notes or comments added by the agent for internal reference, not visible to the customer.',
    `language_code` STRING COMMENT 'Three-letter ISO 639-2 language code representing the language used in the interaction (e.g., ENG for English, SPA for Spanish).. Valid values are `^[A-Z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this interaction record was last modified or updated in the format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `nps_score` STRING COMMENT 'Net Promoter Score (NPS) provided by the customer for this interaction, typically on a scale of 0-10.',
    `outcome` STRING COMMENT 'The outcome or result of the interaction: resolved, unresolved, escalated, referred to another department, information provided, or callback scheduled.. Valid values are `resolved|unresolved|escalated|referred|information_provided|callback_scheduled`',
    `priority` STRING COMMENT 'Priority level assigned to this interaction: low, medium, high, or critical.. Valid values are `low|medium|high|critical`',
    `resolution_provided_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a resolution or answer was provided during this interaction (True/False).',
    `response_time_seconds` STRING COMMENT 'Time in seconds taken by the agent to provide the first substantive response after interaction initiation.',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Automated sentiment analysis score for the interaction, typically ranging from -1.00 (negative) to +1.00 (positive), derived from NLP (Natural Language Processing) analysis of interaction content.',
    `sla_breach_reason` STRING COMMENT 'Reason or explanation for SLA (Service Level Agreement) breach, if the interaction did not meet SLA targets.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this interaction met the defined SLA (Service Level Agreement) targets for response and resolution time (True/False).',
    `source_system` STRING COMMENT 'Name or identifier of the source system that captured this interaction (e.g., CRM (Customer Relationship Management), call center platform, chat system).',
    `subject` STRING COMMENT 'Brief subject line or title summarizing the purpose or topic of the interaction.',
    `tags` STRING COMMENT 'Comma-separated list of tags or labels applied to categorize or classify the interaction (e.g., billing, technical, complaint, refund).',
    `transfer_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the interaction was transferred to another agent or department (True/False).',
    `wait_time_seconds` STRING COMMENT 'Time in seconds the customer waited before the interaction was answered or acknowledged by an agent.',
    CONSTRAINT pk_case_interaction PRIMARY KEY(`case_interaction_id`)
) COMMENT 'Transactional record capturing every individual interaction or communication event within a support case lifecycle. Tracks inbound and outbound messages, call logs, chat transcripts, email threads, internal notes, and agent responses. Stores interaction channel, direction (inbound/outbound), agent ID, timestamp, content summary, attachment references, and interaction outcome. Enables full audit trail of case communications and supports agent performance measurement.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`service`.`rma` (
    `rma_id` BIGINT COMMENT 'Unique identifier for the return merchandise authorization record. Primary key for the RMA entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: RMA processing often needs the customers account to validate credit limits and apply account‑level return policies.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Return processing reports require linking each RMA to the carrier handling the return; replaces the free‑text return_carrier field.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_service. Business justification: Return RMA tracking includes the specific carrier service tier used, enabling cost and SLA analysis for returned shipments.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Return processing costs are allocated to cost centers for internal budgeting and expense tracking.',
    `customer_profile_id` BIGINT COMMENT 'Reference to the customer initiating the return. Links RMA to the customer master record for service history and analytics.',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order. Business justification: RMA processing requires the original fulfillment order to reconcile inventory, validate return eligibility, and generate accurate financial adjustments.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Return management must verify compliance with consumer protection obligations; linking each RMA to its compliance_obligation enables audit of policy adherence.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability of return handling is measured by linking each RMA to a profit center.',
    `warehouse_node_id` BIGINT COMMENT 'Reference to the warehouse facility designated to receive and process the returned item. Used for routing and capacity planning.',
    `approval_required` BOOLEAN COMMENT 'Flag indicating whether this RMA requires manual approval by customer service or management. Triggered by policy exceptions or high-value returns.',
    `approved_by_user_code` BIGINT COMMENT 'Reference to the customer service representative or manager who approved the RMA request. Used for audit trail and performance tracking.',
    `approved_date` DATE COMMENT 'Date when the RMA request was approved by the system or customer service. Marks the start of the return fulfillment process.',
    `closed_date` DATE COMMENT 'Date when the RMA case was fully closed and all associated workflows completed. Marks the end of the return lifecycle for reporting purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the RMA record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this RMA record. Ensures consistent financial reporting across multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `customer_declared_condition` STRING COMMENT 'Condition of the returned item as declared by the customer at the time of RMA request. Used for initial eligibility assessment and compared against inspection findings.. Valid values are `unopened|opened_unused|lightly_used|heavily_used|damaged|defective`',
    `customer_service_notes` STRING COMMENT 'Free-text notes entered by customer service representatives regarding the RMA case. Captures context, customer interactions, and special handling instructions.',
    `disposition_decision` STRING COMMENT 'Final decision on how the returned item will be handled post-inspection. Drives inventory allocation, financial write-offs, and reverse logistics.. Valid values are `restock|liquidate|destroy|return_to_vendor|donate|refurbish`',
    `expected_return_date` DATE COMMENT 'Estimated date by which the returned item is expected to arrive at the warehouse. Used for receiving planning and exception alerts.',
    `inspected_condition` STRING COMMENT 'Actual condition of the returned item as determined by warehouse inspection team. Used to validate customer declaration and determine disposition.. Valid values are `as_new|good|acceptable|damaged|defective|not_as_described`',
    `inspection_completed_date` DATE COMMENT 'Date when the warehouse inspection of the returned item was completed. Triggers disposition decision and refund processing.',
    `inspection_notes` STRING COMMENT 'Free-text notes entered by warehouse inspection team regarding the physical condition and findings of the returned item.',
    `inspection_status` STRING COMMENT 'Current status of the physical inspection process for the returned item. Tracks warehouse receiving and quality control workflow.. Valid values are `not_started|in_progress|completed|failed`',
    `is_within_policy` BOOLEAN COMMENT 'Flag indicating whether the RMA request complies with the applicable return policy rules. Used for auto-approval workflows and exception handling.',
    `label_issued_date` DATE COMMENT 'Date when the return shipping label was generated and provided to the customer. Used for tracking customer action and carrier pickup scheduling.',
    `label_paid_by` STRING COMMENT 'Party responsible for paying the return shipping cost. Determines financial settlement and customer experience.. Valid values are `customer|merchant|carrier|third_party`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the RMA record was last modified. Used for change tracking and data synchronization across systems.',
    `received_date` DATE COMMENT 'Actual date when the returned item was physically received at the warehouse. Triggers inspection workflow and service level measurement.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Total monetary amount to be refunded to the customer in the transaction currency. May differ from original order amount due to restocking fees or partial returns.',
    `refund_method` STRING COMMENT 'Method by which the refund will be issued to the customer. Drives payment processing workflow and customer communication.. Valid values are `original_payment|store_credit|gift_card|bank_transfer|check`',
    `refund_processed_date` DATE COMMENT 'Date when the refund transaction was successfully processed and funds were released to the customer. Used for financial reconciliation and customer satisfaction tracking.',
    `refund_status` STRING COMMENT 'Current status of the refund transaction. Tracks financial settlement workflow and customer notification triggers.. Valid values are `pending|processing|completed|failed|cancelled`',
    `requested_date` DATE COMMENT 'Date when the customer initiated the RMA request. Used for return window calculation and service level tracking.',
    `restocking_fee` DECIMAL(18,2) COMMENT 'Fee charged to the customer for processing the return, deducted from the refund amount. Applied per return policy and product category.',
    `return_label_cost` DECIMAL(18,2) COMMENT 'Cost of the return shipping label in the transaction currency. Used for return cost analysis and customer charge-back decisions.',
    `return_reason_code` STRING COMMENT 'Standardized code indicating the primary reason for the return. Used for root cause analysis, product quality tracking, and return rate analytics. [ENUM-REF-CANDIDATE: defective|wrong_item|not_as_described|damaged_in_transit|no_longer_needed|size_fit_issue|buyer_remorse|duplicate_order|late_delivery|other — 10 candidates stripped; promote to reference product]',
    `return_tracking_number` STRING COMMENT 'Carrier-provided tracking number for the return shipment. Enables real-time visibility into return transit status.',
    `return_type` STRING COMMENT 'Classification of the return resolution method requested by the customer or determined by policy. Drives downstream financial and fulfillment workflows.. Valid values are `refund|exchange|store_credit|replacement`',
    `return_window_days` STRING COMMENT 'Number of days from original order delivery date within which the return must be initiated per policy. Used for eligibility validation.',
    `rma_number` STRING COMMENT 'Business-facing unique RMA number displayed to customers and customer service representatives. Externally-known identifier for tracking return authorization.. Valid values are `^RMA-[0-9]{8,12}$`',
    `rma_status` STRING COMMENT 'Current lifecycle status of the RMA. Tracks the return authorization workflow from initial request through final disposition. [ENUM-REF-CANDIDATE: pending_approval|approved|rejected|label_issued|in_transit|received|inspecting|completed|cancelled — 9 candidates stripped; promote to reference product]',
    CONSTRAINT pk_rma PRIMARY KEY(`rma_id`)
) COMMENT 'Return Merchandise Authorization master record managing the end-to-end RMA lifecycle for e-commerce returns. Captures RMA number, originating order reference, return reason code, return type (refund, exchange, store credit), customer-declared condition, carrier return label details, expected return window, actual receipt date, inspection status, disposition decision (restock, liquidate, destroy), and financial settlement status. SSOT for all return authorization records across the platform.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`service`.`rma_line` (
    `rma_line_id` BIGINT COMMENT 'Unique identifier for the RMA line item. Primary key for the RMA line detail record.',
    `catalog_item_id` BIGINT COMMENT 'Reference to the product master record for the item being returned. Links to the product catalog.',
    `header_id` BIGINT COMMENT 'Reference to the new order created for the exchange shipment, if applicable. Links the return to the replacement order.',
    `line_id` BIGINT COMMENT 'Reference to the original order line item being returned. Links the return to the original purchase transaction.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Operational need: returned items must be tied to the exact lot they originated from; adding lot_id replaces lot_number for precise inventory reconciliation.',
    `rma_id` BIGINT COMMENT 'Reference to the parent RMA authorization under which this line item is processed. Links this line to the RMA header.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Needed for accurate inventory and refund calculations; RMA line must reference the SKU entity to determine restocking fees, unit price, and stock adjustments.',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the specific warehouse location where the returned item was received and inspected. Supports multi-warehouse return processing.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this RMA line record was first created in the system. Supports audit trail and lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this line. Ensures proper currency handling for international returns.. Valid values are `^[A-Z]{3}$`',
    `disposition_code` STRING COMMENT 'The final disposition decision for the returned item. Determines how the item will be handled after inspection and processing.. Valid values are `RESTOCK|LIQUIDATE|DISPOSE|RETURN_VENDOR|REPAIR|DONATE`',
    `exchange_requested_flag` BOOLEAN COMMENT 'Indicates whether the customer has requested an exchange rather than a refund for this item. True if exchange requested, false if refund only.',
    `exchange_sku` STRING COMMENT 'The SKU of the replacement product requested by the customer if this is an exchange. Null if this is a refund-only return.. Valid values are `^[A-Z0-9]{6,20}$`',
    `inspected_by_user_code` BIGINT COMMENT 'Reference to the warehouse staff member who performed the inspection of this returned item. Supports quality control and accountability.',
    `inspected_date` DATE COMMENT 'The date the returned item completed quality inspection. Marks the completion of the inspection process and readiness for disposition.',
    `inspection_notes` STRING COMMENT 'Detailed notes recorded by warehouse inspection staff regarding the condition, completeness, and quality of the returned item. Supports disposition decisions.',
    `item_condition_code` STRING COMMENT 'Standardized assessment of the physical condition of the returned item upon receipt at the warehouse. Determines restocking eligibility and disposition.. Valid values are `NEW_UNOPENED|NEW_OPENED|USED_LIKE_NEW|USED_GOOD|DAMAGED|DEFECTIVE`',
    `line_status` STRING COMMENT 'Current processing status of this RMA line item. Tracks the line through the return workflow from initial request to final disposition. [ENUM-REF-CANDIDATE: PENDING_RECEIPT|RECEIVED|INSPECTING|APPROVED|REJECTED|REFUNDED|EXCHANGED|CLOSED — 8 candidates stripped; promote to reference product]',
    `line_subtotal` DECIMAL(18,2) COMMENT 'The total amount for this line before taxes and fees, calculated as unit price multiplied by quantity approved. Represents the base refund amount.',
    `line_tax_amount` DECIMAL(18,2) COMMENT 'The tax amount to be refunded for this line item. Calculated based on the approved quantity and applicable tax rates.',
    `quantity_approved` STRING COMMENT 'The number of units approved for refund or exchange after inspection. May be less than quantity received if some units fail inspection criteria.',
    `quantity_received` STRING COMMENT 'The actual number of units physically received back from the customer for this SKU. May differ from quantity requested if customer sends partial return.',
    `quantity_requested` STRING COMMENT 'The number of units the customer has requested to return for this SKU. Represents the customers initial return request quantity.',
    `received_date` DATE COMMENT 'The date the returned item was physically received at the warehouse. Used for Service Level Agreement (SLA) tracking and refund processing timelines.',
    `refund_amount` DECIMAL(18,2) COMMENT 'The total refund amount for this line item including subtotal, tax, minus any restocking fees. Represents the actual amount to be credited to the customer.',
    `refund_processed_date` DATE COMMENT 'The date the refund for this line item was processed and initiated to the customers payment method. Marks completion of the financial return transaction.',
    `rejection_reason` STRING COMMENT 'Explanation for why this line item was rejected for refund or exchange, if applicable. Provides transparency to customer and supports dispute resolution.',
    `restocking_eligible_flag` BOOLEAN COMMENT 'Indicates whether the returned item is in suitable condition to be restocked and resold as new inventory. True if eligible for resale, false if must be liquidated or disposed.',
    `restocking_fee_amount` DECIMAL(18,2) COMMENT 'The restocking fee charged to the customer for this line item, if applicable. Typically applied for non-defective returns or opened items per return policy.',
    `return_reason_code` STRING COMMENT 'Standardized code indicating why the customer is returning this specific item. Used for return analytics and quality improvement.. Valid values are `DEFECTIVE|WRONG_ITEM|NOT_AS_DESCRIBED|DAMAGED_SHIPPING|CHANGED_MIND|SIZE_FIT`',
    `return_reason_description` STRING COMMENT 'Detailed free-text explanation provided by the customer or service agent describing the specific reason for returning this item.',
    `serial_number` STRING COMMENT 'The unique serial number of the specific unit being returned, if applicable for serialized products. Enables unit-level tracking and warranty validation.',
    `sku` STRING COMMENT 'The specific product SKU being returned. Identifies the exact product variant at the most granular inventory level.. Valid values are `^[A-Z0-9]{6,20}$`',
    `unit_price` DECIMAL(18,2) COMMENT 'The original unit price paid by the customer for this SKU at the time of purchase. Used to calculate refund amounts.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this RMA line record was last modified. Tracks the most recent change to any field in the record.',
    CONSTRAINT pk_rma_line PRIMARY KEY(`rma_line_id`)
) COMMENT 'Line-item detail record for each SKU included in an RMA. Captures the specific product SKU, quantity requested for return, quantity actually received, unit return reason, item condition on receipt, restocking eligibility flag, refund amount per line, exchange SKU if applicable, and inspection notes. Supports multi-item returns under a single RMA authorization and enables SKU-level return analytics and inventory disposition.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`service`.`service_refund` (
    `service_refund_id` BIGINT COMMENT 'Unique identifier for the service refund record. Primary key for the service refund entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Refunds must be associated with the billing account for financial reconciliation and audit reporting.',
    `customer_profile_id` BIGINT COMMENT 'Reference to the customer receiving the refund or compensation. Links to the customer master record.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Refund transactions must be posted to the general ledger for financial reconciliation and reporting.',
    `header_id` BIGINT COMMENT 'Reference to the original order associated with this refund. Links the refund to the transaction being remediated.',
    `marketplace_transaction_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace_transaction. Business justification: Refunds are processed against the original marketplace transaction; linking provides auditability and financial reconciliation across systems.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Refund processing is subject to financial compliance (e.g., AML); associating refunds with the relevant compliance_obligation supports regulatory reporting.',
    `method_id` BIGINT COMMENT 'Foreign key linking to payment.payment_method. Business justification: Enables audit of refunds by payment method, supporting compliance reports and method‑level performance metrics.',
    `payment_transaction_id` BIGINT COMMENT 'Reference to the payment domain transaction record that executed the financial refund. Links service authorization to payment execution.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Needed for Refund Pricing Source Audit, tracking which price list was used for the original sale to ensure correct refund calculations and compliance.',
    `agent_id` BIGINT COMMENT 'Reference to the customer service agent who initiated the refund request. Links to the employee or agent record.',
    `rma_id` BIGINT COMMENT 'Reference to the RMA that initiated this refund or compensation. Links the refund to the originating return case.',
    `service_support_case_id` BIGINT COMMENT 'Reference to the customer service case that authorized this refund or compensation. Links to the support ticket or inquiry.',
    `amount` DECIMAL(18,2) COMMENT 'Monetary value of the refund or compensation issued to the customer. Represents the gross amount before any adjustments.',
    `approval_status` STRING COMMENT 'Authorization state of the refund request. Indicates whether the refund has been approved and by what authority level.. Valid values are `auto_approved|pending_approval|manager_approved|rejected|override_approved`',
    `approval_tier` STRING COMMENT 'Authorization level required for this refund based on amount thresholds. Defines the approval hierarchy tier.. Valid values are `tier_1_auto|tier_2_supervisor|tier_3_manager|tier_4_director|tier_5_executive`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the refund was authorized by the agent or manager. Null if still pending approval or if rejected.',
    `completed_timestamp` TIMESTAMP COMMENT 'Date and time when the refund was successfully settled and funds were returned to the customer. Marks the end of the refund lifecycle.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this refund record was first created in the system. Audit field for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the refund amount. Defines the monetary unit of the refund value.. Valid values are `^[A-Z]{3}$`',
    `customer_satisfaction_impact` STRING COMMENT 'Assessed impact of the refund on customer satisfaction based on follow-up surveys or agent assessment. Used for service quality tracking.. Valid values are `positive|neutral|negative|unknown`',
    `expiry_date` DATE COMMENT 'Date after which the compensation instrument (store credit, gift card, coupon) can no longer be redeemed. Null for direct refunds with no expiration.',
    `is_goodwill_gesture` BOOLEAN COMMENT 'Indicates whether the refund was issued as a proactive goodwill gesture rather than in response to a specific complaint or return. True for retention offers.',
    `is_retention_offer` BOOLEAN COMMENT 'Indicates whether the compensation was issued as part of a customer retention strategy to prevent churn. True for proactive retention gestures.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this refund record was most recently updated. Audit field for change tracking and data quality monitoring.',
    `loyalty_points_granted` STRING COMMENT 'Number of loyalty program points awarded as compensation. Zero if compensation was not in the form of loyalty points.',
    `manager_override_flag` BOOLEAN COMMENT 'Indicates whether the refund required manager override of standard policy or amount thresholds. True if exception was granted.',
    `net_refund_cost` DECIMAL(18,2) COMMENT 'Total cost to the business including refund amount and processing fees. Used for financial impact analysis and reporting.',
    `notes` STRING COMMENT 'Additional free-text notes or comments from service agents regarding the refund. Used for context and audit trail documentation.',
    `nps_survey_response` STRING COMMENT 'Customer NPS score (0-10) collected after refund resolution. Null if no survey response was received. Used for service quality measurement.',
    `original_payment_method_type` STRING COMMENT 'Type of payment method used in the original order. Used to determine refund routing and processing requirements. [ENUM-REF-CANDIDATE: credit_card|debit_card|paypal|bank_transfer|gift_card|store_credit|cash_on_delivery|buy_now_pay_later — 8 candidates stripped; promote to reference product]',
    `override_justification` STRING COMMENT 'Explanation provided by the approving manager for policy override or exception. Required when manager_override_flag is true.',
    `processed_timestamp` TIMESTAMP COMMENT 'Date and time when the refund was submitted to the payment system for execution. Marks handoff from service to payment domain.',
    `processing_fee` DECIMAL(18,2) COMMENT 'Fee charged by payment processor or financial institution for processing the refund transaction. Represents cost to business.',
    `reason_category` STRING COMMENT 'High-level categorization of why the refund or compensation was issued. Used for root cause analysis and service improvement. [ENUM-REF-CANDIDATE: defective_product|wrong_item_shipped|damaged_in_transit|late_delivery|service_failure|customer_dissatisfaction|pricing_error|goodwill_gesture|retention_offer|policy_exception — 10 candidates stripped; promote to reference product]',
    `reason_detail` STRING COMMENT 'Detailed explanation of the specific reason for issuing the refund or compensation. Free-text field for agent notes.',
    `redemption_code` STRING COMMENT 'Unique code issued for store credit, gift card, or coupon compensation. Used by customer to claim the value. Confidential business data.. Valid values are `^[A-Z0-9]{8,16}$`',
    `redemption_status` STRING COMMENT 'Tracks whether non-monetary compensation (store credit, gift card, coupon) has been used by the customer. Not applicable for direct refunds.. Valid values are `not_applicable|unredeemed|partially_redeemed|fully_redeemed|expired_unredeemed`',
    `redemption_value_remaining` DECIMAL(18,2) COMMENT 'Remaining unredeemed value for partial-use compensation instruments like store credit or gift cards. Null for one-time refunds.',
    `refund_method` STRING COMMENT 'Method by which the refund or compensation is delivered to the customer. Defines the channel for value return. [ENUM-REF-CANDIDATE: original_payment_method|store_credit|gift_card|bank_transfer|check|loyalty_account|promotional_code — 7 candidates stripped; promote to reference product]',
    `refund_number` STRING COMMENT 'Externally visible unique business identifier for the refund. Used in customer communications and tracking.. Valid values are `^RFD-[0-9]{10}$`',
    `remediation_type` STRING COMMENT 'Category of customer remediation issued. Defines the form of compensation provided to the customer. [ENUM-REF-CANDIDATE: full_refund|partial_refund|store_credit|gift_card|coupon_code|free_shipping_voucher|loyalty_points|goodwill_compensation — 8 candidates stripped; promote to reference product]',
    `requested_timestamp` TIMESTAMP COMMENT 'Date and time when the refund was initially requested by the customer or initiated by the service agent. Marks the start of the refund lifecycle.',
    `service_refund_status` STRING COMMENT 'Current lifecycle state of the refund. Tracks the refund through authorization, processing, and completion stages. [ENUM-REF-CANDIDATE: pending|approved|processing|completed|failed|redeemed|expired|cancelled — 8 candidates stripped; promote to reference product]',
    `settlement_reference_number` STRING COMMENT 'External reference number from the payment gateway or financial system confirming the refund transaction was settled. Links to payment domain records.',
    `source_system` STRING COMMENT 'Originating system or channel where the refund request was initiated. Used for data lineage and integration tracking. [ENUM-REF-CANDIDATE: crm|oms|rma_system|service_portal|call_center|chat_system|email_system — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_service_refund PRIMARY KEY(`service_refund_id`)
) COMMENT 'Transactional record representing all customer remediation, refunds, and compensation issued through the service domain. Covers full refunds, partial refunds, store credits, gift cards, coupon codes, free shipping vouchers, loyalty point grants, and goodwill compensation for service failures or proactive retention gestures. Tracks remediation type (refund, exchange credit, compensation, goodwill gesture, retention offer), amount/value, currency, method (original payment method, store credit, gift card), status lifecycle (pending, approved, processing, completed, failed, redeemed, expired), initiating RMA or case reference, approval workflow with authorization thresholds by amount tier, issuing agent, manager override flag, redemption status, expiry date, compensation reason category, and settlement confirmation reference. Owns the service-side authorization decision while payment domain owns financial execution. SSOT for all service-originated customer remediation and compensation records.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`service`.`agent` (
    `agent_id` BIGINT COMMENT 'Unique identifier for the customer service agent. Primary key for the agent entity.',
    `supervisor_agent_id` BIGINT COMMENT 'FK to service.agent',
    `active_status` STRING COMMENT 'Current employment and operational status of the agent. Determines whether the agent is eligible for case assignment.. Valid values are `active|inactive|on_leave|terminated|suspended`',
    `availability_status` STRING COMMENT 'Current real-time availability status of the agent. Used by the case routing engine to determine if the agent can accept new cases.. Valid values are `available|busy|on_break|in_meeting|offline|away`',
    `average_handle_time_minutes` DECIMAL(18,2) COMMENT 'Rolling average time in minutes the agent takes to resolve a case from assignment to closure. Key performance indicator for agent efficiency.',
    `certification_expiry_date` DATE COMMENT 'Date when the agents current service certification expires and requires renewal. Null if certification does not expire.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the agent record was first created in the service domain system. Audit field for data lineage.',
    `customer_satisfaction_score` DECIMAL(18,2) COMMENT 'Average customer satisfaction score for cases handled by this agent, typically on a 1-5 scale. Derived from post-interaction surveys.',
    `email_address` STRING COMMENT 'Corporate email address for the agent. Used for internal communication and system notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `employee_code` STRING COMMENT 'External employee identifier from the HR system. Links the agent to their employee record in the Enterprise Resource Planning (ERP) system.. Valid values are `^[A-Z0-9]{6,12}$`',
    `escalation_rate` DECIMAL(18,2) COMMENT 'Percentage of cases handled by the agent that required escalation to a supervisor or specialist. Lower rates indicate higher agent competency.',
    `first_contact_resolution_rate` DECIMAL(18,2) COMMENT 'Percentage of cases resolved by the agent on first contact without escalation or follow-up. Key quality metric for agent performance.',
    `full_name` STRING COMMENT 'Full legal name of the customer service agent as recorded in the HR system.',
    `hire_date` DATE COMMENT 'Date the agent was hired into the customer service organization. Used for tenure analysis and performance benchmarking.',
    `language_proficiencies` STRING COMMENT 'Comma-separated list of languages the agent can support with proficiency level (e.g., EN-native, ES-fluent, FR-conversational). Enables multilingual customer support routing.',
    `last_login_timestamp` TIMESTAMP COMMENT 'Timestamp of the agents most recent login to the customer service platform. Used for activity monitoring and availability tracking.',
    `max_concurrent_cases` STRING COMMENT 'Maximum number of cases the agent can handle simultaneously. Used by the workload balancing engine to prevent agent overload.',
    `net_promoter_score` DECIMAL(18,2) COMMENT 'Average Net Promoter Score (NPS) for interactions handled by this agent. Measures customer loyalty and likelihood to recommend based on agent service.',
    `performance_tier` STRING COMMENT 'Agent performance classification tier based on experience, skill level, and performance metrics. Used for case complexity routing and escalation paths.. Valid values are `tier_1|tier_2|tier_3|senior|lead|specialist`',
    `phone_extension` STRING COMMENT 'Internal phone extension number for the agent within the contact center phone system.. Valid values are `^[0-9]{3,6}$`',
    `quality_assurance_score` DECIMAL(18,2) COMMENT 'Average quality assurance audit score for the agent based on case review and compliance checks. Typically scored 0-100 by QA team.',
    `shift_schedule_reference` STRING COMMENT 'Reference identifier to the agents current shift schedule or roster. Links to workforce management system for capacity planning.',
    `skill_set_tags` STRING COMMENT 'Comma-separated list of agent competencies and specializations (e.g., returns, billing, technical, escalations, fraud, international). Used for intelligent case routing and workload balancing.',
    `sla_compliance_rate` DECIMAL(18,2) COMMENT 'Percentage of cases where the agent met or exceeded the defined Service Level Agreement (SLA) response and resolution time targets.',
    `supported_channels` STRING COMMENT 'Comma-separated list of customer service channels the agent is trained and authorized to handle (e.g., phone, email, chat, social media, SMS).',
    `team_assignment` STRING COMMENT 'Name or identifier of the service team to which the agent is assigned (e.g., Returns Team, Billing Support, Technical Support, Escalations).',
    `termination_date` DATE COMMENT 'Date the agent left the organization or was terminated. Null for active agents. Used for historical case ownership tracking.',
    `total_cases_handled` STRING COMMENT 'Cumulative count of all cases assigned to and handled by the agent since hire date. Used for productivity and experience analysis.',
    `training_completion_date` DATE COMMENT 'Date the agent completed initial onboarding and training program and was certified to handle customer cases independently.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the agent record was last modified. Audit field for change tracking and data quality monitoring.',
    CONSTRAINT pk_agent PRIMARY KEY(`agent_id`)
) COMMENT 'Master record for customer service agents and support staff operating within the service domain. Captures agent name, employee ID reference, team assignment, skill set tags (returns, billing, technical, escalations), supported channels, language proficiencies, current availability status, shift schedule reference, performance tier, and active/inactive status. Serves as the SSOT for agent identity within the service domain and supports case routing, workload balancing, and performance measurement.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`service`.`team` (
    `team_id` BIGINT COMMENT 'Unique identifier for the customer service team. Primary key.',
    `agent_id` BIGINT COMMENT 'Reference to the employee or manager who leads this team. Used for escalation paths and team performance accountability.',
    `cost_center_id` BIGINT COMMENT 'Reference to the finance cost center to which this teams expenses are allocated. Enables financial reporting and budget tracking.',
    `parent_team_id` BIGINT COMMENT 'Reference to the parent team in a hierarchical team structure. Null for top-level teams. Enables organizational hierarchy and escalation path modeling.',
    `primary_escalation_team_id` BIGINT COMMENT 'Reference to the team to which cases are escalated when this team cannot resolve them. Null if this is the highest escalation tier. Enables escalation path configuration.',
    `capacity_fte` DECIMAL(18,2) COMMENT 'Total team capacity expressed in Full-Time Equivalent (FTE) headcount. Used for workforce planning, capacity forecasting, and case load balancing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the team record was first created in the system. Used for audit trail and data lineage.',
    `csat_target` DECIMAL(18,2) COMMENT 'Target Customer Satisfaction (CSAT) score for the team, expressed as a percentage (0-100). Key performance indicator (KPI) for customer experience quality.',
    `effective_date` DATE COMMENT 'Date when the team became operational and started accepting cases. Used for team lifecycle tracking and historical reporting.',
    `email_address` STRING COMMENT 'Primary email address for the team, used for case assignment notifications and internal communication. Organizational contact data, classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `geographic_coverage` STRING COMMENT 'Geographic region or market this team serves, using 3-letter ISO country codes or region identifiers (e.g., USA, CAN, GBR, EUR, APAC, GLOBAL). Supports geo-based routing and regional SLA (Service Level Agreement) management.',
    `is_remote` BOOLEAN COMMENT 'Indicates whether the team operates remotely (distributed workforce) or from a centralized physical location. True if remote, False if on-site.',
    `language_support` STRING COMMENT 'Comma-separated list of languages the team can support using ISO 639-1 two-letter codes (e.g., en, es, fr, de, zh, ja). Enables language-based case routing.',
    `max_concurrent_cases` STRING COMMENT 'Maximum number of cases the team can handle concurrently based on capacity and workload models. Used for case routing throttling and queue management.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the team record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context about the team (e.g., special operating procedures, temporary capacity changes, pilot program details).',
    `nps_target` STRING COMMENT 'Target Net Promoter Score (NPS) for the team, ranging from -100 to +100. Measures customer loyalty and likelihood to recommend based on team interactions.',
    `operates_holidays` BOOLEAN COMMENT 'Indicates whether the team operates on public holidays. True if holiday coverage is provided, False if holidays are non-operational.',
    `operates_weekends` BOOLEAN COMMENT 'Indicates whether the team operates on weekends (Saturday and Sunday). True if weekend coverage is provided, False if weekends are non-operational.',
    `operating_hours_end` STRING COMMENT 'Daily end time of the teams operating hours in HH:mm format (24-hour clock, teams local timezone). Used for case routing and availability scheduling.. Valid values are `^([01]d|2[0-3]):([0-5]d)$`',
    `operating_hours_start` STRING COMMENT 'Daily start time of the teams operating hours in HH:mm format (24-hour clock, teams local timezone). Used for case routing and availability scheduling.. Valid values are `^([01]d|2[0-3]):([0-5]d)$`',
    `phone_number` STRING COMMENT 'Primary phone number for the team, used for internal escalations and coordination. Organizational contact data, classified as confidential.',
    `physical_location` STRING COMMENT 'Physical office or site location where the team is based (e.g., New York HQ, Manila Contact Center, Remote). Used for workforce planning and facility management.',
    `primary_function` STRING COMMENT 'Brief description of the teams primary business function and scope of responsibility (e.g., Order inquiries and tracking, Returns and refunds processing, Account and billing support, Technical troubleshooting).',
    `quality_score_target` DECIMAL(18,2) COMMENT 'Target quality assurance score for the team, expressed as a percentage (0-100). Represents the expected standard for case handling quality, monitored through QA audits.',
    `sla_tier` STRING COMMENT 'The SLA tier this team is assigned to deliver: standard (baseline service levels), priority (faster response for high-value segments), premium (enhanced service commitments), vip (white-glove service for top customers). Drives case routing and performance targets.. Valid values are `standard|priority|premium|vip`',
    `specialization_tags` STRING COMMENT 'Comma-separated list of specialization keywords or skill tags that describe the teams expertise (e.g., rma, fraud_detection, vip_service, technical_support, billing_disputes). Used for intelligent case routing based on issue type.',
    `target_first_response_minutes` STRING COMMENT 'Target time in minutes for the team to provide the first response to a customer inquiry, as defined by the teams SLA tier. Key performance indicator (KPI) for responsiveness.',
    `target_resolution_hours` DECIMAL(18,2) COMMENT 'Target time in hours for the team to resolve a case, as defined by the teams SLA tier. Key performance indicator (KPI) for case closure efficiency.',
    `team_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the team for operational systems and reporting (e.g., T1-FRONT, T2-ESC, RMA-SPEC).. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `team_name` STRING COMMENT 'Human-readable name of the customer service team (e.g., Tier-1 Frontline Support, Returns Specialist Team, VIP Customer Care).',
    `team_status` STRING COMMENT 'Current operational status of the team: active (currently operational and accepting cases), inactive (temporarily not operational), suspended (on hold pending review), dissolved (permanently closed).. Valid values are `active|inactive|suspended|dissolved`',
    `team_type` STRING COMMENT 'Classification of the team based on its role in the service organization: tier_1_frontline (first contact resolution), tier_2_escalation (complex issue handling), specialist (domain-specific expertise such as RMA or fraud), back_office (non-customer-facing support), quality_assurance (monitoring and coaching), training (onboarding and skill development).. Valid values are `tier_1_frontline|tier_2_escalation|specialist|back_office|quality_assurance|training`',
    `termination_date` DATE COMMENT 'Date when the team was dissolved or permanently closed. Null for active teams. Used for team lifecycle tracking and historical analysis.',
    `timezone` STRING COMMENT 'IANA timezone identifier for the teams operating location (e.g., America/New_York, Europe/London, Asia/Tokyo). Used to calculate local operating hours and SLA deadlines.',
    CONSTRAINT pk_team PRIMARY KEY(`team_id`)
) COMMENT 'Master record defining customer service teams and organizational groupings within the support operation. Captures team name, team type (tier-1 frontline, tier-2 escalation, specialist, back-office), supported contact channels, operating hours, geographic coverage, team lead reference, SLA tier assignment, and capacity targets. Enables hierarchical case routing, team-level SLA tracking, and workforce planning for the service organization.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`service`.`sla_policy` (
    `sla_policy_id` BIGINT COMMENT 'Unique identifier for the SLA policy record. Primary key.',
    `regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulation. Business justification: SLA policies must meet regulatory consumer protection standards; linking SLA policy to the governing regulation allows compliance monitoring.',
    `superseded_by_policy_sla_policy_id` BIGINT COMMENT 'Reference to the newer SLA policy that replaces this one. Nullable for current active policies. Creates version chain for policy evolution tracking.',
    `approval_status` STRING COMMENT 'Approval status of the SLA policy. Policies must be approved before becoming active. Supports governance and change control processes.. Valid values are `pending|approved|rejected`',
    `approved_by_user_code` BIGINT COMMENT 'Identifier of the user who approved this SLA policy. Typically a senior operations leader or executive. Nullable for unapproved policies.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA policy was approved. Nullable for unapproved policies. Supports audit trail and compliance reporting.',
    `auto_escalation_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether automatic escalation is enabled when escalation_threshold_hours is reached. True enables automated escalation workflow, False requires manual escalation.',
    `breach_penalty_amount` DECIMAL(18,2) COMMENT 'Monetary amount of penalty or credit applied when SLA is breached. Applicable when breach_penalty_type is financial or credit. Stored in base currency.',
    `breach_penalty_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the breach penalty amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `breach_penalty_type` STRING COMMENT 'Type of penalty or action triggered when SLA is breached. Options include no penalty, financial penalty, customer credit, automatic escalation, or notification to management.. Valid values are `none|financial|credit|escalation|notification`',
    `business_days` STRING COMMENT 'Comma-separated list of business days when SLA is active (e.g., Monday,Tuesday,Wednesday,Thursday,Friday). Used when time_calculation_method is business_hours to exclude weekends or specific days.',
    `business_hours_end` STRING COMMENT 'End time of business hours in HH:MM format (24-hour clock) when time_calculation_method is business_hours. Used to calculate SLA compliance during operational hours only.. Valid values are `^([01]?[0-9]|2[0-3]):[0-5][0-9]$`',
    `business_hours_start` STRING COMMENT 'Start time of business hours in HH:MM format (24-hour clock) when time_calculation_method is business_hours. Used to calculate SLA compliance during operational hours only.. Valid values are `^([01]?[0-9]|2[0-3]):[0-5][0-9]$`',
    `case_priority` STRING COMMENT 'Priority level of cases this SLA policy applies to. Used in conjunction with case_type to form the SLA matrix (e.g., High priority order inquiries have different SLA targets than Low priority inquiries).. Valid values are `critical|high|medium|low`',
    `case_type` STRING COMMENT 'Type of customer service case this SLA policy applies to (e.g., Order Inquiry, Product Return, Technical Issue, Billing Dispute, Account Management). Defines the scope of cases governed by this policy.',
    `channel` STRING COMMENT 'Customer service channel this SLA policy applies to. Different channels may have different response time commitments (e.g., chat has faster response than email).. Valid values are `phone|email|chat|social_media|self_service|in_person`',
    `compliance_required` BOOLEAN COMMENT 'Boolean flag indicating whether this SLA policy is driven by regulatory compliance requirements (e.g., GDPR data subject request response times, financial services complaint handling). True indicates regulatory mandate.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA policy record was first created in the system. Part of standard audit trail.',
    `customer_segment` STRING COMMENT 'Customer segment this SLA policy applies to (e.g., VIP, Premium, Standard, Enterprise, SMB). Enables differentiated service levels by customer tier.',
    `effective_end_date` DATE COMMENT 'Date when this SLA policy expires or is superseded by a new version. Nullable for currently active policies with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this SLA policy becomes active and begins governing case handling. Part of the effective date range for policy versioning.',
    `escalation_level` STRING COMMENT 'Numeric escalation tier this SLA policy triggers (e.g., 1 = supervisor, 2 = manager, 3 = director). Defines the organizational level to which cases are escalated when thresholds are breached.',
    `escalation_threshold_hours` DECIMAL(18,2) COMMENT 'Time threshold in hours that triggers automatic escalation if the case is not resolved. Typically set before the resolution target to allow time for escalated handling.',
    `exclusions` STRING COMMENT 'Description of cases or conditions excluded from this SLA policy (e.g., Excludes cases opened during system maintenance windows, Does not apply to third-party vendor issues). Defines policy boundaries.',
    `first_response_target_hours` DECIMAL(18,2) COMMENT 'Target time in hours for the first response to a customer case under this SLA policy. Represents the maximum time allowed before initial acknowledgment or response to the customer.',
    `geographic_region` STRING COMMENT 'Geographic region or market this SLA policy applies to (e.g., North America, EMEA, APAC). Supports region-specific service level commitments.',
    `is_default_policy` BOOLEAN COMMENT 'Boolean flag indicating whether this is the default SLA policy applied when no specific policy matches a case. Only one policy per case_type should be marked as default.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA policy record was last updated. Part of standard audit trail for change tracking.',
    `notification_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether automated notifications are sent when SLA thresholds are approaching or breached. True enables notification workflow.',
    `notification_threshold_percent` STRING COMMENT 'Percentage of SLA target time elapsed that triggers a warning notification (e.g., 80 means notify when 80% of resolution_target_hours has passed). Used for proactive SLA management.',
    `owner_user_code` BIGINT COMMENT 'Identifier of the business user or manager responsible for defining and maintaining this SLA policy. Typically a customer service director or operations manager.',
    `policy_code` STRING COMMENT 'Unique business identifier code for the SLA policy used in operational systems and reporting.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `policy_name` STRING COMMENT 'Human-readable name of the SLA policy (e.g., Premium Support SLA, Standard Response Policy).',
    `policy_type` STRING COMMENT 'Classification of the SLA policy indicating the service area it governs (customer support, technical support, returns processing, escalation handling, VIP service, standard service).. Valid values are `customer_support|technical_support|returns|escalation|vip|standard`',
    `regulatory_framework` STRING COMMENT 'Name of the regulatory framework or law that mandates this SLA policy (e.g., GDPR, CCPA, FTC Consumer Protection, PCI DSS). Populated when compliance_required is True.',
    `resolution_target_hours` DECIMAL(18,2) COMMENT 'Target time in hours for full resolution of a customer case under this SLA policy. Represents the maximum time allowed to completely resolve and close the case.',
    `sla_policy_description` STRING COMMENT 'Detailed description of the SLA policy including its purpose, scope, and any special conditions or exceptions. Provides context for policy application and interpretation.',
    `sla_policy_status` STRING COMMENT 'Current lifecycle status of the SLA policy indicating whether it is actively enforced, inactive, in draft state, archived, or temporarily suspended.. Valid values are `active|inactive|draft|archived|suspended`',
    `time_calculation_method` STRING COMMENT 'Method used to calculate SLA time targets. Business hours counts only operational hours (e.g., 9am-5pm weekdays), while calendar hours counts all hours including nights and weekends.. Valid values are `business_hours|calendar_hours`',
    `version_number` STRING COMMENT 'Version number of this SLA policy. Incremented when policy terms are updated. Supports policy change tracking and historical analysis.',
    CONSTRAINT pk_sla_policy PRIMARY KEY(`sla_policy_id`)
) COMMENT 'Reference master defining SLA (Service Level Agreement) policies governing response and resolution time targets for customer support cases. Captures SLA policy name, applicable case type and priority matrix, first response time target (hours), resolution time target (hours), escalation trigger thresholds, business hours vs. calendar hours flag, breach penalty rules, and effective date range. Provides the authoritative SLA configuration used to evaluate case compliance and drive automated escalations.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`service`.`escalation` (
    `escalation_id` BIGINT COMMENT 'Unique identifier for the escalation event. Primary key.',
    `customer_profile_id` BIGINT COMMENT 'Reference to the customer associated with the escalated case, enabling customer-centric escalation pattern analysis.',
    `agent_id` BIGINT COMMENT 'Reference to the support agent who initiated or triggered the escalation.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Escalations triggered by compliance breaches must reference the underlying compliance_obligation to track remediation and reporting.',
    `receiving_agent_id` BIGINT COMMENT 'Reference to the support agent who received and accepted the escalated case.',
    `team_id` BIGINT COMMENT 'Reference to the support team or queue to which the case was escalated.',
    `service_support_case_id` BIGINT COMMENT 'Reference to the originating support case that was escalated.',
    `channel` STRING COMMENT 'The communication channel through which the escalation was initiated or communicated.. Valid values are `phone|email|chat|web|mobile_app|social_media`',
    `compensation_amount` DECIMAL(18,2) COMMENT 'Monetary value of compensation issued to the customer as part of escalation resolution.',
    `compensation_issued_flag` BOOLEAN COMMENT 'Boolean indicator of whether customer compensation (refund, credit, discount, gift) was issued as part of escalation resolution (True) or not (False).',
    `compensation_type` STRING COMMENT 'The type of compensation provided to the customer (e.g., refund, account credit, discount code, gift card, free shipping, product replacement).. Valid values are `refund|credit|discount|gift_card|free_shipping|product_replacement`',
    `cost` DECIMAL(18,2) COMMENT 'Estimated or actual cost associated with handling the escalation, including labor, compensation, and operational overhead.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the escalation record was first created in the system, formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `customer_satisfaction_score` STRING COMMENT 'Post-resolution customer satisfaction score for the escalated case, typically on a scale of 1-5 or 1-10.',
    `customer_segment` STRING COMMENT 'The customer segment or tier at the time of escalation, used for prioritization and SLA (Service Level Agreement) determination.. Valid values are `standard|premium|vip|enterprise`',
    `escalation_number` STRING COMMENT 'Human-readable business identifier for the escalation event, formatted as ESC-NNNNNNNN.. Valid values are `^ESC-[0-9]{8}$`',
    `escalation_status` STRING COMMENT 'Current lifecycle status of the escalation event within the support workflow.. Valid values are `pending|in_progress|resolved|closed|cancelled`',
    `escalation_timestamp` TIMESTAMP COMMENT 'The date and time when the escalation event occurred, formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `escalation_type` STRING COMMENT 'Classification of the escalation mechanism: functional (to specialist team), hierarchical (to supervisor/manager), automatic (system-triggered), or manual (agent-initiated).. Valid values are `functional|hierarchical|automatic|manual`',
    `notes` STRING COMMENT 'Free-text notes or comments provided by the escalating agent explaining the context, urgency, or special handling requirements for the escalation.',
    `nps_score` STRING COMMENT 'Net Promoter Score collected after escalation resolution, measuring customer loyalty on a scale of 0-10.',
    `priority` STRING COMMENT 'The priority level assigned to the escalation, indicating urgency and required response time.. Valid values are `low|medium|high|critical|urgent`',
    `reason` STRING COMMENT 'The trigger or reason that caused the case to be escalated. Common reasons include SLA (Service Level Agreement) breach, customer demand, case complexity, VIP customer status, regulatory concern, or repeat issue.. Valid values are `sla_breach|customer_demand|complexity|vip_customer|regulatory_concern|repeat_issue`',
    `resolution_at_escalated_tier_flag` BOOLEAN COMMENT 'Boolean indicator of whether the case was successfully resolved at the escalated tier (True) or required further escalation (False).',
    `resolution_code` STRING COMMENT 'Standardized code indicating how the escalated case was resolved (e.g., refund issued, replacement shipped, technical fix applied).',
    `resolution_timestamp` TIMESTAMP COMMENT 'The date and time when the escalated case was resolved, formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `root_cause_category` STRING COMMENT 'The identified root cause category for the issue that led to escalation, used for continuous improvement and pattern analysis.',
    `sla_breach_flag` BOOLEAN COMMENT 'Boolean indicator of whether the escalation was triggered by an SLA breach (True) or not (False).',
    `sla_target_resolution_minutes` STRING COMMENT 'The target resolution time in minutes as defined by the applicable SLA for the escalated case.',
    `source_tier` STRING COMMENT 'The support tier or level from which the case was escalated.. Valid values are `tier_1|tier_2|tier_3|specialist`',
    `target_tier` STRING COMMENT 'The support tier or level to which the case was escalated.. Valid values are `tier_2|tier_3|specialist|supervisor|manager|executive`',
    `time_to_resolution_minutes` STRING COMMENT 'The elapsed time in minutes from escalation timestamp to resolution timestamp, used for performance analysis and SLA compliance tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when the escalation record was last modified, formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_escalation PRIMARY KEY(`escalation_id`)
) COMMENT 'Transactional record tracking case escalation events within the support workflow. Captures the originating case reference, escalation trigger reason (SLA breach, customer demand, complexity, VIP customer), escalation tier (tier-1 to tier-2, tier-2 to specialist, agent to supervisor), escalating agent, receiving agent or team, escalation timestamp, resolution at escalated tier flag, and time-to-resolution post-escalation. Supports escalation pattern analysis and service quality improvement.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`service`.`feedback_response` (
    `feedback_response_id` BIGINT COMMENT 'Primary key for feedback_response',
    `customer_profile_id` BIGINT COMMENT 'Reference to the customer who provided the feedback response. Links to the unified customer profile in the Customer Data Platform.',
    `header_id` BIGINT COMMENT 'Reference to the order associated with this feedback, if the survey was triggered by an order-related service interaction or post-delivery survey.',
    `agent_id` BIGINT COMMENT 'Reference to the customer service agent who handled the case being evaluated. Used for agent performance tracking and coaching.',
    `service_support_case_id` BIGINT COMMENT 'Reference to the service case or support ticket that triggered this feedback survey. Links the feedback to the specific service interaction being evaluated.',
    `case_category` STRING COMMENT 'The category of the service case that triggered this feedback (e.g., order_inquiry, return_request, product_defect, delivery_issue, account_management, technical_support). Used to analyze satisfaction by case type and identify problem areas.',
    `case_resolution_time_hours` DECIMAL(18,2) COMMENT 'The total time in hours from case creation to case closure for the service case being evaluated. Captured at the time of survey to enable correlation analysis between resolution speed and customer satisfaction.',
    `channel_of_service` STRING COMMENT 'The channel through which the customer received service for the case being evaluated. Used to analyze satisfaction by service channel and optimize channel strategy. [ENUM-REF-CANDIDATE: phone|email|chat|social_media|in-app|self-service|store — 7 candidates stripped; promote to reference product]',
    `classification_category` STRING COMMENT 'The categorical classification derived from the numeric score. For NPS: promoter (9-10), passive (7-8), detractor (0-6). For CSAT: satisfied (4-5), neutral (3), dissatisfied (1-2). For CES: low_effort (6-7), high_effort (1-3). Used for segmentation and aggregate metrics calculation. [ENUM-REF-CANDIDATE: promoter|passive|detractor|satisfied|neutral|dissatisfied|low_effort|high_effort — 8 candidates stripped; promote to reference product]',
    `contact_reason` STRING COMMENT 'The specific reason the customer contacted support, as classified by the service team. More granular than case_category, capturing the detailed nature of the inquiry or issue (e.g., damaged_item, late_delivery, wrong_item_shipped, refund_status, promo_code_issue).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this feedback response record was first created in the system. Used for data lineage, audit trails, and tracking data freshness.',
    `customer_segment` STRING COMMENT 'The customer segment classification at the time of feedback submission. Used to analyze satisfaction and loyalty metrics by customer cohort (e.g., VIP, frequent_buyer, new_customer, at_risk, dormant). Enables segment-specific experience improvement strategies.',
    `delivery_channel` STRING COMMENT 'The channel through which the survey was delivered to the customer. Email and SMS are common for post-interaction surveys, in-app and web for real-time feedback, IVR for phone-based surveys, chat for conversational feedback collection.. Valid values are `email|SMS|in-app|web|IVR|chat`',
    `escalation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the service case was escalated to a supervisor or specialist team. Escalated cases typically have different satisfaction patterns and require special analysis.',
    `external_survey_reference` STRING COMMENT 'The unique identifier for this survey response in the external survey platform or CRM system. Used for cross-system reconciliation and to link back to the source system for detailed survey metadata.',
    `first_contact_resolution_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the customers issue was resolved on the first contact without requiring follow-up interactions. Key performance indicator (KPI) for service efficiency and a strong predictor of customer satisfaction.',
    `follow_up_action_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this feedback response requires follow-up action from the service team. Typically set to true for detractor responses, low CSAT scores, or when verbatim feedback indicates unresolved issues. Triggers service recovery workflows.',
    `follow_up_completed_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the required follow-up action has been completed. Used to track closure of service recovery loops and ensure no customer feedback is left unaddressed.',
    `follow_up_completed_timestamp` TIMESTAMP COMMENT 'The date and time when the follow-up action was completed. Used to measure time-to-resolution for service recovery and closed-loop feedback processes.',
    `incentive_offered_flag` BOOLEAN COMMENT 'Boolean flag indicating whether an incentive (discount, reward points, gift card) was offered to encourage survey completion. Used to analyze response bias and response rate impact of incentives.',
    `interaction_count` STRING COMMENT 'The total number of customer-agent interactions required to resolve the case being evaluated. Used to measure case complexity and correlate with effort scores and satisfaction ratings.',
    `numeric_score` STRING COMMENT 'The numeric rating provided by the customer. For CSAT surveys this is typically 1-5 (1=very dissatisfied, 5=very satisfied). For NPS surveys this is 0-10 (0=not at all likely to recommend, 10=extremely likely). For CES surveys this is typically 1-7 (1=very difficult, 7=very easy).',
    `primary_feedback_theme` STRING COMMENT 'The main topic or theme identified in the verbatim feedback through text analytics or manual coding. Examples include product_quality, delivery_speed, agent_professionalism, resolution_time, website_usability, pricing, return_process. Used for root cause analysis and improvement prioritization.',
    `response_device_type` STRING COMMENT 'Type of device used by the customer to submit the feedback response. Used to analyze response patterns by device and optimize survey design for different form factors.. Valid values are `desktop|mobile|tablet|unknown`',
    `response_language` STRING COMMENT 'ISO 639-1 two-letter language code indicating the language in which the customer provided their feedback. Used for multilingual sentiment analysis and to route feedback to appropriate language-capable service teams.',
    `response_status` STRING COMMENT 'Status of the survey response. Completed indicates all required questions were answered, partial indicates the survey was started but not finished, abandoned indicates the customer left mid-survey, expired indicates the survey link expired before response, bounced indicates the survey invitation was undeliverable.. Valid values are `completed|partial|abandoned|expired|bounced`',
    `response_timestamp` TIMESTAMP COMMENT 'The date and time when the customer submitted their feedback response. Used to calculate response time from survey delivery and to track feedback recency.',
    `secondary_feedback_theme` STRING COMMENT 'Additional topic or theme identified in the verbatim feedback when multiple themes are present. Captures the secondary concern or compliment expressed by the customer.',
    `sentiment_classification` STRING COMMENT 'Categorical sentiment classification derived from sentiment score and verbatim text analysis. Positive indicates favorable feedback, negative indicates unfavorable feedback, neutral indicates balanced or no strong sentiment, mixed indicates conflicting sentiments within the same response.. Valid values are `positive|neutral|negative|mixed`',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Machine-generated sentiment score derived from verbatim feedback text analysis. Typically ranges from -1.0 (very negative) to +1.0 (very positive), with 0 being neutral. Used to augment numeric ratings with natural language understanding.',
    `sla_met_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the service case was resolved within the committed SLA timeframe. Used to correlate SLA compliance with customer satisfaction and identify the impact of SLA breaches on customer experience.',
    `source_system` STRING COMMENT 'Identifier of the source system that captured this feedback response (e.g., Qualtrics, Medallia, SurveyMonkey, Salesforce Service Cloud, custom feedback platform). Used for data lineage and multi-system integration tracking.',
    `survey_sent_timestamp` TIMESTAMP COMMENT 'The date and time when the survey invitation was sent to the customer. Used to calculate response lag and survey completion rates.',
    `survey_trigger_event` STRING COMMENT 'The specific business event that triggered the delivery of this feedback survey. Identifies the touchpoint in the customer journey being measured.. Valid values are `case_closed|order_delivered|periodic_relationship|return_completed|refund_issued|escalation_resolved`',
    `survey_type` STRING COMMENT 'Type of customer feedback survey administered. CSAT measures satisfaction with specific interactions (1-5 scale), NPS measures customer loyalty and likelihood to recommend (0-10 scale), CES measures ease of interaction (effort score). Post-Delivery surveys capture feedback after order fulfillment, Relationship surveys are periodic assessments, Post-Case surveys follow service case closure.. Valid values are `CSAT|NPS|CES|Post-Delivery|Relationship|Post-Case`',
    `survey_version` STRING COMMENT 'Version identifier of the survey template used. Enables tracking of survey design changes over time and ensures consistent analysis when survey questions or scales are modified.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this feedback response record was last modified. Tracks changes to follow-up status, theme classification, or other mutable fields.',
    `verbatim_feedback_text` STRING COMMENT 'Free-form text comments provided by the customer explaining their rating. This qualitative feedback provides context for the numeric score and is used for sentiment analysis, theme extraction, and identifying specific improvement opportunities. Classified as confidential due to potential inclusion of customer-specific details.',
    CONSTRAINT pk_feedback_response PRIMARY KEY(`feedback_response_id`)
) COMMENT 'Transactional record capturing all customer feedback survey responses tied to service interactions. Covers CSAT (1-5 satisfaction rating for specific interactions), NPS (0-10 loyalty score with promoter/passive/detractor classification), and CES (Customer Effort Score) surveys. Stores survey type, numeric score, classification category, verbatim feedback text, survey trigger event (post-case closure, post-delivery, periodic relationship survey), delivery channel (email, SMS, in-app), response timestamp, associated case and agent references, customer segment, and follow-up action flag. SSOT for all service-domain customer feedback and satisfaction measurement data.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`service`.`knowledge_article` (
    `knowledge_article_id` BIGINT COMMENT 'Unique identifier for the knowledge base article. Primary key.',
    `category_id` BIGINT COMMENT 'Identifier of the primary product category this article applies to. Links article to relevant product catalog segments.',
    `index_id` BIGINT COMMENT 'Foreign key linking to search.index. Business justification: Associates each knowledge article with the search index it resides in, required for index management, re‑indexing, and search performance reporting.',
    `item_id` BIGINT COMMENT 'Foreign key linking to content.content_item. Business justification: Knowledge Base creation reuses existing content items; linking provides traceability and version sync between KB articles and source content.',
    `marketplace_listing_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace_listing. Business justification: Knowledge‑base articles often address issues specific to a marketplace listing; the link enables article‑to‑listing relevance reporting.',
    `agent_id` BIGINT COMMENT 'Identifier of the customer service agent or knowledge manager who authored the article.',
    `regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulation. Business justification: Knowledge articles that address regulatory guidance need to be tied to the applicable regulation to ensure content validity and auditability.',
    `reviewer_agent_id` BIGINT COMMENT 'Identifier of the agent or manager who reviewed and approved the article for publication.',
    `agent_usage_count` STRING COMMENT 'Number of times agents have referenced or attached this article during case resolution. Indicates agent knowledge utilization.',
    `article_number` STRING COMMENT 'Externally-visible unique article number used for reference and citation in support interactions. Format: KA-XXXXXXXX.. Valid values are `^KA-[0-9]{8}$`',
    `article_type` STRING COMMENT 'Classification of the article content type. Determines presentation format and usage context.. Valid values are `faq|troubleshooting_guide|policy_document|how_to|known_issue|product_documentation`',
    `attachment_urls` STRING COMMENT 'Comma-separated list of URLs pointing to supplementary attachments such as PDFs, videos, screenshots, or downloadable resources stored in Content Delivery Network (CDN).',
    `case_deflection_count` STRING COMMENT 'Number of support cases attributed as deflected by this article through self-service resolution. Measured via customer journey tracking.',
    `case_type_tags` STRING COMMENT 'Comma-separated list of case types this article is designed to resolve. Links article to specific support case categories.',
    `content_body` STRING COMMENT 'Rich text content body of the article containing the full resolution steps, policy details, or instructional content. May include HTML formatting, images, and embedded media.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the article record was first created in the knowledge management system.',
    `expiry_date` DATE COMMENT 'Date when the article is scheduled to expire and be automatically archived or removed from active knowledge base. Nullable for evergreen content.',
    `helpful_votes` STRING COMMENT 'Count of positive helpfulness ratings (thumbs up) received from users who viewed the article.',
    `helpfulness_score` DECIMAL(18,2) COMMENT 'Calculated helpfulness percentage based on ratio of helpful to total votes. Range 0.00 to 100.00. Used to identify high-quality and low-quality content.',
    `issue_taxonomy_tags` STRING COMMENT 'Comma-separated list of issue taxonomy tags for categorization and search optimization. Examples: shipping_delay, payment_failure, account_access, product_defect.',
    `knowledge_article_status` STRING COMMENT 'Current lifecycle status of the article in the approval and publication workflow.. Valid values are `draft|in_review|approved|published|archived|expired`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the article record was last modified, including content updates, metadata changes, or status transitions.',
    `last_updated_date` DATE COMMENT 'Date when the article content was last modified and republished.',
    `locale` STRING COMMENT 'Language and region locale code for the article content. Format: ISO 639-1 language code underscore ISO 3166-1 country code (e.g., en_US, es_MX, fr_FR).. Valid values are `^[a-z]{2}_[A-Z]{2}$`',
    `not_helpful_votes` STRING COMMENT 'Count of negative helpfulness ratings (thumbs down) received from users who viewed the article.',
    `priority_level` STRING COMMENT 'Business priority level of the article content. Critical articles address high-impact issues and are promoted in search results.. Valid values are `critical|high|medium|low`',
    `publish_date` DATE COMMENT 'Date when the article was first published and made available to agents or customers.',
    `related_article_ids` STRING COMMENT 'Comma-separated list of knowledge article IDs that are contextually related or frequently viewed together. Used for recommendation engine.',
    `review_by_date` DATE COMMENT 'Target date by which the article should be reviewed for accuracy and relevance. Used to trigger periodic content audits.',
    `search_keywords` STRING COMMENT 'Comma-separated list of keywords and phrases optimized for internal search engine indexing and article discovery.',
    `title` STRING COMMENT 'Human-readable title of the knowledge article displayed in search results and article headers.',
    `version_number` STRING COMMENT 'Sequential version number of the article. Incremented with each published revision to track content evolution.',
    `view_count` BIGINT COMMENT 'Total number of times the article has been viewed by agents or customers. Used to measure article popularity and relevance.',
    `visibility_scope` STRING COMMENT 'Defines the audience scope for article visibility. Determines which user groups can access the article.. Valid values are `internal_only|customer_facing|partner_portal|public`',
    CONSTRAINT pk_knowledge_article PRIMARY KEY(`knowledge_article_id`)
) COMMENT 'Master record for knowledge base articles supporting agent-assisted resolution and customer self-service deflection. Captures article title, rich content body, article type (FAQ, troubleshooting guide, policy document, how-to, known issue), applicable product categories and issue taxonomy tags, authoring agent, review/approval workflow status, publish date, expiry/review-by date, version history, locale/language, view count, helpfulness rating (thumbs up/down), linked case types, and case deflection attribution metrics. Enables measurement of self-service effectiveness, agent knowledge utilization, and content gap identification.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`service`.`case_status_history` (
    `case_status_history_id` BIGINT COMMENT 'Unique identifier for each status transition record in the support case lifecycle. Primary key for the case status history table.',
    `team_id` BIGINT COMMENT 'Reference to the support team that owned the case at the time of this status transition. Tracks case routing and ownership changes.',
    `customer_profile_id` BIGINT COMMENT 'Reference to the customer who owns the support case. Denormalized from support_case for efficient customer-level reporting and segmentation.',
    `header_id` BIGINT COMMENT 'Reference to the order associated with this support case if the case relates to an order issue. Null for non-order-related cases.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Case status changes often stem from compliance obligations; linking status history to the obligation provides traceability for audits.',
    `rma_id` BIGINT COMMENT 'Reference to the RMA record if this status transition relates to a return or refund workflow. Null for non-RMA cases.',
    `service_support_case_id` BIGINT COMMENT 'Reference to the parent support case that experienced this status transition. Links this history record to the originating case entity.',
    `agent_id` BIGINT COMMENT 'Reference to the customer service agent who initiated this status transition. Null if the transition was system-triggered or automated.',
    `automation_rule_code` BIGINT COMMENT 'Reference to the workflow automation rule that triggered this status transition if it was system-initiated. Null for manual transitions.',
    `business_hours_flag` BOOLEAN COMMENT 'Indicates whether this status transition occurred during defined business hours. True if during business hours, False if after hours or weekend. Used for SLA calculation adjustments.',
    `case_category` STRING COMMENT 'High-level categorization of the support case type at the time of this transition. Denormalized for workflow analysis and reporting. [ENUM-REF-CANDIDATE: order_issue|product_defect|shipping_delay|payment_issue|account_inquiry|technical_support|return_refund|complaint|feedback|other — 10 candidates stripped; promote to reference product]',
    `case_number` STRING COMMENT 'Human-readable business identifier for the support case. Denormalized from support_case for reporting convenience and audit trail clarity.. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `channel` STRING COMMENT 'The customer service channel through which the case was originally created. Denormalized for channel performance analysis. [ENUM-REF-CANDIDATE: phone|email|chat|web_form|mobile_app|social_media|in_store — 7 candidates stripped; promote to reference product]',
    `comment_added_flag` BOOLEAN COMMENT 'Indicates whether an agent or system comment was added to the case at the time of this status transition. True if comment was added, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this status history record was created in the system. Used for audit trail and data lineage tracking.',
    `escalation_level` STRING COMMENT 'The escalation tier at the time of this transition. 0 for no escalation, 1 for first-level escalation, 2 for second-level, etc. Tracks case severity progression.',
    `new_status` STRING COMMENT 'The status the case transitioned to at this event. Captures the to-state in the case lifecycle state machine. [ENUM-REF-CANDIDATE: new|open|in_progress|pending_customer|pending_internal|escalated|resolved|closed|cancelled — 9 candidates stripped; promote to reference product]',
    `notification_channel` STRING COMMENT 'The channel used to notify the customer of this status change. None if no notification was sent.. Valid values are `email|sms|push|in_app|none`',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether a customer notification was sent as a result of this status transition. True if notification was sent, False otherwise.',
    `previous_status` STRING COMMENT 'The status the case was in immediately before this transition occurred. Captures the from-state in the case lifecycle state machine. [ENUM-REF-CANDIDATE: new|open|in_progress|pending_customer|pending_internal|escalated|resolved|closed|cancelled — 9 candidates stripped; promote to reference product]',
    `priority_at_transition` STRING COMMENT 'The case priority level that was in effect at the time of this status transition. Captures priority changes over the case lifecycle.. Valid values are `critical|high|medium|low`',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the time spent in the previous status exceeded the SLA target, resulting in an SLA breach. True if breached, False if within SLA.',
    `sla_target_seconds` BIGINT COMMENT 'The SLA target duration in seconds that was applicable for the previous status. Used to determine if the case met or breached SLA during this status phase.',
    `source_system` STRING COMMENT 'Name of the operational system that recorded this status transition. Examples: Salesforce Service Cloud, Zendesk, Custom CRM. Used for data lineage and multi-system integration tracking.',
    `time_in_previous_status_seconds` BIGINT COMMENT 'Duration in seconds that the case spent in the previous status before this transition. Calculated as the difference between this transition timestamp and the prior transition timestamp. Critical for SLA compliance measurement and bottleneck identification.',
    `transition_reason_code` STRING COMMENT 'Standardized code indicating why the status transition occurred. Enables categorization and root cause analysis of case workflow patterns. [ENUM-REF-CANDIDATE: customer_response|agent_action|auto_escalation|sla_breach|resolution_confirmed|duplicate_case|customer_request|system_trigger|manager_override|workflow_rule — 10 candidates stripped; promote to reference product]',
    `transition_reason_description` STRING COMMENT 'Free-text explanation providing additional context for the status transition. Captures agent notes or system-generated rationale.',
    `transition_sequence_number` STRING COMMENT 'Sequential order of this transition within the cases complete lifecycle. First transition is 1, second is 2, etc. Enables chronological ordering and lifecycle stage analysis.',
    `transition_timestamp` TIMESTAMP COMMENT 'Precise date and time when the status transition occurred. Primary business event timestamp for this history record. Used for SLA calculation and workflow bottleneck analysis.',
    `triggered_by_system` STRING COMMENT 'Name of the automated system or workflow engine that triggered this transition if not manually initiated by an agent. Examples: SLA Monitor, Auto-Escalation Engine, Workflow Automation.',
    CONSTRAINT pk_case_status_history PRIMARY KEY(`case_status_history_id`)
) COMMENT 'Transactional history table tracking every status transition in a support case lifecycle. Records the case reference, previous status, new status, transition timestamp, triggering agent or system, transition reason, and time spent in previous status. Enables full case lifecycle audit trail, bottleneck identification in case workflows, and SLA compliance verification. Distinct from the current status field on support_case — this table preserves the complete state machine history.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`service`.`entitlement` (
    `entitlement_id` BIGINT COMMENT 'Unique identifier for the service entitlement record. Primary key.',
    `annual_fee_amount` DECIMAL(18,2) COMMENT 'Annual subscription fee charged for this entitlement tier in base currency (USD). Null indicates no annual fee option.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether customer subscriptions to this entitlement automatically renew at the end of the billing period.',
    `business_hours_coverage` STRING COMMENT 'Support availability hours under this entitlement (business hours 9-5, extended hours 7am-11pm, or 24x7).. Valid values are `business_hours|extended|24x7`',
    `cancellation_notice_days` STRING COMMENT 'Number of days advance notice required for customer to cancel this entitlement without penalty.',
    `concierge_service_flag` BOOLEAN COMMENT 'Indicates whether this entitlement includes white-glove concierge service for complex requests, special orders, or personalized assistance.',
    `contact_channels` STRING COMMENT 'Comma-separated list of support contact channels included in this entitlement (e.g., email, phone, chat, social_media, video_call, in_person).',
    `created_by_user` STRING COMMENT 'Username or identifier of the system user who created this entitlement record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this entitlement record was first created in the system.',
    `customer_segment` STRING COMMENT 'Customer segment eligible for this entitlement tier (standard consumer, prime member, VIP, B2B enterprise account, marketplace seller, or partner).. Valid values are `standard|prime|vip|b2b_enterprise|seller|partner`',
    `dedicated_agent_flag` BOOLEAN COMMENT 'Indicates whether this entitlement includes assignment of a dedicated support agent or account manager.',
    `effective_end_date` DATE COMMENT 'Date when this entitlement tier expires or is discontinued. Null indicates open-ended validity.',
    `effective_start_date` DATE COMMENT 'Date when this entitlement tier becomes active and available for assignment to customer accounts.',
    `entitlement_code` STRING COMMENT 'Business-readable unique code for the entitlement tier (e.g., STD_BASIC, PRIME_PRIORITY, VIP_DEDICATED, B2B_ENTERPRISE).. Valid values are `^[A-Z0-9_-]{6,20}$`',
    `entitlement_description` STRING COMMENT 'Detailed description of the service entitlement benefits, coverage scope, and included features.',
    `entitlement_name` STRING COMMENT 'Human-readable name of the service entitlement tier (e.g., Standard Support, Prime Priority Support, VIP Dedicated Support).',
    `entitlement_status` STRING COMMENT 'Current lifecycle status of the entitlement tier (active and assignable, inactive, deprecated and being phased out, or pending approval).. Valid values are `active|inactive|deprecated|pending`',
    `escalation_path` STRING COMMENT 'Escalation path tier for unresolved cases (standard queue, expedited to management, executive escalation, or no escalation).. Valid values are `standard|expedited|executive|none`',
    `free_return_shipping_flag` BOOLEAN COMMENT 'Indicates whether return shipping costs are waived for customers under this entitlement.',
    `language_support` STRING COMMENT 'Comma-separated list of languages supported for customer service under this entitlement (e.g., en, es, fr, de, zh, ja).',
    `max_cases_per_month` STRING COMMENT 'Maximum number of support cases the customer can open per calendar month under this entitlement. Null indicates unlimited.',
    `monthly_fee_amount` DECIMAL(18,2) COMMENT 'Monthly subscription fee charged for this entitlement tier in base currency (USD). Null indicates no recurring fee.',
    `pricing_tier` STRING COMMENT 'Pricing tier associated with this entitlement (free, basic paid, standard paid, premium paid, enterprise custom pricing).. Valid values are `free|basic|standard|premium|enterprise`',
    `priority_routing_flag` BOOLEAN COMMENT 'Indicates whether cases under this entitlement receive priority routing to senior agents or specialized teams.',
    `proactive_outreach_flag` BOOLEAN COMMENT 'Indicates whether this entitlement includes proactive outreach for service issues, order updates, or account reviews.',
    `refund_processing_priority` STRING COMMENT 'Priority level for refund processing under this entitlement (standard 7-10 days, expedited 3-5 days, immediate 24 hours).. Valid values are `standard|expedited|immediate`',
    `resolution_time_sla_hours` DECIMAL(18,2) COMMENT 'Maximum resolution time in hours guaranteed by SLA for case closure or escalation.',
    `response_time_sla_hours` DECIMAL(18,2) COMMENT 'Maximum response time in hours guaranteed by SLA for initial agent response to customer inquiry.',
    `return_window_days` STRING COMMENT 'Number of days after delivery during which the customer can initiate a return under this entitlement (e.g., 30, 60, 90 days).',
    `rma_auto_approval_flag` BOOLEAN COMMENT 'Indicates whether RMA requests under this entitlement are automatically approved without manual review.',
    `self_service_access_level` STRING COMMENT 'Level of access to self-service tools, knowledge base, and automated resolution features (basic, advanced, premium, full).. Valid values are `basic|advanced|premium|full`',
    `sla_document_url` STRING COMMENT 'URL link to the detailed SLA document specifying response times, resolution commitments, and service guarantees.. Valid values are `^https?://.*$`',
    `support_tier` STRING COMMENT 'Service support tier level defining the quality and speed of support (basic, priority, premium, dedicated, enterprise).. Valid values are `basic|priority|premium|dedicated|enterprise`',
    `technical_support_included_flag` BOOLEAN COMMENT 'Indicates whether technical product support (setup, troubleshooting, configuration) is included in this entitlement.',
    `terms_and_conditions_url` STRING COMMENT 'URL link to the full terms and conditions document governing this entitlement tier.. Valid values are `^https?://.*$`',
    `trial_period_days` STRING COMMENT 'Number of days of free trial period offered for this entitlement tier. Null indicates no trial available.',
    `updated_by_user` STRING COMMENT 'Username or identifier of the system user who last modified this entitlement record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this entitlement record was last modified.',
    `version_number` STRING COMMENT 'Version number of this entitlement configuration, incremented with each modification to track change history.',
    `warranty_extension_months` STRING COMMENT 'Number of additional warranty months provided beyond standard manufacturer warranty under this entitlement. Null indicates no extension.',
    CONSTRAINT pk_entitlement PRIMARY KEY(`entitlement_id`)
) COMMENT 'Master record defining the service entitlements and support tier benefits associated with customer accounts or order types. Captures entitlement name, customer segment eligibility (standard, prime, VIP, B2B enterprise), support tier (basic, priority, dedicated), included contact channels, maximum cases per period, response time SLA tier, dedicated agent assignment flag, and entitlement validity period. Drives case routing logic and SLA policy assignment based on customer service tier.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`service`.`case_queue` (
    `case_queue_id` BIGINT COMMENT 'Unique identifier for the case queue configuration.',
    `team_id` BIGINT COMMENT 'Identifier of the support team primarily responsible for this queue.',
    `policy_id` BIGINT COMMENT 'Reference to the escalation policy applied when SLA thresholds are breached.',
    `overflow_case_queue_id` BIGINT COMMENT 'Self-referencing FK on case_queue (overflow_case_queue_id)',
    `average_wait_time_target_minutes` STRING COMMENT 'Desired average wait time for cases in this queue, expressed in minutes.',
    `capacity_limit` STRING COMMENT 'Maximum number of cases that can be simultaneously assigned to the queue.',
    `case_queue_description` STRING COMMENT 'Detailed description of the queue purpose and behavior.',
    `case_queue_name` STRING COMMENT 'Human‑readable name of the queue.',
    `case_queue_status` STRING COMMENT 'Current lifecycle status of the queue.. Valid values are `active|inactive|paused|decommissioned`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the queue record was first created.',
    `effective_end_date` DATE COMMENT 'Date when the queue configuration ceases to be effective (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the queue configuration becomes effective.',
    `is_priority_queue` BOOLEAN COMMENT 'Indicates whether the queue is designated for high‑priority cases.',
    `last_modified_by_user_code` BIGINT COMMENT 'Identifier of the user who performed the most recent update.',
    `max_wait_time_minutes` STRING COMMENT 'Hard ceiling for how long a case may wait in the queue before escalation.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information about the queue.',
    `operating_hours_end` STRING COMMENT 'Daily end time for queue operation (HH:mm, 24‑hour clock).. Valid values are `^([01]d|2[0-3]):[0-5]d$`',
    `operating_hours_start` STRING COMMENT 'Daily start time for queue operation (HH:mm, 24‑hour clock).. Valid values are `^([01]d|2[0-3]):[0-5]d$`',
    `overflow_routing_rule` STRING COMMENT 'Rule applied when the queue exceeds its capacity (e.g., redirect to overflow queue).',
    `queue_depth_limit` STRING COMMENT 'Maximum number of cases that can be queued awaiting assignment.',
    `queue_type` STRING COMMENT 'Classification of the queue routing strategy.. Valid values are `skill_based|round_robin|priority|overflow`',
    `routing_algorithm` STRING COMMENT 'Algorithm used to distribute cases to agents.. Valid values are `skill_based|round_robin|weighted|custom`',
    `sla_target_abandon_rate_percent` DECIMAL(18,2) COMMENT 'Maximum acceptable percentage of cases abandoned before service.',
    `sla_target_average_wait_minutes` STRING COMMENT 'Service‑level agreement target for average wait time, in minutes.',
    `timezone` STRING COMMENT 'IANA time‑zone identifier for the queues operating schedule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the queue record.',
    CONSTRAINT pk_case_queue PRIMARY KEY(`case_queue_id`)
) COMMENT 'Master record defining service case queues and routing configurations for the contact center operation. Captures queue name, queue type (skill-based, round-robin, priority, overflow), supported case types and priorities, assigned team reference, operating hours, capacity limits, overflow routing rules, average wait time targets, and active/inactive status. Drives real-time case distribution to agents, enables workload balancing across teams, and supports queue-level performance monitoring (average handle time, abandonment rate, queue depth). Essential for contact center workforce management and case routing automation.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ADD CONSTRAINT `fk_service_service_support_case_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ADD CONSTRAINT `fk_service_service_support_case_knowledge_article_id` FOREIGN KEY (`knowledge_article_id`) REFERENCES `ecommerce_ecm`.`service`.`knowledge_article`(`knowledge_article_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ADD CONSTRAINT `fk_service_service_support_case_parent_case_service_support_case_id` FOREIGN KEY (`parent_case_service_support_case_id`) REFERENCES `ecommerce_ecm`.`service`.`service_support_case`(`service_support_case_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ADD CONSTRAINT `fk_service_service_support_case_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `ecommerce_ecm`.`service`.`rma`(`rma_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ADD CONSTRAINT `fk_service_case_interaction_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ADD CONSTRAINT `fk_service_case_interaction_service_support_case_id` FOREIGN KEY (`service_support_case_id`) REFERENCES `ecommerce_ecm`.`service`.`service_support_case`(`service_support_case_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ADD CONSTRAINT `fk_service_rma_line_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `ecommerce_ecm`.`service`.`rma`(`rma_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ADD CONSTRAINT `fk_service_service_refund_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ADD CONSTRAINT `fk_service_service_refund_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `ecommerce_ecm`.`service`.`rma`(`rma_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ADD CONSTRAINT `fk_service_service_refund_service_support_case_id` FOREIGN KEY (`service_support_case_id`) REFERENCES `ecommerce_ecm`.`service`.`service_support_case`(`service_support_case_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ADD CONSTRAINT `fk_service_agent_supervisor_agent_id` FOREIGN KEY (`supervisor_agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`team` ADD CONSTRAINT `fk_service_team_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`team` ADD CONSTRAINT `fk_service_team_parent_team_id` FOREIGN KEY (`parent_team_id`) REFERENCES `ecommerce_ecm`.`service`.`team`(`team_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`team` ADD CONSTRAINT `fk_service_team_primary_escalation_team_id` FOREIGN KEY (`primary_escalation_team_id`) REFERENCES `ecommerce_ecm`.`service`.`team`(`team_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ADD CONSTRAINT `fk_service_sla_policy_superseded_by_policy_sla_policy_id` FOREIGN KEY (`superseded_by_policy_sla_policy_id`) REFERENCES `ecommerce_ecm`.`service`.`sla_policy`(`sla_policy_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ADD CONSTRAINT `fk_service_escalation_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ADD CONSTRAINT `fk_service_escalation_receiving_agent_id` FOREIGN KEY (`receiving_agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ADD CONSTRAINT `fk_service_escalation_team_id` FOREIGN KEY (`team_id`) REFERENCES `ecommerce_ecm`.`service`.`team`(`team_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ADD CONSTRAINT `fk_service_escalation_service_support_case_id` FOREIGN KEY (`service_support_case_id`) REFERENCES `ecommerce_ecm`.`service`.`service_support_case`(`service_support_case_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ADD CONSTRAINT `fk_service_feedback_response_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ADD CONSTRAINT `fk_service_feedback_response_service_support_case_id` FOREIGN KEY (`service_support_case_id`) REFERENCES `ecommerce_ecm`.`service`.`service_support_case`(`service_support_case_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ADD CONSTRAINT `fk_service_knowledge_article_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ADD CONSTRAINT `fk_service_knowledge_article_reviewer_agent_id` FOREIGN KEY (`reviewer_agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ADD CONSTRAINT `fk_service_case_status_history_team_id` FOREIGN KEY (`team_id`) REFERENCES `ecommerce_ecm`.`service`.`team`(`team_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ADD CONSTRAINT `fk_service_case_status_history_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `ecommerce_ecm`.`service`.`rma`(`rma_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ADD CONSTRAINT `fk_service_case_status_history_service_support_case_id` FOREIGN KEY (`service_support_case_id`) REFERENCES `ecommerce_ecm`.`service`.`service_support_case`(`service_support_case_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ADD CONSTRAINT `fk_service_case_status_history_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `ecommerce_ecm`.`service`.`agent`(`agent_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ADD CONSTRAINT `fk_service_case_queue_team_id` FOREIGN KEY (`team_id`) REFERENCES `ecommerce_ecm`.`service`.`team`(`team_id`);
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ADD CONSTRAINT `fk_service_case_queue_overflow_case_queue_id` FOREIGN KEY (`overflow_case_queue_id`) REFERENCES `ecommerce_ecm`.`service`.`case_queue`(`case_queue_id`);

-- ========= TAGS =========
ALTER SCHEMA `ecommerce_ecm`.`service` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `ecommerce_ecm`.`service` SET TAGS ('dbx_domain' = 'service');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` SET TAGS ('dbx_subdomain' = 'customer_support');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `service_support_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Support Case ID');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Agent ID');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `fulfillment_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Content Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `knowledge_article_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Article ID');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `lead_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `marketplace_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Transaction Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `parent_case_service_support_case_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Case ID');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `promotional_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) ID');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Seller ID');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Stock Keeping Unit (SKU)');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `assigned_queue` SET TAGS ('dbx_business_glossary_term' = 'Assigned Queue');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Case Type');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Closed Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `contact_attempts` SET TAGS ('dbx_business_glossary_term' = 'Contact Attempts Count');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `csat_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Score');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `customer_entitlement_tier` SET TAGS ('dbx_business_glossary_term' = 'Customer Entitlement Tier');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `customer_entitlement_tier` SET TAGS ('dbx_value_regex' = 'standard|premium|vip|enterprise');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `escalation_status` SET TAGS ('dbx_business_glossary_term' = 'Escalation Status');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `escalation_status` SET TAGS ('dbx_value_regex' = 'not_escalated|tier2|tier3|management|executive');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `feedback_comments` SET TAGS ('dbx_business_glossary_term' = 'Customer Feedback Comments');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `first_response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Response Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `interaction_count` SET TAGS ('dbx_business_glossary_term' = 'Interaction Count');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `is_vip_case` SET TAGS ('dbx_business_glossary_term' = 'VIP Case Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `originating_channel` SET TAGS ('dbx_business_glossary_term' = 'Originating Channel');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `originating_channel` SET TAGS ('dbx_value_regex' = 'phone|email|chat|social_media|self_service|mobile_app');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `outcome_disposition` SET TAGS ('dbx_business_glossary_term' = 'Outcome Disposition');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `outcome_disposition` SET TAGS ('dbx_value_regex' = 'resolved|unresolved|duplicate|transferred|withdrawn');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'P1|P2|P3|P4');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `reopened_count` SET TAGS ('dbx_business_glossary_term' = 'Reopened Count');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Sentiment Score');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `service_support_case_description` SET TAGS ('dbx_business_glossary_term' = 'Case Description');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `service_support_case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `sla_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Policy Code');
ALTER TABLE `ecommerce_ecm`.`service`.`service_support_case` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Case Subject');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` SET TAGS ('dbx_subdomain' = 'customer_support');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `case_interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Case Interaction ID');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `marketplace_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Transaction Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `service_support_case_id` SET TAGS ('dbx_business_glossary_term' = 'Case ID');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `attachment_references` SET TAGS ('dbx_business_glossary_term' = 'Attachment References');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Interaction Channel');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'phone|email|live_chat|mobile_app|web_portal|social_media');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `contact_method` SET TAGS ('dbx_business_glossary_term' = 'Contact Method');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `contact_method` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `contact_method` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `content_summary` SET TAGS ('dbx_business_glossary_term' = 'Content Summary');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `csat_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Score');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Interaction Direction');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Interaction Duration in Seconds');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `external_interaction_reference` SET TAGS ('dbx_business_glossary_term' = 'External Interaction ID');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `feedback_comment` SET TAGS ('dbx_business_glossary_term' = 'Customer Feedback Comment');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `full_transcript_reference` SET TAGS ('dbx_business_glossary_term' = 'Full Transcript Reference');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `interaction_number` SET TAGS ('dbx_business_glossary_term' = 'Interaction Number');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `interaction_number` SET TAGS ('dbx_value_regex' = '^INT-[0-9]{8,12}$');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `interaction_sequence` SET TAGS ('dbx_business_glossary_term' = 'Interaction Sequence Number');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `interaction_status` SET TAGS ('dbx_business_glossary_term' = 'Interaction Status');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `interaction_status` SET TAGS ('dbx_value_regex' = 'completed|pending|escalated|abandoned|transferred');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `interaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interaction Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_business_glossary_term' = 'Interaction Type');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_value_regex' = 'call|email|chat|sms|social_media|web_form');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Interaction Outcome');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'resolved|unresolved|escalated|referred|information_provided|callback_scheduled');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Interaction Priority');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `resolution_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Resolution Provided Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `response_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Response Time in Seconds');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `sla_breach_reason` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Breach Reason');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Interaction Subject');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Interaction Tags');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `transfer_flag` SET TAGS ('dbx_business_glossary_term' = 'Transfer Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`case_interaction` ALTER COLUMN `wait_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Wait Time in Seconds');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` SET TAGS ('dbx_subdomain' = 'return_management');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) ID');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `approved_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `approved_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `approved_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `customer_declared_condition` SET TAGS ('dbx_business_glossary_term' = 'Customer Declared Condition');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `customer_declared_condition` SET TAGS ('dbx_value_regex' = 'unopened|opened_unused|lightly_used|heavily_used|damaged|defective');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `customer_service_notes` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Notes');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_value_regex' = 'restock|liquidate|destroy|return_to_vendor|donate|refurbish');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `expected_return_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Return Date');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `inspected_condition` SET TAGS ('dbx_business_glossary_term' = 'Inspected Condition');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `inspected_condition` SET TAGS ('dbx_value_regex' = 'as_new|good|acceptable|damaged|defective|not_as_described');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `inspection_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Completed Date');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `is_within_policy` SET TAGS ('dbx_business_glossary_term' = 'Is Within Policy');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `label_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Label Issued Date');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `label_paid_by` SET TAGS ('dbx_business_glossary_term' = 'Label Paid By');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `label_paid_by` SET TAGS ('dbx_value_regex' = 'customer|merchant|carrier|third_party');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `refund_method` SET TAGS ('dbx_business_glossary_term' = 'Refund Method');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `refund_method` SET TAGS ('dbx_value_regex' = 'original_payment|store_credit|gift_card|bank_transfer|check');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `refund_processed_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Processed Date');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `refund_status` SET TAGS ('dbx_business_glossary_term' = 'Refund Status');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `refund_status` SET TAGS ('dbx_value_regex' = 'pending|processing|completed|failed|cancelled');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `requested_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Date');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `restocking_fee` SET TAGS ('dbx_business_glossary_term' = 'Restocking Fee');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `return_label_cost` SET TAGS ('dbx_business_glossary_term' = 'Return Label Cost');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `return_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Return Tracking Number');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `return_type` SET TAGS ('dbx_business_glossary_term' = 'Return Type');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `return_type` SET TAGS ('dbx_value_regex' = 'refund|exchange|store_credit|replacement');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `return_window_days` SET TAGS ('dbx_business_glossary_term' = 'Return Window Days');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `rma_number` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Number');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `rma_number` SET TAGS ('dbx_value_regex' = '^RMA-[0-9]{8,12}$');
ALTER TABLE `ecommerce_ecm`.`service`.`rma` ALTER COLUMN `rma_status` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Status');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` SET TAGS ('dbx_subdomain' = 'return_management');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `rma_line_id` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Line ID');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Order ID');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line ID');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) ID');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location ID');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `disposition_code` SET TAGS ('dbx_business_glossary_term' = 'Disposition Code');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `disposition_code` SET TAGS ('dbx_value_regex' = 'RESTOCK|LIQUIDATE|DISPOSE|RETURN_VENDOR|REPAIR|DONATE');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `exchange_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Exchange Requested Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `exchange_sku` SET TAGS ('dbx_business_glossary_term' = 'Exchange Stock Keeping Unit (SKU)');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `exchange_sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `inspected_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Inspected By User ID');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `inspected_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `inspected_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `inspected_date` SET TAGS ('dbx_business_glossary_term' = 'Inspected Date');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `item_condition_code` SET TAGS ('dbx_business_glossary_term' = 'Item Condition Code');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `item_condition_code` SET TAGS ('dbx_value_regex' = 'NEW_UNOPENED|NEW_OPENED|USED_LIKE_NEW|USED_GOOD|DAMAGED|DEFECTIVE');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `line_subtotal` SET TAGS ('dbx_business_glossary_term' = 'Line Subtotal');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `line_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Tax Amount');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `quantity_approved` SET TAGS ('dbx_business_glossary_term' = 'Quantity Approved for Refund');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `quantity_requested` SET TAGS ('dbx_business_glossary_term' = 'Quantity Requested for Return');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `refund_processed_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Processed Date');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `restocking_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Restocking Eligible Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `restocking_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Restocking Fee Amount');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_value_regex' = 'DEFECTIVE|WRONG_ITEM|NOT_AS_DESCRIBED|DAMAGED_SHIPPING|CHANGED_MIND|SIZE_FIT');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `return_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `ecommerce_ecm`.`service`.`rma_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` SET TAGS ('dbx_subdomain' = 'return_management');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `service_refund_id` SET TAGS ('dbx_business_glossary_term' = 'Service Refund ID');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `marketplace_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Transaction Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction ID');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Agent ID');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) ID');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `service_support_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Case ID');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'auto_approved|pending_approval|manager_approved|rejected|override_approved');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `approval_tier` SET TAGS ('dbx_business_glossary_term' = 'Approval Tier');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `approval_tier` SET TAGS ('dbx_value_regex' = 'tier_1_auto|tier_2_supervisor|tier_3_manager|tier_4_director|tier_5_executive');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Approved Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Completed Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `customer_satisfaction_impact` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Impact');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `customer_satisfaction_impact` SET TAGS ('dbx_value_regex' = 'positive|neutral|negative|unknown');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `is_goodwill_gesture` SET TAGS ('dbx_business_glossary_term' = 'Is Goodwill Gesture Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `is_retention_offer` SET TAGS ('dbx_business_glossary_term' = 'Is Retention Offer Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `loyalty_points_granted` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Granted');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `manager_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Manager Override Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `net_refund_cost` SET TAGS ('dbx_business_glossary_term' = 'Net Refund Cost');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Refund Notes');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `nps_survey_response` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Survey Response');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `original_payment_method_type` SET TAGS ('dbx_business_glossary_term' = 'Original Payment Method Type');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `override_justification` SET TAGS ('dbx_business_glossary_term' = 'Override Justification');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Processed Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `processing_fee` SET TAGS ('dbx_business_glossary_term' = 'Refund Processing Fee');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `reason_category` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason Category');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `reason_detail` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason Detail');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `redemption_code` SET TAGS ('dbx_business_glossary_term' = 'Redemption Code');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `redemption_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,16}$');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `redemption_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `redemption_status` SET TAGS ('dbx_business_glossary_term' = 'Redemption Status');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `redemption_status` SET TAGS ('dbx_value_regex' = 'not_applicable|unredeemed|partially_redeemed|fully_redeemed|expired_unredeemed');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `redemption_value_remaining` SET TAGS ('dbx_business_glossary_term' = 'Redemption Value Remaining');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `refund_method` SET TAGS ('dbx_business_glossary_term' = 'Refund Method');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `refund_number` SET TAGS ('dbx_business_glossary_term' = 'Refund Number');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `refund_number` SET TAGS ('dbx_value_regex' = '^RFD-[0-9]{10}$');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `remediation_type` SET TAGS ('dbx_business_glossary_term' = 'Remediation Type');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `requested_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Requested Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `service_refund_status` SET TAGS ('dbx_business_glossary_term' = 'Refund Status');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `settlement_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Reference Number');
ALTER TABLE `ecommerce_ecm`.`service`.`service_refund` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` SET TAGS ('dbx_subdomain' = 'customer_support');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `supervisor_agent_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Active Status');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `active_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|terminated|suspended');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Availability Status');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `availability_status` SET TAGS ('dbx_value_regex' = 'available|busy|on_break|in_meeting|offline|away');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `average_handle_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average Handle Time (AHT) in Minutes');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `customer_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Score');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Agent Email Address');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `employee_code` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `employee_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `employee_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `employee_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `escalation_rate` SET TAGS ('dbx_business_glossary_term' = 'Escalation Rate Percentage');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `first_contact_resolution_rate` SET TAGS ('dbx_business_glossary_term' = 'First Contact Resolution (FCR) Rate Percentage');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Agent Full Name');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `language_proficiencies` SET TAGS ('dbx_business_glossary_term' = 'Language Proficiencies');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `last_login_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Login Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `max_concurrent_cases` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concurrent Cases');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `net_promoter_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Performance Tier');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `performance_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|senior|lead|specialist');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `phone_extension` SET TAGS ('dbx_business_glossary_term' = 'Phone Extension');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `phone_extension` SET TAGS ('dbx_value_regex' = '^[0-9]{3,6}$');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `phone_extension` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `phone_extension` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `quality_assurance_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Score Percentage');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `shift_schedule_reference` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule Reference');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `skill_set_tags` SET TAGS ('dbx_business_glossary_term' = 'Skill Set Tags');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `sla_compliance_rate` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Rate Percentage');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `supported_channels` SET TAGS ('dbx_business_glossary_term' = 'Supported Channels');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `team_assignment` SET TAGS ('dbx_business_glossary_term' = 'Team Assignment');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `total_cases_handled` SET TAGS ('dbx_business_glossary_term' = 'Total Cases Handled');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `ecommerce_ecm`.`service`.`agent` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`team` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`service`.`team` SET TAGS ('dbx_subdomain' = 'customer_support');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Team Lead ID');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `parent_team_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Team ID');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `primary_escalation_team_id` SET TAGS ('dbx_business_glossary_term' = 'Escalation Team ID');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `capacity_fte` SET TAGS ('dbx_business_glossary_term' = 'Capacity (Full-Time Equivalent)');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `csat_target` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Target (Percentage)');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Team Email Address');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `is_remote` SET TAGS ('dbx_business_glossary_term' = 'Is Remote Team');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `language_support` SET TAGS ('dbx_business_glossary_term' = 'Language Support');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `max_concurrent_cases` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concurrent Cases');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `nps_target` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Target');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `operates_holidays` SET TAGS ('dbx_business_glossary_term' = 'Operates on Holidays');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `operates_weekends` SET TAGS ('dbx_business_glossary_term' = 'Operates on Weekends');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `operating_hours_end` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours End Time');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `operating_hours_end` SET TAGS ('dbx_value_regex' = '^([01]d|2[0-3]):([0-5]d)$');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `operating_hours_start` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Start Time');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `operating_hours_start` SET TAGS ('dbx_value_regex' = '^([01]d|2[0-3]):([0-5]d)$');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Team Phone Number');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `physical_location` SET TAGS ('dbx_business_glossary_term' = 'Physical Location');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `primary_function` SET TAGS ('dbx_business_glossary_term' = 'Primary Function');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `quality_score_target` SET TAGS ('dbx_business_glossary_term' = 'Quality Score Target (Percentage)');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'standard|priority|premium|vip');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `specialization_tags` SET TAGS ('dbx_business_glossary_term' = 'Specialization Tags');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `target_first_response_minutes` SET TAGS ('dbx_business_glossary_term' = 'Target First Response Time (Minutes)');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `target_resolution_hours` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution Time (Hours)');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `team_code` SET TAGS ('dbx_business_glossary_term' = 'Team Code');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `team_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `team_name` SET TAGS ('dbx_business_glossary_term' = 'Team Name');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `team_status` SET TAGS ('dbx_business_glossary_term' = 'Team Status');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `team_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|dissolved');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `team_type` SET TAGS ('dbx_business_glossary_term' = 'Team Type');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `team_type` SET TAGS ('dbx_value_regex' = 'tier_1_frontline|tier_2_escalation|specialist|back_office|quality_assurance|training');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `ecommerce_ecm`.`service`.`team` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Timezone');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` SET TAGS ('dbx_subdomain' = 'customer_support');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `sla_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Policy ID');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `superseded_by_policy_sla_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By SLA Policy ID');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'SLA Policy Approval Status');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `approved_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `approved_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `approved_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SLA Policy Approval Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `auto_escalation_enabled` SET TAGS ('dbx_business_glossary_term' = 'Automatic Escalation Enabled Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `breach_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Penalty Amount');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `breach_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `breach_penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Penalty Currency');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `breach_penalty_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `breach_penalty_type` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Penalty Type');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `breach_penalty_type` SET TAGS ('dbx_value_regex' = 'none|financial|credit|escalation|notification');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `business_days` SET TAGS ('dbx_business_glossary_term' = 'Business Days of Week');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `business_hours_end` SET TAGS ('dbx_business_glossary_term' = 'Business Hours End Time');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `business_hours_end` SET TAGS ('dbx_value_regex' = '^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `business_hours_start` SET TAGS ('dbx_business_glossary_term' = 'Business Hours Start Time');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `business_hours_start` SET TAGS ('dbx_value_regex' = '^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `case_priority` SET TAGS ('dbx_business_glossary_term' = 'Applicable Case Priority');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `case_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Case Type');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Service Channel');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'phone|email|chat|social_media|self_service|in_person');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Required Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SLA Policy Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Applicable Customer Segment');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'SLA Policy Effective End Date');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'SLA Policy Effective Start Date');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `escalation_threshold_hours` SET TAGS ('dbx_business_glossary_term' = 'Escalation Trigger Threshold (Hours)');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `exclusions` SET TAGS ('dbx_business_glossary_term' = 'SLA Policy Exclusions');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `first_response_target_hours` SET TAGS ('dbx_business_glossary_term' = 'First Response Time Target (Hours)');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Applicable Geographic Region');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `is_default_policy` SET TAGS ('dbx_business_glossary_term' = 'Default SLA Policy Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SLA Policy Last Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `notification_enabled` SET TAGS ('dbx_business_glossary_term' = 'SLA Notification Enabled Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `notification_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Notification Threshold Percentage');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `owner_user_code` SET TAGS ('dbx_business_glossary_term' = 'SLA Policy Owner User ID');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `owner_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `owner_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'SLA Policy Code');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'SLA Policy Name');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'SLA Policy Type');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'customer_support|technical_support|returns|escalation|vip|standard');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulatory Framework');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `resolution_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Resolution Time Target (Hours)');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `sla_policy_description` SET TAGS ('dbx_business_glossary_term' = 'SLA Policy Description');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `sla_policy_status` SET TAGS ('dbx_business_glossary_term' = 'SLA Policy Status');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `sla_policy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived|suspended');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `time_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Time Calculation Method');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `time_calculation_method` SET TAGS ('dbx_value_regex' = 'business_hours|calendar_hours');
ALTER TABLE `ecommerce_ecm`.`service`.`sla_policy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'SLA Policy Version Number');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` SET TAGS ('dbx_subdomain' = 'customer_support');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `escalation_id` SET TAGS ('dbx_business_glossary_term' = 'Escalation ID');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Escalating Agent ID');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `receiving_agent_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Agent ID');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Team ID');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `service_support_case_id` SET TAGS ('dbx_business_glossary_term' = 'Case ID');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Escalation Channel');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'phone|email|chat|web|mobile_app|social_media');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `compensation_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensation Issued Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `compensation_issued_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `compensation_issued_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Type');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_value_regex' = 'refund|credit|discount|gift_card|free_shipping|product_replacement');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `cost` SET TAGS ('dbx_business_glossary_term' = 'Escalation Cost');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `customer_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Score');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'standard|premium|vip|enterprise');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `escalation_number` SET TAGS ('dbx_business_glossary_term' = 'Escalation Number');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `escalation_number` SET TAGS ('dbx_value_regex' = '^ESC-[0-9]{8}$');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `escalation_status` SET TAGS ('dbx_business_glossary_term' = 'Escalation Status');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `escalation_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|resolved|closed|cancelled');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `escalation_type` SET TAGS ('dbx_business_glossary_term' = 'Escalation Type');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `escalation_type` SET TAGS ('dbx_value_regex' = 'functional|hierarchical|automatic|manual');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Escalation Notes');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Escalation Priority');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical|urgent');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `reason` SET TAGS ('dbx_value_regex' = 'sla_breach|customer_demand|complexity|vip_customer|regulatory_concern|repeat_issue');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `resolution_at_escalated_tier_flag` SET TAGS ('dbx_business_glossary_term' = 'Resolution at Escalated Tier Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `resolution_code` SET TAGS ('dbx_business_glossary_term' = 'Resolution Code');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Breach Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `sla_target_resolution_minutes` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Target Resolution Minutes');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `source_tier` SET TAGS ('dbx_business_glossary_term' = 'Source Tier');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `source_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|specialist');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `target_tier` SET TAGS ('dbx_business_glossary_term' = 'Target Tier');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `target_tier` SET TAGS ('dbx_value_regex' = 'tier_2|tier_3|specialist|supervisor|manager|executive');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `time_to_resolution_minutes` SET TAGS ('dbx_business_glossary_term' = 'Time to Resolution Minutes');
ALTER TABLE `ecommerce_ecm`.`service`.`escalation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` SET TAGS ('dbx_subdomain' = 'customer_support');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `feedback_response_id` SET TAGS ('dbx_business_glossary_term' = 'Feedback Response Identifier');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Support Agent ID');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `service_support_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Case ID');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `case_category` SET TAGS ('dbx_business_glossary_term' = 'Service Case Category');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `case_resolution_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Case Resolution Time in Hours');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `channel_of_service` SET TAGS ('dbx_business_glossary_term' = 'Service Channel');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `classification_category` SET TAGS ('dbx_business_glossary_term' = 'Feedback Classification Category');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `contact_reason` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Reason');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_business_glossary_term' = 'Survey Delivery Channel');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_value_regex' = 'email|SMS|in-app|web|IVR|chat');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Case Escalation Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `external_survey_reference` SET TAGS ('dbx_business_glossary_term' = 'External Survey Response ID');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `first_contact_resolution_flag` SET TAGS ('dbx_business_glossary_term' = 'First Contact Resolution (FCR) Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `follow_up_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Action Required Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `follow_up_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Completed Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `follow_up_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Completed Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `incentive_offered_flag` SET TAGS ('dbx_business_glossary_term' = 'Survey Incentive Offered Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `interaction_count` SET TAGS ('dbx_business_glossary_term' = 'Interaction Count');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `numeric_score` SET TAGS ('dbx_business_glossary_term' = 'Numeric Feedback Score');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `primary_feedback_theme` SET TAGS ('dbx_business_glossary_term' = 'Primary Feedback Theme');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `response_device_type` SET TAGS ('dbx_business_glossary_term' = 'Response Device Type');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `response_device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|unknown');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `response_language` SET TAGS ('dbx_business_glossary_term' = 'Response Language Code');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `response_status` SET TAGS ('dbx_business_glossary_term' = 'Survey Response Status');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `response_status` SET TAGS ('dbx_value_regex' = 'completed|partial|abandoned|expired|bounced');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `secondary_feedback_theme` SET TAGS ('dbx_business_glossary_term' = 'Secondary Feedback Theme');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `sentiment_classification` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Classification');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `sentiment_classification` SET TAGS ('dbx_value_regex' = 'positive|neutral|negative|mixed');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Analysis Score');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Met Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `survey_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Survey Sent Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `survey_trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Survey Trigger Event');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `survey_trigger_event` SET TAGS ('dbx_value_regex' = 'case_closed|order_delivered|periodic_relationship|return_completed|refund_issued|escalation_resolved');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'CSAT|NPS|CES|Post-Delivery|Relationship|Post-Case');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `survey_version` SET TAGS ('dbx_business_glossary_term' = 'Survey Version Identifier');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `verbatim_feedback_text` SET TAGS ('dbx_business_glossary_term' = 'Verbatim Feedback Text');
ALTER TABLE `ecommerce_ecm`.`service`.`feedback_response` ALTER COLUMN `verbatim_feedback_text` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` SET TAGS ('dbx_subdomain' = 'customer_support');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `knowledge_article_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Article ID');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category ID');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `index_id` SET TAGS ('dbx_business_glossary_term' = 'Index Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Content Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `marketplace_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Listing Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Author Agent ID');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `reviewer_agent_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Agent ID');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `agent_usage_count` SET TAGS ('dbx_business_glossary_term' = 'Agent Usage Count');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `article_number` SET TAGS ('dbx_business_glossary_term' = 'Article Number');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `article_number` SET TAGS ('dbx_value_regex' = '^KA-[0-9]{8}$');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `article_type` SET TAGS ('dbx_business_glossary_term' = 'Article Type');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `article_type` SET TAGS ('dbx_value_regex' = 'faq|troubleshooting_guide|policy_document|how_to|known_issue|product_documentation');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `attachment_urls` SET TAGS ('dbx_business_glossary_term' = 'Attachment URLs');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `case_deflection_count` SET TAGS ('dbx_business_glossary_term' = 'Case Deflection Count');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `case_type_tags` SET TAGS ('dbx_business_glossary_term' = 'Case Type Tags');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `content_body` SET TAGS ('dbx_business_glossary_term' = 'Content Body');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `helpful_votes` SET TAGS ('dbx_business_glossary_term' = 'Helpful Votes');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `helpfulness_score` SET TAGS ('dbx_business_glossary_term' = 'Helpfulness Score');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `issue_taxonomy_tags` SET TAGS ('dbx_business_glossary_term' = 'Issue Taxonomy Tags');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `knowledge_article_status` SET TAGS ('dbx_business_glossary_term' = 'Article Status');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `knowledge_article_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|published|archived|expired');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `locale` SET TAGS ('dbx_business_glossary_term' = 'Locale Code');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `locale` SET TAGS ('dbx_value_regex' = '^[a-z]{2}_[A-Z]{2}$');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `not_helpful_votes` SET TAGS ('dbx_business_glossary_term' = 'Not Helpful Votes');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `publish_date` SET TAGS ('dbx_business_glossary_term' = 'Publish Date');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `related_article_ids` SET TAGS ('dbx_business_glossary_term' = 'Related Article IDs');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `review_by_date` SET TAGS ('dbx_business_glossary_term' = 'Review By Date');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `search_keywords` SET TAGS ('dbx_business_glossary_term' = 'Search Keywords');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Article Title');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `view_count` SET TAGS ('dbx_business_glossary_term' = 'View Count');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `visibility_scope` SET TAGS ('dbx_business_glossary_term' = 'Visibility Scope');
ALTER TABLE `ecommerce_ecm`.`service`.`knowledge_article` ALTER COLUMN `visibility_scope` SET TAGS ('dbx_value_regex' = 'internal_only|customer_facing|partner_portal|public');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` SET TAGS ('dbx_subdomain' = 'customer_support');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `case_status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Case Status History ID');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Team ID');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) ID');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `service_support_case_id` SET TAGS ('dbx_business_glossary_term' = 'Support Case ID');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Triggered By Agent ID');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `automation_rule_code` SET TAGS ('dbx_business_glossary_term' = 'Automation Rule ID');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `business_hours_flag` SET TAGS ('dbx_business_glossary_term' = 'Business Hours Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `case_category` SET TAGS ('dbx_business_glossary_term' = 'Case Category');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Support Case Number');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Support Channel');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `comment_added_flag` SET TAGS ('dbx_business_glossary_term' = 'Comment Added Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Case Status');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `notification_channel` SET TAGS ('dbx_value_regex' = 'email|sms|push|in_app|none');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Case Status');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `priority_at_transition` SET TAGS ('dbx_business_glossary_term' = 'Priority At Transition');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `priority_at_transition` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `sla_target_seconds` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target (Seconds)');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `time_in_previous_status_seconds` SET TAGS ('dbx_business_glossary_term' = 'Time In Previous Status (Seconds)');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `transition_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Transition Reason Code');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `transition_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Transition Reason Description');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `transition_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Transition Sequence Number');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `transition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`case_status_history` ALTER COLUMN `triggered_by_system` SET TAGS ('dbx_business_glossary_term' = 'Triggered By System');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` SET TAGS ('dbx_subdomain' = 'customer_support');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Entitlement ID');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `annual_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Fee Amount');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `business_hours_coverage` SET TAGS ('dbx_business_glossary_term' = 'Business Hours Coverage');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `business_hours_coverage` SET TAGS ('dbx_value_regex' = 'business_hours|extended|24x7');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `cancellation_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Notice Days');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `concierge_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Concierge Service Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `contact_channels` SET TAGS ('dbx_business_glossary_term' = 'Contact Channels');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'standard|prime|vip|b2b_enterprise|seller|partner');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `dedicated_agent_flag` SET TAGS ('dbx_business_glossary_term' = 'Dedicated Agent Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `entitlement_code` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Code');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `entitlement_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{6,20}$');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `entitlement_description` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Description');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `entitlement_name` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Name');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `entitlement_status` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Status');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `entitlement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `escalation_path` SET TAGS ('dbx_business_glossary_term' = 'Escalation Path');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `escalation_path` SET TAGS ('dbx_value_regex' = 'standard|expedited|executive|none');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `free_return_shipping_flag` SET TAGS ('dbx_business_glossary_term' = 'Free Return Shipping Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `language_support` SET TAGS ('dbx_business_glossary_term' = 'Language Support');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `max_cases_per_month` SET TAGS ('dbx_business_glossary_term' = 'Maximum Cases Per Month');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `monthly_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Fee Amount');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_value_regex' = 'free|basic|standard|premium|enterprise');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `priority_routing_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Routing Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `proactive_outreach_flag` SET TAGS ('dbx_business_glossary_term' = 'Proactive Outreach Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `refund_processing_priority` SET TAGS ('dbx_business_glossary_term' = 'Refund Processing Priority');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `refund_processing_priority` SET TAGS ('dbx_value_regex' = 'standard|expedited|immediate');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `resolution_time_sla_hours` SET TAGS ('dbx_business_glossary_term' = 'Resolution Time Service Level Agreement (SLA) Hours');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `response_time_sla_hours` SET TAGS ('dbx_business_glossary_term' = 'Response Time Service Level Agreement (SLA) Hours');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `return_window_days` SET TAGS ('dbx_business_glossary_term' = 'Return Window Days');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `rma_auto_approval_flag` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Auto-Approval Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `self_service_access_level` SET TAGS ('dbx_business_glossary_term' = 'Self-Service Access Level');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `self_service_access_level` SET TAGS ('dbx_value_regex' = 'basic|advanced|premium|full');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `sla_document_url` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Document Uniform Resource Locator (URL)');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `sla_document_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `support_tier` SET TAGS ('dbx_business_glossary_term' = 'Support Tier');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `support_tier` SET TAGS ('dbx_value_regex' = 'basic|priority|premium|dedicated|enterprise');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `technical_support_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Technical Support Included Flag');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `terms_and_conditions_url` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions Uniform Resource Locator (URL)');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `terms_and_conditions_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `trial_period_days` SET TAGS ('dbx_business_glossary_term' = 'Trial Period Days');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `ecommerce_ecm`.`service`.`entitlement` ALTER COLUMN `warranty_extension_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Extension Months');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` SET TAGS ('dbx_subdomain' = 'customer_support');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `case_queue_id` SET TAGS ('dbx_business_glossary_term' = 'Case Queue ID');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Team Identifier (TEAM_ID)');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Escalation Policy Identifier (ESCALATION_POLICY_ID)');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `overflow_case_queue_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `average_wait_time_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Target Average Wait Time (MINUTES)');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `capacity_limit` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concurrent Cases Capacity (CAPACITY_LIMIT)');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `case_queue_description` SET TAGS ('dbx_business_glossary_term' = 'Queue Description (DESC)');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `case_queue_name` SET TAGS ('dbx_business_glossary_term' = 'Queue Name (NAME)');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `case_queue_status` SET TAGS ('dbx_business_glossary_term' = 'Queue Lifecycle Status (STATUS)');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `case_queue_status` SET TAGS ('dbx_value_regex' = 'active|inactive|paused|decommissioned');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFFECTIVE_END)');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFFECTIVE_START)');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `is_priority_queue` SET TAGS ('dbx_business_glossary_term' = 'Priority Queue Flag (IS_PRIORITY)');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `last_modified_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (USER_ID)');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `last_modified_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `last_modified_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `max_wait_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Maximum Allowed Wait Time (MINUTES)');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `operating_hours_end` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours End Time (END_TIME)');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `operating_hours_end` SET TAGS ('dbx_value_regex' = '^([01]d|2[0-3]):[0-5]d$');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `operating_hours_start` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Start Time (START_TIME)');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `operating_hours_start` SET TAGS ('dbx_value_regex' = '^([01]d|2[0-3]):[0-5]d$');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `overflow_routing_rule` SET TAGS ('dbx_business_glossary_term' = 'Overflow Routing Rule (OVERFLOW_RULE)');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `queue_depth_limit` SET TAGS ('dbx_business_glossary_term' = 'Maximum Queue Depth Limit (DEPTH_LIMIT)');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `queue_type` SET TAGS ('dbx_business_glossary_term' = 'Queue Type (TYPE)');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `queue_type` SET TAGS ('dbx_value_regex' = 'skill_based|round_robin|priority|overflow');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `routing_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Routing Algorithm (ALGORITHM)');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `routing_algorithm` SET TAGS ('dbx_value_regex' = 'skill_based|round_robin|weighted|custom');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `sla_target_abandon_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Abandon Rate Percentage (PERCENT)');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `sla_target_average_wait_minutes` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Average Wait Time (MINUTES)');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone (TZ)');
ALTER TABLE `ecommerce_ecm`.`service`.`case_queue` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Update Timestamp (UPDATED_TS)');
