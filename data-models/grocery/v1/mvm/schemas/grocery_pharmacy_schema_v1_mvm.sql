-- Schema for Domain: pharmacy | Business: Grocery | Version: v1_mvm
-- Generated on: 2026-05-04 20:42:51

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `grocery_ecm`.`pharmacy` COMMENT 'Prescription management, drug inventory, clinical services, patient counseling, and controlled substance tracking. Manages Rx orders, fills, refills, insurance claims, prior authorizations, DEA compliance reporting, and HIPAA-compliant patient records. Integrates with McKesson pharmacy systems and State Board of Pharmacy licensing data.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `grocery_ecm`.`pharmacy`.`rx_patient` (
    `rx_patient_id` BIGINT COMMENT 'Unique identifier for the pharmacy patient record. Primary key for HIPAA-compliant patient master data distinct from general customer profile.',
    `household_id` BIGINT COMMENT 'Foreign key linking to customer.household. Business justification: Needed to associate prescription fills with household benefit status for SNAP/WIC and demographic analytics.',
    `membership_id` BIGINT COMMENT 'Foreign key linking to loyalty.membership. Business justification: Required for patient‑tier based counseling and loyalty tier reporting; pharmacy tailors medication offers using the members loyalty tier.',
    `pharmacy_location_id` BIGINT COMMENT 'Identifier of the patients preferred pharmacy store location for prescription fills. Used for prescription routing and inventory allocation.',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Patient Health Promotion Enrollment links patients to targeted health campaigns, allowing incentive tracking and compliance reporting.',
    `shopper_id` BIGINT COMMENT 'Link to the general customer profile in the customer domain. Establishes relationship between pharmacy patient and retail customer identity.',
    `address_line_1` STRING COMMENT 'Primary street address line for the pharmacy patient. Required for prescription delivery and patient contact.',
    `address_line_2` STRING COMMENT 'Secondary address line for apartment, suite, or unit number. Optional field for patient address details.',
    `alternate_phone_number` STRING COMMENT 'Secondary contact phone number for the pharmacy patient. Used when primary contact is unavailable.',
    `auto_refill_enrollment_flag` BOOLEAN COMMENT 'Indicates whether the patient is enrolled in automatic prescription refill program. Improves medication adherence.',
    `city` STRING COMMENT 'City name for the pharmacy patient address. Used for prescription delivery routing and patient contact.',
    `counseling_preference` STRING COMMENT 'Patients preferred method for receiving pharmacist counseling on new prescriptions. Supports compliance with State Board of Pharmacy counseling requirements.. Valid values are `in_person|phone|written|declined`',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the pharmacy patient address. Supports international patient records.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pharmacy patient record was first created in the system. Audit trail for record creation.',
    `date_of_birth` DATE COMMENT 'Date of birth of the pharmacy patient. Required for controlled substance age verification per DEA regulations and patient identity verification.',
    `email_address` STRING COMMENT 'Email address for the pharmacy patient. Used for prescription ready notifications and digital communication per patient consent.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `email_notification_consent_flag` BOOLEAN COMMENT 'Indicates whether the patient has consented to receive prescription ready notifications via email.',
    `first_name` STRING COMMENT 'Legal first name of the pharmacy patient as it appears on prescription insurance and identification documents.',
    `gender` STRING COMMENT 'Gender of the pharmacy patient. Used for clinical decision support and drug utilization review (DUR) screening for gender-specific contraindications.. Valid values are `male|female|other|unknown|declined`',
    `hipaa_authorization_date` DATE COMMENT 'Date when the patient signed HIPAA authorization for use and disclosure of protected health information.',
    `hipaa_authorization_status` STRING COMMENT 'Status of the patients HIPAA authorization for use and disclosure of protected health information. Determines permissible information sharing.. Valid values are `authorized|not_authorized|pending|revoked`',
    `last_name` STRING COMMENT 'Legal last name (surname) of the pharmacy patient as it appears on prescription insurance and identification documents.',
    `last_prescription_fill_date` DATE COMMENT 'Date of the most recent prescription fill for this patient. Used for patient retention analysis and inactive patient identification.',
    `medication_history_consent_date` DATE COMMENT 'Date when the patient provided consent for medication history sharing. Used for consent expiration tracking.',
    `medication_history_consent_flag` BOOLEAN COMMENT 'Indicates whether the patient has consented to sharing medication history with external systems for drug utilization review and clinical decision support.',
    `middle_name` STRING COMMENT 'Middle name or initial of the pharmacy patient. Optional field used for patient identification verification.',
    `patient_status` STRING COMMENT 'Current lifecycle status of the pharmacy patient record. Determines whether new prescriptions can be filled for this patient.. Valid values are `active|inactive|deceased|transferred`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the pharmacy patient. Used for prescription ready notifications and patient counseling callbacks.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the pharmacy patient address. Used for prescription delivery and geographic analysis.',
    `preferred_language` STRING COMMENT 'Preferred language for patient counseling and prescription label instructions. Ensures compliance with language access requirements.',
    `primary_care_physician_name` STRING COMMENT 'Name of the patients primary care physician. Used for clinical consultation and prescription verification.',
    `primary_care_physician_phone` STRING COMMENT 'Contact phone number for the patients primary care physician. Used for prescription clarification and prior authorization requests.',
    `primary_insurance_bin` STRING COMMENT 'Six-digit Bank Identification Number (BIN) for the patients primary prescription insurance. Routes electronic claims to the correct processor.. Valid values are `^[0-9]{6}$`',
    `primary_insurance_carrier` STRING COMMENT 'Name of the patients primary prescription insurance carrier. Used for insurance claim adjudication.',
    `primary_insurance_group_number` STRING COMMENT 'Group number for the patients primary prescription insurance plan. Used for insurance eligibility verification.',
    `primary_insurance_member_number` STRING COMMENT 'Member identification number for the patients primary prescription insurance. Required for electronic claim submission.',
    `primary_insurance_pcn` STRING COMMENT 'Processor Control Number (PCN) for the patients primary prescription insurance. Additional routing identifier for claim adjudication.',
    `registration_date` DATE COMMENT 'Date when the patient first registered with the pharmacy. Used for patient tenure analysis and loyalty program eligibility.',
    `state_province` STRING COMMENT 'State or province code for the pharmacy patient address. Required for State Board of Pharmacy jurisdiction determination.',
    `text_notification_consent_flag` BOOLEAN COMMENT 'Indicates whether the patient has consented to receive prescription ready notifications via SMS text message.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the pharmacy patient record was last modified. Audit trail for record changes.',
    CONSTRAINT pk_rx_patient PRIMARY KEY(`rx_patient_id`)
) COMMENT 'HIPAA-compliant master record for pharmacy patients, distinct from the general customer profile. Captures pharmacy-specific patient identity, documented drug allergies and adverse drug reactions (allergen, reaction type, severity, onset date, active/inactive status), medication history consent flags, HIPAA authorization status, primary care physician, insurance eligibility, date of birth for controlled substance age verification, preferred language for counseling, and patient counseling preferences. Owned exclusively by the pharmacy domain as the authoritative patient record for clinical and dispensing workflows. Allergy data supports DUR (Drug Utilization Review) screening for allergy conflicts.';

CREATE OR REPLACE TABLE `grocery_ecm`.`pharmacy`.`prescription` (
    `prescription_id` BIGINT COMMENT 'Unique identifier for the prescription record. Primary key.',
    `drug_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug. Business justification: Prescription should reference the master drug record; removes redundant drug attributes.',
    `insurance_plan_id` BIGINT COMMENT 'Foreign key linking to pharmacy.insurance_plan. Business justification: Prescription needs to capture the patient’s insurance plan for claim processing.',
    `pharmacy_location_id` BIGINT COMMENT 'Reference to the store location where this prescription is on file and can be filled.',
    `prescriber_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prescriber. Business justification: Linking prescription to prescriber master; removes duplicated prescriber details.',
    `rx_patient_id` BIGINT COMMENT 'Reference to the patient for whom this prescription was written. Links to pharmacy_patient master record.',
    `compound_prescription` BOOLEAN COMMENT 'Indicates whether this prescription is for a compounded medication (custom-prepared by the pharmacist) rather than a manufactured product.',
    `controlled_substance_schedule` STRING COMMENT 'DEA schedule classification of the drug if it is a controlled substance (Schedule II, III, IV, V). Non-controlled if not a controlled substance.. Valid values are `schedule_ii|schedule_iii|schedule_iv|schedule_v|non_controlled`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this prescription record was first created in the pharmacy system.',
    `daw_code` STRING COMMENT 'Code indicating whether generic substitution is allowed. 0=substitution allowed, 1=substitution not allowed by prescriber, 2=substitution allowed but patient requested brand, etc. [ENUM-REF-CANDIDATE: 0|1|2|3|4|5|6|7|8|9 — 10 candidates stripped; promote to reference product]',
    `days_supply` STRING COMMENT 'The number of days the prescribed quantity is intended to last based on the sig directions. Used for insurance claims and refill calculations.',
    `diagnosis_code` STRING COMMENT 'ICD-10 diagnosis code indicating the medical condition for which this prescription was written. Required for some insurance claims and clinical documentation.. Valid values are `^[A-Z][0-9]{2}(.[0-9]{1,4})?$`',
    `expiration_date` DATE COMMENT 'The date after which this prescription can no longer be filled or refilled. Calculated based on issue date and state/federal regulations.',
    `generic_available` BOOLEAN COMMENT 'Indicates whether a generic equivalent is available for this drug. Used for substitution decisions and cost savings.',
    `issue_date` DATE COMMENT 'The date the prescription was written by the prescriber. Critical for determining prescription validity and expiration.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this prescription record was last updated in the pharmacy system.',
    `notes` STRING COMMENT 'Free-text notes entered by pharmacy staff regarding this prescription. May include clarifications, patient counseling points, or special handling instructions.',
    `origin` STRING COMMENT 'The method by which the prescription was received by the pharmacy (written paper, electronic, phone, fax, or transferred from another pharmacy).. Valid values are `written|electronic|phone|fax|transfer_in`',
    `pharmacist_verification_timestamp` TIMESTAMP COMMENT 'Date and time when the pharmacist completed verification of this prescription.',
    `pharmacist_verified_by` STRING COMMENT 'Name or identifier of the pharmacist who verified this prescription for accuracy, drug interactions, and appropriateness.',
    `prescription_status` STRING COMMENT 'Current lifecycle status of the prescription. Active=available for filling, Filled=all fills completed, Expired=past expiration date, Cancelled=voided by prescriber or pharmacist, Transferred Out=moved to another pharmacy, Discontinued=stopped by prescriber.. Valid values are `active|filled|expired|cancelled|transferred_out|discontinued`',
    `prior_authorization_number` STRING COMMENT 'The authorization number provided by the insurance company or PBM approving coverage for this prescription.',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether insurance prior authorization is required before this prescription can be filled and reimbursed.',
    `quantity_prescribed` DECIMAL(18,2) COMMENT 'The quantity of the drug prescribed by the prescriber. May be in units, tablets, milliliters, or other appropriate measure.',
    `quantity_unit` STRING COMMENT 'The unit of measure for the prescribed quantity (tablets, milliliters, units, etc.). [ENUM-REF-CANDIDATE: tablet|capsule|ml|unit|gram|each|package — 7 candidates stripped; promote to reference product]',
    `refills_authorized` STRING COMMENT 'The number of refills authorized by the prescriber. Zero indicates no refills allowed. Controlled substances have specific refill restrictions.',
    `refills_remaining` STRING COMMENT 'The number of refills remaining on this prescription. Decremented each time a refill is dispensed.',
    `rx_number` STRING COMMENT 'The externally-known prescription number assigned by the pharmacy system. Unique identifier used for prescription tracking, refills, and patient communication.. Valid values are `^[A-Z0-9]{7,15}$`',
    `sig` STRING COMMENT 'The prescribers directions for how the patient should take the medication. Printed on the prescription label.',
    `therapeutic_class` STRING COMMENT 'The therapeutic classification of the drug (e.g., antibiotic, antihypertensive, analgesic). Used for clinical decision support and drug utilization review.',
    `transfer_destination_pharmacy` STRING COMMENT 'Name and identifier of the pharmacy to which this prescription was transferred out, if applicable.',
    `transfer_source_pharmacy` STRING COMMENT 'Name and identifier of the pharmacy from which this prescription was transferred in, if applicable.',
    CONSTRAINT pk_prescription PRIMARY KEY(`prescription_id`)
) COMMENT 'Core master record for each prescription order written by a prescriber for a patient. Captures Rx number, prescriber NPI, drug NDC, prescribed quantity, days supply, refills authorized, sig (directions), DAW (Dispense As Written) code, prescription origin (written, electronic, phone, fax), issue date, expiration date, and controlled substance schedule (DEA Schedule II–V). Serves as the authoritative Rx record integrating with McKesson Pharmacy Systems.';

