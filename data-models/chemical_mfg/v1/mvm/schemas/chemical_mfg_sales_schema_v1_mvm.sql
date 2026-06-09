-- Schema for Domain: sales | Business: Chemical Mfg | Version: v1_mvm
-- Generated on: 2026-05-06 14:37:12

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `chemical_mfg_ecm`.`sales` COMMENT 'Commercial sales domain managing sales opportunities, quotes, contracts, pricing agreements, customer negotiations, sales pipeline, territory management, distributor channel data, and sales performance metrics. Supports technical sales with product application guidance and customer-specific formulations. Integrates with Salesforce CRM and SAP SD to drive revenue growth and customer acquisition.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`sales`.`opportunity` (
    `opportunity_id` BIGINT COMMENT 'Unique surrogate identifier for the sales opportunity record in the lakehouse silver layer. Primary key for this entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer account (industrial buyer, distributor, or end-user) associated with this opportunity. Links to the customer/account master data product.',
    `contact_id` BIGINT COMMENT 'Reference to the primary customer contact person (e.g., procurement manager, technical buyer) associated with this opportunity. Links to the contact master data product.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Opportunities in chemical mfg are pursued by a specific legal entity — required for export control (TSCA/REACH jurisdiction), intercompany deal routing, and statutory revenue recognition reporting.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Opportunities are tracked against profit centers for pipeline-to-revenue forecasting in chemical mfg financial planning. Finance uses this link to project expected revenue by profit center from the sa',
    `quality_specification_id` BIGINT COMMENT 'Foreign key linking to quality.quality_specification. Business justification: Opportunity qualification requires checking the products quality specification to ensure regulatory compliance and customer requirements.',
    `reach_dossier_id` BIGINT COMMENT 'Foreign key linking to product.reach_dossier. Business justification: REACH compliance is a legal prerequisite for selling chemicals in the EU market. When reach_compliance_required=true on an opportunity, the sales team must verify a valid REACH dossier exists. FK to r',
    `regulatory_profile_id` BIGINT COMMENT 'Foreign key linking to customer.regulatory_profile. Business justification: Chemical sales opportunities must be validated against the customers regulatory profile (REACH registration, TSCA applicability, export licenses). Linking opportunity to regulatory_profile enables co',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Chemical sales pipeline reporting by market segment (automotive, electronics, agriculture) is standard practice. opportunity.application_segment is a denormalized text field; replacing with segment_id',
    `site_id` BIGINT COMMENT 'Foreign key linking to customer.site. Business justification: Opportunity delivery planning uses the Customer Site to calculate logistics, compliance (REACH/SDS) and shipping terms.',
    `territory_id` BIGINT COMMENT 'Reference to the sales territory to which this opportunity is assigned. Supports territory-based pipeline reporting, quota management, and regional performance analytics.',
    `actual_close_date` DATE COMMENT 'The actual date on which the opportunity was closed (won or lost). Populated upon opportunity closure. Used for sales cycle analysis, win/loss reporting, and period attribution. Format: yyyy-MM-dd.',
    `close_probability_pct` DECIMAL(18,2) COMMENT 'Estimated probability (0.00–100.00%) that this opportunity will be won, as assessed by the sales representative or derived from stage-based defaults. Used in weighted pipeline calculations and revenue forecasting models.',
    `close_reason` STRING COMMENT 'Structured reason code explaining why the opportunity was won or lost. Captures the primary decision criterion at closure. Used for competitive intelligence, win/loss analysis, and sales strategy refinement. [ENUM-REF-CANDIDATE: Price|Technical Fit|Relationship|Competitor|Timeline|Budget|No Decision|Other — promote to reference product]',
    `closed_amount` DECIMAL(18,2) COMMENT 'Actual deal value at the time of opportunity closure (won or lost). May differ from estimated_amount due to negotiation, scope changes, or competitive pricing adjustments. Used for win/loss revenue analysis and competitive intelligence.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the opportunity record was first created in the source CRM system (Salesforce). Used for pipeline aging, sales cycle duration measurement, and audit trail. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `crm_opportunity_code` STRING COMMENT 'Native opportunity identifier from Salesforce CRM (e.g., 006XXXXXXXXXXXXXXX). Used for cross-system traceability and reconciliation with the source system of record.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the estimated and closed deal amounts (e.g., USD, EUR, GBP). Supports multi-currency pipeline reporting and FX conversion in SAP FI/CO.. Valid values are `^[A-Z]{3}$`',
    `decision_criteria` STRING COMMENT 'Free-text or structured description of the customers primary evaluation criteria for this opportunity (e.g., price, technical performance, regulatory compliance, delivery reliability, sustainability). Supports win/loss analysis and sales strategy development.',
    `estimated_amount` DECIMAL(18,2) COMMENT 'Estimated total deal value (revenue) for this opportunity in the transaction currency. Represents the gross revenue expected if the opportunity is won. Used for pipeline valuation, quota tracking, and revenue forecasting. Aligns with SAP SD pricing and SAP FI/CO revenue planning.',
    `estimated_volume_kg` DECIMAL(18,2) COMMENT 'Estimated annual or deal-period volume of chemical product(s) in kilograms associated with this opportunity. Used for supply chain capacity planning, raw material procurement forecasting, and production scheduling alignment with SAP PP.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter in which the opportunity is expected to close, formatted as Q[1-4]-YYYY (e.g., Q3-2024). Used for period-based pipeline reporting, quota attainment tracking, and financial forecasting aligned with SAP FI/CO fiscal calendar.. Valid values are `^Q[1-4]-[0-9]{4}$`',
    `forecast_category` STRING COMMENT 'Sales forecast classification assigned to the opportunity, indicating the confidence level for revenue recognition in the current period. Used in executive revenue forecasting and financial planning aligned with SAP FI/CO reporting.. Valid values are `Pipeline|Best Case|Commit|Closed|Omitted`',
    `is_key_account` BOOLEAN COMMENT 'Indicates whether this opportunity is associated with a strategically designated key account (True) requiring executive sponsorship, dedicated account management, and priority resource allocation. Used for key account management reporting.',
    `is_won` BOOLEAN COMMENT 'Boolean flag indicating whether the opportunity was closed as won (True) or lost/abandoned (False). Null if the opportunity is still open. Used for win rate calculations and pipeline conversion reporting.',
    `last_activity_date` DATE COMMENT 'Date of the most recent sales activity (call, email, meeting, task) logged against this opportunity in Salesforce CRM. Used for pipeline hygiene monitoring, stale opportunity identification, and sales rep engagement tracking. Format: yyyy-MM-dd.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the opportunity record was last updated in the source CRM system (Salesforce). Used for change detection, incremental data loading, and audit trail. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `lead_source` STRING COMMENT 'Channel or origin through which this opportunity was identified or generated. Used for marketing attribution, channel effectiveness analysis, and sales pipeline sourcing analytics. [ENUM-REF-CANDIDATE: Inbound|Trade Show|Referral|Cold Outreach|Distributor|Web|Other — promote to reference product]',
    `next_step` STRING COMMENT 'Free-text description of the immediate next action required to advance this opportunity (e.g., Schedule technical demo, Submit COA for customer qualification, Negotiate pricing terms). Used by sales representatives for pipeline management and CRM activity tracking.',
    `opportunity_description` STRING COMMENT 'Free-text narrative describing the opportunity context, customer requirements, technical application details, and strategic importance. Supports sales team knowledge sharing and opportunity review meetings.',
    `opportunity_name` STRING COMMENT 'Human-readable name or title of the sales opportunity, typically describing the customer, product line, and deal context (e.g., Acme Corp - Specialty Solvents Q3 2024). Used for pipeline reporting and sales team communication.',
    `opportunity_type` STRING COMMENT 'Classification of the opportunity by business development type. Distinguishes new customer acquisition from expansion of existing accounts, contract renewals, win-back of lost customers, and channel type (distributor vs. direct). [ENUM-REF-CANDIDATE: New Business|Existing Business Expansion|Renewal|Win-Back|Distributor|Direct — promote to reference product]. Valid values are `New Business|Existing Business Expansion|Renewal|Win-Back|Distributor|Direct`',
    `product_line` STRING COMMENT 'The primary chemical product line or portfolio segment associated with this opportunity (e.g., Specialty Solvents, Performance Polymers, Agricultural Chemicals, Adhesives). Used for product-level pipeline and revenue mix reporting.',
    `reach_compliance_required` BOOLEAN COMMENT 'Indicates whether the opportunity involves chemical substances subject to REACH registration, evaluation, or authorization requirements under EU regulation. Triggers regulatory compliance review and ECHA documentation workflow.',
    `requires_custom_formulation` BOOLEAN COMMENT 'Indicates whether this opportunity requires a customer-specific chemical formulation or product development engagement (True) versus a standard catalogue product (False). Triggers R&D and technical sales involvement when True.',
    `requires_sds` BOOLEAN COMMENT 'Indicates whether the customer has requested or requires a Safety Data Sheet (SDS) / Material Safety Data Sheet (MSDS) as part of the sales process. Relevant for GHS compliance and REACH regulatory submissions.',
    `sales_channel` STRING COMMENT 'The commercial channel through which this opportunity is being pursued. Distinguishes direct sales from distributor-mediated, agent-based, e-commerce, or tender/bid processes. Used for channel performance analytics and margin analysis.. Valid values are `Direct|Distributor|Agent|E-Commerce|Tender`',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this opportunity record was sourced (e.g., Salesforce CRM, SAP SD, Manual entry). Used for data lineage tracking and reconciliation in the Databricks lakehouse silver layer.. Valid values are `Salesforce|SAP SD|Manual`',
    `stage` STRING COMMENT 'Current stage of the opportunity in the sales pipeline lifecycle. Drives pipeline forecasting, stage-gate reviews, and funnel conversion analytics. [ENUM-REF-CANDIDATE: Prospecting|Qualification|Needs Analysis|Proposal|Negotiation|Closed Won|Closed Lost — promote to reference product]',
    `target_close_date` DATE COMMENT 'Expected date by which the opportunity will be won or lost. Drives pipeline aging analysis, period-end forecasting, and sales cycle duration reporting. Format: yyyy-MM-dd.',
    `tsca_compliance_required` BOOLEAN COMMENT 'Indicates whether the opportunity involves chemical substances subject to TSCA inventory listing, reporting, or restriction requirements under US EPA regulation. Triggers regulatory compliance review.',
    CONSTRAINT pk_opportunity PRIMARY KEY(`opportunity_id`)
) COMMENT 'Core sales opportunity record tracking prospective deals with industrial chemical customers, distributors, and end-users. Captures opportunity stage progression, estimated deal value, probability of close, target close date, and owning sales representative. Includes opportunity-level product associations (per-product quantity, estimated revenue, competitive status) for pipeline visibility. Records structured win/loss outcome on closure (close reason, competitor displaced/displacing, decision criteria, deal value at close) for competitive intelligence. Sourced from Salesforce CRM. Primary pipeline management and forecasting entity for commercial sales.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`sales`.`quote` (
    `quote_id` BIGINT COMMENT 'Unique surrogate identifier for the price quotation record in the lakehouse silver layer. Primary key for the quote entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer or distributor to whom this quotation is issued. Links to the customer master record.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Chemical quotes are addressed to specific purchasing or technical contacts who have authority to accept pricing. Linking quote to contact enables proper document routing, COA/SDS delivery per contact ',
    `contract_id` BIGINT COMMENT 'Reference to the master pricing agreement or sales contract under which this quotation is issued, linking spot quotes to long-term contractual frameworks.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Quotes in chemical mfg are issued by a specific legal entity — critical for VAT/tax determination, export control compliance, and intercompany pricing. A domain expert would expect this link for statu',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Quote generation attaches SDS, REACH, TSCA compliance data; linking to material_master provides authoritative source for those attributes.',
    `opportunity_id` BIGINT COMMENT 'Reference to the Salesforce CRM sales opportunity from which this quotation was generated, enabling pipeline-to-revenue traceability and win/loss analysis.',
    `organization_id` BIGINT COMMENT 'Reference to the SAP SD sales organization responsible for issuing this quotation, defining the legal selling entity and pricing hierarchy.',
    `price_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.price_agreement. Business justification: While quote_line already carries a price_agreement_id at the line level, a quote header may be governed by a single overarching price agreement (e.g., a long-term supply agreement or contract price). ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Chemical mfg quotes are priced and margin-reported by profit center (e.g., Performance Materials vs. Ag Solutions). Revenue recognition and contribution margin reporting in CO-PA require knowing which',
    `qualification_id` BIGINT COMMENT 'Foreign key linking to customer.qualification. Business justification: Chemical quotes must reference the customer qualification record confirming the product grade/spec is approved for that customers use case. Quoting against an unqualified product-customer combination',
    `quality_specification_id` BIGINT COMMENT 'Foreign key linking to quality.quality_specification. Business justification: Chemical quotes must reference the quality specification defining purity, grade, and acceptance criteria for the product being sold. This drives CoA/CoC issuance and ensures the customer receives exac',
    `regulatory_profile_id` BIGINT COMMENT 'Foreign key linking to customer.regulatory_profile. Business justification: Chemical quotes require regulatory validation at generation time — export control flags, REACH compliance, and SDS version requirements are driven by the customers regulatory profile. This link enabl',
    `sds_id` BIGINT COMMENT 'Foreign key linking to product.sds. Business justification: Every chemical quote must reference the current SDS version for OSHA HazCom and REACH regulatory compliance. The sds_version plain-text field is denormalized; FK to sds ensures the correct SDS documen',
    `site_id` BIGINT COMMENT 'Foreign key linking to customer.site. Business justification: Quotes must reference the specific Customer Site for accurate pricing, tax, incoterms and regulatory documentation.',
    `coa_required` BOOLEAN COMMENT 'Indicates whether the customer requires a Certificate of Analysis (COA) to accompany the chemical product shipment, confirming that the product meets specified quality parameters. Drives LabWare LIMS documentation workflow.',
    `coc_required` BOOLEAN COMMENT 'Indicates whether the customer requires a Certificate of Compliance (COC) confirming the product meets regulatory, contractual, or customer-specific specification requirements.',
    `converted_order_number` STRING COMMENT 'SAP SD sales order document number created when this quotation is accepted and converted to a binding sales order, enabling end-to-end quote-to-cash traceability.. Valid values are `^[0-9]{10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this quotation record was first captured in the system, used for audit trail and data lineage tracking.',
    `crm_quote_number` STRING COMMENT 'The Salesforce CRM quote object identifier, enabling bidirectional traceability between the CRM pipeline and the SAP SD quotation document.. Valid values are `^Q-[0-9]{6,10}$`',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which all monetary values on this quotation are denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `customer_po_number` STRING COMMENT 'Customers own Purchase Order (PO) reference number provided with the RFQ or acceptance, required for invoice matching and customer accounts payable reconciliation.',
    `distribution_channel_code` STRING COMMENT 'SAP SD distribution channel code indicating the route to market for this quotation (e.g., direct, distributor, e-commerce), affecting pricing and availability determination.',
    `division_code` STRING COMMENT 'SAP SD division code representing the product line or business unit (e.g., Performance Materials, Agricultural Solutions, Plastics) responsible for this quotation.',
    `export_control_flag` BOOLEAN COMMENT 'Indicates whether any product in this quotation is subject to export control regulations, triggering mandatory compliance review before order conversion (e.g., EAR, ITAR, dual-use chemical controls).',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total gross value of the quotation before application of discounts, surcharges, and taxes, expressed in the quotation currency. Supports margin analysis and revenue forecasting.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the quoted products are classified as hazardous materials under DOT, IATA, or IMDG regulations, requiring special packaging, labeling, and transport documentation.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms 2020) code defining the delivery obligations, risk transfer point, and cost allocation between seller and buyer for chemical product shipments.. Valid values are `^(EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF)$`',
    `incoterms_location` STRING COMMENT 'Named place or port associated with the Incoterms code, specifying the exact point of delivery or risk transfer (e.g., FOB Houston Port). Required for complete Incoterms specification per ICC rules.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent modification to this quotation record, supporting change tracking and incremental data pipeline processing.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net total value of the quotation after all discounts and surcharges but before tax, representing the agreed commercial value. Core metric for margin analysis at the quote level.',
    `payment_terms_code` STRING COMMENT 'SAP SD payment terms key defining the agreed payment schedule, early payment discount conditions, and due date calculation for the customer invoice (e.g., NT30, 2/10NET30).',
    `price_list_type` STRING COMMENT 'Classification of the pricing basis applied to this quotation, determining which SAP SD condition records and pricing procedures are used for calculation.. Valid values are `standard|contract|spot|distributor|transfer`',
    `pricing_date` DATE COMMENT 'The reference date used to determine applicable price lists, condition records, and raw material index values for pricing calculation. May differ from quote_date for forward-priced contracts.',
    `quote_date` DATE COMMENT 'The business date on which the quotation was formally issued to the customer or distributor. Represents the principal real-world event date for this transaction.',
    `quote_status` STRING COMMENT 'Current lifecycle state of the quotation, tracking progression from initial draft through customer acceptance or expiry. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|expired|converted|cancelled — promote to reference product]',
    `quote_type` STRING COMMENT 'Classification of the quotation by commercial purpose: standard customer quote, spot market offer, contract pricing, distributor channel, intercompany transfer, or product sample. [ENUM-REF-CANDIDATE: standard|spot|contract|distributor|intercompany|sample — promote to reference product]. Valid values are `standard|spot|contract|distributor|intercompany|sample`',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether all chemical substances in this quotation are registered and compliant under REACH Regulation (EC) No 1907/2006 for the destination market, required for EU export.',
    `rejection_reason_code` STRING COMMENT 'Coded reason for quotation rejection or loss, populated when quote_status transitions to rejected or cancelled. Supports win/loss analysis and competitive intelligence. [ENUM-REF-CANDIDATE: price_too_high|competitor_selected|spec_mismatch|delivery_terms|no_decision|budget_cancelled — promote to reference product]',
    `requested_delivery_date` DATE COMMENT 'Customer-requested delivery date for the quoted chemical products, used for production scheduling, ATP (Available-to-Promise) checks, and logistics planning.',
    `sales_district_code` STRING COMMENT 'SAP SD sales district code identifying the geographic territory assignment for this quotation, used for territory management, sales performance reporting, and commission calculation.',
    `sap_quotation_number` STRING COMMENT 'The externally-known 10-digit SAP SD quotation document number used for cross-system reference and customer-facing communication.. Valid values are `^[0-9]{10}$`',
    `ship_to_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the destination country for chemical product delivery. Drives export control screening, REACH compliance checks, and hazardous material transport regulations.. Valid values are `^[A-Z]{3}$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to the quotation, including VAT, GST, or applicable excise duties on chemical products, calculated per the customers tax jurisdiction.',
    `technical_notes` STRING COMMENT 'Free-text field capturing technical sales notes, application guidance, customer-specific formulation requirements, or special handling instructions relevant to the quoted chemical products.',
    `total_discount_amount` DECIMAL(18,2) COMMENT 'Aggregate monetary discount applied across all line items on the quotation, including volume rebates, customer-specific pricing adjustments, and promotional discounts.',
    `total_surcharge_amount` DECIMAL(18,2) COMMENT 'Aggregate surcharges applied at the header level, including energy surcharges, raw material index surcharges, hazardous material handling fees, and freight surcharges.',
    `valid_from_date` DATE COMMENT 'The start date from which the quoted prices, terms, and conditions are binding and may be accepted by the customer.',
    `valid_to_date` DATE COMMENT 'The expiry date after which the quoted prices and terms are no longer binding. Drives automated expiry workflows and renewal alerts.',
    `win_probability_pct` DECIMAL(18,2) COMMENT 'Sales representatives estimated probability (0.00–100.00%) that this quotation will be accepted and converted to a sales order, used for pipeline forecasting and revenue planning.',
    CONSTRAINT pk_quote PRIMARY KEY(`quote_id`)
) COMMENT 'Formal price quotation issued to a customer or distributor for chemical products, including header-level terms (validity, incoterms, payment terms) and line-level detail (product/grade, quantity, UOM, per-line pricing, discounts, surcharges, COA/COC requirements). Supports RFQ response workflows and technical sales negotiations. Linked to SAP SD quotation and Salesforce CRM quote object. Enables granular margin analysis at the product-grade level.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`sales`.`quote_line` (
    `quote_line_id` BIGINT COMMENT 'Unique surrogate identifier for each individual line item within a customer quote. Primary key for the quote_line entity in the Databricks Silver Layer.',
    `cas_registry_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.cas_registry. Business justification: quote_line.cas_number is a denormalized reference to cas_registry. Chemical quote lines must reference the regulated substance for export control screening, REACH/TSCA compliance flagging, and hazmat ',
    `chemical_product_id` BIGINT COMMENT 'Reference to the chemical product, grade, or Stock Keeping Unit (SKU) being quoted on this line. Links to the product master for full material specifications.',
    `coa_template_id` BIGINT COMMENT 'Foreign key linking to quality.coa_template. Business justification: quote_line has coa_required flag. When CoA is required, the specific template must be designated at line level since different products/grades use different certificate formats. This drives automated ',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment. Business justification: Specialty chemical quote lines (process chemicals, lubricants, catalysts) are written for specific customer equipment (reactors, columns, tanks). This link enables equipment-specific pricing, technica',
    `functional_location_id` BIGINT COMMENT 'Reference to the manufacturing plant or distribution center designated to fulfill this quote line. Determines production scheduling, inventory sourcing, and applicable plant-level pricing.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Revenue posting requires each quote line to map to a GL account for accurate financial reporting and downstream invoicing.',
    `grade_id` BIGINT COMMENT 'Foreign key linking to product.grade. Business justification: Chemical grade (USP, ACS, technical) is a primary commercial differentiator on quote lines, driving price tier, regulatory compliance requirements, and COA/COC obligations. The product_grade plain-tex',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Available-to-promise quoting: in chemical manufacturing, quote lines for spot sales or batch-specific products reference a specific inventory lot to confirm availability, purity, COA/COC details, and ',
    `packaging_config_id` BIGINT COMMENT 'Foreign key linking to product.packaging_config. Business justification: Packaging configuration drives hazmat surcharges, UN certification requirements, and freight cost on chemical quote lines. The packaging_type plain-text field is denormalized; FK to packaging_config e',
    `price_agreement_id` BIGINT COMMENT 'Reference to the customer-specific pricing agreement, contract price list, or framework agreement that governs the unit price on this quote line. Links to long-term supply agreements and volume rebate contracts.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Quote lines in chemical mfg are assigned to profit centers for contribution margin reporting by business segment. CO-PA reporting requires line-level profit center assignment to analyze margin by prod',
    `quality_specification_id` BIGINT COMMENT 'Foreign key linking to quality.quality_specification. Business justification: Each quote line references a specific chemical product at a defined grade/spec. The quality specification at line level governs CoA generation, compliance reporting, and customer acceptance criteria. ',
    `quote_id` BIGINT COMMENT 'Reference to the parent customer quote header to which this line item belongs. Establishes the header-detail relationship between the quote and its individual line items.',
    `safety_data_sheet_id` BIGINT COMMENT 'Foreign key linking to ehs.safety_data_sheet. Business justification: OSHA HazCom 2012 / GHS / REACH require the current SDS version be attached to customer quote lines for hazardous chemical products. Sales teams must reference the authoritative EHS SDS record per prod',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Quote lines in chemical manufacturing are written at SKU level (specific pack size/configuration). The sku_code plain-text field is a denormalized reference; a proper FK to sku enables automated SDS v',
    `batch_managed` BOOLEAN COMMENT 'Indicates whether the chemical product on this quote line is subject to batch management and lot traceability requirements. Batch-managed products require Certificate of Analysis (COA) per lot and full GMP traceability.',
    `coa_required` BOOLEAN COMMENT 'Indicates whether the customer requires a Certificate of Analysis (COA) to accompany the shipment for this quote line. COA documents the actual quality test results for the specific production lot against specification limits.',
    `coc_required` BOOLEAN COMMENT 'Indicates whether the customer requires a Certificate of Compliance (COC) confirming the product meets all specified regulatory and contractual requirements. Common for food-contact, pharmaceutical, and automotive-grade chemicals.',
    `confirmed_delivery_date` DATE COMMENT 'Seller-confirmed delivery date for this quote line after Available-to-Promise (ATP) check and production capacity validation. May differ from the requested delivery date.',
    `contribution_margin` DECIMAL(18,2) COMMENT 'Gross contribution margin for this quote line, calculated as line net amount minus total standard cost. Expressed in the transaction currency. Enables profitability analysis at the product-grade level during the quoting process. Commercially sensitive.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this quote line record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail, quote aging analysis, and SLA tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary values on this quote line (e.g., USD, EUR, GBP). Enables multi-currency quoting for international chemical trade.. Valid values are `^[A-Z]{3}$`',
    `delivery_lead_time_days` STRING COMMENT 'Estimated number of calendar days from order confirmation to delivery at the agreed delivery point for this quote line. Accounts for production scheduling, inventory availability, and logistics transit time.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Absolute monetary value of the discount applied to this quote line in the transaction currency. Derived from discount_percent applied to line_gross_amount. Stored explicitly for audit and margin reporting.',
    `discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount applied to this quote line, representing negotiated price reductions from the list price. Includes volume discounts, customer-specific pricing agreements, and promotional discounts. Commercially sensitive.',
    `hazard_class` STRING COMMENT 'Globally Harmonized System (GHS) hazard classification for the chemical product on this quote line (e.g., Flammable Liquid Class 3, Corrosive, Toxic). Drives hazmat surcharge applicability, packaging requirements, and transport documentation. [ENUM-REF-CANDIDATE: FLAMMABLE_LIQUID|FLAMMABLE_SOLID|OXIDIZER|TOXIC|CORROSIVE|EXPLOSIVE|COMPRESSED_GAS|ENVIRONMENTAL_HAZARD|NON_HAZARDOUS — promote to reference product]',
    `hazmat_surcharge` DECIMAL(18,2) COMMENT 'Additional surcharge applied to this quote line for hazardous chemical handling, packaging, labeling, and transport compliance costs. Applicable for products classified under DOT, IATA, or IMDG dangerous goods regulations.',
    `incoterm_code` STRING COMMENT 'International Commercial Terms (Incoterms 2020) code defining the delivery obligations, risk transfer point, and cost responsibilities between seller and buyer for this quote line. Affects freight cost allocation and logistics planning. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this quote line record, in ISO 8601 format. Tracks revisions during negotiation cycles and supports change audit requirements.',
    `line_gross_amount` DECIMAL(18,2) COMMENT 'Gross monetary value of this quote line before any discounts or surcharges, calculated as quantity multiplied by unit price in the transaction currency. Used as the baseline for margin and discount analysis.',
    `line_net_amount` DECIMAL(18,2) COMMENT 'Net monetary value of this quote line after applying all discounts and surcharges (gross amount minus discounts plus surcharges) in the transaction currency. Represents the actual quoted value to the customer for this line.',
    `line_number` STRING COMMENT 'Sequential position of this line item within the parent quote, used for ordering and referencing individual items. Corresponds to SAP SD item number (e.g., 10, 20, 30).',
    `line_status` STRING COMMENT 'Current workflow status of this individual quote line item. Allows partial acceptance or rejection of lines within a multi-line quote. Draft: under preparation; Open: submitted to customer; Revised: updated after customer feedback; Accepted: customer confirmed; Rejected: customer declined; Cancelled: withdrawn by seller.. Valid values are `draft|open|revised|accepted|rejected|cancelled`',
    `material_number` STRING COMMENT 'SAP material number (MATNR) identifying the specific chemical product or grade being quoted. Used for cross-referencing with SAP MM and PP modules for production planning and inventory availability.',
    `price_uom` STRING COMMENT 'Unit of measure basis for the unit price (e.g., price per KG, price per MT). May differ from the sales UOM when pricing is expressed per metric ton but sold in drums. Required for accurate line value calculation. [ENUM-REF-CANDIDATE: KG|MT|L|GAL|LB|DRUM|IBC|BAG|TON|M3 — 10 candidates stripped; promote to reference product]',
    `product_description` STRING COMMENT 'Human-readable description of the chemical product or grade being quoted, including trade name, grade designation, and key specification identifiers as presented to the customer.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the chemical product being quoted on this line. Expressed in the unit of measure specified in the uom field. Supports bulk chemical quantities in kg, MT, L, or container counts.',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether the chemical product on this quote line is compliant with REACH (Registration, Evaluation, Authorisation and Restriction of Chemicals) regulation for the destination market. Required for EU export quoting.',
    `requested_delivery_date` DATE COMMENT 'Customer-requested delivery date for the product quantity on this quote line. Used for production planning, Available-to-Promise (ATP) checking, and logistics scheduling.',
    `sds_required` BOOLEAN COMMENT 'Indicates whether a Safety Data Sheet (SDS) must be provided to the customer with this quote line. Mandatory for hazardous chemical substances under GHS/OSHA HazCom 2012 and REACH regulations.',
    `small_order_surcharge` DECIMAL(18,2) COMMENT 'Additional surcharge applied when the quoted quantity falls below the Minimum Order Quantity (MOQ) threshold for this product. Covers incremental handling and packaging costs for sub-MOQ orders.',
    `standard_cost` DECIMAL(18,2) COMMENT 'Internal standard cost per unit of measure for the chemical product on this line, sourced from SAP CO (Controlling). Used to calculate contribution margin and Cost of Goods Sold (COGS) at the quote line level. Commercially sensitive internal data.',
    `storage_location` STRING COMMENT 'SAP storage location code within the delivering plant from which the chemical product will be sourced for this quote line. Relevant for inventory reservation and warehouse management.',
    `tsca_compliant` BOOLEAN COMMENT 'Indicates whether the chemical substance on this quote line is listed on the TSCA Chemical Substance Inventory and compliant with applicable TSCA requirements for US domestic sales.',
    `un_number` STRING COMMENT 'United Nations dangerous goods number (e.g., UN1090 for Acetone) assigned to the hazardous chemical on this quote line. Required for transport documentation, hazmat labeling, and emergency response planning under DOT and IMDG regulations.. Valid values are `^UN[0-9]{4}$`',
    `unit_price` DECIMAL(18,2) COMMENT 'Quoted price per unit of measure for the chemical product on this line, expressed in the transaction currency. Represents the base list or negotiated price before surcharges and discounts. Commercially sensitive pricing data.',
    `uom` STRING COMMENT 'Unit of measure for the quoted quantity (e.g., KG - kilograms, MT - metric tons, L - litres, GAL - gallons, LB - pounds, DRUM - 200L drum units, IBC - intermediate bulk containers, BAG - bag units, TON - short tons, M3 - cubic meters). Critical for chemical pricing and logistics planning. [ENUM-REF-CANDIDATE: KG|MT|L|GAL|LB|DRUM|IBC|BAG|TON|M3 — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_quote_line PRIMARY KEY(`quote_line_id`)
) COMMENT 'Individual line item within a customer quote, representing a specific chemical product, grade, or SKU with its own pricing, quantity, unit of measure (kg, MT, L, drums), and technical specification reference. Captures per-line discount, surcharges (e.g., hazmat handling, small-order), and COA/COC requirements. Enables granular margin analysis at the product-grade level.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` (
    `price_agreement_id` BIGINT COMMENT 'Unique surrogate identifier for the negotiated pricing agreement record in the lakehouse silver layer. Primary key for this entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer or distributor with whom this pricing agreement is established. Links to the customer master in the sales domain.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Price agreements are legally binding contracts executed by a specific legal entity — essential for intercompany pricing, tax jurisdiction assignment, and REACH/TSCA regulatory compliance in chemical m',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Pricing contracts are material‑specific; linking price_agreement to material_master enables material‑based price terms and regulatory clauses.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: In chemical manufacturing sales, negotiated price agreements (long-term supply agreements, contract prices) are frequently originated from a specific sales opportunity. Linking price_agreement back to',
    `organization_id` BIGINT COMMENT 'Reference to the SAP SD sales organization responsible for this pricing agreement, defining the legal selling entity and regional scope.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Price agreements in chemical mfg are negotiated at profit center level for margin management and revenue planning. Finance uses this link to report contracted revenue and discount exposure by business',
    `site_id` BIGINT COMMENT 'Foreign key linking to customer.site. Business justification: Chemical price agreements are frequently negotiated for specific delivery sites (bulk tank farms, manufacturing plants) with site-specific incoterms and logistics costs. Site-level pricing is standard',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: price_agreement currently stores territory_code as a denormalized STRING. Price agreements in chemical manufacturing are frequently scoped to specific sales territories (e.g., regional pricing for a p',
    `agreement_name` STRING COMMENT 'Descriptive name or title of the pricing agreement as referenced internally and in customer negotiations (e.g., FY2025 Polyethylene Supply Agreement - Acme Corp).',
    `agreement_number` STRING COMMENT 'Externally-known business identifier for the pricing agreement, typically matching the SAP SD condition contract number or Salesforce CRM contract number. Used in customer-facing communications and purchase orders.',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the pricing agreement. Draft = under preparation; Pending Approval = submitted for internal authorization; Active = in force and applicable to orders; Suspended = temporarily halted; Expired = past effective end date; Terminated = ended before expiry by mutual or unilateral action; Cancelled = voided before activation. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|expired|terminated|cancelled — promote to reference product]',
    `agreement_type` STRING COMMENT 'Classification of the pricing agreement by commercial structure. Contract Price = fixed negotiated unit price; Volume Rebate = retrospective rebate based on volume thresholds; Long-Term Supply = multi-year supply commitment with pricing; Spot Price = short-term market-based pricing; Distributor Price = channel partner pricing. [ENUM-REF-CANDIDATE: contract_price|volume_rebate|long_term_supply|spot_price|distributor_price|framework — promote to reference product if additional types emerge]. Valid values are `contract_price|volume_rebate|long_term_supply|spot_price|distributor_price`',
    `annual_volume_commitment` DECIMAL(18,2) COMMENT 'The total annual volume the customer has committed to purchase under this agreement, expressed in the price UOM. Used to validate volume rebate eligibility and supply planning. Corresponds to long-term supply agreement volume commitments.',
    `approval_status` STRING COMMENT 'Internal authorization status of the pricing agreement through the commercial approval workflow. Pending = awaiting review; Approved = authorized by required approvers; Rejected = declined; Revision Required = returned for amendment. Distinct from agreement_status which reflects the commercial lifecycle.. Valid values are `pending|approved|rejected|revision_required`',
    `approved_by` STRING COMMENT 'Name or employee ID of the internal approver (e.g., Sales Director, Commercial Manager) who authorized this pricing agreement. Required for SOX audit trail and pricing governance.',
    `approved_date` DATE COMMENT 'Date on which the pricing agreement received final internal approval and was authorized for commercial use.',
    `base_unit_price` DECIMAL(18,2) COMMENT 'The negotiated base price per unit of measure for the primary product or grade covered by this agreement, expressed in the agreement currency. For volume-rebate agreements, this represents the list price before rebate calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pricing agreement record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides audit trail for record origination.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which all prices and amounts within this agreement are denominated (e.g., USD, EUR, GBP). Aligns with SAP SD document currency.. Valid values are `^[A-Z]{3}$`',
    `distribution_channel` STRING COMMENT 'SAP SD distribution channel through which the product is sold under this agreement. Direct = sold directly to end customer; Distributor = sold through channel partner; Toll Manufacturing = customer-owned feedstock processing; Export = cross-border sales.. Valid values are `direct|distributor|toll_manufacturing|export`',
    `effective_end_date` DATE COMMENT 'The date on which the pricing agreement ceases to be binding. Nullable for open-ended agreements. Corresponds to SAP SD condition validity end date (DATBI).',
    `effective_start_date` DATE COMMENT 'The date from which the pricing agreement becomes binding and applicable to customer orders. Corresponds to SAP SD condition validity start date (DATAB).',
    `escalation_frequency` STRING COMMENT 'Frequency at which price escalation reviews and adjustments are performed under the escalation clause. Null if no escalation clause applies.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `escalation_index` STRING COMMENT 'Name or code of the external index used to calculate price escalations under the escalation clause (e.g., ICIS Ethylene Index, US CPI, Henry Hub Natural Gas, Platts Benzene). Null if no escalation clause applies.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms 2020) code defining the delivery and risk transfer point for shipments under this agreement (e.g., DAP = Delivered at Place, FOB = Free on Board, CIF = Cost Insurance Freight). Impacts freight cost allocation and pricing. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `incoterms_location` STRING COMMENT 'Named place or port associated with the Incoterms code (e.g., Houston, TX for FOB Houston). Required by Incoterms 2020 to complete the delivery term specification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this pricing agreement record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change tracking, audit compliance, and incremental data pipeline processing.',
    `min_order_qty` DECIMAL(18,2) COMMENT 'Minimum order quantity (MOQ) the customer must place per order to qualify for the contracted price. Expressed in the price UOM. Below this threshold, standard list pricing may apply.',
    `notes` STRING COMMENT 'Free-text field for capturing additional commercial terms, negotiation context, special conditions, or internal commentary related to this pricing agreement that are not captured in structured fields.',
    `notice_period_days` STRING COMMENT 'Number of calendar days advance notice required by either party to terminate or not renew this pricing agreement. Critical for supply chain continuity planning and customer retention management.',
    `payment_terms_code` STRING COMMENT 'SAP SD payment terms code defining the agreed payment schedule for invoices under this agreement (e.g., NT30 = net 30 days, Z001 = 2/10 net 30). Governs cash discount eligibility and due date calculation.',
    `price_escalation_clause` BOOLEAN COMMENT 'Indicates whether the agreement contains a price escalation clause allowing periodic price adjustments based on raw material indices, energy costs, or inflation benchmarks (e.g., CPI, feedstock index). True = escalation clause present.',
    `price_per_qty` DECIMAL(18,2) COMMENT 'The quantity denominator for the unit price (e.g., price per 100 KG, price per 1000 LB). Corresponds to SAP SD condition pricing quantity (KONP.KPEIN). Enables accurate per-unit price calculation when price is expressed per batch or bulk quantity.',
    `price_uom` STRING COMMENT 'Unit of measure to which the base unit price applies (e.g., KG = kilogram, MT = metric ton, LB = pound, L = liter, GAL = gallon, EA = each, BAG = bag, DR = drum, IBC = intermediate bulk container). Aligns with SAP SD condition pricing unit. [ENUM-REF-CANDIDATE: KG|MT|LB|L|GAL|EA|BAG|DR|IBC — 9 candidates stripped; promote to reference product]',
    `product_grade` STRING COMMENT 'Specific chemical product grade or specification covered by this pricing agreement (e.g., Polyethylene HD-5502, Benzene 99.9% Pure, Sulfuric Acid Technical Grade). Aligns with SAP SD material number or product hierarchy.',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether the products covered by this pricing agreement are compliant with EU REACH (Registration, Evaluation, Authorisation and Restriction of Chemicals) regulation. True = REACH compliant; False = non-compliant or compliance not confirmed. Relevant for export agreements to EU customers.',
    `rebate_pct` DECIMAL(18,2) COMMENT 'Retrospective volume rebate percentage applied to the customers total purchases when volume thresholds are met. Expressed as a percentage of net sales value. Applicable for volume rebate agreement types. Null for contract price agreements.',
    `rebate_threshold_qty` DECIMAL(18,2) COMMENT 'Minimum cumulative purchase quantity (in volume_commitment_uom) the customer must reach within the agreement period to qualify for the rebate percentage. Used in volume rebate agreement types.',
    `renewal_type` STRING COMMENT 'Defines how the pricing agreement is renewed at expiry. Auto Renew = automatically extends for the same term unless cancelled; Manual Renew = requires explicit renegotiation; No Renewal = single-term agreement with no renewal provision.. Valid values are `auto_renew|manual_renew|no_renewal`',
    `sap_condition_contract_no` STRING COMMENT 'The SAP SD condition contract number (KONA.KNUMA_AG) that is the system-of-record identifier for this pricing agreement in SAP S/4HANA. Enables traceability back to the operational source system.',
    `surcharge_amount` DECIMAL(18,2) COMMENT 'Fixed surcharge amount per price UOM added to the base unit price. Expressed in the agreement currency. Null if surcharge_type is none or if surcharge is percentage-based.',
    `surcharge_type` STRING COMMENT 'Type of surcharge applicable to this agreement in addition to the base unit price. Energy = energy cost surcharge; Freight = logistics/transport surcharge; Raw Material = feedstock cost pass-through; Hazmat = hazardous materials handling surcharge per DOT/IATA; None = no surcharge. [ENUM-REF-CANDIDATE: energy|freight|raw_material|hazmat|regulatory|currency|none — promote to reference product]. Valid values are `energy|freight|raw_material|hazmat|none`',
    `tsca_compliant` BOOLEAN COMMENT 'Indicates whether the chemical products covered by this agreement are listed on the TSCA (Toxic Substances Control Act) Chemical Substance Inventory and compliant with EPA TSCA requirements. Required for domestic US chemical sales agreements.',
    `volume_commitment_uom` STRING COMMENT 'Unit of measure for the annual volume commitment quantity (e.g., MT = metric ton, KG = kilogram). May differ from price UOM for large-volume chemical supply agreements. [ENUM-REF-CANDIDATE: KG|MT|LB|L|GAL|EA|BAG|DR|IBC — 9 candidates stripped; promote to reference product]',
    CONSTRAINT pk_price_agreement PRIMARY KEY(`price_agreement_id`)
) COMMENT 'Negotiated pricing agreement (contract price, volume rebate, or long-term supply agreement) with a customer or distributor. Includes header terms (validity, currency, escalation clauses, approval status) and per-product/grade pricing conditions (unit price, volume break tiers, UOM, surcharges). Maps to SAP SD condition records and pricing contracts. SSOT for customer-specific contracted pricing within the sales domain.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` (
    `price_agreement_line_id` BIGINT COMMENT 'Unique surrogate identifier for each individual product-level pricing line within a price agreement. Primary key for this entity in the Databricks Silver Layer.',
    `account_id` BIGINT COMMENT 'Reference to the customer or account for whom this product-level pricing line is negotiated. Supports customer-specific pricing analytics and contract compliance tracking.',
    `chemical_product_id` BIGINT COMMENT 'Reference to the chemical product or grade covered by this pricing line. Identifies the specific SKU, formulation, or material for which the agreed price applies.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Cost accounting for contracted pricing needs a GL account to post expense and COGS when price agreements are applied.',
    `grade_id` BIGINT COMMENT 'Foreign key linking to product.grade. Business justification: Chemical price agreements are grade-specific — pharmaceutical grade commands a significant premium over technical grade. The grade_specification plain-text field is denormalized; FK to grade enables a',
    `organization_id` BIGINT COMMENT 'Foreign key linking to sales.sales_organization. Business justification: price_agreement_line currently stores sales_org_code as a denormalized STRING. Individual pricing conditions in SAP SD are always associated with a specific sales organization. Normalizing to a FK ref',
    `packaging_config_id` BIGINT COMMENT 'Foreign key linking to product.packaging_config. Business justification: Chemical price agreements are packaging-specific — drum, IBC, and bulk tanker pricing differ significantly due to fill weight, hazmat certification, and logistics costs. The packaging_type plain-text ',
    `price_agreement_id` BIGINT COMMENT 'Reference to the parent price agreement header under which this line is defined. Establishes the header-to-line relationship for multi-product pricing agreements.',
    `qualification_id` BIGINT COMMENT 'Foreign key linking to customer.qualification. Business justification: Chemical price agreement lines are negotiated for specific qualified product-customer-grade combinations. Linking price_agreement_line to qualification ensures contracted pricing is only applied to ap',
    `quality_specification_id` BIGINT COMMENT 'Foreign key linking to quality.quality_specification. Business justification: Chemical pricing is grade/spec-specific — 99.5% vs 99.9% purity commands different prices. price_agreement_line.grade_specification is a denormalized text field; replacing with FK to quality_specifica',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Price agreements in chemical manufacturing are negotiated at SKU level — drum pricing differs from IBC pricing for the same chemical. The material_number plain-text field is denormalized; FK to sku en',
    `agreed_unit_price` DECIMAL(18,2) COMMENT 'Negotiated price per unit of measure for the chemical product on this pricing line. Represents the base contractual price before surcharges, rebates, or volume discounts are applied.',
    `annual_volume_commitment` DECIMAL(18,2) COMMENT 'Contractually committed annual purchase volume for this product line in the agreement UOM. Used to track customer compliance with take-or-pay or volume commitment clauses common in chemical supply contracts.',
    `condition_type_code` STRING COMMENT 'SAP SD pricing condition type code identifying the nature of the pricing condition on this line (e.g., PR00 for base price, ZK01 for customer-specific price, RA01 for rebate). Drives pricing determination in SAP SD.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this price agreement line record was first created in the system, capturing the audit trail for contract origination. Sourced from SAP SD or Salesforce CRM record creation time.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the agreed unit price and all monetary values on this pricing line are denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date from which this product-level pricing line becomes valid and applicable for customer orders. Aligns with the SAP SD condition record validity start date.',
    `expiry_date` DATE COMMENT 'Date on which this product-level pricing line ceases to be valid. After this date, the agreed price is no longer applicable unless the agreement is renewed. Aligns with SAP SD condition validity end date.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms 2020) code defining the delivery and risk transfer point for this pricing line (e.g., FOB, CIF, DAP). Affects the all-in cost to the customer and is a standard field in SAP SD. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `incoterms_location` STRING COMMENT 'Named place or port associated with the Incoterms code for this pricing line (e.g., Houston, TX for FOB Houston). Specifies the exact point of risk and cost transfer.',
    `index_adjustment_formula` STRING COMMENT 'Description or formula defining how the price index is applied to adjust the agreed unit price (e.g., Base price + 0.85 * (current month ICIS ethylene - reference ethylene price)). Captures the contractual price escalation mechanism.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this price agreement line record, supporting audit trail and change management requirements for pricing governance.',
    `line_number` STRING COMMENT 'Sequential position of this pricing line within the parent price agreement, used for ordering and referencing individual product terms within a multi-SKU agreement.',
    `line_status` STRING COMMENT 'Current lifecycle state of this pricing line. Controls whether the agreed price is applicable for order processing. Active lines are used in SAP SD pricing determination.. Valid values are `active|pending|expired|suspended|cancelled`',
    `min_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity the customer must order per transaction to qualify for the agreed price on this line. Enforces contractual MOQ commitments common in chemical supply agreements.',
    `payment_terms_code` STRING COMMENT 'Code identifying the payment terms applicable to orders placed under this pricing line (e.g., NET30, NET60, 2/10NET30). Aligns with SAP SD payment terms (ZTERM) and customer credit management.',
    `plant_code` STRING COMMENT 'SAP plant code identifying the manufacturing or distribution facility from which the chemical product on this pricing line is to be supplied. Determines sourcing, logistics costs, and applicable freight surcharges.',
    `price_index_linked` BOOLEAN COMMENT 'Indicates whether the agreed unit price on this line is linked to a commodity or raw material price index (e.g., ethylene cracker margin, benzene spot price, crude oil index). Common in long-term chemical supply contracts.',
    `price_index_name` STRING COMMENT 'Name or code of the commodity or raw material price index to which this pricing line is linked (e.g., ICIS Ethylene NWE, Platts Benzene FOB Korea, WTI Crude Oil). Populated only when price_index_linked is true.',
    `price_per_quantity` DECIMAL(18,2) COMMENT 'The quantity base (denominator) for the agreed unit price, indicating how many units the price applies to (e.g., price per 1 KG, price per 100 KG, price per 1000 L). Corresponds to SAP SD condition pricing unit (KPEIN).',
    `rebate_basis` STRING COMMENT 'The calculation basis on which the rebate percentage is applied: invoice value, net sales value, volume in kilograms, or volume in metric tons. Determines how rebate accruals are computed in SAP SD.. Valid values are `invoice_value|net_sales|volume_kg|volume_mt`',
    `rebate_percent` DECIMAL(18,2) COMMENT 'Percentage rebate to be credited back to the customer on purchases of this product line, typically settled periodically (monthly, quarterly, annually). Supports SAP SD rebate agreement processing.',
    `surcharge_amount` DECIMAL(18,2) COMMENT 'Fixed monetary surcharge amount per UOM added to the agreed unit price for this line. Used when the surcharge is a flat fee rather than a percentage (e.g., $0.05/KG energy surcharge).',
    `surcharge_percent` DECIMAL(18,2) COMMENT 'Percentage-based surcharge applied to the agreed unit price for this line. Used when the surcharge is calculated as a proportion of the base price (e.g., 2.5% raw material index surcharge).',
    `surcharge_type` STRING COMMENT 'Type of surcharge applicable to this pricing line, reflecting cost pass-through mechanisms common in chemical contracts (e.g., energy surcharge, freight surcharge, raw material index surcharge, hazardous material handling surcharge).. Valid values are `energy|freight|raw_material|hazmat|none`',
    `take_or_pay_flag` BOOLEAN COMMENT 'Indicates whether this pricing line is subject to a take-or-pay clause, requiring the customer to purchase the committed volume or pay a penalty for the shortfall. Common in long-term chemical feedstock agreements.',
    `tier_1_min_qty` DECIMAL(18,2) COMMENT 'Minimum order quantity threshold for the first volume break tier. Orders at or above this quantity qualify for the Tier 1 discounted unit price.',
    `tier_1_unit_price` DECIMAL(18,2) COMMENT 'Agreed unit price applicable when the order quantity meets or exceeds the Tier 1 minimum quantity threshold. Represents the first volume discount price break.',
    `tier_2_min_qty` DECIMAL(18,2) COMMENT 'Minimum order quantity threshold for the second volume break tier. Orders at or above this quantity qualify for the Tier 2 discounted unit price.',
    `tier_2_unit_price` DECIMAL(18,2) COMMENT 'Agreed unit price applicable when the order quantity meets or exceeds the Tier 2 minimum quantity threshold. Represents the second volume discount price break.',
    `tier_3_min_qty` DECIMAL(18,2) COMMENT 'Minimum order quantity threshold for the third volume break tier. Orders at or above this quantity qualify for the Tier 3 discounted unit price.',
    `tier_3_unit_price` DECIMAL(18,2) COMMENT 'Agreed unit price applicable when the order quantity meets or exceeds the Tier 3 minimum quantity threshold. Represents the third volume discount price break.',
    `uom` STRING COMMENT 'Unit of measure against which the agreed unit price is expressed (e.g., KG for kilogram, MT for metric ton, L for liter, GAL for gallon). Aligns with SAP SD sales unit and chemical industry standard packaging units. [ENUM-REF-CANDIDATE: KG|MT|LB|L|GAL|EA|DRM|IBC|BAG|TON — 10 candidates stripped; promote to reference product]',
    `volume_tier_flag` BOOLEAN COMMENT 'Indicates whether this pricing line has volume break tiers defined, where the unit price decreases as order quantity increases. When true, volume tier records are associated with this line.',
    `volume_tier_type` STRING COMMENT 'Basis on which volume break tiers are calculated: by order quantity (units/weight), by order value (monetary), or by weight (metric tons). Determines how SAP SD scale pricing is evaluated.. Valid values are `quantity|value|weight`',
    CONSTRAINT pk_price_agreement_line PRIMARY KEY(`price_agreement_line_id`)
) COMMENT 'Individual product-level pricing condition within a price agreement, specifying the agreed unit price, volume break tiers, UOM, validity dates, and applicable surcharges or rebate percentages for a specific chemical product or grade. Enables multi-product pricing agreements with per-SKU terms.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`sales`.`territory` (
    `territory_id` BIGINT COMMENT 'Unique surrogate identifier for the sales territory record. Primary key for the territory data product in the Databricks Silver Layer.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Territory expense allocation report tracks costs per cost center, linking territory to its responsible cost center.',
    `maintenance_plant_id` BIGINT COMMENT 'Foreign key linking to maintenance.plant. Business justification: Sales territories in chemical manufacturing are served by specific manufacturing plants, driving delivery lead time commitments, freight cost estimates, and regional supply planning. Territory-to-plan',
    `parent_territory_id` BIGINT COMMENT 'Self-referencing identifier pointing to the parent territory in the hierarchy. Enables rollup of sales performance, quota, and commission data from local to regional to global levels. Null for top-level global territories.',
    `annual_quota_usd` DECIMAL(18,2) COMMENT 'Annual revenue quota assigned to this territory in US Dollars. Used for sales performance measurement, commission calculation, and territory planning. Represents the revenue target the territory is expected to achieve within the fiscal year.',
    `channel_type` STRING COMMENT 'Primary sales channel model for this territory. Direct indicates company-employed sales reps selling directly to end customers; distributor indicates third-party channel partners; agent indicates commissioned agents; e_commerce indicates digital self-service; hybrid combines multiple channels.. Valid values are `direct|distributor|agent|e_commerce|hybrid`',
    `commission_plan_code` STRING COMMENT 'Code identifying the commission plan applicable to this territory. Determines how sales revenue generated within the territory is translated into commission payments for assigned representatives. Managed in SAP FI/CO and HR incentive compensation systems.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the primary country covered by this territory (e.g., USA, DEU, CHN). Used for regulatory compliance reporting (REACH, TSCA, EPA) and international sales analytics.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this territory record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides audit trail for territory master data governance and SOX compliance.',
    `customer_count` STRING COMMENT 'Number of active customer accounts assigned to this territory at the time of last update. Used for territory sizing, workload balancing, and sales force planning in the chemical sales organization.',
    `distribution_channel_code` STRING COMMENT 'SAP SD distribution channel code applicable to this territory, indicating how chemical products are sold (e.g., direct sales, distributor, e-commerce). Drives pricing, order management, and commission rules.. Valid values are `^[A-Z0-9]{2,10}$`',
    `division_code` STRING COMMENT 'SAP SD division code representing the product division or business unit whose products are sold within this territory (e.g., specialty chemicals, performance materials, agricultural solutions).. Valid values are `^[A-Z0-9]{2,10}$`',
    `effective_end_date` DATE COMMENT 'Date on which this territory definition ceases to be operationally effective. Null for currently active territories. Supports historical territory analysis and commission dispute resolution.',
    `effective_start_date` DATE COMMENT 'Date on which this territory definition became operationally effective. Used for time-bounded quota attribution, commission calculation, and sales force alignment reporting.',
    `fiscal_year` STRING COMMENT 'Fiscal year (four-digit integer, e.g., 2024) for which the territory quota and performance targets are defined. Aligns with the companys SAP FI/CO fiscal year configuration.',
    `hazmat_handling_required` BOOLEAN COMMENT 'Indicates whether sales activities in this territory involve hazardous chemical products requiring special handling, DOT transport compliance, GHS labeling, or OSHA PSM considerations. Drives compliance training requirements for assigned reps.',
    `hierarchy_level` STRING COMMENT 'Position of this territory within the sales territory hierarchy. Global is the top-level rollup; regional covers multi-country or multi-state zones; area covers sub-regional clusters; local is the lowest-level individual rep territory.. Valid values are `global|regional|area|local`',
    `industry_vertical` STRING COMMENT 'Target customer industry vertical served by this territory (e.g., Automotive, Construction, Electronics, Consumer Goods, Agriculture, Pharmaceuticals). Supports industry-specific sales strategy and product application guidance for chemical products. [ENUM-REF-CANDIDATE: automotive|construction|electronics|consumer_goods|agriculture|pharmaceuticals|coatings|food_beverage|oil_gas|textiles — promote to reference product]',
    `last_realignment_date` DATE COMMENT 'Date of the most recent territory realignment or restructuring event. Territory realignments in chemical sales organizations occur during annual planning cycles, mergers, or strategic pivots. Used to track territory stability and assess impact on quota attribution.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this territory record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change data capture, data lineage tracking, and audit compliance.',
    `named_account_flag` BOOLEAN COMMENT 'Indicates whether this territory is defined as a named-account territory (True) rather than a geographic or vertical territory (False). Named account territories in chemical sales are assigned to specific strategic customers regardless of geography.',
    `product_line_scope` STRING COMMENT 'Comma-delimited list or description of chemical product lines assigned to this territory (e.g., Specialty Resins, Performance Coatings, Agricultural Herbicides). Defines which product categories the territory rep is authorized to sell. [ENUM-REF-CANDIDATE: specialty_chemicals|performance_materials|agricultural_solutions|plastics|coatings|adhesives|solvents|catalysts — promote to reference product]',
    `quota_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the territory quota (e.g., USD, EUR, CNY). Supports multi-currency quota management for international chemical sales territories.. Valid values are `^[A-Z]{3}$`',
    `reach_regulated_flag` BOOLEAN COMMENT 'Indicates whether this territory operates under European REACH (Registration, Evaluation, Authorisation and Restriction of Chemicals) regulation, requiring compliance documentation for chemical substances sold. Relevant for EU/EEA territories.',
    `region_code` STRING COMMENT 'Standardized geographic region code for the territory (e.g., NOAM, EMEA, APAC, LATAM). Used for geographic rollup reporting and multi-regional sales performance analysis.. Valid values are `^[A-Z]{2,10}$`',
    `rep_assignment_end_date` DATE COMMENT 'Date on which the current primary sales representative assignment to this territory ends or ended. Null for currently active assignments. Supports historical assignment tracking and commission dispute resolution.',
    `rep_assignment_start_date` DATE COMMENT 'Date on which the current primary sales representative assignment to this territory became effective. Used for commission attribution, quota proration, and sales force alignment history tracking.',
    `sales_org_code` STRING COMMENT 'SAP SD Sales Organization code to which this territory belongs. Defines the legal entity and organizational unit responsible for selling chemical products within this territory (e.g., 1000 for North America Chemicals).. Valid values are `^[A-Z0-9]{2,10}$`',
    `salesforce_territory_code` STRING COMMENT 'Native Salesforce CRM Territory2 object identifier (15 or 18-character Salesforce ID) for this territory. Used for cross-system reconciliation between the Databricks Silver Layer and Salesforce CRM source system.. Valid values are `^[A-Za-z0-9]{15,18}$`',
    `sap_sales_district_code` STRING COMMENT 'SAP SD Sales District code corresponding to this territory. The sales district is the SAP organizational unit that maps most directly to a geographic sales territory and is used in SAP order management, pricing, and reporting.. Valid values are `^[A-Z0-9]{2,10}$`',
    `state_province_code` STRING COMMENT 'ISO 3166-2 state or province code for sub-national geographic territories (e.g., US-TX, DE-BY). Applicable for local-level territories; null for regional or global territories.. Valid values are `^[A-Z0-9]{2,6}$`',
    `strategic_account_flag` BOOLEAN COMMENT 'Indicates whether this territory contains one or more strategic (key) accounts that require dedicated executive-level sales engagement. Strategic territories in chemical manufacturing typically involve large-volume contracts and custom formulation agreements.',
    `technical_sales_required` BOOLEAN COMMENT 'Indicates whether this territory requires dedicated technical sales support (True), such as application engineers or chemists who provide product application guidance, formulation support, or SDS/COA documentation assistance to customers.',
    `territory_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the sales territory, as maintained in SAP SD and Salesforce CRM. Used for cross-system reference and reporting (e.g., NA-CHEM-NE-01, EMEA-AG-DE-02).. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `territory_description` STRING COMMENT 'Free-text narrative description of the territory scope, coverage boundaries, special conditions, or strategic context. May include notes on key customer segments, chemical product focus areas, or competitive landscape relevant to the territory.',
    `territory_name` STRING COMMENT 'Human-readable descriptive name of the sales territory (e.g., Northeast Specialty Chemicals, Germany Agricultural Solutions). Used in reporting, dashboards, and sales force communications.',
    `territory_status` STRING COMMENT 'Current lifecycle status of the territory record. Active territories are currently assigned and operational; pending territories are being set up; inactive territories have been temporarily suspended; archived territories are closed and retained for historical reporting.. Valid values are `active|inactive|pending|archived`',
    `territory_type` STRING COMMENT 'Classification of how the territory is defined and segmented. Geographic territories are defined by physical region; industry_vertical by customer industry sector; named_account by specific key accounts; product_line by chemical product category; hybrid combines multiple dimensions.. Valid values are `geographic|industry_vertical|named_account|product_line|hybrid`',
    `tsca_regulated_flag` BOOLEAN COMMENT 'Indicates whether this territory operates under US TSCA (Toxic Substances Control Act) regulation, requiring compliance with EPA chemical substance reporting and restriction requirements for products sold in this territory.',
    CONSTRAINT pk_territory PRIMARY KEY(`territory_id`)
) COMMENT 'Sales territory definition, hierarchy, and representative assignment record. Defines geographic regions, industry verticals, or named-account segments with territory hierarchy (global/regional/local) and assigned product line scope. Includes full sales representative assignment history with role type (primary, backup, overlay), effective dates, and coverage scope. Supports territory planning, sales force alignment, quota attribution, and commission allocation for chemical sales organizations.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` (
    `territory_assignment_id` BIGINT COMMENT 'Unique surrogate identifier for each territory assignment record in the chemical sales organization. Primary key for this association entity linking a sales representative or account manager to a specific territory.',
    `organization_id` BIGINT COMMENT 'Foreign key linking to sales.sales_organization. Business justification: territory_assignment currently stores sales_org_code as a denormalized STRING. This should be normalized to a FK referencing sales.sales_organization. Territory assignments in chemical manufacturing a',
    `predecessor_assignment_territory_assignment_id` BIGINT COMMENT 'Reference to the previous territory assignment record that this assignment supersedes. Enables historical tracking of territory ownership changes, succession planning, and audit trail of coverage transitions in the chemical sales organization.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Territory assignments drive commission and quota calculations tracked against profit centers. Chemical mfg finance uses this link to allocate sales force costs and commissions to the correct profit ce',
    `territory_id` BIGINT COMMENT 'Reference to the sales territory being assigned. A territory defines a geographic or account-based coverage scope within the chemical sales organization.',
    `account_count_target` STRING COMMENT 'The planned number of customer accounts the sales representative is expected to manage within this territory assignment. Used for workload balancing, territory sizing, and sales capacity planning in the chemical sales organization.',
    `approval_date` DATE COMMENT 'The date on which the territory assignment was formally approved by the designated authority. Required for SOX compliance and internal audit trail of territory ownership changes.',
    `assignment_number` STRING COMMENT 'Externally-known business identifier for the territory assignment record, used in SAP SD and Salesforce CRM for cross-system reference and audit trail. Format: TA-YYYYMMDD-XXXX.. Valid values are `^TA-[0-9]{8}-[A-Z0-9]{4}$`',
    `assignment_status` STRING COMMENT 'Current lifecycle state of the territory assignment. Drives commission eligibility, quota attribution, and CRM routing logic. Active indicates the rep is currently responsible for the territory.. Valid values are `active|inactive|pending|suspended|terminated`',
    `assignment_type` STRING COMMENT 'Classifies the basis on which the territory is defined and assigned. Geographic assignments cover a physical region; account-based assignments cover named accounts; product-based assignments cover specific chemical product lines (e.g., specialty polymers, agrochemicals); channel-based assignments cover distributor or direct channels.. Valid values are `geographic|account-based|product-based|channel-based`',
    `channel_type` STRING COMMENT 'Indicates the go-to-market channel through which the sales representative engages customers in this territory. Direct indicates direct customer engagement; distributor indicates sales through channel partners; OEM indicates original equipment manufacturer accounts; hybrid indicates mixed channel coverage.. Valid values are `direct|distributor|oem|ecommerce|hybrid`',
    `commission_rate_pct` DECIMAL(18,2) COMMENT 'The commission rate (expressed as a decimal fraction, e.g., 0.0350 = 3.50%) applicable to the sales representative for sales generated within this territory assignment. Used for incentive compensation calculation and financial accruals.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the primary country covered by this territory assignment. Used for regulatory compliance reporting (REACH, TSCA, EPA), tax jurisdiction determination, and international sales analytics.. Valid values are `^[A-Z]{3}$`',
    `coverage_scope` STRING COMMENT 'Indicates the geographic or organizational breadth of the territory assignment. Supports hierarchical territory reporting and sales performance aggregation across the chemical sales organization.. Valid values are `national|regional|district|local|global`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this territory assignment record was first created in the system. Supports audit trail, data lineage, and SOX compliance requirements for the chemical sales organization.',
    `crm_assignment_code` STRING COMMENT 'The Salesforce CRM system identifier for this territory assignment record. Enables cross-system reconciliation between the Salesforce CRM territory model and the SAP SD sales organization structure.',
    `distribution_channel_code` STRING COMMENT 'SAP SD distribution channel code associated with this territory assignment (e.g., direct sales, distributor, OEM). Determines pricing conditions and order processing rules for chemical product sales in the territory.. Valid values are `^[A-Z0-9]{2}$`',
    `division_code` STRING COMMENT 'SAP SD division code representing the product division (e.g., specialty chemicals, performance materials, agrochemicals) covered by this territory assignment. Supports product-line-level sales reporting.. Valid values are `^[A-Z0-9]{2}$`',
    `effective_fiscal_quarter` STRING COMMENT 'The fiscal quarter within the effective fiscal year for which this territory assignment and associated quota are applicable. Supports quarterly sales performance reporting and commission accrual calculations.. Valid values are `^Q[1-4]$`',
    `effective_fiscal_year` STRING COMMENT 'The fiscal year in which this territory assignment is active and quota-bearing. Aligns territory assignments with annual sales planning cycles, budget periods, and financial reporting requirements under SAP FI/CO.. Valid values are `^[0-9]{4}$`',
    `end_date` DATE COMMENT 'The date on which the sales representatives responsibility for the territory ends. Null indicates an open-ended assignment with no planned termination. Used for historical tracking and commission cutoff.',
    `geographic_region` STRING COMMENT 'The geographic region or sub-region covered by this territory assignment (e.g., Northeast US, EMEA, APAC). Supports regional sales reporting, territory planning, and logistics coordination for chemical product distribution.',
    `industry_segment_focus` STRING COMMENT 'The target end-market industry segment (e.g., automotive, construction, electronics, consumer goods, agriculture) that this territory assignment is focused on. Supports vertical market analytics and customer acquisition strategy for chemical product sales.',
    `is_commission_eligible` BOOLEAN COMMENT 'Indicates whether the sales representative is eligible to earn commission on sales generated within this territory assignment. Backup and overlay roles may have different commission eligibility rules in chemical sales organizations.',
    `is_primary_assignment` BOOLEAN COMMENT 'Indicates whether this is the primary territory assignment for the sales representative. A representative may have multiple territory assignments; this flag identifies the principal one for reporting and commission attribution purposes.',
    `is_quota_bearing` BOOLEAN COMMENT 'Indicates whether a formal sales quota is assigned to this territory assignment. Overlay and backup roles may not carry independent quotas. Drives quota attainment reporting and KPI dashboards.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context about the territory assignment, such as special coverage arrangements, transition instructions, or customer-specific handling notes relevant to chemical product sales.',
    `product_line_focus` STRING COMMENT 'Describes the specific chemical product line or portfolio segment (e.g., specialty polymers, performance coatings, agrochemicals, industrial solvents) that the sales representative is primarily responsible for within this territory. Supports product-line-level sales analytics and technical sales alignment.',
    `quota_amount` DECIMAL(18,2) COMMENT 'The revenue quota assigned to the sales representative for this territory during the assignment period, expressed in the functional currency. Used for sales performance measurement, KPI reporting, and incentive compensation calculations.',
    `quota_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the quota amount assigned to this territory (e.g., USD, EUR, GBP). Supports multi-currency chemical sales organizations operating across global markets.. Valid values are `^[A-Z]{3}$`',
    `quota_period_type` STRING COMMENT 'Defines the measurement period for the territory quota. Determines how quota attainment is calculated and reported for commission and incentive compensation purposes in the chemical sales organization.. Valid values are `annual|semi-annual|quarterly|monthly`',
    `role_type` STRING COMMENT 'Defines the nature of the sales representatives responsibility for the territory. Primary indicates full ownership; backup covers absence; overlay provides specialist support (e.g., technical sales for specialty chemicals); interim covers temporary gaps; co-primary indicates shared ownership.. Valid values are `primary|backup|overlay|interim|co-primary`',
    `sap_sd_assignment_number` STRING COMMENT 'The SAP SD system identifier for the territory assignment record. Supports cross-system data lineage, reconciliation, and integration between Salesforce CRM and SAP SD for territory management in the chemical manufacturing enterprise.',
    `start_date` DATE COMMENT 'The date on which the sales representatives responsibility for the territory becomes effective. Used for commission calculation, quota proration, and historical territory ownership tracking.',
    `state_province_code` STRING COMMENT 'ISO 3166-2 state or province code for the primary sub-national jurisdiction covered by this territory assignment. Supports state-level sales reporting, tax compliance, and EPA/OSHA regulatory jurisdiction tracking.. Valid values are `^[A-Z]{2,3}$`',
    `termination_reason` STRING COMMENT 'Reason code explaining why the territory assignment was ended. Supports workforce analytics, territory planning, and historical audit of sales coverage changes in the chemical manufacturing sales organization. [ENUM-REF-CANDIDATE: resignation|reassignment|restructuring|performance|retirement|transfer|contract_end — promote to reference product if additional values are needed]',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this territory assignment record was last modified. Tracks changes to assignment status, role type, quota, or coverage scope for audit and data governance purposes.',
    CONSTRAINT pk_territory_assignment PRIMARY KEY(`territory_assignment_id`)
) COMMENT 'Association record linking a sales representative or account manager to a specific territory, capturing assignment start/end dates, role type (primary, backup, overlay), and coverage scope. Enables historical tracking of territory ownership changes and supports commission and quota attribution in chemical sales organizations.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`sales`.`target` (
    `target_id` BIGINT COMMENT 'Primary key for target',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to finance.budget_plan. Business justification: Sales revenue targets are directly derived from and aligned with finance budget plans in chemical mfg. This link enables integrated business planning — comparing sales attainment against the approved ',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Sales targets are period-bound; linking to fiscal_period enables proper period-close attainment reporting. fiscal_period, fiscal_quarter, fiscal_year exist as denormalized plain columns on target that',
    `hierarchy_id` BIGINT COMMENT 'Reference to the chemical product line or product family covered by this target (e.g., Specialty Polymers, Agrochemicals, Performance Coatings). Populated when assignment_level is product_line or when the target is scoped to a specific product category. Sourced from SAP MM material group hierarchy.',
    `organization_id` BIGINT COMMENT 'Foreign key linking to sales.sales_organization. Business justification: Revenue and volume targets in SAP SD environments are set at the sales organization level. The target product currently links to territory but has no FK to sales_organization, despite sales organizati',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Sales targets in chemical mfg are set and reported at profit center level (e.g., Coatings profit center has a $50M revenue target). Finance uses this link for budget vs. actuals reporting by business ',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Chemical sales planning sets revenue and volume targets by customer segment (automotive, agriculture, electronics). target.market_segment is a denormalized text field; replacing it with segment_id ena',
    `territory_id` BIGINT COMMENT 'Reference to the sales territory to which this target is assigned. Populated when assignment_level is territory. Territories in chemical manufacturing are typically defined by geography (e.g., North America, EMEA) and customer segment. Sourced from Salesforce CRM territory management.',
    `actual_revenue_usd` DECIMAL(18,2) COMMENT 'The actual realized revenue in USD for the target period, sourced from SAP SD billing documents and FI/CO revenue postings. Used to calculate revenue attainment variance against the target. Updated periodically via ERP integration.',
    `actual_volume_mt` DECIMAL(18,2) COMMENT 'The actual sales volume in metric tons (MT) realized during the target period, sourced from SAP SD delivery and billing records. Used to calculate volume attainment variance against the volume target.',
    `approval_date` DATE COMMENT 'The date on which this sales target was formally approved by the designated manager or business unit leader. Required for SOX compliance documentation and incentive compensation plan administration.',
    `approved_by` STRING COMMENT 'The name or employee identifier of the sales manager or business unit leader who formally approved this target. Required for SOX compliance and incentive compensation audit trails. Sourced from Salesforce CRM approval workflow.',
    `assignment_level` STRING COMMENT 'The organizational or commercial dimension at which this target is assigned. Sales_rep targets are individual; territory targets cover a geographic sales zone; product_line targets cover a chemical product family; business_unit targets cover a division (e.g., Agrochemicals, Specialty Chemicals); channel targets cover distributor or direct sales channels.. Valid values are `sales_rep|territory|product_line|business_unit|channel`',
    `baseline_year` STRING COMMENT 'The prior fiscal year used as the baseline reference for target-setting calculations (e.g., prior year actuals used to derive growth targets). Supports year-over-year growth analysis and target justification documentation.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the country-level scope of this target (e.g., USA, DEU, CHN). Used for country-specific sales performance reporting and regulatory compliance tracking under REACH, TSCA, and EPA requirements.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this sales target record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail requirements under SOX and data lineage tracking in the Databricks lakehouse silver layer.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary target values in this record (e.g., USD, EUR, GBP). Supports multi-currency chemical sales operations across global territories. Aligns with SAP FI/CO currency configuration.. Valid values are `^[A-Z]{3}$`',
    `fiscal_period` STRING COMMENT 'The fiscal posting period number (1–12) to which this target applies. Populated only when period_granularity is monthly. Aligns with SAP FI/CO posting period numbers for monthly attainment reporting.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter to which this target applies (Q1–Q4). Populated only when period_granularity is quarterly. Null for annual or monthly targets. Supports quarterly sales performance reviews and incentive compensation calculations.. Valid values are `Q1|Q2|Q3|Q4`',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this sales target applies, expressed as a four-digit integer (e.g., 2025). Aligns with Chemical Mfgs SAP FI/CO fiscal year calendar for financial reporting and EBITDA planning.',
    `floor_revenue_usd` DECIMAL(18,2) COMMENT 'The minimum revenue threshold (floor) below which no incentive compensation is earned. Typically 70–80% of the base target. Used in incentive compensation calculations to define the minimum attainment level required for commission eligibility.',
    `geographic_region` STRING COMMENT 'The geographic sales region to which this target applies (e.g., North America, EMEA, APAC, LATAM). Aligns with SAP SD sales organization regional hierarchy and Salesforce CRM territory management. [ENUM-REF-CANDIDATE: north_america|emea|apac|latam|mea|greater_china — promote to reference product]',
    `growth_rate_pct` DECIMAL(18,2) COMMENT 'The planned year-over-year or period-over-period growth rate embedded in this target, expressed as a decimal (e.g., 0.0800 = 8.00% growth). Derived from strategic planning assumptions and used to validate target reasonableness in management reviews.',
    `last_revised_date` DATE COMMENT 'The date on which this target was most recently revised or adjusted. Mid-year target revisions may occur due to market conditions, M&A activity, or force majeure events. Supports audit trail for target change management.',
    `margin_pct` DECIMAL(18,2) COMMENT 'The planned gross margin percentage target for the period, expressed as a decimal (e.g., 0.3250 = 32.50%). Used for profitability management and incentive compensation plans that include margin-based components. Populated when target_type is margin.',
    `notes` STRING COMMENT 'Free-text field for additional context, assumptions, or qualifications associated with this sales target. May include notes on market conditions, excluded accounts, special pricing agreements, or target-setting assumptions documented by the sales manager.',
    `period_end_date` DATE COMMENT 'The calendar date on which the target measurement period ends. For annual targets this is typically December 31 or the fiscal year end date. Aligns with SAP FI/CO posting period close dates.',
    `period_granularity` STRING COMMENT 'The time granularity at which this target is set and tracked. Annual targets cover a full fiscal year; quarterly targets align to SAP posting periods Q1–Q4; monthly targets align to individual SAP posting periods for detailed attainment tracking.. Valid values are `annual|quarterly|monthly`',
    `period_start_date` DATE COMMENT 'The calendar date on which the target measurement period begins. For annual targets this is typically January 1 or the fiscal year start date. Aligns with SAP FI/CO posting period open dates.',
    `product_category` STRING COMMENT 'The chemical product category or market segment covered by this target (e.g., Specialty Chemicals, Agrochemicals, Performance Polymers, Industrial Chemicals, Coatings & Adhesives). Sourced from SAP MM material group classification. [ENUM-REF-CANDIDATE: specialty_chemicals|agrochemicals|performance_polymers|industrial_chemicals|coatings_adhesives|plastics|solvents|catalysts — promote to reference product]',
    `revenue_attainment_pct` DECIMAL(18,2) COMMENT 'The ratio of actual revenue to target revenue for the period, expressed as a decimal (e.g., 0.9250 = 92.50% attainment). Calculated as actual_revenue_usd / target_revenue_usd. Used for sales performance management, KPI dashboards, and incentive compensation calculations. NOTE: This is a stored attainment snapshot, not a real-time computed metric, to support point-in-time reporting and audit.',
    `revenue_usd` DECIMAL(18,2) COMMENT 'The planned revenue target value denominated in US Dollars (USD) for the defined period. Represents the gross revenue goal before deductions. Used for EBITDA planning, COGS analysis, and sales performance management. Populated when target_type is revenue or margin.',
    `revision_reason` STRING COMMENT 'The business reason for the most recent revision to this target. Market_conditions covers demand shifts; portfolio_change covers product additions/removals; territory_realignment covers sales org restructuring; acquisition covers M&A impacts; force_majeure covers unforeseeable events; correction covers data entry errors.. Valid values are `market_conditions|portfolio_change|territory_realignment|acquisition|force_majeure|correction`',
    `sales_channel` STRING COMMENT 'The commercial channel through which sales against this target are expected to be realized. Direct indicates sales to end-use customers; distributor covers third-party distribution partners; OEM covers original equipment manufacturer accounts; ecommerce covers digital order channels; agent covers commissioned sales agents.. Valid values are `direct|distributor|oem|ecommerce|agent`',
    `setting_method` STRING COMMENT 'The methodology used to establish this sales target. Top_down targets are allocated from corporate/BU level; bottom_up targets are built from rep-level forecasts; negotiated targets result from manager-rep agreement; statistical targets are derived from historical trend analysis and SPC methods.. Valid values are `top_down|bottom_up|negotiated|statistical`',
    `stretch_revenue_usd` DECIMAL(18,2) COMMENT 'The aspirational upper-bound revenue target (stretch goal) in USD, set above the base target to incentivize overperformance. Typically 110–120% of the base target. Used in incentive compensation plans to calculate accelerated commission rates for above-target performance.',
    `target_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the sales target record, used in management reporting, incentive compensation plans, and cross-system references between SAP SD and Salesforce CRM.. Valid values are `^TGT-[A-Z0-9]{4,20}$`',
    `target_name` STRING COMMENT 'Human-readable descriptive name for the sales target, such as FY2025 Q1 Specialty Chemicals - North America or Annual Volume Target - Agrochemicals - Rep Smith. Used in dashboards and management reports.',
    `target_status` STRING COMMENT 'Current lifecycle state of the sales target record. Draft targets are under review; active targets are in-period and being tracked; approved targets have passed management sign-off; closed targets have reached period end; cancelled targets were withdrawn before period start.. Valid values are `draft|active|approved|closed|cancelled`',
    `target_type` STRING COMMENT 'Classification of the sales target by the primary metric being tracked. Revenue targets are denominated in USD; volume targets in MT or kg; margin targets as gross margin percentage; new_business for new customer acquisition; account_growth for existing account expansion.. Valid values are `revenue|volume|margin|new_business|account_growth`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this sales target record was most recently modified, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Updated on any change to target values, status, or attainment data. Supports change data capture (CDC) in the Databricks lakehouse pipeline.',
    `volume_attainment_pct` DECIMAL(18,2) COMMENT 'The ratio of actual volume to target volume for the period, expressed as a decimal (e.g., 1.0500 = 105.00% attainment). Calculated as actual_volume_mt / target_volume_mt. Used for supply chain planning alignment and sales volume KPI reporting.',
    `volume_mt` DECIMAL(18,2) COMMENT 'The planned sales volume target expressed in metric tons (MT). Used for chemical manufacturing capacity planning, raw material procurement forecasting, and supply chain management. Populated when target_type is volume. Aligns with SAP SD delivery quantity planning.',
    `volume_uom` STRING COMMENT 'The unit of measure for the volume target. MT (metric tons) is standard for bulk chemicals; KG for specialty/fine chemicals; L (liters) for liquid products; GAL (gallons) for US market; LB (pounds) for certain North American contracts. Aligns with SAP MM base unit of measure.. Valid values are `MT|KG|L|GAL|LB`',
    CONSTRAINT pk_target PRIMARY KEY(`target_id`)
) COMMENT 'Annual or periodic revenue and volume targets assigned to sales territories, product lines, or individual sales representatives. Captures target value (revenue in USD, volume in MT/kg), product category scope, period granularity (year/quarter/month), attainment tracking (actual vs. target with variance), and stretch/floor thresholds. Supports sales performance management, incentive compensation calculations, and management reporting for chemical sales teams.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`sales`.`distributor` (
    `distributor_id` BIGINT COMMENT 'Unique surrogate identifier for the authorized chemical distributor or channel partner record. Primary key for the distributor master in the sales domain.',
    `maintenance_plant_id` BIGINT COMMENT 'Foreign key linking to maintenance.plant. Business justification: In chemical manufacturing, distributors are assigned to specific manufacturing plants as their primary supply source. This link drives order fulfillment routing, ATP availability checks, and logistics',
    `account_id` BIGINT COMMENT 'Salesforce CRM Account record identifier for this distributor. Enables cross-system traceability between the lakehouse silver layer distributor master and the Salesforce CRM system of record for opportunity and activity management.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Distributors in chemical manufacturing are authorized for specific geographic territories. The distributor product currently stores territory_scope as a denormalized STRING. Normalizing this to a FK r',
    `agreement_effective_date` DATE COMMENT 'Calendar date on which the distribution agreement becomes legally binding and commercially effective. Marks the start of authorized distribution rights and contractual obligations.',
    `agreement_expiry_date` DATE COMMENT 'Calendar date on which the distribution agreement expires or is scheduled to terminate. Null indicates an open-ended agreement. Used for renewal tracking and compliance monitoring.',
    `agreement_number` STRING COMMENT 'Externally-known unique reference number of the governing distribution agreement document. Used for contract management, audit trails, and legal reference. Prefixed DA- per internal convention.. Valid values are `^DA-[A-Z0-9-]{4,20}$`',
    `agreement_type` STRING COMMENT 'Classification of the distribution agreement governing the commercial relationship. Exclusive grants sole territorial rights; Non-exclusive allows multiple distributors; Preferred grants priority pricing; Consignment transfers risk only upon sale.. Valid values are `exclusive|non_exclusive|preferred|consignment`',
    `annual_purchase_commitment` DECIMAL(18,2) COMMENT 'Contractually agreed minimum annual purchase value (in agreement currency) that the distributor commits to purchasing from Chemical Mfg. Used for rebate tier qualification and agreement compliance monitoring.',
    `authorized_product_categories` STRING COMMENT 'Comma-separated list of product categories or chemical product lines that the distributor is contractually authorized to sell under the distribution agreement (e.g., Specialty Solvents,Performance Coatings,Agricultural Intermediates). Enforced during order processing in SAP SD.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the distribution agreement automatically renews upon expiry unless explicitly terminated. True = auto-renews; False = requires affirmative renewal action.',
    `certification_expiry_date` DATE COMMENT 'Earliest expiry date among the distributors active compliance certifications (e.g., ISO 9001, Responsible Distribution, REACH). Used to trigger recertification workflows and flag distributors with lapsing credentials.',
    `channel_type` STRING COMMENT 'Indicates the go-to-market channel through which the distributor operates. Direct channels involve direct resale; indirect may involve additional intermediaries; hybrid combines both models.. Valid values are `direct|indirect|hybrid|online`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code of the distributors primary registered business address. Used for regulatory jurisdiction determination (REACH, TSCA, EPA) and trade compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp (ISO 8601 with timezone offset) recording when the distributor master record was first created in the lakehouse silver layer. Supports data lineage, audit trails, and SOX compliance.',
    `credit_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the credit limit and financial terms are denominated (e.g., USD, EUR, GBP). Aligns with the agreement currency for consistent financial reporting.. Valid values are `^[A-Z]{3}$`',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum outstanding accounts receivable balance (in agreement currency) extended to the distributor by Chemical Mfg. Enforced in SAP SD credit management to block orders exceeding the limit.',
    `distributor_code` STRING COMMENT 'Externally-known alphanumeric business identifier assigned to the distributor in SAP SD / Salesforce CRM. Used on purchase orders, invoices, and channel communications as the canonical reference code.. Valid values are `^[A-Z0-9-]{3,20}$`',
    `distributor_status` STRING COMMENT 'Current lifecycle status of the distributor master record. Active = approved and trading; Suspended = temporarily blocked (e.g., compliance hold); Pending Approval = onboarding in progress; Terminated = agreement ended.. Valid values are `active|inactive|suspended|pending_approval|terminated`',
    `distributor_tier` STRING COMMENT 'Commercial tier classification of the distributor based on sales volume, strategic importance, and service level. Drives rebate eligibility, pricing tiers, and support resource allocation. Tier 1 = highest volume/strategic; Tier 3 = emerging/low volume.. Valid values are `tier_1|tier_2|tier_3|strategic`',
    `distributor_type` STRING COMMENT 'Classification of the distributor relationship type. Exclusive distributors hold sole rights in a territory; master distributors may appoint sub-distributors; agents act on behalf without taking title to goods.. Valid values are `exclusive|non_exclusive|master|sub_distributor|agent`',
    `duns_number` STRING COMMENT 'Nine-digit Dun & Bradstreet Data Universal Numbering System (DUNS) number uniquely identifying the distributors legal entity globally. Used for credit risk assessment, supplier qualification, and third-party data enrichment.. Valid values are `^[0-9]{9}$`',
    `ghs_classification_acknowledged` BOOLEAN COMMENT 'Indicates whether the distributor has formally acknowledged receipt and understanding of GHS hazard classification and labelling requirements for all authorized product categories. Required for EHS compliance onboarding.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms 2020) code defining the agreed delivery and risk transfer point for shipments to the distributor. Governs freight responsibility, insurance obligations, and customs clearance duties. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `iso_9001_certified` BOOLEAN COMMENT 'Indicates whether the distributor holds a current ISO 9001 Quality Management System certification. Used as a quality assurance criterion in distributor qualification and tier classification.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp (ISO 8601 with timezone offset) recording when the distributor master record was most recently modified. Used for change data capture, incremental loads, and audit compliance.',
    `legal_name` STRING COMMENT 'Full registered legal name of the distributor entity as recorded in the distribution agreement and government business registry. Used for contract execution, invoicing, and regulatory filings.',
    `moq_kg` DECIMAL(18,2) COMMENT 'Minimum Order Quantity (MOQ) in kilograms that the distributor must place per order under the distribution agreement. Enforced in SAP SD order entry to ensure commercial viability of each transaction.',
    `onboarding_date` DATE COMMENT 'Calendar date on which the distributor completed the formal onboarding process and was approved as an authorized channel partner. Marks the start of the commercial relationship lifecycle.',
    `payment_terms_code` STRING COMMENT 'SAP payment terms key defining the agreed payment schedule for the distributor (e.g., NT30 = Net 30 days, Z001 = 2/10 Net 30). Governs invoice due dates and early payment discount eligibility.. Valid values are `^[A-Z0-9]{2,10}$`',
    `primary_contact_email` STRING COMMENT 'Primary business email address for the distributors key account contact. Used for order confirmations, SDS/COA distribution, regulatory notifications, and commercial communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact person at the distributor organization responsible for managing the commercial relationship with Chemical Mfg.',
    `primary_contact_phone` STRING COMMENT 'Primary business telephone number for the distributors key account contact. Used for urgent order management, compliance escalations, and technical sales support.. Valid values are `^+?[0-9s-.()]{7,20}$`',
    `reach_registration_number` STRING COMMENT 'European Chemicals Agency (ECHA) REACH registration number confirming the distributors compliance with Registration, Evaluation, Authorisation and Restriction of Chemicals (REACH) Regulation (EC) No 1907/2006. Required for distributors operating in EU/EEA markets.. Valid values are `^[0-9]{2}-[0-9]{10}-[0-9]{2}-[0-9]{4}$`',
    `rebate_structure_code` STRING COMMENT 'Reference code identifying the rebate or volume incentive program applicable to this distributor as defined in the SAP SD rebate agreement. Determines the rebate calculation method, thresholds, and payout schedule.. Valid values are `^[A-Z0-9-]{2,15}$`',
    `renewal_notice_days` STRING COMMENT 'Number of calendar days prior to agreement expiry by which either party must provide written notice of non-renewal or termination. Contractually mandated and used to trigger renewal workflow alerts.',
    `responsible_distribution_certified` BOOLEAN COMMENT 'Indicates whether the distributor holds current certification under the National Association of Chemical Distributors (NACD) Responsible Distribution program, demonstrating commitment to EHS, security, and product stewardship standards.',
    `sap_customer_number` STRING COMMENT 'SAP S/4HANA SD customer master number assigned to the distributor. Used for order-to-cash processing, credit management, and financial reconciliation between the lakehouse and SAP ERP.. Valid values are `^[0-9]{7,10}$`',
    `sds_distribution_obligation` BOOLEAN COMMENT 'Indicates whether the distributor is contractually and regulatory obligated to distribute Safety Data Sheets (SDS) to downstream customers per GHS/OSHA HazCom 2012 requirements. True = obligated; False = exempt (e.g., agent not taking title).',
    `tax_identification_number` STRING COMMENT 'Government-issued Tax Identification Number (TIN) or VAT registration number of the distributor legal entity. Required for invoicing, customs documentation, and tax compliance reporting.',
    `termination_date` DATE COMMENT 'Calendar date on which the distribution agreement was formally terminated or the distributor relationship was ended. Null if the relationship is active or the agreement has not been terminated.',
    `trade_name` STRING COMMENT 'Operating or doing business as (DBA) trade name of the distributor, which may differ from the legal entity name. Used in commercial communications and sales reporting.',
    `tsca_compliance_flag` BOOLEAN COMMENT 'Indicates whether the distributor has confirmed compliance with the Toxic Substances Control Act (TSCA) requirements for chemical distribution in the United States. True = confirmed compliant; False = non-compliant or unconfirmed.',
    CONSTRAINT pk_distributor PRIMARY KEY(`distributor_id`)
) COMMENT 'Master record for authorized chemical distributors and channel partners, including the governing distribution agreement terms. Captures distributor identity, tier classification, geographic coverage, credit limit, and compliance certifications (REACH, TSCA, responsible distribution, SDS distribution obligations). Embeds agreement details: type (exclusive/non-exclusive), authorized product categories, territory scope, MOQ, minimum purchase commitments, rebate structure, compliance obligations, and agreement validity period. SSOT for channel partner identity, commercial relationship, and contractual terms within the sales domain.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` (
    `distributor_agreement_id` BIGINT COMMENT 'Unique surrogate identifier for the distributor agreement record in the Chemical Mfg lakehouse silver layer. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Distributor agreement costs are allocated to a specific cost center for budgeting and rebate accounting.',
    `opportunity_id` BIGINT COMMENT 'Salesforce CRM opportunity or contract record identifier that originated or is linked to this distributor agreement. Enables traceability from sales pipeline to executed agreement.',
    `distributor_id` BIGINT COMMENT 'Reference to the authorized distributor (customer/business partner) who is party to this agreement. Links to the distributor master record in the customer domain.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Distributor agreement rebates and commissions are accrued to specific GL accounts for period-close journal entries. Chemical mfg finance requires this link to post distributor-related liabilities accu',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Distributor agreements are executed by a specific legal entity — governing_law_country and tax obligations require this link. Chemical mfg compliance teams use it for REACH downstream reporting and cr',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Distribution agreements authorize a distributor to sell particular chemicals; need FK to material_master to enforce product scope and compliance.',
    `organization_id` BIGINT COMMENT 'Reference to the Chemical Mfg sales organization responsible for managing and executing this distributor agreement, as defined in SAP SD organizational structure.',
    `price_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.price_agreement. Business justification: A distributor agreement in chemical manufacturing governs the commercial relationship including pricing terms. Linking distributor_agreement to the governing price_agreement enables traceability betwe',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Distributor agreements generate channel revenue tracked to profit centers. Chemical mfg P&L reporting by distribution channel requires this link to attribute net revenue (after rebates) to the correct',
    `quality_specification_id` BIGINT COMMENT 'Foreign key linking to quality.quality_specification. Business justification: Distributor agreements in chemical manufacturing contractually bind distributors to maintain and communicate specific quality standards (GHS, REACH, SDS obligations). The quality specification defines',
    `reach_registration_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.reach_registration. Business justification: distributor_agreement.reach_downstream_reporting_required flag confirms REACH obligations exist. Under EU REACH Articles 31-32, distributors must pass SDS and registration information downstream; the ',
    `safety_data_sheet_id` BIGINT COMMENT 'Foreign key linking to ehs.safety_data_sheet. Business justification: REACH Article 31 and OSHA HazCom legally require chemical manufacturers to ensure distributors receive and pass on the current SDS. Distributor agreements must formally reference the applicable SDS ve',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: distributor_agreement has territory_scope and territory_country_code as STRING fields but no FK to the territory master. Distribution agreements in chemical manufacturing are scoped to specific territ',
    `agreement_number` STRING COMMENT 'Externally-known, human-readable agreement reference number assigned by SAP SD (Sales and Distribution) at contract creation. Used in all correspondence, purchase orders (POs), and regulatory submissions with the distributor.. Valid values are `^DA-[0-9]{4}-[0-9]{6}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the distributor agreement. Draft: under negotiation; Active: fully executed and binding; Suspended: temporarily halted (e.g., compliance breach); Terminated: ended before natural expiry; Expired: reached end date without renewal.. Valid values are `draft|active|suspended|terminated|expired`',
    `agreement_type` STRING COMMENT 'Classification of the distribution arrangement: exclusive (sole distributor in territory), non_exclusive (multiple distributors permitted), master (umbrella agreement with sub-agreements), sub (child of a master agreement), or trial (limited-term evaluation agreement).. Valid values are `exclusive|non_exclusive|master|sub|trial`',
    `agreement_version` STRING COMMENT 'Sequential version number of the distributor agreement, incremented each time the agreement is formally amended (e.g., price renegotiation, territory expansion, MOQ revision). Version 1 is the original executed agreement.',
    `amendment_date` DATE COMMENT 'Date of the most recent formal amendment to this distributor agreement. Null if no amendments have been made since original execution. Used with agreement_version for change tracking.',
    `amendment_description` STRING COMMENT 'Free-text description of the most recent amendment to this distributor agreement, summarizing the key changes made (e.g., Territory expanded to include CAN; MOQ increased to USD 500,000). Supports audit trail and Management of Change (MOC) documentation.',
    `authorized_product_categories` STRING COMMENT 'Comma-separated list of Chemical Mfg product category codes or names that the distributor is authorized to sell under this agreement (e.g., Performance Coatings, Agricultural Chemicals, Specialty Polymers). Governs which SKUs can be ordered against this agreement in SAP SD.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this distributor agreement automatically renews upon expiry unless either party provides written notice of termination within the notice period. Drives renewal workflow automation in Salesforce CRM.',
    `coa_required` BOOLEAN COMMENT 'Indicates whether a Certificate of Analysis (COA) must accompany each product shipment to the distributor under this agreement, confirming that the batch meets specification. Supports GMP and ISO 9001 quality documentation requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this distributor agreement record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Populated at insert time and never updated. Supports SOX audit trail requirements.',
    `credit_limit_usd` DECIMAL(18,2) COMMENT 'Maximum outstanding accounts receivable credit extended to the distributor under this agreement, denominated in USD. Enforced in SAP SD credit management (FD32) to control financial exposure.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which all financial terms of this agreement (MOQ, rebates, pricing) are denominated (e.g., USD, EUR, GBP). Supports multi-currency reporting in SAP FI/CO.. Valid values are `^[A-Z]{3}$`',
    `dispute_resolution_mechanism` STRING COMMENT 'Contractually agreed mechanism for resolving disputes arising under this distributor agreement: arbitration (binding third-party arbitration), litigation (court proceedings), mediation (non-binding third-party mediation), or negotiation (direct party negotiation).. Valid values are `arbitration|litigation|mediation|negotiation`',
    `effective_date` DATE COMMENT 'Calendar date on which the distributor agreement becomes legally binding and commercially operative. Aligns with SAP SD contract validity start date.',
    `ehs_training_required` BOOLEAN COMMENT 'Indicates whether distributor personnel are required to complete Chemical Mfg-mandated EHS (Environment Health and Safety) training on product handling, storage, and emergency response as a condition of this agreement.',
    `exclusivity_scope` STRING COMMENT 'Defines the breadth of exclusivity granted to the distributor within the authorized territory: full_portfolio (all Chemical Mfg products), product_category (specific product categories only), single_product (one product or SKU), or none (non-exclusive arrangement).. Valid values are `full_portfolio|product_category|single_product|none`',
    `expiry_date` DATE COMMENT 'Calendar date on which the distributor agreement naturally expires. Nullable for open-ended evergreen agreements. Used to trigger renewal workflows and compliance reviews.',
    `governing_law_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the jurisdiction whose laws govern interpretation and enforcement of this distributor agreement (e.g., USA, DEU, GBR). Critical for dispute resolution and regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms 2020) code defining the delivery obligations, risk transfer point, and cost responsibilities between Chemical Mfg and the distributor for shipments under this agreement. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `moq_annual_usd` DECIMAL(18,2) COMMENT 'Minimum annual purchase commitment in US dollars that the distributor must achieve to maintain agreement terms and qualify for contracted pricing and rebates. Failure to meet MOQ may trigger agreement renegotiation or termination. Aligns with SAP SD minimum order value configuration.',
    `payment_terms_code` STRING COMMENT 'SAP SD payment terms key (e.g., NT30, NT60, 2/10NT30) governing invoice due dates and early payment discount conditions for orders placed under this agreement.',
    `product_application_support` BOOLEAN COMMENT 'Indicates whether Chemical Mfg provides technical sales and product application guidance support to the distributor under this agreement, including customer-specific formulation assistance and technical documentation.',
    `reach_downstream_reporting_required` BOOLEAN COMMENT 'Indicates whether the distributor must fulfill REACH downstream user reporting obligations, including use notifications and exposure scenario communication, as required under ECHA REACH Regulation (EC) No 1907/2006 Title V.',
    `rebate_rate_pct` DECIMAL(18,2) COMMENT 'Base rebate percentage (0.00–100.00) applied to eligible purchases under this agreement. For volume_tiered structures, this represents the base tier rate; tier thresholds are managed in the rebate schedule. Stored in SAP SD rebate agreement condition records.',
    `rebate_structure_type` STRING COMMENT 'Classification of the rebate mechanism applicable to this distributor agreement: volume_tiered (rebate percentage increases with purchase volume tiers), flat_rate (fixed percentage on all purchases), growth_incentive (rebate tied to year-over-year growth targets), or none (no rebate applicable).. Valid values are `volume_tiered|flat_rate|growth_incentive|none`',
    `renewal_date` DATE COMMENT 'Date by which a renewal decision must be made or the agreement auto-renews. Drives CRM (Salesforce) renewal opportunity creation and account manager notifications.',
    `renewal_notice_days` STRING COMMENT 'Number of calendar days prior to expiry_date by which either party must provide written notice of non-renewal or termination. Typically 30, 60, or 90 days as negotiated.',
    `responsible_care_compliance_required` BOOLEAN COMMENT 'Indicates whether the distributor is contractually required to adhere to the ACC (American Chemistry Council) Responsible Care program standards as a condition of this distribution agreement.',
    `sap_contract_number` STRING COMMENT 'SAP S/4HANA SD contract document number (transaction VA41/VA42) corresponding to this distributor agreement. Used for cross-system reconciliation between the CRM pipeline and ERP order management.',
    `sds_distribution_required` BOOLEAN COMMENT 'Indicates whether the distributor is contractually obligated to distribute Safety Data Sheets (SDS) to downstream customers for all chemical products sold under this agreement. Mandatory under GHS, REACH, and OSHA HazCom 2012 (29 CFR 1910.1200).',
    `signed_date` DATE COMMENT 'Date on which both parties executed (signed) the distributor agreement. May differ from effective_date when agreements are backdated or post-dated.',
    `termination_date` DATE COMMENT 'Actual date on which the agreement was terminated early (before natural expiry). Null if the agreement has not been terminated. Distinct from expiry_date which represents the scheduled end date.',
    `termination_reason` STRING COMMENT 'Reason code for early termination of the distributor agreement. [ENUM-REF-CANDIDATE: mutual_agreement|breach_of_contract|moq_failure|compliance_violation|business_exit|acquisition|other — promote to reference product]',
    `territory_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code representing the primary country of the authorized distribution territory. Used for REACH downstream user reporting and EPA/TSCA jurisdictional compliance tracking.. Valid values are `^[A-Z]{3}$`',
    `territory_scope` STRING COMMENT 'Geographic scope within which the distributor is authorized to sell Chemical Mfg products under this agreement. May be expressed as country codes (ISO 3166-1 alpha-3), regions, or named sales territories (e.g., USA,CAN,MEX or EMEA-West). Supports territory management analytics in Salesforce CRM.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this distributor agreement record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Updated on every modification. Supports change data capture (CDC) in the Databricks lakehouse silver layer.',
    CONSTRAINT pk_distributor_agreement PRIMARY KEY(`distributor_agreement_id`)
) COMMENT 'Formal distribution agreement governing the commercial relationship between Chemical Mfg and an authorized distributor. Captures agreement type (exclusive, non-exclusive), authorized product categories, territory scope, minimum purchase commitments (MOQ), rebate structure, compliance obligations (SDS distribution, REACH downstream user reporting), and agreement validity period.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` (
    `rebate_agreement_id` BIGINT COMMENT 'Unique surrogate identifier for the sales rebate agreement record in the lakehouse silver layer. Primary key for this entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer or distributor party with whom this rebate agreement is established. Links to the customer master.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Rebate accruals post to specific GL accounts for period-close journal entries. accrual_account_code is a denormalized plain column that should be a proper FK to gl_account for accurate financial posti',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Rebate accruals in chemical mfg are charged to specific cost centers for period-close accounting. cost_center_code is a denormalized plain column on sales_rebate_agreement that should be replaced by a',
    `distributor_id` BIGINT COMMENT 'Foreign key linking to sales.distributor. Business justification: The sales_rebate_agreement product description explicitly states it covers rebate agreements with a customer or distributor. While account_id covers the customer side, there is no FK to distributor ',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Rebate settlement and accrual cycles must align with fiscal periods for period-close accuracy. Chemical mfg finance requires this link to ensure rebate postings fall in the correct accounting period.',
    `hierarchy_id` BIGINT COMMENT 'Reference to the product hierarchy or product group that defines the eligible product scope for this rebate agreement (e.g., specialty chemicals, performance materials, agricultural solutions).',
    `organization_id` BIGINT COMMENT 'Reference to the SAP SD sales organization responsible for administering this rebate agreement, defining the selling entity and currency context.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Rebate settlements are tracked against profit centers for P&L impact reporting by business segment. Chemical mfg finance teams require this link to report net revenue after rebates at the profit cente',
    `opportunity_id` BIGINT COMMENT 'Identifier of the associated Salesforce CRM opportunity or contract record that originated or tracks this rebate agreement. Enables cross-system traceability between CRM pipeline and SAP SD rebate execution.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: sales_rebate_agreement currently stores territory_code as a denormalized STRING. Rebate agreements in chemical manufacturing are scoped to specific sales territories (e.g., a regional distributor reba',
    `accrual_method` STRING COMMENT 'Accounting method used to recognize and accrue rebate liability over the agreement period. Accrual-based: rebate liability is recognized as sales occur; Cash basis: recognized only upon settlement payment; Manual: accruals are posted manually by finance. Aligns with SAP FI/CO accrual posting logic.. Valid values are `accrual_based|cash_basis|manual`',
    `accrued_amount` DECIMAL(18,2) COMMENT 'Cumulative rebate liability accrued to date under this agreement based on eligible customer purchases. Updated periodically via SAP SD rebate settlement runs. Expressed in payout currency. Represents the current outstanding rebate obligation.',
    `agreement_notes` STRING COMMENT 'Free-text field capturing commercial negotiation context, special conditions, customer-specific terms, or exceptions not captured in structured fields. Used by sales and finance teams for agreement administration.',
    `agreement_number` STRING COMMENT 'Externally-known business identifier for the rebate agreement, typically sourced from SAP SD rebate agreement number (BO01/BO02 agreement number field). Used in customer-facing communications and settlement documents.',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the rebate agreement. Draft: under negotiation; Active: binding and accruing; Suspended: temporarily paused; Settled: final settlement completed; Expired: past end date without renewal; Cancelled: terminated before end date.. Valid values are `draft|active|suspended|settled|expired|cancelled`',
    `agreement_type` STRING COMMENT 'Classification of the rebate agreement by commercial incentive type. Volume rebate rewards cumulative purchase volume; growth incentive rewards year-over-year growth; market development fund (MDF) supports distributor marketing activities; distributor rebate applies to channel partners; loyalty rebate rewards long-term customers; performance rebate ties payout to KPI achievement. [ENUM-REF-CANDIDATE: volume_rebate|growth_incentive|market_development_fund|distributor_rebate|loyalty_rebate|performance_rebate — promote to reference product]. Valid values are `volume_rebate|growth_incentive|market_development_fund|distributor_rebate|loyalty_rebate|performance_rebate`',
    `approval_date` DATE COMMENT 'Date on which the rebate agreement was formally approved by the authorized approver. Marks the transition from draft to active status and establishes the audit trail for financial commitment.',
    `baseline_period_end` DATE COMMENT 'End date of the reference period used to establish the baseline purchase volume or revenue for growth incentive rebate measurement. Together with baseline_period_start, defines the comparison window.',
    `baseline_period_start` DATE COMMENT 'Start date of the reference period used to establish the baseline purchase volume or revenue against which growth performance is measured for growth incentive rebate agreements.',
    `calculation_basis` STRING COMMENT 'Defines the metric used to measure customer performance and calculate rebate entitlement. Revenue: net invoiced sales value; Volume: quantity of product units; Quantity: number of orders or transactions; Weight (kg): metric weight of chemical products shipped; Mixed: combination of revenue and volume thresholds.. Valid values are `revenue|volume|quantity|weight_kg|mixed`',
    `channel_type` STRING COMMENT 'Commercial channel through which the customer purchases eligible products. Direct: sold directly by Chemical Mfg sales force; Distributor: sold through authorized chemical distributors; Dealer: regional dealer network; OEM: original equipment manufacturer purchasing for incorporation; Ecommerce: digital channel purchases.. Valid values are `direct|distributor|dealer|oem|ecommerce`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rebate agreement record was first created in the system, formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX. Provides audit trail for record origination and SOX compliance.',
    `effective_from` DATE COMMENT 'Calendar date on which the rebate agreement becomes binding and eligible purchases begin accruing toward rebate thresholds. Formatted as yyyy-MM-dd.',
    `effective_until` DATE COMMENT 'Calendar date on which the rebate agreement expires and no further accruals are recognized. Nullable for open-ended agreements. Formatted as yyyy-MM-dd.',
    `eligible_product_scope` STRING COMMENT 'Defines the breadth of products eligible for rebate accrual under this agreement. All products: entire customer portfolio; Product group: defined SAP material group; Specific SKUs: enumerated Stock Keeping Units (SKUs); Product line: a named chemical product line; Material type: SAP material type classification (e.g., FERT, HALB).. Valid values are `all_products|product_group|specific_skus|product_line|material_type`',
    `growth_target_percent` DECIMAL(18,2) COMMENT 'Year-over-year revenue or volume growth percentage target that the customer must achieve to qualify for growth incentive rebate tiers. Applicable only when agreement_type is growth_incentive. Expressed as a decimal percentage (e.g., 10.0000 = 10%).',
    `is_retroactive` BOOLEAN COMMENT 'Indicates whether the rebate is applied retroactively to all eligible purchases once a higher tier threshold is crossed (retroactive/step rebate), as opposed to applying only to incremental purchases above the threshold (incremental rebate). Critical for SAP SD rebate condition type configuration.',
    `is_tiered` BOOLEAN COMMENT 'Indicates whether this rebate agreement uses a tiered scale structure where different rebate rates apply at different purchase volume or revenue thresholds. True: multiple tiers defined in the rebate tier child product; False: single flat rate applies.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this rebate agreement record, formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX. Supports change tracking, audit compliance, and incremental data pipeline processing.',
    `last_settlement_date` DATE COMMENT 'Date on which the most recent rebate settlement was completed and credit memo or payment was issued to the customer. Used to track settlement history and validate settlement frequency compliance.',
    `max_rebate_cap_amount` DECIMAL(18,2) COMMENT 'Maximum total rebate payout amount allowed under this agreement regardless of actual purchase performance. Protects Chemical Mfg from uncapped rebate liability exposure. Null if no cap applies. Expressed in payout currency.',
    `next_settlement_date` DATE COMMENT 'Scheduled date for the next rebate settlement run for this agreement. Drives SAP SD settlement processing calendar and finance accrual review cycles.',
    `payout_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which the rebate settlement is denominated and paid to the customer or distributor (e.g., USD, EUR, GBP). Supports multi-currency rebate programs for global chemical distribution.. Valid values are `^[A-Z]{3}$`',
    `rebate_amount_fixed` DECIMAL(18,2) COMMENT 'Fixed monetary rebate amount payable upon achievement of agreement conditions, used for flat-fee rebate structures (e.g., market development funds with a fixed payout). Null when the agreement uses a percentage-based rate. Expressed in the payout currency.',
    `rebate_rate_percent` DECIMAL(18,2) COMMENT 'Percentage rate applied to the calculation basis to determine the rebate payout amount for a given tier. Expressed as a decimal percentage (e.g., 2.5000 = 2.5%). For tiered agreements, this represents the base or entry-level rate; tier-specific rates are captured in the rebate tier product.',
    `sap_rebate_agreement_number` STRING COMMENT 'Source system identifier for this rebate agreement in SAP SD (BO01/BO02 agreement number). Enables traceability and reconciliation between the lakehouse silver layer and the SAP S/4HANA system of record.',
    `settled_amount` DECIMAL(18,2) COMMENT 'Total rebate amount that has been paid or credited to the customer through completed settlement runs. The difference between accrued_amount and settled_amount represents the outstanding rebate payable. Expressed in payout currency.',
    `settlement_frequency` STRING COMMENT 'Frequency at which the accrued rebate is settled and paid to the customer or distributor. Determines the cadence of SAP SD rebate settlement runs and credit memo generation.. Valid values are `monthly|quarterly|semi_annual|annual|on_demand`',
    `settlement_method` STRING COMMENT 'Mechanism by which the rebate is paid to the customer or distributor. Credit memo: applied against future invoices in SAP SD; Check: physical payment instrument; Bank transfer: electronic funds transfer; Product credit: rebate applied as credit toward future product purchases.. Valid values are `credit_memo|check|bank_transfer|product_credit`',
    `threshold_basis_amount` DECIMAL(18,2) COMMENT 'Minimum cumulative purchase value (in payout currency) or volume that the customer must achieve to qualify for the rebate. Represents the entry-level threshold for single-tier agreements. For multi-tier agreements, this is the lowest tier threshold.',
    `threshold_basis_unit` STRING COMMENT 'Unit of measure for the rebate threshold basis amount. For revenue-based agreements, this is the ISO 4217 currency code. For volume-based agreements, this is the unit of measure (MT = metric ton, KG = kilogram, L = liter, EA = each) aligned with chemical product measurement standards. [ENUM-REF-CANDIDATE: USD|EUR|GBP|MT|KG|L|EA| — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_rebate_agreement PRIMARY KEY(`rebate_agreement_id`)
) COMMENT 'Volume-based or performance-based rebate agreement with a customer or distributor, defining rebate tiers, calculation basis (revenue or volume), accrual method, settlement frequency, and eligible product scope. Captures rebate type (volume rebate, growth incentive, market development fund), threshold levels, and payout currency. Maps to SAP SD rebate processing (BO01/BO02). Distinct from price_agreement — rebates are retrospective settlements, not upfront pricing.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` (
    `opportunity_product_id` BIGINT COMMENT 'Unique surrogate identifier for the opportunity-product association record in the Silver Layer lakehouse. Primary key for this entity.',
    `cas_registry_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.cas_registry. Business justification: opportunity_product.cas_number is a denormalized reference to cas_registry. In chemical sales, the CAS number identifies the exact regulated substance; linking to cas_registry enables REACH/TSCA compl',
    `chemical_product_id` BIGINT COMMENT 'Reference to the chemical product or grade being proposed within this opportunity. Identifies the specific finished good, intermediate, or specialty chemical.',
    `cost_element_id` BIGINT COMMENT 'Foreign key linking to finance.cost_element. Business justification: Opportunity products in chemical mfg carry standard cost estimates for margin calculation during the sales stage. Linking to cost_element enables accurate contribution margin forecasting on pipeline o',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment. Business justification: In chemical manufacturing technical sales, opportunity products are tied to specific customer equipment (e.g., a catalyst for a specific reactor, a lubricant for a specific compressor). This link enab',
    `grade_id` BIGINT COMMENT 'Foreign key linking to product.grade. Business justification: During opportunity qualification in chemical manufacturing, the specific grade pursued determines pricing tier, GMP/USP compliance requirements, and technical review scope. The product_grade plain-tex',
    `opportunity_id` BIGINT COMMENT 'Reference to the parent sales opportunity to which this product line belongs. Links the product-level detail back to the opportunity header.',
    `packaging_config_id` BIGINT COMMENT 'Foreign key linking to product.packaging_config. Business justification: During opportunity qualification, packaging configuration affects cost modeling, logistics feasibility, and hazmat compliance. The packaging_type plain-text field is denormalized; FK to packaging_conf',
    `product_specification_id` BIGINT COMMENT 'Foreign key linking to product.product_specification. Business justification: In chemical manufacturing, customer-specific specifications drive the technical review process during opportunity qualification. FK from opportunity_product to product_specification links the commerci',
    `qualification_id` BIGINT COMMENT 'Foreign key linking to customer.qualification. Business justification: In chemical manufacturing, opportunity products must reference the customer qualification record to confirm the product grade is approved for the customers application. This drives sample requests, t',
    `sds_id` BIGINT COMMENT 'Foreign key linking to product.sds. Business justification: When sds_required=true on an opportunity_product, the specific SDS document must be referenced for OSHA HazCom and REACH compliance. FK to sds enables automatic SDS version tracking during opportunity',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Chemical sales opportunities are tracked at SKU level to forecast demand by specific pack configuration (e.g., 200L drum vs 1000L IBC). The sku_code plain-text field is denormalized; FK to sku enables',
    `tds_id` BIGINT COMMENT 'Foreign key linking to product.tds. Business justification: TDS documents are central to technical sales in chemical manufacturing — customers require performance data to qualify a chemical for their process. When technical_review_required=true, the TDS should',
    `annual_volume_estimate` DECIMAL(18,2) COMMENT 'Estimated annual purchase volume for this product line, expressed in the quantity UOM. Supports long-term demand forecasting, supply chain planning, and volume-based pricing negotiations.',
    `application_end_use` STRING COMMENT 'Specific end-use application or industry segment for which the customer intends to use this chemical product (e.g., automotive coatings, agricultural formulation, electronic cleaning). Critical for REACH downstream user notifications and technical sales support.',
    `close_date` DATE COMMENT 'Expected or actual date on which this product line within the opportunity is anticipated to be won or lost. Used for pipeline aging analysis and sales forecast period alignment.',
    `coa_required` BOOLEAN COMMENT 'Indicates whether the customer requires a Certificate of Analysis (COA) with each shipment of this product. Drives quality documentation requirements in LabWare LIMS and SAP QM.',
    `competitive_status` STRING COMMENT 'Describes the competitive landscape for this product line within the opportunity. Indicates whether Chemical Mfg is the sole supplier, competing against others, defending incumbent business, or attempting to displace a competitor.. Valid values are `sole_source|competitive_bid|incumbent|new_business|displacement`',
    `competitor_name` STRING COMMENT 'Name of the primary competing supplier for this product line in the opportunity. Used for competitive intelligence, win/loss analysis, and strategic positioning.',
    `contract_end_date` DATE COMMENT 'Proposed end date of the supply contract or pricing agreement for this product line. Defines the duration of the commercial commitment being negotiated.',
    `contract_start_date` DATE COMMENT 'Proposed start date of the supply contract or pricing agreement for this product line if the opportunity is won. Feeds into contract management and SAP SD scheduling agreements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this opportunity-product association record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail and pipeline aging analysis.',
    `crm_opportunity_product_code` STRING COMMENT 'External identifier for this opportunity-product line as recorded in Salesforce CRM (OpportunityLineItem ID). Used for cross-system reconciliation between CRM and SAP SD.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary values on this opportunity product line (e.g., USD, EUR, GBP). Supports multi-currency reporting and FX conversion.. Valid values are `^[A-Z]{3}$`',
    `delivery_lead_time_days` STRING COMMENT 'Estimated number of calendar days from order placement to delivery for this product line, used in customer negotiations and supply chain planning.',
    `discount_pct` DECIMAL(18,2) COMMENT 'Percentage discount offered on the list price for this product line as part of the commercial negotiation. Supports margin analysis and pricing governance.',
    `estimated_quantity` DECIMAL(18,2) COMMENT 'Estimated volume or quantity of the chemical product the customer intends to purchase within the opportunity period. Used for demand forecasting and production planning.',
    `estimated_revenue` DECIMAL(18,2) COMMENT 'Total estimated revenue for this product line within the opportunity, calculated as estimated quantity multiplied by unit price. Represents the gross revenue potential before discounts.',
    `first_shipment_date` DATE COMMENT 'Anticipated date of the first product shipment if the opportunity is won. Used for production scheduling, raw material procurement planning, and customer commitment management.',
    `formulation_required` BOOLEAN COMMENT 'Indicates whether this opportunity product line requires a customer-specific formulation or blending service rather than a standard catalog product. Triggers engagement with R&D and formulation teams.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this opportunity-product record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change tracking, data freshness monitoring, and incremental ETL processing.',
    `line_number` STRING COMMENT 'Sequential line number of this product within the parent opportunity, enabling ordered display and reference of multiple product lines within a single opportunity.',
    `list_price` DECIMAL(18,2) COMMENT 'Published or standard list price per unit of measure for this chemical product before any negotiated discounts or customer-specific pricing adjustments.',
    `moq` DECIMAL(18,2) COMMENT 'Minimum order quantity required for this chemical product, expressed in the quantity UOM. Communicated to the customer during opportunity negotiation to set commercial expectations.',
    `opportunity_product_status` STRING COMMENT 'Current lifecycle status of this specific product line within the opportunity. Allows individual product lines to be won, lost, or withdrawn independently of the overall opportunity status.. Valid values are `active|won|lost|withdrawn|on_hold`',
    `probability_weighted_revenue` DECIMAL(18,2) COMMENT 'Estimated revenue for this product line adjusted by the win probability percentage. Used for pipeline valuation, sales forecasting, and revenue planning at the product level.',
    `quantity_uom` STRING COMMENT 'Unit of measure for the estimated quantity field (e.g., KG for kilograms, MT for metric tons, L for liters, DRUM for drum containers). Aligns with SAP base unit of measure for the material. [ENUM-REF-CANDIDATE: KG|MT|LB|L|GAL|DRUM|IBC|BAG|TON — 9 candidates stripped; promote to reference product]',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether this chemical product is confirmed compliant with REACH regulation for the customers intended use and geography. Critical for European market opportunities.',
    `sales_stage` STRING COMMENT 'Current sales pipeline stage for this product line, which may differ from the parent opportunity stage when individual products are at different negotiation phases. [ENUM-REF-CANDIDATE: prospecting|qualification|needs_analysis|proposal|negotiation|closed_won|closed_lost — promote to reference product]',
    `sample_requested` BOOLEAN COMMENT 'Indicates whether the customer has requested a product sample for evaluation or qualification testing as part of this opportunity. Triggers sample order creation in SAP SD.',
    `sap_sd_item_number` STRING COMMENT 'SAP SD quotation or sales order item number corresponding to this product line, used for traceability from opportunity to formal quote or order in SAP S/4HANA.. Valid values are `^[0-9]{6}$`',
    `sds_required` BOOLEAN COMMENT 'Indicates whether the customer requires a Safety Data Sheet (SDS) for this chemical product as part of the opportunity documentation. Mandatory for hazardous chemicals under GHS and REACH.',
    `technical_review_required` BOOLEAN COMMENT 'Indicates whether this product line requires a technical review by the applications engineering or R&D team before a formal proposal can be submitted to the customer.',
    `tsca_compliant` BOOLEAN COMMENT 'Indicates whether this chemical product is listed on the TSCA Chemical Substance Inventory and compliant for commercial sale in the United States.',
    `unit_price` DECIMAL(18,2) COMMENT 'Proposed or target selling price per unit of measure for this chemical product in the opportunity. Represents the commercial pricing position before final negotiation.',
    `win_probability_pct` DECIMAL(18,2) COMMENT 'Estimated probability (0–100%) that this specific product line will be won, which may differ from the overall opportunity win probability when the customer is evaluating multiple products independently.',
    CONSTRAINT pk_opportunity_product PRIMARY KEY(`opportunity_product_id`)
) COMMENT 'Association record linking a specific chemical product or grade to a sales opportunity, capturing estimated quantity, unit of measure, estimated revenue, probability-weighted value, and competitive status for that product line within the opportunity. Enables product-level pipeline visibility and supports demand forecasting from the sales pipeline.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`sales`.`organization` (
    `organization_id` BIGINT COMMENT 'Primary key for sales_organization',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: In SAP-based chemical mfg, every sales organization is assigned to exactly one legal entity — fundamental organizational structure for statutory reporting, tax determination, and intercompany transact',
    `maintenance_plant_id` BIGINT COMMENT 'Foreign key linking to maintenance.plant. Business justification: In SAP-based chemical manufacturing, a sales organization is assigned to one or more plants for production order routing, available-to-promise checks, and delivery scheduling. This is a foundational S',
    `parent_organization_id` BIGINT COMMENT 'Identifier of the immediate parent sales organization in the hierarchy.',
    `parent_sales_organization_id` BIGINT COMMENT 'Self-referencing FK on sales_organization (parent_sales_organization_id)',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Sales organizations map to profit centers for CO-PA revenue reporting in chemical mfg. Finance uses this link to aggregate sales org performance into profit center P&L statements for management report',
    `address_line1` STRING COMMENT 'Primary street address of the sales organization.',
    `annual_budget` DECIMAL(18,2) COMMENT 'Planned annual financial budget for the sales organization.',
    `city` STRING COMMENT 'City where the sales organization is located.',
    `cost_center_code` STRING COMMENT 'Internal cost‑center code associated with the sales organization for financial reporting.',
    `country` STRING COMMENT 'Three‑letter ISO country code of the sales organization location.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the sales organization record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code used for the organization’s financial reporting.',
    `effective_from` DATE COMMENT 'Date when the sales organization became operational.',
    `effective_until` DATE COMMENT 'Date when the sales organization ceased operation (null if still active).',
    `number_of_employees` STRING COMMENT 'Total headcount employed by the sales organization.',
    `organization_type` STRING COMMENT 'Category that defines the scope or channel of the sales organization.',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the sales organization address.',
    `primary_contact_email` STRING COMMENT 'Main email address for contacting the sales organization.',
    `primary_contact_phone` STRING COMMENT 'Main telephone number for the sales organization.',
    `region_code` STRING COMMENT 'Geographic region identifier (e.g., NA, EU, APAC) for the sales organization.',
    `sales_channel` STRING COMMENT 'Channel through which the organization sells products.',
    `sales_organization_description` STRING COMMENT 'Free‑form text describing the purpose, focus, or notes about the sales organization.',
    `sales_organization_name` STRING COMMENT 'Human‑readable name of the sales organization.',
    `sales_organization_status` STRING COMMENT 'Current lifecycle state of the sales organization.',
    `state` STRING COMMENT 'State or province of the sales organization location.',
    `timezone` STRING COMMENT 'IANA time zone identifier for the sales organization (e.g., America/New_York).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the sales organization record.',
    CONSTRAINT pk_organization PRIMARY KEY(`organization_id`)
) COMMENT 'Master reference table for sales_organization. Referenced by sales_organization_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`organization`(`organization_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`quote`(`quote_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`organization`(`organization_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ADD CONSTRAINT `fk_sales_price_agreement_line_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`organization`(`organization_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ADD CONSTRAINT `fk_sales_price_agreement_line_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_parent_territory_id` FOREIGN KEY (`parent_territory_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ADD CONSTRAINT `fk_sales_territory_assignment_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`organization`(`organization_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ADD CONSTRAINT `fk_sales_territory_assignment_predecessor_assignment_territory_assignment_id` FOREIGN KEY (`predecessor_assignment_territory_assignment_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`territory_assignment`(`territory_assignment_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ADD CONSTRAINT `fk_sales_territory_assignment_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ADD CONSTRAINT `fk_sales_target_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`organization`(`organization_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ADD CONSTRAINT `fk_sales_target_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ADD CONSTRAINT `fk_sales_distributor_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ADD CONSTRAINT `fk_sales_distributor_agreement_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ADD CONSTRAINT `fk_sales_distributor_agreement_distributor_id` FOREIGN KEY (`distributor_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`distributor`(`distributor_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ADD CONSTRAINT `fk_sales_distributor_agreement_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`organization`(`organization_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ADD CONSTRAINT `fk_sales_distributor_agreement_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ADD CONSTRAINT `fk_sales_distributor_agreement_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ADD CONSTRAINT `fk_sales_rebate_agreement_distributor_id` FOREIGN KEY (`distributor_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`distributor`(`distributor_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ADD CONSTRAINT `fk_sales_rebate_agreement_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`organization`(`organization_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ADD CONSTRAINT `fk_sales_rebate_agreement_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ADD CONSTRAINT `fk_sales_rebate_agreement_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ADD CONSTRAINT `fk_sales_opportunity_product_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`organization` ADD CONSTRAINT `fk_sales_organization_parent_organization_id` FOREIGN KEY (`parent_organization_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`organization`(`organization_id`);
ALTER TABLE `chemical_mfg_ecm`.`sales`.`organization` ADD CONSTRAINT `fk_sales_organization_parent_sales_organization_id` FOREIGN KEY (`parent_sales_organization_id`) REFERENCES `chemical_mfg_ecm`.`sales`.`organization`(`organization_id`);

-- ========= TAGS =========
ALTER SCHEMA `chemical_mfg_ecm`.`sales` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `chemical_mfg_ecm`.`sales` SET TAGS ('dbx_domain' = 'sales');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` SET TAGS ('dbx_subdomain' = 'deal_management');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `quality_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `reach_dossier_id` SET TAGS ('dbx_business_glossary_term' = 'Reach Dossier Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `regulatory_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Profile Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `actual_close_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Close Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `close_probability_pct` SET TAGS ('dbx_business_glossary_term' = 'Close Probability Percentage');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `close_reason` SET TAGS ('dbx_business_glossary_term' = 'Close Reason');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `closed_amount` SET TAGS ('dbx_business_glossary_term' = 'Closed Deal Amount');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `closed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `crm_opportunity_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Opportunity ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `decision_criteria` SET TAGS ('dbx_business_glossary_term' = 'Decision Criteria');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `estimated_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Deal Amount');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `estimated_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `estimated_volume_kg` SET TAGS ('dbx_business_glossary_term' = 'Estimated Volume (Kilograms)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = '^Q[1-4]-[0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `forecast_category` SET TAGS ('dbx_business_glossary_term' = 'Forecast Category');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `forecast_category` SET TAGS ('dbx_value_regex' = 'Pipeline|Best Case|Commit|Closed|Omitted');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `is_key_account` SET TAGS ('dbx_business_glossary_term' = 'Is Key Account Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `is_won` SET TAGS ('dbx_business_glossary_term' = 'Is Won Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `lead_source` SET TAGS ('dbx_business_glossary_term' = 'Lead Source');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `next_step` SET TAGS ('dbx_business_glossary_term' = 'Next Step');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `opportunity_description` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Description');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Name');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `opportunity_type` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Type');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `opportunity_type` SET TAGS ('dbx_value_regex' = 'New Business|Existing Business Expansion|Renewal|Win-Back|Distributor|Direct');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `reach_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliance Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `requires_custom_formulation` SET TAGS ('dbx_business_glossary_term' = 'Requires Custom Formulation Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `requires_sds` SET TAGS ('dbx_business_glossary_term' = 'Requires Safety Data Sheet (SDS) Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'Direct|Distributor|Agent|E-Commerce|Tender');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Salesforce|SAP SD|Manual');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Stage');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `target_close_date` SET TAGS ('dbx_business_glossary_term' = 'Target Close Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity` ALTER COLUMN `tsca_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Toxic Substances Control Act (TSCA) Compliance Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` SET TAGS ('dbx_subdomain' = 'deal_management');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Opportunity ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `quality_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `regulatory_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Profile Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `sds_id` SET TAGS ('dbx_business_glossary_term' = 'Sds Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `coa_required` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Required');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `coc_required` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Compliance (COC) Required');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `converted_order_number` SET TAGS ('dbx_business_glossary_term' = 'Converted Sales Order Number');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `converted_order_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `crm_quote_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Quote Number');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `crm_quote_number` SET TAGS ('dbx_value_regex' = '^Q-[0-9]{6,10}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `customer_po_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order (PO) Number');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `customer_po_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `distribution_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `division_code` SET TAGS ('dbx_business_glossary_term' = 'Division Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `export_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Export Control Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_value_regex' = '^(EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF)$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `price_list_type` SET TAGS ('dbx_business_glossary_term' = 'Price List Type');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `price_list_type` SET TAGS ('dbx_value_regex' = 'standard|contract|spot|distributor|transfer');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `pricing_date` SET TAGS ('dbx_business_glossary_term' = 'Pricing Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `quote_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `quote_status` SET TAGS ('dbx_business_glossary_term' = 'Quote Status');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `quote_type` SET TAGS ('dbx_business_glossary_term' = 'Quote Type');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `quote_type` SET TAGS ('dbx_value_regex' = 'standard|spot|contract|distributor|intercompany|sample');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `sales_district_code` SET TAGS ('dbx_business_glossary_term' = 'Sales District Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `sap_quotation_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Quotation Number');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `sap_quotation_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `ship_to_country_code` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Country Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `ship_to_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `technical_notes` SET TAGS ('dbx_business_glossary_term' = 'Technical Notes');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `total_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Discount Amount');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `total_discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `total_surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Surcharge Amount');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `total_surcharge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Valid From Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Valid To Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `win_probability_pct` SET TAGS ('dbx_business_glossary_term' = 'Win Probability Percentage');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote` ALTER COLUMN `win_probability_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` SET TAGS ('dbx_subdomain' = 'deal_management');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Line ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `cas_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Cas Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `coa_template_id` SET TAGS ('dbx_business_glossary_term' = 'Coa Template Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `packaging_config_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Config Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `quality_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `batch_managed` SET TAGS ('dbx_business_glossary_term' = 'Batch Managed');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `coa_required` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Required');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `coc_required` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Compliance (COC) Required');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `contribution_margin` SET TAGS ('dbx_business_glossary_term' = 'Contribution Margin');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `contribution_margin` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `delivery_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Delivery Lead Time (Days)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `discount_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'GHS Hazard Class');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `hazmat_surcharge` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (Hazmat) Surcharge');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `incoterm_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `line_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Gross Amount');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `line_gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `line_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Net Amount');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `line_net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Status');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'draft|open|revised|accepted|rejected|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `product_description` SET TAGS ('dbx_business_glossary_term' = 'Product Description');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quoted Quantity');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'REACH Compliant');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `sds_required` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Required');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `small_order_surcharge` SET TAGS ('dbx_business_glossary_term' = 'Small Order Surcharge');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `tsca_compliant` SET TAGS ('dbx_business_glossary_term' = 'Toxic Substances Control Act (TSCA) Compliant');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'UN Number');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`quote_line` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` SET TAGS ('dbx_subdomain' = 'contract_pricing');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Name');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Number');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Status');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Type');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'contract_price|volume_rebate|long_term_supply|spot_price|distributor_price');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `annual_volume_commitment` SET TAGS ('dbx_business_glossary_term' = 'Annual Volume Commitment');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `annual_volume_commitment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revision_required');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `base_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Base Unit Price');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `base_unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = 'direct|distributor|toll_manufacturing|export');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `escalation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Frequency');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `escalation_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `escalation_index` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Index');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `escalation_index` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `min_order_qty` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `price_escalation_clause` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Clause Indicator');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `price_escalation_clause` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `price_per_qty` SET TAGS ('dbx_business_glossary_term' = 'Price Per Quantity');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `product_grade` SET TAGS ('dbx_business_glossary_term' = 'Product Grade');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'REACH Compliance Indicator');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `rebate_pct` SET TAGS ('dbx_business_glossary_term' = 'Rebate Percentage');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `rebate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `rebate_threshold_qty` SET TAGS ('dbx_business_glossary_term' = 'Rebate Threshold Quantity');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `rebate_threshold_qty` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `renewal_type` SET TAGS ('dbx_business_glossary_term' = 'Renewal Type');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `renewal_type` SET TAGS ('dbx_value_regex' = 'auto_renew|manual_renew|no_renewal');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `sap_condition_contract_no` SET TAGS ('dbx_business_glossary_term' = 'SAP Condition Contract Number');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Amount');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `surcharge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `surcharge_type` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Type');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `surcharge_type` SET TAGS ('dbx_value_regex' = 'energy|freight|raw_material|hazmat|none');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `surcharge_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `tsca_compliant` SET TAGS ('dbx_business_glossary_term' = 'TSCA Compliance Indicator');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement` ALTER COLUMN `volume_commitment_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` SET TAGS ('dbx_subdomain' = 'contract_pricing');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `price_agreement_line_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Line ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `packaging_config_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Config Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `quality_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `agreed_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Agreed Unit Price');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `agreed_unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `annual_volume_commitment` SET TAGS ('dbx_business_glossary_term' = 'Annual Volume Commitment');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `annual_volume_commitment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `condition_type_code` SET TAGS ('dbx_business_glossary_term' = 'Condition Type Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `index_adjustment_formula` SET TAGS ('dbx_business_glossary_term' = 'Index Adjustment Formula');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `index_adjustment_formula` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Line Status');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|suspended|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `min_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `price_index_linked` SET TAGS ('dbx_business_glossary_term' = 'Price Index Linked Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `price_index_name` SET TAGS ('dbx_business_glossary_term' = 'Price Index Name');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `price_per_quantity` SET TAGS ('dbx_business_glossary_term' = 'Price Per Quantity');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `rebate_basis` SET TAGS ('dbx_business_glossary_term' = 'Rebate Basis');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `rebate_basis` SET TAGS ('dbx_value_regex' = 'invoice_value|net_sales|volume_kg|volume_mt');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `rebate_percent` SET TAGS ('dbx_business_glossary_term' = 'Rebate Percentage');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `rebate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Amount');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `surcharge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `surcharge_percent` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Percentage');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `surcharge_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `surcharge_type` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Type');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `surcharge_type` SET TAGS ('dbx_value_regex' = 'energy|freight|raw_material|hazmat|none');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `take_or_pay_flag` SET TAGS ('dbx_business_glossary_term' = 'Take-or-Pay Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `tier_1_min_qty` SET TAGS ('dbx_business_glossary_term' = 'Tier 1 Minimum Quantity');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `tier_1_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Tier 1 Unit Price');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `tier_1_unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `tier_2_min_qty` SET TAGS ('dbx_business_glossary_term' = 'Tier 2 Minimum Quantity');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `tier_2_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Tier 2 Unit Price');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `tier_2_unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `tier_3_min_qty` SET TAGS ('dbx_business_glossary_term' = 'Tier 3 Minimum Quantity');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `tier_3_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Tier 3 Unit Price');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `tier_3_unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `volume_tier_flag` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `volume_tier_type` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier Type');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`price_agreement_line` ALTER COLUMN `volume_tier_type` SET TAGS ('dbx_value_regex' = 'quantity|value|weight');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` SET TAGS ('dbx_subdomain' = 'territory_planning');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `maintenance_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `parent_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Territory ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `annual_quota_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Sales Quota (USD)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `annual_quota_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Type');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'direct|distributor|agent|e_commerce|hybrid');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `commission_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `commission_plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `commission_plan_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `customer_count` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Count');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `distribution_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `distribution_channel_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `division_code` SET TAGS ('dbx_business_glossary_term' = 'Division Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `division_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Territory Effective End Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Territory Effective Start Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `hazmat_handling_required` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Handling Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Territory Hierarchy Level');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_value_regex' = 'global|regional|area|local');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `industry_vertical` SET TAGS ('dbx_business_glossary_term' = 'Industry Vertical');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `last_realignment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Territory Realignment Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `named_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Named Account Territory Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `product_line_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Line Scope');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `quota_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Quota Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `quota_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `reach_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'REACH Regulated Territory Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,10}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `rep_assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Representative Assignment End Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `rep_assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Representative Assignment Start Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `sales_org_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization (Sales Org) Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `sales_org_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `salesforce_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce CRM Territory ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `salesforce_territory_code` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9]{15,18}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `sap_sales_district_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Sales District Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `sap_sales_district_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `state_province_code` SET TAGS ('dbx_business_glossary_term' = 'State / Province Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `state_province_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `strategic_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Strategic Account Territory Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `technical_sales_required` SET TAGS ('dbx_business_glossary_term' = 'Technical Sales Support Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `territory_description` SET TAGS ('dbx_business_glossary_term' = 'Territory Description');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_business_glossary_term' = 'Territory Name');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Status');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|archived');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_business_glossary_term' = 'Territory Type');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_value_regex' = 'geographic|industry_vertical|named_account|product_line|hybrid');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory` ALTER COLUMN `tsca_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'TSCA Regulated Territory Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` SET TAGS ('dbx_subdomain' = 'territory_planning');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `territory_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Assignment ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `predecessor_assignment_territory_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Assignment ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `account_count_target` SET TAGS ('dbx_business_glossary_term' = 'Target Account Count');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Approval Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Territory Assignment Number');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_value_regex' = '^TA-[0-9]{8}-[A-Z0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Assignment Status');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Territory Assignment Type');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'geographic|account-based|product-based|channel-based');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Type');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'direct|distributor|oem|ecommerce|hybrid');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `commission_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `commission_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `coverage_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Coverage Scope');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `coverage_scope` SET TAGS ('dbx_value_regex' = 'national|regional|district|local|global');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `crm_assignment_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Assignment ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `distribution_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `distribution_channel_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `division_code` SET TAGS ('dbx_business_glossary_term' = 'Division Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `division_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `effective_fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Effective Fiscal Quarter');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `effective_fiscal_quarter` SET TAGS ('dbx_value_regex' = '^Q[1-4]$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `effective_fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Effective Fiscal Year');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `effective_fiscal_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `industry_segment_focus` SET TAGS ('dbx_business_glossary_term' = 'Industry Segment Focus');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `is_commission_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Commission Eligible Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `is_primary_assignment` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Assignment Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `is_quota_bearing` SET TAGS ('dbx_business_glossary_term' = 'Is Quota Bearing Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `product_line_focus` SET TAGS ('dbx_business_glossary_term' = 'Product Line Focus');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `quota_amount` SET TAGS ('dbx_business_glossary_term' = 'Territory Sales Quota Amount');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `quota_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `quota_currency` SET TAGS ('dbx_business_glossary_term' = 'Quota Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `quota_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `quota_period_type` SET TAGS ('dbx_business_glossary_term' = 'Quota Period Type');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `quota_period_type` SET TAGS ('dbx_value_regex' = 'annual|semi-annual|quarterly|monthly');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Territory Role Type');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `role_type` SET TAGS ('dbx_value_regex' = 'primary|backup|overlay|interim|co-primary');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `sap_sd_assignment_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Sales and Distribution (SD) Assignment ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `state_province_code` SET TAGS ('dbx_business_glossary_term' = 'State or Province Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `state_province_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Termination Reason');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`territory_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` SET TAGS ('dbx_subdomain' = 'territory_planning');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Target Identifier');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Product Line ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `actual_revenue_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Revenue (USD)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `actual_revenue_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `actual_volume_mt` SET TAGS ('dbx_business_glossary_term' = 'Actual Volume (Metric Tons)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Target Approval Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (Manager Name)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `assignment_level` SET TAGS ('dbx_business_glossary_term' = 'Target Assignment Level');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `assignment_level` SET TAGS ('dbx_value_regex' = 'sales_rep|territory|product_line|business_unit|channel');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `baseline_year` SET TAGS ('dbx_business_glossary_term' = 'Baseline Reference Year');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period (Month Number)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `floor_revenue_usd` SET TAGS ('dbx_business_glossary_term' = 'Floor Revenue Target (USD)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `floor_revenue_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Sales Region');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `growth_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Growth Rate Percentage');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `growth_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `last_revised_date` SET TAGS ('dbx_business_glossary_term' = 'Last Target Revision Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `margin_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Gross Margin Percentage');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `margin_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Target Notes');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Target Period End Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `period_granularity` SET TAGS ('dbx_business_glossary_term' = 'Target Period Granularity');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `period_granularity` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Period Start Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `revenue_attainment_pct` SET TAGS ('dbx_business_glossary_term' = 'Revenue Attainment Percentage');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `revenue_attainment_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `revenue_usd` SET TAGS ('dbx_business_glossary_term' = 'Target Revenue (USD)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `revenue_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Target Revision Reason');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `revision_reason` SET TAGS ('dbx_value_regex' = 'market_conditions|portfolio_change|territory_realignment|acquisition|force_majeure|correction');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'direct|distributor|oem|ecommerce|agent');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `setting_method` SET TAGS ('dbx_business_glossary_term' = 'Target Setting Method');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `setting_method` SET TAGS ('dbx_value_regex' = 'top_down|bottom_up|negotiated|statistical');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `stretch_revenue_usd` SET TAGS ('dbx_business_glossary_term' = 'Stretch Revenue Target (USD)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `stretch_revenue_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `target_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Target Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `target_code` SET TAGS ('dbx_value_regex' = '^TGT-[A-Z0-9]{4,20}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `target_name` SET TAGS ('dbx_business_glossary_term' = 'Sales Target Name');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `target_status` SET TAGS ('dbx_business_glossary_term' = 'Sales Target Status');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `target_status` SET TAGS ('dbx_value_regex' = 'draft|active|approved|closed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `target_type` SET TAGS ('dbx_business_glossary_term' = 'Sales Target Type');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `target_type` SET TAGS ('dbx_value_regex' = 'revenue|volume|margin|new_business|account_growth');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `volume_attainment_pct` SET TAGS ('dbx_business_glossary_term' = 'Volume Attainment Percentage');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `volume_mt` SET TAGS ('dbx_business_glossary_term' = 'Target Volume (Metric Tons)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`target` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'MT|KG|L|GAL|LB');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` SET TAGS ('dbx_subdomain' = 'channel_partners');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `distributor_id` SET TAGS ('dbx_business_glossary_term' = 'Distributor ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `maintenance_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Salesforce CRM Account ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `agreement_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `agreement_effective_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `agreement_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Expiry Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `agreement_expiry_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Number');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^DA-[A-Z0-9-]{4,20}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `agreement_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Type');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'exclusive|non_exclusive|preferred|consignment');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `agreement_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `annual_purchase_commitment` SET TAGS ('dbx_business_glossary_term' = 'Annual Purchase Commitment');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `annual_purchase_commitment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `authorized_product_categories` SET TAGS ('dbx_business_glossary_term' = 'Authorized Product Categories');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Expiry Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Type');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'direct|indirect|hybrid|online');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `credit_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Credit Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `credit_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `distributor_code` SET TAGS ('dbx_business_glossary_term' = 'Distributor Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `distributor_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,20}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `distributor_status` SET TAGS ('dbx_business_glossary_term' = 'Distributor Status');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `distributor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|terminated');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `distributor_tier` SET TAGS ('dbx_business_glossary_term' = 'Distributor Tier Classification');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `distributor_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|strategic');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `distributor_type` SET TAGS ('dbx_business_glossary_term' = 'Distributor Type');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `distributor_type` SET TAGS ('dbx_value_regex' = 'exclusive|non_exclusive|master|sub_distributor|agent');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Dun & Bradstreet (DUNS) Number');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `ghs_classification_acknowledged` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Classification Acknowledgement Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `iso_9001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Quality Management Certification Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Distributor Legal Name');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `legal_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `moq_kg` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) in Kilograms');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Distributor Onboarding Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-.()]{7,20}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_business_glossary_term' = 'REACH Registration Number');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{10}-[0-9]{2}-[0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `rebate_structure_code` SET TAGS ('dbx_business_glossary_term' = 'Rebate Structure Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `rebate_structure_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{2,15}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `rebate_structure_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `responsible_distribution_certified` SET TAGS ('dbx_business_glossary_term' = 'Responsible Distribution Certification Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `sap_customer_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Customer Number');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `sap_customer_number` SET TAGS ('dbx_value_regex' = '^[0-9]{7,10}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `sds_distribution_obligation` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Distribution Obligation Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Distributor Termination Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `trade_name` SET TAGS ('dbx_business_glossary_term' = 'Distributor Trade Name (DBA)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor` ALTER COLUMN `tsca_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Toxic Substances Control Act (TSCA) Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` SET TAGS ('dbx_subdomain' = 'channel_partners');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `distributor_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distributor Agreement ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Opportunity ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `distributor_id` SET TAGS ('dbx_business_glossary_term' = 'Distributor ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `quality_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `reach_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Reach Registration Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Distributor Agreement Number');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^DA-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Distributor Agreement Status');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Distributor Agreement Type');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'exclusive|non_exclusive|master|sub|trial');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `agreement_version` SET TAGS ('dbx_business_glossary_term' = 'Agreement Version Number');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `amendment_description` SET TAGS ('dbx_business_glossary_term' = 'Amendment Description');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `authorized_product_categories` SET TAGS ('dbx_business_glossary_term' = 'Authorized Product Categories');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `coa_required` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Required');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `credit_limit_usd` SET TAGS ('dbx_business_glossary_term' = 'Distributor Credit Limit (USD)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `credit_limit_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Agreement Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Mechanism');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_value_regex' = 'arbitration|litigation|mediation|negotiation');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `ehs_training_required` SET TAGS ('dbx_business_glossary_term' = 'Environment Health and Safety (EHS) Training Required');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_value_regex' = 'full_portfolio|product_category|single_product|none');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Expiry Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `governing_law_country` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Country Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `governing_law_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `moq_annual_usd` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Annual Commitment (USD)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `moq_annual_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `product_application_support` SET TAGS ('dbx_business_glossary_term' = 'Product Application Support Included');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `reach_downstream_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'REACH Downstream User Reporting Required');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `rebate_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Rebate Rate Percentage');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `rebate_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `rebate_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Rebate Structure Type');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `rebate_structure_type` SET TAGS ('dbx_value_regex' = 'volume_tiered|flat_rate|growth_incentive|none');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `rebate_structure_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Renewal Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `responsible_care_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Responsible Care Compliance Required');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `sap_contract_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Contract Number');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `sds_distribution_required` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Distribution Required');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Signed Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Termination Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Agreement Termination Reason');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `territory_country_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Primary Country Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `territory_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`distributor_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` SET TAGS ('dbx_subdomain' = 'contract_pricing');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `rebate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rebate Agreement ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Accrual Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `distributor_id` SET TAGS ('dbx_business_glossary_term' = 'Distributor Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Product Hierarchy ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Opportunity ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `accrual_method` SET TAGS ('dbx_business_glossary_term' = 'Rebate Accrual Method');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `accrual_method` SET TAGS ('dbx_value_regex' = 'accrual_based|cash_basis|manual');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `accrued_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued Rebate Amount');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `accrued_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `agreement_notes` SET TAGS ('dbx_business_glossary_term' = 'Rebate Agreement Notes');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `agreement_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Rebate Agreement Number');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Rebate Agreement Status');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|settled|expired|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Rebate Agreement Type');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'volume_rebate|growth_incentive|market_development_fund|distributor_rebate|loyalty_rebate|performance_rebate');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Rebate Agreement Approval Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `baseline_period_end` SET TAGS ('dbx_business_glossary_term' = 'Baseline Period End Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `baseline_period_start` SET TAGS ('dbx_business_glossary_term' = 'Baseline Period Start Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Rebate Calculation Basis');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_value_regex' = 'revenue|volume|quantity|weight_kg|mixed');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Type');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'direct|distributor|dealer|oem|ecommerce');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Until Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `eligible_product_scope` SET TAGS ('dbx_business_glossary_term' = 'Eligible Product Scope');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `eligible_product_scope` SET TAGS ('dbx_value_regex' = 'all_products|product_group|specific_skus|product_line|material_type');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `growth_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Growth Target Percentage');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `growth_target_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `is_retroactive` SET TAGS ('dbx_business_glossary_term' = 'Is Retroactive Rebate Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `is_tiered` SET TAGS ('dbx_business_glossary_term' = 'Is Tiered Rebate Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `last_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Settlement Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `max_rebate_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Rebate Cap Amount');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `max_rebate_cap_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `next_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Next Settlement Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `payout_currency` SET TAGS ('dbx_business_glossary_term' = 'Rebate Payout Currency');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `payout_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `rebate_amount_fixed` SET TAGS ('dbx_business_glossary_term' = 'Fixed Rebate Amount');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `rebate_amount_fixed` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `rebate_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Rebate Rate Percentage');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `rebate_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `sap_rebate_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Rebate Agreement ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `settled_amount` SET TAGS ('dbx_business_glossary_term' = 'Settled Rebate Amount');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `settled_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Rebate Settlement Frequency');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|on_demand');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Rebate Settlement Method');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'credit_memo|check|bank_transfer|product_credit');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `threshold_basis_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Threshold Basis Amount');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `threshold_basis_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`rebate_agreement` ALTER COLUMN `threshold_basis_unit` SET TAGS ('dbx_business_glossary_term' = 'Rebate Threshold Basis Unit');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` SET TAGS ('dbx_subdomain' = 'deal_management');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `opportunity_product_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Product ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `cas_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Cas Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `cost_element_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `packaging_config_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Config Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `product_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `sds_id` SET TAGS ('dbx_business_glossary_term' = 'Sds Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `tds_id` SET TAGS ('dbx_business_glossary_term' = 'Tds Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `annual_volume_estimate` SET TAGS ('dbx_business_glossary_term' = 'Annual Volume Estimate');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `application_end_use` SET TAGS ('dbx_business_glossary_term' = 'Application End Use');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Close Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `coa_required` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `competitive_status` SET TAGS ('dbx_business_glossary_term' = 'Competitive Status');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `competitive_status` SET TAGS ('dbx_value_regex' = 'sole_source|competitive_bid|incumbent|new_business|displacement');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `competitor_name` SET TAGS ('dbx_business_glossary_term' = 'Competitor Name');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `competitor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `crm_opportunity_product_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Opportunity Product ID');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `delivery_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Delivery Lead Time (Days)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `discount_pct` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `discount_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `estimated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Estimated Quantity');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `estimated_revenue` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `estimated_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `first_shipment_date` SET TAGS ('dbx_business_glossary_term' = 'First Shipment Date');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `formulation_required` SET TAGS ('dbx_business_glossary_term' = 'Formulation Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `list_price` SET TAGS ('dbx_business_glossary_term' = 'List Price');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `list_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `moq` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `opportunity_product_status` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Product Status');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `opportunity_product_status` SET TAGS ('dbx_value_regex' = 'active|won|lost|withdrawn|on_hold');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `probability_weighted_revenue` SET TAGS ('dbx_business_glossary_term' = 'Probability-Weighted Revenue');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `probability_weighted_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `sales_stage` SET TAGS ('dbx_business_glossary_term' = 'Sales Stage');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `sample_requested` SET TAGS ('dbx_business_glossary_term' = 'Sample Requested Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `sap_sd_item_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Sales and Distribution (SD) Item Number');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `sap_sd_item_number` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `sds_required` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `technical_review_required` SET TAGS ('dbx_business_glossary_term' = 'Technical Review Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `tsca_compliant` SET TAGS ('dbx_business_glossary_term' = 'Toxic Substances Control Act (TSCA) Compliant Flag');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`opportunity_product` ALTER COLUMN `win_probability_pct` SET TAGS ('dbx_business_glossary_term' = 'Win Probability Percentage');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`organization` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`organization` SET TAGS ('dbx_subdomain' = 'territory_planning');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`organization` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Identifier');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`organization` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`organization` ALTER COLUMN `maintenance_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`organization` ALTER COLUMN `parent_sales_organization_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`organization` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`organization` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`organization` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`organization` ALTER COLUMN `annual_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`organization` ALTER COLUMN `annual_budget` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`organization` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`organization` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`organization` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`organization` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`organization` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`organization` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`organization` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`organization` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`organization` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`sales`.`organization` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
