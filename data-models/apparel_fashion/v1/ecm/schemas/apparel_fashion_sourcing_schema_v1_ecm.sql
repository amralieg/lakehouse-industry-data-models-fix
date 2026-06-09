-- Schema for Domain: sourcing | Business: Apparel Fashion | Version: v1_ecm
-- Generated on: 2026-05-05 15:54:38

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `apparel_fashion_ecm`.`sourcing` COMMENT 'Owns the strategic and tactical sourcing process including RFQ/RFP management, costing (CMT, FOB), material development, SMS (Sample Management System), and PP approval workflows. Manages the Time and Action (TNA) calendar, MOQ negotiations, and fabric/trim procurement from mills and vendors via Centric PLM and Infor PLM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` (
    `rfq_id` BIGINT COMMENT 'Unique identifier for the request for quotation record. Primary key.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or mill that was selected and awarded the business as a result of this RFQ evaluation.',
    `collection_id` BIGINT COMMENT 'Reference to the product collection or line this RFQ supports.',
    `concept_id` BIGINT COMMENT 'Foreign key linking to design.concept. Business justification: RFQs are issued to source materials/production for approved design concepts. Enables concept-to-sourcing traceability, cost validation against design targets, and sourcing performance reporting by con',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: RFQs are created and owned by sourcing employees. Tracks accountability for RFQ issuance, vendor selection decisions, and award approvals. Essential for sourcing performance metrics and audit trails i',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: RFQs specify compliance obligations (labor standards, sustainability certifications, chemical restrictions) that vendors must meet. Buyers use this to enforce compliance requirements in sourcing decis',
    `sustainable_material_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainable_material. Business justification: RFQs specify target sustainable materials for new product development. Buyers reference sustainable material specifications when issuing RFQs to ensure sustainability requirements are met. Critical fo',
    `award_date` DATE COMMENT 'The date when the RFQ was awarded to the selected vendor.',
    `awarded_quote_amount` DECIMAL(18,2) COMMENT 'The final quoted unit price from the awarded vendor.',
    `closed_timestamp` TIMESTAMP COMMENT 'The date and time when this RFQ was formally closed, either through award or cancellation.',
    `compliance_requirements` STRING COMMENT 'Any regulatory, labor, or ethical compliance requirements that vendors must meet (e.g., WRAP certification, FLA compliance, CPSC safety standards).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this RFQ record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this RFQ (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `destination_country` STRING COMMENT 'Three-letter ISO country code for the destination country or primary market for the goods.. Valid values are `^[A-Z]{3}$`',
    `estimated_volume` STRING COMMENT 'The anticipated total order volume or quantity that may be placed if the RFQ results in an award.',
    `fabric_composition` STRING COMMENT 'The fiber content and blend percentages for fabric RFQs (e.g., 80% Cotton 20% Polyester).',
    `hs_code` STRING COMMENT 'The Harmonized System tariff classification code for the goods being sourced, used for customs and duty calculation.. Valid values are `^[0-9]{6,10}$`',
    `incoterms` STRING COMMENT 'International Commercial Terms defining the responsibilities, costs, and risks between buyer and seller (e.g., FOB, CIF, EXW). [ENUM-REF-CANDIDATE: exw|fca|cpt|cip|dat|dap|ddp|fas|fob|cfr|cif — 11 candidates stripped; promote to reference product]',
    `issue_date` DATE COMMENT 'The date when the RFQ was formally issued and sent to vendors or mills.',
    `lead_time_days` STRING COMMENT 'The requested or expected production and delivery lead time in days from order placement to delivery.',
    `material_type` STRING COMMENT 'The type or category of material being sourced through this RFQ (e.g., cotton fabric, polyester blend, leather, zipper, button).',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this RFQ record was last modified or updated.',
    `moq_quantity` STRING COMMENT 'The minimum order quantity being requested or negotiated as part of this RFQ.',
    `moq_unit` STRING COMMENT 'The unit of measure for the MOQ (e.g., pieces, yards, meters, kilograms).. Valid values are `pieces|units|yards|meters|kilograms|dozens`',
    `notes` STRING COMMENT 'Additional notes, special instructions, or comments related to this RFQ that vendors should be aware of.',
    `payment_terms` STRING COMMENT 'The payment terms and conditions specified in the RFQ (e.g., Net 30, Net 60, Letter of Credit, 50% deposit).',
    `product_category` STRING COMMENT 'High-level product category classification for the items covered by this RFQ.. Valid values are `apparel|footwear|accessories|athletic|lifestyle|luxury`',
    `quality_standard` STRING COMMENT 'The quality specifications, testing standards, or acceptance criteria that vendors must meet (e.g., AQL 2.5, ISO 9001, specific performance requirements).',
    `quote_received_count` STRING COMMENT 'The number of vendor quotations received in response to this RFQ.',
    `rfq_number` STRING COMMENT 'Business-facing unique identifier for the RFQ, used in vendor communications and sourcing documentation.. Valid values are `^RFQ-[0-9]{6,10}$`',
    `rfq_status` STRING COMMENT 'Current lifecycle status of the RFQ: draft (being prepared), issued (sent to vendors), under evaluation (quotes received and being reviewed), awarded (vendor selected), closed (process complete), cancelled (RFQ withdrawn).. Valid values are `draft|issued|under_evaluation|awarded|closed|cancelled`',
    `rfq_type` STRING COMMENT 'Classification of the RFQ based on sourcing scope: CMT (Cut Make Trim), FOB (Free on Board), material procurement, trim sourcing, fabric sourcing, or full package manufacturing.. Valid values are `cmt|fob|material|trim|fabric|full_package`',
    `sample_required_flag` BOOLEAN COMMENT 'Indicates whether vendors are required to submit physical samples as part of their quotation response.',
    `sample_submission_deadline` DATE COMMENT 'The deadline by which vendors must submit physical samples if required.',
    `season_code` STRING COMMENT 'The fashion season or collection period this RFQ is associated with (e.g., SS24 for Spring/Summer 2024, FW24 for Fall/Winter 2024).. Valid values are `^(SS|FW|SP|FA)[0-9]{2}$`',
    `shipping_origin_country` STRING COMMENT 'Three-letter ISO country code for the country from which goods will be shipped (e.g., CHN for China, VNM for Vietnam, IND for India).. Valid values are `^[A-Z]{3}$`',
    `sourcing_region` STRING COMMENT 'The geographic region being targeted for sourcing through this RFQ.. Valid values are `asia|europe|americas|middle_east|africa`',
    `style_reference` STRING COMMENT 'The style number or design reference code that this RFQ is requesting quotes for.',
    `submission_deadline` DATE COMMENT 'The final date by which vendors must submit their quotations in response to this RFQ.',
    `sustainability_requirement` STRING COMMENT 'Any sustainability or certification requirements specified in the RFQ (e.g., GOTS certified, BCI cotton, OEKO-TEX Standard 100, recycled materials, organic).. Valid values are `none|gots|bci|oeko_tex|recycled|organic`',
    `target_cost` DECIMAL(18,2) COMMENT 'The desired or budgeted unit cost that the business is aiming to achieve through this RFQ process.',
    `technical_pack_reference` STRING COMMENT 'Reference to the technical specification document or tech pack that provides detailed construction, measurement, and material specifications for the RFQ.',
    `vendor_count` STRING COMMENT 'The number of vendors or mills to whom this RFQ has been issued.',
    CONSTRAINT pk_rfq PRIMARY KEY(`rfq_id`)
) COMMENT 'Request for Quotation master record capturing the formal solicitation sent to vendors or mills for CMT, FOB, or material pricing. Tracks RFQ number, season, style references, target cost, submission deadline, currency, incoterms, and lifecycle status (draft, issued, under evaluation, awarded, closed). SSOT for all sourcing quote requests.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` (
    `rfq_line_id` BIGINT COMMENT 'Unique identifier for the RFQ line item. Primary key for this entity.',
    `rfq_id` BIGINT COMMENT 'Reference to the parent RFQ header document. Links this line item to the overall RFQ request.',
    `sketch_id` BIGINT COMMENT 'Foreign key linking to design.design_sketch. Business justification: RFQ lines reference specific design sketches when sourcing materials/production for that design. Enables design-to-sourcing handoff tracking, ensures vendor quotes align with design specifications, su',
    `style_id` BIGINT COMMENT 'Foreign key linking to product.style. Business justification: RFQ lines quote specific styles for vendor cost estimation. Critical for sourcing decisions, vendor selection, and cost comparison. Apparel buyers always link RFQ line items to style master for accura',
    `sustainable_material_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainable_material. Business justification: Individual RFQ lines specify sustainable material requirements at the style/colorway level. Enables line-level sustainable material specification and tracking for product development. Essential for ma',
    `approval_status` STRING COMMENT 'Internal approval workflow status for this RFQ line. Tracks progression through sourcing, merchandising, and finance approval gates.. Valid values are `draft|pending_approval|approved|rejected|on_hold`',
    `bom_reference` STRING COMMENT 'Reference to the Bill of Materials document listing all components, fabrics, and trims required for this style.',
    `buyer_notes` STRING COMMENT 'Internal notes from the buyer or sourcing team regarding special requirements, constraints, or context for this line item.',
    `colorway_code` STRING COMMENT 'Color variant code for the style being quoted. Represents specific color combination or finish.. Valid values are `^[A-Z0-9]{2,10}$`',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO currency code for all cost values on this line. Typically USD, EUR, CNY, or other manufacturing region currencies.. Valid values are `^[A-Z]{3}$`',
    `country_of_origin` STRING COMMENT 'Expected country of manufacture for this line item. Impacts duty rates, trade agreements (GSP), and compliance labeling requirements.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this RFQ line item was first created in the system. Audit trail for sourcing process tracking.',
    `gender_classification` STRING COMMENT 'Target gender demographic for the product. Used for merchandising planning and assortment allocation.. Valid values are `mens|womens|unisex|boys|girls|infant`',
    `hs_code` STRING COMMENT 'Harmonized System tariff classification code for customs and duty calculation. Required for international trade compliance.. Valid values are `^[0-9]{6,10}$`',
    `incoterm` STRING COMMENT 'Incoterms code defining the delivery terms and transfer of risk between buyer and vendor. Most common in apparel is FOB (Free on Board). [ENUM-REF-CANDIDATE: EXW|FOB|CIF|DDP|FCA|CPT|DAP|DPU — 8 candidates stripped; promote to reference product]',
    `lead_time_days` STRING COMMENT 'Requested production lead time in days from order placement to ex-factory date. Critical for Time and Action (TNA) calendar planning.',
    `line_number` STRING COMMENT 'Sequential line number within the RFQ document. Used for ordering and referencing specific line items in vendor communications.',
    `material_description` STRING COMMENT 'Detailed description of the fabric, trim, or material being sourced. Includes composition, weight, finish, and construction details.',
    `material_type` STRING COMMENT 'Category of material being quoted. Classifies the component type for sourcing and costing purposes. [ENUM-REF-CANDIDATE: fabric|trim|accessory|packaging|label|thread|zipper|button — 8 candidates stripped; promote to reference product]',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this RFQ line. Tracks changes during negotiation and vendor response cycles.',
    `moq_quantity` STRING COMMENT 'Minimum order quantity requested from vendors for this line item. Critical for vendor capability assessment and cost negotiation.',
    `packaging_requirement` STRING COMMENT 'Packaging specifications for this line item. Includes polybag requirements, hangtags, labels, carton specifications, and shipping marks.',
    `port_of_loading` STRING COMMENT 'Expected port of origin for shipment. Critical for logistics planning and landed cost calculation.',
    `priority_level` STRING COMMENT 'Business priority level for this RFQ line. Critical items require expedited vendor response and faster decision cycles.. Valid values are `critical|high|medium|low`',
    `product_category` STRING COMMENT 'High-level product category classification for merchandising and sourcing segmentation. Examples: tops, bottoms, outerwear, footwear, accessories.',
    `quality_standard` STRING COMMENT 'Quality and compliance standards required for this line item. May reference OEKO-TEX, GOTS, BCI, or internal quality specifications.',
    `quantity_break_tier_1` STRING COMMENT 'First quantity threshold for tiered pricing. Vendors provide different unit costs based on volume commitments.',
    `quantity_break_tier_2` STRING COMMENT 'Second quantity threshold for tiered pricing. Enables cost comparison across different volume scenarios.',
    `quantity_break_tier_3` STRING COMMENT 'Third quantity threshold for tiered pricing. Supports complex volume-based sourcing strategies.',
    `requested_quantity` STRING COMMENT 'Total quantity being requested in the RFQ for this line item. Used for volume-based pricing negotiations.',
    `response_due_date` DATE COMMENT 'Date by which vendors must submit their quotations for this line item. Critical for Time and Action (TNA) calendar management.',
    `sample_required_flag` BOOLEAN COMMENT 'Indicates whether physical samples are required from vendors as part of the RFQ response. Critical for SMS (Sample Management System) workflow.',
    `sample_type` STRING COMMENT 'Type of sample requested from vendors. Includes proto (prototype), fit sample, PP (pre-production), SMS (salesman sample), strike-off (fabric), or lab dip (color). [ENUM-REF-CANDIDATE: proto|fit|pp|sms|production|strike_off|lab_dip — 7 candidates stripped; promote to reference product]',
    `season_code` STRING COMMENT 'Fashion season or collection code this RFQ line belongs to. Examples: SS24 (Spring/Summer 2024), FW24 (Fall/Winter 2024), Holiday 2024.',
    `size_range` STRING COMMENT 'Size range or size breakdown for the style being quoted. May include standard sizing (XS-XXL) or numeric sizing depending on product category.',
    `sustainability_requirement` STRING COMMENT 'Sustainability or ethical sourcing requirements for this line. May include organic certification, recycled content, fair labor standards, or carbon footprint targets.',
    `target_cmt_cost` DECIMAL(18,2) COMMENT 'Target CMT cost per unit for manufacturing services only. Excludes material costs, represents labor and production overhead.',
    `target_fob_cost` DECIMAL(18,2) COMMENT 'Target FOB cost per unit that the buyer is seeking from vendors. Represents the price at the port of origin before shipping.',
    `tech_pack_reference` STRING COMMENT 'Reference identifier to the technical specification package in PLM system. Contains construction details, measurements, and quality standards.',
    `testing_requirement` STRING COMMENT 'Laboratory testing requirements for materials or finished goods. May include colorfastness, shrinkage, pilling, flammability, or chemical content testing.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for quantities and pricing. Varies by material type (pieces for garments, yards for fabric, etc.). [ENUM-REF-CANDIDATE: piece|yard|meter|kilogram|dozen|gross|roll|set — 8 candidates stripped; promote to reference product]',
    `vendor_notes` STRING COMMENT 'Notes or comments provided by vendors in their quotation response. May include production constraints, alternative suggestions, or clarification requests.',
    `vendor_response_status` STRING COMMENT 'Current status of vendor responses for this RFQ line. Tracks the quotation lifecycle from request through vendor selection.. Valid values are `pending|submitted|under_review|accepted|rejected|withdrawn`',
    CONSTRAINT pk_rfq_line PRIMARY KEY(`rfq_line_id`)
) COMMENT 'Individual line item within an RFQ representing a specific style, colorway, or material being quoted. Captures style number, material description, target FOB/CMT cost, MOQ, lead time requested, quantity break tiers, and vendor response status. Enables granular cost comparison across multiple vendor responses for vendor selection.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` (
    `vendor_quote_id` BIGINT COMMENT 'Unique identifier for the vendor quote record. Primary key.',
    `compliance_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_certification. Business justification: Vendor quotes must reference certifications they hold to qualify for RFQ evaluation. Sourcing teams use certification status as a scoring criterion in vendor selection. Quotes without required certifi',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Vendor quotes must be assigned to cost centers for RFQ budget tracking, procurement planning, and cost benchmarking - enables financial control over sourcing decisions before PO commitment.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Vendor quotes are evaluated by sourcing analysts who benchmark pricing, assess capacity, and recommend awards. Tracks who performed quote analysis for accountability in cost negotiations and vendor se',
    `rfq_id` BIGINT COMMENT 'Reference to the RFQ that this quote responds to. Links the vendor response back to the sourcing request.',
    `style_id` BIGINT COMMENT 'Foreign key linking to product.style. Business justification: Vendor quotes price specific styles. Essential for cost analysis, vendor comparison, and award decisions. Sourcing teams must link quotes to style master for accurate cost tracking and historical anal',
    `supplier_esg_assessment_id` BIGINT COMMENT 'Foreign key linking to sustainability.supplier_esg_assessment. Business justification: Vendor quotes are evaluated against current ESG assessments for responsible sourcing decisions. Sourcing teams must verify ESG compliance before awarding business. Mandatory for ethical sourcing polic',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier submitting this quote.',
    `acceptance_date` DATE COMMENT 'Date the buyer formally accepted this quote. Triggers conversion to purchase order or contract.',
    `acceptance_status` STRING COMMENT 'Buyer decision status on this quote. Indicates whether the quote has been accepted, rejected, or is under negotiation.. Valid values are `pending|accepted|rejected|negotiating`',
    `benchmark_score` DECIMAL(18,2) COMMENT 'Comparative score assigned to this quote during vendor selection analysis. Enables objective comparison across multiple vendor quotes.',
    `capacity_available_units` STRING COMMENT 'Production capacity available from the vendor for this quote period. Indicates maximum units the vendor can produce within the lead time window.',
    `cmt_rate` DECIMAL(18,2) COMMENT 'Quoted CMT rate per unit. Represents the manufacturing labor cost for cutting fabric, making the garment, and trimming/finishing, excluding material costs.',
    `counter_terms` STRING COMMENT 'Any counter-proposals, exceptions, or deviations from the original RFQ terms proposed by the vendor. Captures negotiation points.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor quote record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this quote (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `duty_rate_percent` DECIMAL(18,2) COMMENT 'Estimated import duty rate as a percentage of FOB value. Based on Harmonized System (HS) code classification and destination country tariff schedule.',
    `fob_price` DECIMAL(18,2) COMMENT 'Quoted FOB price per unit. Represents the cost of goods loaded onto the shipping vessel at the port of origin, excluding freight and insurance.',
    `freight_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated freight cost per unit from port of loading to destination. May be provided by vendor or calculated internally.',
    `hs_code` STRING COMMENT 'Harmonized System tariff classification code for the quoted product. Used to determine applicable duties, taxes, and trade compliance requirements.',
    `incoterm` STRING COMMENT 'International Commercial Terms (Incoterms) rule defining the division of costs, risks, and responsibilities between buyer and seller for shipment. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `ldp_estimate` DECIMAL(18,2) COMMENT 'Estimated total landed cost per unit including FOB price, freight, insurance, duties, and taxes. Provides a complete cost view for comparison.',
    `lead_time_days` STRING COMMENT 'Number of calendar days from purchase order confirmation to shipment readiness. Critical for Time and Action (TNA) calendar planning.',
    `material_cost` DECIMAL(18,2) COMMENT 'Quoted cost of raw materials (fabric, trims, accessories) per unit. May be itemized separately from CMT in some quotes.',
    `moq` STRING COMMENT 'Minimum order quantity required by the vendor to honor the quoted price and terms. Orders below this threshold may not be accepted or may incur surcharges.',
    `notes` STRING COMMENT 'Additional notes, comments, or clarifications related to this quote. Captures context for sourcing decisions.',
    `payment_terms` STRING COMMENT 'Vendor-specified payment terms and conditions (e.g., Net 30, 50% deposit + 50% on shipment, Letter of Credit). Defines when and how payment is due.',
    `port_of_loading` STRING COMMENT 'Port or location where goods will be loaded for shipment. Relevant for FOB and other origin-based Incoterms.',
    `quality_certification` STRING COMMENT 'Quality certifications or standards the vendor commits to for this quote (e.g., OEKO-TEX Standard 100, GOTS, ISO 9001, WRAP). Ensures compliance with quality and ethical standards.',
    `quote_date` DATE COMMENT 'Date the vendor submitted or issued this quote.',
    `quote_number` STRING COMMENT 'Vendor-assigned unique identifier for this quotation. Used for external reference and vendor communication.',
    `quote_status` STRING COMMENT 'Current lifecycle status of the vendor quote in the sourcing workflow. [ENUM-REF-CANDIDATE: draft|submitted|under_review|accepted|rejected|expired|withdrawn|superseded — 8 candidates stripped; promote to reference product]',
    `quote_version` STRING COMMENT 'Version number of this quote. Increments when vendor revises or resubmits the quote in response to negotiation or clarification.',
    `rejection_reason` STRING COMMENT 'Reason for rejecting this quote. Provides feedback to vendor and supports future sourcing decisions.',
    `sample_cost` DECIMAL(18,2) COMMENT 'Cost per sample unit for pre-production (PP) samples. Samples are typically required for approval before bulk production.',
    `sample_lead_time_days` STRING COMMENT 'Number of days required to produce and deliver pre-production samples for approval. Critical for Sample Management System (SMS) workflow.',
    `sustainability_certification` STRING COMMENT 'Sustainability or environmental certifications applicable to the quoted materials or production process (e.g., Better Cotton Initiative, Global Organic Textile Standard).',
    `tooling_cost` DECIMAL(18,2) COMMENT 'One-time cost for tooling, molds, dies, or setup required for production. May be amortized across order quantity or charged separately.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor quote record was last modified. Audit trail for record changes.',
    `valid_from_date` DATE COMMENT 'Start date of the quote validity period. Quote pricing and terms are effective from this date.',
    `valid_until_date` DATE COMMENT 'Expiration date of the quote. After this date, the vendor is not obligated to honor the quoted terms.',
    CONSTRAINT pk_vendor_quote PRIMARY KEY(`vendor_quote_id`)
) COMMENT 'Vendor response to an RFQ capturing the quoted FOB price, CMT rate, MOQ, lead time, payment terms, validity period, and any counter-terms. Tracks quote version, currency, landed duty paid (LDP) estimate, and acceptance status. Enables cost negotiation, benchmark comparison, and vendor selection decisions.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` (
    `vendor_cost_quote_id` BIGINT COMMENT 'Unique identifier for the vendor cost quote record. Primary key for the vendor cost quote entity.',
    `colorway_id` BIGINT COMMENT 'Foreign key linking to product.colorway. Business justification: Cost quotes vary by colorway due to dye costs, material availability, and complexity. Critical for accurate colorway-level costing and margin analysis. Sourcing teams price by colorway for profitabili',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost quotes require cost center assignment for detailed costing analysis, budget validation, and procurement financial planning - supports target cost vs. actual cost variance reporting in apparel sou',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Cost quotes are created by sourcing coordinators who compile vendor pricing. Tracks quote originator for audit trail. Complements existing approved_by field to show full quote lifecycle ownership in c',
    `rfq_id` BIGINT COMMENT 'Foreign key linking to sourcing.rfq. Business justification: Vendor cost quotes are typically generated in response to RFQs. This FK establishes the parent-child relationship between the RFQ solicitation and the detailed cost breakdown response. No bidirectiona',
    `sketch_id` BIGINT COMMENT 'Foreign key linking to design.design_sketch. Business justification: Vendor cost quotes are validated against design sketches to ensure costing aligns with design specifications before style finalization. Critical for design-costing validation, target margin analysis, ',
    `style_id` BIGINT COMMENT 'Reference to the style or product design for which this cost quote applies. Links to the product master in PLM.',
    `supplier_esg_assessment_id` BIGINT COMMENT 'Foreign key linking to sustainability.supplier_esg_assessment. Business justification: Cost quotes must be evaluated alongside ESG performance for holistic sourcing decisions. Enables total cost of ownership analysis including sustainability risk. Required for responsible sourcing appro',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or manufacturer providing this cost quote. Links to the vendor master data.',
    `vendor_quote_id` BIGINT COMMENT 'Foreign key linking to sourcing.vendor_quote. Business justification: A vendor_cost_quote provides the detailed cost breakdown that supports a vendor_quote (the formal quote response). This FK links the detailed costing to the summary quote. No bidirectional conflict ex',
    `agent_commission` DECIMAL(18,2) COMMENT 'Commission paid to sourcing agent or buying office per unit. Typically a percentage of FOB cost, expressed as absolute amount per unit.',
    `approved_date` DATE COMMENT 'The date when this cost quote was approved for production. Marks transition from negotiation to execution phase.',
    `cmt_cost` DECIMAL(18,2) COMMENT 'The manufacturing labor cost for cutting, making, and trimming the garment. Core component of production cost in CMT sourcing model.',
    `cogs_estimate` DECIMAL(18,2) COMMENT 'Estimated COGS per unit including all landed costs and internal allocation of overhead. Used for financial planning and margin calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost quote record was first created in the system. Part of audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this quote (e.g., USD, EUR, CNY). Critical for multi-currency sourcing operations.. Valid values are `^[A-Z]{3}$`',
    `duty_cost` DECIMAL(18,2) COMMENT 'Estimated import duty and tariff cost per unit based on HS code classification and country of origin. Critical for landed cost calculation.',
    `embellishment_cost` DECIMAL(18,2) COMMENT 'Additional cost for embellishments such as embroidery, printing, appliqué, or special finishes. Optional cost component for decorated styles.',
    `fabric_cost` DECIMAL(18,2) COMMENT 'The cost of fabric materials per unit for this style. Major component of total COGS. Sourced from fabric mills or material suppliers.',
    `fob_cost` DECIMAL(18,2) COMMENT 'Total Free On Board cost per unit at the port of origin. Sum of fabric, trim, CMT, embellishment, packaging, testing, and agent commission. Key metric for sourcing decisions.',
    `freight_cost` DECIMAL(18,2) COMMENT 'Estimated freight and logistics cost per unit from factory to destination port or warehouse. May vary by incoterm (FOB, CIF, DDP).',
    `incoterm` STRING COMMENT 'The international commercial term defining the division of costs and risks between buyer and seller. Determines which costs are included in the quoted price. [ENUM-REF-CANDIDATE: EXW|FOB|CIF|CFR|DDP|DDU|FCA|CPT|CIP|DAP|DPU — 11 candidates stripped; promote to reference product]',
    `ldp_cost` DECIMAL(18,2) COMMENT 'Total landed duty paid cost per unit at destination warehouse. Includes FOB cost plus freight, duty, and other landed charges. Used for COGS and margin analysis.',
    `lead_time_days` STRING COMMENT 'Production lead time in days from PO confirmation to ex-factory date. Critical input for TNA calendar and delivery planning.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost quote record was last modified. Tracks changes through negotiation and revision cycles.',
    `moq` STRING COMMENT 'The minimum order quantity required by the vendor for this style at the quoted price. Key constraint for buy plan and allocation decisions.',
    `moq_unit` STRING COMMENT 'The unit of measure for the MOQ (e.g., pieces, dozens, cartons). Clarifies how MOQ is counted.. Valid values are `pieces|units|dozens|cartons`',
    `notes` STRING COMMENT 'Free-text notes capturing negotiation details, special conditions, quality requirements, or other contextual information relevant to this cost quote.',
    `other_charges` DECIMAL(18,2) COMMENT 'Miscellaneous charges not captured in other cost components (e.g., bank fees, inspection fees, special handling). Catch-all for additional costs.',
    `packaging_cost` DECIMAL(18,2) COMMENT 'Cost of packaging materials per unit including polybags, boxes, tissue paper, and branded packaging. Part of total unit cost.',
    `payment_terms` STRING COMMENT 'Negotiated payment terms for this quote (e.g., 30% deposit, 70% on shipment; LC at sight; Net 60). Impacts cash flow and working capital planning.',
    `quote_date` DATE COMMENT 'The date when the vendor submitted or the sourcing team created this cost quote. Key timestamp for TNA calendar tracking.',
    `quote_number` STRING COMMENT 'Business identifier for the cost quote, typically generated by the PLM system or sourcing team. Used for external communication with vendors and internal tracking.. Valid values are `^[A-Z0-9]{8,20}$`',
    `quote_status` STRING COMMENT 'Current lifecycle status of the cost quote in the sourcing workflow. Tracks progression from initial draft through approval or rejection. [ENUM-REF-CANDIDATE: draft|submitted|under_review|negotiating|approved|rejected|superseded — 7 candidates stripped; promote to reference product]',
    `quote_version` STRING COMMENT 'Version number of the cost quote. Increments with each revision as negotiations progress or specifications change. Supports cost history tracking.',
    `sample_cost` DECIMAL(18,2) COMMENT 'Cost charged by vendor for producing pre-production samples (PP samples, SMS samples). May be deducted from bulk order or charged separately.',
    `season_code` STRING COMMENT 'The fashion season for which this cost quote applies (e.g., SS24 for Spring/Summer 2024, FW24 for Fall/Winter 2024). Critical for collection planning and merchandising.. Valid values are `^[A-Z]{2}[0-9]{2}$`',
    `target_imu_percent` DECIMAL(18,2) COMMENT 'Target initial markup percentage for this style based on merchandising strategy. Used to validate if the quoted cost supports desired retail price and margin.',
    `target_retail_price` DECIMAL(18,2) COMMENT 'Target retail price for this style. Used with cost quote to calculate achievable margin and validate pricing strategy.',
    `testing_certification_cost` DECIMAL(18,2) COMMENT 'Cost per unit for product testing and certifications (OEKO-TEX, GOTS, CPSC compliance testing, etc.). Amortized across production quantity.',
    `trim_cost` DECIMAL(18,2) COMMENT 'The cost of trims and accessories (buttons, zippers, labels, hangtags, etc.) per unit. Part of the BOM cost breakdown.',
    `valid_from_date` DATE COMMENT 'The date from which this cost quote becomes effective. Used for time-bound pricing agreements.',
    `valid_to_date` DATE COMMENT 'The date until which this cost quote remains valid. After this date, a new quote may be required. Nullable for open-ended quotes.',
    CONSTRAINT pk_vendor_cost_quote PRIMARY KEY(`vendor_cost_quote_id`)
) COMMENT 'Detailed cost breakdown record for a style or material capturing CMT cost components (cut, make, trim), fabric cost, accessories cost, freight, duty, agent commission, and total FOB/LDP cost. Tracks IMU target, COGS estimate, season, cost version, and approval status. Authoritative costing record for pre-production financial planning and margin analysis.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` (
    `sourcing_purchase_order_id` BIGINT COMMENT 'Primary key for purchase_order',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_agreement. Business justification: Sourcing POs can be issued under framework sourcing agreements. This FK links tactical purchase orders to the strategic agreements that govern pricing, terms, and commitments. No bidirectional conflic',
    `vendor_quote_id` BIGINT COMMENT 'Foreign key linking to sourcing.vendor_quote. Business justification: A sourcing PO is issued based on an accepted vendor quote. This FK links the PO to the specific quote that was awarded, enabling traceability from quote to order. No bidirectional conflict exists.',
    `compliance_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_certification. Business justification: Purchase orders require vendor certifications (GOTS, OEKO-TEX, SA8000, WRAP) as approval gates. Procurement teams verify certification validity before PO release. Critical for ethical sourcing and bra',
    `concept_id` BIGINT COMMENT 'Foreign key linking to design.concept. Business justification: Purchase orders link to originating design concepts for end-to-end traceability from concept through production. Enables concept performance analysis, concept-to-delivery cycle time reporting, and des',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Sourcing POs must be allocated to cost centers for procurement expense tracking, budget management, and departmental cost reporting - standard financial control in apparel sourcing operations.',
    `employee_id` BIGINT COMMENT 'Reference to the third-party sourcing agent or buying office facilitating this purchase order, if applicable.',
    `production_factory_id` BIGINT COMMENT 'Reference to the specific factory or manufacturing facility where production will occur.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: POs must be assigned to profit centers (brand/channel) for landed cost profitability analysis, margin reporting, and P&L attribution - critical for apparel brand financial management.',
    `rfq_id` BIGINT COMMENT 'Foreign key linking to sourcing.rfq. Business justification: Sourcing purchase orders are often the result of awarded RFQs. This FK provides traceability from the PO back to the originating RFQ solicitation. No bidirectional conflict exists. This is a critical ',
    `season_id` BIGINT COMMENT 'Reference to the fashion season or collection this purchase order supports (e.g., Spring/Summer 2024, Fall/Winter 2024).',
    `style_id` BIGINT COMMENT 'Foreign key linking to product.style. Business justification: Sourcing POs are issued for specific styles. Fundamental for order tracking, production planning, and style-level cost reconciliation. Every apparel PO must link to style master for operational visibi',
    `supplier_esg_assessment_id` BIGINT COMMENT 'Foreign key linking to sustainability.supplier_esg_assessment. Business justification: Purchase orders reference latest supplier ESG assessment to ensure compliance with sustainability standards at time of order placement. Required for audit trails and demonstrating due diligence in res',
    `tertiary_sourcing_approved_by_employee_id` BIGINT COMMENT 'Reference to the employee who approved this purchase order for submission to the vendor.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or mill receiving this purchase order.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: Sourcing purchase orders directly trigger production work orders in apparel manufacturing. This link enables production planning, order fulfillment tracking, and variance analysis between sourced comm',
    `actual_delivery_date` DATE COMMENT 'Actual date when goods were delivered and received. Used for On Time In Full (OTIF) performance tracking.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this purchase order was approved for submission to the vendor.',
    `confirmed_delivery_date` DATE COMMENT 'Delivery date confirmed by the vendor. May differ from requested date due to capacity or lead time constraints.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code where goods are manufactured. Required for customs clearance and trade compliance (e.g., CHN for China, VNM for Vietnam, BGD for Bangladesh).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this purchase order record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this purchase order (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `destination_port_code` STRING COMMENT 'UN/LOCODE 5-character code for the destination port where goods will be received (e.g., USNYC for New York, DEHAM for Hamburg).. Valid values are `^[A-Z]{5}$`',
    `duty_amount` DECIMAL(18,2) COMMENT 'Total customs duty amount for imported goods in the specified currency. Relevant for international sourcing.',
    `fob_port_code` STRING COMMENT 'UN/LOCODE 5-character code for the port where goods are loaded and ownership transfers from vendor to buyer (e.g., CNSHA for Shanghai, VNSGN for Ho Chi Minh City).. Valid values are `^[A-Z]{5}$`',
    `freight_cost` DECIMAL(18,2) COMMENT 'Transportation cost for shipping goods from vendor to destination in the specified currency.',
    `hs_code` STRING COMMENT 'International customs classification code (6-10 digits) used for tariff determination and trade statistics. Required for cross-border shipments.. Valid values are `^[0-9]{6,10}$`',
    `incoterms` STRING COMMENT 'Standard trade terms defining responsibilities for shipping, insurance, and risk transfer between buyer and vendor (e.g., FOB, CIF, DDP). Follows ICC Incoterms 2020. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `landed_cost` DECIMAL(18,2) COMMENT 'Total landed cost including product value, freight, duties, taxes, and all other costs to deliver goods to final destination. Used for true Cost of Goods Sold (COGS) calculation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this purchase order record was last modified in the system.',
    `moq_quantity` STRING COMMENT 'Minimum order quantity negotiated with the vendor. Vendor will not accept orders below this threshold.',
    `otif_flag` BOOLEAN COMMENT 'Boolean indicator of whether the purchase order was delivered on time and in full. True if actual delivery date is within ship window and received quantity matches ordered quantity.',
    `payment_method` STRING COMMENT 'Instrument used for payment: letter_of_credit (LC - bank-backed), telegraphic_transfer (TT - international wire), wire_transfer (domestic), check, ach (automated clearing house), trade_credit (open account).. Valid values are `letter_of_credit|telegraphic_transfer|wire_transfer|check|ach|trade_credit`',
    `payment_terms` STRING COMMENT 'Agreed payment terms between buyer and vendor: net_30/60/90 (payment due in days), advance_payment (prepayment required), letter_of_credit (LC - bank guarantee), telegraphic_transfer (TT - wire transfer), consignment (pay on sale). [ENUM-REF-CANDIDATE: net_30|net_60|net_90|advance_payment|letter_of_credit|telegraphic_transfer|consignment — 7 candidates stripped; promote to reference product]',
    `po_date` DATE COMMENT 'Date when the purchase order was officially issued to the vendor. Principal business event timestamp for this transaction.',
    `po_number` STRING COMMENT 'Externally-known business identifier for the purchase order. Used for vendor communication, tracking, and reference across systems.. Valid values are `^PO[0-9]{8,12}$`',
    `po_status` STRING COMMENT 'Current lifecycle status of the purchase order: draft (being prepared), submitted (sent to vendor), acknowledged (vendor confirmed), in_production (manufacturing underway), shipped (goods dispatched), received (goods arrived at warehouse), closed (completed), cancelled (voided). [ENUM-REF-CANDIDATE: draft|submitted|acknowledged|in_production|shipped|received|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `po_type` STRING COMMENT 'Classification of the purchase order by procurement category: finished goods (CMT/FOB garments), fabric (textiles from mills), trim (buttons, zippers, labels), packaging (polybags, hangtags), or sample (pre-production samples).. Valid values are `finished_goods|fabric|trim|packaging|sample`',
    `product_category` STRING COMMENT 'High-level product category for items on this purchase order: apparel (clothing), footwear (shoes), accessories (bags, belts), fabric (textiles), trim (notions), packaging (polybags, boxes).. Valid values are `apparel|footwear|accessories|fabric|trim|packaging`',
    `quality_inspection_required` BOOLEAN COMMENT 'Boolean indicator of whether goods from this purchase order require quality inspection before acceptance. True for first-time vendors or high-risk categories.',
    `requested_delivery_date` DATE COMMENT 'Target date by which the buyer requests delivery of goods. Used for Time and Action (TNA) calendar planning.',
    `sample_approval_status` STRING COMMENT 'Status of pre-production (PP) sample approval for this purchase order: not_required (bulk order without sample), pending (awaiting review), approved (sample accepted), rejected (sample failed), conditional (approved with modifications).. Valid values are `not_required|pending|approved|rejected|conditional`',
    `ship_window_end_date` DATE COMMENT 'Latest acceptable date for the vendor to ship goods. Defines the end of the delivery window.',
    `ship_window_start_date` DATE COMMENT 'Earliest acceptable date for the vendor to ship goods. Defines the beginning of the delivery window.',
    `special_instructions` STRING COMMENT 'Free-text field for any special handling, packaging, labeling, or shipping instructions for the vendor.',
    `sustainability_certification` STRING COMMENT 'Sustainability or ethical certification applicable to this purchase order: GOTS (Global Organic Textile Standard), OEKO_TEX (textile safety), BCI (Better Cotton Initiative), FLA (Fair Labor Association), WRAP (Worldwide Responsible Accredited Production), or none.. Valid values are `GOTS|OEKO_TEX|BCI|FLA|WRAP|none`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to this purchase order in the specified currency.',
    `tna_milestone_status` STRING COMMENT 'Overall status of Time and Action calendar milestones for this purchase order: on_track (meeting deadlines), at_risk (potential delay), delayed (missed milestone), completed (all milestones met).. Valid values are `on_track|at_risk|delayed|completed`',
    `total_order_value` DECIMAL(18,2) COMMENT 'Total monetary value of the purchase order in the specified currency, including all line items before taxes and duties.',
    `total_quantity` STRING COMMENT 'Total quantity of units ordered across all line items on this purchase order.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for quantities on this purchase order: pieces (garments), yards/meters (fabric), kilograms/pounds (weight), dozens/gross (count), rolls (fabric rolls), cartons (packaging). [ENUM-REF-CANDIDATE: pieces|yards|meters|kilograms|pounds|dozens|gross|rolls|cartons — 9 candidates stripped; promote to reference product]',
    CONSTRAINT pk_sourcing_purchase_order PRIMARY KEY(`sourcing_purchase_order_id`)
) COMMENT 'Approved purchase order issued to a vendor or mill for finished goods, fabric, or trim procurement. Captures PO number, vendor, factory, season, delivery window, FOB port, incoterms, currency, total order value, payment terms (LC, TT), and OTIF tracking flags. The commercial procurement instrument for all sourcing commitments — distinct from production work orders.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` (
    `sourcing_purchase_order_line_id` BIGINT COMMENT 'Primary key for purchase_order_line',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Line-level cost center allocation enables granular expense tracking by SKU/style, supporting detailed procurement cost analysis and variance reporting required in apparel financial operations.',
    `material_id` BIGINT COMMENT 'Reference to the raw material, fabric, or trim component being procured. Used when ordering materials from mills and suppliers.',
    `employee_id` BIGINT COMMENT 'Reference to the user who created this purchase order line. Supports audit trail and accountability.',
    `product_safety_test_id` BIGINT COMMENT 'Foreign key linking to compliance.product_safety_test. Business justification: Order lines must link to passing safety test results for the specific SKU/material before shipment authorization. QA teams verify test completion and pass status as a release gate for production order',
    `production_factory_id` BIGINT COMMENT 'Reference to the specific manufacturing facility or mill producing this line item. Critical for CMT and OEM sourcing models.',
    `production_tna_milestone_id` BIGINT COMMENT 'Reference to the TNA calendar milestone associated with this line item. Links sourcing orders to the master production timeline.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Line-level profit center assignment enables SKU-level margin analysis, supporting detailed brand/channel profitability reporting and IMU tracking critical to apparel merchandising financial planning.',
    `rfq_line_id` BIGINT COMMENT 'Foreign key linking to sourcing.rfq_line. Business justification: PO line items can trace back to the specific RFQ line items that initiated them. This FK provides line-level traceability from RFQ solicitation through to purchase order, critical for sourcing audit a',
    `sku_id` BIGINT COMMENT 'Reference to the finished product SKU being ordered on this line. Used when ordering finished goods from manufacturers.',
    `sourcing_purchase_order_id` BIGINT COMMENT 'Reference to the parent sourcing purchase order header. Links this line item to its parent order document.',
    `sustainable_material_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainable_material. Business justification: PO lines specify sustainable materials being procured for production. Direct link between sourcing execution and sustainable material usage. Essential for tracking sustainable material adoption rates ',
    `vendor_cost_quote_id` BIGINT COMMENT 'Foreign key linking to sourcing.vendor_cost_quote. Business justification: PO line pricing is often based on vendor cost quotes. This FK links the PO line to the cost quote that informed its pricing, enabling cost variance analysis and audit. No bidirectional conflict exists',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor fulfilling this line item. May differ from the header-level supplier for multi-vendor orders.',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the warehouse or distribution center where this line item will be received and stored.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: Line-level linkage between sourcing PO lines and production work orders enables SKU-specific production tracking, quantity reconciliation, and cost variance analysis. Critical for item-level traceabil',
    `actual_receipt_date` DATE COMMENT 'The actual date this line item was received and recorded in the warehouse management system. Used for goods receipt reconciliation.',
    `actual_ship_date` DATE COMMENT 'The actual date the supplier shipped this line item. Used for OTIF performance measurement and logistics tracking.',
    `color_code` STRING COMMENT 'The specific color variant code for the material or SKU being ordered. Critical for apparel differentiation.',
    `confirmed_ship_date` DATE COMMENT 'The date confirmed by the supplier for shipping this line item. Critical for OTIF tracking and supply chain planning.',
    `costing_method` STRING COMMENT 'The costing or pricing method used for this line. CMT (Cut Make Trim), FOB (Free on Board), CIF (Cost Insurance Freight), EXW (Ex Works), DDP (Delivered Duty Paid), FCA (Free Carrier).. Valid values are `CMT|FOB|CIF|EXW|DDP|FCA`',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating where this item is manufactured or sourced. Required for customs, compliance, and GSP eligibility.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this purchase order line record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit cost and line total (e.g., USD, EUR, CNY, INR).. Valid values are `^[A-Z]{3}$`',
    `delivery_status` STRING COMMENT 'Delivery performance status for this line item. Used for OTIF (On Time In Full) tracking and supplier performance measurement.. Valid values are `pending|on_time|delayed|early|delivered|partial`',
    `expected_receipt_date` DATE COMMENT 'The expected date for receiving this line item at the destination warehouse or facility. Used for inbound planning.',
    `hs_code` STRING COMMENT 'The international customs classification code for this material or product. Required for cross-border shipments and duty calculation.',
    `lead_time_days` STRING COMMENT 'The negotiated lead time in days from order confirmation to delivery for this line item. Critical for supply chain planning.',
    `line_notes` STRING COMMENT 'Free-text notes or special instructions specific to this line item. Used for communicating special requirements to suppliers.',
    `line_number` STRING COMMENT 'Sequential line number within the purchase order. Determines the ordering and position of this line item in the PO document.',
    `line_status` STRING COMMENT 'Current lifecycle status of this purchase order line item. Tracks progression from order placement through receipt and closure. [ENUM-REF-CANDIDATE: draft|confirmed|in_production|shipped|partially_received|fully_received|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `line_total_cost` DECIMAL(18,2) COMMENT 'The total cost for this line item, calculated as ordered quantity multiplied by unit cost. Represents the extended line value.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this purchase order line record was last modified. Audit trail for tracking changes to order details.',
    `moq_quantity` DECIMAL(18,2) COMMENT 'The minimum order quantity negotiated with the supplier for this line item. Critical for procurement planning and vendor negotiations.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'The quantity of the item ordered on this line. Represents the total units or volume requested from the supplier.',
    `outstanding_quantity` DECIMAL(18,2) COMMENT 'The remaining quantity yet to be received for this line item. Calculated as ordered quantity minus received quantity.',
    `payment_terms` STRING COMMENT 'The payment terms negotiated for this line item (e.g., Net 30, Net 60, LC at sight, 50% advance). May override header-level terms.',
    `pp_approval_status` STRING COMMENT 'The approval status for pre-production samples associated with this line item. Critical gate in the TNA calendar before bulk production.. Valid values are `pending|approved|rejected|conditional|not_applicable`',
    `quality_status` STRING COMMENT 'Quality inspection status for the received goods on this line. Tracks quality control outcomes and approval workflows.. Valid values are `pending_inspection|approved|rejected|conditional_approval|quarantine`',
    `received_quantity` DECIMAL(18,2) COMMENT 'The actual quantity received for this line item. May differ from ordered quantity due to shortages, overages, or partial deliveries.',
    `requested_delivery_date` DATE COMMENT 'The date by which the buyer requests delivery of this line item. Used for initial planning and TNA calendar alignment.',
    `sample_type` STRING COMMENT 'The type of sample or production run this line represents. Values: proto (prototype), fit (fit sample), pp (pre-production), sms (sample management system), production, bulk. Critical for SMS workflows.. Valid values are `proto|fit|pp|sms|production|bulk`',
    `size_code` STRING COMMENT 'The size specification for the SKU being ordered (e.g., XS, S, M, L, XL, or numeric sizing).',
    `style_code` STRING COMMENT 'The style or design code associated with this line item. Links to the product design and collection in PLM systems.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The negotiated cost per unit for this line item. Represents the price agreed with the supplier for one unit of the material or SKU.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the ordered quantity. Common values: EA (each), PC (piece), YD (yard), MTR (meter), KG (kilogram), LB (pound), ROLL, BOLT, PAIR, SET, DOZ (dozen). [ENUM-REF-CANDIDATE: EA|PC|YD|MTR|KG|LB|ROLL|BOLT|PAIR|SET|DOZ — 11 candidates stripped; promote to reference product]',
    CONSTRAINT pk_sourcing_purchase_order_line PRIMARY KEY(`sourcing_purchase_order_line_id`)
) COMMENT 'Individual line item on a sourcing purchase order representing a specific SKU, fabric roll, or trim component. Captures style/material reference, ordered quantity, unit cost, UOM, confirmed ship date, and line-level delivery status. Enables granular OTIF tracking and goods receipt reconciliation.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` (
    `sourcing_tna_calendar_id` BIGINT COMMENT 'Unique identifier for the Time and Action calendar record. Primary key for the sourcing T&A calendar entity.',
    `colorway_id` BIGINT COMMENT 'Foreign key linking to product.colorway. Business justification: TNA calendars track colorway-specific milestones like lab dip approval and strike-off submission. Critical for color approval workflow and on-time delivery. Sourcing teams manage timelines by colorway',
    `concept_id` BIGINT COMMENT 'Foreign key linking to design.concept. Business justification: TNA calendars track design concept progression through sourcing and production milestones. Enables concept-level timeline management, design-to-market lead time tracking, and concept delivery performa',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: TNA calendars require cost center assignment for project-based cost tracking, timeline delay cost analysis, and production planning expense management - supports apparel operations financial accountab',
    `distribution_center_id` BIGINT COMMENT 'Foreign key linking to logistics.distribution_center. Business justification: TNA calendars specify target in-DC dates for specific distribution centers to support allocation planning, replenishment scheduling, and coordinating inbound receipts with retail launch dates in appar',
    `higg_index_assessment_id` BIGINT COMMENT 'Foreign key linking to sustainability.higg_index_assessment. Business justification: TNA calendars include factory Higg Index assessment milestones for sustainability compliance verification. Ensures factories complete required assessments before production. Critical for brand sustain',
    `employee_id` BIGINT COMMENT 'Reference to the sourcing planner or product developer responsible for managing this T&A calendar.',
    `production_factory_id` BIGINT COMMENT 'Reference to the specific factory or manufacturing facility where production will occur. May differ from vendor headquarters.',
    `rfq_id` BIGINT COMMENT 'Foreign key linking to sourcing.rfq. Business justification: T&A calendars can be created to track RFQ events and milestones. The existing rfq_reference (STRING) should be replaced with a proper FK to rfq. This enables relational integrity and proper joins. No ',
    `season_id` BIGINT COMMENT 'Reference to the season or collection this T&A calendar is associated with (e.g., Spring/Summer 2024, Fall/Winter 2024).',
    `sourcing_purchase_order_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_purchase_order. Business justification: T&A calendars track milestones for sourcing purchase orders. The existing po_number (STRING) should be replaced with a proper FK to sourcing_purchase_order. This enables relational integrity and prope',
    `style_id` BIGINT COMMENT 'Reference to the style or product being developed through this T&A calendar. Links to the product master in PLM.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier responsible for manufacturing this style. Primary sourcing partner.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: Sourcing TNA calendars track end-to-end timelines including production milestones. Linking to work_order enables actual vs. planned production timeline analysis, delay tracking, and critical path mana',
    `bulk_production_start_actual_date` DATE COMMENT 'Actual date when bulk production started. Null if milestone not yet achieved.',
    `bulk_production_start_planned_date` DATE COMMENT 'Planned date for bulk production to commence at the factory. Follows PP approval.',
    `cmt_cost` DECIMAL(18,2) COMMENT 'Cost per unit for cut, make, and trim services. Excludes material costs. Negotiated with vendor.',
    `compliance_certification_required` BOOLEAN COMMENT 'Indicates whether this style requires compliance certification (e.g., OEKO-TEX, GOTS, WRAP) before shipment.',
    `cost_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for CMT and FOB costs (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this T&A calendar record was first created in the system. Audit trail for record lifecycle.',
    `critical_path_flag` BOOLEAN COMMENT 'Indicates whether this T&A calendar is on the critical path for the season launch. True if any delay impacts go-to-market date.',
    `delay_days` STRING COMMENT 'Total number of days the T&A calendar is delayed relative to planned milestones. Calculated field for reporting.',
    `delay_reason` STRING COMMENT 'Free-text explanation of the primary cause of delay if T&A is at risk or delayed. Used for root cause analysis.',
    `ex_factory_actual_date` DATE COMMENT 'Actual date when goods left the factory. Null if milestone not yet achieved.',
    `ex_factory_planned_date` DATE COMMENT 'Planned date for goods to leave the factory. Critical milestone for shipment and logistics planning.',
    `fabric_approval_actual_date` DATE COMMENT 'Actual date when fabric approval was completed. Null if milestone not yet achieved.',
    `fabric_approval_planned_date` DATE COMMENT 'Planned date for fabric approval milestone. Critical pre-production milestone for material sign-off.',
    `fob_cost` DECIMAL(18,2) COMMENT 'Total cost per unit including materials and CMT, delivered to port of shipment. Basis for landed cost calculation.',
    `in_dc_actual_date` DATE COMMENT 'Actual date when goods arrived at the distribution center. Null if milestone not yet achieved.',
    `in_dc_planned_date` DATE COMMENT 'Planned date for goods to arrive at the distribution center. End of pre-production T&A scope.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this T&A calendar record was last updated. Audit trail for change tracking.',
    `lead_time_days` STRING COMMENT 'Total lead time in days from PP approval to ex-factory date. Used for production planning and scheduling.',
    `moq_quantity` STRING COMMENT 'Minimum order quantity negotiated with the vendor for this style. Drives production planning and costing.',
    `notes` STRING COMMENT 'Free-text notes and comments related to this T&A calendar. Used for collaboration and issue tracking.',
    `planned_order_quantity` STRING COMMENT 'Total quantity planned for this production run. May exceed MOQ based on demand forecast.',
    `pp_approval_actual_date` DATE COMMENT 'Actual date when pre-production sample was approved. Null if milestone not yet achieved.',
    `pp_approval_planned_date` DATE COMMENT 'Planned date for pre-production sample approval. Gate for bulk production authorization.',
    `pp_sample_actual_date` DATE COMMENT 'Actual date when pre-production sample was submitted. Null if milestone not yet achieved.',
    `pp_sample_planned_date` DATE COMMENT 'Planned date for pre-production sample submission. Critical milestone for final fit and construction approval before bulk production.',
    `tech_pack_version` STRING COMMENT 'Version number of the technical specification package (tech pack) used for this production. Ensures vendor has correct specs.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}$`',
    `tna_code` STRING COMMENT 'Business identifier for the Time and Action calendar. Externally-known unique code used across PLM and sourcing systems.. Valid values are `^TNA-[A-Z0-9]{6,12}$`',
    `tna_status` STRING COMMENT 'Current lifecycle status of the T&A calendar. Indicates overall health and progress of the sourcing timeline. [ENUM-REF-CANDIDATE: draft|active|on_track|at_risk|delayed|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `tna_type` STRING COMMENT 'Classification of the T&A calendar type. Indicates the phase of product lifecycle this calendar governs.. Valid values are `development|pre_production|bulk_production|sample_only`',
    `trim_approval_actual_date` DATE COMMENT 'Actual date when trim approval was completed. Null if milestone not yet achieved.',
    `trim_approval_planned_date` DATE COMMENT 'Planned date for trim and accessories approval milestone. Includes buttons, zippers, labels, and other components.',
    CONSTRAINT pk_sourcing_tna_calendar PRIMARY KEY(`sourcing_tna_calendar_id`)
) COMMENT 'Time and Action (T&A) calendar master record defining the milestone schedule for a sourcing event or style development cycle during pre-production. Captures season, style, vendor, factory, critical path milestones (fabric approval, PP sample, bulk production start, ex-factory date), planned vs. actual dates, and overall on-track status. SSOT for pre-production T&A management within sourcing scope (post-order production T&A owned by supply/production domains).';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` (
    `sourcing_tna_milestone_id` BIGINT COMMENT 'Unique identifier for the sourcing TNA milestone record. Primary key.',
    `colorway_id` BIGINT COMMENT 'Foreign key linking to product.colorway. Business justification: Individual milestones (lab dip approval, bulk fabric approval) are colorway-specific. Essential for detailed color approval tracking and delay root cause analysis. Standard practice in apparel sourcin',
    `milestone_id` BIGINT COMMENT 'Reference to another milestone that must be completed before this milestone can start. Null if no predecessor dependency exists. Enables critical path and dependency analysis.',
    `higg_index_assessment_id` BIGINT COMMENT 'Foreign key linking to sustainability.higg_index_assessment. Business justification: Specific TNA milestones track completion of Higg Index assessments as approval gates. Links production timeline to sustainability compliance verification. Enables tracking of assessment completion sta',
    `order_purchase_order_id` BIGINT COMMENT 'Reference to the purchase order this milestone is associated with. Enables tracking of milestones against specific procurement transactions.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: TNA milestones are owned by specific sourcing/production employees responsible for completion. Tracks accountability for critical path activities, delays, and escalations. Normalizes denormalized cont',
    `rfq_id` BIGINT COMMENT 'Foreign key linking to sourcing.rfq. Business justification: Milestones can track RFQ process stages (e.g., RFQ issue date, submission deadline, award date). This FK links milestones to RFQ events, enabling milestone-based RFQ tracking. No bidirectional conflic',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: TNA milestones (ex-factory, in-transit, in-DC) are tracked against actual shipment events for delay analysis, root cause identification, escalation triggers, and OTIF performance measurement in appare',
    `sourcing_purchase_order_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_purchase_order. Business justification: Milestones can be associated with specific sourcing POs. The existing FK purchase_order_id points to order.purchase_order (cross-domain, likely customer orders). This new FK establishes the in-domain ',
    `sourcing_tna_calendar_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_tna_calendar. Business justification: Milestones belong to T&A calendars. The existing FK tna_calendar_id points to product.tna_calendar (cross-domain). This new FK establishes the in-domain relationship to sourcing.sourcing_tna_calendar,',
    `style_id` BIGINT COMMENT 'Reference to the product style this milestone is tracking. Links milestone to the specific design being sourced.',
    `actual_date` DATE COMMENT 'Date when the milestone was actually completed. Null if milestone is not yet complete. Used for performance analysis and delay calculation.',
    `approval_date` DATE COMMENT 'Date when the approval decision was made. Null if approval is not required or not yet provided.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether formal approval is required to complete this milestone. True for approval milestones (e.g., fabric approval, PP approval), false for informational milestones.',
    `approval_status` STRING COMMENT 'Current approval decision status for milestones requiring approval. Tracks whether the deliverable has been approved, rejected, or conditionally approved.. Valid values are `pending|approved|rejected|conditional|not_required`',
    `approver_name` STRING COMMENT 'Name of the individual who provided the approval decision. Null if approval is not required or not yet provided.',
    `baseline_date` DATE COMMENT 'Original baseline date locked at TNA approval. Used as the reference point for measuring schedule variance and delays.',
    `buffer_days` STRING COMMENT 'Number of buffer days built into the schedule for this milestone to absorb potential delays. Part of risk mitigation planning.',
    `comments` STRING COMMENT 'Free-text notes and comments related to this milestone. Used for collaboration, issue tracking, and context capture.',
    `completion_status` STRING COMMENT 'Current state of the milestone in its lifecycle. Tracks progress from planning through completion.. Valid values are `not_started|in_progress|completed|delayed|cancelled|on_hold`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this milestone record was first created in the system. Audit trail for data lineage.',
    `delay_days` STRING COMMENT 'Number of days the milestone is delayed compared to the planned or revised date. Calculated as actual_date minus target_date. Negative if completed early, positive if late, null if not yet complete.',
    `delay_reason_code` STRING COMMENT 'Standardized code indicating the root cause of any delay (e.g., FABRIC_DELAY, APPROVAL_DELAY, SHIPPING_DELAY, VENDOR_CAPACITY, QUALITY_ISSUE, DESIGN_CHANGE). Null if no delay or not yet analyzed.',
    `delay_reason_description` STRING COMMENT 'Free-text explanation of the delay cause. Provides additional context beyond the standardized delay reason code.',
    `escalation_date` DATE COMMENT 'Date when the milestone was escalated to management. Null if no escalation has occurred.',
    `escalation_flag` BOOLEAN COMMENT 'Indicator that this milestone has been escalated to management due to delay risk or actual delay. True if escalated, false otherwise.',
    `is_critical_path` BOOLEAN COMMENT 'Flag indicating whether this milestone is on the critical path for the TNA calendar. True if any delay to this milestone will delay the overall production timeline.',
    `lead_time_days` STRING COMMENT 'Standard number of days allocated for completing this milestone activity. Used for TNA planning and scheduling.',
    `milestone_category` STRING COMMENT 'High-level classification of the milestone type. Groups milestones into functional categories for analysis and reporting.. Valid values are `material_development|sample_management|production_preparation|quality_approval|logistics|administrative`',
    `milestone_code` STRING COMMENT 'Standardized short code for the milestone type (e.g., FAB_APPR, PP_SMPL, BULK_CUT, TRIM_APPR, LAB_DIP, FIT_SMPL). Enables consistent reporting and system integration.',
    `milestone_name` STRING COMMENT 'Business name of the milestone event (e.g., Fabric Approval, Pre-Production (PP) Sample Submission, Bulk Cut Start, Trim Approval, Lab Dip Approval, Strike-Off Approval, Fit Sample Due, Size Set Approval, Top of Production).',
    `milestone_sequence` STRING COMMENT 'Sequential ordering of this milestone within the TNA calendar. Defines the critical path position (e.g., 1, 2, 3).',
    `milestone_type` STRING COMMENT 'Nature of the milestone event (approval decision, submission of deliverable, start of activity, completion of activity, shipment, receipt). Defines the action required.. Valid values are `approval|submission|start|completion|shipment|receipt`',
    `planned_date` DATE COMMENT 'Originally scheduled target date for this milestone to be completed. Baseline date set during TNA calendar creation.',
    `responsible_party_type` STRING COMMENT 'Classification of the entity responsible for completing this milestone (internal team, external vendor, factory, mill, agent, etc.). [ENUM-REF-CANDIDATE: internal|vendor|supplier|factory|mill|agent|freight_forwarder|lab|other — 9 candidates stripped; promote to reference product]',
    `revised_date` DATE COMMENT 'Updated target date if the milestone has been rescheduled due to delays or changes. Null if no revision has occurred.',
    `updated_by` STRING COMMENT 'User ID or name of the person who last modified this milestone record. Audit trail for change accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this milestone record was last modified. Audit trail for change tracking.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this milestone record. Audit trail for accountability.',
    CONSTRAINT pk_sourcing_tna_milestone PRIMARY KEY(`sourcing_tna_milestone_id`)
) COMMENT 'Individual milestone record within a T&A calendar capturing the milestone name (e.g., fabric approval, PP sample submission, bulk cut start), planned date, actual date, responsible party, delay reason code, and completion status. Enables critical path analysis and proactive delay escalation during the pre-production sourcing phase.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` (
    `sample_request_id` BIGINT COMMENT 'Unique identifier for the sample request record. Primary key for the sample request entity.',
    `colorway_id` BIGINT COMMENT 'Foreign key linking to product.colorway. Business justification: Samples are requested in specific colorways for color approval. Critical for colorway approval process and color accuracy evaluation. Standard practice to track sample requests by colorway in apparel ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Sample requests require cost center assignment for product development expense tracking, sample cost budgeting, and pre-production cost management - critical for apparel development financial control.',
    `environmental_impact_id` BIGINT COMMENT 'Foreign key linking to sustainability.environmental_impact. Business justification: Sample production has environmental impact that should be tracked for full product lifecycle assessment. Enables cradle-to-gate impact calculation including development phase. Supports comprehensive e',
    `pp_sample_id` BIGINT COMMENT 'Foreign key linking to production.pp_sample. Business justification: Sample requests from sourcing teams trigger PP sample production at factories. This link tracks sample request fulfillment, approval cycles, and revision rounds—critical for pre-production approval wo',
    `product_safety_test_id` BIGINT COMMENT 'Foreign key linking to compliance.product_safety_test. Business justification: Samples submitted for fit/construction evaluation must pass safety testing before production approval. Sample approval workflow includes test verification. Product development teams cannot advance to ',
    `production_factory_id` BIGINT COMMENT 'Identifier of the manufacturing factory or CMT (Cut Make Trim) partner responsible for producing the sample.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Sample requests are initiated by product development or design employees. Tracks who requested proto/PP/SMS samples for accountability in sample management, cost allocation, and development timeline t',
    `rfq_id` BIGINT COMMENT 'Foreign key linking to sourcing.rfq. Business justification: Sample requests can be initiated as part of the RFQ process (e.g., requesting samples from vendors responding to an RFQ). This FK links sample requests to the RFQ that triggered them. No bidirectional',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Sample shipments (proto, SMS, PP) are tracked through logistics for delivery confirmation, transit time monitoring, sample cost allocation, and ensuring timely arrival for evaluation in apparel develo',
    `sketch_id` BIGINT COMMENT 'Foreign key linking to design.design_sketch. Business justification: Sample requests are created directly from design sketches to validate design intent with physical samples. Core design-to-sampling workflow. Enables design-sample traceability, design validation track',
    `sourcing_purchase_order_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_purchase_order. Business justification: Sample requests can be associated with sourcing POs (e.g., PP samples for validating a production order). This FK links sample requests to the PO they validate. No bidirectional conflict exists.',
    `style_id` BIGINT COMMENT 'Foreign key linking to product.style. Business justification: Sample requests are for specific styles. Essential for sample tracking, approval workflow, and fit evaluation. Sourcing and design teams must link requests to style master for complete sample history.',
    `approval_date` DATE COMMENT 'Date when the final approval decision was made for the sample.',
    `approval_decision` STRING COMMENT 'Final approval decision for the sample: approved (sample meets all requirements and production can proceed), approved_with_comments (sample acceptable with minor notes for production), rejected (sample does not meet requirements and must be revised).. Valid values are `approved|approved_with_comments|rejected`',
    `bom_reference` STRING COMMENT 'Reference to the Bill of Materials (BOM) document that lists all materials, components, and quantities required to produce the sample.',
    `color_accuracy_evaluation` STRING COMMENT 'Assessment of how accurately the sample color matches the approved lab dip or Pantone standard, including any color correction instructions.',
    `construction_evaluation_comments` STRING COMMENT 'Evaluation comments on the construction quality of the sample, including seam quality, stitching, finishing, and adherence to construction specifications in the tech pack.',
    `corrective_actions_required` STRING COMMENT 'Detailed list of corrective actions that the factory must implement before submitting the next sample revision, including specific changes to fit, construction, materials, or measurements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sample request record was first created in the SMS (Sample Management System).',
    `evaluation_date` DATE COMMENT 'Date when the sample evaluation was completed and documented.',
    `factory_submission_date` DATE COMMENT 'Actual date when the factory submitted the sample for evaluation.',
    `fit_evaluation_comments` STRING COMMENT 'Detailed comments from the fit evaluation session describing how the sample fits on the fit model, including any adjustments needed to silhouette, ease, or proportions.',
    `material_fabric_reference` STRING COMMENT 'Reference code for the fabric used in the sample, linking to the material library in PLM system for fabric specifications and sourcing details.',
    `measurement_conformance_status` STRING COMMENT 'Indicates whether the sample measurements conform to the tech pack specifications: pass (all measurements within tolerance), fail (critical measurements out of spec), within_tolerance (acceptable variance), out_of_spec (unacceptable variance).. Valid values are `pass|fail|within_tolerance|out_of_spec`',
    `measurement_deviation_details` STRING COMMENT 'Specific details of any measurement deviations from tech pack specifications, including which measurements are out of tolerance and by how much.',
    `modified_by` STRING COMMENT 'Username or identifier of the person who last modified the sample request record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the sample request record was last modified, tracking the most recent update to any field.',
    `priority_level` STRING COMMENT 'Priority level assigned to the sample request based on business urgency and TNA calendar constraints: critical (immediate attention required), high (expedited processing), normal (standard timeline), low (flexible timeline).. Valid values are `critical|high|normal|low`',
    `recipient_location` STRING COMMENT 'Office or facility location where the sample should be delivered (e.g., headquarters, regional office, showroom).',
    `request_number` STRING COMMENT 'Business identifier for the sample request, externally visible and used for tracking and communication with factories and internal teams.. Valid values are `^SR-[0-9]{8}$`',
    `request_status` STRING COMMENT 'Current lifecycle status of the sample request: draft (being prepared), submitted (sent to factory), in_production (factory is making sample), shipped (sample in transit), received (sample arrived), under_evaluation (being evaluated), approved (evaluation complete and approved), rejected (evaluation complete and rejected), cancelled (request cancelled). [ENUM-REF-CANDIDATE: draft|submitted|in_production|shipped|received|under_evaluation|approved|rejected|cancelled — 9 candidates stripped; promote to reference product]',
    `requested_delivery_date` DATE COMMENT 'Target date by which the sample must be delivered to meet TNA (Time and Action) calendar milestones.',
    `revision_round` STRING COMMENT 'Sequential number indicating which revision iteration this sample represents (1 for first submission, 2 for first revision, etc.).',
    `sample_cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the sample cost (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `sample_cost_fob` DECIMAL(18,2) COMMENT 'Cost charged by the factory for producing the sample on a FOB (Free on Board) basis, used for budgeting and cost tracking.',
    `sample_type` STRING COMMENT 'Type of sample being requested: proto (prototype), salesman (sales sample), PP (pre-production), TOP (top of production), counter (counter sample), fit (fit sample).. Valid values are `proto|salesman|PP|TOP|counter|fit`',
    `season_code` STRING COMMENT 'Season identifier for which the sample is being developed (e.g., SS24 for Spring/Summer 2024, FW24 for Fall/Winter 2024, HO24 for Holiday 2024).. Valid values are `^(SS|FW|HO)[0-9]{2}$`',
    `shipping_method` STRING COMMENT 'Method used to ship the sample from factory to recipient location: air_express (urgent air shipment), air_standard (standard air freight), sea_freight (ocean shipping), courier (express courier service).. Valid values are `air_express|air_standard|sea_freight|courier`',
    `size` STRING COMMENT 'Size specification for the sample (e.g., S, M, L, XL, or numeric sizing depending on product category).',
    `special_instructions` STRING COMMENT 'Any special instructions or requirements for the sample production, including specific construction techniques, labeling requirements, or packaging instructions.',
    `tech_pack_version` STRING COMMENT 'Version number of the technical specification package (tech pack) that the sample should be produced against, ensuring factory uses correct specifications.',
    `tracking_number` STRING COMMENT 'Carrier tracking number for the sample shipment, used to monitor delivery status and location.',
    `trim_reference` STRING COMMENT 'Reference codes for trims and accessories used in the sample (buttons, zippers, labels, etc.), linking to the material library.',
    `created_by` STRING COMMENT 'Username or identifier of the person who created the sample request record in the system.',
    CONSTRAINT pk_sample_request PRIMARY KEY(`sample_request_id`)
) COMMENT 'Sample Management System (SMS) record tracking the full sample lifecycle from request through factory submission and evaluation. Captures sample type (proto, salesman, PP, TOP, counter, fit), season, style reference, colorway, size, requested delivery date, recipient, factory submission date, measurement conformance, evaluation comments (fit, construction, color accuracy, measurement deviations), evaluator, revision round, corrective actions, and final approval decision (approved, approved with comments, rejected). SSOT for all sample requests, counter-sample submissions, and their evaluation outcomes within sourcing.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` (
    `sample_evaluation_id` BIGINT COMMENT 'Primary key for sample_evaluation',
    `colorway_id` BIGINT COMMENT 'Foreign key linking to product.colorway. Business justification: Sample evaluations assess colorway accuracy against standards. Critical for color approval workflow and lab dip/strike-off decisions. Colorists and technical designers evaluate samples by colorway for',
    `employee_id` BIGINT COMMENT 'Reference to the employee who conducted the evaluation. Typically a product developer, technical designer, or quality assurance specialist.',
    `environmental_impact_id` BIGINT COMMENT 'Foreign key linking to sustainability.environmental_impact. Business justification: Sample evaluations include sustainability criteria assessment and environmental impact review. Links quality approval process to sustainability performance. Enables rejection of samples that fail envi',
    `pp_sample_id` BIGINT COMMENT 'Foreign key linking to production.pp_sample. Business justification: Sourcing sample evaluations assess production-submitted PP samples for fit, construction, and quality. This link closes the feedback loop between sourcing quality standards and factory execution, enab',
    `product_sample_id` BIGINT COMMENT 'Reference to the physical sample being evaluated. Links to the sample management system (SMS) record.',
    `sample_request_id` BIGINT COMMENT 'Foreign key linking to sourcing.sample_request. Business justification: Sample evaluations are performed on samples that were requested. The existing FK sample_id points to product.sample (cross-domain). This new FK establishes the in-domain relationship to sample_request',
    `sketch_id` BIGINT COMMENT 'Foreign key linking to design.design_sketch. Business justification: Sample evaluations assess physical samples against original design sketches to validate design intent. Critical design validation workflow. Enables design-to-sample conformance tracking, design revisi',
    `style_id` BIGINT COMMENT 'Foreign key linking to product.style. Business justification: Sample evaluations assess style construction, fit, and quality. Essential for style approval decisions and fit standard validation. Technical designers link evaluations to style master for approval wo',
    `color_accuracy_score` STRING COMMENT 'Assessment of color match against approved lab dip or color standard. Evaluates color consistency across all materials and components.. Valid values are `pass|fail|acceptable|needs_improvement`',
    `color_comments` STRING COMMENT 'Detailed observations on color accuracy including shade variations, color matching between components, and lighting condition notes. Critical for color approval decisions.',
    `construction_comments` STRING COMMENT 'Detailed narrative on construction quality issues, defects, or deviations from specifications. Includes observations on seam allowances, topstitching, hem quality, and finishing details.',
    `construction_quality_score` STRING COMMENT 'Assessment of garment construction quality including seam quality, stitching consistency, finishing, and workmanship. Evaluates adherence to construction specifications in tech pack.. Valid values are `pass|fail|acceptable|needs_improvement`',
    `corrective_actions_required` STRING COMMENT 'Detailed list of specific corrective actions the supplier must take to address evaluation findings. Provides clear direction for sample revision.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the evaluation record was first created in the system. Audit trail for record creation.',
    `evaluation_date` DATE COMMENT 'Date when the physical evaluation was conducted. Represents the business event date when the evaluator assessed the sample.',
    `evaluation_duration_minutes` STRING COMMENT 'Time spent conducting the evaluation in minutes. Used for resource planning and process efficiency analysis.',
    `evaluation_notes` STRING COMMENT 'General notes and observations from the evaluation that do not fit into specific category comments. Captures additional context and evaluator insights.',
    `evaluation_number` STRING COMMENT 'Business identifier for the evaluation record. Externally visible evaluation tracking number used in communications with suppliers and internal teams.. Valid values are `^EVAL-[0-9]{8}$`',
    `evaluation_status` STRING COMMENT 'Current lifecycle status of the evaluation. Pending = awaiting evaluator assignment, In Progress = evaluation underway, Approved = sample meets all requirements, Approved with Comments = sample acceptable with minor notes, Rejected = sample fails requirements and must be revised, On Hold = evaluation paused pending additional information.. Valid values are `pending|in_progress|approved|approved_with_comments|rejected|on_hold`',
    `evaluator_name` STRING COMMENT 'Full name of the person who conducted the evaluation. Captured for audit trail and communication purposes.',
    `evaluator_role` STRING COMMENT 'Functional role of the evaluator. Determines evaluation focus area and approval authority level.. Valid values are `product_developer|technical_designer|quality_assurance|merchandiser|design_director`',
    `fit_comments` STRING COMMENT 'Detailed narrative comments on fit evaluation including specific measurement deviations, silhouette issues, and fit model feedback. Critical for communicating fit corrections to suppliers.',
    `fit_evaluation_score` STRING COMMENT 'Overall assessment of garment fit against technical specifications. Pass = meets all fit requirements, Fail = significant fit issues, Acceptable = minor fit deviations within tolerance, Needs Improvement = fit issues requiring correction.. Valid values are `pass|fail|acceptable|needs_improvement`',
    `material_comments` STRING COMMENT 'Detailed notes on material compliance including fabric hand feel, weight deviations, trim substitutions, and any material quality concerns. Documents material approval or rejection reasons.',
    `material_compliance_score` STRING COMMENT 'Assessment of whether materials used match approved specifications. Evaluates fabric type, weight, composition, and trim components against Bill of Materials (BOM).. Valid values are `pass|fail|acceptable|needs_improvement`',
    `measurement_comments` STRING COMMENT 'Detailed documentation of specific measurement points that deviate from specifications, including actual vs. target measurements and tolerance analysis.',
    `measurement_deviation_flag` BOOLEAN COMMENT 'Indicates whether any measurements fall outside acceptable tolerance ranges defined in the tech pack. True = deviations exist, False = all measurements within tolerance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the evaluation record was last modified. Audit trail for record updates and changes.',
    `overall_approval_decision` STRING COMMENT 'Final approval decision for the sample. Approved = sample passes all criteria and can proceed to production, Approved with Comments = sample acceptable with documented notes, Rejected = sample fails and requires revision.. Valid values are `approved|approved_with_comments|rejected`',
    `photo_documentation_flag` BOOLEAN COMMENT 'Indicates whether photographic documentation was captured during evaluation. True = photos attached, False = no photos. Photos are critical for communicating issues to suppliers.',
    `pp_approval_date` DATE COMMENT 'Date when Pre-Production (PP) approval was granted. Critical milestone in the sourcing timeline that triggers production authorization.',
    `pp_approval_flag` BOOLEAN COMMENT 'Indicates whether this evaluation resulted in Pre-Production (PP) approval, which authorizes the supplier to proceed with bulk production. True = PP approved, False = PP not approved.',
    `rejection_reason_category` STRING COMMENT 'Primary category of rejection when sample is not approved. Helps categorize supplier performance issues and track common failure modes. [ENUM-REF-CANDIDATE: fit|construction|material|color|measurement|workmanship|multiple — 7 candidates stripped; promote to reference product]',
    `resubmission_required_flag` BOOLEAN COMMENT 'Indicates whether supplier must resubmit a revised sample. True = resubmission required, False = no resubmission needed (approved or approved with minor comments).',
    `revision_round` STRING COMMENT 'Sequential revision number for this sample. Tracks how many times the sample has been revised and re-evaluated. First submission is round 1.',
    `sample_type` STRING COMMENT 'Type of sample being evaluated. Proto = prototype sample, Fit = fit sample for sizing validation, PP = pre-production sample, SMS = sample management system sample, Production = production-run sample, Counter = counter sample from vendor, Salesman = sales representative sample. [ENUM-REF-CANDIDATE: proto|fit|pp|sms|production|counter|salesman — 7 candidates stripped; promote to reference product]',
    `supplier_notified_date` DATE COMMENT 'Date when evaluation results were communicated to the supplier. Tracks communication timeliness and supplier response time.',
    `target_resubmission_date` DATE COMMENT 'Expected date for supplier to resubmit revised sample. Drives Time and Action (TNA) calendar updates and production timeline management.',
    CONSTRAINT pk_sample_evaluation PRIMARY KEY(`sample_evaluation_id`)
) COMMENT 'Evaluation record for a received sample capturing fit comments, construction quality, material compliance, color accuracy, measurement deviations, and overall approval decision (approved, approved with comments, rejected). Tracks evaluator, evaluation date, revision round, and required corrective actions. Drives the PP approval workflow within the sourcing sample management process.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` (
    `sourcing_material_sourcing_id` BIGINT COMMENT 'Unique identifier for the material sourcing record. Primary key for the material master data.',
    `chemical_compliance_id` BIGINT COMMENT 'Foreign key linking to sustainability.chemical_compliance. Business justification: Materials must meet chemical compliance standards (ZDHC MRSL, REACH, California Prop 65). Regulatory requirement for material approval and market access. Links sourcing decisions to chemical testing a',
    `compliance_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_certification. Business justification: Materials require specific certifications (GOTS for organic cotton, GRS for recycled polyester, FSC for packaging). Material master data includes certification requirements that sourcing teams verify ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Material sourcing records require cost center allocation for fabric/trim expense tracking, material cost budgeting, and BOM cost analysis - fundamental to apparel product costing and financial plannin',
    `material_certification_id` BIGINT COMMENT 'Foreign key linking to sustainability.material_certification. Business justification: Materials require certifications (GOTS, OEKO-TEX, BCI, etc.) for compliance and marketing claims. Fundamental link for certification management and audit trails. Removes denormalized certificate numbe',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Material sourcing records track approved materials from suppliers. Essential for BOM validation, material library management, and supplier-material linkage. Sourcing teams link sourced materials to ma',
    `restricted_substance_id` BIGINT COMMENT 'Foreign key linking to compliance.restricted_substance. Business justification: Materials must be screened against restricted substance lists (REACH SVHC, California Prop 65, ZDHC MRSL). Material approval workflow requires RSL compliance verification before supplier qualification',
    `rfq_id` BIGINT COMMENT 'Foreign key linking to sourcing.rfq. Business justification: Materials can be sourced via the RFQ process. This FK links material sourcing records to the RFQ that procured them, providing traceability from solicitation to material master. No bidirectional confl',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Materials are sourced by fabric/trim buyers who negotiate with mills. Tracks accountability for material selection, sustainability compliance, and cost negotiations. Essential for performance metrics ',
    `supplier_material_supplier_id` BIGINT COMMENT 'Reference to the approved mill or supplier from whom this material is sourced. Links to supplier master data.',
    `sustainable_material_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainable_material. Business justification: Material sourcing records reference sustainable material master data for procurement specifications. Natural alignment between sourcing execution and sustainability material library. Enables consisten',
    `active_flag` BOOLEAN COMMENT 'Indicates whether the material is currently active and available for use in new product development and production.',
    `bci_cotton` BOOLEAN COMMENT 'Indicates whether the material contains cotton sourced through the Better Cotton Initiative for sustainable cotton farming.',
    `care_instructions` STRING COMMENT 'Care and maintenance instructions for the material (e.g., washing, drying, ironing). Used for product labeling and consumer information.',
    `color_standard` STRING COMMENT 'Reference color standard or Pantone code for the material. Used for color matching and quality control in production.',
    `cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit cost (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `cost_unit` STRING COMMENT 'Unit of measure for the unit cost (e.g., per yard, per meter, per kilogram, per piece).. Valid values are `yard|meter|kilogram|piece|unit`',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the country where the material is manufactured. Required for customs and trade compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the material sourcing record was first created in the system.',
    `development_season` STRING COMMENT 'Season or collection for which this material was developed (e.g., SS24, FW24, Holiday 2024). Links material to merchandising calendar.',
    `development_status` STRING COMMENT 'Current lifecycle status of the material in the product development and sourcing workflow.. Valid values are `concept|in_development|sample_approved|production_ready|active|discontinued`',
    `fiber_content` STRING COMMENT 'Composition of the material by fiber type and percentage (e.g., 100% Organic Cotton, 65% Polyester 35% Cotton, Metal: Brass). Required for FTC textile labeling compliance.',
    `fob_cost` DECIMAL(18,2) COMMENT 'Free on Board cost including material cost and delivery to port of shipment. Used for total landed cost calculation.',
    `gots_compliant` BOOLEAN COMMENT 'Indicates whether the material meets Global Organic Textile Standard (GOTS) requirements for organic fiber content and sustainable processing.',
    `hs_code` STRING COMMENT 'Harmonized System code for customs classification and international trade. Required for import/export documentation and duty calculation.. Valid values are `^[0-9]{6,10}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the material sourcing record was last updated. Used for change tracking and audit trail.',
    `lead_time_days` STRING COMMENT 'Standard lead time in days from purchase order placement to material delivery. Used in Time and Action (TNA) calendar planning.',
    `moq_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required by the mill or supplier for this material. Critical for procurement planning and costing.',
    `moq_unit` STRING COMMENT 'Unit of measure for the MOQ (e.g., yards, meters, kilograms, pieces).. Valid values are `yards|meters|kilograms|pieces|units`',
    `oeko_tex_certified` BOOLEAN COMMENT 'Indicates whether the material has OEKO-TEX Standard 100 certification for textile safety and absence of harmful substances.',
    `pp_approval_date` DATE COMMENT 'Date when the material received Pre-Production approval. Key milestone in the Time and Action (TNA) calendar.',
    `pp_approval_status` STRING COMMENT 'Pre-Production approval status for the material. Indicates whether the material has passed quality and specification review for production use.. Valid values are `not_submitted|pending_review|approved|rejected|conditional_approval`',
    `sample_available` BOOLEAN COMMENT 'Indicates whether a physical sample of this material is available in the Sample Management System (SMS) for design review and approval.',
    `sample_reference_number` STRING COMMENT 'Reference number for the physical sample in the Sample Management System (SMS) if available.',
    `sustainability_score` DECIMAL(18,2) COMMENT 'Composite sustainability score for the material based on environmental impact, certifications, and sourcing practices. Scale 0-100.',
    `test_report_available` BOOLEAN COMMENT 'Indicates whether lab test reports (e.g., colorfastness, shrinkage, tensile strength) are available for this material.',
    `test_report_reference` STRING COMMENT 'Reference number or document identifier for the lab test report if available.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of the material in the base currency. Used for Bill of Materials (BOM) costing and Cost of Goods Sold (COGS) calculation.',
    `weight_gsm` DECIMAL(18,2) COMMENT 'Weight of the fabric material measured in grams per square meter. Key specification for fabric performance and costing.',
    `width_inches` DECIMAL(18,2) COMMENT 'Usable width of the fabric material measured in inches. Critical for yield calculation and cutting efficiency.',
    CONSTRAINT pk_sourcing_material_sourcing PRIMARY KEY(`sourcing_material_sourcing_id`)
) COMMENT 'Master record for all raw materials, fabrics, trims, and components used in apparel production. Captures material code, description, material type (woven, knit, trim, lining, hardware, button, zipper, label, elastic, interlining), fiber content, weight (GSM), width, color standard, development status, development season, OEKO-TEX certification status, GOTS compliance flag, HS code, MOQ, lead time, unit cost, and approved mill/supplier references. SSOT for material definitions including trim catalog entries within sourcing.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` (
    `fabric_development_id` BIGINT COMMENT 'Unique identifier for the fabric development record. Primary key for tracking a fabric through its entire development lifecycle from concept to bulk approval.',
    `collection_id` BIGINT COMMENT 'Reference to the product collection for which this fabric is being developed. Links fabric development to specific merchandising collections.',
    `concept_id` BIGINT COMMENT 'Foreign key linking to design.concept. Business justification: Fabric development projects originate from design concepts requiring custom fabric creation. Enables concept-to-fabric development traceability, concept-level fabric innovation tracking, and design co',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Fabric development costs must be allocated to cost centers for R&D expense tracking, product development budgeting, and innovation cost management - standard practice in apparel product development fi',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Fabric development is led by textile developers who manage lab dips, strike-offs, and bulk approvals. Tracks ownership for fabric innovation, quality issues, and development timelines. Normalizes deno',
    `environmental_impact_id` BIGINT COMMENT 'Foreign key linking to sustainability.environmental_impact. Business justification: New fabric developments require environmental impact assessments (LCA) for sustainability evaluation and material selection decisions. Enables comparison of development alternatives based on environme',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Fabric development results in approved materials added to material library. Critical for BOM integration and material master data. Sourcing teams link approved fabrics to material master for reuse.',
    `product_safety_test_id` BIGINT COMMENT 'Foreign key linking to compliance.product_safety_test. Business justification: New fabric developments require safety testing (azo dyes, formaldehyde, phthalates, lead) before bulk approval. Fabric approval gate requires passing test results. Development teams track test status ',
    `production_factory_id` BIGINT COMMENT 'Reference to the textile mill or fabric supplier responsible for developing and producing this fabric. Links to supplier master data.',
    `rfq_id` BIGINT COMMENT 'Foreign key linking to sourcing.rfq. Business justification: Fabric development can be initiated via RFQs sent to mills. This FK links fabric development to the RFQ that initiated it, providing traceability from solicitation to fabric approval. No bidirectional',
    `sourcing_material_sourcing_id` BIGINT COMMENT 'Foreign key linking to sourcing.material_sourcing. Business justification: Fabric development records track the lifecycle of new fabrics, which should reference the material sourcing master record. This FK links fabric development to the material master, enabling consolidate',
    `style_id` BIGINT COMMENT 'Foreign key linking to product.style. Business justification: Fabric development is initiated for specific styles. Needed for style-fabric linkage, development tracking, and fabric approval workflow. Design and sourcing teams link fabric development to target st',
    `sustainable_material_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainable_material. Business justification: Fabric development projects target sustainable material specifications for new collections. Links R&D efforts to sustainability material library. Essential for tracking sustainable innovation pipeline',
    `bulk_approval_date` DATE COMMENT 'Date when the fabric received final bulk approval. Enables procurement to issue Purchase Orders (PO) for production yardage.',
    `bulk_approval_status` STRING COMMENT 'Final approval status for bulk production of the fabric. Indicates whether the fabric is cleared for large-scale manufacturing and Purchase Order (PO) placement.. Valid values are `not_submitted|pending_review|approved|rejected|conditional`',
    `bulk_yardage_commitment` DECIMAL(18,2) COMMENT 'Total yardage or meterage of fabric committed for bulk production. Used for capacity planning and Minimum Order Quantity (MOQ) negotiations with the mill.',
    `colorway` STRING COMMENT 'Color or color combination being developed for this fabric. May include Pantone references, color names, or internal color codes.',
    `cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the fabric cost (e.g., USD, EUR, CNY). Required for multi-currency procurement and landed cost calculations.. Valid values are `^[A-Z]{3}$`',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Negotiated cost per unit (yard or meter) of fabric from the mill. Used for Bill of Materials (BOM) costing and Cost of Goods Sold (COGS) calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fabric development record was first created in the system. Audit trail for record creation.',
    `development_season` STRING COMMENT 'The target season for which this fabric is being developed. Format: SS (Spring/Summer), FW (Fall/Winter), SP (Spring), FA (Fall) followed by two-digit year (e.g., SS24, FW25).. Valid values are `^(SS|FW|SP|FA)[0-9]{2}$`',
    `development_status` STRING COMMENT 'Current lifecycle status of the fabric development process. Tracks progression from initial concept through mill submissions, lab dip approval, strike-off approval, and final bulk approval. [ENUM-REF-CANDIDATE: concept|submitted|lab_dip_pending|lab_dip_approved|strike_off_pending|strike_off_approved|bulk_approved|rejected|on_hold — 9 candidates stripped; promote to reference product]',
    `fabric_code` STRING COMMENT 'Unique alphanumeric code assigned to the fabric for system identification and cross-referencing across Product Lifecycle Management (PLM) and Enterprise Resource Planning (ERP) systems.. Valid values are `^[A-Z0-9]{6,12}$`',
    `fabric_construction` STRING COMMENT 'Technical description of the fabric structure including weave type, knit pattern, or construction method (e.g., plain weave, twill, jersey knit, rib knit, interlock).',
    `fabric_name` STRING COMMENT 'Business name or marketing name assigned to the fabric being developed. Used for identification in collection planning and merchandising.',
    `fabric_weight` DECIMAL(18,2) COMMENT 'Weight of the fabric measured in grams per square meter (GSM) or ounces per square yard. Critical specification for product costing and performance characteristics.',
    `fabric_width` DECIMAL(18,2) COMMENT 'Width of the fabric measured in inches or centimeters. Standard widths impact cutting efficiency and Bill of Materials (BOM) calculations.',
    `fiber_blend` STRING COMMENT 'Composition of fibers used in the fabric with percentages (e.g., 60% Cotton 40% Polyester, 100% Organic Cotton). Must comply with Federal Trade Commission (FTC) fiber content labeling requirements.',
    `finish_treatment` STRING COMMENT 'Chemical or mechanical finishing processes applied to the fabric (e.g., enzyme wash, stone wash, water repellent, anti-microbial, wrinkle-free). Impacts hand-feel and performance.',
    `lab_dip_approval_date` DATE COMMENT 'Date when the lab dip color sample was approved by the design or product development team. Critical milestone in the TNA calendar.',
    `lab_dip_status` STRING COMMENT 'Approval status of the lab dip color sample. Lab dip is the initial small-scale color sample submitted by the mill for color approval before bulk production.. Valid values are `not_submitted|pending_review|approved|rejected|resubmit_required`',
    `lab_dip_submission_date` DATE COMMENT 'Date when the lab dip color sample was submitted by the mill for review. Used to track Time and Action (TNA) calendar milestones.',
    `lead_time_days` STRING COMMENT 'Number of days required from Purchase Order (PO) placement to fabric delivery. Critical for Time and Action (TNA) calendar planning and On Time In Full (OTIF) performance.',
    `mill_reference_number` STRING COMMENT 'The mills internal reference or article number for this fabric. Used for communication and ordering with the supplier.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fabric development record was last modified. Audit trail for tracking changes throughout the development lifecycle.',
    `moq_quantity` DECIMAL(18,2) COMMENT 'Minimum Order Quantity (MOQ) required by the mill for this fabric. Critical for procurement planning and cost negotiations.',
    `moq_unit` STRING COMMENT 'Unit of measure for the Minimum Order Quantity (MOQ) - may be linear measure (yards/meters) or weight (kg) depending on mill requirements.. Valid values are `yards|meters|kg`',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or observations during the fabric development process. Captures iterative feedback and mill communications.',
    `rejection_reason` STRING COMMENT 'Detailed explanation if the fabric was rejected at any stage (lab dip, strike-off, or bulk). Captures quality issues, color mismatch, hand-feel deviation, or test failures.',
    `strike_off_approval_date` DATE COMMENT 'Date when the strike-off fabric sample was approved. Approval triggers progression to bulk yardage commitment and Pre-Production (PP) sample phase.',
    `strike_off_status` STRING COMMENT 'Approval status of the strike-off sample. Strike-off is a larger fabric sample (typically 1-2 yards) that demonstrates the final fabric construction, color, and finish.. Valid values are `not_submitted|pending_review|approved|rejected|resubmit_required`',
    `strike_off_submission_date` DATE COMMENT 'Date when the strike-off fabric sample was submitted by the mill for review. Key TNA milestone before bulk production commitment.',
    `submission_round` STRING COMMENT 'Sequential number indicating which iteration of fabric submission this represents. Tracks the number of times the mill has resubmitted samples for approval.',
    `sustainability_certification` STRING COMMENT 'Environmental or ethical certifications held by the fabric (e.g., GOTS, BCI, OEKO-TEX, Bluesign, GRS). Supports sustainability reporting and compliance.',
    `target_hand_feel` STRING COMMENT 'Desired tactile characteristics and drape of the fabric as specified by the design team (e.g., soft, crisp, fluid, structured, brushed).',
    `test_results_summary` STRING COMMENT 'Summary of physical and chemical test results performed on the fabric (e.g., colorfastness, shrinkage, pilling resistance, tensile strength). Links to detailed lab test reports.',
    `weight_unit` STRING COMMENT 'Unit of measure for fabric weight. GSM (grams per square meter) is metric standard; oz per square yard is imperial standard.. Valid values are `gsm|oz_per_sq_yd`',
    `width_unit` STRING COMMENT 'Unit of measure for fabric width (inches or centimeters).. Valid values are `inches|cm`',
    `yardage_unit` STRING COMMENT 'Unit of measure for bulk yardage commitment (yards or meters).. Valid values are `yards|meters`',
    CONSTRAINT pk_fabric_development PRIMARY KEY(`fabric_development_id`)
) COMMENT 'Fabric development record tracking the lifecycle of a new fabric from concept through mill approval. Captures fabric name, construction, fiber blend, colorway, finish, target hand-feel, lab dip status, strike-off approval, bulk yardage commitment, and development season. Manages the iterative mill development process including submission rounds, test results, and final bulk approval.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` (
    `lab_dip_id` BIGINT COMMENT 'Unique identifier for the lab dip approval record. Primary key for tracking color development and approval process for fabric or material.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Lab dips are approved by color managers or product developers who verify Pantone accuracy and color fastness. Tracks approval authority for color standards, critical for quality control and vendor acc',
    `chemical_compliance_id` BIGINT COMMENT 'Foreign key linking to sustainability.chemical_compliance. Business justification: Lab dips must be tested for chemical compliance (ZDHC MRSL, restricted substances) before bulk production approval. Quality gate for color development. Links color approval process to chemical testing',
    `colorway_development_id` BIGINT COMMENT 'Foreign key linking to design.colorway_development. Business justification: Lab dips are color approval samples for specific colorway development projects. Direct 1:1 business relationship. Enables colorway-to-lab-dip traceability, color approval workflow management, and colo',
    `colorway_id` BIGINT COMMENT 'Foreign key linking to product.colorway. Business justification: Lab dips are submitted for specific colorways to achieve color standards. Fundamental to color approval process and bulk production authorization. Colorists link lab dips to colorway master for approv',
    `fabric_development_id` BIGINT COMMENT 'Reference to the specific fabric or material for which the color is being matched.',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Lab dips test specific materials for color accuracy and fastness. Needed for material-color approval tracking and dye recipe validation. Sourcing teams link lab dips to material master for quality con',
    `print_colorway_id` BIGINT COMMENT 'Foreign key linking to design.print_colorway. Business justification: Lab dips validate print colorway color accuracy for printed fabrics. Natural design-to-sourcing validation process. Enables print colorway approval tracking, print color conformance validation, and pr',
    `production_factory_id` BIGINT COMMENT 'Reference to the textile mill or dye house that submitted this lab dip for approval.',
    `sourcing_material_sourcing_id` BIGINT COMMENT 'Foreign key linking to sourcing.material_sourcing. Business justification: Lab dips are color approval records for materials. This FK links lab dip approvals to the material sourcing master record, enabling consolidated material color management. No bidirectional conflict ex',
    `style_id` BIGINT COMMENT 'Reference to the product style for which this lab dip color is being developed.',
    `vendor_id` BIGINT COMMENT 'Reference to the primary supplier managing the fabric sourcing and color development process.',
    `actual_lab_a` DECIMAL(18,2) COMMENT 'Measured green-red axis value of the submitted lab dip in CIELAB color space.',
    `actual_lab_b` DECIMAL(18,2) COMMENT 'Measured blue-yellow axis value of the submitted lab dip in CIELAB color space.',
    `actual_lab_l` DECIMAL(18,2) COMMENT 'Measured lightness value of the submitted lab dip in CIELAB color space.',
    `approval_date` DATE COMMENT 'Date when the lab dip received final approval for bulk production. Null if not yet approved. Critical milestone for TNA calendar and PO (Purchase Order) release.',
    `approval_status` STRING COMMENT 'Current approval status of the lab dip in the color development workflow. Determines whether bulk fabric production can proceed.. Valid values are `pending|approved|rejected|resubmit|conditionally_approved|cancelled`',
    `collection_name` STRING COMMENT 'Name of the product collection or line to which this color belongs. Used for merchandising and assortment planning.',
    `color_fastness_rating` STRING COMMENT 'Rating (1-5 scale) indicating the color fastness performance of the dyed fabric. Higher values indicate better resistance to fading. Based on ISO 105 testing standards.. Valid values are `^[1-5]$|not_tested`',
    `color_standard_type` STRING COMMENT 'Type of color standard used for matching specification (Pantone, LAB values, RGB, CMYK, or physical swatch).. Valid values are `pantone|lab|rgb|cmyk|physical_swatch`',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or special instructions related to the lab dip evaluation and approval process.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lab dip record was first created in the system. Used for audit trail and process tracking.',
    `delta_e_value` DECIMAL(18,2) COMMENT 'Calculated color difference (Delta E) between target and actual color. Lower values indicate closer match. Typically acceptable range is Delta E < 1.0 for critical color matching.',
    `digital_image_url` STRING COMMENT 'URL link to digital photograph or scan of the lab dip sample. Enables remote review and digital archiving.. Valid values are `^https?://.*`',
    `dye_lot_number` STRING COMMENT 'Batch identifier for the dye lot used in this lab dip submission. Critical for traceability and consistency in bulk production.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `dye_recipe_code` STRING COMMENT 'Code identifying the specific dye formulation and recipe used for this color. Links to dye house technical specifications.',
    `evaluation_date` DATE COMMENT 'Date when the lab dip was evaluated by the design or quality team.',
    `is_strike_off_required` BOOLEAN COMMENT 'Boolean flag indicating whether a larger strike-off sample (printed or dyed fabric yardage) is required after lab dip approval before bulk production commitment.',
    `lab_dip_number` STRING COMMENT 'Business identifier for the lab dip submission. Externally-known reference number used across PLM systems and vendor communications.. Valid values are `^LD-[A-Z0-9]{6,12}$`',
    `light_fastness_grade` STRING COMMENT 'Grade (1-8 scale) measuring resistance to color change from light exposure. Grade 8 is excellent, grade 1 is poor.. Valid values are `^[1-8]$|not_tested`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this lab dip record was last modified. Tracks the most recent update to any field in the record.',
    `pantone_reference` STRING COMMENT 'Pantone color standard reference code used as the target color specification for matching.. Valid values are `^PANTONE [0-9]{2,4}[A-Z]{0,2}$`',
    `rejection_reason` STRING COMMENT 'Detailed explanation of why the lab dip was rejected or requires resubmission. Includes specific color matching issues or quality defects.',
    `sample_physical_location` STRING COMMENT 'Physical storage location of the lab dip sample swatch (e.g., design studio, quality lab, archive). Used for sample retrieval and reference.',
    `season_code` STRING COMMENT 'Code representing the fashion season for which this color is being developed (e.g., SS24 for Spring/Summer 2024, FW24 for Fall/Winter 2024).. Valid values are `^(SS|FW|SP|FA)[0-9]{2}$`',
    `spectrophotometer_reading_file` STRING COMMENT 'File path or reference to the spectrophotometer measurement data file. Contains detailed color measurement data for technical analysis.',
    `submission_date` DATE COMMENT 'Date when the mill submitted this lab dip sample for evaluation. Critical for Time and Action (TNA) calendar tracking.',
    `submission_round` STRING COMMENT 'Sequential number indicating which submission attempt this represents (1 for first submission, 2 for resubmit, etc.). Tracks iteration count in color approval process.',
    `target_bulk_production_date` DATE COMMENT 'Planned date for bulk fabric production to begin. Drives urgency of lab dip approval process within TNA calendar.',
    `target_lab_a` DECIMAL(18,2) COMMENT 'Target green-red axis value in CIELAB color space. Negative values indicate green, positive indicate red.',
    `target_lab_b` DECIMAL(18,2) COMMENT 'Target blue-yellow axis value in CIELAB color space. Negative values indicate blue, positive indicate yellow.',
    `target_lab_l` DECIMAL(18,2) COMMENT 'Target lightness value in CIELAB color space (0-100 scale). Used for precise color measurement and matching.',
    `wash_fastness_grade` STRING COMMENT 'Grade (1-5 scale) measuring resistance to color change from washing. Grade 5 is excellent, grade 1 is poor.. Valid values are `^[1-5]$|not_tested`',
    CONSTRAINT pk_lab_dip PRIMARY KEY(`lab_dip_id`)
) COMMENT 'Lab dip approval record tracking the color development and approval process for a fabric or material. Captures colorway reference, Pantone/color standard, dye lot, mill submission date, evaluation result (approved, rejected, resubmit), delta-E measurement, submission round number, and final approval date. Critical for color accuracy compliance before bulk fabric production commitment.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` (
    `lead_time_profile_id` BIGINT COMMENT 'Unique identifier for the lead time profile record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_agreement. Business justification: Lead time profiles can be defined and governed by sourcing agreements. This FK links lead time profiles to the agreements that define them, enabling agreement-based lead time management. No bidirectio',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Lead time profiles require cost center assignment for supply chain cost modeling, lead time cost analysis, and procurement planning expense allocation - supports apparel sourcing financial optimizatio',
    `distribution_center_id` BIGINT COMMENT 'Foreign key linking to logistics.distribution_center. Business justification: Lead time profiles specify target in-DC dates for specific destination facilities; critical for vendor onboarding, PO placement timing, and ensuring sourcing commitments align with DC capacity and ret',
    `employee_id` BIGINT COMMENT 'Identifier of the sourcing manager or planner who approved this lead time profile for operational use.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Lead time profiles include carrier-specific transit times for different lanes and service levels; essential for accurate TNA planning, routing guide alignment, and vendor lead time commitments in appa',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier for which this lead time profile is defined.',
    `superseded_lead_time_profile_id` BIGINT COMMENT 'Self-referencing FK on lead_time_profile (superseded_lead_time_profile_id)',
    `approval_date` DATE COMMENT 'Date when this lead time profile was formally approved and activated for planning purposes.',
    `buffer_days` STRING COMMENT 'Additional safety buffer days added to the total lead time to account for variability, delays, and risk mitigation.',
    `capacity_constraint_flag` BOOLEAN COMMENT 'Indicates whether the supplier has capacity constraints for this product category that may affect lead time variability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lead time profile record was first created in the system.',
    `critical_path_flag` BOOLEAN COMMENT 'Indicates whether this lead time profile is on the critical path for Time and Action (TNA) calendar planning.',
    `customs_clearance_lead_time_days` STRING COMMENT 'Number of days required for customs clearance, duty payment, and import documentation processing.',
    `destination_country_code` STRING COMMENT 'Three-letter ISO country code representing the destination country for shipment.. Valid values are `^[A-Z]{3}$`',
    `effective_from_date` DATE COMMENT 'Date from which this lead time profile becomes active and applicable for planning and sourcing decisions.',
    `effective_to_date` DATE COMMENT 'Date until which this lead time profile remains valid; nullable for open-ended profiles.',
    `fob_port_code` STRING COMMENT 'Code identifying the port of loading where goods are handed over to the carrier under FOB terms.',
    `incoterm` STRING COMMENT 'International Commercial Terms (Incoterms) defining the delivery terms and responsibility transfer point between supplier and buyer.. Valid values are `EXW|FOB|CIF|DDP|FCA|CPT`',
    `last_review_date` DATE COMMENT 'Date when this lead time profile was last reviewed and validated against actual performance data.',
    `material_sourcing_lead_time_days` STRING COMMENT 'Number of days required to source and procure raw materials, fabrics, and trims from mills and vendors.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this lead time profile record was last modified or updated.',
    `moq_quantity` STRING COMMENT 'Minimum order quantity required by the supplier for this product category, negotiated during sourcing.',
    `moq_unit` STRING COMMENT 'Unit of measure for the minimum order quantity (e.g., units, pieces, dozens, cartons).. Valid values are `units|pieces|dozens|cartons`',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review and update of this lead time profile to ensure accuracy.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information about this lead time profile.',
    `payment_terms` STRING COMMENT 'Negotiated payment terms with the supplier (e.g., Net 30, Net 60, Letter of Credit) that may influence lead time planning.',
    `plm_system_reference` STRING COMMENT 'Reference identifier linking this lead time profile to the corresponding record in Centric PLM or Infor PLM system.',
    `pp_approval_lead_time_days` STRING COMMENT 'Number of days required for pre-production sample approval workflow including fit, construction, and material compliance evaluation.',
    `product_category_code` STRING COMMENT 'Code representing the product category (e.g., tops, bottoms, footwear, accessories) for which this lead time profile applies.',
    `production_lead_time_days` STRING COMMENT 'Number of days required for bulk production including cutting, making, and trimming (CMT) operations.',
    `profile_name` STRING COMMENT 'Descriptive name for the lead time profile to facilitate identification and reporting.',
    `profile_status` STRING COMMENT 'Current lifecycle status of the lead time profile indicating whether it is actively used in planning.. Valid values are `active|inactive|draft|archived`',
    `quality_inspection_lead_time_days` STRING COMMENT 'Number of days allocated for quality inspection and compliance testing before shipment.',
    `quality_standard` STRING COMMENT 'Quality standard or certification requirement applicable to this lead time profile (e.g., ISO 9001, AQL 2.5).',
    `sample_development_lead_time_days` STRING COMMENT 'Number of days required for sample development, submission, and evaluation through the Sample Management System (SMS).',
    `season_code` STRING COMMENT 'Code representing the fashion season or collection period for which this lead time profile is applicable (e.g., SS24, FW24).',
    `shipping_transit_lead_time_days` STRING COMMENT 'Number of days required for freight transportation from Free on Board (FOB) port to destination warehouse or distribution center.',
    `sustainability_certification_required` BOOLEAN COMMENT 'Indicates whether sustainability certifications (OEKO-TEX, GOTS, BCI) are required for this supplier-category combination, which may impact lead time.',
    `total_lead_time_days` STRING COMMENT 'Total end-to-end lead time in days from order placement to delivery at destination, including all component lead times and buffers.',
    CONSTRAINT pk_lead_time_profile PRIMARY KEY(`lead_time_profile_id`)
) COMMENT 'Master record defining standard lead time parameters for a supplier-product category combination including total lead time, component lead times, and buffer days';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` (
    `rtv_order_id` BIGINT COMMENT 'Unique identifier for the return to vendor order.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: RTV orders must be allocated to cost centers for quality cost tracking, return expense management, and vendor performance cost analysis - enables financial accountability for defective goods.',
    `employee_id` BIGINT COMMENT 'Identifier of the buyer or sourcing manager responsible for the RTV order.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: RTV orders require GL account assignment for accounts payable credit processing, inventory return accounting, and vendor credit memo reconciliation - fundamental to apparel financial transaction proce',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Returns to vendor for compliance failures (restricted substances detected, missing certifications, labeling violations) must link to incident records. RTV root cause tracking for regulatory violations',
    `production_factory_id` BIGINT COMMENT 'Identifier of the factory or manufacturing facility that produced the returned goods.',
    `return_shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.return_shipment. Business justification: RTV orders generate outbound return shipments that must be tracked through logistics network for carrier coordination, tracking, delivery confirmation, and freight cost reconciliation in apparel retur',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Returns are processed at SKU level for inventory accuracy and defect tracking. Essential for vendor accountability, quality analysis, and cost recovery. Warehouse and QA teams link RTVs to SKU master.',
    `sourcing_purchase_order_id` BIGINT COMMENT 'Reference to the original sourcing purchase order from which goods are being returned.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor to whom goods are being returned.',
    `warehouse_location_id` BIGINT COMMENT 'Identifier of the warehouse or distribution center initiating the return.',
    `waste_record_id` BIGINT COMMENT 'Foreign key linking to sustainability.waste_record. Business justification: Returns to vendor generate waste that must be tracked for waste management, circular economy programs, and landfill diversion reporting. Links reverse logistics to waste accounting. Required for zero-',
    `original_rtv_order_id` BIGINT COMMENT 'Self-referencing FK on rtv_order (original_rtv_order_id)',
    `actual_credit_amount` DECIMAL(18,2) COMMENT 'Actual credit amount issued by the vendor after inspection and approval of returned goods.',
    `actual_ship_date` DATE COMMENT 'Date when the returned goods were actually shipped back to the vendor.',
    `approval_date` DATE COMMENT 'Date when the RTV order was approved for execution.',
    `approved_by` STRING COMMENT 'Name of the person who approved the RTV order for processing.',
    `carrier_name` STRING COMMENT 'Name of the logistics carrier or freight forwarder handling the return shipment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the RTV order record was first created in the system.',
    `credit_disposition` STRING COMMENT 'Vendor decision on how the return will be credited or resolved.. Valid values are `full_credit|partial_credit|replacement|no_credit|pending_inspection`',
    `credit_issue_date` DATE COMMENT 'Date when the vendor issued the credit memo for the returned goods.',
    `credit_memo_number` STRING COMMENT 'Vendor-issued credit memo reference number for the return transaction.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the return value and credit amounts. [ENUM-REF-CANDIDATE: USD|EUR|GBP|CNY|JPY|INR|CAD|AUD — 8 candidates stripped; promote to reference product]',
    `expected_credit_amount` DECIMAL(18,2) COMMENT 'Expected credit amount to be issued by the vendor for the returned goods.',
    `freight_cost` DECIMAL(18,2) COMMENT 'Cost of freight and logistics for returning goods to the vendor.',
    `freight_responsibility` STRING COMMENT 'Party responsible for bearing the freight cost of the return shipment.. Valid values are `vendor|buyer|shared`',
    `incoterms` STRING COMMENT 'Incoterms governing the return shipment and transfer of risk and cost responsibility.. Valid values are `EXW|FOB|CIF|DDP|DAP|FCA`',
    `inspection_report_reference` STRING COMMENT 'Reference number of the quality inspection report documenting the defects or non-conformance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the RTV order record was last modified or updated.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the RTV order.',
    `product_category` STRING COMMENT 'High-level product category classification of the returned goods.',
    `quality_defect_category` STRING COMMENT 'Classification of the quality defect type when return is due to quality issues.. Valid values are `fabric_defect|construction_defect|color_variance|measurement_deviation|workmanship|material_defect`',
    `requested_pickup_date` DATE COMMENT 'Date when the vendor is requested to pick up or receive the returned goods.',
    `return_authorization_number` STRING COMMENT 'Vendor-issued return merchandise authorization (RMA) number approving the return.',
    `return_reason_code` STRING COMMENT 'Standardized code representing the specific reason for returning goods to the vendor.',
    `return_reason_description` STRING COMMENT 'Detailed description of the reason for returning goods including quality issues, specification mismatches, or other defects.',
    `rtv_date` DATE COMMENT 'Date when the RTV order was created and initiated in the system.',
    `rtv_number` STRING COMMENT 'Externally-known unique business identifier for the RTV order used in vendor communication and tracking.',
    `rtv_status` STRING COMMENT 'Current lifecycle status of the RTV order in the return workflow process. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|in_transit|received_by_vendor|credit_issued|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `rtv_type` STRING COMMENT 'Classification of the return type indicating the primary reason category for the return.. Valid values are `quality_defect|excess_inventory|damaged_goods|non_conforming|wrong_shipment|obsolete`',
    `season_code` STRING COMMENT 'Season identifier for the returned goods linking to the collection planning cycle.',
    `shipping_method` STRING COMMENT 'Method of transportation used to return goods to the vendor.. Valid values are `air_freight|ocean_freight|ground_courier|vendor_pickup|3pl_logistics`',
    `total_return_quantity` DECIMAL(18,2) COMMENT 'Total quantity of units being returned to the vendor across all line items.',
    `total_return_value` DECIMAL(18,2) COMMENT 'Total monetary value of all goods being returned to the vendor.',
    `tracking_number` STRING COMMENT 'Shipment tracking number provided by the carrier for monitoring return transit.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the returned goods quantity. [ENUM-REF-CANDIDATE: EA|PC|PCS|CTN|BOX|PLT|YD|MTR|KG|LB — 10 candidates stripped; promote to reference product]',
    `vendor_contact_email` STRING COMMENT 'Email address of the vendor contact for return coordination and communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `vendor_contact_name` STRING COMMENT 'Name of the vendor contact person handling the return transaction.',
    `vendor_receipt_date` DATE COMMENT 'Date when the vendor confirmed receipt of the returned goods.',
    CONSTRAINT pk_rtv_order PRIMARY KEY(`rtv_order_id`)
) COMMENT 'Return to Vendor order managing the return of defective, excess, or non-conforming goods to the supplier including RTV reason, quantity, and credit disposition';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` (
    `agreement_id` BIGINT COMMENT 'Unique identifier for the sourcing agreement record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the internal buyer or sourcing manager responsible for negotiating and managing this agreement.',
    `agreement_sourcing_agent_employee_id` BIGINT COMMENT 'Reference to the third-party sourcing agent or buying office involved in this agreement, if applicable.',
    `carbon_target_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_target. Business justification: Long-term sourcing agreements align with corporate carbon reduction targets and may include supplier-specific emission reduction commitments. Links commercial strategy to climate goals. Essential for ',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Sourcing agreements define pricing, capacity, and terms for product categories. Critical for category-level capacity planning, pricing strategy, and vendor management. Sourcing directors link agreemen',
    `collaboration_id` BIGINT COMMENT 'Foreign key linking to design.design_collaboration. Business justification: Sourcing agreements are established for design collaboration partnerships requiring dedicated vendor relationships and capacity allocation. Enables collaboration-specific sourcing terms management, co',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Sourcing agreements must be allocated to cost centers for multi-year contract expense tracking, committed spend management, and long-term procurement budget planning in apparel operations.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Long-term sourcing agreements specify ongoing compliance obligations (labor standards, environmental certifications, audit frequency) that vendors must maintain. Master service agreements include comp',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Agreements must be assigned to profit centers for strategic vendor profitability analysis, brand-specific sourcing cost tracking, and long-term margin planning in apparel brand management.',
    `rfq_id` BIGINT COMMENT 'Foreign key linking to sourcing.rfq. Business justification: Sourcing agreements can result from RFQ processes (e.g., strategic RFQs leading to framework agreements). This FK links agreements to the RFQ that initiated them, providing traceability from solicitat',
    `supplier_esg_assessment_id` BIGINT COMMENT 'Foreign key linking to sustainability.supplier_esg_assessment. Business justification: Sourcing agreements require valid ESG assessments and reference sustainability requirements as contract terms. Links long-term commercial relationships to ESG performance. Mandatory for responsible so',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor party with whom this sourcing agreement is established.',
    `master_agreement_id` BIGINT COMMENT 'Self-referencing FK on agreement (master_agreement_id)',
    `agreement_name` STRING COMMENT 'Descriptive name of the sourcing agreement for easy identification and reference by business users.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the sourcing agreement, used in vendor communications and contract references.. Valid values are `^SA-[0-9]{6,10}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the sourcing agreement indicating its operational state and enforceability. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|expired|terminated|renewed — 7 candidates stripped; promote to reference product]',
    `agreement_type` STRING COMMENT 'Classification of the sourcing agreement based on its strategic purpose and scope. Master agreements cover multiple seasons, seasonal agreements are collection-specific, spot agreements are one-time purchases, blanket agreements provide volume commitments, framework agreements establish terms for future orders, and exclusive agreements grant sole sourcing rights.. Valid values are `master|seasonal|spot|blanket|framework|exclusive`',
    `approval_date` DATE COMMENT 'The date when this sourcing agreement received final internal approval.',
    `approval_status` STRING COMMENT 'The approval status of this sourcing agreement within the internal governance workflow.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the executive or manager who approved this sourcing agreement.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this agreement automatically renews at the end of its term unless either party provides termination notice.',
    `base_cmt_rate` DECIMAL(18,2) COMMENT 'The baseline Cut Make Trim labor rate per unit negotiated in this agreement for manufacturing services.',
    `base_fob_price` DECIMAL(18,2) COMMENT 'The baseline Free On Board unit price negotiated in this agreement before volume discounts or surcharges are applied.',
    `capacity_allocation_percent` DECIMAL(18,2) COMMENT 'The percentage of the vendors production capacity allocated or reserved for the buyer under this agreement.',
    `committed_volume_quantity` DECIMAL(18,2) COMMENT 'The total volume or quantity of goods that the buyer commits to source from the vendor under this agreement, used for volume guarantee negotiations.',
    `compliance_certification_required` STRING COMMENT 'List of compliance certifications that the vendor must maintain and provide under this agreement (e.g., WRAP, SA8000, ISO 14001, CPSC compliance).',
    `contract_document_reference` STRING COMMENT 'Reference identifier or file path to the signed legal contract document stored in the document management system.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this sourcing agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for all monetary values in this agreement (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `destination_port_code` STRING COMMENT 'The destination port or distribution center where goods will be delivered under this agreement.',
    `effective_from_date` DATE COMMENT 'The date when the sourcing agreement becomes legally binding and operational.',
    `effective_to_date` DATE COMMENT 'The date when the sourcing agreement expires or terminates. Nullable for open-ended agreements with no fixed end date.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this agreement grants the buyer exclusive sourcing rights for specified products or categories from this vendor.',
    `exclusivity_scope` STRING COMMENT 'Description of the scope of exclusivity if applicable, detailing which products, categories, or geographic regions are covered by the exclusive arrangement.',
    `fob_port_code` STRING COMMENT 'The port of origin from which goods will be shipped under FOB terms, typically the vendors shipping port.',
    `incoterms` STRING COMMENT 'The Incoterms rule governing the transfer of risk and responsibility for shipping costs in this agreement. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `lead_time_days` STRING COMMENT 'The standard total lead time in days from purchase order placement to ex-factory shipment under this agreement.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The minimum order quantity per purchase order or per style that the vendor requires under this agreement.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this sourcing agreement record was last modified or updated.',
    `moq_unit` STRING COMMENT 'The unit of measure for the minimum order quantity.. Valid values are `units|pieces|dozens|cases`',
    `notes` STRING COMMENT 'Free-text field for additional notes, special terms, or contextual information about this sourcing agreement.',
    `payment_terms` STRING COMMENT 'The negotiated payment terms for orders placed under this agreement (e.g., Net 30, Net 60, 50% deposit + 50% on shipment, Letter of Credit).',
    `penalty_clause` STRING COMMENT 'Description of penalties or liquidated damages applicable for breach of agreement terms, such as failure to meet volume commitments or quality standards.',
    `pricing_tier_structure` STRING COMMENT 'Description of the volume-based pricing tiers negotiated in this agreement, detailing quantity breaks and corresponding unit prices or discount percentages.',
    `quality_standard` STRING COMMENT 'The quality standards and specifications that the vendor must meet under this agreement (e.g., ISO 9001, AQL 2.5, ASTM standards).',
    `renewal_notice_days` STRING COMMENT 'The number of days advance notice required to terminate or opt out of auto-renewal of this agreement.',
    `season_code` STRING COMMENT 'The fashion season or collection period covered by this sourcing agreement. Format examples: SS24 (Spring/Summer 2024), FW24 (Fall/Winter 2024), HO24 (Holiday 2024), SP24 (Spring 2024).. Valid values are `^(SS|FW|HO|SP)[0-9]{2}$`',
    `sustainability_requirement` STRING COMMENT 'Sustainability and ethical sourcing requirements mandated in this agreement, such as GOTS certification, BCI cotton usage, OEKO-TEX compliance, or Fair Labor Association standards.',
    `termination_clause` STRING COMMENT 'Description of the conditions and procedures under which either party may terminate this agreement before its natural expiration.',
    `volume_unit` STRING COMMENT 'The unit of measure for the committed volume quantity (e.g., units, pieces, dozens, cases, pallets).. Valid values are `units|pieces|dozens|cases|pallets`',
    CONSTRAINT pk_agreement PRIMARY KEY(`agreement_id`)
) COMMENT 'Master record for strategic sourcing framework agreements with vendors covering seasonal commitments, volume guarantees, pricing tiers, and exclusivity terms distinct from individual purchase orders';