CREATE OR REPLACE TABLE `grocery_ecm`.`pharmacy`.`rx_fill` (
    `rx_fill_id` BIGINT COMMENT 'Unique identifier for each individual prescription fill or refill event. Primary key for the rx_fill product.',
    `drug_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug. Business justification: RX fill records should reference drug master; NDC is redundant.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Pharmacy revenue recognition requires mapping each rx fill to a fiscal period for period-close reporting, DIR fee accruals, and SOX-compliant revenue reconciliation. Grocery pharmacy finance teams rep',
    `insurance_plan_id` BIGINT COMMENT 'Foreign key linking to pharmacy.insurance_plan. Business justification: rx_fill is the dispensing event that captures the actual insurance adjudication outcome (copay_amount, insurance_paid_amount, adjudication_result). The insurance plan used at fill time may differ from',
    `pharmacy_location_id` BIGINT COMMENT 'Identifier of the store location where this prescription was filled. Links to the store master data in the Store domain.',
    `prescription_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prescription. Business justification: Each fill belongs to a single prescription; adding prescription_id FK enables parent‑child relationship and eliminates need for duplicate prescription details on fill.',
    `price_override_id` BIGINT COMMENT 'Foreign key linking to pricing.price_override. Business justification: Grocery pharmacy cash-price programs and price-match policies require pharmacists to apply manual price overrides at dispensing. Linking rx_fill to price_override enables pharmacy pricing compliance a',
    `promotion_redemption_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_redemption. Business justification: Required for Prescription Fill Discount Tracking Report to reconcile discounts applied via digital coupons to each pharmacy fill.',
    `rx_order_id` BIGINT COMMENT 'Foreign key linking to product.rx_order. Business justification: rx_fill is the dispensing event that fulfills an rx_order. Linking rx_fill back to rx_order enables omnichannel pharmacy order tracking, DEA dispensing audit trails, and reconciliation of insurance cl',
    `rx_patient_id` BIGINT COMMENT 'Identifier of the patient for whom this prescription was filled. Links to pharmacy_patient in the Customer domain for HIPAA-compliant patient records.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: COST/REBATE: Record the supplier that fulfilled each fill to allocate costs, calculate rebates, and satisfy payer/regulatory reporting.',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_transaction. Business justification: REQUIRED: Daily financial reconciliation report matches each prescription fill (rx_fill) to its POS payment transaction to verify copay collection and insurance payments.',
    `adjudication_result` STRING COMMENT 'The outcome of the insurance claim adjudication for this fill. Indicates whether the claim was paid, rejected, reversed, or is pending.. Valid values are `paid|rejected|reversed|pending`',
    `controlled_substance_schedule` STRING COMMENT 'The DEA controlled substance schedule classification of the dispensed drug. Required for DEA compliance reporting and inventory tracking.. Valid values are `schedule_2|schedule_3|schedule_4|schedule_5|non_controlled`',
    `copay_amount` DECIMAL(18,2) COMMENT 'The patient copayment amount collected or due for this fill after insurance adjudication. Expressed in US dollars.',
    `counseling_accepted_flag` BOOLEAN COMMENT 'Boolean indicator of whether the patient accepted the counseling offer. True indicates patient received counseling; false indicates patient declined.',
    `counseling_method` STRING COMMENT 'The method by which patient counseling was delivered (in-person, phone, written materials, video consultation) or declined.. Valid values are `in_person|phone|written|video|declined`',
    `counseling_offered_flag` BOOLEAN COMMENT 'Boolean indicator of whether patient counseling was offered by the pharmacist for this fill. OBRA 90 requires counseling offer for all new prescriptions.',
    `counseling_topics_covered` STRING COMMENT 'Free-text description of the topics covered during patient counseling (e.g., dosing instructions, side effects, storage, interactions). Empty if counseling was declined.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fill record was first created in the pharmacy system. Used for audit trail and data lineage.',
    `days_supply` STRING COMMENT 'The number of days the dispensed quantity is intended to last based on the prescribed dosing instructions. Used for refill timing and insurance adjudication.',
    `dea_form_222_number` STRING COMMENT 'The DEA Form 222 order form number if this fill involved a Schedule II controlled substance requiring special ordering documentation. Empty for non-Schedule II drugs.',
    `dispensed_quantity` DECIMAL(18,2) COMMENT 'The quantity of medication dispensed for this fill, measured in the drugs unit of measure (tablets, capsules, milliliters, etc.).',
    `dispensing_pharmacist_npi` STRING COMMENT 'The 10-digit National Provider Identifier of the licensed pharmacist who dispensed this fill. Cross-domain reference to workforce pharmacist credential data.. Valid values are `^[0-9]{10}$`',
    `dur_allergy_conflict_alert` STRING COMMENT 'Description of any allergy conflict alerts (dispensed drug conflicts with patients documented allergies) generated during DUR screening. Empty if no conflicts detected.',
    `dur_drug_interaction_alert` STRING COMMENT 'Description of any drug-drug interaction alerts generated during DUR screening. Empty if no interactions detected.',
    `dur_override_flag` BOOLEAN COMMENT 'Boolean indicator of whether the pharmacist overrode any DUR alerts to proceed with dispensing. True indicates override occurred.',
    `dur_override_reason_code` STRING COMMENT 'The standardized reason code documenting why the pharmacist overrode DUR alerts. Required when dur_override_flag is true.',
    `dur_screening_performed_flag` BOOLEAN COMMENT 'Boolean indicator of whether Drug Utilization Review screening was performed for this fill. DUR checks for drug-drug interactions, therapeutic duplication, and allergy conflicts.',
    `dur_therapeutic_duplication_alert` STRING COMMENT 'Description of any therapeutic duplication alerts (patient taking multiple drugs in same therapeutic class) generated during DUR screening. Empty if no duplication detected.',
    `fill_date` DATE COMMENT 'The date the prescription was dispensed to the patient. This is the principal business event timestamp for the fill transaction.',
    `fill_number` STRING COMMENT 'Sequential number indicating which fill this is for the prescription (1 for initial fill, 2+ for refills). Used to track refill count against authorized refills.',
    `fill_status` STRING COMMENT 'Current lifecycle status of this fill event. Tracks the fill through dispensing workflow from initiation to completion or cancellation.. Valid values are `filled|partial|on_hold|cancelled|transferred_out|transferred_in`',
    `fill_timestamp` TIMESTAMP COMMENT 'Precise date and time when the prescription was dispensed and the fill transaction was completed in the pharmacy system.',
    `insurance_paid_amount` DECIMAL(18,2) COMMENT 'The amount paid by the patients insurance plan for this fill after adjudication. Excludes patient copay.',
    `label_printed_flag` BOOLEAN COMMENT 'Boolean indicator of whether the prescription label was printed for this fill. True indicates label was printed and affixed to the container.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fill record was last modified in the pharmacy system. Used for audit trail and change tracking.',
    `patient_pickup_confirmed_flag` BOOLEAN COMMENT 'Boolean indicator of whether the patient (or authorized representative) picked up the filled prescription. True indicates pickup was confirmed.',
    `pickup_timestamp` TIMESTAMP COMMENT 'Date and time when the patient picked up the filled prescription. Null if not yet picked up.',
    `quantity_unit` STRING COMMENT 'The unit of measure for the dispensed quantity (e.g., tablets, capsules, milliliters). [ENUM-REF-CANDIDATE: tablet|capsule|ml|gm|unit|patch|inhaler|vial|syringe|suppository — 10 candidates stripped; promote to reference product]',
    `rejection_code` STRING COMMENT 'The NCPDP rejection code returned by the insurance processor if the claim was rejected. Empty if claim was paid.',
    `rems_acknowledgment_flag` BOOLEAN COMMENT 'Boolean indicator of whether REMS program requirements were acknowledged and documented for drugs with FDA-mandated REMS. True indicates REMS compliance documented.',
    `rx_number` STRING COMMENT 'The externally-known prescription number assigned by the pharmacy system. This is the business identifier printed on the label and used by patients and pharmacists to reference the prescription.. Valid values are `^[A-Z0-9]{7,15}$`',
    `total_price` DECIMAL(18,2) COMMENT 'The total price charged for this fill before insurance adjustments. Represents the pharmacys usual and customary price.',
    `transfer_date` DATE COMMENT 'The date the prescription transfer occurred. Null if no transfer.',
    `transfer_pharmacy_ncpdp` STRING COMMENT 'The 7-digit NCPDP provider ID of the pharmacy involved in the transfer (originating pharmacy for transferred_in, receiving pharmacy for transferred_out). Empty if no transfer.. Valid values are `^[0-9]{7}$`',
    `transfer_type` STRING COMMENT 'Indicates whether this fill is associated with a prescription transfer. None for normal fills, transferred_in for prescriptions received from another pharmacy, transferred_out for prescriptions sent to another pharmacy.. Valid values are `none|transferred_in|transferred_out`',
    `will_call_bin_assignment` STRING COMMENT 'The physical bin or location identifier where the filled prescription is stored in the pharmacy will-call area awaiting patient pickup.. Valid values are `^[A-Z0-9]{1,10}$`',
    CONSTRAINT pk_rx_fill PRIMARY KEY(`rx_fill_id`)
) COMMENT 'Transactional record capturing each individual dispensing event (fill or refill) against a prescription. Tracks fill number, fill date, dispensed NDC, dispensed quantity, days supply dispensed, dispensing pharmacist NPI (cross-domain reference to workforce pharmacist credential), fill status (filled, partial, on-hold, cancelled, transferred), copay amount, adjudication result, label printed flag, patient pickup confirmation, will-call bin assignment, DUR screening results (drug-drug interaction alerts, therapeutic duplication, allergy conflicts, override decisions, override reason codes), patient counseling documentation (counseling offered, accepted/declined, method, topics covered, REMS acknowledgment), and transfer metadata when applicable. Each fill is a distinct business event with its own lifecycle. Integrates with McKesson dispensing workflow.';

CREATE OR REPLACE TABLE `grocery_ecm`.`pharmacy`.`drug` (
    `drug_id` BIGINT COMMENT 'Unique identifier for the drug item in the pharmacy system. Primary key.',
    `category_id` BIGINT COMMENT 'Foreign key linking to assortment.category. Business justification: Required for category‑level sales, margin, and inventory reports; enables linking each drug to its retail category for planogram and GMROI calculations.',
    `compliance_record_id` BIGINT COMMENT 'Foreign key linking to vendor.compliance_record. Business justification: FDA and DEA regulatory requirements mandate pharmacies verify supplier compliance (FDA registration, HACCP, DEA authorization) for each drug sourced. Linking drug to supplier compliance_record support',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_offer. Business justification: Drug Discount Promotion Management links each drug to its promotional offer, enabling eligibility checks and discount application during checkout.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: PROCUREMENT: Track which supplier provides each drug for purchase orders, compliance audits, and recall management – essential for supply chain visibility.',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to vendor.trade_agreement. Business justification: Pharmacy drug procurement and formulary management are governed by supplier trade agreements. Rebate reconciliation, cost validation, and formulary negotiations require knowing which trade agreement c',
    `vendor_item_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_item. Business justification: Drug procurement requires linking each drugs NDC to the suppliers vendor catalog entry to validate case pack quantities, unit costs, lead times, and ordering multiples used in drug inventory repleni',
    `awp` DECIMAL(18,2) COMMENT 'Published benchmark price representing the average price at which wholesalers sell to pharmacies. Used as a basis for reimbursement calculations and pricing negotiations. Expressed in USD.',
    `black_box_warning_indicator` BOOLEAN COMMENT 'Flag indicating whether the drug carries an FDA black box warning for serious or life-threatening risks. Triggers mandatory patient counseling and documentation.',
    `brand_name` STRING COMMENT 'Proprietary trademark name assigned by the manufacturer. Null for generic drugs. Used for brand-specific prescriptions and patient preference tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the drug record was first created in the pharmacy system. Used for audit trails and data lineage tracking.',
    `dea_schedule` STRING COMMENT 'Controlled substance classification (Schedule II, III, IV, V, or unscheduled). Determines dispensing restrictions, inventory controls, and DEA reporting requirements. Schedule II drugs have highest abuse potential and strictest controls.. Valid values are `schedule_ii|schedule_iii|schedule_iv|schedule_v|unscheduled`',
    `desi_status` STRING COMMENT 'FDA classification indicating whether the drug has been determined to be effective for its labeled indications under the DESI program. Used for formulary decisions and clinical protocols.. Valid values are `effective|less_than_effective|not_reviewed`',
    `discontinuation_date` DATE COMMENT 'Date the drug was discontinued by the manufacturer or removed from the pharmacy formulary. Used for inventory phase-out and therapeutic substitution planning.',
    `dosage_form` STRING COMMENT 'Physical form in which the drug is administered (e.g., tablet, capsule, injection, topical). Critical for dispensing instructions and patient counseling. [ENUM-REF-CANDIDATE: tablet|capsule|solution|suspension|injection|cream|ointment|gel|patch|inhaler|suppository|powder|spray|lozenge|film — promote to reference product]',
    `drug_name` STRING COMMENT 'Full proprietary or non-proprietary name of the drug as it appears on the label. Used for prescription filling and patient counseling.',
    `drug_status` STRING COMMENT 'Current lifecycle status of the drug in the pharmacy system. Active drugs are available for dispensing; discontinued drugs are no longer manufactured; recalled drugs must be removed from inventory; on backorder drugs are temporarily unavailable.. Valid values are `active|discontinued|recalled|on_backorder|obsolete`',
    `drug_type` STRING COMMENT 'Classification indicating whether the drug requires a prescription (Rx), is available over-the-counter (OTC), or is a pharmacy-compounded preparation. Determines dispensing workflow and regulatory requirements.. Valid values are `prescription|otc|compound`',
    `effective_date` DATE COMMENT 'Date the drug record became active in the pharmacy system and available for dispensing. Used for audit trails and historical analysis.',
    `expiration_date` DATE COMMENT 'Date after which the drug should not be dispensed or used. Critical for inventory rotation (FIFO) and patient safety. Null for drug master records; populated at lot level in inventory.',
    `formulary_status` STRING COMMENT 'Indicates whether the drug is included in the pharmacys formulary and any restrictions (e.g., preferred, non-preferred, requires prior authorization). Drives reimbursement and clinical decision support.. Valid values are `preferred|non_preferred|excluded|prior_authorization_required`',
    `generic_name` STRING COMMENT 'United States Adopted Name (USAN) or international nonproprietary name (INN) for the active pharmaceutical ingredient. Used for therapeutic substitution and formulary management.',
    `gpi` STRING COMMENT '14-digit hierarchical classification code that groups drugs by therapeutic class, generic ingredient, dosage form, and strength. Used for claims processing and drug utilization review.. Valid values are `^[0-9]{14}$`',
    `hazardous_drug_indicator` BOOLEAN COMMENT 'Flag indicating whether the drug is classified as hazardous and requires special handling, storage, and disposal procedures per NIOSH guidelines. Critical for employee safety and OSHA compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the drug record. Used for change tracking and data synchronization with McKesson pharmacy systems.',
    `manufacturer_name` STRING COMMENT 'Name of the pharmaceutical company that manufactures or distributes the drug product. Used for recall tracking and vendor management.',
    `multi_source_indicator` STRING COMMENT 'Indicates whether the drug is a brand-name product, a generic equivalent available from multiple manufacturers, or a single-source product with no generic alternatives. Used for generic substitution and cost optimization.. Valid values are `brand|generic|single_source`',
    `ndc` STRING COMMENT 'FDA-assigned unique 10-digit or 11-digit identifier for drug products at the package level. Format: labeler code, product code, package code. Required for prescription claims adjudication and DEA reporting.. Valid values are `^[0-9]{5}-[0-9]{4}-[0-9]{2}$|^[0-9]{5}-[0-9]{3}-[0-9]{2}$|^[0-9]{4}-[0-9]{4}-[0-9]{2}$`',
    `orange_book_code` STRING COMMENT 'FDA code indicating therapeutic equivalence rating (e.g., AB, BX). AA or AB ratings indicate generic substitutability. Used for generic substitution decisions.',
    `package_size` STRING COMMENT 'Quantity of dosage units in the package (e.g., 30 tablets, 100 mL, 1 vial). Includes numeric value and unit. Used for inventory management and days supply calculations.',
    `refrigeration_required_indicator` BOOLEAN COMMENT 'Flag indicating whether the drug must be stored under refrigerated conditions. Used for inventory placement and cold chain monitoring.',
    `rems_indicator` BOOLEAN COMMENT 'Flag indicating whether the drug is subject to FDA-mandated REMS program requiring special monitoring, patient education, or restricted distribution. Affects dispensing workflow and documentation requirements.',
    `repackaged_indicator` BOOLEAN COMMENT 'Flag indicating whether the drug has been repackaged from bulk into smaller units by a repackager. Affects NDC assignment and labeling requirements.',
    `route_of_administration` STRING COMMENT 'Method by which the drug is introduced into the body (e.g., oral, topical, intravenous). Used for patient counseling and clinical decision support. [ENUM-REF-CANDIDATE: oral|topical|intravenous|intramuscular|subcutaneous|inhalation|rectal|ophthalmic|otic|nasal|transdermal|sublingual|buccal — promote to reference product]. Valid values are `oral|topical|intravenous|intramuscular|subcutaneous|inhalation`',
    `storage_requirements` STRING COMMENT 'Temperature and environmental conditions required to maintain drug stability and efficacy (e.g., refrigerated 2-8°C, controlled room temperature 20-25°C, frozen). Critical for inventory management and cold chain compliance.. Valid values are `room_temperature|refrigerated|frozen|controlled_room_temperature`',
    `strength` STRING COMMENT 'Potency or concentration of the active ingredient (e.g., 500mg, 10mg/mL, 0.5%). Includes numeric value and unit. Required for accurate dispensing and dosing calculations.',
    `tall_man_lettering` STRING COMMENT 'Drug name with mixed-case lettering to highlight differences between look-alike drug names and reduce medication errors (e.g., hydrOXYzine vs hydrALAzine). Used for labeling and clinical alerts.',
    `therapeutic_class` STRING COMMENT 'Clinical category based on the drugs therapeutic use or pharmacological action (e.g., antihypertensive, antibiotic, analgesic). Used for formulary management and therapeutic interchange.',
    `unit_of_measure` STRING COMMENT 'Standard unit for inventory tracking and dispensing (e.g., each, bottle, vial, tube). Used for stock counts and reorder calculations.. Valid values are `each|bottle|vial|tube|box|package`',
    `wac` DECIMAL(18,2) COMMENT 'Manufacturers list price to wholesalers before discounts or rebates. Used for cost analysis and formulary decisions. Expressed in USD.',
    CONSTRAINT pk_drug PRIMARY KEY(`drug_id`)
) COMMENT 'Pharmacy-specific drug item master capturing NDC (National Drug Code) at package level, drug name, generic name, brand name, manufacturer, dosage form, strength, route of administration, DEA schedule (II-V or unscheduled), therapeutic class, GPI (Generic Product Identifier), drug type (Rx, OTC, compound), multi-source indicator (brand, generic, single-source), storage requirements (refrigerated, controlled room temp, freezer), unit of measure, package size, AWP (Average Wholesale Price), WAC (Wholesale Acquisition Cost), and DESI (Drug Efficacy Study Implementation) status. Complements the product domains general item catalog with pharmacy-specific clinical and pricing attributes required for dispensing and claims adjudication.';

CREATE OR REPLACE TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` (
    `drug_inventory_id` BIGINT COMMENT 'Unique identifier for the drug inventory record. Primary key for the drug inventory position at a specific pharmacy location.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Drug inventory shrink, expired drug write-offs, and controlled substance loss postings must be allocated to a pharmacy cost center for departmental accountability and budget variance reporting. drug_i',
    `cost_schedule_id` BIGINT COMMENT 'Foreign key linking to vendor.cost_schedule. Business justification: Drug inventory acquisition cost validation and AP reconciliation require linking each inventory record to the active vendor cost schedule. The denormalized acquisition_cost on drug_inventory must be t',
    `drug_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug. Business justification: Drug inventory should reference the drug master; NDC is stored in drug.',
    `fixture_id` BIGINT COMMENT 'Foreign key linking to assortment.fixture. Business justification: Pharmacy compliance operations require knowing which physical fixture (refrigerated unit, DEA vault) holds each drug inventory lot. Supports refrigeration monitoring, DEA biennial vault audits, and fi',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Links inventory valuation to the GL account used for inventory accounting, enabling accurate COGS and balance sheet postings.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Drug inventory records must link to lot/batch for USP and FDA expiration/recall compliance, FIFO rotation, and DEA biennial count reconciliation. lot_number on drug_inventory is a denormalized string;',
    `pharmacy_location_id` BIGINT COMMENT 'Identifier of the pharmacy location where this drug inventory is held. Links to the store or pharmacy facility.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Pharmacy drug inventory is physically stored in specific controlled locations (DEA vault, refrigerator, controlled substance cage). Linking to storage_location enables temperature zone compliance, cap',
    `supplier_id` BIGINT COMMENT 'Identifier of the wholesaler or manufacturer who supplied this drug lot. Typically McKesson for most pharmacy inventory.',
    `controlled_substance_schedule` STRING COMMENT 'DEA controlled substance classification schedule (I through V) or non-controlled designation. Determines vault storage requirements and perpetual inventory tracking obligations.. Valid values are `SCHEDULE_I|SCHEDULE_II|SCHEDULE_III|SCHEDULE_IV|SCHEDULE_V|NON_CONTROLLED`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this drug inventory record was first created in the system. Audit trail for inventory position establishment.',
    `dea_biennial_count_flag` BOOLEAN COMMENT 'Indicates whether this controlled substance inventory was included in the most recent DEA-required biennial physical inventory count. Required for Schedule II-V substances.',
    `expiration_date` DATE COMMENT 'Date when the drug lot expires and can no longer be dispensed. Critical for FIFO rotation and inventory write-off management.',
    `fifo_rotation_status` STRING COMMENT 'Current rotation status for this lot based on expiration date proximity. Drives dispensing priority and markdown/disposal workflows.. Valid values are `CURRENT|NEAR_EXPIRY|EXPIRED|RECALLED`',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether this drug is classified as hazardous material requiring special handling and disposal procedures. True for chemotherapy agents and certain biologics.',
    `inventory_status` STRING COMMENT 'Current lifecycle status of this drug inventory position. Determines whether inventory is available for dispensing or restricted.. Valid values are `AVAILABLE|ALLOCATED|QUARANTINED|EXPIRED|RECALLED|DISPOSED`',
    `inventory_value` DECIMAL(18,2) COMMENT 'Total dollar value of on-hand quantity at acquisition cost. Calculated as on_hand_quantity multiplied by acquisition_cost for balance sheet reporting.',
    `last_adjustment_date` DATE COMMENT 'Date of the most recent perpetual inventory adjustment. Tracks when variances were reconciled.',
    `last_dispense_date` DATE COMMENT 'Date when this drug lot was last dispensed to a patient. Used for slow-mover identification and expiration risk assessment.',
    `last_physical_count_date` DATE COMMENT 'Date of the most recent physical inventory count for this drug and lot. DEA requires biennial counts for controlled substances; best practice is more frequent.',
    `last_physical_count_quantity` DECIMAL(18,2) COMMENT 'Quantity recorded during the last physical inventory count. Used to calculate shrink and perpetual inventory variance.',
    `last_receipt_date` DATE COMMENT 'Date when this drug lot was last received into inventory from a supplier delivery. Used for aging analysis and supplier performance tracking.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this drug inventory record was most recently modified. Tracks the last receipt, dispense, adjustment, or status change event.',
    `on_hand_quantity` DECIMAL(18,2) COMMENT 'Current physical quantity of the drug available in inventory at this pharmacy location. Updated by receipts, dispensing, adjustments, and physical counts.',
    `par_level` DECIMAL(18,2) COMMENT 'Target maximum inventory level for this drug at this location. Used to prevent overstocking and manage working capital.',
    `perpetual_adjustment_quantity` DECIMAL(18,2) COMMENT 'Net quantity adjustment applied to reconcile perpetual inventory with physical count. Positive for found inventory, negative for missing inventory.',
    `recall_date` DATE COMMENT 'Date when this drug lot was placed under recall by the FDA or manufacturer. Null if no recall has been issued.',
    `recall_status` STRING COMMENT 'Current recall status for this drug lot. Recalled or quarantined inventory cannot be dispensed and must be segregated pending return or destruction.. Valid values are `ACTIVE|RECALLED|QUARANTINED|CLEARED`',
    `refrigeration_required_flag` BOOLEAN COMMENT 'Indicates whether this drug requires cold chain storage between 2-8 degrees Celsius. True for vaccines, biologics, and temperature-sensitive medications.',
    `reorder_point` DECIMAL(18,2) COMMENT 'Minimum inventory level that triggers an automated reorder to McKesson distribution. Set based on lead time and average daily dispensing rate.',
    `reorder_quantity` DECIMAL(18,2) COMMENT 'Standard quantity to order when inventory falls below reorder point. Optimized for order economics and shelf space constraints.',
    `shrink_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity lost to theft, damage, or spoilage since last physical count. Tracked separately for financial reconciliation and loss prevention analysis.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the on-hand quantity. Typically each (EA), box (BX), bottle (BTL), or other pharmaceutical packaging unit. [ENUM-REF-CANDIDATE: EA|BX|BTL|PKG|VIAL|TUBE|INHALER|PATCH|SYRINGE — 9 candidates stripped; promote to reference product]',
    `vault_storage_flag` BOOLEAN COMMENT 'Indicates whether this drug must be stored in a secure controlled substance vault. True for Schedule II narcotics and high-risk controlled substances.',
    `will_call_bin_flag` BOOLEAN COMMENT 'Indicates whether this inventory is allocated to a will-call bin for a specific patient pickup. True when prescription is filled and awaiting customer collection.',
    CONSTRAINT pk_drug_inventory PRIMARY KEY(`drug_inventory_id`)
) COMMENT 'Real-time and historical drug inventory positions at the pharmacy location level, distinct from the general store inventory domain which handles grocery/GM stock. Tracks on-hand quantity by NDC and lot number, expiration date, reorder point, reorder quantity, par level, bin location within pharmacy, controlled substance vault flag, FIFO rotation status, shrink quantity, last physical count date, and perpetual inventory adjustments. Supports DEA controlled substance inventory reconciliation (biennial and perpetual), State Board of Pharmacy compliance reporting, will-call bin management, and automated reorder triggering to McKesson distribution. Pharmacy procurement orders are managed by the supply domain; this product owns position and count data only.';

CREATE OR REPLACE TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` (
    `insurance_plan_id` BIGINT COMMENT 'Unique identifier for the pharmacy benefit insurance plan, manufacturer copay assistance program, or patient assistance program (PAP) card. Primary key.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Different insurance plan types (Medicare Part D, Medicaid, commercial) post pharmacy revenue to distinct GL accounts for regulatory reporting and financial statement segmentation. Grocery pharmacy fin',
    `payer_id` BIGINT COMMENT 'Foreign key linking to pharmacy.payer. Business justification: Each insurance_plan is administered by a payer or PBM (Pharmacy Benefit Manager). insurance_plan currently stores pbm_name as a denormalized string. Adding payer_id FK normalizes this relationship, en',
    `bin` STRING COMMENT 'Six-digit Bank Identification Number used to route pharmacy claims to the correct Pharmacy Benefit Manager (PBM) processor. Required for all electronic adjudication.. Valid values are `^[0-9]{6}$`',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'Percentage of drug cost the patient is responsible for after deductible is met, if the plan uses coinsurance instead of fixed copays. Expressed as a percentage (e.g., 20.00 for 20%).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this insurance plan record was first created in the pharmacy system. Used for audit trail and data lineage tracking.',
    `deductible_applies` BOOLEAN COMMENT 'Indicates whether the plan deductible must be met before prescription drug benefits are available. True if deductible applies to pharmacy claims.',
    `eligible_ndc_list` STRING COMMENT 'Comma-separated list of National Drug Code (NDC) numbers eligible for coverage under this manufacturer copay assistance or patient assistance program. Applicable only for manufacturer programs.',
    `formulary_effective_date` DATE COMMENT 'Date when the current formulary version becomes active for this plan. Used to determine which coverage rules apply to prescriptions filled on or after this date.',
    `formulary_version` STRING COMMENT 'Version identifier for the drug formulary associated with this plan. Formularies are updated periodically to reflect coverage changes, tier assignments, and utilization management rules.',
    `group_number` STRING COMMENT 'Employer or sponsor group identifier that segments members under a common benefit design. Used for eligibility verification and benefit determination.',
    `hipaa_compliant` BOOLEAN COMMENT 'Indicates whether this plan meets HIPAA privacy and security requirements for protected health information (PHI) handling. All commercial and government plans must be compliant.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this insurance plan record was last modified. Used for audit trail and change tracking.',
    `mail_order_available` BOOLEAN COMMENT 'Indicates whether this plan offers mail order pharmacy services for maintenance medications, typically at lower copays or extended days supply.',
    `manufacturer_name` STRING COMMENT 'Name of the pharmaceutical manufacturer sponsoring the copay assistance or patient assistance program. Applicable only for manufacturer_coupon and patient_assistance_program plan types.',
    `max_benefit_amount` DECIMAL(18,2) COMMENT 'Maximum total dollar amount the manufacturer copay assistance program will cover over the program period (e.g., annual cap). Applicable only for manufacturer coupon programs. Amount in USD.',
    `medicaid_plan_number` STRING COMMENT 'State-assigned Medicaid plan identifier for Medicaid managed care plans. Required for Medicaid plan types for state reporting and reimbursement.',
    `medicare_part_d_contract_number` STRING COMMENT 'CMS-assigned contract identifier for Medicare Part D plans. Required for all Medicare Part D plan types for regulatory reporting and reconciliation.',
    `network_participation_status` STRING COMMENT 'Indicates the pharmacys participation status in this plans network. Determines reimbursement rates and patient cost-sharing. Not applicable for manufacturer coupon programs.. Valid values are `in_network|out_of_network|preferred_network|limited_network|not_applicable`',
    `out_of_pocket_max_amount` DECIMAL(18,2) COMMENT 'Maximum annual out-of-pocket amount the patient is responsible for under this plan. Once reached, the plan covers 100% of eligible drug costs. Amount in USD.',
    `pcn` STRING COMMENT 'Processor Control Number used in conjunction with BIN to further route claims to specific plan segments or processing queues within a PBM system.',
    `per_fill_cap_amount` DECIMAL(18,2) COMMENT 'Maximum dollar amount the manufacturer copay assistance program will cover per individual prescription fill. Applicable only for manufacturer coupon programs. Amount in USD.',
    `plan_effective_date` DATE COMMENT 'Date when this insurance plan or assistance program becomes active and eligible for claim adjudication.',
    `plan_name` STRING COMMENT 'Human-readable name of the insurance plan, copay assistance program, or patient assistance program as displayed to pharmacy staff and patients.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the insurance plan or assistance program in the pharmacy system. Determines whether the plan can be used for claim adjudication.. Valid values are `active|inactive|suspended|pending_activation`',
    `plan_termination_date` DATE COMMENT 'Date when this insurance plan or assistance program is no longer active. Null for plans with no scheduled end date.',
    `plan_type` STRING COMMENT 'Classification of the insurance plan or assistance program type. Determines regulatory requirements, billing rules, and eligibility criteria.. Valid values are `commercial|medicare_part_d|medicaid|tricare|manufacturer_coupon|patient_assistance_program`',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether this plan requires prior authorization approval from the PBM before dispensing certain medications. True if prior auth is a plan-level requirement.',
    `program_expiration_date` DATE COMMENT 'Date when the manufacturer copay assistance or patient assistance program expires and is no longer valid for claim adjudication. Applicable only for manufacturer programs.',
    `quantity_limit_enforced` BOOLEAN COMMENT 'Indicates whether this plan enforces quantity limits on prescription fills (e.g., maximum days supply, maximum units per fill).',
    `specialty_pharmacy_required` BOOLEAN COMMENT 'Indicates whether specialty medications under this plan must be dispensed through designated specialty pharmacy networks.',
    `step_therapy_required` BOOLEAN COMMENT 'Indicates whether this plan enforces step therapy protocols requiring patients to try lower-cost alternatives before covering higher-tier medications.',
    `tier_1_copay_amount` DECIMAL(18,2) COMMENT 'Patient copayment amount for Tier 1 (typically preferred generic) drugs. Amount in USD.',
    `tier_2_copay_amount` DECIMAL(18,2) COMMENT 'Patient copayment amount for Tier 2 (typically non-preferred generic or preferred brand) drugs. Amount in USD.',
    `tier_3_copay_amount` DECIMAL(18,2) COMMENT 'Patient copayment amount for Tier 3 (typically non-preferred brand) drugs. Amount in USD.',
    `tier_4_copay_amount` DECIMAL(18,2) COMMENT 'Patient copayment amount for Tier 4 (typically specialty or high-cost) drugs. Amount in USD.',
    `tier_5_copay_amount` DECIMAL(18,2) COMMENT 'Patient copayment amount for Tier 5 (typically ultra-specialty or limited distribution) drugs. Amount in USD.',
    CONSTRAINT pk_insurance_plan PRIMARY KEY(`insurance_plan_id`)
) COMMENT 'Master record for pharmacy benefit insurance plans, manufacturer copay assistance programs, and patient assistance program (PAP) cards accepted at the pharmacy. Captures BIN (Bank Identification Number), PCN (Processor Control Number), group number, plan name, PBM (Pharmacy Benefit Manager) name, plan type (commercial, Medicare Part D, Medicaid, TRICARE, manufacturer_coupon, PAP), formulary tier structure (Tier 1 generic through Tier 5 specialty), coverage rules (covered, non-covered, prior auth required, step therapy required, quantity limit), copay amount by tier, formulary version effective date, prior authorization requirements, step therapy rules, network participation status, and for coupon programs: maximum benefit amount, per-fill cap, eligible NDCs, and program expiration. Used for adjudication routing, eligibility verification, and real-time formulary lookup during prescription processing.';