-- ========= FOREIGN KEYS =========
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ADD CONSTRAINT `fk_sourcing_rfq_line_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`rfq`(`rfq_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ADD CONSTRAINT `fk_sourcing_vendor_quote_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`rfq`(`rfq_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ADD CONSTRAINT `fk_sourcing_vendor_cost_quote_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`rfq`(`rfq_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ADD CONSTRAINT `fk_sourcing_vendor_cost_quote_vendor_quote_id` FOREIGN KEY (`vendor_quote_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`vendor_quote`(`vendor_quote_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`agreement`(`agreement_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_vendor_quote_id` FOREIGN KEY (`vendor_quote_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`vendor_quote`(`vendor_quote_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`rfq`(`rfq_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_line_rfq_line_id` FOREIGN KEY (`rfq_line_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`rfq_line`(`rfq_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_line_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ADD CONSTRAINT `fk_sourcing_sourcing_purchase_order_line_vendor_cost_quote_id` FOREIGN KEY (`vendor_cost_quote_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote`(`vendor_cost_quote_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ADD CONSTRAINT `fk_sourcing_sourcing_tna_calendar_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`rfq`(`rfq_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ADD CONSTRAINT `fk_sourcing_sourcing_tna_calendar_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ADD CONSTRAINT `fk_sourcing_sourcing_tna_milestone_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`rfq`(`rfq_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ADD CONSTRAINT `fk_sourcing_sourcing_tna_milestone_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ADD CONSTRAINT `fk_sourcing_sourcing_tna_milestone_sourcing_tna_calendar_id` FOREIGN KEY (`sourcing_tna_calendar_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar`(`sourcing_tna_calendar_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ADD CONSTRAINT `fk_sourcing_sample_request_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`rfq`(`rfq_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ADD CONSTRAINT `fk_sourcing_sample_request_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ADD CONSTRAINT `fk_sourcing_sample_evaluation_sample_request_id` FOREIGN KEY (`sample_request_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sample_request`(`sample_request_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ADD CONSTRAINT `fk_sourcing_sourcing_material_sourcing_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`rfq`(`rfq_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ADD CONSTRAINT `fk_sourcing_fabric_development_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`rfq`(`rfq_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ADD CONSTRAINT `fk_sourcing_fabric_development_sourcing_material_sourcing_id` FOREIGN KEY (`sourcing_material_sourcing_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing`(`sourcing_material_sourcing_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ADD CONSTRAINT `fk_sourcing_lab_dip_fabric_development_id` FOREIGN KEY (`fabric_development_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`fabric_development`(`fabric_development_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ADD CONSTRAINT `fk_sourcing_lab_dip_sourcing_material_sourcing_id` FOREIGN KEY (`sourcing_material_sourcing_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing`(`sourcing_material_sourcing_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ADD CONSTRAINT `fk_sourcing_lead_time_profile_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`agreement`(`agreement_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ADD CONSTRAINT `fk_sourcing_lead_time_profile_superseded_lead_time_profile_id` FOREIGN KEY (`superseded_lead_time_profile_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`lead_time_profile`(`lead_time_profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ADD CONSTRAINT `fk_sourcing_rtv_order_sourcing_purchase_order_id` FOREIGN KEY (`sourcing_purchase_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`(`sourcing_purchase_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ADD CONSTRAINT `fk_sourcing_rtv_order_original_rtv_order_id` FOREIGN KEY (`original_rtv_order_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`rtv_order`(`rtv_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ADD CONSTRAINT `fk_sourcing_agreement_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`rfq`(`rfq_id`);
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ADD CONSTRAINT `fk_sourcing_agreement_master_agreement_id` FOREIGN KEY (`master_agreement_id`) REFERENCES `apparel_fashion_ecm`.`sourcing`.`agreement`(`agreement_id`);

-- ========= TAGS =========
ALTER SCHEMA `apparel_fashion_ecm`.`sourcing` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `apparel_fashion_ecm`.`sourcing` SET TAGS ('dbx_domain' = 'sourcing');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` SET TAGS ('dbx_subdomain' = 'vendor_negotiation');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Awarded Vendor ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `sustainable_material_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Material Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `awarded_quote_amount` SET TAGS ('dbx_business_glossary_term' = 'Awarded Quote Amount');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `destination_country` SET TAGS ('dbx_business_glossary_term' = 'Destination Country');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `destination_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `estimated_volume` SET TAGS ('dbx_business_glossary_term' = 'Estimated Volume');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `fabric_composition` SET TAGS ('dbx_business_glossary_term' = 'Fabric Composition');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `moq_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Quantity');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `moq_unit` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Unit');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `moq_unit` SET TAGS ('dbx_value_regex' = 'pieces|units|yards|meters|kilograms|dozens');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `product_category` SET TAGS ('dbx_value_regex' = 'apparel|footwear|accessories|athletic|lifestyle|luxury');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `quality_standard` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `quote_received_count` SET TAGS ('dbx_business_glossary_term' = 'Quote Received Count');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `rfq_number` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Number');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `rfq_number` SET TAGS ('dbx_value_regex' = '^RFQ-[0-9]{6,10}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `rfq_status` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Status');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `rfq_status` SET TAGS ('dbx_value_regex' = 'draft|issued|under_evaluation|awarded|closed|cancelled');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `rfq_type` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Type');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `rfq_type` SET TAGS ('dbx_value_regex' = 'cmt|fob|material|trim|fabric|full_package');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `sample_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Sample Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `sample_submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Sample Submission Deadline');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^(SS|FW|SP|FA)[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `shipping_origin_country` SET TAGS ('dbx_business_glossary_term' = 'Shipping Origin Country');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `shipping_origin_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `sourcing_region` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Region');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `sourcing_region` SET TAGS ('dbx_value_regex' = 'asia|europe|americas|middle_east|africa');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `style_reference` SET TAGS ('dbx_business_glossary_term' = 'Style Reference');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Submission Deadline');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `sustainability_requirement` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Requirement');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `sustainability_requirement` SET TAGS ('dbx_value_regex' = 'none|gots|bci|oeko_tex|recycled|organic');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `target_cost` SET TAGS ('dbx_business_glossary_term' = 'Target Cost');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `technical_pack_reference` SET TAGS ('dbx_business_glossary_term' = 'Technical Pack Reference');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq` ALTER COLUMN `vendor_count` SET TAGS ('dbx_business_glossary_term' = 'Vendor Count');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` SET TAGS ('dbx_subdomain' = 'vendor_negotiation');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `rfq_line_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Line Identifier');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Identifier');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `sketch_id` SET TAGS ('dbx_business_glossary_term' = 'Design Sketch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `sustainable_material_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Material Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|on_hold');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `bom_reference` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Reference');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `buyer_notes` SET TAGS ('dbx_business_glossary_term' = 'Buyer Notes');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `colorway_code` SET TAGS ('dbx_business_glossary_term' = 'Colorway Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `colorway_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `gender_classification` SET TAGS ('dbx_business_glossary_term' = 'Gender Classification');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `gender_classification` SET TAGS ('dbx_value_regex' = 'mens|womens|unisex|boys|girls|infant');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `gender_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `gender_classification` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time in Days');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `moq_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `packaging_requirement` SET TAGS ('dbx_business_glossary_term' = 'Packaging Requirement');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `port_of_loading` SET TAGS ('dbx_business_glossary_term' = 'Port of Loading');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `quality_standard` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `quantity_break_tier_1` SET TAGS ('dbx_business_glossary_term' = 'Quantity Break Tier 1');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `quantity_break_tier_2` SET TAGS ('dbx_business_glossary_term' = 'Quantity Break Tier 2');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `quantity_break_tier_3` SET TAGS ('dbx_business_glossary_term' = 'Quantity Break Tier 3');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `requested_quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `sample_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Sample Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `size_range` SET TAGS ('dbx_business_glossary_term' = 'Size Range');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `sustainability_requirement` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Requirement');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `target_cmt_cost` SET TAGS ('dbx_business_glossary_term' = 'Target Cut Make Trim (CMT) Cost');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `target_fob_cost` SET TAGS ('dbx_business_glossary_term' = 'Target Free on Board (FOB) Cost');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `tech_pack_reference` SET TAGS ('dbx_business_glossary_term' = 'Technical Package (Tech Pack) Reference');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `testing_requirement` SET TAGS ('dbx_business_glossary_term' = 'Testing Requirement');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `vendor_notes` SET TAGS ('dbx_business_glossary_term' = 'Vendor Notes');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `vendor_response_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Response Status');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rfq_line` ALTER COLUMN `vendor_response_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|under_review|accepted|rejected|withdrawn');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` SET TAGS ('dbx_subdomain' = 'vendor_negotiation');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `vendor_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Quote Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `supplier_esg_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Esg Assessment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Status');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|rejected|negotiating');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `benchmark_score` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Score');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `capacity_available_units` SET TAGS ('dbx_business_glossary_term' = 'Capacity Available (Units)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `cmt_rate` SET TAGS ('dbx_business_glossary_term' = 'Cut Make Trim (CMT) Rate');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `counter_terms` SET TAGS ('dbx_business_glossary_term' = 'Counter Terms');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `duty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Duty Rate Percent');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `fob_price` SET TAGS ('dbx_business_glossary_term' = 'Free on Board (FOB) Price');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `freight_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Estimate');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `ldp_estimate` SET TAGS ('dbx_business_glossary_term' = 'Landed Duty Paid (LDP) Estimate');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `material_cost` SET TAGS ('dbx_business_glossary_term' = 'Material Cost');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `moq` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `port_of_loading` SET TAGS ('dbx_business_glossary_term' = 'Port of Loading');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `quality_certification` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `quote_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `quote_number` SET TAGS ('dbx_business_glossary_term' = 'Quote Number');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `quote_status` SET TAGS ('dbx_business_glossary_term' = 'Quote Status');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `quote_version` SET TAGS ('dbx_business_glossary_term' = 'Quote Version');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `sample_cost` SET TAGS ('dbx_business_glossary_term' = 'Sample Cost');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `sample_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Sample Lead Time (Days)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `tooling_cost` SET TAGS ('dbx_business_glossary_term' = 'Tooling Cost');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_quote` ALTER COLUMN `valid_until_date` SET TAGS ('dbx_business_glossary_term' = 'Valid Until Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` SET TAGS ('dbx_subdomain' = 'vendor_negotiation');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `vendor_cost_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Cost Quote Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `colorway_id` SET TAGS ('dbx_business_glossary_term' = 'Colorway Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Rfq Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `sketch_id` SET TAGS ('dbx_business_glossary_term' = 'Design Sketch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `supplier_esg_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Esg Assessment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `vendor_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Quote Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `agent_commission` SET TAGS ('dbx_business_glossary_term' = 'Agent Commission');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `cmt_cost` SET TAGS ('dbx_business_glossary_term' = 'Cut Make Trim (CMT) Cost');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `cogs_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Estimate');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `duty_cost` SET TAGS ('dbx_business_glossary_term' = 'Duty Cost');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `embellishment_cost` SET TAGS ('dbx_business_glossary_term' = 'Embellishment Cost');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `fabric_cost` SET TAGS ('dbx_business_glossary_term' = 'Fabric Cost');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `fob_cost` SET TAGS ('dbx_business_glossary_term' = 'Free On Board (FOB) Cost');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `ldp_cost` SET TAGS ('dbx_business_glossary_term' = 'Landed Duty Paid (LDP) Cost');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time in Days');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `moq` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `moq_unit` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Unit of Measure');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `moq_unit` SET TAGS ('dbx_value_regex' = 'pieces|units|dozens|cartons');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `other_charges` SET TAGS ('dbx_business_glossary_term' = 'Other Charges');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `packaging_cost` SET TAGS ('dbx_business_glossary_term' = 'Packaging Cost');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `quote_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `quote_number` SET TAGS ('dbx_business_glossary_term' = 'Quote Number');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `quote_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `quote_status` SET TAGS ('dbx_business_glossary_term' = 'Quote Status');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `quote_version` SET TAGS ('dbx_business_glossary_term' = 'Quote Version Number');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `sample_cost` SET TAGS ('dbx_business_glossary_term' = 'Sample Cost');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `target_imu_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Initial Markup (IMU) Percentage');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `target_retail_price` SET TAGS ('dbx_business_glossary_term' = 'Target Retail Price');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `testing_certification_cost` SET TAGS ('dbx_business_glossary_term' = 'Testing and Certification Cost');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `trim_cost` SET TAGS ('dbx_business_glossary_term' = 'Trim and Accessories Cost');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` SET TAGS ('dbx_subdomain' = 'vendor_negotiation');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `sourcing_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Identifier');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Agreement Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `vendor_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Awarded Vendor Quote Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Agent ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Rfq Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `supplier_esg_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Esg Assessment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `tertiary_sourcing_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `tertiary_sourcing_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `tertiary_sourcing_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `destination_port_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Port Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `destination_port_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{5}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `duty_amount` SET TAGS ('dbx_business_glossary_term' = 'Duty Amount');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `fob_port_code` SET TAGS ('dbx_business_glossary_term' = 'Free On Board (FOB) Port Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `fob_port_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{5}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `landed_cost` SET TAGS ('dbx_business_glossary_term' = 'Landed Duty Paid (LDP) Cost');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `moq_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `otif_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Flag');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'letter_of_credit|telegraphic_transfer|wire_transfer|check|ach|trade_credit');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `po_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_value_regex' = '^PO[0-9]{8,12}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Status');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Type');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_value_regex' = 'finished_goods|fabric|trim|packaging|sample');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `product_category` SET TAGS ('dbx_value_regex' = 'apparel|footwear|accessories|fabric|trim|packaging');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `sample_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Sample Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `sample_approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected|conditional');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `ship_window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Ship Window End Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `ship_window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Ship Window Start Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_value_regex' = 'GOTS|OEKO_TEX|BCI|FLA|WRAP|none');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `tna_milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Time and Action (TNA) Milestone Status');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `tna_milestone_status` SET TAGS ('dbx_value_regex' = 'on_track|at_risk|delayed|completed');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `total_order_value` SET TAGS ('dbx_business_glossary_term' = 'Total Order Value');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Order Quantity');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` SET TAGS ('dbx_subdomain' = 'vendor_negotiation');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `sourcing_purchase_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Line Identifier');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `product_safety_test_id` SET TAGS ('dbx_business_glossary_term' = 'Product Safety Test Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Identifier');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `production_tna_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Time and Action (TNA) Milestone Identifier');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `rfq_line_id` SET TAGS ('dbx_business_glossary_term' = 'Rfq Line Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `sourcing_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Purchase Order (PO) Identifier');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `sustainable_material_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Material Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `vendor_cost_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Cost Quote Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Warehouse Identifier');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `actual_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Receipt Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `color_code` SET TAGS ('dbx_business_glossary_term' = 'Color Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `confirmed_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Ship Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `costing_method` SET TAGS ('dbx_business_glossary_term' = 'Costing Method');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `costing_method` SET TAGS ('dbx_value_regex' = 'CMT|FOB|CIF|EXW|DDP|FCA');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'pending|on_time|delayed|early|delivered|partial');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `expected_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Receipt Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `line_notes` SET TAGS ('dbx_business_glossary_term' = 'Line Notes');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `line_total_cost` SET TAGS ('dbx_business_glossary_term' = 'Line Total Cost');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `moq_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `outstanding_quantity` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Quantity');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `pp_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Pre-Production (PP) Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `pp_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional|not_applicable');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `quality_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Status');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `quality_status` SET TAGS ('dbx_value_regex' = 'pending_inspection|approved|rejected|conditional_approval|quarantine');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'proto|fit|pp|sms|production|bulk');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `size_code` SET TAGS ('dbx_business_glossary_term' = 'Size Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `style_code` SET TAGS ('dbx_business_glossary_term' = 'Style Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` SET TAGS ('dbx_subdomain' = 'production_planning');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `sourcing_tna_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Time and Action (T&A) Calendar ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `colorway_id` SET TAGS ('dbx_business_glossary_term' = 'Colorway Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Distribution Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `higg_index_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Higg Index Assessment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Planner ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Rfq Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `sourcing_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `bulk_production_start_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Bulk Production Start Actual Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `bulk_production_start_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Bulk Production Start Planned Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `cmt_cost` SET TAGS ('dbx_business_glossary_term' = 'Cut Make Trim (CMT) Cost');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `cmt_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `compliance_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Required');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `delay_days` SET TAGS ('dbx_business_glossary_term' = 'Delay Days');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `delay_reason` SET TAGS ('dbx_business_glossary_term' = 'Delay Reason');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `ex_factory_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Ex-Factory Actual Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `ex_factory_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Ex-Factory Planned Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `fabric_approval_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Fabric Approval Actual Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `fabric_approval_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Fabric Approval Planned Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `fob_cost` SET TAGS ('dbx_business_glossary_term' = 'Free on Board (FOB) Cost');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `fob_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `in_dc_actual_date` SET TAGS ('dbx_business_glossary_term' = 'In Distribution Center (DC) Actual Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `in_dc_planned_date` SET TAGS ('dbx_business_glossary_term' = 'In Distribution Center (DC) Planned Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `moq_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `planned_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Quantity');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `pp_approval_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Pre-Production (PP) Approval Actual Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `pp_approval_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Pre-Production (PP) Approval Planned Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `pp_sample_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Pre-Production (PP) Sample Actual Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `pp_sample_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Pre-Production (PP) Sample Planned Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `tech_pack_version` SET TAGS ('dbx_business_glossary_term' = 'Tech Pack Version');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `tech_pack_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `tna_code` SET TAGS ('dbx_business_glossary_term' = 'Time and Action (T&A) Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `tna_code` SET TAGS ('dbx_value_regex' = '^TNA-[A-Z0-9]{6,12}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `tna_status` SET TAGS ('dbx_business_glossary_term' = 'Time and Action (T&A) Status');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `tna_type` SET TAGS ('dbx_business_glossary_term' = 'Time and Action (T&A) Type');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `tna_type` SET TAGS ('dbx_value_regex' = 'development|pre_production|bulk_production|sample_only');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `trim_approval_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Trim Approval Actual Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_calendar` ALTER COLUMN `trim_approval_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Trim Approval Planned Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` SET TAGS ('dbx_subdomain' = 'production_planning');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `sourcing_tna_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Time and Action (TNA) Milestone ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `colorway_id` SET TAGS ('dbx_business_glossary_term' = 'Colorway Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Dependency Milestone ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `higg_index_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Higg Index Assessment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `order_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Rfq Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `sourcing_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `sourcing_tna_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Tna Calendar Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Milestone Completion Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional|not_required');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `approver_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `approver_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Milestone Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `buffer_days` SET TAGS ('dbx_business_glossary_term' = 'Buffer Days');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Milestone Comments');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Completion Status');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|delayed|cancelled|on_hold');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `delay_days` SET TAGS ('dbx_business_glossary_term' = 'Delay Days');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `delay_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Delay Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `delay_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Delay Reason Description');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `is_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Indicator');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `milestone_category` SET TAGS ('dbx_business_glossary_term' = 'Milestone Category');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `milestone_category` SET TAGS ('dbx_value_regex' = 'material_development|sample_management|production_preparation|quality_approval|logistics|administrative');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `milestone_code` SET TAGS ('dbx_business_glossary_term' = 'Milestone Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `milestone_sequence` SET TAGS ('dbx_business_glossary_term' = 'Milestone Sequence Number');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_value_regex' = 'approval|submission|start|completion|shipment|receipt');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Milestone Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Type');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `revised_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Milestone Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` SET TAGS ('dbx_subdomain' = 'production_planning');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `sample_request_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Request ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `colorway_id` SET TAGS ('dbx_business_glossary_term' = 'Colorway Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `environmental_impact_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `pp_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Pp Sample Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `product_safety_test_id` SET TAGS ('dbx_business_glossary_term' = 'Product Safety Test Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Rfq Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `sketch_id` SET TAGS ('dbx_business_glossary_term' = 'Design Sketch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `sourcing_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `approval_decision` SET TAGS ('dbx_business_glossary_term' = 'Sample Approval Decision');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `approval_decision` SET TAGS ('dbx_value_regex' = 'approved|approved_with_comments|rejected');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `bom_reference` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Materials (BOM) Reference');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `color_accuracy_evaluation` SET TAGS ('dbx_business_glossary_term' = 'Color Accuracy Evaluation');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `construction_evaluation_comments` SET TAGS ('dbx_business_glossary_term' = 'Construction Evaluation Comments');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `corrective_actions_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Required');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Evaluation Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `factory_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Factory Submission Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `fit_evaluation_comments` SET TAGS ('dbx_business_glossary_term' = 'Fit Evaluation Comments');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `material_fabric_reference` SET TAGS ('dbx_business_glossary_term' = 'Material Fabric Reference');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `measurement_conformance_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Conformance Status');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `measurement_conformance_status` SET TAGS ('dbx_value_regex' = 'pass|fail|within_tolerance|out_of_spec');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `measurement_deviation_details` SET TAGS ('dbx_business_glossary_term' = 'Measurement Deviation Details');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `modified_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Sample Request Priority Level');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `recipient_location` SET TAGS ('dbx_business_glossary_term' = 'Sample Recipient Location');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Sample Request Number');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^SR-[0-9]{8}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Sample Request Status');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `revision_round` SET TAGS ('dbx_business_glossary_term' = 'Sample Revision Round');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `sample_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Sample Cost Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `sample_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `sample_cost_fob` SET TAGS ('dbx_business_glossary_term' = 'Sample Cost Free On Board (FOB)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `sample_cost_fob` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'proto|salesman|PP|TOP|counter|fit');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^(SS|FW|HO)[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Sample Shipping Method');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'air_express|air_standard|sea_freight|courier');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `tech_pack_version` SET TAGS ('dbx_business_glossary_term' = 'Tech Pack Version');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `trim_reference` SET TAGS ('dbx_business_glossary_term' = 'Trim Reference');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_request` ALTER COLUMN `created_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` SET TAGS ('dbx_subdomain' = 'production_planning');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `sample_evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Evaluation Identifier');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `colorway_id` SET TAGS ('dbx_business_glossary_term' = 'Colorway Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `environmental_impact_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `pp_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Pp Sample Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `product_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `sample_request_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Request Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `sketch_id` SET TAGS ('dbx_business_glossary_term' = 'Design Sketch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `color_accuracy_score` SET TAGS ('dbx_business_glossary_term' = 'Color Accuracy Score');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `color_accuracy_score` SET TAGS ('dbx_value_regex' = 'pass|fail|acceptable|needs_improvement');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `color_comments` SET TAGS ('dbx_business_glossary_term' = 'Color Comments');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `construction_comments` SET TAGS ('dbx_business_glossary_term' = 'Construction Comments');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `construction_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Construction Quality Score');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `construction_quality_score` SET TAGS ('dbx_value_regex' = 'pass|fail|acceptable|needs_improvement');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `corrective_actions_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Required');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `evaluation_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Duration Minutes');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `evaluation_notes` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Notes');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `evaluation_number` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Number');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `evaluation_number` SET TAGS ('dbx_value_regex' = '^EVAL-[0-9]{8}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|approved|approved_with_comments|rejected|on_hold');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `evaluator_name` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Name');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `evaluator_role` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Role');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `evaluator_role` SET TAGS ('dbx_value_regex' = 'product_developer|technical_designer|quality_assurance|merchandiser|design_director');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `fit_comments` SET TAGS ('dbx_business_glossary_term' = 'Fit Comments');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `fit_evaluation_score` SET TAGS ('dbx_business_glossary_term' = 'Fit Evaluation Score');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `fit_evaluation_score` SET TAGS ('dbx_value_regex' = 'pass|fail|acceptable|needs_improvement');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `material_comments` SET TAGS ('dbx_business_glossary_term' = 'Material Comments');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `material_compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Material Compliance Score');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `material_compliance_score` SET TAGS ('dbx_value_regex' = 'pass|fail|acceptable|needs_improvement');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `measurement_comments` SET TAGS ('dbx_business_glossary_term' = 'Measurement Comments');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `measurement_deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Measurement Deviation Flag');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `overall_approval_decision` SET TAGS ('dbx_business_glossary_term' = 'Overall Approval Decision');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `overall_approval_decision` SET TAGS ('dbx_value_regex' = 'approved|approved_with_comments|rejected');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `photo_documentation_flag` SET TAGS ('dbx_business_glossary_term' = 'Photo Documentation Flag');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `pp_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Pre-Production (PP) Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `pp_approval_flag` SET TAGS ('dbx_business_glossary_term' = 'Pre-Production (PP) Approval Flag');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `rejection_reason_category` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Category');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `resubmission_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `revision_round` SET TAGS ('dbx_business_glossary_term' = 'Revision Round');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `supplier_notified_date` SET TAGS ('dbx_business_glossary_term' = 'Supplier Notified Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sample_evaluation` ALTER COLUMN `target_resubmission_date` SET TAGS ('dbx_business_glossary_term' = 'Target Resubmission Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` SET TAGS ('dbx_subdomain' = 'material_development');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `sourcing_material_sourcing_id` SET TAGS ('dbx_business_glossary_term' = 'Material Sourcing ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `chemical_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Compliance Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `material_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Certification Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `restricted_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Restricted Substance Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Rfq Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `supplier_material_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Mill or Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `sustainable_material_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Material Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `bci_cotton` SET TAGS ('dbx_business_glossary_term' = 'Better Cotton Initiative (BCI) Cotton Flag');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `care_instructions` SET TAGS ('dbx_business_glossary_term' = 'Care Instructions');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `color_standard` SET TAGS ('dbx_business_glossary_term' = 'Color Standard');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `cost_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Unit of Measure');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `cost_unit` SET TAGS ('dbx_value_regex' = 'yard|meter|kilogram|piece|unit');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `development_season` SET TAGS ('dbx_business_glossary_term' = 'Development Season');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `development_status` SET TAGS ('dbx_business_glossary_term' = 'Development Status');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `development_status` SET TAGS ('dbx_value_regex' = 'concept|in_development|sample_approved|production_ready|active|discontinued');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `fiber_content` SET TAGS ('dbx_business_glossary_term' = 'Fiber Content');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `fob_cost` SET TAGS ('dbx_business_glossary_term' = 'Free on Board (FOB) Cost');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `fob_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `gots_compliant` SET TAGS ('dbx_business_glossary_term' = 'Global Organic Textile Standard (GOTS) Compliant Flag');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time in Days');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `moq_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `moq_unit` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Unit of Measure');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `moq_unit` SET TAGS ('dbx_value_regex' = 'yards|meters|kilograms|pieces|units');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `oeko_tex_certified` SET TAGS ('dbx_business_glossary_term' = 'OEKO-TEX Certified Flag');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `pp_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Pre-Production (PP) Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `pp_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Pre-Production (PP) Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `pp_approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending_review|approved|rejected|conditional_approval');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `sample_available` SET TAGS ('dbx_business_glossary_term' = 'Sample Available Flag');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `sample_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Sample Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `sustainability_score` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Score');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `test_report_available` SET TAGS ('dbx_business_glossary_term' = 'Test Report Available Flag');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `test_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Report Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `weight_gsm` SET TAGS ('dbx_business_glossary_term' = 'Weight Grams per Square Meter (GSM)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`sourcing_material_sourcing` ALTER COLUMN `width_inches` SET TAGS ('dbx_business_glossary_term' = 'Width in Inches');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` SET TAGS ('dbx_subdomain' = 'material_development');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `fabric_development_id` SET TAGS ('dbx_business_glossary_term' = 'Fabric Development ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Developer Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `environmental_impact_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `product_safety_test_id` SET TAGS ('dbx_business_glossary_term' = 'Product Safety Test Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Mill ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Rfq Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `sourcing_material_sourcing_id` SET TAGS ('dbx_business_glossary_term' = 'Material Sourcing Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `sustainable_material_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Material Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `bulk_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Bulk Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `bulk_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Bulk Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `bulk_approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending_review|approved|rejected|conditional');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `bulk_yardage_commitment` SET TAGS ('dbx_business_glossary_term' = 'Bulk Yardage Commitment');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `colorway` SET TAGS ('dbx_business_glossary_term' = 'Colorway');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `development_season` SET TAGS ('dbx_business_glossary_term' = 'Development Season');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `development_season` SET TAGS ('dbx_value_regex' = '^(SS|FW|SP|FA)[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `development_status` SET TAGS ('dbx_business_glossary_term' = 'Development Status');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `fabric_code` SET TAGS ('dbx_business_glossary_term' = 'Fabric Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `fabric_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `fabric_construction` SET TAGS ('dbx_business_glossary_term' = 'Fabric Construction');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `fabric_name` SET TAGS ('dbx_business_glossary_term' = 'Fabric Name');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `fabric_weight` SET TAGS ('dbx_business_glossary_term' = 'Fabric Weight');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `fabric_width` SET TAGS ('dbx_business_glossary_term' = 'Fabric Width');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `fiber_blend` SET TAGS ('dbx_business_glossary_term' = 'Fiber Blend');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `finish_treatment` SET TAGS ('dbx_business_glossary_term' = 'Finish Treatment');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `finish_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `finish_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `lab_dip_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Lab Dip Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `lab_dip_status` SET TAGS ('dbx_business_glossary_term' = 'Lab Dip Status');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `lab_dip_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending_review|approved|rejected|resubmit_required');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `lab_dip_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Lab Dip Submission Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `mill_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Mill Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `moq_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `moq_unit` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Unit');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `moq_unit` SET TAGS ('dbx_value_regex' = 'yards|meters|kg');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Development Notes');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `strike_off_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Strike Off Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `strike_off_status` SET TAGS ('dbx_business_glossary_term' = 'Strike Off Status');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `strike_off_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending_review|approved|rejected|resubmit_required');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `strike_off_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Strike Off Submission Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `submission_round` SET TAGS ('dbx_business_glossary_term' = 'Submission Round');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `target_hand_feel` SET TAGS ('dbx_business_glossary_term' = 'Target Hand Feel');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `test_results_summary` SET TAGS ('dbx_business_glossary_term' = 'Test Results Summary');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `weight_unit` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `weight_unit` SET TAGS ('dbx_value_regex' = 'gsm|oz_per_sq_yd');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `width_unit` SET TAGS ('dbx_business_glossary_term' = 'Width Unit of Measure');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `width_unit` SET TAGS ('dbx_value_regex' = 'inches|cm');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `yardage_unit` SET TAGS ('dbx_business_glossary_term' = 'Yardage Unit of Measure');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`fabric_development` ALTER COLUMN `yardage_unit` SET TAGS ('dbx_value_regex' = 'yards|meters');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` SET TAGS ('dbx_subdomain' = 'material_development');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `lab_dip_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Dip Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `chemical_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Compliance Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `colorway_development_id` SET TAGS ('dbx_business_glossary_term' = 'Colorway Development Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `colorway_id` SET TAGS ('dbx_business_glossary_term' = 'Colorway Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `fabric_development_id` SET TAGS ('dbx_business_glossary_term' = 'Fabric Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `print_colorway_id` SET TAGS ('dbx_business_glossary_term' = 'Print Colorway Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Mill Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `sourcing_material_sourcing_id` SET TAGS ('dbx_business_glossary_term' = 'Material Sourcing Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `actual_lab_a` SET TAGS ('dbx_business_glossary_term' = 'Actual LAB A Value');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `actual_lab_b` SET TAGS ('dbx_business_glossary_term' = 'Actual LAB B Value');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `actual_lab_l` SET TAGS ('dbx_business_glossary_term' = 'Actual LAB L Value');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Final Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|resubmit|conditionally_approved|cancelled');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `collection_name` SET TAGS ('dbx_business_glossary_term' = 'Collection Name');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `color_fastness_rating` SET TAGS ('dbx_business_glossary_term' = 'Color Fastness Rating');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `color_fastness_rating` SET TAGS ('dbx_value_regex' = '^[1-5]$|not_tested');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `color_standard_type` SET TAGS ('dbx_business_glossary_term' = 'Color Standard Type');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `color_standard_type` SET TAGS ('dbx_value_regex' = 'pantone|lab|rgb|cmyk|physical_swatch');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `delta_e_value` SET TAGS ('dbx_business_glossary_term' = 'Delta E Value');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `digital_image_url` SET TAGS ('dbx_business_glossary_term' = 'Digital Image URL (Uniform Resource Locator)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `digital_image_url` SET TAGS ('dbx_value_regex' = '^https?://.*');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `dye_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Dye Lot Number');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `dye_lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `dye_recipe_code` SET TAGS ('dbx_business_glossary_term' = 'Dye Recipe Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `is_strike_off_required` SET TAGS ('dbx_business_glossary_term' = 'Strike-Off Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `lab_dip_number` SET TAGS ('dbx_business_glossary_term' = 'Lab Dip Number');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `lab_dip_number` SET TAGS ('dbx_value_regex' = '^LD-[A-Z0-9]{6,12}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `light_fastness_grade` SET TAGS ('dbx_business_glossary_term' = 'Light Fastness Grade');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `light_fastness_grade` SET TAGS ('dbx_value_regex' = '^[1-8]$|not_tested');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `pantone_reference` SET TAGS ('dbx_business_glossary_term' = 'Pantone Reference');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `pantone_reference` SET TAGS ('dbx_value_regex' = '^PANTONE [0-9]{2,4}[A-Z]{0,2}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `sample_physical_location` SET TAGS ('dbx_business_glossary_term' = 'Sample Physical Location');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^(SS|FW|SP|FA)[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `spectrophotometer_reading_file` SET TAGS ('dbx_business_glossary_term' = 'Spectrophotometer Reading File');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `submission_round` SET TAGS ('dbx_business_glossary_term' = 'Submission Round Number');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `target_bulk_production_date` SET TAGS ('dbx_business_glossary_term' = 'Target Bulk Production Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `target_lab_a` SET TAGS ('dbx_business_glossary_term' = 'Target LAB A Value');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `target_lab_b` SET TAGS ('dbx_business_glossary_term' = 'Target LAB B Value');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `target_lab_l` SET TAGS ('dbx_business_glossary_term' = 'Target LAB L Value');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `wash_fastness_grade` SET TAGS ('dbx_business_glossary_term' = 'Wash Fastness Grade');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lab_dip` ALTER COLUMN `wash_fastness_grade` SET TAGS ('dbx_value_regex' = '^[1-5]$|not_tested');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` SET TAGS ('dbx_subdomain' = 'vendor_negotiation');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `lead_time_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Profile ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Agreement Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Distribution Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Carrier Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `superseded_lead_time_profile_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `buffer_days` SET TAGS ('dbx_business_glossary_term' = 'Buffer Days');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `capacity_constraint_flag` SET TAGS ('dbx_business_glossary_term' = 'Capacity Constraint Flag');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `customs_clearance_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `fob_port_code` SET TAGS ('dbx_business_glossary_term' = 'Free on Board (FOB) Port Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `incoterm` SET TAGS ('dbx_value_regex' = 'EXW|FOB|CIF|DDP|FCA|CPT');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `material_sourcing_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Material Sourcing Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `moq_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `moq_unit` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Unit');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `moq_unit` SET TAGS ('dbx_value_regex' = 'units|pieces|dozens|cartons');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `plm_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) System Reference');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `pp_approval_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Pre-Production (PP) Approval Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `product_category_code` SET TAGS ('dbx_business_glossary_term' = 'Product Category Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `production_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Production Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Profile Name');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Profile Status');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `quality_inspection_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `quality_standard` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `sample_development_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Sample Development Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `shipping_transit_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Shipping Transit Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `sustainability_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`lead_time_profile` ALTER COLUMN `total_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Total Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` SET TAGS ('dbx_subdomain' = 'vendor_negotiation');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `rtv_order_id` SET TAGS ('dbx_business_glossary_term' = 'Return to Vendor (RTV) Order ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `return_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Return Shipment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `sourcing_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Purchase Order (PO) ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `waste_record_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Record Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `original_rtv_order_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `actual_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Credit Amount');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `credit_disposition` SET TAGS ('dbx_business_glossary_term' = 'Credit Disposition');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `credit_disposition` SET TAGS ('dbx_value_regex' = 'full_credit|partial_credit|replacement|no_credit|pending_inspection');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `credit_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Issue Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `credit_memo_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Number');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `expected_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Credit Amount');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `freight_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Freight Responsibility');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `freight_responsibility` SET TAGS ('dbx_value_regex' = 'vendor|buyer|shared');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_value_regex' = 'EXW|FOB|CIF|DDP|DAP|FCA');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `inspection_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Inspection Report Reference');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `quality_defect_category` SET TAGS ('dbx_business_glossary_term' = 'Quality Defect Category');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `quality_defect_category` SET TAGS ('dbx_value_regex' = 'fabric_defect|construction_defect|color_variance|measurement_deviation|workmanship|material_defect');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `requested_pickup_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Pickup Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `return_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Return Authorization Number');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `return_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `rtv_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Vendor (RTV) Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `rtv_number` SET TAGS ('dbx_business_glossary_term' = 'Return to Vendor (RTV) Number');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `rtv_status` SET TAGS ('dbx_business_glossary_term' = 'Return to Vendor (RTV) Status');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `rtv_type` SET TAGS ('dbx_business_glossary_term' = 'Return to Vendor (RTV) Type');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `rtv_type` SET TAGS ('dbx_value_regex' = 'quality_defect|excess_inventory|damaged_goods|non_conforming|wrong_shipment|obsolete');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'air_freight|ocean_freight|ground_courier|vendor_pickup|3pl_logistics');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `total_return_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Return Quantity');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `total_return_value` SET TAGS ('dbx_business_glossary_term' = 'Total Return Value');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Email');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Name');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`rtv_order` ALTER COLUMN `vendor_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Receipt Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` SET TAGS ('dbx_data_type' = 'Master');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` SET TAGS ('dbx_subdomain' = 'vendor_negotiation');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Agreement ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `agreement_sourcing_agent_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Agent ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `agreement_sourcing_agent_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `agreement_sourcing_agent_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `carbon_target_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Target Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `collaboration_id` SET TAGS ('dbx_business_glossary_term' = 'Design Collaboration Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Rfq Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `supplier_esg_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Esg Assessment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `master_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Agreement Name');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Agreement Number');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^SA-[0-9]{6,10}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Agreement Status');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Agreement Type');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'master|seasonal|spot|blanket|framework|exclusive');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `base_cmt_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Cut Make Trim (CMT) Rate');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `base_fob_price` SET TAGS ('dbx_business_glossary_term' = 'Base Free On Board (FOB) Price');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `capacity_allocation_percent` SET TAGS ('dbx_business_glossary_term' = 'Capacity Allocation Percentage');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `committed_volume_quantity` SET TAGS ('dbx_business_glossary_term' = 'Committed Volume Quantity');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `compliance_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Required');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `destination_port_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Port Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `fob_port_code` SET TAGS ('dbx_business_glossary_term' = 'Free On Board (FOB) Port Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `moq_unit` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Unit');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `moq_unit` SET TAGS ('dbx_value_regex' = 'units|pieces|dozens|cases');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `pricing_tier_structure` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier Structure');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `quality_standard` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^(SS|FW|HO|SP)[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `sustainability_requirement` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Requirement');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `apparel_fashion_ecm`.`sourcing`.`agreement` ALTER COLUMN `volume_unit` SET TAGS ('dbx_value_regex' = 'units|pieces|dozens|cases|pallets');