CREATE OR REPLACE TABLE `grocery_ecm`.`pharmacy`.`rx_claim` (
    `rx_claim_id` BIGINT COMMENT 'Unique identifier for the pharmacy insurance claim transaction. Primary key for the rx_claim product.',
    `drug_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug. Business justification: RX claim should reference drug master for accurate drug identification.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Adjudicated insurance claims are posted to GL within specific fiscal periods for pharmacy AR reporting, DIR fee accrual, and period-close reconciliation. Grocery pharmacy finance requires claim totals',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Associates each pharmacy claim with the GL account for revenue recognition and claim expense tracking in the general ledger.',
    `insurance_plan_id` BIGINT COMMENT 'Foreign key linking to pharmacy.insurance_plan. Business justification: rx_claim currently stores bin_number, pcn_number, and group_number as raw strings — these are the exact identifiers that uniquely identify an insurance_plan record (insurance_plan has bin, pcn, group_',
    `payer_id` BIGINT COMMENT 'Foreign key linking to pharmacy.payer. Business justification: rx_claim is submitted to a PBM or payer for adjudication. Linking rx_claim directly to the payer master enables payer-level claim analytics, reimbursement rate tracking, and DIR fee reporting. The pay',
    `payment_run_id` BIGINT COMMENT 'Foreign key linking to finance.payment_run. Business justification: Payer ERA (Electronic Remittance Advice) payments for adjudicated pharmacy claims are processed as payment runs in the finance system. Grocery pharmacy revenue cycle management requires linking each c',
    `pharmacy_location_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pharmacy_location. Business justification: rx_claim has pharmacy_npi (STRING) which is a denormalized reference to the dispensing pharmacy location. pharmacy_location has npi as its natural key. Adding pharmacy_location_id FK normalizes this r',
    `prescriber_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prescriber. Business justification: rx_claim has prescriber_npi (STRING) which is a denormalized reference to the prescriber. prescriber has npi as its natural key. Adding prescriber_id FK normalizes this relationship, enabling direct j',
    `prescription_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prescription. Business justification: Each claim originates from a prescription; linking claim to prescription enables traceability of claim amounts to the underlying order.',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prior_authorization. Business justification: rx_claim has a prior_authorization_number (STRING) that denormalizes the PA reference. prior_authorization has pa_number as its natural key. Adding prior_authorization_id FK normalizes this relationsh',
    `rx_patient_id` BIGINT COMMENT 'Unique identifier for the patient receiving the prescription. Links to the pharmacy_patient master entity.',
    `adjudication_timestamp` TIMESTAMP COMMENT 'Date and time when the payer completed adjudication and returned a response (approval or rejection).',
    `amount_reversed` DECIMAL(18,2) COMMENT 'For reversal transactions, the total dollar amount being reversed and credited back to the payer.',
    `cardholder_number` STRING COMMENT 'The insurance cardholder identifier from the patients insurance card used for claim adjudication.',
    `claim_status` STRING COMMENT 'Current lifecycle status of the insurance claim indicating its adjudication state.. Valid values are `submitted|paid|rejected|reversed|pending|adjusted`',
    `cob_indicator` STRING COMMENT 'Indicates whether Coordination of Benefits applies (patient has multiple insurance coverages). Y = COB applies, N = no COB.. Valid values are `Y|N`',
    `compound_indicator` BOOLEAN COMMENT 'Indicates whether the prescription is a compounded medication (custom-prepared by the pharmacy) rather than a manufactured product.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this claim record was first created in the pharmacy system.',
    `daw_code` STRING COMMENT 'NCPDP Dispense as Written code indicating whether a brand-name drug was dispensed and the reason. 0=no product selection indicated, 1=substitution not allowed by prescriber, 2=patient requested brand, etc.. Valid values are `0|1|2|3|4|5`',
    `days_supply` STRING COMMENT 'The number of days the dispensed quantity is expected to last based on the prescribed dosing regimen.',
    `dir_fee_amount` DECIMAL(18,2) COMMENT 'The Direct and Indirect Remuneration fee assessed by the PBM, often applied retroactively and impacting net pharmacy reimbursement.',
    `dispensing_fee` DECIMAL(18,2) COMMENT 'The professional fee charged by the pharmacy for dispensing services, separate from the drug cost.',
    `ingredient_cost` DECIMAL(18,2) COMMENT 'The pharmacys acquisition cost for the drug ingredient, excluding dispensing fees. Used in reimbursement calculations.',
    `mac_pricing_applied` BOOLEAN COMMENT 'Indicates whether Maximum Allowable Cost pricing was applied by the payer during adjudication to limit reimbursement for generic drugs.',
    `patient_pay_amount` DECIMAL(18,2) COMMENT 'The total amount the patient is responsible for paying, including copay, coinsurance, and deductible.',
    `plan_pay_amount` DECIMAL(18,2) COMMENT 'The amount the insurance plan agrees to reimburse the pharmacy after adjudication.',
    `quantity_dispensed` DECIMAL(18,2) COMMENT 'The quantity of medication dispensed to the patient, measured in the drugs unit of measure (tablets, milliliters, etc.).',
    `reject_code` STRING COMMENT 'NCPDP reject code(s) returned when a claim is denied, indicating the specific reason for rejection (e.g., prior authorization required, refill too soon).',
    `response_code` STRING COMMENT 'The NCPDP response code returned by the payer indicating approval, rejection, or other adjudication outcome.',
    `restocking_action` STRING COMMENT 'For reversals, indicates the disposition of the returned medication (restocked to inventory, disposed per regulations, etc.).. Valid values are `restocked|disposed|returned_to_stock|not_restocked`',
    `reversal_reason_code` STRING COMMENT 'For reversal transactions (B2), the code indicating why the original claim is being reversed (e.g., patient returned medication, not picked up, billing error, duplicate claim).',
    `reversal_response_code` STRING COMMENT 'The response code returned by the payer for a reversal transaction, indicating whether the reversal was accepted or rejected.',
    `rx_number` STRING COMMENT 'The prescription number assigned by the pharmacy system for the dispensed medication. Links the claim to the underlying prescription fill.',
    `sales_tax_amount` DECIMAL(18,2) COMMENT 'The sales tax amount applied to the prescription transaction, if applicable per state regulations.',
    `service_date` DATE COMMENT 'The date the prescription was dispensed to the patient. This is the clinical service date for the claim.',
    `submission_clarification_code` STRING COMMENT 'NCPDP code providing additional context about the claim submission (e.g., emergency supply, vacation supply, lost prescription).',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the claim was submitted to the Pharmacy Benefit Manager (PBM) or payer for adjudication.',
    `total_claim_amount` DECIMAL(18,2) COMMENT 'The total submitted claim amount before adjudication, typically ingredient cost plus dispensing fee plus any additional fees.',
    `transaction_type` STRING COMMENT 'NCPDP transaction type code indicating the nature of the claim submission. B1 = original billing, B2 = reversal, B3 = rebill.. Valid values are `B1|B2|B3`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this claim record was last modified, supporting audit trail and data lineage requirements.',
    CONSTRAINT pk_rx_claim PRIMARY KEY(`rx_claim_id`)
) COMMENT 'Transactional record for each pharmacy insurance claim or claim reversal submitted to a PBM or payer for adjudication. Captures transaction type (original billing B1, reversal B2, rebill), claim submission date, NCPDP transaction code, BIN/PCN/group, patient pay amount, plan pay amount, ingredient cost, dispensing fee, adjudication response code, reject codes, COB (Coordination of Benefits) indicator, MAC (Maximum Allowable Cost) pricing applied, and for reversals: reversal reason code (patient returned, not picked up, billing error, duplicate), reversal response, amount reversed, and restocking action. Supports revenue cycle management, DIR (Direct and Indirect Remuneration) fee tracking, and complete claims lifecycle management.';

CREATE OR REPLACE TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` (
    `prior_authorization_id` BIGINT COMMENT 'Unique identifier for the prior authorization request. Primary key.',
    `drug_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug. Business justification: prior_authorization currently stores drug_ndc, drug_name, drug_form, and drug_strength as raw string columns — all of which are attributes of the drug master record (drug has ndc, drug_name, dosage_fo',
    `insurance_plan_id` BIGINT COMMENT 'Foreign key linking to pharmacy.insurance_plan. Business justification: Prior authorizations are submitted under a specific insurance plan; capturing the plan_id creates a clear relationship for reporting and eligibility checks.',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer who will review and approve or deny the prior authorization request.',
    `pharmacy_location_id` BIGINT COMMENT 'Reference to the pharmacy location submitting the prior authorization request.',
    `prescriber_id` BIGINT COMMENT 'Reference to the healthcare provider who prescribed the medication requiring prior authorization.',
    `prescription_id` BIGINT COMMENT 'Reference to the prescription requiring prior authorization.',
    `rx_patient_id` BIGINT COMMENT 'Reference to the patient for whom the prior authorization is requested.',
    `appeal_date` DATE COMMENT 'Date when an appeal was filed for a denied prior authorization request.',
    `appeal_decision_date` DATE COMMENT 'Date when a decision was made on the prior authorization appeal.',
    `appeal_status` STRING COMMENT 'Status of any appeal filed for a denied prior authorization request.. Valid values are `not_appealed|appeal_pending|appeal_approved|appeal_denied`',
    `approved_days_supply` STRING COMMENT 'Number of days supply approved by the payer under the prior authorization.',
    `approved_quantity` DECIMAL(18,2) COMMENT 'Quantity of medication approved by the payer for dispensing under the prior authorization.',
    `approved_quantity_unit` STRING COMMENT 'Unit of measure for the approved quantity (e.g., tablets, milliliters, grams).',
    `approved_refills` STRING COMMENT 'Number of refills approved by the payer under the prior authorization.',
    `clinical_criteria_submitted` STRING COMMENT 'Clinical criteria, rationale, and supporting documentation submitted to justify the prior authorization request.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the prior authorization record was first created in the system.',
    `decision_date` DATE COMMENT 'Date when the payer made a decision on the prior authorization request.',
    `decision_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the payer made a decision on the prior authorization request.',
    `denial_reason_code` STRING COMMENT 'Standardized code indicating the reason for prior authorization denial.',
    `denial_reason_description` STRING COMMENT 'Human-readable description of the reason for prior authorization denial.',
    `diagnosis_code` STRING COMMENT 'ICD-10 diagnosis code justifying the medical necessity for the prescribed medication.. Valid values are `^[A-Z][0-9]{2}(.[0-9]{1,4})?$`',
    `diagnosis_description` STRING COMMENT 'Human-readable description of the diagnosis justifying the prior authorization request.',
    `effective_date` DATE COMMENT 'Date when the approved prior authorization becomes effective and can be used for prescription fills.',
    `expiration_date` DATE COMMENT 'Date when the approved prior authorization expires and can no longer be used for prescription fills.',
    `formulary_exception_flag` BOOLEAN COMMENT 'Indicates whether the prior authorization is for a non-formulary drug requiring an exception.',
    `notes` STRING COMMENT 'Free-text notes and comments related to the prior authorization request, review, and decision.',
    `pa_number` STRING COMMENT 'External prior authorization reference number assigned by the payer or pharmacy system.',
    `pa_status` STRING COMMENT 'Current status of the prior authorization request in its lifecycle. [ENUM-REF-CANDIDATE: pending|approved|denied|cancelled|expired|appealed|under_review — 7 candidates stripped; promote to reference product]',
    `payer_contact_name` STRING COMMENT 'Name of the payer representative who processed the prior authorization request.',
    `payer_contact_phone` STRING COMMENT 'Phone number of the payer representative who processed the prior authorization request.',
    `request_date` DATE COMMENT 'Date when the prior authorization request was submitted to the payer.',
    `request_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the prior authorization request was submitted to the payer.',
    `step_therapy_required_flag` BOOLEAN COMMENT 'Indicates whether the payer requires step therapy (trial of alternative medications) before approving this drug.',
    `submission_method` STRING COMMENT 'Method used to submit the prior authorization request to the payer.. Valid values are `electronic|fax|phone|portal|mail`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the prior authorization record was last updated in the system.',
    `urgency_flag` BOOLEAN COMMENT 'Indicates whether the prior authorization request was marked as urgent or expedited.',
    CONSTRAINT pk_prior_authorization PRIMARY KEY(`prior_authorization_id`)
) COMMENT 'Tracks prior authorization (PA) requests submitted to payers for non-formulary or restricted drugs. Captures PA request date, PA number, drug NDC, diagnosis code (ICD-10), clinical criteria submitted, payer decision (approved, denied, pending), approval effective date, expiration date, approved quantity limit, and appeal status. Integrates with McKesson PA workflow and supports clinical pharmacist review processes.';

CREATE OR REPLACE TABLE `grocery_ecm`.`pharmacy`.`prescriber` (
    `prescriber_id` BIGINT COMMENT 'Unique identifier for the prescriber record. Primary key.',
    `accepts_generic_substitution` BOOLEAN COMMENT 'Indicates whether the prescriber generally accepts generic drug substitutions unless explicitly marked Dispense As Written (DAW).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the prescriber record was first created in the system.',
    `credential` STRING COMMENT 'Primary professional credential or degree of the prescriber (e.g., MD for Medical Doctor, DO for Doctor of Osteopathic Medicine, NP for Nurse Practitioner, PA for Physician Assistant, DDS for Doctor of Dental Surgery). [ENUM-REF-CANDIDATE: MD|DO|NP|PA|DDS|DMD|DPM|OD|PharmD|DVM — 10 candidates stripped; promote to reference product]',
    `dea_number` STRING COMMENT 'DEA registration number assigned to prescribers authorized to prescribe controlled substances. Format: two letters followed by seven digits.. Valid values are `^[A-Z]{2}[0-9]{7}$`',
    `dea_schedule_ii_authorized` BOOLEAN COMMENT 'Indicates whether the prescriber is authorized to prescribe Schedule II controlled substances (high potential for abuse, accepted medical use with severe restrictions).',
    `dea_schedule_iii_authorized` BOOLEAN COMMENT 'Indicates whether the prescriber is authorized to prescribe Schedule III controlled substances (moderate to low potential for physical and psychological dependence).',
    `dea_schedule_iv_authorized` BOOLEAN COMMENT 'Indicates whether the prescriber is authorized to prescribe Schedule IV controlled substances (low potential for abuse and low risk of dependence).',
    `dea_schedule_v_authorized` BOOLEAN COMMENT 'Indicates whether the prescriber is authorized to prescribe Schedule V controlled substances (lower potential for abuse than Schedule IV).',
    `erx_enabled` BOOLEAN COMMENT 'Indicates whether the prescriber is enabled for electronic prescribing (eRx) and can transmit prescriptions electronically to pharmacies.',
    `erx_system_code` STRING COMMENT 'Identifier for the electronic prescribing system or platform used by the prescriber (e.g., Surescripts, DrFirst).',
    `first_name` STRING COMMENT 'Legal first name of the prescriber as registered with licensing authorities.',
    `first_prescription_date` DATE COMMENT 'Date the prescriber wrote their first prescription filled at a Grocery pharmacy.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the prescriber record was last updated.',
    `last_name` STRING COMMENT 'Legal last name (surname) of the prescriber as registered with licensing authorities.',
    `last_prescription_date` DATE COMMENT 'Date the prescriber most recently wrote a prescription filled at a Grocery pharmacy.',
    `license_expiration_date` DATE COMMENT 'Date the state medical license expires and must be renewed.',
    `license_issue_date` DATE COMMENT 'Date the state medical license was originally issued to the prescriber.',
    `license_status` STRING COMMENT 'Current status of the prescribers state medical license.. Valid values are `active|inactive|suspended|revoked|expired|probation`',
    `middle_name` STRING COMMENT 'Middle name or initial of the prescriber.',
    `notes` STRING COMMENT 'Free-text notes about the prescriber, including special instructions, preferences, or relationship management details.',
    `npi` STRING COMMENT 'Ten-digit unique identification number issued by the National Plan and Provider Enumeration System (NPPES) to healthcare providers in the United States. Required for all HIPAA-covered transactions.. Valid values are `^[0-9]{10}$`',
    `practice_address_line1` STRING COMMENT 'Primary street address line of the prescribers practice location.',
    `practice_address_line2` STRING COMMENT 'Secondary address line (suite, floor, building) of the prescribers practice location.',
    `practice_city` STRING COMMENT 'City where the prescribers practice is located.',
    `practice_email` STRING COMMENT 'Email address for the prescribers practice, used for non-PHI communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `practice_fax` STRING COMMENT 'Fax number for the prescribers practice, used for prescription transmission and prior authorization communications.. Valid values are `^[0-9]{10}$`',
    `practice_name` STRING COMMENT 'Name of the medical practice, clinic, hospital, or healthcare organization where the prescriber practices.',
    `practice_phone` STRING COMMENT 'Primary contact phone number for the prescribers practice (10-digit format without formatting).. Valid values are `^[0-9]{10}$`',
    `practice_postal_code` STRING COMMENT 'ZIP code or ZIP+4 code of the prescribers practice location.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `practice_state` STRING COMMENT 'Two-letter state code where the prescribers practice is located.. Valid values are `^[A-Z]{2}$`',
    `preferred_contact_method` STRING COMMENT 'Prescribers preferred method of contact for pharmacy communications (e.g., clarifications, prior authorizations, refill requests).. Valid values are `phone|fax|email|erx`',
    `prescriber_status` STRING COMMENT 'Current operational status of the prescriber in the pharmacy system.. Valid values are `active|inactive|suspended|retired`',
    `relationship_tier` STRING COMMENT 'Classification of the prescribers relationship strength with Grocery pharmacies based on prescription volume and engagement (tier_1 = high volume, tier_2 = medium volume, tier_3 = low volume).. Valid values are `tier_1|tier_2|tier_3|unclassified`',
    `specialty` STRING COMMENT 'Primary medical specialty or practice area of the prescriber (e.g., Family Medicine, Internal Medicine, Cardiology, Pediatrics, Psychiatry, Dentistry).',
    `state_license_number` STRING COMMENT 'State-issued medical license number authorizing the prescriber to practice medicine in the jurisdiction.',
    `state_license_state` STRING COMMENT 'Two-letter state code indicating the jurisdiction that issued the medical license.. Valid values are `^[A-Z]{2}$`',
    `suffix` STRING COMMENT 'Name suffix or professional designation (e.g., Jr, Sr, II, III, MD, DO, NP, PA, DDS). [ENUM-REF-CANDIDATE: Jr|Sr|II|III|IV|MD|DO|PharmD|NP|PA|DDS|DMD — 12 candidates stripped; promote to reference product]',
    `taxonomy_code` STRING COMMENT 'Ten-digit alphanumeric code that classifies the prescribers type, classification, and specialization. Used in HIPAA transactions.. Valid values are `^[0-9]{10}[X]$`',
    CONSTRAINT pk_prescriber PRIMARY KEY(`prescriber_id`)
) COMMENT 'Master record for licensed prescribers (physicians, NPs, PAs, dentists) who write prescriptions filled at Grocery pharmacies. Captures NPI (National Provider Identifier), DEA registration number, DEA schedules authorized, prescriber name, specialty, practice address, state license number, license expiration date, e-prescribing (eRx) capability flag, and preferred contact method. Used for Rx validation, DEA compliance, and prescriber relationship management.';

CREATE OR REPLACE TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` (
    `patient_medication_profile_id` BIGINT COMMENT 'Unique identifier for the patient medication profile record.',
    `pharmacy_location_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pharmacy_location. Business justification: A patients medication profile is managed at a specific pharmacy location — this is the home pharmacy where the patients MedSync, MTM enrollment, and adherence programs are administered. Linking pati',
    `rx_patient_id` BIGINT COMMENT 'Reference to the pharmacy patient for whom this medication profile is maintained.',
    `active_medication_count` STRING COMMENT 'Total number of active medications currently prescribed to the patient.',
    `adherence_risk_level` STRING COMMENT 'Risk classification for medication non-adherence based on PDC scores and fill patterns.. Valid values are `low|moderate|high|critical`',
    `allergy_alerts_count` STRING COMMENT 'Number of documented drug allergies or adverse reactions on file for this patient.',
    `auto_refill_enabled` BOOLEAN COMMENT 'Indicates whether the patient has opted into automatic prescription refill services.',
    `chronic_medication_count` STRING COMMENT 'Number of chronic maintenance medications the patient is taking (e.g., for diabetes, hypertension, cholesterol).',
    `controlled_substance_count` STRING COMMENT 'Number of active controlled substance prescriptions (DEA Schedule II-V) in the patients profile.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the patient medication profile record was first created in the system.',
    `delivery_preference` STRING COMMENT 'Patients preferred method for receiving filled prescriptions.. Valid values are `pickup|home_delivery|mail_order|curbside`',
    `drug_interaction_alerts_count` STRING COMMENT 'Number of active drug-drug interaction alerts flagged in the patients current medication profile.',
    `estimated_annual_fill_count` STRING COMMENT 'Projected number of prescription fills for this patient over a 12-month period, used for pharmacy workflow planning and inventory management.',
    `hipaa_consent_date` DATE COMMENT 'Date when the patient signed the HIPAA authorization form. Null if no consent on file.',
    `hipaa_consent_on_file` BOOLEAN COMMENT 'Indicates whether a signed HIPAA authorization form is on file allowing disclosure of protected health information.',
    `last_adherence_calculation_date` DATE COMMENT 'Date when adherence metrics (PDC, MPR) were last calculated for this patient.',
    `last_fill_date` DATE COMMENT 'Date of the most recent prescription fill for this patient.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified the profile record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the patient medication profile record was last updated.',
    `last_mtm_review_date` DATE COMMENT 'Date of the most recent comprehensive medication review conducted as part of MTM services.',
    `medsync_enrolled` BOOLEAN COMMENT 'Indicates whether the patient is enrolled in the Medication Synchronization program to align all prescription refills to a single monthly pickup date.',
    `medsync_enrollment_date` DATE COMMENT 'Date when the patient enrolled in the MedSync program. Null if never enrolled.',
    `medsync_status` STRING COMMENT 'Current status of the patients MedSync program enrollment.. Valid values are `active|paused|cancelled|pending`',
    `medsync_target_day` STRING COMMENT 'Target day of the month (1-31) when all synchronized medications are scheduled for pickup. Null if not enrolled in MedSync.',
    `mtm_eligible` BOOLEAN COMMENT 'Indicates whether the patient meets eligibility criteria for MTM services based on medication count, chronic conditions, and drug spend.',
    `mtm_enrolled` BOOLEAN COMMENT 'Indicates whether the patient is actively enrolled in MTM services.',
    `mtm_enrollment_date` DATE COMMENT 'Date when the patient enrolled in MTM services. Null if never enrolled.',
    `next_mtm_review_due_date` DATE COMMENT 'Scheduled date for the next comprehensive medication review. Null if not enrolled in MTM.',
    `next_scheduled_fill_date` DATE COMMENT 'Date of the next scheduled prescription refill based on current medication regimen and days supply.',
    `overall_adherence_score` DECIMAL(18,2) COMMENT 'Composite medication adherence score across all chronic medications, calculated as percentage (0.00-100.00).',
    `pdc_cholesterol` DECIMAL(18,2) COMMENT 'Proportion of Days Covered adherence metric for cholesterol medications (statins), calculated as percentage (0.00-100.00). Used for Medicare Part D Star Ratings.',
    `pdc_diabetes` DECIMAL(18,2) COMMENT 'Proportion of Days Covered adherence metric for diabetes medications, calculated as percentage (0.00-100.00). Used for Medicare Part D Star Ratings.',
    `pdc_hypertension` DECIMAL(18,2) COMMENT 'Proportion of Days Covered adherence metric for hypertension medications, calculated as percentage (0.00-100.00). Used for Medicare Part D Star Ratings.',
    `preferred_contact_method` STRING COMMENT 'Patients preferred method for pharmacy communications including refill reminders and adherence outreach.. Valid values are `phone|sms|email|app|mail`',
    `profile_end_date` DATE COMMENT 'Date when the patient medication profile was closed or transferred. Null for active profiles.',
    `profile_notes` STRING COMMENT 'Free-text clinical notes and observations about the patients medication history, adherence patterns, or special handling requirements.',
    `profile_start_date` DATE COMMENT 'Date when the patient medication profile was first established at this pharmacy.',
    `profile_status` STRING COMMENT 'Current lifecycle status of the patient medication profile.. Valid values are `active|inactive|suspended|deceased|transferred`',
    CONSTRAINT pk_patient_medication_profile PRIMARY KEY(`patient_medication_profile_id`)
) COMMENT 'Consolidated medication history and adherence management record for a pharmacy patient, capturing all active and historical medications including Rx fills, OTC medications self-reported, and medication adherence metrics (PDC — Proportion of Days Covered, MPR — Medication Possession Ratio). Tracks therapy start/stop dates, prescriber, indication, and Medication Synchronization (MedSync) program enrollment including sync date (target monthly pickup day), enrolled medications, program status (active, paused, cancelled), assigned pharmacy technician, and estimated annual fill count. Supports MTM (Medication Therapy Management) services, Star Ratings compliance for Medicare Part D, patient retention through adherence programs, and pharmacy workflow planning.';

CREATE OR REPLACE TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` (
    `pharmacy_location_id` BIGINT COMMENT 'Unique identifier for the pharmacy location. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for financial reporting of pharmacy operating expenses per cost center; profit & loss statements allocate pharmacy costs to the appropriate cost center.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Needed for consolidating pharmacy financial results under the correct legal entity for statutory reporting and tax compliance.',
    `planogram_id` BIGINT COMMENT 'Foreign key linking to assortment.planogram. Business justification: Pharmacy aisles use planograms; this FK enables compliance tracking, planogram version control, and automated replenishment for pharmacy shelves.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: Required for Pharmacy Pricing Zone assignment used in daily price calculation reports and regulatory price compliance per location.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Each pharmacy location operates as a distinct profit center for P&L reporting, same-store sales tracking, and segment reporting in grocery retail. pharmacy_location already has cost_center_id but lack',
    `program_config_id` BIGINT COMMENT 'Foreign key linking to loyalty.program_config. Business justification: Pharmacy locations must operate under a specific loyalty program configuration governing pharmacy-specific earn rates, redemption rules, and points multipliers for prescription fills. Grocery pharmacy',
    `store_cluster_id` BIGINT COMMENT 'Foreign key linking to assortment.store_cluster. Business justification: Cluster‑wide assortment planning includes pharmacy sites; linking location to its store cluster supports cluster inventory allocation and space planning reports.',
    `store_location_id` BIGINT COMMENT 'Reference to the parent retail store location where this pharmacy is housed. Links pharmacy to the broader store operations.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier_site. Business justification: LOGISTICS: Map each store to its primary supplier site to optimize delivery routing, lead‑time monitoring, and performance scorecards.',
    `address_line_1` STRING COMMENT 'Primary street address of the pharmacy location. Required for regulatory filings, DEA registration, and state board documentation.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite number, building identifier, or floor. Optional field for additional location detail.',
    `city` STRING COMMENT 'City or municipality where the pharmacy is located. Required for regulatory filings and geographic reporting.',
    `clia_waiver_expiration_date` DATE COMMENT 'Expiration date of the CLIA waiver certificate. CLIA certificates must be renewed every two years. Null if no waiver held.',
    `clia_waiver_number` STRING COMMENT 'CLIA waiver certificate number authorizing the pharmacy to perform point-of-care testing such as flu tests, strep tests, and blood glucose monitoring. Null if no waiver held.',
    `closure_date` DATE COMMENT 'Date when the pharmacy location permanently ceased operations. Null for active pharmacies. Used for historical analysis and patient transfer tracking.',
    `controlled_substance_vault_certified_flag` BOOLEAN COMMENT 'Indicates whether the pharmacy has a DEA-compliant controlled substance storage vault that meets security and access control requirements. True if certified, False otherwise.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the pharmacy location. Determines applicable national regulatory framework.. Valid values are `USA|CAN|MEX`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pharmacy location record was first created in the system. Used for data lineage and audit trail.',
    `dea_registration_expiration_date` DATE COMMENT 'Expiration date of the DEA registration. DEA registrations must be renewed every three years. Critical for compliance tracking and renewal planning.',
    `dea_registration_number` STRING COMMENT 'DEA registration number authorizing the pharmacy to dispense controlled substances. Format: two letters followed by seven digits.. Valid values are `^[A-Z]{2}[0-9]{7}$`',
    `dispensing_system_identifier` STRING COMMENT 'Unique identifier for the pharmacy dispensing system endpoint. Used for McKesson system integration and prescription routing.',
    `drive_through_available_flag` BOOLEAN COMMENT 'Indicates whether this pharmacy location offers drive-through prescription pickup service. True if available, False otherwise.',
    `email_address` STRING COMMENT 'Primary email address for the pharmacy location. Used for business communication, regulatory correspondence, and vendor coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Fax number for receiving prescriptions from prescribers and processing prior authorizations. Critical for HIPAA-compliant prescription transmission.. Valid values are `^+?[0-9]{10,15}$`',
    `immunization_certified_flag` BOOLEAN COMMENT 'Indicates whether this pharmacy location is certified to administer immunizations and vaccinations. True if certified, False otherwise.',
    `last_state_board_inspection_date` DATE COMMENT 'Date of the most recent state board of pharmacy inspection. Used for compliance tracking and inspection readiness planning.',
    `max_prescription_volume_capacity` STRING COMMENT 'Maximum number of prescriptions this pharmacy location can safely process per day based on staffing, equipment, and physical capacity. Used for workload balancing and capacity planning.',
    `mckesson_site_code` STRING COMMENT 'McKesson system site identifier for this pharmacy location. Used for inventory management, ordering, and claims processing integration.',
    `next_state_board_inspection_due_date` DATE COMMENT 'Expected or scheduled date for the next state board of pharmacy inspection. Used for proactive compliance preparation.',
    `npi` STRING COMMENT 'Ten-digit National Provider Identifier assigned by CMS for healthcare billing and identification. Required for pharmacy claims processing.. Valid values are `^[0-9]{10}$`',
    `opening_date` DATE COMMENT 'Date when the pharmacy location first opened for business and began dispensing prescriptions. Used for tenure analysis and historical reporting.',
    `operating_hours_saturday` STRING COMMENT 'Standard operating hours for Saturday. Format: HH:MM-HH:MM. May differ from weekday hours.',
    `operating_hours_sunday` STRING COMMENT 'Standard operating hours for Sunday. Format: HH:MM-HH:MM. May differ from weekday and Saturday hours.',
    `operating_hours_weekday` STRING COMMENT 'Standard operating hours for Monday through Friday. Format: HH:MM-HH:MM (e.g., 09:00-21:00). Used for customer communication and staffing planning.',
    `pharmacist_in_charge_license_number` STRING COMMENT 'State-issued pharmacist license number for the pharmacist-in-charge. Required for state board reporting and inspection documentation.',
    `pharmacist_in_charge_name` STRING COMMENT 'Full name of the licensed pharmacist designated as pharmacist-in-charge responsible for day-to-day operations and regulatory compliance at this location.',
    `pharmacy_director_name` STRING COMMENT 'Full name of the licensed pharmacist designated as the pharmacy director responsible for overall pharmacy operations and regulatory compliance.',
    `pharmacy_director_npi` STRING COMMENT 'National Provider Identifier of the pharmacy director. Required for regulatory filings and compliance documentation.. Valid values are `^[0-9]{10}$`',
    `pharmacy_name` STRING COMMENT 'Business name of the pharmacy location as registered with state authorities and displayed to customers.',
    `pharmacy_number` STRING COMMENT 'Internal business identifier for the pharmacy location used in operational systems and reporting.',
    `pharmacy_status` STRING COMMENT 'Current operational status of the pharmacy location in its lifecycle.. Valid values are `active|inactive|suspended|pending_licensure|closed`',
    `pharmacy_type` STRING COMMENT 'Classification of pharmacy service model and capabilities offered at this location.. Valid values are `full_service|drive_through|24_hour|specialty|compounding|clinical`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the pharmacy location. Used for patient inquiries, prescription transfers, and prescriber communication.. Valid values are `^+?[0-9]{10,15}$`',
    `postal_code` STRING COMMENT 'ZIP code or postal code for the pharmacy location. Used for geographic analysis, network adequacy reporting, and regulatory filings.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `state_board_license_expiration_date` DATE COMMENT 'Expiration date of the state pharmacy license. Renewal frequency varies by state. Critical for operational compliance and inspection readiness.',
    `state_board_license_number` STRING COMMENT 'State-issued pharmacy license number required to operate and dispense prescriptions. Format varies by state jurisdiction.',
    `state_province` STRING COMMENT 'State or province code where the pharmacy is located. Determines applicable state board jurisdiction and regulatory requirements.',
    `twenty_four_hour_flag` BOOLEAN COMMENT 'Indicates whether this pharmacy operates 24 hours per day, 7 days per week. True if 24-hour operation, False otherwise.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this pharmacy location record was last modified. Used for change tracking and data quality monitoring.',
    CONSTRAINT pk_pharmacy_location PRIMARY KEY(`pharmacy_location_id`)
) COMMENT 'Master record for each Grocery pharmacy location capturing pharmacy-specific regulatory credentials and operational configuration distinct from the store domains general location profile. Includes pharmacy NPI, DEA registration number and expiration, State Board of Pharmacy license number and expiration, pharmacy director name and NPI, pharmacist-in-charge designation, operating hours, pharmacy type (full-service, drive-through, 24-hour, specialty), dispensing system identifier (McKesson integration endpoint), CLIA waiver number (for point-of-care testing), controlled substance vault certification status, and maximum prescription volume capacity. Supports DEA registration renewal tracking, State Board inspection readiness, and pharmacy network adequacy reporting.';

CREATE OR REPLACE TABLE `grocery_ecm`.`pharmacy`.`payer` (
    `payer_id` BIGINT COMMENT 'Primary key for payer',
    `parent_payer_id` BIGINT COMMENT 'Self-referencing FK on payer (parent_payer_id)',
    `address_line1` STRING COMMENT 'First line of the payers mailing address.',
    `address_line2` STRING COMMENT 'Second line of the payers mailing address, if applicable.',
    `cap_amount` DECIMAL(18,2) COMMENT 'Maximum total amount payable by the payer per contract period.',
    `city` STRING COMMENT 'City component of the payers address.',
    `claim_submission_method` STRING COMMENT 'Preferred method for submitting claims to the payer.',
    `compliance_status` STRING COMMENT 'Current compliance standing of the payer with regulatory requirements.',
    `contact_email` STRING COMMENT 'Primary email address for payer communications.',
    `contact_phone` STRING COMMENT 'Primary telephone number for payer communications.',
    `contract_number` STRING COMMENT 'Reference number for the contractual agreement with the payer.',
    `country` STRING COMMENT 'Three‑letter ISO country code of the payers primary location.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the payer record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code used for reimbursements.',
    `effective_from` DATE COMMENT 'Date when the payer relationship becomes effective.',
    `effective_until` DATE COMMENT 'Date when the payer relationship ends or is scheduled to terminate; null if open‑ended.',
    `external_payer_code` STRING COMMENT 'Code used by external systems (e.g., clearinghouses) to identify the payer.',
    `is_excluded_from_reporting` BOOLEAN COMMENT 'Indicates whether the payer is excluded from regulatory reporting aggregates.',
    `is_preferred` BOOLEAN COMMENT 'Indicates if this payer is designated as a preferred network for contracts.',
    `last_claim_submission_date` DATE COMMENT 'Date of the most recent claim submitted to this payer.',
    `legal_name` STRING COMMENT 'Full legal name as registered with regulatory bodies.',
    `network_code` STRING COMMENT 'Identifier for the payers network or group affiliation.',
    `npi_number` STRING COMMENT 'NPI assigned to the payer when applicable (e.g., health plan).',
    `payer_description` STRING COMMENT 'Free‑form description or notes about the payer.',
    `payer_name` STRING COMMENT 'Legal name of the payer organization.',
    `payer_status` STRING COMMENT 'Current lifecycle status of the payer record.',
    `payer_type` STRING COMMENT 'Classification of the payer entity.',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the payer.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the payers address.',
    `reimbursement_rate` DECIMAL(18,2) COMMENT 'Standard percentage rate applied to claim amounts for this payer.',
    `short_name` STRING COMMENT 'Abbreviated or commonly used name for the payer.',
    `state` STRING COMMENT 'State or province component of the payers address.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the payer record.',
    CONSTRAINT pk_payer PRIMARY KEY(`payer_id`)
) COMMENT 'Master reference table for payer. Referenced by payer_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ADD CONSTRAINT `fk_pharmacy_rx_patient_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_drug_id` FOREIGN KEY (`drug_id`) REFERENCES `grocery_ecm`.`pharmacy`.`drug`(`drug_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_insurance_plan_id` FOREIGN KEY (`insurance_plan_id`) REFERENCES `grocery_ecm`.`pharmacy`.`insurance_plan`(`insurance_plan_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_prescriber_id` FOREIGN KEY (`prescriber_id`) REFERENCES `grocery_ecm`.`pharmacy`.`prescriber`(`prescriber_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_rx_patient_id` FOREIGN KEY (`rx_patient_id`) REFERENCES `grocery_ecm`.`pharmacy`.`rx_patient`(`rx_patient_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ADD CONSTRAINT `fk_pharmacy_rx_fill_drug_id` FOREIGN KEY (`drug_id`) REFERENCES `grocery_ecm`.`pharmacy`.`drug`(`drug_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ADD CONSTRAINT `fk_pharmacy_rx_fill_insurance_plan_id` FOREIGN KEY (`insurance_plan_id`) REFERENCES `grocery_ecm`.`pharmacy`.`insurance_plan`(`insurance_plan_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ADD CONSTRAINT `fk_pharmacy_rx_fill_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ADD CONSTRAINT `fk_pharmacy_rx_fill_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `grocery_ecm`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ADD CONSTRAINT `fk_pharmacy_rx_fill_rx_patient_id` FOREIGN KEY (`rx_patient_id`) REFERENCES `grocery_ecm`.`pharmacy`.`rx_patient`(`rx_patient_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ADD CONSTRAINT `fk_pharmacy_drug_inventory_drug_id` FOREIGN KEY (`drug_id`) REFERENCES `grocery_ecm`.`pharmacy`.`drug`(`drug_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ADD CONSTRAINT `fk_pharmacy_drug_inventory_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ADD CONSTRAINT `fk_pharmacy_insurance_plan_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `grocery_ecm`.`pharmacy`.`payer`(`payer_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_drug_id` FOREIGN KEY (`drug_id`) REFERENCES `grocery_ecm`.`pharmacy`.`drug`(`drug_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_insurance_plan_id` FOREIGN KEY (`insurance_plan_id`) REFERENCES `grocery_ecm`.`pharmacy`.`insurance_plan`(`insurance_plan_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `grocery_ecm`.`pharmacy`.`payer`(`payer_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_prescriber_id` FOREIGN KEY (`prescriber_id`) REFERENCES `grocery_ecm`.`pharmacy`.`prescriber`(`prescriber_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `grocery_ecm`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `grocery_ecm`.`pharmacy`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_rx_patient_id` FOREIGN KEY (`rx_patient_id`) REFERENCES `grocery_ecm`.`pharmacy`.`rx_patient`(`rx_patient_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_drug_id` FOREIGN KEY (`drug_id`) REFERENCES `grocery_ecm`.`pharmacy`.`drug`(`drug_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_insurance_plan_id` FOREIGN KEY (`insurance_plan_id`) REFERENCES `grocery_ecm`.`pharmacy`.`insurance_plan`(`insurance_plan_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `grocery_ecm`.`pharmacy`.`payer`(`payer_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_prescriber_id` FOREIGN KEY (`prescriber_id`) REFERENCES `grocery_ecm`.`pharmacy`.`prescriber`(`prescriber_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `grocery_ecm`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_rx_patient_id` FOREIGN KEY (`rx_patient_id`) REFERENCES `grocery_ecm`.`pharmacy`.`rx_patient`(`rx_patient_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ADD CONSTRAINT `fk_pharmacy_patient_medication_profile_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `grocery_ecm`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ADD CONSTRAINT `fk_pharmacy_patient_medication_profile_rx_patient_id` FOREIGN KEY (`rx_patient_id`) REFERENCES `grocery_ecm`.`pharmacy`.`rx_patient`(`rx_patient_id`);
ALTER TABLE `grocery_ecm`.`pharmacy`.`payer` ADD CONSTRAINT `fk_pharmacy_payer_parent_payer_id` FOREIGN KEY (`parent_payer_id`) REFERENCES `grocery_ecm`.`pharmacy`.`payer`(`payer_id`);

-- ========= TAGS =========
ALTER SCHEMA `grocery_ecm`.`pharmacy` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `grocery_ecm`.`pharmacy` SET TAGS ('dbx_domain' = 'pharmacy');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` SET TAGS ('dbx_subdomain' = 'patient_management');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `rx_patient_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription (Rx) Patient ID');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Pharmacy Store ID');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Patient Address Line 1');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Patient Address Line 2');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `alternate_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Patient Alternate Phone Number');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `alternate_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `alternate_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `auto_refill_enrollment_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Refill Enrollment Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Patient City');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `counseling_preference` SET TAGS ('dbx_business_glossary_term' = 'Patient Counseling Preference');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `counseling_preference` SET TAGS ('dbx_value_regex' = 'in_person|phone|written|declined');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Patient Country Code');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Patient Date of Birth');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Patient Email Address');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `email_notification_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Email Notification Consent Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `email_notification_consent_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `email_notification_consent_flag` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Patient First Name');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Patient Gender');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown|declined');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `gender` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `gender` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `hipaa_authorization_date` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Authorization Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `hipaa_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Authorization Status');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `hipaa_authorization_status` SET TAGS ('dbx_value_regex' = 'authorized|not_authorized|pending|revoked');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Patient Last Name');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `last_prescription_fill_date` SET TAGS ('dbx_business_glossary_term' = 'Last Prescription Fill Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `last_prescription_fill_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `last_prescription_fill_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `medication_history_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Medication History Consent Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `medication_history_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Medication History Consent Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Patient Middle Name');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `patient_status` SET TAGS ('dbx_business_glossary_term' = 'Patient Status');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `patient_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deceased|transferred');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Patient Phone Number');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Patient Postal Code');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Patient Preferred Language');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `primary_care_physician_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) Name');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `primary_care_physician_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `primary_care_physician_name` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `primary_care_physician_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) Phone Number');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `primary_care_physician_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `primary_care_physician_phone` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `primary_insurance_bin` SET TAGS ('dbx_business_glossary_term' = 'Primary Insurance Bank Identification Number (BIN)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `primary_insurance_bin` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `primary_insurance_carrier` SET TAGS ('dbx_business_glossary_term' = 'Primary Insurance Carrier Name');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `primary_insurance_carrier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `primary_insurance_carrier` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `primary_insurance_group_number` SET TAGS ('dbx_business_glossary_term' = 'Primary Insurance Group Number');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `primary_insurance_group_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `primary_insurance_group_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `primary_insurance_member_number` SET TAGS ('dbx_business_glossary_term' = 'Primary Insurance Member ID');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `primary_insurance_member_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `primary_insurance_member_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `primary_insurance_pcn` SET TAGS ('dbx_business_glossary_term' = 'Primary Insurance Processor Control Number (PCN)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Patient Registration Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Patient State or Province');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `text_notification_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Text Notification Consent Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_patient` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` SET TAGS ('dbx_subdomain' = 'patient_management');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription ID');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `drug_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `insurance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Plan Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Store ID');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prescriber_id` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `rx_patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `compound_prescription` SET TAGS ('dbx_business_glossary_term' = 'Compound Prescription Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `compound_prescription` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `compound_prescription` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Schedule');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_value_regex' = 'schedule_ii|schedule_iii|schedule_iv|schedule_v|non_controlled');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `daw_code` SET TAGS ('dbx_business_glossary_term' = 'Dispense As Written (DAW) Code');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `days_supply` SET TAGS ('dbx_business_glossary_term' = 'Days Supply');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Code (ICD-10)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}(.[0-9]{1,4})?$');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Prescription Expiration Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `generic_available` SET TAGS ('dbx_business_glossary_term' = 'Generic Available Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Prescription Issue Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Prescription Notes');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `origin` SET TAGS ('dbx_business_glossary_term' = 'Prescription Origin');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `origin` SET TAGS ('dbx_value_regex' = 'written|electronic|phone|fax|transfer_in');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `pharmacist_verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pharmacist Verification Timestamp');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `pharmacist_verified_by` SET TAGS ('dbx_business_glossary_term' = 'Pharmacist Verified By');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prescription_status` SET TAGS ('dbx_business_glossary_term' = 'Prescription Status');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prescription_status` SET TAGS ('dbx_value_regex' = 'active|filled|expired|cancelled|transferred_out|discontinued');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prescription_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prescription_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prior_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `quantity_prescribed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Prescribed');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `refills_authorized` SET TAGS ('dbx_business_glossary_term' = 'Refills Authorized');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `refills_remaining` SET TAGS ('dbx_business_glossary_term' = 'Refills Remaining');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `rx_number` SET TAGS ('dbx_business_glossary_term' = 'Prescription (Rx) Number');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `rx_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{7,15}$');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `sig` SET TAGS ('dbx_business_glossary_term' = 'Sig (Directions for Use)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `therapeutic_class` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Class');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `transfer_destination_pharmacy` SET TAGS ('dbx_business_glossary_term' = 'Transfer Destination Pharmacy');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescription` ALTER COLUMN `transfer_source_pharmacy` SET TAGS ('dbx_business_glossary_term' = 'Transfer Source Pharmacy');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` SET TAGS ('dbx_subdomain' = 'dispensing_operations');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `rx_fill_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription (Rx) Fill ID');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `drug_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `insurance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Plan Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Store ID');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `price_override_id` SET TAGS ('dbx_business_glossary_term' = 'Price Override Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `promotion_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Redemption Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `rx_order_id` SET TAGS ('dbx_business_glossary_term' = 'Rx Order Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `rx_patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `adjudication_result` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Result');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `adjudication_result` SET TAGS ('dbx_value_regex' = 'paid|rejected|reversed|pending');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Schedule');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_value_regex' = 'schedule_2|schedule_3|schedule_4|schedule_5|non_controlled');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Copay Amount');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `counseling_accepted_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Counseling Accepted Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `counseling_method` SET TAGS ('dbx_business_glossary_term' = 'Counseling Method');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `counseling_method` SET TAGS ('dbx_value_regex' = 'in_person|phone|written|video|declined');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `counseling_offered_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Counseling Offered Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `counseling_topics_covered` SET TAGS ('dbx_business_glossary_term' = 'Counseling Topics Covered');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `days_supply` SET TAGS ('dbx_business_glossary_term' = 'Days Supply');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `dea_form_222_number` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Form 222 Number');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `dispensed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Dispensed Quantity');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `dispensing_pharmacist_npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI) - Dispensing Pharmacist');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `dispensing_pharmacist_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `dur_allergy_conflict_alert` SET TAGS ('dbx_business_glossary_term' = 'Drug Utilization Review (DUR) Allergy Conflict Alert');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `dur_drug_interaction_alert` SET TAGS ('dbx_business_glossary_term' = 'Drug Utilization Review (DUR) Drug-Drug Interaction Alert');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `dur_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Drug Utilization Review (DUR) Override Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `dur_override_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Drug Utilization Review (DUR) Override Reason Code');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `dur_screening_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Drug Utilization Review (DUR) Screening Performed Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `dur_therapeutic_duplication_alert` SET TAGS ('dbx_business_glossary_term' = 'Drug Utilization Review (DUR) Therapeutic Duplication Alert');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `fill_date` SET TAGS ('dbx_business_glossary_term' = 'Fill Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `fill_number` SET TAGS ('dbx_business_glossary_term' = 'Fill Number');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `fill_status` SET TAGS ('dbx_business_glossary_term' = 'Fill Status');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `fill_status` SET TAGS ('dbx_value_regex' = 'filled|partial|on_hold|cancelled|transferred_out|transferred_in');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `fill_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fill Timestamp');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `insurance_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Paid Amount');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `label_printed_flag` SET TAGS ('dbx_business_glossary_term' = 'Label Printed Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `patient_pickup_confirmed_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Pickup Confirmed Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `pickup_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pickup Timestamp');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `rejection_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Code');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `rems_acknowledgment_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Evaluation and Mitigation Strategy (REMS) Acknowledgment Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `rx_number` SET TAGS ('dbx_business_glossary_term' = 'Prescription (Rx) Number');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `rx_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{7,15}$');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `total_price` SET TAGS ('dbx_business_glossary_term' = 'Total Price');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `transfer_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `transfer_pharmacy_ncpdp` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pharmacy National Council for Prescription Drug Programs (NCPDP) Number');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `transfer_pharmacy_ncpdp` SET TAGS ('dbx_value_regex' = '^[0-9]{7}$');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Type');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `transfer_type` SET TAGS ('dbx_value_regex' = 'none|transferred_in|transferred_out');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `will_call_bin_assignment` SET TAGS ('dbx_business_glossary_term' = 'Will-Call Bin Assignment');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_fill` ALTER COLUMN `will_call_bin_assignment` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` SET TAGS ('dbx_subdomain' = 'dispensing_operations');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `drug_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Identifier');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `compliance_record_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Record Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `vendor_item_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `awp` SET TAGS ('dbx_business_glossary_term' = 'Average Wholesale Price (AWP)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `awp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `black_box_warning_indicator` SET TAGS ('dbx_business_glossary_term' = 'Black Box Warning Indicator');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Schedule');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_value_regex' = 'schedule_ii|schedule_iii|schedule_iv|schedule_v|unscheduled');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `desi_status` SET TAGS ('dbx_business_glossary_term' = 'Drug Efficacy Study Implementation (DESI) Status');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `desi_status` SET TAGS ('dbx_value_regex' = 'effective|less_than_effective|not_reviewed');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `dosage_form` SET TAGS ('dbx_business_glossary_term' = 'Dosage Form');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `drug_name` SET TAGS ('dbx_business_glossary_term' = 'Drug Name');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `drug_status` SET TAGS ('dbx_business_glossary_term' = 'Drug Status');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `drug_status` SET TAGS ('dbx_value_regex' = 'active|discontinued|recalled|on_backorder|obsolete');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `drug_type` SET TAGS ('dbx_business_glossary_term' = 'Drug Type');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `drug_type` SET TAGS ('dbx_value_regex' = 'prescription|otc|compound');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `formulary_status` SET TAGS ('dbx_business_glossary_term' = 'Formulary Status');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `formulary_status` SET TAGS ('dbx_value_regex' = 'preferred|non_preferred|excluded|prior_authorization_required');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `generic_name` SET TAGS ('dbx_business_glossary_term' = 'Generic Name');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `gpi` SET TAGS ('dbx_business_glossary_term' = 'Generic Product Identifier (GPI)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `gpi` SET TAGS ('dbx_value_regex' = '^[0-9]{14}$');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `hazardous_drug_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Drug Indicator');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `multi_source_indicator` SET TAGS ('dbx_business_glossary_term' = 'Multi-Source Indicator');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `multi_source_indicator` SET TAGS ('dbx_value_regex' = 'brand|generic|single_source');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `ndc` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `ndc` SET TAGS ('dbx_value_regex' = '^[0-9]{5}-[0-9]{4}-[0-9]{2}$|^[0-9]{5}-[0-9]{3}-[0-9]{2}$|^[0-9]{4}-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `orange_book_code` SET TAGS ('dbx_business_glossary_term' = 'Orange Book Therapeutic Equivalence Code');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `package_size` SET TAGS ('dbx_business_glossary_term' = 'Package Size');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `refrigeration_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'Refrigeration Required Indicator');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `rems_indicator` SET TAGS ('dbx_business_glossary_term' = 'Risk Evaluation and Mitigation Strategy (REMS) Indicator');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `repackaged_indicator` SET TAGS ('dbx_business_glossary_term' = 'Repackaged Indicator');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `route_of_administration` SET TAGS ('dbx_business_glossary_term' = 'Route of Administration');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `route_of_administration` SET TAGS ('dbx_value_regex' = 'oral|topical|intravenous|intramuscular|subcutaneous|inhalation');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `storage_requirements` SET TAGS ('dbx_business_glossary_term' = 'Storage Requirements');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `storage_requirements` SET TAGS ('dbx_value_regex' = 'room_temperature|refrigerated|frozen|controlled_room_temperature');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `strength` SET TAGS ('dbx_business_glossary_term' = 'Drug Strength');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `tall_man_lettering` SET TAGS ('dbx_business_glossary_term' = 'Tall Man Lettering');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `therapeutic_class` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Class');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'each|bottle|vial|tube|box|package');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `wac` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Acquisition Cost (WAC)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug` ALTER COLUMN `wac` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` SET TAGS ('dbx_subdomain' = 'dispensing_operations');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `drug_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Inventory ID');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `cost_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Schedule Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `drug_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `fixture_id` SET TAGS ('dbx_business_glossary_term' = 'Fixture Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Location ID');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Schedule');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_value_regex' = 'SCHEDULE_I|SCHEDULE_II|SCHEDULE_III|SCHEDULE_IV|SCHEDULE_V|NON_CONTROLLED');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `dea_biennial_count_flag` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Biennial Count Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `fifo_rotation_status` SET TAGS ('dbx_business_glossary_term' = 'First In First Out (FIFO) Rotation Status');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `fifo_rotation_status` SET TAGS ('dbx_value_regex' = 'CURRENT|NEAR_EXPIRY|EXPIRED|RECALLED');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'AVAILABLE|ALLOCATED|QUARANTINED|EXPIRED|RECALLED|DISPOSED');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `inventory_value` SET TAGS ('dbx_business_glossary_term' = 'Inventory Value');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `inventory_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `last_adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Adjustment Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `last_dispense_date` SET TAGS ('dbx_business_glossary_term' = 'Last Dispense Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `last_physical_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Count Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `last_physical_count_quantity` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Count Quantity');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `last_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Last Receipt Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `on_hand_quantity` SET TAGS ('dbx_business_glossary_term' = 'On-Hand Quantity');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `par_level` SET TAGS ('dbx_business_glossary_term' = 'Par Level');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `perpetual_adjustment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Perpetual Adjustment Quantity');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `recall_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `recall_status` SET TAGS ('dbx_business_glossary_term' = 'Recall Status');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `recall_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|RECALLED|QUARANTINED|CLEARED');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `refrigeration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Refrigeration Required Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `reorder_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Quantity');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `shrink_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shrink Quantity');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `vault_storage_flag` SET TAGS ('dbx_business_glossary_term' = 'Vault Storage Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`drug_inventory` ALTER COLUMN `will_call_bin_flag` SET TAGS ('dbx_business_glossary_term' = 'Will-Call Bin Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` SET TAGS ('dbx_subdomain' = 'claims_adjudication');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `insurance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Plan ID');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `bin` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `bin` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Percentage');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `deductible_applies` SET TAGS ('dbx_business_glossary_term' = 'Deductible Applies');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `eligible_ndc_list` SET TAGS ('dbx_business_glossary_term' = 'Eligible National Drug Code (NDC) List');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `formulary_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Formulary Effective Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `formulary_version` SET TAGS ('dbx_business_glossary_term' = 'Formulary Version');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `group_number` SET TAGS ('dbx_business_glossary_term' = 'Group Number');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `hipaa_compliant` SET TAGS ('dbx_business_glossary_term' = 'HIPAA (Health Insurance Portability and Accountability Act) Compliant');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `mail_order_available` SET TAGS ('dbx_business_glossary_term' = 'Mail Order Available');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `max_benefit_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Benefit Amount');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `medicaid_plan_number` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Plan ID');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `medicare_part_d_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Medicare Part D Contract ID');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `network_participation_status` SET TAGS ('dbx_business_glossary_term' = 'Network Participation Status');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `network_participation_status` SET TAGS ('dbx_value_regex' = 'in_network|out_of_network|preferred_network|limited_network|not_applicable');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `out_of_pocket_max_amount` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Pocket Maximum Amount');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `pcn` SET TAGS ('dbx_business_glossary_term' = 'Processor Control Number (PCN)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `per_fill_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Per Fill Cap Amount');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `plan_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_activation');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `plan_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Termination Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'commercial|medicare_part_d|medicaid|tricare|manufacturer_coupon|patient_assistance_program');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `program_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Program Expiration Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `quantity_limit_enforced` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit Enforced');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `specialty_pharmacy_required` SET TAGS ('dbx_business_glossary_term' = 'Specialty Pharmacy Required');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Required');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `tier_1_copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Tier 1 Copay Amount');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `tier_2_copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Tier 2 Copay Amount');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `tier_3_copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Tier 3 Copay Amount');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `tier_4_copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Tier 4 Copay Amount');
ALTER TABLE `grocery_ecm`.`pharmacy`.`insurance_plan` ALTER COLUMN `tier_5_copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Tier 5 Copay Amount');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` SET TAGS ('dbx_subdomain' = 'claims_adjudication');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `rx_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription (Rx) Claim ID');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `drug_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `insurance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Plan Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `prescriber_id` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `rx_patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `adjudication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Timestamp');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `amount_reversed` SET TAGS ('dbx_business_glossary_term' = 'Amount Reversed');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `cardholder_number` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `cardholder_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `cardholder_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_value_regex' = 'submitted|paid|rejected|reversed|pending|adjusted');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `cob_indicator` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Indicator');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `cob_indicator` SET TAGS ('dbx_value_regex' = 'Y|N');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `compound_indicator` SET TAGS ('dbx_business_glossary_term' = 'Compound Medication Indicator');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `daw_code` SET TAGS ('dbx_business_glossary_term' = 'Dispense as Written (DAW) Code');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `daw_code` SET TAGS ('dbx_value_regex' = '0|1|2|3|4|5');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `days_supply` SET TAGS ('dbx_business_glossary_term' = 'Days Supply');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `dir_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Direct and Indirect Remuneration (DIR) Fee Amount');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `dispensing_fee` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Fee');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `ingredient_cost` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Cost');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `mac_pricing_applied` SET TAGS ('dbx_business_glossary_term' = 'Maximum Allowable Cost (MAC) Pricing Applied');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `patient_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Patient Pay Amount');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `plan_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Plan Pay Amount');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `quantity_dispensed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Dispensed');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `reject_code` SET TAGS ('dbx_business_glossary_term' = 'Reject Code');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `response_code` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Response Code');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `restocking_action` SET TAGS ('dbx_business_glossary_term' = 'Restocking Action');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `restocking_action` SET TAGS ('dbx_value_regex' = 'restocked|disposed|returned_to_stock|not_restocked');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `reversal_response_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Response Code');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `rx_number` SET TAGS ('dbx_business_glossary_term' = 'Prescription (Rx) Number');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `sales_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Sales Tax Amount');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Date of Service');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `submission_clarification_code` SET TAGS ('dbx_business_glossary_term' = 'Submission Clarification Code');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Claim Submission Timestamp');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `total_claim_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Claim Amount');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Code');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'B1|B2|B3');
ALTER TABLE `grocery_ecm`.`pharmacy`.`rx_claim` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` SET TAGS ('dbx_subdomain' = 'claims_adjudication');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) ID');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `drug_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `insurance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Plan Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Location ID');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `prescriber_id` SET TAGS ('dbx_business_glossary_term' = 'Prescriber ID');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription (Rx) ID');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `rx_patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `appeal_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `appeal_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'not_appealed|appeal_pending|appeal_approved|appeal_denied');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `approved_days_supply` SET TAGS ('dbx_business_glossary_term' = 'Approved Days Supply');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `approved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Approved Quantity');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `approved_quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Approved Quantity Unit of Measure');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `approved_refills` SET TAGS ('dbx_business_glossary_term' = 'Approved Refills');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `clinical_criteria_submitted` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Submitted');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `clinical_criteria_submitted` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decision Timestamp');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases 10th Revision (ICD-10) Diagnosis Code');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}(.[0-9]{1,4})?$');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Description');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `formulary_exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Formulary Exception Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `pa_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Number');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `pa_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Status');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `payer_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Payer Contact Name');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `payer_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `payer_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `payer_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Payer Contact Phone Number');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `payer_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `payer_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `step_therapy_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Required Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'electronic|fax|phone|portal|mail');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prior_authorization` ALTER COLUMN `urgency_flag` SET TAGS ('dbx_business_glossary_term' = 'Urgency Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` SET TAGS ('dbx_subdomain' = 'patient_management');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `prescriber_id` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Identifier');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `accepts_generic_substitution` SET TAGS ('dbx_business_glossary_term' = 'Accepts Generic Substitution Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `credential` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Professional Credential');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `dea_number` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Registration Number');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `dea_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{7}$');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `dea_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `dea_schedule_ii_authorized` SET TAGS ('dbx_business_glossary_term' = 'DEA Schedule II Authorization Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `dea_schedule_iii_authorized` SET TAGS ('dbx_business_glossary_term' = 'DEA Schedule III Authorization Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `dea_schedule_iv_authorized` SET TAGS ('dbx_business_glossary_term' = 'DEA Schedule IV Authorization Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `dea_schedule_v_authorized` SET TAGS ('dbx_business_glossary_term' = 'DEA Schedule V Authorization Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `erx_enabled` SET TAGS ('dbx_business_glossary_term' = 'Electronic Prescribing (eRx) Enabled Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `erx_system_code` SET TAGS ('dbx_business_glossary_term' = 'Electronic Prescribing System Identifier');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Prescriber First Name');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `first_prescription_date` SET TAGS ('dbx_business_glossary_term' = 'First Prescription Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `first_prescription_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `first_prescription_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Last Name');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `last_prescription_date` SET TAGS ('dbx_business_glossary_term' = 'Last Prescription Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `last_prescription_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `last_prescription_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `license_issue_date` SET TAGS ('dbx_business_glossary_term' = 'License Issue Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `license_status` SET TAGS ('dbx_business_glossary_term' = 'License Status');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `license_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|revoked|expired|probation');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Middle Name');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Notes');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `practice_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Practice Address Line 1');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `practice_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `practice_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `practice_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Practice Address Line 2');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `practice_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `practice_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `practice_city` SET TAGS ('dbx_business_glossary_term' = 'Practice City');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `practice_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `practice_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `practice_email` SET TAGS ('dbx_business_glossary_term' = 'Practice Email Address');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `practice_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `practice_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `practice_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `practice_fax` SET TAGS ('dbx_business_glossary_term' = 'Practice Fax Number');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `practice_fax` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `practice_fax` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `practice_fax` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `practice_name` SET TAGS ('dbx_business_glossary_term' = 'Practice or Organization Name');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `practice_phone` SET TAGS ('dbx_business_glossary_term' = 'Practice Phone Number');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `practice_phone` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `practice_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `practice_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `practice_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Practice Postal Code');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `practice_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `practice_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `practice_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `practice_state` SET TAGS ('dbx_business_glossary_term' = 'Practice State');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `practice_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'phone|fax|email|erx');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `prescriber_status` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Status');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `prescriber_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|retired');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `relationship_tier` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Relationship Tier');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `relationship_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|unclassified');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `specialty` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Medical Specialty');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `state_license_number` SET TAGS ('dbx_business_glossary_term' = 'State Medical License Number');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `state_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `state_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `state_license_state` SET TAGS ('dbx_business_glossary_term' = 'State License Jurisdiction');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `state_license_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `suffix` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Name Suffix');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `taxonomy_code` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Provider Taxonomy Code');
ALTER TABLE `grocery_ecm`.`pharmacy`.`prescriber` ALTER COLUMN `taxonomy_code` SET TAGS ('dbx_value_regex' = '^[0-9]{10}[X]$');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` SET TAGS ('dbx_subdomain' = 'patient_management');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `patient_medication_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Medication Profile ID');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `rx_patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `active_medication_count` SET TAGS ('dbx_business_glossary_term' = 'Active Medication Count');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `adherence_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Adherence Risk Level');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `adherence_risk_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `allergy_alerts_count` SET TAGS ('dbx_business_glossary_term' = 'Allergy Alerts Count');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `auto_refill_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto Refill Enabled');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `chronic_medication_count` SET TAGS ('dbx_business_glossary_term' = 'Chronic Medication Count');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `controlled_substance_count` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Count');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `delivery_preference` SET TAGS ('dbx_business_glossary_term' = 'Delivery Preference');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `delivery_preference` SET TAGS ('dbx_value_regex' = 'pickup|home_delivery|mail_order|curbside');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `drug_interaction_alerts_count` SET TAGS ('dbx_business_glossary_term' = 'Drug Interaction Alerts Count');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `estimated_annual_fill_count` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Fill Count');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `hipaa_consent_date` SET TAGS ('dbx_business_glossary_term' = 'HIPAA (Health Insurance Portability and Accountability Act) Consent Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `hipaa_consent_on_file` SET TAGS ('dbx_business_glossary_term' = 'HIPAA (Health Insurance Portability and Accountability Act) Consent On File');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `last_adherence_calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Adherence Calculation Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `last_fill_date` SET TAGS ('dbx_business_glossary_term' = 'Last Fill Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `last_mtm_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Medication Therapy Management (MTM) Review Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `medsync_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Medication Synchronization (MedSync) Enrolled');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `medsync_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Medication Synchronization (MedSync) Enrollment Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `medsync_status` SET TAGS ('dbx_business_glossary_term' = 'Medication Synchronization (MedSync) Status');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `medsync_status` SET TAGS ('dbx_value_regex' = 'active|paused|cancelled|pending');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `medsync_target_day` SET TAGS ('dbx_business_glossary_term' = 'Medication Synchronization (MedSync) Target Day');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `mtm_eligible` SET TAGS ('dbx_business_glossary_term' = 'Medication Therapy Management (MTM) Eligible');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `mtm_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Medication Therapy Management (MTM) Enrolled');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `mtm_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Medication Therapy Management (MTM) Enrollment Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `next_mtm_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Medication Therapy Management (MTM) Review Due Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `next_scheduled_fill_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Fill Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `overall_adherence_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Adherence Score');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `pdc_cholesterol` SET TAGS ('dbx_business_glossary_term' = 'Proportion of Days Covered (PDC) Cholesterol');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `pdc_diabetes` SET TAGS ('dbx_business_glossary_term' = 'Proportion of Days Covered (PDC) Diabetes');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `pdc_hypertension` SET TAGS ('dbx_business_glossary_term' = 'Proportion of Days Covered (PDC) Hypertension');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'phone|sms|email|app|mail');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `profile_end_date` SET TAGS ('dbx_business_glossary_term' = 'Profile End Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `profile_notes` SET TAGS ('dbx_business_glossary_term' = 'Profile Notes');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `profile_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `profile_start_date` SET TAGS ('dbx_business_glossary_term' = 'Profile Start Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Profile Status');
ALTER TABLE `grocery_ecm`.`pharmacy`.`patient_medication_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|deceased|transferred');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` SET TAGS ('dbx_subdomain' = 'dispensing_operations');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Location ID');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `planogram_id` SET TAGS ('dbx_business_glossary_term' = 'Planogram Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `program_config_id` SET TAGS ('dbx_business_glossary_term' = 'Program Config Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `store_cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `clia_waiver_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'CLIA Waiver Expiration Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `clia_waiver_number` SET TAGS ('dbx_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Waiver Number');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Closure Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `controlled_substance_vault_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Vault Certified Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `dea_registration_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'DEA Registration Expiration Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `dea_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Registration Number');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `dea_registration_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{7}$');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `dea_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `dispensing_system_identifier` SET TAGS ('dbx_business_glossary_term' = 'Dispensing System Identifier');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `drive_through_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Drive-Through Available Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Email Address');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Fax Number');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `fax_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `immunization_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Immunization Certified Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `last_state_board_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last State Board Inspection Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `max_prescription_volume_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Prescription Volume Capacity');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `max_prescription_volume_capacity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `max_prescription_volume_capacity` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `mckesson_site_code` SET TAGS ('dbx_business_glossary_term' = 'McKesson Site ID');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `next_state_board_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next State Board Inspection Due Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Opening Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `operating_hours_saturday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Saturday');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `operating_hours_sunday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Sunday');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `operating_hours_weekday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Weekday');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `pharmacist_in_charge_license_number` SET TAGS ('dbx_business_glossary_term' = 'Pharmacist-in-Charge (PIC) License Number');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `pharmacist_in_charge_name` SET TAGS ('dbx_business_glossary_term' = 'Pharmacist-in-Charge (PIC) Name');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `pharmacist_in_charge_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `pharmacy_director_name` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Director Name');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `pharmacy_director_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `pharmacy_director_npi` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Director National Provider Identifier (NPI)');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `pharmacy_director_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `pharmacy_name` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Name');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `pharmacy_number` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Number');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `pharmacy_status` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Status');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `pharmacy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_licensure|closed');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `pharmacy_type` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Type');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `pharmacy_type` SET TAGS ('dbx_value_regex' = 'full_service|drive_through|24_hour|specialty|compounding|clinical');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Phone Number');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `state_board_license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'State Board License Expiration Date');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `state_board_license_number` SET TAGS ('dbx_business_glossary_term' = 'State Board of Pharmacy License Number');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `twenty_four_hour_flag` SET TAGS ('dbx_business_glossary_term' = '24-Hour Operation Flag');
ALTER TABLE `grocery_ecm`.`pharmacy`.`pharmacy_location` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`pharmacy`.`payer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`pharmacy`.`payer` SET TAGS ('dbx_subdomain' = 'claims_adjudication');
ALTER TABLE `grocery_ecm`.`pharmacy`.`payer` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Identifier');
ALTER TABLE `grocery_ecm`.`pharmacy`.`payer` ALTER COLUMN `parent_payer_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`payer` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`payer` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`payer` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`payer` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`payer` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`payer` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`payer` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`payer` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`payer` ALTER COLUMN `npi_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`payer` ALTER COLUMN `npi_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`payer` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`pharmacy`.`payer` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
